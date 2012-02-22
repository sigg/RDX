--- Time.lua
-- @author (C)2006 Bill Johnson and The VFL Project

VFLT = RegisterVFLModule({
	name = "VFLT";
	description = "Timer";
	parent = VFL;
});

-- Localize functions to prevent table lookups
local mathdotfloor = math.floor;
local mathdotmodf = math.modf;
local blizzGetTime = GetTime;
local tempty, tinsert, tremove, tsort = VFL.empty, table.insert, table.remove, table.sort;
local strmatch = string.match;
local strformat = string.format;

--- Gets the kernel time with 1/10th second precision.
-- @return The kernel time in tenths-of-a-second.
function VFLT.GetTimeTenths()
	return mathdotmodf(blizzGetTime()*10);
end

----------------------------------------------------------------------------------------------
-- ADAPTIVE SCHEDULER
----------------------------------------------------------------------------------------------
VFLP.RegisterCategory("VFL Time");

local aix, dilation, idilation = 1, 1, 1;
local ads = {};

--- Adaptive-schedule a recurring process.
-- @description The adaptive scheduler is a system designed to improve the performance impact
-- of frequently-recurring (subsecond precison) tasks.
-- It works by assigning tasks to "slots" within the 1-second interval, then sweeping
-- over those slots and running the tasks. Each task receives a random offset that ensures
-- it does not collide with other tasks. It also reduces overhead by not "thrashing" schedule entries.
-- Moreover, when FPS drops below a user definable number, the adaptive staggered scheduler
-- automatically "dilates" the schedule to slow everything down.
-- @param id An ID that can be later used to stop this schedule
-- @param interval The interval of time of recurring process (min 0.02)
-- @param func The function to call
-- @param ... arg to pass to func
function VFLT.AdaptiveSchedule(id, interval, func, ...)
	if(not interval) or (interval <= 0.02) then
		error("VFLT.AdaptiveSchedule: Must provide an interval larger than 0.2 seconds.");
	end
	if not func then
		error("VFLT.AdaptiveSchedule: Must provide a function to schedule.");
	end
	local t = GetTime() + math.random(0, math.floor(interval*100))/100;
	local stbl = {
		id = id;
		interval = interval;
		x = 0;
		func = func;
		start = t;
		last = t;
	};
	for i=1,select("#",...) do stbl[i] = select(i,...); end
	table.insert(ads, stbl);
	return stbl;
end

--- Change the dilation of the adaptive scheduler
-- @param d the time of the dilation
function VFLT.SetScheduleDilation(d)
	if(not d) or (d < 0.1) then error("invalid dilation"); end
	dilation = d; idilation = 1/d;
end

--- Unschedule by ID from the adaptive scheduler
-- @param id An ID used in VFLT.AdaptiveSchedule
function VFLT.AdaptiveUnschedule(id)
	VFL.filterInPlace(ads, function(x)
		return x.id ~= id;
	end);
end

-- The internals of the adaptive scheduler
local tas, target_timescale;
local function _AS(self, elapsed)
	tas = GetTime();
	for i,entry in ipairs(ads) do
		-- Target timescale is the number of times this function SHOULD have run.
		target_timescale = mathdotfloor( (tas - entry.start) / (entry.interval * dilation) );
		if( (entry.x * idilation) < target_timescale ) then
			--entry.func(unpack(entry), (tas - entry.last));
			entry.func();
			entry.x = (target_timescale + .0001) * dilation;
			entry.last = tas;
		end
	end
end
local asframe = CreateFrame("Frame");
--asframe:SetScript("OnUpdate", _AS);
VFLP.RegisterFunc("VFL Time", "Adaptive", _AS);

