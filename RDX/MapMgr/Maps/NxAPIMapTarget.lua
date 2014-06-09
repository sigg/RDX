

--------
-- Set map target name

function RDXMAP.APIMap.SetTargetName (name)

	local tar = RDXMAP.Targets[1]
	if tar then
		tar.TargetName = name
	end
end

--------
-- Set map target at zone xy (pos 0-100)
-- Ret target table

function RDXMAP.APIMap.SetTargetXY (mid, zx, zy, name, keep)           

	Nx.Quest.Watch:ClearAutoTarget()

	local wx, wy = RDXMAP.APIMap.GetWorldPos (mid, zx, zy)
	return RDXMAP.APIMap.SetTarget ("Goto", wx, wy, wx, wy, nil, nil, name or "", keep, mid)
end

--------
-- Set map target at mouse click

function RDXMAP.APIMap.SetTargetAtClick(map)

	Nx.Quest.Watch:ClearAutoTarget()

	local wx, wy = RDXMAP.APIMap.FramePosToWorldPos (map, map.ClickFrmX, map.ClickFrmY)
	local zx, zy = RDXMAP.APIMap.GetZonePos (map.MapId, wx, wy)
	local str = format ("Goto %.0f, %.0f", zx, zy)

	RDXMAP.APIMap.SetTarget ("Goto", wx, wy, wx, wy, nil, nil, str, IsShiftKeyDown(), map.MapId)
end

function RDXMAP.APIMap.SetTargetAtStr (str, keep)

	local mId, zx, zy = RDXMAP.APIMap.ParseTargetStr (str)
	if mId then
		local wx, wy = RDXMAP.APIMap.GetWorldPos (mId, zx, zy)
		local str = format ("%.0f, %.0f", zx, zy)
		RDXMAP.APIMap.SetTarget ("Goto", wx, wy, wx, wy, nil, nil, str, keep, mId)
	end
end

--------
-- Parse map target string. "[zone] x y"
-- (string)

function RDXMAP.APIMap.ParseTargetStr (str)

--	VFL.vprint (str)

	local str = gsub (strlower (str), ",", " ")

	local zone
	local zx, zy

	for s in gmatch (str, "%S+") do
		local i = tonumber (s)
		if i then
			if zx then
				zy = zy or i
			else
				zx = i
			end
		else
			if zone then
				zone = zone .. " " .. s
			else
				zone = s
			end
		end
	end

	local myunit = RDXDAL.GetMyUnit();
	local mid = myunit.mapId

	if zone then

		mid = nil
		local tbl = RDXMAP.MapNameToId;
		for name, id in pairs (tbl) do
			if strfind (strlower (name), zone, 1, true) then
				mid = id
--				VFL.vprint (" %s", name)
				break
			end
		end

		if not mid then
			VFL.vprint ("zone %s not found", zone)
			return
		end
	end

	if not zx or not zy then
		VFL.vprint ("zone coordinate error")
		return
	end

	return mid, zx, zy
end

--------
-- Set map target
-- (type string, x, y, x2, y2, texture (nil for default, false for none), user id, name)

function RDXMAP.APIMap.SetTarget (typ, x1, y1, x2, y2, tex, id, name, keep, mapId)

	RDXMapEvents:Dispatch("SetTarget2", keep);

	local tar = {}
	tinsert (RDXMAP.Targets, tar)

	assert (x1)

	tar.TargetType = typ
	tar.TargetX1 = x1
	tar.TargetY1 = y1
	tar.TargetX2 = x2
	tar.TargetY2 = y2
	tar.TargetMX = (x1 + x2) * .5		-- Mid point
	tar.TargetMY = (y1 + y2) * .5
	tar.TargetTex = tex
	tar.TargetId = id
	tar.TargetName = name
--	tar.ArrowPulse = 1

	--mapId = mapId or map.MapId
	tar.MapId = mapId

	--local i = map.TargetNextUniqueId
	--tar.UniqueId = i
	--map.TargetNextUniqueId = i + 1

	local typ = keep and "Target" or "TargetS"
	local zx, zy = RDXMAP.APIMap.GetZonePos (mapId, tar.TargetMX, tar.TargetMY)

	Nx.Fav:Record (typ, name, mapId, zx, zy)

	return tar
end

--------
-- Clear all targets
-- (matchType we will clear or nil for any)

function RDXMAP.APIMap.ClearTargets (matchType)

	if matchType then
		local tar = RDXMAP.Targets[1]
		if tar then
			if tar.TargetType ~= matchType then
				return
			end
		end
	end

	RDXMAP.Targets = {}
	RDXMAP.Tracking = {}
	
	RDXMapEvents:Dispatch("ClearTargets");	
end

--------
--------
-- Get map target type, id

function RDXMAP.APIMap.GetTargetInfo()

	local tar = RDXMAP.Targets[1]
	if tar then
		return tar.TargetType, tar.TargetId
	end
end

--------
-- Get map target pos

function RDXMAP.APIMap.GetTargetPos()

	local tar = RDXMAP.Targets[1]
	if tar then
		return tar.TargetX1, tar.TargetY1, tar.TargetX2, tar.TargetY2
	end
end

--------
-- Changes indexed or last target to a new index

function RDXMAP.APIMap.ChangeTargetOrder (srcI, dstI)

	srcI = srcI >= 0 and srcI or #RDXMAP.Targets	-- -1 for last target

	local t = tremove (RDXMAP.Targets, srcI)
	tinsert (RDXMAP.Targets, dstI, t)

	RDXMAP.Tracking = {}
end

--------
-- Reverse order of all targets

function RDXMAP.APIMap.ReverseTargets()

	local tar = RDXMAP.Targets
	local n2 = #tar

	for n = 1, n2 / 2 do
		local a = tar[n]
		tar[n] = tar[n2]
		tar[n2] = a
		n2 = n2 - 1
	end

	RDXMAP.Tracking = {}
end

--------
-- Targets

function RDXMAP.APIMap.UpdateTargets(map)

	local delay = map.UpdateTargetDelay
	if delay > 0 then
		map.UpdateTargetDelay = delay - 1
		return
	end

	local tar = RDXMAP.Targets[1]
	local myunit = RDXDAL.GetMyUnit();

	local x = tar.TargetMX - myunit.PlyrX
	local y = tar.TargetMY - myunit.PlyrY
	local distYd = (x * x + y * y) ^ .5 * 4.575

	if distYd < (tar.Radius or 7) * map.BaseScale then

		if tar.TargetType ~= "Q" then	-- Not for quest, so clear

			map.UpdateTargetDelay = 20
			map.UpdateTrackingDelay = 0

--			VFL.vprintVar ("", RDXMAP.Targets[1])

			tremove (RDXMAP.Targets, 1)

			if #RDXMAP.Targets > 0 and map.GOpts["RouteRecycle"] then
				tinsert (RDXMAP.Targets, tar)
			end

			if map.GOpts["HUDTSoundOn"] then
				Nx:PlaySoundFile ("sound\\interface\\magicclick.wav")
			end

			UIErrorsFrame:AddMessage ("Target " .. tar.TargetName .. " reached", 1, 1, 1, 1)

			RDXMapEvents:Dispatch("Guide:ClearAll")

			-- deprecated
			--if tar.RadiusFunc then
--				VFL.vprint ("Target radius func")
			--	tar.RadiusFunc ("distance", tar.UniqueId, tar.Radius, distYd, distYd)
			--	tar.RadiusFunc = nil
			--end
		end
	end
end

