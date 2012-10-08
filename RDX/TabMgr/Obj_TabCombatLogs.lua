-- Obj_CombatLogs.lua
-- OpenRDX 
--

--
-- Helper
--

local olw = nil;
local olw_lines, olw_width = 20, 346;
local olw_bkd = { r=0,g=0,b=0,a=0.1 };
local zeropad = VFL.zeropad;

-- colspec
-- Time, Source, Target, HP, Amt, Ability, Misc
local function LastNLiterator(array, n)
	local function sz()
		return min(#array, n);
	end
	local function get(i)
		local z = #array;
		if(z < n) then
			return array[i];
		else
			return array[z - n + i];
		end
	end
	return sz, get;
end

------------------ Paint function
local function LWApplyData(tbl, cell, data, pos)
	local cols = cell.col;
	local rowType = data.y;
	local str = nil;
	local stWhole, stFrac;
	for i = 1, table.getn(cols) do
		if cols[i]._type == "Time" then
			if data.tm then
				--str = date("%H:%M:%S", data.tm);
				stWhole, stFrac = VFL.modf( (tbl.timeOffset + data.tm) / 10);
				str = date("%H:%M:%S", stWhole);
				--str = str .. string.format(".%1d", stFrac*10);
				cols[i]:SetText("|cFFAAAAAA" .. str .. "|r");
			end
		elseif cols[i]._type == "Source" then
			cols[i]:SetText(data.s or "");
		elseif cols[i]._type == "Target" then
			cols[i]:SetText(data.t or "");
		elseif cols[i]._type == "HP" then
			if data.uh then
				local pct = VFL.clamp(data.uh / data.uhm, 0, 1);
				tempcolor:blend(_red, _green, pct);
				cols[i]:SetText(zeropad(data.uh, 5, "|cFF333333", "|r" .. tempcolor:GetFormatString()) .. "|r"); --/" .. zeropad(data.uhm, 5, "|cFF333333", "|r"));
			else
				cols[i]:SetText("");
			end
		elseif cols[i]._type == "Amt" then
			if data.x then
				str = VFL.strtcolor(RDXMD.GetEventTypeColor(rowType)) .. tostring(data.x);
				if Omni.IsCritRow(data) then
					--cols[i]:SetFont(Fonts.Default.face, 12);
					str = str .. "!";
				else
					--cols[i]:SetFont(Fonts.Default.face, 10);
				end
				cols[i]:SetText(str .. "|r");
			else
				cols[i]:SetText("");
			end
		elseif cols[i]._type == "Ability" then
			cols[i]:SetText(Omni.GetAbilityString(data, rowType));
		elseif cols[i]._type == "Misc" then
			local str2 = RDXMD.GetExtdType(data.e);
			if str2 then
				str = "|cFF00FFFF[|r" .. str2 .. "|cFF00FFFF]|r " .. Omni.GetMiscString(data);
			else
				str = Omni.GetMiscString(data);
			end
			cols[i]:SetText(str);
		end
	end
end

-- Create the local session.
local localSess = Omni.Session:new("Local");
localSess.isLocal = true;

local n, row;

local function AddRow(x, log)
	--VFL.print("ADD");
	if x.filterFunc(nil, log) then
		n, row = #x.data, nil;
		if(n >= x.sizemax) then row = table.remove(x.data, 1); VFL.empty(row); else row = {}; end
		row = VFL.copy(log);
		row.sg = nil; row.tg = nil; 
		--VFL.print(row.tm);
		table.insert(x.data, row);
		OmniEvents:Dispatch("TABLE_DATA_CHANGED", x);
	end
end


-- Edit dialog
local dlg = nil;
local function EditCombatLogsDialog(parent, path, md)
	if dlg then
		RDX.printI(VFLI.i18n("A CombatLogs editor is already open. Please close it first."));
		return;
	end

	-- Sanity checks
	if (not path) or (not md) or (not md.data) then return nil; end

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(370); dlg:SetHeight(520);
	dlg:SetText(VFLI.i18n("Edit CombatLogs: ") .. path);
	if RDXPM.Ismanaged("CombatLogs") then RDXPM.RestoreLayout(dlg, "CombatLogs"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	dlg:Show();
	local ca = dlg:GetClientArea();
	
	local ed_name = VFLUI.LabeledEdit:new(ca, 150);
	ed_name:SetText(VFLI.i18n("Tab Title"));
	ed_name.editBox:SetText(md.data.title);
	ed_name:SetHeight(25); ed_name:SetWidth(250);
	ed_name:SetPoint("TOPLEFT", ca, "TOPLEFT");
	ed_name:Show();
	dlg.ed_name = ed_name;
	
	local ed_tabwidth = VFLUI.LabeledEdit:new(ca, 150);
	ed_tabwidth:SetText(VFLI.i18n("Tab Width"));
	ed_tabwidth.editBox:SetText(md.data.tabwidth);
	ed_tabwidth:SetHeight(25); ed_tabwidth:SetWidth(250);
	ed_tabwidth:SetPoint("TOPLEFT", ed_name, "BOTTOMLEFT");
	ed_tabwidth:Show();
	dlg.ed_tabwidth = ed_tabwidth;
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	--sf:SetWidth(346); sf:SetHeight(430);
	sf:SetWidth(370 - 16); sf:SetHeight(480 - 25);
	sf:SetPoint("TOPLEFT", ed_tabwidth, "BOTTOMLEFT");
	
	----------------- POPULATE
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Core parameters")));
	
	local ed_size = VFLUI.LabeledEdit:new(ui, 200); ed_size:Show();
	ed_size:SetText(VFLI.i18n("Table size"));
	if md.data and md.data.size then ed_size.editBox:SetText(md.data.size); else ed_size.editBox:SetText("0"); end
	ui:InsertFrame(ed_size);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));
	
	local chk_fe = VFLUI.Checkbox:new(ui); chk_fe:Show();
	chk_fe:SetText(VFLI.i18n("Use Filter"));
	if md.data and md.data.filter then chk_fe:SetChecked(true); else chk_fe:SetChecked(); end
	ui:InsertFrame(chk_fe);

	local fe = Omni.FilterEditor:new(dlg); fe:Show();
	fe:SetDescriptor(md.data.filters);
	ui:InsertFrame(fe);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	----------------- INTERACT
	local esch = function()
		RDXPM.StoreLayout(dlg, "CombatLogs");
		dlg:Destroy(); dlg = nil;
	end
	VFL.AddEscapeHandler(esch);

	local function Save()
		md.data.filter = chk_fe:GetChecked();
		if chk_fe:GetChecked() then 
			md.data.filters = fe:GetDescriptor();
		end
		md.data.title = ed_name.editBox:GetText();
		md.data.tabwidth = ed_tabwidth.editBox:GetText();
		-- See if this combatlogs was already instantiated...
		local inst = RDXDB.GetObjectInstance(path, true);
		if inst then
			inst:SetFilters(md.data);
			inst:SetTabOptions(md.data);
		end
		VFL.EscapeTo(esch);
	end
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	dlg.Destroy = VFL.hook(function(s)
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
		s.ed_tabwidth:Destroy(); s.ed_tabwidth = nil;
		s.ed_name:Destroy(); s.ed_name = nil;
	end, dlg.Destroy);
