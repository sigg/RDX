-- Metadata_Warlock.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- CLASS METADATA FILE
--
-- The metadata format should be clear from examining the contents below. Note
-- that this file will only be loaded if the player is of the specified class.
-- 
-- Metadata for the Warlock class's spells.
local _,class = UnitClass("player");
if class == "WARLOCK" then
	RDXEvents:Bind("SPELLS_BUILD_CLASSES", nil, function()
		RDXSS.ClassifySpell(VFLI.i18n("Detect Lesser Invisibility()"), "Detect Invisibility");
		RDXSS.ClassifySpell(VFLI.i18n("Detect Invisibility()"), "Detect Invisibility");
		RDXSS.ClassifySpell(VFLI.i18n("Detect Greater Invisibility()"), "Detect Invisibility");
	end);

	--RDXEvents:Bind("SPELLS_BUILD_CATEGORIES", nil, function()
	--	RDXSS.CategorizeClass(VFLI.i18n("Shadow Bolt"), "DIRECT");
	--	RDXSS.CategorizeClass(VFLI.i18n("Shadow Bolt"), "DAMAGE");
	--end);
end
