-- Core.lua
-- OpenRDX
-- Sigg

-- A cooldown database is created using the registererCoodldown(spellid, duration, group) function
--  -> the duration is not really accurate, because some duration could change with talent + glyph
-- A local engine will store real cooldown per character (duration + timeleft)
-- this local engine is sync with all members of the raid


RDXCD = RegisterVFLModule({
	name = "Cooldown";
	title = VFLI.i18n("Cooldown");
	description = "Cooldown";
	version = {1,0,0};
	parent = RDX;
});

-- All Cooldowns
local cd = {};
function RDXCD.GetCDs() return cd; end

-- no talent, no boss
local cdc = {};
function RDXCD.GetCDCs() return cdc; end

-- Talent Cooldowns only
local cdt = {};
function RDXCD.GetCDTs() return cdt; end

-- Talent Cooldowns only
local cdb = {};
function RDXCD.GetCDBs() return cdb; end

-- Cooldown group registry
local cdg = {};
function RDXCD.GetCDGs() return cdg; end

------------------------------------------
-- Cooldown registration
------------------------------------------

-- RACE  Worgen Draenei Dwarf Gnome Human NightElf Goblin BloodElf Orc Tauren Troll Scourge, Boss, Item
-- CLASS PRIEST DRUID PALADIN SHAMAN WARRIOR WARLOCK MAGE ROGUE HUNTER DEATHKNIGHT
-- text : race:class:talentindex:spellname

function RDXCD.RegisterCooldown(race, boss, class, talent, spellid, duration, group)
	if not spellid then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Attempt to register an anonymous omni cooldown.")); return; end
	if cd[spellid] then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Attempt to register duplicate object type ") .. spellid .. "."); return; end
	local spellname, _, icon = GetSpellInfo(spellid);
	if not spellname then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : unknown spellid ") .. spellid .. "."); return; end
	local text = "";
	if race then text = text .. race .. ":"; end
	if boss then text = text .. boss .. ":"; end
	if class then text = text .. class .. ":"; end
	if talent then text = text .. talent .. ":"; end
	text = text .. spellname;
	local cdtemp = {
		text = text;
		race = race;
		class = class;
		talent = talent;
		spellid = spellid;
		spellname = spellname;
		duration = duration;
		icon = icon;
		group = group;
	};
	cd[spellid] = cdtemp;
	if boss then cdb[spellid] = cdtemp; end
	if talent then cdt[spellid] = cdtemp; end
	if not talent and not boss then cdc[spellid] = cdtemp; end
	return true;
end

function RDXCD.GetCooldownInfoBySpellid(spellid)
	if not spellid then return nil; end
	return cd[spellid];
end

function RDXCD.GetCooldownInfoByText(text)
	if not text then return nil; end
	local spellid = nil;
	for k,v in pairs(cd) do
		if v.text == text then spellid = k; end
	end
	return spellid;
end

function RDXCD.GetGroupCooldowns(group)
	if not group then return nil; end
	return cdg[group];
end


--- Reproduce an cooldown tooltip from an entry
local cdtmp;
function RDXCD.ShowCooldownTooltip(spellid, frame, anchor)
	cdtmp = cd[spellid];
	if cdtmp then
		GameTooltip:SetOwner(frame, "ANCHOR_NONE");
		GameTooltip:SetPoint("TOPLEFT", frame, anchor, 0, 20);
		GameTooltip:ClearLines();
		GameTooltip:AddDoubleLine(cdtmp.text, RDXU.CooldownDB[spellid] or cdtmp.duration);
		GameTooltip:Show();
	end
end


