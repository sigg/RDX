
--------
-- Draw group (raid or party)
-- (player world pos)

function RDXMAP.APIMap.UpdateGroup (map, plX, plY)

	local alt = IsAltKeyDown()
	local redGlow = abs (GetTime() * 400 % 200 - 100) / 200 + .5

	local members = MAX_PARTY_MEMBERS
	local unitName = "party"
	local raid

	if IsInRaid() then
		members = MAX_RAID_MEMBERS
		unitName = "raid"
		raid = true
	end

	local pals = Nx.Com.PalNames
	local palName
	local palDist = 99999999
	local palX, palY
	local combatName
	local combatUnit
	local combatHealth
	local combatDist = 99999999
	local combatX, combatY

	local palsInfo = Nx.Com.PalsInfo

	for i = 1, members do

		local unit = unitName .. i
		local name, unitRealm = UnitName (unit)

		local mapId = map.MapId

		local pX, pY = GetPlayerMapPosition (unit)
		if pX <= 0 and pY <= 0 then

			local info = palsInfo[name]
			if info and info.EntryMId == mapId then
				mapId = info.MId
				pX = info.X + .00001
				pY = info.Y
			end

		else
			pX = pX * 100
			pY = pY * 100
		end

		if (pX ~= 0 or pY ~= 0) and not UnitIsUnit (unit, "player") then

			local fullName = unitRealm and #unitRealm > 0 and (name .. "-" .. unitRealm) or name

			local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, pX, pY)

			local sz = 16 * map.LOpts.NXDotRaidScale
			if UnitInParty (unit) then
				sz = 18 * map.LOpts.NXDotPartyScale
			end

			local cls = UnitClass (unit) or ""
			local inCombat
--PAIDS!
			inCombat = UnitAffectingCombat (unit)
--PAIDE!
			local h = UnitHealth (unit)
			if UnitIsDeadOrGhost (unit) then
				h = 0
			end
			local m = UnitHealthMax (unit)
			local per = min (h / m, 1)			-- Can overflow?

			if per > 0 then

				if pals[name] ~= nil or RDXMAP.TrackPlyrs[name] then

--					VFL.vprintCtrl ("Pal %s", name)

					sz = 20 * map.LOpts.NXDotPalScale

					if RDXMAP.TrackPlyrs[name] then
						sz = 25 * map.LOpts.NXDotPalScale
					end

					local dist = (plX - wx) ^ 2 + (plY - wy) ^ 2
					if dist < palDist then
						palName = name
						palDist = dist
						palX, palY = wx, wy

--						VFL.vprintCtrl ("Pal %s %s", name, dist)
					end
				end

				if inCombat then

					local dist = (plX - wx) ^ 2 + (plY - wy) ^ 2
					if dist < combatDist then
						combatName = name
						combatUnit = unit
						combatHealth = per
						combatDist = dist
						combatX, combatY = wx, wy
					end
				end
			end

			local f1 = RDXMAP.APIMap.GetIcon (map, 1)

			if RDXMAP.APIMap.ClipFrameW (map, f1, wx, wy, sz, sz, 0) then

				f1.NXType = 1000
				f1.NXData = unit
				f1.NXData2 = fullName

				local inactive
				for n = 1, MAX_TARGET_DEBUFFS do
					if UnitDebuff (unit, n) == "Inactive" then
						inactive = true
						per = 0
						break
					end
				end

				local txName = "IconPlyrP"

				if pals[name] == false then
					txName = "IconPlyrF"
				elseif pals[name] == true then
					txName = "IconPlyrG"
				end

				if inCombat then
					txName = txName.."C"
				end

				f1.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\"..txName)

--				VFL.vprint ("#%d %.1f %.1f", i, pX, pY)

				-- Show health

				local tStr = ""
--PAIDS!
				f = RDXMAP.APIMap.GetIconNI (map, 2)

				if per > .33 then

					-- Horizontal bar at top left

					local sc = map.ScaleDraw
					RDXMAP.APIMap.ClipFrameTL (map, f, wx - 9 / sc, wy - 10 / sc, 16 * per / sc, 1 / sc)
--					RDXMAP.APIMap.ClipFrameZTLO (map, f, pX, pY, 12 * per / map.ScaleDraw, .9 / map.ScaleDraw, -7, -7)
					f.texture:SetTexture (1, 1, 1, 1)

				else
					RDXMAP.APIMap.ClipFrameW (map, f, wx, wy, 7, 7, 0)
--					RDXMAP.APIMap.ClipFrameZ (map, f, pX, pY, 7, 7, 0)

					if per > 0 then
						f.texture:SetTexture (1, .1, .1, 1 - per * 2)
					else
						if inactive then
							f.texture:SetTexture (1, 0, 1, .7)	-- Punk
						else
							f.texture:SetTexture (0, 0, 0, .5)	-- Dead
						end
					end
				end

				-- Show target info

				local unitTarget = unit.."target"
				local tName = UnitName (unitTarget)
				local tEnPlayer

				if tName then

					local tLvl = UnitLevel (unitTarget)
					local tCls = UnitClass (unitTarget) or ""
					if tName == tCls then
						tCls = ""
					end

					local th = UnitHealth (unitTarget)
					if UnitIsDeadOrGhost (unitTarget) then
						th = 0
					end
					local tm = max (UnitHealthMax (unitTarget), 1)
					local per = min (th / tm, 1)

