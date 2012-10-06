-- Metadata_Cooldowns.lua
--
-- Definitions for common cooldowns from WoW.
-- Soulstone
--[[

Logistics.RegisterCooldown({
	name = "ss";
	title = VFLI.i18n("Soulstone");
	icon = "Interface\\Icons\\Spell_Shadow_SoulGem";
	_timer = -1;
	Initialize = VFL.Noop;
	IsPossible = function()
		local c = RDXPlayer:GetClassMnemonic();
		if(c == nil, nil, "WARLOCK", nil) then return true; end
	end;
	Activate = function(self)
		Logistics._RegisterForUSS(self, VFLI.i18n("Soulstone Resurrection"));		
	end;
	CooldownUsed = function(self)
		self._timer = GetTime() + 1800;
	end;
	GetValue = function(self)
		if self._timer < 0 then
			return -1,1800;
		else
			return VFL.clamp(self._timer - GetTime(), 0, 1800), 1800;
		end
	end;
});

--- Determine the player's rank in the talent with the specified name.
-- Returns 0 if they don't have the talent trained.
function VFL.GetPlayerTalentRank(talent)
	for tab=1,GetNumTalentTabs() do
		for talentID=1,GetNumTalents(tab) do
			local name,_,_,_,rank = GetTalentInfo(tab, talentID);
			if name == talent then return rank;	end
		end
	end
	return 0;
end

-- Reinc
Logistics.RegisterCooldown({
	name = "reinc"; title = VFLI.i18n("Reincarnation");
	icon = "Interface\\Icons\\Spell_Nature_AgitatingTotem";
	_timer = -1;
	Initialize = VFL.Noop;
	IsPossible = function()
		local c = RDXPlayer:GetClassMnemonic();
		if (c == nil, nil, "SHAMAN", nil) then return true; end
	end;
	Activate = function(self)
		self._rank = VFL.GetPlayerTalentRank(VFLI.i18n("Improved Reincarnation"));
		hooksecurefunc("UseSoulstone", function()
			if HasSoulstone() == VFLI.i18n("Reincarnation") then self:CooldownUsed();	end
		end);
	end;
	CooldownUsed = function(self)
		self._timer = GetTime() + 3600 - (10 * self._rank);
	end;
	GetValue = function(self)
		if self._timer < 0 then
			return -1, 3600 - (10 * self._rank);
		else
			return VFL.clamp(self._timer - GetTime(), 0, 3600), 3600 - (10 * self._rank);
		end
	end;
});
]]
--------------------------
-- New system
--------------------------
--RDXEvents:Bind("INIT_SPELL", nil, function()
-- RACE  Worgen Draenei Dwarf Gnome Human NightElf Goblin BloodElf Orc Tauren Troll Scourge, Boss, Item
-- CLASS PRIEST DRUID PALADIN SHAMAN WARRIOR WARLOCK MAGE ROGUE HUNTER DEATHKNIGHT
-- text : race:class:talentindex:spellname
-- talent : 
--RDXCD.RegisterCooldown(race, class, talent, spellid, duration, group, event);



-- PRIEST SPELL
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 126123, 60, nil, "SPELL_CAST_SUCCESS"); --  Confession
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 17, 6, nil, "SPELL_CAST_SUCCESS"); --  Mot de pouvoir : Bouclier
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 8122, 30, nil, "SPELL_CAST_SUCCESS"); -- Cri psychique
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 586, 30, nil, "SPELL_CAST_SUCCESS"); -- Oubli
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 34433, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Ombrefiel
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 32379, 8, nil, "SPELL_CAST_SUCCESS"); -- Mot de l'ombre : Mort
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 6346, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Gardien de peur
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 64901, 6*60, nil, "SPELL_CAST_SUCCESS"); -- Hymne à l'espoir
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 33076, 10, nil, "SPELL_CAST_SUCCESS"); -- Prière de guérison
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 32375, 15, nil, "SPELL_DAMAGE"); -- Mass Dispel
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 73325, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Saut de foi
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 108968, 6*60, nil, "SPELL_CAST_SUCCESS"); -- Void shift


-- spe
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 81700, 30, nil, "SPELL_DAMAGE"); -- Archangel
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 81209, 30, nil, "SPELL_AURA_APPLIED"); -- Chakra chatier
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 81206, 30, nil, "SPELL_AURA_APPLIED"); -- Chakra sanctuaire
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 81208, 30, nil, "SPELL_AURA_APPLIED"); -- Chakra serenity
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 34861, 10, nil, "SPELL_CAST_SUCCESS"); -- Cercle de soins
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 47585, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Dispersion
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 64843, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Hymne divin
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 47788, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Esprit gardien
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 14914, 10, nil, "SPELL_DAMAGE"); -- Flammes sacrées
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 88625, 30, nil, "SPELL_CAST_SUCCESS"); -- Mot sacré : Châtier
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 89485, 45, nil, "SPELL_CAST_SUCCESS"); -- Focalisation intérieure
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 724, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Puits de lumière, see totem fire lol
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 8092, 8, nil, "SPELL_DAMAGE"); -- Attaque mentale
RDXCD.RegisterCooldown(nil, nil, "PRIEST","Discipline", 33206, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Suppression de la douleur
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 47540, 10, nil, "SPELL_CAST_SUCCESS"); -- Pénitence
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 62618, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Mot de pouvoir : Barrière
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 64044, 45, nil, "SPELL_CAST_SUCCESS"); -- Horreur psychique
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 527, 8, nil, "SPELL_CAST_SUCCESS"); -- Purify  -- CURE MAGIC DISEASE
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 15473, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Forme d'Ombre
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 15487, 45, nil, "SPELL_CAST_SUCCESS"); -- Silence  -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 109964, 60, nil, "SPELL_CAST_SUCCESS"); -- Spirit Shell
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 15286, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Vampiric Embrace

