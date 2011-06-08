-- ActionBars.lua
-- OpenRDX
-- Sigg Rashgarroth EU

-- Create function

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
	
	local hidebs = "nil"; if desc.hidebs then hidebs = "true"; end
	local showkey = "nil"; if desc.showkey then showkey = "true"; end
	local showtooltip = "nil"; if desc.showtooltip then showtooltip = "true"; end
	local anyup = "nil"; if desc.anyup then anyup = "true"; end
	local selfcast = "nil"; if desc.selfcast then selfcast = "true"; end
	local nRows = VFL.clamp(desc.rows, 1, 40);
	local useheader = "true"; if (not desc.headerstateType) or desc.headerstateType == "None" then useheader = "nil"; end
	local headerstate = "nil";
	if desc.headerstateType == "Custom" then 
		headerstate = desc.headerstateCustom;
	else
		headerstate = __RDXGetStates(desc.headerstateType);
	end
	if desc.headerstate then headerstate = desc.headerstate; end
	
	if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
	
	local createCode = [[
-- variables
local abid = ]] .. desc.abid .. [[;
local btnOwner = ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
-- Main variable frame.
frame.]] .. objname .. [[ = {};

-- parent frame
local h = nil;
if ]] .. useheader .. [[ then
	h = __RDXCreateHeaderHandlerAttribute("]] .. headerstate .. [[");
else
	h = VFLUI.AcquireFrame("Frame");
	h:Show();
end
VFLUI.StdSetParent(h, btnOwner);
h:SetFrameLevel(btnOwner:GetFrameLevel());
local dabid = nil;

-- Create buttons
for i=1, ]] .. desc.nIcons .. [[ do
	local btn = RDXUI.ActionButton:new(h, abid, ]] .. desc.size .. [[, ]] .. usebs .. [[, "]] .. ebs .. [[", ]] .. usebkd .. [[, ]] .. Serialize(bkd) .. [[, ]] .. os .. [[, ]] .. hidebs .. [[, "]] .. headerstate .. [[", ]] .. desc.nIcons .. [[, ]] .. Serialize(desc.cd) .. [[, ]] .. showkey .. [[, ]] .. showtooltip .. [[, ]] .. anyup .. [[, ]] .. selfcast .. [[);
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
-- { text = "Stealth"},
local _states = {
	{ text = "None"},
	{ text = "Defaultui"},
	{ text = "Actionbar"},
	{ text = "Stance"},
	{ text = "Shift"},
	{ text = "Ctrl"},
	{ text = "Alt"},
	{ text = "Custom"},
};
local function _dd_states() return _states; end

local _orientations = {
	{ text = "RIGHT"},
	{ text = "DOWN"},
};
local function _dd_orientations() return _orientations; end

RDX.RegisterFeature({
	name = "actionbar";
	version = 1;
	title = VFLI.i18n("Action Bar");
	category = VFLI.i18n("Buttons");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not desc.usebkd then desc.usebs = true; end
		if desc.headerstateType == "Custom" then
			local test = __RDXconvertStatesTable(desc.headerstateCustom);
			if #test == 0 then VFL.AddError(errs, VFLI.i18n("Custom definition invalid")); return nil; end 
		end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
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
		
		local ed_id = VFLUI.LabeledEdit:new(ui, 50); ed_id:Show();
		ed_id:SetText(VFLI.i18n("Begin Action Bar Buttons ID (1 - 120)"));
		if desc and desc.abid then ed_id.editBox:SetText(desc.abid); else ed_id.editBox:SetText("1"); end
		ui:InsertFrame(ed_id);
		
		local ed_nbar = VFLUI.LabeledEdit:new(ui, 50); ed_nbar:Show();
		ed_nbar:SetText(VFLI.i18n("Max Action Bar Buttons"));
		if desc and desc.nIcons then ed_nbar.editBox:SetText(desc.nIcons); end
		ui:InsertFrame(ed_nbar);
		
		local chk_anyup = VFLUI.Checkbox:new(ui); chk_anyup:Show();
		chk_anyup:SetText(VFLI.i18n("Click AnyUp"));
		if desc and desc.anyup then chk_anyup:SetChecked(true); else chk_anyup:SetChecked(); end
		ui:InsertFrame(chk_anyup);
		
		local chk_selfcast = VFLUI.Checkbox:new(ui); chk_selfcast:Show();
		chk_selfcast:SetText(VFLI.i18n("Right click self cast"));
		if desc and desc.selfcast then chk_selfcast:SetChecked(true); else chk_selfcast:SetChecked(); end
		ui:InsertFrame(chk_selfcast);
		
		-------------- State
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("States")));
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("States type:"));
		local _dd_states = VFLUI.Dropdown:new(er, _dd_states);
		_dd_states:SetWidth(100); _dd_states:Show();
		if desc and desc.headerstateType then 
			_dd_states:SetSelection(desc.headerstateType); 
		else
			_dd_states:SetSelection("None");
		end
		er:EmbedChild(_dd_states); er:Show();
		ui:InsertFrame(er);
		
		local ed_custom = VFLUI.LabeledEdit:new(ui, 300); ed_custom:Show();
		ed_custom:SetText(VFLI.i18n("Custom definition"));
		if desc and desc.headerstateCustom then 
			ed_custom.editBox:SetText(desc.headerstateCustom);
		else
			_dd_states:SetSelection("");
		end
		ui:InsertFrame(ed_custom);
		
		local stxt = VFLUI.SimpleText:new(ui, 1, 200); stxt:Show();
		local str = "Current State:\n";
		if desc.headerstateType ~= "Custom" then
			str = str .. __RDXGetStates(desc.headerstateType);
		else 
			str = str .. desc.headerstateCustom;
		end
		
		stxt:SetText(str);
		ui:InsertFrame(stxt);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout")));
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local ed_rows = VFLUI.LabeledEdit:new(ui, 50); ed_rows:Show();
		ed_rows:SetText(VFLI.i18n("Row size"));
		if desc and desc.rows then ed_rows.editBox:SetText(desc.rows); end
		ui:InsertFrame(ed_rows);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation:"));
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
		ed_iconspx:SetText(VFLI.i18n("Action Bar Buttons spacing width"));
		if desc and desc.iconspx then ed_iconspx.editBox:SetText(desc.iconspx); else ed_iconspx.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspx);
		
		local ed_iconspy = VFLUI.LabeledEdit:new(ui, 50); ed_iconspy:Show();
		ed_iconspy:SetText(VFLI.i18n("Action Bar Buttons spacing height"));
		if desc and desc.iconspy then ed_iconspy.editBox:SetText(desc.iconspy); else ed_iconspy.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspy);
		
		local ed_size = VFLUI.LabeledEdit:new(ui, 50); ed_size:Show();
		ed_size:SetText(VFLI.i18n("Action Bar Buttons Size"));
		if desc and desc.size then ed_size.editBox:SetText(desc.size); end
		ui:InsertFrame(ed_size);
		
		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Display")));
		
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
		ed_bs:SetText(VFLI.i18n("Button Skin Size Offset :"));
		if desc and desc.ButtonSkinOffset then ed_bs.editBox:SetText(desc.ButtonSkinOffset); end
		ui:InsertFrame(ed_bs);
		
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
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown :"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);
		
		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Display")));
		
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
		chk_showtooltip:SetText(VFLI.i18n("Show Tooltip"));
		if desc and desc.showtooltip then chk_showtooltip:SetChecked(true); else chk_showtooltip:SetChecked(); end
		ui:InsertFrame(chk_showtooltip);
		
		-------------- END
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("End")));
		
		function ui:GetDescriptor()
			if chk_bs:GetChecked() then chk_bkd:SetChecked(); end
			return { 
				feature = "actionbar"; version = 1;
				name = ed_name.editBox:GetText();
				abid = VFL.clamp(ed_id.editBox:GetNumber(), 1, 120);
				nIcons = VFL.clamp(ed_nbar.editBox:GetNumber(), 1, 40);
				anyup = chk_anyup:GetChecked();
				selfcast = chk_selfcast:GetChecked();
				--States
				headerstateType = _dd_states:GetSelection();
				headerstateCustom = ed_custom.editBox:GetText();
				-- layout
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				rows = VFL.clamp(ed_rows.editBox:GetNumber(), 1, 40);
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), -20, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), -20, 200);
				size = VFL.clamp(ed_size.editBox:GetNumber(), 20, 100);
				-- display
				usebs = chk_bs:GetChecked();
				externalButtonSkin = dd_buttonSkin:GetSelection();
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				usebkd = chk_bkd:GetChecked();
				bkd = dd_backdrop:GetSelectedBackdrop();
				hidebs = chk_hidebs:GetChecked();
				-- Cooldown
				cd = cd:GetSelectedCooldown();
				cdTimerType = nil;
				cdGfxReverse = nil;
				cdHideTxt = nil;
				cdFont = nil;
				cdTxtType = nil;
				cdoffx = nil;
				cdoffy = nil;
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
			abid = 1;
			headerstateType = "None";
			headerstateCustom = "";
			owner = "decor";
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

