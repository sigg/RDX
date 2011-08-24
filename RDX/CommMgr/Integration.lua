-- Integration.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- "Integration" is the act of merging remotely-acquired packages into the RDX
-- filesystem.


---------------------------------
-- INTEGRATION IMPLEMENTATION
---------------------------------
-- info package
local _infopkg = {};

local function _IntegrateAll(data)
end

local function _IntegrateSingleObject(data, path)
	if (not data) or (not path) then return nil; end
	local pkg, file = RDXDB.ParsePath(path);
	local new = false;
	if data[pkg] and data[pkg][file] then
		local src = data[pkg][file];
		-- Is the info package exist ?
		local infop = _infopkg[pkg];
		if infop then
			RDXDB.GetOrCreatePackage(pkg, infop["infoversion"], infop["infoname"], infop["inforealm"], infop["infoemail"], infop["infowebsite"], infop["infocomment"]);
		end
		
		-- Is this a new file?
		if RDXDB._AccessPathRaw(pkg, file) then new=false; else new=true; end
		-- Update the contents
		local lf = RDXDB.TouchObject(path);
		if lf then
			lf.ty = src.ty;
			lf.version = src.version;
			lf.data = VFL.copy(src.data);
			-- OK, we updated the contents; if it's a new file send OBJECT_CREATED, else send OBJECT_UPDATED.
			if new then
				RDXDBEvents:Dispatch("OBJECT_CREATED", pkg, file);
			else
				RDXDBEvents:Dispatch("OBJECT_UPDATED", pkg, file);
			end
		end
	end
end

local function _IntegrateChecklist(list, data)
	for _,entry in pairs(list) do
		if (type(entry) == "table") and entry.sel then
			_IntegrateSingleObject(data, entry.name);
		end
	end
end

---------------------------------
-- INTEGRATION FRONTEND
---------------------------------

local _ilist = {};
local function BuildIntegrationList(data)
	VFL.empty(_ilist); local i = 0;
	if not data then return; end
	for pkgName,pkgData in pairs(data) do
		for file,md in pairs(pkgData) do
			if type(md) == "table" then
				local dangerous = RDXDB.IsDangerousObject(md);
				local exists = RDXDB.AccessPath(pkgName, file);
				table.insert(_ilist, { 
					name = RDXDB.MakePath(pkgName, file), 
					exists = exists,
					dangerous = dangerous,
					sel = not (exists or dangerous),
				}); i=i+1;
			else
				_infopkg[pkgName] = {};
				_infopkg[pkgName][file] = md;
			end
		end
	end
	table.sort(_ilist, function(x1,x2) return x1.name < x2.name; end);
	return _ilist;
end

