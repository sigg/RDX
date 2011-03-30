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
--RDXCD.RegisterCooldown(race, class, talent, spellid, duration, group);




-- PRIEST SPELL
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 17, 3); --  Mot de pouvoir : Bouclier
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 8092, 8); -- Attaque mentale
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 8122, 30); -- Cri psychique
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 14914, 10); -- Flammes sacrées
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 88684, 15); -- Mot sacré : Sérénité
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 586, 30); -- Oubli
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 32379, 10); -- Mot de l'ombre : Mort
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 6346, 3*60); -- Gardien de peur
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 64901, 6*60); -- Hymne à l'espoir
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 34433, 5*60); -- Ombrefiel
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 33076, 10); -- Prière de guérison
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 64843, 8*60); -- Hymne divin
RDXCD.RegisterCooldown(nil, nil, "PRIEST", nil, 73325, 1.5*60); -- Saut de foi

-- PRIEST TALENT
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 89485, 45); -- Focalisation intérieure
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 10060, 2*60); -- Infusion de puissance
RDXCD.RegisterCooldown(nil, nil, "PRIEST","Discipline", 33206, 3*60); -- Suppression de la douleur
RDXCD.RegisterCooldown(nil, nil, "PRIEST","Holy", 47755, 12); -- Extase
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 19236, 2*60); -- Prière du désespoir
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 724, 3*60); -- Puits de lumière, see totem fire lol
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 14751, 30); -- Chakra
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 34861, 10); -- Cercle de soins
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 47788, 3*60); -- Esprit gardien
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 62618, 2*60); -- Mot de pouvoir : Barrière
--RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 15473, 1.5); -- Forme d'Ombre
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 15487, 45); -- Silence
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 64044, 2*60); -- Horreur psychique
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Shadow", 47585, 2*60); -- Dispersion


-- PRIEST SPECIALISATION
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Holy", 88625, 30); -- Mot sacré : Châtier
RDXCD.RegisterCooldown(nil, nil, "PRIEST", "Discipline", 47540, 12); -- Pénitence

-- PALADIN SPELL
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 35395, 4.5); --  Frappe du croise
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 20271, 8); --  Jugement
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 62124, 8); --  Main de rétribution
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 853, 60); --  Marteau de la justice
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 633, 10*60); --  Imposition des mains
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1022, 5*60); --  Main de protection
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 26573, 30); --  Consécration
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 2812, 15); --  Colère divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 498, 60); --  Protection divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 31789, 8); --  Défense vertueuse
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 54428, 2*60); --  Supplique divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 24275, 6); --  Marteau de courroux
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 642, 5*60); --  Bouclier divin
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1044, 25); --  Main de liberté
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 96231, 10); --  Réprimandes
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 1038, 2*60); --  Main de salut
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 31884, 3*60); --  Corroux vengeur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 6940, 2*60); --  Main de sacrifice
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 82327, 60); --  Radiance sacrée
RDXCD.RegisterCooldown(nil, nil, "PALADIN", nil, 86150, 5*60); --  Gardien des anciens rois

RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 31842, 3*60); -- Faveur divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 53595, 4.5); -- Marteau du vertueux
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 53385, 4.5); -- Tempête divine
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 85285, 30); -- Bouclier saint
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 70940, 2*60); -- Gardien divin
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 31821, 2*60); -- Maitrise des auras
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 20066, 60); -- Repentir
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 31850, 3*60); -- Ardent defenseur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Retribution", 85696, 2*60); -- Fanatisme

RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Protection", 31935, 15); -- Bouclier du vengeur
RDXCD.RegisterCooldown(nil, nil, "PALADIN", "Holy", 20473, 6); -- horion sacre

RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1784, 10); -- Camouflage
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 5277, 3*60); -- Evasion
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1766, 10); -- Coup de pied
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 2983, 60); -- sprint
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1776, 10); -- Suriner
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1856, 3*60); -- Disparition
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1725, 30); -- Distraction
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 408, 20); -- Aiguillon perfide
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 2094, 3*60); -- Cecité
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 51722, 60); -- Démantèlement
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 1966, 10); -- Feinte
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 31224, 1.5*60); -- Cape d'ombre
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 57934, 30); -- Ficelle du métier
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 74001, 2*60); -- Promptitude au combat
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 73981, 1*60); -- Rediriger
RDXCD.RegisterCooldown(nil, nil, "ROGUE", nil, 76577, 3*60); -- bombe fumigène

RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Assassination", 14177, 2*60); -- Sang froid
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 14183, 20); -- Préméditation
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 13750, 3*60); -- Poussée d'adrenaline
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 14185, 5*60); -- Préparation
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 51713, 60); -- Danse de l'ombre
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 51690, 2*60); -- Série meurtrière
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Assassination", 79140, 2*60); -- Vendetta

RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Combat", 13877, 10); -- Déluge de lames
RDXCD.RegisterCooldown(nil, nil, "ROGUE", "Subtlety", 36554, 24); -- Pas de l'ombre


RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 2136, 8); -- Trait de feu
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 122, 25); -- Nova de givre
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 2139, 24); -- contresort
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 12051, 4*60); -- evocation
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 1953, 15); -- transfert
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 120, 10); -- cone de froid
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 45438, 5*60); -- bloc de glace
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 543, 30); -- gardien du mage
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 1463, 12); -- bouclier de mana
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 55342, 3*60); -- image miroir
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 66, 3*60); -- invisibilité
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 82731, 60); -- Orbe enflammé
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 82676, 2*60); -- Anneau de givre
RDXCD.RegisterCooldown(nil, nil, "MAGE", nil, 80353, 5*60); -- distorsion temporelle

RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 12043, 2*60); -- présence spirituelle
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 11113, 15); -- vague explosive
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 12472, 3*60); -- veines glaciales
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 11129, 2*60); -- combustion
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 11958, 8*60); -- morsure du froid
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 11426, 30); -- barrière de glace
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Fire", 31661, 20); -- souffle du dragon
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 44572, 30); -- congélation
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 12042, 2*60); -- pouvoir des arcanes

RDXCD.RegisterCooldown(nil, nil, "MAGE", "Arcane", 44425, 4); -- Barrage des arcanes
RDXCD.RegisterCooldown(nil, nil, "MAGE", "Frost", 31687, 3*60); -- Invocation d'un élémentaire d'eau


RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73899, 8); -- Frappe primordiale
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8042, 6); -- Horion de terre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8050, 6); -- Horion de flammes
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 57994, 6); -- Cisaille de vent
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2484, 15); -- Totem de lien terrestre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8056, 6); -- Horion de givre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 1535, 10); -- Nova de feu
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 421, 3); -- Chaine d'éclair
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 20608, 30*60); -- Réincarnation
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 556, 15*60); -- Rappel astral
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51505, 8); -- Explosion de lave
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8177, 15); -- Totem de glèbe
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 8143, 60); -- Totem de seisme
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2062, 10*60); -- Totem d'elementair de terre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 5730, 20); -- Totem de griffes de pierre
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2894, 10*60); -- Totem d'élémentaire de feu
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 32182, 5*60); -- Heroisme
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 2825, 5*60); -- Furie sanguinaire
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 51514, 45); -- Maléfice
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73680, 15); -- Déchainement des éléments
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 73920, 10); -- Pluie guérisseuse
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", nil, 79206, 2*60); -- Grace du marcheur des esprits

RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 17364, 8); -- frappe tempête
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Restoration", 16188, 2*60); -- Rapidité de la nature
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Elemental", 16166, 3*60); -- Maitrise élémentaire
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 30823, 60); -- Rage du shaman
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 51533, 2*60); -- esprit farouche
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Restoration", 61295, 6); -- remous

RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Enhancement", 60103, 10); -- Fouet de lave
RDXCD.RegisterCooldown(nil, nil, "SHAMAN", "Elemental", 51490, 45); -- orage

RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 88161, 3); -- Frappe
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 100, 15); -- Charge
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6343, 6); -- Coup de tonnerre
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 355, 8); -- Provocation
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 78, 3); -- Frappe heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 72, 12); -- Coup de bouclier
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6673, 60); -- Cri de guerre
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 845, 3); -- Enchainement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 2565, 60); -- Maitrise du blocage
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 676, 60); -- Désarmement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1680, 10); -- Tourbillon
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6552, 10); -- Volee de coup
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6572, 5); -- Revanche
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 5246, 2*60); -- Cri d'intimidation
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1161, 3*60); -- Cri de défi
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 871, 5*60); -- Mur protecteur
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 20252, 30); -- Interception
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 18499, 30); -- Rage Berseker
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 20230, 5*60); -- Represailles
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1719, 5*60); -- Témérité
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 23920, 10); -- Renvoi de sort
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 469, 60); -- Cri de commandement
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 3411, 30); -- Intervention
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 64382, 5*60); -- Lancer fracassant
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 55694, 3*60); -- Régénération enragée
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 57755, 60); -- Lancée heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 86346, 20); -- Frappe du colosse
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 1134, 30); -- Rage intérieure
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", nil, 6544, 60); -- Bond heroique

RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 12328, 60); -- attaque circulaire
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 12809, 30); -- coup traumatisant
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 12975, 3*60); -- dernier rempart
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 12292, 3*60); -- souhait mortel
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 85730, 2*60); -- calme mortel
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 60970, 30); -- fureur heroique
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 85388, 45); -- mise au tapis
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 46968, 20); -- onde de choc
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 46924, 1.5*60); -- tempête de lames

RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Arms", 12294, 4.5); -- frappe mortelle
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Protection", 23922, 6); -- heurt de bouclier
RDXCD.RegisterCooldown(nil, nil, "WARRIOR", "Fury", 23881, 3); -- Sanguinaire

RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 467, 45); -- Epines
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 33878, 6); -- Mutilation
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 50769, 10); -- Ressuciter
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 6795, 8); -- Grondement
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 6807, 3); -- Mutiler
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 20484, 10*60); -- Renaissance
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 80964, 60); -- coup de crane
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 80965, 60); -- coup de crane
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5229, 60); -- enrager
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5217, 30); -- fureur de tigre
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 16857, 6); -- luciole
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 1850, 3*60); -- célérité
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 8998, 10); -- dérobade
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 29166, 3*60); -- innervation
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5209, 3*60); -- rugissement provocateur
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 5211, 60); -- sonner
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 779, 6); -- balayage
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 16689, 60); -- emprise de la nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22842, 3*60); -- régénération frénétique
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22812, 60); -- ecorce
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 22570, 10); -- estropier
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 740, 8*60); -- tranquilité
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77758, 6); -- rosser
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77761, 2*60); -- ruee rugissante
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 77764, 2*60); -- ruee rugissante
RDXCD.RegisterCooldown(nil, nil, "DRUID", nil, 88751, 10); -- champignon détonation

RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 81283, 60); -- croissance fongique
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 16979, 15); -- charge farouche
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 49376, 30); -- charge farouche
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 17116, 3*60); -- rapidité de la nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 50516, 20); -- Typhon
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 78675, 60); -- Rayon solaire
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 48438, 8); -- Croissange sauvage
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 33831, 3*60); -- Force de la nature
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 61336, 3*60); -- Instincts de survie
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Feral Combat", 50334, 3*60); -- Berserk
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 48505, 1.5*60); -- Météore

RDXCD.RegisterCooldown(nil, nil, "DRUID", "Balance", 78674, 15); -- Eruption stellaire
RDXCD.RegisterCooldown(nil, nil, "DRUID", "Restoration", 18562, 15); -- Prompte guérison

RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 2973, 6); -- attaque du raptor
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 5116, 5); -- trait de choc
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 6991, 10); -- Nourrir le familier
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34026, 6); -- Ordre de tuer
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 781, 25); -- Désengagement
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 19503, 30); -- Flèche de dispersion
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13795, 30); -- Piège d'immolation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82945, 30); -- Piège d'immolation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 1499, 30); -- Piège givrant
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 60192, 30); -- Piège givrant
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 5384, 30); -- Feindre la mort
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 53351, 10); -- Tir mortel
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 1543, 20); -- Fusée eclairante
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13813, 30); -- Piège explosive
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82939, 30); -- Piège explosive
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 13809, 30); -- Piège de glace
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82941, 30); -- Piège de glace
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 20736, 8); -- Trait provocateur
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 3045, 5*60); -- Tir rapide
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34600, 30); -- Piège à serpent
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 82948, 30); -- Piège à serpent
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 53271, 45); -- Appel du maitre
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 34477, 30); -- Détournement
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 19263, 2*60); -- Dissuasion
RDXCD.RegisterCooldown(nil, nil, "HUNTER", nil, 51753, 60); -- Dissimulation

RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 19306, 5); -- Contre attaque
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 82726, 2*60); -- Ferveur
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 34490, 20); -- Flèche baillon
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 82692, 15); -- Focalisation du feu
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 19574, 2*60); -- courroux bestial
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 19386, 60); -- Piqure de wyverne
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 23989, 3*60); -- Promptitude
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 3674, 30); -- Flèche noire
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Marksmanship", 53209, 10); -- Tir de la chimère

RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Beast Mastery", 19577, 60); -- intimidation
RDXCD.RegisterCooldown(nil, nil, "HUNTER", "Survival", 53301, 6); -- Tir explosif

RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 49576, 35); -- Poigne de la mort
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 50977, 60); -- Porte de la mort
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 46584, 3*60); -- Réanimation morbide
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47528, 10); -- Gel de l'esprit
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47476, 2*60); -- Strangulation
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 43265, 30); -- Mort de décomposition
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48792, 3*60); -- Robustesse glaciale
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 45529, 60); -- Drain sanglant
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 57330, 20); -- Cor de l'hiver
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 56222, 8); -- Sombre ordre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48743, 2*60); -- Pacte mortel
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 48707, 45); -- Carapace anti magie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 61999, 10*60); -- Réanimation dun allié
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 47568, 5*60); -- Renforcer l'arme runique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 42650, 10*60); -- Armée de morts
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 77575, 60); -- Pousee de fievre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", nil, 77606, 60); -- Sombre simulacre

RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 49039, 2*60); -- Changeliche
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 49222, 60); --  Bouclier d'os
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 49016, 3*60); -- Frénésie impie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 51271, 60); -- Pilier de givre
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 48982, 30); -- Connexion runique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Frost", 49203, 60); -- Froid dévorant
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 55233, 60); -- sang vampirique
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 51052, 2*60); -- zone anti magie
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Blood", 49028, 1.5*60); -- arme runique dansante 
RDXCD.RegisterCooldown(nil, nil, "DEATHKNIGHT", "Unholy", 49206, 3*60); -- invocation d'une gargouille 

RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 74434, 45); -- Brulure d'ame
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 79268, 30); -- Récolte d'ames
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 6229, 30); -- Gardien d'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 698, 2*60); -- rituel d'invocation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 6789, 2*60); -- Voile mortel
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 5484, 40); -- hurlement de terreur
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 1122, 10*60); -- invocation infernale
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 18540, 10*60); -- invocation garde funeste
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 50589, 30); -- Aura d'immolation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 54785, 45); -- Bond démoniaque
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 29858, 2*60); -- Brise dame
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 29893, 5*60); -- rituel des ames
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 47897, 12); -- ombreflamme
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 48020, 30); -- cercle démoniquae téléportation
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", nil, 77801, 2*60); -- ame du demon

RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 17877, 15); -- brulure de l'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Demonology", 47193, 60); -- renforcement démoniaque
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Demonology", 71521, 12); -- main de guldan
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 30283, 20); -- Furie de l'ombre
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 91711, 30); -- Gardien du néant
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Affliction", 48181, 8); -- Hanter
RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 50796, 12); -- Trai du chaos

RDXCD.RegisterCooldown(nil, nil, "WARLOCK", "Destruction", 17962, 10); -- Conflagration


RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69041, 2*60); -- Barrage de fusee
RDXCD.RegisterCooldown("Troll", nil, nil, nil, 26297, 3*60); -- Berserk
RDXCD.RegisterCooldown("NightElf", nil, nil, nil, 58984, 2*60); -- Camouflage de l'ombre
RDXCD.RegisterCooldown("Scourge", nil, nil, nil, 20577, 2*60); -- canibalisme
RDXCD.RegisterCooldown("Human", nil, nil, nil, 59752, 2*60); -- Chacun pour soi
RDXCD.RegisterCooldown("Tauren", nil, nil, nil, 20549, 2*60); -- Choc martial
RDXCD.RegisterCooldown("Draenei", nil, nil, nil, 59548, 3*60); -- Don des naaruu
RDXCD.RegisterCooldown("Dwarf", nil, nil, nil, 20594, 2*60); -- forme de pierre
RDXCD.RegisterCooldown("Orc", nil, nil, nil, 33702, 2*60); -- Fureur sanguinaire
RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69070, 2*60); -- Fusee de saut
RDXCD.RegisterCooldown("Goblin", nil, nil, nil, 69046, 30*60); -- Hobe gobelin de bat
RDXCD.RegisterCooldown("Gnome", nil, nil, nil, 20589, 1.5*60); -- Maitre de l'evasion
RDXCD.RegisterCooldown("Worgen", nil, nil, nil, 68992, 2*60); -- Sombre course
RDXCD.RegisterCooldown("BloodElf", nil, nil, nil, 80483, 2*60); -- Torrent arcanique
RDXCD.RegisterCooldown("Scourge", nil, nil, nil, 7744, 2*60); -- volonte reprouve

-- métier herboriste


--ITEM
RDXCD.RegisterCooldown("Item", nil, nil, nil, 42292, 2*60); -- PVP trinket

--end);
