-----------------------------------
-- The AuraName object type.
-- Use with the feature buff/debuff info
-----------------------------------
local dlg = nil;

local function WriteName(dest, src)
	VFL.empty(dest);
	if type(src) == "string" then
		dest[string.lower(src)] = true; 
	end
end

RDXDB.RegisterObjectType({
	name = "AuraName";
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		if dlg then return; end
		if (not path) or (not md) or (not md.data) then return nil; end
		local inst = RDXDB.GetObjectInstance(path, true);

		dlg = VFLUI.Window:new(parent);
		VFLUI.Window.SetDefaultFraming(dlg, 22);
		dlg:SetTitleColor(0,0,.6);
		dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
		dlg:SetPoint("CENTER", VFLParent, "CENTER");
		dlg:SetWidth(320); dlg:SetHeight(85);
		dlg:SetText(VFLI.i18n("Edit AuraName: ") .. path);
		dlg:SetClampedToScreen(true);
		
		VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
		if RDXPM.Ismanaged("Auraname") then RDXPM.RestoreLayout(dlg, "Auraname"); end
		
		local ed_name = VFLUI.LabeledEdit:new(dlg, 220);
		ed_name:SetText(VFLI.i18n("Aura Name"));
		ed_name.editBox:SetText(md.data["auraname"] or "");
		ed_name:SetHeight(25); ed_name:SetWidth(310);
		ed_name:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
		ed_name:Show();
		
		local tmpcache = {};
		
		local btn_name = VFLUI.Button:new(ed_name);
		btn_name:SetHeight(25); btn_name:SetWidth(25); btn_name:SetText("...");
		btn_name:SetPoint("RIGHT", ed_name.editBox, "LEFT"); 
		btn_name:Show();
		btn_name:SetScript("OnClick", function()
			VFL.empty(tmpcache);
			VFL.copyInto(tmpcache, RDXDAL._GetBuffCache());
			VFL.copyInto(tmpcache, RDXDAL._GetDebuffCache());
			RDXDAL.AuraCachePopup(tmpcache, function(x) 
				if x then ed_name.editBox:SetText(x.name); end
			end, btn_name, "CENTER");
		end);
		
		dlg:Show();
		--dlg:_Show(RDX.smooth);

		local esch = function()
			--dlg:_Hide(RDX.smooth, nil, function()
				RDXPM.StoreLayout(dlg, "Auraname");
				dlg:Destroy(); dlg = nil;
			--end);
		end
		VFL.AddEscapeHandler(esch);
		
		local function Save()
			local desc = ed_name.editBox:GetText();
			if desc then
				md.data["auraname"] = desc;
				if inst then WriteFilter(inst, desc); end
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
			ed_name:Destroy(); ed_name = nil;
			btn_name:Destroy(); btn_name = nil;
		end, dlg.Destroy);
	end;
	Instantiate = function(path, md)
		if type(md.data) ~= "string" then return nil; end
		local inst = {};
		WriteName(inst, md.data["auraname"]);
		return inst;
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
