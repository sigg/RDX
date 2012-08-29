-- Spells.lua
-- (C)2006 Bill Johnson
--
-- Code relating to the manipulation of in-game spells and abilities.
--
-- spellid is coming from the combat log
-- bookid is coming from the book
--
-- Each spell is represented by its WoW numerical Book ID. Spells are grouped into SpellClasses;
-- all spells in a SpellClass have the same effect, but to different magnitudes.
--
-- Examples of SpellClasses: Shadow Bolt(Rank 1), Shadow Bolt(Rank 2), ...
--                           Detect Lesser Invisibility, Detect Invisibility, Detect Greater Invisibility
-- Subtleties: Power Word: Fortitude and Prayer of Fortitude are DIFFERENT spell classes because
--   they don't have the exact same effect (one buffs a single person, one buffs a group.)
--
-- Spells are also grouped into SpellCategories. A SpellCategory can be something like "DAMAGE", 
-- "HEALING", "PERIODIC", "INSTANT", etc. A spell can be in multiple SpellCategories.
--
-- Spells are also grouped into RangeClasses. Spells in the same RangeClass have the same range.
--
-- Spells can be manually grouped into generic SpellGroups which can have any content or meaning 
-- that the programmer desires.
-- 
-- Interesting spell events
-- LEARNED_SPELL_IN_TAB(tabnum)
-- SPELL_UPDATE_USABLE
--
-- OpenRDX, move into RDX

RDXSS = RegisterVFLModule({
	name = "RDXSS";
	title = "RDX Spell System";
	description = "RDX Spell System";
	version = {1,0,0};
	parent = RDX;
});
VFLP.RegisterCategory("RDXSS: Spell System");

-- Burning Crusade: abstract away crazy renamed function...
if IsPassiveSpell then
	RDXSS.IsPassiveSpell = IsPassiveSpell;
else
	RDXSS.IsPassiveSpell = IsSpellPassive;
end

------------------------------------------------
-- Basic spell API
------------------------------------------------

-- Given a spell's book numerical ID, return its full name.
function RDXSS.GetSpellFullNameByBookId(id)
	if not id then return nil; end
	local name,q = GetSpellBookItemName(id, BOOKTYPE_SPELL);
	if not name then return nil; end
	return name .. '(' .. q .. ')', name, q;
end

-- Given a spell's book numerical ID, attempt to figure out its numerical rank
function RDXSS.GetSpellRankByBookId(id)
	local name,q = GetSpellBookItemName(id, BOOKTYPE_SPELL);
	if not name then return nil; end
	if q then
		local _,_,num = string.find(q, "(%d+)");
		if num then return tonumber(num), name, q; end
	end
	return 0, name, q;
end

-- Given a spell's full name and Booktype (BOOKTYPE_SPELL or BOOKTYPE_PET), return spell's book numerical ID.
function RDXSS.GetSpellBookId(sname, bkt)
	if not sname then return nil; end
	if not bkt then return nil; end
	for i = 1, MAX_SKILLLINE_TABS do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		if not name then break; end
		for s = offset + 1, offset + numSpells do
			if (sname == GetSpellBookItemName(s,bkt)) then
				return s;
			end
		end
	end
	return 0;
end

------------------------------------------------
-- Local spell DB
------------------------------------------------

-- Given a spellid by name
function RDXSS.GetSpellIdByLocalName(name)
	if not name then return nil; end
	return RDXLocalSpellDB[name];
end

-- Given a spellinfo by spellid
-- name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId or spellName or spellLink)
function RDXSS.GetSpellInfoBySpellId(id)
	if not id then return nil; end
	return GetSpellInfo(id);
end

------------------------------------------------
-- Core spell databases
------------------------------------------------
-- Spells by full name
local spFN = {};
local FullspFN = {};
local IFullspFN = {};

--- Get a spell by FULL NAME: Spell Name(Rank X)
-- Partial names will not work.
function RDXSS.GetSpellByFullName(n, fulldb)
	if not n then return nil; end
	if fulldb then
		return FullspFN[n];
	else
		return spFN[n];
	end
end

function RDXSS.GetSpellIdBook(n)
	if not n then return nil; end
	return IFullspFN[n];
end

--- Get a table (name->id) of all spells recognized by VFL.
function RDXSS.GetAllSpells(fulldb) 
	if fulldb then
		return FullspFN;
	else
		return spFN;
	end
end

