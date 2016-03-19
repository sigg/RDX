-- ObjectBrowser.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson

------------------------------------------------
-- Explorer Instance
--
-- An "instance" of the Explorer that can be specialized for multiple purposes.
------------------------------------------------
RDXDB.ExplorerInstance = {};
function RDXDB.ExplorerInstance:new(parent)
	local dlg = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(dlg, parent, 2);
	dlg:SetHeight(325); dlg:SetWidth(600);

	---------------- PREDECLARATIONS
	local dks, pkgs, dir = {}, {}, {}; -- Temp storage tables
	local UpdateDiskList, UpdatePackageList, UpdateFileList, SetActiveDisk, SetActivePackage, SelectFile;
	local fileFilter, FindFilterFile = VFL.True, VFL.True; -- Filter ops
	local DiskRightClick, PackageRightClick, ObjectRightClick = VFL.Noop, VFL.Noop; -- Click Funcs
	local dkList, pkgList, fileList = nil, nil, nil;
	local activeDk, activePkg, activeFile, selDk, selPkg, selFile = nil, nil, nil, nil, nil, nil;

	local function FilterFile(dk, pkg, file, data)
		return FindFilterFile(dk, pkg, file, data) and fileFilter(dk, pkg, file, data);
	end

	local function FilterPackage(dk, pkg)
		local pd = RDXDB.GetPackage(dk, pkg);
		if not pd then return nil; end
		local i=0;
		for file,data in pairs(pd) do
			i=i+1;
			if FilterFile(dk, pkg, file, data) then return true; end 
		end
		if(i == 0) and (FindFilterFile == VFL.True) then return true; end
		return nil;
	end
	
	local function Filterdisk(dk)
		local pd = RDXDB.GetDisk(dk);
		if not pd then return nil; end
		local i=0;
		for file,data in pairs(pd) do
			i=i+1;
			if FilterPackage(dk, pkg) then return true; end 
		end
		if(i == 0) and (FindFilterFile == VFL.True) then return true; end
		return nil;
	end

	---------------- Top side (current selection, finder)
	local selEd = VFLUI.Edit:new(dlg);
	selEd:SetHeight(25); selEd:SetWidth(400); selEd:SetPoint("TOPLEFT", dlg, "TOPLEFT");
	selEd:Show();

	local find = VFLUI.Edit:new(dlg);
	find:SetHeight(25); find:SetWidth(125); find:SetPoint("TOPRIGHT", dlg, "TOPRIGHT");
	find:Show();

	local magGlass = VFLUI.CreateTexture(dlg);
	magGlass:SetTexture("Interface\\Addons\\VFL\\Skin\\mag_glass.tga");
	magGlass:SetWidth(22); magGlass:SetHeight(22); magGlass:SetDrawLayer("ARTWORK");
	magGlass:SetPoint("RIGHT", find, "LEFT");
	magGlass:Show();

	local selFeedback = VFLUI.MakeLabel(nil, dlg, "");
	selFeedback:SetWidth(400);
	selFeedback:SetPoint("TOPLEFT", selEd, "BOTTOMLEFT", 5, 0);

	----------------- Finder implementation
	find:SetScript("OnTextChanged", function()
		local txt = find:GetText();
		if(not txt) or (txt == "") then
			FindFilterFile = VFL.True;
		else
			txt = string.lower(txt);
			function FindFilterFile(dk, pkg, file, data)
				if (not data) then return nil; end
				if type(data) ~= "table" then return nil; end
				if data.ty == "SymLink" then 
					local v = RDXDB.AccessPath(dk, pkg, file); 
					if v then 
						if string.find(string.lower(v.ty), txt, 1, true) then return true; end
					end
				elseif string.find(string.lower(file), txt, 1, true) or string.find(string.lower(data.ty), txt, 1, true)  then
					return true;
				else
					return nil;
				end
			end;
		end
		if not FilterPackage(activeDk, activePkg) then activePkg = nil; end
		if not Filterdisk(activeDk) then activeDk = nil; end
		UpdateDiskList();
		UpdatePackageList();
		UpdateFileList();
	end);

	----------------- Pathbar implementation
	--[[selEd:SetScript("OnTextChanged", function()
		local txt = selEd:GetText();
		if(not txt) or (txt == "") then return; end
		local a,b,c = RDXDB.ParsePath(txt);
		if not RDXDB.GetDisk(a) then 
			selFeedback:SetText(VFLI.i18n("|cFFFF0000Invalid disk.|r"));
			return;
		end
		if not RDXDB.GetPackage(a, b) then
			selFeedback:SetText(VFLI.i18n("|cFFFF0000Invalid folder.|r")); 
			return;
		end
		if (not c) then
			selFeedback:SetText(VFLI.i18n("|cFFFF0000No filename specified.|r"));
			return; 
		elseif (not RDXDB.IsValidFileName(c)) then 
			selFeedback:SetText(VFLI.i18n("|cFFFF0000Invalid filename.|r"));
			return; 
		end
		local qq = RDXDB.AccessPath(a,b,c);
		if (not FilterFile(a,b,c,qq)) then
			selFeedback:SetText(VFLI.i18n("|cFFFF0000File does not match filter.|r"));
		else
			-- symlink
			local obj = RDXDB._AccessPathRaw(a,b,c);
			if obj.ty == "SymLink" then
				local link
				if type(obj.data) ~= "table" then 
					link = "error";
				else
					link = RDXDB.GetSymLinkTarget(obj.data);
				end
				if not link then link = "error"; end
				local objl = RDXDB.AccessPath(a,b,c); -- resolve the link
				if not objl then
					selFeedback:SetText("|cFFAAAAAA|r |cFF00FFFF" .. link .. VFLI.i18n("|r |cFFFF0000(Broken link)|r"));
				else
					selFeedback:SetText(" |cFFAAAAAA|r |cFF00FFFF" .. link .. "|r|cFFAAAAAA (" .. objl.ty .. " v" .. objl.version .. ")|r");
				end
			else
				selFeedback:SetText("");
			end
		end
	end);]]
	----------------- Left side (disk list)
	local decor0 = VFLUI.AcquireFrame("Frame");
	decor0:SetParent(dlg);
	decor0:SetBackdrop(VFLUI.BlackDialogBackdrop);
	decor0:SetPoint("TOPLEFT", selEd, "BOTTOMLEFT", 0, -25);
	decor0:SetWidth(150); decor0:SetHeight(250); decor0:Show();
	
	local lbl0 = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Disks:"));
	lbl0:SetPoint("TOPLEFT", decor0, "TOPLEFT", 3, 10);
	
	dkList = VFLUI.List:new(dlg, 12, VFLUI.Selectable.AcquireCell)
	dkList:SetPoint("TOPLEFT", decor0, "TOPLEFT", 5, -5);
	dkList:SetWidth(140); dkList:SetHeight(240); 
	dkList:Rebuild(); dkList:Show();
	
	dkList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data);
		if(data == activeDk) then
			cell.selTexture:SetVertexColor(0,0,1); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		cell:SetScript("OnClick", function(self, arg1)
			if arg1 == "LeftButton" then
				SetActiveDisk(data); 
			elseif arg1 == "RightButton" then
				DiskRightClick(cell, data, dlg);
			end
		end);
	end, VFL.ArrayLiterator(dks));
	
	function UpdateDiskList()
		VFL.empty(dks); local i = 0;
		for k,_ in pairs(RDXDB.GetDisks()) do 
			--if Filterdisk(k) then
				i=i+1; dks[i] = k;
			--end
		end
		table.sort(dks, function(a,b) return a<b; end);
		dkList:Update();
	end
	
	function SetActiveDisk(dk)
		if dk ~= activeDk then
			VFL.poptree:Release(); -- release any dangling menus
			--if Filterdisk(dk) then 
				activeDk = dk;
				if activeDk then
					selEd:SetText(activeDk .. ":");
				end
				activePkg = nil;
				activeFile = nil;
			--else 
			--	activeDk = nil; 
			--end
			dkList:Update();
			UpdatePackageList()
			pkgList:Update();
			UpdateFileList();
		end
	end
	
	----------------- Left side (package list)
	local decor1 = VFLUI.AcquireFrame("Frame");
	decor1:SetParent(dlg);
	decor1:SetBackdrop(VFLUI.BlackDialogBackdrop);
	decor1:SetPoint("TOPLEFT", decor0, "TOPRIGHT", 5, 0);
	decor1:SetWidth(150); decor1:SetHeight(250); decor1:Show();

	local lbl1 = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Folders:"));
	lbl1:SetPoint("TOPLEFT", decor1, "TOPLEFT", 3, 10);

	pkgList = VFLUI.List:new(dlg, 12, VFLUI.Selectable.AcquireCell)
	pkgList:SetPoint("TOPLEFT", decor1, "TOPLEFT", 5, -5);
	pkgList:SetWidth(140); pkgList:SetHeight(240); 
	pkgList:Rebuild(); pkgList:Show();

	pkgList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data);
		if(data == activePkg) then
			cell.selTexture:SetVertexColor(0,0,1); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		cell:SetScript("OnClick", function(self, arg1)
			if arg1 == "LeftButton" then
				SetActivePackage(data); 
			elseif arg1 == "RightButton" then
				PackageRightClick(cell, activeDk,data, dlg);
			end
		end);
	end, VFL.ArrayLiterator(pkgs));

	function UpdatePackageList()
		VFL.empty(pkgs); local i = 0;
		if activeDk then
			for k,_ in pairs(RDXDB.GetDisk(activeDk)) do 
				if FilterPackage(activeDk, k) then
					i=i+1; pkgs[i] = k;
				end
			end
		end
		table.sort(pkgs, function(a,b) return a<b; end);
		pkgList:Update();
	end

	function SetActivePackage(pkg)
		if pkg ~= activePkg then
			VFL.poptree:Release(); -- release any dangling menus
			if FilterPackage(activeDk, pkg) then 
				activePkg = pkg;
				if activeDk and activePkg then
					selEd:SetText(activeDk .. ":" .. activePkg .. ":");
				elseif activeDk then
					selEd:SetText(activeDk .. ":");
				end
			else 
				activePkg = nil; 
			end
			pkgList:Update();
			UpdateFileList();
		end
	end

	----------------- Right side (content list)
	local decor2 = VFLUI.AcquireFrame("Frame");
	decor2:SetParent(dlg);
	decor2:SetBackdrop(VFLUI.BlackDialogBackdrop);
	decor2:SetPoint("TOPLEFT", decor1, "TOPRIGHT", 5, 0);
	decor2:SetWidth(335); decor2:SetHeight(250); decor2:Show();

	local lbl2 = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Files:"));
	lbl2:SetPoint("TOPLEFT", decor2, "TOPLEFT", 3, 10);

	fileList = VFLUI.List:new(dlg, 12, VFLUI.Selectable.AcquireCell);
	fileList:SetPoint("TOPLEFT", decor2, "TOPLEFT", 5, -5);
	fileList:SetWidth(325); fileList:SetHeight(240); 
	fileList:Rebuild(); fileList:Show();
	
	fileList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data.text);
		if (activeDk == selDk) and (activePkg == selPkg) and (data.name == selFile) then
			cell.selTexture:SetVertexColor(0,0,1); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		local fn = data.name;
		cell:SetScript("OnClick", function(self, arg1) 
			if(arg1 == "LeftButton") then
				SelectFile(activeDk, activePkg, fn); 
			elseif(arg1 == "RightButton") then
				ObjectRightClick(cell, data.path, dlg);
			end
		end);
	end, VFL.ArrayLiterator(dir));

	function UpdateFileList()
		local pkg = RDXDB.GetPackage(activeDk, activePkg);
		VFL.empty(dir);
		-- If the package is empty, early out
		if not pkg then fileList:Update(); return; end
		-- Iterate over all entries in the package
		local i,u,tbl = 0,nil;
		for k,v in pairs(pkg) do
			if (type(v) == "table") then
				tbl = {name = k, path = RDXDB.MakePath(activeDk, activePkg, k)};
				if v.data and v.data.Name then
					tbl.text = v.data.Name;
				end
				-- Handle symlinks
				if v.ty == "SymLink" then
					if type(v.data) ~= "table" then 
						tbl.link = "error";
					else
						tbl.link = RDXDB.GetSymLinkTarget(v.data);
					end
					if not tbl.link then tbl.link = "error"; end
					v = RDXDB.AccessPath(activeDk, activePkg, k); -- resolve the link
					if not v then
						tbl.version = 0; tbl.ty = "SymLink"; 
						tbl.text = k .. " |cFFAAAAAA->|r |cFF00FFFF" .. tbl.link .. VFLI.i18n("|r |cFFFF0000(Broken link)|r");
						table.insert(dir, tbl);
					end
				end
				if v and FilterFile(activeDk, activePkg, k, v) then
					tbl.ty = v.ty; tbl.version = v.version;
					if RDXDB.PathHasInstance(RDXDB.MakePath(activeDk, activePkg, k)) then
						k = "|cFF00FF00" .. k .. "|r";
					end
					if tbl.link then
						tbl.text = k .. " |cFFAAAAAA->|r |cFF00FFFF" .. tbl.link .. "|r|cFFAAAAAA (" .. v.ty .. " v" .. v.version .. ")|r";
					else
						if v.data and v.data.mf and v.data.mf.class and v.data.mf.Name then --MapInfo
							tbl.text = k .. "  |cFFAAAAAA(" .. v.ty .. " v" .. v.version .. ") " .. v.data.mf.class .. " " .. v.data.mf.Name .. "|r";
						else
							tbl.text = k .. "  |cFFAAAAAA(" .. v.ty .. " v" .. v.version .. ")|r";
						end
					end
					table.insert(dir, tbl);
				end
			end
		end
		table.sort(dir, function(a,b) return (a.name)<(b.name); end);
		fileList:Update();
	end

	function SelectFile(a,b,c)
		if (a == selDk) and (b == selPkg) and (c == selFile) then return; end
		local path = RDXDB.MakePath(a,b,c)
		selDk = a; selPkg = b; selFile = c;
		selEd:SetText(path);
		fileList:Update();
	end

	----------------- Event handling
	RDXDBEvents:Bind("PACKAGE_CREATED", nil, UpdatePackageList, dlg);
	RDXDBEvents:Bind("PACKAGE_DELETED", nil, function(dk, pkg)
		if (dk == activeDk) and (pkg == activePkg) then
			SetActivePackage(nil);
		end
		UpdatePackageList();
	end, dlg);
	RDXDBEvents:Bind("OBJECT_CREATED", nil, function(dk, pkg)
		if (dk == activeDk) and (pkg == activePkg) then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_DELETED", nil, function(dk, pkg)
		if (dk == activeDk) and (pkg == activePkg) then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_MOVED", nil, function(srcDk, srcPkg, _, dstDk, dstPkg)
		if (srcDk == activeDk) and ((srcPkg == activePkg) or (dstPkg == activePkg)) then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(dk, pkg)
		if (dk == activeDk) and (pkg == activePkg) then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_INSTANCIATED", nil, function(dk, pkg)
		if (dk == activeDk) and (pkg == activePkg) then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_DEINSTANCIATED", nil, function(dk, pkg)
		if (dk == activeDk) and (pkg == activePkg) then UpdateFileList(); end
	end, dlg);

	----------------- API
	function dlg:SetFileFilter(func)
		if type(func) ~= "function" then return; end
		fileFilter = func;
	end
	function dlg:SetRightClickFunctions(dkClick, pkgClick, fileClick)
		if (type(dkClick) ~= "function") or (type(pkgClick) ~= "function") or (type(fileClick) ~= "function") then return; end
		DiskRightClick = dkClick;
		PackageRightClick = pkgClick;
		ObjectRightClick = fileClick;
	end
	function dlg:Rebuild() UpdateDiskList(); UpdatePackageList(); UpdateFileList(); end
	function dlg:SetPath(initPath)
		if type(initPath) ~= "string" then return; end
		VFL.print(initPath);
		local a,b,c = RDXDB.ParsePath(initPath);
		if c then
			SetActiveDisk(a);
			SetActivePackage(b);
			SelectFile(a,b,c);
		end
	end
	function dlg:GetPath()
		if selDk and selPkg and selFile then
			return RDXDB.MakePath(selDk, selPkg, selFile);
		else
			return nil;
		end
	end
	function dlg:GetPathRaw()
		return selEd:GetText();
	end
	function dlg:_GetSelection()
		return selDk, selPkg, selFile, activeDk, activePkg, activeFile;
	end

	-- Embeddable feedback
	local okBtn, cancelBtn, fnOK, fnCancel, esch = nil, nil, nil, nil, nil;
	function dlg:EnableFeedback(okFunc, cancelFunc)
		if okBtn then return; end -- Can't EnableFeedback twice.
		fnOK = okFunc or VFL.Noop; fnCancel = cancelFunc or VFL.Noop;
		
		cancelBtn = VFLUI.CancelButton:new(self);
		cancelBtn:SetWidth(60); cancelBtn:SetHeight(25);
		cancelBtn:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
		cancelBtn:SetText(VFLI.i18n("Cancel"));
		cancelBtn:Show();

		okBtn = VFLUI.OKButton:new(self);
		okBtn:SetWidth(60); okBtn:SetHeight(25);
		okBtn:SetPoint("RIGHT", cancelBtn, "LEFT");
		okBtn:SetText(VFLI.i18n("OK"));
		okBtn:Show();

		esch = function() self:Destroy(); end
		VFL.AddEscapeHandler(esch);
		cancelBtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
		okBtn:SetScript("OnClick", function()
			fnCancel = nil;
			fnOK(self);
			VFL.EscapeTo(esch);
		end);
	end

	----------------- Close functionality
	dlg.Destroy = VFL.hook(function(s)
		-- Cancel if we need to.
		if esch then VFL.EscapeTo(esch, true); VFL.RemoveEscapeHandler(esch); esch = nil; end
		if fnCancel then fnCancel(s); fnCancel = nil; end

		-- Quash API
		s.SetFileFilter = nil; s.SetRightClickFunctions = nil;
		s.SetPath = nil; s.GetPath = nil; s.GetPathRaw = nil; s.EnableFeedback = nil;
		s._GetSelection = nil; s.Rebuild = nil;

		-- Remove events
		RDXDBEvents:Unbind(s);

		-- Destroy subobjects
		if okBtn then okBtn:Destroy(); okBtn = nil; end
		if cancelBtn then cancelBtn:Destroy(); cancelBtn = nil; end
		VFLUI.ReleaseRegion(magGlass); magGlass = nil;
		selEd:Destroy(); selEd = nil; find:Destroy(); find = nil;
		decor0:Destroy(); decor1:Destroy(); decor2:Destroy();
		dkList:Destroy(); pkgList:Destroy(); fileList:Destroy(); dkList = nil; pkgList = nil; fileList = nil;
	end, dlg.Destroy);

	return dlg;
