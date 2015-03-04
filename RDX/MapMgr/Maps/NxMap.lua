---------------------------------------------------------------------------------------
-- RDX
-- Carbonite
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

NxMapOpts = {
	Version = 0
}

--------
-- Init map stuff

function RDXMAP.Map:Init()
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local gopts = mbo.data
	self.GOpts = gopts

	self.Maps = {}
	--self.Created = false

	self:InitFuncs()

	self.WorldMapHideNames = {
		"WorldMapCorpse", "WorldMapDeathRelease", "WorldMapPing", "OutlandButton", "AzerothButton"
	}
end

--------
-- Open and init

function RDXMAP.Map:Open(index, data)

	if not index then index = 1; end
	
	if not data[0] then
		data[0] = {};
		data[0].NXPlyrFollow = true;
		data[0].NXWorldShow = true;
	end

	self.Maps[index] = self:Create (index, data)

	return self.Maps[index];
end

--------

function RDXMAP.Map:UpdateOptions ()
	local opts = self.CurOpts
	if opts then
		--VFL.vprint ("Map UpdateOptions %s %s", self.MapPosX, self.MapPosY)
		opts.NXMapPosX = self.MapPosX
		opts.NXMapPosY = self.MapPosY
		opts.NXScale = self.Scale
	end
end

--------
-- Switch to a new set of options
-- self = map

function RDXMAP.Map:SwitchOptions (id, startup)

	local copts = self.LOpts[id] or self.LOpts[0]

	if copts ~= self.CurOpts then
		self.CurOpts = copts

		if copts.NXPlyrFollow then
			RDXMAP.APIMap.GotoPlayer(self)
		end


		if (not copts.NXPlyrFollow or startup) and copts.NXMapPosX then

			--VFL.vprint ("Map SwitchOptions %s NXMapPosX %f %f %f", id, copts.NXMapPosX, copts.NXMapPosY, copts.NXScale)

			self.MapPosX = copts.NXMapPosX
			self.MapPosY = copts.NXMapPosY
			self.Scale = copts.NXScale
			self.RealScale = self.Scale
			self.StepTime = 1

		elseif copts.NXPlyrFollow or RDX.InBG then
			RDXMAP.APIMap.GotoCurrentZone(self)
		end

	end
end

--------
-- Create a map

function RDXMAP.Map:Create (index, data)

	local m = {}
	
	m.myunit = RDXDAL.GetMyUnit();
	
	m.MapEvents = DispatchTable:new();
	m.DragContext = VFLUI.DragContext:new();

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local gopts = mbo.data
	m.GOpts = gopts
	
	local opts = data
	
	m.LOpts = opts		-- Local for map (stuff without a map mode)

	m.LOpts.NXPOIAtScale = m.LOpts.NXPOIAtScale or 1

	setmetatable (m, self)
	self.__index = self

	m.Tick = 0												-- Debug tick
	m.IconTick = 0;
	m.Debug = nil											-- Debug on
	m.DebugTime = nil
	m.DebugFullCoords = nil								-- Debug high precision map coords
	m.DebugAdjustScale = .1

	m.MapIndex = index

	m.TitleH = 0
	m.PadX = 0
	m.Scale = .025
	m.RealScale = .025
	m.ScaleDraw = .025									-- Actual draw scale
	m.MapScale = m.LOpts.NXMapScale or 1
	m.MapW = 150
	m.MapH = 140
	m.W = m.MapW + m.PadX * 2
	m.H = m.MapH + m.TitleH + 1
	m.LClickTime = 0
	m.MouseEnabled = true
	m.Scrolling = false
	m.StepTime = 0
	m.MapId = 0

	--m.PlyrX = 0
	--m.PlyrY = 0
	m.PlyrRZX = 0
	m.PlyrRZY = 0
	m.PlyrDir = 0
	m.PlyrLastDir = 999
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
	
	m.BackgndAlpha = 0									-- Current value
	m.BackgndAlphaTarget = m.LOpts.NXBackgndAlphaFade		-- Target value
	m.WorldAlpha = 0
	
	m.ArrowPulse = 1
	m.ArrowScroll = 0

	m.Data = {}
	m.IconFrms = {}
	m.IconFrms.Next = 1
	m.IconNIFrms = {}				-- Non interactive
	m.IconNIFrms.Next = 1
	m.IconStaticFrms = {}
	m.IconStaticFrms.Next = 1
	m.TextFStrs = {}
	m.TextFStrs.Next = 1
	
	m.Icon2Frms = {} -- new generation global
	m.Icon3Frms = {} -- new generation zone

	m.MMGathererUpdateDelay = 1

	-- Create main frame

	local f = VFLUI.AcquireFrame("Frame");
	m.Frm = f
	f.NxMap = m
	
	f.OnDrop = RDXMAP.APIMap.DropOn;

--	win:RegisterEvent ("PLAYER_LOGIN", self.OnEvent)
--	win:RegisterEvent ("PLAYER_ENTERING_WORLD", self.OnEvent)
	--f:RegisterEvent ("WORLD_MAP_UPDATE", RDXMAP.APIMap.OnEvent)
	--f:RegisterEvent ("PLAYER_REGEN_DISABLED", RDXMAP.APIMap.OnEvent)
	--f:RegisterEvent ("PLAYER_REGEN_ENABLED", RDXMAP.APIMap.OnEvent)
	
	--WoWEvents:Bind("WORLD_MAP_UPDATE", nil, function() RDXMAP.APIMap.OnEvent(f, "WORLD_MAP_UPDATE"); end, "MAP" .. index);
	
	WoWEvents:Bind("PLAYER_REGEN_DISABLED", nil, function() RDXMAP.APIMap.OnEvent(f, "PLAYER_REGEN_DISABLED"); end, "RDXMap" .. m.MapIndex);
	WoWEvents:Bind("PLAYER_REGEN_ENABLED", nil, function() RDXMAP.APIMap.OnEvent(f, "PLAYER_REGEN_ENABLED"); end, "RDXMap" .. m.MapIndex);
	
	f:SetScript ("OnMouseDown", RDXMAP.APIMap.OnMouseDown)
	f:SetScript ("OnMouseUp", RDXMAP.APIMap.OnMouseUp)
	f:SetScript ("OnMouseWheel", RDXMAP.APIMap.OnMouseWheel)
	f:EnableMouse (true)
	f:EnableMouseWheel (true)

	f:SetScript ("OnUpdate", RDXMAP.APIMap.OnUpdate)

	f:SetMovable (true)
	f:SetResizable (true)

	f:SetWidth (m.W)
	f:SetHeight (m.H)
	f:SetMinResize (50, 50)

	local t = VFLUI.CreateTexture(f)
	t:SetTexture (0, 0, 0, .2)
	t:SetAllPoints (f)
	f.texture = t
	t:Show();

	f:Show()

	-- Create text frame

	local tsf = VFLUI.AcquireFrame("ScrollFrame");
	tsf:SetParent(f);
	
	m.TextScFrm = tsf

	tsf:SetAllPoints (f)

	local tf = VFLUI.AcquireFrame("Frame");
	tf:SetParent(tsf);
	m.TextFrm = tf
	tf:SetPoint ("TOPLEFT", 0, 0)
	tf:SetWidth (100)
	tf:SetHeight (100)

	tsf:SetScrollChild (tf)

	-- Create Tip
	local ftip = VFLUI.AcquireFrame("Frame");
	ftip:SetParent(f);
