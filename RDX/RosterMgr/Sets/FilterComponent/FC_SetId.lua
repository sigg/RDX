--- "Set by SID" filter component.
RDXDAL.RegisterFilterComponent({
	name = "ssid", title = "Set By SID (Debug)", category = "Sets",
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText("Set By SID (Debug)"); ui:Show();
		
		local ed = VFLUI.LabeledEdit:new(ui, 50);
		ui:SetChild(ed);
		ed:SetText("SID"); ed:Show();

		ui.GetDescriptor = function(x)
			local sid = ed.editBox:GetNumber(); if not sid then sid = 1; end
			return {"ssid", sid};
		end
		
		return ui;
	end,
	GetBlankDescriptor = function() return {"ssid"}; end,
	FilterFromDescriptor = function(desc, metadata)
		if not desc[2] then return "(true)"; end
		local theSet = RDXDAL.GetSetByID(desc[2]);
		if not theSet then return "(true)"; end
		local v = RDXDAL.GenerateFilterUpvalue();
		table.insert(metadata, {
			class = "CLOSURE", name = v,
			script = v .. "=RDXDAL.GetSetByID(" .. desc[2] .. ");"
		});
		return "(" .. v .. ":IsMember(unit))";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = function(desc, metadata)
		if desc[2] then
			metadata[desc[2]] = true;
		end
	end
});
