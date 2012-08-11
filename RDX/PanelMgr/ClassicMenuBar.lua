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
	ent.justifyH = "CENTER";
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Quick Options");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.keepShownOnClick = false;
	ent.menuList = {
		{ text = VFLI.i18n("Tutorial RDX"), notCheckable = true, func = function() RDX.NewLearnWizard(); end },
		--{ text = VFLI.i18n("Global Scale"), notCheckable = true, func = RDXDK.GlobalScaleDialog },
		{ text = VFLI.i18n("Package Explorer"), notCheckable = true, func = RDXDB.ToggleObjectBrowser },
		{ text = VFLI.i18n("Package Updater"), notCheckable = true, func = RDXDB.ToggleRAU },
		{ text = VFLI.i18n("Switch Talent"), notCheckable = true, func = function() 
			local index = GetActiveTalentGroup();
			if index == 1 then index = 2; else index = 1; end
			SetActiveTalentGroup(index); 
			end 
		},
		{ text = VFLI.i18n("Chatframe Manager"), notCheckable = true, func = function()
			CURRENT_CHAT_FRAME_ID = 1;
			ShowUIPanel(ChatConfigFrame);
			end 
		},
		{ text = VFLI.i18n("Test Death mode"), notCheckable = true, func = function()
			StaticPopup_Show("DEATH");
			end 
		},
	};
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Themes");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.keepShownOnClick = false;
	ent.menuList = RDXPM.subMenus;
end);

--RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Theme state");
--	ent.notCheckable = true;
--	ent.hasArrow = true;
--	ent.keepShownOnClick = false;
--	ent.menuList = RDXPM.stateTypeMenus;
--end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Third Party");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.keepShownOnClick = false;
	ent.menuList = RDX.thirdpartymenu;
end);
	
--RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Action bars");
--	ent.notCheckable = true;
--	ent.hasArrow = true;
--	ent.menuList = {
		--{ text = "Desktop", checked = RDXDK.IsDesktopLocked, func = RDXDK.ToggleDesktopLock },
--		{ text = "Configure keys", checked = RDXDK.IsKeyBindingsLocked, func = RDXDK.ToggleKeyBindingsLock },
--		{ text = "Lock Action Buttons", checked = RDXDK.IsActionBindingsLocked, func = RDXDK.ToggleActionBindingsLock }
--	};
--end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Backups");
	ent.hasArrow = true;
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.menuList = {
		{ text = VFLI.i18n("Backup Packages"), notCheckable = true, keepShownOnClick = false, func = RDXDB.BackupPackages },
		{ text = VFLI.i18n("Restore Packages"), notCheckable = true, keepShownOnClick = false, func = RDXDB.RestorePackages }
	};
end);
	
RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Visibility");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.menuList = {
		{ text = VFLI.i18n("Main Panel"), checked = function() return not RDXPM.IsPanelHidden(); end, func = RDXPM.ToggleHidePanel },
		{ text = VFLI.i18n("Mini Panel Default"), checked = function() if RDX.GetRDXIconType() == "default" then return true; else return nil; end end, func = function() RDX.ToggleRDXIcon("default"); DesktopEvents:Dispatch("DESKTOP_RDXICON_TYPE", "default", true); end},
		{ text = VFLI.i18n("Mini Panel Powered"), checked = function() if RDX.GetRDXIconType() == "poweredbyrdx" then return true; else return nil; end end, func = function() RDX.ToggleRDXIcon("poweredbyrdx"); DesktopEvents:Dispatch("DESKTOP_RDXICON_TYPE", "poweredbyrdx", true); end},
		{ text = VFLI.i18n("Activate Clean Icons (Addon Required)"), checked = RDX.UseCleanIcons, func = RDX.ToggleCleanIcons },
	};
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Debugging");
	ent.hasArrow = true;
	ent.notCheckable = true;
	ent.menuList = {
		{ text = VFLI.i18n("     Open Set Debugger"), notCheckable = true, keepShownOnClick = false, func = RDXM_Debug.SetDebugger },
		{ text = VFLI.i18n("     Open Profiler"), notCheckable = true, keepShownOnClick = false, func = VFLP.ToggleProfiler },
		{ text = VFLI.i18n("     Open ErrorDialog"), notCheckable = true, keepShownOnClick = false, func = VFL.ToggleErrorDialog },
		{ text = VFLI.i18n("     Fire Disrupt Signal"), notCheckable = true, keepShownOnClick = false, func = RDX._Disrupt },
		{ text = VFLI.i18n("     Fire Roster Update Signal"), notCheckable = true, keepShownOnClick = false, func = RDX._Roster },
		{ text = VFLI.i18n("     Reset Editor Layout"), notCheckable = true, keepShownOnClick = false, func = RDXPM.ResetLayouts },
		{ text = VFLI.i18n("     Garbage Collect"), notCheckable = true, keepShownOnClick = false, func = VFLGC },
		--{ text = VFLI.i18n("Fake Roster Units"), checked = RDXDAL.IsDummy, func = function() RDXEvents:Dispatch("ROSTER_DUMMY"); end },
		{ text = VFLI.i18n("Store Compiled Code"), checked = RDXM_Debug.IsStoreCompilerActive, keepShownOnClick = false, func = RDXM_Debug.ToggleStoreCompiler },
		{ text = VFLI.i18n("Party with me"), checked = RDXM_Debug.IsPartyIncludeMe, keepShownOnClick = false, func = RDXM_Debug.TogglePartyIncludeMe },
		{ text = VFLI.i18n("     Wipe CooldownDB"), notCheckable = true, keepShownOnClick = false, func = RDXCD.WipeCooldownDB },
		{ text = VFLI.i18n("     Print CooldownDB"), notCheckable = true, keepShownOnClick = false, func = RDXCD.DebugCooldownDB },
		{ text = VFLI.i18n("     Reset Chatframes"), notCheckable = true, keepShownOnClick = false, func = function() FCF_ResetChatWindows(); ReloadUI(); end },
	};
end);

RDXPM.CompactMenu:RegisterMenuFunction(function(ent)
	ent.text = "**************";
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
	mini:SetPoint("CENTER", VFLParent, "CENTER");
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
	txtrdx:SetWidth(50); txtrdx:SetHeight(20);
	txtrdx:SetFont("Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Adventure.ttf", 20);
	txtrdx:SetShadowOffset(1,-1);
	txtrdx:SetShadowColor(0,0,0,1);
	txtrdx:SetJustifyH("LEFT"); txtrdx:SetJustifyV("BOTTOM");
	txtrdx:SetText("RDX");
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
	
	function mini:SetIcon(mtxt)
		if mtxt == "poweredbyrdx"  then
			mtxtsave = mtxt;
			mini:SetHighlightTexture("");
			mini:SetHeight(20); mini:SetWidth(120);
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
			--RDXPM.StoreLayout(mini, "MiniButton");
			local anchorx,_,_,anchory = VFLUI.GetUniversalBoundary(mini);
			DesktopEvents:Dispatch("DESKTOP_RDXICON_POSITION", anchorx, anchory, true);
			return;
		end
		if(arg1 == "LeftButton") then
			RDXPM.CompactMenu:Open();
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
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()	
	-- Mini Panel
	miniPane = CreateMiniPane();
	miniPane:Layout();
	miniPane:SetIcon("default");
end);

function RDXPM.GetMiniPane() return miniPane; end