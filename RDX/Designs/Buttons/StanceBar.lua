-- ActionBars.lua
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
local abid = 1;
local btnOwner = ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
-- Main variable frame.
frame.]] .. objname .. [[ = {};

-- parent frame
local h = nil;
if ]] .. useheader .. [[ then
	h = __RDXCreateHeaderHandlerBase(]] .. headervis .. [[);
else
	h = VFLUI.AcquireFrame("Frame");
	h:Show();
end
VFLUI.StdSetParent(h, btnOwner);
h:SetFrameLevel(btnOwner:GetFrameLevel() + ]] .. flo .. [[);

local dabid = false;

-- Create buttons
for i=1, ]] .. desc.nIcons .. [[ do
]];
if desc.test then
	createCode = createCode .. [[
	local btn = RDXUI.ActionButtonTest:new(h, abid, ]] .. useheader .. [[, ]] .. Serialize(desc) .. [[);
]];
else
	createCode = createCode .. [[
	local btn = RDXUI.StanceButton:new(h, abid, ]] .. useheader .. [[, ]] .. Serialize(desc) .. [[);
]];
end	
	createCode = createCode .. [[
	if btn then
]];
		createCode = createCode .. VFLUI.GenerateSetFontCode("btn.txtHotkey", desc.fontkey, nil, true);
		createCode = createCode .. [[
		if btn.Init then btn:Init(); end
		--btn:Show();
		frame.]] .. objname .. [[[i] = btn;
		abid = abid + 1;
	else
		dabid = true;
	end
end

frame.]] .. objname .. [[header = h;

]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	createCode = createCode .. [[
if dabid then
	--RDX.printW("Stance Button already used, See feature ]] .. desc.name ..[[");
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
	name = "stancebar";
	version = 1;
	title = VFLI.i18n("Bar Stance");
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
		desc.nIcons = 8;
		if not desc.flo then desc.flo = 5; end
		
		if not desc.externalButtonSkin then desc.externalButtonSkin = "bs_default"; end
		if not desc.bsdefault then desc.bsdefault = VFL.copy(_white); end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop); end
		if not desc.flyoutdirection then desc.flyoutdirection = "UP"; end
		if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
		
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
	btn = frame.]] .. objname .. [[[i]
	if btn then 
		btn:ClearAllPoints();
		btn:Hide(); btn:Destroy(); btn = nil; 
	end
end

frame.]] .. objname .. [[header:Hide();
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

		------------- Visibility
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Visibility parameters")));
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Visibility type"));
		
		local dd_visi = VFLUI.Dropdown:new(er, __RDX_dd_visi);
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
				feature = "stancebar"; version = 1;
				name = ed_name.editBox:GetText();
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
				-- display
				driver = driver:GetValue();
				externalButtonSkin = dd_buttonSkin:GetSelection();
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				showgloss = chk_showgloss:GetChecked();
				bsdefault = color_bsdefault:GetColor();
				bkd = dd_backdrop:GetSelectedBackdrop();
				bordersize = VFL.clamp(ed_borsize.editBox:GetNumber(), 0, 50);
				-- Cooldown
				cd = cd:GetSelectedCooldown();
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
			feature = "stancebar";
			version = 1; 
			name = "stancebar";
			headervisiType = "None";
			headervisiCustom = "";
			owner = "Base";
			flo = 5;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			size = 36; rows = 1; orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			drawLayer = "ARTWORK";
			fontkey = fontk;
			cd = VFL.copy(VFLUI.defaultCooldown);
			--showkey = true;
			showtooltip = true;
		};
	end;
});

