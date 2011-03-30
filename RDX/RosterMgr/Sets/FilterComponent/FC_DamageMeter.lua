-- FC_DamageMeter.lua
-- Sigg / OpenRDX

RDXDAL.RegisterFilterComponent({
	name = "tablemeter", title = VFLI.i18n("TableMeter..."), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("TableMeter...")); ui:Show();
		local container = VFLUI.CompoundFrame:new(ui);
		ui:SetChild(container); container:Show();
		
		local sf = VFLUI.Dropdown:new(container, RDXDB._fnListTabMeter, nil, nil, nil, 30);
		if desc[2] then
			sf:SetSelection(desc[2]);
		end
		sf:Show();
		container:InsertFrame(sf);

		local lb = VFLUI.LabeledEdit:new(container, 50);
		container:InsertFrame(lb);
		lb:SetText(VFLI.i18n("Lower bound")); lb.editBox:SetText(desc[3]);
		lb:Show();
		local ub = VFLUI.LabeledEdit:new(container, 50);
		container:InsertFrame(ub);
		ub:SetText(VFLI.i18n("Upper bound")); ub.editBox:SetText(desc[4]);
		ub:Show();

		ui.GetDescriptor = function(x)
			local lwr = lb.editBox:GetNumber(); if (not lwr) or (lwr < 0) then lwr = 0; end
			local upr = ub.editBox:GetNumber(); if (not upr) or (upr < 0) then upr = 1; end
			if(upr < lwr) then local temp = upr; upr = lwr; lwr = temp; end
			return {"tablemeter", sf:GetSelection(), lwr, upr};
		end

		return ui;
	end,
	GetBlankDescriptor = function() return {"tablemeter", "", 10000, 10000000}; end,
	FilterFromDescriptor = function(desc, metadata)
		local lb, ub, vexpr = desc[3], desc[4], "(unit:GetTableMeterValue('" .. desc[2] .. "'))";
		-- Generate the closures/locals
		local vC = RDXDAL.GenerateFilterUpvalue();
		table.insert(metadata, { class = "LOCAL", name = vC, value = vexpr });
		-- Generate the filtration expression.
		return "((" .. vC .. " >= " .. lb ..") and (" .. vC .. " <= " .. ub .."))";
	end;
	ValidateDescriptor = VFL.True;
	SetsFromDescriptor = VFL.Noop;
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, desc[2] .. "UNIT_METER_UPDATE");
	end;
});