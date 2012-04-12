-- ChatFrameManager.lua

local idToChatEvent = {
	"SYSTEM",
	"SAY",
	"EMOTE",
	"YELL",
	"WHISPER",
	"BN_WHISPER",
	"PARTY",
	"PARTY_LEADER",
	"RAID",
	"RAID_LEADER",
	"RAID_WARNING",
	"BATTLEGROUND",
	"BATTLEGROUND_LEADER",
	"GUILD",
	"OFFICER",
	"MONSTER_SAY",
	"MONSTER_YELL",
	"MONSTER_EMOTE",
	"MONSTER_WHISPER",
	"MONSTER_BOSS_EMOTE",
	"MONSTER_BOSS_WHISPER",
	"ERRORS",
	"AFK",
	"DND",
	"IGNORED",
	"BG_HORDE",
	"BG_ALLIANCE",
	"BG_NEUTRAL",
	"COMBAT_XP_GAIN",
	"COMBAT_HONOR_GAIN",
	"COMBAT_FACTION_CHANGE",
	"SKILL",
	"LOOT", 
	"CURRENCY",
	"MONEY",
	"OPENING",
	"TRADESKILLS",
	"PET_INFO",
	"COMBAT_MISC_INFO",
	"ACHIEVEMENT",
	"GUILD_ACHIEVEMENT",
	"CHANNEL",
	"BN_WHISPER",
	"BN_CONVERSATION",
	"BN_INLINE_TOAST_ALERT",
	"COMBAT_GUILD_XP_GAIN",
}

RDXPM.ChatEventFilterUI = {};
function RDXPM.ChatEventFilterUI:new(parent)
	local self = VFLUI.GroupBox:new(parent);
	VFLUI.GroupBox.MakeTextCaption(self, VFLI.i18n("Chat Events"));
	self:SetLayoutConstraint("WIDTH_DOWNWARD_HEIGHT_UPWARD");

	local checks = VFLUI.CheckGroup:new(self);
	self:SetClient(checks); checks:Show();
	checks:SetLayout(46, 1);
	for i=1,46 do 
		checks.checkBox[i]:SetText(idToChatEvent[i]); 
	end

	local all = VFLUI.Button:new(self);
	all:SetBackdrop(VFLUI.BorderlessDialogBackdrop);
	all:SetHeight(16); all:SetWidth(35); all:SetText(VFLI.i18n("All"));
	all:SetPoint("RIGHT", self:GetCaptionArea(), "RIGHT"); all:Show();
	all:SetScript("OnClick", function() for i=1,46 do checks.checkBox[i]:SetChecked(true); end end);
	self:AddDecoration(all);

	local none = VFLUI.Button:new(self);
	none:SetBackdrop(VFLUI.BorderlessDialogBackdrop);
	none:SetHeight(16); none:SetWidth(35); none:SetText(VFLI.i18n("None"));
	none:SetPoint("RIGHT", all, "LEFT"); none:Show();
	none:SetScript("OnClick", function() for i=1,46 do checks.checkBox[i]:SetChecked(); end end);
	self:AddDecoration(none);

	function self:GetChatEvents()
		local grps = {};
		for i=1,46 do
			if checks.checkBox[i]:GetChecked() then grps[i] = true; end
		end
		return grps;
	end
	function self:SetChatEvents(grps)
		if type(grps) ~= "table" then grps = nil; end
		for i=1,46 do
			if grps and grps[i] then checks.checkBox[i]:SetChecked(true); else checks.checkBox[i]:SetChecked(); end
		end
	end

	self.Destroy = VFL.hook(function(s)
		s.GetChatEvents = nil; s.SetChatEvents = nil;
	end, self.Destroy);

	return self;
end


