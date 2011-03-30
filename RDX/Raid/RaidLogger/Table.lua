-- Table.lua
-- RDX - Project Omniscience
-- (C)2006 Bill Johnson
--
-- The Omniscience data classes.

local copyInto = VFL.copyInto;

----------------------------------
-- @class Omni.Session
-- An Omniscience session.
----------------------------------
Omni.Session = {};
Omni.Session.__index = Omni.Session;

local sessions = {};

--- Find the Omniscience session with the given name.
function Omni.GetSessionByName(name)
	for k,v in pairs(sessions) do
		if (v.name == name) then return v,k; end
	end
	return nil;
end

--- Return a list of all sessions.
function Omni.Sessions()
	return sessions;
end

--- Remove an Omniscience session by name.
function Omni.RemoveSessionByName(name)
	local sess, q = Omni.GetSessionByName(name);
	if sess and (sess:Close()) then
		table.remove(sessions, q);
		OmniEvents:Dispatch("SESSION_DELETED", sess.name);
		return true;
	else
		return nil;
	end
end

--- Create a new Omniscience session.
function Omni.Session:new(name)
	-- No overwriting preexisting sessions
	if sessions[name] then return nil; end
	-- Make the session.
	local self = {};
	self.name = name; self.tablespace = {};
	setmetatable(self, Omni.Session);
	-- Register it in the global table.
	table.insert(sessions, self);
	OmniEvents:Dispatch("SESSION_CREATED", self);
	return self;
end

--- Adds a table to this session's tablespace.
function Omni.Session:AddTable(tbl, number)
	-- Check for a table on this session with the same name.
	-- Rename to avoid conflict if so.
	local name = tbl.name;
	if number then name = name .. " (" .. number .. ")"; else number = 1; end
	if self:FindTable(name) then return self:AddTable(tbl, number+1); end
	-- Add the table.
	tbl.name = name;
	table.insert(self.tablespace, tbl);
	tbl.session = self;
	OmniEvents:Dispatch("SESSION_TABLE_ADDED", self, tbl);
	return true;
end

--- Rename a table on this session.
function Omni.Session:RenameTable(tbl, newName)
	-- See if the desired table is in this tablespace...
	local k = VFL.vfind(self.tablespace, tbl);
	if not k then return nil; end
	-- If the table is immutable, nogo
	if tbl:IsImmutable() then return nil; end
	-- Determine if the new name is taken...
	if self:FindTable(newName) then return nil; end
	-- Rename it
	tbl.name = newName;
	OmniEvents:Dispatch("SESSION_TABLE_RENAMED", self, tbl);
end

--- Remove a table from this session's tablespace by index
function Omni.Session:RemoveTableByIndex(idx)
	local t = table.remove(self.tablespace, idx);
	OmniEvents:Dispatch("SESSION_TABLE_DELETED", self, t.name);
	return t;
end

--- Remove a table from this session's tablespace by pointer.
function Omni.Session:RemoveTable(tbl)
	local k = VFL.vfind(self.tablespace, tbl);
	if not k then return nil; end
	local t = table.remove(self.tablespace, k);
	OmniEvents:Dispatch("SESSION_TABLE_DELETED", self, t.name);
	return t;
end

--- Get a table from this session by name
-- @return table,index where table is the desired table and index is its numerical index. NIL if not found.
function Omni.Session:FindTable(name)
	for k,v in pairs(self.tablespace) do
		if (v.name == name) then return v,k; end
	end
	return nil;
end

--- Get this session's tablespace.
function Omni.Session:Tablespace()
	return self.tablespace;
end

--- Determine if the session is a local session (no unsynchronized tables)
function Omni.Session:IsLocal()
	return self.isLocal;
end

--- Close down a session.
function Omni.Session:Close()
	-- Can't close a local session.
	if self:IsLocal() then return nil; end
	-- Destroy the tablespace
	self.tablespace = nil;
	-- TODO: RPC broadcast close message.
	self.name = nil;
	return true;
end

--- Clear a session.
function Omni.Session:Clear()
	-- Can only clear local sessions.
	if not self:IsLocal() then return nil; end
	-- Delete all non-immutable tables
	local nts = {};
	for k,v in pairs(self.tablespace) do
		if v:IsImmutable() then table.insert(nts, v); end
	end
	-- Rebuild the tablespace.
	for i=1,table.getn(self.tablespace) do
		if nts[i] then self.tablespace[i] = nts[i]; else self.tablespace[i] = nil; end
	end
	return true;
end

-- "Cleanse" a session.
-- This operation makes sure everything that should be a number is tonumber()'d.
function Omni.Session:Cleanse()
	for _,table in pairs(self:Tablespace()) do
		table:Cleanse();
	end
end

