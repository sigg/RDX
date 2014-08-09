RDXMAP.GuideAbr = {
	["K"] = "Kalimdor",
	["E"] = "Eastern Kingdoms",
	["O"] = "Outlands",
	["N"] = "Northrend",
	["M"] = "The Maelstrom",
	["P"] = "Pandaria",
}


RDXMAP.GuideInfo = {
	Name = "All",
	Tx = "INV_Misc_Map02",
	{
		Name = "Quest Givers",
		T = "&",
		Tx = "INV_Misc_Note_02",
		Persist = "QMapShowQuestGivers3",
	},
	{
		T = "Stable Master",
		Tx = "Ability_Hunter_BeastTaming",
	},
	{
		T = "Flight Master",
		Tx = "Ability_Mount_Wyvern_01",
	},
	{
		Name = "Common Place",
		Tx = "INV_Misc_Map02",
		{
			T = "Auctioneer",
			Tx = "Racial_Dwarf_FindTreasure",
		},
		{
			T = "Banker",
			Tx = "INV_Misc_Coin_02",
		},
		{
			T = "Innkeeper",
			Tx = "Spell_Shadow_Twilight",
		},
		{
			T = "Arcane Reforger",
			Tx = "INV_Sword_67",
		},
        {
			T = "Void Storage",
			Tx = "spell_nature_astralrecalgroup",
		},
		{
			T = "Transmogrifier",
			Tx = "INV_Arcane_Orb",
		},
		{
			T = "Battle Pet Trainer",
			Tx = "INV_Pet_BattlePetTraining",
		},
		{
			T = "Barber",
			Tx = "INV_Misc_Comb_02",
		},
        {
			T = "Mailbox",
			Tx = "INV_Letter_15",
		},
		{
			T = "Anvil",
			Tx = "Trade_BlackSmithing",
		},
		{
			T = "Forge",
			Tx = "INV_Sword_09",
		},
	},
	
	{
		Name = "Class Trainer",
		T = "^C",
		Tx = "INV_Misc_Book_10",
		{
			T = "Death Knight Trainer",
			Tx = "Spell_Deathknight_ClassIcon",
		},
		{
			T = "Druid Trainer",
			Tx = "Ability_Druid_Maul",
		},
		{
			T = "Hunter Trainer",
			Tx = "INV_Weapon_Bow_07",
		},
		{
			T = "Mage Trainer",
			Tx = "INV_Staff_13",
		},
		{
			T = "Paladin Trainer",
			Tx = "INV_Hammer_01",
		},
		{
			T = "Priest Trainer",
			Tx = "INV_Staff_30",
		},
		{
			T = "Rogue Trainer",
			Tx = "INV_ThrowingKnife_04",
		},
		{
			T = "Shaman Trainer",
			Tx = "Spell_Nature_BloodLust",
		},
		{
			T = "Warlock Trainer",
			Tx = "Spell_Nature_FaerieFire",
		},
		{
			T = "Warrior Trainer",
			Tx = "INV_Sword_27",
		},
		{
			T = "Monk Trainer",
			Tx = "Class_Monk", 
		},
	},	
	{
		Name = "Trainer",
		T = "^C",
		Tx = "INV_Misc_Book_01",
		
		{
			Pre = "Alchemy",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Alchemy",
		},
		{
			Pre = "Archaeology",
			Name = "Trainer",
			T = "^P",
			Tx = "trade_archaeology",
		},
		{
			Pre = "Blacksmithing",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_BlackSmithing",
		},
		{
			Pre = "Enchanting",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Engraving",
		},
		{
			Pre = "Engineering",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Engineering",
		},
		{
			Pre = "Herbalism",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Herbalism",
		},
		{
			Pre = "Inscription",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Inscription_Tradeskill01",
		},
		{
			Pre = "Jewelcrafting",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Misc_Gem_02",
		},
		{
			Pre = "Leatherworking",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Misc_ArmorKit_17",
		},
		{
			Pre = "Mining",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Mining",
		},
		{
			Pre = "Skinning",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Misc_Pelt_Wolf_01",
		},
		{
			Pre = "Tailoring",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Tailoring",
		},
		{
			Pre = "Cooking",
			Name = "Trainer",
			T = "^S",
			Tx = "INV_Misc_Food_15",
		},
		{
			Pre = "First Aid",
			Name = "Trainer",
			T = "^S",
			Tx = "Spell_Holy_SealOfSacrifice",
		},
		{
			Pre = "Fishing",
			Name = "Trainer",
			T = "^S",
			Tx = "Trade_Fishing",
		},
		{
			Pre = "Flying",
			Name = "Trainer",
			T = "^S",
			Tx = "inv_scroll_11",
		},
		{
			Pre = "Riding",
			Name = "Trainer",
			T = "^S",
			Tx = "spell_nature_swiftness",
		},
	},
	{
		Name = "Travel",
		Tx = "Ability_Townwatch",
	},
	
	{
		Name = "Visited Vendor",
		Tx = "INV_Misc_Coin_05",
		{
			Name = "All Items",
			NoShowChild = true,
		},
	},
	{
		Name = "Gather",
		Tx = "INV_Misc_Bag_10",
		{
			Name = "Herb",
			Tx = "INV_Misc_Flower_02",
			Persist = "MapShowGatherH",
		},
		{
			Name = "Ore",
			Tx = "INV_Ore_Copper_01",
			Persist = "MapShowGatherM",
		},
		{
			Name = "Artifacts",
			T = "$ A",
			Id = "Art",
			Tx = "Trade_Archaeology",
			Persist = "MapShowGatherA",
		},
		{
			Name = NXlEverfrost,
			T = "$ E",
			Id = "Everfrost",
			Tx = "spell_shadow_teleport",
		},
		{
			Name = NXlGas,
			T = "$ G",
			Id = "Gas",
			Tx = "inv_gizmo_zapthrottlegascollector",
		},
	},
	{
		Name = "Instances",
		Tx = "INV_Misc_ShadowEgg",
		{
			Name = "@K",
			Inst = 1
		},
		{
			Name = "@E",
			Inst = 2
		},
		{
			Name = "@O",
			Inst = 3
		},
		{
			Name = "@N",
			Inst = 4
		},
		{
			Name = "@M",
			Inst = 5
		},
		{
			Name = "@P",
			Inst = 6
		},
	},
	{
		Name = "Zone",
		Tx = "INV_Misc_Map_01",
		{
			Name = "All",
			Map = 0
		},
		{
			Name = "@K",
			Map = 1
		},
		{
			Name = "@E",
			Map = 2
		},
		{
			Name = "@O",
			Map = 3
		},
		{
			Name = "@N",
			Map = 4
		},
		{
			Name = "@M",
			Map = 5
		},
		{
			Name = "@P",
			Map = 6
		},
	},
	{
		Name = "Trade Skill",
		Tx = "INV_Misc_Note_04",
		{
			T = "Alchemy Lab",
			Tx = "INV_Potion_06",
		},
		{
			T = "Altar Of Shadows",
			Tx = "INV_Fabric_Felcloth_Ebon",
		},
		{
			T = "Mana Loom",
			Tx = "INV_Fabric_Netherweave_Bolt_Imbued",
		},
		{
			T = "Moonwell",
			Tx = "INV_Fabric_MoonRag_Primal",
		},
	},	
	
}

