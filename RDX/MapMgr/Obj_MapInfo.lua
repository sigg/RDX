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
		
		local ed_id = VFLUI.LabeledEdit:new(ui, 100); ed_id:Show();
		ed_id:SetText(VFLI.i18n("Id"));
		if desc and desc.id then ed_id.editBox:SetText(desc.id); end
		ui:InsertFrame(ed_id);
		
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		if desc and desc.Name then ed_name.editBox:SetText(desc.Name); end
		ui:InsertFrame(ed_name);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 100); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale"));
		if desc and desc.s then ed_scale.editBox:SetText(desc.s); end
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
		if desc and desc.oldid then ed_oldid.editBox:SetText(desc.oldid); end
		ui:InsertFrame(ed_oldid);
		
		local ed_FileName = VFLUI.LabeledEdit:new(ui, 100); ed_FileName:Show();
		ed_FileName:SetText(VFLI.i18n("FileName"));
		if desc and desc.FileName then ed_FileName.editBox:SetText(desc.FileName); end
		ui:InsertFrame(ed_FileName);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() --return { 
			desc.class = "c";
			desc.id = ed_id.editBox:GetNumber();
			desc.Name = ed_name.editBox:GetText();
			desc.s = ed_scale.editBox:GetNumber();
			desc.x = ed_x.editBox:GetNumber();
			desc.y = ed_y.editBox:GetNumber();
			desc.oldid = ed_oldid.editBox:GetNumber(); 
			desc.FileName = ed_FileName.editBox:GetText();
			return desc;
		--}; 
		end

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
		if desc and desc.Name then ed_name.editBox:SetText(desc.Name); end
		ui:InsertFrame(ed_name);
		
		local ed_c = VFLUI.LabeledEdit:new(ui, 100); ed_c:Show();
		ed_c:SetText(VFLI.i18n("Continent mapid"));
		if desc and desc.c then ed_c.editBox:SetText(desc.c); end
		ui:InsertFrame(ed_c);
		
		local ed_Cont = VFLUI.LabeledEdit:new(ui, 100); ed_Cont:Show();
		ed_Cont:SetText(VFLI.i18n("Continent id"));
		if desc and desc.Cont then ed_Cont.editBox:SetText(desc.Cont); end
		ui:InsertFrame(ed_Cont);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 100); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale"));
		if desc and desc.s then ed_scale.editBox:SetText(desc.s); end
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
		if desc and desc.oldid then ed_oldid.editBox:SetText(desc.oldid); end
		ui:InsertFrame(ed_oldid);
		
		local ed_o = VFLUI.LabeledEdit:new(ui, 100); ed_o:Show();
		ed_o:SetText(VFLI.i18n("Overlay"));
		if desc and desc.o then ed_o.editBox:SetText(desc.o); end
		ui:InsertFrame(ed_o);
		
		local chk_StartZone = VFLUI.Checkbox:new(ui); chk_StartZone:Show();
		chk_StartZone:SetText("Start Zone");
		if desc and desc.StartZone then chk_StartZone:SetChecked(true); else chk_StartZone:SetChecked(); end
		ui:InsertFrame(chk_StartZone);
		
		local chk_Explored = VFLUI.Checkbox:new(ui); chk_Explored:Show();
		chk_Explored:SetText("Explored");
		if desc and desc.Explored then chk_Explored:SetChecked(true); else chk_Explored:SetChecked(); end
		ui:InsertFrame(chk_Explored);
		
		local ed_fact = VFLUI.LabeledEdit:new(ui, 100); ed_fact:Show();
		ed_fact:SetText(VFLI.i18n("Faction"));
		if desc and desc.faction then ed_fact.editBox:SetText(desc.faction); end
		ui:InsertFrame(ed_fact);
		
		local ed_milv = VFLUI.LabeledEdit:new(ui, 100); ed_milv:Show();
		ed_milv:SetText(VFLI.i18n("Min Level"));
		if desc and desc.minLvl then ed_milv.editBox:SetText(desc.minLvl); end
		ui:InsertFrame(ed_milv);
		
		local ed_malv = VFLUI.LabeledEdit:new(ui, 100); ed_malv:Show();
		ed_malv:SetText(VFLI.i18n("Max Level"));
		if desc and desc.maxLvl then ed_malv.editBox:SetText(desc.maxLvl); end
		ui:InsertFrame(ed_malv);
		
		local ed_fish = VFLUI.LabeledEdit:new(ui, 100); ed_fish:Show();
		ed_fish:SetText(VFLI.i18n("Fish Level"));
		if desc and desc.fish then ed_fish.editBox:SetText(desc.fish); end
		ui:InsertFrame(ed_fish);
		
		local ed_MId = VFLUI.LabeledEdit:new(ui, 100); ed_MId:Show();
		ed_MId:SetText(VFLI.i18n("MId"));
		if desc and desc.MId then ed_MId.editBox:SetText(desc.MId); end
		ui:InsertFrame(ed_MId);
		
		local ed_QAchievementId = VFLUI.LabeledEdit:new(ui, 100); ed_QAchievementId:Show();
		ed_QAchievementId:SetText(VFLI.i18n("Quest Alliance"));
		if desc and desc.QAchievementId then ed_QAchievementId.editBox:SetText(desc.QAchievementId); end
		ui:InsertFrame(ed_QAchievementId);
		
		local ed_QAchievementIdH = VFLUI.LabeledEdit:new(ui, 100); ed_QAchievementIdH:Show();
		ed_QAchievementIdH:SetText(VFLI.i18n("Quest Horde"));
		if desc and desc.QAchievementIdH then ed_QAchievementIdH.editBox:SetText(desc.QAchievementIdH); end
		ui:InsertFrame(ed_QAchievementIdH);
		
		local ed_ScaleAdjust = VFLUI.LabeledEdit:new(ui, 100); ed_ScaleAdjust:Show();
		ed_ScaleAdjust:SetText(VFLI.i18n("ScaleAdjust"));
		if desc and desc.ScaleAdjust then ed_ScaleAdjust.editBox:SetText(desc.ScaleAdjust); end
		ui:InsertFrame(ed_ScaleAdjust);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() --return { 
			desc.class = "z"; 
			desc.Name = ed_name.editBox:GetText();
			desc.c = ed_c.editBox:GetNumber();
			desc.Cont = ed_Cont.editBox:GetNumber();
			desc.s = ed_scale.editBox:GetNumber();
			desc.x = ed_x.editBox:GetNumber();
			desc.y = ed_y.editBox:GetNumber();
			desc.oldid = ed_oldid.editBox:GetNumber();
			desc.o = ed_o.editBox:GetText();
			desc.StartZone = chk_StartZone:GetChecked();
			desc.Explored = chk_Explored:GetChecked();
			desc.faction = ed_fact.editBox:GetNumber();
			desc.minLvl = ed_milv.editBox:GetNumber();
			desc.maxLvl = ed_malv.editBox:GetNumber();
			desc.fish = ed_fish.editBox:GetNumber();
			desc.MId = ed_MId.editBox:GetNumber();
			desc.QAchievementId = ed_QAchievementId.editBox:GetNumber();
			desc.QAchievementIdH = ed_QAchievementIdH.editBox:GetNumber();
			desc.ScaleAdjust = ed_ScaleAdjust.editBox:GetNumber();
			return desc;
		--}; 
		end

		return ui;
	end,
});

