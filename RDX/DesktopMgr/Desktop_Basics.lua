-- Desktop_Basics.lua
-- OpenRDX
--
-- Main feature for Desktop objects.
--

RDX.RegisterFeature({
	name = "Desktop main",
	title = "Desktop";
	category = "Basics";
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if state:Slot("Desktop main") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		--if not desc.title then
		--	VFL.AddError(errs, VFLI.i18n("Missing field"));
		--	return nil;
		--end
		state:AddSlot("Desktop main");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local useviewport = "nil"; if desc.viewport then useviewport = "true"; end
		if not desc.offsetleft then desc.offsetleft = 0; end
		if not desc.offsettop then desc.offsettop = 0; end
		if not desc.offsetright then desc.offsetright = 0; end
		if not desc.offsetbottom then desc.offsetbottom = 0; end
		
		if not desc.gametooltip then
			desc.gametooltip = {};
			desc.gametooltip.anchorx = 200;
			desc.gametooltip.anchory = 200;
			desc.gametooltip.bkd = { _border = "IshBorder"; bgFile = "Interface\\Addons\\VFL\\Skin\\black"; tileSize = 16; tile = true; _backdrop = "VFL_black"; edgeSize = 24; edgeFile = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder";};
			desc.gametooltip.font = { face = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\BigNoodleTitling.ttf"; justifyH = "LEFT"; size = 14; flags = "OUTLINE"; };
			desc.gametooltip.tex = { path = "Interface\\Addons\\RDX\\Skin\\bar1"; blendMode = "BLEND"; color = {r=1,g=1,b=1,a=1}; };
		end
		local tooltipmouse = "nil"; if desc.gametooltip.tooltipmouse then tooltipmouse = "true"; end
		--if not desc.anchorx then desc.anchorx = 200; end
		--if not desc.anchory then desc.anchory = 200; end
		--if not desc.bkd then desc.bkd = VFL.copy(VFLUI.DarkDialogBackdrop); end
		--if not desc.font then desc.font = VFL.copy(Fonts.Default10); end
		--if not desc.tex then desc.tex = { path = "Interface\\Addons\\RDX\\Skin\\bar1"; blendMode = "BLEND"; color = {r=1,g=1,b=1,a=1}; }; end
		desc.anchorx = nil;
		desc.anchory = nil;
		desc.bkd = nil;
		desc.font = nil;
		desc.tex = nil;
		
		if not desc.realid then
			desc.realid = {};
			desc.realid.anchorxrid = 200;
			desc.realid.anchoryrid = 200;
		end
		--if not desc.anchorxrid then desc.anchorxrid = 200; end
		--if not desc.anchoryrid then desc.anchoryrid = 200; end
		desc.anchorxrid = nil;
		desc.anchoryrid = nil;
		
		if not desc.open then desc.open = true; end
		if not desc.root then desc.root = true; end
		if not desc.name then desc.name = "root"; end
		if not desc.dgp then desc.dgp = true; end
		if not desc.scale then desc.scale = 1; end
		if not desc.alpha then desc.alpha = 1; end
		if not desc.strata then desc.strata = "LOW"; end
		if not desc.ap then desc.ap = "TOPLEFT"; end
		
		if not desc.rdxiconx then desc.rdxiconx = 300; end
		if not desc.rdxicony then desc.rdxicony = 300; end
		if not desc.rdxmtxt then desc.rdxmtxt = "default"; end
		
		if not desc.topstack_props then desc.topstack_props = {512, 750, "TOP", "BOTTOM", .4, 1}; end
		if not desc.bottomstack_props then desc.bottomstack_props = {512, 450, "BOTTOM", "TOP", .9, 1}; end
		
		if not desc.ctffont then desc.ctffont = VFL.copy(Fonts.Default10); end
		
		state.Code:Clear();
		state.Code:AppendCode([[
local encid = "dk_rdx8";
DesktopEvents:Dispatch("WINDOW_OPEN", "root", "Desktop main");
DesktopEvents:Dispatch("DESKTOP_VIEWPORT", ]] .. useviewport .. [[, ]] .. desc.offsetleft .. [[, ]] .. desc.offsettop .. [[, ]] .. desc.offsetright .. [[, ]] .. desc.offsetbottom .. [[);
DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP", ]] .. Serialize(desc.gametooltip) .. [[);
DesktopEvents:Dispatch("DESKTOP_REALID", ]] .. Serialize(desc.realid) .. [[);
DesktopEvents:Dispatch("DESKTOP_RDXICON_POSITION", ]] .. desc.rdxiconx .. [[, ]] .. desc.rdxicony .. [[);
DesktopEvents:Dispatch("DESKTOP_RDXICON_TYPE", ']] .. desc.rdxmtxt  .. [[');
DesktopEvents:Dispatch("DESKTOP_ALERTS", ]] .. Serialize(desc.topstack_props) .. [[, ]] .. Serialize(desc.bottomstack_props) .. [[);
DesktopEvents:Dispatch("DESKTOP_COMBATTEXT", ]] .. Serialize(desc.ctffont) .. [[);
]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local title = VFLUI.LabeledEdit:new(ui, 200); title:Show();
		title:SetText(VFLI.i18n("Desktop Title"));
		if desc and desc.title then title.editBox:SetText(desc.title); end
		ui:InsertFrame(title);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("ViewPort")));
		
		local chk_viewport = VFLUI.Checkbox:new(ui); chk_viewport:Show();
		chk_viewport:SetText(VFLI.i18n("Activate Viewport"));
		if desc and desc.viewport then chk_viewport:SetChecked(true); else chk_viewport:SetChecked(); end
		ui:InsertFrame(chk_viewport);
		
		--local er = VFLUI.EmbedRight(ui, VFLI.i18n("Anchor:"));
		--local dd_vanchor = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
		--dd_vanchor:SetWidth(200); dd_vanchor:Show();
		--if desc and desc.vanchor then 
		--	dd_vanchor:SetSelection(desc.vanchor); 
		--else
		--	dd_vanchor:SetSelection("CENTER");
		--end
		--er:EmbedChild(dd_vanchor); er:Show();
		--ui:InsertFrame(er);
		
		local offsettop = VFLUI.LabeledEdit:new(ui, 200); offsettop:Show();
		offsettop:SetText(VFLI.i18n("Offset Top"));
		if desc and desc.offsettop then offsettop.editBox:SetText(desc.offsettop); else offsettop.editBox:SetText("0"); end
		ui:InsertFrame(offsettop);
		
		local offsetleft = VFLUI.LabeledEdit:new(ui, 200); offsetleft:Show();
		offsetleft:SetText(VFLI.i18n("Offset Left"));
		if desc and desc.offsetleft then offsetleft.editBox:SetText(desc.offsetleft); else offsetleft.editBox:SetText("0"); end
		ui:InsertFrame(offsetleft);
		
		local offsetbottom = VFLUI.LabeledEdit:new(ui, 200); offsetbottom:Show();
		offsetbottom:SetText(VFLI.i18n("Offset Bottom"));
		if desc and desc.offsetbottom then offsetbottom.editBox:SetText(desc.offsetbottom); else offsetbottom.editBox:SetText("0"); end
		ui:InsertFrame(offsetbottom);
		
		local offsetright = VFLUI.LabeledEdit:new(ui, 200); offsetright:Show();
		offsetright:SetText(VFLI.i18n("Offset Right"));
		if desc and desc.offsetright then offsetright.editBox:SetText(desc.offsetright); else offsetright.editBox:SetText("0"); end
		ui:InsertFrame(offsetright);
		
		--[[
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("GameTooltips")));
		
		local chk_tooltipmouse = VFLUI.Checkbox:new(ui); chk_tooltipmouse:Show();
		chk_tooltipmouse:SetText(VFLI.i18n("Mouse anchor GameTooltip"));
		if desc and desc.tooltipmouse then chk_tooltipmouse:SetChecked(true); else chk_tooltipmouse:SetChecked(); end
		ui:InsertFrame(chk_tooltipmouse);
		
		local anchorx = VFLUI.LabeledEdit:new(ui, 200); anchorx:Show();
		anchorx:SetText(VFLI.i18n("Offset x"));
		if desc and desc.anchorx then anchorx.editBox:SetText(desc.anchorx); else anchorx.editBox:SetText("200"); end
		ui:InsertFrame(anchorx);
		
		local anchory = VFLUI.LabeledEdit:new(ui, 200); anchory:Show();
		anchory:SetText(VFLI.i18n("Offset y"));
		if desc and desc.anchory then anchory.editBox:SetText(desc.anchory); else anchory.editBox:SetText("0"); end
		ui:InsertFrame(anchory);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop style"));
		local bkd = VFLUI.MakeBackdropSelectButton(er, desc.bkd); bkd:Show();
		er:EmbedChild(bkd); er:Show();
		ui:InsertFrame(er);
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local font = VFLUI.MakeFontSelectButton(er_st, desc.font); font:Show();
		er_st:EmbedChild(font); er_st:Show();
		ui:InsertFrame(er_st);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.tex); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Realid properties")));
		
		local anchorxrid = VFLUI.LabeledEdit:new(ui, 200); anchorxrid:Show();
		anchorxrid:SetText(VFLI.i18n("Offset x"));
		if desc and desc.anchorxrid then anchorxrid.editBox:SetText(desc.anchorxrid); else anchorxrid.editBox:SetText("200"); end
		ui:InsertFrame(anchorxrid);
		
		local anchoryrid = VFLUI.LabeledEdit:new(ui, 200); anchoryrid:Show();
		anchoryrid:SetText(VFLI.i18n("Offset y"));
		if desc and desc.anchoryrid then anchoryrid.editBox:SetText(desc.anchoryrid); else anchoryrid.editBox:SetText("0"); end
		ui:InsertFrame(anchoryrid);]]
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Dock properties")));
		
		local n = 2; 
		if desk and desk.dock then n = #desk.dock + 1 end
		if desk and desk.dgp then n = n + 1 end
		local txtCurDock = VFLUI.SimpleText:new(ui, n, 200); txtCurDock:Show();
		local str = VFLI.i18n("Current Docks:\n");
		if desc.dock then
			for k,v in pairs(desc.dock) do
				str = str .. k .. ": " .. v.id .. "\n";
			end
		else
			str = str .. "(none)\n";
		end
		if desc.dgp then str = str ..  VFLI.i18n("This element is parent dock"); end
		
		txtCurDock:SetText(str);
		ui:InsertFrame(txtCurDock);
		
		
		--local l,t,r,b = VFLUI.GetUniversalBoundary(frame);
		
		--VFLUI.SetAnchorFramebyPosition(frame, ap, left, top, right, bottom)

		function ui:GetDescriptor()
			return {
				feature = "Desktop main";
				name = "root";
				title = title.editBox:GetText();
				--resolution = VFLUI.GetCurrentResolution();
				--scale = VFLUI.GetCurrentEffectiveScale();
				--perfectpixel = chk_perfectpixel:GetChecked();
				viewport = chk_viewport:GetChecked();
				--vanchor = dd_vanchor:GetSelection();
				offsettop = offsettop.editBox:GetText();
				offsetleft = offsetleft.editBox:GetText();
				offsetbottom = offsetbottom.editBox:GetText();
				offsetright = offsetright.editBox:GetText();
				--tooltipmouse = chk_tooltipmouse:GetChecked();
				--anchorx = anchorx.editBox:GetText();
				--anchory = anchory.editBox:GetText();
				--bkd = bkd:GetSelectedBackdrop();
				--font = font:GetSelectedFont();
				--tex = tsel:GetSelectedTexture();
				--anchorxrid = anchorxrid.editBox:GetText();
				--anchoryrid = anchoryrid.editBox:GetText();
				gametooltip = desc.gametooltip;
				realid = desc.realid;
				dock = desc.dock;
				dgp = desc.dgp;
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Desktop main", name = "root", resolution = VFLUI.GetCurrentResolution(), scale = VFLUI.GetCurrentEffectiveScale()}; end
});

