-- Frame.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- Aggregate frame types supporting VFL layout primitives.

--- class VFLUI.PassthroughFrame
-- A passthrough config frame simply passes on its requests to its subobject.
-- Passthroughs can be used as decoration or for other functionality-inert
-- purposes.
--
-- Passthroughs are automatically anchored to their children, with the given
-- offsets.
VFLUI.PassthroughFrame = {};
function VFLUI.PassthroughFrame:new(f, parent)
	local self = f or VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent);
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	
	local collapsed = nil;
	local child = nil;
	local dxLeft, dyTop, dxRight, dyBottom = 0, 0, 0, 0;

	self.DialogOnLayout = function(s)
		if child then
			if collapsed then
				child:Hide();
				s:SetHeight(dyTop + dyBottom);
			else
				-- Downward layout constraint on width
				child:Show();
				child:SetWidth(self:GetWidth() - dxLeft - dxRight);
				if child.DialogOnLayout then child:DialogOnLayout(); end
				-- Upward layout constraint on height
				self:SetHeight(child:GetHeight() + dyTop + dyBottom);
			end
		else
			s:SetHeight(dyTop + dyBottom);
		end
	end

	self.SetInsets = function(s, dxL, dyT, dxR, dyB)
		if dxL then dxLeft = dxL; end
		if dyT then dyTop = dyT; end
		if dxR then dxRight = dxR; end
		if dyB then dyBottom = dyB; end
	end

	self.SetChild = function(s, ch, dxL, dyT, dxR, dyB)
		if (not ch) or (child) then return; end
		s:SetInsets(dxL, dyT, dxR, dyB);

		-- Setup child
		child = ch;
		child:SetParent(s); child:SetScale(1);
		child:SetPoint("TOPLEFT", s, "TOPLEFT", dxLeft, -dyTop);
	end

	self.SetCollapsed = function(s, coll)
		if coll then
			if collapsed then return; end
			collapsed = true; child:Hide(); s:SetHeight(dyTop + dyBottom);
		else
			if not collapsed then return; end
			collapsed = nil; child:Show(); s:SetHeight(child:GetHeight() + dyTop + dyBottom);
		end
		VFLUI.UpdateDialogLayout(s);
	end

	self.ToggleCollapsed = function(s)
		s:SetCollapsed(not collapsed);
	end

	self.IsCollapsed = function() return collapsed; end

	-- Hook the destroy function to cleanup what we did.
	self.Destroy = VFL.hook(function(s)
		-- Destroy child
		if child then child:Destroy(); child = nil; end
		-- Remove closures
		s.SetChild = nil; s.SetInsets = nil;
		s.DialogOnLayout = nil; s.SetCollapsed = nil; s.ToggleCollapsed = nil; s.IsCollapsed = nil;
	end, self.Destroy);

	return self;
end

--- class VFLUI.CollapsibleFrame
-- A collapsible frame is a PassthroughFrame augmented with a button to control its collapse and
-- expansion, and a FontString to describe its contents.
VFLUI.CollapsibleFrame = {};
function VFLUI.CollapsibleFrame:new(parent)
	local self = VFLUI.PassthroughFrame:new(nil, parent);

	-- Background
	self:SetBackdrop(VFLUI.DefaultDialogBackdrop);

	-- Create the textbox and button
	local ctl = VFLUI.Button:new(self);
	ctl:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	ctl:SetWidth(25); ctl:SetHeight(25); ctl:Show();
	ctl:SetText("+");
	ctl:SetScript("OnClick", function(self)
		local p = self:GetParent();
		if p and p.ToggleCollapsed then p:ToggleCollapsed(); end
	end);
	self.btn = ctl;

	local fs = VFLUI.CreateFontString(self);
	fs:SetPoint("LEFT", ctl, "RIGHT"); 
	VFLUI.SetFont(fs, Fonts.Default);
	fs:SetJustifyH("LEFT");
	fs:SetHeight(25); fs:SetWidth(0); fs:Show();
	self.text = fs;

	-- Hook necessary functions
	local oldDialogOnLayout = self.DialogOnLayout;
	self.DialogOnLayout = function(s)
		oldDialogOnLayout(s);
		s.text:SetWidth(math.max(s:GetWidth() - 25, 0));
	end

	local oldSetCollapsed = self.SetCollapsed;
	self.SetCollapsed = function(s2, coll)
		oldSetCollapsed(s2, coll);
		if coll then s2.btn:SetText("+"); else s2.btn:SetText("-"); end
	end

	local oldSetChild = self.SetChild;
	self.SetChild = function(s, child, isCollapsed)
		oldSetChild(s, child, 5, 30, 5, 5);
		s:SetCollapsed(isCollapsed);
	end

	self.SetText = function(s, txt) s.text:SetText(txt); end

	self.Destroy = VFL.hook(function(s)
		s.btn:Destroy(); s.btn = nil;
		VFLUI.ReleaseRegion(s.text); s.text = nil;
		s.SetText = nil;
	end, self.Destroy);
	
	return self;
