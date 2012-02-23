-- AggroSet.lua
-- RDX
-- (C)2007 Raid Informatics
--
-- A set class matching all people who are being targeted by a hostile entity.

-- Locals
local aggromap = {};
local aggroUpdatePeriod = 0.5;
local strlower = string.lower;
local GetUnitByName = RDXDAL.GetUnitByNameIfInGroup;
local GetUnitByNumber = RDXDAL.GetUnitByNumber;

-- The aggro map is the "feeder" for the aggro set.
local unit, uid, t, tt;
local function UpdateAggroMap()
	for i=1,40 do aggromap[i] = false; end
	for i=1,40 do
		unit = GetUnitByNumber(i);
		if unit:IsCacheValid() then
			uid = unit.uid; t = uid .. "target"; tt = t .. "target";
			-- "Target" must be hostile and "targettarget" must be friendly
			if UnitExists(tt) and UnitIsEnemy(uid, t) and UnitIsFriend(uid, tt) then
				-- If so "targettarget" has aggro.
				unit = GetUnitByName(strlower(UnitName(tt)));
				if unit then aggromap[unit.nid] = true;	end
			end
		end
	end
end

-- The set
local aggroSet = RDXDAL.Set:new();
aggroSet.name = "Has Aggro<>";
RDXDAL.RegisterSet(aggroSet);

local function UpdateAggroSet()
	UpdateAggroMap();
	for i=1,40 do aggroSet:_Set(i, aggromap[i]); end
end
VFLP.RegisterFunc("RDX", "AggroUpdate", UpdateAggroSet, true);

function aggroSet:_OnActivate()
	VFLT.AdaptiveUnschedule2("AggroUpdate");
	VFLT.AdaptiveSchedule2("AggroUpdate", aggroUpdatePeriod, UpdateAggroSet);
end
function aggroSet:_OnDeactivate()
	VFLT.AdaptiveUnschedule2("AggroUpdate");
end

RDXDAL.RegisterSetClass({
	name = "ags"; title = VFLI.i18n("Has Aggro");
	GetUI = RDXDAL.TrivialSetFinderUI("ags");
	FindSet = function() return aggroSet; end;
});

-------------------------------------------------------
-- Combat Set
-------------------------------------------------------

local combatmap = {};
local combatUpdatePeriod = 0.5;

-- The aggro map is the "feeder" for the aggro set.
local unit1;
local function UpdateCombatMap()
	for i=1,40 do combatmap[i] = false; end
	for i=1,40 do
		unit1 = GetUnitByNumber(i);
		if unit1:IsCacheValid() and UnitAffectingCombat(unit1.uid) then
			combatmap[unit1.nid] = true;
		end
	end
end

local combatSet = RDXDAL.Set:new();
combatSet.name = "In Combat<>";
RDXDAL.RegisterSet(combatSet);


local function UpdateCombatSet()
	UpdateCombatMap();
	for i=1,40 do combatSet:_Set(i, combatmap[i]); end
end

function combatSet:_OnActivate()
	VFLT.AdaptiveUnschedule2("CombatUpdate");
	VFLT.AdaptiveSchedule2("CombatUpdate", combatUpdatePeriod, UpdateCombatSet);
end
function combatSet:_OnDeactivate()
	VFLT.AdaptiveUnschedule2("CombatUpdate");
end

RDXDAL.RegisterSetClass({
	name = "combatset"; title = VFLI.i18n("In Combat");
	GetUI = RDXDAL.TrivialSetFinderUI("combatset");
	FindSet = function() return combatSet; end;
});

-- A set class matching all people who are Assisting me

local assistmap = {};
local assistUpdatePeriod = 0.5;

local function UpdateAssistMap()
	for i=1,40 do assistmap[i] = false; end
	for i=1,40 do
		unit = GetUnitByNumber(i);
		if unit:IsCacheValid() and UnitExists("target") then
			uid = unit.uid; t = uid .. "target";
			if not UnitIsUnit(t, "target") then
				unit = GetUnitByName(strlower(UnitName(tt)));
				if unit then assistmap[unit.nid] = true; end
			end
		end
	end
end

local assistSet = RDXDAL.Set:new();
assistSet.name = "Assist Me Not<>";
RDXDAL.RegisterSet(assistSet);

local function UpdateAssistSet()
	UpdateAssistMap();
	for i=1,40 do assistSet:_Set(i, assistmap[i]); end
end

function assistSet:_OnActivate()
	VFLT.AdaptiveUnschedule2("AssistUpdate");
	VFLT.AdaptiveSchedule2("AssistUpdate", assistUpdatePeriod, UpdateAssistSet);
end
function assistSet:_OnDeactivate()
	VFLT.AdaptiveUnschedule2("AssistUpdate");
end

RDXDAL.RegisterSetClass({
	name = "assists"; title = VFLI.i18n("Who Assist Me");
	GetUI = RDXDAL.TrivialSetFinderUI("assists");
	FindSet = function() return assistSet; end;
});

