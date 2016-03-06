-- ChatFrame.lua
-- OpenRDX 
--

-- Create a cell in the data table
local function CreateCell(parent)
	local self = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(self, parent); self:SetHeight(15);
	-- Create the columns.
	self.col = {};
	
	local enablecheck = VFLUI.AcquireFrame("CheckButton");
	enablecheck:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
	enablecheck:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
	enablecheck:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
	enablecheck:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
	enablecheck:SetParent(self);
	enablecheck:SetFrameStrata(self:GetFrameStrata());
	enablecheck:SetFrameLevel(self:GetFrameLevel() + 1);
	enablecheck:SetPoint("TOPLEFT", self, "TOPLEFT", 2, 0);
	enablecheck:SetHeight(19); enablecheck:SetWidth(19); enablecheck:Show();
	self.col[1] = enablecheck;
	
	local nameText = VFLUI.CreateFontString(self);
	nameText:SetDrawLayer("OVERLAY");
	VFLUI.SetFont(nameText, Fonts.Default, 12);
	nameText:SetShadowOffset(1,-1);
	nameText:SetShadowColor(0,0,0,.6);
	nameText:SetTextColor(1,1,1,1); nameText:SetJustifyH("LEFT");
	nameText:SetPoint("TOPLEFT", enablecheck, "TOPRIGHT"); 
	nameText:SetHeight(19); nameText:SetWidth(200);
	nameText:Show();
	self.col[2] = nameText;

	-- Update the Destroy function
	self.Destroy = VFL.hook(function(s)
		-- Destroy columns
		for _,column in pairs(s.col) do column:Destroy(); column = nil; end
		s.col = nil;
	end, self.Destroy);
	self.OnDeparent = self.Destroy;

	return self;
end

----------- local variables
local cti, col;

----------- CHAT_CONFIG_CHAT_LEFT
local adecor = VFLUI.AcquireFrame("Frame");
adecor:SetWidth(470); adecor:SetHeight(273);
adecor:SetBackdrop(VFLUI.DefaultDialogBorder); 
adecor:Hide();

local adata = VFLUI.List:new(adecor, 15, CreateCell);
adata:SetPoint("TOPLEFT", adecor, "TOPLEFT", 5, -5);
adata:SetWidth(465); adata:SetHeight(273); 
adata:Show(); 

adata:SetDataSource(function(cell, data, pos, absPos)
	col = cell.col;
	if data.enabled then
		col[1]:SetChecked(true);
	else
		col[1]:SetChecked(nil);
	end
	col[1]:SetScript("OnClick", function(self) data.enabled = self:GetChecked(); end);
	cti = ChatTypeInfo[data.type];
	col[2]:SetTextColor(cti.r, cti.g, cti.b);
	if data.text then
		col[2]:SetText(data.text);
	else
		col[2]:SetText(_G[data.type]);
	end
end, function()
	return #CHAT_CONFIG_CHAT_LEFT;
end, function(n) 
	return CHAT_CONFIG_CHAT_LEFT[n];
end);

adata:Rebuild();
adata:Update();

---------------- CHAT_CONFIG_CHAT_CREATURE_LEFT
local bdecor = VFLUI.AcquireFrame("Frame");
bdecor:SetWidth(470); bdecor:SetHeight(273);
bdecor:SetBackdrop(VFLUI.DefaultDialogBorder); 
bdecor:Hide();

local bdata = VFLUI.List:new(bdecor, 15, CreateCell);
bdata:SetPoint("TOPLEFT", bdecor, "TOPLEFT", 5, -5);
bdata:SetWidth(465); bdata:SetHeight(273); 
bdata:Show(); 

bdata:SetDataSource(function(cell, data, pos, absPos)
	col = cell.col;
	if data.enabled then
		col[1]:SetChecked(true);
	else
		col[1]:SetChecked(nil);
	end
	col[1]:SetScript("OnClick", function(self) data.enabled = self:GetChecked(); end);
	cti = ChatTypeInfo[data.type];
	if cti then
		col[2]:SetTextColor(cti.r, cti.g, cti.b);
	end
	if data.text then
		col[2]:SetText(data.text);
	else
		col[2]:SetText(_G[data.type]);
	end
end, function()
	return #CHAT_CONFIG_CHAT_CREATURE_LEFT;
end, function(n) 
	return CHAT_CONFIG_CHAT_CREATURE_LEFT[n];
end);