end

------------------------------------------------
-- Manipulate a "popup" version of the explorer
------------------------------------------------
local xpop = nil;
function RDXDB.IsExplorerPopupOpen()
	return xpop;
end

function RDXDB.CloseExplorerPopup()
	if xpop then xpop:Destroy(); end
end

function RDXDB.ExplorerPopup(parent)
	RDXDB.CloseExplorerPopup();

	xpop = RDXDB.ExplorerInstance:new(VFLFULLSCREEN_DIALOG);
	xpop:SetClampedToScreen(true);
	xpop:SetBackdrop(VFLUI.WhiteBackdrop);
	xpop:SetBackdropColor(0,0,0.3,0.75);
	xpop.Destroy = VFL.hook(function(s)
		xpop = nil;
	end, xpop.Destroy);

	return xpop;
end

------------------------------------------------
-- Some helper functions
------------------------------------------------
local function _DisplayError(x1,x2)
	if not x1 then VFLUI.MessageBox(VFLI.i18n("Error"), x2); end
end

local function _sub2dots(name)
	local dk, pkg, file = RDXDB.ParsePath(name);
	return file;
end

local function NewPackage(dk)
	VFLUI.MessageBox(VFLI.i18n("Create Package"), VFLI.i18n("Enter package name:"), "", VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) _DisplayError(RDXDB.CreatePackage(dk, newname)); end);
