---------------------------------------------------------------------------------------
-- NxTravel - Travel code
-- Copyright 2007-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Tables

-------------------------------------------------------------------------------


--------

function RDXMAP.Travel:Init()

	local gopts = Nx.GetGlobalOpts()
	self.GOpts = gopts

	self.OrigTakeTaxiNode = TakeTaxiNode
	TakeTaxiNode = self.TakeTaxiNode		-- Hook it

	local tr = {}
	self.Travel = tr

	for n = 1, 4 do
		tr[n] = {}
		self:Add ("Flight Master", n)
	end

--	if Nx:GetUnitClass() == "DRUID" then
--		local taxiT = NxCData["Taxi"]
--		taxiT[""] = true
--	end

	self.ColdFlyName = GetSpellInfo (54197) or ""
	self.AzerothFlyName = GetSpellInfo (90267) or ""
	self.FlySkillPandaria=115913
end

function RDXMAP.Travel:Add (typ, cont)

	local tdata = self.Travel[cont]

	local hideFac = UnitFactionGroup ("player") == "Horde" and 1 or 2

	if 1 then

		local dataStr = RDXMAP.GuideData[typ][cont] or ""

		for n = 1, #dataStr, 2 do

			local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
			local npcStr = RDXMAP.NPCData[npcI]

			local fac = strbyte (npcStr, 1) - 35
			if fac ~= hideFac then

				local oStr = strsub (npcStr, 2)
				local desc, zone, loc = RDXMAP.UnpackObjective (oStr)
				local name, locName = strsplit ("!", desc)

--				local locName = strsplit (",", locName)

				if strbyte (oStr, loc) == 32 then  -- Points

					local mapId = RDXMAP.Zone2MapId[zone]
					local x, y = RDXMAP.UnpackLocPtOff (oStr, loc + 1)
					local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)

					local node = {}
					node.Name = desc
					node.LocName = NXlTaxiNames[locName] or locName		-- Localize it
					node.MapId = mapId
					node.WX = wx
					node.WY = wy
					tinsert (tdata, node)

				else
					assert (0)
				end
			end
		end
	end
end

--------
-- Taxi Map open event

function RDXMAP.Travel.OnTaximap_opened()

--	VFL.vprint ("OnTaximap_opened")

	local self = RDXMAP.Travel

	self:CaptureTaxi()
end

--------
-- Record taxi locations we can use

function RDXMAP.Travel:CaptureTaxi()

	self.TaxiNameStart = false

	local taxiT = NxCData["Taxi"]

	for n = 1, NumTaxiNodes() do

--		local locName = strsplit (",", TaxiNodeName (n))
		local locName = TaxiNodeName (n)

		taxiT[locName] = true

		if TaxiNodeGetType (n) == "CURRENT" then

			self.TaxiNameStart = locName

			if NxData.DebugMap then
				local name = RDXMAP.APITravel.FindTaxis2(n)
				VFL.vprint ("Taxi current %s (%s)", name or "nil", locName)
			end
		end
	end
end

--------
-- Hook for Taxi use
-- call when you click on the taxi 
function RDXMAP.Travel.TakeTaxiNode (node)

	local self = RDXMAP.Travel

	RDXMAP.TaxiName = TaxiNodeName (node) -- Localize name
	local x1,y1 = TaxiNodePosition(node);
	x1 = format("%0.6f",x1);
	y1 = format("%0.6f",y1);
	
	-- Get Data from old system by default
	local name, x, y = RDXMAP.APITravel.FindTaxis (RDXMAP.TaxiName)
	local ff;
	-- try to get global data from RDX FS
	local mapId = RDXMAP.APIMap.GetRealMapId()
	local info = RDXMAP.APIMap.GetWorldZone(mapId)
	if info and info.c then
		local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:F_" .. info.c);
		for k,v in ipairs (mbo.data) do
			if x1 == v.fx and y1 == v.fy then
				ff = true;
				x, y = v.x, v.y
			end
		end
		if ff then
			VFL.print("TakeTaxiNode : get data from RDX FS");
		end
	end
	
	-- store into RDX FS
	if not ff then
		local mapId = RDXMAP.APIMap.GetRealMapId()
		local info = RDXMAP.APIMap.GetWorldZone(mapId)
		if info and info.c then
			local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:F_" .. info.c);
			for k,v in ipairs (mbo.data) do
				if v.n == RDXMAP.TaxiName then
					ff = true;
					v.fx = x1
					v.fy = y1
				end
			end
			if not ff2 then
				VFL.print("TakeTaxiNode : Insert Not found, English only " .. RDXMAP.TaxiName);
			end
		end
	end
	
	RDXMAP.TaxiX = x
	RDXMAP.TaxiY = y

	RDXMAP.TaxiETA = false

	local tm = self:TaxiCalcTime (node)
	if tm > 0 and self.TaxiNameStart then

		self.TaxiTimeEnd = GetTime() + tm
		Nx.Timer:Start ("TaxiTime", 1, self, self.TaxiTimer)
	end

	--if RDXG.DebugMap then
	--	VFL.vprint ("Taxi %s (%s) %.2f secs, node %d, %s %s", name or "nil", RDXMAP.TaxiName, tm, node, x or "?", y or "?")
	--end

	RDXMAP.Travel.OrigTakeTaxiNode (node)
