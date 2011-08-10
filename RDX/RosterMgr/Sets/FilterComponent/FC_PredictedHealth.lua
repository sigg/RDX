-- Predicted HP filter
RDXDAL.RegisterFilterComponent({
	name = "shp", title = VFLI.i18n("Predicted Heal"), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = function(desc, parent)
		return RDXDAL._GenHPMPFilterUI(desc, parent, VFLI.i18n("Predicted Heal"), "shp");
	end,
	GetBlankDescriptor = function() return {"shp", 1, 1, 0, 100}; end,
	FilterFromDescriptor = function(desc, metadata)
		local lb, ub, vexpr = desc[4], desc[5], "unit:SmartHealth()";
		-- Figure out whether we want fractional health or total health
		if desc[2] == 1 then -- current
			if desc[3] == 1 then -- current percentage
				lb = VFL.clamp( (lb/100), 0, 1);
				ub = VFL.clamp( (ub/100), 0, 1);
				vexpr = "(unit:FracSmartHealth())";
			else -- current total
				vexpr = "(unit:SmartHealth())";
			end
		elseif desc[2] == 2 then -- missing
			if desc[3] == 1 then -- missing percentage
				lb = VFL.clamp( (lb/100), 0, 1);
				ub = VFL.clamp( (ub/100), 0, 1);
				vexpr = "(1 - unit:FracSmartHealth())";
			else -- missing total
				vexpr = "(unit:MaxHealth() - unit:SmartHealth())";
			end
		elseif desc[2] == 3 then -- max
			vexpr = "(unit:MaxHealth())";
		end
		-- Generate the closures/locals
		local vL, vU, vC = RDXDAL.GenerateFilterUpvalue(), RDXDAL.GenerateFilterUpvalue(), RDXDAL.GenerateFilterUpvalue();
		table.insert(metadata, { class = "CLOSURE", name = vL, script = vL .. "=" .. desc[4] .. ";" });
		table.insert(metadata, { class = "CLOSURE", name = vU, script = vU .. "=" .. desc[5] .. ";" });
		table.insert(metadata, { class = "LOCAL", name = vC, value = vexpr });
		-- Generate the filtration expression.
		return "((" .. vC .. " >= " .. lb ..") and (" .. vC .. " <= " .. ub .."))";
	end;
	ValidateDescriptor = VFL.True;
	SetsFromDescriptor = VFL.Noop;
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_HEAL_PREDICTION");
	end;
});