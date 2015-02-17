
local i, j, k
local frms, frm
local mapId
local winfo, iinfo
local scale
local size
local x, y, w, h
local wx, wy, ww, wh
local cont, zone
local offx, offy
local tex

-- RDXMAP.APIMap

-- Center the map in view
function RDXMAP.APIMap.CenterMap(map, mapId, scale)

	mapId = mapId or map.MapId

--[[ -- Map capture
	if 1 then
		RDXMAP.APIMap.CenterMap1To1 (map, floor (mapId / 1000) * 1000)
		return
	end
--]]
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if winfo then
		if winfo.class == "ci" then
			scale = 1
		end
	else
		VFL.print("RDXMAP.APIMap.CenterMap, unknown mapId " .. mapId);
		return;
	end

	map.MapW = map.Frm:GetWidth() - map.PadX * 2
	map.MapH = map.Frm:GetHeight() - map.TitleH

	x, y = RDXMAP.APIMap.GetWorldPos (mapId, 50, 50)
	size = min (map.MapW / 1002, map.MapH / 668)
	if map.MapW < GetScreenWidth() / 2 then
		size = size * (scale or 1.5)
	end

	scale = size / RDXMAP.APIMap.GetWorldZoneScale (mapId) * 10.02

	RDXMAP.APIMap.Move (map, x, y, scale, 30)

--	VFL.vprint ("Center #%d %f (%f %f) (%d %d)", mapId, map.Scale, map.MapPosX, map.MapPosY, map.MapW, map.MapH)
end

--------
-- Center the map in view and 1 to 1 scale

function RDXMAP.APIMap.CenterMap1To1(map, mapId)

	map.MapPosX, map.MapPosY = RDXMAP.APIMap.GetWorldPos (mapId, 50, 50)

	map.Scale = 1002 / 100 / RDXMAP.APIMap.GetWorldZoneScale (mapId) * GetScreenWidth() / 1680 * 2
	map.ScaleDraw = map.Scale
	map.StepTime = 10
end

--------
-- Set the current using a map id

function RDXMAP.APIMap.SetCurrentMap (map, mapId)

	if mapId then

		RDXMAP.BaseScale = 1
		
		if RDXMAP.APIMap.IsInstanceMap(mapId) then
			RDXMAP.BaseScale = .025
			SetMapByID (mapId)
			SetDungeonMapLevel (1)
		elseif map.myunit.mapId == mapId then
			--VFL.print("SetMapToCurrentZone");
			SetMapToCurrentZone()
			-- do nothing
		else
			--VFL.print("SetMapByID " .. mapId);
			SetMapByID (mapId)
			--SetDungeonMapLevel (GetCurrentMapDungeonLevel)
		end
		map.InstLevelSet = GetCurrentMapDungeonLevel()
	else
		VFL.print("RDXMAP.APIMap.SetCurrentMap no mapid");
		--RDXMAP.APIMap.SetToCurrentZone();
	end
end

function RDXMAP.APIMap.SetInstanceMap (map, mapId)	
	map.InstMapId = nil
	if not mapId then
		return
	end

	-- store texture
	iinfo = RDXMAP.Map.InstanceInfo[mapId]
    
    if not(iinfo) then
        RDXMAP.APIMap.GetInstanceMapTextures(mapId)		
        iinfo = RDXMAP.Map.InstanceInfo[mapId]
    end
	
	x, y = 1002, 668	
	if iinfo then	
		RDXMAP.APIMap.SetCurrentMap (map, mapId)		
		map.InstMapId = mapId
		map.InstMapInfo = iinfo
		winfo = RDXMAP.APIMap.GetWorldZone(mapId)
		--wx = winfo[4]
		--wy = winfo[5]
		wx = winfo.x
		wy = winfo.y
		map.InstMapWX1 = wx
		map.InstMapWY1 = wy
		map.InstMapWX2 = wx + x / 256
		map.InstMapWY2 = wy + y / 256 * #iinfo / 3
	end
end

--------
-- Update instance map

function RDXMAP.APIMap.UpdateInstanceMap(map)

	mapId = map.InstMapId
	if not mapId then
		return
	end
	winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	iinfo = map.InstMapInfo				-- Valid if Id not nil

--	VFL.vprint ("Inst id %s", mapId)

	wx = winfo.x
	wy = winfo.y

	for n = 1, #iinfo, 3 do

		j = 1

		offx = 0		-- iinfo[n] * .04 * 1002 / 1024
		offy = iinfo[n + 1] * .03 * 668 / 768

		for by = 0, 2 do

			for bx = 0, 3 do

				i = 1
				frm = RDXMAP.APIMap.GetIconNI(map)

