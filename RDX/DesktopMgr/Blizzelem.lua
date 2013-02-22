-- Blizzard.lua

local descb = {};

local watchframebtn = VFLUI.Button:new();
watchframebtn:SetHeight(WatchFrame:GetHeight()); 
watchframebtn:SetWidth(WatchFrame:GetWidth());
watchframebtn:SetText(VFLI.i18n("WatchFrame"));
watchframebtn:SetClampedToScreen(true);
watchframebtn:SetFrameStrata("FULLSCREEN_DIALOG");
watchframebtn:Hide();

WatchFrame._ClearAllPoints = WatchFrame.ClearAllPoints;
WatchFrame.ClearAllPoints = VFL.Noop;
WatchFrame._SetPoint = WatchFrame.SetPoint;
WatchFrame.SetPoint = VFL.Noop;

local vehicleseatbtn = VFLUI.Button:new();
vehicleseatbtn:SetHeight(VehicleSeatIndicator:GetHeight()); vehicleseatbtn:SetWidth(VehicleSeatIndicator:GetWidth());
vehicleseatbtn:SetText(VFLI.i18n("VehicleSeatIndicator"));
vehicleseatbtn:SetClampedToScreen(true);
vehicleseatbtn:SetFrameStrata("FULLSCREEN_DIALOG");
vehicleseatbtn:Hide();

VehicleSeatIndicator._ClearAllPoints = VehicleSeatIndicator.ClearAllPoints;
VehicleSeatIndicator.ClearAllPoints = VFL.Noop;
VehicleSeatIndicator._SetPoint = VehicleSeatIndicator.SetPoint;
VehicleSeatIndicator.SetPoint = VFL.Noop;

local durabilitybtn = VFLUI.Button:new();
durabilitybtn:SetHeight(DurabilityFrame:GetHeight()); durabilitybtn:SetWidth(DurabilityFrame:GetWidth());
durabilitybtn:SetText(VFLI.i18n("Durability"));
durabilitybtn:SetClampedToScreen(true);
durabilitybtn:SetFrameStrata("FULLSCREEN_DIALOG");
durabilitybtn:Hide();

DurabilityFrame._ClearAllPoints = DurabilityFrame.ClearAllPoints;
DurabilityFrame.ClearAllPoints = VFL.Noop;
DurabilityFrame._SetPoint = DurabilityFrame.SetPoint;
DurabilityFrame.SetPoint = VFL.Noop;

local extrabtn = VFLUI.Button:new();
extrabtn:SetHeight(ExtraActionBarFrame:GetHeight()); 
extrabtn:SetWidth(ExtraActionBarFrame:GetWidth());
extrabtn:SetText(VFLI.i18n("ExtraActionBar"));
extrabtn:SetClampedToScreen(true);
extrabtn:SetFrameStrata("FULLSCREEN_DIALOG");
extrabtn:Hide();

ExtraActionBarFrame._ClearAllPoints = ExtraActionBarFrame.ClearAllPoints;
ExtraActionBarFrame.ClearAllPoints = VFL.Noop;
ExtraActionBarFrame._SetPoint = ExtraActionBarFrame.SetPoint;
ExtraActionBarFrame.SetPoint = VFL.Noop;

-- /script ExtraActionBarFrame:Show();
-- /script ExtraActionButton1:Show();
-- /script ExtraActionBarFrame:SetAlpha(1);
-- /script ExtraActionBarFrame:SetParent(UIParent);
-- /script ExtraActionBarFrame:SetClampedToScreen(true);
-- /script ExtraActionBarFrame:_ClearAllPoints();
-- /script ExtraActionBarFrame:_SetPoint("CENTER", UIParent, "CENTER");

function __RDXADEBUG()
	ExtraActionBarFrame:Show();
	ExtraActionButton1:Show();
	ExtraActionBarFrame:SetAlpha(1);
end

-- /script __RDXADEBUG()

local playerpowerbaraltbtn = VFLUI.Button:new();
playerpowerbaraltbtn:SetHeight(30); 
playerpowerbaraltbtn:SetWidth(100);
playerpowerbaraltbtn:SetText(VFLI.i18n("PlayerPowerBarAlt"));
playerpowerbaraltbtn:SetClampedToScreen(true);
playerpowerbaraltbtn:SetFrameStrata("FULLSCREEN_DIALOG");
playerpowerbaraltbtn:Hide();

PlayerPowerBarAlt._ClearAllPoints = PlayerPowerBarAlt.ClearAllPoints;
PlayerPowerBarAlt.ClearAllPoints = VFL.Noop;
PlayerPowerBarAlt._SetPoint = PlayerPowerBarAlt.SetPoint;
PlayerPowerBarAlt.SetPoint = VFL.Noop;

