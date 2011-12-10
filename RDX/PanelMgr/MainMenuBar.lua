-- MainPanel.lua
-- OpenRDX

-- Fonts
VFLUI.RegisterFont({
	name = "MainPanel";
	title = "MainPanel";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 8;
	flags = "OUTLINE";
	sx = 1; sy = -1; sr = 0; sg = 0; sb = 0; sa = 1;
});

VFLUI.MenuDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80black", tile = true, tileSize = 8,
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },
};

VFLUI.MenuButtonDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80black", tile = true, tileSize = 4,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.MainMenuBarBackdrop = {
--	bgFile="Interface\\Addons\\RDX_mediapack\\Halcyon\\HalK", tile = false, tileSize = 4,
	bgFile="Interface\\Addons\\RDX\\skin\\speckle", tile = false, tileSize = 4,
	edgeFile="Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 }
};

RDXPM.POPMENUHIGH = 10;
local size = 40;

-- Menu
RDXPM.CharacterMenu = RDXPM.Menu:new();
RDXPM.GuildMenu = RDXPM.Menu:new();
RDXPM.DuiMenu = RDXPM.Menu:new();
RDXPM.ObjectMenu = RDXPM.Menu:new();
RDXPM.MainMenu = RDXPM.Menu:new();

local function CreateMainPane()
	local s = VFLUI.AcquireFrame("Button");
	s:SetParent(VFLFULLSCREEN_DIALOG);
	s:Hide();
	s:SetPoint("TOP", VFLParent, "TOP", -200, 2);
	s:SetHeight(size);
	s:SetWidth(5*size);
	s:SetBackdrop(VFLUI.MainMenuBarBackdrop);
	s:SetBackdropColor(0.541,0.541,0.541);

	----------------------------
	-- Automatic Show / Hide panel
	----------------------------
	local showpanel = false;
	local ismoving = nil;
	local handlemainpanel = 0;
	local allwaysshowpanel = nil;
	local menuOpen = nil;
	
	--[[function s:MainPanelLayout(show)
		local totalElapsed = 0;
		local toSize = 0;
		local valueshow = 0;
		 
		VFLT.AdaptiveSchedule(s, 0.021, function(_,elapsed)
			totalElapsed = totalElapsed + elapsed;
			ismoving = true;
			if totalElapsed > 0.5  then
				VFLT.AdaptiveUnschedule(s);
				totalElapsed = 0;
				if show then showpanel = true; else showpanel = false; end
				ismoving = nil;
			else
				valueshow = VFL.lerp1(1/.1*totalElapsed, 0, size);
				if show then
					toSize = size - valueshow;
				else
					toSize = valueshow;
				end
				s:ClearAllPoints();
				s:SetPoint("TOP", VFLParent, "TOP", -200, toSize + 2);
			end
		end);
		
	end]]
	
	function s:MainPanelLayout(show)
		s:ClearAllPoints();
		s:SetPoint("TOP", VFLParent, "TOP", -200, 2);
		s:Show();
	end
	
	--[[function s:HideMainPanel()
		if not ismoving then
			if showpanel and not allwaysshowpanel then
				if handlemainpanel then VFLT.ZMUnschedule(handlemainpanel); end
				handlemainpanel = VFLT.ZMSchedule(2, function() s:MainPanelLayout(); end);
			end
		end
	end]]
	
	function s:HideMainPanel()
		s:Hide();
	end
	
	function s:ShowMainPanel()
		--if not ismoving then 
		--	if not showpanel then
				s:MainPanelLayout(true);
		--	else
		--		if handlemainpanel then VFLT.ZMUnschedule(handlemainpanel); end
		--	end
		--end
	end
	
	--s:SetScript("OnEnter", function()
	--	s:ShowMainPanel()
	--end);
	--s:SetScript("OnLeave", function()
	--	s:HideMainPanel();
	--end);
	
	function s:SetAllwaysShow(val)
		allwaysshowpanel = val;
		if val then
			s:ShowMainPanel();
		else
			s:HideMainPanel();
		end
	end
	
	--------------------------------------
	-- Menu
	--------------------------------------
	
	local btn_CharacterMicroButton = VFLUI.AcquireFrame("Button");
	btn_CharacterMicroButton:SetParent(s);
	btn_CharacterMicroButton:SetPoint("TOPLEFT", s, "TOPLEFT", 0, -1);
	btn_CharacterMicroButton:SetHeight(size); btn_CharacterMicroButton:SetWidth(size);
	btn_CharacterMicroButton:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\crystal\\solo");
	btn_CharacterMicroButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	btn_CharacterMicroButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	btn_CharacterMicroButton:SetScript("OnClick", function(self, arg1)
		if(arg1 == "LeftButton") then
			RDXPM.CharacterMenu:Open("TOP", btn_CharacterMicroButton, "TOP", 0, 0);
		elseif(arg1 == "RightButton") then
			local index = GetActiveTalentGroup();
			if index == 1 then index = 2; else index = 1; end
			SetActiveTalentGroup(index);
		end
	end);
	--btn_CharacterMicroButton:SetScript("OnEnter", function()
	--	s:ShowMainPanel()
	--end);
	--btn_CharacterMicroButton:SetScript("OnLeave", function()
	--	s:HideMainPanel();
	--end);
	s.cmbfs = VFLUI.CreateFontString(s);
	s.cmbfs:SetPoint("TOP", btn_CharacterMicroButton, "BOTTOM");
	s.cmbfs:SetWidth(size); s.cmbfs:SetHeight(10);
	s.cmbfs:Show();
	VFLUI.SetFont(s.cmbfs, Fonts.MainPanel);
	s.cmbfs:SetText("Solo");
	
	local btn_GuildMicroButton = VFLUI.AcquireFrame("Button");
	btn_GuildMicroButton:SetParent(s);
	btn_GuildMicroButton:SetPoint("TOPLEFT", btn_CharacterMicroButton, "TOPRIGHT", 0, 0);
	btn_GuildMicroButton:SetHeight(size); btn_GuildMicroButton:SetWidth(size);
	btn_GuildMicroButton:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\crystal\\multi");
	btn_GuildMicroButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	btn_GuildMicroButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	btn_GuildMicroButton:SetScript("OnClick", function(self, arg1)
		if(arg1 == "LeftButton") then
			RDXPM.GuildMenu:Open("TOP", btn_GuildMicroButton, "TOP", 0, 0);
		elseif(arg1 == "RightButton") then
		end
	end);
	--btn_GuildMicroButton:SetScript("OnEnter", function()
	--	s:ShowMainPanel()
	--end);
	--btn_GuildMicroButton:SetScript("OnLeave", function()
	--	s:HideMainPanel();
	--end);
	s.gmbfs = VFLUI.CreateFontString(s);
	s.gmbfs:SetPoint("TOP", btn_GuildMicroButton, "BOTTOM");
	s.gmbfs:SetWidth(size); s.gmbfs:SetHeight(10);
	s.gmbfs:Show();
	VFLUI.SetFont(s.gmbfs, Fonts.MainPanel);
	s.gmbfs:SetText("Multi");
	
	--local btn_MainMenuBarBackpackButton = VFLUI.AcquireFrame("Button");
	--btn_MainMenuBarBackpackButton:SetParent(s);
	--btn_MainMenuBarBackpackButton:SetPoint("TOPLEFT", btn_GuildMicroButton, "TOPRIGHT", 0, 0);
	--btn_MainMenuBarBackpackButton:SetHeight(size); btn_MainMenuBarBackpackButton:SetWidth(size);
	--btn_MainMenuBarBackpackButton:SetNormalTexture("Interface\\Addons\\VFL\\Skin\\Upojenie\\Dropbox");
	--btn_MainMenuBarBackpackButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	--btn_MainMenuBarBackpackButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	--btn_MainMenuBarBackpackButton.isBag = 1;
	--btn_MainMenuBarBackpackButton:SetScript("OnClick", function(self, arg1)
	--	if(arg1 == "LeftButton") then
	--		OpenAllBags();
	--	elseif(arg1 == "RightButton") then
	--		if (CursorHasItem()) then
	--			PutKeyInKeyRing();
	--		else
	--			ToggleKeyRing();
	--		end
	--	end
	--end);
	
	local btn_AUI = VFLUI.AcquireFrame("Button");
	btn_AUI:SetParent(s);
	btn_AUI:SetPoint("TOPLEFT", btn_GuildMicroButton, "TOPRIGHT", 0, 0);
	btn_AUI:SetHeight(size); btn_AUI:SetWidth(size);
	btn_AUI:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\crystal\\ui");
	btn_AUI:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	btn_AUI:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	btn_AUI:SetScript("OnClick", function(self, arg1)
		if not InCombatLockdown() then
			if(arg1 == "LeftButton") then
				RDXPM.DuiMenu:Open("TOP", btn_AUI, "TOP", 0, 0);
			elseif(arg1 == "RightButton") then
				if not InCombatLockdown() then
					local curdesk = RDXDK.GetCurrentDesktop();
					if curdesk then
						RDXDK.ToggleDesktopTools(VFLFULLSCREEN_DIALOG, curdesk:_GetFrameProps("root"));
					end
				end
			end
		end
	end);
	--btn_AUI:SetScript("OnEnter", function()
	--	s:ShowMainPanel()
	--end);
	--btn_AUI:SetScript("OnLeave", function()
	--	s:HideMainPanel();
	--end);
	s.auifs = VFLUI.CreateFontString(s);
	s.auifs:SetPoint("TOP", btn_AUI, "BOTTOM");
	s.auifs:SetWidth(size); s.auifs:SetHeight(10);
	s.auifs:Show();
	VFLUI.SetFont(s.auifs, Fonts.MainPanel);
	s.auifs:SetText("UI");
	
	local btn_repository = VFLUI.AcquireFrame("Button");
	btn_repository:SetParent(s);
	btn_repository:SetPoint("TOPLEFT", btn_AUI, "TOPRIGHT", 0, 0);
	btn_repository:SetHeight(size); btn_repository:SetWidth(size);
	btn_repository:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\crystal\\database");
	btn_repository:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	btn_repository:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	btn_repository:SetScript("OnClick", function(self, arg1)
		if(arg1 == "LeftButton") then
			RDXPM.ObjectMenu:Open("TOP", btn_repository, "TOP", 0, 0);
		elseif(arg1 == "RightButton") then
			RDXDB.ToggleObjectBrowser();
		end
	end);
	--btn_repository:SetScript("OnEnter", function()
	--	s:ShowMainPanel()
	--end);
	--btn_repository:SetScript("OnLeave", function()
	--	s:HideMainPanel();
	--end);
	s.rfs = VFLUI.CreateFontString(s);
	s.rfs:SetPoint("TOP", btn_repository, "BOTTOM");
	s.rfs:SetWidth(size); s.rfs:SetHeight(10);
	s.rfs:Show();
	VFLUI.SetFont(s.rfs, Fonts.MainPanel);
	s.rfs:SetText("Repo");
	
	local btn_MainMenuMicroButton = VFLUI.AcquireFrame("Button");
	btn_MainMenuMicroButton:SetParent(s);
	btn_MainMenuMicroButton:SetPoint("TOPLEFT", btn_repository, "TOPRIGHT", 0, 0);
	btn_MainMenuMicroButton:SetHeight(size); btn_MainMenuMicroButton:SetWidth(size);
	btn_MainMenuMicroButton:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\crystal\\settings");
	btn_MainMenuMicroButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	btn_MainMenuMicroButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	btn_MainMenuMicroButton:SetScript("OnClick", function(self, arg1)
		if(arg1 == "LeftButton") then
			RDXPM.MainMenu:Open("TOP", btn_MainMenuMicroButton, "TOP", 0, 0);
		elseif(arg1 == "RightButton") then
			if GameMenuFrame:IsShown() then
				HideUIPanel(GameMenuFrame);
			else 
				ShowUIPanel(GameMenuFrame);
			end
		end
	end);
	--btn_MainMenuMicroButton:SetScript("OnEnter", function()
	--	s:ShowMainPanel()
	--end);
	--btn_MainMenuMicroButton:SetScript("OnLeave", function()
	--	s:HideMainPanel();
	--end);
	s.mmmfs = VFLUI.CreateFontString(s);
	s.mmmfs:SetPoint("TOP", btn_MainMenuMicroButton, "BOTTOM");
	s.mmmfs:SetWidth(size + 4); s.mmmfs:SetHeight(10);
	s.mmmfs:Show();
	VFLUI.SetFont(s.mmmfs, Fonts.MainPanel);
	s.mmmfs:SetText("Settings");
	
	s.mover = VFLUI.AcquireFrame("Button");
	s.mover:SetPoint("TOPLEFT", btn_CharacterMicroButton, "BOTTOMLEFT");
	s.mover:SetWidth(5*size); s.mover:SetHeight(10);
	s.mover:Show();
	--s.mover:SetScript("OnEnter", function()
	--	s:ShowMainPanel()
	--end);
	--s.mover:SetScript("OnLeave", function()
	--	s:HideMainPanel();
	--end);
	
	s.infofs = VFLUI.CreateFontString(s);
	s.infofs:SetPoint("TOPLEFT", btn_MainMenuMicroButton, "TOPRIGHT");
	s.infofs:SetWidth(200); s.infofs:SetHeight(12);
	s.infofs:Show();
	VFLUI.SetFont(s.infofs, Fonts.MainPanel, 10, true);
	
	s.perffs = VFLUI.CreateFontString(s);
	s.perffs:SetPoint("TOPLEFT", s.infofs, "BOTTOMLEFT");
	s.perffs:SetWidth(200); s.perffs:SetHeight(12);
	s.perffs:Show();
	VFLUI.SetFont(s.perffs, Fonts.MainPanel, 10, true);
	
	VFLT.AdaptiveSchedule("infoaui", 1, function()
		if RDXU and RDXU.AUI then
			local _, auiname = RDXDB.ParsePath(RDXU.AUI);
			if RDXU.autoSwitchState then
				s.infofs:SetText((auiname or "Unknown") .. ":" .. "Auto");
			else
				s.infofs:SetText((auiname or "Unknown") .. ":" .. (RDXU.AUIState or "Unknown"));
			end
			s.perffs:SetText(VFLP.GetTextPerf());
		end
	end);
	
	----------------------------------------
	-- Button Idesktop
	----------------------------------------
	
	local line1 = VFLUI.AcquireFrame("Frame");
	line1:SetParent(s);
	if UIParent:GetWidth() < 1060 then
		line1:SetPoint("TOPLEFT", btn_omni, "BOTTOMRIGHT", 20, -5);
	else
		line1:SetPoint("TOPLEFT", btn_omni, "TOPRIGHT", 300, 0);
	end
	line1:SetHeight(22); line1:SetWidth(500);
	--line1:SetBackdrop(VFLUI.BorderlessDialogBackdrop);
	line1:Show();
	
	-- mainbuttondb : first line of button
	-- buttondb : second line of button
	local mainbuttondb, buttondb = {}, {};
	local sortedmb, sortedb = {}, {};
	
	local lastBtn, tmpbtns, mbtns, btns, sl = nil, nil, {}, {}, nil;
	
	local idState = {};
	
	-- Function to layout buttons
	function s:buttonsLayout(line, id, state)
		lastBtn = nil; 
		if line == "main" then
			tmpbtns = mbtns;
		else
			tmpbtns = btns;
		end
		for k,v in pairs(tmpbtns) do
			local grow = nil;
						
			if state == "mousein" then
				grow = true;
			end
			
			local h = v:GetHeight();
			local w = v:GetWidth();
			if h == 0 or h > 31 then h = 20; v:SetHeight(h); end
			if w == 0 or w > 31 then w = 20; v:SetWidth(w); end
			
			if id == k  and state then
				VFLT.AdaptiveUnschedule(v);
				local totalElapsed = 0;
				local toSize = 20;
				VFLT.AdaptiveSchedule(v, 0.021, function(_,elapsed)
					totalElapsed = totalElapsed + elapsed;
					if totalElapsed > .5 then
						VFLT.AdaptiveUnschedule(v);
						totalElapsed = 0;
					else
						if grow then
							toSize = 40;
						else
							toSize = 20;
						end
						v:SetHeight(VFL.lerp1(1/.1*totalElapsed, h, toSize));
						v:SetWidth(VFL.lerp1(1/.1*totalElapsed, w, toSize));
					end
				end);
			end
			
			if lastBtn then
				if line == "main" then
					v:SetPoint("TOPLEFT", lastBtn, "TOPRIGHT", 1, 0);
				else
					v:SetPoint("LEFT", lastBtn, "RIGHT", 1, 0);
				end
			else
				if line == "main" then
					v:SetPoint("TOPLEFT", line1, "TOPLEFT", 1, 0);
				else
					v:SetPoint("LEFT", line2, "LEFT", 1, -1);
				end
				
			end
			lastBtn = v;
		end
	end
	
	function s:ButtonsLayoutAll()
		self:buttonsLayout("main");
	end

	function s:removebutton(name)
		self:buttonsLayout("main");
		mainbuttondb[name] = nil;
		self:ShowMainButtons();
	end
	
	function s:removeAllbuttons()
		self:buttonsLayout("main");
		VFL.empty(mainbuttondb);
		self:ShowMainButtons();
	end
	
	function s:HideMainButtons()
		for k,v in pairs(mbtns) do
			mbtns[k]:Destroy(); mbtns[k] = nil;
		end
		self:buttonsLayout("main");
	end
	
	function s:ShowMainButtons()
		self:HideMainButtons();
		local bnttmp;
		for k,v in pairs(mainbuttondb) do
			bnttmp = VFLUI.AcquireFrame("Button");
			bnttmp:SetParent(s);
			bnttmp:SetFrameLevel(1);
			bnttmp:SetNormalTexture(v.texture);
			bnttmp._name = v.name;
			bnttmp._texture = v.texture;
			
			bnttmp:SetScript("OnClick", function()
				GameTooltip:Hide();
				RDXDK.QueueLockdownAction(RDXDK._OpenWindowRDX, v.name, true);
			end);
			
			bnttmp:SetScript("OnEnter", function()
				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint("TOPLEFT", mbtns[k], "BOTTOMRIGHT");
				GameTooltip:ClearLines();
				GameTooltip:AddLine(v.title, 1, 1, 1, 1, true);
				--GameTooltip:AddLine(v.desc);
				GameTooltip:Show();
				self:buttonsLayout("main", k, "mousein");
			end);
			bnttmp:SetScript("OnLeave", function()
				GameTooltip:Hide();
				self:buttonsLayout("main", k, "mouseout");
			end);
			bnttmp:Show();
			-- store the buttons
			mbtns[k] = bnttmp;
		end
		self:buttonsLayout("main");
	end
	
	---------------------------------
	-- Messages
	---------------------------------
	local messagelist, messagebuttons, maxmessage = {}, {}, 10;
	
	local anchorf;
	for i = 1, maxmessage do
		local btn = VFLUI.AcquireFrame("Button");
		btn:SetBackdrop(VFLUI.DefaultDialogBorder);
		btn:SetNormalFontObject(Fonts.Default8Shadowed);
		btn:SetHeight(14); btn:SetWidth(240);
		btn:RegisterForClicks("AnyUp");
		if anchorf then
			btn:SetPoint("TOP", anchorf, "BOTTOM", 0, -1);
		else
			btn:SetPoint("TOP", s, "BOTTOM", 0, -12);
		end
		anchorf = btn;
		btn:Hide();
		messagebuttons[i] = btn;
	end
	
	function s:LayoutMessages()
		local af = nil;
		local i = 1;
		local btn;
		for _,btn in ipairs(messagebuttons) do
			v = messagelist[i];
			if v then
				btn:SetText(v.text:sub(1, 80));
				if v.func then btn:SetScript("OnClick", v.func); else btn:SetScript("OnClick", nil); end
				btn:Show()
			else
				btn:Hide();
			end
			i = i +1
		end
	end
	
	function s:AddMessage(text, delay, func)
		--if s:IsShown() and not func then
			local msg = {}
			msg.start = GetTime();
			msg.duration = delay;
			msg.text = text;
			msg.func = func;
			table.insert(messagelist, msg);
			s:LayoutMessages();
			--VFL.print(text);
		--end
	end
	
	function s:RemoveMessage()
		local ctime, found = GetTime(), false;
		for i,v in ipairs(messagelist) do
			if v.start + v.duration < ctime then
				table.remove(messagelist, i);
				found = true;
			end
		end
		if found then
			s:LayoutMessages();
		end
	end
	
	VFLT.AdaptiveSchedule("mainpanel", 1, function() s:RemoveMessage(); end);
	VFLEvents:Bind("ERRORLUA", nil, function(err) s:AddMessage(err, 20, function() VFL.OpenErrorDialog(); end) end);
	VFLEvents:Bind("ERROR", nil, function(err) s:AddMessage(err, 20, function() VFL.OpenErrorDialog(); end) end);
	--RDXEvents:Bind("INFO", nil, function(err) s:AddMessage(err, 10) end);
	--RDXEvents:Bind("WARNING", nil, function(err) s:AddMessage(err, 10) end);
	RDXEvents:Bind("ERROR", nil, function(err) s:AddMessage(err, 20) end);
	
	----------------------
	-- Skin
	----------------------
	
	function s:SetSkin(name)
		local tbl = RDX.GetSkin(name);
		btn_CharacterMicroButton:SetNormalTexture(tbl.solo);
		btn_GuildMicroButton:SetNormalTexture(tbl.multi);
		btn_AUI:SetNormalTexture(tbl.ui);
		btn_repository:SetNormalTexture(tbl.database);
		btn_MainMenuMicroButton:SetNormalTexture(tbl.settings);
	end
	
	-----------------------------------
	-- Destroy
	-----------------------------------
	
	s.Destroy = VFL.hook(function(self)
		self.SetSkin = nil;
		VFLUI.ReleaseRegion(tx1); tx1 = nil;
		VFLUI.ReleaseRegion(tx2); tx2 = nil;
		tBtn:Destroy(); tBtn = nil;
		self:HideMainButtons(); self.HideMainButtons = nil; self.ShowMainButtons = nil;
		self:HideSubButtons(); self.HideSubButtons = nil; v.ShowSubButtons = nil;
		self.Layout = nil; self.buttonsLayout = nil; tmpbtns = nil; mntns = nil; btns = nil; lastBtn = nil;
		line1:Destroy(); line1 = nil;
		line2:Destroy(); line2 = nil;
		line3:Destroy(); line3 = nil;
		VFLUI.ReleaseRegion(tTxtLeft); tTxtLeft = nil;
		VFLUI.ReleaseRegion(tTxtRight); tTxtRight = nil;
		self.SetDesktopName = nil;
	end, s.Destroy);

	return s;
