-- Encounters.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- The RDX encounter system.

---------------------------------------------
-- Encounter internal variables
---------------------------------------------
local encTimer = VFLT.CountUpTimer:new();
local encPane = nil;
local mouseoverMap = {};

---------------------------------------------
-- ENCOUNTER DATABASE
---------------------------------------------
local edb, ce = {}, nil;

-- Encounter category menus.
local ecats = {};
ecats[""] = {};
local _submenu_color = {r=0.2, g=0.9, b=0.9};
local function EncounterCatMenu(menu, cell, category)
	if not ecats[category] then menu:Release(); return; end
	menu:Expand(cell, ecats[category]);
end

local function MakeCatHierarchy(cat)
	if not ecats[cat] then
		local _,_,pcat,thiscat = string.find(cat, "^(.*)%/([^%/]*)$");
		if not pcat then pcat = ""; thiscat = cat; end
		if not ecats[pcat] then MakeCatHierarchy(pcat); end 
		table.insert(ecats[pcat], 1, {
			text = thiscat; color = _submenu_color; hasArrow = true;
			sort = -1;
			func = function(self) EncounterCatMenu(VFL.poptree, self, cat); end;
		});
		ecats[cat] = {};
	end
end

--- Register an encounter in the RDX encounter database.
-- @field name The name of the encounter.
-- @field title A text title for the encounter.
-- @field category A string category for the encounter. Hierarchical subcategories can be added by using "/" separators.
-- @field sort An integer used in table.sort to sort the encounter list.
function RDX.RegisterEncounter(tbl)
	if type(tbl) ~= "table" then error("expected table"); end
	if type(tbl.name) ~= "string" then error("bad or missing encounter name"); end
	if type(tbl.title) ~= "string" then error("bad or missing encounter title"); end
	if type(tbl.category) ~= "string" then tbl.category = ""; end

	local name = tbl.name;

	if edb[name] then
		-- Duplicate encounter registration.
		-- Check if it's the active encounter...
		if ce and (ce == edb[name]) then
			-- Stop and deactivate the encounter if it is the current encounter.
			RDX:Debug(1, "Replacing encounter <", name, "> in situ");
			RDX.StopEncounter(true); encTimer:Reset();
			if ce.DeactivateEncounter then ce.DeactivateEncounter(name); end
			-- Update the data
			VFL.copyOver(ce, tbl);
			-- Reactivate the encounter on the next frame.
			-- This gives the dynamic bossmods time to initialize themselves.
			encPane:SetInfoBundle(ce.title, "", 1);
			if ce.ActivateEncounter then
				VFLT.schedule(.1, ce.ActivateEncounter, name, name);
			end
		else
			-- Just update the data
			VFL.copyOver(edb[name], tbl);
		end
	else
		-- Non-duplicate encounter
		-- Add the data
		edb[name] = tbl;
		-- Categorize the encounter; find its parent category.
		local cat = tbl.category;
		-- Create category related structures
		MakeCatHierarchy(cat);
		-- Add it to the menu for its category
		table.insert(ecats[cat], {
			text = tbl.title;
			name = name;
			sort = tonumber(tbl.sort) or 0;
			func = function() VFL.poptree:Release(); RDX.SetActiveEncounter(name); end
		});
		table.sort(ecats[cat], function(x1,x2) return x1.sort < x2.sort; end);
	end
end

--- Remove an encounter previously added with RegisterEncounter.
function RDX.UnregisterEncounter(name)
	-- Sanity checks.
	if (name == "default") or (not edb[name]) then return; end;
	local cat = edb[name].category;

	-- swap to default if we're trying to unregister the current encounter
	if ce.name == name then RDX.SetActiveEncounter("default", true); end
	
	-- discard it from the menu
	VFL.filterInPlace(ecats[cat], function(x)
		if x.name == name then return false; else return true; end
	end);
	-- resort
	table.sort(ecats[cat], function(x1,x2) return x1.sort < x2.sort; end);

	-- remove from mouseover map
	for k,v in pairs(mouseoverMap) do if v == name then mouseoverMap[k] = nil; end	end

	-- remove from the database
	edb[name] = nil;
end


-- The default encounter
RDX.RegisterEncounter({name = "default"; title = "Default";});

