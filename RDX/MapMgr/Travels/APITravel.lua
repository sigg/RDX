
RDXMAP.APITravel = {};

--local myunit;
--RDXEvents:Bind("INIT_POST", nil, function() myunit = RDXDAL.GetMyUnit(); end);	


function RDXMAP.APITravel.FindTaxis (campName)
	local hideFac = UnitFactionGroup ("player") == "Horde" and 1 or 2
	for cont = 1, RDXMAP.ContCnt do
		local dataStr = RDXMAP.GuideData["Flight Master"][cont] or ""
		for n = 1, #dataStr, 2 do
			local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
			local npcStr = RDXMAP.NPCData[npcI]
			local fac = strbyte (npcStr, 1) - 35
			if fac ~= hideFac then
				local oStr = strsub (npcStr, 2)
				local desc, zone, loc = RDXMAP.UnpackObjective (oStr)
				local name, camp = strsplit ("!", desc)
				
				if camp == campName then
					local mapId = RDXMAP.Zone2MapId[zone]
					local x, y = RDXMAP.UnpackLoc (oStr, loc)
					local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
					return name, wx, wy
				end
			end
		end
	end
end

-- universal system, not localized
function RDXMAP.APITravel.FindTaxis2(node)
	local name = TaxiNodeName(node);
	local wx, wy = 0,0;
	local x1,y1 = TaxiNodePosition(node);
	x1 = format("%0.6f",x1);
	y1 = format("%0.6f",y1);
	-- Get continent mapid
	local mapId = RDXMAP.APIMap.GetRealMapId()
	local cont = RDXMAP.APIMap.GetContinent(mapId)
	if cont then
		local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:F_" .. cont);
		if mbo.data then
			for k,v in ipairs (mbo.data) do
				if x1 == v.fx and y1 == v.fy then
					wx, wy = v.x, v.y
				end
			end
		else
		
		end
	end
	return name, wx, wy;
end

function RDXMAP.APITravel.MakePath (tr, srcMapId, srcX, srcY, dstMapId, dstX, dstY)

	--local tr;
	
	--if not self.GOpts["MapRouteUse"] then
	--	return
	--end

	--if UnitOnTaxi ("player") then
	--	return
	--end
	-- instance trick
	local srcInfo = RDXMAP.APIMap.GetWorldZone(srcMapId)
	if not srcInfo then return; end
	--if srcInfo.EntryMId then
	--	srcMapId = srcInfo.EntryMId
	--	srcInfo = RDXMAP.APIMap.GetWorldZone(srcInfo.EntryMId)
	--end
	local dstInfo = RDXMAP.APIMap.GetWorldZone(dstMapId)
	--if dstInfo.EntryMId then
	--	dstMapId = dstInfo.EntryMId
	--	dstInfo = RDXMAP.APIMap.GetWorldZone(dstInfo.EntryMId)
	--end

	local x = dstX - srcX
	local y = dstY - srcY
	local tarDist = (x * x + y * y) ^ .5
	
	local cont1 = srcInfo.c
	local cont2 = dstInfo.c

--[[
	local riding = Nx.Warehouse.SkillRiding ---

	if IsAltKeyDown() then
--		VFL.vprint ("Riding %s", riding)
		riding = 0
	end

	self.FlyingMount = false

	if riding >= 225 then
		if cont1 == 13 or cont1 == 14 or cont1 == 751 then
			self.FlyingMount = GetSpellInfo (self.AzerothFlyName)
		elseif cont1 == 466 then
			self.FlyingMount = true
		elseif cont1 == 485 then
			self.FlyingMount = GetSpellInfo (self.ColdFlyName)
        elseif cont1 == 862 then
            self.FlyingMount = IsSpellKnown(self.FlySkillPandaria)            
		end
	end

	local speed = 2 / 4.5
	if riding < 75 then
		speed = 1 / 4.5
	elseif riding < 150 then
		speed = 1.6 / 4.5
	elseif self.FlyingMount then
		speed = 2.5 / 4.5
	end

--	VFL.vprint ("Tar %d, Spd %s, Fly %s, Cold:%s", tarDist * 4.575, speed, self.FlyingMount and 1 or 0)
]]
	--self.Speed = speed
	--self.Speed = 2 / 4.5

	if cont1 == cont2 then

		--if riding >= 300 and self.FlyingMount then	-- Epic flyer in flying area, don't route
		--	return
		--end


		local path = {}

		local node1 = {}
		node1.m = srcMapId
		--VFL.print(srcMapId);
		node1.x = srcX
		node1.y = srcY
		tinsert (path, node1)

		local node2 = {}
		node2.m = dstMapId
		node2.x = dstX
		node2.y = dstY
		tinsert (path, node2)

