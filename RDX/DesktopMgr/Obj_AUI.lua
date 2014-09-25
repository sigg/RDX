-- OpenRDX
-- Sigg / Rashgarroth

-- AUI Adaptive User Interface or theme
-- Replacement of the old autoswitch desktop.

local function WriteAUI(dest, src)
	VFL.empty(dest);
	for k,v in pairs(src) do
		dest[k] = v;
	end
end

-- The AUI Editor
local dlg = nil;

function RDXDK.IsAUIEditorOpen()
	if dlg then return true; else return nil; end
end

function RDXDK.CloseAUIEditor()
	dlg:_esch();
end

function RDXDK.OpenAUIEditor(path, md, parent)
	if dlg then return; end
	if (not path) or (not md) or (not md.data) then return nil; end
	local inst = RDXDB.GetObjectInstance(path, true);
	local dk, pkg, file = RDXDB.ParsePath(path);
	local tmpdata = VFL.copy(md.data);
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(270); dlg:SetHeight(350);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText("List of layout in the theme " .. file);
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("AUI_editor") then RDXPM.RestoreLayout(dlg, "AUI_editor"); end
	
	local le_names = VFLUI.ListEditor:new(dlg, md.data, 
		function(cell,data) 
			cell.text:SetText(data);
		end, 
		nil,
		function(list, ty, ctl, txt) 
			if txt and txt ~= "" and not VFL.vfind(list, txt) then
				table.insert(list, txt);
				ctl:SetText("");
			else
				VFLUI.MessageBox("Error", "Enter something else please.");
			end
		end);
	le_names:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	le_names:SetWidth(260);	le_names:SetHeight(263); le_names:Show();
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);
	
	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "AUI_editor");
			dlg:Destroy(); dlg = nil;
		end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local function Save()
		local lst = le_names:GetList();
		if lst then			
			-- new layout are created
			for i, v in ipairs(lst) do
				local isexist2 = RDXDB.CheckObject(path .. "_" .. v, "Desktop");
				if not isexist2 then 
					RDXDB.Copy(file .. ":autodesk", path .. "_" .. v);
				end
			end
			
			local currentlayout = nil;
			-- search for old layout dropped
			for i, v in ipairs(tmpdata) do
				if not VFL.vfind(lst, v) then
					RDXDB.DeleteObject(path .. "_" .. v);
					-- check if we are deleting the current theme layout
					if v == RDXU.AUIState then currentlayout = true; end
				end
			end
			md.data = lst;
			if inst then WriteAUI(inst, lst); end
			-- in the case the current layout has been deleted, a reload ui is done.
			if currentlayout then
				RDXU.AUIState = "default";
				ReloadUI();
			end
			RDXDK.AUIList();
		end
		VFL.EscapeTo(esch);
	end
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	
	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		s._esch = nil;
		le_names:Destroy(); le_names = nil;
	end, dlg.Destroy);
end

function RDXDK.ToggleAUIEditor(path, md, parent)
	if dlg then
		RDXDK.CloseAUIEditor();
	else
		RDXDK.OpenAUIEditor(path, md, parent)
	end
end

-- The AUI object type.
RDXDB.RegisterObjectType({
	name = "AUI";
	invisible = true;
	New = function(path, md)
		md.version = 1;
	end; 
	Edit = function(path, md, parent)
		RDXDK.OpenAUIEditor(path, md, parent);
	end;
	Instantiate = function(path, md)
		if type(md.data) ~= "table" then return nil; end
		local inst = {};
		WriteAUI(inst, md.data);
		return inst;
	end;
	Deinstantiate = function(instance, path, md)
		VFL.empty(instance);
		instance = nil;
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});


-------------------------------------
-- Change AUI
-------------------------------------

local currentAUI = nil;

local function ChangeAUI(path, state, force)
	if RDXDK.IsAUIEditorOpen() then RDXDK.CloseAUIEditor() end
	RDX:Debug(3, "Change AUI " .. path);
	if RDXU.AUI == path and not force then
		if RDXU.AUIState == state then
			-- do nothing
		else
			RDXDK.SecuredChangeState(state);
		end
	else
		if currentAUI then
			RDXDB._RemoveInstance(RDXU.AUI);
			currentAUI = nil;
		end
		RDXU.AUI = path;
		currentAUI = RDXDB.GetObjectInstance(RDXU.AUI);
		if currentAUI then
			local _, _, auiname = RDXDB.ParsePath(RDXU.AUI);
			RDXDK.SecuredChangeState(state);
		end
		--RDXEvents:Dispatch("AUI", auiname);
	end
end

local newpath, newstate;
function RDXDK.SecuredChangeAUI(path, state, nosave)
	if not InCombatLockdown() then
		ChangeAUI(path, state, nosave); 
	else
		newpath = path;
		newstate = state;
	end
