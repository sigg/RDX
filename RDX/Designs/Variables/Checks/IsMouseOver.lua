
RDX.RegisterFeature({
	name = "var_isMouseOver";
	title = VFLI.i18n("Var IsMouseOver?");
	category = VFLI.i18n("Variables True/False");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isMouseOver");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
local isMouseOver = MouseIsOver(frame);
]]);
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isMouseOver" }; end
});