RDXPM.ChatFrameEditor = {};
function RDXPM.ChatFrameEditor:new(parent)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent); 
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 3);
	end
	--self:SetWidth(346); self:SetHeight(340); 
	--self:SetBackdrop(VFLUI.BlackDialogBackdrop);
	self:Show();

	-- Scrollframe
	local sf = VFLUI.VScrollFrame:new(self);
	--sf:SetWidth(320); sf:SetHeight(330);
	--sf:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	sf:SetAllPoints(self);
	sf:Show();

	-- Root
	local ui = VFLUI.CompoundFrame:new(sf); ui.isLayoutRoot = true;
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Core Parameters")));
	
	local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
	ed_name:SetText(VFLI.i18n("Name"));
	ui:InsertFrame(ed_name);
	
	local chk_enable = VFLUI.Checkbox:new(ui); chk_enable:Show();
	chk_enable:SetText(VFLI.i18n("Enable"));
	ui:InsertFrame(chk_enable);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filter Parameters")));
	
	local events = RDXPM.ChatEventFilterUI:new(ui); events:Show();
	ui:InsertFrame(events);

	--- Layout Engine Bootstrap
	sf:SetScrollChild(ui);
	ui:SetWidth(sf:GetWidth());
	ui:DialogOnLayout(); ui:Show();

	function self:GetDescriptor()
		local desc = {};
		desc.name = ed_name.editBox:GetText();
		desc.enable = chk_enable:GetChecked();
		desc.etypes = events:GetChatEvents();
		return desc;
	end
	
	function self:SetDescriptor(desc)
		if not desc then return; end
		ed_name.editBox:SetText(desc.name);
		if desc.enable then chk_enable:SetChecked(true); else chk_enable:SetChecked(); end
		events:SetChatEvents(desc.etypes);
	end

	self.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil;
		s.SetDescriptor = nil;
		sf:SetScrollChild(nil);
		ui:Destroy(); ui = nil; sf:Destroy(); sf = nil;
	end, self.Destroy);

	return self;
end

local dlg = nil;
local function ChatFrameManagerDialog(parent)
	if dlg then return ; end
	------------------ CREATE
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetHeight(550); dlg:SetWidth(842);
	dlg:SetText(VFLI.i18n("ChatFrame Manager"));
	dlg:Show();
	
	if RDXPM.Ismanaged("ChatFrameManager") then RDXPM.RestoreLayout(dlg, "ChatFrameManager"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	
	local ca = dlg:GetClientArea();
	
	----------------------------------
	-- The table list
	----------------------------------
	local tlist = {};
	local sel = "";
	
	local ctlTblList = VFLUI.List:new(dlg, 12, function()
		local c = VFLUI.Selectable:new();
		c:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		c.OnDeparent = c.Destroy;
		return c;
	end);
	ctlTblList:SetPoint("TOPLEFT", ca, "TOPLEFT");
	ctlTblList:SetWidth(156); ctlTblList:SetHeight(500); 
	ctlTblList:Rebuild(); ctlTblList:Show();
	ctlTblList:SetDataSource(VFLUI.Selectable.ApplyData_TextOnly, VFL.ArrayLiterator(tlist));
	
	-----------------------------
	-- The table viewer
	-----------------------------
	local ctlTbl = RDXPM.ChatFrameEditor:new(ca)
	ctlTbl:SetPoint("TOPLEFT", ctlTblList, "TOPRIGHT");
	ctlTbl:SetWidth(676); ctlTbl:SetHeight(500);
	
	
	-----------------------------
	-- ListData
	-----------------------------
	local tinfo = { text = "ChatFrame1", 
		OnClick = function(self, arg1)
			if(arg1 == "LeftButton") then
				-- Save previous
				
				-- Open the new
				sel = "ChatFrame1";
				ctlTbl:SetDescriptor(RDXG.Chatframes[sel]);
			elseif(arg1 == "RightButton") then
				--TableRightClick(self, tbl, dlg);
			end
		end 
	};
	table.insert(tlist, tinfo);
	ctlTblList:Update();
	
	sel = "ChatFrame1";
	ctlTbl:SetDescriptor(RDXG.Chatframes[sel]);
				
	----------------- INTERACT
	local esch = function()
		RDXPM.StoreLayout(dlg, "ChatFrameManager");
		dlg:Destroy(); dlg = nil;
	end
	VFL.AddEscapeHandler(esch);
	
	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);
	
	----------------- DESTROY
	dlg.Destroy = VFL.hook(function(s)
		if ctlTbl then ctlTbl:Destroy(); ctlTbl = nil; end
		if ctlTblList then ctlTblList:Destroy(); ctlTblList = nil; end
	end, dlg.Destroy);
end




-- at load
-- create all chatframes + filters
-- store in RDXG
