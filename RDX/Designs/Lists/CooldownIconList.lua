-- CooldownIcons.lua
-- OpenRDX
-- sigg / rashgarroth
--

local ShowCooldownTooltip = RDXCD.ShowCooldownTooltip;

function __CooldownIconOnEnter(self)
	if self.spellid then ShowCooldownTooltip(self.spellid, self, "RIGHT"); end
end
function __CooldownIconOnLeave()
	GameTooltip:Hide();
end

--------------- Code emitter helpers
local function _EmitCreateCode(objname, desc)
	local driver = desc.driver or 2;
	local ebs = desc.externalButtonSkin or "bs_default";
	local showgloss = "nil"; if desc.showgloss then showgloss = "true"; end
	local bsdefault = desc.bsdefault or _white;
	local bkd = desc.bkd or VFLUI.defaultBackdrop;
	local bordersize = desc.bordersize or 1;
	local os = 0; 
	if driver == 1 then 
		os = desc.ButtonSkinOffset or 0;
	elseif driver == 2 then
		if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
	elseif driver == 3 then
		os = desc.bordersize or 1;
	end

	local createCode = [[
frame.]] .. objname .. [[ = {};
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
for i=1, ]] .. desc.nIcons .. [[ do
	if ]] .. driver .. [[ == 1 then 
		btn = VFLUI.SkinButton:new();
		btn:SetWidth(]] .. desc.size .. [[); btn:SetHeight(]] .. desc.size .. [[);
		btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, ]] .. showgloss ..[[);
	elseif ]] .. driver .. [[ == 2 then
		btn = VFLUI.AcquireFrame("Button");
		btn:SetWidth(]] .. desc.size .. [[); btn:SetHeight(]] .. desc.size .. [[);
		VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
	elseif ]] .. driver .. [[ == 3 then
		btn = VFLUI.AcquireFrame("Button");
		btn:SetWidth(]] .. desc.size .. [[); btn:SetHeight(]] .. desc.size .. [[);
		VFLUI.SetBackdropBorderRDX(btn, _black, "ARTWORK", 7, ]] .. bordersize .. [[);
	end
	btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
]];
	if desc.disableClick then createCode = createCode .. [[
	btn:Disable();
]];
	end
	if not desc.disableShowTooltip then createCode = createCode .. [[
	btn:SetScript("OnEnter", __CooldownIconOnEnter);
	btn:SetScript("OnLeave", __CooldownIconOnLeave);
]];
	end
	createCode = createCode .. [[
	btn.tex = VFLUI.CreateTexture(btn);
	btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. os .. [[, -]] .. os .. [[);
	btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. os .. [[, ]] .. os .. [[);
	if not RDXG.usecleanicons then
		btn.tex:SetTexCoord(0.05, 1-0.06, 0.05, 1-0.04);
	end
	btn.tex:SetDrawLayer("ARTWORK", 2);
	btn.tex:Show();
	
	btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
	btn.cd:SetAllPoints(btn.tex);
	btn.cd:Show();
	frame.]] .. objname .. [[[i] = btn;
end
]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	return createCode;
end

-----------------------------
-- COOLDOWN ICONS
-----------------------------
RDX.RegisterFeature({
	name = "cd_icons";
	version = 1;
	title = VFLI.i18n("Icons Cooldown");
	category = VFLI.i18n("Lists");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
		if not desc.usebkd then desc.usebs = true; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Icons_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if not desc.mindurationfilter then desc.mindurationfilter = 0; end
		if (not tonumber(desc.mindurationfilter)) then 
			if (desc.mindurationfilter ~= "") then VFL.AddError(errs, VFLI.i18n("Min duration is not a number or empty")); flg = nil; end 
		end
		if not desc.maxdurationfilter then desc.maxdurationfilter = 3000; end
		if (not tonumber(desc.maxdurationfilter)) then 
			if (desc.maxdurationfilter ~= "") then VFL.AddError(errs, VFLI.i18n("Max duration is not a number or empty")); flg = nil; end 
		end
		if desc.externalNameFilter and desc.externalNameFilter ~= "" then
			if not RDXDB.CheckObject(desc.externalNameFilter, "CooldownFilter") then VFL.AddError(errs, VFLI.i18n("Invalid cooldownfilter")); flg = nil; end
		end
		if flg then state:AddSlot("Icons_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Icons_" .. desc.name;
		local driver = desc.driver or 2;
		local ebs = desc.externalButtonSkin or "bs_default";
		local showgloss = "nil"; if desc.showgloss then showgloss = "true"; end
		local bsdefault = desc.bsdefault or _white;
		local bkd = desc.bkd or VFLUI.defaultBackdrop;
		local bordersize = desc.bordersize or 1;
		local os = 0; 
		if driver == 1 then 
			os = desc.ButtonSkinOffset or 0;
		elseif driver == 2 then
			if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
		elseif driver == 3 then
			os = desc.bordersize or 1;
		end
	
		-- Event hinting.
		local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		mask = mux:GetPaintMask("COOLDOWN");
		mux:Event_UnitMask("UNIT_COOLDOWN", mask);
		mask = bit.bor(mask, 1);
		
		local loadCode = "unit:GetUsedCooldownsById";
		-- Event hinting.
		if desc.cooldownType == "AVAIL" then
			loadCode = "unit:GetAvailCooldownsById";
		end
		
		-- If there's an external filter, add a quick menu to the window to edit it.
		if desc.externalNameFilter then
			local path = desc.externalNameFilter; local afname = desc.name;
			state:GetContainingWindowState():Attach("Menu", true, function(win, mnu)
				table.insert(mnu, {
					text = VFLI.i18n("Edit CooldownFilter: ") .. afname;
					OnClick = function()
						VFL.poptree:Release();
						RDXDB.OpenObject(path, "Edit", VFLDIALOG);
					end;
				});
			end);
		end

		------------ Closure
		if desc.filterName then
			local closureCode = "";
			closureCode = closureCode ..[[
local ]] .. objname .. [[_fnames = ]];
			if desc.externalNameFilter then
				closureCode = closureCode .. [[RDXDB.GetObjectInstance(]] .. string.format("%q", desc.externalNameFilter) .. [[);
]];
			else
				-- Internal filter
				closureCode = closureCode .. [[{};
]];
				if desc.filterNameList then
					local flag;
					for _,name in pairs(desc.filterNameList) do
						flag = nil;
						local test = string.sub(name, 1, 1);
						if test == "!" then
							flag = true;
							name = string.sub(name, 2);
						end
						local testnumber = tonumber(name);
						if testnumber then
							local auname = GetSpellInfo(name);
							if flag then
								auname = "!" .. auname;
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", auname) .. "] = true; ";
							else
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", auname) .. "] = true; ";
							end
						else
							if flag then
								name = "!" .. name;
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", name) .. "] = true; ";
							else
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", name) .. "] = true; ";
							end
						end
					end
				end
			end
			state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);
		end
		
		----------------- Creation
		local createCode = _EmitCreateCode(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
local btn = nil;
for i=1,]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i]
	btn.meta = nil;
	btn.cd:Destroy(); btn.cd = nil;
	VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
	btn:Destroy();
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		local timefilter = "true";
		if desc.timefilter then timefilter = "(_dur > 0";
			if (desc.mindurationfilter ~= "") then timefilter = timefilter .. " and _dur >= " .. desc.mindurationfilter; end
			if (desc.maxdurationfilter ~= "") then timefilter = timefilter .. " and _dur <= " .. desc.maxdurationfilter; end
			timefilter = timefilter ..")";
		end
		local namefilter = "true"; if desc.filterName then
			namefilter = "(" .. objname .. "_fnames[_bn])";
			namefilter = namefilter .. " and (not (" .. objname .. "_fnames['!'.._bn]))"
		end
		local sorticons = " "; 
		desc.sort = nil;
		if desc.sort then
			if desc.sortduration then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._dur < x2._dur; end); ]];
			end
			if desc.sortstack then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._apps < x2._apps; end); ]];
			end
			if desc.sorttimeleft then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._tl < x2._tl; end); ]];
			end
			if desc.sortname then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._bn < x2._bn; end); ]];
			end
			
		end

		local paintCode = [[
if band(paintmask, ]] .. mask .. [[) ~= 0 then
	_i, _j, _avail, _bn, _meta, _tex, _dur, _tl = 1, 1, nil, nil, nil, nil, nil;
	_icons = frame.]] .. objname .. [[;
	local sort_icons = {};

	while true do
		local tbl_icons = {};
		_avail, _bn, _, _, _meta, _tex, _dur, _, _tl = RDXCD.UnitCooldown(uid, _i);
		if not _avail then break; end
		if ]] .. timefilter .. [[ and ]] .. namefilter .. [[ then
			tbl_icons._bn = _bn;
			tbl_icons._meta = _meta;
			tbl_icons._tex = _tex;
			tbl_icons._dur = _dur;
			tbl_icons._tl = _tl;
			tbl_icons._i = _i;
			table.insert(sort_icons, tbl_icons);
		end
		_i = _i + 1;
	end
	
	]];
		paintCode = paintCode .. sorticons;
		paintCode = paintCode ..[[
	local tbl_icons;
	while true do
		if (_j > ]] .. desc.nIcons .. [[) then break; end
		tbl_icons = sort_icons[_j];
		if not tbl_icons then break; end
		__SetCooldownIcon(_icons[_j], tbl_icons._meta, tbl_icons._tex, tbl_icons._dur, tbl_icons._tl, tbl_icons._i);
		_j = _j + 1;
	end
	
	while _j <= ]] .. desc.nIcons .. [[ do
		_icons[_j]:Hide(0.2); _j = _j + 1;
	end
end
]];

		local paintCodeWithoutSort = [[
if band(paintmask, ]] .. mask .. [[) ~= 0 then
	_i, _j, _avail, _bn, _meta, _tex, _dur, _tl = 1, 1, nil, nil, nil, nil, nil;
	_icons = frame.]] .. objname .. [[;
	while true do
		if (_j > ]] .. desc.nIcons .. [[) then break; end
		_avail, _bn, _meta, _tex, _dur, _start = ]] .. loadCode .. [[(_i);
		if not _avail then break; end
		if ]] .. timefilter .. [[ and ]] .. namefilter .. [[ then
			btn = _icons[_j];
			if not btn:IsShown() then btn:Show(0.2); end
			btn.spellid = _meta;
			btn.tex:SetTexture(_tex);
			if _dur and _dur > 0 and btn.cd then
				btn.cd:SetCooldown(_start, _dur);
			end
			_j = _j + 1;
		end
		_i = _i + 1;
	end
	while _j <= ]] .. desc.nIcons .. [[ do
		if _icons[_j]:IsShown() then _icons[_j]:Hide(0.2); end
		_j = _j + 1;
	end
end
]];
		if desc.sort then
			state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		else
			state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCodeWithoutSort); end);
		end
		------------------- Cleanup
		local cleanupCode = [[
local btn = nil;
for i=1,]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i];
	btn:Hide(); btn.meta = nil;
