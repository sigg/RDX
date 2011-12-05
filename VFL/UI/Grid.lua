-- Grid.lua
-- VFL
-- (C)2006 Bill Johnson

local mod, ceil = VFL.mmod, math.ceil;

------------------------------------------------------------
------------------------------------------------------------
-- GRID
-- A grid is a rectangular array of frames which can itself
-- be manipulated like a frame.
-- 
-- A grid can be built using the Size() method, which will
-- allocate an array of frames using a user-provided allocator
-- function.
--
-- Every frame in a grid should be given an OnDeparent method, which
-- will be called when the frame is released from the grid.
------------------------------------------------------------
------------------------------------------------------------
VFLUI.Grid = {};
VFLUI.Grid.__index = VFLUI.Grid;

----------------------------------------------------------------------------------------------
-- INTERNAL IMPLEMENTATION
----------------------------------------------------------------------------------------------

-- Glue two frames together along a shared corner
local function glue(grid, lastx, lasty, lastframe, thisx, thisy, thisframe, padx, pady)
--	VFLUI:Debug(10, "gluing cell " .. thisx .. "," .. thisy);
	thisframe:ClearAllPoints();
	if(lasty == thisy) then
		if(lastx < thisx) then
			-- Last anchored frame was left of this one.
			-- Anchor the topleft of this one to the topright of the next
			thisframe:SetPoint("TOPLEFT", lastframe, "TOPRIGHT", padx, 0);
		else
			-- The last frame was to the right of this one.
			-- Anchor the topright of this to the topleft of last
			thisframe:SetPoint("TOPRIGHT", lastframe, "TOPLEFT", -padx, 0);
		end
	else
		-- Get the last frame from the previously laid-out row
		lastframe = grid:GetCell(thisx, lasty);
		if(lasty < thisy) then
			-- Last frame is above this one.
			-- Anchor topleft to bottomleft.
			thisframe:SetPoint("TOPLEFT", lastframe, "BOTTOMLEFT", 0, -pady);
		else
			-- Last frame is below this one.
			-- Anchor bottomleft to topleft
			thisframe:SetPoint("BOTTOMLEFT", lastframe, "TOPLEFT", 0, pady);
		end
	end
end

-- Update the interior cell layout for the grid
local function UpdateLayout(self)
	if not self.nolayout then
		local oldc, oldx, oldy, first = nil, nil, nil, true;
		for _,c,x,y in self:StatelessIterator(1) do
			if first then
				-- Anchor the first frame to the container
				c:ClearAllPoints();
				c:SetPoint("TOPLEFT", self, "TOPLEFT");
				first = nil;
			else
				-- Glue subsequent cells to their predecessors.
				glue(self, oldx, oldy, oldc, x, y, c, 0, 0);
			end
			-- Store the previous cell for subsequent operations.
			oldx = x; oldy = y; oldc = c;
		end
	end
end
VFLP.RegisterFunc("VFL UI", "Grid layout", UpdateLayout, true);

-- Remove/deparent a cell known to exist
local function RemoveCellAt(grid, x, y)
	local c = grid.cells[x][y];
	grid.cells[x][y] = nil;
	if (c and (c.OnDeparent)) then c:OnDeparent(); c.OnDeparent = nil; end
end

-- Apply all UI-specific primitives necessary to make the cell appear
-- correctly in the grid.
local function OrientCell(grid, cell)
	if grid.OnOrient then
		grid:OnOrient(cell);
	else
		cell:SetParent(grid); cell:SetScale(1);
		cell:SetFrameStrata(grid:GetFrameStrata());
		cell:SetFrameLevel(grid:GetFrameLevel() + 1);
	end
end

----------------------------------------------------------------------------------------
-- MUTATORS
----------------------------------------------------------------------------------------
-- Clear the grid, freeing all cells.
function VFLUI.Grid:Clear()
	for x=1,self.dx do
		for y=1,self.dy do
			RemoveCellAt(self, x, y);
		end
	end
	self.dx = 0; self.dy = 0; VFL.empty(self.cells);
end

-- Size the grid to the given width and height.
-- 
-- OnAlloc() is called each time a newly allocated cell is touched. Its return
-- value is placed in the cell.
function VFLUI.Grid:Size(w, h, OnAlloc, ...)
	-- Do-nothing check
	if(w == self.dx) and (h == self.dy) then return; end
	-- Destroy all out-of-bounds cells
	for x=1,self.dx do
		for y=1,self.dy do
			if(x>w) or (y>h) then
				RemoveCellAt(self, x, y);
			end
		end
		if(x>w) then self.cells[x] = nil; end
	end
	-- Allocate missing cells
	for x=1,w do
		if not self.cells[x] then self.cells[x] = {}; end
		for y=1,h do
			if not self.cells[x][y] then
				local c = nil;
				if OnAlloc then 
					c = OnAlloc(self, ..., x, y); OrientCell(self, c);
				end
				self.cells[x][y] = c;
			end
		end
	end
	-- Update internal states
	self.dx = w; self.dy = h;
	-- Run layout engine
	UpdateLayout(self); self:ComputeFrameDimensions();
