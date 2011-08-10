-- CooldownSets.lua
-- OpenRDX
-- Sigg / Rashgarroth EU
--

local MAX_UNITS = RDXDAL.NUM_UNITS;
local GetUnitByNumber = RDXDAL.GetUnitByNumber

-- Create an aura set for the given aura.
local function CreateCooldownSet(type, spellid)
	local self = RDXDAL.Set:new();
	self.name = type .. "<" .. spellid .. ">";
	--type = string.upper(type);

	-- The full rebuild function.
	local FullRebuild;
	if type == "AVAIL" then
		function FullRebuild(x)
			local unit = nil;
			for i=1,MAX_UNITS do
				unit = GetUnitByNumber(i);
				if unit:IsCacheValid() and unit:HasAvailCooldownBySpellid(spellid) then x:_Set(i, true); else x:_Set(i, false); end
			end
		end
	elseif type == "USED" then
		function FullRebuild(x)
			local unit = nil;
			for i=1,MAX_UNITS do
				unit = GetUnitByNumber(i);
				if unit:IsCacheValid() and unit:HasUsedCooldownBySpellid(spellid) then x:_Set(i, true); else x:_Set(i, false); end
			end
		end
	else
		error(VFLI.i18n("invalid cooldownset type"));
	end

	-- The function invoked when an aura event triggers.
	local function OnCooldownEvent(x, unit, _, apps)
		if(apps == 0) then x:_Set(unit.nid, false); else x:_Set(unit.nid, true); end
	end

	-- Bind/unbind events on act/deact.
	self._OnActivate = function(x)
		RDXEvents:Bind("UNIT_CD_" .. type .. "_" .. spellid, x, OnCooldownEvent, x);
		RDXEvents:Bind("DISRUPT_SETS", x, FullRebuild, x);
		FullRebuild(x);
	end;
	self._OnDeactivate = function(x)
		RDXEvents:Unbind(x);
	end

	return self;
end

-- Aura set databases
local availsets = {};
local usedsets = {};

--- Get the debuff set for the given debuff.
function RDXDAL.GetAvailSet(spellid)
	local ret = availsets[spellid];
	if not ret then
		ret = CreateCooldownSet("AVAIL", spellid);
		RDXDAL.RegisterSet(ret);
		availsets[spellid] = ret;
	end
	return ret;
end

--- Get the buff set for the given buff.
function RDXDAL.GetUsedSet(spellid)
	local ret = usedsets[spellid];
	if not ret then
		ret = CreateCooldownSet("USED", spellid);
		RDXDAL.RegisterSet(ret);
		usedsets[spellid] = ret;
	end
	return ret;
end

-----------------------------------------------------------------
-- COOLDOWN METASETS FILTERS
-----------------------------------------------------------------
function RDXDAL.CooldownCachePopup(db, callback, frame, point, dx, dy)
	local qq = {};
	for _,v in pairs(db) do
		local dbEntry = v;
		table.insert(qq, {
			text = v.text;
			texture = v.icon or "Interface\\InventoryItems\\WoWUnknownItem01.blp";
			OnClick = function()
				VFL.poptree:Release();
				callback(dbEntry);
			end
		});
	end
	table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
	VFL.poptree:Begin(250, 12, frame, point, dx, dy);
	VFL.poptree:Expand(nil, qq, 20);
end

RDXDAL.RegisterSetClass({
	name = "cd_avail",
	title = VFLI.i18n("Cooldown Available"),
	GetUI = function(parent, desc)
		local ui = VFLUI.LabeledEdit:new(parent, 250);
		ui:SetText(VFLI.i18n("Cooldown Name")); ui:Show();
		if desc and desc.cd then
			local cdinfo = RDXCD.GetCooldownInfoBySpellid(desc.cd);
			if cdinfo then
				ui.editBox:SetText(cdinfo.text);
			end
		end

		local btn = VFLUI.Button:new(ui);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", ui.editBox, "LEFT"); btn:Show();
		btn:SetScript("OnClick", function()
			RDXDAL.CooldownCachePopup(RDXCD.GetCDCs(), function(x) 
				if x then ui.editBox:SetText(x.text); end
			end, btn, "CENTER");
		end);

		ui.GetDescriptor = function(x)
			local t = ui.editBox:GetText();
			if (not t) or (t == "") then return nil; end
			return {class = "cd_avail", cd = RDXCD.GetCooldownInfoByText(t)};
		end;

		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end,
	FindSet = function(desc)
		if (not desc) or (not desc.cd) then return nil; end
		return RDXDAL.GetAvailSet(desc.cd);
	end
});

RDXDAL.RegisterSetClass({
	name = "cd_used",
	title = VFLI.i18n("Cooldown Used"),
	GetUI = function(parent, desc)
		local ui = VFLUI.LabeledEdit:new(parent, 250);
		ui:SetText(VFLI.i18n("Cooldown Name")); ui:Show();
		if desc and desc.cd then
			local cdinfo = RDXCD.GetCooldownInfoBySpellid(desc.cd);
			if cdinfo then
				ui.editBox:SetText(cdinfo.text);
			end
		end

		local btn = VFLUI.Button:new(ui);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", ui.editBox, "LEFT"); btn:Show();
		btn:SetScript("OnClick", function()
			RDXDAL.CooldownCachePopup(RDXCD.GetCDCs(), function(x) 
				if x then ui.editBox:SetText(x.text); end
			end, btn, "CENTER");
		end);

		ui.GetDescriptor = function(x)
			local t = ui.editBox:GetText();
			if(not t) or (t == "") then return nil; end
			return {class = "cd_used", cd = RDXCD.GetCooldownInfoByText(t)};
		end;

		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end,
	FindSet = function(desc)
		if (not desc) or (not desc.cd) then return nil; end
		return RDXDAL.GetUsedSet(desc.cd);
	end
});

