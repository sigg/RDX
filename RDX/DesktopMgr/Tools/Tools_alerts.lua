
--
-- TAB Alerts
--
local framea = VFLUI.AcquireFrame("Frame");
framea:SetHeight(400); framea:SetWidth(216);

local function SetFramea(froot)
	DesktopEvents:Dispatch("DESKTOP_ALERTS_UNLOCK");
end

local function UnsetFramea()
	DesktopEvents:Dispatch("DESKTOP_ALERTS_LOCK");
end

framea:Hide();

RDXDK.RegisterTool("A", 30, framea, SetFramea, UnsetFramea);