end
VFLP.RegisterFunc("VFL UI", "Grid resize", VFLUI.Grid.Size, true);

-- Insert a row of frames directly into the grid.
function VFLUI.Grid:InsertRow(pos, row)
	-- Make sure the target position is sane
	if(pos < 1) or (pos > self.dy) then return nil; end
	-- The row needs to have the right number of columns
	if(table.getn(row) ~= self.dx) then return nil; end
	for i=1,self.dx do
		OrientCell(self, row[i]);
		table.insert(self.cells[i], pos, row[i]);
	end
	-- Expand DY
	self.dy = self.dy + 1;
	return true;
end

-- Attach a frame to the END of a single-column grid.
function VFLUI.Grid:InsertFrame(f, pos)
	if (self.dx ~= 1) then return nil; end
	OrientCell(self, f);
	if pos then
		table.insert(self.cells[1], pos, f);
	else
		table.insert(self.cells[1], f);
	end
	self.dy = self.dy + 1;
	return true;
end

-- Remove a frame inserted by InsertFrame.
function VFLUI.Grid:RemoveFrame(f)
	if(self.dx ~= 1) or (self.dy < 1) then return nil; end
	local qq = self.cells[1];
	for i=1,self.dy do
		if (qq[i] == f) then 
			self.dy = self.dy - 1; table.remove(qq, i); return true; 
		end
	end
	return nil;
end

-- Locate a frame in the grid.
function VFLUI.Grid:LocateFrame(f)
	for _,cell,x,y in self:StatelessIterator() do
		if(cell == f) then return x,y; end
	end
	return nil;
end

-- Delete a row of frames directly from the grid.
function VFLUI.Grid:DeleteRow(pos)
	-- Position sanity check
	if(pos < 1) or (pos > self.dy) or (self.dy == 0) then return false; end
	for i=1,self.dx do
		local c = table.remove(self.cells[i], pos);
		if(c.OnDeparent) then c:OnDeparent(); c.OnDeparent = nil; end
	end
	self.dy = self.dy - 1;
	return true;
end

-----------------------------------------------------------------------------
-- ITERATORS AND ACCESSORS
-----------------------------------------------------------------------------
-- Get the size of the grid
-- patch 3.3 deprecated GetSize()
--function VFLUI.Grid:GetSize()
--	return self.dx, self.dy;
--end
function VFLUI.Grid:GetGridSize()
	return self.dx, self.dy;
end
function VFLUI.Grid:GetNumRows() return self.dy; end
function VFLUI.Grid:GetNumColumns() return self.dx; end

-- Get the cell at a given location
function VFLUI.Grid:GetCell(x,y)
	return self.cells[x][y];
end

-- Obtain an iterator over a region of the grid.
-- The iterator can move in various directions.
-- dir: 1=+x->+y 2=-x->+y 3=+x->-y 4=-x->-y 5 = +y->+x
function VFLUI.Grid:RegionIterator(x0, y0, x1, y1, dir)
	-- Bounds check for the iterator
	if(x0 < 1) or (y0 < 1) or (x1 < 1) or (y1 < 1) or (x0 > self.dx) or (y0 > self.dy) or (x1 > self.dx) or (y1 > self.dy) then
		return VFL.Nil;
	end
	local _c = self.cells;
	-- Switch based on the direction
	if(dir == 1) then
		local x,y = x0-1,y0;
		return function()
			x = x + 1;
			if(x > x1) then
				x = x0; y = y + 1;
				if(y > y1) then return nil; end
			end
			return _c[x][y], x, y;
		end;
	elseif(dir == 2) then
		local x,y = x1+1,y0;
		return function()
			x = x - 1;
			if(x < 1) then
				x = x1; y = y + 1;
				if(y > y1) then return nil; end
			end
			return _c[x][y], x, y;
		end;
	elseif(dir == 3) then
		local x,y = x0-1,y1;
		return function()
			x = x + 1;
			if(x > x1) then
				x = x0; y = y - 1;
				if(y < 1) then return nil; end
			end
			return _c[x][y], x, y;
		end;
	elseif(dir == 4) then
		local x,y = x1+1,y1;
		return function()
			x = x - 1;
			if(x < 1) then
				x = x1; y = y - 1;
				if(y < 1) then return nil; end
			end
			return _c[x][y], x, y;
		end
	elseif(dir == 5) then
		local x,y = x0, y0 - 1;
		return function()
			y = y + 1;
			if(y > y1) then
				y = y0; x = x + 1;
				if(x > x1) then return nil; end
			end
			return _c[x][y], x, y;
		end
	else
		error("VFLUI.Grid:RegionIterator() - invalid iterator direction");
	end
