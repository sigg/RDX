local iconIdToName = {}
iconIdToName["ALL"] = "Alchemy Lab";
iconIdToName["ALT"] = "Alchemy Trainer";
iconIdToName["ALS"] = "Altar Of Shadows";
iconIdToName["ANV"] = "Anvil";
iconIdToName["ARR"] = "Arcane Reforger";
iconIdToName["ART"] = "Archaeology Trainer";
iconIdToName["AUC"] = "Auctioneer";
iconIdToName["BAN"] = "Banker";
iconIdToName["BAR"] = "Barber";
iconIdToName["BPT"] = "Battle Pet Trainer";
iconIdToName["BLT"] = "Blacksmithing Trainer";
iconIdToName["COT"] = "Cooking Trainer";
iconIdToName["DKT"] = "Death Knight Trainer";
iconIdToName["DRT"] = "Druid Trainer";
iconIdToName["ENT"] = "Enchanting Trainer";
iconIdToName["EGT"] = "Engineering Trainer";
iconIdToName["FAT"] = "First Aid Trainer";
iconIdToName["FIT"] = "Fishing Trainer";
iconIdToName["FLM"] = "Flight Master";
iconIdToName["FLT"] = "Flying Trainer";
iconIdToName["FOR"] = "Forge";
iconIdToName["HET"] = "Herbalism Trainer";
iconIdToName["HUT"] = "Hunter Trainer";
iconIdToName["INN"] = "Innkeeper";
iconIdToName["INT"] = "Inscription Trainer";
iconIdToName["JET"] = "Jewelcrafting Trainer";
iconIdToName["LET"] = "Leatherworking Trainer";
iconIdToName["MAT"] = "Mage Trainer";
iconIdToName["MAI"] = "Mailbox";
iconIdToName["MAL"] = "Mana Loom";
iconIdToName["MIT"] = "Mining Trainer";
iconIdToName["MOT"] = "Monk Trainer";
iconIdToName["MOO"] = "Moonwell";
iconIdToName["PAT"] = "Paladin Trainer";
iconIdToName["PRT"] = "Priest Trainer";
iconIdToName["RIT"] = "Riding Trainer";
iconIdToName["ROT"] = "Rogue Trainer";
iconIdToName["SHT"] = "Shaman Trainer";
iconIdToName["SKT"] = "Skinning Trainer";
iconIdToName["STM"] = "Stable Master";
iconIdToName["TAT"] = "Tailoring Trainer";
iconIdToName["TRA"] = "Transmogrifier";
iconIdToName["VOS"] = "Void Storage";
iconIdToName["WLT"] = "Warlock Trainer";
iconIdToName["WRT"] = "Warrior Trainer";



RDXMAP.iconIdToName = iconIdToName;
local iconNameToId = VFL.invert(iconIdToName);

