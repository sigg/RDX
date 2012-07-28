-- Obj_WindowTab.lua
-- OpenRDX
--


-- The Window object type.
RDXDB.RegisterObjectType({
	name = "TabWindow";
	isFeatureDriven = true;
	New = function(path, md)
		md.version = 1;
	end,
	Edit = function(path, md, parent)
		RDX.EditWindow(parent, path, md);
	end,
	Instantiate = function(path, md)
		local f = VFLUI.AcquireFrame("Frame");
		local w = RDX.Window:new(f);
		-- Attempt to setup the window; if it fails, just bail out.
		if not RDX.SetupWindow(path, w, md.data) then 
			w:Destroy();
		else
			RDXDK.StdMove(w, w:GetTitleBar());
			RDX:Debug(5, "Instantiate WindowObject<", path, ">");
			w:WMGetPositionalFrame():SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2);
			f.w = w;
		end
		return f;
	end,
	Deinstantiate = function(instance, path, md)
		--instance:_Hide(RDX.smooth, nil, function() instance:Destroy(); instance._path = nil; instance = nil; end);
		if instance.w then
			instance.w:Destroy();
			instance.w._path = nil;
			instance.w = nil;
		end
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
		table.insert(mnu, {
			text = VFLI.i18n("Transform Window"),
			OnClick = function() 
				VFL.poptree:Release();
				local pkg, file = RDXDB.ParsePath(path);
				md.ty = "Window";
				md.version = 2;
				RDXDBEvents:Dispatch("OBJECT_MOVED", pkg, file, pkg, file, md);
			end
		});
	end,
});

--
-- function to ckeck if a windows is secured or not.
--
function RDX.IsWindowTabSecured(path)
	
end

--------------- Tab Manager

RDXPM.RegisterTabCategory(VFLI.i18n("Windows"));

------------------------------------------
-- Update hooks
------------------------------------------
RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg, file, md)
	if md and md.ty == "TabWindow" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "Windows")
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(pkg, file, newpkg, newfile, md)
	if md and md.ty == "TabWindow" then
		local path = RDXDB.MakePath(pkg,file);
		RDXPM.UnregisterTab(path, "Windows")
	end
end);
RDXDBEvents:Bind("OBJECT_CREATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabWindow" then
		local data = obj.data;
		local tit = "";
		--if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("Windows");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);
RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(pkg, file) 
	local path = RDXDB.MakePath(pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "TabWindow" then
		RDXPM.UnregisterTab(path, "Windows");
		local data = obj.data;
		local tit = "";
		--if data then tit = obj.data.title; end
		RDXPM.RegisterTab({
			name = path;
			title = path .. " " .. tit;
			category = VFLI.i18n("Windows");
			GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
			GetBlankDescriptor = function() return {op = path}; end;
		});
	end
end);

-- run on UI load 
local function RegisterTabWindows()
	for pkgName,pkg in pairs(RDXData) do
		for objName,obj in pairs(pkg) do
			if type(obj) == "table" and obj.ty == "TabWindow" then 
				local path = RDXDB.MakePath(pkgName, objName);
				local data = obj.data;
				local tit = "";
				--if data then tit = obj.data.title; end
				RDXPM.RegisterTab({
					name = path;
					title = path .. " " .. tit;
					category = VFLI.i18n("Windows");
					GetUI = RDXPM.TrivialChatFrameUI(path, path .. " " .. tit);
					GetBlankDescriptor = function() return {op = path}; end;
				});
			end
		end
	end
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	RegisterTabWindows();
end);








--test

-- The Window object type.
RDXDB.RegisterObjectType({
	name = "TabMap";
	isFeatureDriven = true;
	New = function(path, md)
		md.version = 1;
	end,
	--Edit = function(path, md, parent)
	--	RDX.EditWindow(parent, path, md);
	--end,
	Instantiate = function(path, md)
		local f = VFLUI.AcquireFrame("Frame");
		--f:SetMaskTexture("Interface\\AddOns\\RDX_mediapack\\minimap\\SquareMinimapMask");
		
		for i = 1,12 do
			local tex = VFLUI.CreateTexture(f);
			--tex:SetAllPoints(f);
			--tex:SetTexture("Interface\\WorldMap\\TheCapeOfStranglethorn\\TheCapeOfStranglethorn6");
			tex:Show();
			f.tex = tex;
		end
		
		f:SetScript("OnResize", function() end);
		
		return f;
	end,
	Deinstantiate = function(instance, path, md)
		--instance:_Hide(RDX.smooth, nil, function() instance:Destroy(); instance._path = nil; instance = nil; end);
		--if instance.w then
		--	instance.w:Destroy();
		--	instance.w._path = nil;
		--	instance.w = nil;
		--end
		instance:Destroy();
		instance = nil;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		--table.insert(mnu, {
		--	text = VFLI.i18n("Edit"),
		--	OnClick = function()
		--		VFL.poptree:Release();
		--		RDXDB.OpenObject(path, "Edit", dlg);
		--	end
		--});
	end,
});


--------------- Tab Manager

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
end);
