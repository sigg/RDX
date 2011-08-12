-- GameTooltip.lua

-- use to style gametooltip

local TooltipsList = {
	GameTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	WorldMapTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
};

function RDXDK.SetGameTooltipBackdrop(bkdp)
	for i = 1, #tooltips do
		VFLUI.SetBackdrop(TooltipsList[i], bkdp);
	end
end

function RDXDK.SetGameTooltipFont(font)
	VFLUI.SetFont(GameTooltipHeaderText, font, font.size + 3, true);
	VFLUI.SetFont(GameTooltipText, font, nil, true);
	VFLUI.SetFont(GameTooltipTextSmall, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip1TextLeft1, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip1TextLeft2, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip1TextLeft3, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip2TextLeft1, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip2TextLeft2, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip2TextLeft3, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip3TextLeft1, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip3TextLeft2, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip3TextLeft3, font, nil, true);
	
	for i = 1, ShoppingTooltip1:NumLines() do
		VFLUI.SetFont(_G["ShoppingTooltip1TextRight"..i], font, nil, true);
	end
	for i = 1, ShoppingTooltip2:NumLines() do
		VFLUI.SetFont(_G["ShoppingTooltip2TextRight"..i], font, nil, true);
	end
	for i = 1, ShoppingTooltip3:NumLines() do
		VFLUI.SetFont(_G["ShoppingTooltip3TextRight"..i], font, nil, true);
	end
	
	if GameTooltipMoneyFrame1 then
		VFLUI.SetFont(GameTooltipMoneyFrame1PrefixText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1SuffixText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1CopperButtonText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1SilverButtonText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1GoldButtonText, font, nil, true);
	end
end

function RDXDK.SetGameTooltipSB(font)
	--GameTooltipStatusBar:SetStatusBarTexture
	--GameTooltipStatusBar:SetSBarColor
end



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