local dlg, integList, integData = nil, nil, nil;
function RDX.Integrate(parent, data, author, callback)
	if dlg then return nil; end

	callback = callback or VFL.Noop;
	integData = data;
	integList = BuildIntegrationList(data);
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetText(VFLI.i18n("Integration: ") .. tostring(author));
	dlg:SetPoint("LEFT", VFLParent, "LEFT", 25, 0);
	dlg:SetHeight(500); dlg:SetWidth(245);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar()); --raider
	dlg:Show();
	local ca = dlg:GetClientArea();

	local lbl = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Receiving the following objects from |cFF00FFFF") .. tostring(author) .. VFLI.i18n("|r. Objects highlighted in |cFFFF0000RED|r may contain executable Lua code. You should not accept these unless you trust the author. If you press Cancel, no objects will be integrated."));
	lbl:SetPoint("TOPLEFT", ca, "TOPLEFT");
	lbl:SetWidth(235); lbl:SetHeight(64);

	local SelectFile; -- Predeclaration for function
	
	------------------- List of stuff waiting to be integrated
	local fileList = VFLUI.List:new(dlg, 12, function(parent)
		local c = VFLUI.Checkbox:new(parent);
		c.button = VFLUI.AcquireFrame("Button");
		c.button:SetParent(c);
		c.button:SetPoint("TOPLEFT", c.check, "TOPRIGHT");
		c.button:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT");
		c.button:Show();
		c.Destroy = VFL.hook(function(s)
			s.button:Destroy(); s.button = nil;
		end, c.Destroy);
		c.OnDeparent = c.Destroy;
		return c;
	end);
	fileList:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
	fileList:SetWidth(235); fileList:SetHeight(380);
	fileList:Rebuild(); fileList:Show();
	fileList:SetDataSource(function(cell, data, pos)
		cell:SetText(data.name);
		if data.dangerous then
			cell:SetText("|cFFFF0000" .. data.name .. "|r");
		elseif data.exists then
			cell:SetText("|cFFFFFF00" .. data.name .. "|r");
		else
			cell:SetText(data.name);
		end
		cell:SetChecked(data.sel);
		cell.check:SetScript("OnClick", function(self) data.sel = self:GetChecked(); end);
		cell.button:SetScript("OnClick", function() SelectFile(data.name); end);
	end, VFL.ArrayLiterator(integList));
	fileList:Update();
	
	---------------------- View box
	local viewBox = VFLUI.TextEditor:new(dlg);
	viewBox:SetPoint("TOPLEFT", dlg, "TOPRIGHT");
	viewBox:SetWidth(400); viewBox:SetHeight(480); viewBox:Hide();

	function SelectFile(path)
		local pkg,file = RDXDB.ParsePath(path); if(not pkg) or (not file) then return; end
		local x = integData[pkg]; if not x then return; end
		x = x[file]; if not x then return; end
		viewBox:Show();
		viewBox:SetText(Serialize(x));
	end
	
	--------------------- Interact buttons
	local btnCancel = VFLUI.CancelButton:new(dlg);
	btnCancel:SetHeight(25); btnCancel:SetWidth(60);
	btnCancel:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnCancel:SetText(VFLI.i18n("Cancel")); btnCancel:Show();
	btnCancel:SetScript("OnClick", function()
		dlg:Destroy();
		integList = nil; integData = nil;
		callback(nil);
	end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("RIGHT", btnCancel, "LEFT");
	btnOK:SetText(VFLI.i18n("OK")); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		dlg:Destroy();
		_IntegrateChecklist(integList, integData);
		integList = nil; integData = nil;
		callback(true);
	end);

	local btnNone = VFLUI.Button:new(dlg);
	btnNone:SetHeight(25); btnNone:SetWidth(60);
	btnNone:SetPoint("RIGHT", btnOK, "LEFT");
	btnNone:SetText(VFLI.i18n("None")); btnNone:Show();
	btnNone:SetScript("OnClick", function()
		for _,v in ipairs(integList) do v.sel = nil; end
		fileList:Update();
	end);

	local btnAll = VFLUI.Button:new(dlg);
	btnAll:SetHeight(25); btnAll:SetWidth(60);
	btnAll:SetPoint("RIGHT", btnNone, "LEFT");
	btnAll:SetText(VFLI.i18n("All")); btnAll:Show();
	btnAll:SetScript("OnClick", function()
		for _,v in ipairs(integList) do v.sel = true; end
		fileList:Update();
	end);

	dlg.Destroy = VFL.hook(function(s)
		btnCancel:Destroy(); btnOK:Destroy(); btnNone:Destroy(); btnAll:Destroy();
		btnCancel = nil; btnOK = nil; btnNone = nil; btnAll = nil;
		fileList:Destroy(); fileList = nil;
		viewBox:Destroy(); viewBox = nil;
		dlg = nil;
	end, dlg.Destroy);

	return true;
end

--- Try to integrate a data set. Tries for 1 minute until the dialog is successfully displayed.
-- This can be used to defer a later integration while an earlier one is still in progress.
function RDX.TryIntegrate(parent, data, author, callback)
	local tries = 12;
	local function _doit()
		if (not RDX.Integrate(parent, data, author, callback)) and (tries > 0) then
			tries = tries - 1;
			VFLT.ZMSchedule(10, _doit);
		end
	end
	_doit();
end

---------------------------------------------------
-- INCOMING REMOTE INTEGRATION
-- Remote integration is the ability to send RDX packages over conferences.
---------------------------------------------------

local remoteIntegrationEnabled = true;

