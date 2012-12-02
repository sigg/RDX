-- Core.lua
-- VFL_Profiler
-- (C)2007 Bill Johnson and The VFL Project
-- 
-- STUB
-- APIs for instrumenting code for profiling.
--
-- Individual pieces of code can register themselves for profile monitoring
-- by using these APIs. These functions are intelligently converted to NOOPs based
-- on whether or not full script profiling is enabled and will not hurt performance
-- when profiling is disabled.
--

VFLP = RegisterVFLModule({
	name = "VFLP";
	description = "Profiler";
	parent = VFL;
});
VFLP.Events = DispatchTable:new();

-- Object profiling data storage
local fcats = {};
local flist = {};
VFLP._fcats = fcats;
VFLP._flist = flist;

local ecats = {};
local elist = {};
VFLP._ecats = ecats;
VFLP._elist = elist;

local pcats = {};
local plist = {};
VFLP._pcats = pcats;
VFLP._plist = plist;

-- Enabled state of profiling = cvar value at UI load time.
local isEnabled = 0;
local success,x = pcall(GetCVar, "scriptProfile");
if success == true then
	isEnabled = tonumber(x);
end

--- Determine if profiling is enabled.
function VFLP.IsEnabled()
	if (isEnabled == 0) then return false; else return true; end
end

--- Stub functions
VFLP.RegisterCategory = VFL.Noop;
VFLP.UnregisterCategory = VFL.Noop;
VFLP.RegisterFunc = VFL.Noop;
VFLP.RegisterFrame = VFL.Noop;
VFLP.UnregisterObject = VFL.Noop;

VFLP.RegisterEventCategory = VFL.Noop;
VFLP.RegisterEvent = VFL.Noop;
VFLP.UnregisterEvent = VFL.Noop;

VFLP.RegisterPoolCategory = VFL.Noop;
VFLP.RegisterPool = VFL.Noop;
VFLP.UnregisterPool = VFL.Noop;
VFLP.GetCategoryCPU = VFL.Noop;

