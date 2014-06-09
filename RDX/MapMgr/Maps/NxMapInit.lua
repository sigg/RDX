
local titi = {};


--------
-- Init map tables

function NxMap.InitTables()

	local Nx = Nx

--[[
	NxData.NXMapDebugZones1 = { GetMapZones (1) }
	NxData.NXMapDebugZones2 = { GetMapZones (2) }
	NxData.NXMapDebugZones3 = { GetMapZones (3) }
	NxData.NXMapDebugZones4 = { GetMapZones (4) }
	VFL.vprint ("zone cap!!!!!")
--]]

	local worldInfo = NxMap.MapWorldInfo

	RDXMAP.MapNameToId = {}
	RDXMAP.MapIdToName = {}
	RDXMAP.MapOverlayToMapId = {}

	-- Get Blizzard's alphabetical set of names

	--V403
	-- GetMapZones different french, german
	RDXMAP.MapNames = {
		{ GetMapZones (1) },
		{ GetMapZones (2) },
		{ GetMapZones (3) },
		{ GetMapZones (4) },
		{ GetMapZones (5) },
		{ GetMapZones (6) },
	}

	tinsert (RDXMAP.MapNames[2], NXlMapNames["Plaguelands: The Scarlet Enclave"] or "Plaguelands: The Scarlet Enclave")
	tinsert (RDXMAP.MapNames[2], NXlMapNames["Gilneas"] or "Gilneas")
	tinsert (RDXMAP.MapNames[2], NXlMapNames["Gilneas City"] or "Gilneas City")

	for mi, mapName in pairs (RDXMAP.MapNames[2]) do
		for mi2, mapName2 in pairs (RDXMAP.MapNames[2]) do
			if mapName == mapName2 and mi ~= mi2 then			-- Duplicate name? (Gilneas, Ruins of Gilneas (EU))
				RDXMAP.MapNames[2][mi2] = mapName .. "2"			-- Hack it!
--				VFL.vprint ("Dup zone name %s", mapName)
				break
			end
		end
	end

	local BGNames = {}
	RDXMAP.MapNames[9] = BGNames

	for n = 1, 999 do
		local winfo = worldInfo[9000 + n]
		if not winfo then
			break
		end

		BGNames[n] = NXlMapNames[winfo.Name] or winfo.Name
	end

--	NxMap.Zones[152]="Icecrown: The Forge of Souls!80!80!3!5!128!####!5"


	-- Set overlays

	NxMap.ZoneOverlays["lakewintergrasp"]["lakewintergrasp"] = "0,0,1024,768"

	-- Support maps with multiple levels

	RDXMAP.MapSubNames = NXlMapSubNames

	tinsert (RDXMAP.MapNames[4], "Molten Front")
	tinsert (RDXMAP.MapNames[4], "Dalaran Underbelly")
	tinsert (RDXMAP.MapNames[5], "Darkmoon Island")
    tinsert (RDXMAP.MapNames[6], "The Wandering Isle")    
	-- Setup mapping to and from Blizzard cont/zone to Map Id
	-- and overlay name to map id

	--Nx.ContCnt = 6
	continentNums = { 1, 2, 3, 4, 5, 6, 9 }

	Nx.CZ2Id = {}

	for _, ci in ipairs (continentNums) do

		local z2id = {}
		Nx.CZ2Id[ci] = z2id

		for n = 1, 999 do

			local mapId = ci * 1000 + n
			local winfo = worldInfo[mapId]
			if not winfo then
				break
			end

			if Nx.PlFactionNum == 0 and winfo.QAchievementIdA then
				winfo.QAchievementId = winfo.QAchievementIdA				-- Copy Ally Id to generic Id
			end
			if Nx.PlFactionNum == 1 and winfo.QAchievementIdH then
				winfo.QAchievementId = winfo.QAchievementIdH				-- Copy Horde Id to generic Id
			end

			local locName = NXlMapNames[winfo.Name] or winfo.Name

			for i, name in ipairs (RDXMAP.MapNames[ci]) do
				if name == locName then
