
--------

function RDXMAP.Map:InitFuncs()

	self.Funcs = {
		["None"] = function() end,
		["Add Note"] = self.Menu_OnAddNote,
		["Goto"] = RDXMAP.APIMap.SetTargetAtClick,
		["Show Player Zone"] = RDXMAP.APIMap.GotoCurrentZone,
		["Show Selected Zone"] = RDXMAP.APIMap.CenterMap,
		["Menu"] = self.OpenMenu,
		["Zoom In"] = self.ClickZoomIn,
		["Zoom Out"] = self.ClickZoomOut,
	}
end

function RDXMAP.Map:GetFuncs()

	local t = {}

	for name in pairs (self.Funcs) do
		tinsert (t, name)
	end

	sort (t)

	return t
end

--------
-- Call a map function from an option setting
-- self = map

function RDXMAP.Map:CallFunc (optName)

	local name = self.GOpts[optName]
	if name == "None" then
		return	-- return nil
	end

	local func = self.Funcs[name]
	if func then
		func (self)
	else
		VFL.vprint ("Unknown map function %s", name)
	end

	return true	-- We did something
end

--------------------------------------


function RDXMAP.Map:BuildMenu(f, gopts, opts)
	
	self.Menu2 = RDXPM.Menu:new();
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Goto");
		ent.func = function() VFL.poptree:Release(); RDXMAP.APIMap.SetTargetAtClick(self); end 
	end);
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Clear Goto");
		ent.func = function() VFL.poptree:Release(); RDXMAP.APIMap.ClearTargets(); RDXMapEvents:Dispatch("Guide:ClearAll"); end 
	end);
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Add Note");
		ent.func = function() VFL.poptree:Release(); self:Menu_OnAddNote(); end 
	end);
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Save Map Scale");
		ent.func = function() VFL.poptree:Release(); self.CurOpts.NXScaleSave = self.Scale; end 
	end);
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Restore Map Scale");
		ent.func = function() 
			VFL.poptree:Release(); 
			local s = self.CurOpts.NXScaleSave
			if s then
				self.Scale = s
				self.RealScale = s
				self.StepTime = 10
			else
				VFL.vprint ("Scale not set")
			end
		end 
	end);
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Follow You");
		ent.checked = function() return self.CurOpts.NXPlyrFollow; end;
		ent.func = function() VFL.poptree:Release(); self.CurOpts.NXPlyrFollow = not self.CurOpts.NXPlyrFollow end 
	end);
	-- was disable ...
	--self.Menu2:RegisterMenuFunction(function(ent)
	--	ent.text = VFLI.i18n("Select Cities Last");
	--	ent.checked = function() return self.NXCitiesUnder; end;
	--	ent.func = function() VFL.poptree:Release(); RDXMAP.APIMap.SetLevelWorldHotspots(self) end 
	--end);
	-- TODO SIGG
	--self.Menu2:RegisterMenuFunction(function(ent)
	--	ent.text = VFLI.i18n("Monitor Zone");
	--	ent.checked = function() return Nx.Com:IsZoneMonitored(self.MenuMapId) end; ---
	--	ent.func = function() VFL.poptree:Release(); Nx.Com:MonitorZone (self.MenuMapId, not Nx.Com:IsZoneMonitored(self.MenuMapId)) end ---
	--end);
	
	--local menu = Nx.Menu:Create (f) ---
	--self.Menu = menu ---
	
	--menu:AddItem (0, "Goto", self.Menu_OnGoto, self)
	--menu:AddItem (0, "Clear Goto", self.Menu_OnClearGoto, self)

	--menu:AddItem (0, "Add Note", self.Menu_OnAddNote, self)

	--menu:AddItem (0, "Save Map Scale", self.Menu_OnScaleSave, self)
	--menu:AddItem (0, "Restore Map Scale", self.Menu_OnScaleRestore, self)

	--self.MenuIPlyrFollow = menu:AddItem (0, "Follow You", self.Menu_OnPlyrFollow, self)

	--local item = menu:AddItem (0, "Select Cities Last", RDXMAP.APIMap.SetLevelWorldHotspots, self)
	--item:SetChecked (self, "NXCitiesUnder")

	--self.MenuIMonitorZone = menu:AddItem (0, "Monitor Zone", self.Menu_OnMonitorZone, self)

	--menu:AddItem (0, "", nil, self)
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = "*************";
		ent.isTitle = true;
		ent.color = _yellow;
		ent.notCheckable = true;
		ent.func = VFL.Noop;
	end);
	
	-- Create route sub menu
	self.MenuRoute = RDXPM.Menu:new();
	self.MenuRoute:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Current Gather Locations");
		ent.func = function() VFL.poptree:Release(); RDXMAP.APIMap.RouteGathers(self); end 
	end);
	self.MenuRoute:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Current Goto Targets");
		ent.func = function() VFL.poptree:Release(); RDXMAP.APIMap.RouteTargets(self); end 
	end);
	self.MenuRoute:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Unexplored Locations");
		ent.func = function() 
			VFL.poptree:Release();
			self.LOpts.NXShowUnexplored = false
			RDXMAP.APIMap.UpdateOverlayUnexplored(self)
			RDXMAP.APIMap.TargetOverlayUnexplored(self)
			RDXMAP.APIMap.RouteTargets(self)
		end 
	end);
	self.MenuRoute:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Reverse Targets");
		ent.func = function() VFL.poptree:Release(); RDXMAP.APIMap.ReverseTargets(); end 
	end);
	self.MenuRoute:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Recycle Reached Targets");
		ent.checked = function() return gopts.RouteRecycle; end;
		ent.func = function() VFL.poptree:Release(); gopts.RouteRecycle = not gopts.RouteRecycle end 
	end);
	self.Menu2:RegisterMenuEntry(VFLI.i18n("Route..."), true, function(tree, frame) self.MenuRoute:Open(tree, frame); end)

	--local routeMenu = Nx.Menu:Create (f) ---
	--menu:AddSubMenu (routeMenu, "Route...") ---

	--local function func (self2)
	--	RDXMAP.APIMap.RouteGathers(self2)
	--end
	--local item = routeMenu:AddItem (0, "Current Gather Locations", func, self)

	--local function func (self2)
	--	RDXMAP.APIMap.RouteTargets(self2)
	--end
	--local item = routeMenu:AddItem (0, "Current Goto Targets", func, self)

	--local function func (self2)
	--	self2.LOpts.NXShowUnexplored = false
	--	RDXMAP.APIMap.UpdateOverlayUnexplored(self2)
	--	RDXMAP.APIMap.TargetOverlayUnexplored(self2)
	--	RDXMAP.APIMap.RouteTargets(self2)
	--end

	--routeMenu:AddItem (0, "Unexplored Locations", func, self)

	--local function func (self2)
	--	RDXMAP.APIMap.ReverseTargets()
	--end
	--routeMenu:AddItem (0, "Reverse Targets", func, self)

	--local item = routeMenu:AddItem (0, "Recycle Reached Targets")
	--item:SetChecked (gopts, "RouteRecycle")
	-- TODO
	--local item = routeMenu:AddItem (0, "Gather Target Radius")
	--item:SetSlider (gopts, 7, 300, nil, "RouteGatherRadius")

	--local item = routeMenu:AddItem (0, "Gather Merge Radius")
	--item:SetSlider (gopts, 0, 100, nil, "RouteMergeRadius")
	
	self.MenuShow = RDXPM.Menu:new();
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Player Zone");
		ent.func = function() VFL.poptree:Release(); RDXMAP.APIMap.GotoCurrentZone(self); end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Herb Locations");
		ent.checked = function() return RDXU.Opts.MapShowGatherH; end;
		ent.func = function() VFL.poptree:Release(); RDXU.Opts.MapShowGatherH = not RDXU.Opts.MapShowGatherH; RDXMapEvents:Dispatch("Guide:UpdateGatherFolders"); end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Mining Locations");
		ent.checked = function() return RDXU.Opts.MapShowGatherM; end;
		ent.func = function() VFL.poptree:Release(); RDXU.Opts.MapShowGatherM = not RDXU.Opts.MapShowGatherM; RDXMapEvents:Dispatch("Guide:UpdateGatherFolders"); end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Artifact Locations");
		ent.checked = function() return RDXU.Opts.MapShowGatherA; end;
		ent.func = function() VFL.poptree:Release(); RDXU.Opts.MapShowGatherA = not RDXU.Opts.MapShowGatherA; RDXMapEvents:Dispatch("Guide:UpdateGatherFolders"); end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Mailboxes");
		ent.checked = function() return gopts.MapShowMailboxes; end;
		ent.func = function() VFL.poptree:Release(); gopts.MapShowMailboxes = not gopts.MapShowMailboxes; self.POIDraw = nil; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Notes");
		ent.checked = function() return gopts.MapShowNotes; end;
		ent.func = function() VFL.poptree:Release(); gopts.MapShowNotes = not gopts.MapShowNotes; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Punks");
		ent.checked = function() return gopts.MapShowPunks; end;
		ent.func = function() VFL.poptree:Release(); gopts.MapShowPunks = not gopts.MapShowPunks; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Archaeology Blobs");
		ent.checked = function() return RDXU.Opts.MapShowArchBlobs; end;
		ent.func = function() VFL.poptree:Release(); RDXU.Opts.MapShowArchBlobs = not RDXU.Opts.MapShowArchBlobs; self.POIDraw = nil; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Quest Blobs");
		ent.checked = function() return RDXU.Opts.MapShowQuestBlobs; end;
		ent.func = function() VFL.poptree:Release(); RDXU.Opts.MapShowQuestBlobs = not RDXU.Opts.MapShowQuestBlobs; self.POIDraw = nil; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Unexplored Areas");
		ent.checked = function() return opts.NXShowUnexplored; end;
		ent.func = function() VFL.poptree:Release(); opts.NXShowUnexplored = not opts.NXShowUnexplored; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show World");
		ent.checked = function() return self.CurOpts.NXWorldShow; end;
		ent.func = function() VFL.poptree:Release(); self.CurOpts.NXWorldShow = not self.CurOpts.NXWorldShow; end 
	end);
	
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Cities");
		ent.checked = function() return gopts.MapShowCCity; end;
		ent.func = function() VFL.poptree:Release(); gopts.MapShowCCity = not gopts.MapShowCCity; self.ScanContinentsMod = 10; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Towns");
		ent.checked = function() return gopts.MapShowCTown; end;
		ent.func = function() VFL.poptree:Release(); gopts.MapShowCTown = not gopts.MapShowCTown; self.ScanContinentsMod = 10; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Extras");
		ent.checked = function() return gopts.MapShowCExtra; end;
		ent.func = function() VFL.poptree:Release(); gopts.MapShowCExtra = not gopts.MapShowCExtra; self.ScanContinentsMod = 10; end 
	end);
	self.MenuShow:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Kill Icons");
		ent.checked = function() return opts.NXKillShow; end;
		ent.func = function() VFL.poptree:Release(); opts.NXKillShow = not opts.NXKillShow; end 
	end);
	self.Menu2:RegisterMenuEntry(VFLI.i18n("Show..."), true, function(tree, frame) self.MenuShow:Open(tree, frame); end)

	-- Create show sub menu

	--local showMenu = Nx.Menu:Create (f)
	--menu:AddSubMenu (showMenu, "Show...")

	--showMenu:AddItem (0, "Show Player Zone", self.Menu_OnShowPlayerZone, self)

	--local function func (self2)
	--	RDXMapEvents:Dispatch("Guide:UpdateGatherFolders")
	--end

	--local item = showMenu:AddItem (0, "Show Herb Locations", func, self)
	--self.MenuIShowHerb = item
	--item:SetChecked (RDXU.Opts, "MapShowGatherH")

	--local item = showMenu:AddItem (0, "Show Mining Locations", func, self)
	--self.MenuIShowMine = item
	--item:SetChecked (RDXU.Opts, "MapShowGatherM")

	--local item = showMenu:AddItem (0, "Show Artifact Locations", func, self)
