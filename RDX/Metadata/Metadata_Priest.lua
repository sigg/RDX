-- Metadata_Priest.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- CLASS METADATA FILE
--
-- The metadata format should be clear from examining the contents below. Note
-- that this file will only be loaded if the player is of the specified class.
-- 
local _,class = UnitClass("player");
if class == "PRIEST" then
	RDXEvents:Bind("SPELLS_BUILD_CATEGORIES", nil, function()
		RDXSS.CategorizeClass(527, "DIRECT");
		RDXSS.CategorizeClass(527, "CURE_MAGIC");
		RDXSS.CategorizeClass(528, "DIRECT");
		RDXSS.CategorizeClass(528, "CURE_DISEASE");
	end);
end

VFLUI.RegisterAbilIcon("Priest", "Prayer of Fortitude", "Spell_Holy_PrayerOfFortitude");
VFLUI.RegisterAbilIcon("Priest", "Shadow Protection", "Spell_Holy_PrayerofShadowProtection");