--- Get the name of the currently-active encounter
function RDX.GetActiveEncounter()
	if not ce then return "default"; end
	return ce.name;
end

--- Change the currently-active encounter.
function RDX.SetActiveEncounter(en, nosync)
	if not en then error("Usage: RDX.SetActiveEncounter(encName, nosync)"); end
	if ce and ce.name == en then
		-- already set to this encounter
		return;
	end
	-- Check the new encounter
	RDX:Debug(2, "RDX.SetActiveEncounter(" .. en .. ")");
	if not edb[en] then
		RDX:Debug(1, "SetActiveEncounter(".. en .. "): invalid encounter");
		return nil;
	end
	-- Stop the existing encounter
	RDX.StopEncounter(nosync); encTimer:Reset();
	-- Deactivate the old encounter
	local olden = nil;
	if ce then 
		olden = ce.name;
		if ce.DeactivateEncounter then ce.DeactivateEncounter(olden); end
	end
	-- Switch to the new encounter.
	ce = edb[en];
	-- Update encounter pane
	encPane:SetInfoBundle(ce.title, "", 1);
	-- Invoke encounter's activate function
	if ce.ActivateEncounter then ce.ActivateEncounter(en, olden); end
	RDXEvents:Dispatch("ENCOUNTER_CHANGED", en, olden);
	-- Save the pref
	RDXU.active_encounter = en;
	-- Sync
	if (not nosync) then RDX.SyncEncounter(); end
	return true;
end

-----------------------------------------------
-- ENCOUNTER SYNC
-----------------------------------------------
--- Synchronize the current encounter
function RDX.SyncEncounter()
	local myunit = RDXDAL.GetMyUnit();
	if myunit:IsLeader() then
		RPC_Group:Flash("enc_set", RDX.GetActiveEncounter());
	end
end

RPC_Group:Bind("enc_set", function(ci, en) 
	if RPC.IsGroupLeader(ci) then
		RDX.SetActiveEncounter(en, true); 
	end
end);

---------------------------------------
-- SYNC TOOLBAR BUTTON
---------------------------------------
--[[local syncbtn = VFLUI.AcquireFrame("Button");
local sbtex = VFLUI.CreateTexture(syncbtn);
sbtex:SetAllPoints(syncbtn);
sbtex:Show();
syncbtn:SetHighlightTexture(sbtex);
sbtex:SetBlendMode("DISABLE");
if RDX._skin == "boomy" then
	syncbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\boomy\\refresh");
	sbtex:SetTexture("Interface\\Addons\\RDX\\Skin\\boomy\\refresh");
elseif RDX._skin == "kids" then
	syncbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\kids\\k-services");
	sbtex:SetTexture("Interface\\Addons\\RDX\\Skin\\kids\\k-services");
else
	syncbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\sync");
	sbtex:SetTexture("Interface\\Addons\\RDX\\Skin\\sync");
end
sbtex:SetVertexColor(0, 0.8, 1);
syncbtn:RegisterForClicks("LeftButtonUp", "RightButtonUp");

syncbtn:SetScript("OnClick", function(self, arg1)
	if(arg1 == "LeftButton") then
		RDX.SyncEncounter();
	elseif(arg1 == "RightButton") then

	end
end);

--RDXEvents:Bind("INIT_PRELOAD", nil, function() RDX.AddToolbarButton(syncbtn, true); end);
]]

---------------------------------------------
-- START/STOP
---------------------------------------------
local playbtn = VFLUI.AcquireFrame("Button");
local phtex = VFLUI.CreateTexture(playbtn);
phtex:SetAllPoints(playbtn);
phtex:Show();
playbtn:SetHighlightTexture(phtex);
phtex:SetBlendMode("DISABLE");

local function PlayBtn_SetPlay()
	if RDX._skin == "boomy" then
		playbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\boomy\\play");
		phtex:SetTexture("Interface\\Addons\\RDX\\Skin\\boomy\\play");
	elseif RDX._skin == "kids" then
		playbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\kids\\click-n-run");
		phtex:SetTexture("Interface\\Addons\\RDX\\Skin\\kids\\click-n-run");
	else
		playbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\play");
		phtex:SetTexture("Interface\\Addons\\RDX\\Skin\\play");
	end
	phtex:SetVertexColor(0, 0.8, 0);