end

----------------------------------------------
-- INIT
-- Create the menu pane and show all buttons
----------------------------------------------

local mainPane;

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	if not RDXG.RDXopt then RDXG.RDXopt = {}; RDXG.RDXopt.hmp = true; end
	local opt = RDXG.RDXopt;
	
	VFLT.NextFrame(math.random(10000000), function()
		mainPane = CreateMainPane();
		mainPane:HideMainPanel();	
		mainPane:SetAllwaysShow(opt.asmp);
	
		if RDXPM.IsPanelHidden() then
			RDXPM.HidePanel();
		else
			RDXPM.ShowPanel();
		end
		-- skin update
		if opt.mmskin and RDX.IsMMSkinValid(opt.mmskin) then
			mainPane:SetSkin(opt.mmskin);
		end
	end);
end);

function RDXPM.GetMainPane() return mainPane; end

-- TODO: Need a global option for hidden/shown panel.
function RDXPM.ShowPanel()
	RDXG.RDXopt.hmp = false;
	mainPane:Show();
end

function RDXPM.HidePanel()
	RDXG.RDXopt.hmp = true;
	mainPane:Hide();
end

function RDXPM.IsPanelHidden()
	return RDXG.RDXopt.hmp;
end

function RDXPM.ToggleHidePanel()
	if RDXPM.IsPanelHidden() then
		RDXPM.ShowPanel();
	else
		RDXPM.HidePanel();
	end
