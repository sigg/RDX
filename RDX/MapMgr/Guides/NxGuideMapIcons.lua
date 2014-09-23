
RDXMAP.IconGuide = {}

-- deprecated
function RDXMAP.IconGuide.UpdateMapIcons(map, guide)
	local Nx = Nx
	local Quest = Nx.Quest
	local hideFac = RDXMAP.IconGuide.GetHideFaction()
	RDXMAP.APIMap.InitIconType (map, "!G", "WP", "", 16, 16)
	RDXMAP.APIMap.SetIconTypeChop (map, "!G", true)
	RDXMAP.APIMap.InitIconType (map, "!GIn", "WP", "", 20, 20)	
	RDXMAP.APIMap.SetIconTypeChop (map, "!GIn", true)
	RDXMAP.APIMap.InitIconType (map, "!Ga", "WP", "", 12, 12)
	local a = map.GOpts["MapIconGatherA"]
	RDXMAP.APIMap.SetIconTypeAlpha (map, "!Ga", a, a < 1 and a * .5)
	RDXMAP.APIMap.SetIconTypeChop (map, "!Ga", true)
	RDXMAP.APIMap.SetIconTypeAtScale (map, "!Ga", map.GOpts["MapIconGatherAtScale"])
	RDXMAP.APIMap.InitIconType (map, "!GQ", "WP", "", 16, 16)
	RDXMAP.APIMap.SetIconTypeChop (map, "!GQ", true)
	RDXMAP.APIMap.SetIconTypeLevel (map, "!GQ", 1)
	RDXMAP.APIMap.InitIconType (map, "!GQC", "WP", "", 10, 10)
	RDXMAP.APIMap.SetIconTypeChop (map, "!GQC", true)
	local mapId = RDXMAP.APIMap.GetCurrentMapId()
	if not mapId then return end
    if RDXMAP.APIMap.IsMicroDungeon(mapId) then return end 
	for showType, folder in pairs (guide.ShowFolders) do		
		local mode = strbyte (showType)		
		local tx = "Interface\\Icons\\" .. (folder.Tx or "")
		if mode == 36 then					
			local type = strsub (showType, 2, 2)
			local longType = type == "H" and "Herb" or type == "M" and "Mine"
			local fid = folder.Id
			local data = longType and Nx:GetData (longType) or NxData.NXGather["Misc"]
			local zoneT = data[mapId]
			if zoneT then
				local nodeT = zoneT[fid]
				if nodeT then
					local iconType = fid == "Art" and "!G" or "!Ga"
					for k, node in ipairs (nodeT) do
						local x, y = Nx:GatherUnpack (node)
						local name, tex, skill = Nx:GetGather (type, fid)						
						assert (name)
						local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)						
						icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, "Interface\\Icons\\"..tex)
						if skill > 0 then
							name = name .. " " .. skill
						end
						RDXMAP.APIMap.SetIconTip (icon, name)
					end
				end
			end
		elseif mode == 35 then		
		elseif mode == 37 then		
			local mapId = folder.InstMapId
			local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
			if winfo then
				local wx = winfo[2]
				local wy = winfo[3]
				local icon = RDXMAP.APIMap.AddIconPt (map, "!GIn", wx, wy, nil, tx)
				RDXMAP.APIMap.SetIconTip (icon, folder.InstTip)
				RDXMAP.APIMap.SetIconUserData (icon, folder.InstMapId)
			end
		elseif mode == 38 then		
			if Quest and Quest.QGivers then	
				local mapId = RDXMAP.APIMap.GetCurrentMapId()
				mapId=RDXMAP.APIMap.GCMI_OVERRIDE(mapId) 
				local zone = RDXMAP.MapId2Zone[mapId]
				local stzone = Quest.QGivers[zone]
				if stzone then
					local opts = Nx:GetGlobalOpts()
					if not RDXU["Level"] then return end 
					local minLvl = RDXU["Level"] - opts["QMapQuestGiversLowLevel"]
					local maxLvl = RDXU["Level"] + opts["QMapQuestGiversHighLevel"]
					local state = RDXU.Opts[folder.Persist]
					local debugMap = NxData.DebugMap
					local showComplete = RDXG.MapGuide.ShowQuestGiverCompleted
					local qIds = Quest.QIds
					for namex, qdata in pairs (stzone) do
						local name = strsplit ("=", namex)
						local anyDaily
						local show
						local s = name
						for n = 1, #qdata, 4 do
							local qId = tonumber (strsub (qdata, n, n + 3), 16)
							local quest = Quest.IdToQuest[qId]
							local qname, _, lvl, minlvl = Quest:Unpack (quest[1])
							if lvl < 1 then	
								lvl = RDXU["Level"]
							end
							if lvl >= minLvl and lvl <= maxLvl then
								local col = "|r"
								local daily = Quest.DailyIds[qId] or Quest.DailyDungeonIds[qId]
								anyDaily = anyDaily or daily
								local status, qTime = Nx:GetQuest (qId)
								if daily then
									col = "|cffa0a0ff"
									show = true
								elseif status == "C" then
									col = "|cff808080"
								else
									if qIds[qId] then
										col = "|cff80f080"
									end
									show = true
								end
								local qcati = Quest:UnpackCategory (quest[1])
								if qcati > 0 then
									qname = qname .. " <" .. Nx.QuestCategory[qcati] .. ">"
								end
								s = format ("%s\n|cffbfbfbf%d%s %s", s, lvl, col, qname)
								if quest.CNum then
									s = s .. format (" (Part %d)", quest.CNum)
								end
								if daily then
									s = s .. (Quest.DailyDungeonIds[qId] and " (Dungeon Daily" or " (Daily")
									local typ, money, rep, req = strsplit ("^", daily)
									if rep and #rep > 0 then
										s = s .. ", "
										for n = 0, 1 do	
											local i = n * 4 + 1
											local repChar = strsub (rep or "", i, i)
											if repChar == "" then
												break
											end
											s = s .. " " ..  Quest.Reputations[repChar]
										end
									end
									s = s .. ")"
								end
								if debugMap then
									s = s .. format (" [%d]", qId)
								end
							end
						end
						if state == 3 and not anyDaily then
							show = false
							showComplete = false
						end
						if show or showComplete then
							local qId = tonumber (strsub (qdata, 1, 4), 16)
							local quest = Quest.IdToQuest[qId]
							local startName, zone, x, y = Quest:GetSEPos (quest[2])
							local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
							local tx = anyDaily and "Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconExclaimB" or "Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconExclaim" 
							local icon = RDXMAP.APIMap.AddIconPt (map, show and "!GQ" or "!GQC", wx, wy, nil, tx)
							RDXMAP.APIMap.SetIconTip (icon, s)
							icon.UDataQuestGiverD = qdata
						end
					end
				end
			end
		elseif mode == 40 then		
			local mapId, x, y = strsplit ("^", folder.VendorPos)
			mapId = tonumber (mapId)
			x = tonumber (x)
			y = tonumber (y)
			local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
			local icon = RDXMAP.APIMap.AddIconPt (map, "!G", wx, wy, nil, tx)
			RDXMAP.APIMap.SetIconTip (icon, folder.Name)
		elseif mode == 41 then		
			local vv = NxData.NXVendorV
			local t = { strsplit ("^", folder.ItemSource) }
			for _, npcName in pairs (t) do
				local npc = vv[npcName]		
				if npc then
					local links = npc["POS"]
					local mapId, x, y = strsplit ("^", links)
					mapId = tonumber (mapId)
					x = tonumber (x)
					y = tonumber (y)
					local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
					local icon = RDXMAP.APIMap.AddIconPt (map, "!G", wx, wy, nil, tx)
					local tag, name = strsplit ("~", npcName)
					local iname = strsplit ("\n", folder.Name)
					RDXMAP.APIMap.SetIconTip (icon, format ("%s\n%s\n%s", name, tag, iname))
				end
			end
		elseif mode == 42 then		
			local conStr = NxMap.ZoneConnections[folder.ConIndex]
			local flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2 = RDXMAP.APIMap.ConnectionUnpack (conStr)
			if folder.Con2 then
				mapId1, x1, y1, name1 = mapId2, x2, y2, name2
			end
			local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId1, x1, y1)
			local icon = RDXMAP.APIMap.AddIconPt (map, "!G", wx, wy, nil, tx)
			RDXMAP.APIMap.SetIconTip (icon, format ("%s\n%s %.1f %.1f", name1, RDXMAP.APIMap.IdToName(mapId1), x1, y1))
		else
			local cont1 = 1
			local cont2 = RDXMAP.ContCnt
			if not RDXG.MapGuide.ShowAllCont then
				cont1 = RDXMAP.APIMap.IdToContZone (mapId)
				cont2 = cont1
			end
			for cont = cont1, cont2 do
				RDXMAP.IconGuide.UpdateMapGeneralIcons (map, cont, showType, hideFac, tx, folder.Name, "!G")
			end
		end
	end
