local TaxiNameStart

local function __RDXParser()
	if not RDXG.TaxiDB then RDXG.TaxiDB = {}; end
	for n = 1, NumTaxiNodes() do
		local locName = TaxiNodeName (n)
		local status = TaxiNodeGetType (n)
		VFL.vprint ("Taxi current %s (%s)", status or "nil", locName)

		RDXG.TaxiDB[locName] = true

		if TaxiNodeGetType (n) == "CURRENT" then

			TaxiNameStart = locName

			if NxData.DebugMap then
				local name = RDXMAP.APIGuide.FindTaxis(locName)
				VFL.vprint ("Taxi current %s (%s)", name or "nil", locName)
			end
		end
	end
end

-- World

-- 0,6299   7405,93
-- 0,5615   8886,91
-- 4665
-- 4990

-- 0,6465   8204,17
-- 0,4987   8590,33
-- 5304
-- 4284

-- 0,6516   8420,81
-- 0,4556   
-- 5487
-- 7344

local function EnableStoreLocalTaxiDB()
	RDX.printI(VFLI.i18n("Enable Store Local Taxi DB"));
	RDXG.localTaxiDB = true;
	WoWEvents:Unbind("localTaxiDB");
	WoWEvents:Bind("TAXIMAP_OPENED", nil, __RDXParser, "localTaxiDB");
end

local function DisableStoreLocalTaxiDB()
	RDXG.localTaxiDB = nil;
	WoWEvents:Unbind("localTaxiDB");
	RDX.printI(VFLI.i18n("Disable Store Local Taxi DB"));
end

function RDXMAP.ToggleStoreLocalTaxiDB()
	if RDXG.localTaxiDB then
		DisableStoreLocalTaxiDB();
	else
		EnableStoreLocalTaxiDB();
	end
end

function RDXMAP.IsStoreLocalTaxiDB()
	return RDXG.localTaxiDB;
end

--WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, EnableStoreLocalTaxiDB);