local icontex = {}
icontex["ALL"] = "Interface\\Icons\\INV_Potion_06";
icontex["ALT"] = "Interface\\Icons\\Trade_Alchemy";
icontex["ALS"] = "Interface\\Icons\\INV_Fabric_Felcloth_Ebon";
icontex["ANV"] = "Interface\\Icons\\Trade_BlackSmithing";
icontex["ARR"] = "Interface\\Icons\\INV_Sword_67";
icontex["ART"] = "Interface\\Icons\\trade_archaeology";
icontex["AUC"] = "Interface\\Icons\\Racial_Dwarf_FindTreasure";
icontex["BAN"] = "Interface\\Icons\\INV_Misc_Coin_02";
icontex["BAR"] = "Interface\\Icons\\INV_Misc_Comb_02";
icontex["BPT"] = "Interface\\Icons\\INV_Pet_BattlePetTraining";
icontex["BLT"] = "Interface\\Icons\\Trade_BlackSmithing";
icontex["COT"] = "Interface\\Icons\\INV_Misc_Food_15";
icontex["DKT"] = "Interface\\Icons\\Spell_Deathknight_ClassIcon";
icontex["DRT"] = "Interface\\Icons\\Ability_Druid_Maul";
icontex["ENT"] = "Interface\\Icons\\Trade_Engraving";
icontex["EGT"] = "Interface\\Icons\\Trade_Engineering";
icontex["FAT"] = "Interface\\Icons\\Spell_Holy_SealOfSacrifice";
icontex["FIT"] = "Interface\\Icons\\Trade_Fishing";
icontex["FLT"] = "Interface\\Icons\\inv_scroll_11";
icontex["FLM"] = "Interface\\Icons\\Ability_Mount_Wyvern_01";
icontex["FOR"] = "Interface\\Icons\\INV_Sword_09";
icontex["HET"] = "Interface\\Icons\\Trade_Herbalism";
icontex["HUT"] = "Interface\\Icons\\INV_Weapon_Bow_07";
icontex["INN"] = "Interface\\Icons\\Spell_Shadow_Twilight";
icontex["INT"] = "Interface\\Icons\\INV_Inscription_Tradeskill01";
icontex["JET"] = "Interface\\Icons\\INV_Misc_Gem_02";
icontex["LET"] = "Interface\\Icons\\INV_Misc_ArmorKit_17";
icontex["MAT"] = "Interface\\Icons\\INV_Staff_13";
icontex["MAI"] = "Interface\\Icons\\INV_Letter_15";
icontex["MAL"] = "Interface\\Icons\\INV_Fabric_Netherweave_Bolt_Imbued";
icontex["MIT"] = "Interface\\Icons\\Trade_Mining";
icontex["MOT"] = "Interface\\Icons\\Class_Monk";
icontex["MOO"] = "Interface\\Icons\\INV_Fabric_MoonRag_Primal";
icontex["PAT"] = "Interface\\Icons\\INV_Hammer_01";
icontex["PRT"] = "Interface\\Icons\\INV_Staff_30";
icontex["RIT"] = "Interface\\Icons\\spell_nature_swiftness";
icontex["ROT"] = "Interface\\Icons\\INV_ThrowingKnife_04";
icontex["SHT"] = "Interface\\Icons\\Spell_Nature_BloodLust";
icontex["SKT"] = "Interface\\Icons\\INV_Misc_Pelt_Wolf_01";
icontex["STM"] = "Interface\\Icons\\Ability_Hunter_BeastTaming";
icontex["TAT"] = "Interface\\Icons\\Trade_Tailoring";
icontex["TRA"] = "Interface\\Icons\\INV_Arcane_Orb";
icontex["VOS"] = "Interface\\Icons\\spell_nature_astralrecalgroup";
icontex["WLT"] = "Interface\\Icons\\Spell_Nature_FaerieFire";
icontex["WRT"] = "Interface\\Icons\\INV_Sword_27";
icontex["D"] = "Interface\\Minimap\\POIIcons";
icontex["Goto"] = "Interface\\AddOns\\RDX\\Skin\\Map\\IconWayTarget";

