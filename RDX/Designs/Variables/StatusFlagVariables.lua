-- Variables.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Variables that can be used in unit frames.
------------------------ Baseline status flags
RDX.RegisterFeature({
	name = "Variables: Status Flags (dead, ld, feigned)";
	title = VFLI.i18n("Vars Status (dead, ld, feigned)");
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_dead") or state:Slot("Var_ld") or state:Slot("Var_feigned") or state:Slot("Var_incap") then 
			return nil; 
		end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_dead"); state:AddSlot("BoolVar_dead");
		state:AddSlot("Var_ld"); state:AddSlot("BoolVar_ld");
		state:AddSlot("Var_feigned"); state:AddSlot("BoolVar_feigned");
		state:AddSlot("Var_incap"); state:AddSlot("BoolVar_incap");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
		local feigned, dead, ld, incap = nil, nil, nil, nil;
		if unit then feigned = unit:IsFeigned(); end
		dead = UnitIsDeadOrGhost(uid) and (not feigned);
		ld = (not UnitIsConnected(uid));
		incap = (feigned or dead or ld);
]]); 
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("HEALTH");
		mux:Event_UnitMask("UNIT_HEALTH", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variables: Status Flags (dead, ld, feigned)" }; end
});























