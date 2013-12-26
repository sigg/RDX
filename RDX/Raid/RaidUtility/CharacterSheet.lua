-----------------------------------------------
-- RESPONDER
-----------------------------------------------
local function ComposeStatRating(name, chance, rating, ratingBonus)
	return name .. ": " .. string.format("%0.2f%%", chance) .. " (" .. string.format("%0.2f%%", ratingBonus) .. " > rating " .. rating .. ")";
end

-- Compose the character sheet.
local function MakeCharSheet()
	local ret = {};

	-- Talent info
	-- base talent info
	local z1={};
	local z2={};
	local x1, x2, x3, x4, x5;

	local _, specName1 = GetSpecializationInfo(GetSpecialization(false, false, 1));
	local _, specName2 = GetSpecializationInfo(GetSpecialization(false, false, 2));
	
	table.insert(ret, "|cFFAAAAAA " ..specName1.. "/" ..specName2.. "|r");
	z1, z2 = nil;
	-- Per tree talent info
	--for tab = 1,GetNumSpecializations(false, true) do
	--	local tabName, _, tabPS = GetTalentTabInfo(tab);
	--	table.insert(ret, "|cFFFFFF00" .. tabName .. "|r |cFFAAAAAA(" .. tabPS .. ")|r");
	--	for tal = 1,GetNumTalents(tab) do
	--		local talName, _, _, _, n, maxn = GetTalentInfo(tab, tal);
	--		if n and (n>0) then
	--			table.insert(ret, "    " .. talName .. " |cFFAAAAAA(" .. n .. "/" .. maxn .. ")|r");
	--		end
	--	end
	--end

	-- Melee defensive info
	table.insert(ret, "|cFF888844Defenses|r");
	-- Armor
	_, x1 = UnitArmor("player");
	x2 = PaperDollFrame_GetArmorReduction(x1, UnitLevel("player"));
	table.insert(ret, "  Armor: " .. x1 .. " (" .. string.format("%0.2f%%", x2) .. " DR)");
	-- Def
	x1, x2 = UnitDefense("player"); 
	--x3 = GetDodgeBlockParryChanceFromDefense(); 
	x4 = GetCombatRating(CR_DEFENSE_SKILL); x5 = GetCombatRatingBonus(CR_DEFENSE_SKILL);
	table.insert(ret, "  Defense: " .. (x1+x2));
	table.insert(ret, "    Rating: " .. x4 .. " (+" .. x5 .. " def)");
	--table.insert(ret, "    Bonus: +" .. string.format("%0.2f", x3) .. "% blk/dg/pry");
	-- Dodge/Parry/Block
	table.insert(ret, "  " .. ComposeStatRating(VFLI.i18n("Dodge"), GetDodgeChance(), GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE)));
	table.insert(ret, "  " .. ComposeStatRating(VFLI.i18n("Parry"), GetParryChance(), GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY)));
	table.insert(ret, "  " .. ComposeStatRating(VFLI.i18n("Block"), GetBlockChance(), GetCombatRating(CR_BLOCK), GetCombatRatingBonus(CR_BLOCK)));
	-- Resil
	--x1 = math.min(GetCombatRating(CR_CRIT_TAKEN_MELEE), GetCombatRating(CR_CRIT_TAKEN_RANGED), GetCombatRating(CR_CRIT_TAKEN_SPELL));
	--x2 = math.min(GetCombatRatingBonus(CR_CRIT_TAKEN_MELEE), GetCombatRatingBonus(CR_CRIT_TAKEN_RANGED), GetCombatRatingBonus(CR_CRIT_TAKEN_SPELL));
	--table.insert(ret, "  Resil: " .. x1 .. " (-" .. string.format("%0.2f%%", x2) .. " crit, -" .. string.format("%0.2f%%", x2*2) .. " dmg)");
	-- Resists
	x1, x2, x3, x4, x5 = Logistics.GetResists();
	table.insert(ret, "  Resist: " .. VFL.strcolor(1,0,0)..x1.." "..VFL.strcolor(.2,.2,1)..x2.." "..VFL.strcolor(1,1,1)..x4.." "..VFL.strcolor(0.5,0,0.8)..x5 );


	-- Base Stats
	x1,x2,x3,x4,x5=9999,9999,9999,9999,9999;
	local stats = {"Str","Agi","Sta","Int","Spi"};
	table.insert(ret, "|cFFCCDBA4Base Stats:|r");
	for i=1,5 do 
		x1,x2,x3,x4 = UnitStat("player", i);
		x1=min(x5, x1);
		x2=min(x5, x2);
		x3=min(x5, x3);
		x4=min(x5, x4);
		table.insert(ret, "  "..stats[i]..": "..x2.." ("..x1..VFL.strcolor(0,1,0).."+"..x3..VFL.strcolor(1,0,0).."-"..x4..VFL.strcolor(1,1,1)..")");
	end
	stats = nil;

	-- Melee info
	table.insert(ret, "|cFFDC6C6CMelee Stats|r");
	x5 = 9999;
	x1,x2,x3 = UnitAttackPower("player");
	x1 = min(x5, x1);
	x2 = min(x5, x2);
	x3 = min(x5, x3);
	x4 = x1+x2;
	table.insert(ret, "   AP: ".. x4 .. " ("..x1..VFL.strcolor(0,1,0).."+"..x2..VFL.strcolor(1,0,0).."-"..x3..VFL.strcolor(1,1,1)..")");
	x1, x2, x3, x4 = UnitAttackBothHands("player");
	x1 = min(x5, x1);
	x2 = min(x5, x2);
	x3 = min(x5, x3);
	x4 = min(x5, x4);
	table.insert(ret, "   Skill: MH: ".. x1..VFL.strcolor(0,1,0).."+"..x2..VFL.strcolor(1,1,1).." OH: "..x3..VFL.strcolor(0,1,0).."+"..x4);
	x1 = GetCritChance();
	x1 = min(x5, x1);
	table.insert(ret, "   Crit: "..string.format("%0.2f%%", x1));
	x1,x2,x3 = UnitRangedAttackPower("player");
	x1 = min(x5, x1);
	x2 = min(x5, x2);
	x3 = min(x5, x3);
	x4 = x1+x2;
	table.insert(ret, "   Rngd AP: ".. x4 .. " ("..x1..VFL.strcolor(0,1,0).."+"..x2..VFL.strcolor(1,0,0).."-"..x3..VFL.strcolor(1,1,1)..")");
	x1 = GetRangedCritChance();
	x1 = min(x5, x1);
	table.insert(ret, "   Rngd Crit: "..string.format("%0.2f%%", x1));

	-- Spellpower
	table.insert(ret, "|cFFFFFFFFSpellpower|r");
	x1 = 999;
	table.insert(ret, "  |cFFFFFFFFTree     Dmg      Crit:|r ");
	local school = {"Holy:    ","Fire:     ","Nature: ","Frost:   ","Shadow:","Arcane: "};
	local dmg = {};
	local crit = {};
	local xr = {"1","1","0","0.2","0.5","0.7"};
	local xg = {"0.85","0","1","0.2","0","0.7"};
	local xb = {"0.2","0","0","1","0.8","0.7"};
	for i=2,MAX_SPELL_SCHOOLS do 
		local b=i-1;
		table.insert(dmg, GetSpellBonusDamage(i));
		table.insert(crit, GetSpellCritChance(i));
		table.insert(ret, "  "..VFL.strcolor(xr[b],xg[b],xb[b])..school[b].." "..dmg[b].."     "..string.format("%0.2f%%", crit[b]));
	end
	x1 = min(x1, GetCombatRating(8))
	table.insert(ret, "  Hit: "..x1);
	school, dmg, crit, xr, xg, xb = nil;

	-- Regen / healing shit
	table.insert(ret, "|cFF00E305Healing and Regen|r");
	x1 = 9999; x2 = 9999; x3 = 9999;
	x1 = min(x1, GetSpellBonusHealing());
	x4,x5 = GetManaRegen()
	x2 = min(x2, (x4*5));
	x3 = min(x3, (x5*5));
	table.insert(ret, "  Healing: " .. x1);
	table.insert(ret, "  5s Rule Mp5: " .. string.format("%1.0f", x2));
	table.insert(ret, "  Casting Mp5: " .. string.format("%1.0f", x3));

	-- Version info
	table.insert(ret, "|cFF009999RDX Version Info|r");
	RDX:ModuleListModules(function(indent, m)
		if m.version then
			local str = "";
			for i=1,indent do str = str .. "    "; end
			table.insert(ret, str .. m.name .. " |cFFAAAAAA(" .. m.version[1] .. "." .. m.version[2] .. "." .. m.version[3] .. ")");
		end
	end, 1);
	x1,x2,x3,x4,x5 = nil;
	return ret;
