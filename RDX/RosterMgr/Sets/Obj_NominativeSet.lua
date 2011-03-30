-- Obj_NominativeSet.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Glue code for attaching NominativeSets to the user interface.

local dlg = nil;
local function EditNominativeSetDialog(parent, path, md)
	if dlg then
		RDX.printI(VFLI.i18n("A set editor is already open. Please close it first."));
		return;
	end

	-- Sanity checks
	if (not path) or (not md) or (not md.data) then return nil; end
	local inst = RDXDB.GetObjectInstance(path, true);

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(270); dlg:SetHeight(350);
	dlg:SetText(VFLI.i18n("Edit NominativeSet: ") .. path);
	-- OpenRDX 7.1 RDXPM
	if RDXPM.Ismanaged("NominativeSet") then RDXPM.RestoreLayout(dlg, "NominativeSet"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	dlg:Show();
	
	--------------- PREDECLARATIONS
	local list = md.data or {};

	---------------- CONTROLS
	local lbl = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Enter name to add:"));
	lbl:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");

	local le = VFLUI.ListEditor:new(dlg, list, function(cell, data) cell.text:SetText(data); end);
	le:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
	le:SetWidth(260); le:SetHeight(263);
	le:Show();

	---------------- OK button
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText("OK");
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();

	----------------- Close functionality
	dlg.Destroy = VFL.hook(function()
		btnOK:Destroy(); btnOK = nil;
		le:Destroy(); le = nil; list = nil;
		dlg = nil;
	end, dlg.Destroy);
	
	-- Escapement
	local esch = function() 
		RDXPM.StoreLayout(dlg, "NominativeSet");
		dlg:Destroy();
	end
	VFL.AddEscapeHandler(esch);
	local closebtn = VFLUI.CloseButton:new();
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	-- OK handler
	btnOK:SetScript("OnClick", function()
		local lst = le:GetList();
		VFL.EscapeTo(esch);
		if lst then 
			-- Lowercase the list before saving.
			for k,name in ipairs(lst) do lst[k] = string.lower(name); end
			md.data = lst;
			if inst then inst:SetNameList(lst); end
		end
	end);
end

-- Object class registration
RDXDB.RegisterObjectType({
	name = "NominativeSet";
	New = function(path, md)
		md.version = 1;
		md.data = {};
	end;
	Edit = function(path, md, parent)
		EditNominativeSetDialog(parent, path, md);
	end;
	Twiddle = function(path, md, name, val)
		if not name then return; end
		name = string.lower(name);
		local inst = RDXDB.GetObjectInstance(path);
		if not inst then return; end
		local cs = inst:CheckName(name);
		if (cs) and (not val) then
			inst:RemoveName(name);
			md.data = inst:GetNameArray();
		elseif (not cs) and (val) then
			inst:AddName(name);
			md.data = inst:GetNameArray();
		end
	end;
	Instantiate = function(path, obj)
		local x = RDXDAL.NominativeSet:new();
		x.name = "NominativeSet<" .. path .. ">";
		x.path = path;
		RDXDAL.RegisterSet(x);
		x:SetNameList(obj.data);
		return x;
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit..."),
			OnClick = function() 
				VFL.poptree:Release(); 
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});

