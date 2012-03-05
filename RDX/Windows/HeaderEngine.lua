-- HeaderEngine.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- The Header Engine allows the creation of RDX windows that are "driven" by SecureRaidGroupHeaderTemplates.
-- This will allow windows to update themselves in-combat to reflect changes to the raid group.

--VFLP.RegisterCategory(VFLI.i18n("RDX: Misc Render"));

local modf, floor, abs, strlower = math.modf, math.floor, math.abs, string.lower;
local GetRDXUnit = RDXDAL._ReallyFastProject;

----------- Helper functions for headers.
local function siter_active_children(header, i)
	i = i + 1;
	local child = header:GetAttribute("child" .. i);
	if child and child:IsShown() then
		return i, child, child:GetAttribute("unit");
	end
end

local function siter_all_children(header, i)
	i = i + 1;
	local child = header:GetAttribute("child" .. i);
	if child then
		return i, child, child:GetAttribute("unit");
	end
end

local function siter_ds(header, i)
	i = i + 1;
	local child, uid = header:GetAttribute("child" .. i), nil;
	if child and child:IsShown() then
		uid = child:GetAttribute("unit");
		return i, uid, GetRDXUnit(uid);
	end
end

----------------------- Common header API
local headerAPI = {};
-- Return a stateless iterator over *active* children in this header.
function headerAPI:ActiveChildren() return siter_active_children, self, 0; end

-- Return a stateless iterator over *all* children in this header.
function headerAPI:AllChildren() return siter_all_children, self, 0; end

-- Iterate this header as if it were an RDX DataSource
function headerAPI:IterateAsDataSource() return siter_ds, self, 0; end

-- Get the i'th child of this smart header.
function headerAPI:GetChild(i) return self:GetAttribute("child" .. i); end

-- Get the i'th child of this smart header only if it is active; just return nil
-- otherwise.
function headerAPI:GetActiveChild(i)
	local ch = self:GetAttribute("child" .. i);
	if ch and ch:IsShown() then return ch; end
end

-- Set this header to a comma-separated list of names
function headerAPI:SetNameList(list)
	if self:GetAttribute("groupFilter") then self:SetAttribute("groupFilter", nil); end
	self:SetAttribute("nameList", list);
	self:Show();
end

local function CleanupHeader(x)
	x:Hide(); x:SetScale(1); x:SetBackdrop(nil);
	-- Set default attributes
	x:SetAttribute("showRaid", true); x:SetAttribute("showParty", true); x:SetAttribute("showSolo", true); x:SetAttribute("showPlayer", true);
	x:SetAttribute("nameList", nil); x:SetAttribute("groupFilter", nil); x:SetAttribute("strictFiltering", nil);
	x:SetAttribute("point", "TOP"); x:SetAttribute("xOffset", 0);	x:SetAttribute("yOffset", 0);
	x:SetAttribute("sortMethod", nil); x:SetAttribute("sortDir", nil);
	x:SetAttribute("template", "SecureFrameTemplate"); x:SetAttribute("templateType", "Frame");
	x.initialConfigFunction = nil;
	-- Frame specific cleanup
	VFLUI._CleanupLayoutFrame(x);
end

------------------------------------------------------------
-- A pooled wrapper for Blizzard's secure header template.
------------------------------------------------------------
VFLUI.CreateFramePool("SecureGroupHeader", function(pool, frame)
	CleanupHeader(frame);
end, function()
	local f = CreateFrame("Frame", "SGH" .. VFL.GetNextID(), nil, "SecureGroupHeaderTemplate");
	f:SetAttribute("_ignore", "RDXIgnore");
	CleanupHeader(f);
	-- Mixin the API
	VFL.mixin(f, headerAPI);
	return f;
end);