--					VFL.vprint ("Inst %s, %s %s %s %s", mapId, wx, wy, bx, by)

				if RDXMAP.APIMap.ClipFrameTL (map, frm, wx + bx - offx, wy + by - offy, i, i) then
					tex = iinfo[n + 2]
					tex = "Interface\\WorldMap\\" .. tex .. j
					frm.texture:SetTexture (tex)
				end

				j = j + 1
			end
		end
	end

	map.Level = map.Level + 1

end
--------
-- Switch to a new map

function RDXMAP.APIMap.SwitchRealMap (map, id)	
	if RDXMAP.APIMap.IsInstanceMap (id) then
		RDXMAP.APIMap.SetInstanceMap (map, id)			-- Turn it on
	else
		RDXMAP.APIMap.SetInstanceMap(map)				-- Turn it off
	end

	if map.GOpts["MapMMInstanceTogFullSize"] then
		map.LOpts.NXMMFull = false
		if RDXMAP.APIMap.IsInstanceMap (id) then
			map.LOpts.NXMMFull = true
		end
	else
		if RDXMAP.APIMap.IsInstanceMap(id) then		
			s = map.Scale
			map.Scale = 120.0			
		else
			map.Scale = map.RealScale			
		end
	end
end

--------
-- Goto current zone and center map

function RDXMAP.APIMap.GotoCurrentZone(map)

--	VFL.vprint ("GotoCurrentZone")
	local myunit = RDXDAL.GetMyUnit();

	if myunit.InstanceId then
		RDXMAP.APIMap.Move (map, myunit.PlyrX, myunit.PlyrY, 20, 30)
	else

		--RDXMAP.APIMap.SetToCurrentZone()
		--mapId = RDXMAP.APIMap.GetCurrentMapId()
		RDXMAP.APIMap.CenterMap (map, myunit.mapId)
	end
end

--------
-- Set the map to current zone

function RDXMAP.APIMap.SetToCurrentZone()

	SetMapToCurrentZone()

	-- to be analyse
	--if i == 321 then					-- Orgrimmar
	--	SetDungeonMapLevel (1)			-- Don't allow cleft of shadows
	--end

end

--------
-- Goto current zone and cause player moved update

function RDXMAP.APIMap.GotoPlayer(map)

--	VFL.vprint ("GotoPlayer")

	--RDXMAP.APIMap.CalcTracking()

	--RDXMAP.APIMap.SetToCurrentZone()

	map.MoveLastX = -1
	map.MoveLastY = -1
end

--------
-- Move map

function RDXMAP.APIMap.Move (map, x, y, scale, stepTime)

--	VFL.vprint ("Move %s %s sc %s time %s", x, y, scale or "nil", stepTime)

	map.MapPosX = x
	map.MapPosY = y

	if scale then
		map.Scale = scale
	end

	i = ((map.MapPosXDraw - map.MapPosX) ^ 2 + (map.MapPosYDraw - map.MapPosY) ^ 2) ^ .5

	j = max (map.MapW, map.MapH)

--	VFL.vprint ("Move dist %f %f val %f", j, i, i * map.Scale / j)

	if i * map.Scale / j > 10 then	-- Zoomed in and a large jump?
		stepTime = 1	-- Go fast
	end

--	VFL.vprint ("Move #%d %f steptime %f ", map.Tick, i, map.StepTime)

	k = abs (map.StepTime)	-- Will be neg if triggered

	if k > 0 and k < stepTime then		-- Already stepping? Use short time
		stepTime = k
--		VFL.vprint ("Move steptime %f", stepTime)
	end

	map.StepTime = stepTime

	if i < .25 then

--		VFL.vprint ("Move snap XY")

		map.MapPosXDraw = map.MapPosX
		map.MapPosYDraw = map.MapPosY
	end

	if abs (1 / map.ScaleDraw - 1 / map.Scale) < .01 then
		map.ScaleDraw = map.Scale

--		VFL.vprint ("Move snap scale")

		if i < .25 then
			map.StepTime = 0
		end
	end


	--if map.Debug then
		--local plZX, plZY = GetPlayerMapPosition ("player")
		--VFL.vprint("Move %f %f (%f %f)", x, y, plZX, plZY)
	--end

end

--------
-- Convert frame (top left) to world positions

function RDXMAP.APIMap.FramePosToWorldPos (map, x, y)
	x = map.MapPosX + (x - map.PadX - map.MapW / 2) / 10.02 / map.MapScale
	y = map.MapPosY + (y - map.TitleH - map.MapH / 2) / 10.02 / map.MapScale
	return x, y
end