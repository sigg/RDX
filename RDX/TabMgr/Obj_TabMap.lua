-- Obj_WindowTab.lua
-- OpenRDX
--



-- The Window object type.
RDXDB.RegisterObjectType({
	name = "TabMap";
	isFeatureDriven = true;
	invisible = true;
	New = function(path, md)
		md.version = 1;
	end,
	Edit = function(path, md, parent)
		RDX.EditWindow(parent, path, md);
	end,
	Instantiate = function(path, md)
		local mf = VFLUI.AcquireFrame("Frame");
		if Nx then
			local m = Nx.Map:Open();
			m.Frm:SetParent(mf);
			--m.Frm:SetAllPoints(mf);
			mf.m = m;
			
			local function layout()
				local w = mf:GetWidth();
				local h = mf:GetHeight();
				m.Frm:ClearAllPoints();
				m.Frm:SetPoint("CENTER", mf, "CENTER");
				m.Frm:SetWidth(w - 2);
				m.Frm:SetHeight(h - 2);
			end
			mf:SetScript("OnShow", layout);
			mf:SetScript("OnSizeChanged", layout);
		end
		
		return mf;
	end,
	Deinstantiate = function(instance, path, md)
		--instance:_Hide(RDX.smooth, nil, function() instance:Destroy(); instance._path = nil; instance = nil; end);
		--if instance.m then
		--	instance.m:Destroy();
		--	instance.m = nil;
		--end
		--instance:Destroy();
		instance = nil;
	end,
	OpenTab = function(tabbox, path, md, objdesc, desc, tm)
		local tabtitle, tabwidth = "Tab", 80;
		for k, v in pairs(md.data) do
			if v.feature == "taboptions" then
				tabtitle = v.tabtitle;
				tabwidth = v.tabwidth;
			end
		end
		local f = RDXDB.GetObjectInstance(path);
		local tab = tabbox:GetTabBar():AddTab(tabwidth, function(self, arg1)
			tabbox:SetClient(f);
			VFLUI.SetBackdrop(f, desc.bkd);
			--f.font = desc.font;
			--if f.NxWin then f.NxWin:Enable(); end
		end,
		function()
			--if f.NxWin then f.NxWin:Disable(); end
		end, 
		function(mnu, dlg) 
			return objdesc.GenerateBrowserMenu(mnu, path, nil, dlg, tm)
		end);
		tab.font:SetText(tabtitle);
		tab.f = f;
		return tab;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg, tm)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
		local feat = RDXDB.GetFeatureData(path, "Design");
		if not feat then feat = RDXDB.GetFeatureData(path, "Assist Frames"); end
		if feat then
			local upath = feat["design"];
			table.insert(mnu, {
				text = VFLI.i18n("Edit Design"),
				OnClick = function() 
					VFL.poptree:Release();
					if IsShiftKeyDown() then
						RDXDB.OpenObject(upath, "Edit", VFLDIALOG, true);
					else
						RDXDB.OpenObject(upath, "Edit", VFLDIALOG);
					end
				end
			});
		end
		if tm then 
			table.insert(mnu, {
				text = VFLI.i18n("Close Tab");
				OnClick = function()
					VFL.poptree:Release();
					tm:RemoveTab(path, true);
				end;
			});
		end
	end,
});


