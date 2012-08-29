--
-- METADATA
-- 

RDXMD = RegisterVFLModule({
	name = "RDXMD";
	title = "RDX METADATA";
	description = "RDX METADATA";
	version = {1,0,0};
	parent = RDX;
});

local idToClass = { 
	"PRIEST", "DRUID", "PALADIN", 
	"SHAMAN", "WARRIOR", "WARLOCK", 
	"MAGE", "ROGUE", "HUNTER", "DEATHKNIGHT", "MONK"
};
local classToID = VFL.invert(idToClass);

local idToLocalName = { 
	VFLI.i18n("Priest"), VFLI.i18n("Druid"), VFLI.i18n("Paladin"), 
	VFLI.i18n("Shaman"), VFLI.i18n("Warrior"), VFLI.i18n("Warlock"), 
	VFLI.i18n("Mage"), VFLI.i18n("Rogue"), VFLI.i18n("Hunter"), 
	VFLI.i18n("DeathKnight"), VFLI.i18n("Monk"),
};
local localNameToID = VFL.invert(idToLocalName);

local idToClassColor = {};
for i=1,11 do
	idToClassColor[i] = RAID_CLASS_COLORS[idToClass[i]];
end
local nameToClassColor = RAID_CLASS_COLORS;

local _grey = { r=.5, g=.5, b=.5};

local classIcons = {
	["WARRIOR"] = {0, 0.25, 0, 0.25},
	["MAGE"] = {0.25, 0.5, 0, 0.25},
	["ROGUE"] = {0.5, 0.75, 0, 0.25},
	["DRUID"] = {0.74, 1, 0, 0.25},
	["HUNTER"] = {0, 0.25, 0.25, 0.5},
	["SHAMAN"] = {0.25, 0.5, 0.25, 0.5},
	["PRIEST"] = {0.5, 0.75, 0.25, 0.5},
	["WARLOCK"] = {0.75, 1, 0.25, 0.5},
	["PALADIN"] = {0, 0.25, 0.5, 0.75},
	["DEATHKNIGHT"]	= {0.25, .5, 0.5, .75},
	["PETS"] = {0, 1, 0, 1},
	["MAINTANK"] = {0, 1, 0, 1},
	["MAINASSIST"] = {0, 1, 0, 1}
};
local class_un = {0, 0, 0, 0};

--- Retrieve the class ID for the class with the given proper name.
-- The proper name is the SECOND parameter returned from UnitClass(), and is
-- the fully capitalized English name of the class (e.g. "WARRIOR", "PALADIN")
function RDXMD.GetClassID(cn) return classToID[cn] or 0; end

-- Given the class ID, retrieve the proper classname
function RDXMD.GetClassMnemonic(cid) return idToClass[cid] or "UNKNOWN"; end

--- Given the class ID, retrieve the localized name for the class.
function RDXMD.GetClassName(cid) return idToLocalName[cid] or VFLI.i18n("Unknown"); end

--- Given the class ID, retrieve the class color as an RGB table.
function RDXMD.GetClassColor(cid) return idToClassColor[cid] or _grey; end
function RDXMD.GetClassColorFromEn(en) return nameToClassColor[en] or _grey; end

--- Given a *VALID* unit ID, get its class color.
function RDXMD.GetUnitClassColor(uid)
	local _,cn = UnitClass(uid);
	local id = classToID[cn];
	if not id then return _grey; end
	return idToClassColor[id] or _grey;
end

-- need find the points
function RDXMD.GetClassIcon(cn)
	return classIcons[cn] or class_un;
end

---------------------------------------------------------
-- metadata about role
--
local idToRole = { 
	"TANK", "HEALER", "DAMAGER", "NONE",
};
local roleToId = VFL.invert(idToRole);

function RDXMD.GetRoleName(cid) return idToRole[cid] or VFLI.i18n("Unknown"); end