end
RDXPM.RegisterSlashCommand("showpanel", RDXPM.ShowPanel);
RDXPM.RegisterSlashCommand("hidepanel", RDXPM.HidePanel);

RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = "Character";
	ent.isTitle = true;
	ent.notCheckable = true;
	ent.justifyH = "CENTER";
end);
RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Character");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleCharacter("PaperDollFrame"); end;
end);
RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("SpellBook");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() 
	--ToggleFrame(SpellBookFrame);
		if SpellBookFrame:IsShown() then
			HideUIPanel(SpellBookFrame);
		else
			ShowUIPanel(SpellBookFrame);
		end
	end;
end);
RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Talents");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleTalentFrame(); end;
end);
RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Achievements");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleAchievementFrame(); end;
end);
RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Quests");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleFrame(QuestLogFrame); end;
end);
RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Encounters");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleEncounterJournal(); end;
end);
RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Bags");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() OpenAllBags(); end;
end);
--RDXPM.CharacterMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Key Bag");
--	ent.notCheckable = true;
--	ent.func = function() ToggleKeyRing(); end;
--end);

RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = "Guild/Raid";
	ent.isTitle = true;
	ent.notCheckable = true;
	ent.justifyH = "CENTER";
end);
RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Calendar");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleCalendar(); end;
end);
RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Social");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleFriendsFrame(); end;
end);
RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Guild");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleGuildFrame(); end;
end);
RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("PVP");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() TogglePVPFrame(); end;
end);
RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("LFD");
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.func = function() ToggleLFDParentFrame(); end;
end);