bdata:Rebuild();
bdata:Update();

---------------- CHAT_CONFIG_OTHER_COMBAT
local cdecor = VFLUI.AcquireFrame("Frame");
cdecor:SetWidth(470); cdecor:SetHeight(273);
cdecor:SetBackdrop(VFLUI.DefaultDialogBorder); 
cdecor:Hide();

local cdata = VFLUI.List:new(cdecor, 15, CreateCell);
cdata:SetPoint("TOPLEFT", cdecor, "TOPLEFT", 5, -5);
cdata:SetWidth(465); cdata:SetHeight(273); 
cdata:Show(); 

cdata:SetDataSource(function(cell, data, pos, absPos)
	col = cell.col;
	if data.enabled then
		col[1]:SetChecked(true);
	else
		col[1]:SetChecked(nil);
	end
	col[1]:SetScript("OnClick", function(self) data.enabled = self:GetChecked(); end);
	cti = ChatTypeInfo[data.type];
	if cti then
		col[2]:SetTextColor(cti.r, cti.g, cti.b);
	end
	if data.text then
		col[2]:SetText(data.text);
	else
		col[2]:SetText(_G[data.type]);
	end
end, function()
	return #CHAT_CONFIG_OTHER_COMBAT;
end, function(n) 
	return CHAT_CONFIG_OTHER_COMBAT[n];
end);

cdata:Rebuild();
cdata:Update();

---------------- CHAT_CONFIG_OTHER_PVP
local ddecor = VFLUI.AcquireFrame("Frame");
ddecor:SetWidth(470); ddecor:SetHeight(273);
ddecor:SetBackdrop(VFLUI.DefaultDialogBorder); 
ddecor:Hide();

local ddata = VFLUI.List:new(ddecor, 15, CreateCell);
ddata:SetPoint("TOPLEFT", ddecor, "TOPLEFT", 5, -5);
ddata:SetWidth(465); ddata:SetHeight(273); 
ddata:Show(); 

ddata:SetDataSource(function(cell, data, pos, absPos)
	col = cell.col;
	if data.enabled then
		col[1]:SetChecked(true);
	else
		col[1]:SetChecked(nil);
	end
	col[1]:SetScript("OnClick", function(self) data.enabled = self:GetChecked(); end);
	cti = ChatTypeInfo[data.type];
	if cti then
		col[2]:SetTextColor(cti.r, cti.g, cti.b);
	end
	if data.text then
		col[2]:SetText(data.text);
	else
		col[2]:SetText(_G[data.type]);
	end
end, function()
	return #CHAT_CONFIG_OTHER_PVP;
end, function(n) 
	return CHAT_CONFIG_OTHER_PVP[n];
end);

ddata:Rebuild();
ddata:Update();

---------------- CHAT_CONFIG_OTHER_SYSTEM
local edecor = VFLUI.AcquireFrame("Frame");
edecor:SetWidth(470); edecor:SetHeight(273);
edecor:SetBackdrop(VFLUI.DefaultDialogBorder); 
edecor:Hide();

local edata = VFLUI.List:new(edecor, 15, CreateCell);
edata:SetPoint("TOPLEFT", edecor, "TOPLEFT", 5, -5);
edata:SetWidth(465); edata:SetHeight(273); 
edata:Show(); 

edata:SetDataSource(function(cell, data, pos, absPos)
	col = cell.col;
	if data.enabled then
		col[1]:SetChecked(true);
	else
		col[1]:SetChecked(nil);
	end
	col[1]:SetScript("OnClick", function(self) data.enabled = self:GetChecked(); end);
	cti = ChatTypeInfo[data.type];
	if cti then
		col[2]:SetTextColor(cti.r, cti.g, cti.b);
	end
	if data.text then
		col[2]:SetText(data.text);
	else
		col[2]:SetText(_G[data.type]);
	end
end, function()
	return #CHAT_CONFIG_OTHER_SYSTEM;
end, function(n) 
	return CHAT_CONFIG_OTHER_SYSTEM[n];
end);

