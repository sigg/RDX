-- Tools.lua
-- OpenRDX
-- Sigg
-- The desktop tools is opened when you unlock your desktop.
-- replace the old framesprops.

-- helper

-- The windows list container
local wl = {};

local function BuildWindowList(pkgfilter)
	VFL.empty(wl);
	local desc = nil;
	for pkg,data in pairs(RDXData) do
		if not pkgfilter or pkg == pkgfilter or pkg == "WoWRDX" or pkg == "default" then
			for file,md in pairs(data) do
				if (type(md) == "table") and md.data and md.ty and string.find(md.ty, "Window$") then
					local hide = RDXDB.HasFeature(md.data, "WindowListHide");
					if not hide then
						table.insert(wl, {path = RDXDB.MakePath(pkg, file), data = md.data});
					end
				end
			end
		end
	end
	table.sort(wl, function(x1,x2) return x1.path<x2.path; end);
end

-- function to create each row of the windows list
local function CreateWindowsListFrame()
	local self = VFLUI.AcquireFrame("Button");
	
	-- Create the button highlight texture
	local hltTexture = VFLUI.CreateTexture(self);
	hltTexture:SetAllPoints(self);
	hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	hltTexture:Show();
	self:SetHighlightTexture(hltTexture);

	-- Create the text
	local text = VFLUI.CreateFontString(self);
	text:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));	text:SetJustifyH("LEFT");
	text:SetTextColor(1,1,1,1);
	text:SetPoint("LEFT", self, "LEFT"); text:SetHeight(10); text:SetWidth(200);
	text:Show();
	self.text = text;

	self.Destroy = VFL.hook(function(self)
		-- Destroy allocated regions
		VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
		VFLUI.ReleaseRegion(self.text); self.text = nil;
	end, self.Destroy);

	self.OnDeparent = self.Destroy;

	return self;
end

local function WindowListClick(path)
	-- "Close" case
	if InCombatLockdown() then return; end	
	local inst = RDXDB.GetObjectInstance(path, true);
	if inst then
		--RDX.printI(VFLI.i18n("Closing Window at <") .. path .. ">");
		RDXDB.OpenObject(path, "Close");
		return;
	end
	-- "Open" case
	--RDX.printI(VFLI.i18n("Opening Window at <") .. path .. ">");
	RDXDB.OpenObject(path);
end

