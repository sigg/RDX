-- UDB.lua
-- RDX
-- (C)2006 Bill Johnson
--
-- The master unit database.
--
-- The primary responsibilities of the Unit Database are:
-- * Enforce the party/raid abstraction.
-- * Provide events for when people are added/removed from the group.
-- * Map units to ndata/edata.
-- * Promote WoW events to RDX events, intelligently up-converting unit references.
--

-- Imports
local tempty, strlower, strmatch, strgsub = VFL.empty, string.lower, string.match, string.gsub;
local GetBGName = VFL.GetBGName;
local myunit = nil;

VFLP.RegisterCategory("RDXDAL: UnitDB");

------------------------------------------------------------------------------
-- UNIT ID MAPPINGS/UNIT COUNTING
------------------------------------------------------------------------------
RDXDAL.NUM_UNITS = 94; -- Number of internal unit structures.
local NUM_UNITS = RDXDAL.NUM_UNITS;

-- 1 to 40 party and raid
-- 41 to 80 partypet and raidpet
-- 81 to 85 arena
-- 86 to 90 arenapet
-- 91 to 94 boss

local rostertypes = {
	{ text = "RAID" },
	{ text = "RAIDPET" },
	{ text = "RAID&RAIDPET" },
	{ text = "ARENA" },
	{ text = "ARENAPET" },
	{ text = "ARENA&ARENAPET" },
	{ text = "BOSS" },
	{ text = "ALL" },
};
function RDXDAL.RosterTypesSelectionFunc() return rostertypes; end

local securedrostertypes = {
	{ text = "RAID" },
	{ text = "RAIDPET" },
	{ text = "ARENA" },
	{ text = "ARENAPET" },
	{ text = "BOSS" },
};
function RDXDAL.SecuredRosterTypesSelectionFunc() return securedrostertypes; end

----------- Party unit maps
-- player, party1..party4, pet, partypet1..partypet4
local party_id2num = {};
party_id2num["player"] = 1;
for i=1,4 do party_id2num["party" .. i] = i + 1; end
party_id2num["pet"] = 41;
for i=1,4 do party_id2num["partypet" .. i] = i + 41; end
for i=1,5 do party_id2num["arena" .. i] = 80 + i; end
for i=1,5 do party_id2num["arenapet" .. i] = 85 + i; end
for i=1,4 do party_id2num["boss" .. i] = 90 + i; end

local party_num2id = {};
party_num2id[1] = "player";
for i=1,4 do party_num2id[i+1] = "party" .. i; end
for i=6,40 do party_num2id[i] = false; end
party_num2id[41] = "pet";
for i=1,4 do party_num2id[41+i] = "partypet" .. i; end
for i=1,5 do party_num2id[80 + i] = "arena" .. i; end
for i=1,5 do party_num2id[85 + i] = "arenapet" .. i; end
for i=1,4 do party_num2id[90 + i] = "boss" .. i; end

----------- Raid unit maps
-- raid1..raid40, raidpet1..raidpet40
local raid_id2num = {};
for i=1,40 do raid_id2num["raid" .. i] = i; end
for i=1,40 do raid_id2num["raidpet" .. i] = 40 + i; end
for i=1,5 do raid_id2num["arena" .. i] = 80 + i; end
for i=1,5 do raid_id2num["arenapet" .. i] = 85 + i; end
for i=1,4 do raid_id2num["boss" .. i] = 90 + i; end

local raid_num2id = {};
for i=1,40 do raid_num2id[i] = "raid" .. i; end
for i=1,40 do raid_num2id[40 + i] = "raidpet" .. i; end
for i=1,5 do raid_num2id[80 + i] = "arena" .. i; end
for i=1,5 do raid_num2id[85 + i] = "arenapet" .. i; end
for i=1,4 do raid_num2id[90 + i] = "boss" .. i; end

--------------------------------
local id2num, num2id = {}, {};

local function SetRaidIDDatabase()
	id2num = raid_id2num; num2id = raid_num2id;
end

local function SetPartyIDDatabase()
	id2num = party_id2num; num2id = party_num2id;
end

function RDXDAL.NumberToUID(unum)
	return num2id[unum];
end

function RDXDAL.UIDToNumber(uid)
	return id2num[uid] or 0;
end

-- Internal: raid or party status and member count
local function party_GetNumUnits()
	return GetNumSubgroupMembers() + 1;
end

local function raid_GetNumUnits()
	return GetNumGroupMembers();
end

--- @return The total number of units in the RDX unit database.
local GetNumUnits = party_GetNumUnits;
RDXDAL.GetNumUnits = GetNumUnits;
SetPartyIDDatabase();

-- New system switch state
local currentstate = "";
function RDXDAL.GetCurrentState()
	return currentstate;
end

local _sig_rdx_roster_state = RDXEvents:LockSignal("ROSTER_STATE");

local function SwitchState()
	--VFL.print("SwitchState from " .. currentstate);
	if select(2, IsInInstance()) == "arena" then
		--VFL.print("ARENA MODE");
		if currentstate ~= "ARENA" then
			currentstate = "ARENA";
			--VFL.print("ARENA MODE SET");
			_sig_rdx_roster_state:Raise("ARENA");
		end
	elseif select(2,IsInInstance()) == "pvp" then
		--VFL.print("BATTLEGROUND MODE");
		if currentstate ~= "BATTLEGROUND" then
			currentstate = "BATTLEGROUND";
			--VFL.print("BATTLEGROUND MODE SET");
			_sig_rdx_roster_state:Raise("BATTLEGROUND");
		end
	elseif IsInRaid() then
		--VFL.print("RAID MODE");
		if currentstate ~= "RAID" then
			currentstate = "RAID";
			--VFL.print("RAID MODE SET");
			_sig_rdx_roster_state:Raise("RAID");
		end
	elseif IsInGroup() then
		--VFL.print("PARTY MODE");
		if currentstate ~= "PARTY" then
			currentstate = "PARTY";
			--VFL.print("PARTY MODE SET");
			_sig_rdx_roster_state:Raise("PARTY");
		end
	else
		--VFL.print("SOLO MODE");
		if currentstate ~= "SOLO" then
			currentstate = "SOLO";
			--VFL.print("SOLO MODE SET");
			_sig_rdx_roster_state:Raise("SOLO");
		end
	end
end



-- prevent the function to be call to many times
--local function SwitchStateLatch()
--	VFLT.CreatePeriodicLatch(0.5, SwitchState);
--end

--RDXEvents:Bind("PARTY_IS_RAID", nil, SwitchStateLatch);
--RDXEvents:Bind("PARTY_IS_NONRAID", nil, SwitchStateLatch);
--VFLEvents:Bind("PLAYER_IN_BATTLEGROUND", nil, SwitchStateLatch);
--VFLEvents:Bind("PLAYER_IN_ARENA", nil, SwitchStateLatch);

---------------------------------------------
-- Queue Update aura and cd
---------------------------------------------
-- The queue of units whose auras are dirty
local auraq = {};
-- The queue of units whose CD are dirty
local cdq = {};

-------------------------------------------------------------------
-- EDATA
-- Edata = engine data = data that follows a unit around by ID number.
-------------------------------------------------------------------

-- Temporary touched matrix for edata
local _touched, _cattouched = {}, {};
local LoadBuffFromUnit = RDXDAL.LoadBuffFromUnit;
local LoadDebuffFromUnit = RDXDAL.LoadDebuffFromUnit;

