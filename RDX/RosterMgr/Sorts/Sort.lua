-- Sort.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--

--VFLP.RegisterCategory(VFLI.i18n("RDXDAL: Sorts"));

-------------------------------------------- Parameters
local perf_SortPeriod = .075;


-----------------------------------------------------------------------------
-- A Sort is a logical "view" on a set with a coupled Sort operation that can
-- be executed to sort the contents according to a given rubric.
-- Sorts have the following API:
--
-- SetData(set, sortFunc) - Set the underlying set and sort function for this
--   sort. sortFunc(u1,u2) is of the table.sort variety, accepting two RDX Unit
--   objects as parameters.
-- GetUnderlyingSet() - Get the underlying set for this sort
-- Iterator() - Iterate over this sort in order.
-- Rebuild() - Rebuild the sortation from the underlying set, then Sort().
-- Sort() - Sort the current sortation.
-----------------------------------------------------------------------------
RDXDAL.Sort = {};

local function Sort_ClosureFreeIterator(sortation, i)
	i = i + 1;
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

local function Sort_Raid_ClosureFreeIterator(sortation, i)
	i = i + 1;
	while sortation[i] and sortation[i].nid > 40 do i = i + 1; end
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

local function Sort_RaidPet_ClosureFreeIterator(sortation, i)
	i = i + 1;
	while sortation[i] and (sortation[i].nid < 41 or sortation[i].nid > 80) do i = i + 1; end
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

local function Sort_RaidRaidPet_ClosureFreeIterator(sortation, i)
	i = i + 1;
	while sortation[i] and sortation[i].nid > 80 do i = i + 1; end
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

local function Sort_Arena_ClosureFreeIterator(sortation, i)
	i = i + 1;
	while sortation[i] and (sortation[i].nid < 81 or sortation[i].nid > 85) do i = i + 1; end
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

local function Sort_ArenaPet_ClosureFreeIterator(sortation, i)
	i = i + 1;
	while sortation[i] and (sortation[i].nid < 86 or sortation[i].nid > 90) do i = i + 1; end
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

local function Sort_ArenaArenaPet_ClosureFreeIterator(sortation, i)
	i = i + 1;
	while sortation[i] and (sortation[i].nid < 81 or sortation[i].nid > 90) do i = i + 1; end
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

local function Sort_Boss_ClosureFreeIterator(sortation, i)
	i = i + 1;
	while sortation[i] and (sortation[i].nid < 91 or sortation[i].nid > 95) do i = i + 1; end
	local se = sortation[i];
	if se then
		return i, se.uid, se;
	end
end

