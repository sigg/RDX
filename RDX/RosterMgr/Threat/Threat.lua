
local clamp, tsort, tinsert, strlower = VFL.clamp, table.sort, table.insert, string.lower;
local sig_unit_threat = RDXEvents:LockSignal("UNIT_THREAT");

-- Signal an update to ALL player threat.
-- There is no event for one unit fire when rawthread change erf
local function GlobalThreatUpdate()
	RDXDAL.BeginEventBatch();
	for _,unit in RDXDAL.Raid() do
		sig_unit_threat:Raise(unit, unit.nid, unit.uid);
	end
	RDXDAL.EndEventBatch();
end

---------------------------------------------------
-- INIT
---------------------------------------------------
local function InitThreat()
	-- to be fixed
	VFLT.AdaptiveUnschedule2("threat_target");
	VFLT.AdaptiveSchedule2("threat_target", 5, GlobalThreatUpdate);
end

RDXEvents:Bind("INIT_DEFERRED", nil, InitThreat);

----------------------------------------------------------
-- UNIT API MODS
-- Add functions to the Unit objects to query their threat.
----------------------------------------------------------
local isTanking, state, scaledPercent, rawPercent, threatValue;

local function GetThreatInfo(rdxunit)
	if not UnitExists("target") then return nil, nil, 0, 0, 0; end
	isTanking, state, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation(rdxunit.uid, "target");
	if scaledPercent then scaledPercent = scaledPercent / 100; else scaledPercent = 0; end
	if rawPercent then rawPercent = rawPercent / 100; else rawPercent = 0; end
	return isTanking, state, scaledPercent, rawPercent, threatValue;
end

RDXDAL.Unit.GetThreatInfo = function(self)
   isTanking, state, scaledPercent, rawPercent, threatValue = GetThreatInfo(self);
   return isTanking, state, scaledPercent, rawPercent, threatValue;
end;

RDXDAL.Unit.FracThreat = function(self)
   _, _, _, rawPercent = GetThreatInfo(self);
   return rawPercent;
end;

RDXDAL.Unit.FracThreatScaled = function(self)
   _, _, scaledPercent = GetThreatInfo(self);
   return scaledPercent;
end;

--VFLP.RegisterFunc(VFLI.i18n("RDX: UnitDB"), "UnitDetailedThreatSituation", UnitDetailedThreatSituation, true);