end
local function CopyPackage(dk, ppath)
	VFLUI.MessageBox(VFLI.i18n("Copy Package") .. ppath, VFLI.i18n("Enter new filename for the package at ") .. ppath, ppath, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) _DisplayError(RDXDB.CopyPackage(dk, ppath, newname)); end);
end

local function MigratePackage(dk, pkg)
	VFLUI.MessageBox(VFLI.i18n("MigratePackage") .. pkg, VFLI.i18n("Enter new disk"), "RDXDiskTheme", VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) _DisplayError(RDXDB.MigratePackage(dk, pkg, newname, pkg)); end);
end

local function CopyIntoPackage(dk, pkg)
	VFLUI.MessageBox(VFLI.i18n("Copy Into Package: ") .. pkg, VFLI.i18n("Enter filename of the existing package ") .. pkg, pkg, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) _DisplayError(RDXDB.CopyIntoPackage(dk, pkg, newname)); end);
end

local function CopyIntoAllPackages(dk, pkg)
	VFLUI.MessageBox(VFLI.i18n("Copy Into All Packages"), VFLI.i18n("Are you sure you want to copy all ?"), nil, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function() _DisplayError(RDXDB.CopyIntoAllPackages(dk, pkg)); end);
end

local function DeleteConfirmed(opath)
 _DisplayError(RDXDB.DeleteObject(opath));
