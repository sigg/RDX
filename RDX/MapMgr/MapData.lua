------------------------------------------
-- Map table access

-- continents
-- zones
-- zoneoverlays


--------
-- Init map tables

local function InitTables()

	--local Nx = Nx

--[[
	NxData.NXMapDebugZones1 = { GetMapZones (1) }
	NxData.NXMapDebugZones2 = { GetMapZones (2) }
	NxData.NXMapDebugZones3 = { GetMapZones (3) }
	NxData.NXMapDebugZones4 = { GetMapZones (4) }
	Nx.prt ("zone cap!!!!!")
--]]

	local plFaction = UnitFactionGroup ("player")
	plFaction = strsub (plFaction, 1, 1)
	local PlFactionNum = plFaction == "A" and 0 or 1
	local PlFactionShort = plFaction == "A" and "Ally" or "Horde"

	local worldInfo = Map.MapWorldInfo

	local MapNameToId = {}
	local MapIdToName = {}
	local MapIdToZone = {}
	local ZoneToMapId = {}
	local MapOverlayToMapId = {}

	-- Get Blizzard's alphabetical set of names

	local MapNames = {
		{ GetMapZones (1) },
		{ GetMapZones (2) },
		{ GetMapZones (3) },
		{ GetMapZones (4) },
		{ GetMapZones (5) },
		{ GetMapZones (6) },
	}

	tinsert (MapNames[2], NXlMapNames["Plaguelands: The Scarlet Enclave"] or "Plaguelands: The Scarlet Enclave")
	tinsert (MapNames[2], NXlMapNames["Gilneas"] or "Gilneas")
	tinsert (MapNames[2], NXlMapNames["Gilneas City"] or "Gilneas City")

	-- recherche de doublons
	for mi, mapName in pairs (MapNames[2]) do
		for mi2, mapName2 in pairs (MapNames[2]) do
			if mapName == mapName2 and mi ~= mi2 then			-- Duplicate name? (Gilneas, Ruins of Gilneas (EU))
				MapNames[2][mi2] = mapName .. "2"			-- Hack it!
--				Nx.prt ("Dup zone name %s", mapName)
				break
			end
		end
	end

	local BGNames = {}
	MapNames[9] = BGNames

	for n = 1, 999 do
		local winfo = worldInfo[9000 + n]
		if not winfo then
			break
		end

		BGNames[n] = NXlMapNames[winfo.Name] or winfo.Name
	end

--	Nx.Zones[152]="Icecrown: The Forge of Souls!80!80!3!5!128!####!5"


	-- Set overlays

	ZoneOverlays["lakewintergrasp"]["lakewintergrasp"] = "0,0,1024,768"

	-- Support maps with multiple levels
	self.MapSubNames = NXlMapSubNames

	tinsert(MapNames[4], "Molten Front")
	tinsert(MapNames[4], "Dalaran Underbelly")
	tinsert(MapNames[5], "Darkmoon Faire")
    tinsert(MapNames[6], "The Wandering Isle")    
	-- Setup mapping to and from Blizzard cont/zone to Map Id
	-- and overlay name to map id

	local ContCnt = 6
	continentNums = { 1, 2, 3, 4, 5, 6, 9 }

	-- CZ2Id continents[ci] = continent
	-- z2id  continent[bzi] = czi
	-- ci = continent id
	-- bzi = blizzard zone id
	-- czi = carbonite zone id
	
	local CZ2Id = {}

	for _, ci in ipairs (continentNums) do

		local z2id = {}
		CZ2Id[ci] = z2id

		for n = 1, 999 do
			local czi = ci * 1000 + n
			local winfo = worldInfo[czi]
			if not winfo then
				break
			end

			if PlFactionNum == 0 and winfo.QAchievementIdA then
				winfo.QAchievementId = winfo.QAchievementIdA				-- Copy Ally Id to generic Id
			end
			if PlFactionNum == 1 and winfo.QAchievementIdH then
				winfo.QAchievementId = winfo.QAchievementIdH				-- Copy Horde Id to generic Id
			end

			local locName = NXlMapNames[winfo.Name] or winfo.Name

			for i, name in ipairs (MapNames[ci]) do
				if name == locName then