edata:Rebuild();
edata:Update();

---------------- CHAT_CONFIG_CHANNEL_LIST
local fdecor = VFLUI.AcquireFrame("Frame");
fdecor:SetWidth(470); fdecor:SetHeight(273);
fdecor:SetBackdrop(VFLUI.DefaultDialogBorder); 
fdecor:Hide();

local fdata = VFLUI.List:new(fdecor, 15, CreateCell);
fdata:SetPoint("TOPLEFT", fdecor, "TOPLEFT", 5, -5);
fdata:SetWidth(465); fdata:SetHeight(273); 
fdata:Show();

function RDX.CreateChatChannelList(...)
	local channel, channelID, tag;
	local count = 1;
	local titi = {};
	for i=1, select("#", ...), 2 do
		channelID = select(i, ...);
		tag = "CHANNEL"..channelID;
		channel = select(i+1, ...);
		titi[count] = {};
		titi[count].text = channelID.."."..channel;
		titi[count].channelName = channel;
		titi[count].type = tag;
		titi[count].maxWidth = CHATCONFIG_CHANNELS_MAXWIDTH;
		count = count+1;
	end
	return titi;
end

-- Edit dialog
local dlg = nil;
local function EditChatFrameDialog(parent, path, md)
	if dlg then
		RDX.printI(VFLI.i18n("A ChatFrame editor is already open. Please close it first."));
		return;
	end

	-- Sanity checks
	if (not path) or (not md) or (not md.data) then return nil; end

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(490); dlg:SetHeight(383);
	dlg:SetText(VFLI.i18n("Edit ChatFrame: ") .. path);
	dlg:SetClampedToScreen(true);
	if RDXPM.Ismanaged("ChatFrame") then RDXPM.RestoreLayout(dlg, "ChatFrame"); end
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	dlg:Show();
	local ca = dlg:GetClientArea();
	
	local ed_tabtitle = VFLUI.LabeledEdit:new(ca, 150);
	ed_tabtitle:SetText(VFLI.i18n("Tab Title"));
	ed_tabtitle.editBox:SetText(md.data.tabtitle);
	ed_tabtitle:SetHeight(25); ed_tabtitle:SetWidth(250);
	ed_tabtitle:SetPoint("TOPLEFT", ca, "TOPLEFT");
	ed_tabtitle:Show();
	dlg.ed_tabtitle = ed_tabtitle;
	
	local ed_title = VFLUI.LabeledEdit:new(ca, 100);
	ed_title:SetText(VFLI.i18n("Title"));
	ed_title.editBox:SetText(md.data.title);
	ed_title:SetHeight(25); ed_title:SetWidth(150);
	ed_title:SetPoint("TOPLEFT", ed_tabtitle, "TOPRIGHT");
	ed_title:Show();
	dlg.ed_title = ed_title;
	
	local ed_tabwidth = VFLUI.LabeledEdit:new(ca, 150);
	ed_tabwidth:SetText(VFLI.i18n("Tab Width"));
	ed_tabwidth.editBox:SetText(md.data.tabwidth);
	ed_tabwidth:SetHeight(25); ed_tabwidth:SetWidth(250);
	ed_tabwidth:SetPoint("TOPLEFT", ed_tabtitle, "BOTTOMLEFT");
	ed_tabwidth:Show();
	dlg.ed_tabwidth = ed_tabwidth;
	
	local cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("Change chat color"), 150);
	cbtn:SetPoint("TOPLEFT", ed_tabwidth, "TOPRIGHT", 50, 0);
	
	local tabbox = VFLUI.TabBox:new(dlg, 22, "TOP");
	tabbox:SetWidth(480); tabbox:SetHeight(300);
	tabbox:SetPoint("TOPLEFT", ed_tabwidth, "BOTTOMLEFT", 0, 0);
	tabbox:SetBackdrop(nil);
	
	local tab = nil;
	tab = tabbox:GetTabBar():AddTab("80", function() 
		tabbox:SetClient(adecor);   
		for k,v in ipairs(CHAT_CONFIG_CHAT_LEFT) do
			v.enabled = md.data.discussion[v.type];
		end
		adata:Update();
	end, function()
		for k,v in ipairs(CHAT_CONFIG_CHAT_LEFT) do
			md.data.discussion[v.type] = v.enabled;
			v.enabled = nil;
		end
	end);
	tab.font:SetText("Player");
	
	tab = tabbox:GetTabBar():AddTab("80", function() 
		tabbox:SetClient(bdecor);   
		for k,v in ipairs(CHAT_CONFIG_CHAT_CREATURE_LEFT) do
			v.enabled = md.data.creature[v.type];
		end
		bdata:Update();
	end, function()
		for k,v in ipairs(CHAT_CONFIG_CHAT_CREATURE_LEFT) do
			md.data.creature[v.type] = v.enabled;
			v.enabled = nil;
		end
	end);
	tab.font:SetText("Creature");
	
	tab = tabbox:GetTabBar():AddTab("80", function() 
		tabbox:SetClient(cdecor);   
		for k,v in ipairs(CHAT_CONFIG_OTHER_COMBAT) do
			v.enabled = md.data.combat[v.type];
		end
		cdata:Update();
	end, function()
		for k,v in ipairs(CHAT_CONFIG_OTHER_COMBAT) do
			md.data.combat[v.type] = v.enabled;
			v.enabled = nil;
		end
	end);
	tab.font:SetText(COMBAT);
	
	tab = tabbox:GetTabBar():AddTab("80", function() 
		tabbox:SetClient(ddecor);   
		for k,v in ipairs(CHAT_CONFIG_OTHER_PVP) do
			v.enabled = md.data.pvp[v.type];
		end
		ddata:Update();
	end, function()
		for k,v in ipairs(CHAT_CONFIG_OTHER_PVP) do
			md.data.pvp[v.type] = v.enabled;
			v.enabled = nil;
		end
	end);
	tab.font:SetText(PVP);
	
	tab = tabbox:GetTabBar():AddTab("80", function() 
		tabbox:SetClient(edecor);   
		for k,v in ipairs(CHAT_CONFIG_OTHER_SYSTEM) do
			v.enabled = md.data.system[v.type];
		end
		edata:Update();
	end, function()
		for k,v in ipairs(CHAT_CONFIG_OTHER_SYSTEM) do
			md.data.system[v.type] = v.enabled;
			v.enabled = nil;
		end
	end);
	tab.font:SetText(OTHER);
	
	local channelList;
	
	tab = tabbox:GetTabBar():AddTab("80", function() 
		tabbox:SetClient(fdecor);
		
		channelList = RDX.CreateChatChannelList(GetChannelList());
		fdata:SetDataSource(function(cell, data, pos, absPos)
			col = cell.col;
			if data.enabled then
				col[1]:SetChecked(true);
			else
				col[1]:SetChecked(nil);
			end
			col[1]:SetScript("OnClick", function(self) data.enabled = self:GetChecked(); end);
			cti = ChatTypeInfo[data.type];
			if cti then
				col[2]:SetTextColor(cti.r, cti.g, cti.b);
			end
			if data.text then
				col[2]:SetText(data.text);
			else
				col[2]:SetText(_G[data.type]);
			end
		end, function()
			return #channelList;
		end, function(n) 
			return channelList[n];
		end);
		--if not RDXU.channels then RDXU.channels = {}; end
		for k,v in ipairs(channelList) do
			v.enabled = md.data.channels[v.type];
			--v.enabled = RDXU.channels[v.type];
		end
		fdata:Rebuild();
		fdata:Update();
	end, function()
		--if not RDXU.channels then RDXU.channels = {}; end
		for k,v in ipairs(channelList) do
			md.data.channels[v.type] = v.enabled;
			--RDXU.channels[v.type] = v.enabled;
			v.enabled = nil;
		end
	end);
	tab.font:SetText("Channels");
	
	tabbox:Show();
	tabbox:GetTabBar():SelectTabName("Player");
	
	dlg.tabbox = tabbox;
	
	local esch = function()
		RDXPM.StoreLayout(dlg, "ChatFrame");
		dlg:Destroy(); dlg = nil;
	end
	VFL.AddEscapeHandler(esch);

	local function Save()
		md.data.tabtitle = ed_tabtitle.editBox:GetText();
		md.data.title = ed_title.editBox:GetText();
		md.data.tabwidth = ed_tabwidth.editBox:GetText();
		dlg.tabbox:GetTabBar():UnSelectTab();
		--RDXDB.NotifyUpdate(path);
		-- See if this chatframe was already instantiated...
		local inst = RDXDB.GetObjectInstance(path, true);
		if inst then 
			inst.mtab:RemoveMessages();
			inst.mtab:AddMessages(md.data);
			inst.mtab:SetTabOptions(md.data);
		end
		VFL.EscapeTo(esch);
	end
	
	cbtn:SetScript("OnClick", function()
		CURRENT_CHAT_FRAME_ID = 1;
		ShowUIPanel(ChatConfigFrame);
		VFL.EscapeTo(esch);
	end);
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	dlg.Destroy = VFL.hook(function(s)
		s.tabbox:Destroy(); s.tabbox = nil;
		s.ed_tabwidth:Destroy(); s.ed_tabwidth = nil;
		s.ed_title:Destroy(); s.ed_title = nil;
		s.ed_tabtitle:Destroy(); s.ed_tabtitle = nil;
	end, dlg.Destroy);
