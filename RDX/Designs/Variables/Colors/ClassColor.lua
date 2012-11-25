
RDX.RegisterFeature({
	name = "ColorVariable: Unit Class Color";
	title = VFLI.i18n("Color Unit Class");
	category = VFLI.i18n("Variables Colors");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if state:Slot("ColorVar_classColor") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name")); return nil;
		end
		state:AddSlot("Var_classColor");
		state:AddSlot("ColorVar_classColor");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
		local classColor = unit:GetClassColor();
]]);
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function()
		return { feature = "ColorVariable: Unit Class Color"; };
	end;
});