end


--- class VFLUI.CompoundFrame
-- A compound config frame is a grid of config frames. Any invocation of a config method on
-- a compound config frame is automatically passed on to all of its children.
VFLUI.CompoundFrame = {};
function VFLUI.CompoundFrame:new(parent)
	local self = VFLUI.Grid:new(parent);
	self:Size(1,0);

	-- Ensure that frames added to this grid will be properly destroyed.
	self.OnOrient = function(grid, cell)
		cell:SetParent(grid); cell:SetScale(1);
--		cell:SetFrameStrata(grid:GetFrameStrata());
--		cell:SetFrameLevel(grid:GetFrameLevel() + 1);
		cell.OnDeparent = cell.Destroy;
	end

	self.DialogOnLayout = function(s)
		for _,c in s:StatelessIterator() do
			if c.DialogOnLayout then c:DialogOnLayout(); end
		end
		-- Upward constraint: relayout the grid based on the cells
		s:Relayout();
	end
	
	-- Destroy cleans up what we did and destroys all children
	self.Destroy = VFL.hook(function(s)
		s.DialogOnLayout = nil;
	end, self.Destroy);

	return self;
end

--- Scrolling Compound Frame
-- It's very common to stick a CompoundFrame into a ScrollFrame, so let's abstract that.
function VFLUI.CreateScrollingCompoundFrame(parent)
	local sf = VFLUI.VScrollFrame:new(parent);
	local ui = VFLUI.CompoundFrame:new(sf);
	ui.isLayoutRoot = true;
	sf:SetScrollChild(ui);

	return ui, sf;
end
function VFLUI.ActivateScrollingCompoundFrame(ui, sf)
	ui:SetWidth(sf:GetWidth());
	sf:Show(); ui:Show();
	VFLUI.UpdateDialogLayout(ui);
end

function VFLUI.DestroyScrollingCompoundFrame(ui, sf)
	sf:SetScrollChild(nil);
	ui:Destroy(); 
	sf:Destroy();
end

--- class VFLUI.Separator
-- A separator bar for compound UIs.
VFLUI.Separator = {};
function VFLUI.Separator:new(parent, str, objHeight, fontHeight)
	if type(objHeight) ~= "number" then objHeight = 16; end
	if type(fontHeight) ~= "number" then fontHeight = 12; end
	objHeight = VFL.clamp(objHeight, 2, 10000);
	fontHeight = VFL.clamp(fontHeight, 1, objHeight);

	local f = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(f, parent);
	f:SetHeight(objHeight); f:Show();

	local txt = VFLUI.CreateFontString(f);
	VFLUI.SetFont(txt, Fonts.Default, fontHeight);
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("CENTER");
	txt:SetPoint("LEFT", f, "LEFT", 5, 0); txt:Show();
	txt:SetTextColor(0.85, 0.8, 0);
	txt:SetHeight(fontHeight);
	if type(str) == "string" then txt:SetText(str); end

	local tex = VFLUI.CreateTexture(f);
	tex:SetAllPoints(f); tex:Show();
	tex:SetTexture(0,0,0.6); tex:SetGradient("HORIZONTAL", 1,1,1,0.1,0.1,0.1);

	local function Layout()
		txt:SetWidth(VFL.clamp(f:GetWidth() - 10, 0.1, 10000));
	end
	f.DialogOnLayout = Layout;

	function f:GetFontString() return txt; end
	function f:GetBackground() return tex; end

	f.Destroy = VFL.hook(function(s)
		VFLUI.ReleaseRegion(tex); tex = nil;
		VFLUI.ReleaseRegion(txt); txt = nil;
		s.GetFontString = nil; s.GetBackground = nil;
	end, f.Destroy);
	return f;
end

VFLUI.EmptySeparator = {};
function VFLUI.EmptySeparator:new(parent, objHeight)
	if type(objHeight) ~= "number" then objHeight = 16; end
	objHeight = VFL.clamp(objHeight, 2, 10000);

	local f = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(f, parent);
	f:SetHeight(objHeight); f:Show();

	return f;