function RDXDAL.Sort:new()
	local self = {};
	self.name = "(anonymous)";

	-------------- Refcount implementation
	local refcount = 0;
	self.IsOpen = function() return (refcount > 0); end
	self._GetRefCount = function() return refcount; end
	self.Open = function(x)
		refcount = refcount + 1;
		if(refcount == 1) then
			RDX:Debug(5, "+ Activating Sort<" .. self.name .. ">");
			x:_OnActivate();
		end
	end
	self.Close = function(x)
		if(refcount > 0) then
			refcount = refcount - 1;
			if(refcount == 0) then
				RDX:Debug(5, "- Deactivating Sort<" .. self.name .. ">");
				x:_OnDeactivate();
			end
		end
	end

	-------------- Internals
	-- Underlying set, sort function, and event map
	local uset, usf, eventTable = nil, nil, {};
	-- The internal sorted list
	local sortation = {};
	-- An inverse of the sorted list; maps unit ids back to list positions
	local umap = {};
	-- The internal update level 0==nothing, 1==resort, 2==rebuild
	local updateLevel = 0;
	-- Burning Crusade: Combat lock. If this is TRUE, and the player is
	-- in combat, then updates to this entity will be skipped over.
	local combat_lock = nil;
	-- The update signal; fires whenever this sort is updated.
	local sig = VFL.Signal:new();
	sig.OnNonEmpty = function() self:Open(); end
	sig.OnEmpty = function() self:Close(); end
	self.SigUpdate = sig;

	---------------- Updaters
	local function Rebuild()
		if not uset then return; end
		VFL.empty(sortation);
		local i = 0;
		for _,_,unit in uset:Iterator(self.rostertype) do 
			i=i+1; sortation[i] = unit;
		end
	end

	local function Sort()
		-- Burning Crusade: New sort functionality. First of all, we now allow
		-- nilpotent sorts.
		if usf and usf ~= VFL.Noop then
			table.sort(sortation, usf);
		end
		-- Secondly, we now keep a (uid->position) map to allow Skeins to quickly
		-- determine if a uid is in a window and where.
		VFL.empty(umap);
		local i,x = 1,nil;
		while true do
			x = sortation[i]; if not x then break; end
			if x.uid then umap[x.uid] = i; end
			i=i+1;
		end
	end

	--------------- Update latch and triggers
	--local updater = VFLT.CreatePeriodicLatch(perf_SortPeriod, function()
	local function updater()
		-- No updating in combat.
		if (combat_lock and InCombatLockdown()) then 
--			RDX:Debug(10,"|cFFFF00FFSecureSort update declined because of ICLD...|r");
			return; 
		end 

		if updateLevel == 1 then
--			RDX:Debug(10,"|cFF00FFFFSort " .. self.name .. " resort.|r");
			Sort();
			sig:Raise(self, 1);
		elseif updateLevel == 2 then
--			RDX:Debug(10,"|cFFFF00FFSort " .. self.name .. " rebuild.|r");
			Rebuild(); Sort();
			sig:Raise(self, 2);
		end
		updateLevel = 0;
	end
	--end);
	
	local function TriggerFullRebuild() 
		if updateLevel < 2 then 
			updateLevel = 2; updater(); 
		end
	end
	local function TriggerResort(rdxu)
		if updateLevel < 1 then
			if uset:IsMember(rdxu) then
				updateLevel = 1; updater();
			end
		end
	end
	local function TriggerResortNoCheck()
		if updateLevel < 1 then updateLevel = 1; updater(); end
	end

	-- Force an immediate full rebuild without delay.
	local function FlashFullRebuild()
		if combat_lock and InCombatLockdown() then 
--			RDX:Debug(10,"|cFFFF00FFSecureSort<" .. self.name .. "> FFR declined because of ICLD...|r");
			return; 
		end