--	self.MenuIShowArt = item
	--item:SetChecked (RDXU.Opts, "MapShowGatherA")


	--local function func (self2)
	--	self.POIDraw = nil
	--end

	--local item = showMenu:AddItem (0, "Show Mailboxes", func, self)
	--item:SetChecked (gopts, "MapShowMailboxes")

	--local item = showMenu:AddItem (0, "Show Notes")
	--item:SetChecked (gopts, "MapShowNotes")

	--local item = showMenu:AddItem (0, "Show Punks")
	--item:SetChecked (gopts, "MapShowPunks")

	--local item = showMenu:AddItem(0, "Show Archaeology Blobs", func, self)
	--item:SetChecked (RDXU.Opts, "MapShowArchBlobs")

	--local item = showMenu:AddItem(0, "Show Quest Blobs", func, self)
	--item:SetChecked (RDXU.Opts, "MapShowQuestBlobs")
	
	--local function func (self2, item)
	--	self2.LOpts.NXShowUnexplored = item:GetChecked()
	--end

	--local item = showMenu:AddItem (0, "Show Unexplored Areas", func, self)
	--item:SetChecked (self.LOpts.NXShowUnexplored)


	--self.MenuIShowWorld = showMenu:AddItem (0, "Show World", self.Menu_OnShowWorld, self)


	--local function forceShowCont (self2)
	--	self2.ScanContinentsMod = 10
	--end

	--local item = showMenu:AddItem (0, "Show Cities", forceShowCont, Map)
	--item:SetChecked (gopts, "MapShowCCity")

	--local item = showMenu:AddItem (0, "Show Towns", forceShowCont, Map)
	--item:SetChecked (gopts, "MapShowCTown")

	--local item = showMenu:AddItem (0, "Show Extras", forceShowCont, Map)
	--item:SetChecked (gopts, "MapShowCExtra")

	--local item = showMenu:AddItem (0, "Show Kill Icons", self.Menu_OnShowKills, self)
	--item:SetChecked (self.LOpts.NXKillShow)
	
	-- Create scale sub menu
	
	--[[
	
	local smenu = Nx.Menu:Create (f) ---

	menu:AddSubMenu (smenu, "Scale...")

	local item = smenu:AddItem (0, "Auto Scale Min")
	item:SetSlider (self.LOpts.NXAutoScaleMin, .01, 10)

	local item = smenu:AddItem (0, "Auto Scale Max")
	item:SetSlider (self.LOpts.NXAutoScaleMax, .25, 10)
	
	local item = smenu:AddItem (0, "Zone Dot Scale", self.Menu_OnDotZoneScale, self)
	item:SetSlider (self.LOpts.NXDotZoneScale, 0.1, 2)

	local item = smenu:AddItem (0, "Friend/Guild Dot Scale", self.Menu_OnDotPalScale, self)
	item:SetSlider (self.LOpts.NXDotPalScale, 0.1, 2)

	local item = smenu:AddItem (0, "Party Dot Scale", self.Menu_OnDotPartyScale, self)
	item:SetSlider (self.LOpts.NXDotPartyScale, 0.1, 2)

	local item = smenu:AddItem (0, "Raid Dot Scale", self.Menu_OnDotRaidScale, self)
	item:SetSlider (self.LOpts.NXDotRaidScale, 0.1, 2)

	local item = smenu:AddItem (0, "Icon Scale", self.Menu_OnIconScale, self)
	item:SetSlider (self.LOpts.NXIconScale, 0.1, 3)

	local item = smenu:AddItem (0, "Navigation Icon Scale", self.Menu_OnIconNavScale, self)
	item:SetSlider (self.LOpts.NXIconNavScale, 0.1, 3)

	local function func (self2, item)
		self2.LOpts.NXDetailScale = item:GetSlider()
	end

	local item = smenu:AddItem (0, "Details At Scale", func, self)
	item:SetSlider (self.LOpts.NXDetailScale, .05, 10)

	local item = smenu:AddItem (0, "Gather Icons At Scale")
	item:SetSlider (gopts, .01, 10, nil, "MapIconGatherAtScale")

	local item = smenu:AddItem (0, "POI Icons At Scale")
	item:SetSlider (self.LOpts.NXPOIAtScale, .1, 10)
	
	-- Create transparency sub menu

	local tmenu = Nx.Menu:Create (f) ---
	self.TransMenu = tmenu

	menu:AddSubMenu (tmenu, "Transparency...")

	local item = tmenu:AddItem (0, "Detail Transparency", self.Menu_OnDetailAlpha, self)
	item:SetSlider (self.LOpts.NXDetailAlpha, .25, 1)

	local item = tmenu:AddItem (0, "Fade In Transparency", self.Menu_OnBackgndAlphaFull, self)
	item:SetSlider (self.LOpts.NXBackgndAlphaFull, .25, 1)

	local item = tmenu:AddItem (0, "Fade Out Transparency", self.Menu_OnBackgndAlphaFade, self)
	item:SetSlider (self.LOpts.NXBackgndAlphaFade, 0, 1)

	local function func (self2)
		RDXMapEvents:Dispatch("Guide:UpdateGatherFolders")
	end

	local item = tmenu:AddItem (0, "Gather Icon Transparency", func, self)
	item:SetSlider (gopts, .2, 1, nil, "MapIconGatherA")

	local item = tmenu:AddItem (0, "POI Icon Transparency")
	item:SetSlider (gopts, .2, 1, nil, "MapIconPOIAlpha")

	local function func (self2, item)
		self2.LOpts.NXUnexploredAlpha = item:GetSlider()
	end

	local item = tmenu:AddItem (0, "Unexplored Transparency", func, self)
	item:SetSlider (self.LOpts.NXUnexploredAlpha, 0, .9)
	
	local item = tmenu:AddItem(0, "Archaeology Blob Transparency",self.Menu_OnArchAlpha, self)
	item:SetSlider (self.LOpts.NXArchAlpha,0,1)

	local item = tmenu:AddItem(0, "Quest Blob Transparency",self.Menu_OnQuestAlpha, self)
	item:SetSlider (self.QuestAlpha,0,1)
	
	--]]
	-- Options menu
	
	self.Menu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Options...");
		ent.func = function() VFL.poptree:Release(); self.Menu_OnOptions(self) end 
	end);
	--local item = menu:AddItem (0, "Options...", self.Menu_OnOptions, self)

	-- Debug menu

	if RDXG.DebugMap then

		--self.DebugMap = true

		--local dbmenu = Nx.Menu:Create (f) ---

		--menu:AddItem (0, "", nil, self)
		--menu:AddSubMenu (dbmenu, "Debug...")
		
		self.MenuDebug = RDXPM.Menu:new();
		self.MenuDebug:RegisterMenuFunction(function(ent)
			ent.text = VFLI.i18n("Map Debug");
			ent.checked = function() return self.Debug end;
			ent.func = function() VFL.poptree:Release(); self.Debug = not self.Debug; end 
		end);
		self.MenuDebug:RegisterMenuFunction(function(ent)
			ent.text = VFLI.i18n("Hotspots");
			ent.checked = function() return self.DebugHotspots end;
			ent.func = function() VFL.poptree:Release(); self.DebugHotspots = not self.DebugHotspots; self.Debug = self.DebugHotspots; end 
		end);
		self.MenuDebug:RegisterMenuFunction(function(ent)
			ent.text = VFLI.i18n("Hotspots pack");
			ent.func = function() VFL.poptree:Release(); self.PackHotspotsDebug(self); end 
		end);
		self.MenuDebug:RegisterMenuFunction(function(ent)
			ent.text = VFLI.i18n("Map Debug Time");
			ent.checked = function() return self.DebugTime end;
			ent.func = function() VFL.poptree:Release(); self.DebugTime = not self.DebugTime; end 
		end);
		self.MenuDebug:RegisterMenuFunction(function(ent)
			ent.text = VFLI.i18n("Map Full Coords");
			ent.checked = function() return self.DebugFullCoords end;
			ent.func = function() VFL.poptree:Release(); self.DebugFullCoords = not self.DebugFullCoords; end 
		end);
		--self.MenuDebug:RegisterMenuFunction(function(ent)
		--	ent.text = VFLI.i18n("Quest Debug");
		--	ent.checked = function() return Nx.Quest.Debug end;
		--	ent.func = function() VFL.poptree:Release(); Nx.Quest.Debug = not Nx.Quest.Debug; end 
		--end);
		self.Menu2:RegisterMenuEntry(VFLI.i18n("Debug..."), true, function(tree, frame) self.MenuDebug:Open(tree, frame); end)


		--local function func (self2, item)
		--	self2.Debug = item:GetChecked()
		--end

		--local item = dbmenu:AddItem (0, "Map Debug", func, self)
		--item:SetChecked (false)


		--VFL.vprint ("*** DebugHotspots is ON")
		--self["DebugHotspots"] = true

		--local item = dbmenu:AddItem (0, "Hotspots", func, self)
		--item:SetChecked (self, "DebugHotspots")

		--dbmenu:AddItem (0, "Hotspots pack", self.PackHotspotsDebug, self)

		--local function func (self2, item)
		--	self2.DebugTime = item:GetChecked()
		--end

		--local item = dbmenu:AddItem (0, "Map Debug Time", func, self)
		--item:SetChecked (false)

		--local item = dbmenu:AddItem (0, "Map Full Coords", self.Menu_OnMapDebugFullCoords, self)
		--item:SetChecked (self.DebugFullCoords)

		--local item = dbmenu:AddItem (0, "Quest Debug", self.Menu_OnQuestDebug, self)
		--item:SetChecked (Nx.Quest.Debug)

		--local function func (self2, item)
		--	self2.DebugScale = item:GetSlider()
		--end

		--local item = dbmenu:AddItem (0, "Scale", func, self)
		--item:SetSlider (0, 4, 6)
	end
	
	-- Create player icon menu
