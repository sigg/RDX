-- HOT.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
-- 
-- HOT is Higher-Order Targeting, the ability to track units via their "target" unit tags.
--
-- Terminology:
--
-- A pretarget of unit X is any unit Y in the group for which Y target^(n) = X for 
-- some n.
--
-- The prototarget is the pretarget at the beginning of the chain.

HOT = RegisterVFLModule({
	name = "HOT";
	description = "Higher Order Targeting module for RDX";
	parent = RDX;
});


-- Perf: default delay between traces.
local traceDelay = 0.2;

------------------------------------------------------
-- Trace condition builder for common conditions.
------------------------------------------------------
function HOT.NewTraceCondition()
	local x = VFL.Snippet:new();
	x:AppendCode([[return function(proto_uid)
]]);
	return x;
end

function HOT.TraceUnitSuffix(cond, sfx)
	cond:AppendCode([[local uid = proto_uid .. ]] .. string.format('%q', sfx) .. [[;
if not UnitExists(uid) then return nil; end
]]);
end

function HOT.TraceName(cond, name)
	cond:AppendCode([[if UnitName(uid) ~= ]] .. string.format('%q', name) .. [[ then return nil; end
]]);
end

function HOT.TraceRaidTargetIcon(cond, icon)
	cond:AppendCode([[if GetRaidTargetIndex(uid) ~= ]] .. icon .. [[ then return nil; end
]]);
end

function HOT.TraceLevel(cond, level)
	cond:AppendCode([[if UnitLevel(uid) ~= ]] .. level .. [[ then return nil; end
]]);
end

function HOT.TraceSex(cond, sex)
	cond:AppendCode([[if UnitSex(uid) ~= ]] .. sex .. [[ then return nil; end
]]);
end

function HOT.BuildTraceFunction(cond)
	cond:AppendCode([[
return proto_uid, uid;
end
]]);
	local f,err = loadstring(cond:GetCode());
	if not f then error(VFLI.i18n("BuildTraceFunction: ") .. err); end
	return f();
end

-------------------------------------------------------------
-- A Tracer tracks a single pattern.
-------------------------------------------------------------
HOT.Tracer = {};
HOT.Tracer.__index = HOT.Tracer;

--- Create a new tracer for the given dataset
function HOT.Tracer:new(traceFunc)
	if not traceFunc then return nil; end
	local self = {};
	setmetatable(self, HOT.Tracer);
	
	--------- STATE
	self.test = traceFunc; -- The test
	self.distinct = true; -- Show only distinct mobs matching the filter, or all mobs?
	self.n = 0; -- The number of acquired traces
	self.lostTime = 0; -- The time the signal was last lost.
	self.proto_uids = {}; -- The uids of all units that tripped the trace.
	self.uids = {}; -- The uids of all the target units.
	--------- SIGNALS
	self.sigAcq = VFL.Signal:new(); -- Signal on acquire
	self.sigTrace = VFL.Signal:new(); -- Signal each trace tick
	self.sigLost = VFL.Signal:new(); -- Signal on loss

	return self;
end

-- Execute this tracer
function HOT.Tracer:Execute()
	-- Metadata
	local uids, proto_uids, distinct, test = self.uids, self.proto_uids, self.distinct, self.test;
	VFL.empty(uids); VFL.empty(proto_uids);

	-- Local data
	local proto_uid, uid, ix, flag = nil, nil, 0, nil;

	---------------------- SCAN
	for _,unit in RDXDAL.Group() do	
		-- Get unit and test it
		proto_uid = unit.uid;
		proto_uid, uid = test(proto_uid);
		-- If it passed...
		if proto_uid then
			flag = true;
			-- Uniqueness test: if UnitIsUnit(uid, prev_uids) it's not unique!
			if distinct then
				for j=1,ix do
					if UnitIsUnit(uid, uids[j]) then flag = nil; break; end
				end
			end
			-- If all tests passed, add it
			if flag then
				ix = ix + 1;
				self.proto_uids[ix] = proto_uid;
				self.uids[ix] = uid;
			end
		end
	end

	--------------------- POSTSCAN
	-- Postprocessing: flip signals
	if(ix > 0) then
		if(self.n == 0) then
			self.n = ix;
			self.sigAcq:Raise(self);
		end
		self.n = ix;
		self.sigTrace:Raise(self);
		return true;
	else
		if(self.n > 0) then
			self.n = 0; self.lostTime = GetTime();
			self.sigLost:Raise(self);
		end
		return nil;
	end
