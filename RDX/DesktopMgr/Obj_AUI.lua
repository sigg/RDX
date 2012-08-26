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
	dlg:SetWidth(430); dlg:SetHeight(300);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText("Manage AUI");
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("AUI_editor") then RDXPM.RestoreLayout(dlg, "AUI_editor"); end
	
	local solo = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	solo:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	solo:SetWidth(390); solo:Show();
	solo:SetPathWidth(250);
	solo:SetLabel("Solo Desktop:");
	solo:SetPath(md.data["solo"]);
	
	local chk_solo = VFLUI.Checkbox:new(dlg);
	chk_solo:SetPoint("LEFT", solo, "RIGHT");
	chk_solo:SetHeight(16); chk_solo:SetWidth(16);
	if md.data["soloflag"] then chk_solo:SetChecked(true); else chk_solo:SetChecked(); end
	chk_solo:Show();
	
	local group = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	group:SetPoint("TOPLEFT", solo, "BOTTOMLEFT");
	group:SetWidth(390); group:Show();
	group:SetPathWidth(250);
	group:SetLabel("Party Desktop:");
	group:SetPath(md.data["party"] or "");
	
	local chk_group = VFLUI.Checkbox:new(dlg);
	chk_group:SetPoint("LEFT", group, "RIGHT");
	chk_group:SetHeight(16); chk_group:SetWidth(16);
	if md.data["partyflag"] then chk_group:SetChecked(true); else chk_group:SetChecked(); end
	chk_group:Show();
	
	local raid = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	raid:SetPoint("TOPLEFT", group, "BOTTOMLEFT");
	raid:SetWidth(390); raid:Show();
	raid:SetPathWidth(250);
	raid:SetLabel("Raid Desktop:");
	raid:SetPath(md.data["raid"]);
	
	local chk_raid = VFLUI.Checkbox:new(dlg);
	chk_raid:SetPoint("LEFT", raid, "RIGHT");
	chk_raid:SetHeight(16); chk_raid:SetWidth(16);
	if md.data["raidflag"] then chk_raid:SetChecked(true); else chk_raid:SetChecked(); end
	chk_raid:Show();
	
	local pvp = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	pvp:SetPoint("TOPLEFT", raid, "BOTTOMLEFT");
	pvp:SetWidth(390); pvp:Show();
	pvp:SetPathWidth(250);
	pvp:SetLabel("PVP Desktop:");
	pvp:SetPath(md.data["pvp"]);
	
	local chk_pvp = VFLUI.Checkbox:new(dlg);
	chk_pvp:SetPoint("LEFT", pvp, "RIGHT");
	chk_pvp:SetHeight(16); chk_pvp:SetWidth(16);
	if md.data["pvpflag"] then chk_pvp:SetChecked(true); else chk_pvp:SetChecked(); end
	chk_pvp:Show();
	
	local arena = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	arena:SetPoint("TOPLEFT", pvp, "BOTTOMLEFT");
	arena:SetWidth(390); arena:Show();
	arena:SetPathWidth(250);
	arena:SetLabel("Arena Desktop:");
	arena:SetPath(md.data["arena"]);
	
	local chk_arena = VFLUI.Checkbox:new(dlg);
	chk_arena:SetPoint("LEFT", arena, "RIGHT");
	chk_arena:SetHeight(16); chk_arena:SetWidth(16);
	if md.data["arenaflag"] then chk_arena:SetChecked(true); else chk_arena:SetChecked(); end
	chk_arena:Show();
	
	local solo2 = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	solo2:SetPoint("TOPLEFT", arena, "BOTTOMLEFT");
	solo2:SetWidth(390); solo2:Show();
	solo2:SetPathWidth(250);
	solo2:SetLabel("Solo T2 Desktop:");
	solo2:SetPath(md.data["solo2"]);
	
	local chk_solo2 = VFLUI.Checkbox:new(dlg);
	chk_solo2:SetPoint("LEFT", solo2, "RIGHT");
	chk_solo2:SetHeight(16); chk_solo2:SetWidth(16);
	if md.data["soloflag2"] then chk_solo2:SetChecked(true); else chk_solo2:SetChecked(); end
	chk_solo2:Show();
	
	local group2 = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	group2:SetPoint("TOPLEFT", solo2, "BOTTOMLEFT");
	group2:SetWidth(390); group2:Show();
	group2:SetPathWidth(250);
	group2:SetLabel("Party T2 Desktop:");
	group2:SetPath(md.data["party2"] or "");
	
	local chk_group2 = VFLUI.Checkbox:new(dlg);
	chk_group2:SetPoint("LEFT", group2, "RIGHT");
	chk_group2:SetHeight(16); chk_group2:SetWidth(16);
	if md.data["partyflag2"] then chk_group2:SetChecked(true); else chk_group2:SetChecked(); end
	chk_group2:Show();
	
	local raid2 = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	raid2:SetPoint("TOPLEFT", group2, "BOTTOMLEFT");
	raid2:SetWidth(390); raid2:Show();
	raid2:SetPathWidth(250);
	raid2:SetLabel("Raid T2 Desktop:");
	raid2:SetPath(md.data["raid2"]);
	
	local chk_raid2 = VFLUI.Checkbox:new(dlg);
	chk_raid2:SetPoint("LEFT", raid2, "RIGHT");
	chk_raid2:SetHeight(16); chk_raid2:SetWidth(16);
	if md.data["raidflag2"] then chk_raid2:SetChecked(true); else chk_raid2:SetChecked(); end
	chk_raid2:Show();
	
	local pvp2 = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	pvp2:SetPoint("TOPLEFT", raid2, "BOTTOMLEFT");
	pvp2:SetWidth(390); pvp2:Show();
	pvp2:SetPathWidth(250);
	pvp2:SetLabel("PVP T2 Desktop:");
	pvp2:SetPath(md.data["pvp2"]);
	
	local chk_pvp2 = VFLUI.Checkbox:new(dlg);
	chk_pvp2:SetPoint("LEFT", pvp2, "RIGHT");
	chk_pvp2:SetHeight(16); chk_pvp2:SetWidth(16);
	if md.data["pvpflag2"] then chk_pvp2:SetChecked(true); else chk_pvp2:SetChecked(); end
	chk_pvp2:Show();
	
	local arena2 = RDXDB.ObjectFinder:new(dlg, function(p,f,md) return (md and type(md) == "table" and md.ty=="Desktop"); end);
	arena2:SetPoint("TOPLEFT", pvp2, "BOTTOMLEFT");
	arena2:SetWidth(390); arena2:Show();
	arena2:SetPathWidth(250);
	arena2:SetLabel("Arena T2 Desktop:");
	arena2:SetPath(md.data["arena2"]);
	
	local chk_arena2 = VFLUI.Checkbox:new(dlg);
	chk_arena2:SetPoint("LEFT", arena2, "RIGHT");
	chk_arena2:SetHeight(16); chk_arena2:SetWidth(16);
	if md.data["arenaflag2"] then chk_arena2:SetChecked(true); else chk_arena2:SetChecked(); end
	chk_arena2:Show();
	
	--local chk_autoswitch = VFLUI.Checkbox:new(dlg);
	--chk_autoswitch:SetPoint("TOPLEFT", arena2, "BOTTOMLEFT");
	--if md.data["autoswitch"] then chk_autoswitch:SetChecked(true); else chk_autoswitch:SetChecked(); end
	--chk_autoswitch:SetWidth(100);
	--chk_autoswitch:SetText("Autoswitch");
	--chk_autoswitch:Show();
	
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
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	
	-- OK
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:SetText("OK"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local ntable = {};
		ntable["solo"] = solo:GetPath();
		ntable["soloflag"] = chk_solo:GetChecked();
		ntable["party"] = group:GetPath();
		ntable["partyflag"] = chk_group:GetChecked();
		ntable["raid"] = raid:GetPath();
		ntable["raidflag"] = chk_raid:GetChecked();
		ntable["pvp"] = pvp:GetPath();
		ntable["pvpflag"] = chk_pvp:GetChecked();
		ntable["arena"] = arena:GetPath();
		ntable["arenaflag"] = chk_arena:GetChecked();
		ntable["solo2"] = solo2:GetPath();
		ntable["soloflag2"] = chk_solo2:GetChecked();
		ntable["party2"] = group2:GetPath();
		ntable["partyflag2"] = chk_group2:GetChecked();
		ntable["raid2"] = raid2:GetPath();
		ntable["raidflag2"] = chk_raid2:GetChecked();
		ntable["pvp2"] = pvp2:GetPath();
		ntable["pvpflag2"] = chk_pvp2:GetChecked();
		ntable["arena2"] = arena2:GetPath();
		ntable["arenaflag2"] = chk_arena2:GetChecked();
		--ntable["autoswitch"] = chk_autoswitch:GetChecked();
		--if ntable["autoswitch"] then SwitchDesktop(); end
		md.data = ntable;
		if inst then WriteAUI(inst, ntable); end
		VFL.EscapeTo(esch);
	end);
	
	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		solo:Destroy(); solo = nil;
		chk_solo:Destroy(); chk_solo = nil;
		group:Destroy(); group = nil;
		chk_group:Destroy(); chk_group = nil;
		raid:Destroy(); raid = nil;
		chk_raid:Destroy(); chk_raid = nil;
		pvp:Destroy(); pvp = nil;
		chk_pvp:Destroy(); chk_pvp = nil;
		arena:Destroy(); arena = nil;
		chk_arena:Destroy(); chk_arena = nil;
		solo2:Destroy(); solo2 = nil;
		chk_solo2:Destroy(); chk_solo2 = nil;
		group2:Destroy(); group2 = nil;
		chk_group2:Destroy(); chk_group2 = nil;
		raid2:Destroy(); raid2 = nil;
		chk_raid2:Destroy(); chk_raid2 = nil;
		pvp2:Destroy(); pvp2 = nil;
		chk_pvp2:Destroy(); chk_pvp2 = nil;
		arena2:Destroy(); arena2 = nil;
		chk_arena2:Destroy(); chk_arena2 = nil;
		--chk_autoswitch:Destroy(); chk_autoswitch = nil;
		s._esch = nil;
		btnOK:Destroy(); btnOK = nil;
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
				--RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});

