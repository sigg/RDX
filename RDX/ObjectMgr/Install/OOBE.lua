-- OOBE.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL. UNLICENSED COPYING IS PROHIBITED.
--
-- Implementation for the OOBE (out-of-box experience) package and desktop auto-installer.
--
-- The installer will bring up a "wizard" dialog when RDX is first loaded, or when a new
-- external package is detected.

local function IsLocalObject(x)
	local l = RDXU.oobe; if not l then return nil; end
	return l[x];
end

local function IsGlobalObject(x)
	local g = RDXG.oobe; if not g then return nil; end
	return g[x];
end

-- Get the version of an OOBE object.
function RDX.GetOOBEObjectVersion(x)
	local v = IsLocalObject(x);
	if v then return v; else return IsGlobalObject(x); end
end

function RDX.CheckOOBEObjectVersion(x, vt, strict)
	local v = IsLocalObject(x);
	if not v then v = IsGlobalObject(x); end
	if not v then return nil; else return true; end
--[[
	if strict then
		return (v == vt);
	else
		return (v >= vt);
	end
]]--
end

-- Drop one OOBE
function RDX.ClearInstaller(name)
	if RDXU then RDXU.oobe[name] = nil; end
	if RDXU then RDXU.installers[name] = nil; end
	if RDXG then RDXG.oobe[name] = nil; end
end

-- Clear all installer data
function RDX.ClearInstallerData()
	if RDXU then RDXU.oobe = {}; RDXU.installers = {}; end
	if RDXG then RDXG.oobe = {}; end
end

---------------------------------------------
-- INSTALLER TOGGLES SYSTEM
---------------------------------------------
local toggles = {};

local function ClearToggles()
	VFL.empty(toggles);
end

-- Perform exclusion
local excluded = {};
local function ComputeExclusion()
	-- Compute excluded categories
	VFL.empty(excluded);
	excluded["disabled"] = true;
	for _,tog in pairs(toggles) do
		if tog.sel then
			for _,cat in pairs(tog.excludeCategories) do
				excluded[cat] = true;
			end
		end
	end
	-- Uncheck and disable everything that's excluded
	for _,tog in pairs(toggles) do
		for cat,_ in pairs(tog.categories) do
			if excluded[cat] then
				tog.disabled = true; tog.sel = nil;
			else
				tog.disabled = nil;
			end
		end
	end
end

-- Clear all toggles in a given category
local function Uniquize(cat)
	for _,tog in pairs(toggles) do
		if tog.categories[cat] then
			tog.sel = nil;
		end
	end
end

local function ToggleStateChanged(ctl, curTog, state)
	--if curTog.text == "Install WoWtootRDX" then curTog.sel = true; ctl:Update(); return; end
	ComputeExclusion();
	for _,cat in pairs(curTog.uniqueCategories) do
		Uniquize(cat);
	end
	if(not curTog.disabled) then curTog.sel = state; else curTog.sel = nil; end
	ctl:Update();
end

