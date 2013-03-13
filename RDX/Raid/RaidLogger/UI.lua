-- UI.lua
-- RDX - Project Omniscience
-- (C)2006 Bill Johnson
--
-- The Omniscience user interface.

local dlg = nil; -- Main dialog
local fdlg = nil; -- Generic subdialog variable

---------------------------------
-- Tablespaces
---------------------------------
local tblCur = nil; -- Current table

--- Activate a table in the Omniscience viewer.
function Omni.SetActiveTable(tbl)
	if tblCur ~= tbl then
		Omni:Debug(1, "Omni.SetActiveTable(" .. tostring(tbl) .. ")");
		tblCur = tbl;
		OmniEvents:Dispatch("TABLE_CURRENT_CHANGED", tbl);
	end
end

------------------------------
-- User Interface
------------------------------
-- "Totals" button
local function Analyze()
	if fdlg or (not dlg) or (not tblCur) then return; end
	local tbl = tblCur;

	local fdlg = VFLUI.Window:new(dlg);
	VFLUI.Window.SetDefaultFraming(fdlg, 22);
	fdlg:SetTitleColor(0,0,.6);
	fdlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	fdlg:SetPoint("CENTER", RDXParent, "CENTER");
	fdlg:SetWidth(200); fdlg:SetHeight(150);
	fdlg:SetText("Totals for Table: " .. tbl.name);
	fdlg:SetClampedToScreen(true);
	fdlg:Show();

	local lbl = VFLUI.MakeLabel(nil, fdlg, "Group By:");
	lbl:SetPoint("TOPLEFT", fdlg:GetClientArea(), "TOPLEFT");

	local checks = VFLUI.CheckGroup:new(fdlg);
	checks:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT"); checks:Show();
	checks:SetLayout(4, 1);
	checks.checkBox[1]:SetText("Event Type");
	checks.checkBox[2]:SetText("Source");
	checks.checkBox[3]:SetText("Target");
	checks.checkBox[4]:SetText("Ability");
	checks:SetWidth(190); checks:DialogOnLayout();

	local esch = function() fdlg:Destroy(); end
	VFL.AddEscapeHandler(esch);

	local btnClose = VFLUI.CloseButton:new(fdlg);
	fdlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnOK = VFLUI.OKButton:new(fdlg);
	btnOK:SetText("OK"); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", fdlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local cfg = {}; cfg.groupBy = {};
		for i=1,4 do if checks.checkBox[i]:GetChecked() then cfg.groupBy[i] = true; end end
		local nt = Omni.TotalsTransform(tbl, cfg);
		tbl.session:AddTable(nt);
		VFL.EscapeTo(esch);
	end);

	fdlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		checks:Destroy(); checks = nil;
		fdlg = nil;
	end, fdlg.Destroy);
end

local function AnalyzeMenu(tree, ...)
	local mnu = {
		{text = "Totals", OnClick = function() Analyze(); tree:Release(); end},
	};
	tree:Begin(120, 12, ...);
	tree:Expand(nil, mnu);
end

------------------------- Filter interface
local function Filter(parent)
	if fdlg or (not tblCur) then return; end
	local tbl = tblCur;

	local fdlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(fdlg, 22);
	fdlg:SetTitleColor(0,0,.6);
	fdlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	fdlg:SetPoint("CENTER", RDXParent, "CENTER");
	fdlg:SetWidth(360); fdlg:SetHeight(390);
	fdlg:SetText("Filter Table: " .. tbl.name);
	fdlg:SetClampedToScreen(true);
	fdlg:Show();

	local fe = Omni.FilterEditor:new(fdlg);
	fe:SetPoint("TOPLEFT", fdlg:GetClientArea(), "TOPLEFT");
	fe:Show();

	local esch = function() fdlg:Destroy(); end
	VFL.AddEscapeHandler(esch);

	local btnClose = VFLUI.CloseButton:new(fdlg);
	fdlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnOK = VFLUI.OKButton:new(fdlg);
	btnOK:SetText("OK"); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", fdlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local ff = Omni.FilterFunctor(fe:GetDescriptor());
		local nt = tbl:Filter(ff);
		tbl.session:AddTable(nt);
		VFL.EscapeTo(esch);
	end);

	fdlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		fe:Destroy(); fe = nil;
		fdlg = nil;
	end, fdlg.Destroy);
end

-- Time menu
local function TimeMenu(tree, ...)
	if not tblCur then return; end
	local mnu = {};
	if (not tblCur:IsImmutable()) then
		table.insert(mnu,{text = "Absolute", OnClick = function() tree:Release(); tblCur.displayTime = "ABSOLUTE"; OmniEvents:Dispatch("TABLE_DATA_CHANGED", tblCur);  end});
		table.insert(mnu,		{text = "Relative", OnClick = function() tree:Release(); tblCur.displayTime = "RELATIVE"; OmniEvents:Dispatch("TABLE_DATA_CHANGED", tblCur); end});
	end
	tree:Begin(120, 12, ...);
	tree:Expand(nil, mnu);
end