local mem_logs = nil;
local omni_color = _green;
local function GetMemoryLogs()
	mem_logs = GetAddOnMemoryUsage("RDX_combatlogs");
	omni_color = _green;
	if mem_logs > 1000 then omni_color = _yellow; end
	if mem_logs > 2000 then omni_color = _orange; end
	if mem_logs > 3000 then omni_color = _red; end
	mem_logs = mem_logs * 1000;
	return VFL.KayMemory(mem_logs, omni_color);
end

local mem_repo = nil;
local mem_repo_color = _green;
local function GetMemoryRepo()
	mem_repo = GetAddOnMemoryUsage("RDX_filesystem");
	mem_repo_color = _green;
	if mem_repo > 10000 then mem_repo_color = _yellow; end
	if mem_repo > 20000 then mem_repo_color = _orange; end
	if mem_repo > 30000 then mem_repo_color = _red; end
	mem_repo = mem_repo * 1000;
	return VFL.KayMemory(mem_repo, mem_repo_color);
end

RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	local recentSearches = {};
	
	if RDXU and RDXU.icMRU then
		for k,v in ipairs(RDXU.icMRU) do
			table.insert(recentSearches, { text = k .. ". " .. v, func = function() Logistics.DoInvCheck(v); end , notCheckable = true});
		end
	end
	
	local inventoryMenu = {
		{ text = VFLI.i18n("Potions"), notCheckable = true, keepShownOnClick = false, func = function() Logistics.DoInvCheck("*potion*"); end },
		{ text = VFLI.i18n("Healthstone"), notCheckable = true, keepShownOnClick = false, func = function() Logistics.DoInvCheck("*healthstone*"); end },
		{ text = VFLI.i18n("Custom..."), notCheckable = true, keepShownOnClick = false, func = Logistics.InvCheckFrontend },
		{ text = VFLI.i18n("Recent Searches"), notCheckable = true, hasArrow = true, menuList = recentSearches }
	}
	local checkMenu = {
		{ text = VFLI.i18n("RDX Version"), notCheckable = true, keepShownOnClick = false, func = RDX.VersionCheck_Start },
		{ text = VFLI.i18n("Durability"), notCheckable = true, keepShownOnClick = false, func = Logistics.DuraCheck_Start },
		{ text = VFLI.i18n("Resists"), notCheckable = true, keepShownOnClick = false, func = Logistics.ResistCheck_Start },
		{ text = VFLI.i18n("Ready Check"), notCheckable = true, keepShownOnClick = false, func = Logistics.ReadyCheck },
		{ text = VFLI.i18n("Poll"), notCheckable = true, keepShownOnClick = false, func = Logistics.CustomPollDlg },
		{ text = VFLI.i18n("Inventory"), notCheckable = true, hasArrow = true, menuList = inventoryMenu }
	}
	ent.text = VFLI.i18n("Raid Checks");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.menuList = checkMenu;
	
