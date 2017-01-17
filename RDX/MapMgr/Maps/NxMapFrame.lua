
function RDXMAP.APIMap.OnMouseDown (self, button)

	local map = self.NxMap

	local x, y = GetCursorPosition()
	x = x / self:GetEffectiveScale()
	y = y / self:GetEffectiveScale()

	map:CalcClick()

	ResetCursor()

--	VFL.vprint ("Map MouseDown %s %s %s %s %s", button, x, y, rgt, bot)

	if button == "LeftButton" then

--[[
		if map["DebugHotspots"] then

			map.HotspotDebugCurT = nil

			if map:IsDoubleClick() then
				map.DebugMapId = map.MapId
			else
				map.LClickTime = GetTime()
				map.Scrolling = true
				map.ScrollingX = x
				map.ScrollingY = y
				map.ScrollingFrm = map.ClickFrm
			end
			return
		end
--]]

		if IsControlKeyDown() and map:CallFunc ("MapButLCtrl") then	-- If func does nothing continue

		elseif IsAltKeyDown() and map:CallFunc ("MapButLAlt") then	-- If func does nothing continue

		elseif IsShiftKeyDown() then
			--map:Ping() -- sigg disable now

		else

			if map:IsDoubleClick() then

				RDXMAP.APIMap.CenterMap(map)
				map.DebugMapId = map.MapId

			else
				map.LClickTime = GetTime()
				map.Scrolling = true
				map.ScrollingX = x
				map.ScrollingY = y
				map.ScrollingFrm = map.ClickFrm
			end
		end

	elseif button == "MiddleButton" then

		if IsControlKeyDown() then
			map:CallFunc ("MapButMCtrl")
		elseif IsAltKeyDown() then
			map:CallFunc ("MapButMAlt")
		else
			map:CallFunc ("MapButM")
		end

	elseif button == "RightButton" then

		if IsControlKeyDown() and map:CallFunc ("MapButRCtrl") then

		elseif IsAltKeyDown() and map:CallFunc ("MapButRAlt") then

		else
			map:CallFunc ("MapButR")
		end

	elseif button == "Button4" then

		if IsControlKeyDown() then
			map:CallFunc ("MapBut4Ctrl")
		elseif IsAltKeyDown() then
			map:CallFunc ("MapBut4Alt")
		else
			map:CallFunc ("MapBut4")
		end
	end
end

function RDXMAP.APIMap.OnMouseUp (self, button)

--	VFL.vprint ("Map MouseUp "..tostring (button))

	local map = self.NxMap
	map.Scrolling = false
end

function RDXMAP.APIMap.OnMouseWheel (self, value)
	self.NxMap:MouseWheel (value)
end

--------
-- Handle events
-- self = map table

function RDXMAP.APIMap.OnEvent (self, event, ...)
	--VFL.print("event " .. event);
	--local this = self.Win.Frm
	local map = self.NxMap

--	VFL.vprintVar ("Map Event", self)
--	VFL.vprint ("Map Event %s", event)

	if event == "WORLD_MAP_UPDATE" then
		--VFL.print("CALL WORLD_MAP_UPDATE");
		--if this:IsVisible() then
			map:UpdateAll()
		--end
	--elseif event == "PLAYER_REGEN_DISABLED" then
	  --map.Arch:Hide()
	  --map.QuestWin:Hide()
	  --map.Arch:SetParent(nil)
	  --map.QuestWin:SetParent(nil)
	  --map.Arch:ClearAllPoints()
	  --map.QuestWin:ClearAllPoints()
	--elseif event == "PLAYER_REGEN_ENABLED" then
	  --map.Arch:SetParent(self.NxMap.TextScFrm:GetScrollChild())
	  --map.QuestWin:SetParent(self.NxMap.TextScFrm:GetScrollChild())
	  --map.Arch:Show()
	  --map.QuestWin:Hide()
	end
end


--------
-- Update event handler

function RDXMAP.APIMap.OnUpdate (self, elapsed)	--V4 self


