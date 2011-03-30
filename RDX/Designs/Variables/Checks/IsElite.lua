
RDX.RegisterFeature({
	name = "var_isElite";
	title = VFLI.i18n("Var IsElite?");
	category = VFLI.i18n("Variables Check");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isElite");
		state:AddSlot("BoolVar_isNotElite");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local isElite, isNotElite = true, false;
]]);
		else
			code:AppendCode([[
local isElite, isNotElite = false, true;
local strclasstype = UnitClassification(uid);
if (strclasstype ~= "normal") then isElite = true; isNotElite = false; end
]]);
		end
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isElite" }; end
});
