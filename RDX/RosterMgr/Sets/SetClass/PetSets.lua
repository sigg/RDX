
---------------------------------------------
-- "Has Pet" set class
---------------------------------------------
local GetUnitByNumber = RDXDAL.GetUnitByNumber;

local hasPetSet = RDXDAL.Set:new();
hasPetSet.name = "Has Pet";
RDXDAL.RegisterSet(hasPetSet);

local function UpdateHasPet()
	local unit,uid;
	RDXDAL.BeginEventBatch();
	for i=41,80 do
		unit = GetUnitByNumber(i);
		if unit:IsValid() then
			hasPetSet:_Set(i-40, true);
		else
			hasPetSet:_Set(i-40, false);
		end
	end
	RDXDAL.EndEventBatch();
end
RDXEvents:Bind("ROSTER_PETS_CHANGED", nil, UpdateHasPet);

RDXDAL.RegisterSetClass({
	name = "haspet";
	title = VFLI.i18n("Has Pet");
	GetUI = RDXDAL.TrivialSetFinderUI("haspet");
	FindSet = function() return hasPetSet; end;
});

-- The whole raid, and pets set
local gps = RDXDAL.Set:new();
gps.name = "Group and Pets";
RDXDAL.RegisterSet(gps);

local function UpdateGroupPet()
	local unit,uid;
	RDXDAL.BeginEventBatch();
	for i=1,80 do
		unit = GetUnitByNumber(i);
		if unit:IsValid() then
			gps:_Set(i, true);
		else
			gps:_Set(i, false);
		end
	end
	RDXDAL.EndEventBatch();
end

RDXEvents:Bind("ROSTER_UPDATE", nil, UpdateGroupPet);

RDXDAL.RegisterSetClass({
	name = "grouppets";
	title = VFLI.i18n("Group and Pets");
	GetUI = RDXDAL.TrivialSetFinderUI("grouppets");
	FindSet = function() return gps; end;
});