--					VFL.vprint("%s #%s = %s", name, i, czi)
					z2id[i] = czi
					break
				end
			end
		end
		
		-- ajoute Cont + zone à worldinfo.
		for k, v in ipairs (CZ2Id[ci]) do
            
			worldInfo[v].Cont = ci
			worldInfo[v].Zone = k

			local ov = worldInfo[v].Overlay
			if ov then
				MapOverlayToMapId[ov] = v
			end
		end
	end

	-- add zone init
	for n = 1, ContCnt do
		CZ2Id[n][0] = n * 1000
	end

	-- Init for getting map id to and from name

	for _, ci in ipairs (continentNums) do

		for mi, mapName in pairs (MapNames[ci]) do

--			if ci == 2 then
--				Nx.prt ("Map %s %s", mapName, self.CZ2Id[ci][mi] or "nil")
--			end
			local mid = CZ2Id[ci][mi]

			if Nx.MapNameToId[mapName] then
				Nx.prt ("Dup map name: %s (%s %s)", mapName, ci, mi)
				Nx.MapNameToId[mapName .. "2"] = mid
			else
				Nx.MapNameToId[mapName] = mid
			end

			if not mid then
				Nx.prt ("Unknown map name: %s (%s %s)", mapName, ci, mi)
			else
				Nx.MapIdToName[mid] = mapName
			end
		end
	end

	-- Localize the zone name

	for id, v in ipairs (Nx.Zones) do

		local i = strfind (v, "!")
		local name = strsub (v, 1, i - 1)
		local data = strsub (v, i + 1)

		local locName = NXlMapNames[name]
		if locName then
			Nx.Zones[id] = locName .. "!" .. data
		end
	end

	-- Move MapGenAreas to MapWorldInfo (scale, x, y, overlay)

	for id, area in pairs (Nx.Map.MapGenAreas) do

		local s = Nx.Zones[id]
		local name = strsplit ("!", s)
		local mapId = Nx.MapNameToId[name]

		if not mapId then
			Nx.prt ("Err MapGenAreas %s", name)

		else

			local cont = floor (mapId / 1000)
			if cont <= 2 or cont == 5 then

				local wi = worldInfo[mapId]
				wi[1] = area[1]				-- Scale
				wi[2] = area[2]				-- X
				wi[3] = area[3]				-- Y

				if wi.XOff then	-- Had pos offset?
					wi[2] = wi[2] + wi.XOff	-- X
					wi[3] = wi[3] + wi.YOff	-- Y
					wi.XOff = nil
					wi.YOff = nil
				end

				wi.Overlay = area[4]
			end
		end
	end

	Nx.Map.MapGenAreas = nil

	-- Make world coords for each zone

	for _, ci in ipairs (continentNums) do

		local info = self.MapInfo[ci]
		local cx = info.X
		local cy = info.Y

--		Nx.prt ("WC %s %s %s", ci, cx, cy)

		for n = 0, 999 do
			local winfo = worldInfo[ci * 1000 + n]			
			if not winfo then
				break
			end			
			winfo[4] = cx + winfo[2]
			winfo[5] = cy + winfo[3]
		end
	end			
	--

	for id, v in pairs (Nx.Zones) do

		local name, minLvl, maxLvl, faction, cont, entryId, entryPos = strsplit ("!", v)

		-- Faction:
		-- 0 Alliance
		-- 1 Horde
		-- 2 Contested
		-- 3 Instance
		-- 4 Unknown

		-- Continent:
		-- 1 Kalimdor
		-- 2 EasternKingdoms
		-- 3 Outland
		-- 4 Battleground
		-- 5 Dungeon
		-- 6 Raid					-- OLD
		-- 7 Northrend
		-- 8 The Maelstrom
		-- 9 Unknown

		if faction == "3" and cont == "5" then		-- Instance

			assert (entryId and entryPos)

			if entryId == "0" then
				entryId = "125"
			end

