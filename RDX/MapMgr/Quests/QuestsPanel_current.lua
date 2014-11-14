-- OpenRDX
--
-------------------
-- helper
-------------------

local cur
local qId
local quest
local title
local level
local tag
local isComplete
local qn
local onQ
local onQStr
local lvlStr
local header
local oldSel
local show
local color
local nameStr

local ShowQuest;

local driver = VFLUI.DisjointRadioGroup:new(true);

local wl = {};
local function BuildQuestsList(filter)
	VFL.empty(wl);
	
	if not RDXU.mapSettings then RDXU.mapSettings = {} end;
	if not RDXU.mapSettings.cquests then RDXU.mapSettings.cquests = {}; end
	if not RDXU.mapSettings.cquests.hide then RDXU.mapSettings.cquests.hide = {}; end
	
	oldSel = GetQuestLogSelection()
	
	for n = 1, RDXMAP.Quest.CurQ and #RDXMAP.Quest.CurQ or 0 do		
		cur = RDXMAP.Quest.CurQ[n]
		quest = cur.Q
		qId = cur.QId
		qn = cur.QI
		if qn > 0 then
			SelectQuestLogEntry(qn)
		end
		
		if cur.Header ~= header then
			header = cur.Header
			local t = {};
			t.title = true;
			t.text = format ("|cff8f8fff---- %s ----", header);
			t.header = header;
			table.insert(wl, t);
		end
		
		if not RDXU.mapSettings.cquests.hide[cur.Header] then
		
			show = true;
			
			title, level, tag, isComplete = cur.Title, cur.Level, cur.Tag, cur.Complete
			
			onQ = 0
			onQStr = ""
			lvlStr = "  "

			if qn > 0 then
				for n = 1, 4 do
					if IsUnitOnQuest (qn, "party"..n) then
						if onQ > 0 then
							onQStr = onQStr .. "," .. UnitName ("party" .. n)
						else
							onQStr = onQStr .. UnitName ("party" .. n)
						end
						onQ = onQ + 1
					end
				end
			end
			
			if qn > 0 then
				SelectQuestLogEntry (qn)
			end
			
			if level > 0 then
				lvlStr = format ("|cffd0d0d0%2d", level)
			end

			color = GetQuestDifficultyColor (level)
			color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

			nameStr = format ("%s %s%s", lvlStr, color, title)

			if quest and quest.CNum then
				nameStr = nameStr .. format (" (Part %d of %d)", quest.CNum, cur.CNumMax)
			end

			if onQ > 0 then
				nameStr = format ("(%d) %s (%s)", onQ, nameStr, onQStr)
			end

			if isComplete then
				nameStr = nameStr .. (isComplete == 1 and "|cff80ff80 - Complete" or "|cfff04040 - "..FAILED)
			end
			
			nameStr = nameStr .. format (" [%s]", qId)

			if tag and cur.GCnt > 0 then
				tag = tag .. " " .. cur.GCnt
			end
			
			if cur.Daily then
				if tag then
					tag = format (DAILY_QUEST_TAG_TEMPLATE, tag)
				else
					tag = DAILY
				end
			end
			
			if not filter or filter ~= "" then
				local str = strlower (format ("%s %s", nameStr, tag or ""))
				local filtStr = strlower (filter)
				show = strfind (str, filtStr, 1, true)
			end
			
			if show then
				local t = {};
				t.quest = true;
				t.text = nameStr;
				t.qn = qn;
				t.tag = tag;
				t.header = header;
				table.insert(wl, t);
				
				-- objectives
				
				local trackMode = RDXMAP.Quest.Tracking[qId] or 0
				
				local num = GetNumQuestLeaderBoards (qn)

				local str = ""
				local desc, typ, done
				local zone, loc

				for ln = 1, 15 do

					zone = nil

					local obj = quest and quest[ln + 3]

					if obj then
						desc, zone, loc = RDXMAP.UnpackObjective (obj)
					end							
					if ln <= num then
						desc, typ, done = GetQuestLogLeaderBoard (ln, qn)
						desc = desc or "?"	--V4

					else
						if not obj then
							break
						end

						done = false
					end

					color = done and "|cff5f5f6f" or "|cff9f9faf"
					str = format ("     %s%s", color, desc)

					--list:ItemAdd (qId * 0x10000 + ln * 0x100 + qn)

					local trkStr = ""

					if zone then