-- talent
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 605, 30, nil, "SPELL_CAST_SUCCESS"); -- Dominate mind
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 108921, 45, nil, "SPELL_CAST_SUCCESS"); -- psyfiend
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 108920, 30, nil, "SPELL_CAST_SUCCESS"); -- void tendrils
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 123040, 60, nil, "SPELL_CAST_SUCCESS"); -- mindbinder
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 19236, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Prière du désespoir
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 112833, 30, nil, "SPELL_CAST_SUCCESS"); -- spectral Guise
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 10060, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Infusion de puissance
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 121135, 25, nil, "SPELL_CAST_SUCCESS"); -- Cascade
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 110744, 15, nil, "SPELL_CAST_SUCCESS"); -- Divine star
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 120517, 40, nil, "SPELL_CAST_SUCCESS"); -- Halo

--RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 88684, 15, nil, "SPELL_CAST_SUCCESS"); -- Mot sacré : Sérénité
--RDXCD.RegisterCooldown(nil, nil, "PRIEST","Holy", 47755, 12, nil, "SPELL_CAST_SUCCESS"); -- Extase
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 14751, 30, nil, "SPELL_AURA_REMOVED"); -- Chakra

-- PALADIN SPELL
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 35395, 4.5, nil, "SPELL_CAST_SUCCESS"); --  Frappe du croise
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 20271, 6, nil, "SPELL_CAST_SUCCESS"); --  Jugement
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 853, 60, nil, "SPELL_CAST_SUCCESS"); --  Marteau de la justice
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 85673, 1.5, nil, "SPELL_CAST_SUCCESS"); --  Word of glory
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 25780, 1.5, nil, "SPELL_CAST_SUCCESS"); --  Righteous fury
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 62124, 8, nil, "SPELL_CAST_SUCCESS"); --  Main de rétribution
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 633, 10*60, nil, "SPELL_CAST_SUCCESS"); --  Imposition des mains
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 642, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Bouclier divin
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 4987, 8, nil, "SPELL_CAST_SUCCESS"); --  Cleanse  -- CURE DISEASE POISON
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 121183, 8, nil, "SPELL_CAST_SUCCESS"); --  comtemplation
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 498, 60, nil, "SPELL_CAST_SUCCESS"); --  Protection divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 96231, 15, nil, "SPELL_CAST_SUCCESS"); --  Réprimandes -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 24275, 6, nil, "SPELL_CAST_SUCCESS"); --  Marteau de courroux
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1022, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Main de protection
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1044, 25, nil, "SPELL_CAST_SUCCESS"); --  Main de liberté
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 31821, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Maitrise des auras
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1038, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Main de salut
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 31884, 3*60, nil, "SPELL_CAST_SUCCESS"); --  Corroux vengeur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 6940, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Main de sacrifice
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 115750, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Blinding light

-- spe
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 31850, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Ardent defenseur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 31935, 15, nil, "SPELL_CAST_SUCCESS"); -- Bouclier du vengeur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 53563, 3, nil, "SPELL_CAST_SUCCESS"); -- Beacon of light
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 26573, 9, nil, "SPELL_CAST_SUCCESS"); --  Consécration
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 31842, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Faveur divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 54428, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Supplique divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 879, 15, nil, "SPELL_CAST_SUCCESS"); --  Exorcism
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 86698, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Gardien of ancien Kings
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 86669, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Gardien of ancien Kings
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 86659, 3*60, nil, "SPELL_CAST_SUCCESS"); --  Gardien of ancien Kings
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 53595, 4.5, nil, "SPELL_CAST_SUCCESS"); -- Marteau du vertueux
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 20473, 6, nil, "SPELL_CAST_SUCCESS"); -- horion sacre
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 119072, 9, nil, "SPELL_CAST_SUCCESS"); -- holy wrath
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 53600, 1.5, nil, "SPELL_CAST_SUCCESS"); -- shiel of the righteous

-- talent
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 85499, 45, nil, "SPELL_CAST_SUCCESS"); --  speed of light
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 105593, 30, nil, "SPELL_CAST_SUCCESS"); --  Fist of justice
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 20066, 15, nil, "SPELL_CAST_SUCCESS"); -- Repentir
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 20925, 6, nil, "SPELL_CAST_SUCCESS"); --  Sacred Shield
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 114039, 30, nil, "SPELL_CAST_SUCCESS"); --  Hand of purity
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 105809, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Holy avenger
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 114157, 60, nil, "SPELL_CAST_SUCCESS"); --  Execution sentence
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 114165, 20, nil, "SPELL_CAST_SUCCESS"); --  holy prism
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 114158, 60, nil, "SPELL_CAST_SUCCESS"); --  Light's Hammer

--RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 2812, 15, nil, "SPELL_CAST_SUCCESS"); --  Colère divine
--RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 31789, 8, nil, "SPELL_CAST_SUCCESS"); --  Défense vertueuse
--RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 82327, 60, nil, "SPELL_CAST_SUCCESS"); --  Radiance sacrée
--RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 86150, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Gardien des anciens rois
--RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 53385, 4.5, nil, "SPELL_CAST_SUCCESS"); -- Tempête divine
--RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 85285, 30, nil, "SPELL_CAST_SUCCESS"); -- Bouclier saint
--RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 70940, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Gardien divin
--RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 85696, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fanatisme

RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1784, 6, nil, "SPELL_AURA_REMOVED"); -- Camouflage
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 5277, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Evasion
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1766, 15, nil, "SPELL_CAST_SUCCESS"); -- Coup de pied -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1776, 10, nil, "SPELL_CAST_SUCCESS"); -- Suriner
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 2983, 60, nil, "SPELL_CAST_SUCCESS"); -- sprint
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1725, 30, nil, "SPELL_CAST_SUCCESS"); -- Distraction
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 2094, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Cecité
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1856, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Disparition
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 408, 20, nil, "SPELL_CAST_SUCCESS"); -- Aiguillon perfide
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 51722, 60, nil, "SPELL_CAST_SUCCESS"); -- Démantèlement
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 31224, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Cape d'ombre
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 5938, 10, nil, "SPELL_CAST_SUCCESS"); -- Shic  -- ENRAGE
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 114842, 60, nil, "SPELL_CAST_SUCCESS"); -- shadow walk
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 57934, 30, nil, "SPELL_CAST_SUCCESS"); -- Ficelle du métier
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 114018, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Shroud of concealment
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 73981, 1*60, nil, "SPELL_CAST_SUCCESS"); -- Rediriger
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 76577, 3*60, nil, "SPELL_CAST_SUCCESS"); -- bombe fumigène
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 121471, 3*60, nil, "SPELL_CAST_SUCCESS"); -- shadow blades