end

--------
-- 

function RDXMAP.Travel:TaxiCalcTime (dest)

	local tm = 0
	local num = NumTaxiNodes()

	if num > 0 then

		TaxiNodeSetCurrent (dest)

		local rCnt = GetNumRoutes (dest)

		for n = 1, rCnt do

			local x = TaxiGetSrcX (dest, n)
			local y = TaxiGetSrcY (dest, n)

			local srcNode = self:TaxiFindNodeFromRouteXY (x, y)

			local x = TaxiGetDestX (dest, n)
			local y = TaxiGetDestY (dest, n)

			local destNode = self:TaxiFindNodeFromRouteXY (x, y)

			if srcNode and destNode then

--				local srcName = strsplit (",", TaxiNodeName (srcNode))
--				local destName = strsplit (",", TaxiNodeName (destNode))

				local srcName = TaxiNodeName (srcNode)
				local destName = TaxiNodeName (destNode)

				local t = self:TaxiFindConnectionTime (srcNode, destNode)
				--local t = 0;
				local routeName = srcName .. "#" .. destName

				if t == 0 then

					local tt = NxData.NXTravel["TaxiTime"]

					t = tt[routeName]

					if not t then

						if NxData.DebugMap then
							VFL.vprint (" No taxi data %s to %s", srcName, destName)
						end

						if rCnt == 1 then
							self.TaxiSaveName = routeName
						end

						return 0
					end
				end

				tm = tm + t

				if NxData.DebugMap then
					VFL.vprint (" #%s %s to %s, %s secs", n, srcName, destName, t)
				end

			end
		end
	end

	return tm
end

--------
-- 
-- OK
function RDXMAP.Travel:TaxiFindNodeFromRouteXY (x, y)

	for n = 1, NumTaxiNodes() do

		local x2, y2 = TaxiNodePosition (n)
		local dist = (x - x2) ^ 2 + (y - y2) ^ 2

		if dist < .000001 then

--			if NxData.DebugMap then
--				VFL.vprint (" #%s %s %s %s %s", n, TaxiNodeName (n), dist, x, y)
--			end

			return n
		end
	end
end

--------
-- 

function RDXMAP.Travel:TaxiFindConnectionTime (srcNode, destNode)

	local srcNPCName, x, y = RDXMAP.APITravel.FindTaxis2 (srcNode)
	local destNPCName, x, y = RDXMAP.APITravel.FindTaxis2 (destNode)

--	VFL.vprint ("NPC src %s %s", srcName, srcNPCName or "nil")
--	VFL.vprint ("NPC dest %s %s", destName, destNPCName or "nil")

	-- single string comprising multiple 6 byte entries
	-- aabbcc
	-- aa = index of start npc (RDXMAP.NPCData table)
	-- bb = index of end npc (RDXMAP.NPCData table)
	-- cc = flight time in 10ths of a second
	-- all are base 221 encoded (indicies start at 1)

	local conn = RDXMAP.FlightConnection

	for n = 1, #conn, 6 do

		local a1, a2, b1, b2, c1, c2 = strbyte (conn, n, n + 5)

		local i = (a1 - 35) * 221 + a2 - 35

		local npc = RDXMAP.NPCData[i]
		if npc then

			local oStr = strsub (npc, 2)
			local desc, zone, loc = RDXMAP.UnpackObjective (oStr)
			local name = strsplit ("!", desc)

			if name == srcNPCName then

