-- FC_UnitStatus.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- Filter components dealing with unit status.

RDXDAL.RegisterFilterComponentCategory(VFLI.i18n("Unit Status"));

--------------------------------------------------------------------
-- HP/MANA
--------------------------------------------------------------------
local function GenHPMPUI(desc, parent, text, descrName)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(text); ui:Show();
		local container = VFLUI.CompoundFrame:new(ui);
		ui:SetChild(container); container:Show();

		local curr_miss = VFLUI.RadioGroup:new(container);
		container:InsertFrame(curr_miss);
		curr_miss:SetLayout(3, 3);
		curr_miss.buttons[1]:SetText(VFLI.i18n("Current")); curr_miss.buttons[2]:SetText(VFLI.i18n("Missing")); curr_miss.buttons[3]:SetText(VFLI.i18n("Max"));
		curr_miss:SetValue(desc[2]);
		curr_miss:Show();

		local perc_numer = VFLUI.RadioGroup:new(container);
		container:InsertFrame(perc_numer);
		perc_numer:SetLayout(2, 2);
		perc_numer.buttons[1]:SetText(VFLI.i18n("Percentage")); perc_numer.buttons[2]:SetText(VFLI.i18n("Numerical"));
		perc_numer:SetValue(desc[3]);
		perc_numer:Show();

		local lb = VFLUI.LabeledEdit:new(container, 50);
		container:InsertFrame(lb);
		lb:SetText(VFLI.i18n("Lower bound")); lb.editBox:SetText(desc[4]);
		lb:Show();
		local ub = VFLUI.LabeledEdit:new(container, 50);
		container:InsertFrame(ub);
		ub:SetText(VFLI.i18n("Upper bound")); ub.editBox:SetText(desc[5]);
		ub:Show();

		ui.GetDescriptor = function(x)
			local lwr = lb.editBox:GetNumber(); if (not lwr) or (lwr < 0) then lwr = 0; end
			local upr = ub.editBox:GetNumber(); if (not upr) or (upr < 0) then upr = 1; end
			if(upr < lwr) then local temp = upr; upr = lwr; lwr = temp; end
			return {descrName, curr_miss:GetValue(), perc_numer:GetValue(), lwr, upr};
		end

		return ui;
end
RDXDAL._GenHPMPFilterUI = GenHPMPUI;

RDXDAL.RegisterFilterComponent({
	name = "hp", title = VFLI.i18n("HP..."), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = function(desc, parent)
		return GenHPMPUI(desc, parent, VFLI.i18n("HP..."), "hp");
	end,
	GetBlankDescriptor = function() return {"hp", 1, 1, 0, 100}; end,
	FilterFromDescriptor = function(desc, metadata)
		local lb, ub, vexpr = desc[4], desc[5], "unit:Health()";
		-- Figure out whether we want fractional health or total health
		if desc[2] == 1 then -- current
			if desc[3] == 1 then -- current percentage
				lb = VFL.clamp( (lb/100), 0, 1);
				ub = VFL.clamp( (ub/100), 0, 1);
				vexpr = "(unit:FracHealth())";
			else -- current total
				vexpr = "(unit:Health())";
			end
		elseif desc[2] == 2 then -- missing
			if desc[3] == 1 then -- missing percentage
				lb = VFL.clamp( (lb/100), 0, 1);
				ub = VFL.clamp( (ub/100), 0, 1);
				vexpr = "(1 - unit:FracHealth())";
			else -- missing total
				vexpr = "(unit:MaxHealth() - unit:Health())";
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
	end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_HEALTH");
	end,
	SetsFromDescriptor = VFL.Noop,
});

RDXDAL.RegisterFilterComponent({
	name = "mana", title = VFLI.i18n("Power..."), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = function(desc, parent)
		return GenHPMPUI(desc, parent, VFLI.i18n("Mana/Rage/Energy..."), "mana");
	end,
	GetBlankDescriptor = function() return {"mana", 1, 1, 0, 100}; end,
	FilterFromDescriptor = function(desc, metadata)
		local lb, ub, vexpr = desc[4], desc[5], "unit:Power()";
		-- Figure out whether we want fractional health or total health
		if desc[2] == 1 then -- current
			if desc[3] == 1 then -- current percentage
				lb = VFL.clamp( (lb/100), 0, 1);
				ub = VFL.clamp( (ub/100), 0, 1);
				vexpr = "(unit:FracPower())";
			else -- current total
				vexpr = "(unit:Power())";
			end
		elseif desc[2] == 2 then -- missing
			if desc[3] == 1 then -- missing percentage
				lb = VFL.clamp( (lb/100), 0, 1);
				ub = VFL.clamp( (ub/100), 0, 1);
				vexpr = "(1 - unit:FracPower())";
			else -- missing total
				vexpr = "(unit:MaxPower() - unit:Power())";
			end
		elseif desc[2] == 3 then -- max
			vexpr = "(unit:MaxPower())";
		end
		-- Generate the closures/locals
		local vL, vU, vC = RDXDAL.GenerateFilterUpvalue(), RDXDAL.GenerateFilterUpvalue(), RDXDAL.GenerateFilterUpvalue();
		table.insert(metadata, { class = "CLOSURE", name = vL, script = vL .. "=" .. desc[4] .. ";" });
		table.insert(metadata, { class = "CLOSURE", name = vU, script = vU .. "=" .. desc[5] .. ";" });
		table.insert(metadata, { class = "LOCAL", name = vC, value = vexpr });
		-- Generate the filtration expression.
		return "((" .. vC .. " >= " .. lb ..") and (" .. vC .. " <= " .. ub .."))";
	end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_POWER");
	end,
	SetsFromDescriptor = VFL.Noop,
});

----------------------------------------------
-- Death filter component
----------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "dead", title = VFLI.i18n("Dead"), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = RDXDAL.TrivialFilterUI("dead", VFLI.i18n("Dead")),
	GetBlankDescriptor = function() return {"dead"}; end,
	FilterFromDescriptor = function() 
		return "(unit:IsDead())"; 
	end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_HEALTH");
	end,
	SetsFromDescriptor = VFL.Noop,
});

----------------------------------------------
-- Feigned death filter component
----------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "feigned", title = VFLI.i18n("Feigning Death"), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = RDXDAL.TrivialFilterUI("feigned", VFLI.i18n("Feigning Death")),
	GetBlankDescriptor = function() return {"feigned"}; end,
	FilterFromDescriptor = function() 
		return "(unit:IsFeigned())"; 
	end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_FEIGN_DEATH");
	end,
	SetsFromDescriptor = VFL.Noop,
});

----------------------------------------------
-- Online/offilne filter component
----------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "ol", title = VFLI.i18n("Online"), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = RDXDAL.TrivialFilterUI("ol", VFLI.i18n("Online")),
	GetBlankDescriptor = function() return {"ol"}; end,
	FilterFromDescriptor = function(desc, metadata) 
		return "(unit:IsOnline())"; 
	end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "ROSTER_UPDATE");
	end,
	SetsFromDescriptor = VFL.Noop,
});