end

-- Copy Paste dialog
local dlg2 = nil;
local function EditScriptDialog(parent, data)
	if dlg then
		RDX.printI(VFLI.i18n("A copy paste editor is already open. Please close it first."));
		return;
	end
	-- Sanity checks
	local ctype, font = nil, nil;

	dlg2 = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg2, 22);
	dlg2:SetTitleColor(0,0,.6);
	dlg2:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg2:SetPoint("CENTER", RDXParent, "CENTER");
	dlg2:SetWidth(500); dlg2:SetHeight(500);
	dlg2:SetText(VFLI.i18n("Text Editor"));
	dlg2:Show();
	VFLUI.Window.StdMove(dlg2, dlg2:GetTitleBar());

	local editor = VFLUI.TextEditor:new(dlg2, ctype, font);
	editor:SetPoint("TOPLEFT", dlg2:GetClientArea(), "TOPLEFT");
	editor:SetWidth(490); editor:SetHeight(430); editor:Show();
	msglink = "";
	for _,v in ipairs(data) do
		msglink = msglink .. v .. "\n";
	end
	editor:SetText(msglink or "");
	editor:GetEditWidget():SetFocus();

	local esch = function() dlg2:Destroy(); end
	VFL.AddEscapeHandler(esch);

	local btnClose = VFLUI.CloseButton:new(dlg2);
	dlg2:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	dlg2.Destroy = VFL.hook(function(s)
		editor:Destroy(); editor = nil;
	end, dlg2.Destroy);
