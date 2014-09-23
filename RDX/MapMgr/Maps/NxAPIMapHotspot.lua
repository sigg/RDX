
--------
-- Init hotspots

local winfo, cname, zname, color, infoStr, tipStr, loc

function RDXMAP.APIMap.InitHotspots(map)

	local quad = {}
	map.WorldHotspots = quad
	local quadCity = {}
	map.WorldHotspotsCity = quadCity
	
	for mapId, winfo in pairs (RDXMAP.APIMap.MapWorldInfo()) do
		if winfo.class == "z" or winfo.class == "ci" then
			cname = RDXMAP.APIMap.GetWorldZoneInfo(winfo.c) --get data continent name
			zname = winfo.localname or winfo.Name
			color, infoStr = RDXMAP.APIMap.GetMapNameDesc (mapId)
			tipStr = format ("%s, %s%s (%s)", cname, color, zname, infoStr)
			loc = RDXMAP.MapWorldHotspots2[mapId]
			if loc then
				locSize = 12
			else
				locSize = 4
				loc = format ("%c%c%c%c", 85, 85, 135, 135)
			end
			
			for n = 0, 100 do

				local locN = n * locSize + 1

				local loc1 = strsub (loc, locN, locN + locSize - 1)
				if loc1 == "" then
					break
				end

				local zx, zy, zw, zh

				if locSize == 4 then
					zx, zy, zw, zh = RDXMAP.UnpackLocRect (loc1)
				else
					zx = tonumber (strsub (loc1, 1, 3), 16) * 100 / 4095
					zy = tonumber (strsub (loc1, 4, 6), 16) * 100 / 4095
					zw = tonumber (strsub (loc1, 7, 9), 16) * 1002 / 4095
					zh = tonumber (strsub (loc1, 10, 12), 16) * 668 / 4095
				end

				local spot = {}

				local wzone = RDXMAP.APIMap.GetWorldZone (mapId)

				if wzone.City or wzone.StartZone then
					tinsert (quadCity, spot)
				else
					tinsert (quad, spot)
				end

				spot.MapId = mapId

				local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, zx, zy)
				spot.WX1 = wx
				spot.WY1 = wy
				zw = zw / 1002 * 100
				zh = zh / 668 * 100
				local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, zx + zw, zy + zh)
				spot.WX2 = wx
				spot.WY2 = wy

				spot.NxTipBase = tipStr

--				if contN == 5 then
--					VFL.vprintVar ("Spot", spot)
--				end

			end
			
		end
	end
end

--------
-- Check world zone hotspots

function RDXMAP.APIMap.CheckWorldHotspots (map, wx, wy)

	if map.InstMapId then
		if wx >= map.InstMapWX1 and wx <= map.InstMapWX2 and wy >= map.InstMapWY1 and wy <= map.InstMapWY2 then
			
			local lvl = floor ((wy - map.InstMapWY1) / 668 * 256) + 1

			if map.InstMapId ~= map.MapId then

--				VFL.vprint ("Hit Inst %s, lvl %s", map.InstMapId, lvl)

				RDXMAP.APIMap.SetCurrentMap (map, map.InstMapId)
			end

			SetDungeonMapLevel (lvl)

			map.InstLevelSet = -1

			map.WorldHotspotTipStr = RDXMAP.APIMap.IdToName(map.InstMapId) .. "\n"

			return
		end
	end

	local quad1 = map.WorldHotspotsCity
	local quad2 = map.WorldHotspots

	if map.NXCitiesUnder then
		quad1, quad2 = quad2, quad1
	end

	if RDXMAP.APIMap.CheckWorldHotspotsType (map, wx, wy, quad1) then
		return
	end

	if RDXMAP.APIMap.CheckWorldHotspotsType (map, wx, wy, quad2) then
		return
	end

	map.WorldHotspotTipStr = false

--	local tt = GameTooltip
--	if tt:IsOwned (map.Win.Frm) and map.TooltipType == 1 then
--		tt:Hide()
--	end
end

--------
-- Check world zone hotspots type
-- This is very fast. No need to make a quad tree

function RDXMAP.APIMap.CheckWorldHotspotsType (map, wx, wy, quad)

	for n, spot in ipairs (quad) do
		if wx >= spot.WX1 and wx <= spot.WX2 and wy >= spot.WY1 and wy <= spot.WY2 then

			local curId = RDXMAP.APIMap.GetCurrentMapId()
			local winfo = RDXMAP.APIMap.GetWorldZone(curId)
			if winfo then
				curId = winfo.Level1Id or curId
			end

			if spot.MapId ~= curId then

--				VFL.vprint ("hotspot %s %s %s %s %s", spot.MapId, spot.WX1, spot.WX2, spot.WY1, spot.WY2)
				--VFL.print("CHANGE spot " .. spot.MapId);
				RDXMAP.APIMap.SetCurrentMap (map, spot.MapId)
			end

			map.WorldHotspotTipStr = spot.NxTipBase .. "\n"
--[[
			if false then

				local tt = GameTooltip
				local owner = map.Win.Frm

				owner.NXTip = spot.NxTipBase

				if not tt:IsVisible() then

--					VFL.vprint ("hotspot tip")

					local tippos = "ANCHOR_TOPLEFT"

					Nx.TooltipOwner = owner ---
					map.TooltipType = 1

					tt:SetOwner (owner, tippos, 0, 0)
					Nx:SetTooltipText (owner.NXTip .. RDXMAP.PlyrNamesTipStr)

					owner["UpdateTooltip"] = RDXMAP.Map.OnUpdateTooltip
				end
			end
--]]
			return true
		end
	end
end

--------
-- Update 

