-- AuraIcons.lua
-- RDX - Raid Data Exchange
-- (C)2006-2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Code for aura icons attached to unitframes.
--

function __SetAuraIcon(btn, meta, tex, apps, dur, tl, dispelType, i, ebsflag, smooth)
	if not btn:IsShown() then btn:Show(smooth); end
	btn.meta = meta;
	btn.tex:SetTexture(tex);
	if dispelType and DebuffTypeColor[dispelType] then
		btn._texBorder:SetVertexColor(VFL.explodeColor(DebuffTypeColor[dispelType]));
	else
		btn._texBorder:SetVertexColor(VFL.explodeRGBA(btn.bsdefault));
	end
	-- Cooldown
	if dur and dur > 0 and btn.cd then
		btn.cd:SetCooldown(GetTime() + tl - dur , dur);
	else
		btn.cd:SetCooldown(0, 0);
	end
	if apps and (apps > 1) then btn.sttxt:SetText(apps); else btn.sttxt:SetText(""); end
	return true;
end

local ShowAuraTooltip = RDXDAL.ShowAuraTooltip;

function __AuraIconOnEnter(self)
	if self.meta then ShowAuraTooltip(self.meta, self, "RIGHT"); end
end
function __AuraIconOnLeave()
	GameTooltip:Hide();
end
function __AuraIconOnClick(self)
	if not InCombatLockdown() then
		CancelUnitBuff("player", self.meta.name);
	end
end