local function ShowInstallerDialog(title, text, onOK, onCancel, onDecline)
	onOK = onOK or VFL.Noop;

	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(260); dlg:SetHeight(285);
	dlg:SetTitleColor(0,0,0.6); dlg:SetText(VFLI.i18n("RDX Installer")); 
	dlg:Show();
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());

	local txt = VFLUI.CreateFontString(dlg);
	txt:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	txt:SetWidth(250); txt:SetHeight(30);
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP");
	txt:SetFontObject(Fonts.Default10);
	txt:Show(); txt:SetText(text);

	local cl = VFLUI.CheckList:new(dlg, toggles);
	cl:SetPoint("TOPLEFT", txt, "BOTTOMLEFT");
	cl:SetWidth(250); cl:SetHeight(216); cl:Rebuild(); cl:Show();
	cl.OnClick = ToggleStateChanged;
	cl:Update();

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:SetText(VFLI.i18n("OK")); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		dlg:Destroy();
		onOK();
	end);

	--local btnCancel = nil;
	--if onCancel then
	--	btnCancel = VFLUI.CancelButton:new(dlg);
	--	btnCancel:SetHeight(25); btnCancel:SetWidth(60);
	--	btnCancel:SetPoint("RIGHT", btnOK, "LEFT");
	--	btnCancel:SetText(VFLI.i18n("Cancel")); btnCancel:Show();
	--	btnCancel:SetScript("OnClick", function()
	--		dlg:Destroy();
	--		onCancel();
	--	end);
	--end

	local btnDecline = nil;
	if onCancel and onDecline then
		btnDecline = VFLUI.CancelButton:new(dlg);
		btnDecline:SetHeight(25); btnDecline:SetWidth(60);
		btnDecline:SetPoint("RIGHT", btnOK, "LEFT");
		btnDecline:SetText(VFLI.i18n("Decline")); btnDecline:Show();
		btnDecline:SetScript("OnClick", function()
			dlg:Destroy();
			onDecline();
		end);
	end

	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		--if btnCancel then btnCancel:Destroy(); btnCancel = nil; end
		--if btnDecline then btnDecline:Destroy(); btnDecline = nil; end
		VFLUI.ReleaseRegion(txt); txt = nil;
		cl:Destroy(); cl = nil;
	end, dlg.Destroy);
end


---------------------------------------------
-- INSTALLER CORE
---------------------------------------------
local installs = {}; -- installer storage
local rlui_flag = nil; -- Do we need to reload ui?
local loadedOOBEs = nil; -- What version(s) of installer addons were loaded?
local cur_oobe_version = nil; -- The version number of the currently loaded OOBE.
function RDX.OOBESetReloadUI() rlui_flag = true; end

-- Install object data into the file system
local function InstallData(data)
	if type(data) ~= "table" then return; end
	-- Integrate
	for pkgName, pkgData in pairs(data) do
		for objName, objData in pairs(pkgData) do
			RDXDB.GetOrCreatePackage(pkgName);
			if type(objData) == "table" then
				local lf = RDXDB.TouchObject(pkgName .. ":" .. objName);
				if lf then
					lf.ty = objData.ty;
					lf.version = objData.version;
					lf.data = objData.data;
				end
			else
				RDXDB.SetPackageMetadata(pkgName, objName, objData);
			end
		end
	end
end

-- Update the stored version of an object
local function UpdateVersion(data)
	if type(data) ~= "table" then return; end
	RDX.printI(VFLI.i18n("Installing object: |cFFFFFFFF") .. data.title .. VFLI.i18n("|r |cFF00FF00(version ") .. data.version .. ")|r");
	if(data.context == "GLOBAL") then
		local g = RDXG.oobe; if not g then return; end
		g[data.name] = data.version or 0;
	else
		local l = RDXU.oobe; if not l then return; end
		l[data.name] = data.version or 0;
	end
end

-- Run library installers
local function InstallLibraries()
	RDX:Debug(3, "OOBE:InstallLibraries()");
	for k,obj in pairs(installs) do	if obj.library then
		local curVersion = RDX.GetOOBEObjectVersion(obj.name) or 0;
		if (obj.version > curVersion) then
			RDX:Debug(3, "Installing OOBE library ", obj.name, " oobeVersion ", obj.version, " currentVersion ", curVersion);
			UpdateVersion(obj); InstallData(obj.data);
			obj.InstallScript();
		else
			RDX:Debug(3, "Skipping OOBE library ", obj.name, " oobeVersion ", obj.version, " currentVersion ", curVersion);
		end
		-- Remove the library from memory after install checks.
		installs[k] = nil;
	end end
end

-- Determine which installers need to be run. Delete the ones that don't from memory.
-- Run the preinstall scripts for the ones that do.
local function PreInstall()
	RDX:Debug(3, "OOBE:PreInstall()");
	ClearToggles();
	for _,obj in pairs(installs) do
		obj._preinst = nil;
		local curVersion = RDX.GetOOBEObjectVersion(obj.name) or 0;
		--if (obj.version > curVersion) then
			RDX:Debug(3, "Preinstalling OOBE object ", obj.name, " oobeVersion ", obj.version, " currentVersion ", curVersion);
			if obj.PreInstallCondition() then
				obj._preinst = true;
				obj.PreInstallScript();
			end
		--else
		--	RDX:Debug(3, "Skipping OOBE object ", obj.name, " oobeVersion ", obj.version, " currentVersion ", curVersion);
		--end
	end
	for k,obj in pairs(installs) do
		if not obj._preinst then installs[k] = nil; end
	end