--[[
	local menu = Nx.Menu:Create (f) ---
	self.PIconMenu = menu

	menu:AddItem (0, "Whisper", self.Menu_OnWhisper, self)
	menu:AddItem (0, "Invite", self.Menu_OnInvite, self)
	menu:AddItem (0, "Get Quests", self.Menu_OnGetQuests, self)

	local item = menu:AddItem (0, "Track Player", self.Menu_OnTrackPlyr, self)
	local item = menu:AddItem (0, "Remove From Tracking", self.Menu_OnRemoveTracking, self)

	menu:AddItem (0, "Report Player AFK", self.Menu_OnReportPlyrAFK, self)
--	menu:AddItem (0, "Report All AFK", self.Menu_OnReportAllAFK, self)

	menu:AddItem (0, "")

	local item = menu:AddItem (0, "Grow Conflict Bars", self.Menu_OnGrowConflictBars, self)
	item:SetChecked (true)
	self.BGGrowBars = true
	]]
	-- Create general icon menu

	--local menug = Nx.Menu:Create (f)
	--self.GIconMenu = menug
	-- TODO
	self.GIconMenu2 = RDXPM.Menu:new();
	self.GIconMenu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Toggle Instance Map");
		ent.func = function() VFL.poptree:Release(); self:GMenu_OnTogInst(); end 
	end);
	self.GIconMenu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Find Note");
		ent.func = function() VFL.poptree:Release(); self:GMenu_OnFindNote(); end 
	end);

	--self.GIconMenuITogInst = menug:AddItem (0, "Toggle Instance Map", self.GMenu_OnTogInst, self)
	--self.GIconMenuIFindNote = menug:AddItem (0, "Find Note", self.GMenu_OnFindNote, self)
	--if Nx and Nx.Quest then
	--	Nx.Quest:CreateGiverIconMenu (menug, f)
	--end

	self.GIconMenu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Goto");
		ent.func = function() VFL.poptree:Release(); self:GMenu_OnGoto(); end 
	end);
	self.GIconMenu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Clear Goto");
		ent.func = function() VFL.poptree:Release(); self:Menu_OnClearGoto(); end 
	end);
	self.GIconMenu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Paste Link");
		ent.func = function() VFL.poptree:Release(); self:GMenu_OnPasteLink(); end 
	end);
	self.GIconMenu2:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Add Note");
		ent.func = function() VFL.poptree:Release(); self:Menu_OnAddNote(); end 
	end);
	--menug:AddItem (0, "Goto", self.GMenu_OnGoto, self)
	--menug:AddItem (0, "Clear Goto", self.Menu_OnClearGoto, self)
	--menug:AddItem (0, "Paste Link", self.GMenu_OnPasteLink, self)

	--menug:AddItem (0, "Add Note", self.Menu_OnAddNote, self)
	
	-- Create BG icon menu

	--[[
	self.BGIncNum = 0

	local menub = Nx.Menu:Create (f) ---
	self.BGIconMenu = menub

	for n = 1, #NXlBGMessages, 2 do

		local function func (self2)
			self2:BGMenu_Send (NXlBGMessages[n + 1])	-- Inherit n from loop
		end

		menub:AddItem (0, NXlBGMessages[n], func, self)
	end

	menub:AddItem (0, NXlBGStatus, self.BGMenu_OnStatus, self)
	]]
	return menu;
