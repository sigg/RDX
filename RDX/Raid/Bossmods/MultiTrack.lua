-- MultiTrack.lua
--
-- Copyright (c) 2006, Jim Zajkowski
-- Portions (C)2006 Bill Johnson

-- Implements a multiple tracker window to show the health bars of a number of tracers
-- specifically allows for multiple targets found from one trace (eg, "Flamewalker Elite")

MultiTrack = RegisterVFLModule({
	name = "MultiTrack";
	description = "Multiple HOT tracker for RDX";
	parent = RDX;
});

local enabled = true;
local _isOpen = nil;
local traceDelay = 0.2;

local _tracers = { };

----------------------------------------
-- Gathering tracer iterator.
----------------------------------------
-- NOTE: Single-threaded, single-instanced, not meant to be used outside of this file...
local function _CountTraces()
	local i=0;
	for _,tracer in ipairs(_tracers) do
		i = i + tracer:NumMatches();
	end
	return i;
end
local tracerIndex, subIndex = 0, 0;
local function _TracerIteratorCore()
	while true do
		local x = _tracers[tracerIndex]; if not x then return nil; end
		local ary = x:ProtoUIDs();
		subIndex = subIndex + 1;
		if ary and ary[subIndex] then
			return 1, ary[subIndex];
		end
		tracerIndex = tracerIndex + 1; subIndex = 0;
	end
end

local function _TracerIterator()
	tracerIndex = 1; subIndex = 0; 
	return _TracerIteratorCore;
end

-------------------------------------
-- Window creation code
-------------------------------------
local _multi_track_window = nil;
local function _CreateMultiTracker()
	if _multi_track_window then return; end
	
	local state = RDX.GenericWindowState:new();
	-- Custom slots
	state:GetSlotValue("Multiplexer"):SetPeriod(nil);
	state:GetSlotValue("Multiplexer"):SetNoHinting(true);
	state:AddFeature({feature = "Frame: Default", title = VFLI.i18n("Encounter Targets")});
	state:AddSlot("DataSource");
	state:AddSlot("DataSourceIterator");
	state:_SetSlotFunction("DataSourceIterator", function() return _TracerIterator(); end);
	state:AddSlot("DataSourceSize");
	state:_SetSlotFunction("DataSourceSize", function() return _CountTraces(); end);
	-- Features
	state:AddFeature({feature = "Assist Frames", design = "Builtin:uf_multitrack"});
	state:AddFeature({feature = "Grid Layout", axis = 1, dxn = 1, cols = 1});

	_multi_track_window = RDX.Window:new(RDXParent);
	_multi_track_window:LoadState(state);
	state = nil;
--[[
	function _multi_track_window:_WindowMenu(mnu)
		table.insert(mnu, { 
			text = "Close";
			func = function()
				VFL.poptree:Release();
				MultiTrack._Disable();
			end;
		});
	end
]]
end

--------------------------------------
-- API
--------------------------------------
function MultiTrack.Open()
	if _isOpen then return end;
	_isOpen = true;

	-- Only make/show the tracker if it's enabled.
	--if enabled then
		if (not _multi_track_window) then _CreateMultiTracker(); end
		VFLT.AdaptiveUnschedule2("multitrack");
		_multi_track_window:Show();
		VFLT.AdaptiveSchedule2("multitrack", traceDelay, _multi_track_window.RepaintAll );
	--end
	
	-- Cause tracers to begin tracking
	for _,v in pairs(_tracers) do v:Open(); end
	return _multi_track_window;
end

function MultiTrack.Show()
	--if _multi_track_window and enabled then
	if _multi_track_window then
		_multi_track_window:Show();
		_multi_track_window:RepaintAll();
	end
end

function MultiTrack.Hide()
	if _multi_track_window then _multi_track_window:Hide();	end
end

function MultiTrack.Close()
	_isOpen = false;
	VFLT.AdaptiveUnschedule2("multitrack");
	for k,v in ipairs(_tracers) do
		v:Close();
		_tracers[k] = nil;
	end
	if _multi_track_window then _multi_track_window:Hide(); end
end

function MultiTrack.Add(tracer)
	table.insert(_tracers, tracer);
end

function MultiTrack.Remove(tracer)
	local idx = VFL.vfind(_tracers, tracer);
	if idx then table.remove(_tracers, idx); end
end

--------------------------------------
-- Enable/disable
--------------------------------------
--RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
--	if RDXU.disable_multitrack then enabled = nil; else enabled = true; end
--end);

--function MultiTrack._Disable()
--	RDXU.disable_multitrack = true; enabled = nil;
--	MultiTrack.Hide();
--end

--RDXBossmods.menu:RegisterMenuFunction(function(ent)
--	if RDXU.disable_multitrack then
--		ent.text = VFLI.i18n("MultiTrack |cFFFF0000[OFF]|r"); 
--		ent.func = function() 
--			RDXU.disable_multitrack = nil; enabled = true;
--			VFL.poptree:Release(); 
--		end;
--	else
--		ent.text = VFLI.i18n("MultiTrack |cFF00FF00[ON]|r"); 
--		ent.func = function() 
--			MultiTrack._Disable();
--			VFL.poptree:Release();
--		end;
--	end
--end);