end

--------------- Dialog box helpers
-- A dialog control for filter entries.
VFLUI.FilterDialogFrame = {};
function VFLUI.FilterDialogFrame:new(parent)
	local self = VFLUI.PassthroughFrame:new(nil, parent);
	self:SetBackdrop(VFLUI.DefaultDialogBorder);
	self:SetInsets(5, 17, 5, 5);

	local btn = VFLUI.CloseButton:new(self, 12);
	btn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -5, -5);
	btn:Hide();

	local label = VFLUI.CreateFontString(self);
	label:SetHeight(12); label:SetWidth(50);
	label:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	label:SetFontObject(Fonts.Default10); label:SetJustifyH("LEFT");
	label:Show();

	local oldSetChild = self.SetChild;
	self.SetChild = function(s, child)
		oldSetChild(s, child);
		s:SetCollapsed(nil);
	end

	self.DialogOnLayout = VFL.hook(function(s)
		label:SetWidth(math.max(s:GetWidth() - 25, 0));
	end, self.DialogOnLayout);

	self.EnableCloseButton = function(s, onClose)
		btn:Show();
		btn:SetScript("OnClick", onClose);
	end;
	self.SetText = function(s, t) 
		label:SetText(t); 
	end

	self.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil; s.EnableCloseButton = nil; s.SetText = nil;
		btn:Destroy(); btn = nil;
		VFLUI.ReleaseRegion(label); label = nil;
	end, self.Destroy);

	return self;
end

-- A dialog control for sort components.
VFLUI.SortDialogFrame = {};
function VFLUI.SortDialogFrame:new(parent)
	local self = VFLUI.PassthroughFrame:new(nil, parent);
	self:SetBackdrop(VFLUI.DefaultDialogBorder);
	self:SetInsets(5, 20, 5, 5);

	local btn = VFLUI.CloseButton:new(self, 12);
	btn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -6, -6);
	btn:Show();

	local upbtn = VFLUI.TexturedButton:new(self, 12, "Interface\\Addons\\VFL\\Skin\\sb_up");
	upbtn:SetPoint("RIGHT", btn, "LEFT");
	upbtn:Show();

	local dnbtn = VFLUI.TexturedButton:new(self, 12, "Interface\\Addons\\VFL\\Skin\\sb_down");
	dnbtn:SetPoint("RIGHT", upbtn, "LEFT");
	dnbtn:Show();

	------------- The "reverse-or-not" checkbox
	local rvs = VFLUI.Checkbox:new(self);
	rvs:SetHeight(16); rvs:SetWidth(60); rvs:SetText(VFLI.i18n("Reverse"));
	rvs:SetPoint("RIGHT", dnbtn, "LEFT");
	rvs:Show();

	local label = VFLUI.CreateFontString(self);
	label:SetHeight(12); label:SetWidth(50);
	label:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -7);
	label:SetFontObject(Fonts.Default10); label:SetJustifyH("LEFT");
	label:Show();

	local oldSetChild = self.SetChild;
	self.SetChild = function(s, child)
		oldSetChild(s, child);
		s:SetCollapsed(nil);
	end

	self.DialogOnLayout = VFL.hook(function(s)
		label:SetWidth(math.max(s:GetWidth() - 100, 0));
	end, self.DialogOnLayout);

	self.SetupButtons = function(s, onClose, onUp, onDn)
		btn:SetScript("OnClick", onClose);
		upbtn:SetScript("OnClick", onUp);
		dnbtn:SetScript("OnClick", onDn);
	end;
	self.SetText = function(s, t) 
		label:SetText(t); 
	end
	self.IsReversed = function(s) return rvs:GetChecked(); end
	self.SetReversed = function(s, arg) rvs:SetChecked(arg); end
	self.DisableButtons = function(s, dUp, dDn, dClose, dReverse)
		if dUp then upbtn:Hide(); end
		if dDn then dnbtn:Hide(); end
		if dClose then btn:Hide(); end
		if dReverse then rvs:Hide(); end
	end

	self.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil; s.SetupButtons = nil; s.SetText = nil; s.IsReversed = nil; s.SetReversed = nil;
		s.DisableButtons = nil;
		btn:Destroy(); btn = nil; upbtn:Destroy(); upbtn = nil; dnbtn:Destroy(); dnbtn = nil;
		rvs:Destroy(); rvs = nil;
		VFLUI.ReleaseRegion(label); label = nil;
	end, self.Destroy);

	return self;
end