end

function VFLUI.Grid:Iterator(dir)
	if not dir then dir=1; end
	return self:RegionIterator(1,1,self.dx,self.dy,dir);
end

function VFLUI.Grid:RowIterator(row)
	return self:RegionIterator(1, row, self.dx, row, 1);
end

function VFLUI.Grid:ColumnIterator(col)
	return self:RegionIterator(col, 1, col, self.dy, 5);
end

--- Return the n'th entry of the grid in the given iterator direction.
function VFLUI.Grid:Nth(n, dxn)
	if (not n) or (not dxn) or (n <= 0) then return nil; end
	local x,y;
	if(dxn == 1) then -- +x->+y
		x = mod(n, self.dx); if x==0 then x=self.dx; end
		y = ceil(n/self.dx);
	elseif(dxn == 2) then -- -x->+y
	elseif(dxn == 3) then -- +x->-y		
	elseif(dxn == 4) then -- -x->-y
	elseif(dxn == 5) then -- +y->+x
		y = mod(n, self.dy); if y==0 then y=self.dy; end
		x = ceil(n/self.dy);
	end
	if not self.cells[x] then return nil; end
	return self.cells[x][y];
end

------------------------------------------------------------------------------------
-- STATELESS ITERATION
------------------------------------------------------------------------------------
local function Dxn1StatelessIter(grid, idx)
	idx = idx + 1;
	local c,dx = grid.cells, grid.dx;
	if dx == 0 then dx = 1; end
	local x,y = mod(idx, dx), ceil(idx / dx);
	if(x == 0) then x = dx; end
	if c[x] and c[x][y] then return idx, c[x][y], x, y; end
end

local function Dxn5StatelessIter(grid, idx)
	idx = idx + 1;
	local c,dy = grid.cells, grid.dy;
	if dy == 0 then dy = 1; end
	local y,x = mod(idx, dy), ceil(idx / dy);
	if(y == 0) then y = dy; end
	if c[x] and c[x][y] then return idx, c[x][y], x, y;	end
end

local si = {};
si[1] = Dxn1StatelessIter;
si[5] = Dxn5StatelessIter;

function VFLUI.Grid:StatelessIterator(dxn)
	return si[dxn or 1], self, 0;
end

------------------------------------------------------------------------------------
-- EXTENDED LAYOUT COMMANDS
------------------------------------------------------------------------------------
-- Sets the row heights and column widths.
-- The arguments can either be arrays (in which case each row height/column width is
-- set to the value of the corresponding array entry) or numbers (in which case each row height/
-- column width is set to the given value)
function VFLUI.Grid:SetCellDimensions(xdim, ydim)
	if type(xdim) == "table" then
		for _,c,x,y in self:StatelessIterator() do
			if xdim[x] then c:SetWidth(xdim[x]); end
		end
	elseif type(xdim) == "number" then
		for _,c in self:StatelessIterator() do
			c:SetWidth(xdim);
		end
	else
		error("xdim parameter to SetCellDimensions must be a table or number");
	end

	if type(ydim) == "table" then
		for _,c,x,y in self:StatelessIterator() do
			if ydim[y] then c:SetHeight(ydim[y]); end
		end
	elseif type(ydim) == "number" then
		for _,c in self:StatelessIterator() do
			c:SetHeight(ydim);
		end
	else
		error("ydim parameter to SetCellDimensions must be a table or number");
	end

	self:ComputeFrameDimensions();
end

-- Recompute all layout-related information (used when manipulating internal frames
-- directly)
function VFLUI.Grid:Relayout()
	UpdateLayout(self);	self:ComputeFrameDimensions();
end

