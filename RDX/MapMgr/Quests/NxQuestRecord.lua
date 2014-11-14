
function RDXMAP.Quest.CalcCNumMax (cur, quest)

	if quest.CNum then

		cur.CNumMax = quest.CNum - 1

		local qc = quest
		while qc do
			cur.CNumMax = cur.CNumMax + 1
			qc = RDXMAP.Quest.IdToQuest[RDXMAP.UnpackNext (qc[1])]
		end
	end
end

function RDXMAP.Quest.CalcDesc (quest, objI, cnt, total)

	local desc = ""
	local obj = quest and quest[objI + 3]
	if obj then
		desc = RDXMAP.UnpackObjective (obj)
	end

	if total == 0 then
		return desc, cnt == 1
	else
		return format ("%s : %d/%d", desc, cnt, total), cnt >= total
	end
end

function RDXMAP.Quest.FindCurFromOld (oldCur)

	for n, cur in ipairs (RDXMAP.Quest.CurQ) do
		if cur.Title == oldCur.Title and cur.ObjText == oldCur.ObjText then
			return cur
		end
	end
end

--------
-- Sort quests

function RDXMAP.Quest.SortQuests()

	local curq = RDXMAP.Quest.CurQ

	-- Sort by level

	repeat
		local done = true

		for n = 1, #curq - 1 do

			if curq[n].Level > curq[n + 1].Level then
				curq[n], curq[n + 1] = curq[n + 1], curq[n]
				done = false
			end
		end

	until done

	-- Sort by header
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:quest");
	local qopts = mbo.data;

	if qopts.NXShowHeaders then

		local hdrNames = {}

		for n = 1, #curq do
			hdrNames[curq[n].Header] = 1
		end

		local hdrs = {}

		for name in pairs (hdrNames) do
			tinsert (hdrs, name)
		end

		sort (hdrs)

--		Nx.prtVar ("HDR", hdrs)

		local curq2 = curq
		curq = {}

		for _, name in ipairs (hdrs) do

			for n = 1, #curq2 do

				if curq2[n].Header == name then
					tinsert (curq, curq2[n])
				end
			end
		end

		RDXMAP.Quest.CurQ = curq

--		Nx.prtVar ("curq", curq)
	end

	-- Build id mapping

	local t = {}
	RDXMAP.Quest.IdToCurQ = t

	for k, cur in ipairs (curq) do

		if cur.Q then
			local id = cur.QId
			t[id] = cur
		end
	end
end

function RDXMAP.Quest.RecordQuestsLog()

	local qcnt = GetNumQuestLogEntries()

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data
	
	local curq = RDXMAP.Quest.CurQ
	local oldSel = GetQuestLogSelection()