end

--------------------------------------------------
-- The object.
-- Provides slots for Create, Destroy, Show, and Hide events.
-- Based on the VFL Window object, which allows custom
-- framing.
--------------------------------------------------
RDX.ChatFrame = {};
function RDX.ChatFrame:new(path, parent)
	local self = VFLUI.AcquireFrame("ChatFrame2");
	
	self.msgmax = 1000;
	self.msgs = {};
	
	-- hack
	self.cf._AddMessage = self.cf.AddMessage;
	
	self.cf.AddMessage = function(frame, msg, ...)
		if(#self.msgs >= self.msgmax) then table.remove(self.msgs, 1); end
		table.insert(self.msgs, msg);
		frame:_AddMessage(msg, ...)
	end
	
	function self:RemoveMessages()
		ChatFrame_RemoveAllMessageGroups(self.cf);
		ChatFrame_RemoveAllChannels(self.cf);
	end
	
	local function Flash()
		if self.tab and not self.tab.selected then
			self.tab:StartFlash(); 
		end
	end

	function self:AddMessages(desc)
		if not desc.logs then desc.logs = {}; end
		self.msgs = desc.logs;
		
		for k,v in pairs(desc.discussion) do
			ChatFrame_AddMessageGroup(self.cf, k);
			if k == "WHISPER" then
				WoWEvents:Bind("CHAT_MSG_WHISPER", nil, Flash, "whisp_" .. path);
				WoWEvents:Bind("CHAT_MSG_WHISPER_INFORM", nil, Flash, "whisp_" .. path);
				WoWEvents:Bind("CHAT_MSG_AFK", nil, Flash, "whisp_" .. path);
				WoWEvents:Bind("CHAT_MSG_DND", nil, Flash, "whisp_" .. path);
			end
		end
		for k,v in pairs(desc.creature) do
			ChatFrame_AddMessageGroup(self.cf, k);
		end
		for k,v in pairs(desc.combat) do
			ChatFrame_AddMessageGroup(self.cf, k);
		end
		for k,v in pairs(desc.pvp) do
			ChatFrame_AddMessageGroup(self.cf, k);
		end
		for k,v in pairs(desc.system) do
			ChatFrame_AddMessageGroup(self.cf, k);
		end
		if not RDX.deferreddone then
			RDXEvents:Bind("INIT_DEFERRED", nil, function()
				local cn = RDX.CreateChatChannelList(GetChannelList());
				--if not RDXU.channels then RDXU.channels = {}; end
				--for k,v in pairs(RDXU.channels) do
				for k,v in pairs(desc.channels) do
					for k2,v2 in ipairs(cn) do
						if v2.type == k then
							ChatFrame_AddChannel(self.cf, v2.channelName);
						end
					end
				end
			end);
		else
			local cn = RDX.CreateChatChannelList(GetChannelList());
			for k,v in pairs(desc.channels) do
				for k2,v2 in ipairs(cn) do
					if v2.type == k then
						ChatFrame_AddChannel(self.cf, v2.channelName);
					end
				end
			end
		end
	end
	
	function self:SetTabOptions(desc)
		if self.tab then
			self.tab.font:SetText(desc.title);
			self.tab:SetWidth(desc.tabwidth);
		end	
	end
	
	

	self.Destroy = VFL.hook(function(s)
		WoWEvents:Unbind("whisp_" .. path);
		s.cf.AddMessage = s.cf._AddMessage;
		s.SetTabOptions = nil;
		s.AddMessages = nil; s.RemoveMessages = nil;
		s.tab = nil;
	end, self.Destroy);

	return self;
end

-----------------------------------------------------------
-- Window meta-control
-----------------------------------------------------------
-- Master priming function for compiling windows.
local function SetupChatFrame(path, cf, desc)
	if (not cf) or (not desc) then return nil; end
	cf:RemoveMessages();
	cf:AddMessages(desc);
	cf:SetTabOptions(desc);
	return true;
end

-- Chatframe RDX object registration
RDXDB.RegisterObjectType({
	name = "TabChatFrame";
	invisible = true;
	New = function(path, md)
		md.version = 1;
		md.data = {};
		md.data.title = "Chat";
		md.data.tabtitle = "C";
		md.data.tabwidth = 80;
		md.data.discussion = {};
		md.data.discussion["SAY"] = true;
		md.data.discussion["EMOTE"] = true;
		md.data.discussion["YELL"] = true;
		md.data.discussion["GUILD"] = true;
		md.data.discussion["OFFICER"] = true;
		md.data.discussion["GUILD_ACHIEVEMENT"] = true;
		md.data.discussion["ACHIEVEMENT"] = true;
		md.data.discussion["WHISPER"] = true;
		md.data.discussion["BN_WHISPER"] = true;
		md.data.discussion["PARTY"] = true;
		md.data.discussion["PARTY_LEADER"] = true;
		md.data.discussion["RAID"] = true;
		md.data.discussion["RAID_LEADER"] = true;
		md.data.discussion["INSTANCE_CHAT"] = true;
		md.data.discussion["INSTANCE_CHAT_LEADER"] = true;
		md.data.discussion["RAID_WARNING"] = true;
		md.data.discussion["BATTLEGROUND"] = true;
		md.data.discussion["BATTLEGROUND_LEADER"] = true;
		md.data.discussion["BN_CONVERSATION"] = true;
		md.data.creature = {};
		md.data.creature["MONSTER_SAY"] = true; 
		md.data.creature["MONSTER_EMOTE"] = true;
		md.data.creature["MONSTER_YELL"] = true;
		md.data.creature["MONSTER_WHISPER"] = true;
		md.data.creature["MONSTER_BOSS_EMOTE"] = true;
		md.data.creature["MONSTER_BOSS_WHISPER"] = true;
		md.data.combat = {};
		md.data.combat["COMBAT_FACTION_CHANGE"] = true;
		md.data.combat["SKILL"] = true;
		md.data.combat["LOOT"] = true;
		md.data.combat["CURRENCY"] = true;
		md.data.combat["MONEY"] = true;
		md.data.pvp = {};
		md.data.pvp["BG_SYSTEM_HORDE"] = true;
		md.data.pvp["BG_SYSTEM_ALLIANCE"] = true;
		md.data.pvp["BG_SYSTEM_NEUTRAL"] = true;
		md.data.system = {};
		md.data.system["SYSTEM"] = true;
		md.data.system["ERRORS"] = true;
		md.data.system["IGNORED"] = true;
		md.data.system["CHANNEL"] = true;
		md.data.system["BN_INLINE_TOAST_ALERT"] = true;
		md.data.channels = {};
	end;
	Edit = function(path, md, parent)
		EditChatFrameDialog(parent or VFLDIALOG, path, md);
	end;
	CopyPaste = function(path, md, parent)
		local inst = RDXDB.GetObjectInstance(path, true);
		if inst then 
			EditScriptDialog(parent or VFLDIALOG, inst.mtab.msgs);
		end
	end;
	Clear = function(path, md, parent)
		local inst = RDXDB.GetObjectInstance(path, true);
		if inst then 
			inst.mtab.cf:Clear();
		end
	end;
	Instantiate = function(path, md)
		local dlgtab = VFLUI.Window:new();
		dlgtab:SetFraming(VFLUI.Framing.Sleek, 25, VFLUI.BorderlessDialogBackdrop2);
		dlgtab:SetTitleColor(0,.5,0);
		if not md.data.title then
			dlgtab:SetText(VFLI.i18n("Chat"));
		else
			dlgtab:SetText(VFLI.i18n("Chat") .. " : " .. md.data.title);
		end
		
		local ca = dlgtab:GetClientArea();
		
		local mtab = RDX.ChatFrame:new(path);
		-- Attempt to setup the window; if it fails, just bail out.
		if not SetupChatFrame(path, mtab, md.data) then mtab:Destroy(); return nil; end
		
		mtab:SetParent(ca);
		mtab:SetAllPoints(ca);
		dlgtab.mtab = mtab;
		
		local function layout()
			local w = ca:GetWidth();
			local h = ca:GetHeight();
			mtab:ClearAllPoints();
			mtab:SetPoint("CENTER", ca, "CENTER");
			mtab:SetWidth(w);
			mtab:SetHeight(h);
		end
		ca:SetScript("OnShow", layout);
		ca:SetScript("OnSizeChanged", layout);
		
		local syncbtn = VFLUI.SyncButton:new()
		syncbtn:SetScript("OnClick", function()
			RDXDB.OpenObject(path, "Clear", dlgtab);
		end);
		dlgtab:AddButton(syncbtn);
		
		local mgbtn = VFLUI.MagGlassButton:new()
		mgbtn:SetScript("OnClick", function()
			RDXDB.OpenObject(path, "CopyPaste", dlgtab);
		end);
		dlgtab:AddButton(mgbtn);
		
		local markbtn = VFLUI.MarkButton:new()
		markbtn:SetScript("OnClick", function()
			RDXDB.OpenObject(path, "Edit", dlgtab);
		end);
		dlgtab:AddButton(markbtn);
		
		return dlgtab;
	end,
	Deinstantiate = function(instance, path, md)
		if instance.mtab then
			instance.mtab:Destroy();
			instance.mtab = nil;
		end
		instance:Destroy();
		instance = nil;
	end,
	OpenTab = function(tabbox, path, md, objdesc, desc, tm)
		local f = RDXDB.GetObjectInstance(path);
		local tab = tabbox:GetTabBar():AddTab(md.data.tabwidth, function(self, arg1)
			tabbox:SetClient(f);
			VFLUI.SetBackdrop(f, desc.bkd);
			ChatEdit_SetLastActiveWindow(f.mtab.cf.editBox);
			--VFLUI.SetBackdrop(f.mtab.cfbg, desc.bkd);
			--VFLUI.SetBackdrop(f.mtab.ebbg, desc.bkd);
			VFLUI.SetFont(f.mtab.cf, desc.font);
			f:SetTitleColor(VFL.explodeRGBA(desc.titleColor));
		end,
		function() end, 
		function(mnu, dlg) 
			return objdesc.GenerateBrowserMenu(mnu, path, nil, dlg, tm)
		end);
		if md.data.tabtitle then
			tab.font:SetText(md.data.tabtitle);
		else
			tab.font:SetText(md.data.title);
		end
		tab.f = f;
		f.tab = tab;
		return tab;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg, tm)
		--table.insert(mnu, {
			--text = VFLI.i18n("Edit"),
			--func = function() 
			--	VFL.poptree:Release(); 
			--	RDXDB.OpenObject(path, "Edit", dlg);
			--end
		--});
		if tm then 
			--table.insert(mnu, {
			--	text = VFLI.i18n("Open copy paste");
			--	func = function()
			--		VFL.poptree:Release();
			--		RDXDB.OpenObject(path, "CopyPaste", dlg);
			--	end;
			--});
			--table.insert(mnu, {
			--	text = VFLI.i18n("Clear Messages");
			--	func = function()
			--		VFL.poptree:Release();
			--		RDXDB.OpenObject(path, "Clear", dlg);
			--	end;
			--});
			table.insert(mnu, {
				text = VFLI.i18n("Close Tab");
				func = function()
					VFL.poptree:Release();
					tm:RemoveTab(path, true);
				end;
			});
		end
	end;
});

