--------------------------------------------------
-- swing
--------------------------------------------------

RDX.RegisterFeature({
	name = "var_swingmelee";
	title = VFLI.i18n("Vars Player Melee Info"); category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("TimerVar_meleemh");
		state:AddSlot("TimerVar_meleeoh");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("SWING_MELEE_UPDATE");
		
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local meleemh_start, meleeoh_start, meleemh_duration, meleeoh_duration = RDX.GetSwingMeleeInfo();
]]);
		end);

		mux:Event_UnitMask("UNIT_SWING_MELEE_UPDATE", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_swingmelee" }; end
});