local idToRoleColor = {};
idToRoleColor[1] = _blue;
idToRoleColor[2] = _green;
idToRoleColor[3] = _red;
idToRoleColor[4] = _yellow;

function RDXMD.GetRoleColor(cid) return idToRoleColor[cid] or _grey; end
--
-- Metadata about talent
--

local idToLocalsubclass = { 
	"Discipline", "Holy", "Shadow",
	"Balance", "Feral Combat", "Restoration",
	"Holy", "Protection", "Retribution",
	"Elemental", "Enhancement", "Restoration",
	"Arms", "Fury", "Protection",
	"Affliction", "Demonology", "Destruction",
	"Arcane", "Fire", "Frost",
	"Assassination","Combat", "Subtlety",
	"Beast Mastery", "Marksmanship", "Survival",
	"Blood", "Frost", "Unholy",
};
local localsubclassToID = VFL.invert(idToLocalsubclass);
local _unsubclass = "Unknown";

local talentIndex = {};
talentIndex["PRIEST"] = 1;
talentIndex["DRUID"] = 4;
talentIndex["PALADIN"] = 7;
talentIndex["SHAMAN"] = 10;
talentIndex["WARRIOR"] = 13;
talentIndex["WARLOCK"] = 16;
talentIndex["MAGE"] = 19;
talentIndex["ROGUE"] = 22;
talentIndex["HUNTER"] = 25;
talentIndex["DEATHKNIGHT"] = 28;
talentIndex["MONK"] = 31;

local idToSubClassColor = { 
	RAID_CLASS_COLORS["PRIEST"], RAID_CLASS_COLORS["PRIEST"], RAID_CLASS_COLORS["PRIEST"],
	RAID_CLASS_COLORS["DRUID"], RAID_CLASS_COLORS["DRUID"], RAID_CLASS_COLORS["DRUID"],
	RAID_CLASS_COLORS["PALADIN"], RAID_CLASS_COLORS["PALADIN"], RAID_CLASS_COLORS["PALADIN"],
	RAID_CLASS_COLORS["SHAMAN"], RAID_CLASS_COLORS["SHAMAN"], RAID_CLASS_COLORS["SHAMAN"],
	RAID_CLASS_COLORS["WARRIOR"], RAID_CLASS_COLORS["WARRIOR"], RAID_CLASS_COLORS["WARRIOR"],
	RAID_CLASS_COLORS["WARLOCK"], RAID_CLASS_COLORS["WARLOCK"], RAID_CLASS_COLORS["WARLOCK"],
	RAID_CLASS_COLORS["MAGE"], RAID_CLASS_COLORS["MAGE"], RAID_CLASS_COLORS["MAGE"],
	RAID_CLASS_COLORS["ROGUE"], RAID_CLASS_COLORS["ROGUE"], RAID_CLASS_COLORS["ROGUE"],
	RAID_CLASS_COLORS["HUNTER"], RAID_CLASS_COLORS["HUNTER"], RAID_CLASS_COLORS["HUNTER"],
	RAID_CLASS_COLORS["DEATHKNIGHT"], RAID_CLASS_COLORS["DEATHKNIGHT"], RAID_CLASS_COLORS["DEATHKNIGHT"],
	RAID_CLASS_COLORS["MONK"], RAID_CLASS_COLORS["MONK"], RAID_CLASS_COLORS["MONK"],
};
local localSubClassColorToID = VFL.invert(idToSubClassColor);
local _unsbColor = { r=.5, g=.5, b=.5};