--								trkStr = "|cff505050o"
						--list:ItemSetButton ("QuestWatch", false)
					end
					
					if bit.band (trackMode, bit.lshift (1, ln)) > 0 then
						--list:ItemSetButton (qLocColors[ln][5], true)
					end
				
					local t = {};
					t.obj = true;
					t.text = str;
					table.insert(wl, t);
				end
			end
		end
	end
	SelectQuestLogEntry (oldSel)
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
	
	local ctl = VFLUI.Button:new(self);
	ctl:SetPoint("TOPLEFT", self, "TOPLEFT");
	ctl:SetWidth(10); ctl:SetHeight(10); ctl:Hide();
	ctl:SetText("-");
	--ctl:SetScript("OnClick", function(self)
	--	local p = self:GetParent();
	--	if p and p.ToggleCollapsed then p:ToggleCollapsed(); end
	--end);
	self.ctl = ctl;
	
	local chk = VFLUI.ColoredButton:new(self, _grey, _yellow);
	chk:SetPoint("TOPLEFT", self, "TOPLEFT", 10, 0);
	chk:SetWidth(10); chk:SetHeight(10); chk:Hide();
	self.chk = chk;
	
	local chk2 = VFLUI.ColoredButton:new(self, _grey, _white);
	chk2:SetPoint("TOPLEFT", self, "TOPLEFT", 32, 0);
	chk2:SetWidth(10); chk2:SetHeight(10); chk2:Hide();
	self.chk2 = chk2;
	
	driver:AddRadioButton(chk2);

	-- Create the text
	local text = VFLUI.CreateFontString(self);
	text:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));	text:SetJustifyH("LEFT");
	text:SetTextColor(1,1,1,1);
	text:SetPoint("LEFT", self, "LEFT"); 
	text:SetHeight(10); text:SetWidth(260);
	text:Show();
	self.text = text;
	
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	self.Destroy = VFL.hook(function(self)
		-- Destroy allocated regions
		VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
		VFLUI.ReleaseRegion(self.text); self.text = nil;
		self.ctl:Destroy(); self.ctl = nil;
		self.chk:Destroy(); self.chk = nil;
	end, self.Destroy);

	self.OnDeparent = self.Destroy;

	return self;
end

local function WindowListClick(id)
	--if InCombatLockdown() then return; end	
	--local inst = RDXDB.GetObjectInstance(path, true);
	--if inst then
	--	RDXDB.OpenObject(path, "Close");
	--	return;
	--end
	--RDXDB.OpenObject(path);
	ShowQuest(id);
end