local mnu = {};
-------------------------------------- The table rightclick menu
local _tbl_mhdlrs = {};
function Omni.RegisterTableMenuHandler(func)
	if type(func) ~= "function" then error("Expected function"); end
	table.insert(_tbl_mhdlrs, func);
end

local function TableRightClick(cell, tbl, dialog)
	VFL.empty(mnu);
	for _,hdlr in ipairs(_tbl_mhdlrs) do
		hdlr(mnu, tbl, dialog);
	end
	VFL.poptree:Begin(120, 12, cell, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(cell));
	VFL.poptree:Expand(nil, mnu);
end

Omni.RegisterTableMenuHandler(function(mnu, tbl, dialog)
	if (not tbl:IsImmutable()) then
		table.insert(mnu, {text="Remove", OnClick = function() 
			VFL.poptree:Release();
			local x = tbl.session:RemoveTable(tbl);
			if (x == tblCur) then Omni.SetActiveTable(nil); end
		end});
		table.insert(mnu, {text="Rename", OnClick = function()
			VFL.poptree:Release();
			VFLUI.MessageBox("Rename " .. tbl.name, "Enter new name for table '" .. tbl.name .. "'", "", "Cancel", VFL.Noop, "OK", function(newName) Omni.RenameTable(tbl, newName); end);
		end});
	end
	if(tbl.session and tbl.session.name ~= "Saved Tables") then
		table.insert(mnu, {text="Save", OnClick = function()
			VFL.poptree:Release();
			local sts = Omni.GetSessionByName("Saved Tables"); if not sts then return; end
			sts:AddTable(tbl:MakeCopy());
		end});
	end
end);