end


--------------------------------------
--function RDXMAP.Map:Menu_OnGoto (item)
--	RDXMAP.APIMap.SetTargetAtClick(self)
--end

--function RDXMAP.Map:Menu_OnClearGoto (item)
--	RDXMAP.APIMap.ClearTargets()
--	RDXMapEvents:Dispatch("Guide:ClearAll")
--end

function RDXMAP.Map:Menu_OnAddNote()
	local wx, wy = RDXMAP.APIMap.FramePosToWorldPos (self, self.ClickFrmX, self.ClickFrmY)
	VFLUI.MessageBox(VFLI.i18n("Add Note:"), VFLI.i18n("Enter name"), "?", VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) 
		local mbo = RDXDB.TouchObject("RDXDiskSystem:favs:" .. self.MapId)
		if not mbo.data then
			mbo.ty = "POISet"; 
			mbo.version = 1;
			mbo.data = {};
		end
		local tbl1 = {};
		tbl1.t = "Star";
		tbl1.z = self.MapId;
		tbl1.x = wx;
		tbl1.y = wy;
		tbl1.n = newname;
		table.insert(mbo.data, tbl1);
		self.upp = true;
	end);
end

function RDXMAP.Map:Menu_OnMonitorZone (item)
	--Nx.Com:MonitorZone (self.MenuMapId, item:GetChecked())
