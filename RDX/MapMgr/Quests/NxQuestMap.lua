
local ChoicesQAreaTex = {
		["SolidTexture"] = "Interface\\Buttons\\White8x8",
		["HGrad"] = "Interface\\AddOns\\Carbonite\\Gfx\\Map\\AreaGrad",
	}

--------
-- Update map icons (called by map)

function RDXMAP.Quest.UpdateIcons (map)
	
	local qLocColors = RDXMAP.Quest.QLocColors
	local ptSz = 4 * map.ScaleDraw

	local navscale = map.LOpts.NXIconNavScale * 16
	--local showOnMap = Quest.Watch.ButShowOnMap:GetPressed()
	local showOnMap = true

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data
	local showWatchAreas = opts["QMapShowWatchAreas"]
	local trkR, trkG, trkB, trkA = VFL.explodeHexNumberRGBA (opts["QMapWatchAreaTrackColor"])
	local hovR, hovG, hovB, hovA = VFL.explodeHexNumberRGBA (opts["QMapWatchAreaHoverColor"])

	-- Update target

	local typ, tid = RDXMAP.APIMap.GetTargetInfo()
	if typ == "Q" then

--		VFL.vprint ("QTar %s", tid)

		local qid = floor (tid / 100)
		local i, cur = RDXMAP.APIQuest.FindCur (qid)

		if cur then
			RDXMAP.Quest.CalcDistances (cur.Index, cur.Index)
			RDXMAP.Quest.TrackOnMap (cur.QId, tid % 100, cur.QI > 0 or cur.Party, true, true)

--			VFL.vprint ("UpIcons target %s %s", typ or "nil", tid or "nil")
		end
	end

	-- Blob

--	local f = self.BlobFrm


	-- Draw completed quests

	for k, cur in ipairs (RDXMAP.Quest.CurQ) do

		if cur.Q and cur.CompleteMerge then

			local q = cur.Q
			local obj = q[3] or q[2]

			local endName, zone, x, y = RDXMAP.GetSEPos (obj)
			local mapId = RDXMAP.Zone2MapId[zone]

			if mapId then

				local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
				local f = RDXMAP.APIMap.GetIconStatic (map, 4)

				if RDXMAP.APIMap.ClipFrameW (map, f, wx, wy, navscale, navscale, 0) then

					f.NXType = 9000
					f.NXData = cur
					local qname = "|cffc0c0ff" .. "Quest: " .. cur.Title
					f.NxTip = format ("%s\nEnd: %s (%.1f %.1f)", qname, endName, x, y)
					if cur.PartyNames then
						f.NxTip = f.NxTip .. "\n" .. cur.PartyNames
					end
					f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconQuestion")
				end
			end
		end
	end

	-- Update tracking data

	local tracking = RDXMAP.Quest.IconTracking

	if VFLT.GetFrameCounter() % 10 == 0 then