--[[
			local i = strfind (name, ": ")
			if i then
				name = strsub (name, i + 2)
			end
--]]

--			Nx.prt ("Inst %s %d", name, id)

			local entryZone = Nx.Zones[tonumber (entryId)]
			local ename, _, _, _, cont = strsplit ("!", entryZone)
			if cont == "7" then
				cont = 4
			end
			if cont == "8" then
				cont = 5
			end
			local mid = cont * 1000 + 10000 + id

			Nx.MapNameToId[name] = mid
			Nx.MapIdToName[mid] = name

			local emid = Nx.MapNameToId[ename]

			local ex, ey = Nx.Quest:UnpackLocPt (entryPos)

			if self.MapWorldInfo[mid] then			-- Adjustment exists?
				ex = ex + self.MapWorldInfo[mid][2]
				ey = ey + self.MapWorldInfo[mid][3]
			end

--			Nx.prt ("Inst %s %s, %s %s %f %f", name, mid, ename, emid or "nil", ex, ey)

			local x, y = self:GetWorldPos (emid, ex, ey)

--			Nx.prt ("Inst %s %d, %d %f %f", name, mid, emid, x, y)

			local ewinfo = self.MapWorldInfo[emid]
			if not ewinfo then
--				Nx.prt ("? %s %s", ename, emid or "nil")
			end

			local winfo = {}

			winfo.EntryMId = emid
			winfo[1] = 1002 / 25600 --ewinfo[1]		-- Scale
			winfo[2] = x				-- X
			winfo[3] = y				-- Y
			winfo[4] = x				-- X
			winfo[5] = y				-- Y
			self.MapWorldInfo[mid] = winfo
		end
	end
--	Nx.prt("debug: ")
	-- Init NxzoneToMapId, MapIdToNxzone

	for id, v in ipairs (Nx.Zones) do

		local name, minLvl, maxLvl, faction = strsplit ("!", v)
--[[
		if id ~= 146 then		-- The Scarlet Enclave needs to keep the :
			local i = strfind (name, ": ")
			if i then
				name = strsub (name, i + 2)
			end
		end
--]]
		local mapId = Nx.MapNameToId[name]

		if mapId then

			if not Nx.MapIdToNxzone[mapId] then
				Nx.MapIdToNxzone[mapId] = id
			else
--				Nx.prt ("Map Init %s %s dup %s", name, id, Nx.MapIdToNxzone[mapId])
			end

			self.NxzoneToMapId[id] = mapId
		else
--			Nx.prt ("Inst %s %d", name, id)
		end
	end

	-- Init AId2Id (Blizzard area id to map id and back)

	Nx.AIdToId = {}
	Nx.IdToAId = {}

	for aid, zid in pairs (Nx.ID2Zone) do
		if zid ~= 0 then
			local id = self.NxzoneToMapId[zid]
			Nx.AIdToId[aid] = id
			if id then
				Nx.IdToAId[id] = aid
			end
--			if not id then
--				Nx.prt ("AId %s (%s) = %s", aid, zid, id or "nil")
--			end

		end
	end

	-- Test
