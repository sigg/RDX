-- Obj_TableMeter.lua
-- OpenRDX
-- Sigg / Rashgarroth EU
-- Daniel Ly

-- tablemeter

RDXLF.TableMeter = {};
RDXLF.TableMeter.__index = RDXLF.TableMeter;
function RDXLF.TableMeter:new(name)
	local self = {};
	setmetatable(self, RDXLF.TableMeter);
	if name then self.name = name; else self.name = "(anonymous)"; end
	self.valuemax = 1; self.valuetotal = 0;
	self.data = {};
	self.sig = RDXEvents:LockSignal(name .. "UNIT_METER_UPDATE");
	self.filter = nil;
	return self;
end

function RDXLF.TableMeter:Destroy()
	self.filter = nil;
	RDXEvents:DeleteKey(self.name .. "UNIT_METER_UPDATE");
	self.sig = nil;
	VFL.empty(self.data); self.data = nil;
	self.valuemax = nil; self.valuetotal = nil;
	self.name = nil;
end

function RDXLF.TableMeter:Reset()
	self.valuemax = 1; self.valuetotal = 0;
	VFL.empty(self.data);
end

function RDXLF.TableMeter:Size()
	return VFL.tsize(self.data);
end

function RDXLF.TableMeter:GetInfo(GUID)
	local tableinfo = self.data[GUID];
	if tableinfo then
		return true, tableinfo.value, self.valuemax, self.valuetotal;
	else
		return nil;
	end
end

function RDXLF.TableMeter:GetValue(GUID)
	local tableinfo = self.data[GUID];
	if tableinfo then
		return tableinfo.value;
	else
		return O;
	end
end

function RDXLF.TableMeter:SetFilter(func)
	self.filter = func;
end

local flag, data, un;
function RDXLF.TableMeter:Update(log, unitsrc, unittgt)
	flag, data, un = self.filter(log, unitsrc, unittgt);
	if flag then
		local tableinfo = self.data[log.sg];
		if not tableinfo then
			tableinfo = {}; 
			tableinfo.value = 0;
			tableinfo.unit = un;
			self.data[log.sg] = tableinfo;
		end
		if tableinfo then
			if type(data) ~= "number" then data = 1; end
			self.valuetotal = self.valuetotal + data;
			tableinfo.value = tableinfo.value + data;
			if (tableinfo.value > self.valuemax) then self.valuemax = tableinfo.value; end
			self.sig:Raise(tableinfo.unit, tableinfo.unit.nid, tableinfo.unit.uid);
		end
	end
end

