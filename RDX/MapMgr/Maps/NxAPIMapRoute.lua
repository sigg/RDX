

--------
-- Gather icons

function RDXMAP.APIMap.RouteGathers(map)

	local points = {}
	local cnt = RDXMAP.APIMap.GetIconCnt (map, "!Ga")

	for n = 1, cnt do
		local wx, wy = RDXMAP.APIMap.GetIconPt (map, "!Ga", n)
		local x, y = RDXMAP.APIMap.GetZonePos (map.MapId, wx, wy)

		local pt = {}
		tinsert (points, pt)
		pt.x = x
		pt.y = y
	end

	RDXMAP.APIMap.RouteMerge (map, points)

	local route = RDXMAP.APIMap.Route (map, points)
	if route then
		RDXMAP.APIMap.RouteToTargets (map, route, false)
	end
end

function RDXMAP.APIMap.RouteTargets(map)

	local points = {}

	for n, tar in ipairs (RDXU.MapTargets) do

		--local wx = tar.TargetMX
		--local wy = tar.TargetMY
		local wx = tar.x
		local wy = tar.y
		local x, y = RDXMAP.APIMap.GetZonePos (map.MapId, wx, wy)

		local pt = {}
		tinsert (points, pt)
		pt.Name = tar.n
		pt.x = x
		pt.y = y
	end

	local route = RDXMAP.APIMap.Route (map, points)
	if route then
		RDXMAP.APIMap.RouteToTargets (map, route)
	end
end

function RDXMAP.APIMap.RouteQuests (map, points)

	local route = RDXMAP.APIMap.Route (map, points)
	if route then
		RDXMAP.APIMap.RouteToTargets (map, route, false)
	end
end

--------
-- Merge close points

function RDXMAP.APIMap.RouteMerge (map, points)

	local radius = map.GOpts["RouteMergeRadius"]

	if #points < 2 or radius < 1 then
		return
	end

	local tm = GetTime()

	sort (points, function (a, b) return a.x < b.x end)

--	for n, pt in ipairs (points) do
--		VFL.vprint ("%s %s", n, pt.x)
--	end

	radius = radius / RDXMAP.APIMap.GetWorldZoneScale (map.MapId) / 4.575
--	VFL.vprint ("rad %s", radius)

	local radiusSq = radius ^ 2	-- Yards to world space squared

	local startCnt = #points
	local merged = true

	while merged do

		merged = false

		local close = 999999999
		local closeI1
		local closeI2

		for n1, pt1 in ipairs (points) do

--			local done

			for n2 = n1 + 1, #points do

				local pt2 = points[n2]

				if pt2.x - pt1.x > radius then
--					VFL.vprint ("done %s %s", pt1.x, pt2.x)
--					done = true
					break
				end

				local d = (pt1.x - pt2.x) ^ 2 + ((pt1.y - pt2.y) / 1.5) ^ 2
				if d < close then
					close = d
					closeI1 = n1
					closeI2 = n2
--[[
					if d ^ .5 < radius * .5 then	-- Close enough? Early out
						VFL.vprint ("%s + %s, %s", n1, n2, d ^ .5)
						done = true
						break
					end
--]]
				end
			end

--			if done then
--				break
--			end
		end

		if close ^ .5 < radius then