-- The panel
local dlg = nil;
local function OpenDesktopTools(parent, froot)
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 20);
	dlg:SetTitleColor(0,.5,0);
	dlg:SetText(VFLI.i18n("Desktop Manager: "));
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:Accomodate(216, 450);
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("dktools") then RDXPM.RestoreLayout(dlg, "dktools"); end
	
	local ca = dlg:GetClientArea();
	
	-- Viewport
	local separator1 = VFLUI.SeparatorText:new(ca, 1, 216);
	separator1:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -5);
	separator1:SetText("Viewport");
	
	local updateViewport;
	
	local chk_viewport = VFLUI.Checkbox:new(ca); chk_viewport:SetHeight(16); chk_viewport:SetWidth(200);
	chk_viewport:SetPoint("TOPLEFT", separator1, "BOTTOMLEFT");
	if froot.viewport then chk_viewport:SetChecked(true); else chk_viewport:SetChecked(); end
	chk_viewport:SetText("Activate Viewport");
	chk_viewport:Show();
	chk_viewport.check:SetScript("OnClick", function() updateViewport(); end);
	
	local leleft = VFLUI.LabeledEdit:new(ca, 50); leleft:SetHeight(25); leleft:SetWidth(100);
	leleft:SetPoint("TOPLEFT", chk_viewport, "BOTTOMLEFT", 0, 0); leleft:SetText("Left"); 
	leleft.editBox:SetText(froot.offsetleft); leleft:Show();
	leleft.editBox:SetScript("OnTextChanged", function() updateViewport(); end);
	
	local letop = VFLUI.LabeledEdit:new(ca, 50); letop:SetHeight(25); letop:SetWidth(100);
	letop:SetPoint("TOPLEFT", leleft, "TOPRIGHT", 0, 0); letop:SetText("Top");
	letop.editBox:SetText(froot.offsettop); letop:Show();
	letop.editBox:SetScript("OnTextChanged", function() updateViewport(); end);
	
	local leright = VFLUI.LabeledEdit:new(ca, 50); leright:SetHeight(25); leright:SetWidth(100);
	leright:SetPoint("TOPLEFT", leleft, "BOTTOMLEFT", 0, 0); leright:SetText("Right"); 
	leright.editBox:SetText(froot.offsetright); leright:Show();
	leright.editBox:SetScript("OnTextChanged", function() updateViewport(); end);
	
	local lebottom = VFLUI.LabeledEdit:new(ca, 50); lebottom:SetHeight(25); lebottom:SetWidth(100);
	lebottom:SetPoint("TOPLEFT", leright, "TOPRIGHT", 0, 0); lebottom:SetText("Bottom");
	lebottom.editBox:SetText(froot.offsetbottom); lebottom:Show();
	lebottom.editBox:SetScript("OnTextChanged", function() updateViewport(); end);
	
	updateViewport = function()
		local left = tonumber(leleft.editBox:GetText());
		local top = tonumber(letop.editBox:GetText());
		local right = tonumber(leright.editBox:GetText());
		local bottom = tonumber(lebottom.editBox:GetText());
		if left and top and right and bottom then
			DesktopEvents:Dispatch("DESKTOP_VIEWPORT", chk_viewport:GetChecked(), left, top, right, bottom);
		end
	end
	
	-- Windows list
	local separator2 = VFLUI.SeparatorText:new(ca, 1, 216);
	separator2:SetPoint("TOPLEFT", leright, "BOTTOMLEFT", 0, -5);
	separator2:SetText("Windows List");
	
	local list = VFLUI.List:new(dlg, 12, CreateWindowsListFrame);
	list:SetPoint("TOPLEFT", separator2, "BOTTOMLEFT");
	list:SetWidth(216); list:SetHeight(150);
	list:Rebuild(); list:Show();
	list:SetDataSource(function(cell, data, pos)
		local p = data.path;
		if RDXDB.PathHasInstance(p) then
			cell.text:SetText("|cFF00FF00" .. p .. "|r");
		else
			cell.text:SetText(p);
		end
		cell:SetScript("OnClick", function()
			WindowListClick(p); list:Update();
		end);
	end, VFL.ArrayLiterator(wl));
	
	local _, auiname = RDXDB.ParsePath(RDXU.AUI);
	if RDXG.dktoolfilter then
		BuildWindowList(auiname);
	else
		BuildWindowList();
	end
	list:Update();
	
	-- Window option
	local separator3 = VFLUI.SeparatorText:new(ca, 1, 216);
	separator3:SetPoint("TOPLEFT", list, "BOTTOMLEFT", 0, -5);
	separator3:SetText("Window options");
	
	local windowName = VFLUI.SimpleText:new(ca, 1, 216);
	windowName:SetPoint("TOPLEFT", separator3, "BOTTOMLEFT");
	windowName:SetText("Click on a window of your UI to modify it");
	
	-- scale
	local lblScale = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Scale"));
	lblScale:SetPoint("TOPLEFT", windowName, "BOTTOMLEFT"); lblScale:SetHeight(25);
	local edScale = VFLUI.Edit:new(dlg, true); edScale:SetHeight(25); edScale:SetWidth(50);
	edScale:SetPoint("TOPRIGHT", windowName, "BOTTOMRIGHT", 0, 0); edScale:Show();
	local slScale = VFLUI.HScrollBar:new(dlg, nil, function(value)
		if dlg.frameprops then
			if value == 0 then value = 0.01; end
			DesktopEvents:Dispatch("WINDOW_UPDATE", dlg.frameprops.name, "SCALE", value);
		end
	end);
	slScale:SetPoint("RIGHT", edScale, "LEFT", -16, 0); slScale:SetWidth(100);
	slScale:Show();
	slScale:SetMinMaxValues(.1, 3.0); slScale:SetValue(1, true);
	VFLUI.BindSliderToEdit(slScale, edScale);

	-- alpha
	local lblAlpha = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Alpha"));
	lblAlpha:SetPoint("TOPLEFT", lblScale, "BOTTOMLEFT"); lblAlpha:SetHeight(25);
	local edAlpha = VFLUI.Edit:new(dlg, true); edAlpha:SetHeight(25); edAlpha:SetWidth(50);
	edAlpha:SetPoint("TOPRIGHT", edScale, "BOTTOMRIGHT", 0, 0); edAlpha:Show();
	local slAlpha = VFLUI.HScrollBar:new(dlg, nil, function(value)
		if dlg.frameprops then
			DesktopEvents:Dispatch("WINDOW_UPDATE", dlg.frameprops.name, "ALPHA", value);
		end
	end);
	slAlpha:SetPoint("RIGHT", edAlpha, "LEFT", -16, 0); slAlpha:SetWidth(100);
	slAlpha:Show();
	slAlpha:SetMinMaxValues(0, 1); slAlpha:SetValue(1, true);
	VFLUI.BindSliderToEdit(slAlpha, edAlpha);

	-- strata
	local lblStrata = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Stratum"));
	lblStrata:SetPoint("TOPLEFT", lblAlpha, "BOTTOMLEFT"); lblStrata:SetHeight(25);
	local ddStrata = VFLUI.Dropdown:new(dlg, RDXUI.DesktopStrataFunction, function(value)
		if dlg.frameprops and RDXUI.IsValidStrata(value) then
			DesktopEvents:Dispatch("WINDOW_UPDATE", dlg.frameprops.name, "STRATA", value);
		end
	end);
	ddStrata:SetPoint("TOPRIGHT", edAlpha, "BOTTOMRIGHT", 0, 0); ddStrata:SetWidth(132);
	ddStrata:SetSelection("MEDIUM", true);
	ddStrata:Show();

	-- anchor
	--local lblAP = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Anchor point"));
	--lblAP:SetPoint("TOPLEFT", lblStrata, "BOTTOMLEFT"); lblAP:SetHeight(25);
	--local ddAP = VFLUI.Dropdown:new(dlg, RDXUI.DesktopAnchorFunction, function(value) 
	--	if dlg.frameprops and RDXUI.IsValidAnchor(value) then
	--		DesktopEvents:Dispatch("WINDOW_UPDATE", dlg.frameprops.name, "ANCHOR", value);
	--	end
	--end);
	--ddAP:SetPoint("TOPRIGHT", ddStrata, "BOTTOMRIGHT", 0, 0); ddAP:SetWidth(132);
	--ddAP:SetSelection("TOPLEFT", true);
	--ddAP:Show();

	--local txtCurDock = VFLUI.CreateFontString(dlg);
	--txtCurDock:SetPoint("TOPLEFT", lblStrata, "BOTTOMLEFT", 0, -5);
	--txtCurDock:SetWidth(180); txtCurDock:SetHeight(160);
	--txtCurDock:SetJustifyV("TOP");
	--txtCurDock:SetJustifyH("LEFT");
	--txtCurDock:SetFontObject(Fonts.Default10); txtCurDock:Show();
	
	--local function updateDockTxt(dd)
	--	local str = VFLI.i18n("Tips: To undock two windows, right click on the red/yellow anchor point.\n\n");
	--	str = str .. VFLI.i18n("Tips: To dock two windows, drag a anchor point and drop it to a other anchor point.\n\n");
	--	str = str .. VFLI.i18n("Docks:\n");
	--	if dd and dd.dock then
	--		for k,v in pairs(dd.dock) do
	--			str = str .. k .. ": " .. v.id .. "\n";
	--		end
	--	else
	--		str = str .. "(none)";
	--	end
	--	txtCurDock:SetText(str);
	--end
	--updateDockTxt();
	
	function dlg:_update(frameprops)
		dlg.frameprops = frameprops;
		windowName:SetText("|cFF00FF00" .. frameprops.name .. "|r");
		slScale:SetValue(frameprops.scale, true);
		slAlpha:SetValue(frameprops.alpha, true);
		ddStrata:SetSelection(frameprops.strata, true);
		--ddAP:SetSelection(frameprops.ap, true);
		--updateDockTxt(frameprops);
	end
	
	-- action bar
	local separator4 = VFLUI.SeparatorText:new(ca, 1, 216);
	separator4:SetPoint("TOPLEFT", lblStrata, "BOTTOMLEFT", 0, -5);
	separator4:SetText("ActionBars");
	
	-- button configure keys
	local dfkey = nil;
	local btndefinekey = VFLUI.OKButton:new(ca);
	btndefinekey:SetHeight(25); btndefinekey:SetWidth(216);
	btndefinekey:SetPoint("TOPLEFT", separator4, "BOTTOMLEFT", 0, -5);
	btndefinekey:SetText(VFLI.i18n("Click to setup your keys")); btndefinekey:Show();
	btndefinekey:SetScript("OnClick", function()
		if not InCombatLockdown() then 
			if dfkey then
				btndefinekey:SetText(VFLI.i18n("Click to setup your keys"));
				DesktopEvents:Dispatch("DESKTOP_UNLOCK");
				DesktopEvents:Dispatch("DESKTOP_LOCK_BINDINGS");
				dfkey = nil;
			else
				btndefinekey:SetText(VFLI.i18n("Lock keys setup"));
				DesktopEvents:Dispatch("DESKTOP_LOCK");
				DesktopEvents:Dispatch("DESKTOP_UNLOCK_BINDINGS");
				dfkey = true;
			end
		end
	end);
	
	local chk_lockaction = VFLUI.Checkbox:new(ca); chk_lockaction:SetHeight(16); chk_lockaction:SetWidth(200);
	chk_lockaction:SetPoint("TOPLEFT", btndefinekey, "BOTTOMLEFT");
	if RDXDK.IsActionBindingsLocked() then chk_lockaction:SetChecked(true); else chk_lockaction:SetChecked(); end
	chk_lockaction:SetText("Lock drag action button in combat");
	chk_lockaction:Show();
	chk_lockaction.check:SetScript("OnClick", function() RDXDK.ToggleActionBindingsLock(); end);
	
	-- to see if many people is really using this.
	--local lbl_keys = VFLUI.MakeLabel(nil, ca, VFLI.i18n("Keys definition"));
	--lbl_keys:SetPoint("TOPLEFT", chk_lockaction, "BOTTOMLEFT"); lbl_keys:SetHeight(25);
	--local dd_Keys = VFLUI.Dropdown:new(ca, RDXUI.DesktopStrataFunction, function(value)
	--end);
	--dd_Keys:SetPoint("TOPRIGHT", lbl_keys, "BOTTOMRIGHT", 0, 0); dd_Keys:SetWidth(132);
	--dd_Keys:SetSelection(froot.keys, true);
	--dd_Keys:Show();
	
	-- gametooltips
	local separator5 = VFLUI.SeparatorText:new(ca, 1, 216);
	separator5:SetPoint("TOPLEFT", chk_lockaction, "BOTTOMLEFT", 0, -5);
	separator5:SetText("GameTooltips");
	
	local chk_tooltipmouse = VFLUI.Checkbox:new(ca); chk_tooltipmouse:SetHeight(16); chk_tooltipmouse:SetWidth(200);
	chk_tooltipmouse:SetPoint("TOPLEFT", separator5, "BOTTOMLEFT");
	if froot.tooltipmouse then chk_tooltipmouse:SetChecked(true); else chk_tooltipmouse:SetChecked(); end
	chk_tooltipmouse:SetText(VFLI.i18n("Mouse anchor tooltip"));
	chk_tooltipmouse:Show();
	chk_tooltipmouse.check:SetScript("OnClick", function() DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP", chk_tooltipmouse:GetChecked(), froot.anchorx, froot.anchory); end);
	
	dlg:Show();
	
	DesktopEvents:Dispatch("DESKTOP_UNLOCK");
	
	local esch = function()
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
		if not RDXG.dktoolfilter then
			local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
			BuildWindowList(auiname);
			RDXG.dktoolfilter = true
		else
			BuildWindowList();
			RDXG.dktoolfilter = nil;
		end
		list:Update();
	end);
	dlg:AddButton(listbtn);

	dlg.Destroy = VFL.hook(function(s)
		s._esch = nil;
		chk_tooltipmouse:Destroy(); chk_tooltipmouse = nil;
		separator5:Destroy(); separator5 = nil;
		chk_lockaction:Destroy(); chk_lockaction = nil;
		btndefinekey:Destroy(); btndefinekey = nil;
		separator4:Destroy(); separator4 = nil;
		s._update = nil;
		--updateDockTxt = nil;
		--VFLUI.ReleaseRegion(txtCurDock); txtCurDock = nil;
		ddStrata:Destroy(); ddStrata = nil;
		slAlpha:Destroy(); slAlpha = nil; edAlpha:Destroy(); edAlpha = nil;
		slScale:Destroy(); slScale = nil; edScale:Destroy(); edScale = nil;
		windowName:Destroy(); windowName = nil;
		separator3:Destroy(); separator3 = nil;
		list:Destroy(); list = nil;
		separator2:Destroy(); separator2 = nil;
		updateViewport = nil;
		lebottom:Destroy(); lebottom = nil;
		leright:Destroy(); leright = nil;
		letop:Destroy(); letop = nil;
		leleft:Destroy(); leleft = nil;
		chk_viewport:Destroy(); chk_viewport = nil;
		separator1:Destroy(); separator1 = nil;
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

function RDXDK.UpdateDesktopTools(frameprops)
	if not dlg then RDXDK.OpenDesktopTools(); end
	if frameprops then dlg:_update(frameprops); end
end