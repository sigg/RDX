
--
-- TAB nampelates
--
local framen = VFLUI.AcquireFrame("Frame");
framen:SetHeight(400); framen:SetWidth(216);

local updateNameplate = nil;

local separator1 = VFLUI.SeparatorText:new(framen, 1, 216);
separator1:SetPoint("TOPLEFT", framen, "TOPLEFT", 5, -5);
separator1:SetText("Nameplates");

local lblfont = VFLUI.MakeLabel(nil, framen, VFLI.i18n("Fnt"));
lblfont:SetWidth(34); lblfont:SetPoint("TOPLEFT", separator1, "BOTTOMLEFT", 0, -15);
local dd_font = VFLUI.MakeFontSelectButton(framen, nil, function() updateNameplate(); end, nil); 
dd_font:SetPoint("LEFT", lblfont, "RIGHT");
dd_font:Show();

local lblsb = VFLUI.MakeLabel(nil, framen, VFLI.i18n("Sb"));
lblsb:SetWidth(34); lblsb:SetPoint("TOPLEFT", lblfont, "BOTTOMLEFT", 0, -15);
local dd_btexture = VFLUI.MakeTextureSelectButton(framen, nil, function() updateNameplate(); end, nil); 
dd_btexture:SetPoint("LEFT", lblsb, "RIGHT");
dd_btexture:Show();

local nptemp = nil ;

updateNameplate = function()
	local desc = {};
	--desc.tooltipmouse = chk_tooltipmouse:GetChecked();
	--desc.anchorx = ggtemp.anchorx;
	--desc.anchory = ggtemp.anchory;
	--desc.bkd = dd_bkd:GetSelectedBackdrop();
	desc.font = dd_font:GetSelectedFont();
	desc.tex = dd_btexture:GetSelectedTexture();
	--desc.showTarget = chk_showTarget:GetChecked();
	--desc.showDiffColor = chk_showDiffColor:GetChecked();
	--desc.showTextBar = chk_showTextBar:GetChecked();
	--desc.hideInCombat = chk_hideInCombat:GetChecked();
	--desc.showTalent = chk_showTalent:GetChecked();
	DesktopEvents:Dispatch("DESKTOP_NAMEPLATE", desc, true);
end

local function SetFramen(froot)
	local desc = froot.nameplates;
	if desc then
		nptemp = desc;
		--if desc.tooltipmouse then chk_tooltipmouse:SetChecked(true); else chk_tooltipmouse:SetChecked(); end
		--dd_bkd:SetSelectedBackdrop(desc.bkd);
		dd_font:SetSelectedFont(desc.font);
		dd_btexture:SetSelectedTexture(desc.tex);
		--if desc.showTarget then chk_showTarget:SetChecked(true); else chk_showTarget:SetChecked(); end
		--if desc.showDiffColor then chk_showDiffColor:SetChecked(true); else chk_showDiffColor:SetChecked(); end
		--if desc.showTextBar then chk_showTextBar:SetChecked(true); else chk_showTextBar:SetChecked(); end
		--if desc.hideInCombat then chk_hideInCombat:SetChecked(true); else chk_hideInCombat:SetChecked(); end
		--if desc.showTalent then chk_showTalent:SetChecked(true); else chk_showTalent:SetChecked(); end
	end
end

local function UnsetFramen()

end

framen:Hide();

RDXDK.RegisterTool("N", 30, framen, SetFramen, UnsetFramen);