if VFLP.IsEnabled() then
	-- If enabled, replace stubs with real stuff

	--- Register a profiling category. All functions have a category; the parent category
	-- totals up the usages of all subfunctions.
	
	function VFLP.RegisterCategory(name)
		if (type(name) ~= "string") or (fcats[name]) then return; end
		fcats[name] = true;
		table.insert(flist, {
			type = "category"; category = name; title = name; 
			calls = 0; lastCalls = 0; raCalls =0;
			CPU = 0; lastCPU = 0; raCPU = 0;
		});
	end
	VFLP.RegisterCategory("Uncategorized");

	--- Unregister a profiling category; Also implicitly unregisters all functions in that
	-- category.
	function VFLP.UnregisterCategory(name)
		if (type(name) ~= "string") or (name == "Uncategorized") or (not fcats[name]) then return; end
		VFL.filterInPlace(flist, function(x) return (x.category ~= name); end);
		fcats[name] = nil;
		VFLP.Events:Dispatch("PROFILE_OBJECTS_CHANGED");
	end
	
	function VFLP.GetCategoryCPU(name)
		for i,v in ipairs(flist) do
			if v.category == name then
				return v.CPU;
			end
		end
	end

	--- Register a function in the given category.
	function VFLP.RegisterFunc(category, title, f, includeSubs)
		if (type(f) ~= "function") then return; end
		if (type(category) ~= "string") or (not fcats[category]) then category = "Uncategorized"; end
		local idx,u = 0, nil;
		for i in ipairs(flist) do
			u = flist[i];
			if (u.type == "category") and (u.category == category) then idx = i; break; end
		end
		if idx > 0 then
			table.insert(flist, idx + 1, {
				type = "function"; category = category; title = title;
				object = f; includeSubObjects = includeSubs; 
				calls = 0; lastCalls = 0; raCalls = 0;
				CPU = 0; lastCPU = 0; raCPU = 0;
			});
			VFLP.Events:Dispatch("PROFILE_OBJECTS_CHANGED");
		end
	end

	--- Register a frame in the given category
	function VFLP.RegisterFrame(category, title, f, includeSubs)
		if (type(f) ~= "table") or (not f.GetObjectType) then return; end
		if (type(category) ~= "string") or (not fcats[category]) then category = "Uncategorized"; end
		local idx,u = 0, nil;
		for i in ipairs(flist) do
			u = flist[i];
			if (u.type == "category") and (u.category == category) then idx = i; break; end
		end
		if idx > 0 then
			table.insert(flist, idx + 1, {
				type = "frame"; category = category; title = title;
				object = f; includeSubObjects = includeSubs;
				calls = 0; lastCalls = 0; raCalls = 0;
				CPU = 0; lastCPU = 0; raCPU = 0;
			});
			VFLP.Events:Dispatch("PROFILE_OBJECTS_CHANGED");
		end
	end

	--- Remove a frame or function previously registered.
	function VFLP.UnregisterObject(obj)
		if obj == nil then return; end
		if (VFL.removeFieldMatches(flist, "object", obj) > 0) then
			VFLP.Events:Dispatch("PROFILE_OBJECTS_CHANGED");
		end
	end

	------------------------------event
	function VFLP.RegisterEventCategory(name)
		if (type(name) ~= "string") or (ecats[name]) then return; end
		ecats[name] = true;
		table.insert(elist, {
			type = "category"; category = name; title = name; 
			calls = 0; lastCalls = 0; raCalls =0;
			CPU = 0; lastCPU = 0; raCPU = 0;
		});
	end
	VFLP.RegisterEventCategory("Uncategorized");
	
	--- Register a event in the given category.
	function VFLP.RegisterEvent(category, title, f)
		if (type(title) ~= "string") then return; end
		if (type(category) ~= "string") or (not ecats[category]) then category = "Uncategorized"; end
		local idx,u = 0, nil;
		for i in ipairs(elist) do
			u = elist[i];
			if (u.type == "category") and (u.category == category) then idx = i; break; end
		end
		if idx > 0 then
			table.insert(elist, idx + 1, {
				type = "event"; category = category; title = title;
				object = f;
				calls = 0; lastCalls = 0; raCalls = 0;
				CPU = 0; lastCPU = 0; raCPU = 0;
			});
			VFLP.Events:Dispatch("PROFILE_OBJECTS_CHANGED");
		end
	end

	---------------------------------------- pool
	--- Register a profiling category. All functions have a category; the parent category
	-- totals up the usages of all subfunctions.
	function VFLP.RegisterPoolCategory(name)
		if (type(name) ~= "string") or (pcats[name]) then return; end
		pcats[name] = true;
		table.insert(plist, {
			type = "category"; category = name; title = name; 
			create = 0; use = 0; available = 0; jail = 0;
		});
	end
	--VFLP.RegisterPoolCategory("Uncategorized");
	
	


end -- (if VFLP.IsEnabled())
--

-- SUMMARY CPU/Memory PROFILING

local summary_update_interval = 1;

--- Gets the summary update interval.
-- This is used for converting to per-second stats.
-- (usage per second = usage per interval * intervals per sec = upi / spi)
function VFLP.GetSummaryUpdateInterval() return summary_update_interval; end

local sig_ProfUpdated = VFLP.Events:LockSignal("SUMMARY_PROFILE_UPDATED");

-- List of addons currently being profiled
local alist = {};
function VFLP._GetAddonSummary() return alist; end

