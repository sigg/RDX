-- Core.lua
-- Sigg

RDXMAP = RegisterVFLModule({
	name = "Map";
	title = VFLI.i18n("Map");
	description = "Map";
	version = {1,0,0};
	parent = RDX;
});

local continentdb = {};
function RDXMAP.GetContinents() return continentdb; end

local zonedb = {};
function RDXMAP.GetZones() return zonedb; end

function RDXMAP.GetContinentById(i)
	if not i then return; end
	return continentdb[i];
end

function RDXMAP.GetZoneById(i)
	if not i then return; end
	return zonedb[i];
end

------------------------------------------
-- registration
------------------------------------------

function RDXMAP.RegisterContinent(tbl)
	if (not tbl) or (not tbl.cid) then RDX.printI(VFLI.i18n("attempt to register anonymous continent")); return; end
	local cid = tbl.cid;
	if continentdb[cid] then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Duplicate registration continent ") .. tbl.id); return; end
	continentdb[cid] = tbl;
end

function RDXMAP.RegisterZone(tbl)
	if (not tbl) or (not tbl.zid) then RDX.printI(VFLI.i18n("attempt to register anonymous zone")); return; end
	if (not tbl.cid) then RDX.printI(VFLI.i18n("attempt to register zone without continent")); return; end
	local zid = tbl.zid;
	if zonedb[zid] then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Duplicate registration zone ") .. tbl.id); return; end
	zonedb[zid] = tbl;
	if not continentdb[cid].zones then continentdb[cid].zones = {}; end
	table.insert(continentdb[cid].zones, tbl);
end

------------------------------------------
-- high API
------------------------------------------

function RDXMAP.GetWorldPos(cid, mapX, mapY)

--	self.GetWorldPosCnt = (self.GetWorldPosCnt or 0) + 1

--[[
	local info = self.MapInfo[floor (mapId / 1000)]
	if not info then

		if IsControlKeyDown() then
			Nx.prt ("GetWorldPos inst %s %s %s", mapId, mapX, mapY)
--			Nx.prt (" %s", debugstack (2, 3, 0))
		end

--		info = self.MapInfo[0]
		mapX = 0
		mapY = 0
	end
--]]

	local winfo = continentdb[cid]
	if winfo then

		local scale = winfo[1]

		return	winfo[4] + mapX * scale,
					winfo[5] + mapY * scale / 1.5

--		if mapId == 11050 then
--			Nx.prt ("%s %s %s %s", info.Y, winfo[3], mapY, scale)
--		end

--		return	info.X + winfo[2] + mapX * scale,
--					info.Y + winfo[3] + mapY / 1.5 * scale
	end

	return 0, 0
end

