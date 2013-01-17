-- PowerVar.lua
-- Sigg OpenRDX

RDX.RegisterFeature({
	name = "Variable: Fractional mana (fm)";
	title = "Vars Frac Power";
	category = VFLI.i18n("Variables");
	test = true;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if not desc.name then desc.name = "fm"; end
		if not desc.powertype then desc.powertype = "nil"; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("Var_" .. desc.name .. "_i");
		state:AddSlot("FracVar_" .. desc.name);
		state:AddSlot("FracVar_" .. desc.name .. "_i");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
		local ]] .. desc.name .. [[, ]] .. desc.name .. [[_i = 0.5, 0.5;
]]);
		else
			code:AppendCode([[
		local ]] .. desc.name .. [[, ]] .. desc.name .. [[_i = unit:FracPower(]] .. desc.powertype .. [[);
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("POWER");
			mux:Event_UnitMask("UNIT_POWER", mask);
		end
	end;

	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("fm"); end
		ui:InsertFrame(name);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Power Type:"));
		local dd_powerType = VFLUI.Dropdown:new(er, RDXUI.PowerSelectionFunc);
		dd_powerType:SetWidth(200); dd_powerType:Show();
		if desc and desc.powertype then 
			dd_powerType:SetSelection(desc.powertype); 
		else
			dd_powerType:SetSelection("nil");
		end
		er:EmbedChild(dd_powerType); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return {
				feature = "Variable: Fractional mana (fm)";
				name = name.editBox:GetText();
				powertype = dd_powerType:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() return { feature = "Variable: Fractional mana (fm)"; name = "fm"; powertype = "nil"; }; end
});

RDX.RegisterFeature({
	name = "Variable: Number power";
	title = "Vars Number Power";
	category = VFLI.i18n("Variables");
	test = true;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc.name then desc.name = "nm"; end
		if not desc.powertype then desc.powertype = "nil"; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("NumberVar_" .. desc.name);
		state:AddSlot("NumberVar_" .. desc.name .. "_i");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local ]] .. desc.name .. [[, ]] .. desc.name .. [[_i = 3, 3;
]]);
		else
			code:AppendCode([[
local ]] .. desc.name .. [[, ]] .. desc.name .. [[_i = unit:Power(]] .. desc.powertype .. [[) or 0;
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("POWER");
			mux:Event_UnitMask("UNIT_POWER", mask);
		end
	end;

	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("nm"); end
		ui:InsertFrame(name);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Power Type:"));
		local dd_powerType = VFLUI.Dropdown:new(er, RDXUI.PowerSelectionFunc);
		dd_powerType:SetWidth(200); dd_powerType:Show();
		if desc and desc.powertype then 
			dd_powerType:SetSelection(desc.powertype); 
		else
			dd_powerType:SetSelection("nil");
		end
		er:EmbedChild(dd_powerType); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return {
				feature = "Variable: Number power";
				name = name.editBox:GetText();
				powertype = dd_powerType:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() return { feature = "Variable: Number power"; name = "nm"; powertype = "nil"; }; end
});
