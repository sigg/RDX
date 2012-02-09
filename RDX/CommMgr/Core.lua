-- Core.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Core dependencies that the whole RPC system relies on.

-----------------------------------
-- CORE OBJECTS
-----------------------------------

RPC = RegisterVFLModule({
	name = "RPC";
	description = "RDX Remote Procedure Call";
	parent = RDX;
});

Traffic = RegisterVFLModule({
	name = "Traffic";
	description = "RDX chat traffic";
	parent = RDX;
});

RPCEvents = DispatchTable:new();
RPCEvents.name = "RPCEvents";

---------------------------------------------------------------------------------------
-- CONFERENCE DATABASE
---------------------------------------------------------------------------------------
local confs = {};
local confsByID = {};

-- Run periodic maintenance on conferences
local function _ConfMaintenance()
	local t = GetTime();
	local found = nil;
	-- Dead conference maintenance
	for conf,_ in pairs(confs) do
		if conf.purgeTime then found = true; end
		if (conf.purgeTime) and (t > conf.purgeTime) then
			conf:Shutdown();
			RPC.UnregisterConference(conf);
		end
	end
	if not found then
		-- there is no more conf with timeout, we can stop the schedule of the _ConfMaintenance
		VFLT.AdaptiveUnschedule("confMaintenance");
	end
end

function RPC.RegisterConference(conf, id, timeout)
	if (not conf) then error(VFLI.i18n("Attempt to register nil conference")); end
	if (not id) then error(VFLI.i18n("id is required")); end
	if timeout then
		conf.purgeTime = GetTime() + timeout;
		-- a conf with timeout is set, let schedule the _ConfMaintenance
		VFLT.AdaptiveUnschedule("confMaintenance");
		VFLT.AdaptiveSchedule("confMaintenance", 30, _ConfMaintenance);
	else
		conf.purgeTime = nil;
	end
	confs[conf] = true;
	conf.id = id;
	confsByID[id] = conf;
end

function RPC.UnregisterConference(conf)
	confs[conf] = nil;
	confsByID[conf.id] = nil;
end

function RPC.GetConferenceByID(id)
	if not id then return nil; end
	return confsByID[id];
end

function RPC.Conferences() return confsByID; end

---------------------------------------
-- The global RPC bindings table
---------------------------------------
local gbinds = {};
gbinds.__index = gbinds;
RPC._globalBinds = gbinds;

-- Bind an RPC routine to a local function.
function RPC.GlobalBind(routine, fn)
	if (not routine) or (gbinds[routine]) then return nil; end
	gbinds[routine] = fn; return true;
end

-- Unbind a sheaf of routines matching the given regular expression.
function RPC.GlobalUnbindPattern(regex)
	if not regex then return; end
	for k,_ in pairs(gbinds) do
		if string.find(k, regex) then
			gbinds[k] = nil;
		end
	end
end

--- COMPAT: Compatibility with RDX5's RPC.Bind
RPC.Bind = RPC.GlobalBind;

--- COMPAT: compatibility with RDX5's RPC.UnbindPattern
RPC.UnbindPattern = RPC.GlobalUnbindPattern;