end

----------------------------------
-- Accessors
----------------------------------
function HOT.Tracer:ProtoUIDs() return self.proto_uids; end
function HOT.Tracer:UIDs() return self.uids; end
function HOT.Tracer:NumMatches() return self.n; end
function HOT.Tracer:First() return self.uids[1]; end
function HOT.Tracer:FirstProto() return self.proto_uids[1]; end


-----------------------------------
-- Signal binders
-----------------------------------
function HOT.Tracer:OnAcquire(func)
	self.sigAcq:Connect(nil, func);
end
function HOT.Tracer:OnTrace(func)
	self.sigTrace:Connect(nil, func);
end
function HOT.Tracer:OnLost(func)
	self.sigLost:Connect(nil, func);
end

-----------------------------------
-- Registration
-----------------------------------
--- Register this tracer to be continually monitored by the system.
function HOT.Tracer:Open()
	self.Open = VFL.Noop; -- make sure it doesn't open twice
	VFLT.AdaptiveSchedule2(self, traceDelay, self.Execute, self);
end

--- Close a tracer previously Opened.
function HOT.Tracer:Close()
	VFLT.AdaptiveUnschedule2(self);
	self.sigAcq:DisconnectAll();
	self.sigTrace:DisconnectAll();
	self.sigLost:DisconnectAll();
end

---------------------------------
-- Highlevel API
---------------------------------
--- Returns a Tracer object tracking the given NPC by name.
function HOT.TrackTarget(name)
	local cond = HOT.NewTraceCondition();
	HOT.TraceUnitSuffix(cond, "target");
	HOT.TraceName(cond, name);
	return HOT.Tracer:new(HOT.BuildTraceFunction(cond));
end

--- Returns a Tracer object tracking the given NPC by raid icon
-- number.
function HOT.TrackRaidIcon(number)
	local cond = HOT.NewTraceCondition();
	HOT.TraceUnitSuffix(cond, "target");
	HOT.TraceRaidTargetIcon(cond, number);
	return HOT.Tracer:new(HOT.BuildTraceFunction(cond));
end

--- Automatically start/stop the encounter based on the results of the
-- given tracer.
function RDX.AutoStartStopEncounter(tracer)
	tracer:OnTrace(function(tr)
		if RDX.EncounterIsRunning() then
			if UnitIsDead(tr:First()) then
				RDX.StopEncounter();
			end
		else
			if UnitIsFriend(tr:First() .. "target", "player") then
				RDX.StartEncounter();
			end
		end
	end);
end

function RDX.AutoStartEncounter(tracer)
	tracer:OnTrace(function(tr)
		if not RDX.EncounterIsRunning() then
			if UnitIsFriend(tr:First() .. "target", "player") then
				RDX.StartEncounter();
			end
		end
	end);
end

--- Automatically update the encounter pane when the given tracer updates.
function RDX.AutoUpdateEncounterPane(tracer, lockedName)
	local name, fh = "", 1;
	tracer:OnTrace(function(tr)
		local uid = tr:First();
		local h, hm = UnitHealth(uid), UnitHealthMax(uid); if hm < 1 then hm = 1; end
		fh = VFL.clamp(h/hm, 0, 1); name = lockedName or UnitName(uid);
		RDX.GetEncounterPane():SetInfoBundle(name, string.format("%0.0f%%", fh*100), fh, _red, _green);
	end);
	tracer:OnLost(function(tr)
		RDX.GetEncounterPane():SetInfoBundle(name, string.format("%0.0f%%", fh*100), fh, _cyan, _cyan);
	end);
end