--	f.NxInst = m
	m.LocTipFrm = ftip

	ftip:SetClampedToScreen()

	local t = VFLUI.CreateTexture(ftip)
	ftip.texture = t
	t:SetAllPoints (ftip)
	t:SetTexture (0, 0, 0, .85)
	t:Show();

	-- Font strings

	local fstrs = {}
	m.LocTipFStrs = fstrs
	
	for n = 1, 4 do
		local fstr = VFLUI.CreateFontString(ftip);
		tinsert (fstrs, fstr)
		VFLUI.SetFont(fstr, Fonts.Default, 10);
	end

	-- Create tool bar
	--m:CreateToolBar()

	-- Create menu
	
	local menu = m:BuildMenu(f, gopts, opts)
	
	-- Create player icon
	local plf = VFLUI.AcquireFrame("Frame");
	plf:SetParent(f);
	m.PlyrFrm = plf
	plf.NxMap = m

	plf:SetWidth (3)
	plf:SetHeight (3)

	local t = VFLUI.CreateTexture(plf)
	plf.texture = t
	t:SetTexture ("Interface\\Minimap\\MinimapArrow")
	t:SetAllPoints (plf)
	t:Show();

	plf:SetPoint ("CENTER", 0, (m.TitleH - 1) * -.5)
	plf:Show()

	-- Init map frames
	
	-- Create map zone tile frames
	m.TileFrms = {}
	for i = 1, 12 do
		local tf = VFLUI.AcquireFrame("Frame");
		tf:SetParent(f);
		m.TileFrms[i] = tf

		local t = VFLUI.CreateTexture(tf)
		t:SetAllPoints (tf)
		tf.texture = t
		t:Show();
	end
	
	-- Create continent frames
	m.ContFrms = {}

	local n = 1;
	
	local k, v;
	local pkg = RDXDB.GetPackage("RDXDiskMap", "maps")
	for objname, obj in pairs(pkg) do
		if type(obj) == "table" and obj.ty == "MapInfo" then
			k = tonumber(objname);
			v = obj.data.mf
			if v then
				if v.class == "c" then
					m.ContFrms[n] = {}
					m.ContFrms[n].mapid = k;
					local mapFileName = v.FileName
					for i = 1, 12 do
						if RDXMAP.ContBlks[k][i] ~= 0 then
							local cf = VFLUI.AcquireFrame("Frame");
							cf:SetParent(f);
							m.ContFrms[n][i] = cf

							local t = VFLUI.CreateTexture(cf)
							t:SetAllPoints (cf)
							cf.texture = t
							t:SetTexture ("Interface\\WorldMap\\"..mapFileName.."\\"..mapFileName..i)
							t:Show();
						end
					end
					n = n + 1;
				end
			else
				--VFL.print("error k " .. k);
			end
		end
	end
	
	--[[for k, v in pairs(RDXMAP.APIMap.MapWorldInfo()) do
		if v.class == "c" then
			m.ContFrms[n] = {}
			m.ContFrms[n].mapid = k;
			local mapFileName = v.FileName
			for i = 1, 12 do
				if RDXMAP.ContBlks[k][i] ~= 0 then
					local cf = VFLUI.AcquireFrame("Frame");
					cf:SetParent(f);
					m.ContFrms[n][i] = cf

					local t = VFLUI.CreateTexture(cf)
					t:SetAllPoints (cf)
					cf.texture = t
					t:SetTexture ("Interface\\WorldMap\\"..mapFileName.."\\"..mapFileName..i)
					t:Show();
				end
			end
			n = n + 1;
		end
	end]]
	
	m.MiniFrms = {}

	for n = 1, m.MiniBlks ^ 2 do

		local tf = VFLUI.AcquireFrame("Frame");
		tf:SetParent(f);
		m.MiniFrms[n] = tf

		local t = VFLUI.CreateTexture(tf)
		tf.texture = t
		t:SetAllPoints (tf)
		t:Show();
	end

	RDXMAP.APIMap.InitHotspots(m)

	-- Test

--[[
	RDXMAP.APIMap.InitIconType (m, "Test", nil, "Interface\\TargetingFrame\\TargetDead", 64, 64)

	for i = 1, 100, .2 do
		m:AddIconData ("Test", i, 30, 0)
	end
--]]

--[[
	RDXMAP.APIMap.InitIconType (m, "Test2", nil, 64, 64)

	for i = 1, 100, .2 do
		m:AddIconData ("Test2", i, 10, "00ff00")
	end
--]]

