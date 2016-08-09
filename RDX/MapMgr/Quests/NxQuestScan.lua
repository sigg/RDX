
function RDXMAP.Quest.ScanBlizzQuestDataZone()

	local num = QuestMapUpdateAllQuests()		-- Blizz calls these in this order

	if num > 0 then

		QuestPOIUpdateIcons()

		local mapId = RDXMAP.APIMap.GetRealMapId()
		local zone = RDXMAP.MapId2Zone[mapId]

		if not zone then
--			VFL.vprint ("ScanQuestZone %s, %s", mapId or "nil", num)
			return
		end

--		VFL.vprint ("Id %s, %s", mapId, num)

		for n = 1, num do			
			local id, qi = QuestPOIGetQuestIDByVisibleIndex (n)
			if qi and qi > 0 then				
				local title, level, groupCnt, isHeader, isCollapsed, isComplete = GetQuestLogTitle (qi)
				local lbCnt = GetNumQuestLeaderBoards (qi)

				local quest = RDXMAP.Quest.IdToQuest[id] or {}
				local patch = RDXMAP.Quest.IdToQuest[-id] or 0
				local needEnd = isComplete and not quest[3]				
				if patch > 0 or needEnd or (not isComplete and not quest[4]) then					
					local _, x, y, objective = QuestPOIGetIconInfo (id)

					if x then	-- Miner's Fortune was found in org, but x, y, obj were nil

--						VFL.vprint ("%s #%s %s %s %s %s", mapId, n, id, x or "nil", y or "nil", objective or "nil")

						if not quest[1] then

--							self.ScanBlizzChanged = true

							quest[1] = format ("%c%s######", #title + 35, title)

							RDXMAP.Quest.IdToQuest[id] = quest

							RDXMAP.QuestsData[(id + 7) * 2 - 3] = quest
						end

						x = x * 10000
						y = y * 10000

						if needEnd or bit.band (patch, 1) then

							patch = bit.bor (patch, 1)		-- Flag as a patched quest

							quest[3] = format ("##%c %c%c%c%c", zone + 35,
									floor (x / 221) + 35, x % 221 + 35, floor (y / 221) + 35, y % 221 + 35)
						end

						if not isComplete then

							patch = bit.bor (patch, 2)

							local s = title
							local obj = format ("%c%s%c %c%c%c%c", #s + 35, s, zone + 35,
									floor (x / 221) + 35, x % 221 + 35, floor (y / 221) + 35, y % 221 + 35)

							for i = 1, lbCnt do
								quest[3 + i] = obj
							end
						end

						RDXMAP.Quest.IdToQuest[-id] = patch

--[[
						if not self.ScanBlizzChanged and
								(q2 ~= quest[2] or q4 ~= quest[4]) then

							self.ScanBlizzChanged = true
						end
--]]
					end
				end
			end
		end
	end
end

RDXEvents:Bind("PlayerZoneChanged", nil, function(rid)
	if RDXMAP.Quest.IdToQuest then
		RDXMAP.Quest.ScanBlizzQuestDataZone()
	end
end, "RDXMapQuestScan");