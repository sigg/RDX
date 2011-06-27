-- Log.lua
-- RDX - Project Omniscience
-- (C)2006 Bill Johnson
--

RDXLF = RegisterVFLModule({
	name = "Logger Facility";
	title = VFLI.i18n("Logger Facility");
	description = "Logger Facility";
	version = {1,0,0};
	parent = RDX;
});

-- Imports
local match, gmatch, lower = string.find, string.gmatch, string.lower;
local GetUnitByGUIDIfInGroup = RDXDAL.GetUnitByGUIDIfInGroup;
local GetUnitByGUID = RDXDAL.GetUnitByGUID;
local band = bit.band;
local empty = VFL.empty;

local logTrigger = RDXEvents:LockSignal("LOG_ROW_ADDED");

-------------------------------------------
-- LOOKUP METADATA: BUFFS TO TRACK
-- Omniscience doesn't ordinarily record buffs because the log would be overspammed
-- with buff info. Certain exceptions (shield wall, last stand, etc.) are recorded here.
-------------------------------------------
--[[
local trackedBuffs = {};
trackedBuffs[VFLI.i18n("Shield Block")] = true;
trackedBuffs[VFLI.i18n("Shield Wall")] = true;
trackedBuffs[VFLI.i18n("Gift of Life")] = true;
trackedBuffs[VFLI.i18n("Last Stand")] = true;
trackedBuffs[VFLI.i18n("Power Word: Shield")] = true;
Omni.trackedBuffs = trackedBuffs;
]]--

-------------------------------------------
-- LOOKUP METADATA: DAMAGE TYPES
-------------------------------------------
local unknown = VFLI.i18n("Unknown");

local idToDmg = {
	[1] = "Physical",
	[2] = "Holy",
	[4] = "Fire",
	[8] = "Nature",
	[16] = "Frost",
	[32] = "Shadow",
	[64] = "Arcane",
};
RDXMD.idToDmg = idToDmg;

local dmgToId = VFL.invert(idToDmg);
RDXMD.dmgToId = dmgToId;

local strdt, idt = "", 0;
function RDXMD.GetDamageType(idx)
	if not idx then return unknown; end
	strdt, idt = "", 0;
	for k, v in pairs(idToDmg) do
		if band(k, idx) == 1 then
			strdt = strdt .. v .." ";
			idt = idt + 1;
		end
	end
	return strdt, idt;
end

-- default color, in case of multiple damage type, return _purple
local dmgTypeColors = {
	[1] = { r=1, g=1, b=0 }, 
	[2] = { r=1, g=1, b=.7 }, 
	[4] = { r=.95, g=.3, b= 0 }, 
	[8] = { r=.65, g=.9, b=.25 }, 
	[16] = { r=.25, g=.9, b=.92 }, 
	[32] = { r=.5, g=.13, b=.58 },
	[64] = { r=1, g=1, b=1 },
};

function RDXMD.GetDamageTypeColor(idx)
	if not idx then return _grey; end
	return dmgTypeColors[idx] or _grey;
end

local idToEvent = {
	"DamageIn",
	"DamageOut",
	"Damage",
	"MissedIn",
	"MissedOut",
	"Missed",
	"HealIn",
	"HealOut",
	"Heal",
	"CastStart",
	"CastSucess",
	"CastFailed",
	"CooldownAvail",
	"CooldownUsed",
	"+Buff",
	"-Buff",
	"+Debuff",
	"-Debuff",
	"+Enchant",
	"-Enchant",
	"Killing Blow",
	"Death",
	"Dispell",
	"DispellFailed",
	"Stolen",
	"Interrupt",
	"Resurrect",
	"Summon",
	"InstantKill",
	"+Combat",
	"-Combat",
	"+Encounter",
	"-Encounter", 
	"+Battleground",
	"-Battleground",
	"+pvp",
	"-pvp",
}
RDXMD.idToEvent = idToEvent;

local eventToId = VFL.invert(idToEvent);
RDXMD.eventToId = eventToId;

function RDXMD.GetEventType(idx)
	if not idx then return unknown; end
	return idToEvent[idx] or unknown;
end

