-- Obj_WindowTab.lua
-- OpenRDX
--

----------------------------------------------
local dlg = nil;
local function EditTabMapDialog(parent, path, md, callback)
	if dlg then
		RDX.printI(VFLI.i18n("A TabMap editor is already open. Please close it first."));
		return;
	end
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(370); dlg:SetHeight(520);
	dlg:SetText("TabMap object: " .. path);
	dlg:SetClampedToScreen(true);
	if RDXPM.Ismanaged("TabMap") then RDXPM.RestoreLayout(dlg, "TabMap"); end

	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
		
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(346); sf:SetHeight(480);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Tab parameters")));
	
	local ed_title = VFLUI.LabeledEdit:new(ui, 150); ed_title:Show();
	ed_title:SetText(VFLI.i18n("Title"));
	if md and md.data and md.data.title then ed_title.editBox:SetText(md.data.title); end
	ui:InsertFrame(ed_title);
	
	local ed_tabtitle = VFLUI.LabeledEdit:new(ui, 150); ed_tabtitle:Show();
	ed_tabtitle:SetText(VFLI.i18n("Tab Title"));
	if md and md.data and md.data.tabtitle then ed_tabtitle.editBox:SetText(md.data.tabtitle); end
	ui:InsertFrame(ed_tabtitle);
	
	local ed_tabwidth = VFLUI.LabeledEdit:new(ui, 150); ed_tabwidth:Show();
	ed_tabwidth:SetText(VFLI.i18n("Tab Width"));
	if md and md.data and md.data.tabwidth then ed_tabwidth.editBox:SetText(md.data.tabwidth); end
	ui:InsertFrame(ed_tabwidth);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));
	
	local fe = RDXLF.SelectEditor:new(dlg); fe:Show();
	fe:SetDescriptor(md.data.filters);
	ui:InsertFrame(fe);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);

	dlg:Show();
	--dlg:_Show(RDX.smooth);

	local esch = function()
		--dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "TabMap");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	
	VFL.AddEscapeHandler(esch);

	local function Save()
		md.data.NXAutoScaleOn = ed_title.editBox:GetText();
		md.data.NXKillShow = ed_tabtitle.editBox:GetText();
		md.data.NXMMFull = ed_tabwidth.editBox:GetText();
		md.data.NXMMAlpha = fe:GetDescriptor();
		
		
		
		
		if callback then callback(md.data); end
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
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end




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
		local dlgtab = VFLUI.Window:new();
		dlgtab:SetFraming(VFLUI.Framing.Sleek, 25, VFLUI.BorderlessDialogBackdrop2);
		dlgtab:SetTitleColor(0,.5,0);
		dlgtab:SetText(VFLI.i18n("Map"));
		
		local ca = dlgtab:GetClientArea();
		
		local mtab = RDXMAP.Map:Open(1, md.data);
		mtab.Frm:SetParent(ca);
		mtab.Frm:SetAllPoints(ca);
		dlgtab.mtab = mtab;
		
		local function layout()
			local w = ca:GetWidth();
			local h = ca:GetHeight();
			mtab.Frm:ClearAllPoints();
			mtab.Frm:SetPoint("CENTER", ca, "CENTER");
			mtab.Frm:SetWidth(w);
			mtab.Frm:SetHeight(h);
		end
		ca:SetScript("OnShow", layout);
		ca:SetScript("OnSizeChanged", layout);
		
		local closebtn = VFLUI.CloseButton:new()
		closebtn:SetScript("OnClick", function() VFL.print("hello"); end);
		dlgtab:AddButton(closebtn);
		
		return dlgtab;
	end,
	Deinstantiate = function(instance, path, md)
		--instance:_Hide(RDX.smooth, nil, function() instance:Destroy(); instance._path = nil; instance = nil; end);
		if instance.mtab then
			instance.mtab:Destroy();
			instance.mtab = nil;
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
			f:SetTitleColor(VFL.explodeRGBA(desc.titleColor));
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



