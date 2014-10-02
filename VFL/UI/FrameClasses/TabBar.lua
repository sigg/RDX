-- TabBar.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A tab bar is a scrollable row of clickable buttons that are usually used
-- to perform manipulations on an underlying window.

--local topTabBackdrop = {
--	edgeFile="Interface\\Addons\\VFL\\Skin\\tab_top", edgeSize = 16,
--	insets = { left = 5, right = 5, top = 4, bottom = 5 }
--};

local topTabBackdrop = {
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder"; edgeSize = 8;
	insets = { left = 2, right = 2, top = 2, bottom = 2 };
	_bkdtype = 1;
	borl = 2;
	bors = 1;
};

--local bottomTabBackdrop = {
--	edgeFile="Interface\\Addons\\VFL\\Skin\\tab_bottom", edgeSize = 16,
--	insets = { left = 5, right = 5, top = 4, bottom = 5 }
--};

local bottomTabBackdrop = {
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder"; edgeSize = 8;
	insets = { left = 2, right = 2, top = 2, bottom = 2 };
	_bkdtype = 1;
	borl = 2;
	bors = 1;
};

local function NewTabButtonTop(parent)
	local btn = VFLUI.AcquireFrame("Button");
	btn:SetBackdrop(topTabBackdrop);

	-- Textures
	local tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.1);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn.texBkg = tex;

	-- Normal Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetNormalTexture(tex);

	-- Disabled Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(0.5, 0.5, 0.5, 1);
	tex:SetDrawLayer("ARTWORK", 2);	
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetDisabledTexture(tex);

	-- Highlight Texture IS NOT OWNED by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.2);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetHighlightTexture(tex);
	btn.texHlt = tex;

	-- Pushed Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0.4);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetPushedTexture(tex);

	-- Fonts
	--btn:SetNormalFontObject(Fonts.Default);
	btn.font = VFLUI.CreateFontString(btn);
	btn.font:SetAllPoints(btn);
	btn.font:Show();
	VFLUI.SetFont(btn.font, Fonts.default);
	
	btn.StartFlash = function()
		btn.elapsed = 0;
		btn:SetScript("OnUpdate", function(self, elapsed)
			self.elapsed = self.elapsed + elapsed
			if self.elapsed > 0.5 then
				if self.hlt then
					self:UnlockHighlight();
					self.hlt = nil;
				else
					self:LockHighlight();
					self.hlt = true;
				end
				self.elapsed = 0;
			end
		end);
	end
	
	btn.StopFlash = function()
		btn:SetScript("OnUpdate", nil);
	end

	btn.Destroy = VFL.hook(function(s)
		s:StopFlash();
		s.StartFlash = nil;
		s.StopFlash = nil;
		VFLUI.ReleaseRegion(s.font);
		s.font = nil;
		VFLUI.ReleaseRegion(s.texBkg);
		s.texBkg = nil;
		VFLUI.ReleaseRegion(s.texHlt);
		s.texHlt = nil;
	end, btn.Destroy);

	return btn;
end

local function NewTabButtonBottom(parent)
	local btn = VFLUI.AcquireFrame("Button");
	btn:SetBackdrop(bottomTabBackdrop);

	-- Textures
	local tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.1);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn.texBkg = tex;

	-- Normal Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetNormalTexture(tex);

	-- Disabled Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(0.5, 0.5, 0.5, 1);
	tex:SetDrawLayer("ARTWORK", 1);	
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetDisabledTexture(tex);

	-- Highlight Texture IS NOT OWNED by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.2);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetHighlightTexture(tex);
	btn.texHlt = tex;

	-- Pushed Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0.4);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetPushedTexture(tex);

	-- Fonts
	--btn:SetNormalFontObject(Fonts.Default);
	btn.font = VFLUI.CreateFontString(btn);
	btn.font:SetAllPoints(btn);
	btn.font:Show();
	VFLUI.SetFont(btn.font, Fonts.default);
	
	btn.StartFlash = function()
		btn.elapsed = 0;
		btn:SetScript("OnUpdate", function(self, elapsed)
			self.elapsed = self.elapsed + elapsed
			if self.elapsed > 0.5 then
				if self.hlt then
					self:UnlockHighlight();
					self.hlt = nil;
				else
					self:LockHighlight();
					self.hlt = true;
				end
				self.elapsed = 0;
			end
		end);
	end
	
	btn.StopFlash = function()
		btn:SetScript("OnUpdate", nil);
	end

	btn.Destroy = VFL.hook(function(s)
		s:StopFlash();
		s.StartFlash = nil;
		s.StopFlash = nil;
		VFLUI.ReleaseRegion(s.font);
		s.font = nil;
		VFLUI.ReleaseRegion(s.texBkg);
		s.texBkg = nil;
		VFLUI.ReleaseRegion(s.texHlt);
		s.texHlt = nil;
	end, btn.Destroy);

	return btn;