-- spe
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 13750, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Poussée d'adrenaline
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 13877, 10, nil, "SPELL_CAST_SUCCESS"); -- Déluge de lames
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 51690, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Série meurtrière
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 14183, 20, nil, "SPELL_CAST_SUCCESS"); -- Préméditation
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 51713, 60, nil, "SPELL_CAST_SUCCESS"); -- Danse de l'ombre
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Assassination", 79140, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Vendetta

-- talent
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 74001, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Promptitude au combat
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 14185, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Préparation
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 36554, 24, nil, "SPELL_CAST_SUCCESS"); -- Pas de l'ombre

--RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1966, 10, nil, "SPELL_CAST_SUCCESS"); -- Feinte
--RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Assassination", 14177, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Sang froid

RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 126578, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Conjure Familiar
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 131784, 30*60, nil, "SPELL_CAST_SUCCESS"); -- Illusion
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 2136, 8, nil, "SPELL_CAST_SUCCESS"); -- Trait de feu
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 1953, 15, nil, "SPELL_CAST_SUCCESS"); -- transfert
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 122, 25, nil, "SPELL_CAST_SUCCESS"); -- Nova de givre
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 2139, 24, nil, "SPELL_CAST_SUCCESS"); -- contresort    -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 120, 10, nil, "SPELL_CAST_SUCCESS"); -- cone de froid
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 45438, 5*60, nil, "SPELL_CAST_SUCCESS"); -- bloc de glace
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 475, 8, nil, "SPELL_CAST_SUCCESS"); -- remove curse  -- CURE CURSE
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 12051, 2*60, nil, "SPELL_CAST_SUCCESS"); -- evocation
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 2120, 12, nil, "SPELL_CAST_SUCCESS"); -- flamestrike
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 55342, 3*60, nil, "SPELL_CAST_SUCCESS"); -- image miroir
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 66, 5*60, nil, "SPELL_CAST_SUCCESS"); -- invisibilité
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 44572, 30, nil, "SPELL_CAST_SUCCESS"); -- congélation
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 43987, 60, nil, "SPELL_CAST_SUCCESS"); -- Conjure Refreshment table
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 80353, 5*60, nil, "SPELL_CAST_SUCCESS"); -- distorsion temporelle
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 108978, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Alter time

-- spe
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 44425, 3, nil, "SPELL_CAST_SUCCESS"); -- Barrage des arcanes
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 12042, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- pouvoir des arcanes
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 11129, 45, nil, "SPELL_CAST_SUCCESS"); -- combustion
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 31661, 20, nil, "SPELL_CAST_SUCCESS"); -- souffle du dragon
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 84714, 60, nil, "SPELL_CAST_SUCCESS"); -- Frozen orb
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 12472, 3*60, nil, "SPELL_CAST_SUCCESS"); -- veines glaciales
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 108853, 8, nil, "SPELL_CAST_SUCCESS"); -- Inferno Blast
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 31687, 60, nil, "SPELL_CAST_SUCCESS"); -- Invocation d'un élémentaire d'eau

-- talent
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 108839, 60, nil, "SPELL_CAST_SUCCESS"); -- Ice Floes
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 12043, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- présence spirituelle
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 108843, 25, nil, "SPELL_CAST_SUCCESS"); -- Blazing speed
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 11426, 25, nil, "SPELL_CAST_SUCCESS"); -- barrière de glace
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 115610, 25, nil, "SPELL_CAST_SUCCESS"); -- Temporal Shield
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 102051, 20, nil, "SPELL_CAST_SUCCESS"); -- Frostjaw
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 111264, 20, nil, "SPELL_CAST_SUCCESS"); -- IceWard
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 113724, 30, nil, "SPELL_CAST_SUCCESS"); -- Ring of frost
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 11958, 3*60, nil, "SPELL_CAST_SUCCESS"); -- morsure du froid
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 110959, 2.5*60, nil, "SPELL_CAST_SUCCESS"); -- Greater invisibility
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 112948, 10, nil, "SPELL_CAST_SUCCESS"); -- Frost bomb
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 1463, 25, nil, "SPELL_CAST_SUCCESS"); -- bouclier de mana
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 116011, 6, nil, "SPELL_CAST_SUCCESS"); -- tune of power

--RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 543, 30, nil, "SPELL_CAST_SUCCESS"); -- gardien du mage
--RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 82731, 60, nil, "SPELL_CAST_SUCCESS"); -- Orbe enflammé
--RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 82676, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Anneau de givre
--RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 11113, 15, nil, "SPELL_CAST_SUCCESS"); -- vague explosive


RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73685, 15, nil, "SPELL_CAST_SUCCESS"); -- Unleash life
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73899, 8, nil, "SPELL_CAST_SUCCESS"); -- Frappe primordiale
RDXCD.RegisterCooldownGroup("Horion", "Interface\\Icons\\Spell_Holy_PrayerOfFortitude", 6)
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8042, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Horion de terre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8050, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Horion de flammes
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 57994, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Cisaille de vent  -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51886, 8, nil, "SPELL_CAST_SUCCESS"); -- Cleanse spirit
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8056, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Horion de givre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2484, 30, nil, "SPELL_CAST_SUCCESS"); -- Totem de lien terrestre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 115356, 8, nil, "SPELL_CAST_SUCCESS"); -- Stormblast
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 421, 3, nil, "SPELL_CAST_SUCCESS"); -- Chaine d'éclair
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 556, 15*60, nil, "SPELL_CAST_SUCCESS"); -- Rappel astral
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 5394, 30, nil, "SPELL_CAST_SUCCESS"); -- healing stream totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 20608, 30*60, nil, "SPELL_CAST_SUCCESS"); -- Réincarnation
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8177, 15, nil, "SPELL_CAST_SUCCESS"); -- Totem de glèbe
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8143, 60, nil, "SPELL_CAST_SUCCESS"); -- Totem de seisme
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2062, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Totem d'elementair de terre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73920, 10, nil, "SPELL_CAST_SUCCESS"); -- Pluie guérisseuse
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108269, 45, nil, "SPELL_CAST_SUCCESS"); -- Capacitor totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2894, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Totem d'élémentaire de feu
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2825, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Furie sanguinaire
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 32182, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Heroisme
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 120668, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Stormlash weapon
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51514, 45, nil, "SPELL_CAST_SUCCESS"); -- Maléfice
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73680, 15, nil, "SPELL_CAST_SUCCESS"); -- Déchainement des éléments
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 79206, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Grace du marcheur des esprits
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 114049, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Ascendance