end

-- For every installer whose install condition returns true, install it.
local function Install()
	for k,obj in pairs(installs) do
		if obj.InstallCondition() then
			if obj.PrepareInstall then obj.PrepareInstall(); end
			UpdateVersion(obj); InstallData(obj.data); rlui_flag = true;
			obj.InstallScript();
		else
			installs[k] = nil;
		end
	end
end

-- Finish install
local function InstallFreeAll()
	RDX.RegisterOOBEObject = nil;
	RDX.RegisterOOBEOption = nil;
	RDX.GetOOBEOptionState = nil;
	RDX.OOBESetDefaultUserDesktop = nil;
	ClearToggles();
	--if rlui_flag then ReloadUI(); end
	ReloadUI();
end
local function InstallDone()
	-- Save that we've seen these installers on this character.
	if loadedOOBEs then
		for k,v in pairs(loadedOOBEs) do RDXU.installers[k] = v; end
	end
	InstallFreeAll();
end

-- Continue install after the second selection phase (post-install)
local function InstallPhase3()
	-- For each toggle, if it's enabled, run its action.
	for k,obj in pairs(toggles) do
		if obj.sel then obj.action(); end
	end
	InstallDone();
end

-- Continue install after the first selection phase
local function InstallPhase2()
	Install();
	ClearToggles();
	-- Run the post install scripts
	for k,obj in pairs(installs) do
		if obj.PostInstallCondition() then
			if obj.postInstallData then
				UpdateVersion(obj); InstallData(obj.postInstallData);
			end
			obj.PostInstallScript();
		end
		installs[k] = nil;
	end
	-- Show the post install options window.
	if(VFL.tsize(toggles) > 0) then
		ShowInstallerDialog(VFLI.i18n("RDX Installer"), VFLI.i18n("The following post-installation options are available:"), InstallPhase3);
	else
		InstallDone();
	end
end

-- Invoked after OOBEs are loaded.
local function DeferredInstaller()
	-- Step 3: Install libraries.
	InstallLibraries();
	-- Step 4: Preinstall
	ClearToggles();
	PreInstall();

	-- If no installs remain after the preinstall phase, peace out.
	if(VFL.tsize(installs) == 0) then InstallDone(); return; end

	-- Step 5: Show the first install options screen and wait for user feedback before proceeding.
	if(VFL.tsize(toggles) > 0) then
		ShowInstallerDialog(VFLI.i18n("RDX Installer"), VFLI.i18n("The following packages are available. (Warning, packages already installed will reset)"), InstallPhase2, InstallFreeAll, InstallDone);
	else
		InstallPhase2();
	end
end

