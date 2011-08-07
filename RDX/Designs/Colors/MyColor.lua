
RDX.RegisterFeature({
	name = "ColorVariable_Mycolor";
	title = "Color My Color";
	category = "Colors";
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if state:Slot("ColorVar_myColor") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name.")); return nil;
		end
		state:AddSlot("Var_myColor");
		state:AddSlot("ColorVar_myColor");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local myunit = RDXDAL.GetMyUnit();		
local myColor = myunit:GetClassColor();
]]);
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function()
		return { feature = "ColorVariable_Mycolor"; };
	end;
});