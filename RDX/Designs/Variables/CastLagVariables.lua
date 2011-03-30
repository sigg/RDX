
RDX.RegisterFeature({
	name = "var_castlag";
	title = VFLI.i18n("Vars Player Cast Lag"); category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:HasSlots("DesignFrame", "EmitPaintPreamble", "TimerVar_spell") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("FracVar_spell_fraclag");
		state:AddSlot("TextData_spell_lag_number");
		return true;
	end;
	ApplyFeature = function(desc, state)
		--local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		--local umask = mux:GetPaintMask("CAST_TIMER_UPDATE");
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local spell_lag = RDX._GetLastSpellLag();
local spell_fraclag = clamp(spell_lag / max(spell_duration,0.01), 0, 1);
local spell_lag_number = strformat("%dms", spell_lag*1000);
]]);
		--mux:Event_UnitMask("UNIT_CAST_TIMER_UPDATE", umask);
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_castlag" }; end
});