--- Open the Omniscience interface.
Omni._RefreshActiveTable = VFL.Noop;
function Omni.Open(path)
	if dlg then return; end

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText("Omniscience");
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetHeight(550); dlg:SetWidth(842);
	dlg:SetClampedToScreen(true);

	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("browser_omniscience") then RDXPM.RestoreLayout(dlg, "browser_omniscience"); end
	local ca = dlg:GetClientArea();

	----------------------------------
	-- The table list
	----------------------------------
	local ctlTblList = VFLUI.List:new(dlg, 12, function()
		local c = VFLUI.Selectable:new();
		c:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		c.OnDeparent = c.Destroy;
		return c;
	end);
	ctlTblList:SetPoint("TOPLEFT", ca, "TOPLEFT",0,-25);
	ctlTblList:SetWidth(156); ctlTblList:SetHeight(500); 
	ctlTblList:Rebuild(); ctlTblList:Show();

	local tlist = {};
	ctlTblList:SetDataSource(VFLUI.Selectable.ApplyData_TextOnly, VFL.ArrayLiterator(tlist));
		
	local function CreateSessionEntry(sess)
		return {
			text = VFL.strcolor(0,0,1) .. sess.name .. "|r", 
			hlt = {r=0,g=0.5,b=1, a=.75},
			OnClick = function(self, arg1)
				if(arg1 == "RightButton") then
					local mnu = {};
					--------------------------------------- BEGIN SESSION RIGHTCLICK MENU -----------------------------------------
					table.insert(mnu, { text = "Clear", OnClick = function() sess:Clear(); Omni.SetActiveTable(nil); VFL.poptree:Release(); end });
					--------------------------------------- END SESSION RIGHTCLICK MENU ----------------------------------------
					VFL.poptree:Begin(120, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self)); VFL.poptree:Expand(nil, mnu);
				end
			end
		};
	end

	local function CreateTableEntry(sess, tbl, idx)
		local str = VFL.strcolor(0,1,0);
		str = str .. tbl.name .. "|r"
		local tinfo = { text = str, 
			OnClick = function(self, arg1)
				if(arg1 == "LeftButton") then
					Omni.SetActiveTable(tbl); 
				elseif(arg1 == "RightButton") then
					TableRightClick(self, tbl, dlg);
				end
			end 
		};
		if(tbl == tblCur) then tinfo.hlt = {r=0,g=0,b=1,a=0.5}; end
		return tinfo;
	end

	local function RefreshTableList()
		VFL.empty(tlist);
		for _,session in pairs(Omni.Sessions()) do
			table.insert(tlist, CreateSessionEntry(session));
			for idx,tbl in pairs(session:Tablespace()) do
				table.insert(tlist, CreateTableEntry(session, tbl, idx));
			end
		end
		ctlTblList:Update();
	end

	-----------------------------
	-- The table viewer
	-----------------------------
	local ctlTbl, mark = nil, nil;

	local ctlTbl = VFLUI.List:new(dlg, 10, function(x) return Omni._CreateCell(x, "Button"); end);
	ctlTbl:SetPoint("TOPLEFT", ctlTblList, "TOPRIGHT");
	ctlTbl:SetWidth(676); ctlTbl:SetHeight(500);
	ctlTbl:Rebuild(); ctlTbl:Show();
	
	-- Refresh the table viewer
	local function RefreshActiveTable()
		if (not ctlTbl) or (not tblCur) then return; end
		Omni:Debug(1, "Refreshing active table");
		ctlTbl:Update();
	end
	Omni._RefreshActiveTable = RefreshActiveTable;

	-- The "extra apply data" function
	local function ExtraApplyData(cell, data, pos)
		pos = pos - 1;
		if(pos == tblCur.mark) then
			cell.selTexture:SetVertexColor(0, 1, 1, 0.3);
			cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		-- Pass parameters down to the onclick function.
		cell._srcTbl = tblCur; cell._pos = pos; cell._time = data.t;
	end

	-- Update the viewer in response to a change of table.
	local function TableChanged()
		-- Clear out all dangling VFL windows
		VFL.Escape();
		-- Destroy the existing table viewer, marks, etc
		mark = nil;
		-- If our new table is nothing, we're done.
		if not tblCur then 
			ctlTbl:Hide();
			return; 
		end
		-- Otherwise, update our data source.
		ctlTbl:Show();
		Omni.SetupTable(ctlTbl, tblCur, ExtraApplyData);
		ctlTbl:SetScroll(0, true);
	end

	---------------------------
	-- Topbar
	---------------------------
	local ctlRefresh = VFLUI.Button:new(dlg);
	ctlRefresh:SetHeight(24); ctlRefresh:SetWidth(70);
	ctlRefresh:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, 0);
	ctlRefresh:SetText("Refresh");
	ctlRefresh:SetScript("OnClick", RefreshActiveTable);
	ctlRefresh:Show();
	
	local ctlTime = VFLUI.Button:new(dlg);
	ctlTime:SetHeight(24); ctlTime:SetWidth(70);
	ctlTime:SetPoint("LEFT", ctlRefresh, "RIGHT", 0, 0);
	ctlTime:SetText("Time");
	ctlTime:SetScript("OnClick", function(self) TimeMenu(VFL.poptree, self, "CENTER"); end);
	ctlTime:Show();

	local ctlFilter = VFLUI.Button:new(dlg);
	ctlFilter:SetHeight(24); ctlFilter:SetWidth(70);
	ctlFilter:SetPoint("LEFT", ctlTime, "RIGHT", 0, 0);
	ctlFilter:SetText("Filter");
	ctlFilter:SetScript("OnClick", function()
		Filter(dlg);
	end);
	ctlFilter:Show();

	local ctlAnalyze = VFLUI.Button:new(dlg);
	ctlAnalyze:SetHeight(24); ctlAnalyze:SetWidth(70);
	ctlAnalyze:SetPoint("LEFT", ctlFilter, "RIGHT", 0, 0);
	ctlAnalyze:SetText("Analyze");
	ctlAnalyze:SetScript("OnClick", function(self) AnalyzeMenu(VFL.poptree, self, "CENTER"); end);
	ctlAnalyze:Show();

	-- Bind events
	OmniEvents:Bind("SESSION_CREATED", nil, RefreshTableList, "oui");
	OmniEvents:Bind("SESSION_DELETED", nil, RefreshTableList, "oui");
	OmniEvents:Bind("SESSION_TABLE_ADDED", nil, RefreshTableList, "oui");
	OmniEvents:Bind("SESSION_TABLE_DELETED", nil, RefreshTableList, "oui");
	OmniEvents:Bind("SESSION_TABLE_RENAMED", nil, RefreshTableList, "oui");
	OmniEvents:Bind("SESSION_TABLE_ALTERED", nil, RefreshTableList, "oui");
	OmniEvents:Bind("TABLE_CURRENT_CHANGED", nil, TableChanged, "oui");
	OmniEvents:Bind("TABLE_CURRENT_CHANGED", nil, RefreshTableList, "oui");
	OmniEvents:Bind("TABLE_DATA_CHANGED", nil, function(tbl) 
		if (tbl == tblCur) then RefreshActiveTable(); end
	end, "oui");
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "browser_omniscience");
			dlg:Destroy(); dlg = nil;
		end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		esch();
	end
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	btnClose:SetScript("OnClick", function() esch(); end);
	dlg:AddButton(btnClose);

	dlg.Destroy = VFL.hook(function(s)
		OmniEvents:Unbind("oui");
		VFL.Escape();
		-- Destroy subtables
		if ctlTbl then ctlTbl:Destroy(); ctlTbl = nil; end
		if ctlTblList then ctlTblList:Destroy(); ctlTblList = nil; end
		tblCur = nil;
		-- Destroy the topbar
		if ctlRefresh then ctlRefresh:Destroy(); ctlRefresh = nil; end
		if ctlTime then ctlTime:Destroy(); ctlTime = nil; end
		if ctlFilter then ctlFilter:Destroy(); ctlFilter = nil; end
		if ctlAnalyze then ctlAnalyze:Destroy(); ctlAnalyze = nil; end

		-- Destroy the exported refresher function
		Omni._RefreshActiveTable = VFL.Noop;

		dlg = nil;
	end, dlg.Destroy);
	
	RefreshTableList();
end

function Omni.ToggleOmniBrowser(path, parent)
	if dlg then
		dlg:_esch();
	else
		Omni.Open(path, parent);
	end
end

