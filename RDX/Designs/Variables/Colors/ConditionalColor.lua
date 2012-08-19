
RDX.RegisterFeature({
	name = "ColorVariable: Conditional Color";
	title = VFLI.i18n("Color Conditional");
	category = VFLI.i18n("Variable Colors");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if (not desc.condVar) or not state:Slot("BoolVar_" .. desc.condVar) then
			VFL.AddError(errs, VFLI.i18n("Invalid condition variable")); return nil;
		end
		if (not desc.colorVar1) or (not desc.colorVar2) then
			VFL.AddError(errs, VFLI.i18n("Missing true/false colors")); return nil;
		end
		if (not state:Slot("ColorVar_" .. desc.colorVar1)) or (not state:Slot("ColorVar_" .. desc.colorVar2)) then
			VFL.AddError(errs, VFLI.i18n("Invalid true/false colors")); return nil;
		end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("ColorVar_" .. desc.name);
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[ = nil;
if ]] .. desc.condVar .. [[ then 
	]] .. desc.name .. [[ = ]] .. desc.colorVar1 .. [[;
else
	]] .. desc.name .. [[ = ]] .. desc.colorVar2 .. [[;
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

		local condVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Condition"), state, "BoolVar_");
		if desc and desc.condVar then condVar:SetSelection(desc.condVar); end

		local colorVar1 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("True color"), state, "ColorVar_");
		if desc and desc.colorVar1 then colorVar1:SetSelection(desc.colorVar1); end
		local colorVar2 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("False color"), state, "ColorVar_");
		if desc and desc.colorVar2 then colorVar2:SetSelection(desc.colorVar2); end
		
		function ui:GetDescriptor()
			return {
				feature = "ColorVariable: Conditional Color"; name = name.editBox:GetText();
				condVar = condVar:GetSelection(); colorVar1 = colorVar1:GetSelection(); colorVar2 = colorVar2:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "ColorVariable: Conditional Color"; name = "condColor"; };
	end;
});