RDXMAP.RegisterMapClass({
	name = "ci",
	title = VFLI.i18n("City"),
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		if desc and desc.Name then ed_name.editBox:SetText(desc.Name); end
		ui:InsertFrame(ed_name);
		
		local ed_c = VFLUI.LabeledEdit:new(ui, 100); ed_c:Show();
		ed_c:SetText(VFLI.i18n("Continent mapid"));
		if desc and desc.c then ed_c.editBox:SetText(desc.c); end
		ui:InsertFrame(ed_c);
		
		local ed_Cont = VFLUI.LabeledEdit:new(ui, 100); ed_Cont:Show();
		ed_Cont:SetText(VFLI.i18n("Continent id"));
		if desc and desc.Cont then ed_Cont.editBox:SetText(desc.Cont); end
		ui:InsertFrame(ed_Cont);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 100); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale"));
		if desc and desc.s then ed_scale.editBox:SetText(desc.s); end
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
		if desc and desc.oldid then ed_oldid.editBox:SetText(desc.oldid); end
		ui:InsertFrame(ed_oldid);
		
		--local ed_o = VFLUI.LabeledEdit:new(ui, 100); ed_o:Show();
		--ed_o:SetText(VFLI.i18n("Overlay"));
		--if desc and desc.o then ed_o.editBox:SetText(desc.o); end
		--ui:InsertFrame(ed_o);
		
		--local chk_StartZone = VFLUI.Checkbox:new(ui); chk_StartZone:Show();
		--chk_StartZone:SetText("Start Zone");
		--if desc and desc.StartZone then chk_StartZone:SetChecked(true); else chk_StartZone:SetChecked(); end
		--ui:InsertFrame(chk_StartZone);
		
		--local chk_Explored = VFLUI.Checkbox:new(ui); chk_Explored:Show();
		--chk_Explored:SetText("Explored");
		--if desc and desc.Explored then chk_Explored:SetChecked(true); else chk_Explored:SetChecked(); end
		--ui:InsertFrame(chk_Explored);
		
		local ed_fact = VFLUI.LabeledEdit:new(ui, 100); ed_fact:Show();
		ed_fact:SetText(VFLI.i18n("Faction"));
		if desc and desc.faction then ed_fact.editBox:SetText(desc.faction); end
		ui:InsertFrame(ed_fact);
		
		local ed_milv = VFLUI.LabeledEdit:new(ui, 100); ed_milv:Show();
		ed_milv:SetText(VFLI.i18n("Min Level"));
		if desc and desc.minLvl then ed_milv.editBox:SetText(desc.minLvl); end
		ui:InsertFrame(ed_milv);
		
		local ed_malv = VFLUI.LabeledEdit:new(ui, 100); ed_malv:Show();
		ed_malv:SetText(VFLI.i18n("Max Level"));
		if desc and desc.maxLvl then ed_malv.editBox:SetText(desc.maxLvl); end
		ui:InsertFrame(ed_malv);
		
		--local ed_fish = VFLUI.LabeledEdit:new(ui, 100); ed_fish:Show();
		--ed_fish:SetText(VFLI.i18n("Fish Level"));
		--if desc and desc.fish then ed_fish.editBox:SetText(desc.fish); end
		--ui:InsertFrame(ed_fish);
		
		local ed_MId = VFLUI.LabeledEdit:new(ui, 100); ed_MId:Show();
		ed_MId:SetText(VFLI.i18n("MId"));
		if desc and desc.MId then ed_MId.editBox:SetText(desc.MId); end
		ui:InsertFrame(ed_MId);
		
		local ed_ScaleAdjust = VFLUI.LabeledEdit:new(ui, 100); ed_ScaleAdjust:Show();
		ed_ScaleAdjust:SetText(VFLI.i18n("MId"));
		if desc and desc.ScaleAdjust then ed_ScaleAdjust.editBox:SetText(desc.ScaleAdjust); end
		ui:InsertFrame(ed_ScaleAdjust);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() --return { 
			desc.class = "ci"; 
			desc.Name = ed_name.editBox:GetText();
			desc.c = ed_c.editBox:GetNumber();
			desc.Cont = ed_Cont.editBox:GetNumber();
			desc.s = ed_scale.editBox:GetNumber();
			desc.x = ed_x.editBox:GetNumber();
			desc.y = ed_y.editBox:GetNumber();
			desc.oldid = ed_oldid.editBox:GetNumber();
			--desc.o = ed_o.editBox:GetText();
			--desc.StartZone = chk_StartZone:GetChecked();
			--desc.Explored = chk_Explored:GetChecked();
			desc.faction = ed_fact.editBox:GetNumber();
			desc.minLvl = ed_milv.editBox:GetNumber();
			desc.maxLvl = ed_malv.editBox:GetNumber();
			--desc.fish = ed_fish.editBox:GetNumber();
			desc.MId = ed_MId.editBox:GetNumber();
			desc.ScaleAdjust = ed_ScaleAdjust.editBox:GetNumber();
			
			return desc;
		--}; 
		end

		return ui;
	end,
});

