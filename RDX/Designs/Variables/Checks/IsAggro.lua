
RDX.RegisterFeature({
	name = "var_isAggro";
	title = VFLI.i18n("Var IsAggro?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isAggro");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local isAggro = true;
]]);
		else
			code:AppendCode([[
local isAggro = false;
local threatSituation = UnitThreatSituation(uid, 'target');
if threatSituation == 3 then
	isAggro = true;
end
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("THREAT_SITUATION");
			mux:Event_UnitMask("UNIT_THREAT_SITUATION_UPDATE", mask);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isAggro" }; end
});
