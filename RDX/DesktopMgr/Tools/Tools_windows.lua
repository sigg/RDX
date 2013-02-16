-- OpenRDX
--
-------------------
-- helper
-------------------

-- The windows list container
local wl = {};
local function BuildWindowList(pkgfilter)
	VFL.empty(wl);
	local desc = nil;
	for pkg,data in pairs(RDXData) do
		if not pkgfilter or pkg == pkgfilter or RDXDB.IsCommonPackage(pkg) then
			for file,md in pairs(data) do
				if (type(md) == "table") and md.data and md.ty and string.find(md.ty, "^Window$") then
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

-- the windows less list container
local w2 = {};
local function BuildWindowLessList()
	VFL.empty(w2);
	local desc = nil;
	for k,v in pairs(RDXDK._GetWindowsLess()) do
		table.insert(w2, {path = k, data = v});
	end
	table.sort(w2, function(x1,x2) return x1.path<x2.path; end);
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
	
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	self.Destroy = VFL.hook(function(self)
		-- Destroy allocated regions
		VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
		VFLUI.ReleaseRegion(self.text); self.text = nil;
	end, self.Destroy);

	self.OnDeparent = self.Destroy;

	return self;
end

local function WindowListClick(path)
	if InCombatLockdown() then return; end	
	local inst = RDXDB.GetObjectInstance(path, true);
	if inst then
		RDXDB.OpenObject(path, "Close");
		return;
	end
	RDXDB.OpenObject(path);
end

local function WindowLessListClick(path)
	if InCombatLockdown() then return; end
	if RDXDK._IsWindowOpen(path) then
		RDXDK._DelRegisteredWindowRDX(path);
	else
		RDXDK._AddRegisteredWindowRDX(path);
	end
end