end
local function ConfirmDelete(opath)
	VFLUI.MessageBox(VFLI.i18n("Delete: ") .. opath, VFLI.i18n("Are you sure you want to delete the object at ") .. opath .. VFLI.i18n("?"), nil, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function() DeleteConfirmed(opath); end);
end

local function Rename(opath)
	VFLUI.MessageBox(VFLI.i18n("Rename: ") .. opath, VFLI.i18n("Enter new filename for the object at ") .. opath, _sub2dots(opath), VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) _DisplayError(RDXDB.RenameObject(opath, newname)); end);
end

---------------------------------------------------------
-- RIGHT-CLICK OPS MENUS
---------------------------------------------------------
-- Menu array
local mnu = {};

-------------------------- The disk rightclick menu
local _dk_mhdlrs = {};

--- Extend the menu that appears when you right click on a package.
-- The function you supply will be called with the following parameters:
--   F(menuTable, packageName, parentDialog)
-- and it should table.insert() any desired entries into the menuTable.
function RDXDB.RegisterDiskMenuHandler(func)
	if not func then error(VFLI.i18n("Expected function, got nil")); end
	table.insert(_dk_mhdlrs, func);
end

local function DiskRightClick(cell, dk, dialog)
	VFL.empty(mnu);
	for _,hdlr in ipairs(_dk_mhdlrs) do
		hdlr(mnu, dk, dialog);
	end
	VFL.poptree:Begin(120, 12, cell, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(cell));
	VFL.poptree:Expand(nil, mnu);
