--- IntervalTree.lua
-- @author (C)2006 Bill Johnson and The VFL Project
-- @class file
-- @name VFL.IntervalTree
-- @description An "interval tree" is a data structure that stores a set of intervals of the real line of the form [x1, x2].
-- It is designed to efficiently answer queries of the form "Which interval does the point p lie in?" It is
-- a red-black tree, augmented with some additional information.
-- Each node of an interval tree has a left, right, parent, and color.
-- As each node represents an interval, there are low and high numerical fields associated to it.
-- In addition, the node has a gub (greatest upper bound) field as an intermediary.

VFL.IntervalTree = {};
VFL.IntervalTree.__index = VFL.IntervalTree;

local tinsert = table.insert;

--- Construct a new, empty interval tree.
-- @param min
-- @param max
-- @return a new VFL.IntervalTre object
function VFL.IntervalTree:new(min, max)
	local self = {};
	setmetatable(self, VFL.IntervalTree);

	-- Create the "sentinel node" for the tree
	local sentinel = {};
	sentinel.left = sentinel; sentinel.right = sentinel; sentinel.parent = sentinel;
	sentinel.low = min; sentinel.high = min; sentinel.gub = min;
	sentinel.red = false;
	self.sentinel = sentinel;

	-- Create the "root node" for the tree
	local root = {};
	root.left = sentinel; root.right = sentinel; root.parent = sentinel;
	root.low = max; root.high = max; root.gub = max;
	root.red = false;
	self.root = root;

	-- Return the new tree
	return self;
end


-- Perform left rotation on node x.
-- Moves x.parent to x.left, lifts x to x.parent, and fixes other poiners accordingly.
-- Also updates the internal max fields.
local function LeftRotate(sentinel, x)
	local y = x.right;
	x.right = y.left;

	if(y.left ~= sentinel) then y.left.parent = x; end

	y.parent = x.parent;

	if(x == x.parent.left) then x.parent.left = y; else	x.parent.right = y;	end
	y.left = x;
	x.parent = y;

	x.gub = math.max(x.left.gub, x.right.gub, x.high);
	y.gub = math.max(x.high, y.right.gub, y.gub);
end

-- Perform right rotation on node y.
local function RightRotate(sentinel, y)
	local x = y.left;
	y.left = x.right;
	
	if(sentinel ~= x.right) then x.right.parent = y; end

	x.parent = y.parent;

	if(y == y.parent.left) then y.parent.left = x; else	y.parent.right = x;	end
	x.right = y; 
	y.parent = x;

	y.gub = math.max(y.left.gub, y.right.gub, y.high);
	x.gub = math.max(x.left.gub, y.gub, x.high);
end

-- Insert helper function. Treats the tree as a regular binary tree.
local function InsertHelper(sentinel, root, z)
	local x,y = root.left, root;
	-- For starters, the node is nowhere.
	z.left = sentinel; z.right = sentinel;
	-- Traverse down
	while(x ~= sentinel) do
		y = x;
		if(x.low > z.low) then -- Current node's value is bigger than desired, move left
			x = x.left;
		else -- Current node's value is smaller than desired, move right
			x = x.right;
		end
	end
	-- We found our parent node
	z.parent = y;
	-- Associate us as the proper child to our parent
	if( (y == root) or (y.low > z.low) ) then
		y.left = z;
	else
		y.right = z;
	end
end

-- GUB fixer function. Fixes the greatest-upper-bound field of all nodes between
-- us and the root.
local function FixGUB(root, x)
	-- Traverse up
	while(x ~= root) do
		x.gub = math.max(x.high, x.left.gub, x.right.gub);
		x=x.parent;
	end
end

