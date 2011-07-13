-- GameTooltip.lua
-- use to move the gametooltip

local usemouse, anchorx, anchory = nil, 0, 0;
local style = {};

local btn = VFLUI.Button:new();
btn:SetHeight(100); btn:SetWidth(100);
btn:SetText(VFLI.i18n("GameTooltip"));
btn:SetClampedToScreen(true);
btn:SetFrameStrata("FULLSCREEN_DIALOG");
btn:Hide();

function RDXDK.SetGameTooltipLocation(mb, x, y)
	usemouse, anchorx, anchory = mb, x, y;
	if x and y then
		btn:ClearAllPoints();
		btn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", x, y);
	end
end

-- move game tooltip
-- on desktop unlock
function RDXDK.SetUnlockGameTooltip()
	btn:ClearAllPoints();
	btn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", anchorx, anchory);
	btn:Show();
	btn:SetMovable(true);
	btn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	btn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing(); anchorx,_,_,anchory = VFLUI.GetUniversalBoundary(btn); end);
end

-- on desktop lock
function RDXDK.GetLockGameTooltip()
	btn:SetMovable(nil);
	btn:SetScript("OnMouseDown", nil);
	btn:SetScript("OnMouseUp", nil);
	btn:Hide();
	return usemouse, anchorx, anchory;
end

-- Add option to disable tooltip
-- option dgr managed in globalSettings
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	local opt =  RDXU.disablebliz2;
	if opt and opt.toolposition then
		hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
			if usemouse then
				GameTooltip:SetOwner(parent, "ANCHOR_CURSOR");
			else
				GameTooltip:SetOwner(parent, "ANCHOR_NONE");
				GameTooltip:SetPoint("CENTER", btn, "CENTER");
			end
		end);
	end
	--if opt and opt.tooltipunit then
		-- hide the game tooltip for unit only
	--	GameTooltip:SetScript("OnTooltipSetUnit",function()
	--		if GameTooltipStatusBar then
	--			GameTooltip:Hide();
	--		end
	--	end);
	--end
end);