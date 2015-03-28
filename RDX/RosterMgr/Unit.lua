-- Unit.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- Unit data structures for RDX6.
--
-- There are two ways of referencing a unit: by explicit name, and by raid number.
-- When a unit is referenced by number, the object created points directly to the
-- underlying WoW unit "raidX" or "partyX." When a unit is referenced by name, a
-- "shadow object" is created which is updated on every ROSTER_UPDATE impulse to
-- point to the appropriate unit.
--
-- Each unit has two types of data, "engine data" and "nominative data." 
-- Nominative data is data associated to the unit by name, and will travel with the 
-- unit as its ID changes.
-- 
-- Engine data is data associated to the unit ID "raidX" or "partyX" and will stick
-- to that ID. (e.g. auras etc.)

local _grey = { r=.5, g=.5, b=.5};

------------------------------------------------
-- SPECIALIZED METATABLES
-- These allow us to "hot-switch" an already existing unit to a new
-- API instantaneously.
------------------------------------------------
RDXDAL.InvalidUnit = {};
RDXDAL.InvalidUnit.__index = RDXDAL.InvalidUnit;

----------------------------------------
-- CORE METATABLE
----------------------------------------
-- Whenever a method is added to RDXDAL.Unit, add it to the other unit metatables as well
RDXDAL.Unit = setmetatable({}, {
	__newindex = function(tbl, key, val)
		rawset(tbl, key, val);
		rawset(RDXDAL.InvalidUnit, key, val);
	end;
});
rawset(RDXDAL.Unit, "__index", RDXDAL.Unit);

function RDXDAL.Unit:new()
	local self = {};
	setmetatable(self, RDXDAL.Unit);
	return self;
end

-------------------------------------------------------------
-- CORE UNIT INFO API
-------------------------------------------------------------
--- Determine if this unit is using the "valid unit" metatable.
RDXDAL.Unit._ValidMetatable = VFL.True;

--- Return TRUE if this unit is the player unit
function RDXDAL.Unit:IsPlayer()
	return UnitIsUnit(self.uid, "player");
end

--- Return TRUE if this unit is valid. A valid unit is one that's in the raid group
-- and whose vital statistics are accessible to the engine.
-- @return TRUE iff this unit is valid.
function RDXDAL.Unit:IsValid()
	return UnitExists(self.uid);
end

-- The IsCacheValid return false when the unit is invalidate by the roster
function RDXDAL.Unit:IsCacheValid()
	return true;
end

--- Invalidates the underlying unit. Subsequent calls to IsValid() will return false.
function RDXDAL.Unit:Invalidate()
	self.uid = "none";
	setmetatable(self, RDXDAL.InvalidUnit);
	return true;
end
RDXDAL.Unit.Validate = VFL.Noop;

--- @return The WoW unit ID of this unit.
function RDXDAL.Unit:GetUnitID()
	return self.uid or "none";
end

--- @return the fundamental numeric ID of the unit.
function RDXDAL.Unit:GetNumber()
	return self.nid or 0;
end

--- @return The name of this unit, in internal (lowercased) form
function RDXDAL.Unit:GetName()
	return self.name or "unknown";
end

--- @return The proper in-game name of this unit.
function RDXDAL.Unit:GetProperName()
	return UnitName(self.uid) or "Unknown";
end

--- @return The guid of this unit. patch 2.4
function RDXDAL.Unit:GetGuid()
	if not self.guid then self.guid = UnitGUID(self.uid); end
	return self.guid;
end

--- @return The proper in game guid of this unit. patch 2.4
function RDXDAL.Unit:GetProperGuid()
	return UnitGUID(self.uid) or "Unknown";
end

--- @return Class information about the unit
function RDXDAL.Unit:GetClass()
	local ret = UnitClass(self.uid or "none");
	return ret or "None"; 
end
function RDXDAL.Unit:GetClassMnemonic()
	local _,ret = UnitClass(self.uid or "none");
	return ret or "NONE";
end

function RDXDAL.Unit:GetClassID()
	if not self.classid then self.classid = RDXMD.GetClassID(self.classec); end
	return self.classid;
end

