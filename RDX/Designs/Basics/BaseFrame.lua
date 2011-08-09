-- BasicUFFeatures.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- The basic unit frame features. (Baseframe, bars, text boxes.)

RDX.RegisterFeature({
	name = "base_default"; 
	title = VFLI.i18n("Frame Base");
	category = VFLI.i18n("Basics");
	version = 1; 
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitCreate") then return nil; end
		if not state:Slot("EmitDestroy") then return nil; end
		if state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not RDXUI.UFLayoutCheck(desc, state, errs) then return nil; end
		if desc.ph and state:Slot("Hotspot_") then
			VFL.AddError(errs, VFLI.i18n("Duplicate primary hotspots"));
			return nil;
		end
		if desc.ph then state:AddSlot("Hotspot_"); end
		if (not desc.alpha) or (desc.alpha < 0.05) then
			desc.alpha = 1;
		end
		state:AddSlot("Base");
		state:AddSlot("StaticVar_BaseHeight");
		state:AddSlot("StaticVar_BaseWidth");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local alpha = desc.alpha or 1;
		local dx,dy = desc.w, desc.h;
		local hlt = desc.hlt or "false";
		local createCode = [[
local BaseWidth = ]] .. dx .. [[;
local BaseHeight = ]] .. dy .. [[;
frame:SetWidth(]] .. dx .. [[); frame:SetHeight(]] .. dy .. [[);
frame:SetAlpha(]] .. alpha .. [[);
]];
		if desc.ph then
			createCode = createCode .. [[
local btn = VFLUI.AcquireFrame("SecureUnitButton");
VFLUI.StdSetParent(btn, frame, 4);
btn:SetAttribute("useparent-unit", true); btn:SetAttribute("unit", nil);
btn:SetAttribute("useparent-unitsuffix", true); btn:SetAttribute("unitsuffix", nil);
btn:SetAllPoints(frame); btn:Show();
if frame:GetAttribute("toggleForVehicle") then
	btn:SetAttribute("toggleForVehicle", true);
end
if not ]] .. hlt .. [[ then
	btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
end
frame._phs = btn; frame:SetHotspot(nil, btn);
]];
			state:Attach("EmitDestroy", nil, function(code) code:AppendCode([[
frame._phs:Destroy(); frame._phs = nil;
]]); end);
		end -- if desc.ph
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:AddSlot("FrameDimensions");
		state:Attach(state:Slot("FrameDimensions"), nil, function() return dx,dy; end);
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_width = VFLUI.LabeledEdit:new(ui, 100); ed_width:Show();
		ed_width:SetText(VFLI.i18n("Width"));
		if desc and desc.w then ed_width.editBox:SetText(desc.w); end
		ui:InsertFrame(ed_width);
		
		local ed_height = VFLUI.LabeledEdit:new(ui, 100); ed_height:Show();
		ed_height:SetText(VFLI.i18n("Height"));
		if desc and desc.h then ed_height.editBox:SetText(desc.h); end
		ui:InsertFrame(ed_height);
		
		local ed_alpha = VFLUI.LabeledEdit:new(ui, 50); ed_alpha:Show();
		ed_alpha:SetText(VFLI.i18n("Base alpha"));
		if desc and desc.alpha then ed_alpha.editBox:SetText(desc.alpha); end
		ui:InsertFrame(ed_alpha);

		local chk_ph = VFLUI.Checkbox:new(ui); 
		chk_ph:Show(); chk_ph:SetText(VFLI.i18n("Auto-create primary hotspot"));
		if desc and desc.ph then chk_ph:SetChecked(true); end
		ui:InsertFrame(chk_ph);

		local chk_hlt = VFLUI.Checkbox:new(ui); 
		chk_hlt:Show(); chk_hlt:SetText(VFLI.i18n("Disable highlight on mouseover"));
		if desc and desc.hlt then chk_hlt:SetChecked(true); end
		ui:InsertFrame(chk_hlt);

		function ui:GetDescriptor()
			local a = ed_alpha.editBox:GetNumber(); if not a then a = 1; end
			a = VFL.clamp(a, 0, 1);
			return { 
				feature = "base_default"; version = 1; 
				w = ed_width.editBox:GetNumber();
				h = ed_height.editBox:GetNumber();
				alpha = a; 
				ph = chk_ph:GetChecked();
				hlt = chk_hlt:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "base_default"; version = 1;
			w = 90; h = 14; alpha = 1; ph = false;
		};
	end;
});

RDX.RegisterFeature({
	name = "artbase_default"; 
	version = 2;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "base_default"; desc.version = 1;
	end;
});