-- spe
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 61882, 10, nil, "SPELL_CAST_SUCCESS"); -- earthquake
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 51533, 2*60, nil, "SPELL_CAST_SUCCESS"); -- esprit farouche
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 1535, 4, nil, "SPELL_CAST_SUCCESS"); -- Nova de feu
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51505, 8, nil, "SPELL_CAST_SUCCESS"); -- Explosion de lave
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 60103, 10, nil, "SPELL_CAST_SUCCESS"); -- Fouet de lave
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 16190, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Mana Tide Totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 77130, 8, nil, "SPELL_CAST_SUCCESS"); -- Purify spirit  -- CURE CURSE MAGIC
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Restoration", 61295, 6, nil, "SPELL_CAST_SUCCESS"); -- remous
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 30823, 60, nil, "SPELL_CAST_SUCCESS"); -- Rage du shaman
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 98008, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Spirit Link Totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 58875, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Spirit walk
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 17364, 8, nil, "SPELL_CAST_SUCCESS"); -- frappe tempête
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Elemental", 51490, 45, nil, "SPELL_CAST_SUCCESS"); -- orage

-- talent
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108271, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Astral Shift
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108270, 60, nil, "SPELL_CAST_SUCCESS"); -- Stone Bulwark totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51485, 30, nil, "SPELL_CAST_SUCCESS"); -- Earthgrab totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108273, 60, nil, "SPELL_CAST_SUCCESS"); -- Windwalk totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108285, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Call of the elements TODOMOP COOLDOWN RESET
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108287, 10, nil, "SPELL_CAST_SUCCESS"); -- Totem projection
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Restoration", 16188, 60, nil, "SPELL_CAST_SUCCESS"); -- Rapidité de la nature
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Elemental", 16166, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Maitrise élémentaire
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108281, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Ancestral guidance
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 108280, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Healing tide totem
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 117014, 12, nil, "SPELL_CAST_SUCCESS"); -- Elemental blast


--RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 5730, 20, nil, "SPELL_CAST_SUCCESS"); -- Totem de griffes de pierre

RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 2457, 3, nil, "SPELL_CAST_SUCCESS"); -- Battle stance
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 78, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Frappe heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 100, 20, nil, "SPELL_CAST_SUCCESS"); -- Charge
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 71, 3, nil, "SPELL_CAST_SUCCESS"); -- Defensive stance
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 355, 8, nil, "SPELL_CAST_SUCCESS"); -- Provocation
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 57755, 30, nil, "SPELL_CAST_SUCCESS"); -- Lancée heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6343, 6, nil, "SPELL_CAST_SUCCESS"); -- Coup de tonnerre
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6552, 15, nil, "SPELL_CAST_SUCCESS"); -- Volee de coup -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 676, 60, nil, "SPELL_CAST_SUCCESS"); -- Désarmement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 2458, 3, nil, "SPELL_CAST_SUCCESS"); -- Berseker stance
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6673, 60, nil, "SPELL_CAST_SUCCESS"); -- Cri de guerre
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 845, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Enchainement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 871, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Mur protecteur
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 5246, 60, nil, "SPELL_CAST_SUCCESS"); -- Cri d'intimidation
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 18499, 30, nil, "SPELL_CAST_SUCCESS"); -- Rage Berseker
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 85730, 60, nil, "SPELL_CAST_SUCCESS"); -- calme mortel
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1719, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Témérité
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 23920, 25, nil, "SPELL_CAST_SUCCESS"); -- Renvoi de sort
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 469, 60, nil, "SPELL_CAST_SUCCESS"); -- Cri de commandement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 3411, 30, nil, "SPELL_CAST_SUCCESS"); -- Intervention
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 64382, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Lancer fracassant
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 97462, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Rallying Cry
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6544, 45, nil, "SPELL_CAST_SUCCESS"); -- Bond heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 114203, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Demoralizing banner
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 114192, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Mocking banner
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 114207, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Skull banner

-- spe
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 23881, 4.5, nil, "SPELL_CAST_SUCCESS"); -- Sanguinaire
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 86346, 20, nil, "SPELL_CAST_SUCCESS"); -- Frappe du colosse
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1160, 60, nil, "SPELL_CAST_SUCCESS"); -- Demoralizing Shout
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 118038, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Die by the sword
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 12975, 3*60, nil, "SPELL_CAST_SUCCESS"); -- dernier rempart
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 12294, 6, nil, "SPELL_CAST_SUCCESS"); -- frappe mortelle
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6572, 9, nil, "SPELL_CAST_SUCCESS"); -- Revanche
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 112048, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Shield barrier
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 2565, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Maitrise du blocage
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 23922, 6, nil, "SPELL_CAST_SUCCESS"); -- heurt de bouclier
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 12328, 10, nil, "SPELL_CAST_SUCCESS"); -- attaque circulaire

-- talent
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 55694, 60, nil, "SPELL_CAST_SUCCESS"); -- Régénération enragée
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 103840, 30, nil, "SPELL_CAST_SUCCESS"); -- Impending Victory
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 102060, 40, nil, "SPELL_CAST_SUCCESS"); -- Disrupting shout
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 107566, 40, nil, "SPELL_CAST_SUCCESS"); -- Staggering shout
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 46924, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- tempête de lames
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 118000, 60, nil, "SPELL_CAST_SUCCESS"); -- Dragon roar
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 46968, 20, nil, "SPELL_CAST_SUCCESS"); -- onde de choc
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 114028, 60, nil, "SPELL_CAST_SUCCESS"); -- Mass spell reflection
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 114029, 30, nil, "SPELL_CAST_SUCCESS"); -- Safeguard
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 114030, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Vigilance
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 107574, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Avatar
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 12292, 60, nil, "SPELL_CAST_SUCCESS"); -- souhait mortel
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 107570, 30, nil, "SPELL_CAST_SUCCESS"); -- Storm bolt

