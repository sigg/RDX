
RDX.RegisterFeature({
	name = "var_isnpc";
	title = VFLI.i18n("Var IsNPC?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isnpc");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local isnpc = true;
]]);
		else
			code:AppendCode([[
local isnpc = (not UnitIsPlayer(uid));
]]);
		end
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isnpc" }; end
});