--- Exclusion tables. Spells excluded by this table will not
-- appear in the VFL spell system.
local excludeNames = {
	[VFLI.i18n("Attack")] = true,
	[VFLI.i18n("Disenchant")] = true,
	[VFLI.i18n("Gnomish Engineer")] = true,
	[VFLI.i18n("Goblin Engineer")] = true,
};
local excludeQualifiers = {
	[VFLI.i18n("Passive")] = true,
	[VFLI.i18n("Racial Passive")] = true,
	[VFLI.i18n("Apprentice")] = true,
	[VFLI.i18n("Journeyman")] = true,
	[VFLI.i18n("Master")] = true,
	[VFLI.i18n("Expert")] = true,
	[VFLI.i18n("Artisan")] = true,
};

-- Filter this spell for "worthwhile-ness"
local function SpellFilter(id,name,q)
	if RDXSS.IsPassiveSpell(id, BOOKTYPE_SPELL) then return nil; end
	if excludeNames[name] then return nil; end
	if excludeQualifiers[q] then return nil; end
	return true;
end

-- Empty the core spell database
local function ResetCoreSpellDB()
	VFL.empty(spFN);
	VFL.empty(FullspFN);
end

-- Rebuild the core spell database
local function BuildCoreSpellDB()
	local i=1;
	while true do
		local name,q = GetSpellBookItemName(i, BOOKTYPE_SPELL);
		if not name then break; end
		local level = GetSpellAvailableLevel(i, BOOKTYPE_SPELL);
		if (level and level <= UnitLevel("player")) then 
			if SpellFilter(i,name,q) then
				if not q or q == "" then
					spFN[name] = i;
				else
					spFN[name.."("..q..")"] = i;
				end
			end
			if not q or q == "" then
				FullspFN[name] = i;
			else
				FullspFN[name.."("..q..")"] = i;
			end
		end
		i=i+1;
	end
	IFullspFN = VFL.invert(FullspFN);
end

--RDXSpellDB
-- RDXSpellDB is stored in RDX_localspelldb.lua
--[[
spellname = {
 spellid
 spellrank
 bookid
 casttime
 duration
 maxAmount 
 averageAmount
}
heal utilise spellname + rank pour récupérer casttime et averageamount
cd utilise spellid pour récupérer la durée réelle
action bouton utilise bookid

if not RDXSession[RDX.pspace] then RDXSession[RDX.pspace] = {}; end
	RDXU = RDXSession[RDX.pspace];
]]

-----------------------------------------------
-- Companion spell 3.0.3
-----------------------------------------------
local spCritter = {};
local spMount = {};

function RDXSS.GetSpellCritterByName(n)
	if not n then return nil; end
	return spCritter[n];
end

local function ResetCoreSpellCritterDB()
	VFL.empty(spCritter);
end

local function BuildCoreSpellCritterDB()
	local i=1;
	while true do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("CRITTER", i);
		if not creatureName then break; end
		spCritter[creatureName] = {creatureID = creatureID, creatureName = creatureName, creatureSpellID = creatureSpellID, icon = icon, issummoned = issummoned, i = i};
		i=i+1;
	end
end

function RDXSS.GetSpellMountByName(n)
	if not n then return nil; end
	return spMount[n];
end

local function ResetCoreSpellMountDB()
	VFL.empty(spMount);
end

local function BuildCoreSpellMountDB()
	local i=1;
	while true do
		local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo("MOUNT", i);
		if not creatureName then break; end
		spMount[creatureName] = {creatureID = creatureID, creatureName = creatureName, creatureSpellID = creatureSpellID, icon = icon, issummoned = issummoned, i = i};
		i=i+1;
	end
end