--	if IsControlKeyDown() then		return	end

	local profileTime = GetTime()

	local map = self.NxMap
	local gopts = map.GOpts
	local myunit = RDXDAL.GetMyUnit();

	map.Tick = map.Tick + 1

	map.EffScale = self:GetEffectiveScale()
	map.Size1 = gopts["MapLineThick"] * .75 / map.EffScale

	map:UpdateOptions()

	---------------------------
	-- Scroll map with mouse
	---------------------------
	
	local winx, winy = VFLUI.IsMouseOver (self)

	if not self:IsVisible() or not map.MouseEnabled then
		winx = nil
		map.Scrolling = false
	end

	map.MouseIsOver = winx
	
	if winx and map.Scrolling then

		local cx, cy = GetCursorPosition()
		cx = cx / map.EffScale
		cy = cy / map.EffScale

		local x = cx - map.ScrollingX
		local y = cy - map.ScrollingY

--[[
		if map["DebugHotspots"] or (map.Debug and IsAltKeyDown()) then
			if map:OnButScrollDebug (0, 0, x, -y) then
				x = 0
				y = 0
			end
		end
--]]

		if x ~= 0 or y ~= 0 then		-- Moved? Cancel double click
			map.LClickTime = 0
		end

		map.ScrollingX = cx
		map.ScrollingY = cy

		local left = self:GetLeft()
		local top = self:GetTop()

		local mx = x / map.ScaleDraw
		local my = y / map.ScaleDraw
		map.MapPosXDraw = map.MapPosXDraw - mx
		map.MapPosYDraw = map.MapPosYDraw + my

		map.MapPosX = map.MapPosXDraw
		map.MapPosY = map.MapPosYDraw
		map.Scale = map.ScaleDraw
	end
	
	----------------------
	-- HOTSPOT
	----------------------

	local cursorLocStr = ""
	local cursorLocXY = ""
	
	if winx and not map.Scrolling then

		map.BackgndAlphaTarget = map.LOpts.NXBackgndAlphaFull

		winy = self:GetHeight() - winy

		if winy >= map.TitleH then

			local wx, wy = RDXMAP.APIMap.FramePosToWorldPos (map, winx, winy)

			if not VFL.poptree:MouseIsOver() then
	--				local tm = GetTime()
				RDXMAP.APIMap.CheckWorldHotspots (map, wx, wy)
	--				VFL.vprint ("CheckWorldHotspots Time %s", GetTime() - tm)
			end

			local x, y = RDXMAP.APIMap.GetZonePos (map.MapId, wx, wy)

			x = floor (x * 10) / 10	-- Chop fraction to tenths
			y = floor (y * 10) / 10
			local dist = ((wx - myunit.PlyrX) ^ 2 + (wy - myunit.PlyrY) ^ 2) ^ .5 * 4.575

			cursorLocXY = format ("|cff80b080%.1f %.1f %.0f yds", x, y, dist)
			cursorLocStr = cursorLocXY

			local name = UpdateMapHighlight (x / 100, y / 100)
			if name then
				cursorLocStr = format ("%s\n|cffafafaf%s", cursorLocStr, name)
			end
			
		end

	else
	
		--		if GameTooltip:IsOwned (map.Win.Frm) and map.TooltipType == 1 then
		--			VFL.vprint ("map TT hide")
		--			map.TooltipType = 0
		--			GameTooltip:Hide()
		--		end

		map.BackgndAlphaTarget = map.LOpts.NXBackgndAlphaFade

		local rid = RDXMAP.APIMap.GetRealMapId()
		if rid ~= 9000 and not WorldMapFrame:IsShown() then

			local mapId = RDXMAP.APIMap.GetCurrentMapId()
			--[[
			if RDXMAP.APIMap.IsInstanceMap (rid) then					
				if not RDXMAP.Map.InstanceInfo[rid] then		-- Don't convert WotLK/Cata instances
					local winfo = RDXMAP.APIMap.GetWorldZone(rid)
					if winfo then
						rid = winfo.EntryMId
					end
				end					
				if RDXMAP.APIMap.IsInstanceMap(rid) then
				  map.Scale = 120					  
				else
				  map.Scale = map.RealScale					  
				end
				local lvl = GetCurrentMapDungeonLevel()
				if lvl ~= map.InstLevelSet then
					mapId = 0	-- Force set
--						VFL.vprint ("map force set inst")
				end
			end]]

			if mapId ~= rid then
				if RDXMAP.APIMap.IsBattleGroundMap (rid) then						
					SetMapToCurrentZone()
				else
					RDXMAP.APIMap.SetCurrentMap (map, rid)
				end
			end
		end
	end
	
	----------------------
	-- Update mapid zone
	----------------------
	map:Update (elapsed)

	--------------
	-- Title text
	--------------
	
	local title = ""

	if gopts["MapShowTitleName"] then

		title = RDXMAP.APIMap.IdToName (myunit.mapId)