--[[
	RDXMAP.APIMap.InitIconType (m, "TestZR", "ZR")

	for i = 1, 10, 2 do
		RDXMAP.APIMap.AddIconRect (m, "TestZR", i, 5, i+1, 6, "00ff0080")
	end
--]]

	-- temporary disable
	
	--local questwin = CreateFrame("QuestPOIFrame")
	--m.QuestWin = questwin
	--m.QuestWin:SetParent(m.TextScFrm:GetScrollChild())
	--m.QuestWin:Hide()
	--m.QuestWin:SetSize(WorldMapButton:GetSize())
	--m.QuestWin:SetFillAlpha(255 * m.QuestAlpha)
	--m.QuestWin:SetBorderAlpha(255 * m.QuestAlpha)
	--m.QuestWin:SetFillTexture([[Interface\WorldMap\UI-QuestBlob-Inside]])
	--m.QuestWin:SetBorderTexture([[Interface\WorldMap\UI-QuestBlob-Outside]])
	--m.QuestWin:SetBorderScalar(0.15)
	
	local arch = VFLUI.AcquireFrame("ArchaeologyDigSiteFrame")
	m.Arch = arch
    m.Arch:SetParent(m.TextScFrm:GetScrollChild())		
    m.Arch:Hide()
	m.Arch:SetSize(WorldMapButton:GetSize())
	m.Arch:SetFillAlpha(255 * m.LOpts.NXArchAlpha)
	m.Arch:SetBorderAlpha(255 * m.LOpts.NXArchAlpha )
	m.Arch:SetFillTexture( [[Interface\WorldMap\UI-ArchaeologyBlob-Inside]] )
	m.Arch:SetBorderTexture( [[Interface\WorldMap\UI-ArchaeologyBlob-Outside]] )
	m.Arch:SetBorderScalar( 0.15 )
	
	m.RMapId = 9000		-- Safe default

	m:SwitchOptions (-1, true)
	
	-- Real map switch
	RDXEvents:Bind("PlayerZoneChanged", nil, function(rid)
		m:SwitchOptions(rid)
		RDXMAP.APIMap.SwitchRealMap(m, rid)
		m.Scale = m.RealScale
	end, "RDXMap" .. m.MapIndex)

	m:UpdateAll()


	local function func ()
		if not RDX.InBG then
			RDXMAP.APIMap.GotoPlayer(m)
		end
	end

	VFLT.ZMSchedule(1, func);

	RDXMapEvents:Bind("TrackPlayer", nil, function(a1) RDXMAP.TrackPlyrs[a1] = true; end, "RDXMap" .. m.MapIndex);
	RDXMapEvents:Bind("VehicleDumpPos", nil, function() m:VehicleDumpPos() end, "RDXMap" .. m.MapIndex);
	
	RDXMapEvents:Bind("SetTarget2", nil, function(keep) 
		RDXMAP.UpdateTrackingDelay = 0
		local sbt = m.ScaleBeforeTarget
		--	if m.ScaleBeforeTarget then
		--		m.Scale = m.ScaleBeforeTarget
				m.ScaleBeforeTarget = false
		--	end
		if not keep then
			RDXMAP.APIMap.ClearTargets()
		end
		m.ScaleBeforeTarget = sbt or not next (RDXU.MapTargets) and m.GOpts["MapRestoreScaleAfterTrack"] and m.Scale
		
	end, 
	"RDXMap" .. m.MapIndex);
	
	RDXMapEvents:Bind("ClearTargets", nil, function() 
		if m.LOpts.NXAutoScaleOn and m.ScaleBeforeTarget then

	--		VFL.vprint ("ScaleBeforeTarget trigger %s", matchType or "nil")
	--		m.Scale = m.ScaleBeforeTarget

			local myunit = RDXDAL.GetMyUnit();

			RDXMAP.APIMap.GotoPlayer(m)		-- Map won't move if cursor on it
			RDXMAP.APIMap.Move (m, myunit.PlyrX, myunit.PlyrY, m.ScaleBeforeTarget, 60)
		end

		m.ScaleBeforeTarget = false
	end, 
	"RDXMap" .. m.MapIndex);
	
	RDXMapEvents:Bind("SetCurrentMap", nil, function(mapId) 
		RDXMAP.APIMap.SetCurrentMap (m, mapId)
	end, "RDXMap" .. m.MapIndex);
	
	RDXMapEvents:Bind("CenterMap", nil, function(mapId, id) 
		RDXMAP.APIMap.CenterMap (m, mapId, id)
	end, "RDXMap" .. m.MapIndex);
	
	--RDXMapEvents:Dispatch("SetCurrentMap", curMapId)
	
	RDXMapEvents:Bind("GotoPlayer", nil, function() 
		RDXMAP.APIMap.GotoPlayer(m)
	end, "RDXMap" .. m.MapIndex);
	
	RDXMapEvents:Bind("GotoCurrentZone", nil, function() 
		local myunit = m.myunit;
		if myunit.InstanceId then
			RDXMAP.APIMap.Move (m, myunit.PlyrX, myunit.PlyrY, 20, 30)
		else
			RDXMAP.APIMap.CenterMap (m, myunit.mapId)
		end
	end, "RDXMap" .. m.MapIndex);
	
	RDXMapEvents:Bind("UpdateWorld", nil, function() 
		m:UpdateWorld()
	end, "RDXMap" .. m.MapIndex);
	
	m:UpdateWorld();
	----
	
	m.Destroy = VFL.hook(function(s)
		s.MapEvents:Unbind("RDXMap" .. s.MapIndex);
		RDXMapEvents:Unbind("RDXMap" .. s.MapIndex);
		WoWEvents:Unbind("RDXMap" .. s.MapIndex);
		RDXEvents:Unbind("RDXMap" .. s.MapIndex);
		
		s.GIconMenu2:Destroy();
		if s.MenuDebug then s.MenuDebug:Destroy(); end
		s.MenuShow:Destroy();
		s.MenuRoute:Destroy();
		
		s.Menu2:Destroy();
		
		
		for n = 1, #s.Icon2Frms do
			s.Icon2Frms[n]:Destroy(); s.Icon2Frms[n] = nil;
		end
		
		for n = 1, #s.Icon3Frms do
			s.Icon3Frms[n]:Destroy(); s.Icon3Frms[n] = nil;
		end
		
		s.Arch:Destroy(); s.Arch = nil;
		
		for n = 1, s.MiniBlks ^ 2 do
			VFLUI.ReleaseRegion(s.MiniFrms[n].texture); s.MiniFrms[n].texture = nil;
			s.MiniFrms[n]:Destroy(); s.MiniFrms[n] = nil;
		end
		s.MiniFrms = nil;
		for n = 1, #s.ContFrms do
			local k = s.ContFrms[n].mapid;
			for i = 1, 12 do
				if RDXMAP.ContBlks[k][i] ~= 0 then
					VFLUI.ReleaseRegion(s.ContFrms[n][i].texture); s.ContFrms[n][i].texture = nil;
					s.ContFrms[n][i]:Destroy(); s.ContFrms[n][i] = nil;
				end
			end
			s.ContFrms[n].mapid = nil;
			s.ContFrms[n] = nil;
		end
		s.ContFrms = nil;
		for n = 1, 12 do
			VFLUI.ReleaseRegion(s.TileFrms[n].texture); s.TileFrms[n].texture = nil;
			s.TileFrms[n]:Destroy(); s.TileFrms[n] = nil;
		end
		s.TileFrms = nil;
		VFLUI.ReleaseRegion(s.PlyrFrm.texture); s.PlyrFrm.texture = nil;
		s.PlyrFrm:Destroy(); s.PlyrFrm = nil;
		for n = 1, 4 do
			VFLUI.ReleaseRegion(s.LocTipFStrs[n]); s.LocTipFStrs[n] = nil;
		end
		VFLUI.ReleaseRegion(s.LocTipFrm.texture); s.LocTipFrm.texture = nil;
		s.LocTipFrm:Destroy(); s.LocTipFrm = nil;
		
		s.TextScFrm:SetScrollChild(nil);
		s.TextFrm:Destroy(); s.TextFrm = nil;
		s.TextScFrm:Destroy(); s.TextScFrm = nil;
		
		VFLUI.ReleaseRegion(s.Frm.texture); s.Frm.texture = nil;
		s.Frm.OnDrop = nil;
		s.Frm.NxMap = nil;
		s.Frm:Destroy(); s.Frm = nil;
		
		VFL.empty(s.WorldHotspots); s.WorldHotspots = nil;
		VFL.empty(s.WorldHotspotsCity); s.WorldHotspotsCity = nil;
		
		s.RMapId = nil;
		
	end, m.Destroy);

	return m
end

--------

function RDXMAP.Map:GetWinName()
	return "NxMap" .. self.MapIndex
end



function RDXMAP.Map:SetLocationTip (tipStr)

	local f = self.LocTipFrm
	local a = self.GOpts["MapLocTipAnchor"]

	if tipStr and a ~= "None" then

		local ar = self.GOpts["MapLocTipAnchorRel"]
		ar = ar == "None" and a or ar
		f:ClearAllPoints()
		f:SetPoint (a, self.Frm, ar)

		local fstrs = self.LocTipFStrs
		local i = 1
		local textW = 0

		for s in gmatch (tipStr, "(%C+)") do		-- gmatch makes garbage!
--			VFL.vprint (s)
			local fstr = fstrs[i]
			fstr:SetPoint ("TOPLEFT", 2, 0 - (i - 1) * 10)
			fstr:SetText (s)
			textW = max (textW, fstr:GetStringWidth())
			i = i + 1
		end

		for n = i, #fstrs do
			fstrs[n]:SetText ("")
		end

--		VFL.vprint (textW)

--		f:SetFrameStrata ("DIALOG")
		f:SetWidth (4 + textW)
		f:SetHeight (2 + (i - 1) * 10)
		f:Show()

	else
		f:Hide()
	end
end

--------
-- Update Blizzard world map frame if we grabbed it

function RDXMAP.Map:UpdateWorldMap()

	local f = self.WorldMapFrm
	
	--for factionIndex = 1, GetNumFactions() do
	--	local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)				
	--	if (name == "Operation: Shieldwall") or (name == "Dominance Offensive") then
	--		RDXMAP.MapWorldInfo[857].o = "krasarang_terrain1"
	--	end
	--end
	
	if f then

		if self.StepTime ~= 0 or self.Scrolling or IsShiftKeyDown() then
			f:Hide()
		else

			local tipf = getglobal ("WorldMapTooltip")
			if tipf then
				tipf:SetFrameStrata ("TOOLTIP")
			end

			local af = getglobal ("WorldMapFrameAreaFrame")
			if af then
				af:SetFrameStrata ("HIGH")
			end

			f:Show()

			RDXMAP.APIMap.ClipZoneFrm (self, self.MapId, f, 1)
			f:SetFrameLevel (self.Level)
			if self.WorldMapFrmMapId ~= self.MapId then

