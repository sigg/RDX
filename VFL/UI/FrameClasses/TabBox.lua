-- TabBox.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A TabBox is a client area frame together with an attached TabBar. When a tab on the TabBar is clicked,
-- typically the client is populated with a different frame depend on which tab was clicked. Procedures
-- to easily enable this are provided.

local function NewTabBox(fp, parent, tabHeight, orientation, offsetx, offsety)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent); self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	VFLUI.SetBackdrop(self, VFLUI.DefaultDialogBackdrop)
	
	local tabBar = VFLUI.TabBar:new(self, tabHeight, orientation);
	if orientation == "TOP" then
		tabBar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -2);
	elseif orientation == "BOTTOM" then
		tabBar:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 2);
	end
	tabBar:Show();

	--- Get the TabBar for this TabBox.
	function self:GetTabBar() return tabBar; end

	local curClient = nil;
	if not offsetx then offsetx = 0; end
	if not offsety then offsety = 0; end

	--- Set the client frame for this window.
	function self:SetClient(cli)
		if curClient == cli then return; end
		if curClient then curClient:Hide(); end
		curClient = cli;
		if not cli then return; end
		cli:SetParent(self);	cli:ClearAllPoints();
		if orientation == "TOP" then
			cli:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -tabHeight-offsety);
		elseif orientation == "BOTTOM" then
			cli:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, tabHeight+offsety);
		end
		local tab = tabBar:_GetCurrentTab();
		cli:SetWidth(self:GetWidth() - 2*offsetx);
		cli:SetHeight(self:GetHeight() - tabHeight - 3*offsety + tab._heightclientoffset);
		cli:Show();
	end

	--- Generate the AddTab() functions for the given client.
	function self:GenerateTabFuncs(cli)
		return function() self:SetClient(cli); end;
	end

	-- Resize/show handling
	local function OnResize()
		tabBar:SetWidth(self:GetWidth());
		if curClient then 
			local tab = tabBar:_GetCurrentTab();
			curClient:SetWidth(math.max(self:GetWidth() - 2*offsetx, 0));
			curClient:SetHeight(math.max(0, self:GetHeight() - tabHeight - 3*offsety + tab._heightclientoffset));
		end
	end 
	self:SetScript("OnSizeChanged", OnResize);
	self:SetScript("OnShow", OnResize);
	
	-- Destructor
	self.Destroy = VFL.hook(function(s)
		if curClient then curClient:Hide(); curClient = nil; end
		tabBar:Destroy(); tabBar = nil;
		self.SetClient = nil; self.GenerateTabFuncs = nil; self.GetTabBar = nil;
	end, self.Destroy);

	return self;
end

VFLUI.TabBox = {};
VFLUI.TabBox.new = NewTabBox;

function tabbox()
	theBox = VFLUI.TabBox:new(VFLFULLSCREEN, 22, "BOTTOM");
	theBox:SetHeight(250); theBox:SetWidth(300);
	theBox:SetPoint("CENTER", VFLParent, "CENTER");
	local cli = nil;
	for i=1,10 do
		cli = VFLUI.Button:new(); cli:SetText("cli " .. i); cli:Hide();
		local tab = theBox:GetTabBar():AddTab(50, theBox:GenerateTabFuncs(cli));
		tab.font:SetText(i);
	end
end
