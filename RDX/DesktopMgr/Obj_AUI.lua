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
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(270); dlg:SetHeight(350);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText("Manage AUI");
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("AUI_editor") then RDXPM.RestoreLayout(dlg, "AUI_editor"); end
	
	local le_names = VFLUI.ListEditor:new(dlg, md.data, function(cell,data) 
		cell.text:SetText(data);
	end);
	le_names:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	le_names:SetWidth(260);	le_names:SetHeight(263); le_names:Show();
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "AUI_editor");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local function Save()
		local lst = le_names:GetList();
		VFL.EscapeTo(esch);
		if lst then
			md.data = lst;
			for i, v in ipairs(lst) do
				local isexist2 = RDXDB.CheckObject(path .. "_" .. v, "Desktop");
				local pkg, file = RDXDB.ParsePath(path);
				if not isexist2 then 
					RDXDB.Copy(file .. ":autodesk", path .. "_" .. v);
				end
			end
			if inst then WriteAUI(inst, lst); end
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
			OnClick = function()
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

local function ChangeAUI(path, state, nosave)
	if RDXDK.IsAUIEditorOpen() then RDXDK.CloseAUIEditor() end
	RDX:Debug(3, "Change AUI " .. path);
	-- close
	if currentAUI then
		RDXDB._RemoveInstance(RDXU.AUI);
		currentAUI = nil;
	end
	RDXU.AUI = path;
	currentAUI = RDXDB.GetObjectInstance(RDXU.AUI);
	if currentAUI then
		local _, auiname = RDXDB.ParsePath(RDXU.AUI);
		RDXDK.SecuredChangeState(state);
		RDXEvents:Dispatch("AUI", auiname);
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

--RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg, file, md)
--	local path = RDXDB.MakePath(pkg,file);
--	if md and md.ty == "AUI" and path ~= RDXU.AUI then
		--RDXDK.SecuredChangeDUI("desktops:");
--	end
--end);

--RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(pkg, file) 
--	local path = RDXDB.MakePath(pkg,file);
--	local _,_,_,ty = RDXDB.GetObjectData(path)
--	if ty == "DUI" and path == RDXU.DUI then 
		--RDXDK.SecuredChangeDUI(path);
--	end
--end);

----------------------------
-- INIT
----------------------------

RDXEvents:Bind("INIT_DESKTOP", nil, function()
	if not RDXU.AUI and not RDXDB.ResolvePath(RDXU.AUI) then RDXU.AUI = "desktops:default"; end
	if not RDXU.AUIState then RDXU.AUIState = "default"; end
	
	ChangeAUI(RDXU.AUI, RDXU.AUIState);
	
	if RDXG.RDXopt and RDXG.RDXopt.upp then
		SetCVar("uiScale", 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"));
	end
end);

local function ManageAutoDesk(pkg, dir)
	local aex, adesk, isexist = nil, nil, nil;
	adesk = dir["autodesk"];
	if adesk and adesk.ty == "Desktop" then
		isexist = RDXDB.CheckObject("desktops:".. pkg, "AUI");
		if not isexist then 
			local mbo = RDXDB.TouchObject("desktops:".. pkg);
			mbo.data = {};
			mbo.ty = "AUI"; 
			mbo.version = 2;
			local isexist2 = RDXDB.CheckObject("desktops:".. pkg .. "_default", "Desktop");
			if not isexist2 then 
				RDXDB.Copy(pkg .. ":autodesk", "desktops:".. pkg .. "_default");
				table.insert(mbo.data, "default");
			end
		end
	end
end

-- Run all autodesk
RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	for pkg,dir in pairs(RDXDB.GetPackages()) do
		ManageAutoDesk(pkg, dir);
	end
end);

local function NewPackage_OnOK(x)
	if RDXDB.CreatePackage(x) then
		local default = RDXDB.GetOrCreatePackage(x);
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

