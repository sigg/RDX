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
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(500); dlg:SetHeight(500);
	dlg:SetText(VFLI.i18n("Text Editor: ") .. path);
	dlg:SetClampedToScreen(true);
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
	name = "Global";
	invisible = true;
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		--EditScriptDialog(parent or VFLDIALOG, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function() 
				VFL.poptree:Release(); 
				--EditScriptDialog(dlg, path, md); 
			end
		});
	end;
});