end
local function PlayBtn_SetStop()
	if RDX._skin == "boomy" then
		playbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\boomy\\stop");
		phtex:SetTexture("Interface\\Addons\\RDX\\Skin\\boomy\\stop");
	elseif RDX._skin == "kids" then
		playbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\kids\\agt-resume");
		phtex:SetTexture("Interface\\Addons\\RDX\\Skin\\kids\\agt-resume");
	else
		playbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\stop");
		phtex:SetTexture("Interface\\Addons\\RDX\\Skin\\stop");
	end
	phtex:SetVertexColor(0.8, 0, 0);
end

PlayBtn_SetPlay();

--- Stop the encounter if it's running, or start it if it isn't.
function RDX.StartOrStopEncounter()
	if encTimer:IsRunning() then RDX.StopEncounter(); else RDX.StartEncounter(); end
end

-- On click of the play button, start or stop
playbtn:SetScript("OnClick", RDX.StartOrStopEncounter);

--- Return TRUE iff the current encounter is running, nil otherwise.
function RDX.EncounterIsRunning()
	return encTimer:IsRunning();
end

--- Start the current encounter.
function RDX.StartEncounter(nosync)
	local ename = RDX.GetActiveEncounter();
	if encTimer:IsRunning() then return; end
	local myunit = RDXDAL.GetMyUnit();
	if (not nosync) and (myunit:IsLeader()) then
		RPC_Group:Flash("enc_start", ename);
	end
	PlayBtn_SetStop(); encTimer:Reset(); encTimer:Start();
	-- Inform the encounter that it's been started.
	if ce and ce.StartEncounter then
		ce.StartEncounter();
	end
	RDXEvents:Dispatch("ENCOUNTER_STARTED", ename);
end
-- Remote start request hdlr
RPC_Group:Bind("enc_start", function(ci, enc)
	if RPC.IsGroupLeader(ci) and (enc == RDX.GetActiveEncounter()) then 
		RDX.StartEncounter(true); 
	end
end);

--- Stop the current encounter.
function RDX.StopEncounter(nosync)
	local ename = RDX.GetActiveEncounter();
	PlayBtn_SetPlay();
	local myunit = RDXDAL.GetMyUnit();
	-- Synchronize encounter stop
	if (not nosync) and (myunit:IsLeader()) then
		RPC_Group:Flash("enc_stop", ename);
	end
	-- Stop the encounter if it was started.
	if(encTimer:IsRunning()) then
		encTimer:Stop();
		if ce and ce.StopEncounter then
			ce.StopEncounter();
		end
		RDXEvents:Dispatch("ENCOUNTER_STOPPED", ename);
	end
end
-- Remote stop request hdlr
RPC_Group:Bind("enc_stop", function(ci, enc)
	if RPC.IsGroupLeader(ci) and (enc == RDX.GetActiveEncounter()) then 
		RDX.StopEncounter(true); 
	end
end);

----------------------------------------
-- ENCOUNTER STOP when change
----------------------------------------

WoWEvents:Bind("ZONE_CHANGED_NEW_AREA", nil, function()
	if encTimer:IsRunning() then RDX.StopEncounter(false); end
end);

----------------------------------------
-- MOUSEOVER ENCOUNTER SWITCHING
----------------------------------------
function RDX.RegisterMouseoverEncounterTrigger(target, encid)
	if type(target) ~= "string" or type(encid) ~= "string" then return; end
	mouseoverMap[target] = encid;
end

WoWEvents:Bind("UPDATE_MOUSEOVER_UNIT", nil, function()
	local n = UnitName("mouseover"); if not n then return; end
	if UnitHealth("mouseover") < 2 then return; end -- Don't proc off dead bosses...
	if mouseoverMap[n] then
		RDX.SetActiveEncounter(mouseoverMap[n]);
	end
end);


----------------------------------------
-- ENCOUNTER MENU
----------------------------------------
-- Show the dropdown encounter menu
local function ShowEncounterMenu(frame)
	-- Show the menu
	VFL.poptree:Begin(160, 14, frame);
	EncounterCatMenu(VFL.poptree, nil, "")
end