--				VFL.vprint ("mapid %s", self.MapId)

				self.WorldMapFrmMapId = self.MapId

				self:SetChildLevels (f, self.Level + 1)

				self.Level = self.Level + 4
			end
		end

		for k, f in ipairs (_G["MAP_VEHICLES"]) do
			f:SetScale (.001)
		end
	end
	if not InCombatLockdown() then	
		self.Arch:DrawNone();
		if RDXU.Opts["MapShowArchBlobs"] then
			for i = 1, ArchaeologyMapUpdateAll() do
				self.Arch:DrawBlob(ArcheologyGetVisibleBlobID(i), true)	  
			end
			RDXMAP.APIMap.ClipZoneFrm( self, self.MapId, self.Arch, 1 )
			self.Arch:SetFrameLevel(self.Level)		
			self.Arch:SetFillAlpha(255 * self.LOpts.NXArchAlpha)
			self.Arch:SetBorderAlpha( 255 * self.LOpts.NXArchAlpha )		
			self.Arch:Show()
		else
			self.Arch:Hide()
		end
	end
end

--------
-- Recursively set child levels

function RDXMAP.Map:SetChildLevels (frm, lvl)

	local ch = { frm:GetChildren() }

	for n, chf in pairs (ch) do

		chf:SetFrameLevel (lvl)

		if chf:GetNumChildren() > 0 then
			self:SetChildLevels (chf, lvl + 1)
		end
	end
end

--------
-- Set scale on world map icons

function RDXMAP.Map:SetWorldMapIcons (scale)

	for n = 1, MAX_PARTY_MEMBERS do
		local f = getglobal ("WorldMapParty" .. n)
		if f then
			f:SetScale (scale)
		end
	end
	for n = 1, MAX_RAID_MEMBERS do
		local f = getglobal ("WorldMapRaid" .. n)
		if f then
			f:SetScale (scale)
		end
	end
	local flags = GetNumBattlefieldFlagPositions()
	for n = 1, flags do
		local f = getglobal ("WorldMapFlag" .. n)
		if f then
			f:SetScale (scale)
		end
	end

	for k, f in ipairs (_G["MAP_VEHICLES"]) do
		f:SetScale (scale)
	end

	--for k, name in ipairs (RDXMAP.Map.WorldMapHideNames) do

	--	local f = getglobal (name)
	--	if f then
	--		f:SetScale (scale)
	--	end
	--end

--[[
	for n = 1, QuestMapUpdateAllQuests() do
		local f = QUEST_MAP_POI[n]
		if f then
			f:SetScale (scale)
		end
	end

	for i = 1, #QUEST_MAP_ADDITIONAL_POI do
		QUEST_MAP_ADDITIONAL_POI[i]:Hide();
	end
--]]
end

--------
--

function RDXMAP.Map:OnButZoomIn()
	self:SetScaleOverTime (2)
end

function RDXMAP.Map:OnButZoomOut()
	self:SetScaleOverTime (-2)
end


function RDXMAP.Map:BGIncSendTimer()

	local str = format ("Inc %s", self.BGIncNum)
	self:BGMenu_Send (str)

	self.BGIncNum = 0

--	VFL.vprint ("BGIncSendTimer %s", str)
end

--------
-- Enable or disable map mouse input

function RDXMAP.Map:MouseEnable (max)

--	VFL.vprint ("MouseEnable %s %s", max and "max" or "min", alt and 1 or 0)

	local on = true

	if max then
		if self.GOpts["MapMaxMouseIgnore"] then
			on = IsAltKeyDown() and true or false		-- IsAltKeyDown returns nil or 1
		end
	else
		if self.GOpts["MapMouseIgnore"] then
			on = IsAltKeyDown() and true or false		-- IsAltKeyDown returns nil or 1
		end
	end

	if self.MouseEnabled ~= on then

		self.MouseEnabled = on

		-- deprecated toolbar
		--if on then
		--	self:UpdateToolBar()		-- Will show or hide
		--else
		--	self.ToolBar.Frm:Hide()
		--end

		self.Frm:EnableMouse (on)
		self.Frm:EnableMouseWheel (on)

		for n, f in ipairs (self.IconFrms) do
			f:EnableMouse (on)
		end

		for n, f in ipairs (self.IconStaticFrms) do
			f:EnableMouse (on)
		end
	end
end


function RDXMAP.Map:CalcClick()

	local f = self.Frm

	local x, y = GetCursorPosition()
	x = x / f:GetEffectiveScale()
	y = y / f:GetEffectiveScale()

	self.ClickFrmX = x - f:GetLeft()
	self.ClickFrmY = f:GetTop() - y
end

function RDXMAP.Map:IsDoubleClick()

	if GetTime() - self.LClickTime < .5 then
		self.LClickTime = 0
		return true
	end
end

function RDXMAP.Map:OpenMenu()

	--local opts = self:GetOptionsT (self.MapIndex)

	-- TODO
	--self.MenuIPlyrFollow:SetChecked (self.CurOpts.NXPlyrFollow)
	--self.MenuIShowWorld:SetChecked (self.CurOpts.NXWorldShow)

	self.MenuMapId = self.MapId

	--self.Menu:Open()
	
	-- new menu
	VFL.poptree:Begin(150, 12, self.Frm, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self.Frm));
	self.Menu2:Open(VFL.poptree, nil, nil, "TOPLEFT", 0, 0, nil);
	
end



--------

function RDXMAP.Map:ClickZoomIn()
	self:MouseWheel (1)
end

function RDXMAP.Map:ClickZoomOut()
	self:MouseWheel (-1)
end

function RDXMAP.Map:MouseWheel (value)

--	VFL.vprint ("Map MouseWheel "..tostring (value))

	local f = self.Frm

	local x, y = GetCursorPosition()
	x = x / f:GetEffectiveScale()
	y = y / f:GetEffectiveScale()

	local left = f:GetLeft()
	local rgt = f:GetRight()
	local top = f:GetTop()
	local bot = f:GetBottom()

	local ox = self.MapPosX + (x - left - self.PadX - self.MapW / 2) / self.Scale
	local oy = self.MapPosY + (top - y - self.TitleH - self.MapH / 2) / self.Scale

	self.Scale = self:ScrollScale (value)
	self.StepTime = 10
	if RDXMAP.APIMap.IsInstanceMap(RDXMAP.APIMap.GetRealMapId()) then
	else
	  self.RealScale = self.Scale
	end
	self.MapScale = self.Scale / 10.02

	local nx = self.MapPosX + (x - left - self.PadX - self.MapW / 2) / self.Scale
	local ny = self.MapPosY + (top - y - self.TitleH - self.MapH / 2) / self.Scale

	self.MapPosX = self.MapPosX + ox - nx
	self.MapPosY = self.MapPosY + oy - ny		
end

function RDXMAP.Map:ScrollScale (value)

	local s = self.Scale
	if value < 0 then
		value = value * .76923
	end

	return math.max (s + value * s * .3, .015)
end

function RDXMAP.Map:SetScaleOverTime (steps)

	local step = steps >= 0 and 1 or -1
	for n = 1, abs (steps) do
		self.Scale = self:ScrollScale (step)
	end

	self.StepTime = 10
end


--------
-- Flag for update all map data

function RDXMAP.Map:UpdateAll()

	self.NeedWorldUpdate = true

--	VFL.vprint ("%d Map UpdateAll %d (%d)", self.Tick, RDXMAP.APIMap.GetCurrentMapId(), self.MapId)
end