local function GeneralIntegrate(si, data, targets)
	if not remoteIntegrationEnabled then return; end
	if (not si) or (type(data) ~= "table") then
		RPC:Debug(1, "Received integrate with invalid parameters");
		return;
	end
	local myunit = RDXDAL.GetMyUnit();
	local name = si.sender;	if not name then RPC:Debug(1, "Ignoring integrate with unknown sender."); return; end
	-- Don't integrate my own stuff.
	if(name == myunit.name) then RPC:Debug(2, "Ignoring integrate from self."); end
	-- Check against allowedSenders and deniedSenders.
	local d = RDXDB.GetObjectData("default:allowedSenders");
	if d and d.data then
		if not VFL.vfind(d.data, name) then RPC:Debug(1, "Ignoring integrate from unallowed sender " .. name); return; end
	end
	d = RDXDB.GetObjectData("default:deniedSenders");
	if d and d.data then
		if VFL.vfind(d.data, name) then RPC:Debug(1, "Ignoring integrate from denied sender " .. name); return; end
	end
	-- Match against target list.
	-- This is not a very efficient way to do this, but it's rarely called so it shouldn't be a major issue.
	if type(targets) == "table" then
		local match = false;
		for _,targ in pairs(targets) do
			local p = targ:match("^%*class:(.*)$");
			if p and p == myunit:GetClassMnemonic() then match = true; break; end
			p = targ:match("^%*group:(%d+)$");
			if p and tonumber(p) == myunit:GetGroup() then match = true; break; end
			if targ == myunit.name then match = true; break; end
		end
		if not match then return; end
	end
	-- Do it
	RPC:Debug(2, "Integrating from user " .. name);
	RDX.TryIntegrate(VFLDIALOG, data, name);
end

-- Receive a package for integration
RPC.Bind("integrate", function(si, pn, pd)
	if not remoteIntegrationEnabled then return; end
	if not pn then
		RPC:Debug(2, "Ignoring integrate with nil package name.");
		return;
	end
	-- Ignore integrates with no table data
	if type(pd) ~= "table" then return; end

	local data = {};
	data[pn] = pd;
	GeneralIntegrate(si, data);
end);

-- Receive a mass integration
RPC.Bind("mintegrate", GeneralIntegrate);



--- Allow the user to enable/disable package transmission
local function EnableRcvPackage()
	remoteIntegrationEnabled = true;
	RDXU.rcvDisabled = nil;
end

local function DisableRcvPackage()
	remoteIntegrationEnabled = nil;
	RDXU.rcvDisabled = true;
end

local function ToggleRcvPackage()
	if not RDXU.rcvDisabled then 
		DisableRcvPackage();
		RDX.printI(VFLI.i18n("Disable Receiving Packages"));
	else 
		EnableRcvPackage();
		RDX.printI(VFLI.i18n("Enable Receiving Packages"));
	end
end

RDX.ToggleRcvPackage = ToggleRcvPackage;

function RDX.IsRcvDisable()
	return RDXU.rcvDisabled;
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	if RDXU.rcvDisabled then DisableRcvPackage(); else EnableRcvPackage(); end
end);

----------------------------------------------
-- OUTGOING REMOTE INTEGRATION
----------------------------------------------
--- Send the given package to the given conference.
function RPC.RemoteIntegrate(data, conf, targets)
	if(not conf) then return nil; end
	-- Verify the package contains data.
	if (not data) or (VFL.tsize(data) == 0) then return nil; end
	return conf:Invoke("mintegrate", data, targets);
end

