-- OpenRDX
--
-------------------
-- helper
-------------------
local function CheckShow (mapId, index)

	local NxzoneToMapId = Nx.Map.NxzoneToMapId
	local Quest = Nx.Quest

	while true do

		local qId = Quest.Sorted[index]

		if Quest:CheckShow (mapId, qId) then
			return true
		end

		local quest = Quest.IdToQuest[qId]
		local next = Quest:UnpackNext (quest[1])

		if next == 0 then		-- End?
			return
		end

		index = index + 1
	end
end

local showAllZones = nil
local showLowLevel = true
local showHighLevel = nil
local showFinished = true
local showOnlyDailies = nil

local wl = {};
local function BuildQuestsList(filter)
	VFL.empty(wl);
	local mapId = Nx.Map:GetCurrentMapId()
	local minLevel = UnitLevel ("player") - GetQuestGreenRange()
	local maxLevel = showHighLevel and MAX_PLAYER_LEVEL or UnitLevel ("player") + 6
	
	local dbTitleNum = 0
	
	local low = max (1, showLowLevel and 1 or minLevel)
	local high = min (MAX_PLAYER_LEVEL, maxLevel)
	
	local t = {};
	t.title = true;
	t.text = format ("|cffc0c0c0--- Levels %d to %d ---", low, high)
	table.insert(wl, t);
	
	local addBlank
	local inchain
	local showchain
	
	for qsIndex, qId in ipairs (Nx.Quest.Sorted) do
		local quest = Nx.Quest.IdToQuest[qId]
		if not quest then
			VFL.vprint("nil quest %s", qId)
		end
		local qname, side, lvl, minlvl, next = Nx.Quest:Unpack (quest[1])
		local status, qTime = Nx:GetQuest (qId)
		local qCompleted = status == "C"
		
		if not quest.CNum or quest.CNum == 1 then
			addBlank = true
		end
		
		local show = showchain
		if not inchain then

			show = true

			if quest.CLvlMax then
				inchain = true
			end

			if not showLowLevel then
				if quest.CLvlMax then
					show = show and quest.CLvlMax >= minLevel
				else
					show = show and ((lvl == 0) or (lvl >= minLevel))
				end
			end
			show = show and lvl <= maxLevel

			if show and not showAllZones then
				show = CheckShow (mapId, qsIndex)
			end

			showchain = show
		end
		
		if not Nx.Quest.DailyIds[qId] then
			if (not showFinished and qCompleted) or showOnlyDailies then
				show = false
			end
		end
		
		if show then
			local t = {};
			t.quest = quest
			t.qId = qId
			table.insert(wl, t);
			
			dbTitleNum = dbTitleNum + 1;
		end
		
		if next == 0 then
			inchain = false
		end
		
	end
	--table.sort(wl, function(x1,x2) return x1.T>x2.T; end);
	
	local str = (showAllZones and "Full" or Nx.Map:IdToName (mapId)) .. " Database"
	local t = {};
	t.title = true;
	t.text = format("|cffc0c0c0--- %s (%d) ---", str, dbTitleNum)
	table.insert(wl, 1, t);
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

	if data.title then
		cell.text:SetText(data.text);
	else
		local quest = data.quest;
		local qId = data.qId
		local qname, side, lvl, minlvl, next = Nx.Quest:Unpack(quest[1])
		local status, qTime = Nx:GetQuest(qId)
		local qCompleted = status == "C"
		
		local lvlStr = format ("|cffd0d0d0%2d", lvl)
		local title = qname
		
		local cati = Nx.Quest:UnpackCategory (quest[1])
		if cati > 0 then
			title = title .. " <" .. Nx.QuestCategory[cati] .. ">"
		end
		if quest.CNum then
--			if quest.CNum > 1 then
--				lvlStr = "    " .. lvlStr
--			end
			title = title .. format (" (Part %d)", quest.CNum)
		end
		local tag = qCompleted and "(History) " or ""
		local dailyStr = Nx.Quest.DailyIds[qId] or Nx.Quest.DailyDungeonIds[qId]
		if dailyStr then
			local typ, money, rep, req = strsplit ("^", dailyStr)
			tag = format ("|cffd060d0(%s %.2fg", Nx.Quest.DailyTypes[typ], money / 100)
			for n = 0, 1 do	-- Only support 2 reps
				local i = n * 4 + 1
				local repChar = strsub (rep or "", i, i)
				if repChar == "" then
					break
				end
				tag = format ("%s, %s %s", tag, strsub (rep, i + 1, i + 3), Nx.Quest.Reputations[repChar])
			end
			if req and Nx.Quest.Requirements[req] then	-- 1 and 2 (Ally, Horde) not in table
				tag = tag .. ", |cffe0c020Need " .. Nx.Quest.Requirements[req]
			end
			tag = tag .. ")"
		end
		
		--dbTitleNum = dbTitleNum + 1
		local trackMode = Nx.Quest.Tracking[qId] or 0
		local haveStr = ""
		if Nx.Quest.QIds[qId] then
			haveStr = "|cffe0e0e0+ "
		end
		
		local color = Nx.Quest:GetDifficultyColor (lvl)
		color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

		local str = format ("%s %s%s%s", lvlStr, haveStr, color, title)

		if showQId then
			str = str .. format (" [%s]", qId)
		end

		local questTip = "@" .. qId
		cell.text:SetText(str);
		--cell.tag:SetText(tag);
	end
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

RDXMAP.RegisterPanel("Database", 100, framew, SetFramew, UnsetFramew);