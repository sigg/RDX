-- CustomIconList.lua
-- OpenRDX
-- Sigg

RDX.RegisterFeature({
	name = "custom_icons";
	version = 1;
	title = VFLI.i18n("Icons Custom");
	category = VFLI.i18n("Lists");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.usebkd then desc.usebs = true; end
		if (not desc.number) or (not state:Slot("NumberVar_" .. desc.number)) then
			VFL.AddError(errs, VFLI.i18n("Invalid number object pointer")); return nil;
		end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Icons_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		
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
		
		if not desc.w then desc.w = 20; end
		if not desc.h then desc.h = 20; end
		
		-- required for RDXUI.LayoutCodeMultiRows
		desc.nIcons = 5;
		desc.rows = 1
------------ Closure
		local closureCode = [[
local color]] .. objname .. [[ = {};
color]] .. objname .. [[[1] = ]] .. Serialize(desc.color1) .. [[;
color]] .. objname .. [[[2] = ]] .. Serialize(desc.color2) .. [[;
color]] .. objname .. [[[3] = ]] .. Serialize(desc.color3) .. [[;
color]] .. objname .. [[[4] = ]] .. Serialize(desc.color4) .. [[;
color]] .. objname .. [[[5] = ]] .. Serialize(desc.color5) .. [[;
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);
		
		----------------- Creation
		local createCode = [[
frame.]] .. objname .. [[ = {};
btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
for i=1,]] .. desc.nIcons .. [[ do
	if ]] .. driver .. [[ == 1 then 
		btn = VFLUI.SkinButton:new();
		btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
		btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, ]] .. showgloss ..[[);
	elseif ]] .. driver .. [[ == 2 then
		btn = VFLUI.AcquireFrame("Button");
		btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
		VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
	elseif ]] .. driver .. [[ == 3 then
		btn = VFLUI.AcquireFrame("Button");
		btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
		VFLUI.SetBackdropBorderRDX(btn, _black, "ARTWORK", 7, ]] .. bordersize .. [[);
	end
	btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
	btn.tex = VFLUI.CreateTexture(btn);
	btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. os .. [[, -]] .. os .. [[);
	btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. os .. [[, ]] .. os .. [[);
	if not RDXG.usecleanicons then
		btn.tex:SetTexCoord(0.05, 1-0.06, 0.05, 1-0.04);
	end
	btn.tex:SetDrawLayer("ARTWORK", 2);
	btn.tex:Show();
]];	
	if desc.disableClick then createCode = createCode .. [[
	btn:Disable();
]];
	end
	createCode = createCode .. VFLUI.GenerateSetTextureCode("btn.tex", desc.texture)
	createCode = createCode .. [[
	frame.]] .. objname .. [[[i] = btn;
end
]];
		createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
btn = nil;
for i=1,]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i];
	VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
	btn:Destroy(); btn = nil;
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		local smooth = "nil"; if desc.smooth then smooth = "RDX.smooth"; end

		local paintCode = [[
_i = VFL.clamp(]] .. desc.number .. [[, 0, ]] .. desc.nIcons .. [[);
if _i and _i > 0 then
	for i=1, _i do
		frame.]] .. objname .. [[[i].tex:SetVertexColor(explodeRGBA(color]] .. objname .. [[[i]));
		frame.]] .. objname .. [[[i]:Show();
	end
	if _i < ]] .. desc.nIcons .. [[ then
		for i=(_i + 1), ]] .. desc.nIcons .. [[ do
			frame.]] .. objname .. [[[i]:Hide();
		end
	end
else
	for i=1,]] .. desc.nIcons .. [[ do
		frame.]] .. objname .. [[[i]:Hide();
	end
end

]];
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		
		------------------- Cleanup
		local cleanupCode = [[
btn = nil;
for i=1,]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i];
	btn:Hide();
end
]];
		state:Attach("EmitCleanup", true, function(code) code:AppendCode(cleanupCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		ed_name.editBox:SetText(desc.name);
		ui:InsertFrame(ed_name);
				
		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", "StatusBar_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
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
		
		--W
		local ed_width = VFLUI.LabeledEdit:new(ui, 50); ed_width:Show();
		ed_width:SetText(VFLI.i18n("Width"));
		if desc and desc.w then ed_width.editBox:SetText(desc.w); else ed_width.editBox:SetText("20"); end
		ui:InsertFrame(ed_width);
		--h
		local ed_height = VFLUI.LabeledEdit:new(ui, 50); ed_height:Show();
		ed_height:SetText(VFLI.i18n("Height"));
		if desc and desc.h then ed_height.editBox:SetText(desc.h); else ed_height.editBox:SetText("20"); end
		ui:InsertFrame(ed_height);
		
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
		
		-------------- Data source
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Datasource parameters")));
		
		local number = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Number"), state, "NumberVar_");
		if desc and desc.number then number:SetSelection(desc.number); end
		
		-- Drawlayer
		local er = VFLUI.EmbedRight(ui, "Draw layer");
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(100); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);
		
		-- Texture
		local er = VFLUI.EmbedRight(ui, "Texture");
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);
		
		-- color
		local color1 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Texture 1 color"));
		if desc and desc.color1 then color1:SetColor(VFL.explodeRGBA(desc.color1)); end
		local color2 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Texture 2 color"));
		if desc and desc.color2 then color2:SetColor(VFL.explodeRGBA(desc.color2)); end
		local color3 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Texture 3 color"));
		if desc and desc.color3 then color3:SetColor(VFL.explodeRGBA(desc.color3)); end
		local color4 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Texture 4 color"));
		if desc and desc.color4 then color4:SetColor(VFL.explodeRGBA(desc.color4)); end
		local color5 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Texture 5 color"));
		if desc and desc.color5 then color5:SetColor(VFL.explodeRGBA(desc.color5)); end
		
		function ui:GetDescriptor()
			return { 
				feature = "custom_icons"; version = 1;
				name = ed_name.editBox:GetText();

				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), -200, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), -200, 200);
				w = VFL.clamp(ed_width.editBox:GetNumber(), 1, 100);
				h = VFL.clamp(ed_height.editBox:GetNumber(), 1, 100);
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
				number = number.editBox:GetText();
				drawLayer = drawLayer:GetSelection();
				texture = tsel:GetSelectedTexture();
				color1 = color1:GetColor();
				color2 = color2:GetColor();
				color3 = color3:GetColor();
				color4 = color4:GetColor();
				color5 = color5:GetColor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "custom_icons";
			version = 1;
			name = "customicon1";
			owner = "Frame_decor";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			w = 20; h = 20;
			orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			drawLayer = "ARTWORK";
			texture = VFL.copy(VFLUI.defaultTexture);
			color1 = {r=1,g=1,b=1,a=1};
			color2 = {r=1,g=1,b=1,a=1};
			color3 = {r=1,g=1,b=1,a=1};
			color4 = {r=1,g=1,b=1,a=1};
			color5 = {r=1,g=1,b=1,a=1};
		};
	end;
});