end

local function CSIncRPC(ci, who)
	-- Sanity check sender
	if (not ci) or (type(who) ~= "string") then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	-- Only leaders can send polls.
	--if not sunit:IsLeader() then
	--	RPC:Debug(1, "Got Charsheet check from non-leader " .. sunit.name);
	--	return; 
	--end
	local myunit = RDXDAL.GetMyUnit();
	if string.lower(who) == myunit.name then
		return MakeCharSheet();
	else

	end
end

RPC_Group:Bind("logistics_cs", CSIncRPC);

-----------------------------------------------
-- DISPATCHER
-----------------------------------------------
local csheets = {};

local function CSAD(cell, d, pos)
	cell:Show();
	cell.text1:SetText(d);
end

local function CS_ResponseRcvd(ci, resp)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (not ci) or (not ci.sender) or (not ci.id) or (type(resp) ~= "table") then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end

	local csi = csheets[ci.id];
	if not csi then 
		return; 
	end
	if (type(csi) == "table") then csi:Destroy(); end
	
	-- Open up a window with the character sheet data.
	local win = Logistics.MakeDetailWindow(CSAD);
	win:SetText("Character Sheet: " .. VFL.capitalize(ci.sender));
	VFL.copyOver(win.data, resp);
	win:Update();

	local idcl = ci.id;
	csheets[idcl] = win;
	win.Destroy = VFL.hook(function(s) csheets[idcl] = nil;	end, win.Destroy);
