---------------------------------------------------------------------------------------
-- NxMapData - Map code
-- Copyright 2007-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

--[[

4 = Durotar
9 = Mulgore
11 = Barrens (Northern Barrens)
13 = Kalimdor (continent 1)
14 = Azeroth (continent 2)
15 = Alterac
16 = Arathi
17 = Badlands
19 = BlastedLands
20 = Tirisfal
21 = Silverpine
22 = WesternPlaguelands
23 = EasternPlaguelands
24 = Hilsbrad
26 = Hinterlands
27 = DunMorogh
28 = SearingGorge
29 = BurningSteppes
30 = Elwynn
32 = DeadwindPass
34 = Duskwood
35 = LochModan
36 = Redridge
37 = Stranglethorn (Northern Stranglethorn)
38 = SwampOfSorrows
39 = Westfall
40 = Wetlands
41 = Teldrassil
42 = Darkshore
43 = Ashenvale
61 = ThousandNeedles
81 = StonetalonMountains
101 = Desolace
121 = Feralas
141 = Dustwallow
161 = Tanaris
181 = Aszhara
182 = Felwood
201 = UngoroCrater
241 = Moonglade
261 = Silithus
281 = Winterspring
301 = Stormwind
321 = Ogrimmar
341 = Ironforge
362 = ThunderBluff
381 = Darnassis
382 = Undercity
401 = AlteracValley
443 = WarsongGulch
461 = ArathiBasin
462 = EversongWoods
463 = Ghostlands
464 = AzuremystIsle
465 = Hellfire
466 = Expansion01 (continent 3 Outland)
467 = Zangarmarsh
471 = TheExodar
473 = ShadowmoonValley
475 = BladesEdgeMountains
476 = BloodmystIsle
477 = Nagrand
478 = TerokkarForest
479 = Netherstorm
480 = SilvermoonCity
481 = ShattrathCity
482 = NetherstormArena
485 = Northrend (continent 4)
486 = BoreanTundra
488 = Dragonblight
490 = GrizzlyHills
491 = HowlingFjord
492 = IcecrownGlacier
493 = SholazarBasin
495 = TheStormPeaks
496 = ZulDrak
499 = Sunwell
501 = LakeWintergrasp
502 = ScarletEnclave
504 = Dalaran
510 = CrystalsongForest
512 = StrandoftheAncients
520 = TheNexus
521 = CoTStratholme
522 = Ahnkahet
523 = UtgardeKeep
524 = UtgardePinnacle
525 = HallsofLightning
526 = Ulduar77
527 = TheEyeofEternity
528 = Nexus80
529 = Ulduar
530 = Gundrak
531 = TheObsidianSanctum
532 = VaultofArchavon
533 = AzjolNerub
534 = DrakTharonKeep
535 = Naxxramas
536 = VioletHold
540 = IsleofConquest
541 = HrothgarsLanding
542 = TheArgentColiseum
609 = RubySanctum

Cataclysm

-- Continent 1
606 = Mount Hyjal
607 = Southern Barrens
720 = Uldum
772 = Ahn'Qiraj: The Fallen Kingdom

-- Continent 2
689 = Stranglethorn Vale (full map)
673 = The Cape of Stranglethorn (south part)

-- Continent 2 (Vashj'ir sub continent of EK)
613 = Vashj'ir (full map)
610 = Kelp'thar Forest
614 = Abyssal Depths
615 = Shimmering Expanse

-- Continent 5 (The Maelstrom)
751 = The Maelstrom (continent)
544 = The Lost Isles (goblin starting)
605 = Kezan (goblin city)
640 = Deepholm
737 = The Maelstrom

545 = Gilneas (starting phase)
611 = GilneasCity (starting city phase)
626 = TwinPeaks (battle ground)
680 = RagefireChasm
685 = Ruins of Gilneas City (Worgen city)
686 = ZulFarrak
687 = TheTempleOfAtalHakkar
688 = BlackfathomDeeps
690 = TheStockade
691 = Gnomeregan
692 = Uldaman
696 = MoltenCore
699 = DireMaul (multiple layers for each wing)
700 = Twilight Highlands
704 = BlackrockDepths
708 = Tol Barad (battle ground)
709 = Tol Barad Peninsula
717 = RuinsofAhnQiraj
718 = OnyxiasLair
721 = BlackrockSpire
736 = BattleForGilneas (battle ground)
747 = LostCityOfTheTolvir
749 = WailingCaverns
750 = Maraudon
752 = BardinHold
753 = BlackrockCaverns
754 = BlackwingDescent
755 = BlackwingLair
756 = TheDeadmines
757 = GrimBatol
758 = BastionOfTwilight
759 = HallsOfOrigination
760 = RazorfenDowns
761 = RazorfenKraul
762 = ScarletMonastery (multiple layers for each wing)
763 = Scholomance
764 = ShadowfangKeep
765 = Stratholme
766 = AhnQiraj
767 = ThroneOfTheTides
768 = TheStonecore
769 = TheVortexPinnacle
773 = ThroneOfTheFourWinds
--]]


	


-- Local
NxMap = {};
local Map = RDXMAP.Map

--[[
Zone (id carbonite)
NxMap.MapGenAreas {
	[122] = {
		11.52916601562, -- [1] scale
		-1714.166601562, -- [2] x
		-979.5833007819999, -- [3] y
		"boreantundra", -- [4] overlay
	},

Continent (id carbonite)
RDXMAP.MapInfo = {
	{
		Name = "Kalimdor",
		FileName = "Kalimdor",
		X = -1800,	-- Was 0
		Y = 200,
		Min = 1001,
		Max = 1033,
	},
	
NxMap.BloodelfXO = -503
NxMap.BloodelfYO = 516
NxMap.DraeneiXO = -3500
NxMap.DraeneiYO = -2010

Zone  info (id2 carbonite)
NxMap.MapWorldInfo = {
	[2029] = {
		Name = "Isle of Quel'Danas",
		XOff = NxMap.BloodelfXO,
		YOff = NxMap.BloodelfYO,
		MId = 2011,
		Fish = 450,
	},

Zone overlay (subzone)
NxMap.ZoneOverlays = {
		["moonglade"] = {
			["shrineofremulos"] = "209,91,271,296",
			["lakeeluneara"] = "219,273,431,319",
			["stormragebarrowdens"] = "542,210,275,346",
			["nighthaven"] = "370,135,346,244",
		},
	
]]
--------
-- Map tables

NxMap.MapGenAreas = {	-- Auto gen by ConvertMapData()
	[122] = {
		11.52916601562, -- [1]
		-1714.166601562, -- [2]
		-979.5833007819999, -- [3]
		"boreantundra", -- [4]
	},
	[31] = {
		12.92916601564, -- [1]
		-603.3333007819999, -- [2]
		-1644.583203126, -- [3]
		"darkshore", -- [4]
	},
	[125] = {
		11.21666625976, -- [1]
		-725.41665039, -- [2]
		-1115, -- [3]
		"dragonblight", -- [4]
	},
	[126] = {
		10.49999975586, -- [1]
		222.083325196, -- [2]
		-1103.333300782, -- [3]
		"grizzlyhills", -- [4]
	},
	[32] = {
		3.07916674804, -- [1]
		-637.5, -- [2]
		-2092.91660156, -- [3]
		"darnassus", -- [4]
	},
	[128] = {
		12.541666625976, -- [1]
		-1088.75, -- [2]
		-1885.416601562, -- [3]
		"icecrownglacier", -- [4]
	},
	[33] = {
		4.999999877923999, -- [1]
		166.6666625976, -- [2]
		1973.333203126, -- [3]
		"deadwindpass", -- [4]
	},
	[132] = {
		9.987500000000001, -- [1]
		120, -- [2]
		-1533.749902344, -- [3]
		"zuldrak", -- [4]
	},
	[35] = {
		8.99166601562, -- [1]
		-846.666601562, -- [2]
		-90.4166625976, -- [3]
		"desolace", -- [4]
	},
	[37] = {
		9.795833007819999, -- [1]
		-427.5, -- [2]
		788.3333007819999, -- [3]
		"dunmorogh", -- [4]
	},
	[38] = {
		10.57499926758, -- [1]
		392.499975586, -- [2]
		-361.66665039, -- [3]
		"durotar", -- [4]
	},
	[39] = {
		5.399999877936, -- [1]
		-166.6666625976, -- [2]
		1943.333203126, -- [3]
		"duskwood", -- [4]
	},
	[10] = {
		11.02916699218, -- [1]
		674.5833007819999, -- [2]
		-1076.25, -- [3]
		"aszhara", -- [4]
	},
	[40] = {
		10.5, -- [1]
		195, -- [2]
		406.666796876, -- [3]
		"dustwallow", -- [4]
	},
	[41] = {
		8.0625, -- [1]
		457.5, -- [2]
		-740.8333007819999, -- [3]
		"easternplaguelands", -- [4]
	},
	[164] = {
		2.704166381844, -- [1]
		-425.833300782, -- [2]
		1546.249902344, -- [3]
		"kezan", -- [4]
	},
	[42] = {
		6.94166650392, -- [1]
		-307.083325196, -- [2]
		1587.916601562, -- [3]
		"elwynn", -- [4]
	},
	[168] = {
		5.60416601562, -- [1]
		-1014.166601562, -- [2]
		803.749951172, -- [3]
		"vashjirkelpforest", -- [4]
	},
	[43] = {
		9.85, -- [1]
		897.5, -- [2]
		-2208.33320312, -- [3]
		"eversongwoods", -- [4]
	},
	[11] = {
		8.1416660156, -- [1]
		2100, -- [2]
		558.75, -- [3]
		"azuremystisle", -- [4]
	},
	[174] = {
		10.19999975586, -- [1]
		-610.41665039, -- [2]
		-559.16665039, -- [3]
		"deepholm", -- [4]
	},
	[45] = {
		12.12499926758, -- [1]
		-359.583325196, -- [2]
		-1447.499902344, -- [3]
		"felwood", -- [4]
	},
	[180] = {
		10.54166601562, -- [1]
		487.5, -- [2]
		431.25, -- [3]
		"twilighthighlands_terrain1", -- [4]
	},
	[46] = {
		13.89999951172, -- [1]
		-1088.333300782, -- [2]
		473.333300782, -- [3]
		"feralas", -- [4]
	},
	[47] = {
		6.600000000000001, -- [1]
		1056.666601562, -- [2]
		-1653.333203126, -- [3]
		"ghostlands", -- [4]
	},
	[12] = {
		6.14166650392, -- [1]
		380.41665039, -- [2]
		1170.833300782, -- [3]
		"badlands", -- [4]
	},
	[206] = {
		3.6375, -- [1]
		2562.91640626, -- [2]
		720.833203124, -- [3]
		"ammenvalestart", -- [4]
	},
	[208] = {
		3.6125, -- [1]
		898.3332031260001, -- [2]
		105, -- [3]
		"echoislesstart", -- [4]
	},
	[210] = {
		2.700000000000001, -- [1]
		728.3332031259999, -- [2]
		-0, -- [3]
		"valleyoftrialsstart", -- [4]
	},
	[212] = {
		2.17916796876, -- [1]
		-429.583398438, -- [2]
		-454.166601562, -- [3]
		"deathknellstart", -- [4]
	},
	[214] = {
		1.9375, -- [1]
		-37.5, -- [2]
		1714.16640625, -- [3]
		"northshire", -- [4]
	},
	[55] = {
		10.32916601562, -- [1]
		-1107.916601562, -- [2]
		-296.25, -- [3]
		"hellfire", -- [4]
	},
	[56] = {
		9.724999755860001, -- [1]
		-369.999975586, -- [2]
		-296.25, -- [3]
		"hillsbradfoothills", -- [4]
	},
	[57] = {
		1.581250122062, -- [1]
		142.7182739258, -- [2]
		913.8482421880001, -- [3]
		"ironforge", -- [4]
	},
	[211] = {
		1.929166015626,
		-195.8333984376,
		1192.5,
		"coldridgevalley",
	},	
	[213] = {
		3.7, -- [1]
		-241.25, -- [2]
		945.416796876, -- [3]
		"newtinkertownstart", -- [4]
	},
	[215] = {
		3.2, -- [1]
		1076.666796876, -- [2]
		-2166.66660156, -- [3]
		"sunstriderislestart", -- [4]
	},
	[59] = {
		5.51666625976, -- [1]
		398.749975586, -- [2]
		897.5, -- [3]
		"lochmodan", -- [4]
	},
	[207] = {
		3.53333593751, -- [1]
		-46.666796875, -- [2]
		515.416796876, -- [3]
		"campnarachestart", -- [4]
	},
	[209] = {
		2.90000195313, -- [1]
		-298.333398438, -- [2]
		-2206.66660156, -- [3]
		"shadowglenstart", -- [4]
	},
	[146] = {
		6.325, -- [1]
		809.5833007819999, -- [2]
		-617.5, -- [3]
		"scarletenclave", -- [4]
	},
	[199] = {
		2.379166625976, -- [1]
		-186.6666625976, -- [2]
		-340.41665039, -- [3]
		"moltenfront", -- [4]
	},
	[197] = {
		8.099999664314, -- [1]
		-778.3333007819999, -- [2]
		1606.666601562, -- [3]
		"ahnqirajthefallenkingdom", -- [4]
	},
	[62] = {
		4.6166665039, -- [1]
		276.25, -- [2]
		-1698.333203126, -- [3]
		"moonglade", -- [4]
	},
	[166] = {
		14.825, -- [1]
		-271.25, -- [2]
		-40.8333312988, -- [3]
		"southernbarrens", -- [4]
	},
	[63] = {
		10.89999951172, -- [1]
		-440.833300782, -- [2]
		33.75, -- [3]
		"mulgore", -- [4]
	},
	[169] = {
		1.7791665039, -- [1]
		-386.66665039, -- [2]
		261.25, -- [3]
		"gilneascity", -- [4]
	},
	[64] = {
		11.04999999998, -- [1]
		-2059.16660156, -- [2]
		-8.333332824699999, -- [3]
		"nagrand", -- [4]
	},
	[129] = {
		8.7125, -- [1]
		-1385.833300782, -- [2]
		-1457.499902344, -- [3]
		"sholazarbasin", -- [4]
	},
	[66] = {
		11.149999343867, -- [1]
		-1096.666601562, -- [2]
		-1091.25, -- [3]
		"netherstorm", -- [4]
	},
	[182] = {
		3.675, -- [1]
		-482.5, -- [2]
		-75.4166625976, -- [3]
		"tolbaraddailyarea", -- [4]
	},
	[68] = {
		3.47875, -- [1]
		701.2708007819999, -- [2]
		-497.33334961, -- [3]
		"orgrimmar", -- [4]
	},
	[170] = {
		13.89166552736, -- [1]
		-1750.833203126, -- [2]
		744.16665039, -- [3]
		"vashjir", -- [4]
	},
	[179] = {
		13.10416601562, -- [1]
		-595.41665039, -- [2]
		2192.91660156, -- [3]
		"stranglethornvale", -- [4]
	},
	[178] = {
		1.7791665039, -- [1]
		-386.66665039, -- [2]
		261.25, -- [3]
		"ruinsofgilneascity", -- [4]
	},
	[72] = {
		5.13749975586, -- [1]
		295.833325196, -- [2]
		1702.916601562, -- [3]
		"redridge", -- [4]
	},
	[177] = {
		6.2916665039, -- [1]
		-687.91665039, -- [2]
		106.6666625976, -- [3]
		"ruinsofgilneas", -- [4]
	},
	[175] = {
		7.89166625976, -- [1]
		-421.66665039, -- [2]
		2503.33320312, -- [3]
		"thecapeofstranglethorn", -- [4]
	},
	[19] = {
		10.84999951172, -- [1]
		-1769.166601562, -- [2]
		-881.666601562, -- [3]
		"bladesedgemountains", -- [4]
	},
	[76] = {
		4.462499694831999, -- [1]
		64.58333129880001, -- [2]
		1220, -- [3]
		"searinggorge", -- [4]
	},
	[172] = {
		9.699999267579999, -- [1]
		-1336.249902344, -- [2]
		951.25, -- [3]
		"vashjirruins", -- [4]
	},
	[78] = {
		11, -- [1]
		-845, -- [2]
		389.583325196, -- [3]
		"shadowmoonvalley", -- [4]
	},
	[79] = {
		2.6125, -- [1]
		-1227.051757812, -- [2]
		294.790893554, -- [3]
		"shattrathcity", -- [4]
	},
	[80] = {
		8.116666503899999, -- [1]
		-596.66665039, -- [2]
		1174.583300782, -- [3]
		"silithus", -- [4]
	},
	[81] = {
		2.42291699218, -- [1]
		1280.15, -- [2]
		-2030.74179688, -- [3]
		"silvermooncity", -- [4]
	},
	[82] = {
		8.399999511719999, -- [1]
		-689.999951172, -- [2]
		-333.333325196, -- [3]
		"silverpine", -- [4]
	},
	[83] = {
		11.79999975586, -- [1]
		-780.41665039, -- [2]
		-680.8333007819999, -- [3]
		"stonetalonmountains", -- [4]
	},
	[84] = {
		3.4749999179908, -- [1]
		-344.583325196, -- [2]
		1599.166601562, -- [3]
		"stormwindcity", -- [4]
	},
	[85] = {
		8.19999975586, -- [1]
		-348.749975586, -- [2]
		2203.33320312, -- [3]
		"stranglethornjungle", -- [4]
	},
	[171] = {
		8.150000000000002, -- [1]
		-1646.666601562, -- [2]
		981.25, -- [3]
		"vashjirdepths", -- [4]
	},
	[22] = {
		6.304166381844, -- [1]
		92.9166625976, -- [2]
		1397.083300782, -- [3]
		"burningsteppes", -- [4]
	},
	[88] = {
		5.016666015619999, -- [1]
		416.25, -- [2]
		1907.083203126, -- [3]
		"swampofsorrows", -- [4]
	},
	[89] = {
		14.4249990310694, -- [1]
		12.49999923706, -- [2]
		1154.166601562, -- [3]
		"tanaris", -- [4]
	},
	[90] = {
		11.74999951172, -- [1]
		-847.0833007819999, -- [2]
		-2369.58320312, -- [3]
		"teldrassil", -- [4]
	},
	[181] = {
		4.02916658497544, -- [1]
		-402.083325196, -- [2]
		112.0833251954, -- [3]
		"tolbarad", -- [4]
	},
	[183] = {
		12.38749951172, -- [1]
		-488.333300782, -- [2]
		1605.833300782, -- [3]
		"uldum_terrain1", -- [4]
	},
	[185] = {
		3.1, -- [1]
		-311.25, -- [2]
		-274.16665039, -- [3]
		"themaelstrom", -- [4]
	},
	[165] = {
		8.491666748046001, -- [1]
		185.8333251954, -- [2]
		-1239.166601562, -- [3]
		"hyjal_terrain1", -- [4]
	},
	[163] = {
		9.02916601562, -- [1]
		-876.666601562, -- [2]
		-576.25, -- [3]
		"thelostisles_terrain2", -- [4]
	},
	[96] = {
		10.79999951172, -- [1]
		-1416.666601562, -- [2]
		199.999987793, -- [3]
		"terokkarforest", -- [4]
	},
	[97] = {
		11.491666656494, -- [1]
		-40.4166656494, -- [2]
		-362.083325196, -- [3]
		"barrens", -- [4]
	},
	[150] = {
		7.354166259774, -- [1]
		-559.5833007819999, -- [2]
		-2156.25, -- [3]
		"hrothgarslanding", -- [4]
	},
	[99] = {
		2.1135410156, -- [1]
		2213.2734375, -- [2]
		721.936669922, -- [3]
		"theexodar", -- [4]
	},
	[100] = {
		7.7, -- [1]
		315, -- [2]
		-293.333325196, -- [3]
		"hinterlands", -- [4]
	},
	[161] = {
		6.2916665039, -- [1]
		-687.91665039, -- [2]
		106.6666625976, -- [3]
		"gilneas_terrain2", -- [4]
	},
	[123] = {
		5.44583325196, -- [1]
		-288.75, -- [2]
		-1300.416601562, -- [3]
		"crystalsongforest", -- [4]
	},
	[103] = {
		8.799999389643999, -- [1]
		86.6666625976, -- [2]
		793.3333007819999, -- [3]
		"thousandneedles", -- [4]
	},
	[104] = {
		2.08749987793, -- [1]
		-103.3333251954, -- [2]
		169.999987793, -- [3]
		"thunderbluff", -- [4]
	},
	[105] = {
		9.037499755860001, -- [1]
		-606.66665039, -- [2]
		-767.499951172, -- [3]
		"tirisfal", -- [4]
	},
	[211] = {
		1.929166015626, -- [1]
		-195.8333984376, -- [2]
		1192.5, -- [3]
		"coldridgevalley", -- [4]
	},
	[107] = {
		7.399999633796, -- [1]
		-106.6666625976, -- [2]
		1193.333300782, -- [3]
		"ungorocrater", -- [4]
	},
	[108] = {
		1.918750061035, -- [1]
		-174.6385253906, -- [2]
		-375.5890625, -- [3]
		"undercity", -- [4]
	},
	[131] = {
		5.94999975586, -- [1]
		-865.8333007819999, -- [2]
		-1143.333300782, -- [3]
		"lakewintergrasp", -- [4]
	},
	[127] = {
		12.09166577148, -- [1]
		279.583325196, -- [2]
		-623.3333007819999, -- [3]
		"howlingfjord", -- [4]
	},
	[111] = {
		8.599999816887999, -- [1]
		-83.33333129880001, -- [2]
		-673.3333007819999, -- [3]
		"westernplaguelands", -- [4]
	},
	[112] = {
		6.999999633796, -- [1]
		-603.3333007819999, -- [2]
		1880, -- [3]
		"westfall", -- [4]
	},
	[113] = {
		8.270833374023999, -- [1]
		77.9166625976, -- [2]
		429.583300782, -- [3]
		"wetlands", -- [4]
	},
	[114] = {
		12.299999755866, -- [1]
		198.3333251954, -- [2]
		-1758.75, -- [3]
		"winterspring", -- [4]
	},
	[115] = {
		10.05416699218, -- [1]
		-1895, -- [2]
		-387.083325196, -- [3]
		"zangarmarsh", -- [4]
	},
	[130] = {
		14.22499926758, -- [1]
		-368.333325196, -- [2]
		-2039.58320312, -- [3]
		"thestormpeaks", -- [4]
	},
	[4] = {
		6.95416650392, -- [1]
		225.41665039, -- [2]
		28.3333312988, -- [3]
		"arathi", -- [4]
	},
	[5] = {
		11.53333276368, -- [1]
		-339.999975586, -- [2]
		-934.5833007819999, -- [3]
		"ashenvale", -- [4]
	},
	[119] = {
		6.654166015640001, -- [1]
		1060.416601562, -- [2]
		-2713.74980468, -- [3]
		"sunwell", -- [4]
	},
	[20] = {
		7.325, -- [1]
		238.75, -- [2]
		2116.66660156, -- [3]
		"blastedlands", -- [4]
	},
	[21] = {
		6.5249980468, -- [1]
		2015, -- [2]
		151.6666625976, -- [3]
		"bloodmystisle", -- [4]
	},
}

NxMap.MapInfo = {
	[0] = {	-- Dummy
		Name = "Instance",
		X = 0,
		Y = 0,
	},
	{
		Name = "Kalimdor",
		FileName = "Kalimdor",
		X = -1800,	-- Was 0
		Y = 200,
		Min = 1001,
		Max = 1033,
	},
	{
		Name = "Eastern Kingdoms",
		FileName = "Azeroth",
		X = 5884,	-- Was 3784
		Y = -200,
		Min = 2001,
		Max = 2048,
	},
	{
		Name = "Outland",
		FileName = "Expansion01",
		X = 7000,
		Y = -4000,
		Min = 3001,
		Max = 3008,
	},
	{
		Name = "Northrend",
		FileName = "Northrend",
		X = 600,
		Y = -4500,
		Min = 4001,
		Max = 4014,
	},
	{
		Name = "The Maelstrom",
		FileName = "TheMaelstromContinent",
		X = 1100,
		Y = -1800, 
		Min = 5001,
		Max = 5005,
	},
	[6] = {
	    Name = "Pandaria",
		FileName = "Pandaria",
		X = 2350,
		Y = 300,
		Min = 6001,
		Max = 6015,
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
}

NxMap.BloodelfXO = -503
NxMap.BloodelfYO = 516
NxMap.DraeneiXO = -3500
NxMap.DraeneiYO = -2010

NxMap.MapWorldInfo = {

	-- Dummy if we get a zero on startup
	[0] = {
		10,
		0, 0,
		0, 0,  -- Index 4,5 XY world position created for zones in continents 1-5, 9
		Overlay = "barrens",
	},

	[1000] = {
		73.3282, -- Scale
		-3398.85, -2552.91, -- Origin
	},
	[1001] = {
		Name = "Ashenvale",
		Fish = 150,
		QAchievementId = 4925,
		QAchievementIdH = 4976,
	},
	[1002] = {
		Name = "Azshara",
		Fish = 300,
		QAchievementIdH = 4927,
	},
	[1003] = {
		Name = "Azuremyst Isle",
		XOff = NxMap.DraeneiXO,
		YOff = NxMap.DraeneiYO,
		MId = 1003,
		Fish = 25,
	},
	[1004] = {
		Name = "Bloodmyst Isle",
		XOff = NxMap.DraeneiXO,
		YOff = NxMap.DraeneiYO,
		MId = 1003,
		Fish = 75,
		QAchievementIdA = 4926,
	},
	[1005] = {
		Name = "Darkshore",
		Fish = 75,
		QAchievementIdA = 4928,
	},
	[1006] = {
		Name = "Darnassus",
		2.116669, -- Scale (0.6668302)
		-587.6726, -2047.663, -- Origin (WH 211.6669, 141.1459)
		 -- -2012.279 -9985.129, 87.5039 35.8759
		 -- -2400.08 -9702.901, 50.8613 75.8668
		Overlay = "darnassis",
		City = true,
		MMOutside = true,
		Fish = 75,
	},
	[1007] = {
		Name = "Desolace",
		Fish = 225,
		QAchievementId = 4930,
	},
	[1008] = {
		Name = "Durotar",
		Fish = 25,
	},
	[1009] = {
		Name = "Dustwallow Marsh",
		Fish = 225,
		QAchievementId = 4929,
		QAchievementIdH = 4978,
	},
	[1010] = {
		Name = "Felwood",
		Fish = 300,
		QAchievementId = 4931,
	},
	[1011] = {
		Name = "Feralas",
		Fish = 300,
		QAchievementId = 4932,
		QAchievementIdH = 4979,
	},
	[1012] = {
		Name = "Moonglade",
		Fish = 300,
	},
	[1013] = {
		Name = "Mulgore",
		Fish = 25,
	},
	[1014] = {
		Name = "Orgrimmar",
		2.805208, -- Scale (0.6669141)
		736.1202, -454.7754, -- Origin (WH 280.5208, 187.0833)
		 -- 4362.793 -1397.708, 48.63751 93.66625
		 -- 4452.566 -1601.87, 55.03796 71.84045
		Overlay = "ogrimmar",
		City = true,
		MMOutside = true,
--		MId = 1014,
		Fish = 75,
	},
	[1015] = {
		Name = "Silithus",
		Fish = 425,
		QAchievementIdA = 4934,
	},
	[1016] = {
		Name = "Stonetalon Mountains",
		Fish = 150,
		QAchievementId = 4936,
		QAchievementIdH = 4980,
	},
	[1017] = {
		Name = "Tanaris",
		Fish = 300,
		QAchievementId = 4935,
	},
	[1018] = {
		Name = "Teldrassil",
		Fish = 25,
	},
	[1019] = {
		Name = "Northern Barrens",
		Fish = 75,
		QAchievementIdH = 4933,
	},
	[1020] = {
		Name = "The Exodar",
		XOff = NxMap.DraeneiXO,
		YOff = NxMap.DraeneiYO,
		City = true,
		MId = 1003,
	},
	[1021] = {
		Name = "Thousand Needles",
		Fish = 225,
		QAchievementId = 4938,
	},
	[1022] = {
		Name = "Thunder Bluff",
		2.087504, -- Scale (0.666666)
		-103.3333, 170, -- Origin (WH 208.7504, 139.1668)
		 -- -288.8936 975.1409, 21.8225 17.9843
		 -- -134.5071 1215.782, 36.614 52.5675
		 -- -180.5793 1321.172, 32.1999 67.7133
		Overlay = "thunderbluff",
		City = true,
		MMOutside = true,
		Fish = 75,
	},
	[1023] = {
		Name = "Un'Goro Crater",
		Fish = 300,
		QAchievementId = 4939,
	},
	[1024] = {
		Name = "Winterspring",
		Fish = 425,
		QAchievementId = 4940,
	},

	-- Cataclysm

	[1025] = {
		Name = "Ahn'Qiraj: The Fallen Kingdom",
		Fish = 1,
	},
	[1026] = {
		Name = "Mount Hyjal",
		Fish = 1,
		QAchievementId = 4870,
	},
	[1027] = {
		Name = "Southern Barrens",
		Fish = 75,
		QAchievementId = 4937,
		QAchievementIdH = 4981,
	},
	[1028] = {
		Name = "Uldum",
		Fish = 75,
		QAchievementId = 4872,
	},

	-- Mists

	[1029] = {
		Name = "Ammen Vale",
		XOff = NxMap.DraeneiXO,
		YOff = NxMap.DraeneiYO,
		MId = 1003,
		StartZone = true,
	},
	[1030] = {
		Name = "Camp Narache",
		StartZone = true,
	},
	[1031] = {
		Name = "Echo Isles",
		StartZone = true,
	},
	[1032] = {
		Name = "Shadowglen",
		StartZone = true,
	},
	[1033] = {
		Name = "Valley of Trials",
		StartZone = true,
	},

	[2000] = {
		81.53, -- Scale
		-3645.96, -2249.31, -- Origin
	},
	[2001] = {	-- Merged into Hillsbrad Foothills for Cataclysm
		Name = "Alterac Mountains",
		5.599993, -- Scale (0.6666676)
		-156.6661, -299.9998, -- Origin (WH 559.9993, 373.3334)
		 -- 599.2264 -222.7941, 49.3771 68.4217
		 -- 830.212 -798.6328, 57.6266 37.5732
		Overlay = "alterac",
		Fish = 225,
	},
	[2002] = {
		Name = "Arathi Highlands",
		Fish = 225,
		QAchievementId = 4896,
	},
	[2003] = {
		Name = "Badlands",
		QAchievementId = 4900,
	},
	[2004] = {
		Name = "Blasted Lands",
		QAchievementId = 4909,
	},
	[2005] = {
		Name = "Burning Steppes",
		Fish = 425,
		QAchievementId = 4901,
	},
	[2006] = {
		Name = "Deadwind Pass",
		Fish = 425,
	},
	[2007] = {
		Name = "Dun Morogh",
		Fish = 25,
	},
	[2008] = {
		Name = "Duskwood",
		Fish = 150,
		QAchievementIdA = 4907,
	},
	[2009] = {
		Name = "Eastern Plaguelands",
		Fish = 425,
		QAchievementId = 4892,
	},
	[2010] = {
		Name = "Elwynn Forest",
		Fish = 25,
	},
	[2011] = {
		Name = "Eversong Woods",
		XOff = NxMap.BloodelfXO,
		YOff = NxMap.BloodelfYO,
		MId = 2011,
		Fish = 25,
	},
	[2012] = {
		Name = "Ghostlands",
		XOff = NxMap.BloodelfXO,
		YOff = NxMap.BloodelfYO,
		MId = 2011,
		Fish = 75,
		QAchievementIdH = 4908,
	},
	[2013] = {
		Name = "Hillsbrad Foothills",
		Fish = 150,
		QAchievementIdH = 4895,
	},
	[2014] = {
		Name = "Ironforge",
		1.581249, -- Scale (0.6673273)
		142.7185, 913.8483, -- Origin (WH 158.1249, 105.521)
		 -- 1168.239 4834.522, 57.5047 50.2803
		 -- 1002.861 4949.052, 36.5874 71.9877
		 -- 953.4069 4990.946, 30.3323 79.9281
		Overlay = "ironforge",
		City = true,
		Fish = 75,
	},
	[2015] = {
		Name = "Loch Modan",
		Fish = 75,
		QAchievementIdA = 4899,
	},
	[2016] = {
		Name = "Redridge Mountains",
		Fish = 150,
		QAchievementIdA = 4902,
	},
	[2017] = {
		Name = "Searing Gorge",
		QAchievementId = 4910,
	},
	[2018] = {
		Name = "Silvermoon City",
		XOff = NxMap.BloodelfXO,
		YOff = NxMap.BloodelfYO,
		City = true,
		MId = 2011,
	},
	[2019] = {
		Name = "Silverpine Forest",
		Fish = 75,
		QAchievementIdH = 4894,
	},
	[2020] = {
		Name = "Stormwind City",
		City = true,
		MMOutside = true,
		Fish = 75,
	},
	[2021] = {
		Name = "Northern Stranglethorn",
--		Name = "Stranglethorn Vale",
		Fish = 225,
		QAchievementId = 4906,
	},
	[2022] = {
		Name = "Swamp of Sorrows",
		Fish = 225,
		QAchievementId = 4904,
	},
	[2023] = {
		Name = "The Hinterlands",
		Fish = 300,
		QAchievementId = 4897,
	},
	-- Tirisfal Glades
	[2024] = {
		Name = "Tirisfal Glades",
		Fish = 25,
	},
	-- Undercity
	[2025] = {
		Name = "Undercity", -- [26]
		1.9187478, -- Scale (0.6672102)
		-174.6383, -375.589, -- Origin (WH 191.8748, 128.0208)
		 -- -246.8386 -1631.841, 65.2877 38.4475
		 -- -241.8082 -1783.917, 65.812 14.6895
		 -- -343.3792 -1804.086, 55.2248 11.5385
		 -- -239.2218 -1836.685, 66.0816 6.4458
		Overlay = "undercity",
		City = true,
		Fish = 75,
	},
	[2026] = {
		Name = "Western Plaguelands",
		Fish = 300,
		QAchievementId = 4893,
	},
	[2027] = {
		Name = "Westfall",
		Fish = 75,
		QAchievementIdA = 4903,
	},
	[2028] = {
		Name = "Wetlands",
		Fish = 150,
		QAchievementIdA = 4898,
	},
	[2029] = {
		Name = "Isle of Quel'Danas",
		XOff = NxMap.BloodelfXO,
		YOff = NxMap.BloodelfYO,
		MId = 2011,
		Fish = 450,
	},
	[2030] = {
		Name = "Plaguelands: The Scarlet Enclave",
		XOff = 400,
		YOff = -33,
		City = true,	-- No explored areas
	},

-- Cataclysm

	[2031] = {
		Name = "Abyssal Depths",
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
	},
	[2032] = {
		Name = "Kelp'thar Forest",
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
	},
	[2033] = {
		Name = "Ruins of Gilneas",
		Fish = 75,
		Explored = true,
	},
	[2034] = {
		Name = "Ruins of Gilneas City",
		Fish = 75,
		City = true,	-- No explored areas
	},
	[2035] = {
		Name = "Shimmering Expanse",
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
	},
	[2036] = {
		Name = "Stranglethorn Vale",	-- Fake parent map?
		Fish = 75,
	},
	[2037] = {
		Name = "The Cape of Stranglethorn",
		Fish = 75,
		QAchievementId = 4905,
	},
	[2038] = {
		Name = "Tol Barad",
		XOff = -600,
		YOff = 320,
		MId = 2038,
		Fish = 75,
		Explored = true,
	},
	[2039] = {
		Name = "Tol Barad Peninsula",
		XOff = -600,
		YOff = 320,
		MId = 2038,
		Fish = 75,
		Explored = true,
	},
	[2040] = {
		Name = "Twilight Highlands",
		Fish = 75,
		QAchievementId = 4873,
		QAchievementIdH = 5501,
	},
	[2041] = {	-- Need??? Sub continent
		Name = "Vashj'ir",
		Fish = 75,
	},
	[2042] = {
		Name = "Gilneas",
	},
	[2043] = {
		Name = "Gilneas City",
		City = true,			-- No explored areas
		MMOutside = true,
	},

	-- Mists

	[2044] = {
		Name = "Coldridge Valley",
		StartZone = true,
	},
	[2045] = {
		Name = "Deathknell",
		StartZone = true,
	},
	[2046] = {
		Name = "New Tinkertown",
		StartZone = true,
	},
	[2047] = {
		Name = "Northshire",
		StartZone = true,
	},
	[2048] = {
		Name = "Sunstrider Isle",
		XOff = NxMap.BloodelfXO,
		YOff = NxMap.BloodelfYO,
		MId = 2011,
		StartZone = true,
	},


	[3000] = {
		34.606,				-- Scale
		-2587.3, -1151.7,	-- Origin
	},
	[3001] = {
		Name = "Blade's Edge Mountains", -- [1]
		10.85003, -- Scale (0.666667)
		-1769.168, -881.6678, -- Origin (WH 1085.003, 723.3356)
		 -- -5982.262 -2399.672, 52.7847 55.539
		 -- -4709.442 -2041.002, 76.2468 65.4561
		 -- -4603.104 -2096.445, 78.2069 63.9231
		Overlay = "bladesedgemountains",
		QAchievementId = 1193,
	},
	[3002] = {
		Name = "Hellfire Peninsula", -- [2]
		10.32915, -- Scale (0.6668043)
		-1107.916, -296.2509, -- Origin (WH 1032.916, 688.7525)
		 -- -4976.093 697.7343, 10.9106 63.2735
		 -- -4605.781 414.6589, 18.0808 55.0536
		 -- -5056.561 188.3606, 9.3525 48.4823
		Overlay = "hellfire",
		Fish = 375,
		QAchievementId = 1189,
		QAchievementIdH = 1271,
	},
	[3003] = {
		Name = "Nagrand", -- [3]
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
	},
	[3004] = {
		Name = "Netherstorm", -- [4]
		11.14996, -- Scale (0.6666698)
		-1096.665, -1091.25, -- Origin (WH 1114.996, 743.3344)
		 -- -4413.899 -2483.77, 19.1826 79.977
		 -- -3666.211 -3010.165, 32.5941 65.8139
		Overlay = "netherstorm",
		Fish = 475,
		QAchievementId = 1194,
	},
	--!
	[3005] = {
		Name = "Shadowmoon Valley", -- [5]
		11, -- Scale (0.6666666)
		-845.0001, 389.5833, -- Origin (WH 1100, 733.3334)
		 -- -3265.336 3224.464, 17.44844 34.81494
		 -- -2685.753 2841.652, 27.9863 24.3746
		Overlay = "shadowmoonvalley",
		Fish = 375,
		QAchievementId = 1195,
	},
	-- Shattrath City
	--!
	[3006] = {
		Name = "Shattrath City", -- [6]
		2.6125, -- Scale (0.6666668)
		-1227.052, 294.7909, -- Origin (WH 261.25, 174.1667)
		 -- -5785.705 1864.776, 26.76009 44.87901
		 -- -5098.179 1620.727, 79.39369 16.85428
		Overlay = "shattrathcity",
		City = true,
		MMOutside = true,
	},
	--!
	[3007] = {
		Name = "Terokkar Forest", -- [7]
		10.8, -- Scale (0.6666667)
		-1416.667, 200, -- Origin (WH 1080, 720)
		 -- -3295.501 3248.513, 70.14504 62.45869
		 -- -5076.772 1600.578, 37.15854 16.68273
		Overlay = "terokkarforest",
		Fish = 450,
		QAchievementId = 1191,
		QAchievementIdH = 1272,
	},
	[3008] = {
		Name = "Zangarmarsh", -- [8]
		10.05418, -- Scale (0.6668039)
		-1895, -387.0831, -- Origin (WH 1005.418, 670.4165)
		 -- -6286.6 1113.615, 63.4244 90.9593
		 -- -5236.717 810.7363, 84.3089 81.9237
		 -- -5265.634 100.2874, 83.7337 60.7295
		Overlay = "zangarmarsh",
		Fish = 400,
		QAchievementId = 1190,
	},

	[4000] = {
		35.5,		-- Scale
		0, 0,		-- Origin
	},
	[4001] = {
		Name = "Borean Tundra", -- [1]
		11.521,
		125.764810, 1139.054323, -- Origin (WH 1085.003, 723.3356)
		Overlay = "boreantundra",
		Fish = 475,
		QAchievementId = 33,
		QAchievementIdH = 1358,
	},
	[4002] = {
		Name = "Crystalsong Forest", -- [2]
		5.4416,
		1550.386409, 817.907816,
		Overlay = "crystalsongforest",
		Fish = 500,
	},
	[4003] = {	-- Main level
		Name = "Dalaran", -- [3]
		1.6589 / 1.3,
		1629, 861,		--		1580, 1739,
		Overlay = "dalaran",
		MapBaseName = "dalaran1_",
--		NoBackground = true,
		City = true,
		Alpha = .85,
		ScaleAdjust = 1.3,
		Fish = 525,
		MapLevel = 1,
		Level2Id = 4014,
	},
	[4014] = {	-- Level 2 (was id 4012)
		Name = "Dalaran Underbelly", -- [3]
		1.6589 / 1.3,
		1629, 861,		--		1580, 1739,
		Overlay = "dalaran",
		MapBaseName = "dalaran2_",
		City = true,
		Alpha = .85,
		ScaleAdjust = 1.3,
		Fish = 525,
		MapLevel = 2,
		Level1Id = 4003,
	},
	[4004] = {
		Name = "Dragonblight", -- [4]
		11.21,
		1113.94, 1003.78, -- Origin (WH 1085.003, 723.3356)
		Overlay = "dragonblight",
		Fish = 475,
		QAchievementId = 35,
		QAchievementIdH = 1359,
	},
	[4005] = {
		Name = "Grizzly Hills", -- [5]
		10.5,
		2061.032452, 1015.273026, -- Origin (WH 1085.003, 723.3356)
		Overlay = "grizzlyhills",
		Fish = 475,
		QAchievementId = 37,
		QAchievementIdH = 1357,
	},
	[4006] = {
		Name = "Howling Fjord", -- [6]
		12.085,
		2119.306683, 1495.527721, -- Origin (WH 1085.003, 723.3356)
		Overlay = "howlingfjord",
		Fish = 475,
		QAchievementId = 34,
		QAchievementIdH = 1356,
	},
	[4007] = {
		Name = "Icecrown", -- [7]
		12.533,
		750.941881, 233.475172, -- Origin (WH 1085.003, 723.3356)
		Overlay = "icecrownglacier",
		QAchievementId = 40,
	},
	[4008] = {
		Name = "Sholazar Basin", -- [8]
		8.7057,
		453.792401, 661.305837,
		Overlay = "sholazarbasin",
		Fish = 525,
		QAchievementId = 39,
	},
	[4009] = {
		Name = "The Storm Peaks", -- [9]
		14.214,
		1471.175866, 79.244441, -- Origin (WH 1085.003, 723.3356)
		Overlay = "thestormpeaks",
		QAchievementId = 38,
	},
	[4010] = {
		Name = "Wintergrasp", -- [10]
		5.9455,
		973.388866, 975.227557,
		Overlay = "lakewintergrasp",
		Explored = true,
	},
	[4011] = {
		Name = "Zul'Drak", -- [11]
		9.98,
		1959.324066, 584.635173, -- Origin (WH 1085.003, 723.3356)
		Overlay = "zuldrak",
		QAchievementId = 36,
	},
	[4012] = {	-- Patch 4.2 (AID 795)
		Name = "Molten Front",
		2.38,
		1000, 2500,
		MId = 4012,
		UseAId = true,
--		City = true,
		Overlay = "moltenfront",
		Explored = true,
	},
	[4013] = {
		Name = "Hrothgar's Landing",
		7.35,
		1280, -37.5,
		Overlay = "hrothgarslanding",
		Explored = true,
	},
--	[4014]	Used by Dalaran sewers!

	-- Lost Isles (Cataclysm)
	[5000] = {
		26,		-- Scale
		0, 0,		-- Origin
	},
	[5001] = {
		Name = "Deepholm",
		XOff = 1580,
		YOff = 700,
		QAchievementId = 4871,
		MId = 5001,
	},
	[5002] = {
		Name = "Kezan",
		XOff = 1256,
		YOff = -542,
		MId = 5002,
	},
	[5003] = {
		Name = "The Lost Isles",
		XOff = 750,
		YOff = 1150,
	},
	[5004] = {
		Name = "The Maelstrom",
		XOff = 1000,
		YOff = 600,
		City = true,
		Explored = true,
	},	
    [5005] = { 
	    Name = "Darkmoon Island",
		3.8,
		-300, -2750+2400,
		Explored = true,
		City = true,
		MMOutside = true,		
		UseAId=true,
		MId=5005,
		Overlay = "darkmoonfaireisland",
	},
	-- BGs/Arenas (note: add map win InitLayoutData when adding BGs)
    [6000] = {
		31.030601,
		-1756.42, 595.44,
	},
	[6001] = {
		Name="Dread Wastes",
		10.704166,
		-1234.27, 1648.84,
		Overlay = "dreadwastes",
		Fish = 525,
	},
	[6002] = {
		Name="Krasarang Wilds",
		9.375002,
		-595.94, 1954.25,
		Overlay = "krasarang",
		Fish = 525,
	},
	[6003] = {
		Name="Kun-Lai Summit",
		12.516666,
		-974.27, 808.42,
		Overlay = "kunlaisummit",
		Fish = 525,
	},
	[6004] = { 
		Name = "Shrine of Seven Stars",	
		0.55, 
		-82, 1751, 
		ScaleAdjust=0.9469, 
		City = true, 
		Level2Id = 6005,
	}, 
    [6005] = {
		Name = "Shrine of Seven Stars L2", 
		0.55,
		-82, 1751, 
		ScaleAdjust=1.14356, 
		City = true, 
		Level1Id = 6004,
	},
    [6006] = {
		Name="The Jade Forest",
		13.966666,
		-296.77,1201.75,
		Overlay = "thejadeforest",
		Fish = 525,
	},
	[6007] = {
		Name="The Veiled Stair",
		3.587500,
		-168.85,1594.25,
		Overlay = "thehiddenpass",
		Fish = 525,
	},
	[6008] = {
		Name="Townlong Steppes",
		11.487498,
		-1422.19,1020.50,
		Overlay = "townlongwastes",
		Fish = 525,
	},
	[6009] = {
		Name="Vale of Eternal Blossoms",
		5.066668,
		-502.60,1542.59,
		Overlay = "valeofeternalblossoms",
		Fish = 525,
	},
	[6010] = {
		Name="Valley of the Four Winds",
		7.850002,
		-542.19,1713.00,
		Overlay = "valleyofthefourwinds",
		Fish = 525,
	},
	[6011] = {
		Name="The Wandering Isle",
		5.341666015625,
		-500,-200,
		Overlay = "thewanderingisle",
		StartZone = true,
--		City = true,
		MMOutside = true,		
	},    
    [6012] = { 
		Name = "Shrine of Two Moons",	
		0.5,
		-217.8, 1573.5,
		Alpha=2,
		ScaleAdjust=0.87584,
		City = true,
		Level2Id = 6013,
	},
    [6013] = { 
		Name = "Shrine of Seven Stars",	
		0.5,
		-217.8, 1573.5,
		Alpha=2,	
		ScaleAdjust=1.03448,
		City = true, 
		Level1Id = 6012,
	},	
	[6014] = {
		Name = "Isle of Giants",
		3.575001968,
		-400.8334, 600.5832,
		Explored = true,
		Overlay = "isleofgiants",
	},
	[6015] = {
		Name = "Isle of Thunder",
		8.270832,
		-1535.8332, 514.5832,
		Explored = true,
		Overlay = "isleofthethunderking",
	},	
	
	[9000] = {
		1,				-- Scale
		0, 0,			-- Origin
	},
	[9001] = {		-- AB
		Name = "Arathi Basin",
		3.508,		-- Scale
		-16000, 0,		-- Origin
		Short = "AB",
	},
	[9002] = {		-- WG
		Name = "Warsong Gulch",
		2.29,			-- Scale
		-16000,1000,	-- Origin
		Short = "WG",
	},
	[9003] = {		-- AV
		Name = "Alterac Valley",
		8.471,		-- Scale
		16000,2000,		-- Origin
		Short = "AV",
	},
	[9004] = {		-- EOS
		Name = "Eye of the Storm",
		4.538,		-- Scale
		-16000,3000,		-- Origin
		Short = "EOS",
	},
	[9005] = {		-- Blade's Edge Arena
		Name = "Blade's Edge Arena",
		1,
		-16000,4000,
		Short = "BEA",
		Arena = true
	},
	[9006] = {		-- Nagrand Arena
		Name = "Nagrand Arena",
		1,
		-16000,5000,
		Short = "NA",
		Arena = true
	},
	[9007] = {		-- Ruins of Lordaeron
		Name = "Ruins of Lordaeron",
		1,
		-16000,6000,
		Short = "RL",
		Arena = true
	},
	[9008] = {		-- SoA
		Name = "Strand of the Ancients",
		3.486,
		-14500,0,
		Short = "SoA",
	},
	[9009] = {		-- IC
		Name = "Isle of Conquest",
		5.295,
		-14500,1000,
		Short = "IC",
	},
	[9010] = {
		Name = "The Battle for Gilneas",
		3.0,
		-14500,2000,
		Short = "TBG",
	},
	[9011] = {
		Name = "Twin Peaks",
		3.0,
		-14500,3000,
		Short = "TP",
	},
    [9012] = {
		Name = "Temple of Kotmogu",
		3.0,
		-14500,4000,
		Short = "TK",
	},
	[9013] = {
		Name = "Silvershard Mines",
		8.0,
		-14500,5000,
		Short = "SSM",
		MapBaseName = "STVDiamondMineBG1_",
	},	
	[9014] = {
		Name = "Tol'vir Proving Grounds",
		3.0,
		-14500,6000,
		Short = "TPG",
	},
	-- Instances are created at 11000-14999 (cont * 1000 + 10000 + nxid)
	-- Manual adjustments are added here

	[11024] = {
		0,
		0, .02
	},
	[11025] = {
		0,
		0, .04
	},
	[11147] = {
		0,
		0, .06
	},
	[11201] = {
		0,
		.03, 0
	},
	[11202] = {
		0,
		.03, .02
	},
	[11203] = {
		0,
		.03, .04
	},
	[11204] = {
		0,
		.03, .06
	},
	[12017] = {
		0,
		0, .02
	},
	[12061] = {
		0,
		0, .04
	},
	[12189] = {
		0,
		.01, .07		-- Base coords off a little
	},
	[12190] = {
		0,
		.01, .09		-- Base coords off a little
	},
	[13027] = {
		0,
		.0, -.0
	},
	[13028] = {
		0,
		-.04, .0
	},
	[13029] = {
		0,
		-.02, .0
	},
	[13030] = {
		0,
		.02, .00
	},
}

--------

--Map.HotspotInfo = {
--}

--------
-- "Atlas\Images\Maps"

Map.AtlasInstanceInfo = {
--[[
	Atlas = 1,					-- Flag table as Atlas maps
	[13006] = {
		129 / 512, 386 / 512,		"AuchAuchenaiCrypts"
	},
	[13007] = {
		109 / 512, 44 / 512,		"AuchManaTombs",
	},
	[13008] = {
		458 / 512, 236 / 512,		"AuchSethekkHalls",
	},
	[13009] = {
		61 / 512, 77 / 512,		"AuchShadowLabyrinth", },
	[13013] = {
		104 / 512, 458 / 512,		"BlackTempleStart",
		104 / 512 - 1, 458 / 512,		"BlackTempleBasement",
		104 / 512, 458 / 512 + 1,		"BlackTempleTop",
	},
	[11014] = {
		171 / 512, 59 / 512,		"BlackfathomDeeps",
	},
	[12015] = {
		126 / 512, 420 / 512,		"BlackrockDepths",	},
	[12017] = {
		16 / 512, 71 / 512,		"BlackrockSpireLower",
		16 / 512, 71 / 512 + 1,		"BlackrockSpireUpper",
	},
	[12018] = {
		342 / 512, 361 / 512,		"BlackwingLair",
	},
	[11023] = {
		108 / 512, 252 / 512,		"CoTHyjal",
	},
	[11024] = {
		71 / 512, 206 / 512,		"CoTOldHillsbrad",
	},
	[11025] = {
		267 / 512, 135 / 512,		"CoTBlackMorass",
	},
	[13027] = {
		12 / 512, 339 / 512,		"CFRSerpentshrineCavern",
	},
	[13028] = {
		126 / 512, 119 / 512,		"CFRTheSlavePens",
	},
	[13029] = {
		14 / 512, 181 / 512,		"CFRTheSteamvault",
	},
	[13030] = {
		124 / 512, 341 / 512,		"CFRTheUnderbog",
	},
	[11036] = {
		385 / 512, 405 / 512,		"DireMaulNorth",
		385 / 512 + 1, 405 / 512,		"DireMaulWest",
		385 / 512 - 1, 405 / 512,		"DireMaulEast",
	},
	[12048] = {
		405 / 512, 73 / 512,		"Gnomeregan",
	},
	[13049] = {
		447 / 512, 364 / 512,	"GruulsLair",
	},
	[13051] = {
		213 / 512, 330 / 512,	"HCHellfireRamparts",
	},
	[13052] = {
		101 / 512, 81 / 512,		"HCMagtheridonsLair",
	},
	[13053] = {
		242 / 512, 473 / 512,	"HCBloodFurnace",
	},
	[13054] = {
		341 / 512, 497 / 512,	"HCTheShatteredHalls",
	},
	[12058] = {
		144 / 512, 217 / 512,		"KarazhanStart",
		144 / 512 - 1, 217 / 512,	"KarazhanEnd",
	},
	[11060] = {
		378 / 512, 63 / 512,		"Maraudon",
	},
	[12061] = {
		19 / 512, 114 / 512,		"MoltenCore",
	},
	[14065] = {
		210 / 512, 211 / 512,	"Naxxramas",
	},
	[11067] = {
		50 / 512, 66 / 512,		"OnyxiasLair",
	},
	[11069] = {
		379 / 512, 14 / 512,		"RagefireChasm",
	},
	[11070] = {
		26 / 512, 123 / 512,		"RazorfenDowns",
	},
	[11071] = {
		359 / 512, 361 / 512,	"RazorfenKraul",
	},
	[11073] = {
		320 / 512, 36 / 512,		"TheRuinsofAhnQiraj",
	},
	[12074] = {
		512 / 512, 512 / 512,	"SMArmory",
		0 / 512, 512 / 512,		"SMCathedral",
		512 / 512, 0 / 512,		"SMGraveyard",
		0 / 512, 0 / 512,			"SMLibrary",
	},
	[12075] = {
		124 / 512, 174 / 512,	"Scholomance",
	},
	[12077] = {
		373 / 512, 325 / 512,	"ShadowfangKeep",
	},
	[12086] = {
		266 / 512, 460 / 512,	"Stratholme",
	},
	[12087] = {
		307 / 512, 11 / 512,		"TheSunkenTemple",
	},
	[13091] = {
		193 / 512, 485 / 512,		"TempestKeepArcatraz",
	},
	[13092] = {
		494 / 512, 218 / 512,		"TempestKeepBotanica",
	},
	[13093] = {
		230 / 512, 482 / 512,		"TempestKeepTheEye",
	},
	[13094] = {
		219 / 512, 475 / 512,		"TempestKeepMechanar",
	},
	[11095] = {
		127 / 512, 193 / 512,		"TheTempleofAhnQiraj",
	},
	[12098] = {
		62 / 512, 100 / 512,		"TheDeadmines",
	},
	[12101] = {
		257 / 512, 347 / 512,		"TheStockade",
	},
	[12106] = {
		458 / 512, 379 / 512,		"Uldaman",
	},
	[11109] = {
		220 / 512, 298 / 512,		"WailingCaverns",
	},
	[12116] = {
		399 / 512, 453 / 512,		"ZulFarrak",
	},
	[12117] = {
		39 / 512, 259 / 512,		"ZulGurub",
	},
	[12118] = {
		39 / 512, 271 / 512,		"ZulAman",
	},
	[12120] = {
		209 / 512, 401 / 512,	"MagistersTerrace",
	},
	[12121] = {
		164 / 512, 69 / 512,		"SunwellPlateau",
	},
	[14133] = { 438 / 512, 349 / 512, "AhnKahet", },
	[14134] = { 108 / 512, 214 / 512, "AzjolNerub",	},
	[14135] = {  17 / 512, 279 / 512, "DrakTharonKeep", },
	[14136] = { 375 / 512, 172 / 512, "Gundrak", },
	[14137] = { 186 / 512, 459 / 512, "TheNexus", },
	[14138] = { 250 / 512, 244 / 512, "TheOculus", },
	[14139] = { 236 / 512, 481 / 512, "VioletHold", },
	[14140] = {   9 / 512, 154 / 512, "UlduarHallsofLightning", },
	[14141] = {  62 / 512, 209 / 512, "UlduarHallsofStone", },
	[14142] = { 334 / 512, 271 / 512, "UtgardeKeep", },
	[14144] = { 265 / 512, 257 / 512, "ObsidianSanctum", },
	[14145] = { 185 / 512,   9 / 512, "UtgardePinnacle", },
	[11147] = { 398 / 512, 489 / 512, "CoTOldStratholme", },
]]--
}

Map.InstanceInfo = {			-- Blizzard instance maps (SetInstanceMap uses size of 3 for table entries)
}	

NxMap.ZoneOverlays = {

	-- Kalimdor

		["moonglade"] = {
			["shrineofremulos"] = "209,91,271,296",
			["lakeeluneara"] = "219,273,431,319",
			["stormragebarrowdens"] = "542,210,275,346",
			["nighthaven"] = "370,135,346,244",
		},
		["barrens"] = {
			["dreadmistpeak"] = "290,104,241,195",
			["thornhill"] = "481,254,239,231",
			["thestagnantoasis"] = "344,379,336,289",
			["farwatchpost"] = "555,129,207,332",
			["thesludgefen"] = "403,6,257,249",
			["thewailingcaverns"] = "152,318,377,325",
			["thedryhills"] = "116,57,283,270",
			["themerchantcoast"] = "556,456,315,212",
			["boulderlodemine"] = "511,7,278,209",
			["theforgottenpools"] = "100,208,446,256",
			["morshanrampart"] = "258,6,261,216",
			["ratchet"] = "547,379,219,175",
			["thecrossroads"] = "362,275,233,193",
			["groldomfarm"] = "448,127,243,217",
		},
		["winterspring"] = {
			["icethistlehills"] = "581,314,249,217",
			["lakekeltheril"] = "372,268,271,258",
			["starfallvillage"] = "229,33,367,340",
			["mazthoril"] = "399,340,257,238",
			["frostsaberrock"] = "304,0,332,268",
			["timbermawpost"] = "92,302,362,252",
			["thehiddengrove"] = "500,17,333,255",
			["frostwhispergorge"] = "424,474,317,183",
			["everlook"] = "482,195,194,229",
			["owlwingthicket"] = "556,439,254,150",
			["winterfallvillage"] = "588,181,221,209",
			["frostfirehotsprings"] = "93,118,376,289",
		},
		["uldum_terrain1"] = {
			["thegateofunendingcycles"] = "647,15,161,236",
			["thecursedlanding"] = "752,170,237,316",
			["ruinsofammon"] = "217,289,203,249",
			["akhenetfields"] = "471,277,164,185",
			["orsis"] = "264,136,249,243",
			["nahom"] = "583,162,237,194",
			["ramkahen"] = "411,67,228,227",
			["obeliskofthemoon"] = "110,0,400,224",
			["obeliskofthesun"] = "340,282,269,203",
			["thetrailofdevestation"] = "657,349,206,204",
			["cradeloftheancient"] = "341,402,202,169",
			["schnottzslanding"] = "28,221,312,289",
			["marat"] = "406,174,160,193",
			["virnaaldam"] = "479,215,151,144",
			["throneofthefourwinds"] = "229,433,270,229",
			["thevortexpinnacle"] = "656,473,213,195",
			["hallsoforigination"] = "599,184,269,242",
			["templeofuldum"] = "132,127,296,209",
			["obeliskofthestars"] = "551,121,196,170",
			["ruinsofahmtul"] = "365,0,278,173",
			["khartutstomb"] = "542,0,203,215",
			["neferset"] = "407,384,209,254",
			["tahretgrounds"] = "545,193,150,159",
			["lostcityofthetolvir"] = "527,291,233,321",
		},
		["ashenvale"] = {
			["theshrineofassenia"] = "40,275,306,283",
			["nightrun"] = "595,253,221,257",
			["fallenskylake"] = "529,385,287,276",
			["warsonglumbercamp"] = "771,265,231,223",
			["lakefalathim"] = "112,148,184,232",
			["satyrnaar"] = "696,154,235,236",
			["thehowlingvale"] = "473,97,325,239",
			["raynewoodretreat"] = "481,221,231,256",
			["thezoramstrand"] = "0,0,262,390",
			["felfirehill"] = "714,317,277,333",
			["maelstraspost"] = "188,0,246,361",
			["thunderpeak"] = "377,121,203,310",
			["theruinsofstardust"] = "210,331,236,271",
			["orendilsretreat"] = "143,0,244,251",
			["astranaar"] = "255,164,251,271",
			["thistlefurvillage"] = "255,78,314,241",
			["silverwindrefuge"] = "338,335,347,308",
			["boughshadow"] = "836,148,166,211",
		},
		["teldrassil"] = {
			["banethilhollow"] = "374,221,175,235",
			["shadowglen"] = "481,104,241,217",
			["gnarlpinehold"] = "347,355,198,181",
			["thecleft"] = "432,109,144,226",
			["theoracleglade"] = "276,90,194,244",
			["rutheranvillage"] = "329,448,317,220",
			["lakealameth"] = "422,310,289,202",
			["wellspringlake"] = "382,83,165,249",
			["starbreezevillage"] = "544,217,187,196",
			["galardellvalley"] = "466,237,178,186",
			["poolsofarlithrien"] = "345,243,140,210",
			["darnassus"] = "149,181,298,337",
		},
		["mulgore"] = {
			["baeldundigsite"] = "226,220,218,192",
			["winterhoofwaterwell"] = "449,340,174,185",
			["redcloudmesa"] = "286,401,446,264",
			["redrocks"] = "514,43,186,185",
			["ravagedcaravan"] = "435,224,187,165",
			["thunderhornwaterwell"] = "333,202,201,167",
			["theventurecomine"] = "530,138,208,300",
			["wildmanewaterwell"] = "331,0,190,172",
			["thunderbluff"] = "208,62,373,259",
			["windfuryridge"] = "400,0,222,202",
			["bloodhoofvillage"] = "319,273,302,223",
			["stonetalonpass"] = "201,0,237,184",
			["therollingplains"] = "527,291,260,243",
			["palemanerock"] = "248,321,172,205",
			["thegoldenplains"] = "448,101,186,216",
		},
		["hyjal"] = {
			["archimondesvengeance"] = "320,5,270,300",
			["shrineofgoldrinn"] = "116,17,291,321",
			["nordrassil"] = "392,0,537,323",
			["gatesofsothann"] = "622,320,272,334",
			["sethriasroost"] = "139,436,277,232",
			["theregrowth"] = "52,253,441,319",
			["direforgehill"] = "303,197,270,173",
			["ashenlake"] = "6,78,282,418",
			["thescorchedplain"] = "411,216,365,264",
			["thethroneofflame"] = "318,378,419,290",
			["darkwhispergorge"] = "682,128,320,471",
		},
		["felwood"] = {
			["irontreewoods"] = "406,55,261,273",
			["morlosaran"] = "476,484,187,176",
			["bloodvenomfalls"] = "220,231,345,192",
			["jaedenar"] = "234,317,319,176",
			["felpawvillage"] = "471,0,307,161",
			["jadefirerun"] = "303,9,263,199",
			["ruinsofconstellas"] = "278,359,268,214",
			["deadwoodvillage"] = "410,505,173,163",
			["emeraldsanctuary"] = "394,382,274,212",
			["shatterscarvale"] = "243,107,343,250",
			["talonbranchglade"] = "531,57,209,226",
			["jadefireglen"] = "288,458,229,210",
		},
		["darkshore"] = {
			["lordanel"] = "391,54,277,281",
			["eyeofthevortex"] = "300,239,330,192",
			["nazjvel"] = "207,467,244,201",
			["wildbendriver"] = "280,378,314,193",
			["ruinsofauberdine"] = "280,182,203,194",
			["witheringthicket"] = "305,118,328,250",
			["shatterspearvale"] = "596,16,250,241",
			["shatterspearwarcamp"] = "565,0,245,147",
			["ametharan"] = "294,330,326,145",
			["ruinsofmathystra"] = "517,28,200,263",
			["themastersglaive"] = "277,483,303,185",
		},
		["aszhara"] = {
			["bearshead"] = "113,141,256,224",
			["thesecretlab"] = "353,396,184,213",
			["ruinsofarkkoran"] = "575,121,219,193",
			["darnassianbasecamp"] = "343,3,243,262",
			["lakemennar"] = "245,377,210,232",
			["ravencrestmonument"] = "476,401,295,267",
			["stormcliffs"] = "407,403,207,232",
			["theshatteredstrand"] = "316,168,206,329",
			["gallywixpleasurepalace"] = "70,222,250,230",
			["blackmawhold"] = "204,53,260,267",
			["bilgewaterharbor"] = "395,127,587,381",
			["towerofeldara"] = "684,22,306,337",
			["orgimmarreargate"] = "22,344,352,274",
			["bitterreaches"] = "477,0,321,247",
			["ruinsofeldarath"] = "228,229,218,237",
		},
		["ungorocrater"] = {
			["lakkaritarpits"] = "305,0,432,294",
			["ironstoneplateau"] = "706,201,197,222",
			["therollinggarden"] = "565,39,337,321",
			["golakkahotsprings"] = "145,226,309,277",
			["theslitheringscar"] = "335,384,381,274",
			["thescreamingreaches"] = "157,0,332,332",
			["mossypile"] = "328,179,186,185",
			["themarshlands"] = "573,256,263,412",
			["fireplumeridge"] = "356,192,321,288",
			["terrorrun"] = "162,357,316,293",
			["fungalrock"] = "557,0,224,191",
			["marshalsstand"] = "462,330,204,170",
		},
		["desolace"] = {
			["valleyofspears"] = "170,196,321,275",
			["gelkisvillage"] = "207,472,274,196",
			["mannoroccoven"] = "381,357,326,311",
			["thunderaxefortress"] = "440,49,220,205",
			["shokthokar"] = "589,319,309,349",
			["cenarionwildlands"] = "415,156,312,285",
			["sargeron"] = "655,0,317,293",
			["nijelspoint"] = "573,0,231,257",
			["magramterritory"] = "613,170,289,244",
			["thargadscamp"] = "275,376,212,186",
			["tethrisaran"] = "399,0,274,145",
			["kodograveyard"] = "360,273,250,215",
			["ranzjarisle"] = "210,0,161,141",
			["shadowbreakravine"] = "637,402,292,266",
			["shadowpreyvillage"] = "142,369,222,299",
			["slitherbladeshore"] = "208,24,338,342",
		},
		["tanaris"] = {
			["landsendbeach"] = "431,452,224,216",
			["southbreakshore"] = "437,289,274,186",
			["zulfarrak"] = "184,0,315,190",
			["valleryofthewatchers"] = "255,431,269,190",
			["southmoonruins"] = "301,349,232,211",
			["brokenpillar"] = "413,211,195,163",
			["thegapingchasm"] = "448,364,225,187",
			["cavernsoftime"] = "507,238,213,173",
			["gadgetzan"] = "412,92,189,180",
			["dunemaulcompound"] = "305,257,231,177",
			["gadgetzanbay"] = "479,9,254,341",
			["lostriggercover"] = "615,201,178,243",
			["eastmoonruins"] = "380,341,173,163",
			["abyssalsands"] = "297,148,255,194",
			["thistleshrubvalley"] = "185,280,221,293",
			["thenoxiouslair"] = "258,211,179,190",
			["sandsorrowwatch"] = "293,99,214,149",
		},
		["uldum"] = {
			["thegateofunendingcycles"] = "647,15,161,236",
			["thecursedlanding"] = "752,170,237,316",
			["ruinsofammon"] = "217,289,203,249",
			["akhenetfields"] = "471,277,164,185",
			["orsis"] = "264,136,249,243",
			["nahom"] = "583,162,237,194",
			["ramkahen"] = "411,67,228,227",
			["obeliskofthemoon"] = "110,0,400,224",
			["obeliskofthesun"] = "340,282,269,203",
			["thetrailofdevestation"] = "657,349,206,204",
			["cradeloftheancient"] = "341,402,202,169",
			["schnottzslanding"] = "28,221,312,289",
			["marat"] = "406,174,160,193",
			["virnaaldam"] = "479,215,151,144",
			["throneofthefourwinds"] = "229,433,270,229",
			["thevortexpinnacle"] = "656,473,213,195",
			["hallsoforigination"] = "599,184,269,242",
			["templeofuldum"] = "132,127,296,209",
			["obeliskofthestars"] = "551,121,196,170",
			["ruinsofahmtul"] = "365,0,278,173",
			["khartutstomb"] = "542,0,203,215",
			["neferset"] = "407,384,209,254",
			["tahretgrounds"] = "545,193,150,159",
			["lostcityofthetolvir"] = "527,291,233,321",
		},
		["ahnqirajthefallenkingdom"] = {
			["aqkingdom"] = "115,0,887,668",
		},
		["durotar"] = {
			["razormanegrounds"] = "302,264,248,158",
			["echoisles"] = "429,413,330,255",
			["thunderridge"] = "295,48,220,218",
			["skullrock"] = "438,0,208,157",
			["tiragardekeep"] = "462,298,210,200",
			["valleyoftrials"] = "304,312,254,258",
			["southfurywatershed"] = "282,174,244,222",
			["drygulchravine"] = "415,60,236,196",
			["senjinvillage"] = "457,406,192,184",
			["razorhill"] = "431,157,224,227",
			["northwatchfoothold"] = "399,440,162,157",
			["orgrimmar"] = "309,0,259,165",
		},
		["feralas"] = {
			["campmojache"] = "671,181,174,220",
			["feathermoonstronghold"] = "362,237,217,192",
			["darkmistruins"] = "568,287,172,198",
			["writhingdeep"] = "652,298,232,206",
			["ruinsoffeathermoon"] = "186,229,208,204",
			["theforgottencoast"] = "375,343,194,304",
			["feralscar"] = "457,281,191,179",
			["grimtotemcompund"] = "607,170,159,218",
			["ruinsofisildien"] = "467,354,206,237",
			["gordunnioutpost"] = "663,116,192,157",
			["thetwincolossals"] = "271,0,350,334",
			["diremaul"] = "485,101,265,284",
			["lowerwilds"] = "756,191,207,209",
		},
		["silithus"] = {
			["thescarabwall"] = "0,455,580,213",
			["valorsrest"] = "614,0,315,285",
			["twilightbasecamp"] = "100,151,434,231",
			["southwindvillage"] = "550,181,309,243",
			["thecrystalvale"] = "126,0,329,246",
			["hiveashi"] = "345,4,405,267",
			["cenarionhold"] = "427,143,292,260",
			["hiveregal"] = "380,310,489,358",
			["hivezora"] = "0,206,542,367",
		},
		["stonetalonmountains"] = {
			["windshearcrag"] = "533,179,374,287",
			["kromgarfortress"] = "588,341,183,196",
			["stonetalonpeak"] = "265,0,305,244",
			["unearthedgrounds"] = "654,369,265,206",
			["greatwoodvale"] = "602,448,322,220",
			["boulderslideravine"] = "532,512,194,156",
			["cliffwalkerpost"] = "366,95,241,192",
			["webwinderpath"] = "468,263,267,352",
			["sunrockretreat"] = "353,285,222,222",
			["webwinderhollow"] = "479,401,164,258",
			["ruinsofeldrethar"] = "367,411,221,235",
			["battlescarvalley"] = "220,189,290,297",
			["windshearhold"] = "516,289,176,189",
			["thaldarahoverlook"] = "252,121,210,189",
			["malakajin"] = "618,537,211,131",
			["mirkfallonlake"] = "417,143,244,247",
			["thecharredvale"] = "199,368,277,274",
		},
		["southernbarrens"] = {
			["huntershill"] = "300,64,218,178",
			["honorsstand"] = "201,0,315,170",
			["ruinsoftaurajo"] = "244,286,285,171",
			["razorfenkraul"] = "273,528,214,140",
			["vendettapoint"] = "267,196,254,214",
			["forwardcommand"] = "423,251,216,172",
			["battlescar"] = "274,307,384,248",
			["theovergrowth"] = "289,117,355,226",
			["baelmodan"] = "398,457,269,211",
			["northwatchhold"] = "548,147,280,279",
			["frazzlecrazmotherload"] = "269,436,242,195",
		},
		["dustwallow"] = {
			["witchhill"] = "428,0,270,353",
			["theramoreisle"] = "542,223,305,247",
			["direhornpost"] = "358,169,279,301",
			["blackhoofvillage"] = "199,0,344,183",
			["brackenwllvillage"] = "133,59,384,249",
			["alcazisland"] = "656,21,206,200",
			["mudsprocket"] = "109,313,433,351",
			["shadyrestinn"] = "137,188,317,230",
			["thewyrmbog"] = "359,369,436,299",
		},
		["hyjal_terrain1"] = {
			["archimondesvengeance"] = "320,5,270,300",
			["shrineofgoldrinn"] = "116,17,291,321",
			["nordrassil"] = "392,0,537,323",
			["gatesofsothann"] = "622,320,272,334",
			["sethriasroost"] = "139,436,277,232",
			["theregrowth"] = "52,253,441,319",
			["direforgehill"] = "303,197,270,173",
			["ashenlake"] = "6,78,282,418",
			["thescorchedplain"] = "411,216,365,264",
			["thethroneofflame"] = "318,378,419,290",
			["darkwhispergorge"] = "682,128,320,471",
		},
		["thousandneedles"] = {
			["southseaholdfast"] = "756,412,246,256",
			["thetwilightwithering"] = "347,329,374,339",
			["splithoofheights"] = "571,49,431,410",
			["thegreatlift"] = "136,0,272,232",
			["razorfendowns"] = "298,0,361,314",
			["theshimmeringdeep"] = "591,257,411,411",
			["freewindpost"] = "276,186,436,271",
			["highperch"] = "0,134,246,380",
			["rustmauldivesite"] = "527,465,234,203",
			["westreachsummit"] = "0,0,280,325",
			["twilightbulwark"] = "125,241,358,418",
			["darkcloudpinnacle"] = "169,116,317,252",
		},

	-- Eastern Kingdoms

		["vashjirruins"] = {
			["nespirah"] = "460,261,286,269",
			["glimmeringdeepgorge"] = "270,222,272,180",
			["silvertidehollow"] = "150,32,480,319",
			["shimmeringgrotto"] = "400,0,339,278",
			["ruinsofvashjir"] = "217,268,349,361",
			["ruinsoftherseral"] = "554,175,197,223",
			["bethmoraridge"] = "407,445,335,223",
		},
		["duskwood"] = {
			["theyorgenfarmstead"] = "401,396,233,248",
			["addlesstead"] = "32,348,299,296",
			["thetranquilgardenscemetary"] = "627,344,291,244",
			["darkshire"] = "640,128,329,314",
			["brightwoodgrove"] = "497,112,279,399",
			["vulgologremound"] = "228,355,268,282",
			["thehushedbank"] = "0,152,189,307",
			["thedarkenedbank"] = "71,26,931,235",
			["manormistmantle"] = "661,122,219,182",
			["racenhill"] = "96,292,205,157",
			["thetwilightgrove"] = "314,101,320,388",
			["therottingorchard"] = "539,368,291,263",
			["ravenhillcemetary"] = "91,132,323,309",
		},
		["vashjirkelpforest"] = {
			["darkwhispergorge"] = "528,228,220,189",
			["honorstomb"] = "380,43,291,206",
			["legionsfate"] = "210,35,278,315",
			["gnawsboneyard"] = "451,325,311,217",
			["theaccursedreef"] = "365,162,340,225",
			["gubogglesledge"] = "399,280,227,207",
			["holdingpens"] = "456,401,316,267",
		},
		["twilighthighlands_terrain1"] = {
			["victorypoint"] = "302,306,177,159",
			["dragonmawpass"] = "76,120,283,206",
			["bloodgulch"] = "416,205,215,157",
			["obsidianforest"] = "436,380,342,288",
			["thundermar"] = "374,93,238,229",
			["grimbatol"] = "83,223,230,276",
			["theblackbreach"] = "498,121,211,210",
			["wyrmsbend"] = "205,232,191,198",
			["dragonmawport"] = "631,245,251,207",
			["crucibleofcarnage"] = "387,268,203,208",
			["twilightshore"] = "610,345,260,202",
			["vermillionredoubt"] = "71,16,324,264",
			["thegullet"] = "269,179,175,180",
			["humboldtconflaguration"] = "344,89,143,141",
			["gorshakwarcamp"] = "543,220,194,170",
			["highbank"] = "697,403,220,227",
			["crushblow"] = "370,447,182,195",
			["thetwilightcitadel"] = "151,314,361,354",
			["highlandforest"] = "482,330,239,232",
			["thetwilightbreach"] = "312,192,199,212",
			["thekrazzworks"] = "654,0,226,232",
			["slitheringcove"] = "622,169,198,201",
			["thetwilightgate"] = "327,356,165,199",
			["ruinsofdrakgor"] = "296,0,206,182",
			["firebeardspatrol"] = "499,265,215,181",
			["dunwaldruins"] = "395,367,197,218",
			["weepingwound"] = "358,0,214,190",
			["kirthaven"] = "482,0,308,267",
			["glopgutshollow"] = "291,89,174,190",
		},
		["hinterlands"] = {
			["queldanillodge"] = "220,181,241,211",
			["thealtarofzul"] = "357,343,225,196",
			["shaolwatha"] = "565,208,281,261",
			["thecreepingruin"] = "390,252,199,199",
			["zunwatha"] = "152,284,226,225",
			["plaguemistravine"] = "133,105,191,278",
			["shadraalor"] = "220,379,240,196",
			["aeriepeak"] = "0,236,238,267",
			["valorwindlake"] = "286,269,199,212",
			["agolwatha"] = "367,159,208,204",
			["jinthaalor"] = "487,334,287,289",
			["skulkrock"] = "490,195,176,235",
			["seradane"] = "475,5,303,311",
			["theoverlookcliffs"] = "677,267,244,401",
		},
		["blastedlands"] = {
			["serpentscoil"] = "459,97,218,183",
			["nethergardekeep"] = "530,6,295,205",
			["dreadmaulpost"] = "327,182,235,188",
			["altarofstorms"] = "225,110,238,195",
			["riseofthedefiler"] = "375,102,168,170",
			["dreadmaulhold"] = "258,0,272,206",
			["thetaintedforest"] = "132,311,348,357",
			["surwich"] = "333,474,199,191",
			["thedarkportal"] = "368,179,370,298",
			["theredreaches"] = "533,268,268,354",
			["shattershore"] = "578,91,240,270",
			["sunveilexcursion"] = "386,374,233,266",
			["nethergardesupplycamps"] = "436,0,195,199",
			["thetaintedscar"] = "144,175,308,226",
		},
		["wetlands"] = {
			["sundownmarsh"] = "121,63,276,243",
			["blackchannelmarsh"] = "37,240,301,232",
			["dunalgaz"] = "346,419,298,215",
			["slabchiselssurvey"] = "532,352,300,316",
			["satlspray"] = "218,0,250,282",
			["greenwardensgrove"] = "460,102,250,269",
			["raptorridge"] = "599,123,256,245",
			["thelganrock"] = "371,335,258,207",
			["bluegillmarsh"] = "31,102,321,248",
			["mosshidefen"] = "506,232,369,235",
			["direforgehills"] = "506,34,329,228",
			["angerfangencampment"] = "359,201,236,256",
			["whelgarsexcavationsite"] = "185,195,298,447",
			["dunmodr"] = "356,7,257,185",
			["ironbeardstomb"] = "372,76,185,224",
			["menethilharbor"] = "0,297,325,363",
		},
		["easternplaguelands"] = {
			["zulmashar"] = "528,0,286,176",
			["thefungalvale"] = "183,211,274,216",
			["theundercroft"] = "56,457,280,211",
			["lightshopechapel"] = "687,271,196,220",
			["corinscrossing"] = "493,289,186,213",
			["tyrshand"] = "651,414,214,254",
			["eastwalltower"] = "541,184,181,176",
			["northpasstower"] = "401,69,250,192",
			["acherus"] = "774,102,228,273",
			["thondorilriver"] = "0,100,262,526",
			["themarrisstead"] = "133,335,202,202",
			["thenoxiousglade"] = "650,55,297,299",
			["thepestilentscar"] = "383,348,182,320",
			["theinfectisscar"] = "595,263,177,266",
			["terrordale"] = "0,10,258,320",
			["blackwoodlake"] = "382,151,238,231",
			["stratholme"] = "118,0,310,178",
			["quellithienlodge"] = "351,0,277,175",
			["plaguewood"] = "144,40,328,253",
			["darrowshire"] = "211,462,248,206",
			["ruinsofthescarletenclave"] = "738,295,264,373",
			["lightsshieldtower"] = "391,271,243,162",
			["northdale"] = "570,61,265,232",
			["crownguardtower"] = "258,351,202,191",
			["lakemereldar"] = "462,427,266,241",
		},
		["badlands"] = {
			["agmondsend"] = "230,315,342,353",
			["apocryphansrest"] = "0,66,252,353",
			["campcagg"] = "0,281,339,347",
			["uldaman"] = "336,0,266,210",
			["lethlorravine"] = "533,55,469,613",
			["campboff"] = "407,220,274,448",
			["hammertoesdigsite"] = "411,116,209,196",
			["campkosh"] = "504,19,236,260",
			["angorfortress"] = "230,68,285,223",
			["deathwingscar"] = "175,178,328,313",
			["thedustbowl"] = "144,99,214,285",
		},
		["silverpine"] = {
			["northtidesrun"] = "147,0,281,345",
			["thesepulcher"] = "341,157,218,200",
			["forsakenhighcommand"] = "445,0,361,175",
			["thedecrepitfields"] = "471,156,176,152",
			["northtidesbeachhead"] = "323,68,174,199",
			["theforsakenfront"] = "433,327,152,189",
			["valgansfield"] = "461,77,162,172",
			["deepelemmine"] = "483,212,217,198",
			["thebattlefront"] = "349,429,255,180",
			["fenrisisle"] = "581,15,352,302",
			["shadowfangkeep"] = "337,337,179,165",
			["olsensfarthing"] = "312,249,251,167",
			["ambermill"] = "509,250,283,243",
			["berensperil"] = "505,405,318,263",
			["forsakenrearguard"] = "369,0,186,238",
			["thegreymanewall"] = "318,506,409,162",
			["theskitteringdark"] = "236,0,227,172",
		},
		["thecapeofstranglethorn"] = {
			["bootybay"] = "289,341,225,255",
			["gurubashiarena"] = "345,0,238,260",
			["mistvalevalley"] = "408,248,253,242",
			["crystalveinmine"] = "528,73,271,204",
			["wildshore"] = "340,392,236,276",
			["nekmaniwellspring"] = "292,213,246,221",
			["ruinsofaboraz"] = "533,181,184,176",
			["jagueroisle"] = "471,404,240,264",
			["thesundering"] = "452,0,244,209",
			["hardwrenchhideaway"] = "208,116,356,221",
			["ruinsofjubuwal"] = "468,119,155,221",
		},
		["vashjirdepths"] = {
			["abyssalbreach"] = "497,0,491,470",
			["seabrush"] = "415,183,225,250",
			["fireplumetrench"] = "315,110,298,251",
			["lghorek"] = "162,210,306,293",
			["coldlightchasm"] = "266,280,267,374",
			["abandonedreef"] = "50,263,371,394",
			["korthunsend"] = "412,283,370,385",
			["deepfinridge"] = "275,32,363,262",
		},
		["stranglethornjungle"] = {
			["kurzenscompound"] = "499,0,244,238",
			["balalruins"] = "267,168,159,137",
			["thevilereef"] = "140,208,236,224",
			["moshoggogremound"] = "543,253,234,206",
			["ruinsofzulkunda"] = "158,0,228,265",
			["fortlivingston"] = "398,375,230,170",
			["mazthoril"] = "488,364,350,259",
			["nesingwarysexpedition"] = "306,63,227,190",
			["zuuldalaruins"] = "9,22,324,263",
			["kalairuins"] = "354,184,139,150",
			["zulgurub"] = "626,0,376,560",
			["baliamahruins"] = "397,243,239,205",
			["bambala"] = "566,164,190,176",
			["mizjahruins"] = "387,246,157,173",
			["lakenazferiti"] = "413,95,240,228",
			["gromgolbasecamp"] = "298,228,167,179",
			["rebelcamp"] = "306,0,302,166",
		},
		["ruinsofgilneas"] = {
			["gilneaspuzzle"] = "0,0,1002,668",
		},
		["gilneas_terrain2"] = {
			["greymanemanor"] = "141,202,244,241",
			["theblackwald"] = "504,394,280,224",
			["theheadlands"] = "160,0,328,336",
			["crowleyorchard"] = "261,427,210,166",
			["emberstonemine"] = "639,43,281,351",
			["duskhaven"] = "272,333,286,178",
			["tempestsreach"] = "652,290,350,345",
			["korothsden"] = "393,386,222,268",
			["hammondfarmstead"] = "167,352,194,236",
			["haywardfishery"] = "293,449,177,219",
			["stormglenvillage"] = "516,465,321,203",
			["northgatewoods"] = "482,14,282,298",
			["northernheadlands"] = "387,0,267,314",
			["keelharbor"] = "298,95,280,342",
		},
		["searinggorge"] = {
			["blackrockmountain"] = "243,424,304,244",
			["thoriumpoint"] = "255,38,429,301",
			["tannercamp"] = "413,360,571,308",
			["thecauldron"] = "232,171,481,360",
			["blackcharcave"] = "0,361,375,307",
			["grimsiltworksite"] = "531,241,441,266",
			["firewatchridge"] = "0,75,365,393",
			["dustfirevalley"] = "588,0,392,355",
		},
		["elwynn"] = {
			["westbrookgarrison"] = "116,355,269,313",
			["jerodslanding"] = "396,430,230,206",
			["northshirevalley"] = "355,138,295,296",
			["goldshire"] = "247,294,276,231",
			["stromwind"] = "0,0,512,422",
			["stonecairnlake"] = "552,186,340,272",
			["crystallake"] = "417,327,220,207",
			["towerofazora"] = "529,287,270,241",
			["ridgepointtower"] = "708,442,285,194",
			["brackwellpumpkinpatch"] = "532,424,287,216",
			["fargodeepmine"] = "240,420,269,248",
			["eastvaleloggingcamp"] = "703,292,294,243",
		},
		["arathi"] = {
			["refugepoint"] = "293,145,196,270",
			["galensfall"] = "0,144,212,305",
			["northfoldmanor"] = "132,105,227,268",
			["circleofeastbinding"] = "506,126,183,238",
			["bouldergor"] = "171,123,249,278",
			["goshekfarm"] = "430,249,306,248",
			["cirecleofouterbinding"] = "332,273,215,188",
			["hammerfall"] = "581,118,270,271",
			["thandolspan"] = "261,416,237,252",
			["boulderfisthall"] = "327,367,252,258",
			["faldirscove"] = "77,400,273,268",
			["witherbarkvillage"] = "476,359,260,220",
			["stromgardekeep"] = "21,269,284,306",
			["dabyriesfarmstead"] = "404,144,210,227",
			["circleofinnerbinding"] = "201,312,228,227",
			["circleofwestbinding"] = "85,24,220,287",
		},
		["dunmorogh"] = {
			["thegrizzledden"] = "374,287,211,160",
			["coldridgepass"] = "360,340,225,276",
			["kharanos"] = "449,220,184,188",
			["gnomeregan"] = "0,27,409,318",
			["thetundridhills"] = "579,306,174,249",
			["theshimmeringdeep"] = "397,132,171,234",
			["golbolarquarry"] = "663,288,198,251",
			["iceflowlake"] = "263,0,236,358",
			["amberstillranch"] = "595,225,249,183",
			["ironforgeairfield"] = "630,0,308,335",
			["frostmanehold"] = "50,227,437,249",
			["coldridgevalley"] = "100,366,398,302",
			["ironforge"] = "398,0,376,347",
			["helmsbedlake"] = "760,268,218,234",
			["northgateoutpost"] = "765,43,237,366",
			["frostmanefront"] = "469,256,226,335",
		},
		["westfall"] = {
			["thedaggerhills"] = "303,395,292,273",
			["furlbrowspumpkinfarm"] = "394,0,197,213",
			["thegapingchasm"] = "294,168,184,217",
			["jangoloadmine"] = "311,0,196,229",
			["goldcoastquarry"] = "199,79,235,306",
			["themolsenfarm"] = "348,118,202,224",
			["westfalllighthouse"] = "221,477,211,167",
			["sentinelhill"] = "404,226,229,265",
			["demontsplace"] = "203,376,201,195",
			["alexstonfarmstead"] = "167,263,346,222",
			["saldeansfarm"] = "451,81,244,237",
			["moonbrook"] = "308,325,232,213",
			["thedustplains"] = "480,378,317,261",
			["thedeadacre"] = "531,200,193,273",
			["thejansenstead"] = "474,0,202,179",
		},
		["burningsteppes"] = {
			["blackrockpass"] = "419,258,298,410",
			["dreadmaulrock"] = "568,151,274,263",
			["dracodar"] = "0,237,362,431",
			["altarofstorms"] = "0,0,182,360",
			["ruinsofthaurissan"] = "421,0,324,354",
			["blackrockmountain"] = "79,0,281,388",
			["terrorwingpath"] = "646,7,350,341",
			["blackrockstronghold"] = "235,0,320,385",
			["morgansvigil"] = "615,255,383,413",
			["pillarofash"] = "253,255,274,413",
		},
		["westernplaguelands"] = {
			["thebulwark"] = "48,235,316,316",
			["hearthglen"] = "235,0,432,271",
			["caerdarrow"] = "601,390,194,208",
			["sorrowhill"] = "261,448,368,220",
			["felstonefield"] = "229,228,241,212",
			["darrowmerelake"] = "510,354,492,314",
			["northridgelumbercamp"] = "231,123,359,182",
			["thewrithinghaunt"] = "472,332,169,195",
			["thondrorilriver"] = "533,0,311,436",
			["theweepingcave"] = "551,151,185,230",
			["redpinedell"] = "286,211,290,133",
			["dalsonsfarm"] = "300,232,325,192",
			["andorhal"] = "96,343,464,325",
			["gahrronswithering"] = "495,213,241,252",
		},
		["tirisfal"] = {
			["balnirfarmstead"] = "594,324,242,179",
			["venomwebvale"] = "752,150,250,279",
			["thebulwark"] = "709,330,293,338",
			["brill"] = "480,252,199,182",
			["scarletmonastery"] = "740,47,262,262",
			["scarletwatchpost"] = "692,99,161,234",
			["agamandmills"] = "324,90,285,260",
			["brightwaterlake"] = "573,122,210,292",
			["ruinsoflorderon"] = "423,359,390,267",
			["sollidenfarmstead"] = "201,192,286,225",
			["calstonestate"] = "389,255,179,169",
			["coldhearthmanor"] = "418,317,212,177",
			["deathknell"] = "9,207,431,407",
			["nightmarevale"] = "347,325,225,281",
			["crusaderoutpost"] = "686,232,175,210",
			["garrenshaunt"] = "477,129,190,214",
		},
		["redridge"] = {
			["rendersvalley"] = "451,377,427,291",
			["stonewatchkeep"] = "480,0,228,420",
			["lakeridgehighway"] = "148,316,392,352",
			["campeverstill"] = "445,286,189,193",
			["renderscamp"] = "214,0,357,246",
			["lakeeverstill"] = "81,214,464,250",
			["lakeshire"] = "0,110,410,256",
			["althersmill"] = "350,139,228,247",
			["shalewindcanyon"] = "688,283,306,324",
			["stonewatchfalls"] = "525,302,316,182",
			["galardellvalley"] = "574,0,428,463",
			["threecorners"] = "0,256,323,406",
			["redridgecanyons"] = "37,0,413,292",
		},
		["swampofsorrows"] = {
			["splinterspearjunction"] = "194,236,238,343",
			["stagalbog"] = "540,360,347,303",
			["marshtidewatch"] = "478,0,330,342",
			["pooloftears"] = "575,238,257,229",
			["theshiftingmire"] = "331,24,292,360",
			["sorrowmurk"] = "703,80,229,418",
			["ithariuscave"] = "7,242,268,316",
			["mistyreedstrand"] = "600,0,402,668",
			["stonard"] = "297,258,357,308",
			["mistyvalley"] = "0,80,268,285",
			["theharborage"] = "161,79,266,284",
			["bogpaddle"] = "600,0,262,193",
		},
		["lochmodan"] = {
			["thefarstriderlodge"] = "570,209,349,292",
			["stronewroughtdam"] = "339,0,333,200",
			["silverstreammine"] = "221,0,225,252",
			["northgatepass"] = "16,0,319,289",
			["ironbandsexcavationsite"] = "481,296,397,291",
			["stonesplintervalley"] = "177,345,273,294",
			["thelsamar"] = "0,146,455,295",
			["grizzlepawridge"] = "245,324,273,230",
			["valleyofkings"] = "0,311,310,345",
			["theloch"] = "340,81,330,474",
			["mogroshstronghold"] = "549,52,294,249",
		},
		["deadwindpass"] = {
			["deadmanscrossing"] = "83,0,617,522",
			["thevice"] = "433,208,350,449",
			["karazhan"] = "92,310,513,358",
		},
		["hillsbradfoothills"] = {
			["tarrenmill"] = "494,226,165,203",
			["gavinsnaze"] = "344,254,116,129",
			["lordamereinternmentcamp"] = "194,216,250,167",
			["mistyshore"] = "321,42,158,169",
			["nethandersteed"] = "502,373,204,244",
			["hillsbradfields"] = "191,302,302,175",
			["growlesscave"] = "359,191,171,136",
			["theheadland"] = "390,255,105,148",
			["azurelodemine"] = "287,399,180,182",
			["dalarancrater"] = "102,137,316,238",
			["gallowscorner"] = "451,140,155,147",
			["strahnbrad"] = "505,44,275,193",
			["darrowhill"] = "425,279,147,160",
			["southpointtower"] = "59,310,312,254",
			["dandredsfold"] = "341,0,258,113",
			["slaughterhollow"] = "413,55,148,120",
			["soferasnaze"] = "484,166,148,146",
			["ruinsofalterac"] = "347,85,189,181",
			["corrahnsdagger"] = "426,224,135,160",
			["purgationisle"] = "200,505,144,139",
			["crushridgehold"] = "463,101,134,124",
			["dungarok"] = "542,410,269,258",
			["durnholdekeep"] = "565,217,437,451",
			["chillwindpoint"] = "555,68,447,263",
			["theuplands"] = "441,0,212,160",
			["southshore"] = "383,352,229,219",
		},

	-- Jamie exports

	["azuremystisle"] = 
	{
		["ammenford"] = "515,279,256,256",
		["ammenvale"] = "527,104,475,512",
		["azurewatch"] = "383,249,256,256",
		["bristlelimbvillage"] = "174,363,256,256",
		["emberglade"] = "488,24,256,256",
		["fairbridgestrand"] = "356,0,256,128",
		["greezlescamp"] = "507,350,256,256",
		["moongrazewoods"] = "449,183,256,256",
		["odesyuslanding"] = "352,378,256,256",
		["podcluster"] = "281,305,256,256",
		["podwreckage"] = "462,349,128,256",
		["siltingshore"] = "291,3,256,256",
		["silvermystisle"] = "23,446,256,222",
		["stillpinehold"] = "365,49,256,256",
		["theexodar"] = "74,85,512,512",
		["valaarsberth"] = "176,303,256,256",
		["wrathscalepoint"] = "220,421,256,247",
	},
	["bladesedgemountains"] = 
	{
		["bashirlanding"] = "422,0,256,256",
		["bladedgulch"] = "623,147,256,256",
		["bladesiprehold"] = "314,161,256,507",
		["bloodmaulcamp"] = "412,95,256,256",
		["bloodmauloutpost"] = "342,371,256,297",
		["brokenwilds"] = "733,109,256,256",
		["circleofwrath"] = "439,210,256,256",
		["deathsdoor"] = "512,249,256,419",
		["forgecampanger"] = "586,147,416,256",
		["forgecampterror"] = "144,416,512,252",
		["forgecampwrath"] = "254,176,256,256",
		["grishnath"] = "286,28,256,256",
		["gruulslayer"] = "527,81,256,256",
		["jaggedridge"] = "446,414,256,254",
		["moknathalvillage"] = "658,297,256,256",
		["ravenswood"] = "214,55,512,256",
		["razorridge"] = "533,332,256,336",
		["ridgeofmadness"] = "554,258,256,410",
		["ruuanweald"] = "479,98,256,512",
		["skald"] = "673,71,256,256",
		["sylvanaar"] = "289,350,256,318",
		["thecrystalpine"] = "585,0,256,256",
		["thunderlordstronghold"] = "405,272,256,396",
		["veillashh"] = "271,428,256,240",
		["veilruuan"] = "563,151,256,128",
		["vekhaarstand"] = "629,406,256,256",
		["vortexpinnacle"] = "166,206,256,462",
	},
	["bloodmystisle"] = 
	{
		["amberwebpass"] = "44,62,256,512",
		["axxarien"] = "297,136,256,256",
		["blacksiltshore"] = "177,426,512,242",
		["bladewood"] = "367,209,256,256",
		["bloodscaleisle"] = "763,256,239,256",
		["bloodwatch"] = "437,258,256,256",
		["bristlelimbenclave"] = "546,410,256,256",
		["kesselscrossing"] = "517,527,485,141",
		["middenvale"] = "414,406,256,256",
		["mystwood"] = "309,483,256,185",
		["nazzivian"] = "250,404,256,256",
		["ragefeatherridge"] = "481,117,256,256",
		["ruinsofloretharan"] = "556,216,256,256",
		["talonstand"] = "657,78,256,256",
		["telathionscamp"] = "180,216,128,128",
		["thebloodcursedreef"] = "729,54,256,256",
		["thebloodwash"] = "302,27,256,256",
		["thecrimsonreach"] = "555,87,256,256",
		["thecryocore"] = "293,285,256,256",
		["thefoulpool"] = "221,136,256,256",
		["thehiddenreef"] = "205,39,256,256",
		["thelostfold"] = "503,470,256,198",
		["thevectorcoil"] = "43,238,512,430",
		["thewarppiston"] = "451,29,256,256",
		["veridianpoint"] = "637,0,256,256",
		["vindicatorsrest"] = "232,242,256,256",
		["wrathscalelair"] = "598,338,256,256",
		["wyrmscarisland"] = "613,82,256,256",
	},
	["eversongwoods"] = 
	{
		["azurebreezecoast"] = "669,228,256,256",
		["duskwithergrounds"] = "605,253,256,256",
		["eastsanctum"] = "460,373,256,256",
		["elrendarfalls"] = "580,399,128,256",
		["fairbreezevilliage"] = "386,386,256,256",
		["farstriderretreat"] = "524,359,256,128",
		["goldenboughpass"] = "243,469,256,128",
		["lakeelrendar"] = "584,471,128,197",
		["northsanctum"] = "361,298,256,256",
		["ruinsofsilvermoon"] = "307,136,256,256",
		["runestonefalithas"] = "378,496,256,172",
		["runestoneshandor"] = "464,494,256,174",
		["satherilshaven"] = "324,384,256,256",
		["silvermooncity"] = "440,87,512,512",
		["stillwhisperpond"] = "474,314,256,256",
		["sunsailanchorage"] = "231,404,256,128",
		["sunstriderisle"] = "195,5,512,512",
		["thegoldenstrand"] = "183,415,128,253",
		["thelivingwood"] = "511,420,128,248",
		["thescortchedgrove"] = "255,507,256,128",
		["thuronslivery"] = "539,305,256,128",
		["torwatha"] = "648,315,256,353",
		["tranquilshore"] = "215,298,256,256",
		["westsanctum"] = "292,319,128,256",
		["zebwatha"] = "554,475,128,193",
	},
	["ghostlands"] = 
	{
		["amanipass"] = "598,232,404,436",
		["bleedingziggurat"] = "184,238,256,256",
		["dawnstarspire"] = "575,0,427,256",
		["deatholme"] = "95,375,512,293",
		["elrendarcrossing"] = "326,0,512,256",
		["farstriderenclave"] = "573,136,429,256",
		["goldenmistvillage"] = "44,0,512,512",
		["howlingziggurat"] = "340,219,256,449",
		["isleoftribulations"] = "585,0,256,256",
		["sanctumofthemoon"] = "210,126,256,256",
		["sanctumofthesun"] = "448,150,256,512",
		["suncrownvillage"] = "460,0,512,256",
		["thalassiapass"] = "364,406,256,262",
		["tranquillien"] = "365,2,256,512",
		["windrunnerspire"] = "40,287,256,256",
		["windrunnervillage"] = "60,117,256,512",
		["zebnowa"] = "466,237,512,431",
	},
	["hellfire"] = 
	{
		["denofhaalesh"] = "182,412,256,256",
		["expeditionarmory"] = "261,413,512,255",
		["falconwatch"] = "183,326,512,342",
		["fallenskyridge"] = "34,142,256,256",
		["forgecamprage"] = "478,25,512,512",
		["hellfirecitadel"] = "338,210,256,458",
		["honorhold"] = "469,298,256,256",
		["magharpost"] = "206,110,256,256",
		["poolsofaggonar"] = "326,45,256,512",
		["ruinsofshanaar"] = "25,290,256,378",
		["templeoftelhamat"] = "38,152,512,512",
		["thelegionfront"] = "579,128,256,512",
		["thestairofdestiny"] = "737,156,256,512",
		["thrallmar"] = "467,154,256,256",
		["throneofkiljaeden"] = "477,6,512,256",
		["voidridge"] = "705,368,256,256",
		["warpfields"] = "308,408,256,260",
		["zethgor"] = "580,430,422,238",
	},
	["nagrand"] = 
	{
		["burningbladeruins"] = "660,334,256,334",
		["clanwatch"] = "532,363,256,256",
		["forgecampfear"] = "36,248,512,420",
		["forgecamphate"] = "162,154,256,256",
		["garadar"] = "431,143,256,256",
		["halaa"] = "335,193,256,256",
		["kilsorrowfortress"] = "558,427,256,241",
		["laughingskullruins"] = "351,52,256,256",
		["oshugun"] = "168,334,512,334",
		["ringoftrials"] = "533,267,256,256",
		["southwindcleft"] = "391,258,256,256",
		["sunspringpost"] = "219,199,256,256",
		["telaar"] = "387,390,256,256",
		["throneoftheelements"] = "504,53,256,256",
		["twilightridge"] = "10,107,256,512",
		["warmaulhill"] = "157,32,256,256",
		["windyreedpass"] = "598,79,256,256",
		["windyreedvillage"] = "666,233,256,256",
		["zangarridge"] = "277,54,256,256",
	},
	["netherstorm"] = 
	{
		["area52"] = "241,388,256,128",
		["arklonruins"] = "328,397,256,256",
		["celestialridge"] = "644,173,256,256",
		["ecodomefarfield"] = "396,10,256,256",
		["etheriumstaginggrounds"] = "481,208,256,256",
		["forgebaseog"] = "237,22,256,256",
		["kirinvarvillage"] = "490,523,256,145",
		["manaforgebanar"] = "147,281,256,387",
		["manaforgecoruu"] = "357,489,256,179",
		["manaforgeduro"] = "465,336,256,256",
		["manafrogeara"] = "171,155,256,256",
		["netherstone"] = "411,20,256,256",
		["netherstormbridge"] = "132,294,256,256",
		["ruinedmanaforge"] = "513,138,256,256",
		["ruinsofenkaat"] = "253,301,256,256",
		["ruinsoffarahlon"] = "354,49,512,256",
		["socretharsseat"] = "229,38,256,256",
		["sunfuryhold"] = "454,451,256,217",
		["tempestkeep"] = "593,284,409,384",
		["theheap"] = "239,455,256,213",
		["thescrapfield"] = "356,261,256,256",
		["thestormspire"] = "298,134,256,256",
	},
	["shadowmoonvalley"] = 
	{
		["altarofshatar"] = "520,93,256,256",
		["coilskarpoint"] = "348,8,512,512",
		["eclipsepoint"] = "343,310,512,358",
		["illadarpoint"] = "143,256,256,256",
		["legionhold"] = "104,155,512,512",
		["netherwingcliffs"] = "554,308,256,256",
		["netherwingledge"] = "510,445,492,223",
		["shadowmoonvilliage"] = "116,35,512,512",
		["theblacktemple"] = "606,126,396,512",
		["thedeathforge"] = "290,129,256,512",
		["thehandofguldan"] = "394,90,512,512",
		["thewardenscage"] = "469,258,512,410",
		["wildhammerstronghold"] = "168,229,512,439",
	},
	["terokkarforest"] = 
	{
		["allerianstronghold"] = "480,277,256,256",
		["auchenaigrounds"] = "247,434,256,234",
		["bleedinghollowclanruins"] = "103,301,256,367",
		["bonechewerruins"] = "521,275,256,256",
		["carrionhill"] = "377,272,256,256",
		["cenarionthicket"] = "314,0,256,256",
		["firewingpoint"] = "617,149,385,512",
		["grangolvarvilliage"] = "143,171,512,256",
		["raastokglade"] = "505,154,256,256",
		["razorthornshelf"] = "478,19,256,256",
		["refugecaravan"] = "316,268,128,256",
		["ringofobservance"] = "310,345,256,256",
		["sethekktomb"] = "245,289,256,256",
		["shattrathcity"] = "104,4,512,512",
		["skethylmountains"] = "449,348,512,320",
		["smolderingcaravan"] = "321,460,256,208",
		["stonebreakerhold"] = "397,165,256,256",
		["thebarrierhills"] = "116,4,256,256",
		["tuurem"] = "455,34,256,512",
		["veilrhaze"] = "222,362,256,256",
		["writhingmound"] = "417,327,256,256",
	},
	["zangarmarsh"] = 
	{
		["angoroshgrounds"] = "88,50,256,256",
		["angoroshstronghold"] = "124,0,256,128",
		["bloodscaleenclave"] = "596,412,256,256",
		["cenarionrefuge"] = "694,321,308,256",
		["coilfangreservoir"] = "462,90,256,512",
		["feralfenvillage"] = "314,332,512,336",
		["marshlightlake"] = "81,152,256,256",
		["oreborharborage"] = "329,25,256,512",
		["quaggridge"] = "141,325,256,343",
		["sporeggar"] = "20,202,512,256",
		["telredor"] = "569,112,256,512",
		["thedeadmire"] = "716,128,286,512",
		["thehewnbog"] = "219,51,256,512",
		["thelagoon"] = "512,303,256,256",
		["thespawningglen"] = "31,339,256,256",
		["twinspireruins"] = "342,249,256,256",
		["umbrafenvillage"] = "720,461,256,207",
		["zabrajin"] = "175,232,256,256",
	},

	-- Manually added for patch 2.4
	["sunwell"] =
	{
		["sunsreachharbor"] = "252,252,512,416",
		["sunsreachsanctum"] = "251,4,512,512",
	},

	-- WotLK

	["scarletenclave"] =
	{
		["scarletenclave"] = "0,0,1024,768",	-- FIX!!
	},
	["lakewintergrasp"] = {							
		["lakewintergrasp"] = "0,0,1024,768",		
	},
	["dalaran"] = {
		["dalaran1_"] = "0,0,1024,768",	-- FIX!!
	},

	["boreantundra"] = {
		["deathsstand"] = "707,181,289,279",
		["templecityofenkilah"] = "712,15,290,292",
		["warsongstronghold"] = "329,237,260,278",
		["riplashstrand"] = "293,383,382,258",
		["thedensofdying"] = "662,11,203,209",
		["thegeyserfields"] = "480,0,375,342",
		["torpsfarm"] = "272,237,186,276",
		["valiancekeep"] = "457,264,259,302",
		["garroshslanding"] = "153,238,267,378",
		["borgorokoutpost"] = "314,0,396,203",
		["amberledge"] = "325,140,244,214",
		["kaskala"] = "509,214,385,316",
		["steeljawscaravan"] = "397,66,244,319",
		["coldarra"] = "50,0,460,381",
	},
	["sholazarbasin"] = {
		["kartakshold"] = "76,375,329,293",
		["theavalanche"] = "596,92,322,265",
		["thesavagethicket"] = "396,51,293,229",
		["thesuntouchedpillar"] = "82,186,455,316",
		["themakersperch"] = "172,135,249,248",
		["themakersoverlook"] = "705,236,233,286",
		["rainspeakercanopy"] = "427,244,207,235",
		["themosslightpillar"] = "265,355,239,313",
		["theglimmeringpillar"] = "308,34,294,327",
		["thelifebloodpillar"] = "501,134,312,369",
		["thestormwrightsshelf"] = "138,58,268,288",
		["riversheart"] = "359,339,468,329",
	},
	["dragonblight"] = {
		["lightsrest"] = "703,7,299,278",
		["galakrondsrest"] = "433,118,258,225",
		["newhearthglen"] = "614,358,214,261",
		["rubydragonshrine"] = "374,208,188,211",
		["icemistvillage"] = "134,165,235,337",
		["venomspite"] = "661,264,226,212",
		["westwindrefugeecamp"] = "42,187,229,299",
		["obsidiandragonshrine"] = "256,104,304,203",
		["naxxramas"] = "691,160,311,272",
		["wyrmresttemple"] = "453,219,317,353",
		["scarletpoint"] = "569,7,235,354",
		["emeralddragonshrine"] = "543,362,196,218",
		["agmarshammer"] = "258,203,236,218",
		["theforgottenshore"] = "698,332,301,286",
		["thecrystalvice"] = "487,0,229,259",
		["angrathar"] = "210,0,306,242",
		["lakeindule"] = "217,313,356,300",
		["coldwindheights"] = "403,0,213,219",
	},
	["crystalsongforest"] = {
		["windrunnersoverlook"] = "444,383,558,285",
		["theunboundthicket"] = "500,105,502,477",
		["theazurefront"] = "0,244,416,424",
		["forlornwoods"] = "129,0,544,668",
		["violetstand"] = "0,176,264,303",
		["thegreattree"] = "0,91,252,260",
		["thedecrepitflow"] = "0,0,288,222",
		["sunreaverscommand"] = "536,40,446,369",
	},
	["howlingfjord"] = {
		["scalawagpoint"] = "168,410,350,258",
		["baleheim"] = "576,170,174,173",
		["giantsrun"] = "572,0,298,306",
		["halgrind"] = "397,208,187,263",
		["utgardekeep"] = "477,216,248,382",
		["vengeancelanding"] = "664,25,223,338",
		["nifflevar"] = "595,240,178,208",
		["emberclutch"] = "283,203,213,256",
		["ivaldsruin"] = "668,223,193,201",
		["cauldrosisle"] = "490,161,181,178",
		["fortwildervar"] = "490,0,251,192",
		["thetwistedglade"] = "420,57,266,210",
		["newagamand"] = "415,360,284,308",
		["baelgunsexcavationsite"] = "621,327,244,305",
		["apothecarycamp"] = "99,37,263,265",
		["ancientlift"] = "342,351,177,191",
		["kamagua"] = "99,278,333,265",
		["gjalerbron"] = "225,0,242,189",
		["explorersleagueoutpost"] = "585,336,232,216",
		["westguardkeep"] = "90,180,347,220",
		["skorn"] = "343,108,238,232",
		["campwinterhoof"] = "354,0,223,209",
		["steelgate"] = "222,100,222,168",
	},
	["zuldrak"] = {
		["zeramas"] = "7,412,307,256",
		["draksotrafields"] = "326,358,286,265",
		["altarofrhunok"] = "431,127,247,304",
		["altarofsseratus"] = "288,168,237,248",
		["kolramas"] = "380,437,302,231",
		["gundrak"] = "629,0,336,297",
		["altarofquetzlun"] = "607,251,261,288",
		["altarofharkoa"] = "533,345,265,257",
		["lightsbreach"] = "181,363,321,305",
		["thrymsend"] = "0,247,272,268",
		["amphitheaterofanguish"] = "289,287,266,254",
		["voltarus"] = "174,191,218,291",
		["altarofmamtoth"] = "575,88,291,258",
		["zimtorga"] = "479,241,249,258",
	},
	["grizzlyhills"] = {
		["grizzlemaw"] = "358,187,294,227",
		["voldrune"] = "176,421,283,247",
		["conquesthold"] = "17,307,332,294",
		["dunargol"] = "547,257,455,400",
		["ragefangshrine"] = "312,294,475,362",
		["drakiljinruins"] = "607,41,351,284",
		["venturebay"] = "18,461,274,207",
		["thormodan"] = "509,0,329,246",
		["granitesprings"] = "7,207,356,224",
		["blueskylogginggrounds"] = "232,129,249,235",
		["draktheronkeep"] = "0,46,382,285",
		["amberpinelodge"] = "217,244,278,290",
		["ursocsden"] = "331,32,328,260",
		["camponeqwah"] = "548,137,324,265",
	},
	["thestormpeaks"] = {
		["frosthold"] = "134,429,244,220",
		["templeofstorms"] = "239,301,169,164",
		["ulduar"] = "218,0,369,265",
		["sparksocketminefield"] = "242,468,251,200",
		["borsbreath"] = "109,375,322,195",
		["engineofthemakers"] = "316,296,210,179",
		["garmsbane"] = "395,470,184,191",
		["dunniffelem"] = "481,285,309,383",
		["narvirscradle"] = "214,144,180,239",
		["nidavelir"] = "108,206,221,200",
		["brunnhildarvillage"] = "339,370,305,298",
		["snowdriftplains"] = "162,143,205,232",
		["valkyrion"] = "98,318,228,158",
		["templeoflife"] = "570,113,182,270",
		["terraceofthemakers"] = "292,122,363,341",
		["thunderfall"] = "627,179,306,484",
	},
	["icecrownglacier"] = {
		["aldurthar"] = "355,37,373,375",
		["corprethar"] = "342,392,308,212",
		["thebombardment"] = "538,181,248,243",
		["onslaughtharbor"] = "0,167,204,268",
		["sindragosasfall"] = "626,31,300,343",
		["thefleshwerks"] = "218,291,219,283",
		["jotunheim"] = "22,122,393,474",
		["valleyofechoes"] = "715,390,269,217",
		["theconflagration"] = "327,305,227,210",
		["thebrokenfront"] = "558,329,283,231",
		["scourgeholme"] = "690,267,245,239",
		["ymirheim"] = "444,276,223,207",
		["theshadowvault"] = "321,15,223,399",
		["argenttournamentground"] = "616,30,314,224",
		["icecrowncitadel"] = "392,466,308,202",
		["valhalas"] = "217,50,238,240",
	},

	-- Patch 3.2
	["hrothgarslanding"] =
	{
--		["hrothgarslanding"] = "0,0,1024,768",
		["hrothgarslanding2"] = "256,0,256,256,1",	-- Just draw 4 parts
		["hrothgarslanding3"] = "512,0,256,256,1",
		["hrothgarslanding6"] = "256,256,256,256,1",
		["hrothgarslanding7"] = "512,256,256,256,1",
	},

	-- Cataclysm
	["tolbarad"] = {
		["tolbarad"] = "0,0,1024,768",	-- Manual
	},
	["tolbaraddailyarea"] = {
		["tolbaraddailyarea"] = "0,0,1024,768",	-- Manual
	},

	["themaelstrom"] = {
		["themaelstrom"] = "0,0,1024,768",	-- Manual
	},
	["thelostisles_terrain2"] = {
		["gallywixdocks"] = "351,21,173,180",
		["alliancebeachhead"] = "129,348,177,172",
		["bilgewaterlumberyard"] = "462,43,248,209",
		["thesavageglen"] = "213,325,231,216",
		["oostan"] = "492,161,210,258",
		["raptorrise"] = "416,368,168,205",
		["warchiefslookout"] = "264,144,159,230",
		["ooomlotvillage"] = "508,345,221,211",
		["scorchedgully"] = "323,185,305,288",
		["ktcoilplatform"] = "433,11,156,142",
		["hordebasecamp"] = "244,458,222,190",
		["lostpeak"] = "581,21,350,517",
		["shipwreckshore"] = "189,408,172,175",
		["skyfalls"] = "416,131,190,186",
		["ruinsofvashelan"] = "440,452,212,216",
		["landingsite"] = "377,359,142,133",
		["theslavepits"] = "279,68,212,193",
	},
	["kezan"] = {
		["bilgewaterport"] = "163,148,694,290",
		["firstbankofkezan"] = "98,325,376,343",
		["swindlestreet"] = "317,232,168,213",
		["theslick"] = "219,108,592,202",
		["kajamine"] = "586,308,354,360",
		["kajarofield"] = "383,260,250,307",
		["gallywixsvilla"] = "0,41,303,452",
		["kezanmap"] = "0,4,1002,664",
		["drudgetown"] = "180,367,351,301",
	},
	["deepholm"] = {
		["stonehearth"] = "0,314,371,354",
		["twilightterrace"] = "297,384,237,198",
		["scouredreach"] = "448,0,516,287",
		["needlerockchasm"] = "20,0,378,359",
		["stormsfurywreckage"] = "458,383,292,285",
		["twilightoverlook"] = "570,420,411,248",
		["deathwingsfall"] = "549,297,454,343",
		["thepaleroost"] = "85,0,467,273",
		["needlerockslag"] = "0,146,370,285",
		["theshatteredfield"] = "141,438,430,230",
		["therazanesthrone"] = "434,0,274,156",
		["crimsonexpanse"] = "540,12,462,400",
		["templeofearth"] = "287,177,355,345",
	},

	-- Patch 4.2
	["moltenfront"] = {
		["moltenfront"] = "0,0,1024,768",	-- Manual
	},
	-- Pandaria
 ["thejadeforest"] = {
    ["chuntianmonastery"] = "300,56,227,198",
    ["dawnsblossom"] = "325,178,234,210",
    ["dreamerspavillion"] = "474,520,218,148",
    ["emperorsomen"] = "430,21,202,204",
    ["glassfinvillage"] = "525,358,278,310",
    ["grookinmound"] = "182,214,253,229",
    ["hellscreamshope"] = "181,75,196,166",
    ["jademines"] = "400,146,236,142",
    ["nectarbreezeorchard"] = "290,330,219,256",
    ["nookanooka"] = "189,151,219,205",
    ["ruinsofganshi"] = "316,0,196,158",
    ["serpentsspine"] = "388,299,191,216",
    ["slingtailpits"] = "428,416,179,180",
    ["templeofthejadeserpent"] = "468,295,264,211",
    ["thearboretum"] = "481,215,242,210",
    ["waywardlanding"] = "346,482,219,186",
    ["windlessisle"] = "539,43,251,348",
    ["wreckoftheskyshark"] = "202,0,210,158",
  },
	["dreadwastes"] = {
		["klaxxivess"] = "458,110,236,204",
		["zanvess"] = "162,385,290,283",
		["brewgarden"] = "351,0,250,218",
		["dreadwaterlake"] = "437,313,322,211",
		["clutchesofshekzeer"] = "341,125,209,318",
		["horridmarch"] = "441,224,323,194",
		["brinymuck"] = "214,311,325,270",
		["soggysgamble"] = "450,406,268,241",
		["terraceofgurthan"] = "593,92,209,234",
		["rikkitunvillage"] = "236,32,218,186",
		["heartoffear"] = "191,122,262,293",
		["kyparivor"] = "485,0,325,190",
	},
	["krasarang"] = {
		["redwingrefuge"] = "317,63,212,265",
		["anglersoutpost"] = "545,205,265,194",
		["templeoftheredcrane"] = "300,215,219,259",
		["dojaniriver"] = "513,3,190,282",
		["krasarangcove"] = "701,19,286,268",
		["thedeepwild"] = "397,59,188,412",
		["lostdynasty"] = "589,27,217,279",
		["fallsongriver"] = "218,77,214,393",
		["thesouthernisles"] = "23,267,252,313",
		["zhusbastion"] = "612,0,306,204",
		["ruinsofdojan"] = "444,44,204,383",
		["theforbiddenjungle"] = "0,79,257,300",
		["ruinsofkorja"] = "125,88,211,395",
		["cradleofchiji"] = "176,376,272,250",
		["ungaingoo"] = "330,498,258,170",
		["nayelilagoon"] = "343,373,246,240",
	},
	["krasarang_terrain1"] = {
		["redwingrefuge"] = "317,63,212,265",
		["anglersoutpost"] = "545,205,265,194",
		["templeoftheredcrane"] = "300,215,219,259",
		["dojaniriver"] = "513,3,190,282",
		["krasarangcove"] = "701,19,295,293",
		["thedeepwild"] = "397,59,188,412",
		["lostdynasty"] = "589,27,217,279",
		["fallsongriver"] = "218,77,214,393",
		["thesouthernisles"] = "0,267,275,329",
		["zhusbastion"] = "612,0,306,204",
		["ruinsofdojan"] = "444,44,204,383",
		["theforbiddenjungle"] = "0,79,257,300",
		["ruinsofkorja"] = "125,88,211,395",
		["cradleofchiji"] = "176,376,272,250",
		["ungaingoo"] = "330,498,258,170",
		["nayelilagoon"] = "343,373,246,240",
	},	
	["kunlaisummit"] = {
		["binanvillage"] = "607,470,240,198",
		["mogujia"] = "462,411,253,208",
		["muskpawranch"] = "603,313,229,262",
		["mountneverset"] = "228,264,313,208",
		["zouchinvillage"] = "502,64,298,219",
		["templeofthewhitetiger"] = "587,170,250,260",
		["gateoftheaugust"] = "449,506,261,162",
		["shadopanmonastery"] = "88,92,385,385",
		["theburlaptrail"] = "398,310,310,276",
		["peakofserenity"] = "333,63,287,277",
		["valleyofemperors"] = "453,191,224,241",
		["kotapeak"] = "233,360,252,257",
		["iseoflostsouls"] = "602,4,259,233",
		["fireboughnook"] = "322,496,224,172",
	},	
	["valeofeternalblossoms"] = {
		["guolairuins"] = "87,3,337,349",
		["whitemoonshrine"] = "482,10,298,262",
		["mistfallvillage"] = "200,363,310,305",
		["settingsuntraining"] = "0,234,350,429",
		["tushenburialground"] = "349,316,267,308",
		["thestairsascent"] = "556,267,446,359",
		["winterboughglade"] = "4,107,361,333",
		["thegoldenstair"] = "328,16,242,254",
		["whitepetallake"] = "278,170,267,281",
		["thetwinmonoliths"] = "444,97,272,522",
		["mogushanpalace"] = "629,22,373,385",
	},
	["valleyofthefourwinds"] = {
		["thunderfootfields"] = "622,0,380,317",
		["poolsofpurity"] = "513,58,213,246",
		["rumblingterrace"] = "582,301,277,245",
		["paoquanhollow"] = "12,105,273,246",
		["stormsoutbrewery"] = "227,380,257,288",
		["dustbackgorge"] = "0,343,209,308",
		["cliffsofdispair"] = "215,404,510,264",
		["theheartland"] = "253,75,286,392",
		["silkenfields"] = "530,253,254,259",
		["harvesthome"] = "5,239,260,251",
		["gildedfan"] = "438,41,208,292",
		["grandgranery"] = "334,325,314,212",
		["singingmarshes"] = "170,130,175,291",
		["zhusdecent"] = "699,114,303,323",
		["halfhill"] = "438,177,206,245",
		["nesingwarysafari"] = "104,326,249,342",
		["mudmugsplace"] = "561,161,230,217",
		["kuzenvillage"] = "224,74,199,304",
	},
	["townlongwastes"] = {
		["niuzaotemple"] = "213,241,296,359",
		["shanzedao"] = "125,0,300,246",
		["thesumprushes"] = "545,369,271,205",
		["sikvess"] = "306,433,261,235",
		["gaoranblockade"] = "546,468,353,200",
		["mingchicrossroads"] = "417,447,247,221",
		["palewindvillage"] = "692,362,282,306",
		["osulmesa"] = "560,185,238,296",
		["shadopangarrison"] = "413,385,213,170",
		["krivess"] = "420,209,255,269",
		["srivess"] = "92,192,294,283",
	},
	["thewanderingisle"] = {
		["thedawningvalley"] = "325,0,677,667",
		["templeoffivedawns"] = "395,182,607,461",
		["mandorivillage"] = "392,294,610,374",
		["ridgeoflaughingwinds"] = "183,198,313,321",
		["pei-wuforest"] = "351,406,651,262",
		["poolofthepaw"] = "297,324,220,188",
		["skyfirecrash-site"] = "124,405,346,263",
		["therows"] = "504,295,385,373",
		["thesingingpools"] = "545,12,372,475",
		["morningbreezevillage"] = "203,36,261,315",
		["fe-fangvillage"] = "134,9,234,286",
		["thewoodofstaves"] = "13,202,989,466",
	},
	["darkmoonfaireisland"] = {
		["darkmoonfaireisland"] = "0,0,1024,768",
	},
	["thehiddenpass"] = {
		["thehiddencliffs"] = "443,0,294,220",
		["theblackmarket"] = "371,175,479,493",
		["thehiddensteps"] = "412,477,290,191",
	},

	["isleofgiants"] = {
		["isleofgiants"] = "0,0,1024,768",	-- Manual
	},
	["timelessisle"] = {
		["timelessisle"] = "0,0,1024,768",
	},
	["isleofthethunderking"] = {
		["isleofthethunderking"] = "0,0,1024,768",	-- Manual
		["HORDE"] = "183,95,278,325",
		["LOCK4"] = "396,9,446,429",
	},
	["frostfireridge"] = {
		--["nogarrison"] = "336,327,267,257",
		["bladespirefortress"] = "38,117,356,303",
		["bloodmaulstronghold"] = "311,4,258,217",
		["bonesofagurak"] = "729,319,273,349",
		["daggermawravine"] = "284,91,255,191",
		["frostwinddunes"] = "121,0,274,214",
		["grimfrosthill"] = "597,210,178,203",
		["grombolash"] = "483,33,217,239",
		["gromgar"] = "505,323,282,341",
		["hordegarrison"] = "336,327,267,257",
		["ironsiegeworks"] = "673,156,329,294",
		["magnarok"] = "609,33,213,278",
		["ironwaystation"] = "641,304,199,335",
		["stonefangoutpost"] = "306,281,251,191",
		["theboneslag"] = "290,192,256,210",
		["thecracklingplains"] = "439,137,266,293",
		["worgol"] = "72,292,317,233",
	},
	["nagranddraenor"] = {
		["grommashar"] = "600,367,256,301",
		["ironfistharbor"] = "283,354,236,242",
		["lokrath"] = "382,187,316,221",
		["oshugun"] = "366,323,262,266",
		["highmaul"] = "0,0,471,437",
		["sunspringwatch"] = "312,98,274,254",
		["hallvalor"] = "766,118,236,372",
		["ringofblood"] = "430,0,263,287",
		["elementals"] = "588,0,286,274",
		["telaar"] = "461,353,296,272",
		["mushrooms"] = "746,25,250,287",
		["margoks"] = "753,380,249,288",
		["brokenprecipice"] = "256,12,305,227",
		["ancestral"] = "239,259,234,191",
		["ringoftrials"] = "523,159,354,315",
	},
	["dustwallow_terrain1"] = {
		["mudsprocket"] = "109,313,433,351",
		["theramoreisle"] = "542,223,305,247",
		["direhornpost"] = "358,169,279,301",
		["blackhoofvillage"] = "199,0,344,183",
		["brackenwllvillage"] = "133,59,384,249",
		["witchhill"] = "428,0,270,353",
		["alcazisland"] = "656,21,206,200",
		["shadyrestinn"] = "137,188,317,230",
		["thewyrmbog"] = "359,369,436,299",
	},
	["gorgrond"] = {
		["irondocks"] = "350,0,315,180",
		["gronncanyon"] = "258,213,279,241",
		["easternruin"] = "525,260,210,193",
		["evermorn"] = "281,444,297,181",
		["stonemaulsouth"] = "275,416,208,142",
		["stonemaularena"] = "259,335,217,178",
		["tangleheart"] = "451,372,262,221",
		["foundry"] = "455,74,211,221",
		["beastwatch"] = "383,371,166,161",
		["highlandpass"] = "547,73,285,323",
		["highpass"] = "411,250,209,225",
		["bastionrise"] = "283,507,324,161",
		["stripmine"] = "312,77,250,232",
		["mushrooms"] = "444,323,253,198",
		["foundrysouth"] = "454,183,217,180",
	},
	["twilighthighlands"] = {
		["victorypoint"] = "302,306,177,159",
		["dragonmawpass"] = "76,120,283,206",
		["bloodgulch"] = "416,205,215,157",
		["obsidianforest"] = "436,380,342,288",
		["thundermar"] = "374,93,238,229",
		["dragonmawport"] = "631,245,251,207",
		["theblackbreach"] = "498,121,211,210",
		["firebeardspatrol"] = "499,265,215,181",
		["thetwilightbreach"] = "312,192,199,212",
		["kirthaven"] = "482,0,308,267",
		["twilightshore"] = "610,345,260,202",
		["thegullet"] = "269,179,175,180",
		["humboldtconflaguration"] = "344,89,143,141",
		["thekrazzworks"] = "654,0,226,232",
		["gorshakwarcamp"] = "543,220,194,170",
		["highbank"] = "697,403,220,227",
		["thetwilightcitadel"] = "151,314,361,354",
		["wyrmsbend"] = "205,232,191,198",
		["highlandforest"] = "482,330,239,232",
		["grimbatol"] = "83,223,230,276",
		["glopgutshollow"] = "291,89,174,190",
		["slitheringcove"] = "622,169,198,201",
		["thetwilightgate"] = "327,356,165,199",
		["vermillionredoubt"] = "71,16,324,264",
		["crushblow"] = "370,447,182,195",
		["dunwaldruins"] = "395,367,197,218",
		["weepingwound"] = "358,0,214,190",
		["ruinsofdrakgor"] = "296,0,206,182",
		["crucibleofcarnage"] = "387,268,203,208",
	},
	["talador"] = {
		["orunaicoast"] = "427,0,279,267",
		["aruuna"] = "597,178,389,234",
		["shattrath"] = "173,22,406,367",
		["centerisles"] = "546,228,252,280",
		["seentrance"] = "685,298,308,276",
		["fortwrynn"] = "567,42,292,235",
		["tuurem"] = "472,148,225,224",
		["gordalfortress"] = "548,378,423,290",
		["tomboflights"] = "352,271,326,212",
		["zangarra"] = "713,35,287,277",
		["gulrok"] = "165,364,278,270",
		["telmor"] = "207,511,497,157",
		["courtofsouls"] = "150,264,307,229",
		["auchindoun"] = "338,356,309,262",
		["northgate"] = "571,0,398,149",
	},
	["shadowmoonvalleydr"] = {
		["gulvar"] = "26,0,260,309",
		["elodor"] = "426,0,291,266",
		["nogarrison"] = "194,0,223,279",
		["garrison"] = "194,0,223,279",
		["darktideroost"] = "468,467,282,201",
		["swisland"] = "309,460,173,160",
		["karabor"] = "537,150,393,318",
		["socrethar"] = "383,411,202,201",
		["shimmeringmoor"] = "453,306,288,261",
		["shazgul"] = "259,315,282,225",
		["embaari"] = "270,158,346,252",
		["gloomshade"] = "319,5,229,240",
		["anguishfortress"] = "140,160,309,264",
	},
	["stvdiamondminebg"] = {
		["17467"] = "206,173,385,146",
		["17468"] = "414,96,362,222",
		["17469"] = "565,289,164,191",
		["17470"] = "565,126,213,257",
	},
	["spiresofarak"] = {
		["writhingmire"] = "197,198,229,213",
		["solospiresouth"] = "374,276,169,178",
		["southport"] = "310,328,197,179",
		["veilakraz"] = "281,83,252,230",
		["clutchpop"] = "533,382,217,224",
		["solospirenorth"] = "429,84,196,284",
		["bloodmanevalley"] = "410,350,229,246",
		["eastmushrooms"] = "649,155,182,244",
		["emptygarrison"] = "282,261,190,187",
		["sethekkhollow"] = "520,127,238,295",
		["bloodbladeredoubt"] = "334,210,209,154",
		["skettis"] = "289,0,371,174",
		["nwcorner"] = "102,0,314,304",
		["veilzekk"] = "521,268,198,232",
		["venturecove"] = "465,475,226,193",
		["howlingcrag"] = "459,0,382,274",
		["centerravennest"] = "444,255,188,190",
	},
}







NxMap.MapLevels={
    [811] = { [3] = 6010, [4] = 6011, },
    [903] = { [1] = 6012, [2] = 6013, },
    [905] = { [3] = 6010, [4] = 6011, }, 
    [504] = { [2] = 4014, },    
    [321] = { [2] = 1034, },   
}

-------------------------------------------------------------------------------



-- WorldMapArea.dbc
-- bounds y1, y2, x1, x2
-- 4.0.1 11,1,17,"Barrens",2622.91650391,-7510.41650391,1612.49987793,-5143.75,-1,0,0,0x0,
-- 4.0.3 11,1,17,"Barrens",202.083328247,-5543.75,1810.41662598,-2020.83325195,-1,0,0,0x0,
-- 5.0.4 11,1,17,"Barrens",202.083328247,-5543.75,1810.41662598,-2020.83325195,-1,0,0,0x0,10,20,

-- x = (x-maEntry->x1)/((maEntry->x2-maEntry->x1)/100);
-- y = (y-maEntry->y1)/((maEntry->y2-maEntry->y1)/100);    // client y coord from top to down
--
-- MapWorldInfo table calc:
-- Scale = -y2 + y1 / 500
-- X = -y1 / 5
-- Y = -x1 / 5
--[[function RDXMAP.Map:ConvertMapData()

	local data = {}
	NxData.DumpZoneOverlays = data

	local areas = {}
	NxData.DumpMapAreas = areas

	local wma = { strsplit ("\n", self.WorldMapArea) }
	local wmo = { strsplit ("\n", self.WorldMapOverlay) }

	for n, s in ipairs (wma) do

		local aid, map, _, aname, ay1, ay2, ax1, ax2 = strsplit (",", s)
		aid = tonumber (aid)
		map = tonumber (map)

		aname = gsub (aname, '"', "")
		aname = strlower (aname)
		VFL.vprint(aid)
		local nxid = NxMap.ID2Zone[aid]
		if nxid and nxid > 0 then

			local name, minLvl, maxLvl, faction, cont = strsplit ("!", NxMap.Zones[nxid]) --

			if faction ~= "3" then	-- Not instance

				ay1 = tonumber (ay1)
				ay2 = tonumber (ay2)
				ax1 = tonumber (ax1)
				ax2 = tonumber (ax2)

				local scale = (-ay2 + ay1) / 500
				VFL.vprint(scale)
				if scale > 0 then
					local t = {}
					areas[nxid] = t
					t[1] = scale
					t[2] = -ay1 / 5						-- X
					t[3] = -ax1 / 5						-- Y
					t[4] = aname
					VFL.vprint("%s %s %s %s",t[4],t[2],t[3],t[1])
				end
			end			
		end

--		if map == 0 or map == 1 then
--		if map == 648 or map == 646 or map == 730 then			-- Maelstrom
--		if map == 654 then	-- Gilneas
--		if map == 571 or map == 609 then			-- Northrend, DK start
		if map == 1064 or map == 870 then
--			VFL.vprint ("%s %s %s", aid, map, aname)

			local area = {}

			for n, os in ipairs (wmo) do

				-- 84,41,736,0,0,0,"BanethilHollow",175,235,374,221,292,430,375,497,0x0,

				local _, oaid, _, _, _, _, oname, w, h, x, y = strsplit (",", os)

				oname = gsub (oname, '"', "")

				if tonumber (oaid) == aid and #oname > 0 then
					oname = strlower (oname)
					area[oname] = format ("%s,%s,%s,%s", x, y, w, h)
				end
			end

			if next (area) then	-- Not empty?
				data[aname] = area
			end
		end
	end
end
--]]
--RDXMAP.Map.WorldMapArea = [[929,870,6661,"Isleofgiants",2004.167,216.666016,6697.916,5506.25,-1,0,0,0x0,0,0,]]

--RDXMAP.Map.WorldMapOverlay = [[3564,928,0,0,0,0,"",0,0,0,0,490,290,256,378,0x0,]]


--RDXMAP.Map:ConvertMapData()

-------------------------------------------------------------------------------
--EOF





local errata = {
	["AhnQirajTheFallenKingdom"] = {
		["AQKingdom"] = 121271159,
	},
	["Arathi"] = {
		["BoulderfistHall"] = 394406398204,
		["Bouldergor"] = 132249835769,
		["CircleofEastBinding"] = 135822293175,
		["CircleofInnerBinding"] = 335218445540,
		["CircleofWestBinding"] = 25859226844,
		["CirecleofOuterBinding"] = 293479837911,
		["DabyriesFarmstead"] = 155042680018,
		["FaldirsCove"] = 429577744657,
		["GalensFall"] = 154619135188,
		["GoShekFarm"] = 267812856114,
		["Hammerfall"] = 127311035662,
		["NorthfoldManor"] = 112881578211,
		["RefugePoint"] = 156000073924,
		["StromgardeKeep"] = 288858884380,
		["ThandolSpan"] = 446950535405,
		["WitherbarkVillage"] = 385972662532,
	},
	["Ashenvale"] = {
		["Astranaar"] = 176361323771,
		["BoughShadow"] = 159790615718,
		["FallenSkyLake"] = 413945581855,
		["FelfireHill"] = 341125182741,
		["LakeFalathim"] = 159031468216,
		["MaelstrasPost"] = 197502198,
		["NightRun"] = 272280847581,
		["OrendilsRetreat"] = 150203636,
		["RaynewoodRetreat"] = 237801570535,
		["Satyrnaar"] = 166086291691,
		["SilverwindRefuge"] = 360058245467,
		["TheHowlingVale"] = 104649178437,
		["TheRuinsofStardust"] = 355629022444,
		["TheShrineofAssenia"] = 295321234738,
		["TheZoramStrand"] = 399622,
		["ThistlefurVillage"] = 84019496250,
		["ThunderPeak"] = 130318391499,
		["WarsongLumberCamp"] = 285350264039,
	},
	["Aszhara"] = {
		["BearsHead"] = 151516315904,
		["BilgewaterHarbor"] = 136779789899,
		["BitterReaches"] = 500424001,
		["BlackmawHold"] = 57122499844,
		["DarnassianBaseCamp"] = 3581155571,
		["GallywixPleasurePalace"] = 238444321018,
		["LakeMennar"] = 405057806546,
		["OrgimmarRearGate"] = 369390537056,
		["RavencrestMonument"] = 431069867303,
		["RuinsofArkkoran"] = 130525889755,
		["RuinsofEldarath"] = 246126195930,
		["StormCliffs"] = 433144963279,
		["TheSecretLab"] = 425572127928,
		["TheShatteredStrand"] = 180720313550,
		["TowerofEldara"] = 24339891506,
	},
	["AzuremystIsle"] = {
		["AmmenFord"] = 300114247936,
		["AmmenVale"] = 112222274011,
		["AzureWatch"] = 267763581184,
		["BristlelimbVillage"] = 389950996736,
		["Emberglade"] = 26281771264,
		["FairbridgeStrand"] = 373424384,
		["GreezlesCamp"] = 376341528832,
		["MoongrazeWoods"] = 196965826816,
		["OdesyusLanding"] = 406243770624,
		["PodCluster"] = 327786168576,
		["PodWreckage"] = 375220600960,
		["SiltingShore"] = 3526623488,
		["SilvermystIsle"] = 478913198336,
		["StillpineHold"] = 52996342016,
		["TheExodar"] = 91346174464,
		["ValaarsBerth"] = 325528584448,
		["WrathscalePoint"] = 452276247808,
	},
	["Badlands"] = {
		["AgmondsEnd"] = 338470208854,
		["AngorFortress"] = 73255845149,
		["ApocryphansRest"] = 70867322108,
		["CampBoff"] = 236650430738,
		["CampCagg"] = 301721808211,
		["CampKosh"] = 20929843436,
		["DeathwingScar"] = 191309866312,
		["HammertoesDigsite"] = 124985217233,
		["LethlorRavine"] = 59615319509,
		["TheDustbowl"] = 106451727574,
		["Uldaman"] = 352536842,
	},
	["Barrens"] = {
		["BoulderLodeMine"] = 8052229398,
		["DreadmistPeak"] = 111973436657,
		["FarWatchPost"] = 139094995151,
		["GroldomFarm"] = 136835196147,
		["MorshanRampart"] = 6713204997,
		["Ratchet"] = 407521901787,
		["TheCrossroads"] = 295658783977,
		["TheDryHills"] = 61325195547,
		["TheForgottenPools"] = 223443419582,
		["TheMerchantCoast"] = 490209497403,
		["TheSludgeFen"] = 6865282305,
		["TheStagnantOasis"] = 407309157712,
		["TheWailingCaverns"] = 341609616761,
		["ThornHill"] = 273235025135,
	},
	["BladesEdgeMountains"] = {
		["BashirLanding"] = 442761472,
		["BladedGulch"] = 158493573376,
		["BladesipreHold"] = 173202205952,
		["BloodmaulCamp"] = 102437748992,
		["BloodmaulOutpost"] = 398717134080,
		["BrokenWilds"] = 117806727424,
		["CircleofWrath"] = 225946370304,
		["DeathsDoor"] = 267899014400,
		["ForgeCampAnger"] = 158454776224,
		["ForgeCampTerror"] = 446827852288,
		["ForgeCampWrath"] = 189245161728,
		["Grishnath"] = 30364926208,
		["GruulsLayer"] = 87525949696,
		["JaggedRidge"] = 444997040384,
		["MokNathalVillage"] = 319591547136,
		["RavensWood"] = 59280458240,
		["RazorRidge"] = 357041520896,
		["RidgeofMadness"] = 277606721792,
		["RuuanWeald"] = 105729491200,
		["Skald"] = 76941623552,
		["Sylvanaar"] = 376113002752,
		["TheCrystalpine"] = 613679360,
		["ThunderlordStronghold"] = 292482855168,
		["VeilLashh"] = 459845910784,
		["VeilRuuan"] = 162725495040,
		["VekhaarStand"] = 436598997248,
		["VortexPinnacle"] = 221365352704,
	},
	["BlastedLands"] = {
		["AltarofStorms"] = 118347730158,
		["DreadmaulHold"] = 270743824,
		["DreadmaulPost"] = 195764089067,
		["NethergardeKeep"] = 6998406439,
		["NethergardeSupplyCamps"] = 457383107,
		["RISEOFTHEDEFILER"] = 109915056296,
		["SerpentsCoil"] = 104634440922,
		["Shattershore"] = 98316859632,
		["SunveilExcursion"] = 401984465129,
		["Surwich"] = 509302996167,
		["TheDarkPortal"] = 192585967986,
		["TheRedReaches"] = 288322062604,
		["TheTaintedForest"] = 334072485212,
		["TheTaintedScar"] = 188056045876,
	},
	["BloodmystIsle"] = {
		["AmberwebPass"] = 66618654976,
		["Axxarien"] = 146340577536,
		["BlacksiltShore"] = 457599863296,
		["Bladewood"] = 224797131008,
		["BloodWatch"] = 277483880704,
		["BloodscaleIsle"] = 275678232815,
		["BristlelimbEnclave"] = 440806932736,
		["KesselsCrossing"] = 566404199909,
		["Middenvale"] = 436373553408,
		["Mystwood"] = 518941500672,
		["Nazzivian"] = 434054103296,
		["RagefeatherRidge"] = 126132420864,
		["RuinsofLorethAran"] = 232511504640,
		["TalonStand"] = 84441039104,
		["TelathionsCamp"] = 232117108864,
		["TheBloodcursedReef"] = 58746732800,
		["TheBloodwash"] = 29307961600,
		["TheCrimsonReach"] = 93997760768,
		["TheCryoCore"] = 306323915008,
		["TheFoulPool"] = 146260885760,
		["TheHiddenReef"] = 42091151616,
		["TheLostFold"] = 505186294016,
		["TheVectorCoil"] = 255596083712,
		["TheWarpPiston"] = 31611683072,
		["VeridianPoint"] = 668205312,
		["VindicatorsRest"] = 260089053440,
		["WrathscaleLair"] = 363552047360,
		["WyrmscarIsland"] = 88689869056,
	},
	["BoreanTundra"] = {
		["AmberLedge"] = 150664861940,
		["BorGorokOutpost"] = 329461132,
		["Coldarra"] = 52819404,
		["DeathsStand"] = 195088899361,
		["GarroshsLanding"] = 255711373579,
		["Kaskala"] = 230314799489,
		["RiplashStrand"] = 411550615934,
		["SteeljawsCaravan"] = 71283571956,
		["TempleCityOfEnKilah"] = 16853012770,
		["TheDensOfDying"] = 12505531595,
		["TheGeyserFields"] = 503667063,
		["TorpsFarm"] = 254762307770,
		["ValianceKeep"] = 283947350275,
		["WarsongStronghold"] = 254822078724,
	},
	["BurningSteppes"] = {
		["AltarofStorms"] = 368822,
		["BlackrockMountain"] = 83235097,
		["BlackrockPass"] = 277465164074,
		["BlackrockStronghold"] = 246809920,
		["Dracodar"] = 254477253994,
		["DreadmaulRock"] = 162730876178,
		["MorgansVigil"] = 274449462655,
		["PillarofAsh"] = 274069878034,
		["RuinsofThaurissan"] = 441813316,
		["TerrorWingPath"] = 8193922398,
	},
	["CrystalsongForest"] = {
		["ForlornWoods"] = 135950880,
		["SunreaversCommand"] = 43512087998,
		["TheAzureFront"] = 261993439648,
		["TheDecrepitFlow"] = 227616,
		["TheGreatTree"] = 97710772476,
		["TheUnboundThicket"] = 113267668470,
		["VioletStand"] = 188978871560,
		["WindrunnersOverlook"] = 411708978734,
	},
	["Darkshore"] = {
		["AmethAran"] = 354643232070,
		["EyeoftheVortex"] = 256939065674,
		["Lordanel"] = 58392339733,
		["Nazjvel"] = 501654693108,
		["RuinsofAuberdine"] = 195714812107,
		["RuinsofMathystra"] = 30607154376,
		["ShatterspearVale"] = 17805067514,
		["ShatterspearWarcamp"] = 592596213,
		["TheMastersGlaive"] = 518907946287,
		["WildbendRiver"] = 406168208698,
		["WitheringThicket"] = 127021607240,
	},
	["DeadwindPass"] = {
		["DeadmansCrossing"] = 87566953,
		["Karazhan"] = 332956801537,
		["TheVice"] = 223792792926,
	},
	["Deepholm"] = {
		["CrimsonExpanse"] = 13451542990,
		["DeathwingsFall"] = 319477341638,
		["NeedlerockChasm"] = 21339514,
		["NeedlerockSlag"] = 156766598514,
		["ScouredReach"] = 470056452,
		["StoneHearth"] = 337155295603,
		["StormsFuryWreckage"] = 411723658532,
		["TempleOfEarth"] = 190353597795,
		["ThePaleRoost"] = 89408979,
		["TheShatteredField"] = 470447004078,
		["TherazanesThrone"] = 455242002,
		["TwilightOverlook"] = 451569508763,
		["TwilightTerrace"] = 412628490477,
	},
	["Desolace"] = {
		["CenarionWildlands"] = 167939175736,
		["GelkisVillage"] = 507023397138,
		["KodoGraveyard"] = 293509225722,
		["MagramTerritory"] = 183179137313,
		["MannorocCoven"] = 383725657414,
		["NijelsPoint"] = 601097447,
		["RanzjarIsle"] = 220345505,
		["Sargeron"] = 687117629,
		["ShadowbreakRavine"] = 432312428836,
		["ShadowpreyVillage"] = 396359937246,
		["ShokThokar"] = 343141610805,
		["SlitherbladeShore"] = 25988258130,
		["TethrisAran"] = 418530578,
		["ThargadsCamp"] = 404015474900,
		["ThunderAxeFortress"] = 53074932956,
		["ValleyofSpears"] = 210631937345,
	},
	["Dragonblight"] = {
		["AgmarsHammer"] = 218240346348,
		["Angrathar"] = 220449074,
		["ColdwindHeights"] = 422800597,
		["EmeraldDragonshrine"] = 389264140484,
		["GalakrondsRest"] = 127155799298,
		["IcemistVillage"] = 177308255467,
		["LakeIndule"] = 336309039460,
		["LightsRest"] = 8253626667,
		["Naxxramas"] = 172523536695,
		["NewHearthglen"] = 385043666134,
		["ObsidianDragonshrine"] = 111937793328,
		["RubyDragonshrine"] = 223730683068,
		["ScarletPoint"] = 8113195243,
		["TheCrystalVice"] = 510921957,
		["TheForgottenShore"] = 357214484781,
		["VenomSpite"] = 284161167586,
		["WestwindRefugeeCamp"] = 200834067685,
		["WyrmrestTemple"] = 235624826173,
	},
	["DreadWastes"] = {
		["BREWGARDEN"] = 368273658,
		["BRINYMUCK"] = 334158379333,
		["CLUTCHESOFSHEKZEER"] = 134575618257,
		["DREADWATERLAKE"] = 336539635010,
		["HEARTOFFEAR"] = 131197080838,
		["HORRIDMARCH"] = 240980789571,
		["KLAXXIVESS"] = 118592059628,
		["KYPARIVOR"] = 508754245,
		["RIKKITUNVILLAGE"] = 34607392986,
		["SOGGYSGAMBLE"] = 436411286796,
		["TERRACEOFGURTHAN"] = 99406293201,
		["ZANVESS"] = 413560761634,
	},
	["DunMorogh"] = {
		["AmberstillRanch"] = 242216000761,
		["ColdridgePass"] = 365449990369,
		["ColdridgeValley"] = 393094674830,
		["FrostmaneFront"] = 275370032354,
		["FrostmaneHold"] = 243792078261,
		["Gnomeregan"] = 28991355289,
		["GolBolarQuarry"] = 309933108422,
		["HelmsBedLake"] = 288559966426,
		["IceFlowLake"] = 276142316,
		["Ironforge"] = 417688952,
		["IronforgeAirfield"] = 660946228,
		["Kharanos"] = 236694204600,
		["NorthGateOutpost"] = 46973434093,
		["TheGrizzledDen"] = 308556234963,
		["TheShimmeringDeep"] = 142150445227,
		["TheTundridHills"] = 329172378798,
	},
	["Durotar"] = {
		["DrygulchRavine"] = 64859869420,
		["EchoIsles"] = 443905473866,
		["NorthwatchFoothold"] = 472864945314,
		["Orgrimmar"] = 324179203,
		["RazorHill"] = 169029635296,
		["RazormaneGrounds"] = 283784673528,
		["SenjinVillage"] = 436418568384,
		["SkullRock"] = 459437264,
		["SouthfuryWatershed"] = 187127003380,
		["ThunderRidge"] = 51849160924,
		["TiragardeKeep"] = 320459710674,
		["ValleyOfTrials"] = 335326480638,
	},
	["Duskwood"] = {
		["AddlesStead"] = 373696012587,
		["BrightwoodGrove"] = 120780635415,
		["Darkshire"] = 138110363977,
		["ManorMistmantle"] = 131689797851,
		["RacenHill"] = 313633436877,
		["RavenHillCemetary"] = 141829657923,
		["TheDarkenedBank"] = 27991977891,
		["TheHushedBank"] = 163209071805,
		["TheRottingOrchard"] = 395702443299,
		["TheTranquilGardensCemetary"] = 370024894755,
		["TheTwilightGrove"] = 108777574720,
		["TheYorgenFarmstead"] = 425622495465,
		["VulGolOgreMound"] = 381417711884,
	},
	["Dustwallow"] = {
		["AlcazIsland"] = 23236649166,
		["BlackhoofVillage"] = 208854360,
		["BrackenwllVillage"] = 63490483584,
		["DirehornPost"] = 181838066967,
		["Mudsprocket"] = 336195845553,
		["ShadyRestInn"] = 202007353661,
		["TheWyrmbog"] = 396587478452,
		["TheramoreIsle"] = 240013008177,
		["WitchHill"] = 449152270,
	},
	["Dustwallow_terrain1"] = {
		["ALCAZISLAND"] = 23236649166,
		["BLACKHOOFVILLAGE"] = 208854360,
		["BRACKENWLLVILLAGE"] = 63490483584,
		["DIREHORNPOST"] = 181838066967,
		["MUDSPROCKET"] = 336195845553,
		["SHADYRESTINN"] = 202007353661,
		["THERAMOREISLE"] = 240013008177,
		["THEWYRMBOG"] = 396587478452,
		["WITCHHILL"] = 449152270,
	},
	["EasternPlaguelands"] = {
		["Acherus"] = 110333543652,
		["BlackwoodLake"] = 162535808238,
		["CorinsCrossing"] = 310828553402,
		["CrownGuardTower"] = 377154108618,
		["Darrowshire"] = 496290183416,
		["EastwallTower"] = 198135955637,
		["LakeMereldar"] = 458972448010,
		["LightsHopeChapel"] = 291704631492,
		["LightsShieldTower"] = 291394193651,
		["Northdale"] = 66096177417,
		["NorthpassTower"] = 74508861690,
		["Plaguewood"] = 43100927304,
		["QuelLithienLodge"] = 368229653,
		["RuinsOfTheScarletEnclave"] = 317528069384,
		["Stratholme"] = 123914550,
		["Terrordale"] = 10737746178,
		["TheFungalVale"] = 226751635730,
		["TheInfectisScar"] = 283018274993,
		["TheMarrisStead"] = 359843178698,
		["TheNoxiousGlade"] = 59737681193,
		["ThePestilentScar"] = 374064087222,
		["TheUndercroft"] = 490758950168,
		["ThondorilRiver"] = 107374721286,
		["Tyrshand"] = 445211998422,
		["ZulMashar"] = 553828638,
	},
	["Elwynn"] = {
		["BrackwellPumpkinPatch"] = 455824597279,
		["CrystalLake"] = 351551044828,
		["EastvaleLoggingCamp"] = 314270010662,
		["FargodeepMine"] = 451223478541,
		["Goldshire"] = 315939331348,
		["JerodsLanding"] = 462124431590,
		["NorthshireValley"] = 148548919591,
		["RidgepointTower"] = 475336476957,
		["StonecairnLake"] = 200295072084,
		["Stromwind"] = 432640,
		["TowerofAzora"] = 308718847246,
		["WestbrookGarrison"] = 381300303117,
	},
	["EversongWoods"] = {
		["AzurebreezeCoast"] = 245514895616,
		["DuskwitherGrounds"] = 272291332352,
		["EastSanctum"] = 400988307712,
		["ElrendarFalls"] = 429031424128,
		["FairbreezeVilliage"] = 414869356800,
		["FarstriderRetreat"] = 386022899968,
		["GoldenboughPass"] = 503839850752,
		["LakeElrendar"] = 506344969344,
		["NorthSanctum"] = 320353861888,
		["RuinsofSilvermoon"] = 146351063296,
		["RunestoneFalithas"] = 532972482816,
		["RunestoneShandor"] = 530915178752,
		["SatherilsHaven"] = 412656861440,
		["SilvermoonCity"] = 93877436928,
		["StillwhisperPond"] = 337652220160,
		["SunsailAnchorage"] = 434034049280,
		["SunstriderIsle"] = 5573706240,
		["TheGoldenStrand"] = 445795005568,
		["TheLivingWood"] = 451507642496,
		["TheScortchedGrove"] = 544654622976,
		["ThuronsLivery"] = 328056570112,
		["TorWatha"] = 338908513536,
		["TranquilShore"] = 320200769792,
		["WestSanctum"] = 342830088320,
		["Zebwatha"] = 510608475264,
	},
	["Felwood"] = {
		["BloodvenomFalls"] = 248265245017,
		["DeadwoodVillage"] = 542669704365,
		["EmeraldSanctuary"] = 410582733074,
		["FelpawVillage"] = 494044467,
		["IrontreeWoods"] = 59481801989,
		["JadefireGlen"] = 492075960549,
		["JadefireRun"] = 9981598983,
		["Jaedenar"] = 340621705535,
		["MorlosAran"] = 520190345403,
		["RuinsofConstellas"] = 385765038348,
		["ShatterScarVale"] = 115145435479,
		["TalonbranchGlade"] = 61760309457,
	},
	["Feralas"] = {
		["CampMojache"] = 195051090094,
		["DarkmistRuins"] = 308759697580,
		["DireMaul"] = 108956774665,
		["FeathermoonStronghold"] = 254856593625,
		["FeralScar"] = 302200835263,
		["GordunniOutpost"] = 125249418432,
		["GrimtotemCompund"] = 183172819103,
		["LowerWilds"] = 205877626063,
		["RuinsofFeathermoon"] = 246082121936,
		["RuinsofIsildien"] = 380594533582,
		["TheForgottenCoast"] = 368686973122,
		["TheTwinColossals"] = 284506462,
		["WrithingDeep"] = 320658946280,
	},
	["FrostfireRidge"] = {
		["BLADESPIREFORTRESS"] = 125667949924,
		["BLOODMAULSTRONGHOLD"] = 4621296898,
		["BONESOFAGURAK"] = 343288411409,
		["DAGGERMAWRAVINE"] = 98008497407,
		["FROSTWINDDUNES"] = 127097106,
		["GRIMFROSTHILL"] = 226111990962,
		["GROMBOLASH"] = 35940187353,
		["GROMGAR"] = 347348489498,
		["HORDEGARRISON"] = 351466161419,
		["IRONSIEGEWORKS"] = 168209717577,
		["IRONWAYSTATION"] = 327089994951,
		["MAGNAROK"] = 36072347861,
		["NOGARRISON"] = 351466161419,
		["STONEFANGOUTPOST"] = 302042512635,
		["THEBONESLAG"] = 206462732544,
		["THECRACKLINGPLAINS"] = 147563255050,
		["WORGOL"] = 313608348989,
	},
	["Ghostlands"] = {
		["AmaniPass"] = 249735598484,
		["BleedingZiggurat"] = 255743754496,
		["DawnstarSpire"] = 603193771,
		["Deatholme"] = 402753099264,
		["ElrendarCrossing"] = 342098432,
		["FarstriderEnclave"] = 146629984685,
		["GoldenmistVillage"] = 46662144,
		["HowlingZiggurat"] = 235506435328,
		["IsleofTribulations"] = 613679360,
		["SanctumoftheMoon"] = 135511933184,
		["SanctumoftheSun"] = 161531560192,
		["SuncrownVillage"] = 482607616,
		["ThalassiaPass"] = 436321130752,
		["Tranquillien"] = 2530738432,
		["WindrunnerSpire"] = 308206108928,
		["WindrunnerVillage"] = 125691232512,
		["ZebNowa"] = 254965890560,
	},
	["Gilneas"] = {
		["CrowleyOrchard"] = 458761607378,
		["Duskhaven"] = 357841422622,
		["EmberstoneMine"] = 46841298201,
		["GilneasCity"] = 225992514842,
		["Greymanemanor"] = 217043944692,
		["HammondFarmstead"] = 378132476098,
		["HaywardFishery"] = 482417536177,
		["Keelharbor"] = 102318299416,
		["KorothsDen"] = 414876709086,
		["NorthernHeadlands"] = 406120715,
		["NorthgateWoods"] = 15538104602,
		["StormglenVillage"] = 499831221569,
		["TempestsReach"] = 312069154142,
		["TheBlackwald"] = 423582990616,
		["TheHeadlands"] = 168116552,
	},
	["Gorgrond"] = {
		["BASTIONRISE"] = 544684016964,
		["BEASTWATCH"] = 398759986342,
		["EASTERNRUIN"] = 279723574482,
		["EVERMORN"] = 477036205353,
		["FOUNDRY"] = 79934223571,
		["FOUNDRYSOUTH"] = 196970991833,
		["GRONNCANYON"] = 228977788183,
		["HIGHLANDPASS"] = 78957055261,
		["HIGHPASS"] = 268866651345,
		["IRONDOCKS"] = 367186235,
		["MUSHROOMS"] = 347284379901,
		["STONEMAULARENA"] = 359975274713,
		["STONEMAULSOUTH"] = 446965102800,
		["STRIPMINE"] = 83005513978,
		["TANGLEHEART"] = 399905092870,
	},
	["GrizzlyHills"] = {
		["AmberpineLodge"] = 262220843286,
		["BlueSkyLoggingGrounds"] = 138756205817,
		["CampOneqwah"] = 147677521220,
		["ConquestHold"] = 329656867148,
		["DrakTheronKeep"] = 49392416126,
		["DrakilJinRuins"] = 44660191583,
		["DunArgol"] = 276525629895,
		["GraniteSprings"] = 222272127332,
		["GrizzleMaw"] = 201165344038,
		["RageFangShrine"] = 316007623131,
		["ThorModan"] = 533977417,
		["UrsocsDen"] = 34707083592,
		["VentureBay"] = 495014067474,
		["Voldrune"] = 452230110491,
	},
	["Hellfire"] = {
		["DenofHaalesh"] = 442572734720,
		["ExpeditionArmory"] = 443729313280,
		["FalconWatch"] = 350232074752,
		["FallenSkyRidge"] = 152507252992,
		["ForgeCampRage"] = 27345289728,
		["HellfireCitadel"] = 225840670976,
		["HonorHold"] = 320467108096,
		["MagharPost"] = 118327869696,
		["PoolsofAggonar"] = 48660742400,
		["RuinsofShanaar"] = 311411730688,
		["TempleofTelhamat"] = 163249127936,
		["TheLegionFront"] = 138046603520,
		["TheStairofDestiny"] = 168277049600,
		["Thrallmar"] = 165846188288,
		["ThroneofKiljaeden"] = 6942884352,
		["VoidRidge"] = 395876499712,
		["WarpFields"] = 438409892096,
		["ZethGor"] = 462317402534,
	},
	["HillsbradFoothills"] = {
		["AzurelodeMine"] = 428724115636,
		["ChillwindPoint"] = 73596673471,
		["CorrahnsDagger"] = 240965025927,
		["CrushridgeHold"] = 108933542022,
		["DalaranCrater"] = 147209828668,
		["DandredsFold"] = 357680386,
		["DarrowHill"] = 300019777683,
		["DunGarok"] = 440802740493,
		["DurnholdeKeep"] = 233594883509,
		["GallowsCorner"] = 150796913819,
		["GavinsNaze"] = 273091265652,
		["GrowlessCave"] = 205461266603,
		["HillsbradFields"] = 324470488366,
		["LordamereInternmentCamp"] = 232131828986,
		["MistyShore"] = 45433922718,
		["NethanderSteed"] = 401032335564,
		["PurgationIsle"] = 542449478800,
		["RuinsOfAlterac"] = 91632096445,
		["SlaughterHollow"] = 59488985236,
		["SoferasNaze"] = 178748803220,
		["SouthpointTower"] = 332922091832,
		["Southshore"] = 378358951141,
		["Strahnbrad"] = 47774369043,
		["TarrenMill"] = 243183856805,
		["TheHeadland"] = 274213261417,
		["TheUplands"] = 462586068,
	},
	["Hinterlands"] = {
		["AeriePeak"] = 253403344110,
		["Agolwatha"] = 171109986512,
		["JinthaAlor"] = 359140721951,
		["PlaguemistRavine"] = 112882636991,
		["QuelDanilLodge"] = 194578173169,
		["Seradane"] = 5867101487,
		["ShadraAlor"] = 407179038960,
		["Shaolwatha"] = 223931012377,
		["SkulkRock"] = 209893698736,
		["TheAltarofZul"] = 368667988193,
		["TheCreepingRuin"] = 270992088263,
		["TheOverlookCliffs"] = 287399363828,
		["ValorwindLake"] = 289136660679,
		["Zunwatha"] = 305102292194,
	},
	["HowlingFjord"] = {
		["AncientLift"] = 377242188977,
		["ApothecaryCamp"] = 39832528135,
		["BaelgunsExcavationSite"] = 351765054708,
		["Baleheim"] = 183140267182,
		["CampWinterHoof"] = 371410143,
		["CauldrosIsle"] = 173386418357,
		["EmberClutch"] = 218266599637,
		["ExplorersLeagueOutpost"] = 361390891240,
		["FortWildervar"] = 513999099,
		["GiantsRun"] = 600099114,
		["Gjalerbron"] = 236123378,
		["Halgrind"] = 223754853563,
		["IvaldsRuin"] = 240145081537,
		["Kamagua"] = 298604307789,
		["NewAgamand"] = 386982531356,
		["Nifflevar"] = 258322153650,
		["ScalawagPoint"] = 440410573150,
		["Skorn"] = 116324016366,
		["SteelGate"] = 107607138526,
		["TheTwistedGlade"] = 61643901194,
		["UtgardeKeep"] = 232428796152,
		["VengeanceLanding"] = 27540146399,
		["WestguardKeep"] = 193368125787,
	},
	["HrothgarsLanding"] = {
	},
	["Hyjal"] = {
		["ArchimondesVengeance"] = 5704560910,
		["AshenLake"] = 83758582042,
		["DarkwhisperGorge"] = 138154564928,
		["DireforgeHill"] = 211845035278,
		["GatesOfSothann"] = 344249940240,
		["Nordrassil"] = 411373081,
		["SethriasRoost"] = 468297425173,
		["ShrineOfGoldrinn"] = 18375574819,
		["TheRegrowth"] = 271711534521,
		["TheScorchedPlain"] = 232359469421,
		["TheThroneOfFlame"] = 406208154019,
	},
	["IcecrownGlacier"] = {
		["Aldurthar"] = 40101076341,
		["ArgentTournamentGround"] = 32858407226,
		["Corprethar"] = 421265625396,
		["IcecrownCitadel"] = 500774938932,
		["Jotunheim"] = 131020056969,
		["OnslaughtHarbor"] = 179315159244,
		["Scourgeholme"] = 287412829429,
		["SindragosasFall"] = 33942756652,
		["TheBombardment"] = 194911653112,
		["TheBrokenFront"] = 353846402331,
		["TheConflagration"] = 327834355939,
		["TheFleshwerks"] = 312687750363,
		["TheShadowVault"] = 16443129055,
		["Valhalas"] = 53914878190,
		["ValleyofEchoes"] = 419509265677,
		["Ymirheim"] = 296818523359,
	},
	["Kezan"] = {
		["KEZANMAP"] = 4295648234,
	},
	["Krasarang"] = {
		["AnglersOutpost"] = 220688746761,
		["CradleOfChiJi"] = 403911731472,
		["DojaniRiver"] = 3759433918,
		["FallsongRiver"] = 82907112662,
		["LostDynasty"] = 29608926425,
		["NayeliLagoon"] = 400865607926,
		["RedwingRefuge"] = 67978405076,
		["RuinsOfDojan"] = 47710600396,
		["RuinsOfKorja"] = 94620757203,
		["TempleOfTheRedCrane"] = 231169330395,
		["TheDeepwild"] = 63767474364,
		["TheForbiddenJungle"] = 84825911553,
		["TheSouthernIsles"] = 286713505020,
		["UngaIngoo"] = 535069632770,
		["ZhusBastion"] = 641937714,
		["krasarangCove"] = 21136421150,
	},
	["Krasarang_terrain1"] = {
		["ANGLERSOUTPOST"] = 215320042843,
		["CRADLEOFCHIJI"] = 403911731472,
		["DOJANIRIVER"] = 3759433918,
		["FALLSONGRIVER"] = 82907112662,
		["KRASARANGCOVE"] = 21136446759,
		["LOSTDYNASTY"] = 29608926425,
		["NAYELILAGOON"] = 400865607926,
		["REDWINGREFUGE"] = 67978405076,
		["RUINSOFDOJAN"] = 47710600396,
		["RUINSOFKORJA"] = 94620757203,
		["TEMPLEOFTHEREDCRANE"] = 231169330395,
		["THEDEEPWILD"] = 63767474364,
		["THEFORBIDDENJUNGLE"] = 84825911553,
		["THESOUTHERNISLES"] = 286689404179,
		["UNGAINGOO"] = 535069632770,
		["ZHUSBASTION"] = 641937714,
	},
	["KunLaiSummit"] = {
		["BinanVillage"] = 505295345904,
		["FireboughNook"] = 532913762528,
		["GateoftheAugust"] = 543784339717,
		["Iseoflostsouls"] = 4926448899,
		["Kotapeak"] = 386791638268,
		["Mogujia"] = 441792545021,
		["MountNeverset"] = 283707130169,
		["MuskpawRanch"] = 336713750757,
		["PeakOfSerenity"] = 67995194655,
		["ShadoPanMonastery"] = 98876917121,
		["TEMPLEOFTHEWHITETIGER"] = 183151890682,
		["TheBurlapTrail"] = 333277581622,
		["ValleyOfEmperors"] = 205559940320,
		["ZouchinVillage"] = 69246086442,
	},
	["LakeWintergrasp"] = {
	},
	["LochModan"] = {
		["GrizzlepawRidge"] = 348149487889,
		["IronbandsExcavationSite"] = 318332243341,
		["MogroshStronghold"] = 56410498342,
		["NorthgatePass"] = 17073471,
		["SilverStreamMine"] = 231993569,
		["StonesplinterValley"] = 370626828561,
		["StronewroughtDam"] = 355672397,
		["TheFarstriderLodge"] = 225010028893,
		["TheLoch"] = 87330089290,
		["Thelsamar"] = 156766608839,
		["ValleyofKings"] = 333934060854,
	},
	["Moonglade"] = {
		["LakeEluneara"] = 293361483183,
		["Nighthaven"] = 145343369562,
		["ShrineofRemulos"] = 97929961743,
		["StormrageBarrowDens"] = 226054465811,
	},
	["Mulgore"] = {
		["BaeldunDigsite"] = 236460376282,
		["BloodhoofVillage"] = 293466242350,
		["PalemaneRock"] = 344931382444,
		["RavagedCaravan"] = 240974468283,
		["RedCloudMesa"] = 430870634942,
		["RedRocks"] = 46710056122,
		["StonetalonPass"] = 210952429,
		["TheGoldenPlains"] = 108917907642,
		["TheRollingPlains"] = 313011719428,
		["TheVentureCoMine"] = 148732424400,
		["ThunderBluff"] = 66790362485,
		["ThunderhornWaterWell"] = 217245195465,
		["WildmaneWaterWell"] = 347254974,
		["WindfuryRidge"] = 419637470,
		["WinterhoofWaterWell"] = 365543220398,
	},
	["Nagrand"] = {
		["BurningBladeRUins"] = 359322171648,
		["ClanWatch"] = 390326386944,
		["ForgeCampFear"] = 266326151680,
		["ForgeCampHate"] = 165526372608,
		["Garadar"] = 153997279488,
		["Halaa"] = 207583707392,
		["KilsorrowFortress"] = 459073111296,
		["LaughingSkullRuins"] = 56202887424,
		["OshuGun"] = 358806272512,
		["RingofTrials"] = 287248220416,
		["SouthwindCleft"] = 277435646208,
		["SunspringPost"] = 213904523520,
		["Telaar"] = 419165372672,
		["ThroneoftheElements"] = 57437061376,
		["TwilightRidge"] = 114901385472,
		["WarmaulHill"] = 34524627200,
		["WindyreedPass"] = 85452914944,
		["WindyreedVillage"] = 250880459008,
		["ZangarRidge"] = 58272776448,
	},
	["NagrandDraenor"] = {
		["ANCESTRAL"] = 278349937898,
		["BROKENPRECIPICE"] = 13153570097,
		["ELEMENTALS"] = 616843550,
		["GROMMASHAR"] = 394692703488,
		["HALLVALOR"] = 127505125612,
		["HIGHMAUL"] = 447959,
		["IRONFISTHARBOR"] = 380401600748,
		["LOKRATH"] = 201190503740,
		["MARGOKS"] = 408811766009,
		["MUSHROOMS"] = 27626077434,
		["OSHUGUN"] = 347202660614,
		["RINGOFBLOOD"] = 451181831,
		["RINGOFTRIALS"] = 171273678178,
		["SUNSPRINGWATCH"] = 105554114834,
		["TELAAR"] = 379514536232,
	},
	["Netherstorm"] = {
		["Area52"] = 416864665856,
		["ArklonRuins"] = 426619699456,
		["CelestialRidge"] = 186432880896,
		["EcoDomeFarfield"] = 11152916736,
		["EtheriumStagingGrounds"] = 223842926848,
		["ForgeBaseOG"] = 23871095040,
		["KirinVarVillage"] = 562080924928,
		["ManaforgeBanar"] = 301875989760,
		["ManaforgeCoruu"] = 525434277120,
		["ManaforgeDuro"] = 361265103104,
		["ManafrogeAra"] = 166609551616,
		["Netherstone"] = 21906063616,
		["NetherstormBridge"] = 315818770688,
		["RuinedManaforge"] = 148714553600,
		["RuinsofEnkaat"] = 323461841152,
		["RuinsofFarahlon"] = 52984807936,
		["SocretharsSeat"] = 41042575616,
		["SunfuryHold"] = 484733838592,
		["TempestKeep"] = 305564877209,
		["TheHeap"] = 488803357952,
		["TheScrapField"] = 280620171520,
		["TheStormspire"] = 144194142464,
	},
	["Redridge"] = {
		["AlthersMill"] = 149617368292,
		["CampEverstill"] = 307556975805,
		["GalardellValley"] = 602357164,
		["LakeEverstill"] = 229865941456,
		["LakeridgeHighway"] = 339457966472,
		["Lakeshire"] = 118111863194,
		["RedridgeCanyons"] = 39096733,
		["RendersCamp"] = 224647525,
		["RendersValley"] = 405273873835,
		["ShalewindCanyon"] = 304590688562,
		["StonewatchFalls"] = 324820719932,
		["StonewatchKeep"] = 503746788,
		["ThreeCorners"] = 274878323011,
	},
	["RuinsofGilneas"] = {
		["GilneasPuzzle"] = 685034,
	},
	["STVDiamondMineBG"] = {
		["17467"] = 185973492097,
		["17468"] = 103513553258,
		["17469"] = 310904028324,
		["17470"] = 135884178645,
	},
	["SearingGorge"] = {
		["BlackcharCave"] = 387621113207,
		["BlackrockMountain"] = 455521587504,
		["DustfireValley"] = 616926600,
		["FirewatchRidge"] = 80531039597,
		["GrimsiltWorksite"] = 259328846265,
		["TannerCamp"] = 386980434491,
		["TheCauldron"] = 183853490657,
		["ThoriumPoint"] = 41069884845,
	},
	["ShadowmoonValley"] = {
		["AltarofShatar"] = 100403511552,
		["CoilskarPoint"] = 8955363840,
		["EclipsePoint"] = 333219994112,
		["IlladarPoint"] = 275028115712,
		["LegionHold"] = 166539559424,
		["NetherwingCliffs"] = 331293655296,
		["NetherwingLedge"] = 478350114284,
		["ShadowmoonVilliage"] = 37703123456,
		["TheBlackTemple"] = 135927431564,
		["TheDeathForge"] = 138817306880,
		["TheHandofGuldan"] = 97050427904,
		["TheWardensCage"] = 277517593088,
		["WildhammerStronghold"] = 246063488512,
	},
	["ShadowmoonValleyDR"] = {
		["ANGUISHFORTRESS"] = 171945763125,
		["DARKTIDEROOST"] = 501928371482,
		["ELODOR"] = 446966051,
		["EMBAARI"] = 169934582106,
		["GARRISON"] = 203709663,
		["GLOOMSHADE"] = 5703450853,
		["GULVAR"] = 27579652,
		["KARABOR"] = 161624684937,
		["NOGARRISON"] = 203709663,
		["SHAZGUL"] = 338500486426,
		["SHIMMERINGMOOR"] = 329040270624,
		["SOCRETHAR"] = 441709700298,
		["SWISLAND"] = 494245413037,
	},
	["SholazarBasin"] = {
		["KartaksHold"] = 402733176137,
		["RainspeakerCanopy"] = 262440987855,
		["RiversHeart"] = 364375254484,
		["TheAvalanche"] = 99409470786,
		["TheGlimmeringPillar"] = 36830518566,
		["TheLifebloodPillar"] = 144407119160,
		["TheMakersOverlook"] = 254142609641,
		["TheMakersPerch"] = 145135755513,
		["TheMosslightPillar"] = 381456540911,
		["TheSavageThicket"] = 55176303909,
		["TheStormwrightsShelf"] = 62422024460,
		["TheSuntouchedPillar"] = 199802286535,
	},
	["Silithus"] = {
		["CenarionHold"] = 153993089316,
		["HiveAshi"] = 4656999829,
		["HiveRegal"] = 333258791401,
		["HiveZora"] = 221191192094,
		["SouthwindVillage"] = 194924236085,
		["TheCrystalVale"] = 132372809,
		["TheScarabWall"] = 488552748612,
		["TwilightBaseCamp"] = 162240110002,
		["ValorsRest"] = 644117819,
	},
	["Silverpine"] = {
		["Ambermill"] = 268969430299,
		["BerensPeril"] = 435395239230,
		["DeepElemMine"] = 228139931865,
		["FenrisIsle"] = 16715659616,
		["ForsakenHighCommand"] = 466795881,
		["ForsakenRearGuard"] = 387168442,
		["NorthTidesBeachhead"] = 73353338030,
		["NorthTidesRun"] = 154494233,
		["OlsensFarthing"] = 267689041147,
		["ShadowfangKeep"] = 362204533939,
		["TheBattlefront"] = 461001380095,
		["TheDecrepitFields"] = 167997759664,
		["TheForsakenFront"] = 351567803544,
		["TheGreymaneWall"] = 543646976409,
		["TheSepulcher"] = 168935235802,
		["TheSkitteringDark"] = 247640291,
		["ValgansField"] = 83161690274,
	},
	["SouthernBarrens"] = {
		["BaelModan"] = 491117563149,
		["Battlescar"] = 329926304128,
		["ForwardCommand"] = 269952921816,
		["FrazzlecrazMotherload"] = 468433702130,
		["HonorsStand"] = 210938171,
		["HuntersHill"] = 69034232026,
		["NorthwatchHold"] = 158414953752,
		["RazorfenKraul"] = 567222087894,
		["RuinsofTaurajo"] = 307346189597,
		["TheOvergrowth"] = 125931063651,
		["VendettaPoint"] = 210733586686,
	},
	["SpiresOfArak"] = {
		["BLOODBLADEREDOUBT"] = 225836165329,
		["BLOODMANEVALLEY"] = 376239806693,
		["CENTERRAVENNEST"] = 274269927612,
		["CLUTCHPOP"] = 410728497369,
		["EASTMUSHROOMS"] = 167110758582,
		["EMPTYGARRISON"] = 280542506174,
		["HOWLINGCRAG"] = 481577342,
		["NWCORNER"] = 107266362,
		["SETHEKKHOLLOW"] = 136910773486,
		["SKETTIS"] = 303217011,
		["SOLOSPIRENORTH"] = 90644443332,
		["SOLOSPIRESOUTH"] = 296745093289,
		["SOUTHPORT"] = 352512560325,
		["VEILAKRAZ"] = 89415457020,
		["VEILZEKK"] = 288309354694,
		["VENTURECOVE"] = 510515152098,
		["WRITHINGMIRE"] = 212807668965,
	},
	["StonetalonMountains"] = {
		["BattlescarValley"] = 203168195874,
		["BoulderslideRavine"] = 550313816258,
		["CliffwalkerPost"] = 102389448945,
		["GreatwoodVale"] = 481667805506,
		["KromgarFortress"] = 366762725559,
		["Malakajin"] = 577247513811,
		["MirkfallonLake"] = 153982590196,
		["RuinsofEldrethar"] = 441692957917,
		["StonetalonPeak"] = 278122801,
		["SunRockRetreat"] = 306386794718,
		["ThaldarahOverlook"] = 130187195602,
		["TheCharredVale"] = 395345938709,
		["UnearthedGrounds"] = 396896712969,
		["WebwinderHollow"] = 431073003684,
		["WebwinderPath"] = 282885193995,
		["WindshearCrag"] = 192758971766,
		["WindshearHold"] = 310852646064,
	},
	["StranglethornJungle"] = {
		["BalAlRuins"] = 180668736671,
		["BaliaMahRuins"] = 261335758063,
		["Bambala"] = 176687333566,
		["FortLivingston"] = 403070691558,
		["GromGolBaseCamp"] = 245125794983,
		["KalAiRuins"] = 197939845259,
		["KurzensCompound"] = 523483380,
		["LakeNazferiti"] = 102438768880,
		["Mazthoril"] = 391353994590,
		["MizjahRuins"] = 264546464925,
		["MoshOggOgreMound"] = 272226269418,
		["NesingwarysExpedition"] = 67966793955,
		["RebelCamp"] = 321034542,
		["RuinsOfZulKunda"] = 165946596,
		["TheVileReef"] = 223485329644,
		["ZulGurub"] = 656982392,
		["ZuuldalaRuins"] = 23632026948,
	},
	["Sunwell"] = {
		["SunsReachHarbor"] = 270847607296,
		["SunsReachSanctum"] = 4558684672,
	},
	["SwampOfSorrows"] = {
		["Bogpaddle"] = 629343494,
		["IthariusCave"] = 259853185292,
		["MarshtideWatch"] = 501569866,
		["MistyValley"] = 85899638028,
		["MistyreedStrand"] = 629830034,
		["PoolOfTears"] = 256153720065,
		["Sorrowmurk"] = 86636923109,
		["SplinterspearJunction"] = 253606845678,
		["Stagalbog"] = 387113598299,
		["Stonard"] = 277337133413,
		["TheHarborage"] = 84994715914,
		["TheShiftingMire"] = 26117251364,
	},
	["Talador"] = {
		["ARUUNA"] = 191752284549,
		["AUCHINDOUN"] = 382606776629,
		["CENTERISLES"] = 245385945340,
		["COURTOFSOULS"] = 283625362739,
		["FORTWRYNN"] = 45691940132,
		["GORDALFORTRESS"] = 406449326503,
		["GULROK"] = 391015315734,
		["NORTHGATE"] = 598889870,
		["ORUNAICOAST"] = 448015639,
		["SEENTRANCE"] = 320693621044,
		["SHATTRATH"] = 23804099990,
		["TELMOR"] = 548899288561,
		["TOMBOFLIGHTS"] = 291353350470,
		["TUUREM"] = 159408947425,
		["ZANGARRA"] = 38328882463,
	},
	--[[["TanaanJungleIntro"] = {
		["TANK"] = 269853271183,
	},--]]
	["Tanaris"] = {
		["AbyssalSands"] = 159225415935,
		["BrokenPillar"] = 226992753859,
		["CavernsofTime"] = 256082359509,
		["DunemaulCompound"] = 276271645927,
		["EastmoonRuins"] = 366544587949,
		["Gadgetzan"] = 99216445629,
		["GadgetzanBay"] = 10166293758,
		["LandsEndBeach"] = 485783462112,
		["LostRiggerCover"] = 216467229874,
		["SandsorrowWatch"] = 106607826134,
		["SouthbreakShore"] = 310769805586,
		["SouthmoonRuins"] = 375051734248,
		["TheGapingChasm"] = 391311977697,
		["TheNoxiousLair"] = 226830252211,
		["ThistleshrubValley"] = 300841997533,
		["ValleryoftheWatchers"] = 463050307853,
		["ZulFarrak"] = 193132859,
	},
	["Teldrassil"] = {
		["BanethilHollow"] = 237689351343,
		["Darnassus"] = 194503853354,
		["GalardellValley"] = 254965639346,
		["GnarlpineHold"] = 381542388934,
		["LakeAlameth"] = 333302671649,
		["PoolsofArlithrien"] = 261281237132,
		["RutheranVillage"] = 481381544253,
		["Shadowglen"] = 112173737201,
		["StarbreezeVillage"] = 233572602043,
		["TheCleft"] = 117491075216,
		["TheOracleGlade"] = 96926421186,
		["WellspringLake"] = 89521382565,
	},
	["TerokkarForest"] = {
		["AllerianStronghold"] = 297930064128,
		["AuchenaiGrounds"] = 466263189760,
		["BleedingHollowClanRuins"] = 323304668416,
		["BonechewerRuins"] = 295825572096,
		["CarrionHill"] = 292453351680,
		["CenarionThicket"] = 329515264,
		["FirewingPoint"] = 160635027841,
		["GrangolvarVilliage"] = 183760060928,
		["RaastokGlade"] = 165886034176,
		["RazorthornShelf"] = 20902576384,
		["RefugeCaravan"] = 288094421120,
		["RingofObservance"] = 370766250240,
		["SethekkTomb"] = 310568550656,
		["ShattrathCity"] = 4404544000,
		["SkethylMountains"] = 374133293568,
		["SmolderingCaravan"] = 494258045184,
		["StonebreakerHold"] = 177583948032,
		["TheBarrierHills"] = 4416864512,
		["Tuurem"] = 36984848640,
		["VeilRhaze"] = 388927586560,
		["WrithingMound"] = 351551095040,
	},
	["TheCapeOfStranglethorn"] = {
		["BootyBay"] = 366449261793,
		["CrystalveinMine"] = 78937010447,
		["GurubashiArena"] = 362025198,
		["HardwrenchHideaway"] = 124772382052,
		["JagueroIsle"] = 434285846768,
		["MistvaleValley"] = 266716039421,
		["NekmaniWellspring"] = 229013419254,
		["RuinsofAboraz"] = 194906341560,
		["RuinsofJubuwal"] = 128266237083,
		["TheSundering"] = 474170612,
		["WildShore"] = 421263593708,
	},
	["TheHiddenPass"] = {
		["TheBlackMarket"] = 188294346207,
		["TheHiddenCliffs"] = 454258982,
		["TheHiddenSteps"] = 512607059234,
	},
	["TheJadeForest"] = {
		["ChunTianMonastery"] = 60444317923,
		["DawnsBlossom"] = 191467047146,
		["DreamersPavillion"] = 558842925274,
		["EmperorsOmen"] = 22999675082,
		["GlassfinVillage"] = 384950393110,
		["GrookinMound"] = 229971825917,
		["HellscreamsHope"] = 80720599236,
		["JadeMines"] = 157185882348,
		["NectarbreezeOrchard"] = 354639151323,
		["NookaNooka"] = 162333406427,
		["RuinsOfGanShi"] = 331512004,
		["SerpentsSpine"] = 321455874239,
		["SlingtailPits"] = 447125573811,
		["TempleOfTheJadeSerpent"] = 317244787976,
		["TheArboretum"] = 231359072498,
		["Waywardlanding"] = 517906557147,
		["WindlessIsle"] = 46736437499,
		["WreckOfTheSkyShark"] = 211974354,
	},
	["TheLostIsles"] = {
		["Alliancebeachhead"] = 373797597361,
		["BilgewaterLumberyard"] = 46655554808,
		["GallywixDocks"] = 22916812973,
		["HordeBaseCamp"] = 492029802718,
		["KTCOilPlatform"] = 12265339036,
		["Lostpeak"] = 23158330718,
		["OoomlotVillage"] = 370973822173,
		["Oostan"] = 173388597458,
		["RaptorRise"] = 395573408936,
		["RuinsOfVashelan"] = 485792899284,
		["ScorchedGully"] = 198981222705,
		["ShipwreckShore"] = 438285024428,
		["SkyFalls"] = 141096577214,
		["TheSavageGlen"] = 349189660903,
		["TheSlavePits"] = 73307194580,
		["WarchiefsLookout"] = 154895882399,
		["landingSite"] = 385868764302,
	},
	["TheStormPeaks"] = {
		["BorsBreath"] = 402767678786,
		["BrunnhildarVillage"] = 397640247601,
		["DunNiffelem"] = 306521177397,
		["EngineoftheMakers"] = 318159113426,
		["Frosthold"] = 460775977204,
		["GarmsBane"] = 505073040568,
		["NarvirsCradle"] = 154843462836,
		["Nidavelir"] = 221304266973,
		["SnowdriftPlains"] = 153715187917,
		["SparksocketMinefield"] = 502765134075,
		["TempleofLife"] = 121930791094,
		["TempleofStorms"] = 323447066793,
		["TerraceoftheMakers"] = 131303036267,
		["Thunderfall"] = 192857739570,
		["Ulduar"] = 228861297,
		["Valkyrion"] = 341552822500,
	},
	["TheWanderingIsle"] = {
		["Fe-FangVillage"] = 9804478698,
		["MandoriVillage"] = 316091521634,
		["MorningBreezeVillage"] = 38867889413,
		["Pei-WuForest"] = 436307499659,
		["PoolofthePaw"] = 348203970780,
		["RidgeofLaughingWinds"] = 212793099577,
		["SkyfireCrash-Site"] = 434995731802,
		["TempleofFiveDawns"] = 195835672159,
		["TheDawningValley"] = 341471909,
		["TheRows"] = 317282702721,
		["TheSingingPools"] = 13456862580,
		["TheWoodofStaves"] = 216909958109,
	},
	["ThousandNeedles"] = {
		["DarkcloudPinnacle"] = 124731519293,
		["FreewindPost"] = 200005664180,
		["Highperch"] = 143881793782,
		["RazorfenDowns"] = 312797545,
		["RustmaulDiveSite"] = 499842755818,
		["SouthseaHoldfast"] = 443174617334,
		["SplithoofHeights"] = 53212506543,
		["TheGreatLift"] = 142844176,
		["TheShimmeringDeep"] = 276571778459,
		["TheTwilightWithering"] = 353625263478,
		["TwilightBulwark"] = 258903279974,
		["WestreachSummit"] = 333080,
	},
	["Tirisfal"] = {
		["AgamandMills"] = 96976769309,
		["BalnirFarmstead"] = 348515388658,
		["BrightwaterLake"] = 131597635794,
		["Brill"] = 271086442695,
		["CalstonEstate"] = 274212234419,
		["ColdHearthManor"] = 340814644436,
		["CrusaderOutpost"] = 249827641519,
		["Deathknell"] = 222274411951,
		["GarrensHaunt"] = 139013085374,
		["NightmareVale"] = 349330236641,
		["RuinsofLorderon"] = 385917136262,
		["ScarletMonastery"] = 51242080518,
		["ScarletWatchPost"] = 107026294945,
		["SollidenFarmstead"] = 206369424670,
		["TheBulwark"] = 355078588709,
		["VenomwebVale"] = 161850088698,
	},
	["TolBarad"] = {
	},
	["TolBaradDailyArea"] = {
	},
	["TownlongWastes"] = {
		["GaoRanBlockade"] = 503083901281,
		["KriVess"] = 224852718847,
		["MingChiCrossroads"] = 480400078071,
		["NiuzaoTemple"] = 258995494184,
		["OsulMesa"] = 199229743342,
		["ShadoPanGarrison"] = 413823838421,
		["ShanzeDao"] = 131324204,
		["Sikvess"] = 465251314949,
		["SriVess"] = 206255189286,
		["TheSumprushes"] = 396782417167,
		["palewindVillage"] = 389420468506,
	},
	["TwilightHighlands"] = {
		["Bloodgulch"] = 220553442519,
		["CrucibleOfCarnage"] = 288168820939,
		["Crushblow"] = 480350768310,
		["DragonmawPass"] = 128928921883,
		["DragonmawPort"] = 263728610555,
		["DunwaldRuins"] = 394477660357,
		["FirebeardsPatrol"] = 285065008343,
		["GlopgutsHollow"] = 95868352686,
		["GorshakWarCamp"] = 236792752322,
		["GrimBatol"] = 239531741414,
		["Highbank"] = 433449045212,
		["HighlandForest"] = 354840453359,
		["HumboldtConflaguration"] = 95923877007,
		["Kirthaven"] = 505687348,
		["ObsidianForest"] = 408479367510,
		["RuinsOfDrakgor"] = 310565070,
		["SlitheringCove"] = 182114788550,
		["TheBlackBreach"] = 130445166803,
		["TheGullet"] = 192482037935,
		["TheKrazzworks"] = 686006498,
		["TheTwilightBreach"] = 206485803207,
		["TheTwilightCitadel"] = 337313630569,
		["TheTwilightGate"] = 382595177637,
		["Thundermar"] = 100250391790,
		["TwilightShore"] = 371080767748,
		["VermillionRedoubt"] = 17254588740,
		["VictoryPoint"] = 328881831089,
		["WeepingWound"] = 375584982,
		["WyrmsBend"] = 249323264191,
	},
	["Uldum"] = {
		["AkhenetFields"] = 297920554148,
		["CradelOfTheAncient"] = 432001950922,
		["HallsOfOrigination"] = 198196840717,
		["KhartutsTomb"] = 568548555,
		["LostCityOfTheTolVir"] = 313011799273,
		["Marat"] = 187256997024,
		["Nahom"] = 174557694189,
		["Neferset"] = 412743891153,
		["ObeliskOfTheMoon"] = 115573136,
		["ObeliskOfTheStars"] = 130500700356,
		["ObeliskOfTheSun"] = 303151918349,
		["Orsis"] = 146305961209,
		["Ramkahen"] = 72371899620,
		["RuinsOfAhmtul"] = 382907670,
		["RuinsOfAmmon"] = 310539183307,
		["Schnottzslanding"] = 237326599480,
		["TahretGrounds"] = 207803808918,
		["TempleofUldum"] = 136503837992,
		["TheCursedlanding"] = 183324963053,
		["TheGateofUnendingCycles"] = 16784797857,
		["TheTrailOfDevestation"] = 375425020110,
		["TheVortexPinnacle"] = 508567948501,
		["ThroneOfTheFourWinds"] = 465170568462,
		["VirnaalDam"] = 231356907671,
	},
	["UngoroCrater"] = {
		["FirePlumeRidge"] = 206532018497,
		["FungalRock"] = 584252640,
		["GolakkaHotSprings"] = 242817979701,
		["IronstonePlateau"] = 216562628805,
		["LakkariTarPits"] = 320117168,
		["MarshalsStand"] = 354819418316,
		["MossyPile"] = 192543909050,
		["TerrorRun"] = 383496000828,
		["TheMarshlands"] = 275479163143,
		["TheRollingGarden"] = 42468705617,
		["TheScreamingReaches"] = 164966732,
		["TheSlitheringScar"] = 412668414333,
	},
	["ValeofEternalBlossoms"] = {
		["GuoLaiRuins"] = 3312809297,
		["MistfallVillage"] = 389978309942,
		["MoguShanPalace"] = 24282269045,
		["SettingSunTraining"] = 251256026462,
		["TheGoldenStair"] = 17524062450,
		["TheStairsAscent"] = 287272443326,
		["TheTwinMonoliths"] = 104619059472,
		["TuShenBurialGround"] = 339668685067,
		["WhiteMoonShrine"] = 11243100458,
		["WhitepetalLake"] = 182827902219,
		["WinterboughGlade"] = 114894910825,
	},
	["ValleyoftheFourWinds"] = {
		["CliffsofDispair"] = 434017411582,
		["DustbackGorge"] = 368293761233,
		["GildedFan"] = 44482990288,
		["GrandGranery"] = 349316534586,
		["Halfhill"] = 190511830222,
		["HarvestHome"] = 256629796100,
		["KuzenVillage"] = 79692087495,
		["MudmugsPlace"] = 173460907238,
		["NesingwarySafari"] = 350149236985,
		["PaoquanHollow"] = 112755726609,
		["PoolsofPurity"] = 62815197397,
		["RumblingTerrace"] = 323806811413,
		["SilkenFields"] = 272212692222,
		["SingingMarshes"] = 139764993199,
		["StormsoutBrewery"] = 408260215041,
		["Theheartland"] = 80796328222,
		["ThunderfootFields"] = 652539260,
		["ZhusDecent"] = 123139853615,
	},
	["VashjirDepths"] = {
		["AbandonedReef"] = 282446932339,
		["AbyssalBreach"] = 521624043,
		["ColdlightChasm"] = 300927015179,
		["DeepfinRidge"] = 34648365419,
		["FireplumeTrench"] = 118442159402,
		["KorthunsEnd"] = 304301344114,
		["LGhorek"] = 225655952690,
		["Seabrush"] = 196930169057,
	},
	["VashjirKelpForest"] = {
		["DarkwhisperGorge"] = 245366977756,
		["GnawsBoneyard"] = 349439223095,
		["GubogglesLedge"] = 301066304739,
		["HoldingPens"] = 431048895804,
		["HonorsTomb"] = 46569568547,
		["LegionsFate"] = 37801487638,
		["TheAccursedReef"] = 174329136468,
	},
	["VashjirRuins"] = {
		["BethMoraRidge"] = 478242110799,
		["GlimmeringdeepGorge"] = 238653985040,
		["Nespirah"] = 280729236766,
		["RuinsOfTherseral"] = 188485958853,
		["RuinsOfVashjir"] = 287990719837,
		["ShimmeringGrotto"] = 419715411,
		["SilverTideHollow"] = 34517351904,
	},
	["WesternPlaguelands"] = {
		["Andorhal"] = 368394442192,
		["CaerDarrow"] = 419389718722,
		["DalsonsFarm"] = 249422872901,
		["DarrowmereLake"] = 380639701484,
		["FelstoneField"] = 245053477105,
		["GahrronsWithering"] = 229226311921,
		["Hearthglen"] = 246693296,
		["NorthridgeLumberCamp"] = 132312652135,
		["RedpineDell"] = 226859554082,
		["SorrowHill"] = 481310241136,
		["TheBulwark"] = 252379984188,
		["TheWeepingCave"] = 162713016505,
		["TheWrithingHaunt"] = 356977413289,
		["ThondrorilRiver"] = 559337783,
	},
	["Westfall"] = {
		["AlexstonFarmstead"] = 282569439578,
		["DemontsPlace"] = 403939986633,
		["FurlbrowsPumpkinFarm"] = 413357253,
		["GoldCoastQuarry"] = 85034584299,
		["JangoloadMine"] = 326341828,
		["Moonbrook"] = 349289272552,
		["SaldeansFarm"] = 87446238452,
		["SentinelHill"] = 243089548517,
		["TheDaggerHills"] = 424446018852,
		["TheDeadAcre"] = 215305438401,
		["TheDustPlains"] = 406377993533,
		["TheGapingChasm"] = 180697130168,
		["TheJansenStead"] = 497208522,
		["TheMolsenFarm"] = 127066669258,
		["WestfallLighthouse"] = 512406756563,
	},
	["Wetlands"] = {
		["AngerfangEncampment"] = 216198807788,
		["BlackChannelMarsh"] = 257737072941,
		["BluegillMarsh"] = 109554426177,
		["DireforgeHills"] = 37038035273,
		["DunAlgaz"] = 450260852010,
		["DunModr"] = 7889675521,
		["GreenwardensGrove"] = 110004286714,
		["IronbeardsTomb"] = 81994678457,
		["MenethilHarbor"] = 318901693765,
		["MosshideFen"] = 249638923633,
		["RaptorRidge"] = 132698592512,
		["Satlspray"] = 228878586,
		["SlabchiselsSurvey"] = 378515288364,
		["SundownMarsh"] = 67772861716,
		["ThelganRock"] = 360092744962,
		["WhelgarsExcavationSite"] = 209574100266,
	},
	["Winterspring"] = {
		["Everlook"] = 209885304002,
		["FrostfireHotSprings"] = 126799349112,
		["FrostsaberRock"] = 319041868,
		["FrostwhisperGorge"] = 509398408509,
		["IceThistleHills"] = 337764377849,
		["LakeKeltheril"] = 288153143567,
		["Mazthoril"] = 365490845953,
		["OwlWingThicket"] = 471955822846,
		["StarfallVillage"] = 35673952623,
		["TheHiddenGrove"] = 18778160461,
		["TimbermawPost"] = 324366758250,
		["WinterfallVillage"] = 194964047069,
	},
	["Zangarmarsh"] = {
		["AngoroshGrounds"] = 53779628288,
		["AngoroshStronghold"] = 130154752,
		["BloodscaleEnclave"] = 443006845184,
		["CenarionRefuge"] = 345399099700,
		["CoilfangReservoir"] = 97121730816,
		["FeralfenVillage"] = 356811883008,
		["MarshlightLake"] = 163293954304,
		["OreborHarborage"] = 27189051648,
		["QuaggRidge"] = 349114293504,
		["Sporeggar"] = 216917082624,
		["Telredor"] = 120856248576,
		["TheDeadMire"] = 138190258462,
		["TheHewnBog"] = 54990995712,
		["TheLagoon"] = 325880905984,
		["TheSpawningGlen"] = 364031246592,
		["TwinspireRuins"] = 267720589568,
		["UmbrafenVillage"] = 495750167808,
		["ZabraJin"] = 249291866368,
	},
	["ZulDrak"] = {
		["AltarOfHarKoa"] = 371000083721,
		["AltarOfMamToth"] = 95092536631,
		["AltarOfQuetzLun"] = 270145978629,
		["AltarOfRhunok"] = 136817459447,
		["AltarOfSseratus"] = 180690870509,
		["AmphitheaterOfAnguish"] = 308467202314,
		["DrakSotraFields"] = 384741680414,
		["GunDrak"] = 659858768,
		["Kolramas"] = 469623872814,
		["LightsBreach"] = 389958387009,
		["ThrymsEnd"] = 265214505232,
		["Voltarus"] = 205267438810,
		["Zeramas"] = 442389233971,
		["ZimTorga"] = 259274311929,
	},
	["IsleoftheThunderKing"] = false,
	["IsleoftheThunderKingScenario"] = false,
	['*'] = {},
}

function RDX.OV()
	if not RDXG.OV then RDXG.OV = {}; end
	for k,v in pairs(errata) do
		RDXG.OV[strlower(k)] = {};
		for l,w in pairs(v) do
			local textureWidth, textureHeight, offsetX, offsetY = mod(w, 2^10), mod(floor(w / 2^10), 2^10), mod(floor(w / 2^20), 2^10), floor(w / 2^30)
			RDXG.OV[strlower(k)][strlower(l)] = format ("%d,%d,%d,%d", offsetX, offsetY, textureWidth, textureHeight)
		end
	end



end
-- /script RDX.OV()


