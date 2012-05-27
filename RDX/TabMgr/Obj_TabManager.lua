-- TabManager.lua
-- OpenRDX 
--

----------------------------------------------------------------
-- SORT FUNCTORS AND OPERATOR GENERATION
----------------------------------------------------------------
local sortOps = {};
local sortCategory = {};
local sortCategories = {};

--- Register a category of sort functions. Can later be passed as category= to
-- RegisterSortOperator.
function RDXPM.RegisterTabCategory(cat)
	local cdata = {};
	sortCategory[cat] = cdata;
	table.insert(sortCategories, {name = cat, entries = cdata});
end

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
function RDXPM.RegisterTab(tbl)
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

function RDXPM.UnregisterTab(name, category)
	sortOps[name] = nil;
	local qq = sortCategory[category];
	VFL.removeFieldMatches(qq, "name", name);
end

function RDXPM.GetTabByName(n)
	if not n then return nil; end
	return sortOps[n];
end

----------------------------------------------------------------
-- SORT UI
----------------------------------------------------------------
-- The drag context for sorts
RDXPM.dcSorts = VFLUI.DragContext:new();

-- Generate a frame onto which a filter can be dropped.
function RDXPM.GenerateSortDropTarget(parent)
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
	self:SetText(VFLI.i18n("(Drag a ChatFrame here)"));
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
		RDXPM.dcSorts:UnregisterDragTarget(s);
		VFLUI.ReleaseRegion(tex); tex = nil;
	end, self.Destroy);

	RDXPM.dcSorts:RegisterDragTarget(self);
	return self;
end



-- Helper function to build a selectable menu of all sort categories.
local function CreateCategoryEntry(cat)
	return { text = cat, hlt = { r=0, g=0.5, b=0.7, a=.75 } };
end
local function CreateSortEntry(x)
	local fn, ft = x.name, x.title;
	return { text = ft, OnMouseDown = function(self)
		RDXPM.dcSorts:Drag(self, VFLUI.CreateGenericDragProxy(self, ft, fn));
	end };
end
local _sortcmps = {};
local function BuildSortComponentMenu()
	VFL.empty(_sortcmps);
	for _,cdata in pairs(sortCategories) do
		table.insert(_sortcmps, CreateCategoryEntry(cdata.name));
		for _,fdata in pairs(cdata.entries) do
			table.insert(_sortcmps, CreateSortEntry(fdata));
		end
	end
	return _sortcmps;
end

---------------- The sort editor dialog.
RDXPM.TabManagerEditor = {};
function RDXPM.TabManagerEditor:new(parent)
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
		local op = RDXPM.GetTabByName(desc.op);
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
		--- Draggable target
		local dragTarget = RDXPM.GenerateSortDropTarget(ctr); dragTarget:Show();
		function dragTarget:OnDrop(dropped)
			local op = RDXPM.GetTabByName(dropped.data);
			if not op then error(VFLI.i18n("SortUI: an invalid sort component was drag/dropped.")); return; end
			InsertByDescriptor(op.GetBlankDescriptor());
			VFLUI.UpdateDialogLayout(ctr);
		end
		ctr:InsertFrame(dragTarget);
	end

	function dlg:SetDescriptors(desc)
		ResetUI();
		if desc then
			for _,entry in ipairs(desc) do
				InsertByDescriptor(entry);
			end
		end
		ctr:SetWidth(sf:GetWidth()); ctr:Show();
		VFLUI.UpdateDialogLayout(ctr);
	end

	function dlg:GetDescriptors()
		if(ctr.dy < 2) then
			RDX:Debug(5, "SortDialog:GetDescriptors() - missing arguments, aborting.");
			return nil; 
		end
		local ret, i = {}, 0;
		for x in ctr:Iterator() do
			if (x ~= set) and (x.GetDescriptor) then
				i=i+1; ret[i] = x:GetDescriptor();
			end
		end
		return ret;
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

--- Generic empty UI generating function
function RDXPM.TrivialChatFrameUI(name, text)
	return function(parent, desc)
		local ui = VFLUI.SortDialogFrame:new(parent);
		ui:DisableButtons(nil, nil, nil, true);
		ui:SetText(text); ui:Show();
		ui.GetDescriptor = function() return {op = name}; end
		return ui;
	end;
end

-- The dialog for editing the contents of a Sort.
local dlg = nil;
local function EditTabManagerDialog(parent, path, md)
	if dlg then
		RDX.printI(VFLI.i18n("A tab manager editor is already open. Please close it first."));
		return;
	end
	if (not path) or (not md) or (not md.data) then return nil; end

	dlg = VFLUI.Window:new(parent); 
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(435); dlg:SetHeight(350);
	dlg:SetText("Edit TabManager: " .. path);
	if RDXPM.Ismanaged("TabManager") then RDXPM.RestoreLayout(dlg, "TabManager"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	dlg:Show();

	-- Editor
	local ed = RDXPM.TabManagerEditor:new(dlg);
	ed:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	ed:Show();
	
	if md.data then
		ed:SetDescriptors(md.data.cfm);
	else
		ed:SetDescriptors();
	end

	-- OK/cancel
	local esch = function() 
		RDXPM.StoreLayout(dlg, "TabManager");
		dlg:Destroy(); dlg = nil;
	end
	VFL.AddEscapeHandler(esch);

	local function Save()
		local d1 = ed:GetDescriptors();
		if d1 then
			md.data = { cfm = d1 };
			RDXDB.NotifyUpdate(path);
		else
			RDX.printI(VFLI.i18n("Error: missing descriptor."));
		end
		VFL.EscapeTo(esch);
	end
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		ed:Destroy(); ed = nil;
	end, dlg.Destroy);
end

RDXDB.RegisterObjectType({
	name = "TabManager";
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		EditTabManagerDialog(parent or VFLDIALOG, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function() 
				VFL.poptree:Release(); 
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});