local function WindowListRightClick(self, path)
	local mnu = {};
	table.insert(mnu, {
		text = VFLI.i18n("Edit Window"),
		OnClick = function()
			VFL.poptree:Release();
			RDXDB.OpenObject(path, "Edit", VFLDIALOG);
		end
	});
	
	local feat = RDXDB.GetFeatureData(path, "Design");
	local upath = feat["design"];
	--table.insert(mnu, {
	--	text = VFLI.i18n("Clone..."),
	--	OnClick = function() 
	--		VFL.poptree:Release();
	--		RDX.CloneWindow(frameprops.name, upath, VFLDIALOG); 
	--	end;
	--});
	if upath then
		table.insert(mnu, {
			text = VFLI.i18n("Edit Design");
			OnClick = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(upath, "Edit", VFLDIALOG);
			end;
		});
	end
	
	table.insert(mnu, {
		text = "********************";
		OnClick = VFL.Noop;
	});
	
	table.insert(mnu, {
		text = VFLI.i18n("Delete Window"),
		OnClick = function()
			VFL.poptree:Release();
			if InCombatLockdown() then return; end
			VFLUI.MessageBox(VFLI.i18n("Delete window: ") .. path, VFLI.i18n("Are you sure you want to delete the window ") .. path .. VFLI.i18n("?"), nil, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), 
				function()
					local inst = RDXDB.GetObjectInstance(path, true);
					if inst then
						RDXDB.OpenObject(path, "Close");
					end
					RDXDB.DeleteObject(path .. "_ds");
					RDXDB.DeleteObject(path);
					VFLT.NextFrame(math.random(10000000), function()
						RDXDK.ToolsWindowUpdate();
					end);
				end);
		end
	});
	
	VFL.poptree:Begin(150, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
	VFL.poptree:Expand(nil, mnu);
end

-- layout raid frames
-- allow to define number of unit per column for the raid frames.
local layouts = {
	{ text = "1" },
	{ text = "5" },
	{ text = "10" },
	{ text = "15" },
	{ text = "25" },
	{ text = "40" },
};
local function layoutSel() return layouts; end

--
-- TAB Windows
--
local winframeprops = nil;

local framew = VFLUI.AcquireFrame("Frame");
framew:SetHeight(400); framew:SetWidth(216);

local separator2 = VFLUI.SeparatorText:new(framew, 1, 216);
separator2:SetPoint("TOPLEFT", framew, "TOPLEFT", 5, -5);
separator2:SetText(VFLI.i18n("RDX Windows"));

local list = VFLUI.List:new(framew, 12, CreateWindowsListFrame);
list:SetPoint("TOPLEFT", separator2, "BOTTOMLEFT");
list:SetWidth(216); list:SetHeight(200);
list:Rebuild(); list:Show();
list:SetDataSource(function(cell, data, pos)
	local p = data.path;
	if RDXDB.PathHasInstance(p) then
		cell.text:SetText("|cFF00FF00" .. p .. "|r");
	else
		cell.text:SetText(p);
	end
	cell:SetScript("OnClick", function(self, arg1)
		if arg1 == "LeftButton" then
			WindowListClick(p); list:Update();
		elseif arg1 == "RightButton" then
			WindowListRightClick(self, p); 
		end
	end);
end, VFL.ArrayLiterator(wl));

function RDXDK.ToolsWindowUpdate()
	local _, auiname = RDXDB.ParsePath(RDXU.AUI);
	BuildWindowList(auiname);
	list:Update();
end;

-- Windows less
local separator_winless = VFLUI.SeparatorText:new(framew, 1, 216);
separator_winless:SetPoint("TOPLEFT", list, "TOPLEFT", 0, -195);
separator_winless:SetText(VFLI.i18n("External Addons"));

local list2 = VFLUI.List:new(framew, 12, CreateWindowsListFrame);
list2:SetPoint("TOPLEFT", separator_winless, "BOTTOMLEFT");
list2:SetWidth(216); list2:SetHeight(50);
list2:Rebuild(); list2:Show();
list2:SetDataSource(function(cell, data, pos)
	local p = data.path;
	if RDXDK._IsWindowOpen(p) then
		cell.text:SetText("|cFF00FF00" .. p .. "|r");
	else
		cell.text:SetText(p);
	end
	cell:SetScript("OnClick", function(self, arg1)
		if arg1 == "LeftButton" then
			WindowLessListClick(p); list2:Update();
		--elseif arg1 == "RightButton" then
		--	WindowListRightClick(self, p);
		end
	end);
end, VFL.ArrayLiterator(w2));

local separatorGS = VFLUI.SeparatorText:new(framew, 1, 216);
separatorGS:SetPoint("TOPLEFT", list2, "BOTTOMLEFT", 0, -45);
separatorGS:SetText(VFLI.i18n("Options"));

-- scale
local lblGScale = VFLUI.MakeLabel(nil, framew, VFLI.i18n("Global Scale:"));
lblGScale:SetPoint("TOPLEFT", separatorGS, "BOTTOMLEFT"); lblGScale:SetHeight(25); lblGScale:Show();

local slGScale = VFLUI.HScrollBar:new(framew, nil, function(value)
	if value == 0 then value = 0.01; end
	DesktopEvents:Dispatch("WINDOW_UPDATE_ALL", "SCALE", value);
end);
slGScale:SetPoint("TOPLEFT", lblGScale, "BOTTOMLEFT", 16, 0); slGScale:SetWidth(140);
slGScale:Show();
slGScale:SetMinMaxValues(.1, 2.0); slGScale:SetValue(1, true);

local edGScale = VFLUI.Edit:new(framew, true); edGScale:SetHeight(25); edGScale:SetWidth(50);
edGScale:SetPoint("LEFT", slGScale, "RIGHT", 16, 0); edGScale:Show();

VFLUI.BindSliderToEdit(slGScale, edGScale);


-- Window option
local separator3 = VFLUI.SeparatorText:new(framew, 1, 216);
separator3:SetPoint("TOPLEFT", slGScale, "BOTTOMLEFT", -16, -5);
separator3:SetText("Window options");

local windowName = VFLUI.SimpleText:new(framew, 1, 216);
windowName:SetPoint("TOPLEFT", separator3, "BOTTOMLEFT");
windowName:SetText(VFLI.i18n("Click on a window of your UI to modify it"));
windowName:Show();

-- scale
local lblScale = VFLUI.MakeLabel(nil, framew, VFLI.i18n("Scale:"));
lblScale:SetPoint("TOPLEFT", windowName, "BOTTOMLEFT"); lblScale:SetHeight(25); lblScale:Hide();
local edScale = VFLUI.Edit:new(framew, true); edScale:SetHeight(25); edScale:SetWidth(50);
edScale:SetPoint("TOPRIGHT", windowName, "BOTTOMRIGHT", 0, 0); edScale:Hide();
local slScale = VFLUI.HScrollBar:new(framew, nil, function(value)
	if winframeprops then
		if value == 0 then value = 0.01; end
		DesktopEvents:Dispatch("WINDOW_UPDATE", winframeprops.name, "SCALE", value);
	end
end);
slScale:SetPoint("RIGHT", edScale, "LEFT", -16, 0); slScale:SetWidth(100);
slScale:Hide();
slScale:SetMinMaxValues(.1, 3.0); slScale:SetValue(1, true);
VFLUI.BindSliderToEdit(slScale, edScale);

-- alpha
local lblAlpha = VFLUI.MakeLabel(nil, framew, VFLI.i18n("Alpha:"));
lblAlpha:SetPoint("TOPLEFT", lblScale, "BOTTOMLEFT"); lblAlpha:SetHeight(25); lblAlpha:Hide();
local edAlpha = VFLUI.Edit:new(framew, true); edAlpha:SetHeight(25); edAlpha:SetWidth(50);
edAlpha:SetPoint("TOPRIGHT", edScale, "BOTTOMRIGHT", 0, 0); edAlpha:Hide();
local slAlpha = VFLUI.HScrollBar:new(framew, nil, function(value)
	if winframeprops then
		DesktopEvents:Dispatch("WINDOW_UPDATE", winframeprops.name, "ALPHA", value);
	end
end);
slAlpha:SetPoint("RIGHT", edAlpha, "LEFT", -16, 0); slAlpha:SetWidth(100);
slAlpha:Hide();
slAlpha:SetMinMaxValues(0, 1); slAlpha:SetValue(1, true);
VFLUI.BindSliderToEdit(slAlpha, edAlpha);

-- strata
local lblStrata = VFLUI.MakeLabel(nil, framew, VFLI.i18n("Stratum:"));
lblStrata:SetPoint("TOPLEFT", lblAlpha, "BOTTOMLEFT"); lblStrata:SetHeight(25); lblStrata:Hide();
local ddStrata = VFLUI.Dropdown:new(framew, RDXUI.DesktopStrataFunction, function(value)
	if winframeprops and RDXUI.IsValidStrata(value) then
		DesktopEvents:Dispatch("WINDOW_UPDATE", winframeprops.name, "STRATA", value);
	end
end);
ddStrata:SetPoint("TOPRIGHT", edAlpha, "BOTTOMRIGHT", 0, 0); ddStrata:SetWidth(132);
ddStrata:SetSelection("MEDIUM", true);
ddStrata:Hide();

-- layout
local lblLayout = VFLUI.MakeLabel(nil, framew, VFLI.i18n("Layout units per column:"));
lblLayout:SetPoint("TOPLEFT", lblStrata, "BOTTOMLEFT"); lblLayout:SetHeight(25); lblLayout:Hide();
local ddLayout = VFLUI.Dropdown:new(framew, layoutSel, function(value)
	if winframeprops then
		DesktopEvents:Dispatch("WINDOW_UPDATE", winframeprops.name, "LAYOUT", value);
	end
end);
ddLayout:SetPoint("TOPRIGHT", ddStrata, "BOTTOMRIGHT", 0, 0); ddLayout:SetWidth(60);
ddLayout:SetSelection("10", true);
ddLayout:Hide();

local function SetFramew(froot)
	local _, auiname = RDXDB.ParsePath(RDXU.AUI);
	
	if not RDXU.GlobalScale then RDXU.GlobalScale = {}; end
	local scale = RDXU.GlobalScale[auiname];
	if not scale then scale = 1; end
	slGScale:SetValue(scale);
	
	BuildWindowList(auiname);
	list:Update();
	BuildWindowLessList();
	list2:Update();
	DesktopEvents:Dispatch("DESKTOP_UNLOCK");
end

local function UnsetFramew()
	local _, auiname = RDXDB.ParsePath(RDXU.AUI);
	RDXU.GlobalScale[auiname] = slGScale:GetValue();
	winframeprops = nil;
	RDXDK.SetFramew_window(nil);
	DesktopEvents:Dispatch("DESKTOP_LOCK");
end

function RDXDK.SetFramew_window(frameprops)
	winframeprops = frameprops;
	if frameprops then
		windowName:SetText("|cFF00FF00" .. frameprops.name .. VFLI.i18n(" is selected!|r"));
		if not lblScale:IsShown() then
			lblScale:Show(); edScale:Show(); slScale:Show();
			lblAlpha:Show(); edAlpha:Show(); slAlpha:Show();
			lblStrata:Show(); ddStrata:Show();
			lblLayout:Show(); ddLayout:Show();
		end
		slScale:SetValue(frameprops.scale, true);
		slAlpha:SetValue(frameprops.alpha, true);
		ddStrata:SetSelection(frameprops.strata, true);
		ddLayout:SetSelection(frameprops.raidlayout, true);
	else
		windowName:SetText(VFLI.i18n("Click on a window of your UI to modify it"));
		lblScale:Hide(); edScale:Hide(); slScale:Hide();
		lblAlpha:Hide(); edAlpha:Hide(); slAlpha:Hide();
		lblStrata:Hide(); ddStrata:Hide();
		lblLayout:Hide(); ddLayout:Hide();
	end
end

framew:Hide();

RDXDK.RegisterTool("W", 30, framew, SetFramew, UnsetFramew, true);