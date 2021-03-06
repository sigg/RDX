﻿
RDX.RegisterFeature({
	name = "var_isDeath";
	title = VFLI.i18n("Var IsDeathOrGhost?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isDeath");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local isDeath = true;
]]);
		else
			code:AppendCode([[
local isDeath = UnitIsDead(uid);
if not isDeath then
	isDeath = UnitIsGhost(uid)
end
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("FLAGS");
			mux:Event_UnitMask("UNIT_FLAGS", mask);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isDeath" }; end
});
