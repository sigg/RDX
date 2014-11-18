
local i, j, k
local s
local t
local flag
local frms, frm
local opts
local mapId
local winfo
local wzone
local alpha, alphaRange, alphaPer
local scale
local size
local clipW
local clipH
local texX1, texX2
local texY1, texY2
local vx0, vx1, vx2
local vy0, vy1, vy2
local x, y, w, h
local bx, by, bw, bh
local mx, my
local wx, wy, ww, wh
local zname
local zx, zy, zw, zh

--------
-- Update continent frames

function RDXMAP.APIMap.UpdateContinents(map)

	if map.CurOpts.NXWorldShow then
		
		for contN = 1, #map.ContFrms do
			i = contN <= 2 and map.Level or map.Level + 1
			RDXMAP.APIMap.MoveZoneTiles (map, map.ContFrms[contN].mapid, map.ContFrms[contN], map.WorldAlpha, i)
		end

		map.Level = map.Level + 2

	else
		
		for contN = 1, #Nmap.ContFrms do
			frms = map.ContFrms[contN]

			for i = 1, 12 do
				frm = frms[i]
				if frm then
					frm:Hide()
				end
			end
		end

		if map.ContFillFrm then
			map.ContFillFrm:Hide()
		end
	end
end

--------
-- Update map zone tiles

function RDXMAP.APIMap.MoveCurZoneTiles (map, clear)

	mapId = map.MapId
	wzone = RDXMAP.APIMap.GetWorldZone (mapId)
	local myunit = RDXDAL.GetMyUnit();

	--if not clear and (not wzone or wzone.class == "ci" or (wzone.StartZone and myunit.mapId == mapId) or RDXMAP.APIMap.IsBattleGroundMap (mapId)) or RDXMAP.APIMap.IsMicroDungeon(mapId) then
	if not clear and (not wzone or wzone.class == "ci" or wzone.StartZone or RDXMAP.APIMap.IsBattleGroundMap (mapId)) then
--		VFL.vprint ("MoveCurZoneTiles %d", mapId)
		--VFL.print("RDXMAP.APIMap.MoveCurZoneTiles " .. mapId);

		alpha = map.BackgndAlpha * (wzone.Alpha or 1)

		RDXMAP.APIMap.MoveZoneTiles (map, mapId, map.TileFrms, alpha, map.Level)
		map.Level = map.Level + 1

	else

		frms = map.TileFrms

		for i = 1, 12 do
		frm = frms[i]
			if frm then
				frm:Hide()
			end
		end
	end
end



--------
-- Hide extra (Dalaran) map zone tiles

function RDXMAP.APIMap.HideExtraZoneTiles(map)
	frms = map.TileFrms
	frms[4]:Hide()
	frms[8]:Hide()
	frms[9]:Hide()
	frms[12]:Hide()
end


--------
-- Update map zone tiles (4x3 blocks)

function RDXMAP.APIMap.MoveZoneTiles (map, mapid, frms, alpha, level)
	
	zname, zx, zy, zw, zh = RDXMAP.APIMap.GetWorldZoneInfo (mapid)
	if not zx then
		VFL.print("function RDXMAP.APIMap.MoveZoneTiles no ZX");
		return
	end

--	VFL.vprint ("MapZ %f, %f", zx, zy)

	scale = map.ScaleDraw

	clipW = map.MapW
	clipH = map.MapH
	x = (zx - map.MapPosXDraw) * scale + clipW / 2
	y = (zy - map.MapPosYDraw) * scale + clipH / 2
	bx = 0
	by = 0
	bw = zw * 1024 / 1002 / 4 * scale
	bh = zh * 768 / 668 / 3 * scale

	for i = 1, 12 do

		frm = frms[i]
		if frm then

			texX1 = 0
			texX2 = 1
			texY1 = 0
			texY2 = 1

			vx0 = bx * bw + x
			vx1 = vx0
			vx2 = vx0 + bw

			if vx1 < 0 then
				vx1 = 0
				texX1 = (vx1 - vx0) / bw
			end

			if vx2 > clipW then
				vx2 = clipW
				texX2 = (vx2 - vx0) / bw
			end

			vy0 = by * bh + y
			vy1 = vy0
			vy2 = vy0 + bh

			if vy1 < 0 then
				vy1 = 0
				texY1 = (vy1 - vy0) / bh
			end

			if vy2 > clipH then
				vy2 = clipH
				texY2 = (vy2 - vy0) / bh
			end

			w = vx2 - vx1
			h = vy2 - vy1
			--VFL.print(frm.texture:GetTexture());

			if w <= 0 or h <= 0 then
				frm:Hide()
			else
				frm:SetPoint ("TOPLEFT", vx1, -vy1 - map.TitleH)
				frm:SetWidth (w)
				frm:SetHeight (h)
				frm:SetFrameLevel (level)

				frm.texture:SetTexCoord (texX1, texX2, texY1, texY2)
				--frm.texture:SetVertexColor (1, 1, 1, map.BackgndAlpha)
				
				frm:Show()
			end
		end

		bx = bx + 1

		if bx >= 4 then
			bx = 0
			by = by + 1
		end
	end
