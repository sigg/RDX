-- Obj_WindowTab.lua
-- OpenRDX
--

local cur
local qId
local quest
local curq
local id
local qStatus
local qWatched
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
local lbNum

--------------------------------------------------
-- The object.
-- Provides slots for Create, Destroy, Show, and Hide events.
-- Based on the VFL Window object, which allows custom
-- framing.
--------------------------------------------------
RDX.QuestFrame = {};
function RDX.QuestFrame:new(path, desc)
	local obj = VFLUI.AcquireFrame("Frame");
	obj:Show();
	local header = VFLUI.AcquireFrame("Frame");
	header:SetParent(obj);
	header:SetPoint("TOPLEFT", obj, "TOPLEFT");
	header:SetWidth(400); header:SetHeight(20);
	
	header:Show();
	obj.header = header;
		
	local driver = VFLUI.DisjointRadioGroup:new(true);
	obj.driver = driver;
	
	
	local wl = {};
	local w2 = {};
	local function BuildQuestsList(filter)
		VFL.empty(wl);
		
		--if not RDXU.mapSettings then RDXU.mapSettings = {} end;
		--if not RDXU.mapSettings.cquests then RDXU.mapSettings.cquests = {}; end
		--if not RDXU.mapSettings.cquests.hide then RDXU.mapSettings.cquests.hide = {}; end
		if Nx then
			local qopts = Nx:GetQuestOpts()
			local hideUnfinished = qopts["NXWHideUnfinished"]
			local hideGroup = qopts["NXWHideGroup"]
			local hideNotInZone = qopts["NXWHideNotInZone"]
			local hideNotInCont = qopts["NXWHideNotInCont"]
			local hideDist = qopts["NXWHideDist"] >= 19900 and 99999 or qopts["NXWHideDist"]
			local hideDist = hideDist / 4.575		-- Convert to world units
			local priDist = qopts.NXWPriDist
		
		
		--oldSel = GetQuestLogSelection()
		
			curq = Nx.Quest.CurQ
		
		
			for n, cur in ipairs (curq) do
				--cur = Nx.Quest.CurQ[n]
				quest = cur.Q
				qId = cur.QId
				qi = cur.QI
				id = qId > 0 and qId or cur.Title
				qStatus = Nx:GetQuest (id)
				qWatched = qStatus == "W" or cur.PartyDesc
				
				if qWatched and (cur.Distance < hideDist or cur.Distance > 999999) then

					if (not hideUnfinished or cur.CompleteMerge) and
						(not hideGroup or cur.PartySize < 5) and
						(not hideNotInZone or cur.InZone) and
						(not hideNotInCont or cur.InCont) then

						local d = max (cur.Distance * priDist * cur.Priority * 10 + cur.Priority * 100, 0)
						d = cur.HighPri and 0 or d
						
						d = floor (d) * 256 + n
						tinsert (wl, d)
					end
				end
			end
		
			sort (wl) -- sort distance priority
		
			VFL.empty(w2);
			--SelectQuestLogEntry (oldSel)
			for _, distn in ipairs (wl) do
				
				local n = bit.band (distn, 0xff)
				local cur = curq[n]
				local qId = cur.QId
				
				local level, isComplete = cur.Level, cur.CompleteMerge
				local quest = cur.Q
				local qn = cur.QI
				local lbNum = cur.LBCnt
				
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
				
				
				if level > 0 then
					lvlStr = format ("|cffd0d0d0%2d", level)
				end

				color = Nx.Quest:GetDifficultyColor (level)
				--color = format ("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)

				nameStr = format ("%s %s%s", lvlStr, "|cfff4ac00", title)

				--if quest and quest.CNum then
				--	nameStr = nameStr .. format (" (Part %d of %d)", quest.CNum, cur.CNumMax)
				--end

				--if onQ > 0 then
				--	nameStr = format ("(%d) %s (%s)", onQ, nameStr, onQStr)
				--end
				
				--if cur.NewTime and time() < cur.NewTime + 60 then
				--	nameStr = format ("|cff00%2x00New: %s", self.FlashColor * 200 + 55, nameStr)
				--end

				if isComplete then
					nameStr = nameStr .. (isComplete == 1 and "|cff80ff80 - Complete" or "|cfff04040 - "..FAILED)
				end
				
				--nameStr = nameStr .. format (" [%s]", qId)
				
				--if showDist then
					local d = cur.Distance * 4.575

					if d < 1000 then
						nameStr = format ("%s |cff808080%d yds", nameStr, d)
					elseif cur.Distance < 99999 then
						nameStr = format ("%s |cff808080%.1fK yds", nameStr, d / 1000)
					end
				--end

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
				
				
				local t = {};
				t.quest = true;
				t.text = nameStr;
				t.qn = qn;
				t.tag = tag;
				if not isComplete and cur.ItemLink then
					t.ItemImg = cur.ItemImg
					t.ItemCharges = cur.ItemCharges
				end
				table.insert(w2, t);
				
				-- objectives
				
				local trackMode = Nx.Quest.Tracking[qId] or 0
				
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

					--color = done and "|cff5f5f6f" or "|cff9f9faf"
					color = done and "|cffffffff" or "|cff9f9faf"
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
				
					local t2 = {};
					t2.obj = true;
					t2.text = str;
					table.insert(w2, t2);
					t.sub = true;
				end

			end
			
			
		end
	end
	
	obj.wl = wl;
	obj.w2 = w2;
	
	local function CreateWatchQuestRow()
		local self = VFLUI.AcquireFrame("Frame");
		
		-- Create the button highlight texture
		--local hltTexture = VFLUI.CreateTexture(self);
		--hltTexture:SetAllPoints(self);
		--hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		--hltTexture:Show();
		--self:SetHighlightTexture(hltTexture);
		
		-- icon button
		local wfibut = VFLUI.AcquireFrame("WatchFrameItemButton");
		wfibut:SetParent(self);
		wfibut:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -3);
		wfibut:SetWidth(20); wfibut:SetHeight(20); wfibut:Hide();
		self.wfibut = wfibut;
		
		local chk = VFLUI.ColoredButton:new(self, _grey, _yellow);
		chk:SetPoint("TOPLEFT", self, "TOPLEFT", 27, 0);
		chk:SetWidth(10); chk:SetHeight(10); chk:Hide();
		self.chk = chk;
		
		driver:AddRadioButton(chk);

		-- Create the text
		local text = VFLUI.CreateFontString(self);
		--text:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));
		VFLUI.SetFont(text, desc.font);
		text:SetJustifyH("LEFT");
		text:SetTextColor(1,1,1,1);
		text:SetPoint("TOPLEFT", self, "TOPLEFT", 41, 0); 
		text:SetHeight(10); text:SetWidth(360);
		text:Show();
		self.text = text;
		
		--self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

		self.Destroy = VFL.hook(function(self)
			-- Destroy allocated regions
			--VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
			VFLUI.ReleaseRegion(self.text); self.text = nil;
			self.wfibut:Destroy(); self.wfibut = nil;
			self.chk:Destroy(); self.chk = nil;
		end, self.Destroy);

		self.OnDeparent = self.Destroy;

		return self;
	end
	
	
	
	
	--self.msgmax = 100;
	--self.msgs = {};
	
	local list = VFLUI.List:new(obj, 12, CreateWatchQuestRow);
	list:SetPoint("TOPLEFT", obj, "TOPLEFT", 0, -20);
	list:SetWidth(400); list:SetHeight(160);
	list:SetScrollBarEnabled(true);
	list:Rebuild(); list:Show();
	
	obj.list = list
	
	list:SetDataSource(function(cell, data, pos)
	
		cell.text:SetText(data.text);
		if data.quest then
			--cell.ctl:Hide();
			cell.chk:Show();
			cell.chk:ClearAllPoints();
			cell.chk:SetPoint("TOPLEFT", cell, "TOPLEFT", 27, 0);
			--cell.chk:SetWidth(20); cell.chk:SetHeight(20);
			--cell.chk2:Hide();
			--cell.text:ClearAllPoints();
			--cell.text:SetWidth(360);
			--cell.text:SetPoint("TOPLEFT", cell, "TOPLEFT", 41, 0);
			--cell:SetScript("OnClick", function(self, arg1)
			--	if arg1 == "LeftButton" then
			--		WindowListClick(data.qn); list:Update();
			--	elseif arg1 == "RightButton" then
			--		WindowListRightClick(self, data.qn); 
			--	end
			--end);
			
			
		else
			--cell.ctl:Hide();
			cell.chk:Show();
			cell.chk:ClearAllPoints();
			cell.chk:SetPoint("TOPLEFT", cell, "TOPLEFT", 47, 0);
			--cell.chk:SetWidth(20); cell.chk:SetHeight(20);
			--cell.chk2:Show();
			--cell.text:ClearAllPoints();
			--cell.text:SetWidth(360);
			--cell.text:SetPoint("LEFT", cell, "LEFT", 60, 0);
			--cell:SetScript("OnClick",nil);
		end
		
		if data.ItemImg then
			cell.wfibut:SetID (tonumber(data.qn))
			SetItemButtonTexture(cell.wfibut, data.ItemImg);
			local ic = tonumber (data.ItemCharges);
			if ic and ic > 0 then
				SetItemButtonCount (cell.wfibut, ic);
			end
			local _, dur = GetQuestLogSpecialItemCooldown (tonumber (data.qn))
			if dur then
				WatchFrameItem_UpdateCooldown(cell.wfibut)
			end
			cell.wfibut:Show();
			--cell:SetHeight(22);
			if data.sub then
				cell:SetHeight(12);
			else
				cell:SetHeight(22);
			end
		else
			cell.wfibut:Hide();
			cell:SetHeight(12);
		end
		
		
		
		--[[--VFL.print(data);
		local n = bit.band (data, 0xff)
		curq = Nx.Quest.CurQ
		cur = curq[n]
		qId = cur.QId
		
		local level, isComplete = cur.Level, cur.CompleteMerge
		local quest = cur.Q
		local qi = cur.QI
		local lbNum = cur.LBCnt
		
		if not isComplete and cur.ItemLink then --and gopts["QWItemScale"] >= 1 then
			--list:ItemSetFrame ("WatchItem~" .. cur.QI .. "~" .. cur.ItemImg .. "~" .. cur.ItemCharges)
			
			--local typ, v1, v2, v3 = strsplit ("~", "WatchItem~" .. cur.QI .. "~" .. cur.ItemImg .. "~" .. cur.ItemCharges)
			cell.wfibut:SetID (tonumber (cur.QI))
			SetItemButtonTexture(cell.wfibut, cur.ItemImg);
			SetItemButtonCount (cell.wfibut, tonumber (cur.ItemCharges));
			local _, dur = GetQuestLogSpecialItemCooldown (id)
			if dur then
				WatchFrameItem_UpdateCooldown (cell.wfibut)
			end
			cell.wfibut:Show();
			cell:SetHeight(22);
			
		else
			cell.wfibut:Hide();
			cell:SetHeight(12);
		end
		
		--local color = isComplete and Nx.Util_num2colstr(ffd200ff) or Nx.Util_num2colstr(bf9b00ff)
		
		local lvlStr = ""
		if level > 0 then
			local col = Nx.Quest:GetDifficultyColor (level)
			lvlStr = format ("|cff%02x%02x%02x%2d%s ", col.r * 255, col.g * 255, col.b * 255, level, cur.TagShort)
		end
		--local nameStr = format ("%s%s%s", lvlStr, color, cur.Title)
		local nameStr = format ("%s%s%s ", lvlStr, "|cfff4ac00",cur.Title)
		
		--if cur.NewTime and time() < cur.NewTime + 60 then
		--	nameStr = format ("|cff00%2x00New: %s", self.FlashColor * 200 + 55, nameStr)
		--end
		
		if isComplete then

			local obj = quest and (quest[3] or quest[2])

			if lbNum > 0 or not obj then
				nameStr = nameStr .. (isComplete == 1 and "|cff80ff80 (Complete)" or "|cfff04040 - " .. FAILED)

			else
				local desc = Nx.Quest:UnpackSE (obj)
				nameStr = format ("%s |cffffffff(%s)", nameStr, desc)
			end
		end
		
		local showDist = true;
		if showDist then
			local d = cur.Distance * 4.575

			if d < 1000 then
				nameStr = format ("%s |cff808080%d yds", nameStr, d)
			elseif cur.Distance < 99999 then
				nameStr = format ("%s |cff808080%.1fK yds", nameStr, d / 1000)
			end
		end
		
		if cur.PartyCnt then
			nameStr = format ("%s |cffb0b0f0(+%s)", nameStr, cur.PartyCnt)
		end

		if cur.Party then
			nameStr = nameStr .. " |cffb0b0f0" .. cur.Party
		end
		
		cell.text:SetText(nameStr);
		--cell.chk:Show();
		--cell.text:ClearAllPoints();
		--cell.text:SetWidth(220);
		--cell.text:SetPoint("LEFT", cell, "LEFT", 30, 0);
		--cell:SetScript("OnClick", function(self, arg1)
		--	if arg1 == "LeftButton" then
		--		WindowListClick(data.qn); list:Update();
		--	elseif arg1 == "RightButton" then
		--		WindowListRightClick(self, data.qn); 
		--	end
		--end);]]
	end, VFL.ArrayLiterator(w2));
	
	function obj:updatequest()
		BuildQuestsList("");
		list:Update();
		--list:Rebuild();
	end
	
	function self:SetTabOptions(desc)
		if self.tab then
			self.tab.font:SetText(desc.title);
			self.tab:SetWidth(desc.tabwidth);
		end	
	end
	
	--WoWEvents:Bind("QUEST_LOG_UPDATE", nil, obj.updatequest, "qw_" .. path);
	--VFLT.AdaptiveUnschedule2("qw_" .. path)
	--VFLT.AdaptiveSchedule2("qw_" .. path, 1, obj.updatequest)
	
	obj.Destroy = VFL.hook(function(s)
		--WoWEvents:Unbind("qw_" .. path);
		VFLT.AdaptiveUnschedule2("qw_" .. path)
		s.updatequest = nil;
		s.list:Destroy(); s.list = nil;
		s.wl = nil;
		s.SetTabOptions = nil;
		s.driver:Destroy(); s.driver = nil;
		s.header:Destroy(); s.header = nil;
		
	end, obj.Destroy);

	return obj;
