-- Metadata_*.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- CLASS METADATA FILE
--
-- The metadata format should be clear from examining the contents below. Note
-- that this file will only be loaded if the player is of the specified class.
-- 
local _,class = UnitClass("player");
if class == "PALADIN" then
	RDXEvents:Bind("SPELLS_BUILD_CATEGORIES", nil, function()
		RDXSS.CategorizeClass(4987, "CURE_POISON");
		RDXSS.CategorizeClass(4987, "CURE_DISEASE");
	end);
end

VFLUI.RegisterAbilIcon("Paladin", "Greater Blessing of Wisdom", "Spell_Holy_GreaterBlessingofWisdom");
VFLUI.RegisterAbilIcon("Paladin", "Greater Blessing of Kings", "Spell_Holy_GreaterBlessingofKings");
VFLUI.RegisterAbilIcon("Paladin", "Blessing of Kings", "Spell_Magic_MageArmor");
VFLUI.RegisterAbilIcon("Paladin", "Blessing of Wisdom", "Spell_Holy_SealOfWisdom");