--		for n = 1, MAX_BATTLEFIELD_QUEUES do
		for n = 1, GetMaxBattlefieldID() do		-- Patch 4.3

			local status, _, instId = GetBattlefieldStatus (n)
			if status == "active" then
				title = title .. format (" #%s", instId)
				break
			end
		end
	end

	if gopts["MapShowTitleXY"] then
		if map.DebugFullCoords then
			title = title .. format (" %4.2f, %4.2f", myunit.PlyrRZX, myunit.PlyrRZY)
		else
			title = title .. format (" %4.1f, %4.1f", myunit.PlyrRZX, myunit.PlyrRZY)
		end
	end
	
	title = title .. format (" mapid %s", map.MapId)

	if myunit.PlyrSpeed > 0 and gopts["MapShowTitleSpeed"] then

		local speed = myunit.PlyrSpeed
		local sa
		local winfo = RDXMAP.APIMap.GetWorldZone(myunit.mapId)
		if winfo and winfo.ScaleAdjust and winfo.ScaleAdjust ~= 0 then
			sa = winfo.ScaleAdjust
		end 
		if sa then
			speed = speed * sa
		end

		speed = speed / 6.4 * 100 - 100
		if abs (speed) < .5 then	-- Removes small -0%
			speed = 0
		end
		title = title..format (" |cffa0a0a0Speed %+.0f%%", speed)
--		VFL.vprint ("Speed %f %f, Tm %.4f, %.3f %.3f", myunit.PlyrSpeed, speed, elapsed, myunit.PlyrX, myunit.PlyrY)		-- DEBUG!
	end

--	title = title..format (" Dir %.1f", map.myunit.PlyrDir)
	
	---------------
	-- Profiling
	---------------
	
	--if map.DebugTime then

	--	profileTime = GetTime() - profileTime
	--	local t = map.DebugProfileTime or .01
	--	t = t * .95 + profileTime * .05
	--	map.DebugProfileTime = t

	--	UpdateAddOnMemoryUsage()
	--	local mem = GetAddOnMemoryUsage ("Carbonite")

	--	local memdif = mem - (map.DebugMemUse or 0)
	--	map.DebugMemUse = mem

	--	title = title..format (" Time %.4f Mem %d %.4f", t, mem, memdif)
	--end

	--if GetCVar ("scriptProfile") == "1" then

	--	UpdateAddOnCPUUsage()

	--	title = title..format (" |cffffffffCPU %6.3f %6.3f", GetAddOnCPUUsage ("CARBONITE"), GetScriptCPUUsage())

	--	ResetCPUUsage()
	--end

	-- TEST X, Y

	---------------
	-- Tip
	---------------
	
	if VFLT.GetFrameCounter() % 3 == 0 then	-- Do less often, since tip makes garbage

		local tip = format (" %s", cursorLocStr)
		if map.Debug and winx then
			local x, y = RDXMAP.APIMap.FramePosToWorldPos (map, winx, winy)
			tip = tip .. format ("\n|cffc080a0%.2f WXY %6.2f %6.2f PXY %6.2f %6.2f", map.Scale, x, y, myunit.PlyrX, myunit.PlyrY)
			map.DebugWX = x
			map.DebugWY = y
		end

		local over = winx --and not VFLUI.IsMouseOver (map.ToolBar.Frm)
		map:SetLocationTip (over and not menuOpened and map.WorldHotspotTipStr and (map.WorldHotspotTipStr .. tip))
	end

end

