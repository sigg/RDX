---------------------------------------------------
-- Fractional Reputation (fridgid)
---------------------------------------------------

RDX.RegisterFeature({
	name = "Variable: Frac Reputation (frep)";
	title = "Vars Frac Reputation (frep)";
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_frep") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_frep");
		state:AddSlot("FracVar_frep");
		state:AddSlot("TextData_freptxt");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
		local name, _, repmin, repmax, repvalue = GetWatchedFactionInfo();
		local frep, crep, cmax, freptxt = 0, 0, 0, "";
		if name then 
			frep = (repvalue - repmin) / (repmax - repmin);
			crep = repvalue - repmin;
			cmax = repmax - repmin;
			freptxt = name .. ": ".. crep .. "/".. cmax .. " ".. floor((crep/cmax) *100) .."%";
		end
]]); end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			mux:Event_MaskAll("UNIT_FACTION", 2);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variable: Frac Reputation (frep)" }; end
});
