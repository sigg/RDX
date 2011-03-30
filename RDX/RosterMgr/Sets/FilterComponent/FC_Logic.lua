-- FC_Logic.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- Logical (and/or/not/etc) filter components.

RDXDAL.RegisterFilterComponentCategory(VFLI.i18n("Logic"));

-- Helper function for logic components. Generates the drag/drop UI boxes.
local function GenerateCompoundFilterUI(desc, parent, limitComps)	
	----------- The UI.
	local base = VFLUI.FilterDialogFrame:new(parent);
	base:Show();

	local container = VFLUI.CompoundFrame:new(base);
	base:SetChild(container);
	container:Show();

	local dragTarget, dragTargetEnabled = RDXDAL.GenerateFilterDropTarget(container), nil;
	dragTarget:Show();

	-- Toggle the presence of the drag target.
	local function AddDragTarget()
		if not dragTargetEnabled then
			dragTargetEnabled = true;
			container:InsertFrame(dragTarget); dragTarget:Show();
		end
	end
	local function RemoveDragTarget()
		if dragTargetEnabled then
			container:RemoveFrame(dragTarget); dragTarget:Hide();
			dragTargetEnabled = nil;
		end
	end
	local function ToggleDragTarget()
		local _,dy = container:GetGridSize();
		if (not limitComps) or (dy < limitComps) then AddDragTarget(); else RemoveDragTarget(); end
	end
	
	function dragTarget:OnDrop(dropped)
		RemoveDragTarget();
		local _,dy = container:GetGridSize();
		-- don't allow subcomponents to be added if we've exceeded the component limit
		if limitComps and (dy >= limitComps) then return; end
		-- Get the component type.
		local fc = RDXDAL.GetFilterComponentByName(dropped.data);
		if not fc then error(VFLI.i18n("CompoundFilterUI: an invalid filter component was drag-and-dropped.")); return; end
		local desc = fc.GetBlankDescriptor();
		fc = RDXDAL.GetFilterComponent(desc);
		local ui = fc.UIFromDescriptor(desc, container);
		if not ui then error(VFLI.i18n("CompoundFilterUI: could not invoke UIFromDescriptor on subcomponent.")); return; end
		-- Enable the close button on the subcomponent. Upon clicking the close button, it should destroy
		-- the subcomponent altogether, then update our layout.
		ui:EnableCloseButton(function()
			if container:RemoveFrame(ui) then 
				ui:Destroy();
				ToggleDragTarget();
				VFLUI.UpdateDialogLayout(container); 
			end
		end);
		-- Add the new subcomponent to the frame
		ui:Show();
		container:InsertFrame(ui);
		-- Readd the drop handle as appropriate.
		if (not limitComps) or ((dy + 1) < limitComps) then AddDragTarget(); end
		VFLUI.UpdateDialogLayout(container);
	end

	-- Insert preexisting frames
	for i=2,table.getn(desc) do
		local fc = RDXDAL.GetFilterComponent(desc[i]);
		if not fc then error(VFLI.i18n("CompoundFilterUI: there's an invalid subcomponent somewhere.")); return; end
		local ui = fc.UIFromDescriptor(desc[i], container);
		ui:Show();
		ui:EnableCloseButton(function()
			if container:RemoveFrame(ui) then 
				ui:Destroy();
				ToggleDragTarget();
				VFLUI.UpdateDialogLayout(container); 
			end
		end);
		container:InsertFrame(ui);
	end

	-- Insert drag target frame
	ToggleDragTarget();

	----------- The function that makes the filter from the UI.
	local ctype = desc[1];
	base.GetDescriptor = function(x)
		local ret = { ctype };
		for obj in container:Iterator() do
			if obj.GetDescriptor then table.insert(ret, obj:GetDescriptor()); end
		end
		return ret;
	end

	base.Destroy = VFL.hook(function(s) 
		RemoveDragTarget(); dragTarget:Destroy(); dragTarget = nil; dragTargetEnabled = nil;
	end, base.Destroy);

	return base;
end

-- Helper function for logic components. Iterates over all subcomponents, doing something
-- that's hopefully useful.
local function ForeachSubcomponent(desc, firstn, lastn, f)
	if not firstn then firstn = 2; end
	if not lastn then lastn = table.getn(desc); end
	if(lastn < firstn) then return nil, 0, 0; end
	local subfilter, fc, cnt = nil, nil, 0;
	for i=firstn,lastn do
		cnt = cnt + 1;
		subfilter = desc[i];
		fc = RDXDAL.GetFilterComponent(subfilter);
		if not fc then return nil, cnt, (lastn-firstn); end -- Early out if the descriptor is invalid
		if not f(subfilter, fc, i, firstn, lastn) then cnt = cnt + 1; else return nil, cnt, (lastn-firstn); end
	end
	-- Success
	return true, cnt, (lastn-firstn);
end

------------------------------------ COMPONENTS ----------------------------------------

