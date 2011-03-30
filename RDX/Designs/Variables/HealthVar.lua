--------------------------------------- fh/fm
RDX.RegisterFeature({
	name = "Variable: Fractional health (fh)";
	title = "Vars Frac health (fh)";
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_fh") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_fh");
		state:AddSlot("FracVar_fh");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
local fh = unit:FracHealth();
]]); 
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("HEALTH");
		mux:Event_UnitMask("UNIT_HEALTH", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variable: Fractional health (fh)" }; end
});
