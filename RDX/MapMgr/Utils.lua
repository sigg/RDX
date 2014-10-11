

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

-- Get status for a quest

function RDXMAP.GetQuest (qId)

	local quest = RDXU.Q[qId]
	if not quest then
		return
	end

	local s1, s2, status, time = strfind (quest, "(%a)(%d+)")

	return status, time
end

function RDXMAP.SetQuest (qId, qStatus, qTime)

	qTime = qTime or 0

	RDXU.Q[qId] = qStatus .. qTime
end