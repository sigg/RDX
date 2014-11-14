

--------
-- Set map target name

function RDXMAP.APIMap.SetTargetName (name)

	local tar = RDXU.MapTargets[1]
	if tar then
		tar.n = name
	end
end

--------
-- Set map target at zone xy (pos 0-100)
-- Ret target table

function RDXMAP.APIMap.SetTargetXY (mid, zx, zy, name, keep)           

	RDXMapEvents:Dispatch("Watch:ClearAutoTarget");

	local wx, wy = RDXMAP.APIMap.GetWorldPos (mid, zx, zy)
	return RDXMAP.APIMap.SetTarget ("Goto", wx, wy, nil, name or "", keep, mid)
end

--------
-- Set map target at mouse click

function RDXMAP.APIMap.SetTargetAtClick(map)

	RDXMapEvents:Dispatch("Watch:ClearAutoTarget");


	local wx, wy = RDXMAP.APIMap.FramePosToWorldPos (map, map.ClickFrmX, map.ClickFrmY)
	local zx, zy = RDXMAP.APIMap.GetZonePos (map.MapId, wx, wy)
	local str = format ("Goto %.0f, %.0f", zx, zy)

	RDXMAP.APIMap.SetTarget ("Goto", wx, wy, nil, str, IsShiftKeyDown(), map.MapId)
end

function RDXMAP.APIMap.SetTargetAtStr (str, keep)

	local mId, zx, zy = RDXMAP.APIMap.ParseTargetStr (str)
	if mId then
		local wx, wy = RDXMAP.APIMap.GetWorldPos (mId, zx, zy)
		local str = format ("%.0f, %.0f", zx, zy)
		RDXMAP.APIMap.SetTarget ("Goto", wx, wy, nil, str, keep, mId)
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

function RDXMAP.APIMap.SetTarget (typ, x1, y1, id, name, keep, mapId)

	RDXMapEvents:Dispatch("SetTarget2", keep);

	local tar = {}
	tinsert (RDXU.MapTargets, tar)

	assert (x1)

	tar.t = typ
	tar.id = id
--	tar.ArrowPulse = 1

	tar.x = x1
	tar.y = y1
	tar.n = name

	tar.m = mapId

	return tar
end

function RDXMAP.APIMap.SetNodeTarget (node, keep)
	RDXMapEvents:Dispatch("SetTarget2", keep);
	tinsert(RDXU.MapTargets, node)
end

--------
-- Clear all targets
-- (matchType we will clear or nil for any)

function RDXMAP.APIMap.ClearTargets (matchType)

	if matchType then
		local tar = RDXU.MapTargets[1]
		if tar then
			if tar.t ~= matchType then
				return
			end
		end
	end

	RDXU.MapTargets = {}
	RDXMAP.Tracking = {}
	
	RDXMapEvents:Dispatch("ClearTargets");	
end

--------
--------
-- Get map target type, id

function RDXMAP.APIMap.GetTargetInfo()

	local tar = RDXU.MapTargets[1]
	if tar then
		return tar.t, tar.id
	end
end

--------
-- Get map target pos

function RDXMAP.APIMap.GetTargetPos()

	local tar = RDXU.MapTargets[1]
	if tar then
		return tar.x, tar.y
	end
end

--------
-- Changes indexed or last target to a new index

function RDXMAP.APIMap.ChangeTargetOrder (srcI, dstI)

	srcI = srcI >= 0 and srcI or #RDXU.MapTargets	-- -1 for last target

	local t = tremove (RDXU.MapTargets, srcI)
	tinsert (RDXU.MapTargets, dstI, t)

	RDXMAP.Tracking = {}
end

--------
-- Reverse order of all targets

function RDXMAP.APIMap.ReverseTargets()

	local tar = RDXU.MapTargets
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

	local tar = RDXU.MapTargets[1]
	if not tar.x then 
		VFL.print("Error Target");
		RDXU.MapTargets[1] = nil;
		return;
	end
	local x = tar.x - map.myunit.PlyrX
	local y = tar.y - map.myunit.PlyrY
	local distYd = (x * x + y * y) ^ .5 * 4.575

	if distYd < (tar.Radius or 7) * map.BaseScale then

		if tar.t ~= "Q" then	-- Not for quest, so clear

			map.UpdateTargetDelay = 20
			map.UpdateTrackingDelay = 0

--			VFL.vprintVar ("", RDXU.MapTargets[1])

			tremove (RDXU.MapTargets, 1)

			if #RDXU.MapTargets > 0 and map.GOpts["RouteRecycle"] then
				tinsert (RDXU.MapTargets, tar)
			end

			if map.GOpts["HUDTSoundOn"] then
				VFLIO.PlaySoundFile ("sound\\interface\\magicclick.wav")
			end

			--UIErrorsFrame:AddMessage ("Target " .. tar.TargetName .. " reached", 1, 1, 1, 1)
			UIErrorsFrame:AddMessage ("Target " .. tar.n .. " reached", 1, 1, 1, 1)

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