--		RDX:Debug(10,"|cFFFF00FFSecureSort<" .. self.name .. "> FFR EXECUTING!!!|r");
		Rebuild(); Sort();
		-- Let's trip the latch anyways; help performance a little.
		updateLevel = 0; updater();
	end

	--------------- Construction, command, and control
	-- Reset the internal state of this sort.
	function self:_OnDeactivate()
		-- Remove everything from this sort.
		VFL.empty(sortation); VFL.empty(umap);
		-- Unbind us from the delta signal of the underlying set
		if uset then uset:RemoveDelta(self); end
		-- Unbind us from all RDX events.
		RDXEvents:Unbind(self);
		-- For all setlike events in our event table, unbind us from the respective set.
		for ev,data in pairs(eventTable) do
			if string.find(ev, "^_SET_") then
				data:RemoveDelta(self);
			end
		end
	end

	-- Activate this sort from a cold state
	function self:_OnActivate()
		if uset then uset:ConnectDelta(self, TriggerFullRebuild); end
		RDXEvents:Bind("DISRUPT_SORTS", nil, FlashFullRebuild, self);
		for ev,data in pairs(eventTable) do
			-- Special cases: _SET_ allows us to bind sorts to external sets
			if string.find(ev, "^_SET_") then
				data:ConnectDelta(self, TriggerResortNoCheck);
			elseif (ev == "ROSTER_UPDATE") or (data == "NOUNIT") then 			-- ROSTER_UPDATE doesn't pass a unit id for checking
				RDXEvents:Bind(ev, nil, TriggerResortNoCheck, self);
			elseif ev ~= "ROSTER_NIDS_CHANGED" then
				RDXEvents:Bind(ev, nil, TriggerResort, self);
			end
		end
		-- Fire off an initial update
		updateLevel = 2; updater();
	end

	-- Setup this sort by loading the given descriptor
	function self:Setup(sort_desc, set, secureFlag)
		-- Sanity check parameters
		if (not sort_desc) or (not set) then return nil; end
		
		-- Burning Crusade: Do not allow a secure sort to be setup in combat.
		if combat_lock and InCombatLockdown() then
			error(VFLI.i18n("Attempt to Setup() a secure sort while in combat."));
		end

		-- Proceed with setup.
		self:_OnDeactivate();
		VFL.empty(eventTable);
		local sf = RDXDAL.SortFunctor(sort_desc, set, eventTable);
		if not sf then return nil; end
		usf = sf; uset = set;
		-- Burning Crusade: Secure sort handling. If a sort is secure, make sure it
		-- fully rebuilds itself just before and after the UI lockdown.
		combat_lock = secureFlag;
		if self:IsOpen() then self:_OnActivate(); end
		return true;
	end

	--------------------- Accessors
	function self:GetUnderlyingSet() return uset; end

	function self:GetSortSize(rostertype) return uset:GetSetSize(rostertype); end

	function self:Iterator(rostertype)
		if not rostertype or rostertype == "ALL" then return Sort_ClosureFreeIterator, sortation, 0;
		elseif rostertype == "RAID" then return Sort_Raid_ClosureFreeIterator, sortation, 0;
		elseif rostertype == "RAIDPET" then return Sort_RaidPet_ClosureFreeIterator, sortation, 0;
		elseif rostertype == "RAID&RAIDPET" then return Sort_RaidRaidPet_ClosureFreeIterator, sortation, 0;
		elseif rostertype == "ARENA" then return Sort_Arena_ClosureFreeIterator, sortation, 0;
		elseif rostertype == "ARENAPET" then return Sort_ArenaPet_ClosureFreeIterator, sortation, 0;
		elseif rostertype == "ARENA&ARENAPET" then return Sort_ArenaArenaPet_ClosureFreeIterator, sortation, 0;
		elseif rostertype == "BOSS" then return Sort_Boss_ClosureFreeIterator, sortation, 0;
		end
	end

	function self:GetByIndex(i)
		return sortation[i];
	end

	-- Burning Crusade: Look in this sort and find a specific unit or UID.
	function self:IndexOfUnit(unit)
		if not unit:IsCacheValid() then return nil; end
		return umap[unit.uid];
	end
	function self:IndexOfUID(uid)
		if not uid then return nil; end
		return umap[uid];
	end
	-- Burning Crusade: Set the combat-lock flag on this sort.
	function self:IsSecure() return combat_lock; end

	return self;
end

----------------------------------------------------------------
-- SORT FUNCTORS AND OPERATOR GENERATION
----------------------------------------------------------------
local sortOps = {};
local sortCategory = {};
local sortCategories = {};

--- Register a category of sort functions. Can later be passed as category= to
-- RegisterSortOperator.
function RDXDAL.RegisterSortOperatorCategory(cat)
	local cdata = {};
	sortCategory[cat] = cdata;
	table.insert(sortCategories, {name = cat, entries = cdata});
end
RDXDAL.RegisterSortOperatorCategory(VFLI.i18n("Uncategorized"));

