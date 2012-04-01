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
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 17, 3, nil, "SPELL_CAST_SUCCESS"); --  Mot de pouvoir : Bouclier
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 8092, 8, nil, "SPELL_DAMAGE"); -- Attaque mentale
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 8122, 30, nil, "SPELL_CAST_SUCCESS"); -- Cri psychique
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 14914, 10, nil, "SPELL_DAMAGE"); -- Flammes sacrées
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 88684, 15, nil, "SPELL_CAST_SUCCESS"); -- Mot sacré : Sérénité
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 586, 30, nil, "SPELL_CAST_SUCCESS"); -- Oubli
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 32379, 10, nil, "SPELL_CAST_SUCCESS"); -- Mot de l'ombre : Mort
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 6346, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Gardien de peur
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 64901, 6*60, nil, "SPELL_CAST_SUCCESS"); -- Hymne à l'espoir
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 34433, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Ombrefiel
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 33076, 10, nil, "SPELL_CAST_SUCCESS"); -- Prière de guérison
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 64843, 8*60, nil, "SPELL_CAST_SUCCESS"); -- Hymne divin
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 73325, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Saut de foi

-- PRIEST TALENT
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 89485, 45, nil, "SPELL_CAST_SUCCESS"); -- Focalisation intérieure
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 10060, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Infusion de puissance
RDXCD.RegisterCooldown(nil, nil, "PRIEST","Discipline", 33206, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Suppression de la douleur
RDXCD.RegisterCooldown(nil, nil, "PRIEST","Holy", 47755, 12, nil, "SPELL_CAST_SUCCESS"); -- Extase
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 19236, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Prière du désespoir
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 724, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Puits de lumière, see totem fire lol
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 14751, 30, nil, "SPELL_AURA_REMOVED"); -- Chakra
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 81209, 60, nil, "SPELL_AURA_APPLIED"); -- Chakra chatier
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 81206, 60, nil, "SPELL_AURA_APPLIED"); -- Chakra sanctuaire
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 34861, 10, nil, "SPELL_CAST_SUCCESS"); -- Cercle de soins
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 47788, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Esprit gardien
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 62618, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Mot de pouvoir : Barrière
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 15473, 1.5, nil, "SPELL_CAST_SUCCESS"); -- Forme d'Ombre
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 15487, 45, nil, "SPELL_CAST_SUCCESS"); -- Silence
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 64044, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Horreur psychique
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 47585, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Dispersion


-- PRIEST SPECIALISATION
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 88625, 30, nil, "SPELL_CAST_SUCCESS"); -- Mot sacré : Châtier
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 47540, 12, nil, "SPELL_CAST_SUCCESS"); -- Pénitence

-- PALADIN SPELL
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 35395, 4.5, nil, "SPELL_CAST_SUCCESS"); --  Frappe du croise
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 20271, 8, nil, "SPELL_CAST_SUCCESS"); --  Jugement
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 62124, 8, nil, "SPELL_CAST_SUCCESS"); --  Main de rétribution
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 853, 60, nil, "SPELL_CAST_SUCCESS"); --  Marteau de la justice
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 633, 10*60, nil, "SPELL_CAST_SUCCESS"); --  Imposition des mains
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1022, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Main de protection
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 26573, 30, nil, "SPELL_CAST_SUCCESS"); --  Consécration
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 2812, 15, nil, "SPELL_CAST_SUCCESS"); --  Colère divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 498, 60, nil, "SPELL_CAST_SUCCESS"); --  Protection divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 31789, 8, nil, "SPELL_CAST_SUCCESS"); --  Défense vertueuse
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 54428, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Supplique divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 24275, 6, nil, "SPELL_CAST_SUCCESS"); --  Marteau de courroux
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 642, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Bouclier divin
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1044, 25, nil, "SPELL_CAST_SUCCESS"); --  Main de liberté
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 96231, 10, nil, "SPELL_CAST_SUCCESS"); --  Réprimandes
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1038, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Main de salut
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 31884, 3*60, nil, "SPELL_CAST_SUCCESS"); --  Corroux vengeur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 6940, 2*60, nil, "SPELL_CAST_SUCCESS"); --  Main de sacrifice
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 82327, 60, nil, "SPELL_CAST_SUCCESS"); --  Radiance sacrée
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 86150, 5*60, nil, "SPELL_CAST_SUCCESS"); --  Gardien des anciens rois

RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 31842, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Faveur divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 53595, 4.5, nil, "SPELL_CAST_SUCCESS"); -- Marteau du vertueux
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 53385, 4.5, nil, "SPELL_CAST_SUCCESS"); -- Tempête divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 85285, 30, nil, "SPELL_CAST_SUCCESS"); -- Bouclier saint
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 70940, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Gardien divin
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 31821, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Maitrise des auras
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 20066, 60, nil, "SPELL_CAST_SUCCESS"); -- Repentir
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 31850, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Ardent defenseur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 85696, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fanatisme

RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 31935, 15, nil, "SPELL_CAST_SUCCESS"); -- Bouclier du vengeur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 20473, 6, nil, "SPELL_CAST_SUCCESS"); -- horion sacre

RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1784, 10, nil, "SPELL_AURA_REMOVED"); -- Camouflage
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 5277, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Evasion
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1766, 10, nil, "SPELL_CAST_SUCCESS"); -- Coup de pied
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 2983, 60, nil, "SPELL_CAST_SUCCESS"); -- sprint
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1776, 10, nil, "SPELL_CAST_SUCCESS"); -- Suriner
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1856, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Disparition
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1725, 30, nil, "SPELL_CAST_SUCCESS"); -- Distraction
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 408, 20, nil, "SPELL_CAST_SUCCESS"); -- Aiguillon perfide
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 2094, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Cecité
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 51722, 60, nil, "SPELL_CAST_SUCCESS"); -- Démantèlement
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1966, 10, nil, "SPELL_CAST_SUCCESS"); -- Feinte
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 31224, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Cape d'ombre
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 57934, 30, nil, "SPELL_CAST_SUCCESS"); -- Ficelle du métier
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 74001, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Promptitude au combat
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 73981, 1*60, nil, "SPELL_CAST_SUCCESS"); -- Rediriger
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 76577, 3*60, nil, "SPELL_CAST_SUCCESS"); -- bombe fumigène

RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Assassination", 14177, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Sang froid
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 14183, 20, nil, "SPELL_CAST_SUCCESS"); -- Préméditation
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 13750, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Poussée d'adrenaline
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 14185, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Préparation
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 51713, 60, nil, "SPELL_CAST_SUCCESS"); -- Danse de l'ombre
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 51690, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Série meurtrière
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Assassination", 79140, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Vendetta

RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 13877, 10, nil, "SPELL_CAST_SUCCESS"); -- Déluge de lames
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 36554, 24, nil, "SPELL_CAST_SUCCESS"); -- Pas de l'ombre


RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 2136, 8, nil, "SPELL_CAST_SUCCESS"); -- Trait de feu
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 122, 25, nil, "SPELL_CAST_SUCCESS"); -- Nova de givre
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 2139, 24, nil, "SPELL_CAST_SUCCESS"); -- contresort
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 12051, 4*60, nil, "SPELL_CAST_SUCCESS"); -- evocation
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 1953, 15, nil, "SPELL_CAST_SUCCESS"); -- transfert
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 120, 10, nil, "SPELL_CAST_SUCCESS"); -- cone de froid
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 45438, 5*60, nil, "SPELL_CAST_SUCCESS"); -- bloc de glace
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 543, 30, nil, "SPELL_CAST_SUCCESS"); -- gardien du mage
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 1463, 12, nil, "SPELL_CAST_SUCCESS"); -- bouclier de mana
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 55342, 3*60, nil, "SPELL_CAST_SUCCESS"); -- image miroir
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 66, 3*60, nil, "SPELL_CAST_SUCCESS"); -- invisibilité
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 82731, 60, nil, "SPELL_CAST_SUCCESS"); -- Orbe enflammé
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 82676, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Anneau de givre
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 80353, 5*60, nil, "SPELL_CAST_SUCCESS"); -- distorsion temporelle

RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 12043, 2*60, nil, "SPELL_CAST_SUCCESS"); -- présence spirituelle
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 11113, 15, nil, "SPELL_CAST_SUCCESS"); -- vague explosive
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 12472, 3*60, nil, "SPELL_CAST_SUCCESS"); -- veines glaciales
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 11129, 2*60, nil, "SPELL_CAST_SUCCESS"); -- combustion
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 11958, 8*60, nil, "SPELL_CAST_SUCCESS"); -- morsure du froid
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 11426, 30, nil, "SPELL_CAST_SUCCESS"); -- barrière de glace
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 31661, 20, nil, "SPELL_CAST_SUCCESS"); -- souffle du dragon
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 44572, 30, nil, "SPELL_CAST_SUCCESS"); -- congélation
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 12042, 2*60, nil, "SPELL_CAST_SUCCESS"); -- pouvoir des arcanes

RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 44425, 4, nil, "SPELL_CAST_SUCCESS"); -- Barrage des arcanes
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 31687, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Invocation d'un élémentaire d'eau


RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73899, 8, nil, "SPELL_CAST_SUCCESS"); -- Frappe primordiale
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8042, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Horion de terre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8050, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Horion de flammes
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 57994, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Cisaille de vent
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2484, 15, nil, "SPELL_CAST_SUCCESS"); -- Totem de lien terrestre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8056, 6, "Horion", "SPELL_CAST_SUCCESS"); -- Horion de givre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 1535, 10, nil, "SPELL_CAST_SUCCESS"); -- Nova de feu
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 421, 3, nil, "SPELL_CAST_SUCCESS"); -- Chaine d'éclair
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 20608, 30*60, nil, "SPELL_CAST_SUCCESS"); -- Réincarnation
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 556, 15*60, nil, "SPELL_CAST_SUCCESS"); -- Rappel astral
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51505, 8, nil, "SPELL_CAST_SUCCESS"); -- Explosion de lave
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8177, 15, nil, "SPELL_CAST_SUCCESS"); -- Totem de glèbe
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8143, 60, nil, "SPELL_CAST_SUCCESS"); -- Totem de seisme
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2062, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Totem d'elementair de terre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 5730, 20, nil, "SPELL_CAST_SUCCESS"); -- Totem de griffes de pierre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2894, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Totem d'élémentaire de feu
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 32182, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Heroisme
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2825, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Furie sanguinaire
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51514, 45, nil, "SPELL_CAST_SUCCESS"); -- Maléfice
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73680, 15, nil, "SPELL_CAST_SUCCESS"); -- Déchainement des éléments
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73920, 10, nil, "SPELL_CAST_SUCCESS"); -- Pluie guérisseuse
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 79206, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Grace du marcheur des esprits

RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 17364, 8, nil, "SPELL_CAST_SUCCESS"); -- frappe tempête
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Restoration", 16188, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Rapidité de la nature
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Elemental", 16166, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Maitrise élémentaire
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 30823, 60, nil, "SPELL_CAST_SUCCESS"); -- Rage du shaman
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 51533, 2*60, nil, "SPELL_CAST_SUCCESS"); -- esprit farouche
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Restoration", 61295, 6, nil, "SPELL_CAST_SUCCESS"); -- remous

RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 60103, 10, nil, "SPELL_CAST_SUCCESS"); -- Fouet de lave
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Elemental", 51490, 45, nil, "SPELL_CAST_SUCCESS"); -- orage

RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 88161, 3, nil, "SPELL_CAST_SUCCESS"); -- Frappe
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 100, 15, nil, "SPELL_CAST_SUCCESS"); -- Charge
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6343, 6, nil, "SPELL_CAST_SUCCESS"); -- Coup de tonnerre
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 355, 8, nil, "SPELL_CAST_SUCCESS"); -- Provocation
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 78, 3, nil, "SPELL_CAST_SUCCESS"); -- Frappe heroique
--RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 72, 12, nil, "SPELL_CAST_SUCCESS"); -- Coup de bouclier not existing anymore
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6673, 60, nil, "SPELL_CAST_SUCCESS"); -- Cri de guerre
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 845, 3, nil, "SPELL_CAST_SUCCESS"); -- Enchainement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 2565, 60, nil, "SPELL_CAST_SUCCESS"); -- Maitrise du blocage
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 676, 60, nil, "SPELL_CAST_SUCCESS"); -- Désarmement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1680, 10, nil, "SPELL_CAST_SUCCESS"); -- Tourbillon
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6552, 10, nil, "SPELL_CAST_SUCCESS"); -- Volee de coup
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6572, 5, nil, "SPELL_CAST_SUCCESS"); -- Revanche
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 5246, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Cri d'intimidation
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1161, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Cri de défi
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 871, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Mur protecteur
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 20252, 30, nil, "SPELL_CAST_SUCCESS"); -- Interception
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 18499, 30, nil, "SPELL_CAST_SUCCESS"); -- Rage Berseker
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 20230, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Represailles
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1719, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Témérité
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 23920, 10, nil, "SPELL_CAST_SUCCESS"); -- Renvoi de sort
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 469, 60, nil, "SPELL_CAST_SUCCESS"); -- Cri de commandement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 3411, 30, nil, "SPELL_CAST_SUCCESS"); -- Intervention
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 64382, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Lancer fracassant
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 55694, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Régénération enragée
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 57755, 60, nil, "SPELL_CAST_SUCCESS"); -- Lancée heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 86346, 20, nil, "SPELL_CAST_SUCCESS"); -- Frappe du colosse
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1134, 30, nil, "SPELL_CAST_SUCCESS"); -- Rage intérieure
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6544, 60, nil, "SPELL_CAST_SUCCESS"); -- Bond heroique

RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 12328, 60, nil, "SPELL_CAST_SUCCESS"); -- attaque circulaire
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 12809, 30, nil, "SPELL_CAST_SUCCESS"); -- coup traumatisant
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 12975, 3*60, nil, "SPELL_CAST_SUCCESS"); -- dernier rempart
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 12292, 3*60, nil, "SPELL_CAST_SUCCESS"); -- souhait mortel
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 85730, 2*60, nil, "SPELL_CAST_SUCCESS"); -- calme mortel
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 60970, 30, nil, "SPELL_CAST_SUCCESS"); -- fureur heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 85388, 45, nil, "SPELL_CAST_SUCCESS"); -- mise au tapis
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 46968, 20, nil, "SPELL_CAST_SUCCESS"); -- onde de choc
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 46924, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- tempête de lames

RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 12294, 4.5, nil, "SPELL_CAST_SUCCESS"); -- frappe mortelle
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 23922, 6, nil, "SPELL_CAST_SUCCESS"); -- heurt de bouclier
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 23881, 3, nil, "SPELL_CAST_SUCCESS"); -- Sanguinaire

RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 467, 45, nil, "SPELL_CAST_SUCCESS"); -- Epines
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 33878, 6, nil, "SPELL_CAST_SUCCESS"); -- Mutilation
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 50769, 10, nil, "SPELL_CAST_SUCCESS"); -- Ressuciter
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 6795, 8, nil, "SPELL_CAST_SUCCESS"); -- Grondement
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 6807, 3, nil, "SPELL_CAST_SUCCESS"); -- Mutiler
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 20484, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Renaissance
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 80964, 60, nil, "SPELL_CAST_SUCCESS"); -- coup de crane
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 80965, 60, nil, "SPELL_CAST_SUCCESS"); -- coup de crane
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5229, 60, nil, "SPELL_CAST_SUCCESS"); -- enrager
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5217, 30, nil, "SPELL_CAST_SUCCESS"); -- fureur de tigre
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 16857, 6, nil, "SPELL_CAST_SUCCESS"); -- luciole
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 1850, 3*60, nil, "SPELL_CAST_SUCCESS"); -- célérité
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 8998, 10, nil, "SPELL_CAST_SUCCESS"); -- dérobade
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 29166, 3*60, nil, "SPELL_CAST_SUCCESS"); -- innervation
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5209, 3*60, nil, "SPELL_CAST_SUCCESS"); -- rugissement provocateur
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5211, 60, nil, "SPELL_CAST_SUCCESS"); -- sonner
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 779, 6, nil, "SPELL_CAST_SUCCESS"); -- balayage
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 16689, 60, nil, "SPELL_CAST_SUCCESS"); -- emprise de la nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22842, 3*60, nil, "SPELL_CAST_SUCCESS"); -- régénération frénétique
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22812, 60, nil, "SPELL_CAST_SUCCESS"); -- ecorce
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22570, 10, nil, "SPELL_CAST_SUCCESS"); -- estropier
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 740, 8*60, nil, "SPELL_CAST_SUCCESS"); -- tranquilité
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77758, 6, nil, "SPELL_CAST_SUCCESS"); -- rosser
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77761, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ruee rugissante
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77764, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ruee rugissante
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 88751, 10, nil, "SPELL_CAST_SUCCESS"); -- champignon détonation

RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 81283, 60, nil, "SPELL_CAST_SUCCESS"); -- croissance fongique
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 16979, 15, nil, "SPELL_CAST_SUCCESS"); -- charge farouche
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 49376, 30, nil, "SPELL_CAST_SUCCESS"); -- charge farouche
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 17116, 3*60, nil, "SPELL_CAST_SUCCESS"); -- rapidité de la nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 50516, 20, nil, "SPELL_CAST_SUCCESS"); -- Typhon
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 78675, 60, nil, "SPELL_CAST_SUCCESS"); -- Rayon solaire
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 48438, 8, nil, "SPELL_CAST_SUCCESS"); -- Croissange sauvage
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 33831, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Force de la nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 61336, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Instincts de survie
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 50334, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Berserk
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 48505, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Météore

RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 78674, 15, nil, "SPELL_CAST_SUCCESS"); -- Eruption stellaire
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 18562, 15, nil, "SPELL_CAST_SUCCESS"); -- Prompte guérison

RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 2973, 6, nil, "SPELL_CAST_SUCCESS"); -- attaque du raptor
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 5116, 5, nil, "SPELL_CAST_SUCCESS"); -- trait de choc
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 6991, 10, nil, "SPELL_CAST_SUCCESS"); -- Nourrir le familier
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34026, 6, nil, "SPELL_CAST_SUCCESS"); -- Ordre de tuer
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 781, 25, nil, "SPELL_CAST_SUCCESS"); -- Désengagement
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 19503, 30, nil, "SPELL_CAST_SUCCESS"); -- Flèche de dispersion
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13795, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège d'immolation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82945, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège d'immolation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 1499, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège givrant
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 60192, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège givrant
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 5384, 30, nil, "SPELL_CAST_SUCCESS"); -- Feindre la mort
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 53351, 10, nil, "SPELL_CAST_SUCCESS"); -- Tir mortel
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 1543, 20, nil, "SPELL_CAST_SUCCESS"); -- Fusée eclairante
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13813, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège explosive
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82939, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège explosive
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13809, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège de glace
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82941, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège de glace
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 20736, 8, nil, "SPELL_CAST_SUCCESS"); -- Trait provocateur
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 3045, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Tir rapide
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34600, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège à serpent
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82948, 30, nil, "SPELL_CAST_SUCCESS"); -- Piège à serpent
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 53271, 45, nil, "SPELL_CAST_SUCCESS"); -- Appel du maitre
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34477, 30, nil, "SPELL_CAST_SUCCESS"); -- Détournement
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 19263, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Dissuasion
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 51753, 60, nil, "SPELL_CAST_SUCCESS"); -- Dissimulation

RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 19306, 5, nil, "SPELL_CAST_SUCCESS"); -- Contre attaque
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 82726, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Ferveur
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 34490, 20, nil, "SPELL_CAST_SUCCESS"); -- Flèche baillon
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 82692, 15, nil, "SPELL_CAST_SUCCESS"); -- Focalisation du feu
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 19574, 2*60, nil, "SPELL_CAST_SUCCESS"); -- courroux bestial
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 19386, 60, nil, "SPELL_CAST_SUCCESS"); -- Piqure de wyverne
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 23989, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Promptitude
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 3674, 30, nil, "SPELL_CAST_SUCCESS"); -- Flèche noire
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 53209, 10, nil, "SPELL_CAST_SUCCESS"); -- Tir de la chimère

RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 19577, 60, nil, "SPELL_CAST_SUCCESS"); -- intimidation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 53301, 6, nil, "SPELL_CAST_SUCCESS"); -- Tir explosif

RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 49576, 35, nil, "SPELL_CAST_SUCCESS"); -- Poigne de la mort
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 50977, 60, nil, "SPELL_CAST_SUCCESS"); -- Porte de la mort
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 46584, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Réanimation morbide
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47528, 10, nil, "SPELL_CAST_SUCCESS"); -- Gel de l'esprit
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47476, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Strangulation
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 43265, 30, nil, "SPELL_CAST_SUCCESS"); -- Mort de décomposition
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48792, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Robustesse glaciale
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 45529, 60, nil, "SPELL_CAST_SUCCESS"); -- Drain sanglant
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 57330, 20, nil, "SPELL_CAST_SUCCESS"); -- Cor de l'hiver
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 56222, 8, nil, "SPELL_CAST_SUCCESS"); -- Sombre ordre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48743, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Pacte mortel
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48707, 45, nil, "SPELL_CAST_SUCCESS"); -- Carapace anti magie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 61999, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Réanimation dun allié
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47568, 5*60, nil, "SPELL_CAST_SUCCESS"); -- Renforcer l'arme runique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 42650, 10*60, nil, "SPELL_CAST_SUCCESS"); -- Armée de morts
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 77575, 60, nil, "SPELL_CAST_SUCCESS"); -- Pousee de fievre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 77606, 60, nil, "SPELL_CAST_SUCCESS"); -- Sombre simulacre

RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 49039, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Changeliche
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 49222, 60, nil, "SPELL_CAST_SUCCESS"); --  Bouclier d'os
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 49016, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Frénésie impie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 51271, 60, nil, "SPELL_CAST_SUCCESS"); -- Pilier de givre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 48982, 30, nil, "SPELL_CAST_SUCCESS"); -- Connexion runique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 49203, 60, nil, "SPELL_CAST_SUCCESS"); -- Froid dévorant
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 55233, 60, nil, "SPELL_CAST_SUCCESS"); -- sang vampirique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 51052, 2*60, nil, "SPELL_CAST_SUCCESS"); -- zone anti magie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 49028, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- arme runique dansante 
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 49206, 3*60, nil, "SPELL_CAST_SUCCESS"); -- invocation d'une gargouille 

RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 74434, 45, nil, "SPELL_CAST_SUCCESS"); -- Brulure d'ame
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 79268, 30, nil, "SPELL_CAST_SUCCESS"); -- Récolte d'ames
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 6229, 30, nil, "SPELL_CAST_SUCCESS"); -- Gardien d'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 698, 2*60, nil, "SPELL_CAST_SUCCESS"); -- rituel d'invocation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 6789, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Voile mortel
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 5484, 40, nil, "SPELL_CAST_SUCCESS"); -- hurlement de terreur
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 1122, 10*60, nil, "SPELL_CAST_SUCCESS"); -- invocation infernale
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 18540, 10*60, nil, "SPELL_CAST_SUCCESS"); -- invocation garde funeste
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 50589, 30, nil, "SPELL_CAST_SUCCESS"); -- Aura d'immolation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 54785, 45, nil, "SPELL_CAST_SUCCESS"); -- Bond démoniaque
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 29858, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Brise dame
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 29893, 5*60, nil, "SPELL_CAST_SUCCESS"); -- rituel des ames
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 47897, 12, nil, "SPELL_CAST_SUCCESS"); -- ombreflamme
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 48020, 30, nil, "SPELL_CAST_SUCCESS"); -- cercle démoniquae téléportation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 77801, 2*60, nil, "SPELL_CAST_SUCCESS"); -- ame du demon

RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 17877, 15, nil, "SPELL_CAST_SUCCESS"); -- brulure de l'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Demonology", 47193, 60, nil, "SPELL_CAST_SUCCESS"); -- renforcement démoniaque
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Demonology", 71521, 12, nil, "SPELL_CAST_SUCCESS"); -- main de guldan
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 30283, 20, nil, "SPELL_CAST_SUCCESS"); -- Furie de l'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 91711, 30, nil, "SPELL_CAST_SUCCESS"); -- Gardien du néant
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Affliction", 48181, 8, nil, "SPELL_CAST_SUCCESS"); -- Hanter
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 50796, 12, nil, "SPELL_CAST_SUCCESS"); -- Trai du chaos

RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 17962, 10, nil, "SPELL_CAST_SUCCESS"); -- Conflagration


RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69041, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Barrage de fusee
RDXCD.RegisterCooldown("Troll", nil, nil, nil, 26297, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Berserk
RDXCD.RegisterCooldown("NightElf", nil, nil, nil, 58984, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Camouflage de l'ombre
RDXCD.RegisterCooldown("Scourge", nil, nil, nil, 20577, 2*60, nil, "SPELL_CAST_SUCCESS"); -- canibalisme
RDXCD.RegisterCooldown("Human", nil, nil, nil, 59752, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Chacun pour soi
RDXCD.RegisterCooldown("Tauren", nil, nil, nil, 20549, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Choc martial
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59548, 3*60, nil, "SPELL_CAST_SUCCESS"); -- Don des naaruu
RDXCD.RegisterCooldown("Dwarf", nil, nil, nil, 20594, 2*60, nil, "SPELL_CAST_SUCCESS"); -- forme de pierre
RDXCD.RegisterCooldown("Orc", nil, nil, nil, 33702, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fureur sanguinaire
RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69070, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Fusee de saut
RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69046, 30*60, nil, "SPELL_CAST_SUCCESS"); -- Hobe gobelin de bat
RDXCD.RegisterCooldown("Gnome", nil, nil, nil, 20589, 1.5*60, nil, "SPELL_CAST_SUCCESS"); -- Maitre de l'evasion
RDXCD.RegisterCooldown("Worgen", nil, nil, nil, 68992, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Sombre course
RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 80483, 2*60, nil, "SPELL_CAST_SUCCESS"); -- Torrent arcanique
RDXCD.RegisterCooldown("Scourge", nil, nil, nil, 7744, 2*60, nil, "SPELL_CAST_SUCCESS"); -- volonte reprouve

-- métier herboriste

--ITEM
RDXCD.RegisterCooldown("Item", nil, nil, nil, 42292, 2*60, nil, "SPELL_CAST_SUCCESS"); -- PVP trinket
RDXCD.RegisterCooldown("Item", nil, nil, nil, 74241, 45, nil, "SPELL_AURA_APPLIED");  -- Power Torrent
RDXCD.RegisterCooldown("Item", nil, nil, nil, 89091, 45, nil, "SPELL_AURA_APPLIED");  -- DMC: Volcano
--end, nil, "SPELL_CAST_SUCCESS");
