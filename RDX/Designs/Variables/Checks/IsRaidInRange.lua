
RDX.RegisterFeature({
	name = "var_inrange";
	title = VFLI.i18n("Var IsRaidInRange?");
	category = VFLI.i18n("Variables Check");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_inRange");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local inRange = true;
]]);
		else
			code:AppendCode([[
local inRange = UnitInRange(uid);
]]);
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("RANGED");
		mux:Event_UnitMask("UNIT_RANGED", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_inrange" }; end
});