----------------------------------------
-- THE MAIN ENCOUNTER PANE
----------------------------------------
function RDX.CreateEncPane()
	local s = VFLUI.AcquireFrame("Frame");
	s:SetParent("RDXParent"); s:Hide();
	s:SetHeight(44); s:SetWidth(230); s:SetMovable(true);
	s:SetBackdrop(VFLUI.BorderlessDialogBackdrop);

	-- Divider
	local tx1 = VFLUI.CreateTexture(s);
	tx1:SetDrawLayer("ARTWORK");
	tx1:SetTexture("Interface\\TradeSkillFrame\\UI-TradeSkill-SkillBorder");
	tx1:SetTexCoord(0.1, 0.5, 0, 0.25);
	tx1:SetPoint("TOPLEFT", s, "TOPLEFT", 2, -17);
	tx1:SetPoint("BOTTOMRIGHT", s, "TOPRIGHT", -2, -25);
	tx1:Show();
	
	-- Divider
	--local tx2 = VFLUI.CreateTexture(s);
	--tx2:SetDrawLayer("ARTWORK");
	--tx2:SetTexture("Interface\\TradeSkillFrame\\UI-TradeSkill-SkillBorder");
	--tx2:SetTexCoord(0.1, 0.5, 0, 0.25);
	--tx2:SetPoint("TOPLEFT", s, "TOPLEFT", 2, -40);
	--tx2:SetPoint("BOTTOMRIGHT", s, "TOPRIGHT", -2, -48);
	--tx2:Show();

	-- Topbar
	local tBtn = VFLUI.AcquireFrame("Button");
	tBtn:SetParent(s); tBtn:SetFrameLevel(5);
	tBtn:SetHeight(18);
	tBtn:SetPoint("TOPLEFT", s, "TOPLEFT", 2, -2);
	tBtn:Show();

	local tBar = VFLUI.AcquireFrame("StatusBar");
	tBar:SetFrameLevel(10);
	tBar:EnableKeyboard(nil); tBar:EnableMouse(nil); tBar:EnableMouseWheel(nil);
	tBar:SetParent(s); tBar:SetAllPoints(tBtn);
	tBar:SetMinMaxValues(0,1); tBar:SetValue(1);
	tBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
	tBar:Show();

	local tTxtLeft = VFLUI.CreateFontString(tBtn);
	tTxtLeft:SetFontObject(Fonts.Default); tTxtLeft:SetHeight(12);
	tTxtLeft:SetJustifyH("LEFT");
	tTxtLeft:SetPoint("LEFT", tBtn, "LEFT");
	tTxtLeft:Show();

	local tTxtRight = VFLUI.CreateFontString(tBtn);
	tTxtRight:SetFontObject(Fonts.Default10); tTxtRight:SetHeight(10);
	tTxtRight:SetJustifyH("RIGHT");
	tTxtRight:SetPoint("RIGHT", tBtn, "RIGHT");
	tTxtRight:Show();

	function s:GetInfoBundle()
		return tTxtLeft, tTxtRight, tBar, tBtn;
	end

	function s:SetInfoBundle(ltxt, rtxt, frac, c0, c1)
		if not frac then frac=1; end
		if not c0 then c0 = _blue; end
		if not c1 then c1 = c0; end
		tTxtLeft:SetText(ltxt);
		tTxtRight:SetText(rtxt);
		frac = VFL.clamp(frac, 0, 1);
		tBar:SetValue(frac);
		tempcolor:blend(c0, c1, frac);
		tBar:SetStatusBarColor(VFL.explodeColor(tempcolor));
	end

	-- Timer widget
	local tmr = VFLUI.TimerWidget:new(s);
	tmr:SetPoint("TOPLEFT", s, "TOPLEFT", 5, -25);
	tmr:SetWidth(70); tmr:SetHeight(16); tmr:Show();
	tmr:SetScript("OnUpdate", function(self) self:SetTime(encTimer:Get()); end);

	-- Click handlers
	--tBtn:SetScript("OnMouseDown", function(self, arg1)
	--	if(arg1 == "LeftButton") and IsShiftKeyDown() then
	--		encPane:WMDrag();
	--	end
	--end);
	tBtn:SetScript("OnMouseUp", function(self, arg1)
		if(arg1 == "LeftButton") then 
			encPane:WMStopDrag();
		elseif(arg1 == "RightButton") then
			ShowEncounterMenu(self);
		end
	end);

	-- Toolbar
	local tbw, lastBtn, btns = 0, nil, {};

	function s:AddToolbarButton(btn, autoWidth)
		btn:SetParent(self);
		btn:SetHeight(16); if autoWidth then btn:SetWidth(16); end
		if lastBtn then
			btn:SetPoint("LEFT", lastBtn, "RIGHT");
		else
			btn:SetPoint("LEFT", tmr, "RIGHT");
		end
		lastBtn = btn;
		table.insert(btns, btn);
		tbw = tbw + btn:GetWidth();
		btn:Show();
		self:SetWidth(math.max(230, tbw + 74));
	end

	local function Layout()
		tBtn:SetWidth(math.max(s:GetWidth() - 4, 0));
		tTxtRight:SetWidth(50);
		tTxtLeft:SetWidth(s:GetWidth() - 50);
	end
	s:SetScript("OnShow", Layout);
	s:SetScript("OnSizeChanged", Layout);
	
	-- desktop
	--local tTxtBtLeft = VFLUI.CreateFontString(s);
	--tTxtBtLeft:SetFontObject(Fonts.Default10); tTxtBtLeft:SetHeight(12);
	--tTxtBtLeft:SetJustifyH("CENTER");
	--tTxtBtLeft:SetJustifyV("CENTER");
	--tTxtBtLeft:SetPoint("TOPLEFT", s, "TOPLEFT" , 2, -48);
	--tTxtBtLeft:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT" , -2, 6);
	--tTxtBtLeft:Show();
	
	--function s:SetDesktopName(desktxt)
	--	tTxtBtLeft:SetText(desktxt);
	--end

	s.Destroy = VFL.hook(function(s2)
		VFLUI.ReleaseRegion(tx1); tx1 = nil;
		--VFLUI.ReleaseRegion(tx2); tx2 = nil;
		VFLUI.ReleaseRegion(tTxtLeft); tTxtLeft = nil;
		VFLUI.ReleaseRegion(tTxtRight); tTxtRight = nil;
		tBar:Destroy(); tBar = nil;
		tBtn:Destroy(); tBtn = nil;
		for _,b in btns do b:Destroy(); end; btns = nil; lastBtn = nil;
		s.AddToolbarButton = nil; s.GetInfoBundle = nil;
	end, s.Destroy);

	s:AddToolbarButton(playbtn, true);

	return s;
