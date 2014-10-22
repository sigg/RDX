
--------
-- Update map icons (called by map)

function RDXMAP.Quest.UpdateIcons (map)
	if not Nx then return; end
	local Nx = Nx
	local Quest = Nx.Quest
	
	local qLocColors = Quest.QLocColors
	local ptSz = 4 * map.ScaleDraw

	local navscale = map.LOpts.NXIconNavScale * 16
	local showOnMap = Quest.Watch.ButShowOnMap:GetPressed()

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
			Quest:CalcDistances (cur.Index, cur.Index)
			Quest:TrackOnMap (cur.QId, tid % 100, cur.QI > 0 or cur.Party, true, true)

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
					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQuestion")
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

	local areaTex = Nx.Opts.ChoicesQAreaTex[opts["QMapWatchAreaGfx"]]

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
						f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconExclaim")
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
					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQuestion")
--					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQTarget")
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
										f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconQTarget")
										f.texture:SetVertexColor (r, g, b, .9)
									else
										f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconCirclePlus")
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

									f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconAreaArrows")

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
												f.texture:SetTexture (hovR, hovG, hovB, hovA)
											elseif tracking then
												f.texture:SetTexture (trkR, trkG, trkB, trkA)
											else
												f.texture:SetTexture (r, g, b, col[4])
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