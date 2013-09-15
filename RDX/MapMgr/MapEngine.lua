


local function IsDoubleClick(self)

	if GetTime() - self.LClickTime < .5 then
--		Nx.prt ("Map DBL Click")
		self.LClickTime = 0
		return true
	end
end

local function CenterMap (self, mapId, scale)

	mapId = mapId or self.MapId

--[[ -- Map capture
	if 1 then
		self:CenterMap1To1 (floor (mapId / 1000) * 1000)
		return
	end
--]]

	if self:GetWorldZone (mapId).City then
		scale = 1
	end

	self.MapW = self:GetWidth()
	self.MapH = self:GetHeight() - self.TitleH

	local x, y = self:GetWorldPos (mapId, 50, 50)
	local size = min (self.MapW / 1002, self.MapH / 668)
	if self.MapW < GetScreenWidth() / 2 then
		size = size * (scale or 1.5)
	end

	local scale = size / self:GetWorldZoneScale (mapId) * 10.02

	self:Move (x, y, scale, 30)

--	Nx.prt ("Center #%d %f (%f %f) (%d %d)", mapId, self.Scale, self.MapPosX, self.MapPosY, self.MapW, self.MapH)
end

local function OnMouseWheel (self, value)

--	Nx.prt ("Map MouseWheel "..tostring (value))

	--local map = self
	--local this = map.Frm

	--[[ --disable
	if self.MMZoomType == 0 and Nx.Util_IsMouseOver (self.MMFrm) then

		self.MMZoomChanged = true

		local i = self.GOpts["MapMMDockZoom"]

		if value < 0 then
			i = max (i - 1, 0)
		else
			i = min (i + 1, 5)
		end

		self.GOpts["MapMMDockZoom"] = i

		return
	end
	]]

	local x, y = GetCursorPosition()
	x = x / self:GetEffectiveScale()
	y = y / self:GetEffectiveScale()

	local left = self:GetLeft()
	local rgt = self:GetRight()
	local top = self:GetTop()
	local bot = self:GetBottom()

	-- old value (or current)
	local ox = self.MapPosX + (x - left - self.MapW / 2) / self.Scale
	local oy = self.MapPosY + (top - y - self.MapH / 2) / self.Scale

	if value < 0 then
		value = value * .76923
	end
	self.Scale = math.max (self.Scale + value * self.Scale * .3, .015)

	
	self.StepTime = 10

	self.MapScale = self.Scale / 10.02

	-- new value
	local nx = self.MapPosX + (x - left - self.MapW / 2) / self.Scale
	local ny = self.MapPosY + (top - y - self.MapH / 2) / self.Scale

	self.MapPosX = self.MapPosX + ox - nx
	self.MapPosY = self.MapPosY + oy - ny
end

local function OnMouseDown (self, button)

	--local map = self.NxMap	--V4 this
	--local this = map.Frm

	local x, y = GetCursorPosition()
	x = x / self:GetEffectiveScale()
	y = y / self:GetEffectiveScale()

	self.ClickFrmX = x - self:GetLeft()
	self.ClickFrmY = self:GetTop() - y

	ResetCursor()

--	Nx.prt ("Map MouseDown %s %s %s %s %s", button, x, y, rgt, bot)

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

		if IsControlKeyDown() and self:CallFunc ("MapButLCtrl") then	-- If func does nothing continue

		elseif IsAltKeyDown() and self:CallFunc ("MapButLAlt") then	-- If func does nothing continue

		elseif IsShiftKeyDown() then
			self:Ping()

		else

			if IsDoubleClick(self) then

				self:CenterMap()
				self.DebugMapId = self.MapId

			else
				self.LClickTime = GetTime()
				self.Scrolling = true
				self.ScrollingX = x
				self.ScrollingY = y
				self.ScrollingFrm = self.ClickFrm
			end
		end

	elseif button == "MiddleButton" then

		if IsControlKeyDown() then
			self:CallFunc ("MapButMCtrl")
		elseif IsAltKeyDown() then
			self:CallFunc ("MapButMAlt")
		else
			self:CallFunc ("MapButM")
		end

	elseif button == "RightButton" then

		if IsControlKeyDown() and self:CallFunc ("MapButRCtrl") then

		elseif IsAltKeyDown() and self:CallFunc ("MapButRAlt") then

		else
			self:CallFunc ("MapButR")
		end

	elseif button == "Button4" then

		if IsControlKeyDown() then
			self:CallFunc ("MapBut4Ctrl")
		elseif IsAltKeyDown() then
			self:CallFunc ("MapBut4Alt")
		else
			self:CallFunc ("MapBut4")
		end
	end
end

local function OnMouseUp(self, button)
--	Nx.prt ("Map MouseUp "..tostring (button))
	self.Scrolling = false
end

RDX.Map = {};