end);

RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Assists");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.menuList = {
		{ text = VFLI.i18n("Add Target to Assists"), notCheckable = true, keepShownOnClick = false, func = Logistics.AddAssist },
		{ text = VFLI.i18n("Remove Target from Assists"), notCheckable = true, keepShownOnClick = false, func = Logistics.DropAssist },
		{ text = VFLI.i18n("Sync Assists"), notCheckable = true, keepShownOnClick = false, func = Logistics.SyncAssists },
		{ text = VFLI.i18n("Clear Assists"), notCheckable = true, keepShownOnClick = false, func = Logistics.ClearAssists }
	};
end);

RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Roster Manager");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.menuList = {
		{ text = VFLI.i18n("Open Roster"), notCheckable = true, keepShownOnClick = false, func = RDX.OpenRosterWindow },
		{ text = VFLI.i18n("Disband Raid"), notCheckable = true, keepShownOnClick = false, func = Logistics.Disband },
		{ text = VFLI.i18n("Toggle Keyword Invite"), notCheckable = true, keepShownOnClick = false, func = Logistics.ToggleKeyword },
		{ text = VFLI.i18n("Change Invite Keyword"), notCheckable = true, keepShownOnClick = false, func = Logistics.SetKeyword },
		{ text = VFLI.i18n("Request Invite"), notCheckable = true, keepShownOnClick = false, func = Logistics.RequestInvite },
		{ text = VFLI.i18n("Remote Logout"), notCheckable = true, keepShownOnClick = false, func = Logistics.BootAfk }
	};