-- Internal: Create a new engine data structure for the given unit.
local function NewEData(idx)
	local self = {};
	
	-- Custom fields
	local _efields = {};
	
	-- Use by auracache
	local _buffscache, _debuffscache = {}, {};
	
	-- Use to send signal to set
	-- Buff/debuff lists
	local _buffsset, _debuffsset = {}, {};
	
	-- category lists
	local _debuffscat = {};
	
	-- Fixed fields
	local group = 0;

	self.SetGroup = function(x, g) group = g; end
	self.GetGroup = function() return group; end
	
	local gid = 0;
	self.SetMemberGroupId = function(x, g) gid = g; end
	self.GetMemberGroupId = function() return gid; end

	self.IsPet = VFL.Noop;
	if(idx > 0) and (idx <= 40) then
		self.IsPet = VFL.Nil;
	elseif(idx > 40) and (idx <= 80) then
		self.IsPet = VFL.True;
	elseif(idx > 80) then
		self.IsPet = VFL.Nil;
	end
	
	self.IsArenaUnit = VFL.Noop;
	if(idx > 0) and (idx <= 80) then
		self.IsArenaUnit = VFL.Nil;
	elseif(idx > 80) and (idx <= 85) then
		self.IsArenaUnit = VFL.True;
	elseif(idx > 85) then
		self.IsArenaUnit = VFL.Nil;
	end
	
	self.IsBossUnit = VFL.Noop;
	if(idx > 0) and (idx <= 90) then
		self.IsBossUnit = VFL.Nil;
	elseif(idx > 90) and (idx <= 94) then
		self.IsBossUnit = VFL.True;
	elseif(idx > 94) then
		self.IsBossUnit = VFL.Nil;
	end
	
	--
	-- Aura manager
	--
	local auraflag;
	
	self.Debuffs = function() return _debuffscache; end
	self.HasDebuff = function(x, debuff)
				auraflag = false;
				for i=1,#_debuffscache do
					if _debuffscache[i].name == debuff then auraflag = true; end
				end
				if _debuffscat[debuff] then auraflag = true; end
				return auraflag;
			end
	
	self.GetDeBuffCache = function(x, i)
		local t = _debuffscache[i];
		if t and t.name then return t.name, t.rank, t.icon, t.count, t.debuffType, t.duration, t.expirationTime, t.caster, t.isStealable;
		else return nil, nil, nil, nil, nil, nil, nil, nil, nil;
		end
	end
	self.Buffs = function() return _buffscache; end
	self.HasBuff = function(x, buff)
				auraflag = nil;
				for i=1,#_buffscache do
					if _buffscache[i].name == buff then auraflag = true; end
				end
				return auraflag;
			end
	
	self.HasMyBuff = function(x, mybuff) 
				auraflag = nil;
				for i=1,#_buffscache do
					if (_buffscache[i].name == mybuff) and (_buffscache[i].caster == "player") then auraflag = true; end
				end
				return auraflag;
			end
	
	self.GetBuffCache = function(x, i)
		local t = _buffscache[i];
		if t and t.name then return t.name, t.rank, t.icon, t.count, t.debuffType, t.duration, t.expirationTime, t.caster, t.isStealable;
		else return nil, nil, nil, nil, nil, nil, nil, nil, nil;
		end
	end
	
	-- Process auras
	
	local uid, debuffchangeflag, buffchangeflag, i, name, lname, category, info, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable, found;
	
	self.ProcessAuras = function(rdxunit)
		debuffchangeflag, buffchangeflag, found = nil, nil, nil;
		uid = num2id[idx]; 
		tempty(_cattouched);

		RDXDAL.BeginEventBatch();

		------------------ DEBUFFS
		-- Step 1 clear the cache
		for i=1, #_debuffscache do
			if _debuffscache[i].name then _debuffscache[i].name = nil; end
		end
		
		-- Step 2 feed the cache
		i = 1;
		while true do
			cont, name, _, category, info, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable = LoadDebuffFromUnit(uid, i, nil, false);
			if not cont then break; end
			
			if not _debuffscache[i] then _debuffscache[i] = {}; end
			
			_debuffscache[i].name = name;
			_debuffscache[i].rank = rank;
			_debuffscache[i].icon = icon;
			_debuffscache[i].count = count;
			_debuffscache[i].debuffType = debuffType;
			_debuffscache[i].duration = duration;
			_debuffscache[i].expirationTime = expirationTime;
			_debuffscache[i].caster = caster;
			_debuffscache[i].isStealable = isStealable;
			
			_cattouched[category] = true;
			
			-- Move on to next debuff
			i = i + 1;
		end
		
		-- Step 3
		-- parse the cache vs set for new debuff 
		for i=1, #_debuffscache do
			if _debuffscache[i].name then
				found = nil;
				for j=1, #_debuffsset do
					if (_debuffsset[j].name == _debuffscache[i].name) and (_debuffsset[j].count == _debuffscache[i].count) and (_debuffsset[j].caster == _debuffscache[i].caster) and (_debuffsset[j].expirationTime == _debuffscache[i].expirationTime) then found = true; end
					--if (_debuffsset[j].name == _debuffscache[i].name) then 
					--	found = true;
						-- test debuff stack different, send a signal to repaint raid windows
					--	if (_debuffsset[j].count ~= _debuffscache[i].count) then
					--		debuffchangeflag = true;
					--	end
					--end
				end
				if not found then
					-- update set stuff
					RDXEvents:Dispatch("UNIT_DEBUFF_" .. _debuffscache[i].name, rdxunit, _debuffscache[i].name, 1);
					--if rdxunit.name then VFL.print("|cFF00FF00sig +DEBUFF:|r" .. _debuffscache[i].name .. " " .. rdxunit.name); end
					debuffchangeflag = true;
				end
			end
		end
		
		-- Step 4
		-- parse the set vs cache for missing debuff
		for i=1, #_debuffsset do
			if _debuffsset[i].name then
				found = nil;
				for j=1, #_debuffscache do
					if (_debuffsset[i].name == _debuffscache[j].name) and (_debuffsset[i].count == _debuffscache[j].count) and (_debuffsset[i].caster == _debuffscache[j].caster) and (_debuffsset[i].expirationTime == _debuffscache[j].expirationTime) then found = true; end
					--if (_debuffsset[i].name == _debuffscache[j].name) then 
					--	found = true;
						-- test debuff stack different, send a signal to repaint raid windows
					--	if (_debuffsset[i].count ~= _debuffscache[j].count) then
					--		debuffchangeflag = true;
					--	end
					--end
				end
				if not found then
					-- update set stuff
					RDXEvents:Dispatch("UNIT_DEBUFF_" .. _debuffsset[i].name, rdxunit, _debuffsset[i].name, 0);
					--if rdxunit.name then VFL.print("|cFF00FF00sig -DEBUFF:|r" .. _debuffsset[i].name .. " " .. rdxunit.name); end
					debuffchangeflag = true;
				end
			end
		end
		
		-- Step 5
		-- clear the set
		for i=1, #_debuffsset do
			_debuffsset[i].name = nil;
		end
		
		-- Step 6
		-- Update the set
		for i=1, #_debuffscache do
			if not _debuffsset[i] then _debuffsset[i] = {}; end
			_debuffsset[i].name = _debuffscache[i].name;
			_debuffsset[i].count = _debuffscache[i].count;
			_debuffsset[i].caster = _debuffscache[i].caster;
			_debuffsset[i].expirationTime = _debuffscache[i].expirationTime;
		end
		
		-- Mark category info
		for k,_ in pairs(_cattouched) do
			if _cattouched[k] and (not _debuffscat[k]) then
				_debuffscat[k] = true;
				RDXEvents:Dispatch("UNIT_DEBUFF_" .. k, rdxunit, k, 1);
				--VFL.print("sig +DEBUFF " .. k);
			end
		end
		
		for k,_ in pairs(_debuffscat) do
			if (not _cattouched[k]) and _debuffscat[k] then
				_debuffscat[k] = nil;
				RDXEvents:Dispatch("UNIT_DEBUFF_" .. k, rdxunit, k, 0);
				--VFL.print("sig -DEBUFF " .. k);
			end
		end
		
		------------------------- BUFFS
		
		-- Step 1 clear the cache
		for i=1, #_buffscache do
			if _buffscache[i].name then _buffscache[i].name = nil; end
		end
		
		-- Step 2 feed the cache
		i = 1;
		while true do
			cont, name, _, category, info, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable = LoadBuffFromUnit(uid, i, nil, false);
			if not cont then break; end
			
			if not _buffscache[i] then _buffscache[i] = {}; end
			
			_buffscache[i].name = name;
			_buffscache[i].rank = rank;
			_buffscache[i].icon = icon;
			_buffscache[i].count = count;
			_buffscache[i].debuffType = debuffType;
			_buffscache[i].duration = duration;
			_buffscache[i].expirationTime = expirationTime;
			_buffscache[i].caster = caster;
			_buffscache[i].isStealable = isStealable;
			
			-- Move on to next debuff
			i = i + 1;
		end
		
		-- Step 3
		-- parse the cache vs set for new buff 
		for i=1, #_buffscache do
			if _buffscache[i].name then
				found = nil;
				for j=1, #_buffsset do
					--if (_buffsset[j].name == _buffscache[i].name) and (_buffsset[j].count == _buffscache[i].count) and (_buffsset[j].caster == _buffscache[i].caster) and (_buffsset[j].expirationTime == _buffscache[i].expirationTime) then found = true; end
					if (_buffsset[j].name == _buffscache[i].name) then found = true; end
					if (_buffsset[j].expirationTime < _buffscache[i].expirationTime) then buffchangeflag = true; end
				end
				if not found then
					RDXEvents:Dispatch("UNIT_BUFF_" .. _buffscache[i].name, rdxunit, _buffscache[i].name, 1);
					--if rdxunit.name then VFL.print("|cFF00FF00sig +BUFF:|r" .. _buffscache[i].name .. " " .. rdxunit.name); end
					buffchangeflag = true;
					if _buffscache[i].caster == "player" then 
						RDXEvents:Dispatch("UNIT_MYBUFF_" .. _buffscache[i].name, rdxunit, _buffscache[i].name, 1); 
						--VFL.print("sig +MYBUFF " .. _buffscache[i].name); 
					end
				end
			end
		end
		
		-- Step 4
		-- parse the set vs cache for missing buff
		for i=1, #_buffsset do
			if _buffsset[i].name then
				found = nil;
				for j=1, #_buffscache do
					--if (_buffsset[i].name == _buffscache[j].name) and (_buffsset[i].count == _buffscache[j].count) and (_buffsset[i].caster == _buffscache[j].caster) and (_buffsset[i].expirationTime == _buffscache[j].expirationTime) then found = true; end
					if (_buffsset[i].name == _buffscache[j].name) then found = true; end
					if (_buffsset[i].expirationTime > _buffscache[j].expirationTime) then buffchangeflag = true; end
				end
				if not found then
					RDXEvents:Dispatch("UNIT_BUFF_" .. _buffsset[i].name, rdxunit, _buffsset[i].name, 0);
					--if rdxunit.name then VFL.print("|cFF00FF00sig -BUFF:|r" .. _buffsset[i].name .. " " .. rdxunit.name); end
					buffchangeflag = true;
					if _buffsset[i].caster == "player" then 
						RDXEvents:Dispatch("UNIT_MYBUFF_" .. _buffsset[i].name, rdxunit, _buffsset[i].name, 0); 
						--VFL.print("sig -MYBUFF " .. _buffsset[i].name); 
					end
				end
			end
		end
		
		-- Step 5
		-- clear the set
		for i=1, #_buffsset do
			_buffsset[i].name = nil;
		end
		
		-- Step 6
		-- Update the set
		for i=1, #_buffscache do
			if not _buffsset[i] then _buffsset[i] = {}; end
			_buffsset[i].name = _buffscache[i].name;
			_buffsset[i].count = _buffscache[i].count;
			_buffsset[i].caster = _buffscache[i].caster;
			_buffsset[i].expirationTime = _buffscache[i].expirationTime;
		end
		
		RDXDAL.EndEventBatch();
		return debuffchangeflag, buffchangeflag;
	end
	
	-- standard
	self.SetEField = function(x, f, v) _efields[f] = v; end
	self.GetEField = function(x, f) return _efields[f]; end
	self.EFields = function() return _efields; end

	RDXEvents:Dispatch("EDATA_CREATED", self, idx);

	return self;
end

-- Master edata table
local edata = {};

local function GetEData(i)
	return edata[i];
end

-- Edata[0] = empty, do-nothing edata.
local ed0 = NewEData(0);
ed0.ProcessAuras = VFL.Noop;
ed0.SetEField = VFL.Noop;
ed0.GetEField = VFL.Nil;
ed0.IsPet = VFL.False;
ed0.IsArenaUnit = VFL.False;
ed0.IsBossUnit = VFL.False;
ed0.SetGroup = VFL.Noop;
ed0.GetGroup = VFL.Zero;
edata[0] = ed0;

