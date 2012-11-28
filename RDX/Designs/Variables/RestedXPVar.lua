---------------------------------------------------
-- Fractional Rested XP (jfn302)
---------------------------------------------------
RDX.RegisterFeature({
	name = "Variable: Frac Rested XP (frxp)";
	title = "Vars Frac Rested XP (frxp)";
	test = true;
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_frxp") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_frxp");
		state:AddSlot("FracVar_frxp");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) 
		if desc.test then
		code:AppendCode([[	
		local frxp = 0.5;
]]);
		else
		code:AppendCode([[
		local rxp;
		if GetXPExhaustion() then
			rxp = GetXPExhaustion()
		else
			rxp = 0
		end;	
		local frxp = (UnitXP("player")+rxp)/UnitXPMax("player");
		if frxp > 1 then frxp = 1; end
]]);
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("XP_UPDATE");
		mux:Event_UnitMask("UNIT_XP_UPDATE", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variable: Frac Rested XP (frxp)" }; end
});