--------------- Tab Manager

--[[

RDXPM.RegisterTabCategory(VFLI.i18n("ChatFrames"));

------------------------------------------
-- Update hooks
------------------------------------------
RDXDBEvents:Bind("OBJECT_DELETED", nil, function(dk, pkg, file, md)
	if md and md.ty == "TabChatFrame" then
		local path = RDXDB.MakePath(dk, pkg,file);
		RDXPM.UnregisterTab(path, "ChatFrames")
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(dk, pkg, file, newdk, newpkg, newfile, md)
	if md and md.ty == "TabChatFrame" then
		local path = RDXDB.MakePath(dk, pkg,file);
		RDXPM.UnregisterTab(path, "ChatFrames")
	end
end);
RDXDBEvents:Bind("OBJECT_CREATED", nil, function(dk, pkg, file) 
	local path = RDXDB.MakePath(dk, pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabChatFrame" then
		local data = obj.data;
		local tit = "";
		if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("ChatFrames");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);
RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(dk, pkg, file) 
	local path = RDXDB.MakePath(dk,pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabChatFrame" then
		RDXPM.UnregisterTab(path, "ChatFrames");
		local data = obj.data;
		local tit = "";
		if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("ChatFrames");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);

-- run on UI load 
local function RegisterTabChatFrames()
	for pkgName,pkg in pairs(RDXDB.GetDisk("RDXData")) do
		for objName,obj in pairs(pkg) do
			if type(obj) == "table" and obj.ty == "TabChatFrame" then 
				local path = RDXDB.MakePath("RDXData", pkgName, objName);
				local data = obj.data;
				local tit = "";
				if data then tit = obj.data.title; end
				RDXPM.RegisterTab({
					name = path;
					title = path .. " " .. tit;
					category = VFLI.i18n("ChatFrames");
					GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
					GetBlankDescriptor = function() return {op = path}; end;
				});
			end
		end
	end
end

RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RegisterTabChatFrames();
end);]]
