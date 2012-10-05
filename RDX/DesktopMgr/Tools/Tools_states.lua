-- OpenRDX
--

local framew = VFLUI.AcquireFrame("Frame");
framew:SetHeight(400); framew:SetWidth(216);

local separator = VFLUI.SeparatorText:new(framew, 1, 216);
separator:SetPoint("TOPLEFT", framew, "TOPLEFT", 5, -5);
separator:SetText(VFLI.i18n("States"));

local soloselect = VFLUI.OKButton:new(framew);
soloselect:SetText(VFLI.i18n("SOLO")); soloselect:SetHeight(25); soloselect:SetWidth(216);
soloselect:SetPoint("TOPLEFT", separator, "BOTTOMLEFT");
soloselect:Show();

local partyselect = VFLUI.OKButton:new(framew);
partyselect:SetText(VFLI.i18n("PARTY")); partyselect:SetHeight(25); partyselect:SetWidth(216);
partyselect:SetPoint("TOPLEFT", soloselect, "BOTTOMLEFT");
partyselect:Show();

local raidselect = VFLUI.OKButton:new(framew);
raidselect:SetText(VFLI.i18n("RAID")); raidselect:SetHeight(25); raidselect:SetWidth(216);
raidselect:SetPoint("TOPLEFT", partyselect, "BOTTOMLEFT");
raidselect:Show();

local bgselect = VFLUI.OKButton:new(framew);
bgselect:SetText(VFLI.i18n("BG")); bgselect:SetHeight(25); bgselect:SetWidth(216);
bgselect:SetPoint("TOPLEFT", raidselect, "BOTTOMLEFT");
bgselect:Show();

local arenaselect = VFLUI.OKButton:new(framew);
arenaselect:SetText(VFLI.i18n("ARENA")); arenaselect:SetHeight(25); arenaselect:SetWidth(216);
arenaselect:SetPoint("TOPLEFT", bgselect, "BOTTOMLEFT");
arenaselect:Show();

local testseparator = VFLUI.SeparatorText:new(framew, 1, 216);
testseparator:SetPoint("TOPLEFT", arenaselect, "BOTTOMLEFT", 0, -5);
testseparator:SetText(VFLI.i18n("Test"));

local solo = VFLUI.OKButton:new(framew);
solo:SetText(VFLI.i18n("SOLO")); solo:SetHeight(25); solo:SetWidth(216);
solo:SetPoint("TOPLEFT", testseparator, "BOTTOMLEFT");
solo:Show();
solo:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "SOLO");
end);

local party = VFLUI.OKButton:new(framew);
party:SetText(VFLI.i18n("PARTY")); party:SetHeight(25); party:SetWidth(216);
party:SetPoint("TOPLEFT", solo, "BOTTOMLEFT");
party:Show();
party:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "PARTY");
end);

local raid = VFLUI.OKButton:new(framew);
raid:SetText(VFLI.i18n("RAID")); raid:SetHeight(25); raid:SetWidth(216);
raid:SetPoint("TOPLEFT", party, "BOTTOMLEFT");
raid:Show();
raid:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "RAID");
end);

local bg = VFLUI.OKButton:new(framew);
bg:SetText(VFLI.i18n("BG")); bg:SetHeight(25); bg:SetWidth(216);
bg:SetPoint("TOPLEFT", raid, "BOTTOMLEFT");
bg:Show();
bg:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "BATTLEGROUND");
end);

local arena = VFLUI.OKButton:new(framew);
arena:SetText(VFLI.i18n("ARENA")); arena:SetHeight(25); arena:SetWidth(216);
arena:SetPoint("TOPLEFT", bg, "BOTTOMLEFT");
arena:Show();
arena:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "ARENA");
end);

local resetseparator = VFLUI.SeparatorText:new(framew, 1, 216);
resetseparator:SetPoint("TOPLEFT", arena, "BOTTOMLEFT", 0, -5);
resetseparator:SetText(VFLI.i18n("Options"))

local reset = VFLUI.OKButton:new(framew);
reset:SetText(VFLI.i18n("Reset states to default")); reset:SetHeight(25); reset:SetWidth(216);
reset:SetPoint("TOPLEFT", resetseparator, "BOTTOMLEFT");
reset:Show();
reset:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_RESETSTATE");
end);


local function SetFramew(froot)
	
	soloselect:SetScript("OnClick", function()
		if froot.states and froot.states.SOLO then
			RDXDK.EditStateActionDialog(framew, froot.states.SOLO.OnSelect);
		end
	end);
	--solounselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["SOLO"].OnUnselect);
	--end);
	partyselect:SetScript("OnClick", function()
		if froot.states and froot.states.PARTY then
			RDXDK.EditStateActionDialog(framew, froot.states.PARTY.OnSelect);
		end
	end);
	--partyunselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["PARTY"].OnUnselect);
	--end);
	raidselect:SetScript("OnClick", function()
		if froot.states and froot.states.RAID then
			RDXDK.EditStateActionDialog(framew, froot.states.RAID.OnSelect);
		end
	end);
	--raidunselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["RAID"].OnUnselect);
	--end);
	bgselect:SetScript("OnClick", function()
		if froot.states and froot.states.BATTLEGROUND then
			RDXDK.EditStateActionDialog(framew, froot.states.BATTLEGROUND.OnSelect);
		end
	end);
	--bgunselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["BATTLEGROUND"].OnUnselect);
	--end);
	arenaselect:SetScript("OnClick", function()
		if froot.states and froot.states.ARENA then
			RDXDK.EditStateActionDialog(framew, froot.states.ARENA.OnSelect);
		end
	end);
	--arenaunselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["ARENA"].OnUnselect);
	--end);
end

local function UnsetFramew(froot)
	soloselect:SetScript("OnClick", nil);
	--solounselect:SetScript("OnClick", nil);
	partyselect:SetScript("OnClick", nil);
	--partyunselect:SetScript("OnClick", nil);
	raidselect:SetScript("OnClick", nil);
	--raidunselect:SetScript("OnClick", nil);
	bgselect:SetScript("OnClick", nil);
	--bgunselect:SetScript("OnClick", nil);
	arenaselect:SetScript("OnClick", nil);
	--arenaunselect:SetScript("OnClick", nil);
end

framew:Hide();
RDXDK.RegisterTool("S", 30, framew, SetFramew, UnsetFramew, true);