end

--function RDXMAP.Map:Menu_OnScaleSave()
--	self.CurOpts.NXScaleSave = self.Scale
--end

--function RDXMAP.Map:Menu_OnScaleRestore()
--	local s = self.CurOpts.NXScaleSave
--	if s then
--		self.Scale = s
--		self.RealScale = s
--		self.StepTime = 10
--	else
--		VFL.vprint ("Scale not set")
--	end
--end

--function RDXMAP.Map:Menu_OnPlyrFollow (item)
	--self.CurOpts.NXPlyrFollow = item:GetChecked()
--end

function RDXMAP.Map:Menu_OnShowWorld (item)
	--self.CurOpts.NXWorldShow = item:GetChecked()
end

function RDXMAP.Map:Menu_OnShowPlayerZone()
	RDXMAP.APIMap.GotoCurrentZone(self)
end

--function RDXMAP.Map:Menu_OnShowKills (item)
--	self.LOpts.NXKillShow = item:GetChecked()
--end

function RDXMAP.Map:Menu_OnDetailAlpha (item)
	self.LOpts.NXDetailAlpha = item:GetSlider()
end

function RDXMAP.Map:Menu_OnBackgndAlphaFade (item)
	self.LOpts.NXBackgndAlphaFade = item:GetSlider()