end
]];
		state:Attach("EmitCleanup", true, function(code) code:AppendCode(cleanupCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		------------- Core
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Core Parameters")));

		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		ed_name.editBox:SetText(desc.name);
		ui:InsertFrame(ed_name);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown Type"));
		local dd_cooldownType = VFLUI.Dropdown:new(er, RDXUI.CooldownsTypesDropdownFunction);
		dd_cooldownType:SetWidth(150); dd_cooldownType:Show();
		if desc and desc.cooldownType then 
			dd_cooldownType:SetSelection(desc.cooldownType); 
		else
			dd_cooldownType:SetSelection("USED");
		end
		er:EmbedChild(dd_cooldownType); er:Show();
		ui:InsertFrame(er);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", "StatusBar_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local ed_nicon = VFLUI.LabeledEdit:new(ui, 50); ed_nicon:Show();
		ed_nicon:SetText(VFLI.i18n("Max icons"));
		if desc and desc.nIcons then ed_nicon.editBox:SetText(desc.nIcons); end
		ui:InsertFrame(ed_nicon);

		local ed_rows = VFLUI.LabeledEdit:new(ui, 50); ed_rows:Show();
		ed_rows:SetText(VFLI.i18n("Row number"));
		if desc and desc.rows then ed_rows.editBox:SetText(desc.rows); end
		ui:InsertFrame(ed_rows);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation"));
		local dd_orientation = VFLUI.Dropdown:new(er, RDXUI.OrientationDropdownFunction);
		dd_orientation:SetWidth(75); dd_orientation:Show();
		if desc and desc.orientation then 
			dd_orientation:SetSelection(desc.orientation); 
		else
			dd_orientation:SetSelection("RIGHT");
		end
		er:EmbedChild(dd_orientation); er:Show();
		ui:InsertFrame(er);
		
		local ed_iconspx = VFLUI.LabeledEdit:new(ui, 50); ed_iconspx:Show();
		ed_iconspx:SetText(VFLI.i18n("Width spacing"));
		if desc and desc.iconspx then ed_iconspx.editBox:SetText(desc.iconspx); else ed_iconspx.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspx);
		
		local ed_iconspy = VFLUI.LabeledEdit:new(ui, 50); ed_iconspy:Show();
		ed_iconspy:SetText(VFLI.i18n("Height spacing"));
		if desc and desc.iconspy then ed_iconspy.editBox:SetText(desc.iconspy); else ed_iconspy.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspy);
		
		local ed_size = VFLUI.LabeledEdit:new(ui, 50); ed_size:Show();
		ed_size:SetText(VFLI.i18n("Icon Size"));
		if desc and desc.size then ed_size.editBox:SetText(desc.size); end
		ui:InsertFrame(ed_size);

		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Skin parameters")));
		
		local driver = VFLUI.DisjointRadioGroup:new();
		
		local driver_BS = driver:CreateRadioButton(ui);
		driver_BS:SetText(VFLI.i18n("Use Button Skin"));
		local driver_BD = driver:CreateRadioButton(ui);
		driver_BD:SetText(VFLI.i18n("Use Backdrop"));
		local driver_RB = driver:CreateRadioButton(ui);
		driver_RB:SetText(VFLI.i18n("Use RDX Border"));
		driver:SetValue(desc.driver or 2);
		
		ui:InsertFrame(driver_BS);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Button Skin"));
		local dd_buttonSkin = VFLUI.Dropdown:new(er, VFLUI.GetButtonSkinList);
		dd_buttonSkin:SetWidth(150); dd_buttonSkin:Show();
		dd_buttonSkin:SetSelection(desc.externalButtonSkin); 
		er:EmbedChild(dd_buttonSkin); er:Show();
		ui:InsertFrame(er);
		
		local ed_bs = VFLUI.LabeledEdit:new(ui, 50); ed_bs:Show();
		ed_bs:SetText(VFLI.i18n("Button Skin Size Offset"));
		if desc and desc.ButtonSkinOffset then ed_bs.editBox:SetText(desc.ButtonSkinOffset); end
		ui:InsertFrame(ed_bs);
		
		local chk_showgloss = VFLUI.Checkbox:new(ui); chk_showgloss:Show();
		chk_showgloss:SetText(VFLI.i18n("Button Skin Show Gloss"));
		if desc and desc.showgloss then chk_showgloss:SetChecked(true); else chk_showgloss:SetChecked(); end
		ui:InsertFrame(chk_showgloss);
		
		local color_bsdefault = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Button Skin default color"));
		if desc and desc.bsdefault then color_bsdefault:SetColor(VFL.explodeRGBA(desc.bsdefault)); end
		
		ui:InsertFrame(driver_BD);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop"));
		local dd_backdrop = VFLUI.MakeBackdropSelectButton(er, desc.bkd);
		dd_backdrop:Show();
		er:EmbedChild(dd_backdrop); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(driver_RB);
		
		local ed_borsize = VFLUI.LabeledEdit:new(ui, 50); ed_borsize:Show();
		ed_borsize:SetText(VFLI.i18n("Border size"));
		if desc and desc.bordersize then ed_borsize.editBox:SetText(desc.bordersize); end
		ui:InsertFrame(ed_borsize);
		
		-------------- Interraction
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Interaction parameters")));
		
		local chk_disableClick = VFLUI.Checkbox:new(ui); chk_disableClick:Show();
		chk_disableClick:SetText(VFLI.i18n("Disable button"));
		if desc and desc.disableClick then chk_disableClick:SetChecked(true); else chk_disableClick:SetChecked(); end
		ui:InsertFrame(chk_disableClick);
		
		local chk_disableShowTooltip = VFLUI.Checkbox:new(ui); chk_disableShowTooltip:Show();
		chk_disableShowTooltip:SetText(VFLI.i18n("Disable tooltip"));
		if desc and desc.disableShowTooltip then chk_disableShowTooltip:SetChecked(true); else chk_disableShowTooltip:SetChecked(); end
		ui:InsertFrame(chk_disableShowTooltip);
		
		-------------- CooldownDisplay
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown parameters")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);
		
		------------ Sort
		--[[ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Sort")));
		
		local chk_sort = VFLUI.Checkbox:new(ui); chk_sort:Show();
		chk_sort:SetText(VFLI.i18n("Activate Sort"));
		if desc and desc.sort then chk_sort:SetChecked(true); else chk_sort:SetChecked(); end
		ui:InsertFrame(chk_sort);
		
		--local chk_sortstack = VFLUI.Checkbox:new(ui); chk_sortstack:Show();
		--chk_sortstack:SetText(VFLI.i18n("Sort by stack"));
		--if desc and desc.sortstack then chk_sortstack:SetChecked(true); else chk_sortstack:SetChecked(); end
		--ui:InsertFrame(chk_sortstack);
		
		local chk_sortduration = VFLUI.Checkbox:new(ui); chk_sortduration:Show();
		chk_sortduration:SetText(VFLI.i18n("Sort by duration"));
		if desc and desc.sortduration then chk_sortduration:SetChecked(true); else chk_sortduration:SetChecked(); end
		ui:InsertFrame(chk_sortduration);
		
		local chk_sorttimeleft = VFLUI.Checkbox:new(ui); chk_sorttimeleft:Show();
		chk_sorttimeleft:SetText(VFLI.i18n("Sort by timeleft"));
		if desc and desc.sorttimeleft then chk_sorttimeleft:SetChecked(true); else chk_sorttimeleft:SetChecked(); end
		ui:InsertFrame(chk_sorttimeleft);
		
		local chk_sortname = VFLUI.Checkbox:new(ui); chk_sortname:Show();
		chk_sortname:SetText(VFLI.i18n("Sort by name"));
		if desc and desc.sortname then chk_sortname:SetChecked(true); else chk_sortname:SetChecked(); end
		ui:InsertFrame(chk_sortname);]]

		------------ Filter
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));
		
		local chk_timefilter = VFLUI.Checkbox:new(ui); chk_timefilter:Show();
		chk_timefilter:SetText(VFLI.i18n("Filter by duration"));
		if desc and desc.timefilter then chk_timefilter:SetChecked(true); else chk_timefilter:SetChecked(); end
		ui:InsertFrame(chk_timefilter);
		
		local ed_maxduration = VFLUI.LabeledEdit:new(ui, 50); ed_maxduration:Show();
		ed_maxduration:SetText(VFLI.i18n("Filter by Max duration (sec)"));
		if desc and desc.maxdurationfilter then ed_maxduration.editBox:SetText(desc.maxdurationfilter); else ed_maxduration.editBox:SetText(""); end
		ui:InsertFrame(ed_maxduration);
		
		local ed_minduration = VFLUI.LabeledEdit:new(ui, 50); ed_minduration:Show();
		ed_minduration:SetText(VFLI.i18n("Filter by min duration (sec)"));
		if desc and desc.mindurationfilter then ed_minduration.editBox:SetText(desc.mindurationfilter); else ed_minduration.editBox:SetText(""); end
		ui:InsertFrame(ed_minduration);

		local chk_filterName = VFLUI.Checkbox:new(ui); chk_filterName:Show();
		chk_filterName:SetText(VFLI.i18n("Filter by cooldown name"));
		if desc and desc.filterName then chk_filterName:SetChecked(true); else chk_filterName:SetChecked(); end
		ui:InsertFrame(chk_filterName);

		local chk_external = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use external cooldown list"));
		local file_external = RDXDB.ObjectFinder:new(chk_external, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "CooldownFilter$")); end);
		file_external:SetWidth(200); file_external:Show();
		chk_external:EmbedChild(file_external); chk_external:Show();
		ui:InsertFrame(chk_external);
		if desc.externalNameFilter then
			chk_external:SetChecked(true); file_external:SetPath(desc.externalNameFilter);
		else
			chk_external:SetChecked();
		end

		local le_names = VFLUI.ListEditor:new(ui, desc.filterNameList or {}, function(cell,data) 
			if type(data) == "number" then
				local name = GetSpellInfo(data);
				cell.text:SetText(name);
			else
				local test = string.sub(data, 1, 1);
				if test == "!" then
					local uname = string.sub(data, 2);
					local vname = GetSpellInfo(uname);
					if vname then
						cell.text:SetText("!" .. vname);
					else
						cell.text:SetText(data);
					end
				else
					cell.text:SetText(data);
				end
			end
		end);
		le_names:SetHeight(183); le_names:Show();
		ui:InsertFrame(le_names);
		
		function ui:GetDescriptor()
			local filterName, filterNameList, filternl, ext, unitfi, maxdurfil, mindurfil = nil, nil, {}, nil, "", "", "";
			if chk_timefilter:GetChecked() then
				maxdurfil = ed_maxduration.editBox:GetText();
				mindurfil = ed_minduration.editBox:GetText();
			end
			if chk_filterName:GetChecked() then
				filterNameList = le_names:GetList();
				local flag;
				for k,v in pairs(filterNameList) do
					flag = nil;
					local test = string.sub(v, 1, 1);
					if test == "!" then
						flag = true;
						v = string.sub(v, 2);
					end
					local testnumber = tonumber(v);
					if testnumber then
						if flag then
							filternl[k] = "!" .. testnumber;
						else
							filternl[k] = testnumber;
						end
					else
						if flag then
							local spellid = RDXSS.GetSpellIdByLocalName(v);
							if spellid then
								filternl[k] = "!" .. spellid;
							else
								filternl[k] = "!" .. v;
							end
						else
							filternl[k] = RDXSS.GetSpellIdByLocalName(v) or v;
						end
					end
				end
				if chk_external:GetChecked() then ext = file_external:GetPath(); end
			end
			--if  not chk_sort:GetChecked() then
			--	chk_sortduration:SetChecked();
			--	chk_sorttimeleft:SetChecked();
			--	chk_sortname:SetChecked();
			--end
			return { 
				feature = "cd_icons"; version = 1;
				name = ed_name.editBox:GetText();
				cooldownType = dd_cooldownType:GetSelection();
				-- layout
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				nIcons = VFL.clamp(ed_nicon.editBox:GetNumber(), 1, 40);
				rows = VFL.clamp(ed_rows.editBox:GetNumber(), 1, 40);
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), -200, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), -200, 200);
				size = VFL.clamp(ed_size.editBox:GetNumber(), 1, 100);
				-- display
				driver = driver:GetValue();
				externalButtonSkin = dd_buttonSkin:GetSelection();
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				showgloss = chk_showgloss:GetChecked();
				bsdefault = color_bsdefault:GetColor();
				bkd = dd_backdrop:GetSelectedBackdrop();
				bordersize = VFL.clamp(ed_borsize.editBox:GetNumber(), 0, 50);
				-- interaction
				disableClick = chk_disableClick:GetChecked();
				disableShowTooltip = chk_disableShowTooltip:GetChecked();
				-- cooldown
				cd = cd:GetSelectedCooldown();
				timefilter = chk_timefilter:GetChecked();
				maxdurationfilter = maxdurfil;
				mindurationfilter = mindurfil;
				filterName = chk_filterName:GetChecked();
				externalNameFilter = ext;
				filterNameList = filternl;
				-- sort
				--sort = chk_sort:GetChecked();
				--sortstack = chk_sortstack:GetChecked();
				--sortduration = chk_sortduration:GetChecked();
				--sorttimeleft = chk_sorttimeleft:GetChecked();
				--sortname = chk_sortname:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		local font = VFL.copy(Fonts.Default); font.size = 8; font.justifyV = "CENTER"; font.justifyH = "CENTER";
		return { 
			feature = "cd_icons";
			version = 1;
			name = "ai1";
			owner = "Frame_decor";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			nIcons = 4; size = 20; rows = 1; orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			drawLayer = "ARTWORK";
			cd = VFL.copy(VFLUI.defaultCooldown);
		};
	end;
});


