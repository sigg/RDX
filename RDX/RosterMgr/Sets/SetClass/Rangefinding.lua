-- Rangefinding.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- Rangefinding tools for RDX.

local MAX_UNITS = RDXDAL.NUM_UNITS;
local GetUnitByNumber = RDXDAL.GetUnitByNumber;

RDXRF = RegisterVFLModule({
	name = "RDXRF";
	title = VFLI.i18n("RDX Rangefinding");
	description = "Rangefinding tools for RDX";
	parent = RDX;
});

local perf_rf_Enabled = true;
local frsTickLength = .2;
local unit,uid = nil, nil;

-------------------------------------------------------------------
-- The "fast" rangefinding sets.
--
-- These sets use UnitIsVisible() and CheckInteractDistance() to
-- measure distances of 70, 30, 10, and 5 yards, respectively.
-------------------------------------------------------------------
local frs_activity = 0;
local frs_70, frs_30, frs_10;

local function UpdateFRS()
	RDXDAL.BeginEventBatch();
	-- For each valid unit, check its range using CID.
	for i=1,MAX_UNITS do
		unit = GetUnitByNumber(i); uid = unit.uid;
		if (not unit:IsCacheValid()) or (not UnitIsVisible(uid)) then
			frs_70:_Set(i, false); frs_30:_Set(i, false); frs_10:_Set(i, false);
		elseif CheckInteractDistance(uid, 3) then
			frs_70:_Set(i, true); frs_30:_Set(i, true); frs_10:_Set(i, true);
		elseif CheckInteractDistance(uid, 4) then
			frs_70:_Set(i, true); frs_30:_Set(i, true); frs_10:_Set(i, false);
		else
			frs_70:_Set(i, true); frs_30:_Set(i, false); frs_10:_Set(i, false);
		end
	end

	RDXDAL.EndEventBatch();
end

-- Activate/deactivate FRS as needed.
local function CheckFRSActivity()
	if not perf_rf_Enabled then return; end
	if (frs_activity == 0) then -- we need to disable
		RDXRF:Debug(2, "Disabling FRS");
		VFLT.AdaptiveUnschedule("frs");
	elseif (frs_activity > 0) then -- we need to enable
		RDXRF:Debug(2, "Enabling FRS");
		VFLT.AdaptiveUnschedule("frs");
		VFLT.AdaptiveSchedule("frs", frsTickLength, UpdateFRS);
	end
end

-- Generate the actual range sets
local function CreateFRS(yd)
	local x = RDXDAL.Set:new();
	function x:_OnActivate()
		frs_activity = frs_activity + 1; CheckFRSActivity();
	end
	function x:_OnDeactivate()
		frs_activity = frs_activity - 1; CheckFRSActivity();
	end
	x.name = "Range<" .. yd .. " yd>";
	RDXDAL.RegisterSet(x);
	return x;
end
frs_70 = CreateFRS(70); 
frs_30 = CreateFRS(30); 
frs_10 = CreateFRS(10); 

-- The RDX setclass for FRS.
RDXDAL.RegisterSetClass({
	name = "frs",
	title = VFLI.i18n("Within Range"),
	GetUI = function(parent, desc)
		local ui = VFLUI.RadioGroup:new(parent);
		ui:SetLayout(3,3);
		ui.buttons[1]:SetText(VFLI.i18n("10yd")); ui.buttons[2]:SetText(VFLI.i18n("30yd"));  ui.buttons[3]:SetText(VFLI.i18n("Visible"));
		if desc and desc.n then
			if desc.n == 1 then -- compat: old 5yd class
				ui:SetValue(1);
			else
				ui:SetValue(desc.n - 1); 
			end
		else
			ui:SetValue(1);
		end

		function ui:GetDescriptor() return {class="frs", n=(ui:GetValue() + 1)}; end

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil end, ui.Destroy);
		return ui;
	end,
	FindSet = function(desc)
		if not desc then return nil; end
		local qq = desc.n;
		if qq == 1 then
			return frs_10;
		elseif qq == 2 then
			return frs_10;
		elseif qq == 3 then
			return frs_30;
		elseif qq == 4 then
			return frs_70;
		else
			return nil;
		end
	end
});

RDXRF.yd70 = frs_70; RDXRF.yd30 = frs_30; RDXRF.yd10 = frs_10;

----------------------------------------------------------------------------------------
-- WOW 2.4 Unit in range UnitInRange("unit") by Sigg
----------------------------------------------------------------------------------------
local uirs_activity = nil;
local uirsTickLength = .2;

local uirs = RDXDAL.Set:new();
uirs.name = "Unit in Range<>";

