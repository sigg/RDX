-- Window.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A Window is a frame with a title bar and various other decorations.

--------------------------------------------------------------------------------
-- ABSTRACT WINDOW
-- The base class for windows, providing the basic methods all windows must support.
--------------------------------------------------------------------------------
VFLUI.AbstractWindow = {};
local function AW_GetClient(self) return self.clientArea; end
local function AW_GetTitle(self) return self.titleArea; end
local function AW_AddButton(self, btn)
	if not btn then return; end
	btn:SetParent(self); btn:SetFrameLevel(self:GetFrameLevel() + 2);
	btn:ClearAllPoints();
	table.insert(self.ctlButtons, btn);
	self:_FrameLayout(); self:_FrameResize();
end
local function AW_OnLayout(self)
	self:_FrameResize();
end

local function AW_HideTitle(self) 
	--self.bh = self.titleArea:GetHeight();
	--self.titleArea:SetHeight(0);
	--self:_FrameResize();
end

local function AW_ShowTitle(self) 
	--self.titleArea:SetHeight(self.bh);
	--self.bh = nil;
	--self:_FrameResize();
end

local function AW_IsHiddenTitle(self)
	return self.bh;
end

local function AW_HideClient(self)
	self.ch = true; --self.clientArea:GetHeight();
	self.clientArea:Hide();
	--self:_FrameResize();
end

local function AW_ShowClient(self) 
	self.clientArea:Show();
	self.ch = nil;
	--self:_FrameResize();
end

local function AW_IsHiddenClient(self)
	return self.ch;
end

local function AW_TearDown(self)
	-- Instruct the framing to destroy itself
	self:_FrameDestroy();
	-- Destroy all control buttons
	for _,btn in pairs(self.ctlButtons) do btn:Destroy(); end
	VFL.empty(self.ctlButtons);
	-- Quash the title area
	self.titleArea:ClearAllPoints(); self.titleArea:SetWidth(0); self.titleArea:SetHeight(0);
	-- Bring the API back to where we want it
	self.GetTitleBar = AW_GetTitle;	self.SetText = VFL.Noop; self.SetTitleColor = VFL.Noop; self.SetPerfText = VFL.Noop; self.AddButton = AW_AddButton;
	self.HideTitleBar = AW_HideTitle; self.ShowTitleBar = AW_ShowTitle; self.IsHiddenTitleBar = AW_IsHiddenTitle;
	self.bh = nil;
	self.GetClientArea = AW_GetClient;
	self.HideClientArea = AW_HideClient; self.ShowClientArea = AW_ShowClient; self.IsHiddenClientArea = AW_IsHiddenClient;
	self.ch = nil;
	self._FrameLayout = VFL.Noop; self._FrameResize = VFL.Noop; self._FrameDestroy = VFL.Noop;
	self:SetScript("OnShow", AW_OnLayout);
	self:SetScript("OnSizeChanged", AW_OnLayout);
end

