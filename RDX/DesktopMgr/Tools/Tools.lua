-- Tools.lua
-- OpenRDX
-- Sigg
-- The desktop tools is opened when you unlock your desktop.
-- replace the old framesprops.

---------------------------------------
-- The main panel
---------------------------------------
local tools = {};

function RDXDK.RegisterTool(title, width, cli, funcSet, funcUnset)
	local tbl = {};
	tbl.title = title;
	tbl.width = width;
	tbl.cli = cli;
	tbl.funcSet = funcSet;
	tbl.funcUnset = funcUnset;
	table.insert(tools, tbl);
end

local dlg = nil;
local function OpenDesktopTools(parent, froot)
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 20);
	dlg:SetTitleColor(0,.5,0);
	dlg:SetText(VFLI.i18n("Desktop Manager"));
	dlg:SetPoint("CENTER", RDXParent, "CENTER", -200, 0);
	dlg:Accomodate(232, 530);
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("dktools") then RDXPM.RestoreLayout(dlg, "dktools"); end
	
	local ca = dlg:GetClientArea();
	
	local tabbox = VFLUI.TabBox:new(ca, 22, "TOP");
	tabbox:SetHeight(530); tabbox:SetWidth(232);
	tabbox:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, 0);
	
	for i, v in ipairs(tools) do
		local tab = tabbox:GetTabBar():AddTab(v.width, function() tabbox:SetClient(v.cli); v.funcSet(froot) end, function() v.funcUnset(froot) end);
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
			RDXPM.StoreLayout(dlg, "dktools");
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
	--		--local _, auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
	--		--BuildWindowList(auiname);
	--		RDXG.dktoolnofilter = nil;
	--	end
	--	--list:Update();
	--end);
	--dlg:AddButton(listbtn);
	RDXG.dktoolnofilter = nil;
	
	local closebtn = VFLUI.CloseButton:new()
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);
	
	dlg.Destroy = VFL.hook(function(s)
		s._esch = nil;
		s.tabbox:Destroy(); s.tabbox = nil;
		s.frameprops = nil;
	end, dlg.Destroy);
end

function RDXDK.IsDesktopToolsOpen()
	if dlg then return true; else return nil; end
end

function RDXDK.ToggleDesktopTools(parent, froot)
	if not InCombatLockdown() then
		if dlg then
			dlg:_esch();
		else
			OpenDesktopTools(parent, froot);
		end
	end
end

RDXPM.RegisterSlashCommand("toggledesk", function()
	local curdesk = RDXDK.GetCurrentDesktop();
	if curdesk then
		RDXDK.ToggleDesktopTools(VFLFULLSCREEN_DIALOG, curdesk:_GetFrameProps("root"));
	end
end);