VFLUI.CreateFramePool("SecureGroupPetHeader", function(pool, frame)
	CleanupHeader(frame);
	frame:SetAttribute("useOwnerUnit", nil); frame:SetAttribute("filterOnPet", nil);
end, function()
	local f = CreateFrame("Frame", "SGHP" .. VFL.GetNextID(), nil, "SecureGroupPetHeaderTemplate");
	CleanupHeader(f);
	f:SetAttribute("useOwnerUnit", nil); f:SetAttribute("filterOnPet", nil);
	-- Mixin the API
	VFL.mixin(f, headerAPI);
	return f;
end);

------------------------------------------------------------
-- SMART HEADER
-- We start by abstracting the header template itself, into an object with some intelligent API.
-- - Signal for when it reapportions itself
-- - API for querying its size
-- - API for querying and iterating its contents
-- - Ability to "stuff" it with data (while out of combat)
-- - Ability to associate a "subframe" with each unit frame underneath the header; the subframes
--     can be dynamically pooled.
------------------------------------------------------------
RDX.SmartHeader = {};
function RDX.SmartHeader:new(ty, switchvehicle, winpath)
	if type(ty) ~= "string" then ty = "SecureGroupHeader"; end
	local self = VFLUI.AcquireFrame(ty);
	self:SetAttribute("template", "SecureFrameTemplate"); 
	self:SetAttribute("templateType", "Frame");
	self:SetAttribute("sortMethod", "INDEX"); 
	self:SetAttribute("sortDir", "ASC");
	self.OnAllocateFrame = VFL.Noop; 
	self.OnSecureUpdate = VFL.Noop;
	-- Called whenever a new child frame is associated to this header.
	self.icf = function(self, newChildName)
		if switchvehicle then _G[newChildName]:SetAttribute("toggleForVehicle", true); end
		local succ,err = pcall(self.OnAllocateFrame, self, _G[newChildName]);
		if not succ and winpath then
			RDX.printW(winpath .." could not be updated. It will be rebuild at the end of combat. (or Reload your UI now!)");
			RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, winpath);
		end
		--self:OnAllocateFrame(_G[newChildName]);
	end
	self:SetAttribute('initialConfigFunction', [[
		control:GetParent():CallMethod('icf', self:GetName());
	]]);
	
	self.Destroy = VFL.hook(function(s)
		if InCombatLockdown() then
			error(VFLI.i18n("Attempt to destroy secure header while in combat."));
		end
		-- Clear data
		s:Hide();
		s:SetAttribute('initialConfigFunction', nil);
		s.OnAllocateFrame = nil; s.OnSecureUpdate = nil; s.icf = nil;
		-- Invoke :Destroy on any children that have a destroy method
		for _,child in self:AllChildren() do
			if child.Destroy then 
				child:Destroy(); child.Destroy = nil; 
			end
		end
	end, self.Destroy);

	return self;
end

-- We need to hook the SecureRaidGroupHeader_Update function to notify a SmartHeader that it
-- has been updated.
-- WoW 2.1: These functions have been rejigged internally by blizzard. This should work with both
-- versions.
if type(SecureRaidGroupHeader_Update) == "function" then
	hooksecurefunc("SecureRaidGroupHeader_Update", function(header)
		if header.OnSecureUpdate then header:OnSecureUpdate(); end
	end);
elseif type(SecureGroupHeader_Update) == "function" then
	hooksecurefunc("SecureGroupHeader_Update", function(header)
		if header.OnSecureUpdate then header:OnSecureUpdate(); end
	end);
end
if type(SecureGroupPetHeader_Update) == "function" then
	hooksecurefunc("SecureGroupPetHeader_Update", function(header)
		if header.OnSecureUpdate then header:OnSecureUpdate(); end
	end);
end

-------------------------------------------------------------------------------
-- HEADER GRID
--
-- The Header Grid combines a series of SmartHeaders in a user-controllable
-- orientation.
--
-- It provides a "downward-driver" function that can iterate over an Set or
-- Sort and stuff each header's name list to a given capacity. It also provides
-- "upward-driver" capabilities such that whenever any of the subheaders
-- update themselves, notification is given.
-------------------------------------------------------------------------------
RDX.HeaderGrid = {};