-- Rename a table.
function Omni.RenameTable(tbl, newName)
	return tbl.session:RenameTable(tbl, newName);
end

-- Create the local session.
--local localSess = Omni.Session:new("Local");
--localSess.isLocal = true;

----------------------------------
-- @class Omni.Table
-- An Omniscience table.
-- Data format is:
--
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
----------------------------------
-- Source/Target finding functions
local RowHasActors = Omni.RowHasActors;
local RowActorIsSource = Omni.RowActorIsSource;
local RowActorIsTarget = Omni.RowActorIsTarget;
--[[
local GetRowSourceFunc_Local = function(tbl, row) 
	if RowHasActors(row.y) then
		if RowActorIsSource(row.y) then
			return row.c;
		else
			return tbl.source;
		end
	end
end
local GetRowTargetFunc_Local = function(tbl, row)
	if RowHasActors(row.y) then
		if RowActorIsTarget(row.y) then
			return row.c;
		else
			return tbl.source;
		end
	end
end]]
--[[
local GetRowSourceFunc_Local = function(tbl, row) 
	if RowHasActors(row.y) then
		if RowActorIsSource(row.y) then
			return row.r;
		else
			return row.s;
		end
	end
end
local GetRowTargetFunc_Local = function(tbl, row)
	if RowHasActors(row.y) then
		if RowActorIsTarget(row.y) then
			return row.r;
		else
			return row.s;
		end
	end
end

local GetRowSourceFunc_Remote = function(tbl, row) return row.s; end
local GetRowTargetFunc_Remote = function(tbl, row) return row.t; end
]]
Omni.Table = {};
Omni.Table.__index = Omni.Table;
function Omni.Table:new(name)
	local self = {};
	setmetatable(self, Omni.Table);
	if name then self.name = name; else self.name = "(anonymous)"; end
	self.source = "Unknown";
	self:SetFormat("LOCAL"); self.open = nil;
	self.timeOffset = 0; self.displayTime = "ABSOLUTE";
	return self;
end

function Omni.Table:Destroy()
	self.name = nil; self.source = nil;
	self.open = nil; self.timeOffset = nil; 
	self.displayTime = nil; self.format = nil;
	self.immutable = nil; self.session = nil;
	VFL.empty(self.data); self.data = nil;
end

--- Get the size of this table
function Omni.Table:Size()
	if not self.data then return 0; else return #(self.data); end
end

--- Set the "open status" for this table.
function Omni.Table:SetOpen(flag)
	self.open = flag;
	OmniEvents:Dispatch("SESSION_TABLE_ALTERED", self.session, self);
end

--- Is this table suitable for reading data from?
function Omni.Table:IsReadable()
	return (not self.open);
end

--- Set the format for this table
function Omni.Table:SetFormat(fmt)
	self.format = fmt;
	--if(fmt == "LOCAL") then
	--	self.GetRowSource = GetRowSourceFunc_Local;
	--	self.GetRowTarget = GetRowTargetFunc_Local;
	--elseif(fmt == "REMOTE") then
	--	self.GetRowSource = GetRowSourceFunc_Remote;
	--	self.GetRowTarget = GetRowTargetFunc_Remote;
	--else
		self.GetRowSource = VFL.Noop; 
		self.GetRowTarget = VFL.Noop;
	--end
end

--- Check immutability for this table.
-- @return TRUE iff this table is immutable.
function Omni.Table:IsImmutable()
	return self.immutable;
end

--- Check if this table is in local format.
-- @return TRUE iff this table is in local format.
function Omni.Table:IsLocal()
	return (self.format == "LOCAL");
end
function Omni.Table:IsLogTable()
	return (self.format == "LOCAL" or self.format == "REMOTE");
end

--- Get the data from this table.
function Omni.Table:GetData()
	return self.data;
end
function Omni.Table:GetRow(n)
	if not n then return nil; end
	return self.data[n];
end

--- Sets this table's metadata equal to the metadata of the other table.
function Omni.Table:SetMetadataFrom(t)
	self.timeOffset = t.timeOffset;
	self.displayTime = t.displayTime;
	self.session = t.session;
	self:SetFormat(t.format);
	self.source = t.source;
	self.open = t.open;
	self.mark = nil;
end

--- Make a table that's a copy of this table.
function Omni.Table:MakeCopy()
	local ret = Omni.Table:new(self.name);
	ret:SetMetadataFrom(self); ret.immutable = nil;
	ret.data = VFL.copy(self.data);
	return ret;
end

-- "Cleanse" the data of a table, making sure everything that should be a number is
function Omni.Table:Cleanse()
	if not self.data then return; end
	for _,row in ipairs(self.data) do
		if row.tm then row.tm = tonumber(row.tm); end
		if row.x then	row.x = tonumber(row.x); end
		if row.y then row.y = tonumber(row.y); end
		if row.e then row.e = tonumber(row.e); end
		if row.d then row.d = tonumber(row.d); end
	end