end);

RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Logistics");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.menuList = {
		{ text = VFLI.i18n("Logs"), notCheckable = true, hasArrow = true, menuList = {
				{ text = VFLI.i18n("Query Raid Logs"), notCheckable = true, keepShownOnClick = false, func = Omni.ToggleOmniSearch },
				{ text = VFLI.i18n("Open Analyser"), notCheckable = true, keepShownOnClick = false, func = Omni.ToggleOmniBrowser },
				{ text = VFLI.i18n("Reset Logs: " .. GetMemoryLogs()), notCheckable = true, keepShownOnClick = false, func = Omni.ResetLogs }
			}
		},
		--{ text = VFLI.i18n("Damage Meters"), notCheckable = true, hasArrow = true, menuList = {
		--		{ text = VFLI.i18n("Sync Meters"), notCheckable = true, func = RDXDAL.ToggleSyncDamageMeter },
		--		{ text = VFLI.i18n("Reset Meters"), notCheckable = true, func = RDXDAL.ResetDamageMeter }
		--	}
		--}

	};
end);

RDXPM.GuildMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Bossmods");
	ent.notCheckable = true;
	ent.hasArrow = true;
	ent.menuList = {
		{ text = VFLI.i18n("     Encounter Panel"), notCheckable = true, keepShownOnClick = false, func = RDX.ToggleEncounterPane },
		{ text = VFLI.i18n("Track Abilities"), checked = function() return RDXU.atracker; end, keepShownOnClick = false, func = RDXBM.ToggleAbilityTracker },
		{ text = VFLI.i18n("Move Alerts"), checked = RDXBM.isMoveAlerts, keepShownOnClick = false, func = RDXBM.ToggleMoveAlerts },
		{ text = VFLI.i18n("Sound Alerts"), checked = function() return not RDXU.nosound; end, keepShownOnClick = false, func = function() RDXU.nosound = not RDXU.nosound; end },
		{ text = VFLI.i18n("Announcer"), checked = function() return RDXU.spam; end, keepShownOnClick = false, func = function() if RDXU.spam then RDX.AnnounceOff(); else RDX.AnnounceOn(); end end }
	};
