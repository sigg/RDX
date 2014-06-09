-- Core.lua
-- Sigg

RDXMAP = RegisterVFLModule({
	name = "Map";
	title = VFLI.i18n("Map");
	description = "Map";
	version = {1,0,0};
	parent = RDX;
});

RDXMAP.Map = {};
RDXMAP.ContCnt = 6;
Nx = {};

----------------------------------
-- Map Database local
----------------------------------

local mapid, mapName;

local function __RDXParser()
	SetMapToCurrentZone();
	mapid = GetCurrentMapAreaID();
	--VFL.print(mapid);
	if mapid then
		mapName = GetMapNameByID(mapid);
		RDXLocalMapDB[mapid] = mapName;
	end
end

VFLP.RegisterFunc("RDXSS: Spell System", "Parser", __RDXParser, true);

local function EnableStoreLocalMapDB()
	--if not RDXG.localSpellDBVersion or RDXG.localSpellDBVersion ~= RDX.GetVersion() or not RDXG.localSpellDBClient or RDXG.localSpellDBClient ~= GetLocale() then
	--	RDX.printI("RESET Local spell DB");
	--	VFL.empty(RDXLocalSpellDB);
	--	RDXLocalSpellDB = {};
	--	RDXG.localSpellDBVersion = RDX.GetVersion();
	--	RDXG.localSpellDBClient = GetLocale();
	--end
	--VFL.print("EnableStoreLocalMapDB");
	RDXG.localMapDB = true;
	WoWEvents:Unbind("localMapDB");
	WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, __RDXParser, "localMapDB");
	WoWEvents:Bind("ZONE_CHANGED_NEW_AREA", nil, __RDXParser, "localMapDB");
	--VFLT.AdaptiveSchedule2("vcc", 1, __RDXParser);
end

local function DisableStoreLocalMapDB()
	RDXG.localMapDB = nil;
	WoWEvents:Unbind("localMapDB");
end

function RDXMAP.ToggleStoreLocalMapDB()
	if RDXG.localMapDB then
		DisableStoreLocalMapDB();
		RDX.printI(VFLI.i18n("Disable Store Local Map DB"));
	else
		EnableStoreLocalMapDB();
		RDX.printI(VFLI.i18n("Enable Store Local Map DB"));
	end
end

function RDXMAP.IsStoreLocalMapDB()
	return RDXG.localMapDB;
end

--RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
--	if not RDXLocalMapDB then RDXLocalMapDB = {}; end
--	EnableStoreLocalMapDB();
--end);

TargetEvents = DispatchTable:new();

RDXMAP.Targets = {};
RDXMAP.TargetNextUniqueId = 1;
RDXMAP.Tracking = {};
RDXMAP.TrackPlyrs = {};
RDXMAP.PlyrNames = {};
RDXMAP.PlyrNames = {};
RDXMAP.AFKers = {};
RDXMAP.PlyrNamesTipStr = "";

RDXMAP.BGTimers = {};


-- Global options should be here

-- Global Map
local dlg = nil;

local function CreateMap(parent)
	dlg = VFLUI.Window:new(parent);
	--dlg = VFLUI.AcquireFrame("Frame");
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	--dlg:SetPoint("CENTER", RDXParent, "CENTER");
	--dlg:SetWidth(1000); dlg:SetHeight(800);
	dlg:SetAllPoints(RDXParent)
	dlg:SetText("Central map");
	dlg:SetClampedToScreen(true);
	--VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	--if RDXPM.Ismanaged("Central map") then RDXPM.RestoreLayout(dlg, "Central map"); end

	--local esch = function()
		--dlg:_Hide(RDX.smooth, nil, function()
		--	RDXPM.StoreLayout(dlg, "blizzard_desktop");
		--	dlg:Destroy(); dlg = nil;
		--end);
		--dlg:Hide();
	--end
	
	--VFL.AddEscapeHandler(esch);
	
	--function dlg:_esch()
	--	VFL.EscapeTo(esch);
	--end
	
	--local function Save()
		
	--	VFL.EscapeTo(esch);
	--end
	local ca = dlg:GetClientArea()
	
	if not RDXG.GMap then
		RDXG.GMap = {};
		RDXG.GMap.NXAutoScaleOn = true;
		RDXG.GMap.NXKillShow = false;
		RDXG.GMap.NXMMFull = false;
		RDXG.GMap.NXMMAlpha = .1;
		RDXG.GMap.NXMMDockScale = .4;
		RDXG.GMap.NXMMDockScaleBG = .4;
		RDXG.GMap.NXMMDockAlpha = 1;
		RDXG.GMap.NXMMDockOnAtScale = .6;
		RDXG.GMap.NXBackgndAlphaFade = .4;
		RDXG.GMap.NXBackgndAlphaFull = 1;
		RDXG.GMap.NXArchAlpha = .3;
		RDXG.GMap.NXQuestAlpha = .3;
		RDXG.GMap.NXAutoScaleMin = .01;
		RDXG.GMap.NXAutoScaleMax = 4;
		RDXG.GMap.NXDotZoneScale = 1;
		RDXG.GMap.NXDotPalScale = 1;
		RDXG.GMap.NXDotPartyScale = 1;
		RDXG.GMap.NXDotRaidScale = 1;
		RDXG.GMap.NXIconNavScale = 1;
		RDXG.GMap.NXIconScale = 1;
		RDXG.GMap.NXDetailScale = 2;
		RDXG.GMap.NXDetailAlpha = 1;
		RDXG.GMap.NXPOIAtScale = 1;
		RDXG.GMap.NXShowUnexplored = false;
		RDXG.GMap.NXUnexploredAlpha = .35;
		RDXG.GMap[0] = {};
		RDXG.GMap[0].NXPlyrFollow = true;
		RDXG.GMap[0].NXWorldShow = true;
	end
	
	local m = RDXMAP.Map:Open(2, RDXG.GMap);
	m.Frm:SetParent(ca);
	m.Frm:SetFrameLevel(ca:GetFrameLevel() + 2);
	--m.Frm:SetAllPoints(ca);
	ca.m = m;
	
	local function layout()
		local w = ca:GetWidth();
		local h = ca:GetHeight();
		m.Frm:ClearAllPoints();
		m.Frm:SetPoint("CENTER", ca, "CENTER");
		m.Frm:SetWidth(w - 2);
		m.Frm:SetHeight(h - 2);
	end
	ca:SetScript("OnShow", layout);
	ca:SetScript("OnSizeChanged", layout);
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	--closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	closebtn:SetScript("OnClick", function() dlg:Hide(); end);
	dlg:AddButton(closebtn);

	-- Destructor
	--dlg.Destroy = VFL.hook(function(s)
		--VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		--ui = nil; sf = nil;
	--end, dlg.Destroy);
	
	dlg:Hide();
end

RDXEvents:Bind("INIT_DESKTOP", nil, function()
	CreateMap(VFLDIALOG)
end);

function RDXMAP.CentralMap(parent)
	dlg:Show();
	--dlg:_Show(RDX.smooth);
end

function RDXMAP.CloseCentralMap()
	dlg:Hide();
end

function RDXMAP.ToggleCentralMap()
	if dlg and dlg:IsShown() then
		RDXMAP.CloseCentralMap();
	else
		RDXMAP.CentralMap(VFLDIALOG);
	end
end

function RDXMAP.IsCentralMapOpen()
	if dlg and dlg:IsShown() then return true; else return nil; end
end






