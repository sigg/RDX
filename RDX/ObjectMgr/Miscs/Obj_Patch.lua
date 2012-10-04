-- Patch.lua
-- OpenRDX
--
-- The Updater object type, use to update RDX.

-- Edit dialog for scripts
local function EditScriptDialog(parent, path, md)
	-- Sanity checks
	if (not path) or (not md) or (not md.data) then return nil; end
	local ctype, font = "LuaEditBox", nil;

	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(500); dlg:SetHeight(500);
	dlg:SetText(VFLI.i18n("Text Editor: ") .. path);
	dlg:Show();
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());

	local editor = VFLUI.TextEditor:new(dlg, ctype, font);
	editor:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	editor:SetWidth(490); editor:SetHeight(430); editor:Show();
	editor:SetText(md.data.script or "");
	editor:GetEditWidget():SetFocus();

	local esch = function() 
		dlg:Destroy(); dlg = nil;
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
	name = "Patch";
	invisible = true;
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
			text = VFLI.i18n("Edit"),
			OnClick = function() 
				VFL.poptree:Release(); 
				EditScriptDialog(dlg, path, md); 
			end
		});
	end;
});



-------------------------------------
-- UPDATER EXECUTION
-------------------------------------

-- When we login (post DB load) run our auto_USER script.
-- Also run all autoexec scripts in sub-packages.
RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	--RDXDB.OpenObject("scripts:auto_u_" .. RDX.pspace);
	--local aex, adesk, isexist = nil, nil, nil;
	--for pkg,dir in pairs(RDXDB.GetPackages()) do
	--	aex = dir["autoexec"];
	--	if aex and aex.ty == "Script" and RDXDB.GetPackageMetadata(pkg, "infoRunAutoexec") then
	--		RDXDB.OpenObject(pkg .. ":autoexec", "Open", "local pkg = '" .. pkg .. "';");
	--	end
	--end
	-- regarder dans le package default
	-- si il y a un objet appelé RDX813
	-- L'objet RDX 813 doit faire un SetPatchversion.
	--
end);


