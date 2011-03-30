-- DamageMeterVariable.lua
-- Sigg / OpenRDX
-- Rasgharroth

RDX.RegisterFeature({
	name = "var_tablemeter";
	title = VFLI.i18n("Vars TableMeter");
	category = VFLI.i18n("Variables");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc.name then return nil; end
		if not desc.tablemeter then return nil; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("BoolVar_b" .. desc.name);
		state:AddSlot("FracVar_f" .. desc.name);
		state:AddSlot("TextData_" .. desc.name .. "_text");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
local b]] .. desc.name .. [[, ]] .. desc.name .. [[, ]] .. desc.name .. [[_max, ]] .. desc.name .. [[_total = unit:GetTableMeterInfo("]] .. desc.tablemeter .. [[");
local ]] .. desc.name .. [[_text, f]] .. desc.name .. [[ = "", 0;
if ]] .. desc.name .. [[ and (]] .. desc.name .. [[ > 0) then
	]] .. desc.name .. [[_text = ]] .. desc.name .. [[ .. " / " .. strformat("%.1f", VFL.clamp(]] .. desc.name .. [[/]] .. desc.name .. [[_total, 0, 1) * 100) .. "%";
	f]] .. desc.name .. [[ = VFL.clamp(]] .. desc.name .. [[/]] .. desc.name .. [[_max, 0, 1);
end
]]); end);
		-- Event hinting
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		mux:Event_MaskAll(desc.tablemeter .."UNIT_METER_UPDATE", mux:GetPaintMask(desc.tablemeter .."METER_UPDATE"));
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("nm"); end
		ui:InsertFrame(name);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Table Meter:"));
		local dd_tabmeterId = VFLUI.Dropdown:new(er, RDXDB._fnListTabMeter, nil, nil, nil, 30);
		dd_tabmeterId:SetWidth(250); dd_tabmeterId:Show();
		if desc and desc.tablemeter then 
			dd_tabmeterId:SetSelection(desc.tablemeter); 
		end
		er:EmbedChild(dd_tabmeterId); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return {
				feature = "var_tablemeter";
				name = name.editBox:GetText();
				tablemeter = dd_tabmeterId:GetSelection();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function() return { feature = "var_tablemeter"; version = 1; name = "combatmeter1" }; end
});