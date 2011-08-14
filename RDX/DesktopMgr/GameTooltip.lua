-- GameTooltip.lua

-- use to style gametooltip

local bkdtmp, fonttmp, textmp;

local TooltipsList = {
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	GameTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3,
	ItemRefTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	WorldMapTooltip,
};

--hack
-- Blizzard is repainting the backdrop color in dark blue. only rdx can change the color of the backdrop now.
for i, v in ipairs (TooltipsList) do
	v._SetBackdropColor = v.SetBackdropColor;
	v.SetBackdropColor = VFL.Noop;
	v._SetBackdropBorderColor = v.SetBackdropBorderColor;
	v.SetBackdropBorderColor = VFL.Noop;
	v._SetBackdrop = v.SetBackdrop;
	v.SetBackdrop = VFL.Noop;
end

function RDXDK.SetGameTooltipBackdrop(bkdp)
	if bkdp then bkdtmp = bkdp; end
	for i, v in ipairs (TooltipsList) do
		v:_SetBackdrop(bkdtmp);
		if bkdtmp.br then
			v:_SetBackdropBorderColor(bkdtmp.br or 1, bkdtmp.bg or 1, bkdtmp.bb or 1, bkdtmp.ba or 1);
		else
			v:_SetBackdropBorderColor(1,1,1,1);
		end
		if bkdtmp.kr then
			v:_SetBackdropColor(bkdtmp.kr or 1, bkdtmp.kg or 1, bkdtmp.kb or 1, bkdtmp.ka or 1);
		else
			v:_SetBackdropColor(1,1,1,1);
		end
	end
end

function RDXDK.SetGameTooltipFont(font)
	fonttmp = font;
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

function RDXDK.SetGameTooltipSB(tex)
	textmp = tex;
	GameTooltipStatusBar:SetStatusBarTexture(tex.path);
	--GameTooltipStatusBar:SetSBarColor
end



-- use to move the gametooltip
local usemouse, anchorx, anchory = nil, 0, 0;

local btn = VFLUI.Button:new();
btn:SetHeight(50); btn:SetWidth(100);
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
	return usemouse, anchorx, anchory, bkdtmp, fonttmp, textmp;
end

-- realid
local anchorxrid, anchoryrid = 0, 0;
local btnrid = VFLUI.Button:new();
btnrid:SetHeight(50); btnrid:SetWidth(100);
btnrid:SetText(VFLI.i18n("Realid"));
btnrid:SetClampedToScreen(true);
btnrid:SetFrameStrata("FULLSCREEN_DIALOG");
btnrid:Hide();

function RDXDK.SetRealidLocation(x, y)
	anchorxrid, anchoryrid = x, y;
	if anchorxrid and anchoryrid then
		btnrid:ClearAllPoints();
		btnrid:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", anchorxrid, anchoryrid);
	end
end

function RDXDK.SetUnlockRealid()
	btnrid:ClearAllPoints();
	btnrid:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", anchorxrid, anchoryrid);
	btnrid:Show();
	btnrid:SetMovable(true);
	btnrid:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	btnrid:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing(); anchorxrid,_,_,anchoryrid = VFLUI.GetUniversalBoundary(btnrid); end);
end

-- on desktop lock
function RDXDK.GetLockRealid()
	btnrid:SetMovable(nil);
	btnrid:SetScript("OnMouseDown", nil);
	btnrid:SetScript("OnMouseUp", nil);
	btnrid:Hide();
	return anchorxrid, anchoryrid;
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
	
	local unit, class, item, quality, r, g, b;
	
	-- for unknown reason, item on world map are blue.
	local function fix()
		if bkdtmp.kr then
			GameTooltip:_SetBackdropColor(bkdtmp.kr or 1, bkdtmp.kg or 1, bkdtmp.kb or 1, bkdtmp.ka or 1);
		else
			GameTooltip:_SetBackdropColor(1,1,1,1);
		end
	end
	
	GameTooltip:HookScript("OnShow", fix);
	GameTooltip:HookScript("OnHide", function()
		GameTooltip:_SetBackdropBorderColor(1,1,1,1);
	end);
	GameTooltip:HookScript("OnTooltipSetItem", function()
		fix();
		_,item = GameTooltip:GetItem();
		_,_,quality = GetItemInfo(item);
		r, g, b = GetItemQualityColor(quality);
		if r and g and b then
			GameTooltip:_SetBackdropBorderColor(r,g,b,1);
		end
	end);
	GameTooltip:HookScript("OnTooltipSetUnit", function()
		fix();
		_, unit = GameTooltip:GetUnit();
		_,class = UnitClass(unit);
		GameTooltip:_SetBackdropBorderColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1);
	end);
	
	BNToastFrame_UpdateAnchor = VFL.noop;
	BNToastFrame:ClearAllPoints();
	BNToastFrame:SetPoint("CENTER", btnrid, "CENTER");
end);