end

RDXDB.RegisterDiskMenuHandler(function(mnu, dk, dialog)
	if dk == "RDXData" then
		table.insert(mnu, {
			text = VFLI.i18n("Upgrade10"), func = function() VFL.poptree:Release(); RDXDB.Upgrade10() end
		});
	end
end);

-------------------------- The package rightclick menu
local _pkg_mhdlrs = {};

--- Extend the menu that appears when you right click on a package.
-- The function you supply will be called with the following parameters:
--   F(menuTable, packageName, parentDialog)
-- and it should table.insert() any desired entries into the menuTable.
function RDXDB.RegisterPackageMenuHandler(func)
	if not func then error(VFLI.i18n("Expected function, got nil")); end
	table.insert(_pkg_mhdlrs, func);
end

local function PackageRightClick(cell, dk, pkg, dialog)
	VFL.empty(mnu);
	for _,hdlr in ipairs(_pkg_mhdlrs) do
		hdlr(mnu, dk, pkg, dialog);
	end
	VFL.poptree:Begin(120, 12, cell, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(cell));
	VFL.poptree:Expand(nil, mnu);
end

local function PkgDeleteHandler(dk, pkg)
	local result,err = RDXDB.DeletePackage(dk, pkg);
	if result then return; end
	if err == VFLI.i18n("Cannot delete non-empty package.") then
		VFLUI.MessageBox(VFLI.i18n("Delete Package: ") .. pkg, VFLI.i18n("The package ") .. pkg .. VFLI.i18n(" is not empty. Are you sure you want to delete it? WARNING: Deleting a package with objects that are in use can cause undefined behavior."), nil, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function() _DisplayError(RDXDB.DeletePackage(dk, pkg, true)); end);
	else
		_DisplayError(result, err);
	end