local function UpdateAList()
	alist[1] = {
		addon_index = 1;
		title = "--- TOTAL ---";
		mem = 0; CPU = 0; raMem = 0; raCPU = 0, PicCPU = 0, nbPicCPU = 0;
	};
	alist[2] = {
		addon_index = 1;
		title = "Blizzard";
		mem = 0; CPU = 0; raMem = 0; raCPU = 0, PicCPU = 0, nbPicCPU = 0;
	};
	local n = 3;
	for i=1, GetNumAddOns() do
		if IsAddOnLoaded(i) then
			local name = GetAddOnInfo(i);
			if not string.find(name, "^RDX_mediapack_") then
				alist[n] = {
					addon_index = i;
					title = name;
					mem = 0; CPU = 0; raMem = 0; raCPU = 0, PicCPU = 0, nbPicCPU = 0;
				};
				n = n + 1;
			end
		end
	end
	sig_ProfUpdated:Raise();
end
WoWEvents:Bind("ADDON_LOADED", nil, UpdateAList);

local globalMemory = 0;
local mem, memusage, memtot, memratot, memx, memaindex, cgm, title = 0, 0, 0, 0, nil, 1, 0, "";
-- By default, no Memory summary
local UpdateMemorySummary = VFL.Noop;
if VFLP.IsEnabled() then
	function UpdateMemorySummary()
		--UpdateAddOnMemoryUsage();
		-- /script UpdateAddOnMemoryUsage();
		mem, memusage, memtot, memratot, memx, memaindex = 0, 0, 0, 0, nil, 1;
		
		-- For each addon...
		for i=3,#alist do
			memx = alist[i]; memaindex = memx.addon_index;
			--if VFLConfig.summary[alist[i].title] then
				mem = GetAddOnMemoryUsage(memaindex);
			--else
			--	mem = 0;
			--end
			memtot = memtot + mem;
			memusage = mem - memx.mem; 
			memx.raMem = ( (memx.raMem * 4) + memusage ) / 5; -- weight-5 rolling average
			memratot = memratot + memx.raMem;
			memx.mem = mem;
		end
	
		-- Now update totals row
		memx = alist[1];
		cgm = collectgarbage("count");
		memusage = cgm - memx.mem;
		memx.raMem = ( (memx.raMem * 4) + memusage ) / 5;
		memx.mem = cgm;
		globalMemory = memtot/1000;
		-- Update blizzard
		memx = alist[2];
		memx.raMem = alist[1].raMem - memratot;
		memx.mem = alist[1].mem - memtot;
	end
end

function VFLP._GetAddonsMemory() return globalMemory; end

local acpu, acpuusage, acputot, acpuratot, acpupictot, acpux, acpuaindex = 0, 0, 0, 0, 0, nil, 1;
-- By default, no CPU summary
local UpdateCPUSummary = VFL.Noop;
if VFLP.IsEnabled() then
	function UpdateCPUSummary()
		UpdateAddOnCPUUsage();
		acpu, acpuusage, acputot, acpuratot, acpupictot, acpux, acpuaindex = 0, 0, 0, 0, 0, nil, 1;
		for i=3, #alist do
			acpux = alist[i];
			acpuaindex = acpux.addon_index;
			acpu = GetAddOnCPUUsage(acpuaindex) / 1000;
			acputot = acputot + acpu;
			
			acpuusage = acpu - acpux.CPU;
			acpux.raCPU = ( (acpux.raCPU * 4) + acpuusage ) / 5;
			acpuratot = acpuratot + acpux.raCPU;
			acpux.CPU = acpu;
		end
		acpux = alist[1]; 
		acpu = GetScriptCPUUsage() / 1000; 
		acpuusage = acpu - acpux.CPU;
		acpux.raCPU = ( (acpux.raCPU * 4) + acpuusage ) / 5;
		acpux.CPU = acpu;
		
		acpux = alist[2]; 
		acpux.raCPU = alist[1].raCPU - acpuratot;
		acpux.CPU = alist[1].CPU - acputot;
	end
end

-- Summary updater
local last_su, framecount_su, last_su_frame, frames_per_su = 0, 0, 0, 0;
local t_su = 0;