function RDX.Map:new(index, parent)

	if not parent then parent = VFLParent; end

	--local Map = Nx.Map

	local m = VFLUI.AcquireFrame("Frame");
	m:SetParent(parent);
	m:SetFrameLevel(parent:GetFrameLevel());

	--local gopts = Nx.GetGlobalOpts()
	--m.GOpts = gopts
	local gopts = {};
	m.GOpts = gopts;
	--local opts = NxMapOpts.NXMaps[index]
	local opts = {};
	--m.LOpts = opts		-- Local for map (stuff without a map mode)
	m.LOpts = opts;
	--opts.NXPOIAtScale = opts.NXPOIAtScale or 1

	-- un tick par update
	m.Tick = 0												-- Debug tick
	m.Debug = nil											-- Debug on
	m.DebugTime = nil
	m.DebugFullCoords = nil								-- Debug high precision map coords
	m.DebugAdjustScale = .1

	m.MapIndex = index
	-- TODO m.MMOwn = gopts["MapMMOwn"] and index == 1

	m.ShowUnexplored = opts.NXShowUnexplored
	m.KillShow = opts.NXKillShow

	m.TitleH = 0
	m.PadX = 0
	m.Scale = .025
	m.ScaleDraw = .025									-- Actual draw scale
	m.MapScale = opts.NXMapScale or 1
	-- taille de la carte
	m.MapW = 150
	m.MapH = 140
	-- taille avec le titre et border
	-- en principe on  retire le titre ici.
	m.W = m.MapW + m.PadX * 2
	m.H = m.MapH + m.TitleH + 1
	m.LClickTime = 0
	m.MouseEnabled = true
	m.Scrolling = false
	m.StepTime = 0
	m.MapId = 0
	m.BaseScale = 1										-- Scale values, because instances are smaller
	m.PlyrX = 0
	m.PlyrY = 0
	m.PlyrRZX = 0
	m.PlyrRZY = 0
	m.PlyrDir = 0
	m.PlyrLastDir = 999
	m.PlyrSpeed = 0
	m.PlyrSpeedX = 0
	m.PlyrSpeedY = 0
	m.PlyrSpeedCalcTime = GetTime()
	m.MoveDir = 0
	m.MoveLastX = 0
	m.MoveLastY = 0
	m.ViewSavedData = {}
	m.MapPosX = 2200											-- World position of map
	m.MapPosY = -100
	m.MapPosXDraw = m.MapPosX								-- Actual draw position
	m.MapPosYDraw = m.MapPosY
	m.MapsDrawnOrder = {}									-- [index (1st is newest)] = map id
	m.MapsDrawnFade = {}										-- [map id] = fade
	m.MiniBlks = gopts["MapDetailSize"]
	m.BackgndAlphaFade = opts.NXBackgndAlphaFade
	m.BackgndAlphaFull = opts.NXBackgndAlphaFull
	m.BackgndAlpha = 0									-- Current value
	m.BackgndAlphaTarget = m.BackgndAlphaFade		-- Target value
	m.WorldAlpha = 0
	m.DotZoneScale = opts.NXDotZoneScale
	m.DotPalScale = opts.NXDotPalScale
	m.DotPartyScale = opts.NXDotPartyScale
	m.DotRaidScale = opts.NXDotRaidScale
	m.IconNavScale = opts.NXIconNavScale
	m.IconScale = opts.NXIconScale
	m.ArrowPulse = 1
	m.ArrowScroll = 0

	m.UpdateTargetDelay = 0
	m.UpdateTrackingDelay = 0

	m.Targets = {}
	m.TargetNextUniqueId = 1
	m.Tracking = {}
	m.TrackPlyrs = {}

	m.Data = {}
	m.IconFrms = {}
	m.IconFrms.Next = 1
	m.IconNIFrms = {}				-- Non interactive
	m.IconNIFrms.Next = 1
	m.IconStaticFrms = {}
	m.IconStaticFrms.Next = 1

	m.TextFStrs = {}
	m.TextFStrs.Next = 1

	m.MMGathererUpdateDelay = 1
	
	m:SetScript ("OnMouseDown", OnMouseDown)
	m:SetScript ("OnMouseUp", OnMouseUp)
	m:SetScript ("OnMouseWheel", OnMouseWheel)
	m:EnableMouse (true)
	m:EnableMouseWheel (true)

	--m:SetScript ("OnUpdate", self.OnUpdate)

	m:SetMovable (true)
	m:SetResizable (true)

	-- handle by desktop
--	m:SetFrameStrata ("LOW")
	m:SetWidth (m.MapW)
	m:SetHeight (m.MapH)
	m:SetMinResize (50, 50)

	local t = VFLUI.CreateTexture(m);
	t:SetTexture (0, 0, 0, .2)
	t:SetAllPoints(m)
	t:Show();
	m.texture = t
	
	
	m:Show()
	
	
	

	-- Create Window

	--Nx.Window:SetCreateFade (1, 0)
	--self.CFadeIn = fadein
	--self.CFadeOut = fadeout
	--
	--[[
	local wname = "NxMap" .. m.MapIndex;

	local i = gopts["MapShowTitle2"] and 2 or 1

	local win = Nx.Window:Create (wname, nil, nil, nil, i)
	m.Win = win

	win:SetBGAlpha (0, 1)

	win:CreateButtons (true)
	win:InitLayoutData (nil, -.0001, -.4, -.19, -.3, 1)

	for n = 9001, 9004 do
		win:InitLayoutData (tostring (n), -.0001, -.4, -.19, -.3, 1)
	end

	for n = 9008, 9011 do
		win:InitLayoutData (tostring (n), -.0001, -.4, -.19, -.3, 1)
	end

	win:SetUser (m, self.OnWin)
	win.UserUpdateFade = m.WinUpdateFade

	win.Frm:SetToplevel (true)
	win.Frm.NxMap = m

	m.StartupShown = win:IsShown()
	win.Frm:Show()
	--]]

	-- Create main frame

	--local f = CreateFrame ("Frame", nil, UIParent)
	--m.Frm = f
	--f.NxMap = m

	--win:Attach (f, 0, 1, 0, 1)

--	win:RegisterEvent ("PLAYER_LOGIN", self.OnEvent)
--	win:RegisterEvent ("PLAYER_ENTERING_WORLD", self.OnEvent)
--	win:RegisterEvent ("WORLD_MAP_UPDATE", self.OnEvent)

	

	-- Create text frame

	local tsf = VFLUI.AcquireFrame("ScrollFrame");
	tsf:SetParent(m);
	tsf:SetFrameLevel(m:GetFrameLevel());
	tsf:SetAllPoints(m)
	tsf:Show();
	m.TextScFrm = tsf

	local tf = VFLUI.AcquireFrame("Frame");
	tf:SetParent(tsf);
	tf:SetFrameLevel(tsf:GetFrameLevel());
	tf:SetPoint ("TOPLEFT", 0, 0)
	tf:SetWidth (100)
	tf:SetHeight (100)
	tf:Show();
	m.TextFrm = tf