end

RDXDB.RegisterPackageMenuHandler(function(mnu, dk, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Copy"), func = function() VFL.poptree:Release(); CopyPackage(dk, pkg); end
	});
end);

RDXDB.RegisterPackageMenuHandler(function(mnu, dk, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Migrate disk"), func = function() VFL.poptree:Release(); MigratePackage(dk, pkg); end
	});
end);

RDXDB.RegisterPackageMenuHandler(function(mnu, dk, pkg, dialog)
	if string.find(pkg, "^template") then
		table.insert(mnu, {
			text = VFLI.i18n("Copy into"), func = function() VFL.poptree:Release(); CopyIntoPackage(dk, pkg); end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Copy into all packages"), func = function() VFL.poptree:Release(); CopyIntoAllPackages(dk, pkg); end
		});
	end
end);

RDXDB.RegisterPackageMenuHandler(function(mnu, dk, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Delete"), func = function() VFL.poptree:Release(); PkgDeleteHandler(dk, pkg); end
	});
end);


--------------------------- The object rightclick menu
local _object_mhdlrs = {};

--- Extend the menu that appears when you right click on an object.
-- This SHOULD NOT BE USED for type specific handlers; use type.GenerateBrowserMenu
-- instead for those.
-- This should be used for global operations on files.
-- func is of the form F(menuTable, filePath, fileMetadata, parentDialog)
function RDXDB.RegisterObjectMenuHandler(func)
	if not func then error(VFLI.i18n("Expected function, got nil")); end
	table.insert(_object_mhdlrs, func);
