-- MainPanel.lua
-- OpenRDX
-- New Main Panel

-- mainbuttondb : first line of button
-- buttondb : second line of button

local mainbuttondb, buttondb = {}, {};
local sortedmb, sortedb = {}, {};

RDXPM.CompactMenu = RDXPM.Menu:new();

------------------------
-- "MINIMIZED" RDX ICON
------------------------
local miniPane = nil;

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = "RDX";
	ent.notCheckable = true;
	ent.isTitle = true;
	ent.color = _yellow;
	ent.justifyH = "CENTER";
end);

--RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Quick Options");
--	ent.notCheckable = true;
--	ent.hasArrow = true;
--	ent.keepShownOnClick = false;
--	ent.menuList = {
		--{ text = VFLI.i18n("Tutorial RDX"), notCheckable = true, func = function() RDX.NewLearnWizard(); end },
		--{ text = VFLI.i18n("Global Scale"), notCheckable = true, func = RDXDK.GlobalScaleDialog },
		--{ text = VFLI.i18n("Package Explorer"), notCheckable = true, func = RDXDB.ToggleObjectBrowser },
		--{ text = VFLI.i18n("Package Updater"), notCheckable = true, func = RDXDB.ToggleRAU },
--		{ text = VFLI.i18n("Switch Talent"), notCheckable = true, func = function() 
--			local index = GetActiveSpecGroup();
--			if index == 1 then index = 2; else index = 1; end
--			SetActiveTalentGroup(index); 
--			end 
--		},
--	};
--end);

RDXPM.AUIMenu = RDXPM.Menu:new();
RDXPM.CompactMenu:RegisterMenuEntry(VFLI.i18n("Themes"), true, function(tree, frame) RDXPM.AUIMenu:Open(tree, frame); end)

RDXPM.DkStateMenu = RDXPM.Menu:new();
RDXPM.DkStateMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Solo");
	ent.func = function() VFL.poptree:Release(); DesktopEvents:Dispatch("DESKTOP_STATE", "SOLO"); RDX.SetRDXColor(1,1,1); end 
end);
RDXPM.DkStateMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Party");
	ent.func = function() VFL.poptree:Release(); DesktopEvents:Dispatch("DESKTOP_STATE", "PARTY"); RDX.SetRDXColor(1,0,1); end 
end);
RDXPM.DkStateMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Raid");
	ent.func = function() VFL.poptree:Release(); DesktopEvents:Dispatch("DESKTOP_STATE", "RAID"); RDX.SetRDXColor(0,1,0); end 
end);
RDXPM.DkStateMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Battleground");
	ent.func = function() VFL.poptree:Release(); DesktopEvents:Dispatch("DESKTOP_STATE", "BATTLEGROUND"); RDX.SetRDXColor(0,1,1); end 
end);
RDXPM.DkStateMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Arena");
	ent.func = function() VFL.poptree:Release(); DesktopEvents:Dispatch("DESKTOP_STATE", "ARENA"); RDX.SetRDXColor(1,1,0); end 
end);

RDXPM.CompactMenu:RegisterMenuEntry(VFLI.i18n("State"), true, function(tree, frame) RDXPM.DkStateMenu:Open(tree, frame); end)
--RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Themes");
--	ent.notCheckable = true;
--	ent.hasArrow = true;
--	ent.keepShownOnClick = false;
--	ent.menuList = RDXPM.subMenus;
--end);



------------------------------------------------------------------------------
-- KEY BINDINGS
------------------------------------------------------------------------------
local dfkey
local function ToggleKeyBindings()
	if not InCombatLockdown() then 
		if dfkey then
			DesktopEvents:Dispatch("DESKTOP_LOCK_BINDINGS");
			dfkey = nil;
		else
			DesktopEvents:Dispatch("DESKTOP_UNLOCK_BINDINGS");
			dfkey = true;
		end
	end
end

RDXPM.KeyBindingsMenu = RDXPM.Menu:new();
RDXPM.KeyBindingsMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Configure keys");
	ent.checked = function() return dfkey; end;
	ent.func = function() VFL.poptree:Release(); ToggleKeyBindings(); end 
end);
RDXPM.CompactMenu:RegisterMenuEntry(VFLI.i18n("Key Bindings"), true, function(tree, frame) RDXPM.KeyBindingsMenu:Open(tree, frame); end)

------------------------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------------------------

RDXPM.SettingsMenu = RDXPM.Menu:new();
--RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Main Panel");
--	ent.checked = function() return not RDXPM.IsPanelHidden(); end;
--	ent.func = function() VFL.poptree:Release(); RDXPM.ToggleHidePanel(); end 
--end);
RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("RDX Settings");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXPM.ToggleRDXManage(); end 
end);
RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Chatframe Settings");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); CURRENT_CHAT_FRAME_ID = 1; ShowUIPanel(ChatConfigFrame); end 
end);
RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Show/Hide RDX UI");
	ent.checked = RDXDK.IsRDXHidden;
	ent.func = function() VFL.poptree:Release(); RDXDK.ToggleRDX(); end 