function VFLUI.AbstractWindow:new(parent)
	local self = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(self, parent or VFLDIALOG, 5);

	----------------------------------------- CONCRETE ELEMENTS
	-- Every window has a title bar. (GetTitleBar/SetText/SetTitleColor methods)
	local titleBar = VFLUI.AcquireFrame("Button");
	titleBar:SetParent(self); titleBar:SetFrameLevel(self:GetFrameLevel() + 1);
	self.titleArea = titleBar;
	self.GetTitleBar = AW_GetTitle;
	self.SetText = VFL.Noop;
	self.SetTitleColor = VFL.Noop;
	self.HideTitleBar = AW_HideTitle; 
	self.ShowTitleBar = AW_ShowTitle;
	self.IsHiddenTitleBar = AW_IsHiddenTitle;
	self.HideClientArea = AW_HideClient; 
	self.ShowClientArea = AW_ShowClient;
	self.IsHiddenClientArea = AW_IsHiddenClient;
	self.SetPerfText = VFL.Noop;

	-- Every window has a client area, although AbstractWindows don't supply this;
	-- the concrete instances must. (GetClientArea method)
	self.GetClientArea = AW_GetClient;

	-- Every window has a control button list. (AddButton method)
	self.ctlButtons = {};
	self.AddButton = AW_AddButton;

	----------------------------------------- ABSTRACT ELEMENTS
	-- Every window has a _FrameLayout method that is responsible for reanchoring things
	-- like titlebars/buttons etc.
	self._FrameLayout = VFL.Noop;
	-- Every window has a _FrameResize method that receives notification when its size changes
	self._FrameResize = VFL.Noop;
	-- Every window has a _FrameDestroy method that indicates that subframes should clean
	-- themselves up.
	self._FrameDestroy = VFL.Noop;

	----------------------------------------- SCRIPTS
	self:SetScript("OnShow", AW_OnLayout);
	self:SetScript("OnSizeChanged", AW_OnLayout);

	----------------------------------------- DESTRUCTORS
	self.TearDown = AW_TearDown;

	self.Destroy = VFL.hook(function(s)
		-- Instruct the framing to destroy itself
		self:_FrameDestroy();
		-- Destroy all control buttons
		for _,btn in pairs(self.ctlButtons) do btn:Destroy(); end
	 	s.ctlButtons = nil;
		-- Destroy title area.
		s.titleArea:Destroy(); s.titleArea = nil;
		-- Remove API
		s.GetTitleBar = nil; s.SetText = nil; s.SetTitleColor = nil; s.SetPerfText = nil;
		s.HideTitleBar = nil; s.ShowTitleBar = nil; s.IsHiddenTitleBar = nil; s.bh = nil;
		s.GetClientArea = nil; s.AddButton = nil;
		s.HideClientArea = nil; s.ShowClientArea = nil; s.IsHiddenClientArea = nil; s.ch = nil;
		s._FrameLayout = nil; s._FrameResize = nil; s._FrameDestroy = nil;
		s.TearDown = nil;
	end, self.Destroy);
	
	return self;
end

------------------------------------------------------------------------------------
-- CONCRETE DOWNWARD-DRIVEN WINDOW
-- A window with a predefined, fixed client frame that is driven from the top down.
-------------------------------------------------------------------------------------
VFLUI.Window = {};
local function W_Accomodate(self, dx, dy)
	self:SetWidth(dx); self:SetHeight(dy);
	self.clientArea:SetWidth(dx); self.clientArea:SetWidth(dy);
end

