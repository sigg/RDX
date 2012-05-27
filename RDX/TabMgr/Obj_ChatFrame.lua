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
	
	-- See if this chatframe was already instantiated...
	local inst = RDXDB.GetObjectInstance(path, true);

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(490); dlg:SetHeight(363);
	dlg:SetText(VFLI.i18n("Edit ChatFrame: ") .. path);
	if RDXPM.Ismanaged("ChatFrame") then RDXPM.RestoreLayout(dlg, "ChatFrame"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	dlg:Show();
	local ca = dlg:GetClientArea();
	
	local ed_name = VFLUI.LabeledEdit:new(ca, 150);
	ed_name:SetText(VFLI.i18n("Title"));
	ed_name.editBox:SetText(md.data.title);
	ed_name:SetHeight(25); ed_name:SetWidth(250);
	ed_name:SetPoint("TOPLEFT", ca, "TOPLEFT");
	ed_name:Show();
	dlg.ed_name = ed_name;
	
	local cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("Change chat color"), 150);
	cbtn:SetPoint("TOPLEFT", ed_name, "TOPRIGHT", 50, 0);
	
	local tabbox = VFLUI.TabBox:new(dlg, 22, "TOP");
	tabbox:SetWidth(490); tabbox:SetHeight(315);
	tabbox:SetPoint("TOPLEFT", ca, "TOPLEFT", -5, -30);
	tabbox:SetBackdrop(nil);
	
	tabbox:GetTabBar():AddTab("80", function() 
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
	end):SetText("Player");
	
	tabbox:GetTabBar():AddTab("80", function() 
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
	end):SetText("Creature");
	
	tabbox:GetTabBar():AddTab("80", function() 
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
	end):SetText(COMBAT);
	
	tabbox:GetTabBar():AddTab("80", function() 
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
	end):SetText(PVP);
	
	tabbox:GetTabBar():AddTab("80", function() 
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
	end):SetText(OTHER);
	
	local channelList;
	
	tabbox:GetTabBar():AddTab("80", function() 
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
		for k,v in ipairs(channelList) do
			v.enabled = md.data.channels[v.type];
		end
		fdata:Rebuild();
		fdata:Update();
	end, function()
		for k,v in ipairs(channelList) do
			md.data.channels[v.type] = v.enabled;
			v.enabled = nil;
		end
	end):SetText("Channels");
	
	tabbox:Show();
	tabbox:GetTabBar():SelectTabName("Player");
	
	dlg.tabbox = tabbox;
	
	local esch = function()
		RDXPM.StoreLayout(dlg, "ChatFrame");
		dlg:Destroy(); dlg = nil;
	end
	VFL.AddEscapeHandler(esch);

	local function Save()
		md.data.title = ed_name.editBox:GetText();
		dlg.tabbox:GetTabBar():UnSelectTab();
		RDXDB.NotifyUpdate(path);
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
		s.ed_name:Destroy(); s.ed_name = nil;
	end, dlg.Destroy);
end

-- Chatframe RDX object registration
RDXDB.RegisterObjectType({
	name = "ChatFrame";
	New = function(path, md)
		md.version = 1;
		md.data = {};
		md.data.title = "Chat";
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
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function() 
				VFL.poptree:Release(); 
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});

--------------- Tab Manager

RDXPM.RegisterTabCategory(VFLI.i18n("ChatFrames"));

------------------------------------------
-- Update hooks
------------------------------------------
RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg, file, md)
	if md and md.ty == "ChatFrame" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "ChatFrames")
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(pkg, file, newpkg, newfile, md)
	if md and md.ty == "ChatFrame" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "ChatFrames")
	end
end);
RDXDBEvents:Bind("OBJECT_CREATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "ChatFrame" then
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
RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "ChatFrame" then
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
local function RegisterChatFrames()
	for pkgName,pkg in pairs(RDXData) do
		for objName,obj in pairs(pkg) do
			if type(obj) == "table" and obj.ty == "ChatFrame" then 
				local path = RDXDB.MakePath(pkgName, objName);
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

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	RegisterChatFrames();
end);