-- Stateless iterator for the header grid.
-- Concept: encode values as integers of the form XXX*1000 + YYY, where
-- XXX is the index into the header array, and YYY is the index into the header itself.
local function _project_index(n)
	local i = modf(n/1000);
	local j = n - (i*1000);
	return i + 1, j;
end
local function _unproject_index(i, j)
	return ((i - 1)*1000) + j;
end

local function hg_stateless_iterator(hg, i)
	-- Move to the next index
	i = i + 1;
	local x,y = _project_index(i);
	local col, cell = nil, nil;
	-- Find the column specified by this index. If we cannot, we must already be
	-- past the end of the array, so early abort.
	col = hg:GetSubHeader(x); if not col then return; end
	-- Try to get an active cell from this column
	cell = col:GetActiveChild(y);
	if cell then
		return i, x, y, cell, cell:GetAttribute("unit");
	end
	-- There was no cell, let's move on to the first cell of the next column...
	x = x + 1; y = 1;
	col = hg:GetSubHeader(x); if not col then return; end
	cell = col:GetActiveChild(y);
	if cell then
		return _unproject_index(x,y), x, y, cell, cell:GetAttribute("unit");
	end
end

-- Iterate ALL frames, even inactive ones
local function hg_stateless_iterator_all(hg, i)
	i = i + 1;
	local x,y = _project_index(i);
	local col, cell = nil, nil;
	col = hg:GetSubHeader(x); if not col then return; end
	cell = col:GetChild(y);
	if cell then
		return i, x, y, cell, cell:GetAttribute("unit");
	end
	x = x + 1; y = 1;
	col = hg:GetSubHeader(x); if not col then return; end
	cell = col:GetChild(y);
	if cell then
		return _unproject_index(x,y), x, y, cell, cell:GetAttribute("unit");
	end
end

-- A working table used to assemble strings for header stuffing
local strList = {};

