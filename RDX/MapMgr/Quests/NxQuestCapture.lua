
--------
-- Capture a quest
-- (current index, objective # (nil for start, -1 end)

function RDXMAP.Quest.Capture (curi, objNum)

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data

	if not opts["CaptureEnable"] then
		return
	end

	local cur = RDXMAP.Quest.CurQ[curi]
	local id = cur.QId

	if NxData.DebugMap and (not objNum or objNum < 0) then	-- Start or end
		VFL.vprint ("Quest Capture %s", id or "nil")
	end

	if not id then
		return
	end

	local facI = UnitFactionGroup ("player") == "Horde" and 1 or 0
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:capQuest");
	local quests = mbo.data;

	local saveId = id * 2 + facI

	local len = 0

	for id, str in pairs (quests) do
		len = len + 4 + #str + 1
	end

	if len > 110 * 1024 then
		return
	end

--	VFL.vprint ("Cap len %s", len)

--[[
	if not objNum or objNum < 0 then
		VFL.vprint ("Capture %s %s %s %.2f,%.2f", RDXMAP.Quest.AcceptGiver, RDXMAP.Quest.AcceptAId or 0, RDXMAP.Quest.AcceptDLvl, RDXMAP.Quest.AcceptX, RDXMAP.Quest.AcceptY)
	else
		local map = self.Map
		local myunit = RDXDAL.GetMyUnit();
		VFL.vprint ("Capture #%s %s %.2f,%.2f", objNum, myunit.mapId, myunit.PlyrRZX, myunit.PlyrRZY) ---
	end
--]]

--	local ids = self:CaptureGet (quests, id)
--	ids["I"] = format ("%d^%s^%s", cur.RealLevel, cur.Title, cur.Header)

	local q = quests[saveId]

	if not q then
		q = strrep ("~", cur.LBCnt + 1)
	end

	local qdata = { strsplit ("~", q) }

	if not objNum then	-- Starter

--		local flags = bit.bor (tonumber (strsub (qdata[1], 1, 1), 16) or 0, facMask)
		local plLvl = UnitLevel ("player")

		-- 0 is reserved
		local s = RDXMAP.PackXY (RDXMAP.Quest.AcceptX, RDXMAP.Quest.AcceptY)
--		qdata[1] = format ("0%s^%02x%02x%s", RDXMAP.Quest.AcceptGiver, plLvl, RDXMAP.Quest.AcceptAId, s)
		qdata[1] = format ("0%s^%03x%x%s", RDXMAP.Quest.AcceptGiver, RDXMAP.Quest.AcceptAId, RDXMAP.Quest.AcceptDLvl, s)

--		VFL.vprint ("Capture start %s", qdata[1])

	elseif objNum < 0 then	-- Ender

		local s = RDXMAP.PackXY (RDXMAP.Quest.AcceptX, RDXMAP.Quest.AcceptY)
		qdata[2] = format ("%s^%03x%x%s", RDXMAP.Quest.AcceptGiver, RDXMAP.Quest.AcceptAId, RDXMAP.Quest.AcceptDLvl, s)

		RDXMAP.Quest.CaptureQEndTime = GetTime()
		RDXMAP.Quest.CaptureQEndId = saveId

--		VFL.vprint ("Capture end %s", qdata[2])

	else
		local myunit = RDXDAL.GetMyUnit();
		local nxzone
		nxzone = myunit.mapId --
		if nxzone then

			local index = objNum + 2
			local obj = qdata[index]

			if not obj then
				VFL.vprint ("Capture err %s, %s", cur.Title, objNum)
				return
			end

			if #obj >= 3 then
				local z = tonumber (strsub (obj, 1, 3), 16)
				if nxzone ~= z then
					return
				end
			else
				obj = format ("%03x", nxzone)
			end

			local cnt = (#obj - 3) / 6
			if cnt >= 15 then
				return
			end

			qdata[index] = obj .. RDXMAP.PackXY (myunit.PlyrRZX, myunit.PlyrRZY)

--			VFL.vprint ("Capture%d #%d %s", objNum, cnt, qdata[index])
		end
	end

	quests[saveId] = table.concat (qdata, "~")	-- concat is not global!!!

--	VFL.vprint ("CapStr %s", quests[saveId])
end

function RDXMAP.Quest.CaptureGetCount()

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:capQuest");
	local quests = mbo.data;
	
	local cnt = 0

	for id, str in pairs (quests) do
		cnt = cnt + 1
	end

	return cnt
end

function RDXMAP.Quest.OnChat_msg_combat_faction_change (event, arg1)

--	VFL.vprint ("OnChat_msg_combat_faction_change %s", arg1)

	local form = FACTION_STANDING_INCREASED
	form = gsub (form, "%%s", "(.+)")
	form = gsub (form, "%%d", "(%%d+)")
	local facName, rep = strmatch (arg1, form)
	rep = tonumber (rep)

	if facName and rep and RDXMAP.Quest.CaptureQEndTime and GetTime() - RDXMAP.Quest.CaptureQEndTime < 2 then

		local facNum = RDXMAP.Quest.CapFactionAbr[facName]
		if facNum then

			local _, race = UnitRace ("player")
			if race == "Human" then
				rep = rep / 1.1 + .5
			end

--			VFL.vprint ("Fac %s %s", facName, rep)

			local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:capQuest");
			local quests = mbo.data;
			local qdata = { strsplit ("~", quests[RDXMAP.Quest.CaptureQEndId]) }
			local ender, reps = strsplit ("@", qdata[2])

			local repdata = reps and { strsplit ("^", reps) } or {}
			tinsert (repdata, format ("%d %x", rep, facNum))
			reps = table.concat (repdata, "^")

			qdata[2] = format ("%s@%s", ender, reps)
			quests[RDXMAP.Quest.CaptureQEndId] = table.concat (qdata, "~")	-- concat is not global!!!
		end
	end

	RDXMAP.Quest.CaptureQEndTime = nil
end

