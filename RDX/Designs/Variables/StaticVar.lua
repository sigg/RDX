
RDX.RegisterFeature({
	name = "Variable: Static Value";
	title = VFLI.i18n("Vars Static Value");
	category = VFLI.i18n("Variables");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitClosure") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not desc.value then VFL.AddError(errs, VFLI.i18n("Missing value")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("StaticVar_" .. desc.name);
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[ = ]] .. desc.value .. [[;
]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local value = VFLUI.LabeledEdit:new(ui, 100); value:Show();
		value:SetText(VFLI.i18n("Variable Value"));
		if desc and desc.value then value.editBox:SetText(desc.value); end
		ui:InsertFrame(value);

		function ui:GetDescriptor()
			return {
				feature = "Variable: Static Value"; 
				name = name.editBox:GetText();
				value = value.editBox:GetText();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variable: Static Value"; name = "staticValue"; value = 0 };
	end;
});