--- Register a new sort function. The table passed in must have the following fields:
-- name = The name of the sort function.
-- title = The text to displayed in the UI when the sort function is referred to.
-- category = A category for the sort function, used for UI purposes.
-- GetUI(parent, descriptor) = Construct a VFL hierarchical UI object for setting up the sort.
--   The UI must have a GetDescriptor() method that returns the current descriptor.
-- GetBlankDescriptor() = construct a "blank" descriptor for this sort.
-- EmitClosure(desc, code, vars) = Optional. If exists, must generate any closure code this sort requires.
--   Use the vars table to check if the variable you are creating already exists before emitting code.
-- EmitLocals(desc, code, vars) = Optional. If exists, must emit any locals code this sort requires.
-- EmitCode(desc, code, context) = Emit code for this sort into the given CodeSnippet
--   object. Operates in the "continuation-passing" style; when dealing with the "else" case,
--   you must use the code for sorts further down the chain by calling RDXDAL._SortContinuation
--   on the context object.
-- Events(desc, array) = Register each event that would cause this sort to resort.
function RDXDAL.RegisterSortOperator(tbl)
	if not tbl then error(VFLI.i18n("expected table, got nil")); end
	local n = tbl.name;
	if not n then error(VFLI.i18n("attempt to register anonymous sort function")); end
	if sortOps[n] then error(VFLI.i18n("attempt to register duplicate sort function")); end
	if not tbl.title then tbl.title = n; end
	sortOps[n] = tbl;
	-- Categorize
	local cat = tbl.category; if not cat then cat = VFLI.i18n("Uncategorized"); end
	local qq = sortCategory[cat]; 
	if not qq then qq = sortCategory[VFLI.i18n("Uncategorized")]; end
	-- HACK: create an "Invisible" category of things that won't be seen.
	if(cat ~= VFLI.i18n("Invisible")) then table.insert(qq, tbl); end
	return true;
end

function RDXDAL.GetSortOperatorByName(n)
	if not n then return nil; end
	return sortOps[n];
end

--- Recursively generate continuation-passing code for the given sort descriptor.
function RDXDAL._SortContinuation(context)
	-- Sanity check
	if (not context) then return; end
	local desc = context.desc;
	-- Retrieve the sort object entry that we're working with
	local entry = desc[context.i]; if not entry then return; end
	local op = RDXDAL.GetSortOperatorByName(entry.op); if not op then return; end
	-- Emit any necessary closures/locals
	if op.EmitClosure then op.EmitClosure(entry, context._closures, context.closureVars); end
	if op.EmitLocals then op.EmitLocals(entry, context._locals, context.localVars); end
	if op.Events then op.Events(entry, context.events); end
	-- Emit the continuation
	context.i = context.i + 1;
	op.EmitCode(entry, context._body, context);
end

--- From a sort descriptor, generate the sort function F(u1,u2).
function RDXDAL.SortFunctor(desc, set, events)
	local closures, locs, body = VFL.Snippet:new(), VFL.Snippet:new(), VFL.Snippet:new();
	-- Construct a new, properly-terminated descriptor
	local ndesc = VFL.copy(desc);
	table.insert(ndesc, {op = "_term"});
	-- Construct the assembly context.
	local context = {};
	context.desc = ndesc; context.i = 1;
	context.events = events;
	context._closures = closures;
	context.closureVars = {};
	context._locals = locs;
	context.localVars = {};
	context._body = body;

	------------ Body
	-- Body: continuation-passing!
	RDXDAL._SortContinuation(context);

	------------- Code
	local code = VFL.Snippet:new();
	code:AppendCode([[
return function(set)
]]);
	code:AppendSnippet(closures);
	code:AppendCode([[
	return function(u1, u2)
		if (u1:IsCacheValid()) and (u2:IsCacheValid()) then
]]);
	code:AppendSnippet(locs);
	code:AppendSnippet(body);
	code:AppendCode([[
		elseif u1:IsCacheValid() then
			return true;
		else
			return nil;
		end
	end
end
]]);

	-- Now generate the function.
--	VFL.Debug_ShowCode(code:GetCode()) 
	local f, err = loadstring(code:GetCode());
	if not f then 
		VFL.TripError("RDX", VFLI.i18n("Could not compile sort"), err);
		return nil;
	end
	-- Return the sort function.
	return f()(set);
end

