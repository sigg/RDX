

-- Create a cell in the data table
local function CreateCell(parent)
	local self = VFLUI.AcquireFrame("Button");
	VFLUI.StdSetParent(self, parent); self:SetHeight(11);
	
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	local sbt = VFLUI.StatusBarTexture:new(self, nil, nil, "ARTWORK", 1);
	sbt:SetOrientation("HORIZONTAL");
	sbt:SetValue(1)
	sbt:SetTexture("Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Ruben");
	sbt:SetBlendMode("BLEND");
	sbt:SetVertexColor(1,1,1,1);
	sbt:SetTexCoord(0,1,0,1);
	sbt:Show();
	self.sbt = sbt;
	
	-- Create the button highlight texture
	local hltTexture = VFLUI.CreateTexture(self);
	hltTexture:SetAllPoints(self);
	hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	hltTexture:SetBlendMode("ADD");
	self:SetHighlightTexture(hltTexture);
	hltTexture:Show();
	self.hltTexture = hltTexture;
	
	local nameText = VFLUI.CreateFontString(self);
	nameText:SetDrawLayer("OVERLAY");
	VFLUI.SetFont(nameText, Fonts.Default, 11);
	nameText:SetShadowOffset(1,-1);
	nameText:SetShadowColor(0,0,0,.6);
	nameText:SetTextColor(1,1,1,1); nameText:SetJustifyH("LEFT");
	nameText:Show();
	self.nameText = nameText;
	
	local nText = VFLUI.CreateFontString(self);
	nText:SetDrawLayer("OVERLAY");
	VFLUI.SetFont(nText, Fonts.Default, 11);
	nText:SetShadowOffset(1,-1);
	nText:SetShadowColor(0,0,0,.6);
	nText:SetTextColor(1,1,1,1); nText:SetJustifyH("RIGHT");
	nText:Show();
	self.nText = nText;
	
	self:Show();
	
	local function layout()
			local w = self:GetWidth();
			local h = self:GetHeight();
			self.sbt:ClearAllPoints();
			self.sbt:SetPoint("LEFT", self, "LEFT", 2, 0);
			self.sbt:SetWidth(w - 4);
			self.sbt:SetHeight(h);
			self.nameText:ClearAllPoints();
			self.nameText:SetPoint("CENTER", self, "CENTER");
			self.nameText:SetWidth(w - 4);
			self.nameText:SetHeight(h);
			self.nText:ClearAllPoints();
			self.nText:SetPoint("CENTER", self, "CENTER");
			self.nText:SetWidth(w - 4);
			self.nText:SetHeight(h);
	end
	self:SetScript("OnShow", layout);
	self:SetScript("OnSizeChanged", layout);


	-- Update the Destroy function
	self.Destroy = VFL.hook(function(s)
		s:SetScript("OnShow", nil);
		s:SetScript("OnSizeChanged", nil);
		s.nameText:Destroy(); s.nameText = nil;
		s.nText:Destroy(); s.nText = nil;
		-- Destroy textures
		if s.hltTexture then s.hltTexture:Destroy(); s.hltTexture = nil; end
		s.sbt:Destroy(); s.sbt = nil;
	end, self.Destroy);
	self.OnDeparent = self.Destroy;

	return self;
end

