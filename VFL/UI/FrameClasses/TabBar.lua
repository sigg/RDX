-- TabBar.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A tab bar is a scrollable row of clickable buttons that are usually used
-- to perform manipulations on an underlying window.

local topTabBackdrop = {
	edgeFile="Interface\\Addons\\VFL\\Skin\\tab_top", edgeSize = 16,
	insets = { left = 5, right = 5, top = 4, bottom = 0 }
};

local bottomTabBackdrop = {
	edgeFile="Interface\\Addons\\VFL\\Skin\\tab_bottom", edgeSize = 16,
	insets = { left = 5, right = 5, top = 4, bottom = 5 }
};

local function NewTabButtonTop()
	local btn = VFLUI.AcquireFrame("Button");
	btn:SetBackdrop(topTabBackdrop);

	-- Textures
	local tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.1);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 0);
	tex:Show();
	btn.texBkg = tex;

	-- Normal Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 0);
	tex:Show();
	btn:SetNormalTexture(tex);

	-- Disabled Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(0.5, 0.5, 0.5, 1);
	tex:SetDrawLayer("ARTWORK", 2);	
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 0);
	tex:Show();
	btn:SetDisabledTexture(tex);

	-- Highlight Texture IS NOT OWNED by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.2);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 0);
	tex:Show();
	btn:SetHighlightTexture(tex);
	btn.texHlt = tex;

	-- Pushed Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0.4);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 0);
	tex:Show();
	btn:SetPushedTexture(tex);

	-- Fonts
	btn:SetNormalFontObject(Fonts.Default);

	btn.Destroy = VFL.hook(function(s)
		VFLUI.ReleaseRegion(s.texBkg);
		s.texBkg = nil;
		VFLUI.ReleaseRegion(s.texHlt);
		s.texHlt = nil;
	end, btn.Destroy);

	return btn;
end

local function NewTabButtonBottom()
	local btn = VFLUI.AcquireFrame("Button");
	btn:SetBackdrop(bottomTabBackdrop);

	-- Textures
	local tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.1);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, 0);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn.texBkg = tex;

	-- Normal Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, 0);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetNormalTexture(tex);

	-- Disabled Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(0.5, 0.5, 0.5, 1);
	tex:SetDrawLayer("ARTWORK", 1);	
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, 0);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetDisabledTexture(tex);

	-- Highlight Texture IS NOT OWNED by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.2);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 5, 0);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -5, 4);
	tex:Show();
	btn:SetHighlightTexture(tex);
	btn.texHlt = tex;

	-- Pushed Texture is owned by the button
	tex = btn:CreateTexture();
	tex:SetTexture(1, 1, 1, 0.4);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 5, 0);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -5, 4);
	tex:Show();
	btn:SetPushedTexture(tex);

	-- Fonts
	btn:SetNormalFontObject(Fonts.Default);

	btn.Destroy = VFL.hook(function(s)
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
	function self:SelectTab(tab)
		if curTab == tab then return; end
		if curTab then
			if curTab._tbOnDeselect then curTab:_tbOnDeselect(); end
			curTab:UnlockHighlight();
		end
		curTab = tab;
		if not tab then return; end
		if tab._tbOnSelect then tab:_tbOnSelect(); end
		tab:LockHighlight();
	end
	
	function self:SelectTabName(title)
		local tab = nil;
		for i, v in ipairs(tabs) do
			if v:GetText() == title then tab = v; end
		end
		self:SelectTab(tab);
	end

	--- Adds a tab to the tab bar. The tab will have the given width.
	function self:AddTab(width, fnSelect, fnDeselect)
		local t = nil;
		if orientation == "TOP" then
			t = NewTabButtonTop();
		elseif orientation == "BOTTOM" then
			t = NewTabButtonBottom();
		end
		t:SetHeight(tabHeight); t:SetWidth(width); t:Show();
		-- Add clickscript
		t:SetScript("OnClick", function(self2) self:SelectTab(self2); end);
		t._tbOnSelect = fnSelect; t._tbOnDeselect = fnDeselect;
		t.Destroy = VFL.hook(function(s)
			t._tbOnSelect = nil; t._tbOnDeselect = nil;
		end, t.Destroy);
		-- Add to data structures
		tabWidth = tabWidth + width;
		table.insert(tabs, t);
		-- If the newly added tab caused width to exceed proportion, make us scrollable
		UpdateScrollable();
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
		for k,tab in pairs(tabs) do tab:Destroy(); tabs[k] = nil; end
		UnsetScrollable();
		tabs = nil; tabWidth = nil;
		self.SelectTabName = nil;
		self.RemoveTab = nil; self.AddTab = nil; self.SelectTab = nil;
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
