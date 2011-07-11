-- Tools.lua
-- OpenRDX
-- Sigg
-- The desktop tools is opened when you unlock your desktop.
-- replace the old framesprops.

-- helper

-- The container
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

local dlg = nil;
function RDXDK.OpenDesktopTools(parent)
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 20);
	dlg:SetTitleColor(0,.5,0);
	dlg:SetText(VFLI.i18n("Desktop Tools: "));
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:Accomodate(216, 350);
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("dktools") then RDXPM.RestoreLayout(dlg, "dktools"); end
	
	local ca = dlg:GetClientArea();
	
	local separator1 = VFLUI.SimpleText:new(ca, 1, 216);
	separator1:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -5);
	separator1:SetText("Windows List (Click to open/close)");
	
	local list = VFLUI.List:new(dlg, 12, CreateWindowsListFrame);
	list:SetPoint("TOPLEFT", separator1, "BOTTOMLEFT");
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
	
	-- Get current AUI name
	local _, auiname = RDXDB.ParsePath(RDXU.AUI);
	BuildWindowList(auiname);
	list:Update();
	
	-- a separator.
	local separator2 = VFLUI.SimpleText:new(ca, 1, 216);
	separator2:SetPoint("TOPLEFT", list, "BOTTOMLEFT");
	separator2:SetText("Window options");
	
	local windowName = VFLUI.SimpleText:new(ca, 1, 216);
	windowName:SetPoint("TOPLEFT", separator2, "BOTTOMLEFT");
	windowName:SetText("Click on a window to select it");
	
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
	local lblAP = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Anchor point"));
	lblAP:SetPoint("TOPLEFT", lblStrata, "BOTTOMLEFT"); lblAP:SetHeight(25);
	local ddAP = VFLUI.Dropdown:new(dlg, RDXUI.DesktopAnchorFunction, function(value) 
		if dlg.frameprops and RDXUI.IsValidAnchor(value) then
			DesktopEvents:Dispatch("WINDOW_UPDATE", dlg.frameprops.name, "ANCHOR", value);
		end
	end);
	ddAP:SetPoint("TOPRIGHT", ddStrata, "BOTTOMRIGHT", 0, 0); ddAP:SetWidth(132);
	ddAP:SetSelection("TOPLEFT", true);
	ddAP:Show();

	local txtCurDock = VFLUI.CreateFontString(dlg);
	txtCurDock:SetPoint("TOPLEFT", lblAP, "BOTTOMLEFT");
	txtCurDock:SetWidth(180); txtCurDock:SetHeight(60);
	txtCurDock:SetJustifyV("TOP");
	txtCurDock:SetJustifyH("LEFT");
	txtCurDock:SetFontObject(Fonts.Default10); txtCurDock:Show();
	
	local function updateDockTxt(dd)
		local str = VFLI.i18n("Docks:\n");
		if dd.dock then
			for k,v in pairs(dd.dock) do
				str = str .. k .. ": " .. v.id .. "\n";
			end
		else
			str = str .. "(none)";
		end
		txtCurDock:SetText(str);
	end
	
	function dlg:_update(frameprops)
		dlg.frameprops = frameprops;
		windowName:SetText(frameprops.name);
		slScale:SetValue(frameprops.scale, true);
		slAlpha:SetValue(frameprops.alpha, true);
		ddStrata:SetSelection(frameprops.strata, true);
		--ddAP:SetSelection(frameprops.ap, true);
		updateDockTxt(frameprops);
	end
	
	dlg:Show();
	
	local esch = function()
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
		if dlg.toggle then
			local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
			BuildWindowList(auiname);
			dlg.toggle = nil
		else
			BuildWindowList();
			dlg.toggle = true;
		end
		list:Update();
	end);
	dlg:AddButton(listbtn);

	dlg.Destroy = VFL.hook(function(s)
		s._esch = nil;
		s._update = nil;
		updateDockTxt = nil;
		VFLUI.ReleaseRegion(txtCurDock); txtCurDock = nil;
		ddAP:Destroy(); ddAP = nil; ddStrata:Destroy(); ddStrata = nil;
		slAlpha:Destroy(); slAlpha = nil; edAlpha:Destroy(); edAlpha = nil;
		slScale:Destroy(); slScale = nil; edScale:Destroy(); edScale = nil;
		windowName:Destroy(); windowName = nil;
		separator2:Destroy(); separator2 = nil;
		list:Destroy(); list = nil;
		separator1:Destroy(); separator1 = nil;
		s.frameprops = nil;
	end, dlg.Destroy);
end

function RDXDK.ToggleDesktopTools()
	if dlg then
		dlg:_esch();
	else
		RDXDK.OpenDesktopTools();
	end
end

function RDXDK.CloseDesktopTools()
	if dlg then
		dlg:_esch();
	end
end

function RDXDK.UpdateDesktopTools(frameprops)
	if not dlg then RDXDK.OpenDesktopTools(); end
	if frameprops then dlg:_update(frameprops); end
end