--- Usage/frame = usage/interval * intervals/frame = u/i * 1/(f/i)
function VFLP.GetFramesPerSummaryUpdate() return frames_per_su; end

local suf = CreateFrame("Frame");
local function SummaryUpdate()
	framecount_su = framecount_su + 1;
	t_su = GetTime();
	if (t_su-last_su) < summary_update_interval then return; end
	last_su = t_su;

	-- Measure 
	frames_per_su = ( (frames_per_su * 4) + (framecount_su - last_su_frame) ) / 5;
	last_su_frame = framecount_su;

	UpdateMemorySummary();
	UpdateCPUSummary();
	sig_ProfUpdated:Raise();
end

-- Event Profiling

local event_update_interval = 3;

function VFLP.GetEventUpdateInterval() return event_update_interval; end

local sig_EProfUpdated = VFLP.Events:LockSignal("EVENT_PROFILE_UPDATED");
local eblist = VFLP._elist;

local curCat, totCPU, totCalls, delta, cpu, calls = nil, 0, 0, 0, 0, 0;

local function UpdateEventProfile()
	curCat, totCPU, totCalls, delta, cpu, calls = nil, 0, 0, 0, 0, 0;
	for _,obj in ipairs(eblist) do
		if (obj.type == "category") and (obj ~= curCat) then
			-- We just changed categories. Update the current category
			if curCat then
				-- update total calls
				delta = totCalls - curCat.calls;
				curCat.raCalls = ( (curCat.raCalls * 4) + delta ) / 5;
				curCat.lastCalls = curCat.calls; curCat.calls = totCalls;
				-- update total CPU
				delta = totCPU - curCat.CPU;
				curCat.raCPU = ( (curCat.raCPU * 4) + delta ) / 5;
				curCat.lastCPU = curCat.CPU; curCat.CPU = totCPU;
			end
			totCPU = 0; totCalls = 0; curCat = obj;
		else
			if obj.type == "event" then
				VFL.print(obj.object);
				cpu, calls = GetEventCPUUsage(obj.object);
				VFL.print(cpu);
				VFL.print(calls);
				cpu = cpu / 1000;
			end
			totCPU = totCPU + cpu; totCalls = totCalls + calls;
			-- update calls
			delta = calls - obj.calls;
			obj.raCalls = ( (obj.raCalls * 4) + delta ) / 5;
			obj.lastCalls = obj.calls; obj.calls = calls;
			-- update cpu
			delta = cpu - obj.CPU;
			obj.raCPU = ( ( obj.raCPU * 4) + delta ) / 5;
			obj.lastCPU = obj.CPU; obj.CPU = cpu;
		end
	end
	-- Update last category
	if curCat then
		-- update total calls
		delta = totCalls - curCat.calls;
		curCat.raCalls = ( (curCat.raCalls * 4) + delta ) / 5;
		curCat.lastCalls = curCat.calls; curCat.calls = totCalls;
		-- update total CPU
		delta = totCPU - curCat.CPU;
		curCat.raCPU = ( (curCat.raCPU * 4) + delta ) / 5;
		curCat.lastCPU = curCat.CPU; curCat.CPU = totCPU;
	end
end

-- Object updater
local last_eu, framecount_eu, last_eu_frame, frames_per_eu = 0, 0, 0, 0;
local t_eu = 0;

--- Usage/frame = usage/interval * intervals/frame = u/i * 1/(f/i)
function VFLP.GetFramesPerEventUpdate() return frames_per_eu; end

local euf = CreateFrame("Frame");
local function EventUpdate()
	framecount_eu = framecount_eu + 1;
	t_eu = GetTime();
	if (t_eu-last_eu) < event_update_interval then return; end
	last_eu = t_eu;

	-- Measure 
	frames_per_eu = ( (frames_per_eu * 4) + (framecount_eu - last_eu_frame) ) / 5;
	last_eu_frame = framecount_eu;

	UpdateEventProfile();
	sig_EProfUpdated:Raise();
