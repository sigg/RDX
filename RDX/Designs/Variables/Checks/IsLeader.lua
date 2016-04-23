
-- Cidan
RDX.RegisterFeature({
	name = "var_israidpartyleader";
	title = VFLI.i18n("Var IsLeader?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_israidpartyleader");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local israidpartyleader = true;
]]);
		else
			code:AppendCode([[
local israidpartyleader = nil;
if GetNumRaidMembers() > 0 then
	_,israidpartyleader = GetRaidRosterInfo(RDXDAL.UIDToNumber(uid));
	if israidpartyleader < 2 then israidpartyleader = nil; end
else
	israidpartyleader = UnitIsGroupLeader(uid);
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
	CreateDescriptor = function() return { feature = "var_israidpartyleader" }; end
});
