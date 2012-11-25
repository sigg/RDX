--- Unit frame variables for predicted health valuation.
RDX.RegisterFeature({
	name = "var_pred_health";
	title = VFLI.i18n("Vars Frac Predicted Health (ph, pfh, ih)");
	test = true;
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_ph") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_ph"); state:AddSlot("Var_pfh"); state:AddSlot("FracVar_pfh");
		state:AddSlot("Var_ih"); state:AddSlot("TextData_pheal");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
		local ph, pfh, ih = 300, 0.5, 100;
		local pheal = VFL.strcolor(1,1,1) .. "+" .. 300 .. " " .. VFL.strcolor(0.75,0,0) .. "-" .. 100;
]]);
		else
			code:AppendCode([[
		local ph, _, pfh, ih = unit:AllSmartHealth();
		local umh = unit:MissingHealth();
		local pheal = "";
		if umh and umh > 0 then pheal = VFL.strcolor(0.75,0,0) .. "-" .. umh; end
		if ih and ih > 0 then pheal = VFL.strcolor(1,1,1) .. "+" .. ih .. " " .. pheal; end
]]);
		end
		end);
		-- Event hinting
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		mux:Event_UnitMask("UNIT_HEAL_PREDICTION", mux:GetPaintMask("HEAL_PREDICTION"));
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_pred_health" }; end
});