local idToTexture = {};
idToTexture[1] = "Interface\\Icons\\Spell_Holy_PowerInfusion";
idToTexture[2] = "Interface\\Icons\\Spell_Holy_HolyBolt";
idToTexture[3] = "Interface\\Icons\\Spell_Shadow_ShadowWordPain";
idToTexture[4] = "Interface\\Icons\\Spell_Nature_Preservation";
idToTexture[5] = "Interface\\Icons\\Ability_Racial_BearForm";
idToTexture[6] = "Interface\\Icons\\Spell_Nature_HealingTouch";
idToTexture[7] = "Interface\\Icons\\Spell_Holy_HolyGuidance";
idToTexture[8] = "Interface\\Icons\\SPELL_HOLY_DEVOTIONAURA";
idToTexture[9] = "Interface\\Icons\\Spell_Holy_AuraOfLight";
idToTexture[10] = "Interface\\Icons\\Spell_Nature_Lightning";
idToTexture[11] = "Interface\\Icons\\Spell_Nature_LightningShield";
idToTexture[12] = "Interface\\Icons\\Spell_Nature_MagicImmunity";
idToTexture[13] = "Interface\\Icons\\Ability_MeleeDamage";
idToTexture[14] = "Interface\\Icons\\Ability_Warrior_InnerRage";
idToTexture[15] = "Interface\\Icons\\Ability_Warrior_DefensiveStance";
idToTexture[16] = "Interface\\Icons\\Spell_Shadow_DeathCoil";
idToTexture[17] = "Interface\\Icons\\Spell_Shadow_Metamorphosis";
idToTexture[18] = "Interface\\Icons\\Spell_Shadow_RainOfFire";
idToTexture[19] = "Interface\\Icons\\Spell_Arcane_Blast";
idToTexture[20] = "Interface\\Icons\\Spell_Fire_FlameBolt";
idToTexture[21] = "Interface\\Icons\\Spell_Frost_FrostBolt02";
idToTexture[22] = "Interface\\Icons\\Ability_Rogue_Eviscerate";
idToTexture[23] = "Interface\\Icons\\Ability_BackStab";
idToTexture[24] = "Interface\\Icons\\Ability_Rogue_MasterOfSubtlety";
idToTexture[25] = "Interface\\Icons\\Ability_Hunter_BeastTaming";
idToTexture[26] = "Interface\\Icons\\Ability_Marksmanship";
idToTexture[27] = "Interface\\Icons\\Ability_Hunter_SwiftStrike";
idToTexture[28] = "Interface\\Icons\\Spell_Deathknight_BloodPresence";
idToTexture[29] = "Interface\\Icons\\Spell_Deathknight_FrostPresence";
idToTexture[30] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence";

local _unsbTex = "Interface\\InventoryItems\\WoWUnknownItem01.blp";

function RDXMD.GetIdSubClassByLocal(scn)
	return localsubclassToID[scn] or 0;
end

function RDXMD.GetLocalSubclassById(scid)
	return idToLocalsubclass[scid] or _unsubclass;
end

function RDXMD.GetColorSubClassByLocal(scn)
	local idn = localsubclassToID[scn];
	if not idn then return _unsbColor; end
	return idToSubClassColor[idn] or _unsbColor;
end

function RDXMD.GetColorSubClassById(id)
	return idToSubClassColor[id] or _unsbColor;
end

function RDXMD.GetTextureSubClassByLocal(scn)
	local idn = localsubclassToID[scn];
	if not idn then return _unsbTex; end
	return idToTexture[idn] or _unsbTex;
end

function RDXMD.GetTextureSubClassById(id)
	return idToTexture[id] or _unsbTex;
end
-- TODOMOP
function RDXMD.GetSelfTextureTalent()
	local myunit = RDXDAL.GetMyUnit();
	local a = myunit:GetClassMnemonic();
	local tabPSTmp, idtab = 0, 1;
	--for i=1,GetNumTalentTabs() do
	--	local _, _, _, _, tabPS = GetTalentTabInfo(i);
	--	if tabPS > tabPSTmp then
	--		tabPSTmp = tabPS;
	--		idtab = i;
	--	end;
	--end;
	local id = talentIndex[a] + idtab - 1;
	return idToTexture[id];