end

function RDXMAP.Map:Menu_OnArchAlpha (item)
	self.LOpts.NXArchAlpha = item:GetSlider()
end

function RDXMAP.Map:Menu_OnQuestAlpha (item)
	self.QuestAlpha = item:GetSlider()
end

function RDXMAP.Map:Menu_OnBackgndAlphaFull (item)
	self.LOpts.NXBackgndAlphaFull = item:GetSlider()
end

function RDXMAP.Map:Menu_OnDotZoneScale (item)
	self.LOpts.NXDotZoneScale = item:GetSlider()
end

function RDXMAP.Map:Menu_OnDotPalScale (item)
	self.LOpts.NXDotPalScale = item:GetSlider()
end

function RDXMAP.Map:Menu_OnDotPartyScale (item)
	self.LOpts.NXDotPartyScale = item:GetSlider()
end

function RDXMAP.Map:Menu_OnDotRaidScale (item)
	self.LOpts.NXDotRaidScale = item:GetSlider()
end

function RDXMAP.Map:Menu_OnIconScale (item)
	self.LOpts.NXIconScale = item:GetSlider()
end

function RDXMAP.Map:Menu_OnIconNavScale (item)
	self.LOpts.NXIconNavScale = item:GetSlider()
end

function RDXMAP.Map:Menu_OnOptions (item)
	if Nx and Nx.Opts then
		Nx.Opts:Open ("Map")
	end