--					VFL.vprint ("%s #%s = %s", name, i, mapId)
					z2id[i] = mapId
					break
				end
			end
		end
       
		for k, v in ipairs (Nx.CZ2Id[ci]) do
            
			worldInfo[v].Cont = ci
			worldInfo[v].Zone = k

			local ov = worldInfo[v].Overlay
			if ov then
				RDXMAP.MapOverlayToMapId[ov] = v
			end
		end
	end

	for n = 1, RDXMAP.ContCnt do
		Nx.CZ2Id[n][0] = n * 1000
	end

	-- Init for getting map id to and from name

	for _, ci in ipairs (continentNums) do

		for mi, mapName in pairs (RDXMAP.MapNames[ci]) do

--			if ci == 2 then
--				VFL.vprint ("Map %s %s", mapName, Nx.CZ2Id[ci][mi] or "nil")
--			end
			local mid = Nx.CZ2Id[ci][mi]

			if RDXMAP.MapNameToId[mapName] then
				VFL.vprint ("Dup map name: %s (%s %s)", mapName, ci, mi)
				RDXMAP.MapNameToId[mapName .. "2"] = mid
			else
				RDXMAP.MapNameToId[mapName] = mid
			end

			if not mid then
				VFL.vprint ("Unknown map name: %s (%s %s)", mapName, ci, mi)
			else
				RDXMAP.MapIdToName[mid] = mapName
			end
		end
	end

	-- Localize the zone name

	for id, v in ipairs (NxMap.Zones) do

		local i = strfind (v, "!")
		local name = strsub (v, 1, i - 1)
		local data = strsub (v, i + 1)

		local locName = NXlMapNames[name]
		if locName then
			NxMap.Zones[id] = locName .. "!" .. data
		end
	end

	-- Move MapGenAreas to MapWorldInfo (scale, x, y, overlay)

	for id, area in pairs (NxMap.MapGenAreas) do

		local s = NxMap.Zones[id]				
		local name = strsplit ("!", s)		
		local mapId = RDXMAP.MapNameToId[name]

		if not mapId then
			VFL.vprint ("Err MapGenAreas %s", name)

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

	NxMap.MapGenAreas = nil

	-- Make world coords for each zone

	for _, ci in ipairs (continentNums) do

		local info = NxMap.MapInfo[ci]
		local cx = info.X
		local cy = info.Y		
--		VFL.vprint ("WC %s %s %s", ci, cx, cy)

		for n = 0, 999 do			
			local winfo = worldInfo[ci * 1000 + n]						
			if not winfo then
				break
			end			
-- LANG TEST			
--			VFL.vprint(ci * 1000 + n) 
			winfo[4] = cx + winfo[2]
			winfo[5] = cy + winfo[3]
		end
	end			
	
	
	--

	for id, v in pairs (NxMap.Zones) do

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

--			VFL.vprint ("Inst %s %d", name, id)

			local entryZone = NxMap.Zones[tonumber (entryId)]			
			local ename, _, _, _, cont = strsplit ("!", entryZone)
			if cont == "7" then
				cont = 4
			end
			if cont == "8" then
				cont = 5
			end
			local mid = cont * 1000 + 10000 + id

			RDXMAP.MapNameToId[name] = mid
			RDXMAP.MapIdToName[mid] = name

			local emid = RDXMAP.MapNameToId[ename]

			local ex, ey = RDXMAP.UnpackLocPt (entryPos)

			if NxMap.MapWorldInfo[mid] then			-- Adjustment exists?
				ex = ex + NxMap.MapWorldInfo[mid][2]
				ey = ey + NxMap.MapWorldInfo[mid][3]
			end

--			VFL.vprint ("Inst %s %s, %s %s %f %f", name, mid, ename, emid or "nil", ex, ey)

			local x, y = RDXMAP.APIMap.GetWorldPos (emid, ex, ey)

