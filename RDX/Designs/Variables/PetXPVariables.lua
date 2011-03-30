---------------------------------------------------
-- Fractional Pet XP (fridgid)
---------------------------------------------------
RDX.RegisterFeature({
	name = "Variable: Frac Pet XP (fpxp)";
	title = "Vars Frac Pet XP (fpxp)";
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_fpxp") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_fpxp");
		state:AddSlot("FracVar_fpxp");
		state:AddSlot("TextData_fpetxptxt");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
local currentXP, nextXP = GetPetExperience();
local fpxp = currentXP/nextXP;
local fpetxptxt = currentXP .. " / " .. nextXP;
]]); end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("XP_UPDATE");
		mux:Event_UnitMask("UNIT_XP_UPDATE", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variable: Frac Pet XP (fpxp)" }; end
});