RDXMAP.GuidePOI = {
	"Auctioneer~Racial_Dwarf_FindTreasure",
	"Banker~INV_Misc_Coin_02",
	"Flight Master~Ability_Mount_Wyvern_01",
	"Innkeeper~Spell_Shadow_Twilight",
	"Mailbox~INV_Letter_15",
    "Arcane Reforger~INV_Sword_67",
	
}

RDXMAP.VendorCostAbr = {
	["INV_Jewelry_Amulet_07"] = "AB",
	["INV_Jewelry_Necklace_21"] = "AV",
	["Spell_Nature_EyeOfTheStorm"] = "EOS",
	["INV_Misc_Rune_07"] = "WG",
	["Spell_Holy_ChampionsBond"] = "Badge of Justice", 
	["INV_Misc_Dust_06"] = "Holy Dust",			
	["INV_Misc_Rune_05"] = "Arcane Rune",		
	["INV_Chest_Chain_03"] = "Chestguard Token", 
	["INV_Gauntlets_27"] = "Gloves Token",
	["INV_Helmet_24"] = "Helm Token",
	["INV_Pants_Plate_17"] = "Leggings Token",
	["INV_Shoulder_22"] = "Pauldrons Token",
	["INV_Misc_Apexis_Shard"] = "Apexis Shard",
	["INV_Misc_Apexis_Crystal"] = "Apexis Crystal",
	["INV_Misc_Token_Thrallmar"] = "Thrallmar Token",
	["INV_Misc_Rune_08"] = "Battle Token",
	["INV_Misc_Rune_09"] = "Research Token",
	["Spell_Holy_ProclaimChampion"] = "Emblem of Heroism",
	["Spell_Holy_ProclaimChampion_02"] = "Emblem of Valor",
	["INV_Misc_Platnumdisks"] = "Stone Keeper's Shard",
	["INV_Enchant_AbyssCrystal"] = "Abyss Crystal",
	["INV_Enchant_DreamShard_02"] = "Dream Shard",
	["INV_Misc_LeatherScrap_19"] = "Heavy Borean Leather",
	["INV_Misc_Pelt_14"] = "Arctic Fur",
}