end);
RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Mini Panel Default");
	ent.checked = function() if RDX.GetRDXIconType() == "default" then return true; else return nil; end end;
	ent.func = function() VFL.poptree:Release(); RDX.ToggleRDXIcon("default"); DesktopEvents:Dispatch("DESKTOP_RDXICON_TYPE", "default", true); end 
end);
RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Mini Panel Powered");
	ent.checked = function() if RDX.GetRDXIconType() == "poweredbyrdx" then return true; else return nil; end end;
	ent.func = function() VFL.poptree:Release(); RDX.ToggleRDXIcon("poweredbyrdx"); DesktopEvents:Dispatch("DESKTOP_RDXICON_TYPE", "poweredbyrdx", true); end 
end);
RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Clean Icons (Addon Required)");
	ent.checked = RDX.UseCleanIcons;
	ent.func = function() VFL.poptree:Release(); RDX.ToggleCleanIcons(); end 
end);
--RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
--	ent.text = "*************";
--	ent.isTitle = true;
--	ent.color = _yellow;
--	ent.notCheckable = true;
--	ent.func = VFL.Noop;
--end);
--RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Launch Themes Installer");
--	ent.notCheckable = true;
--	ent.func = function() VFL.poptree:Release(); RDX.StartInstaller(true); end 
--end);
--RDXPM.SettingsMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Uninstall Themes");
--	ent.notCheckable = true;
--	ent.func = function() VFL.poptree:Release(); RDXDB.DeleteThemes(); end 
--end);

RDXPM.CompactMenu:RegisterMenuEntry(VFLI.i18n("Settings"), true, function(tree, frame) RDXPM.SettingsMenu:Open(tree, frame); end)

------------------------------------------------------------------------------
-- DEBUG
------------------------------------------------------------------------------

RDXPM.DebugMenu = RDXPM.Menu:new();
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = "**** Blizzard ****";
	ent.isTitle = true;
	ent.color = _yellow;
	ent.notCheckable = true;
	ent.func = VFL.Noop;
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Show Release Corps Button");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); StaticPopup_Show("DEATH"); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Reset Blizzard Chatframes");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); DEFAULT_CHAT_FRAME = ChatFrame1; FCF_ResetChatWindows(); ReloadUI(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = "**** RDX ****";
	ent.isTitle = true;
	ent.color = _yellow;
	ent.notCheckable = true;
	ent.func = VFL.Noop;
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Open Set Debugger");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXM_Debug.SetDebugger(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Open Profiler");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); VFLP.ToggleProfiler(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Open ErrorDialog");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); VFL.ToggleErrorDialog(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Open Console");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); VFL.ToggleConsoleDialog(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Fire Disrupt Signal");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDX._Disrupt(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Fire Roster Update Signal");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDX._Roster(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Reset Editor Layout");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXPM.ResetLayouts(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Garbage Collect");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); VFLGC(); end 
end);
--RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Fake Roster Units");
--	ent.checked = RDXDAL.IsDummy;
--	ent.func = function() VFL.poptree:Release(); RDXEvents:Dispatch("ROSTER_DUMMY"); end 
--end);
--RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Store Compiled Code");
--	ent.checked = RDXM_Debug.IsStoreCompilerActive;
--	ent.func = function() VFL.poptree:Release(); RDXM_Debug.ToggleStoreCompiler(); end 
--end);
--RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Party with me");
--	ent.checked = RDXM_Debug.IsPartyIncludeMe;
--	ent.func = function() VFL.poptree:Release(); RDXM_Debug.TogglePartyIncludeMe(); end 
--end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Wipe CooldownDB");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXCD.WipeCooldownDB(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Print CooldownDB");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXCD.DebugCooldownDB(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Enable Debug Map Menu");
	ent.checked = function() return RDXG.DebugMap; end;
	ent.func = function() VFL.poptree:Release(); RDXG.DebugMap = not RDXG.DebugMap; end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Enable LootOn");
	ent.checked = function() return RDXG.LootOn; end;
	ent.func = function() VFL.poptree:Release(); RDXG.LootOn = not RDXG.LootOn; end 
end);
--[[RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = "**** Packages ****";
	ent.isTitle = true;
	ent.color = _yellow;
	ent.notCheckable = true;
	ent.func = VFL.Noop;
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Backup Packages");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXDB.BackupPackages(); end 
end);
RDXPM.DebugMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Restore Packages");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXDB.RestorePackages(); end 
end);
]]

