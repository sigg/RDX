-- DropDownFunctions.lua

------------------------------------------
-- Dropdown helpers
------------------------------------------

local anchorpoints = {
	{ text = "TOPLEFT" },
	{ text = "TOP" },
	{ text = "TOPRIGHT" },
	{ text = "RIGHT" },
	{ text = "BOTTOMRIGHT" },
	{ text = "BOTTOM" },
	{ text = "BOTTOMLEFT" },
	{ text = "LEFT" },
	{ text = "CENTER" }
};
function RDXUI.AnchorPointSelectionFunc() return anchorpoints; end

local anchors = {
	{ text = "TOPLEFT" },
	{ text = "TOPRIGHT" },
	{ text = "BOTTOMLEFT" },
	{ text = "BOTTOMRIGHT" },
	{ text = "CENTER" },
};
function RDXUI.DesktopAnchorFunction() return anchors; end
function RDXUI.IsValidAnchor(anchor)
	if anchor == "TOPLEFT" or anchor == "TOPRIGHT" or anchor == "BOTTOMLEFT" or anchor == "BOTTOMRIGHT" or anchor == "CENTER" then return true; else return nil; end
end

local fontdd = {};
for k,_ in pairs(Fonts) do
	table.insert(fontdd, { text = k } );
end
function RDXUI.FontDropdownFunction() return fontdd; end

local hadd = {
	{ text = "LEFT" },
	{ text = "CENTER" },
	{ text = "RIGHT" }
};
function RDXUI.HAlignDropdownFunction() return hadd; end

local vadd = {
	{ text = "TOP" },
	{ text = "CENTER" },
	{ text = "BOTTOM" }
};
function RDXUI.VAlignDropdownFunction() return vadd; end

local insertmode = {
	{ text = "TOP" },
	{ text = "BOTTOM" }
};
function RDXUI.InserModeDropdownFunction() return insertmode; end

local _ltrb = {
	{ text = "LEFT" },
	{ text = "TOP" },
	{ text = "RIGHT" },
	{ text = "BOTTOM" },
};
function RDXUI.LTRBDropdownFunction() return _ltrb; end

local oradd = {
	{ text = "LEFT"},
	{ text = "RIGHT"},
	{ text = "DOWN"},
	{ text = "UP"},
};
function RDXUI.OrientationDropdownFunction() return oradd; end

local dladd = {
	{ text = "BACKGROUND" },
	{ text = "BORDER" },
	{ text = "ARTWORK" },
	{ text = "OVERLAY" },
	{ text = "HIGHLIGHT" },
};
function RDXUI.DrawLayerDropdownFunction() return dladd; end

local tbl_hvert = {
	{ text = "HORIZONTAL" },
	{ text = "VERTICAL" },
};
function RDXUI.HVDropdownFunction() return tbl_hvert; end

local strata = {
	{ text = "BACKGROUND" },
	{ text = "LOW" },
	{ text = "MEDIUM" },
	{ text = "HIGH"} ,
	--{ text = "DIALOG" } ,
	--{ text = "FULLSCREEN" } ,
	--{ text = "FULLSCREEN_DIALOG" } ,
	--{ text = "TOOLTIP" } ,
};
function RDXUI.DesktopStrataFunction() return strata; end
function RDXUI.IsValidStrata(strata)
	if strata == "BACKGROUND" or strata == "LOW" or strata == "MEDIUM" or strata == "HIGH" then return true; else return nil; end
end

local cotadd = {
	{ text = "CountUP" },
	{ text = "CountDOWN" },
};
function RDXUI.CountTypesDropdownFunction() return cotadd; end

local _aurasadd = {
	{ text = "BUFFS" },
	{ text = "DEBUFFS" },
};
function RDXUI.AurasTypesDropdownFunction() return _aurasadd; end

local _cooldownadd = {
	{ text = "USED" },
	{ text = "AVAIL" },
};
function RDXUI.CooldownsTypesDropdownFunction() return _cooldownadd; end

local loops = {
    { text = "NONE" },
    { text = "REPEAT" },
    { text = "BOUNCE" }
};
function RDXUI.LoopSelectionFunc() return loops; end

local smoothing = {
    { text = "IN" },
    { text = "OUT" },
    { text = "IN_OUT" },
    { text = "None" }
};
function RDXUI.SmoothSelectionFunc() return smoothing; end

local power = {
    { text = "nil" },
    { text = "SPELL_POWER_MANA" },
    { text = "SPELL_POWER_RAGE" },
    { text = "SPELL_POWER_FOCUS" },
    { text = "SPELL_POWER_ENERGY" },
    { text = "SPELL_POWER_HAPPINESS" },
    { text = "SPELL_POWER_RUNES" },
    { text = "SPELL_POWER_RUNIC_POWER" },
    { text = "SPELL_POWER_SOUL_SHARDS" },
    { text = "SPELL_POWER_ECLIPSE" },
    { text = "SPELL_POWER_HOLY_POWER" },
    { text = "SPELL_POWER_SHADOW_ORBS" },
    { text = "SPELL_POWER_LIGHT_FORCE" },
	{ text = "SPELL_POWER_CHI" },
	{ text = "SPELL_POWER_COMBO_POINTS" },
    { text = "ALTERNATE_POWER_INDEX" },
};
function RDXUI.PowerSelectionFunc() return power; end

----------------------------------------------------
-- list RDX window
----------------------------------------------------

local wl = {};

local function BuildWindowList(class)
	VFL.empty(wl);
	local desc = nil;
	for pkg,data in pairs(RDXDB.GetDisk("RDXDiskTheme")) do
		for file,md in pairs(data) do
			if (type(md) == "table") and md.data and md.ty and string.find(md.ty, class) then
				table.insert(wl, {text = RDXDB.MakePath("RDXDiskTheme", pkg, file)});
			end
		end
	end
	table.sort(wl, function(x1,x2) return x1.text<x2.text; end);
end

function RDXUI.fnListWindows() BuildWindowList("Window"); return wl; end
function RDXUI.fnListStatusWindows() BuildWindowList("StatusWindow"); return wl; end

----------------------------------------------------
-- list windowless
----------------------------------------------------

local w2 = {};

local function BuildWindowLessList()
	VFL.empty(w2);
	local desc = nil;
	for k,v in pairs(RDXDK._GetWindowsLess()) do
		table.insert(w2, {text = k});
	end
	table.sort(w2, function(x1,x2) return x1.text<x2.text; end);
end

function RDXUI.fnListWindowsLess() BuildWindowLessList(); return w2; end