function RDXMAP.Map:UpdateWorld()

	if self.Debug then
		VFL.vprint ("%d Map UpdateWorld1 %d L%d", self.Tick, RDXMAP.APIMap.GetCurrentMapId(), GetCurrentMapDungeonLevel())
	end

	self.NeedWorldUpdate = false

	local mapId = RDXMAP.APIMap.GetCurrentMapId()
	
	--local winfo = RDXMAP.APIMap.GetWorldZone(mapId)
	
	--if winfo and winfo.MapLevel then
	--	if GetCurrentMapDungeonLevel() ~= winfo.MapLevel then	-- Wrong level?
	--		SetDungeonMapLevel (winfo.MapLevel)
	--	end
	--end

	local i = RDXMAP.APIMap.GetExploredOverlayNum(self)

	if self.CurWorldUpdateMapId == mapId and i == self.CurWorldUpdateOverlayNum and GetCurrentMapDungeonLevel()==self.LastDungeonLevel then
		return
	end

	self.CurWorldUpdateMapId = mapId
	self.CurWorldUpdateOverlayNum = i
    self.LastDungeonLevel = GetCurrentMapDungeonLevel()
	
	local mapFileName,_,_,isMicro,microTex = GetMapInfo()	
	if not mapFileName then
		if GetCurrentMapContinent() == WORLDMAP_COSMIC_ID then
			mapFileName = "Cosmic"
		else
			mapFileName = "World"
		end
	end
    local texPath = "Interface\\WorldMap\\"..(isMicro and "MicroDungeon\\"..mapFileName.."\\"..microTex or mapFileName).."\\"
    local texName = microTex or mapFileName
	
	RDXMAP.APIMap.UpdateOverlayUnexplored(self)

	if self.Debug then
		VFL.vprint ("%d Map UpdateWorld %d", self.Tick, RDXMAP.APIMap.GetCurrentMapId())
		VFL.vprint (" File %s", mapFileName)
	end

	if Nx and Nx.UEvents then
		Nx.UEvents:UpdateMap (self, true)
	end
	
    local dungeonLevel = GetCurrentMapDungeonLevel();
    if (DungeonUsesTerrainMap()) then
        dungeonLevel = dungeonLevel - 1;
    end
    if dungeonLevel>0 then texName = texName..dungeonLevel.."_" end
	for i = 1, 12 do
		self.TileFrms[i].texture:SetTexture (texPath..texName..i)
	end
end

--------
-- Update window fade

function RDXMAP.Map:WinUpdateFade (fade)

	--self.ToolBar:SetFade (fade)
	--self.ButAutoScaleOn.Frm:SetAlpha (fade)
end

--------
-- Update map. Called every tick, make it quick

function RDXMAP.Map:Update (elapsed)

	local Nx = Nx
	
	-- self.MapId = mouse
	-- self.CurMapBG = BG mouse
	
	-- self.RMapId = player
	-- self.PlyrRZX = player X zone
	-- self.PlyrRZY = player Y zone 
	
	-- self.PlyrX = player X world
	-- self.PlyrY = player Y world

	--self:MouseEnable (self.Win:IsSizeMax())
	self:MouseEnable (true)

	if self.NeedWorldUpdate then
		self:UpdateWorld()
	end

	self.MapW = self.Frm:GetWidth() - self.PadX * 2
	self.MapH = self.Frm:GetHeight() - self.TitleH
	self.Level = self.Frm:GetFrameLevel() + 1

	local mapId = RDXMAP.APIMap.GetCurrentMapId()
	local rid = RDXMAP.APIMap.GetRealMapId()
	local inBG = RDXMAP.APIMap.IsBattleGroundMap (rid)

	if self.MapId ~= mapId or self.upp then
		self.upp = nil;
		--self.MapEvents:Dispatch("MAP_CHANGED", mapId);

		if self.Debug then
			VFL.vprint ("%d Map change %d to %d", self.Tick, self.MapId, mapId)
		end

		self.CurMapBG = RDXMAP.APIMap.IsBattleGroundMap (mapId)