RDXPM.CompactMenu:RegisterMenuEntry(VFLI.i18n("Debugging"), true, function(tree, frame) RDXPM.DebugMenu:Open(tree, frame); end)

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = "**************";
	ent.isTitle = true;
	ent.color = _yellow;
	ent.notCheckable = true;
	ent.func = VFL.Noop;
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Package Explorer");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXDB.ToggleObjectBrowser(); end;
end);

--[[
RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Favoris");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); if Nx and Nx.Fav then Nx.Fav:ToggleShow(); end end;
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Quests Explorer");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXMAP.ToggleQuestsPanel(); end;
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Guide Explorer");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDXMapEvents:Dispatch("Guide:ToggleShow"); end;
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Warehouse");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); if Nx and Nx.Warehouse then Nx.Warehouse:ToggleShow(); end end;
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Combat");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); if Nx and Nx.Combat then Nx.Combat:Open(); end end;
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("UEvents");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); if Nx and Nx.UEvents then Nx.UEvents.List:Open(); end end;
end);
]]
RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Window Wizard");
	ent.notCheckable = true;
	ent.func = function() VFL.poptree:Release(); RDX.NewWindowWizard(); end;
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = "**************";
	ent.isTitle = true;
	ent.color = _yellow;
	ent.notCheckable = true;
	ent.func = VFL.Noop;
	end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Reload UI");
	ent.notCheckable = true;
	ent.func = VFLReloadUI;
end);

local function CreateMiniPane()
	local mini = VFLUI.AcquireFrame("Button");
	mini:SetParent(VFLDIALOG); 
	--mini:SetScale(Minimap:GetEffectiveScale() / RDXParent:GetEffectiveScale());
	mini:SetMovable(true);
	mini:SetPoint("CENTER", RDXParent, "CENTER");
	mini:SetClampedToScreen(true);
	mini:Show();
	
	local tx1 = VFLUI.CreateTexture(mini);
	tx1:SetPoint("TOPLEFT", mini, "TOPLEFT"); tx1:SetWidth(56); tx1:SetHeight(56);
	tx1:SetDrawLayer("OVERLAY");
	tx1:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder"); tx1:Show();
	
	local tx2 = VFLUI.CreateTexture(mini);
	tx2:SetPoint("CENTER", mini, "CENTER"); tx2:SetHeight(24); tx2:SetWidth(24);
	tx2:SetDrawLayer("BACKGROUND");
	tx2:SetTexture("Interface\\Addons\\RDX\\Skin\\mmbtn"); tx2:Show();
	
	local txtpower = VFLUI.CreateFontString(mini);
	txtpower:SetPoint('LEFT',mini,'LEFT', 0, 0);
	txtpower:SetWidth(80); txtpower:SetHeight(20);
	txtpower:SetFont("Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Acme7W.ttf", 8);
	txtpower:SetShadowOffset(1,-1);
	txtpower:SetShadowColor(0,0,0,1);
	txtpower:SetText("Powered by");
	txtpower:SetJustifyH("LEFT"); txtpower:SetJustifyV("BOTTOM");
	txtpower:Show();
	
	local txtrdx = VFLUI.CreateFontString(mini);
	txtrdx:SetPoint('LEFT',mini,'LEFT', 80, -4);
	txtrdx:SetWidth(70); txtrdx:SetHeight(20);
	txtrdx:SetFont("Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Adventure.ttf", 20);
	txtrdx:SetShadowOffset(1,-1);
	txtrdx:SetShadowColor(0,0,0,1);
	txtrdx:SetJustifyH("LEFT"); txtrdx:SetJustifyV("BOTTOM");
	txtrdx:SetText("RDX10");
	txtrdx:Show();
	
	local mtxtsave = nil;
	
	-- function main panel layout
	function mini:Layout(x, y)
		if x and y then
			mini:ClearAllPoints();
			VFLUI.SetAnchorFramebyPosition(mini, "BOTTOMLEFT", x, nil, nil, y);
		else
			mini:ClearAllPoints();
			mini:SetPoint("CENTER", RDXParent, "CENTER");
		end
	end
	
	function mini:SetColor(r,g,b)
		txtpower:SetTextColor(r,g,b,1);
		txtrdx:SetTextColor(r,g,b,1);
	end
	
	function mini:SetIcon(mtxt)
		if mtxt == "poweredbyrdx"  then
			mtxtsave = mtxt;
			mini:SetHighlightTexture("");
			mini:SetHeight(20); mini:SetWidth(130);
			tx1:Hide();
			tx2:Hide();
			txtpower:Show();
			txtrdx:Show();
		elseif mtxt == "default" then
			mtxtsave = mtxt;
			mini:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
			mini:SetHeight(32); mini:SetWidth(32);
			tx1:Show();
			tx2:Show();
			txtpower:Hide();
			txtrdx:Hide();
		end
	end
	
	function mini:GetMtxt()
		return mtxtsave;
	end
	
	--mini:SetScript("OnEnter", function(self)
	--	GameTooltip:SetOwner(self, "ANCHOR_NONE");
	--	GameTooltip:SetPoint("BOTTOMLEFT", self, anchor, 0, 20);
	--	GameTooltip:ClearLines();
	--	GameTooltip:AddDoubleLine("Tips", "Use the key Shift to drag this button");
	--	GameTooltip:Show();
	--end);
	
	--mini:SetScript("OnLeave", function(self)
	--	GameTooltip:Hide();
	--end);
	
	local mmvg = nil;
	local shiftRight = nil;
	mini:SetScript("OnMouseDown", function(self, arg1)
		if (arg1 == "LeftButton") then
			if (IsShiftKeyDown()) then
				mmvg = true;
				mini:StartMoving();
				return;
			end
		elseif (arg1 == "RightButton") then
			if not InCombatLockdown() then
				if IsShiftKeyDown() then
					RDXDB.ToggleObjectBrowser();
				else
					local curdesk = RDXDK.GetCurrentDesktop();
					if curdesk then
						RDXDK.ToggleDesktopTools(VFLFULLSCREEN_DIALOG, curdesk:_GetFrameProps("root"));
					end
				end
			end
		end
	end);
	
	mini:SetScript("OnMouseUp", function(self, arg1)
		if mmvg then
			mmvg = nil;
			mini:StopMovingOrSizing();
			local anchorx,_,_,anchory = VFLUI.GetUniversalBoundary(mini);
			DesktopEvents:Dispatch("DESKTOP_RDXICON_POSITION", anchorx, anchory, true);
			return;
		end
		if(arg1 == "LeftButton") then
			VFL.poptree:Begin(220, 12, mini, relpoint, VFLUI.GetRelativeLocalMousePosition(mini));
			RDXPM.CompactMenu:Open(VFL.poptree, nil, nil, "TOPLEFT", 0, 0, nil);
		end
	end);
	
	return mini;
