------------- Register some common Lua routines to see how they're doing
VFLP.RegisterCategory("Lua Core");
VFLP.RegisterFunc("Lua Core", "string.find", string.find, nil);
VFLP.RegisterFunc("Lua Core", "string.match", string.match, nil);
VFLP.RegisterFunc("Lua Core", "string.gmatch", string.gmatch, nil);
VFLP.RegisterFunc("Lua Core", "string.format", string.format, nil);
VFLP.RegisterFunc("Lua Core", "string.lower", string.lower, nil);
VFLP.RegisterFunc("Lua Core", "table.sort", table.sort, nil);
VFLP.RegisterFunc("Lua Core", "table.insert", table.insert, nil);
VFLP.RegisterFunc("Lua Core", "table.remove", table.remove, nil);

--VFLP.RegisterEventCategory("WoWEvents");
--VFLP.RegisterEvent("WoWEvents", "UNIT_AURA", "UNIT_AURA");
--VFLP.RegisterEvent("WoWEvents", "COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED");


--VFLP.RegisterCategory("WoWRDX Frame");
--VFLP.RegisterCategory("Blizzard Frame");

--VFLP.RegisterFrame("Blizzard Frame", "WorldFrame", WorldFrame, true);
--VFLP.RegisterFrame("Blizzard Frame", "PlayerFrame", PlayerFrame, true);
--[[VFLP.RegisterFrame("Blizzard Frame", "RuneFrame", RuneFrame, true);

VFLP.RegisterFrame("Blizzard Frame", "BuffFrame", BuffFrame, true);
VFLP.RegisterFrame("Blizzard Frame", "TemporaryEnchantFrame", TemporaryEnchantFrame, true);
VFLP.RegisterFrame("Blizzard Frame", "ChannelFrame", ChannelFrame, true);
--VFLP.RegisterFrame("Blizzard Frame", "CombatLogButtons", CombatLogButtons, true);

VFLP.RegisterFrame("Blizzard Frame", "TargetFrame", TargetFrame, true);
VFLP.RegisterFrame("Blizzard Frame", "PetFrame", PetFrame, true);
VFLP.RegisterFrame("Blizzard Frame", "FocusFrame", FocusFrame, true);
VFLP.RegisterFrame("Blizzard Frame", "PartyMemberFrame1", PartyMemberFrame1, true);
VFLP.RegisterFrame("Blizzard Frame", "PartyMemberFrame2", PartyMemberFrame2, true);
VFLP.RegisterFrame("Blizzard Frame", "PartyMemberFrame3", PartyMemberFrame3, true);
VFLP.RegisterFrame("Blizzard Frame", "PartyMemberFrame4", PartyMemberFrame4, true);
]]