-- Begin install
local function StartInstaller(force)
	-- Step 1: expose registration API.
	VFL.empty(installs);
	RDX.RegisterOOBEObject = function(tbl)
		if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") or (installs[tbl.name]) then
			error(VFLI.i18n("Invalid OOBE object registration."));
		end
		-- Fulfill any missing fields
		if(not tbl.context) then tbl.context = "LOCAL"; end
		if(not tbl.title) then tbl.title = "Untitled"; end
		tbl.version = cur_oobe_version;
		if(not tbl.PreInstallCondition) then tbl.PreInstallCondition = VFL.True; end
		if(not tbl.PreInstallScript) then tbl.PreInstallScript = VFL.Noop; end
		if(not tbl.InstallCondition) then tbl.InstallCondition = VFL.True; end
		if(not tbl.InstallScript) then tbl.InstallScript = VFL.Noop; end
		if(not tbl.PostInstallCondition) then tbl.PostInstallCondition = VFL.True; end
		if(not tbl.PostInstallScript) then tbl.PostInstallScript = VFL.Noop; end

		RDX:Debug(5, "RDX.RegisterOOBEObject(", tbl.name, ")");

		installs[tbl.name] = tbl;
	end;

	RDX.RegisterOOBEOption = function(tbl)
		if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then 
			error(VFLI.i18n("Invalid OOBE option registration.")); 
		end
		if(not tbl.heading) then tbl.heading = "Default"; end
		if(not tbl.text) then tbl.text = VFLI.i18n("(Missing text)"); end
		if(not tbl.categories) then tbl.categories = VFL.emptyTable; end
		if(not tbl.excludeCategories) then tbl.excludeCategories = VFL.emptyTable; end
		if(not tbl.uniqueCategories) then tbl.uniqueCategories = VFL.emptyTable; end
		if(not tbl.action) then tbl.action = VFL.Noop; end

		local h = tbl.heading;
		tbl.index = #toggles + 1;
		if not VFL.vmatch(toggles, function(tog) if tog.heading == h then return true; end end) then
			table.insert(toggles, {
				name = "__nonsense";
				index = 0;
				categories = VFL.emptyTable; excludeCategories = VFL.emptyTable; uniqueCategories = VFL.emptyTable;
				heading = h;
				text = h;
				isHeader = true;
			});
		end
		table.insert(toggles, tbl);
		table.sort(toggles, function(t1, t2)
			if t1.heading == t2.heading then
				return (t1.index < t2.index);
			else
				return (t1.heading < t2.heading);
			end
		end);
	end

	RDX.GetOOBEOptionState = function(tn, default)
		for _,tog in pairs(toggles) do
			if(tog.name == tn) then return tog.sel; end
		end
		return default;
	end;

	RDX.OOBESetDefaultUserDesktop = function(dtpath)
		local _,_,_,ty = RDXDB.GetObjectData(dtpath);
		if(ty ~= "Desktop") then return; end
		-- Copy our desktop
		--RDXDB.Copy(dtpath, "default:desktop_" .. RDX.pspace);
		-- Now formulate a script that auto-selects this desktop.
		local script = [[
--RDX.SelectDesktop("default:desktop_]] .. RDX.pspace .. [[");
]];
		-- Save to our autoexec script
		local so = RDXDB.TouchObject("Scripts:auto_e_default_u_" .. RDX.pspace);
		so.ty = "Script"; so.version = 1; so.data = { script = script };
		rlui_flag = true; -- We need to reload ui after setting a default desktop.
	end;

	-- Step 2: Dynaload OOBE addons. Load only the installers the user hasn't seen on the current character.
	local installers, instName = RDXU.installers, nil;
	for i=1,GetNumAddOns() do
		instName = GetAddOnMetadata(i, "X-RDX-OOBEName");
		instVersion = tonumber(GetAddOnMetadata(i, "X-RDX-OOBEVersion"));
		-- If we've encountered an OOBE addon...
		if(instName and instVersion) then
			-- If we haven't seen this installer, or only seen an older version...
			if (not installers[instName]) or (installers[instName] < instVersion) or force then
				cur_oobe_version = instVersion;
				-- Load it up
				local n, title = GetAddOnInfo(i);
				local loaded, reason = LoadAddOn(i);
				if loaded then
					if not loadedOOBEs then loadedOOBEs = {}; end
					loadedOOBEs[instName] = instVersion
					RDX.printI(VFLI.i18n("Loading installer addon : ") .. title);
				end
			end
		end
	end
	-- If no oobes were loaded, peace out.
	if(not loadedOOBEs) then
		RDX.InstallerDone();
		return;
	end
	VFLT.ZMSchedule(2, DeferredInstaller);
end

-- Everything is triggered by the VARIABLES_LOADED event.
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	-- Clear out variables set by legacy versions.
	RDXG.bundles = nil; RDXG.OOBE_Installed = nil;
	-- Create our new data files if they don't exist
	if type(RDXG.oobe) ~= "table" then RDXG.oobe = {}; end
	if type(RDXU.oobe) ~= "table" then RDXU.oobe = {}; end
	if type(RDXU.installers) ~= "table" then RDXU.installers = {}; end
	StartInstaller();
end);

RDX.StartInstaller = StartInstaller;