--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 88161, 3, nil, "SPELL_CAST_SUCCESS"); -- Frappe
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 72, 12, nil, "SPELL_CAST_SUCCESS"); -- Coup de bouclier not existing anymore
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1680, 10, nil, "SPELL_CAST_SUCCESS"); -- Tourbillon
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1161, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Cri de défi
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 20252, 30, nil, "SPELL_CAST_SUCCESS"); -- Interception
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 20230, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Represailles
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1134, 30, nil, "SPELL_CAST_SUCCESS"); -- Rage intérieure
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 12809, 30, nil, "SPELL_CAST_SUCCESS"); -- coup traumatisant
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 60970, 30, nil, "SPELL_CAST_SUCCESS"); -- fureur heroique
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 85388, 45, nil, "SPELL_CAST_SUCCESS"); -- mise au tapis

-- DRUID

RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102543, 3*60, nil, "SPELL_CAST_SUCCESS"); --Incarnation: King of the Jungle
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102558, 3*60, nil, "SPELL_CAST_SUCCESS"); --Incarnation: Son of Ursoc
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 33878, 6, nil, "SPELL_CAST_SUCCESS"); -- Mutilation
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102547, 10, nil, "SPELL_CAST_SUCCESS"); -- Prowl
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 6795, 8, nil, "SPELL_CAST_SUCCESS"); -- Grondement
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 6807, 3, nil, "SPELL_CAST_SUCCESS"); -- Mutiler
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102560, 3*60, nil, "SPELL_CAST_SUCCESS"); --Incarnation: Chosen of Elune
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5215, 10, nil, "SPELL_CAST_SUCCESS"); -- Prowl
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 779, 3, nil, "SPELL_CAST_SUCCESS"); -- balayage
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 1850, 3*60, nil, "SPELL_CAST_SUCCESS"); -- célérité
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77758, 6, nil, "SPELL_CAST_SUCCESS"); -- rosser
--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5225, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Track Humanoïds
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 33745, 3, nil, "SPELL_CAST_SUCCESS"); -- Lacerate
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22812, 60, nil, "SPELL_CAST_SUCCESS"); -- ecorce
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 16689, 60, nil, "SPELL_CAST_SUCCESS"); -- emprise de la nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 29166, 3*60, nil, "SPELL_CAST_SUCCESS"); -- innervation
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 20484, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Renaissance
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22842, 1.5, nil, "SPELL_CAST_SUCCESS"); -- régénération frénétique
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 106922, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Might of Ursoc
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 740, 8*60, nil, "SPELL_CAST_SUCCESS"); -- tranquilité
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22570, 10, nil, "SPELL_CAST_SUCCESS"); -- estropier
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77761, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ruee rugissante
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77764, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ruee rugissante
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 106898, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ruee rugissante

-- spe
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102795, 60, nil, "SPELL_CAST_SUCCESS"); -- Bear hug
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 106952, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Berserk
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 112071, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Celestial Alignment
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5229, 60, nil, "SPELL_CAST_SUCCESS"); -- enrager
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102342, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ironbark
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 88423, 8, nil, "SPELL_CAST_SUCCESS"); -- Natural's cure  ---- CURE Magic Curse poison
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 2782, 8, nil, "SPELL_CAST_SUCCESS"); -- Remove corruption
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 62606, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Savage Defense
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 106839, 15, nil, "SPELL_CAST_SUCCESS"); -- Skull Bash    -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 78675, 60, nil, "SPELL_CAST_SUCCESS"); -- Rayon solaire
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 48505, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Météore
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 78674, 15, nil, "SPELL_CAST_SUCCESS"); -- Eruption stellaire
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 61336, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Instincts de survie
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 18562, 15, nil, "SPELL_CAST_SUCCESS"); -- Prompte guérison
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5217, 30, nil, "SPELL_CAST_SUCCESS"); -- fureur de tigre
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 48438, 8, nil, "SPELL_CAST_SUCCESS"); -- Croissange sauvage
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102791, 10, nil, "SPELL_CAST_SUCCESS"); -- champignon Bloom
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 88751, 10, nil, "SPELL_CAST_SUCCESS"); -- champignon détonation

-- talent
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102280, 30, nil, "SPELL_CAST_SUCCESS"); -- Displacer Beast
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102401, 15, nil, "SPELL_CAST_SUCCESS"); -- Wild Charge
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102351, 30, nil, "SPELL_CAST_SUCCESS"); -- Cenarion ward
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 132158, 60, nil, "SPELL_CAST_SUCCESS"); -- Nature's swiftness
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 108238, 2*60, nil, "SPELL_CAST_SUCCESS"); -- renewal
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102359, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Mass Entanglement
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 132469, 20, nil, "SPELL_CAST_SUCCESS"); -- typhoon
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 106737, 60, nil, "SPELL_CAST_SUCCESS"); -- Force of nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 106731, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Incarnation
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 99, 30, nil, "SPELL_CAST_SUCCESS"); -- Disorienting Roar
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5211, 50, nil, "SPELL_CAST_SUCCESS"); -- sonner
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 102793, 60, nil, "SPELL_CAST_SUCCESS"); -- Urdol's vortex
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 108288, 6*60, nil, "SPELL_CAST_SUCCESS"); -- Heart of the will
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 124974, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Nature-s Vigil