end

VFLEvents:Bind("PLAYER_COMBAT", nil, function(flag)
	if not flag and newpath then
		ChangeAUI(newpath, newstate);
		newpath = nil;
		newstate = nil;
	end
end);

-------------------------------------
-- Change STATE IN AUI
-------------------------------------

local function ChangeState(state)
	RDX:Debug(3, "Change AUI state " .. state);
	RDXU.AUIState = state;
	local inst = RDXDB.GetObjectInstance(RDXU.AUI);
	if inst then
		RDXDK.SecuredChangeDesktop(RDXU.AUI .. "_" .. state);
		VFLGC();
	end
end

local newstate;
function RDXDK.SecuredChangeState(state)
	if not InCombatLockdown() then
		ChangeState(state);
	else
		RDX:Debug(3, "AUI change state impossible");
		newstate = state;
	end
end

VFLEvents:Bind("PLAYER_COMBAT", nil, function(flag)
	if not flag and newstate then
		ChangeState(newstate);
		newstate = nil;
	end
end);

-----------------------------------------------------------------
-- Update hooks - make sure when a desktop changes we reload it.
-----------------------------------------------------------------

RDXDBEvents:Bind("PACKAGE_DELETED", nil, function(dk, pkg)
	local objdata = RDXDB._AccessPathRaw(dk, "desktops", pkg);
	
	if objdata and objdata.data then
		for i, v in ipairs(objdata.data) do
			RDXDB.DeleteObject(dk, "desktops:" .. pkg .. "_".. v);
		end
		RDXDB.DeleteObject(dk, "desktops:".. pkg);
	end
end);

----------------------------
-- INIT
----------------------------

RDXEvents:Bind("INIT_DESKTOP", nil, function()
	if not RDXU.AUI and not RDXDB.ResolvePath(RDXU.AUI) then RDXU.AUI = "RDXDiskSystem:desktops:default"; end
	if not RDXU.AUIState then RDXU.AUIState = "default"; end
	
	ChangeAUI(RDXU.AUI, RDXU.AUIState, true);
	
	if RDXG.RDXopt and RDXG.RDXopt.upp then
		SetCVar("uiScale", 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"));
	end
	
	if RDXG.RDXopt then
		local top, left, bottom, right = 0, 0, 0, 0;
		if RDXG.RDXopt.offsettop then top = tonumber(RDXG.RDXopt.offsettop); end
		if RDXG.RDXopt.offsetleft then left = tonumber(RDXG.RDXopt.offsetleft); end
		if RDXG.RDXopt.offsetbottom then bottom = tonumber(RDXG.RDXopt.offsetbottom); end
		if RDXG.RDXopt.offsetright then right = tonumber(RDXG.RDXopt.offsetright); end
		if top > 0 or left > 0 or bottom > 0 or right > 0 then
			RDXParent:ClearAllPoints();
			RDXParent:SetPoint("TOPLEFT", left, 0 - top);
			RDXParent:SetPoint("BOTTOMRIGHT", 0 - right, bottom);
		end
	end
	
	
end);

local function ManageAutoDesk()
	for pkg,dir in pairs(RDXDB.GetDisk("RDXDiskTheme")) do
		local aex, adesk, isexist = nil, nil, nil;
		adesk = dir["autodesk"];
		if adesk and adesk.ty == "Desktop" then
			isexist = RDXDB.CheckObject("RDXDiskSystem:desktops:".. pkg, "AUI");
			if not isexist then 
				local mbo = RDXDB.TouchObject("RDXDiskSystem:desktops:".. pkg);
				mbo.data = {};
				mbo.ty = "AUI"; 
				mbo.version = 2;
				table.insert(mbo.data, "default");
			else
				local mbo = RDXDB.TouchObject("RDXDiskSystem:desktops:".. pkg);
				if not VFL.vfind(mbo.data, "default") then
					table.insert(mbo.data, "default");
				end
			end
			local isexist2 = RDXDB.CheckObject("RDXDiskSystem:desktops:".. pkg .. "_default", "Desktop");
			if not isexist2 then 
				RDXDB.Copy("RDXDiskTheme:".. pkg .. ":autodesk", "RDXDiskSystem:desktops:".. pkg .. "_default");
			end
		end
	end
end
RDXDK.ManageAutoDesk = ManageAutoDesk;

-- Run all autodesk
RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	ManageAutoDesk();
end);