--				VFL.vprint ("SNPC %s", desc)

				local i = (b1 - 35) * 221 + b2 - 35
				local npc = RDXMAP.NPCData[i]
				if npc then

					local oStr = strsub (npc, 2)
					local desc, zone, loc = RDXMAP.UnpackObjective (oStr)
					local name = strsplit ("!", desc)

					if name == destNPCName then

--						VFL.vprint ("DNPC %s", desc)

						return ((c1 - 35) * 221 + c2 - 35) / 10
					end
				else
					VFL.vprint ("Travel: missing dnpc %s %s", destNPCName, i)
				end
			end
		else
			VFL.vprint ("Travel: missing snpc %s %s", srcNPCName, i)
		end
	end

	return 0
end

function RDXMAP.Travel:TaxiTimer()

	if UnitOnTaxi ("player") then

		RDXMAP.TaxiETA = max (0, self.TaxiTimeEnd - GetTime())

		return .5
	end
end

--------
-- Called by map to save flight time

function RDXMAP.Travel:TaxiSaveTime (tm)

	if self.TaxiSaveName then		-- Need?

		NxData.NXTravel["TaxiTime"][self.TaxiSaveName] = tm
		self.TaxiSaveName = false
	end
end

local function ProcessTaxi(self, elapsed)

	RDXMAP.ontaxi = UnitOnTaxi ("player")

	if RDXMAP.ontaxi then
		if not RDXMAP.TaxiOn then	-- New taxi ride?
			RDXMAP.TaxiStartTime = GetTime()
			RDXMAP.TaxiOn = true
			if RDXG.DebugMap then
				VFL.vprint ("Taxi start")
			end
		end

	elseif RDXMAP.TaxiOn then	-- Done with taxi
		RDXMAP.TaxiOn = false
		RDXMAP.TaxiX = nil		-- Clear so if we pop on a taxi by a unhooked method we don't track old

		local tm = GetTime() - RDXMAP.TaxiStartTime

		RDXMAP.Travel:TaxiSaveTime (tm)

		if RDXG.DebugMap then
			VFL.vprint ("Taxi time %.1f seconds", tm)
		end
	end
end

RDXEvents:Bind("INIT_POST", nil, function() 
	local taxiFrame = CreateFrame("Frame");
	taxiFrame:SetScript("OnUpdate", ProcessTaxi);
	VFLP.RegisterFunc("RDXMAP", "ProcessTaxi", ProcessTaxi, true);
end);

-------------------------------------------------------------------------------

--------
-- Make shortest path
--
-- Straight line (flight master can shorten)
-- zone connection (FM can shorten)
--
-- C connection
-- P player
-- d destination
-- F flight master
--
--             ************
--  ***********            *
--  *          *            *
--  *  F        *            *
--  *          *             *
--  *    .....CCC....        *
--  *   .      *     ....    *
--  *  P       *         d   *
--  *   .      *       ..    *
--  *    .     *      F      *
--  *     .    *      |      *
--  *      .   *     /       *
--  *       .  *    /        *
--  *        .CC.F--         *
--  *          *             *
--  ************************

function RDXMAP.Travel:MakePath (tracking, srcMapId, srcX, srcY, dstMapId, dstX, dstY, targetType)

	if not self.GOpts["MapRouteUse"] then
		return
	end

	if UnitOnTaxi ("player") then
		return
	end

	local srcInfo = RDXMAP.APIMap.GetWorldZone(srcMapId)
	if srcInfo.EntryMId then
		srcMapId = srcInfo.EntryMId
		srcInfo = RDXMAP.APIMap.GetWorldZone(srcInfo.EntryMId)
	end
	local dstInfo = RDXMAP.APIMap.GetWorldZone(dstMapId)
	if dstInfo.EntryMId then
		dstMapId = dstInfo.EntryMId
		dstInfo = RDXMAP.APIMap.GetWorldZone(dstInfo.EntryMId)
	end

	local x = dstX - srcX
	local y = dstY - srcY
	local tarDist = (x * x + y * y) ^ .5

	if srcMapId == dstMapId and tarDist < 500 / 4.575 then		-- Short travel?
		return
	end

	local riding = Nx.Warehouse.SkillRiding

	if IsAltKeyDown() then
--		VFL.vprint ("Riding %s", riding)
		riding = 0
	end

	local cont1 = srcInfo.c
	local cont2 = dstInfo.c
	local lvl = UnitLevel ("player")

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

	self.Speed = speed

	if cont1 == cont2 then

