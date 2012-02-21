-- ActionBars.lua
-- OpenRDX
-- Sigg Rashgarroth EU

local _states = {
	{ text = "None"},
	{ text = "Defaultui"},
	{ text = "Actionbar"},
	{ text = "Stance"},
	{ text = "Shift"},
	{ text = "Ctrl"},
	{ text = "Alt"},
	--{ text = "Stealth"},
	{ text = "Custom"},
};
local function _dd_states() return _states; end

local _visi = {
	{ text = "None"},
	{ text = "InCombat"},
	{ text = "InStealth"},
	{ text = "InForm3"},
	{ text = "Custom"},
};
local function _dd_visi() return _visi; end

local _bars = {
	{ text = "mainbar1"}, --  1 to 12
	{ text = "mainbar2"}, -- 13 to 24
	{ text = "bar3"},  -- 25 to 36
	{ text = "bar4"}, -- 37 to 48
	{ text = "bar5"}, -- 49 to 60
	{ text = "bar6_druid_stealth"}, -- 61 to 72
	{ text = "bonusbar1"}, -- 73 to 84
	{ text = "bonusbar2"}, -- 85 to 96
	{ text = "bonusbar3"}, -- 97 to 108
	{ text = "bonusbar4"}, -- 109 to 120
	{ text = "possessbar"}, -- 121 to 132
	--{ text = "multibar"}, -- 133 to 144 -- see multibar specific feature
};
local function _dd_bars() return _bars; end

local baridToNum = {};
baridToNum["mainbar1"] = 1;
baridToNum["mainbar2"] = 13;
baridToNum["bar3"] = 25;
baridToNum["bar4"] = 37;
baridToNum["bar5"] = 49;
baridToNum["bar6_druid_stealth"] = 61;
baridToNum["bonusbar1"] = 73;
baridToNum["bonusbar2"] = 85;
baridToNum["bonusbar3"] = 97;
baridToNum["bonusbar4"] = 109;
baridToNum["possessbar"] = 121;

local function GetBarNumber(barid)
	if not barid then return 109; end
	return baridToNum[barid] or 109;
end

local numToBarid = VFL.invert(baridToNum);

local function GetBarId(num)
	if not num then return "bonusbar4"; end
	return numToBarid[num] or "bonusbar4";
end

local _orientations = {
	{ text = "RIGHT"},
	{ text = "DOWN"},
};
local function _dd_orientations() return _orientations; end

-- Create function