end
-- TODOMOP
function RDXMD.GetSelfTalent()
	local myunit = RDXDAL.GetMyUnit();
	local a = myunit:GetClassMnemonic();
	local tabPSTmp, idtab = 0, 1;
	--for i=1,GetNumTalentTabs() do
	--	local _, _, _, _, tabPS = GetTalentTabInfo(i);
	--	if tabPS > tabPSTmp then
	--		tabPSTmp = tabPS;
	--		idtab = i;
	--	end;
	--end;
	if talentIndex[a] then
		local id = talentIndex[a] + idtab - 1;
		return id;
	else
		return 1;
	end
end
-- TODOMOP
function RDXMD.GetSelfTalentNoIndex()
	local tabPSTmp, idtab = 0, 1;
	--for i=1,GetNumTalentTabs() do
	--	local _, _, _, _, tabPS = GetTalentTabInfo(i);
	--	if tabPS > tabPSTmp then
	--		tabPSTmp = tabPS;
	--		idtab = i;
	--	end;
	--end;
	return idtab;
end

local function UpdateTalent()
	local myunit = RDXDAL.GetMyUnit();
	if not myunit then return; end
	local t = myunit:GetNField("sync");
	t.mt = RDXMD.GetSelfTalent();
end;

RDXEvents:Bind("INIT_DEFERRED", nil, UpdateTalent);
WoWEvents:Bind("PLAYER_TALENT_UPDATE", nil, UpdateTalent);

--
-- Metadata about PVP
--
local pvpIcons = {
	["Horde"] = {0.08, 0.58, 0.045, 0.545},
	["Alliance"] = {0.07, 0.58, 0.06, 0.57},
	["FFA"] = {0.05, 0.605, 0.015, 0.57},
}

function RDXMD.GetPVPIcon(cl)
	return pvpIcons[cl];
end

-----------------------
-- Runes
-----------------------
local RUNETYPE_BLOOD = 1;
local RUNETYPE_UNHOLY = 2;
local RUNETYPE_FROST = 3;
local RUNETYPE_DEATH = 4;

local iconTextures = {
	[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
	[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
	[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
	[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
}
function RDXMD.GetRuneIconTexturesNormal(id)
	return iconTextures[id];
end

local iconTexturesOn = {
	[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood-On",
	[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death-On",
	[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost-On",
	[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Chromatic-On",
}
function RDXMD.GetRuneIconTexturesOn(id)
	return iconTexturesOn[id];
end

local runeTexturesOff = {
	[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Blood-Off",
	[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Death-Off",
	[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost-Off",
	[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Chromatic-Off",
}
function RDXMD.GetRuneIconTexturesOff(id)
	return runeTexturesOff[id];
end

local runeTexturesList = {
	{ text = "Normal" },
	{ text = "On" },
	{ text = "Off" },
};
function RDXMD.RuneTextureTypeDropdownFunction() return runeTexturesList; end

local runeColors = {
	[RUNETYPE_BLOOD] = {1, 0, 0},
	[RUNETYPE_UNHOLY] = {0, 0.5, 0},
	[RUNETYPE_FROST] = {0, 1, 1},
	[RUNETYPE_DEATH] = {0.8, 0.1, 1},
}
function RDXMD.GetRuneColors(id)
	return runeColors[id];
end   

local runeMapping = {
	[1] = VFLI.i18n("BLOOD"),
	[2] = VFLI.i18n("UNHOLY"),
	[3] = VFLI.i18n("FROST"),
	[4] = VFLI.i18n("DEATH"),
}

function RDXMD.GetRuneMapping(id)
	return runeMapping[id];
end

-------------------------------------------
-- Pet Hapiness
-------------------------------------------
local pethapIcons = {
	[1] = {0.375, 0.5625, 0, 0.359375},
	[2] = {0.1875, 0.375, 0, 0.359375},
	[3] = {0, 0.1875, 0, 0.359375},
}

function RDXMD.GetPethapIcon(cl)
	return pethapIcons[cl];
end



