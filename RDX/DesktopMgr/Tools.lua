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
	dlg:SetPoint("CENTER", VFLParent, "CENTER", -200, 0);
	dlg:Accomodate(232, 530);
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("dktools") then RDXPM.RestoreLayout(dlg, "dktools"); end
	
	local ca = dlg:GetClientArea();
	
	local tabbox = VFLUI.TabBox:new(ca, 22, "TOP");
	tabbox:SetHeight(530); tabbox:SetWidth(232);
	tabbox:SetPoint("TOPLEFT", ca, "TOPLEFT");
	
	for i, v in ipairs(tools) do
		tabbox:GetTabBar():AddTab(v.width, function() tabbox:SetClient(v.cli); v.funcSet(froot) end, function() v.funcUnset() end):SetText(v.title);
	end
	
	tabbox:GetTabBar():SelectTabName("Windows");
	tabbox:Show();
	
	dlg.tabbox = tabbox;
	
	--function dlg:_update(frameprops)
		-- deprecated
	--end
	
	--local updateCombatText = nil;
	--local separator6 = VFLUI.SeparatorText:new(ca, 1, 216);
	--separator6:SetPoint("TOPLEFT", lblsb, "BOTTOMLEFT", 0, -5);
	--separator6:SetText("Combat Text Font");
	
	--local ctffont = VFLUI.MakeLabel(nil, ca, VFLI.i18n("Fnt"));
	--ctffont:SetWidth(34); ctffont:SetPoint("TOPLEFT", separator6, "BOTTOMLEFT", 0, -15);
	--local dd_ctf_font = VFLUI.MakeFontSelectButton(ca, froot.ctffont, function() updateCombatText(); end, nil); 
	--dd_ctf_font:SetPoint("LEFT", ctffont, "RIGHT");
	--dd_ctf_font:Show();
	
	--updateCombatText = function()
	--	DesktopEvents:Dispatch("DESKTOP_COMBATTEXT", dd_ctf_font:GetSelectedFont());
	--end
	
	dlg:Show();
	
	local esch = function()
		RDXDK.SetFramew_window(nil);
		DesktopEvents:Dispatch("DESKTOP_LOCK_BINDINGS");
		DesktopEvents:Dispatch("DESKTOP_LOCK");
		RDXPM.StoreLayout(dlg, "dktools");
		dlg:Destroy(); dlg = nil;
	end
	
	function dlg:_esch()
		esch();
	end
	
	-- Add button filter on list
	local listbtn = VFLUI.TexturedButton:new(dlg, 16, "Interface\\AddOns\\RDX\\Skin\\menu");
	listbtn:SetHighlightColor(0,1,1,1);
	listbtn:SetScript("OnClick", function()
		if not RDXG.dktoolnofilter then
			BuildWindowList();
			RDXG.dktoolnofilter = true;
		else
			local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
			BuildWindowList(auiname);
			RDXG.dktoolnofilter = nil;
		end
		list:Update();
	end);
	dlg:AddButton(listbtn);
	
	local closebtn = VFLUI.CloseButton:new()
	closebtn:SetScript("OnClick", esch);
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