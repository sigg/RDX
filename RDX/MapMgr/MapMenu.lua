

-- Create tool bar
	--[[
	m:CreateToolBar()

	-- Create buttons

	local bw, bh = win:GetBorderSize()

	local function func (self, but)
		self.LOpts.NXAutoScaleOn = but:GetPressed()
	end

	m.ButAutoScaleOn = Nx.Button:Create (win.Frm, "MapAutoScale", nil, nil, -20, -bh, "TOPRIGHT", 12, 12, func, m)
	m.ButAutoScaleOn:SetPressed (opts.NXAutoScaleOn)

	-- Create menu

	local menu = Nx.Menu:Create (f)
	m.Menu = menu

	menu:AddItem (0, "Goto", self.Menu_OnGoto, m)
	menu:AddItem (0, "Clear Goto", self.Menu_OnClearGoto, m)

	menu:AddItem (0, "Add Note", self.Menu_OnAddNote, m)

	menu:AddItem (0, "Save Map Scale", self.Menu_OnScaleSave, m)
	menu:AddItem (0, "Restore Map Scale", self.Menu_OnScaleRestore, m)

	m.MenuIPlyrFollow = menu:AddItem (0, "Follow You", self.Menu_OnPlyrFollow, m)

	local item = menu:AddItem (0, "Select Cities Last", self.SetLevelWorldHotspots, m)
	item:SetChecked (m, "NXCitiesUnder")

	m.MenuIMonitorZone = menu:AddItem (0, "Monitor Zone", self.Menu_OnMonitorZone, m)

	menu:AddItem (0, "", nil, self)

	-- Create route sub menu

	local routeMenu = Nx.Menu:Create (f)
	menu:AddSubMenu (routeMenu, "Route...")

	local function func (self)
		self:RouteGathers()
	end
	local item = routeMenu:AddItem (0, "Current Gather Locations", func, m)

	local function func (self)
		self:RouteTargets()
	end
	local item = routeMenu:AddItem (0, "Current Goto Targets", func, m)

	local function func (self)
		self.ShowUnexplored = false
		self:UpdateOverlayUnexplored()
		self:TargetOverlayUnexplored()
		self:RouteTargets()
	end

	routeMenu:AddItem (0, "Unexplored Locations", func, m)

	local function func (self)
		self:ReverseTargets()
	end

	routeMenu:AddItem (0, "Reverse Targets", func, m)

	local item = routeMenu:AddItem (0, "Recycle Reached Targets")
	item:SetChecked (gopts, "RouteRecycle")

	local item = routeMenu:AddItem (0, "Gather Target Radius")
	item:SetSlider (gopts, 7, 300, nil, "RouteGatherRadius")

	local item = routeMenu:AddItem (0, "Gather Merge Radius")
	item:SetSlider (gopts, 0, 100, nil, "RouteMergeRadius")

	-- Create show sub menu

	local showMenu = Nx.Menu:Create (f)
	menu:AddSubMenu (showMenu, "Show...")

	showMenu:AddItem (0, "Show Player Zone", self.Menu_OnShowPlayerZone, m)

	local function func (self)
		self.Guide:UpdateGatherFolders()
	end

	local item = showMenu:AddItem (0, "Show Herb Locations", func, m)
	m.MenuIShowHerb = item
	item:SetChecked (Nx.CharOpts, "MapShowGatherH")

	local item = showMenu:AddItem (0, "Show Mining Locations", func, m)
	m.MenuIShowMine = item
	item:SetChecked (Nx.CharOpts, "MapShowGatherM")

	local item = showMenu:AddItem (0, "Show Artifact Locations", func, m)
--	m.MenuIShowArt = item
	item:SetChecked (Nx.CharOpts, "MapShowGatherA")


	local function func (self)
		self.Guide.POIDraw = nil
	end

	local item = showMenu:AddItem (0, "Show Mailboxes", func, m)
	item:SetChecked (gopts, "MapShowMailboxes")


	local item = showMenu:AddItem (0, "Show Notes")
	item:SetChecked (gopts, "MapShowNotes")

	local item = showMenu:AddItem (0, "Show Punks")
	item:SetChecked (gopts, "MapShowPunks")


	local function func (self, item)
		self.ShowUnexplored = item:GetChecked()
	end

	local item = showMenu:AddItem (0, "Show Unexplored Areas", func, m)
	item:SetChecked (m.ShowUnexplored)


	m.MenuIShowWorld = showMenu:AddItem (0, "Show World", self.Menu_OnShowWorld, m)


	local function forceShowCont (self)
		self.ScanContinentsMod = 10
	end

	local item = showMenu:AddItem (0, "Show Cities", forceShowCont, Map)
	item:SetChecked (gopts, "MapShowCCity")

	local item = showMenu:AddItem (0, "Show Towns", forceShowCont, Map)
	item:SetChecked (gopts, "MapShowCTown")

	local item = showMenu:AddItem (0, "Show Extras", forceShowCont, Map)
	item:SetChecked (gopts, "MapShowCExtra")

	local item = showMenu:AddItem (0, "Show Kill Icons", self.Menu_OnShowKills, m)
	item:SetChecked (m.KillShow)

	-- Create minimap sub menu

	if not Nx.Free then

		local mmmenu = Nx.Menu:Create (f)

		menu:AddSubMenu (mmmenu, "Minimap...")

		local function func (self, item)
			self.LOpts.NXMMFull = item:GetChecked()
			self.MMZoomChanged = true
		end

		local item = mmmenu:AddItem (0, "Full Size", func, m)
		self.MMMenuIFull = item
		item:SetChecked (opts.NXMMFull)

		local function func (self, item)
			self.LOpts.NXMMAlpha = item:GetSlider()
		end

		local item = mmmenu:AddItem (0, "Transparency", func, m)
		item:SetSlider (opts.NXMMAlpha, 0, 1)

		local function func (self, item)
			self.LOpts.NXMMDockScale = item:GetSlider()
			self.MMZoomChanged = true
		end

		local item = mmmenu:AddItem (0, "Docked Scale", func, m)
		item:SetSlider (opts.NXMMDockScale, .01, 3)

		local function func (self, item)
			self.LOpts.NXMMDockScaleBG = item:GetSlider()
			self.MMZoomChanged = true
		end

		local item = mmmenu:AddItem (0, "Docked Scale In BG", func, m)
		item:SetSlider (opts.NXMMDockScaleBG, .01, 3)

		local function func (self, item)
			self.LOpts.NXMMDockAlpha = item:GetSlider()
		end

		local item = mmmenu:AddItem (0, "Docked Transparency", func, m)
		item:SetSlider (opts.NXMMDockAlpha, 0, 1)

		local function func (self, item)
			self.LOpts.NXMMDockOnAtScale = item:GetSlider()
		end

		local item = mmmenu:AddItem (0, "Docking Below Map Scale", func, m)
		item:SetSlider (opts.NXMMDockOnAtScale, 0, 5)
	end

	-- Create scale sub menu

	local smenu = Nx.Menu:Create (f)

	menu:AddSubMenu (smenu, "Scale...")

	local item = smenu:AddItem (0, "Auto Scale Min")
	item:SetSlider (opts, .01, 10, nil, "NXAutoScaleMin")

	local item = smenu:AddItem (0, "Auto Scale Max")
	item:SetSlider (opts, .25, 10, nil, "NXAutoScaleMax")

	local item = smenu:AddItem (0, "Zone Dot Scale", self.Menu_OnDotZoneScale, m)
	item:SetSlider (m.DotZoneScale, 0.1, 2)

	local item = smenu:AddItem (0, "Friend/Guild Dot Scale", self.Menu_OnDotPalScale, m)
	item:SetSlider (m.DotPalScale, 0.1, 2)

	local item = smenu:AddItem (0, "Party Dot Scale", self.Menu_OnDotPartyScale, m)
	item:SetSlider (m.DotPartyScale, 0.1, 2)

	local item = smenu:AddItem (0, "Raid Dot Scale", self.Menu_OnDotRaidScale, m)
	item:SetSlider (m.DotRaidScale, 0.1, 2)

	local item = smenu:AddItem (0, "Icon Scale", self.Menu_OnIconScale, m)
	item:SetSlider (m.IconScale, 0.1, 3)

	local item = smenu:AddItem (0, "Navigation Icon Scale", self.Menu_OnIconNavScale, m)
	item:SetSlider (m.IconNavScale, 0.1, 3)

	local function func (self, item)
		self.LOpts.NXDetailScale = item:GetSlider()
	end

	local item = smenu:AddItem (0, "Details At Scale", func, m)
	item:SetSlider (opts.NXDetailScale, .05, 10)

	local item = smenu:AddItem (0, "Gather Icons At Scale")
	item:SetSlider (gopts, .01, 10, nil, "MapIconGatherAtScale")

	local item = smenu:AddItem (0, "POI Icons At Scale")
	item:SetSlider (opts, .1, 10, nil, "NXPOIAtScale")

	-- Create transparency sub menu

	local tmenu = Nx.Menu:Create (f)
	m.TransMenu = tmenu

	menu:AddSubMenu (tmenu, "Transparency...")

	local item = tmenu:AddItem (0, "Detail Transparency", self.Menu_OnDetailAlpha, m)
	item:SetSlider (opts.NXDetailAlpha, .25, 1)

	local item = tmenu:AddItem (0, "Fade In Transparency", self.Menu_OnBackgndAlphaFull, m)
	item:SetSlider (m.BackgndAlphaFull, .25, 1)

	local item = tmenu:AddItem (0, "Fade Out Transparency", self.Menu_OnBackgndAlphaFade, m)
	item:SetSlider (m.BackgndAlphaFade, 0, 1)

	local function func (self)
		self.Guide:UpdateGatherFolders()
	end

	local item = tmenu:AddItem (0, "Gather Icon Transparency", func, m)
	item:SetSlider (gopts, .2, 1, nil, "MapIconGatherA")

	local item = tmenu:AddItem (0, "POI Icon Transparency")
	item:SetSlider (gopts, .2, 1, nil, "MapIconPOIAlpha")

	local function func (self, item)
		self.LOpts.NXUnexploredAlpha = item:GetSlider()
	end

	local item = tmenu:AddItem (0, "Unexplored Transparency", func, m)
	item:SetSlider (opts.NXUnexploredAlpha, 0, .9)

	-- Options menu

	local item = menu:AddItem (0, "Options...", self.Menu_OnOptions, m)

	-- Debug menu

	if NxData.DebugMap then

		m.DebugMap = true

		local dbmenu = Nx.Menu:Create (f)

		menu:AddItem (0, "", nil, self)
		menu:AddSubMenu (dbmenu, "Debug...")

		local function func (self, item)
			self.Debug = item:GetChecked()
		end

		local item = dbmenu:AddItem (0, "Map Debug", func, m)
		item:SetChecked (false)

--[[
		Nx.prt ("*** DebugHotspots is ON")
		m["DebugHotspots"] = true
--]]
		local item = dbmenu:AddItem (0, "Hotspots", func, m)
		item:SetChecked (m, "DebugHotspots")

		dbmenu:AddItem (0, "Hotspots pack", self.PackHotspotsDebug, m)

		local function func (self, item)
			self.DebugTime = item:GetChecked()
		end

		local item = dbmenu:AddItem (0, "Map Debug Time", func, m)
		item:SetChecked (false)

		local item = dbmenu:AddItem (0, "Map Full Coords", self.Menu_OnMapDebugFullCoords, m)
		item:SetChecked (m.DebugFullCoords)

		local item = dbmenu:AddItem (0, "Quest Debug", self.Menu_OnQuestDebug, m)
		item:SetChecked (Nx.Quest.Debug)

		local function func (self, item)
			self.DebugScale = item:GetSlider()
		end

		local item = dbmenu:AddItem (0, "Scale", func, m)
		item:SetSlider (0, 4, 6)
	end

	-- Create player icon menu

	local menu = Nx.Menu:Create (f)
	m.PIconMenu = menu

	menu:AddItem (0, "Whisper", self.Menu_OnWhisper, m)
	menu:AddItem (0, "Invite", self.Menu_OnInvite, m)
	menu:AddItem (0, "Get Quests", self.Menu_OnGetQuests, m)

	local item = menu:AddItem (0, "Track Player", self.Menu_OnTrackPlyr, m)
	local item = menu:AddItem (0, "Remove From Tracking", self.Menu_OnRemoveTracking, m)

	menu:AddItem (0, "Report Player AFK", self.Menu_OnReportPlyrAFK, m)
--	menu:AddItem (0, "Report All AFK", self.Menu_OnReportAllAFK, m)

	menu:AddItem (0, "")

	local item = menu:AddItem (0, "Grow Conflict Bars", self.Menu_OnGrowConflictBars, m)
	item:SetChecked (true)
	m.BGGrowBars = true

	-- Create general icon menu

	m:CreateIconMenu (f)

	-- Create BG icon menu

	m.BGIncNum = 0

	local menu = Nx.Menu:Create (f)
	m.BGIconMenu = menu

	for n = 1, #NXlBGMessages, 2 do

		local function func (self)
			self:BGMenu_Send (NXlBGMessages[n + 1])	-- Inherit n from loop
		end

		menu:AddItem (0, NXlBGMessages[n], func, m)
	end

	menu:AddItem (0, NXlBGStatus, self.BGMenu_OnStatus, m)
	--]]