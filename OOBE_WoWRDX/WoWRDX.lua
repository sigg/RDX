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
					["version"] = 1,
					["clickable"] = 1,
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
						["class"] = "rez",
						["n"] = 1,
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["class"] = "rez",
						["n"] = 2,
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
					["h"] = "height",
					["name"] = "otxt1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["ty"] = "AUI",
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["h"] = "height",
					["name"] = "otxt2",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt1",
					},
					["version"] = 1,
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["name"] = "Default",
						["title"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["ty"] = "AUIState",
				}, -- [4]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["h"] = "height",
					["name"] = "otxt3",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt2",
					},
					["version"] = 1,
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["ty"] = "Usage",
				}, -- [5]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["h"] = "height",
					["name"] = "otxt4",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt3",
					},
					["version"] = 1,
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["ty"] = "Memory Debit",
				}, -- [6]
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
						["_border"] = "straight",
						["edgeSize"] = 8,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["_backdrop"] = "solid",
						["ba"] = 1,
						["bb"] = 0,
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
					["h"] = "21",
					["owner"] = "sf_plife",
					["w"] = "200",
					["drawLayer"] = "ARTWORK",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "green",
					["name"] = "sb_plife",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
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
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["b"] = 0.79,
						["g"] = 0.51,
						["r"] = 0.58,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyDruidColor"] = {
						["a"] = 1,
						["b"] = 0.04,
						["g"] = 0.49,
						["r"] = 1,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["b"] = 0.23,
						["g"] = 0.12,
						["r"] = 0.77,
					},
					["friendlyMageColor"] = {
						["a"] = 1,
						["b"] = 0.94,
						["g"] = 0.8,
						["r"] = 0.41,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
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
					["interpolate"] = 1,
					["colorVar"] = "hostilityclassColor",
					["feature"] = "statusbar_horiz",
					["owner"] = "sf_life",
					["w"] = "200",
					["name"] = "sb_life",
					["sublevel"] = 2,
					["h"] = "21",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["drawLayer"] = "ARTWORK",
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
					["name"] = "text_pheal",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["version"] = 1,
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
					["name"] = "text_vie",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
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
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["ty"] = "fdld",
					["version"] = 1,
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
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["ty"] = "mobtype",
					["version"] = 1,
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
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["ba"] = 1,
						["bb"] = 0,
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
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.2,
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
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
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
					["name"] = "text_mana",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["ty"] = "mptxt",
					["h"] = "14",
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
						["br"] = 1,
						["bb"] = 1,
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
					["colorVar2"] = "nocolor",
					["feature"] = "ColorVariable: Conditional Color",
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
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
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
						["size"] = 15,
					},
					["ty"] = "level",
					["version"] = 1,
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["h"] = "30",
					["version"] = 1,
					["font"] = {
						["size"] = 15,
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
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["name"] = "np",
					["feature"] = "txt_np",
				}, -- [36]
				{
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_icons",
					["iconspx"] = 2,
					["cd"] = {
						["Offsety"] = 0,
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
						["offsety"] = "0",
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
					["usebs"] = true,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["ButtonSkinOffset"] = 0,
					["name"] = "debuff",
					["nIcons"] = 10,
					["orientation"] = "RIGHT",
					["version"] = 1,
					["size"] = 12,
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
					["flo"] = 3,
					["h"] = 76,
					["name"] = "",
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
							["size"] = 10,
							["ca"] = 1,
							["cg"] = 0.04313725490196078,
							["justifyH"] = "CENTER",
							["cb"] = 0,
							["title"] = "Default",
							["name"] = "Default",
							["flags"] = "OUTLINE",
							["cr"] = 1,
						},
						["Offsety"] = -20,
						["TimerType"] = "TEXT",
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
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
					["size"] = 30,
					["version"] = 1,
					["name"] = "ai1",
					["externalButtonSkin"] = "bs_simplesquare",
					["orientation"] = "RIGHT",
					["usebkd"] = 1,
					["bkd"] = {
						["ka"] = 1,
						["kg"] = 0.1,
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["edgeSize"] = 12,
						["_border"] = "IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["maxdurationfilter"] = "",
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0.2,
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
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["owner"] = "decor",
					["nIcons"] = 6,
					["deathColor"] = {
						["a"] = 1,
						["r"] = 0.6000000000000001,
						["g"] = 0.3,
						["b"] = 0.6000000000000001,
					},
					["name"] = "rune_bar_skin",
					["sizeh"] = 36,
					["orientation"] = "RIGHT",
					["frostColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.6000000000000001,
						["b"] = 1,
					},
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
					["version"] = 1,
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
					["title"] = "Konyagi_AUI:desk_solo",
					["offsetright"] = "0",
					["name"] = "root",
					["open"] = true,
					["strata"] = "BACKGROUND",
					["anchorx"] = 1134.3997024882,
					["anchory"] = 204.26689378525,
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
					["open"] = true,
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
					["r"] = 1356.80010743447,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1326.079997212661,
					["b"] = 199.680014288981,
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
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["r"] = 1326.079997212661,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1295.360006506218,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 78.50667113537041,
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
				}, -- [6]
				{
					["strata"] = "MEDIUM",
					["r"] = 805.54665535993,
					["scale"] = 1,
					["t"] = 139.9466674876765,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["open"] = true,
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
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = -10,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Player_Debuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 884.0533713135628,
					["r"] = 1225.386747459484,
					["b"] = 716.7999823426051,
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
					["dgp"] = true,
					["feature"] = "desktop_window",
					["open"] = true,
					["name"] = "WoWRDX:Player_Main",
					["b"] = 355.1065659816338,
					["anchor"] = "TOPLEFT",
					["l"] = 313.9066313560981,
					["r"] = 489.6932979609048,
					["alpha"] = 1,
				}, -- [11]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:Cooldowns_Used",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 255.1466923945194,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 594.7734189894393,
					["b"] = 232.9600092007674,
					["r"] = 770.560085594246,
				}, -- [12]
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
					["t"] = 346.5732584689431,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 313.9066313560981,
					["b"] = 281.7199181963717,
					["r"] = 489.6932979609048,
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 636.5866467168124,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMapButtons",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1227.093426889327,
					["r"] = 1363.62658612311,
					["b"] = 609.2800148700559,
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
					["dgp"] = true,
					["feature"] = "desktop_window",
					["open"] = true,
					["name"] = "WoWRDX:Target_Main",
					["b"] = 359.6131617751177,
					["anchor"] = "TOPLEFT",
					["l"] = 836.7606030750241,
					["r"] = 1012.547209922148,
					["alpha"] = 1,
				}, -- [15]
				{
					["strata"] = "MEDIUM",
					["r"] = 1196.86727367617,
					["scale"] = 1,
					["t"] = 424.4664721688475,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1021.080607071363,
					["b"] = 359.6131617751177,
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 716.7999823426051,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Debuff_Icon",
					["b"] = 678.3999939595518,
					["anchor"] = "TOPLEFT",
					["l"] = 969.3866854712014,
					["open"] = true,
					["r"] = 1225.386747459484,
				}, -- [17]
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
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1015.466611773182,
					["b"] = 17.06666731335399,
					["r"] = 1348.266710285255,
				}, -- [18]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "WoWRDX:ChatEditBox1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 109.3463863599395,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["dgp"] = true,
					["name"] = "WoWRDX:ChatFrame1",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 18.65334397835861,
					["b"] = 24.01304792574194,
					["r"] = 359.9866771734452,
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 134.9463835951153,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 18.65333837607582,
					["b"] = 109.3463863599395,
					["r"] = 359.9866771734452,
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
					["open"] = true,
					["b"] = 202.2398392212755,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMap",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1233.920025093333,
					["b"] = 636.5866467168124,
					["r"] = 1356.80010743447,
				}, -- [22]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 232.9600092007674,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Cooldowns_Used",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 554.6666914188597,
					["b"] = 207.3599970261709,
					["r"] = 810.6667534071423,
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
					["b"] = 231.2531803767166,
					["open"] = true,
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
						["n"] = 2,
						["class"] = "frs",
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
							["class"] = "file",
							["file"] = "WoWRDX:Debuff_Primary_fset",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "file",
							["file"] = "WoWRDX:Debuff_Secondary_fset",
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
						["GfxReverse"] = true,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["cr"] = 1,
							["flags"] = "THICKOUTLINE",
							["cg"] = 0.807843137254902,
							["title"] = "Default",
							["cb"] = 0.02745098039215686,
							["ca"] = 1,
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -25,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 3,
						["TextType"] = "Largest",
						["HideText"] = 0,
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
					["set"] = {
						["file"] = "default:set_raid_group7",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
					["name"] = "texcd_earth",
					["gt"] = "",
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
					["externalButtonSkin"] = "bs_kitty",
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
					["ButtonSkinOffset"] = 7,
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
					["w"] = "36",
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
					["secure"] = 1,
					["h"] = "36",
				}, -- [5]
				{
					["name"] = "texcd_Fire",
					["gt"] = "",
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
					["externalButtonSkin"] = "bs_kitty",
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
					["ButtonSkinOffset"] = 7,
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
					["w"] = "36",
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "fire",
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
					["h"] = "36",
					["flo"] = 3,
					["version"] = 1,
				}, -- [7]
				{
					["name"] = "texcd_water",
					["gt"] = "",
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
					["externalButtonSkin"] = "bs_kitty",
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
					["ButtonSkinOffset"] = 7,
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
					["flo"] = 3,
					["secure"] = 1,
				}, -- [9]
				{
					["name"] = "texcd_air",
					["gt"] = "",
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
					["externalButtonSkin"] = "bs_kitty",
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
					["ButtonSkinOffset"] = 7,
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
					["h"] = 36,
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
					["flo"] = 3,
					["secure"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = 144,
					["feature"] = "hotspot",
					["h"] = 14,
					["name"] = "remove",
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
					["version"] = 1,
				}, -- [13]
			},
		},
		["Arena_desk"] = {
			["ty"] = "Desktop",
			["version"] = 2,
			["data"] = {
				{
					["strata"] = "LOW",
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
					["offsetleft"] = "0",
					["offsetright"] = "0",
					["name"] = "root",
					["anchorx"] = 1182.1866833495,
					["alpha"] = 1,
					["title"] = "Konyagi_AUI:desk_solo",
					["anchory"] = 112.64005532254,
					["ap"] = "TOPLEFT",
				}, -- [1]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "TOPLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 380.8263325531983,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 425.5732143390299,
					["b"] = 315.972992280627,
					["r"] = 601.359851064995,
				}, -- [2]
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 725.3333197341373,
					["r"] = 1365.333385068319,
				}, -- [3]
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 0,
					["b"] = 721.0666211595296,
					["r"] = 341.3333462670797,
				}, -- [4]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 30.72000191100822,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 0,
					["r"] = 866.9866965304984,
				}, -- [5]
				{
					["strata"] = "MEDIUM",
					["r"] = 1334.613394361876,
					["scale"] = 1,
					["t"] = 568.320007342238,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["dock"] = {
						["RIGHT"] = {
							["id"] = "WoWRDX:ActionBar4",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 1303.893284140067,
					["alpha"] = 1,
					["b"] = 199.680014288981,
				}, -- [6]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 568.320007342238,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1334.613394361876,
					["b"] = 199.680014288981,
					["r"] = 1365.333385068319,
				}, -- [7]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 61.44000382201643,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 314.0266845414816,
					["b"] = 30.72000191100822,
					["r"] = 682.6666925341594,
				}, -- [8]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar5",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 61.44000382201643,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 682.6666925341594,
					["b"] = 30.72000191100822,
					["r"] = 1051.306640769154,
				}, -- [9]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 92.16000199816945,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 344.7467051267659,
					["b"] = 61.44000382201643,
					["r"] = 651.9467018277169,
				}, -- [10]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 92.16000199816945,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 651.9467018277169,
					["b"] = 61.44000382201643,
					["r"] = 959.1466686498262,
				}, -- [11]
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
					["t"] = 92.16000199816945,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 959.1466686498262,
					["b"] = 61.44000382201643,
					["r"] = 1051.306640769154,
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
					["open"] = true,
					["b"] = 551.1680583453646,
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["CENTER"] = {
							["id"] = "WoWRDX:ChatFrame1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 159.5733464760847,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 3.413354191117129,
					["b"] = 133.9733343014881,
					["r"] = 344.7467051267659,
				}, -- [14]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 146.7733403887864,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 3.413354191117129,
					["b"] = 61.44000382201643,
					["r"] = 344.7467051267659,
				}, -- [15]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Focus_Main",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
						["TOP"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = -8.000024619406203,
							["point"] = "BOTTOM",
							["y"] = -47.000122755095,
						},
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 348.3996624169126,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMap",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 601.359851064995,
					["b"] = 225.5196547728798,
					["r"] = 724.2398736484487,
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:ActionBar1",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 29.01333555315834,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:MiniMapButtons",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 866.9866965304984,
					["b"] = 1.706668341991702,
					["r"] = 1003.519975279647,
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
					["open"] = true,
					["b"] = 126.2932171095112,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["open"] = true,
					["name"] = "WoWRDX:Party",
					["b"] = 475.3066955079885,
					["anchor"] = "TOPLEFT",
					["l"] = 92.07456345073184,
					["r"] = 267.9465789664515,
					["dgp"] = true,
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["r"] = 443.7331858135751,
					["scale"] = 1,
					["t"] = 540.2027027663061,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Partytarget",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 267.9465789664515,
					["b"] = 475.3493624937347,
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["open"] = true,
					["name"] = "WoWRDX:Target_Main",
					["b"] = 290.3729801060304,
					["anchor"] = "TOPLEFT",
					["l"] = 724.2397541330824,
					["r"] = 900.0265402532555,
					["dgp"] = true,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "BOTTOMLEFT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 290.3729801060304,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 425.5732143390299,
					["b"] = 225.5196547728798,
					["r"] = 601.359851064995,
				}, -- [22]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMLEFT"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Target_Main",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 290.3729801060304,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Focus_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 724.2398736484487,
					["b"] = 225.5196547728798,
					["r"] = 900.0265402532555,
				}, -- [23]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:MiniMap",
							["x"] = 8.000024619406203,
							["point"] = "TOP",
							["y"] = 47.000122755095,
						},
					},
					["scale"] = 1,
					["t"] = 410.6930731812441,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 581.7332766525323,
					["b"] = 388.5064198663337,
					["r"] = 757.5198834996559,
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
					["design"] = "WoWRDX:Dispell_Grid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Dispell_Grid_Data_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 5,
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
						["file"] = "WoWRDX:Dispell_Grid_Audio_fset",
						["class"] = "file",
					},
					["sndEmpty"] = "",
					["sndDown"] = "",
					["sndUp"] = "",
					["sndFill"] = "Interface\\AddOns\\RDX\\Skin\\moleUp.wav",
				}, -- [6]
				{
					["feature"] = "FilterSet Editor",
				}, -- [7]
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
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
				["party2"] = "WoWRDX:Party_desk",
				["soloflag2"] = 1,
				["pvpflag"] = 1,
				["solo"] = "WoWRDX:Solo_desk",
				["arena"] = "WoWRDX:Arena_desk",
				["pvpflag2"] = 1,
				["pvp"] = "WoWRDX:Battleground_desk",
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
						["ka"] = 0.3999999761581421,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kr"] = 0,
						["kb"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["_border"] = "HalStraight",
						["kg"] = 0,
						["edgeSize"] = 8,
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
					["timer1"] = "0",
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["timer2"] = "0",
					["cd"] = 48518,
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["name"] = "lunar",
				}, -- [4]
				{
					["auraType"] = "BUFFS",
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
					["timer1"] = "0",
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["timer2"] = "0",
					["cd"] = 48517,
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["name"] = "solar",
				}, -- [5]
				{
					["feature"] = "commentline",
				}, -- [6]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.5,
						["g"] = 0.5,
						["b"] = 1,
					},
					["name"] = "BlueLightColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [7]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 1,
					},
					["name"] = "BlueColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [8]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "LunarColor",
					["colorVar1"] = "BlueColor",
					["colorVar2"] = "BlueLightColor",
					["condVar"] = "lunar_possible",
				}, -- [9]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0.5,
					},
					["name"] = "YellowLightColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [10]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["name"] = "YellowColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [11]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "SolarColor",
					["colorVar1"] = "YellowColor",
					["colorVar2"] = "YellowLightColor",
					["condVar"] = "solar_possible",
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
					["interpolate"] = 1,
					["reducex"] = 1,
					["owner"] = "decor",
					["w"] = "60",
					["frac"] = "fm_i",
					["feature"] = "statusbar_horiz",
					["h"] = "12",
					["version"] = 1,
					["colorVar"] = "LunarColor",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "LunarBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalA",
					},
				}, -- [15]
				{
					["interpolate"] = 1,
					["owner"] = "decor",
					["w"] = "60",
					["h"] = "12",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "SolarColor",
					["version"] = 1,
					["frac"] = "fm",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["name"] = "solarBar",
					["orientation"] = "HORIZONTAL",
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
						["r"] = 0.9254901960784314,
						["g"] = 1,
						["b"] = 0.2549019607843137,
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
						["_border"] = "none",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
					},
				}, -- [5]
				{
					["owner"] = "subframe",
					["w"] = "100",
					["classColor"] = 1,
					["h"] = "14",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["version"] = 1,
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
						["size"] = 10,
					},
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
					["orientation"] = "HORIZONTAL",
					["name"] = "statusBar",
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
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "subframe",
					},
					["h"] = "14",
					["name"] = "customText",
				}, -- [9]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "14",
					["feature"] = "txt_custom",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["ca"] = 1,
						["cg"] = 0.01176470588235294,
						["justifyH"] = "CENTER",
						["cb"] = 0,
						["sr"] = 0,
						["size"] = 10,
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["title"] = "Default",
						["sb"] = 0,
						["flags"] = "OUTLINE",
						["cr"] = 1,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["name"] = "stackText",
					["h"] = "14",
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
					["txt"] = "auraia_aura_stack",
					["text"] = "customText",
					["TL"] = 0,
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["countTypeFlag"] = "false",
					["version"] = 1,
					["tex"] = "auraia_icon",
					["blendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0.007843137254901961,
					},
					["timerVar"] = "auraia_aura",
					["texIcon"] = "tex1",
				}, -- [11]
				{
					["feature"] = "shader_showhide",
					["owner"] = "subframe",
					["version"] = 1,
					["flag"] = "auraia_possible",
				}, -- [12]
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
						["r"] = 1,
						["g"] = 0.3098039215686275,
						["b"] = 0.2862745098039216,
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
					["interpolate"] = 1,
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["colorVar"] = "red",
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
					["frac"] = "fthreat",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Ruben",
					},
				}, -- [5]
				{
					["owner"] = "pdt",
					["w"] = "60",
					["classColor"] = 1,
					["h"] = "12",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["feature"] = "txt_np",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["sb"] = 0,
						["sr"] = 0,
					},
				}, -- [6]
				{
					["txt"] = "threat_info",
					["owner"] = "pdt",
					["w"] = "40",
					["feature"] = "txt_dyn",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "RIGHT",
						["af"] = "Text_np",
					},
					["h"] = "14",
					["name"] = "infothreat",
				}, -- [7]
				{
					["txt"] = "threat_value",
					["owner"] = "pdt",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["justifyH"] = "RIGHT",
						["sy"] = -1,
						["title"] = "Default",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "RIGHT",
						["af"] = "Text_infothreat",
					},
					["h"] = "12",
					["name"] = "infoText",
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
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
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
						["n"] = 1,
						["class"] = "rez",
					},
				}, -- [6]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "rezdone",
					["set"] = {
						["n"] = 2,
						["class"] = "rez",
					},
				}, -- [7]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "nonmort",
					["set"] = {
						["file"] = "WoWRDX:Not_Dead_fset",
						["class"] = "file",
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
						["g"] = 0.2078431372549019,
						["r"] = 0.2235294117647059,
					},
				}, -- [11]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "vierouge",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
				}, -- [12]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "vievert",
					["color"] = {
						["a"] = 1,
						["r"] = 0.611764705882353,
						["g"] = 0.8784313725490196,
						["b"] = 0.2784313725490196,
					},
				}, -- [13]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "vert2",
					["color"] = {
						["a"] = 1,
						["r"] = 0.2078431372549019,
						["g"] = 0.6431372549019607,
						["b"] = 0,
					},
				}, -- [14]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "colorrezincom",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.8240000009536743,
						["b"] = 0.3449999988079071,
					},
				}, -- [15]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "blanc",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [16]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "colorrezdone",
					["color"] = {
						["a"] = 1,
						["r"] = 0.7450980392156863,
						["g"] = 0.4745098039215687,
						["b"] = 1,
					},
				}, -- [17]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "gris2",
					["color"] = {
						["a"] = 1,
						["r"] = 0.5019607843137255,
						["g"] = 0.5019607843137255,
						["b"] = 0.5019607843137255,
					},
				}, -- [18]
				{
					["feature"] = "ColorVariable: Unit Class Color",
				}, -- [19]
				{
					["condVar"] = "aggro_flag",
					["name"] = "vie",
					["colorVar1"] = "vierouge",
					["colorVar2"] = "vert2",
					["feature"] = "ColorVariable: Conditional Color",
				}, -- [20]
				{
					["condVar"] = "range_flag",
					["name"] = "couleurporte",
					["colorVar1"] = "vie",
					["colorVar2"] = "gris2",
					["feature"] = "ColorVariable: Conditional Color",
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
						["ka"] = 0.2445517182350159,
						["edgeSize"] = 8,
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0.4470588235294117,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["bb"] = 0.3803921568627451,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_border"] = "straight",
						["kg"] = 0,
						["bg"] = 0.3843137254901961,
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
						["file"] = "WoWRDX:Debuff_Poison_fset",
						["class"] = "file",
					},
					["texture1"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					},
					["set1"] = {
						["file"] = "WoWRDX:Debuff_Magic_fset",
						["class"] = "file",
					},
					["texture2"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_NullifyPoison_02",
					},
					["raColor5"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["set4"] = {
						["file"] = "WoWRDX:Debuff_Curse_fset",
						["class"] = "file",
					},
					["set3"] = {
						["file"] = "WoWRDX:Debuff_Disease_fset",
						["class"] = "file",
					},
					["texture4"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_RemoveCurse",
					},
					["raColor2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.5,
						["r"] = 0,
					},
					["feature"] = "Variables decurse",
					["texture3"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_RemoveDisease",
					},
					["raColor1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0,
					},
					["raColor3"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["raColor4"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.9,
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
						["bg"] = 0.3843137254901961,
						["_backdrop"] = "none",
						["br"] = 0.4470588235294117,
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
					["drawLayer"] = "ARTWORK",
					["name"] = "TextureDecurse",
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
					["feature"] = "shader_applytex",
					["owner"] = "TextureDecurse",
					["version"] = 1,
					["var"] = "decurseIcon",
				}, -- [32]
				{
					["w"] = "20",
					["feature"] = "hotspot",
					["h"] = "20",
					["name"] = "decurse",
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
					["flo"] = 4,
					["secure"] = 1,
					["version"] = 1,
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
						["br"] = 0.4470588235294117,
						["bb"] = 0.3803921568627451,
						["bg"] = 0.3843137254901961,
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
					["orientation"] = "VERTICAL",
					["name"] = "manaBar",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\vbar_halfoutline",
					},
				}, -- [37]
				{
					["w"] = "20",
					["feature"] = "hotspot",
					["h"] = "20",
					["name"] = "status",
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
					["flo"] = 4,
					["secure"] = 1,
					["version"] = 1,
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
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high1",
					},
					["name"] = "previeBar",
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
					["h"] = "18",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "couleurporte",
					["name"] = "viebar",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high2",
					},
					["interpolate"] = 1,
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
					["h"] = "20",
					["name"] = "action",
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
					["flo"] = 4,
					["secure"] = 1,
					["version"] = 1,
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
					["drawLayer"] = "ARTWORK",
					["name"] = "texparlera",
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
					["drawLayer"] = "ARTWORK",
					["name"] = "texparlerb",
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
					["drawLayer"] = "ARTWORK",
					["name"] = "texrez",
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
					["h"] = "19",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 1,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_high3",
					},
					["name"] = "np",
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
				}, -- [56]
				{
					["txt"] = "pheal",
					["owner"] = "high3",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["h"] = "19",
					["name"] = "txt_pheal",
					["anchor"] = {
						["dx"] = -3,
						["dy"] = 1,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_high3",
					},
					["font"] = {
						["size"] = 8,
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
				}, -- [57]
				{
					["owner"] = "high3",
					["w"] = "30",
					["feature"] = "txt_status",
					["ty"] = "fdld",
					["name"] = "txt_state",
					["anchor"] = {
						["dx"] = -25,
						["dy"] = 1,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_high3",
					},
					["h"] = "14",
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
						["size"] = 8,
					},
					["version"] = 1,
				}, -- [58]
				{
					["externalNameFilter"] = "WoWRDX:Buff_af",
					["rows"] = 1,
					["filterNameList"] = {
					},
					["feature"] = "aura_icons",
					["iconspx"] = 1,
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
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["filterName"] = 1,
					["version"] = 1,
					["maxdurationfilter"] = "",
					["orientation"] = "LEFT",
					["name"] = "regen",
					["size"] = 12,
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
					["rows"] = 1,
					["usebs"] = true,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "boss",
					["orientation"] = "LEFT",
					["bkd"] = {
					},
					["size"] = 18,
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
						["b"] = 1,
						["g"] = 0.4705882352941176,
						["r"] = 0.5137254901960784,
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["size"] = 10,
					},
					["name"] = "cf1",
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
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["feature"] = "base_default",
					["w"] = 90,
					["alpha"] = 1,
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
					["h"] = "14",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["feature"] = "txt_np",
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
				}, -- [6]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["font"] = {
						["size"] = 8,
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
					["ty"] = "hpm",
					["name"] = "text_hp_missing",
				}, -- [7]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["font"] = {
						["size"] = 8,
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
					["ty"] = "fdld",
					["name"] = "status_text",
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
					["owner"] = "decor",
					["w"] = "145",
					["flOffset"] = 1,
				}, -- [7]
				{
					["feature"] = "backdrop",
					["owner"] = "main",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "HalStraight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["kg"] = 0,
						["ka"] = 0.2749999761581421,
						["edgeSize"] = 8,
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main",
					},
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
					["owner"] = "decor",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main1",
					},
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
					["owner"] = "decor",
					["w"] = "144",
					["flOffset"] = 2,
				}, -- [14]
				{
					["feature"] = "txt_np",
					["h"] = "15",
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["size"] = 10,
					},
				}, -- [15]
				{
					["owner"] = "main2",
					["w"] = "35",
					["feature"] = "txt_status",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["size"] = 10,
					},
					["name"] = "text_hp_percent",
					["anchor"] = {
						["dx"] = -4,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_main2",
					},
					["version"] = 1,
					["ty"] = "hpp",
					["h"] = "15",
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
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["h"] = "7",
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["orientation"] = "HORIZONTAL",
					["name"] = "castBar",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -15,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_main1",
					},
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
					["h"] = "7",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -12,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_main2",
					},
					["name"] = "customText",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Bold.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "CENTER",
						["sx"] = 1,
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["size"] = 8,
					},
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
					["TL"] = 0,
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
					["texIcon"] = "",
					["tex"] = "",
					["txt"] = "spell_name_rank",
					["timerVar"] = "spell",
					["TEIExpireState"] = "Hide",
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
					["timefilter"] = 1,
					["iconspy"] = 0,
					["cdTimerType"] = "COOLDOWN",
					["cdFont"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
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
						["GfxReverse"] = true,
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
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
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
					["usebs"] = true,
					["maxdurationfilter"] = "",
					["cdTxtType"] = "MinSec",
					["filterNameList"] = {
					},
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["cdHideTxt"] = "0",
					["owner"] = "decor",
					["playerauras"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["version"] = 1,
					["cdoffx"] = 0,
					["name"] = "debuffs",
					["petauras"] = 1,
					["orientation"] = "RIGHT",
					["size"] = 10,
					["nIcons"] = 12,
					["unitfilter"] = "",
				}, -- [25]
			},
		},
		["Alive_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["name"] = "Alive",
				["val"] = {
					["qty"] = "ssz",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Alive_fset",
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
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["texture"] = "",
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
		["Debuff_Magic_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "debuff",
						["buff"] = "@magic",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "debuff",
							["buff"] = "thunderfury",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "debuff",
							["buff"] = "unstable affliction",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "debuff",
							["buff"] = "dreamless sleep",
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
					["set"] = {
						["file"] = "default:set_raid_group4",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
		["FactionBar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["colorHonored"] = {
						["a"] = 1,
						["b"] = 0.53,
						["g"] = 1,
						["r"] = 0,
					},
					["colorFriendly"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["factionID"] = 14,
					["colorUnknown"] = {
						["a"] = 1,
						["b"] = 0.5,
						["g"] = 0.5,
						["r"] = 0.5,
					},
					["colorRevered"] = {
						["a"] = 1,
						["b"] = 0.8,
						["g"] = 1,
						["r"] = 0,
					},
					["feature"] = "Variables: Detailed Faction Info",
					["colorHostile"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["name"] = "faction1",
					["colorUnfriendly"] = {
						["a"] = 1,
						["b"] = 0.13,
						["g"] = 0.4,
						["r"] = 0.9300000000000001,
					},
					["factionName"] = "Horde",
					["colorNeutral"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["colorExalted"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 0,
					},
					["colorHated"] = {
						["a"] = 1,
						["b"] = 0.13,
						["g"] = 0.13,
						["r"] = 0.8,
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
						["_border"] = "none",
						["tile"] = false,
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
					["name"] = "statusBar",
					["orientation"] = "HORIZONTAL",
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
					["h"] = "BaseHeight",
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "CENTER",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
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
					["class"] = "file",
					["file"] = "WoWRDX:Threat_fset",
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
					["version"] = 1,
					["clickable"] = 1,
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
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["name"] = "black",
					["feature"] = "ColorVariable: Static Color",
				}, -- [12]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["name"] = "green",
					["feature"] = "ColorVariable: Static Color",
				}, -- [13]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0.07500000298023224,
						["g"] = 0.07500000298023224,
						["b"] = 0.07500000298023224,
					},
					["name"] = "grey",
					["feature"] = "ColorVariable: Static Color",
				}, -- [14]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["name"] = "red",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0.7647058823529411,
					},
					["name"] = "purple",
					["feature"] = "ColorVariable: Static Color",
				}, -- [16]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [17]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0,
					},
					["name"] = "blue",
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
					["color"] = {
						["a"] = 0.8257031291723251,
						["b"] = 0.3725490196078432,
						["g"] = 1,
						["r"] = 0.4313725490196079,
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
						["class"] = "file",
						["file"] = "WoWRDX:Alive_fset",
					},
				}, -- [25]
				{
					["interpolate"] = 1,
					["owner"] = "hpframe",
					["w"] = "28",
					["colorVar"] = "darkclass",
					["feature"] = "statusbar_horiz",
					["h"] = "28",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["orientation"] = "VERTICAL",
					["name"] = "hp",
					["frac"] = "fh",
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
					["orientation"] = "VERTICAL",
					["name"] = "php",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar_smooth",
					},
				}, -- [27]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "hpframe",
					["w"] = "28",
					["disable"] = true,
					["feature"] = "texture",
					["h"] = "28",
					["name"] = "hpmiss",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar_smooth",
					},
				}, -- [28]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "hpframe",
					["w"] = "28",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "ALPHAKEY",
					},
					["feature"] = "texture",
					["h"] = "28",
					["version"] = 1,
					["drawLayer"] = "BACKGROUND",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
					["sublevel"] = 1,
					["name"] = "phhp",
					["disable"] = true,
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
						["class"] = "file",
						["file"] = "WoWRDX:Dead_fset",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 0.6509803921568631,
							["g"] = 0.6509803921568631,
							["r"] = 0.6509803921568631,
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
					["drawLayer"] = "BACKGROUND",
					["sublevel"] = 1,
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
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Both_fset",
					},
				}, -- [43]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "cure1",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Primary_fset",
					},
				}, -- [44]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "cure2",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Secondary_fset",
					},
				}, -- [45]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "none",
					["set"] = {
						["file"] = "WoWRDX:Debuff_None_fset",
						["class"] = "file",
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
					["drawLayer"] = "BACKGROUND",
					["sublevel"] = 1,
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
						["class"] = "file",
						["file"] = "default:set_red",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 0,
							["r"] = 1,
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
						["class"] = "file",
						["file"] = "default:set_green",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 1,
							["r"] = 0,
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
						["class"] = "file",
						["file"] = "default:set_yellow",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["b"] = 0,
							["g"] = 1,
							["r"] = 1,
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
						["class"] = "file",
						["file"] = "default:set_blue",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["vertexColor"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 0,
							["r"] = 0,
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
					["h"] = "14",
					["version"] = 1,
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "hpframe",
					},
					["trunc"] = 3,
					["feature"] = "txt_np",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["justifyH"] = "CENTER",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
				}, -- [69]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["flo"] = 3,
					["name"] = "click",
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
					["secure"] = 1,
					["h"] = "36",
					["version"] = 1,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 774,
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["timer2"] = 0,
					["name"] = "aurareju",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["timer1"] = 0,
				}, -- [75]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["name"] = "rejutxt",
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
					["txt"] = "",
					["text"] = "rejutxt",
					["TL"] = 0,
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["tex"] = "",
					["blendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["timerVar"] = "aurareju_aura",
					["texIcon"] = "",
				}, -- [77]
				{
					["feature"] = "commentline",
				}, -- [78]
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 8936,
					["timer1"] = "0",
					["timer2"] = "0",
					["name"] = "auraregrowth",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [79]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Base",
					},
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["name"] = "regrotxt",
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
					["txt"] = "",
					["text"] = "regrotxt",
					["TL"] = 0,
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["tex"] = "",
					["blendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["timerVar"] = "auraregrowth_aura",
					["texIcon"] = "",
				}, -- [81]
				{
					["feature"] = "commentline",
				}, -- [82]
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = "wild growth",
					["timer1"] = "0",
					["timer2"] = "0",
					["name"] = "aurawgrowth",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [83]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["name"] = "wgrothtxt",
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
					["txt"] = "",
					["text"] = "wgrothtxt",
					["TL"] = 0,
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["tex"] = "",
					["blendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["timerVar"] = "aurawgrowth_aura",
					["texIcon"] = "",
				}, -- [85]
				{
					["feature"] = "commentline",
				}, -- [86]
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = "lifebloom",
					["timer1"] = "0",
					["timer2"] = "0",
					["name"] = "auralifebloom",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color0"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}, -- [87]
				{
					["script"] = "",
					["owner"] = "hpframe",
					["w"] = "50",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["name"] = "lbtxt",
				}, -- [88]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "Tenths",
					["statusBar"] = "",
					["stackMax"] = 3,
					["txt"] = "",
					["TEIExpireState"] = "Hide",
					["blendcolor"] = 1,
					["text"] = "lbtxt",
					["stackVar"] = "aura_lifebloom_stack",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["TL"] = 0,
					["version"] = 1,
					["countTypeFlag"] = "true",
					["tex"] = "",
					["stack"] = 1,
					["timerVar"] = "auralifebloom_aura",
					["texIcon"] = "",
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
						["r"] = 0.5,
						["g"] = 0,
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["h"] = 20,
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["r"] = 0.5,
						["g"] = 0,
						["b"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 0.5,
						["g"] = 0,
						["b"] = 1,
					},
					["version"] = 1,
					["name"] = "customicon1",
					["color3"] = {
						["a"] = 1,
						["r"] = 0.5,
						["g"] = 0,
						["b"] = 1,
					},
					["orientation"] = "RIGHT",
					["drawLayer"] = "ARTWORK",
					["color5"] = {
						["a"] = 1,
						["r"] = 0.5,
						["g"] = 0,
						["b"] = 1,
					},
					["nIcons"] = 5,
				}, -- [3]
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
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
						},
						["nametxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["h"] = 20,
						["showicon"] = true,
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
						["stacktxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
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
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "HP Status",
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
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Warlock_fset",
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
				["name"] = "Warlock",
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Warlock_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0.611764705882353,
					["g"] = 0,
					["r"] = 0.1843137254901961,
				},
				["texture"] = "",
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
							["size"] = 10,
							["ca"] = 1,
							["cg"] = 0.04313725490196078,
							["justifyH"] = "CENTER",
							["cb"] = 0,
							["title"] = "Default",
							["name"] = "Default",
							["flags"] = "OUTLINE",
							["cr"] = 1,
						},
						["Offsety"] = -20,
						["TimerType"] = "TEXT",
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
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
					["maxdurationfilter"] = "",
					["name"] = "ai1",
					["version"] = 1,
					["orientation"] = "RIGHT",
					["externalButtonSkin"] = "bs_simplesquare",
					["size"] = 30,
					["usebs"] = true,
				}, -- [2]
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
					["version"] = 1,
					["clickable"] = 1,
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
					["version"] = 1,
					["clickable"] = 1,
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
							["buff"] = 17626,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 17627,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 17628,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 17629,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28518,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [6]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28519,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [7]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28520,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [8]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28521,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [9]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28540,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [10]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 33053,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [11]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 42735,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [12]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 40567,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [13]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 40568,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [14]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 40572,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [15]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 40573,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [16]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 40575,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [17]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 40576,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [18]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 41608,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [19]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 41609,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [20]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 41610,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [21]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 41611,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [22]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 46837,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [23]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 46839,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [24]
			},
		},
		["Dps_Power_stc"] = {
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
				["name"] = "DPS",
				["sv"] = 1,
				["color"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 0.2980392156862746,
					["b"] = 0.7607843137254902,
				},
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Dps_fset",
					},
				},
				["pct"] = 1,
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Dps_fset",
					},
				},
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
						["buff"] = 79105,
						["class"] = "buff",
					}, -- [2]
				}, -- [2]
			},
		},
		["Druid_EclipseBar"] = {
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
					["switchvehicle"] = 1,
					["version"] = 1,
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
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
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
					["design"] = "WoWRDX:Priest_Buff_POM_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Set",
					["set"] = {
						["buff"] = 41635,
						["class"] = "mybuff",
					},
					["rostertype"] = "RAID&RAIDPET",
				}, -- [3]
				{
					["feature"] = "Grid Layout",
					["countTitle"] = 1,
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
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
					["name"] = "aurai",
					["cd"] = 63735,
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
						["b"] = 1,
						["g"] = 0.1529411764705883,
						["r"] = 0,
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
					["h"] = 20,
					["usebs"] = true,
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.1529411764705883,
						["r"] = 0,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.1529411764705883,
						["r"] = 0,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.1529411764705883,
						["r"] = 0,
					},
					["version"] = 1,
					["drawLayer"] = "ARTWORK",
					["orientation"] = "RIGHT",
					["name"] = "customicon1",
					["color5"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.1529411764705883,
						["r"] = 0,
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
					["name"] = "texcd_earth",
					["gt"] = "",
					["version"] = 1,
					["externalButtonSkin"] = "bs_onix",
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
					["w"] = "36",
					["feature"] = "hotspot",
					["h"] = "36",
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
				}, -- [5]
				{
					["version"] = 1,
					["gt"] = "",
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
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemfire_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["name"] = "texcd_Fire",
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_onix",
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
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["secure"] = 1,
					["name"] = "fire",
				}, -- [7]
				{
					["version"] = 1,
					["gt"] = "",
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
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemwater_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["name"] = "texcd_water",
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_onix",
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
						["dx"] = 0,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["secure"] = 1,
					["name"] = "water",
				}, -- [9]
				{
					["version"] = 1,
					["gt"] = "",
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
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemair_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["name"] = "texcd_air",
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -108,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_onix",
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
					["name"] = "air",
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
					["secure"] = 1,
					["h"] = "36",
					["version"] = 1,
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
						["dx"] = 0,
						["dy"] = -144,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["secure"] = 1,
					["name"] = "remove",
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
							["class"] = "file",
							["file"] = "WoWRDX:Range_0_15_fset",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "file",
							["file"] = "WoWRDX:Range_15_30_fset",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "file",
							["file"] = "WoWRDX:Range_30_40_fset",
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
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
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
					["name"] = "minimap1",
					["font"] = {
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Bazooka.ttf",
						["justifyV"] = "CENTER",
						["cr"] = 0.3843137254901961,
						["ca"] = 1,
						["cg"] = 0.7764705882352941,
						["title"] = "Default",
						["cb"] = 0.6901960784313725,
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 12,
					},
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "260",
					["feature"] = "txt_other",
					["ty"] = "mapzonetext",
					["name"] = "otxt1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["font"] = {
						["sr"] = 0,
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
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
						["size"] = 12,
					},
					["h"] = "14",
					["version"] = 1,
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
					["set"] = {
						["file"] = "default:set_raid_group3",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["mbFriendly"] = "default:bindings_arena",
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
					["version"] = 1,
					["clickable"] = 1,
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
					["class"] = "file",
					["file"] = "WoWRDX:Overheal_Done_fset",
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
						["buff"] = "@disease",
						["class"] = "debuff",
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
					["version"] = 1,
					["switchvehicle"] = 1,
					["unit"] = "player",
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
						["class"] = "file",
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
					},
				}, -- [2]
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 79105,
					["name"] = "aurai",
					["auraType"] = "BUFFS",
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["w"] = 80,
					["alpha"] = 1,
					["feature"] = "base_default",
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "BaseWidth",
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
					["h"] = "13",
					["name"] = "statusBar",
					["feature"] = "statusbar_horiz",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "aurai_aura",
					["texIcon"] = "",
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
					["font"] = {
						["size"] = 9,
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
					["h"] = "14",
					["version"] = 1,
				}, -- [10]
				{
					["owner"] = "high",
					["w"] = "BaseWidth",
					["classColor"] = 1,
					["font"] = {
						["size"] = 10,
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["name"] = "np",
					["feature"] = "txt_np",
					["h"] = "BaseHeight",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["condVar"] = "unitInRange30_flag",
					["name"] = "range",
					["colorVar1"] = "red",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "alpha",
				}, -- [16]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "true",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [17]
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
							["buff"] = 35272,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 43722,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 43730,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 43763,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 44106,
							["class"] = "buff",
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
						["b"] = 0.6784313725490196,
						["g"] = 0.3058823529411765,
						["r"] = 0.7803921568627451,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Druid_Buff_Wild_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "group",
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
					["mbFriendly"] = "WoWRDX:Druid_Buff_Wild_mb",
				}, -- [5]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
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
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.75,
						["r"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["b"] = 0.75,
						["g"] = 0,
						["r"] = 0,
					},
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["feature"] = "base_default",
					["alpha"] = 1,
					["w"] = 90,
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
					["name"] = "ppbar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [6]
				{
					["owner"] = "Base",
					["w"] = "50",
					["classColor"] = 1,
					["h"] = "14",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
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
					["feature"] = "txt_np",
					["version"] = 1,
				}, -- [7]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["name"] = "status_text",
					["ty"] = "fdld",
					["font"] = {
						["size"] = 8,
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
				}, -- [8]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["name"] = "text_mp_percent",
					["ty"] = "mpp",
					["font"] = {
						["size"] = 8,
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
						["ka"] = 0.7119999825954437,
						["kg"] = 0,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["edgeSize"] = 8,
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
					["colorVar"] = "green",
					["owner"] = "sf_plife",
					["w"] = "200",
					["drawLayer"] = "ARTWORK",
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
					["h"] = "21",
					["feature"] = "statusbar_horiz",
					["owner"] = "sf_life",
					["w"] = "200",
					["version"] = 1,
					["sublevel"] = 2,
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
					["drawLayer"] = "ARTWORK",
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
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["font"] = {
						["size"] = 12,
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
					["name"] = "text_pheal",
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
					["version"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["sx"] = 1,
						["sr"] = 0,
					},
					["h"] = "14",
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "fdld",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["h"] = "14",
					["name"] = "text_dead",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "mobtype",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["h"] = "14",
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
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["edgeSize"] = 8,
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
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.2,
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
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["ty"] = "mptxt",
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
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["br"] = 1,
						["bb"] = 1,
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
					["ty"] = "level",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
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
						["size"] = 15,
					},
					["h"] = "30",
					["name"] = "status_text",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["feature"] = "txt_np",
					["font"] = {
						["size"] = 15,
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
					["h"] = "30",
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
						["Offsety"] = 0,
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
						["offsety"] = "0",
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
					["usebs"] = true,
					["ButtonSkinOffset"] = 0,
					["nIcons"] = 10,
					["version"] = 1,
					["size"] = 12,
					["orientation"] = "RIGHT",
					["name"] = "debuff",
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
					["h"] = 76,
					["name"] = "",
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
					["version"] = 1,
					["switchvehicle"] = 1,
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
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0.2156862745098039,
						["g"] = 0.5333333333333333,
						["b"] = 0.7803921568627451,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_Fortitude_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Raid_fset",
						["class"] = "file",
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
					["mbFriendly"] = "WoWRDX:Priest_Buff_Fortitude_mb",
				}, -- [5]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
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
						["sr"] = 0,
						["sa"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
						["justifyV"] = "BOTTOM",
						["sb"] = 0,
						["flags"] = "THICKOUTLINE",
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["size"] = 14,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["cr"] = 1,
							["flags"] = "OUTLINE",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
							["justifyV"] = "CENTER",
							["sx"] = 0,
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["name"] = "Default",
							["cb"] = 0.1333333333333333,
							["justifyH"] = "CENTER",
							["sy"] = 0,
							["title"] = "Default",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.1,
						["TextType"] = "Largest",
						["HideText"] = 0,
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
					["version"] = 1,
					["maxdurationfilter"] = "",
					["orientation"] = "LEFT",
					["name"] = "ai1",
					["size"] = 30,
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
					["set"] = {
						["file"] = "default:set_raid_group8",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.01176470588235294,
					["g"] = 0,
					["r"] = 0.4705882352941178,
				},
				["name"] = "Raid HP",
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
						["class"] = "group",
					},
					["qty"] = "smaxhp",
				},
				["val"] = {
					["set"] = {
						["class"] = "group",
					},
					["qty"] = "shp",
				},
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
						["class"] = "file",
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
					},
				}, -- [2]
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 79107,
					["name"] = "aurai",
					["auraType"] = "BUFFS",
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["alpha"] = 1,
					["w"] = 80,
					["feature"] = "base_default",
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "13",
					["name"] = "statusBar",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "aurai_aura",
					["texIcon"] = "",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["h"] = "14",
					["font"] = {
						["size"] = 9,
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
					["name"] = "text_group",
				}, -- [10]
				{
					["owner"] = "high",
					["w"] = "BaseWidth",
					["feature"] = "txt_np",
					["h"] = "BaseHeight",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["name"] = "np",
					["classColor"] = 1,
					["font"] = {
						["size"] = 10,
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "range",
					["colorVar1"] = "red",
					["condVar"] = "unitInRange30_flag",
					["colorVar2"] = "alpha",
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
					["name"] = "auraia",
					["cd"] = 15286,
					["auraType"] = "BUFFS",
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.192156862745098,
						["r"] = 0.2156862745098039,
					},
					["name"] = "blue",
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
					["colorVar"] = "blue",
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
					["version"] = 1,
					["name"] = "tex1",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["name"] = "customText",
					["h"] = "14",
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
		["Debuff_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
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
						["_border"] = "straight",
						["kg"] = 0,
						["kb"] = 0,
						["tile"] = false,
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
				}, -- [5]
				{
					["feature"] = "var_pred_health",
				}, -- [6]
				{
					["color"] = {
						["a"] = 0.903999999165535,
						["r"] = 0.04313725490196078,
						["g"] = 1,
						["b"] = 0,
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
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_plife",
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
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_life",
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
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 12,
					},
					["name"] = "text_pheal",
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["ty"] = "hptxt2",
					["version"] = 1,
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
						["justifyH"] = "LEFT",
						["sx"] = 1,
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
					["ty"] = "fdld",
					["version"] = 1,
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
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 12,
					},
					["name"] = "text_dead",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "mobtype",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
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
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 12,
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
					["flOffset"] = 1,
				}, -- [19]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
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
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.2,
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
					["orientation"] = "HORIZONTAL",
					["name"] = "sb_power",
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
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
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
					["name"] = "text_power",
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
						["bg"] = 1,
						["_backdrop"] = "none",
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
					["colorVar2"] = "nocolor",
					["condVar"] = "aggro_flag",
				}, -- [31]
				{
					["color"] = "aggrocolour",
					["owner"] = "sf_sup",
					["feature"] = "Backdrop Border Colorizer",
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
					["ty"] = "level",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["h"] = "30",
					["font"] = {
						["size"] = 15,
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
					["name"] = "status_text",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["h"] = "30",
					["version"] = 1,
					["name"] = "np",
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["feature"] = "txt_np",
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
						["justifyH"] = "LEFT",
						["size"] = 15,
					},
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
					["h"] = "76",
					["name"] = "",
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
						["ka"] = 0.7119999825954437,
						["kg"] = 0,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["edgeSize"] = 8,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["ba"] = 1,
						["bb"] = 0,
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
					["colorVar"] = "green",
					["owner"] = "sf_plife",
					["w"] = "200",
					["drawLayer"] = "ARTWORK",
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
					["friendlyWarlockColor"] = {
						["a"] = 1,
						["b"] = 0.79,
						["g"] = 0.51,
						["r"] = 0.58,
					},
					["feature"] = "colorvar_hostility_class",
					["friendlyDruidColor"] = {
						["a"] = 1,
						["b"] = 0.04,
						["g"] = 0.49,
						["r"] = 1,
					},
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["b"] = 0.23,
						["g"] = 0.12,
						["r"] = 0.77,
					},
					["friendlyMageColor"] = {
						["a"] = 1,
						["b"] = 0.94,
						["g"] = 0.8,
						["r"] = 0.41,
					},
					["friendlyPriestColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
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
					["colorVar"] = "hostilityclassColor",
					["owner"] = "sf_life",
					["w"] = "200",
					["drawLayer"] = "ARTWORK",
					["feature"] = "statusbar_horiz",
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
					["sublevel"] = 2,
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
					["name"] = "text_pheal",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["version"] = 1,
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
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["sb"] = 0,
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
					["h"] = "14",
					["ty"] = "hptxt2",
					["name"] = "text_vie",
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
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
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["ty"] = "fdld",
					["name"] = "text_dead",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 12,
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
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["ty"] = "mobtype",
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
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["edgeSize"] = 8,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["ba"] = 1,
						["bb"] = 0,
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
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.2,
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
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "nil",
					["name"] = "fm",
				}, -- [22]
				{
					["frac"] = "fm",
					["colorVar"] = "powerColor",
					["owner"] = "sf_mana",
					["w"] = "200",
					["drawLayer"] = "ARTWORK",
					["feature"] = "statusbar_horiz",
					["h"] = "10",
					["name"] = "sb_power",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["sublevel"] = 1,
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
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
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
						["_backdrop"] = "none",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["br"] = 1,
						["bb"] = 1,
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
						["size"] = 15,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["h"] = "30",
					["ty"] = "level",
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
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 8,
					["name"] = "np",
					["classColor"] = 1,
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
						["TimerType"] = "COOLDOWN",
						["GfxReverse"] = true,
						["TextType"] = "Seconds",
						["HideText"] = 0,
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
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "debuff",
					["size"] = 12,
					["orientation"] = "RIGHT",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["filterNameList"] = {
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
					["secure"] = 1,
					["h"] = 76,
					["version"] = 1,
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
						["class"] = "frs",
						["n"] = 4,
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
					["switchvehicle"] = 1,
					["version"] = 1,
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
						["size"] = 8,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["name"] = "Default",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["flags"] = "OUTLINE",
						["justifyH"] = "RIGHT",
						["cr"] = 1,
					},
					["headerstateType"] = "None",
					["headerstateCustom"] = "",
					["abid"] = 13,
					["version"] = 1,
					["size"] = 36,
					["orientation"] = "RIGHT",
					["name"] = "barbut2",
					["fontkey"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["cb"] = 0.1058823529411765,
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 10,
					},
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
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "RIGHT",
					["version"] = 1,
					["iconspy"] = 0,
					["nIcons"] = 6,
				}, -- [2]
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
						["b"] = 0.1098039215686275,
						["g"] = 0.08627450980392157,
						["r"] = 1,
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
					["usebs"] = true,
					["nIcons"] = 5,
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["b"] = 0.1098039215686275,
						["g"] = 0.08627450980392157,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 0.1098039215686275,
						["g"] = 0.08627450980392157,
						["r"] = 1,
					},
					["version"] = 1,
					["name"] = "customicon1",
					["color3"] = {
						["a"] = 1,
						["b"] = 0.1098039215686275,
						["g"] = 0.08627450980392157,
						["r"] = 1,
					},
					["orientation"] = "RIGHT",
					["drawLayer"] = "ARTWORK",
					["color5"] = {
						["a"] = 1,
						["b"] = 0.1098039215686275,
						["g"] = 0.08627450980392157,
						["r"] = 1,
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
					["name"] = "texcd_earth",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
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
					["flo"] = 3,
					["secure"] = 1,
				}, -- [5]
				{
					["name"] = "texcd_Fire",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
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
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["flo"] = 3,
					["secure"] = 1,
				}, -- [7]
				{
					["name"] = "texcd_water",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
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
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["flo"] = 3,
					["secure"] = 1,
				}, -- [9]
				{
					["name"] = "texcd_air",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 6,
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_simplesquare",
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
					["h"] = "36",
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
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = "144",
					["feature"] = "hotspot",
					["h"] = "14",
					["name"] = "remove",
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
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
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
					["font"] = {
						["size"] = 14,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Italic.ttf",
						["justifyH"] = "CENTER",
						["name"] = "Default",
						["flags"] = "THICKOUTLINE",
						["cg"] = 1,
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["ca"] = 1,
						["cb"] = 1,
						["cr"] = 1,
					},
					["name"] = "minimap1",
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
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "RIGHT",
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
						["b"] = 0,
						["g"] = 0.7176470588235294,
						["r"] = 0.788235294117647,
					},
				}, -- [1]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 0.5088750422000885,
						["b"] = 0.0392156862745098,
						["g"] = 0.407843137254902,
						["r"] = 0,
					},
				}, -- [2]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "rezinc",
					["set"] = {
						["class"] = "rez",
						["n"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "rezdone",
					["set"] = {
						["class"] = "rez",
						["n"] = 2,
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
					["version"] = 1,
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "50",
					["h"] = "12",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
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
					["showtitlebar"] = 1,
					["title"] = "Healing Done",
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
						["path"] = "Interface\\Icons\\Spell_Holy_HolyGuidance",
					},
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
					["cols"] = 1,
					["axis"] = 1,
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
						["_border"] = "straight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kb"] = 0,
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
					["flOffset"] = 0,
					["owner"] = "sf_plife",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["version"] = 1,
					["colorVar"] = "green",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_plife",
					},
					["name"] = "sb_plife",
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
					["friendlyDeathKnightColor"] = {
						["a"] = 1,
						["b"] = 0.23,
						["g"] = 0.12,
						["r"] = 0.77,
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
					["friendlyMageColor"] = {
						["a"] = 1,
						["b"] = 0.94,
						["g"] = 0.8,
						["r"] = 0.41,
					},
					["feature"] = "colorvar_hostility_class",
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
					["frac"] = "fh",
					["flOffset"] = 0,
					["owner"] = "sf_life",
					["w"] = "200",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
					["version"] = 1,
					["colorVar"] = "hostilityclassColor",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["name"] = "sb_life",
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
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
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
					["h"] = "14",
					["version"] = 1,
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
					["name"] = "text_vie",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["sb"] = 0,
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
					["font"] = {
						["size"] = 12,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["ty"] = "fdld",
					["version"] = 1,
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
					["font"] = {
						["size"] = 12,
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
					["ty"] = "mobtype",
					["version"] = 1,
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
						["ka"] = 0.7119999825954437,
						["kg"] = 0,
						["tile"] = false,
						["kb"] = 0,
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
				}, -- [21]
				{
					["feature"] = "ColorVariable: Unit PowerType Color",
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.5450980392156862,
						["b"] = 1,
					},
					["focusColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.5,
						["b"] = 0.2,
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
					["w"] = "150",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["name"] = "status_power",
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
					["ty"] = "mptxt",
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
						["br"] = 1,
						["bb"] = 1,
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
					["colorVar2"] = "nocolor",
					["feature"] = "ColorVariable: Conditional Color",
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
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
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
						["size"] = 15,
					},
					["ty"] = "level",
					["version"] = 1,
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
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
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
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
					["feature"] = "txt_np",
				}, -- [36]
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
					["flo"] = 3,
					["h"] = 76,
					["name"] = "",
				}, -- [37]
			},
		},
		["Paladin_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Paladin_fset",
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
				["name"] = "Paladin",
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Paladin_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0.4862745098039216,
					["g"] = 0.2274509803921569,
					["r"] = 1,
				},
				["texture"] = "",
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
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.6392156862745098,
						["b"] = 0,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_InnerFire",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_InnerFire_ds",
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
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Chat 4",
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
					["feature"] = "Secure Assists",
					["suffix1"] = "target",
					["suffix2"] = "targettarget",
					["interval"] = 0.1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
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
					["size"] = 36,
					["usebs"] = true,
					["externalButtonSkin"] = "bs_simplesquare",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["rows"] = 1,
					["owner"] = "decor",
					["version"] = 1,
					["feature"] = "vehiclebar",
					["iconspx"] = 2,
					["name"] = "vehiclebar",
					["ButtonSkinOffset"] = 6,
					["orientation"] = "RIGHT",
					["fontkey"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sx"] = 0,
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["title"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["iconspy"] = 0,
					["nIcons"] = 3,
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
						["b"] = 1,
						["g"] = 0.2627450980392157,
						["r"] = 0.2588235294117647,
					},
				}, -- [4]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 1,
						["r"] = 0.4313725490196079,
						["g"] = 1,
						["b"] = 0.2745098039215687,
					},
				}, -- [5]
				{
					["condVar"] = "isExhaustion",
					["name"] = "xpcolor",
					["colorVar1"] = "blue",
					["colorVar2"] = "green",
					["feature"] = "ColorVariable: Conditional Color",
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
						["kg"] = 0.7294117647058823,
						["kb"] = 1,
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
					["name"] = "statusBar",
					["orientation"] = "HORIZONTAL",
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
						["justifyH"] = "CENTER",
						["size"] = 10,
					},
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["h"] = "BaseHeight",
					["version"] = 1,
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
					["name"] = "texcd_earth",
					["gt"] = "",
					["version"] = 1,
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemearth_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["flags"] = "THICKOUTLINE",
							["name"] = "Default",
							["sx"] = 0,
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["sy"] = 0,
							["size"] = 11,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 1,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
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
					["h"] = 36,
					["version"] = 1,
				}, -- [5]
				{
					["name"] = "texcd_Fire",
					["gt"] = "",
					["version"] = 1,
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemfire_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["GfxReverse"] = true,
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
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 1,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
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
					["name"] = "fire",
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
					["flo"] = 3,
					["h"] = 36,
					["version"] = 1,
				}, -- [7]
				{
					["name"] = "texcd_water",
					["gt"] = "",
					["version"] = 1,
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemwater_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["GfxReverse"] = true,
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
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 1,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 72,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
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
					["flo"] = 3,
					["h"] = 36,
					["version"] = 1,
				}, -- [9]
				{
					["name"] = "texcd_air",
					["gt"] = "",
					["version"] = 1,
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemair_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["flags"] = "THICKOUTLINE",
							["justifyH"] = "CENTER",
							["sx"] = 0,
							["name"] = "Default",
							["sy"] = 0,
							["title"] = "Default",
							["size"] = 11,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = 0,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 1,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 2,
					["anchor"] = {
						["dx"] = 108,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
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
					["flo"] = 3,
					["h"] = 36,
					["version"] = 1,
				}, -- [11]
				{
					["feature"] = "commentline",
				}, -- [12]
				{
					["w"] = 144,
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "remove",
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
					["flo"] = 3,
					["h"] = 14,
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
						["class"] = "file",
						["file"] = "WoWRDX:Range_0_15_fset",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "frs",
							["n"] = 2,
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
					["orientation"] = "HORIZONTAL",
					["name"] = "rune1_bar",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
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
					["h"] = 14,
					["name"] = "rune1_timer",
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
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune1_bar",
					},
					["name"] = "rune1_text",
					["h"] = 14,
				}, -- [9]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune1_text",
					["statusBar"] = "rune1_bar",
					["texIcon"] = "rune1_tex",
					["txt"] = "rune1_name",
					["text"] = "rune1_timer",
					["feature"] = "free_timer",
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
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune1_icon",
					["TTIDefaultState"] = "Default",
					["timerVar"] = "rune1",
					["textType"] = "Tenths",
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
					["orientation"] = "HORIZONTAL",
					["name"] = "rune2_bar",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["name"] = "rune2_timer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 9,
					},
				}, -- [16]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["name"] = "rune2_text",
					["h"] = 14,
				}, -- [17]
				{
					["statusBar"] = "rune2_bar",
					["textInfo"] = "rune2_text",
					["TEIDefaultState"] = "Default",
					["texIcon"] = "rune2_tex",
					["txt"] = "rune2_name",
					["text"] = "rune2_timer",
					["feature"] = "free_timer",
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
					["sbDefaultState"] = "Full",
					["tex"] = "rune2_icon",
					["TTIDefaultState"] = "Default",
					["textType"] = "Tenths",
					["timerVar"] = "rune2",
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
					["orientation"] = "HORIZONTAL",
					["name"] = "rune3_bar",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["name"] = "rune3_timer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 9,
					},
				}, -- [24]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["name"] = "rune3_text",
					["h"] = 14,
				}, -- [25]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune3_text",
					["txt"] = "rune3_name",
					["texIcon"] = "rune3_tex",
					["statusBar"] = "rune3_bar",
					["text"] = "rune3_timer",
					["feature"] = "free_timer",
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
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune3_icon",
					["TTIDefaultState"] = "Default",
					["timerVar"] = "rune3",
					["textType"] = "Tenths",
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
					["orientation"] = "HORIZONTAL",
					["name"] = "rune4_bar",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
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
						["af"] = "rune4_bar",
					},
					["name"] = "rune4_timer",
					["h"] = 14,
				}, -- [32]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["name"] = "rune4_text",
					["h"] = 14,
				}, -- [33]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune4_text",
					["txt"] = "rune4_name",
					["texIcon"] = "rune4_tex",
					["statusBar"] = "rune4_bar",
					["text"] = "rune4_timer",
					["feature"] = "free_timer",
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
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune4_icon",
					["TTIDefaultState"] = "Default",
					["timerVar"] = "rune4",
					["textType"] = "Tenths",
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
					["orientation"] = "HORIZONTAL",
					["name"] = "rune5_bar",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["name"] = "rune5_timer",
					["h"] = 14,
				}, -- [40]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["name"] = "rune5_text",
					["h"] = 14,
				}, -- [41]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune5_text",
					["txt"] = "rune5_name",
					["texIcon"] = "rune5_tex",
					["statusBar"] = "rune5_bar",
					["text"] = "rune5_timer",
					["feature"] = "free_timer",
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
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune5_icon",
					["TTIDefaultState"] = "Default",
					["timerVar"] = "rune5",
					["textType"] = "Tenths",
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
					["orientation"] = "HORIZONTAL",
					["name"] = "rune6_bar",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["name"] = "rune6_timer",
					["h"] = 14,
				}, -- [48]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["name"] = "rune6_text",
					["h"] = 14,
				}, -- [49]
				{
					["TEIDefaultState"] = "Default",
					["textInfo"] = "rune6_text",
					["txt"] = "rune6_name",
					["texIcon"] = "rune6_tex",
					["statusBar"] = "rune6_bar",
					["text"] = "rune6_timer",
					["feature"] = "free_timer",
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
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbDefaultState"] = "Full",
					["tex"] = "rune6_icon",
					["TTIDefaultState"] = "Default",
					["timerVar"] = "rune6",
					["textType"] = "Tenths",
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
						["path"] = "Interface\\Icons\\Ability_BackStab",
					},
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
					["axis"] = 1,
					["cols"] = 1,
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
					["ph"] = true,
					["h"] = 14,
					["version"] = 1,
					["feature"] = "base_default",
					["alpha"] = 1,
					["w"] = 90,
					["a"] = 1,
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
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [5]
				{
					["owner"] = "Base",
					["w"] = "50",
					["classColor"] = 1,
					["h"] = "14",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["feature"] = "txt_np",
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
				}, -- [6]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
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
					["ty"] = "fdld",
					["name"] = "status_text",
				}, -- [7]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
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
					["ty"] = "hpp",
					["name"] = "text_hp_percent",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["name"] = "rune1_timer",
				}, -- [8]
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
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
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
					["countTypeFlag"] = "true",
					["tex"] = "rune1_icon",
					["txt"] = "rune1_name",
					["timerVar"] = "rune1",
					["texIcon"] = "rune1_tex",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
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
					["name"] = "rune2_timer",
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
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["h"] = 14,
					["name"] = "rune2_text",
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
					["TEIExpireState"] = "Default",
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
					["countTypeFlag"] = "true",
					["tex"] = "rune2_icon",
					["txt"] = "rune2_name",
					["timerVar"] = "rune2",
					["texIcon"] = "rune2_tex",
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
					["drawLayer"] = "OVERLAY",
					["name"] = "rune3_tex",
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
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
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
					["name"] = "rune3_timer",
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
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["h"] = 14,
					["name"] = "rune3_text",
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
					["TEIExpireState"] = "Default",
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
					["countTypeFlag"] = "true",
					["tex"] = "rune3_icon",
					["txt"] = "rune3_name",
					["timerVar"] = "rune3",
					["texIcon"] = "rune3_tex",
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
					["drawLayer"] = "OVERLAY",
					["name"] = "rune4_tex",
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
						["af"] = "rune4_bar",
					},
					["h"] = 14,
					["name"] = "rune4_timer",
				}, -- [32]
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
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["h"] = 14,
					["name"] = "rune4_text",
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
					["TEIExpireState"] = "Default",
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
					["countTypeFlag"] = "true",
					["tex"] = "rune4_icon",
					["txt"] = "rune4_name",
					["timerVar"] = "rune4",
					["texIcon"] = "rune4_tex",
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
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["drawLayer"] = "OVERLAY",
					["name"] = "rune5_tex",
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
						["af"] = "rune5_bar",
					},
					["h"] = 14,
					["name"] = "rune5_timer",
				}, -- [40]
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
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["h"] = 14,
					["name"] = "rune5_text",
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
					["TEIExpireState"] = "Default",
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
					["countTypeFlag"] = "true",
					["tex"] = "rune5_icon",
					["txt"] = "rune5_name",
					["timerVar"] = "rune5",
					["texIcon"] = "rune5_tex",
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
					["anchor"] = {
						["dx"] = 20,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["drawLayer"] = "OVERLAY",
					["name"] = "rune6_tex",
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
						["af"] = "rune6_bar",
					},
					["h"] = 14,
					["name"] = "rune6_timer",
				}, -- [48]
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
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["h"] = 14,
					["name"] = "rune6_text",
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
					["TEIExpireState"] = "Default",
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
					["countTypeFlag"] = "true",
					["tex"] = "rune6_icon",
					["txt"] = "rune6_name",
					["timerVar"] = "rune6",
					["texIcon"] = "rune6_tex",
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
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Shaman_fset",
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
				["name"] = "Shaman",
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Shaman_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0.5098039215686274,
					["g"] = 0.7019607843137257,
					["r"] = 0.00392156862745098,
				},
				["texture"] = "",
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
						["b"] = 0,
						["g"] = 0.8156862745098039,
						["r"] = 0.03137254901960784,
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
					["owner"] = "decor",
					["w"] = "120",
					["flOffset"] = 1,
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
					["owner"] = "decor",
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
					["owner"] = "decor",
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
					["name"] = "hpbar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [11]
				{
					["feature"] = "txt_np",
					["h"] = "14",
					["name"] = "np",
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
					["anchor"] = {
						["dx"] = 12,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "110",
					["version"] = 1,
				}, -- [12]
				{
					["owner"] = "decor",
					["w"] = "35",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_hp_percent",
					["anchor"] = {
						["dx"] = 102,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["font"] = {
						["size"] = 8,
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
					["ty"] = "hpp",
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
					["maxdurationfilter"] = 3000,
					["mindurationfilter"] = 0,
					["auraType"] = "DEBUFFS",
					["ButtonSkinOffset"] = 0,
					["owner"] = "decor",
					["text"] = "STACK",
					["nIcons"] = 10,
					["name"] = "debuffs",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\framd.ttf",
						["justifyV"] = "CENTER",
						["size"] = 8,
					},
					["version"] = 1,
					["ephemeral"] = 1,
					["orientation"] = "LEFT",
					["cdoffx"] = 0,
					["myaurasfilter"] = 1,
					["usebs"] = true,
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
					["name"] = "statusBar",
					["orientation"] = "HORIZONTAL",
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
					["font"] = {
						["size"] = 8,
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -1,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "subframe",
					},
					["name"] = "spellText",
					["h"] = "14",
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
					["countTypeFlag"] = "",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "spell",
					["TEIExpireState"] = "Hide",
				}, -- [19]
				{
					["txt"] = "spell_name_rank",
					["owner"] = "subframe",
					["w"] = "93",
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
						["justifyH"] = "LEFT",
						["size"] = 8,
					},
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = 13,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["version"] = 1,
					["h"] = "14",
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
					["set"] = {
						["file"] = "default:set_raid_group5",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
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
						["r"] = 0.2117647058823529,
						["g"] = 0.3882352941176471,
						["b"] = 1,
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
					["frac"] = "fcombatmeter1",
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["h"] = "12",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "blue",
					["version"] = 1,
					["interpolate"] = 1,
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
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
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
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["h"] = "12",
					["classColor"] = 1,
					["version"] = 1,
				}, -- [6]
				{
					["txt"] = "combatmeter1_text",
					["owner"] = "pdt",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["font"] = {
						["size"] = 9,
						["name"] = "Default",
						["title"] = "Default",
						["sg"] = 0,
						["sx"] = 1,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["ca"] = 1,
						["cg"] = 1,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sa"] = 1,
						["sr"] = 0,
						["cb"] = 1,
						["cr"] = 1,
					},
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["h"] = "12",
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
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Chat 3",
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
					["mbFriendly"] = "default:bindings_player",
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
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0.4352941176470588,
						["g"] = 0.03137254901960784,
						["b"] = 0.7803921568627451,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_Shadow_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Raid_fset",
						["class"] = "file",
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
					["mbFriendly"] = "WoWRDX:Priest_Buff_Shadow_mb",
				}, -- [5]
				{
					["feature"] = "mp_args",
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
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
							["class"] = "frs",
							["n"] = 3,
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
		["infoAuthor"] = "Sigg",
		["Bossmod_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				"@other", -- [1]
				"!69127", -- [2]
				"!57724", -- [3]
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["name"] = "TotemEarthBar",
					["orientation"] = "HORIZONTAL",
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
						["justifyH"] = "CENTER",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemEarthBar",
					},
					["h"] = "12",
					["name"] = "EarthTimer",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["texIcon"] = "TotemEarthIcon",
				}, -- [11]
				{
					["w"] = 36,
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
					["h"] = 36,
					["flo"] = 3,
					["version"] = 1,
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["name"] = "TotemFireBar",
					["orientation"] = "HORIZONTAL",
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemFireBar",
					},
					["name"] = "FireTimer",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "CENTER",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
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
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["texIcon"] = "TotemFireIcon",
				}, -- [17]
				{
					["w"] = 36,
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "fire",
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
					["h"] = 36,
					["flo"] = 3,
					["version"] = 1,
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["name"] = "TotemWaterBar",
					["orientation"] = "HORIZONTAL",
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemWaterBar",
					},
					["name"] = "WaterTimer",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "CENTER",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
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
					["countTypeFlag"] = "false",
					["tex"] = "totemwater_icon",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["texIcon"] = "TotemWaterIcon",
				}, -- [23]
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
						["dx"] = 74,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["flo"] = 3,
					["version"] = 1,
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
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
					["name"] = "TotemAirBar",
					["orientation"] = "HORIZONTAL",
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemAirBar",
					},
					["name"] = "AirTimer",
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "CENTER",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["sr"] = 0,
					},
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
					["countTypeFlag"] = "false",
					["tex"] = "totemair_icon",
					["txt"] = "",
					["timerVar"] = "totemair",
					["texIcon"] = "TotemAirIcon",
				}, -- [29]
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
						["dx"] = 111,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 36,
					["flo"] = 3,
					["version"] = 1,
				}, -- [30]
				{
					["feature"] = "commentline",
				}, -- [31]
				{
					["w"] = 148,
					["feature"] = "hotspot",
					["secure"] = 1,
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
					["h"] = 12,
					["flo"] = 3,
					["version"] = 1,
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
		["Range_0_30_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "frs",
						["n"] = 3,
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
					["drawLayer"] = "OVERLAY",
					["name"] = "TotemEarthIcon",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [11]
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
						["title"] = "Default",
						["sb"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["h"] = 14,
					["name"] = "EarthTimer",
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["texIcon"] = "TotemEarthIcon",
				}, -- [13]
				{
					["txt"] = "totemearth_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["h"] = 14,
					["name"] = "status_text_earth",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["version"] = 1,
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
				}, -- [14]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["h"] = 20,
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
					["secure"] = 1,
					["flo"] = 3,
					["version"] = 1,
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
					["drawLayer"] = "OVERLAY",
					["name"] = "TotemFireIcon",
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
						["af"] = "TotemFireBar",
					},
					["name"] = "FireTimer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["texIcon"] = "TotemFireIcon",
				}, -- [22]
				{
					["txt"] = "totemfire_name",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_dyn",
					["h"] = 14,
					["name"] = "status_text_firea",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemFireBar",
					},
					["version"] = 1,
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
				}, -- [23]
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
					["name"] = "fire",
					["secure"] = 1,
					["h"] = 20,
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
					["drawLayer"] = "OVERLAY",
					["name"] = "TotemWaterIcon",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [29]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemWaterBar",
					},
					["name"] = "WaterTimer",
					["h"] = 14,
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemwater_icon",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["texIcon"] = "TotemWaterIcon",
				}, -- [31]
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
					["h"] = 14,
					["version"] = 1,
				}, -- [32]
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
					["name"] = "water",
					["secure"] = 1,
					["h"] = 20,
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
					["drawLayer"] = "OVERLAY",
					["name"] = "TotemAirIcon",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [38]
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
					["name"] = "AirTimer",
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 9,
					},
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemair_icon",
					["txt"] = "",
					["timerVar"] = "totemair",
					["texIcon"] = "TotemAirIcon",
				}, -- [40]
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
					["name"] = "status_text_air",
					["h"] = 14,
				}, -- [41]
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
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 20,
					["flo"] = 3,
					["name"] = "air",
				}, -- [42]
				{
					["feature"] = "commentline",
				}, -- [43]
				{
					["w"] = 20,
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
					["h"] = 80,
					["flo"] = 3,
					["name"] = "remove",
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
		["Raid_Pet"] = {
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
					["title"] = "Pets",
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
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAIDPET",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Raid_Pet_fset",
					},
				}, -- [3]
				{
					["feature"] = "Header Grid",
					["dxn"] = 1,
					["axis"] = 1,
					["bkt"] = 1,
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
		["Dps_Health_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["qty"] = "shp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Dps_fset",
					},
				},
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["name"] = "DPS HP",
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
						["file"] = "WoWRDX:Dps_fset",
					},
				},
				["pct"] = 1,
				["sv"] = 1,
				["texture"] = "",
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
				}, -- [2]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Target_Hot_ds",
				}, -- [3]
				{
					["feature"] = "Data Source: Set",
					["set"] = {
						["file"] = "WoWRDX:Target_Hot_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
				}, -- [4]
				{
					["feature"] = "Grid Layout",
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [5]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.10000000149012,
					["slot"] = "RepaintAll",
				}, -- [6]
			},
		},
		["infoVersion"] = "1.0.0",
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
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["feature"] = "multicastbar",
					["iconspx"] = 1,
					["cd"] = {
						["GfxReverse"] = false,
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
					["fontmacro"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["fontkey"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["bkd"] = {
						["_border"] = "none",
					},
					["version"] = 1,
					["usebs"] = true,
					["orientation"] = "RIGHT",
					["name"] = "totembar1",
					["size"] = 36,
					["totembar"] = "Elements",
				}, -- [2]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["feature"] = "multicastbar",
					["iconspx"] = 1,
					["cd"] = {
						["GfxReverse"] = false,
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
					["fontmacro"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["fontkey"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["bkd"] = {
					},
					["version"] = 1,
					["usebs"] = true,
					["orientation"] = "RIGHT",
					["name"] = "totembar2",
					["size"] = 36,
					["totembar"] = "Ancestors",
				}, -- [3]
				{
					["showtooltip"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["feature"] = "multicastbar",
					["iconspx"] = 1,
					["cd"] = {
						["GfxReverse"] = false,
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
					["fontmacro"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 8,
					},
					["fontkey"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "TOP",
						["size"] = 8,
					},
					["bkd"] = {
					},
					["version"] = 1,
					["usebs"] = true,
					["orientation"] = "RIGHT",
					["name"] = "totembar3",
					["size"] = 36,
					["totembar"] = "Spirits",
				}, -- [4]
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
						["sr"] = 0,
						["sa"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 1,
						["flags"] = "THICKOUTLINE",
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["size"] = 14,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["cr"] = 1,
							["sr"] = 0,
							["sb"] = 0,
							["sa"] = 1,
							["cb"] = 0.1333333333333333,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["justifyH"] = "CENTER",
							["ca"] = 1,
							["sg"] = 0,
							["title"] = "Default",
							["sx"] = 1,
							["cg"] = 0.7372549019607844,
							["name"] = "Default",
							["sy"] = -1,
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.1,
						["TextType"] = "Largest",
						["HideText"] = 0,
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
					["bkd"] = {
					},
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "LEFT",
					["usebs"] = true,
					["smooth"] = 1,
					["unitfilter"] = "",
				}, -- [2]
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
		["Battleground_desk"] = {
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
					["title"] = "Konyagi_AUI:desk_solo",
					["offsetright"] = "0",
					["name"] = "root",
					["open"] = true,
					["dock"] = {
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
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Combat_Logs",
							["x"] = 20,
							["point"] = "BOTTOMRIGHT",
							["y"] = -20,
						},
						["CENTER"] = {
							["id"] = "WoWRDX:Panel_Center",
							["x"] = 0,
							["point"] = "CENTER",
							["y"] = 0,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["open"] = true,
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
					["b"] = 128.0000160547205,
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
					["r"] = 1365.333385068319,
					["scale"] = 1,
					["t"] = 768.0000066917983,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["open"] = true,
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
					["r"] = 512.0000044611988,
					["scale"] = 1,
					["t"] = 416.4267033610263,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 336.2133378563921,
					["b"] = 351.573363088455,
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
					["r"] = 770.5600258365629,
					["scale"] = 1,
					["t"] = 256.0000022305994,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 594.7733592317561,
					["b"] = 233.8133339762682,
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
					["t"] = 343.0400256969228,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 336.2133378563921,
					["b"] = 278.1866854243514,
					["r"] = 512.0000044611988,
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
					["r"] = 853.3333806071202,
					["scale"] = 1,
					["t"] = 469.3333473823794,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Panel_Center",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 512.0000044611988,
					["b"] = 298.6666593094188,
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
						["CENTER"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "CENTER",
							["y"] = 0,
						},
					},
				}, -- [19]
				{
					["strata"] = "MEDIUM",
					["r"] = 1029.120047211927,
					["scale"] = 1,
					["t"] = 416.4267033610263,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Target_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 853.3333806071202,
					["b"] = 351.573363088455,
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
					["r"] = 1213.439991450583,
					["scale"] = 1,
					["t"] = 416.4267033610263,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 1037.653324845776,
					["b"] = 351.573363088455,
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
					["r"] = 1348.266710285255,
					["scale"] = 1,
					["t"] = 145.0666609589433,
					["alpha"] = 1,
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
					["l"] = 1028.266707497005,
					["b"] = 17.06666731335399,
					["open"] = true,
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
					["b"] = 589.6532611845438,
					["open"] = true,
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
		["Status_Raid"] = {
			["ty"] = "StatusWindow",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Status",
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
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
					["axis"] = 1,
					["cols"] = 2,
					["dxn"] = 2,
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
					["rostertype"] = "BOSS",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Boss_fset",
					},
				}, -- [3]
				{
					["feature"] = "Boss Layout",
					["axis"] = 1,
					["cols"] = 1,
					["dxn"] = 1,
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
					["fontkey"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sx"] = 0,
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["title"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["orientation"] = "RIGHT",
					["size"] = 36,
					["name"] = "actionbarpet",
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
						["class"] = "file",
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
					},
				}, -- [2]
				{
					["auraType"] = "BUFFS",
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
					["timer1"] = "0",
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["timer2"] = "0",
					["name"] = "aurai",
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["cd"] = 79061,
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["w"] = 80,
					["alpha"] = 1,
					["feature"] = "base_default",
				}, -- [5]
				{
					["frac"] = "",
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "13",
					["name"] = "statusBar",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "aurai_aura",
					["texIcon"] = "",
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
						["size"] = 9,
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["ty"] = "gn",
					["h"] = "14",
					["name"] = "text_group",
				}, -- [10]
				{
					["owner"] = "high",
					["w"] = "BaseWidth",
					["feature"] = "txt_np",
					["h"] = "BaseHeight",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 10,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["name"] = "np",
					["classColor"] = 1,
					["font"] = {
						["size"] = 10,
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [15]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "range",
					["colorVar1"] = "red",
					["condVar"] = "unitInRange30_flag",
					["colorVar2"] = "alpha",
				}, -- [16]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "true",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [17]
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
					["anyup"] = 1,
					["rows"] = 1,
					["fontcount"] = {
						["size"] = 10,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["justifyH"] = "RIGHT",
						["ca"] = 1,
						["cg"] = 0.3882352941176471,
						["name"] = "Default",
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
					["nIcons"] = 12,
					["showkey"] = 1,
					["showtooltip"] = 1,
					["externalButtonSkin"] = "bs_simplesquare",
					["owner"] = "decor",
					["usebs"] = true,
					["version"] = 1,
					["headerstateType"] = "Defaultui",
					["abid"] = 1,
					["name"] = "barbut1",
					["headerstateCustom"] = "",
					["orientation"] = "RIGHT",
					["fontmacro"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["cb"] = 0.8901960784313725,
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["bkd"] = {
						["ka"] = 1,
						["edgeSize"] = 12,
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "IshBorder",
						["kg"] = 0.1,
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["size"] = 36,
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
							["class"] = "frs",
							["n"] = 4,
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
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
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sx"] = 0,
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["title"] = "Default",
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 10,
					},
					["iconspy"] = 0,
					["size"] = 36,
					["showkey"] = 1,
					["owner"] = "decor",
					["version"] = 1,
					["usebs"] = true,
					["orientation"] = "RIGHT",
					["externalButtonSkin"] = "bs_simplesquare",
					["name"] = "stancebar",
					["nIcons"] = 8,
				}, -- [2]
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
					["version"] = 1,
					["gt"] = "MainHandEnchant_InventoryItem",
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["sr"] = 0,
							["sy"] = -1,
							["sx"] = 1,
							["justifyH"] = "CENTER",
							["sb"] = 0,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["title"] = "Default",
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["name"] = "Default",
							["cb"] = 0.1333333333333333,
							["sg"] = 0,
							["sa"] = 1,
							["size"] = 10,
							["cr"] = 1,
						},
						["Offsety"] = -20,
						["TimerType"] = "COOLDOWN&TEXT",
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Largest",
						["HideText"] = 0,
					},
					["dyntexture"] = 1,
					["owner"] = "Base",
					["w"] = "30",
					["tex"] = "MainHand_icon",
					["feature"] = "texture_cooldown",
					["h"] = "30",
					["name"] = "mainhand",
					["ButtonSkinOffset"] = 4,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "mediapack:bs_entropy",
					["timerVar"] = "MainHandEnchant",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [3]
				{
					["version"] = 1,
					["gt"] = "OffHandEnchant_InventoryItem",
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["size"] = 10,
							["sy"] = -1,
							["sx"] = 1,
							["justifyH"] = "CENTER",
							["sb"] = 0,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["title"] = "Default",
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["name"] = "Default",
							["cb"] = 0.1333333333333333,
							["sg"] = 0,
							["sa"] = 1,
							["sr"] = 0,
							["cr"] = 1,
						},
						["Offsety"] = -20,
						["TimerType"] = "COOLDOWN&TEXT",
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Largest",
						["HideText"] = 0,
					},
					["dyntexture"] = 1,
					["owner"] = "Base",
					["w"] = "30",
					["tex"] = "OffHand_icon",
					["feature"] = "texture_cooldown",
					["h"] = "30",
					["name"] = "offhand",
					["ButtonSkinOffset"] = 4,
					["anchor"] = {
						["dx"] = 35,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "mediapack:bs_entropy",
					["timerVar"] = "OffHandEnchant",
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
		["Tanks_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_DeathKnight_DarkConviction",
					},
					["showtitlebar"] = 1,
					["feature"] = "Frame: Lightweight",
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
					["title"] = "Main Tanks",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Assists_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "mtma",
						["n"] = 1,
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
					["mbFriendly"] = "WoWRDX:Assists_mb",
				}, -- [5]
				{
					["feature"] = "Description",
					["description"] = "Blizzard Main Tanks",
				}, -- [6]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [7]
			},
		},
		["Assist_List"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Assists",
					["bkdColor"] = {
						["a"] = 0.2557997107505798,
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
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["showtitlebar"] = true,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Assists_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "default:assists",
						["class"] = "file",
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
					["mbFriendly"] = "default:bindings",
				}, -- [5]
				{
					["feature"] = "NominativeSet Editor",
				}, -- [6]
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
					["version"] = 1,
					["clickable"] = 1,
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
					["file"] = "WoWRDX:Rez_Monitor_fset",
					["class"] = "file",
				},
			},
		},
		["Assists_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Main Assists",
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
						["path"] = "Interface\\Icons\\Spell_DeathKnight_Explode_Ghoul",
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Assists_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "mtma",
						["n"] = 2,
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
					["mbFriendly"] = "WoWRDX:Assists_mb",
				}, -- [5]
				{
					["feature"] = "Description",
					["description"] = "Blizzard Main Assists",
				}, -- [6]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [7]
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
						["class"] = "debuff",
						["buff"] = "@curse",
					}, -- [2]
				}, -- [2]
			},
		},
		["Name_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["feature"] = "base_default",
					["alpha"] = 1,
					["w"] = 90,
				}, -- [1]
				{
					["owner"] = "Base",
					["w"] = "90",
					["classColor"] = 1,
					["h"] = "14",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
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
					["feature"] = "txt_np",
					["version"] = 1,
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
						["buff"] = 79061,
						["class"] = "buff",
					}, -- [2]
				}, -- [2]
			},
		},
		["Offline_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["name"] = "Offline",
				["texture"] = "",
				["max"] = {
					["set"] = {
						["class"] = "group",
					},
					["qty"] = "ssz",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0.01176470588235294,
					["g"] = 0,
					["r"] = 0.4705882352941178,
				},
				["sv"] = 3,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Offline_set",
						["class"] = "file",
					},
					["qty"] = "ssz",
				},
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
						["ka"] = 0.2749999761581421,
						["kg"] = 0,
						["kb"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["edgeSize"] = 8,
						["_border"] = "HalStraight",
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
					["name"] = "BackgroundBar",
					["orientation"] = "HORIZONTAL",
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
					["name"] = "HealthBar",
					["orientation"] = "HORIZONTAL",
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
					["h"] = "20",
					["name"] = "np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\FRIZQT__.TTF",
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
				}, -- [17]
				{
					["owner"] = "main2",
					["w"] = "35",
					["feature"] = "txt_status",
					["ty"] = "hpp",
					["name"] = "text_hp_percent",
					["anchor"] = {
						["dx"] = -4,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_main2",
					},
					["version"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\FRIZQT__.TTF",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["size"] = 10,
					},
					["h"] = "20",
				}, -- [18]
				{
					["w"] = "140",
					["feature"] = "hotspot",
					["h"] = "20",
					["name"] = "",
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
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
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
					["usebs"] = true,
					["petauras"] = 1,
					["filterNameList"] = {
					},
					["version"] = 1,
					["maxdurationfilter"] = "",
					["orientation"] = "RIGHT",
					["name"] = "debuffs",
					["size"] = 10,
					["unitfilter"] = "",
				}, -- [21]
			},
		},
		["ClassBar_ds"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["DEATHKNIGHT"] = "WoWRDX:Deathknight_Runes1_ds",
				["ROGUE"] = "WoWRDX:Rogue_Combo_ds",
				["class"] = "class&form",
				["WARLOCK"] = "WoWRDX:Warlock_Shards_ds",
				["PALADIN"] = "WoWRDX:Paladin_HolyPower_ds",
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
		["Priest_Buff_InnerFire_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 588,
					["name"] = "auraia",
					["auraType"] = "BUFFS",
				}, -- [1]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0.0196078431372549,
						["g"] = 0.8627450980392157,
						["r"] = 1,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["hlt"] = 1,
					["alpha"] = 1,
					["w"] = 80,
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
					["colorVar"] = "yellow",
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
					["name"] = "tex1",
					["version"] = 1,
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
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "subframe",
					},
					["h"] = "14",
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
					["TEIExpireState"] = "Default",
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
					["version"] = 1,
					["clickable"] = 1,
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
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
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
					["drawLayer"] = "ARTWORK",
					["h"] = 20,
					["bkd"] = {
						["ka"] = 1,
						["kg"] = 0.1,
						["tile"] = false,
						["kr"] = 0.1,
						["kb"] = 0.1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["edgeSize"] = 12,
						["_border"] = "IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["owner"] = "decor",
					["w"] = 20,
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "customicon1",
					["color3"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["version"] = 1,
					["orientation"] = "RIGHT",
					["nIcons"] = 5,
					["color5"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["usebs"] = true,
				}, -- [3]
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
		["Info"] = {
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
					["title"] = "Info",
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
					["design"] = "WoWRDX:Info_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
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
						["b"] = 0.3647058823529412,
						["g"] = 1,
						["r"] = 0.6274509803921569,
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
					["interpolate"] = 1,
					["owner"] = "pdt",
					["w"] = "140",
					["h"] = "12",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "green",
					["version"] = 1,
					["frac"] = "fcombatmeter1",
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
					["w"] = "100",
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
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
					["classColor"] = 1,
					["name"] = "np",
				}, -- [6]
				{
					["txt"] = "combatmeter1_text",
					["owner"] = "pdt",
					["w"] = "138",
					["feature"] = "txt_dyn",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_pdt",
					},
					["name"] = "infoText",
					["font"] = {
						["size"] = 10,
						["title"] = "Default",
						["name"] = "Default",
						["sg"] = 0,
						["sx"] = 1,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["ca"] = 1,
						["cg"] = 1,
						["justifyH"] = "RIGHT",
						["cb"] = 1,
						["sa"] = 1,
						["sr"] = 0,
						["sb"] = 0,
						["cr"] = 1,
					},
				}, -- [7]
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["orientation"] = "VERTICAL",
					["name"] = "TotemEarthBar",
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
					["font"] = {
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
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
						["dx"] = -1,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["h"] = 12,
					["name"] = "EarthTimer",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["texIcon"] = "TotemEarthIcon",
				}, -- [11]
				{
					["w"] = 50,
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
					["h"] = 36,
					["secure"] = 1,
					["name"] = "earth",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["w"] = 12,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["name"] = "TotemFireBar",
					["h"] = 36,
					["orientation"] = "VERTICAL",
					["anchor"] = {
						["dx"] = 87,
						["dy"] = 12,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 49,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
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
						["justifyH"] = "CENTER",
						["size"] = 9,
					},
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
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["texIcon"] = "TotemFireIcon",
				}, -- [17]
				{
					["w"] = 50,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
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
					["h"] = 36,
					["secure"] = 1,
					["name"] = "fire",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["anchor"] = {
						["dx"] = 137,
						["dy"] = 12,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 101,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
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
						["justifyH"] = "CENTER",
						["size"] = 9,
					},
					["name"] = "WaterTimer",
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
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["texIcon"] = "",
				}, -- [24]
				{
					["w"] = 50,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
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
					["h"] = 36,
					["secure"] = 1,
					["name"] = "water",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
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
					["anchor"] = {
						["dx"] = 187,
						["dy"] = 12,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 149,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
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
						["justifyH"] = "CENTER",
						["size"] = 9,
					},
					["name"] = "AirTimer",
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
					["countTypeFlag"] = "false",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "totemair",
					["texIcon"] = "",
				}, -- [31]
				{
					["w"] = 50,
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
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
					["h"] = 36,
					["secure"] = 1,
					["name"] = "air",
				}, -- [32]
				{
					["feature"] = "commentline",
				}, -- [33]
				{
					["w"] = 200,
					["feature"] = "hotspot",
					["flo"] = 3,
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
					["h"] = 12,
					["secure"] = 1,
					["name"] = "remove",
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
						["ka"] = 0.5,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kr"] = 0,
						["kb"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
						["edgeSize"] = 16,
						["kg"] = 0,
						["_border"] = "tooltip",
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
					["ty"] = "level",
					["name"] = "level_text",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = -5,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["h"] = "14",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "120",
					["classColor"] = 1,
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
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
						["af"] = "Text_level_text",
					},
					["h"] = "14",
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [4]
				{
					["txt"] = "Class:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_level_text",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "class_text_static",
				}, -- [5]
				{
					["txt"] = "Race:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_class_text_static",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "race_text_static",
				}, -- [6]
				{
					["txt"] = "Mtype:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_race_text_static",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "mobtype_text_static",
				}, -- [7]
				{
					["txt"] = "Group:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_mobtype_text_static",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "group_text_static",
				}, -- [8]
				{
					["txt"] = "Guild:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["h"] = "14",
					["name"] = "guild_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_group_text_static",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
				}, -- [9]
				{
					["txt"] = "Target:",
					["owner"] = "decor",
					["w"] = "50",
					["feature"] = "txt_static",
					["h"] = "14",
					["name"] = "target_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_guild_text_static",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
				}, -- [10]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "guild_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_guild_text_static",
					},
					["h"] = "14",
					["ty"] = "guild",
					["version"] = 1,
				}, -- [11]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
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
						["af"] = "Text_class_text_static",
					},
					["ty"] = "class",
					["h"] = "14",
					["name"] = "class_text_var",
				}, -- [12]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
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
						["af"] = "Text_race_text_static",
					},
					["ty"] = "race",
					["h"] = "14",
					["name"] = "race_text_var",
				}, -- [13]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "mobtype_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_mobtype_text_static",
					},
					["h"] = "14",
					["ty"] = "mobtype",
					["version"] = 1,
				}, -- [14]
				{
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["name"] = "group_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_group_text_static",
					},
					["h"] = "14",
					["ty"] = "gn",
					["version"] = 1,
				}, -- [15]
				{
					["editor"] = "--enter your code here\n\nlocal varsc1 = UnitName(uid .. \"target\");",
					["name"] = "varsc1",
					["vartype"] = "TextData",
					["feature"] = "var_scripted",
				}, -- [16]
				{
					["txt"] = "varsc1",
					["owner"] = "decor",
					["w"] = "100",
					["feature"] = "txt_dyn",
					["h"] = "14",
					["name"] = "target_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_target_text_static",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
				}, -- [17]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [18]
				{
					["frac"] = "fh",
					["drawLayer"] = "ARTWORK",
					["feature"] = "statusbar_horiz",
					["owner"] = "decor",
					["w"] = "140",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["h"] = "14",
					["name"] = "healthBar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_target_text_static",
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["sublevel"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [19]
				{
					["owner"] = "decor",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\AvantGarde.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 5,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["ty"] = "hpp",
					["h"] = "14",
					["name"] = "hp_text",
				}, -- [20]
			},
		},
		["infoComment"] = "",
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
						["sr"] = 0,
						["sa"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
						["justifyV"] = "BOTTOM",
						["sb"] = 0,
						["flags"] = "THICKOUTLINE",
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 14,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["size"] = 10,
							["ca"] = 1,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
							["justifyV"] = "CENTER",
							["justifyH"] = "CENTER",
							["flags"] = "OUTLINE",
							["cg"] = 0.7372549019607844,
							["title"] = "Default",
							["sx"] = 0,
							["name"] = "Default",
							["cb"] = 0.1333333333333333,
							["sy"] = 0,
							["cr"] = 1,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.1,
						["TextType"] = "Largest",
						["HideText"] = 0,
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
					["version"] = 1,
					["maxdurationfilter"] = "",
					["orientation"] = "LEFT",
					["name"] = "ai1",
					["size"] = 30,
					["unitfilter"] = "",
				}, -- [2]
			},
		},
		["Overheal_Done"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_Restoration",
					},
					["title"] = "Overhealing Done",
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
					["cols"] = 1,
					["axis"] = 1,
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
					["h"] = "10",
					["version"] = 1,
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
					["anchor"] = {
						["dx"] = 8,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["trunc"] = 8,
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [2]
				{
					["owner"] = "decor",
					["w"] = "40",
					["feature"] = "txt_status",
					["font"] = {
						["size"] = 9,
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
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["name"] = "group",
					["h"] = "10",
					["ty"] = "gn",
				}, -- [3]
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
						["size"] = 10,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "BOTTOM",
						["justifyH"] = "RIGHT",
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.3882352941176471,
						["name"] = "Default",
						["cb"] = 1,
						["sy"] = 0,
						["sx"] = 0,
						["ca"] = 1,
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
						["Offsety"] = 0,
						["TimerType"] = "COOLDOWN",
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
					["anyup"] = 1,
					["externalButtonSkin"] = "bs_simplesquare",
					["usebs"] = true,
					["owner"] = "decor",
					["fontmacro"] = {
						["size"] = 8,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["name"] = "Default",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["ca"] = 1,
						["justifyH"] = "RIGHT",
						["cr"] = 1,
					},
					["headerstateCustom"] = "",
					["headerstateType"] = "None",
					["abid"] = 61,
					["name"] = "barbut2",
					["version"] = 1,
					["orientation"] = "RIGHT",
					["bkd"] = {
					},
					["size"] = 36,
					["hidebs"] = 1,
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
						["class"] = "debuff",
						["buff"] = "@poison",
					}, -- [2]
				}, -- [2]
			},
		},
		["Paladin_Buff_Kings_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"set", -- [1]
				{
					["class"] = "buff",
					["buff"] = 79062,
				}, -- [2]
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
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
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
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
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
					["name"] = "np",
					["classColor"] = 1,
					["h"] = 18,
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
						["GfxReverse"] = true,
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
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
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
					["filterNameList"] = {
					},
					["size"] = 16,
					["version"] = 1,
					["name"] = "kinga",
					["orientation"] = "RIGHT",
					["maxdurationfilter"] = "",
					["filterName"] = 1,
					["unitfilter"] = "",
				}, -- [11]
				{
					["w"] = "16",
					["feature"] = "hotspot",
					["secure"] = 1,
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
					["flo"] = 3,
					["h"] = "16",
					["name"] = "kings",
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
						["GfxReverse"] = true,
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
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 0,
						["TextType"] = "Seconds",
						["HideText"] = 0,
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
					["filterNameList"] = {
					},
					["size"] = 16,
					["version"] = 1,
					["name"] = "mighta",
					["orientation"] = "RIGHT",
					["maxdurationfilter"] = "",
					["filterName"] = 1,
					["unitfilter"] = "",
				}, -- [13]
				{
					["w"] = "16",
					["feature"] = "hotspot",
					["secure"] = 1,
					["version"] = 1,
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
					["flo"] = 3,
					["h"] = "16",
					["name"] = "might",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["vertexColor"] = {
							["a"] = 0,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [16]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "unitnotInRange30",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Range_not_0_30_dead_fset",
					},
				}, -- [17]
				{
					["color"] = {
						["a"] = 0.8039999902248383,
						["r"] = 0.5882352941176472,
						["g"] = 0.04705882352941176,
						["b"] = 0,
					},
					["name"] = "red",
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
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "range",
					["colorVar1"] = "red",
					["colorVar2"] = "alpha",
					["condVar"] = "unitnotInRange30_flag",
				}, -- [20]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "true",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [21]
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
						["sr"] = 0,
						["sa"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 1,
						["flags"] = "THICKOUTLINE",
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["size"] = 14,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["cr"] = 1,
							["sr"] = 0,
							["sb"] = 0,
							["sa"] = 1,
							["cb"] = 0.1333333333333333,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["justifyH"] = "CENTER",
							["ca"] = 1,
							["sg"] = 0,
							["title"] = "Default",
							["sx"] = 1,
							["cg"] = 0.7372549019607844,
							["name"] = "Default",
							["sy"] = -1,
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -20,
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.1,
						["TextType"] = "Largest",
						["HideText"] = 0,
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
					["bkd"] = {
						["ka"] = 1,
						["edgeSize"] = 12,
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "IshBorder",
						["kg"] = 0.1,
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "LEFT",
					["usebs"] = true,
					["smooth"] = 1,
					["unitfilter"] = "",
				}, -- [2]
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
					["set"] = {
						["file"] = "WoWRDX:Raid_GroupAll_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["bkt"] = 1,
					["dxn"] = 2,
					["cols"] = 5,
					["feature"] = "Header Grid",
					["axis"] = 2,
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
		["infoAuthorWebSite"] = "http://www.wowrdx.com",
		["Range_15_30_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "frs",
						["n"] = 3,
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "file",
							["file"] = "WoWRDX:Range_0_15_fset",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
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
					["set"] = {
						["file"] = "default:set_raid_group2",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 100,
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.8627450980392157,
						["b"] = 0.0196078431372549,
					},
					["name"] = "yellow",
					["feature"] = "ColorVariable: Static Color",
				}, -- [3]
				{
					["feature"] = "base_default",
					["h"] = 20,
					["version"] = 1,
					["hlt"] = 1,
					["ph"] = 1,
					["alpha"] = 1,
					["w"] = 100,
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
					["drawLayer"] = "ARTWORK",
					["version"] = 1,
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
					["owner"] = "decor",
					["w"] = 40,
					["feature"] = "txt_custom",
					["h"] = 20,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["name"] = "customText",
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
						["justifyH"] = "LEFT",
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
					["defaultTL"] = 1,
					["text"] = "customText",
					["TEIExpireState"] = "Default",
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
					["TL"] = 20,
					["version"] = 1,
					["txt"] = "",
					["tex"] = "auraia_icon",
					["countTypeFlag"] = "false",
					["timerVar"] = "auraia_aura",
					["texIcon"] = "tex1",
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
		["Range_40_70_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "frs",
						["n"] = 4,
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "file",
							["file"] = "WoWRDX:Range_0_40_fset",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
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
							["buff"] = 11390,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 11406,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 17538,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 17539,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28490,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [6]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28491,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [7]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28493,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [8]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28497,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [9]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28501,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [10]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28503,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [11]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 33720,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [12]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 33721,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [13]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 33726,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [14]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 38954,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [15]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 45373,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [16]
			},
		},
		["Healer_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.5372549019607842,
					["g"] = 0,
					["r"] = 0.6352941176470583,
				},
				["name"] = "Healer",
				["sv"] = 1,
				["color"] = {
					["a"] = 1,
					["b"] = 0.7607843137254902,
					["g"] = 0.2980392156862746,
					["r"] = 0,
				},
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Healer_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["pct"] = 1,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Healer_fset",
						["class"] = "file",
					},
					["qty"] = "smp",
				},
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
					["name"] = "texcd_earth",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 9,
					["anchor"] = {
						["dx"] = 36,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_serenity",
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
					["h"] = 36,
					["name"] = "earth",
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
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [5]
				{
					["name"] = "texcd_Fire",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 9,
					["anchor"] = {
						["dx"] = 72,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_serenity",
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
						["dx"] = 72,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [7]
				{
					["name"] = "texcd_water",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 9,
					["anchor"] = {
						["dx"] = 36,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_serenity",
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
						["dx"] = 36,
						["dy"] = -72,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [9]
				{
					["name"] = "texcd_air",
					["gt"] = "",
					["version"] = 1,
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
					["ButtonSkinOffset"] = 9,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_serenity",
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
					["h"] = 36,
					["name"] = "air",
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
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
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
						["dx"] = 36,
						["dy"] = -36,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
				}, -- [13]
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
						["b"] = 0,
						["g"] = 0.7764705882352941,
						["r"] = 0.788235294117647,
					},
				}, -- [3]
				{
					["feature"] = "ColorVariable: Static Color",
					["name"] = "green",
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.7568627450980392,
						["r"] = 0.3254901960784314,
					},
				}, -- [4]
				{
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "barColor",
					["colorVar1"] = "yellow",
					["colorVar2"] = "green",
					["condVar"] = "spell_channeled",
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
						["_border"] = "HalStraight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kb"] = 0,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["ka"] = 0.4239999651908875,
						["edgeSize"] = 8,
						["bg"] = 0,
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
					["name"] = "castBar",
					["orientation"] = "HORIZONTAL",
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
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 0.718999981880188,
							["b"] = 0,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [11]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "50",
					["feature"] = "txt_custom",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_subframe",
					},
					["name"] = "spellTimer",
					["h"] = "14",
				}, -- [12]
				{
					["script"] = "",
					["owner"] = "subframe",
					["w"] = "150",
					["feature"] = "txt_custom",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 25,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_subframe",
					},
					["h"] = "14",
					["name"] = "spellname",
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
					["sublevel"] = 1,
					["drawLayer"] = "OVERLAY",
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
					["countTypeFlag"] = "spell_casting",
					["tex"] = "spell_icon",
					["txt"] = "spell_name_rank",
					["timerVar"] = "spell",
					["texIcon"] = "spellIcon",
				}, -- [15]
				{
					["frac"] = "spell_fraclag",
					["flOffset"] = 0,
					["owner"] = "subframe",
					["w"] = "180",
					["color1"] = {
						["a"] = 0.4695078730583191,
						["b"] = 0,
						["g"] = 0.2784313725490196,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["version"] = 1,
					["color2"] = {
						["a"] = 0.4695078730583191,
						["b"] = 0,
						["g"] = 0.2784313725490196,
						["r"] = 1,
					},
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_subframe",
					},
					["name"] = "lagBar",
					["orientation"] = "HORIZONTAL",
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Frame_subframe",
					},
					["h"] = "14",
					["name"] = "infoText",
				}, -- [17]
				{
					["feature"] = "shader_showhide",
					["owner"] = "subframe",
					["version"] = 1,
					["flag"] = "spell_castingOrChanneled",
				}, -- [18]
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
					["h"] = "20",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["line"] = 15,
					["spec"] = "{ title = \"Time\", width = 55, font = Fonts.Default },\n{ title = \"HP\", width = 50, font = Fonts.Default },\n{ title = \"Amt\", width = 50, font = Fonts.Default },\n{ title = \"Ability\", width = 180, font = Fonts.Default },\n{ title = \"Misc\", width = 55, font = Fonts.Default },\n\n\n\n",
					["name"] = "combatlogs",
				}, -- [2]
			},
		},
		["Priest_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.5372549019607842,
					["g"] = 0,
					["r"] = 0.6352941176470583,
				},
				["name"] = "Priest",
				["sv"] = 2,
				["color"] = {
					["a"] = 1,
					["b"] = 0.5254901960784313,
					["g"] = 0.5254901960784313,
					["r"] = 0.5254901960784313,
				},
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Priest_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["pct"] = 1,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Priest_fset",
						["class"] = "file",
					},
					["qty"] = "smp",
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
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Shadow_UnsummonBuilding",
					},
					["titleColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.3647058823529412,
						["r"] = 0.2941176470588235,
					},
					["defaultbuttons"] = 1,
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Priest_Buff_VampiricEmbrace_ds",
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
						["_border"] = "straight",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["ka"] = 0.7119999825954437,
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_backdrop"] = "solid",
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
					["h"] = "21",
					["owner"] = "sf_plife",
					["w"] = "200",
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["colorVar"] = "green",
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
					["colorVar"] = "hostilityclassColor",
					["sublevel"] = 2,
					["owner"] = "sf_life",
					["w"] = "200",
					["drawLayer"] = "ARTWORK",
					["feature"] = "statusbar_horiz",
					["h"] = "21",
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
					["h"] = "14",
					["name"] = "text_pheal",
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
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
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 12,
					},
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["name"] = "Default",
						["title"] = "Default",
						["sy"] = -1,
						["size"] = 10,
					},
					["ty"] = "hptxt2",
					["version"] = 1,
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "fdld",
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
						["sr"] = 0,
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
						["size"] = 12,
					},
					["h"] = "14",
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["ty"] = "mobtype",
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
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 12,
					},
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
						["ka"] = 0.7119999825954437,
						["kg"] = 0,
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["_border"] = "straight",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_backdrop"] = "solid",
						["edgeSize"] = 8,
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
					["feature"] = "ColorVariable: Unit PowerType Color",
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
						["justifyH"] = "LEFT",
						["sb"] = 0,
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
						["bb"] = 1,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["bg"] = 1,
						["_backdrop"] = "none",
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
					["ty"] = "level",
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
						["size"] = 15,
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
					["h"] = "30",
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
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
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
						["offsety"] = "0",
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
						["Offsety"] = 0,
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
					["name"] = "debuff",
					["version"] = 1,
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
					["h"] = 76,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "",
					["flo"] = 3,
					["secure"] = 1,
				}, -- [38]
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
					["version"] = 1,
					["clickable"] = 1,
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
						["b"] = 1,
						["g"] = 0.4705882352941176,
						["r"] = 0.5137254901960784,
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
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["size"] = 10,
					},
					["name"] = "cf1",
				}, -- [2]
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
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["showtitlebar"] = true,
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
					["design"] = "WoWRDX:Paladin_Buff_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Paladin_Buff_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["bkt"] = 1,
					["dxn"] = 1,
					["cols"] = 40,
					["feature"] = "Header Grid",
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mp_args",
					["period"] = 0.2,
					["dpm1"] = 0,
					["version"] = 1,
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
						["r"] = 1,
						["g"] = 0.3098039215686275,
						["b"] = 0.2862745098039216,
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
					["colorVar"] = "red",
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
					["frac"] = "fcombatmeter1",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Ruben",
					},
				}, -- [5]
				{
					["owner"] = "pdt",
					["w"] = "60",
					["classColor"] = 1,
					["h"] = "12",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["feature"] = "txt_np",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["sx"] = 1,
						["sr"] = 0,
					},
				}, -- [6]
				{
					["txt"] = "combatmeter1_text",
					["owner"] = "pdt",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = -1,
						["name"] = "Default",
						["size"] = 10,
					},
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_pdt",
					},
					["version"] = 1,
					["h"] = "12",
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
					["nIcons"] = 6,
					["owner"] = "decor",
					["rows"] = 1,
					["name"] = "rune_bar",
					["feature"] = "runes_bar",
					["iconspx"] = 0,
					["version"] = 1,
					["orientation"] = "RIGHT",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
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
					["iconspy"] = 0,
					["size"] = 36,
				}, -- [2]
			},
		},
		["Raid_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"nidmask", -- [1]
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
					["cdFont"] = {
						["size"] = 10,
						["sy"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "CENTER",
						["cb"] = 0.08235294117647057,
						["flags"] = "OUTLINE",
						["cr"] = 1,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["cdHideTxt"] = "0",
					["name"] = "rune1_tc",
					["cdoffx"] = 0,
					["tex"] = "rune1_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune1",
					["version"] = 1,
				}, -- [4]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["name"] = "Default",
						["cb"] = 0.08235294117647057,
						["justifyH"] = "CENTER",
						["title"] = "Default",
						["ca"] = 1,
						["cr"] = 1,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["cdHideTxt"] = "0",
					["name"] = "rune2_tc",
					["cdoffx"] = 0,
					["tex"] = "rune2_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune2",
					["version"] = 1,
				}, -- [5]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["title"] = "Default",
						["cb"] = 0.08235294117647057,
						["justifyH"] = "CENTER",
						["name"] = "Default",
						["ca"] = 1,
						["cr"] = 1,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["cdHideTxt"] = "0",
					["name"] = "rune3_tc",
					["cdoffx"] = 0,
					["tex"] = "rune3_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune3",
					["version"] = 1,
				}, -- [6]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["justifyH"] = "CENTER",
						["cb"] = 0.08235294117647057,
						["name"] = "Default",
						["title"] = "Default",
						["flags"] = "OUTLINE",
						["cr"] = 1,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["cdHideTxt"] = "0",
					["name"] = "rune4_tc",
					["cdoffx"] = 0,
					["tex"] = "rune4_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune4",
					["version"] = 1,
				}, -- [7]
				{
					["cdFont"] = {
						["size"] = 10,
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["sy"] = 0,
						["sx"] = 0,
						["title"] = "Default",
						["cb"] = 0.08235294117647057,
						["ca"] = 1,
						["cr"] = 1,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["cdHideTxt"] = "0",
					["name"] = "rune5_tc",
					["cdoffx"] = 0,
					["tex"] = "rune5_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune5",
					["version"] = 1,
				}, -- [8]
				{
					["cdFont"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["justifyH"] = "CENTER",
						["cb"] = 0.08235294117647057,
						["title"] = "Default",
						["name"] = "Default",
						["flags"] = "OUTLINE",
						["cr"] = 1,
					},
					["cdTimerType"] = "COOLDOWN&TEXT",
					["cdoffy"] = -22,
					["feature"] = "texture_cooldown",
					["h"] = 36,
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["cdTxtType"] = "Largest",
					["owner"] = "decor",
					["w"] = 36,
					["cdHideTxt"] = "0",
					["name"] = "rune6_tc",
					["cdoffx"] = 0,
					["tex"] = "rune6_icon",
					["dyntexture"] = 1,
					["timerVar"] = "rune6",
					["version"] = 1,
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
					["switchvehicle"] = 1,
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
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
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
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
					["set"] = {
						["file"] = "WoWRDX:Range_0_10_ODM_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
					["set"] = {
						["file"] = "default:set_raid_group6",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
		["Mage_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Mage_fset",
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
				["name"] = "Mage",
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Mage_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 0.3333333333333333,
					["r"] = 0,
				},
				["texture"] = "",
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
					["class"] = "file",
					["file"] = "WoWRDX:Heal_Done_fset",
				},
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
					["version"] = 1,
					["switchvehicle"] = 1,
					["unit"] = "player",
				}, -- [3]
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
		["Damage_Done"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Ability_BackStab",
					},
					["title"] = "Damage Done",
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
					["feature"] = "Frame: Lightweight",
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
					["cols"] = 1,
					["axis"] = 1,
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
					["feature"] = "ColorVariable: Unit PowerType Color",
					["runeColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.75,
						["r"] = 0,
					},
					["manaColor"] = {
						["a"] = 1,
						["b"] = 0.75,
						["g"] = 0,
						["r"] = 0,
					},
				}, -- [4]
				{
					["feature"] = "commentline",
				}, -- [5]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["ph"] = 1,
					["alpha"] = 1,
					["w"] = 90,
				}, -- [6]
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
					["h"] = "11",
					["name"] = "hpbar",
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
				}, -- [7]
				{
					["frac"] = "1",
					["owner"] = "Base",
					["w"] = "90",
					["h"] = "3",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "powerColor",
					["version"] = 1,
					["interpolate"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
					["name"] = "ppbar",
					["orientation"] = "HORIZONTAL",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
					},
				}, -- [8]
				{
					["owner"] = "Base",
					["w"] = "50",
					["classColor"] = 1,
					["h"] = "14",
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["feature"] = "txt_np",
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
				}, -- [9]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["font"] = {
						["size"] = 8,
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
					["ty"] = "hpp",
					["name"] = "text_hp_percent",
				}, -- [10]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["font"] = {
						["size"] = 8,
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
					["ty"] = "fdld",
					["name"] = "status_text",
				}, -- [11]
			},
		},
		["Raid_GroupAll"] = {
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
					["title"] = "Raid Group All",
					["bkd"] = {
						["_backdrop"] = "none",
						["_border"] = "none",
					},
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["defaultbuttons"] = 1,
					["feature"] = "Frame: Lightweight",
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "WoWRDX:Raid_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Raid_GroupAll_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
				}, -- [3]
				{
					["bkt"] = 1,
					["switchvehicle"] = 1,
					["dxn"] = 1,
					["axis"] = 1,
					["feature"] = "Header Grid",
					["cols"] = 20,
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
					["name"] = "TotemEarthBar",
					["orientation"] = "HORIZONTAL",
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
					["drawLayer"] = "OVERLAY",
					["name"] = "TotemEarthIcon",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
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
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["h"] = 14,
					["name"] = "EarthTimer",
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemearth_icon",
					["txt"] = "",
					["timerVar"] = "totemearth",
					["texIcon"] = "TotemEarthIcon",
				}, -- [11]
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
					["name"] = "status_text_earth",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemEarthBar",
					},
					["h"] = 14,
					["version"] = 1,
				}, -- [12]
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
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["secure"] = 1,
					["flo"] = 3,
					["name"] = "earth",
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
					["name"] = "TotemFireBar",
					["orientation"] = "HORIZONTAL",
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
					["drawLayer"] = "OVERLAY",
					["name"] = "TotemFireIcon",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [16]
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
						["af"] = "TotemFireBar",
					},
					["name"] = "FireTimer",
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
						["size"] = 9,
					},
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemfire_icon",
					["txt"] = "",
					["timerVar"] = "totemfire",
					["texIcon"] = "TotemFireIcon",
				}, -- [18]
				{
					["txt"] = "totemfire_name",
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
						["af"] = "TotemFireBar",
					},
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["name"] = "status_text_firea",
				}, -- [19]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["secure"] = 1,
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
					["version"] = 1,
					["h"] = 20,
					["flo"] = 3,
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
					["name"] = "TotemWaterBar",
					["orientation"] = "HORIZONTAL",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemWaterBar",
					},
					["name"] = "WaterTimer",
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
						["size"] = 9,
					},
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemwater_icon",
					["txt"] = "",
					["timerVar"] = "totemwater",
					["texIcon"] = "TotemWaterIcon",
				}, -- [25]
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
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
					["name"] = "status_text_water",
				}, -- [26]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["secure"] = 1,
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
					["version"] = 1,
					["h"] = 20,
					["flo"] = 3,
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
					["name"] = "TotemAirBar",
					["orientation"] = "HORIZONTAL",
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
					["drawLayer"] = "OVERLAY",
					["name"] = "TotemAirIcon",
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [30]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
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
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemAirBar",
					},
					["name"] = "AirTimer",
					["h"] = 14,
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
					["TEIExpireState"] = "Hide",
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
					["countTypeFlag"] = "false",
					["tex"] = "totemair_icon",
					["txt"] = "",
					["timerVar"] = "totemair",
					["texIcon"] = "TotemAirIcon",
				}, -- [32]
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
					["version"] = 1,
					["font"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 9,
					},
				}, -- [33]
				{
					["w"] = 180,
					["feature"] = "hotspot",
					["secure"] = 1,
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
					["h"] = 20,
					["flo"] = 3,
					["version"] = 1,
				}, -- [34]
				{
					["feature"] = "commentline",
				}, -- [35]
				{
					["w"] = 20,
					["feature"] = "hotspot",
					["secure"] = 1,
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
					["h"] = 80,
					["flo"] = 3,
					["version"] = 1,
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
					["class"] = "file",
					["file"] = "WoWRDX:Damage_Done_fset",
				},
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
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
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
					["set"] = {
						["file"] = "WoWRDX:Range_0_15_ODM_fset",
						["class"] = "file",
					},
					["rostertype"] = "RAID",
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
		["Healer_Health_stc"] = {
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
				["name"] = "Healer HP",
				["color"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["pct"] = 1,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Healer_fset",
						["class"] = "file",
					},
					["qty"] = "smaxhp",
				},
				["sv"] = 1,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Healer_fset",
						["class"] = "file",
					},
					["qty"] = "shp",
				},
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0.2,
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
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["owner"] = "decor",
					["nIcons"] = 6,
					["deathColor"] = {
						["a"] = 1,
						["r"] = 0.6000000000000001,
						["g"] = 0.3,
						["b"] = 0.6000000000000001,
					},
					["name"] = "rune_bar_skin",
					["sizeh"] = 20,
					["orientation"] = "RIGHT",
					["frostColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.6000000000000001,
						["b"] = 1,
					},
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
					["version"] = 1,
				}, -- [2]
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
					["version"] = 1,
					["clickable"] = 1,
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
		["Priest_Buff_Shadow_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["buff"] = 79107,
						["class"] = "buff",
					}, -- [2]
				}, -- [2]
			},
		},
		["Raid_desk"] = {
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
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "TOPRIGHT",
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar1",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 17.06666731335399,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar3",
					["r"] = 1348.266710285255,
					["anchor"] = "TOPLEFT",
					["l"] = 1317.546600063446,
					["b"] = 199.680014288981,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar4",
					["r"] = 1317.546600063446,
					["anchor"] = "TOPLEFT",
					["l"] = 1286.826609357003,
					["b"] = 199.680014288981,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar5",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 47.78666548950701,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["r"] = 866.9866965304984,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 78.50667113537041,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["r"] = 805.54665535993,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 109.2266693115234,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarStance",
					["r"] = 805.54665535993,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 139.9466674876765,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarVehicle",
					["r"] = 897.7066274792579,
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 139.9466674876765,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["r"] = 358.4000210501441,
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 102.4000113498343,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["r"] = 358.4000210501441,
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
					["r"] = 358.4000210501441,
					["anchor"] = "TOPLEFT",
					["l"] = 187.7333479166043,
					["open"] = true,
					["b"] = 128.0000160547205,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureBuff_Icon",
					["r"] = 1365.333385068319,
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 725.3333197341373,
					["open"] = true,
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
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["r"] = 341.3333462670797,
					["anchor"] = "TOPLEFT",
					["l"] = 0,
					["b"] = 721.0666211595296,
					["open"] = true,
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
					["t"] = 402.8929924404083,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["r"] = 464.2133688505334,
					["anchor"] = "TOPLEFT",
					["l"] = 288.4267022457266,
					["b"] = 338.0396521678369,
					["open"] = true,
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
					["t"] = 242.4662913099814,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["r"] = 722.7733603470558,
					["anchor"] = "TOPLEFT",
					["l"] = 546.9866937422491,
					["b"] = 220.2796081162294,
					["open"] = true,
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["r"] = 464.2133688505334,
					["scale"] = 1,
					["t"] = 329.5063147763047,
					["alpha"] = 1,
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
					["l"] = 288.4267022457266,
					["b"] = 264.6529745037333,
					["open"] = true,
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
					["t"] = 455.7996364617614,
					["dgp"] = true,
					["feature"] = "desktop_window",
					["r"] = 805.54665535993,
					["name"] = "WoWRDX:Panel_Center",
					["b"] = 285.1329483888007,
					["anchor"] = "TOPLEFT",
					["l"] = 464.2133688505334,
					["alpha"] = 1,
					["open"] = true,
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
					["t"] = 402.8929924404083,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Target_Main",
					["r"] = 981.3333219647368,
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 338.0396521678369,
					["open"] = true,
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
					["t"] = 402.8929924404083,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["r"] = 1165.653206445709,
					["anchor"] = "TOPLEFT",
					["l"] = 989.8665995985858,
					["b"] = 338.0396521678369,
					["open"] = true,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["r"] = 1348.266710285255,
					["scale"] = 1,
					["t"] = 145.0666609589433,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Combat_Logs",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1015.466611773182,
					["b"] = 17.06666731335399,
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "root",
							["x"] = -20,
							["point"] = "BOTTOMRIGHT",
							["y"] = 20,
						},
					},
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
		["Dead_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["r"] = 0.4705882352941178,
					["g"] = 0,
					["b"] = 0.01176470588235294,
				},
				["name"] = "Dead",
				["texture"] = "",
				["max"] = {
					["qty"] = "ssz",
					["set"] = {
						["class"] = "group",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["sv"] = 3,
				["val"] = {
					["qty"] = "ssz",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Dead_fset",
					},
				},
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
						["file"] = "WoWRDX:Debuff_Primary_fset",
						["class"] = "file",
					},
				}, -- [1]
				{
					["feature"] = "Variable: Unit In Set",
					["name"] = "shifted",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Debuff_Secondary_fset",
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
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
						["b"] = 0.03529411764705882,
						["g"] = 1,
						["r"] = 0,
					},
					["name"] = "shTrue",
					["feature"] = "ColorVariable: Static Color",
				}, -- [7]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["name"] = "shFalse",
					["feature"] = "ColorVariable: Static Color",
				}, -- [8]
				{
					["condVar"] = "shifted_flag",
					["name"] = "shColor",
					["colorVar1"] = "shTrue",
					["feature"] = "ColorVariable: Conditional Color",
					["colorVar2"] = "shFalse",
				}, -- [9]
				{
					["feature"] = "commentline",
				}, -- [10]
				{
					["ph"] = 1,
					["h"] = 30,
					["version"] = 1,
					["feature"] = "base_default",
					["w"] = 30,
					["alpha"] = 1,
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
					["sublevel"] = 1,
					["drawLayer"] = "ARTWORK",
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
					["color"] = "shColor",
					["flag"] = "true",
				}, -- [15]
				{
					["script"] = "WoWRDX:Dispell_Grid_Shiftcode_sc",
					["owner"] = "decor",
					["w"] = "20",
					["feature"] = "txt_custom",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -2,
						["lp"] = "TOP",
						["rp"] = "TOP",
						["af"] = "Base",
					},
					["name"] = "shiftText",
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 6,
					},
				}, -- [16]
				{
					["falseAlpha"] = 0.3,
					["version"] = 1,
					["flag"] = "range_flag",
					["owner"] = "decor",
					["feature"] = "shader_ca",
					["trueAlpha"] = 1,
				}, -- [17]
				{
					["owner"] = "decor",
					["w"] = "20",
					["classColor"] = 1,
					["h"] = "14",
					["version"] = 1,
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 2,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["trunc"] = 3,
					["feature"] = "txt_np",
					["name"] = "np",
				}, -- [18]
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
							["class"] = "buff",
							["buff"] = 27827,
						}, -- [2]
					}, -- [2]
				}, -- [4]
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
						["size"] = 10,
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["flags"] = "OUTLINE",
						["sr"] = 0,
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
						["kg"] = 1,
						["kb"] = 0.9450980392156863,
						["kr"] = 0.7490196078431373,
					},
					["anchor"] = {
						["dx"] = 15,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["iconposition"] = "LEFT",
					["iconspy"] = 1,
					["smooth"] = 1,
					["nIcons"] = 10,
					["abr"] = 1,
					["mindurationfilter"] = 0,
					["sbfont"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\airstrip.ttf",
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
					["h"] = "14",
					["owner"] = "Base",
					["w"] = "90",
					["auraType"] = "DEBUFFS",
					["version"] = 2,
					["countTypeFlag"] = "false",
					["name"] = "ab1",
					["sbtimerfont"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\airstrip.ttf",
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
					["orientation"] = "DOWN",
					["sbtexture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
					["maxdurationfilter"] = 3000,
					["unitfilter"] = "",
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
						["class"] = "file",
						["file"] = "WoWRDX:Dispell_Grid_Data_fset",
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
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
					["axis"] = 1,
					["autoShowHide"] = 1,
					["cols"] = 3,
				}, -- [5]
			},
		},
		["Party_desk"] = {
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
					["r"] = 1365.333385068319,
					["root"] = true,
					["t"] = 768.0000066917983,
					["anchorx"] = 1248.7467033076,
					["alpha"] = 1,
					["name"] = "root",
					["offsetright"] = "0",
					["title"] = "Konyagi_AUI:desk_solo",
					["open"] = true,
					["dock"] = {
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
						["TOPLEFT"] = {
							["id"] = "WoWRDX:Player_Main",
							["x"] = -10,
							["point"] = "TOPLEFT",
							["y"] = 10,
						},
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 0,
							["point"] = "LEFT",
							["y"] = 0,
						},
					},
					["strata"] = "BACKGROUND",
					["anchory"] = 18.239958923888,
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
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 17.06666731335399,
					["r"] = 866.9866965304984,
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
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1317.546600063446,
					["b"] = 199.680014288981,
					["r"] = 1348.266710285255,
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
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1286.826609357003,
					["b"] = 199.680014288981,
					["r"] = 1317.546600063446,
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
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 47.78666548950701,
					["r"] = 866.9866965304984,
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
					["scale"] = 1,
					["t"] = 109.2266693115234,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBar6",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 78.50667113537041,
					["r"] = 866.9866965304984,
				}, -- [6]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 139.9466674876765,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ActionBarPet",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 109.2266693115234,
					["r"] = 805.54665535993,
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
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 139.9466674876765,
					["r"] = 805.54665535993,
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
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 805.54665535993,
					["b"] = 139.9466674876765,
					["r"] = 897.7066274792579,
				}, -- [9]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 128.0000160547205,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatEditBox1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 102.4000113498343,
					["r"] = 358.4000210501441,
				}, -- [10]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 102.4000113498343,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:ChatFrame1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 17.06666731335399,
					["b"] = 17.06666731335399,
					["r"] = 358.4000210501441,
				}, -- [11]
				{
					["strata"] = "MEDIUM",
					["b"] = 128.0000160547205,
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
					["r"] = 358.4000210501441,
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
						["BOTTOMRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureDebuff_Icon",
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
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 725.3333197341373,
					["r"] = 1365.333385068319,
				}, -- [13]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOPRIGHT"] = {
							["id"] = "WoWRDX:Player_SecureBuff_Icon",
							["x"] = 0,
							["point"] = "BOTTOMRIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 725.3333197341373,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_SecureDebuff_Icon",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 1024.000008922398,
					["b"] = 678.3999939595518,
					["r"] = 1365.333385068319,
				}, -- [14]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 8.533333656676994,
					["b"] = 694.6133290276947,
					["r"] = 184.3200039963389,
				}, -- [15]
				{
					["strata"] = "MEDIUM",
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
					["scale"] = 1,
					["t"] = 216.7466741326246,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Player_CastBar",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 594.7733592317561,
					["b"] = 194.5600058782934,
					["r"] = 770.5600258365629,
				}, -- [16]
				{
					["strata"] = "MEDIUM",
					["r"] = 184.3200039963389,
					["scale"] = 1,
					["t"] = 686.0799916361625,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pet_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 8.533339258959785,
					["b"] = 621.2266513635912,
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
				}, -- [17]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Pet_Main",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 686.0799916361625,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Pettarget_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 192.8533413878711,
					["b"] = 621.2266513635912,
					["r"] = 368.6400079926778,
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
					["scale"] = 1,
					["t"] = 759.4666693002661,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Target_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 192.8533413878711,
					["b"] = 694.6133290276947,
					["r"] = 368.6400079926778,
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
					["t"] = 759.4666693002661,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Targettarget_Main",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 377.17334538421,
					["b"] = 694.6133290276947,
					["r"] = 552.9600119890167,
				}, -- [21]
				{
					["strata"] = "MEDIUM",
					["r"] = 175.8720155157196,
					["scale"] = 1,
					["t"] = 416.4693105890893,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Party",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 0,
					["b"] = 351.5306363450258,
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
				}, -- [22]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 10,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 416.4266436033432,
					["alpha"] = 1,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:PartyTarget",
					["open"] = true,
					["anchor"] = "TOPLEFT",
					["l"] = 184.4053529072519,
					["b"] = 351.5733033307719,
					["r"] = 360.1920045726378,
				}, -- [23]
				{
					["strata"] = "MEDIUM",
					["r"] = 351.6586671811056,
					["scale"] = 1,
					["t"] = 416.4266436033432,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Partytarget",
					["dock"] = {
						["LEFT"] = {
							["id"] = "WoWRDX:Party",
							["x"] = 0,
							["point"] = "RIGHT",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 175.8720155157196,
					["b"] = 351.5733033307719,
					["alpha"] = 1,
				}, -- [24]
				{
					["strata"] = "MEDIUM",
					["r"] = 1348.266710285255,
					["scale"] = 1,
					["t"] = 145.0666908377849,
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
				}, -- [25]
				{
					["strata"] = "MEDIUM",
					["r"] = 810.6667534071423,
					["scale"] = 1,
					["t"] = 242.3466713678004,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "WoWRDX:Cooldowns_Used",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "WoWRDX:Player_CastBar",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["anchor"] = "TOPLEFT",
					["l"] = 554.6666914188597,
					["b"] = 216.7466741326246,
					["alpha"] = 1,
				}, -- [26]
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
							["buff"] = 11348,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 11396,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 24363,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28502,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [5]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28509,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [6]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 28514,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [7]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 39625,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [8]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 39626,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [9]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 39627,
							["class"] = "buff",
						}, -- [2]
					}, -- [2]
				}, -- [10]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["buff"] = 39628,
							["class"] = "buff",
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
							["class"] = "file",
							["file"] = "WoWRDX:Range_0_15_fset",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["class"] = "file",
							["file"] = "WoWRDX:Range_15_30_fset",
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
						["r"] = 1,
						["g"] = 0,
						["b"] = 0.2,
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
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["owner"] = "decor",
					["nIcons"] = 6,
					["deathColor"] = {
						["a"] = 1,
						["r"] = 0.6000000000000001,
						["g"] = 0.3,
						["b"] = 0.6000000000000001,
					},
					["name"] = "rune_bar_skin",
					["sizeh"] = 36,
					["orientation"] = "RIGHT",
					["frostColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.6000000000000001,
						["b"] = 1,
					},
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
					["version"] = 1,
				}, -- [2]
			},
		},
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
						["class"] = "frs",
						["n"] = 2,
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
		["Mage_Buff_Arcane_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"or", -- [1]
				{
					"set", -- [1]
					{
						["buff"] = 1459,
						["class"] = "buff",
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["buff"] = 23028,
						["class"] = "buff",
					}, -- [2]
				}, -- [3]
				{
					"set", -- [1]
					{
						["buff"] = 61024,
						["class"] = "buff",
					}, -- [2]
				}, -- [4]
				{
					"set", -- [1]
					{
						["buff"] = 61316,
						["class"] = "buff",
					}, -- [2]
				}, -- [5]
			},
		},
		["Tank_health_stc"] = {
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
				["name"] = "Tank HP",
				["color"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["pct"] = 1,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Tank_fset",
						["class"] = "file",
					},
					["qty"] = "smaxhp",
				},
				["sv"] = 1,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Tank_fset",
						["class"] = "file",
					},
					["qty"] = "shp",
				},
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
		["Paladin_Buff_Might_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"set", -- [1]
				{
					["class"] = "buff",
					["buff"] = 19740,
				}, -- [2]
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
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
					["axis"] = 1,
					["cols"] = 1,
					["dxn"] = 1,
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
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
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
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["usebs"] = true,
					["fontmacro"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["title"] = "Default",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["owner"] = "decor",
					["size"] = 36,
					["headerstateCustom"] = "",
					["headerstateType"] = "None",
					["abid"] = 25,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "DOWN",
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
					["anyup"] = 1,
					["hidebs"] = 1,
				}, -- [2]
			},
		},
		["Hunter_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Hunter_fset",
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
				["name"] = "Hunter",
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Hunter_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0.1019607843137255,
					["g"] = 0.5450980392156861,
					["r"] = 0,
				},
				["texture"] = "",
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
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
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
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["usebs"] = true,
					["fontmacro"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["title"] = "Default",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["owner"] = "decor",
					["size"] = 36,
					["headerstateCustom"] = "",
					["headerstateType"] = "None",
					["abid"] = 37,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "DOWN",
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
					["anyup"] = 1,
					["hidebs"] = 1,
				}, -- [2]
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
					["version"] = 1,
					["clickable"] = 1,
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
							["class"] = "file",
							["file"] = "WoWRDX:Range_0_10_fset",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
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
						["TimerType"] = "COOLDOWN",
						["Offsety"] = 0,
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
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["usebs"] = true,
					["fontmacro"] = {
						["cr"] = 1,
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["title"] = "Default",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["owner"] = "decor",
					["size"] = 36,
					["headerstateCustom"] = "",
					["headerstateType"] = "None",
					["abid"] = 49,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "RIGHT",
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
					["anyup"] = 1,
					["hidebs"] = 1,
				}, -- [2]
			},
		},
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
						["GfxReverse"] = true,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["cr"] = 1,
							["flags"] = "THICKOUTLINE",
							["cg"] = 0.807843137254902,
							["title"] = "Default",
							["cb"] = 0.02745098039215686,
							["ca"] = 1,
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -25,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 3,
						["TextType"] = "Largest",
						["HideText"] = 0,
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
					["name"] = "sai1",
					["orientation"] = "LEFT",
					["xoffset"] = 0,
					["maxwraps"] = 2,
					["yoffset"] = 0,
				}, -- [2]
			},
		},
		["Range_40plus_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["name"] = "Away",
				["texture"] = "",
				["max"] = {
					["set"] = {
						["class"] = "group",
					},
					["qty"] = "ssz",
				},
				["color"] = {
					["a"] = 1,
					["b"] = 0.01176470588235294,
					["g"] = 0,
					["r"] = 0.4705882352941178,
				},
				["sv"] = 3,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Range_40plus_fset",
						["class"] = "file",
					},
					["qty"] = "ssz",
				},
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
							["class"] = "frs",
							["n"] = 3,
						}, -- [2]
					}, -- [2]
				}, -- [3]
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
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["name"] = "alpha",
					["feature"] = "ColorVariable: Static Color",
				}, -- [2]
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
					["orientation"] = "HORIZONTAL",
					["name"] = "rune1_bar",
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
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
						["size"] = 9,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "RIGHT",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
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
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sb"] = 0,
						["sx"] = 1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 9,
					},
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
					["statusBar"] = "rune1_bar",
					["txt"] = "rune1_name",
					["TEIExpireState"] = "Hide",
					["text"] = "rune1_timer",
					["tex"] = "rune1_icon",
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
					["TL"] = 0,
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "rune2_bar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [16]
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
						["af"] = "rune2_bar",
					},
					["name"] = "rune2_timer",
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
				}, -- [17]
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
						["justifyH"] = "LEFT",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune2_bar",
					},
					["name"] = "rune2_text",
					["h"] = 14,
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
					["txt"] = "rune2_name",
					["texIcon"] = "rune2_tex",
					["TEIExpireState"] = "Hide",
					["text"] = "rune2_timer",
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
					["tex"] = "rune2_icon",
					["countTypeFlag"] = "true",
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "rune3_bar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [24]
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
						["af"] = "rune3_bar",
					},
					["name"] = "rune3_timer",
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
				}, -- [25]
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
						["justifyH"] = "LEFT",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune3_bar",
					},
					["name"] = "rune3_text",
					["h"] = 14,
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
					["txt"] = "rune3_name",
					["texIcon"] = "rune3_tex",
					["TEIExpireState"] = "Hide",
					["text"] = "rune3_timer",
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
					["tex"] = "rune3_icon",
					["countTypeFlag"] = "true",
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "rune4_bar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -60,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [32]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = 180,
					["feature"] = "txt_custom",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["name"] = "rune4_timer",
					["h"] = 14,
				}, -- [33]
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
						["justifyH"] = "LEFT",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune4_bar",
					},
					["name"] = "rune4_text",
					["h"] = 14,
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
					["txt"] = "rune4_name",
					["texIcon"] = "rune4_tex",
					["TEIExpireState"] = "Hide",
					["text"] = "rune4_timer",
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
					["tex"] = "rune4_icon",
					["countTypeFlag"] = "true",
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "rune5_bar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -80,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [40]
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
						["af"] = "rune5_bar",
					},
					["name"] = "rune5_timer",
					["h"] = 14,
				}, -- [41]
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
						["justifyH"] = "LEFT",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune5_bar",
					},
					["name"] = "rune5_text",
					["h"] = 14,
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
					["txt"] = "rune5_name",
					["texIcon"] = "rune5_tex",
					["TEIExpireState"] = "Hide",
					["text"] = "rune5_timer",
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
					["tex"] = "rune5_icon",
					["countTypeFlag"] = "true",
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
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["orientation"] = "HORIZONTAL",
					["name"] = "rune6_bar",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -100,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
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
					["drawLayer"] = "OVERLAY",
					["version"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [48]
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
						["af"] = "rune6_bar",
					},
					["name"] = "rune6_timer",
					["h"] = 14,
				}, -- [49]
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
						["justifyH"] = "LEFT",
						["size"] = 9,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "rune6_bar",
					},
					["name"] = "rune6_text",
					["h"] = 14,
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
					["txt"] = "rune6_name",
					["texIcon"] = "rune6_tex",
					["TEIExpireState"] = "Hide",
					["text"] = "rune6_timer",
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
					["tex"] = "rune6_icon",
					["countTypeFlag"] = "true",
					["timerVar"] = "rune6",
					["sbcolorVar2"] = "rune6_color",
				}, -- [51]
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
						["b"] = 1,
						["g"] = 0.4705882352941176,
						["r"] = 0.5137254901960784,
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
					["font"] = {
						["size"] = 12,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["justifyH"] = "LEFT",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
					},
					["name"] = "cf1",
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
					["nIcons"] = 10,
					["owner"] = "decor",
					["mindurationfilter"] = 0,
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
						["borientation"] = "VERTICAL",
						["btype"] = "Frame",
						["w"] = 20,
						["banchor"] = "BOTTOM",
						["h"] = 200,
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
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\vbar1",
						},
						["stacktxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["nametxt"] = {
							["flags"] = "OUTLINE",
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Decker.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["iconposition"] = "BOTTOM",
					},
					["orientation"] = "RIGHT",
					["rows"] = 1,
					["filterNameList"] = {
					},
					["version"] = 2,
					["feature"] = "cooldown_bars",
					["countTypeFlag"] = "false",
					["name"] = "ab2",
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
					["maxdurationfilter"] = 3000,
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
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
						},
						["nametxt"] = {
							["flags"] = "OUTLINE",
							["title"] = "Default",
							["name"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\Decker.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["h"] = 20,
						["showicon"] = true,
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
						["stacktxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
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
		["Druid_Power_stc"] = {
			["ty"] = "Statistic",
			["version"] = 1,
			["data"] = {
				["texture"] = "",
				["fadeColor"] = {
					["a"] = 1,
					["b"] = 0.5372549019607842,
					["g"] = 0,
					["r"] = 0.6352941176470583,
				},
				["name"] = "Druid",
				["sv"] = 2,
				["color"] = {
					["a"] = 1,
					["b"] = 0.06666666666666665,
					["g"] = 0.2784313725490195,
					["r"] = 0.7333333333333334,
				},
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Druid_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["pct"] = 1,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Druid_fset",
						["class"] = "file",
					},
					["qty"] = "smp",
				},
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
		["Status_Power"] = {
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
					["title"] = "Class Mana Status",
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
					["version"] = 1,
					["name"] = "but1",
					["mbuttontype"] = "MiniMapTracking",
					["owner"] = "decor",
					["w"] = "32",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [2]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["version"] = 1,
					["name"] = "but2",
					["mbuttontype"] = "MiniMapVoiceChatFrame",
					["owner"] = "decor",
					["w"] = "32",
					["anchor"] = {
						["dx"] = 32,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [3]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["version"] = 1,
					["name"] = "but3",
					["mbuttontype"] = "MiniMapLFGFrame",
					["owner"] = "decor",
					["w"] = "32",
					["anchor"] = {
						["dx"] = 64,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [4]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["version"] = 1,
					["mbuttontype"] = "MiniMapBattlefieldFrame",
					["anchor"] = {
						["dx"] = 96,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "32",
					["name"] = "but4",
				}, -- [5]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["version"] = 1,
					["mbuttontype"] = "MiniMapMailFrame",
					["anchor"] = {
						["dx"] = 128,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "32",
					["name"] = "but5",
				}, -- [6]
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
		["None_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"false", -- [1]
			},
		},
	},
-- End Export Data for win_DispelGrid
-- End RDX Data Export
        };
});
