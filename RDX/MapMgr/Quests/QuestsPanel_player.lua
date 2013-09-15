-- OpenRDX
--
-------------------
-- helper
-------------------

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
	if Nx then 
		list:SetDataSource(function(cell, data, pos)

			local quest = data.Q
			local qId = data.QId
			local title, level, tag, isComplete = data.Title, data.Level, data.Tag, data.Complete
			local qn = data.QI
			
			local onQ = 0
			local onQStr = ""

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
			
			local lvlStr = "  "
			if level > 0 then
				lvlStr = format ("|cffd0d0d0%2d", level)
			end

			local color = Nx.Quest:GetDifficultyColor (level)
			color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

			local nameStr = format ("%s %s%s", lvlStr, color, title)

			if quest and quest.CNum then
				nameStr = nameStr .. format (" (Part %d of %d)", quest.CNum, data.CNumMax)
			end

			if onQ > 0 then
				nameStr = format ("(%d) %s (%s)", onQ, nameStr, onQStr)
			end

			if isComplete then
				nameStr = nameStr .. (isComplete == 1 and "|cff80ff80 - Complete" or "|cfff04040 - "..FAILED)
			end

			if tag and data.GCnt > 0 then
				tag = tag .. " " .. data.GCnt
			end

			cell.text:SetText(nameStr);
			cell:SetScript("OnClick", function(self, arg1)
				if arg1 == "LeftButton" then
					WindowListClick(data); list:Update();
				elseif arg1 == "RightButton" then
					WindowListRightClick(self, data); 
				end
			end);
		end, VFL.ArrayLiterator(Nx.Quest.CurQ));
	end
end);


--function RDXDK.ToolsWindowUpdate()
--	local _, auiname = RDXDB.ParsePath(RDXU.AUI);
--	BuildWindowList(auiname);
--	list:Update();
--end;



local function SetFramew()
	
	
	
	--BuildWindowList(auiname);
	list:Update();
end

local function UnsetFramew()
	
end

framew:Hide();

--RDXMAP.RegisterPanel("Current", 100, framew, SetFramew, UnsetFramew);