end

--------------------------------------------------
-- The object.
-- Provides slots for Create, Destroy, Show, and Hide events.
-- Based on the VFL Window object, which allows custom
-- framing.
--------------------------------------------------
RDX.CombatLogs = {};
function RDX.CombatLogs:new(path, desc)
	local obj = VFLUI.AcquireFrame("Frame");
	obj.path = path;
	
	-- create the table omni
	local x = Omni.Table:new(path);
	x.immutable = true;
	x.displayTime = "ABSOLUTE";
	x.source = UnitName("player");
	x.data = RDXGetTableLogs(path);
	x.timeOffset = 0;
	local sysEpoch = VFLT.GetSystemEpoch();
	if sysEpoch then
		x.timeOffset = math.modf(sysEpoch:GetKernelTimeCorrection() * 10);
	else
		VFLEvents:Bind("SYSTEM_EPOCH_ESTABLISHED", nil, function(syse)
			x.timeOffset = math.modf(syse:GetKernelTimeCorrection() * 10);
			VFLEvents:Unbind("omni_init");
		end, "omni_init");
	end
	x.sizemax = desc.size or 1000;
	x.path = path;
	x.filterFunc = function() return true; end;
	
	RDXEvents:Bind("LOG_ROW_ADDED", nil, function(logrow) AddRow(x, logrow); end, "omni" .. obj.path);
	localSess:AddTable(x);
	obj.table = x;
	
	--create the list
	local list = VFLUI.List:new(obj, 10, function(x) return Omni._CreateCell(x, "Frame"); end);
	list:SetPoint("CENTER", obj, "CENTER");
	list:SetScrollBarEnabled(true);
	list:SetScript("OnSizeChanged", function(self2) 
		self2:SetDataSource(
			function(cell, data, pos, absPos) LWApplyData(obj.table, cell, data, pos); end,
			LastNLiterator(obj.table.data, math.floor(self2:GetHeight() / 10))
		);
		self2:Rebuild();
		local ft = obj.font;
		if not ft then ft = Fonts.Default; end
		Omni._ApplyColSpecToList(self2, { 
			{ title = "Time", width = 60, font = ft },
			{ title = "Amt", width = 50, font = ft },
			{ title = "Ability", width = 195, font = ft },
			{ title = "Misc", width = 87, font = ft }
		});
		self2:Update();
	end);
	list:Show();
	OmniEvents:Bind("TABLE_DATA_CHANGED", nil, function(tbl) if tbl.path == obj.path then list:Update(); end; end, "omni" .. obj.path);
	obj.list = list;
	
	obj:SetScript("OnSizeChanged", function(self2)
		self2.list:SetWidth(self2:GetWidth() - 8);
		self2.list:SetHeight(self2:GetHeight() - 8);
	end);
	
	function obj:SetFilters(desc)
		if desc.filter then
			obj.table.filterFunc = Omni.FilterFunctor(desc.filters);
		else
			obj.table.filterFunc = function() return true; end;
		end
	end
	
	function obj:SetTabOptions(desc)
		if obj.tab then
			obj.tab.font:SetText(desc.title);
			obj.tab:SetWidth(desc.tabwidth);
		end	
	end

	obj.Destroy = VFL.hook(function(s)
		OmniEvents:Unbind("omni" .. s.path);
		RDXEvents:Unbind("omni" .. s.path);
		localSess:RemoveTable(s.table);
		s.table.filterFunc = nil;
		s.table.immutable = nil;
		s.table.displayTime = nil;
		s.table.source = nil;
		s.table.data = nil;
		s.table.timeOffset = nil;
		s.table.sizemax = nil;
		s.table.path = nil;
		s.table = nil;
		s.list:Destroy(); s.list = nil;
		s.SetFilters = nil;
		s.SetTabOptions = nil;
		s.path = nil;
	end, obj.Destroy);

	return obj;