local function _IntegrateSendUI(parent, data)
	if not data then return; end

	RDX.OpenRosterWindow(parent);

	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetText(VFLI.i18n("Send Files"));
	dlg:SetPoint("CENTER", VFLParent, "CENTER", 250, 0);
	dlg:SetHeight(260); dlg:SetWidth(250);
	
	if RDXPM.Ismanaged("integratesend") then RDXPM.RestoreLayout(dlg, "integratesend"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	--dlg:Show();
	local ca = dlg:GetClientArea();

	-- Conference picker
	local lbl = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Select a conference to send this data to."));
	lbl:SetPoint("TOPLEFT", ca, "TOPLEFT"); lbl:SetWidth(240);
	local cf = RPC.ConfFinder:new(dlg);
	cf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT"); cf:SetWidth(240); cf:Show();
	cf:SetConferenceID("GROUP");

	-- Target picker
	local lbl = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Drag and drop names, classes, or groups |cFF00FFFFfrom the RDX roster screen|r into the space below to send to specific people. Leave this blank to send to everyone."));
	lbl:SetPoint("TOPLEFT", cf, "BOTTOMLEFT"); lbl:SetHeight(40); lbl:SetWidth(240);
	local grid = VFLUI.Grid:new(dlg);
	grid:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT"); grid:Show();
	grid:Size(2, 10, VFLUI.Selectable.AcquireCell);
	grid:SetCellDimensions(120, 12);

	local function DragScript(cell)
		if cell.data then
			RDXUI.dc_RaidMembers:Drag(cell, VFLUI.CreateGenericDragProxy(cell, cell.text:GetText(), cell.data));
			cell.data = nil; cell.text:SetText("");
		end
	end
	local function DropScript(cell, dropped)
		cell.text:SetText(dropped:GetText() or "");
		cell.data = dropped.data;
	end

	for _,cell in grid:StatelessIterator() do
		cell:SetBackdrop(VFLUI.WhiteBackdrop);
		cell:SetBackdropColor(0.6, 0.6, 0.6, 0.25);
		cell:Show();
		-- Register all cells for drag/drop
		cell:SetScript("OnMouseDown", DragScript);
		cell.OnDrop = DropScript;
		cell.OnDragEnter = cell.LockHighlight; cell.OnDragLeave = cell.UnlockHighlight;
		RDXUI.dc_RaidMembers:RegisterDragTarget(cell);
	end

	local function CompileTargetArray()
		local ret = nil;
		for _,cell in grid:StatelessIterator() do
			if type(cell.data) == "string" then
				if not ret then ret = {}; end
				table.insert(ret, cell.data); 
			end
		end
		return ret;
	end

	dlg:Show(.2, true);

	-- Teardown
	local esch = function() 
		dlg:Hide(.2, true);
		VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "integratesend");
			dlg:Destroy(); dlg = nil;
		end);
	end
	VFL.AddEscapeHandler(esch);

	local btnCancel = VFLUI.CancelButton:new(dlg);
	btnCancel:SetText(VFLI.i18n("Cancel")); btnCancel:SetHeight(25); btnCancel:SetWidth(75);
	btnCancel:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnCancel:Show();
	btnCancel:SetScript("OnClick", function()
		VFL.EscapeTo(esch);
	end);
	
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText(VFLI.i18n("OK")); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("RIGHT", btnCancel, "LEFT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		RPC.RemoteIntegrate(data, cf:GetConference(), CompileTargetArray());
		VFL.EscapeTo(esch);
	end);

	dlg.Destroy = VFL.hook(function(s)
		for _,cell in grid:StatelessIterator() do
			cell.data = nil; cell.OnDrop = nil; cell.OnDragEnter = nil; cell.OnDragLeave = nil;
			RDXUI.dc_RaidMembers:UnregisterDragTarget(cell);
		end
		grid:Destroy(); grid = nil;
		cf:Destroy(); cf = nil;
		btnOK:Destroy(); btnOK = nil;
		btnCancel:Destroy(); btnCancel = nil;
		RDX.CloseRosterWindow();
	end, dlg.Destroy);
end

function RDX.MassIntegrate(parent)
	RDXDB.PackageListWindow(parent, VFLI.i18n("Bulk Package Send"), VFLI.i18n("Select packages to send."), VFL.True, function(pkgs)
		if not pkgs then return; end
		local idata = {};
		for pName,_ in pairs(pkgs) do
			idata[pName] = RDXData[pName];
		end
		_IntegrateSendUI(parent, idata);
	end);
end

-- Package send
RDXDB.RegisterPackageMenuHandler(function(mnu, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Send"), OnClick = function() 
			VFL.poptree:Release();
			local data = {};
			if pkg then data[pkg] = RDXData[pkg]; end
			_IntegrateSendUI(dialog, data); 
		end
	});
end);
-- Single object send
RDXDB.RegisterObjectMenuHandler(function(mnu, opath, md, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Send"), OnClick = function()
			VFL.poptree:Release();
			local pkg,file = RDXDB.ParsePath(opath);
			local data = {};
			if pkg then data[pkg] = {};
			data[pkg][file] = RDXData[pkg][file]; end
			_IntegrateSendUI(dialog, data);
		end
	});
end);

