
RDXMAP.APIMap = {};

--------
-- Get world info for a continent
-- (cont #)

function RDXMAP.APIMap.GetWorldContinentInfo (cont)
	local info
		info = RDXMAP.MapInfo[cont]
	if not info then
		return
	end

	return info.Name, info.X, info.Y
end

--------
-- Get world info for a continent and zone
-- (cont #, zone #)
function RDXMAP.APIMap.GetWorldZoneInfo (cont, zone)

	if zone == 0 then
		local info = RDXMAP.MapInfo[cont];
		if info then
			local winfo = RDXMAP.MapWorldInfo[info.mapid]
			if not winfo then
				return "unknown", 0, 0, 1, 1.5
			end
			local x = info.X + winfo[2]
			local y = info.Y + winfo[3]
			local scale = winfo[1] * 100
			local name = winfo.localname or winfo.Name

			return name, x, y, scale, scale / 1.5	
		else
			return "unknown", 0, 0, 1, 1.5
		end
	end
	local winfo = RDXMAP.MapWorldInfo[zone]
	if not winfo or not winfo[1] then
		return "unknown", 0, 0, 1, 1.5
	end
	local x = winfo[4]
	local y = winfo[5]
	local scale = winfo[1] * 100
	local name = winfo.localname or winfo.Name

	return name, x, y, scale, scale / 1.5
end


function RDXMAP.APIMap.GetWorldPos (mapId, mapX, mapY)

--	self.GetWorldPosCnt = (self.GetWorldPosCnt or 0) + 1

--[[
	local info = NxMap.MapInfo[floor (mapId / 1000)]
	if not info then

		if IsControlKeyDown() then
			VFL.vprint ("GetWorldPos inst %s %s %s", mapId, mapX, mapY)
--			VFL.vprint (" %s", debugstack (2, 3, 0))
		end

--		info = NxMap.MapInfo[0]
		mapX = 0
		mapY = 0
	end
--]]
	local winfo = NxMap.GetZoneInfo(mapId)
	if winfo and winfo[4] then

		local scale = winfo[1]
		
		--if not scale then VFL.print("RDXMAP.APIMap.GetWorldPos scale " .. mapId); end
		--if not mapX then VFL.print("RDXMAP.APIMap.GetWorldPos mapX " .. mapId); end
		--if not mapY then VFL.print("RDXMAP.APIMap.GetWorldPos mapY " .. mapId); end
		if not winfo[4] then 
			--VFL.print("RDXMAP.APIMap.GetWorldPos winfo[4] " .. mapId); 
			return 0, 0 end
		--if not winfo[5] then VFL.print("RDXMAP.APIMap.GetWorldPos winfo[5] " .. mapId); end
		
		return	winfo[4] + mapX * scale, winfo[5] + mapY * scale / 1.5

--		if mapId == 11050 then
--			VFL.vprint ("%s %s %s %s", info.Y, winfo[3], mapY, scale)
--		end

--		return	info.X + winfo[2] + mapX * scale,
--					info.Y + winfo[3] + mapY / 1.5 * scale
	end

	return 0, 0
end

--------
-- Get world positions of map (zone) rectangle
-- (id, x, y)

function RDXMAP.APIMap.GetWorldRect (mapId, mapX, mapY, mapX2, mapY2)

	local x, y = RDXMAP.APIMap.GetWorldPos (mapId, mapX, mapY)
	local x2, y2 = RDXMAP.APIMap.GetWorldPos (mapId, mapX2, mapY2)

	return x, y, x2, y2
end

--------
-- Get zone position of world location
-- (id, x, y)

function RDXMAP.APIMap.GetZonePos (mapId, worldX, worldY)

--	self.GetZonePosCnt = (self.GetZonePosCnt or 0) + 1

--	VFL.vprint ("WXY %f %f", worldX, worldY)

	local winfo = NxMap.GetZoneInfo(mapId)
	if winfo and winfo[4] then

		local scale = winfo[1]		
		return	(worldX - winfo[4]) / scale,
					(worldY - winfo[5]) / scale * 1.5

--		local x = (worldX - info.X - winfo[2]) / scale
--		local y = (worldY - info.Y - winfo[3]) / scale * 1.5

--		VFL.vprint ("XY %f %f %f", x, y, scale)

--		return x, y
	end

	return 0, 0
end

--------
-- Get the real player location map id
-- asdf
function RDXMAP.APIMap.GetInstanceID(id)
		return id;
end

-- cette fonction récupère le mapid ou se trouve le joueur
-- ne remonte plus le subzone dans la version RDX
function RDXMAP.APIMap.GetRealMapId() 
	local myunit = RDXDAL.GetMyUnit();
	return myunit.mapId
	
end

--------
-- Get the current selected map id
-- Do not call SetMapToCurrentZone() here or crash
function RDXMAP.APIMap.GetCurrentMapId()
	local aid = GetCurrentMapAreaID()
	return aid;
end


function RDXMAP.APIMap.IdToContZone (mapId)
	local info = RDXMAP.MapWorldInfo[mapId] --
	if info then
		return info.Cont or 9, mapId
	else
		--VFL.print("unknow mapid " .. mapId);
		return 0, mapId
	end
end

--------
-- Convert raw cont and zone to mapid
-- self: not used

function RDXMAP.APIMap.CZ2MapId (cont, zone)
		return zone;
end


function RDXMAP.APIMap.GetInstanceMapTextures(mapId)
	local areaId
	areaId = mapId
    if areaId then
        SetMapByID(areaId)
        local mapName = GetMapInfo();
        local levels, first = GetNumDungeonMapLevels() 
        local useTerrainMap = DungeonUsesTerrainMap()
		if (areaId == 824) then
		  levels = 7		  
		  first = 1
		end
        RDXMAP.Map.InstanceInfo[mapId] = {}
        for i=first,max(first,first+levels-1) do
            SetDungeonMapLevel(i)
            local level = useTerrainMap and i-1 or i
            local fileName = mapName.."\\"..mapName;
            if ( level > 0 ) then
                fileName = fileName..level.."_";
            end
            RDXMAP.Map.InstanceInfo[mapId][(i-first)*3+1] = 0
            RDXMAP.Map.InstanceInfo[mapId][(i-first)*3+2] = -100*(i-first)
            RDXMAP.Map.InstanceInfo[mapId][(i-first)*3+3] = fileName			
        end
    end    
end

--------
-- Get world zone scale from map id
-- (id)

function RDXMAP.APIMap.GetWorldZoneScale (mapId)

--	self.GetWorldZoneScaleCnt = (self.GetWorldZoneScaleCnt or 0) + 1
--	local winfo = NxMap.GetZoneInfo(mapId)
--	if not winfo then --
--		VFL.vprint ("GetWorldZoneScale %s %s %s", mapId)
--	end

--	return (not winfo and 10.02) or winfo[1] --
	local winfo = NxMap.GetZoneInfo(mapId)
	if winfo then
		return winfo[1]
	end 
end

-- Get world zone from map id
-- (id)

function RDXMAP.APIMap.GetWorldZone (mapId)
	return NxMap.GetZoneInfo(mapId)
end

--------
-- Get map short name (only BGs have)
function RDXMAP.APIMap.GetShortName (mapId)
	local winfo = NxMap.GetZoneInfo(mapId)
	if winfo then
		return winfo.Short
	end 
end

--------
-- Get description (color) that goes with a map nane

function RDXMAP.APIMap.GetMapNameDesc (mapId)

--	VFL.vprint ("MapId %s", mapId)
	local minLvl, maxLvl, faction
	if RDX.mapsw then
		local winfo = NxMap.GetZoneInfo(mapId)
		if winfo then
			minLvl = winfo.minLvl or 0;
			maxLvl = winfo.maxLvl or 0;
			faction = winfo.faction;
		else
			minLvl = 0;
			maxLvl = 0;
			faction = 1;
		end
	else
		local nxz = RDXMAP.MapId2Zone[mapId] or 0
		_, minLvl, maxLvl, faction = strsplit ("!", NxMap.Zones[nxz]) --
		minLvl = tonumber (minLvl)
		faction = tonumber (faction)
	end

	local infoStr = format ("%d-%d", minLvl, maxLvl)

	local color = "|cffffffff"
	if RDX.PlFactionNum == faction then
		color = "|cff20ff20"
	elseif faction == 2 then
		color = "|cffffff00"
	elseif faction < 2 then
		color = "|cffff6060"
	end

	if minLvl == 0 then
		infoStr = "Any"
	end

	local a = RDXMAP.APIMap.GetWorldZone(mapId)
	
	if a and a.City then
		infoStr = "City"
		minLvl = -1
	end

	return color, infoStr .. " " .. mapId , minLvl
end

function RDXMAP.APIMap.GCMI_OVERRIDE(mapId)
    return mapId and RDXMAP.APIMap.GetWorldZone(mapId) and RDXMAP.APIMap.GetWorldZone(mapId).overrideMapWorldId or mapId
end

--------
-- Update all map data

function RDXMAP.APIMap.NewGetMapInfo()
    local mapName, textureWidth, textureHeight, isMicroDungeon, microDungeonName = GetMapInfo()
    if isMicroDungeon and microDungeonName then
        return microDungeonName, textureWidth, textureHeight, isMicroDungeon, microDungeonName
    end
    return mapName, textureWidth, textureHeight, isMicroDungeon
end	

--------
-- Get map name from id

function RDXMAP.APIMap.IdToName (mapId)
	return RDXMAP.MapIdToName[mapId] or "?";
end

--------
-- Get map id from name

function RDXMAP.APIMap.NameToId (mapName)
	return RDXMAP.MapNameToId[mapName] or 0;
end

-----------------------------------------------------------
-- Check
-----------------------------------------------------------


function RDXMAP.APIMap.IsNormalMap (mapId)
	local a = RDXMAP.MapWorldInfo[mapId]
	if a then
		return a.tp == 2
	end
end

--------
--
function RDXMAP.APIMap.IsOutlandMap (mapId)
	local a = RDXMAP.MapWorldInfo[mapId]
	if a then
		return a.tp == 2 and a.Cont == 3
	end
end

--------
--
function RDXMAP.APIMap.IsInstanceMap (mapId)
	local a = RDXMAP.MapWorldInfo[mapId]
	if a then
		return a.tp == 4
	end
end

--------
--
function RDXMAP.APIMap.IsBattleGroundMap (mapId)
	local a = RDXMAP.MapWorldInfo[mapId]
	if a then
		return a.tp == 5
	end
end

function RDXMAP.APIMap.IsMicroDungeon(mapId)
	-- Sigg not good
	local a = RDXMAP.MapWorldInfo[mapId]
	if a then
		return a.tp == 4
	end
end

function RDXMAP.APIMap.IsScenario(mapId)
	local a = RDXMAP.MapWorldInfo[mapId]
	if a then
		return a.tp == 6
	end
end

--------------------------------------

--------
-- Convert raw cont and zone to mapid
-- self: not used

function RDXMAP.APIMap.ConnectionUnpack (str)

--[[
	Format is (base 221 packed):

	1 byte flags Bit 0 = two-way, Bit 1 = Alliance, Bit 2 = Horde
	2 byte time,  0 = Instant (Portal)  1 = Normal connection  >1 = Some type of boat/zeppelin
	1 byte zone 1
	2 byte zone 1 location
	1 byte zone 2
	2 byte zone 2 location
	1 byte name 1 length
	name 1
	1 byte name 2 length
	name 2

	To choose icons to show you could search the string to work out what it is.
	Boat, Tram, Zeppelin, Portal
--]]

	local flags, ta, tb, z1, x1a, x1b, y1a, y1b, z2, x2a, x2b, y2a, y2b, name1len = strbyte (str, 1, 14)

	flags = flags - 35
	local conTime = (ta - 35) * 221 + tb - 35
	local mapId1 = RDXMAP.Zone2MapId[z1 - 35]
	local mapId2 = RDXMAP.Zone2MapId[z2 - 35]

--	local cont1 = RDXMAP.APIMap.IdToContZone (mapId1)
--	local cont2 = RDXMAP.APIMap.IdToContZone (mapId2)

	name1len = name1len - 35
	local name1 = name1len == 0 and "" or strsub (str, 15, 14 + name1len)
	local i = 15 + name1len
	local name2len = strbyte (str, i)
	local name2 = name2len == 0 and "" or strsub (str, i + 1, i + name2len)

	local x1 = ((x1a - 35) * 221 + x1b - 35) / 100
	local y1 = ((y1a - 35) * 221 + y1b - 35) / 100
	local x2 = ((x2a - 35) * 221 + x2b - 35) / 100
	local y2 = ((y2a - 35) * 221 + y2b - 35) / 100

	return flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2
end



--[[
function RDXMAP.Map:GetContFromPos (worldX, worldY)

	if worldY < -2050 then
		return 3
	end

	if worldX > 2200 then
		return 2
	end

	return 1
end
--]]

--------
-- Convert frame (top left) to zone positions
--[[
function RDXMAP.Map:FramePosToZonePos (x, y)
	x = self.ZonePosX + (x - self.PadX - self.MapW / 2) / 10.02 / self.Scale
	y = self.ZonePosY + (y - self.TitleH - self.MapH / 2) / 6.68 / self.Scale
	return x, y
end
--]]