end

-----------------------------------------------------------
-- Window meta-control
-----------------------------------------------------------
-- Master priming function for compiling windows.
local function SetupCombatLogs(path, cl, desc)
	if (not cl) or (not desc) then return nil; end
	cl:SetFilters(desc);
	cl:SetTabOptions(desc);
	return true;
end

-- Chatframe RDX object registration
RDXDB.RegisterObjectType({
	name = "TabCombatLogs";
	invisible = true;
	New = function(path, md)
		md.version = 1;
		md.data = {};
		md.data.title = "Combat";
		md.data.tabwidth = 80;
		md.data.size = 1000;		
	end;
	Edit = function(path, md, parent)
		EditCombatLogsDialog(parent or VFLDIALOG, path, md);
	end;
	Instantiate = function(path, md)
		local cl = RDX.CombatLogs:new(path, md.data);
		-- Attempt to setup the window; if it fails, just bail out.
		if not SetupCombatLogs(path, cl, md.data) then cl:Destroy(); return nil; end
		return cl;
	end,
	Deinstantiate = function(instance, path, md)
		instance:Destroy();
		instance = nil;
	end,
	OpenTab = function(tabbox, path, md, objdesc, desc)
		local f = RDXDB.GetObjectInstance(path);
		local tab = tabbox:GetTabBar():AddTab(md.data.tabwidth, function(self, arg1)
			tabbox:SetClient(f);
			VFLUI.SetBackdrop(f, desc.bkd);
			f.font = desc.font;
		end,
		function() end, 
		function(mnu, dlg) 
			return objdesc.GenerateBrowserMenu(mnu, path, nil, dlg)
		end);
		tab.f = f;
		return tab;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function() 
				VFL.poptree:Release(); 
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Analyse");
			OnClick = function()
				VFL.poptree:Release();
				local inst = RDXDB.GetObjectInstance(path, true);
				if inst then
					Omni.Open();
					Omni.SetActiveTable(inst.table);
				end
			end;
		});
	end;
});

--------------- Tab Manager

RDXPM.RegisterTabCategory(VFLI.i18n("CombatLogs"));

------------------------------------------
-- Update hooks
------------------------------------------
RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg, file, md)
	if md and md.ty == "TabCombatLogs" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "CombatLogs")
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(pkg, file, newpkg, newfile, md)
	if md and md.ty == "TabCombatLogs" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "CombatLogs")
	end
end);
RDXDBEvents:Bind("OBJECT_CREATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabCombatLogs" then
		local data = obj.data;
		local tit = "";
		if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("CombatLogs");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);
RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabCombatLogs" then
		RDXPM.UnregisterTab(path, "CombatLogs");
		local data = obj.data;
		local tit = "";
		if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("CombatLogs");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);

-- run on UI load 
local function RegisterTabCombatLogs()
	for pkgName,pkg in pairs(RDXData) do
		for objName,obj in pairs(pkg) do
			if type(obj) == "table" and obj.ty == "TabCombatLogs" then 
				local path = RDXDB.MakePath(pkgName, objName);
				local data = obj.data;
				local tit = "";
				if data then tit = obj.data.title; end
				RDXPM.RegisterTab({
					name = path;
					title = path .. " " .. tit;
					category = VFLI.i18n("CombatLogs");
					GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
					GetBlankDescriptor = function() return {op = path}; end;
				});
			end
		end
	end
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	RegisterTabCombatLogs();
end);