local function SetLocation()
	if descb.quest and descb.quest.anchorx and descb.quest.anchory then
		watchframebtn:ClearAllPoints();
		watchframebtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.quest.anchorx, descb.quest.anchory);
		WatchFrame:_ClearAllPoints();
		WatchFrame:_SetPoint("TOPLEFT", watchframebtn, "TOPLEFT");
		WatchFrame:SetHeight(descb.quest.h or 400);
		watchframebtn:SetHeight(descb.quest.h or 400);
	else
		watchframebtn:ClearAllPoints();
		watchframebtn:SetPoint("CENTER", RDXParent, "CENTER", 200, 0);
		WatchFrame:_ClearAllPoints();
		WatchFrame:_SetPoint("TOPLEFT", watchframebtn, "TOPLEFT");
		WatchFrame:SetHeight(400);
		watchframebtn:SetHeight(400);
	end
	if descb.vehicle and descb.vehicle.anchorx and descb.vehicle.anchory then
		vehicleseatbtn:ClearAllPoints();
		vehicleseatbtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.vehicle.anchorx, descb.vehicle.anchory);
		VehicleSeatIndicator:_ClearAllPoints();
		VehicleSeatIndicator:_SetPoint("TOPLEFT", vehicleseatbtn, "TOPLEFT");
	else
		vehicleseatbtn:ClearAllPoints();
		vehicleseatbtn:SetPoint("CENTER", RDXParent, "CENTER", 200, 50);
		VehicleSeatIndicator:_ClearAllPoints();
		VehicleSeatIndicator:_SetPoint("TOPLEFT", vehicleseatbtn, "TOPLEFT");
	end
	if descb.dura and descb.dura.anchorx and descb.dura.anchory then
		durabilitybtn:ClearAllPoints();
		durabilitybtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.dura.anchorx, descb.dura.anchory);
		DurabilityFrame:_ClearAllPoints();
		DurabilityFrame:_SetPoint("TOPLEFT", durabilitybtn, "TOPLEFT");
	else
		durabilitybtn:ClearAllPoints();
		durabilitybtn:SetPoint("CENTER", RDXParent, "CENTER", 200, 50);
		DurabilityFrame:_ClearAllPoints();
		DurabilityFrame:_SetPoint("TOPLEFT", durabilitybtn, "TOPLEFT");
	end
	if descb.extra and descb.extra.anchorx and descb.extra.anchory then
		extrabtn:ClearAllPoints();
		extrabtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.extra.anchorx, descb.extra.anchory);
		ExtraActionBarFrame:_ClearAllPoints();
		ExtraActionBarFrame:_SetPoint("TOPLEFT", extrabtn, "TOPLEFT");
	else
		extrabtn:ClearAllPoints();
		extrabtn:SetPoint("CENTER", RDXParent, "CENTER");
		ExtraActionBarFrame:_ClearAllPoints();
		ExtraActionBarFrame:_SetPoint("TOPLEFT", extrabtn, "TOPLEFT");
	end
	if descb.playerpower and descb.playerpower.anchorx and descb.playerpower.anchory then
		playerpowerbaraltbtn:ClearAllPoints();
		playerpowerbaraltbtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.playerpower.anchorx, descb.playerpower.anchory);
		PlayerPowerBarAlt:_ClearAllPoints();
		PlayerPowerBarAlt:_SetPoint("CENTER", playerpowerbaraltbtn, "CENTER");
	else
		playerpowerbaraltbtn:ClearAllPoints();
		playerpowerbaraltbtn:SetPoint("CENTER", RDXParent, "CENTER");
		PlayerPowerBarAlt:_ClearAllPoints();
		PlayerPowerBarAlt:_SetPoint("CENTER", playerpowerbaraltbtn, "CENTER");
	end
end

-- on desktop update
function RDXDK.SetBlizzard(desc)
	descb = desc;
	if not descb then descb = {}; end
	if not descb.quest then descb.quest = {}; end
	if not descb.vehicle then descb.vehicle = {}; end
	if not descb.dura then descb.dura = {}; end
	if not descb.extra then descb.extra = {}; end
	if not descb.playerpower then descb.playerpower = {}; end
	SetLocation();
end

