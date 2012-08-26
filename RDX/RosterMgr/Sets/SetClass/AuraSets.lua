-- AuraSets.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- Aura sets are special sets maintained by the game engine. The contents
-- of an aura set are precisely those units which have the aura in question.

local MAX_UNITS = RDXDAL.NUM_UNITS;
local GetUnitByNumber = RDXDAL.GetUnitByNumber

-- Create an aura set for the given aura.
local function CreateAuraSet(type, name)
	local self = RDXDAL.Set:new();
	self.name = type .. "<" .. name .. ">";
	type = string.upper(type);

	-- The full rebuild function.
	local FullRebuild;
	if type == "DEBUFF" then
		function FullRebuild(x)
			local unit = nil;
			for i=1,MAX_UNITS do
				unit = GetUnitByNumber(i);
				if unit:IsCacheValid() and unit:HasDebuff(name) then x:_Set(i, true); else x:_Set(i, false); end
			end
		end
	elseif type == "BUFF" then
		function FullRebuild(x)
			local unit = nil;
			for i=1,MAX_UNITS do
				unit = GetUnitByNumber(i);
				if unit:IsCacheValid() and unit:HasBuff(name) then x:_Set(i, true); else x:_Set(i, false); end
			end
		end
	elseif type == "MYBUFF" then
		function FullRebuild(x)
			local unit = nil;
			for i=1,MAX_UNITS do
				unit = GetUnitByNumber(i);
				if unit:IsCacheValid() and unit:HasMyBuff(name) then x:_Set(i, true); else x:_Set(i, false); end
			end
		end
	else
		error(VFLI.i18n("invalid auraset type"));
	end

	-- The function invoked when an aura event triggers.
	local function OnAuraEvent(x, unit, _, apps)
		if(apps == 0) then x:_Set(unit.nid, false); else x:_Set(unit.nid, true); end
	end

	-- Bind/unbind events on act/deact.
	self._OnActivate = function(x)
		RDXEvents:Bind("UNIT_" .. type .. "_" .. name, x, OnAuraEvent, x);
		RDXEvents:Bind("DISRUPT_SETS", x, FullRebuild, x);
		FullRebuild(x);
	end;
	self._OnDeactivate = function(x)
		RDXEvents:Unbind(x);
	end

	return self;
end

-- Aura set databases
local bsets = {};
local dsets = {};
local mbsets = {};

--- Get the debuff set for the given debuff.
function RDXDAL.GetDebuffSet(spellid)
	local name;
	if type(spellid) == "number" then
		local auname = GetSpellInfo(spellid);
		if not auname then auname = spellid; end
		name =  auname;
	else
		name = spellid;
	end
	local ret = dsets[name];
	if not ret then
		ret = CreateAuraSet("Debuff", name);
		RDXDAL.RegisterSet(ret);
		dsets[name] = ret;
	end
	return ret;
end

--- Get the buff set for the given buff.
function RDXDAL.GetBuffSet(spellid)
	local name;
	if type(spellid) == "number" then
		local auname = GetSpellInfo(spellid);
		if not auname then auname = spellid; end
		name =  auname;
	else
		name = spellid;
	end
	local ret = bsets[name];
	if not ret then
		ret = CreateAuraSet("Buff", name);
		RDXDAL.RegisterSet(ret);
		bsets[name] = ret;
	end
	return ret;
end

function RDXDAL.GetMyBuffSet(spellid)
	local name;
	if type(spellid) == "number" then
		local auname = GetSpellInfo(spellid);
		if not auname then auname = spellid; end
		name =  auname;
	else
		name = spellid;
	end
	local ret = mbsets[name];
	if not ret then
		ret = CreateAuraSet("MyBuff", name);
		RDXDAL.RegisterSet(ret);
		mbsets[name] = ret;
	end
	return ret;
end


-----------------------------------------------------------------
-- AURA METASETS FILTERS
-----------------------------------------------------------------
function RDXDAL.AuraCachePopup(db, callback, frame, point, dx, dy)
	local qq = {};
	for _,v in pairs(db) do
		local dbEntry = v;
		table.insert(qq, {
			text = v.properName;
			texture = v.texture or "Interface\\InventoryItems\\WoWUnknownItem01.blp";
			OnClick = function()
				VFL.poptree:Release();
				callback(dbEntry);
			end
		});
	end
	table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
	VFL.poptree:Begin(150, 12, frame, point, dx, dy);
	VFL.poptree:Expand(nil, qq, 20);
end