--	VFL.vprint ("RecordQuestsLog %s, %s", qcnt, #curq)

	local lastChanged

	local qIds = {}
	RDXMAP.Quest.QIds = qIds

	--
	local partySend

	if RDXMAP.Quest.RealQEntries == qcnt then	-- No quests added or removed?

		for curi, cur in ipairs (curq) do

			local qi = cur.QI
			if qi > 0 then

				local title, level, groupCnt, isHeader, isCollapsed, isComplete = GetQuestLogTitle (qi)
				title = RDXMAP.APIQuest.ExtractTitle (title)

--				VFL.vprint ("QD %s %s %s %s", title, qi, isHeader and "H1" or "H0", isComplete and "C1" or "C0")

				if cur.Title == title then		-- Still matches?

					local change

					if isComplete == 1 and not cur.Complete then
						--VFL.vprint ("Quest Complete '%s'", title)

						if opts["QSndPlayCompleted"] then
							RDXMAP.Quest.PlaySound()
						end

						if opts["QAutoTurnInAC"] and cur.IsAutoComplete then
							ShowQuestComplete (qi)
						end

						if opts["QWRemoveComplete"] and not cur.IsAutoComplete then
							RDXMapEvents:Dispatch("Watch:RemoveWatch", cur.QId, cur.QI);
							RDXMapEvents:Dispatch("Watch:Update");
							change = false
						else
							change = true
						end

					end

					local lbCnt = GetNumQuestLeaderBoards (qi)
					for n = 1, lbCnt do

						local desc, _typ, done = GetQuestLogLeaderBoard (n, qi)

						--V4

						if desc and (desc ~= cur[n] or done ~= cur[n + 100]) then

--							VFL.vprint ("Q Change %s->%s", desc, cur[n] or "nil")

							if opts["QWAddChanged"] then
								if change == nil then
									change = true
								end
							end

							local s1, _, oldCnt = strfind (cur[n] or "", ": (%d+)/")
							if s1 then
								oldCnt = tonumber (oldCnt)
							end

							local s1, _, newCnt = strfind (desc, ": (%d+)/")
							if s1 then
--								VFL.vprint ("%s %s", i, total)
								newCnt = tonumber (newCnt)
							end

							if done or (oldCnt and newCnt and newCnt > oldCnt) then
								RDXMAP.Quest.Capture (curi, n)
							end

							lastChanged = cur

							partySend = true
						end
					end

					if change and opts["QWAddChanged"] then
						RDXMapEvents:Dispatch("Watch:Add", curi);
					end
				end
			end
		end

	else

		partySend = true
	end

	-- Remove real blizz quests

	local fakeq = {}

	local n = 1
	while curq[n] do

		local cur = curq[n]
		if not cur.Goto or cur.Party then
--			VFL.vprint ("RecordQuests RemoveQ %s - %s", cur.Title, cur.QI)
			table.remove (curq, n)
		else
			fakeq[cur.Q] = cur
			n = n + 1
		end
	end

	-- Add blizz quests

	RDXMAP.Quest.RealQ = {}

	local header = "?"

	RDXMAP.Quest.RealQEntries = qcnt

	local index = #curq + 1

	for qn = 1, qcnt do

		local title, level, groupCnt, isHeader, isCollapsed, isComplete, frequency = GetQuestLogTitle (qn)

		--VFL.vprint ("Q %d %s %s %d %s %s %s", qn, isHeader and "H" or " ", title, level, groupCnt or "nil", isDaily or "not daily", isComplete and "C1" or "C0")

		if isHeader then
			header = title or "?"
--			if isCollapsed then
--				VFL.vprint ("Q %s collapsed!", title)
--			end

		else
			title = RDXMAP.APIQuest.ExtractTitle (title)

			SelectQuestLogEntry (qn)

			local qDesc, qObj = GetQuestLogQuestText()

			local qId, qLevel = RDXMAP.APIQuest.GetLogIdLevel (qn)
			if qId then
				local quest = RDXMAP.Quest.IdToQuest[qId]

	--			local quest = self:Find (title, level, qDesc, qObj)
				local lbCnt = GetNumQuestLeaderBoards (qn)

				local cur = quest and fakeq[quest]
	--			local DBqId = quest and self:UnpackId (quest[1])
	--			assert (qId == DBqId)

				if not cur then
					cur = {}
					curq[index] = cur
					cur.Index = index
					index = index + 1

				else
					cur.Goto = nil						-- Might have been a goto quest
					cur.Index = index

					if quest then
						RDXMAP.Quest.Tracking[qId] = 0
						RDXMAP.Quest.TrackOnMap (qId, 0, true)
					end
				end

				qIds[qId] = cur

				cur.Q = quest
				cur.QI = qn							-- Blizzard index
				cur.QId = qId
				cur.Header = header
				cur.Title = title
				cur.ObjText = qObj
				cur.DescText = qDesc
				cur.Level = level
				cur.RealLevel = qLevel
				cur.NewTime = RDXMAP.Quest.QIdsNew[qId]	-- Copy new time

				--cur.Tag = tag
				cur.GCnt = groupCnt or 0

				cur.PartySize = groupCnt or 1
	--			if cur.Tag then VFL.vprint ("%s %s", cur.Tag, cur.GCnt) end
				--if tag == "Dungeon" or tag == "Heroic" then
				--	cur.PartySize = 5
				--elseif tag == "Raid" then
				--	cur.PartySize = 10
				--end

				--cur.TagShort = self.TagNames[tag] or ""

				cur.Daily = frequency
				if frequency then
					--cur.TagShort = "$" .. cur.TagShort
				end

				cur.CanShare = GetQuestLogPushable()
				cur.Complete = isComplete		-- 1 is Done, nil not. Otherwise failed
				cur.IsAutoComplete = GetQuestLogIsAutoComplete (qn)

				local left = GetQuestLogTimeLeft()
				if left then
					cur.TimeExpire = time() + left
					cur.HighPri = true
				end

				cur.ItemLink, cur.ItemImg, cur.ItemCharges = GetQuestLogSpecialItemInfo (qn)

				cur.Priority = 1
				cur.Distance = 999999999
				cur.LBCnt = lbCnt

				for n = 1, lbCnt do
					local desc, typ, done = GetQuestLogLeaderBoard (n, qn)
					cur[n] = desc or "?"		--V4
					cur[n + 100] = done
				end

				local mask = 0
				local ender = quest and (quest[3] or quest[2])

				if (isComplete and ender) or lbCnt == 0 or (cur.Goto and quest[2]) then
					mask = 1

				else
					for n = 1, 99 do

						local done
						if n <= lbCnt then
							done = cur[n + 100]
						end

						local obj = quest and quest[3 + n]

						if not obj then
							break
						end

						if obj and not done then
							mask = mask + bit.lshift (1, n)
						end
					end
				end

				cur.TrackMask = mask

	--			VFL.vprint ("%s %x", title, mask)

				RDXMAP.Quest.RealQ[title] = cur			-- For diff

				-- Calc total number in quest chain

				if quest then
					RDXMAP.Quest.CalcCNumMax (cur, quest)
				end
			end
		end
	end

	--

	if opts["QPartyShare"] then --and self.Watch.ButShowParty:GetPressed() then

--		VFL.vprint ("-PQuest-")

		local pq = RDXMAP.Quest.PartyQ

		for plName, pdata in pairs (pq) do

--			VFL.vprint ("PQuest %s", plName)

			for qId, qT in pairs (pdata) do

				local quest = RDXMAP.Quest.IdToQuest[qId]
				local cur = qIds[qId]

				if cur then		-- We have the quest?

					local s = format ("\n|cff8080f0%s|r", plName)

					if not cur.PartyDesc then

						cur.PartyDesc = ""
						cur.PartyNames = "\n|cfff080f0Me"
						cur.PartyCnt = 0
						cur.PartyComplete = cur.Complete

						for n, cnt in ipairs (qT) do
							cur[n + 200] = cur[n + 100]
							cur[n + 400] = "\n|cfff080f0Me" .. s
						end
					end

					cur.PartyDesc = cur.PartyDesc .. s
					cur.PartyNames = cur.PartyNames .. s
					cur.PartyCnt = cur.PartyCnt + 1
					cur.PartyComplete = cur.PartyComplete and qT.Complete

					local mask = (cur.PartyComplete or #qT == 0) and 1 or 0

					for n, cnt in ipairs (qT) do

						local total = qT[n + 100]

						local desc, done = RDXMAP.Quest.CalcDesc (quest, n, cnt, total)

--						cur[n] = desc

						done = cur[n + 200] and done
						cur[n + 200] = done

						cur.PartyDesc = cur.PartyDesc .. "\n " .. desc
						cur[n + 400] = cur[n + 400] .. " " .. desc

						if not done then
							mask = mask + bit.lshift (1, n)
						end
					end

					cur.TrackMask = mask

				elseif quest then

					local name, side, lvl = RDXMAP.Unpack (quest[1])

--					VFL.vprint ("PartyQ %s", name)

					local cur = {}
					cur.Goto = true
					cur.Party = plName
					cur.PartyDesc = format ("\n|cff8080f0%s|r", plName)
					cur.PartyNames = cur.PartyDesc
					cur.Q = quest
					cur.QI = 0
					cur.QId = qId
					cur.Header = "Party, " .. plName
					cur.Title = name
					cur.ObjText = ""
					cur.Level = lvl
					cur.PartySize = 1
					cur.TagShort = ""
					cur.Complete = qT.Complete
					cur.Priority = 1
					cur.Distance = 999999999

					RDXMAP.Quest.CalcCNumMax (cur, quest)

					tinsert (curq, cur)
					cur.Index = #curq

					cur.LBCnt = #qT

					local mask = (qT.Complete or #qT == 0) and 1 or 0

					for n, cnt in ipairs (qT) do

						local total = qT[n + 100]

						cur[n], cur[n + 100] = RDXMAP.Quest.CalcDesc (quest, n, cnt, total)

						cur[n + 400] = cur.PartyNames

						if not cur[n + 100] then
							mask = mask + bit.lshift (1, n)
						end
					end

					cur.TrackMask = mask
				end
			end
		end
	end

	for curi, cur in ipairs (curq) do
		if cur.PartyCnt then
			cur.CompleteMerge = cur.PartyComplete

			for n, desc in ipairs (cur) do
				cur[n + 300] = cur[n + 200]
			end

		else
			cur.CompleteMerge = cur.Complete

			for n, desc in ipairs (cur) do
				cur[n + 300] = cur[n + 100]
			end
		end
	end

	--

	if lastChanged then
		RDXMAP.Quest.QLastChanged = RDXMAP.Quest.FindCurFromOld (lastChanged)
	end

	SelectQuestLogEntry (oldSel)

--	VFL.vprint ("CurQ %d", #curq)

	RDXMAP.Quest.SortQuests()

	if partySend then
		--self:PartyStartSend()
	end

	RDXMapEvents:Dispatch("Guide:UpdateMapIcons")
end



