
RDX.RegisterFeature({
	name = "var_targetexisted";
	title = VFLI.i18n("Var IsTargetExisted?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_targetexisted");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local targetexisted = true;
]]);
		else
			code:AppendCode([[
local targetexisted = UnitExists("target");
if targetexisted then targetexisted = true; else targetexisted = false; end
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("TARGET");
			mux:Event_UnitMask("UNIT_TARGET", mask);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_targetexisted" }; end
});