local function UpdateUIRS()
	for i=1,MAX_UNITS do
		unit = GetUnitByNumber(i); uid = unit.uid;
		if unit:IsCacheValid() and UnitInRange(uid) then
			uirs:_Set(i, true);
		else
			uirs:_Set(i, false);
		end
	end
end

function uirs:_OnActivate()
	if not perf_rf_Enabled then return; end
	RDXRF:Debug(2, "Enabling UIRS");
	VFLT.AdaptiveUnschedule("uirs");
	VFLT.AdaptiveSchedule("uirs", uirsTickLength, UpdateUIRS);
end
function uirs:_OnDeactivate()
	RDXRF:Debug(2, "Disabling UIRS");
	VFLT.AdaptiveUnschedule("uirs");
end

RDXDAL.RegisterSet(uirs);

RDXDAL.RegisterSetClass({
	name = "unitinrange";
	title = VFLI.i18n("Unit in Range (2.4)");
	GetUI = RDXDAL.TrivialSetFinderUI("unitinrange");
	FindSet = function() return uirs; end;
});

----------------------------------------------------------------------------------------
-- WOW 2.0 EXACT SPELL/ITEM RANGE CHECKING
-- WOW 2.4 Unit in range UnitInRange("unit") by Sigg
----------------------------------------------------------------------------------------
local srs = {};
local irs = {};

local function UpdateSRS()
	for i=1,MAX_UNITS do
		unit = GetUnitByNumber(i); uid = unit.uid;
		for k,v in pairs(srs) do
			if unit:IsCacheValid() and (IsSpellInRange(k, uid) == 1) then
				v:_Set(i, true);
			else
				v:_Set(i, false);
			end
		end
	end
end

local function UpdateIRS()
	for i=1,MAX_UNITS do
		unit = GetUnitByNumber(i); uid = unit.uid;
		for k,v in pairs(irs) do
			if unit:IsCacheValid() and (IsItemInRange(k, uid) == 1) then
				v:_Set(i, true);
			else
				v:_Set(i, false);
			end
		end
	end
end

local function UpdateRS()
	RDXDAL.BeginEventBatch();
	UpdateSRS();
	UpdateIRS();
	RDXDAL.EndEventBatch();
end

VFLT.AdaptiveSchedule("srs", frsTickLength, UpdateRS);

--- Get an exact range set for the given spell.
function RDXRF.GetSpellRangeSet(spell)
	-- If we already have a range set for this spell, return it.
	if type(spell) == "number" then
		local name, rank = GetSpellInfo(spell);
		if not rank then rank = ""; end
		spell =  name .. "(" .. rank ..")";
	end
	if srs[spell] then return srs[spell]; end
	-- Create a range set for this spell.
	local x = RDXDAL.Set:new();
	x.name = "SpellRange<" .. spell .. ">";
	srs[spell] = x;
	RDXDAL.RegisterSet(x);
	return x;
end

--- Get an exact range set for the given item.
function RDXRF.GetItemRangeSet(item)
	if irs[item] then return irs[item]; end
	local x = RDXDAL.Set:new();
	x.name = "ItemRange<" .. item .. ">";
	irs[item] = x;
	RDXDAL.RegisterSet(x);
	return x;
end

RDXDAL.RegisterSetClass({
	name = "spellrange";
	title = VFLI.i18n("Exact Spell Range");
	GetUI = function(parent, desc)
		-- Get current spell
		local csp = "(none)"; if desc and desc.spell then csp = desc.spell; end
		-- Build the UI
		local ui = VFLUI.CompoundFrame:new(parent);

		local spellEdit = RDXSS.SpellSelector:new(ui); spellEdit:Show();
		spellEdit:SetSpell(csp);
		ui:InsertFrame(spellEdit);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() return { class="spellrange", spell = spellEdit:GetSpell() }; end

		return ui;
	end;
	FindSet = function(desc)
		if not desc then return nil; end
		return RDXRF.GetSpellRangeSet(desc.spell);
	end;
});

RDXDAL.RegisterSetClass({
	name = "itemrange";
	title = VFLI.i18n("Exact Item Range");
	GetUI = function(parent, desc)
		-- Get current spell
		local csp = "(none)"; if desc and desc.item then csp = desc.item; end
		-- Build the UI
		local ui = VFLUI.CompoundFrame:new(parent);

		local edit = VFLUI.LabeledEdit:new(ui, 200);
		edit:SetText(VFLI.i18n("Item name (Exact)")); edit:Show();
		edit.editBox:SetText(csp);
		ui:InsertFrame(edit);
	
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		ui.GetDescriptor = function() return { class="itemrange", item = edit.editBox:GetText() }; end

		return ui;
	end;
	FindSet = function(desc)
		if type(desc) ~= "table" then return nil; end
		return RDXRF.GetItemRangeSet(desc.item);
	end;
});