----------------------------------------------
RDXLF.SelectEditor = {};
function RDXLF.SelectEditor:new(parent)
	local dlg = VFLUI.AcquireFrame("Frame");
	if parent then
		dlg:SetParent(parent); 
		dlg:SetFrameStrata(parent:GetFrameStrata());
		dlg:SetFrameLevel(parent:GetFrameLevel() + 3);
	end
	dlg:SetWidth(346); dlg:SetHeight(340); 
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:Show();

	-- Scrollframe
	local sf = VFLUI.VScrollFrame:new(dlg);
	sf:SetWidth(320); sf:SetHeight(330);
	sf:SetPoint("TOPLEFT", dlg, "TOPLEFT", 5, -5);
	sf:Show();

	-- Root
	local ui = VFLUI.CompoundFrame:new(sf); ui.isLayoutRoot = true;

	-- Event + Modifier types
	local ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText(VFLI.i18n("Event Types"));
	ui:InsertFrame(ctr);
	local ctd = VFLUI.RadioGroup:new(ctr); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	local eventMap = RDXMD.idToEvent;
	local modifierMap = RDXMD.idToExtd;
	ctd:SetLayout(#eventMap + #modifierMap, 2);
	for i=1,#eventMap do 
		ctd.buttons[i]:SetText(VFL.strtcolor(RDXMD.GetEventTypeColor(i)) .. RDXMD.GetEventType(i) .. "|r");
	end
	for i=#eventMap+1,#eventMap+#modifierMap do 
		ctd.buttons[i]:SetText(RDXMD.GetExtdType(i - #eventMap));
	end
	local etypes_container, etypes_checks = ctr,ctd;
	
	ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText(VFLI.i18n("Unit type"));
	ui:InsertFrame(ctr);
	ctd = VFLUI.RadioGroup:new(ctr); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	ctd:SetLayout(2, 2);
	ctd.buttons[1]:SetText(VFLI.i18n("Source"));
	ctd.buttons[2]:SetText(VFLI.i18n("Target"));
	local dtypes_container, dtypes_checks = ctr, ctd;

	-- Ability Filter
	ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText(VFLI.i18n("Ability"));
	ui:InsertFrame(ctr);
	ctd = VFLUI.LabeledEdit:new(ctr, 250); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	ctd:SetText(VFLI.i18n("* is a wildcard"));
	local abil_container, abil_edit = ctr,ctd;	

	--- Layout Engine Bootstrap
	sf:SetScrollChild(ui);
	ui:SetWidth(sf:GetWidth());
	ui:DialogOnLayout(); ui:Show();

	function dlg:GetDescriptor()
		local desc = {};
		if not etypes_container:IsCollapsed() then
			desc.etypes = {};
			desc.etypes[etypes_checks:GetValue()] = true;
		else
			desc.etypes = nil;
		end
		if not dtypes_container:IsCollapsed() then
			desc.dtypes = {};
			desc.dtypes[dtypes_checks:GetValue()] = true;
		else
			desc.dtypes = nil;
		end

		if not abil_container:IsCollapsed() then desc.abil = abil_edit.editBox:GetText(); else desc.abil = nil; end
		if desc.abil == "" then desc.abil = nil; end

		return desc;
	end
	
	function dlg:SetDescriptor(desc)
		if not desc then return; end
		if desc.etypes then
			etypes_container:ToggleCollapsed();
			for i=1,#RDXMD.idToEvent + #RDXMD.idToExtd do
				if desc.etypes[i] then etypes_checks:SetValue(i); end
			end
		end
		
		if desc.dtypes then
			dtypes_container:ToggleCollapsed();
			if desc.dtypes[1] then
				dtypes_checks:SetValue(1);
			elseif desc.dtypes[2] then
				dtypes_checks:SetValue(2);
			else
				dtypes_checks:SetValue(1);
			end
		end
		
		if desc.abil then
			abil_container:ToggleCollapsed();
			abil_edit.editBox:SetText(desc.abil);
		end
	end

	dlg.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil;
		s.SetDescriptor = nil;
		sf:SetScrollChild(nil);
		ui:Destroy(); ui = nil; sf:Destroy(); sf = nil;
	end, dlg.Destroy);

	return dlg;
end

function RDXLF.SelectFunctor(desc)
	if type(desc) ~= "table" then return VFL.True; end
	-- Load defaults
	local etypes, mtypes, dtypes, unit = {}, {}, {}, nil;
	for i=1,#RDXMD.idToEvent do etypes[i] = true; end
	for i=1,#RDXMD.idToExtd do mtypes[i] = true; end
	
	local re_abil = nil;

	if desc.etypes then 
		for i=1,#RDXMD.idToEvent do etypes[i] = desc.etypes[i]; end
		for i=#RDXMD.idToEvent+1, #RDXMD.idToEvent+#RDXMD.idToExtd do mtypes[i - #RDXMD.idToEvent] = desc.etypes[i]; end
	end
	
	if desc.dtypes then
		if desc.dtypes[1] then
			dtypes[1] = true;
		elseif desc.dtypes[2] then
			dtypes[2] = true;
		end
	end
	
	if desc.abil then re_abil = VFL.WildcardToRegex(strlower(desc.abil)); end
	
	return function(row, unitsrc, unittgt)
		if re_abil and (not strfind(strlower(row.a or ""), re_abil)) then return nil; end
		if dtypes[1] and unitsrc then 
			--VFL.print("point3");
			unit = unitsrc;
		elseif dtypes[2] and unittgt then 
			unit = unittgt;
		else
			return nil;
		end
		if etypes[row.y] then return true, row.x, unit; end
		if mtypes[1] and row.xir then return true, row.xir, unit; end
		if mtypes[2] and row.xib then return true, row.xib, unit; end
		if mtypes[3] and row.xia then return true, row.xia, unit; end
		if mtypes[4] and row.xic then return true, row.xic, unit; end
		if mtypes[7] and row.xioh then return true, row.xioh, unit; end
		return nil;
	end
end
----------------------------------------------
local dlg = nil;
local function EditTableMeterDialog(parent, path, md, callback)
	if dlg then return nil; end
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(370); dlg:SetHeight(480);
	dlg:SetText("Meter object: " .. path);
	dlg:Show();
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(346); sf:SetHeight(430);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));
	
	local fe = RDXLF.SelectEditor:new(dlg); fe:Show();
	fe:SetDescriptor(md.data);
	ui:InsertFrame(fe);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);

	local esch = function() dlg:Destroy(); dlg = nil; end
	VFL.AddEscapeHandler(esch);

	local function Save()
		md.data = fe:GetDescriptor();
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