--		tracking = {}		-- garbage creator
		wipe (tracking)

		for trackId, trackMode in pairs (RDXMAP.Quest.Tracking) do
			tracking[trackId] = trackMode
		end

		if showOnMap then
			for k, cur in ipairs (RDXMAP.Quest.CurQ) do
				if cur.Q and (RDXMAP.APIQuest.GetQuest (cur.QId) == "W" or cur.PartyDesc) then
					tracking[cur.QId] = (tracking[cur.QId] or 0) + 0x10000		-- cur.TrackMask + i
				end
			end
		end

		RDXMAP.Quest.IconTracking = tracking
	end

	-- Draw

	local areaTex = ChoicesQAreaTex[opts["QMapWatchAreaGfx"]]

	local colorPerQ = opts["QMapWatchColorPerQ"]
	local colMax = opts["QMapWatchColorCnt"]

	for trackId, trackMode in pairs (tracking) do

		local cur = RDXMAP.Quest.IdToCurQ[trackId]
		local quest = cur and cur.Q or RDXMAP.Quest.IdToQuest[trackId]
		local qname = "|cffc0c0ff" .. "Quest: " .. (cur and cur.Title or RDXMAP.UnpackName (quest[1]))

		local mask = showOnMap and cur and cur.TrackMask or trackMode
		local showEnd

		if bit.band (mask, 1) > 0 then

			if not (cur and (cur.QI > 0 or cur.Party)) then

				local startName, zone, x, y = RDXMAP.GetSEPos (quest[2])
				local mapId = RDXMAP.Zone2MapId[zone]

				if mapId then

					local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
					local f = RDXMAP.APIMap.GetIconStatic (map, 4)

					if RDXMAP.APIMap.ClipFrameW (map, f, wx, wy, navscale, navscale, 0) then
						f.NxTip = format ("%s\nStart: %s (%.1f %.1f)", qname, startName, x, y)
						f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconExclaim")
					end
				end
			else

				showEnd = true
			end
		end

		if showEnd or bit.band (mask, 0x10000) > 0 then

			local obj = quest[3] or quest[2]

			local endName, zone, x, y = RDXMAP.GetSEPos (obj)
			local mapId = RDXMAP.Zone2MapId[zone]

			if mapId and (not cur or not cur.CompleteMerge) then

				local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)
				local f = RDXMAP.APIMap.GetIconStatic (map, 4)

				if RDXMAP.APIMap.ClipFrameW (map, f, wx, wy, navscale, navscale, 0) then

					f.NXType = 9000
					f.NXData = cur
					f.NxTip = format ("%s\nEnd: %s (%.1f %.1f)", qname, endName, x, y)
					if cur and cur.PartyNames then
						f.NxTip = f.NxTip .. "\n" .. cur.PartyNames
					end
					f.texture:SetVertexColor (.6, 1, .6, 1)
					f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconQuestion")
--					f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconQTarget")
				end
			end
		end

		-- Objectives (max of 15)

		if not cur or cur.QI > 0 or cur.Party then

			local drawArea

			if cur then
				local qStatus = RDXMAP.APIQuest.GetQuest (cur.QId)
				drawArea = showWatchAreas and qStatus == "W"
			end
--			local drawArea = bit.band (trackMode, 0x10000) == 0

			for n = 1, 15 do

				local obj = quest[n + 3]
				if not obj then
					break
				end

				local objName, objZone, loc = RDXMAP.UnpackObjective (obj)

				if objZone then

					local mapId = RDXMAP.Zone2MapId[objZone]

					if not mapId then
--						VFL.vprint ("Nxzone error %s %s", objName, objZone)
						break
					end

--					VFL.vprint ("%s zone %d %s", objName, mapId, loc)

					if loc and bit.band (mask, bit.lshift (1, n)) > 0 then

						local colI = n

						if colorPerQ then
							colI = ((cur and cur.Index or 1) - 1) % colMax + 1
						end

						local col = qLocColors[colI]
						local r = col[1]
						local g = col[2]
						local b = col[3]

						local oname = cur and cur[n] or objName

						if strbyte (obj, loc) == 32 then  -- Points