--		if srcMapId == 4003 or dstMapId == 4003 then		-- Dalaran?
--			return													-- Do a straight line
--		end

		if riding >= 300 and self.FlyingMount then	-- Epic flyer in flying area, don't route
			return
		end

		self.VisitedMapIds = {}

		local path = {}

		local node1 = {}
		node1.MapId = srcMapId
		node1.X = srcX
		node1.Y = srcY
		tinsert (path, node1)

		local node2 = {}
		node2.MapId = dstMapId
		node2.X = dstX
		node2.Y = dstY
		tinsert (path, node2)

--		VFL.vprint ("** path nodes start %s to %s", srcMapId, dstMapId)

		local watchdog = 10

		repeat

			local nodeCnt = #path

			for n = 1, #path - 1 do

				local node1 = path[n]
				local node2 = path[n + 1]

				if not node1.NoSplit then

					if node1.MapId ~= node2.MapId then

						local conDist, conS, conD, con
						if self.FlyingMount then		-- Can fly?
							conDist = ((node1.X -  node2.X) ^ 2 + (node1.Y - node2.Y) ^ 2) ^ .5	-- Use straight line distance
						else
							conDist, conS, conD = RDXMAP.APITravel.FindZoneConnection (node1.MapId, node1.X, node1.Y, node2.MapId, node2.X, node2.Y)
						end
						local flyDist, fpath = RDXMAP.APITravel.FindFlight (node1.MapId, node1.X, node1.Y, node2.MapId, node2.X, node2.Y)

--						fpath = nil		-- Test

--						VFL.vprint ("%d: con %s, fly %s", n, conDist or "nil", flyDist or "nil")

						if conDist and (not fpath or conDist < flyDist) then

--							VFL.vprint (" con %s to %s", RDXMAP.APIMap.IdToName(node1.MapId), RDXMAP.APIMap.IdToName(node2.MapId))

							if conS then
--								VFL.vprint (" make con")

								local ang1 = math.deg (math.atan2 (srcX - conS.x, srcY - conS.y))
								local ang2 = math.deg (math.atan2 (srcX - conD.x, srcY - conD.y))
								local ang = abs (ang1 - ang2)
								ang = ang > 180 and 360 - ang or ang

--								VFL.vprint ("Ang %s %s = %s", ang1, ang2, ang)

								if conD.zcr ~= node1.MapId then	-- Open connection caused us to switch zones? No split
									node1.NoSplit = true
								end

								local name = format ("Connection: %s to %s", RDXMAP.APIMap.IdToName(conD.zcr), RDXMAP.APIMap.IdToName(conS.zcr))

								local node = {}
								node.NoSplit = true
								node.MapId = conD.zcr
								node.X = conS.x
								node.Y = conS.y
								node.Name = name
								node.Tex = "Interface\\Icons\\Spell_Nature_FarSight"
								tinsert (path, n + 1, node)

								self.VisitedMapIds[conD.zcr] = true

								if ang > 90 then
									node.Die = true
								end

								local node = {}
								node.MapId = conS.zcr
								node.X = conD.x
								node.Y = conD.y
								node.Name = name
								node.Tex = "Interface\\Icons\\Spell_Nature_FarSight"
								tinsert (path, n + 2, node)
							end
						else
							if fpath then

--								VFL.vprint (" flight %s to %s", node1.MapId, node2.MapId)

								tinsert (path, n + 1, fpath[1])
								tinsert (path, n + 2, fpath[2])
							end
						end

					else

						local directDist = ((node1.X - node2.X) ^ 2 + (node1.Y - node2.Y) ^ 2) ^ .5		-- Straight line distance
						local flyDist, fpath = RDXMAP.APITravel.FindFlight (node1.MapId, node1.X, node1.Y, node2.MapId, node2.X, node2.Y)

--						VFL.vprint ("%d: direct %s, fly %s", n, directDist, flyDist or "nil")

						if fpath and flyDist < directDist then

--							VFL.vprint (" flight in %s", node1.MapId)

							tinsert (path, n + 1, fpath[1])
							tinsert (path, n + 2, fpath[2])
						end
					end
				end
			end

			watchdog = watchdog - 1

			if watchdog < 0 then
--				VFL.vprint ("path watchdog")
				break
			end

		until nodeCnt == #path

		-- Build path

