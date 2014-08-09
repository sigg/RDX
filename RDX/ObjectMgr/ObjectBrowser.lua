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
	dlg:SetHeight(325); dlg:SetWidth(490);

	---------------- PREDECLARATIONS
	local pkgs, dir = {}, {}; -- Temp storage tables
	local UpdatePackageList, UpdateFileList, SetActivePackage, SelectFile;
	local fileFilter, FindFilterFile = VFL.True, VFL.True; -- Filter ops
	local PackageRightClick, ObjectRightClick = VFL.Noop, VFL.Noop; -- Click Funcs
	local pkgList, fileList = nil, nil;
	local activePkg, activeFile, selPkg, selFile = nil, nil, nil, nil;

	local function FilterFile(pkg, file, data)
		return FindFilterFile(pkg, file, data) and fileFilter(pkg, file, data);
	end

	local function FilterPackage(pkg)
		local pd = RDXDB.GetPackage(pkg);
		if not pd then return nil; end
		local i=0;
		for file,data in pairs(pd) do
			i=i+1;
			if FilterFile(pkg, file, data) then return true; end 
		end
		if(i == 0) and (FindFilterFile == VFL.True) then return true; end
		return nil;
	end

	---------------- Top side (current selection, finder)
	local selEd = VFLUI.Edit:new(dlg);
	selEd:SetHeight(25); selEd:SetWidth(300); selEd:SetPoint("TOPLEFT", dlg, "TOPLEFT");
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
	selFeedback:SetWidth(300);
	selFeedback:SetPoint("TOPLEFT", selEd, "BOTTOMLEFT", 5, 0);

	----------------- Finder implementation
	find:SetScript("OnTextChanged", function()
		local txt = find:GetText();
		if(not txt) or (txt == "") then
			FindFilterFile = VFL.True;
		else
			txt = string.lower(txt);
			function FindFilterFile(pkg, file, data)
				if (not data) then return nil; end
				if type(data) ~= "table" then return nil; end
				if data.ty == "SymLink" then 
					local v = RDXDB.AccessPath(pkg, file); 
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
		if not FilterPackage(activePkg) then activePkg = nil; end
		UpdatePackageList();
		UpdateFileList();
	end);

	----------------- Pathbar implementation
	selEd:SetScript("OnTextChanged", function()
		local txt = selEd:GetText();
		if(not txt) or (txt == "") then return; end
		local a,b = RDXDB.ParsePath(txt);
		if not a then selFeedback:SetText(VFLI.i18n("|cFFFF0000Invalid path.|r")); return; end
		if not RDXDB.GetPackage(a) then
			selFeedback:SetText(VFLI.i18n("|cFFFF0000Invalid package.|r")); SetActivePackage(nil);
			return;
		end
		SetActivePackage(a); selPackage = a;
		if (not b) or (not RDXDB.IsValidFileName(b)) then 
			selFeedback:SetText(VFLI.i18n("|cFFFF0000No filename specified.|r"));
			selFile = nil; fileList:Update();
			return; 
		end
		local qq = RDXDB.AccessPath(a,b);
		if (not FilterFile(a,b,qq)) then
			selFeedback:SetText(VFLI.i18n("|cFFFF0000File does not match filter.|r"));
			selFile = nil;
		else
			selFeedback:SetText("");
			selFile = b;
		end
		fileList:Update();
	end);

	----------------- Left side (package list)
	local decor1 = VFLUI.AcquireFrame("Frame");
	decor1:SetParent(dlg);
	decor1:SetBackdrop(VFLUI.BlackDialogBackdrop);
	decor1:SetPoint("TOPLEFT", selEd, "BOTTOMLEFT", 0, -25);
	decor1:SetWidth(150); decor1:SetHeight(250); decor1:Show();

	local lbl1 = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Packages:"));
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
				PackageRightClick(cell, data, dlg);
			end
		end);
	end, VFL.ArrayLiterator(pkgs));

	function UpdatePackageList()
		VFL.empty(pkgs); local i = 0;
		for k,_ in pairs(RDXDB.GetPackages()) do 
			if FilterPackage(k) then
				i=i+1; pkgs[i] = k;
			end
		end
		table.sort(pkgs, function(a,b) return a<b; end);
		pkgList:Update();
	end

	function SetActivePackage(pkg)
		if pkg ~= activePkg then
			VFL.poptree:Release(); -- release any dangling menus
			if FilterPackage(pkg) then 
				activePkg = pkg;
				selEd:SetText(activePkg .. ":");
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

	local lbl2 = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Package Contents:"));
	lbl2:SetPoint("TOPLEFT", decor2, "TOPLEFT", 3, 10);

	fileList = VFLUI.List:new(dlg, 12, VFLUI.Selectable.AcquireCell);
	fileList:SetPoint("TOPLEFT", decor2, "TOPLEFT", 5, -5);
	fileList:SetWidth(325); fileList:SetHeight(240); 
	fileList:Rebuild(); fileList:Show();
	
	fileList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data.text);
		if(activePkg == selPkg) and (data.name == selFile) then
			cell.selTexture:SetVertexColor(0,0,1); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		local fn = data.name;
		cell:SetScript("OnClick", function(self, arg1) 
			if(arg1 == "LeftButton") then
				SelectFile(activePkg, fn); 
			elseif(arg1 == "RightButton") then
				ObjectRightClick(cell, data.path, dlg);
			end
		end);
	end, VFL.ArrayLiterator(dir));

	function UpdateFileList()
		local pkg = RDXDB.GetPackage(activePkg);
		VFL.empty(dir);
		-- If the package is empty, early out
		if not pkg then fileList:Update(); return; end
		-- Iterate over all entries in the package
		local i,u,tbl = 0,nil;
		for k,v in pairs(pkg) do
			if (type(v) == "table") then
				tbl = {name = k, path = RDXDB.MakePath(activePkg, k)};
				-- Handle symlinks
				if v.ty == "SymLink" then
					if type(v.data) ~= "table" then 
						tbl.link = "error";
					else
						tbl.link = RDXDB.GetSymLinkTarget(v.data);
					end
					if not tbl.link then tbl.link = "error"; end
					v = RDXDB.AccessPath(activePkg, k); -- resolve the link
					if not v then
						tbl.version = 0; tbl.ty = "SymLink"; tbl.text = k .. " |cFFAAAAAA->|r |cFF00FFFF" .. tbl.link .. VFLI.i18n("|r |cFFFF0000(Broken link)|r");
						table.insert(dir, tbl);
					end
				end
				if v and FilterFile(activePkg, k, v) then
					tbl.ty = v.ty; tbl.version = v.version;
					if RDXDB.PathHasInstance(RDXDB.MakePath(activePkg, k)) then
						k = "|cFF00FF00" .. k .. "|r";
					end
					if tbl.link then
						tbl.text = k .. " |cFFAAAAAA->|r |cFF00FFFF" .. tbl.link .. "|r|cFFAAAAAA (" .. v.ty .. " v" .. v.version .. ")|r";
					else
						tbl.text = k .. "  |cFFAAAAAA(" .. v.ty .. " v" .. v.version .. ")|r";
					end
					table.insert(dir, tbl);
				end
			end
		end
		table.sort(dir, function(a,b) return (a.name)<(b.name); end);
		fileList:Update();
	end

	function SelectFile(a,b)
		if(a == selPkg) and (b == selFile) then return; end
		selPkg = a; selFile = b;
		selEd:SetText(RDXDB.MakePath(a,b));
	end

	----------------- Event handling
	RDXDBEvents:Bind("PACKAGE_CREATED", nil, UpdatePackageList, dlg);
	RDXDBEvents:Bind("PACKAGE_DELETED", nil, function(pkg)
		if(pkg == activePkg) then
			SetActivePackage(nil);
		end
		UpdatePackageList();
	end, dlg);
	RDXDBEvents:Bind("OBJECT_CREATED", nil, function(pkg)
		if pkg == activePkg then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg)
		if pkg == activePkg then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_MOVED", nil, function(srcPkg, _, dstPkg)
		if (srcPkg == activePkg) or (dstPkg == activePkg) then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(pkg)
		if pkg == activePkg then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_INSTANCIATED", nil, function(pkg)
		if pkg == activePkg then UpdateFileList(); end
	end, dlg);
	RDXDBEvents:Bind("OBJECT_DEINSTANCIATED", nil, function(pkg)
		if pkg == activePkg then UpdateFileList(); end
	end, dlg);

	----------------- API
	function dlg:SetFileFilter(func)
		if type(func) ~= "function" then return; end
		fileFilter = func;
	end
	function dlg:SetRightClickFunctions(pkgClick, fileClick)
		if (type(pkgClick) ~= "function") or (type(fileClick) ~= "function") then return; end
		PackageRightClick = pkgClick; ObjectRightClick = fileClick;
	end
	function dlg:Rebuild() UpdatePackageList(); UpdateFileList(); end
	function dlg:SetPath(initPath)
		if type(initPath) ~= "string" then return; end
		local a,b = RDXDB.ParsePath(initPath);
		if a and b then
			SetActivePackage(a);
			SelectFile(a,b);
		end
	end
	function dlg:GetPath()
		if selPkg and selFile then
			return RDXDB.MakePath(selPackage, selFile);
		else
			return nil;
		end
	end
	function dlg:GetPathRaw()
		return selEd:GetText();
	end
	function dlg:_GetSelection()
		return selPkg, selFile, activePkg, activeFile;
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
		decor1:Destroy(); decor2:Destroy();
		pkgList:Destroy(); fileList:Destroy(); pkgList = nil; fileList = nil;
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
	local a = string.find(name, ":");
        return string.sub(name, a + 1);