--local myunit;
--RDXEvents:Bind("INIT_POST", nil, function() myunit = RDXDAL.GetMyUnit(); end);	

function RDXMAP.APIMap.CalcTracking()

	local tr = {}
	RDXMAP.Tracking = tr
	local myunit = RDXDAL.GetMyUnit();
	local srcX = myunit.PlyrX
	local srcY = myunit.PlyrY
	local srcMapId = myunit.mapId

	for n, tar in ipairs (RDXU.MapTargets) do

		--RDXMAP.Travel:MakePath (tr, srcMapId, srcX, srcY, tar.m, tar.x, tar.y, tar.t)
		tinsert (tr, tar)

		srcX = tar.x
		srcY = tar.y
		srcMapId = tar.m
	end

end

function RDXMAP.APIMap.UpdateTracking(map)

	map.UpdateTrackingDelay = map.UpdateTrackingDelay - 1

	if map.UpdateTrackingDelay <= 0 then
		RDXMAP.APIMap.CalcTracking()
		map.UpdateTrackingDelay = 45
	end

	map.Level = map.Level + 2

	local dist1
	local dir1
	local srcX = map.myunit.PlyrX
	local srcY = map.myunit.PlyrY

	for n = 1, #RDXMAP.Tracking do

		local tr = RDXMAP.Tracking[n]

		RDXMAP.APIMap.DrawTracking (map, srcX, srcY, tr.x, tr.y, tr.t, tr.n)

		if n == 1 then
			map.TrackName = tr.n
			dist1 = map.TrackDistYd
			dir1 = map.TrackDir
		end

		srcX = tr.x
		srcY = tr.y
	end

	map.TrackDistYd = dist1
	map.TrackDir = dir1
end




-- new edition
function RDXMAP.APIMap.UpdateTargets2(map)

	local tar = RDXU.MapTargets[1]
	local srcX = map.myunit.PlyrX
	local srcY = map.myunit.PlyrY
	local x = tar.x - srcX
	local y = tar.y - srcY
	local distYd = (x * x + y * y) ^ .5 * 4.575
	local dist1
	local dir1

	if distYd < (tar.Radius or 7) * map.BaseScale then
		if tar.t ~= "Q" then	-- Not for quest, so clear
			tremove (RDXU.MapTargets, 1)
			if #RDXU.MapTargets > 0 and map.GOpts["RouteRecycle"] then
				tinsert (RDXU.MapTargets, tar)
			end
			if map.GOpts["HUDTSoundOn"] then
				VFLIO.PlaySoundFile ("sound\\interface\\magicclick.wav")
			end
			UIErrorsFrame:AddMessage ("Target " .. tar.n .. " reached", 1, 1, 1, 1)
		end
	end

	map.Level = map.Level + 2

	for n = 1, #RDXU.MapTargets do
		local tr = RDXU.MapTargets[n]
		
		if n == 1 then
			map.TrackName = tr.n
			dist1 = map.TrackDistYd
			dir1 = map.TrackDir
		end

		if tr.r then -- sub road
			for m = 1, #tr.r do
				local tr2 = tr.r[m]
				if m == 1 then
					map.TrackName = tr2.n
				end
				RDXMAP.APIMap.DrawTracking (map, srcX, srcY, tr2.x, tr2.y, tr2.t, tr2.n)
				
				srcX = tr2.x
				srcY = tr2.y
				
			end
		else
			RDXMAP.APIMap.DrawTracking (map, srcX, srcY, tr.x, tr.y, tr.t, tr.n)
			srcX = tr.x
			srcY = tr.y
		end
	end

	map.TrackDistYd = dist1
	map.TrackDir = dir1
end

function RDXMAP.APIMap.CalcTracking2()
	local myunit = RDXDAL.GetMyUnit();
	local srcX = myunit.PlyrX
	local srcY = myunit.PlyrY
	local srcMapId = myunit.mapId

	for n, tar in ipairs (RDXU.MapTargets) do
		tar.r = RDXMAP.APITravel.MakePath (srcMapId, srcX, srcY, tar.m, tar.x, tar.y, tar.t)
		srcX = tar.x
		srcY = tar.y
		srcMapId = tar.m
	end
end

RDXEvents:Bind("INIT_DESKTOP", nil, function()
	--VFLT.AdaptiveSchedule2("CalcTracking2", 5, RDXMAP.APIMap.CalcTracking2);
end);