function RDXDAL.Unit:GetClassColor()
	local _,mnem = UnitClass(self.uid or "none");
	if mnem then
		return RAID_CLASS_COLORS[mnem] or _grey;
	else
		return _grey;
	end
end

function RDXDAL.Unit:GetMainTalent()
	local t = self:GetNField("sync");
	if t then return t.mt or 0; else return 0; end
end;

--- @return TRUE if this unit is a pet
function RDXDAL.Unit:IsPet()
	return nil;
end

--- @return The owner unit of this unit, if it is a pet. NIL if cannot be resolved.
local GetUnitByNumber = RDXDAL.GetUnitByNumber;
function RDXDAL.Unit:GetOwnerUnit()
	local n = self.nid;
	if n and n > 40 and n < 81 then
		return GetUnitByNumber(n-40);
	end
end

--- @return TRUE iff this unit is a arenaUnit
function RDXDAL.Unit:IsArenaUnit()
	return nil;
end

--- @return TRUE iff this unit is an Assistant Leader or Leader of the raid group.
function RDXDAL.Unit:IsLeader()
	return nil;
end

--- Get the leader level of the unit, as per the convention of GetRaidRosterInfo.
function RDXDAL.Unit:GetLeaderLevel() return 0; end

--- Get the group number of this unit, as returned by GetRaidRosterInfo.
function RDXDAL.Unit:GetGroup() return 0; end

--- Get the group member of this unit.
function RDXDAL.Unit:GetMemberGroupId() return 0; end

--- @return TRUE iff this unit is the same unit as the given RDX unit.
function RDXDAL.Unit:IsSameUnit(u2)
	return UnitIsUnit(self.uid, u2.uid);
end

-------------------------------------------
-- NOMINATIVE/INDEXICAL TRANSFORMS
-------------------------------------------
--- @return A unit reference equivalent to this unit, but nominative in scope.
function RDXDAL.Unit:GetNominativeUnit()
	return self;
end
function RDXDAL.Unit:IsNominativeUnit()
	return nil;
end

--- @return A unit reference equivalent to this unit, but indexical in scope.
function RDXDAL.Unit:GetIndexedUnit()
	return self;
end
function RDXDAL.Unit:IsIndexedUnit()
	return nil;
end

--- @return The nominative field structure of the unit or NIL if none.
function RDXDAL.Unit:GetNField(fld)
	return nil;
end
--- @return The engine field structore of the unit or NIL if none.
function RDXDAL.Unit:GetEField(fld)
	return nil
end

------------------------------------------------------------
-- UNIT HP DATA.
------------------------------------------------------------
--- @return The current HP of the unit as reported by the WoW engine.
function RDXDAL.Unit:Health()
	if self:IsFeigned() then return 1; end
	return UnitHealth(self.uid or "none");
end
--- @return The max HP of the unit as reported by the WoW engine.
function RDXDAL.Unit:MaxHealth()
	if self:IsFeigned() then return 1; end
	return UnitHealthMax(self.uid or "none");
end
--- @return The fractional HP of the unit as reported by the WoW engine.
function RDXDAL.Unit:FracHealth()
	if self:IsFeigned() then return 1; end
	local uid = self.uid or "none";
	local a,b = UnitHealth(uid),UnitHealthMax(uid);
	if(b<1) then return 0; end
	a=a/b;
	if a<0 then return 0 elseif a>1 then return 1; else return a; end
end
--- @return The number of missing HP of the unit as reported by the WoW engine.
function RDXDAL.Unit:MissingHealth()
	if self:IsFeigned() then return 0; end
	local uid = self.uid or "none";
	return UnitHealthMax(uid) - UnitHealth(uid);
end
--- @return The fraction of the unit's missing HP as reported by the WoW engine.
function RDXDAL.Unit:FracMissingHealth()
	if self:IsFeigned() then return 0; end
	local uid = self.uid or "none";
	local a,b = UnitHealth(uid),UnitHealthMax(uid);
	if(b<1) then return 0; end
	a=(b-a)/b;
	if a<0 then return 0; elseif a>1 then return 1; else return a; end
end