------------------------------------------------------------------------------------
-- CONSTRUCTION
------------------------------------------------------------------------------------
--- Create a new Grid, optionally creating it as a child of the given parent.
-- @param parent (Optional) The frame to make this Grid a child of.
function VFLUI.Grid:new(parent, nolayout)
	local self = VFLUI.AcquireFrame("Frame");

	if parent then
		self:SetParent(parent);
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	self.nolayout = nolayout;

	-- Get Blizz UI methods for overriding purposes
	local BlizzardSetHeight = self.SetHeight;
	local BlizzardSetWidth = self.SetWidth;

	-- Resize the container for this grid to appropriately accomodate the cells.
	self.ComputeFrameDimensions = function(s)
		if not self.nolayout then
			local dx,dy,c = s.dx, s.dy, s.cells;
			if(dx == 0) or (dy == 0) then 
				BlizzardSetHeight(s, 0); BlizzardSetWidth(s, 0);
				return; 
			end
			local w, h = 0, 0;
			-- Count 
			for i=1,dx do w = w + c[i][1]:GetWidth(); end
			for i=1,dy do h = h + c[1][i]:GetHeight(); end
			--VFLUI:Debug(7, "Grid(" .. tostring(s) .. "):ComputeFrameDimensions(): dx=" .. w .. " dy=" .. h);
			BlizzardSetHeight(s, h); BlizzardSetWidth(s, w);
		end
	end

	-- Apply a downward layout constraint along the y-axis.
	self.SetHeight = function(s, height)
		if not self.nolayout then
			BlizzardSetHeight(s, height);
			if(s.dy == 0) then return; end
			height = height / s.dy;
			for _,c in s:StatelessIterator() do c:SetHeight(height); end
		end
	end

	-- Apply a downward layout constraint along the x-axis.
	self.SetWidth = function(s, width)
		if not self.nolayout then
			BlizzardSetWidth(s, width);
			if(s.dx == 0) then return; end
			width = width / s.dx;
			for _,c in s:StatelessIterator() do c:SetWidth(width); end
		end
	end

	-- Attach functions
	VFL.mixin(self, VFLUI.Grid);

	-- Setup destroy function
	self.Destroy = VFL.hook(function(self)
		self:Clear();

		VFL.unmix(self, VFLUI.Grid);

		self.SetHeight = nil; self.SetWidth = nil; self.ComputeFrameDimensions = nil;

		self.OnOrient = nil;
	
		self.dx = nil; self.dy = nil; self.cells = nil;
		
		self.nolayout = nil;
	end, self.Destroy);
	
	-- Initialize
	self.dx = 0; self.dy = 0;
	self.cells = {};
	self:ClearAllPoints();

	return self;
end

--------------------------------
--------------------------------
-- VIRTUAL GRID
--
-- A VirtualGrid is a wrapper around a Grid that allows the grid to be
-- used as a view into an underlying data store.
--
-- The VirtualGrid contains the following member variables:
-- - vx - The virtual x-coordinate of the top-left square of the grid
-- - vy - The virtual y-coordinate of the top-left square of the grid
--
-- Closures must be provided by the user which do the following things:
-- - Render the cells of the grid from the underlying data source. (OnRenderCell)
-- - Determine the scroll boundaries of the virtual space. (GetVirtualSize)
--
-- self:OnRenderCell(cell, physicalX, physicalY, virtualX, virtualY) must update
-- the cell with its contents, extracted from the virtual space by whatever means
-- you choose.
--
-- self:GetVirtualSize() must return the maximum allowable values for vx and vy
-- acceptable to OnRenderCell.
---------------------------------
---------------------------------
VFLUI.VirtualGrid = {};
VFLUI.VirtualGrid.__index = VFLUI.VirtualGrid;

-- Create a virtual grid atop the given physical grid.
function VFLUI.VirtualGrid:new(phys)
	if not phys then return nil; end
	local self = {};
	self.vx = 1; self.vy = 1;
	setmetatable(self, VFLUI.VirtualGrid);
	self.physicalGrid = phys;
	return self;
end

-- Destroy a virtual grid and its underlying physical grid.
function VFLUI.VirtualGrid:Destroy()
	self.OnRenderCell = nil; self.GetVirtualSize = nil;
	self.physicalGrid:Destroy(); self.phys = nil;
end

-- Update the grid with the given virtual coordinates
function VFLUI.VirtualGrid:SetVirtualPosition(vx, vy)
	-- Sanify coordinates
	local vxMax, vyMax = self:GetVirtualSize();
	if(vx < 1) then vx = 1; elseif(vx > vxMax) then vx = vxMax; end
	if(vy < 1) then vy = 1; elseif(vy > vyMax) then vy = vyMax; end
	-- Update
	self.vx = vx; self.vy = vy;
	for c, x, y in self.physicalGrid:Iterator() do
		self:OnRenderCell(c, x, y, vx, vy);
	end
end
VFLP.RegisterFunc("VFL UI", "VirtualGrid paint", VFLUI.VirtualGrid.SetVirtualPosition, true);