--------------- Code emitter helpers
local function _EmitCreateCode(objname, desc)
	local usebs = "false"; if desc.usebs then usebs = "true"; end
	local ebs = desc.externalButtonSkin or "bs_default";
	local usebkd = "false"; if desc.usebkd then usebkd = "true"; end
	local bkd = desc.bkd or VFLUI.defaultBackdrop;	
	local os = 0; 
	if desc.usebs then 
		os = desc.ButtonSkinOffset or 0;
	elseif desc.usebkd then
		if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
	end
	local showgloss = "nil"; if desc.showgloss then showgloss = "true"; end
	local bsdefault = desc.bsdefault or _white;
	
	local createCode = [[
frame.]] .. objname .. [[ = {};
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
for i=1, ]] .. desc.nIcons .. [[ do
	if ]] .. usebs .. [[ then 
		btn = VFLUI.SkinButton:new();
		btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, ]] .. showgloss ..[[);
	elseif ]] .. usebkd .. [[ then
		btn = VFLUI.AcquireFrame("Button");
		VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
	else
		btn = VFLUI.AcquireFrame("Button");
	end
	btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
	btn:SetWidth(]] .. desc.size .. [[); btn:SetHeight(]] .. desc.size .. [[);
	btn:SetScript("OnEnter", __AuraIconOnEnter);
	btn:SetScript("OnLeave", __AuraIconOnLeave);
]];
	if desc.externalButtonSkin then createCode = createCode .. [[
	btn:RegisterForClicks("RightButtonUp");
	btn:SetScript("OnClick", __AuraIconOnClick);
]];
	end
	createCode = createCode .. [[
	btn.tex = VFLUI.CreateTexture(btn);
	btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. os .. [[, -]] .. os .. [[);
	btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. os .. [[, ]] .. os .. [[);
	btn.tex:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	btn.tex:SetDrawLayer("ARTWORK", 2);
	btn.tex:Show();
	
	btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
	btn.cd:SetAllPoints(btn.tex);
	btn.cd:Show();
]];
	createCode = createCode .. [[
	btn.frtxt = VFLUI.AcquireFrame("Frame");
	btn.frtxt:SetParent(btn);
	btn.frtxt:SetFrameLevel(btn:GetFrameLevel() + 2);
	btn.frtxt:SetAllPoints(btn);
	btn.frtxt:Show();
	
	btn.sttxt = VFLUI.CreateFontString(btn.frtxt);
	btn.sttxt:SetAllPoints(btn.frtxt);
	btn.sttxt:Show();
]];
	createCode = createCode .. VFLUI.GenerateSetFontCode("btn.sttxt", desc.fontst, nil, true);
	createCode = createCode .. [[
	frame.]] .. objname .. [[[i] = btn;
end
]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	return createCode;
end

-----------------------------
-- AURA ICONS
-----------------------------
RDX.RegisterFeature({
	name = "aura_icons";
	version = 1;
	title = VFLI.i18n("Icons Aura");
	test = true;
	category = VFLI.i18n("Lists");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
		if not desc.iconspx then desc.iconspx = 0; end
		if not desc.iconspy then desc.iconspy = 0; end
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
			if not RDXDB.CheckObject(desc.externalNameFilter, "AuraFilter") then VFL.AddError(errs, VFLI.i18n("Invalid aurafilter")); flg = nil; end
		end
		if flg then state:AddSlot("Icons_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Icons_" .. desc.name;
		
		local usebs = "false"; if desc.usebs then usebs = "true"; end
		local ebs = desc.externalButtonSkin or "bs_default";
		local usebkd = "false"; if desc.usebkd then usebkd = "true"; end
		local bkd = desc.bkd or VFLUI.defaultBackdrop;	
		local os = 0; 
		if desc.usebs then 
			os = desc.ButtonSkinOffset or 0;
		elseif desc.usebkd then
			if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
		end
		local showgloss = "nil"; if desc.showgloss then showgloss = "true"; end
		local bsdefault = desc.bsdefault or _white;
		
		local r, g, b, a = bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1;
		
		local loadCode = "LoadBuffFromUnit";
		-- Event hinting.
		local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		if desc.auraType == "DEBUFFS" then
			mask = mux:GetPaintMask("DEBUFFS");
			mux:Event_UnitMask("UNIT_DEBUFF_*", mask);
			loadCode = "LoadDebuffFromUnit";
		else
			mask = mux:GetPaintMask("BUFFS");
			mux:Event_UnitMask("UNIT_BUFF_*", mask);
		end
		mask = bit.bor(mask, 1);

		-- If there's an external filter, add a quick menu to the window to edit it.
		if desc.externalNameFilter then
			local path = desc.externalNameFilter; local afname = desc.name;
			state:GetContainingWindowState():Attach("Menu", true, function(win, mnu)
				table.insert(mnu, {
					text = VFLI.i18n("Edit AuraFilter: ") .. afname;
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
	VFLUI.ReleaseRegion(btn.sttxt); btn.sttxt = nil;
	btn.frtxt:Destroy(); btn.frtxt = nil;
	btn.cd:Destroy(); btn.cd = nil;
	VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
	btn:Destroy(); btn = nil;
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		local winpath = state:GetContainingWindowState():GetSlotValue("Path");
		local md = RDXDB.GetObjectData(winpath);
		local auracache = "false"; if md and RDXDB.HasFeature(md.data, "AuraCache") then auracache = "true"; end
		local smooth = "nil"; if desc.smooth then smooth = "RDX.smooth"; end
		local raidfilter = "nil"; if desc.raidfilter then raidfilter = "true"; end
		
		local aurasfilter, afflag = " (", nil; 
		if desc.playerauras then aurasfilter = aurasfilter .. " _caster == 'player'"; afflag = true; end
		if desc.othersauras then 
			if afflag then
				aurasfilter = aurasfilter .. " or _caster ~= 'player'";
			else
				aurasfilter = aurasfilter .. " _caster ~= 'player'"; afflag = true;
			end
		end
		if desc.petauras then 
			    -- ================== PATCH GB : Make filter by  vehicle working =====================================
			if afflag then
				aurasfilter = aurasfilter .. " or _caster == 'pet' or _caster == 'vehicle'";
			else
				aurasfilter = aurasfilter .. " _caster == 'pet' or _caster == 'vehicle'"; afflag = true;
			end
-- 			if afflag then
-- 				aurasfilter = aurasfilter .. " or _caster == 'pet'";
-- 			else
-- 				aurasfilter = aurasfilter .. " _caster == 'pet'"; afflag = true;
-- 			end
			-- ================== fin patch GB =====================================
		
		end
		if desc.targetauras then 
			if afflag then
				aurasfilter = aurasfilter .. " or _caster == 'target'";
			else
				aurasfilter = aurasfilter .. " _caster == 'target'"; afflag = true;
			end
		end
		if desc.focusauras then 
			if afflag then
				aurasfilter = aurasfilter .. " or _caster == 'focus'";
			else
				aurasfilter = aurasfilter .. " _caster == 'focus'"; afflag = true;
			end
		end
		if not afflag then aurasfilter = aurasfilter .. " true"; end
		aurasfilter = aurasfilter .. " )";
		
		local isstealablefilter = "true"; if desc.isstealablefilter then isstealablefilter = "_isStealable"; end
		local curefilter = "true"; if desc.curefilter then curefilter = "(_dispelt and RDXSS.GetCategoryByName('CURE_'..string.upper(_dispelt)))"; end
		local timefilter = "true"; 
		if desc.timefilter then timefilter = "(_dur > 0";
			if (desc.mindurationfilter ~= "") then timefilter = timefilter .. " and _dur >= " .. desc.mindurationfilter; end
			if (desc.maxdurationfilter ~= "") then timefilter = timefilter .. " and _dur <= " .. desc.maxdurationfilter; end
			timefilter = timefilter ..")";
		elseif desc.notimefilter then
			timefilter = "(_dur == 0)";
		end
		local namefilter = "true"; if desc.filterName then
			namefilter = "(" .. objname .. "_fnames[_bn] or " .. objname .. "_fnames[_meta.category])";
			namefilter = namefilter .. " and (not (" .. objname .. "_fnames['!'.._bn] or " .. objname .. "_fnames['!'.._meta.category]))"
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
		
		local paintCodeTest = [[
	_i, _j, _bn, _tex, _apps, _meta, _dur, _tl, _dispelt, _caster, _isStealable = 1,1,nil,nil,nil,nil,nil,nil,nil,nil;
	_icons = frame.]] .. objname .. [[;
	while true do
		if (_j > ]] .. desc.nIcons .. [[) then break; end
		_, _bn, _, _, _meta, _, _tex, _apps, _dispelt, _dur, _, _tl, _caster, _isStealable = nil, true, nil, nil, {}, nil, "Interface\\Addons\\RDX\\Skin\\whackaMole", 6, nil, 60, nil, 50, true, true;
		if not _meta then break; end
		--if (not _meta.isInvisible) and ]] .. aurasfilter .. [[ and ]] .. isstealablefilter .. [[ and ]] .. curefilter .. [[ and ]] .. timefilter .. [[ and ]] .. namefilter .. [[ then
			btn = _icons[_j];
			if not btn:IsShown() then btn:Show(smooth); end
			btn.meta = _meta;
			btn.tex:SetTexture(_tex);
			if _dispelt and DebuffTypeColor[_dispelt] then
				if ]] .. usebs .. [[ then
					btn._texBorder:SetVertexColor(VFL.explodeColor(DebuffTypeColor[_dispelt]));
				elseif ]] .. usebkd .. [[ then
					btn:SetBackdropBorderColor(VFL.explodeRGBA(DebuffTypeColor[_dispelt]));
				end
			else
				if ]] .. usebs .. [[ then
					btn._texBorder:SetVertexColor(1, 1, 1, 1);
				elseif ]] .. usebkd .. [[ then
					btn:SetBackdropBorderColor(]] .. r .. [[, ]] .. g .. [[, ]] .. b .. [[, ]] .. a .. [[);
				end
			end
			-- Cooldown
			if _dur and _dur > 0 and btn.cd then
				btn.cd:SetCooldown(GetTime() + _tl - _dur , _dur);
			else
				btn.cd:SetCooldown(0, 0);
			end
			if _apps and (_apps > 1) then btn.sttxt:SetText(_apps); else btn.sttxt:SetText(""); end
			
			_j = _j + 1;
		--end
		_i = _i + 1;
	end
	while _j <= ]] .. desc.nIcons .. [[ do
		btn = _icons[_j];
		if btn:IsShown() then btn:Hide(]] .. smooth .. [[); end
		_j = _j + 1;
	end
]];

		local paintCode = [[
if band(paintmask, ]] .. mask .. [[) ~= 0 then
	_i, _j, _bn, _tex, _apps, _meta, _dur, _tl, _dispelt, _caster, _isStealable = 1,1,nil,nil,nil,nil,nil,nil,nil,nil;
	_icons = frame.]] .. objname .. [[;
	local sort_icons = {};

	while true do
		local tbl_icons = {};
		_, _bn, _, _, _meta, _, _tex, _apps, _dispelt, _dur, _, _tl, _caster, _isStealable = ]] .. loadCode .. [[(uid, _i, ]] .. raidfilter .. [[, ]] .. auracache .. [[);
		if not _meta then break; end
		if (not _meta.isInvisible) and ]] .. aurasfilter .. [[ and ]] .. isstealablefilter .. [[ and ]] .. curefilter .. [[ and ]] .. timefilter .. [[ and ]] .. namefilter .. [[ then
			tbl_icons._bn = _bn;
			tbl_icons._meta = _meta;
			tbl_icons._tex = _tex;
			tbl_icons._apps = _apps;
			tbl_icons._dispelt = _dispelt;
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
		__SetAuraIcon(_icons[_j], tbl_icons._meta, tbl_icons._tex, tbl_icons._apps, tbl_icons._dur, tbl_icons._tl, tbl_icons._dispelt, tbl_icons._i, nil, ]] .. smooth .. [[);
		_j = _j + 1;
	end
	
	while _j <= ]] .. desc.nIcons .. [[ do
		if _icons[_j]:IsShown() then _icons[_j]:Hide(]] .. smooth .. [[); end
		_j = _j + 1;
	end
end
]];

		local paintCodeWithoutSort = [[
if band(paintmask, ]] .. mask .. [[) ~= 0 then
	_i, _j, _bn, _tex, _apps, _meta, _dur, _tl, _dispelt, _caster, _isStealable = 1,1,nil,nil,nil,nil,nil,nil,nil,nil;
	_icons = frame.]] .. objname .. [[;
	while true do
		if (_j > ]] .. desc.nIcons .. [[) then break; end
		_, _bn, _, _, _meta, _, _tex, _apps, _dispelt, _dur, _, _tl, _caster, _isStealable = ]] .. loadCode .. [[(uid, _i, ]] .. raidfilter .. [[, ]] .. auracache .. [[);
		if not _meta then break; end
		if (not _meta.isInvisible) and ]] .. aurasfilter .. [[ and ]] .. isstealablefilter .. [[ and ]] .. curefilter .. [[ and ]] .. timefilter .. [[ and ]] .. namefilter .. [[ then
			btn = _icons[_j];
			if not btn:IsShown() then btn:Show(smooth); end
			btn.meta = _meta;
			btn.tex:SetTexture(_tex);
			if _dispelt and DebuffTypeColor[_dispelt] then
				if ]] .. usebs .. [[ then
					btn._texBorder:SetVertexColor(VFL.explodeColor(DebuffTypeColor[_dispelt]));
				elseif ]] .. usebkd .. [[ then
					btn:SetBackdropBorderColor(VFL.explodeRGBA(DebuffTypeColor[_dispelt]));
				end
			else
				if ]] .. usebs .. [[ then
					btn._texBorder:SetVertexColor(VFL.explodeRGBA(]] .. Serialize(bsdefault) .. [[));
				elseif ]] .. usebkd .. [[ then
					btn:SetBackdropBorderColor(]] .. r .. [[, ]] .. g .. [[, ]] .. b .. [[, ]] .. a .. [[);
				end
			end

			-- Cooldown
			if _dur and _dur > 0 and btn.cd then
				btn.cd:SetCooldown(GetTime() + _tl - _dur , _dur);
			else
				btn.cd:SetCooldown(0, 0);
			end
			if _apps and (_apps > 1) then btn.sttxt:SetText(_apps); else btn.sttxt:SetText(""); end
			
			_j = _j + 1;
		end
		_i = _i + 1;
	end
	while _j <= ]] .. desc.nIcons .. [[ do
		btn = _icons[_j];
		if btn:IsShown() then btn:Hide(]] .. smooth .. [[); end
		_j = _j + 1;
	end
end
]];
		if desc.test then
			state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCodeTest); end);
		elseif desc.sort then
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

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Aura Type"));
		local dd_auraType = VFLUI.Dropdown:new(er, RDXUI.AurasTypesDropdownFunction);
		dd_auraType:SetWidth(150); dd_auraType:Show();
		if desc and desc.auraType then 
			dd_auraType:SetSelection(desc.auraType); 
		else
			dd_auraType:SetSelection("BUFFS");
		end
		er:EmbedChild(dd_auraType); er:Show();
		ui:InsertFrame(er);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
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
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Button Skin parameters")));
		
		local chk_bs = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use Button Skin"));
		local dd_buttonSkin = VFLUI.Dropdown:new(chk_bs, VFLUI.GetButtonSkinList);
		dd_buttonSkin:SetWidth(150); dd_buttonSkin:Show();
		dd_buttonSkin:SetSelection(desc.externalButtonSkin); 
		if desc and desc.usebs then
			chk_bs:SetChecked(true);
		else
			chk_bs:SetChecked();
		end
		chk_bs:EmbedChild(dd_buttonSkin); chk_bs:Show();
		ui:InsertFrame(chk_bs);
		
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
		
		local chk_bkd = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use Backdrop"));
		local dd_backdrop = VFLUI.MakeBackdropSelectButton(chk_bkd, desc.bkd);
		dd_backdrop:Show();
		if desc and desc.usebkd then
			chk_bkd:SetChecked(true);
		else
			chk_bkd:SetChecked();
		end
		chk_bkd:EmbedChild(dd_backdrop); chk_bkd:Show();
		ui:InsertFrame(chk_bkd);
		
		-------------- CooldownDisplay
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown parameters")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Font parameters")));
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font stack"));
		local fontsel2 = VFLUI.MakeFontSelectButton(er_st, desc.fontst); fontsel2:Show();
		er_st:EmbedChild(fontsel2); er_st:Show();
		ui:InsertFrame(er_st);
		
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
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));

		local chk_raidfilter = VFLUI.Checkbox:new(ui); chk_raidfilter:Show();
		chk_raidfilter:SetText(VFLI.i18n("Use Blizzard raid filter"));
		if desc and desc.raidfilter then chk_raidfilter:SetChecked(true); else chk_raidfilter:SetChecked(); end
		ui:InsertFrame(chk_raidfilter);
		
		local chk_playerauras = VFLUI.Checkbox:new(ui); chk_playerauras:Show();
		chk_playerauras:SetText(VFLI.i18n("Filter auras by player"));
		if desc and desc.playerauras then chk_playerauras:SetChecked(true); else chk_playerauras:SetChecked(); end
		ui:InsertFrame(chk_playerauras);
		
		local chk_othersauras = VFLUI.Checkbox:new(ui); chk_othersauras:Show();
		chk_othersauras:SetText(VFLI.i18n("Filter auras by other players"));
		if desc and desc.othersauras then chk_othersauras:SetChecked(true); else chk_othersauras:SetChecked(); end
		ui:InsertFrame(chk_othersauras);

		local chk_petauras = VFLUI.Checkbox:new(ui); chk_petauras:Show();
		chk_petauras:SetText(VFLI.i18n("Filter auras by pet/vehicle"));
		if desc and desc.petauras then chk_petauras:SetChecked(true); else chk_petauras:SetChecked(); end
		ui:InsertFrame(chk_petauras);
		
		local chk_targetauras = VFLUI.Checkbox:new(ui); chk_targetauras:Show();
		chk_targetauras:SetText(VFLI.i18n("Filter auras by target"));
		if desc and desc.targetauras then chk_targetauras:SetChecked(true); else chk_targetauras:SetChecked(); end
		ui:InsertFrame(chk_targetauras);
		
		local chk_focusauras = VFLUI.Checkbox:new(ui); chk_focusauras:Show();
		chk_focusauras:SetText(VFLI.i18n("Filter auras by focus"));
		if desc and desc.focusauras then chk_focusauras:SetChecked(true); else chk_focusauras:SetChecked(); end
		ui:InsertFrame(chk_focusauras);
		
		local chk_nameauras = VFLUI.Checkbox:new(ui); chk_nameauras:Show();
		chk_nameauras:SetText(VFLI.i18n("Filter auras by name"));
		if desc and desc.nameauras then chk_nameauras:SetChecked(true); else chk_nameauras:SetChecked(); end
		ui:InsertFrame(chk_nameauras);
		
		local ed_unitfilter = VFLUI.LabeledEdit:new(ui, 200); ed_unitfilter:Show();
		ed_unitfilter:SetText(VFLI.i18n("Name of the unit"));
		if desc and desc.unitfilter then ed_unitfilter.editBox:SetText(desc.unitfilter); else ed_unitfilter.editBox:SetText(""); end
		ui:InsertFrame(ed_unitfilter);
		
		local chk_isStealable = VFLUI.Checkbox:new(ui); chk_isStealable:Show();
		chk_isStealable:SetText(VFLI.i18n("Show only Stealable auras"));
		if desc and desc.isstealablefilter then chk_isStealable:SetChecked(true); else chk_isStealable:SetChecked(); end
		ui:InsertFrame(chk_isStealable);
		
		local chk_curefilter = VFLUI.Checkbox:new(ui); chk_curefilter:Show();
		chk_curefilter:SetText(VFLI.i18n("Show only auras that I can cure"));
		if desc and desc.curefilter then chk_curefilter:SetChecked(true); else chk_curefilter:SetChecked(); end
		ui:InsertFrame(chk_curefilter);
		
		local chk_notimefilter = VFLUI.Checkbox:new(ui); chk_notimefilter:Show();
		chk_notimefilter:SetText(VFLI.i18n("Show only auras with no timer"));
		if desc and desc.notimefilter then chk_notimefilter:SetChecked(true); else chk_notimefilter:SetChecked(); end
		ui:InsertFrame(chk_notimefilter);
		
		local chk_timefilter = VFLUI.Checkbox:new(ui); chk_timefilter:Show();
		chk_timefilter:SetText(VFLI.i18n("Show only auras with timer"));
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
		chk_filterName:SetText(VFLI.i18n("Filter by aura name"));
		if desc and desc.filterName then chk_filterName:SetChecked(true); else chk_filterName:SetChecked(); end
		ui:InsertFrame(chk_filterName);

		local chk_external = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use external aura list"));
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
			local filterName, filterNameList, filternl, ext, unitfi, maxdurfil, mindurfil = nil, nil, {}, nil, "", "", "";
			if chk_bs:GetChecked() then chk_bkd:SetChecked(); end
			if chk_nameauras:GetChecked() then
				unitfi = string.lower(ed_unitfilter.editBox:GetText());
			end
			if chk_timefilter:GetChecked() then
				maxdurfil = ed_maxduration.editBox:GetText();
				mindurfil = ed_minduration.editBox:GetText();
				chk_notimefilter:SetChecked();
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
				feature = "aura_icons"; version = 1;
				name = ed_name.editBox:GetText();
				auraType = dd_auraType:GetSelection();
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
				usebs = chk_bs:GetChecked();
				externalButtonSkin = dd_buttonSkin:GetSelection();
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				showgloss = chk_showgloss:GetChecked();
				bsdefault = color_bsdefault:GetColor();
				usebkd = chk_bkd:GetChecked();
				bkd = dd_backdrop:GetSelectedBackdrop();
				-- cooldown
				cd = cd:GetSelectedCooldown();
				-- other
				fontst = fontsel2:GetSelectedFont();
				-- smooth
				smooth = chk_smooth:GetChecked();
				-- filter
				raidfilter = chk_raidfilter:GetChecked();
				playerauras = chk_playerauras:GetChecked();
				othersauras = chk_othersauras:GetChecked();
				petauras = chk_petauras:GetChecked();
				targetauras = chk_targetauras:GetChecked();
				focusauras = chk_focusauras:GetChecked();
				nameauras = chk_nameauras:GetChecked();
				unitfilter = unitfi;
				isstealablefilter = chk_isStealable:GetChecked();
				curefilter = chk_curefilter:GetChecked();
				notimefilter = chk_notimefilter:GetChecked();
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
			feature = "aura_icons";
			version = 1;
			name = "ai1";
			auraType = "BUFFS";
			owner = "decor";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			nIcons = 4; size = 20; rows = 1; orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			cd = VFL.copy(VFLUI.defaultCooldown);
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
		};
	end;
});


