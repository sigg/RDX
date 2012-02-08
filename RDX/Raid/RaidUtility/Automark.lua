-- Automark.lua
-- By Antonio "Cidan" Lobato of Eredar (US)
-- Automark allows users to assign a new click handler to mouse bindings that
-- creates an "automark" on a player.  After you set an automark, whatever
-- that player targets will always update with whatever raid mark you have selected,
-- in real time.
RDXAM = {};
RDXAM.Marks = {};
RDXAM.UnitMarks = {};
RDXAM.NameToNumber = {
	["Star"] = 1,
	["Circle"] = 2,
	["Diamond"] = 3,
	["Triangle"] = 4,
	["Moon"] = 5,
	["Square"] = 6,
	["Cross"] = 7,
	["Skull"] = 8
};

RDXAM.Menu = RDXPM.Menu:new();
RDXAM.SetMark = function(unit, name, mark)
	RDXAM.Marks[name] = mark;
	RDXAM.UnitMarks[unit] = mark;
end

RDXAM.ShowMenu = function(frame, unit)
	local name = UnitName(unit);
	local currentMark = RDXAM.Marks[name];
	RDXAM.Menu:ResetMenu();
	
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		ent.text = "Automark for " .. UnitName(unit);
		ent.notCheckable = true;
		ent.isTitle = true;
		ent.justifyH = "CENTER";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Star"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_1";
	end);
	
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Circle"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_2";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Diamond"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_3";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Triangle"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_4";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Moon"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_5";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Square"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_6";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Cross"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_7";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = "Skull"
		ent.text = mark;
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
		ent.icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8";
	end);
	RDXAM.Menu:RegisterMenuFunction(function(ent)
		local mark = nil;
		ent.text = "None";
		if currentMark == mark then ent.checked = true; else ent.checked = false; end
		ent.func = function() RDXAM.SetMark(unit, name, mark); end;
	end);
	
	RDXAM.Menu:Open();
end

RDX.RegisterClickAction({
	name = "automark"; 
	title = "Set Automark";
	GetUI = VFL.Nil;
	GetClickFunc = function(desc)
		return VFL.Noop;
	end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "unitmenu");
		uf.unitmenu = RDXAM.ShowMenu;
	end;
});

-- Initial load
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	local function asupdate()
		for unit,mark in pairs(RDXAM.UnitMarks) do
			if UnitExists(unit.."-target") then
				if GetRaidTargetIndex(unit.."-target") == RDXAM.NameToNumber[mark] then return; end
				SetRaidTarget(unit.."-target", RDXAM.NameToNumber[mark]);
			else
				if GetRaidTargetIndex(unit) == RDXAM.NameToNumber[mark] then return; end
				SetRaidTarget(unit, RDXAM.NameToNumber[mark]);
			end
		end
	end
	VFLT.AdaptiveSchedule2("Automark", 1, asupdate);
	VFLP.RegisterFunc("RDX", "Automark", asupdate, true);
end);

RDXEvents:Bind("ROSTER_UPDATE", nil, function()
	for unit,mark in pairs(RDXAM.UnitMarks) do
		local name = UnitName(unit);
		if name ~= nil then
			-- Unit name does not match unit id for previously held mark
			if RDXAM.Marks[name] ~= mark then
				RDXAM.Marks[name] = nil;
				RDXAM.SetMark(unit, UnitName(unit), mark);
			end
		else
			RDXAM.UnitMarks[unit] = nil;
		end
	end
end);