--		VFL.vprint ("path nodes %s", #path)

		for n = 2, #path - 1 do

			local node1 = path[n]
			if not node1.Die then

				local x, y = node1.X, node1.Y

				local t1 = {}
				t1.t = targetType				
				t1.x = x
				t1.y = y
				t1.n = node1.Name

				if node1.Flight then
					t1.Mode = "F"
				end

				tinsert (tracking, t1)
			end
		end
	end
end



function RDXMAP.Travel:FindFlight (srcMapId, srcX, srcY, dstMapId, dstX, dstY)

	local t1Dist, t1Node, t1tex = RDXMAP.APITravel.FindClosestFlight (srcMapId, srcX, srcY)

	if t1Node then

		local speed = self.Speed

		local t1Name = t1Node.Name
		local t1x, t1y = t1Node.WX, t1Node.WY

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

				if t1Name == t2Node.Name then	-- Same flight master?
					break
				end

				local t2x, t2y = t2Node.WX, t2Node.WY

				local fltDist = ((t1x - t2x) ^ 2 + (t1y - t2y) ^ 2) ^ .5 * speed
				t2Dist = ((dstX - t2x) ^ 2 + (dstY - t2y) ^ 2) ^ .5	-- Real distance
				local travelDist = t1Dist + fltDist + t2Dist

--				VFL.vprint ("F (%s %d) %d (%s %d)", t1Name, t1Dist * 4.575, fltDist * 4.575, t2Node.Name, t2Dist * 4.575)
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

		local name = format ("Fly: %s to %s", gsub (t1Node.Name, ".+!", ""), gsub (bt2Node.Name, ".+!", ""))
--		local name = format ("Fly: %s to %s", t1Node.Name, bt2Node.Name)

		local node1 = {}
		node1.NoSplit = true
		node1.MapId = t1Node.MapId
		node1.X = t1x
		node1.Y = t1y
		node1.Name = name

		node1.Tex = "Interface\\Icons\\Ability_Mount_Wyvern_01"
		tinsert (path, node1)

		local node2 = {}
		node2.Flight = true
		node2.MapId = bt2Node.MapId
		node2.X = bt2Node.WX
		node2.Y = bt2Node.WY
		node2.Name = name
		node2.Tex = "Interface\\Icons\\Ability_Mount_Wyvern_01"
		tinsert (path, node2)

		return bestDist, path
	end
end

--------
-- Find closest
-- (mapid, world x, world y)

function RDXMAP.Travel:FindClosest (mapId, posX, posY)

	local cont = RDXMAP.APIMap.IdToContZone (mapId)

	local tr = self.Travel[cont]
	if not tr then		-- BGs?
		return
	end

	local taxiT = NxCData["Taxi"]

	local closeNode
	local closeDist = 9000111222333444

	for n, node in ipairs (tr) do

		if taxiT[node.LocName] then

			local dist

			if mapId == node.MapId then

				dist = (node.WX - posX) ^ 2 + (node.WY - posY) ^ 2

			else
				dist = self:FindConnection (mapId, posX, posY, node.MapId, node.WX, node.WY) ---
				if not dist then
					dist = 9900111222333444
				else
					dist = dist ^ 2
				end
			end

			if dist < closeDist then
--				VFL.vprint ("Close %s %d (%s %d %d)", node.Name, dist ^ .5, mapId, posX, posY)
				closeDist = dist
				closeNode = node
			end
		end
	end

	if closeNode then
		local tex = "Interface\\Icons\\Ability_Mount_Wyvern_01"
		return closeDist ^ .5, closeNode, tex
	end
end

--------
-- Find best connection

function RDXMAP.Travel:FindConnection (srcMapId, srcX, srcY, dstMapId, dstX, dstY, skipIndirect)

	if self.FlyingMount then		-- Can fly?
		return ((srcX - dstX) ^ 2 + (srcY - dstY) ^ 2) ^ .5	-- Use straight line distance
	end

	local srcT = RDXMAP.APIMap.GetWorldZone(srcMapId)
	if not srcT or not srcT.Connections then
		return
	end

	local zcon = srcT.Connections[dstMapId]

	if zcon and not self.VisitedMapIds[dstMapId] then

--		VFL.vprint ("C %s to %s #%s", RDXMAP.APIMap.IdToName(srcMapId), RDXMAP.APIMap.IdToName(dstMapId), #zcon)

		if #zcon == 0 then
			return ((srcX - dstX) ^ 2 + (srcY - dstY) ^ 2) ^ .5	-- Open connection. Use straight line distance
		end

		local closeCon
		local closeDist = 9000111222333444

		for n, con in ipairs (zcon) do

			local dist1 = ((con.StartX - srcX) ^ 2 + (con.StartY - srcY) ^ 2) ^ .5
			local dist2 = ((con.EndX - dstX) ^ 2 + (con.EndY - dstY) ^ 2) ^ .5
			local d = dist1 + con.Dist + dist2

			if d < closeDist then
				closeCon = con
				closeDist = d
			end
		end

		return closeDist, closeCon

	elseif not skipIndirect then	-- No direct connection

		local closeCon
		local closeDist = 9000111222333444

		for mapId, zcon in pairs (srcT.Connections) do

			if not self.VisitedMapIds[mapId] then

--				VFL.vprint ("C %s (%s to %s) #%s", RDXMAP.APIMap.IdToName(mapId), RDXMAP.APIMap.IdToName(srcMapId), RDXMAP.APIMap.IdToName(dstMapId), #zcon)

				if #zcon == 0 then

					local d, con = self:FindConnection (mapId, srcX, srcY, dstMapId, dstX, dstY, true) ---
					if d and d < closeDist then
						closeDist = d
						closeCon = con
					end

				else
					for n, con in ipairs (zcon) do

						local dist1 = ((con.StartX - srcX) ^ 2 + (con.StartY - srcY) ^ 2) ^ .5
						local dist2 = ((con.EndX - dstX) ^ 2 + (con.EndY - dstY) ^ 2) ^ .5
						local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
						local penalty
						if winfo then
							penalty = winfo.Connections[dstMapId] and 1 or 2
						end

						local d = dist1 + con.Dist + dist2 * penalty	-- Penalty for no direct connection

						if d < closeDist then
							closeDist = d
							closeCon = con
						end
					end
				end
			end
		end

		if closeCon then

			local d, con = self:FindConnection (closeCon.EndMapId, closeCon.EndX, closeCon.EndY, dstMapId, dstX, dstY, true)	--- Find next connection
			if con then

--				VFL.vprint ("C+ %s %d (%s to %s)", RDXMAP.APIMap.IdToName(srcMapId), d, RDXMAP.APIMap.IdToName(con.StartMapId), RDXMAP.APIMap.IdToName(con.EndMapId))

				closeDist = closeDist + d	-- Add 2nd connection. Fixes issues like going from Org to areas in Ashenvale near Org, which has no direct connection
			end
		end

--[[
		if closeCon then
			VFL.vprint ("C- %s %d (%s to %s)", RDXMAP.APIMap.IdToName(srcMapId), closeDist, RDXMAP.APIMap.IdToName(closeCon.StartMapId), RDXMAP.APIMap.IdToName(closeCon.EndMapId))
		end
--]]

		return closeDist, closeCon
	end
end

--------

function RDXMAP.Travel:DebugCaptureTaxi()

	local num = NumTaxiNodes()

	if num > 0 then

--		NxData.TaxiCap = {}

		local mid = RDXMAP.APIMap.GetRealMapId()

		local cap = NxData.TaxiCap or {}
		NxData.TaxiCap = cap
		local d = {}
		cap[mid] = d

		for n = 1, num do
			local name = TaxiNodeName (n)
			local typ = TaxiNodeGetType (n)		-- NONE, CURRENT, REACHABLE, DISTANT
			local x, y = TaxiNodePosition (n)
			VFL.vprint ("Taxi #%s %s, %s %f %f", n, name, typ, x, y)
			tinsert (d, name)
		end
--[[
		local dest = 6

		TaxiNodeSetCurrent (dest)

		for n = 1, GetNumRoutes (dest) do
			local x = TaxiGetDestX (dest, n)
			local y = TaxiGetDestY (dest, n)

			VFL.vprint (" #%s %s %s", n, x, y)

			local match

			for n2 = 1, num do
				local name = TaxiNodeName (n2)
				local x2, y2 = TaxiNodePosition (n2)
				local dist = (x - x2) ^ 2 + (y - y2) ^ 2
--				VFL.vprint (" %s %s", name, dist)
				if dist < .000001 then
					match = n2
					VFL.vprint (" #%s %s %s %s %s %s", n, n2, name, dist, x, y)
					break
				end
			end
		end
--]]
	end
end






-------------------------------------------------------------------------------
-- EOF