--			self.MapIdOld = self.MapId
		--RDXMAP.APIMap.AddOldMap (self, mapId)
		local oi = self.GOpts["MapZoneDrawCnt"]
	
		if rid and RDXMAP.APIMap.IsZoneMap(rid) then
			VFL.vremove(self.MapsDrawnOrder, rid)
			tinsert (self.MapsDrawnOrder, rid)
			if #self.MapsDrawnOrder > oi then
				tremove (self.MapsDrawnOrder, 1)
			end
		end
		
		if mapId and RDXMAP.APIMap.IsZoneMap(mapId) then
			VFL.vremove(self.MapsDrawnOrder, mapId)
			tinsert (self.MapsDrawnOrder, mapId)
			if #self.MapsDrawnOrder > oi then
				tremove (self.MapsDrawnOrder, 1)
			end
		end
		
		
		

		self.MapId = mapId

		-- Nx.Com.PlyrChange = GetTime() ---
		
		-- Global icons data
		-- wipe
		for n = 1, #self.Icon2Frms do
			self.Icon2Frms[n]:Destroy(); self.Icon2Frms[n] = nil;
		end
		-- add
		local poiNum = GetNumMapLandmarks()
		for i = 1, poiNum do
			local name, desc, txIndex, pX, pY = GetMapLandmarkInfo (i)
			if txIndex ~= 0 then
				local tip = name
				if desc then
					tip = format ("%s\n%s", name, desc)
				end
				
				local f = VFLUI.POIIcon:new(self, 3)
				f.NxTip = tip
				f.NXType = 3000
				f.UData = name;
				f.NXData = f
				
				f.texture:SetTexture ("Interface\\Minimap\\POIIcons")
				txX1, txX2, txY1, txY2 = GetPOITextureCoords (txIndex)
				f.texture:SetTexCoord (txX1 + .003, txX2 - .003, txY1 + .003, txY2 - .003)
				f.texture:SetVertexColor (1, 1, 1, 1)
				local wx, wy = RDXMAP.APIMap.GetWorldPos (mapId, pX * 100, pY * 100)
				f.x = wx
				f.y = wy
				f.MapId = mapId
				f.n = f.NxTip
				table.insert(self.Icon2Frms, f);
			end
		end
		
		-- Zone icons data
		for n = 1, #self.Icon3Frms do
			self.Icon3Frms[n]:Destroy(); self.Icon3Frms[n] = nil;
		end
		-- add general
		--for k, name in ipairs (RDXMAP.GuidePOI) do
		--	local showType, tx = strsplit ("~", name)
		--	if showType == "Mailbox" then
		--		showType = self.GOpts["MapShowMailboxes"] and showType
		--	end
		--	if showType then
		--		tx = "Interface\\Icons\\" .. tx
		--		RDXMAP.IconGuide.UpdateMapGeneralIcons2 (self, self.Cont, showType, RDX.PlFactionNum, tx, showType, "!POI", mapId)
				
		--	end
		--end
		
		for n, id in ipairs (self.MapsDrawnOrder) do
			
			local mbo = RDXDB.TouchObject("RDXDiskMap:poisG:" .. id)
			if mbo and mbo.data then
				for i,v in ipairs(mbo.data) do
					if v.s == RDX.PlFactionNum or v.s == 2 then
						local f = VFLUI.POIIcon:new(self, 4)
						f.texture:SetTexture(RDXMAP.icontex[v.t])
						f.NxTip = format ("%s\n%s %.1f %.1f", RDXMAP.iconIdToName[v.t], RDXMAP.APIMap.IdToName(id), v.x, v.y) 
						f.x = v.x
						f.y = v.y
						f.NXType = 3001
						f.MapId = id
						f.n = f.NxTip
						f.NXData = v
						table.insert(self.Icon3Frms, f);
					end
				end
			end
			
			local mbo = RDXDB.TouchObject("RDXDiskSystem:favs:" .. id)
			if mbo and mbo.data then
				for i,v in ipairs(mbo.data) do
					--if v.s == RDX.PlFactionNum or v.s == 2 then
						local f = VFLUI.POIIcon:new(self, 4)
						f.texture:SetTexture(RDXMAP.icontex[v.t])
						f.NxTip = format ("%s\n%s %.1f %.1f", v.n or "toto", RDXMAP.APIMap.IdToName(id), v.x, v.y) 
						f.x = v.x
						f.y = v.y
						f.NXType = 3002
						f.MapId = id
						f.n = f.NxTip
						f.NXData = v
						table.insert(self.Icon3Frms, f);
					--end
				end
			end
			
			local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:ZC_" .. id);
			if mbo and mbo.data then
				for i,v in ipairs(mbo.data) do
					--if v.s == RDX.PlFactionNum or v.s == 2 then
						local f = VFLUI.POIIcon:new(self, 4)
						f.texture:SetTexture(RDXMAP.icontex["F"])
						f.NxTip = format ("%s\n%s %.1f %.1f", "Zone Connection", RDXMAP.APIMap.IdToName(id), v.x, v.y) 
						f.x = v.x
						f.y = v.y
						f.NXType = 3001
						f.MapId = id
						f.n = f.NxTip
						f.NXData = v
						table.insert(self.Icon3Frms, f);
					--end
				end
			end
		end
		
		
		
		
		-- add instances
		local mapid, info;
		local pkg = RDXDB.GetPackage("RDXDiskMap", "maps")
		for objname, obj in pairs(pkg) do
			if type(obj) == "table" and obj.ty == "MapInfo" then
				mapid = tonumber(objname);
				info = obj.data.mf
				if info then
					if info.class == "i" and info.EntryMId == self.MapId then
						local f = VFLUI.POIIcon:new(self, 4)
						f.NxTip = RDXMAP.MapIdToName[mapid]
						f.NXType = 3003
						f.UData = mapid;
						f.NXData = f
						f.texture:SetTexture ("Interface\\Icons\\INV_Misc_ShadowEgg")
						f.x = info.x --* 100
						f.y = info.y --* 100
						f.MapId = mapId
						f.n = f.NxTip
						table.insert(self.Icon3Frms, f); 
					end
				end
			end
		end

		RDXMAP.Quest.MapChanged()
		self:UpdateAll()
		
		--self.MoveLastX = self.myunit.PlyrX
		--self.MoveLastY = self.myunit.PlyrY
	end
	
	-- TODO To be checked later

	
	
	--[[
	if RDX.InBG and RDX.InBG ~= rid then	-- Left or changed BG?

--		VFL.vprint ("Left BG %s", RDX.InBG)

		local cb = Nx.Combat ---

		if RDX.InA then
			local s = RDXMAP.APIMap.GetShortName (RDX.InA)
			Nx.UEvents:AddInfo (format ("Left %s %d %d %dD %dH", s, cb.KBs, cb.Deaths, cb.DamDone, cb.HealDone)) ---

		else
			local total = cb.KBs + cb.Deaths + cb.HKs + cb.Honor
			if total > 0 then
				local sname = RDXMAP.APIMap.GetShortName (RDX.InBG)
				Nx.UEvents:AddInfo (format ("Left %s %d %d %d %d", sname, cb.KBs, cb.Deaths, cb.HKs, cb.Honor)) ---

				local tm = GetTime() - cb.BGEnterTime
				local _, honor = GetCurrencyInfo (392)		--V4
				local hGain = honor - cb.BGEnterHonor
				Nx.UEvents:AddInfo (format (" %s +%d honor, +%d hour", VFLT.FormatMinSec (tm), hGain, hGain / tm * 3600)) ---

				local xpGain = UnitXP ("player") - cb.BGEnterXP
				if xpGain > 0 then
					Nx.UEvents:AddInfo (format (" +%d xp, +%d hour", xpGain, xpGain / tm * 3600)) ---
				end
			end
		end

		cb.KBs = 0
		cb.Deaths = 0
		cb.HKs = 0
		cb.Honor = 0

		if RDX.InA then
			self.LOpts.NXMMFull = false
		end
		--Nx.InArena = nil ---
	end
]]
	--if inBG and RDX.InBG ~= rid then
	--	RDX.InBG = rid

	--	local cb = Nx.Combat ---
	--	cb.BGEnterTime = GetTime()
	--	local _, honor = GetCurrencyInfo (392)		--V4
	--	cb.BGEnterHonor = honor
	--	cb.BGEnterXP = UnitXP ("player")
		
	--	local winfo = RDXMAP.APIMap.GetWorldZone(rid)
	--	if winfo and winfo.Arena then
	--		Nx.InArena = rid ---
	--		self.LOpts.NXMMFull = true
	--	end

--		VFL.vprint ("Entering BG %s", rid)
	--	doSetCurZone = true
	--end

	--if self.RMapId ~= rid then
	--	if rid ~= 9000 then

			--VFL.vprint ("Map zone changed %d, %d", rid, mapId)

	--		if self.RMapId == 9000 then	-- Loading?
	--			self.CurOpts = nil
	--			self:SwitchOptions (rid, true)
	--		end

	--		self.RMapId = rid

	--		self:SwitchOptions (rid)
	--		RDXMAP.APIMap.SwitchRealMap (self, rid)
	--	end
	--	self.Scale = self.RealScale
	--end
	
	--local plX = self.myunit.PlyrX
	--local plY = self.myunit.PlyrY

	--local x = self.myunit.PlyrX - self.myunit.MoveLastX
	--local y = self.myunit.PlyrY - self.myunit.MoveLastY
	--local ang = self.myunit.PlyrDir - self.myunit.PlyrLastDir

	--local moveDist = (x * x + y * y) ^ .5

--	if moveDist > 0 then VFL.vprint ("MoveDist %f %f", moveDist, RDXMAP.BaseScale) end

	--if moveDist >= .01 * RDXMAP.BaseScale or abs (ang) > .01 then
	if self.myunit.movetick then

		-- Nx.Com.PlyrChange = GetTime() ---

		if self.myunit.MoveLastX ~= -1 then
			self.MoveDir = math.deg (math.atan2 (self.myunit.DistX, -self.myunit.DistY / 1.5))
		end

		--self.myunit.MoveLastX = plX
		--self.myunit.MoveLastY = plY

--		if not rotOk then
--			self.PlyrDir = self.MoveDir
--		end

		--self.myunit.PlyrLastDir = self.myunit.PlyrDir

		if not self.Scrolling and not self.MouseIsOver and not WorldMapFrame:IsVisible() then

			if self.CurOpts.NXPlyrFollow then

				local scOn = self.LOpts.NXAutoScaleOn		--self.GOpts["MapFollowChangeScale"]
				
				if plZX ~= 0 or plZY ~= 0 then
					
					if #RDXMAP.Tracking == 0 or not scOn then
						RDXMAP.APIMap.Move (self, self.myunit.PlyrX, self.myunit.PlyrY, nil, 60)
					end
				end

				if scOn then

					local midX
					local midY
					local dtx
					local dty

					local cX, cY = GetCorpseMapPosition()

					if cX ~= 0 or cY ~= 0 then

						midX, midY = RDXMAP.APIMap.GetWorldPos (mapId, cX * 100, cY * 100)
						dtx = 1
						dty = 1

					elseif #RDXMAP.Tracking > 0 then

						local tr = RDXMAP.Tracking[1]
						--midX = tr.TargetMX
						--midY = tr.TargetMY
						--dtx = abs (tr.TargetX1 - tr.TargetX2)
						--dty = abs (tr.TargetY1 - tr.TargetY2)
						midX = tr.x
						midY = tr.y
						dtx = 1
						dty = 1

					elseif RDXMAP.TaxiX then

						midX, midY = RDXMAP.TaxiX, RDXMAP.TaxiY
						dtx = 1
						dty = 1
					end

					if midX then

						local mX = (midX + self.myunit.PlyrX) * .5
						local mY = (midY + self.myunit.PlyrY) * .5

						local dx = abs (midX - self.myunit.PlyrX)
						local dy = abs (midY - self.myunit.PlyrY)