--					VFL.vprint ("H %d", th)

					local f = RDXMAP.APIMap.GetIconNI (map, 2)
					local sc = map.ScaleDraw

					if UnitIsFriend ("player", unitTarget) then

						-- Horizontal green bar
						RDXMAP.APIMap.ClipFrameTL (map, f, wx - 9 / sc, wy - 2 / sc, 16 * per / sc, 1 / sc)
						f.texture:SetTexture (0, 1, 0, 1)

						tStr = format ("\n|cff80ff80%s %d %s %d", tName, tLvl, tCls, th)

						if not UnitIsPlayer (unitTarget) then	-- NPC?
							tStr = tStr .. "%"
						end
					else
						RDXMAP.APIMap.ClipFrameTL (map, f, wx - 9 / sc, wy - 9 / sc, 1 / sc, 15 * per / sc)

						if UnitIsPlayer (unitTarget) then

							tEnPlayer = true
							tStr = format ("\n|cffff4040%s %d %s %d%%", tName, tLvl, tCls, th)
							f.texture:SetTexture (redGlow, .1, 0, 1)

						elseif UnitIsEnemy ("player", unitTarget) then

							tStr = format ("\n|cffffff40%s %d %s %d%%", tName, tLvl, tCls, th)

							if Nx:UnitIsPlusMob (unitTarget) then
								f.texture:SetTexture (1, .4, 1, 1)
							else
								f.texture:SetTexture (1, 1, 0, 1)
							end

						else
							tStr = format ("\n|cffc0c0ff%s %d %s %d%%", tName, tLvl, tCls, th)
							f.texture:SetTexture (.7, .7, 1, 1)
						end
					end
				end
--PAIDE!
				local lvl = UnitLevel (unit)
				local qStr = Nx.Com:GetPlyrQStr (name)

				if raid then
					local name, rank, grp = GetRaidRosterInfo (i)
					cls = cls .. " G" .. grp
				end

				f1.NxTip = format ("%s %d %s %d%%\n(%d,%d) %s %s%s", fullName, lvl, cls, per * 100, pX, pY, inactive and "Inactive" or "", tStr, qStr or "")

				if alt then
					-- tStr has \n
					local s = tEnPlayer and (name .. tStr) or name
					local txt = RDXMAP.APIMap.GetText (map, s)
					RDXMAP.APIMap.MoveTextToIcon (txt, f1, 15, 1)
				end
			end
		end
	end

	map.Level = map.Level + 3

	if palName and map.GOpts["HUDATBGPal"] then
		if not combatName or combatDist > palDist then
			map.TrackPlayer = palName
			return palName, palX, palY
		end
	end

	if combatName then

		if not map.InCombat or combatDist > 35 then
			map.TrackPlayer = combatName
			return format ("Combat, %s %d%%", combatName, combatHealth * 100), combatX, combatY
		end
	end
end

--------
-- Draw player position history

function RDXMAP.APIMap.UpdatePlyrHistory(map)

	local myunit = RDXDAL.GetMyUnit();

	local Map = RDXMAP.Map			-- Use global map
	local hist = myunit.PlyrHist

	local tm = GetTime()

	local scale = map.BaseScale

	local x = hist.LastX - map.MoveLastX
	local y = hist.LastY - map.MoveLastY
	local moveDist = (x * x + y * y) ^ .5

	if moveDist > map.GOpts["MapTrailDist"] * scale then

		hist.LastX = map.MoveLastX
		hist.LastY = map.MoveLastY

		hist.Time = tm

		local a = hist.Next
		local o = a * 4 - 3

		hist[o] = GetTime()
		hist[o + 1] = myunit.PlyrX
		hist[o + 2] = myunit.PlyrY
		hist[o + 3] = map.PlyrDir
		

		if a >= hist.Cnt then
			a = 0
		end

		hist.Next = a + 1
	end

	local size = min (max (4 * map.ScaleDraw * map.BaseScale, 3), 25)

	local fadeTime = map.GOpts["MapTrailTime"]

	for n = 1, hist.Cnt * 4, 4 do

		local secs = hist[n]
		local tmdif = tm - secs

		if tmdif < fadeTime then

			local x = hist[n + 1]
			local y = hist[n + 2]
			local dir = hist[n + 3]

			local f = RDXMAP.APIMap.GetIconNI(map)

			if RDXMAP.APIMap.ClipFrameW (map, f, x, y, size, size, dir) then

				f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconCircleFade")
				local a = (fadeTime - tmdif) / fadeTime * .9
				f.texture:SetVertexColor (1, 0, 0, a)
			end

		end
	end
end




