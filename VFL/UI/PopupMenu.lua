-- PopupMenu.lua
-- VFL - Venificus' Function Library
-- (C)2005-2006 Bill Johnson (Venificus of Eredar server)
--
-- Implementation of a generalized popup menu object.

-- Amount of time to wait for the mouse to not be over a menu before autoclosing
-- it
local mouseOutDelay = 2;

-- An empty popup menu
local emptyMenu = {
	{ text = "|c00888888(Empty menu)|r" }
};
local menuFrame = CreateFrame("Frame", "VFL_DropDownFrame", VFLFULLSCREEN_DIALOG, "UIDropDownMenuTemplate");

function VFLUI.PopUpMenu(data, point, parent, relpoint, x, y)
	if (point) then
		EasyMenu(data, menuFrame, parent, x, y, "MENU");
	else
		EasyMenu(data, menuFrame, "cursor", 0 , 0, "MENU");
	end
end

function VFLUI.ClosePopUp()
	UIDROPDOWNMENU_OPEN_MENU:Hide();
	menuFrame:Hide();
end

-----------------------------------------------------------------------------
-- @class VFLUI.PopMenu
--
-- An entity for displaying a hierarchical menu whose display entities are 
-- VFL Selectables.
-- 
-- PopupMenu:Begin(targetFrame, targetPoint, offx, offy) functions like SetPoint
-- and sets where the popup menu will originate from.
--
-- PopupMenu:Expand(anchorFrame, data) expands the tree, hanging it off the given
-- frame.
-----------------------------------------------------------------------------
-- Rendering functions
local function UnivMenuApplyData(cell, data)
	-- Set pictorials
	if(data.hasArrow) then 
		cell.icon:Show();
	elseif data.checked and type(data.checked) == "function" and data.checked() then
		cell.icon:SetTexture("Interface\\AddOns\\VFL\\Skin\\DotOn");
		cell.icon:Show();
	elseif(data.texture) then
		cell.icon:SetTexture(data.texture);
		cell.icon:Show();
	else
		cell.icon:Hide();
	end
	-- Set text color
	if(data.color) then
		cell.text:SetTextColor(data.color.r, data.color.g, data.color.b);
	else
		cell.text:SetTextColor(1,1,1);
	end
	-- Set text
    cell:Enable();
	cell.text:SetText(data.text);
	cell:SetScript("OnClick", data.func);
	cell:SetScript("OnMouseDown", data.OnMouseDown);
	cell:SetScript("OnMouseUp", data.OnMouseUp);
	-- Show highlight
	if(data.hlt) then cell:Select(); else cell:Unselect(); end
end

local function LeftMenuApplyData(cell, data)
	cell:SetPurpose(3);
	cell.icon:SetTexture("Interface\\Addons\\VFL\\Skin\\sb_left");
	UnivMenuApplyData(cell, data);
end

local function RightMenuApplyData(cell, data)
	cell:SetPurpose(2);
	cell.icon:SetTexture("Interface\\Addons\\VFL\\Skin\\sb_right");
	UnivMenuApplyData(cell, data);
end

local function DisableListContents(list)
	list:SetAlpha(0.45);
	for x in list:_GetGrid():Iterator() do
		x:Disable();
	end
end

-- Popmenu object
VFLUI.PopMenu = {};
VFLUI.PopMenu.__index = VFLUI.PopMenu;

function VFLUI.PopMenu:new()
	local self = {};
	setmetatable(self, VFLUI.PopMenu);
	-- Create unique escape handler
	self.esch = function() self:Release(); end
	return self;
end

-- Determine if the popup tree is currently in use.
function VFLUI.PopMenu:IsInUse()
	if self.menus then return true; else return nil; end
end

-- Determine if the mouse is over this menu
function VFLUI.PopMenu:MouseIsOver()
	for k,v in pairs(self.menus) do if MouseIsOver(v) then return true; end end
	return false;
end

