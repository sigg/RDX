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
		--local f = VFLUI.AcquireFrame("Frame");
		--local m = RDX.Map:new(1, f);
		--m:Show();
		-- Attempt to setup the window; if it fails, just bail out.
		--f.m = m;
		--local map = Nx.Map;
		local m = NxMap1;
		if not m then m = VFLUI.AcquireFrame("Frame"); end
		return m;
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
			if f.NxWin then f.NxWin:Enable(); end
		end,
		function()
			if f.NxWin then f.NxWin:Disable(); end
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

-- The Window object type.
RDXDB.RegisterObjectType({
	name = "TabQuest";
	isFeatureDriven = true;
	invisible = true;
	New = function(path, md)
		md.version = 1;
	end,
	Edit = function(path, md, parent)
		RDX.EditWindow(parent, path, md);
	end,
	Instantiate = function(path, md)
		--local f = VFLUI.AcquireFrame("Frame");
		--local m = RDX.Map:new(1, f);
		--m:Show();
		-- Attempt to setup the window; if it fails, just bail out.
		--f.m = m;
		--local map = Nx.Map;
		local m = NxQuestWatch;
		if not m then m = VFLUI.AcquireFrame("Frame"); end
		return m;
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
			f:Show();
		end,
		function() 
			f:Hide();
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


--------------- Tab Manager
--[[
RDXPM.RegisterTabCategory(VFLI.i18n("Maps"));

------------------------------------------
-- Update hooks
------------------------------------------
RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg, file, md)
	if md and md.ty == "TabMap" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "Maps")
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(pkg, file, newpkg, newfile, md)
	if md and md.ty == "TabMap" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "Maps")
	end
end);
RDXDBEvents:Bind("OBJECT_CREATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabMap" then
		local data = obj.data;
		local tit = "";
		--if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("Maps");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);
RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabMap" then
		RDXPM.UnregisterTab(path, "Maps");
		local data = obj.data;
		local tit = "";
		--if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("Maps");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);

-- run on UI load 
local function RegisterTabMap()
	for pkgName,pkg in pairs(RDXData) do
		for objName,obj in pairs(pkg) do
			if type(obj) == "table" and obj.ty == "TabMap" then 
				local path = RDXDB.MakePath(pkgName, objName);
				local data = obj.data;
				local tit = "";
				--if data then tit = obj.data.title; end
				RDXPM.RegisterTab({
					name = path;
					title = path .. " " .. tit;
					category = VFLI.i18n("Maps");
					GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
					GetBlankDescriptor = function() return {op = path}; end;
				});
			end
		end
	end
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	RegisterTabMap();
end);]]