--			VFL.vprint ("Inst %s %d, %d %f %f", name, mid, emid, x, y)

			local ewinfo = NxMap.MapWorldInfo[emid]
			if not ewinfo then
--				VFL.vprint ("? %s %s", ename, emid or "nil")
			end

			local winfo = {}

			winfo.EntryMId = emid
			winfo[1] = 1002 / 25600 --ewinfo[1]		-- Scale
			winfo[2] = x				-- X
			winfo[3] = y				-- Y
			winfo[4] = x				-- X
			winfo[5] = y				-- Y
			NxMap.MapWorldInfo[mid] = winfo

			--local aa = {};
			--titi[mid] = aa;
			--aa.Name = toto[id];
			--aa.EntryMId = toto[tonumber (entryId)];
			--aa.minLvl = minLvl; 
			--aa.maxLvl = maxLvl;
			--aa[2] = ex;
			--aa[3] = ey;
			--table.sort(titi,function(x1,x2) return tonumber(x1.minLvl) < tonumber(x2.minLvl); end);
		end
	end
--	VFL.vprint("debug: ")


	

	--	DEBUG for Jamie

	NxMap.ZoneConnections = NxMap["ZoneConnections"] or NxMap.ZoneConnections	-- Copy unmunged data to munged data

	-- Init zone connections

	for ci = 1, RDXMAP.ContCnt do
		for n = 0, 999 do

			local mapId = ci * 1000 + n
			local winfo = worldInfo[mapId]
			if not winfo then
				break
			end
			local cons = {}
			winfo.Connections = cons

			for _, str in ipairs (NxMap.ZoneConnections) do

				local flags, ta, tb, z1, x1a, x1b, y1a, y1b, z2, x2a, x2b, y2a, y2b, name1len = strbyte (str, 1, 14)

				flags = flags - 35
				local conTime = (ta - 35) * 221 + tb - 35
				local mapId1 = RDXMAP.Zone2MapId[z1 - 35]
				local mapId2 = RDXMAP.Zone2MapId[z2 - 35]
--[[
				if mapId1 == 1017 or mapId2 == 1017 or mapId1 == 1028 or mapId2 == 1028 then
					VFL.vprint ("%s %d %d to %s %d %d, %s f%x",
							RDXMAP.MapIdToName[mapId1] or mapId1, ((x1a - 35) * 221 + x1b - 35) / 100, ((y1a - 35) * 221 + y1b - 35) / 100,
							RDXMAP.MapIdToName[mapId2] or mapId2, ((x2a - 35) * 221 + x2b - 35) / 100, ((y2a - 35) * 221 + y2b - 35) / 100,
							conTime, flags)
				end
--]]
				if not (mapId1 and mapId2) then
--					VFL.vprint ("zone conn err %s to %s", z1 - 35, z2 - 35)
					conTime = 0
				end

				if conTime == 1 and (mapId == mapId1 or (mapId == mapId2 and bit.band (flags, 1) == 1)) then

					local cont1 = RDXMAP.APIMap.IdToContZone (mapId1)
					local cont2 = RDXMAP.APIMap.IdToContZone (mapId2)

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
							VFL.vprint ("%s %d %d to %s %d %d, %s, %s %s",
									RDXMAP.MapIdToName[mapId1] or mapId1, x1, y1,
									RDXMAP.MapIdToName[mapId2] or mapId2, x2, y2,
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

							x1, y1 = RDXMAP.APIMap.GetWorldPos (mapId1, x1, y1)
							x2, y2 = RDXMAP.APIMap.GetWorldPos (mapId2, x2, y2)

							con.StartMapId = mapId1
							con.StartX = x1
							con.StartY = y1
							con.EndMapId = mapId2
							con.EndX = x2
							con.EndY = y2
							con.Dist = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ .5
						end

--					else
--						VFL.vprint ("%s to %s", mapId1, mapId2)
					end
				end
			end
		end
	end
end

function RDXGtiti()
	RDXG.titi = titi;
end