--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 467, 45, nil, "SPELL_CAST_SUCCESS"); -- Epines
--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 50769, 10, nil, "SPELL_CAST_SUCCESS"); -- Ressuciter
--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 80964, 60, nil, "SPELL_CAST_SUCCESS"); -- coup de crane
--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 80965, 60, nil, "SPELL_CAST_SUCCESS"); -- coup de crane
--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 16857, 6, nil, "SPELL_CAST_SUCCESS"); -- luciole
--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 8998, 10, nil, "SPELL_CAST_SUCCESS"); -- dérobade
--RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5209, 3*60, nil, "SPELL_CAST_SUCCESS"); -- rugissement provocateur
--RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 81283, 60, nil, "SPELL_CAST_SUCCESS"); -- croissance fongique
--RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 16979, 15, nil, "SPELL_CAST_SUCCESS"); -- charge farouche
--RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 49376, 30, nil, "SPELL_CAST_SUCCESS"); -- charge farouche
--RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 17116, 3*60, nil, "SPELL_CAST_SUCCESS"); -- rapidité de la nature
--RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 50516, 20, nil, "SPELL_CAST_SUCCESS"); -- Typhon
--RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 33831, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Force de la nature
--RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 50334, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Berserk


RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 5116, 5, nil, "SPELL_CAST_SUCCESS"); -- trait de choc
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 6991, 10, nil, "SPELL_CAST_SUCCESS"); -- Nourrir le familier
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 781, 25, nil, "SPELL_CAST_SUCCESS"); -- Désengagement
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 19503, 30, nil, "SPELL_CAST_SUCCESS"); -- Flèche de dispersion
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 1499, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège givrant
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 5384, 30, nil, "SPELL_CAST_SUCCESS"); -- Feindre la mort
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 53351, 10, nil, "SPELL_CAST_SUCCESS"); -- Tir mortel
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13813, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège explosive
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 1543, 20, nil, "SPELL_CAST_SUCCESS"); -- Fusée eclairante
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13809, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège de glace
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 77769, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Trap launcher
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 20736, 8, nil, "SPELL_CAST_SUCCESS"); -- Trait provocateur
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 3045, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Tir rapide
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 23989, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Readiness (MOPTODO wipe cooldowns)
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34600, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège à serpent
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 53271, 45, nil, "SPELL_CAST_SUCCESS"); -- Appel du maitre
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34477, 30, nil, "SPELL_CAST_SUCCESS"); -- Détournement
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 19263, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Dissuasion
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 51753, 60, nil, "SPELL_CAST_SUCCESS"); -- Dissimulation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 121818, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Stampede

-- spe
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 19574, 60, nil, "SPELL_CAST_SUCCESS"); -- courroux bestial
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 3674, 30, nil, "SPELL_CAST_SUCCESS"); -- Flèche noire
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 53209, 9, nil, "SPELL_CAST_SUCCESS"); -- Tir de la chimère
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 53301, 6, nil, "SPELL_CAST_SUCCESS"); -- Tir explosif
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 19577, 60, nil, "SPELL_CAST_SUCCESS"); -- intimidation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34026, 6, nil, "SPELL_CAST_SUCCESS"); -- Ordre de tuer

-- talent
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 109248, 45, nil, "SPELL_CAST_SUCCESS"); -- binding shot
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 34490, 20, nil, "SPELL_CAST_SUCCESS"); -- Flèche baillon -- INTERRUPT
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 19386, 60, nil, "SPELL_CAST_SUCCESS"); -- Piqure de wyverne
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 109304, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Exhilaration
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 120679, 30, nil, "SPELL_CAST_SUCCESS"); -- Dire Beast
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 82726, 30, nil, "SPELL_CAST_SUCCESS"); -- Ferveur
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 131894, 2*60, nil, "SPELL_CAST_SUCCESS"); -- A Murder of Crows
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 130392, 20, nil, "SPELL_CAST_SUCCESS"); -- Blind Strike
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 120697, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Linx rush
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 120360, 30, nil, "SPELL_CAST_SUCCESS"); -- Barrage
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 117050, 15, nil, "SPELL_CAST_SUCCESS"); -- Glaive Toss
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 109259, 60, nil, "SPELL_CAST_SUCCESS"); -- Power shot

--[[
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 2973, 6, nil, "SPELL_CAST_SUCCESS"); -- attaque du raptor
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13795, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège d'immolation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82945, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège d'immolation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 60192, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège givrant
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82939, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège explosive
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82941, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège de glace
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82948, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège à serpent
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 19306, 5, nil, "SPELL_CAST_SUCCESS"); -- Contre attaque
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 82692, 15, nil, "SPELL_CAST_SUCCESS"); -- Focalisation du feu
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 23989, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Promptitude
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 53209, 10, nil, "SPELL_CAST_SUCCESS"); -- Tir de la chimère
]]

RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 127344, 15, nil, "SPELL_CAST_SUCCESS"); -- Corpse explosion
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 50977, 60, nil, "SPELL_CAST_SUCCESS"); -- Porte de la mort
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 49576, 25, nil, "SPELL_CAST_SUCCESS"); -- Poigne de la mort
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 46584, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Réanimation morbide
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47528, 15, nil, "SPELL_CAST_SUCCESS"); -- Gel de l'esprit
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47476, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Strangulation
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 43265, 30, nil, "SPELL_CAST_SUCCESS"); -- Mort de décomposition
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48792, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Robustesse glaciale
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 57330, 20, nil, "SPELL_CAST_SUCCESS"); -- Cor de l'hiver
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48707, 45, nil, "SPELL_CAST_SUCCESS"); -- Carapace anti magie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 61999, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Réanimation dun allié
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47568, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Renforcer l'arme runique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 42650, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Armée de morts
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 77575, 60, nil, "SPELL_CAST_SUCCESS"); -- Pousee de fievre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 77606, 60, nil, "SPELL_CAST_SUCCESS"); -- Sombre simulacre