function RDXDAL.Unit:SmartHealth(source)
	return UnitGetIncomingHeals(self.uid, source) + self:Health() + UnitGetTotalAbsorbs(self.uid);
end

function RDXDAL.Unit:FracSmartHealth(source)
	local ih, ha, h, mh = UnitGetIncomingHeals(self.uid, source), UnitGetTotalAbsorbs(self.uid), self:Health(), self:MaxHealth();
	if not ih then ih = 0; end
	if not ha then ha = 0; end
	if(mh <= 1) then return 0; end
	h = (h+ih+ha)/mh;
	if h<0 then return 0; elseif h>1 then return 1; else return h; end
end

function RDXDAL.Unit:AllSmartHealth(source)
	local ih, ha, h, mh = UnitGetIncomingHeals(self.uid, source), UnitGetTotalAbsorbs(self.uid), self:Health(), self:MaxHealth();
	if not ih then ih = 0; end
	if not ha then ha = 0; end
	if(mh <= 1) then return 1, 1, 0; end
	h = (h+ih+ha); 
	local x = h/mh;
	if x<0 then
		return h, mh, 0, ih + ha;
	elseif x>1 then
		return h, mh, 1, ih + ha;
	else
		return h, mh, x, ih + ha;
	end
end

---------------------------------------------------------------
-- UNIT Power DATA.3.0
---------------------------------------------------------------
-- Power type
--SPELL_POWER_MANA = 0 
--SPELL_POWER_RAGE = 1  
--SPELL_POWER_FOCUS = 2 
--SPELL_POWER_ENERGY = 3  
--SPELL_POWER_HAPPINESS = 4 
--SPELL_POWER_RUNES = 5 
--SPELL_POWER_RUNIC_POWER = 6 
--SPELL_POWER_SOUL_SHARDS = 7  
--SPELL_POWER_ECLIPSE = 8 
--SPELL_POWER_HOLY_POWER = 9

--- @return the WoW Powertype of the unit
function RDXDAL.Unit:PowerType()
	return UnitPowerType(self.uid or "none");
end
--- @return the current Power of the unit.
function RDXDAL.Unit:Power(pt)
	local a = UnitPower(self.uid or "none", pt);
	if a > 0 then return a,0; else return 0, abs(a); end 
end
--- @return the max Power of the unit.
function RDXDAL.Unit:MaxPower(pt)
	local a = UnitPowerMax(self.uid or "none", pt);
	if a > 0 then return a,0; else return 0, abs(a); end
end
--- @return the fractional Power of the unit.
function RDXDAL.Unit:FracPower(pt)
	local uid = self.uid or "none";
	local a,b = UnitPower(uid, pt), UnitPowerMax(uid, pt);
	if b == 0 then b = 1; end
	a=a/b;
	if a > 1 then a = 1; end
	if a < -1 then a = -1; end
	if a > 0 then return a, 0; else return 0, abs(a); end
end
--- @return the missing Power of the unit.
function RDXDAL.Unit:MissingPower(pt)
	local uid = self.uid or "none";
	return UnitPowerMax(self.uid, pt) - UnitPower(self.uid, pt);
end
--- @return the fraction of missing Power of the unit.
function RDXDAL.Unit:FracMissingPower(pt)
	local uid = self.uid or "none";
	local a,b = UnitPower(self.uid, pt), UnitPowerMax(self.uid, pt);
	if(b<1) then return 0; end
	a = (b-a)/b;
	if a<0 then return 0; elseif a>1 then return 1; else return a; end
end

-- Status

--- @return TRUE iff the unit is dead.
function RDXDAL.Unit:IsDead()
	return (not self:IsFeigned()) and (UnitIsDeadOrGhost(self.uid));
end
--- @return TRUE iff the unit is feigning death.
function RDXDAL.Unit:IsFeigned()
	return nil;
end
--- @return TRUE iff the unit is online
function RDXDAL.Unit:IsOnline()
	return UnitIsConnected(self.uid or "none");
end
--- @return TRUE iff the unit is incapacitated (offline, dead, feigned)
function RDXDAL.Unit:IsIncapacitated()
	local uid = self.uid or "none";
	if (self:IsFeigned()) or (UnitIsDeadOrGhost(uid)) or (not UnitIsConnected(uid)) then return true; else return nil; end