-- see also VFL\Core\Color.lua for default color
local eventTypeColors = {
	_red, --"DamageIn", 1
	_orange, --"DamageOut",
	_white, --"Damage",
	_cyan, --"MissedIn",
	_purple, --"MissedOut",
	_white, --"Missed",
	_green, --"HealIn",
	_greensky, --"HealOut",
	_white, --"Heal",
	_white, --"CastStart", 10
	_white, --"CastSucess",
	_white, --"CastFailed"
	_white, --"CooldownAvail"
	_white, --"CooldownUsed"
	{r=0,g=1,b=0.75}, --"+Buff"
	{r=1,g=0.5,b=0.75}, --"-Buff"
	{r=.75, g=0, b=0}, --"+Debuff"
	{r=0.5,g=0.9,b=0}, --"-Debuff"
	{r=0,g=1,b=0.75}, --"+Enchant"
	{r=1,g=0.5,b=0.75}, --"-Enchant" 20
	{r=0,g=0.5,b=0}, --"Killing Blow"
	{r=0.5,g=0,b=0}, --"Death"
	_yellow, --"Dispell"
	_red, --"DispellFailed"
	_yellow, --"Stolen" 
	_yellow, --"Interrupt" 26
	_yellow, --"Resurrect"
	_yellow, --"Summon"
	_yellow, --"InstantKill"
	_grey, --"+Combat" 30
	_grey, --"-Combat" 
	_grey, --"+Encounter",
	_grey, --"-Encounter", 
	_grey, --"+Battleground",
	_grey, --"-Battleground",
	_grey, --"+pvp",
	_grey, --"-pvp",
};

function RDXMD.GetEventTypeColor(idx)
	if not idx then return _grey end
	return eventTypeColors[idx] or _grey;
end

-- An "impulse" is an event that actually does damage or healing...
--local impulseTypes = { [1] = "DamageIn", [2] = "DamageOut", [3] = "HealingIn", [4] = "HealingOut", [7] = "HealingSelf", [8] = "Healing" };
--function Omni.GetImpulseType(idx)
--	if not idx then return nil; end
--	return impulseTypes[idx];
--end

-- Determine if a row has a source/target
--function Omni.RowHasActors(idx)
--	return (idx == 1) or (idx == 2) or (idx == 3) or (idx == 4) or (idx == 7) or (idx == 8) or (idx == 16) or (idx == 21) or (idx == 22);
--end

-- If the actor is the SOURCE for this row type, return true.
--function Omni.RowActorIsSource(idx)
--	return (idx == 1) or (idx == 3) or (idx == 7) or (idx == 18) or (idx == 21);
--end

-- If the actor is the TARGET for this row type, return true
--function Omni.RowActorIsTarget(idx)
--	return (idx == 2) or (idx == 4) or (idx == 16) or (idx == 22);
--end


-------------------------------------------------------------------
-- LOOKUP METADATA: EXTENDED INFO
-- (1 = resist, 2 = block, 3 = absorb, 4 = crit, 5 = glancing, 6 = crusching)
-- (7 = overhealing, 8 = overkill, 9 = dot, 10 = hot)
-------------------------------------------------------------------
local extdToId = {
	["resist"] = 1,
	["block"] = 2,
	["absorb"] = 3,
	["crit"] = 4,
	["glancing"] = 5,
	["crushing"] = 6,
	["overhealing"] = 7,
	["overkill"] = 8,
	["dot"] = 9,
	["hot"] = 10,
};
RDXMD.extdToId = extdToId;

local idToExtd = VFL.invert(extdToId);
RDXMD.idToExtd = idToExtd;

function RDXMD.GetExtdType(idx)
	if not idx then return nil; end
	return idToExtd[idx] or "";
end

----------------------------------------------------------------------
-- LOGGING CORE
----------------------------------------------------------------------
-- Adds a row to the Omniscience combat log.
-- y = Type
-- tm = timestamp
-- s = Source
-- t = Target
-- sg = Sourceguid
-- tg = Targetguid
-- uh = health
-- uhm = health max
-- a = Ability (Name of ability or spell)
-- b = Ability Id or spell Id
-- x = Amount
-- d = Damage type
-- e = environmental type
-- u = aura type
-- ua = aura amount
-- m = Miss type
-- ma = Miss amount
-- r = range
-- xir = resist
-- xib = block
-- xia = absorb
-- xic = crit
-- xig = glancing
-- xicu = crushing
-- xioh = overhealing
-- xiok = overkill
-- xidot = dot
-- xihot = hot

