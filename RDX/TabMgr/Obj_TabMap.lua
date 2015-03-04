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
		md.data = {};
		md.data.NXAutoScaleOn = true;
		md.data.NXKillShow = false;
		md.data.NXMMFull = false;
		md.data.NXMMAlpha = .1;
		md.data.NXMMDockScale = .4;
		md.data.NXMMDockScaleBG = .4;
		md.data.NXMMDockAlpha = 1;
		md.data.NXMMDockOnAtScale = .6;
		md.data.NXBackgndAlphaFade = .4;
		md.data.NXBackgndAlphaFull = 1;
		md.data.NXArchAlpha = .3;
		md.data.NXQuestAlpha = .3;
		md.data.NXAutoScaleMin = .01;
		md.data.NXAutoScaleMax = 4;
		md.data.NXDotZoneScale = 1;
		md.data.NXDotPalScale = 1;
		md.data.NXDotPartyScale = 1;
		md.data.NXDotRaidScale = 1;
		md.data.NXIconNavScale = 1;
		md.data.NXIconScale = 1;
		md.data.NXDetailScale = 2;
		md.data.NXDetailAlpha = 1;
		md.data.NXPOIAtScale = 1;
		md.data.NXShowUnexplored = false;
		md.data.NXUnexploredAlpha = .35;
		md.data[0] = {};
		md.data[0].NXPlyrFollow = true;
		md.data[0].NXWorldShow = true;
	end,
	Edit = function(path, md, parent)
		RDX.EditWindow(parent, path, md);
	end,
	Instantiate = function(path, md)
		local mf = VFLUI.AcquireFrame("Frame");
		
		local m = RDXMAP.Map:Open(1, md.data);
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

		
		return mf;
	end,
	Deinstantiate = function(instance, path, md)
		--instance:_Hide(RDX.smooth, nil, function() instance:Destroy(); instance._path = nil; instance = nil; end);
		if instance.m then
			instance.m:Destroy();
			instance.m = nil;
		end
		instance:Destroy();
		instance = nil;
	end,
	OpenTab = function(tabbox, path, md, objdesc, desc, tm)
		local tabtitle, tabwidth = "Map", 80;
		for k, v in pairs(md.data) do
			--if v.feature == "taboptions" then
			--	tabtitle = v.tabtitle;
			--	tabwidth = v.tabwidth;
			--end
		end
		local f = RDXDB.GetObjectInstance(path);
		local tab = tabbox:GetTabBar():AddTab(tabwidth, function(self, arg1)
			tabbox:SetClient(f);
			VFLUI.SetBackdrop(f, desc.bkd);
			--f.font = desc.font;
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
			func = function()
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
				func = function() 
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
				func = function()
					VFL.poptree:Release();
					tm:RemoveTab(path, true);
				end;
			});
		end
	end,
});



