-- Obj_TableLog.lua
-- OpenRDX
-- Sigg / Rashgarroth EU
-- Daniel Ly

local dlg = nil;
local function EditTableLogDialog(parent, path, md, callback)
	------------------ CREATE
	if dlg then return nil; end
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(370); dlg:SetHeight(480);
	dlg:SetText(VFLI.i18n("Filter object: ") .. path);
	dlg:SetClampedToScreen(true);
	dlg:Show();
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	--sf:SetWidth(346); sf:SetHeight(430);
	sf:SetWidth(370 - 16); sf:SetHeight(480 - 25);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	----------------- POPULATE
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Core parameters")));
	
	local ed_size = VFLUI.LabeledEdit:new(ui, 200); ed_size:Show();
	ed_size:SetText(VFLI.i18n("Table size"));
	if md.data and md.data.size then ed_size.editBox:SetText(md.data.size); else ed_size.editBox:SetText("0"); end
	ui:InsertFrame(ed_size);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));
	
	local chk_fe = VFLUI.Checkbox:new(ui); chk_fe:Show();
	chk_fe:SetText(VFLI.i18n("Use Filter"));
	if md.data and md.data.filter then chk_fe:SetChecked(true); else chk_fe:SetChecked(); end
	ui:InsertFrame(chk_fe);

	local fe = Omni.FilterEditor:new(dlg); fe:Show();
	fe:SetDescriptor(md.data);
	ui:InsertFrame(fe);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);

	----------------- INTERACT
	local esch = function() dlg:Destroy(); dlg = nil; end
	VFL.AddEscapeHandler(esch);
	
	local function Save()
		if chk_fe:GetChecked() then 
			md.data = fe:GetDescriptor();
		else
			md.data = {};
		end
		local size = ed_size.editBox:GetNumber();
		if size == 0 then size = 1000; end
		md.data.size = size;
		md.data.filter = chk_fe:GetChecked();
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
	
	----------------- DESTROY
	dlg.Destroy = VFL.hook(function(s)
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end

-- Create the local session.
local localSess = Omni.Session:new("Local");
localSess.isLocal = true;

local n, row;

local function AddRow(x, log)
	if x.filterFunc(nil, log) then
		n, row = #x.data, nil;
		if(n >= x.sizemax) then row = table.remove(x.data, 1); VFL.empty(row); else row = {}; end
		row = VFL.copy(log);
		row.sg = nil; row.tg = nil; 
		--VFL.print(row.tm);
		table.insert(x.data, row);
		OmniEvents:Dispatch("TABLE_DATA_CHANGED", x);
	end
end

-- Registration and controls for the FilterSet object type.
RDXDB.RegisterObjectType({
	name = "TableLog";
	New = function(path, md)
		md.version = 1;
		md.data = {};
		md.data.size = 1000;
	end,
	Edit = function(path, md, parent)
		EditTableLogDialog(parent or VFLFULLSCREEN, path, md, function(data) local inst = RDXDB.GetObjectInstance(path); if data.filter then inst.filterFunc = Omni.FilterFunctor(data); else inst.filterFunc = function() return true; end; end VFL.empty(inst.data); end);
	end,
	Open = function(path, md)
		RDXDB.GetObjectInstance(path);
	end,
	--Close = function(path, md)
	--	RDXDB._RemoveInstance(path);
	--end,
	Instantiate = function(path, md)
		local x = Omni.Table:new(path);
		x.immutable = true;
		x.displayTime = "ABSOLUTE";
		x.source = UnitName("player");
		x.data = RDXGetTableLogs(path);
		x.timeOffset = 0;
		local sysEpoch = VFLT.GetSystemEpoch();
		if sysEpoch then
			x.timeOffset = math.modf(sysEpoch:GetKernelTimeCorrection() * 10);
		else
			VFLEvents:Bind("SYSTEM_EPOCH_ESTABLISHED", nil, function(syse)
				x.timeOffset = math.modf(syse:GetKernelTimeCorrection() * 10);
				VFLEvents:Unbind("omni_init");
			end, "omni_init");
		end
		x.sizemax = md.data.size or 1000;
		x.path = path;
		if md.data.filter then
			x.filterFunc = Omni.FilterFunctor(md.data);
		else
			x.filterFunc = function() return true; end;
		end
		RDXEvents:Bind("LOG_ROW_ADDED", nil, function(logrow) AddRow(x, logrow); end, x);
		localSess:AddTable(x);
		return x;
	end,
	--Deinstantiate = function(instance, path, md, emb)
	--	localSess:RemoveTable(instance);
	--	RDXEvents:Unbind(instance);
	--	instance.filterFunc = nil;
	--	instance.path = nil;
	--	instance.sizemax = nil;
	--	instance:Destroy(); instance = nil;
	--end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function() 
				VFL.poptree:Release(); 
				RDXDB.OpenObject(path, "Edit");
			end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Analyse"),
			func = function() 
				VFL.poptree:Release(); 
				Omni.ToggleOmniBrowser(path, dlg); 
			end
		});
		if not RDXDB.PathHasInstance(path) then
			table.insert(mnu, {
				text = VFLI.i18n("Open"),
				func = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Open");
				end
			});
		end
	end,
});