local function WindowListRightClick(self, path)
	local mnu = {};
	table.insert(mnu, {
		text = VFLI.i18n("Edit Window"),
		func = function()
			VFL.poptree:Release();
			RDXDB.OpenObject(path, "Edit", VFLDIALOG);
		end
	});
	
	VFL.poptree:Begin(150, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
	VFL.poptree:Expand(nil, mnu);
end

--
-- TAB
--
local winframeprops = nil;

local framew = VFLUI.AcquireFrame("Frame");
framew:SetHeight(400); framew:SetWidth(600);

local find = VFLUI.Edit:new(framew);
find:SetHeight(25); find:SetWidth(258); find:SetPoint("TOPLEFT", framew, "TOPLEFT", 2 , -2);
find:Show();

local magGlass = VFLUI.CreateTexture(framew);
magGlass:SetTexture("Interface\\Addons\\VFL\\Skin\\mag_glass.tga");
magGlass:SetWidth(22); magGlass:SetHeight(22); magGlass:SetDrawLayer("ARTWORK");
magGlass:SetPoint("LEFT", find, "RIGHT");
magGlass:Show();

local list = VFLUI.List:new(framew, 12, CreateQuestRow);
list:SetPoint("TOPLEFT", find, "BOTTOMLEFT");
list:SetWidth(280); list:SetHeight(470);
list:Rebuild(); list:Show();



----------------- Finder implementation
find:SetScript("OnTextChanged", function()
	local txt = find:GetText();
	if(not txt) or (txt == "") then
		BuildQuestsList("");
	else
		BuildQuestsList(txt);
	end
	list:Update();
end);

list:SetDataSource(function(cell, data, pos)
	cell.text:SetText(data.text);
	if data.title then
		cell.ctl:Show();
		cell.chk:Hide();
		cell.chk2:Hide();
		cell.text:ClearAllPoints();
		cell.text:SetWidth(240);
		cell.text:SetPoint("LEFT", cell, "LEFT", 20, 0);
		
		if RDXU.mapSettings.cquests.hide[data.header] then
			cell.ctl:SetText("+");
		else
			cell.ctl:SetText("-");
		end
		cell.ctl:SetScript("OnClick", function(self)
			if RDXU.mapSettings.cquests.hide[data.header] then
				RDXU.mapSettings.cquests.hide[data.header] = nil;
			else
				RDXU.mapSettings.cquests.hide[data.header] = true;
			end
			BuildQuestsList("");
			list:Update();
		end);
		cell:SetScript("OnClick",nil);
	elseif data.quest then
		cell.ctl:Hide();
		cell.chk:Show();
		cell.chk2:Hide();
		cell.text:ClearAllPoints();
		cell.text:SetWidth(220);
		cell.text:SetPoint("LEFT", cell, "LEFT", 30, 0);
		cell:SetScript("OnClick", function(self, arg1)
			if arg1 == "LeftButton" then
				WindowListClick(data.qn); list:Update();
			elseif arg1 == "RightButton" then
				WindowListRightClick(self, data.qn); 
			end
		end);
	else
		cell.ctl:Hide();
		cell.chk:Hide();
		cell.chk2:Show();
		cell.text:ClearAllPoints();
		cell.text:SetWidth(190);
		cell.text:SetPoint("LEFT", cell, "LEFT", 40, 0);
		cell:SetScript("OnClick",nil);
	end
end, VFL.ArrayLiterator(wl));

local sf = VFLUI.VScrollFrame:new(framew);
sf:SetPoint("TOPLEFT", framew, "TOPLEFT", 300, -5);
sf:SetWidth(280); sf:SetHeight(500);
sf:Show();

local ui = VFLUI.AcquireFrame("Frame");
VFLUI.SetBackdrop(ui, VFLUI.WhiteBackdrop);
VFLUI.SetBackdropColor(ui, 0, 0, 0, 1);
--VFLUI.SetBackdropColor(ui, 1, 1, 0.5, 1);
ui:SetWidth(280); ui:SetHeight(800);
--ui.isLayoutRoot = true;
sf:SetScrollChild(ui);

function ShowQuest(id)
	if id and id > 0 then
		SelectQuestLogEntry (id);
	end
	VFLUI.SetBackdropColor(ui, 1, 1, 0.5, 1);
	VFLT.NextFrame("Rdx", function()
		QuestInfo_Display (QUEST_TEMPLATE_LOG, ui, nil, nil, "Rdx");
	end);
end


local function SetFramew()
	BuildQuestsList("");
	list:Update();
end

local function UnsetFramew()
	--VFLUI.SetBackdropColor(ui, 0, 0, 0, 1);
end

framew:Hide();

RDXMAP.RegisterPanel("Current", 100, framew, SetFramew, UnsetFramew);