end

--- @return TRUE iff this unit is in the data range of the WoW engine.
function RDXDAL.Unit:IsInDataRange()
	return UnitIsVisible(self.uid);
end

--- @return TRUE iff this unit is in the data range of the WoW engine.
function RDXDAL.Unit:IsInRange()
	return UnitInRange(self.uid);
end

--- @return the WoW Powertype of the unit ("MANA" 0, "RAGE" 1, "ENERGY" 2, "FOCUS" 3)
function RDXDAL.Unit:GetRoleType()
	local role = UnitGroupRolesAssigned(uid);
	if role == "TANK" then
		return 1;
	elseif role == "HEALER" then
		return 2;
	elseif role == "DAMAGER" then
		return 3;
	elseif role == "NONE" then
		return 4;
	else
		return 0;
	end
end

------------------------------------------------------
-- cooldown real duration (store only in unit engine)
-- t.cdp = cdpossible with spellid and duration
------------------------------------------------------
function RDXDAL.Unit:GetCooldownsDuration()
	local t = self:GetNField("sync");
	if t then return t.cdp; end
end

function RDXDAL.Unit:DeleteCooldownsDuration()
	local t = self:GetNField("sync");
	if t and t.cdp then 
		VFL.empty(t.cdp);
	end
end

function RDXDAL.Unit:GetCooldownDuration(spellid)
	local t = self:GetNField("sync");
	if t and t.cdp then return t.cdp[spellid]; end
end

function RDXDAL.Unit:SetCooldownDuration(spellid, duration)
	local t = self:GetNField("sync");
	if t then 
		if not t.cdp then t.cdp = {}; end
		t.cdp[spellid] = duration;
	end
end

-- cooldown refactoring.
function RDXDAL.Unit:GetCooldowns()
	return nil;
end

function RDXDAL.Unit:HasUsedCooldownBySpellid()
	return nil;
end

function RDXDAL.Unit:HasAvailCooldownBySpellid()
	return nil;
end

function RDXDAL.Unit:GetUsedCooldownBySpellid()
	return nil;
end

function RDXDAL.Unit:GetAvailCooldownBySpellid()
	return nil;
end

function RDXDAL.Unit:GetUsedCooldownBySpellname()
	return nil;
end

function RDXDAL.Unit:GetAvailCooldownBySpellname()
	return nil;
end

function RDXDAL.Unit:RemoveCooldown()
	return nil;
end

function RDXDAL.Unit:AddCooldown()
	return nil;
end

function RDXDAL.Unit:ProcessCooldown()
	return nil;
end

-- tablemeter
function RDXDAL.Unit:GetTableMeterInfo(path)
	local tablemeter = RDXDB.GetObjectInstance(path);
	if tablemeter then
		return tablemeter:GetInfo(self:GetGuid());
	else
		return nil;
	end
end

function RDXDAL.Unit:GetTableMeterValue(path)
	local tablemeter = RDXDB.GetObjectInstance(path);
	if tablemeter then
		return tablemeter:GetValue(self:GetGuid()) or 0;
	else
		return 0;
	end
end

function RDXDAL.Unit:GetMapPosition()
	return GetPlayerMapPosition (self.uid)
end

------------------------------------------------
-- INVALID UNIT API
------------------------------------------------
RDXDAL.InvalidUnit._ValidMetatable = VFL.False;
RDXDAL.InvalidUnit.IsValid = VFL.False;
RDXDAL.InvalidUnit.IsCacheValid = VFL.False;
RDXDAL.InvalidUnit.Invalidate = VFL.Noop;
function RDXDAL.InvalidUnit:Validate()
	setmetatable(self, RDXDAL.Unit);
	return true;