end

local function CS_Ask(who)
	if type(who) ~= "string" then return; end
	who = string.lower(who);
	local rpcid = RPC_Group:Invoke("logistics_cs", who);
	csheets[rpcid] = true;
	RPC_Group:Wait(rpcid, CS_ResponseRcvd, 10);
end
Omni.CS_Ask = CS_Ask;

-- Slash command to execute a query.
SLASH_CHARSHEET1 = VFLI.i18n("/charsheet");
SlashCmdList["CHARSHEET"] = function()
	if UnitExists("target") and (UnitInParty("target") or UnitInRaid("target")) then
		CS_Ask(UnitName("target"));
	else
		if RDXDAL.IsSolo() then
			VFL.print("You must be in a party or raid to preform queries.");
		else
			VFL.print("* Target is not in your raid or party; cannot request character sheet.");
		end
	end
end

----------------------------------------
-- GLUE
-- Create a menu option on the character context menus.
----------------------------------------
-- This code is causing irrevocable taint and disabling the Promote to MT/MA buttons
-- so it is being disabled

--[[UnitPopupButtons["RDX_CHARSHEET"] = { text = "RDX: Character Sheet", dist = 0 };
local function _fudgemenu(menu)
	if menu then
		table.insert(menu, "RDX_CHARSHEET");
	end
end
_fudgemenu(UnitPopupMenus["PLAYER"]);
_fudgemenu(UnitPopupMenus["RAID"]);
_fudgemenu(UnitPopupMenus["PARTY"]);

local function _menuhook(self)
	local dropdownFrame = _G[UIDROPDOWNMENU_INIT_MENU];
	local button = self.value;
	local unit = dropdownFrame.unit;
	local name = dropdownFrame.name;

	if (button == "RDX_CHARSHEET") then
		if UnitExists(unit) then name = UnitName(unit); end
		CS_Ask(name);
	end
end

hooksecurefunc("UnitPopup_OnClick", _menuhook);]]



