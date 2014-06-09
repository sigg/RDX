-- OpenRDX
--
-------------------
-- helper
-------------------
local showAllZones = nil
local showLowLevel = true
local showHighLevel = nil
local showFinished = true
local showOnlyDailies = nil


local wl = {};
local function BuildQuestsList(filter)
	VFL.empty(wl);
	local mapId = RDXMAP.Map:GetCurrentMapId()
	local minLevel = UnitLevel ("player") - GetQuestGreenRange()
	local maxLevel = showHighLevel and MAX_PLAYER_LEVEL or UnitLevel ("player") + 6
	--local dbTitleIndex = list:ItemGetNum()
	local dbTitleNum = 0
	
	for qId in pairs (Nx.CurCharacter.Q) do			-- Loop over quests with history

		local quest = Nx.Quest.IdToQuest[qId]

		local status, qTime = Nx:GetQuest (qId)
		local qCompleted = status == "C"

		local show = qCompleted

		if show and not showAllZones then
			show = Nx.Quest:CheckShow (mapId, qId)
		end

		if show then

			local qname, side_, lvl

			if quest then
				qname, side_, lvl = Nx.Quest:Unpack (quest[1])
			else
				qname = format ("%s?", qId)
				lvl = 0
			end

--				VFL.vprint ("%s [%s] %s", qname, qId, quest.CNum or "")

			local lvlStr = format ("|cffd0d0d0%2d", lvl)
			local title = qname

			if quest and quest.CNum then
				title = title .. format (" (Part %d)", quest.CNum)
			end

			if showQId then
				title = title .. format (" [%s]", qId)
			end

			local dailyName = ""

			local dailyStr = Nx.Quest.DailyIds[qId] or Nx.Quest.DailyDungeonIds[qId] or Nx.Quest.DailyPVPIds[qId]
			if dailyStr then

				local typ = strsplit ("^", dailyStr)
				dailyName = format (" |cffd060d0(%s)", Nx.Quest.DailyTypes[typ])

				local age = time() - qTime
				local dayChange = 86400 - GetQuestResetTime()

				if age < dayChange then
					dailyName = dailyName .. " |cffff8080today"
				end
			end

			local show = true

			--if self.Filters[self.TabSelected] ~= "" then
			if filter ~= "" then

				local str = strlower (format ("%2d %s %s%s", lvl, title, date ("%m/%d %H:%M:%S", qTime), dailyName))
				--local filtStr = strlower (self.Filters[self.TabSelected])
				local filtStr = strlower (filter)

				show = strfind (str, filtStr, 1, true)
			end

			if show then

				local t = {}
				tinsert (wl, t)

				t.T = qTime
				t.QId = qId

				dbTitleNum = dbTitleNum + 1

				local haveStr = ""

				if Nx.Quest.QIds[qId] then
					haveStr = "|cffe0e0e0+ "
				end

				local color = Nx.Quest:GetDifficultyColor (lvl)
				color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

				t.Desc = format ("%s %s%s%s", lvlStr, haveStr, color, title)
				t.Col4 = format ("%s %s", date ("|cff9f9fcf%m/%d %H:%M:%S", qTime), dailyName)
			end
		end
	end
	table.sort(wl, function(x1,x2) return x1.T>x2.T; end);
	
	--local str = (showAllZones and "All" or Map:IdToName (mapId)) .. " Completed"
	--table.insert
end



-- function to create each row
local function CreateQuestRow()
	local self = VFLUI.AcquireFrame("Button");
	
	-- Create the button highlight texture
	local hltTexture = VFLUI.CreateTexture(self);
	hltTexture:SetAllPoints(self);
	hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	hltTexture:Show();
	self:SetHighlightTexture(hltTexture);

	-- Create the text
	local text = VFLUI.CreateFontString(self);
	text:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));	text:SetJustifyH("LEFT");
	text:SetTextColor(1,1,1,1);
	text:SetPoint("LEFT", self, "LEFT"); text:SetHeight(10); text:SetWidth(280);
	text:Show();
	self.text = text;
	
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	self.Destroy = VFL.hook(function(self)
		-- Destroy allocated regions
		VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
		VFLUI.ReleaseRegion(self.text); self.text = nil;
	end, self.Destroy);

	self.OnDeparent = self.Destroy;

	return self;
end

local function WindowListClick(path)
	--if InCombatLockdown() then return; end	
	--local inst = RDXDB.GetObjectInstance(path, true);
	--if inst then
	--	RDXDB.OpenObject(path, "Close");
	--	return;
	--end
	--RDXDB.OpenObject(path);
end

local function WindowListRightClick(self, path)
	local mnu = {};
	table.insert(mnu, {
		text = VFLI.i18n("Edit Window"),
		OnClick = function()
			VFL.poptree:Release();
			RDXDB.OpenObject(path, "Edit", VFLDIALOG);
		end
	});
	
	VFL.poptree:Begin(150, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
	VFL.poptree:Expand(nil, mnu);
end

--
-- TAB Windows
--
local winframeprops = nil;

local framew = VFLUI.AcquireFrame("Frame");
framew:SetHeight(400); framew:SetWidth(280);

local separator2 = VFLUI.SeparatorText:new(framew, 1, 216);
separator2:SetPoint("TOPLEFT", framew, "TOPLEFT", 5, -5);
separator2:SetText(VFLI.i18n("RDX Windows"));

local list = VFLUI.List:new(framew, 12, CreateQuestRow);
list:SetPoint("TOPLEFT", separator2, "BOTTOMLEFT");
list:SetWidth(280); list:SetHeight(200);
list:Rebuild(); list:Show();

RDXEvents:Bind("INIT_DEFERRED", nil, function()

list:SetDataSource(function(cell, data, pos)

	cell.text:SetText(data.Desc);
	cell:SetScript("OnClick", function(self, arg1)
		if arg1 == "LeftButton" then
			WindowListClick(data); list:Update();
		elseif arg1 == "RightButton" then
			WindowListRightClick(self, data); 
		end
	end);
end, VFL.ArrayLiterator(wl));

end);

--function RDXDK.ToolsWindowUpdate()
--	local _, auiname = RDXDB.ParsePath(RDXU.AUI);
--	BuildWindowList(auiname);
--	list:Update();
--end;



local function SetFramew()
	
	BuildQuestsList("");
	list:Update();
end

local function UnsetFramew()
	
end

framew:Hide();

RDXMAP.RegisterPanel("History", 100, framew, SetFramew, UnsetFramew);