function RDXMAP.APIMap.SetLevelWorldHotspots(map)
--[[
	local lvl =	map.NXCitiesUnder and -1 or 1

	for _, f in ipairs (map.WorldHotFrms) do
		if f.NXLev ~= 0 then		-- A city?
			f.NXLev = lvl
		end
	end
--]]
end

--------
-- Init hotspots

--[[

function RDXMAP.Map:InitHotspotsDebug()

	if 1 then return end

	NxData.NXDBHotspotsT = {}
--	NxData.NXDBHotspotsT = NxData.NXDBHotspotsT or {}

	self:InitHotspots2Debug (self.WorldHotspotsCity)
	self:InitHotspots2Debug (self.WorldHotspots)
end

function RDXMAP.Map:InitHotspots2Debug (quad)

	local saved = NxData.NXDBHotspotsT

	for n, spot in ipairs (quad) do

		local mapId = spot.MapId

		if mapId then
--		if mapId ~= 2042 and mapId ~= 2043 then
--		if mapId == 1014 or mapId > 4000 and mapId <= 5999 then

			local x, y = RDXMAP.APIMap.GetZonePos (mapId, spot.WX1, spot.WY1)
			local w, h = RDXMAP.APIMap.GetZonePos (mapId, spot.WX2, spot.WY2)

			local mapT = saved[mapId] or {}
			saved[mapId] = mapT

			local saveSpot = { X = x, Y = y, W = w - x, H = h - y }
			tinsert (mapT, saveSpot)
		end
	end
end

function RDXMAP.Map:HotspotDebugCmd (cmd)

	if cmd == "add" then

		local curT = self.HotspotDebugCurT
		if curT then
			VFL.vprint ("Add")

			local x, y = RDXMAP.APIMap.GetZonePos (self.DebugMapId, self.DebugWX or 0, self.DebugWY or 0)
			local spot = { X = x, Y = y, W = 10, H = 10 }
			tinsert (curT, spot)
		end

	elseif cmd == "del" then

		local curT = self.HotspotDebugCurT
		if curT then
			tremove (curT, self.HotspotDebugCurI)
		end
	end
end


function RDXMAP.Map:PackHotspotsDebug()

	local saved = NxData.NXDBHotspotsT

	if saved then

		local cnt = 0

		local packed = {}
		NxData.NXDBHotspotsPacked = packed

		for mapId, mapT in pairs (saved) do

			local s = ""

			for n, spot in ipairs (mapT) do

				local x = min (max (spot.X * 4095 / 100, 0), 4095)
				local y = min (max (spot.Y * 4095 / 100, 0), 4095)
				local w = min (max (spot.W * 4095 / 100, 0), 4095)
				local h = min (max (spot.H * 4095 / 100, 0), 4095)
				s = format ("%s%03x%03x%03x%03x", s, x, y, w, h)

				cnt = cnt + 1
			end

			packed[mapId] = s
		end

		VFL.vprint ("Packed %d", cnt)
	end
end

function RDXMAP.Map:UpdateHotspotsDebug()

	local saved = NxData.NXDBHotspotsT or {}
	NxData.NXDBHotspotsT = saved

	local curMapId = self.DebugMapId

	for mapId, mapT in pairs (saved) do

		local zscale = RDXMAP.APIMap.GetWorldZoneScale (mapId)

		for n, spot in ipairs (mapT) do

			local f = RDXMAP.APIMap.GetIcon (self, 0)

			local x, y = RDXMAP.APIMap.GetWorldPos (mapId, spot.X, spot.Y)
			if RDXMAP.APIMap.ClipFrameTL (self, f, x, y, spot.W * zscale, spot.H * zscale / 1.5) then

				f.NXType = 8000
				f.NXData = mapId
				f.NXData2 = n

				if IsControlKeyDown() then
					f.NxTip = format ("%s %d #%d\n%s %s\n%s %s", RDXMAP.APIMap.IdToName (mapId), mapId, n, spot.X, spot.Y, spot.W, spot.H)
				end

				if mapId == curMapId then

					if mapT == self.HotspotDebugCurT and n == self.HotspotDebugCurI then
						f.texture:SetTexture (.2, .2, .5, .5)
					else
						f.texture:SetTexture (0, 0, .4, .35)
					end
				else
					f.texture:SetTexture (.1, 0, 0, .3)
				end
			end

--			VFL.vprint ("spot #%d %s %s %s %s", n, spot.X, spot.Y, spot.W, spot.H)
		end
	end
end

function RDXMAP.Map:HotspotDebugClick (button)

--	this = self.Frm
	self.OnMouseDown (self.Frm, button)

	local icon = self.ClickFrm
	local mapId = icon.NXData

	if mapId == self.DebugMapId then

		local index = icon.NXData2

		local saved = NxData.NXDBHotspotsT

		self.HotspotDebugCurT = saved[mapId]
		self.HotspotDebugCurI = index

--		local spot = saved[mapId][index]
--		VFL.vprint ("spot #%d %s %s %s %s", n, spot.X, spot.Y, spot.W, spot.H)
	end
end

function RDXMAP.Map:HotspotDebugScroll (x, y)

	local curT = self.HotspotDebugCurT

	local spot = curT and curT[self.HotspotDebugCurI]
	if spot then

		x = x * 2
		y = y * 2

		if IsShiftKeyDown() then
			x = x * .05
			y = y * .05
		end

		if not IsAltKeyDown() then

			spot.X = spot.X + x
			spot.Y = spot.Y + y
		else
			spot.W = spot.W + x
			spot.H = spot.H + y
		end

		VFL.vprint ("%s spot #%d %s %s %s %s", self.DebugMapId, self.HotspotDebugCurI, spot.X, spot.Y, spot.W, spot.H)

		return true
	end
end

--]]
