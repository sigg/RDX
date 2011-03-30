-- NominativeSet.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--

local MAX_UNITS = RDXDAL.NUM_UNITS;
local GetUnitByName = RDXDAL.GetUnitByNameIfInGroup;
local GetUnitByNumber = RDXDAL.GetUnitByNumber;

-- A Nominative Set is a set of units called explicitly by name. Iterating over a
-- NominativeSet gives those of the named units who are currently in the raid group 
-- in no particular order. The value of an entry in a NominativeSet is its linear
-- position in the list used to populate the set.
RDXDAL.NominativeSet = {};

function RDXDAL.NominativeSet:new()
	local self = RDXDAL.Set:new();

	-- "Names Changed" signal will be broadcast every time the underlying name list
	-- changes.
	self.SigNamesChanged = VFL.Signal:new();

	local name2pos, hopos = {}, 0;

	--- Bootstrap a NominativeSet from a list of names.
	function self:SetNameList(list)
		if not list then return; end
		-- Rebuild the name2pos map
		VFL.empty(name2pos);
		local i = 0;
		for number,name in ipairs(list) do
			name2pos[name] = number; i = number;
		end
		hopos = i;
		-- Rebuild the set
		RDXDAL.BeginEventBatch();
		self:_Clear();
		if(self:IsOpen()) then self:_Sweep(); end
		RDXDAL.EndEventBatch();
		-- Fire signals
		self.SigNamesChanged:Raise(self);
	end

	--- Clear this set.
	function self:ClearNames()
		VFL.empty(name2pos); hopos = 0;
		self:_Clear();
		self.SigNamesChanged:Raise(self);
	end

	--- Remove a name from this set.
	-- Returns TRUE iff a name was actually removed, NIL otherwise;
	function self:RemoveName(n)
		if name2pos[n] then
			name2pos[n] = nil;
			local u = GetUnitByName(n);
			if u then	self:_Set(u.nid, false); end
			self.SigNamesChanged:Raise(self);
			return true;
		end
		return nil;
	end

	--- Add a name to this set.
	-- Returns TRUE iff a name was actually added, NIL otherwise;
	function self:AddName(n)
		if not name2pos[n] then
			hopos = hopos + 1;
			name2pos[n] = hopos;
			local u = GetUnitByName(n);
			if u then	self:_Set(u.nid, hopos); end
			self.SigNamesChanged:Raise(self);
			return true;
		end
		return nil;
	end

	--- Check if a name is in this set
	function self:CheckName(n)
		if not n then return nil; end
		return name2pos[n];
	end

	--- Get the list of names from this set.
	function self:GetNames()
		return name2pos;
	end

	--- Get the names from this set as an array.
	function self:GetNameArray()
		local ret = {};
		local pos2name = VFL.invert(name2pos); -- better way to do this without a temp. table?
		for i=1,hopos do
			if pos2name[i] then table.insert(ret, pos2name[i]); end
		end
		return ret;
	end

	--- Get the names as a comma separated list suitable for use with raid state headers.
	function self:GetHeaderList()
		local str = "";
		for name,_ in pairs(name2pos) do
			str = str .. VFL.capitalize(name) .. ",";
		end
		return str;
	end

	-- Update the underlying NID set.
	function self:_Sweep()
		RDXDAL.BeginEventBatch();
		local u = nil;
		for i=1,40 do -- NOTE: players only in nominative sets.
			u = GetUnitByNumber(i);
			if u:IsValid() and name2pos[u.name] then
				self:_Set(i, name2pos[u.name]);
			else
				self:_Set(i, false);
			end
		end
		RDXDAL.EndEventBatch();
	end

	-- On activate/deactivate, bind/unbind us to DISRUPT_SETS
	function self:_OnActivate()
		RDXEvents:Bind("DISRUPT_SETS", self, self._Sweep, self);
		self:_Sweep();
	end
	function self:_OnDeactivate()
		RDXEvents:Unbind(self);
	end

	return self;
end

