-- Scripting.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- The Script object type, and various automated handling for the Scripts 
-- package.

-- Edit dialog for scripts
local dlg = nil;

local function EditScriptDialog(parent, path, md)
	if dlg then
		RDX.printI(VFLI.i18n("A script editor is already open. Please close it first.")); return;
	end
	-- Sanity checks
	if (not path) or (not md) or (not md.data) then return nil; end
	local ctype, font = "LuaEditBox", nil;

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(500); dlg:SetHeight(500);
	dlg:SetText(VFLI.i18n("Text Editor: ") .. path);
	dlg:SetClampedToScreen(true);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("script_editor") then RDXPM.RestoreLayout(dlg, "script_editor"); end

	local editor = VFLUI.TextEditor:new(dlg, ctype, font);
	editor:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	editor:SetWidth(490); editor:SetHeight(430); editor:Show();
	editor:SetText(md.data.script or "");
	editor:GetEditWidget():SetFocus();
	
	dlg:Show();
	--dlg:_Show(RDX.smooth);

	local esch = function()
		--dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "script_editor");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	local function Save()
		md.data.script = editor:GetText() or "";
		VFL.EscapeTo(esch);
	end

	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	dlg.Destroy = VFL.hook(function(s)
		editor:Destroy(); editor = nil;
	end, dlg.Destroy);
end

-- Script RDX object registration
RDXDB.RegisterObjectType({
	name = "Script";
	New = function(path, md)
		md.version = 1;
	end;
	Open = function(path, md, arg)
		if not md.data.script then return nil; end
		if type(arg) ~= "string" then arg = ""; end
		local f,err = loadstring(arg .. "\n" .. md.data.script);
		if f then f(); else
			VFL.TripError("RDX", VFLI.i18n("Script error at <") .. path .. ">", err); return;
		end
	end;
	Edit = function(path, md, parent)
		EditScriptDialog(parent or VFLDIALOG, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Run"),
			func = function() 
				VFL.poptree:Release();
				RDXDB.OpenObject(path);
			end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function() 
				VFL.poptree:Release(); 
				EditScriptDialog(dlg, path, md); 
			end
		});
	end;
});

-- Macro RDX object registration
RDXDB.RegisterObjectType({
	name = "Macro";
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		EditScriptDialog(parent or VFLDIALOG, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function() 
				VFL.poptree:Release(); 
				EditScriptDialog(dlg, path, md); 
			end
		});
	end;
});

-- Dangerous object filter registration: scripts should always be viewed as dangerous.
RDXDB.RegisterDangerousObjectFilter({
	matchType = "Script";
	Filter = VFL.True;
});
RDXDB.RegisterDangerousObjectFilter({
	matchType = "Macro";
	Filter = VFL.True;
});

-------------------------------------
-- SCRIPT EXECUTION
-------------------------------------
function RDX.RunScript(path)
	if RDXDB.CheckObject(path, "Script") then RDXDB.OpenObject(path); end
end

RDXPM.RegisterSlashCommand("script", function(rest)
	local script = VFL.word(rest);
	RDX.RunScript(script);
end);

-- When we login (post DB load) run our auto_USER script.
-- Also run all autoexec scripts in sub-packages.
RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RDXDB.OpenObject("RDXDiskSystem:" .. RDX.pspace .. ":auto_u_script");
	
	RDXDB.Foreach(function(dk, pkg, file, md)
		local ty = RDXDB.GetObjectType(md.ty);
		if not ty then return; end
		if file == "autoexec" and ty == "Script" and RDXDB.GetPackageMetadata(dk, pkg, "infoRunAutoexec") then 
			RDXDB.OpenObject(RDXDB.MakePath(dk,pkg,file), "Open", "local dk, pkg = '" .. dk .. "','" .. pkg .. "';");
		end
	end);
end);