end);

-----------------------------------------------------------------------------------

-- ObjectsMenu.lua
-- OpenRDX
--

RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Packages");
	ent.isTitle = true;
	ent.notCheckable = true;
	ent.justifyH = "CENTER";
end);

RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Repo Size: ") .. GetMemoryRepo();
	ent.func = VFL.Noop;
	ent.notCheckable = true;
end);

RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Package Options");
	ent.hasArrow = true;
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.menuList = {
		{ text = VFLI.i18n("Package Explorer"), notCheckable = true, keepShownOnClick = false, func = RDXDB.ToggleObjectBrowser },
		{ text = VFLI.i18n("Package Updater"), notCheckable = true, keepShownOnClick = false, func = RDXDB.ToggleRAU },
		{ text = VFLI.i18n("OOBE Manager"), notCheckable = true, keepShownOnClick = false, func = RDXDB.DropOOBE },
		--{ text = "     " .. VFLI.i18n("Package Explorer"), notCheckable = true, func = RDXDB.ToggleObjectBrowser },
		--{ text = "     " .. VFLI.i18n("Package Updater"), notCheckable = true, func = RDXDB.ToggleRAU },
		--{ text = "     " .. VFLI.i18n("OOBE Manager"), notCheckable = true, func = RDXDB.DropOOBE },
		--{ text = VFLI.i18n("Package Sharing"), checked = function() return not RDX.IsRcvDisable(); end, func = function() RDX.ToggleRcvPackage(); end }

	};
