--local updateCombatText = nil;
--local separator6 = VFLUI.SeparatorText:new(ca, 1, 216);
--separator6:SetPoint("TOPLEFT", lblsb, "BOTTOMLEFT", 0, -5);
--separator6:SetText("Combat Text Font");

--local ctffont = VFLUI.MakeLabel(nil, ca, VFLI.i18n("Fnt"));
--ctffont:SetWidth(34); ctffont:SetPoint("TOPLEFT", separator6, "BOTTOMLEFT", 0, -15);
--local dd_ctf_font = VFLUI.MakeFontSelectButton(ca, froot.ctffont, function() updateCombatText(); end, nil); 
--dd_ctf_font:SetPoint("LEFT", ctffont, "RIGHT");
--dd_ctf_font:Show();

--updateCombatText = function()
--	DesktopEvents:Dispatch("DESKTOP_COMBATTEXT", dd_ctf_font:GetSelectedFont());
--end