RDXMAP.RegisterMapClass({
	name = "bg",
	title = VFLI.i18n("Battleground"),
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		if desc and desc.Name then ed_name.editBox:SetText(desc.Name); end
		ui:InsertFrame(ed_name);
		
		local ed_c = VFLUI.LabeledEdit:new(ui, 100); ed_c:Show();
		ed_c:SetText(VFLI.i18n("Continent mapid"));
		if desc and desc.c then ed_c.editBox:SetText(desc.c); end
		ui:InsertFrame(ed_c);
		
		local ed_Cont = VFLUI.LabeledEdit:new(ui, 100); ed_Cont:Show();
		ed_Cont:SetText(VFLI.i18n("Continent id"));
		if desc and desc.Cont then ed_Cont.editBox:SetText(desc.Cont); end
		ui:InsertFrame(ed_Cont);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 100); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale"));
		if desc and desc.s then ed_scale.editBox:SetText(desc.s); end
		ui:InsertFrame(ed_scale);
		
		local ed_x = VFLUI.LabeledEdit:new(ui, 100); ed_x:Show();
		ed_x:SetText(VFLI.i18n("X"));
		if desc and desc.x then ed_x.editBox:SetText(desc.x); end
		ui:InsertFrame(ed_x);
		
		local ed_y = VFLUI.LabeledEdit:new(ui, 100); ed_y:Show();
		ed_y:SetText(VFLI.i18n("Y"));
		if desc and desc.y then ed_y.editBox:SetText(desc.y); end
		ui:InsertFrame(ed_y);
		
		--local ed_oldid = VFLUI.LabeledEdit:new(ui, 100); ed_oldid:Show();
		--ed_oldid:SetText(VFLI.i18n("OldId"));
		--if desc and desc.oldid then ed_oldid.editBox:SetText(desc.oldid); end
		--ui:InsertFrame(ed_oldid);
		
		--local ed_o = VFLUI.LabeledEdit:new(ui, 100); ed_o:Show();
		--ed_o:SetText(VFLI.i18n("Overlay"));
		--if desc and desc.o then ed_o.editBox:SetText(desc.o); end
		--ui:InsertFrame(ed_o);
		
		--local chk_StartZone = VFLUI.Checkbox:new(ui); chk_StartZone:Show();
		--chk_StartZone:SetText("Start Zone");
		--if desc and desc.StartZone then chk_StartZone:SetChecked(true); else chk_StartZone:SetChecked(); end
		--ui:InsertFrame(chk_StartZone);
		
		--local chk_Explored = VFLUI.Checkbox:new(ui); chk_Explored:Show();
		--chk_Explored:SetText("Explored");
		--if desc and desc.Explored then chk_Explored:SetChecked(true); else chk_Explored:SetChecked(); end
		--ui:InsertFrame(chk_Explored);
		
		local ed_fact = VFLUI.LabeledEdit:new(ui, 100); ed_fact:Show();
		ed_fact:SetText(VFLI.i18n("Faction"));
		if desc and desc.faction then ed_fact.editBox:SetText(desc.faction); end
		ui:InsertFrame(ed_fact);
		
		--local ed_milv = VFLUI.LabeledEdit:new(ui, 100); ed_milv:Show();
		--ed_milv:SetText(VFLI.i18n("Min Level"));
		--if desc and desc.minLvl then ed_milv.editBox:SetText(desc.minLvl); end
		--ui:InsertFrame(ed_milv);
		
		--local ed_malv = VFLUI.LabeledEdit:new(ui, 100); ed_malv:Show();
		--ed_malv:SetText(VFLI.i18n("Max Level"));
		--if desc and desc.maxLvl then ed_malv.editBox:SetText(desc.maxLvl); end
		--ui:InsertFrame(ed_malv);
		
		--local ed_fish = VFLUI.LabeledEdit:new(ui, 100); ed_fish:Show();
		--ed_fish:SetText(VFLI.i18n("Fish Level"));
		--if desc and desc.fish then ed_fish.editBox:SetText(desc.fish); end
		--ui:InsertFrame(ed_fish);
		
		--local ed_MId = VFLUI.LabeledEdit:new(ui, 100); ed_MId:Show();
		--ed_MId:SetText(VFLI.i18n("MId"));
		--if desc and desc.MId then ed_MId.editBox:SetText(desc.MId); end
		--ui:InsertFrame(ed_MId);
		
		--local ed_ScaleAdjust = VFLUI.LabeledEdit:new(ui, 100); ed_ScaleAdjust:Show();
		--ed_ScaleAdjust:SetText(VFLI.i18n("MId"));
		--if desc and desc.ScaleAdjust then ed_ScaleAdjust.editBox:SetText(desc.ScaleAdjust); end
		--ui:InsertFrame(ed_ScaleAdjust);
		
		local ed_Short = VFLUI.LabeledEdit:new(ui, 100); ed_Short:Show();
		ed_Short:SetText(VFLI.i18n("Short Name"));
		if desc and desc.Short then ed_Short.editBox:SetText(desc.Short); end
		ui:InsertFrame(ed_Short);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() --return { 
			desc.class = "bg"; 
			desc.Name = ed_name.editBox:GetText();
			desc.c = ed_c.editBox:GetNumber();
			desc.Cont = ed_Cont.editBox:GetNumber();
			desc.s = ed_scale.editBox:GetNumber();
			desc.x = ed_x.editBox:GetNumber();
			desc.y = ed_y.editBox:GetNumber();
			--desc.oldid = ed_oldid.editBox:GetNumber();
			--desc.o = ed_o.editBox:GetText();
			--desc.StartZone = chk_StartZone:GetChecked();
			--desc.Explored = chk_Explored:GetChecked();
			desc.faction = ed_fact.editBox:GetNumber();
			--desc.minLvl = ed_milv.editBox:GetNumber();
			--desc.maxLvl = ed_malv.editBox:GetNumber();
			--desc.fish = ed_fish.editBox:GetNumber();
			--desc.MId = ed_MId.editBox:GetNumber();
			--desc.ScaleAdjust = ed_ScaleAdjust.editBox:GetNumber();
			desc.Short = ed_Short.editBox:GetText();
			return desc;
		--}; 
		end

		return ui;
	end,
});