end

local function SetupQuestFrame(path, qw, desc)
	if (not qw) or (not desc) then return nil; end
	--cf:RemoveMessages();
	--cf:AddMessages(desc);
	--cf:SetTabOptions(desc);
	--qw:updatequest();
	return true;
end


-- The Window object type.
RDXDB.RegisterObjectType({
	name = "TabQuest";
	isFeatureDriven = true;
	invisible = true;
	New = function(path, md)
		md.version = 1;
	end,
	Edit = function(path, md, parent)
		RDX.EditWindow(parent, path, md);
	end,
	Instantiate = function(path, md, desc)
		
		local qw = RDX.QuestFrame:new(path, desc);
		-- Attempt to setup the window; if it fails, just bail out.
		--if not SetupQuestFrame(path, qw, md.data) then qw:Destroy(); return nil; end
		return qw;
	end,
	Deinstantiate = function(instance, path, md)
		instance:Destroy();
		instance = nil;
	end,
	OpenTab = function(tabbox, path, md, objdesc, desc, tm)
		local tabtitle, tabwidth = "Tab", 80;
		for k, v in pairs(md.data) do
			if v.feature == "taboptions" then
				tabtitle = v.tabtitle;
				tabwidth = v.tabwidth;
			end
		end
		local f = RDXDB.GetObjectInstance(path, nil, desc);
		local tab = tabbox:GetTabBar():AddTab(tabwidth, function(self, arg1)
			tabbox:SetClient(f);
			VFLUI.SetBackdrop(f, desc.bkd);
			--f.font = desc.font;
			f:updatequest();
			f:Show();
			VFLT.AdaptiveUnschedule2("qw_" .. path)
			VFLT.AdaptiveSchedule2("qw_" .. path, 1, f.updatequest)
		end,
		function() 
			f:Hide();
			VFLT.AdaptiveUnschedule2("qw_" .. path)
		end, 
		function(mnu, dlg) 
			return objdesc.GenerateBrowserMenu(mnu, path, nil, dlg, tm)
		end);
		tab.font:SetText(tabtitle);
		tab.f = f;
		return tab;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg, tm)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
		local feat = RDXDB.GetFeatureData(path, "Design");
		if not feat then feat = RDXDB.GetFeatureData(path, "Assist Frames"); end
		if feat then
			local upath = feat["design"];
			table.insert(mnu, {
				text = VFLI.i18n("Edit Design"),
				func = function() 
					VFL.poptree:Release();
					if IsShiftKeyDown() then
						RDXDB.OpenObject(upath, "Edit", VFLDIALOG, true);
					else
						RDXDB.OpenObject(upath, "Edit", VFLDIALOG);
					end
				end
			});
		end
		if tm then 
			table.insert(mnu, {
				text = VFLI.i18n("Close Tab");
				func = function()
					VFL.poptree:Release();
					tm:RemoveTab(path, true);
				end;
			});
		end
	end,
});