-------------------------------------------------------------------
-- NDATA
-- Ndata = nominative data = data that follows a unit around by name.
-------------------------------------------------------------------
local function NewNData(name)
	--VFL.print("NewNData " .. name);
	local self = {};

	local _nfields = {};
	local leader = 0;
	local feigned = nil;

	self.SetLeaderLevel = function(x, lv) leader = lv; end
	self.GetLeaderLevel = function(x) return leader; end
	self.IsLeader = function() return (leader > 0); end
	self._SetFeigned = function(x, flg) feigned = flg; end
	self.IsFeigned = function() return feigned; end
	
	self.SetNField = function(x, f, v) _nfields[f] = v; end
	self.GetNField = function(x, f) return _nfields[f]; end
	self.NFields = function() return _nfields; end
	
	self:SetNField("sync", {});
	
	----------------------------------------------
	-- cooldown management
	----------------------------------------------
	
	local cd_possi = {};
	-- spellid = duration
	local cd_avail = {};
	-- spellid = true
	local cd_used = {};
	-- spellid = start
	local cd_group = {};
	-- spellid = true
	
	local i, spellid, start, duration, cd;
	local GetCooldownInfoBySpellid = RDXCD.GetCooldownInfoBySpellid;
	
	self.GetCooldowns = function(x) return cd_used, cd_avail, cd_possi; end
	
	self.HasUsedCooldownBySpellid = function(x, spellid) return cd_used[spellid]; end
	
	self.HasAvailCooldownBySpellid = function(x, spellid) return cd_avail[spellid]; end
	
	self.GetUsedCooldownsById = function(x, id)
		i, spellid, start, duration = 0, nil, nil, nil;
		for k, v in pairs(cd_used) do
			i = i + 1;
			if i == id then
				spellid = k;
				start = v;
				duration = cd_possi[k];
				break;
			end
		end
		if start then
			cd = GetCooldownInfoBySpellid(spellid);
			return true, cd.spellname, spellid, cd.icon, duration, start;
		else
			return nil;
		end
	end
	
	self.GetAvailCooldownsById = function(x, id)
		i, spellid, start, duration = 0, nil, nil, nil;
		for k, v in pairs(cd_avail) do
			i = i + 1;
			if i == id then
				spellid = k;
				start = v;
				duration = cd_possi[k];
				break;
			end
		end
		if start then
			cd = GetCooldownInfoBySpellid(spellid);
			return true, cd.spellname, spellid, cd.icon, duration, 0;
		else
			return nil;
		end
	end
	
	self.GetUsedCooldownBySpellid = function(x, spellid)
		cd = GetCooldownInfoBySpellid(spellid);
		if cd and cd_used[spellid] then
			return true, cd.spellname, nil, cd.icon, cd_possi[spellid], cd_used[spellid];
		else
			return nil;
		end
	end
	self.GetAvailCooldownBySpellid = function(x, spellid)
		cd = GetCooldownInfoBySpellid(spellid);
		if cd and cd_avail[spellid] then
			return true, cd.spellname, nil, cd.icon, cd_possi[spellid], cd_avail[spellid];
		else
			return nil;
		end
	end
	
	self.GetUsedCooldownBySpellname = function(x, spellname)
		local spellid = RDXSS.GetSpellIdByLocalName(spellname);
		if spellid then
			return cd_used[spellid], cd_possi[spellid];
		end
	end
	
	self.GetAvailCooldownBySpellname = function(x, spellname)
		local spellid = RDXSS.GetSpellIdByLocalName(spellname);
		if spellid then
			return cd_avail[spellid], cd_possi[spellid];
		end
	end
	
	self.RemoveCooldown = function(x, spellid)
		if not cd_possi[spellid] then return; end
		--VFL.print("call RemoveCooldown " .. spellid .. " " .. cd_possi[spellid]);
		cd_avail[spellid] = true;
		cd_used[spellid] = nil;
		if x.nid then
			-- set, sort update
			RDXEvents:Dispatch("UNIT_CD_AVAIL_" .. spellid, x, spellid, 1);
			RDXEvents:Dispatch("UNIT_CD_USED_" .. spellid, x, spellid, 0);
			-- windows update next frame
			cdq[x.nid] = true;
		else
			-- update target, focus in case of
			cdq[0] = true;
		end
	end
	
	self.AddCooldown = function(x, spellid, timeleft)
		-- test spellid group ?
		-- if yes, replace cooldown spellid by groupid
		if cd_group[spellid] then
			spellid = cd_group[spellid];
		end
		-- to be analysed
		-- this could be a optional cooldown or return;
		if not cd_possi[spellid] then
			local tbl = RDXCD.GetCDs();
			local found = nil;
			for k,v in pairs(tbl) do
				if v.spellid == spellid then
					--VFL.print("PROCESS TALENT COOLDOWN " .. v.spellname);
					cd_possi[k] = v.duration;
					cd_avail[k] = true;
					found = true;
				end
			end
			if not found then return; end
		end
		--VFL.print("call AddCooldown " .. spellid .. " " .. cd_possi[spellid]);
		-- see if a existing schedule exist
		if not cd_avail[spellid] then VFLT.unschedulePattern(name..spellid); end
		
		-- add the cooldown
		cd_avail[spellid] = nil;
		if not timeleft then
			cd_used[spellid] = GetTime();
		else
			cd_used[spellid] = GetTime() + timeleft - cd_possi[spellid];
		end
		
		-- schedule the remove
		VFLT.scheduleNamed(name..spellid, timeleft or cd_possi[spellid], function() x:RemoveCooldown(spellid); end);
		
		-- update
		if x.nid then
			-- set, sort update
			RDXEvents:Dispatch("UNIT_CD_AVAIL_" .. spellid, x, spellid, 0);
			RDXEvents:Dispatch("UNIT_CD_USED_" .. spellid, x, spellid, 1);
			-- windows update next frame
			cdq[x.nid] = true;
		else
			-- update target, focus in case of
			cdq[0] = true;
		end
	end
	
	-- init cooldown, call when NewNData is called only common CD
	self.ProcessCooldown = function(x, class, race)
		local tbl = RDXCD.GetCDCs();
		for k,v in pairs(tbl) do
			if class and v.class == class then
				--VFL.print("PROCESS CLASS COOLDOWN " .. v.spellname);
				cd_possi[k] = v.duration;
				cd_avail[k] = true;
			end
			if race and ((v.race == race) or (v.race == "Item")) then
				--VFL.print("PROCESS RACE COOLDOWN " .. v.spellname);
				cd_possi[k] = v.duration;
				cd_avail[k] = true;
			end
			if v.group then
				cd_group[k] = v.group;
			end
		end
	end
	
	RDXEvents:Dispatch("NDATA_CREATED", self, name);

	return self;
end

-- Master ndata table
local ndata = {};

local function GetNData(name)
	local r = ndata[name];
	local create = nil;
	if not r then
		r = NewNData(name);
		ndata[name] = r;
		create = true;
	end
	return r, create;
end

-----------------------------------------------------------------
-- UNIT POOL only for ubn
-----------------------------------------------------------------
-- the pool
local unitpool = VFL.Pool:new();
unitpool.OnRelease = function(_,unit)
	unit:Invalidate();
end
unitpool.OnFallback = function(pool)
	local unit = RDXDAL.Unit:new();
	return unit;
end
--unitpool.OnAcquire = function(pool, unit) unit:Invalidate(); end
local acq = unitpool.Acquirer;
local rel = unitpool.Releaser;

function RDXDAL.GetUnitPoolInfo()
	return unitpool:KGetObjectInfo();
end

function RDXDAL.DebugUnitPoolInfo()
	VFL.print(unitpool:KGetObjectInfo());
end

-----------------------------------------------------------------
-- UNIT DATABASES
-----------------------------------------------------------------
-- UBI: Units by index
local ubi = {};
-- UBN: Units by name
local ubn = {};

local function ubn_to_ubi(x)
	if not x or not x.nid then return nil; end
	return ubi[x.nid];
end
local function ubi_to_ubn(x)
	if not x or not x.name then return nil; end
	return ubn[x.name];
end

-- Destroyer ubn
-- this function will drop units from ubn.
local timeGC_default = 300;
local ctime, flag = 0, {};
local function RemoveUnit()
	VFL.empty(flag);
	ctime = GetTime();
	for k,v in pairs(ubn) do
		if not RDXDAL.InRoster(k) and timeGC_default < (ctime - v.timestamp) then
			table.insert(flag, k);
		end
	end
	-- removing expired ubn
	for _,n in pairs(flag) do
		--VFL.print("RemoveUnit " .. n);
		ndata[n] = nil;
		unitpool.Releaser(ubn[n]); ubn[n] = nil;
	end
	-- also removing expired ndata from projectiveUnit (target frame)
	VFL.empty(flag);
	for k,v in pairs(ndata) do
		if not RDXDAL.InRoster(k) and v.timestamp and timeGC_default < (ctime - v.timestamp) then
			table.insert(flag, k);
		end
	end
	for _,n in pairs(flag) do 
		--VFL.print("RemoveNDATA " .. n); 
		ndata[n] = nil;
	end
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	VFLT.AdaptiveSchedule2("UDB:RemoveUnit", timeGC_default, RemoveUnit);
	VFLP.RegisterFunc("RDX", "UDB:RemoveUnit", RemoveUnit, true);
end);

-------------- Initial unit creation
-- Create the initial units by index
-- ubi do not use the unit pool by default.
for i=1,NUM_UNITS do
	local qq = RDXDAL.Unit:new();
	qq.nid = i; qq:Invalidate();
	-- Apply unit query functionality
	qq.GetNominativeUnit = ubi_to_ubn;
	qq.IsNominativeUnit = VFL.Nil;
	qq.GetIndexedUnit = VFL.Identity;
	qq.IsIndexedUnit = VFL.True;
	ubi[i] = qq;
end

-- ubn used unit pool by default.
local function CreateUnitName(n)
	--VFL.print("CreateUnitName " .. n);
	local r = unitpool.Acquirer();
	r.name = n; r:Invalidate();
	-- Apply nominative/indexed unit funcs
	r.GetNominativeUnit = VFL.Identity;
	r.IsNominativeUnit = VFL.True;
	r.GetIndexedUnit = ubn_to_ubi;
	r.IsIndexedUnit = VFL.Nil;
	r.timestamp = GetTime();
	VFL.mixin(r, GetNData(n), true);
	ubn[n] = r;
	return r;
end

-- Defer the creation and application of edata and ndata until the VARS_LOADED phase.
-- This gives all mods a chance to load first.
-- Create and apply EData.
for i=1, NUM_UNITS do
	edata[i] = NewEData(i);
	VFL.mixin(ubi[i], edata[i], true);
end
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	-- Create all NData that doesn't exist
	for n,unit in pairs(ubn) do VFL.mixin(unit, GetNData(n), true); end
end);

local function FlushAuras()
	local u;
	tempty(auraq);
	for i=1,NUM_UNITS do
		u = ubi[i];
		if u:IsValid() then auraq[i] = true; end
	end
