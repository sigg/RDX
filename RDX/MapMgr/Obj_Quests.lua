-----------------------------------
-- The POISet object type.
-----------------------------------
local dlg = nil;

local function WriteFilter(dest, src)
	VFL.empty(dest);
	VFL.copyInto(dest, src);
end

RDXDB.RegisterObjectType({
	name = "QuestSet",
	New = function(path, md)
		md.version = 1;
	end,
	Edit = function(path, md, parent)
		if dlg then return; end
		if (not path) or (not md) or (not md.data) then return nil; end

		dlg = VFLUI.Window:new(parent);
		VFLUI.Window.SetDefaultFraming(dlg, 22);
		dlg:SetTitleColor(0,0,.6);
		dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
		dlg:SetPoint("CENTER", RDXParent, "CENTER");
		dlg:SetWidth(610); dlg:SetHeight(270);
		dlg:SetText(VFLI.i18n("Edit POISet: ") .. path);
		dlg:SetClampedToScreen(true);
		
		VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
		if RDXPM.Ismanaged("QuestSet") then RDXPM.RestoreLayout(dlg, "QuestSet"); end

		local le_names = VFLUI.ListEditor:new(dlg, md.data, function(cell,data) 
			cell.text:SetText(data);
		end, nil, function(list, ty, ctl, txt)
			if txt and txt ~= "" then 
				table.insert(list, txt);
				if ctl then
					ctl:SetText("");
				end
			else
				VFLUI.MessageBox("Error", "Enter something please.");
			end
		end);
		le_names:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
		le_names:SetWidth(600);	le_names:SetHeight(183); le_names:Show();
		
		--dlg:Show();
		dlg:_Show(RDX.smooth);

		local esch = function()
			dlg:_Hide(RDX.smooth, nil, function()
				--dlg:Hide();
				RDXPM.StoreLayout(dlg, "POISet");
				dlg:Destroy(); dlg = nil;
			end);
		end
		VFL.AddEscapeHandler(esch);
		
		local function Save()
			md.data = le_names:GetList();
			-- Notify the FS that we've updated.
			RDXDB.NotifyUpdate(path);
			VFL.EscapeTo(esch);
		end

		local savebtn = VFLUI.SaveButton:new()
		savebtn:SetScript("OnClick", Save);
		dlg:AddButton(savebtn);

		local closebtn = VFLUI.CloseButton:new(dlg);
		closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
		dlg:AddButton(closebtn);

		dlg.Destroy = VFL.hook(function(s)
			le_names:Destroy(); le_names = nil;
		end, dlg.Destroy);
	end,
	Instantiate = function(path, md)
		if type(md.data) ~= "table" then return nil; end
		local inst = {};
		WriteFilter(inst, md.data);
		return inst;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		--table.insert(mnu, {
		--	text = VFLI.i18n("Edit"),
		--	func = function()
		--		VFL.poptree:Release();
		--		RDXDB.OpenObject(path, "Edit", dlg);
		--	end
		--});
	end,
});

--RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(dk, pkg, file) 
--	local path = RDXDB.MakePath(dk,pkg,file);
--	local md,_,_,ty = RDXDB.GetObjectData(path)
--	if ty == "QuestSet" then
--		local inst = RDXDB.GetObjectInstance(path, true)
--		WriteFilter(inst, md.data);
--	end
--end);



