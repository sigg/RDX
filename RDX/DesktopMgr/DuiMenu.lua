--local state = {"Solo", "Party", "Raid", "PvP", "Arena", "solo2", "party2", "raid2", "pvp2", "arena2"};
local state = {"Solo", "Party", "Raid", "PvP", "Arena"};

local subMenus = {};
local stateTypeMenus = {};
local thirdpartymenu = {};

function RDXDK.RegisterThirdPartyMenu(id, menu)
	if not id or not menu then return nil; end
	if thirdpartymenu[id] then return nil; end
	thirdpartymenu[id] = menu;
end

-- helper

local function PkgDeleteHandler(pkg)
	local result,err = RDXDB.DeletePackage(pkg);
	if result then return; end
	if err == VFLI.i18n("Cannot delete non-empty package.") then
		VFLUI.MessageBox(VFLI.i18n("Delete Theme: ") .. pkg, VFLI.i18n("The theme ") .. pkg .. VFLI.i18n(" is not empty. Are you sure you want to delete it?"), nil, VFLI.i18n("Cancel"), VFL.Noop, VFLI.i18n("OK"), function() RDXDK.SecuredChangeAUI("desktops:default", "default"); _DisplayError(RDXDB.DeletePackage(pkg, true)); end);
	else
		_DisplayError(result, err);
	end
end

-----------------------------------------
-- DUI change
-----------------------------------------
local function AUIList()
	RDXPM.AUIMenu:ResetMenu();
	
	local sortDUI = {};
	local pkg = RDXDB.GetPackage("RDXDiskSystem", "desktops")
	for objName, obj in pairs(pkg) do
		if type(obj) == "table" and obj.ty == "AUI" then 
			local path = RDXDB.MakePath("RDXDiskSystem", "desktops", objName);
			local newMenu;
			local submenu = {};
			local flag = nil;
			local data = obj.data;
			if #data > 1 then
				table.insert(submenu,{ text = VFLI.i18n("**** Layout ****"), isTitle = true, notCheckable = true, keepShownOnClick = false, func = VFL.Noop });
				for i, v in ipairs(data)do
					table.insert(submenu, { 
							text = v,
							checked = function()
								if path == RDXU.AUI and v == RDXU.AUIState then return true; else return nil; end
							end,
							func = function()
								VFL.poptree:Release();
								RDXDK.SecuredChangeAUI(path, v);
								AUIList();
							end,
						}
					);
				end
				flag = true;
			end
			local tbl = thirdpartymenu[objName];
			if tbl then
				VFL.copyInto(submenu, tbl);
				flag = true;
			end
			if flag then
				newMenu = {
					text = objName,
					checked = function()
						if path == RDXU.AUI then return true; else return nil; end
					end,
					func = function()
						VFL.poptree:Release();
						RDXDK.SecuredChangeAUI(path, "default");
						AUIList();
					end,
					hasArrow = true;
					menuList = submenu;
				};
			else
				newMenu = {
					text = objName,
					checked = function()
						if path == RDXU.AUI then return true; else return nil; end
					end,
					func = function()
						VFL.poptree:Release();
						RDXDK.SecuredChangeAUI(path, "default");
						AUIList();
					end
				};
			end
			table.insert(sortDUI, newMenu);
		end
	end
	table.sort(sortDUI, function(x1,x2) return x1.text < x2.text; end);
	for i, v in pairs(sortDUI) do
		if v.menuList then
			local menu = RDXPM.Menu:new();
			for j, w in ipairs(v.menuList) do
				menu:RegisterMenuFunction(function(ent)
					ent.text = w.text;
					ent.checked = w.checked;
					ent.func = w.func;
				end);
			end
			RDXPM.AUIMenu:RegisterMenuEntry(v.text, true, function(tree, frame) menu:Open(tree, frame); end)
		else
			RDXPM.AUIMenu:RegisterMenuFunction(function(ent)
				ent.text = v.text;
				--ent.hasArrow = true;
				ent.checked = v.checked;
				ent.func = v.func;
			end);
		end
	end
	
	RDXPM.AUIMenu:RegisterMenuFunction(function(ent)
		ent.text = "*****************";
		ent.isTitle = true;
		ent.color = _yellow;
		ent.notCheckable = true;
		--ent.hasArrow = true;
		ent.func = VFL.Noop;
	end);
	RDXPM.AUIMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Create a new theme");
		ent.notCheckable = true;
		--ent.hasArrow = true;
		ent.func = function() VFL.poptree:Release(); RDXDK.NewAUI(); end;
	end);
	RDXPM.AUIMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Duplicate a theme");
		ent.notCheckable = true;
		--ent.hasArrow = true;
		ent.func = function() VFL.poptree:Release(); DXDK.DuplicateAUI(); end;
	end);
	
	if RDXU.AUI then
		local dk, pkg, file = RDXDB.ParsePath(RDXU.AUI);
		if file then
			RDXPM.AUIMenu:RegisterMenuFunction(function(ent)
				ent.text = "*****************";
				ent.isTitle = true;
				ent.color = _yellow;
				ent.notCheckable = true;
				--ent.hasArrow = true;
				ent.func = VFL.Noop;
			end);
			RDXPM.AUIMenu:RegisterMenuFunction(function(ent)
				ent.text = VFLI.i18n("Manage layouts ") .. file;
				ent.notCheckable = true;
				--ent.hasArrow = true;
				ent.func = function() VFL.poptree:Release(); local md = RDXDB.GetObjectData(RDXU.AUI); if md then RDXDK.ToggleAUIEditor(RDXU.AUI, md); end end
			end);
			--RDXPM.AUIMenu:RegisterMenuFunction(function(ent)
			--	ent.text = VFLI.i18n("Drop the theme ") .. file;
			--	ent.notCheckable = true;
				--ent.hasArrow = true;
			--	ent.func = function() VFL.poptree:Release(); PkgDeleteHandler(file); end
			--end);
		end
	end
end

RDXDBEvents:Bind("OBJECT_DELETED", nil, function(dk, pkg, file, md)
	local path = RDXDB.MakePath(dk, pkg,file);
	if md and md.ty == "AUI" and path ~= RDXU.AUI then
		AUIList();
	end
end);

RDXDBEvents:Bind("OBJECT_CREATED", nil, function(dk, pkg, file, md)
	local path = RDXDB.MakePath(dk, pkg,file);
	if md and md.ty == "AUI" and path ~= RDXU.AUI then
		AUIList();
	end
end);

RDXDBEvents:Bind("OBJECT_MOVED", nil, function(dk, pkg, file, ndk, npkg, nfile, md)
	local path = RDXDB.MakePath(ndk,npkg,nfile);
	if md and md.ty == "AUI" and path ~= RDXU.AUI then
		AUIList();
	end
end);

RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function() AUIList(); end);

RDXDK.AUIList = AUIList;
