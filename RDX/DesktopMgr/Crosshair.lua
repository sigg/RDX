-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
-- OpenRDX
-- Sigg Rashgarroth EU
-- Desktop Main function
-- Crosshair
-- This file has been removed from toc file
--[[

-------------------------------------------------------
-- The Crosshair
-------------------------------------------------------
local xhbtn = VFLUI.AcquireFrame("Button");
local xhtex = VFLUI.CreateTexture(xhbtn);
xhtex:SetAllPoints(xhbtn);
xhtex:Show();
xhbtn:SetHighlightTexture(xhtex);
xhtex:SetBlendMode("DISABLE");
if RDX._skin == "boomy" then
	xhbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\boomy\\find");
	xhtex:SetTexture("Interface\\Addons\\RDX\\Skin\\boomy\\find");
elseif RDX._skin == "kids" then
	xhbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\kids\\hook");
	xhtex:SetTexture("Interface\\Addons\\RDX\\Skin\\kids\\hook");
else
	xhbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\crosshair");
	xhtex:SetTexture("Interface\\Addons\\RDX\\Skin\\crosshair");
end
xhtex:SetVertexColor(0.6, 0, 0.6);
--RDXEvents:Bind("INIT_PRELOAD", nil, function() RDX.AddToolbarButton(xhbtn, true); end);

local xhdrag = VFLUI.AcquireFrame("Frame");
xhdrag:SetFrameStrata("FULLSCREEN_DIALOG");
xhdrag:SetAllPoints(xhbtn); xhdrag:SetMovable(true); xhdrag:Hide();
local xhdtex = VFLUI.CreateTexture(xhdrag);
xhdtex:SetAllPoints(xhdrag); xhdtex:Show();
if RDX._skin == "boomy" then
	xhdtex:SetTexture("Interface\\Addons\\RDX\\Skin\\boomy\\find");
elseif RDX._skin == "kids" then
	xhdtex:SetTexture("Interface\\Addons\\RDX\\Skin\\kids\\hook");
else
	xhdtex:SetTexture("Interface\\Addons\\RDX\\Skin\\crosshair");
end

-- Added frame overlays to all windows when the crosshair is dragged out.
-- Thanks to VFL's frame recycling system, this isn't expensive at all.
xhbtn:SetScript("OnMouseDown", function()
	if not RDXDK.IsDesktopLocked() then return; end
	xhdrag:Show();
	xhdrag:StartMoving();
end);

xhbtn:SetScript("OnMouseUp", function()
	if not RDXDK.IsDesktopLocked() then return; end
	xhdrag:StopMovingOrSizing();
	xhdrag:SetAllPoints(xhbtn);
	xhdrag:Hide();
	local identMap = RDX.GetIdentMap();
	-- Figure out which window, if any, the mouse is over.
	for ident, win in pairs(identMap) do
		if MouseIsOver(win) then
			RDXDK.FrameProperties(win);
		end
	end
end);

]]