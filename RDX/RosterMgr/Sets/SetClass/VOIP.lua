-- VOIP.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
-- 
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE LICENCE.
-- UNLICENSED COPYING IS PROHIBITED.
-- 
-- Code for interfacing with WoW's internal VOIP.

local UIDToNumber = RDXDAL.UIDToNumber;

-------------------------------------
-- The "talking" set - unit is a member of this set if and only if they
-- are talking on a voice channel with you.
-------------------------------------
local talking = RDXDAL.Set:new();
talking.name = "VOIP Talking";

local function ComsatStart(unit)
   local n = UIDToNumber(unit);
   if n > 0 then talking:_Set(n, true); end
end
local function ComsatStop(unit)
   local n = UIDToNumber(unit);
   if n > 0 then talking:_Set(n, false); end
end

function talking:_OnActivate()
WoWEvents:Bind("VOICE_START", nil, ComsatStart, "voip_talking");
WoWEvents:Bind("VOICE_STOP", nil, ComsatStop, "voip_talking");
end

function talking:_OnDeactivate()
WoWEvents:Unbind("voip_talking", "VOICE_START");
WoWEvents:Unbind("voip_talking", "VOICE_STOP");
end

RDXDAL.RegisterSet(talking);

-- The RDX setclass for FRS.
RDXDAL.RegisterSetClass({
   name = "voip_talk";
   title = VFLI.i18n("VOIP Talking");
   GetUI = RDXDAL.TrivialSetFinderUI("voip_talk");
   FindSet = function() return talking; end;
});

