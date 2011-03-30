
RDX.RegisterFeature({
	name = "var_isGhost";
	title = VFLI.i18n("Var IsGhost?");
	category = VFLI.i18n("Variables Check");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isGhost");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local isGhost = true;
]]);
		else
			code:AppendCode([[
local isGhost = UnitIsGhost(uid);
]]);
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("FLAGS");
		mux:Event_UnitMask("UNIT_FLAGS", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isGhost" }; end
});