-- spe
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 50034, 3*60, nil, "SPELL_CAST_SUCCESS"); -- blood rites
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 49222, 60, nil, "SPELL_CAST_SUCCESS"); --  Bouclier d'os
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 49028, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- arme runique dansante 
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 56222, 8, nil, "SPELL_CAST_SUCCESS"); -- Sombre ordre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 51271, 60, nil, "SPELL_CAST_SUCCESS"); -- Pilier de givre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 48982, 30, nil, "SPELL_CAST_SUCCESS"); -- Connexion runique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 130736, 6, nil, "SPELL_CAST_SUCCESS"); -- Soul reaper
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 130735, 6, nil, "SPELL_CAST_SUCCESS"); -- Soul reaper
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 114866, 6, nil, "SPELL_CAST_SUCCESS"); -- Soul reaper
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 49206, 3*60, nil, "SPELL_CAST_SUCCESS"); -- invocation d'une gargouille 
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 49016, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Frénésie impie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 55233, 60, nil, "SPELL_CAST_SUCCESS"); -- sang vampirique

-- talent
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 123693, 25, nil, "SPELL_CAST_SUCCESS"); -- Plague leach
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 115989, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Unholy Blight
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 51052, 2*60, nil, "SPELL_CAST_SUCCESS"); -- zone anti magie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 49039, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Changeliche
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 108194, 1*60, nil, "SPELL_CAST_SUCCESS"); -- Asphyxiate
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 96268, 30, nil, "SPELL_CAST_SUCCESS"); -- Death's Advance
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48743, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Pacte mortel
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 108201, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Desecrated ground
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 108199, 60, nil, "SPELL_CAST_SUCCESS"); -- Gorefiend's Grasp
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 108200, 60, nil, "SPELL_CAST_SUCCESS"); -- Remorseless Winter


--RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 45529, 60, nil, "SPELL_CAST_SUCCESS"); -- Drain sanglant
--RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 49203, 60, nil, "SPELL_CAST_SUCCESS"); -- Froid dévorant


RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 114168, 10, nil, "SPELL_CAST_SUCCESS"); -- Dark Apotheosis
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 20707, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Soulstone
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 104316, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Imp Swarm
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 6229, 30, nil, "SPELL_CAST_SUCCESS"); -- Gardien d'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 698, 2*60, nil, "SPELL_CAST_SUCCESS"); -- rituel d'invocation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 1122, 10*60, nil, "SPELL_CAST_SUCCESS"); -- invocation infernale
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 18540, 10*60, nil, "SPELL_CAST_SUCCESS"); -- invocation garde funeste
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 104773, 3*60, nil, "SPELL_CAST_SUCCESS"); -- unending resolve
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 29858, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Brise dame
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 29893, 2*60, nil, "SPELL_CAST_SUCCESS"); -- rituel des ames
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 48020, 30, nil, "SPELL_CAST_SUCCESS"); -- cercle démoniquae téléportation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 77801, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ame du demon

-- spe
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 103967, 12, nil, "SPELL_CAST_SUCCESS"); -- Carrion Swarm
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 113858, 2*60, nil, "SPELL_CAST_SUCCESS"); -- dark soul instability
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 113861, 2*60, nil, "SPELL_CAST_SUCCESS"); -- dark soul knowledge
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 113860, 2*60, nil, "SPELL_CAST_SUCCESS"); -- dark soul misery
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 109151, 10, nil, "SPELL_CAST_SUCCESS"); -- demonic leap
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108683, 1, nil, "SPELL_CAST_SUCCESS"); -- Fire and brimstone
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 120451, 60, nil, "SPELL_CAST_SUCCESS"); -- Flames of Xoroth
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 80240, 45, nil, "SPELL_CAST_SUCCESS"); -- Havoc
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 103958, 10, nil, "SPELL_CAST_SUCCESS"); -- Metamorphosis

-- talent
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108359, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Dark regeneration
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 5484, 40, nil, "SPELL_CAST_SUCCESS"); -- hurlement de terreur
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 6789, 45, nil, "SPELL_CAST_SUCCESS"); -- Voile mortel
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 30283, 30, nil, "SPELL_CAST_SUCCESS"); -- Furie de l'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 110913, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Dark Bargain
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108416, 60, nil, "SPELL_CAST_SUCCESS"); -- Sacrifice Pact
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108415, 10, nil, "SPELL_CAST_SUCCESS"); -- Soul link
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 11397, 10, nil, "SPELL_CAST_SUCCESS"); -- Blood fear
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108482, 60, nil, "SPELL_CAST_SUCCESS"); -- Unbound will
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108503, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Grimoire of Sacrifice
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108501, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Grimoire of Service
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 108505, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Archimondd's Vengeance
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 119049, 60, nil, "SPELL_CAST_SUCCESS"); -- Kil'jaeden's Cunning


--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 74434, 45, nil, "SPELL_CAST_SUCCESS"); -- Brulure d'ame
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 79268, 30, nil, "SPELL_CAST_SUCCESS"); -- Récolte d'ames
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 50589, 30, nil, "SPELL_CAST_SUCCESS"); -- Aura d'immolation
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 54785, 45, nil, "SPELL_CAST_SUCCESS"); -- Bond démoniaque
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 47897, 12, nil, "SPELL_CAST_SUCCESS"); -- ombreflamme
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 17877, 15, nil, "SPELL_CAST_SUCCESS"); -- brulure de l'ombre
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Demonology", 47193, 60, nil, "SPELL_CAST_SUCCESS"); -- renforcement démoniaque
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Demonology", 71521, 12, nil, "SPELL_CAST_SUCCESS"); -- main de guldan
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 91711, 30, nil, "SPELL_CAST_SUCCESS"); -- Gardien du néant
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Affliction", 48181, 8, nil, "SPELL_CAST_SUCCESS"); -- Hanter
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 50796, 12, nil, "SPELL_CAST_SUCCESS"); -- Trai du chaos
--RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 17962, 10, nil, "SPELL_CAST_SUCCESS"); -- Conflagration



RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 109132, 20, nil, "SPELL_CAST_SUCCESS"); -- Roll
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115546, 8, nil, "SPELL_CAST_SUCCESS"); -- Provoke
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115450, 8, nil, "SPELL_CAST_SUCCESS"); -- Detox     CURE POISON DISEASE
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 126892, 30*60, nil, "SPELL_CAST_SUCCESS"); -- Zen Pilgrimage
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115080, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Touch of death
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115203, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Fortifying Brew
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115072, 15, nil, "SPELL_CAST_SUCCESS"); -- Expel harm
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 116705, 15, nil, "SPELL_CAST_SUCCESS"); -- Spear Hand Strike
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115078, 15, nil, "SPELL_CAST_SUCCESS"); -- Paralysis
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115460, 0.5, nil, "SPELL_CAST_SUCCESS"); -- Healing sphere
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 117368, 60, nil, "SPELL_CAST_SUCCESS"); -- Grapple weapon
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115543, 20, nil, "SPELL_CAST_SUCCESS"); -- Leer of the Ox
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115176, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Zen Meditation
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 101643, 45, nil, "SPELL_CAST_SUCCESS"); -- Transcendence

-- spe
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115213, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Avert Harm
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 122057, 35, nil, "SPELL_CAST_SUCCESS"); -- clash
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115308, 9, nil, "SPELL_CAST_SUCCESS"); -- elusive brew
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115288, 60, nil, "SPELL_CAST_SUCCESS"); -- energizing brew
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 113656, 25, nil, "SPELL_CAST_SUCCESS"); -- fists of fury
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 101545, 25, nil, "SPELL_CAST_SUCCESS"); -- Flying Serpent kick
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115295, 30, nil, "SPELL_CAST_SUCCESS"); -- Guard
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 121253, 8, nil, "SPELL_CAST_SUCCESS"); -- Keg Smash
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 116849, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Life cocoon
--RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 119582, 1, nil, "SPELL_CAST_SUCCESS"); -- Purifying brew
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115151, 8, nil, "SPELL_CAST_SUCCESS"); -- Renewing mist
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115310, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Revival
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 107428, 8, nil, "SPELL_CAST_SUCCESS"); -- Rising sun kick
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115315, 30, nil, "SPELL_CAST_SUCCESS"); -- Summon Black Ox Statue
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115313, 30, nil, "SPELL_CAST_SUCCESS"); -- Summon ade Serpent Statue
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 116680, 45, nil, "SPELL_CAST_SUCCESS"); -- Thunder focus tea
--RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 116740, 1, nil, "SPELL_CAST_SUCCESS"); -- Tigereye Brew
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 122470, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Touch of karma

-- talent
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 116841, 30, nil, "SPELL_CAST_SUCCESS"); -- Tiger's Lust
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 123986, 8, nil, "SPELL_CAST_SUCCESS"); -- Chi wave
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 115399, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Chi Brew
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 119392, 60, nil, "SPELL_CAST_SUCCESS"); -- Charging Ox Wave
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 119381, 45, nil, "SPELL_CAST_SUCCESS"); -- Leg Sweep
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 122278, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Dampen Harm
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 122783, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Diffuse Magic
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 123904, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Invoke Xuen, the White Tiger
RDXCD.RegisterCooldown(nil, nil, "MONK", nil, 116847, 30, nil, "SPELL_CAST_SUCCESS"); -- Rushing Jade wing

RDXCD.RegisterCooldown("Troll", nil, nil, nil, 26297, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Berserk
RDXCD.RegisterCooldown("NightElf", nil, nil, nil, 58984, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Camouflage de l'ombre
RDXCD.RegisterCooldown("Scourge", nil, nil, nil, 20577, 2*60, nil, "SPELL_CAST_SUCCESS"); -- canibalisme
RDXCD.RegisterCooldown("Human", nil, nil, nil, 59752, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Chacun pour soi
RDXCD.RegisterCooldown("Tauren", nil, nil, nil, 20549, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Choc martial

RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59545, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59543, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59548, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 121093, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59542, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59544, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59547, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 28880, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu

RDXCD.RegisterCooldown("Dwarf", nil, nil, nil, 20594, 2*60, nil, "SPELL_AURA_APPLIED"); -- forme de pierre

RDXCD.RegisterCooldown("Orc", nil, nil, nil, 20572, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fureur sanguinaire
RDXCD.RegisterCooldown("Orc", nil, nil, nil, 33697, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fureur sanguinaire
RDXCD.RegisterCooldown("Orc", nil, nil, nil, 33702, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fureur sanguinaire

RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69070, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fusee de saut
RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69046, 30*60, nil, "SPELL_CAST_SUCCESS"); -- Hobe gobelin de bat
RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69041, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Barrage de fusee
RDXCD.RegisterCooldown("Gnome", nil, nil, nil, 20589, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Maitre de l'evasion
RDXCD.RegisterCooldown("Worgen", nil, nil, nil, 68992, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Sombre course

--RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 28730, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Torrent arcanique
RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 50613, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Torrent arcanique
RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 80483, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Torrent arcanique
RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 129597, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Torrent arcanique
RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 25046, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Torrent arcanique
RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 69179, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Torrent arcanique

RDXCD.RegisterCooldown("Scourge", nil, nil, nil, 7744, 2*60, nil, "SPELL_CAST_SUCCESS"); -- volonte reprouve

-- métier herboriste

--ITEM
RDXCD.RegisterCooldown("Item", nil, nil, nil, 42292, 2*60, nil, "SPELL_CAST_SUCCESS"); -- PVP trinket

RDXCD.RegisterCooldown("Item", nil, nil, nil, 74241, 45, nil, "SPELL_AURA_APPLIED");  -- Power Torrent
RDXCD.RegisterCooldown("Item", nil, nil, nil, 89091, 45, nil, "SPELL_AURA_APPLIED");  -- DMC: Volcano
RDXCD.RegisterCooldown("Item", nil, nil, nil, 97007, 60, nil, "SPELL_CAST_SUCCESS"); -- Rune of Zeth
RDXCD.RegisterCooldown("Item", nil, nil, nil, 100612, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Moonwell Chalice
RDXCD.RegisterCooldown("Item", nil, nil, nil, 102662, 45, nil, "SPELL_AURA_APPLIED"); -- Foul Gift of the Demon Lord
RDXCD.RegisterCooldown("Item", nil, nil, nil, 82174, 60, nil, "SPELL_CAST_SUCCESS"); -- Synapse Springs
RDXCD.RegisterCooldown("Item", nil, nil, nil, 107982, 2*50, nil, "SPELL_AURA_APPLIED"); -- Insignia of the Corrupted Mind