local function _EmitCreateCode(objname, desc)
	local flo = tonumber(desc.flo); if not flo then flo = 5; end; flo = VFL.clamp(flo,1,10);
	
	--local usebs = "false"; if desc.usebs then usebs = "true"; end
	--local ebs = desc.externalButtonSkin or "bs_default";
	--local usebkd = "false"; if desc.usebkd then usebkd = "true"; end
	--local bkd = desc.bkd or VFLUI.defaultBackdrop;	
	--local os = 0; 
	--if desc.usebs then 
	--	os = desc.ButtonSkinOffset or 0;
	--elseif desc.usebkd then
	--	if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
	--end
	
	--local showgloss = "nil"; if desc.showgloss then showgloss = "true"; end
	--local bsdefault = desc.bsdefault or _white;
	
	
	local abid = GetBarNumber(desc.barid);
	
	--local hidebs = "nil"; if desc.hidebs then hidebs = "true"; end
	--local showkey = "nil"; if desc.showkey then showkey = "true"; end
	--local showtooltip = "nil"; if desc.showtooltip then showtooltip = "true"; end
	--local anyup = "nil"; if desc.anyup then anyup = "true"; end
	--local selfcast = "nil"; if desc.selfcast then selfcast = "true"; end
	
	local useheader = "true";
	if desc.headerstateType == "None" and desc.headervisType == "None" then useheader = "nil"; end
	local headerstate = "nil";
	if desc.headerstateType == "Custom" then
		headerstate = "'" .. desc.headerstateCustom .. "'";
	elseif desc.headerstateType ~= "None" then
		headerstate = "'" .. __RDXGetStates(desc.headerstateType) .. "'";
	end
	
	local headervis = "nil";
	if desc.headervisiType == "Custom" then
		headervis = "'" .. desc.headervisiCustom .. "'";
	elseif desc.headervisiType ~= "None" then
		headervis = "'" .. __RDXGetVisi(desc.headervisiType) .. "'";
	end

	local createCode = [[
-- variables
local abid = ]] .. abid .. [[;
local btnOwner = ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
-- Main variable frame.
frame.]] .. objname .. [[ = {};

-- parent frame
local h = nil;
if ]] .. useheader .. [[ then
	h = __RDXCreateHeaderHandlerAttribute(]] .. headerstate .. [[, ]] .. headervis .. [[);
else
	h = VFLUI.AcquireFrame("Frame");
	h:Show();
end
VFLUI.StdSetParent(h, btnOwner);
h:SetFrameLevel(btnOwner:GetFrameLevel() + ]] .. flo .. [[);
local dabid = nil;

-- Create buttons
for i=1, ]] .. desc.nIcons .. [[ do
	local btn = RDXUI.ActionButton:new(h, abid, "]] .. headerstate .. [[", ]] .. Serialize(desc) .. [[);
]];
		createCode = createCode .. VFLUI.GenerateSetFontCode("btn.txtCount", desc.fontcount, nil, true);
		createCode = createCode .. VFLUI.GenerateSetFontCode("btn.txtMacro", desc.fontmacro, nil, true);
		createCode = createCode .. VFLUI.GenerateSetFontCode("btn.txtHotkey", desc.fontkey, nil, true);
		createCode = createCode .. [[
	if not btn.error then
		if btn.Init then btn:Init(); end
	else
		dabid = abid;
	end
	btn:Show();
	frame.]] .. objname .. [[[i] = btn;
	abid = abid + 1;
end

frame.]] .. objname .. [[header = h;

]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	createCode = createCode .. [[
if dabid then
	--RDX.printE("Action Button ".. dabid .." already used");
end
]];
	return createCode;
end

RDX.RegisterFeature({
	name = "actionbar";
	version = 1;
	title = VFLI.i18n("Bar Action Buttons");
	category = VFLI.i18n("Buttons");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		desc.owner = "Base";
		desc.nIcons = 12;
		if not desc.barid then 
			if desc.abid then desc.barid = GetBarId(desc.abid); desc.abid = nil; end
		end
		
		if not desc.flo then desc.flo = 5; end
		if not desc.usebkd then desc.usebs = true; end
		if not desc.externalButtonSkin then desc.externalButtonSkin = "bs_default"; end
		if not desc.bsdefault then desc.bsdefault = VFL.copy(_white); end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop);
		if not desc.flyoutdirection then desc.flyoutdirection = "UP"; end
		if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
		
		if not desc.headerstateType then desc.headerstateType = "None"; end
		if desc.headerstateType == "Custom" then
			local test = __RDXconvertStatesTable(desc.headerstateCustom);
			if #test == 0 then VFL.AddError(errs, VFLI.i18n("Invalid custom definition")); return nil; end 
		end
		if not desc.headervisType then desc.headervisType = "None"; end
		
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		--flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		if not VFLUI.isFacePathExist(desc.fontkey.face) then desc.fontkey = VFL.copy(Fonts.Default); end
		if not VFLUI.isFacePathExist(desc.fontmacro.face) then desc.fontmacro = VFL.copy(Fonts.Default); end
		if not VFLUI.isFacePathExist(desc.fontcount.face) then desc.fontcount = VFL.copy(Fonts.Default); end		
		local objname = "Bar_" .. desc.name;
		
		local useheader = "true"; if (not desc.headerstateType) or desc.headerstateType == "None" then useheader = "nil"; end

		------------------ On frame creation
		local createCode = _EmitCreateCode(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);
		
		------------------ On frame destruction.
		local destroyCode = [[
for i=1, ]] .. desc.nIcons .. [[ do
	local btn = frame.]] .. objname .. [[[i];
	if btn then btn:ClearAllPoints(); btn:Hide(); btn:Destroy(); btn = nil; end
end
frame.]] .. objname .. [[header:Destroy();
frame.]] .. objname .. [[header = nil;
frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

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
		
		--local ed_id = VFLUI.LabeledEdit:new(ui, 50); ed_id:Show();
		--ed_id:SetText(VFLI.i18n("Begin Action Bar Buttons ID (1 - 120)"));
		--if desc and desc.abid then ed_id.editBox:SetText(desc.abid); else ed_id.editBox:SetText("1"); end
		--ui:InsertFrame(ed_id);
		
		--local ed_nbar = VFLUI.LabeledEdit:new(ui, 50); ed_nbar:Show();
		--ed_nbar:SetText(VFLI.i18n("Max Action Bar Buttons"));
		--if desc and desc.nIcons then ed_nbar.editBox:SetText(desc.nIcons); end
		--ui:InsertFrame(ed_nbar);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Bar id"));
		local dd_bars = VFLUI.Dropdown:new(er, _dd_bars);
		dd_bars:SetWidth(200); dd_bars:Show();
		if desc and desc.barid then 
			dd_bars:SetSelection(desc.barid); 
		else
			dd_bars:SetSelection("mainbar1");
		end
		er:EmbedChild(dd_bars); er:Show();
		ui:InsertFrame(er);
		
		local chk_anyup = VFLUI.Checkbox:new(ui); chk_anyup:Show();
		chk_anyup:SetText(VFLI.i18n("Click AnyUp"));
		if desc and desc.anyup then chk_anyup:SetChecked(true); else chk_anyup:SetChecked(); end
		ui:InsertFrame(chk_anyup);
		
		local chk_selfcast = VFLUI.Checkbox:new(ui); chk_selfcast:Show();
		chk_selfcast:SetText(VFLI.i18n("Right click self cast"));
		if desc and desc.selfcast then chk_selfcast:SetChecked(true); else chk_selfcast:SetChecked(); end
		ui:InsertFrame(chk_selfcast);
		
		-------------- State
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("States parameters")));
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("States type"));
		local dd_states = VFLUI.Dropdown:new(er, _dd_states);
		dd_states:SetWidth(100); dd_states:Show();
		if desc and desc.headerstateType then 
			dd_states:SetSelection(desc.headerstateType); 
		else
			dd_states:SetSelection("None");
		end
		er:EmbedChild(dd_states); er:Show();
		ui:InsertFrame(er);
		
		local ed_custom = VFLUI.LabeledEdit:new(ui, 300); ed_custom:Show();
		ed_custom:SetText(VFLI.i18n("Custom definition"));
		if desc and desc.headerstateCustom then 
			ed_custom.editBox:SetText(desc.headerstateCustom);
		else
			dd_states:SetSelection("");
		end
		ui:InsertFrame(ed_custom);
		
		local stxt = VFLUI.SimpleText:new(ui, 2, 200); stxt:Show();
		local str = "Current State\n";
		if desc.headerstateType ~= "Custom" then
			str = str .. __RDXGetStates(desc.headerstateType);
		else 
			str = str .. desc.headerstateCustom;
		end
		
		stxt:SetText(str);
		ui:InsertFrame(stxt);
		
		------------- Visibility
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Visibility parameters")));
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Visibility type"));
		
		local dd_visi = VFLUI.Dropdown:new(er, _dd_visi);
		dd_visi:SetWidth(100); dd_visi:Show();
		if desc and desc.headervisiType then 
			dd_visi:SetSelection(desc.headervisiType); 
		else
			dd_visi:SetSelection("None");
		end
		er:EmbedChild(dd_visi); er:Show();
		ui:InsertFrame(er);
		
		local ed_visicustom = VFLUI.LabeledEdit:new(ui, 300); ed_visicustom:Show();
		ed_visicustom:SetText(VFLI.i18n("Custom definition"));
		if desc and desc.headervisiCustom then 
			ed_visicustom.editBox:SetText(desc.headervisiCustom);
		else
			ed_visicustom.editBox:SetText("");
		end
		ui:InsertFrame(ed_visicustom);
		
		local visistxt = VFLUI.SimpleText:new(ui, 2, 200); visistxt:Show();
		local str = "Current Visibility\n";
		if desc.headerstateType ~= "Custom" then
			str = str .. __RDXGetVisi(desc.headervisiType);
		else 
			str = str .. desc.headerstateCustom;
		end
		
		visistxt:SetText(str);
		ui:InsertFrame(visistxt);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));
		
		--local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		--if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local ed_flo = VFLUI.LabeledEdit:new(ui, 50); ed_flo:Show();
		ed_flo:SetText(VFLI.i18n("FrameLevel offset"));
		if desc and desc.flo then ed_flo.editBox:SetText(desc.flo); else ed_flo.editBox:SetText(5); end
		ui:InsertFrame(ed_flo);

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local ed_rows = VFLUI.LabeledEdit:new(ui, 50); ed_rows:Show();
		ed_rows:SetText(VFLI.i18n("Row number"));
		if desc and desc.rows then ed_rows.editBox:SetText(desc.rows); end
		ui:InsertFrame(ed_rows);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation"));
		local dd_orientation = VFLUI.Dropdown:new(er, _dd_orientations);
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
		ed_size:SetText(VFLI.i18n("Buttons Size"));
		if desc and desc.size then ed_size.editBox:SetText(desc.size); end
		ui:InsertFrame(ed_size);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Flyout"));
		local dd_flyoutdirection = VFLUI.Dropdown:new(er, RDXUI.OrientationDropdownFunction);
		dd_flyoutdirection:SetWidth(75); dd_flyoutdirection:Show();
		if desc and desc.flyoutdirection then 
			dd_flyoutdirection:SetSelection(desc.flyoutdirection); 
		else
			dd_flyoutdirection:SetSelection("UP");
		end
		er:EmbedChild(dd_flyoutdirection); er:Show();
		ui:InsertFrame(er);
		
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
		
		local chk_hidebs = VFLUI.Checkbox:new(ui); chk_hidebs:Show();
		chk_hidebs:SetText(VFLI.i18n("Hide empty button"));
		if desc and desc.hidebs then chk_hidebs:SetChecked(true); else chk_hidebs:SetChecked(); end
		ui:InsertFrame(chk_hidebs);
		
		-------------- COOLDOWN
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown parameters")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);
		
		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Display parameters")));
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font Key"));
		local fontkey = VFLUI.MakeFontSelectButton(er_st, desc.fontkey); fontkey:Show();
		er_st:EmbedChild(fontkey); er_st:Show();
		ui:InsertFrame(er_st);
		
		local chk_showkey = VFLUI.Checkbox:new(ui); chk_showkey:Show();
		chk_showkey:SetText(VFLI.i18n("Show Key Binding"));
		if desc and desc.showkey then chk_showkey:SetChecked(true); else chk_showkey:SetChecked(); end
		ui:InsertFrame(chk_showkey);
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font Macro"));
		local fontmacro = VFLUI.MakeFontSelectButton(er_st, desc.fontmacro); fontmacro:Show();
		er_st:EmbedChild(fontmacro); er_st:Show();
		ui:InsertFrame(er_st);
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font Count"));
		local fontcount = VFLUI.MakeFontSelectButton(er_st, desc.fontcount); fontcount:Show();
		er_st:EmbedChild(fontcount); er_st:Show();
		ui:InsertFrame(er_st);
		
		local chk_showtooltip = VFLUI.Checkbox:new(ui); chk_showtooltip:Show();
		chk_showtooltip:SetText(VFLI.i18n("Show GameTooltip"));
		if desc and desc.showtooltip then chk_showtooltip:SetChecked(true); else chk_showtooltip:SetChecked(); end
		ui:InsertFrame(chk_showtooltip);
		
		function ui:GetDescriptor()
			if chk_bs:GetChecked() then chk_bkd:SetChecked(); end
			return { 
				feature = "actionbar"; version = 1;
				name = ed_name.editBox:GetText();
				--abid = VFL.clamp(ed_id.editBox:GetNumber(), 1, 120);
				barid = dd_bars:GetSelection();
				nIcons = 12;
				anyup = chk_anyup:GetChecked();
				selfcast = chk_selfcast:GetChecked();
				--States
				headerstateType = dd_states:GetSelection();
				headerstateCustom = ed_custom.editBox:GetText();
				--Visibility
				headervisiType = dd_visi:GetSelection();
				headervisiCustom = ed_visicustom.editBox:GetText();
				-- layout
				--owner = owner:GetSelection();
				owner = "Base";
				flo = VFL.clamp(ed_flo.editBox:GetNumber(), 1, 10);
				anchor = anchor:GetAnchorInfo();
				rows = VFL.clamp(ed_rows.editBox:GetNumber(), 1, 40);
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), -20, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), -20, 200);
				size = VFL.clamp(ed_size.editBox:GetNumber(), 20, 100);
				flyoutdirection = dd_flyoutdirection:GetSelection();
				-- display
				usebs = chk_bs:GetChecked();
				externalButtonSkin = dd_buttonSkin:GetSelection();
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				showgloss = chk_showgloss:GetChecked();
				bsdefault = color_bsdefault:GetColor();
				usebkd = chk_bkd:GetChecked();
				bkd = dd_backdrop:GetSelectedBackdrop();
				hidebs = chk_hidebs:GetChecked();
				-- Cooldown
				cd = cd:GetSelectedCooldown();
				-- Display
				fontkey = fontkey:GetSelectedFont();
				showkey = chk_showkey:GetChecked();
				fontmacro = fontmacro:GetSelectedFont();
				fontcount = fontcount:GetSelectedFont();
				showtooltip = chk_showtooltip:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		local fontk = VFL.copy(Fonts.Default); fontk.size = 8; fontk.justifyV = "TOP"; fontk.justifyH = "RIGHT";
		local fontm = VFL.copy(Fonts.Default); fontm.size = 8; fontm.justifyV = "BOTTOM"; fontm.justifyH = "CENTER";
		local fontc = VFL.copy(Fonts.Default); fontc.size = 8; fontc.justifyV = "BOTTOM"; fontc.justifyH = "RIGHT";
		return { 
			feature = "actionbar";
			version = 1; 
			name = "barbut2", 
			barid = "mainbar1";
			headerstateType = "None";
			headerstateCustom = "";
			headervisiType = "None";
			headervisiCustom = "";
			owner = "Base";
			flyoutdirection = "UP";
			flo = 5;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			nIcons = 12; size = 36; rows = 1; orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			externalButtonSkin = "bs_default";
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			ButtonSkinOffset = 0;
			fontkey = fontk;
			fontmacro = fontm;
			fontcount = fontc;
			cd = VFL.copy(VFLUI.defaultCooldown);
			showkey = true;
			showtooltip = true;
		};
	end;
});

