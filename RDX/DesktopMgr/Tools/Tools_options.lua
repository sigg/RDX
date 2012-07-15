
--
-- TAB Desktop option
--
local framed = VFLUI.AcquireFrame("Frame");
framed:SetHeight(400); framed:SetWidth(216);

-- Viewport
local separator1 = VFLUI.SeparatorText:new(framed, 1, 216);
separator1:SetPoint("TOPLEFT", framed, "TOPLEFT", 5, -5);
separator1:SetText("Viewport"); separator1:Show();

local updateViewport, setViewport;

local chk_viewport = VFLUI.Checkbox:new(framed); chk_viewport:SetHeight(16); chk_viewport:SetWidth(200);
chk_viewport:SetPoint("TOPLEFT", separator1, "BOTTOMLEFT");
chk_viewport:SetText(VFLI.i18n("Activate Viewport"));
chk_viewport:Show();
chk_viewport.check:SetScript("OnClick", function() updateViewport(); end);

local leleft = VFLUI.LabeledEdit:new(framed, 50); leleft:SetHeight(25); leleft:SetWidth(100);
leleft:SetPoint("TOPLEFT", chk_viewport, "BOTTOMLEFT", 0, 0); leleft:SetText(VFLI.i18n("Left")); 
leleft:Show();
leleft.editBox:SetScript("OnTextChanged", function() updateViewport(); end);

local letop = VFLUI.LabeledEdit:new(framed, 50); letop:SetHeight(25); letop:SetWidth(100);
letop:SetPoint("TOPLEFT", leleft, "TOPRIGHT", 0, 0); letop:SetText(VFLI.i18n("Top"));
letop:Show();
letop.editBox:SetScript("OnTextChanged", function() updateViewport(); end);

local leright = VFLUI.LabeledEdit:new(framed, 50); leright:SetHeight(25); leright:SetWidth(100);
leright:SetPoint("TOPLEFT", leleft, "BOTTOMLEFT", 0, 0); leright:SetText(VFLI.i18n("Right")); 
leright:Show();
leright.editBox:SetScript("OnTextChanged", function() updateViewport(); end);

local lebottom = VFLUI.LabeledEdit:new(framed, 50); lebottom:SetHeight(25); lebottom:SetWidth(100);
lebottom:SetPoint("TOPLEFT", leright, "TOPRIGHT", 0, 0); lebottom:SetText(VFLI.i18n("Bottom"));
lebottom:Show();
lebottom.editBox:SetScript("OnTextChanged", function() updateViewport(); end);

setViewport = function(froot)
	if froot.viewport then chk_viewport:SetChecked(true); else chk_viewport:SetChecked(); end
	leleft.editBox:SetText(froot.offsetleft);
	letop.editBox:SetText(froot.offsettop);
	leright.editBox:SetText(froot.offsetright);
	lebottom.editBox:SetText(froot.offsetbottom);
end

updateViewport = function()
	local left = tonumber(leleft.editBox:GetText());
	local top = tonumber(letop.editBox:GetText());
	local right = tonumber(leright.editBox:GetText());
	local bottom = tonumber(lebottom.editBox:GetText());
	if left and top and right and bottom then
		DesktopEvents:Dispatch("DESKTOP_VIEWPORT", chk_viewport:GetChecked(), left, top, right, bottom);
	end
end

-- action bar
local separator4 = VFLUI.SeparatorText:new(framed, 1, 216);
separator4:SetPoint("TOPLEFT", leright, "BOTTOMLEFT", 0, -5);
separator4:SetText("ActionBars"); separator4:Show();

-- button configure keys
local dfkey = nil;
local btndefinekey = VFLUI.OKButton:new(framed);
btndefinekey:SetHeight(25); btndefinekey:SetWidth(216);
btndefinekey:SetPoint("TOPLEFT", separator4, "BOTTOMLEFT", 0, -5);
btndefinekey:SetText(VFLI.i18n("Click to setup your keys")); btndefinekey:Show();
btndefinekey:SetScript("OnClick", function()
	if not InCombatLockdown() then 
		if dfkey then
			btndefinekey:SetText(VFLI.i18n("Click to setup your keys"));
			DesktopEvents:Dispatch("DESKTOP_LOCK_BINDINGS");
			dfkey = nil;
		else
			btndefinekey:SetText(VFLI.i18n("Lock keys setup"));
			DesktopEvents:Dispatch("DESKTOP_UNLOCK_BINDINGS");
			dfkey = true;
		end
	end
end);

--local chk_lockaction = VFLUI.Checkbox:new(ca); chk_lockaction:SetHeight(16); chk_lockaction:SetWidth(200);
--chk_lockaction:SetPoint("TOPLEFT", btndefinekey, "BOTTOMLEFT");
--if RDXDK.IsActionBindingsLocked() then chk_lockaction:SetChecked(true); else chk_lockaction:SetChecked(); end
--chk_lockaction:SetText("Lock drag action button in combat");
--chk_lockaction:Show();
--chk_lockaction.check:SetScript("OnClick", function() RDXDK.ToggleActionBindingsLock(); end);

-- to see if many people is really using this.
--local lbl_keys = VFLUI.MakeLabel(nil, ca, VFLI.i18n("Keys definition"));
--lbl_keys:SetPoint("TOPLEFT", chk_lockaction, "BOTTOMLEFT"); lbl_keys:SetHeight(25);
--local dd_Keys = VFLUI.Dropdown:new(ca, RDXUI.DesktopStrataFunction, function(value)
--end);
--dd_Keys:SetPoint("TOPRIGHT", lbl_keys, "BOTTOMRIGHT", 0, 0); dd_Keys:SetWidth(132);
--dd_Keys:SetSelection(froot.keys, true);
--dd_Keys:Show();

local function SetFramed(froot)
	setViewport(froot);
end

local function UnsetFramed()
	if dfkey then
		DesktopEvents:Dispatch("DESKTOP_LOCK_BINDINGS");
		dfkey = nil;
	end
end

framed:Hide();

RDXDK.RegisterTool("O", 30, framed, SetFramed, UnsetFramed);