function RDX.HeaderGrid:new(parent, htype)
	local self = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(self, parent, 1);
	self:SetWidth(0.1); self:SetHeight(0.1);

	-- Internal callbacks.
	self.OnSecureUpdate = VFL.Noop;
	self.OnAcclimatize = VFL.Noop;
	self.OnDeacclimatize = VFL.Noop;
	-- The sub-headers.
	local headers = {};
	-- The number of active units in this grid
	local active = 0;

	-------------------------- ACCESSORS
	--- Get the n'th subheader in this grid.
	function self:GetSubHeader(index) return headers[index]; end
	function self:GetNumSubHeaders() return #headers; end

	--- Get a cell by index from this grid.
	function self:GetCellByIndex(idx)
		local x,y = _project_index(idx);
		local col = headers[x]; if not col then return nil; end
		return col:GetChild(y);
	end
	self.ProjectIndex = _project_index;

	--- Iterate over the  ACTIVE contents of this grid.
	function self:Iterator()
		return hg_stateless_iterator, self, 0;
	end
	--- Iterate over the ENTIRE contents of this grid.
	function self:IterateAll()
		return hg_stateless_iterator_all, self, 0;
	end

	-------------------------- LAYOUT
	local l_dir, l_dx, l_dy, l_opp, l_subdir, l_sdx, l_sdy = "TOPLEFT", 0, 0, "TOPRIGHT", "TOP", 0, 0;
	local std_dx, std_dy = 0, 0;

	local function Layout()
		local tf = headers[1];
		if tf then
			tf:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0);
		else 
			return; -- no headers, early out
		end
		for i=2,#headers do
			headers[i]:ClearAllPoints();
			headers[i]:SetPoint(l_dir, tf, l_opp, l_dx, l_dy);
			tf = headers[i];
		end
	end

	-- Get the width and height of our grid.
	function self:GetBoundary()
		-- Empty case
		if #headers == 0 then 
			if l_subdir == "TOP" then
				return std_dx,0;
			elseif l_subdir == "LEFT" then
				return 0,std_dy;
			else
				return 0,0;
			end
		end
		local l, t, r, b = 100000, 0, 0, 100000;
		for _,header in ipairs(headers) do
			local hl, ht, hr, hb = VFLUI.GetLocalBoundary(header);
			if not hl then hl=100000; hb = 100000; hr = 0; ht = 0; end -- BUGFIX: nil check on response.
			if(hl < l) then l = hl; end
			if(hr > r) then r = hr; end
			if(hb < b) then b = hb; end
			if(ht > t) then t = ht; end
		end
		if(l == 100000) then l=0; end
		if(b == 100000) then b=0; end
		return l, t, r, b;
	end

	-- Convert units of length along the major and minor axes, respectively, into
	-- units of absolute length.
	function self:RectifyDimensions(activeCells, xCells, yCells)
		if ( (l_opp == "TOPRIGHT") and (l_subdir == "LEFT") ) then
			return activeCells * std_dx, std_dy;
		elseif ( (l_opp == "BOTTOMLEFT") and (l_subdir == "TOP") ) then
			return std_dx, activeCells * std_dy;
		elseif l_subdir == "LEFT" then
			return std_dx * yCells, std_dy * xCells;
		elseif l_subdir == "TOP" then
			return std_dx * xCells, std_dy * yCells;
		else
			error(VFLI.i18n("Erroneous direction parameters (shouldn't be possible!)"));
		end
	end

	--- Change the layout parameters for this grid.
	function self:SetLayoutParameters(dir, dx, dy, subdir, sdx, sdy, sfdx, sfdy)
		if #headers > 0 then
			error(VFLI.i18n("Cannot SetLayoutParameters() to a header grid that is already in use."));
		end
		if(dir == "LEFT") then
			l_dir = "TOPLEFT"; l_opp = "TOPRIGHT";
		elseif(dir == "TOP") then
			l_dir = "TOPLEFT"; l_opp = "BOTTOMLEFT";
		else
			error("Invalid external direction");
		end
		if (subdir ~= "LEFT") and (subdir ~= "TOP") then error(VFLI.i18n("Invalid internal direction")); end
		l_dx = dx; l_dy = dy; l_subdir = subdir; l_sdx = sdx; l_sdy = sdy;
		std_dx = sfdx; std_dy = sfdy;
	end
	function self:GetLayoutParameters()
		return l_dir, l_dx, l_dy, l_opp, l_subdir, l_sdx, l_sdy;
	end
	function self:GetHeaderDirection() return l_subdir; end
	
	----------------------------------------- FUNCTORS
	local function SubHeaderUpdate(hdr)
		self:OnSecureUpdate(hdr);
	end
	local function AllocateFrame(hdr, frame)
		self:OnAcclimatize(hdr, frame);
	end

	----------------------------------------- CONTENT
	-- Add headers to this grid until the number of headers is equal to k.
	function self:SizeHeaders(k, switchvehicle)
		-- No work to do
		if(k == #headers) then return; end
		-- Can't manipulate these while in combat..
		if InCombatLockdown() then return; end 

		if(k < #headers) then -- Truncation
			for i=(k+1), #headers, 1 do
				local h = headers[i];
				for _, cell in h:AllChildren() do
					self:OnDeacclimatize(h, cell);
				end
				h:Destroy();
				headers[i] = nil;
			end
		else -- Insertion
			for i=(#headers + 1),k,1 do
				-- Create our new subheading
				local h = RDX.SmartHeader:new(htype, switchvehicle);
				h:SetParent(self); h:Hide();
				-- Set up its properties
				h:SetAttribute("point", l_subdir);
				h:SetAttribute("xOffset", l_sdx); h:SetAttribute("yOffset", l_sdy);
				h.OnSecureUpdate = SubHeaderUpdate; h.OnAllocateFrame = AllocateFrame;
				for _, cell in h:AllChildren() do self:OnAcclimatize(h, cell); end
				-- Add it to our table
				table.insert(headers, h);
			end
			Layout(); -- Update our layout
		end
	end

	--- Stuff this header with data
	function self:Stuff(iterGen, filter, transform, bucket, limit, switchvehicle)
		if InCombatLockdown() then return; end
		if not limit then limit = 10000; end
		VFL.empty(strList);
		local count, bucketCount, maxBucket, idx = 0, 0, 0, 0;
		-- Sort iterables into buckets
		for x1,x2,x3,x4,x5 in iterGen() do if filter(x1,x2,x3,x4,x5) then
			count = count + 1; if(count > limit) then break; end
			local bkt = bucket(x1,x2,x3,x4,x5);
			maxBucket = math.max(maxBucket, bkt);
			if not strList[bkt] then strList[bkt] = "";  bucketCount = bucketCount + 1; end
			strList[bkt] = strList[bkt] .. transform(x1,x2,x3,x4,x5) .. ",";
		end end
		-- Resize us
		self:SizeHeaders(bucketCount, switchvehicle);
		-- No buckets = no more work
		if(bucketCount == 0) then return 0,0; end
		-- Populate the headers.
		for i=1,maxBucket do if strList[i] then
			idx = idx + 1;
			self:GetSubHeader(idx):SetNameList(strList[i]);
		end	end
		return count, bucketCount;
	end

	------------------------------- DESTRUCTOR
	self.Destroy = VFL.hook(function(s)
		-- Deallocate all subheaders
		s:SizeHeaders(0); headers = nil; active = nil;
		self.OnSecureUpdate = nil; self.OnAcclimatize = nil; self.OnDeacclimatize = nil;
		-- Annul API
		self.GetSubHeader = nil; self.GetNumSubHeaders = nil;
		self.GetCellByIndex = nil; self.ProjectIndex = nil;
		self.Iterator = nil; self.IterateAll = nil; self.IterateDataSource = nil;
		self.GetBoundary = nil; self.SetLayoutParameters = nil; self.GetLayoutParameters = nil;
		self.RectifyDimensions = nil; self.GetHeaderDirection = nil;
		self.SizeHeaders = nil; self.Stuff = nil;
	end, self.Destroy);

	return self;
end

------------------------------ BUCKETING FUNCTIONS
--- A straightforward bucketing function that just splits the header into evenly sized subheaders.
local counter, curbkt, bktsz = 0, 0, 0;
local function typewriterBucket()
	counter = counter + 1;
	if(counter > bktsz) then curbkt = curbkt + 1; counter = 1; end
	return curbkt;
end
function RDXUI.TypewriterBucketing(colsz)
	curbkt = 1; bktsz = colsz; counter = 0;
	return typewriterBucket;
end

local function classBucket(_, uid, unit)
	if not unit then return 1; end
	return unit:GetClassID() + 1;
end
function RDXUI.ClassBucketing() return classBucket; end

local idToBucketMap = {};
local function classOrderBucket(_, uid, unit)
	if not unit then return 1; end
	local id = unit:GetClassID();
	local bkt = idToBucketMap[id];
	if not bkt then
		bkt = curbkt; curbkt = curbkt + 1; idToBucketMap[id] = bkt;
	end
	return bkt;
end
function RDXUI.ClassOrderBucketing()
	curbkt = 1; VFL.empty(idToBucketMap);
	return classOrderBucket;
end

local function groupBucket(_, uid, unit)
	if not unit then return 9; end
	local g = unit:GetGroup();
	if g == 0 then return 9; else return g; end
end
function RDXUI.GroupBucketing() return groupBucket; end

local function roleBucket(_, uid, unit)
	if not unit then return 4; end
	local g = unit:GetRoleType();
	if g == 0 then return 4; else return g; end
end
function RDXUI.RoleBucketing() return roleBucket; end

---------------------------------------------------------------------
-- HEADER EDITOR
-- An interface for editing header descriptors.
---------------------------------------------------------------------
RDXUI.HeaderEditor = {};
function RDXUI.HeaderEditor:new(parent)
	local ui = VFLUI.CompoundFrame:new(parent);

	--------------- Content section
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Content parameters")));

	local driver = VFLUI.DisjointRadioGroup:new();

	local driver_NSet = driver:CreateRadioButton(ui);
	driver_NSet:SetText(VFLI.i18n("Use nominative Set"));
	local driver_GC = driver:CreateRadioButton(ui);
	driver_GC:SetText(VFLI.i18n("Use group/class/role filter"));
	driver:SetValue(2);

	-- Group/class section
	ui:InsertFrame(driver_GC);
	local classes = RDXUI.ClassFilterUI:new(ui); classes:Show();
	ui:InsertFrame(classes); 
	local groups = RDXUI.GroupFilterUI:new(ui); groups:Show();
	ui:InsertFrame(groups);

	-- nset section
	ui:InsertFrame(driver_NSet);
	local nset = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "NominativeSet$")); end);
	nset:SetLabel(VFLI.i18n("Set")); nset:Show();
	ui:InsertFrame(nset);
	
	
	--------------- Pet/Vehicle section
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Pet/Vehicle parameters")));
	local chk_pet = VFLUI.Checkbox:new(ui); 
	chk_pet:Show(); chk_pet:SetText(VFLI.i18n("Show Pet"));
	ui:InsertFrame(chk_pet);
	
	local chk_switchvehicle = VFLUI.Checkbox:new(ui); chk_switchvehicle:Show();
	chk_switchvehicle:SetText(VFLI.i18n("Switch vehicle"));
	ui:InsertFrame(chk_switchvehicle);

	------------------ Sorting section
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Sort parameters")));

	local sortType = VFLUI.RadioGroup:new(ui);
	sortType:SetLayout(2,2);
	sortType.buttons[1]:SetText(VFLI.i18n("Sort by index"));
	sortType.buttons[2]:SetText(VFLI.i18n("Sort by name"));
	ui:InsertFrame(sortType);
	sortType:SetValue(1);

	local sortRev = VFLUI.Checkbox:new(ui); sortRev:Show();
	sortRev:SetText(VFLI.i18n("Reverse sort"));
	ui:InsertFrame(sortRev);

	------------------ Layout section
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));

	local groupType = VFLUI.RadioGroup:new(ui);
	groupType:SetLayout(3,3);
	groupType.buttons[1]:SetText(VFLI.i18n("No grouping"));
	groupType.buttons[2]:SetText(VFLI.i18n("Group by class"));
	groupType.buttons[3]:SetText(VFLI.i18n("Group by raidgroup"));
	ui:InsertFrame(groupType);
	groupType:SetValue(1);

	local er = VFLUI.EmbedRight(ui, VFLI.i18n("Design assembly anchor:"));
	local dd_up = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
	dd_up:SetWidth(100); dd_up:Show(); dd_up:SetSelection("TOP");
	er:EmbedChild(dd_up); er:Show();
	ui:InsertFrame(er);

	local ed_width = VFLUI.LabeledEdit:new(ui, 50); ed_width:Show();
	ed_width:SetText(VFLI.i18n("Max subheaders"));
	ui:InsertFrame(ed_width);

	local ed_height = VFLUI.LabeledEdit:new(ui, 50); ed_height:Show();
	ed_height:SetText(VFLI.i18n("Units per subheader (0 = unlimited)"));
	ui:InsertFrame(ed_height);

	local ed_padding = VFLUI.LabeledEdit:new(ui, 50); ed_padding:Show();
	ed_padding:SetText(VFLI.i18n("Padding between subheaders"));
	ui:InsertFrame(ed_padding);

	local er = VFLUI.EmbedRight(ui, VFLI.i18n("Subheader assembly anchor:"));
	local dd_lp = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
	dd_lp:SetWidth(100); dd_lp:Show(); dd_lp:SetSelection("LEFT");
	er:EmbedChild(dd_lp); er:Show();
	ui:InsertFrame(er);

	function ui:SetDescriptor(tbl)
		if type(tbl) ~= "table" then return; end
		dd_up:SetSelection(tbl.frameAnchor or "TOP");
		ed_width.editBox:SetText(tbl.w or 1);
		ed_height.editBox:SetText(tbl.h or 0);
		ed_padding.editBox:SetText(tbl.padding or 0);
		dd_lp:SetSelection(tbl.colAnchor or "LEFT");
		groupType:SetValue(tbl.groupType or 1);
		sortType:SetValue(tbl.sortType or 1);
		sortRev:SetChecked(tbl.sortRev);
		driver:SetValue(tbl.driver or 2);
		if tbl.driver == 1 then
			nset:SetPath(tbl.nset);
		elseif tbl.driver == 2 then
			classes:SetClasses(tbl.classes);
			groups:SetGroups(tbl.groups);
		end
		chk_pet:SetChecked(tbl.pet);
		chk_switchvehicle:SetChecked(tbl.switchvehicle);
	end

	function ui:GetDescriptor()
		local desc = {};
		local x = tonumber(ed_width.editBox:GetText()); if not x then x = 1; end
		desc.w = x;
		x = tonumber(ed_height.editBox:GetText()); if x == 0 then x = nil; end
		desc.h = x;
		x = tonumber(ed_padding.editBox:GetText()); if not x then x = 0; end
		desc.padding = x;
		desc.frameAnchor = dd_up:GetSelection();
		desc.colAnchor = dd_lp:GetSelection();
		desc.groupType = groupType:GetValue();
		desc.sortType = sortType:GetValue();
		desc.sortRev = sortRev:GetChecked();
		desc.driver = driver:GetValue();
		if desc.driver == 1 then
			desc.nset = nset:GetPath();
		else
			desc.classes = classes:GetClasses();
			desc.groups = groups:GetGroups();
		end
		desc.pet = chk_pet:GetChecked();
		desc.switchvehicle = chk_switchvehicle:GetChecked();
		return desc;
	end

	ui.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil;
		s.SetDescriptor = nil;
	end, ui.Destroy);

	return ui;
