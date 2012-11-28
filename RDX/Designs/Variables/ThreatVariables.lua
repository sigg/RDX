-- Threats.lua
-- OpenRDX
--
-- Sigg Rashgarroth EU
--

------------------------------------------------
-- THREAT UNITFRAME VARS
------------------------------------------------
--- Unit frame variables for predicted health valuation.
RDX.RegisterFeature({
	name = "var_threat";
	title = VFLI.i18n("Vars Threat (threat, fthreat)");
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_threat") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_threat"); state:AddSlot("TextData_threat_value");
		state:AddSlot("FracVar_fthreat"); state:AddSlot("TextData_threat_info");
		state:AddSlot("BoolVar_bthreat");
		state:AddSlot("FracVar_fthreatscale"); state:AddSlot("TextData_threatscale_info");
		state:AddSlot("BoolVar_bthreatscale");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
		local _, _, fthreatscale, fthreat, threat_value = unit:GetThreatInfo();
		local bthreat, bthreatscale = nil, nil;
		local threat_info = "";
		local threatscale_info = "";
		if fthreat and fthreat > 0 then
			bthreat = true;
			threat_info = strformat("%d%%",(fthreat * 100));
		end
		if fthreatscale and fthreatscale > 0 then
			bthreatscale = true;
			threatscale_info = strformat("%d%%",(fthreatscale * 100));
		end
]]); end);
		-- Event hinting
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		mux:Event_UnitMask("UNIT_THREAT", mux:GetPaintMask("THREAT"));
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local stxt = VFLUI.SimpleText:new(ui, 3, 200); stxt:Show();
		local str = "This feature contains a refresh function that will repaint your window every 0.5 secondes.\n";
		str = str .. "It is strongly recommend to use it in his own window.";
		str = str .. "OpenRDX Team";
		
		stxt:SetText(str);
		ui:InsertFrame(stxt);

		function ui:GetDescriptor()
			return {feature = "var_threat"};
		end
		
		return ui;
	end;
	CreateDescriptor = function() return { feature = "var_threat" }; end
});