end


-- deprecated
function RDXMAP.IconGuide.UpdateZonePOIIcons(map, guide)
	local mapId = map.MapId
    mapId = RDXMAP.APIMap.GCMI_OVERRIDE(mapId) 
	local atScale = map.LOpts.NXPOIAtScale
	local alphaRange = atScale * .25
	local s = atScale - alphaRange
	local draw = map.ScaleDraw > s and map.GOpts["MapShowPOI"]
    if RDXMAP.APIMap.IsMicroDungeon(mapId) then draw = false end 
	local alpha = min ((map.ScaleDraw - s) / alphaRange, 1) * map.GOpts["MapIconPOIAlpha"]
	
	RDXMAP.APIMap.InitIconType (map, "!POI", "WP", "", 17, 17)
	RDXMAP.APIMap.SetIconTypeChop (map, "!POI", true)
	RDXMAP.APIMap.SetIconTypeAlpha (map, "!POI", alpha)
	
	RDXMAP.APIMap.InitIconType (map, "!POIIn", "WP", "", 21, 21)
	RDXMAP.APIMap.SetIconTypeChop (map, "!POIIn", true)
	RDXMAP.APIMap.SetIconTypeAlpha (map, "!POIIn", alpha)
	
	--if mapId == map.POIMapId and draw == map.POIDraw then
	--	return
	--end
	--map.POIMapId = mapId
	--map.POIDraw = draw
	if not draw then
		return
	end
	
	local hideFac = UnitFactionGroup ("player") == "Horde" and 1 or 2
	local cont = RDXMAP.APIMap.IdToContZone (mapId)
	if cont > 0 and cont < 9 then
		for k, name in ipairs (RDXMAP.GuidePOI) do
			local showType, tx = strsplit ("~", name)
			if showType == "Mailbox" then
				showType = map.GOpts["MapShowMailboxes"] and showType
			end
			if showType then
				tx = "Interface\\Icons\\" .. tx
				RDXMAP.IconGuide.UpdateMapGeneralIcons (map, cont, showType, hideFac, tx, showType, "!POI", mapId)
			end
		end
		local folder = guide:FindFolder ("Instances")
		RDXMAP.IconGuide.UpdateInstanceIcons (map, cont, folder)
		local folder = guide:FindFolder ("Travel")
		RDXMAP.IconGuide.UpdateTravelIcons (map, hideFac, folder)
	end