----------------------------------------------------------------
-- SORT UI
----------------------------------------------------------------
-- The drag context for sorts
RDXDAL.dcSorts = VFLUI.DragContext:new();

-- Generate a frame onto which a filter can be dropped.
function RDXDAL.GenerateSortDropTarget(parent)
	local self = VFLUI.AcquireFrame("Button");
	if parent then
		self:SetParent(parent); self:SetFrameStrata(parent:GetFrameStrata()); self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	local tex = VFLUI.CreateTexture(self);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -4, 4);
	tex:SetTexture(1, 1, 1, 0.2);
	tex:Hide();
	
	self:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	self:SetNormalFontObject(Fonts.DefaultItalic);
	self:SetText(VFLI.i18n("(Drag a sort operator here)"));
	--self:SetTextColor(.6, .6, .6);
	self:SetHeight(30);

	-- Empty OnLayout method
	self.DialogOnLayout = VFL.Noop;
	-- On drag start/stop, highlight
	self.OnDragStart = function() tex:SetTexture(1, 1, 1, 0.2); tex:Show(); end
	self.OnDragStop = function() tex:Hide(); end
	-- On drag enter/leave, highlight brightly
	self.OnDragEnter = function() tex:SetTexture(1, 1, 1, 0.4); end
	self.OnDragLeave = function() tex:SetTexture(1, 1, 1, 0.2); end

	self.Destroy = VFL.hook(function(s)
		s.DialogOnLayout = nil;
		s.OnDragStart = nil; s.OnDragStop = nil; s.OnDragEnter = nil; s.OnDragLeave = nil; s.OnDrop = nil;
		RDXDAL.dcSorts:UnregisterDragTarget(s);
		VFLUI.ReleaseRegion(tex); tex = nil;
	end, self.Destroy);

	RDXDAL.dcSorts:RegisterDragTarget(self);
	return self;
end



-- Helper function to build a selectable menu of all sort categories.
local function CreateSortEntry(x)
	local fn, ft = x.name, x.title;
	return { text = ft, OnMouseDown = function(self)
		RDXDAL.dcSorts:Drag(self, VFLUI.CreateGenericDragProxy(self, ft, fn));
	end };
end
local _sortcmps = {};
local function BuildSortComponentMenu()
	VFL.empty(_sortcmps);
	for _,cdata in pairs(sortCategories) do
		table.insert(_sortcmps, RDXDAL._CreateCategoryEntry(cdata.name));
		for _,fdata in pairs(cdata.entries) do
			table.insert(_sortcmps, CreateSortEntry(fdata));
		end
	end
	return _sortcmps;
end

