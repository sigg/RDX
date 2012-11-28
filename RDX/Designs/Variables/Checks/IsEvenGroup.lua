
-- Xenios
RDX.RegisterFeature({
	name = "var_isEven";
	title = VFLI.i18n("Var IsEvenGroup?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isEven");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) 
		if desc.test then
			code:AppendCode([[
local isEven = true;
]]);
		else
			code:AppendCode([[
local isEven = (unit:GetGroup() % 2 == 0);
]]);
		end
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isEven" }; end
});