end

local function ObjectRightClick(cell, opath, dialog)
	-- Symlink resolution
	local rpath = RDXDB.ResolvePath(opath);

	-- Build header
	VFL.empty(mnu);
	table.insert(mnu, { text = "|cFFAAAAAA" .. opath .. "|r" });
	if rpath ~= opath then
		table.insert(mnu, { 
			text = VFLI.i18n("Edit link");
			func = function() 
				VFL.poptree:Release();
				RDXDB.EditSymLink(opath, dialog); 
			end;
		});
	end

	-- Build ops
	for _,hdlr in ipairs(_object_mhdlrs) do
		hdlr(mnu, opath, md, dialog);
	end

	-- Build rest
	local md,_,_,_,ot = RDXDB.GetObjectData(rpath);
	if ot then
		if ot.GenerateBrowserMenu then
			ot.GenerateBrowserMenu(mnu, rpath, md, dialog);
		end
	end

	-- If we did any work, display the result
	if #mnu > 1 then
		VFL.poptree:Begin(120, 12, cell, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(cell));
		VFL.poptree:Expand(nil, mnu);
	end
end

-- Basic file ops.
RDXDB.RegisterObjectMenuHandler(function(mnu, opath, md, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Delete"), func = function() VFL.poptree:Release(); ConfirmDelete(opath); end
	});
	table.insert(mnu, {
		text = VFLI.i18n("Rename"), func = function() VFL.poptree:Release(); Rename(opath); end
	});
end);

------------------------------------------------
-- The object browser dialog
------------------------------------------------
local dlg = nil;

function RDXDB.IsObjectBrowserOpen()
	if dlg then return true; else return nil; end