end
VFLP.RegisterFunc("RDXDAL: UnitDB", "FlushAuras", FlushAuras, true);

--- Force a reprocessing of auras for all valid units.
local function FlushCDs()
	local u;
	tempty(cdq);
	for i=1,NUM_UNITS do
		u = ubi[i];
		if u:IsValid() then cdq[i] = true; end
	end
end
VFLP.RegisterFunc("RDXDAL: UnitDB", "FlushCDs", FlushCDs, true);

-----------------------------------------------------------------
-- RAID ROSTER
-----------------------------------------------------------------

local GetRosterInfo = VFL.Nil;
-- When the group is a party, get the roster info for the given unit.
local function party_GetRosterInfo(idx, uid)
	if not uid then return nil; end
	local class = UnitClass(uid);
	local llv = 0;
	--if IsSolo() or UnitIsPartyLeader(uid) then llv = 2; end
	if UnitIsGroupLeader(uid) then llv = 2; end
	local name, server = UnitName(uid);
	if (server and server ~= "") then
		name = name.."-"..server;
	end
	return name, llv, 1, UnitLevel(uid), nil, class;
end

-- Main roster processing.
local _rtouched, _gtouched = {}, {};
local function ProcessRoster()
	RDXDAL:Debug(3, "ProcessRoster");
	VFL.empty(_rtouched);
	VFL.empty(_gtouched);

	local roster_changed = nil;
	local my_ndata, my_edata;
	local iunit, uid, nunit;
	local name, leaderLevel, grp, level, class, classec, racec, guid;
	local gid, mygidflag = 1, false;

	RDXDAL.BeginEventBatch();

	-- Iterate over all valid units
	local n = GetNumUnits();
	RDXDAL:Debug(4, "ProcessRoster(): processing ", n, " units.");
	for i=1,n do
		iunit = ubi[i];
		uid = num2id[i];
		name, leaderLevel, grp, level, _, class = GetRosterInfo(i, uid);
		_, classec = UnitClass(uid);
		_, racec = UnitRace(uid);
		guid = UnitGUID(uid);
		-- gid (id in the group)
		gid = i - ((grp-1)*5);
		if gid == 1 then mygidflag = false; end
		if UnitIsUnit(uid, "player") then 
			mygidflag = true; gid = 0;
		elseif mygidflag then 
			gid = gid -1;
		end
		
		if (not name) or (name == "Unknown") then
			-- This unit is now invalid...
			iunit:Invalidate();
		else
			--VFL.print("ROSTER Update " .. name);
			iunit.rosterName = name;
			name = strlower(UnitName(uid));
			if UnitIsUnit(uid, "player") then 
				iunit.me = true;
			else
				iunit.me = false;
			end
			-- Mark engine unit as valid
			iunit.uid = uid; 
			iunit.guid = guid;
			iunit.class = class;
			iunit.classec = classec;
			iunit.racec = racec;
			iunit.classid = RDXMD.GetClassID(classec);
			iunit:Validate();
			-- If engine unit has changed, schedule it for rediscovery
			if(iunit.name ~= name) then 
				RDXDAL:Debug(5, "Roster: NID<", tostring(i), "> ", tostring(iunit.name), " -> ", tostring(name));
				iunit.name = name;
				-- When an engine unit changes identities, update auras too.
				auraq[i] = true;
				roster_changed = true; 
			end
			
			-- Acquire nominative unit and mark as valid
			nunit = ubn[name];
			if not nunit then
				nunit = CreateUnitName(name);
				nunit.me = iunit.me;
				nunit:ProcessCooldown(classec, racec);
				-- init the myunit
				if nunit.me then
					myunit = nunit;
				end
			end
			nunit.rosterName = iunit.rosterName;
			nunit.uid = uid;
			nunit.guid = guid;
			nunit.class = class;
			nunit.classec = classec;
			nunit.classid = RDXMD.GetClassID(classec);
			nunit:Validate();
			
			if(nunit.nid ~= i) then nunit.nid = i; roster_changed = true; end
			-- Mark unit as touched this session
			_rtouched[name] = iunit;
			if guid then _gtouched[guid] = iunit; end
			
			-- Get unit data
			my_ndata = GetNData(name); my_edata = GetEData(i);

			-- Update unit data
			my_ndata.SetLeaderLevel(nil, leaderLevel);
			my_edata.SetGroup(nil, grp);
			my_edata.SetMemberGroupId(nil, gid);

			-- Attach new edata to nunit
			VFL.mixin(nunit, my_edata, true);			
			-- Atach new ndata to eunit
			VFL.mixin(iunit, my_ndata, true);
		end
	end

	-- Iterate over all invalid units
	if (n < 40) and (ubi[n+1]:_ValidMetatable()) then roster_changed = true; end
	for i=(n+1),40 do
		if ubi[i]:Invalidate() then
			RDXDAL:Debug(6, "Roster: NID<", i, "> quashed.");
		end
	end

	-- Invalidate all nominative units no longer present disable see unitpool
	--for k,v in pairs(ubn) do
	--	if not _rtouched[k] then v:Invalidate(); end
	--end

	-- Notify of a roster update
	if roster_changed then RDXEvents:Dispatch("ROSTER_NIDS_CHANGED", _rtouched); end
	RDXDAL:Debug(3,"FIRE ROSTER_UPDATE");
	RDXEvents:Dispatch("ROSTER_UPDATE", _rtouched);
	RDXDAL.EndEventBatch();
end
VFLP.RegisterFunc("RDXDAL: UnitDB", "ProcessRoster", ProcessRoster, true);

-- Pet processing
local _petrtouched, _petgtouched = {}, {};
-- Latched to prevent uberspam.
--local ProcessPets = VFLT.CreatePeriodicLatch(1, function()
local function ProcessPets()
	RDXDAL:Debug(3, "ProcessPets");
	VFL.empty(_petrtouched);
	VFL.empty(_petgtouched);
	local unit, uid, changed;
	changed = nil;
	for i=41,80 do
		unit = ubi[i]; uid =  num2id[i];
		if uid and UnitExists(uid) then
			if not unit:IsValid() then
				unit:Validate();
				unit.uid = uid;
				unit.name = strlower(UnitName(uid));
				unit.guid = UnitGUID(uid);
				unit.class, unit.classec = UnitClass(uid);
				if not unit.class then unit.class = "Pet"; end
				if not unit.classec then unit.classec = "PET"; end
				auraq[i] = true; changed = true;
				unit.nid = i;
				if unit.name then _petrtouched[unit.name] = unit; end
				if unit.guid then _petgtouched[unit.guid] = unit; end
				RDXDAL:Debug(5, "PetRoster: NID<", tostring(i), "> ", tostring(unit.name));
			end
		elseif unit:_ValidMetatable() then
			RDXDAL:Debug(6, "PetRoster: NID<", i, "> quashed.");
			unit:Invalidate();
			changed = true;
		end
	end
	if changed then
		RDXDAL:Debug(3,"FIRE ROSTER_PETS_CHANGED");
		RDXEvents:Dispatch("ROSTER_PETS_CHANGED"); 
	end
end
--end);
VFLP.RegisterFunc("RDXDAL: UnitDB", "ProcessPets", ProcessPets, true);
WoWEvents:Bind("UNIT_PET", nil, ProcessPets);

--function RDX.ProcessPetsDelay()
--	VFLT.ZMSchedule(1, function() ProcessPets(); end);
--end

-- Pets: whenever a major change in the raid roster happens, or a UNIT_PET happens
-- let's update the pets.
--WoWEvents:Bind("GROUP_ROSTER_UPDATE", nil, ProcessPets);
--WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, ProcessPets);

----------------------------------------------------------------------------
-- ROSTER EVENT BINDINGS
----------------------------------------------------------------------------
local process_flag = nil;

local function SetRaid(noReprocess)
	RDXDAL:Debug(2, "SetRaid");

	SetRaidIDDatabase();
	GetNumUnits = raid_GetNumUnits;
	GetRosterInfo = GetRaidRosterInfo;

	if not noReprocess then
		RDXDAL.BeginEventBatch();
		ProcessRoster();
		ProcessPets();
		FlushAuras();
		RDXDAL.EndEventBatch();
	end
	
	SwitchState();
	-- use by old stuff
	RDXEvents:Dispatch("PARTY_IS_RAID");
end

local function SetParty(noReprocess)
	RDXDAL:Debug(2, "SetParty");
	
	SetPartyIDDatabase();
	GetNumUnits = party_GetNumUnits;
	GetRosterInfo = party_GetRosterInfo;

	if not noReprocess then
		RDXDAL.BeginEventBatch();
		ProcessRoster();
		ProcessPets();
		FlushAuras();
		RDXDAL.EndEventBatch();
	end

	SwitchState();
	RDXEvents:Dispatch("PARTY_IS_NONRAID");
end

local function SetSolo(noReprocess)
	RDXDAL:Debug(2, "SetSolo");
	
	SetPartyIDDatabase();
	GetNumUnits = party_GetNumUnits;
	GetRosterInfo = party_GetRosterInfo;

	if not noReprocess then
		RDXDAL.BeginEventBatch();
		ProcessRoster();
		ProcessPets();
		FlushAuras();
		RDXDAL.EndEventBatch();
	end

	SwitchState();
	RDXEvents:Dispatch("PARTY_IS_NONRAID");
end

-- Called on the WoW RAID_ROSTER_UPDATE event.
-- Latched to prevent uberspam. (when too many people join the raid)
local OnGroupRosterUpdate = VFLT.CreatePeriodicLatch(1, function()
	RDXDAL:Debug(2, "OnGroupRosterUpdate");
	if IsInRaid() then
		SetRaid();
	elseif IsInGroup() then
		SetParty();
	else 
		SetSolo();
	end
end);
WoWEvents:Bind("GROUP_ROSTER_UPDATE", nil, OnGroupRosterUpdate);

-- Before everything loads, let's setup in a default nonraid state
--RDXEvents:Bind("INIT_PRELOAD", nil, function()
--	RDXDAL:Debug(1, "INIT_PRELOAD");	
--end);

-- After everything loads, let's double check our party/raid status. 
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function() 
	if IsInRaid() then
		SetRaid();
	elseif IsInGroup() then
		SetParty();
	else 
		SetSolo();
	end 
end);

