RDXMAP.APIQuest = {}

-- Get status for a quest

function RDXMAP.APIQuest.GetQuest (qId)

	local quest = Nx.CurCharacter.Q[qId]
	if not quest then
		return
	end

	local s1, s2, status, time = strfind (quest, "(%a)(%d+)")

	return status, time
end

function RDXMAP.APIQuest.SetQuest (qId, qStatus, qTime)

	qTime = qTime or 0

	Nx.CurCharacter.Q[qId] = qStatus .. qTime
end


function RDXMAP.APIQuest.FindCurByIndex (qi)

	assert (qi > 0)

	local curq = RDXMAP.Quest.CurQ

	for n, v in ipairs (curq) do
		if v.QI == qi then
			return n, v
		end
	end
end

function RDXMAP.APIQuest.FindCur (qId, qIndex)

	if type (qId) == "string" then	-- Quest title?

		for n, v in ipairs (RDXMAP.Quest.CurQ) do
			if v.Title == qId then
				return n, v, qId
			end
		end

		return
	end

	if qIndex and qId == 0 then
		local i, cur = RDXMAP.APIQuest.FindCurByIndex (qIndex)
		return i, cur, cur.Title	-- Also return string type id
	end

	assert (qId > 0)

	for n, v in ipairs (RDXMAP.Quest.CurQ) do
		if v.QId == qId then
			return n, v, qId
		end
	end
end

function RDXMAP.APIQuest.GetLogIdLevel (index)
	--VFL.print("INDEX " .. index);
	if index > 0 then
		local qlink = GetQuestLink (index)
		if qlink then
			local s1, _, id, level = strfind (qlink, "Hquest:(%d+):(.%d*)")
			if s1 then

--				VFL.vprint ("qlink %s", gsub (qlink, "|", "^"))

				return tonumber (id), tonumber (level)
			end
		end
	end
end

function RDXMAP.APIQuest.CreateLink (qId, realLevel, title)

	if realLevel <= 0 then	-- Could be a 0
		realLevel = -1
	end
	return format ("|cffffff00|Hquest:%s:%s|h[%s]|h|r", qId, realLevel, title)
end

function RDXMAP.APIQuest.ExtractTitle (title)

--	VFL.vprint ("Orig '%s'", title)

	local _, e = strfind (title, "^%[%S+%] ")
	if e then
		title = strsub (title, e + 1)

	else
		local _, e = strfind (title, "^%d+%S* ")
		if e then
			title = strsub (title, e + 1)
		end
	end

--	VFL.vprint ("'%s'", title)

	return title
end

--------
-- Get closest position of objective or start/end

function RDXMAP.APIQuest.GetClosestObjectivePos (str, loc, mapId, px, py)

	if strbyte (str, loc) <= 33 then  -- Point

		local x1, y1, x2, y2 = RDXMAP.GetObjectiveRect (str, loc)
		x1, y1 = RDXMAP.APIMap.GetWorldPos (mapId, (x1 + x2) / 2, (y1 + y2) / 2)
		return x1, y1

	else -- Multiple locations

		local closeDist = 999999999
		local closeX, closeY

		loc = loc - 1
		local loopCnt = floor ((#str - loc) / 4)
		cnt = 0

		for locN = loc + 1, loc + loopCnt * 4, 4 do

			local x, y

			local loc1 = strsub (str, locN, locN + 3)
			assert (loc1 ~= "")

			local x, y, w, h = RDXMAP.UnpackLocRect (loc1)
			w = w / 1002 * 100
			h = h / 668 * 100

			local wx1, wy1 = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
			local wx2, wy2 = RDXMAP.APIMap.GetWorldPos (mapId, x + w, y + h)

			x = wx1		-- Top left
			y = wy1

			if px >= wx1 and px <= wx2 then
				if py >= wy1 and py <= wy2 then		-- Within span?
					return px, py
				end
				x = px

			elseif px >= wx2 then	-- Right of span?
				x = wx2
			end

			if py >= wy1 then		-- Y within span?
				y = py
			end
			if py >= wy2 then	-- Below span?
				y = wy2
			end

			local dist = (x - px) ^ 2 + (y - py) ^ 2
			if dist < closeDist then
				closeDist = dist
				closeX = x
				closeY = y
			end

--			VFL.vprint ("#%f %f %f %f %f (%f)", cnt, x, y, w, h, area)
		end

		return closeX, closeY
	end
end

--------
-- Is targeted already?

function RDXMAP.APIQuest.IsTargeted (qId, qObj, x1, y1)

	local typ, tid = RDXMAP.APIMap.GetTargetInfo()
	if typ == "Q" then

		local tqid = floor (tid / 100)
		if tqid == qId then		-- Same as us?

			if x1 then
				local tx1, ty1 = RDXMAP.APIMap.GetTargetPos()
				if x1 ~= tx1 or y1 ~= ty1 then
					return
				end
			end

			if not qObj then
				return true
			end

			if tid % 100 == qObj then
				return true
			end
		end
	end
end