--		VFL.vprint ("** path nodes start %s to %s", srcMapId, dstMapId)

		--local watchdog = 10

		--repeat

			local nodeCnt = #path

			for n = 1, #path - 1 do

				local node1 = path[n]
				local node2 = path[n + 1]

				if not node1.NoSplit then

					if node1.m ~= node2.m then

						local conDist, conS, conD, con
						--if self.FlyingMount then		-- Can fly?
						--	conDist = ((node1.x -  node2.x) ^ 2 + (node1.y - node2.y) ^ 2) ^ .5	-- Use straight line distance
						--else
							conDist, conS, conD = RDXMAP.APITravel.FindZoneConnection (node1.m, node1.x, node1.y, node2.m, node2.x, node2.y)
						--end
						local flyDist, fpath = RDXMAP.APITravel.FindFlight (node1.m, node1.x, node1.y, node2.m, node2.x, node2.y)

--						fpath = nil		-- Test

--						VFL.vprint ("%d: con %s, fly %s", n, conDist or "nil", flyDist or "nil")

						if conDist and (not fpath or conDist < flyDist) then

--							VFL.vprint (" con %s to %s", RDXMAP.APIMap.IdToName(node1.m), RDXMAP.APIMap.IdToName(node2.m))

							if conS then
--								VFL.vprint (" make con")

								local ang1 = math.deg (math.atan2 (srcX - conS.x, srcY - conS.y))
								local ang2 = math.deg (math.atan2 (srcX - conD.x, srcY - conD.y))
								local ang = abs (ang1 - ang2)
								ang = ang > 180 and 360 - ang or ang

--								VFL.vprint ("Ang %s %s = %s", ang1, ang2, ang)

								if conD.zcr ~= node1.m then	-- Open connection caused us to switch zones? No split
									node1.NoSplit = true
								end

								local name = format ("Connection: %s to %s", RDXMAP.APIMap.IdToName(conD.zcr), RDXMAP.APIMap.IdToName(conS.zcr))

								local node = {}
								node.NoSplit = true
								node.m = conD.zcr
								node.x = conS.x
								node.y = conS.y
								node.n = name
								node.Tex = "Interface\\Icons\\Spell_Nature_FarSight"
								tinsert (path, n + 1, node)


								if ang > 90 then
									node.Die = true
								end

								local node = {}
								node.m = conS.zcr
								node.x = conD.x
								node.y = conD.y
								node.n = name
								node.Tex = "Interface\\Icons\\Spell_Nature_FarSight"
								tinsert (path, n + 2, node)
							end
						else
							if fpath then

--								VFL.vprint (" flight %s to %s", node1.m, node2.m)

								tinsert (path, n + 1, fpath[1])
								tinsert (path, n + 2, fpath[2])
							end
						end

					else
						-- same map id
						local directDist = ((node1.x - node2.x) ^ 2 + (node1.y - node2.y) ^ 2) ^ .5		-- Straight line distance
						local flyDist, fpath = RDXMAP.APITravel.FindFlight (node1.m, node1.x, node1.y, node2.m, node2.x, node2.y)

--						VFL.vprint ("%d: direct %s, fly %s", n, directDist, flyDist or "nil")

						if fpath and flyDist < directDist then

--							VFL.vprint (" flight in %s", node1.m)

							tinsert (path, n + 1, fpath[1])
							tinsert (path, n + 2, fpath[2])
						end
					end
				end
			end

			--watchdog = watchdog - 1

			--if watchdog < 0 then
--				VFL.vprint ("path watchdog")
			--	break
			--end

		--until nodeCnt == #path

		-- Build path

