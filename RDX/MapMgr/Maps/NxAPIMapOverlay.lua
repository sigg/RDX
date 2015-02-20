
local i, j, k
local s
local t
local flag
local frms, frm
local mapId
local wzone
local alpha
local scale
local x, y
local bx, by, bw, bh
local wx, wy
local zname
local zx, zy, zw, zh
local s1, s2, folder, file
local txPixelW, txFileW, txPixelH, txFileH

function RDXMAP.APIMap.GetExploredOverlayNum(map)

--	local overlayNum = GetNumMapOverlays()		-- Cartographer makes this return 0

	for i = 1, 999 do
		s = GetMapOverlayInfo (i)
		if not s then
			return i
		end
	end
end

function RDXMAP.APIMap.TargetOverlayUnexplored(map)

	mapId = RDXMAP.APIMap.GetCurrentMapId()

	RDXMAP.APIMap.ClearTargets()		-- Will change current mapid

	wzone = RDXMAP.APIMap.GetWorldZone (mapId)
	if wzone and wzone.class == "ci" then
		return
	end

	t = map.CurOverlays

	if not t then	-- Not found? New stuff probably
		VFL.print("ERROR T");
		return
	end

	for txName, whxyStr in pairs (t) do

		zx, zy, zw, zh = strsplit (",", whxyStr)

		zx = tonumber (zx)
		zy = tonumber (zy)

		if zx >= 0 then

			zw = tonumber (zw)
			zh = tonumber (zh)

			if zw == 512 then
				zw = zw * .75
			end
			if zh == 512 then
				zh = zh * .75
			end

--			VFL.vprint ("%s %s %s %s %s", txName, zx, zy, zw, zh)

			x, y = (zx + zw / 2) / 1002 * 100, (zy + zh / 2) / 668 * 100
--			local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, (zx) / 1002 * 100, (zy) / 668 * 100)

			RDXMAP.APIMap.SetTargetXY (mapId, x, y, "Explore", true)
		end
	end
end

function RDXMAP.APIMap.UpdateOverlayUnexplored(map)

	map.CurOverlays = false
	s = nil

	mapId = RDXMAP.APIMap.GetCurrentMapId()

	wzone = RDXMAP.APIMap.GetWorldZone (mapId)
	if wzone then
		if wzone.class == "ci" then
			return
		end
		s = wzone.o
	end

	t = nil
	
	if s then
		t = NxMap.ZoneOverlays[s]
	end

	if not t or not map.LOpts.NXShowUnexplored then

		--local overlayNum = GetNumMapOverlays()		-- Cartographer makes this return 0
		--VFL.vprint ("Overlays %s", overlayNum)

		--local s1, s2, file
		local ol = {}

		if t then
			for txName, whxyStr in pairs (t) do	-- Copy overlay table
				ol[txName] = whxyStr
			end
		end

		t = ol
		--VFL.print("**************************");

		for i = 1, 99 do

			-- Terrokar has 4 overlays with "" for name
			zname, zw, zh, zx, zy = GetMapOverlayInfo (i)
			if not zname then
				break
			end
			--VFL.print(zname);
			--VFL.print(zw .. "," .. zh .. "," .. zx .."," .. zy);

			s1, s2, folder, file = strfind (zname, ".+\\.+\\(.+)\\(.+)")
			if s1 then
				--if folder and file then
				--	VFL.print(folder .. "\\" .. file);
				--end
				s = folder
				file = strlower (file)
				t[file] = format ("%d,%d,%d,%d", zx - 10000, zy, zw, zh)

				--VFL.vprint (" %s %s", zname, format ("%d,%d,%d,%d", zx, zy, zw, zh))
			end
		end

		if not s then		-- Can happen on log in
			t = false
		end
	end

	map.CurOverlays = t
	map.CurOverlaysTexFolder = s
end

--------
-- Update the overlays

function RDXMAP.APIMap.UpdateOverlay (map, mapId, bright, noUnexplored, main)

	wzone = RDXMAP.APIMap.GetWorldZone (mapId)
	-- sigg startzone isssu pandaria
	--if wzone and (wzone.class == "ci" or wzone.StartZone or RDXMAP.APIMap.IsMicroDungeon(mapId)) then
	--if wzone and wzone.class == "ci" then
	--	return
	--end

	s = wzone and wzone.o or ""
	t = NxMap.ZoneOverlays[s]
	flag = nil;
	local myunit = RDXDAL.GetMyUnit();

	if not noUnexplored and (not t or not map.LOpts.NXShowUnexplored) then --and myunit.mapId == mapId then

		if not (wzone and wzone.Explored) then
			flag = true
		end

		t = map.CurOverlays
		s = map.CurOverlaysTexFolder
	end

	if not t then	-- Not found? New stuff probably
		--VFL.print("RDXMAP.APIMap.UpdateOverlay not found " .. mapId)
		return
	end

	s1 = "Interface\\Worldmap\\" .. s .. "\\"

	alpha = map.BackgndAlpha

	scale = RDXMAP.APIMap.GetWorldZoneScale (mapId) / 10

	for txName, whxyStr in pairs (t) do

		j = 0
		if main then j = 1; end
		k = bright

		txName = s1 .. txName

		zx, zy, zw, zh, zname = strsplit (",", whxyStr)

		zw = tonumber (zw)
		zh = tonumber (zh)
		zx = tonumber (zx)
		zy = tonumber (zy)

		if flag then		-- Dimming unexplored?
			if zx < 0 then
				zx = zx + 10000	-- Fix explored x
			else
				k = map.LOpts.NXUnexploredAlpha		-- Dim
				j = 1
			end
		end

--		if map.Debug then
--			VFL.vprint ("%d %f %f", i, zx, zy)
--		end

		bw = ceil (zw / 256)
		bh = ceil (zh / 256)
		i = 1

		for bY = 0, bh - 1 do

			if bY < bh - 1 then
				txPixelH = 256
				txFileH = 256
			else
				txPixelH = mod (zh, 256)
				if txPixelH == 0 then
					txPixelH = 256
				end
				txFileH = 16
				while txFileH < txPixelH do
					txFileH = txFileH * 2
				end
			end

			for bX = 0, bw - 1 do

				if bX < bw - 1 then
					txPixelW = 256
					txFileW = 256
				else
					txPixelW = mod (zw, 256)
					if txPixelW == 0 then
						txPixelW = 256
					end
					txFileW = 16
					while txFileW < txPixelW do
						txFileW = txFileW * 2
					end
				end

				frm = RDXMAP.APIMap.GetIconNI (map, j)

				wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, (zx + bX * 256) / 1002 * 100, (zy + bY * 256) / 668 * 100)

				if RDXMAP.APIMap.ClipFrameTL (map, frm, wx, wy, txFileW * scale, txFileH * scale) then

--					if IsShiftKeyDown() then
--						frm.texture:SetTexture (1, 0, 0)
--					end
--[[
					if IsAltKeyDown() then		-- DEBUG!
						alpha = .2
					end
--]]
					--VFL.print(txName);
					frm.texture:SetTexture (zname and txName or txName .. i)
					frm.texture:SetVertexColor (k, k, k, alpha)

--					if IsControlKeyDown() then
--						VFL.vprint ("Overlay %s, %s, %s %s", txName, i, zx, zy)
--					end

--[[ -- Map cap
					if bright < 1 then
						frm.texture:SetVertexColor (1, 1, 1, 1)
--						SetDesaturation (frm.texture, 1)
					end
--]]
				end

				i = i + 1
			end
		end
	end

	-- Don't understand why
	map.Level = map.Level + 2
end