end

local function NewTabBar(fp, parent, tabHeight, orientation)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent);
	end
	self:SetHeight(tabHeight);

	local tabs, tabWidth = {}, 0;
	
	local scrollable, scrollChild = nil, nil;
	local btnLeft, btnRight = nil, nil;
	
	local TabDragContext = VFLUI.DragContext:new();
	
	local function TabDragStart(btn, txt)
		local proxy = VFLUI.CreateGenericDragProxy(btn, txt);
		TabDragContext:Drag(btn, proxy);
	end
	
	local function TabDropOn(target, proxy, source, context)
		if target == source then
			--RDX.NewLearnWizardName("docking_windows");
		else
			-- récupère l'id de la target cible
			local id = VFL.vfind(tabs, target);
			if id then
				self:MoveTab(source, id)
			end
			--DesktopEvents:Dispatch("WINDOW_DOCK", proxy.data, proxy.point, target.data, target.point, offset);
		end
	end

	-- Rebuild the anchor structure of the tabs
	local function ReanchorTabs()
		local n = table.getn(tabs);
		local t1, par = tabs[1], self;
		if not t1 then return; end
		for _,tab in pairs(tabs) do tab:ClearAllPoints(); end
		if scrollable then
			par = scrollChild;
			t1:SetPoint("TOPLEFT", scrollChild, "TOPLEFT"); t1:SetParent(par);
		else
			t1:SetPoint("TOPLEFT", self, "TOPLEFT"); t1:SetParent(par);
		end
		for i=2,n do
			tabs[i]:SetPoint("TOPLEFT", t1, "TOPRIGHT"); tabs[i]:SetParent(par);
			t1 = tabs[i];
		end
	end

	-- Create scrolling infrastructure.
	local function SetScrollable()
		if scrollable then return; end
		-- Generate the Scrollable
		scrollable = VFLUI.AcquireFrame("ScrollFrame");
		scrollable:SetParent(self);
		scrollable:SetFrameStrata(self:GetFrameStrata()); scrollable:SetFrameLevel(self:GetFrameLevel());
		scrollable:SetPoint("TOPLEFT", self, "TOPLEFT", 16, 0);

		-- Generate the ScrollChild
		scrollChild = VFLUI.AcquireFrame("Frame");
		scrollChild:SetParent(scrollable); 
		scrollChild:Show();

		-- Layout
		scrollChild:SetWidth(tabWidth); scrollChild:SetHeight(tabHeight);
		scrollable:SetWidth(self:GetWidth() - 32); scrollable:SetHeight(tabHeight);
		scrollable:SetScrollChild(scrollChild);
		scrollable:Show();

		-- Generate the left/right scroll buttons
		btnLeft = VFLUI.CreateScrollLeftButton();
		btnLeft:SetParent(scrollable);
		btnLeft:SetWidth(16); btnLeft:SetHeight(tabHeight);
		btnLeft:SetPoint("RIGHT", scrollable, "LEFT"); btnLeft:Show();
		btnLeft:SetScript("OnClick", function()
			local sr, hs = scrollable:GetHorizontalScrollRange(), scrollable:GetHorizontalScroll();
			hs = hs - scrollable:GetWidth();
			if(hs < 0) then hs = 0; end
			scrollable:SetHorizontalScroll(hs);
			PlaySound("UChatScrollButton");
		end);

		btnRight = VFLUI.CreateScrollRightButton();
		btnRight:SetParent(scrollable);
		btnRight:SetWidth(16); btnRight:SetHeight(tabHeight);
		btnRight:SetPoint("LEFT", scrollable, "RIGHT"); btnRight:Show();
		btnRight:SetScript("OnClick", function()
			local sr, hs = scrollable:GetHorizontalScrollRange(), scrollable:GetHorizontalScroll();
			hs = hs + scrollable:GetWidth(); 
			if(hs > sr) then hs = sr; end
			scrollable:SetHorizontalScroll(hs);
			PlaySound("UChatScrollButton");
		end);

		-- Reparent and reanchor the tabs so that they are part of the ScrollChild.
		ReanchorTabs();
	end

	-- Destroy scrolling infrastructure.
	local function UnsetScrollable()
		if not scrollable then return; end
		btnLeft:Destroy(); btnLeft = nil; btnRight:Destroy(); btnRight = nil;
		local ss = scrollable; scrollable = nil;
		ReanchorTabs();
		scrollChild:Destroy(); scrollChild = nil;
		ss:Destroy(); ss = nil;
	end

	-- Update scrolling infrastructure
	local function UpdateScrollable()
		if scrollable then
			if tabWidth < self:GetWidth() then
				UnsetScrollable();
			else
				scrollChild:SetWidth(tabWidth);
				scrollable:UpdateScrollChildRect();
				ReanchorTabs();
			end
		else
			if(tabWidth >= self:GetWidth()) then SetScrollable(); else ReanchorTabs(); end
		end
	end

	--- Select the given tab.
	local curTab = nil;
	function self:SelectTab(tab, a, b, c)
		if curTab == tab then return; end
		if curTab then
			curTab.selected = nil;
			if curTab._tbOnDeselect then curTab:_tbOnDeselect(); end
			curTab:UnlockHighlight();
		end
		curTab = tab;
		if not tab then return; end
		curTab.selected = true;
		if tab._tbOnSelect then tab:_tbOnSelect(a, b, c); end
		tab:StopFlash();
		tab:LockHighlight();
	end
	
	function self:SelectTabName(title, a, b, c)
		local tab = nil;
		for i, v in ipairs(tabs) do
			if v.font:GetText() == title then tab = v; end
		end
		self:SelectTab(tab, a, b, c);
	end
	
	function self:SelectTabId(id, a, b, c)
		if id then
			self:SelectTab(tabs[id], a, b, c);
		end
	end
	
	function self:UnSelectTab()
		if curTab then
			if curTab._tbOnDeselect then curTab:_tbOnDeselect(); end
			curTab:UnlockHighlight();
			curTab = nil;
		end
	end
	
	function self:_GetCurrentTab()
		return curTab;
	end
	
	--- Return tabs list
	function self:_GetTabs()
		return tabs;
	end

	--- Adds a tab to the tab bar. The tab will have the given width.
	function self:AddTab(width, fnSelect, fnDeselect, fnMenu, showOnMouseOver, notSelectable, heightclientoffset)
		local t = nil;
		if orientation == "TOP" then
			t = NewTabButtonTop(self);
		elseif orientation == "BOTTOM" then
			t = NewTabButtonBottom(self);
		end
		t:SetHeight(tabHeight); t:SetWidth(width); t:Show();
		
		local mnu = {};
		
		t._tbOnSelect = fnSelect; t._tbOnDeselect = fnDeselect;
		-- Add clickscript
		t:RegisterForClicks("LeftButtonDown", "RightButtonDown");
		-- drag
		t.OnDrop = TabDropOn;
		TabDragContext:RegisterDragTarget(t);
		
		t:SetScript("OnClick", function(self2, arg1) 
			if(arg1 == "LeftButton") then
				if not notSelectable then
					self:SelectTab(self2);
				end
				TabDragStart(self2, self2.font:GetText());
			else
				VFL.empty(mnu);
				if fnMenu then fnMenu(mnu, t); end
				if #mnu > 0 then
					VFL.poptree:Begin(240, 12, t, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(t));
					VFL.poptree:Expand(nil, mnu);
				end
			end;
		end);
		if showOnMouseOver then
			t:SetScript("OnEnter", function(self2, arg1) 
				t:SetAlpha(1);
			end);
			t:SetScript("OnLeave", function(self2, arg1) 
				t:SetAlpha(0.5);
			end);
			t:SetAlpha(0.5);
		end
		-- add heightclientoffset
		if not heightclientoffset then heightclientoffset = 0; end
		t._heightclientoffset = heightclientoffset;
		t.Destroy = VFL.hook(function(s)
			t._tbOnSelect = nil; t._tbOnDeselect = nil; t._heightclientoffset = nil;
		end, t.Destroy);
		-- Add to data structures
		tabWidth = tabWidth + width;
		table.insert(tabs, t);
		-- If the newly added tab caused width to exceed proportion, make us scrollable
		UpdateScrollable();
		self:SelectTab(t);
		return t;
	end

	--- Removes a tab previously added by AddTab.
	function self:RemoveTab(x)
		local rt = VFL.vremove(tabs, x);
		if rt then
			if rt == curTab then self:SelectTab(nil); end
			tabWidth = tabWidth - rt:GetWidth();
			UpdateScrollable();
			rt:Destroy();
		end
	end
	
	--- Move a tab to a new point.
	function self:MoveTab(x, i)
		local t = VFL.vremove(tabs, x);
		if t then
			table.insert(tabs, i, t);
			ReanchorTabs();
			UpdateScrollable();
		end
		if self.OnTabMoved then self:OnTabMoved(); end
	end
	
	--- Change look and feel
	function self:SetBackdropTab(desc)
		for i, v in ipairs(tabs) do
			VFLUI.SetBackdrop(v, desc);
		end
	end
	
	function self:SetFontTab(desc)
		for i, v in ipairs(tabs) do
			VFLUI.SetFont(v.font, desc);
		end
	end

	local function OnResize()
		if(tabWidth >= self:GetWidth()) then SetScrollable(); else UnsetScrollable(); end
		if scrollable then
			scrollable:SetWidth(self:GetWidth() - 32);
		end
	end

	self:SetScript("OnSizeChanged", OnResize);
	self:SetScript("OnShow", OnResize);

	-- Destructor
	self.Destroy = VFL.hook(function(s)
		for k,tab in pairs(tabs) do tab.selected = nil; tab.OnDrop = nil; TabDragContext:UnregisterDragTarget(x); tab:Destroy(); tabs[k] = nil; end
		TabDragContext = nil;
		UnsetScrollable();
		tabs = nil; tabWidth = nil;
		self.SetBackdropTab = nil; self.SetFontTab = nil;
		self.SelectTabName = nil; self.SelectTabId = nil; self.UnSelectTab = nil; self._GetCurrentTab = nil;
		self.MoveTab = nil; self.RemoveTab = nil; self.AddTab = nil; self.SelectTab = nil; self._GetTabs = nil;
	end, self.Destroy);

	return self;
end

VFLUI.TabBar = {};
VFLUI.TabBar.new = NewTabBar;

function tabbar1()
	theBar = VFLUI.TabBar:new(VFLFULLSCREEN, 24, "BOTTOM");
	theBar:SetPoint("CENTER", VFLParent, "CENTER");
	theBar:SetWidth(250); theBar:Show();
end

local tix = 1;
function tabbar2()
	if not theBar then return; end
	local tx = theBar:AddTab(100);
	tx:SetText(tix); tix = tix + 1;
end