end);

RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Backups");
	ent.hasArrow = true;
	ent.notCheckable = true;
	ent.keepShownOnClick = false;
	ent.menuList = {
		{ text = VFLI.i18n("Backup Packages"), notCheckable = true, keepShownOnClick = false, func = RDXDB.BackupPackages },
		{ text = VFLI.i18n("Restore Packages"), notCheckable = true, keepShownOnClick = false, func = RDXDB.RestorePackages }
	};
end);

RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = "*******************";
	ent.notCheckable = true;
	ent.func = VFL.Noop;
end);

RDX.thirdpartymenu = {};
RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Third Party");
	ent.hasArrow = true;
	ent.notCheckable = true;
	ent.menuList = RDX.thirdpartymenu;
end);

function RDX.RegisterThirdPartyMenu(menu)
	if not menu then return nil; end
	table.insert(RDX.thirdpartymenu, menu);
end

-- temporary removed
--RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
--	ent.text = VFLI.i18n("Window Wizard");
--	ent.func = RDX.NewWindowWizard;
--	ent.notCheckable = true;
--end);

RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = "*******************";
	ent.notCheckable = true;
	ent.func = VFL.Noop;
end);

RDXPM.ObjectMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Reset RDX");
	ent.notCheckable = true;
	ent.func = RDXDB.MasterReset;
end);
-----------------------------------------------------------------------------------

RDXPM.MainMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Settings");
	ent.isTitle = true;
	ent.notCheckable = true;
	ent.justifyH = "CENTER";
end);
RDXPM.MainMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("MainMenu");
	ent.notCheckable = true;
	ent.func = function() if GameMenuFrame:IsShown() then
				HideUIPanel(GameMenuFrame);
			else 
				ShowUIPanel(GameMenuFrame);
			end
	end;
end);
RDXPM.MainMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Help");
	ent.notCheckable = true;
	ent.func = function() ToggleHelpFrame(); end;
end);
RDXPM.MainMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("RDX Settings");
	ent.func = RDXPM.ToggleRDXManage;
	ent.notCheckable = true;
end);

RDXPM.MainMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Learn Wizard");
	ent.func = function() RDX.NewLearnWizard(); end;
	ent.notCheckable = true;
end);

RDXPM.MainMenu:RegisterMenuFunction(function(ent)
	ent.text = VFLI.i18n("Debugging");
	ent.hasArrow = true;
	ent.notCheckable = true;
	ent.menuList = {
		{ text = VFLI.i18n("     Open Set Debugger"), notCheckable = true, keepShownOnClick = false, func = RDXM_Debug.SetDebugger },
		{ text = VFLI.i18n("     Open Profiler"), notCheckable = true, keepShownOnClick = false, func = VFLP.ToggleProfiler },
		{ text = VFLI.i18n("     Open ErrorDialog"), notCheckable = true, keepShownOnClick = false, func = VFL.ToggleErrorDialog },
		{ text = VFLI.i18n("     Fire Disrupt Signal"), notCheckable = true, keepShownOnClick = false, func = RDX._Disrupt },
		{ text = VFLI.i18n("     Fire Roster Update Signal"), notCheckable = true, keepShownOnClick = false, func = RDX._Roster },
		{ text = VFLI.i18n("     Reset Editor Layout"), notCheckable = true, keepShownOnClick = false, func = RDXPM.ResetLayouts },
		{ text = VFLI.i18n("     Garbage Collect"), notCheckable = true, keepShownOnClick = false, func = VFLGC },
		--{ text = VFLI.i18n("Fake Roster Units"), checked = RDXDAL.IsDummy, func = function() RDXEvents:Dispatch("ROSTER_DUMMY"); end },
		{ text = VFLI.i18n("Store Compiled Code"), checked = RDXM_Debug.IsStoreCompilerActive, keepShownOnClick = false, func = RDXM_Debug.ToggleStoreCompiler },
		{ text = VFLI.i18n("Party with me"), checked = RDXM_Debug.IsPartyIncludeMe, keepShownOnClick = false, func = RDXM_Debug.TogglePartyIncludeMe },
		{ text = VFLI.i18n("     Wipe CooldownDB"), notCheckable = true, keepShownOnClick = false, func = RDXCD.WipeCooldownDB },
		{ text = VFLI.i18n("     Print CooldownDB"), notCheckable = true, keepShownOnClick = false, func = RDXCD.DebugCooldownDB },
		{ text = VFLI.i18n("     Reset Chatframes"), notCheckable = true, keepShownOnClick = false, func = function() FCF_ResetChatWindows(); ReloadUI(); end },
	};
end);