--			VFL.vprint (" + %s %s", closeI1, closeI2)

			local pt1 = points[closeI1]
			local pt2 = points[closeI2]

			pt1.x = (pt1.x + pt2.x) * .5		-- Average
			pt1.y = (pt1.y + pt2.y) * .5

			tremove (points, closeI2)
			merged = true

			sort (points, function (a, b) return a.x < b.x end)
		end
	end

	VFL.vprint ("Merged %s in %.1f secs", startCnt - #points, GetTime() - tm)
end

--------
-- Make a route and target it

function RDXMAP.APIMap.Route (map, points)

	if #points == 0 then
		return
	end

	-- Test

	local tm = GetTime()
--[[
	local blks = 20
	local scale = 5

	local points = {}
	for n = 0, 399 do
		local pt = {}
		points[n + 1] = pt
		pt.x = n % blks * scale + floor (n / 7) % 2 * 3
		pt.y = floor (n / blks) * scale + floor (n / 3) % 2 * 4
--		pt.x = random (1, 20)
--		pt.y = random (1, 20)
	end
--]]

	--

	local route = {}

	for n, pt in ipairs (points) do
		pt.y = pt.y / 1.5		-- Make Y same units as X
	end

	-- Nearest neighbor

	if #points > 1 then

		local x = points[1].x
		local y = points[1].y
		if x == points[#points].x and y == points[#points].y then	-- End same as start?
			tremove (points)
		end
	end
	
	local myunit = RDXDAL.GetMyUnit();

	local x, y = RDXMAP.APIMap.GetZonePos (map.MapId, myunit.PlyrX, myunit.PlyrY)
	y = y / 1.5

	while #points > 0 do

		local closeDist = 999999999
		local closeI

		for n, pt in ipairs (points) do

			local dist = (x - pt.x) ^ 2 + (y - pt.y) ^ 2
			if dist < closeDist then
				closeDist = dist
				closeI = n
			end
		end

		local pt = tremove (points, closeI)

		local r = {}
		tinsert (route, r)
		r.Name = pt.Name
		r.x = pt.x
		r.y = pt.y
		r.Weight = pt.Weight or 1

		x = pt.x
		y = pt.y
	end

	-- Add first node at end if needed for loop

	local x = route[1].x
	local y = route[1].y

	if x ~= route[#route].x or y ~= route[#route].y then

--		VFL.vprint ("%f %f %f %f", x, route[#route].x, y, route[#route].y)

		local r = {}
		r.x = x
		r.y = y
		tinsert (route, r)
	end

	-- Calc length (sets node distances)

	local len = RDXMAP.APIMap.RouteLen (map, route)
--	VFL.vprint ("Route len %s, %s secs", len, GetTime() - tm)

	-- Optimize .517 secs on 400

	for n = 1, 5 do
		local swap = RDXMAP.APIMap.RouteOptimize (map, route)
--		local len = RDXMAP.APIMap.RouteLen (map, route)
--		VFL.vprint ("Route opt #%s len %s, %s secs", #route, len, GetTime() - tm)
		if not swap then
			break
		end
	end

	-- Show info

	local scale = RDXMAP.APIMap.GetWorldZoneScale (map.MapId)
	local len = RDXMAP.APIMap.RouteLen (map, route)
	VFL.vprint ("Routed %s nodes, %d yards in %.1f secs", #route, len * scale * 4.575, GetTime() - tm)

	return route
end

function RDXMAP.APIMap.RouteToTargets (map, route, targetIcon)

	--Nx.Quest.Watch:ClearAutoTarget()
	RDXMapEvents:Dispatch("Watch:ClearAutoTarget");

	local mapId = map.MapId

	for n, r in ipairs (route) do

		local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, r.x, r.y * 1.5)
		local s = format ("Route%s (%s) %s", n, #route - n + 1, r.Name or "")
		local tar = RDXMAP.APIMap.SetTarget ("Route", wx, wy, nil, s, n ~= 1, mapId)

		tar.Radius = map.GOpts["RouteGatherRadius"]
	end
end

function RDXMAP.APIMap.RouteLen (map, route)

	local len = 0

	for n = 1, #route - 1 do
		local r1 = route[n]
		local r2 = route[n + 1]
		r1.Dist = ((r1.x - r2.x) ^ 2 + (r1.y - r2.y) ^ 2) ^ .5
		len = len + r1.Dist
--		VFL.vprint ("Route %s len %s", n, ((x - r.x) ^ 2 + (y - r.y) ^ 2) ^ .5)
	end

	return len
end

function RDXMAP.APIMap.RouteOptimize (map, route)

	local swap

---[[ 1394.4788 len
	for len = #route - 2, 2, -1 do

		for n = 1, #route - len - 1 do

			local r1 = route[n]
			local r2 = route[n + 1]
			local n2 = n + len
			local r3 = route[n2]
			local r4 = route[n2 + 1]

			if r1.Dist + r3.Dist >
				((r1.x - r3.x) ^ 2 + (r1.y - r3.y) ^ 2) ^ .5 + ((r2.x - r4.x) ^ 2 + (r2.y - r4.y) ^ 2) ^ .5 then

				RDXMAP.APIMap.RouteSwap (map, route, n + 1, len)

--				local dist1 = ((r1.x - r2.x) ^ 2 + (r1.y - r2.y) ^ 2) ^ .5 + ((r3.x - r4.x) ^ 2 + (r3.y - r4.y) ^ 2) ^ .5
--				local dist2 = ((r1.x - r3.x) ^ 2 + (r1.y - r3.y) ^ 2) ^ .5 + ((r2.x - r4.x) ^ 2 + (r2.y - r4.y) ^ 2) ^ .5
--				VFL.vprint ("Route %s swap %s %s %s", len, n, dist1 or 0, dist2 or 0)

				swap = true
			end
		end
	end
--]]

--[[	Little slower
	for last = #route - 1, 2, -1 do

		for n = 1, last - 2 do

			local r1 = route[n]
			local r2 = route[n + 1]
			local n2 = last
			local r3 = route[n2]
			local r4 = route[n2 + 1]

			if r1.Dist + r3.Dist >
				((r1.x - r3.x) ^ 2 + (r1.y - r3.y) ^ 2) ^ .5 + ((r2.x - r4.x) ^ 2 + (r2.y - r4.y) ^ 2) ^ .5 then

				RDXMAP.APIMap.RouteSwap (map, route, n + 1, last - n)

--				local dist1 = ((r1.x - r2.x) ^ 2 + (r1.y - r2.y) ^ 2) ^ .5 + ((r3.x - r4.x) ^ 2 + (r3.y - r4.y) ^ 2) ^ .5
--				local dist2 = ((r1.x - r3.x) ^ 2 + (r1.y - r3.y) ^ 2) ^ .5 + ((r2.x - r4.x) ^ 2 + (r2.y - r4.y) ^ 2) ^ .5
				VFL.vprint ("Route %s swap %s %s %s", last - n, n, dist1 or 0, dist2 or 0)

				swap = true
			end
		end
	end
--]]

	return swap
end

function RDXMAP.APIMap.RouteSwap (map, route, first, len)

	-- 1 2 3 4 5 6 7 8	Before (3, +4)
	-- 1 2 6 5 4 3 7 8	After

	local last = first + len - 1
	local stop = first + floor (len / 2) - 1

--[[	Loop unroll does not help
	local loops = floor (len / 2)

--	if loops > 1 then

--		VFL.vprint ("Route swap loops %s", loops)

		if loops % 2 ~= 0 then
			route[first], route[last] = route[last], route[first]
			first = first + 1
			last = last - 1
		end

		for n = first, stop, 2 do
			route[n], route[last] = route[last], route[n]
			route[n+1], route[last-1] = route[last-1], route[n+1]
			last = last - 2
		end
	else
--]]

	local n2 = last
	for n = first, stop do
		route[n], route[n2] = route[n2], route[n]
		n2 = n2 - 1
	end

	for n = first - 1, last do
		local r1 = route[n]
		local r2 = route[n + 1]
		r1.Dist = ((r1.x - r2.x) ^ 2 + (r1.y - r2.y) ^ 2) ^ .5
	end
end