--						VFL.vprint ("Map scale target %f %f", dx, dy)
						dx = self.MapW / dx
						dy = self.MapH / dy
						local scale = min (dx, dy) * .5
--						VFL.vprint ("Map scales %f %f", dx, dy)

--						VFL.vprint ("Map scale target %f %f", dtx, dty)
						dx = self.MapW / dtx
						dy = self.MapH / dty
						scale = min (min (dx, dy), scale)	-- Smaller of target rect of player to target center

						local scmax = self.myunit.InstanceId and 800 or self.LOpts.NXAutoScaleMax

						scale = max (min (scale, scmax), self.LOpts.NXAutoScaleMin)
						RDXMAP.APIMap.Move (self, mX, mY, scale, 60)
					end
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

--		VFL.vprint ("Tick %f", self.Tick)

		if self.StepTime > 0 then

--			VFL.vprint ("Steptime Go #%d %f", self.Tick, self.StepTime)

			self.StepTime = -self.StepTime

			self.ScaleDrawW = 1 / self.ScaleDraw
			self.ScaleW = 1 / self.Scale
		end

		local st = -self.StepTime

		self.MapPosXDraw = VFL.Util_StepValue (self.MapPosXDraw, self.MapPosX, abs (xDiff) / st)
		self.MapPosYDraw = VFL.Util_StepValue (self.MapPosYDraw, self.MapPosY, abs (yDiff) / st)
		self.ScaleDrawW = VFL.Util_StepValue (self.ScaleDrawW, self.ScaleW, abs (self.ScaleDrawW - self.ScaleW) / st)
		self.ScaleDraw = 1 / self.ScaleDrawW

--		VFL.vprint ("Map scrl #%d %f %f", self.StepTime, self.MapPosXDraw, self.MapPosX)
--		VFL.vprint ("Map scrl %f %f", self.OCur, self.OEnd)
--		VFL.vprint ("Map scrl %f %f", self.ScaleDraw, self.Scale)

		self.StepTime = self.StepTime + 1
	end

	local _, zx, zy, zw = RDXMAP.APIMap.GetWorldZoneInfo (self.MapId)
	if zx then
		self.MapScale = self.Scale / 10.02
	end

	-- SIGG TO DISCUSS DISABLE
	--self.BackgndAlpha = VFL.Util_StepValue (self.BackgndAlpha, self.BackgndAlphaTarget, .05)
	self.BackgndAlpha = 1;
	self.Frm.texture:SetVertexColor (1, 1, 1, self.BackgndAlpha)
	--self.WorldAlpha = (self.BackgndAlpha - self.LOpts.NXBackgndAlphaFade) / (self.LOpts.NXBackgndAlphaFull - self.LOpts.NXBackgndAlphaFade) * self.LOpts.NXBackgndAlphaFull
	self.WorldAlpha = 1
	
	-- SIGG TO REMOVE MAP
	--if Nx and Nx.HUD then
	--	Nx.HUD:Update (self)
	--end
	--RDXMAP.Hud.Update (self)
	
	-- reset icons
	RDXMAP.APIMap.ResetIcons(self)
	
	-------------- START MAIN Update zone instance 
	RDXMAP.APIMap.UpdateContinents(self)
	RDXMAP.APIMap.UpdateZones(self)
	RDXMAP.APIMap.UpdateInstanceMap(self)
	self:UpdateWorldMap() -- archeology
	RDXMAP.APIMap.UpdateMiniFrames(self) --(minimap)
	
	-------------- END MAIN Update zone instance 
	
	-------------- START ICONS
	-- SHOW PLAYER ARROW 1

	local plSize = self.GOpts["MapPlyrArrowSize"]
	if IsShiftKeyDown() then -- decease the size of the icon  hide it
		plSize = 5 
	end

	local g = 1
	local b = 1
	local al = 1
	if RDX.InCombat then
		g = 0
		b = 0
		al = abs (GetTime() % 1 - .5) / .5 * .5 + .4
	end
	self.PlyrFrm.texture:SetVertexColor (1, g, b, al)
	--local str = format ("%s %d %d", UnitName ("player"), UnitHealth ("player"), UnitMana ("player"))
	--self.PlyrFrm.NxTip = str
	RDXMAP.APIMap.ClipFrameW (self, self.PlyrFrm, self.myunit.PlyrX, self.myunit.PlyrY, plSize, plSize, self.myunit.PlyrDir)

	-- SHOW PLAYER RED history
	if self.GOpts["MapShowTrail"] then
		RDXMAP.APIMap.UpdatePlyrHistory(self)
	end
	
	-- DEPRECATED
	--RDXMAP.APIMap.DrawContinentsPOIs(self)

	-- SHOW punks
	if self.GOpts["MapShowPunks"] then
		if Nx and Nx.Social then
			Nx.Social:UpdateIcons (self)
		end
	end
	
	if Nx and Nx.UEvents then
		Nx.UEvents:UpdateMap (self)
	end

--[[
	if self["DebugHotspots"] then
		self:UpdateHotspotsDebug()
	end
--]]

	-- Battlefield Vehicles ICONS
	RDXMAP.APIMap.UpdateIconsBattlefieldVehicle(self)
	
	-- alpha management
	local atScale = self.LOpts.NXPOIAtScale
	local alphaRange = atScale * .25
	local s = atScale - alphaRange
	local alpha = min ((self.ScaleDraw - s) / alphaRange, 1) * self.GOpts["MapIconPOIAlpha"]
	local draw = self.ScaleDraw > s and self.GOpts["MapShowPOI"]

	-- POI's (Points of interest)
	--RDXMAP.APIMap.UpdateIconsPOI(self)
	if not self.CurMapBG then -- static POI
		for n = 1, #self.Icon2Frms do
			self.Icon2Frms[n]:SetFrameLevel(self.Level + 3);
			RDXMAP.APIMap.ClipFrameW (self, self.Icon2Frms[n], self.Icon2Frms[n].x, self.Icon2Frms[n].y, 16, 16, -1)
		end
		if draw then
			for n = 1, #self.Icon3Frms do
				self.Icon3Frms[n]:SetFrameLevel(self.Level + 4);
				self.Icon3Frms[n].texture:SetVertexColor (1, 1, 1, alpha)
				RDXMAP.APIMap.ClipFrameW (self, self.Icon3Frms[n], self.Icon3Frms[n].x, self.Icon3Frms[n].y, 16, 16, -1)
			end
		else
			for n = 1, #self.Icon3Frms do
				self.Icon3Frms[n]:Hide();
			end
		end
	else -- BG dynamic POI
		-- to see later
	end

	-- Update misc icons (herbs, ore, ...)
	-- Levels:
	--  +0 quest areas
	--  +1 quest area target
	--  +2-3 com players (++3 if alt key)
	--  +4 quest icons
	--  +5 ?
	--if self.IconTick == 1 then
		--local comTrackName, comTrackX, comTrackY = Nx.Com:UpdateIcons (self) ---

		self.Level = self.Level + 2
		--[[
		
		TODO Sigg
		Completely changed the way it works
		On Mapid change load icon data into map
		
		
		]]
		
		
		-- Note icons
		if Nx and Nx.Fav then
			--Nx.Fav:UpdateIcons(self)
		end
		
		RDXMAP.APIMap.UpdateIcons (self, self.LOpts.NXKillShow)
		self.Level = self.Level - 2
	--end
	
	-- QUEST
	--if Nx and Nx.Quest and Nx.Quest.Enabled then
		RDXMAP.Quest.UpdateIcons(self)
	--end

	self.Level = self.Level + 7

	-- Battlefield flags

	local fX, fY, fToken, wX, wY
	local flagNum = GetNumBattlefieldFlagPositions()

	for i = 1, flagNum do

		fX, fY, fToken = GetBattlefieldFlagPosition (i)

		if fX ~= 0 or fY ~= 0 then
			local f = VFLUI.POIIcon:new(self)
			f.texture:SetTexture ("Interface\\WorldStateFrame\\"..fToken)
			wX, wY = RDXMAP.APIMap.GetWorldPos (self.MapId, fX * 100, fY * 100)
			RDXMAP.APIMap.ClipFrameW (self, f, wX, wY, 36, 36, 0)
		end
	end

	self.Level = self.Level + 1

	-- Raid or party icons (AKA group)
	local palName, palX, palY = RDXMAP.APIMap.UpdateGroup (self, plX, plY)

	-- Tracking animation
	if self.myunit.PlyrSpeed == 0 then

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

	RDXMapEvents:Dispatch("Guide:OnMapUpdate")	-- For closest target
	
	if #RDXU.MapTargets > 0 then
		--RDXMAP.APIMap.UpdateTargets(self)
		RDXMAP.APIMap.UpdateTracking(self)
		self.Level = self.Level + 2
	end

	self.TrackETA = false

	--local cX, cY = GetCorpseMapPosition()

	--if (cX > 0 or cY > 0) and not inBG then	-- We dead, but not in BG?

	--	if self.GOpts["HUDATCorpse"] then

		--	self.TrackName = "Corpse"

			--local x, y = RDXMAP.APIMap.GetWorldPos (mapId, cX * 100, cY * 100)
			--RDXMAP.APIMap.DrawTracking (self, plX, plY, x, y, "D", "Your corpse")

			--self.Level = self.Level + 2
		--end

	--else
	--if RDXMAP.ontaxi and RDXMAP.TaxiX then

	--	if self.GOpts["HUDATTaxi"] then

	--		self.TrackName = RDXMAP.TaxiName
	--		self.TrackETA = RDXMAP.TaxiETA

	--		local x, y = RDXMAP.TaxiX, RDXMAP.TaxiY
	--		RDXMAP.APIMap.DrawTracking (self, plX, plY, x, y, "F")