----------------------------------------------
local dlg = nil;
local function EditTableMeterDialog(parent, path, md, callback)
	if dlg then return nil; end
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(370); dlg:SetHeight(520);
	dlg:SetText("TabMeter object: " .. path);
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("TabMeter") then RDXPM.RestoreLayout(dlg, "TabMeter"); end
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(346); sf:SetHeight(480);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Tab parameters")));
	
	local ed_name = VFLUI.LabeledEdit:new(ui, 150); ed_name:Show();
	ed_name:SetText(VFLI.i18n("Tab Title"));
	if md and md.data and md.data.title then ed_name.editBox:SetText(md.data.title); end
	ui:InsertFrame(ed_name);
	
	local ed_tabwidth = VFLUI.LabeledEdit:new(ui, 150); ed_tabwidth:Show();
	ed_tabwidth:SetText(VFLI.i18n("Tab Width"));
	if md and md.data and md.data.tabwidth then ed_tabwidth.editBox:SetText(md.data.tabwidth); end
	ui:InsertFrame(ed_tabwidth);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));
	
	local fe = RDXLF.SelectEditor:new(dlg); fe:Show();
	fe:SetDescriptor(md.data.filters);
	ui:InsertFrame(fe);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);

	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "TabMeter");
			dlg:Destroy(); dlg = nil;
		end);
	end
	
	VFL.AddEscapeHandler(esch);

	local function Save()
		md.data.title = ed_name.editBox:GetText();
		md.data.tabwidth = ed_tabwidth.editBox:GetText();
		md.data.filters = fe:GetDescriptor();
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
	name = "TabMeter";
	isFeatureDriven = true;
	invisible = true;
	New = function(path, md)
		md.version = 1;
		md.data = {};
		md.data.filters = {};
		md.data.title = "Meter";
		md.data.tabwidth = 80;
	end,
	Edit = function(path, md, parent)
		EditTableMeterDialog(parent or VFLFULLSCREEN, path, md, function(data) local inst = RDXDB.GetObjectInstance(path, true); if inst then inst.tm:SetFilter(RDXLF.SelectFunctor(data)); inst.tm:Reset(); end end);
	end,
	Instantiate = function(path, md)
		local mf = VFLUI.AcquireFrame("Frame");
		
		local l = VFLUI.List:new(mf, 12, CreateCell); 
		l:Show();
		mf.ml = l;
		
		local x = RDXLF.TableMeter:new(path, md.data);
		x:SetFilter(RDXLF.SelectFunctor(md.data.filters));
		RDXEvents:Bind("LOG_ROW_ADDED", x, x.Update, x);
		mf.tm = x
		
		local function layout()
			local w = mf:GetWidth();
			local h = mf:GetHeight();
			mf.ml:ClearAllPoints();
			mf.ml:SetPoint("CENTER", mf, "CENTER", 0, -15);
			mf.ml:SetWidth(w - 2);
			mf.ml:SetHeight(h - 2 - 15);
			mf.ml:Rebuild();
		end
		mf:SetScript("OnShow", layout);
		mf:SetScript("OnSizeChanged", layout);
		
		mf.a = {};
		
		mf.ml:SetDataSource(function(cell, data, pos, absPos)
			cell:SetScript("OnClick", nil);
			cell.nameText:SetText(data.unit.name or "None");
			cell.nText:SetText(data.value .. " / " .. string.format("%d", VFL.clamp(data.value/mf.tm.data.valuetotal, 0, 1) * 100) .. "%");
			cell.sbt:SetValueAndColorTable(VFL.clamp(data.value/mf.tm.data.valuemax, 0, 1), _blue);
		end, VFL.ArrayLiterator(mf.a));
		
		local function updatelist()
			VFL.empty(mf.a);
			for k, v in pairs (mf.tm.data.list) do
				table.insert(mf.a, v);
			end
		end
		
		--function
		VFLT.AdaptiveUnschedule2("TabMeter" .. path)
		VFLT.AdaptiveSchedule2("TabMeter" .. path, 2, function()
			if mf.tm and mf.tm.data and mf.tm.data.valuetotal > 0 then
				--sort
				table.sort(mf.a, function(x1,x2) return x1.value > x2.value; end);
				mf.ml:Update();
			end
		end)
		
		-- update list size
		RDXEvents:Bind(path .. "UNIT_METER_LIST_UPDATE", nil, updatelist, path .. "UNIT_METER_LIST_UPDATE")
		updatelist();
		return mf;
	end,
	Deinstantiate = function(instance, path, md)
		--instance:_Hide(RDX.smooth, nil, function() instance:Destroy(); instance._path = nil; instance = nil; end);
		--if instance.m then
		--	instance.m:Destroy();
		--	instance.m = nil;
		--end
		RDXEvents:Unbind(path .. "UNIT_METER_LIST_UPDATE");
		VFLT.AdaptiveUnschedule2("TabMeter" .. path)
		instance.ml:Destroy()
		instance.ml = nil;
		instance.tm:Destroy();
		instance.tm = nil;
		VFL.empty(instance.a);
		instance.a = nil;
		instance:Destroy();
		instance = nil;
	end,
	OpenTab = function(tabbox, path, md, objdesc, desc, tm)
		local tabtitle, tabwidth = md.data.title or "Tab", md.data.tabwidth or 80;
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
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Wipe data"),
			func = function() 
				VFL.poptree:Release(); 
				local x = RDXDB.GetObjectInstance(path);
				x.tm:Reset();
				x.ml:Update();
				--local dk, pkg, file = RDXDB.ParsePath(path);
				--RDXDBEvents:Dispatch("OBJECT_UPDATED", dk, pkg, file);
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