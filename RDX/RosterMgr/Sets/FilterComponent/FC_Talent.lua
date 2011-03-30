---------------------------------------------------------------
-- Match subclasses
---------------------------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "subclasses", title = VFLI.i18n("Talents..."), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		-- Setup the base frame and the checkboxes for subclasses
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Subclasses..."));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(31, 2);
		-- Populate checkboxes
		for i=1,30 do 
			checks.checkBox[i]:SetText(VFL.strtcolor(RDXMD.GetColorSubClassById(i)) .. RDXMD.GetLocalSubclassById(i) .. "|r"); 
			if desc[i + 1] then checks.checkBox[i]:SetChecked(true); end
		end
		checks.checkBox[31]:SetText(VFL.strcolor(.5,.5,.5) .. VFLI.i18n("Unknown|r"));
		if desc[32] then checks.checkBox[31]:SetChecked(true); end

		ui.GetDescriptor = function(x)
			local ret = {"subclasses"};
			for i=1,31 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; else ret[i+1] = nil; end
			end
			return ret;
		end
		return ui;
	end,
	GetBlankDescriptor = function() return {"subclasses"}; end,
	FilterFromDescriptor = function(desc, metadata)
		-- Build the filtration array
		local v = RDXDAL.GenerateFilterUpvalue();
		local script = v .. "={};";
		for i=2,31 do
			if desc[i] then script = script .. v .. "[" .. i-1 .. "]=true;"; end
		end
		if desc[32] then script = script .. v .. "[0]=true;"; end
		table.insert(metadata, { class = "CLOSURE", name = v, script = script });
		-- Now, our filter expression is just a check on the closure array against the unit's subclass number.
		return "(" .. v .. "[unit:GetMainTalent()])";
	end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "ROSTER_UPDATE");
		RDXDAL.FilterEvents_FullUpdate(metadata, "UNIT_NDATA_SYNC");
	end,
	SetsFromDescriptor = VFL.Noop,
});