end

local function NewPackage_OnOK(x)
	_DisplayError(RDXDB.CreatePackage(x));
end
local function NewPackage()
	VFLUI.MessageBox(VFLI.i18n("Create Package"), VFLI.i18n("Enter package name:"), "", VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), NewPackage_OnOK);
end
local function CopyPackage(ppath)
	VFLUI.MessageBox(VFLI.i18n("Copy Package") .. ppath, VFLI.i18n("Enter new filename for the package at ") .. ppath, ppath, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) _DisplayError(RDXDB.CopyPackage(ppath, newname)); end);
end

local function CopyIntoPackage(ppath)
	VFLUI.MessageBox(VFLI.i18n("Copy Into Package: ") .. ppath, VFLI.i18n("Enter filename of the existing package ") .. ppath, ppath, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function(newname) _DisplayError(RDXDB.CopyIntoPackage(ppath, newname)); end);
end

local function CopyIntoAllPackages(ppath)
	VFLUI.MessageBox(VFLI.i18n("Copy Into All Packages: ") .. ppath, VFLI.i18n("Are you sure you want to copy all ?"), nil, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function() _DisplayError(RDXDB.CopyIntoAllPackages(ppath)); end);
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

local function PackageRightClick(cell, pkg, dialog)
	VFL.empty(mnu);
	for _,hdlr in ipairs(_pkg_mhdlrs) do
		hdlr(mnu, pkg, dialog);
	end
	VFL.poptree:Begin(120, 12, cell, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(cell));
	VFL.poptree:Expand(nil, mnu);