end


-- Object PROFILING

local object_update_interval = 1;
--- Gets the object update interval.
-- This is used for converting to per-second stats.
-- (usage per second = usage per interval * intervals per sec = upi / spi)
function VFLP.GetObjectUpdateInterval() return object_update_interval; end

local sig_OProfUpdated = VFLP.Events:LockSignal("OBJECT_PROFILE_UPDATED");
local oblist = flist;

local curCat, totCPU, totCalls, delta, cpu, calls = nil, 0, 0, 0, 0, 0;
local function UpdateObjProfile()
	curCat, totCPU, totCalls, delta, cpu, calls = nil, 0, 0, 0, 0, 0;
	for _,obj in ipairs(oblist) do
		if (obj.type == "category") and (obj ~= curCat) then
			-- We just changed categories. Update the current category
			if curCat then
				-- update total calls
				delta = totCalls - curCat.calls;
				curCat.raCalls = ( (curCat.raCalls * 4) + delta ) / 5;
				curCat.lastCalls = curCat.calls; curCat.calls = totCalls;
				-- update total CPU
				delta = totCPU - curCat.CPU;
				curCat.raCPU = ( (curCat.raCPU * 4) + delta ) / 5;
				curCat.lastCPU = curCat.CPU; curCat.CPU = totCPU;
			end
			totCPU = 0; totCalls = 0; curCat = obj;
		else
			if obj.type == "function" then
				if obj.object == nil then VFL.print("ERROR"); end
				cpu, calls = GetFunctionCPUUsage(obj.object, obj.includeSubObjects);
				cpu = cpu / 1000;
				--VFL.print(obj.title .. ":" .. cpu);
			elseif obj.type == "frame" then
				cpu, calls = GetFrameCPUUsage(obj.object, obj.includeSubObjects);
				cpu = cpu / 1000;
			end
			totCPU = totCPU + cpu; totCalls = totCalls + calls;
			-- update calls
			delta = calls - obj.calls;
			obj.raCalls = ( (obj.raCalls * 4) + delta ) / 5;
			obj.lastCalls = obj.calls; obj.calls = calls;
			-- update cpu
			delta = cpu - obj.CPU;
			obj.raCPU = ( ( obj.raCPU * 4) + delta ) / 5;
			obj.lastCPU = obj.CPU; obj.CPU = cpu;
		end
	end
	-- Update last category
	if curCat then
		-- update total calls
		delta = totCalls - curCat.calls;
		curCat.raCalls = ( (curCat.raCalls * 4) + delta ) / 5;
		curCat.lastCalls = curCat.calls; curCat.calls = totCalls;
		-- update total CPU
		delta = totCPU - curCat.CPU;
		curCat.raCPU = ( (curCat.raCPU * 4) + delta ) / 5;
		curCat.lastCPU = curCat.CPU; curCat.CPU = totCPU;
	end
end

-- Object updater
local last_ou, framecount_ou, last_ou_frame, frames_per_ou = 0, 0, 0, 0;
local t_ou = 0;

--- Usage/frame = usage/interval * intervals/frame = u/i * 1/(f/i)
function VFLP.GetFramesPerObjectUpdate() return frames_per_ou; end

local ouf = CreateFrame("Frame");
local function ObjectUpdate()
	framecount_ou = framecount_ou + 1;
	t_ou = GetTime();
	if (t_ou-last_ou) < object_update_interval then return; end
	last_ou = t_ou;

	-- Measure 
	frames_per_ou = ( (frames_per_ou * 4) + (framecount_ou - last_ou_frame) ) / 5;
	last_ou_frame = framecount_ou;

	UpdateObjProfile();
	sig_OProfUpdated:Raise();
end

-- Pool Profiling


local pool_update_interval = 5;