local function W_SetFraming(self, framingFunctor, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	local caw, cah = self:GetClientArea():GetWidth(), self:GetClientArea():GetHeight();
	self:TearDown();
	framingFunctor(self, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
end

function VFLUI.Window:new(parent)
	local self = VFLUI.AbstractWindow:new(parent);

	--------------------------------- CLIENT AREA
	-- For a downward-driven window, the CA is just a frame which by default is
	-- superposed directly over the window itself.
	local clientArea = VFLUI.AcquireFrame("Frame");
	clientArea:SetParent(self); clientArea:SetFrameLevel(self:GetFrameLevel() + 1);
	clientArea:Show(); clientArea:SetPoint("TOPLEFT", self, "TOPLEFT");
	self.clientArea = clientArea;

	-- The "accomodate" function resizes the window to accomodate a client of the given size.
	-- Should be overridden by framing.
	self.Accomodate = W_Accomodate;

	-- Set framing function
	self.SetFraming = W_SetFraming;

	-------------------------------- DESTRUCTORS
	self.TearDown = VFL.hook(self.TearDown, function(s)
		s.clientArea:ClearAllPoints(); s.clientArea:SetPoint("TOPLEFT", s, "TOPLEFT");
		s.Accomodate = W_Accomodate;
	end);

	self.Destroy = VFL.hook(function(s)
		s.clientArea:Destroy(); s.clientArea = nil;
		s.Accomodate = nil; s.SetFraming = nil;
	end, self.Destroy);

	return self;
end

-------------------------------------------------------------------------------
-- INVERTED-CONTROL WINDOW
-- Create an "inverted-control" window. An inverted control window is a window 
-- whose decor is anchored to the clientArea via anchors. An inverted control
-- window cannot be manipulated using SetPoint/SetWidth/SetHeight.
--
-- The inverted-control window has a user-provided client. The client must be a
-- proper VFL frame with :Destroy() method. When a new client is attached, any
-- old client is automatically destroyed.
-------------------------------------------------------------------------------
VFLUI.InvertedControlWindow = {};
local function ICW_ApplyClientSettings(self, client)
	if not client then return; end
	self:_ClearAllPoints();
	self:_SetPoint("TOPLEFT", client, "TOPLEFT", -self.insetLeft, self.insetTop);
	self:_SetPoint("BOTTOMRIGHT", client, "BOTTOMRIGHT", self.insetRight, -self.insetBottom);
	VFLT.NextFrame(math.random(10000000), function() if self and self._FrameResize then self:_FrameResize(); end; end);
end

local function ICW_SetClient(self, client)
	self.clientArea = nil;
	if not client then
		self:_ClearAllPoints();
		--self:Hide(); 
		self:SetParent(nil);
		return;
	end
	self.clientArea = client;
	client:SetParent(self._parent);
	client:SetFrameLevel(math.max(client:GetFrameLevel(), 3));
	self:SetParent(client);
	self:SetFrameLevel(client:GetFrameLevel() - 1);
	client:Show(); 
	--self:Show();
	self:_FrameLayout(); -- Restore subframe lineage settings.
	ICW_ApplyClientSettings(self, self.clientArea);
end

local function ICW_SetInsets(self, l, t, r, b)
	if (not l) or (not t) or (not r) or (not b) then
		error("Usage: SetInsets(left, top, right, bottom)");
	end
	self.insetLeft = l; self.insetTop = t; self.insetRight = r; self.insetBottom = b;
	ICW_ApplyClientSettings(self, self.clientArea);
end

local function ICW_InvalidOpError()
	error("The operations :SetPoint(), :ClearAllPoints(), :SetWidth(), :SetHeight() are illegal on an inverted-control window.");
end

local function ICW_SetFraming(self, framingFunctor, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	self:TearDown();
	framingFunctor(self, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
end

local function ICW_BaseGetDockPoint(self, point)
	if point == "TOPLEFT" then
		return "TOPLEFT", -self.insetLeft, self.insetTop;
	elseif point == "TOP" then
		return "TOP", 0, self.insetTop;
	elseif point == "TOPRIGHT" then
		return "TOPRIGHT", self.insetRight, self.insetTop;
	elseif point == "RIGHT" then
		return "RIGHT", self.insetRight, 0;
	elseif point == "BOTTOMRIGHT" then
		return "BOTTOMRIGHT", self.insetRight, -self.insetBottom;
	elseif point == "BOTTOM" then
		return "BOTTOM", 0, -self.insetBottom;
	elseif point == "BOTTOMLEFT" then
		return "BOTTOMLEFT", -self.insetLeft, -self.insetBottom;
	elseif point == "LEFT" then
		return "LEFT", -self.insetLeft, 0;
	elseif point == "CENTER" then
		return "CENTER", 0, 0;
	else
		error("Invalid frame point");
	end
end

local function ICW_GetDockTargetPoint(self, point)
	local p,dx,dy = ICW_BaseGetDockPoint(self, point);
	return p,dx,dy;
end

local function ICW_GetDockSourcePoint(self, point)
	local p,dx,dy = ICW_BaseGetDockPoint(self, point);
	return p,-dx,-dy;
end

local function ICW_GetDockBoundary(self)
	return VFLUI.GetUniversalBoundary(self);
end

local function ICW_SetScale(self, scale)
	if not self.clientArea then return; end
	self.clientArea:SetScale(scale);
end

local function ICW_SetAlpha(self, alpha)
	if not self.clientArea then return; end
	self.clientArea:SetAlpha(alpha);
end

function VFLUI.InvertedControlWindow:new(parent)
	local self = VFLUI.AbstractWindow:new();
	self._parent = parent;

	----------------------------- API
	self._SetPoint = self.SetPoint; self._ClearAllPoints = self.ClearAllPoints;
	self.SetPoint = ICW_InvalidOpError; self.ClearAllPoints = ICW_InvalidOpError;
	self.SetWidth = ICW_InvalidOpError; self.SetHeight = ICW_InvalidOpError;
	self.SetScale = ICW_SetScale; self.SetAlpha = ICW_SetAlpha;

	----------------------------- CLIENT AREA
	self.insetLeft = 0; self.insetTop = 0; self.insetRight = 0; self.insetBottom = 0;
	self.SetClient = ICW_SetClient;
	self.SetInsets = ICW_SetInsets;
	self.SetFraming = ICW_SetFraming;

	----------------------------- RDX WM
	-- These methods provide information to the RDX window manager about how to properly
	-- handle an IC window.
	self.WMGetPositionalFrame = AW_GetClient;
	self.WMGetDockTargetPoint = ICW_GetDockTargetPoint;
	self.WMGetDockSourcePoint = ICW_GetDockSourcePoint;
	self.WMGetDockBoundary = ICW_GetDockBoundary;

	----------------------------- DESTRUCTORS
	self.TearDown = VFL.hook(function(s)
		s:SetClient(nil);
	end, self.TearDown);
	
	self.Destroy = VFL.hook(function(s)
		s:SetClient(nil); s._parent = nil;

		s._SetPoint = nil; s._ClearAllPoints = nil;
		s.SetPoint = nil; s.ClearAllPoints = nil;
		s.SetWidth = nil; s.SetHeight = nil;
		s.SetScale = nil; s.SetAlpha = nil;

		s.SetClient = nil; s.SetInsets = nil;
		s.SetFraming = nil; 

		s.WMGetPositionalFrame = nil; s.WMGetDockTargetPoint = nil;
		s.WMGetDockSourcePoint = nil; s.WMGetDockBoundary = nil;
	end, self.Destroy);

	return self;
end

-------------------------------------------------------------------------------
-- HELPER FUNCTIONS
-------------------------------------------------------------------------------

local wm_entries = {};
local function WindowMenu(win)
	if type(win._WindowMenu) == "function" then
		VFL.empty(wm_entries);
		win:_WindowMenu(wm_entries);
		VFL.poptree:Begin(120, 12, win, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(win));
		VFL.poptree:Expand(nil, wm_entries);
	end
end

--- Imbue the given window with a basic movement paradigm.
function VFLUI.Window.StdMove(win, handle)
	win:SetMovable(true);
	handle:SetScript("OnMouseDown", function(self, arg1)
		if(arg1 == "LeftButton") then
			win:StartMoving();
		end
	end);
	handle:SetScript("OnMouseUp", function(self, arg1) 
		win:StopMovingOrSizing();
		if(arg1 == "RightButton") then WindowMenu(win); end
	end);
end

function VFLUI.Window.StdMoveICW(win, handle)
	win:GetClientArea():SetMovable(true);
	handle:SetScript("OnMouseDown", function(self, arg1)
		if(arg1 == "LeftButton") and IsShiftKeyDown() then
			win:GetClientArea():StartMoving();
		end
	end);
	handle:SetScript("OnMouseUp", function(self, arg1) 
		win:GetClientArea():StopMovingOrSizing();
		if(arg1 == "RightButton") then WindowMenu(win); end
	end);
end

--- "Right-anchor" the buttons of a window to the given point on the window itself.
-- Set their height/widths in the process.
function VFLUI.Window.RightButtonStrip(win, sz, af, point, ofsX, ofsY)
	local cb = win.ctlButtons; if not cb then return; end
	local i = 1;
	while cb[i+1] do
		cb[i]:SetFrameLevel(win:GetFrameLevel() + 1);
		cb[i]:SetWidth(sz); cb[i]:SetHeight(sz); cb[i]:Show();
		cb[i]:ClearAllPoints(); cb[i]:SetPoint("RIGHT", cb[i+1], "LEFT", 0, 0);
		i=i+1;
	end
	-- Anchor the last button
	if cb[i] then
		cb[i]:SetFrameLevel(win:GetFrameLevel() + 1);
		cb[i]:SetWidth(sz); cb[i]:SetHeight(sz); cb[i]:Show();
		cb[i]:ClearAllPoints();
		cb[i]:SetPoint("RIGHT", af, point, ofsX, ofsY);
	end
end

--- "Left-anchor" the buttons of a window to the given point on the window itself.
-- Set their height/widths in the process.
function VFLUI.Window.RightInverseButtonStrip(win, sz, af, point, ofsX, ofsY)
	local cb = win.ctlButtons; if not cb then return; end
	local i = 1;
	if cb[i] then
		cb[i]:SetFrameLevel(win:GetFrameLevel() + 1);
		cb[i]:SetWidth(sz); cb[i]:SetHeight(sz); cb[i]:Show();
		cb[i]:ClearAllPoints();
		cb[i]:SetPoint("LEFT", af, point, ofsX, ofsY);
	end
	i = i + 1;
	while cb[i] do
		cb[i]:SetFrameLevel(win:GetFrameLevel() + 1);
		cb[i]:SetWidth(sz); cb[i]:SetHeight(sz); cb[i]:Show();
		cb[i]:ClearAllPoints(); cb[i]:SetPoint("RIGHT", cb[i-1], "LEFT", 0, 0);
		i=i+1;
	end
end