end

--------
-- Add old map zone to list

function RDXMAP.APIMap.AddOldMap (map, newMapId)
	
	if map.MapId == 0 then		-- Happens on startup
		return
	end

	-- Remove any for new zone

	i = 1
	flag = nil;

	for n = 1, #map.MapsDrawnOrder do
		if map.MapsDrawnOrder[i] == newMapId then
			tremove (map.MapsDrawnOrder, i)
			flag = true
		else
			i = i + 1
		end
	end

	i = map.GOpts["MapZoneDrawCnt"]

	if not flag then

--		VFL.vprint ("no dup")

		j = #map.MapsDrawnOrder - i + 2
		for n = 1, j do
			tremove (map.MapsDrawnOrder, 1)
		end
	end

	if i > 1 then

		map.MapsDrawnFade[map.MapId] = -1
		tinsert (map.MapsDrawnOrder, map.MapId)		-- Newest at end

--		VFL.vprint ("Cur map %s", RDXMAP.APIMap.GetCurrentMapId())
--		VFL.vprintVar ("order", map.MapsDrawnOrder)
	end
end

--------
-- Update the zones or city or micro

function RDXMAP.APIMap.UpdateZones(map)

	mapId = map.MapId
	--VFL.print("MapId " .. map.MapId);
	--VFL.print("myunit.mapId  " ..myunit.mapId);
	winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if not winfo then
		if map.MapId then
			--VFL.print("UpdateZones MapId unknown " .. map.MapId);
		else
			--VFL.print("UpdateZones no MapId");
		end
		return
	end

--	VFL.vprint ("UpdateZones %s, %s", mapId, winfo.Name or "nil")

	s = map.LOpts.NXDetailScale

	-- freeOrScale
	flag = map.ScaleDraw <= s
	--flag = false
	--local myunit = RDXDAL.GetMyUnit();
	--if flag or winfo.class == "ci" or (winfo.StartZone and myunit.mapId == mapId) or RDXMAP.APIMap.IsBattleGroundMap (mapId) or RDXMAP.APIMap.IsMicroDungeon(mapId) then
	if flag or winfo.class == "ci" or winfo.StartZone or RDXMAP.APIMap.IsBattleGroundMap (mapId) then
	
--		if flag and map.MapIdOld and map.MapIdOld ~= mapId then
--			RDXMAP.APIMap.UpdateOverlay (map, id, .8, true)
--		end
		for n, id in ipairs (map.MapsDrawnOrder) do
			RDXMAP.APIMap.UpdateOverlay (map, id, .8, true)
		end
--[[
		if flag then

			local abs = abs

			for id, fade in pairs (map.MapsDrawnFade) do

				if id ~= mapId then
					RDXMAP.APIMap.UpdateOverlay (map, id, abs (fade) * .8, true)
				end

				if fade > 0 then
					fade = fade + .1
					map.MapsDrawnFade[id] = fade <= 1 and fade or 1

				elseif fade < 0 then
					fade = fade + .1
					map.MapsDrawnFade[id] = fade < 0 and fade or nil
				end
			end
		end
--]]
--[[
			if mapId >= 1000 and mapId <= 1999 then

				for id = 1001, 1024 do
					if id ~= mapId then
						RDXMAP.APIMap.UpdateOverlay (map,  id, .8)
					end
				end

			elseif mapId >= 2000 and mapId <= 2999 then

				for id = 2001, 2028 do
					if id ~= mapId then
						RDXMAP.APIMap.UpdateOverlay (map, id, .8)
					end
				end

			elseif mapId >= 3000 and mapId <= 3999 then

				for id = 3001, 3008 do
					if id ~= mapId then
						RDXMAP.APIMap.UpdateOverlay (map, id, .8)
					end
				end
			end
--]]
		if winfo.class == "ci" then