RDXMAP.RegisterMapClass({
	name = "i",
	title = VFLI.i18n("Instance"),
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		if desc and desc.Name then ed_name.editBox:SetText(desc.Name); end
		ui:InsertFrame(ed_name);
		
		local ed_c = VFLUI.LabeledEdit:new(ui, 100); ed_c:Show();
		ed_c:SetText(VFLI.i18n("Continent mapid"));
		if desc and desc.c then ed_c.editBox:SetText(desc.c); end
		ui:InsertFrame(ed_c);
		
		local ed_Cont = VFLUI.LabeledEdit:new(ui, 100); ed_Cont:Show();
		ed_Cont:SetText(VFLI.i18n("Continent id"));
		if desc and desc.Cont then ed_Cont.editBox:SetText(desc.Cont); end
		ui:InsertFrame(ed_Cont);
		
		local ed_EntryMId = VFLUI.LabeledEdit:new(ui, 100); ed_EntryMId:Show();
		ed_EntryMId:SetText(VFLI.i18n("Map id"));
		if desc and desc.EntryMId then ed_EntryMId.editBox:SetText(desc.EntryMId); end
		ui:InsertFrame(ed_EntryMId);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 100); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale"));
		if desc and desc.s then ed_scale.editBox:SetText(desc.s); end
		ui:InsertFrame(ed_scale);
		
		local ed_x = VFLUI.LabeledEdit:new(ui, 100); ed_x:Show();
		ed_x:SetText(VFLI.i18n("X"));
		if desc and desc.x then ed_x.editBox:SetText(desc.x); end
		ui:InsertFrame(ed_x);
		
		local ed_y = VFLUI.LabeledEdit:new(ui, 100); ed_y:Show();
		ed_y:SetText(VFLI.i18n("Y"));
		if desc and desc.y then ed_y.editBox:SetText(desc.y); end
		ui:InsertFrame(ed_y);
		
		--local ed_oldid = VFLUI.LabeledEdit:new(ui, 100); ed_oldid:Show();
		--ed_oldid:SetText(VFLI.i18n("OldId"));
		--if desc and desc.oldid then ed_oldid.editBox:SetText(desc.oldid); end
		--ui:InsertFrame(ed_oldid);
		
		--local ed_o = VFLUI.LabeledEdit:new(ui, 100); ed_o:Show();
		--ed_o:SetText(VFLI.i18n("Overlay"));
		--if desc and desc.o then ed_o.editBox:SetText(desc.o); end
		--ui:InsertFrame(ed_o);
		
		--local chk_StartZone = VFLUI.Checkbox:new(ui); chk_StartZone:Show();
		--chk_StartZone:SetText("Start Zone");
		--if desc and desc.StartZone then chk_StartZone:SetChecked(true); else chk_StartZone:SetChecked(); end
		--ui:InsertFrame(chk_StartZone);
		
		--local chk_Explored = VFLUI.Checkbox:new(ui); chk_Explored:Show();
		--chk_Explored:SetText("Explored");
		--if desc and desc.Explored then chk_Explored:SetChecked(true); else chk_Explored:SetChecked(); end
		--ui:InsertFrame(chk_Explored);
		
		local ed_fact = VFLUI.LabeledEdit:new(ui, 100); ed_fact:Show();
		ed_fact:SetText(VFLI.i18n("Faction"));
		if desc and desc.faction then ed_fact.editBox:SetText(desc.faction); end
		ui:InsertFrame(ed_fact);
		
		local ed_milv = VFLUI.LabeledEdit:new(ui, 100); ed_milv:Show();
		ed_milv:SetText(VFLI.i18n("Min Level"));
		if desc and desc.minLvl then ed_milv.editBox:SetText(desc.minLvl); end
		ui:InsertFrame(ed_milv);
		
		local ed_malv = VFLUI.LabeledEdit:new(ui, 100); ed_malv:Show();
		ed_malv:SetText(VFLI.i18n("Max Level"));
		if desc and desc.maxLvl then ed_malv.editBox:SetText(desc.maxLvl); end
		ui:InsertFrame(ed_malv);
		
		--local ed_fish = VFLUI.LabeledEdit:new(ui, 100); ed_fish:Show();
		--ed_fish:SetText(VFLI.i18n("Fish Level"));
		--if desc and desc.fish then ed_fish.editBox:SetText(desc.fish); end
		--ui:InsertFrame(ed_fish);
		
		--local ed_MId = VFLUI.LabeledEdit:new(ui, 100); ed_MId:Show();
		--ed_MId:SetText(VFLI.i18n("MId"));
		--if desc and desc.MId then ed_MId.editBox:SetText(desc.MId); end
		--ui:InsertFrame(ed_MId);
		
		--local ed_ScaleAdjust = VFLUI.LabeledEdit:new(ui, 100); ed_ScaleAdjust:Show();
		--ed_ScaleAdjust:SetText(VFLI.i18n("MId"));
		--if desc and desc.ScaleAdjust then ed_ScaleAdjust.editBox:SetText(desc.ScaleAdjust); end
		--ui:InsertFrame(ed_ScaleAdjust);
		
		--local ed_Short = VFLUI.LabeledEdit:new(ui, 100); ed_Short:Show();
		--ed_Short:SetText(VFLI.i18n("Short Name"));
		--if desc and desc.Short then ed_Short.editBox:SetText(desc.Short); end
		--ui:InsertFrame(ed_Short);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() --return { 
			desc.class = "i"; 
			desc.Name = ed_name.editBox:GetText();
			desc.c = ed_c.editBox:GetNumber();
			desc.Cont = ed_Cont.editBox:GetNumber();
			desc.EntryMId = ed_EntryMId.editBox:GetNumber();
			desc.s = ed_scale.editBox:GetNumber();
			desc.x = ed_x.editBox:GetNumber();
			desc.y = ed_y.editBox:GetNumber();
			--desc.oldid = ed_oldid.editBox:GetNumber();
			--desc.o = ed_o.editBox:GetText();
			--desc.StartZone = chk_StartZone:GetChecked();
			--desc.Explored = chk_Explored:GetChecked();
			desc.faction = ed_fact.editBox:GetNumber();
			desc.minLvl = ed_milv.editBox:GetNumber();
			desc.maxLvl = ed_malv.editBox:GetNumber();
			--desc.fish = ed_fish.editBox:GetNumber();
			--desc.MId = ed_MId.editBox:GetNumber();
			--desc.ScaleAdjust = ed_ScaleAdjust.editBox:GetNumber();
			--desc.Short = ed_Short.editBox:GetText();
			return desc;
		--}; 
		end

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
		--VFL.EscapeTo(esch);
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
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});