RDXDAL.RegisterFilterComponent({
	name = "and", title = VFLI.i18n("And..."), category = VFLI.i18n("Logic"),
	UIFromDescriptor = function(desc, parent)
		local ui = GenerateCompoundFilterUI(desc, parent);
		ui:SetText(VFLI.i18n("And..."));
		return ui;
	end,
	GetBlankDescriptor = function() return {"and"}; end,
	FilterFromDescriptor = function(desc, metadata)
		local n = table.getn(desc);
		-- If no operands, it just returns true.
		if(n < 2) then return "(true)"; end
		-- Otherwise, build the expression from the operands
		local ret = "(";
		ForeachSubcomponent(desc, 2, n, function(sf, fc, idx, idx0, idx1) 
			ret = ret .. fc.FilterFromDescriptor(sf, metadata);
			if(idx < idx1) then ret = ret .. " and "; end
		end);
		return ret .. ")";
	end,
	EventsFromDescriptor = function(desc, metadata)
		ForeachSubcomponent(desc, 2, nil, function(sf, fc) fc.EventsFromDescriptor(sf, metadata); end);
	end,
	SetsFromDescriptor = function(desc, metadata)
		ForeachSubcomponent(desc, 2, nil, function(sf, fc) fc.SetsFromDescriptor(sf, metadata); end);
	end,
	ValidateDescriptor = function(desc)
		local x = true;
		if not ForeachSubcomponent(desc, 2, nil, function(sf, fc) x = x and fc.ValidateDescriptor(sf); end) then
			return nil
		else
			return x;
		end
	end
});

RDXDAL.RegisterFilterComponent({
	name = "or", title = VFLI.i18n("Or..."), category = VFLI.i18n("Logic"),
	UIFromDescriptor = function(desc, parent)
		local ui = GenerateCompoundFilterUI(desc, parent);
		ui:SetText(VFLI.i18n("Or..."));
		return ui;
	end,
	GetBlankDescriptor = function() return {"or"}; end,
	FilterFromDescriptor = function(desc, metadata)
		local n = table.getn(desc);
		-- If the AND has no operands, it just returns true.
		if(n < 2) then return "(true)"; end
		-- Otherwise, build the expression from the operands
		local ret = "(";
		ForeachSubcomponent(desc, 2, n, function(sf, fc, idx, idx0, idx1) 
			ret = ret .. fc.FilterFromDescriptor(sf, metadata);
			if(idx < idx1) then ret = ret .. " or "; end
		end);
		return ret .. ")";
	end,
	EventsFromDescriptor = function(desc, metadata)
		ForeachSubcomponent(desc, 2, nil, function(sf, fc) fc.EventsFromDescriptor(sf, metadata); end);
	end,
	SetsFromDescriptor = function(desc, metadata)
		ForeachSubcomponent(desc, 2, nil, function(sf, fc) fc.SetsFromDescriptor(sf, metadata); end);
	end,
	ValidateDescriptor = function(desc)
		local x = true;
		if not ForeachSubcomponent(desc, 2, nil, function(sf, fc) x = x and fc.ValidateDescriptor(sf); end) then
			return nil
		else
			return x;
		end
	end
});

RDXDAL.RegisterFilterComponent({
	name = "not", title = VFLI.i18n("Not..."), category = VFLI.i18n("Logic"),
	UIFromDescriptor = function(desc, parent)
		local ui = GenerateCompoundFilterUI(desc, parent, 1);
		ui:SetText(VFLI.i18n("Not..."));
		return ui;
	end,
	GetBlankDescriptor = function() return {"not"}; end,
	FilterFromDescriptor = function(desc, metadata)
		local n = table.getn(desc);
		-- If the NOT has no operands, it just returns true.
		if(n ~= 2) then return "(true)"; end
		-- Otherwise, build the expression from the operands
		local fc = RDXDAL.GetFilterComponent(desc[2]);
		if not fc then return "nil"; end
		return "(not " .. fc.FilterFromDescriptor(desc[2], metadata) .. ")";
	end,
	EventsFromDescriptor = function(desc, metadata)
		ForeachSubcomponent(desc, 2, nil, function(sf, fc) fc.EventsFromDescriptor(sf, metadata); end);
	end,
	SetsFromDescriptor = function(desc, metadata)
		ForeachSubcomponent(desc, 2, nil, function(sf, fc) fc.SetsFromDescriptor(sf, metadata); end);
	end,
	ValidateDescriptor = function(desc)
		local x = true;
		if not ForeachSubcomponent(desc, 2, nil, function(sf, fc) x = x and fc.ValidateDescriptor(sf); end) then
			VFL.print("error");
			return nil
		else
			return x;
		end
	end
});

RDXDAL.RegisterFilterComponent({
	name = "true", title = VFLI.i18n("True"), category = VFLI.i18n("Logic"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("True")); ui:Show();
		ui.GetDescriptor = function() return {"true"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"true"}; end,
	FilterFromDescriptor = function(desc, metadata)
		return "(true)";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

RDXDAL.RegisterFilterComponent({
	name = "false", title = VFLI.i18n("False"), category = VFLI.i18n("Logic"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("False")); ui:Show();
		ui.GetDescriptor = function() return {"false"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"false"}; end,
	FilterFromDescriptor = function(desc, metadata)
		return "(false)";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});
