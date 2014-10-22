
RDXMAP.APIMap = {};

local myunit;
RDXEvents:Bind("INIT_POST", nil, function() myunit = RDXDAL.GetMyUnit(); end);	

-- Get world zone from mapId
function RDXMAP.APIMap.MapWorldInfo()
	return RDXMAP.MapWorldInfo
end

-- Get world zone from mapId
function RDXMAP.APIMap.GetWorldZone (mapId)
	return RDXMAP.MapWorldInfo[mapId]
end

--------
-- Get world info for a continent or zone
-- (cont #, zone #)
function RDXMAP.APIMap.GetWorldZoneInfo (mapId)
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if not winfo or not winfo.x then 
		return "unknown", 0, 0, 1, 1.5
	end
	local scale = winfo.s * 100
	return winfo.localname or winfo.Name, winfo.x, winfo.y, scale, scale / 1.5
end

--------
-- Get map short name (only BGs have)
function RDXMAP.APIMap.GetShortName (mapId)
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if winfo then return winfo.Short end 
end

--------
-- Get description (color) that goes with a map nane

function RDXMAP.APIMap.GetMapNameDesc (mapId)

--	VFL.vprint ("MapId %s", mapId)
	local minLvl, maxLvl, faction
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if winfo then
		minLvl = winfo.minLvl or 0;
		maxLvl = winfo.maxLvl or 0;
		faction = winfo.faction;
	else
		minLvl = 0;
		maxLvl = 0;
		faction = 1;
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
	
	if winfo and winfo.City then
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


function RDXMAP.APIMap.GetWorldPos (mapId, mapX, mapY)
--	self.GetWorldPosCnt = (self.GetWorldPosCnt or 0) + 1
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if winfo and winfo.x then
		local scale = winfo.s
		return	winfo.x + mapX * scale, winfo.y + mapY * scale / 1.5
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
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if winfo and winfo.x then
		local scale = winfo.s		
		return	(worldX - winfo.x) / scale, (worldY - winfo.y) / scale * 1.5
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
	return myunit.mapId
end

--------
-- Get the current selected map id
-- Do not call SetMapToCurrentZone() here or crash
function RDXMAP.APIMap.GetCurrentMapId()
	return GetCurrentMapAreaID()
end

function RDXMAP.APIMap.GetContinent(mapId)
	local info = RDXMAP.APIMap.GetWorldZone(mapId) --
	if info then
		return info.c
	end
end

function RDXMAP.APIMap.IdToContZone(mapId)
	local info = RDXMAP.APIMap.GetWorldZone(mapId) --
	if info then
		return info.Cont or 9, mapId
	else
		--VFL.print("unknow mapid " .. mapId);
		return 0, mapId
	end
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
--	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
--	if not winfo then --
--		VFL.vprint ("GetWorldZoneScale %s %s %s", mapId)
--	end

--	return (not winfo and 10.02) or winfo[1] --
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if winfo then
		return winfo.s
	end 
end

--------
-- Get map name from id
function RDXMAP.APIMap.IdToName (mapId)
	return RDXMAP.MapIdToName[mapId] or "?";
end

--------
-- Get map id from name

function RDXMAP.APIMap.NameToId (mapName, contId)
	return RDXMAP.MapNameToId[contId][mapName] or 0;
end

-----------------------------------------------------------
-- Check
-----------------------------------------------------------

function RDXMAP.APIMap.IsContinentMap (mapId)
	local a = RDXMAP.APIMap.GetWorldZone(mapId)
	if a then
		return a.class == "c"
	end
end

function RDXMAP.APIMap.IsZoneMap (mapId)
	local a = RDXMAP.APIMap.GetWorldZone(mapId)
	if a then
		return a.class == "z"
	end
end
--
function RDXMAP.APIMap.IsOutlandMap (mapId)
	local a = RDXMAP.APIMap.GetWorldZone(mapId)
	if a then
		return a.class == "z" and a.c == 466
	end
end

--------
--
function RDXMAP.APIMap.IsInstanceMap (mapId)
	local a = RDXMAP.APIMap.GetWorldZone(mapId)
	if a then
		return a.tp == 4
	end
end

--------
--
function RDXMAP.APIMap.IsBattleGroundMap (mapId)
	local a = RDXMAP.APIMap.GetWorldZone(mapId)
	if a then
		return a.tp == 5
	end
end

function RDXMAP.APIMap.IsMicroDungeon(mapId)
	return myunit.isIndoor
end

function RDXMAP.APIMap.IsScenario(mapId)
	local a = RDXMAP.APIMap.GetWorldZone(mapId)
	if a then
		return a.tp == 6
	end
end

--------------------------------------

--------
-- Get minimap info for map
-- (map id)
-- ret: table, x, y

function RDXMAP.APIMap.GetMiniInfo (mapId)

	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	--if not winfo then VFL.print(mapId); return; end
	local id = winfo.MId

	if not id then id = winfo.c; end
	if not id then return; end

	local t = RDXMAP.MiniMapBlks[id]

	if not t then		-- "Isle of Quel'Danas"??

--		if RDXG.DebugMap then
--			VFL.vprint ("GetMiniInfo: missing %s", id)
--		end
		VFL.print("NxMap.MiniMapBlks error mapId " .. mapId);
		return
	end

	return t, t[5], t[6]
end

--------
-- Get minimap block file name (256x256 texture)

function RDXMAP.APIMap.GetMiniBlkName (miniT, x, y)

	local off = x * 100 + y

--	VFL.vprintCtrl ("%s, %s, %s = %s", x, y, off, off + miniT[2])

	--V4

	local v = miniT[1][off + miniT[2]]

	if v then

		if #v > 0 then
			return format ("%s\\noLiquid_map%02d_%02d", miniT[7], x + miniT[3], y + miniT[4])
		end		
		if (strfind(miniT[7],"HawaiiMainLand")) then			
			local hasFac = false
			for factionIndex = 1, GetNumFactions() do
				local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)				
				if (name == "Operation: Shieldwall") or (name == "Dominance Offensive") then --localized name
					hasFac = true
				end
			end
			if (hasFac) then
				if ((x + miniT[3] == 33) or (x + miniT[3] == 34)) and ((y + miniT[4] == 33) or (y + miniT[4] == 34)) then
					return format("World\\Minimaps\\AllianceBeachDailyArea\\map%02d_%02d", x + miniT[3], y + miniT[4])
				end
				if ((x + miniT[3] == 27) or (x + miniT[3] == 28)) and ((y + miniT[4] == 35) or (y + miniT[4] == 36) or (y + miniT[4] == 37) or (y + miniT[4] == 38)) then
					return format("World\\Minimaps\\HordeBeachDailyArea\\map%02d_%02d", x + miniT[3], y + miniT[4])
				end
			elseif (x + miniT[3] >= 18) and (x + miniT[3] <= 25) and (y + miniT[4] >= 17) and (y + miniT[4] <= 24) then
				return format("World\\Minimaps\\MoguIslandDailyArea\\map%02d_%02d",x+miniT[3], y + miniT[4]-2)
			else
				return format ("%s\\map%02d_%02d", miniT[7], x + miniT[3], y + miniT[4])
			end
		else
			return format ("%s\\map%02d_%02d", miniT[7], x + miniT[3], y + miniT[4])
		end
	end
end

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