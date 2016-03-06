
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

	local name, zone, x, y = RDXMAP.GetSEPos (q[n])
	local mapId = RDXMAP.Zone2MapId[zone]

	if (x == 0 or y == 0) and mapId and not RDXMAP.APIMap.IsInstanceMap (mapId) then
		q[n] = format ("%s# ####", strsub (q[n], 1, 2))	-- Zero it to get a red button
--		local oName = RDXMAP.UnpackSE (q[n])
--		VFL.vprint ("zeroed %s, %s", RDXMAP.UnpackName (q[1]), oName)
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
-- Get centered position of objective

function RDXMAP.GetObjectivePos (str)

	local name, zone, loc = RDXMAP.UnpackObjective (str)

	if zone then
		return name, zone, RDXMAP.GetPosLoc (str, loc)		-- x, y
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

function QuestsBuild()

end

-- old quest structure
--[[
[6962] = {
	Quest = Treats for Great-father Winter|2|0|10|0|15,
	Start = "291|321|32|49.7|77.85",
	End = "291|321|32|49.71|77.87",
	Objectives = {
	  [1] = {
		 "nil|321|35|56|61|5.01|3.34",
		 "nil|321|35|52|75.5|15.03|3.34",
		 "nil|321|35|51.5|76|20.04|3.34",
		 "nil|321|35|51|76.5|25.05|3.34",
		 "nil|321|35|49.5|77|45.09|3.34",
		 "nil|321|35|49.5|77.5|50.1|3.34",
		 "nil|321|35|49.5|78|55.11|3.34",
	   },
	  [2] = {
		 "nil|321|35|70|49|5.01|3.34",
		 "nil|321|35|51.5|75.5|15.03|3.34",
		 "nil|321|35|50|76|30.06|3.34",
		 "nil|321|35|52|76.5|15.03|3.34",
		 "nil|321|35|52.5|77|15.03|3.34",
		 "nil|321|35|53|77.5|20.04|10.02",
		 "nil|321|35|53|79|15.03|3.34",
		 "nil|321|35|53|79.5|10.02|3.34",
		 "nil|321|35|53.5|80|5.01|16.7",
	   },
	},
  },


]]

-- new quest structure
--[[

[6962] = { -- ID
	n = "Treats for Great-father Winter";
	f = 2 --faction should disappear
	sl = 0 -- start level
	el = 10 -- end level
	i = next id
	c = category
	s = {  --(start point)
		ni = name id database
		z = zone
		t = type point or rec 32, 33, etc
		x =
		y =
	}
	e = { --(end point)
		ni = name id database
		z = zone
		t = type point or rec 32, 33, etc
		x =
		y =
	}
	o = { -- objectives
		[1] = {
			z = zone
			t = type
			
		}
		[2] = {
		}
	}
	
	|2|0|10|0|15,
	Start = "291|321|32|49.7|77.85",
	End = "291|321|32|49.71|77.87",
	Objectives = {
	  [1] = {
		 "nil|321|35|56|61|5.01|3.34",
		 "nil|321|35|52|75.5|15.03|3.34",
		 "nil|321|35|51.5|76|20.04|3.34",
		 "nil|321|35|51|76.5|25.05|3.34",
		 "nil|321|35|49.5|77|45.09|3.34",
		 "nil|321|35|49.5|77.5|50.1|3.34",
		 "nil|321|35|49.5|78|55.11|3.34",
	   },
	  [2] = {
		 "nil|321|35|70|49|5.01|3.34",
		 "nil|321|35|51.5|75.5|15.03|3.34",
		 "nil|321|35|50|76|30.06|3.34",
		 "nil|321|35|52|76.5|15.03|3.34",
		 "nil|321|35|52.5|77|15.03|3.34",
		 "nil|321|35|53|77.5|20.04|10.02",
		 "nil|321|35|53|79|15.03|3.34",
		 "nil|321|35|53|79.5|10.02|3.34",
		 "nil|321|35|53.5|80|5.01|16.7",
	   },
	},
  },


]]


	
local function pp(obj)
	if not obj then
		return
	end
	
	local i = (strbyte (obj) - 35) * 221 + (strbyte (obj, 2) - 35)
	
	if #obj == 2 then
		return i
	else
		--VFL.print("local pp name only");
	end

	local zone = strbyte (obj, 3) - 35
	if zone then 
		return i, RDXMAP.Zone2MapId[zone], RDXMAP.GetPosLoc (obj, 4)
	else
		VFL.print("local pp no zone");
	end