end;
RDXDAL.InvalidUnit.GetUnitID = VFL.Nil;
RDXDAL.InvalidUnit.GetNumber = VFL.One;
function RDXDAL.InvalidUnit:GetName() return "unknown"; end
function RDXDAL.InvalidUnit:GetProperName() return "Unknown"; end
RDXDAL.InvalidUnit.GetGuid = VFL.Nil;
RDXDAL.InvalidUnit.GetProperGuid = VFL.Nil;
RDXDAL.InvalidUnit.GetClass = VFL.Nil;
RDXDAL.InvalidUnit.GetClassMnemonic = VFL.Nil;
RDXDAL.InvalidUnit.GetClassID = VFL.Nil;
RDXDAL.InvalidUnit.GetClassColor = VFL.Nil;
RDXDAL.InvalidUnit.GetMainTalent = VFL.Nil;
RDXDAL.InvalidUnit.IsPet = VFL.Nil;
RDXDAL.InvalidUnit.GetOwnerUnit = VFL.Nil;
RDXDAL.InvalidUnit.IsArenaUnit = VFL.Nil;
RDXDAL.InvalidUnit.IsLeader = VFL.Nil;
RDXDAL.InvalidUnit.GetLeaderLevel = VFL.Nil;
RDXDAL.InvalidUnit.GetGroup = VFL.Nil;
RDXDAL.InvalidUnit.GetMemberGroupId = VFL.Nil;
RDXDAL.InvalidUnit.IsSameUnit = VFL.False;
RDXDAL.InvalidUnit.Health = VFL.Zero;
RDXDAL.InvalidUnit.MaxHealth = VFL.One;
RDXDAL.InvalidUnit.FracHealth = VFL.Zero;
RDXDAL.InvalidUnit.MissingHealth = VFL.Zero;
RDXDAL.InvalidUnit.FracMissingHealth = VFL.Zero;
RDXDAL.InvalidUnit.SmartHealth = VFL.Zero;
RDXDAL.InvalidUnit.FracSmartHealth = VFL.Zero;
RDXDAL.InvalidUnit.AllSmartHealth = VFL.Zero;
function RDXDAL.InvalidUnit:PowerType() return "MANA"; end
RDXDAL.InvalidUnit.Power = VFL.Zero;
RDXDAL.InvalidUnit.MaxPower = VFL.Zero;
RDXDAL.InvalidUnit.FracPower = VFL.One;
RDXDAL.InvalidUnit.MissingPower = VFL.Zero;
RDXDAL.InvalidUnit.FracMissingPower = VFL.Zero;
RDXDAL.InvalidUnit.IsDead = VFL.False;
RDXDAL.InvalidUnit.IsFeigned = VFL.False;
RDXDAL.InvalidUnit.IsOnline = VFL.False;
RDXDAL.InvalidUnit.IsIncapacitated = VFL.True;
RDXDAL.InvalidUnit.IsInDataRange = VFL.Nil;
RDXDAL.InvalidUnit.IsInRange = VFL.Nil;
RDXDAL.InvalidUnit.GetRoleType = VFL.Zero;

RDXDAL.InvalidUnit.GetCooldownsDuration = VFL.Zero;
RDXDAL.InvalidUnit.DeleteCooldownsDuration = VFL.Zero;
RDXDAL.InvalidUnit.GetCooldownDuration = VFL.Zero;
RDXDAL.InvalidUnit.SetCooldownDuration = VFL.Zero;
RDXDAL.InvalidUnit.GetTableMeterInfo = VFL.Zero;
RDXDAL.InvalidUnit.GetTableMeterValue = VFL.Zero;
function RDXDAL.InvalidUnit:GetMapPosition() return 0,0; end

------------------------------------------------
-- TEMPORARY UNIT
-- This unit is used when no internal unit matches, but the Unit API is required
-- nevertheless. (eg. assist windows and the like)
------------------------------------------------
RDXDAL.tempUnit = RDXDAL.Unit:new();
RDXDAL.tempUnit.nid = 0;
RDXDAL.tempUnit.name = "unknown";
RDXDAL.tempUnit.uid = "none";
RDXDAL.tempUnit.guid = "unknown";
RDXDAL.tempUnit.class = "unknown";
RDXDAL.tempUnit.classec = "unknown";

RDXDAL.tempUnit.Invalidate = VFL.Noop;
RDXDAL.tempUnit.Validate = VFL.Noop;

