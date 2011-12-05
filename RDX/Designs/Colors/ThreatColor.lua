
local units = {
	{ text = "uid" },
	{ text = "nil" },
	{ text = "player" },
	{ text = "target" },
	{ text = "targettarget" },
	{ text = "targettargettarget" },
	{ text = "focus" },
	{ text = "focustarget" },
	{ text = "focustargettarget" },
	{ text = "pet" },
	{ text = "pettarget"},
	{ text = "pettargettarget"},
	{ text = "vehicle" },
};
local function unitSel() return units; end

RDX.RegisterFeature({
	name = "ColorVariable: Threat Color";
	title = VFLI.i18n("Color Threat");
	category = VFLI.i18n("Colors");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if (not desc.colorVar0) or (not desc.colorVar1) or (not desc.colorVar2) or (not desc.colorVar3) then
			VFL.AddError(errs, VFLI.i18n("Missing variable Color")); return nil;
		end
		if (not state:Slot("ColorVar_" .. desc.colorVar0)) or (not state:Slot("ColorVar_" .. desc.colorVar1)) or (not state:Slot("ColorVar_" .. desc.colorVar2)) or (not state:Slot("ColorVar_" .. desc.colorVar3)) then
			VFL.AddError(errs, VFLI.i18n("Invalid variable Color")); return nil;
		end
		if not desc.unit then desc.unit = "uid"; end
		if not desc.unitother then desc.unitother = "target"; end
		if desc.unit == "nil" then
			VFL.AddError(errs, VFLI.i18n("Unit could not be nil")); return nil;
		end
		
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("ColorVar_" .. desc.name);
		return true;
	end;
	ApplyFeature = function(desc, state)
		local unit = "";
		if desc.unit == "nil" or desc.unit == "uid" then
			unit = desc.unit;
		else
			unit = "'" .. desc.unit .. "'";
		end
		
		local unitother = "";
		if desc.unitother == "nil" or desc.unitother == "uid" then
			unitother = desc.unitother;
		else
			unitother = "'" .. desc.unitother .. "'";
		end
	
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[ = nil;
local threatSituation = UnitThreatSituation(]] .. unit .. [[, ]] .. unitother .. [[);
if threatSituation == 0 then
	]] .. desc.name .. [[ = ]] .. desc.colorVar0 .. [[;
elseif threatSituation == 1 then
	]] .. desc.name .. [[ = ]] .. desc.colorVar1 .. [[;
elseif threatSituation == 2 then
	]] .. desc.name .. [[ = ]] .. desc.colorVar2 .. [[;
elseif threatSituation == 3 then
	]] .. desc.name .. [[ = ]] .. desc.colorVar3 .. [[;
else
	]] .. desc.name .. [[ = ]] .. desc.colorVar0 .. [[;
end
			]]);
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("THREAT_SITUATION");
		mux:Event_UnitMask("UNIT_THREAT_SITUATION_UPDATE", mask);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);
		
		local er = VFLUI.EmbedRight(ui, "Unit (player)");
		local dd_unit = VFLUI.Dropdown:new(er, unitSel);
		dd_unit:SetWidth(100); dd_unit:Show();
		if desc and desc.unit then dd_unit:SetSelection(desc.unit); end
		er:EmbedChild(dd_unit); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, "Unit Threat Table (target)");
		local dd_unitother = VFLUI.Dropdown:new(er, unitSel);
		dd_unitother:SetWidth(100); dd_unitother:Show();
		if desc and desc.unitother then dd_unitother:SetSelection(desc.unitother); end
		er:EmbedChild(dd_unitother); er:Show();
		ui:InsertFrame(er);
		
		local colorVar0 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("No Threat color"), state, "ColorVar_");
		if desc and desc.colorVar0 then colorVar0:SetSelection(desc.colorVar0); end
		local colorVar1 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Gain aggro color"), state, "ColorVar_");
		if desc and desc.colorVar1 then colorVar1:SetSelection(desc.colorVar1); end
		local colorVar2 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Loss Aggro color"), state, "ColorVar_");
		if desc and desc.colorVar2 then colorVar2:SetSelection(desc.colorVar2); end
		local colorVar3 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Tanking color"), state, "ColorVar_");
		if desc and desc.colorVar3 then colorVar3:SetSelection(desc.colorVar3); end
		
		function ui:GetDescriptor()
			return {
				feature = "ColorVariable: Threat Color";
				name = name.editBox:GetText();
				unit = dd_unit:GetSelection();
				unitother = dd_unitother:GetSelection();
				colorVar0 = colorVar0:GetSelection(); colorVar1 = colorVar1:GetSelection(); colorVar2 = colorVar2:GetSelection(); colorVar3 = colorVar3:GetSelection();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "ColorVariable: Threat Color"; name = "ThreatColor"; unit = "uid"; unitother = "target";};
	end;
});