local MyGUID, uselogall = nil, false;

-- Spell standard order
local spellId, spellName, spellSchool;
local extraSpellId, extraSpellName, extraSpellSchool;

-- For Melee/Ranged swings and enchants
local nameIsNotSpell, extraNameIsNotSpell; 

-- Damage standard order
local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, overhealing;
-- Miss argument order
local missType, amountMissed;
-- Aura arguments
local auraType; -- BUFF or DEBUFF

-- Enchant arguments
local itemId, itemName;

-- Special Spell values
local valueType = 1;  -- 1 = School, 2 = Power Type
local extraAmount; -- Used for Drains and Leeches
local powerType; -- Used for energizes, drains and leeches
local environmentalType; -- Used for environmental damage
local message; -- Used for server spell messages
local originalEvent; -- Used for spell links

local unitsrc;
local unittgt;

local subVal;

local lr = {};
local tu;

local function AddLogRow(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
	empty(lr);
	unitsrc = nil;
	unittgt = nil;
	--lr.tm = timestamp;
	lr.tm = VFLT.GetTimeTenths();
	lr.sg = sourceGUID;
	lr.s = sourceName;
	lr.tg = destGUID;
	lr.t = destName;
	if sourceGUID then unitsrc = GetUnitByGUIDIfInGroup(sourceGUID); end
	if destGUID then unittgt = GetUnitByGUIDIfInGroup(destGUID); end
	subVal = strsub(event, 1, 5);
	if (subVal == "SWING") then
		if (event == "SWING_DAMAGE") then
			if unitsrc then lr.y = 2; 
			elseif unittgt then lr.y = 1;
			else lr.y = 3;
			end
			lr.x, lr.xiok, lr.d, lr.xir, lr.xib, lr.xia, lr.xic, lr.xig, lr.xicu = select(1, ...);
			lr.x = lr.x - lr.xiok; -- amount = amount - overkill
			if unittgt then
				lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
			end
		elseif (event == "SWING_MISSED") then
			if unitsrc then lr.y = 5;
			elseif unittgt then lr.y = 4;
			else lr.y = 6;
			end
			lr.m = select(1, ...);
		end
	elseif (subVal == "SPELL") then 
		if (event == "SPELL_DAMAGE") then
			lr.b, lr.a, lr.d, lr.x, lr.xiok, _, lr.xir, lr.xib, lr.xia, lr.xic, lr.xig, lr.xicu = select(1, ...);
			lr.x = lr.x - lr.xiok; -- amount = amount - overkill
			if unitsrc then lr.y = 2;
			elseif unittgt then lr.y = 1;
			else lr.y = 3;
			end
			if unittgt then
				lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
			end
		elseif (event == "SPELL_HEAL") then
			if unitsrc then lr.y = 8; 
			elseif unittgt then lr.y = 7;
			else lr.y = 9;
			end
			lr.b, lr.a, lr.d, lr.x, lr.xioh, lr.xia, lr.xic = select(1, ...); 
			lr.x = lr.x - lr.xioh; -- amount = amount - overhealing
			if unittgt then
				lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
			end
		elseif (event == "SPELL_MISSED") then
			if unitsrc then lr.y = 5;
			elseif unittgt then lr.y = 4;
			else lr.y = 6;
			end
			lr.b, lr.a, lr.d, lr.m = select(1, ...);
		elseif (strsub(event, 1, 14) == "SPELL_PERIODIC") then
			if (event == "SPELL_PERIODIC_DAMAGE") then
				if unitsrc then lr.y = 2; 
				elseif unittgt then lr.y = 1;
				else lr.y = 3;
				end
				lr.xidot = true;
				lr.b, lr.a, lr.d, lr.x, lr.xiok, _, lr.xir, lr.xib, lr.xia, lr.xic, lr.xig, lr.xicu = select(1, ...);
				lr.x = lr.x - lr.xiok; -- amount = amount - overkill
				if unittgt then
					lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
				end
			elseif (event == "SPELL_PERIODIC_HEAL") then
				if unitsrc then lr.y = 8; 
				elseif unittgt then lr.y = 7;
				else lr.y = 9;
				end
				lr.xihot = true;
				lr.b, lr.a, lr.d, lr.x, lr.xioh, lr.xia, lr.xic = select(1, ...); 
				lr.x = lr.x - lr.xioh; -- amount = amount - overhealing
				if unittgt then
					lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
				end
			elseif (event == "SPELL_PERIODIC_MISSED") then
				if unitsrc then lr.y = 5;
				elseif unittgt then lr.y = 4;
				else lr.y = 6;
				end
				lr.xidot = true;
				lr.b, lr.a, lr.d, lr.m = select(1, ...);
			elseif (event == "SPELL_PERIODIC_DRAIN") or (event == "SPELL_PERIODIC_LEECH") then
				if unitsrc then lr.y = 2; 
				elseif unittgt then lr.y = 1;
				else lr.y = 3;
				end
				lr.xidot = true;
				lr.b, lr.a, lr.d, lr.x = select(1, ...);
				if unittgt then
					lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
				end
			end
		elseif (event == "SPELL_INTERRUPT") then
			lr.y = 26;
			lr.b, lr.a, lr.d = select(1, ...);
		elseif (strsub(event, 1, 10) == "SPELL_AURA") then
			if (event == "SPELL_AURA_APPLIED") then --or event == "SPELL_AURA_REFRESH") then
				lr.b, lr.a, lr.d, lr.u = select(1, ...);
				if lr.u == "BUFF" then lr.y = 15; else lr.y = 17; end
			elseif (event == "SPELL_AURA_REMOVED") then
				lr.b, lr.a, lr.d, lr.u = select(1, ...);
				if lr.u == "BUFF" then lr.y = 16; else lr.y = 18; end
			elseif (event == "SPELL_AURA_APPLIED_DOSE") then
				lr.b, lr.a, lr.d, lr.u, lr.ua = select(1, ...);
				if lr.u == "BUFF" then lr.y = 15; else lr.y = 17; end
			elseif (event == "SPELL_AURA_REMOVED_DOSE") then
				lr.b, lr.a, lr.d, lr.u, lr.ua = select(1, ...);
				if lr.u == "BUFF" then lr.y = 16; else lr.y = 18; end
			end
		elseif  (event == "SPELL_CAST_START") then
			lr.y = 10;
			lr.b, lr.a, lr.d = select(1, ...);
		elseif (event == "SPELL_CAST_SUCCESS") then
			lr.y = 11;
			lr.b, lr.a, lr.d = select(1, ...);
		--elseif (event == "SPELL_CAST_AVAIL") then
		--	lr.y = 13;
		--	lr.b, lr.a, lr.d = select(1, ...);
		elseif (event == "SPELL_DRAIN") or (event == "SPELL_LEECH") then
			if unitsrc then lr.y = 2; 
			elseif unittgt then lr.y = 1;
			else lr.y = 3;
			end
			lr.b, lr.a, lr.d, lr.x = select(1, ...);
			if unittgt then
				lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
			end
		elseif (event == "SPELL_SUMMON") then
			lr.y = 28;
			lr.b, lr.a, lr.d = select(1, ...);
		end
	elseif (subVal == "RANGE") then
		if (event == "RANGE_DAMAGE") then
			if unitsrc then lr.y = 2; 
			elseif unittgt then lr.y = 1;
			else lr.y = 3;
			end
			lr.r = true; -- range
			lr.b, lr.a, lr.d, lr.x, lr.xiok, _, lr.xir, lr.xib, lr.xia, lr.xic, lr.xig, lr.xicu = select(1, ...);
			lr.x = lr.x - lr.xiok; -- amount = amount - overkill
			if unittgt then
				lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
			end
		elseif (event == "RANGE_MISSED") then 
			if unitsrc then lr.y = 5;
			elseif unittgt then lr.y = 4;
			else lr.y = 6;
			end
			lr.r = true; -- range
			lr.b, lr.a, lr.d, lr.m = select(1, ...);
		end
	elseif (event == "DAMAGE_SHIELD") or (event == "DAMAGE_SPLIT") then
		if unitsrc then lr.y = 2; 
		elseif unittgt then lr.y = 1;
		else lr.y = 3;
		end
		lr.b, lr.a, lr.d, lr.x, lr.xiok, _, lr.xir, lr.xib, lr.xia, lr.xic, lr.xig, lr.xicu = select(1, ...);
		lr.x = lr.x - lr.xiok; -- amount = amount - overkill
		if unittgt then
			lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
		end
	elseif (event == "DAMAGE_SHIELD_MISSED") then 
		if unitsrc then lr.y = 5;
		elseif unittgt then lr.y = 4;
		else lr.y = 6;
		end
		lr.b, lr.a, lr.d, lr.m = select(1, ...);
	elseif (event == "ENVIRONMENTAL_DAMAGE") then
		if unitsrc then lr.y = 2; 
		elseif unittgt then lr.y = 1;
		else lr.y = 3;
		end
		lr.e, lr.x, lr.xiok, lr.d, lr.xir, lr.xib, lr.xia, lr.xic, lr.xig, lr.xicu = select(1, ...);
		lr.x = lr.x - lr.xiok; -- amount = amount - overkill
		if unittgt then
			lr.uh = unittgt:Health(); lr.uhm = unittgt:MaxHealth();
		end
	elseif (event == "PARTY_KILL") then
		lr.y = 21;
	elseif (event == "UNIT_DIED" or event == "UNIT_DESTROYED") then
		lr.y = 22;
	elseif (event == "INCOMBAT") then
		lr.y = 30;
	elseif (event == "OUTOFCOMBAT") then
		lr.y = 31;
	elseif (event == "STARTENCOUNTER") then
		lr.y = 32;
	elseif (event == "STOPENCOUNTER") then
		lr.y = 33;
	--else
		--VFL.print(event);
	end
	
	lr.x = tonumber(lr.x);
	lr.d = tonumber(lr.d);
	
	if lr.y then logTrigger:Raise(lr, unitsrc, unittgt); end
	
