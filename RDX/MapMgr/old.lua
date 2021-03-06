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
		class = "c",
		id = 1,
		Name = "Kalimdor",
		73.3282, -- Scale
		-3398.85, -2552.91, -- Origin
		tp = 1,
		oldid = 1000,
		X = -1800,	-- Was 0
		Y = 200,
		x = -5198.85,	-- Was 0
		y = -2352.91,
		s = 73.3282,
		FileName = "Kalimdor",
	},
	[772] = {
		Name = "Ahn'Qiraj: The Fallen Kingdom",
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "ci",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "ci",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "ci",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "z",
		c = 13,
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
		class = "c",
		id = 2,
		Name = "Eastern Kingdoms",
		81.53, -- Scale
		-3645.96, -2249.31, -- Origin
		tp = 1,
		oldid = 2000,
		X = 5884,
		Y = -200,
		x = 2238.04,
		y = -2449.31,
		s = 81.53,
		FileName = "Azeroth",
	},
	[614] = {
		Name = "Abyssal Depths",
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
		Cont = 2,
		faction = 2,
		tp = 2,
		oldid = 2042,
		minLvl = 0,
		maxLvl = 0,
	},
	[611] = {
		Name = "Gilneas City",
		class = "ci",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "ci",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "ci",
		c = 14,
		Cont = 2,
		Fish = 75,
		City = true,	-- No explored areas
		faction = 2,
		tp = 3,
		oldid = 2034,
	},
	[28] = {
		Name = "Searing Gorge",
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "ci",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "ci",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "ci",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "ci",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "z",
		c = 14,
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
		class = "c",
		id = 3,
		Name = "Outland",
		34.606,				-- Scale
		-2587.3, -1151.7,	-- Origin
		tp = 1,
		oldid = 3000,
		X = 7000,
		Y = -4000,
		x = 4412.7,
		y = -5151.7,
		s = 34.606,
		FileName = "Expansion01",
	},
	[475] = {
		Name = "Blade's Edge Mountains", -- [1]
		class = "z",
		c = 466,
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
		class = "z",
		c = 466,
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
		class = "z",
		c = 466,
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
		class = "z",
		c = 466,
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
		class = "z",
		c = 466,
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
		class = "ci",
		c = 466,
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
		class = "z",
		c = 466,
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
		class = "z",
		c = 466,
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
		class = "c",
		id = 4,
		Name = "Northrend",
		35.5,		-- Scale
		0, 0,		-- Origin
		tp = 1,
		oldid = 4000,
		X = 600,
		Y = -4500,
		x = 600,
		y = -4500,
		s = 35.5,
		FileName = "Northrend",
	},
	[486] = {
		Name = "Borean Tundra", -- [1]
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "ci",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "z",
		c = 485,
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
		class = "c",
		id = 5,
		Name = "The Maelstrom",
		26,		-- Scale
		0, 0,		-- Origin
		tp = 1,
		oldid = 5000,
		X = 1100,
		Y = -1800,
		x = 1100,
		y = -1800,
		s = 26,
		FileName = "TheMaelstromContinent",
	},
	[640] = {
		Name = "Deepholm",
		class = "z",
		c = 751,
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
		class = "z",
		c = 751,
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
		class = "z",
		c = 751,
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
		class = "z",
		c = 751,
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
		class = "c",
		id = 6,
		Name = "Pandaria",
		31.030601,
		-1756.42, 595.44,
		tp = 1,
		oldid = 6000,
		X = 2350,
		Y = 300,
		x = 593.58,
		y = 895.44,
		s = 31.03,
		FileName = "Pandaria",
	},
	[858] = {
		Name="Dread Wastes",
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "ci",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
		class = "z",
		c = 862,
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
	
	---------------------------------------
	-- Draenor
	
	[962] = {
		class = "c",
		id = 7,
		Name = "Draenor",
		34.606, -- Scale
		-3398.85, -2552.91, -- Origin
		tp = 1,
		X = -800,	-- Was 0
		Y = 200,
		x = -3198.85,	-- Was 0
		y = -5100.91,
		s = 34.606,
		FileName = "Draenor",
	},
	
	[950] = {
		Name="Nagrand",
		class = "z",
		c = 962,
		Cont = 7,
		7.850002,
		-542.19,1713.00,
		Overlay = "valleyofthefourwinds",
		Fish = 525,
		faction = 2,
		tp = 2,
		oldid = 6010,
		minLvl = 0,
		maxLvl = 0,
		x = -3198.85,
		y = -5100.91,
		s = 11.049,
		o = "NagrandDraenor",
	},
	
	[970] = {
		Name = "aa",
		class = "z",
		c = 962,
		Cont = 7,
		StartZone = true,
		faction = 2,
		tp = 2,
		minLvl = 0,
		maxLvl = 0,
		x = -2500,
		y = -4100,
		s = 2.7,
	},

	-- Battlegrounds
	
	--[9000] = {
	--	1,				-- Scale
	--	0, 0,			-- Origin
	--},
	[401] = {		-- AV
		Name = "Alterac Valley",
		class = "bg",
		8.471,		-- Scale
		16000,2000,		-- Origin
		Short = "AV",
		faction = 3,
		tp = 5,
		c = 14,
		Cont = 2,
	},
	[461] = {		-- AB
		Name = "Arathi Basin",
		class = "bg",
		3.508,		-- Scale
		-16000, 0,		-- Origin
		Short = "AB",
		faction = 3,
		tp = 5,
		c = 14,
		Cont = 2,
	},
	[482] = {		-- EOS
		Name = "Eye of the Storm",
		class = "bg",
		4.538,		-- Scale
		-16000,3000,		-- Origin
		Short = "EOS",
		faction = 3,
		tp = 5,
		c = 466,
		Cont = 3,
	},
	[540] = {		-- IC
		Name = "Isle of Conquest",
		class = "bg",
		5.295,
		-14500,1000,
		Short = "IC",
		faction = 3,
		tp = 5,
		c = 485,
		Cont = 4,
	},
	[860] = {
		Name = "Silvershard Mines",
		class = "bg",
		8.0,
		-14500,5000,
		Short = "SSM",
		MapBaseName = "STVDiamondMineBG1_",
		faction = 3,
		tp = 5,
		c = 14,
		Cont = 2,
	},
	[512] = {		-- SoA
		Name = "Strand of the Ancients",
		class = "bg",
		3.486,
		-14500,0,
		Short = "SoA",
		faction = 3,
		tp = 5,
		c = 485,
		Cont = 4,
	},
	[856] = {
		Name = "Temple of Kotmogu",
		class = "bg",
		3.0,
		-14500,4000,
		Short = "TK",
		faction = 3,
		tp = 5,
		c = 862,
		Cont = 6,
	},
	[736] = {
		Name = "The Battle for Gilneas",
		class = "bg",
		3.0,
		-14500,2000,
		Short = "TBG",
		faction = 3,
		tp = 5,
		c = 14,
		Cont = 2,
	},
	--[9014] = {
	--	Name = "Tol'vir Proving Grounds",
	--	3.0,
	--	-14500,6000,
	--	Short = "TPG",
	-- 	c = 14,
	--	Cont = 2,
	--},
	[626] = {
		Name = "Twin Peaks",
		class = "bg",
		3.0,
		-14500,3000,
		Short = "TP",
		faction = 3,
		tp = 5,
		c = 14,
		Cont = 2,
	},
	[443] = {		-- WG
		Name = "Warsong Gulch",
		class = "bg",
		2.29,			-- Scale
		-16000,1000,	-- Origin
		Short = "WG",
		faction = 3,
		tp = 5,
		c = 13,
		Cont = 1,
	},
	
	--Deepwind Gorge
	--c = 862,
	--	Cont = 6,
	
	
	-- Wintergrasp 
	--c = 485,
	--	Cont = 4,
	
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
		["class"] = "i",
		["minLvl"] = 15,
		[2] = 51.9,
		["EntryMId"] = 321,
		[3] = 58.4,
		["Name"] = "Ragefire Chasm",
		["maxLvl"] = 16,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[756] = {
		["class"] = "i",
		["minLvl"] = 15,
		[2] = 42.56,
		["EntryMId"] = 39,
		[3] = 71.72,
		["Name"] = "The Deadmines",
		["maxLvl"] = 16,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[749] = {
		["class"] = "i",
		["minLvl"] = 17,
		[2] = 39,
		["EntryMId"] = 11,
		[3] = 69.40000000000001,
		["Name"] = "Wailing Caverns",
		["maxLvl"] = 20,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[764] = {
		["class"] = "i",
		["minLvl"] = 18,
		[2] = 44.86,
		["EntryMId"] = 21,
		[3] = 67.86,
		["Name"] = "Shadowfang Keep",
		["maxLvl"] = 21,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[690] = {
		["class"] = "i",
		["minLvl"] = 22,
		[2] = 51.4,
		["EntryMId"] = 301,
		[3] = 68.3,
		["Name"] = "The Stockade",
		["maxLvl"] = 25,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[688] = {
		["class"] = "i",
		["minLvl"] = 22,
		[2] = 14.15,
		["EntryMId"] = 43,
		[3] = 13.9,
		["Name"] = "Blackfathom Deeps",
		["maxLvl"] = 25,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[691] = {
		["class"] = "i",
		["minLvl"] = 26,
		[2] = 24.38,
		["EntryMId"] = 27,
		[3] = 39.8,
		["Name"] = "Gnomeregan",
		["maxLvl"] = 29,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
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
		["class"] = "i",
		["minLvl"] = 32,
		[2] = 42.5,
		["EntryMId"] = 607,
		[3] = 94.8,
		["Name"] = "Razorfen Kraul",
		["maxLvl"] = 35,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[750] = {
		["class"] = "i",
		["minLvl"] = 36,
		[2] = 29.48,
		["EntryMId"] = 101,
		[3] = 62.53,
		["Name"] = "Maraudon",
		["maxLvl"] = 39,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
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
		["class"] = "i",
		["minLvl"] = 42,
		[2] = 43.2,
		["EntryMId"] = 61,
		[3] = 26.1,
		["Name"] = "Razorfen Downs",
		["maxLvl"] = 45,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[699] = {
		["class"] = "i",
		["minLvl"] = 44,
		[2] = 59.1,
		["EntryMId"] = 121,
		[3] = 45.4,
		["Name"] = "Dire Maul",
		["maxLvl"] = 47,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[686] = {
		["class"] = "i",
		["minLvl"] = 46,
		[2] = 39.2,
		["EntryMId"] = 161,
		[3] = 21.4,
		["Name"] = "Zul'Farrak",
		["maxLvl"] = 49,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[765] = {
		["class"] = "i",
		["minLvl"] = 48,
		[2] = 27.09,
		["EntryMId"] = 23,
		[3] = 12.6,
		["Name"] = "Stratholme",
		["maxLvl"] = 51,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[687] = {
		["class"] = "i",
		["minLvl"] = 52,
		[2] = 69.83,
		["EntryMId"] = 38,
		[3] = 54.14,
		["Name"] = "The Temple of Atal'Hakkar",
		["maxLvl"] = 55,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[704] = {
		["class"] = "i",
		["minLvl"] = 53,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.01000000000001,
		["Name"] = "Blackrock Depths",
		["maxLvl"] = 56,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[721] = {
		["class"] = "i",
		["minLvl"] = 58,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.03,
		["Name"] = "Blackrock Spire",
		["maxLvl"] = 58,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[755] = {
		["class"] = "i",
		["minLvl"] = 60,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.01000000000001,
		["Name"] = "Blackwing Lair",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[766] = {
		["class"] = "i",
		["minLvl"] = 60,
		[2] = 47,
		["EntryMId"] = 772,
		[3] = 7.8,
		["Name"] = "Ahn'Qiraj", -- temple
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[717] = {
		["class"] = "i",
		["minLvl"] = 60,
		[2] = 59.1,
		["EntryMId"] = 772,
		[3] = 14,
		["Name"] = "Ruins of Ahn'Qiraj",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[696] = {
		["class"] = "i",
		["minLvl"] = 60,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.05000000000001,
		["Name"] = "Molten Core",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	----------------------------------
	[797] = {
		["class"] = "i",
		["minLvl"] = 59,
		[2] = 47.64,
		["EntryMId"] = 465,
		[3] = 53.57,
		["Name"] = "Hellfire Ramparts",
		["maxLvl"] = 62,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[725] = {
		["class"] = "i",
		["minLvl"] = 61,
		[2] = 46.03,
		["EntryMId"] = 465,
		[3] = 51.78,
		["Name"] = "The Blood Furnace",
		["maxLvl"] = 63,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[728] = {
		["class"] = "i",
		["minLvl"] = 62,
		[2] = 50.37,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "The Slave Pens",
		["maxLvl"] = 64,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[726] = {
		["class"] = "i",
		["minLvl"] = 63,
		[2] = 50.43,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "The Underbog",
		["maxLvl"] = 65,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[732] = {
		["class"] = "i",
		["minLvl"] = 64,
		[2] = 39.63,
		["EntryMId"] = 478,
		[3] = 62.06,
		["Name"] = "Mana-Tombs",
		["maxLvl"] = 66,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[722] = {
		["class"] = "i",
		["minLvl"] = 65,
		[2] = 37.3,
		["EntryMId"] = 478,
		[3] = 65.61,
		["Name"] = "Auchenai Crypts",
		["maxLvl"] = 67,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[734] = {
		["class"] = "i",
		["minLvl"] = 66,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50.02,
		["Name"] = "Old Hillsbrad Foothills",
		["maxLvl"] = 68,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[723] = {
		["class"] = "i",
		["minLvl"] = 67,
		[2] = 41.98,
		["EntryMId"] = 478,
		[3] = 65.62000000000001,
		["Name"] = "Sethekk Halls",
		["maxLvl"] = 68,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[724] = {
		["class"] = "i",
		["minLvl"] = 67,
		[2] = 39.63,
		["EntryMId"] = 478,
		[3] = 69.13,
		["Name"] = "Shadow Labyrinth",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[729] = {
		["class"] = "i",
		["minLvl"] = 67,
		[2] = 71.7,
		["EntryMId"] = 479,
		[3] = 55.07,
		["Name"] = "The Botanica",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[710] = {
		["class"] = "i",
		["minLvl"] = 67,
		[2] = 48.02,
		["EntryMId"] = 465,
		[3] = 51.88,
		["Name"] = "The Shattered Halls",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[727] = {
		["class"] = "i",
		["minLvl"] = 67,
		[2] = 50.38999999999999,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "The Steamvault",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[730] = {
		["class"] = "i",
		["minLvl"] = 67,
		[2] = 70.54000000000001,
		["EntryMId"] = 479,
		[3] = 69.64,
		["Name"] = "The Mechanar",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[733] = {
		["class"] = "i",
		["minLvl"] = 68,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50.04,
		["Name"] = "The Black Morass",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[798] = {
		["class"] = "i",
		["minLvl"] = 68,
		[2] = 61.18,
		["EntryMId"] = 499,
		[3] = 30.83,
		["Name"] = "Magisters' Terrace",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[731] = {
		["class"] = "i",
		["minLvl"] = 68,
		[2] = 74.37000000000001,
		["EntryMId"] = 479,
		[3] = 57.75,
		["Name"] = "The Arcatraz",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	
	[796] = {
		["class"] = "i",
		["minLvl"] = 70,
		[2] = 71.03,
		["EntryMId"] = 473,
		[3] = 46.33,
		["Name"] = "Black Temple",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[780] = {
		["class"] = "i",
		["minLvl"] = 70,
		[2] = 50.41,
		["EntryMId"] = 467,
		[3] = 40.9,
		["Name"] = "Serpentshrine Cavern",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[776] = {
		["class"] = "i",
		["minLvl"] = 70,
		[2] = 68.20999999999999,
		["EntryMId"] = 475,
		[3] = 24.37,
		["Name"] = "Gruul's Lair",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[779] = {
		["class"] = "i",
		["minLvl"] = 70,
		[2] = 46.63,
		["EntryMId"] = 465,
		[3] = 52.78,
		["Name"] = "Magtheridon's Lair",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 466,
		["Cont"] = 3,
	},
	[775] = {
		["class"] = "i",
		["minLvl"] = 70,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50,
		["Name"] = "Hyjal Summit",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[789] = {
		["class"] = "i",
		["minLvl"] = 70,
		[2] = 44.27,
		["EntryMId"] = 499,
		[3] = 45.65,
		["Name"] = "Sunwell Plateau",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[799] = {
		["class"] = "i",
		["minLvl"] = 70,
		[2] = 47,
		["EntryMId"] = 32,
		[3] = 74.94,
		["Name"] = "Karazhan",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
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
		["class"] = "i",
		["minLvl"] = 69,
		[2] = 57.28,
		["EntryMId"] = 491,
		[3] = 46.72,
		["Name"] = "Utgarde Keep",
		["maxLvl"] = 72,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[520] = {
		["class"] = "i",
		["minLvl"] = 71,
		[2] = 27.5,
		["EntryMId"] = 486,
		[3] = 26.03,
		["Name"] = "The Nexus",
		["maxLvl"] = 73,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[533] = {
		["class"] = "i",
		["minLvl"] = 72,
		[2] = 26.01,
		["EntryMId"] = 488,
		[3] = 50.83,
		["Name"] = "Azjol-Nerub",
		["maxLvl"] = 74,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[522] = {
		["class"] = "i",
		["minLvl"] = 73,
		[2] = 28.46,
		["EntryMId"] = 488,
		[3] = 51.71,
		["Name"] = "Ahn'kahet: The Old Kingdom",
		["maxLvl"] = 75,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[534] = {
		["class"] = "i",
		["minLvl"] = 74,
		[2] = 17.43,
		["EntryMId"] = 490,
		[3] = 21.21,
		["Name"] = "Drak'Tharon Keep",
		["maxLvl"] = 76,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[536] = {
		["class"] = "i",
		["minLvl"] = 75,
		[2] = 67,
		["EntryMId"] = 504,
		[3] = 68.40000000000001,
		["Name"] = "The Violet Hold",
		["maxLvl"] = 77,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[530] = {
		["class"] = "i",
		["minLvl"] = 76,
		[2] = 83.59999999999999,
		["EntryMId"] = 496,
		[3] = 18,
		["Name"] = "Gundrak",
		["maxLvl"] = 78,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[526] = {
		["class"] = "i",
		["minLvl"] = 77,
		[2] = 39.5,
		["EntryMId"] = 495,
		[3] = 26.9,
		["Name"] = "Halls of Stone",
		["maxLvl"] = 78,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[542] = {
		["class"] = "i",
		["minLvl"] = 78,
		[2] = 74.2,
		["EntryMId"] = 492,
		[3] = 20.4,
		["Name"] = "Trial of the Champion",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[525] = {
		["class"] = "i",
		["minLvl"] = 79,
		[2] = 45.4,
		["EntryMId"] = 495,
		[3] = 21.4,
		["Name"] = "Halls of Lightning",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[521] = {
		["class"] = "i",
		["minLvl"] = 79,
		[2] = 65.34,
		["EntryMId"] = 161,
		[3] = 50.06,
		["Name"] = "The Culling of Stratholme",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[528] = {
		["class"] = "i",
		["minLvl"] = 79,
		[2] = 27.52,
		["EntryMId"] = 486,
		[3] = 26.75,
		["Name"] = "The Oculus",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[524] = {
		["class"] = "i",
		["minLvl"] = 79,
		[2] = 57.28,
		["EntryMId"] = 491,
		[3] = 46.75,
		["Name"] = "Utgarde Pinnacle",
		["maxLvl"] = 79,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[543] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 75.09999999999999,
		["EntryMId"] = 492,
		[3] = 21.8,
		["Name"] = "Trial of the Crusader",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[527] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 27.5,
		["EntryMId"] = 486,
		[3] = 26.03,
		["Name"] = "The Eye of Eternity",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[531] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 59.8,
		["EntryMId"] = 488,
		[3] = 54.1,
		["Name"] = "The Obsidian Sanctum",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[718] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 52.41,
		["EntryMId"] = 141,
		[3] = 76.39,
		["Name"] = "Onyxia's Lair",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[532] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 50,
		["EntryMId"] = 501,
		[3] = 18,
		["Name"] = "Vault of Archavon",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[604] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 53.3,
		["EntryMId"] = 492,
		[3] = 85.59999999999999,
		["Name"] = "Icecrown Citadel",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[602] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 54.5,
		["EntryMId"] = 492,
		[3] = 91.3,
		["Name"] = "Pit of Saron",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[609] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 0,
		["EntryMId"] = 488,
		[3] = 0,
		["Name"] = "The Ruby Sanctum",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[601] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 54.5,
		["EntryMId"] = 492,
		[3] = 90.2,
		["Name"] = "The Forge of Souls",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[603] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 54.8,
		["EntryMId"] = 492,
		[3] = 90.8,
		["Name"] = "Halls of Reflection",
		["maxLvl"] = 82,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	[529] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 41.6,
		["EntryMId"] = 495,
		[3] = 18.2,
		["Name"] = "Ulduar",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	
	-----------------------------------------------
	[753] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.06999999999999,
		["Name"] = "Blackrock Caverns",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[767] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 70.7,
		["EntryMId"] = 614,
		[3] = 29,
		["Name"] = "Throne of the Tides",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[768] = {
		["class"] = "i",
		["minLvl"] = 81,
		[2] = 47,
		["EntryMId"] = 640,
		[3] = 52.2,
		["Name"] = "The Stonecore",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 751,
		["Cont"] = 5,
	},
	[769] = {
		["class"] = "i",
		["minLvl"] = 81,
		[2] = 76.7,
		["EntryMId"] = 720,
		[3] = 84.40000000000001,
		["Name"] = "The Vortex Pinnacle",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[757] = {
		["class"] = "i",
		["minLvl"] = 84,
		[2] = 19.2,
		["EntryMId"] = 700,
		[3] = 54.1,
		["Name"] = "Grim Batol",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[759] = {
		["class"] = "i",
		["minLvl"] = 84,
		[2] = 71.8,
		["EntryMId"] = 720,
		[3] = 52.2,
		["Name"] = "Halls of Origination",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[793] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 67.2,
		["EntryMId"] = 37,
		[3] = 32.8,
		["Name"] = "Zul'Gurub",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[752] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 51,
		["EntryMId"] = 708,
		[3] = 50,
		["Name"] = "Baradin Hold",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[747] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 60.5,
		["EntryMId"] = 720,
		[3] = 64.09999999999999,
		["Name"] = "Lost City of the Tol'vir",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[754] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 34.91,
		["EntryMId"] = 28,
		[3] = 85.09,
		["Name"] = "Blackwing Descent",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[758] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 33.9,
		["EntryMId"] = 700,
		[3] = 78,
		["Name"] = "The Bastion of Twilight",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[781] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 81.51000000000001,
		["EntryMId"] = 463,
		[3] = 64.34,
		["Name"] = "Zul'Aman",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
	[800] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 46.2,
		["EntryMId"] = 606,
		[3] = 78.8,
		["Name"] = "Firelands",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[820] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50,
		["Name"] = "End Time",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[816] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50.02,
		["Name"] = "Well of Eternity",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[819] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50.04,
		["Name"] = "Hour of Twilight",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[824] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 65.37000000000001,
		["EntryMId"] = 161,
		[3] = 50.06,
		["Name"] = "Dragon Soul",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	[773] = {
		["class"] = "i",
		["minLvl"] = 85,
		[2] = 38.4,
		["EntryMId"] = 720,
		[3] = 80.59999999999999,
		["Name"] = "Throne of the Four Winds",
		["maxLvl"] = 85,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 13,
		["Cont"] = 1,
	},
	
	-----------------------------------------------
	[876] = {
		["class"] = "i",
		["minLvl"] = 86,
		[2] = 39.1,
		["EntryMId"] = 807,
		[3] = 67.75,
		["Name"] = "Stormstout Brewery",
		["maxLvl"] = 87,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
	},
	[867] = {
		["class"] = "i",
		["minLvl"] = 87,
		[2] = 55.88,
		["EntryMId"] = 806,
		[3] = 55.64,
		["Name"] = "Temple of the Jade Serpent",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
	},
	[885] = {
		["class"] = "i",
		["minLvl"] = 87,
		[2] = 74.2,
		["EntryMId"] = 811,
		[3] = 42.6,
		["Name"] = "Mogu'shan Palace",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
	},
	[877] = {
		["class"] = "i",
		["minLvl"] = 87,
		[2] = 36,
		["EntryMId"] = 809,
		[3] = 49.2,
		["Name"] = "Shado-Pan Monastery",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
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
		["class"] = "i",
		["minLvl"] = 90,
		[2] = 14,
		["EntryMId"] = 811,
		[3] = 75.42,
		["Name"] = "Gate of the Setting Sun",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
	},
	[896] = {
		["class"] = "i",
		["minLvl"] = 90,
		[2] = 74.5,
		["EntryMId"] = 809,
		[3] = 40.6,
		["Name"] = "Mogu'shan Vaults",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
	},
	[886] = {
		["class"] = "i",
		["minLvl"] = 90,
		[2] = 49.3,
		["EntryMId"] = 873,
		[3] = 61.1,
		["Name"] = "Terrace of Endless Spring",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
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
		["class"] = "i",
		["minLvl"] = 90,
		[2] = 55.97,
		["EntryMId"] = 928,
		[3] = 162.21,
		["Name"] = "Throne of Thunder",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
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
	--[897] = {
	--	["minLvl"] = 90,
	--	[2] = 34.7,
	--	["EntryMId"] = 585,
	--	[3] = 41.1,
	--	["Name"] = "Heart of Fear",
	--	["maxLvl"] = 90,
	--	["faction"] = 3,
	--	["tp"] = 4,
		
	--},
	--[11231] = {
	--	["minLvl"] = 90,
	--	[2] = 55.9,
	--	["EntryMId"] = 141,
	--	[3] = 49.5,
	--	["Name"] = "Battle of Theramore",
	--	["maxLvl"] = 90,
	--},
	
	
	[535] = {
		["class"] = "i",
		["minLvl"] = 80,
		[2] = 87.3,
		["EntryMId"] = 488,
		[3] = 50.98,
		["Name"] = "Naxxramas",
		["maxLvl"] = 83,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 485,
		["Cont"] = 4,
	},
	
	[887] = {
		["class"] = "i",
		["minLvl"] = 90,
		[2] = 38.1,
		["EntryMId"] = 810,
		[3] = 62.16,
		["Name"] = "Siege of Niuzao Temple",
		["maxLvl"] = 90,
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 862,
		["Cont"] = 6,
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
		["class"] = "i",
		["minLvl"] = 37,
		[2] = 44.44,
		["EntryMId"] = 17,
		[3] = 12.19,
		["Name"] = "Uldaman",
		["maxLvl"] = "40",
		["faction"] = 3,
		["tp"] = 4,
		["c"] = 14,
		["Cont"] = 2,
	},
}

RDXMAP.MapGenAreas2 = {
	[480] = {
		["y"] = -1714.74179688,
		["x"] = 6661.15,
		["s"] = 2.42291699218,
		["o"] = "silvermooncity",
	},
	[488] = {
		["y"] = -3496.22,
		["x"] = 1713.94,
		["s"] = 11.21666625976,
		["o"] = "dragonblight",
	},
	[492] = {
		["y"] = -4266.524828,
		["x"] = 1350.941881,
		["s"] = 12.541666625976,
		["o"] = "icecrownglacier",
	},
	[607] = {
		["y"] = 159.1666687012,
		["x"] = -2071.25,
		["s"] = 14.825,
		["o"] = "southernbarrens",
	},
	[615] = {
		["y"] = 751.25,
		["x"] = 4547.750097656,
		["s"] = 9.699999267579999,
		["o"] = "vashjirruins",
	},
	[504] = {
		["y"] = -3639,
		["x"] = 2229,
		["s"] = 1.276076923076923,
		["o"] = "dalaran",
	},
	[381] = {
		["y"] = -1892.91660156,
		["x"] = -2437.5,
		["s"] = 3.07916674804,
		["o"] = "darnassus",
	},
	[893] = {
		["y"] = -1850.66660156,
		["x"] = 6457.666796876,
		["s"] = 3.2,
		["o"] = "sunstriderislestart",
	},
	[34] = {
		["y"] = 1743.333203126,
		["x"] = 5717.3333374024,
		["s"] = 5.399999877936,
		["o"] = "duskwood",
	},
	[35] = {
		["y"] = 697.5,
		["x"] = 6282.749975586,
		["s"] = 5.51666625976,
		["o"] = "lochmodan",
	},
	[9] = {
		["y"] = 233.75,
		["x"] = -2240.833300782,
		["s"] = 10.89999951172,
		["o"] = "mulgore",
	},
	[36] = {
		["y"] = 1502.916601562,
		["x"] = 6179.833325196,
		["s"] = 5.13749975586,
		["o"] = "redridge",
	},
	[37] = {
		["y"] = 2003.33320312,
		["x"] = 5535.250024414,
		["s"] = 8.19999975586,
		["o"] = "stranglethornjungle",
	},
	[38] = {
		["y"] = 1707.083203126,
		["x"] = 6300.25,
		["s"] = 5.016666015619999,
		["o"] = "swampofsorrows",
	},
	[39] = {
		["y"] = 1680,
		["x"] = 5280.666699218,
		["s"] = 6.999999633796,
		["o"] = "westfall",
	},
	[40] = {
		["y"] = 229.583300782,
		["x"] = 5961.9166625976,
		["s"] = 8.270833374023999,
		["o"] = "wetlands",
	},
	[41] = {
		["y"] = -2169.58320312,
		["x"] = -2647.083300782,
		["s"] = 11.74999951172,
		["o"] = "teldrassil",
	},
	[42] = {
		["y"] = -1444.583203126,
		["x"] = -2403.333300782,
		["s"] = 12.92916601564,
		["o"] = "darkshore",
	},
	[161] = {
		["y"] = 1354.166601562,
		["x"] = -1787.50000076294,
		["s"] = 14.4249990310694,
		["o"] = "tanaris",
	},
	[43] = {
		["y"] = -734.5833007819999,
		["x"] = -2139.999975586,
		["s"] = 11.53333276368,
		["o"] = "ashenvale",
	},
	[11] = {
		["y"] = -162.083325196,
		["x"] = -1840.4166656494,
		["s"] = 11.491666656494,
		["o"] = "barrens",
	},
	[473] = {
		["y"] = -3610.416674804,
		["x"] = 6155,
		["s"] = 11,
		["o"] = "shadowmoonvalley",
	},
	[477] = {
		["y"] = -4008.3333328247,
		["x"] = 4940.83339844,
		["s"] = 11.04999999998,
		["o"] = "nagrand",
	},
	[481] = {
		["y"] = -3705.209106446,
		["x"] = 5772.948242188,
		["s"] = 2.6125,
		["o"] = "shattrathcity",
	},
	[720] = {
		["y"] = 1805.833300782,
		["x"] = -2288.333300782,
		["s"] = 12.38749951172,
		["o"] = "uldum_terrain1",
	},
	[182] = {
		["y"] = -1247.499902344,
		["x"] = -2159.583325196,
		["s"] = 12.12499926758,
		["o"] = "felwood",
	},
	[493] = {
		["y"] = -3838.694163,
		["x"] = 1053.792401,
		["s"] = 8.7125,
		["o"] = "sholazarbasin",
	},
	[281] = {
		["y"] = -1558.75,
		["x"] = -1601.6666748046,
		["s"] = 12.299999755866,
		["o"] = "winterspring",
	},
	[501] = {
		["y"] = -3524.772443,
		["x"] = 1573.388866,
		["s"] = 5.94999975586,
		["o"] = "lakewintergrasp",
	},
	[810] = {
		["y"] = 1320.5,
		["x"] = 927.81,
		["s"] = 11.487498,
		["o"] = "townlongwastes",
	},
	[382] = {
		["y"] = -575.5890625,
		["x"] = 5709.3614746094,
		["s"] = 1.918750061035,
		["o"] = "undercity",
	},
	[895] = {
		["y"] = 745.416796876,
		["x"] = 5642.75,
		["s"] = 3.7,
		["o"] = "newtinkertownstart",
	},
	[903] = {
		["y"] = 1873.5,
		["x"] = 2132.2,
		["s"] = 0.5,
	},
	[611] = {
		["y"] = 61.25,
		["x"] = 5497.33334961,
		["s"] = 1.7791665039,
		["o"] = "gilneascity",
	},
	[806] = {
		["y"] = 1501.75,
		["x"] = 2053.23,
		["s"] = 13.966666,
		["o"] = "thejadeforest",
	},
	[673] = {
		["y"] = 2303.33320312,
		["x"] = 5462.33334961,
		["s"] = 7.89166625976,
		["o"] = "thecapeofstranglethorn",
	},
	[808] = {
		["y"] = 100,
		["x"] = 1850,
		["s"] = 5.341666015625,
		["o"] = "thewanderingisle",
	},
	[689] = {
		["y"] = 1992.91660156,
		["x"] = 5288.58334961,
		["s"] = 13.10416601562,
		["o"] = "stranglethornvale",
	},
	[951] = {
		["y"] = 2185.6667968,
		["x"] = 3160.2668,
		["s"] = 4.8,
		["o"] = "timelessisle",
	},
	[685] = {
		["y"] = 61.25,
		["x"] = 5497.33334961,
		["s"] = 1.7791665039,
		["o"] = "ruinsofgilneascity",
	},
	[465] = {
		["y"] = -4296.25,
		["x"] = 5892.083398438,
		["s"] = 10.32916601562,
		["o"] = "hellfire",
	},
	[16] = {
		["y"] = -171.6666687012,
		["x"] = 6109.41665039,
		["s"] = 6.95416650392,
		["o"] = "arathi",
	},
	[499] = {
		["y"] = -2397.74980468,
		["x"] = 6441.416601562,
		["s"] = 6.654166015640001,
		["o"] = "sunwell",
	},
	[864] = {
		["y"] = 1514.16640625,
		["x"] = 5846.5,
		["s"] = 1.9375,
		["o"] = "northshire",
	},
	[181] = {
		["y"] = -876.25,
		["x"] = -1125.416699218,
		["s"] = 11.02916699218,
		["o"] = "aszhara",
	},
	[496] = {
		["y"] = -3915.364827,
		["x"] = 2559.324066,
		["s"] = 9.987500000000001,
		["o"] = "zuldrak",
	},
	[888] = {
		["y"] = -2006.66660156,
		["x"] = -2098.333398438,
		["s"] = 2.90000195313,
		["o"] = "shadowglenstart",
	},
	[894] = {
		["y"] = -1089.166796876,
		["x"] = -2737.08359374,
		["s"] = 3.6375,
		["o"] = "ammenvalestart",
	},
	[640] = {
		["y"] = -1659.16665039,
		["x"] = 2069.58334961,
		["s"] = 10.19999975586,
		["o"] = "deepholm",
	},
	[772] = {
		["y"] = 1806.666601562,
		["x"] = -2578.333300782,
		["s"] = 8.099999664314,
		["o"] = "ahnqirajthefallenkingdom",
	},
	[462] = {
		["y"] = -1892.33320312,
		["x"] = 6278.5,
		["s"] = 9.85,
		["o"] = "eversongwoods",
	},
	[928] = {
		["y"] = 814.5832,
		["x"] = 814.1668,
		["s"] = 8.270832,
		["o"] = "isleofthethunderking",
	},
	[809] = {
		["y"] = 1108.42,
		["x"] = 1375.73,
		["s"] = 12.516666,
		["o"] = "kunlaisummit",
	},
	[22] = {
		["y"] = -873.3333007819999,
		["x"] = 5800.6666687012,
		["s"] = 8.599999816887999,
		["o"] = "westernplaguelands",
	},
	[478] = {
		["y"] = -3800.000012207,
		["x"] = 5583.333398438,
		["s"] = 10.79999951172,
		["o"] = "terokkarforest",
	},
	[61] = {
		["y"] = 993.3333007819999,
		["x"] = -1713.3333374024,
		["s"] = 8.799999389643999,
		["o"] = "thousandneedles",
	},
	[486] = {
		["y"] = -3360.945677,
		["x"] = 725.76481,
		["s"] = 11.52916601562,
		["o"] = "boreantundra",
	},
	[490] = {
		["y"] = -3484.726974,
		["x"] = 2661.032452,
		["s"] = 10.49999975586,
		["o"] = "grizzlyhills",
	},
	[857] = {
		["y"] = 2254.25,
		["x"] = 1754.06,
		["s"] = 9.375002,
		["o"] = "krasarang",
	},
	[4] = {
		["y"] = -161.66665039,
		["x"] = -1407.500024414,
		["s"] = 10.57499926758,
		["o"] = "durotar",
	},
	[873] = {
		["y"] = 1894.25,
		["x"] = 2181.15,
		["s"] = 3.5875,
		["o"] = "thehiddenpass",
	},
	[502] = {
		["y"] = -850.5,
		["x"] = 7093.583300782,
		["s"] = 6.325,
		["o"] = "scarletenclave",
	},
	[889] = {
		["y"] = 200,
		["x"] = -1071.666796874,
		["s"] = 2.700000000000001,
		["o"] = "valleyoftrialsstart",
	},
	[121] = {
		["y"] = 673.3333007819999,
		["x"] = -2888.333300782,
		["s"] = 13.89999951172,
		["o"] = "feralas",
	},
	[17] = {
		["y"] = 970.8333007819999,
		["x"] = 6264.41665039,
		["s"] = 6.14166650392,
		["o"] = "badlands",
	},
	[463] = {
		["y"] = -1337.333203126,
		["x"] = 6437.666601562,
		["s"] = 6.600000000000001,
		["o"] = "ghostlands",
	},
	[101] = {
		["y"] = 109.5833374024,
		["x"] = -2646.666601562,
		["s"] = 8.99166601562,
		["o"] = "desolace",
	},
	[929] = {
		["y"] = 900.5832,
		["x"] = 1949.1666,
		["s"] = 3.575001968,
		["o"] = "isleofgiants",
	},
	[141] = {
		["y"] = 606.666796876,
		["x"] = -1605,
		["s"] = 10.5,
		["o"] = "dustwallow",
	},
	[81] = {
		["y"] = -480.8333007819999,
		["x"] = -2580.41665039,
		["s"] = 11.79999975586,
		["o"] = "stonetalonmountains",
	},
	[610] = {
		["y"] = 603.749951172,
		["x"] = 4869.833398438,
		["s"] = 5.60416601562,
		["o"] = "vashjirkelpforest",
	},
	[737] = {
		["y"] = -1474.16665039,
		["x"] = 1788.75,
		["s"] = 3.1,
		["o"] = "themaelstrom",
	},
	[19] = {
		["y"] = 1916.66660156,
		["x"] = 6122.75,
		["s"] = 7.325,
		["o"] = "blastedlands",
	},
	[241] = {
		["y"] = -1498.333203126,
		["x"] = -1523.75,
		["s"] = 4.6166665039,
		["o"] = "moonglade",
	},
	[858] = {
		["y"] = 1948.84,
		["x"] = 1115.73,
		["s"] = 10.704166,
		["o"] = "dreadwastes",
	},
	[866] = {
		["y"] = 992.5,
		["x"] = 5688.1666015624,
		["s"] = 1.929166015626,
		["o"] = "coldridgevalley",
	},
	[20] = {
		["y"] = -967.499951172,
		["x"] = 5277.33334961,
		["s"] = 9.037499755860001,
		["o"] = "tirisfal",
	},
	[545] = {
		["y"] = -93.33333740240001,
		["x"] = 5196.08334961,
		["s"] = 6.2916665039,
		["o"] = "gilneas_terrain2",
	},
	[890] = {
		["y"] = 715.416796876,
		["x"] = -1846.666796875,
		["s"] = 3.53333593751,
		["o"] = "campnarachestart",
	},
	[321] = {
		["y"] = -297.33334961,
		["x"] = -1098.729199218,
		["s"] = 3.47875,
		["o"] = "orgrimmar",
	},
	[21] = {
		["y"] = -533.333325196,
		["x"] = 5194.000048828,
		["s"] = 8.399999511719999,
		["o"] = "silverpine",
	},
	[544] = {
		["y"] = -1226.25,
		["x"] = 973.333398438,
		["s"] = 9.02916601562,
		["o"] = "thelostisles_terrain2",
	},
	[795] = {
		["y"] = -140.41665039,
		["x"] = -1986.6666625976,
		["s"] = 2.379166625976,
		["o"] = "moltenfront",
	},
	[467] = {
		["y"] = -4387.083325196,
		["x"] = 5105,
		["s"] = 10.05416699218,
		["o"] = "zangarmarsh",
	},
	[684] = {
		["y"] = -93.33333740240001,
		["x"] = 5196.08334961,
		["s"] = 6.2916665039,
		["o"] = "ruinsofgilneas",
	},
	[475] = {
		["y"] = -4881.666601562,
		["x"] = 5230.833398438,
		["s"] = 10.84999951172,
		["o"] = "bladesedgemountains",
	},
	[700] = {
		["y"] = 231.25,
		["x"] = 6371.5,
		["s"] = 10.54166601562,
		["o"] = "twilighthighlands_terrain1",
	},
	[708] = {
		["y"] = 232.0833251954,
		["x"] = 4881.916674804,
		["s"] = 4.02916658497544,
		["o"] = "tolbarad",
	},
	[23] = {
		["y"] = -940.8333007819999,
		["x"] = 6341.5,
		["s"] = 8.0625,
		["o"] = "easternplaguelands",
	},
	[491] = {
		["y"] = -3004.472279,
		["x"] = 2719.306683,
		["s"] = 12.09166577148,
		["o"] = "howlingfjord",
	},
	[605] = {
		["y"] = -795.750097656,
		["x"] = 1930.166699218,
		["s"] = 2.704166381844,
		["o"] = "kezan",
	},
	[613] = {
		["y"] = 544.16665039,
		["x"] = 4133.166796874,
		["s"] = 13.89166552736,
		["o"] = "vashjir",
	},
	[24] = {
		["y"] = -496.25,
		["x"] = 5514.000024414,
		["s"] = 9.724999755860001,
		["o"] = "hillsbradfoothills",
	},
	[905] = {
		["y"] = 2051,
		["x"] = 2268,
		["s"] = 0.55,
	},
	[891] = {
		["y"] = 305,
		["x"] = -901.6667968739999,
		["s"] = 3.6125,
		["o"] = "echoislesstart",
	},
	[261] = {
		["y"] = 1374.583300782,
		["x"] = -2396.66665039,
		["s"] = 8.116666503899999,
		["o"] = "silithus",
	},
	[495] = {
		["y"] = -4420.755559,
		["x"] = 2071.175866,
		["s"] = 14.22499926758,
		["o"] = "thestormpeaks",
	},
	[479] = {
		["y"] = -5091.25,
		["x"] = 5903.333398438,
		["s"] = 11.149999343867,
		["o"] = "netherstorm",
	},
	[201] = {
		["y"] = 1393.333300782,
		["x"] = -1906.6666625976,
		["s"] = 7.399999633796,
		["o"] = "ungorocrater",
	},
	[807] = {
		["y"] = 2013,
		["x"] = 1807.81,
		["s"] = 7.850002,
		["o"] = "valleyofthefourwinds",
	},
	[26] = {
		["y"] = -493.333325196,
		["x"] = 6199,
		["s"] = 7.7,
		["o"] = "hinterlands",
	},
	[541] = {
		["y"] = -6656.25,
		["x"] = 40.41669921800008,
		["s"] = 7.354166259774,
		["o"] = "hrothgarslanding",
	},
	[510] = {
		["y"] = -3682.092184,
		["x"] = 2150.386409,
		["s"] = 5.44583325196,
		["o"] = "crystalsongforest",
	},
	[709] = {
		["y"] = 44.58333740239999,
		["x"] = 4801.5,
		["s"] = 3.675,
		["o"] = "tolbaraddailyarea",
	},
	[27] = {
		["y"] = 588.3333007819999,
		["x"] = 5456.5,
		["s"] = 9.795833007819999,
		["o"] = "dunmorogh",
	},
	[301] = {
		["y"] = 1399.166601562,
		["x"] = 5539.416674804,
		["s"] = 3.4749999179908,
		["o"] = "stormwindcity",
	},
	[606] = {
		["y"] = -1039.166601562,
		["x"] = -1614.1666748046,
		["s"] = 8.491666748046001,
		["o"] = "hyjal_terrain1",
	},
	[614] = {
		["y"] = 781.25,
		["x"] = 4237.333398438,
		["s"] = 8.150000000000002,
		["o"] = "vashjirdepths",
	},
	[28] = {
		["y"] = 1020,
		["x"] = 5948.5833312988,
		["s"] = 4.462499694831999,
		["o"] = "searinggorge",
	},
	[32] = {
		["y"] = 1773.333203126,
		["x"] = 6050.6666625976,
		["s"] = 4.999999877923999,
		["o"] = "deadwindpass",
	},
	[892] = {
		["y"] = -654.166601562,
		["x"] = 5454.416601562,
		["s"] = 2.17916796876,
		["o"] = "deathknellstart",
	},
	[811] = {
		["y"] = 1842.59,
		["x"] = 1847.4,
		["s"] = 5.066668,
		["o"] = "valeofeternalblossoms",
	},
	[29] = {
		["y"] = 1197.083300782,
		["x"] = 5976.9166625976,
		["s"] = 6.304166381844,
		["o"] = "burningsteppes",
	},
	[362] = {
		["y"] = 369.999987793,
		["x"] = -1903.3333251954,
		["s"] = 2.08749987793,
		["o"] = "thunderbluff",
	},
	[464] = {
		["y"] = -1251.25,
		["x"] = -3200,
		["s"] = 8.1416660156,
		["o"] = "azuremystisle",
	},
	[341] = {
		["y"] = 713.8482421880001,
		["x"] = 6026.7182739258,
		["s"] = 1.581250122062,
		["o"] = "ironforge",
	},
	[30] = {
		["y"] = 1387.916601562,
		["x"] = 5576.916674804,
		["s"] = 6.94166650392,
		["o"] = "elwynn",
	},
	[476] = {
		["y"] = -1658.3333374024,
		["x"] = -3285,
		["s"] = 6.5249980468,
		["o"] = "bloodmystisle",
	},
	[471] = {
		["y"] = -1088.063330078,
		["x"] = -3086.7265625,
		["s"] = 2.1135410156,
		["o"] = "theexodar",
	},
};

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