function VFLT.GetAdaptiveSize()
	VFL.print(#ads);
	for i,entry in ipairs(ads) do
		if entry.id then
			VFL.print(entry.id .. " " .. entry.interval);
		else
			VFL.print("nil " .. entry.interval);
		end
	end
end
-- /script VFLT.GetAdaptiveSize();

local ads2 = {};

function VFLT.AdaptiveSchedule2(id, interval, func)
	if not id then VFL.print("id is null"); return; end
	if ads2[id] then VFL.print("id already exist"); return; end
	local asframe = VFLUI.AcquireFrame("Frame");
	asframe.elapsed = 0;
	function asframe.as(self, elapsed)
		self.elapsed = self.elapsed + elapsed
		if self.elapsed > interval then
			func();
			self.elapsed = 0;
		end
	end
	asframe:SetScript("OnUpdate", asframe.as);
	VFLP.RegisterFunc("VFL Time", id, asframe.as);
	ads2[id] = asframe;
end

function VFLT.AdaptiveUnschedule2(id)
	local asframe = ads2[id];
	if not asframe then return; end
	VFLP.UnregisterObject(asframe.as);
	asframe:SetScript("OnUpdate", nil);
	asframe.as = nil;
	asframe.elapsed = nil;
	asframe:Destroy();
	ads2[id] = nil;
end

function VFLT.GetAdaptiveSize2()
	VFL.print(VFL.tsize(ads2));
	for id,as in pairs(ads2) do
		VFL.print(id);
	end
end
-- /script VFLT.GetAdaptiveSize2();

-----------------------------------------------------------------
-- ZERO-MEMORY SCHEDULER
-----------------------------------------------------------------
local zmt, zfunq = {}, {};

--- Schedule func to be executed dt seconds from now.
-- @description The zero-memory scheduler is an alternative scheduling implementation
-- for "one-off" scheduling tasks.
-- It allocates zero tables and one table entry at schedule time, using
-- nearly no memory and performing very little work. However, its cycle
-- time is linear in the size of the schedule table. Moreover, entities
-- scheduled with ZMSchedule can only be directly unscheduled by handle,
-- creating the need for an API layer on top of ZMSchedule for more
-- complex cases.
-- @param dt The period of time
-- @param func The Function to be executed
-- @return a handle for later descheduling.
function VFLT.ZMSchedule(dt, func)
	local tt, i = mathdotfloor((GetTime() + dt) * 1000), 0;
	while zmt[tt+i] do i=i+1; end
	zmt[tt+i] = func;
	return tt+i;
end

--- Unschedule a function scheduled by ZMSchedule. 
-- @param handle the return value from ZMSchedule as the handle.
function VFLT.ZMUnschedule(handle)
	zmt[handle] = nil;
end

-- The internals of the ZM scheduler.
local tzm, izm;
local function _ZM()
	tzm, izm = mathdotfloor(GetTime() * 1000), 0;
	-- Need to separate descheduling from execution due to Lua's
	-- fail-on-insert iterators. First build up a queue (using
	-- a preallocated array, no temp tables!)
	for st,func in pairs(zmt) do
		if(tzm > st) then
			izm=izm+1; zfunq[izm] = func;
			zmt[st] = nil;
		end
	end
	-- Now run the queue, emptying it as we go.
	for j=1,izm do
		zfunq[j](); zfunq[j] = nil;
	end
end
local zmframe = CreateFrame("Frame");
zmframe:SetScript("OnUpdate", _ZM);
VFLP.RegisterFunc("VFL Time", "ZM", _ZM, true);

function zmtest(n)
	for i=1,n do
		local qq=i;
		VFLT.ZMSchedule(5, function() VFL.print("ZMSchedule " .. qq); end);
	end
end

-----------------------------------------------------------------
-- NEXT-FRAME SCHEDULER
-----------------------------------------------------------------
local nfFrame, nfFunc, nfq = {}, {}, {};
local frameCounter = 0;

local inf;
local function _NF()
	frameCounter = frameCounter + 1;
	inf = 0;
	for k,v in pairs(nfFrame) do
		if v <= frameCounter then
			inf = inf + 1; nfq[inf] = nfFunc[k];
			nfFrame[k] = nil; nfFunc[k] = nil;
		end
	end
	for j=1,inf do nfq[j](); nfq[j] = nil; end
end
local NFFrame = CreateFrame("Frame");
NFFrame:SetScript("OnUpdate", _NF);
VFLP.RegisterFunc("VFL Time", "NextFrame", _NF, true);

--- Schedule something to happen on the next frame.
-- @param id To identify this task, most of time this is a random number math.random(10000000)
-- @param func The Function to be executed
function VFLT.NextFrame(id, func)
	if nfFrame[id] then return; end
	nfFrame[id] = frameCounter + 1;
	nfFunc[id] = func;
end

--- Get the number of task to be executed in the next frame.
function VFL.GetFrameCounter() return frameCounter; end

-----------------------------------------------------------------
-- STANDARD SCHEDULER
-----------------------------------------------------------------
-- The schedule table
local sched, schedx = {}, {};
local function timeSort(x1,x2) return x1.t > x2.t; end

-- The schedule executive
local nsc, m0sc, m1sc, tsc, xsc, zsc;
local function Sched()
	-- Indices
	nsc, m0sc, m1sc, tsc = #sched, 0, (#schedx + 1), GetTime();
	-- Start at the beginning
	xsc, zsc = sched[nsc], nil;
	-- For each scheduled object that's past-due
	while (xsc and xsc.t <= tsc) do
		-- We want to move it to the execution queue at spot "m0".
		-- If there's something already there, move it to spot "m1".
		m0sc = m0sc + 1; zsc = schedx[m0sc]; schedx[m0sc] = xsc;
		if zsc then schedx[m1sc] = zsc; m1sc = m1sc + 1; end
		-- Remove it from the schedule
		sched[nsc] = nil;
		-- Move on
		nsc=nsc-1; xsc = sched[nsc];
	end
	-- For every object added to the execution queue
	for i=1,m0sc do
		-- Retrieve and execute
		xsc = schedx[i]; 
		if xsc.func then xsc.func(unpack(xsc)); end
		-- Recycle it
		tempty(xsc);
	end
end
local schedframe = CreateFrame("Frame");
schedframe:SetScript("OnUpdate", Sched);
VFLP.RegisterFunc("VFL Time", "Scheduler", Sched, true);

-- The schedule allocator.
-- We look at the last object in the execution queue. If it's empty
-- we reuse, otherwise create.
local function SchedAlloc()
	local n = #schedx;
	local ret = schedx[n];
	if ret and (not ret.t) then
		schedx[n] = nil; return ret;
	else
		return {};
	end
end

--- Schedule a function to be executed dt sec in the future.
-- @param dt The period of time
-- @param func The Function to be executed
-- @param ... parameter to pass to the function
function VFLT.schedule(dt, func, ...)
	local x = SchedAlloc();
	x.func = func; x.t = GetTime() + dt;
	for i=1,select("#", ...) do	x[i] = select(i, ...); end
	tinsert(sched, x);
	tsort(sched, timeSort);
	return x;
end

--- Schedule a function to be executed dt sec in the future.
-- Associates a name with the scheduled event that allows it to be
-- revoked.
-- @param name The identifier
-- @param dt The period of time
-- @param func The Function to be executed
-- @param ... parameter to pass to the function
-- @return a scheduled entry.
function VFLT.scheduleNamed(name, dt, func, ...)
	local x = SchedAlloc();
	x.name = name; x.func = func; x.t = GetTime() + dt;
	for i=1,select("#", ...) do	x[i] = select(i, ...); end
	tinsert(sched, x); 
	tsort(sched, timeSort);
	return x;
end

--- Unschedule a function by pattern match on the name
-- WARNING: This function is slow enough where it shouldn't be called on
-- a per-frame basis.
-- @param ptn The identifier
function VFLT.unschedulePattern(ptn)
	for _,se in pairs(sched) do
		if se.name and strmatch(se.name, ptn) then se.func = nil;	end
	end
end

--- Deschedule a previously scheduled entry
-- @param se
function VFLT.deschedule(se)
	if not se then return; end
	se.func = nil;
end

--- Return the countdown to an event, in seconds
function VFLT.GetEventCountdown(ev)
	return ev.t - GetTime();
end;

--- Find an event by name
function VFLT.FindEventByName(name)
	for i=1,#sched do
		if sched[i].name == name then return sched[i]; end
	end
	return nil;
end

--- Remove an event by name
function VFLT.UnscheduleByName(name)
	VFL.filterInPlace(sched, function(x) return x.name ~= name; end);
end

--- Schedule by name if not already scheduled
function VFLT.scheduleExclusive(name, dt, func, ...)
	if not VFLT.FindEventByName(name) then
		VFLT.scheduleNamed(name, dt, func, ...);
	end
end

function test_sched(qq_i)
	if not qq_i then qq_i = 0; end
	if (qq_i % 10) == 0 then VFL.print("second " .. qq_i/10); end
	VFLT.schedule(.1, test_sched, qq_i + 1);
end

--- Create a "periodic latch" around a function. The periodic latch guarantees that a function
-- won't be called more often than the period, and if the function should be spammed multiple
-- times, it'll be called again the end of the period
-- @param period The period of time
-- @param f The Function to be executed
-- @return a "go" function
-- @return a "terminate" function that can be used in the event of a shutdown to destroy the latch.
function VFLT.CreatePeriodicLatch(period, f)
	local latch, deferred, unlatch, go = nil, nil, nil, nil;
	local dargtbl = {};
	
	function unlatch()
		latch = nil;
		if deferred then 
			f(unpack(dargtbl));
			for k in pairs(dargtbl) do dargtbl[k] = nil; end
			deferred = nil;
		end
	end

	function go(...)
		if not latch then
			f(...);
			deferred = nil; latch = true;
			VFLT.ZMSchedule(period, unlatch);
		else
			if not deferred then
				deferred = true;
				for i=1,select("#",...) do dargtbl[i] = select(i,...); end
			end
		end
	end

	local function terminate()
		deferred = nil; for k in pairs(dargtbl) do dargtbl[k] = nil; end
		go = VFL.Noop; unlatch = VFL.Noop; f = VFL.Noop;
	end
	
	return go, terminate;
end

