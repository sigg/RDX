
local qdt = {};

local function createQuestByQn(qn)
	local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle (qn)

	if not isHeader then

		SelectQuestLogEntry (qn)
	
		local cur = {}
		cur.QI = qn							-- Blizzard index
		cur.QId = questID

		cur.text = RDXMAP.APIQuest.ExtractTitle (title)
		cur.DescText, cur.ObjText = GetQuestLogQuestText()
		cur.Level = level
		cur.GCnt = suggestedGroup or 0
		cur.Daily = frequency
		cur.CanShare = GetQuestLogPushable()
		cur.Complete = isComplete		-- 1 is Done, nil not. Otherwise failed
		cur.IsAutoComplete = GetQuestLogIsAutoComplete (qn)
		local left = GetQuestLogTimeLeft()
		if left then
			cur.TimeExpire = time() + left
		end
		cur.ItemLink, cur.ItemImg, cur.ItemCharges = GetQuestLogSpecialItemInfo (qn)
		
		local lbCnt = GetNumQuestLeaderBoards (qn)
		if lbCnt and lbCnt > 0 then
			cur.LBCnt = lbCnt
			cur.LB = {};

			for n = 1, lbCnt do
				local desc, typ, done = GetQuestLogLeaderBoard (n, qn)
				local tt = {}
				tt.d = desc or "?"		--V4
				tt.t = typ
				tt.c = done
				cur.LB[n] = tt;
			end
		end
		
		local questdata;
		if questID then
			--questdata = RDXMAP.Quest.IdToQuest[questID]
			if questdata then
				cur.Q = questdata

				local mask = 0
				local ender = questdata and (questdata.e or questdata.s)

				if (isComplete and ender) or lbCnt == 0 then
					mask = 1
				else
					for n = 1, 99 do

						local done
						if n <= lbCnt then
							done = cur.LB[n].c
						end

						local obj = questdata.o

						if not obj then
							break
						end

						if obj and not done then
							mask = mask + bit.lshift (1, n)
						end
					end
				end
				
				cur.TrackMask = mask
				-- Calc total number in quest chain
				RDXMAP.Quest.CalcCNumMax (cur, questdata)
			end
		end
		return cur;
	end
end

local function LoadQuestsDS()

	VFL.empty(qdt)
	
	local qcnt = GetNumQuestLogEntries()

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data

	local oldSel = GetQuestLogSelection()

	local header = "?"

	--local qIds = {}
	--RDXMAP.Quest.QIds = qIds

	for qn = 1, qcnt do
		local cur = createQuestByQn(qn);
		if cur then
			table.insert(qdt, cur);
		end
	end

	SelectQuestLogEntry (oldSel)

	--RDXMAP.Quest.SortQuests()
end

local function SortQuestsDS()

end

function GetQuestsDS()
	return qdt;
end