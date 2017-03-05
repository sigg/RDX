-- Obj_FilterSet.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Glue code for the FilterSet object type.

-- Edit a preexisting FilterSet.
local dlg = nil;
local function EditFilterSetDialog(parent, path, md)
	if dlg then
		RDX.printI(VFLI.i18n("A set editor is already open. Please close it first."));
		return;
	end

	-- Sanity checks
	if (not path) or (not md) or (not md.data) then return nil; end
	-- See if this set was already instantiated...
	local inst = RDXDB.GetObjectInstance(path, true);

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(510); dlg:SetHeight(370);
	dlg:SetText(VFLI.i18n("Edit FilterSet: ") .. path);
	dlg:SetClampedToScreen(true);
	-- OpenRDX 7.1 RDXPM
	if RDXPM.Ismanaged("FilterSet") then RDXPM.RestoreLayout(dlg, "FilterSet"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());

	local fe = RDXDAL.FilterEditor:new(dlg);
	fe:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	fe:Show();
	fe:LoadDescriptor(md.data);

	dlg:Show();
	--dlg:_Show(RDX.smooth);

	local esch = function()
		--dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "FilterSet");
			dlg:Destroy(); dlg = nil;
		--end);
	end

	VFL.AddEscapeHandler(esch);

	local function Save()
		local desc = fe:GetDescriptor();
		if desc then
			md.data = desc;
			if inst then inst:SetFilter(desc); end
		end
		VFL.EscapeTo(esch);
	end
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	dlg.Destroy = VFL.hook(function(s)
		fe:Destroy(); fe = nil;
	end, dlg.Destroy);
end


-- Registration and controls for the FilterSet object type.
RDXDB.RegisterObjectType({
	name = "FilterSet";
	New = function(path, md)
		md.version = 1;
	end;
	Instantiate = function(path, obj)
		-- Verify the filter
		if not RDXDAL.ValidateFilter(obj.data) then
			VFL.TripError("RDX", VFLI.i18n("Could not validate filter for FilterSet<") .. tostring(path) .. ">", "");
			return nil; 
		end
		-- Make the set
		local x = RDXDAL.FilterSet:new(); RDXDAL.RegisterSet(x);
		x.path = path;
		x.name = "FilterSet<" .. path .. ">"; x:SetFilter(obj.data);
		return x;
	end;
	Edit = function(path, md, parent)
		EditFilterSetDialog(parent, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function() 
				VFL.poptree:Release(); 
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end
});

