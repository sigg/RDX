-- ColorVariables.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Variables that can be used to define colors.

local function valOrNil(x)
	if type(x) ~= "string" then return "nil"; end
	x = strtrim(x);
	if x == "" then return "nil"; else return x; end
end

RDX.RegisterFeature({
	name = "color_hlsxform";
	title = VFLI.i18n("Color HLS Transform"); 
	category = VFLI.i18n("Colors");
	multiple = true;
	IsPossible = function(state)
		if not state:HasSlots("DesignFrame", "EmitClosure", "EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if (type(desc.colorVar) ~= "string") or (strtrim(desc.colorVar) == "") then 
			VFL.AddError(errs, VFLI.i18n("Missing base Color")); return nil;
		end
		if (not state:Slot("ColorVar_" .. desc.colorVar)) then VFL.AddError(errs, VFLI.i18n("Invalid base color"));	end
		if (type(desc.hx) ~= "string") then	VFL.AddError(errs, VFLI.i18n("Invalid hue")); end
		if (type(desc.lx) ~= "string") then	VFL.AddError(errs, VFLI.i18n("Invalid luminosity")); end
		if (type(desc.sx) ~= "string") then	VFL.AddError(errs, VFLI.i18n("Invalid saturation")); end
		if VFL.HasError(errs) then return nil; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("ColorVar_" .. desc.name);
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode("local " .. desc.name .. " = VFL.Color:new();");
		end);
		local condition = desc.condVar or "true";
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
if ]] .. condition .. [[ then
	]] .. desc.name .. [[:HLSTransform(]] .. desc.colorVar .. "," .. valOrNil(desc.hx) .. "," .. valOrNil(desc.lx) .. "," .. valOrNil(desc.sx) .. [[);
else
	]] .. desc.name .. [[:set(]] .. desc.colorVar .. [[);
end
]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local colorVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("From color"), state, "ColorVar_");
		if desc and desc.colorVar then colorVar:SetSelection(desc.colorVar); end

		local condVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Apply shader only if condition is true"), state, "BoolVar_", nil,"true", "false");
		if desc and desc.condVar then condVar:SetSelection(desc.condVar); end

		local hx = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Hue modifier (blank for none)"), state, "FracVar_");
		if desc and desc.hx then hx:SetSelection(desc.hx); end

		local lx = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Luminosity modifier (blank for none)"), state, "FracVar_");
		if desc and desc.lx then lx:SetSelection(desc.lx); end

		local sx = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Saturation modifier (blank for none)"), state, "FracVar_");
		if desc and desc.sx then sx:SetSelection(desc.sx); end

		function ui:GetDescriptor()
			return {
				feature = "color_hlsxform"; 
				name = name.editBox:GetText();
				colorVar = colorVar:GetSelection();
				condVar = condVar:GetSelection();
				hx = hx:GetSelection(); lx = lx:GetSelection(); sx = sx:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "color_hlsxform"; name = "hlsColor"; condVar = "true"; };
	end;
});