--------------- Tab Manager
--[[
RDXPM.RegisterTabCategory(VFLI.i18n("Maps"));

------------------------------------------
-- Update hooks
------------------------------------------
RDXDBEvents:Bind("OBJECT_DELETED", nil, function(dk, pkg, file, md)
	if md and md.ty == "TabMap" then
		local path = RDXDB.MakePath(dk,pkg,file);
		RDXPM.UnregisterTab(path, "Maps")
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(dk, pkg, file, newdk, newpkg, newfile, md)
	if md and md.ty == "TabMap" then
		local path = RDXDB.MakePath(dk,pkg,file);
		RDXPM.UnregisterTab(path, "Maps")
	end
end);
RDXDBEvents:Bind("OBJECT_CREATED", nil, function(dk,pkg, file) 
	local path = RDXDB.MakePath(dk,pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabMap" then
		local data = obj.data;
		local tit = "";
		--if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("Maps");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);
RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(dk,pkg, file) 
	local path = RDXDB.MakePath(dk,pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabMap" then
		RDXPM.UnregisterTab(path, "Maps");
		local data = obj.data;
		local tit = "";
		--if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("Maps");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);

-- run on UI load 
local function RegisterTabMap()
	for pkgName,pkg in pairs(RDXDB.GetDisk("RDXData")) do
		for objName,obj in pairs(pkg) do
			if type(obj) == "table" and obj.ty == "TabMap" then 
				local path = RDXDB.MakePath("RDXData", pkgName, objName);
				local data = obj.data;
				local tit = "";
				--if data then tit = obj.data.title; end
				RDXPM.RegisterTab({
					name = path;
					title = path .. " " .. tit;
					category = VFLI.i18n("Maps");
					GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
					GetBlankDescriptor = function() return {op = path}; end;
				});
			end
		end
	end
end

RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RegisterTabMap();
end);]]