-- Registration and controls for the TableMeter object type.
RDXDB.RegisterObjectType({
	name = "TableMeter";
	New = function(path, md)
		md.version = 1;
		md.data = {};
	end,
	Edit = function(path, md, parent)
		EditTableMeterDialog(parent or VFLFULLSCREEN, path, md, function(data) local inst = RDXDB.GetObjectInstance(path); inst:SetFilter(RDXLF.SelectFunctor(data)); inst:Reset(); end);
	end,
	Open = function(path, md)
		RDXDB.GetObjectInstance(path);
	end,
	Instantiate = function(path, md)
		local x = RDXLF.TableMeter:new(path);
		x:SetFilter(RDXLF.SelectFunctor(md.data));
		RDXEvents:Bind("LOG_ROW_ADDED", x, x.Update, x);
		return x;
	end,
	--Deinstantiate = function(instance, path, md)
	--	RDXEvents:Unbind(instance);
	--	instance.filterFunc = nil;
	--	instance:Destroy(); instance = nil;
	--end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function() 
				VFL.poptree:Release(); 
				RDXDB.OpenObject(path, "Edit"); 
			end
		});
		--table.insert(mnu, {
		--	text = VFLI.i18n("Analyse..."),
		--	OnClick = function() 
		--		VFL.poptree:Release(); 
		--		Omni.ToggleOmniBrowser(path); 
		--	end
		--});
		if not RDXDB.PathHasInstance(path) then
			table.insert(mnu, {
				text = VFLI.i18n("Open"),
				OnClick = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Open");
				end
			});
		end
	end,
});

local wl = {};

local function BuildTabMeterList()
	VFL.empty(wl);
	local desc = nil;
	for pkg,data in pairs(RDXData) do
		for file,md in pairs(data) do
			if (type(md) == "table") and md.data and md.ty and string.find(md.ty, "TableMeter") then
				table.insert(wl, {text = RDXDB.MakePath(pkg, file)});
			end
		end
	end
	table.sort(wl, function(x1,x2) return x1.text<x2.text; end);
end

function RDXDB._fnListTabMeter() BuildTabMeterList(); return wl; end

--local SAMPLESIZE = 5; 
--local fWeight = ( (SAMPLESIZE-1)/SAMPLESIZE );
--local sWeight = 1 - fWeight;
--local interval_update = 2;
--local vps;

--vps = data / interval_update;
--if tableinfo.valueps < 50 then
--	tableinfo.valueps = vps;
--else
--	tableinfo.valueps = ((tableinfo.valueps * fWeight) + (vps * sWeight));
--end
-- if dps and dps > 0 then dps_text = strformat("%d", dps) .. "dps"; end