end

function RDXUI.ApplyHeaderDescriptor(hdr, hdef)
	hdr:SetAttribute("point", hdef.frameAnchor or "TOP");
	hdr:SetAttribute("columnAnchorPoint", hdef.colAnchor or "LEFT");
	hdr:SetAttribute("columnSpacing", hdef.padding or 0);
	hdr:SetAttribute("startingIndex", 1);
	hdr:SetAttribute("unitsPerColumn", hdef.h);
	hdr:SetAttribute("maxColumns", hdef.w or 1);
	if hdef.groupType == 2 then
		hdr:SetAttribute("groupingOrder", "PRIEST,DRUID,PALADIN,SHAMAN,WARRIOR,WARLOCK,MAGE,ROGUE,HUNTER,DEATHKNIGHT");
		hdr:SetAttribute("groupBy", "CLASS");
	elseif hdef.groupType == 3 then
		hdr:SetAttribute("groupingOrder", "1,2,3,4,5,6,7,8");
		hdr:SetAttribute("groupBy", "GROUP");
	elseif hdef.groupType == 4 then
		hdr:SetAttribute("groupingOrder", "TANK,DAMAGER,HEALER");
		hdr:SetAttribute("groupBy", "ROLE");
	else
		-- No grouping
		hdr:SetAttribute("groupBy", nil);
		hdr:SetAttribute("groupingOrder", nil);
	end
	if hdef.sortType == 1 then hdr:SetAttribute("sortMethod", "INDEX"); else hdr:SetAttribute("sortMethod", "NAME"); end
	if hdef.sortRev then hdr:SetAttribute("sortDir", "DESC"); else hdr:SetAttribute("sortDir", "ASC"); end
	if hdef.driver == 2 then
		hdr:SetAttribute("nameList", nil);
		hdr:SetAttribute("strictFiltering", true);
		local gf = "";
		if hdef.groups then
			for i=1,8 do if hdef.groups[i] then gf = gf .. i .. ","; end end
		end
		if hdef.classes then
			for i=1,10 do if hdef.classes[i] then gf = gf .. RDXMD.GetClassMnemonic(i) .. ","; end end
		end
		if hdef.roles then
			for i=1,3 do if hdef.roles[i] then gf = gf .. i .. ","; end end
		end
		hdr:SetAttribute("groupFilter", gf);
	end
end