--- Gets the summary update interval.
-- This is used for converting to per-second stats.
-- (usage per second = usage per interval * intervals per sec = upi / spi)
function VFLP.GetPoolUpdateInterval() return pool_update_interval; end

local sig_PProfUpdated = VFLP.Events:LockSignal("POOL_PROFILE_UPDATED");

-- List of addons currently being profiled
local plist = {};
function VFLP._GetPools() return plist; end

local function UpdatePList()
	local n = 1;
	plist[n] = {
		pool_name = "Objects";
		title = "--- TOTAL ---";
		create = 0; use = 0; available = 0; jail = 0;
		type = "category";
	};
	n = n + 1;
	for i,v in ipairs(VFLUI.GetSortPoolsObject()) do
		plist[n] = {
			pool_name = v.name;
			title = v.name;
			create = 0; use = 0; available = 0; jail = 0;
			type = "poolObject";
		};
		n = n + 1;
	end
	plist[n] = {
		pool_name = "Others";
		title = "--- TOTAL ---";
		create = 0; use = 0; available = 0; jail = 0;
		type = "category";
	};
	n = n + 1;
	plist[n] = {
		pool_name = "Textures";
		title = "Textures";
		create = 0; use = 0; available = 0; jail = 0;
		type = "poolOther";
	};
	n = n + 1;
	plist[n] = {
		pool_name = "Fonts";
		title = "Fonts";
		create = 0; use = 0; available = 0; jail = 0;
		type = "poolOther";
	};
	sig_PProfUpdated:Raise();
end
WoWEvents:Bind("ADDON_LOADED", nil, UpdatePList);

local pool, tot, x = nil, {}, nil;
local function UpdatePoolSummary()
	tot.create = 0;
	tot.use = 0;
	tot.available = 0;
	tot.jail = 0;
	
	for i=2,#plist do
		x = plist[i];
		if x.type == "poolObject" then
			pool = VFLUI.GetPoolObject(x.pool_name);
			x.create = pool:GetFallbacks(); 
			x.use = (pool:GetFallbacks() - pool:GetPoolSize() -  pool:GetJailSize()); 
			x.available = pool:GetPoolSize();
			x.jail = pool:GetJailSize();
			
			tot.create = tot.create + x.create;
			tot.use = tot.use + x.use;
			tot.available = tot.available + x.available;
			tot.jail = tot.jail + x.jail;
		elseif x.pool_name == "Textures" then
			pool = VFLUI.GetPoolTextures();
			x.create = pool:GetFallbacks(); 
			x.use = (pool:GetFallbacks() - pool:GetPoolSize() -  pool:GetJailSize()); 
			x.available = pool:GetPoolSize(); 
			x.jail = 0;
		elseif x.pool_name == "Fonts" then
			pool = VFLUI.GetPoolFonts();
			x.create = pool:GetFallbacks(); 
			x.use = (pool:GetFallbacks() - pool:GetPoolSize() -  pool:GetJailSize()); 
			x.available = pool:GetPoolSize(); 
			x.jail = 0;
		end
	end

	-- Now update totals row
	x = plist[1];
	x.create = tot.create; 
	x.use = tot.use;
	x.available = tot.available;
	x.jail = tot.jail;
end

-- Object updater
local last_pu, framecount_pu, last_pu_frame, frames_per_pu = 0, 0, 0, 0;
local t_pu = 0;

local puf = CreateFrame("Frame");
local function PoolUpdate()
	framecount_pu = framecount_pu + 1;
	t_pu = GetTime();
	if (t_pu-last_pu) < pool_update_interval then return; end
	last_pu = t_pu;

	-- Measure 
	frames_per_su = ( (frames_per_su * 4) + (framecount_pu - last_su_frame) ) / 5;
	last_su_frame = framecount_pu;

	UpdatePoolSummary();
	sig_PProfUpdated:Raise();
end

