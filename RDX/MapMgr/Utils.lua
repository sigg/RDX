

--------
-- Get centered position of objective

function RDXMAP.GetObjectivePos (str)

	local name, zone, loc = RDXMAP.UnpackObjective (str)

	if zone then
		return name, zone, RDXMAP.GetPosLoc (str, loc)		-- x, y
	end
end


--------
-- Get size of objective or start/end

function RDXMAP.GetObjectiveRect (str, loc)

	local x1 = 100
	local y1 = 100
	local x2 = 0
	local y2 = 0
	local cnt

	if strbyte (str, loc) == 32 then  -- Point

		cnt = floor ((#str - loc) / 4)
		local x, y

		for locN = loc + 1, loc + cnt * 4, 4 do

--			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

			x, y = RDXMAP.UnpackLocPtOff (str, locN)
			x1 = min (x1, x)
			y1 = min (y1, y)
			x2 = max (x2, x)
			y2 = max (y2, y)
		end

	elseif strbyte (str, loc) == 33 then  -- Point

		x1, y1 = RDXMAP.UnpackLocPtRelative (str, loc + 1)
		x2, y2 = x1, y1

	else -- Multiple locations

		loc = loc - 1

		cnt = floor ((#str - loc) / 4)

		for locN = loc + 1, loc + cnt * 4, 4 do

			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

			local x, y, w, h = RDXMAP.UnpackLocRect (loc1)

			x1 = min (x1, x)
			y1 = min (y1, y)
			x2 = max (x2, x + w / 1002 * 100)
			y2 = max (y2, y + h / 668 * 100)

--			VFL.vprint ("Rect %f %f %f %f", x, y, w, h)
		end
	end

--	VFL.vprint ("RectMinMax %f %f %f %f", x1, y1, x2, y2)

	return x1, y1, x2, y2
end

--------
-- Unpack objective or start/end
-- Format: name length (byte), name string, zone (byte), location data (may start with space)
-- Example: 3,the,1, xxyy
-- Example: 3,end,1,xywh

function RDXMAP.UnpackObjective (obj)

	if not obj then
		return
	end

	local i = strbyte (obj) - 35 + 1
	local desc = strsub (obj, 2, i)

	if #obj == i then
		return desc
	end

	local zone = strbyte (obj, i + 1) - 35

	return desc, zone, i + 2
end

--------
-- Unpack start/end
-- Format: name index (byte x2), zone (byte), location data (may start with space)
-- Example: 00,1, xxyy
-- Example: 00,1,xywh

function RDXMAP.UnpackSE (obj)

	if not obj then
		return
	end

	local i = (strbyte (obj) - 35) * 221 + (strbyte (obj, 2) - 35)
	-- test sigg
	
	local name = RDXMAP.QuestDataStartEnd[i]
	--local name = self.QuestStartEnd[i]

	if not name then
--		VFL.vprint ("UnpackSE err %s (%s)", i, obj)
		name = "?"
	end

	if #obj == 2 then
		return name
	end

	local zone = strbyte (obj, 3) - 35

	return name, zone, 4
end

--------
-- Get centered position of start/end

function RDXMAP.GetSEPos (str)

	local name, zone, loc = RDXMAP.UnpackSE (str)

	if zone then
		return name, zone, RDXMAP.GetPosLoc (str, loc)		-- x, y
	end
end

function RDXMAP.CheckQuestSE (q, n)

	local _, zone, x, y = RDXMAP.GetSEPos (q[n])
	local mapId = RDXMAP.Zone2MapId[zone]

	if (x == 0 or y == 0) and mapId and not RDXMAP.APIMap.IsInstanceMap (mapId) then
		q[n] = format ("%s# ####", strsub (q[n], 1, 2))	-- Zero it to get a red button
--		local oName = RDXMAP.UnpackSE (q[n])
--		VFL.vprint ("zeroed %s, %s", RDXMAP.UnpackName (q[1]), oName)
	end
end

function RDXMAP.CheckQuestObj (q, n)

	local oName, zone, x, y = RDXMAP.GetObjectivePos (q[n])
	local mapId = RDXMAP.Zone2MapId[zone]

	if (x == 0 or y == 0) and mapId and not RDXMAP.APIMap.IsInstanceMap (mapId) then		
		q[n] = format ("%c%s# ####", #oName + 35, oName)	-- Zero it to get a red button
--		VFL.vprint ("zeroed %s, %s", RDXMAP.UnpackName (q[1]), oName)
	end
end


--------
-- Unpack quest info
-- Format: (b) is byte
--  name len (b), name str, side (b), level (b), min lvl (b), next id (b3), category (b)

function RDXMAP.Unpack (info)

	local strbyte = strbyte
	local i = strbyte (info, 1) - 35 + 1
	local name = strsub (info, 2, i)
	local side, lvl, minlvl, n1, n2, n3 = strbyte (info, i + 1, i + 6)
	local nextId = (n1 - 35) * 48841 + (n2 - 35) * 221 + n3 - 35
--	if nextId > 0 then
--		nextId = (nextId + 3) / 2 - 7
--	end

	return name, side - 35, lvl - 35, minlvl - 35, nextId
end

--------
-- Unpack quest name

function RDXMAP.UnpackName (info)

	local i = strbyte (info, 1) - 35 + 1
	return strsub (info, 2, i)
end

--------
-- Unpack quest next id

function RDXMAP.UnpackNext (info)

	local sb = strbyte
	local i = sb (info, 1) - 35 + 1
	return (sb (info, i + 4) - 35) * 48841 + (sb (info, i + 5) - 35) * 221 + sb (info, i + 6) - 35
end

--------
-- Unpack quest category

function RDXMAP.UnpackCategory (info)

	local i = strbyte (info, 1) - 35 + 1 + 7
	return strbyte (info, i) - 35
end


--------
-- Get centered position from location string

function RDXMAP.GetPosLoc (str, loc)

	local cnt
	local ox = 0
	local oy = 0

	local typ = strbyte (str, loc)

	if typ == 32 then  -- Point

		cnt = floor ((#str - loc) / 4)

		local x, y

		for locN = loc + 1, loc + cnt * 4, 4 do

--			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

			x, y = RDXMAP.UnpackLocPtOff (str, locN)
			ox = ox + x
			oy = oy + y
		end

	elseif typ == 33 then  -- Relative point (for Icecrown airships)

		cnt = 1
		ox, oy = RDXMAP.UnpackLocPtRelative (str, loc + 1)

	else -- Multiple locations

		loc = loc - 1
		local loopCnt = floor ((#str - loc) / 4)
		cnt = 0

		for locN = loc + 1, loc + loopCnt * 4, 4 do

			local loc1 = strsub (str, locN, locN + 3)
--			assert (loc1 ~= "")

--			prtVar ("Loc1", loc1)

			local x, y, w, h = RDXMAP.UnpackLocRect (loc1)

			w = w / 1002 * 100
			h = h / 668 * 100

			local area = w * h
			cnt = cnt + area
			ox = ox + (x + w * .5) * area
			oy = oy + (y + h * .5) * area				
--			VFL.vprint ("#%f %f %f %f %f (%f)", cnt, x, y, w, h, area)
		end
	end

	ox = ox / cnt
	oy = oy / cnt

	return ox, oy
end

--------
-- Get type of objective (not start/end)

function RDXMAP.GetObjectiveType (obj)

	local loc = strbyte (obj) - 35 + 3
	local typ = strbyte (obj, loc) or 0			-- Can be nil somehow

	if typ <= 33 then  -- Points
		return 0
	end

	return 1		-- Spans
end


--------
-- Unpack location data " xywh" or "xxyy"
-- (string, offset)

function RDXMAP.UnpackLoc (locStr, off)

	local isPt = strbyte (locStr, off) <= 33		-- Space or !

	if isPt then

		local x1, x2, y1, y2 = strbyte (locStr, 1 + off, 4 + off)
		return	((x1 - 35) * 221 + (x2 - 35)) / 100,
					((y1 - 35) * 221 + (y2 - 35)) / 100
	end

	local x, y, w, h = strbyte (locStr, 0 + off, 3 + off)

	return	(x - 35) * .5,		-- * 100 / 200, Optimised
				(y - 35) * .5		-- * 100 / 200

--	return	(x - 35) * .5 + (w - 35) * 2.505,	-- * 100 / 200, * 1002 / 200, Optimised (center)
--				(y - 35) * .5 + (h - 35) * 1.67		-- * 100 / 200, * 668 / 200
end

--------

function RDXMAP.UnpackLocPtRelative (str, loc)

	local cnt
	local ox, oy = RDXMAP.UnpackLocPtOff (str, loc)

	ox = ox - 50
	oy = oy - 50

	for n = 1, GetNumBattlefieldVehicles() do

		local x, y, unitName, possessed, typ, dir, player = GetBattlefieldVehicleInfo (n)
		if x and not player then

			if typ == RDX.AirshipType then
				cnt = 1

				dir = dir / PI * 180
				oy = oy / 1.5
				ox, oy = ox * cos (dir) + oy * sin (dir), (ox * -sin (dir) + oy * cos (dir)) * 1.5
				ox = x * 100 + ox
				oy = y * 100 + oy

--				VFL.vprint ("%s Airship %s %s %s", name, typ, ox, oy)
				break
			end
		end
	end

	if not cnt then
		ox = ox + 62
		oy = oy + 42
	end

	return ox, oy
end
--------
-- Unpack location data "xywh"
-- (string)

function RDXMAP.UnpackLocRect (locStr)

	local x, y, w, h = strbyte (locStr, 1, 4)

	return	(x - 35) * .5,		-- * 100 / 200	Optimised
				(y - 35) * .5,		-- * 100 / 200
				(w - 35) * 5.01,	-- * 1002 / 200,
				(h - 35) * 3.34	-- * 668 / 200
end

--------
-- Unpack location data point "xxyy"
-- (string)

function RDXMAP.UnpackLocPt (locStr)

	local x1, x2, y1, y2 = strbyte (locStr, 1, 4)
	return	((x1 - 35) * 221 + (x2 - 35)) / 100,
				((y1 - 35) * 221 + (y2 - 35)) / 100
end

--------
-- Unpack location data point "xxyy"
-- (string)

function RDXMAP.UnpackLocPtOff (locStr, off)

	local x1, x2, y1, y2 = strbyte (locStr, off, 3 + off)
	return	((x1 - 35) * 221 + (x2 - 35)) / 100,
				((y1 - 35) * 221 + (y2 - 35)) / 100
end


--------
-- Make packed XY string
-- (xy 0-100)

function RDXMAP.PackXY (x, y)

	x = max (0, min (100, x))
	y = max (0, min (100, y))
	return format ("%03x%03x", x * 40.9 + .5, y * 40.9 + .5)		-- Round off
end

--------

function RDXMAP.UnpackXY (xy)

	local x = tonumber (strsub (xy, 1, 3), 16) / 40.9
	local y = tonumber (strsub (xy, 4, 6), 16) / 40.9
	return x, y
end