--VFLP.RegisterCategory("Blizzard");
--[[
--VFLP.RegisterFunc("Blizzard", "CheckInteractDistance", CheckInteractDistance, true);
--VFLP.RegisterFunc("Blizzard", "SpellCanTargetUnit", SpellCanTargetUnit, true);
--VFLP.RegisterFunc("Blizzard", "GetUnitPitch", GetUnitPitch, true);
--VFLP.RegisterFunc("Blizzard", "GetUnitSpeed", GetUnitSpeed, true);

--VFLP.RegisterFunc("Blizzard", "UnitAffectingCombat", UnitAffectingCombat, true);
--VFLP.RegisterFunc("Blizzard", "UnitArmor", UnitArmor, true);
--VFLP.RegisterFunc("Blizzard", "UnitAttackBothHands", UnitAttackBothHands, true);
--VFLP.RegisterFunc("Blizzard", "UnitAttackPower", UnitAttackPower, true);
--VFLP.RegisterFunc("Blizzard", "UnitAttackSpeed", UnitAttackSpeed, true);
VFLP.RegisterFunc("Blizzard", "UnitAura", UnitAura, true);
VFLP.RegisterFunc("Blizzard", "UnitBuff", UnitBuff, true);
--VFLP.RegisterFunc("Blizzard", "UnitCanAssist", UnitCanAssist, true);
--VFLP.RegisterFunc("Blizzard", "UnitCanAttack", UnitCanAttack, true);
--VFLP.RegisterFunc("Blizzard", "UnitCanCooperate", UnitCanCooperate, true);
--VFLP.RegisterFunc("Blizzard", "UnitCharacterPoints", UnitCharacterPoints, true);
VFLP.RegisterFunc("Blizzard", "UnitClass", UnitClass, true);
--VFLP.RegisterFunc("Blizzard", "UnitClassification", UnitClassification, true);
--VFLP.RegisterFunc("Blizzard", "UnitCreatureFamily", UnitCreatureFamily, true);
--VFLP.RegisterFunc("Blizzard", "UnitCreatureType", UnitCreatureType, true);
--VFLP.RegisterFunc("Blizzard", "UnitDamage", UnitDamage, true);
VFLP.RegisterFunc("Blizzard", "UnitDebuff", UnitDebuff, true);
--VFLP.RegisterFunc("Blizzard", "UnitDefense", UnitDefense, true);
VFLP.RegisterFunc("Blizzard", "UnitDetailedThreatSituation", UnitDetailedThreatSituation, true);
VFLP.RegisterFunc("Blizzard", "UnitExists", UnitExists, true);
--VFLP.RegisterFunc("Blizzard", "UnitFactionGroup", UnitFactionGroup, true);
VFLP.RegisterFunc("Blizzard", "UnitGUID", UnitGUID, true);
--VFLP.RegisterFunc("Blizzard", "UnitHasRelicSlot", UnitHasRelicSlot, true);
VFLP.RegisterFunc("Blizzard", "UnitHealth", UnitHealth, true);
VFLP.RegisterFunc("Blizzard", "UnitHealthMax", UnitHealthMax, true);
--VFLP.RegisterFunc("Blizzard", "UnitInParty", UnitInParty, true);
--VFLP.RegisterFunc("Blizzard", "UnitInRaid", UnitInRaid, true);
VFLP.RegisterFunc("Blizzard", "UnitInRange", UnitInRange, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsAFK", UnitIsAFK, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsCharmed", UnitIsCharmed, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsConnected", UnitIsConnected, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsCorpse", UnitIsCorpse, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsDead", UnitIsDead, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsDeadOrGhost", UnitIsDeadOrGhost, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsDND", UnitIsDND, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsEnemy", UnitIsEnemy, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsFeignDeath", UnitIsFeignDeath, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsFriend", UnitIsFriend, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsGhost", UnitIsGhost, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsPVP", UnitIsPVP, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsPVPFreeForAll", UnitIsPVPFreeForAll, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsPartyLeader", UnitIsPartyLeader, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsPlayer", UnitIsPlayer, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsPlusMob", UnitIsPlusMob, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsTapped", UnitIsTapped, true);
--VFLP.RegisterFunc("Blizzard", "UnitIsTappedByPlayer", UnitIsTappedByPlayer, true);
VFLP.RegisterFunc("Blizzard", "UnitIsTrivial", UnitIsTrivial, true);
VFLP.RegisterFunc("Blizzard", "UnitIsUnit", UnitIsUnit, true);
VFLP.RegisterFunc("Blizzard", "UnitIsVisible", UnitIsVisible, true);
--VFLP.RegisterFunc("Blizzard", "UnitLevel", UnitLevel, true);
VFLP.RegisterFunc("Blizzard", "UnitName", UnitName, true);
--VFLP.RegisterFunc("Blizzard", "UnitOnTaxi", UnitOnTaxi, true);
--VFLP.RegisterFunc("Blizzard", "UnitPlayerControlled", UnitPlayerControlled, true);
--VFLP.RegisterFunc("Blizzard", "UnitPlayerOrPetInParty", UnitPlayerOrPetInParty, true);
--VFLP.RegisterFunc("Blizzard", "UnitPlayerOrPetInRaid", UnitPlayerOrPetInRaid, true);
--VFLP.RegisterFunc("Blizzard", "UnitPVPName", UnitPVPName, true);
--VFLP.RegisterFunc("Blizzard", "UnitPVPRank", UnitPVPRank, true);
VFLP.RegisterFunc("Blizzard", "UnitPower", UnitPower, true);
VFLP.RegisterFunc("Blizzard", "UnitPowerMax", UnitPowerMax, true);
VFLP.RegisterFunc("Blizzard", "UnitPowerType", UnitPowerType, true);
--VFLP.RegisterFunc("Blizzard", "UnitRace", UnitRace, true);
--VFLP.RegisterFunc("Blizzard", "UnitRangedAttack", UnitRangedAttack, true);
--VFLP.RegisterFunc("Blizzard", "UnitRangedAttackPower", UnitRangedAttackPower, true);
--VFLP.RegisterFunc("Blizzard", "UnitRangedDamage", UnitRangedDamage, true);
--VFLP.RegisterFunc("Blizzard", "UnitReaction", UnitReaction, true);
--VFLP.RegisterFunc("Blizzard", "UnitResistance", UnitResistance, true);
--VFLP.RegisterFunc("Blizzard", "UnitSex", UnitSex, true);
--VFLP.RegisterFunc("Blizzard", "UnitStat", UnitStat, true);
VFLP.RegisterFunc("Blizzard", "UnitThreatSituation", UnitThreatSituation, true);
--VFLP.RegisterFunc("Blizzard", "UnitXP", UnitXP, true);
--VFLP.RegisterFunc("Blizzard", "UnitXPMax", UnitXPMax, true);
]]


