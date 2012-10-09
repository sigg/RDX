-- TabManager.lua
-- OpenRDX 
--

-- the instance
-- data is object data (list of tabs)
-- data[1] = "tabs:Chatframe1";
-- data[2] = "tabs:Chatframe3";
-- etc
-- desc is customization option from IDE
-- desc.height
-- desc.orientation
RDX.TabManager = {};
function RDX.TabManager:new(parent, path, data, desc)
	local self = {};
	local tabbox = VFLUI.TabBox:new(nil, desc.h, desc.orientation);
	VFLUI.SetBackdrop(tabbox, nil);
	tabbox:Show();
	
	local tabbar = tabbox:GetTabBar();
	-- init callback in case of tab switching.
	tabbar.OnTabMoved = function(self)
		local tabs = self:_GetTabs();
		-- je vide data
		VFL.empty(data);
		-- je réinsert
		for k,v in pairs(tabs) do
			if v._path then
				table.insert(data, v._path);
			end
		end
		
	end;
	
	self.tabbox = tabbox;
	self.tabbar = tabbar;
	self.count = 0;
	
	function self:AddTab(tabpath, save)
		local tab;
		if tabpath == "root" then
			local f = VFLUI.AcquireFrame("Frame");
			tab = tabbox:GetTabBar():AddTab(20, function(self, arg1) 
				end, 
				function() end,
				function(mnu, dlg)
					table.insert(mnu, {
						text = VFLI.i18n("Add"),
						OnClick = function() 
							VFL.poptree:Release(); 
							-- TODO
						end
					});
				end,
				true,
				true
			);
			tab._path = tabpath;
			tab.font:SetText("");
		else
			local md, _, _, _, objdesc = RDXDB.GetObjectData(tabpath);
			local flag = RDXDB.GetObjectInstance(tabpath, true);
			if flag then
				local f = VFLUI.SimpleText:new(nil, 5, 100);
				f:SetText("Already acquired!");
				tab = tabbox:GetTabBar():AddTab(md.data.tabwidth, function(self, arg1) 
					tabbox:SetClient(f);
					VFLUI.SetBackdrop(f, desc.bkd);
				end, function() end);
				tab.f = f;
				tab.error = true;
				tab.font:SetText("error");
			else
				tab = objdesc.OpenTab(tabbox, tabpath, md, objdesc, desc, self);
			end
			tab._path = tabpath;
		end
		-- store in data object.
		if save then
			table.insert(data, tabpath);
		end
		self.count = self.count + 1;
	end
	
	function self:RemoveTab(tabpath, save)
		local tabs = tabbar:_GetTabs();
		for k,v in pairs(tabs) do
			if v._path == tabpath then
				if v._path == "root" or v.error then
					v.f:Destroy(); v.f = nil;
				else
					RDXDB._RemoveInstance(v._path); v.f = nil;
				end
				tabbox:GetTabBar():RemoveTab(v);
				self.count = self.count - 1;
				-- remove from data object
				if save then
					VFL.vremove(data, tabpath);
				end
			end
		end
	end

	self.Destroy = VFL.hook(function(s)
		local tabs = tabbar:_GetTabs();
		for k,v in pairs(tabs) do
			if v._path == "root" or v.error then
				v.f:Destroy(); v.f = nil;
			else
				RDXDB._RemoveInstance(v._path); v.f = nil;
			end
			s.tabbox:GetTabBar():RemoveTab(v);
		end
		s.AddTab = nil;
		s.RemoveTab = nil;
		s.tabbox:Destroy();
		s.tabbox = nil;
		s.tabbar = nil;
		s.count = nil;
	end, self.Destroy);

	return self;
end

-----------------------------------------------------------
-- Window meta-control
-----------------------------------------------------------
local dlg = nil;
-- object TabManager
RDXDB.RegisterObjectType({
	name = "TabManager";
	version = 2;
	VersionMismatch = function(md)
		-- code update version 1 to version 2;
		md.version = 2;
		-- save md.data
		local tmpdata = nil;
		if md.data then
			tmpdata = VFL.copy(md.data);
			-- empty md.data
			VFL.empty(md.data);
		else
			md.data = {};
		end
		VFL.empty(md.data);
		if tmpdata.cfm then
			for k,v in pairs(tmpdata.cfm) do
				table.insert(md.data, v.op);
			end
		end
		table.insert(md.data, "root");
		-- clear
		VFL.empty(tmpdata);
		tmpdata = nil;
		return true;
	end;
	New = function(path, md)
		md.version = 2;
		md.data = {};
		table.insert(md.data, "root");
	end;
	Edit = function(path, md, parent)
		if dlg then return; end
		if (not path) or (not md) or (not md.data) then return nil; end
		--local inst = RDXDB.GetObjectInstance(path, true);

		dlg = VFLUI.Window:new(parent);
		VFLUI.Window.SetDefaultFraming(dlg, 22);
		dlg:SetTitleColor(0,0,.6);
		dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
		dlg:SetPoint("CENTER", VFLParent, "CENTER");
		dlg:SetWidth(310); dlg:SetHeight(270);
		dlg:SetText(VFLI.i18n("Edit TabManager: ") .. path);
		dlg:SetClampedToScreen(true);
		
		VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
		if RDXPM.Ismanaged("TabManager") then RDXPM.RestoreLayout(dlg, "TabManager"); end

		local le_names = VFLUI.ListEditor:new(dlg, md.data, function(cell,data) 
			cell.text:SetText(data);
		end);
		le_names:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
		le_names:SetWidth(300);	le_names:SetHeight(183); le_names:Show();
		
		dlg:Show();
		--dlg:_Show(RDX.smooth);

		local esch = function()
			--dlg:_Hide(RDX.smooth, nil, function()
				RDXPM.StoreLayout(dlg, "TabManager");
				dlg:Destroy(); dlg = nil;
			--end);
		end
		VFL.AddEscapeHandler(esch);
		
		local function Save()
			local desc = le_names:GetList();
			if desc then
				md.data = desc;
				--if inst then WriteFilter(inst, descid); end
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
			le_names:Destroy(); le_names = nil;
		end, dlg.Destroy);
	end;
	Instantiate = function(path, md, desc)
		local tm = RDX.TabManager:new(nil, path, md.data, desc);
		for k, v in pairs(md.data) do
			tm:AddTab(v);
		end
		return tm;
	end,
	Deinstantiate = function(instance, path, md)
		instance:Destroy();
		instance = nil;
	end,
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