local function NewPackage_OnOK(x)
	if RDXDB.CreatePackage("RDXDiskTheme", x) then
		local default = RDXDB.GetOrCreatePackage("RDXDiskTheme", x);
		if not default["autodesk"] then
			default["autodesk"] = {
				["ty"] = "Desktop",
				["version"] = 2,
				["data"] = {
					{
						["strata"] = "LOW",
						["b"] = 0,
						["anchorxrid"] = 255.4666801982218,
						["uiscale"] = 0.8533333539962769,
						["dgp"] = true,
						["resolution"] = "1600",
						["feature"] = "Desktop main",
						["offsetbottom"] = 0,
						["bkd"] = {
							["bgFile"] = "Interface\\Addons\\VFL\\Skin\\a80black",
							["tileSize"] = 16,
							["tile"] = true,
							["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\HalBorder",
							["edgeSize"] = 8,
							["insets"] = {
								["top"] = 2,
								["right"] = 2,
								["left"] = 2,
								["bottom"] = 2,
							},
						},
						["l"] = 0,
						["offsettop"] = 0,
						["scale"] = 1,
						["offsetleft"] = 0,
						["offsetright"] = 0,
						["r"] = 1365.333426704711,
						["root"] = true,
						["t"] = 767.9999824928667,
						["alpha"] = 1,
						["anchoryrid"] = 465.386732369479,
						["title"] = "updated",
						["font"] = {
							["title"] = "Default 10pt",
							["color"] = {
								["r"] = 1,
								["g"] = 1,
								["b"] = 1,
							},
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["name"] = "Default10",
							["size"] = 10,
						},
						["name"] = "root",
						["open"] = true,
						["tex"] = {
							["color"] = {
								["a"] = 1,
								["b"] = 1,
								["g"] = 1,
								["r"] = 1,
							},
							["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
							["blendMode"] = "BLEND",
						},
						["anchorx"] = 285.333341904534,
						["anchory"] = 320.3201048020767,
						["ap"] = "TOPLEFT",
					}, -- [1]
				},
			};
		end
		ManageAutoDesk(x, default);
	end
end

function RDXDK.NewAUI()
	VFLUI.MessageBox(VFLI.i18n("Create New AUI"), VFLI.i18n("Enter name:"), "", VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), NewPackage_OnOK);
end

local wl = {};
local function BuildPackageList()
	VFL.empty(wl);
	for pkg,dir in pairs(RDXDB.GetDisk("RDXDiskTheme")) do
		local adesk = dir["autodesk"];
		if adesk and adesk.ty == "Desktop" then
			table.insert(wl, {text = pkg});
		end
	end
	table.sort(wl, function(x1,x2) return x1.text<x2.text; end);
	return wl;
end


local dlg2 = nil;
function RDXDK.DuplicateAUI()
	if dlg2 then return; end
	
	dlg2 = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg2, 22);
	dlg2:SetTitleColor(0,.6,0);
	dlg2:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg2:SetPoint("CENTER", RDXParent, "CENTER");
	dlg2:SetWidth(250); dlg2:SetHeight(125);
	dlg2:SetText("Duplicate a theme");
	VFLUI.Window.StdMove(dlg2, dlg2:GetTitleBar());
	if RDXPM.Ismanaged("rdx_duplicate_window") then RDXPM.RestoreLayout(dlg2, "rdx_duplicate_window"); end
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg2);
	sf:SetWidth(230); sf:SetHeight(70);
	sf:SetPoint("TOPLEFT", dlg2:GetClientArea(), "TOPLEFT");
	
	BuildPackageList();
	
	local er = VFLUI.EmbedRight(ui, VFLI.i18n("Select a theme"));
	local dd_pkg = VFLUI.Dropdown:new(er, BuildPackageList);
	dd_pkg:SetWidth(150); dd_pkg:Show();
	er:EmbedChild(dd_pkg); er:Show();
	ui:InsertFrame(er);
	
	local ed_newname = VFLUI.LabeledEdit:new(ui, 150); ed_newname:Show();
	ed_newname:SetText(VFLI.i18n("Enter a name"));
	ui:InsertFrame(ed_newname);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	dlg2:_Show(RDX.smooth);

	local esch = function()
		dlg2:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg2, "rdx_duplicate_window");
			dlg2:Destroy(); dlg2 = nil;
		end);
	end
	
	VFL.AddEscapeHandler(esch);
	function dlg2:_esch() VFL.EscapeTo(esch); end
	
	local btnClose = VFLUI.CloseButton:new(dlg2);
	dlg2:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	
	local btnOK = VFLUI.OKButton:new(dlg2);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", dlg2:GetClientArea(), "BOTTOMRIGHT", -15, 0);
	btnOK:SetText("OK"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local pkgname = dd_pkg:GetSelection();
		local new_name = ed_newname.editBox:GetText();
		RDXDB.CopyPackage(pkgname, new_name);
		ManageAutoDesk();
		VFL.EscapeTo(esch);
	end);

	-- Destructor
	dlg2.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg2.Destroy);
end