RDXDAL.RegisterSetClass({
	name = "buff",
	title = VFLI.i18n("Buff"),
	GetUI = function(parent, desc)
		local ui = VFLUI.LabeledEdit:new(parent, 150);
		ui:SetText(VFLI.i18n("Buff Name")); ui:Show();
		if desc and desc.buff then
			if type(desc.buff) == "number" then
				local name = GetSpellInfo(desc.buff);
				if not name then name = desc.buff; end
				ui.editBox:SetText(name);
			else
				ui.editBox:SetText(desc.buff);
			end
		end

		local btn = VFLUI.Button:new(ui);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", ui.editBox, "LEFT"); btn:Show();
		btn:SetScript("OnClick", function()
			RDXDAL.AuraCachePopup(RDXDAL._GetBuffCache(), function(x) 
				if x then ui.editBox:SetText(x.properName); end
			end, btn, "CENTER");
		end);

		ui.GetDescriptor = function(x)
			local t = ui.editBox:GetText();
			if(not t) or (t == "") then return nil; end
			--t = string.lower(t);
			return {class = "buff", buff = RDXSS.GetSpellIdByLocalName(t) or t};
		end;

		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end,
	FindSet = function(desc)
		if (not desc) or (not desc.buff) then return nil; end
		return RDXDAL.GetBuffSet(desc.buff);
	end
});

RDXDAL.RegisterSetClass({
	name = "debuff",
	title = VFLI.i18n("Debuff"),
	GetUI = function(parent, desc)
		local ui = VFLUI.LabeledEdit:new(parent, 150);
		ui:SetText(VFLI.i18n("Debuff Name")); ui:Show();
		if desc and desc.buff then
			if type(desc.buff) == "number" then
				local name = GetSpellInfo(desc.buff);
				if not name then name = desc.buff; end
				ui.editBox:SetText(name);
			else
				ui.editBox:SetText(desc.buff);
			end
		end

		local btn = VFLUI.Button:new(ui);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", ui.editBox, "LEFT"); btn:Show();
		btn:SetScript("OnClick", function()
			RDXDAL.AuraCachePopup(RDXDAL._GetDebuffCache(), function(x) 
				if x then ui.editBox:SetText(x.properName); end
			end, btn, "CENTER");
		end);

		ui.GetDescriptor = function(x)
			local t = ui.editBox:GetText();
			if(not t) or (t == "") then return nil; end
			--t = string.lower(t);
			return {class = "debuff", buff = RDXSS.GetSpellIdByLocalName(t) or t};
		end;

		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end,
	FindSet = function(desc)
		if (not desc) or (not desc.buff) then return nil; end
		return RDXDAL.GetDebuffSet(desc.buff);
	end
});

--------------------------------
-- mybuff by Sigg rashgarroth EU
--------------------------------

RDXDAL.RegisterSetClass({
	name = "mybuff",
	title = VFLI.i18n("My Buff"),
	GetUI = function(parent, desc)
		local ui = VFLUI.LabeledEdit:new(parent, 150);
		ui:SetText(VFLI.i18n("Buff Name")); ui:Show();
		if desc and desc.buff then
			if type(desc.buff) == "number" then
				local name = GetSpellInfo(desc.buff);
				if not name then name = desc.buff; end
				ui.editBox:SetText(name);
			else
				ui.editBox:SetText(desc.buff);
			end
		end

		local btn = VFLUI.Button:new(ui);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", ui.editBox, "LEFT"); btn:Show();
		btn:SetScript("OnClick", function()
			RDXDAL.AuraCachePopup(RDXDAL._GetBuffCache(), function(x) 
				if x then ui.editBox:SetText(x.properName); end
			end, btn, "CENTER");
		end);

		ui.GetDescriptor = function(x)
			local t = ui.editBox:GetText();
			if(not t) or (t == "") then return nil; end
			--t = string.lower(t);
			return {class = "mybuff", buff = RDXSS.GetSpellIdByLocalName(t) or t};
		end;

		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end,
	FindSet = function(desc)
		if (not desc) or (not desc.buff) then return nil; end
		return RDXDAL.GetMyBuffSet(desc.buff);
	end
});