-- bug GUID not available at INIT_VARIABLES_LOADED, and unitraid
-- this event is only fire when you log in the game, not on reloadUI
--WoWEvents:Bind("KNOWLEDGE_BASE_SYSTEM_MOTD_UPDATED", nil, function()
--	VFLT.NextFrame(math.random(10000000), function() RDX._Roster(); RDXEvents:Dispatch("ROSTER_NIDS_CHANGED"); end);
--end);

------------------------------------------------------------
-- Arena roster
------------------------------------------------------------

-- Arena processing
local ProcessArenaRoster = function(arg1, arg2)
	--RDX.printW("Roster: ProcessArenaRoster()");
	local unit, uid, changed;
	changed = nil;
	for i=81,85 do
		uid = num2id[i];
		if uid == arg1 then
			unit = ubi[i]; 
			unit:Validate();
			unit.uid = uid;
			name = UnitName(uid);
			if name then unit.name = strlower(name); else unit.name = "Unknown name"; end
			unit.guid = UnitGUID(uid);
			if not unit.guid then unit.guid = "Unknow arena"; end
			unit.class, unit.classec = UnitClass(uid);
			if not unit.class then unit.class = "Arena"; end
			if not unit.classec then unit.classec = "ARENA"; end
			if name then
				auraq[i] = true; changed = true;
			end
			unit.nid = i;
			unit.arena = arg2;
			
			--if name then
			--	local nunit = ubn[unit.name];
			--	if not nunit then
			--		nunit = CreateUnitName(unit.name);
			--	end
			--	nunit.rosterName = unit.rosterName;
			--	nunit.uid = unit.uid;
			--	nunit.guid = unit.guid;
			--	nunit.class = unit.class;
			--	nunit.classec = unit.classec;
			--	nunit.classid = RDXMD.GetClassID(unit.classec);
			--	nunit:Validate();
			--	nunit.arena = arg2;
			--end
		end
	end
	if changed then 
		--RDX.printW("ARENA_ROSTER_CHANGED");
		RDXEvents:Dispatch("ARENA_ROSTER_CHANGED"); 
	end
end

VFLP.RegisterFunc("RDXDAL: UnitDB", "ProcessArenaRoster", ProcessArenaRoster, true);


WoWEvents:Bind("ARENA_OPPONENT_UPDATE", nil, ProcessArenaRoster);

-- Arenapets processing
local ProcessArenaPets = VFLT.CreatePeriodicLatch(1, function()
	RDX:Debug(2, "Roster: ProcessArenaPets()");
	local unit, uid, changed;
	changed = nil;
	for i=86,90 do
		unit = ubi[i]; 
		uid = num2id[i];
		unit:Validate();
		unit.uid = uid;
		name = UnitName(uid);
		if name then unit.name = strlower(name); else unit.name = "Unknown name"; end
		unit.guid = UnitGUID(uid);
		if not unit.guid then unit.guid = "Unknow arena pet"; end
		unit.class, unit.classec = UnitClass(uid);
		if not unit.class then unit.class = "ArenaPet"; end
		if not unit.classec then unit.classec = "ARENAPET"; end
		if name then
			auraq[i] = true; changed = true;
		end
		unit.nid = i;
	end
	if changed then 
		RDX:Debug(2, "ARENA_ROSTER_PETS_CHANGED");
		RDXEvents:Dispatch("ARENA_ROSTER_PETS_CHANGED"); 
	end
end);
VFLP.RegisterFunc("RDXDAL: UnitDB", "ProcessArenaPets", ProcessArenaPets, true);

WoWEvents:Bind("UNIT_PET", nil, ProcessArenaPets);

--local ProcessBoss = VFLT.CreatePeriodicLatch(1, function()
local ProcessBoss = function()
	RDX:Debug(2, "Roster: ProcessBoss()");
	local unit, uid, changed, name;
	changed = nil;
	for i=91,94 do
		unit = ubi[i]; 
		uid = num2id[i];
		unit:Validate(); -- always validate
		unit.uid = uid; -- boss1, boss2 ...
		name = UnitName(uid);
		if name then unit.name = strlower(name); else unit.name = "Unknown name"; end
		unit.guid = UnitGUID(uid);
		if not unit.guid then unit.guid = "Unknown GUID"; end
		unit.class, unit.classec = UnitClass(uid);
		if not unit.class then unit.class = "boss"; end
		if not unit.classec then unit.classec = "BOSS"; end
		if name then
			auraq[i] = true; changed = true;
		end
		unit.nid = i;
	end
	if changed then 
		RDX:Debug(2, "BOSS_ROSTER_CHANGED");
		--RDXEvents:Dispatch("BOSS_ROSTER_CHANGED");
		RDXEvents:Dispatch("DISRUPT_WINDOWS", "BOSS");
	end
end
VFLP.RegisterFunc(VFLI.i18n("RDXDAL: UnitDB"), "ProcessBoss", ProcessBoss, true);
WoWEvents:Bind("INSTANCE_ENCOUNTER_ENGAGE_UNIT", nil, ProcessBoss);
WoWEvents:Bind("UNIT_TARGETABLE_CHANGED", nil, ProcessBoss);
WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, ProcessBoss);
--VFLEvents:Bind("PLAYER_COMBAT", nil, ProcessBoss);

------------------------------------------------------------
-- ROSTER LOOKUP AND INDEXING
-----------------------------------------------------------

--- Get a reference to a unit by its unit number.
-- @param i The unit number to query.
-- @return A reference to the unit object with unit number i.
function RDXDAL.GetUnitByNumber(i)
	if not i then return nil; end
	return ubi[i];
end

--- Get a reference to a unit by its name.
-- @param n The name (all lowercase) of the unit to query.
-- @return A reference to the unit object for the unit named n.
function RDXDAL.GetUnitByName(n, class)
	if not n then return nil; end
	--local n = GetBGName(m);
	local r = ubn[strlower(n)];
	if not r then
		r = CreateUnitName(strlower(n));
		r:ProcessCooldown(class);
	end
	return r;
end

--- Get the RDX Unit for this raider if he's in the raid; otherwise
-- return nil.
function RDXDAL.GetUnitByNameIfInGroup(n)
	return _rtouched[strlower(n)];
end

function RDXDAL.InRoster(n)
	if _rtouched[n] then return true; end 
end

function RDXDAL.UnitInGroup(uid)
	return (UnitInParty(uid) or UnitInRaid(uid));
end

function RDXDAL.ProjectUnitID(uid)
	for i=1,NUM_UNITS do
		if UnitIsUnit(num2id[i] or "none", uid) then return ubi[i]; end
	end
end

function RDXDAL._FastProject(uid)
	if not RDXDAL.UnitInGroup(uid) then return nil; end
	local un = id2num[uid]; if not un then return nil; end
	return ubi[un];
end

function RDXDAL._ReallyFastProject(uid)
	if not uid then return nil; end
	local un = id2num[uid]; if not un then return nil; end
	return ubi[un];
end


-- Get the RDX Unit for this raider if he's in the raid; otherwise
-- return nil.
function RDXDAL.GetUnitByGUIDIfInGroup(guid)
	return _gtouched[guid] or _petgtouched[guid];
end

-- not really fast but all and PET
function RDXDAL.GetUnitByGUID(guid)
	for i,_ in pairs(ubi) do
		if not ubi[i].guid then ubi[i].guid = UnitGUID(ubi[i].uid); end
		if (ubi[i].guid == guid) then return ubi[i]; end
	end
end

function RDXDAL.GetMyUnit()
	return myunit;
end

--function RDX.TESTPrint()
--	for i,_ in pairs(ubi) do
--		if ubi[i].guid then VFL.print(ubi[i].guid); end
--	end
--end

-----------------------------------------------------
-- ITERATORS
-- Iterate over the units in the raid.
-----------------------------------------------------
-- Return an iterator over the current group.
local function giter(_, i)
	i=i+1;
	local u = ubi[i];
	if u and u:IsCacheValid() then return i, u; end
end

function RDXDAL.Raid()
	return giter, nil, 0;
end

-- Return an iterator for all, raids and pets
local function giter2(_, i)
	i=i+1;
	local u = ubi[i];
	if u and i < 81 then return i, u; end
end

function RDXDAL.RaidAll()
	return giter2, nil, 0;
end

local function GroupStatelessIterator(gn, idx)
	local u = nil;
	while true do
		idx = idx + 1; u = ubi[idx];
		if (not u) or (not u:IsCacheValid()) then break; end
		--if (not u) or (not u:IsValid()) then break; end
		if (u:GetGroup() == gn) then return idx, u; end
	end
end

function RDXDAL.Group(gn)
	if not gn then return giter, nil, 0; end
	return GroupStatelessIterator, gn, 0;
end

-- Return an iterator for arena
local function giter3(_, i)
	i=i+1;
	local u = ubi[80 + i];
	if u then return i, u; end
end

function RDXDAL.ArenaGroup()
	return giter3, nil, 0;
end


-------------------------------
-- PROJECTIVE UNIT
-- A projective unit is a unit with a non-canonical id (i.e. not partyX or raidX)
-- that may or may not be equivalent to one of the canonical units. If it is,
-- there is a Project() operator that will figure out which one and match
-- edata and ndata appropriately.
-------------------------------
local function ProjUnit_Project(self)
	local uid, nid = self.uid, 0;
	-- Project
	if UnitExists(uid) then
		self.name = strlower(UnitName(uid));
		self.guid = UnitGUID(uid);
		self.class, self.classec = UnitClass(uid);
		for i=1,NUM_UNITS do
			if UnitIsUnit(num2id[i] or "none", uid) then nid = i; end
		end
	else
		self.name = "";
	end
	-- Store nid
	self.nid = nid;
	-- Get unit data
	VFL.mixin(self, GetEData(nid), true);
	if RDXDAL.InRoster(self.name) or UnitIsPlayer(uid) then -- or boss
		local ndata, create = GetNData(self.name);
		ndata.timestamp = GetTime();
		VFL.mixin(self, ndata, true);
		if create then
			self:ProcessCooldown(self.classec);
		end
	else
		local ndata, create = GetNData("");
		VFL.mixin(self, ndata, true);
	end
end

RDXDAL.ProjectiveUnit = {};
function RDXDAL.ProjectiveUnit:new()
	local x = unitpool.Acquirer();
	--VFL.print("ProjectiveUnit new");
	x:Validate();
	x.uid = "none"; x.name = "unknown"; x.nid = 0; x.guid = "unknown";
	x.class = "unknown"; x.classec = "unknown";
	x._Project = ProjUnit_Project;
	x.Invalidate = VFL.Noop; x.Validate = VFL.Noop;
	return x;