-- on desktop unlock
-- Show the moving box
function RDXDK.SetUnlockBlizzard()

	if not descb.quest then descb.quest = {}; end
	if not descb.quest.anchorx then descb.quest.anchorx = 400; end
	if not descb.quest.anchory then descb.quest.anchory = 400; end
	
	watchframebtn:ClearAllPoints();
	watchframebtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.quest.anchorx, descb.quest.anchory);
	watchframebtn:Show();
	watchframebtn:SetMovable(true);
	watchframebtn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	watchframebtn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing();
		descb.quest.anchorx,_,_,descb.quest.anchory = VFLUI.GetUniversalBoundary(watchframebtn);
		WatchFrame:_ClearAllPoints();
		WatchFrame:_SetPoint("TOPLEFT", th, "TOPLEFT");
		WatchFrame:SetHeight(200);
	end);
	
	vehicleseatbtn:ClearAllPoints();
	vehicleseatbtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.vehicle.anchorx, descb.vehicle.anchory);
	vehicleseatbtn:Show();
	vehicleseatbtn:SetMovable(true);
	vehicleseatbtn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	vehicleseatbtn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing();
		descb.vehicle.anchorx,_,_,descb.vehicle.anchory = VFLUI.GetUniversalBoundary(vehicleseatbtn);
		VehicleSeatIndicator:_ClearAllPoints();
		VehicleSeatIndicator:_SetPoint("TOPLEFT", th, "TOPLEFT");
	end);
	
	durabilitybtn:ClearAllPoints();
	durabilitybtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.dura.anchorx, descb.dura.anchory);
	durabilitybtn:Show();
	durabilitybtn:SetMovable(true);
	durabilitybtn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	durabilitybtn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing();
		descb.dura.anchorx,_,_,descb.dura.anchory = VFLUI.GetUniversalBoundary(durabilitybtn);
		DurabilityFrame:_ClearAllPoints();
		DurabilityFrame:_SetPoint("TOPLEFT", th, "TOPLEFT");
	end);
	
	extrabtn:ClearAllPoints();
	extrabtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.extra.anchorx, descb.extra.anchory);
	extrabtn:Show();
	extrabtn:SetMovable(true);
	extrabtn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	extrabtn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing();
		descb.extra.anchorx,_,_,descb.extra.anchory = VFLUI.GetUniversalBoundary(extrabtn);
		ExtraActionBarFrame:_ClearAllPoints();
		ExtraActionBarFrame:_SetPoint("TOPLEFT", th, "TOPLEFT");
	end);
	
	if not descb.playerpower then descb.playerpower = {}; end
	if not descb.playerpower.anchorx then descb.playerpower.anchorx = 300; end
	if not descb.playerpower.anchory then descb.playerpower.anchory = 300; end
	
	playerpowerbaraltbtn:ClearAllPoints();
	playerpowerbaraltbtn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descb.playerpower.anchorx, descb.playerpower.anchory);
	playerpowerbaraltbtn:Show();
	playerpowerbaraltbtn:SetMovable(true);
	playerpowerbaraltbtn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	playerpowerbaraltbtn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing();
		descb.playerpower.anchorx,_,_,descb.playerpower.anchory = VFLUI.GetUniversalBoundary(playerpowerbaraltbtn);
		PlayerPowerBarAlt:_ClearAllPoints();
		PlayerPowerBarAlt:_SetPoint("CENTER", th, "CENTER");
	end);
end

-- on desktop lock
-- Hide the moving box
-- return all data to desktop
function RDXDK.GetLockBlizzard()
	watchframebtn:SetMovable(nil);
	watchframebtn:SetScript("OnMouseDown", nil);
	watchframebtn:SetScript("OnMouseUp", nil);
	watchframebtn:Hide();
	
	vehicleseatbtn:SetMovable(nil);
	vehicleseatbtn:SetScript("OnMouseDown", nil);
	vehicleseatbtn:SetScript("OnMouseUp", nil);
	vehicleseatbtn:Hide();
	
	durabilitybtn:SetMovable(nil);
	durabilitybtn:SetScript("OnMouseDown", nil);
	durabilitybtn:SetScript("OnMouseUp", nil);
	durabilitybtn:Hide();
	
	extrabtn:SetMovable(nil);
	extrabtn:SetScript("OnMouseDown", nil);
	extrabtn:SetScript("OnMouseUp", nil);
	extrabtn:Hide();
	
	playerpowerbaraltbtn:SetMovable(nil);
	playerpowerbaraltbtn:SetScript("OnMouseDown", nil);
	playerpowerbaraltbtn:SetScript("OnMouseUp", nil);
	playerpowerbaraltbtn:Hide();
	return descb;
end

-- Hook secure
--RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	--FramePositionDelegate.UIParentManageFramePositions = VFL.hook(
	--	FramePositionDelegate.UIParentManageFramePositions,
	--	function()
			--WatchFrame:ClearAllPoints();
			--WatchFrame:SetPoint("TOPLEFT", watchframebtn, "TOPLEFT");
			--VehicleSeatIndicator:ClearAllPoints();
			--VehicleSeatIndicator:SetPoint("TOPLEFT", vehicleseatbtn, "TOPLEFT");
			--DurabilityFrame:ClearAllPoints();
			--DurabilityFrame:SetPoint("TOPLEFT", durabilitybtn, "TOPLEFT");
	--	end)
--end);