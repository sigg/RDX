-- Obj_MapInfo.lua
-- Sigg


local mapClasses = {};

function RDXMAP.RegisterMapClass(tbl)
	if not tbl then error(VFLI.i18n("expected table, got nil")); end
	local n = tbl.name;
	if not n then error(VFLI.i18n("attempt to register anonymous map class")); end
	if mapClasses[n] then error(VFLI.i18n("attempt to register duplicate map class")); end
	mapClasses[n] = tbl;
	return true;
end

local function GetMapClassByName(n)
	if not n then return nil; end
	return mapClasses[n];
end

--- Find a set given the descriptor returned by the set finder. not need
function RDXMAP.FindMap(descr)
	if not descr then return nil; end
	local cls = GetMapClassByName(descr.class); if not cls then return nil; end
	return cls.FindSet(descr);
end

--- Validate a set not need
function RDXMAP.ValidateSet(descr)
	if not descr then return nil; end
	local cls = GetSetClassByName(descr.class); if not cls then return nil; end
	if cls.ValidateSet then return cls.ValidateSet(descr); else return true; end
end

--- Create a new set finder
local noneDesc = {class = "none"};
RDXMAP.MapFinder = {};
function RDXMAP.MapFinder:new(parent)
	local self = VFLUI.SelectEmbed:new(parent, 150, function()
		local qq = {};
		for k,v in pairs(mapClasses) do table.insert(qq, {text = v.title, value = v}); end
		table.sort(qq, function(x1,x2) return x1.text < x2.text; end);
		return qq;
	end, function(ctl, desc)
		local cls = GetMapClassByName(desc.class);
		if cls then
			return cls.GetUI(ctl, desc), cls.title, cls;
		end
	end);
	self:SetText(VFLI.i18n("Map class:"));
	self:SetDescriptor(noneDesc);
	return self;
end

-- Create a trivial GetUI() function for the set finder.
function RDXMAP.TrivialMapFinderUI(class)
	return function(parent, desc)
		local ui = VFLUI.AcquireFrame("Frame");
		ui.GetDescriptor = function() return {class = class}; end
		ui.DialogOnLayout = VFL.Noop;
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		return ui;
	end;
end


RDXMAP.RegisterMapClass({
	name = "c",
	title = VFLI.i18n("Continent"),
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		if desc and desc.name then ed_name.editBox:SetText(desc.name); end
		ui:InsertFrame(ed_name);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 100); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale"));
		if desc and desc.sc then ed_scale.editBox:SetText(desc.sc); end
		ui:InsertFrame(ed_scale);
		
		local ed_x = VFLUI.LabeledEdit:new(ui, 100); ed_x:Show();
		ed_x:SetText(VFLI.i18n("X"));
		if desc and desc.x then ed_x.editBox:SetText(desc.x); end
		ui:InsertFrame(ed_x);
		
		local ed_y = VFLUI.LabeledEdit:new(ui, 100); ed_y:Show();
		ed_y:SetText(VFLI.i18n("Y"));
		if desc and desc.y then ed_y.editBox:SetText(desc.y); end
		ui:InsertFrame(ed_y);
		
		local ed_oldid = VFLUI.LabeledEdit:new(ui, 100); ed_oldid:Show();
		ed_oldid:SetText(VFLI.i18n("OldId"));
		if desc and desc.oid then ed_oldid.editBox:SetText(desc.oid); end
		ui:InsertFrame(ed_oldid);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() return { 
			class = "c";
			name = ed_name.editBox:GetText();
			sc = ed_scale.editBox:GetNumber();
			x = ed_x.editBox:GetNumber();
			y = ed_y.editBox:GetNumber();
			oid = ed_oldid.editBox:GetNumber(); 
		}; end

		return ui;
	end,
});

