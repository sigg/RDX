
RDX.RegisterFeature({
	name = "ColorVariable: Static Color";
	title = "Color Static";
	category = "Colors";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitClosure") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not desc.color then VFL.AddError(errs, VFLI.i18n("Missing color parameter.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("ColorVar_" .. desc.name);
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[ = ]] .. Serialize(desc.color) .. [[;
]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local color = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Color"));
		if desc and desc.color then color:SetColor(VFL.explodeRGBA(desc.color)); end

		function ui:GetDescriptor()
			return {
				feature = "ColorVariable: Static Color"; name = name.editBox:GetText();
				color = color:GetColor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "ColorVariable: Static Color"; name = "staticColor"; color = {r=1,g=1,b=1,a=1}; };
	end;
});