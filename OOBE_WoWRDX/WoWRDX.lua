RDX.RegisterOOBEObject({
context = "GLOBAL";
name = "WoWRDX";
title = "WoWRDX";
PreInstallScript = function()
    RDX.RegisterOOBEOption({
        name = "WoWRDX";
        text = "Install WoWRDX";
        sel = true;
    });
end;
InstallCondition = function()
    return RDX.GetOOBEOptionState("WoWRDX");
end;
data = {
-- Begin RDX Data Export
-- Begin Export Data for win_DispelGrid
	["WoWRDX"] = {
		["Shaman_Totems5"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems5_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Rez_Monitor_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["n"] = 1,
						["class"] = "rez",
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["n"] = 2,
						["class"] = "rez",
					}, -- [2]
				}, -- [3]
			},
		},
		["Info_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["value"] = "11",
					["name"] = "height",
					["feature"] = "Variable: Static Value",
				}, -- [1]
				{
					["feature"] = "base_default",
					["h"] = 44,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 120,
				}, -- [2]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["ty"] = "AUI",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "height",
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["name"] = "otxt1",
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["ty"] = "AUIState",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt1",
					},
					["h"] = "height",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["name"] = "otxt2",
				}, -- [4]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["ty"] = "Usage",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt2",
					},
					["h"] = "height",
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["name"] = "otxt3",
				}, -- [5]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["ty"] = "Memory Debit",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt3",
					},
					["h"] = "height",
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["name"] = "otxt4",
				}, -- [6]
			},
		},
		["Priest_Buff_InnerFire_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 588,
				},
			},
		},
		["Bags"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Bags_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Boss_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 76,
					["version"] = 1,
					["w"] = 206,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -30,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_plife",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_plife",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["edgeSize"] = 8,
						["kr"] = 0,
						["_border"] = "straight",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_backdrop"] = "solid",
						["kg"] = 0,
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [5]
				{
					["feature"] = "var_pred_health",
				}, -- [6]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 0.903999999165535,
						["r"] = 0.04313725490196078,
						["g"] = 1,
						["b"] = 0,
					},
				}, -- [7]
				{
					["frac"] = "pfh",
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_plife",
					["w"] = "200",
					["colorVar"] = "green",
					["sublevel"] = 1,
					["h"] = "21",
					["name"] = "sb_plife",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
					["orientation"] = "HORIZONTAL",
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [8]
				{
					["feature"] = "commentline",
				}, -- [9]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_life",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [10]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [11]
				{
					["neutralColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyDruidColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.49,
						["b"] = 0.04,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["r"] = 0.77,
						["g"] = 0.12,
						["b"] = 0.23,
					},
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["r"] = 0.58,
						["g"] = 0.51,
						["b"] = 0.79,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["friendlyMageColor"] = {
						["a"] = 1,
						["r"] = 0.41,
						["g"] = 0.8,
						["b"] = 0.94,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyPaladinColor"] = {
						["a"] = 1,
						["r"] = 0.96,
						["g"] = 0.55,
						["b"] = 0.73,
					},
					["name"] = "hostilityclassColor",
					["hostileColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.15,
						["b"] = 0,
					},
					["friendlyRogueColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.96,
						["b"] = 0.41,
					},
					["friendlyShamanColor"] = {
						["a"] = 1,
						["r"] = 0.14,
						["g"] = 0.34,
						["b"] = 1,
					},
					["friendlyHunterColor"] = {
						["a"] = 1,
						["r"] = 0.67,
						["g"] = 0.83,
						["b"] = 0.45,
					},
					["friendlyWarriorColor"] = {
						["a"] = 1,
						["r"] = 0.78,
						["g"] = 0.61,
						["b"] = 0.43,
					},
				}, -- [12]
				{
					["interpolate"] = 1,
					["frac"] = "fh",
					["sublevel"] = 2,
					["owner"] = "sf_life",
					["w"] = "200",
					["h"] = "21",
					["drawLayer"] = "ARTWORK",
					["colorVar"] = "hostilityclassColor",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_life",
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [13]
				{
					["txt"] = "pheal",
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_pheal",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 12,
					},
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["ty"] = "hptxt2",
					["name"] = "text_vie",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["name"] = "Default",
						["title"] = "Default",
						["sy"] = -1,
						["size"] = 10,
					},
					["version"] = 1,
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_dead",
					["ty"] = "fdld",
					["h"] = "14",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_mob",
					["ty"] = "mobtype",
					["h"] = "14",
				}, -- [17]
				{
					["feature"] = "commentline",
				}, -- [18]
				{
					["feature"] = "Subframe",
					["h"] = "16",
					["name"] = "sf_mana",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -23,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [19]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["kg"] = 0,
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["edgeSize"] = 8,
						["kr"] = 0,
						["ka"] = 0.7119999825954437,
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_backdrop"] = "solid",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [20]
				{
					["energyColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.5450980392156862,
						["b"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.5,
						["r"] = 1,
					},
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 1,
					},
					["rageColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [21]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [22]
				{
					["frac"] = "fm",
					["flOffset"] = 2,
					["owner"] = "sf_mana",
					["w"] = "200",
					["h"] = "10",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "powerColor",
					["version"] = 1,
					["interpolate"] = 1,
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
					["name"] = "sb_power",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [23]
				{
					["owner"] = "sf_mana",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "mptxt",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["name"] = "text_mana",
					["h"] = "14",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = "39",
					["name"] = "sf_sup",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 3,
				}, -- [26]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_sup",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 20,
						["ba"] = 0,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bg"] = 1,
						["bb"] = 1,
						["br"] = 1,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [27]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "aggro",
					["set"] = {
						["class"] = "ags",
					},
				}, -- [28]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "red",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [29]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "nocolor",
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [30]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "aggrocolour",
					["colorVar1"] = "red",
					["condVar"] = "aggro_flag",
					["colorVar2"] = "nocolor",
				}, -- [31]
				{
					["feature"] = "Backdrop Border Colorizer",
					["owner"] = "sf_sup",
					["color"] = "aggrocolour",
					["flag"] = "true",
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "30",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -3,
						["dy"] = -3,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "30",
					["drawLayer"] = "ARTWORK",
				}, -- [34]
				{
					["owner"] = "pdt",
					["w"] = "30",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 15,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["name"] = "status_text",
					["ty"] = "level",
					["h"] = "30",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 15,
					},
					["version"] = 1,
					["classColor"] = 1,
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["name"] = "np",
					["h"] = "30",
				}, -- [36]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_icons",
					["iconspx"] = 2,
					["cd"] = {
						["Offsety"] = 0,
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 7,
						},
						["TimerType"] = "COOLDOWN",
						["offsety"] = "0",
						["Offsetx"] = 0,
						["offsetx"] = "10",
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["anchor"] = {
						["dx"] = 4,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["maxdurationfilter"] = "",
					["mindurationfilter"] = "",
					["auraType"] = "DEBUFFS",
					["owner"] = "pdt",
					["playerauras"] = 1,
					["usebs"] = true,
					["size"] = 12,
					["name"] = "debuff",
					["version"] = 1,
					["nIcons"] = 10,
					["orientation"] = "RIGHT",
					["ButtonSkinOffset"] = 0,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["unitfilter"] = "",
				}, -- [37]
				{
					["mover"] = 1,
					["w"] = 206,
					["feature"] = "hotspot",
					["flo"] = 3,
					["name"] = "",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["h"] = 76,
					["secure"] = 1,
				}, -- [38]
			},
		},
		["Cooldowns_Avail_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 30,
					["version"] = 1,
					["w"] = 300,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "cd_icons",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\Blokletters-Viltstift.ttf",
							["justifyV"] = "CENTER",
							["cr"] = 1,
							["flags"] = "OUTLINE",
							["cg"] = 0.04313725490196078,
							["title"] = "Default",
							["cb"] = 0,
							["ca"] = 1,
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["size"] = 10,
						},
						["Offsety"] = -20,
						["TimerType"] = "TEXT",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 5,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["cooldownType"] = "AVAIL",
					["iconspy"] = 0,
					["nIcons"] = 30,
					["mindurationfilter"] = "",
					["owner"] = "decor",
					["maxdurationfilter"] = "",
					["bkd"] = {
						["ka"] = 1,
						["edgeSize"] = 12,
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["kg"] = 0.1,
						["_border"] = "IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["name"] = "ai1",
					["usebkd"] = 1,
					["orientation"] = "RIGHT",
					["externalButtonSkin"] = "bs_simplesquare",
					["version"] = 1,
					["size"] = 30,
				}, -- [2]
			},
		},
		["Deathknight_Runes7_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 216,
				}, -- [1]
				{
					["sizew"] = 36,
					["rows"] = 1,
					["bloodColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0,
						["r"] = 1,
					},
					["feature"] = "runes_bar_vars",
					["iconspx"] = 0,
					["runetexture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["ButtonSkinOffset"] = 4,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_caith",
					["iconspy"] = 0,
					["unholyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["owner"] = "decor",
					["name"] = "rune_bar_skin",
					["deathColor"] = {
						["a"] = 1,
						["b"] = 0.6000000000000001,
						["g"] = 0.3,
						["r"] = 0.6000000000000001,
					},
					["version"] = 1,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["orientation"] = "RIGHT",
					["frostColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6000000000000001,
						["r"] = 0,
					},
					["sizeh"] = 36,
					["nIcons"] = 6,
				}, -- [2]
			},
		},
		["Solo_desk"] = {
			["ty"] = "Desktop",
			["version"] = 2,
			["data"] = {
				{
					["offsetleft"] = "0",
					["b"] = 0,
					["scale"] = 1,
					["dgp"] = true,
					["feature"] = "Desktop main",
					["offsetbottom"] = "0",
					["l"] = 0,
					["offsettop"] = "0",
					["r"] = 1365.333426704711,
					["root"] = true,
					["t"] = 767.9999824928667,
					["alpha"] = 1,
					["anchorx"] = 1134.3997024882,
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 10,
							["point"] = "TOPRIGHT",
							["y"] = 10,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Combat_Logs",
							["x"] = 20,
							["point"] = "BOTTOMRIGHT",
							["y"] = -20,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -20,
						},
					},
					["offsetright"] = "0",
					["name"] = "root",
					["strata"] = "BACKGROUND",
					["open"] = true,
					["title"] = "Konyagi_AUI:desk_solo",
					["anchory"] = 204.26689378525,
					["ap"] = "TOPLEFT",
				}, -- [1]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 20,
						},
					},
					["scale"] = 1,
					["t"] = 47.78666548950701,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 17.06666731335399,
					["alpha"] = 1,
				}, -- [2]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "root",
							["x"] = -10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar4",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["r"] = 1356.80010743447,
					["anchor"] = "TOPLEFT",
					["l"] = 1326.079997212661,
					["b"] = 199.680014288981,
					["alpha"] = 1,
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["r"] = 1326.079997212661,
					["anchor"] = "TOPLEFT",
					["l"] = 1295.360006506218,
					["b"] = 199.680014288981,
					["alpha"] = 1,
				}, -- [4]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 78.50667113537041,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 47.78666548950701,
					["alpha"] = 1,
				}, -- [5]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
						["TOP"] = {
							["id"] = "WoWRDX:Cooldowns_Used",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -115,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 109.2266693115234,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 78.50667113537041,
					["alpha"] = 1,
				}, -- [6]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 139.9466674876765,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["r"] = 805.54665535993,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 109.2266693115234,
					["alpha"] = 1,
				}, -- [7]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBarVehicle",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["r"] = 805.54665535993,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 139.9466674876765,
					["alpha"] = 1,
				}, -- [8]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["r"] = 897.7066274792579,
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 139.9466674876765,
					["alpha"] = 1,
				}, -- [9]
				{
					["strata"] = "MEDIUM",
					["b"] = 716.7999823426051,
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Player_Debuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = -10,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 884.0533713135628,
					["r"] = 1225.386747459484,
					["alpha"] = 1,
				}, -- [10]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 10,
						},
					},
					["scale"] = 1,
					["t"] = 419.9599062542051,
					["open"] = true,
					["feature"] = "desktop_window",
					["dgp"] = true,
					["name"] = "WoWRDX:Player_Main",
					["r"] = 489.6932979609048,
					["anchor"] = "TOPLEFT",
					["l"] = 313.9066313560981,
					["b"] = 355.1065659816338,
					["alpha"] = 1,
				}, -- [11]
				{
					["strata"] = "MEDIUM",
					["r"] = 770.560085594246,
					["scale"] = 1,
					["t"] = 255.1466923945194,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:Cooldowns_Used",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 594.7734189894393,
					["b"] = 232.9600092007674,
					["alpha"] = 1,
				}, -- [12]
				{
					["strata"] = "MEDIUM",
					["r"] = 489.6932979609048,
					["scale"] = 1,
					["t"] = 346.5732584689431,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -10,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 313.9066313560981,
					["b"] = 281.7199181963717,
					["alpha"] = 1,
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["b"] = 609.2800148700559,
					["scale"] = 1,
					["t"] = 636.5866467168124,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMapButtons",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1227.093426889327,
					["r"] = 1363.62658612311,
					["alpha"] = 1,
				}, -- [14]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Targettarget_Main",
							["x"] = -10,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 424.4664721688475,
					["open"] = true,
					["feature"] = "desktop_window",
					["dgp"] = true,
					["name"] = "WoWRDX:Target_Main",
					["r"] = 1012.547209922148,
					["anchor"] = "TOPLEFT",
					["l"] = 836.7606030750241,
					["b"] = 359.6131617751177,
					["alpha"] = 1,
				}, -- [15]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 424.4664721688475,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["r"] = 1196.86727367617,
					["anchor"] = "TOPLEFT",
					["l"] = 1021.080607071363,
					["b"] = 359.6131617751177,
					["alpha"] = 1,
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["b"] = 678.3999939595518,
					["scale"] = 1,
					["t"] = 716.7999823426051,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Debuff_Icon",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 969.3866854712014,
					["open"] = true,
					["r"] = 1225.386747459484,
				}, -- [17]
				{
					["strata"] = "MEDIUM",
					["r"] = 1348.266710285255,
					["scale"] = 1,
					["t"] = 145.0666609589433,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Combat_Logs",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "BOTTOMRIGHT",
							["y"] = 20,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1015.466611773182,
					["b"] = 17.06666731335399,
					["alpha"] = 1,
				}, -- [18]
				{
					["strata"] = "MEDIUM",
					["r"] = 359.9866771734452,
					["scale"] = 1,
					["t"] = 109.3463863599395,
					["dgp"] = true,
					["feature"] = "desktop_window",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
					},
					["name"] = "WoWRDX:ChatFrame1",
					["b"] = 24.01304792574194,
					["anchor"] = "TOPLEFT",
					["l"] = 18.65334397835861,
					["open"] = true,
					["alpha"] = 1,
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["r"] = 359.9866771734452,
					["scale"] = 1,
					["t"] = 134.9463835951153,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 18.65333837607582,
					["b"] = 109.3463863599395,
					["alpha"] = 1,
				}, -- [20]
				{
					["strata"] = "MEDIUM",
					["r"] = 1246.719642755691,
					["scale"] = 1,
					["t"] = 306.3465374706632,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MouseOver_Main",
					["anchor"] = "TOPLEFT",
					["l"] = 1118.719641640391,
					["b"] = 202.2398392212755,
					["open"] = true,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["r"] = 1356.80010743447,
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMap",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "root",
							["x"] = -10,
							["point"] = "TOPRIGHT",
							["y"] = -10,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 10,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:MiniMapButtons",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1233.920025093333,
					["b"] = 636.5866467168124,
					["alpha"] = 1,
				}, -- [22]
				{
					["strata"] = "MEDIUM",
					["r"] = 810.6667534071423,
					["scale"] = 1,
					["t"] = 232.9600092007674,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Cooldowns_Used",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 115,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 554.6666914188597,
					["b"] = 207.3599970261709,
					["alpha"] = 1,
				}, -- [23]
				{
					["strata"] = "MEDIUM",
					["r"] = 451.4130340959779,
					["scale"] = 1,
					["t"] = 244.9064963000948,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ClassBar",
					["anchor"] = "TOPLEFT",
					["l"] = 345.5996564167471,
					["open"] = true,
					["b"] = 231.2531803767166,
				}, -- [24]
			},
		},
		["Range_0_10_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "frs",
						["n"] = 2,
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Panel_Center_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 200,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 400,
				}, -- [1]
			},
		},
		["Debuff_None_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Debuff_Primary_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Debuff_Secondary_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
			},
		},
		["Boss_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"boss", -- [1]
			},
		},
		["Player_SecureBuff_Icon_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 50,
					["version"] = 1,
					["w"] = 400,
					["alpha"] = 1,
				}, -- [1]
				{
					["separateown"] = "NONE",
					["point"] = "TOPRIGHT",
					["wrapafter"] = 20,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 8,
					},
					["feature"] = "sec_aura_icons",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
							["ca"] = 1,
							["cg"] = 0.807843137254902,
							["justifyH"] = "CENTER",
							["cb"] = 0.02745098039215686,
							["title"] = "Default",
							["name"] = "Default",
							["flags"] = "THICKOUTLINE",
							["cr"] = 1,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -25,
						["Offsetx"] = 3,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 6,
					["showweapons"] = 1,
					["externalButtonSkin"] = "bs_simplesquare",
					["usebs"] = true,
					["template"] = "RDXAB40x40Template",
					["auraType"] = "BUFFS",
					["owner"] = "Base",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["name"] = "sai1",
					["orientation"] = "LEFT",
					["xoffset"] = 0,
					["maxwraps"] = 2,
					["sortmethod"] = "INDEX",
					["yoffset"] = 0,
				}, -- [2]
			},
		},
		["Minimap_Main2"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Minimap_Main2_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Logs_All_tl"] = {
			["ty"] = "TableLog",
			["version"] = 1,
			["data"] = {
				["size"] = 10000,
			},
		},
		["Raid_Group7"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 7",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group7",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["cols"] = 40,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["ClassBar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ClassBar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Totems7_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 50,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 144,
				}, -- [1]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["version"] = 1,
					["gt"] = "",
					["name"] = "texcd_earth",
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemearth_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 7,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_kitty",
					["timerVar"] = "totemearth",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [4]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["h"] = "36",
					["name"] = "earth",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [5]
				{
					["version"] = 1,
					["gt"] = "",
					["name"] = "texcd_Fire",
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemfire_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 7,
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_kitty",
					["timerVar"] = "totemfire",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["h"] = "36",
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "fire",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [7]
				{
					["version"] = 1,
					["gt"] = "",
					["name"] = "texcd_water",
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemwater_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 7,
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_kitty",
					["timerVar"] = "totemwater",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "water",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["flo"] = 3,
					["version"] = 1,
				}, -- [9]
				{
					["version"] = 1,
					["gt"] = "",
					["name"] = "texcd_air",
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemair_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 7,
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_kitty",
					["timerVar"] = "totemair",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [10]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "air",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["flo"] = 3,
					["version"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = 144,
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "remove",
					["flo"] = 3,
					["h"] = 14,
				}, -- [13]
			},
		},
		["Arena_desk"] = {
			["ty"] = "Desktop",
			["version"] = 2,
			["data"] = {
				{
					["offsetleft"] = "0",
					["b"] = 0,
					["scale"] = 1,
					["dgp"] = true,
					["feature"] = "Desktop main",
					["offsetbottom"] = "0",
					["l"] = 0,
					["offsettop"] = "0",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar4",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_SecureDebuff_Icon",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
					},
					["root"] = true,
					["t"] = 767.9999824928667,
					["open"] = true,
					["r"] = 1365.333426704711,
					["name"] = "root",
					["offsetright"] = "0",
					["title"] = "Konyagi_AUI:desk_solo",
					["alpha"] = 1,
					["anchorx"] = 1182.1866833495,
					["strata"] = "LOW",
					["anchory"] = 112.64005532254,
					["ap"] = "TOPLEFT",
				}, -- [1]
				{
					["strata"] = "MEDIUM",
					["r"] = 601.359851064995,
					["scale"] = 1,
					["t"] = 380.8263325531983,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 425.5732143390299,
					["b"] = 315.972992280627,
					["alpha"] = 1,
				}, -- [2]
				{
					["strata"] = "MEDIUM",
					["r"] = 1365.333385068319,
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 725.3333197341373,
					["alpha"] = 1,
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["r"] = 341.3333462670797,
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 0,
					["b"] = 721.0666211595296,
					["alpha"] = 1,
				}, -- [4]
				{
					["strata"] = "MEDIUM",
					["r"] = 866.9866965304984,
					["scale"] = 1,
					["t"] = 30.72000191100822,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:MiniMapButtons",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 0,
					["alpha"] = 1,
				}, -- [5]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar4",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["r"] = 1334.613394361876,
					["anchor"] = "TOPLEFT",
					["l"] = 1303.893284140067,
					["alpha"] = 1,
					["b"] = 199.680014288981,
				}, -- [6]
				{
					["strata"] = "MEDIUM",
					["r"] = 1365.333385068319,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1334.613394361876,
					["b"] = 199.680014288981,
					["alpha"] = 1,
				}, -- [7]
				{
					["strata"] = "MEDIUM",
					["r"] = 682.6666925341594,
					["scale"] = 1,
					["t"] = 61.44000382201643,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["TOP"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 314.0266845414816,
					["b"] = 30.72000191100822,
					["alpha"] = 1,
				}, -- [8]
				{
					["strata"] = "MEDIUM",
					["r"] = 1051.306640769154,
					["scale"] = 1,
					["t"] = 61.44000382201643,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 682.6666925341594,
					["b"] = 30.72000191100822,
					["alpha"] = 1,
				}, -- [9]
				{
					["strata"] = "MEDIUM",
					["r"] = 651.9467018277169,
					["scale"] = 1,
					["t"] = 92.16000199816945,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 344.7467051267659,
					["b"] = 61.44000382201643,
					["alpha"] = 1,
				}, -- [10]
				{
					["strata"] = "MEDIUM",
					["r"] = 959.1466686498262,
					["scale"] = 1,
					["t"] = 92.16000199816945,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBarVehicle",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 651.9467018277169,
					["b"] = 61.44000382201643,
					["alpha"] = 1,
				}, -- [11]
				{
					["strata"] = "MEDIUM",
					["r"] = 1051.306640769154,
					["scale"] = 1,
					["t"] = 92.16000199816945,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 959.1466686498262,
					["b"] = 61.44000382201643,
					["alpha"] = 1,
				}, -- [12]
				{
					["strata"] = "MEDIUM",
					["r"] = 1171.626464934794,
					["scale"] = 1,
					["t"] = 551.25345207454,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Arena_Main",
					["anchor"] = "TOPLEFT",
					["l"] = 995.8398580876703,
					["b"] = 551.1680583453646,
					["open"] = true,
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["r"] = 344.7467051267659,
					["scale"] = 1,
					["t"] = 159.5733464760847,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["dock"] = {
						["CENTER"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 3.413354191117129,
					["b"] = 133.9733343014881,
					["alpha"] = 1,
				}, -- [14]
				{
					["strata"] = "MEDIUM",
					["r"] = 344.7467051267659,
					["scale"] = 1,
					["t"] = 146.7733403887864,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "CENTER",
							["y"] = 0,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 3.413354191117129,
					["b"] = 61.44000382201643,
					["alpha"] = 1,
				}, -- [15]
				{
					["strata"] = "MEDIUM",
					["r"] = 724.2398736484487,
					["scale"] = 1,
					["t"] = 348.3996624169126,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMap",
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
						["TOP"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = -8.000024619406203,
							["point"] = "BOTTOM",
							["y"] = -47.000122755095,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Focus_Main",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 601.359851064995,
					["b"] = 225.5196547728798,
					["alpha"] = 1,
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["r"] = 1003.519975279647,
					["scale"] = 1,
					["t"] = 29.01333555315834,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMapButtons",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 866.9866965304984,
					["b"] = 1.706668341991702,
					["alpha"] = 1,
				}, -- [17]
				{
					["strata"] = "MEDIUM",
					["r"] = 1141.759933458639,
					["scale"] = 1,
					["t"] = 191.1465573820826,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MouseOver_Main",
					["anchor"] = "TOPLEFT",
					["l"] = 965.9732668538323,
					["b"] = 126.2932171095112,
					["open"] = true,
				}, -- [18]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Partytarget",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 540.2453697520522,
					["open"] = true,
					["feature"] = "desktop_window",
					["alpha"] = 1,
					["name"] = "WoWRDX:Party",
					["r"] = 267.9465789664515,
					["anchor"] = "TOPLEFT",
					["l"] = 92.07456345073184,
					["b"] = 475.3066955079885,
					["dgp"] = true,
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 540.2027027663061,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Partytarget",
					["r"] = 443.7331858135751,
					["anchor"] = "TOPLEFT",
					["l"] = 267.9465789664515,
					["b"] = 475.3493624937347,
					["alpha"] = 1,
				}, -- [20]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Focus_Main",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 355.2263203786018,
					["open"] = true,
					["feature"] = "desktop_window",
					["alpha"] = 1,
					["name"] = "WoWRDX:Target_Main",
					["r"] = 900.0265402532555,
					["anchor"] = "TOPLEFT",
					["l"] = 724.2397541330824,
					["b"] = 290.3729801060304,
					["dgp"] = true,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["r"] = 601.359851064995,
					["scale"] = 1,
					["t"] = 290.3729801060304,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 425.5732143390299,
					["b"] = 225.5196547728798,
					["alpha"] = 1,
				}, -- [22]
				{
					["strata"] = "MEDIUM",
					["r"] = 900.0265402532555,
					["scale"] = 1,
					["t"] = 290.3729801060304,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Focus_Main",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 724.2398736484487,
					["b"] = 225.5196547728798,
					["alpha"] = 1,
				}, -- [23]
				{
					["strata"] = "MEDIUM",
					["r"] = 757.5198834996559,
					["scale"] = 1,
					["t"] = 410.6930731812441,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 8.000024619406203,
							["point"] = "TOP",
							["y"] = 47.000122755095,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 581.7332766525323,
					["b"] = 388.5064198663337,
					["alpha"] = 1,
				}, -- [24]
			},
		},
		["Dispel_Grid"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Dispel Grid",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Dispell_Grid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Dispell_Grid_Data_fset",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["cols"] = 5,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [5]
				{
					["feature"] = "Audio Cue: Set Delta",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Dispell_Grid_Audio_fset",
					},
					["sndFill"] = "Interface\\AddOns\\RDX\\Skin\\moleUp.wav",
					["sndUp"] = "",
					["sndDown"] = "",
					["sndEmpty"] = "",
				}, -- [6]
				{
					["feature"] = "FilterSet Editor",
				}, -- [7]
			},
		},
		["ChatFrame4_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 100,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 400,
				}, -- [1]
				{
					["number"] = "4",
					["ts"] = "HH:MM:SS STR",
					["color"] = {
						["a"] = 1,
						["r"] = 0.5137254901960784,
						["g"] = 0.4705882352941176,
						["b"] = 1,
					},
					["owner"] = "Base",
					["w"] = "BaseWidth",
					["feature"] = "chatframe",
					["h"] = "BaseHeight",
					["version"] = 1,
					["channel"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "cf1",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["justifyH"] = "LEFT",
						["sr"] = 0,
					},
				}, -- [2]
			},
		},
		["Paladin_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"classes", -- [1]
					[4] = true,
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Priest_Buff_Serendipity"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Serendipity",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_Serendipity_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["WoWRDX"] = {
			["ty"] = "AUI",
			["version"] = 1,
			["data"] = {
				["solo2"] = "WoWRDX:Solo_desk",
				["raidflag"] = 1,
				["arenaflag2"] = 1,
				["party"] = "WoWRDX:Party_desk",
				["pvp2"] = "WoWRDX:Battleground_desk",
				["raid"] = "WoWRDX:Raid_desk",
				["raid2"] = "WoWRDX:Raid_desk",
				["arenaflag"] = 1,
				["partyflag"] = 1,
				["raidflag2"] = 1,
				["soloflag"] = 1,
				["arena2"] = "WoWRDX:Arena_desk",
				["partyflag2"] = 1,
				["arena"] = "WoWRDX:Arena_desk",
				["soloflag2"] = 1,
				["solo"] = "WoWRDX:Solo_desk",
				["pvpflag"] = 1,
				["party2"] = "WoWRDX:Party_desk",
				["pvpflag2"] = 1,
				["pvp"] = "WoWRDX:Battleground_desk",
			},
		},
		["Priest_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Priest_fset",
					},
				},
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Priest",
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Priest_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0.5254901960784313,
					["g"] = 0.5254901960784313,
					["b"] = 0.5254901960784313,
				},
				["texture"] = "",
			},
		},
		["Party_desk"] = {
			["ty"] = "Desktop",
			["version"] = 2,
			["data"] = {
				{
					["strata"] = "BACKGROUND",
					["b"] = 0,
					["scale"] = 1,
					["dgp"] = true,
					["feature"] = "Desktop main",
					["offsetbottom"] = "0",
					["l"] = 0,
					["offsettop"] = "0",
					["r"] = 1365.333385068319,
					["root"] = true,
					["t"] = 768.0000066917983,
					["anchorx"] = 1248.7467033076,
					["alpha"] = 1,
					["offsetleft"] = "0",
					["offsetright"] = "0",
					["title"] = "Konyagi_AUI:desk_solo",
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = -10,
							["point"] = "TOPLEFT",
							["y"] = 10,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -20,
						},
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 20,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Combat_Logs",
							["x"] = 20,
							["point"] = "BOTTOMRIGHT",
							["y"] = -20,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = -20,
							["point"] = "BOTTOMLEFT",
							["y"] = -20,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["open"] = true,
					["name"] = "root",
					["anchory"] = 18.239958923888,
					["ap"] = "TOPLEFT",
				}, -- [1]
				{
					["strata"] = "MEDIUM",
					["r"] = 866.9866965304984,
					["scale"] = 1,
					["t"] = 47.78666548950701,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 20,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 17.06666731335399,
					["open"] = true,
				}, -- [2]
				{
					["strata"] = "MEDIUM",
					["r"] = 1348.266710285255,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar4",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1317.546600063446,
					["b"] = 199.680014288981,
					["open"] = true,
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["r"] = 1317.546600063446,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1286.826609357003,
					["b"] = 199.680014288981,
					["open"] = true,
				}, -- [4]
				{
					["strata"] = "MEDIUM",
					["r"] = 866.9866965304984,
					["scale"] = 1,
					["t"] = 78.50667113537041,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 47.78666548950701,
					["open"] = true,
				}, -- [5]
				{
					["strata"] = "MEDIUM",
					["r"] = 866.9866965304984,
					["scale"] = 1,
					["t"] = 109.2266693115234,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
						["TOP"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -100,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 78.50667113537041,
					["open"] = true,
				}, -- [6]
				{
					["strata"] = "MEDIUM",
					["r"] = 805.54665535993,
					["scale"] = 1,
					["t"] = 139.9466674876765,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 109.2266693115234,
					["open"] = true,
				}, -- [7]
				{
					["strata"] = "MEDIUM",
					["r"] = 805.54665535993,
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBarVehicle",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 139.9466674876765,
					["open"] = true,
				}, -- [8]
				{
					["strata"] = "MEDIUM",
					["r"] = 897.7066274792579,
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 139.9466674876765,
					["open"] = true,
				}, -- [9]
				{
					["strata"] = "MEDIUM",
					["r"] = 358.4000210501441,
					["scale"] = 1,
					["t"] = 128.0000160547205,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:XpBar",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 102.4000113498343,
					["open"] = true,
				}, -- [10]
				{
					["strata"] = "MEDIUM",
					["r"] = 358.4000210501441,
					["scale"] = 1,
					["t"] = 102.4000113498343,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "root",
							["x"] = 20,
							["point"] = "BOTTOMLEFT",
							["y"] = 20,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 17.06666731335399,
					["open"] = true,
				}, -- [11]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 140.8000221420188,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:XpBar",
					["b"] = 128.0000160547205,
					["anchor"] = "TOPLEFT",
					["l"] = 187.7333479166043,
					["open"] = true,
					["r"] = 358.4000210501441,
				}, -- [12]
				{
					["strata"] = "MEDIUM",
					["r"] = 1365.333385068319,
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureDebuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
						["TOPRIGHT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 725.3333197341373,
					["open"] = true,
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["r"] = 1365.333385068319,
					["scale"] = 1,
					["t"] = 725.3333197341373,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 678.3999939595518,
					["open"] = true,
				}, -- [14]
				{
					["strata"] = "MEDIUM",
					["r"] = 184.3200039963389,
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = -10,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "root",
							["x"] = 10,
							["point"] = "TOPLEFT",
							["y"] = -10,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 10,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 8.533333656676994,
					["b"] = 694.6133290276947,
					["open"] = true,
				}, -- [15]
				{
					["strata"] = "MEDIUM",
					["r"] = 770.5600258365629,
					["scale"] = 1,
					["t"] = 216.7466741326246,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Cooldowns_Used",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 100,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 594.7733592317561,
					["b"] = 194.5600058782934,
					["open"] = true,
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -10,
						},
						["RIGHT"] = {
							["id"] = "WoWRDX:Pettarget_Main",
							["x"] = -10,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 686.0799916361625,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["r"] = 184.3200039963389,
					["anchor"] = "TOPLEFT",
					["l"] = 8.533339258959785,
					["b"] = 621.2266513635912,
					["open"] = true,
				}, -- [17]
				{
					["strata"] = "MEDIUM",
					["r"] = 368.6400079926778,
					["scale"] = 1,
					["t"] = 686.0799916361625,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pettarget_Main",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 192.8533413878711,
					["b"] = 621.2266513635912,
					["open"] = true,
				}, -- [18]
				{
					["strata"] = "HIGH",
					["r"] = 1220.760307632507,
					["scale"] = 1,
					["t"] = 561.8533894213333,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMapButtons",
					["b"] = 534.5466978168937,
					["anchor"] = "TOPLEFT",
					["l"] = 1084.227028883359,
					["open"] = true,
					["ap"] = "TOPLEFT",
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["r"] = 368.6400079926778,
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Target_Main",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Targettarget_Main",
							["x"] = -10,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 192.8533413878711,
					["b"] = 694.6133290276947,
					["open"] = true,
				}, -- [20]
				{
					["strata"] = "MEDIUM",
					["r"] = 552.9600119890167,
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 377.17334538421,
					["b"] = 694.6133290276947,
					["open"] = true,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Partytarget",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 416.4693105890893,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Party",
					["r"] = 175.8720155157196,
					["anchor"] = "TOPLEFT",
					["l"] = 0,
					["b"] = 351.5306363450258,
					["open"] = true,
				}, -- [22]
				{
					["strata"] = "MEDIUM",
					["r"] = 360.1920045726378,
					["scale"] = 1,
					["t"] = 416.4266436033432,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:PartyTarget",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 184.4053529072519,
					["b"] = 351.5733033307719,
					["alpha"] = 1,
				}, -- [23]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 416.4266436033432,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Partytarget",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 175.8720155157196,
					["b"] = 351.5733033307719,
					["r"] = 351.6586671811056,
				}, -- [24]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "BOTTOMRIGHT",
							["y"] = 20,
						},
					},
					["scale"] = 1,
					["t"] = 145.0666908377849,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Combat_Logs",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1015.466611773182,
					["b"] = 17.06666731335399,
					["r"] = 1348.266710285255,
				}, -- [25]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 242.3466713678004,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Cooldowns_Used",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 554.6666914188597,
					["b"] = 216.7466741326246,
					["r"] = 810.6667534071423,
				}, -- [26]
			},
		},
		["Threat_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_threat",
				}, -- [1]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "red",
					["color"] = {
						["a"] = 1,
						["b"] = 0.2862745098039216,
						["g"] = 0.3098039215686275,
						["r"] = 1,
					},
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 13,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 180,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["frac"] = "fthreat",
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["h"] = "12",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["version"] = 1,
					["interpolate"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["name"] = "statusBar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Ruben",
					},
				}, -- [5]
				{
					["owner"] = "pdt",
					["w"] = "60",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["title"] = "Default",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["h"] = "12",
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [6]
				{
					["txt"] = "threat_info",
					["owner"] = "pdt",
					["w"] = "40",
					["feature"] = "txt_dyn",
					["h"] = "14",
					["name"] = "infothreat",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "RIGHT",
						["af"] = "Text_np",
					},
					["version"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
				}, -- [7]
				{
					["txt"] = "threat_value",
					["owner"] = "pdt",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["h"] = "12",
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "RIGHT",
						["af"] = "Text_infothreat",
					},
					["version"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["sr"] = 0,
					},
				}, -- [8]
				{
					["feature"] = "shader_showhide",
					["owner"] = "pdt",
					["version"] = 1,
					["flag"] = "bthreat",
				}, -- [9]
			},
		},
		["Dispell_Grid_Shiftcode_sc"] = {
			["ty"] = "Script",
			["version"] = 1,
			["data"] = {
				["script"] = "if shifted_flag then text = \"SHIFT\"; end",
			},
		},
		["Raid_Group1"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 1",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group1",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 40,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Raid_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [1]
				{
					["feature"] = "var_pred_health",
				}, -- [2]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [3]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "range",
					["set"] = {
						["class"] = "unitinrange",
					},
				}, -- [4]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "voice",
					["set"] = {
						["class"] = "voip_talk",
					},
				}, -- [5]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "rezincom",
					["set"] = {
						["class"] = "rez",
						["n"] = 1,
					},
				}, -- [6]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "rezdone",
					["set"] = {
						["class"] = "rez",
						["n"] = 2,
					},
				}, -- [7]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "nonmort",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Not_Dead_fset",
					},
				}, -- [8]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "aggro",
					["set"] = {
						["class"] = "ags",
					},
				}, -- [9]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["comment"] = "Variable",
				}, -- [10]
				{
					["feature"] = "ColorVariable: Unit PowerType Color",
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0.2235294117647059,
						["g"] = 0.2078431372549019,
						["b"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.5,
						["r"] = 1,
					},
					["energyColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["runeColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 1,
					},
					["rageColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [11]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "vierouge",
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
				}, -- [12]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "vievert",
					["color"] = {
						["a"] = 1,
						["b"] = 0.2784313725490196,
						["g"] = 0.8784313725490196,
						["r"] = 0.611764705882353,
					},
				}, -- [13]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "vert2",
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.6431372549019607,
						["r"] = 0.2078431372549019,
					},
				}, -- [14]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "colorrezincom",
					["color"] = {
						["a"] = 1,
						["b"] = 0.3449999988079071,
						["g"] = 0.8240000009536743,
						["r"] = 1,
					},
				}, -- [15]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "blanc",
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
				}, -- [16]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "colorrezdone",
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.4745098039215687,
						["r"] = 0.7450980392156863,
					},
				}, -- [17]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "gris2",
					["color"] = {
						["a"] = 1,
						["b"] = 0.5019607843137255,
						["g"] = 0.5019607843137255,
						["r"] = 0.5019607843137255,
					},
				}, -- [18]
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [19]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "vie",
					["colorVar1"] = "vierouge",
					["condVar"] = "aggro_flag",
					["colorVar2"] = "vert2",
				}, -- [20]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "couleurporte",
					["colorVar1"] = "vie",
					["condVar"] = "range_flag",
					["colorVar2"] = "gris2",
				}, -- [21]
				{
					["feature"] = "commentline",
				}, -- [22]
				{
					["feature"] = "base_default",
					["h"] = 22,
					["version"] = 1,
					["w"] = 224,
					["alpha"] = 1,
				}, -- [23]
				{
					["feature"] = "Subframe",
					["h"] = "22",
					["name"] = "cadre",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "163",
					["anchor"] = {
						["dx"] = 61,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [24]
				{
					["feature"] = "backdrop",
					["owner"] = "cadre",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["bg"] = 0.3843137254901961,
						["edgeSize"] = 8,
						["kr"] = 0,
						["ka"] = 0.2445517182350159,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bb"] = 0.3803921568627451,
						["kg"] = 0,
						["br"] = 0.4470588235294117,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "pdt",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "160",
					["anchor"] = {
						["dx"] = 62,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [26]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["comment"] = "",
				}, -- [27]
				{
					["set2"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Poison_fset",
					},
					["texture1"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					},
					["set1"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Magic_fset",
					},
					["texture2"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_NullifyPoison_02",
					},
					["set3"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Disease_fset",
					},
					["set4"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Curse_fset",
					},
					["raColor5"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texture4"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_RemoveCurse",
					},
					["raColor2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.5,
						["b"] = 0,
					},
					["feature"] = "Variables decurse",
					["raColor1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 1,
					},
					["texture3"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_RemoveDisease",
					},
					["raColor3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["raColor4"] = {
						["a"] = 1,
						["r"] = 0.9,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [28]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "fdebuff",
					["flOffset"] = 1,
					["owner"] = "pdt",
					["w"] = "20",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
				}, -- [29]
				{
					["feature"] = "backdrop",
					["owner"] = "fdebuff",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["ba"] = 1,
						["bb"] = 0.3803921568627451,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["br"] = 0.4470588235294117,
						["_backdrop"] = "none",
						["bg"] = 0.3843137254901961,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [30]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "fdebuff",
					["w"] = "17",
					["sublevel"] = 1,
					["h"] = "17",
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_fdebuff",
					},
					["name"] = "TextureDecurse",
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [31]
				{
					["feature"] = "shader_applytex",
					["owner"] = "TextureDecurse",
					["version"] = 1,
					["var"] = "decurseIcon",
				}, -- [32]
				{
					["w"] = "20",
					["feature"] = "hotspot",
					["flo"] = 4,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 62,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["name"] = "decurse",
					["secure"] = 1,
					["h"] = "20",
				}, -- [33]
				{
					["feature"] = "commentline",
				}, -- [34]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "fpower",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "20",
					["flOffset"] = 1,
				}, -- [35]
				{
					["feature"] = "backdrop",
					["owner"] = "fpower",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["ba"] = 1,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bg"] = 0.3843137254901961,
						["bb"] = 0.3803921568627451,
						["br"] = 0.4470588235294117,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [36]
				{
					["frac"] = "fm",
					["flOffset"] = 0,
					["owner"] = "pdt",
					["w"] = "16",
					["feature"] = "statusbar_horiz",
					["h"] = "16",
					["version"] = 1,
					["colorVar"] = "powerColor",
					["anchor"] = {
						["dx"] = 22,
						["dy"] = 2,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_pdt",
					},
					["name"] = "manaBar",
					["orientation"] = "VERTICAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\vbar_halfoutline",
					},
				}, -- [37]
				{
					["w"] = "20",
					["feature"] = "hotspot",
					["flo"] = 4,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 82,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["name"] = "status",
					["secure"] = 1,
					["h"] = "20",
				}, -- [38]
				{
					["feature"] = "commentline",
				}, -- [39]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "high1",
					["flOffset"] = 1,
					["owner"] = "pdt",
					["w"] = "120",
					["anchor"] = {
						["dx"] = 40,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
				}, -- [40]
				{
					["frac"] = "pfh",
					["flOffset"] = 0,
					["owner"] = "high1",
					["w"] = "120",
					["feature"] = "statusbar_horiz",
					["h"] = "18",
					["version"] = 1,
					["colorVar"] = "vievert",
					["orientation"] = "HORIZONTAL",
					["name"] = "previeBar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high1",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [41]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "high2",
					["flOffset"] = 2,
					["owner"] = "pdt",
					["w"] = "120",
					["anchor"] = {
						["dx"] = 40,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
				}, -- [42]
				{
					["frac"] = "fh",
					["flOffset"] = 0,
					["owner"] = "high2",
					["w"] = "120",
					["colorVar"] = "couleurporte",
					["feature"] = "statusbar_horiz",
					["h"] = "18",
					["name"] = "viebar",
					["interpolate"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high2",
					},
					["version"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [43]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "high3",
					["flOffset"] = 3,
					["owner"] = "pdt",
					["w"] = "120",
					["anchor"] = {
						["dx"] = 40,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
				}, -- [44]
				{
					["w"] = "120",
					["feature"] = "hotspot",
					["flo"] = 4,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 102,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["name"] = "action",
					["secure"] = 1,
					["h"] = "20",
				}, -- [45]
				{
					["feature"] = "commentline",
				}, -- [46]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high3",
					["w"] = "12",
					["sublevel"] = 1,
					["h"] = "12",
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 47,
						["dy"] = -3,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_high3",
					},
					["name"] = "texparlera",
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Common\\VoiceChat-Speaker",
					},
				}, -- [47]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high3",
					["w"] = "12",
					["sublevel"] = 1,
					["h"] = "12",
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 47,
						["dy"] = -3,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_high3",
					},
					["name"] = "texparlerb",
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Common\\VoiceChat-On",
					},
				}, -- [48]
				{
					["color"] = "blanc",
					["feature"] = "Highlight: Texture Map",
					["flag"] = "voice_flag",
					["texture"] = "texparlera",
				}, -- [49]
				{
					["feature"] = "Highlight: Texture Map",
					["color"] = "blanc",
					["flag"] = "voice_flag",
					["texture"] = "texparlerb",
				}, -- [50]
				{
					["feature"] = "commentline",
				}, -- [51]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high2",
					["w"] = "120",
					["sublevel"] = 1,
					["h"] = "18",
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high2",
					},
					["name"] = "texrez",
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [52]
				{
					["feature"] = "Highlight: Texture Map",
					["color"] = "colorrezincom",
					["flag"] = "rezincom_flag",
					["texture"] = "texrez",
				}, -- [53]
				{
					["feature"] = "Highlight: Texture Map",
					["color"] = "colorrezdone",
					["flag"] = "rezdone_flag",
					["texture"] = "texrez",
				}, -- [54]
				{
					["feature"] = "commentline",
				}, -- [55]
				{
					["owner"] = "high3",
					["w"] = "80",
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["name"] = "np",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 1,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_high3",
					},
					["h"] = "19",
					["classColor"] = 1,
					["version"] = 1,
				}, -- [56]
				{
					["txt"] = "pheal",
					["owner"] = "high3",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -3,
						["dy"] = 1,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_high3",
					},
					["name"] = "txt_pheal",
					["h"] = "19",
				}, -- [57]
				{
					["owner"] = "high3",
					["w"] = "30",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -25,
						["dy"] = 1,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_high3",
					},
					["name"] = "txt_state",
					["font"] = {
						["size"] = 8,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["ty"] = "fdld",
				}, -- [58]
				{
					["externalNameFilter"] = "WoWRDX:Buff_af",
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_icons",
					["iconspx"] = 1,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = -6,
						["lp"] = "BOTTOMRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Frame_high3",
					},
					["iconspy"] = 0,
					["nIcons"] = 5,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "high3",
					["playerauras"] = 1,
					["usebs"] = true,
					["size"] = 12,
					["version"] = 1,
					["name"] = "regen",
					["maxdurationfilter"] = "",
					["orientation"] = "LEFT",
					["filterName"] = 1,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["unitfilter"] = "",
				}, -- [59]
				{
					["externalNameFilter"] = "WoWRDX:Bossmod_af",
					["filterName"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_icons",
					["iconspx"] = 0,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -19,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["nIcons"] = 3,
					["mindurationfilter"] = "",
					["auraType"] = "DEBUFFS",
					["owner"] = "pdt",
					["fontst"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["size"] = 18,
					["bkd"] = {
					},
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "boss",
					["orientation"] = "LEFT",
					["usebs"] = true,
					["rows"] = 1,
					["unitfilter"] = "",
				}, -- [60]
				{
					["owner"] = "high3",
					["w"] = "12",
					["drawLayer"] = "OVERLAY",
					["h"] = "12",
					["name"] = "rtai",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -4,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_high3",
					},
					["ukfilter"] = 1,
					["feature"] = "ico_subclass",
				}, -- [61]
				{
					["feature"] = "Raid Leader Icon",
					["h"] = "13",
					["name"] = "rli",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 34,
						["dy"] = -4,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_high3",
					},
					["owner"] = "high3",
					["w"] = "13",
					["drawLayer"] = "ARTWORK",
				}, -- [62]
				{
					["feature"] = "Master Looter Icon",
					["h"] = "13",
					["name"] = "mli",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 21,
						["dy"] = -3,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_high3",
					},
					["owner"] = "high3",
					["w"] = "13",
					["drawLayer"] = "ARTWORK",
				}, -- [63]
			},
		},
		["Paladin_Buff_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"groups", -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
					true, -- [5]
					true, -- [6]
					true, -- [7]
					true, -- [8]
					true, -- [9]
				}, -- [2]
				{
					"classes", -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
					true, -- [5]
					true, -- [6]
					true, -- [7]
					true, -- [8]
					true, -- [9]
					true, -- [10]
					true, -- [11]
				}, -- [3]
			},
		},
		["ChatFrame3_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 100,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 400,
				}, -- [1]
				{
					["number"] = "3",
					["ts"] = "HH:MM:SS STR",
					["color"] = {
						["a"] = 1,
						["r"] = 0.5137254901960784,
						["g"] = 0.4705882352941176,
						["b"] = 1,
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "chatframe",
					["h"] = "BaseHeight",
					["version"] = 1,
					["channel"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "cf1",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["justifyH"] = "LEFT",
						["sr"] = 0,
					},
				}, -- [2]
			},
		},
		["Health_Missing_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["w"] = 90,
					["alpha"] = 1,
					["ph"] = 1,
				}, -- [4]
				{
					["interpolate"] = 1,
					["frac"] = "fh",
					["owner"] = "Base",
					["w"] = "90",
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "14",
					["name"] = "statusBar",
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [5]
				{
					["owner"] = "Base",
					["w"] = "50",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["h"] = "14",
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [6]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 8,
					},
					["name"] = "text_hp_missing",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["ty"] = "hpm",
					["h"] = "14",
				}, -- [7]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 8,
					},
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["ty"] = "fdld",
					["h"] = "14",
				}, -- [8]
			},
		},
		["Targettarget_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Targettarget_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["unitWatch"] = 1,
					["version"] = 1,
					["clickable"] = 1,
					["unit"] = "targettarget",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [4]
				{
					["interval"] = 0.1,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [5]
			},
		},
		["Not_Elixirs_Battle_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 11390,
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 11406,
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 17538,
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 17539,
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28490,
						}, -- [2]
					}, -- [2]
				}, -- [6]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28491,
						}, -- [2]
					}, -- [2]
				}, -- [7]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28493,
						}, -- [2]
					}, -- [2]
				}, -- [8]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28497,
						}, -- [2]
					}, -- [2]
				}, -- [9]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28501,
						}, -- [2]
					}, -- [2]
				}, -- [10]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28503,
						}, -- [2]
					}, -- [2]
				}, -- [11]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 33720,
						}, -- [2]
					}, -- [2]
				}, -- [12]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 33721,
						}, -- [2]
					}, -- [2]
				}, -- [13]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 33726,
						}, -- [2]
					}, -- [2]
				}, -- [14]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 38954,
						}, -- [2]
					}, -- [2]
				}, -- [15]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 45373,
						}, -- [2]
					}, -- [2]
				}, -- [16]
			},
		},
		["Alive_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.01176470588235294,
					["g"] = 0,
					["r"] = 0.4705882352941178,
				},
				["name"] = "Alive",
				["texture"] = "",
				["max"] = {
					["set"] = {
						["class"] = "group",
					},
					["qty"] = "ssz",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["sv"] = 3,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Alive_fset",
						["class"] = "file",
					},
					["qty"] = "ssz",
				},
			},
		},
		["Status_Power_Role"] = {
			["ty"] = "StatusWindow",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Mana Status",
					["bkdColor"] = {
						["a"] = 0.5,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [1]
				{
					["feature"] = "Raid Status DataSource",
				}, -- [2]
				{
					["feature"] = "Stat Frames: Bar",
					["h"] = "14",
					["fsz"] = 8,
					["tdx"] = 60,
					["w"] = "120",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Healer_Power_stc",
				}, -- [5]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Dps_Power_stc",
				}, -- [6]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.3,
					["slot"] = "RepaintAll",
				}, -- [7]
				{
					["feature"] = "Description",
					["description"] = "Mana statistics",
				}, -- [8]
			},
		},
		["Debuff_Magic_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["buff"] = "@magic",
						["class"] = "debuff",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = "thunderfury",
							["class"] = "debuff",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = "unstable affliction",
							["class"] = "debuff",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = "dreamless sleep",
							["class"] = "debuff",
						}, -- [2]
					}, -- [2]
				}, -- [5]
			},
		},
		["Raid_Group4"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 4",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group4",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["cols"] = 40,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["FactionBar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["colorHonored"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0.53,
					},
					["colorFriendly"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["colorUnknown"] = {
						["a"] = 1,
						["r"] = 0.5,
						["g"] = 0.5,
						["b"] = 0.5,
					},
					["colorRevered"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0.8,
					},
					["factionID"] = 14,
					["feature"] = "Variables: Detailed Faction Info",
					["colorHostile"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["name"] = "faction1",
					["colorUnfriendly"] = {
						["a"] = 1,
						["r"] = 0.9300000000000001,
						["g"] = 0.4,
						["b"] = 0.13,
					},
					["factionName"] = "Horde",
					["colorNeutral"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["colorExalted"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 1,
					},
					["colorHated"] = {
						["a"] = 1,
						["r"] = 0.8,
						["g"] = 0.13,
						["b"] = 0.13,
					},
				}, -- [1]
				{
					["feature"] = "commentline",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 15,
					["version"] = 1,
					["w"] = 200,
					["alpha"] = 1,
				}, -- [3]
				{
					["feature"] = "backdrop",
					["owner"] = "decor",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 1,
						["kg"] = 1,
						["_backdrop"] = "solid",
						["kb"] = 0.5058823529411765,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["_border"] = "none",
						["kr"] = 0.6235294117647059,
					},
				}, -- [4]
				{
					["frac"] = "faction1",
					["flOffset"] = 0,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "statusbar_horiz",
					["h"] = "BaseHeight",
					["version"] = 1,
					["colorVar"] = "faction1cv",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "statusBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Dabs",
					},
				}, -- [5]
				{
					["txt"] = "faction1txt",
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_dyn",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["name"] = "infoText",
					["h"] = "BaseHeight",
				}, -- [6]
			},
		},
		["ActionBar2"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBar2_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Deathknight_Runes4"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes4_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Threat_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["op"] = "threatscaled",
					}, -- [1]
					{
						["op"] = "alpha",
					}, -- [2]
				},
				["set"] = {
					["file"] = "WoWRDX:Threat_fset",
					["class"] = "file",
				},
			},
		},
		["Warlock_Shards"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Warlock_Shards_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Totems4"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems4_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Raid_Druid_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 36,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "30",
					["name"] = "hpframe",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "30",
					["flOffset"] = 3,
				}, -- [2]
				{
					["feature"] = "Subframe",
					["h"] = "34",
					["name"] = "bgframe",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["owner"] = "hpframe",
					["w"] = "34",
					["flOffset"] = 2,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "34",
					["name"] = "blackbox",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "34",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "bgframe",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 0,
						["ka"] = 0.2000000029802322,
						["kg"] = 0,
						["kr"] = 0,
					},
				}, -- [5]
				{
					["feature"] = "backdrop",
					["owner"] = "blackbox",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["kg"] = 0,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["ka"] = 0.4000000059604645,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [6]
				{
					["feature"] = "commentline",
				}, -- [7]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [8]
				{
					["feature"] = "var_pred_health",
				}, -- [9]
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [10]
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [11]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["name"] = "black",
					["feature"] = "ColorVariable: Static Color",
				}, -- [12]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [13]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.07500000298023224,
						["g"] = 0.07500000298023224,
						["r"] = 0.07500000298023224,
					},
					["name"] = "grey",
					["feature"] = "ColorVariable: Static Color",
				}, -- [14]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.7647058823529411,
						["g"] = 0,
						["b"] = 1,
					},
					["name"] = "purple",
					["feature"] = "ColorVariable: Static Color",
				}, -- [16]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [17]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 1,
					},
					["name"] = "blue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [18]
				{
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [19]
				{
					["color"] = {
						["a"] = 0.8257031291723251,
						["r"] = 0.4313725490196079,
						["g"] = 1,
						["b"] = 0.3725490196078432,
					},
					["name"] = "incomingheal",
					["feature"] = "ColorVariable: Static Color",
				}, -- [20]
				{
					["feature"] = "ColorVariable: Two-Color Blend",
					["name"] = "darkclass",
					["colorVar1"] = "classColor",
					["colorVar2"] = "black",
					["bfVar"] = "0.4",
				}, -- [21]
				{
					["feature"] = "ColorVariable: Two-Color Blend",
					["name"] = "namecolor",
					["colorVar1"] = "classColor",
					["colorVar2"] = "grey",
					["bfVar"] = ".3",
				}, -- [22]
				{
					["feature"] = "ColorVariable: Two-Color Blend",
					["name"] = "missinghpc",
					["colorVar1"] = "classColor",
					["colorVar2"] = "classColor",
					["bfVar"] = "1",
				}, -- [23]
				{
					["feature"] = "commentline",
				}, -- [24]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "alive",
					["set"] = {
						["file"] = "WoWRDX:Alive_fset",
						["class"] = "file",
					},
				}, -- [25]
				{
					["frac"] = "fh",
					["owner"] = "hpframe",
					["w"] = "28",
					["h"] = "28",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "darkclass",
					["version"] = 1,
					["interpolate"] = 1,
					["orientation"] = "VERTICAL",
					["name"] = "hp",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar_smooth",
					},
				}, -- [26]
				{
					["frac"] = "pfh",
					["owner"] = "hpframe",
					["w"] = "28",
					["feature"] = "statusbar_horiz",
					["h"] = "28",
					["version"] = 1,
					["colorVar"] = "incomingheal",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["name"] = "php",
					["orientation"] = "VERTICAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar_smooth",
					},
				}, -- [27]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "hpframe",
					["w"] = "28",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar_smooth",
					},
					["drawLayer"] = "ARTWORK",
					["h"] = "28",
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["name"] = "hpmiss",
					["disable"] = true,
				}, -- [28]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "hpframe",
					["w"] = "28",
					["disable"] = true,
					["drawLayer"] = "BACKGROUND",
					["h"] = "28",
					["name"] = "phhp",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["feature"] = "texture",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "ALPHAKEY",
					},
				}, -- [29]
				{
					["w1"] = 28,
					["w2"] = 28,
					["flag"] = "alive_flag",
					["feature"] = "StatusBar Texture Map",
					["b1"] = 0,
					["b2"] = 0,
					["texture"] = "phhp",
					["frac"] = "pfh",
					["h2"] = 28,
					["h1"] = 0.10000000149012,
					["l2"] = 0,
					["color"] = "incomingheal",
					["t1"] = 1,
					["l1"] = 0,
					["t2"] = 1,
					["r1"] = 0,
					["r2"] = 1,
					["disable"] = true,
				}, -- [30]
				{
					["t2"] = 1,
					["t1"] = 1,
					["color"] = "darkclass",
					["feature"] = "StatusBar Texture Map",
					["b1"] = 0,
					["b2"] = 0,
					["texture"] = "hpmiss",
					["frac"] = "fh",
					["h2"] = 28,
					["h1"] = 0.10000000149012,
					["l2"] = 0,
					["flag"] = "alive_flag",
					["w2"] = 28,
					["l1"] = 0,
					["w1"] = 28,
					["r1"] = 0,
					["r2"] = 1,
					["disable"] = true,
				}, -- [31]
				{
					["feature"] = "commentline",
					["comment"] = "",
					["version"] = 1,
				}, -- [32]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "deaddc",
					["set"] = {
						["file"] = "WoWRDX:Dead_fset",
						["class"] = "file",
					},
				}, -- [33]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "bgframe",
					["w"] = "28",
					["feature"] = "texture",
					["h"] = "28",
					["version"] = 1,
					["name"] = "hpbg",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 0.6509803921568631,
							["g"] = 0.6509803921568631,
							["b"] = 0.6509803921568631,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [34]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "deaddc_flag",
					["color"] = "darkclass",
					["texture"] = "hpbg",
				}, -- [35]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "alive_flag",
					["color"] = "missinghpc",
					["texture"] = "hpbg",
				}, -- [36]
				{
					["feature"] = "commentline",
				}, -- [37]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "26",
					["feature"] = "texture",
					["h"] = "26",
					["version"] = 1,
					["name"] = "redx",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["sublevel"] = 1,
					["drawLayer"] = "BACKGROUND",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\x",
					},
				}, -- [38]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "ld",
					["color"] = "grey",
					["texture"] = "redx",
				}, -- [39]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "deaddc_flag",
					["color"] = "red",
					["texture"] = "redx",
				}, -- [40]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "alive_flag",
					["color"] = "alpha",
					["texture"] = "redx",
				}, -- [41]
				{
					["feature"] = "commentline",
				}, -- [42]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "dblcure",
					["set"] = {
						["file"] = "WoWRDX:Debuff_Both_fset",
						["class"] = "file",
					},
				}, -- [43]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "cure1",
					["set"] = {
						["file"] = "WoWRDX:Debuff_Primary_fset",
						["class"] = "file",
					},
				}, -- [44]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "cure2",
					["set"] = {
						["file"] = "WoWRDX:Debuff_Secondary_fset",
						["class"] = "file",
					},
				}, -- [45]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "none",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_None_fset",
					},
				}, -- [46]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "decor",
					["w"] = "46",
					["feature"] = "texture",
					["h"] = "46",
					["version"] = 1,
					["name"] = "debuff",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["sublevel"] = 1,
					["drawLayer"] = "BACKGROUND",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\crosshair",
					},
				}, -- [47]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "cure1_flag",
					["color"] = "red",
					["texture"] = "debuff",
				}, -- [48]
				{
					["flag"] = "cure2_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "blue",
					["texture"] = "debuff",
				}, -- [49]
				{
					["flag"] = "dblcure_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "purple",
					["texture"] = "debuff",
				}, -- [50]
				{
					["flag"] = "none_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "alpha",
					["texture"] = "debuff",
				}, -- [51]
				{
					["feature"] = "commentline",
					["name"] = "",
					["version"] = 1,
				}, -- [52]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "redset",
					["set"] = {
						["file"] = "default:set_red",
						["class"] = "file",
					},
				}, -- [53]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "hpframe",
					["w"] = "7",
					["feature"] = "texture",
					["h"] = "7",
					["version"] = 1,
					["name"] = "redbox",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "TOP",
						["rp"] = "TOP",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 0,
							["b"] = 0,
						},
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\stop",
					},
				}, -- [54]
				{
					["feature"] = "shaderTex_showhide",
					["owner"] = "redbox",
					["version"] = 1,
					["flag"] = "redset_flag",
				}, -- [55]
				{
					["feature"] = "commentline",
					["comment"] = "greenset",
					["version"] = 1,
				}, -- [56]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "greenset",
					["set"] = {
						["file"] = "default:set_green",
						["class"] = "file",
					},
				}, -- [57]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "hpframe",
					["w"] = "7",
					["feature"] = "texture",
					["h"] = "7",
					["version"] = 1,
					["name"] = "greenbox",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["r"] = 0,
							["g"] = 1,
							["b"] = 0,
						},
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\stop",
					},
				}, -- [58]
				{
					["feature"] = "shaderTex_showhide",
					["owner"] = "greenbox",
					["version"] = 1,
					["flag"] = "greenset_flag",
				}, -- [59]
				{
					["feature"] = "commentline",
					["comment"] = "yellowset",
					["version"] = 1,
				}, -- [60]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "yellowset",
					["set"] = {
						["file"] = "default:set_yellow",
						["class"] = "file",
					},
				}, -- [61]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "hpframe",
					["w"] = "7",
					["feature"] = "texture",
					["h"] = "7",
					["version"] = 1,
					["name"] = "yellowbox",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 0,
						},
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\stop",
					},
				}, -- [62]
				{
					["feature"] = "shaderTex_showhide",
					["owner"] = "yellowbox",
					["version"] = 1,
					["flag"] = "yellowset_flag",
				}, -- [63]
				{
					["feature"] = "commentline",
					["comment"] = "blueset",
					["version"] = 1,
				}, -- [64]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "blueset",
					["set"] = {
						["file"] = "default:set_blue",
						["class"] = "file",
					},
				}, -- [65]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "hpframe",
					["w"] = "7",
					["feature"] = "texture",
					["h"] = "7",
					["version"] = 1,
					["name"] = "bluebox",
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["r"] = 0,
							["g"] = 0,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\stop",
					},
				}, -- [66]
				{
					["feature"] = "shaderTex_showhide",
					["owner"] = "bluebox",
					["version"] = 1,
					["flag"] = "blueset_flag",
				}, -- [67]
				{
					["feature"] = "commentline",
					["name"] = "",
					["version"] = 1,
				}, -- [68]
				{
					["owner"] = "hpframe",
					["w"] = "28",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "CENTER",
						["name"] = "Default",
						["size"] = 10,
					},
					["name"] = "np",
					["h"] = "14",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "hpframe",
					},
					["trunc"] = 3,
					["feature"] = "txt_np",
					["version"] = 1,
				}, -- [69]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["name"] = "click",
					["h"] = "36",
					["flo"] = 3,
				}, -- [70]
				{
					["feature"] = "commentline",
					["comment"] = "inrange",
					["version"] = 1,
				}, -- [71]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "inrange",
					["set"] = {
						["class"] = "unitinrange",
					},
				}, -- [72]
				{
					["feature"] = "shader_showhide",
					["owner"] = "blackbox",
					["version"] = 1,
					["flag"] = "inrange_flag",
				}, -- [73]
				{
					["feature"] = "commentline",
					["comment"] = "",
					["version"] = 1,
				}, -- [74]
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timer1"] = 0,
					["timer2"] = 0,
					["name"] = "aurareju",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["cd"] = 774,
				}, -- [75]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["name"] = "rejutxt",
					["h"] = "14",
				}, -- [76]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Largest",
					["statusBar"] = "",
					["texIcon"] = "",
					["text"] = "rejutxt",
					["countTypeFlag"] = "true",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["TL"] = 0,
					["version"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["blendcolor"] = 1,
					["tex"] = "",
					["timerVar"] = "aurareju_aura",
					["txt"] = "",
				}, -- [77]
				{
					["feature"] = "commentline",
				}, -- [78]
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["timer1"] = "0",
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timer2"] = "0",
					["name"] = "auraregrowth",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["cd"] = 8936,
				}, -- [79]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Base",
					},
					["name"] = "regrotxt",
					["h"] = "14",
				}, -- [80]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Largest",
					["statusBar"] = "",
					["texIcon"] = "",
					["text"] = "regrotxt",
					["countTypeFlag"] = "true",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["TL"] = 0,
					["version"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["blendcolor"] = 1,
					["tex"] = "",
					["timerVar"] = "auraregrowth_aura",
					["txt"] = "",
				}, -- [81]
				{
					["feature"] = "commentline",
				}, -- [82]
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["timer1"] = "0",
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timer2"] = "0",
					["name"] = "aurawgrowth",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["cd"] = "wild growth",
				}, -- [83]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["name"] = "wgrothtxt",
					["h"] = "14",
				}, -- [84]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Largest",
					["statusBar"] = "",
					["texIcon"] = "",
					["text"] = "wgrothtxt",
					["countTypeFlag"] = "true",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["TL"] = 0,
					["version"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["blendcolor"] = 1,
					["tex"] = "",
					["timerVar"] = "aurawgrowth_aura",
					["txt"] = "",
				}, -- [85]
				{
					["feature"] = "commentline",
				}, -- [86]
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["timer1"] = "0",
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timer2"] = "0",
					["name"] = "auralifebloom",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["cd"] = "lifebloom",
				}, -- [87]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "lbtxt",
					["h"] = "14",
				}, -- [88]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["stackMax"] = 3,
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Tenths",
					["statusBar"] = "",
					["txt"] = "",
					["texIcon"] = "",
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["tex"] = "",
					["text"] = "lbtxt",
					["TL"] = 0,
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["stackVar"] = "aura_lifebloom_stack",
					["blendcolor"] = 1,
					["stack"] = 1,
					["timerVar"] = "auralifebloom_aura",
					["TTIExpireState"] = "Hide",
				}, -- [89]
			},
		},
		["Warlock_Shards_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Number power",
					["powertype"] = "SPELL_POWER_SOUL_SHARDS",
					["name"] = "nm",
				}, -- [1]
				{
					["feature"] = "base_default",
					["h"] = 20,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 100,
				}, -- [2]
				{
					["number"] = "nm",
					["rows"] = 1,
					["feature"] = "custom_icons",
					["iconspx"] = 5,
					["color4"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0.5,
					},
					["ButtonSkinOffset"] = 3,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["nIcons"] = 5,
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0.5,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0.5,
					},
					["name"] = "customicon1",
					["version"] = 1,
					["drawLayer"] = "ARTWORK",
					["orientation"] = "RIGHT",
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0.5,
					},
					["color5"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0.5,
					},
					["h"] = 20,
				}, -- [3]
			},
		},
		["Debuff_Curse_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["buff"] = "@curse",
						["class"] = "debuff",
					}, -- [2]
				}, -- [2]
			},
		},
		["Player_Buff_Bar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 150,
					["version"] = 1,
					["w"] = 250,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_bars2",
					["iconspx"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["iconspy"] = 1,
					["nIcons"] = 10,
					["mindurationfilter"] = 0,
					["auraType"] = "BUFFS",
					["owner"] = "decor",
					["sbtib"] = {
						["timetxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "RIGHT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["borientation"] = "HORIZONTAL",
						["btype"] = "Button",
						["w"] = 220,
						["h"] = 20,
						["nametxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
						},
						["stacktxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["bkd"] = {
							["_border"] = "tooltip",
							["edgeSize"] = 16,
							["_backdrop"] = "none",
							["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
							["insets"] = {
								["top"] = 4,
								["right"] = 4,
								["left"] = 4,
								["bottom"] = 4,
							},
						},
						["banchor"] = "LEFT",
						["showicon"] = true,
						["showname"] = true,
						["iconposition"] = "LEFT",
					},
					["countTypeFlag"] = "false",
					["version"] = 2,
					["orientation"] = "DOWN",
					["maxdurationfilter"] = 3000,
					["name"] = "ab1",
					["unitfilter"] = "",
				}, -- [2]
			},
		},
		["Status_Health"] = {
			["ty"] = "StatusWindow",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "HP Status",
					["bkdColor"] = {
						["a"] = 0.5,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Raid Status DataSource",
				}, -- [2]
				{
					["feature"] = "Stat Frames: Bar",
					["h"] = "14",
					["fsz"] = 8,
					["tdx"] = 60,
					["w"] = "120",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["axis"] = 1,
					["cols"] = 1,
					["dxn"] = 1,
				}, -- [4]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Raid_Health_stc",
				}, -- [5]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Healer_Health_stc",
				}, -- [6]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Dps_Health_stc",
				}, -- [7]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Tank_health_stc",
				}, -- [8]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.3,
					["slot"] = "RepaintAll",
				}, -- [9]
				{
					["feature"] = "Description",
					["description"] = "Health statistics",
				}, -- [10]
			},
		},
		["Warlock_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Warlock",
				["color"] = {
					["a"] = 1,
					["r"] = 0.1843137254901961,
					["g"] = 0,
					["b"] = 0.611764705882353,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Warlock_fset",
					},
				},
				["sv"] = 2,
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Warlock_fset",
					},
				},
			},
		},
		["Druid_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Druid_fset",
					},
				},
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Druid",
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Druid_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0.7333333333333334,
					["g"] = 0.2784313725490195,
					["b"] = 0.06666666666666665,
				},
				["texture"] = "",
			},
		},
		["Warrior_Shout"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Warrior_Shout_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Warrior_Shout_mb",
				}, -- [4]
			},
		},
		["Shaman_Totems9"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems9_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Not_Flask_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 17626,
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 17627,
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 17628,
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 17629,
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28518,
						}, -- [2]
					}, -- [2]
				}, -- [6]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28519,
						}, -- [2]
					}, -- [2]
				}, -- [7]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28520,
						}, -- [2]
					}, -- [2]
				}, -- [8]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28521,
						}, -- [2]
					}, -- [2]
				}, -- [9]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28540,
						}, -- [2]
					}, -- [2]
				}, -- [10]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 33053,
						}, -- [2]
					}, -- [2]
				}, -- [11]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 42735,
						}, -- [2]
					}, -- [2]
				}, -- [12]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 40567,
						}, -- [2]
					}, -- [2]
				}, -- [13]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 40568,
						}, -- [2]
					}, -- [2]
				}, -- [14]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 40572,
						}, -- [2]
					}, -- [2]
				}, -- [15]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 40573,
						}, -- [2]
					}, -- [2]
				}, -- [16]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 40575,
						}, -- [2]
					}, -- [2]
				}, -- [17]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 40576,
						}, -- [2]
					}, -- [2]
				}, -- [18]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 41608,
						}, -- [2]
					}, -- [2]
				}, -- [19]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 41609,
						}, -- [2]
					}, -- [2]
				}, -- [20]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 41610,
						}, -- [2]
					}, -- [2]
				}, -- [21]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 41611,
						}, -- [2]
					}, -- [2]
				}, -- [22]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 46837,
						}, -- [2]
					}, -- [2]
				}, -- [23]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 46839,
						}, -- [2]
					}, -- [2]
				}, -- [24]
			},
		},
		["Dps_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Dps_fset",
						["class"] = "file",
					},
					["qty"] = "smp",
				},
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.5372549019607842,
					["g"] = 0,
					["r"] = 0.6352941176470583,
				},
				["name"] = "DPS",
				["pct"] = 1,
				["sv"] = 1,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Dps_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0.7607843137254902,
					["g"] = 0.2980392156862746,
					["r"] = 0,
				},
				["texture"] = "",
			},
		},
		["Mage_Buff_Arcane_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				1459, -- [1]
				23028, -- [2]
				61024, -- [3]
				61316, -- [4]
			},
		},
		["Priest_Buff_Fortitude_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "buff",
						["buff"] = 79105,
					}, -- [2]
				}, -- [2]
			},
		},
		["Druid_EclipseBar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "test",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Druid_EclipseBar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Player_Buff_Icon"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_Buff_Icon_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["switchvehicle"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Priest_Buff_POM"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Prayer of mending",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_POM_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Set",
					["rostertype"] = "RAID&RAIDPET",
					["set"] = {
						["class"] = "mybuff",
						["buff"] = 41635,
					},
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["countTitle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["cols"] = 1,
				}, -- [4]
			},
		},
		["Heal_Done_tm"] = {
			["ty"] = "TableMeter",
			["version"] = 1,
			["data"] = {
				["dtypes"] = {
					true, -- [1]
				},
				["etypes"] = {
					[8] = true,
				},
			},
		},
		["Priest_Buff_Serendipity_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 63735,
					["name"] = "aurai",
					["auraType"] = "BUFFS",
				}, -- [1]
				{
					["feature"] = "base_default",
					["h"] = 20,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 100,
				}, -- [2]
				{
					["number"] = "aurai_stack",
					["rows"] = 1,
					["feature"] = "custom_icons",
					["iconspx"] = 5,
					["color4"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.1529411764705883,
						["b"] = 1,
					},
					["ButtonSkinOffset"] = 3,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["usebs"] = true,
					["h"] = 20,
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.1529411764705883,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.1529411764705883,
						["b"] = 1,
					},
					["name"] = "customicon1",
					["color3"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.1529411764705883,
						["b"] = 1,
					},
					["drawLayer"] = "ARTWORK",
					["orientation"] = "RIGHT",
					["version"] = 1,
					["color5"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.1529411764705883,
						["b"] = 1,
					},
					["nIcons"] = 5,
				}, -- [3]
			},
		},
		["Logs_Me_tl"] = {
			["ty"] = "TableLog",
			["version"] = 1,
			["data"] = {
				["targ"] = "Player",
				["src"] = "Player",
				["filter"] = 1,
				["etypes"] = {
					true, -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
					true, -- [5]
					true, -- [6]
					true, -- [7]
					true, -- [8]
					true, -- [9]
					nil, -- [10]
					nil, -- [11]
					nil, -- [12]
					true, -- [13]
					true, -- [14]
					true, -- [15]
					true, -- [16]
					true, -- [17]
					true, -- [18]
					true, -- [19]
					true, -- [20]
					true, -- [21]
					true, -- [22]
					true, -- [23]
					true, -- [24]
					true, -- [25]
					true, -- [26]
					nil, -- [27]
					true, -- [28]
					true, -- [29]
					true, -- [30]
					true, -- [31]
				},
				["size"] = 1000,
			},
		},
		["Shaman_Totems9_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 180,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 36,
				}, -- [1]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_earth",
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemearth_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_onix",
					["timerVar"] = "totemearth",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [4]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "earth",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "36",
					["flo"] = 3,
					["version"] = 1,
				}, -- [5]
				{
					["name"] = "texcd_Fire",
					["gt"] = "",
					["version"] = 1,
					["externalButtonSkin"] = "bs_onix",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["tex"] = "totemfire_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemfire",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["h"] = 36,
					["name"] = "fire",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [7]
				{
					["name"] = "texcd_water",
					["gt"] = "",
					["version"] = 1,
					["externalButtonSkin"] = "bs_onix",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["tex"] = "totemwater_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemwater",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["h"] = 36,
					["name"] = "water",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [9]
				{
					["name"] = "texcd_air",
					["gt"] = "",
					["version"] = 1,
					["externalButtonSkin"] = "bs_onix",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -108,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["tex"] = "totemair_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemair",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [10]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -108,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "air",
					["h"] = "36",
					["flo"] = 3,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["h"] = 36,
					["name"] = "remove",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -144,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [13]
			},
		},
		["Range_40plus_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_15_30_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_30_40_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"ol", -- [1]
				}, -- [5]
			},
		},
		["Minimap_Main2_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 160,
					["version"] = 1,
					["w"] = 160,
					["alpha"] = 1,
				}, -- [1]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "160",
					["feature"] = "texture",
					["h"] = "160",
					["version"] = 1,
					["name"] = "tex1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\AddOns\\RDX_mediapack\\minimap\\Border-Blizzard-Square",
					},
				}, -- [2]
				{
					["blipType"] = "Blizzard",
					["maskType"] = "Square",
					["owner"] = "decor",
					["w"] = "140",
					["feature"] = "minimap",
					["h"] = "140",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 10,
						["dy"] = -10,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["font"] = {
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Bazooka.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
						["flags"] = "OUTLINE",
						["cg"] = 0.7764705882352941,
						["justifyH"] = "LEFT",
						["cb"] = 0.6901960784313725,
						["title"] = "Default",
						["name"] = "Default",
						["ca"] = 1,
						["cr"] = 0.3843137254901961,
					},
					["name"] = "minimap1",
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "260",
					["feature"] = "txt_other",
					["font"] = {
						["size"] = 12,
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "CENTER",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["name"] = "otxt1",
					["h"] = "14",
					["ty"] = "mapzonetext",
				}, -- [4]
			},
		},
		["Raid_Group3"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 3",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group3",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 40,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Arena_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Arena_Main_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "ARENA",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Arena_Main_fset",
					},
				}, -- [3]
				{
					["feature"] = "Arena Layout",
					["axis"] = 1,
					["cols"] = 1,
					["dxn"] = 1,
				}, -- [4]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Arena_Main_mb",
				}, -- [6]
			},
		},
		["Shaman_Totems6"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems6_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Overheal_Done_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["vname"] = "cs3032014",
						["op"] = "tablemeter",
						["path"] = "WoWRDX:Overheal_Done_tm",
					}, -- [1]
				},
				["set"] = {
					["file"] = "WoWRDX:Overheal_Done_fset",
					["class"] = "file",
				},
			},
		},
		["Deathknight_Runes2"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes2_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ActionBarVehicle"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBarVehicle_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Debuff_Disease_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "debuff",
						["buff"] = "@disease",
					}, -- [2]
				}, -- [2]
			},
		},
		["Party_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"mygroup", -- [1]
				}, -- [2]
				{
					"not", -- [1]
					{
						"me", -- [1]
					}, -- [2]
				}, -- [3]
			},
		},
		["Target_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Target_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["unitWatch"] = 1,
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "target",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [4]
			},
		},
		["Player_Debuff_Bar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_Debuff_Bar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["switchvehicle"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Deathknight_Runes7"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes7_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Not_Food_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 35272,
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 43722,
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 43730,
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 43763,
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 44106,
						}, -- [2]
					}, -- [2]
				}, -- [6]
			},
		},
		["Druid_Buff_Wild"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Wild",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0.7803921568627451,
						["g"] = 0.3058823529411765,
						["b"] = 0.6784313725490196,
					},
					["defaultbuttons"] = 1,
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Druid_Buff_Wild_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["class"] = "group",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["bkt"] = 1,
					["countTitle"] = 1,
					["dxn"] = 1,
					["cols"] = 25,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Druid_Buff_Wild_mb",
				}, -- [5]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [6]
			},
		},
		["Power_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [2]
				{
					["energyColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0.75,
					},
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 1,
					},
					["rageColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 90,
					["ph"] = 1,
				}, -- [5]
				{
					["frac"] = "fm",
					["owner"] = "Base",
					["w"] = "90",
					["feature"] = "statusbar_horiz",
					["h"] = "14",
					["version"] = 1,
					["colorVar"] = "powerColor",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "ppbar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [6]
				{
					["owner"] = "Base",
					["w"] = "50",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["name"] = "np",
					["feature"] = "txt_np",
					["h"] = "14",
				}, -- [7]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["h"] = "14",
					["ty"] = "fdld",
					["version"] = 1,
				}, -- [8]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["name"] = "text_mp_percent",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["h"] = "14",
					["ty"] = "mpp",
					["version"] = 1,
				}, -- [9]
			},
		},
		["Raid_Pet_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"raidpetsecure", -- [1]
			},
		},
		["Target_Main_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 76,
					["version"] = 1,
					["w"] = 206,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -30,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_plife",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_plife",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["ka"] = 0.7119999825954437,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bb"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [5]
				{
					["feature"] = "var_pred_health",
				}, -- [6]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 0.903999999165535,
						["r"] = 0.04313725490196078,
						["g"] = 1,
						["b"] = 0,
					},
				}, -- [7]
				{
					["frac"] = "pfh",
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_plife",
					["w"] = "200",
					["h"] = "21",
					["sublevel"] = 1,
					["colorVar"] = "green",
					["name"] = "sb_plife",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [8]
				{
					["feature"] = "commentline",
				}, -- [9]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_life",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [10]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [11]
				{
					["neutralColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyDruidColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.49,
						["b"] = 0.04,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["r"] = 0.58,
						["g"] = 0.51,
						["b"] = 0.79,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["r"] = 0.77,
						["g"] = 0.12,
						["b"] = 0.23,
					},
					["friendlyMageColor"] = {
						["a"] = 1,
						["r"] = 0.41,
						["g"] = 0.8,
						["b"] = 0.94,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "hostilityclassColor",
					["friendlyPaladinColor"] = {
						["a"] = 1,
						["r"] = 0.96,
						["g"] = 0.55,
						["b"] = 0.73,
					},
					["friendlyRogueColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.96,
						["b"] = 0.41,
					},
					["hostileColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.15,
						["b"] = 0,
					},
					["friendlyShamanColor"] = {
						["a"] = 1,
						["r"] = 0.14,
						["g"] = 0.34,
						["b"] = 1,
					},
					["friendlyHunterColor"] = {
						["a"] = 1,
						["r"] = 0.67,
						["g"] = 0.83,
						["b"] = 0.45,
					},
					["friendlyWarriorColor"] = {
						["a"] = 1,
						["r"] = 0.78,
						["g"] = 0.61,
						["b"] = 0.43,
					},
				}, -- [12]
				{
					["interpolate"] = 1,
					["frac"] = "fh",
					["sublevel"] = 2,
					["owner"] = "sf_life",
					["w"] = "200",
					["colorVar"] = "hostilityclassColor",
					["drawLayer"] = "ARTWORK",
					["h"] = "21",
					["name"] = "sb_life",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [13]
				{
					["txt"] = "pheal",
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 12,
					},
					["name"] = "text_pheal",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["ty"] = "hptxt2",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["name"] = "Default",
						["title"] = "Default",
						["sy"] = -1,
						["size"] = 10,
					},
					["name"] = "text_vie",
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 12,
					},
					["name"] = "text_dead",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["h"] = "14",
					["ty"] = "fdld",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 12,
					},
					["name"] = "text_mob",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["h"] = "14",
					["ty"] = "mobtype",
				}, -- [17]
				{
					["feature"] = "commentline",
				}, -- [18]
				{
					["feature"] = "Subframe",
					["h"] = "16",
					["name"] = "sf_mana",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -23,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [19]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["edgeSize"] = 8,
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["_border"] = "straight",
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bb"] = 0,
						["kg"] = 0,
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [20]
				{
					["energyColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.5450980392156862,
						["b"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.5,
						["r"] = 1,
					},
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 1,
					},
					["rageColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [21]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [22]
				{
					["frac"] = "fm",
					["flOffset"] = 2,
					["owner"] = "sf_mana",
					["w"] = "200",
					["h"] = "10",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "powerColor",
					["version"] = 1,
					["interpolate"] = 1,
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_power",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [23]
				{
					["owner"] = "sf_mana",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "mptxt",
					["name"] = "text_mana",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["version"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["h"] = "14",
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = "39",
					["name"] = "sf_sup",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 3,
				}, -- [26]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_sup",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 20,
						["ba"] = 0,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bg"] = 1,
						["bb"] = 1,
						["br"] = 1,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [27]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "aggro",
					["set"] = {
						["class"] = "ags",
					},
				}, -- [28]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "red",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [29]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "nocolor",
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [30]
				{
					["condVar"] = "aggro_flag",
					["name"] = "aggrocolour",
					["colorVar1"] = "red",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "nocolor",
				}, -- [31]
				{
					["feature"] = "Backdrop Border Colorizer",
					["owner"] = "sf_sup",
					["color"] = "aggrocolour",
					["flag"] = "true",
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "30",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -3,
						["dy"] = -3,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "30",
					["drawLayer"] = "ARTWORK",
				}, -- [34]
				{
					["owner"] = "pdt",
					["w"] = "30",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 15,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["h"] = "30",
					["ty"] = "level",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["h"] = "30",
					["version"] = 1,
					["feature"] = "txt_np",
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["name"] = "np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 15,
					},
				}, -- [36]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_icons",
					["iconspx"] = 2,
					["cd"] = {
						["Offsety"] = 0,
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 7,
						},
						["TimerType"] = "COOLDOWN",
						["offsety"] = "0",
						["Offsetx"] = 0,
						["offsetx"] = "10",
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["anchor"] = {
						["dx"] = 4,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["maxdurationfilter"] = "",
					["mindurationfilter"] = "",
					["auraType"] = "DEBUFFS",
					["owner"] = "pdt",
					["playerauras"] = 1,
					["usebs"] = true,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
					["name"] = "debuff",
					["size"] = 12,
					["orientation"] = "RIGHT",
					["nIcons"] = 10,
					["ButtonSkinOffset"] = 0,
					["unitfilter"] = "",
				}, -- [37]
				{
					["mover"] = 1,
					["w"] = 206,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "",
					["secure"] = 1,
					["h"] = 76,
				}, -- [38]
			},
		},
		["Arena_Main_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"arena", -- [1]
				true, -- [2]
				true, -- [3]
			},
		},
		["Buff_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				33778, -- [1]
				29166, -- [2]
				6346, -- [3]
				34477, -- [4]
				10060, -- [5]
				20711, -- [6]
				"Prière de guérison", -- [7]
				"Rénovation", -- [8]
				"Détournement", -- [9]
			},
		},
		["Priest_Buff_Fortitude_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79105,
				},
			},
		},
		["Player_SecureBuff_Icon"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_SecureBuff_Icon_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["switchvehicle"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Damage_Done_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"nidmask", -- [1]
				}, -- [2]
				{
					"tablemeter", -- [1]
					"WoWRDX:Damage_Done_tm", -- [2]
					1, -- [3]
					10000000, -- [4]
				}, -- [3]
			},
		},
		["Priest_Buff_Fortitude"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Fortitude",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0.7803921568627451,
						["g"] = 0.5333333333333333,
						["r"] = 0.2156862745098039,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_Fortitude_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Raid_fset",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["countTitle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 25,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Priest_Buff_Fortitude_mb",
				}, -- [5]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [6]
			},
		},
		["Dispell_Grid_Data_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"groups", -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
					true, -- [5]
					true, -- [6]
					true, -- [7]
					true, -- [8]
					true, -- [9]
				}, -- [2]
				{
					"classes", -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
					true, -- [5]
					true, -- [6]
					true, -- [7]
					true, -- [8]
					true, -- [9]
					true, -- [10]
				}, -- [3]
			},
		},
		["Target_Buff_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 45,
					["version"] = 1,
					["w"] = 300,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 10,
					["fontst"] = {
						["size"] = 14,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["sy"] = -1,
						["sb"] = 0,
						["flags"] = "THICKOUTLINE",
						["sr"] = 0,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["size"] = 10,
							["name"] = "Default",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
							["justifyV"] = "CENTER",
							["title"] = "Default",
							["flags"] = "OUTLINE",
							["cg"] = 0.7372549019607844,
							["sy"] = 0,
							["cb"] = 0.1333333333333333,
							["justifyH"] = "CENTER",
							["sx"] = 0,
							["ca"] = 1,
							["cr"] = 1,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["UpdateSpeed"] = 0.1,
						["Offsetx"] = 0,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 5,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 14,
					["nIcons"] = 20,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "decor",
					["filterNameList"] = {
					},
					["size"] = 30,
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "LEFT",
					["maxdurationfilter"] = "",
					["smooth"] = 1,
					["unitfilter"] = "",
				}, -- [2]
			},
		},
		["Deathknight_Runes3"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes3_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Raid_Group8"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 8",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group8",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["cols"] = 40,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Hunter_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"classes", -- [1]
					[10] = true,
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Raid_Health_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["qty"] = "shp",
					["set"] = {
						["class"] = "group",
					},
				},
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["name"] = "Raid HP",
				["max"] = {
					["qty"] = "smaxhp",
					["set"] = {
						["class"] = "group",
					},
				},
				["sv"] = 1,
				["pct"] = 1,
				["color"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["texture"] = "",
			},
		},
		["Healer_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"ol", -- [1]
				}, -- [2]
				{
					"role", -- [1]
					[4] = true,
				}, -- [3]
			},
		},
		["Priest_Buff_Shadow_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "unitInRange30",
					["set"] = {
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
						["class"] = "file",
					},
				}, -- [2]
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "aurai",
					["cd"] = 79107,
					["auraType"] = "BUFFS",
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["ph"] = 1,
					["w"] = 80,
					["alpha"] = 1,
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "13",
					["name"] = "statusBar",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [6]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "VFL.Hundredths",
					["statusBar"] = "statusBar",
					["text"] = "",
					["texIcon"] = "",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "aurai_aura",
					["TEIExpireState"] = "Hide",
				}, -- [7]
				{
					["feature"] = "commentline",
				}, -- [8]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "high",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [9]
				{
					["owner"] = "high",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_group",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["version"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 9,
					},
					["ty"] = "gn",
				}, -- [10]
				{
					["owner"] = "high",
					["w"] = "BaseWidth",
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
					},
					["name"] = "np",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["h"] = "BaseHeight",
					["classColor"] = 1,
					["version"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "high",
					["w"] = "80",
					["feature"] = "texture",
					["h"] = "13",
					["name"] = "tex_range",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [13]
				{
					["color"] = {
						["a"] = 0.7430000007152557,
						["r"] = 0.8313725490196078,
						["g"] = 0.01568627450980392,
						["b"] = 0,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [14]
				{
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["condVar"] = "unitInRange30_flag",
					["name"] = "range",
					["colorVar1"] = "red",
					["colorVar2"] = "alpha",
					["feature"] = "ColorVariable: Conditional Color",
				}, -- [16]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "true",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [17]
			},
		},
		["Priest_Buff_VampiricEmbrace_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 15286,
					["name"] = "auraia",
					["auraType"] = "BUFFS",
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.2156862745098039,
						["g"] = 0.192156862745098,
						["b"] = 1,
					},
					["name"] = "blue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["hlt"] = 1,
					["w"] = 80,
					["alpha"] = 1,
					["ph"] = 1,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "subframe",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["frac"] = "",
					["owner"] = "subframe",
					["w"] = "66",
					["feature"] = "statusbar_horiz",
					["h"] = "BaseHeight",
					["version"] = 1,
					["colorVar"] = "blue",
					["anchor"] = {
						["dx"] = 14,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "statusBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [5]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "subframe",
					["w"] = "14",
					["feature"] = "texture",
					["h"] = "14",
					["version"] = 1,
					["name"] = "tex1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["name"] = "customText",
				}, -- [7]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "statusBar",
					["text"] = "customText",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TEIExpireState"] = "Default",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "auraia_icon",
					["txt"] = "",
					["timerVar"] = "auraia_aura",
					["texIcon"] = "tex1",
				}, -- [8]
				{
					["feature"] = "shader_showhide",
					["owner"] = "subframe",
					["version"] = 1,
					["flag"] = "auraia_possible",
				}, -- [9]
			},
		},
		["Debuff_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Primary_fset",
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Secondary_fset",
					}, -- [2]
				}, -- [3]
			},
		},
		["infoAuthorEmail"] = "",
		["Target_Buff"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Target_Buff_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "target",
				}, -- [3]
			},
		},
		["Player_Main_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 76,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 206,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -30,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_plife",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_plife",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["edgeSize"] = 8,
						["kb"] = 0,
						["tile"] = false,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["bb"] = 0,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_border"] = "straight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["br"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [5]
				{
					["feature"] = "var_pred_health",
				}, -- [6]
				{
					["color"] = {
						["a"] = 0.903999999165535,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0.04313725490196078,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [7]
				{
					["frac"] = "pfh",
					["flOffset"] = 1,
					["owner"] = "sf_plife",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["version"] = 1,
					["colorVar"] = "green",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
					["name"] = "sb_plife",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [8]
				{
					["feature"] = "commentline",
				}, -- [9]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_life",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [10]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [11]
				{
					["neutralColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.75,
						["r"] = 0.75,
					},
					["friendlyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.75,
						["r"] = 0,
					},
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["b"] = 0.79,
						["g"] = 0.51,
						["r"] = 0.58,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["friendlyDruidColor"] = {
						["a"] = 1,
						["b"] = 0.04,
						["g"] = 0.49,
						["r"] = 1,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyMageColor"] = {
						["a"] = 1,
						["b"] = 0.94,
						["g"] = 0.8,
						["r"] = 0.41,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["b"] = 0.23,
						["g"] = 0.12,
						["r"] = 0.77,
					},
					["friendlyRogueColor"] = {
						["a"] = 1,
						["b"] = 0.41,
						["g"] = 0.96,
						["r"] = 1,
					},
					["friendlyPaladinColor"] = {
						["a"] = 1,
						["b"] = 0.73,
						["g"] = 0.55,
						["r"] = 0.96,
					},
					["hostileColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.15,
						["r"] = 0.75,
					},
					["name"] = "hostilityclassColor",
					["friendlyShamanColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.34,
						["r"] = 0.14,
					},
					["friendlyHunterColor"] = {
						["a"] = 1,
						["b"] = 0.45,
						["g"] = 0.83,
						["r"] = 0.67,
					},
					["friendlyWarriorColor"] = {
						["a"] = 1,
						["b"] = 0.43,
						["g"] = 0.61,
						["r"] = 0.78,
					},
				}, -- [12]
				{
					["frac"] = "fh",
					["flOffset"] = 2,
					["owner"] = "sf_life",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["version"] = 1,
					["colorVar"] = "hostilityclassColor",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "sb_life",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [13]
				{
					["txt"] = "pheal",
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["name"] = "text_pheal",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_vie",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["sx"] = 1,
						["sr"] = 0,
					},
					["ty"] = "hptxt2",
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_dead",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["ty"] = "fdld",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_mob",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["ty"] = "mobtype",
				}, -- [17]
				{
					["feature"] = "commentline",
				}, -- [18]
				{
					["feature"] = "Subframe",
					["h"] = "16",
					["name"] = "sf_mana",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -23,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [19]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["kb"] = 0,
						["tile"] = false,
						["bg"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["bb"] = 0,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["ka"] = 0.7119999825954437,
						["kg"] = 0,
						["br"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [20]
				{
					["energyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.75,
						["r"] = 0.75,
					},
					["rageColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.5,
						["r"] = 1,
					},
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.75,
						["r"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.5450980392156862,
						["r"] = 0,
					},
				}, -- [21]
				{
					["frac"] = "",
					["flOffset"] = 1,
					["owner"] = "sf_mana",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "10",
					["version"] = 1,
					["colorVar"] = "powerColor",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
					["name"] = "sb_power",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [22]
				{
					["script"] = "",
					["owner"] = "sf_mana",
					["w"] = "100",
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["name"] = "text_power",
					["h"] = "14",
				}, -- [23]
				{
					["statusBar"] = "sb_power",
					["text"] = "text_power",
					["version"] = 1,
					["feature"] = "shader_SPB",
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = "39",
					["name"] = "sf_sup",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 3,
				}, -- [26]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_sup",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 20,
						["ba"] = 0,
						["bb"] = 1,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["br"] = 1,
						["_backdrop"] = "none",
						["bg"] = 1,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [27]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "aggro",
					["set"] = {
						["class"] = "ags",
					},
				}, -- [28]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "red",
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
				}, -- [29]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "nocolor",
					["color"] = {
						["a"] = 0,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
				}, -- [30]
				{
					["condVar"] = "aggro_flag",
					["name"] = "aggrocolour",
					["colorVar1"] = "red",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "nocolor",
				}, -- [31]
				{
					["color"] = "aggrocolour",
					["owner"] = "sf_sup",
					["flag"] = "true",
					["feature"] = "Backdrop Border Colorizer",
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "30",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -3,
						["dy"] = -3,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "30",
					["drawLayer"] = "ARTWORK",
				}, -- [34]
				{
					["owner"] = "pdt",
					["w"] = "30",
					["feature"] = "txt_status",
					["h"] = "30",
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 15,
					},
					["ty"] = "level",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["font"] = {
						["size"] = 15,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "np",
					["h"] = "30",
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["feature"] = "txt_np",
					["version"] = 1,
				}, -- [36]
				{
					["feature"] = "Player Status Icon",
					["h"] = "15",
					["name"] = "sti",
					["ButtonSkinOffset"] = 5,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "15",
					["drawLayer"] = "ARTWORK",
				}, -- [37]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "76",
					["secure"] = 1,
					["name"] = "",
				}, -- [38]
			},
		},
		["Targettarget_Main_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 76,
					["version"] = 1,
					["w"] = 206,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -30,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_plife",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_plife",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["ka"] = 0.7119999825954437,
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_backdrop"] = "solid",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [5]
				{
					["feature"] = "var_pred_health",
				}, -- [6]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 0.903999999165535,
						["r"] = 0.04313725490196078,
						["g"] = 1,
						["b"] = 0,
					},
				}, -- [7]
				{
					["frac"] = "pfh",
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_plife",
					["w"] = "200",
					["h"] = "21",
					["sublevel"] = 1,
					["colorVar"] = "green",
					["name"] = "sb_plife",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [8]
				{
					["feature"] = "commentline",
				}, -- [9]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_life",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [10]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [11]
				{
					["neutralColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyDruidColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.49,
						["b"] = 0.04,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["r"] = 0.77,
						["g"] = 0.12,
						["b"] = 0.23,
					},
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["r"] = 0.58,
						["g"] = 0.51,
						["b"] = 0.79,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["friendlyMageColor"] = {
						["a"] = 1,
						["r"] = 0.41,
						["g"] = 0.8,
						["b"] = 0.94,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyPaladinColor"] = {
						["a"] = 1,
						["r"] = 0.96,
						["g"] = 0.55,
						["b"] = 0.73,
					},
					["name"] = "hostilityclassColor",
					["hostileColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.15,
						["b"] = 0,
					},
					["friendlyRogueColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.96,
						["b"] = 0.41,
					},
					["friendlyShamanColor"] = {
						["a"] = 1,
						["r"] = 0.14,
						["g"] = 0.34,
						["b"] = 1,
					},
					["friendlyHunterColor"] = {
						["a"] = 1,
						["r"] = 0.67,
						["g"] = 0.83,
						["b"] = 0.45,
					},
					["friendlyWarriorColor"] = {
						["a"] = 1,
						["r"] = 0.78,
						["g"] = 0.61,
						["b"] = 0.43,
					},
				}, -- [12]
				{
					["frac"] = "fh",
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_life",
					["w"] = "200",
					["h"] = "21",
					["sublevel"] = 2,
					["colorVar"] = "hostilityclassColor",
					["name"] = "sb_life",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [13]
				{
					["txt"] = "pheal",
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_pheal",
					["h"] = "14",
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_vie",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["ty"] = "hptxt2",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_dead",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["ty"] = "fdld",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 12,
					},
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_mob",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["ty"] = "mobtype",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 12,
					},
				}, -- [17]
				{
					["feature"] = "commentline",
				}, -- [18]
				{
					["feature"] = "Subframe",
					["h"] = "16",
					["name"] = "sf_mana",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -23,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [19]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["edgeSize"] = 8,
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["_border"] = "straight",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_backdrop"] = "solid",
						["kg"] = 0,
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [20]
				{
					["energyColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.5450980392156862,
						["b"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.5,
						["r"] = 1,
					},
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 1,
					},
					["rageColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [21]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [22]
				{
					["frac"] = "fm",
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_mana",
					["w"] = "200",
					["h"] = "10",
					["sublevel"] = 1,
					["colorVar"] = "powerColor",
					["name"] = "sb_power",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [23]
				{
					["owner"] = "sf_mana",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_mana",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["version"] = 1,
					["ty"] = "mptxt",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = "39",
					["name"] = "sf_sup",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 3,
				}, -- [26]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_sup",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 20,
						["ba"] = 0,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bg"] = 1,
						["bb"] = 1,
						["br"] = 1,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [27]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "aggro",
					["set"] = {
						["class"] = "ags",
					},
				}, -- [28]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "red",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [29]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "nocolor",
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [30]
				{
					["condVar"] = "aggro_flag",
					["name"] = "aggrocolour",
					["colorVar1"] = "red",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "nocolor",
				}, -- [31]
				{
					["feature"] = "Backdrop Border Colorizer",
					["owner"] = "sf_sup",
					["color"] = "aggrocolour",
					["flag"] = "true",
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "30",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -3,
						["dy"] = -3,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "30",
					["drawLayer"] = "ARTWORK",
				}, -- [34]
				{
					["owner"] = "pdt",
					["w"] = "30",
					["feature"] = "txt_status",
					["h"] = "30",
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["ty"] = "level",
					["font"] = {
						["size"] = 15,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 15,
					},
					["version"] = 1,
					["feature"] = "txt_np",
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 8,
					["name"] = "np",
					["h"] = "30",
				}, -- [36]
				{
					["rows"] = 1,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 2,
					["cd"] = {
						["Font"] = {
							["sr"] = 0,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["sx"] = 1,
							["sa"] = 1,
							["sg"] = 0,
							["name"] = "Default",
							["sb"] = 0,
							["sy"] = -1,
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["HideText"] = 0,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 4,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["nIcons"] = 10,
					["mindurationfilter"] = "",
					["auraType"] = "DEBUFFS",
					["owner"] = "pdt",
					["playerauras"] = 1,
					["usebs"] = true,
					["filterNameList"] = {
					},
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["name"] = "debuff",
					["size"] = 12,
					["orientation"] = "RIGHT",
					["version"] = 1,
					["maxdurationfilter"] = "",
					["unitfilter"] = "",
				}, -- [37]
				{
					["mover"] = 1,
					["w"] = 206,
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "",
					["h"] = 76,
					["flo"] = 3,
				}, -- [38]
			},
		},
		["Paladin_HolyPower"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Paladin_HolyPower_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Debuff_Secondary_fset"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["targetpath_5"] = "WoWRDX:None_fset",
				["class"] = "class",
				["targetpath_7"] = "WoWRDX:None_fset",
				["targetpath_8"] = "WoWRDX:None_fset",
				["targetpath_2"] = "WoWRDX:Debuff_Curse_fset",
				["targetpath_3"] = "WoWRDX:Debuff_Disease_fset",
				["targetpath_4"] = "WoWRDX:None_fset",
				["targetpath_1"] = "WoWRDX:Debuff_Disease_fset",
				["targetpath_10"] = "WoWRDX:None_fset",
				["targetpath_9"] = "WoWRDX:None_fset",
				["targetpath_6"] = "WoWRDX:None_fset",
			},
		},
		["Priest_Buff_Fortitude_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				79105, -- [1]
			},
		},
		["Range_0_70_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["n"] = 4,
						["class"] = "frs",
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Druid_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"classes", -- [1]
					[3] = true,
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Player_Debuff_Icon"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_Debuff_Icon_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["switchvehicle"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Priest_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"classes", -- [1]
					true, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["infoAuthorRealm"] = "Rashgarroth",
		["XpBar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:XpBar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ActionBar2_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 40,
					["version"] = 1,
					["w"] = 480,
					["alpha"] = 1,
				}, -- [1]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["cr"] = 0.2980392156862745,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.3882352941176471,
						["name"] = "Default",
						["cb"] = 1,
						["sy"] = 0,
						["justifyH"] = "RIGHT",
						["title"] = "Default",
						["size"] = 10,
					},
					["feature"] = "actionbar",
					["iconspx"] = 0,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["owner"] = "decor",
					["fontmacro"] = {
						["cr"] = 1,
						["flags"] = "OUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["sx"] = 0,
						["title"] = "Default",
						["size"] = 8,
					},
					["fontkey"] = {
						["size"] = 10,
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["title"] = "Default",
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["cb"] = 0.1058823529411765,
						["flags"] = "THICKOUTLINE",
						["cr"] = 1,
					},
					["headerstateCustom"] = "",
					["abid"] = 13,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "RIGHT",
					["size"] = 36,
					["headerstateType"] = "None",
					["hidebs"] = 1,
				}, -- [2]
			},
		},
		["Bags_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 40,
					["version"] = 1,
					["w"] = 188,
					["alpha"] = 1,
				}, -- [1]
				{
					["owner"] = "decor",
					["rows"] = 1,
					["feature"] = "bagsbar",
					["iconspx"] = 2,
					["name"] = "bbar",
					["orientation"] = "RIGHT",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["iconspy"] = 0,
					["nIcons"] = 6,
				}, -- [2]
			},
		},
		["Dead_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.01176470588235294,
					["g"] = 0,
					["r"] = 0.4705882352941178,
				},
				["name"] = "Dead",
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Dead_fset",
						["class"] = "file",
					},
					["qty"] = "ssz",
				},
				["max"] = {
					["set"] = {
						["class"] = "group",
					},
					["qty"] = "ssz",
				},
				["sv"] = 3,
				["color"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["texture"] = "",
			},
		},
		["Priest_Buff_Shadow_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				79107, -- [1]
			},
		},
		["Rogue_Combo_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 20,
					["version"] = 1,
					["w"] = 120,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Variable combo",
				}, -- [2]
				{
					["number"] = "combopoint",
					["rows"] = 1,
					["feature"] = "custom_icons",
					["iconspx"] = 5,
					["color4"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.08627450980392157,
						["b"] = 0.1098039215686275,
					},
					["ButtonSkinOffset"] = 3,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["nIcons"] = 5,
					["usebs"] = true,
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.08627450980392157,
						["b"] = 0.1098039215686275,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.08627450980392157,
						["b"] = 0.1098039215686275,
					},
					["drawLayer"] = "ARTWORK",
					["name"] = "customicon1",
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.08627450980392157,
						["b"] = 0.1098039215686275,
					},
					["orientation"] = "RIGHT",
					["version"] = 1,
					["color5"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.08627450980392157,
						["b"] = 0.1098039215686275,
					},
					["h"] = 20,
				}, -- [3]
			},
		},
		["Shaman_Totems5_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 50,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 144,
				}, -- [1]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_earth",
					["externalButtonSkin"] = "bs_simplesquare",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 6,
					["tex"] = "totemearth_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemearth",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [4]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["flo"] = 3,
					["name"] = "earth",
				}, -- [5]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_Fire",
					["externalButtonSkin"] = "bs_simplesquare",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 6,
					["tex"] = "totemfire_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemfire",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["flo"] = 3,
					["name"] = "fire",
				}, -- [7]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_water",
					["externalButtonSkin"] = "bs_simplesquare",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 6,
					["tex"] = "totemwater_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemwater",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["flo"] = 3,
					["name"] = "water",
				}, -- [9]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_air",
					["externalButtonSkin"] = "bs_simplesquare",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 6,
					["tex"] = "totemair_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemair",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [10]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "air",
					["secure"] = 1,
					["h"] = "36",
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = "144",
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "remove",
					["secure"] = 1,
					["h"] = "14",
				}, -- [13]
			},
		},
		["ActionBarStance"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBarStance_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["MiniMap_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 144,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 144,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "high",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [2]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "high",
					["w"] = "144",
					["feature"] = "texture",
					["h"] = "144",
					["version"] = 1,
					["name"] = "tex1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\AddOns\\RDX_mediapack\\minimap\\Border-Blizzard-Round",
					},
				}, -- [3]
				{
					["blipType"] = "Blizzard",
					["maskType"] = "Blizzard",
					["owner"] = "decor",
					["w"] = "130",
					["feature"] = "minimap",
					["h"] = "130",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 8,
						["dy"] = -8,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "minimap1",
					["font"] = {
						["cr"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Italic.ttf",
						["ca"] = 1,
						["cb"] = 1,
						["flags"] = "THICKOUTLINE",
						["cg"] = 1,
						["name"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["justifyH"] = "CENTER",
						["title"] = "Default",
						["size"] = 14,
					},
				}, -- [4]
			},
		},
		["MainMenu_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 38,
					["version"] = 1,
					["w"] = 264,
					["alpha"] = 1,
				}, -- [1]
				{
					["owner"] = "decor",
					["rows"] = 1,
					["feature"] = "menubar",
					["iconspx"] = -2,
					["name"] = "mbar",
					["orientation"] = "RIGHT",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["iconspy"] = 0,
					["nIcons"] = 10,
				}, -- [2]
			},
		},
		["Rez_Monitor_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "yellow",
					["color"] = {
						["a"] = 0.4638837575912476,
						["r"] = 0.788235294117647,
						["g"] = 0.7176470588235294,
						["b"] = 0,
					},
				}, -- [1]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 0.5088750422000885,
						["r"] = 0,
						["g"] = 0.407843137254902,
						["b"] = 0.0392156862745098,
					},
				}, -- [2]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "rezinc",
					["set"] = {
						["n"] = 1,
						["class"] = "rez",
					},
				}, -- [3]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "rezdone",
					["set"] = {
						["n"] = 2,
						["class"] = "rez",
					},
				}, -- [4]
				{
					["feature"] = "base_default",
					["h"] = 12,
					["version"] = 1,
					["w"] = 50,
					["alpha"] = 1,
				}, -- [5]
				{
					["feature"] = "txt_np",
					["h"] = "12",
					["name"] = "np",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "50",
					["version"] = 1,
				}, -- [6]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "texture",
					["h"] = "12",
					["version"] = 1,
					["name"] = "hlt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [7]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "rezinc_flag",
					["color"] = "yellow",
					["texture"] = "hlt",
				}, -- [8]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "rezdone_flag",
					["color"] = "green",
					["texture"] = "hlt",
				}, -- [9]
			},
		},
		["Heal_Done"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_HolyGuidance",
					},
					["title"] = "Healing Done",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["showtitlebar"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Heal_Done_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Heal_Done_sort",
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["countTitle"] = 1,
					["limit"] = 10,
					["dxn"] = 1,
					["axis"] = 1,
					["cols"] = 1,
				}, -- [4]
				{
					["feature"] = "Sort Editor",
				}, -- [5]
				{
					["feature"] = "FilterSet Editor",
				}, -- [6]
				{
					["feature"] = "TableMeter Editor",
					["path"] = "WoWRDX:Heal_Done_tm",
				}, -- [7]
			},
		},
		["Party_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 76,
					["version"] = 1,
					["w"] = 206,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -30,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_plife",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_plife",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["kg"] = 0,
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["_border"] = "straight",
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bb"] = 0,
						["edgeSize"] = 8,
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [5]
				{
					["feature"] = "var_pred_health",
				}, -- [6]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 0.903999999165535,
						["r"] = 0.04313725490196078,
						["g"] = 1,
						["b"] = 0,
					},
				}, -- [7]
				{
					["frac"] = "pfh",
					["flOffset"] = 0,
					["owner"] = "sf_plife",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["version"] = 1,
					["colorVar"] = "green",
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_plife",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [8]
				{
					["feature"] = "commentline",
				}, -- [9]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_life",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [10]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [11]
				{
					["neutralColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 0,
					},
					["friendlyDruidColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.49,
						["b"] = 0.04,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["r"] = 0.58,
						["g"] = 0.51,
						["b"] = 0.79,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyMageColor"] = {
						["a"] = 1,
						["r"] = 0.41,
						["g"] = 0.8,
						["b"] = 0.94,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["r"] = 0.77,
						["g"] = 0.12,
						["b"] = 0.23,
					},
					["name"] = "hostilityclassColor",
					["friendlyPaladinColor"] = {
						["a"] = 1,
						["r"] = 0.96,
						["g"] = 0.55,
						["b"] = 0.73,
					},
					["friendlyRogueColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.96,
						["b"] = 0.41,
					},
					["hostileColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.15,
						["b"] = 0,
					},
					["friendlyShamanColor"] = {
						["a"] = 1,
						["r"] = 0.14,
						["g"] = 0.34,
						["b"] = 1,
					},
					["friendlyHunterColor"] = {
						["a"] = 1,
						["r"] = 0.67,
						["g"] = 0.83,
						["b"] = 0.45,
					},
					["friendlyWarriorColor"] = {
						["a"] = 1,
						["r"] = 0.78,
						["g"] = 0.61,
						["b"] = 0.43,
					},
				}, -- [12]
				{
					["frac"] = "fh",
					["flOffset"] = 0,
					["owner"] = "sf_life",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["version"] = 1,
					["colorVar"] = "hostilityclassColor",
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_life",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [13]
				{
					["txt"] = "pheal",
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_pheal",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 12,
					},
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["ty"] = "hptxt2",
					["name"] = "text_vie",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["version"] = 1,
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_dead",
					["ty"] = "fdld",
					["h"] = "14",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_mob",
					["ty"] = "mobtype",
					["h"] = "14",
				}, -- [17]
				{
					["feature"] = "commentline",
				}, -- [18]
				{
					["feature"] = "Subframe",
					["h"] = "16",
					["name"] = "sf_mana",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -23,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [19]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [20]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["ka"] = 0.7119999825954437,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bb"] = 0,
						["edgeSize"] = 8,
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [21]
				{
					["feature"] = "ColorVariable: Unit PowerType Color",
					["rageColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.5,
						["r"] = 1,
					},
					["energyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.75,
						["r"] = 0.75,
					},
					["runeColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.75,
						["r"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.5450980392156862,
						["r"] = 0,
					},
				}, -- [22]
				{
					["frac"] = "fm",
					["flOffset"] = 0,
					["owner"] = "sf_mana",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "10",
					["version"] = 1,
					["colorVar"] = "powerColor",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
					["name"] = "sb_power",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [23]
				{
					["owner"] = "sf_mana",
					["w"] = "150",
					["feature"] = "txt_status",
					["ty"] = "mptxt",
					["name"] = "status_power",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["h"] = "14",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["version"] = 1,
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = "39",
					["name"] = "sf_sup",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 3,
				}, -- [26]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_sup",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 20,
						["ba"] = 0,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bg"] = 1,
						["bb"] = 1,
						["br"] = 1,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [27]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "aggro",
					["set"] = {
						["class"] = "ags",
					},
				}, -- [28]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "red",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [29]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "nocolor",
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [30]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "aggrocolour",
					["colorVar1"] = "red",
					["condVar"] = "aggro_flag",
					["colorVar2"] = "nocolor",
				}, -- [31]
				{
					["feature"] = "Backdrop Border Colorizer",
					["owner"] = "sf_sup",
					["color"] = "aggrocolour",
					["flag"] = "true",
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "30",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -3,
						["dy"] = -3,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "30",
					["drawLayer"] = "ARTWORK",
				}, -- [34]
				{
					["owner"] = "pdt",
					["w"] = "30",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 15,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["name"] = "status_text",
					["ty"] = "level",
					["h"] = "30",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 15,
					},
					["version"] = 1,
					["classColor"] = 1,
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["name"] = "np",
					["h"] = "30",
				}, -- [36]
				{
					["mover"] = 1,
					["w"] = 206,
					["feature"] = "hotspot",
					["flo"] = 3,
					["name"] = "",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["h"] = 76,
					["secure"] = 1,
				}, -- [37]
			},
		},
		["Combat_Logs_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 150,
					["version"] = 1,
					["w"] = 390,
					["alpha"] = 1,
				}, -- [1]
				{
					["tablelog"] = "WoWRDX:Logs_Me_tl",
					["owner"] = "decor",
					["w"] = "390",
					["feature"] = "combatlogs",
					["line"] = 15,
					["name"] = "combatlogs",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["spec"] = "{ title = \"Time\", width = 55, font = Fonts.Default },\n{ title = \"HP\", width = 50, font = Fonts.Default },\n{ title = \"Amt\", width = 50, font = Fonts.Default },\n{ title = \"Ability\", width = 180, font = Fonts.Default },\n{ title = \"Misc\", width = 55, font = Fonts.Default },\n\n\n\n",
					["h"] = "20",
				}, -- [2]
			},
		},
		["Priest_Buff_InnerFire"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Inner Fire",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_InnerFire",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.6392156862745098,
						["r"] = 1,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_InnerFire_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["clickable"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Priest_Buff_InnerFire_mb",
				}, -- [4]
			},
		},
		["Cooldowns_Used"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Cooldowns_Used_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ChatFrame4"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Chat 4",
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ChatFrame4_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Partytarget"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Targettarget_Main_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Party_fset",
					},
				}, -- [3]
				{
					["interval"] = 0.1,
					["suffix2"] = "targettarget",
					["suffix1"] = "target",
					["feature"] = "Secure Assists",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Player_Main_mb",
				}, -- [5]
			},
		},
		["ActionBarVehicle_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["w"] = 108,
					["alpha"] = 1,
				}, -- [1]
				{
					["showkey"] = 1,
					["nIcons"] = 3,
					["iconspy"] = 0,
					["fontkey"] = {
						["size"] = 10,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sy"] = 0,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["flags"] = "THICKOUTLINE",
						["cr"] = 1,
					},
					["orientation"] = "RIGHT",
					["rows"] = 1,
					["owner"] = "decor",
					["name"] = "vehiclebar",
					["feature"] = "vehiclebar",
					["iconspx"] = 2,
					["version"] = 1,
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["usebs"] = true,
					["size"] = 36,
				}, -- [2]
			},
		},
		["XpBar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Frac XP (fxp)",
				}, -- [1]
				{
					["feature"] = "var_isExhaustion",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "blue",
					["color"] = {
						["a"] = 1,
						["r"] = 0.2588235294117647,
						["g"] = 0.2627450980392157,
						["b"] = 1,
					},
				}, -- [4]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 1,
						["b"] = 0.2745098039215687,
						["g"] = 1,
						["r"] = 0.4313725490196079,
					},
				}, -- [5]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "xpcolor",
					["colorVar1"] = "blue",
					["condVar"] = "isExhaustion",
					["colorVar2"] = "green",
				}, -- [6]
				{
					["feature"] = "commentline",
				}, -- [7]
				{
					["feature"] = "base_default",
					["h"] = 15,
					["version"] = 1,
					["w"] = 200,
					["alpha"] = 1,
				}, -- [8]
				{
					["feature"] = "backdrop",
					["owner"] = "decor",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["tile"] = false,
						["ka"] = 1,
						["kb"] = 1,
						["kg"] = 0.7294117647058823,
						["kr"] = 0.7058823529411764,
					},
				}, -- [9]
				{
					["frac"] = "fxp",
					["flOffset"] = 0,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "statusbar_horiz",
					["h"] = "BaseHeight",
					["version"] = 1,
					["colorVar"] = "xpcolor",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "statusBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Dabs",
					},
				}, -- [10]
				{
					["txt"] = "fpxptxt",
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_dyn",
					["h"] = "BaseHeight",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["name"] = "infoText",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
				}, -- [11]
			},
		},
		["Priest_Buff_Shadow_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79107,
				},
			},
		},
		["Shaman_Totems6_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 50,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 144,
				}, -- [1]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["flags"] = "THICKOUTLINE",
							["name"] = "Default",
							["sx"] = 0,
							["justifyH"] = "CENTER",
							["title"] = "Default",
							["sy"] = 0,
							["size"] = 11,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = 0,
						["Offsetx"] = 1,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["gt"] = "",
					["name"] = "texcd_earth",
					["externalButtonSkin"] = "bs_default",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 2,
					["tex"] = "totemearth_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemearth",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [4]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "earth",
					["h"] = 36,
					["secure"] = 1,
				}, -- [5]
				{
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["flags"] = "THICKOUTLINE",
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 11,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = 0,
						["Offsetx"] = 1,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["gt"] = "",
					["name"] = "texcd_Fire",
					["externalButtonSkin"] = "bs_default",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 2,
					["tex"] = "totemfire_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemfire",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "fire",
					["h"] = 36,
					["secure"] = 1,
				}, -- [7]
				{
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["flags"] = "THICKOUTLINE",
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 11,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = 0,
						["Offsetx"] = 1,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["gt"] = "",
					["name"] = "texcd_water",
					["externalButtonSkin"] = "bs_default",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 2,
					["tex"] = "totemwater_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemwater",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "water",
					["h"] = 36,
					["secure"] = 1,
				}, -- [9]
				{
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["flags"] = "THICKOUTLINE",
							["justifyH"] = "CENTER",
							["sx"] = 0,
							["sy"] = 0,
							["name"] = "Default",
							["title"] = "Default",
							["size"] = 11,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = 0,
						["Offsetx"] = 1,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["gt"] = "",
					["name"] = "texcd_air",
					["externalButtonSkin"] = "bs_default",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 2,
					["tex"] = "totemair_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemair",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [10]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "air",
					["h"] = 36,
					["secure"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = 144,
					["feature"] = "hotspot",
					["h"] = 14,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["secure"] = 1,
					["flo"] = 3,
					["name"] = "remove",
				}, -- [13]
			},
		},
		["Range_0_15_ODM_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["file"] = "WoWRDX:Range_0_15_fset",
						["class"] = "file",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["n"] = 2,
							["class"] = "frs",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"nidmask", -- [1]
				}, -- [4]
				{
					"not", -- [1]
					{
						"me", -- [1]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"dead", -- [1]
					}, -- [2]
				}, -- [6]
			},
		},
		["Deathknight_Runes6"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes6_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Deathknight_Runes2_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 120,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 190,
				}, -- [1]
				{
					["feature"] = "Vars: Rune Info",
					["colors"] = {
						{
							["a"] = 1,
							["b"] = 0.2,
							["g"] = 0,
							["r"] = 1,
						}, -- [1]
						{
							["a"] = 1,
							["b"] = 0,
							["g"] = 1,
							["r"] = 0,
						}, -- [2]
						{
							["a"] = 1,
							["b"] = 1,
							["g"] = 0.6000000000000001,
							["r"] = 0,
						}, -- [3]
						{
							["a"] = 1,
							["b"] = 0.6000000000000001,
							["g"] = 0.3,
							["r"] = 0.6000000000000001,
						}, -- [4]
					},
					["TextureType"] = "Normal",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "rune1_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "180",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "rune1_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "none",
						["kr"] = 1,
					},
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune1_color",
					["version"] = 1,
					["h"] = 19,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune1_bar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Comet",
					},
				}, -- [6]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune1_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune1_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [7]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune1_bar",
					},
					["name"] = "rune1_timer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["title"] = "Default",
						["size"] = 9,
					},
				}, -- [8]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune1_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune1_text",
				}, -- [9]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune1_text",
					["textType"] = "Tenths",
					["timerVar"] = "rune1",
					["statusBar"] = "rune1_bar",
					["text"] = "rune1_timer",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "free_timer",
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune1_icon",
					["TTIDefaultState"] = "Default",
					["texIcon"] = "rune1_tex",
					["txt"] = "rune1_name",
				}, -- [10]
				{
					["feature"] = "commentline",
				}, -- [11]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune2_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [12]
				{
					["feature"] = "backdrop",
					["owner"] = "rune2_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["_backdrop"] = "solid",
						["kb"] = 0.016,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 1,
					},
				}, -- [13]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune2_color",
					["version"] = 1,
					["h"] = 19,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune2_bar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Comet",
					},
				}, -- [14]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune2_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune2_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [15]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["h"] = 14,
					["name"] = "rune2_timer",
				}, -- [16]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune2_text",
				}, -- [17]
				{
					["statusBar"] = "rune2_bar",
					["textInfo"] = "rune2_text",
					["timerVar"] = "rune2",
					["textType"] = "Tenths",
					["TEIDefaultState"] = "Default",
					["text"] = "rune2_timer",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "free_timer",
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune2_icon",
					["TTIDefaultState"] = "Default",
					["texIcon"] = "rune2_tex",
					["txt"] = "rune2_name",
				}, -- [18]
				{
					["feature"] = "commentline",
				}, -- [19]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune3_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [20]
				{
					["feature"] = "backdrop",
					["owner"] = "rune3_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 1,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [21]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune3_color",
					["version"] = 1,
					["h"] = 19,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune3_bar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Comet",
					},
				}, -- [22]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune3_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune3_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [23]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["h"] = 14,
					["name"] = "rune3_timer",
				}, -- [24]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune3_text",
				}, -- [25]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune3_text",
					["textType"] = "Tenths",
					["timerVar"] = "rune3",
					["txt"] = "rune3_name",
					["text"] = "rune3_timer",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "free_timer",
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune3_icon",
					["TTIDefaultState"] = "Default",
					["texIcon"] = "rune3_tex",
					["statusBar"] = "rune3_bar",
				}, -- [26]
				{
					["feature"] = "commentline",
				}, -- [27]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune4_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [28]
				{
					["feature"] = "backdrop",
					["owner"] = "rune4_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 1,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [29]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune4_color",
					["version"] = 1,
					["h"] = 19,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune4_bar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Comet",
					},
				}, -- [30]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune4_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune4_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [31]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune4_timer",
				}, -- [32]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune4_text",
				}, -- [33]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune4_text",
					["textType"] = "Tenths",
					["timerVar"] = "rune4",
					["txt"] = "rune4_name",
					["text"] = "rune4_timer",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "free_timer",
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune4_icon",
					["TTIDefaultState"] = "Default",
					["texIcon"] = "rune4_tex",
					["statusBar"] = "rune4_bar",
				}, -- [34]
				{
					["feature"] = "commentline",
				}, -- [35]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune5_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [36]
				{
					["feature"] = "backdrop",
					["owner"] = "rune5_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 1,
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["kr"] = 0,
					},
				}, -- [37]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune5_color",
					["version"] = 1,
					["h"] = 19,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune5_bar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Comet",
					},
				}, -- [38]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune5_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune5_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [39]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune5_timer",
				}, -- [40]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune5_text",
				}, -- [41]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune5_text",
					["textType"] = "Tenths",
					["timerVar"] = "rune5",
					["txt"] = "rune5_name",
					["text"] = "rune5_timer",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "free_timer",
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune5_icon",
					["TTIDefaultState"] = "Default",
					["texIcon"] = "rune5_tex",
					["statusBar"] = "rune5_bar",
				}, -- [42]
				{
					["feature"] = "commentline",
				}, -- [43]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune6_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [44]
				{
					["feature"] = "backdrop",
					["owner"] = "rune6_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 1,
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["kr"] = 0,
					},
				}, -- [45]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune6_color",
					["version"] = 1,
					["h"] = 19,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune6_bar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Comet",
					},
				}, -- [46]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune6_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune6_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [47]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune6_timer",
				}, -- [48]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "rune6_text",
				}, -- [49]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune6_text",
					["textType"] = "Tenths",
					["timerVar"] = "rune6",
					["txt"] = "rune6_name",
					["text"] = "rune6_timer",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "free_timer",
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune6_icon",
					["TTIDefaultState"] = "Default",
					["texIcon"] = "rune6_tex",
					["statusBar"] = "rune6_bar",
				}, -- [50]
			},
		},
		["Threat"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Threat",
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Ability_BackStab",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["showtitlebar"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Threat_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Threat_sort",
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["countTitle"] = 1,
					["limit"] = 10,
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "Sort Editor",
				}, -- [5]
				{
					["feature"] = "FilterSet Editor",
				}, -- [6]
			},
		},
		["Health_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["ph"] = true,
					["w"] = 90,
					["alpha"] = 1,
					["a"] = 1,
				}, -- [4]
				{
					["interpolate"] = 1,
					["frac"] = "fh",
					["owner"] = "Base",
					["w"] = "90",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "14",
					["name"] = "statusBar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [5]
				{
					["owner"] = "Base",
					["w"] = "50",
					["classColor"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["h"] = "14",
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [6]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 8,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["ty"] = "fdld",
					["h"] = "14",
				}, -- [7]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 8,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["name"] = "text_hp_percent",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["ty"] = "hpp",
					["h"] = "14",
				}, -- [8]
			},
		},
		["Deathknight_Runes1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 120,
					["version"] = 1,
					["w"] = 200,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Vars: Rune Info",
					["TextureType"] = "Normal",
					["colors"] = {
						{
							["a"] = 1,
							["b"] = 0.2,
							["g"] = 0,
							["r"] = 1,
						}, -- [1]
						{
							["a"] = 1,
							["b"] = 0,
							["g"] = 1,
							["r"] = 0,
						}, -- [2]
						{
							["a"] = 1,
							["b"] = 1,
							["g"] = 0.6000000000000001,
							["r"] = 0,
						}, -- [3]
						{
							["a"] = 1,
							["b"] = 0.6000000000000001,
							["g"] = 0.3,
							["r"] = 0.6000000000000001,
						}, -- [4]
					},
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "rune1_sf",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "180",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "rune1_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "none",
						["kr"] = 1,
					},
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune1_color",
					["name"] = "rune1_bar",
					["h"] = 19,
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour5",
					},
				}, -- [6]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune1_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [7]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["justifyH"] = "RIGHT",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune1_bar",
					},
					["name"] = "rune1_timer",
					["h"] = 14,
				}, -- [8]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune1_bar",
					},
					["name"] = "rune1_text",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [9]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune1_text",
					["sbExpireState"] = "Full",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune1_bar",
					["text"] = "rune1_timer",
					["texIcon"] = "rune1_tex",
					["TEIExpireState"] = "Default",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "true",
					["tex"] = "rune1_icon",
					["txt"] = "rune1_name",
					["timerVar"] = "rune1",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [10]
				{
					["feature"] = "commentline",
				}, -- [11]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune2_sf",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [12]
				{
					["feature"] = "backdrop",
					["owner"] = "rune2_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["_backdrop"] = "solid",
						["kb"] = 0.016,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 1,
					},
				}, -- [13]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune2_color",
					["name"] = "rune2_bar",
					["h"] = 19,
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour5",
					},
				}, -- [14]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune2_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [15]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["name"] = "rune2_timer",
					["h"] = 14,
				}, -- [16]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["name"] = "rune2_text",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [17]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune2_text",
					["sbExpireState"] = "Full",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune2_bar",
					["text"] = "rune2_timer",
					["texIcon"] = "rune2_tex",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "true",
					["tex"] = "rune2_icon",
					["txt"] = "rune2_name",
					["timerVar"] = "rune2",
					["TEIExpireState"] = "Default",
				}, -- [18]
				{
					["feature"] = "commentline",
				}, -- [19]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune3_sf",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [20]
				{
					["feature"] = "backdrop",
					["owner"] = "rune3_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 1,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [21]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune3_color",
					["name"] = "rune3_bar",
					["h"] = 19,
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour5",
					},
				}, -- [22]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune3_tex",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [23]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["name"] = "rune3_timer",
					["h"] = 14,
				}, -- [24]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["name"] = "rune3_text",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [25]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune3_text",
					["sbExpireState"] = "Full",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune3_bar",
					["text"] = "rune3_timer",
					["texIcon"] = "rune3_tex",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "true",
					["tex"] = "rune3_icon",
					["txt"] = "rune3_name",
					["timerVar"] = "rune3",
					["TEIExpireState"] = "Default",
				}, -- [26]
				{
					["feature"] = "commentline",
				}, -- [27]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune4_sf",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [28]
				{
					["feature"] = "backdrop",
					["owner"] = "rune4_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.09999999999999998,
						["kg"] = 1,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [29]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune4_color",
					["name"] = "rune4_bar",
					["h"] = 19,
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour5",
					},
				}, -- [30]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune4_tex",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [31]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["name"] = "rune4_timer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 9,
					},
				}, -- [32]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["name"] = "rune4_text",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [33]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune4_text",
					["sbExpireState"] = "Full",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune4_bar",
					["text"] = "rune4_timer",
					["texIcon"] = "rune4_tex",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "true",
					["tex"] = "rune4_icon",
					["txt"] = "rune4_name",
					["timerVar"] = "rune4",
					["TEIExpireState"] = "Default",
				}, -- [34]
				{
					["feature"] = "commentline",
				}, -- [35]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune5_sf",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [36]
				{
					["feature"] = "backdrop",
					["owner"] = "rune5_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 1,
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["kr"] = 0,
					},
				}, -- [37]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune5_color",
					["name"] = "rune5_bar",
					["h"] = 19,
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour5",
					},
				}, -- [38]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune5_tex",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [39]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["name"] = "rune5_timer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [40]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["name"] = "rune5_text",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [41]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune5_text",
					["sbExpireState"] = "Full",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune5_bar",
					["text"] = "rune5_timer",
					["texIcon"] = "rune5_tex",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "true",
					["tex"] = "rune5_icon",
					["txt"] = "rune5_name",
					["timerVar"] = "rune5",
					["TEIExpireState"] = "Default",
				}, -- [42]
				{
					["feature"] = "commentline",
				}, -- [43]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune6_sf",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [44]
				{
					["feature"] = "backdrop",
					["owner"] = "rune6_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 1,
						["ka"] = 0.09999999999999998,
						["kg"] = 0,
						["kr"] = 0,
					},
				}, -- [45]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "rune6_color",
					["name"] = "rune6_bar",
					["h"] = 19,
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour5",
					},
				}, -- [46]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune6_tex",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [47]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["name"] = "rune6_timer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [48]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["name"] = "rune6_text",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
				}, -- [49]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune6_text",
					["sbExpireState"] = "Full",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune6_bar",
					["text"] = "rune6_timer",
					["texIcon"] = "rune6_tex",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "true",
					["tex"] = "rune6_icon",
					["txt"] = "rune6_name",
					["timerVar"] = "rune6",
					["TEIExpireState"] = "Default",
				}, -- [50]
			},
		},
		["ChatEditBox1"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ChatEditBox1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Shaman",
				["color"] = {
					["a"] = 1,
					["r"] = 0.00392156862745098,
					["g"] = 0.7019607843137257,
					["b"] = 0.5098039215686274,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Shaman_fset",
					},
				},
				["sv"] = 2,
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Shaman_fset",
					},
				},
			},
		},
		["MouseOver_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:MouseOver_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["unitWatch"] = 1,
					["version"] = 1,
					["unit"] = "mouseover",
				}, -- [3]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.2,
					["slot"] = "RepaintAll",
				}, -- [4]
			},
		},
		["Target_Hot_ds1"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [2]
				{
					["feature"] = "var_spellinfo",
				}, -- [3]
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [4]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 1,
						["r"] = 0.03137254901960784,
						["g"] = 0.8156862745098039,
						["b"] = 0,
					},
				}, -- [5]
				{
					["feature"] = "commentline",
				}, -- [6]
				{
					["feature"] = "base_default",
					["h"] = 15,
					["version"] = 1,
					["w"] = 260,
					["alpha"] = 1,
				}, -- [7]
				{
					["feature"] = "Subframe",
					["h"] = "15",
					["name"] = "subframe",
					["anchor"] = {
						["dx"] = 140,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "Base",
					["w"] = "120",
					["flOffset"] = 0,
				}, -- [8]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "top",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "Base",
					["w"] = "90",
					["flOffset"] = 2,
				}, -- [9]
				{
					["feature"] = "backdrop",
					["owner"] = "subframe",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["insets"] = {
							["top"] = 1,
							["right"] = 1,
							["left"] = 1,
							["bottom"] = 1,
						},
					},
				}, -- [10]
				{
					["frac"] = "fh",
					["owner"] = "Base",
					["w"] = "140",
					["feature"] = "statusbar_horiz",
					["h"] = "14",
					["version"] = 1,
					["colorVar"] = "classColor",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "hpbar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [11]
				{
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 8,
					},
					["version"] = 1,
					["name"] = "np",
					["anchor"] = {
						["dx"] = 12,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "Base",
					["w"] = "110",
					["h"] = "14",
				}, -- [12]
				{
					["owner"] = "Base",
					["w"] = "35",
					["feature"] = "txt_status",
					["ty"] = "hpp",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 102,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "14",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 8,
					},
					["name"] = "text_hp_percent",
				}, -- [13]
				{
					["feature"] = "Raid Target Icon",
					["h"] = 12,
					["name"] = "rti",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "top",
					},
					["owner"] = "top",
					["w"] = 12,
					["drawLayer"] = "ARTWORK",
				}, -- [14]
				{
					["timerType"] = "COOLDOWN",
					["rows"] = 1,
					["cdoffy"] = 0,
					["feature"] = "aura_icons",
					["iconspx"] = 0,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["cooldownGfx"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["size"] = 14,
					["mindurationfilter"] = 0,
					["auraType"] = "DEBUFFS",
					["ButtonSkinOffset"] = 0,
					["owner"] = "Base",
					["cdoffx"] = 0,
					["nIcons"] = 10,
					["version"] = 1,
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\framd.ttf",
						["justifyV"] = "CENTER",
						["size"] = 8,
					},
					["name"] = "debuffs",
					["ephemeral"] = 1,
					["orientation"] = "LEFT",
					["text"] = "STACK",
					["myaurasfilter"] = 1,
					["maxdurationfilter"] = 3000,
				}, -- [15]
				{
					["feature"] = "commentline",
				}, -- [16]
				{
					["frac"] = "",
					["owner"] = "subframe",
					["w"] = "108",
					["feature"] = "statusbar_horiz",
					["h"] = "11",
					["version"] = 1,
					["colorVar"] = "green",
					["anchor"] = {
						["dx"] = 12,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "statusBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar_halfoutline",
					},
				}, -- [17]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "40",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -1,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "subframe",
					},
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 8,
					},
					["name"] = "spellText",
				}, -- [18]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "VFL.Hundredths",
					["statusBar"] = "statusBar",
					["text"] = "spellText",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "spell",
					["texIcon"] = "",
				}, -- [19]
				{
					["txt"] = "spell_name_rank",
					["owner"] = "subframe",
					["w"] = "93",
					["feature"] = "txt_dyn",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 13,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["font"] = {
						["size"] = 8,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["name"] = "infoText",
				}, -- [20]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "subframe",
					["w"] = "11",
					["feature"] = "texture",
					["h"] = "11",
					["version"] = 1,
					["name"] = "icontex",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 0,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [21]
				{
					["feature"] = "shader_applytex",
					["owner"] = "icontex",
					["version"] = 1,
					["var"] = "spell_icon",
				}, -- [22]
			},
		},
		["Raid_Group5"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 5",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group5",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 40,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Heal_Done_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_tablemeter",
					["tablemeter"] = "WoWRDX:Heal_Done_tm",
					["name"] = "combatmeter1",
				}, -- [1]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "blue",
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.3882352941176471,
						["r"] = 0.2117647058823529,
					},
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 13,
					["version"] = 1,
					["w"] = 180,
					["alpha"] = 1,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [4]
				{
					["interpolate"] = 1,
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["colorVar"] = "blue",
					["feature"] = "statusbar_horiz",
					["h"] = "12",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["name"] = "statusBar",
					["frac"] = "fcombatmeter1",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Ruben",
					},
				}, -- [5]
				{
					["owner"] = "pdt",
					["w"] = "60",
					["feature"] = "txt_np",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["name"] = "np",
					["classColor"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
				}, -- [6]
				{
					["txt"] = "combatmeter1_text",
					["owner"] = "pdt",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_pdt",
					},
					["font"] = {
						["cr"] = 1,
						["sr"] = 0,
						["cb"] = 1,
						["ca"] = 1,
						["sb"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["cg"] = 1,
						["title"] = "Default",
						["sx"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["size"] = 9,
					},
					["name"] = "infoText",
				}, -- [7]
				{
					["feature"] = "shader_showhide",
					["owner"] = "pdt",
					["version"] = 1,
					["flag"] = "bcombatmeter1",
				}, -- [8]
			},
		},
		["ChatFrame3"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Chat 3",
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ChatFrame3_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ActionBar1"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBar1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ActionBar6"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBar6_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Party"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Party_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Party_fset",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["axis"] = 2,
					["feature"] = "Header Grid",
					["cols"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Player_Main_mb",
				}, -- [5]
				{
					["feature"] = "mp_args",
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
				}, -- [6]
				{
					["feature"] = "FilterSet Editor",
				}, -- [7]
			},
		},
		["Priest_Buff_Shadow"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Shadow",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0.7803921568627451,
						["g"] = 0.03137254901960784,
						["r"] = 0.4352941176470588,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_Shadow_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Raid_fset",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["countTitle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 25,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Priest_Buff_Shadow_mb",
				}, -- [5]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [6]
			},
		},
		["Range_not_0_30_dead_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["n"] = 3,
							["class"] = "frs",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"ol", -- [1]
					}, -- [2]
				}, -- [3]
				{
					"dead", -- [1]
				}, -- [4]
			},
		},
		["Raid_needsHeals_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"dead", -- [1]
					}, -- [2]
				}, -- [2]
				{
					"hp", -- [1]
					1, -- [2]
					1, -- [3]
					0, -- [4]
					85, -- [5]
				}, -- [3]
			},
		},
		["infoAuthor"] = "Sigg",
		["CooldownBars_Used"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:CooldownBars_Used_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Totems3_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 50,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 148,
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.776470588235294,
						["r"] = 0.7882352941176469,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.6196078431372554,
						["b"] = 1,
					},
					["name"] = "blue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [3]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.05490196078431373,
						["r"] = 1,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [4]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.4862745098039216,
						["b"] = 0.1333333333333333,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [5]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [6]
				{
					["feature"] = "commentline",
				}, -- [7]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemEarthIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "green",
					["version"] = 1,
					["h"] = 12,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -37,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemEarthBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalH",
					},
				}, -- [9]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = "36",
					["feature"] = "txt_custom",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemEarthBar",
					},
					["name"] = "EarthTimer",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "CENTER",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
				}, -- [10]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemEarthBar",
					["text"] = "EarthTimer",
					["texIcon"] = "TotemEarthIcon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [11]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["h"] = 36,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "earth",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [12]
				{
					["feature"] = "commentline",
				}, -- [13]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemFireIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 37,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [14]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["version"] = 1,
					["h"] = 12,
					["anchor"] = {
						["dx"] = 37,
						["dy"] = -37,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemFireBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalH",
					},
				}, -- [15]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemFireBar",
					},
					["h"] = 12,
					["name"] = "FireTimer",
				}, -- [16]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemFireBar",
					["text"] = "FireTimer",
					["texIcon"] = "TotemFireIcon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [17]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["h"] = 36,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 37,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "fire",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [18]
				{
					["feature"] = "commentline",
				}, -- [19]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemWaterIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 74,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [20]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "blue",
					["version"] = 1,
					["h"] = 12,
					["anchor"] = {
						["dx"] = 74,
						["dy"] = -37,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemWaterBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalH",
					},
				}, -- [21]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemWaterBar",
					},
					["h"] = 12,
					["name"] = "WaterTimer",
				}, -- [22]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemWaterBar",
					["text"] = "WaterTimer",
					["texIcon"] = "TotemWaterIcon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemwater_icon",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [23]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["h"] = 36,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 74,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "water",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemAirIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 111,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [26]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "yellow",
					["version"] = 1,
					["h"] = 12,
					["anchor"] = {
						["dx"] = 111,
						["dy"] = -37,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemAirBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalH",
					},
				}, -- [27]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemAirBar",
					},
					["h"] = 12,
					["name"] = "AirTimer",
				}, -- [28]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemAirBar",
					["text"] = "AirTimer",
					["texIcon"] = "TotemAirIcon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemair_icon",
					["txt"] = "",
					["timerVar"] = "totemair",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [29]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["h"] = 36,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 111,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "air",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [30]
				{
					["feature"] = "commentline",
				}, -- [31]
				{
					["w"] = 148,
					["feature"] = "hotspot",
					["h"] = 12,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -37,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "remove",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [32]
				{
					["feature"] = "Subframe",
					["h"] = 80,
					["name"] = "remove_s",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 20,
					["flOffset"] = 1,
				}, -- [33]
			},
		},
		["Cooldowns_Avail"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Cooldowns_Avail_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Range_0_30_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["n"] = 3,
						["class"] = "frs",
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Paladin_Buff_Kings_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79062,
				},
			},
		},
		["Shaman_Totem_Remove_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 36936,
				},
			},
		},
		["Druid_Buff_Wild_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				1126, -- [1]
				21849, -- [2]
			},
		},
		["Cooldowns_Used_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 30,
					["version"] = 1,
					["w"] = 300,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "cd_icons",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\Blokletters-Viltstift.ttf",
							["justifyV"] = "CENTER",
							["cr"] = 1,
							["flags"] = "OUTLINE",
							["cg"] = 0.04313725490196078,
							["title"] = "Default",
							["cb"] = 0,
							["ca"] = 1,
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["size"] = 10,
						},
						["Offsety"] = -20,
						["TimerType"] = "TEXT",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 5,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["cooldownType"] = "USED",
					["iconspy"] = 0,
					["nIcons"] = 10,
					["mindurationfilter"] = "",
					["owner"] = "decor",
					["usebs"] = true,
					["name"] = "ai1",
					["size"] = 30,
					["orientation"] = "RIGHT",
					["externalButtonSkin"] = "bs_simplesquare",
					["version"] = 1,
					["maxdurationfilter"] = "",
				}, -- [2]
			},
		},
		["None_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"false", -- [1]
			},
		},
		["Deathknight_Runes5"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes5_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Dps_Health_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.01176470588235294,
					["g"] = 0,
					["r"] = 0.4705882352941178,
				},
				["name"] = "DPS HP",
				["sv"] = 1,
				["color"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["pct"] = 1,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Dps_fset",
						["class"] = "file",
					},
					["qty"] = "smaxhp",
				},
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Dps_fset",
						["class"] = "file",
					},
					["qty"] = "shp",
				},
			},
		},
		["MiniMapButtons_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 32,
					["version"] = 1,
					["w"] = 160,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "but1",
					["mbuttontype"] = "MiniMapTracking",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [2]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "but2",
					["mbuttontype"] = "MiniMapVoiceChatFrame",
					["anchor"] = {
						["dx"] = 32,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [3]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "but3",
					["mbuttontype"] = "MiniMapLFGFrame",
					["anchor"] = {
						["dx"] = 64,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [4]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "but4",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 96,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "32",
					["mbuttontype"] = "MiniMapBattlefieldFrame",
				}, -- [5]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "but5",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 128,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "32",
					["mbuttontype"] = "MiniMapMailFrame",
				}, -- [6]
			},
		},
		["CooldownBars_Used_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 200,
					["version"] = 1,
					["w"] = 220,
					["alpha"] = 1,
				}, -- [1]
				{
					["maxdurationfilter"] = 3000,
					["rows"] = 1,
					["mindurationfilter"] = 0,
					["feature"] = "cooldown_bars",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["filterNameList"] = {
					},
					["countTypeFlag"] = "false",
					["sbtib"] = {
						["nametxt"] = {
							["flags"] = "OUTLINE",
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Decker.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["borientation"] = "VERTICAL",
						["btype"] = "Frame",
						["w"] = 20,
						["banchor"] = "BOTTOM",
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\vbar1",
						},
						["bkd"] = {
							["_border"] = "tooltip",
							["edgeSize"] = 16,
							["_backdrop"] = "none",
							["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
							["insets"] = {
								["top"] = 4,
								["right"] = 4,
								["left"] = 4,
								["bottom"] = 4,
							},
						},
						["timetxt"] = {
							["flags"] = "OUTLINE",
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "RIGHT",
							["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Decker.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["stacktxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["h"] = 200,
						["iconposition"] = "BOTTOM",
					},
					["iconspx"] = 0,
					["name"] = "ab2",
					["version"] = 2,
					["orientation"] = "RIGHT",
					["cooldownType"] = "USED",
					["iconspy"] = 1,
					["nIcons"] = 10,
				}, -- [2]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "cooldown_bars",
					["iconspx"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["cooldownType"] = "USED",
					["iconspy"] = 1,
					["nIcons"] = 10,
					["mindurationfilter"] = 0,
					["owner"] = "decor",
					["sbtib"] = {
						["timetxt"] = {
							["flags"] = "OUTLINE",
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "RIGHT",
							["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Decker.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["borientation"] = "HORIZONTAL",
						["btype"] = "Frame",
						["w"] = 220,
						["h"] = 20,
						["nametxt"] = {
							["flags"] = "OUTLINE",
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Decker.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
						},
						["stacktxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["bkd"] = {
							["_border"] = "tooltip",
							["edgeSize"] = 16,
							["_backdrop"] = "none",
							["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
							["insets"] = {
								["top"] = 4,
								["right"] = 4,
								["left"] = 4,
								["bottom"] = 4,
							},
						},
						["banchor"] = "LEFT",
						["showicon"] = true,
						["showname"] = true,
						["iconposition"] = "LEFT",
					},
					["countTypeFlag"] = "false",
					["name"] = "ab2",
					["orientation"] = "DOWN",
					["maxdurationfilter"] = 3000,
					["version"] = 2,
					["disable"] = true,
				}, -- [3]
			},
		},
		["Mage_Buff_Arcane_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 42995,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 43002,
				},
			},
		},
		["Offline_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["name"] = "Offline",
				["val"] = {
					["qty"] = "ssz",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Offline_set",
					},
				},
				["max"] = {
					["qty"] = "ssz",
					["set"] = {
						["class"] = "group",
					},
				},
				["sv"] = 3,
				["color"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["texture"] = "",
			},
		},
		["Offline_set"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"ol", -- [1]
					}, -- [2]
				}, -- [2]
				{
					"nidmask", -- [1]
				}, -- [3]
			},
		},
		["ActionBar5"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBar5_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Player_Debuff_Icon_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 45,
					["version"] = 1,
					["w"] = 300,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 10,
					["fontst"] = {
						["size"] = 14,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["flags"] = "THICKOUTLINE",
						["sr"] = 0,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["size"] = 10,
							["title"] = "Default",
							["name"] = "Default",
							["sg"] = 0,
							["sx"] = 1,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["sy"] = -1,
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["justifyH"] = "CENTER",
							["sb"] = 0,
							["sa"] = 1,
							["sr"] = 0,
							["cb"] = 0.1333333333333333,
							["cr"] = 1,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["UpdateSpeed"] = 0.1,
						["Offsetx"] = 0,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 5,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 14,
					["nIcons"] = 20,
					["mindurationfilter"] = "",
					["auraType"] = "DEBUFFS",
					["owner"] = "decor",
					["filterNameList"] = {
					},
					["smooth"] = 1,
					["usebs"] = true,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "LEFT",
					["bkd"] = {
					},
					["size"] = 30,
					["unitfilter"] = "",
				}, -- [2]
			},
		},
		["Priest_Buff_VampiricEmbrace_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 15286,
				},
			},
		},
		["Shaman_TotemBar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 108,
					["version"] = 1,
					["w"] = 184,
					["alpha"] = 1,
				}, -- [1]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["feature"] = "multicastbar",
					["iconspx"] = 1,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = false,
					},
					["ButtonSkinOffset"] = 4,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 1,
					["nIcons"] = 5,
					["showkey"] = 1,
					["owner"] = "decor",
					["totembar"] = "Elements",
					["size"] = 36,
					["version"] = 1,
					["name"] = "totembar1",
					["usebs"] = true,
					["orientation"] = "RIGHT",
					["bkd"] = {
						["_border"] = "none",
					},
					["fontkey"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["fontmacro"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
				}, -- [2]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["feature"] = "multicastbar",
					["iconspx"] = 1,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = false,
					},
					["ButtonSkinOffset"] = 4,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 1,
					["nIcons"] = 5,
					["showkey"] = 1,
					["owner"] = "decor",
					["totembar"] = "Ancestors",
					["size"] = 36,
					["version"] = 1,
					["name"] = "totembar2",
					["usebs"] = true,
					["orientation"] = "RIGHT",
					["bkd"] = {
					},
					["fontkey"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["fontmacro"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
				}, -- [3]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["feature"] = "multicastbar",
					["iconspx"] = 1,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = false,
					},
					["ButtonSkinOffset"] = 4,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 1,
					["nIcons"] = 5,
					["showkey"] = 1,
					["owner"] = "decor",
					["totembar"] = "Spirits",
					["size"] = 36,
					["version"] = 1,
					["name"] = "totembar3",
					["usebs"] = true,
					["orientation"] = "RIGHT",
					["bkd"] = {
					},
					["fontkey"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["fontmacro"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
				}, -- [4]
			},
		},
		["Battleground_desk"] = {
			["ty"] = "Desktop",
			["version"] = 2,
			["data"] = {
				{
					["offsetleft"] = "0",
					["b"] = 0,
					["scale"] = 1,
					["dgp"] = true,
					["feature"] = "Desktop main",
					["offsetbottom"] = "0",
					["l"] = 0,
					["offsettop"] = "0",
					["r"] = 1365.333426704711,
					["root"] = true,
					["t"] = 767.9999824928667,
					["anchorx"] = 1083.1998810609,
					["alpha"] = 1,
					["strata"] = "BACKGROUND",
					["offsetright"] = "0",
					["name"] = "root",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Combat_Logs",
							["x"] = 20,
							["point"] = "BOTTOMRIGHT",
							["y"] = -20,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -20,
						},
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 20,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_SecureDebuff_Icon",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = -20,
							["point"] = "BOTTOMLEFT",
							["y"] = -20,
						},
						["CENTER"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "CENTER",
							["y"] = 0,
						},
					},
					["open"] = true,
					["title"] = "Konyagi_AUI:desk_solo",
					["anchory"] = 207.6800844938,
					["ap"] = "TOPLEFT",
				}, -- [1]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 20,
						},
					},
					["scale"] = 1,
					["t"] = 47.78666548950701,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 17.06666731335399,
					["alpha"] = 1,
				}, -- [2]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar4",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["r"] = 1348.266710285255,
					["anchor"] = "TOPLEFT",
					["l"] = 1317.546600063446,
					["b"] = 199.680014288981,
					["alpha"] = 1,
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["r"] = 1317.546600063446,
					["anchor"] = "TOPLEFT",
					["l"] = 1286.826609357003,
					["b"] = 199.680014288981,
					["alpha"] = 1,
				}, -- [4]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 78.50667113537041,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 47.78666548950701,
					["alpha"] = 1,
				}, -- [5]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 109.2266693115234,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 78.50667113537041,
					["alpha"] = 1,
				}, -- [6]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 139.9466674876765,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["r"] = 805.54665535993,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 109.2266693115234,
					["alpha"] = 1,
				}, -- [7]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBarVehicle",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["r"] = 805.54665535993,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 139.9466674876765,
					["alpha"] = 1,
				}, -- [8]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["r"] = 897.7066274792579,
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 139.9466674876765,
					["alpha"] = 1,
				}, -- [9]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:XpBar",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 128.0000160547205,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["r"] = 358.4000210501441,
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 102.4000113498343,
					["alpha"] = 1,
				}, -- [10]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "root",
							["x"] = 20,
							["point"] = "BOTTOMLEFT",
							["y"] = 20,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 102.4000113498343,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["r"] = 358.4000210501441,
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 17.06666731335399,
					["alpha"] = 1,
				}, -- [11]
				{
					["strata"] = "MEDIUM",
					["b"] = 128.0000160547205,
					["scale"] = 1,
					["t"] = 140.8000221420188,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:XpBar",
					["r"] = 358.4000210501441,
					["anchor"] = "TOPLEFT",
					["l"] = 187.7333479166043,
					["open"] = true,
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
				}, -- [12]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["r"] = 1365.333385068319,
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 725.3333197341373,
					["alpha"] = 1,
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["r"] = 341.3333462670797,
					["anchor"] = "TOPLEFT",
					["l"] = 0,
					["b"] = 721.0666211595296,
					["alpha"] = 1,
				}, -- [14]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 10,
						},
					},
					["scale"] = 1,
					["t"] = 416.4267033610263,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["r"] = 512.0000044611988,
					["anchor"] = "TOPLEFT",
					["l"] = 336.2133378563921,
					["b"] = 351.573363088455,
					["alpha"] = 1,
				}, -- [15]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -50,
						},
					},
					["scale"] = 1,
					["t"] = 256.0000022305994,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["r"] = 770.5600258365629,
					["anchor"] = "TOPLEFT",
					["l"] = 594.7733592317561,
					["b"] = 233.8133339762682,
					["alpha"] = 1,
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["r"] = 512.0000044611988,
					["scale"] = 1,
					["t"] = 343.0400256969228,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -10,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 336.2133378563921,
					["b"] = 278.1866854243514,
					["alpha"] = 1,
				}, -- [17]
				{
					["strata"] = "MEDIUM",
					["b"] = 679.2533934321565,
					["scale"] = 1,
					["t"] = 706.560025278913,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMapButtons",
					["anchor"] = "TOPLEFT",
					["l"] = 1063.253396778056,
					["r"] = 1199.786795042571,
					["open"] = true,
				}, -- [18]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["CENTER"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "CENTER",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 50,
						},
					},
					["scale"] = 1,
					["t"] = 469.3333473823794,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Panel_Center",
					["r"] = 853.3333806071202,
					["anchor"] = "TOPLEFT",
					["l"] = 512.0000044611988,
					["b"] = 298.6666593094188,
					["alpha"] = 1,
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Targettarget_Main",
							["x"] = -10,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 416.4267033610263,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Target_Main",
					["r"] = 1029.120047211927,
					["anchor"] = "TOPLEFT",
					["l"] = 853.3333806071202,
					["b"] = 351.573363088455,
					["alpha"] = 1,
				}, -- [20]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 416.4267033610263,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["r"] = 1213.439991450583,
					["anchor"] = "TOPLEFT",
					["l"] = 1037.653324845776,
					["b"] = 351.573363088455,
					["alpha"] = 1,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "BOTTOMRIGHT",
							["y"] = 20,
						},
					},
					["scale"] = 1,
					["t"] = 145.0666609589433,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Combat_Logs",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1028.266707497005,
					["b"] = 17.06666731335399,
					["r"] = 1348.266710285255,
				}, -- [22]
				{
					["strata"] = "MEDIUM",
					["r"] = 1345.707408232687,
					["scale"] = 1,
					["t"] = 712.5332240103143,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMap",
					["anchor"] = "TOPLEFT",
					["l"] = 1222.827325891551,
					["open"] = true,
					["b"] = 589.6532611845438,
				}, -- [23]
				{
					["strata"] = "MEDIUM",
					["r"] = 354.3381878377041,
					["scale"] = 0.9000000357627869,
					["t"] = 643.4560653971696,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Raid_GroupAll",
					["b"] = 305.4592713692527,
					["anchor"] = "TOPLEFT",
					["l"] = 10.19733907745491,
					["open"] = true,
					["ap"] = "TOPLEFT",
				}, -- [24]
			},
		},
		["Range_30plus_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"ol", -- [1]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["n"] = 3,
							["class"] = "frs",
						}, -- [2]
					}, -- [2]
				}, -- [3]
			},
		},
		["Status_Raid"] = {
			["ty"] = "StatusWindow",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Status",
					["bkdColor"] = {
						["a"] = 0.5,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [1]
				{
					["feature"] = "Raid Status DataSource",
				}, -- [2]
				{
					["feature"] = "Stat Frames: Bar",
					["h"] = "12",
					["fsz"] = 8,
					["tdx"] = 60,
					["w"] = "60",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["dxn"] = 2,
					["cols"] = 2,
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Alive_stc",
				}, -- [5]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Dead_stc",
				}, -- [6]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Range_40plus_stc",
				}, -- [7]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Offline_stc",
				}, -- [8]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.3,
					["slot"] = "RepaintAll",
				}, -- [9]
				{
					["feature"] = "Description",
					["description"] = "Status (Alive, Dead, Not Here, Offline)",
				}, -- [10]
			},
		},
		["Boss"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Boss_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Boss_fset",
						["class"] = "file",
					},
					["rostertype"] = "BOSS",
				}, -- [3]
				{
					["feature"] = "Boss Layout",
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [4]
			},
		},
		["ActionBarPet_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["w"] = 360,
					["alpha"] = 1,
				}, -- [1]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["feature"] = "actionbarpet",
					["iconspx"] = 0,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 10,
					["showkey"] = 1,
					["owner"] = "decor",
					["usebs"] = true,
					["abid"] = 1,
					["version"] = 1,
					["name"] = "actionbarpet",
					["orientation"] = "RIGHT",
					["size"] = 36,
					["fontkey"] = {
						["size"] = 10,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sy"] = 0,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["flags"] = "THICKOUTLINE",
						["cr"] = 1,
					},
					["hidebs"] = 1,
				}, -- [2]
			},
		},
		["Overheal_Done_tm"] = {
			["ty"] = "TableMeter",
			["version"] = 1,
			["data"] = {
				["dtypes"] = {
					true, -- [1]
				},
				["etypes"] = {
					[44] = true,
				},
			},
		},
		["Deathknight_Runes1"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["infoRunAutoexec"] = 1,
		["ActionBar1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["w"] = 432,
					["alpha"] = 1,
				}, -- [1]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["cr"] = 0.2980392156862745,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.3882352941176471,
						["justifyH"] = "RIGHT",
						["cb"] = 1,
						["sy"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["feature"] = "actionbar",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["fontkey"] = {
						["cr"] = 1,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["cb"] = 0.1058823529411765,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["size"] = 36,
					["bkd"] = {
						["ka"] = 1,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["edgeSize"] = 12,
						["_border"] = "IshBorder",
						["kg"] = 0.1,
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["owner"] = "decor",
					["fontmacro"] = {
						["size"] = 8,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["cr"] = 1,
					},
					["name"] = "barbut1",
					["headerstateType"] = "Defaultui",
					["abid"] = 1,
					["version"] = 1,
					["headerstateCustom"] = "",
					["orientation"] = "RIGHT",
					["usebs"] = true,
					["anyup"] = 1,
					["externalButtonSkin"] = "bs_simplesquare",
				}, -- [2]
			},
		},
		["Target_Debuff"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Target_Debuff_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "target",
				}, -- [3]
			},
		},
		["Druid_Buff_Wild_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "unitInRange30",
					["set"] = {
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
						["class"] = "file",
					},
				}, -- [2]
				{
					["auraType"] = "BUFFS",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["cd"] = 79061,
					["timer2"] = "0",
					["name"] = "aurai",
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["timer1"] = "0",
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["ph"] = 1,
					["alpha"] = 1,
					["w"] = 80,
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "13",
					["name"] = "statusBar",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [6]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "VFL.Hundredths",
					["statusBar"] = "statusBar",
					["text"] = "",
					["texIcon"] = "",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "aurai_aura",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [7]
				{
					["feature"] = "commentline",
				}, -- [8]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "high",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [9]
				{
					["owner"] = "high",
					["w"] = "40",
					["feature"] = "txt_status",
					["ty"] = "gn",
					["name"] = "text_group",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["version"] = 1,
					["h"] = "14",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 9,
					},
				}, -- [10]
				{
					["owner"] = "high",
					["w"] = "BaseWidth",
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
					},
					["name"] = "np",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["h"] = "BaseHeight",
					["classColor"] = 1,
					["version"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "high",
					["w"] = "80",
					["feature"] = "texture",
					["h"] = "13",
					["name"] = "tex_range",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [13]
				{
					["color"] = {
						["a"] = 0.7430000007152557,
						["b"] = 0,
						["g"] = 0.01568627450980392,
						["r"] = 0.8313725490196078,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [14]
				{
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["condVar"] = "unitInRange30_flag",
					["name"] = "range",
					["colorVar1"] = "red",
					["colorVar2"] = "alpha",
					["feature"] = "ColorVariable: Conditional Color",
				}, -- [16]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "true",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [17]
			},
		},
		["Player_Weapons_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Weapons Buff Info",
				}, -- [1]
				{
					["feature"] = "base_default",
					["h"] = "50",
					["version"] = 1,
					["alpha"] = 1,
					["w"] = "80",
				}, -- [2]
				{
					["name"] = "mainhand",
					["gt"] = "MainHandEnchant_InventoryItem",
					["version"] = 1,
					["externalButtonSkin"] = "mediapack:bs_entropy",
					["owner"] = "Base",
					["w"] = "30",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "30",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["cr"] = 1,
							["size"] = 10,
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["cb"] = 0.1333333333333333,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["name"] = "Default",
							["sa"] = 1,
							["sg"] = 0,
							["sy"] = -1,
							["sx"] = 1,
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["sb"] = 0,
							["sr"] = 0,
						},
						["Offsety"] = -20,
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 4,
					["tex"] = "MainHand_icon",
					["dyntexture"] = 1,
					["timerVar"] = "MainHandEnchant",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [3]
				{
					["name"] = "offhand",
					["gt"] = "OffHandEnchant_InventoryItem",
					["version"] = 1,
					["externalButtonSkin"] = "mediapack:bs_entropy",
					["owner"] = "Base",
					["w"] = "30",
					["anchor"] = {
						["dx"] = 35,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "30",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["cr"] = 1,
							["sr"] = 0,
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["cb"] = 0.1333333333333333,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["name"] = "Default",
							["sa"] = 1,
							["sg"] = 0,
							["sy"] = -1,
							["sx"] = 1,
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["sb"] = 0,
							["size"] = 10,
						},
						["Offsety"] = -20,
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 4,
					["tex"] = "OffHand_icon",
					["dyntexture"] = 1,
					["timerVar"] = "OffHandEnchant",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [4]
			},
		},
		["ChatFrame1"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ChatFrame1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Tanks_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Main Tanks",
					["showtitlebar"] = 1,
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_DeathKnight_DarkConviction",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Assists_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["n"] = 1,
						["class"] = "mtma",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["feature"] = "Secure Assists",
					["suffix2"] = "targettarget",
					["interval"] = 0.2,
					["showAssist"] = 1,
					["suffix1"] = "target",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Assists_mb",
				}, -- [5]
				{
					["feature"] = "Description",
					["description"] = "Blizzard Main Tanks",
				}, -- [6]
				{
					["feature"] = "mp_args",
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
				}, -- [7]
			},
		},
		["Assist_List"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Assists",
					["bkdColor"] = {
						["a"] = 0.2557997107505798,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["showtitlebar"] = true,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Assists_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:assists",
					},
				}, -- [3]
				{
					["feature"] = "Secure Assists",
					["suffix2"] = "targettarget",
					["interval"] = 0.2,
					["showAssist"] = 1,
					["suffix1"] = "target",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "default:bindings",
				}, -- [5]
				{
					["feature"] = "NominativeSet Editor",
				}, -- [6]
			},
		},
		["Range_10_15_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["item"] = "heavy frostweave bandage",
						["class"] = "itemrange",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_0_10_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
			},
		},
		["Paladin_Buff_Kings_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"set", -- [1]
				{
					["buff"] = 79062,
					["class"] = "buff",
				}, -- [2]
			},
		},
		["Assists_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Main Assists",
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_DeathKnight_Explode_Ghoul",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["showtitlebar"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Assists_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["n"] = 2,
						["class"] = "mtma",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["feature"] = "Secure Assists",
					["suffix2"] = "targettarget",
					["interval"] = 0.2,
					["showAssist"] = 1,
					["suffix1"] = "target",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Assists_mb",
				}, -- [5]
				{
					["feature"] = "Description",
					["description"] = "Blizzard Main Assists",
				}, -- [6]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [7]
			},
		},
		["Raid_Druid"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_Druid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Raid_GroupAll_fset",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["dxn"] = 2,
					["axis"] = 2,
					["feature"] = "Header Grid",
					["cols"] = 5,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "click",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [5]
				{
					["feature"] = "FilterSet Editor",
				}, -- [6]
			},
		},
		["Name_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 90,
					["ph"] = 1,
				}, -- [1]
				{
					["owner"] = "Base",
					["w"] = "90",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["name"] = "np",
					["feature"] = "txt_np",
					["h"] = "14",
				}, -- [2]
			},
		},
		["Druid_Buff_Wild_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "buff",
						["buff"] = 79061,
					}, -- [2]
				}, -- [2]
			},
		},
		["Debuff_Poison_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["buff"] = "@poison",
						["class"] = "debuff",
					}, -- [2]
				}, -- [2]
			},
		},
		["ActionBar3"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBar3_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Assists_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [1]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "black",
					["color"] = {
						["a"] = 0.75,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
				}, -- [2]
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [3]
				{
					["feature"] = "ColorVariable: Two-Color Blend",
					["name"] = "classColorDark",
					["colorVar1"] = "classColor",
					["colorVar2"] = "black",
					["bfVar"] = "0.5",
				}, -- [4]
				{
					["feature"] = "commentline",
				}, -- [5]
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 150,
				}, -- [6]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [7]
				{
					["feature"] = "commentline",
				}, -- [8]
				{
					["feature"] = "Subframe",
					["h"] = "24",
					["name"] = "main",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "144",
					["flOffset"] = 1,
				}, -- [9]
				{
					["feature"] = "backdrop",
					["owner"] = "main",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "HalStraight",
						["kg"] = 0,
						["kb"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["edgeSize"] = 8,
						["ka"] = 0.2749999761581421,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [10]
				{
					["frac"] = "1",
					["owner"] = "main",
					["w"] = "140",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["version"] = 1,
					["colorVar"] = "classColorDark",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "BackgroundBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["feature"] = "Subframe",
					["h"] = "24",
					["name"] = "main1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "144",
					["flOffset"] = 1,
				}, -- [13]
				{
					["frac"] = "fh",
					["owner"] = "main1",
					["w"] = "140",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["version"] = 1,
					["colorVar"] = "classColor",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main1",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "HealthBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [14]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [15]
				{
					["feature"] = "Subframe",
					["h"] = "24",
					["name"] = "main2",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "144",
					["flOffset"] = 2,
				}, -- [16]
				{
					["feature"] = "txt_np",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\FRIZQT__.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["version"] = 1,
					["name"] = "np",
					["anchor"] = {
						["dx"] = 4,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_main2",
					},
					["owner"] = "main2",
					["w"] = "100",
					["h"] = "20",
				}, -- [17]
				{
					["owner"] = "main2",
					["w"] = "35",
					["feature"] = "txt_status",
					["h"] = "20",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -4,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_main2",
					},
					["ty"] = "hpp",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\FRIZQT__.TTF",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["name"] = "text_hp_percent",
				}, -- [18]
				{
					["w"] = "140",
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "20",
					["secure"] = 1,
					["name"] = "",
				}, -- [19]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "20",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 5,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Frame_main2",
					},
					["owner"] = "main2",
					["w"] = "20",
					["drawLayer"] = "ARTWORK",
				}, -- [20]
				{
					["timefilter"] = 1,
					["rows"] = 1,
					["fontst"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 1,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_main2",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "decor",
					["playerauras"] = 1,
					["petauras"] = 1,
					["size"] = 10,
					["version"] = 1,
					["name"] = "debuffs",
					["orientation"] = "RIGHT",
					["maxdurationfilter"] = "",
					["filterNameList"] = {
					},
					["unitfilter"] = "",
				}, -- [21]
			},
		},
		["ClassBar_ds"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["DEATHKNIGHT"] = "WoWRDX:Deathknight_Runes1_ds",
				["PALADIN"] = "WoWRDX:Paladin_HolyPower_ds",
				["class"] = "class&form",
				["WARLOCK"] = "WoWRDX:Warlock_Shards_ds",
				["ROGUE"] = "WoWRDX:Rogue_Combo_ds",
				["DRUIDELEM"] = "WoWRDX:Druid_EclipseBar_ds",
				["all"] = "WoWRDX:ClassBarDefault_ds",
				["DRUIDCAT"] = "WoWRDX:Rogue_Combo_ds",
				["SHAMAN"] = "WoWRDX:Shaman_Totems1_ds",
			},
		},
		["Warrior_Shout_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 2048,
				},
			},
		},
		["Deathknight_Runes3_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 120,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 190,
				}, -- [1]
				{
					["color"] = {
						["a"] = 0,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["feature"] = "Vars: Rune Info",
					["colors"] = {
						{
							["a"] = 1,
							["r"] = 1,
							["g"] = 0,
							["b"] = 0.2,
						}, -- [1]
						{
							["a"] = 1,
							["r"] = 0,
							["g"] = 1,
							["b"] = 0,
						}, -- [2]
						{
							["a"] = 1,
							["r"] = 0,
							["g"] = 0.6000000000000001,
							["b"] = 1,
						}, -- [3]
						{
							["a"] = 1,
							["r"] = 0.6000000000000001,
							["g"] = 0.3,
							["b"] = 0.6000000000000001,
						}, -- [4]
					},
					["TextureType"] = "Normal",
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune1_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [5]
				{
					["feature"] = "backdrop",
					["owner"] = "rune1_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [6]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["h"] = 19,
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune1_bar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [7]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune1_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune1_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["title"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune1_bar",
					},
					["h"] = 14,
					["name"] = "rune1_timer",
				}, -- [9]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune1_bar",
					},
					["h"] = 14,
					["name"] = "rune1_text",
				}, -- [10]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune1_text",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["sbcolorVar2"] = "rune1_color",
					["txt"] = "rune1_name",
					["statusBar"] = "rune1_bar",
					["countTypeFlag"] = "true",
					["text"] = "rune1_timer",
					["sbblendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["tex"] = "rune1_icon",
					["TEIExpireState"] = "Hide",
					["timerVar"] = "rune1",
					["texIcon"] = "rune1_tex",
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune2_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [13]
				{
					["feature"] = "backdrop",
					["owner"] = "rune2_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [14]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune2_bar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [15]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune2_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune2_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [16]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "RIGHT",
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["h"] = 14,
					["name"] = "rune2_timer",
				}, -- [17]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "rune2_text",
				}, -- [18]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune2_text",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune2_bar",
					["texIcon"] = "rune2_tex",
					["txt"] = "rune2_name",
					["TL"] = 0,
					["text"] = "rune2_timer",
					["tex"] = "rune2_icon",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["TEIExpireState"] = "Hide",
					["timerVar"] = "rune2",
					["sbcolorVar2"] = "rune2_color",
				}, -- [19]
				{
					["feature"] = "commentline",
				}, -- [20]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune3_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [21]
				{
					["feature"] = "backdrop",
					["owner"] = "rune3_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 1,
						["ka"] = 0,
						["kg"] = 1,
						["kr"] = 1,
					},
				}, -- [22]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune3_bar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [23]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune3_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune3_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [24]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "RIGHT",
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["h"] = 14,
					["name"] = "rune3_timer",
				}, -- [25]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "rune3_text",
				}, -- [26]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune3_text",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune3_bar",
					["texIcon"] = "rune3_tex",
					["txt"] = "rune3_name",
					["TL"] = 0,
					["text"] = "rune3_timer",
					["tex"] = "rune3_icon",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["TEIExpireState"] = "Hide",
					["timerVar"] = "rune3",
					["sbcolorVar2"] = "rune3_color",
				}, -- [27]
				{
					["feature"] = "commentline",
				}, -- [28]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune4_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [29]
				{
					["feature"] = "backdrop",
					["owner"] = "rune4_sf",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0,
						["kg"] = 1,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [30]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune4_bar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [31]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune4_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune4_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [32]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "RIGHT",
						["sr"] = 0,
					},
					["name"] = "rune4_timer",
				}, -- [33]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "rune4_text",
				}, -- [34]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune4_text",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune4_bar",
					["texIcon"] = "rune4_tex",
					["txt"] = "rune4_name",
					["TL"] = 0,
					["text"] = "rune4_timer",
					["tex"] = "rune4_icon",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["TEIExpireState"] = "Hide",
					["timerVar"] = "rune4",
					["sbcolorVar2"] = "rune4_color",
				}, -- [35]
				{
					["feature"] = "commentline",
				}, -- [36]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune5_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [37]
				{
					["feature"] = "backdrop",
					["owner"] = "rune5_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 1,
						["ka"] = 0,
						["kg"] = 0,
						["kr"] = 0,
					},
				}, -- [38]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune5_bar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [39]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune5_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune5_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [40]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "rune5_timer",
				}, -- [41]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "rune5_text",
				}, -- [42]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune5_text",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune5_bar",
					["texIcon"] = "rune5_tex",
					["txt"] = "rune5_name",
					["TL"] = 0,
					["text"] = "rune5_timer",
					["tex"] = "rune5_icon",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["TEIExpireState"] = "Hide",
					["timerVar"] = "rune5",
					["sbcolorVar2"] = "rune5_color",
				}, -- [43]
				{
					["feature"] = "commentline",
				}, -- [44]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "rune6_sf",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [45]
				{
					["feature"] = "backdrop",
					["owner"] = "rune6_sf",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["kb"] = 1,
						["ka"] = 0,
						["kg"] = 0,
						["kr"] = 0,
					},
				}, -- [46]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "rune6_bar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [47]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "rune6_tex",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "rune6_bar",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [48]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "rune6_timer",
				}, -- [49]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "rune6_text",
				}, -- [50]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune6_text",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Default",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Full",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["statusBar"] = "rune6_bar",
					["texIcon"] = "rune6_tex",
					["txt"] = "rune6_name",
					["TL"] = 0,
					["text"] = "rune6_timer",
					["tex"] = "rune6_icon",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["TEIExpireState"] = "Hide",
					["timerVar"] = "rune6",
					["sbcolorVar2"] = "rune6_color",
				}, -- [51]
			},
		},
		["MiniMapButtons"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:MiniMapButtons_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Totems1"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Shaman_Totem_Earth_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = "Totem de force de la terre",
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = "Totem de lien terrestre",
				},
			},
		},
		["Warlock_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"classes", -- [1]
					[7] = true,
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Debuff_Primary_fset"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["targetpath_5"] = "WoWRDX:None_fset",
				["class"] = "class",
				["targetpath_7"] = "WoWRDX:Debuff_Curse_fset",
				["targetpath_8"] = "WoWRDX:None_fset",
				["targetpath_2"] = "WoWRDX:Debuff_Poison_fset",
				["targetpath_3"] = "WoWRDX:Debuff_Poison_fset",
				["targetpath_4"] = "WoWRDX:Debuff_Curse_fset",
				["targetpath_1"] = "WoWRDX:Debuff_Magic_fset",
				["targetpath_10"] = "WoWRDX:None_fset",
				["targetpath_9"] = "WoWRDX:None_fset",
				["targetpath_6"] = "WoWRDX:Debuff_Magic_fset",
			},
		},
		["ActionBar4"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBar4_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Totems4_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 48,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 200,
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.7882352941176469,
						["g"] = 0.776470588235294,
						["b"] = 0,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6196078431372554,
						["r"] = 0,
					},
					["name"] = "blue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [3]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.05490196078431373,
						["b"] = 0,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [4]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.1333333333333333,
						["g"] = 0.4862745098039216,
						["r"] = 0,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [5]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [6]
				{
					["feature"] = "commentline",
				}, -- [7]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemEarthIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "12",
					["feature"] = "statusbar_horiz",
					["h"] = "36",
					["version"] = 1,
					["colorVar"] = "green",
					["anchor"] = {
						["dx"] = 37,
						["dy"] = 12,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemEarthBar",
					["orientation"] = "VERTICAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\vbar1",
					},
				}, -- [9]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "txt_custom",
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["name"] = "EarthTimer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["size"] = 9,
					},
				}, -- [10]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemEarthBar",
					["text"] = "EarthTimer",
					["texIcon"] = "TotemEarthIcon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [11]
				{
					["w"] = 50,
					["feature"] = "hotspot",
					["h"] = 36,
					["name"] = "earth",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [12]
				{
					["feature"] = "commentline",
				}, -- [13]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemFireIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 50,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [14]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 12,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["name"] = "TotemFireBar",
					["h"] = 36,
					["orientation"] = "VERTICAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 87,
						["dy"] = 12,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\vbar1",
					},
				}, -- [15]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 49,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["name"] = "FireTimer",
					["h"] = 12,
				}, -- [16]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemFireBar",
					["text"] = "FireTimer",
					["texIcon"] = "TotemFireIcon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [17]
				{
					["w"] = 50,
					["feature"] = "hotspot",
					["h"] = 36,
					["name"] = "fire",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 50,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [18]
				{
					["feature"] = "commentline",
				}, -- [19]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemWaterIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 100,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [20]
				{
					["feature"] = "shader_applytex",
					["owner"] = "TotemWaterIcon",
					["version"] = 1,
					["var"] = "totemwater_icon",
				}, -- [21]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 12,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "blue",
					["name"] = "TotemWaterBar",
					["h"] = 36,
					["orientation"] = "VERTICAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 137,
						["dy"] = 12,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\vbar1",
					},
				}, -- [22]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 101,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["name"] = "WaterTimer",
					["h"] = 12,
				}, -- [23]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemWaterBar",
					["text"] = "WaterTimer",
					["texIcon"] = "",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [24]
				{
					["w"] = 50,
					["feature"] = "hotspot",
					["h"] = 36,
					["name"] = "water",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 100,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [25]
				{
					["feature"] = "commentline",
				}, -- [26]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["sublevel"] = 1,
					["h"] = 36,
					["name"] = "TotemAirIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 150,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [27]
				{
					["feature"] = "shader_applytex",
					["owner"] = "TotemAirIcon",
					["version"] = 1,
					["var"] = "totemair_icon",
				}, -- [28]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 12,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "yellow",
					["name"] = "TotemAirBar",
					["h"] = 36,
					["orientation"] = "VERTICAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 187,
						["dy"] = 12,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\vbar1",
					},
				}, -- [29]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 149,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["name"] = "AirTimer",
					["h"] = 12,
				}, -- [30]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemAirBar",
					["text"] = "AirTimer",
					["texIcon"] = "",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "totemair",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [31]
				{
					["w"] = 50,
					["feature"] = "hotspot",
					["h"] = 36,
					["name"] = "air",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 150,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["w"] = 200,
					["feature"] = "hotspot",
					["h"] = 12,
					["name"] = "remove",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -37,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [34]
				{
					["feature"] = "Subframe",
					["h"] = 80,
					["name"] = "remove_s",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 20,
					["flOffset"] = 1,
				}, -- [35]
			},
		},
		["Priest_Buff_InnerFire_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "auraia",
					["cd"] = 588,
					["auraType"] = "BUFFS",
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.8627450980392157,
						["b"] = 0.0196078431372549,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["hlt"] = 1,
					["ph"] = 1,
					["w"] = 80,
					["alpha"] = 1,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "subframe",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["frac"] = "",
					["owner"] = "subframe",
					["w"] = "66",
					["feature"] = "statusbar_horiz",
					["h"] = "BaseHeight",
					["version"] = 1,
					["colorVar"] = "yellow",
					["anchor"] = {
						["dx"] = 14,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["name"] = "statusBar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [5]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "subframe",
					["w"] = "14",
					["feature"] = "texture",
					["h"] = "14",
					["name"] = "tex1",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["name"] = "customText",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
				}, -- [7]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "statusBar",
					["text"] = "customText",
					["texIcon"] = "tex1",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "auraia_icon",
					["txt"] = "",
					["timerVar"] = "auraia_aura",
					["TEIExpireState"] = "Default",
				}, -- [8]
				{
					["feature"] = "shader_showhide",
					["owner"] = "subframe",
					["version"] = 1,
					["flag"] = "auraia_possible",
				}, -- [9]
			},
		},
		["MouseOver_Main_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 122,
					["version"] = 1,
					["w"] = 150,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "backdrop",
					["owner"] = "decor",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "tooltip",
						["edgeSize"] = 16,
						["tile"] = false,
						["kr"] = 0,
						["kb"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
						["ka"] = 0.5,
						["kg"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
				}, -- [2]
				{
					["owner"] = "decor",
					["w"] = "16",
					["feature"] = "txt_status",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = -5,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["ty"] = "level",
					["h"] = "14",
					["name"] = "level_text",
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "120",
					["classColor"] = 1,
					["h"] = "14",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_level_text",
					},
					["version"] = 1,
					["feature"] = "txt_np",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [4]
				{
					["txt"] = "Class:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "class_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_level_text",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [5]
				{
					["txt"] = "Race:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "race_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_class_text_static",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [6]
				{
					["txt"] = "Mtype:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "mobtype_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_race_text_static",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [7]
				{
					["txt"] = "Group:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "group_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_mobtype_text_static",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [8]
				{
					["txt"] = "Guild:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_group_text_static",
					},
					["name"] = "guild_text_static",
					["h"] = "14",
				}, -- [9]
				{
					["txt"] = "Target:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_guild_text_static",
					},
					["name"] = "target_text_static",
					["h"] = "14",
				}, -- [10]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_guild_text_static",
					},
					["name"] = "guild_text_var",
					["ty"] = "guild",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [11]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "class",
					["name"] = "class_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_class_text_static",
					},
					["version"] = 1,
					["h"] = "14",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [12]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "race",
					["name"] = "race_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_race_text_static",
					},
					["version"] = 1,
					["h"] = "14",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [13]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_mobtype_text_static",
					},
					["name"] = "mobtype_text_var",
					["ty"] = "mobtype",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [14]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_group_text_static",
					},
					["name"] = "group_text_var",
					["ty"] = "gn",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [15]
				{
					["feature"] = "var_scripted",
					["editor"] = "--enter your code here\n\nlocal varsc1 = UnitName(uid .. \"target\");",
					["vartype"] = "TextData",
					["name"] = "varsc1",
				}, -- [16]
				{
					["txt"] = "varsc1",
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_target_text_static",
					},
					["name"] = "target_text_var",
					["h"] = "14",
				}, -- [17]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [18]
				{
					["frac"] = "fh",
					["feature"] = "statusbar_horiz",
					["sublevel"] = 1,
					["owner"] = "decor",
					["w"] = "140",
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["drawLayer"] = "ARTWORK",
					["h"] = "14",
					["name"] = "healthBar",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_target_text_static",
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [19]
				{
					["owner"] = "decor",
					["w"] = "40",
					["feature"] = "txt_status",
					["ty"] = "hpp",
					["name"] = "hp_text",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 5,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["version"] = 1,
					["h"] = "14",
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [20]
			},
		},
		["Rez_Monitor_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["op"] = "class",
					}, -- [1]
					{
						["op"] = "alpha",
					}, -- [2]
				},
				["set"] = {
					["class"] = "file",
					["file"] = "WoWRDX:Rez_Monitor_fset",
				},
			},
		},
		["ActionBar5_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["w"] = 432,
					["alpha"] = 1,
				}, -- [1]
				{
					["selfcast"] = 1,
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["size"] = 10,
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["ca"] = 1,
						["cg"] = 0.3882352941176471,
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["cb"] = 1,
						["flags"] = "THICKOUTLINE",
						["cr"] = 0.2980392156862745,
					},
					["feature"] = "actionbar",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["usebs"] = true,
					["anyup"] = 1,
					["owner"] = "decor",
					["fontkey"] = {
						["cr"] = 1,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["title"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["headerstateType"] = "None",
					["headerstateCustom"] = "",
					["abid"] = 49,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "RIGHT",
					["size"] = 36,
					["fontmacro"] = {
						["size"] = 8,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["cb"] = 0.8901960784313725,
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["sy"] = 0,
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["cr"] = 1,
					},
					["hidebs"] = 1,
				}, -- [2]
			},
		},
		["Range_40_70_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["n"] = 4,
						["class"] = "frs",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_0_40_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
			},
		},
		["Range_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 10,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 75,
				}, -- [1]
				{
					["owner"] = "decor",
					["w"] = "50",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["name"] = "np",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 8,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["trunc"] = 8,
					["feature"] = "txt_np",
					["h"] = "10",
				}, -- [2]
				{
					["owner"] = "decor",
					["w"] = "40",
					["feature"] = "txt_status",
					["ty"] = "gn",
					["name"] = "group",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 9,
					},
					["h"] = "10",
					["version"] = 1,
				}, -- [3]
			},
		},
		["Shaman_TotemBar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_TotemBar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["clickable"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Target_Hot_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [1]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "black",
					["color"] = {
						["a"] = 0.75,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [2]
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [3]
				{
					["feature"] = "ColorVariable: Two-Color Blend",
					["name"] = "classColorDark",
					["colorVar1"] = "classColor",
					["colorVar2"] = "black",
					["bfVar"] = "0.5",
				}, -- [4]
				{
					["feature"] = "commentline",
					["comment"] = "",
					["version"] = 1,
				}, -- [5]
				{
					["feature"] = "base_default",
					["h"] = "36",
					["version"] = 1,
					["alpha"] = 1,
					["w"] = "150",
				}, -- [6]
				{
					["feature"] = "Subframe",
					["h"] = "24",
					["name"] = "main",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "Base",
					["w"] = "145",
					["flOffset"] = 0,
				}, -- [7]
				{
					["feature"] = "backdrop",
					["owner"] = "main",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.2749999761581421,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["edgeSize"] = 8,
						["kg"] = 0,
						["_border"] = "HalStraight",
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [8]
				{
					["frac"] = "1",
					["owner"] = "main",
					["w"] = "140",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "classColorDark",
					["name"] = "BackgroundBar",
					["h"] = "13",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main",
					},
					["version"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalJ",
					},
				}, -- [9]
				{
					["feature"] = "commentline",
				}, -- [10]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "main1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "Base",
					["w"] = "144",
					["flOffset"] = 1,
				}, -- [11]
				{
					["frac"] = "fh",
					["owner"] = "main1",
					["w"] = "140",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "classColor",
					["name"] = "HealthBar",
					["h"] = "13",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main1",
					},
					["version"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalJ",
					},
				}, -- [12]
				{
					["feature"] = "commentline",
				}, -- [13]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "main2",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "Base",
					["w"] = "144",
					["flOffset"] = 2,
				}, -- [14]
				{
					["feature"] = "txt_np",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "LEFT",
						["sr"] = 0,
					},
					["name"] = "np",
					["h"] = "15",
					["anchor"] = {
						["dx"] = 4,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_main2",
					},
					["owner"] = "main2",
					["w"] = "100",
					["version"] = 1,
				}, -- [15]
				{
					["owner"] = "main2",
					["w"] = "35",
					["feature"] = "txt_status",
					["h"] = "15",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -4,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_main2",
					},
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["ty"] = "hpp",
					["name"] = "text_hp_percent",
				}, -- [16]
				{
					["feature"] = "commentline",
				}, -- [17]
				{
					["feature"] = "var_spellinfo",
				}, -- [18]
				{
					["frac"] = "",
					["owner"] = "main1",
					["w"] = "140",
					["color1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["h"] = "7",
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -15,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main1",
					},
					["name"] = "castBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalJ",
					},
				}, -- [19]
				{
					["script"] = "",
					["owner"] = "main2",
					["w"] = "140",
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 8,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Bold.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -12,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_main2",
					},
					["h"] = "7",
					["name"] = "customText",
				}, -- [20]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "customText",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Hundredths",
					["statusBar"] = "castBar",
					["text"] = "",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["texIcon"] = "",
					["tex"] = "",
					["txt"] = "spell_name_rank",
					["timerVar"] = "spell",
					["TL"] = 0,
				}, -- [21]
				{
					["feature"] = "commentline",
					["comment"] = "",
					["version"] = 1,
				}, -- [22]
				{
					["feature"] = "tex_pvp",
					["h"] = "14",
					["name"] = "faction",
					["ButtonSkinOffset"] = 10,
					["anchor"] = {
						["dx"] = -7,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main2",
					},
					["owner"] = "main2",
					["w"] = "14",
					["drawLayer"] = "ARTWORK",
				}, -- [23]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "20",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 5,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Frame_main2",
					},
					["owner"] = "main2",
					["w"] = "20",
					["drawLayer"] = "ARTWORK",
				}, -- [24]
				{
					["cdFont"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["cdTimerType"] = "COOLDOWN",
					["maxdurationfilter"] = "",
					["rows"] = 1,
					["fontst"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["cdoffy"] = 0,
					["feature"] = "aura_icons",
					["iconspx"] = 1,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["Offsety"] = 0,
						["TimerType"] = "COOLDOWN",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_main",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["cdTxtType"] = "MinSec",
					["size"] = 10,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["cdHideTxt"] = "0",
					["owner"] = "Base",
					["playerauras"] = 1,
					["petauras"] = 1,
					["cdoffx"] = 0,
					["name"] = "debuffs",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["orientation"] = "RIGHT",
					["filterNameList"] = {
					},
					["timefilter"] = 1,
					["unitfilter"] = "",
				}, -- [25]
			},
		},
		["Target_Debuff_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 45,
					["version"] = 1,
					["w"] = 300,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 10,
					["fontst"] = {
						["size"] = 14,
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
						["justifyV"] = "BOTTOM",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sb"] = 0,
						["flags"] = "THICKOUTLINE",
						["sr"] = 0,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["cr"] = 1,
							["title"] = "Default",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
							["justifyV"] = "CENTER",
							["sx"] = 0,
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["sy"] = 0,
							["cb"] = 0.1333333333333333,
							["name"] = "Default",
							["flags"] = "OUTLINE",
							["justifyH"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["UpdateSpeed"] = 0.1,
						["Offsetx"] = 0,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 5,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 14,
					["nIcons"] = 20,
					["mindurationfilter"] = "",
					["auraType"] = "DEBUFFS",
					["owner"] = "decor",
					["filterNameList"] = {
					},
					["size"] = 30,
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "LEFT",
					["maxdurationfilter"] = "",
					["smooth"] = 1,
					["unitfilter"] = "",
				}, -- [2]
			},
		},
		["ActionBar6_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["w"] = 432,
					["alpha"] = 1,
				}, -- [1]
				{
					["selfcast"] = 1,
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["cr"] = 0.2980392156862745,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["cb"] = 1,
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.3882352941176471,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["sy"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["feature"] = "actionbar",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["Offsety"] = 0,
						["TimerType"] = "COOLDOWN",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["fontkey"] = {
						["size"] = 10,
						["sy"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["name"] = "Default",
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["title"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["cb"] = 0.1058823529411765,
						["ca"] = 1,
						["cr"] = 1,
					},
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["anyup"] = 1,
					["size"] = 36,
					["bkd"] = {
					},
					["owner"] = "decor",
					["fontmacro"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["sx"] = 0,
						["title"] = "Default",
						["size"] = 8,
					},
					["name"] = "barbut2",
					["headerstateType"] = "None",
					["abid"] = 61,
					["version"] = 1,
					["headerstateCustom"] = "",
					["orientation"] = "RIGHT",
					["usebs"] = true,
					["externalButtonSkin"] = "bs_simplesquare",
					["hidebs"] = 1,
				}, -- [2]
			},
		},
		["MainMenu"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:MainMenu_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Player_Buff_Icon_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 45,
					["version"] = 1,
					["w"] = 300,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 10,
					["fontst"] = {
						["size"] = 14,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["flags"] = "THICKOUTLINE",
						["sr"] = 0,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["size"] = 10,
							["title"] = "Default",
							["name"] = "Default",
							["sg"] = 0,
							["sx"] = 1,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["sy"] = -1,
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["justifyH"] = "CENTER",
							["sb"] = 0,
							["sa"] = 1,
							["sr"] = 0,
							["cb"] = 0.1333333333333333,
							["cr"] = 1,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["UpdateSpeed"] = 0.1,
						["Offsetx"] = 0,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 5,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 14,
					["nIcons"] = 20,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "decor",
					["filterNameList"] = {
					},
					["smooth"] = 1,
					["usebs"] = true,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "LEFT",
					["bkd"] = {
						["ka"] = 1,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["edgeSize"] = 12,
						["_border"] = "IshBorder",
						["kg"] = 0.1,
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["size"] = 30,
					["unitfilter"] = "",
				}, -- [2]
			},
		},
		["Overheal_Done_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"nidmask", -- [1]
				}, -- [2]
				{
					"tablemeter", -- [1]
					"WoWRDX:Overheal_Done_tm", -- [2]
					1, -- [3]
					10000000, -- [4]
				}, -- [3]
			},
		},
		["infoAuthorWebSite"] = "http://www.wowrdx.com",
		["Mage_Buff_Arcane_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "buff",
						["buff"] = 1459,
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["class"] = "buff",
						["buff"] = 23028,
					}, -- [2]
				}, -- [3]
				{
					"set", -- [1]
					{
						["class"] = "buff",
						["buff"] = 61024,
					}, -- [2]
				}, -- [4]
				{
					"set", -- [1]
					{
						["class"] = "buff",
						["buff"] = 61316,
					}, -- [2]
				}, -- [5]
			},
		},
		["Raid_Group2"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 2",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group2",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["cols"] = 100,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Warrior_Shout_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "auraia",
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["cd"] = 2048,
				}, -- [1]
				{
					["color"] = {
						["a"] = 0,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.0196078431372549,
						["g"] = 0.8627450980392157,
						["r"] = 1,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [3]
				{
					["feature"] = "base_default",
					["h"] = 20,
					["version"] = 1,
					["hlt"] = 1,
					["alpha"] = 1,
					["w"] = 100,
					["ph"] = 1,
				}, -- [4]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 80,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "yellow",
					["name"] = "statusBar",
					["h"] = 20,
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [5]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "decor",
					["w"] = 20,
					["sublevel"] = 1,
					["h"] = 20,
					["name"] = "tex1",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 40,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["justifyH"] = "LEFT",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["h"] = 20,
					["name"] = "customText",
				}, -- [7]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "statusBar",
					["defaultTL"] = 1,
					["text"] = "customText",
					["texIcon"] = "tex1",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 20,
					["version"] = 1,
					["txt"] = "",
					["tex"] = "auraia_icon",
					["countTypeFlag"] = "false",
					["timerVar"] = "auraia_aura",
					["TEIExpireState"] = "Default",
				}, -- [8]
			},
		},
		["Threat_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"nidmask", -- [1]
			},
		},
		["Target_Hot_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"hot_target", -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Priest_Buff_POM_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "auraia",
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["cd"] = 41635,
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.2549019607843137,
						["g"] = 1,
						["r"] = 0.9254901960784314,
					},
					["name"] = "jaune",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 100,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "subframe",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "subframe",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.3159999847412109,
						["kg"] = 0,
						["_backdrop"] = "solid",
						["tile"] = false,
						["kb"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "none",
						["kr"] = 0,
					},
				}, -- [5]
				{
					["owner"] = "subframe",
					["w"] = "100",
					["classColor"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["h"] = "14",
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [6]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "subframe",
					["w"] = "14",
					["feature"] = "texture",
					["h"] = "14",
					["name"] = "tex1",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [7]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "86",
					["feature"] = "statusbar_horiz",
					["h"] = "14",
					["version"] = 1,
					["colorVar"] = "jaune",
					["anchor"] = {
						["dx"] = 14,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "statusBar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [8]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "100",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "subframe",
					},
					["name"] = "customText",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
				}, -- [9]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "14",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["ca"] = 1,
						["cg"] = 0.01176470588235294,
						["justifyH"] = "CENTER",
						["cb"] = 0,
						["sr"] = 0,
						["size"] = 10,
						["sa"] = 1,
						["flags"] = "OUTLINE",
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["cr"] = 1,
					},
					["name"] = "stackText",
				}, -- [10]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "stackText",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Seconds",
					["statusBar"] = "statusBar",
					["texIcon"] = "tex1",
					["text"] = "customText",
					["countTypeFlag"] = "false",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 0.007843137254901961,
						["g"] = 0,
						["r"] = 1,
					},
					["blendcolor"] = 1,
					["tex"] = "auraia_icon",
					["timerVar"] = "auraia_aura",
					["txt"] = "auraia_aura_stack",
				}, -- [11]
				{
					["feature"] = "shader_showhide",
					["owner"] = "subframe",
					["version"] = 1,
					["flag"] = "auraia_possible",
				}, -- [12]
			},
		},
		["Combat_Logs"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Combat_Logs_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ActionBar4_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 432,
					["version"] = 1,
					["w"] = 36,
					["alpha"] = 1,
				}, -- [1]
				{
					["selfcast"] = 1,
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["size"] = 10,
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["ca"] = 1,
						["cg"] = 0.3882352941176471,
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["cb"] = 1,
						["flags"] = "THICKOUTLINE",
						["cr"] = 0.2980392156862745,
					},
					["feature"] = "actionbar",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["usebs"] = true,
					["anyup"] = 1,
					["owner"] = "decor",
					["fontkey"] = {
						["cr"] = 1,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["title"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["headerstateType"] = "None",
					["headerstateCustom"] = "",
					["abid"] = 37,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "DOWN",
					["size"] = 36,
					["fontmacro"] = {
						["size"] = 8,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["cb"] = 0.8901960784313725,
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["sy"] = 0,
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["cr"] = 1,
					},
					["hidebs"] = 1,
				}, -- [2]
			},
		},
		["Healer_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Healer_fset",
					},
				},
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Healer",
				["pct"] = 1,
				["sv"] = 1,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Healer_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 0.2980392156862746,
					["b"] = 0.7607843137254902,
				},
				["texture"] = "",
			},
		},
		["Bossmod_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				"@other", -- [1]
				"!69127", -- [2]
				"!57724", -- [3]
			},
		},
		["Paladin_Buff"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Buff Paladin",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["showtitlebar"] = true,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Paladin_Buff_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Paladin_Buff_fset",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 40,
				}, -- [4]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["period"] = 0.2,
					["dpm1"] = 0,
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "kings",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Paladin_Buff_Kings_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "might",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Paladin_Buff_Might_mb",
				}, -- [7]
				{
					["feature"] = "FilterSet Editor",
				}, -- [8]
			},
		},
		["Hunter_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Hunter",
				["color"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 0.5450980392156861,
					["b"] = 0.1019607843137255,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Hunter_fset",
					},
				},
				["sv"] = 2,
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Hunter_fset",
					},
				},
			},
		},
		["Paladin_Buff_Might_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 19740,
				},
			},
		},
		["Paladin_Buff_Might_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"set", -- [1]
				{
					["buff"] = 19740,
					["class"] = "buff",
				}, -- [2]
			},
		},
		["Damage_Done_tm"] = {
			["ty"] = "TableMeter",
			["version"] = 1,
			["data"] = {
				["dtypes"] = {
					true, -- [1]
				},
				["etypes"] = {
					[2] = true,
				},
			},
		},
		["Priest_Buff_VampiricEmbrace"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Vampiric Embrace",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0.2941176470588235,
						["g"] = 0.3647058823529412,
						["b"] = 1,
					},
					["defaultbuttons"] = 1,
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Shadow_UnsummonBuilding",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_VampiricEmbrace_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Priest_Buff_VampiricEmbrace_mb",
				}, -- [4]
			},
		},
		["Paladin_Buff_Kings_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				79062, -- [1]
			},
		},
		["MiniMap"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:MiniMap_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Totems2"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems2_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Arena_Main_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 76,
					["version"] = 1,
					["w"] = 206,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -30,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_plife",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_plife",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["kg"] = 0,
						["kb"] = 0,
						["tile"] = false,
						["bg"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["bb"] = 0,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_border"] = "straight",
						["edgeSize"] = 8,
						["br"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [5]
				{
					["feature"] = "var_pred_health",
				}, -- [6]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 0.903999999165535,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0.04313725490196078,
					},
				}, -- [7]
				{
					["frac"] = "pfh",
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_plife",
					["w"] = "200",
					["colorVar"] = "green",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["name"] = "sb_plife",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["sublevel"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [8]
				{
					["feature"] = "commentline",
				}, -- [9]
				{
					["feature"] = "Subframe",
					["h"] = "26",
					["name"] = "sf_life",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [10]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [11]
				{
					["neutralColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.75,
						["r"] = 0.75,
					},
					["friendlyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.75,
						["r"] = 0,
					},
					["friendlyDruidColor"] = {
						["a"] = 1,
						["b"] = 0.04,
						["g"] = 0.49,
						["r"] = 1,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["b"] = 0.79,
						["g"] = 0.51,
						["r"] = 0.58,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyMageColor"] = {
						["a"] = 1,
						["b"] = 0.94,
						["g"] = 0.8,
						["r"] = 0.41,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["b"] = 0.23,
						["g"] = 0.12,
						["r"] = 0.77,
					},
					["hostileColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.15,
						["r"] = 0.75,
					},
					["name"] = "hostilityclassColor",
					["friendlyRogueColor"] = {
						["a"] = 1,
						["b"] = 0.41,
						["g"] = 0.96,
						["r"] = 1,
					},
					["friendlyPaladinColor"] = {
						["a"] = 1,
						["b"] = 0.73,
						["g"] = 0.55,
						["r"] = 0.96,
					},
					["friendlyShamanColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.34,
						["r"] = 0.14,
					},
					["friendlyHunterColor"] = {
						["a"] = 1,
						["b"] = 0.45,
						["g"] = 0.83,
						["r"] = 0.67,
					},
					["friendlyWarriorColor"] = {
						["a"] = 1,
						["b"] = 0.43,
						["g"] = 0.61,
						["r"] = 0.78,
					},
				}, -- [12]
				{
					["interpolate"] = 1,
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["owner"] = "sf_life",
					["w"] = "200",
					["version"] = 1,
					["drawLayer"] = "ARTWORK",
					["colorVar"] = "hostilityclassColor",
					["name"] = "sb_life",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["sublevel"] = 2,
					["frac"] = "fh",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [13]
				{
					["txt"] = "pheal",
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["name"] = "text_pheal",
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["sx"] = 1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "text_vie",
					["ty"] = "hptxt2",
					["h"] = "14",
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["ty"] = "fdld",
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["name"] = "text_dead",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["ty"] = "mobtype",
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["name"] = "text_mob",
				}, -- [17]
				{
					["feature"] = "commentline",
				}, -- [18]
				{
					["feature"] = "Subframe",
					["h"] = "16",
					["name"] = "sf_mana",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -23,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [19]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["bb"] = 0,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["ka"] = 0.7119999825954437,
						["edgeSize"] = 8,
						["br"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [20]
				{
					["feature"] = "ColorVariable: Unit PowerType Color",
					["rageColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.2,
					},
					["energyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.75,
						["r"] = 0.75,
					},
					["runeColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.75,
						["r"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.5450980392156862,
						["r"] = 0,
					},
				}, -- [21]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [22]
				{
					["frac"] = "fm",
					["flOffset"] = 2,
					["owner"] = "sf_mana",
					["w"] = "200",
					["colorVar"] = "powerColor",
					["feature"] = "statusbar_horiz",
					["h"] = "10",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_power",
					["interpolate"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [23]
				{
					["owner"] = "sf_mana",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["h"] = "14",
					["ty"] = "mptxt",
					["name"] = "text_mana",
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = "39",
					["name"] = "sf_sup",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["flOffset"] = 3,
				}, -- [26]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_sup",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 20,
						["ba"] = 0,
						["bb"] = 1,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["br"] = 1,
						["_backdrop"] = "none",
						["bg"] = 1,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [27]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "aggro",
					["set"] = {
						["class"] = "ags",
					},
				}, -- [28]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "red",
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
				}, -- [29]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "nocolor",
					["color"] = {
						["a"] = 0,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
				}, -- [30]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "aggrocolour",
					["colorVar1"] = "red",
					["colorVar2"] = "nocolor",
					["condVar"] = "aggro_flag",
				}, -- [31]
				{
					["feature"] = "Backdrop Border Colorizer",
					["owner"] = "sf_sup",
					["flag"] = "true",
					["color"] = "aggrocolour",
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["feature"] = "Raid Target Icon",
					["h"] = "30",
					["name"] = "rti",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = -3,
						["dy"] = -3,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "30",
					["drawLayer"] = "ARTWORK",
				}, -- [34]
				{
					["owner"] = "pdt",
					["w"] = "30",
					["feature"] = "txt_status",
					["h"] = "30",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["ty"] = "level",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 15,
					},
					["name"] = "status_text",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["feature"] = "txt_np",
					["h"] = "30",
					["version"] = 1,
					["font"] = {
						["size"] = 15,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["name"] = "np",
					["classColor"] = 1,
				}, -- [36]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_icons",
					["iconspx"] = 2,
					["cd"] = {
						["offsety"] = "0",
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 7,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["offsetx"] = "10",
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["anchor"] = {
						["dx"] = 4,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["iconspy"] = 0,
					["maxdurationfilter"] = "",
					["mindurationfilter"] = "",
					["auraType"] = "DEBUFFS",
					["owner"] = "pdt",
					["playerauras"] = 1,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["ButtonSkinOffset"] = 0,
					["version"] = 1,
					["nIcons"] = 10,
					["orientation"] = "RIGHT",
					["size"] = 12,
					["name"] = "debuff",
					["unitfilter"] = "",
				}, -- [37]
				{
					["mover"] = 1,
					["w"] = 206,
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 76,
					["flo"] = 3,
					["version"] = 1,
				}, -- [38]
			},
		},
		["Not_Dead_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"dead", -- [1]
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 27827,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [4]
			},
		},
		["Shaman_Totems8_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 108,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 108,
				}, -- [1]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_earth",
					["externalButtonSkin"] = "bs_serenity",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 9,
					["tex"] = "totemearth_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemearth",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [4]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "earth",
					["secure"] = 1,
					["h"] = 36,
				}, -- [5]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_Fire",
					["externalButtonSkin"] = "bs_serenity",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 72,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 9,
					["tex"] = "totemfire_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemfire",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [6]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 72,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "fire",
					["secure"] = 1,
					["h"] = 36,
				}, -- [7]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_water",
					["externalButtonSkin"] = "bs_serenity",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 36,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 9,
					["tex"] = "totemwater_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemwater",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [8]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 36,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "water",
					["secure"] = 1,
					["h"] = 36,
				}, -- [9]
				{
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["gt"] = "",
					["name"] = "texcd_air",
					["externalButtonSkin"] = "bs_serenity",
					["owner"] = "decor",
					["w"] = "36",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["version"] = 1,
					["ButtonSkinOffset"] = 9,
					["tex"] = "totemair_icon",
					["dyntexture"] = 1,
					["timerVar"] = "totemair",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [10]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "air",
					["secure"] = 1,
					["h"] = 36,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 36,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "remove",
					["secure"] = 1,
					["h"] = 36,
				}, -- [13]
			},
		},
		["Druid_EclipseBar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 16,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 124,
				}, -- [1]
				{
					["feature"] = "backdrop",
					["owner"] = "decor",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "HalStraight",
						["edgeSize"] = 8,
						["tile"] = false,
						["kr"] = 0,
						["kb"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kg"] = 0,
						["ka"] = 0.3999999761581421,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [2]
				{
					["feature"] = "var_issolar",
				}, -- [3]
				{
					["auraType"] = "BUFFS",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "lunar",
					["timer2"] = "0",
					["cd"] = 48518,
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["timer1"] = "0",
				}, -- [4]
				{
					["auraType"] = "BUFFS",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "solar",
					["timer2"] = "0",
					["cd"] = 48517,
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["timer1"] = "0",
				}, -- [5]
				{
					["feature"] = "commentline",
				}, -- [6]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.5,
						["r"] = 0.5,
					},
					["name"] = "BlueLightColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [7]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0,
					},
					["name"] = "BlueColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [8]
				{
					["condVar"] = "lunar_possible",
					["name"] = "LunarColor",
					["colorVar1"] = "BlueColor",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "BlueLightColor",
				}, -- [9]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.5,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "YellowLightColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [10]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "YellowColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [11]
				{
					["condVar"] = "solar_possible",
					["name"] = "SolarColor",
					["colorVar1"] = "YellowColor",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "YellowLightColor",
				}, -- [12]
				{
					["feature"] = "commentline",
				}, -- [13]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "SPELL_POWER_ECLIPSE",
					["name"] = "fm",
				}, -- [14]
				{
					["frac"] = "fm_i",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalA",
					},
					["owner"] = "decor",
					["w"] = "60",
					["name"] = "LunarBar",
					["feature"] = "statusbar_horiz",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["colorVar"] = "LunarColor",
					["interpolate"] = 1,
					["reducex"] = 1,
				}, -- [15]
				{
					["frac"] = "fm",
					["owner"] = "decor",
					["w"] = "60",
					["colorVar"] = "SolarColor",
					["feature"] = "statusbar_horiz",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "solarBar",
					["interpolate"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalA",
					},
				}, -- [16]
				{
					["feature"] = "commentline",
				}, -- [17]
			},
		},
		["Damage_Done_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_tablemeter",
					["tablemeter"] = "WoWRDX:Damage_Done_tm",
					["name"] = "combatmeter1",
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.2862745098039216,
						["g"] = 0.3098039215686275,
						["r"] = 1,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 13,
					["version"] = 1,
					["w"] = 180,
					["alpha"] = 1,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["interpolate"] = 1,
					["flOffset"] = 0,
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["h"] = "12",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["version"] = 1,
					["frac"] = "fcombatmeter1",
					["orientation"] = "HORIZONTAL",
					["name"] = "statusBar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Ruben",
					},
				}, -- [5]
				{
					["owner"] = "pdt",
					["w"] = "60",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["h"] = "12",
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [6]
				{
					["txt"] = "combatmeter1_text",
					["owner"] = "pdt",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_pdt",
					},
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sr"] = 0,
					},
					["name"] = "infoText",
				}, -- [7]
				{
					["feature"] = "shader_showhide",
					["owner"] = "pdt",
					["version"] = 1,
					["flag"] = "bcombatmeter1",
				}, -- [8]
			},
		},
		["Focustarget_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Targettarget_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["unitWatch"] = 1,
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "focustarget",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Player_Main_mb",
				}, -- [4]
				{
					["interval"] = 0.1,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [5]
			},
		},
		["Focus_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Target_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["unitWatch"] = 1,
					["version"] = 1,
					["clickable"] = 1,
					["unit"] = "focus",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Player_Main_mb",
				}, -- [4]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.1,
					["slot"] = "RepaintAll",
				}, -- [5]
			},
		},
		["Dispell_Grid_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "unshiftedSet",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Primary_fset",
					},
				}, -- [1]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "shifted",
					["set"] = {
						["file"] = "WoWRDX:Debuff_Secondary_fset",
						["class"] = "file",
					},
				}, -- [2]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "range",
					["set"] = {
						["class"] = "unitinrange",
					},
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["color"] = {
						["a"] = 0.8,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "unshifted",
					["feature"] = "ColorVariable: Static Color",
				}, -- [5]
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [6]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0.03529411764705882,
					},
					["name"] = "shTrue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [7]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "shFalse",
					["feature"] = "ColorVariable: Static Color",
				}, -- [8]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "shColor",
					["colorVar1"] = "shTrue",
					["colorVar2"] = "shFalse",
					["condVar"] = "shifted_flag",
				}, -- [9]
				{
					["feature"] = "commentline",
				}, -- [10]
				{
					["feature"] = "base_default",
					["h"] = 30,
					["version"] = 1,
					["w"] = 30,
					["alpha"] = 1,
					["ph"] = 1,
				}, -- [11]
				{
					["feature"] = "backdrop",
					["owner"] = "decor",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [12]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "decor",
					["w"] = "22",
					["feature"] = "texture",
					["h"] = "22",
					["version"] = 1,
					["name"] = "unshiftedHlt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\whackaMole",
					},
				}, -- [13]
				{
					["feature"] = "shaderTex_showhide",
					["owner"] = "unshiftedHlt",
					["version"] = 1,
					["flag"] = "unshiftedSet_flag",
				}, -- [14]
				{
					["feature"] = "Backdrop Border Colorizer",
					["owner"] = "decor",
					["flag"] = "true",
					["color"] = "shColor",
				}, -- [15]
				{
					["script"] = "WoWRDX:Dispell_Grid_Shiftcode_sc",
					["owner"] = "decor",
					["w"] = "20",
					["feature"] = "txt_custom",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 6,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -2,
						["lp"] = "TOP",
						["rp"] = "TOP",
						["af"] = "Base",
					},
					["h"] = "14",
					["name"] = "shiftText",
				}, -- [16]
				{
					["falseAlpha"] = 0.3,
					["version"] = 1,
					["flag"] = "range_flag",
					["owner"] = "decor",
					["trueAlpha"] = 1,
					["feature"] = "shader_ca",
				}, -- [17]
				{
					["owner"] = "decor",
					["w"] = "20",
					["classColor"] = 1,
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["name"] = "np",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 2,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["trunc"] = 3,
					["feature"] = "txt_np",
					["h"] = "14",
				}, -- [18]
			},
		},
		["Deathknight_Runes4_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 50,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 144,
				}, -- [1]
				{
					["feature"] = "Vars: Rune Info",
					["TextureType"] = "Normal",
					["colors"] = {
						{
							["a"] = 1,
							["r"] = 1,
							["g"] = 0,
							["b"] = 0.2,
						}, -- [1]
						{
							["a"] = 1,
							["r"] = 0,
							["g"] = 1,
							["b"] = 0,
						}, -- [2]
						{
							["a"] = 1,
							["r"] = 0,
							["g"] = 0.6000000000000001,
							["b"] = 1,
						}, -- [3]
						{
							["a"] = 1,
							["r"] = 0.6000000000000001,
							["g"] = 0.3,
							["b"] = 0.6000000000000001,
						}, -- [4]
					},
				}, -- [2]
				{
					["feature"] = "commentline",
				}, -- [3]
				{
					["cdFont"] = {
						["cr"] = 1,
						["flags"] = "OUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["title"] = "Default",
						["cb"] = 0.08235294117647057,
						["justifyH"] = "CENTER",
						["sy"] = 0,
						["name"] = "Default",
						["size"] = 10,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["name"] = "rune1_tc",
					["version"] = 1,
					["cdoffx"] = 0,
					["tex"] = "rune1_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune1",
					["cdHideTxt"] = "0",
				}, -- [4]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["cr"] = 1,
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["justifyH"] = "CENTER",
						["cb"] = 0.08235294117647057,
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["name"] = "rune2_tc",
					["version"] = 1,
					["cdoffx"] = 0,
					["tex"] = "rune2_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune2",
					["cdHideTxt"] = "0",
				}, -- [5]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["cr"] = 1,
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["justifyH"] = "CENTER",
						["cb"] = 0.08235294117647057,
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["name"] = "rune3_tc",
					["version"] = 1,
					["cdoffx"] = 0,
					["tex"] = "rune3_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune3",
					["cdHideTxt"] = "0",
				}, -- [6]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["cr"] = 1,
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["name"] = "Default",
						["cb"] = 0.08235294117647057,
						["ca"] = 1,
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["size"] = 10,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["name"] = "rune4_tc",
					["version"] = 1,
					["cdoffx"] = 0,
					["tex"] = "rune4_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune4",
					["cdHideTxt"] = "0",
				}, -- [7]
				{
					["cdFont"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 0,
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["name"] = "Default",
						["cb"] = 0.08235294117647057,
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["sy"] = 0,
						["size"] = 10,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 144,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["name"] = "rune5_tc",
					["version"] = 1,
					["cdoffx"] = 0,
					["tex"] = "rune5_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune5",
					["cdHideTxt"] = "0",
				}, -- [8]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["cr"] = 1,
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["title"] = "Default",
						["cb"] = 0.08235294117647057,
						["ca"] = 1,
						["name"] = "Default",
						["justifyH"] = "CENTER",
						["size"] = 10,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 180,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "Builtin:bs_default",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["name"] = "rune6_tc",
					["version"] = 1,
					["cdoffx"] = 0,
					["tex"] = "rune6_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune6",
					["cdHideTxt"] = "0",
				}, -- [9]
			},
		},
		["Shaman_Totem_Air_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = "Totem de courroux de l'air",
				},
			},
		},
		["Player_Buff_Bar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_Buff_Bar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["switchvehicle"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ActionBarPet"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:ActionBarPet_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Paladin_Buff_Might_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				19740, -- [1]
			},
		},
		["Range_0_10_ODM"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Rng 0-10",
					["feature"] = "Frame: Black",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Range_ds",
				}, -- [2]
				{
					["feature"] = "Description",
					["description"] = "Range Window 0-10yd",
				}, -- [3]
				{
					["feature"] = "Data Source: Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Range_0_10_ODM_fset",
					},
				}, -- [4]
				{
					["feature"] = "Grid Layout",
					["limit"] = 5,
					["dxn"] = 1,
					["axis"] = 1,
					["cols"] = 1,
				}, -- [5]
			},
		},
		["Deathknight_Runes5_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 216,
				}, -- [1]
				{
					["size"] = 36,
					["owner"] = "decor",
					["rows"] = 1,
					["version"] = 1,
					["feature"] = "runes_bar",
					["iconspx"] = 0,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "RIGHT",
					["name"] = "rune_bar",
					["iconspy"] = 0,
					["nIcons"] = 6,
				}, -- [2]
			},
		},
		["Dead_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"ol", -- [1]
				}, -- [2]
				{
					"dead", -- [1]
				}, -- [3]
				{
					"nidmask", -- [1]
				}, -- [4]
			},
		},
		["Range_0_40_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "unitinrange",
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Raid_desk"] = {
			["ty"] = "Desktop",
			["version"] = 2,
			["data"] = {
				{
					["strata"] = "BACKGROUND",
					["b"] = 0,
					["scale"] = 1,
					["dgp"] = true,
					["feature"] = "Desktop main",
					["offsetbottom"] = "0",
					["l"] = 0,
					["offsettop"] = "0",
					["r"] = 1365.333426704711,
					["root"] = true,
					["t"] = 767.9999824928667,
					["anchorx"] = 1083.1998810609,
					["alpha"] = 1,
					["name"] = "root",
					["offsetright"] = "0",
					["title"] = "Konyagi_AUI:desk_solo",
					["open"] = true,
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_SecureDebuff_Icon",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -20,
						},
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 20,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = -20,
							["point"] = "BOTTOMLEFT",
							["y"] = -20,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Combat_Logs",
							["x"] = 20,
							["point"] = "BOTTOMRIGHT",
							["y"] = -20,
						},
					},
					["offsetleft"] = "0",
					["anchory"] = 207.6800844938,
					["ap"] = "TOPLEFT",
				}, -- [1]
				{
					["strata"] = "MEDIUM",
					["r"] = 866.9866965304984,
					["scale"] = 1,
					["t"] = 47.78666548950701,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 17.06666731335399,
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 20,
						},
					},
				}, -- [2]
				{
					["strata"] = "MEDIUM",
					["r"] = 1348.266710285255,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1317.546600063446,
					["b"] = 199.680014288981,
					["dock"] = {
						["RIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "RIGHT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar4",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["r"] = 1317.546600063446,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1286.826609357003,
					["b"] = 199.680014288981,
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar3",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
				}, -- [4]
				{
					["strata"] = "MEDIUM",
					["r"] = 866.9866965304984,
					["scale"] = 1,
					["t"] = 78.50667113537041,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 47.78666548950701,
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
				}, -- [5]
				{
					["strata"] = "MEDIUM",
					["r"] = 866.9866965304984,
					["scale"] = 1,
					["t"] = 109.2266693115234,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 78.50667113537041,
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
				}, -- [6]
				{
					["strata"] = "MEDIUM",
					["r"] = 805.54665535993,
					["scale"] = 1,
					["t"] = 139.9466674876765,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 109.2266693115234,
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBar6",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
				}, -- [7]
				{
					["strata"] = "MEDIUM",
					["r"] = 805.54665535993,
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 139.9466674876765,
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBarVehicle",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ActionBarPet",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
				}, -- [8]
				{
					["strata"] = "MEDIUM",
					["r"] = 897.7066274792579,
					["scale"] = 1,
					["t"] = 170.6666731335399,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 139.9466674876765,
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBarStance",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
				}, -- [9]
				{
					["strata"] = "MEDIUM",
					["r"] = 358.4000210501441,
					["scale"] = 1,
					["t"] = 128.0000160547205,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 102.4000113498343,
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:XpBar",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
					},
				}, -- [10]
				{
					["strata"] = "MEDIUM",
					["r"] = 358.4000210501441,
					["scale"] = 1,
					["t"] = 102.4000113498343,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 17.06666731335399,
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "root",
							["x"] = 20,
							["point"] = "BOTTOMLEFT",
							["y"] = 20,
						},
					},
				}, -- [11]
				{
					["strata"] = "MEDIUM",
					["r"] = 358.4000210501441,
					["scale"] = 1,
					["t"] = 140.8000221420188,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:XpBar",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 187.7333479166043,
					["open"] = true,
					["b"] = 128.0000160547205,
				}, -- [12]
				{
					["strata"] = "MEDIUM",
					["r"] = 1365.333385068319,
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 725.3333197341373,
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["r"] = 341.3333462670797,
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 0,
					["b"] = 721.0666211595296,
					["dock"] = {
						["TOPLEFT"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
				}, -- [14]
				{
					["strata"] = "MEDIUM",
					["r"] = 464.2133688505334,
					["scale"] = 1,
					["t"] = 402.8929924404083,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 288.4267022457266,
					["b"] = 338.0396521678369,
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 10,
						},
					},
				}, -- [15]
				{
					["strata"] = "MEDIUM",
					["r"] = 722.7733603470558,
					["scale"] = 1,
					["t"] = 242.4662913099814,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 546.9866937422491,
					["b"] = 220.2796081162294,
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -50,
						},
					},
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -10,
						},
					},
					["scale"] = 1,
					["t"] = 329.5063147763047,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 288.4267022457266,
					["b"] = 264.6529745037333,
					["r"] = 464.2133688505334,
				}, -- [17]
				{
					["strata"] = "MEDIUM",
					["b"] = 679.2533934321565,
					["scale"] = 1,
					["t"] = 706.560025278913,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMapButtons",
					["anchor"] = "TOPLEFT",
					["l"] = 1063.253396778056,
					["open"] = true,
					["r"] = 1199.786795042571,
				}, -- [18]
				{
					["strata"] = "MEDIUM",
					["r"] = 805.54665535993,
					["scale"] = 1,
					["t"] = 455.7996364617614,
					["open"] = true,
					["feature"] = "desktop_window",
					["dgp"] = true,
					["name"] = "WoWRDX:Panel_Center",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 464.2133688505334,
					["b"] = 285.1329483888007,
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["BOTTOM"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 50,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["r"] = 981.3333219647368,
					["scale"] = 1,
					["t"] = 402.8929924404083,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Target_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 338.0396521678369,
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:Targettarget_Main",
							["x"] = -10,
							["point"] = "LEFT",
							["y"] = 0,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
				}, -- [20]
				{
					["strata"] = "MEDIUM",
					["r"] = 1165.653206445709,
					["scale"] = 1,
					["t"] = 402.8929924404083,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 989.8665995985858,
					["b"] = 338.0396521678369,
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "BOTTOMRIGHT",
							["y"] = 20,
						},
					},
					["scale"] = 1,
					["t"] = 145.0666609589433,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Combat_Logs",
					["r"] = 1348.266710285255,
					["anchor"] = "TOPLEFT",
					["l"] = 1015.466611773182,
					["b"] = 17.06666731335399,
					["open"] = true,
				}, -- [22]
				{
					["strata"] = "MEDIUM",
					["r"] = 1358.506906379679,
					["scale"] = 1,
					["t"] = 711.6799440530759,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMap",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1235.626943553909,
					["b"] = 588.7999214696223,
					["ap"] = "TOPLEFT",
				}, -- [23]
				{
					["strata"] = "MEDIUM",
					["b"] = 401.0665884924388,
					["scale"] = 1,
					["t"] = 660.4800392192491,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Boss",
					["r"] = 1211.733670566838,
					["anchor"] = "TOPLEFT",
					["l"] = 1035.947003962032,
					["open"] = true,
					["ap"] = "TOPLEFT",
				}, -- [24]
			},
		},
		["Heal_Done_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"nidmask", -- [1]
				}, -- [2]
				{
					"tablemeter", -- [1]
					"WoWRDX:Heal_Done_tm", -- [2]
					1, -- [3]
					10000000, -- [4]
				}, -- [3]
			},
		},
		["Shaman_Totems3"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems3_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Panel_Center"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Panel_Center_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["FactionBar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:FactionBar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Deathknight_Runes8_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 21,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 216,
				}, -- [1]
				{
					["sizew"] = 34,
					["customtexture"] = 1,
					["rows"] = 1,
					["bloodColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0,
						["r"] = 1,
					},
					["feature"] = "runes_bar_vars",
					["iconspx"] = 2,
					["runetexture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Smoothv2",
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
					["iconspy"] = 0,
					["unholyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["owner"] = "decor",
					["name"] = "rune_bar_skin",
					["deathColor"] = {
						["a"] = 1,
						["b"] = 0.6000000000000001,
						["g"] = 0.3,
						["r"] = 0.6000000000000001,
					},
					["version"] = 1,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["orientation"] = "RIGHT",
					["frostColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6000000000000001,
						["r"] = 0,
					},
					["sizeh"] = 20,
					["nIcons"] = 6,
				}, -- [2]
			},
		},
		["Alive_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"dead", -- [1]
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
				{
					"nidmask", -- [1]
				}, -- [4]
			},
		},
		["Healer_Health_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["qty"] = "shp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Healer_fset",
					},
				},
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["name"] = "Healer HP",
				["sv"] = 1,
				["color"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["max"] = {
					["qty"] = "smaxhp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Healer_fset",
					},
				},
				["pct"] = 1,
				["texture"] = "",
			},
		},
		["Range_0_15_ODM"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Rng 10-15",
					["feature"] = "Frame: Black",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Range_ds",
				}, -- [2]
				{
					["feature"] = "Description",
					["description"] = "Range Window 10-15yd (Requires Heavy Frostweave Bandage)",
				}, -- [3]
				{
					["feature"] = "Data Source: Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Range_0_15_ODM_fset",
					},
				}, -- [4]
				{
					["feature"] = "Grid Layout",
					["limit"] = 5,
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [5]
			},
		},
		["Damage_Done_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["vname"] = "cs8874173",
						["op"] = "tablemeter",
						["path"] = "WoWRDX:Damage_Done_tm",
					}, -- [1]
				},
				["set"] = {
					["file"] = "WoWRDX:Damage_Done_fset",
					["class"] = "file",
				},
			},
		},
		["Raid_GroupAll"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group All",
					["bkd"] = {
						["_backdrop"] = "none",
						["_border"] = "none",
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Raid_GroupAll_fset",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["cols"] = 20,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Shaman_Totem_Fire_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = "Totem Langue de feu",
				},
			},
		},
		["Shaman_Totems2_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 80,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 200,
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.7882352941176469,
						["g"] = 0.776470588235294,
						["b"] = 0,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6196078431372554,
						["r"] = 0,
					},
					["name"] = "blue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [3]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.05490196078431373,
						["b"] = 0,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [4]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.1333333333333333,
						["g"] = 0.4862745098039216,
						["r"] = 0,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [5]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [6]
				{
					["feature"] = "commentline",
				}, -- [7]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "green",
					["version"] = 1,
					["h"] = 20,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemEarthBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [8]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemEarthIcon",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [9]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["name"] = "EarthTimer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["size"] = 9,
					},
				}, -- [10]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemEarthBar",
					["text"] = "EarthTimer",
					["texIcon"] = "TotemEarthIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["TEIExpireState"] = "Hide",
				}, -- [11]
				{
					["txt"] = "totemearth_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["name"] = "status_text_earth",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
				}, -- [12]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "earth",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["flo"] = 3,
					["h"] = 20,
				}, -- [13]
				{
					["feature"] = "commentline",
				}, -- [14]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["version"] = 1,
					["h"] = 20,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemFireBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [15]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemFireIcon",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [16]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemFireBar",
					},
					["h"] = 14,
					["name"] = "FireTimer",
				}, -- [17]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemFireBar",
					["text"] = "FireTimer",
					["texIcon"] = "TotemFireIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["TEIExpireState"] = "Hide",
				}, -- [18]
				{
					["txt"] = "totemfire_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["name"] = "status_text_firea",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemFireBar",
					},
					["version"] = 1,
					["h"] = 14,
				}, -- [19]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["secure"] = 1,
					["h"] = 20,
					["name"] = "fire",
				}, -- [20]
				{
					["feature"] = "commentline",
				}, -- [21]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "blue",
					["version"] = 1,
					["h"] = 20,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemWaterBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [22]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["name"] = "TotemWaterIcon",
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [23]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemWaterBar",
					},
					["h"] = 14,
					["name"] = "WaterTimer",
				}, -- [24]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemWaterBar",
					["text"] = "WaterTimer",
					["texIcon"] = "TotemWaterIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemwater_icon",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["TEIExpireState"] = "Hide",
				}, -- [25]
				{
					["txt"] = "totemwater_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["name"] = "status_text_water",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemWaterBar",
					},
					["version"] = 1,
					["h"] = 14,
				}, -- [26]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["secure"] = 1,
					["h"] = 20,
					["name"] = "water",
				}, -- [27]
				{
					["feature"] = "commentline",
				}, -- [28]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "yellow",
					["version"] = 1,
					["h"] = 20,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "TotemAirBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [29]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemAirIcon",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [30]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemAirBar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["name"] = "AirTimer",
				}, -- [31]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemAirBar",
					["text"] = "AirTimer",
					["texIcon"] = "TotemAirIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemair_icon",
					["txt"] = "",
					["timerVar"] = "totemair",
					["TEIExpireState"] = "Hide",
				}, -- [32]
				{
					["txt"] = "totemair_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemAirBar",
					},
					["h"] = 14,
					["name"] = "status_text_air",
				}, -- [33]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["h"] = 20,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "air",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [34]
				{
					["feature"] = "commentline",
				}, -- [35]
				{
					["w"] = 20,
					["feature"] = "hotspot",
					["h"] = 80,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "remove",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [36]
				{
					["feature"] = "Subframe",
					["h"] = 80,
					["name"] = "remove_s",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 20,
					["flOffset"] = 1,
				}, -- [37]
			},
		},
		["Health_Power_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [2]
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [3]
				{
					["energyColor"] = {
						["a"] = 1,
						["r"] = 0.75,
						["g"] = 0.75,
						["b"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0.75,
					},
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.75,
						["b"] = 1,
					},
					["rageColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [4]
				{
					["feature"] = "commentline",
				}, -- [5]
				{
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 90,
					["feature"] = "base_default",
				}, -- [6]
				{
					["interpolate"] = 1,
					["frac"] = "fh",
					["owner"] = "Base",
					["w"] = "90",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "11",
					["name"] = "hpbar",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [7]
				{
					["interpolate"] = 1,
					["owner"] = "Base",
					["w"] = "90",
					["colorVar"] = "powerColor",
					["feature"] = "statusbar_horiz",
					["h"] = "3",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "ppbar",
					["frac"] = "1",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [8]
				{
					["owner"] = "Base",
					["w"] = "50",
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["h"] = "14",
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [9]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 8,
					},
					["name"] = "text_hp_percent",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["ty"] = "hpp",
					["h"] = "14",
				}, -- [10]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 8,
					},
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["ty"] = "fdld",
					["h"] = "14",
				}, -- [11]
			},
		},
		["Damage_Done"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Ability_BackStab",
					},
					["feature"] = "Frame: Lightweight",
					["showtitlebar"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["title"] = "Damage Done",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Damage_Done_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Damage_Done_sort",
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["countTitle"] = 1,
					["limit"] = 10,
					["dxn"] = 1,
					["axis"] = 1,
					["cols"] = 1,
				}, -- [4]
				{
					["feature"] = "Sort Editor",
				}, -- [5]
				{
					["feature"] = "FilterSet Editor",
				}, -- [6]
				{
					["feature"] = "TableMeter Editor",
					["path"] = "WoWRDX:Damage_Done_tm",
				}, -- [7]
			},
		},
		["Assists_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "target",
				},
				["S1"] = {
					["action"] = "assist",
				},
				["2"] = {
					["action"] = "menu",
				},
			},
		},
		["Player_SecureDebuff_Icon"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_SecureDebuff_Icon_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["switchvehicle"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Debuff_Both_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Primary_fset",
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Secondary_fset",
					}, -- [2]
				}, -- [3]
			},
		},
		["Pettarget_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Targettarget_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["unitWatch"] = 1,
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "pettarget",
				}, -- [3]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.1,
					["slot"] = "RepaintAll",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Player_Main_mb",
				}, -- [5]
			},
		},
		["Priest_Buff_Shadow_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "buff",
						["buff"] = 79107,
					}, -- [2]
				}, -- [2]
			},
		},
		["Heal_Done_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["vname"] = "cs8086490",
						["op"] = "tablemeter",
						["path"] = "WoWRDX:Heal_Done_tm",
					}, -- [1]
				},
				["set"] = {
					["file"] = "WoWRDX:Heal_Done_fset",
					["class"] = "file",
				},
			},
		},
		["Mage_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Mage",
				["color"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 0.3333333333333333,
					["b"] = 1,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Mage_fset",
					},
				},
				["sv"] = 2,
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Mage_fset",
					},
				},
			},
		},
		["Raid_Group6"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Raid Group 6",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_raid_group6",
					},
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["cols"] = 40,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Paladin_HolyPower_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 20,
					["version"] = 1,
					["w"] = 100,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "Variable: Number power",
					["powertype"] = "SPELL_POWER_HOLY_POWER",
					["name"] = "nm",
				}, -- [2]
				{
					["number"] = "nm",
					["rows"] = 1,
					["feature"] = "custom_icons",
					["iconspx"] = 5,
					["color4"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["ButtonSkinOffset"] = 3,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["nIcons"] = 5,
					["h"] = 20,
					["usebs"] = true,
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["name"] = "customicon1",
					["version"] = 1,
					["orientation"] = "RIGHT",
					["drawLayer"] = "ARTWORK",
					["color5"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["bkd"] = {
						["ka"] = 1,
						["edgeSize"] = 12,
						["tile"] = false,
						["kr"] = 0.1,
						["kb"] = 0.1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["kg"] = 0.1,
						["_border"] = "IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
				}, -- [3]
			},
		},
		["Raid_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"nidmask", -- [1]
			},
		},
		["Shaman_Totem_Water_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 5675,
				},
			},
		},
		["Range_0_15_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["item"] = "heavy frostweave bandage",
						["class"] = "itemrange",
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Paladin_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.6352941176470583,
					["g"] = 0,
					["b"] = 0.5372549019607842,
				},
				["name"] = "Paladin",
				["color"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.2274509803921569,
					["b"] = 0.4862745098039216,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Paladin_fset",
					},
				},
				["sv"] = 2,
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Paladin_fset",
					},
				},
			},
		},
		["ClassBarDefault_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["w"] = 90,
					["alpha"] = 1,
				}, -- [1]
			},
		},
		["Tank_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"role", -- [1]
					true, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
				{
					"nidmask", -- [1]
				}, -- [4]
			},
		},
		["Player_Debuff_Bar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 150,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 105,
				}, -- [1]
				{
					["borientation"] = "HORIZONTAL",
					["iconfont"] = {
						["sr"] = 0,
						["flags"] = "OUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["rows"] = 1,
					["filterNameList"] = {
					},
					["sbcolor"] = 1,
					["feature"] = "aura_bars2",
					["iconspx"] = 0,
					["bkd"] = {
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_backdrop"] = "solid",
						["tile"] = true,
						["ka"] = 0.4959999918937683,
						["kb"] = 0.9450980392156863,
						["kg"] = 1,
						["kr"] = 0.7490196078431373,
					},
					["anchor"] = {
						["dx"] = 15,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["unitfilter"] = "",
					["iconspy"] = 1,
					["nIcons"] = 10,
					["smooth"] = 1,
					["sbtexture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
					["mindurationfilter"] = 0,
					["sbfont"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\airstrip.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["h"] = "14",
					["owner"] = "Base",
					["w"] = "90",
					["sbtimerfont"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\airstrip.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["name"] = "ab1",
					["countTypeFlag"] = "false",
					["version"] = 2,
					["auraType"] = "DEBUFFS",
					["orientation"] = "DOWN",
					["abr"] = 1,
					["maxdurationfilter"] = 3000,
					["iconposition"] = "LEFT",
				}, -- [2]
			},
		},
		["Dispell_Grid_Audio_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["file"] = "WoWRDX:Dispell_Grid_Data_fset",
						["class"] = "file",
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["class"] = "unitinrange",
					}, -- [2]
				}, -- [3]
				{
					"or", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Debuff_Primary_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Debuff_Secondary_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [3]
				}, -- [4]
			},
		},
		["Rez_Monitor"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Description",
					["description"] = "A window for monitoring targets of resurrection spells currently being cast.",
				}, -- [1]
				{
					["feature"] = "Frame: Default",
					["title"] = "Rez Monitor",
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
				}, -- [2]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Rez_Monitor_ds",
				}, -- [3]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Rez_Monitor_sort",
					["rostertype"] = "RAID",
				}, -- [4]
				{
					["feature"] = "Grid Layout",
					["dxn"] = 2,
					["cols"] = 3,
					["autoShowHide"] = 1,
					["axis"] = 1,
				}, -- [5]
			},
		},
		["Player_CastBar"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_CastBar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Not_Elixirs_Guardian_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 11348,
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 11396,
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 24363,
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28502,
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28509,
						}, -- [2]
					}, -- [2]
				}, -- [6]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 28514,
						}, -- [2]
					}, -- [2]
				}, -- [7]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 39625,
						}, -- [2]
					}, -- [2]
				}, -- [8]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 39626,
						}, -- [2]
					}, -- [2]
				}, -- [9]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 39627,
						}, -- [2]
					}, -- [2]
				}, -- [10]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "buff",
							["buff"] = 39628,
						}, -- [2]
					}, -- [2]
				}, -- [11]
			},
		},
		["Range_30_40_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "unitinrange",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_15_30_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"ol", -- [1]
				}, -- [5]
			},
		},
		["Deathknight_Runes6_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 218,
				}, -- [1]
				{
					["sizew"] = 36,
					["rows"] = 1,
					["bloodColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0,
						["r"] = 1,
					},
					["feature"] = "runes_bar_vars",
					["iconspx"] = 0,
					["runetexture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
					["iconspy"] = 0,
					["unholyColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["owner"] = "decor",
					["name"] = "rune_bar_skin",
					["deathColor"] = {
						["a"] = 1,
						["b"] = 0.6000000000000001,
						["g"] = 0.3,
						["r"] = 0.6000000000000001,
					},
					["version"] = 1,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["orientation"] = "RIGHT",
					["frostColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6000000000000001,
						["r"] = 0,
					},
					["sizeh"] = 36,
					["nIcons"] = 6,
				}, -- [2]
			},
		},
		["Mage_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"classes", -- [1]
					[8] = true,
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Range_0_10_ODM_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["n"] = 2,
						["class"] = "frs",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"me", -- [1]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
				{
					"not", -- [1]
					{
						"dead", -- [1]
					}, -- [2]
				}, -- [5]
				{
					"nidmask", -- [1]
					true, -- [2]
				}, -- [6]
			},
		},
		["Range_15_30_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["n"] = 3,
						["class"] = "frs",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "WoWRDX:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
			},
		},
		["ChatEditBox1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 30,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 400,
				}, -- [1]
				{
					["feature"] = "chatframeeditbox",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 400,
					["ak"] = 1,
				}, -- [2]
			},
		},
		["Paladin_Buff_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [1]
				{
					["feature"] = "commentline",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 20,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 138,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "sub1",
					["anchor"] = {
						["dx"] = 100,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "20",
					["flOffset"] = 1,
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sub1",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [5]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "sub2",
					["anchor"] = {
						["dx"] = 120,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 20,
					["flOffset"] = 1,
				}, -- [6]
				{
					["feature"] = "backdrop",
					["owner"] = "sub2",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "straight",
						["edgeSize"] = 8,
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [7]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "subframe",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 100,
					["flOffset"] = 1,
				}, -- [8]
				{
					["owner"] = "decor",
					["w"] = 70,
					["feature"] = "txt_np",
					["h"] = 18,
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["size"] = 10,
					},
					["classColor"] = 1,
					["version"] = 1,
				}, -- [9]
				{
					["owner"] = "subframe",
					["w"] = 20,
					["feature"] = "ico_subclass",
					["h"] = 20,
					["name"] = "rtai",
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 75,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["ukfilter"] = 1,
					["drawLayer"] = "ARTWORK",
				}, -- [10]
				{
					["externalNameFilter"] = "WoWRDX:Paladin_Buff_Kings_af",
					["rows"] = 1,
					["fontst"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 0,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["Offsety"] = 0,
						["TimerType"] = "COOLDOWN",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 1,
					["anchor"] = {
						["dx"] = 102,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["iconspy"] = 0,
					["nIcons"] = 1,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "sub1",
					["usebs"] = true,
					["filterName"] = 1,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "kinga",
					["orientation"] = "RIGHT",
					["size"] = 16,
					["filterNameList"] = {
					},
					["unitfilter"] = "",
				}, -- [11]
				{
					["w"] = "16",
					["feature"] = "hotspot",
					["flo"] = 3,
					["name"] = "kings",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 102,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["h"] = "16",
					["secure"] = 1,
				}, -- [12]
				{
					["externalNameFilter"] = "WoWRDX:Paladin_Buff_Might_af",
					["rows"] = 1,
					["fontst"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 0,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["Offsety"] = 0,
						["TimerType"] = "COOLDOWN",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 1,
					["anchor"] = {
						["dx"] = 122,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["iconspy"] = 0,
					["nIcons"] = 1,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "sub2",
					["usebs"] = true,
					["filterName"] = 1,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "mighta",
					["orientation"] = "RIGHT",
					["size"] = 16,
					["filterNameList"] = {
					},
					["unitfilter"] = "",
				}, -- [13]
				{
					["w"] = "16",
					["feature"] = "hotspot",
					["flo"] = 3,
					["name"] = "might",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 122,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["h"] = "16",
					["secure"] = 1,
				}, -- [14]
				{
					["feature"] = "commentline",
				}, -- [15]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "texture",
					["h"] = "19",
					["name"] = "tex_range",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["vertexColor"] = {
							["a"] = 0,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [16]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "unitnotInRange30",
					["set"] = {
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
						["class"] = "file",
					},
				}, -- [17]
				{
					["color"] = {
						["a"] = 0.8039999902248383,
						["b"] = 0,
						["g"] = 0.04705882352941176,
						["r"] = 0.5882352941176472,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [18]
				{
					["color"] = {
						["a"] = 0,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [19]
				{
					["condVar"] = "unitnotInRange30_flag",
					["name"] = "range",
					["colorVar1"] = "red",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "alpha",
				}, -- [20]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "true",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [21]
			},
		},
		["Tank_health_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["qty"] = "shp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Tank_fset",
					},
				},
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["name"] = "Tank HP",
				["sv"] = 1,
				["color"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["max"] = {
					["qty"] = "smaxhp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Tank_fset",
					},
				},
				["pct"] = 1,
				["texture"] = "",
			},
		},
		["Overheal_Done"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Overhealing Done",
					["showtitlebar"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_Restoration",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Overheal_Done_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Overheal_Done_sort",
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["countTitle"] = 1,
					["limit"] = 10,
					["dxn"] = 1,
					["axis"] = 1,
					["cols"] = 1,
				}, -- [4]
				{
					["feature"] = "Sort Editor",
				}, -- [5]
				{
					["feature"] = "FilterSet Editor",
				}, -- [6]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.1,
					["slot"] = "RepaintAll",
				}, -- [7]
				{
					["feature"] = "TableMeter Editor",
					["path"] = "WoWRDX:Overheal_Done_tm",
				}, -- [8]
			},
		},
		["Player_CastBar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_spellinfo",
				}, -- [1]
				{
					["feature"] = "var_castlag",
				}, -- [2]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "yellow",
					["color"] = {
						["a"] = 1,
						["r"] = 0.788235294117647,
						["g"] = 0.7764705882352941,
						["b"] = 0,
					},
				}, -- [3]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 1,
						["r"] = 0.3254901960784314,
						["g"] = 0.7568627450980392,
						["b"] = 0,
					},
				}, -- [4]
				{
					["condVar"] = "spell_channeled",
					["name"] = "barColor",
					["colorVar1"] = "yellow",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "green",
				}, -- [5]
				{
					["feature"] = "commentline",
				}, -- [6]
				{
					["feature"] = "base_default",
					["h"] = 26,
					["version"] = 1,
					["w"] = 206,
					["alpha"] = 1,
				}, -- [7]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "subframe",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [8]
				{
					["feature"] = "backdrop",
					["owner"] = "subframe",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.4239999651908875,
						["kg"] = 0,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["_border"] = "HalStraight",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["_backdrop"] = "solid",
						["edgeSize"] = 8,
						["br"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [9]
				{
					["frac"] = "",
					["flOffset"] = 0,
					["owner"] = "subframe",
					["w"] = "180",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["version"] = 1,
					["colorVar"] = "barColor",
					["anchor"] = {
						["dx"] = 23,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_subframe",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "castBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [10]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "subframe",
					["w"] = "2",
					["feature"] = "texture",
					["h"] = "20",
					["name"] = "highlight",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_castBar",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["color"] = {
							["a"] = 0.718999981880188,
							["r"] = 1,
							["g"] = 1,
							["b"] = 0,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [11]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_subframe",
					},
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["name"] = "spellTimer",
				}, -- [12]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "150",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 25,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_subframe",
					},
					["name"] = "spellname",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
				}, -- [13]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "subframe",
					["w"] = "20",
					["feature"] = "texture",
					["h"] = "20",
					["version"] = 1,
					["name"] = "spellIcon",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_subframe",
					},
					["drawLayer"] = "OVERLAY",
					["sublevel"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "",
					},
				}, -- [14]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "spellname",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Tenths",
					["statusBar"] = "castBar",
					["text"] = "spellTimer",
					["texIcon"] = "spellIcon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "spell_casting",
					["tex"] = "spell_icon",
					["txt"] = "spell_name_rank",
					["timerVar"] = "spell",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [15]
				{
					["frac"] = "spell_fraclag",
					["flOffset"] = 0,
					["owner"] = "subframe",
					["w"] = "180",
					["color1"] = {
						["a"] = 0.4695078730583191,
						["r"] = 1,
						["g"] = 0.2784313725490196,
						["b"] = 0,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["version"] = 1,
					["color2"] = {
						["a"] = 0.4695078730583191,
						["r"] = 1,
						["g"] = 0.2784313725490196,
						["b"] = 0,
					},
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_subframe",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "lagBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalU",
					},
				}, -- [16]
				{
					["txt"] = "spell_lag_number",
					["owner"] = "subframe",
					["w"] = "50",
					["feature"] = "txt_dyn",
					["h"] = "14",
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Frame_subframe",
					},
					["version"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
				}, -- [17]
				{
					["feature"] = "shader_showhide",
					["owner"] = "subframe",
					["version"] = 1,
					["flag"] = "spell_castingOrChanneled",
				}, -- [18]
			},
		},
		["Info"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Info",
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Info_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["ActionBar3_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 432,
					["version"] = 1,
					["w"] = 36,
					["alpha"] = 1,
				}, -- [1]
				{
					["selfcast"] = 1,
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["size"] = 10,
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["ca"] = 1,
						["cg"] = 0.3882352941176471,
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["cb"] = 1,
						["flags"] = "THICKOUTLINE",
						["cr"] = 0.2980392156862745,
					},
					["feature"] = "actionbar",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["usebs"] = true,
					["anyup"] = 1,
					["owner"] = "decor",
					["fontkey"] = {
						["cr"] = 1,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["title"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["headerstateType"] = "None",
					["headerstateCustom"] = "",
					["abid"] = 25,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "DOWN",
					["size"] = 36,
					["fontmacro"] = {
						["size"] = 8,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["cb"] = 0.8901960784313725,
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["sy"] = 0,
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["cr"] = 1,
					},
					["hidebs"] = 1,
				}, -- [2]
			},
		},
		["Rogue_Combo"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Rogue_Combo_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["infoComment"] = "",
		["Player_SecureDebuff_Icon_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 55,
					["version"] = 1,
					["w"] = 400,
					["alpha"] = 1,
				}, -- [1]
				{
					["separateown"] = "NONE",
					["point"] = "TOPRIGHT",
					["wrapafter"] = 10,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 8,
					},
					["feature"] = "sec_aura_icons",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
							["ca"] = 1,
							["cg"] = 0.807843137254902,
							["justifyH"] = "CENTER",
							["cb"] = 0.02745098039215686,
							["title"] = "Default",
							["name"] = "Default",
							["flags"] = "THICKOUTLINE",
							["cr"] = 1,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -25,
						["Offsetx"] = 3,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Largest",
						["GfxReverse"] = true,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["usebs"] = true,
					["template"] = "RDXAB40x40Template",
					["auraType"] = "DEBUFFS",
					["owner"] = "Base",
					["sortmethod"] = "INDEX",
					["version"] = 1,
					["maxwraps"] = 2,
					["orientation"] = "LEFT",
					["xoffset"] = 0,
					["name"] = "sai1",
					["yoffset"] = 0,
				}, -- [2]
			},
		},
		["Range_70plus_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["n"] = 4,
							["class"] = "frs",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Player_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["switchvehicle"] = 1,
					["version"] = 1,
					["clickable"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [4]
			},
		},
		["Shaman_Totems8"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems8_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Shaman_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"classes", -- [1]
					[5] = true,
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["Shaman_Totems7"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Shaman_Totems7_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "earth",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Earth_mb",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "fire",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Fire_mb",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "water",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Water_mb",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "air",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Air_mb",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "remove",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Shaman_Totem_Remove_mb",
				}, -- [8]
			},
		},
		["Overheal_Done_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_tablemeter",
					["tablemeter"] = "WoWRDX:Overheal_Done_tm",
					["name"] = "combatmeter1",
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.6274509803921569,
						["g"] = 1,
						["b"] = 0.3647058823529412,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 13,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 140,
				}, -- [3]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "pdt",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 1,
				}, -- [4]
				{
					["frac"] = "fcombatmeter1",
					["owner"] = "pdt",
					["w"] = "140",
					["colorVar"] = "green",
					["feature"] = "statusbar_horiz",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "statusBar",
					["interpolate"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Ruben",
					},
				}, -- [5]
				{
					["owner"] = "pdt",
					["w"] = "100",
					["feature"] = "txt_np",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["classColor"] = 1,
					["h"] = "12",
				}, -- [6]
				{
					["txt"] = "combatmeter1_text",
					["owner"] = "pdt",
					["w"] = "138",
					["feature"] = "txt_dyn",
					["font"] = {
						["cr"] = 1,
						["sr"] = 0,
						["sb"] = 0,
						["ca"] = 1,
						["cb"] = 1,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["cg"] = 1,
						["name"] = "Default",
						["sx"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["size"] = 10,
					},
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_pdt",
					},
					["h"] = "12",
					["version"] = 1,
				}, -- [7]
			},
		},
		["Druid_Buff_Wild_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79061,
				},
			},
		},
		["Range_40plus_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["name"] = "Away",
				["val"] = {
					["qty"] = "ssz",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Range_40plus_fset",
					},
				},
				["max"] = {
					["qty"] = "ssz",
					["set"] = {
						["class"] = "group",
					},
				},
				["sv"] = 3,
				["color"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["texture"] = "",
			},
		},
		["Pet_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Player_Main_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["unitWatch"] = 1,
					["version"] = 1,
					["switchvehicle"] = 1,
					["clickable"] = 1,
					["unit"] = "pet",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [4]
			},
		},
		["ActionBarStance_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 36,
					["version"] = 1,
					["w"] = 360,
					["alpha"] = 1,
				}, -- [1]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["feature"] = "stancebar",
					["iconspx"] = 0,
					["cd"] = {
						["Font"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["fontkey"] = {
						["size"] = 10,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sy"] = 0,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["flags"] = "THICKOUTLINE",
						["cr"] = 1,
					},
					["iconspy"] = 0,
					["size"] = 36,
					["showkey"] = 1,
					["owner"] = "decor",
					["version"] = 1,
					["nIcons"] = 8,
					["orientation"] = "RIGHT",
					["name"] = "stancebar",
					["externalButtonSkin"] = "bs_simplesquare",
					["usebs"] = true,
				}, -- [2]
			},
		},
		["ChatFrame1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 100,
					["version"] = 1,
					["w"] = 400,
					["alpha"] = 1,
				}, -- [1]
				{
					["number"] = "1",
					["ts"] = "HH:MM:SS STR",
					["color"] = {
						["a"] = 1,
						["r"] = 0.5137254901960784,
						["g"] = 0.4705882352941176,
						["b"] = 1,
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "chatframe",
					["h"] = "BaseHeight",
					["version"] = 1,
					["channel"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "cf1",
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "LEFT",
						["size"] = 12,
					},
				}, -- [2]
			},
		},
		["Dps_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"role", -- [1]
					[3] = true,
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		},
		["infoVersion"] = "1.0.0",
		["Status_Power"] = {
			["ty"] = "StatusWindow",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Class Mana Status",
					["bkdColor"] = {
						["a"] = 0.5,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Raid Status DataSource",
				}, -- [2]
				{
					["feature"] = "Stat Frames: Bar",
					["h"] = "14",
					["fsz"] = 8,
					["tdx"] = 60,
					["w"] = "120",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Priest_Power_stc",
				}, -- [5]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Druid_Power_stc",
				}, -- [6]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Shaman_Power_stc",
				}, -- [7]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Paladin_Power_stc",
				}, -- [8]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Mage_Power_stc",
				}, -- [9]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Warlock_Power_stc",
				}, -- [10]
				{
					["feature"] = "Statistic",
					["stat"] = "WoWRDX:Hunter_Power_stc",
				}, -- [11]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.3,
					["slot"] = "RepaintAll",
				}, -- [12]
				{
					["feature"] = "Description",
					["description"] = "Class Power statistics",
				}, -- [13]
			},
		},
		["Raid_GroupAll_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"groups", -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
					true, -- [5]
					true, -- [6]
					true, -- [7]
					true, -- [8]
					true, -- [9]
				}, -- [2]
				{
					"classes", -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
					true, -- [5]
					true, -- [6]
					true, -- [7]
					true, -- [8]
					true, -- [9]
					true, -- [10]
					true, -- [11]
					true, -- [12]
				}, -- [3]
			},
		},
		["Priest_Buff_Fortitude_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Status Flags (dead, ld, feigned)",
				}, -- [1]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "unitInRange30",
					["set"] = {
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
						["class"] = "file",
					},
				}, -- [2]
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "aurai",
					["cd"] = 79105,
					["auraType"] = "BUFFS",
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["ph"] = 1,
					["alpha"] = 1,
					["w"] = 80,
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["h"] = "13",
					["name"] = "statusBar",
					["feature"] = "statusbar_horiz",
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [6]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "VFL.Hundredths",
					["statusBar"] = "statusBar",
					["text"] = "",
					["texIcon"] = "",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "aurai_aura",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [7]
				{
					["feature"] = "commentline",
				}, -- [8]
				{
					["feature"] = "Subframe",
					["h"] = "BaseHeight",
					["name"] = "high",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["flOffset"] = 2,
				}, -- [9]
				{
					["owner"] = "high",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["name"] = "text_group",
					["h"] = "14",
					["ty"] = "gn",
				}, -- [10]
				{
					["owner"] = "high",
					["w"] = "BaseWidth",
					["classColor"] = 1,
					["h"] = "BaseHeight",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
					},
					["feature"] = "txt_np",
					["version"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "high",
					["w"] = "80",
					["feature"] = "texture",
					["h"] = "13",
					["name"] = "tex_range",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [13]
				{
					["color"] = {
						["a"] = 0.7430000007152557,
						["r"] = 0.8313725490196078,
						["g"] = 0.01568627450980392,
						["b"] = 0,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [14]
				{
					["color"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "range",
					["colorVar1"] = "red",
					["colorVar2"] = "alpha",
					["condVar"] = "unitInRange30_flag",
				}, -- [16]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "true",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [17]
			},
		},
		["Target_Hot"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Description",
					["description"] = "High Order Target Window",
				}, -- [1]
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Multi Targets",
					["bkdColor"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [2]
				{
					["feature"] = "Assist Frames",
					["design"] = "WoWRDX:Target_Hot_ds",
				}, -- [3]
				{
					["feature"] = "Data Source: Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Target_Hot_fset",
					},
				}, -- [4]
				{
					["feature"] = "Grid Layout",
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [5]
				{
					["interval"] = 0.10000000149012,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [6]
			},
		},
		["Deathknight_Runes8"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: None",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Deathknight_Runes8_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Raid_Pet"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Pets",
					["bkdColor"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Raid_Pet_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAIDPET",
				}, -- [3]
				{
					["feature"] = "Header Grid",
					["dxn"] = 1,
					["cols"] = 40,
					["bkt"] = 1,
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "status",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_status",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_decurse",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "action",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_action",
				}, -- [7]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [8]
				{
					["feature"] = "FilterSet Editor",
				}, -- [9]
			},
		},
		["Shaman_Totems1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 80,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 200,
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.7882352941176469,
						["g"] = 0.776470588235294,
						["b"] = 0,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6196078431372554,
						["r"] = 0,
					},
					["name"] = "blue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [3]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.05490196078431373,
						["b"] = 0,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [4]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.1333333333333333,
						["g"] = 0.4862745098039216,
						["r"] = 0,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [5]
				{
					["feature"] = "Variables: Totem Info",
				}, -- [6]
				{
					["feature"] = "commentline",
				}, -- [7]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "earth_s",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [8]
				{
					["feature"] = "backdrop",
					["owner"] = "earth_s",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.1839999556541443,
						["kg"] = 1,
						["_backdrop"] = "solid",
						["kb"] = 0.01568627450980392,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "none",
						["kr"] = 0,
					},
				}, -- [9]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "green",
					["name"] = "TotemEarthBar",
					["h"] = 20,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [10]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemEarthIcon",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [11]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["name"] = "EarthTimer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["title"] = "Default",
						["size"] = 9,
					},
				}, -- [12]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemEarthBar",
					["text"] = "EarthTimer",
					["texIcon"] = "TotemEarthIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["TEIExpireState"] = "Hide",
				}, -- [13]
				{
					["txt"] = "totemearth_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["h"] = 14,
					["name"] = "status_text_earth",
				}, -- [14]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "earth",
					["flo"] = 3,
					["h"] = 20,
				}, -- [15]
				{
					["feature"] = "commentline",
				}, -- [16]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "fire_s",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [17]
				{
					["feature"] = "backdrop",
					["owner"] = "fire_s",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.1759999394416809,
						["kg"] = 0.06666666666666665,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 1,
					},
				}, -- [18]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["name"] = "TotemFireBar",
					["h"] = 20,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [19]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemFireIcon",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [20]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemFireBar",
					},
					["h"] = 14,
					["name"] = "FireTimer",
				}, -- [21]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemFireBar",
					["text"] = "FireTimer",
					["texIcon"] = "TotemFireIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["TEIExpireState"] = "Hide",
				}, -- [22]
				{
					["txt"] = "totemfire_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemFireBar",
					},
					["h"] = 14,
					["name"] = "status_text_firea",
				}, -- [23]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["h"] = 20,
					["name"] = "fire",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "water_s",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [26]
				{
					["feature"] = "backdrop",
					["owner"] = "water_s",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.1839999556541443,
						["kg"] = 0.7176470588235295,
						["_backdrop"] = "solid",
						["kb"] = 1,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [27]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "blue",
					["name"] = "TotemWaterBar",
					["h"] = 20,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [28]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemWaterIcon",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [29]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemWaterBar",
					},
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["name"] = "WaterTimer",
				}, -- [30]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemWaterBar",
					["text"] = "WaterTimer",
					["texIcon"] = "TotemWaterIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemwater_icon",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["TEIExpireState"] = "Hide",
				}, -- [31]
				{
					["txt"] = "totemwater_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemWaterBar",
					},
					["name"] = "status_text_water",
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
				}, -- [32]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["h"] = 20,
					["name"] = "water",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [33]
				{
					["feature"] = "commentline",
				}, -- [34]
				{
					["feature"] = "Subframe",
					["h"] = 20,
					["name"] = "air_s",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 180,
					["flOffset"] = 1,
				}, -- [35]
				{
					["feature"] = "backdrop",
					["owner"] = "air_s",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.1839999556541443,
						["kg"] = 0.8274509803921566,
						["_backdrop"] = "solid",
						["kb"] = 0,
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 1,
					},
				}, -- [36]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "yellow",
					["name"] = "TotemAirBar",
					["h"] = 20,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Striped",
					},
				}, -- [37]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 19,
					["sublevel"] = 1,
					["h"] = 19,
					["version"] = 1,
					["feature"] = "texture",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "TotemAirIcon",
					["drawLayer"] = "OVERLAY",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [38]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "RIGHT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemAirBar",
					},
					["h"] = 14,
					["name"] = "AirTimer",
				}, -- [39]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "MinSec",
					["statusBar"] = "TotemAirBar",
					["text"] = "AirTimer",
					["texIcon"] = "TotemAirIcon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "false",
					["tex"] = "totemair_icon",
					["txt"] = "",
					["timerVar"] = "totemair",
					["TEIExpireState"] = "Hide",
				}, -- [40]
				{
					["txt"] = "totemair_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["h"] = 14,
					["name"] = "status_text_air",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemAirBar",
					},
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["version"] = 1,
				}, -- [41]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["h"] = 20,
					["name"] = "air",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["flo"] = 3,
					["secure"] = 1,
				}, -- [42]
				{
					["feature"] = "commentline",
				}, -- [43]
				{
					["w"] = 20,
					["feature"] = "hotspot",
					["h"] = 80,
					["name"] = "remove",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["flo"] = 3,
					["secure"] = 1,
				}, -- [44]
				{
					["feature"] = "Subframe",
					["h"] = 80,
					["name"] = "remove_s",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = 20,
					["flOffset"] = 1,
				}, -- [45]
			},
		},
	},
-- End Export Data for win_DispelGrid
-- End RDX Data Export
        };
});
