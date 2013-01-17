
RDX.RegisterFeature({
	name = "var_isControlDown";
	title = VFLI.i18n("Var IsControlHeldDown?");
	category = VFLI.i18n("Variables True/False");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isControlDown");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
local isControlDown = IsControlKeyDown();
]]);
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("HARDWARE");
			mux:Event_UnitMask("MODIFIER_STATE_CHANGED", mask);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isControlDown" }; end
});
