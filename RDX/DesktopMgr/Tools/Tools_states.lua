-- OpenRDX
--

local framew = VFLUI.AcquireFrame("Frame");
framew:SetHeight(400); framew:SetWidth(216);

local soloseparator = VFLUI.SeparatorText:new(framew, 1, 216);
soloseparator:SetPoint("TOPLEFT", framew, "TOPLEFT", 5, -5);
soloseparator:SetText(VFLI.i18n("State SOLO"));

local soloselect = VFLUI.OKButton:new(framew);
soloselect:SetText(VFLI.i18n("OnEnter")); soloselect:SetHeight(25); soloselect:SetWidth(100);
soloselect:SetPoint("TOPLEFT", soloseparator, "BOTTOMLEFT");
soloselect:Show();

--local solounselect = VFLUI.OKButton:new(framew);
--solounselect:SetText(VFLI.i18n("OnLeave")); solounselect:SetHeight(25); solounselect:SetWidth(100);
--solounselect:SetPoint("TOPLEFT", soloselect, "TOPRIGHT");
--solounselect:Show();

local partyseparator = VFLUI.SeparatorText:new(framew, 1, 216);
partyseparator:SetPoint("TOPLEFT", soloselect, "BOTTOMLEFT", 0, -5);
partyseparator:SetText(VFLI.i18n("State PARTY"));

local partyselect = VFLUI.OKButton:new(framew);
partyselect:SetText(VFLI.i18n("OnEnter")); partyselect:SetHeight(25); partyselect:SetWidth(100);
partyselect:SetPoint("TOPLEFT", partyseparator, "BOTTOMLEFT");
partyselect:Show();

--local partyunselect = VFLUI.OKButton:new(framew);
--partyunselect:SetText(VFLI.i18n("OnLeave")); partyunselect:SetHeight(25); partyunselect:SetWidth(100);
--partyunselect:SetPoint("TOPLEFT", partyselect, "TOPRIGHT");
--partyunselect:Show();

local raidseparator = VFLUI.SeparatorText:new(framew, 1, 216);
raidseparator:SetPoint("TOPLEFT", partyselect, "BOTTOMLEFT", 0, -5);
raidseparator:SetText(VFLI.i18n("State RAID"));

local raidselect = VFLUI.OKButton:new(framew);
raidselect:SetText(VFLI.i18n("OnEnter")); raidselect:SetHeight(25); raidselect:SetWidth(100);
raidselect:SetPoint("TOPLEFT", raidseparator, "BOTTOMLEFT");
raidselect:Show();

--local raidunselect = VFLUI.OKButton:new(framew);
--raidunselect:SetText(VFLI.i18n("OnLeave")); raidunselect:SetHeight(25); raidunselect:SetWidth(100);
--raidunselect:SetPoint("TOPLEFT", raidselect, "TOPRIGHT");
--raidunselect:Show();

local bgseparator = VFLUI.SeparatorText:new(framew, 1, 216);
bgseparator:SetPoint("TOPLEFT", raidselect, "BOTTOMLEFT", 0, -5);
bgseparator:SetText(VFLI.i18n("State BG"));

local bgselect = VFLUI.OKButton:new(framew);
bgselect:SetText(VFLI.i18n("OnEnter")); bgselect:SetHeight(25); bgselect:SetWidth(100);
bgselect:SetPoint("TOPLEFT", bgseparator, "BOTTOMLEFT");
bgselect:Show();

--local bgunselect = VFLUI.OKButton:new(framew);
--bgunselect:SetText(VFLI.i18n("OnLeave")); bgunselect:SetHeight(25); bgunselect:SetWidth(100);
--bgunselect:SetPoint("TOPLEFT", bgselect, "TOPRIGHT");
--bgunselect:Show();

local arenaseparator = VFLUI.SeparatorText:new(framew, 1, 216);
arenaseparator:SetPoint("TOPLEFT", bgselect, "BOTTOMLEFT", 0, -5);
arenaseparator:SetText(VFLI.i18n("State ARENA"));

local arenaselect = VFLUI.OKButton:new(framew);
arenaselect:SetText(VFLI.i18n("OnEnter")); arenaselect:SetHeight(25); arenaselect:SetWidth(100);
arenaselect:SetPoint("TOPLEFT", arenaseparator, "BOTTOMLEFT");
arenaselect:Show();

