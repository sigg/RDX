-- Tools.lua
-- OpenRDX
-- Sigg
-- The desktop tools is opened when you unlock your desktop.
-- replace the old framesprops.

---------------------------------------
-- The main panel
---------------------------------------
local panels = {};

function RDXMAP.RegisterPanel(title, width, cli, funcSet, funcUnset)
	local tbl = {};
	tbl.title = title;
	tbl.width = width;
	tbl.cli = cli;
	tbl.funcSet = funcSet;
	tbl.funcUnset = funcUnset;
	table.insert(panels, tbl);
end

local dlg = nil;
local function OpenQuestsPanel(parent)
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 20);
	dlg:SetTitleColor(0,.5,0);
	dlg:SetPoint("CENTER", RDXParent, "CENTER", -200, 0);
	dlg:Accomodate(600, 530);
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("qspanel") then RDXPM.RestoreLayout(dlg, "qspanel"); end
	
	local _, i = GetNumQuestLogEntries()

	local dailyStr = ""
	local dailysDone = GetDailyQuestsCompleted()
	if dailysDone > 0 then
		dailyStr = "Daily Quests Completed: |cffffffff" .. dailysDone
	end
	dailyStr = dailyStr .. "|r  Daily reset: |cffffffff" .. VFLT.FormatSmartMinSec (GetQuestResetTime())

	dlg:SetText(format ("Quests Explorer: |cffffffff%d/%d|r  %s", i, MAX_QUESTS, dailyStr));
	
	local ca = dlg:GetClientArea();
	
	local tabbox = VFLUI.TabBox:new(ca, 22, "BOTTOM");
	tabbox:SetHeight(530); tabbox:SetWidth(600);
	tabbox:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, 0);
	
	for i, v in ipairs(panels) do
		local tab = tabbox:GetTabBar():AddTab(v.width, function() tabbox:SetClient(v.cli); v.funcSet() end, function() v.funcUnset() end);
		tab.font:SetText(v.title);
	end
	
	tabbox:Show();
	
	dlg.tabbox = tabbox;
	tabbox:GetTabBar():SelectTabId(1);
	dlg:Show();
	
	--dlg:_Show(RDX.smooth, nil, function()
	--	tabbox:GetTabBar():SelectTabId(1);
	--end);
	
	local esch = function()
		--dlg:_Hide(RDX.smooth, nil, function() 
			dlg.tabbox:GetTabBar():UnSelectTab();
			RDXPM.StoreLayout(dlg, "qspanel");
			dlg:Destroy(); dlg = nil; 
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	-- Add button filter on list
	--local listbtn = VFLUI.TexturedButton:new(dlg, 16, "Interface\\AddOns\\RDX\\Skin\\menu");
	--listbtn:SetHighlightColor(0,1,1,1);
	--listbtn:SetScript("OnClick", function()
	--	if not RDXG.dktoolnofilter then
	--		--BuildWindowList();
	--		RDXG.dktoolnofilter = true;
	--	else
	--		--local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
	--		--BuildWindowList(auiname);
	--		RDXG.dktoolnofilter = nil;
	--	end
	--	--list:Update();
	--end);
	--dlg:AddButton(listbtn);
	
	local closebtn = VFLUI.CloseButton:new()
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);
	
	dlg.Destroy = VFL.hook(function(s)
		s._esch = nil;
		s.tabbox:Destroy(); s.tabbox = nil;
		s.frameprops = nil;
	end, dlg.Destroy);
end

function RDXMAP.IsQuestsPanelOpen()
	if dlg then return true; else return nil; end
end

function RDXMAP.ToggleQuestsPanel(parent)
	if not InCombatLockdown() then
		if dlg then
			dlg:_esch();
		else
			OpenQuestsPanel(VFLParent);
		end
	end
end

--RDXPM.RegisterSlashCommand("toggledesk", function()
--	local curdesk = RDXDK.GetCurrentDesktop();
--	if curdesk then
--		RDXDK.ToggleDesktopTools(VFLFULLSCREEN_DIALOG, curdesk:_GetFrameProps("root"));
--	end
--end);