end

------------------------------------------------------------
-- EVENTS RDX
------------------------------------------------------------
--local _sig_rdx_unit_attack_power = RDXEvents:LockSignal("UNIT_ATTACK_POWER");
--local _sig_rdx_unit_attack_speed = RDXEvents:LockSignal("UNIT_ATTACK_SPEED");
local _sig_rdx_debuff_star = RDXEvents:LockSignal("UNIT_DEBUFF_*");
local _sig_rdx_buff_star = RDXEvents:LockSignal("UNIT_BUFF_*");
local _sig_rdx_delayed_debuff_star = RDXEvents:LockSignal("DELAYED_UNIT_DEBUFF_*");
local _sig_rdx_delayed_buff_star = RDXEvents:LockSignal("DELAYED_UNIT_BUFF_*");
local _sig_rdx_unit_buffweapon_update = RDXEvents:LockSignal("UNIT_BUFFWEAPON_UPDATE");
local _sig_rdx_mybuff_star = RDXEvents:LockSignal("UNIT_MYBUFF_*");
local _sig_rdx_unit_aura = RDXEvents:LockSignal("UNIT_AURA");
local _sig_rdx_unit_cooldown = RDXEvents:LockSignal("UNIT_COOLDOWN");
local _sig_rdx_unit_cast_timer_update = RDXEvents:LockSignal("UNIT_CAST_TIMER_UPDATE");
local _sig_rdx_unit_cast_timer_stop = RDXEvents:LockSignal("UNIT_CAST_TIMER_STOP");
local _sig_rdx_unit_combo_points = RDXEvents:LockSignal("UNIT_COMBO_POINTS");
--local _sig_rdx_unit_dynamic_flags = RDXEvents:LockSignal"UNIT_DYNAMIC_FLAGS"); -- statistics
-- "UNIT_ENTERED_VEHICLE"
-- "UNIT_EXITED_VEHICLE"
local _sig_rdx_unit_entering_world = RDXEvents:LockSignal("UNIT_ENTERING_WORLD");
local _sig_rdx_unit_faction = RDXEvents:LockSignal("UNIT_FACTION");
local _sig_rdx_unit_flags = RDXEvents:LockSignal("UNIT_FLAGS");
local _sig_rdx_unit_focus = RDXEvents:LockSignal("UNIT_FOCUS");
local _sig_rdx_unit_health = RDXEvents:LockSignal("UNIT_HEALTH");
local _sig_rdx_unit_heal_prediction = RDXEvents:LockSignal("UNIT_HEAL_PREDICTION");
local _sig_unit_ndata_sync = RDXEvents:LockSignal("UNIT_NDATA_SYNC");
local _sig_rdx_unit_portrait_update = RDXEvents:LockSignal("UNIT_PORTRAIT_UPDATE");
local _sig_rdx_unit_power = RDXEvents:LockSignal("UNIT_POWER");
local _sig_rdx_unit_range = RDXEvents:LockSignal("UNIT_RANGED");
local _sig_rdx_unit_ready_check_update = RDXEvents:LockSignal("UNIT_READY_CHECK_UPDATE");
local _sig_rdx_unit_rune_power_update = RDXEvents:LockSignal("UNIT_RUNE_POWER_UPDATE");
local _sig_rdx_unit_rune_type_update = RDXEvents:LockSignal("UNIT_RUNE_TYPE_UPDATE");
local _sig_rdx_unit_melee_update = RDXEvents:LockSignal("UNIT_SWING_MELEE_UPDATE");
local _sig_rdx_unit_target = RDXEvents:LockSignal("UNIT_TARGET");
local _sig_rdx_unit_threat_situation_update = RDXEvents:LockSignal("UNIT_THREAT_SITUATION_UPDATE");
local _sig_rdx_unit_totem_update = RDXEvents:LockSignal("UNIT_TOTEM_UPDATE");
local _sig_rdx_unit_xp_update = RDXEvents:LockSignal("UNIT_XP_UPDATE");

--
-- ndata:GetNField("sync") return the sync table
-- ndata:SetNField("sync", t) set the sync table not use
-- the sync table is used to sync extra info for all members
--

local function RpcNdataSync(ci, t)
	local unit = RPC.GetSenderUnit(ci);
	if (not unit) or (not unit:IsValid()) or unit.me then return; end	
	local syncdata = unit:GetNField("sync");
	VFL.copyInto(syncdata, t);
	_sig_unit_ndata_sync:Raise(unit, unit.nid, unit.uid);
end
RPC_Group:Bind("ndata_sync", RpcNdataSync);

local function SendNdataSync()
	if not InCombatLockdown() and myunit then
		local t = myunit:GetNField("sync");
		if t and type(t) == "table" then
			RPC_Group:Flash("ndata_sync", t);
		end
	end
end

RDXEvents:Bind("INIT_DEFERRED", nil, function()
	SendNdataSync();
	-- Start periodic broadcasts
	VFLT.AdaptiveSchedule2("UDB:SendNdataSync", 60, SendNdataSync);
	VFLP.RegisterFunc("RDX", "UDB:SendNdataSync", SendNdataSync, true);
end);

------------------------------------------------------------
-- UNIT_AURA HANDLING
------------------------------------------------------------
-- Perf: how many auras should I process per frame?
local aura_unitsPerUpdate = 3;

-- Process pending aura updates
local iaura, batchTrig, debuffFlag, buffFlag;
local function ProcessAuraQueue()
	iaura, batchTrig, debuffFlag, buffFlag = 1, nil, false, false;
	for un,_ in pairs(auraq) do
		if(iaura > aura_unitsPerUpdate) then break; end
		if not batchTrig then batchTrig = true; RDXDAL.BeginEventBatch(); end
		debuffFlag, buffFlag = ubi[un]:ProcessAuras();
		auraq[un] = nil;
		iaura = iaura + 1;
		--if buffFlag then
			_sig_rdx_buff_star:Raise(ubi[un], un, 1);
		--end
		--if debuffFlag then 
			_sig_rdx_debuff_star:Raise(ubi[un], un, 1);
		--end
	end
	if batchTrig then RDXDAL.EndEventBatch(); end
end
local auraFrame = CreateFrame("Frame");
auraFrame:SetScript("OnUpdate", ProcessAuraQueue);
VFLP.RegisterFunc("RDXDAL: UnitDB", "ProcessAuraQueue", ProcessAuraQueue, true);

-- On UNIT_AURA, add the aura'd unit to the aura queue.
WoWEvents:Bind("UNIT_AURA", nil, function(arg1)
	local x = id2num[arg1];
	if x then
		auraq[x] = true;
		_sig_rdx_unit_aura:Raise(ubi[x], x, arg1);
	end
end);

-- On PLAYER_ENTERING_WORLD, refresh all auras.
WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, FlushAuras);

-------------------------------
-- COOLDOWN HANDLING
-------------------------------
local cd_unitsPerUpdate = 3;
local function ProcessCDQueue()
	icd, batchTrig = 1, nil;
	for un,_ in pairs(cdq) do
		if(icd > cd_unitsPerUpdate) then break; end
		if not batchTrig then batchTrig = true; RDXDAL.BeginEventBatch(); end
		cdq[un] = nil;
		--VFL.print("windows sig " .. ubi[un].name);
		_sig_rdx_unit_cooldown:Raise(ubi[un], un, 1);
		icd = icd + 1;
	end
	if batchTrig then RDXDAL.EndEventBatch(); end
end
local cdFrame = CreateFrame("Frame");
cdFrame:SetScript("OnUpdate", ProcessCDQueue);
VFLP.RegisterFunc("RDXDAL: UnitDB", "ProcessCDQueue", ProcessCDQueue, true);

local IsDamageSpell = RDXCD.IsDamageSpell;
local IsHealSpell = RDXCD.IsHealSpell;
local IsCastSpell = RDXCD.IsCastSpell;
local IsAuraASpell = RDXCD.IsAuraASpell;
local IsAuraRSpell = RDXCD.IsAuraRSpell;
local IsResuSpell = RDXCD.IsResuSpell;
local IsSumSpell = RDXCD.IsSumSpell;
-- see the roster cooldown folder.
local function ParseSpellSuccess(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, spellid, spellname)
	--if event and spellid and spellname then VFL.print(event .. " " .. spellid .. " " .. spellname); end
	if (event == "SPELL_DAMAGE" and IsDamageSpell(spellid)) or (event == "SPELL_HEAL" and IsHealSpell(spellid)) or (event == "SPELL_CAST_SUCCESS" and IsCastSpell(spellid)) or (event == "SPELL_AURA_APPLIED" and IsAuraASpell(spellid)) or (event == "SPELL_AURA_REMOVED" and IsAuraRSpell(spellid)) or (event == "SPELL_RESURRECT" and IsResuSpell(spellid)) or (event == "SPELL_SUMMON" and IsSumSpell(spellid)) then
		if sourceName then
			local unit = _rtouched[strlower(sourceName)];
			if unit then
				--local cd = {spellname = spellname, spellid = spellid, duration = cdInfo.duration, start = GetTime()};
				--duration = unit:GetCooldownDuration(spellid);
				--if not duration then duration = cdInfo.duration; end
				--if cdInfo.group then
				--	local cdgroup = RDXCD.GetGroupCooldowns(cdInfo.group);
				--	for f,v in pairs(cdgroup) do
				--		unit:AddCooldown(v.spellname, v.spellid, GetTime() + duration);
				--	end
				--else
					unit:AddCooldown(spellid);
				--end
			--else
				-- no unit, but we still want to create the unit data.
				-- need a lot of test, may be huge memory usage
				--local _, class, _, race = GetPlayerInfoByGUID(sourceGUID);
				--if class then
				--	local ndata, create = GetNData(strlower(sourceName));
				--	ndata.timestamp = GetTime();
				--	if create then
				--		ndata:ProcessCooldown(class, race);
				--	end
				--	ndata:AddCooldown(spellid);
				--end
			end
		end
	end
end

RDXEvents:Bind("INIT_SPELL", nil, function()
	WoWEvents:Bind("COMBAT_LOG_EVENT_UNFILTERED", nil, ParseSpellSuccess, "Cooldown");
end);

------------------------------------------------------------
-- UNIT_HEALTH/UNIT_POWER HANDLING
------------------------------------------------------------