--local arenaunselect = VFLUI.OKButton:new(framew);
--arenaunselect:SetText(VFLI.i18n("OnLeave")); arenaunselect:SetHeight(25); arenaunselect:SetWidth(100);
--arenaunselect:SetPoint("TOPLEFT", arenaselect, "TOPRIGHT");
--arenaunselect:Show();

local testseparator = VFLUI.SeparatorText:new(framew, 1, 216);
testseparator:SetPoint("TOPLEFT", arenaselect, "BOTTOMLEFT", 0, -5);
testseparator:SetText(VFLI.i18n("Test state"));

local solo = VFLUI.OKButton:new(framew);
solo:SetText(VFLI.i18n("SOLO")); solo:SetHeight(25); solo:SetWidth(100);
solo:SetPoint("TOPLEFT", testseparator, "BOTTOMLEFT");
solo:Show();
solo:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "SOLO");
end);

local party = VFLUI.OKButton:new(framew);
party:SetText(VFLI.i18n("PARTY")); party:SetHeight(25); party:SetWidth(100);
party:SetPoint("TOPLEFT", solo, "BOTTOMLEFT");
party:Show();
party:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "PARTY");
end);

local raid = VFLUI.OKButton:new(framew);
raid:SetText(VFLI.i18n("RAID")); raid:SetHeight(25); raid:SetWidth(100);
raid:SetPoint("TOPLEFT", party, "BOTTOMLEFT");
raid:Show();
raid:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "RAID");
end);

local bg = VFLUI.OKButton:new(framew);
bg:SetText(VFLI.i18n("BG")); bg:SetHeight(25); bg:SetWidth(100);
bg:SetPoint("TOPLEFT", raid, "BOTTOMLEFT");
bg:Show();
bg:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "BATTLEGROUND");
end);

local arena = VFLUI.OKButton:new(framew);
arena:SetText(VFLI.i18n("ARENA")); arena:SetHeight(25); arena:SetWidth(100);
arena:SetPoint("TOPLEFT", bg, "BOTTOMLEFT");
arena:Show();
arena:SetScript("OnClick", function()
	DesktopEvents:Dispatch("DESKTOP_STATE", "ARENA");
end);


local function SetFramew(froot)
	if not froot.states then
		froot.states = {}
		froot.states["SOLO"] = {};
		froot.states["SOLO"].OnSelect = {};
		--froot.states["SOLO"].OnUnselect = {};
		froot.states["PARTY"] = {};
		froot.states["PARTY"].OnSelect = {};
		--froot.states["PARTY"].OnUnselect = {};
		froot.states["RAID"] = {};
		froot.states["RAID"].OnSelect = {};
		--froot.states["RAID"].OnUnselect = {};
		froot.states["BATTLEGROUND"] = {};
		froot.states["BATTLEGROUND"].OnSelect = {};
		--froot.states["BATTLEGROUND"].OnUnselect = {};
		froot.states["ARENA"] = {};
		froot.states["ARENA"].OnSelect = {};
		--froot.states["ARENA"].OnUnselect = {};
	end
	
	soloselect:SetScript("OnClick", function()
		RDXDK.EditStateActionDialog(framew, froot.states["SOLO"].OnSelect);
	end);
	--solounselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["SOLO"].OnUnselect);
	--end);
	partyselect:SetScript("OnClick", function()
		RDXDK.EditStateActionDialog(framew, froot.states["PARTY"].OnSelect);
	end);
	--partyunselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["PARTY"].OnUnselect);
	--end);
	raidselect:SetScript("OnClick", function()
		RDXDK.EditStateActionDialog(framew, froot.states["RAID"].OnSelect);
	end);
	--raidunselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["RAID"].OnUnselect);
	--end);
	bgselect:SetScript("OnClick", function()
		RDXDK.EditStateActionDialog(framew, froot.states["BATTLEGROUND"].OnSelect);
	end);
	--bgunselect:SetScript("OnClick", function()
	--	RDXDK.EditStateActionDialog(framew, froot.states["BATTLEGROUND"].OnUnselect);
	--end);
	arenaselect:SetScript("OnClick", function()
		RDXDK.EditStateActionDialog(framew, froot.states["ARENA"].OnSelect);
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