--							VFL.vprint ("%s, pt %s", objName, strsub (obj, loc + 1))

							loc = loc + 1

							local cnt = floor ((#obj - loc + 1) / 4)
							local sz = navscale

							if cnt > 1 then
								sz = RDXMAP.APIMap.GetWorldZoneScale (mapId) / 10.02 * ptSz
							end

							for locN = loc, loc + cnt * 4 - 1, 4 do

								local x, y = RDXMAP.UnpackLocPtOff (obj, locN)
								local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)

								local f = RDXMAP.APIMap.GetIconStatic (map, 4)

								if RDXMAP.APIMap.ClipFrameW (map, f, wx, wy, sz, sz, 0) then

									f.NXType = 9000 + n
									f.NXData = cur

									f.NxTip = format ("%s\nObj: %s (%.1f %.1f)", qname, oname, x, y)
									if cur and cur[n + 400] then
										f.NxTip = f.NxTip .. "\n" .. cur[n + 400]
									end

									if cnt == 1 then
										f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconQTarget")
										f.texture:SetVertexColor (r, g, b, .9)
									else
										f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconCirclePlus")
										f.texture:SetVertexColor (r, g, b, .5)
									end
								end
							end

						else -- Spans (areas)

--							VFL.vprint ("%s, spans %s", objName, strsub (obj, loc))

							local hover = RDXMAP.Quest.IconHoverCur == cur and RDXMAP.Quest.IconHoverObjI == n
							local tracking = bit.band (trackMode, bit.lshift (1, n)) > 0

							local tip = format ("%s\nObj: %s", qname, oname)
							if cur and cur[n + 400] then
								tip = tip .. "\n" .. cur[n + 400]
							end

							local x

							if cur then
								local d = cur["OD"..n]
								if d and d > 0 then
									x = cur["OX"..n]
								end
							end

							if x then
								local y = cur["OY"..n]
								local f = RDXMAP.APIMap.GetIcon (map, 4)
								local sz = navscale

								if not hover then
									sz = sz * .8
								end

								if RDXMAP.APIMap.ClipFrameW (map, f, x, y, sz, sz, 0) then

									f.NXType = 9000 + n
									f.NXData = cur
									f.NxTip = tip

									f.texture:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Map\\IconAreaArrows")

									if tracking then
										f.texture:SetVertexColor (.8, .8, .8, 1)
									else
										f.texture:SetVertexColor (r, g, b, .7)
									end
								end
							end

							if not cur or drawArea or hover
									or (bit.band (trackMode, bit.lshift (1, n)) > 0 and trkA > .05) then

								local scale = RDXMAP.APIMap.GetWorldZoneScale (mapId) / 10.02
								local cnt = floor ((#obj - loc + 1) / 4)
								local ssub = strsub

								for locN = loc, loc + cnt * 4 - 1, 4 do

									local loc1 = ssub (obj, locN, locN + 3)
									if loc1 == "" then
										break
									end

									local x, y, w, h = RDXMAP.UnpackLocRect (loc1)									
									local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, x, y)

									local f = RDXMAP.APIMap.GetIconStatic (map, hover and 1)

									if areaTex then

										if RDXMAP.APIMap.ClipFrameTL (map, f, wx, wy, w * scale, h * scale) then

											f.NXType = 9000 + n
											f.NXData = cur
											f.NxTip = tip

											f.texture:SetTexture (areaTex)

											if hover then
												f.texture:SetVertexColor (hovR, hovG, hovB, hovA)
											elseif tracking then
												f.texture:SetVertexColor (trkR, trkG, trkB, trkA)
											else
												f.texture:SetVertexColor (r, g, b, col[4])
											end
										end

									else

										if RDXMAP.APIMap.ClipFrameTLSolid (map, f, wx, wy, w * scale, h * scale) then

											f.NXType = 9000 + n
											f.NXData = cur
											f.NxTip = tip

											if hover then
												f.texture:SetColorTexture (hovR, hovG, hovB, hovA)
											elseif tracking then
												f.texture:SetColorTexture (trkR, trkG, trkB, trkA)
											else
												f.texture:SetColorTexture (r, g, b, col[4])
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function RDXMAP.Quest.IconOnEnter (frm)

	local i = frm.NXType - 9000
	local cur = frm.NXData

	RDXMAP.Quest.IconHoverCur = cur
	RDXMAP.Quest.IconHoverObjI = i
end

function RDXMAP.Quest.IconOnLeave (frm)
	RDXMAP.Quest.IconHoverCur = nil
end

function RDXMAP.Quest.IconOnMouseDown (frm)

	local cur = RDXMAP.Quest.IconHoverCur
	if cur then

		RDXMAP.Quest.IconMenuCur = cur
		RDXMAP.Quest.IconMenuObjI = RDXMAP.Quest.IconHoverObjI

		local qStatus = RDXMAP.APIQuest.GetQuest (cur.QId)
		--self.IconMenuIWatch:SetChecked (qStatus == "W")
		
		VFL.poptree:Begin(150, 12, frm, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(frm));
		Nx.Quest.IconMenu:Open(VFL.poptree, nil, nil, "TOPLEFT", 0, 0, nil);
		
		--self.IconMenu:Open()
	end
end


--------
-- Track quest on map

function RDXMAP.Quest.TrackOnMap (qId, qObj, useEnd, target, skipSame)
	
	local BlizIndex = nil    
	local quest = RDXMAP.Quest.IdToQuest[qId]
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local GOpts = mbo.data
	
	if GOpts["QSync"] then		
		local i = 1
		while GetQuestLogTitle(i) do
			local _, _, _, _, _, _, _, questID = GetQuestLogTitle(i)
			if questID == qId then
				BlizIndex = i
			else
				if (IsQuestWatched(i)) then
					RemoveQuestWatch(i)
				end
			end
		i = i + 1
		end	
	end
	if quest then

		local tbits = RDXMAP.Quest.Tracking[qId] or 0
--[[
		if tbits == 0 then	-- Nothing tracked?

			local typ, tid = RDXMAP.APIMap.GetTargetInfo()
			if typ == "Q" then

				local tqid = floor (tid / 100)
				if tqid == qId then		-- Same as us?
					RDXMAP.APIMap.ClearTargets()
				end
			end
			return
		end
--]]
		local track = bit.band (tbits, bit.lshift (1, qObj))

		local questObj
		local name, zone, loc

		if qObj == 0 then
			questObj = useEnd and quest[3] or quest[2]
			name, zone, loc = RDXMAP.UnpackSE (questObj)
		else
			questObj = quest[qObj + 3]
			name, zone, loc = RDXMAP.UnpackObjective (questObj)
		end

--		VFL.vprint ("TrackOnMap %s %s %s %s %s", qId, qObj, track, name, zone)

		if track > 0 and zone then
			if GOpts["QSync"] then
				if BlizIndex then
					if not (IsQuestWatched(BlizIndex)) then
						AddQuestWatch(BlizIndex)
					end	
				end
			end
			
			--local QMap = NxMap1.NxMap
			--[[
			local QMap = Nx.Map:GetMap (1) ---
			if not InCombatLockdown() then	
				local cur = RDXMAP.Quest.QIds[qId]
				if cur then
					if not cur.Complete then		
						QMap.QuestWin:DrawNone();
						if RDXU.Opts["MapShowQuestBlobs"] then
							QMap.QuestWin:DrawBlob(qId,true)
							RDXMAP.APIMap.ClipZoneFrm( QMap, QMap.Cont, QMap.Zone, QMap.QuestWin, 1 )
							QMap.QuestWin:SetFrameLevel(QMap.Level)		
							QMap.QuestWin:SetFillAlpha(255 * QMap.QuestAlpha)
							QMap.QuestWin:SetBorderAlpha( 255 * QMap.QuestAlpha )		
							QMap.QuestWin:Show()		
						else
							QMap.QuestWin:Hide()
						end
					end
				end
			end
			]]
	
			local mId = RDXMAP.Zone2MapId[zone]
			if mId then

				if target then

					local x1, y1, x2, y2

					if qObj > 0 then

						local myunit = RDXDAL.GetMyUnit();
						local px = myunit.PlyrX
						local py = myunit.PlyrY

						-- FIX!!!!!!!!!!!!

--						x1, y1, x2, y2 = Quest:GetClosestObjectiveRect (questObj, mId, px, py)
						x1, y1 = RDXMAP.APIQuest.GetClosestObjectivePos (questObj, loc, mId, px, py)
						x2 = x1
						y2 = y1
					else

						x1, y1, x2, y2 = RDXMAP.GetObjectiveRect (questObj, loc)
						x1, y1 = RDXMAP.APIMap.GetWorldPos (mId, x1, y1)
						x2, y2 = RDXMAP.APIMap.GetWorldPos (mId, x2, y2)
						
						x1 = (x1 + x2) * .5
						y1 = (y1 + y2) * .5
					end

					local cur = RDXMAP.Quest.QIds[qId]
--					local _, cur = RDXMAP.APIQuest.FindCur (qId)
					if cur then
						if qObj > 0 then
							name = cur[qObj] or name
--							VFL.vprint ("TrackOnMap name %s", name)
						end

						if cur.Complete then
							name = name .. " |cff80ff80(Complete)"
						end
					end

					if skipSame then
						--if RDXMAP.APIQuest.IsTargeted (qId, qObj, x1, y1, x2, y2) then
						if RDXMAP.APIQuest.IsTargeted (qId, qObj, x1, y1) then
							RDXMAP.APIMap.SetTargetName (name)
							return
						end
					end
					
					
					
					RDXMAP.APIMap.SetTarget ("Q", x1, y1, qId * 100 + qObj, name, false, mId)
--					VFL.vprint ("TrackOnMap %s %s %s", qId, qObj, name)

					RDXMapEvents:Dispatch("Guide:ClearAll")
				end

				RDXMapEvents:Dispatch("GotoPlayer")

			else
				RDXMAP.Quest.MsgNotInDB ("Z")
--				VFL.vprint ("quest zone %s", zone)
			end

		else	-- Clear tracking

			local typ, tid = RDXMAP.APIMap.GetTargetInfo()
			if typ == "Q" then

				local tqid = floor (tid / 100)
				if tqid == qId then		-- Same quest as us?

					if tbits == 0 or (tid == qId * 100 + qObj) then
						if GOpts["QSync"] then
							RemoveQuestWatch(BlizIndex)
						end
	
						RDXMAP.APIMap.ClearTargets()
					end
				end
			end
		end
	end
end

--------
-- Track quest on map

function RDXMAP.Quest.CalcAutoTrack (cur)

	local curq = RDXMAP.Quest.CurQ
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:quest");
	local qopts = mbo.data
	--local qopts = Nx:GetQuestOpts()

	RDXMAP.Quest.Tracking = {}
	local closest = false
	local dist = 99999999

	if cur.Q then

--		RDXMAP.Quest.Tracking[cur.QId] = cur.TrackMask

		local closeI = cur.CloseObjI
		if closeI and closeI >= 0 then

			RDXMAP.Quest.Tracking[cur.QId] = cur.TrackMask			-- bit.lshift (1, closeI)
			RDXMAP.Quest.TrackOnMap (cur.QId, closeI, cur.QI > 0 or cur.Party, true, true)
		end

		for objn = 1, 15 do

			local obj = cur.Q[objn + 3]
			if not obj then
				break
			end

			local obit = bit.lshift (1, objn)
			if bit.band (cur.TrackMask, obit) > 0 then

				if RDXMAP.GetObjectiveType (obj) == 1 then

					local d = cur["OD"..objn]

					if d and d < dist then
						dist = d
						closest = cur
--						Quest.ClosestSpanI = objn
					end
				end
			end
		end
	end

--	Quest.ClosestSpanCur = closest
end

--------
-- Check if any part of quest in the map

function RDXMAP.Quest.CheckShow (mapId, qId)

	local nxid = RDXMAP.MapId2Zone[mapId]
	local quest = RDXMAP.Quest.IdToQuest[qId]

	if not quest then
		return
	end

	local qname, side, lvl, minlvl, next = RDXMAP.Unpack (quest[1])

	--	Check start, end and objectives
--[[
	if not quest[2] then
		VFL.vprint ("quest error: %s %s", qname, qId)
		assert (quest[2])
	end
--]]
	local _, startMapId = RDXMAP.UnpackSE (quest[2])
	if startMapId then
		if startMapId == nxid then
			return true
		end
	end

	if quest[3] then
		local _, endMapId = RDXMAP.UnpackSE (quest[3])
		if endMapId then
			if endMapId == nxid then
				return true
			end
		end
	end

	for n = 1, 15 do

		local obj = quest[n + 3]
		if not obj then
			break
		end

		local _, objMapId = RDXMAP.UnpackObjective (obj)

		if objMapId then

			if objMapId == nxid then
				return true
			end
		end
	end
end


--------
-- Calc watch distance

function RDXMAP.Quest.CalcDistances (n1, n2)

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:quest");
	local qopts = mbo.data
	---local qopts = Nx:GetQuestOpts()
	local myunit = RDXDAL.GetMyUnit();
	local px = myunit.PlyrX
	local py = myunit.PlyrY
	local playerLevel = UnitLevel ("player")

	local curq = RDXMAP.Quest.CurQ
	if not curq then	-- Bad stuff?
		return
	end

	for n = n1, n2 do

		local cur = curq[n]

		if not cur then
			break
		end

		local qi = cur.QI
		local qId = cur.QId

		local id = qId > 0 and qId or cur.Title
		local qStatus = RDXMAP.APIQuest.GetQuest (id)
		local qWatched = (qStatus == "W")
		local quest = cur.Q

		cur.Priority = 1
		cur.Distance = 999999999
		cur.CloseObjI = -1

		if cur.Complete and cur.IsAutoComplete then
			cur.Distance = 0
		end

--		if quest and (qWatched or Nx.Free) then
		if quest then

			local cnt = (cur.CompleteMerge or cur.LBCnt == 0) and 0 or 99

			for qObj = 0, cnt do

				local questObj

				if qObj == 0 then
					questObj = (qi > 0 or cur.Party) and quest[3] or quest[2]	-- Start if goto or no end?
				else
					questObj = quest[qObj + 3]
				end

				if not questObj then
					break
				end

				if bit.band (cur.TrackMask, bit.lshift (1, qObj)) > 0 then

					local _, zone, loc

					if qObj == 0 then
						_, zone, loc = RDXMAP.UnpackSE (questObj)
					else
						_, zone, loc = RDXMAP.UnpackObjective (questObj)
					end

					if zone then

						local mId = RDXMAP.Zone2MapId[zone]
						if mId then

							local x, y = RDXMAP.APIQuest.GetClosestObjectivePos (questObj, loc, mId, px, py)
							local dist = ((x - px) ^ 2 + (y - py) ^ 2) ^ .5

							if dist < cur.Distance then
								cur.CloseObjI = qObj
								cur.Distance = dist
							end

							cur["OX"..qObj] = x
							cur["OY"..qObj] = y
							cur["OD"..qObj] = dist
						end
					end
				end
			end

--PAIDS!
			local pri = 0

			-- Player lvl 30. PriLevel = 20
			-- Q1  100 Lvl 30: 0 ldif = 0
			-- Q2  400 Lvl 20: 10 ldif = 200, .1, 90% = 360
			-- Q3 2000 Lvl 25: 5 ldif = 100, .05, 95% = 1900

			-- Player lvl 30. PriLevel = 200
			-- Q1  100 Lvl 30: 0 ldif = 0
			-- Q2  400 Lvl 20: 10 ldif = 2000, .99, 1% = 4
			-- Q3 2000 Lvl 25: 5 ldif = 1000, .5, 50% = 1000

			-- Formula: cur.Distance * priDist * cur.Priority * 10 + cur.Priority * 100

			if cur.CompleteMerge then
				pri = qopts.NXWPriComplete * 8	-- +-1600

			else
				-- 20 default. 10 lvls max diff * 200 = +-2000
				local l = min (playerLevel - cur.Level, 10)
				l = max (l, -10)
				pri = l * qopts.NXWPriLevel
			end

			cur.Priority = 1 - pri / 2010

			cur.InZone = RDXMAP.Quest.CheckShow (myunit.mapId, qId)
--PAIDE!
		end
	end
end
