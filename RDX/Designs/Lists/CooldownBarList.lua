-- CooldownBarList.lua
-- OpenRDX
-- Sigg Rashgarroth EU
--

local strsub = string.sub;

function __SetCooldownBar(btn, meta, tex, apps, dur, tl, dispelType, i, auratype, usedebuffcolor, auranametrunc, auranameab, smooth, countTypeFlag)
	if not btn:IsShown() then btn:Show(smooth); end
	btn.meta = meta;
	
	if btn.icon then btn.icon:SetTexture(tex); end
	
	if btn.nametxt then
		if auranameab then
			local word, anstr = nil, "";
			for word in string.gmatch(meta.properName, "%a+")
				do anstr = anstr .. word:sub(1, 1);
			end
			btn.nametxt:SetText(anstr);
		elseif auranametrunc then
			btn.nametxt:SetText(strsub(meta.properName, 1, auranametrunc));
		else
			btn.nametxt:SetText(meta.properName);
		end
	end
	
	if auratype == "DEBUFFS" and usedebuffcolor then
		if dispelType then
			btn.sb:SetColorTable(DebuffTypeColor[dispelType]);
		else
			btn.sb:SetColorTable(_grey);
		end
	end
	
	btn.ftc:SetFormula(countTypeFlag);
	if dur and dur > 0 then
		btn.ftc:SetTimer(GetTime() + tl - dur , dur);
	else
		btn.ftc:SetTimer(0, 0);
	end
	
	if apps and apps > 1 and btn.stacktxt then btn.stacktxt:SetText(apps); else btn.stacktxt:SetText(""); end
	
	return true;
end