RDXMAP.RegisterMapClass({
	name = "z",
	title = VFLI.i18n("Zone"),
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		if desc and desc.name then ed_name.editBox:SetText(desc.name); end
		ui:InsertFrame(ed_name);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 100); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale"));
		if desc and desc.sc then ed_scale.editBox:SetText(desc.sc); end
		ui:InsertFrame(ed_scale);
		
		local ed_x = VFLUI.LabeledEdit:new(ui, 100); ed_x:Show();
		ed_x:SetText(VFLI.i18n("X"));
		if desc and desc.x then ed_x.editBox:SetText(desc.x); end
		ui:InsertFrame(ed_x);
		
		local ed_y = VFLUI.LabeledEdit:new(ui, 100); ed_y:Show();
		ed_y:SetText(VFLI.i18n("Y"));
		if desc and desc.y then ed_y.editBox:SetText(desc.y); end
		ui:InsertFrame(ed_y);
		
		local ed_oldid = VFLUI.LabeledEdit:new(ui, 100); ed_oldid:Show();
		ed_oldid:SetText(VFLI.i18n("OldId"));
		if desc and desc.oid then ed_oldid.editBox:SetText(desc.oid); end
		ui:InsertFrame(ed_oldid);
		
		local ed_cont = VFLUI.LabeledEdit:new(ui, 100); ed_cont:Show();
		ed_cont:SetText(VFLI.i18n("Continent"));
		if desc and desc.cont then ed_cont.editBox:SetText(desc.cont); end
		ui:InsertFrame(ed_cont);
		
		local ed_stzo = VFLUI.LabeledEdit:new(ui, 100); ed_stzo:Show();
		ed_stzo:SetText(VFLI.i18n("Start Zone"));
		if desc and desc.stzo then ed_stzo.editBox:SetText(desc.stzo); end
		ui:InsertFrame(ed_stzo);
		
		local ed_fact = VFLUI.LabeledEdit:new(ui, 100); ed_fact:Show();
		ed_fact:SetText(VFLI.i18n("Faction"));
		if desc and desc.fact then ed_fact.editBox:SetText(desc.fact); end
		ui:InsertFrame(ed_fact);
		
		local ed_milv = VFLUI.LabeledEdit:new(ui, 100); ed_milv:Show();
		ed_milv:SetText(VFLI.i18n("Min Level"));
		if desc and desc.milv then ed_milv.editBox:SetText(desc.milv); end
		ui:InsertFrame(ed_milv);
		
		local ed_malv = VFLUI.LabeledEdit:new(ui, 100); ed_malv:Show();
		ed_malv:SetText(VFLI.i18n("Max Level"));
		if desc and desc.malv then ed_malv.editBox:SetText(desc.malv); end
		ui:InsertFrame(ed_malv);
		
		local ed_fish = VFLUI.LabeledEdit:new(ui, 100); ed_fish:Show();
		ed_fish:SetText(VFLI.i18n("Fish Level"));
		if desc and desc.fish then ed_fish.editBox:SetText(desc.fish); end
		ui:InsertFrame(ed_fish);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() return { 
			class = "z"; 
			name = ed_name.editBox:GetText();
			sc = ed_scale.editBox:GetNumber();
			x = ed_x.editBox:GetNumber();
			y = ed_y.editBox:GetNumber();
			oid = ed_oldid.editBox:GetNumber(); 
			fish = ed_fish.editBox:GetNumber(); 
		}; end

		return ui;
	end,
});




local dlg = nil;
function RDX.MapInfoEditor(parent, path, md)
	if dlg then return; end
	
	local desc = md.data;
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(330); dlg:SetHeight(300);
	dlg:SetText("MapInfo Editor");
	dlg:SetClampedToScreen(true);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("MapInfo") then RDXPM.RestoreLayout(dlg, "MapInfo"); end
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(305); sf:SetHeight(240);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	
	local mf = RDXMAP.MapFinder:new(ui); mf:Show();
	ui:InsertFrame(mf); 
	if desc and desc.mf then mf:SetDescriptor(desc.mf); end
	
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "MapInfo");
			dlg:Destroy(); dlg = nil;
		end);
	end
	
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local function Save()
		desc.mf = mf:GetDescriptor();  
		VFL.EscapeTo(esch);
	end
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end




local function EditMapInfo(parent, path, md)
	--if RDX.IsDesignEditorOpen() then return; end
	--dState:LoadDescriptor(md.data, path);
	--RDX.DesignEditor(dState, function(x)
	--	md.data = x:GetDescriptor();
	--	RDXDB.NotifyUpdate(path);
	--end, path, parent, offline);
	RDX.MapInfoEditor(parent, path, md);
end

RDXDB.RegisterObjectType({
	name = "MapInfo";
	New = function(path, md)
		md.version = 1;
		md.data = {};
	end;
	Edit = function(path, md, parent)
		EditMapInfo(parent, path, md);
	end;
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

