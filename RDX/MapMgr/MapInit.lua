
function RDXMAP.loadTables()
	for k,v in pairs(RDXMAP.MapWorldInfo) do
		local mbo = RDXDB.TouchObject("RDXDiskMap:maps:" .. k);
		mbo.ty = "MapInfo"; 
		mbo.version = 1;
		mbo.data = {}
		mbo.data.mf = VFL.copy(v);
		mbo.data.mf[1] = nil;
		mbo.data.mf[2] = nil;
		mbo.data.mf[3] = nil;
		mbo.data.mf[4] = nil;
		mbo.data.mf[5] = nil;
	end
end
-- /script RDXMAP.loadTables()
--------
-- Init map tables

function RDXMAP.InitTables()

	local worldInfo = RDXMAP.MapWorldInfo

	RDXMAP.MapNameToId = {}
	RDXMAP.MapIdToName = {}
	RDXMAP.InstanceNameToId = {}
	RDXMAP.mapIdToCarbId = {}
	RDXMAP.carbIdToMapId = {}
	RDXMAP.MapOverlayToMapId = {}
	RDXMAP.MapInfo = {}
	
	local mapIdToContId = {};
	
	local mapid, winfo;
	
	local pkg = RDXDB.GetPackage("RDXDiskMap", "maps")
	for objName, obj in pairs(pkg) do
		if type(obj) == "table" and obj.ty == "MapInfo" then
			mapid = tonumber(objName);
			winfo = obj.data.mf;
			if winfo and winfo.class == "c" and winfo.id then
				winfo.mapid = mapid;
				mapIdToContId[mapid] = winfo.id;
				RDXMAP.MapNameToId[winfo.id] = {}
			end
		end
	end
	
	local info, cx, cy, scale, contId, localname;
	
	for objName, obj in pairs(pkg) do
		if type(obj) == "table" and obj.ty == "MapInfo" then
			mapid = tonumber(objName);
			winfo = obj.data.mf;
			if winfo then
				localname = GetMapNameByID(mapid);
				contId = mapIdToContId[winfo.c]
				if not localname then
					local name;
					--if winfo.aa then 
					--	name = winfo.Name .. winfo.aa
					--else
						name = winfo.Name
					--end
					if winfo.class == "c" then
					
					elseif winfo.class == "i" or winfo.class == "bg" then
						if not RDXMAP.InstanceNameToId[name] then
							RDXMAP.InstanceNameToId[name] = mapid;
						end
					else
						--VFL.print("InitTables no localname " .. mapid)
						if not RDXMAP.MapNameToId[contId][name] then
							--RDXMAP.MapNameToId[name] = mapid;
							RDXMAP.MapNameToId[contId][name] = mapid;
						else
							--VFL.print("InitTables double name " .. name .. " mapid " .. mapid)
							--VFL.print("InitTables double name " .. name .. " mapid " .. RDXMAP.MapNameToId[name])
							--RDXMAP.MapNameToId[winfo.Name] = nil; -- clear so the engine will use mapid
						end
					end
					RDXMAP.MapIdToName[mapid] = name;
				else
					local name;
					--if winfo.aa then 
					--	name = localname .. winfo.aa
					--else
						name = localname
					--end
					if winfo.class == "c" then
					
					elseif winfo.class == "i" or winfo.class == "bg" then
						if not RDXMAP.InstanceNameToId[name] then
							RDXMAP.InstanceNameToId[name] = mapid;
						end
					else
						if not RDXMAP.MapNameToId[contId][name] then
							RDXMAP.MapNameToId[contId][name] = mapid;
						else
							VFL.print(contId)
							VFL.print(name)
							VFL.print(mapid)
							--VFL.print("InitTables double name " .. name .. " mapid " .. RDXMAP.MapNameToId[name])
							--RDXMAP.MapNameToId[localname] = nil; -- clear so the engine will use mapid
						end
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
				local ov = winfo.o
				if ov then
					RDXMAP.MapOverlayToMapId[ov] = mapid;
				end
			end
		end
	end

	
	
	--[[
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
				local scale1 = winfo1.s
				local scale2 = winfo2.s
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

							x1, y1 = winfo1.x + x1 * scale1, winfo1.y + y1 * scale1 / 1.5
							x2, y2 = winfo2.x + x2 * scale2, winfo2.y + y2 * scale2 / 1.5

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
	end]]
	
end



RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RDXMAP.InitTables()
end);

function dumpgenmap()
	if not RDXG.genmap then RDXG.genmap = {}; end
	for mapid, winfo in pairs (RDXMAP.MapWorldInfo) do
		--if winfo.Cont then --zone
		--	RDXG.genmap[mapid] = {};
		--	RDXG.genmap[mapid].x = winfo[4];
		--	RDXG.genmap[mapid].y = winfo[5];
		--	RDXG.genmap[mapid].s = winfo[1];
		--	RDXG.genmap[mapid].o = winfo.Overlay;
		--end
	end
end

-- /script dumpgenmap()