--[[

	Nx.prt ("Test Map Id")

	for k, v in ipairs (Nx.Zones) do

		if k ~= 16 and k ~= 34 and k ~= 102 then
			local mapId = self.NxzoneToMapId[k]
			assert (Nx.MapIdToNxzone[mapId] == k)
		end
	end
--]]

	-- Init instance entries

	for k, v in ipairs (Nx.Zones) do

		local name, minLvl, maxLvl, faction, cont, entryId = strsplit ("!", v)

		if faction ~= "3" then		-- Not instance

			if entryId and entryId ~= "" then
				self.NxzoneToMapId[k] = self.NxzoneToMapId[tonumber (entryId)]
			end
		end
	end

	--	DEBUG for Jamie

	Nx.ZoneConnections = Nx["ZoneConnections"] or Nx.ZoneConnections	-- Copy unmunged data to munged data

	-- Init zone connections

	for ci = 1, self.ContCnt do
		for n = 0, 999 do

			local mapId = ci * 1000 + n
			local winfo = worldInfo[mapId]
			if not winfo then
				break
			end
			local cons = {}
			winfo.Connections = cons

			for _, str in ipairs (Nx.ZoneConnections) do

				local flags, ta, tb, z1, x1a, x1b, y1a, y1b, z2, x2a, x2b, y2a, y2b, name1len = strbyte (str, 1, 14)

				flags = flags - 35
				local conTime = (ta - 35) * 221 + tb - 35
				local mapId1 = self.NxzoneToMapId[z1 - 35]
				local mapId2 = self.NxzoneToMapId[z2 - 35]
--[[
				if mapId1 == 1017 or mapId2 == 1017 or mapId1 == 1028 or mapId2 == 1028 then
					Nx.prt ("%s %d %d to %s %d %d, %s f%x",
							Nx.MapIdToName[mapId1] or mapId1, ((x1a - 35) * 221 + x1b - 35) / 100, ((y1a - 35) * 221 + y1b - 35) / 100,
							Nx.MapIdToName[mapId2] or mapId2, ((x2a - 35) * 221 + x2b - 35) / 100, ((y2a - 35) * 221 + y2b - 35) / 100,
							conTime, flags)
				end
--]]
				if not (mapId1 and mapId2) then
--					Nx.prt ("zone conn err %s to %s", z1 - 35, z2 - 35)
					conTime = 0
				end

				if conTime == 1 and (mapId == mapId1 or (mapId == mapId2 and bit.band (flags, 1) == 1)) then

					local cont1 = self:IdToContZone (mapId1)
					local cont2 = self:IdToContZone (mapId2)

					if cont1 == cont2 then

						name1len = name1len - 35
						local name1 = name1len == 0 and "" or strsub (str, 15, 14 + name1len)
						local i = 15 + name1len
						local name2len = strbyte (str, i)						
						local name2 = name2len == 0 and "" or strsub (str, i + 1, i + name2len)

						local x1 = ((x1a - 35) * 221 + x1b - 35) / 100
						local y1 = ((y1a - 35) * 221 + y1b - 35) / 100
						local x2 = ((x2a - 35) * 221 + x2b - 35) / 100
						local y2 = ((y2a - 35) * 221 + y2b - 35) / 100
--[[
						if mapId1 == 1017 or mapId2 == 1017 or mapId1 == 1028 or mapId2 == 1028 then
							Nx.prt ("%s %d %d to %s %d %d, %s, %s %s",
									Nx.MapIdToName[mapId1] or mapId1, x1, y1,
									Nx.MapIdToName[mapId2] or mapId2, x2, y2,
									conTime, name1, name2)
						end
--]]
						if mapId == mapId2 then		-- Swap?
							mapId1, mapId2 = mapId2, mapId1
							x1, y1, x2, y2 = x2, y2, x1, y1
						end

						local zcons = cons[mapId2] or {}
						cons[mapId2] = zcons

						if x1 ~= 0 and y1 ~= 0 then	-- Specific connection? Else connects anywhere

							local con = {}
							tinsert (zcons, con)

							x1, y1 = self:GetWorldPos (mapId1, x1, y1)
							x2, y2 = self:GetWorldPos (mapId2, x2, y2)

							con.StartMapId = mapId1
							con.StartX = x1
							con.StartY = y1
							con.EndMapId = mapId2
							con.EndX = x2
							con.EndY = y2
							con.Dist = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ .5
						end

--					else
--						Nx.prt ("%s to %s", mapId1, mapId2)
					end
				end
			end
		end
	end
end