end

-- Debug sub menu

--function RDXMAP.Map:Menu_OnMapDebugFullCoords (item)
--	self.DebugFullCoords = item:GetChecked()
--end

--function RDXMAP.Map:Menu_OnQuestDebug (item)
--	Nx.Quest.Debug = item:GetChecked()
--end

-- Plyr icon menu

function RDXMAP.Map:Menu_OnWhisper()

	for _, name in pairs (RDXMAP.PlyrNames) do

		local box = ChatEdit_ChooseBoxForSend()
		ChatEdit_ActivateChat (box)
		box:SetText ("/w " .. name .. " " .. box:GetText())
--[[
		local frm = DEFAULT_CHAT_FRAME
		local eb = frm["editBox"]
		if not eb:IsVisible() then
			ChatFrame_OpenChat ("/w " .. name, frm)
		else
			eb:SetText ("/w " .. name .. " " .. eb:GetText())
		end
--]]
		break
	end
end

-- Plyr icon menu

function RDXMAP.Map:Menu_OnInvite()

	for _, name in pairs (RDXMAP.PlyrNames) do
		InviteUnit (name)
		break
	end
end

function RDXMAP.Map:Menu_OnGetQuests (item)

	for _, name in pairs (RDXMAP.PlyrNames) do
		Nx.Quest:GetFromPlyr (name)
		break
	end
end

function RDXMAP.Map:Menu_OnTrackPlyr (item)

	for _, name in pairs (RDXMAP.PlyrNames) do
		RDXMAP.TrackPlyrs[name] = true
	end
end

function RDXMAP.Map:Menu_OnRemoveTracking (item)

	for _, name in pairs (RDXMAP.PlyrNames) do
		RDXMAP.TrackPlyrs[name] = nil
	end
end

function RDXMAP.Map:Menu_OnReportPlyrAFK (item)
	local n = 0
	for k, v in pairs (RDXMAP.AFKers) do
		ReportPlayerIsPVPAFK (v)
		n = n + 1
	end
	VFL.vprint ("%d reported", n)
end

--[[
function RDXMAP.Map:Menu_OnReportAllAFK (item)

	local members = MAX_PARTY_MEMBERS
	local unitName = "party"

	if IsInRaid() > 0 then
		members = MAX_RAID_MEMBERS
		unitName = "raid"
	end

	local cnt = 0

	for i = 1, members do

		local unit = unitName..i

		if not UnitIsUnit (unit, "player") then
			ReportPlayerIsPVPAFK (unit)
			cnt = cnt + 1
		end
	end

	VFL.vprint ("%d reported", cnt)
end
--]]

function RDXMAP.Map:Menu_OnGrowConflictBars (item)
	self.BGGrowBars = item:GetChecked()
end

function RDXMAP.Map:GMenuOpen (icon, typ)

	-- new menu
	--[[
	self.GIconMenuITogInst:Show (false)
	self.GIconMenuIFindNote:Show (false)

	if typ == 3000 then
		if icon.UData then
			self.GIconMenuITogInst:Show()
		end

		if icon.FavData1 then
			self.GIconMenuIFindNote:Show()
		end
	end
]]
	--if Nx and Nx.Quest then
	--	Nx.Quest:OpenGiverIconMenu (icon, typ)
	--end

	VFL.poptree:Begin(150, 12, self.Frm, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self.Frm));
	self.GIconMenu2:Open(VFL.poptree, nil, nil, "TOPLEFT", 0, 0, nil);

	--self.GIconMenu:Open()
end

--------
-- Instance icon

function RDXMAP.Map:GMenu_OnTogInst()

	local icon = self.ClickIcon

	local mapId = icon.UData

	if mapId then
		if self.InstMapId == mapId then
			RDXMAP.APIMap.SetInstanceMap(self)
		else
			local atlas = _G["AtlasMaps"]