-------------------------------------
-- Change AUI
-------------------------------------

local currentAUI = nil;

local function ChangeAUI(path, nosave)
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
		RDXDK.SecuredChangeState("default", true);
		RDXEvents:Dispatch("AUI", auiname);
	end
end

local newpath;
function RDXDK.SecuredChangeAUI(path, nosave)
	if not InCombatLockdown() then
		ChangeAUI(path, nosave); 
	else
		newpath = path;
	end
end

VFLEvents:Bind("PLAYER_COMBAT", nil, function(flag)
	if not flag and newpath then
		ChangeAUI(newpath);
		newpath = nil;
	end
end);

-------------------------------------
-- Change STATE IN AUI
-------------------------------------

local function ChangeState(state)
	RDX:Debug(3, "Change AUI state " .. state);
	RDXU.AUIState = state;
	local inst = RDXDB.GetObjectInstance(RDXU.AUI);
	if inst and inst[state] then
		RDXDK.SecuredChangeDesktop(inst[state]);
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
	
	ChangeAUI(RDXU.AUI);
	
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
			mbo.data = {
			};
			mbo.ty = "AUI"; 
			mbo.version = 2;
			local isexist2 = RDXDB.CheckObject("desktops:".. pkg .. "_default", "Desktop");
			if not isexist2 then 
				RDXDB.Copy(pkg .. ":autodesk", "desktops:".. pkg .. "_default");
				mbo.data["default"] = "desktops:".. pkg .. "_default";
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

RDXDB.RegisterObjectType({
	name = "DUI";
	isFeatureDriven = true;
	version = 2;
	VersionMismatch = function(md)
		md.version = 1;
		md.ty = "AUI";
	end,
});


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