--- Insert an interval with the given endpoints.
-- @param low
-- @param high
function VFL.IntervalTree:Insert(low, high)
	local sentinel, root = self.sentinel, self.root;
	local x,y,new;

	-- Create the new node
	x = {};
	x.low = low; x.high = high;
	-- Standard insert phase
	InsertHelper(sentinel, root, x); FixGUB(root, x);

	-- Rebalancing phase
	new = x; x.red = true;
	while(x.parent.red) do
		if(x.parent == x.parent.parent.left) then
			y = x.parent.parent.right;
			if y.red then
				-- Recolor
				x.parent.red = false; y.red = false; x.parent.parent.red = true;
				-- Recurse
				x = x.parent.parent;
			else
				if(x == x.parent.right) then
					x = x.parent; LeftRotate(sentinel, x);
				end
				x.parent.red = false; x.parent.parent.red = true;
				RightRotate(sentinel, x.parent.parent);
			end
		else -- parent = parent.parent.right, similar but reversed polarity
			y = x.parent.parent.left;
			if(y.red) then
				x.parent.red = false; x.red = false; x.parent.parent.red = true;
				x = x.parent.parent;
			else
				if(x == x.parent.left) then
					x = x.parent; RightRotate(sentinel, x);
				end
				x.parent.red = false; x.parent.parent.red = true;
				LeftRotate(sentinel, x.parent.parent);
			end
		end
	end
	root.left.red = false;

	-- Return the newly created node
	return new;
end

--- Get the successor of the given node, or null if none exists.
-- @param x The node
function VFL.IntervalTree:GetSuccessorOf(x)
	local y, sentinel = x.right, self.sentinel;
	if(y ~= sentinel) then
		while(y.left ~= sentinel) do y=y.left; end
		return y;
	else
		y = x.parent;
		while(x == y.right) do x = y; y = y.parent; end
		if(y == self.root) then return nil; end
		return y;
	end
end

--- Get the predecessor of the given node, or null if none exists.
-- @param x The node
function VFL.IntervalTree:GetPredecessorOf(x)
	local y, sentinel, root = x.left, self.sentinel, self.root;
	if(y ~= sentinel) then
		while(y.right ~= sentinel) do y=y.right; end
		return y;
	else
		y = x.parent;
		while(x == y.left) do
			if(y == root) then return nil; end
			x = y; y = y.parent; 
		end
		return y;
	end
end

local function RInorderTraversal(tree, sentinel, node, func)
	if node ~= sentinel then
		RInorderTraversal(tree, sentinel, node.left, func);
		func(tree, node);
		RInorderTraversal(tree, sentinel, node.right, func);
	end
end

--- Traverses the tree in order, calling func(tree, node) each time.
function VFL.IntervalTree:InorderTraversal(func)
	RInorderTraversal(self, self.sentinel, self.root.left, func);
end

--- Dump the tree
function VFL.IntervalTree:Dump()
	self:InorderTraversal(function(tree, node)
		local str = "  PARENT: ";
		if(node.parent == tree.sentinel) then str = str .. "nil"; else str = str .. node.parent.low; end
		VFL.debug(str);
		local str = "  LEFT: ";
		if(node.left == tree.sentinel) then str = str .. "nil"; else str = str .. node.left.low; end
		VFL.debug(str);
		local str = "  RIGHT: ";
		if(node.right == tree.sentinel) then str = str .. "nil"; else str = str .. node.right.low; end
		VFL.debug(str);
	end);
end

local function IntersectR(node, sentinel, x0, x1, data)
	local n0, n1 = node.low, node.high;
	-- If this node contains the interval, add it.
	if ( (x0 <= n1) and (n0 <= x1) ) then	
		tinsert(data, node); 
	end
	-- If the left tree could contain an intersection with this interval, traverse it.
	local n = node.left;
	if( (n ~= sentinel) and (x0 <= n.gub) ) then
		IntersectR(n, sentinel, x0, x1, data);
	end
	-- If the right tree could contain an intersection with this interval, traverse it.
	n = node.right;
	if( (n ~= sentinel) and (x0 <= n.gub) ) then
		IntersectR(n, sentinel, x0, x1, data);
	end
end

--- Return all intervals in the interval tree that intersect the given interval.
function VFL.IntervalTree:Intersect(x0, x1, data)
	if not data then data = {}; end
	IntersectR(self.root, self.sentinel, x0, x1, data);
	return data;
end

--[[
function ittest()
	local t = VFL.IntervalTree:new(-1000, 1000);
	t:Insert(0,20);
	t:Insert(5,25);
	t:Insert(15,30);
	t:Dump();
	local data = t:Intersect(5,35);
	for k,v in ipairs(data) do VFL.print("[" .. v.low .. "," .. v.high .. "]"); end
end
]]