end
RDXLF.AddLogRow = AddLogRow;
VFLP.RegisterFunc("RDXDAL", "Log Row", AddLogRow, true);

local function InCombat()
	AddLogRow(nil, "INCOMBAT");
end
local function OutOfCombat()
	AddLogRow(nil, "OUTOFCOMBAT");
end

-- Bind to Encounter Start/Stop in RDX
local function StartEncounter(ename)
	AddLogRow(nil, "STARTENCOUNTER", nil, ename);
end
local function StopEncounter(ename)
	AddLogRow(nil, "STOPENCOUNTER", nil, ename);
end

-- Bind to Cooldown used, cooldown avail
local function CooldownAvail(cd)
	AddLogRow(nil, "COOLDOWNAVAIL", nil, ename);
end
local function CooldownUsed(cd)
	AddLogRow(nil, "COOLDOWNUSED", nil, ename);
end

--- Enable or disable Omniscience combat logging.
-- @param x If TRUE, logging is enabled; if FALSE, disabled.
local logging = nil;
function RDXLF.SetLogging(x)
	if x and (not logging) then
		logging = true;
		WoWEvents:Bind("COMBAT_LOG_EVENT_UNFILTERED", nil, AddLogRow, "RDXLFLogger");
		-- COMBAT FLAG
		WoWEvents:Bind("PLAYER_REGEN_DISABLED", nil, InCombat, "RDXLFLogger");
		WoWEvents:Bind("PLAYER_REGEN_ENABLED", nil, OutOfCombat, "RDXLFLogger");
		-- START/STOP ENC
		RDXEvents:Bind("ENCOUNTER_STARTED", nil, StartEncounter, "RDXLFLogger");
		RDXEvents:Bind("ENCOUNTER_STOPPED", nil, StopEncounter, "RDXLFLogger");
	else
		logging = nil;
		WoWEvents:Unbind("RDXLFLogger");
		RDXEvents:Unbind("RDXLFLogger");
	end
end

function RDXLF.IsLogging() return logging; end

-- Only start logging when the system timer is established.
--VFLEvents:Bind("SYSTEM_EPOCH_ESTABLISHED", nil, function() 
RDXEvents:Bind("INIT_DEFERRED", nil, function()
	MyGUID = UnitGUID("player");
	RDXLF.SetLogging(true);
end);