-- Schedule a repeating check to see if the mouse is still over the menu or not.
function VFLUI.PopMenu:MouseOutCheck()
	self.mouseout_schedule = nil;
	if not self.menus then return; end
	local mouseout = true;
	if not self:MouseIsOver() then
		self.mouseout_schedule = VFLT.schedule(mouseOutDelay, VFLUI.PopMenu.MouseOutFinal, self);
	else
		self.mouseout_schedule = VFLT.schedule(0.5, VFLUI.PopMenu.MouseOutCheck, self);
	end
end

-- Final mouseout check -- if the mouse is out this time, destroy the menu
function VFLUI.PopMenu:MouseOutFinal()
	self.mouseout_schedule = nil;
	if not self:MouseIsOver() then
		self:Release();
	else
		-- Back to regular checks.
		self.mouseout_schedule = VFLT.schedule(1, VFLUI.PopMenu.MouseOutCheck, self);
	end
end

-- Start a new popup tree. Destroys any old popup tree and sets the anchor point for the
-- newly created tree
function VFLUI.PopMenu:Begin(cellWidth, cellHeight, frame, point, dx, dy)
	-- Sanify parameters
	if (not frame) then return false; end
	if (not dx) then dx = 0; dy = 0; end
	-- Destroy preexisting menus
	if(self.menus) then self:Release(); end
	-- Compute orientation
	-- Get center
	local UICx, UICy = VFLParent:GetCenter();
	-- Translate 1/4 screenwidth rightward
	UICx = UICx + ((VFLParent:GetRight() - UICx)/2);
	-- Go universal
	UICx, UICy = VFLUI.GetUniversalCoords(VFLParent, UICx, UICy);
	-- Get universal coords of new frame center
	local MCx, MCy = VFLUI.GetPoint(frame, point);
	MCx, MCy = VFLUI.GetUniversalCoords(frame, MCx + dx, MCy + dy);
	if(MCx > UICx) then self.orientation = 1; else self.orientation = 2; end
	
	-- Move the menu slightly so the mouse is within the menu boundaries.
	if self.orientation == 1 then
		dx = dx + 10; dy = dy + 10;
	else
		dx = dx - 10; dy = dy + 10;
	end
	
	-- Initialize state
	self.af = frame; self.ap = point; self.adx = dx; self.ady = dy; self.cdx = cellWidth; self.cdy = cellHeight;
	self.menus = {};

	-- If no point was provided, treat as a dropdown
	if not point then
		if self.orientation == 1 then
			self.ap = "BOTTOMRIGHT";
		else
			self.ap = "BOTTOMLEFT";
		end
	end
end