-- Propagate events only if they pertain to RDX-managed units, and
-- promote the units from raw unit IDs to full fledged RDX unit 
-- objects.
local function UnitHealthPropagator(arg1)
	local x = id2num[arg1];
	if x then
		_sig_rdx_unit_health:Raise(ubi[x], x, arg1, UnitHealth(arg1), UnitHealthMax(arg1));
	end
end
local function UnitHealPredictionPropagator(arg1)
	local x = id2num[arg1];
	if x then
		_sig_rdx_unit_heal_prediction:Raise(ubi[x], x, arg1, UnitHealth(arg1), UnitHealthMax(arg1));
	end
end
local function UnitPowerPropagator(arg1)
	local x = id2num[arg1];
	if x then
		_sig_rdx_unit_power:Raise(ubi[x], x, arg1, UnitPower(arg1), UnitPowerMax(arg1));
	end
end

-- Raw bindings
WoWEvents:Bind("UNIT_HEALTH", nil, UnitHealthPropagator);
WoWEvents:Bind("UNIT_MAXHEALTH", nil, UnitHealthPropagator);
WoWEvents:Bind("UNIT_HEAL_PREDICTION", nil, UnitHealPredictionPropagator);
WoWEvents:Bind("UNIT_POWER", nil, UnitPowerPropagator);
WoWEvents:Bind("UNIT_MAXPOWER", nil, UnitPowerPropagator);
--WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, UnitPowerPropagator);

------------------------------------------------------------------
-- FEIGN DEATH CHECKING
------------------------------------------------------------------
-- If a unit's health drops low, check it for the FeignDeath buff. If so, mark as feigned.
RDXEvents:Bind("UNIT_HEALTH", nil, function(u, un, uid, uh)
	if(uh < 2) and (not u:IsFeigned()) and (UnitIsFeignDeath(uid)) and (not u:IsPet()) then
		u:_SetFeigned(true);
		RDXEvents:Dispatch("UNIT_FEIGN_DEATH", u, un, uid, true);
	end
end);

-- When a FD unit's auras change, snap check to see if FD went away.
RDXEvents:Bind("UNIT_AURA", nil, function(u, un, uid)
	if u:IsFeigned() and (not UnitIsFeignDeath(uid)) and (not u:IsPet()) then
		u:_SetFeigned(nil);
		RDXEvents:Dispatch("UNIT_FEIGN_DEATH", u, un, uid, false);
	end
end);

--------------------------------------------
-- TOTEM EVENTS
--------------------------------------------

--WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, function()
--	local myunit = RDXDAL._ReallyFastProject("player");
--	_sig_rdx_unit_entering_world:Raise(myunit, myunit.nid, myunit.uid);
--end);

-- Target change
WoWEvents:Bind("PLAYER_TOTEM_UPDATE", nil, function(arg1)
	if myunit then
		_sig_rdx_unit_totem_update:Raise(myunit, myunit.nid, myunit.uid);
	end
end);

--------------------------------------------
-- COMBO EVENTS
--------------------------------------------

WoWEvents:Bind("PLAYER_TARGET_CHANGED", nil, function(arg1)
	if myunit then
		_sig_rdx_unit_combo_points:Raise(myunit, myunit.nid, myunit.uid);
	end
end);

WoWEvents:Bind("UNIT_COMBO_POINTS", nil, function(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_combo_points:Raise(ubi[x], x, arg1); end
end);

--------------------------------------------
-- RUNES EVENTS
--------------------------------------------

WoWEvents:Bind("RUNE_POWER_UPDATE", nil, function(arg1)
	if myunit then
		_sig_rdx_unit_rune_power_update:Raise(myunit, myunit.nid, myunit.uid);
	end
end);

WoWEvents:Bind("RUNE_TYPE_UPDATE", nil, function(arg1)
	if myunit then
		_sig_rdx_unit_rune_type_update:Raise(myunit, myunit.nid, myunit.uid);
	end
end);

--------------------------------------------
-- BUFF WEAPON EVENTS
--------------------------------------------

-- there is no event to track enchant weapons...
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	local timemh, timeoh = 0, 0;
	local hasMainHandEnchant, mainHandExpiration, hasOffHandEnchant, offHandExpiration;
	local function weaponsupdate()
		if myunit then
			hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo();
			if hasMainHandEnchant then
				if mainHandExpiration > timemh then
					_sig_rdx_unit_buffweapon_update:Raise(myunit, myunit.nid, myunit.uid);
				end
				timemh = mainHandExpiration;
			elseif timemh > 0 then
				_sig_rdx_unit_buffweapon_update:Raise(myunit, myunit.nid, myunit.uid);
				timemh = 0;
			end
			if hasOffHandEnchant then
				if offHandExpiration > timeoh then
					_sig_rdx_unit_buffweapon_update:Raise(myunit, myunit.nid, myunit.uid);
				end
				timeoh = offHandExpiration;
			elseif timeoh > 0 then
				_sig_rdx_unit_buffweapon_update:Raise(myunit, myunit.nid, myunit.uid);
				timeoh = 0;
			end
		end
	end
	VFLT.AdaptiveSchedule2("UDB:weaponsUpdate", 2, weaponsupdate, true);
	VFLP.RegisterFunc("RDX", "UDB:weaponsUpdate", weaponsupdate, true);
end);

--------------------------------------------
-- MISC EVENTS
--------------------------------------------
-- store spell and rank
-- disable 7.0.3
--[[ WoWEvents:Bind("UNIT_SPELLCAST_SENT", nil, function()
	if not arg1 then return; end
	local x = id2num[arg1];
	local un = ubi[x];
	if un then 
		if arg2 and arg3 then
			un.SetLastSpellRank(arg2, string.match(arg3, VFLI.i18n("Rank (%d+)")));
		end
	end
end);]]

-- Powertype change
WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function(arg1)
	local x =_rtouched[strlower(arg1)];
	if x then
		RDXEvents:Dispatch("UNIT_DISPLAYPOWER", x, x.nid, arg1);
	end
end);