------------------------------------------------
-- SpellGroup
-- A SpellGroup is a group of spells. Big shocker there. The spells in the
-- group can be queried by ID or name.
------------------------------------------------
RDXSS.SpellGroup = {};
function RDXSS.SpellGroup:new()
	local s = {};
	
	local spells = {};
	local spellsByID = {};
	local spellsByName = {};
	
	--- Get all spells in this group, as a sorted array.
	function s:Spells() return spells; end

	--- Empty this spell group
	function s:Empty()
		VFL.empty(spells); VFL.empty(spellsByID); VFL.empty(spellsByName);
	end

	--- Add a spell to this group.
	function s:AddSpell(id)
		if not id then error("expected id, got nil"); end
		if spellsByID[id] then return nil; end
		local sn = RDXSS.GetSpellFullNameByBookId(id); if not sn then return nil; end
		table.insert(spells, id);
		spellsByID[id] = sn;
		spellsByName[sn] = id;
		return true;
	end

	--- Add a spell to this group by full name.
	function s:AddSpellByFullName(fn)
		self:AddSpell(RDXSS.GetSpellByFullName(fn));
	end

	--- Determine if the spell with the given ID is in this group
	function s:HasSpellByID(id)
		if not id then return nil; end
		return spellsByID[id];
	end

	--- Determine if the spell with the given full name is in this group.
	function s:HasSpellByFullName(fn)
		if not fn then return nil; end
		return spellsByName[fn];
	end

	--- Get the highest-sorted spell in this group.
	function s:GetBestSpellID()
		local n = table.getn(spells);
		if(n == 0) then return nil; end
		return spells[n];
	end

	--- Get the highest-sorted spell in this group by name
	function s:GetBestSpellName()
		local n = table.getn(spells);
		if(n == 0) then return nil; end
		return spellsByID[spells[n]];
	end

	-- Debug string dump
	function s:_DebugDump()
		local str = "";
		for _,sp in ipairs(spells) do
			str = str .. RDXSS.GetSpellFullNameByBookId(sp) .. ",";
		end
		return str;
	end

	return s;
end

--------------------------------------------------------------------
-- SpellCategory
--
-- A SpellCategory is a loose string-identified grouping of spells.
-- A spell can belong to multiple categories, and there are API
-- calls to identify which categories a spell belongs to.
--------------------------------------------------------------------

local catname2category = {};
local spell2cats = {};

local function ResetSpellCategoryDatabase()
	VFL:Debug(1, "ResetSpellCategoryDatabase()");
	VFL.empty(catname2category);
	VFL.empty(spell2cats);
end

--- Get the category database
function RDXSS.GetAllCategories()
	return catname2category;
end

--- Get a category by name.
function RDXSS.GetCategoryByName(cn)
	if not cn then return nil; end
	return catname2category[cn];
end

--- Get a category by name, creating it if it does not exist.
function RDXSS.GetOrCreateCategoryByName(cn)
	if not cn then return nil; end
	local cat = catname2category[cn];
	if not cat then
		cat = RDXSS.SpellGroup:new();
		VFL:Debug(3,"Creating SpellCategory<"..cn.."> as " .. tostring(cat));
		catname2category[cn] = cat;
	end
	return cat;
end

--- Categorize a spell, assuming both the category and SID are valid.
local function CategorizeSpell(cat, cn, id)
	if cat:HasSpellByID(id) then return; end
	cat:AddSpell(id);
	local s = spell2cats[id];
	if not s then s = {}; spell2cats[id] = s; end
	s[cn] = true;
end

--- Categorize a single spell.
function RDXSS.CategorizeSpell(spellfn, cn)
	if (not spellfn) or (not cn) then return; end
	local id = RDXSS.GetSpellByFullName(spellfn); if not id then return; end
	local cat = RDXSS.GetOrCreateCategoryByName(cn);
	CategorizeSpell(cat, cn, id);
end

--- Categorize all spells in a SpellClass.
function RDXSS.CategorizeClass(class, cn)
	if(not class) or (not cn) then error("usage: RDXSS.CategorizeClass(id, categoryName)"); end
	class = GetSpellInfo(class);
	--local cls = RDXSS.GetClassByName(class); if not cls then return; end
	local cat = RDXSS.GetOrCreateCategoryByName(cn);
	--for _,id in pairs(cls:Spells()) do CategorizeSpell(cat, cn, id); end
	CategorizeSpell(cat, cn, class);
end

--- Get a table (cat->true) mapping of all categories to which the given spell belongs.
function RDXSS.GetSpellCategories(id)
	if not id then return VFL.emptyTable; end
	return spell2cats[id] or VFL.emptyTable;
end

------------------------------------------------
-- UPDATERS/EVENTS
------------------------------------------------

-- Master updater for the spell engine.
local function UpdateSpells()
	ResetCoreSpellDB();
	ResetSpellCategoryDatabase();
	RDXEvents:Dispatch("SPELLS_RESET");
	BuildCoreSpellDB();
	RDXEvents:Dispatch("SPELLS_BUILD_CATEGORIES");
	--RDXEvents:Dispatch("SPELLS_BUILD_CLASSES");
	RDXEvents:Dispatch("SPELLS_UPDATED");