--	tf:SetAllPoints (f)
	tsf:SetScrollChild (tf)
	
	


	-- Tip

	-- TODO m:CreateLocationTip()

	------------------------
	-- Create player icon --
	------------------------
	
	local plf = VFLUI.AcquireFrame("Frame");
	plf:SetParent(m);
	plf:SetFrameLevel(m:GetFrameLevel());
	plf:SetWidth (3)
	plf:SetHeight (3)
	plf:Show()
	m.PlyrFrm = plf
	plf.NxMap = m

	t = VFLUI.CreateTexture(plf);
	t:SetTexture ("Interface\\Minimap\\MinimapArrow")
	t:SetAllPoints (plf)
	plf:SetPoint ("CENTER", 0, 0); --(m.TitleH - 1) * -.5)
	t:Show();
	plf.texture = t

	---------------------
	-- Init map frames --
	---------------------
	
	m.TileFrms = {}

	for i = 1, 12 do

		local tf = VFLUI.AcquireFrame("Frame");
		tf:SetParent(m);
		tf:SetFrameLevel(m:GetFrameLevel());
		tf:Show();
		m.TileFrms[i] = tf

		local t = VFLUI.CreateTexture(tf);
		t:SetAllPoints (tf)
		t:Show();
		tf.texture = t
	end

	-- Init continent frames

	local ContBlks = {
		{ 0,1,1,0, 0,1,1,0, 0,1,1,0 },
		{ 0,1,1,0, 0,1,1,0, 0,1,1,0 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
		{ 1,1,1,0, 1,1,1,0, 1,1,1,0 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
	}

	m.ContFrms = {}

	for n = 1, 6 do

		m.ContFrms[n] = {}

		local mapFileName = RDXMAP.GetContinentById(n).FileName

		local texi = 1

--		Nx.prtD ("Map Update ".. mapFileName)

		for i = 1, 12 do

			if ContBlks[n][i] ~= 0 then

				local cf = VFLUI.AcquireFrame("Frame");
				cf:SetParent(m);
				cf:SetFrameLevel(m:GetFrameLevel());
				cf:Show();

				local t = VFLUI.CreateTexture(cf);
				t:SetAllPoints (cf)
				t:Show();
				cf.texture = t
				
				m.ContFrms[n][i] = cf

				if n == 0 then
					t:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\Cont\\".."Kal"..texi)
					texi = texi + 1
				else
					t:SetTexture ("Interface\\WorldMap\\"..mapFileName.."\\"..mapFileName..i)
					VFL.print("Interface\\WorldMap\\"..mapFileName.."\\"..mapFileName..i);
				end
			end
		end
	end

--[[
	local cf = CreateFrame ("Frame", nil, f)
	self.ContFillFrm = cf

	local t = cf:CreateTexture()
	t:SetAllPoints (cf)
	cf.texture = t
--	t:SetTexture (.5, .5, .45, .99)
	t:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\HBlend")
	t:SetVertexColor (1, 1, 1, .7)
--]]

	-- Create mini frames
--[[
	m.MiniFrms = {}

	for n = 1, m.MiniBlks ^ 2 do

		local tf = VFLUI.AcquireFrame("Frame");
		tf:SetParent(m);
		tf:SetFrameLevel(m:GetFrameLevel());
		tf:Show();
		m.MiniFrms[n] = tf

		local t = VFLUI.CreateTexture(tf);
		tf.texture = t
		t:Show();
		t:SetAllPoints (tf)
	end
]]
	-- TODO self:InitHotspots()
	
	
	
	
	

	-- Test

--[[
	m:InitIconType ("Test", nil, "Interface\\TargetingFrame\\TargetDead", 64, 64)

	for i = 1, 100, .2 do
		m:AddIconData ("Test", i, 30, 0)
	end
--]]

--[[
	m:InitIconType ("Test2", nil, 64, 64)

	for i = 1, 100, .2 do
		m:AddIconData ("Test2", i, 10, "00ff00")
	end
--]]

--[[
	m:InitIconType ("TestZR", "ZR")

	for i = 1, 10, 2 do
		m:AddIconRect ("TestZR", i, 5, i+1, 6, "00ff0080")
	end
--]]

	--

	self.RMapId = 9000		-- Safe default

	-- TODO m:SwitchOptions (-1, true)

	--m:UpdateAll()
	m.NeedWorldUpdate = true

	-- TODO m.Guide = Map.Guide:Create (m)

	--

	--self.MMFrm = _G["Minimap"]
	--assert (self.MMFrm)

	--m:MinimapOwnInit()

	-- Force player to be shown after init done and not in BG

	local function func (self)
		if not Nx.InBG then
			self:GotoPlayer()
		end
	end

	--Nx.Timer:Start ("MapIShow" .. m.MapIndex, 1, m, func)

	--

	return m
end



function RDX.Map:UpdateAll()

	self.NeedWorldUpdate = true

--	Nx.prt ("%d Map UpdateAll %d (%d)", self.Tick, self:GetCurrentMapId(), self.MapId)
end

function RDX.Map:OnUpdate(elapsed)	--V4 this


--	if IsControlKeyDown() then		return	end


	local Nx = Nx

	Nx.Timer:ProfilerStart ("Map OnUpdate")

	local profileTime = GetTime()

	local map = self
	local gopts = self.GOpts
	local Quest = Nx.Quest

	self.Tick = self.Tick + 1

	self.EffScale = self:GetEffectiveScale()
	selfself.Size1 = gopts["MapLineThick"] * .75 / self.EffScale

	-- TODO self:UpdateOptions (map.MapIndex)

	local winx, winy = Nx.Util_IsMouseOver (self)

	if not self:IsVisible() or not self.MouseEnabled then
		winx = nil
		self.Scrolling = false
	end

	if self.MMZoomType == 0 and Nx.Util_IsMouseOver (self.MMFrm) then
		winx = nil
	end

	self.MouseIsOver = winx

	-- Scroll map with mouse

	if self.Scrolling then

		local cx, cy = GetCursorPosition()
		cx = cx / self.EffScale
		cy = cy / self.EffScale

		local x = cx - self.ScrollingX
		local y = cy - self.ScrollingY

--[[
		if self["DebugHotspots"] or (self.Debug and IsAltKeyDown()) then
			if self:OnButScrollDebug (0, 0, x, -y) then
				x = 0
				y = 0
			end
		end
--]]

		if x ~= 0 or y ~= 0 then		-- Moved? Cancel double click
			selfself.LClickTime = 0
		end

		self.ScrollingX = cx
		self.ScrollingY = cy

		local left = self:GetLeft()
		local top = self:GetTop()

		local mx = x / self.ScaleDraw
		local my = y / self.ScaleDraw
		self.MapPosXDraw = self.MapPosXDraw - mx
		self.MapPosYDraw = self.MapPosYDraw + my

		self.MapPosX = self.MapPosXDraw
		self.MapPosY = self.MapPosYDraw
		self.Scale = self.ScaleDraw
	end

	self:Update(elapsed)

	-- Title text

	local title = ""

	--[[ if gopts["MapShowTitleName"] then

		title = map:IdToName (map.RMapId)

--		for n = 1, MAX_BATTLEFIELD_QUEUES do
		for n = 1, GetMaxBattlefieldID() do		-- Patch 4.3

			local status, _, instId = GetBattlefieldStatus (n)
			if status == "active" then
				title = title .. format (" #%s", instId)
				break
			end
		end
	end
]]
	if gopts["MapShowTitleXY"] then
		if self.DebugFullCoords then
			title = title .. format (" %4.2f, %4.2f", self.PlyrRZX, self.PlyrRZY)
		else
			title = title .. format (" %4.1f, %4.1f", self.PlyrRZX, self.PlyrRZY)
		end
	end

	if self.PlyrSpeed > 0 and gopts["MapShowTitleSpeed"] then

		local speed = self.PlyrSpeed

		local sa = Zones[self.MapId].ScaleAdjust
		if sa then
			speed = speed * sa
		end

		speed = speed / 6.4 * 100 - 100
		if abs (speed) < .5 then	-- Removes small -0%
			speed = 0
		end
		title = title..format (" |cffa0a0a0Speed %+.0f%%", speed)
--		Nx.prt ("Speed %f %f, Tm %.4f, %.3f %.3f", self.PlyrSpeed, speed, elapsed, self.PlyrX, self.PlyrY)		-- DEBUG!
	end

--	title = title..format (" Dir %.1f", self.PlyrDir)

	local cursorLocStr = ""
	local cursorLocXY = ""

	local menuOpened = Nx.Menu:IsAnyOpened()

	if winx then

		self.BackgndAlphaTarget = self.BackgndAlphaFull

		winy = this:GetHeight() - winy

		if winy >= self.TitleH then

			local wx, wy = self:FramePosToWorldPos (winx, winy)

			if not menuOpened then
--				local tm = GetTime()
				self:CheckWorldHotspots (wx, wy)
--				Nx.prt ("CheckWorldHotspots Time %s", GetTime() - tm)
			end

			local x, y = self:GetZonePos (self.MapId, wx, wy)

			x = floor (x * 10) / 10	-- Chop fraction to tenths
			y = floor (y * 10) / 10
			local dist = ((wx - self.PlyrX) ^ 2 + (wy - self.PlyrY) ^ 2) ^ .5 * 4.575

			cursorLocXY = format ("|cff80b080%.1f %.1f %.0f yds", x, y, dist)
			cursorLocStr = cursorLocXY

			local name = UpdateMapHighlight (x / 100, y / 100)
			if name then
				cursorLocStr = format ("%s\n|cffafafaf%s", cursorLocStr, name)
			end
		end

	else

--		if GameTooltip:IsOwned (self.Win.Frm) and self.TooltipType == 1 then
--			Nx.prt ("self TT hide")
--			self.TooltipType = 0
--			GameTooltip:Hide()
--		end

		if not self.Scrolling and not menuOpened then

			self.BackgndAlphaTarget = self.BackgndAlphaFade

			local rid = self:GetRealMapId()
			if rid ~= 9000 and not WorldMapFrame:IsShown() then

				local mapId = self:GetCurrentMapId()

				if self:IsInstanceMap (rid) then

					if not Nx.Map.InstanceInfo[rid] then		-- Don't convert WotLK/Cata instances
						rid = Nx.Map.MapWorldInfo[rid].EntryMId
					end

					local lvl = GetCurrentMapDungeonLevel()
					if lvl ~= self.InstLevelSet then
						mapId = 0	-- Force set
--						Nx.prt ("map force set inst")
					end
				end

				if mapId ~= rid then

					if map:IsBattleGroundMap (rid) then
						SetMapToCurrentZone()
					else
						map:SetCurrentMap (rid)
					end
				end
			end
		end
	end

	-- Check quest window
	--[[
	if map.Guide.Win.Frm:IsVisible() or Quest.List.Win and Quest.List.Win.Frm:IsVisible() then
		map.BackgndAlphaTarget = map.BackgndAlphaFull
	end]]

	-- Profiling

	if map.DebugTime then

		profileTime = GetTime() - profileTime
		local t = self.DebugProfileTime or .01
		t = t * .95 + profileTime * .05
		self.DebugProfileTime = t

		UpdateAddOnMemoryUsage()
		local mem = GetAddOnMemoryUsage ("Carbonite")

		local memdif = mem - (self.DebugMemUse or 0)
		self.DebugMemUse = mem

		title = title..format (" Time %.4f Mem %d %.4f", t, mem, memdif)
	end

	--if GetCVar ("scriptProfile") == "1" then

		--UpdateAddOnCPUUsage()

		--title = title..format (" |cffffffffCPU %6.3f %6.3f", GetAddOnCPUUsage ("CARBONITE"), GetScriptCPUUsage())

		--ResetCPUUsage()
	--end

	--

	if Nx.Tick % 3 == 0 then	-- Do less often, since tip makes garbage

		local tip = format (" %s", cursorLocStr)
		if self.Debug and winx then
			local x, y = self:FramePosToWorldPos (winx, winy)
			tip = tip .. format ("\n|cffc080a0%.2f WXY %6.2f %6.2f PXY %6.2f %6.2f", self.Scale, x, y, self.PlyrX, self.PlyrY)
			self.DebugWX = x
			self.DebugWY = y
		end

		local over = winx and not Nx.Util_IsMouseOver (self.ToolBar.Frm)
		self:SetLocationTip (over and not menuOpened and self.WorldHotspotTipStr and (self.WorldHotspotTipStr .. tip))
	end

	if self.Win:IsSizeMax() then
		local s = Nx.Quest:GetZoneAchievement (true)
		if s then
			title = title .. "  " .. s
		end
	end

	self.Win:SetTitle (title, 1)

	if self.GOpts["MapShowTitle2"] then

		local s = GetSubZoneText()
		local pvpType = GetZonePVPInfo()
		if pvpType then
			s = s .. " (" .. pvpType .. ")"
		end
		self.Win:SetTitle (format ("%s %s", s, cursorLocXY), 2)
	end

	Nx.Timer:ProfilerEnd ("self OnUpdate")
end

function RDX.Map:Update(elapsed)

	local Nx = Nx
	local Map = Nx.Map

	self:MouseEnable (self.Win:IsSizeMax())

	if self.NeedWorldUpdate then
		self:UpdateWorld()
	end

	self.MapW = self:GetWidth()
	self.MapH = self:GetHeight()
	self.Level = self:GetFrameLevel() + 1

	local mapId = self:GetCurrentMapId()
	self.Cont, self.Zone = self:IdToContZone (mapId)

	Nx.InSanctuary = GetZonePVPInfo() == "sanctuary"

	local doSetCurZone
	local mapChange

	if self.MapId ~= mapId then

		if self.Debug then
			Nx.prt ("%d Map change %d to %d", self.Tick, self.MapId, mapId)
		end

		self.CurMapBG = self:IsBattleGroundMap (mapId)

		if not self:IsBattleGroundMap (self.MapId) then
--			self.MapIdOld = self.MapId
			self:AddOldMap (mapId)
		end

		self.MapId = mapId
		mapChange = true

		--Nx.Com.PlyrChange = GetTime()
	end

	local rid = self:GetRealMapId()
	local inBG = self:IsBattleGroundMap (rid)

	if Nx.InBG and Nx.InBG ~= rid then	-- Left or changed BG?

--		Nx.prt ("Left BG %s", Nx.InBG)

		local cb = Nx.Combat

		if Nx.InArena then
			local s = Nx.Map:GetShortName (Nx.InArena)
			Nx.UEvents:AddInfo (format ("Left %s %d %d %dD %dH", s, cb.KBs, cb.Deaths, cb.DamDone, cb.HealDone))

		else
			local total = cb.KBs + cb.Deaths + cb.HKs + cb.Honor
			if total > 0 then
				local sname = Nx.Map:GetShortName (Nx.InBG)
				Nx.UEvents:AddInfo (format ("Left %s %d %d %d %d", sname, cb.KBs, cb.Deaths, cb.HKs, cb.Honor))

				local tm = GetTime() - cb.BGEnterTime
				local _, honor = GetCurrencyInfo (392)		--V4
				local hGain = honor - cb.BGEnterHonor
				Nx.UEvents:AddInfo (format (" %s +%d honor, +%d hour", Nx.Util_GetTimeElapsedMinSecStr (tm), hGain, hGain / tm * 3600))

				local xpGain = UnitXP ("player") - cb.BGEnterXP
				if xpGain > 0 then
					Nx.UEvents:AddInfo (format (" +%d xp, +%d hour", xpGain, xpGain / tm * 3600))
				end
			end
		end

		cb.KBs = 0
		cb.Deaths = 0
		cb.HKs = 0
		cb.Honor = 0
		Nx.InBG = nil

		if Nx.InArena then
			self.LOpts.NXMMFull = false
		end
		Nx.InArena = nil
	end

	if inBG and Nx.InBG ~= rid then
		Nx.InBG = rid

		local cb = Nx.Combat
		cb.BGEnterTime = GetTime()
		local _, honor = GetCurrencyInfo (392)		--V4
		cb.BGEnterHonor = honor
		cb.BGEnterXP = UnitXP ("player")

		if self.MapWorldInfo[rid].Arena then
			Nx.InArena = rid
			self.LOpts.NXMMFull = true
		end

--		Nx.prt ("Entering BG %s", rid)
		doSetCurZone = true
	end

	-- Taxi update

	local ontaxi = UnitOnTaxi ("player")

	if ontaxi then
		if not Map.TaxiOn then	-- New taxi ride?
			Map.TaxiStartTime = GetTime()
			Map.TaxiOn = true
			if NxData.DebugMap then
				Nx.prt ("Taxi start")
			end
		end

	elseif Map.TaxiOn then	-- Done with taxi
		Map.TaxiOn = false
		Map.TaxiX = nil		-- Clear so if we pop on a taxi by a unhooked method we don't track old

		local tm = GetTime() - Map.TaxiStartTime

		Nx.Travel:TaxiSaveTime (tm)

		if NxData.DebugMap then
			Nx.prt ("Taxi time %.1f seconds", tm)
		end
	end

	-- Real map switch

	if self.RMapId ~= rid then
		if rid ~= 9000 then

--			Nx.prt ("Map zone changed %d, %d", rid, mapId)

			if self.RMapId == 9000 then	-- Loading?
				self.CurOpts = nil
				self:SwitchOptions (rid, true)
			end

			self.RMapId = rid

			self:SwitchOptions (rid)
			self:SwitchRealMap (rid)
		end
	end

	local plZX, plZY = GetPlayerMapPosition ("player")

	self.InstanceId = false

	if self:IsInstanceMap (rid) then

		self.InstanceId = rid

		plZX = plZX * 100
		plZY = plZY * 100

--		self.PlyrInstX = plZX
--		self.PlyrInstY = plZY

--		Nx.prt ("XY %s %s", plZX, plZY)

		self.PlyrRZX = plZX
		self.PlyrRZY = plZY

		local x, y = self:GetWorldPos (rid, 0, 0)

		local lvl = max (GetCurrentMapDungeonLevel(), 1)		-- 0 if no level

		if not self.InstMapId then		-- Not showing instance?
			plZX = 0
			plZY = 0

		elseif plZX == 0 and plZY == 0 then

			self.InstLevelSet = -1
		end

		self.PlyrX = x + plZX * 1002 / 25600
		self.PlyrY = y + plZY * 668 / 25600 + (lvl - 1) * 668 / 256

--		self.InstanceLevel = GetCurrentMapDungeonLevel()

		self.PlyrSpeed = 0

	elseif plZX > 0 or plZY > 0 then	-- Update world position of player if we can get it

		plZX = plZX * 100
		plZY = plZY * 100

		local x, y = self:GetWorldPos (mapId, plZX, plZY)

		if elapsed > 0 then

			if x == self.PlyrX and y == self.PlyrY then	-- Not moving?
				self.PlyrSpeedCalcTime = GetTime()
				self.PlyrSpeed = 0
				self.PlyrSpeedX = x
				self.PlyrSpeedY = y

			else
				local tmDif = GetTime() - self.PlyrSpeedCalcTime
				if tmDif > .5 then
					self.PlyrSpeedCalcTime = GetTime()
					self.PlyrSpeed = ((x - self.PlyrSpeedX) ^ 2 + (y - self.PlyrSpeedY) ^ 2) ^ .5 * 4.575 / tmDif
					self.PlyrSpeedX = x
					self.PlyrSpeedY = y
				end
			end
		end

--		if elapsed > 0 then
--			self.PlyrSpeed = ((x - self.PlyrX) ^ 2 + (y - self.PlyrY) ^ 2) ^ .5 * 4.575 / elapsed
--		end

		self.PlyrX = x
		self.PlyrY = y

		if mapId ~= rid then			-- Not in real zone?
			plZX, plZY = self:GetZonePos (rid, x, y)
		end

		self.PlyrRZX = plZX
		self.PlyrRZY = plZY

		if mapChange then
			self.MoveLastX = x
			self.MoveLastY = y
		end
	end

--	Nx.prt ("Dir %s", GetPlayerFacing())
	self.PlyrDir = 360 - GetPlayerFacing() / 2 / math.pi * 360

	local plX = self.PlyrX
	local plY = self.PlyrY

	local x = plX - self.MoveLastX
	local y = plY - self.MoveLastY
	local ang = self.PlyrDir - self.PlyrLastDir

	local moveDist = (x * x + y * y) ^ .5

--	if moveDist > 0 then Nx.prt ("MoveDist %f %f", moveDist, self.BaseScale) end

	if moveDist >= .01 * self.BaseScale or abs (ang) > .01 then

		Nx.Com.PlyrChange = GetTime()

		if self.MoveLastX ~= -1 then
			self.MoveDir = math.deg (math.atan2 (x, -y / 1.5))
		end

		self.MoveLastX = plX
		self.MoveLastY = plY

--		if not rotOk then
--			self.PlyrDir = self.MoveDir
--		end

		self.PlyrLastDir = self.PlyrDir

		if not self.Scrolling and not self.MouseIsOver and not WorldMapFrame:IsVisible() then

			if self.CurOpts.NXPlyrFollow then

				local scOn = self.LOpts.NXAutoScaleOn		--self.GOpts["MapFollowChangeScale"]

				if plZX ~= 0 or plZY ~= 0 then

					if #self.Tracking == 0 or not scOn then
						self:Move (plX, plY, nil, 60)
					end
				end

				if scOn then

					local midX
					local midY
					local dtx
					local dty

					local cX, cY = GetCorpseMapPosition()

					if cX ~= 0 or cY ~= 0 then

						midX, midY = self:GetWorldPos (mapId, cX * 100, cY * 100)
						dtx = 1
						dty = 1

					elseif #self.Tracking > 0 then

						local tr = self.Tracking[1]
						midX = tr.TargetMX
						midY = tr.TargetMY
						dtx = abs (tr.TargetX1 - tr.TargetX2)
						dty = abs (tr.TargetY1 - tr.TargetY2)

					elseif Map.TaxiX then

						midX, midY = self.TaxiX, self.TaxiY
						dtx = 1
						dty = 1
					end

					if midX then

						local mX = (midX + self.PlyrX) * .5
						local mY = (midY + self.PlyrY) * .5

						local dx = abs (midX - self.PlyrX)
						local dy = abs (midY - self.PlyrY)
--						Nx.prt ("Map scale target %f %f", dx, dy)
						dx = self.MapW / dx
						dy = self.MapH / dy
						local scale = min (dx, dy) * .5
--						Nx.prt ("Map scales %f %f", dx, dy)

--						Nx.prt ("Map scale target %f %f", dtx, dty)
						dx = self.MapW / dtx
						dy = self.MapH / dty
						scale = min (min (dx, dy), scale)	-- Smaller of target rect of player to target center

						local scmax = self.InstanceId and 800 or self.LOpts.NXAutoScaleMax

						scale = max (min (scale, scmax), self.LOpts.NXAutoScaleMin)
						self:Move (mX, mY, scale, 60)
					end
				end

				if rid ~= mapId then
					doSetCurZone = true
--					Nx.prt ("Map SetMapToCurrentZone")
				end
			end
		end
	end

	-- Adjust draw scale and position

	local scaleDiff = abs (self.ScaleDraw - self.Scale)
	local xDiff = self.MapPosXDraw - self.MapPosX
	local yDiff = self.MapPosYDraw - self.MapPosY

	if self.StepTime ~= 0 and (scaleDiff > 0 or xDiff ~= 0 or yDiff ~= 0) then
--	if (xDiff ~= 0 or yDiff ~= 0) and (self.Tick % 1 == 0) then

--		Nx.prt ("Tick %f", self.Tick)

		if self.StepTime > 0 then

--			Nx.prt ("Steptime Go #%d %f", self.Tick, self.StepTime)

			self.StepTime = -self.StepTime

			self.ScaleDrawW = 1 / self.ScaleDraw
			self.ScaleW = 1 / self.Scale
		end

		local st = -self.StepTime

		self.MapPosXDraw = Nx.Util_StepValue (self.MapPosXDraw, self.MapPosX, abs (xDiff) / st)
		self.MapPosYDraw = Nx.Util_StepValue (self.MapPosYDraw, self.MapPosY, abs (yDiff) / st)
		self.ScaleDrawW = Nx.Util_StepValue (self.ScaleDrawW, self.ScaleW, abs (self.ScaleDrawW - self.ScaleW) / st)
		self.ScaleDraw = 1 / self.ScaleDrawW

--		Nx.prt ("Map scrl #%d %f %f", self.StepTime, self.MapPosXDraw, self.MapPosX)
--		Nx.prt ("Map scrl %f %f", self.OCur, self.OEnd)
--		Nx.prt ("Map scrl %f %f", self.ScaleDraw, self.Scale)

		self.StepTime = self.StepTime + 1
	end

	local _, zx, zy, zw = self:GetWorldZoneInfo (self.Cont, self.Zone)
	if zx then
		self.MapScale = self.Scale / 10.02
	end

	--

	local plSize = self.GOpts["MapPlyrArrowSize"]
	if IsShiftKeyDown() then
		plSize = 5
	end

	self.PlyrFrm:Show()
	self:ClipFrameW (self.PlyrFrm, self.PlyrX, self.PlyrY, plSize, plSize, self.PlyrDir)

	self.InCombat = UnitAffectingCombat ("player")

	local g = 1
	local b = 1
	local al = 1
	if self.InCombat then
		g = 0
		b = 0
		al = abs (GetTime() % 1 - .5) / .5 * .5 + .4
	end

	self.PlyrFrm.texture:SetVertexColor (1, g, b, al)
--	local str = format ("%s %d %d", UnitName ("player"), UnitHealth ("player"), UnitMana ("player"))
--	self.PlyrFrm.NxTip = str

	--

	self.BackgndAlpha = Nx.Util_StepValue (self.BackgndAlpha, self.BackgndAlphaTarget, .05)
	self.Frm.texture:SetVertexColor (1, 1, 1, self.BackgndAlpha)

	self.WorldAlpha = (self.BackgndAlpha - self.BackgndAlphaFade) / (self.BackgndAlphaFull - self.BackgndAlphaFade) * self.BackgndAlphaFull

	self:ResetIcons()

	self:MoveContinents()
--	self:MoveWorldHotspots()

--	if not (IsAltKeyDown() and IsControlKeyDown()) then
--	end

	self:UpdateZones()
	self:UpdateInstanceMap()

	self:MinimapUpdate()
	self:UpdateWorldMap()

	self:DrawContinentsPOIs()

	if self.GOpts["MapShowTrail"] then
		self:UpdatePlyrHistory()
	end

	if self.GOpts["MapShowPunks"] then
		Nx.Social:UpdateIcons (self)
	end

--[[
	if self["DebugHotspots"] then
		self:UpdateHotspotsDebug()
	end
--]]

	-- Battlefield Vehicles

	local vtex = _G["VEHICLE_TEXTURES"]

	for n = 1, GetNumBattlefieldVehicles() do

		local x, y, unitName, possessed, typ, orientation, player = GetBattlefieldVehicleInfo (n)
		if x and x > 0 and not player then

--			Nx.prtCtrl ("#%s %s %.2f %.2f %.3f %s %s %s", n, unitName or "nil", x or -1, y or -1, orientation or -1, typ or "no type", possessed and "poss" or "-poss", player and "plyr" or "-plyr")

			if vtex[typ] then
				local f2 = self:GetIconNI (1)

				local sc = self.ScaleDraw * .8		-- Airships
				if typ == "Drive" or typ == "Fly" then
					sc = 1
				end

				if self:ClipFrameZ (f2, x * 100, y * 100, vtex[typ]["width"] * sc, vtex[typ]["height"] * sc, orientation / PI * -180) then
					f2.texture:SetTexture (WorldMap_GetVehicleTexture (typ, possessed))
				end

--				Nx.prtCtrl ("%s %s %s %s", unitName, x, y, orientation)
			end
		end
	end

	-- POI's (Points of interest)

	local oldLev = self.Level

	if IsShiftKeyDown() then

		oldLev = oldLev - 4
		self.Level = self.Level + 16
	end

	local name, description, txIndex, pX, pY
	local txX1, txX2, txY1, txY2
	local poiNum = GetNumMapLandmarks()

--	Nx.prt ("poiNum %d", poiNum)

	for i = 1, poiNum do
		name, desc, txIndex, pX, pY = GetMapLandmarkInfo (i)

		if txIndex ~= 0 then		-- WotLK has 0 index POIs for named locations

			local tip = name
			if desc then
				tip = format ("%s\n%s", name, desc)
			end

			pX = pX * 100
			pY = pY * 100

--			Nx.prtCtrl ("poi %d %s %s %d", i, name, desc, txIndex)

			local f = self:GetIcon (3)

			if self.CurMapBG then

				f.NXType = 2000

				local iconType = Nx.MapPOITypes[txIndex]

				local sideStr = ""
				if iconType == 1 then	-- Ally?
					sideStr = " (Ally)"
				elseif iconType == 2 then	-- Horde?
					sideStr = " (Horde)"
				end

				if desc == NXlINCONFLICT then

					local state = self.BGTimers[name]
					if state ~= txIndex then
						self.BGTimers[name] = txIndex
						self.BGTimers[name.."#"] = GetTime()
					end

					local dur = GetTime() - self.BGTimers[name.."#"]
					local doneDur = (rid == 9001 or rid == 9009 or rid == 9010) and 64 or 241
					local leftDur = max (doneDur - dur, 0)
					local tmStr

					if leftDur < 60 then
						tmStr = format (":%02d", leftDur)
					else
						tmStr = format ("%d:%02d", floor (leftDur / 60), floor (leftDur % 60))
					end

					f.NXData = format ("1~%f~%f~%s%s %s", pX, pY, name, sideStr, tmStr)

					tip = format ("%s\n%s", tip, tmStr)

					-- Horizontal bar

					local sz = 30 / self.ScaleDraw

					local f2 = self:GetIcon (0)
					self:ClipFrameZTLO (f2, pX, pY, sz, sz, -15, -15)
					f2.texture:SetTexture (0, 0, 0, .35)

					f2.NXType = 2000
					f2.NxTip = tip
					f2.NXData = f.NXData

					local f2 = self:GetIconNI (1)

					if leftDur < 10 then

						if self.BGGrowBars then

							local al = abs (GetTime() % .4 - .2) / .2 * .2 + .8

							local f3 = self:GetIconNI (2)
							self:ClipFrameZTLO (f3, pX, pY, sz * (10 - leftDur) * .1, 3 / self.ScaleDraw, -15, -15)
							f3.texture:SetTexture (.5, 1, .5, al)

							local f3 = self:GetIconNI (2)
							self:ClipFrameZTLO (f3, pX, pY, sz * (10 - leftDur) * .1, 3 / self.ScaleDraw, -15, 12)
							f3.texture:SetTexture (.5, 1, .5, al)
						end

--						f2.texture:SetTexture (.5, 1, .5, abs (GetTime() % .6 - .3) / .3 * .7 + .3)
					end

					local red = .3
					local blue = 1
					if iconType == 2 then	-- Horde?
						red = 1
						blue = .3
					end

					f2.texture:SetTexture (red, .3, blue, abs (GetTime() % 2 - 1) * .5 + .5)

					local per = leftDur / doneDur
					local vper = per > .1 and 1 or per * 10

					if self.BGGrowBars then
						per = 1 - per
						vper = 1
					else
						per = max (per, .1)
					end

					self:ClipFrameZTLO (f2, pX, pY, sz * per, sz * vper, -15, -15)

				else	-- No conflict

					f.NXData = format ("0~%f~%f~%s%s", pX, pY, name, sideStr)

					self.BGTimers[name] = nil

					-- Rect

					local sz = 30 / self.ScaleDraw

					local f2 = self:GetIcon (0)
					self:ClipFrameZTLO (f2, pX, pY, sz, sz, -15, -15)

--					Nx.prtCtrl ("I %s %s %s", name, txIndex, iconType or "nil")

					if iconType == 1 then	-- Ally?
						f2.texture:SetTexture (0, 0, 1, .3)
--						Nx.prtCtrl ("Blue")
					elseif iconType == 2 then	-- Horde?
						f2.texture:SetTexture (1, 0, 0, .3)
--						Nx.prtCtrl ("Red")
					else
						f2.texture:SetTexture (0, 0, 0, .3)
					end

					f2.NXType = 2000
					f2.NxTip = tip
					f2.NXData = f.NXData

				end
			end

			f.NxTip = tip

			self:ClipFrameZ (f, pX, pY, 16, 16, 0)

			f.texture:SetTexture ("Interface\\Minimap\\POIIcons")
			txX1, txX2, txY1, txY2 = GetPOITextureCoords (txIndex)
			f.texture:SetTexCoord (txX1 + .003, txX2 - .003, txY1 + .003, txY2 - .003)
			f.texture:SetVertexColor (1, 1, 1, 1)
		end
	end

	self.Level = oldLev + 4

	-- Update misc icons (herbs, ore, ...)
	-- Levels:
	--  +0 quest areas
	--  +1 quest area target
	--  +2-3 com players (++3 if alt key)
	--  +4 quest icons
	--  +5 ?

	Nx.HUD:Update (self)

	local comTrackName, comTrackX, comTrackY = Nx.Com:UpdateIcons (self)

	self.Level = self.Level + 2
	self.Guide:UpdateZonePOIIcons()
	Nx.Fav:UpdateIcons()
	self:UpdateIcons (self.KillShow)
	self.Level = self.Level - 2

	if Nx.Quest.Enabled then
		Nx.Quest:UpdateIcons (self)
	end

	self.Level = self.Level + 7

	-- Test

--	for n = 0, 100 do
--		local f = self:GetIcon()
--		f.texture:SetTexture (1, 1, .5, 1)
--		self:ClipFrameZ (f, n, 50, 2, 2)
--	end

	-- Battlefield flags

	local fX, fY, fToken
	local flagNum = GetNumBattlefieldFlagPositions()

	for i = 1, flagNum do

		fX, fY, fToken = GetBattlefieldFlagPosition (i)

		if fX ~= 0 or fY ~= 0 then

			local f = self:GetIconNI()
			f.texture:SetTexture ("Interface\\WorldStateFrame\\"..fToken)
			self:ClipFrameZ (f, fX * 100, fY * 100, 36, 36, 0)
		end
	end

	self.Level = self.Level + 1

	-- Raid or party icons (AKA group)

	local palName, palX, palY = self:UpdateGroup (plX, plY)

	-- Tracking animation

	if self.PlyrSpeed == 0 then

--		self.ArrowPulse = self.ArrowPulse + .05
--		if self.ArrowPulse > cnt then
--			self.ArrowPulse = 1
--		end

		self.ArrowScroll = self.ArrowScroll + .01
		if self.ArrowScroll >= 1 then
			self.ArrowScroll = 0
		end
	end

	-- Corpse or target tracking

	self.TrackDir = false

	self.Guide:OnMapUpdate()	-- For closest target

	if #self.Targets > 0 then

		self:UpdateTargets()
		self:UpdateTracking()
		self.Level = self.Level + 2
	end

	self.TrackETA = false

	local cX, cY = GetCorpseMapPosition()

	if (cX > 0 or cY > 0) and not inBG then	-- We dead, but not in BG?

		if self.GOpts["HUDATCorpse"] then

			self.TrackName = "Corpse"

			local x, y = self:GetWorldPos (mapId, cX * 100, cY * 100)
			self:DrawTracking (plX, plY, x, y, false, "D")

			local f = self:GetIcon (1)

			f.NxTip = "Your corpse"
			f.texture:SetTexture ("Interface\\Minimap\\POIIcons")
			self:ClipFrameZ (f, cX * 100, cY * 100, 16, 16, 0)
			-- Override clipping (FIX maybe?)
			f.texture:SetTexCoord (.502, .5605, 0, .0605)	-- 16x16 grid (.0625 uv size)

			self.Level = self.Level + 2
		end

	elseif ontaxi and Map.TaxiX then

		if self.GOpts["HUDATTaxi"] then

			self.TrackName = Map.TaxiName
			self.TrackETA = Map.TaxiETA

			local x, y = self.TaxiX, self.TaxiY
			self:DrawTracking (plX, plY, x, y, false, "F")

--			Nx.prt ("taxi %s %s", x, y)

			local f = self:GetIcon (1)

			f.NxTip = Map.TaxiName
			f.texture:SetTexture ("Interface\\Icons\\Ability_Mount_Wyvern_01")
			self:ClipFrameW (f, x, y, 16, 16, 0)

			self.Level = self.Level + 2
		end
	end

	-- Battle ground or manual pal tracking

	if (palX or comTrackX) and (inBG or next (self.TrackPlyrs)) then

		if palX then

			self.TrackName = palName
			self:DrawTracking (plX, plY, palX, palY, false, "B")
		else
			self.TrackName = comTrackName
			self:DrawTracking (plX, plY, comTrackX, comTrackY, false)
		end

		self.Level = self.Level + 2
	end

	-- Set final levels

	self.TextScFrm:SetFrameLevel (self.Level)
	self.PlyrFrm:SetFrameLevel (self.Level + 1)

	self.ToolBar:SetLevels (self.Level + 2)

	self.Level = self.Level + 3

	self:MinimapUpdateEnd()		-- Uses 2 levels

	self.LocTipFrm:SetFrameLevel (self.Level + 2)

	-- Hide leftovers

	self:HideExtraIcons()

	-- Scan. Switch maps if needed. Do at end so we dont glitch

	if Nx.Tick % self.ScanContinentsMod == 3 then
		self:ScanContinents()
	end

	if doSetCurZone then
		self:SetToCurrentZone()
	end

	-- Debug
--[[
	Nx.prt ("Map WPos %s ZPos %s WScale %s", self.GetWorldPosCnt or 0, self.GetZonePosCnt or 0, self.GetWorldZoneScaleCnt or 0)
	self.GetWorldPosCnt = 0
	self.GetZonePosCnt = 0
	self.GetWorldZoneScaleCnt = 0
--]]

end


function RDX.Map:GetCurrentMapId()

	--V403

	local cont = GetCurrentMapContinent()
	local zone = GetCurrentMapZone()

	if cont <= 0 or cont > 6 then

		local aid = GetCurrentMapAreaID()

--		Nx.prtCtrl ("GetCurrentMapId %s, %s+%s", aid, cont, zone)

--		if cont == -1 and (self.MapId or 0) > 11000 then
--			return self.MapId
--		end

		local id = Nx.AIdToId[aid]
		if id then
--			Nx.prt ("GetCurrentMapId from aid %s", id)
			return id
		end

		return self:GetRealMapId()
	end

--[[
	if not self.CZ2Id[cont] then
		Nx.prt ("cont %s", cont)
	end

	if not self.CZ2Id[cont][zone] then
		Nx.prt ("%s %s", cont, zone)
	end
--]]

	local mapId = self.CZ2Id[cont][zone] or 9000

	if mapId == Nx.MapNameToId[GetRealZoneText()] then		-- Same as real zone?
		return self:GetRealMapId()
	end

	return mapId
end


-- Destroy the menu
function RDX.Map:Destroy()
	--VFL.empty(self.mm); self.mm = nil;
	--VFL.empty(self.entries); self.entries = nil;
	-- to test
	self = nil;
end