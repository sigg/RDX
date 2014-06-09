
--------
-- Init map tables

function RDXMAP.InitTables()

	--local Nx = Nx

--[[
	NxData.NXMapDebugZones1 = { GetMapZones (1) }
	NxData.NXMapDebugZones2 = { GetMapZones (2) }
	NxData.NXMapDebugZones3 = { GetMapZones (3) }
	NxData.NXMapDebugZones4 = { GetMapZones (4) }
--]]

	local worldInfo = RDXMAP.MapWorldInfo

	RDXMAP.MapNameToId = {}
	RDXMAP.MapIdToName = {}
	RDXMAP.mapIdToCarbId = {}
	RDXMAP.carbIdToMapId = {}
	--RDXMAP.MapIdToNxzone = {}
	--RDXMAP.NxzoneToMapId = {}
	RDXMAP.MapOverlayToMapId = {}
	
	RDXMAP.MapInfo = {}
	
	for mapid, winfo in pairs (worldInfo) do
		if winfo.class == "w" and winfo.id and not RDXMAP.MapInfo[winfo.id] then
			winfo.mapid = mapid;
			RDXMAP.MapInfo[winfo.id] = winfo;
		end
	end
	
	for id, area in pairs (RDXMAP.MapGenAreas) do

		local winfo = worldInfo[id]
		if winfo then
			winfo[1] = area[1]				-- Scale
			winfo[2] = area[2]				-- X
			winfo[3] = area[3]				-- Y

			if winfo.XOff then	-- Had pos offset?
				winfo[2] = winfo[2] + winfo.XOff	-- X
				winfo[3] = winfo[3] + winfo.YOff	-- Y
				winfo.XOff = nil
				winfo.YOff = nil
			end

			winfo.Overlay = area[4]
		else
			VFL.print("InitTables MapGenAreas mapid unknown " .. id)
		end
	end
	--RDXMAP.MapGenAreas = nil;
	
	local info, cx, cy, scale

	for mapid, winfo in pairs (worldInfo) do
		winfo.localname = GetMapNameByID(mapid);
		if not winfo.localname then
			local name;
			if winfo.aa then 
				name = winfo.Name .. winfo.aa
			else
				name = winfo.Name
			end
			--VFL.print("InitTables no localname " .. mapid)
			if not RDXMAP.MapNameToId[name] then
				RDXMAP.MapNameToId[name] = mapid;
			else
				VFL.print("InitTables double name " .. name .. " mapid " .. mapid)
				VFL.print("InitTables double name " .. name .. " mapid " .. RDXMAP.MapNameToId[name])
				--RDXMAP.MapNameToId[winfo.Name] = nil; -- clear so the engine will use mapid
			end
			RDXMAP.MapIdToName[mapid] = name;
		else
			local name;
			if winfo.aa then 
				name = winfo.localname .. winfo.aa
			else
				name = winfo.localname
			end
			if not RDXMAP.MapNameToId[name] then
				RDXMAP.MapNameToId[name] = mapid;
			else
				VFL.print("InitTables double name " .. name .. " mapid " .. mapid)
				VFL.print("InitTables double name " .. name .. " mapid " .. RDXMAP.MapNameToId[name])
				--RDXMAP.MapNameToId[winfo.localname] = nil; -- clear so the engine will use mapid
			end
			RDXMAP.MapIdToName[mapid] = name;
		end
		if winfo.oldid then
			RDXMAP.carbIdToMapId[winfo.oldid] = mapid
		end
		
		--if RDX.PlFactionNum == 0 and winfo.QAchievementIdA then
		--	winfo.QAchievementId = winfo.QAchievementIdA				-- Copy Ally Id to generic Id
		--end
		--if RDX.PlFactionNum == 1 and winfo.QAchievementIdH then
		--	winfo.QAchievementId = winfo.QAchievementIdH				-- Copy Horde Id to generic Id
		--end
		
		-- Overlay
		local ov = winfo.Overlay
		if ov then
			RDXMAP.MapOverlayToMapId[ov] = mapid;
		end
		
		-- World coord for zone
		if winfo.Cont then --zone
			info = RDXMAP.MapInfo[winfo.Cont]
			cx = info.X
			cy = info.Y
			if winfo[2] then winfo[4] = cx + winfo[2] else VFL.print("error 2 " .. mapid); end
			if winfo[3] then winfo[5] = cy + winfo[3] else VFL.print("error 3 " .. mapid); end
			
		--elseif winfo.entryMid then --instance
		--	info = worldInfo[winfo.entryMid]
		--	if info then
		--		scale = info[1]
		--		winfo[1] = 1002 / 25600 
		--		winfo[4] = info[4] + winfo[2] * scale
		--		winfo[5] = info[5] + winfo[3] * scale / 1.5
		--	else
		--		VFL.print("InitTables instance " .. winfo.entryMid);
		--	end
		--elseif winfo.tp == 1 then
			
		end
	end
	-- World coord for instance
	for mapid, winfo in pairs (worldInfo) do
		if winfo.EntryMId then --instance
			info = worldInfo[winfo.EntryMId]
			if info then
				scale = info[1]
				winfo[1] = 1002 / 25600 
				winfo[4] = info[4] + winfo[2] * scale
				winfo[5] = info[5] + winfo[3] * scale / 1.5
			else
				VFL.print("InitTables instance " .. winfo.EntryMId);
			end
		end
	end
	
	-- Zone connections
	for mapid, winfo in pairs (worldInfo) do
		local cons = {}
		winfo.Connections = cons
		
		for _, str in ipairs (RDXMAP.ZoneConnections) do

				local flags, conTime, name1, z1, x1, y1, name2, z2, x2, y2 = strsplit("|",str)

				local mapId1 = tonumber(z1)
				local winfo1 = worldInfo[mapId1]
				if not winfo1 then 
					--VFL.print("error zone connection init " .. mapId1); 
					break; 
				end
				local mapId2 = tonumber(z2)
				local winfo2 = worldInfo[mapId2]
				if not winfo2 then 
					--VFL.print("error zone connection init " .. mapId2); 
					break;
				end
				local scale1 = winfo1[1]
				local scale2 = winfo2[1]
				local conTime = tonumber(conTime)
				local x1 = tonumber(x1)
				local y1 = tonumber(y1)
				local x2 = tonumber(x2)
				local y2 = tonumber(y2)

				if not (mapId1 and mapId2) then
					conTime = 0
				end

				if conTime == 1 and (mapid == mapId1 or (mapid == mapId2 and bit.band (flags, 1) == 1)) then

					local cont1 = winfo1.Cont --self:IdToContZone (mapId1)
					local cont2 = winfo2.Cont

					if cont1 == cont2 then												

						if mapid == mapId2 then		-- Swap?
							mapId1, mapId2 = mapId2, mapId1
							x1, y1, x2, y2 = x2, y2, x1, y1
							winfo1, winfo2 = winfo2, winfo1
							scale1, scale2 = scale2, scale1
						end

						local zcons = cons[mapId2] or {}
						cons[mapId2] = zcons

						if x1 ~= 0 and y1 ~= 0 then	-- Specific connection? Else connects anywhere

							local con = {}
							tinsert (zcons, con)

							x1, y1 = winfo1[4] + x1 * scale1, winfo1[5] + y1 * scale1 / 1.5
							x2, y2 = winfo2[4] + x2 * scale2, winfo2[5] + y2 * scale2 / 1.5

							con.StartMapId = mapId1
							con.StartX = x1
							con.StartY = y1
							con.EndMapId = mapId2
							con.EndX = x2
							con.EndY = y2
							con.Dist = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ .5
							--VFL.print("ADD " .. mapId1 .. " " .. mapId2);
						end


					end
				end
			end
	end
	
end



--RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RDXMAP.InitTables()
	RDX.mapsw = true;
--end);