end

-- Ajoute les icônes uniquement
function RDXMAP.IconGuide.UpdateMapGeneralIcons (map, cont, showType, hideFac, tx, name, iconType, showMapId)
	if cont >= 9 then
		return
	end
	local Quest = Nx.Quest
	if not RDXMAP.GuideData[showType] then
		VFL.vprint ("guide showType %s", showType)
		return
	end
    
	local dataStr = RDXMAP.GuideData[showType][cont]
	if not dataStr or dataStr == "" then			
		return
	end	
	local mode = strbyte (dataStr)
	if mode == 32 then		
		for n = 2, #dataStr, 6 do
			local fac = strbyte (dataStr, n) - 35
			if fac ~= hideFac then  
				local zone = strbyte (dataStr, n + 1) - 35						
				local mapId = RDXMAP.Zone2MapId[zone]
				if mapId == nil then
				else
					if not showMapId or mapId == showMapId then
						local x, y = RDXMAP.UnpackLocPtOff (dataStr, n + 2)						
						local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
						local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
						if (RDXMAP.APIMap.IdToName(mapId) == nil) then
							VFL.vprint("ERROR: No Map Name For " .. mapId)
						else
							local str = format ("%s\n%s %.1f %.1f", name, RDXMAP.APIMap.IdToName(mapId), x, y)
							RDXMAP.APIMap.SetIconTip (icon, str)
						end
					end
				end
			end
		end
	elseif mode == 33 then		
	else	
		for n = 1, #dataStr, 2 do
			local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
			local npcStr = RDXMAP.NPCData[npcI]
			if not npcStr then
				VFL.vprint ("%s", name)
			end
			local fac = strbyte (npcStr, 1) - 35
			if fac ~= hideFac then
				local oStr = strsub (npcStr, 2)
				local desc, zone, loc = RDXMAP.UnpackObjective (oStr)
				desc = gsub (desc, "!", ", ")
				local mapId = RDXMAP.Zone2MapId[zone]
				if not mapId then
					local name, minLvl, maxLvl, faction, cont = strsplit ("!", NxMap.Zones[zone])
					if tonumber (faction) ~= 3 then
						VFL.vprint ("Guide icon err %s %d", desc, zone)
					end
				elseif not showMapId or mapId == showMapId then
					local mapName = RDXMAP.APIMap.IdToName(mapId)
					if strbyte (oStr, loc) == 32 then  
						loc = loc + 1
						local cnt = floor ((#oStr - loc + 1) / 4)
						for locN = loc, loc + cnt * 4 - 1, 4 do
							local x, y = RDXMAP.UnpackLocPtOff (oStr, locN)
							local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
							local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
							local str = format ("%s\n%s\n%s %.1f %.1f", name, desc:gsub("\239\188\140.*$",""), mapName, x, y)  
							RDXMAP.APIMap.SetIconTip (icon, str)
						end
					else
						local _, zone, x, y = RDXMAP.GetObjectivePos (oStr)
						local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
						local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
						local str = format ("%s\n%s\n%s %.1f %.1f", name, desc:gsub("\239\188\140.*$",""), mapName, x, y)
						RDXMAP.APIMap.SetIconTip (icon, str)
					end
				end
			end
		end
	end
end

-- Ajoute les icônes uniquement
function RDXMAP.IconGuide.UpdateMapGeneralIcons2 (map, cont, showType, hideFac, tx, name, iconType, showMapId)
	if cont >= 9 then
		return
	end
	local Quest = Nx.Quest
	if not RDXMAP.GuideData[showType] then
		VFL.vprint ("guide showType %s", showType)
		return
	end
    
	local dataStr = RDXMAP.GuideData[showType][cont]
	if not dataStr or dataStr == "" then			
		return
	end	
	local mode = strbyte (dataStr)
	if mode == 32 then		
		for n = 2, #dataStr, 6 do
			local fac = strbyte (dataStr, n) - 35
			if fac ~= hideFac then  
				local zone = strbyte (dataStr, n + 1) - 35						
				local mapId = RDXMAP.Zone2MapId[zone]
				if mapId == nil then
				else
					if not showMapId or mapId == showMapId then
						local x, y = RDXMAP.UnpackLocPtOff (dataStr, n + 2)						
						local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
						--local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
						
						local f = VFLUI.POIIcon:new(map, 4)
						f.texture:SetTexture(tx)
						f.X = x
						f.Y = y
						f.NXType = 3000
						if (RDXMAP.APIMap.IdToName(mapId) == nil) then
							VFL.vprint("ERROR: No Map Name For " .. mapId)
						else
							local str = format ("%s\n%s %.1f %.1f", name, RDXMAP.APIMap.IdToName(mapId), x, y)
							--RDXMAP.APIMap.SetIconTip (icon, str)
							f.NxTip = str
						end
						
						table.insert(map.Icon3Frms, f);
						
					end
				end
			end
		end
	elseif mode == 33 then		
	else	
		for n = 1, #dataStr, 2 do
			local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
			local npcStr = RDXMAP.NPCData[npcI]
			if not npcStr then
				VFL.vprint ("%s", name)
			end
			local fac = strbyte (npcStr, 1) - 35
			if fac ~= hideFac then
				local oStr = strsub (npcStr, 2)
				local desc, zone, loc = RDXMAP.UnpackObjective (oStr)
				desc = gsub (desc, "!", ", ")
				local mapId = RDXMAP.Zone2MapId[zone]
				if not mapId then
					local name, minLvl, maxLvl, faction, cont = strsplit ("!", NxMap.Zones[zone])
					if tonumber (faction) ~= 3 then
						VFL.vprint ("Guide icon err %s %d", desc, zone)
					end
				elseif not showMapId or mapId == showMapId then
					local mapName = RDXMAP.APIMap.IdToName(mapId)
					if strbyte (oStr, loc) == 32 then  
						loc = loc + 1
						local cnt = floor ((#oStr - loc + 1) / 4)
						for locN = loc, loc + cnt * 4 - 1, 4 do
							local x, y = RDXMAP.UnpackLocPtOff (oStr, locN)
							--local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
							--local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
							
							local f = VFLUI.POIIcon:new(map, 4)
							f.texture:SetTexture(tx)
							f.X = x
							f.Y = y
							f.NXType = 3000
							local str = format ("%s\n%s\n%s %.1f %.1f", name, desc:gsub("\239\188\140.*$",""), mapName, x, y)  
							--RDXMAP.APIMap.SetIconTip (icon, str)
							f.NxTip = str
							
							table.insert(map.Icon3Frms, f);
						end
					else
						local _, zone, x, y = RDXMAP.GetObjectivePos (oStr)
						--local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
						--local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
						
						local f = VFLUI.POIIcon:new(map, 4)
							f.texture:SetTexture(tx)
							f.X = x
							f.Y = y
							f.NXType = 3000
						local str = format ("%s\n%s\n%s %.1f %.1f", name, desc:gsub("\239\188\140.*$",""), mapName, x, y)
						--RDXMAP.APIMap.SetIconTip (icon, str)
						f.NxTip = str
							
						table.insert(map.Icon3Frms, f);
					end
				end
			end
		end
	end
end

-- Ajoute les icônes uniquement
function RDXMAP.IconGuide.UpdateMapGeneralIcons3 (map, cont, showType, hideFac, tx, name, iconType, showMapId)

	if not RDXMAP.GuideData[showType] then
		VFL.vprint ("guide showType %s", showType)
		return
	end
    
	local dataStr = RDXMAP.GuideData[showType][cont]
	if not dataStr or dataStr == "" then			
		return
	end	
	local mode = strbyte (dataStr)
	if mode == 32 then		
		for n = 2, #dataStr, 6 do
			local fac = strbyte (dataStr, n) - 35
			if fac ~= hideFac then  
				local zone = strbyte (dataStr, n + 1) - 35						
				local mapId = RDXMAP.Zone2MapId[zone]
				if mapId == nil then
				else
					if not showMapId or mapId == showMapId then
						local x, y = RDXMAP.UnpackLocPtOff (dataStr, n + 2)						
						local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
						--local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
						
						local f = VFLUI.POIIcon:new(map, 4)
						f.texture:SetTexture(tx)
						f.X = x
						f.Y = y
						f.NXType = 3000
						if (RDXMAP.APIMap.IdToName(mapId) == nil) then
							VFL.vprint("ERROR: No Map Name For " .. mapId)
						else
							local str = format ("%s\n%s %.1f %.1f", name, RDXMAP.APIMap.IdToName(mapId), x, y)
							--RDXMAP.APIMap.SetIconTip (icon, str)
							f.NxTip = str
						end
						
						table.insert(map.Icon3Frms, f);
						
					end
				end
			end
		end
	elseif mode == 33 then		
	else	
		for n = 1, #dataStr, 2 do
			local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
			local npcStr = RDXMAP.NPCData[npcI]
			if not npcStr then
				VFL.vprint ("%s", name)
			end
			local fac = strbyte (npcStr, 1) - 35
			if fac ~= hideFac then
				local oStr = strsub (npcStr, 2)
				local desc, zone, loc = RDXMAP.UnpackObjective (oStr)
				desc = gsub (desc, "!", ", ")
				local mapId = RDXMAP.Zone2MapId[zone]
				if not mapId then
					local name, minLvl, maxLvl, faction, cont = strsplit ("!", NxMap.Zones[zone])
					if tonumber (faction) ~= 3 then
						VFL.vprint ("Guide icon err %s %d", desc, zone)
					end
				elseif not showMapId or mapId == showMapId then
					local mapName = RDXMAP.APIMap.IdToName(mapId)
					if strbyte (oStr, loc) == 32 then  
						loc = loc + 1
						local cnt = floor ((#oStr - loc + 1) / 4)
						for locN = loc, loc + cnt * 4 - 1, 4 do
							local x, y = RDXMAP.UnpackLocPtOff (oStr, locN)
							--local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
							--local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
							
							local f = VFLUI.POIIcon:new(map, 4)
							f.texture:SetTexture(tx)
							f.X = x
							f.Y = y
							f.NXType = 3000
							local str = format ("%s\n%s\n%s %.1f %.1f", name, desc:gsub("\239\188\140.*$",""), mapName, x, y)  
							--RDXMAP.APIMap.SetIconTip (icon, str)
							f.NxTip = str
							
							table.insert(map.Icon3Frms, f);
						end
					else
						local _, zone, x, y = RDXMAP.GetObjectivePos (oStr)
						--local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
						--local icon = RDXMAP.APIMap.AddIconPt (map, iconType, wx, wy, nil, tx)
						
						local f = VFLUI.POIIcon:new(map, 4)
							f.texture:SetTexture(tx)
							f.X = x
							f.Y = y
							f.NXType = 3000
						local str = format ("%s\n%s\n%s %.1f %.1f", name, desc:gsub("\239\188\140.*$",""), mapName, x, y)
						--RDXMAP.APIMap.SetIconTip (icon, str)
						f.NxTip = str
							
						table.insert(map.Icon3Frms, f);
					end
				end
			end
		end
	end
end

function RDXMAP.IconGuide.UpdateInstanceIcons (map, cont, folder)
	local inst = folder[cont]
	if not inst then	
		return
	end
	for showType, folder in ipairs (inst) do
		local mapId = folder.InstMapId
		local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
		if winfo and winfo.EntryMId == map.MapId then
			local wx = winfo[2]
			local wy = winfo[3]
			local icon = RDXMAP.APIMap.AddIconPt (map, "!POIIn", wx, wy, nil, "Interface\\Icons\\INV_Misc_ShadowEgg")
			RDXMAP.APIMap.SetIconTip (icon, folder.InstTip)
			RDXMAP.APIMap.SetIconUserData (icon, folder.InstMapId)
		end
	end
end
function RDXMAP.IconGuide.UpdateTravelIcons (map, hideFac, folder)
	local mapId = map.MapId
	for showType, folder in ipairs (folder) do
		if folder.MapId == mapId and folder.Fac ~= hideFac then
			local conStr = NxMap.ZoneConnections[folder.ConIndex]
			local flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2 = RDXMAP.APIMap.ConnectionUnpack (conStr)
			if folder.Con2 then
				mapId1, x1, y1, name1 = mapId2, x2, y2, name2
			end
			local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId1, x1, y1)
			local icon = RDXMAP.APIMap.AddIconPt (map, "!POI", wx, wy, nil, "Interface\\Icons\\" .. folder.Tx)
			RDXMAP.APIMap.SetIconTip (icon, format ("%s\n%s %.1f %.1f", name1, RDXMAP.APIMap.IdToName(mapId1), x1, y1))
		end
	end
	local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	if winfo then
		if winfo.Connections then
			for id, zcon in pairs (winfo.Connections) do
				for n, con in ipairs (zcon) do
					local wx, wy = con.StartX, con.StartY
					local icon = RDXMAP.APIMap.AddIconPt (map, "!POI", wx, wy, nil, "Interface\\Icons\\Spell_Nature_FarSight")
					RDXMAP.APIMap.SetIconTip (icon, "Connection to " .. RDXMAP.APIMap.IdToName(con.EndMapId))
					local wx, wy = con.EndX, con.EndY
					local icon = RDXMAP.APIMap.AddIconPt (map, "!POI", wx, wy, nil, "Interface\\Icons\\Spell_Nature_FarSight")
				end
			end
		end
	end
end

function RDXMAP.IconGuide.GetHideFaction()
	local fac = UnitFactionGroup ("player") == "Horde" and 1 or 2
	if RDXG.MapGuide.ShowEnemy then
		fac = fac == 1 and 2 or 1	
	end
	return fac
end