--------------------------------------
-- Aurafilter set by sigg
--------------------------------------
-- deprecated
--[[

local auraFilterUpdatePeriod = 0.5;

local function CreateAuraFilterSet(type, filename)
	local self = RDXDAL.Set:new();
	self.name = type .. "<" .. filename .. ">";
	type = string.upper(type);
	
	local auralist = RDXDB.GetObjectInstance(filename);
	local auralist_include, auralist_exclude = {}, {};
	local tmpname = nil;
	if not auralist then auralist = {}; end
	for name,_ in pairs(auralist) do
		tmpname = string.match(name, "!(.*)");
		if tmpname then table.insert(auralist_exclude, tmpname);
		else table.insert(auralist_include, name);
		end
	end
	local flag_include, flag_exclude = false, true;
	local unit = nil;
	local auraFilterRebuild;
	if type == "DEBUFF" then
		function auraFilterRebuild(x)
			for i=1,MAX_UNITS do
				unit = GetUnitByNumber(i);
				if unit:IsCacheValid() then
				--if unit:IsValid() then
					flag_include = false;
					for _,name in pairs(auralist_include) do
				        	if unit:HasDebuff(name) then
							flag_include = true;
							break;
						end
					end
					flag_exclude = true;
					for _,name in pairs(auralist_exclude) do
				        	if unit:HasDebuff(name) then
							flag_exclude = false;
							break;
						end
					end
					if #auralist_include == 0 and #auralist_exclude > 0 then flag_include = true; end
					if flag_include and flag_exclude then
						x:_Set(i, true);
					else
						x:_Set(i, false);
					end
				end
			end
		end
	elseif type == "BUFF" then
		function auraFilterRebuild(x)
			for i=1,MAX_UNITS do
				unit = GetUnitByNumber(i);
				if unit:IsCacheValid() then
				--if unit:IsValid() then
					flag_include = false;
					for _,name in pairs(auralist_include) do
				        	if unit:HasBuff(name) then
							flag_include = true;
							break;
						end
					end
					flag_exclude = true;
					for _,name in pairs(auralist_exclude) do
				        	if unit:HasBuff(name) then
							flag_exclude = false;
							break;
						end
					end
					if #auralist_include == 0 and #auralist_exclude > 0 then flag_include = true; end
					if flag_include and flag_exclude then
						x:_Set(i, true);
					else
						x:_Set(i, false);
					end
				end
			end
		end
	else
		error(VFLI.i18n("invalid aurafilterset type"));
	end
	
	-- Bind/unbind events on act/deact.
	self._OnActivate = function(x)
		VFLT.AdaptiveSchedule2("AuraFilterUpdate" .. filename, auraFilterUpdatePeriod, auraFilterRebuild, x);
	end;
	self._OnDeactivate = function(x)
		VFLT.AdaptiveUnschedule2("AuraFilterUpdate" .. filename);
	end

	return self;
end

local bfsets = {};
local dfsets = {};

function RDXDAL.GetDebuffFilterSet(filename)
	local ret = dfsets[filename];
	if not ret then
		ret = CreateAuraFilterSet("Debuff", filename);
		RDXDAL.RegisterSet(ret);
		dfsets[filename] = ret;
	end
	return ret;
end

function RDXDAL.GetBuffFilterSet(filename)
	local ret = bfsets[filename];
	if not ret then
		ret = CreateAuraFilterSet("Buff", filename);
		RDXDAL.RegisterSet(ret);
		bfsets[filename] = ret;
	end
	return ret;
end

RDXDAL.RegisterSetClass({
	name = "bufffilterfile",
	title = VFLI.i18n("BuffFilter File"),
	GetUI = function(parent, desc)
		local ui = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "AuraFilter$")); end);
		ui:SetLabel(VFLI.i18n("BuffFilter File")); ui:Show();
		if desc and desc.file then ui:SetPath(desc.file); end
		ui.GetDescriptor = function()
			return {class = "bufffilterfile", file = ui:GetPath()};
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		
		return ui;
		
	end,
	FindSet = function(desc)
		return RDXDAL.GetBuffFilterSet(desc.file);
	end,
	ValidateSet = function(desc)
		if not desc.file then return nil; end
		if not RDXDB.CheckObject(desc.file, "AuraFilter") then return nil; end
		return true;
	end,
});

RDXDAL.RegisterSetClass({
	name = "debufffilterfile",
	title = VFLI.i18n("DebuffFilter File"),
	GetUI = function(parent, desc)
		local ui = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "AuraFilter$")); end);
		ui:SetLabel(VFLI.i18n("DebuffFilter File")); ui:Show();
		if desc and desc.file then ui:SetPath(desc.file); end
		ui.GetDescriptor = function()
			return {class = "debufffilterfile", file = ui:GetPath()};
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		
		return ui;
		
	end,
	FindSet = function(desc)
		return RDXDAL.GetDebuffFilterSet(desc.file);
	end,
	ValidateSet = function(desc)
		if not desc.file then return nil; end
		if not RDXDB.CheckObject(desc.file, "AuraFilter") then return nil; end
		return true;
	end,
});

]]
