-- AbilityTracker.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics

------------------------------------------------------------------------
-- GUI Bossmods module for RDX
--   By: Trevor Madsen (Gibypri, Kilrogg realm)
--
-- Note:
--  Licensed exclusively to Raid Informatics
------------------------------------------------------------------------

local TrackedEvents = DispatchTable:new();
local ta = {};
-- VFLT.ZMSchedule(3, function() ta = RDXU.ta; end); -- good for testing, messy otherwise

local function SanitizeMobname(mobname)
	local ln = strlen(mobname);
	if strsub(mobname, ln, ln) == " " then
		return strsub(mobname, 1, ln-1), true;
	end
	return mobname, false;
end

local function GetMobTable(mobname)
	if not mobname then return; end
	return ta[mobname]
end
RDXBM.GetMobTable = GetMobTable;

local function GetAbilityTable(mobname, ability)
	local mt = GetMobTable(mobname);
	if not mt then return; end
	return mt[ability];
end
RDXBM.GetAbilityTable = GetAbilityTable;

local function GetMobList()
	local qq = {};
	if not ta then return qq; end
	for k,_ in pairs(ta) do
		table.insert(qq, { text = k });
	end
	return qq;
end
RDXBM.GetMobList = GetMobList;

local function GetAbilityList(mobname)
	local qq,st = {},GetMobTable(mobname);
	if not st then return qq; end
	for k,_ in pairs(st) do
		table.insert(qq, { text = k });
	end
	return qq;
end
RDXBM.GetAbilityList = GetAbilityList;

local dotdump = {};
-- we are sort of associating this dot with this mob
-- the difference is that it only applies to past dots
-- that have not already been 'dumped' to a mob
local function DumpDotToMob(src, ability)
	if not dotdump[ability] or #dotdump[ability] < 1 then return; end
	if not ta[src] then ta[src] = {}; ta[src][ability] = {};
	elseif not ta[src][ability] then ta[src][ability] = {}; end
	local qq = ta[src][ability];
	
	-- inject our recorded dots into the appropriate mob's table
	for _,v in pairs(dotdump[ability]) do
		table.insert(qq, v);
	end
	dotdump[ability] = {}; -- clear the dump
	
	-- resort them so they are in chronological order
	table.sort(qq, function(v1,v2) return v1.t < v2.t; end);
end

local function RecordDot(ability, spellId)
	dotdump[ability] = dotdump[ability] or {};
	table.insert(dotdump[ability], {
		ty = 2;
		t = GetTime();
		s = session;
		castStart = false;
		spellid = spellId;
	});
end

local function RecordBuffMob(src, ability, spellId)
	if not ta[src] then ta[src] = {}; ta[src][ability] = {};
	elseif not ta[src][ability] then ta[src][ability] = {}; end
	local qq = ta[src][ability];
	table.insert(qq, {
		ty = 3;
		t = GetTime();
		s = session;
		castStart = false;
		spellid = spellId;
	});
	table.sort(qq, function(v1,v2) return v1.t < v2.t; end);
end

--[[ ABILITY SOURCE TYPES:
0: normal
2: dot
3: buffmob
]]--

local function RecordAbility(src, ability, spellId, cast)
	if not ta[src] then ta[src] = {}; ta[src][ability] = {};
	elseif not ta[src][ability] then ta[src][ability] = {}; end
	local abt = ta[src][ability];
	local ty = 0;
	table.insert(abt, {
		ty = ty;
		t = GetTime();
		s = session;
		castStart = cast;
		spellid = spellId;
	});
end

-- returns the source and ability of an attack
-- or nil if none found.
local tasd = true;

local function ParseCombatStr2(rowtype, source, sourceGUID, target, targetGUID, spellname, spellid, dot)
	if (rowtype == 6) then
		RecordDot(spellname, spellid);
	elseif (rowtype == 1) and (dot == 14) then
		if source and spellname then DumpDotToMob(source, spellname); end
	elseif (rowtype == 23) then
		RecordBuffMob(target, spellname, spellid);
	elseif (rowtype == 21) then
		if source and spellname then RecordAbility(source, spellname, spellid, true); end
	elseif (rowtype == 1) then
		if source and spellname then RecordAbility(source, spellname, spellid, false); end
	end
end

local session = 1;
local function NewSession()
	session = session+1;
end

WoWEvents:Bind("PLAYER_REGEN_ENABLED", nil, function()
	NewSession();
end);

local function GetLastTime(t, i, buffer, cs)
	local curt,curs = t[i].t,t[i].s;
	while (i > 1) do
		i=i-1;
		if curs ~= t[i].s then return nil; end
		if curt - t[i].t > buffer and t[i].castStart == cs then
			return curt-t[i].t;
		end
	end
	return nil;
end

local function CalcData(abil)
	if not abil then return; end
	local casts, casttimes = {}, {};
	local last;
	local n = #abil;
	for i=2,n do
		if (abil[i-1].s == abil[i].s) then
			if (abil[i].castStart == false) then
				-- Succussful Cast:
				
				-- record (cast time - last cast time), cooldown
				local lt = GetLastTime(abil, i, 0.5, false);
				if lt then table.insert(casts, lt); end
		
				-- look for the start of this cast, record cast time
				local ct = GetLastTime(abil, i, 0.8, true);
				if ct then table.insert(casttimes, ct); end
			end
		end
	end
	
	local mn,median,mx = "?","?","?"
	if #casts >= 1 then
		table.sort(casts);
		mn = math.floor(casts[1]+.5);
		local mdidx = math.floor( (#casts/2) + .5 );
		median = math.floor(casts[mdidx]+.5);
		mx = math.floor(casts[#casts]+.5);		
	end
	
	local ct;
	if #casttimes < 1 then
		if #casts < 1 then
			ct = -1;
		else
			ct = 0;
		end
	else
		local mdidx = math.floor( (#casttimes/2) + .5 );
		ct = math.floor(casttimes[mdidx]+.5); -- the median casttime
	end
	
	local ty = 0;
	for i=1,#abil do
		if abil[i].ty > ty then
			ty = abil[i].ty;
		end
	end
	
	local ids = 0;
	for i=1,#abil do
		if abil[i].spellid then
			ids = abil[i].spellid;
			break;
		end
	end
	
	return mn, median, mx, ct, ty, #casts, ids;
end

RDXBM.GetAbilityInfo = CalcData;

RDXBM.BindAbilityEvents("atrack", TrackedEvents);

local function StartAbilityTracker()
	TrackedEvents:Bind("OMNI", nil, function(rowtype, source, sourceGUID, target, targetGUID, spellname, spellid)
		ParseCombatStr2(rowtype, source, sourceGUID, target, targetGUID, spellname, spellid);
	end, "BindBossmod");
	RDX.printI(VFLI.i18n("Bossmod Ability Tracker ON"));
	RDXU.atracker = true;
end

local function StopAbilityTracker()
	TrackedEvents:Unbind("BindBossmod");
	RDX.printI(VFLI.i18n("Bossmod Ability Tracker OFF"));
	RDXU.atracker = nil;
end

local function ToggleAbilityTracker()
	if RDXU.atracker then
		StopAbilityTracker();
	else
		StartAbilityTracker();
	end
end

RDXBM.StartAbilityTracker = StartAbilityTracker;
RDXBM.StopAbilityTracker = StopAbilityTracker;
RDXBM.ToggleAbilityTracker = ToggleAbilityTracker;
-------------------------------------------------------
-- Menu
-------------------------------------------------------

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	if RDXU.atracker then StartAbilityTracker(); end
end);