end

--- Crop a range of rows from this table.
function Omni.Table:Crop(r1, r2, name)
	local c, d = nil, self.data;
	if(r1 > r2) then c = r2; r2 = r1; r1 = c; end
	if (not d[r1]) or (not d[r2]) then return nil; end

	if not name then name = self.name .. "[" .. r1 .. "," .. r2 .."]"; end

	local ret = Omni.Table:new(name);
	ret:SetMetadataFrom(self);
	ret.immutable = nil;
	local newData = {};
	for i=r1,r2 do
		table.insert(newData, VFL.copy(d[i]));
	end
	ret.data = newData;

	return ret;
end

--- Timeshift this table.
function Omni.Table:Timeshift(dt)
	if self:IsImmutable() then return nil; end
	self.timeOffset = self.timeOffset - dt;
	for _,row in ipairs(self.data) do row.tm = row.tm + dt; end
	return true;
end

--- Get the true time from a row of this table.
function Omni.Table:GetRowTime(row)
	if row.tm then
		return self.timeOffset + row.tm;
	else
		return nil;
	end
end

--- Filter this table through a filter function.
function Omni.Table:Filter(func)
	local d, dOut, curRow = self.data, {}, nil;
	local n = table.getn(d);
	
	-- Perform filtration
	for i=1,n do
		curRow = d[i];
		if func(self, curRow) then table.insert(dOut, VFL.copy(curRow)); end
	end

	local ret = Omni.Table:new("filter " .. self.name);
	ret:SetMetadataFrom(self); ret.immutable = nil;
	ret.data = dOut;
	return ret;
end

-- The local log table.
--local tblLocalLog = Omni.Table:new("Log");
--tblLocalLog.immutable = true;
--tblLocalLog.displayTime = "ABSOLUTE";
--tblLocalLog.source = UnitName("player");
--tblLocalLog.data = Omni.GetLog();
--tblLocalLog.timeOffset = 0;

--localSess:AddTable(tblLocalLog);

--local tblLocalLogAll = Omni.Table:new("LogAll");
--tblLocalLogAll.immutable = true;
--tblLocalLogAll.displayTime = "ABSOLUTE";
--tblLocalLogAll.source = UnitName("player");
--tblLocalLogAll.data = Omni.GetLogAll();
--tblLocalLogAll.timeOffset = 0;

--localSess:AddTable(tblLocalLogAll);

--VFLEvents:Bind("SYSTEM_EPOCH_ESTABLISHED", nil, function(syse)
	--tblLocalLog.timeOffset = math.modf(syse:GetKernelTimeCorrection() * 10);
	--tblLocalLogAll.timeOffset = math.modf(syse:GetKernelTimeCorrection() * 10);
	--VFLEvents:Unbind("omni_init");
--end, "omni_init");

--Omni.localLog = tblLocalLog;
--Omni.localLogAll = tblLocalLogAll;

--- Compress a table's data, returning a symbol lookup table and a new compressed data table.
-- @return symtab, cdata where symtab is the symbol table used for decompression and cdata is the compressed data. NIL on failure.
function Omni.CompressData(tbl)
	local d = tbl.data;
	if not d then return nil; end
	
	local symtab, symid, cdata, crow = {}, 0, {}, nil;
	local function gensym(txt)
		if not txt then return nil; end
		if symtab[txt] then
			return symtab[txt];
		else
			symid = symid + 1;
			symtab[txt] = symid;
			return symid;
		end
	end
	
	for _,row in ipairs(d) do
		crow = {};
		copyInto(crow, row);
		-- Generate symbols for common columns
		crow.c = gensym(row.c); crow.a = gensym(row.a);
		-- Copy longnamed columns
		crow._a = row.absorbed; crow._b = row.blocked; crow._r = row.resisted;
		crow.absorbed = nil; crow.blocked = nil; crow.resisted = nil;
		table.insert(cdata, crow);
	end
	return VFL.invert(symtab), cdata;
end

--- Given a symtab and cdata as returned by Omni.CompressData, decompress a table IN PLACE.
-- @return data The decompressed table data.
function Omni.DecompressData(symtab, cdata)
	local drow = nil;
	local function ungensym(sym)
		if not sym then return nil; else return symtab[sym]; end
	end
	for _,row in ipairs(cdata) do
		row.absorbed = row._a; row._a = nil;
		row.blocked = row._b; row._b = nil;
		row.resisted = row._r; row._r = nil;
		row.c = ungensym(row.c); row.a = ungensym(row.a);
	end
	return cdata;
end

