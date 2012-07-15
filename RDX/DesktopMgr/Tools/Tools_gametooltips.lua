
--
-- TAB 3 Game Tooltip
--
local frameg = VFLUI.AcquireFrame("Frame");
frameg:SetHeight(400); frameg:SetWidth(216);

local updateGametooltip = nil;

-- gametooltips
local separator5 = VFLUI.SeparatorText:new(frameg, 1, 216);
separator5:SetPoint("TOPLEFT", frameg, "TOPLEFT", 5, -5);
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

local chk_showTarget = VFLUI.Checkbox:new(frameg); chk_showTarget:SetHeight(16); chk_showTarget:SetWidth(200);
chk_showTarget:SetPoint("TOPLEFT", lblsb, "BOTTOMLEFT", 0, -15);
chk_showTarget:SetText(VFLI.i18n("Show Target"));
chk_showTarget:Show();
chk_showTarget.check:SetScript("OnClick", function() updateGametooltip(); end);

local chk_showDiffColor = VFLUI.Checkbox:new(frameg); chk_showDiffColor:SetHeight(16); chk_showDiffColor:SetWidth(200);
chk_showDiffColor:SetPoint("TOPLEFT", chk_showTarget, "BOTTOMLEFT");
chk_showDiffColor:SetText(VFLI.i18n("Show Enemy Difiiculty color"));
chk_showDiffColor:Show();
chk_showDiffColor.check:SetScript("OnClick", function() updateGametooltip(); end);

local chk_showTextBar = VFLUI.Checkbox:new(frameg); chk_showTextBar:SetHeight(16); chk_showTextBar:SetWidth(200);
chk_showTextBar:SetPoint("TOPLEFT", chk_showDiffColor, "BOTTOMLEFT");
chk_showTextBar:SetText(VFLI.i18n("Show Text HP"));
chk_showTextBar:Show();
chk_showTextBar.check:SetScript("OnClick", function() updateGametooltip(); end);

local chk_hideInCombat = VFLUI.Checkbox:new(frameg); chk_hideInCombat:SetHeight(16); chk_hideInCombat:SetWidth(200);
chk_hideInCombat:SetPoint("TOPLEFT", chk_showTextBar, "BOTTOMLEFT");
chk_hideInCombat:SetText(VFLI.i18n("Hide GameTooltip In combat"));
chk_hideInCombat:Show();
chk_hideInCombat.check:SetScript("OnClick", function() updateGametooltip(); end);

local chk_showTalent = VFLUI.Checkbox:new(frameg); chk_showTalent:SetHeight(16); chk_showTalent:SetWidth(200);
chk_showTalent:SetPoint("TOPLEFT", chk_hideInCombat, "BOTTOMLEFT");
chk_showTalent:SetText(VFLI.i18n("Show Talent"));
chk_showTalent:Show();
chk_showTalent.check:SetScript("OnClick", function() updateGametooltip(); end);

local ggtemp = nil ;

updateGametooltip = function()
	local desc = {};
	desc.tooltipmouse = chk_tooltipmouse:GetChecked();
	desc.anchorx = ggtemp.anchorx;
	desc.anchory = ggtemp.anchory;
	desc.bkd = dd_bkd:GetSelectedBackdrop();
	desc.font = dd_font:GetSelectedFont();
	desc.tex = dd_btexture:GetSelectedTexture();
	desc.showTarget = chk_showTarget:GetChecked();
	desc.showDiffColor = chk_showDiffColor:GetChecked();
	desc.showTextBar = chk_showTextBar:GetChecked();
	desc.hideInCombat = chk_hideInCombat:GetChecked();
	desc.showTalent = chk_showTalent:GetChecked();
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
		if desc.showTarget then chk_showTarget:SetChecked(true); else chk_showTarget:SetChecked(); end
		if desc.showDiffColor then chk_showDiffColor:SetChecked(true); else chk_showDiffColor:SetChecked(); end
		if desc.showTextBar then chk_showTextBar:SetChecked(true); else chk_showTextBar:SetChecked(); end
		if desc.hideInCombat then chk_hideInCombat:SetChecked(true); else chk_hideInCombat:SetChecked(); end
		if desc.showTalent then chk_showTalent:SetChecked(true); else chk_showTalent:SetChecked(); end
	end
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP_UNLOCK");
end

local function UnsetFrameg()
	DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP_LOCK");
end

frameg:Hide();

RDXDK.RegisterTool("G", 30, frameg, SetFrameg, UnsetFrameg);