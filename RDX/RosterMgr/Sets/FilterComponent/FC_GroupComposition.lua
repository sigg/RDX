-- FC_GroupComposition.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- Filter components relating to raid-group composition.
RDXDAL.RegisterFilterComponentCategory(VFLI.i18n("Group Composition"));

--------------------------------
-- Match anyone in the raid
--------------------------------
RDXDAL.RegisterFilterComponent({
	name = "ne1", title = VFLI.i18n("Everyone"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Everyone")); ui:Show();
		ui.GetDescriptor = function() return {"ne1"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"ne1"}; end,
	FilterFromDescriptor = function(desc, metadata)
		return "(true)";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

--------------------------------
-- Match the player
--------------------------------
RDXDAL.RegisterFilterComponent({
	name = "me", title = VFLI.i18n("Me"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Me")); ui:Show();
		ui.GetDescriptor = function() return {"me"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"me"}; end,
	FilterFromDescriptor = function(desc, metadata)
		return "(unit.me)";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

--------------------------------
-- Individual groups
--------------------------------
RDXDAL.RegisterFilterComponent({
	name = "groups", title = VFLI.i18n("Groups"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		-- Setup the base frame and the checkboxes for groups
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Groups"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(8, 2);
		for i=1,8 do 
			checks.checkBox[i]:SetText(VFLI.i18n("Group") .. " " .. i);
			if desc[i + 1] then checks.checkBox[i]:SetChecked(true); end
		end

		ui.GetDescriptor = function(x)
			local ret = {"groups"};
			for i=1,8 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; else ret[i+1] = nil; end
			end
			return ret;
		end

		return ui;
	end,
	GetBlankDescriptor = function() return {"groups"}; end,
	FilterFromDescriptor = function(desc, metadata)
		-- Build the filtration array.
		local v = RDXDAL.GenerateFilterUpvalue();
		local script = v .. "={};";
		for i=2,9 do
			if desc[i] then script = script .. v .. "[" .. i-1 .. "]=true;"; end
		end
		table.insert(metadata, { class = "CLOSURE", name = v, script = script });
		-- Now, our filter expression is just a check on the closure array against the unit's group number.
		return "(" .. v .. "[unit:GetGroup()])";
	end,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "ROSTER_UPDATE");
	end,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

RDXDAL.RegisterFilterComponent({
	name = "mygroup", title = VFLI.i18n("My Group"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("My Group")); ui:Show();
		ui.GetDescriptor = function() return {"mygroup"}; end
		return ui;
	end,
	GetBlankDescriptor = function() return {"mygroup"}; end,
	FilterFromDescriptor = function(desc, metadata)
		table.insert(metadata, {class = "LOCAL", name = "myunit", value = "RDXDAL.GetMyUnit()"})
		return "(unit:GetGroup() == myunit:GetGroup())";
	end,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "ROSTER_UPDATE");
	end,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

RDXDAL.RegisterFilterComponent({
	name = "mygroupid", title = VFLI.i18n("My Group ID"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		-- Setup the base frame and the checkboxes for groups
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("My Group ID"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(4, 2);
		for i=1,4 do 
			checks.checkBox[i]:SetText(VFLI.i18n("Member") .. " " .. i);
			if desc[i + 1] then checks.checkBox[i]:SetChecked(true); end
		end

		ui.GetDescriptor = function(x)
			local ret = {"mygroupid"};
			for i=1,4 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; else ret[i+1] = nil; end
			end
			return ret;
		end

		return ui;
	end,
	GetBlankDescriptor = function() return {"mygroupid"}; end,
	FilterFromDescriptor = function(desc, metadata)
		-- Build the filtration array.
		local v = RDXDAL.GenerateFilterUpvalue();
		local script = v .. "={};";
		for i=2,5 do
			if desc[i] then script = script .. v .. "[" .. i-1 .. "]=true;"; end
		end
		table.insert(metadata, { class = "CLOSURE", name = v, script = script });
		return "(" .. v .. "[unit:GetMemberGroupId()])";
	end,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "ROSTER_UPDATE");
	end,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

---------------------------------------------------------------
-- Match classes
---------------------------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "classes", title = VFLI.i18n("Classes"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		-- Setup the base frame and the checkboxes for groups
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Classes"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(11, 2);
		-- Populate checkboxes
		for i=1,11 do 
			checks.checkBox[i]:SetText(VFL.strtcolor(RDXMD.GetClassColor(i)) .. RDXMD.GetClassMnemonic(i) .. "|r"); 
			if desc[i + 1] then checks.checkBox[i]:SetChecked(true); end
		end
		checks.checkBox[12]:SetText(VFL.strcolor(.5,.5,.5) .. VFLI.i18n("Unknown") .. "|r");
		if desc[13] then checks.checkBox[12]:SetChecked(true); end

		ui.GetDescriptor = function(x)
			local ret = {"classes"};
			for i=1,12 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; else ret[i+1] = nil; end
			end
			return ret;
		end

		return ui;
	end,
	GetBlankDescriptor = function() return {"classes"}; end,
	FilterFromDescriptor = function(desc, metadata)
		-- Build the filtration array
		local v = RDXDAL.GenerateFilterUpvalue();
		local script = v .. "={};";
		for i=2,12 do
			if desc[i] then script = script .. v .. "[" .. i-1 .. "]=true;"; end
		end
		if desc[12] then script = script .. v .. "[0]=true;"; end
		table.insert(metadata, { class = "CLOSURE", name = v, script = script });
		-- Now, our filter expression is just a check on the closure array against the unit's class
		return "(" .. v .. "[unit:GetClassID()])";
	end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "ROSTER_UPDATE");
	end,
	SetsFromDescriptor = VFL.Noop,
});

RDXDAL.RegisterFilterComponent({
	name = "rl", title = VFLI.i18n("Leaders"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Leaders"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(2,2);
		checks.checkBox[1]:SetText(VFLI.i18n("(L) Leader")); if desc[2] then checks.checkBox[1]:SetChecked(true); end
		checks.checkBox[2]:SetText(VFLI.i18n("(A) Assistant")); if desc[3] then checks.checkBox[2]:Setchecked(true); end
		
		ui.GetDescriptor = function(x)
			local ret = {"rl"};
			for i=1,2 do if checks.checkBox[i]:GetChecked() then ret[i+1] = true; end end
			return ret;
		end
		
		return ui;
	end,
	GetBlankDescriptor = function() return {"rl"}; end,
	FilterFromDescriptor = function() return "(true)"; end,
	ValidateDescriptor = VFL.True,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "ROSTER_UPDATE");
	end,
	SetsFromDescriptor = VFL.Noop,
});

----------------------------------------------
-- Player vs. pet unit mask component -- deprecated
----------------------------------------------
--[[
RDXDAL.RegisterFilterComponent({
	name = "nidmask"; title = VFLI.i18n("Player and Pet"); category = VFLI.i18n("Group Composition");
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Player and Pet"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(2,2);
		checks.checkBox[1]:SetText(VFLI.i18n("Match players")); checks.checkBox[2]:SetText(VFLI.i18n("Match pets"));
		for i=1,2 do
			if desc[i+1] then checks.checkBox[i]:SetChecked(true); end
		end

		function ui:GetDescriptor()
			local ret = {"nidmask"};
			for i=1,2 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; end
			end
			return ret;
		end

		return ui;
	end;
	GetBlankDescriptor = function() return {"nidmask"}; end;
	FilterFromDescriptor = function(desc, metadata)
		local lowv, highv = 1, 40;
		if desc[2] and desc[3] then
			lowv = 1; highv = 80; -- players and pets
		elseif desc[2] then
			lowv = 1; highv = 40; -- players
		elseif desc[3] then
			lowv = 41; highv = 80; -- just pets
		end
		table.insert(metadata, {class = "LOCAL", name = "nid", value = "unit.nid"})
		return "(nid and (nid >= " .. lowv ..") and (nid <= " .. highv .. "))";
	end;
	EventsFromDescriptor = VFL.Noop;
	SetsFromDescriptor = VFL.Noop;
	ValidateDescriptor = VFL.True;
});

----------------------------------------------
-- Arena component
----------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "arenaold"; title = VFLI.i18n("Arena and Pet"); category = VFLI.i18n("Group Composition");
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Arena"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(2,2);
		checks.checkBox[1]:SetText(VFLI.i18n("Match players")); checks.checkBox[2]:SetText(VFLI.i18n("Match pets"));
		for i=1,2 do
			if desc[i+1] then checks.checkBox[i]:SetChecked(true); end
		end

		function ui:GetDescriptor()
			local ret = {"arena"};
			for i=1,2 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; end
			end
			return ret;
		end

		return ui;
	end;
	GetBlankDescriptor = function() return {"arena"}; end;
	FilterFromDescriptor = function(desc, metadata)
		local lowv, highv = 81, 85;
		if desc[2] or desc[3] then
			if not desc[2] then lowv = 86; highv = 90; -- just pets
			elseif desc[3] then lowv = 81; highv = 90; -- players and pets
			end
		end
		table.insert(metadata, {class = "LOCAL", name = "nid", value = "unit.nid"})
		return "(nid and (nid >= " .. lowv ..") and (nid <= " .. highv .. "))";
	end;
	EventsFromDescriptor = VFL.Noop;
	SetsFromDescriptor = VFL.Noop;
	ValidateDescriptor = VFL.True;
});
]]

RDXDAL.RegisterFilterComponent({
	name = "nidmask", title = VFLI.i18n("Raid"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Raid")); ui:Show();
		ui.GetDescriptor = function() return {"nidmask"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"nidmask"}; end,
	FilterFromDescriptor = function(desc, metadata)
		table.insert(metadata, {class = "LOCAL", name = "raidnid", value = "unit.nid"})
		return "(raidnid and (raidnid >= 1) and (raidnid <= 40))";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

RDXDAL.RegisterFilterComponent({
	name = "raidpet", title = VFLI.i18n("Raid Pet"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Raid Pet")); ui:Show();
		ui.GetDescriptor = function() return {"raidpet"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"raidpet"}; end,
	FilterFromDescriptor = function(desc, metadata)
		table.insert(metadata, {class = "LOCAL", name = "raidpetnid", value = "unit.nid"})
		return "(raidpetnid and (raidpetnid >= 41) and (raidpetnid <= 80))";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

-- deprecated
--RDXDAL.RegisterFilterComponent({
--	name = "raidpetsecure", title = VFLI.i18n("Raid Pet Secure"), category = VFLI.i18n("Group Composition"),
--	UIFromDescriptor = function(desc, parent)
--		local ui = VFLUI.FilterDialogFrame:new(parent);
--		ui:SetText(VFLI.i18n("Raid Pet Secure")); ui:Show();
--		ui.GetDescriptor = function() return {"raidpetsecure"}; end;
--		return ui;
--	end,
--	GetBlankDescriptor = function() return {"raidpetsecure"}; end,
--	FilterFromDescriptor = function(desc, metadata)
--		table.insert(metadata, {class = "LOCAL", name = "raidpetsecurenid", value = "unit.nid"})
--		return "(raidpetsecurenid and (raidpetsecurenid >= 1) and (raidpetsecurenid <= 40))";
--	end,
--	EventsFromDescriptor = VFL.Noop,
--	SetsFromDescriptor = VFL.Noop,
--	ValidateDescriptor = VFL.True,
--});

RDXDAL.RegisterFilterComponent({
	name = "arena", title = VFLI.i18n("Arena"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Arena")); ui:Show();
		ui.GetDescriptor = function() return {"arena"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"arena"}; end,
	FilterFromDescriptor = function(desc, metadata)
		table.insert(metadata, {class = "LOCAL", name = "arenanid", value = "unit.nid"})
		return "(arenanid and (arenanid >= 81) and (arenanid <= 85))";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

RDXDAL.RegisterFilterComponent({
	name = "arenapet", title = VFLI.i18n("Arena Pet"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Arena Pet")); ui:Show();
		ui.GetDescriptor = function() return {"arenapet"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"arenapet"}; end,
	FilterFromDescriptor = function(desc, metadata)
		table.insert(metadata, {class = "LOCAL", name = "arenapetnid", value = "unit.nid"})
		return "(arenapetnid and (arenapetnid >= 86) and (arenapetnid <= 90))";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

RDXDAL.RegisterFilterComponent({
	name = "boss", title = VFLI.i18n("Boss"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Boss")); ui:Show();
		ui.GetDescriptor = function() return {"boss"}; end;
		return ui;
	end,
	GetBlankDescriptor = function() return {"boss"}; end,
	FilterFromDescriptor = function(desc, metadata)
		table.insert(metadata, {class = "LOCAL", name = "bossnid", value = "unit.nid"})
		return "(bossnid and (bossnid >= 91) and (bossnid <= 94))";
	end,
	EventsFromDescriptor = VFL.Noop,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

----------------------------------------------
-- Power type filter component
----------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "ptype", title = VFLI.i18n("Power Type"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		-- Create checkboxes for each power type
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Power Type"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(4, 4);
		checks.checkBox[1]:SetText(VFLI.i18n("Mana"));
		checks.checkBox[2]:SetText(VFLI.i18n("Rage"));
		checks.checkBox[3]:SetText(VFLI.i18n("Energy"));
		checks.checkBox[4]:SetText(VFLI.i18n("Rune"));
		for i=1,4 do 
			if desc[i + 1] then checks.checkBox[i]:SetChecked(true); end
		end
		ui.GetDescriptor = function(x)
			local ret = {"ptype"};
			for i=1,4 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; end
			end
			return ret;
		end

		return ui;
	end,
	GetBlankDescriptor = function() return {"ptype"}; end,
	FilterFromDescriptor = function(desc, metadata)
		-- Build the filtration array.
		local v = RDXDAL.GenerateFilterUpvalue();
		local script = v .. "={};";
		if desc[2] then script = script .. v .. "[0]=true;"; end  -- mana
		if desc[3] then script = script .. v .. "[1]=true;"; end  -- rage
		if desc[4] then script = script .. v .. "[3]=true;"; end  -- energy
		if desc[5] then script = script .. v .. "[6]=true;"; end  -- rune
		table.insert(metadata, { class = "CLOSURE", name = v, script = script });
		return "(" .. v .. "[unit:PowerType()])";
	end,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_UnitUpdate(metadata, "UNIT_DISPLAYPOWER");
	end,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

RDXDAL.RegisterFilterComponent({
	name = "role", title = VFLI.i18n("Role Type"), category = VFLI.i18n("Group Composition"),
	UIFromDescriptor = function(desc, parent)
		-- Create checkboxes for each power type
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("Role Type"));
		local checks = VFLUI.CheckGroup:new(ui);
		ui:SetChild(checks);
		checks:SetLayout(4, 4);
		checks.checkBox[1]:SetText(VFLI.i18n("Tank"));
		checks.checkBox[2]:SetText(VFLI.i18n("DPS"));
		checks.checkBox[3]:SetText(VFLI.i18n("Healer"));
		checks.checkBox[4]:SetText(VFLI.i18n("Unknown"));
		for i=1,4 do 
			if desc[i + 1] then checks.checkBox[i]:SetChecked(true); end
		end
		ui.GetDescriptor = function(x)
			local ret = {"role"};
			for i=1,4 do
				if checks.checkBox[i]:GetChecked() then ret[i+1] = true; end
			end
			return ret;
		end

		return ui;
	end,
	GetBlankDescriptor = function() return {"role"}; end,
	FilterFromDescriptor = function(desc, metadata)
		-- Build the filtration array.
		local v = RDXDAL.GenerateFilterUpvalue();
		local script = v .. "={};";
		if desc[2] then script = script .. v .. "[1]=true;"; end
		if desc[3] then script = script .. v .. "[2]=true;"; end
		if desc[4] then script = script .. v .. "[3]=true;"; end 
		if desc[5] then script = script .. v .. "[4]=true;"; end
		table.insert(metadata, { class = "CLOSURE", name = v, script = script });
		return "(" .. v .. "[unit:GetRoleType()])";
	end,
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_UnitUpdate(metadata, "PARTY_MEMBERS_CHANGED");
	end,
	SetsFromDescriptor = VFL.Noop,
	ValidateDescriptor = VFL.True,
});