--			VFL.vprint ("city %s", map.Level)
			RDXMAP.APIMap.UpdateMiniFrames(map)
			RDXMAP.APIMap.MoveCurZoneTiles(map)

		else
			--RDXMAP.APIMap.UpdateOverlayUnexplored(map)
			RDXMAP.APIMap.MoveCurZoneTiles(map)   -- contour ?
			RDXMAP.APIMap.UpdateOverlay (map, mapId, 1, nil, true)
			RDXMAP.APIMap.UpdateMiniFrames(map)
		end

	else
		RDXMAP.APIMap.MoveCurZoneTiles (map, true)		-- Clear
		RDXMAP.APIMap.UpdateMiniFrames(map)

	end
end

--------
-- Update frames for mini map texture layer (detail layer)

function RDXMAP.APIMap.UpdateMiniFrames(map)
	--VFL.print("UpdateMiniFrames");
--[[
	SaveView (5)
--	local x = GetCVar ("cameraYawD")
--	local y = GetCVar ("cameraPitchD")
--	local isLook = IsMouselooking()

--	VFL.vprintCtrl ("Cam %s %s %s", x, y, isLook or "nil")

	local vartest = {
		"cameraYaw",
		"cameraYawA",
		"cameraYawB",
		"cameraYawC",
		"cameraYawD",
	}

	for k, name in pairs (vartest) do
		VFL.vprintCtrl ("Cam %s %s", name, GetCVar (name) or "nil")
		VFL.vprint("Cam %s %s", name, GetCVar (name) or "nil")
	end
--]]
	
	mapId = map.MapId
	winfo = RDXMAP.APIMap.GetWorldZone(mapId)

	opts = map.LOpts

	alphaRange = opts.NXDetailScale * .35
	i = opts.NXDetailScale - alphaRange

--	i = .1

--	or winfo.class == "ci"

	if map.ScaleDraw <= i or opts.NXDetailAlpha <= 0 or RDXMAP.APIMap.IsBattleGroundMap (mapId) then
		RDXMAP.APIMap.HideMiniFrames(map)
		return
	end

	alphaPer = min ((map.ScaleDraw - i) / alphaRange, 1)
--	VFL.vprint ("alpha %s", alphaPer)

--	local zname, zx, zy

	flag, bx, by = RDXMAP.APIMap.GetMiniInfo (mapId)
	if not flag then
		RDXMAP.APIMap.HideMiniFrames(map)
		return
	end

	i = map.Level
	map.Level = map.Level + 1

	j = 1

	scale = 256 * 0.416767770014
	size = scale

--	size = size - 4

	mx = floor ((map.MapPosXDraw - bx) / scale - map.MiniBlks / 2 + .5)
	my = floor ((map.MapPosYDraw - by) / scale - map.MiniBlks / 2 + .5)

--	VFL.vprint ("MiniXY %f %f", mx, my)

	bx = bx + mx * scale
	by = by + my * scale

	wy = by
	alpha = map.BackgndAlpha * opts.NXDetailAlpha * alphaPer

	for y = my, my + map.MiniBlks - 1 do

		wx = bx

		for x = mx, mx + map.MiniBlks - 1 do

			frm = map.MiniFrms[j]
			s = RDXMAP.APIMap.GetMiniBlkName (flag, x, y)

			if s then
			
				if RDXMAP.APIMap.ClipFrameTL (map, frm, wx, wy, size, size) then

					frm:SetFrameLevel (i)
					--frm.texture:SetVertexColor (1, 1, 1, alpha)
					frm.texture:SetVertexColor (1, 1, 1, alpha)
--					s = "Textures\\Minimap\\"..s
					--VFL.print(s);
					frm.texture:SetTexture (s)

--[[
--					VFL.vprintCtrl ("%s %s, %s", x, y, s)

					local r, r2, r3 = frm.texture:SetTexture (s)		--V4 always returns r=1?
					VFL.vprintVar ("mmtex", r)
					VFL.vprintVar ("mmtex2", r2)
					VFL.vprintVar ("mmtex3", r3)
					if not r then
						VFL.vprintCtrl ("%s %s, %s", x, y, s)
					end
--]]
				end

			else

				frm:Hide()
			end

			wx = wx + scale
			j = j + 1
		end

		wy = wy + scale
	end

end

function RDXMAP.APIMap.HideMiniFrames(map)

	for n = 1, map.MiniBlks ^ 2 do
		map.MiniFrms[n]:Hide()
	end
end