--			VFL.vprint ("taxi %s %s", x, y)

	--		local f = RDXMAP.APIMap.GetIcon (self, 1)

	--		f.NxTip = RDXMAP.TaxiName
	--		f.texture:SetTexture ("Interface\\Icons\\Ability_Mount_Wyvern_01")
	--		RDXMAP.APIMap.ClipFrameW (self, f, x, y, 16, 16, 0)

	--		self.Level = self.Level + 2
	--	end
	--end

	-- Battle ground or manual pal tracking

	if (palX or comTrackX) and (inBG or next (RDXMAP.TrackPlyrs)) then

		if palX then

			self.TrackName = palName
			RDXMAP.APIMap.DrawTracking (self, plX, plY, palX, palY, "B")
		else
			self.TrackName = comTrackName
			RDXMAP.APIMap.DrawTracking (self, plX, plY, comTrackX, comTrackY)
		end

		self.Level = self.Level + 2
	end

	-- Set final levels

	self.TextScFrm:SetFrameLevel (self.Level)
	self.PlyrFrm:SetFrameLevel (self.Level + 1)

	self.Level = self.Level + 3

	self.LocTipFrm:SetFrameLevel (self.Level + 2)

	-- Hide leftovers
	RDXMAP.APIMap.HideExtraIcons(self)

	-- Scan. Switch maps if needed. Do at end so we dont glitch

	-- DEPRECATED
	--if VFLT.GetFrameCounter() % self.ScanContinentsMod == 3 then
	--	RDXMAP.APIMap.ScanContinents(self)
	--end

	-- Debug
--[[
	VFL.vprint ("Map WPos %s ZPos %s WScale %s", self.GetWorldPosCnt or 0, self.GetZonePosCnt or 0, RDXMAP.APIMap.GetWorldZoneScaleCnt or 0)
	self.GetWorldPosCnt = 0
	self.GetZonePosCnt = 0
	RDXMAP.APIMap.GetWorldZoneScaleCnt = 0
--]]
end


------------------------------------------
-- Helpers

--------
-- Get a map by index

function RDXMAP.Map:GetMap (mapIndex)
	return self.Maps[mapIndex]
end


function RDXMAP.Map:VehicleDumpPos()

	-- Right Reaver guard .431 -.701  -359
	local myunit = RDXDAL.GetMyUnit();

	for n = 1, GetNumBattlefieldVehicles() do

		local x, y, unitName, possessed, typ, dir, player = GetBattlefieldVehicleInfo (n)
		if x and not player then

			local xo = myunit.PlyrRZX - x * 100
			local yo = (myunit.PlyrRZY - y * 100) / 1.5
			dir = dir / PI * -180
			xo, yo = xo * cos (dir) + yo * sin (dir), (xo * -sin (dir) + yo * cos (dir)) * 1.5

			VFL.vprint ("#%s %s %f %f %.3f %s", n, unitName or "nil", xo, yo, dir or -1, typ or "no type")
		end
	end
end

--[[

--------
-- Test empty function

function RDXMAP.Map:TestEmpty()
end

function RDXMAP.Map:Test1()

	local s = "########"
	local loc1 = strsub (s, 1, 4)
	local x, y = RDXMAP.UnpackLocPtOff (loc1, 1)
end

function RDXMAP.Map:Test2()
	local s = "####"
	local x, y = RDXMAP.UnpackLocPtOff (s, 1)
end

--------
-- Do test

function RDXMAP.Map:Test()

--[
	local tm = GetTime()
	for n = 1, 1000000 do
		self:TestEmpty()
	end
	VFL.vprint ("Time %.3f empty", GetTime() - tm)

	local tm = GetTime()
	for n = 1, 1000000 do
		RDXMAP.APIMap.GetZonePos (1001, 0, 0)
	end
	VFL.vprint ("Time %.3f", GetTime() - tm)

	local tm = GetTime()
	for n = 1, 1000000 do
		self:OLD_GetZonePos (1001, 0, 0)
	end
	VFL.vprint ("Time %.3f", GetTime() - tm)
--]

	-- Precondition
---[
	for n = 1, 1000 do
		self:Test1()
		self:Test2()
	end

	-- Test

	local tm = GetTime()
	local func = RDXMAP.Map.TestEmpty
	for n = 1, 5000000 do
		func (self)
	end
	VFL.vprint ("Time %.3f empty", GetTime() - tm)

	local tm = GetTime()
	local func = RDXMAP.Map.Test1
	for n = 1, 5000000 do
		func (self)
	end
	VFL.vprint ("Time %.3f #1", GetTime() - tm)

	local tm = GetTime()
	local func = RDXMAP.Map.Test2
	for n = 1, 5000000 do
		func (self)
	end
	VFL.vprint ("Time %.3f #2", GetTime() - tm)
--]
end

--]]

-------------------------------------------------------------------------------
-- EOF

function RDXMAP.APIMap.DragStart(btn, map)
	local proxy = VFLUI.CreateGenericDragProxy(btn, "", btn.data);
	--proxy.point = btn.point;
	map.DragContext:Drag(btn, proxy);
end

function RDXMAP.APIMap.DropOn(target, proxy, source, context)
	--if target == source then
	--	RDX.NewLearnWizardName("docking_windows");
	--else
		--local offset = nil;
		--if IsShiftKeyDown() then
		--	offset = true;
		--end
		--DesktopEvents:Dispatch("WINDOW_DOCK", proxy.data, proxy.point, target.data, target.point, offset);
	--end
end


function RDXWMap()
	RDXMapEvents:Dispatch("UpdateWorld")
end
-- /script RDXWMap()







