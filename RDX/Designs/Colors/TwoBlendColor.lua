
RDX.RegisterFeature({
	name = "ColorVariable: Two-Color Blend";
	title = VFLI.i18n("Color Two-Color Blend");
	category = VFLI.i18n("Colors");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if (not desc.bfVar) or (strtrim(desc.bfVar) == "") then VFL.AddError(errs, VFLI.i18n("Missing blend fraction.")); return nil; end
		if not tonumber(desc.bfVar) then
			if (not state:Slot("FracVar_" .. desc.bfVar)) then 
				VFL.AddError(errs, VFLI.i18n("Invalid blend fraction variable.")); return nil;
			end
		end
		if (not desc.colorVar1) or (not desc.colorVar2) then
			VFL.AddError(errs, VFLI.i18n("Missing blend colors.")); return nil;
		end
		if (not state:Slot("ColorVar_" .. desc.colorVar1)) or (not state:Slot("ColorVar_" .. desc.colorVar2)) then
			VFL.AddError(errs, VFLI.i18n("Invalid blend colors.")); return nil;
		end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("ColorVar_" .. desc.name);
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode("local " .. desc.name .. " = VFL.Color:new();");
		end);
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
]] .. desc.name .. [[:blend(]] .. desc.colorVar1 .. "," .. desc.colorVar2 .. "," .. desc.bfVar .. [[);
]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local bfVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Blend fraction"), state, "FracVar_");
		if desc and desc.bfVar then bfVar:SetSelection(desc.bfVar); end

		local colorVar1 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("From color"), state, "ColorVar_");
		if desc and desc.colorVar1 then colorVar1:SetSelection(desc.colorVar1); end
		local colorVar2 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("To color"), state, "ColorVar_");
		if desc and desc.colorVar2 then colorVar2:SetSelection(desc.colorVar2); end
		
		function ui:GetDescriptor()
			return {
				feature = "ColorVariable: Two-Color Blend"; name = name.editBox:GetText();
				bfVar = bfVar:GetSelection(); colorVar1 = colorVar1:GetSelection(); colorVar2 = colorVar2:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "ColorVariable: Two-Color Blend"; name = "twoColor"; };
	end;
});