-- Init.lua
-- VFL - Venificus' Function Library
-- (C)2005-2006 Bill Johnson (Venificus of Eredar server)
-- 
-- VFL bootstrap and initialization.

-----------------------------
-- CORE VFL INITIALIZATION
-----------------------------
VFL._initRan = false;
VFL.loaded = false;
function VFL.init()
	-- Create VFLConfig if it doesn't exist
	if not VFLConfig then VFLConfig = {}; end

	-- Load module saved vars.
	VFLLoadModuleData();
	
	-- Lock out from multiple initializations.
	if VFL._initRan then return; end
	VFL._initRan = true;
end;

-------------------------------
-- DEFERRED VFL INITIALIZATION
-- These initializations are deferred until the player is loaded into
-- the world.
-------------------------------
function VFL.initDeferred()
	-- Unbind so init doesn't rerun
	WoWEvents:Unbind("vflinit");

	-- Initialize the time subsystem.
	VFLT.InitTime();
	
	-- Notify that we're done.
	VFL.loaded = true;
	VFLEvents:Dispatch("VFL_INITIALIZED");
end;

VFLTip:SetOwner(WorldFrame, "ANCHOR_NONE");

-- Trip init event when vars are loaded.
WoWEvents:Bind("VARIABLES_LOADED", nil, VFL.init);
WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, VFL.initDeferred, "vflinit");