---------------- The sort editor dialog.
RDXDAL.SortEditor = {};
function RDXDAL.SortEditor:new(parent)
	-- The dialog itself
	local dlg = VFLUI.AcquireFrame("Frame");
	if parent then
		dlg:SetParent(parent); 
		dlg:SetFrameStrata(parent:GetFrameStrata());
		dlg:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	dlg:SetHeight(300); dlg:SetWidth(425);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:Show();

	------------ Left side: drag-and-drop component list
	local compList = VFLUI.List:new(dlg, 12, VFLUI.Selectable.AcquireCell);
	compList:SetPoint("TOPLEFT", dlg, "TOPLEFT", 5, -5);
	compList:SetWidth(120); compList:SetHeight(290); compList:Rebuild();
	compList:Show();
	compList:SetDataSource(VFLUI.Selectable.ApplyData_TextOnly, VFL.ArrayLiterator(BuildSortComponentMenu()));
	compList:Update();

	--------------- Right side: the UI
	local sf = VFLUI.VScrollFrame:new(dlg);
	sf:SetWidth(279); sf:SetHeight(290);
	sf:SetPoint("TOPLEFT", compList, "TOPRIGHT");
	sf:Show();

	local ctr = VFLUI.CompoundFrame:new(sf);
	ctr:SetParent(sf); sf:SetScrollChild(ctr);
	ctr.isLayoutRoot = true;

	local set = nil;

	local function Move(frame, dxn)
		local x,y = ctr:LocateFrame(frame);
		if not x then return; end
		local np = y + dxn;
		if(np < 2) or (np >= ctr.dy) then return; end -- can't move past end
		-- Do the switch
		local temp = ctr.cells[1][y];
		ctr.cells[1][y] = ctr.cells[1][np];
		ctr.cells[1][np] = temp;
		-- Relayout
		VFLUI.UpdateDialogLayout(ctr);
	end

	local function InsertByDescriptor(desc)
		if (not desc) or (not desc.op) then return; end
		local op = RDXDAL.GetSortOperatorByName(desc.op);
		if not op then return; end
		local ui = op.GetUI(ctr, desc);
		if ui.SetupButtons then
			ui:SetupButtons(function()
				if ctr:RemoveFrame(ui) then 
					ui:Destroy();
					VFLUI.UpdateDialogLayout(ctr); 
				end
			end, function()
				Move(ui, -1);
			end,
			function()
				Move(ui, 1);
			end);
		end
		ui:SetWidth(ctr:GetWidth());
		ctr:InsertFrame(ui, ctr.dy);
	end

	local function ResetUI()
		ctr:Clear(); ctr:Size(1,0);
		--- Set finder
		set = RDXDAL.SetFinder:new(ctr);
		ctr:InsertFrame(set); set:Show();
		--- Draggable target
		local dragTarget = RDXDAL.GenerateSortDropTarget(ctr); dragTarget:Show();
		function dragTarget:OnDrop(dropped)
			local op = RDXDAL.GetSortOperatorByName(dropped.data);
			if not op then error(VFLI.i18n("SortUI: an invalid sort component was drag/dropped.")); return; end
			InsertByDescriptor(op.GetBlankDescriptor());
			VFLUI.UpdateDialogLayout(ctr);
		end
		ctr:InsertFrame(dragTarget);
	end

	function dlg:SetDescriptors(sdesc, desc)
		ResetUI();
		if sdesc and desc then
			set:SetDescriptor(sdesc);
			for _,entry in ipairs(desc) do
				InsertByDescriptor(entry);
			end
		end
		ctr:SetWidth(sf:GetWidth()); ctr:Show();
		VFLUI.UpdateDialogLayout(ctr);
	end

	function dlg:GetDescriptors()
		if(ctr.dy < 3) or (not set) then
			RDX:Debug(5, "SortDialog:GetDescriptors() - missing arguments, aborting.");
			return nil; 
		end
		local ret, i = {}, 0;
		for x in ctr:Iterator() do
			if (x ~= set) and (x.GetDescriptor) then
				i=i+1; ret[i] = x:GetDescriptor();
			end
		end
		return set:GetDescriptor(), ret;
	end
	
	dlg.Destroy = VFL.hook(function(s)
		sf:SetScrollChild(nil);
		ctr:Destroy(); ctr = nil;
		sf:Destroy(); sf = nil;
		compList:Destroy(); compList = nil;
		s.SetDescriptors = nil; s.GetDescriptors = nil;
	end, dlg.Destroy);

	return dlg;
end

--- Generic empty sort UI generating function
function RDXDAL.TrivialSortUI(name, text)
	return function(parent, desc)
		local ui = VFLUI.SortDialogFrame:new(parent);
		ui:SetText(text); ui:Show();
		if desc and desc.reversed then ui:SetReversed(desc.reversed); else ui:SetReversed(); end
		ui.GetDescriptor = function() return {op = name, reversed = ui:IsReversed()}; end
		return ui;
	end;
end

----------------------------------------------------------------
-- BASIC SORT FUNCTIONS
----------------------------------------------------------------
-- Invisible: "bus terminator"
RDXDAL.RegisterSortOperator({
	name = "_term";
	category = VFLI.i18n("Invisible");
	EmitCode = function(desc, code, context)
		code:AppendCode([[
return nil;
]]);
	end;
});

