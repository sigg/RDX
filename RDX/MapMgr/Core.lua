-- Core.lua
-- Sigg

RDXMAP = RegisterVFLModule({
	name = "Map";
	title = VFLI.i18n("Map");
	description = "Map";
	version = {1,0,0};
	parent = RDX;
});

-----------------------
-- RDX Events
-----------------------
RDXMapEvents = DispatchTable:new();
RDXMapEvents.name = "RDXMapEvents";


RDXMAP.Map = {};
RDXMAP.Travel = {};
RDXMAP.ContCnt = 7;

RDXMAP.Hud = {};

RDXMAP.Quest = {};

RDXMAP.Quest.IdToQuest = {};
RDXMAP.Quest.QIds = {};
RDXMAP.Quest.QIdsNew = {};
RDXMAP.Quest.Tracking = {};
RDXMAP.Quest.IconTracking = {};
RDXMAP.Quest.Sorted = {}
RDXMAP.Quest.CurQ = {};
RDXMAP.Quest.RealQ = {}
RDXMAP.Quest.PartyQ = {}
RDXMAP.Quest.IdToCurQ = {}

RDXMAP.Quest.RealQEntries = 0

RDXMAP.Quest.QGivers = {}

RDXMAP.Guide = {}
RDXMAP.Guide.PlayerTargets = {}


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


RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()

	RDXMAP.Map:Init();
	RDXMAP.Travel:Init();
	RDXMAP.Quest:Init();
	RDXMAP.Hud.Create(VFLParent);
	WoWEvents:Bind("TAXIMAP_OPENED", nil, RDXMAP.Travel.OnTaximap_opened);
	
	if not RDXU.MapTargets then RDXU.MapTargets = {}; end
	
	if not RDXU.E then RDXU.E = {}; end
	if not RDXU.Q then RDXU.Q = {}; end
	if not RDXU.Opts then RDXU.Opts = {}; end
	if not RDXU.L then RDXU.L = {}; end
	if not RDXU.W then RDXU.W = {}; end
	if not RDXU.TBar then RDXU.TBar = {}; end
	if not RDXU.Profs then RDXU.Profs = {}; end
	if not RDXU.TBar then RDXU.TBar = {}; end
	
	if not RDXG["TaxiTime"] then RDXG["TaxiTime"] = {}; end
	
	WoWEvents:Bind("MERCHANT_SHOW", nil, RDXMAP.APIGuide.OnMerchant_show);
	WoWEvents:Bind("MERCHANT_UPDATE", nil, RDXMAP.APIGuide.OnMerchant_update);
	WoWEvents:Bind("GOSSIP_SHOW", nil, RDXMAP.APIGuide.OnGossip_show);
	WoWEvents:Bind("TRAINER_SHOW", nil, RDXMAP.APIGuide.OnTrainer_show);
	WoWEvents:Bind("CHAT_MSG_COMBAT_FACTION_CHANGE", nil, RDXMAP.Quest.OnChat_msg_combat_faction_change);

end);



