-- BlizzardElement.lua
-- OpenRDX
-- Sigg / rashgarroth EU

VFLUI.CreateFramePool("BlizzardElement", 
	function(pool, x) -- on released
		if (not x) then return; end
		x:Hide(); x:SetParent(nil); x:ClearAllPoints();
	end,
	function(_, key) -- on fallback
		return _G[key];
	end, 
	function(_, f) -- on acquired
		f:ClearAllPoints();
	end,
"key");

----------------------------------------------------------------------
-- bags bar
----------------------------------------------------------------------

RDX.BlizzardBagsButtons = {
	"KeyRingButton",
	"CharacterBag3Slot",
	"CharacterBag2Slot",
	"CharacterBag1Slot",
	"CharacterBag0Slot",
	"MainMenuBarBackpackButton"
};

----------------------------------------------------------------------
-- MicroMenu bar
----------------------------------------------------------------------

RDX.BlizzardMicroButtons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"PVPMicroButton",
	"LFDMicroButton",
	"MainMenuMicroButton",
	"HelpMicroButton"
};
