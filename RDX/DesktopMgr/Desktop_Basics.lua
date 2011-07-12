-- Desktop_Basics.lua
-- OpenRDX
--
-- Main feature for Desktop objects.
--

RDX.RegisterFeature({
	name = "Desktop main",
	title = VFLI.i18n("Desktop");
	category = VFLI.i18n("Basics");
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
		
		local tooltipmouse = "nil"; if desc.tooltipmouse then tooltipmouse = "true"; end
		if not desc.anchorx then desc.anchorx = 200; end
		if not desc.anchory then desc.anchory = 200; end
		
		if not desc.open then desc.open = true; end
		if not desc.root then desc.root = true; end
		if not desc.name then desc.name = "root"; end
		if not desc.dgp then desc.dgp = true; end
		if not desc.scale then desc.scale = 1; end
		if not desc.alpha then desc.alpha = 1; end
		if not desc.strata then desc.strata = "LOW"; end
		if not desc.ap then desc.ap = "TOPLEFT"; end
		
		
		state.Code:Clear();
		state.Code:AppendCode([[
local encid = "dk_openrdx7";
DesktopEvents:Dispatch("WINDOW_OPEN", "root", "Desktop main");
DesktopEvents:Dispatch("DESKTOP_VIEWPORT", ]] .. useviewport .. [[, ]] .. desc.offsetleft .. [[, ]] .. desc.offsettop .. [[, ]] .. desc.offsetright .. [[, ]] .. desc.offsetbottom .. [[);
DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP", ]] .. tooltipmouse .. [[, ]] .. desc.anchorx .. [[, ]] .. desc.anchory .. [[);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local title = VFLUI.LabeledEdit:new(ui, 200); title:Show();
		title:SetText(VFLI.i18n("Desktop Title"));
		if desc and desc.title then title.editBox:SetText(desc.title); end
		ui:InsertFrame(title);
		
		--local er = VFLUI.EmbedRight(ui, VFLI.i18n("Resolution:"));
		--local dd_resolution = VFLUI.Dropdown:new(er, VFLUI.ResolutionsDropdownFunction);
		--dd_resolution:SetWidth(200); dd_resolution:Show();
		--if desc and desc.resolution then 
		--	dd_resolution:SetSelection(desc.resolution); 
		--else
		--	dd_resolution:SetSelection("1024x768");
		--end
		--er:EmbedChild(dd_resolution); er:Show();
		--ui:InsertFrame(er);
		
		--local uiscale = VFLUI.LabeledEdit:new(ui, 200); uiscale:Show();
		--uiscale:SetText(VFLI.i18n("UI Scale"));
		--if desc and desc.uiscale then uiscale.editBox:SetText(desc.uiscale); end
		--ui:InsertFrame(uiscale);
		
		--local chk_perfectpixel = VFLUI.Checkbox:new(ui); chk_perfectpixel:Show();
		--chk_perfectpixel:SetText(VFLI.i18n("Activate Perfect Pixel"));
		--if desc and desc.perfectpixel then chk_perfectpixel:SetChecked(true); else chk_perfectpixel:SetChecked(); end
		--ui:InsertFrame(chk_perfectpixel);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("ViewPort")));
		
		local chk_viewport = VFLUI.Checkbox:new(ui); chk_viewport:Show();
		chk_viewport:SetText(VFLI.i18n("Activate viewport"));
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
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Tooltip")));
		
		local chk_tooltipmouse = VFLUI.Checkbox:new(ui); chk_tooltipmouse:Show();
		chk_tooltipmouse:SetText(VFLI.i18n("Mouse anchor tooltip"));
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
		if desc.dgp then str = str .. "This element is parent dock"; end
		
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
				tooltipmouse = chk_tooltipmouse:GetChecked();
				anchorx = anchorx.editBox:GetText();
				anchory = anchory.editBox:GetText();
				dock = desc.dock;
				dgp = desc.dgp;
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Desktop main", name = "root", resolution = VFLUI.GetCurrentResolution(), scale = VFLUI.GetCurrentEffectiveScale()}; end
});