--		VFL.vprint ("path nodes %s", #path)

		for n = 2, #path - 1 do

			local node1 = path[n]
			if not node1.Die then
				local t1 = {}
				t1.x = node1.x
				t1.y = node1.y
				t1.n = node1.n
				t1.m = node1.m
				tinsert (tr, t1)
			end
		end
	end
	
	--return tr;
end

function RDXMAP.APITravel.FindFlight (srcMapId, srcX, srcY, dstMapId, dstX, dstY)

	local t1Dist, t1Node, t1tex = RDXMAP.APITravel.FindClosestFlight (srcMapId, srcX, srcY)

	if t1Node then

		local t1Name = t1Node.n
		local t1x, t1y = t1Node.x, t1Node.y

		local bt2Node
		local bestDist = 9999999999

		local distX = dstX - srcX
		local distY = dstY - srcY

--		for per = 0, 0, .2 do
		for per = 0, .5, .2 do

			local dx = dstX - distX * per		-- Push in towards middle
			local dy = dstY - distY * per

			local t2Dist, t2Node, t2tex = RDXMAP.APITravel.FindClosestFlight (dstMapId, dx, dy)

			if t2Node then

				if t1Name == t2Node.n then	-- Same flight master?
					break
				end

				local t2x, t2y = t2Node.x, t2Node.y
				local myunit = RDXDAL.GetMyUnit();
				local fltDist = ((t1x - t2x) ^ 2 + (t1y - t2y) ^ 2) ^ .5 * myunit.speed
				t2Dist = ((dstX - t2x) ^ 2 + (dstY - t2y) ^ 2) ^ .5	-- Real distance
				local travelDist = t1Dist + fltDist + t2Dist

--				VFL.vprint ("F (%s %d) %d (%s %d)", t1Name, t1Dist * 4.575, fltDist * 4.575, t2Node.n, t2Dist * 4.575)
--				VFL.vprint ("F  %d %d, %d %d", t1x, t1y, t2x, t2y)
--				VFL.vprint ("F %d, best %d, per %s", travelDist * 4.575, bestDist * 4.575, per)

				if bestDist > travelDist then
					bestDist = travelDist
					bt2Node = t2Node
				end
			end
		end

		if not bt2Node then
			return
		end

		local path = {}

		local name = format ("Fly: %s to %s", gsub (t1Node.n, ".+!", ""), gsub (bt2Node.n, ".+!", ""))
--		local name = format ("Fly: %s to %s", t1Node.n, bt2Node.n)
		
		tinsert (path, t1Node)
		tinsert (path, bt2Node)
		
		--[[local node1 = {}
		node1.NoSplit = true
		node1.MapId = t1Node.z
		node1.x = t1x
		node1.y = t1y
		node1.n = name
		node1.Tex = "Interface\\Icons\\Ability_Mount_Wyvern_01"
		tinsert (path, node1)

		local node2 = {}
		node2.Flight = true
		node2.MapId = bt2Node.z
		node2.x = bt2Node.x
		node2.y = bt2Node.y
		node2.n = name
		node2.Tex = "Interface\\Icons\\Ability_Mount_Wyvern_01"
		tinsert (path, node2)]]

		return bestDist, path
	end
end

--------
-- Find closest
-- (mapid, world x, world y)

function RDXMAP.APITravel.FindClosestFlight (mapId, posX, posY)

	local closeNode
	local closeDist = 9000111222333444

	local cont = RDXMAP.APIMap.GetContinent(mapId)
	if cont then
		local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:F_" .. cont);
		if mbo and mbo.data then
			for k,v in ipairs (mbo.data) do
				if v.s == 2 or v.s == RDX.PlFactionNum then
					local dist
					if v.z == mapId then
						dist = (v.x - posX) ^ 2 + (v.y - posY) ^ 2
					else
						dist = RDXMAP.APITravel.FindZoneConnection (mapId, posX, posY, v.z, v.x, v.y)
						if not dist then
							dist = 9900111222333444
						else
							dist = dist ^ 2
						end
					end
					if dist < closeDist then
		--				VFL.vprint ("Close %s %d (%s %d %d)", node.Name, dist ^ .5, mapId, posX, posY)
						closeDist = dist
						closeNode = v;
					end
				end
			end
			if closeNode then
				return closeDist ^ .5, closeNode
			end
		else
			return closeDist
		end
	end
end

-- the function only search for first connection. No recursive anymore
function RDXMAP.APITravel.FindZoneConnection (srcMapId, srcX, srcY, dstMapId, dstX, dstY)	

	local found, closeConS, closeConD;
	local closeDist = 9000111222333444;
	
	local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:ZC_" .. srcMapId);
	if mbo and mbo.data then
		for k,v in pairs(mbo.data) do
			if v.zcr == dstMapId then
				found = true;
				local mbo2 = RDXDB.TouchObject("RDXDiskMap:poisT:ZC_" .. dstMapId);
				local v2 = mbo2.data[v.icr];
				local dist1 = ((v.x - srcX) ^ 2 + (v.y - srcY) ^ 2) ^ .5
				local dist2 = ((v2.x - dstX) ^ 2 + (v2.y - dstY) ^ 2) ^ .5
				local d = dist1 + dist2
				local din = 0
				if v.t == 1 then
					din = (((v.x - v2.x) ^ 2 + (v.y - v2.y) ^ 2) ^ .5)
				end
				d = d + din;
				if d < closeDist then
					closeDist = d
					closeConS = v
					closeConD = v2
				end
			end
		end
	end
	if not found then
		return ((srcX - dstX) ^ 2 + (srcY - dstY) ^ 2) ^ .5
	else
		return closeDist, closeConS, closeConD
	end
end