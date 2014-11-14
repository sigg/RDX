

function RDXMAP.Quest:Init()
	RDXMAP.Quest.BlizzAcceptQuest = AcceptQuest
	AcceptQuest = RDXMAP.Quest.AcceptQuest
	--	RDXMAP.Quest.BlizzCompleteQuest = CompleteQuest
	--	CompleteQuest = RDXMAP.Quest.CompleteQuest
	RDXMAP.Quest.BlizzGetQuestReward = GetQuestReward
	GetQuestReward = RDXMAP.Quest.GetQuestReward
	
	local function func()
	--		VFL.vprint ("QAccept")
		if QuestGetAutoAccept() then
		--			VFL.vprint ("auto")
			RDXMAP.Quest.RecordQuestAcceptOrFinish()
		end

		QuestFrameDetailPanel_OnShow()
		local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
		local gopts = mbo.data
		local auto = gopts["QAutoAccept"]
		if IsShiftKeyDown() and IsControlKeyDown() then
			auto = not auto
		end
		if auto and not QuestGetAutoAccept() then
			AcceptQuest()
		end
	end

	QuestFrameDetailPanel:SetScript ("OnShow", func);
	
end

--------
-- Track quest acception

function RDXMAP.Quest.AcceptQuest (...)
	RDXMAP.Quest.RecordQuestAcceptOrFinish()
	RDXMAP.Quest.BlizzAcceptQuest (...)
end

--[[
function RDXMAP.Quest.CompleteQuest (...)

--	VFL.vprint ("CompleteQuest ")
--	VFL.vprint ("Title '%s'", GetTitleText())
	RDXMAP.Quest.BlizzCompleteQuest (...)
end
--]]

function RDXMAP.Quest.GetQuestReward (choice, ...)

--	VFL.vprint ("GetQuestReward %s", choice or "nil")
	RDXMAP.Quest.FinishQuest()	
    RDXMAP.Quest.BlizzGetQuestReward (choice, ...)	
end

function RDXMAP.Quest.RecordQuestAcceptOrFinish()

	local giver = UnitName ("npc") or "?"

	local guid = UnitGUID ("npc")
	if guid then
		local tbl = { strsplit("-", guid) };
		
		if tbl[1] == "Player" then	-- Player
			giver = "p"
		elseif tbl[1] == "Creature" then
			local id = tbl[6] or "null"
			giver = format ("%s#o%x", giver, id)
		end
	end
	--VFL.print(giver);
	
	RDXMAP.Quest.AcceptGiver = giver

	local qname = GetTitleText()		-- Also works for auto accept
	RDXMAP.Quest.AcceptQName = qname

	local id = RDXMAP.APIMap.GetRealMapId()
	RDXMAP.Quest.AcceptAId = id or 0

	RDXMAP.Quest.AcceptDLvl = 0
	
	local myunit = RDXDAL.GetMyUnit();

	if myunit.mapId == id then
		RDXMAP.Quest.AcceptDLvl = GetCurrentMapDungeonLevel()
	end

	
	RDXMAP.Quest.AcceptX = myunit.PlyrRZX
	RDXMAP.Quest.AcceptY = myunit.PlyrRZY

--	VFL.vprint ("AcceptQuest (%s) (%s) %s,%s", giver, qname, RDXMAP.Quest.AcceptAId, RDXMAP.Quest.AcceptDLvl)

end

function RDXMAP.Quest.FinishQuest()

--	VFL.vprint ("FinishQuest")

	local finTitle = GetTitleText()
	finTitle = RDXMAP.APIQuest.ExtractTitle (finTitle)

	local i, cur = RDXMAP.APIQuest.FindCur (finTitle)

	if not i then

--		Nx:ShowMessage (Nx.TXTBLUE.."Carb:\n|rCan't find quest in list!\nAn addon may have modified the title\n'" .. finTitle .. "'", "Continue")
--		assert (nil)
		return
	end

	cur.QI = 0		-- 0 so we dont get a final party message

	local qId = cur.QId

	assert (type (qId) ~= "string")

	local id = qId > 0 and qId or cur.Title
	RDXMAP.APIQuest.SetQuest (id, "C", time())

	RDXMAP.Quest.RecordQuestAcceptOrFinish()
	RDXMAP.Quest.Capture (i, -1)

--	VFL.vprint ("FinishQuest #%s (%s) %s", i, id, cur.Title)

	if cur.Q then

		RDXMAP.Quest.Tracking[qId] = 0
		RDXMAP.Quest.TrackOnMap (qId, 0)
	end

	--	self.List:Update()
	RDXMapEvents:Dispatch("Watch:Update");
end