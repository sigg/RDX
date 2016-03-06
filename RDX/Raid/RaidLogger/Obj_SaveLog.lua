

-- Create the local session.
local SLSess = Omni.Session:new("Save Logs");
SLSess.isLocal = true;

RDXDB.RegisterObjectType({
	name = "SaveLog";
	invisible = true;
	New = function(path, md, format, logs)
		md.version = 1;
		md.data = {};
		md.data.format = format;
		md.data.logs = logs;
		md.data.size = 1000;
	end,
	Edit = function(path, md, parent)
		EditTableLogDialog(parent or VFLFULLSCREEN, path, md, function(data) local inst = RDXDB.GetObjectInstance(path); if data.filter then inst.filterFunc = Omni.FilterFunctor(data); else inst.filterFunc = function() return true; end; end VFL.empty(inst.data); end);
	end,
	Open = function(path, md)
		RDXDB.GetObjectInstance(path);
	end,
	Close = function(path, md)
		RDXDB._RemoveInstance(path);
	end,
	Instantiate = function(path, md)
		local x = Omni.Table:new(path);
		--x.immutable = true;
		x.displayTime = "ABSOLUTE";
		x.source = UnitName("player");
		x.data = md.data.logs;
		x.timeOffset = 0;
		--local sysEpoch = VFLT.GetSystemEpoch();
		--if sysEpoch then
		--	x.timeOffset = math.modf(sysEpoch:GetKernelTimeCorrection() * 10);
		--else
		--	VFLEvents:Bind("SYSTEM_EPOCH_ESTABLISHED", nil, function(syse)
		--		x.timeOffset = math.modf(syse:GetKernelTimeCorrection() * 10);
		--		VFLEvents:Unbind("omni_init");
		--	end, "omni_init");
		--end
		x.sizemax = md.data.size or 1000;
		x.path = path;
		--local tbl = md.data.tbl;
		
		--setmetatable(tbl, Omni.Table);
		x:SetFormat(md.data.format);
		
		SLSess:AddTable(x);
		return x;
	end,
	Deinstantiate = function(instance, path, md, emb)
		SLSess:RemoveTable(instance);
		instance.path = nil;
		instance.sizemax = nil;
		instance:Destroy(); instance = nil;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		--table.insert(mnu, {
		--	text = VFLI.i18n("Edit"),
		--	func = function() 
		--		VFL.poptree:Release(); 
		--		RDXDB.OpenObject(path, "Edit");
		--	end
		--});
		table.insert(mnu, {
			text = VFLI.i18n("Analyse"),
			func = function() 
				VFL.poptree:Release(); 
				Omni.ToggleOmniBrowser(path, dlg); 
			end
		});
		--if not RDXDB.PathHasInstance(path) then
		--	table.insert(mnu, {
		--		text = VFLI.i18n("Open"),
		--		func = function()
		--			VFL.poptree:Release();
		--			RDXDB.OpenObject(path, "Open");
		--		end
		--	});
		--end
	end,
});

RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RDXDB.Foreach(function(dk, pkg, file, md)
		if md.ty == "SaveLog" then 
			RDXDB.OpenObject(RDXDB.MakePath(dk, pkg, file), "Open");
		end
	end);
end);