--------------- Code emitter helpers
local function _EmitCreateCode(objname, desc)
	local createCode = [[
frame.]] .. objname .. [[ = {};
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
for i=1,]] .. desc.nIcons .. [[ do
	btn = VFLUI.SBTIB:new(btnOwner, ]] .. Serialize(desc.sbtib) .. [[);
]];
	if desc.sbtib and desc.sbtib.btype == "Button" then
		createCode = createCode .. [[
	btn:SetScript("OnEnter", __CooldownIconOnEnter);
	btn:SetScript("OnLeave", __CooldownIconOnLeave);
]];
	end
	
	createCode = createCode .. [[
	btn.ftc = ftc_]] .. objname .. [[(btn, btn.sb, btn.timetxt);
	frame.]] .. objname .. [[[i] = btn;
end
]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	return createCode;
end

RDX.RegisterFeature({
	name = "cooldown_bars";
	version = 2;
	title = VFLI.i18n("Cooldown Bars");
	category = VFLI.i18n("Lists");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not desc.sbtib then desc.sbtib = VFL.copy(VFLUI.defaultSBTIB); end
		if not desc.countTypeFlag then desc.countTypeFlag = "false"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Bars_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		--flg = flg and RDXUI.UFLayoutCheck(desc, state, errs);
		if not desc.mindurationfilter then desc.mindurationfilter = 0; end
		if (not tonumber(desc.mindurationfilter)) then 
			if (desc.mindurationfilter ~= "") then VFL.AddError(errs, VFLI.i18n("Min duration is not a number or empty")); flg = nil; end 
		end
		if not desc.maxdurationfilter then desc.maxdurationfilter = 3000; end
		if (not tonumber(desc.maxdurationfilter)) then 
			if (desc.maxdurationfilter ~= "") then VFL.AddError(errs, VFLI.i18n("Max duration is not a number or empty")); flg = nil; end 
		end
		if desc.externalNameFilter and desc.externalNameFilter ~= "" then
			if not RDXDB.CheckObject(desc.externalNameFilter, "CooldownFilter") then VFL.AddError(errs, VFLI.i18n("Invalid CooldownFilter")); flg = nil; end
		end
		if flg then state:AddSlot("Bars_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Bars_" .. desc.name;
		
		-- Event hinting.
		local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		mask = mux:GetPaintMask("COOLDOWN");
		mux:Event_UnitMask("UNIT_COOLDOWN", mask);
		mask = bit.bor(mask, 1);
		
		local loadCode = "unit:GetUsedCooldownsById";
		-- only used
		--if desc.cooldownType == "AVAIL" then
		--	loadCode = "unit:GetAvailCooldownsById";
		--end
		
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
		local closureCode = [[
local ftc_]] .. objname .. [[ = FreeTimer.CreateFreeTimerClass(true,true, nil, VFLUI.GetTextTimerTypesString("MinSec"), false, false, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide);
]];
		if desc.filterName then
			closureCode = closureCode .. [[
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
							if not auname then auname = name; end
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
		end
		
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		----------------- Creation
		local createCode = _EmitCreateCode(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
local btn = nil;
for i=1,]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i]
	btn.meta = nil;
	btn.ftc:Destroy(); btn.ftc = nil;
	btn:Destroy(); btn = nil;
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		local smooth = "nil"; if desc.smooth then smooth = "RDX.smooth"; end
		
		local timefilter = "true"; 
		if desc.timefilter then timefilter = "(_dur > 0";
			if (desc.mindurationfilter ~= "") then timefilter = timefilter .. " and _dur >= " .. desc.mindurationfilter; end
			if (desc.maxdurationfilter ~= "") then timefilter = timefilter .. " and _dur <= " .. desc.maxdurationfilter; end
			timefilter = timefilter ..")";
		elseif desc.notimefilter then
			timefilter = "(_dur == 0)";
		end
		local namefilter = "true"; if desc.filterName then
			namefilter = "(" .. objname .. "_fnames[_bn])";
			namefilter = namefilter .. " and (not (" .. objname .. "_fnames['!'.._bn]))"
		end
		local countTypeFlag = "nil" if desc.countTypeFlag and desc.countTypeFlag ~= "" then countTypeFlag = desc.countTypeFlag; end
		
		local auranametrunc = "nil"; if desc.trunc then auranametrunc = desc.trunc; end
		local auranameab = "true"; if (not desc.abr) then auranameab = "false"; end
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

		local paintCodeWithoutSort = [[
if band(paintmask, ]] .. mask .. [[) ~= 0 then
	_i, _j, _avail, _bn, _meta, _tex, _dur, _start = 1, 1, nil, nil, nil, nil, nil;
	_icons = frame.]] .. objname .. [[;
	while true do
		if (_j > ]] .. desc.nIcons .. [[) then break; end
		_avail, _bn, _meta, _tex, _dur, _start = ]] .. loadCode .. [[(_i);
		if not _avail then break; end
		if ]] .. timefilter .. [[ and ]] .. namefilter .. [[ then
			btn = _icons[_j];
			if not btn:IsShown() then btn:Show(]] .. smooth .. [[); end
			btn.spellid = _meta;
			if btn.icon then
				btn.icon:SetTexture(_tex);
			end
			if btn.nametxt then
				if ]] .. auranameab .. [[ then
					local word, anstr = nil, "";
					for word in string.gmatch(_bn, "%a+")
						do anstr = anstr .. word:sub(1, 1);
					end
					btn.nametxt:SetText(anstr);
				elseif ]] .. auranametrunc .. [[ then
					btn.nametxt:SetText(strsub(_bn, 1, ]] .. auranametrunc .. [[));
				else
					btn.nametxt:SetText(_bn);
				end
			end
			btn.ftc:SetFormula(]] .. countTypeFlag .. [[);
			if _dur and _dur > 0 and btn.ftc then
				btn.ftc:SetTimer(_start, _dur);
			else
				btn.ftc:SetTimer(0, 0);
			end
			_j = _j + 1;
		end
		_i = _i + 1;
	end
	while _j <= ]] .. desc.nIcons .. [[ do
		if _icons[_j]:IsShown() then _icons[_j]:Hide(]] .. smooth .. [[); end
		_j = _j + 1;
	end
end
]];

		--if desc.sort then
		--	state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		--else
			state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCodeWithoutSort); end);
		--end
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

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown Type:"));
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
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout")));

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, "Owner", state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local ed_mb = VFLUI.LabeledEdit:new(ui, 50); ed_mb:Show();
		ed_mb:SetText(VFLI.i18n("Max bars"));
		if desc and desc.nIcons then ed_mb.editBox:SetText(desc.nIcons); end
		ui:InsertFrame(ed_mb);

		local ed_rows = VFLUI.LabeledEdit:new(ui, 50); ed_rows:Show();
		ed_rows:SetText(VFLI.i18n("Row size"));
		if desc and desc.rows then ed_rows.editBox:SetText(desc.rows); end
		ui:InsertFrame(ed_rows);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation:"));
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
		ed_iconspx:SetText(VFLI.i18n("Spacing width"));
		if desc and desc.iconspx then ed_iconspx.editBox:SetText(desc.iconspx); else ed_iconspx.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspx);
		
		local ed_iconspy = VFLUI.LabeledEdit:new(ui, 50); ed_iconspy:Show();
		ed_iconspy:SetText(VFLI.i18n("Spacing height"));
		if desc and desc.iconspy then ed_iconspy.editBox:SetText(desc.iconspy); else ed_iconspy.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspy);
		
		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Display Bar")));
		
		local er2 = VFLUI.EmbedRight(ui, VFLI.i18n("Statusbar style"));
		local sbtib = VFLUI.MakeSBTIBSelectButton(er2, desc.sbtib); sbtib:Show();
		er2:EmbedChild(sbtib); er2:Show();
		ui:InsertFrame(er2);
		
		local countTypeFlag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Count type (true CountUP, false CountDOWN)"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.countTypeFlag then countTypeFlag:SetSelection(desc.countTypeFlag); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Display Fonts")));
		
		local ed_trunc = VFLUI.LabeledEdit:new(ui, 50); ed_trunc:Show();
		ed_trunc:SetText(VFLI.i18n("Max aura length (blank = no truncation)"));
		if desc and desc.trunc then ed_trunc.editBox:SetText(desc.trunc); end
		ui:InsertFrame(ed_trunc);
		
		local chk_abr = VFLUI.Checkbox:new(ui); chk_abr:Show();
		chk_abr:SetText(VFLI.i18n("Use abbreviating"));
		if desc and desc.abr then chk_abr:SetChecked(true); else chk_abr:SetChecked(); end
		ui:InsertFrame(chk_abr);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Smooth show hide")));
		local chk_smooth = VFLUI.Checkbox:new(ui); chk_smooth:Show();
		chk_smooth:SetText(VFLI.i18n("Use smooth on show and hide"));
		if desc and desc.smooth then chk_smooth:SetChecked(true); else chk_smooth:SetChecked(); end
		ui:InsertFrame(chk_smooth);
		
		------------ Sort
		--[[ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Sort")));
		
		local chk_sort = VFLUI.Checkbox:new(ui); chk_sort:Show();
		chk_sort:SetText(VFLI.i18n("Activate Sort"));
		if desc and desc.sort then chk_sort:SetChecked(true); else chk_sort:SetChecked(); end
		ui:InsertFrame(chk_sort);
		
		local chk_sortstack = VFLUI.Checkbox:new(ui); chk_sortstack:Show();
		chk_sortstack:SetText(VFLI.i18n("Sort by stack"));
		if desc and desc.sortstack then chk_sortstack:SetChecked(true); else chk_sortstack:SetChecked(); end
		ui:InsertFrame(chk_sortstack);
		
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
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering")));
		
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
		local file_external = RDXDB.ObjectFinder:new(chk_external, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "AuraFilter$")); end);
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
			local trunc = tonumber(ed_trunc.editBox:GetText());
			if trunc then trunc = VFL.clamp(trunc, 1, 50); end
			local filterName, filterNameList, filternl, ext, unitfi = nil, nil, {}, nil, "";
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
			--	chk_sortstack:SetChecked();
			--	chk_sortduration:SetChecked();
			--	chk_sorttimeleft:SetChecked();
			--	chk_sortname:SetChecked();
			--end
			return { 
				feature = "cooldown_bars"; 
				version = 2;
				name = ed_name.editBox:GetText();
				cooldownType = dd_cooldownType:GetSelection();
				-- layout
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				nIcons = VFL.clamp(ed_mb.editBox:GetNumber(), 1, 40);
				rows = VFL.clamp(ed_rows.editBox:GetNumber(), 1, 40);
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), 0, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), 0, 200);
				-- display bar
				sbtib = sbtib:GetSelectedSBTIB();
				countTypeFlag = countTypeFlag:GetSelection();
				-- fonts
				trunc = trunc;
				abr = chk_abr:GetChecked();
				-- smooth
				smooth = chk_smooth:GetChecked();
				-- filter
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
		return { 
			feature = "cooldown_bars";
			version = 1;
			name = "ab1";
			cooldownType = "USED";
			owner = "decor";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			nIcons = 10; rows = 1; orientation = "DOWN"; iconspx = 0; iconspy = 1;
			sbtib = VFL.copy(VFLUI.defaultSBTIB);
		};
	end;
});

