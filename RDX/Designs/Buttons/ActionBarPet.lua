-- ActionBarPet.lua
-- OpenRDX
-- Sigg Rashgarroth EU

-- Create function

local function _EmitCreateCode(objname, desc)
	local flo = tonumber(desc.flo); if not flo then flo = 5; end; flo = VFL.clamp(flo,1,10);
	
	local useheader = "true"; if desc.headervisType == "None" then useheader = "nil"; end
	local headervis = "nil";
	if desc.headervisiType == "Custom" then
		headervis = "'" .. desc.headervisiCustom .. "'";
	elseif desc.headervisiType ~= "None" then
		headervis = "'" .. __RDXGetOtherVisi(desc.headervisiType) .. "'";
	end
	
	local createCode = [[
-- variables
local abid = ]] .. desc.abid .. [[;
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
-- Main variable frame.
frame.]] .. objname .. [[ = {};

-- parent frame
]];
if desc.test then
	createCode = createCode .. [[
local h = VFLUI.AcquireFrame("Frame");
h:Show();
]];
else
	createCode = createCode .. [[
local h = nil;
if ]] .. useheader .. [[ then
	h = __RDXCreateHeaderHandlerBase(]] .. headervis .. [[);
else
	h = VFLUI.AcquireFrame("Frame");
	h:Show();
end
]];
end
	createCode = createCode .. [[
VFLUI.StdSetParent(h, btnOwner);
h:SetFrameLevel(btnOwner:GetFrameLevel() + ]] .. flo .. [[);

local dabid = false;

-- Create buttons
for i=1, ]] .. desc.nIcons .. [[ do
]];
if desc.test then
	createCode = createCode .. [[
	btn = RDXUI.ActionButtonTest:new(h, abid, nil, ]] .. Serialize(desc) .. [[);
]];
else
	createCode = createCode .. [[
	btn = RDXUI.PetActionButton:new(h, abid, nil, ]] .. Serialize(desc) .. [[);
]];
end	
	createCode = createCode .. [[
	if btn then
		btn:Show();
]];
		createCode = createCode .. VFLUI.GenerateSetFontCode("btn.txtHotkey", desc.fontkey, nil, true);
		createCode = createCode .. [[
		if btn.Init then btn:Init(); end
		frame.]] .. objname .. [[[i] = btn;
		abid = abid + 1;
	else
		dabid = true;
	end
end

frame.]] .. objname .. [[header = h;

if dabid then
	--RDX.printW("Pet Button ".. abid .." already used, See feature ]] .. desc.name ..[[");
else
]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	createCode = createCode .. [[
end
]];
	return createCode;
end

local _orientations = {
	{ text = "RIGHT"},
	{ text = "DOWN"},
};
local function _dd_orientations() return _orientations; end

RDX.RegisterFeature({
	name = "actionbarpet"; version = 1; 
	title = VFLI.i18n("Bar Action Buttons Pet"); 
	test = true; 
	category = VFLI.i18n("Buttons");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		desc.owner = "Base";
		
		if not desc.flo then desc.flo = 5; end
		if not desc.usebkd then desc.usebs = true; end
		if not desc.externalButtonSkin then desc.externalButtonSkin = "bs_default"; end
		if not desc.bsdefault then desc.bsdefault = VFL.copy(_white); end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop); end
		if not desc.flyoutdirection then desc.flyoutdirection = "UP"; end
		if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
		
		if not desc.headervisiType or desc.headervisiType == "Default" then desc.headervisiType = "Pet"; end
		
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		--flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		if not VFLUI.isFacePathExist(desc.fontkey.face) then desc.fontkey = VFL.copy(Fonts.Default); end
		local objname = "Bar_" .. desc.name;
		
		------------------ On frame creation
		local createCode = _EmitCreateCode(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);
		
		------------------ On frame destruction.
		local destroyCode = [[
local btn = nil;
for i=1, ]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i];
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
		
		local chk_anyup = VFLUI.Checkbox:new(ui); chk_anyup:Show();
		chk_anyup:SetText(VFLI.i18n("Click AnyUp"));
		if desc and desc.anyup then chk_anyup:SetChecked(true); else chk_anyup:SetChecked(); end
		ui:InsertFrame(chk_anyup);
		
		------------- Visibility
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Visibility parameters")));
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Visibility type"));
		
		local dd_visi = VFLUI.Dropdown:new(er, __RDX_dd_visi);
		dd_visi:SetWidth(100); dd_visi:Show();
		if desc and desc.headervisiType then 
			dd_visi:SetSelection(desc.headervisiType); 
		else
			dd_visi:SetSelection("Default");
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
			str = str .. __RDXGetOtherVisi(desc.headervisiType);
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
		
		--local chk_showkey = VFLUI.Checkbox:new(ui); chk_showkey:Show();
		--chk_showkey:SetText(VFLI.i18n("Show Key Binding"));
		--if desc and desc.showkey then chk_showkey:SetChecked(true); else chk_showkey:SetChecked(); end
		--ui:InsertFrame(chk_showkey);
		
		local chk_showtooltip = VFLUI.Checkbox:new(ui); chk_showtooltip:Show();
		chk_showtooltip:SetText(VFLI.i18n("Show GameTooltip"));
		if desc and desc.showtooltip then chk_showtooltip:SetChecked(true); else chk_showtooltip:SetChecked(); end
		ui:InsertFrame(chk_showtooltip);
		
		------------- Shader
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Shader Border or Key")));
		
		local chk_useshaderkey = VFLUI.Checkbox:new(ui); chk_useshaderkey:Show();
		chk_useshaderkey:SetText(VFLI.i18n("Use Shader Key"));
		if desc and desc.useshaderkey then chk_useshaderkey:SetChecked(true); else chk_useshaderkey:SetChecked(); end
		ui:InsertFrame(chk_useshaderkey);
		
		function ui:GetDescriptor()
			if chk_bs:GetChecked() then chk_bkd:SetChecked(); end
			return { 
				feature = "actionbarpet"; version = 1;
				name = ed_name.editBox:GetText();
				abid = 1;
				nIcons = 10;
				anyup = chk_anyup:GetChecked();
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
				size = VFL.clamp(ed_size.editBox:GetNumber(), 10, 100);
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
				cdTimerType = nil;
				cdGfxReverse = nil;
				cdHideTxt = nil;
				cdFont = nil;
				cdTxtType = nil;
				cdoffx = nil;
				cdoffy = nil;
				-- Display
				fontkey = fontkey:GetSelectedFont();
				--showkey = chk_showkey:GetChecked();
				showtooltip = chk_showtooltip:GetChecked();
				useshaderkey = chk_useshaderkey:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		local fontk = VFL.copy(Fonts.Default); fontk.size = 8; fontk.justifyV = "TOP"; fontk.justifyH = "RIGHT";
		return { 
			feature = "actionbarpet";
			version = 1; 
			name = "actionbarpet", 
			abid = 1;
			headervisiType = "Pet";
			headervisiCustom = "";
			owner = "Base";
			flo = 5;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			nIcons = 10; size = 36; rows = 1; orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			externalButtonSkin = "bs_default";
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			ButtonSkinOffset = 0;
			fontkey = fontk;
			cd = VFL.copy(VFLUI.defaultCooldown);
			--showkey = true;
			showtooltip = true;
		};
	end;
});