end

function RDXDB.CloseBrowser()
	dlg:_esch();
end

function RDXDB.ObjectBrowser(parent, initPath, fileFilter)
	-- Don't open up a browser if there's already one open!
	if dlg then return; end

	dlg = VFLUI.Window:new(parent);
	dlg:SetHeight(400); dlg:SetWidth(660);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText(VFLI.i18n("Explorer"));
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetClampedToScreen(true);
	
	if RDXPM.Ismanaged("ObjectBrowser") then RDXPM.RestoreLayout(dlg, "ObjectBrowser"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	local ca = dlg:GetClientArea();

	local expl = RDXDB.ExplorerInstance:new(dlg);
	expl:SetPoint("TOPLEFT", ca, "TOPLEFT"); expl:Show();
	expl:SetFileFilter(fileFilter);
	expl:SetRightClickFunctions(DiskRightClick, PackageRightClick, ObjectRightClick);
	expl:Rebuild();
	
	---------------- Clipboard handling
	local clipboardPath, clipboardOp, btnPaste = nil, nil, nil;

	local function ClipboardCopy()
		local selDk, selPkg, selFile = expl:_GetSelection();
		if(not selPkg) or (not selFile) then return; end
		clipboardPath = RDXDB.MakePath(selDk, selPkg, selFile);
		clipboardOp = "COPY";
		btnPaste:Enable();
	end

	local function ClipboardPaste()
		local _, _, _, activeDk, activePkg = expl:_GetSelection();
		if(not activePkg) then return; end
		if(clipboardOp == "COPY") then
			_DisplayError(RDXDB.CopyObject(clipboardPath, activeDk, activePkg));
		elseif(clipboardOp == "CUT") then
		end
		clipboardOp = nil; clipboardPath = nil; btnPaste:Disable();
	end

	----------------- Control buttons
	local cbtn = nil ;
	
	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("New Folder"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 155, 25);
	cbtn:SetScript("OnClick", function()
		local selDk, selPkg, selFile, activeDk = expl:_GetSelection();
		if not activeDk then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Select a disk to create the folder"));
		else
			NewPackage(activeDk);
		end
	end);
	
	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("Mass Send"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 155, 0);
	cbtn:SetScript("OnClick", function()
		local _, _, _, activeDk, activePkg = expl:_GetSelection();
		if not activeDk then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Select a disk."));
		--elseif not activePkg then
		--	VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Select a package to store the new object in."));
		else
			--RDXDB.NewObjectDialog(dlg, activeDk, activePkg);
			RDX.MassIntegrate(dlg, dk);
		end
	end);
	
	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("New File"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 310, 25);
	cbtn:SetScript("OnClick", function()
		local _, _, _, activeDk, activePkg = expl:_GetSelection();
		if not activeDk then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Select a disk to store the new file in."));
		elseif not activePkg then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Select a package to store the new file in."));
		else
			RDXDB.NewObjectDialog(dlg, activeDk, activePkg);
		end
	end);

	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("Copy"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 410, 25);
	cbtn:SetScript("OnClick", ClipboardCopy);

	btnPaste = VFLUI.MakeButton(nil, dlg, VFLI.i18n("Paste"), 100);
	btnPaste:SetPoint("TOPLEFT", cbtn, "TOPRIGHT");
	btnPaste:Disable();
	btnPaste:SetScript("OnClick", ClipboardPaste);
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);
	
	-- Escapement
	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function() 
			RDXPM.StoreLayout(dlg, "ObjectBrowser");
			dlg:Destroy(); dlg = nil;
			if selCallback then selCallback(nil); end
		end);
	end;
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end

	local closebtn = VFLUI.CloseButton:new();
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	dlg.Destroy = VFL.hook(function(s)
		expl:Destroy();
	end, dlg.Destroy);
end

function RDXDB.ToggleObjectBrowser(parent, initPath, fileFilter)
	if dlg then
		RDXDB.CloseBrowser();
	else
		RDXDB.ObjectBrowser(VFLDIALOG, initPath, fileFilter)
	end
end