icontex["Star"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_1";
icontex["Circle"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_2";
icontex["Diamond"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_3";
icontex["Triangle"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_4";
icontex["Moon"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_5";
icontex["Square"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_6";
icontex["Cross"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_7";
icontex["Skull"] = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8";

RDXMAP.icontex = icontex;

RDXMAP.icontexCoord = {};
RDXMAP.icontexCoord["D"] = {.571, .635, 0, .039};


local NX_FLIGHT_LOC = { ["1"] = "Alliance Flight", ["2"] = "Horde Flight", ["0"] = "Neutral Flight", }

local a, h, n = 0, 0, 0;

function DATAPUSHOLD()
	for k,v in pairs (FLIGHT_DATA) do
		local side, zon, x, y = strsplit(",", k)
		--local name = NX_FLIGHT_LOC[side]..":"..v
		local name = v;
		local file
		if side == "1" then 
			side = "0";
		elseif side == "2" then
			side = "1";
		elseif side == "0" then
			side = "2";
		end
		local info = RDXMAP.APIMap.GetWorldZone (tonumber(zon))
		if info and info.c then
			local mbo = RDXDB.TouchObject("RDXDiskMap:poisG:Flight_" .. info.c);
			if not mbo.data then
				mbo.data = {};
				mbo.ty = "POISet"; 
				mbo.version = 1;
			end
			table.insert(mbo.data, format("%s;%s;%s;%s;%s",side,name,zon,x,y));
		end
	end
	VFL.print("OK");
end

local found, flags, conTime, name1, z1, x1, y1, name2, z2, x2, y2;

local cpt = {};

function DATAPUSHOLD2()
	for k,v in pairs (RDXMAP.ZoneConnections) do
		local flags, conTime, name1, z1, x1, y1, name2, z2, x2, y2 = strsplit("|",v)
		conTime = tonumber(conTime)
		z1 = tonumber(z1)
		x1 = tonumber(x1)
		y1 = tonumber(y1)
		x1, y1 = RDXMAP.APIMap.GetWorldPos (z1, x1, y1)
		z2 = tonumber(z2)
		x2 = tonumber(x2)
		y2 = tonumber(y2)
		x2, y2 = RDXMAP.APIMap.GetWorldPos (z2, x2, y2)
		
		local tbl1 = {};
		tbl1.n = name1;
		tbl1.t = conTime
		tbl1.x = x1;
		tbl1.y = y1;
		
		local tbl2 = {};
		tbl2.n = name2;
		tbl2.t = conTime
		tbl2.x = x2;
		tbl2.y = y2;
		
		if not cpt[z1] then cpt[z1] = 0; end
		if not cpt[z2] then cpt[z2] = 0; end
		cpt[z1] = cpt[z1] + 1;
		cpt[z2] = cpt[z2] + 1;
		local id1 = cpt[z1]
		local id2 = cpt[z2]
		
		-- cross reference
		tbl1.zcr = z2
		tbl2.zcr = z1
		tbl1.icr = id2
		tbl2.icr = id1
		
		local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:ZC_" .. z1);
		if not mbo.data then
			mbo.data = {};
			mbo.ty = "POIZoneConnectionSet"; 
			mbo.version = 1;
		end
		
		mbo.data[id1] = tbl1;
		
		local mbo = RDXDB.TouchObject("RDXDiskMap:poisT:ZC_" .. z2);
		if not mbo.data then
			mbo.data = {};
			mbo.ty = "POIZoneConnectionSet"; 
			mbo.version = 1;
		end
		
		mbo.data[id2] = tbl2;

	end
	VFL.print("OK");
end

local tbt = {};
table.insert(tbt,13);
table.insert(tbt,14);
table.insert(tbt,466);
table.insert(tbt,485);
table.insert(tbt,862);

function DATAPUSH()
	for g,w in pairs (RDXDB.GetPackage("RDXDiskMap", "poisG")) do
		local aa = {};
		if type(w) == "table" and w.data then
			for k,v in pairs (w.data) do
				local id,side,x1,y1 = strsplit(",",v)
				
				side = tonumber(side)
				z1 = tonumber(g)
				x1 = tonumber(x1)
				y1 = tonumber(y1)
				if not x1 then VFL.print(g); end
				x1, y1 = RDXMAP.APIMap.GetWorldPos (z1, x1, y1)
				
				
				local tbl1 = {};
				tbl1.t = id
				tbl1.z = z1;
				tbl1.x = x1;
				tbl1.y = y1;
				tbl1.s = side;
				
				table.insert(aa, tbl1);
			end

			local mbo = RDXDB.TouchObject("RDXDiskMap:poisG2:" .. g);
			mbo.ty = "POISet";
			mbo.version = 1;
			mbo.data = aa;
		end
	end
end

--[[
new poidata
x (global)
y (global)
t type
n name
s side (0 A, 1 H, 2 N)
fx (flight x)
fy (flight y)








]]
