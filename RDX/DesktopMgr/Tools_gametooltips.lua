
--
-- TAB 3 Game Tooltip
--
local frameg = VFLUI.AcquireFrame("Frame");
frameg:SetHeight(400); frameg:SetWidth(216);

local updateGametooltip = nil;

-- gametooltips
local separator5 = VFLUI.SeparatorText:new(frameg, 1, 216);
separator5:SetPoint("TOPLEFT", frameg, "TOPLEFT", 0, -5);
separator5:SetText("GameTooltips");

local chk_tooltipmouse = VFLUI.Checkbox:new(frameg); chk_tooltipmouse:SetHeight(16); chk_tooltipmouse:SetWidth(200);
chk_tooltipmouse:SetPoint("TOPLEFT", separator5, "BOTTOMLEFT");
chk_tooltipmouse:SetText(VFLI.i18n("Mouse anchor GameTooltip"));
chk_tooltipmouse:Show();
chk_tooltipmouse.check:SetScript("OnClick", function() updateGametooltip(); end);

local lblbkd = VFLUI.MakeLabel(nil, frameg, VFLI.i18n("Bkd"));
lblbkd:SetWidth(34); lblbkd:SetPoint("TOPLEFT", chk_tooltipmouse, "BOTTOMLEFT", 0, -15);
local dd_bkd = VFLUI.MakeBackdropSelectButton(frameg, nil, function() updateGametooltip(); end, nil); 
dd_bkd:SetPoint("LEFT", lblbkd, "RIGHT");
dd_bkd:Show();

local lblfont = VFLUI.MakeLabel(nil, frameg, VFLI.i18n("Fnt"));
lblfont:SetWidth(34); lblfont:SetPoint("TOPLEFT", lblbkd, "BOTTOMLEFT", 0, -15);
local dd_font = VFLUI.MakeFontSelectButton(frameg, nil, function() updateGametooltip(); end, nil); 
dd_font:SetPoint("LEFT", lblfont, "RIGHT");
dd_font:Show();

local lblsb = VFLUI.MakeLabel(nil, frameg, VFLI.i18n("Sb"));
lblsb:SetWidth(34); lblsb:SetPoint("TOPLEFT", lblfont, "BOTTOMLEFT", 0, -15);
local dd_btexture = VFLUI.MakeTextureSelectButton(frameg, nil, function() updateGametooltip(); end, nil); 
dd_btexture:SetPoint("LEFT", lblsb, "RIGHT");
dd_btexture:Show();

local ggtemp = nil ;

updateGametooltip = function()
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP", chk_tooltipmouse:GetChecked(), ggtemp.anchorx, ggtemp.anchory, dd_bkd:GetSelectedBackdrop(), dd_font:GetSelectedFont(), dd_btexture:GetSelectedTexture());
end

local function SetFrameg(froot)
	ggtemp = froot;
	if froot.tooltipmouse then chk_tooltipmouse:SetChecked(true); else chk_tooltipmouse:SetChecked(); end
	dd_bkd:SetSelectedBackdrop(froot.bkd);
	dd_font:SetSelectedFont(froot.font);
	dd_btexture:SetSelectedTexture(froot.tex);
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP_UNLOCK");
end

local function UnsetFrameg()
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP_LOCK");
end

frameg:Hide();

RDXDK.RegisterTool("GameTooltip", 100, frameg, SetFrameg, UnsetFrameg);