end

-- Create the encounter pane
encPane = RDX.CreateEncPane();

local flagep = nil;
function RDX.GetEncounterPane() flagep = true; return encPane;  end
function RDX.ReleaseEncounterPane() encPane:Hide(); flagep = nil; end

function RDX.IsEncounterPaneShow1() return flagep; end

-- Add a button to the RDX Encounter Pane toolbar. If the setWidth argument
-- is true, autosets the width of the button.
function RDX.AddToolbarButton(btn, setWidth)
	encPane:AddToolbarButton(btn, setWidth);
end

-- Set the desktop name
function RDX.EncSetDesktopName(desktxt)
	--encPane:SetDesktopName(desktxt);
end

local function OpenEncounterPane()
	encPane:Show();
end

local function CloseEncounterPane()
	encPane:Hide();
end

function RDX.IsEncounterPaneShow()
	if RDXU.encounter then return true; else return nil; end
		
end

function RDX.ToggleEncounterPane()
	if RDXU.encounter then
		RDX.printI(VFLI.i18n("Bossmod encounter disabled"));
		RDXU.encounter = nil;
		--RDXDK._CloseWindowRDX("desktop_bossmod");
		RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, "desktop_bossmod");
	else
		RDX.printI(VFLI.i18n("Bossmod encounter enabled"));
		RDXU.encounter = true;
		--RDXDK._OpenWindowRDX("desktop_bossmod");
		RDXDK.QueueLockdownAction(RDXDK._OpenWindowRDX, "desktop_bossmod");
	end
end

------------------------
-- INIT
------------------------
-- After the window manager is loaded, we can register the encpane and show it
RDXEvents:Bind("INIT_POST", nil, function()
	-- Restore the last selected encounter.
	-- If the encounter is invalid, revert to default.
	if (not RDXU.active_encounter) or (not edb[RDXU.active_encounter]) then 
		RDXU.active_encounter = "default"; 
	end
	RDX.SetActiveEncounter(RDXU.active_encounter, true);

end);


