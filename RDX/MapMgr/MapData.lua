
RDXMAP.ContBlks = {
		{ 0,1,1,0, 0,1,1,0, 0,1,1,0 },
		{ 0,1,1,0, 0,1,1,0, 0,1,1,0 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
		{ 1,1,1,0, 1,1,1,0, 1,1,1,0 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
	}

RDXMAP.MapPOITypes = {
		[0] =
		0, 0, 2, 1, 1, 0, 0, 0,  0, 1, 2, 1, 2, 2, 2, 1,
		0, 1, 1, 2, 2, 0, 1, 1,  2, 2, 0, 1, 1, 2, 2, 0,
		1, 1, 2, 2, 0, 1, 1, 2,  2, 0, 0, 1, 2, 0, 1, 1,
		2, 2,
		[136] = 1,
		[137] = 1,
		[138] = 2,
		[139] = 2,
		[141] = 1,
		[142] = 1,
		[143] = 2,
		[144] = 2,
		[146] = 1,
		[147] = 1,
		[148] = 2,
		[149] = 2,
		[151] = 1,
		[152] = 1,
		[153] = 2,
		[154] = 2,
	}


--[[
RDXMAP.MapInfo = {
	[0] = {	-- Dummy
		Name = "Instance",
		X = 0,
		Y = 0,
		mapid = 0,
	},
	{
		Name = "Kalimdor",
		FileName = "Kalimdor",
		X = -1800,	-- Was 0
		Y = 200,
		--Min = 1001,
		--Max = 1033,
		mapid = 13,
	},
	{
		Name = "Eastern Kingdoms",
		FileName = "Azeroth",
		X = 5884,	-- Was 3784
		Y = -200,
		--Min = 2001,
		--Max = 2048,
		mapid = 14,
	},
	{
		Name = "Outland",
		FileName = "Expansion01",
		X = 7000,
		Y = -4000,
		--Min = 3001,
		--Max = 3008,
		mapid = 466,
	},
	{
		Name = "Northrend",
		FileName = "Northrend",
		X = 600,
		Y = -4500,
		--Min = 4001,
		--Max = 4014,
		mapid = 485,
	},
	{
		Name = "The Maelstrom",
		FileName = "TheMaelstromContinent",
		X = 1100,
		Y = -1800, 
		--Min = 5001,
		--Max = 5005,
		mapid = 751,
	},
	[6] = {
	    Name = "Pandaria",
		FileName = "Pandaria",
		X = 2350,
		Y = 300,
		--Min = 6001,
		--Max = 6015,
		mapid = 862,
	},
	[8] = {
		Name = "Instance",
		X = 2000,
		Y = 100,
	},
	[9] = {
		Name = "BG",
		X = 2000,
		Y = 200,
	},
}]]

RDXMAP.BloodelfXO = -503
RDXMAP.BloodelfYO = 516
RDXMAP.DraeneiXO = -3500
RDXMAP.DraeneiYO = -2010

-- type tp
-- 1 = continent
-- 2 = zone
-- 3 = city
-- 4 = instance
-- 5 = bg
-- 6 = scenario

RDXMAP.MapWorldInfo = {

	-- Dummy if we get a zero on startup
	--[0] = {
	--	Name = "",
	--	10,
	--	0, 0,
	--	0, 0,  -- Index 4,5 XY world position created for zones in continents 1-5, 9
	--	Overlay = "barrens",
	--},

	[13] = {
		class = "w",
		id = 1,
		Name = "Kalimdor",
		73.3282, -- Scale
		-3398.85, -2552.91, -- Origin
		tp = 1,
		oldid = 1000,
		X = -1800,	-- Was 0
		Y = 200,
		FileName = "Kalimdor",
	},
	[772] = {
		Name = "Ahn'Qiraj: The Fallen Kingdom",
		Cont = 1,
		Fish = 1,
		faction = 2,
		tp = 2,
		oldid = 1025,
		minLvl = 0,
		maxLvl = 0,
	},
	[894] = {
		Name = "Ammen Vale",
		Cont = 1,
		XOff = RDXMAP.DraeneiXO,
		YOff = RDXMAP.DraeneiYO,
		MId = 1003,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 1029,
		minLvl = 0,
		maxLvl = 0,
	},
	[43] = {
		Name = "Ashenvale",
		Cont = 1,
		Fish = 150,
		QAchievementId = 4925,
		QAchievementIdH = 4976,
		faction = 2,
		tp = 2,
		oldid = 1001,
		minLvl = 0,
		maxLvl = 0,
	},
	[181] = {
		Name = "Azshara",
		Cont = 1,
		Fish = 300,
		QAchievementIdH = 4927,
		faction = 2,
		tp = 2,
		oldid = 1002,
		minLvl = 0,
		maxLvl = 0,
	},
	[464] = {
		Name = "Azuremyst Isle",
		Cont = 1,
		XOff = RDXMAP.DraeneiXO,
		YOff = RDXMAP.DraeneiYO,
		MId = 1003,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 1003,
		minLvl = 0,
		maxLvl = 0,
	},
	[476] = {
		Name = "Bloodmyst Isle",
		Cont = 1,
		XOff = RDXMAP.DraeneiXO,
		YOff = RDXMAP.DraeneiYO,
		MId = 1003,
		Fish = 75,
		QAchievementIdA = 4926,
		faction = 2,
		tp = 2,
		oldid = 1004,
		minLvl = 0,
		maxLvl = 0,
	},
	[890] = {
		Name = "Camp Narache",
		Cont = 1,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 1030,
		minLvl = 0,
		maxLvl = 0,
	},
	[42] = {
		Name = "Darkshore",
		Cont = 1,
		Fish = 75,
		QAchievementIdA = 4928,
		faction = 2,
		tp = 2,
		oldid = 1005,
		minLvl = 0,
		maxLvl = 0,
	},
	[381] = {
		Name = "Darnassus",
		Cont = 1,
		2.116669, -- Scale (0.6668302)
		-587.6726, -2047.663, -- Origin (WH 211.6669, 141.1459)
		 -- -2012.279 -9985.129, 87.5039 35.8759
		 -- -2400.08 -9702.901, 50.8613 75.8668
		Overlay = "darnassis",
		City = true,
		MMOutside = true,
		Fish = 75,
		faction = 2,
		tp = 3,
		oldid = 1006,
	},
	[101] = {
		Name = "Desolace",
		Cont = 1,
		Fish = 225,
		QAchievementId = 4930,
		faction = 2,
		tp = 2,
		oldid = 1007,
		minLvl = 0,
		maxLvl = 0,
	},
	[4] = {
		Name = "Durotar",
		Cont = 1,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 1008,
		minLvl = 1,
		maxLvl = 10,
	},
	[141] = {
		Name = "Dustwallow Marsh",
		Cont = 1,
		Fish = 225,
		QAchievementId = 4929,
		QAchievementIdH = 4978,
		faction = 2,
		tp = 2,
		oldid = 1009,
		minLvl = 0,
		maxLvl = 0,
	},
	[891] = {
		Name = "Echo Isles",
		Cont = 1,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 1031,
		minLvl = 0,
		maxLvl = 0,
	},
	[182] = {
		Name = "Felwood",
		Cont = 1,
		Fish = 300,
		QAchievementId = 4931,
		faction = 2,
		tp = 2,
		oldid = 1010,
		minLvl = 0,
		maxLvl = 0,
	},
	[121] = {
		Name = "Feralas",
		Cont = 1,
		Fish = 300,
		QAchievementId = 4932,
		QAchievementIdH = 4979,
		faction = 2,
		tp = 2,
		oldid = 1011,
		minLvl = 0,
		maxLvl = 0,
	},
	[795] = {	-- Patch 4.2 (AID 795)
		Name = "Molten Front",
		Cont = 1,
		2.38,
		1000, 2500,
		MId = 4012,
		UseAId = true,
--		City = true,
		Overlay = "moltenfront",
		Explored = true,
		faction = 2,
		tp = 2,
		oldid = 4012,
		minLvl = 0,
		maxLvl = 0,
	},
	[241] = {
		Name = "Moonglade",
		Cont = 1,
		Fish = 300,
		faction = 2,
		tp = 2,
		oldid = 1012,
		minLvl = 0,
		maxLvl = 0,
	},
	[606] = {
		Name = "Mount Hyjal",
		Cont = 1,
		Fish = 1,
		QAchievementId = 4870,
		faction = 2,
		tp = 2,
		oldid = 1026,
		minLvl = 0,
		maxLvl = 0,
	},
	[9] = {
		Name = "Mulgore",
		Cont = 1,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 1013,
		minLvl = 1,
		maxLvl = 10,
	},
	[11] = {
		Name = "Northern Barrens",
		Cont = 1,
		Fish = 75,
		QAchievementIdH = 4933,
		faction = 2,
		tp = 2,
		oldid = 1019,
		minLvl = 10,
		maxLvl = 20,
	},
	[321] = {
		Name = "Orgrimmar",
		Cont = 1,
		2.805208, -- Scale (0.6669141)
		736.1202, -454.7754, -- Origin (WH 280.5208, 187.0833)
		 -- 4362.793 -1397.708, 48.63751 93.66625
		 -- 4452.566 -1601.87, 55.03796 71.84045
		Overlay = "ogrimmar",
		City = true,
		MMOutside = true,
		--MId = 1014,
		Fish = 75,
		faction = 2,
		tp = 3,
		oldid = 1014,
	},
	[888] = {
		Name = "Shadowglen",
		Cont = 1,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 1032,
		minLvl = 0,
		maxLvl = 0,
	},
	[261] = {
		Name = "Silithus",
		Cont = 1,
		Fish = 425,
		QAchievementIdA = 4934,
		faction = 2,
		tp = 2,
		oldid = 1015,
		minLvl = 0,
		maxLvl = 0,
	},
	[607] = {
		Name = "Southern Barrens",
		Cont = 1,
		Fish = 75,
		QAchievementId = 4937,
		QAchievementIdH = 4981,
		faction = 2,
		tp = 2,
		oldid = 1027,
		minLvl = 0,
		maxLvl = 0,
	},
	[81] = {
		Name = "Stonetalon Mountains",
		Cont = 1,
		Fish = 150,
		QAchievementId = 4936,
		QAchievementIdH = 4980,
		faction = 2,
		tp = 2,
		oldid = 1016,
		minLvl = 0,
		maxLvl = 0,
	},
	[161] = {
		Name = "Tanaris",
		Cont = 1,
		Fish = 300,
		QAchievementId = 4935,
		faction = 2,
		tp = 2,
		oldid = 1017,
		minLvl = 0,
		maxLvl = 0,
	},
	[41] = {
		Name = "Teldrassil",
		Cont = 1,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 1018,
		minLvl = 0,
		maxLvl = 0,
	},
	[471] = {
		Name = "The Exodar",
		Cont = 1,
		XOff = RDXMAP.DraeneiXO,
		YOff = RDXMAP.DraeneiYO,
		City = true,
		MId = 1003,
		faction = 2,
		tp = 3,
		oldid = 1020,
		minLvl = 0,
		maxLvl = 0,
	},
	[61] = {
		Name = "Thousand Needles",
		Cont = 1,
		Fish = 225,
		QAchievementId = 4938,
		faction = 2,
		tp = 2,
		oldid = 1021,
		minLvl = 0,
		maxLvl = 0,
	},
	[362] = {
		Name = "Thunder Bluff",
		Cont = 1,
		2.087504, -- Scale (0.666666)
		-103.3333, 170, -- Origin (WH 208.7504, 139.1668)
		 -- -288.8936 975.1409, 21.8225 17.9843
		 -- -134.5071 1215.782, 36.614 52.5675
		 -- -180.5793 1321.172, 32.1999 67.7133
		Overlay = "thunderbluff",
		City = true,
		MMOutside = true,
		Fish = 75,
		faction = 2,
		tp = 3,
		oldid = 1022,
	},
	[720] = {
		Name = "Uldum",
		Cont = 1,
		Fish = 75,
		QAchievementId = 4872,
		faction = 2,
		tp = 2,
		oldid = 1028,
		minLvl = 0,
		maxLvl = 0,
	},
	[201] = {
		Name = "Un'Goro Crater",
		Cont = 1,
		Fish = 300,
		QAchievementId = 4939,
		faction = 2,
		tp = 2,
		oldid = 1023,
		minLvl = 0,
		maxLvl = 0,
	},
	[889] = {
		Name = "Valley of Trials",
		Cont = 1,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 1033,
		minLvl = 0,
		maxLvl = 0,
	},
	[281] = {
		Name = "Winterspring",
		Cont = 1,
		Fish = 425,
		QAchievementId = 4940,
		faction = 2,
		tp = 2,
		oldid = 1024,
		minLvl = 0,
		maxLvl = 0,
	},
	
	-- Eastern Kingdoms
	[14] = {
		class = "w",
		id = 2,
		Name = "Eastern Kingdoms",
		81.53, -- Scale
		-3645.96, -2249.31, -- Origin
		tp = 1,
		oldid = 2000,
		X = 5884,	-- Was 3784
		Y = -200,
		FileName = "Azeroth",
	},
	[614] = {
		Name = "Abyssal Depths",
		Cont = 2,
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
		faction = 2,
		tp = 2,
		oldid = 2031,
		minLvl = 0,
		maxLvl = 0,
	},
	--[2001] = {	-- Merged into Hillsbrad Foothills for Cataclysm
	--	Name = "Alterac Mountains",
	--	5.599993, -- Scale (0.6666676)
	--	-156.6661, -299.9998, -- Origin (WH 559.9993, 373.3334)
		 -- 599.2264 -222.7941, 49.3771 68.4217
		 -- 830.212 -798.6328, 57.6266 37.5732
	--	Overlay = "alterac",
	--	Fish = 225,
	--	oldid = 2001,
	--},
	[16] = {
		Name = "Arathi Highlands",
		Cont = 2,
		Fish = 225,
		QAchievementId = 4896,
		faction = 2,
		tp = 2,
		oldid = 2002,
		minLvl = 25,
		maxLvl = 30,
	},
	[17] = {
		Name = "Badlands",
		Cont = 2,
		QAchievementId = 4900,
		faction = 2,
		tp = 2,
		oldid = 2003,
		minLvl = 44,
		maxLvl = 48,
	},
	[19] = {
		Name = "Blasted Lands",
		Cont = 2,
		QAchievementId = 4909,
		faction = 2,
		tp = 2,
		oldid = 2004,
		minLvl = 55,
		maxLvl = 60,
	},
	[29] = {
		Name = "Burning Steppes",
		Cont = 2,
		Fish = 425,
		QAchievementId = 4901,
		faction = 2,
		tp = 2,
		oldid = 2005,
		minLvl = 0,
		maxLvl = 0,
	},
	[866] = {
		Name = "Coldridge Valley",
		Cont = 2,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 2044,
		minLvl = 0,
		maxLvl = 0,
	},
	[32] = {
		Name = "Deadwind Pass",
		Cont = 2,
		Fish = 425,
		faction = 2,
		tp = 2,
		oldid = 2006,
		minLvl = 0,
		maxLvl = 0,
	},
	[892] = {
		Name = "Deathknell",
		Cont = 2,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 2045,
		minLvl = 0,
		maxLvl = 0,
	},
	[27] = {
		Name = "Dun Morogh",
		Cont = 2,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 2007,
		minLvl = 0,
		maxLvl = 0,
	},
	[34] = {
		Name = "Duskwood",
		Cont = 2,
		Fish = 150,
		QAchievementIdA = 4907,
		faction = 2,
		tp = 2,
		oldid = 2008,
		minLvl = 0,
		maxLvl = 0,
	},
	[23] = {
		Name = "Eastern Plaguelands",
		Cont = 2,
		Fish = 425,
		QAchievementId = 4892,
		faction = 2,
		tp = 2,
		oldid = 2009,
		minLvl = 0,
		maxLvl = 0,
	},
	[30] = {
		Name = "Elwynn Forest",
		Cont = 2,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 2010,
		minLvl = 0,
		maxLvl = 0,
	},
	[462] = {
		Name = "Eversong Woods",
		Cont = 2,
		XOff = RDXMAP.BloodelfXO,
		YOff = RDXMAP.BloodelfYO,
		MId = 2011,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 2011,
		minLvl = 0,
		maxLvl = 0,
	},
	[463] = {
		Name = "Ghostlands",
		Cont = 2,
		XOff = RDXMAP.BloodelfXO,
		YOff = RDXMAP.BloodelfYO,
		MId = 2011,
		Fish = 75,
		QAchievementIdH = 4908,
		faction = 2,
		tp = 2,
		oldid = 2012,
		minLvl = 0,
		maxLvl = 0,
	},
	[545] = {
		Name = "Gilneas",
		Cont = 2,
		faction = 2,
		tp = 2,
		oldid = 2042,
		minLvl = 0,
		maxLvl = 0,
	},
	[611] = {
		Name = "Gilneas City",
		Cont = 2,
		City = true,			-- No explored areas
		MMOutside = true,
		faction = 2,
		tp = 3,
		oldid = 2043,
		aa = "1",
	},
	[24] = {
		Name = "Hillsbrad Foothills",
		Cont = 2,
		Fish = 150,
		QAchievementIdH = 4895,
		faction = 2,
		tp = 2,
		oldid = 2013,
		minLvl = 0,
		maxLvl = 0,
	},
	[341] = {
		Name = "Ironforge",
		Cont = 2,
		1.581249, -- Scale (0.6673273)
		142.7185, 913.8483, -- Origin (WH 158.1249, 105.521)
		 -- 1168.239 4834.522, 57.5047 50.2803
		 -- 1002.861 4949.052, 36.5874 71.9877
		 -- 953.4069 4990.946, 30.3323 79.9281
		Overlay = "ironforge",
		City = true,
		Fish = 75,
		faction = 2,
		tp = 3,
		oldid = 2014,
	},
	[499] = {
		Name = "Isle of Quel'Danas",
		Cont = 2,
		XOff = RDXMAP.BloodelfXO,
		YOff = RDXMAP.BloodelfYO,
		MId = 2011,
		Fish = 450,
		faction = 2,
		tp = 2,
		oldid = 2029,
		minLvl = 0,
		maxLvl = 0,
	},
	[610] = {
		Name = "Kelp'thar Forest",
		Cont = 2,
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
		faction = 2,
		tp = 2,
		oldid = 2032,
		minLvl = 0,
		maxLvl = 0,
	},
	[35] = {
		Name = "Loch Modan",
		Cont = 2,
		Fish = 75,
		QAchievementIdA = 4899,
		faction = 2,
		tp = 2,
		oldid = 2015,
		minLvl = 0,
		maxLvl = 0,
	},
	[895] = {
		Name = "New Tinkertown",
		Cont = 2,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 2046,
		minLvl = 0,
		maxLvl = 0,
	},
	[37] = {
		Name = "Northern Stranglethorn",
		Cont = 2,
--		Name = "Stranglethorn Vale",
		Fish = 225,
		QAchievementId = 4906,
		faction = 2,
		tp = 2,
		oldid = 2021,
		minLvl = 0,
		maxLvl = 0,
	},
	[864] = {
		Name = "Northshire",
		Cont = 2,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 2047,
		minLvl = 0,
		maxLvl = 0,
	},
	[36] = {
		Name = "Redridge Mountains",
		Cont = 2,
		Fish = 150,
		QAchievementIdA = 4902,
		faction = 2,
		tp = 2,
		oldid = 2016,
		minLvl = 0,
		maxLvl = 0,
	},
	[684] = {
		Name = "Ruins of Gilneas",
		Cont = 2,
		Fish = 75,
		--Explored = true,
		faction = 2,
		tp = 2,
		oldid = 2033,
		minLvl = 0,
		maxLvl = 0,
	},
	[685] = {
		Name = "Ruins of Gilneas City",
		Cont = 2,
		Fish = 75,
		City = true,	-- No explored areas
		faction = 2,
		tp = 3,
		oldid = 2034,
	},
	[28] = {
		Name = "Searing Gorge",
		Cont = 2,
		QAchievementId = 4910,
		faction = 2,
		tp = 2,
		oldid = 2017,
		minLvl = 0,
		maxLvl = 0,
	},
	[615] = {
		Name = "Shimmering Expanse",
		Cont = 2,
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
		faction = 2,
		tp = 2,
		oldid = 2035,
		minLvl = 0,
		maxLvl = 0,
	},
	[480] = {
		Name = "Silvermoon City",
		Cont = 2,
		XOff = RDXMAP.BloodelfXO,
		YOff = RDXMAP.BloodelfYO,
		City = true,
		MId = 2011,
		faction = 2,
		tp = 3,
		oldid = 2018,
	},
	[21] = {
		Name = "Silverpine Forest",
		Cont = 2,
		Fish = 75,
		QAchievementIdH = 4894,
		faction = 2,
		tp = 2,
		oldid = 2019,
		minLvl = 10,
		maxLvl = 20,
	},
	[301] = {
		Name = "Stormwind City",
		Cont = 2,
		City = true,
		MMOutside = true,
		Fish = 75,
		faction = 2,
		tp = 3,
		oldid = 2020,
	},
	[689] = {
		Name = "Stranglethorn Vale",	-- Fake parent map?
		Cont = 2,
		Fish = 75,
		faction = 2,
		tp = 2,
		oldid = 2036,
		minLvl = 0,
		maxLvl = 0,
	},
	[893] = {
		Name = "Sunstrider Isle",
		Cont = 2,
		XOff = RDXMAP.BloodelfXO,
		YOff = RDXMAP.BloodelfYO,
		MId = 2011,
		StartZone = true,
		faction = 2,
		tp = 2,
		oldid = 2048,
		minLvl = 0,
		maxLvl = 0,
	},
	[38] = {
		Name = "Swamp of Sorrows",
		Cont = 2,
		Fish = 225,
		QAchievementId = 4904,
		faction = 2,
		tp = 2,
		oldid = 2022,
		minLvl = 0,
		maxLvl = 0,
	},
	[673] = {
		Name = "The Cape of Stranglethorn",
		Cont = 2,
		Fish = 75,
		QAchievementId = 4905,
		faction = 2,
		tp = 2,
		oldid = 2037,
		minLvl = 0,
		maxLvl = 0,
	},
	[26] = {
		Name = "The Hinterlands",
		Cont = 2,
		Fish = 300,
		QAchievementId = 4897,
		faction = 2,
		tp = 2,
		oldid = 2023,
		minLvl = 0,
		maxLvl = 0,
	},
	[502] = {
		Name = "Plaguelands: The Scarlet Enclave",
		Cont = 2,
		XOff = 400,
		YOff = -33,
		City = true,	-- No explored areas
		faction = 2,
		tp = 3,
		oldid = 2030,
		minLvl = 0,
		maxLvl = 0,
	},
	[20] = {
		Name = "Tirisfal Glades",
		Cont = 2,
		Fish = 25,
		faction = 2,
		tp = 2,
		oldid = 2024,
		minLvl = 1,
		maxLvl = 10,
	},
	[708] = {
		Name = "Tol Barad",
		Cont = 2,
		XOff = -600,
		YOff = 320,
		MId = 2038,
		Fish = 75,
		Explored = true,
		faction = 2,
		tp = 2,
		oldid = 2038,
		minLvl = 0,
		maxLvl = 0,
	},
	[709] = {
		Name = "Tol Barad Peninsula",
		Cont = 2,
		XOff = -600,
		YOff = 320,
		MId = 2038,
		Fish = 75,
		Explored = true,
		faction = 2,
		tp = 2,
		oldid = 2039,
		minLvl = 0,
		maxLvl = 0,
	},
	[700] = {
		Name = "Twilight Highlands",
		Cont = 2,
		Fish = 75,
		QAchievementId = 4873,
		QAchievementIdH = 5501,
		faction = 2,
		tp = 2,
		oldid = 2040,
		minLvl = 0,
		maxLvl = 0,
	},
	-- Undercity
	[382] = {
		Name = "Undercity", -- [26]
		Cont = 2,
		1.9187478, -- Scale (0.6672102)
		-174.6383, -375.589, -- Origin (WH 191.8748, 128.0208)
		 -- -246.8386 -1631.841, 65.2877 38.4475
		 -- -241.8082 -1783.917, 65.812 14.6895
		 -- -343.3792 -1804.086, 55.2248 11.5385
		 -- -239.2218 -1836.685, 66.0816 6.4458
		Overlay = "undercity",
		City = true,
		Fish = 75,
		faction = 2,
		tp = 3,
		oldid = 2025,
	},
	[613] = {	-- Need??? Sub continent
		Name = "Vashj'ir",
		Cont = 2,
		Fish = 75,
		faction = 2,
		tp = 2,
		oldid = 2041,
		minLvl = 0,
		maxLvl = 0,
	},
	[22] = {
		Name = "Western Plaguelands",
		Cont = 2,
		Fish = 300,
		QAchievementId = 4893,
		faction = 2,
		tp = 2,
		oldid = 2026,
		minLvl = 35,
		maxLvl = 40,
	},
	[39] = {
		Name = "Westfall",
		Cont = 2,
		Fish = 75,
		QAchievementIdA = 4903,
		faction = 2,
		tp = 2,
		oldid = 2027,
		minLvl = 0,
		maxLvl = 0,
	},
	[40] = {
		Name = "Wetlands",
		Cont = 2,
		Fish = 150,
		QAchievementIdA = 4898,
		faction = 2,
		tp = 2,
		oldid = 2028,
		minLvl = 0,
		maxLvl = 0,
	},
	
	-- Outland

	[466] = {
		class = "w",
		id = 3,
		Name = "Outland",
		34.606,				-- Scale
		-2587.3, -1151.7,	-- Origin
		tp = 1,
		oldid = 3000,
		X = 7000,
		Y = -4000,
		FileName = "Expansion01",
	},
	[475] = {
		Name = "Blade's Edge Mountains", -- [1]
		Cont = 3,
		10.85003, -- Scale (0.666667)
		-1769.168, -881.6678, -- Origin (WH 1085.003, 723.3356)
		 -- -5982.262 -2399.672, 52.7847 55.539
		 -- -4709.442 -2041.002, 76.2468 65.4561
		 -- -4603.104 -2096.445, 78.2069 63.9231
		Overlay = "bladesedgemountains",
		QAchievementId = 1193,
		faction = 2,
		tp = 2,
		oldid = 3001,
		minLvl = 0,
		maxLvl = 0,
	},
	[465] = {
		Name = "Hellfire Peninsula", -- [2]
		Cont = 3,
		10.32915, -- Scale (0.6668043)
		-1107.916, -296.2509, -- Origin (WH 1032.916, 688.7525)
		 -- -4976.093 697.7343, 10.9106 63.2735
		 -- -4605.781 414.6589, 18.0808 55.0536
		 -- -5056.561 188.3606, 9.3525 48.4823
		Overlay = "hellfire",
		Fish = 375,
		QAchievementId = 1189,
		QAchievementIdH = 1271,
		faction = 2,
		tp = 2,
		oldid = 3002,
		minLvl = 0,
		maxLvl = 0,
	},
	[477] = {
		Name = "Nagrand", -- [3]
		Cont = 3,
		11.05005, -- Scale (0.6666639)
		-2059.17, -8.333105, -- Origin (WH 1105.005, 736.6674)
		 -- -6137.744 1568.903, 75.2595 43.7258
		 -- -6389.304 1749.084, 70.7064 48.6176
		 -- -6336.4 1318.156, 71.6639 36.9182
		 -- -6297.564 1158.649, 72.3668 32.5877
		Overlay = "nagrand",
		Fish = 475,
		QAchievementId = 1192,
		QAchievementIdH = 1273,
		faction = 2,
		tp = 2,
		oldid = 3003,
		minLvl = 0,
		maxLvl = 0,
	},
	[479] = {
		Name = "Netherstorm", -- [4]
		Cont = 3,
		11.14996, -- Scale (0.6666698)
		-1096.665, -1091.25, -- Origin (WH 1114.996, 743.3344)
		 -- -4413.899 -2483.77, 19.1826 79.977
		 -- -3666.211 -3010.165, 32.5941 65.8139
		Overlay = "netherstorm",
		Fish = 475,
		QAchievementId = 1194,
		faction = 2,
		tp = 2,
		oldid = 3004,
		minLvl = 0,
		maxLvl = 0,
	},
	--!
	[473] = {
		Name = "Shadowmoon Valley", -- [5]
		Cont = 3,
		11, -- Scale (0.6666666)
		-845.0001, 389.5833, -- Origin (WH 1100, 733.3334)
		 -- -3265.336 3224.464, 17.44844 34.81494
		 -- -2685.753 2841.652, 27.9863 24.3746
		Overlay = "shadowmoonvalley",
		Fish = 375,
		QAchievementId = 1195,
		faction = 2,
		tp = 2,
		oldid = 3005,
		minLvl = 0,
		maxLvl = 0,
	},
	-- Shattrath City
	--!
	[481] = {
		Name = "Shattrath City", -- [6]
		Cont = 3,
		2.6125, -- Scale (0.6666668)
		-1227.052, 294.7909, -- Origin (WH 261.25, 174.1667)
		 -- -5785.705 1864.776, 26.76009 44.87901
		 -- -5098.179 1620.727, 79.39369 16.85428
		Overlay = "shattrathcity",
		City = true,
		MMOutside = true,
		faction = 2,
		tp = 3,
		oldid = 3006,
		minLvl = 0,
		maxLvl = 0,
	},
	--!
	[478] = {
		Name = "Terokkar Forest", -- [7]
		Cont = 3,
		10.8, -- Scale (0.6666667)
		-1416.667, 200, -- Origin (WH 1080, 720)
		 -- -3295.501 3248.513, 70.14504 62.45869
		 -- -5076.772 1600.578, 37.15854 16.68273
		Overlay = "terokkarforest",
		Fish = 450,
		QAchievementId = 1191,
		QAchievementIdH = 1272,
		faction = 2,
		tp = 2,
		oldid = 3007,
		minLvl = 0,
		maxLvl = 0,
	},
	[467] = {
		Name = "Zangarmarsh", -- [8]
		Cont = 3,
		10.05418, -- Scale (0.6668039)
		-1895, -387.0831, -- Origin (WH 1005.418, 670.4165)
		 -- -6286.6 1113.615, 63.4244 90.9593
		 -- -5236.717 810.7363, 84.3089 81.9237
		 -- -5265.634 100.2874, 83.7337 60.7295
		Overlay = "zangarmarsh",
		Fish = 400,
		QAchievementId = 1190,
		faction = 2,
		tp = 2,
		oldid = 3008,
		minLvl = 0,
		maxLvl = 0,
	},

	-- Northrend
	[485] = {
		class = "w",
		id = 4,
		Name = "Northrend",
		35.5,		-- Scale
		0, 0,		-- Origin
		tp = 1,
		oldid = 4000,
		X = 600,
		Y = -4500,
		FileName = "Northrend",
	},
	[486] = {
		Name = "Borean Tundra", -- [1]
		Cont = 4,
		11.521,
		125.764810, 1139.054323, -- Origin (WH 1085.003, 723.3356)
		Overlay = "boreantundra",
		Fish = 475,
		QAchievementId = 33,
		QAchievementIdH = 1358,
		faction = 2,
		tp = 2,
		oldid = 4001,
		minLvl = 0,
		maxLvl = 0,
	},
	[510] = {
		Name = "Crystalsong Forest", -- [2]
		Cont = 4,
		5.4416,
		1550.386409, 817.907816,
		Overlay = "crystalsongforest",
		Fish = 500,
		faction = 2,
		tp = 2,
		oldid = 4002,
		minLvl = 0,
		maxLvl = 0,
	},
	[504] = {	-- Main level
		Name = "Dalaran", -- [3]
		Cont = 4,
		1.6589 / 1.3,
		1629, 861,		--		1580, 1739,
		Overlay = "dalaran",
		MapBaseName = "dalaran1_",
--		NoBackground = true,
		City = true,
		Alpha = .85,
		ScaleAdjust = 1.3,
		Fish = 525,
		--MapLevel = 1,
		--Level2Id = 4014,
		faction = 2,
		tp = 3,
		oldid = 4003,
	},
	--[4014] = {	-- Level 2 (was id 4012)
	--	Name = "Dalaran Underbelly", -- [3]
	--	1.6589 / 1.3,
	--	1629, 861,		--		1580, 1739,
	--	Overlay = "dalaran",
	--	MapBaseName = "dalaran2_",
	--	City = true,
	--	Alpha = .85,
	--	ScaleAdjust = 1.3,
	--	Fish = 525,
	--	MapLevel = 2,
	--	Level1Id = 4003,
	--},
	[488] = {
		Name = "Dragonblight", -- [4]
		Cont = 4,
		11.21,
		1113.94, 1003.78, -- Origin (WH 1085.003, 723.3356)
		Overlay = "dragonblight",
		Fish = 475,
		QAchievementId = 35,
		QAchievementIdH = 1359,
		faction = 2,
		tp = 2,
		oldid = 4004,
		minLvl = 0,
		maxLvl = 0,
	},
	[490] = {
		Name = "Grizzly Hills", -- [5]
		Cont = 4,
		10.5,
		2061.032452, 1015.273026, -- Origin (WH 1085.003, 723.3356)
		Overlay = "grizzlyhills",
		Fish = 475,
		QAchievementId = 37,
		QAchievementIdH = 1357,
		faction = 2,
		tp = 2,
		oldid = 4005,
		minLvl = 0,
		maxLvl = 0,
	},
	[491] = {
		Name = "Howling Fjord", -- [6]
		Cont = 4,
		12.085,
		2119.306683, 1495.527721, -- Origin (WH 1085.003, 723.3356)
		Overlay = "howlingfjord",
		Fish = 475,
		QAchievementId = 34,
		QAchievementIdH = 1356,
		faction = 2,
		tp = 2,
		oldid = 4006,
		minLvl = 0,
		maxLvl = 0,
	},
	[541] = {
		Name = "Hrothgar's Landing",
		Cont = 4,
		7.35,
		1280, -37.5,
		Overlay = "hrothgarslanding",
		Explored = true,
		faction = 2,
		tp = 2,
		oldid = 4013,
		minLvl = 0,
		maxLvl = 0,
	},
	[492] = {
		Name = "Icecrown", -- [7]
		Cont = 4,
		12.533,
		750.941881, 233.475172, -- Origin (WH 1085.003, 723.3356)
		Overlay = "icecrownglacier",
		QAchievementId = 40,
		faction = 2,
		tp = 2,
		oldid = 4007,
		minLvl = 0,
		maxLvl = 0,
	},
	[493] = {
		Name = "Sholazar Basin", -- [8]
		Cont = 4,
		8.7057,
		453.792401, 661.305837,
		Overlay = "sholazarbasin",
		Fish = 525,
		QAchievementId = 39,
		faction = 2,
		tp = 2,
		oldid = 4008,
		minLvl = 0,
		maxLvl = 0,
	},
	[495] = {
		Name = "The Storm Peaks", -- [9]
		Cont = 4,
		14.214,
		1471.175866, 79.244441, -- Origin (WH 1085.003, 723.3356)
		Overlay = "thestormpeaks",
		QAchievementId = 38,
		faction = 2,
		tp = 2,
		oldid = 4009,
		minLvl = 0,
		maxLvl = 0,
	},
	[501] = {
		Name = "Wintergrasp", -- [10]
		Cont = 4,
		5.9455,
		973.388866, 975.227557,
		Overlay = "lakewintergrasp",
		Explored = true,
		faction = 2,
		tp = 2,
		oldid = 4010,
		minLvl = 0,
		maxLvl = 0,
	},
	[496] = {
		Name = "Zul'Drak", -- [11]
		Cont = 4,
		9.98,
		1959.324066, 584.635173, -- Origin (WH 1085.003, 723.3356)
		Overlay = "zuldrak",
		QAchievementId = 36,
		faction = 2,
		tp = 2,
		oldid = 4011,
		minLvl = 0,
		maxLvl = 0,
	},


	-- Lost Isles (Cataclysm)
	[751] = {
		class = "w",
		id = 5,
		Name = "The Maelstrom",
		26,		-- Scale
		0, 0,		-- Origin
		tp = 1,
		oldid = 5000,
		X = 1100,
		Y = -1800, 
		FileName = "TheMaelstromContinent",
	},
	[640] = {
		Name = "Deepholm",
		Cont = 5,
		XOff = 1580,
		YOff = 700,
		QAchievementId = 4871,
		MId = 5001,
		faction = 2,
		tp = 2,
		oldid = 5001,
		minLvl = 0,
		maxLvl = 0,
	},
	[605] = {
		Name = "Kezan",
		Cont = 5,
		XOff = 1256,
		YOff = -542,
		MId = 5002,
		faction = 2,
		tp = 2,
		oldid = 5002,
		minLvl = 0,
		maxLvl = 0,
	},
	[544] = {
		Name = "The Lost Isles",
		Cont = 5,
		XOff = 750,
		YOff = 1150,
		faction = 2,
		tp = 2,
		oldid = 5003,
		minLvl = 0,
		maxLvl = 0,
	},
	[737] = {
		Name = "The Maelstrom",
		Cont = 5,
		XOff = 1000,
		YOff = 600,
		City = true,
		Explored = true,
		faction = 2,
		tp = 2,
		oldid = 5004,
		minLvl = 0,
		maxLvl = 0,
	},	
    --[5005] = { 
	--    Name = "Darkmoon Island",
	--	3.8,
	--	-300, -2750+2400,
	--	Explored = true,
	--	City = true,
	--	MMOutside = true,		
	--	UseAId=true,
	--	MId=5005,
	--	Overlay = "darkmoonfaireisland",
	--},
	
	-- Pandaria
    [862] = {
		class = "w",
		id = 6,
		Name = "Pandaria",
		31.030601,
		-1756.42, 595.44,
		tp = 1,
		oldid = 6000,
		X = 2350,
		Y = 300,
		FileName = "Pandaria",
	},
	[858] = {
		Name="Dread Wastes",
		Cont = 6,
		10.704166,
		-1234.27, 1648.84,
		Overlay = "dreadwastes",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6001,
		minLvl = 0,
		maxLvl = 0,
	},
	[929] = {
		Name = "Isle of Giants",
		Cont = 6,
		3.575001968,
		-400.8334, 600.5832,
		Explored = true,
		Overlay = "isleofgiants",
		faction = 2,
		tp = 2,
		oldid = 6014,
		minLvl = 0,
		maxLvl = 0,
	},
	[928] = {
		Name = "Isle of Thunder",
		Cont = 6,
		8.270832,
		-1535.8332, 514.5832,
		Explored = true,
		Overlay = "isleofthethunderking",
		faction = 2,
		tp = 2,
		oldid = 6015,
		minLvl = 0,
		maxLvl = 0,
	},	
	[857] = {
		Name="Krasarang Wilds",
		Cont = 6,
		9.375002,
		-595.94, 1954.25,
		Overlay = "krasarang",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6002,
		minLvl = 0,
		maxLvl = 0,
	},
	[809] = {
		Name="Kun-Lai Summit",
		Cont = 6,
		12.516666,
		-974.27, 808.42,
		Overlay = "kunlaisummit",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6003,
		minLvl = 0,
		maxLvl = 0,
	},
	[905] = { 
		Name = "Shrine of Seven Stars",
		Cont = 6,
		0.55, 
		-82, 1751, 
		ScaleAdjust=0.9469, 
		City = true, 
		--Level2Id = 6005,
		faction = 2,
		tp = 3,
		oldid = 6004,
		minLvl = 0,
		maxLvl = 0,
	}, 
	--[6013] = { 
	--	Name = "Shrine of Seven Stars",	
	--	0.5,
	--	-217.8, 1573.5,
	--	Alpha=2,	
	--	ScaleAdjust=1.03448,
	--	City = true, 
	--	Level1Id = 6012,
	--},	
    --[6005] = {
	--	Name = "Shrine of Seven Stars L2", 
	--	0.55,
	--	-82, 1751, 
	--	ScaleAdjust=1.14356, 
	--	City = true, 
	--	Level1Id = 6004,
	--},
	 [903] = { 
		Name = "Shrine of Two Moons",
		Cont = 6,
		0.5,
		-217.8, 1573.5,
		Alpha=2,
		ScaleAdjust=0.87584,
		City = true,
		--Level2Id = 6013,
		faction = 2,
		tp = 2,
		oldid = 6012,
		minLvl = 0,
		maxLvl = 0,
	},
    [806] = {
		Name="The Jade Forest",
		Cont = 6,
		13.966666,
		-296.77,1201.75,
		Overlay = "thejadeforest",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6006,
		minLvl = 0,
		maxLvl = 0,
	},
	[873] = {
		Name="The Veiled Stair",
		Cont = 6,
		3.587500,
		-168.85,1594.25,
		Overlay = "thehiddenpass",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6007,
		minLvl = 0,
		maxLvl = 0,
	},
	[808] = {
		Name="The Wandering Isle",
		Cont = 6,
		5.341666015625,
		-500,-200,
		Overlay = "thewanderingisle",
		StartZone = true,
--		City = true,
		MMOutside = true,	
		faction = 2,	
		tp = 2,
		oldid = 6011,
		minLvl = 0,
		maxLvl = 0,
		MId = 6009,
	},
	[951] = {
		Name = "Timeless Isle",
		Cont = 6,
		4.8,
		810.2668,1885.6667968,
		Explored = true,
		Overlay = "timelessisle",
		faction = 2,
		tp = 2,
		oldid = 6016,
		minLvl = 0,
		maxLvl = 0,
	},
	[810] = {
		Name="Townlong Steppes",
		Cont = 6,
		11.487498,
		-1422.19,1020.50,
		Overlay = "townlongwastes",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6008,
		minLvl = 0,
		maxLvl = 0,
	},
	[811] = {
		Name="Vale of Eternal Blossoms",
		Cont = 6,
		5.066668,
		-502.60,1542.59,
		Overlay = "valeofeternalblossoms",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6009,
		MId = 6009,
		minLvl = 0,
		maxLvl = 0,
	},
	[807] = {
		Name="Valley of the Four Winds",
		Cont = 6,
		7.850002,
		-542.19,1713.00,
		Overlay = "valleyofthefourwinds",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6010,
		minLvl = 0,
		maxLvl = 0,
	},
	

	-- Battlegrounds
	
	--[9000] = {
	--	1,				-- Scale
	--	0, 0,			-- Origin
	--},
	[401] = {		-- AV
		Name = "Alterac Valley",
		8.471,		-- Scale
		16000,2000,		-- Origin
		Short = "AV",
		faction = 3,
		tp = 5,
	},
	[461] = {		-- AB
		Name = "Arathi Basin",
		3.508,		-- Scale
		-16000, 0,		-- Origin
		Short = "AB",
		faction = 3,
		tp = 5,
	},
	[482] = {		-- EOS
		Name = "Eye of the Storm",
		4.538,		-- Scale
		-16000,3000,		-- Origin
		Short = "EOS",
		faction = 3,
		tp = 5,
	},
	[540] = {		-- IC
		Name = "Isle of Conquest",
		5.295,
		-14500,1000,
		Short = "IC",
		faction = 3,
		tp = 5,
	},
	[860] = {
		Name = "Silvershard Mines",
		8.0,
		-14500,5000,
		Short = "SSM",
		MapBaseName = "STVDiamondMineBG1_",
		faction = 3,
		tp = 5,
	},
	[512] = {		-- SoA
		Name = "Strand of the Ancients",
		3.486,
		-14500,0,
		Short = "SoA",
		faction = 3,
		tp = 5,
	},
	[856] = {
		Name = "Temple of Kotmogu",
		3.0,
		-14500,4000,
		Short = "TK",
		faction = 3,
		tp = 5,
	},
	[736] = {
		Name = "The Battle for Gilneas",
		3.0,
		-14500,2000,
		Short = "TBG",
		faction = 3,
		tp = 5,
	},
	--[9014] = {
	--	Name = "Tol'vir Proving Grounds",
	--	3.0,
	--	-14500,6000,
	--	Short = "TPG",
	--},
	[626] = {
		Name = "Twin Peaks",
		3.0,
		-14500,3000,
		Short = "TP",
		faction = 3,
		tp = 5,
	},
	[443] = {		-- WG
		Name = "Warsong Gulch",
		2.29,			-- Scale
		-16000,1000,	-- Origin
		Short = "WG",
		faction = 3,
		tp = 5,
	},
	
	
	--[9005] = {		-- Blade's Edge Arena
	--	Name = "Blade's Edge Arena",
	--	1,
	--	-16000,4000,
	--	Short = "BEA",
	--	Arena = true
	--},
	--[9006] = {		-- Nagrand Arena
	--	Name = "Nagrand Arena",
	--	1,
	--	-16000,5000,
	--	Short = "NA",
	--	Arena = true
	--},
	--[9007] = {		-- Ruins of Lordaeron
	--	Name = "Ruins of Lordaeron",
	--	1,
	--	-16000,6000,
	--	Short = "RL",
	--	Arena = true
	--},
	
	-- Instances are created at 11000-14999 (cont * 1000 + 10000 + nxid)
	-- Manual adjustments are added here
	
	--------------------------------
	--[12248] = {
	--	["minLvl"] = 0,
	--	[2] = 55.97,
	--	["EntryMId"] = 301,
	--	[3] = 162.21,
	--	["Name"] = "Deeprun Tram",
	--	["maxLvl"] = 0,
	--},
	[680] = {
		["minLvl"] = 15,
		[2] = 51.9,
		["EntryMId"] = 321,
		[3] = 58.4,
		["Name"] = "Ragefire Chasm",
		["maxLvl"] = 16,
		["faction"] = 3,
		["tp"] = 4,
	},
	[756] = {
		["minLvl"] = 15,
		[2] = 42.56,
		["EntryMId"] = 39,
		[3] = 71.72,
		["Name"] = "The Deadmines",
		["maxLvl"] = 16,
		["faction"] = 3,
		["tp"] = 4,
	},
	[749] = {
		["minLvl"] = 17,
		[2] = 39,
		["EntryMId"] = 11,
		[3] = 69.40000000000001,
		["Name"] = "Wailing Caverns",
		["maxLvl"] = 20,
		["faction"] = 3,
		["tp"] = 4,
	},
	[764] = {
		["minLvl"] = 18,
		[2] = 44.86,
		["EntryMId"] = 21,
		[3] = 67.86,
		["Name"] = "Shadowfang Keep",
		["maxLvl"] = 21,
		["faction"] = 3,
		["tp"] = 4,
	},
	[690] = {
		["minLvl"] = 22,
		[2] = 51.4,
		["EntryMId"] = 301,
		[3] = 68.3,
		["Name"] = "The Stockade",
		["maxLvl"] = 25,
		["faction"] = 3,
		["tp"] = 4,
	},
	[688] = {
		["minLvl"] = 22,
		[2] = 14.15,
		["EntryMId"] = 43,
		[3] = 13.9,
		["Name"] = "Blackfathom Deeps",
		["maxLvl"] = 25,
		["faction"] = 3,
		["tp"] = 4,
	},
	[691] = {
		["minLvl"] = 26,
		[2] = 24.38,
		["EntryMId"] = 27,
		[3] = 39.8,
		["Name"] = "Gnomeregan",
		["maxLvl"] = 29,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[12233] = {
	--	["minLvl"] = 31,
	--	[2] = 85.5,
	--	["EntryMId"] = 20,
	--	[3] = 28.5,
	--	["Name"] = "Scarlet Monastery",
	--	["maxLvl"] = 34,
	--},
	--[12074] = {
	--	["minLvl"] = 31,
	--	[2] = 86.7,
	--	["EntryMId"] = 20,
	--	[3] = 31.6,
	--	["Name"] = "Scarlet Halls",
	--	["maxLvl"] = 34,
	--},
	[761] = {
		["minLvl"] = 32,
		[2] = 42.5,
		["EntryMId"] = 607,
		[3] = 94.8,
		["Name"] = "Razorfen Kraul",
		["maxLvl"] = 35,
		["faction"] = 3,
		["tp"] = 4,
	},
	[750] = {
		["minLvl"] = 36,
		[2] = 29.48,
		["EntryMId"] = 101,
		[3] = 62.53,
		["Name"] = "Maraudon",
		["maxLvl"] = 39,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[12075] = {
	--	["minLvl"] = 40,
	--	[2] = 69.77,
	--	["EntryMId"] = 22,
	--	[3] = 73.51000000000001,
	--	["Name"] = "Scholomance",
	--	["maxLvl"] = 43,
	--},
	[760] = {
		["minLvl"] = 42,
		[2] = 43.2,
		["EntryMId"] = 61,
		[3] = 26.1,
		["Name"] = "Razorfen Downs",
		["maxLvl"] = 45,
		["faction"] = 3,
		["tp"] = 4,
	},
	[699] = {
		["minLvl"] = 44,
		[2] = 59.1,
		["EntryMId"] = 121,
		[3] = 45.4,
		["Name"] = "Dire Maul",
		["maxLvl"] = 47,
		["faction"] = 3,
		["tp"] = 4,
	},
	[686] = {
		["minLvl"] = 46,
		[2] = 39.2,
		["EntryMId"] = 161,
		[3] = 21.4,
		["Name"] = "Zul'Farrak",
		["maxLvl"] = 49,
		["faction"] = 3,
		["tp"] = 4,
	},
	[765] = {
		["minLvl"] = 48,
		[2] = 27.09,
		["EntryMId"] = 23,
		[3] = 12.6,
		["Name"] = "Stratholme",
		["maxLvl"] = 51,
		["faction"] = 3,
		["tp"] = 4,
	},
	[687] = {
		["minLvl"] = 52,
		[2] = 69.83,
		["EntryMId"] = 38,
		[3] = 54.14,
		["Name"] = "The Temple of Atal'Hakkar",
		["maxLvl"] = 55,
		["faction"] = 3,
		["tp"] = 4,
	},
	[704] = {
		["minLvl"] = 53,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.01000000000001,
		["Name"] = "Blackrock Depths",
		["maxLvl"] = 56,
		["faction"] = 3,
		["tp"] = 4,
	},
	[721] = {
		["minLvl"] = 58,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.03,
		["Name"] = "Blackrock Spire",
		["maxLvl"] = 58,
		["faction"] = 3,
		["tp"] = 4,
	},
	[755] = {
		["minLvl"] = 60,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.01000000000001,
		["Name"] = "Blackwing Lair",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
	},
	[766] = {
		["minLvl"] = 60,
		[2] = 47,
		["EntryMId"] = 772,
		[3] = 7.8,
		["Name"] = "Ahn'Qiraj", -- temple
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
	},
	[717] = {
		["minLvl"] = 60,
		[2] = 59.1,
		["EntryMId"] = 772,
		[3] = 14,
		["Name"] = "Ruins of Ahn'Qiraj",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
	},
	[696] = {
		["minLvl"] = 60,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.05000000000001,
		["Name"] = "Molten Core",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
	},
	----------------------------------
	[797] = {
		["minLvl"] = 59,
		[2] = 47.64,
		["EntryMId"] = 465,
		[3] = 53.57,
		["Name"] = "Hellfire Ramparts",
		["maxLvl"] = 62,
		["faction"] = 3,
		["tp"] = 4,
	},
	[725] = {
		["minLvl"] = 61,
		[2] = 46.03,
		["EntryMId"] = 465,
		[3] = 51.78,
		["Name"] = "The Blood Furnace",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
	},
	[728] = {
		["minLvl"] = 62,
		[2] = 50.37,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "The Slave Pens",
		["maxLvl"] = 64,
		["faction"] = 3,
		["tp"] = 4,
	},
	[726] = {
		["minLvl"] = 63,
		[2] = 50.43,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "The Underbog",
		["maxLvl"] = 65,
		["faction"] = 3,
		["tp"] = 4,
	},
	[732] = {
		["minLvl"] = 64,
		[2] = 39.63,
		["EntryMId"] = 478,
		[3] = 62.06,
		["Name"] = "Mana-Tombs",
		["maxLvl"] = 66,
		["faction"] = 3,
		["tp"] = 4,
	},
	[722] = {
		["minLvl"] = 65,
		[2] = 37.3,
		["EntryMId"] = 478,
		[3] = 65.61,
		["Name"] = "Auchenai Crypts",
		["maxLvl"] = 67,
		["faction"] = 3,
		["tp"] = 4,
	},
	[734] = {
		["minLvl"] = 66,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50.02,
		["Name"] = "Old Hillsbrad Foothills",
		["maxLvl"] = 68,
		["faction"] = 3,
		["tp"] = 4,
	},
	[723] = {
		["minLvl"] = 67,
		[2] = 41.98,
		["EntryMId"] = 478,
		[3] = 65.62000000000001,
		["Name"] = "Sethekk Halls",
		["maxLvl"] = 68,
		["faction"] = 3,
		["tp"] = 4,
	},
	[724] = {
		["minLvl"] = 67,
		[2] = 39.63,
		["EntryMId"] = 478,
		[3] = 69.13,
		["Name"] = "Shadow Labyrinth",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[729] = {
		["minLvl"] = 67,
		[2] = 71.7,
		["EntryMId"] = 479,
		[3] = 55.07,
		["Name"] = "The Botanica",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[710] = {
		["minLvl"] = 67,
		[2] = 48.02,
		["EntryMId"] = 465,
		[3] = 51.88,
		["Name"] = "The Shattered Halls",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[727] = {
		["minLvl"] = 67,
		[2] = 50.38999999999999,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "The Steamvault",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[730] = {
		["minLvl"] = 67,
		[2] = 70.54000000000001,
		["EntryMId"] = 479,
		[3] = 69.64,
		["Name"] = "The Mechanar",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[733] = {
		["minLvl"] = 68,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50.04,
		["Name"] = "The Black Morass",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[798] = {
		["minLvl"] = 68,
		[2] = 61.18,
		["EntryMId"] = 499,
		[3] = 30.83,
		["Name"] = "Magisters' Terrace",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[731] = {
		["minLvl"] = 68,
		[2] = 74.37000000000001,
		["EntryMId"] = 479,
		[3] = 57.75,
		["Name"] = "The Arcatraz",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	
	[796] = {
		["minLvl"] = 70,
		[2] = 71.03,
		["EntryMId"] = 473,
		[3] = 46.33,
		["Name"] = "Black Temple",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	[780] = {
		["minLvl"] = 70,
		[2] = 50.41,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "Serpentshrine Cavern",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	[776] = {
		["minLvl"] = 70,
		[2] = 68.20999999999999,
		["EntryMId"] = 475,
		[3] = 24.37,
		["Name"] = "Gruul's Lair",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	[779] = {
		["minLvl"] = 70,
		[2] = 46.63,
		["EntryMId"] = 465,
		[3] = 52.78,
		["Name"] = "Magtheridon's Lair",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	[775] = {
		["minLvl"] = 70,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50,
		["Name"] = "Hyjal Summit",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	[789] = {
		["minLvl"] = 70,
		[2] = 44.27,
		["EntryMId"] = 499,
		[3] = 45.65,
		["Name"] = "Sunwell Plateau",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	[799] = {
		["minLvl"] = 70,
		[2] = 47,
		["EntryMId"] = 32,
		[3] = 74.94,
		["Name"] = "Karazhan",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[13093] = {
	--	["minLvl"] = 70,
	--	[2] = 73.62000000000001,
	--	["EntryMId"] = 479,
	--	[3] = 63.73,
	--	["Name"] = "Tempest Keep",
	--	["maxLvl"] = 73,
	--},
	
	
	----------------------------------------
	[523] = {
		["minLvl"] = 69,
		[2] = 57.28,
		["EntryMId"] = 491,
		[3] = 46.72,
		["Name"] = "Utgarde Keep",
		["maxLvl"] = 72,
		["faction"] = 3,
		["tp"] = 4,
	},
	[520] = {
		["minLvl"] = 71,
		[2] = 27.5,
		["EntryMId"] = 486,
		[3] = 26.03,
		["Name"] = "The Nexus",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
	},
	[533] = {
		["minLvl"] = 72,
		[2] = 26.01,
		["EntryMId"] = 488,
		[3] = 50.83,
		["Name"] = "Azjol-Nerub",
		["maxLvl"] = 74,
		["faction"] = 3,
		["tp"] = 4,
	},
	[522] = {
		["minLvl"] = 73,
		[2] = 28.46,
		["EntryMId"] = 488,
		[3] = 51.71,
		["Name"] = "Ahn'kahet: The Old Kingdom",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
	},
	[534] = {
		["minLvl"] = 74,
		[2] = 17.43,
		["EntryMId"] = 490,
		[3] = 21.21,
		["Name"] = "Drak'Tharon Keep",
		["maxLvl"] = 76,
		["faction"] = 3,
		["tp"] = 4,
	},
	[536] = {
		["minLvl"] = 75,
		[2] = 67,
		["EntryMId"] = 504,
		[3] = 68.40000000000001,
		["Name"] = "The Violet Hold",
		["maxLvl"] = 77,
		["faction"] = 3,
		["tp"] = 4,
	},
	[530] = {
		["minLvl"] = 76,
		[2] = 83.59999999999999,
		["EntryMId"] = 496,
		[3] = 18,
		["Name"] = "Gundrak",
		["maxLvl"] = 78,
		["faction"] = 3,
		["tp"] = 4,
	},
	[526] = {
		["minLvl"] = 77,
		[2] = 39.5,
		["EntryMId"] = 495,
		[3] = 26.9,
		["Name"] = "Halls of Stone",
		["maxLvl"] = 78,
		["faction"] = 3,
		["tp"] = 4,
	},
	[542] = {
		["minLvl"] = 78,
		[2] = 74.2,
		["EntryMId"] = 492,
		[3] = 20.4,
		["Name"] = "Trial of the Champion",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
	},
	[525] = {
		["minLvl"] = 79,
		[2] = 45.4,
		["EntryMId"] = 495,
		[3] = 21.4,
		["Name"] = "Halls of Lightning",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
	},
	[521] = {
		["minLvl"] = 79,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50.06,
		["Name"] = "The Culling of Stratholme",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
	},
	[528] = {
		["minLvl"] = 79,
		[2] = 27.52,
		["EntryMId"] = 486,
		[3] = 26.75,
		["Name"] = "The Oculus",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
	},
	[524] = {
		["minLvl"] = 79,
		[2] = 57.28,
		["EntryMId"] = 491,
		[3] = 46.75,
		["Name"] = "Utgarde Pinnacle",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
	},
	[543] = {
		["minLvl"] = 80,
		[2] = 75.09999999999999,
		["EntryMId"] = 492,
		[3] = 21.8,
		["Name"] = "Trial of the Crusader",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[527] = {
		["minLvl"] = 80,
		[2] = 27.5,
		["EntryMId"] = 486,
		[3] = 26.03,
		["Name"] = "The Eye of Eternity",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[531] = {
		["minLvl"] = 80,
		[2] = 59.8,
		["EntryMId"] = 488,
		[3] = 54.1,
		["Name"] = "The Obsidian Sanctum",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[718] = {
		["minLvl"] = 80,
		[2] = 52.41,
		["EntryMId"] = 141,
		[3] = 76.39,
		["Name"] = "Onyxia's Lair",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[532] = {
		["minLvl"] = 80,
		[2] = 50,
		["EntryMId"] = 501,
		[3] = 18,
		["Name"] = "Vault of Archavon",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[604] = {
		["minLvl"] = 80,
		[2] = 53.3,
		["EntryMId"] = 492,
		[3] = 85.59999999999999,
		["Name"] = "Icecrown Citadel",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[602] = {
		["minLvl"] = 80,
		[2] = 54.5,
		["EntryMId"] = 492,
		[3] = 91.3,
		["Name"] = "Pit of Saron",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
	},
	[609] = {
		["minLvl"] = 80,
		[2] = 0,
		["EntryMId"] = 488,
		[3] = 0,
		["Name"] = "The Ruby Sanctum",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[601] = {
		["minLvl"] = 80,
		[2] = 54.5,
		["EntryMId"] = 492,
		[3] = 90.2,
		["Name"] = "The Forge of Souls",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
	},
	[603] = {
		["minLvl"] = 80,
		[2] = 54.8,
		["EntryMId"] = 492,
		[3] = 90.8,
		["Name"] = "Halls of Reflection",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
	},
	[529] = {
		["minLvl"] = 80,
		[2] = 41.6,
		["EntryMId"] = 495,
		[3] = 18.2,
		["Name"] = "Ulduar",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	
	-----------------------------------------------
	[753] = {
		["minLvl"] = 80,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.06999999999999,
		["Name"] = "Blackrock Caverns",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[767] = {
		["minLvl"] = 80,
		[2] = 70.7,
		["EntryMId"] = 614,
		[3] = 29,
		["Name"] = "Throne of the Tides",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	[768] = {
		["minLvl"] = 81,
		[2] = 47,
		["EntryMId"] = 640,
		[3] = 52.2,
		["Name"] = "The Stonecore",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[769] = {
		["minLvl"] = 81,
		[2] = 76.7,
		["EntryMId"] = 720,
		[3] = 84.40000000000001,
		["Name"] = "The Vortex Pinnacle",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[757] = {
		["minLvl"] = 84,
		[2] = 19.2,
		["EntryMId"] = 700,
		[3] = 54.1,
		["Name"] = "Grim Batol",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[759] = {
		["minLvl"] = 84,
		[2] = 71.8,
		["EntryMId"] = 720,
		[3] = 52.2,
		["Name"] = "Halls of Origination",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[793] = {
		["minLvl"] = 85,
		[2] = 67.2,
		["EntryMId"] = 37,
		[3] = 32.8,
		["Name"] = "Zul'Gurub",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[752] = {
		["minLvl"] = 85,
		[2] = 51,
		["EntryMId"] = 708,
		[3] = 50,
		["Name"] = "Baradin Hold",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[747] = {
		["minLvl"] = 85,
		[2] = 60.5,
		["EntryMId"] = 720,
		[3] = 64.09999999999999,
		["Name"] = "Lost City of the Tol'vir",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[754] = {
		["minLvl"] = 85,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.09,
		["Name"] = "Blackwing Descent",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[758] = {
		["minLvl"] = 85,
		[2] = 33.9,
		["EntryMId"] = 700,
		[3] = 78,
		["Name"] = "The Bastion of Twilight",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[781] = {
		["minLvl"] = 85,
		[2] = 81.51000000000001,
		["EntryMId"] = 463,
		[3] = 64.34,
		["Name"] = "Zul'Aman",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[800] = {
		["minLvl"] = 85,
		[2] = 46.2,
		["EntryMId"] = 606,
		[3] = 78.8,
		["Name"] = "Firelands",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[820] = {
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50,
		["Name"] = "End Time",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[816] = {
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50.02,
		["Name"] = "Well of Eternity",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[819] = {
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50.04,
		["Name"] = "Hour of Twilight",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[824] = {
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50.06,
		["Name"] = "Dragon Soul",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	[773] = {
		["minLvl"] = 85,
		[2] = 38.4,
		["EntryMId"] = 720,
		[3] = 80.59999999999999,
		["Name"] = "Throne of the Four Winds",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
	},
	
	-----------------------------------------------
	[876] = {
		["minLvl"] = 86,
		[2] = 39.1,
		["EntryMId"] = 807,
		[3] = 67.75,
		["Name"] = "Stormstout Brewery",
		["maxLvl"] = 87,
		["faction"] = 3,
		["tp"] = 4,
	},
	[867] = {
		["minLvl"] = 87,
		[2] = 55.88,
		["EntryMId"] = 806,
		[3] = 55.64,
		["Name"] = "Temple of the Jade Serpent",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	[885] = {
		["minLvl"] = 87,
		[2] = 74.2,
		["EntryMId"] = 811,
		[3] = 42.6,
		["Name"] = "Mogu'shan Palace",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	[877] = {
		["minLvl"] = 87,
		[2] = 36,
		["EntryMId"] = 809,
		[3] = 49.2,
		["Name"] = "Shado-Pan Monastery",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[11232] = {
	--	["minLvl"] = 90,
	--	[2] = 55.9,
	--	["EntryMId"] = 141,
	--	[3] = 49.5,
	--	["Name"] = "Battle of Theramore",
	--	["maxLvl"] = 90,
	--},
	[875] = {
		["minLvl"] = 90,
		[2] = 14,
		["EntryMId"] = 811,
		[3] = 75.42,
		["Name"] = "Gate of the Setting Sun",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	[896] = {
		["minLvl"] = 90,
		[2] = 74.5,
		["EntryMId"] = 809,
		[3] = 40.6,
		["Name"] = "Mogu'shan Vaults",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	[886] = {
		["minLvl"] = 90,
		[2] = 49.3,
		["EntryMId"] = 873,
		[3] = 61.1,
		["Name"] = "Terrace of Endless Spring",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[16234] = {
	--	["minLvl"] = 90,
	--	[2] = 37.79,
	--	["EntryMId"] = 806,
	--	[3] = 30.4,
	--	["Name"] = "A Brewing Storm",
	--	["maxLvl"] = 90,
	--},
	--[16235] = {
	--	["minLvl"] = 90,
	--	[2] = 25.1,
	--	["EntryMId"] = 811,
	--	[3] = 26.4,
	--	["Name"] = "Crypt of Forgotten Kings",
	--	["maxLvl"] = 90,
	--},
	--[16236] = {
	--	["minLvl"] = 90,
	--	[2] = 52,
	--	["EntryMId"] = 806,
	--	[3] = 68.40000000000001,
	--	["Name"] = "Greenstone Village",
	--	["maxLvl"] = 90,
	--},
	--[16237] = {
	--	["minLvl"] = 90,
	--	[2] = 52,
	--	["EntryMId"] = 857,
	--	[3] = 76.40000000000001,
	--	["Name"] = "Unga Ingoo",
	--	["maxLvl"] = 90,
	--},
	--[[[16238] = {
		["minLvl"] = 90,
		[2] = 72.59,
		["EntryMId"] = 809,
		[3] = 93,
		["Name"] = "Brewmoon Festival",
		["maxLvl"] = 90,
	},
	[16239] = {
		["minLvl"] = 90,
		[2] = 68.59,
		["EntryMId"] = 809,
		[3] = 48.4,
		["Name"] = "Arena of Annihilation",
		["maxLvl"] = 90,
	},
	[16242] = {
		["minLvl"] = 90,
		[2] = 55.9,
		["EntryMId"] = 857,
		[3] = 49.5,
		["Name"] = "Assault on Zan'vess",
		["maxLvl"] = 90,
	},
	[16243] = {
		["minLvl"] = 90,
		[2] = 55.9,
		["EntryMId"] = 857,
		[3] = 49.5,
		["Name"] = "A Little Patience",
		["maxLvl"] = 90,
	},
	[16244] = {
		["minLvl"] = 90,
		[2] = 55.91,
		["EntryMId"] = 857,
		[3] = 148.95,
		["Name"] = "Dagger In The Dark",
		["maxLvl"] = 90,
	},
	[16245] = {
		["minLvl"] = 90,
		[2] = 55.93,
		["EntryMId"] = 857,
		[3] = 153.37,
		["Name"] = "Lion's Landing",
		["maxLvl"] = 90,
	},
	[16246] = {
		["minLvl"] = 90,
		[2] = 155.39,
		["EntryMId"] = 857,
		[3] = 49.5,
		["Name"] = "Domination Point",
		["maxLvl"] = 90,
	},]]
	[930] = {
		["minLvl"] = 90,
		[2] = 55.97,
		["EntryMId"] = 928,
		[3] = 162.21,
		["Name"] = "Throne of Thunder",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[16252] = {
	--	["minLvl"] = 90,
	--	[2] = 55.97,
	--	["EntryMId"] = 928,
	--	[3] = 162.21,
	--	["Name"] = "Thunder King's Citadel",
	--	["maxLvl"] = 90,
	--},
	--[16253] = {
	--	["minLvl"] = 90,
	--	[2] = 55.97,
	--	["EntryMId"] = 928,
	--	[3] = 162.21,
	--	["Name"] = "Isle of Thunder Scenario",
	--	["maxLvl"] = 90,
	--},
	[897] = {
		["minLvl"] = 90,
		[2] = 34.7,
		["EntryMId"] = 585,
		[3] = 41.1,
		["Name"] = "Heart of Fear",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[11231] = {
	--	["minLvl"] = 90,
	--	[2] = 55.9,
	--	["EntryMId"] = 141,
	--	[3] = 49.5,
	--	["Name"] = "Battle of Theramore",
	--	["maxLvl"] = 90,
	--},
	
	
	[535] = {
		["minLvl"] = 80,
		[2] = 87.3,
		["EntryMId"] = 488,
		[3] = 50.98,
		["Name"] = "Naxxramas",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
	},
	
	[887] = {
		["minLvl"] = 90,
		[2] = 38.1,
		["EntryMId"] = 810,
		[3] = 62.16,
		["Name"] = "Siege of Niuzao Temple",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
	},
	--[13247] = {
	--	["minLvl"] = "90",
	--	[2] = 55.97,
	--	["EntryMId"] = "Shadowmoon Valley",
	--	[3] = 162.21,
	--	["Name"] = "Black Temple",
	--	["maxLvl"] = "90",
	--},
	

	[692] = {
		["minLvl"] = 37,
		[2] = 44.44,
		["EntryMId"] = 17,
		[3] = 12.19,
		["Name"] = "Uldaman",
		["maxLvl"] = "40",
		["faction"] = 3,
		["tp"] = 4,
	},
}

RDXMAP.MapGenAreas = {	-- Auto gen by ConvertMapData()
	[4] = {
		10.57499926758, -- [1]
		392.499975586, -- [2]
		-361.66665039, -- [3]
		"durotar", -- [4]
	},
	[9] = {
		10.89999951172, -- [1]
		-440.833300782, -- [2]
		33.75, -- [3]
		"mulgore", -- [4]
	},
	[11] = {
		11.491666656494, -- [1]
		-40.4166656494, -- [2]
		-362.083325196, -- [3]
		"barrens", -- [4]
	},
	[16] = {
		6.95416650392, -- [1]
		225.41665039, -- [2]
		28.3333312988, -- [3]
		"arathi", -- [4]
	},
	[17] = {
		6.14166650392, -- [1]
		380.41665039, -- [2]
		1170.833300782, -- [3]
		"badlands", -- [4]
	},
	[19] = {
		7.325, -- [1]
		238.75, -- [2]
		2116.66660156, -- [3]
		"blastedlands", -- [4]
	},
	[20] = {
		9.037499755860001, -- [1]
		-606.66665039, -- [2]
		-767.499951172, -- [3]
		"tirisfal", -- [4]
	},
	[21] = {
		8.399999511719999, -- [1]
		-689.999951172, -- [2]
		-333.333325196, -- [3]
		"silverpine", -- [4]
	},
	[22] = {
		8.599999816887999, -- [1]
		-83.33333129880001, -- [2]
		-673.3333007819999, -- [3]
		"westernplaguelands", -- [4]
	},
	[23] = {
		8.0625, -- [1]
		457.5, -- [2]
		-740.8333007819999, -- [3]
		"easternplaguelands", -- [4]
	},
	[24] = {
		9.724999755860001, -- [1]
		-369.999975586, -- [2]
		-296.25, -- [3]
		"hillsbradfoothills", -- [4]
	},
	[26] = {
		7.7, -- [1]
		315, -- [2]
		-293.333325196, -- [3]
		"hinterlands", -- [4]
	},
	[27] = {
		9.795833007819999, -- [1]
		-427.5, -- [2]
		788.3333007819999, -- [3]
		"dunmorogh", -- [4]
	},
	[28] = {
		4.462499694831999, -- [1]
		64.58333129880001, -- [2]
		1220, -- [3]
		"searinggorge", -- [4]
	},
	[29] = {
		6.304166381844, -- [1]
		92.9166625976, -- [2]
		1397.083300782, -- [3]
		"burningsteppes", -- [4]
	},
	[30] = {
		6.94166650392, -- [1]
		-307.083325196, -- [2]
		1587.916601562, -- [3]
		"elwynn", -- [4]
	},
	[32] = {
		4.999999877923999, -- [1]
		166.6666625976, -- [2]
		1973.333203126, -- [3]
		"deadwindpass", -- [4]
	},
	[34] = {
		5.399999877936, -- [1]
		-166.6666625976, -- [2]
		1943.333203126, -- [3]
		"duskwood", -- [4]
	},
	[35] = {
		5.51666625976, -- [1]
		398.749975586, -- [2]
		897.5, -- [3]
		"lochmodan", -- [4]
	},
	[36] = {
		5.13749975586, -- [1]
		295.833325196, -- [2]
		1702.916601562, -- [3]
		"redridge", -- [4]
	},
	[37] = {
		8.19999975586, -- [1]
		-348.749975586, -- [2]
		2203.33320312, -- [3]
		"stranglethornjungle", -- [4]
	},
	[38] = {
		5.016666015619999, -- [1]
		416.25, -- [2]
		1907.083203126, -- [3]
		"swampofsorrows", -- [4]
	},
	[39] = {
		6.999999633796, -- [1]
		-603.3333007819999, -- [2]
		1880, -- [3]
		"westfall", -- [4]
	},
	[40] = {
		8.270833374023999, -- [1]
		77.9166625976, -- [2]
		429.583300782, -- [3]
		"wetlands", -- [4]
	},
	[41] = {
		11.74999951172, -- [1]
		-847.0833007819999, -- [2]
		-2369.58320312, -- [3]
		"teldrassil", -- [4]
	},
	[42] = {
		12.92916601564, -- [1]
		-603.3333007819999, -- [2]
		-1644.583203126, -- [3]
		"darkshore", -- [4]
	},
	[43] = {
		11.53333276368, -- [1]
		-339.999975586, -- [2]
		-934.5833007819999, -- [3]
		"ashenvale", -- [4]
	},
	[61] = {
		8.799999389643999, -- [1]
		86.6666625976, -- [2]
		793.3333007819999, -- [3]
		"thousandneedles", -- [4]
	},
	[81] = {
		11.79999975586, -- [1]
		-780.41665039, -- [2]
		-680.8333007819999, -- [3]
		"stonetalonmountains", -- [4]
	},
	[101] = {
		8.99166601562, -- [1]
		-846.666601562, -- [2]
		-90.4166625976, -- [3]
		"desolace", -- [4]
	},
	[121] = {
		13.89999951172, -- [1]
		-1088.333300782, -- [2]
		473.333300782, -- [3]
		"feralas", -- [4]
	},
	[141] = {
		10.5, -- [1]
		195, -- [2]
		406.666796876, -- [3]
		"dustwallow", -- [4]
	},
	[161] = {
		14.4249990310694, -- [1]
		12.49999923706, -- [2]
		1154.166601562, -- [3]
		"tanaris", -- [4]
	},
	[181] = {
		11.02916699218, -- [1]
		674.5833007819999, -- [2]
		-1076.25, -- [3]
		"aszhara", -- [4]
	},
	[182] = {
		12.12499926758, -- [1]
		-359.583325196, -- [2]
		-1447.499902344, -- [3]
		"felwood", -- [4]
	},
	[201] = {
		7.399999633796, -- [1]
		-106.6666625976, -- [2]
		1193.333300782, -- [3]
		"ungorocrater", -- [4]
	},
	[241] = {
		4.6166665039, -- [1]
		276.25, -- [2]
		-1698.333203126, -- [3]
		"moonglade", -- [4]
	},
	[261] = {
		8.116666503899999, -- [1]
		-596.66665039, -- [2]
		1174.583300782, -- [3]
		"silithus", -- [4]
	},
	[281] = {
		12.299999755866, -- [1]
		198.3333251954, -- [2]
		-1758.75, -- [3]
		"winterspring", -- [4]
	},
	[301] = {
		3.4749999179908, -- [1]
		-344.583325196, -- [2]
		1599.166601562, -- [3]
		"stormwindcity", -- [4]
	},
	[321] = {
		3.47875, -- [1]
		701.2708007819999, -- [2]
		-497.33334961, -- [3]
		"orgrimmar", -- [4]
	},
	[341] = {
		1.581250122062, -- [1]
		142.7182739258, -- [2]
		913.8482421880001, -- [3]
		"ironforge", -- [4]
	},
	[362] = {
		2.08749987793, -- [1]
		-103.3333251954, -- [2]
		169.999987793, -- [3]
		"thunderbluff", -- [4]
	},
	[381] = {
		3.07916674804, -- [1]
		-637.5, -- [2]
		-2092.91660156, -- [3]
		"darnassus", -- [4]
	},
	[382] = {
		1.918750061035, -- [1]
		-174.6385253906, -- [2]
		-375.5890625, -- [3]
		"undercity", -- [4]
	},
	[462] = {
		9.85, -- [1]
		897.5, -- [2]
		-2208.33320312, -- [3]
		"eversongwoods", -- [4]
	},
	[463] = {
		6.600000000000001, -- [1]
		1056.666601562, -- [2]
		-1653.333203126, -- [3]
		"ghostlands", -- [4]
	},
	[464] = {
		8.1416660156, -- [1]
		2100, -- [2]
		558.75, -- [3]
		"azuremystisle", -- [4]
	},
	[465] = {
		10.32916601562, -- [1]
		-1107.916601562, -- [2]
		-296.25, -- [3]
		"hellfire", -- [4]
	},
	[467] = {
		10.05416699218, -- [1]
		-1895, -- [2]
		-387.083325196, -- [3]
		"zangarmarsh", -- [4]
	},
	[471] = {
		2.1135410156, -- [1]
		2213.2734375, -- [2]
		721.936669922, -- [3]
		"theexodar", -- [4]
	},
	[473] = {
		11, -- [1]
		-845, -- [2]
		389.583325196, -- [3]
		"shadowmoonvalley", -- [4]
	},
	[475] = {
		10.84999951172, -- [1]
		-1769.166601562, -- [2]
		-881.666601562, -- [3]
		"bladesedgemountains", -- [4]
	},
	[476] = {
		6.5249980468, -- [1]
		2015, -- [2]
		151.6666625976, -- [3]
		"bloodmystisle", -- [4]
	},
	[477] = {
		11.04999999998, -- [1]
		-2059.16660156, -- [2]
		-8.333332824699999, -- [3]
		"nagrand", -- [4]
	},
	[478] = {
		10.79999951172, -- [1]
		-1416.666601562, -- [2]
		199.999987793, -- [3]
		"terokkarforest", -- [4]
	},
	[479] = {
		11.149999343867, -- [1]
		-1096.666601562, -- [2]
		-1091.25, -- [3]
		"netherstorm", -- [4]
	},
	[480] = {
		2.42291699218, -- [1]
		1280.15, -- [2]
		-2030.74179688, -- [3]
		"silvermooncity", -- [4]
	},
	[481] = {
		2.6125, -- [1]
		-1227.051757812, -- [2]
		294.790893554, -- [3]
		"shattrathcity", -- [4]
	},
	[486] = {
		11.52916601562, -- [1]
		---1714.166601562, -- [2]
		---979.5833007819999, -- [3]
		125.764810, 1139.054323,
		--125,
		--,
		"boreantundra", -- [4]
	},
	[488] = {
		11.21666625976, -- [1]
		---725.41665039, -- [2]
		---1115, -- [3]
		1113.94, 1003.78,
		"dragonblight", -- [4]
	},
	[490] = {
		10.49999975586, -- [1]
		--222.083325196, -- [2]
		---1103.333300782, -- [3]
		2061.032452, 1015.273026,
		"grizzlyhills", -- [4]
	},
	[491] = {
		12.09166577148, -- [1]
		--279.583325196, -- [2]
		---623.3333007819999, -- [3]
		2119.306683, 1495.527721,
		"howlingfjord", -- [4]
	},
	[492] = {
		12.541666625976, -- [1]
		---1088.75, -- [2]
		---1885.416601562, -- [3]
		750.941881, 233.475172,
		"icecrownglacier", -- [4]
	},
	[493] = {
		8.7125, -- [1]
		---1385.833300782, -- [2]
		---1457.499902344, -- [3]
		453.792401, 661.305837,
		"sholazarbasin", -- [4]
	},
	[495] = {
		14.22499926758, -- [1]
		---368.333325196, -- [2]
		---2039.58320312, -- [3]
		1471.175866, 79.244441,
		"thestormpeaks", -- [4]
	},
	[496] = {
		9.987500000000001, -- [1]
		--120, -- [2]
		---1533.749902344, -- [3]
		1959.324066, 584.635173,
		"zuldrak", -- [4]
	},
	[501] = {
		5.94999975586, -- [1]
		---865.8333007819999, -- [2]
		---1143.333300782, -- [3]
		973.388866, 975.227557,
		"lakewintergrasp", -- [4]
	},
	[502] = {
		6.325, -- [1]
		809.5833007819999, -- [2]
		-617.5, -- [3]
		"scarletenclave", -- [4]
	},
	[510] = {
		5.44583325196, -- [1]
		---288.75, -- [2]
		---1300.416601562, -- [3]
		1550.386409, 817.907816,
		"crystalsongforest", -- [4]
	},
	[541] = {
		7.354166259774, -- [1]
		-559.5833007819999, -- [2]
		-2156.25, -- [3]
		"hrothgarslanding", -- [4]
	},
	[544] = {
		9.02916601562, -- [1]
		-876.666601562, -- [2]
		-576.25, -- [3]
		"thelostisles_terrain2", -- [4]
	},
	[545] = {
		6.2916665039, -- [1]
		-687.91665039, -- [2]
		106.6666625976, -- [3]
		"gilneas_terrain2", -- [4]
	},
	[605] = {
		2.704166381844, -- [1]
		-425.833300782, -- [2]
		1546.249902344, -- [3]
		"kezan", -- [4]
	},
	[606] = {
		8.491666748046001, -- [1]
		185.8333251954, -- [2]
		-1239.166601562, -- [3]
		"hyjal_terrain1", -- [4]
	},
	[607] = {
		14.825, -- [1]
		-271.25, -- [2]
		-40.8333312988, -- [3]
		"southernbarrens", -- [4]
	},
	[610] = {
		5.60416601562, -- [1]
		-1014.166601562, -- [2]
		803.749951172, -- [3]
		"vashjirkelpforest", -- [4]
	},
	[611] = {
		1.7791665039, -- [1]
		-386.66665039, -- [2]
		261.25, -- [3]
		"gilneascity", -- [4]
	},
	[615] = {
		9.699999267579999, -- [1]
		-1336.249902344, -- [2]
		951.25, -- [3]
		"vashjirruins", -- [4]
	},
	[613] = {
		13.89166552736, -- [1]
		-1750.833203126, -- [2]
		744.16665039, -- [3]
		"vashjir", -- [4]
	},
	[614] = {
		8.150000000000002, -- [1]
		-1646.666601562, -- [2]
		981.25, -- [3]
		"vashjirdepths", -- [4]
	},
	[640] = {
		10.19999975586, -- [1]
		-610.41665039, -- [2]
		-559.16665039, -- [3]
		"deepholm", -- [4]
	},
	[673] = {
		7.89166625976, -- [1]
		-421.66665039, -- [2]
		2503.33320312, -- [3]
		"thecapeofstranglethorn", -- [4]
	},
	[684] = {
		6.2916665039, -- [1]
		-687.91665039, -- [2]
		106.6666625976, -- [3]
		"ruinsofgilneas", -- [4]
	},
	[685] = {
		1.7791665039, -- [1]
		-386.66665039, -- [2]
		261.25, -- [3]
		"ruinsofgilneascity", -- [4]
	},
	[689] = {
		13.10416601562, -- [1]
		-595.41665039, -- [2]
		2192.91660156, -- [3]
		"stranglethornvale", -- [4]
	},
	[700] = {
		10.54166601562, -- [1]
		487.5, -- [2]
		431.25, -- [3]
		"twilighthighlands_terrain1", -- [4]
	},
	[708] = {
		4.02916658497544, -- [1]
		-402.083325196, -- [2]
		112.0833251954, -- [3]
		"tolbarad", -- [4]
	},
	[709] = {
		3.675, -- [1]
		-482.5, -- [2]
		-75.4166625976, -- [3]
		"tolbaraddailyarea", -- [4]
	},
	[720] = {
		12.38749951172, -- [1]
		-488.333300782, -- [2]
		1605.833300782, -- [3]
		"uldum_terrain1", -- [4]
	},
	[737] = {
		3.1, -- [1]
		-311.25, -- [2]
		-274.16665039, -- [3]
		"themaelstrom", -- [4]
	},
	[772] = {
		8.099999664314, -- [1]
		-778.3333007819999, -- [2]
		1606.666601562, -- [3]
		"ahnqirajthefallenkingdom", -- [4]
	},
	[795] = {
		2.379166625976, -- [1]
		-186.6666625976, -- [2]
		-340.41665039, -- [3]
		"moltenfront", -- [4]
	},
	[864] = {
		1.9375, -- [1]
		-37.5, -- [2]
		1714.16640625, -- [3]
		"northshire", -- [4]
	},
	[866] = {
		1.929166015626, -- [1]
		-195.8333984376, -- [2]
		1192.5, -- [3]
		"coldridgevalley", -- [4]
	},
	[888] = {
		2.90000195313, -- [1]
		-298.333398438, -- [2]
		-2206.66660156, -- [3]
		"shadowglenstart", -- [4]
	},	
	[889] = {
		2.700000000000001, -- [1]
		728.3332031259999, -- [2]
		-0, -- [3]
		"valleyoftrialsstart", -- [4]
	},
	[890] = {
		3.53333593751, -- [1]
		-46.666796875, -- [2]
		515.416796876, -- [3]
		"campnarachestart", -- [4]
	},
	[891] = {
		3.6125, -- [1]
		898.3332031260001, -- [2]
		105, -- [3]
		"echoislesstart", -- [4]
	},
	[892] = {
		2.17916796876, -- [1]
		-429.583398438, -- [2]
		-454.166601562, -- [3]
		"deathknellstart", -- [4]
	},
	[893] = {
		3.2, -- [1]
		1076.666796876, -- [2]
		-2166.66660156, -- [3]
		"sunstriderislestart", -- [4]
	},
	[499] = {
		6.654166015640001, -- [1]
		1060.416601562, -- [2]
		-2713.74980468, -- [3]
		"sunwell", -- [4]
	},
	[894] = {
		3.6375, -- [1]
		2562.91640626, -- [2]
		720.833203124, -- [3]
		"ammenvalestart", -- [4]
	},
	[895] = {
		3.7, -- [1]
		-241.25, -- [2]
		945.416796876, -- [3]
		"newtinkertownstart", -- [4]
	},
}

RDXMAP.MapWorldHotspots2 = {

		-- Clear these
		[2036] = "",
		[2041] = "",
		[2042] = "",
		[2043] = "",

		[43] = "0661ff5991ffe074761a01310663ff5fe1338654661f90cc0665329fb060066599f301991ff732d301fd265932ccc1ff3ffb32b320cb730bee566163965cfc2d80dcc88bb621016f",
		[181] = "56e0599282e449e32ea6415a3ad48db5e2411ad603da057e12cb11dfb4c8",
		[464] = "000066ffdf98",
		[476] = "000000ffff98",
		[42] = "3320007fe4cb3324c86cc0cc3325995fe0623325ff5990663326665052c337b9194665fa",
		[381] = "000000bfffff",
		[101] = "1fd0005960cc1fd0ccb963fe1fd4ccac86ca1fdb98b962c61fde64a61199",
		[4] = "5a91767969fd627a8a73253e",
		[141] = "8dc0005a11135340fb9322cb4663999fd9985ffd3186512e",
		[182] = "7970662c30c66cc13339b0646661974030cb5992654d72df5995324660605325993e614b5326cc2f94cc532b984cb0c65ffc653b019f666dfd3990c8666ecb1ff0c7",
		[121] = "1ff0668ca3981ff3ffd2c2651ff64dc436c21ffce75972cb",
		[241] = "2cc1f9a16c0d",
		[9] = "5320843590634c80e34170794661515e15d15326cb5991975328655fe0cc3ff9317305fc",
		[321] = "35b038b48ebe",
        --[1034] = "35b038b48ebe",
		[261] = "198133a8dc84",
		[81] = "22000f42e2251ff20f5c626c39946667625038868997159c941c173de2bb",
		[161] = "5320661992c95323337963994cc6cc7ff1ff3ff8cb8cc41a",
		[41] = "234040acff83",
		[11] = "82217327508c3321901e665ca8e0ab0c82795151f66116c652e81a60e1cd5a99c162b202679b6b5391667f7ccb3b420e",
		[471] = "000000bfefff",
		[61] = "13313219812d1332652650c61333334cc0cc1333ff5ff19913359879512f1336cbe653fa9ffacc5974cc",
		[362] = "1ff0664cc12e1ff199c654663975ffac8260397865865398666bfe5993f9",
		[201] = "2cc0009fbbfe2ccbfe999397",
		[281] = "5eb0006cb6832fc6659b05052f4b4215a09e7d5b5644428981fda82ef12d",
		[772] = "3cd0db7c9e8d",
		[606] = "2b62138d323315d435aa673f401b057393e6b466ed4033e4",
		[607] = "5bf2441092ad580c502bf2e85d14a626d21289f6472df1b96655452453c564f8ef2234c44ad1061c913f6c63bd0510f5",
		[720] = "3ee13672ad52afe65535a827",
		--[1029] = "",
		[16] = "29f33b9d019821b4baad509d1b8521c891d61346c3d3f879",
		[17] = "6661338cb1f90e432cf1695a",
		[19] = "59713157727457e38f5f81504cc4c979aadf",
		[29] = "0bb333f2793c",
		[32] = "53a1d83d96515327fe4df5df",
		[27] = "020165e5d76c0cc8ccd9d2d10ccb986f93d5",
		[34] = "5c91f49771c01eb399ccc0cb0cc464dc072524bb73c5c24c",
		[23] = "1320cbe63864196932dfe466397d96c04142",
		[30] = "0cc2667f91ff0cc464e026df333b2fb9c2c0384dd53fe15f",
		[462] = "1ff066c63dfe",
		[463] = "064130f31d95",
		[24] = "6671002bd2c054e38c6c212141649d80a3203fe79081c26040e9997db0e840ba6d74a1223a8b8f72036c",
		[341] = "12d000ecbdff266dffd92132",
		[35] = "2ca0006c5a1327e9c3b9832e1eac9a4572b595b25c312850",
		[36] = "1b6062c77d25",
		[28] = "060132c65d2d",
		[480] = "7930cc865ecb",
		[21] = "4630cc932466463532798132588655535728",
		[301] = "000000f31aca000acad313ff000ec9bfd130",
		[37] = "5291946030a218822a9a37b184198442832a",
		[38] = "aae0008a1a9e1233a4fff79ea37af9842476",
		[26] = "6661337323ff153521d5d76b924c5c5d6255",
		[20] = "0661ffe657ff0669ffd32248",
		[382] = "6660008c7fff",
		[22] = "5c600052f5995975995931fe4657996d62094659978cb133507acb8162665d8d1174f194",
		[39] = "265000520ffe75911a29b49a7795473145f5761b2043025f",
		[40] = "06612eb36b08709c2949c11a",
		[499] = "407096826f26",
		[502] = "3fe3ff7fd7fd",
		[614] = "0d3000a00fff921107430633",
		[610] = "39c000a429b579769d6236c7",
		[684] = "1d7000597ffe74b1df2c0fff9f23033ddf19",
		[685] = "34c13d898d66",
		[615] = "6321143887dc46370b8927ff",
		[673] = "30511b5a1ff288b401395cd4",
		[708] = "3fd3ff7fe7fc",
		[709] = "3ff3ff7fe7fc",
		[700] = "546000887ea62e50f927ca02",
		[475] = "39900099959939959993239839993199952c",
		[465] = "399000c65130198130e63b2f399c64c65198532dfeacc0cb5ffecb9fc064999f316650cb",
		[477] = "000266b981960003fdbff064000466c65996000dfdbff132",
		[479] = "333000b329fe2cc9feb96398333d98b32264",
		[473] = "5310649ff2623332ccbff4613ff732b32863",
		[481] = "2660658610cc2661339990cc1fa1ffb968cb393acc8cc19852dc6459912e599d963ff133599ec9333133",
		[478] = "3330cc4cc1983332646650cc333333a653ff3337328652642ca9998cc0cc266a659320cc266b329ff465",
		[467] = "0c90005323980c9393d967fe932b975320639ffbfe466194a65d983ff063accdff3990cb",
		[486] = "1550b7bbbf8acfa2ec247a9a",
		[510] = "2a73ca5649260802cb4317170ec18a33a1997d54e2779887",
		[504] = "1e50cab32b764369028908ed",
		[488] = "51e28693bcf95ab1c51e81b218a6684437e9dd63670f396735d5b11c51996aa1350cd0e5",
		[490] = "3ba4b1c7a6ea1683b6283ba4367b752441987d725c82f24b69642399d19898014361719828332e0af196",
		[491] = "42508da74ffe2981b7221e50",
		[492] = "0001e0d7f8803af9cf9cf20d782aa62d450dc9ba9f1dc2365a8b9720e2f1",
		[493] = "0c531f9bcb07a7c5503004afa6b99624d1999fcade1dd1cd98bc2b199193",
		[495] = "36b00092fb4f3dda3358b1bc4a6b6f32a2e5",
		[501] = "3a32d671893c25e53d2406af692bc838e197a012e336a9026060d74122fa",
		[496] = "38544b8008741d06fe2285e72bac4218e1d832cc876a81195a2d19389191a0b00068bac3acba051c71b44ffca4195197",
		--[4012] = "000000ffffff",
		[541] = "3ff0007fcc0d",
		--[4014] = "3fd3ff7fa7fe",
		[640] = "000000ffefff",
		[605] = "000000ffeffe",
		[544] = "20b030cebff6",
		[737] = "000000ffffff",
		[858] = "5ee13353013db1609b0c95b626f2597aed8ca17271084a8ba9526c0ad8e6",
		[857] = "0a36f4d5c95e53941e5921119472c518615813851bcc51e5abd0ca341452",
		[809] = "62bd106570e669adf25e907c712e6c5750721bb03cbc775045192c8420ad5639d67273391b577ead61b7b25ed515d09b",
		[905] = "31418da47e71",
		--[6005] = "31418da47e71",		
		[806] = "57391c0841884287941d11884590007dc3af4cc8da0640ee43470f1c80905f470d7dfcb852e91704b149374004a3f70b4379db061072",
		[873] = "6fd1333b32266fac053d335f6fc3583338b8a2b9802972af",
		[810] = "cf7acb0782e3b859c717147419005f693ef580bb6638f2cdad464c14951680e5792e75ecd6cb51084166",
		[811] = "17842ab2623fc9a3502f69586ac6575f465428f1f5a1023f20966d4ad836",
		[807] = "cb22d220108313e6a33ec6e351f2ea5bb59951f86a4d93e0d252021170d420f42b31b2839ed84e1cf269ad93544844fe",
		[808] = "04b000f07fff",
		[903] = "000000fffffe",
		--[6013] = "000000fffffe",

}

local MapId2Zone={
	[4] = 38,
	[9] = 63,
	[11] = 97,
	[13] = 0,
	[14] = 0,
	[16] = 4,
	[17] = 12,
	[19] = 20,
	[20] = 105,
	[21] = 82,
	[22] = 111,
	[23] = 41,
	[24] = 56,
	[26] = 100,
	[27] = 37,
	[28] = 76,
	[29] = 22,
	[30] = 42,
	[32] = 33,
	[34] = 39,
	[35] = 59,
	[36] = 72,
	[37] = 85,
	[38] = 88,
	[39] = 112,
	[40] = 113,
	[41] = 90,
	[42] = 31,
	[43] = 5,
	[61] = 103,
	[81] = 83,
	
	[101] = 35,
	[121] = 46,
	[141] = 40,
	[161] = 89,
	[181] = 10,
	[182] = 45,
	
	[201] = 107,
	[241] = 62,
	[261] = 80,
	[281] = 114,
	
	[301] = 84,
	[321] = 68,
	[341] = 57,
	[362] = 104,
	[381] = 32,
	[382] = 108,
	
	[401] = 2,
	[443] = 110,
	[461] = 3,
	[462] = 43,
	[463] = 47,
	[464] = 11,
	[465] = 55,
	[466] = 0,
	[467] = 115,
	[471] = 99,
	[473] = 78,
	[475] = 19,
	[476] = 21,
	[477] = 64,
	[478] = 96,
	[479] = 66,
	[480] = 81,
	[481] = 79,
	[482] = 44,
	[485] = 0,
	[486] = 122,
	[488] = 125,
	[490] = 126,
	[491] = 127,
	[492] = 128,
	[493] = 129,
	[495] = 130,
	[496] = 132,
	[499] = 119,
	
	[501] = 131,
	[502] = 146,
	[504] = 124,
	[510] = 123,
	[512] = 148,
	[520] = 137,
	[521] = 147,
	[522] = 133,
	[523] = 142,
	[524] = 145,
	[525] = 140,
	[526] = 141,
	[527] = 143,
	[528] = 138,
	[529] = 149,
	[530] = 136,
	[531] = 144,
	[532] = 159,
	[533] = 134,
	[534] = 135,
	[535] = 65,
	[536] = 139,
	[539] = 161,
	[540] = 162,
	[541] = 150,
	[542] = 152,
	[543] = 151,
	[544] = 163,
	[545] = 161,
	
	[601] = 153,
	[602] = 155,
	[603] = 156,
	[604] = 154,
	[605] = 164,
	[606] = 165,
	[607] = 166,
	[609] = 167,
	[610] = 168,
	[611] = 169,
	[613] = 170,
	[614] = 171,
	[615] = 172,
	[626] = 173,
	[640] = 174,
	[673] = 175,
	[677] = 176,
	[678] = 161,
	[679] = 161,
	[680] = 69,
	[681] = 163,
	[682] = 163,
	[683] = 165,
	[684] = 177,
	[685] = 178,
	[686] = 116,
	[687] = 87,
	[688] = 14,
	[689] = 179,
	[690] = 101,
	[691] = 48,
	[692] = 106,
	[696] = 61,
	[697] = 117,
	[699] = 36,
	
	[700] = 180,
	[704] = 15,
	[708] = 181,
	[709] = 182,
	[710] = 54,
	[717] = 73,
	[718] = 250,
	[720] = 183,
	[721] = 17,
    [722] = 6,
	[723] = 8,
	[724] = 9,
	[725] = 53,
	[726] = 30,
	[727] = 29,
	[728] = 28,
	[729] = 92,
	[730] = 94,
	[731] = 91,
	[732] = 7,
	[733] = 25,
	[734] = 24,	
	[736] = 184,
	[737] = 185,
	[747] = 186,
	[748] = 183,
	[749] = 109,
	[750] = 60,
	[751] = 187,
	[752] = 188,
	[753] = 189,
	[754] = 190,
	[755] = 18,
	[756] = 98,
	[757] = 191,
	[758] = 192,
	[759] = 193,
	[760] = 70,
	[761] = 71,
	[762] = 74,
	[763] = 75,
	[764] = 77,
	[765] = 86,
	[766] = 95,
	[767] = 194,
	[768] = 195,
	[769] = 196,
	[770] = 180,
	[772] = 197,
	[773] = 198,
    [775] = 23,
	[776] = 49,
	[779] = 52,
	[780] = 27,	
	[781] = 118,
    [782] = 93,
	[789] = 121,	
	[795] = 199,
    [796] = 13,
	[797] = 51,
	[798] = 120,
	[799] = 58,
	
	[800] = 200,
	[806] = 216,
	[807] = 217,
	[808] = 1,
	[809] = 218,
	[810] = 219,
	[811] = 16,
	[816] = 202,
	[819] = 203,
	[820] = 201,
	[823] = 230,
	[824] = 204,
	[851] = 236,
	[856] = 240,
	[857] = 220,
	[858] = 102,
	[860] = 241,
	[864] = 214,
	[866] = 211,
	[867] = 226,
	[871] = 74,
	[873] = 26,
	[874] = 233,
	[875] = 221,
	[877] = 223,
	[876] = 225,
	[878] = 234,
	[880] = 236,
	[882] = 237,
	[883] = 242,
	[884] = 238,
	[885] = 222,
	[886] = 229,
	[887] = 224,
	[888] = 209,
	[889] = 210,
	[890] = 207,
	[891] = 208,
	[892] = 212,
	[893] = 215,
	[894] = 206,
	[895] = 213,
	[896] = 228,
	[897] = 227,
	[898] = 75,
	[899] = 239,
	
	[900] = 235,
	[903] = 50,
	[905] = 34,
	[906] = 231,
	[907] = 40,
	[911] = 245,
	[912] = 243,
	[914] = 244,
	[919] = 247,
	[920] = 246,
	[922] = 248,
	[928] = 67,
	[929] = 249,
	[930] = 251,
	[933] = 253,
	[934] = 252,
	
}

local Zone2MapId = VFL.invert(MapId2Zone);

function RDXMAP.ZMGetMapId(zone)
	return Zone2MapId[zone] or 0;
end

function RDXMAP.ZMGetZone(mapid)
	return MapId2Zone[mapid] or 0;
end

RDXMAP.Zone2MapId = Zone2MapId;
RDXMAP.MapId2Zone = MapId2Zone;

RDXMAP.ZoneConnections={
	"7|1||16|14.4|31.7||24|69.3|70",
	"7|1||16|38.1|84.6||40|51.06|11.95",
	"7|1||486|93.38|35.83||488|12.22|55.28",
	"7|1||486|52.49|7.56||493|32.05|84.7",
	"7|1||488|91.87|30.76||490|9.65|31.52",
	"7|1||488|88.96|23.95||496|18.18|84.95",
	"7|1||490|44.49|27.73||496|55.06|90.54",
	"7|1||490|82.8|57.11||491|74.6|8.47",
	"7|1||465|8.11|49.91||467|81.88|64.37",
	"7|1||465|39.98|86.68||478|56.38|19.82",
	"7|1||467|21.1|68.14||477|34.03|13.19",
	"7|1||467|69.27|35.68||475|51.64|74.64",
	"7|1||477|74.94|57.41||481|22.93|49.52",
	"7|1||477|77.21|76.01||478|20.33|56.31",
	"7|1||481|0|0||478|0|0",
	"7|1||478|70.84|49.83||473|21.82|26.59",
	"7|1||475|82.38|28.77||479|22.53|55.67",
	"7|1||464|42.45|5.46||476|65.38|92.58",
	"7|1||42|45|92.5||43|29.4|15.8",
	"7|1||43|36.7|72.9||81|73.3|42.8",
	"7|1||43|55.8|31.6||182|54.6|89.7",
	"7|1||43|94.56|47.6||181|9.1|71.1",
	"7|1||43|68.63|86.25||11|43.2|24.7",
	"7|1||182|64.1|10.6||241|35.77|72.2",
	"7|1||182|64.1|10.6||281|21.3|46.3",
	"7|1||4|45.54|12.28||321|52.49|84.4",
	"7|1||4|0|0||11|0|0",
	"7|1||37|49.9|17.2||34|44.9|79.2",
	"7|1||34|0|0||39|0|0",
	"7|1||39|0|0||30|0|0",
	"7|1||30|32.33|49.86||301|73.34|90.73",
	"7|1||30|91.8|72.9||36|14.6|63.7",
	"7|1||34|93.75|11.43||36|16.4|67",
	"7|1||34|89.88|41.25||32|33.05|35.96",
	"7|1||32|58.29|41.44||38|5.84|60.78",
	"7|1||19|49.2|8.3||38|38.5|60.5",
	"7|0|Portal to Hellfire Peninsula|19|55|53.7|Portal to Blasted Lands|465|89.39|50.22",
	"7|1||36|42.1|18.8||29|65.7|65",
	"7|1||28|33.6|77.9||29|23.4|49.1",
	"7|1||28|72.4|55.6||17|9|51.6",
	"7|1||35|47.5|72.8||17|45.7|7.7",
	"7|1||35|19.61|62.81||27|89.3|51.8",
	"7|1||35|19.23|17.21||27|88.3|41.2",
	"7|1||341|21.62|77.79||27|54.8|39.8",
	"7|1||35|25.57|10.47||40|53.97|70.33",
	"7|1||24|59.7|26.4||22|44.1|86.1",
	"7|1||26|9.66|55.77||24|71.5|54.8",
	"7|1||26|24.94|45.71||22|65.48|88.64",
	"7|1||26|26.2|69.5||16|36.9|29.8",
	"7|1||20|84.09|70.49||22|28.62|57.46",
	"7|1||23|8.82|66.22||22|69.67|50.24",
	"7|1||23|53.6|11.2||463|47.5|82.3",
	"7|1||463|0|0||462|0|0",
	"7|1||21|66.2|79.7||24|28|63.7",
	"7|1||21|67.56|5.45||20|54.14|75.77",
	"7|1||382|66.01|36.85||20|61.86|64.95",
	"7|1||467|43.08|27.35||475|37.26|80.57",
	"7|1||467|67.63|87.56||477|73.89|33.71",
	"7|1||321|25|66.8||11|70.2|4.6",
	"7|1||481|23.3|49.1||477|74.8|57.5",
	"7|1||101|53.3|5.9||81|36.1|74.9",
	"7|1||101|40.91|90.72||121|45.45|2.82",
	"7|1||121|86.7|42.8||61|8.3|12.8",
	"3|2|Boat to Teldrassil|464|21.4|54|Boat to Azuremyst Isle|41|52.5|89.5",
	"7|1||161|50.7|25.4||61|74.4|93",
	"7|1||161|28.2|57.2||201|71.44|77.23",
	"7|1||201|29.43|22.42||261|83.68|14.26",
	"3|2|Boat to Teldrassil|301|22.9|55.8|Boat to Stormwind City|41|55.1|93.4",
	"5|2|Zeppelin to Thunder Bluff|321|43.1|64.9|Zeppelin to Orgrimmar|362|16|25.7",
	"7|1||488|92.3|64||490|10.05|66.73",
	"7|1||490|60.33|17.08||496|70.88|77.32",
	"7|1||490|67.22|67.97||491|53.63|7.14",
	"7|1||490|33.84|79.26||491|24.49|12.31",
	"7|1||510|64|44.34||495|33.19|88.63",
	"7|1||467|82.11|91.89||478|33.57|6.95",
	"7|1||30|0|0||34|0|0",
	"7|1||241|35.77|72.2||281|21.3|46.3",
	"7|1||471|42.31|71.67||464|24.56|49.68",
	"3|0|Portal to Darnassus|41|55|88.2|Portal to Teldrassil|381|36.3|50.5",
	"7|1||480|72.43|84.44||462|56.66|49.97",
	"7|1||41|39|47.6||381|71.5|49.8",
	"7|1||9|37.59|33.03||362|35.69|63.08",
	"7|1||9|34.59|27.91||362|35.69|63.08",
	"7|1||9|38.97|19.09||362|51.17|31.54",
	"7|1||9|42.13|20.2||362|51.17|31.54",
	"7|1||471|74.04|53.76||464|37|47.02",
	"5|2|Zeppelin to Borean Tundra|321|44.7|62.4|Zeppelin to Orgrimmar|486|41.4|53.6",
	"5|2|Zeppelin to Tirisfal Glades|321|51|55.6|Zeppelin to Orgrimmar|20|60.8|58.8",
	"5|2|Zeppelin to Stranglethorn Vale|321|52.4|53.4|Zeppelin to Orgrimmar|37|37.2|52.4",
	"7|1||35|17.4|84.3||28|77.8|17.6",
	"6|0|Portal to Isle of Quel'Danas|481|48.62|42.05||499|48.25|34.48",
	"7|2|Boat to Dragonblight|491|23.46|57.75|Boat to Howling Fjord|488|49.63|78.42",
	"7|2|Boat to Dragonblight|486|78.9|53.64|Boat to Borean Tundra|488|47.95|78.74",
	"3|2|Boat to Stormwind City|486|59.68|69.39|Boat to Borean Tundra|301|18.5|25.5",
	"3|2|Boat to Wetlands|491|61.34|62.6|Boat to Howling Fjord|40|4.66|57.11",
	"3|2|Boat to Wetlands|141|71.54|56.37|Boat to Dustwallow Marsh|40|6.4|62.2",
	"3|2|Tram to Stormwind City|341|72.78|50.24|Tram to Ironforge|301|66.37|34.13",
	"5|2|Zeppelin to Stranglethorn Vale|20|61.8|59.1|Zeppelin to Tirisfal Glades|37|37.5|51",
	"5|2|Zeppelin to Undercity|491|77.71|28.26|Zeppelin to Howling Fjord|20|59.05|58.94",
	"7|2|Boat to Stranglethorn Vale|11|70.1|73.2|Boat to Northern Barrens|673|39.4|67.2",
	"4|0|Portal to Undercity|480|49.5|14.79|Portal to Silvermoon City|382|56.93|11.4",
	"4|0|Portal to Silvermoon City|382|54.86|11.25|Portal to Undercity|480|50.62|16.45",
	"7|1||488|60.92|10.74||510|46.52|70.8",
	"7|1||510|93.02|58.46||496|12.52|66.95",
	"7|1||510|85.77|45.09||495|38.19|93.25",
	"7|1||510|58.5|34.51||492|89.4|83.62",
	"7|1||141|29.7|47.1||607|50.6|78.6",
	"7|1||607|30|9.5||81|78.5|91.9",
	"7|1||321|75.8|2.7||181|27.3|76.2",
	"7|1||141|42.4|77.6||61|73|48.2",
	"7|1||161|28.7|66.1||748|67.3|22.6",
	"7|1||37|0|0||673|0|0",
	"7|1||40|72.4|47.3||700|29.1|40.6",
	"7|1||772|58.2|6.5||261|35.9|82.4",
	"7|1||614|0|0||615|0|0",
	"7|1||610|49|71.9||615|51.4|15.7",
	"2|0|Portal to Blasted Lands|301|48.99|87.32||301|48.99|87.32",
	"2|0|Portal to Stormwind City|504|39.74|62.54||301|28.86|28.86",
	"2|0|Portal to The Jade Forest|301|68.82|17.4||301|68.82|17.4",
	"4|0|Portal to Orgrimmar|504|55.41|25.48||504|55.41|25.48",
	"4|0|Portal to The Jade Forest|321|68.63|40.7||321|68.63|40.7",
	"7|1||806|33.84|64.36||807|90|18.32",
	"7|1||807|70.12|22.89||873|51.8|92.55",
	"7|1||873|50.75|41.35||809|73.19|94.52",
	"7|1||811|44.11|14.3||809|55.54|92.34",
	"7|1||809|30.11|63.39||810|70.39|43.79",
	"7|1||810|61.24|82.84||858|44.69|10.31",
	"7|1||857|75.3|5.21||807|81.9|48.84",
}