-- Expand the popup tree by attaching a menu with the given data, anchored to
-- the given frame.
function VFLUI.PopMenu:Expand(aFrame, data, limit)
	-- Sanity check on state
	if not self.menus then error("VFLUI.PopMenu: attempt to expand uninitialized menu"); end
	-- Sanity check on data
	if (not data) or (table.getn(data) == 0) then data = emptyMenu; end
	if (data.OnClick) then
		data.func = data.OnClick;
	end
	-- Determine menu depth
	local menu_level = nil;
	if aFrame and aFrame._menu_level then
		menu_level = aFrame._menu_level + 1;
	else
		menu_level = 1;
	end
	if not menu_level then error("could not determine menu level"); end
	-- Close all menus deeper than the depth of the new menu
	if menu_level <= #(self.menus) then
		for i = 1, #(self.menus) - menu_level + 1 do
			self.menus[i].decor:Destroy(); self.menus[i].decor = nil;
			self.menus[i]:Destroy();
		end
		for i=1, #(self.menus) - menu_level + 1 do table.remove(self.menus, 1); end
	end
	
	-- Determine layout parameters
	local aHoldPoint, aGrabPoint, fnad, dy, dx = nil, nil, nil, 0, 5;
	if(self.orientation == 1) then -- left-oriented
		aHoldPoint = "TOPLEFT"; aGrabPoint = "TOPRIGHT"; fnad = LeftMenuApplyData;
		dx = -dx;
	else -- right oriented
		aHoldPoint = "TOPRIGHT"; aGrabPoint = "TOPLEFT"; fnad = RightMenuApplyData;
	end
	
	-- If we've not yet created a menu...
	if(table.getn(self.menus) == 0) then
		VFL.AddEscapeHandler(self.esch);
		aFrame = self.af; aHoldPoint = self.ap; dx = dx + self.adx; dy = self.ady;
	else
		dy = 0; -- Shift things upward by units of one cell (?)
	end

	-- Create the decor frame to "look pretty"
	local decor = VFLUI.AcquireFrame("Frame");
	decor:SetParent(VFLTOOLTIP);
	decor:SetFrameLevel(1);
	decor:SetBackdrop(VFLUI.BlackDialogBackdrop);
	
	-- Create the menu
	local menuSz = table.getn(data);
	if limit then menuSz = math.min(limit, menuSz); end
	local menu = VFLUI.List:new(decor, self.cdy, function()
		local c = VFLUI.Selectable:new(nil, Fonts.Default10);
		c._menu_level = menu_level;
		c.Destroy = VFL.hook(c.Destroy, function(x)
			x._menu_level = nil;
		end);
		c.OnDeparent = c.Destroy;
		return c;
	end);
	menu:SetWidth(self.cdx); menu:SetHeight((menuSz * self.cdy) + 1);
	menu:SetDataSource(fnad, VFL.ArrayLiterator(data));
	
	-- Assign and anchor the decor to the menu
	menu.decor = decor;
	decor:SetPoint("TOPLEFT", menu, "TOPLEFT", -5, 4);
	decor:SetPoint("BOTTOMRIGHT", menu, "BOTTOMRIGHT", 5, -5);

	-- Anchor the menu to the appropriate point
	menu:SetPoint(aGrabPoint, aFrame, aHoldPoint, VFLUI.TransformCoords(aFrame, VFLParent, dx, dy));
	
	-- Insert our new menu into the hierarchy
	table.insert(self.menus, 1, menu);

	-- Show the new menu
	menu:Rebuild();
	menu:Show(); decor:Show();
	
	-- Check for off-screenage
	local bx, by = 0, 0;
	if not menu:GetLeft() then return; end
	if(menu:GetLeft() < 0) then
		bx = -menu:GetLeft();
	else
		local univMenuRight, univScreenRight = VFLUI.ToUniversalAxis(menu, menu:GetRight()), VFLUI.ToUniversalAxis(VFLParent, VFLParent:GetRight());
		if( univMenuRight > univScreenRight ) then
			bx = -VFLUI.ToLocalAxis(menu, univMenuRight - univScreenRight);
		end
	end
	if(menu:GetBottom() < 0) then by = -menu:GetBottom(); end
	self:Bump(bx, by);
	
	-- Schedule mouseout checks
	if not self.mouseout_schedule then self:MouseOutCheck(); end
end

-- Bump the popup tree by moving the first anchor by the given distance.
function VFLUI.PopMenu:Bump(dx, dy)
	if(dx == 0) and (dy == 0) then return; end
	self.adx = self.adx + dx; self.ady = self.ady + dy;
	local firstm = self.menus[table.getn(self.menus)];
	if not firstm then return; end
	local aGrabPoint = "TOPLEFT";
	if(self.orientation == 1) then aGrabPoint = "TOPRIGHT"; end
	firstm:SetPoint(aGrabPoint, self.af, self.ap, self.adx, self.ady);
end

-- Release and destroy the entire popup tree.
function VFLUI.PopMenu:Release()
	if not self.menus then return; end
	local m = table.remove(self.menus);
	while m do
		m:Destroy();
		m.decor:Destroy(); m.decor = nil;
		m = table.remove(self.menus);
	end
	self.menus = nil;
	VFL.RemoveEscapeHandler(self.esch);
	if self.mouseout_schedule then
		VFLT.deschedule(self.mouseout_schedule);
		self.mouseout_schedule = nil;
	end
end

--- Global popup menu object.
VFL.poptree = VFLUI.PopMenu:new();


