
local frameb = VFLUI.AcquireFrame("Frame");
frameb:SetHeight(400); frameb:SetWidth(216);

local updateBlizzard = nil;

local separator5 = VFLUI.SeparatorText:new(frameb, 1, 216);
separator5:SetPoint("TOPLEFT", frameb, "TOPLEFT", 5, -5);
separator5:SetText("Blizzard Elements");

local lewh = VFLUI.LabeledEdit:new(frameb, 50); lewh:SetHeight(25); lewh:SetWidth(200);
lewh:SetPoint("TOPLEFT", separator5, "BOTTOMLEFT", 0, 0); lewh:SetText(VFLI.i18n("WatchFrame Height")); 
lewh:Show();
lewh.editBox:SetScript("OnTextChanged", function() updateBlizzard(); end);

local bbtemp = nil ;

updateBlizzard = function()
	if bbtemp and bbtemp.quest then
		bbtemp.quest.h = tonumber(lewh.editBox:GetText());
	end
	DesktopEvents:Dispatch("DESKTOP_BLIZZARD", bbtemp);
end

local function SetFrameb(froot)
	local desc = froot.blizzard;
	if desc then
		bbtemp = desc;
		if desc and desc.quest then
			lewh.editBox:SetText(desc.quest.h or 400);
		end
	end
	DesktopEvents:Dispatch("DESKTOP_BLIZZARD_UNLOCK");
end

local function UnsetFrameb()
	DesktopEvents:Dispatch("DESKTOP_BLIZZARD_LOCK");
end

frameb:Hide();

RDXDK.RegisterTool("B", 30, frameb, SetFrameb, UnsetFrameb);