--			VFL.vprint ("%s", mapId)

			if not (RDXMAP.Map.InstanceInfo[mapId] or atlas) then
				UIErrorsFrame:AddMessage ("This instance map requires the Atlas addon be installed", 1, .1, .1, 1)
				return
			end

			RDXMAP.APIMap.SetInstanceMap (self, mapId)
		end
	end
end

--------
-- Favorite icon

function RDXMAP.Map:GMenu_OnFindNote()
	if Nx and Nx.Fav then
		Nx.Fav:ShowIconNote (self.ClickIcon)
	end
end

--------
-- Generic icon goto

function RDXMAP.Map:GMenu_OnGoto()
	if Nx and Nx.Quest then
		Nx.Quest.Watch:ClearAutoTarget()
	end

	if self.ClickType == 3001 then
		if Nx and Nx.Social then
			Nx.Social:GotoPunk (self.ClickIcon)
		end
	else
		local icon = self.ClickIcon
		local x = icon.x
		local y = icon.y
		local name = icon.Tip and strsplit ("\n", icon.Tip) or ""
		RDXMAP.APIMap.SetTarget ("Goto2", x, y, 0, name, nil, self.MapId)
		self.ClickIcon.m = self.MapId
		--RDXMAP.APIMap.SetNodeTarget (self.ClickIcon, keep)
	end
end

--------
-- Generic icon goto

function RDXMAP.Map:GMenu_OnPasteLink()

	--local name

	--if self.ClickType == 3001 then
	--	if Nx and Nx.Social then
	--		name = Nx.Social:GetPunkPasteInfo (self.ClickIcon)
	--	end
	--else
	--	local icon = self.ClickIcon
	--	name = gsub (icon.Tip, "\n", ", ")
	--end

	--name = gsub (name, "|cff......", "")
	--name = gsub (name, "|r", "")

	--local frm = DEFAULT_CHAT_FRAME
	--local eb = frm["editBox"]
	--if eb:IsVisible() then
	--	eb:SetText (eb:GetText() .. name)
	--else
	--	VFL.vprint ("No edit box open!")
	--end
end

--------
-- Send BG messages

function RDXMAP.Map:BGMenu_OnIncoming (item)
	self:BGMenu_Send (NXlBGMsgIncoming)
end

function RDXMAP.Map:BGMenu_OnClear (item)
	self:BGMenu_Send ("Clear")
end

function RDXMAP.Map:BGMenu_OnHelp (item)
	self:BGMenu_Send ("Help")
end

function RDXMAP.Map:BGMenu_OnAttack (item)
	self:BGMenu_Send ("Attack")
end

function RDXMAP.Map:BGMenu_OnGuard (item)
	self:BGMenu_Send ("Guard")
end

function RDXMAP.Map:BGMenu_OnLosing (item)
	self:BGMenu_Send ("Losing")
end

--------
-- BG icon status

function RDXMAP.Map:BGMenu_OnStatus (item)

	local id, x, y, str = strsplit ("~", self.BGMsg)
	if id == "1" then
		self:BGMenu_Send()
--		SendChatMessage (str, "BATTLEGROUND")
	else
		VFL.vprint ("No Status")
	end
end

--------
-- BG icon status

function RDXMAP.Map:BGMenu_Send (msg)

	local myunit = RDXDAL.GetMyUnit();

	local id, tx, ty, str = strsplit ("~", self.BGMsg)
	tx, ty = RDXMAP.APIMap.GetWorldPos (myunit.mapId, tonumber (tx), tonumber (ty))

	local members = MAX_PARTY_MEMBERS
	local unitName = "party"

	if IsInRaid() then
		members = MAX_RAID_MEMBERS
		unitName = "raid"
	end

	local cnt = 0
	local maxDist = (100 / 4.575) ^ 2	-- Yards to world space squared

	for i = 1, members do

		local unit = unitName..i
		local pX, pY = GetPlayerMapPosition (unit)

		if (pX > 0 or pY > 0) and not UnitIsDeadOrGhost (unit) then

			local x, y = RDXMAP.APIMap.GetWorldPos (myunit.mapId, pX * 100, pY * 100)
			local dist = (tx - x) ^ 2 + (ty - y) ^ 2

--			VFL.vprint ("%s %s %s = %s", unit, pX, pY, sqrt (dist) * 4.575)

			if dist <= maxDist then
				cnt = cnt + 1
--				VFL.vprint (" %s", UnitName (unit))
			end
		end
	end

	local dstr = ", No "
	if cnt > 0 then
		dstr = format (", %d ", cnt)
	end

	dstr = dstr .. RDX.PlFactionShort .. " in area"

	if msg then
		SendChatMessage (msg .. " - " .. str .. dstr, "INSTANCE_CHAT")
	else
		SendChatMessage (str .. dstr, "INSTANCE_CHAT")
	end

--	VFL.vprint ("count %d", cnt)
--	VFL.vprint (msg .. " - " .. str .. dstr)
end