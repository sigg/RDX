
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
	local desc = {};
	desc.tooltipmouse = chk_tooltipmouse:GetChecked();
	desc.anchorx = ggtemp.anchorx;
	desc.anchory = ggtemp.anchory;
	desc.bkd = dd_bkd:GetSelectedBackdrop();
	desc.font = dd_font:GetSelectedFont();
	desc.tex = dd_btexture:GetSelectedTexture();
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP", desc);
end

local function SetFrameg(froot)
	local desc = froot.gametooltip;
	if desc then
		ggtemp = desc;
		if desc.tooltipmouse then chk_tooltipmouse:SetChecked(true); else chk_tooltipmouse:SetChecked(); end
		dd_bkd:SetSelectedBackdrop(desc.bkd);
		dd_font:SetSelectedFont(desc.font);
		dd_btexture:SetSelectedTexture(desc.tex);
	end
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP_UNLOCK");
end

local function UnsetFrameg()
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP_LOCK");
end

frameg:Hide();

RDXDK.RegisterTool("GameTooltip", 100, frameg, SetFrameg, UnsetFrameg);