end

--RDXDiskQuestsHorde
-- /script RDXMAP.QQ()
function RDXMAP.QQ()

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:quest");
	local qopts = mbo.data
	
	local mbo = RDXDB.TouchObject("RDXDiskQuestsHorde:quests:quests");
	local qhorde = mbo.data;
	
	-- RDX   0 = Ally, 1 = Horde, 2 = Neutral
	-- Quest 1 = Horde, 2 = Ally
	
	local enFact = RDX.PlFactionNum == 1 and 1 or 2		-- Remap 0 to 2, 1 to 1
	local qLoadLevel = UnitLevel ("player") - opts["QLevelsToLoad3"]
	local qMaxLevel = 999

	local qCnt = 0
	local maxid = 0
	local sameCnt = 0
	
	local n, z, x, y

	for mungeId, q in pairs(RDXMAP.QuestsData) do
		local id = (mungeId + 3) / 2 - 7
		qCnt = qCnt + 1
		maxid = max (id, maxid)
		
		local name, side, level, minlvl, next = RDXMAP.Unpack (q[1])
		
		local tbl = {};
		tbl.n = name;
		tbl.sl = minlvl;
		tbl.el = level;
		tbl.i = next;
		
		if q[2] then
			local tbl2 = {}
			n, z, x, y = pp(q[2])
			tbl2.ni = n;
			tbl2.z = z;
			tbl2.t = 32;
			tbl2.x = x;
			tbl2.y = y;
			tbl.s = tbl2;
		end
		if q[3] then
			local tbl2 = {}
			n, z, x, y = pp(q[3])
			tbl2.ni = n;
			tbl2.z = z;
			tbl2.t = 32;
			tbl2.x = x;
			tbl2.y = y;
			tbl.e = tbl2;
		end
		
		if q[4] then
			tbl.o = {};
		end
		
		local x1 = 0
		local y1 = 0
		local x2 = 0
		local y2 = 0
		
		for n = 4, 99 do
			if not q[n] then
				break
			end
			local name, zone, loc = RDXMAP.UnpackObjective (q[n])
			if loc then 
				local typ = strbyte (q[n], loc)
				local mapId = RDXMAP.Zone2MapId[zone]
				local tbl2 = {}
				tbl2.n = name;
				tbl2.z = mapId;
				table.insert(tbl.o, tbl2);
				
				if typ == 32 or typ == 33 then
					local x1, y1, x2, y2 = RDXMAP.GetObjectiveRect (q[n], loc)
					local tbl3 = {};
					tbl3.t = typ;
					tbl3.x1 = x1;
					tbl3.y1 = y1;
					tbl3.x2 = x2;
					tbl3.y2 = y2;
					table.insert(tbl2, tbl3);
					VFL.print("FOUND OTHER 35");
				else
					-- multiple points
					typ = 35
					loc = loc - 1

					local cnt = floor ((#q[n] - loc) / 4)

					for locN = loc + 1, loc + cnt * 4, 4 do

						local loc1 = strsub (q[n], locN, locN + 3)
			--			assert (loc1 ~= "")

						local x, y, w, h = RDXMAP.UnpackLocRect (loc1)

						--x1 = min (x1, x)
						--y1 = min (y1, y)
						--x2 = max (x2, x + w / 1002 * 100)
						--y2 = max (y2, y + h / 668 * 100)
						
						local tbl3 = {};
						--tbl3.t = typ;
						--tbl3.x1 = x1;
						--tbl3.y1 = y1;
						--tbl3.x2 = x2;
						--tbl3.y2 = y2;
						tbl3.x = x;
						tbl3.y = y;
						tbl3.w = w;
						tbl3.h = h;
						table.insert(tbl2, tbl3);
			--			VFL.vprint ("Rect %f %f %f %f", x, y, w, h)
					end
				end
			else
			
			end
		end
		
		--VFL.print(side);
		if side == 1 then
			qhorde[id] = tbl;
		elseif side == 2 then
			RDXDiskQuestsAlliance[id] = tbl;
		else
			RDXDiskQuestsNeutral[id] = tbl;
		--	VFL.print("Side error code");
		end
		
	end
end

-- /script RDXDiskQuestsHorde = {}
