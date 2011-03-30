
-- Xenios
RDX.RegisterFeature({
	name = "var_isEnemy";
	title = VFLI.i18n("Var IsEnemy?");
	category = VFLI.i18n("Variables Check");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isEnemy");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) 
		if desc.test then
			code:AppendCode([[
local isEnemy = true;
]]);
		else
			code:AppendCode([[
local isEnemy = UnitIsEnemy(uid,"player");
]]);
		end
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isEnemy" }; end
});
