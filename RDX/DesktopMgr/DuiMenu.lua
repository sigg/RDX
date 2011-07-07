local state = {"Solo", "Party", "Raid", "PvP", "Arena", "solo2", "party2", "raid2", "pvp2", "arena2"}

local subMenus = {};
-----------------------------------------
-- DUI change
-----------------------------------------
local function AUIList()
	VFL.empty(subMenus);
	RDXPM.DuiMenu:ResetMenu();
	
	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = "UI";
		ent.isTitle = true;
		ent.notCheckable = true;
		ent.justifyH = "CENTER";
	end);
	
	-----------------------------------
	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Blizzard Frame Manager");
		ent.func = RDXDK.ToggleBlizzardManage;
		ent.notCheckable = true;
	end);
	
	-----------------------------------
	
	--local currentDesktop = {
	--	text = RDX.pspace,
	--	notCheckable = true,
	--	func = function()
	--		RDXDK.SecuredChangeAUI("desktops:" .. RDX.pspace);
	--		AUIList();
	--	end;
	--};	
	--table.insert(subMenus, currentDesktop);
	--table.insert(subMenus, {
	--	text = "*******************",
	--	notCheckable = true,
	--	func = VFL.Noop,
	--	}
	--);
	local sortDUI = {};
	for pkgName, pkg in pairs(RDXData) do
		--if pkgName == "desktops" then
			for objName, obj in pairs(pkg) do
				if type(obj) == "table" and obj.ty == "AUI" then 
					local path = RDXDB.MakePath(pkgName, objName);
					local newMenu = {
						text = objName,
						notCheckable = true,
						func = function()
							RDXDK.SecuredChangeAUI(path);
							AUIList();
						end
					};
					table.insert(sortDUI, newMenu);
				end
			end
		--end
	end
	table.sort(sortDUI, function(x1,x2) return x1.text < x2.text; end);
	for i, v in pairs(sortDUI) do
		table.insert(subMenus, v);
	end
	
	table.insert(subMenus, {
		text = "*******************",
		notCheckable = true,
		func = VFL.Noop,
		}
	);
	
	table.insert(subMenus, { 
		text = "Edit AUI",
		notCheckable = true, 
		func = function()
			local md = RDXDB.GetObjectData(RDXU.AUI);
			if md then RDXDK.ToggleAUIEditor(RDXU.AUI, md); end
		end
		}
	);

	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = "Theme AUI";
		ent.hasArrow = true;
		ent.notCheckable = true;
		ent.menuList = subMenus;
	end);
	
	-----------------------------------
	local stateTypeMenus = {};

	local autoMenu = {
		text = VFLI.i18n("Auto"),
		notCheckable = true,
		func = function()
			if not RDXU.autoSwitchState then
				RDXDK.SwitchState_Enable();
			end
		end;
	};

	table.insert(stateTypeMenus, autoMenu);

	for _,v in ipairs(state) do
		local thisMenu = {
			text = v,
			notCheckable = true,
			func = function()
				RDXDK.SwitchState_Disable(strlower(v));
			end;
		};
		table.insert(stateTypeMenus, thisMenu);
	end

	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = "State";
		ent.hasArrow = true;
		ent.notCheckable = true;
		ent.menuList = stateTypeMenus;
	end);
	
	-----------------------------------
	local editListMenu = {		
		{ text = "Edit Current Desktop", notCheckable = true, func = function()
			local md = RDXDB.GetObjectData(RDXDK.GetCurrentDesktopPath());
			if md then RDXDK.ToggleDesktopEditor(VFLDIALOG, RDXDK.GetCurrentDesktopPath(), md); end
		end },
		{ text = "Clear Desktop", notCheckable = true, func = RDXDK.DeskClear },
		{ text = "Reset Desktop", notCheckable = true, func = RDXDK.DeskReset }
	}

	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text= "Manage Desktop";
		ent.notCheckable = true;
		ent.hasArrow = true;
		ent.menuList = editListMenu;
	end);
	
	-----------------------------------
	local windowListMenu = {
		{ text = "Windows List", notCheckable = true, func = RDXDK.ToggleWindowList},
		{ text = "Register List", notCheckable = true, func = RDXDK.ToggleWindowLessList},
	}
	
	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Windows");
		ent.notCheckable = true;
		ent.hasArrow = true;
		ent.menuList = windowListMenu;
	end);

	-----------------------------------
	local lockListMenu = {
		{ text = "Desktop", checked = RDXDK.IsDesktopLocked, func = RDXDK.ToggleDesktopLock },
		{ text = "Key Bindings", checked = RDXDK.IsKeyBindingsLocked, func = RDXDK.ToggleKeyBindingsLock },
		{ text = "Action Bindings", checked = RDXDK.IsActionBindingsLocked, func = RDXDK.ToggleActionBindingsLock }
	}
	
	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = "Locking";
		ent.notCheckable = true;
		ent.hasArrow = true;
		ent.menuList = lockListMenu;
	end);
	
	--RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
	--	ent.text = "*******************";
	--	ent.notCheckable = true;
	--	ent.func = VFL.Noop;
	--end);
	
	--RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
	--	ent.text = VFLI.i18n("Wizards");
	--	ent.hasArrow = true;
	--	ent.notCheckable = true;
	--	ent.menuList = {
	--		{ text = "     " .. VFLI.i18n("Windows Wizard"), notCheckable = true, func = function() RDX.NewWindowWizard(); end; },
	--
	--	};
	--end);
	
	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = "*******************";
		ent.notCheckable = true;
		ent.func = VFL.Noop;
	end);
	
	-----------------------------------
	RDXPM.DuiMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Reload UI");
		ent.notCheckable = true;
		ent.func = VFLReloadUI;
	end);
	
	RDXPM.subMenus = subMenus;
end

RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg, file, md)
	local path = RDXDB.MakePath(pkg,file);
	if md and md.ty == "AUI" and path ~= RDXU.AUI then
		AUIList();
	end
end);

RDXDBEvents:Bind("OBJECT_CREATED", nil, function(pkg, file, md)
	local path = RDXDB.MakePath(pkg,file);
	if md and md.ty == "AUI" and path ~= RDXU.AUI then
		AUIList();
	end
end);

RDXDBEvents:Bind("OBJECT_MOVED", nil, function(pkg, file, npkg, nfile, md)
	local path = RDXDB.MakePath(npkg,nfile);
	if md and md.ty == "AUI" and path ~= RDXU.AUI then
		AUIList();
	end
end);

RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function() AUIList(); end);