-- Target change
WoWEvents:Bind("UNIT_TARGET", nil, function(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_target:Raise(ubi[x], x, arg1); end
end);

-- Focus change remove 4.0
--WoWEvents:Bind("UNIT_FOCUS", nil, function(arg1)
--	local x = id2num[arg1];
--	if x then _sig_rdx_unit_focus:Raise(ubi[x], x, arg1); end
--end);

-- Flags change (combat etc stunned, feared)
local function flagprop(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_flags:Raise(ubi[x], x, arg1); end
end
WoWEvents:Bind("UNIT_FLAGS", nil, flagprop);
WoWEvents:Bind("UNIT_DYNAMIC_FLAGS", nil, flagprop);

-- Rangedamage
local function rangeprop(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_range:Raise(ubi[x], x, arg1); end
end
WoWEvents:Bind("UNIT_RANGEDDAMAGE", nil, rangeprop);
WoWEvents:Bind("UNIT_RANGED_ATTACK_POWER", nil, rangeprop);

-- Portrait change.
WoWEvents:Bind("UNIT_PORTRAIT_UPDATE", nil, function(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_portrait_update:Raise(ubi[x], x, arg1); end
end);

-- XP
local function filter_xp_update(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_xp_update:Raise(ubi[x], x, arg1); end
end
WoWEvents:Bind("PLAYER_XP_UPDATE", nil, filter_xp_update);
WoWEvents:Bind("UPDATE_EXHAUSTION", nil, filter_xp_update);
WoWEvents:Bind("PLAYER_LEVEL_UP", nil, filter_xp_update);
WoWEvents:Bind("UNIT_PET_EXPERIENCE", nil, filter_xp_update);

-- faction change.
WoWEvents:Bind("UNIT_FACTION", nil, function(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_faction:Raise(ubi[x], x, arg1); end
end);

-- Ready check change.
WoWEvents:Bind("READY_CHECK_CONFIRM", nil, function(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_ready_check_update:Raise(ubi[x], x, arg1); end
end);

-- threat change.
WoWEvents:Bind("UNIT_THREAT_SITUATION_UPDATE", nil, function(arg1)
	local x = id2num[arg1];
	if x then _sig_rdx_unit_threat_situation_update:Raise(ubi[x], x, arg1); end
end);

-- Spell events
-- CAST_TIMER_UPDATE
local function filter_cast_timer_start(arg1)
	--RDX:Debug(1,"|cFFFF00FFSTART: ", tostring(event), "|r");
	local x = id2num[arg1];
	if x then _sig_rdx_unit_cast_timer_update:Raise(ubi[x], x, arg1); end
end
WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_START", nil, filter_cast_timer_start);
WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_UPDATE", nil, filter_cast_timer_start);
WoWEvents:Bind("UNIT_SPELLCAST_DELAYED", nil, filter_cast_timer_start);
WoWEvents:Bind("UNIT_SPELLCAST_START", nil, filter_cast_timer_start);

-- CAST_TIMER_STOP
local function filter_cast_timer_stop(arg1)
	--RDX:Debug(1,"|cFFFF00FFSTOP: ", tostring(event), "|r");
	local x = id2num[arg1];
	if x then _sig_rdx_unit_cast_timer_stop:Raise(ubi[x], x, arg1); end
end
WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_STOP", nil, filter_cast_timer_stop);
WoWEvents:Bind("UNIT_SPELLCAST_FAILED", nil, function(arg1)
	local spellName = UnitCastingInfo(arg1);
	if not spellName then
		spellName = UnitChannelInfo(arg1);
	end
	if not spellName then
		filter_cast_timer_stop();
	end
end);
WoWEvents:Bind("UNIT_SPELLCAST_INTERRUPTED", nil, filter_cast_timer_stop);
WoWEvents:Bind("UNIT_SPELLCAST_SUCCEEDED", nil, function(arg1)
	local spellName = UnitCastingInfo(arg1);
	if not spellName then
		spellName = UnitChannelInfo(arg1);
	end
	if not spellName then
		filter_cast_timer_stop();
	end
end);
WoWEvents:Bind("UNIT_SPELLCAST_STOP", nil, filter_cast_timer_stop);

----------------------
-- An easy little trick to compute player cast lag and expose it as a unitframe variable.
-- Obviously this ONLY makes sense on a player castbar; using it elsewhere will result in
-- complete and utter nonsense.
----------------------
local lagv = 0;

local function resetLag() 
	lagv = 0;
end

function RDX._GetLastSpellLag() if lagv < 10 then return lagv; else return 0; end end
WoWEvents:Bind("UNIT_SPELLCAST_SENT", nil, function(arg1) lagv = GetTime(); end);
WoWEvents:Bind("UNIT_SPELLCAST_START", nil, function(arg1)
	--VFLT.UnscheduleByName("castbarlag");
	--VFLT.scheduleNamed("castbarlag", 1.2, function() 
	--	lagv = 0;
	--end)
	if arg1 == "player" then lagv = GetTime() - lagv; end
end);
WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_START", nil, function(arg1)
	if arg1 == "player" then lagv = 0; end
end);

--WoWEvents:Bind("UNIT_SPELLCAST_FAILED", nil, resetLag);
WoWEvents:Bind("UNIT_SPELLCAST_INTERRUPTED", nil, resetLag);
--WoWEvents:Bind("UNIT_SPELLCAST_SUCCEEDED", nil, resetLag);

-- Debugging
--[[
local function evcheck()
	VFL.print("Spell event for " .. arg1 .. ": " .. GetTime() .. " = " .. event);
end
WoWEvents:Bind("UNIT_SPELLCAST_SENT", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_START", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_START", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_STOP", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_FAILED", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_INTERRUPTED", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_SUCCEEDED", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_STOP", nil, evcheck);
WoWEvents:Bind("UNIT_SPELLCAST_DELAYED", nil, evcheck);
]]--

----------------------------------------------------
-- swing melee
----------------------------------------------------
local meleemh_start, meleeoh_start, meleemh_duration, meleeoh_duration, mhflag = 0, 0, 0, 0, nil;

function RDX.GetSwingMeleeInfo()
	return meleemh_start, meleeoh_start, meleemh_duration or 0, meleeoh_duration or 0;
end

local function SwingParse(_, event, _, guid)
	if not myunit or myunit:GetGuid() ~= guid then return; end
	if event and (not string.find(event, 'SWING')) then return; end
	meleemh_duration, meleeoh_duration = UnitAttackSpeed("player");
	if OffhandHasWeapon() then
		if mhflag then
			meleemh_start = GetTime();
			mhflag = nil;
		else
			meleeoh_start = GetTime();
			mhflag = true;
		end
	else
		meleemh_start = GetTime();
		meleeoh_start = 0;
	end
	_sig_rdx_unit_melee_update:Raise(myunit, myunit.nid, myunit.uid);
end
VFLP.RegisterFunc("RDXDAL: UnitDB", "SwingParse", SwingParse, true);
WoWEvents:Bind("COMBAT_LOG_EVENT_UNFILTERED", nil, SwingParse);

-----------------------------------------------------------------
-- "DISRUPTIVE EVENTS"
-- Disruptive events are events that tend to require the whole
-- UI to rebuild itself. We consolidate them into one big event.
-----------------------------------------------------------------
local disrupt_flag, disrupt_lock = nil, nil;

local function Disruption()
	if not disrupt_lock then
		disrupt_lock = true;
		RDX:Debug(1,"|cFFFF00FFDisruption: ", tostring(event), "|r");
		RDXEvents:Dispatch("DISRUPT_SETS");
		RDXEvents:Dispatch("DISRUPT_SORTS");
		RDXEvents:Dispatch("DISRUPT_WINDOWS");
		disrupt_lock = nil;
	end
end
VFLP.RegisterFunc("RDXDAL: UnitDB", "Disruptions", Disruption, true);

local function Disruption_delay()
	Disruption();
	if InCombatLockdown() then
		disrupt_flag = true; 
	end
end

VFLEvents:Bind("PLAYER_COMBAT", nil, function()
	if disrupt_flag then
		Disruption();
		disrupt_flag = nil;
	end
end);

local function Debug_combat(flag)
	if flag then
		RDX:Debug(1,"|cFFFF00FFInCombat: ", tostring(event), "|r");
	else
		RDX:Debug(1,"|cFFFF00FFOutCombat: ", tostring(event), "|r");
	end
end

WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, Disruption_delay);
RDXEvents:Bind("ROSTER_UPDATE", nil, Disruption_delay);
RDXEvents:Bind("ROSTER_PETS_CHANGED", nil, Disruption_delay);
--RDXEvents:Bind("ARENA_ROSTER_CHANGED", nil, Disruption_delay);
--RDXEvents:Bind("ARENA_ROSTER_PETS_CHANGED", nil, Disruption_delay);
--RDXEvents:Bind("BOSS_ROSTER_CHANGED", nil, Disruption_delay);
VFLEvents:Bind("PLAYER_COMBAT", nil, function(flag) if not flag then Disruption_delay(); end; end);
VFLEvents:Bind("PLAYER_COMBAT", nil, Debug_combat);

function RDX._Disrupt()
	RDX.printI("Disruption");
	Disruption_delay();
end

function RDX._Roster()
	RDX.printI("Roster");
	ProcessRoster();
	ProcessPets();
	ProcessArenaRoster();
	ProcessArenaPets();
	ProcessBoss();
end


------------------------------------------------
-- Combat and Battleground Detection
------------------------------------------------
--local inCombat = nil;
function VFL._ForceCombatFlag(f)
	if f then
		--inCombat = true;
		VFL:Debug(1, "********** VFL combat flag TRUE *************");
		VFLEvents:Dispatch("PLAYER_COMBAT", true);
	else
		--inCombat = nil;
		VFL:Debug(1, "********** VFL combat flag FALSE *************");
		VFLEvents:Dispatch("PLAYER_COMBAT", nil);
	end
end

WoWEvents:Bind("PLAYER_REGEN_DISABLED", nil, function() VFL._ForceCombatFlag(true); end);
WoWEvents:Bind("PLAYER_REGEN_ENABLED", nil, function() VFL._ForceCombatFlag(nil); end);

function VFL.PlayerInCombat() return InCombatLockdown(); end

-- talent detection
local talent = nil;
function VFL._ForceTalentSwitch(f, nosend)
	if f ~= talent then
		talent = f;
		if not nosend then
			VFL:Debug(1, "********** Talent_changed *************");
			if not InCombatLockdown() then
				VFLT.schedule(0.5, function() VFLEvents:Dispatch("PLAYER_TALENT_UPDATE", f); end)
			end
		end
	end
end
WoWEvents:Bind("PLAYER_TALENT_UPDATE", nil, function() VFL._ForceTalentSwitch(GetSpecialization()); end);
WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, function() VFL._ForceTalentSwitch(GetSpecialization(), true); end);

function VFL.GetPlayerTalent()
	return talent;
end

-- UPDATE_SHAPESHIFT_FORM
-- UPDATE_SHAPESHIFT_FORMS
local ssform = 0;
function VFL._ForceFormSwitch(nosend)
	local index = GetShapeshiftForm();
	--VFL.print(index);
	if index and index > 0 then
		local _, name = GetShapeshiftFormInfo(index); 
		--VFL.print(name);
		if ssform ~= index then
			ssform = index;
			if not nosend then
				VFL:Debug(1, "********** Form_changed *************");
				VFLEvents:Dispatch("PLAYER_FORM_UPDATE", ssform);
				--VFL.print("event " .. name);
			end
		end
	end
end
WoWEvents:Bind("UPDATE_SHAPESHIFT_FORM", nil, function() VFL._ForceFormSwitch(); end);

function VFL.GetPlayerForm()
	return ssform;
end

-- Bg detection
local inBG = nil;
local function SetBGFlag(f)
	if f and (not inBG) then
		inBG = true;
		VFLEvents:Dispatch("PLAYER_IN_BATTLEGROUND", true);
	elseif (not f) and inBG then
		inBG = nil;
		VFLEvents:Dispatch("PLAYER_IN_BATTLEGROUND", nil);
	end
end

-- Arena detection
local inA = nil;
local function SetAFlag(f)
	if f and (not inA) then
		inA = true;
		VFLEvents:Dispatch("PLAYER_IN_ARENA", true);
	elseif (not f) and inA then
		inA = nil;
		VFLEvents:Dispatch("PLAYER_IN_ARENA", nil);
	end
end

function VFL.InBattleground()
	--return (MiniMapBattlefieldFrame.status == "active") and select(2,IsInInstance()) == "pvp";
	return select(2,IsInInstance()) == "pvp";
end

function VFL.InArena()
	--return (MiniMapBattlefieldFrame.status == "active") and select(2, IsInInstance()) == "arena";
	return select(2, IsInInstance()) == "arena";
end

WoWEvents:Bind("UPDATE_BATTLEFIELD_STATUS", nil, function()
	if VFL.InBattleground() then
		SetBGFlag(true);
	else
		SetBGFlag(nil);
	end
	if VFL.InArena() then
		SetAFlag(true);
	else
		SetAFlag(nil);
	end
end);

function VFL.GetBGName(name)
	-- remove any dash
	local _, _, bg_name = string.find(name, "^(.*)-(.*)$");
	-- Record the target
	if bg_name then return bg_name; else return name; end
end

-------------------------------------------------------
-- For some reason, Blizzard decided to break unit suffixing conventions by
-- replacing "raidXXpet" with "raidpetXX" (why, Blizzard, why?)
-- To make things worse, there's no such thing as "playerpet"; instead, it's just
-- "pet".
-- This function fixes that.
-------------------------------------------------------
local _pettbl = {};
_pettbl["playerpet"] = "pet";
for i=1,5 do
	_pettbl["party" .. i .. "pet"] = "partypet" .. i;
end
for i=1,40 do
	_pettbl["raid" .. i .. "pet"] = "raidpet" .. i;
end

function VFL.ResolvePetUID(uid)
	local pt = _pettbl[uid]; if pt then return pt; else return uid; end
end

local _ownertbl = {};
_ownertbl["pet"] = "player";
for i=1,5 do
	_ownertbl["partypet" .. i] = "party" .. i;
end
for i=1,40 do
	_ownertbl["raidpet" .. i] = "raid" .. i;
end

function VFL.GetPetOwnerUID(puid)
	if not puid then return; end
	return _ownertbl[puid];
end

-- Extract a unit from a secure button, properly accounting for pets.
function VFL.GetSecureButtonUnit(self, button)
	local unit = SecureButton_GetModifiedAttribute(self, "unit", button);
	if unit then
		local unitsuffix = SecureButton_GetModifiedAttribute(self, "unitsuffix", button);
		if unitsuffix then
			unit = unit .. unitsuffix;
			local pt = _pettbl[unit]; if pt then return pt; end
		end
		return unit;
	end
end

-- debug
--local tii = 1;
--local frame = CreateFrame('Frame')
--frame:RegisterAllEvents()
--frame:SetScript('OnEvent',
--    function(self, event, ...)
--    	RDXSession[tii] = event;
--    	tii = tii + 1;
--    end
--)