end

local function PkgDeleteHandler(pkg)
	local result,err = RDXDB.DeletePackage(pkg);
	if result then return; end
	if err == VFLI.i18n("Cannot delete non-empty package.") then
		VFLUI.MessageBox(VFLI.i18n("Delete Package: ") .. pkg, VFLI.i18n("The package ") .. pkg .. VFLI.i18n(" is not empty. Are you sure you want to delete it? WARNING: Deleting a package with objects that are in use can cause undefined behavior."), nil, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function() _DisplayError(RDXDB.DeletePackage(pkg, true)); end);
	else
		_DisplayError(result, err);
	end
end

RDXDB.RegisterPackageMenuHandler(function(mnu, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Copy"), func = function() VFL.poptree:Release(); CopyPackage(pkg); end
	});
end);

RDXDB.RegisterPackageMenuHandler(function(mnu, pkg, dialog)
	if string.find(pkg, "^template") then
		table.insert(mnu, {
			text = VFLI.i18n("Copy into"), func = function() VFL.poptree:Release(); CopyIntoPackage(pkg); end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Copy into all packages"), func = function() VFL.poptree:Release(); CopyIntoAllPackages(pkg); end
		});
	end
end);

RDXDB.RegisterPackageMenuHandler(function(mnu, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Delete"), func = function() VFL.poptree:Release(); PkgDeleteHandler(pkg); end
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
	--if RDXU.devflag then
		table.insert(mnu, {
			text = VFLI.i18n("Delete"), func = function() VFL.poptree:Release(); ConfirmDelete(opath); end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Rename"), func = function() VFL.poptree:Release(); Rename(opath); end
		});
	--end
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
	dlg:SetHeight(400); dlg:SetWidth(500);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText(VFLI.i18n("Repository Objects Browser"));
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetClampedToScreen(true);
	
	if RDXPM.Ismanaged("ObjectBrowser") then RDXPM.RestoreLayout(dlg, "ObjectBrowser"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	local ca = dlg:GetClientArea();

	local expl = RDXDB.ExplorerInstance:new(dlg);
	expl:SetPoint("TOPLEFT", ca, "TOPLEFT"); expl:Show();
	expl:SetFileFilter(fileFilter);
	expl:SetRightClickFunctions(PackageRightClick, ObjectRightClick);
	expl:Rebuild();
	
	---------------- Clipboard handling
	local clipboardPath, clipboardOp, btnPaste = nil, nil, nil;

	local function ClipboardCopy()
		local selPkg, selFile = expl:_GetSelection();
		if(not selPkg) or (not selFile) then return; end
		clipboardPath = RDXDB.MakePath(selPkg, selFile);
		clipboardOp = "COPY";
		btnPaste:Enable();
	end

	local function ClipboardPaste()
		local _, _, activePkg = expl:_GetSelection();
		if(not activePkg) then return; end
		if(clipboardOp == "COPY") then
			_DisplayError(RDXDB.CopyObject(clipboardPath, activePkg));
		elseif(clipboardOp == "CUT") then
		end
		clipboardOp = nil; clipboardPath = nil; btnPaste:Disable();
	end

	----------------- Control buttons
	local cbtn = nil ;
	
	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("New Package"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 0, 25);
	cbtn:SetScript("OnClick", NewPackage);
	
	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("Mass Send"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 0, 0);
	cbtn:SetScript("OnClick", function() RDX.MassIntegrate(dlg); end);
	
	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("New Object"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 160, 25);
	cbtn:SetScript("OnClick", function()
		local _, _, activePkg = expl:_GetSelection();
		if not activePkg then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Select a package to store the new object in."));
		else
			RDXDB.NewObjectDialog(dlg, activePkg);
		end
	end);

	cbtn = VFLUI.MakeButton(nil, dlg, VFLI.i18n("Copy"), 100);
	cbtn:SetPoint("TOPLEFT", expl, "BOTTOMLEFT", 260, 25);
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
