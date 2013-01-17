RDX.RegisterFeature({
	name = "Variable combo";
	title = "Vars Combo";
	category = VFLI.i18n("Variables");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("NumberVar_combopoint") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_combopoint");
		state:AddSlot("NumberVar_combopoint");
		state:AddSlot("FracVar_combopoints");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
		local combopoint = 5;
		local combopoints = 1;
]]);
		elseif desc.useplayer then
			code:AppendCode([[
		local combopoint = 0;
		if UnitExists("vehicle") then
			combopoint = GetComboPoints("vehicle");
		else
			combopoint = GetComboPoints("player");
		end
		local combopoints = 0;
		if UnitExists("vehicle") then
			combopoints = GetComboPoints("vehicle") / 5;
		else
			combopoints = GetComboPoints("player") / 5;
		end
]]); 
		else
			code:AppendCode([[
		local combopoint = GetComboPoints(uid);
		local combopoints = GetComboPoints(uid) / 5;
]]); 
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("COMBO_POINTS");
			mux:Event_UnitMask("UNIT_COMBO_POINTS", mask);
		end
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local chk_useplayer = VFLUI.Checkbox:new(ui); chk_useplayer:Show();
		chk_useplayer:SetText(VFLI.i18n("Use player and vehicle"));
		if desc and desc.useplayer then chk_useplayer:SetChecked(true); else chk_useplayer:SetChecked(); end
		ui:InsertFrame(chk_useplayer);

		function ui:GetDescriptor()
			return {
				feature = "Variable combo";
				useplayer = chk_useplayer:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() return { feature = "Variable combo" }; end
});