end
VFLP.RegisterFunc("RDXSS: Spell System", "UpdateSpells", UpdateSpells, true);

--WoWEvents:Bind("LEARNED_SPELL_IN_TAB", nil, UpdateSpells);
--RDXEvents:Bind("INIT_SPELL", nil, UpdateSpells);

-- Master updater for the spell companion.
local function UpdateSpellsCompanion()
	ResetCoreSpellCritterDB();
	ResetCoreSpellMountDB();
	RDXEvents:Dispatch("SPELLS_COMPANION_RESET");
	BuildCoreSpellCritterDB();
	BuildCoreSpellMountDB();
	RDXEvents:Dispatch("SPELLS_COMPANION_UPDATED");
end

--WoWEvents:Bind("COMPANION_LEARNED", nil, UpdateSpellsCompanion);
--WoWEvents:Bind("COMPANION_UPDATE", nil, UpdateSpellsCompanion);
--RDXEvents:Bind("INIT_SPELL", nil, UpdateSpellsCompanion);

-----------------------------------------------
-- DEBUGGERY
-----------------------------------------------
function RDXSS.DebugSpells()
	for k,v in pairs(RDXSS.GetAllSpells()) do
		VFL.print(v .. ": " .. k);
	end
end

function RDXSS.DebugSpellClasses()
	for k,v in pairs(RDXSS.GetSpellClasses()) do
		VFL.print(k .. ": " .. v:_DebugDump());
	end
end

function RDXSS.DebugSpellCategories()
	for k,v in pairs(RDXSS.GetAllCategories()) do
		VFL.print(k .. ": " .. v:_DebugDump());
	end
end

function RDXSS.DebugMounts()
	for k,v in pairs(spMount) do
		VFL.print(k);
		VFL.print(v.creatureSpellID);
	end
end


-- A custom control that allows the entry and selection of spells from a list.
RDXSS.SpellSelector = {};
function RDXSS.SpellSelector:new(parent)
	local spellEdit = VFLUI.LabeledEdit:new(parent, 200);
	spellEdit:SetText(VFLI.i18n("Spell Name")); 

	local btn = VFLUI.Button:new(spellEdit);
	btn:SetHeight(25); 
	btn:SetWidth(25); 
	btn:SetText("...");
	btn:SetPoint("RIGHT", spellEdit.editBox, "LEFT");
	btn:Show();
	btn:SetScript("OnClick", function()
		local qq = { };
		for spell,_ in pairs(RDXSS.GetAllSpells()) do
			local retVal = spell;
			table.insert(qq, { 
				text = retVal, 
				OnClick = function() 
					VFL.poptree:Release();
					spellEdit.editBox:SetText(retVal);
				end
			});
		end
		table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
		VFL.poptree:Begin(200, 12, btn, "CENTER");
		VFL.poptree:Expand(nil, qq, 20);
	end);

	function spellEdit:GetSpell()
		local spelltmp = spellEdit.editBox:GetText();
		return RDXSS.GetSpellIdByLocalName(spelltmp) or spelltmp;
	end
	function spellEdit:SetSpell(sp)
		if type(sp) == "number" then
			local name, rank = GetSpellInfo(sp);
			if not rank or rank == "" then
				sp =  name;
			else
				sp =  name .. "(" .. rank ..")";
			end
		end
		spellEdit.editBox:SetText(sp);
	end

	spellEdit.Destroy = VFL.hook(function(s)
		s.GetSpell = nil; s.SetSpell = nil;
		btn:Destroy(); btn = nil;
	end, spellEdit.Destroy);

	return spellEdit;
end


----------------------------------
-- SPELL Database local
----------------------------------

local subVal, spellId, spellName, spellSchool, rank, norank;