end

function RDX.SetRDXIconLocation(anchorx, anchory, mtxt)
	miniPane:Layout(anchorx, anchory, mtxt);
end

function RDX.GetRDXIconType()
	return miniPane:GetMtxt();
end

function RDX.ToggleRDXIcon(mtxt)
	miniPane:SetIcon(mtxt);
end

function RDX.SetRDXColor(r,g,b)
	miniPane:SetColor(r,g,b);
end

-- clean icon used

function RDX.ToggleCleanIcons()
	if not RDXG.usecleanicons then
		RDXG.usecleanicons = true;
	else
		RDXG.usecleanicons = nil;
	end
	ReloadUI();
end

function RDX.UseCleanIcons()
	return RDXG.usecleanicons;
end

------------
-- INIT
-- Create the menu pane and show all buttons
----------------------------------------------
RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()	
	-- Mini Panel
	miniPane = CreateMiniPane();
	miniPane:Layout();
	miniPane:SetIcon("default");
	if RDXU.currentstate == "SOLO" then
		miniPane:SetColor(1,1,1);
	elseif RDXU.currentstate == "PARTY" then
		miniPane:SetColor(1,0,1);
	elseif RDXU.currentstate == "RAID" then
		miniPane:SetColor(0,1,0);
	elseif RDXU.currentstate == "BATTLEGROUND" then
		miniPane:SetColor(0,1,1);
	elseif RDXU.currentstate == "ARENA" then
		miniPane:SetColor(1,1,0);
	end

	--[[
	local btn = VFLUI.Button:new();
	btn:SetHeight(30); btn:SetWidth(100);
	btn:SetText(VFLI.i18n("Menu"));
	btn:SetClampedToScreen(true);
	btn:SetFrameStrata("FULLSCREEN_DIALOG");
	btn:Show();
	btn:ClearAllPoints();
	btn:SetPoint("CENTER", RDXParent, "CENTER");
	if RDXPM.Ismanaged("MenuBar") then RDXPM.RestoreLayout(btn, "MenuBar"); end
	btn:SetMovable(true);
	
	UpdateMicroButtonsParent(btn)
	MoveMicroButtons("TOPLEFT", btn, "TOPLEFT", 10, 25)
	
	btn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	btn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing(); RDXPM.StoreLayout(btn, "MenuBar"); end);
	
	MoveMicroButtons = VFL.Noop;
	UpdateMicroButtonsParent = VFL.Noop;
	]]
end);

function RDXPM.GetMiniPane() return miniPane; end