-- Add the profiling core to the profiler!
VFLP.RegisterCategory("VFL Profiler");
VFLP.RegisterFunc("VFL Profiler", "Mem Updater", UpdateMemorySummary, true);
VFLP.RegisterFunc("VFL Profiler", "CPU Updater", UpdateCPUSummary, true);
--VFLP.RegisterFunc("VFL Profiler", "Event Updater", UpdateEventProfile, true);
VFLP.RegisterFunc("VFL Profiler", "Object Updater", UpdateObjProfile, true);
VFLP.RegisterFunc("VFL Profiler", "Pool Updater", UpdatePoolSummary, true);

local textperf, textdebit = "", "";
local memtotal_color, ips_color, latency_color;
local memtotal, memtmp, memsave = 0, 0, 0;

local SAMPLESIZE = 5; 
local fWeight = ( (SAMPLESIZE-1)/SAMPLESIZE );
local sWeight = 1 - fWeight;
local vps, val = 0 , 0;

local muf = CreateFrame("Frame");

local function updateTextPerf()
	UpdateAddOnMemoryUsage();
	memtotal_color, ips_color, latency_color = _green, _red, _green;
	memtmp = GetAddOnMemoryUsage("RDX") + GetAddOnMemoryUsage("VFL");
	memtotal = memtmp / 1000;
	if memtotal > 50 then memtotal_color = _yellow; end
	if memtotal > 65 then memtotal_color = _orange; end
	if memtotal > 80 then memtotal_color = _red; end
	memtotal = string.format("%0.2f", memtotal);
	ips = floor(GetFramerate());
	if ips > 10 then ips_color = _orange; end
	if ips > 15 then ips_color = _yellow; end
	if ips > 20 then ips_color = _green; end
	_,_,latency = GetNetStats();
	if latency > 250 then latency_color = _yellow; end
	if latency > 500 then latency_color = _orange; end
	if latency > 750 then latency_color = _red; end
	textperf = VFL.tcolorize(memtotal, memtotal_color) .. "Mb " .. VFL.tcolorize(ips, ips_color) .. "fps " .. VFL.tcolorize(latency, latency_color) .. "ms";

	vps = (memtmp - memsave) * 1000;
	val = ((val * fWeight) + (vps * sWeight));
	if vps < 0 then 
		textdebit = "Garbage Collecting"; val = 0;
	elseif vps > 1000000 then
		textdebit = "Calcul"; val = 0;
	else
		textdebit = "Mem debit: " .. VFL.KayMemory(val);
	end
	memsave = memtmp;
	
end

function VFLP.GetTextPerf()
	return textperf, textdebit;
end

WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	-- Store enable/disable profile object
	if not VFLConfig then VFLConfig = {}; end
	if not VFLConfig.summary then VFLConfig.summary = {}; end
	if not VFLConfig.object then VFLConfig.object = {}; end
	if not VFLConfig.event then VFLConfig.event = {}; end
	if not VFLConfig.pool then VFLConfig.pool = {}; end
	
	-- summary_update_interval = 1 by default
	if type(VFLConfig.prof_summary_update_interval) == "number" then
		summary_update_interval = VFL.clamp(VFLConfig.prof_summary_update_interval, 0.1, 10);
	else
		VFLConfig.prof_summary_update_interval = summary_update_interval;
	end
	
	if VFLP.IsEnabled() then
		if RDX then RDX.printW(VFLI.i18n("Profiler Activated !!!")); end
		suf:SetScript("OnUpdate", SummaryUpdate);
		--euf:SetScript("OnUpdate", EventUpdate);
		ouf:SetScript("OnUpdate", ObjectUpdate);
		puf:SetScript("OnUpdate", PoolUpdate);
	end
	
	local last_as = 0;
	muf:SetScript("OnUpdate", function(self, elapsed)
		last_as = last_as + elapsed;
		if last_as > 1 then
			updateTextPerf();
			last_as = 0;
		end
	end);
end);

function VFLP.ResetCPU()
	ResetCPUUsage()
end