local function __RDXParser(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
	subVal = strsub(event, 1, 5);
	spellId, spellName, spellSchool = nil, nil, nil;
	norank = nil;
	
	if (subVal == "SPELL") then 
		if (event == "SPELL_DAMAGE") then
			spellId, spellName, spellSchool = select(1, ...);
		elseif (event == "SPELL_HEAL") then
			spellId, spellName, spellSchool = select(1, ...);
		elseif (event == "SPELL_INTERRUPT") then
			spellId, spellName, spellSchool = select(1, ...);
		elseif (strsub(event, 1, 14) == "SPELL_PERIODIC") then
			if (event == "SPELL_PERIODIC_DAMAGE") then
				spellId, spellName, spellSchool = select(1, ...);
			elseif (event == "SPELL_PERIODIC_HEAL") then
				spellId, spellName, spellSchool = select(1, ...);
			elseif (event == "SPELL_PERIODIC_MISSED") then 
				spellId, spellName, spellSchool = select(1, ...);
			elseif (event == "SPELL_PERIODIC_DRAIN") then
				spellId, spellName, spellSchool = select(1, ...);
			elseif (event == "SPELL_PERIODIC_LEECH") then
				spellId, spellName, spellSchool = select(1, ...);
			end
		elseif (strsub(event, 1, 10) == "SPELL_AURA") then
			norank = true;
			if (event == "SPELL_AURA_APPLIED") then --or event == "SPELL_AURA_REFRESH") then
				spellId, spellName, spellSchool = select(1, ...);
			elseif (event == "SPELL_AURA_REMOVED") then
				spellId, spellName, spellSchool = select(1, ...);
			elseif (event == "SPELL_AURA_APPLIED_DOSE") then
				spellId, spellName, spellSchool = select(1, ...);
			elseif (event == "SPELL_AURA_REMOVED_DOSE") then
				spellId, spellName, spellSchool = select(1, ...);
			end
		elseif  (event == "SPELL_CAST_START") then
			spellId, spellName, spellSchool = select(1, ...);
		elseif (event == "SPELL_MISSED") then 
			spellId, spellName, spellSchool = select(1, ...);
		elseif (event == "SPELL_DRAIN") then
			spellId, spellName, spellSchool = select(1, ...);
		elseif (event == "SPELL_LEECH") then
			spellId, spellName, spellSchool = select(1, ...);
		elseif (event == "SPELL_CAST_SUCCESS") then
			spellId, spellName = select(1, ...);
		end
	elseif (subVal == "RANGE") then
		if (event == "RANGE_DAMAGE") then
			spellId, spellName, spellSchool = select(1, ...);
		elseif (event == "RANGE_MISSED") then 
			spellId, spellName, spellSchool = select(1, ...);
		end
	elseif (event == "DAMAGE_SHIELD") then
		spellId, spellName, spellSchool = select(1, ...);
	elseif (event == "DAMAGE_SHIELD_MISSED") then 
		spellId, spellName, spellSchool = select(1, ...);
	elseif (event == "DAMAGE_SPLIT") then
		spellId, spellName, spellSchool = select(1, ...);
	end
	
	if norank and spellName and spellId then
		RDXLocalSpellDB[spellName] = spellId;
	end
	
	if spellName and spellId then
		_, rank = GetSpellInfo(spellId);
		if rank then spellName = spellName .. "(" .. rank ..")"; end
		RDXLocalSpellDB[spellName] = spellId;
	end
end

VFLP.RegisterFunc("RDXSS: Spell System", "Parser", __RDXParser, true);

local function EnableStoreLocalSpellDB()
	--if not RDXG.localSpellDBVersion or RDXG.localSpellDBVersion ~= RDX.GetVersion() or not RDXG.localSpellDBClient or RDXG.localSpellDBClient ~= GetLocale() then
	--	RDX.printI("RESET Local spell DB");
	--	VFL.empty(RDXLocalSpellDB);
	--	RDXLocalSpellDB = {};
	--	RDXG.localSpellDBVersion = RDX.GetVersion();
	--	RDXG.localSpellDBClient = GetLocale();
	--end
	RDXG.localSpellDB = true;
	WoWEvents:Unbind("LocalSpellDB");
	WoWEvents:Bind("COMBAT_LOG_EVENT_UNFILTERED", nil, __RDXParser, "LocalSpellDB");
end

local function DisableStoreLocalSpellSB()
	RDXG.localSpellDB = nil;
	WoWEvents:Unbind("LocalSpellDB");
end

function RDXSS.ToggleStoreLocalSpellSB()
	if RDXG.localSpellDB then
		DisableStoreLocalSpellSB();
		RDX.printI(VFLI.i18n("Disable Store Local Spell DB"));
	else
		EnableStoreLocalSpellDB();
		RDX.printI(VFLI.i18n("Enable Store Local Spell DB"));
	end
end

function RDXSS.IsStoreLocalSpellDB()
	return RDXG.localSpellDB;
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	if not RDXLocalSpellDB then RDXLocalSpellDB = {}; end
	EnableStoreLocalSpellDB();
end);