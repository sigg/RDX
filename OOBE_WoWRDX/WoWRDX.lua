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
PrepareInstall = function()
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["h"] = "height",
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
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["ty"] = "AUI",
					["name"] = "otxt1",
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["h"] = "height",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt1",
					},
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["sy"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["ty"] = "AUIState",
					["name"] = "otxt2",
				}, -- [4]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["h"] = "height",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt2",
					},
					["font"] = {
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["ty"] = "Usage",
					["name"] = "otxt3",
				}, -- [5]
				{
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["feature"] = "txt_other",
					["h"] = "height",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_otxt3",
					},
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["ty"] = "Memory Debit",
					["name"] = "otxt4",
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
							["ca"] = 1,
							["cg"] = 0.04313725490196078,
							["title"] = "Default",
							["cb"] = 0,
							["flags"] = "OUTLINE",
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "TEXT",
						["Offsety"] = -20,
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
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kr"] = 0.1,
						["kb"] = 0.1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["kg"] = 0.1,
						["_border"] = "IshBorder",
						["edgeSize"] = 12,
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["version"] = 1,
					["usebkd"] = 1,
					["orientation"] = "RIGHT",
					["externalButtonSkin"] = "bs_simplesquare",
					["name"] = "ai1",
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
					["version"] = 1,
					["deathColor"] = {
						["a"] = 1,
						["b"] = 0.6000000000000001,
						["g"] = 0.3,
						["r"] = 0.6000000000000001,
					},
					["name"] = "rune_bar_skin",
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
		["Decurse_Shaman_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 51886,
				},
			},
		},
		["Raid_Main_Group3"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							[3] = true,
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
			},
		},
		["Interrupt_Hunter_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 34490,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 19503,
				},
			},
		},
		["Dispell_Shaman_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 370,
				},
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
						["flags"] = "THICKOUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["size"] = 12,
					},
					["feature"] = "sec_aura_icons",
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
							["flags"] = "THICKOUTLINE",
							["cg"] = 0.807843137254902,
							["justifyH"] = "CENTER",
							["cb"] = 0.02745098039215686,
							["title"] = "Default",
							["name"] = "Default",
							["ca"] = 1,
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
					["bkd"] = {
					},
					["sortmethod"] = "INDEX",
					["name"] = "sai1",
					["version"] = 1,
					["xoffset"] = 0,
					["orientation"] = "LEFT",
					["maxwraps"] = 2,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["tex"] = "totemearth_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["name"] = "texcd_earth",
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
					["flo"] = 3,
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
					["secure"] = 1,
					["h"] = "36",
					["version"] = 1,
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = "36",
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
					["flo"] = 3,
					["secure"] = 1,
					["version"] = 1,
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
					["h"] = 36,
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
					["version"] = 1,
					["flo"] = 3,
					["secure"] = 1,
				}, -- [13]
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
					["mbFriendly"] = "WoWRDX:Decurse_mb",
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
		["Paladin_Buff_Kings_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				79062, -- [1]
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
				["sv"] = 2,
				["color"] = {
					["a"] = 1,
					["r"] = 0.5254901960784313,
					["g"] = 0.5254901960784313,
					["b"] = 0.5254901960784313,
				},
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Priest_fset",
					},
				},
				["pct"] = 1,
				["texture"] = "",
			},
		},
		["Priest_Buff_POM_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["auraType"] = "BUFFS",
					["playerauras"] = 1,
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
					["timer1"] = "0",
					["timer2"] = "0",
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "auraia",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
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
					["feature"] = "txt_np",
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
					["classColor"] = 1,
					["name"] = "np",
				}, -- [6]
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
						["sx"] = 1,
						["title"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
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
						["flags"] = "OUTLINE",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["sb"] = 0,
						["title"] = "Default",
						["name"] = "Default",
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
					["h"] = "14",
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
					["tex"] = "auraia_icon",
					["blendcolor"] = 1,
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
		["Paladin_Buff_Might_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79102,
				},
			},
		},
		["Dispell_Grid_Shiftcode_sc"] = {
			["ty"] = "Script",
			["version"] = 1,
			["data"] = {
				["script"] = "if shifted_flag then text = \"SHIFT\"; end",
			},
		},
		["Decurse_Priest_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 527,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 528,
				},
			},
		},
		["Interrupt_Mage_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 2139,
				},
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
					["alpha"] = 1,
					["w"] = 90,
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
					["feature"] = "txt_np",
					["h"] = "14",
					["version"] = 1,
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
					["name"] = "text_hp_missing",
					["ty"] = "hpm",
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
					["clickable"] = 1,
					["version"] = 1,
					["unit"] = "targettarget",
				}, -- [3]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.1,
					["slot"] = "RepaintAll",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
			},
		},
		["Decurse_mb"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["targetpath_5"] = "WoWRDX:Noop_mb",
				["class"] = "class",
				["targetpath_7"] = "WoWRDX:Decurse_Mage_mb",
				["targetpath_8"] = "WoWRDX:Noop_mb",
				["targetpath_2"] = "WoWRDX:Decurse_Druid_mb",
				["targetpath_3"] = "WoWRDX:Decurse_Paladin_mb",
				["targetpath_4"] = "WoWRDX:Decurse_Shaman_mb",
				["targetpath_1"] = "WoWRDX:Decurse_Priest_mb",
				["targetpath_10"] = "WoWRDX:Noop_mb",
				["targetpath_9"] = "WoWRDX:Noop_mb",
				["targetpath_6"] = "WoWRDX:Noop_mb",
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
		["Meter_Damage_Done_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["vname"] = "cs8874173",
						["op"] = "tablemeter",
						["path"] = "WoWRDX:Meter_Damage_Done_tm",
					}, -- [1]
				},
				["set"] = {
					["class"] = "file",
					["file"] = "WoWRDX:Meter_Damage_Done_fset",
				},
			},
		},
		["Target_Alternate_Bar"] = {
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
					["design"] = "WoWRDX:Target_Alternate_Bar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
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
					["factionID"] = 14,
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
						["justifyH"] = "CENTER",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
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
					["version"] = 1,
					["h"] = "BaseHeight",
				}, -- [6]
			},
		},
		["Buff_Mage_mb"] = {
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
		["Boss_Main"] = {
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
					["feature"] = "Data Source: Secure Set",
					["set"] = {
						["file"] = "WoWRDX:Boss_fset",
						["class"] = "file",
					},
					["rostertype"] = "BOSS",
				}, -- [3]
				{
					["feature"] = "Boss Layout",
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
					["hotspot"] = "dmg",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_dmg",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "target",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "interrupt",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Interrupt_mb",
				}, -- [8]
			},
		},
		["Warlock_Shards"] = {
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["orientation"] = "VERTICAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 1,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "hpframe",
					},
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
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["justifyH"] = "CENTER",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
				}, -- [69]
				{
					["w"] = "36",
					["feature"] = "hotspot",
					["h"] = "36",
					["name"] = "heal",
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
					["version"] = 1,
					["secure"] = 1,
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
					["blendcolor"] = 1,
					["tex"] = "",
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
					["blendcolor"] = 1,
					["tex"] = "",
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
					["blendcolor"] = 1,
					["tex"] = "",
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
					["version"] = 1,
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
					["countTypeFlag"] = "true",
					["stackVar"] = "aura_lifebloom_stack",
					["TL"] = 0,
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
					["usebs"] = true,
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
						["nametxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
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
						["timetxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "RIGHT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["h"] = 20,
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["interval"] = 0.3,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [9]
				{
					["feature"] = "Description",
					["description"] = "Health statistics",
				}, -- [10]
			},
		},
		["Raid_Main_Group5"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							[5] = true,
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
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
				["sv"] = 2,
				["color"] = {
					["a"] = 1,
					["r"] = 0.7333333333333334,
					["g"] = 0.2784313725490195,
					["b"] = 0.06666666666666665,
				},
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Druid_fset",
					},
				},
				["pct"] = 1,
				["texture"] = "",
			},
		},
		["Warrior_Shout"] = {
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
		["Player_Alternate_Bar"] = {
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
					["design"] = "WoWRDX:Player_Alternate_Bar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Shaman_Totems9"] = {
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
				["sv"] = 1,
				["color"] = {
					["a"] = 1,
					["b"] = 0.7607843137254902,
					["g"] = 0.2980392156862746,
					["r"] = 0,
				},
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Dps_fset",
						["class"] = "file",
					},
					["qty"] = "smaxmp",
				},
				["pct"] = 1,
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
		["Meter_Damage_Done_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_tablemeter",
					["name"] = "combatmeter1",
					["tablemeter"] = "WoWRDX:Meter_Damage_Done_tm",
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
					["txt"] = "combatmeter1_text",
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
		["Player_Buff_Icon"] = {
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
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
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
		["Meter_Damage_Done"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Ability_BackStab",
					},
					["showtitlebar"] = 1,
					["title"] = "Damage Done",
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
					["design"] = "WoWRDX:Meter_Damage_Done_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Meter_Damage_Done_sort",
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
					["path"] = "WoWRDX:Meter_Damage_Done_tm",
				}, -- [7]
			},
		},
		["Priest_Buff_Serendipity_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
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
					["name"] = "aurai",
					["timer1"] = "0",
					["timer2"] = "0",
					["cd"] = 63735,
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["nIcons"] = 5,
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
					["color3"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.1529411764705883,
						["b"] = 1,
					},
					["version"] = 1,
					["drawLayer"] = "ARTWORK",
					["orientation"] = "RIGHT",
					["name"] = "customicon1",
					["color5"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.1529411764705883,
						["b"] = 1,
					},
					["h"] = 20,
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
		["Decurse_Mage_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 475,
				},
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
					["version"] = 1,
					["dyntexture"] = 1,
					["owner"] = "decor",
					["w"] = "36",
					["tex"] = "totemearth_icon",
					["feature"] = "texture_cooldown",
					["h"] = "36",
					["name"] = "texcd_earth",
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
					["version"] = 1,
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
					["name"] = "fire",
					["secure"] = 1,
					["h"] = 36,
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
					["version"] = 1,
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
					["name"] = "water",
					["secure"] = 1,
					["h"] = 36,
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
					["version"] = 1,
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
					["version"] = 1,
					["h"] = "36",
					["secure"] = 1,
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
					["name"] = "remove",
					["secure"] = 1,
					["h"] = 36,
				}, -- [13]
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
					["name"] = "tex1",
					["version"] = 1,
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
						["title"] = "Default",
						["cb"] = 0.6901960784313725,
						["justifyH"] = "LEFT",
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
					["ty"] = "mapzonetext",
					["name"] = "otxt1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["version"] = 1,
					["h"] = "14",
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
						["sb"] = 0,
						["justifyH"] = "CENTER",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
				}, -- [4]
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
					["design"] = "WoWRDX:Target_Main_ds",
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
					["dxn"] = 1,
					["cols"] = 1,
					["axis"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "dmg",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_dmg",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "target",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "interrupt",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Interrupt_mb",
				}, -- [7]
			},
		},
		["Shaman_Totems6"] = {
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
		["Deathknight_Runes2"] = {
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
		["Interrupt_Rogue_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 1766,
				},
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
					["hotspot"] = "dmg",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_dmg",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "target",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "interrupt",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Interrupt_mb",
				}, -- [7]
			},
		},
		["Meter_Heal_Done_tm"] = {
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
		["Dispell_Priest_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 527,
				},
			},
		},
		["Meter_Overheal_Done_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["vname"] = "cs3032014",
						["op"] = "tablemeter",
						["path"] = "WoWRDX:Meter_Overheal_Done_tm",
					}, -- [1]
				},
				["set"] = {
					["class"] = "file",
					["file"] = "WoWRDX:Meter_Overheal_Done_fset",
				},
			},
		},
		["Decurse_Paladin_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 4987,
				},
			},
		},
		["Player_SecureBuff_Bar"] = {
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
					["design"] = "WoWRDX:Player_SecureBuff_Bar_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["switchvehicle"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Player_Debuff_Bar"] = {
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
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
					["feature"] = "ColorVariable: Unit PowerType Color",
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0.75,
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
				}, -- [3]
				{
					["feature"] = "commentline",
				}, -- [4]
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["w"] = 90,
					["alpha"] = 1,
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
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["classColor"] = 1,
					["h"] = "14",
				}, -- [7]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "status_text",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["ty"] = "fdld",
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
					["version"] = 1,
				}, -- [8]
				{
					["owner"] = "Base",
					["w"] = "40",
					["feature"] = "txt_status",
					["h"] = "14",
					["name"] = "text_mp_percent",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Base",
					},
					["ty"] = "mpp",
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
					["version"] = 1,
				}, -- [9]
			},
		},
		["infoIsImmutable"] = false,
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
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -24,
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
					["flOffset"] = 1,
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
				}, -- [4]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_plife",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.7119999825954437,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_border"] = "IshBorder",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_plife",
					["w"] = "200",
					["colorVar"] = "green",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
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
					["flOffset"] = 2,
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
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
					["feature"] = "colorvar_hostility_class",
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
					["sublevel"] = 2,
					["colorVar"] = "hostilityclassColor",
					["owner"] = "sf_life",
					["w"] = "200",
					["name"] = "sb_life",
					["drawLayer"] = "ARTWORK",
					["h"] = "20",
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
				}, -- [14]
				{
					["owner"] = "sf_life",
					["w"] = "150",
					["feature"] = "txt_status",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["name"] = "Default",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 10,
					},
					["name"] = "text_vie",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["ty"] = "hptxt2",
					["version"] = 1,
				}, -- [15]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["name"] = "text_dead",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_life",
					},
					["h"] = "14",
					["ty"] = "fdld",
					["version"] = 1,
				}, -- [16]
				{
					["owner"] = "sf_life",
					["w"] = "100",
					["feature"] = "txt_status",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
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
					["h"] = "14",
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
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_border"] = "IshBorder",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["sy"] = 0,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
					},
					["name"] = "text_mana",
					["anchor"] = {
						["dx"] = 5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_sf_mana",
					},
					["h"] = "14",
					["ty"] = "mptxt",
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 14,
					},
					["name"] = "status_text",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["h"] = "30",
					["name"] = "np",
					["version"] = 1,
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 14,
					},
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
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 4,
						["dy"] = -38,
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
					["filterNameList"] = {
					},
					["usebs"] = true,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "debuff",
					["orientation"] = "RIGHT",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["size"] = 14,
					["unitfilter"] = "",
				}, -- [37]
				{
					["feature"] = "commentline",
				}, -- [38]
				{
					["feature"] = "var_spellinfo",
					["raColor2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["raColor1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["raColor3"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 1,
					},
					["raColor4"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
				}, -- [39]
				{
					["frac"] = "",
					["sublevel"] = 1,
					["owner"] = "decor",
					["w"] = "80",
					["colorVar"] = "spell_color",
					["drawLayer"] = "ARTWORK",
					["h"] = "12",
					["name"] = "spellBar",
					["anchor"] = {
						["dx"] = 125,
						["dy"] = -11,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar_smooth",
					},
				}, -- [40]
				{
					["TEIDefaultState"] = "Hide",
					["textInfo"] = "",
					["sbExpireState"] = "Hide",
					["TTIExpireState"] = "Hide",
					["feature"] = "free_timer",
					["sbDefaultState"] = "Hide",
					["TTIDefaultState"] = "Hide",
					["textType"] = "VFL.Hundredths",
					["statusBar"] = "spellBar",
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
					["countTypeFlag"] = "spell_casting",
					["tex"] = "",
					["txt"] = "",
					["timerVar"] = "spell",
					["texIcon"] = "",
				}, -- [41]
				{
					["txt"] = "spell_name_rank",
					["owner"] = "decor",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["font"] = {
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["name"] = "Default",
						["justifyH"] = "CENTER",
						["title"] = "Default",
						["size"] = 8,
					},
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = 125,
						["dy"] = -11,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "12",
					["version"] = 1,
				}, -- [42]
				{
					["feature"] = "commentline",
				}, -- [43]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["h"] = "22",
					["name"] = "dmg",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -26,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [44]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -49,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "12",
					["secure"] = 1,
					["name"] = "target",
				}, -- [45]
				{
					["mover"] = 1,
					["w"] = "80",
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 125,
						["dy"] = -11,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "12",
					["secure"] = 1,
					["name"] = "interrupt",
				}, -- [46]
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
		["MiniMapButtons_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 64,
					["version"] = 1,
					["w"] = 128,
					["alpha"] = 1,
				}, -- [1]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "mtracking",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "MiniMapTracking",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [2]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "mvoice",
					["anchor"] = {
						["dx"] = 32,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "MiniMapVoiceChatFrame",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [3]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "mrecord",
					["anchor"] = {
						["dx"] = 64,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "MiniMapRecordingButton",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [4]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "mmail",
					["anchor"] = {
						["dx"] = 96,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "MiniMapMailFrame",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [5]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "lfg",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -32,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "MiniMapLFGFrame",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [6]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "battle",
					["anchor"] = {
						["dx"] = 32,
						["dy"] = -32,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "MiniMapBattlefieldFrame",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [7]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "instance",
					["anchor"] = {
						["dx"] = 64,
						["dy"] = -32,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "MiniMapInstanceDifficulty",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [8]
				{
					["feature"] = "minimapbutton",
					["h"] = "32",
					["name"] = "guilde",
					["anchor"] = {
						["dx"] = 96,
						["dy"] = -32,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["mbuttontype"] = "GuildInstanceDifficulty",
					["owner"] = "decor",
					["w"] = "32",
					["version"] = 1,
				}, -- [9]
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
		["Buff_Paladin_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79062,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 79102,
				},
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
						["flags"] = "THICKOUTLINE",
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["sa"] = 1,
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
							["ca"] = 1,
							["cg"] = 0.7372549019607844,
							["sy"] = 0,
							["sx"] = 0,
							["justifyH"] = "CENTER",
							["cb"] = 0.1333333333333333,
							["flags"] = "OUTLINE",
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
					["usebs"] = true,
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
		["Buff_Druid_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79061,
				},
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
				["sv"] = 1,
				["color"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxhp",
					["set"] = {
						["class"] = "group",
					},
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
					["cd"] = 79107,
					["timer1"] = "0",
					["timer2"] = "0",
					["name"] = "aurai",
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
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
					["ty"] = "gn",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "high",
					},
					["name"] = "text_group",
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
						["size"] = 9,
					},
					["h"] = "14",
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
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
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
					["version"] = 1,
					["name"] = "tex_range",
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
					["flag"] = "true",
					["feature"] = "Highlight: Texture Map",
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
					["name"] = "auraia",
					["timer1"] = "0",
					["timer2"] = "0",
					["cd"] = 15286,
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -24,
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
						["edgeSize"] = 8,
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["_border"] = "IshBorder",
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_plife",
					["w"] = "200",
					["colorVar"] = "green",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
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
					["colorVar"] = "hostilityclassColor",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["name"] = "sb_life",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
					["version"] = 1,
					["sublevel"] = 1,
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["sy"] = 0,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
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
					["ty"] = "hptxt2",
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["name"] = "Default",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 10,
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
					["name"] = "text_dead",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["justifyH"] = "LEFT",
						["name"] = "Default",
						["size"] = 10,
					},
					["h"] = "14",
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
					["name"] = "text_mob",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["size"] = 10,
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
					["flOffset"] = 1,
				}, -- [19]
				{
					["feature"] = "backdrop",
					["owner"] = "sf_mana",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "IshBorder",
						["kg"] = 0,
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["edgeSize"] = 8,
						["kr"] = 0,
						["ka"] = 0.7119999825954437,
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
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
					["colorVar2"] = "nocolor",
					["feature"] = "ColorVariable: Conditional Color",
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
					["name"] = "status_text",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["justifyH"] = "LEFT",
						["name"] = "Default",
						["sy"] = 0,
						["size"] = 14,
					},
					["h"] = "30",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["h"] = "30",
					["name"] = "np",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["title"] = "Default",
						["size"] = 14,
					},
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
					["set2"] = {
						["class"] = "file",
						["file"] = "default:set_debuff_poison",
					},
					["texture1"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					},
					["set1"] = {
						["class"] = "file",
						["file"] = "default:set_debuff_magic",
					},
					["texture3"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_RemoveDisease",
					},
					["feature"] = "Variables decurse",
					["raColor1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 1,
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
						["g"] = 1,
						["b"] = 0,
					},
					["set3"] = {
						["class"] = "file",
						["file"] = "default:set_debuff_disease",
					},
					["set4"] = {
						["class"] = "file",
						["file"] = "default:set_debuff_curse",
					},
					["texture2"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_NullifyPoison_02",
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
				}, -- [38]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "24",
					["feature"] = "texture",
					["h"] = "24",
					["version"] = 1,
					["name"] = "tex1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
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
				}, -- [39]
				{
					["feature"] = "shader_applytex",
					["texture"] = "tex1",
					["version"] = 1,
					["var"] = "decurseIcon",
				}, -- [40]
				{
					["rows"] = 1,
					["fontst"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
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
						["dx"] = 3,
						["dy"] = -62,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
					["iconspy"] = 0,
					["nIcons"] = 10,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "decor",
					["playerauras"] = 1,
					["filterNameList"] = {
					},
					["usebs"] = true,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "RIGHT",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["size"] = 14,
					["unitfilter"] = "",
				}, -- [41]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [42]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["flo"] = 3,
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -26,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["name"] = "heal",
					["secure"] = 1,
					["h"] = "22",
				}, -- [43]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["h"] = "12",
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -49,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["name"] = "player",
				}, -- [44]
				{
					["mover"] = 1,
					["w"] = "24",
					["feature"] = "hotspot",
					["h"] = "24",
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["name"] = "decurse",
				}, -- [45]
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
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -24,
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
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_border"] = "IshBorder",
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
					["h"] = "20",
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
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_life",
					["w"] = "200",
					["colorVar"] = "hostilityclassColor",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["name"] = "sb_life",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_life",
					},
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
					["version"] = 1,
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["name"] = "Default",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 10,
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
					["version"] = 1,
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["sy"] = 0,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["justifyH"] = "LEFT",
						["sy"] = 0,
						["name"] = "Default",
						["size"] = 10,
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = 0,
						["name"] = "Default",
						["size"] = 10,
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
					["flOffset"] = 2,
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
						["kg"] = 0,
						["kr"] = 0,
						["_border"] = "IshBorder",
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
					["feature"] = "statusbar_horiz",
					["owner"] = "sf_mana",
					["w"] = "200",
					["h"] = "10",
					["drawLayer"] = "ARTWORK",
					["colorVar"] = "powerColor",
					["name"] = "sb_power",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -3,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_mana",
					},
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
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["name"] = "Default",
						["sy"] = 0,
						["title"] = "Default",
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
					["ty"] = "level",
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 14,
					},
					["version"] = 1,
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["justifyH"] = "LEFT",
						["sy"] = 0,
						["name"] = "Default",
						["size"] = 14,
					},
					["name"] = "np",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 8,
					["feature"] = "txt_np",
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
					["name"] = "debuff",
					["version"] = 1,
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
					["feature"] = "commentline",
				}, -- [38]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["flo"] = 3,
					["name"] = "heal",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -26,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "22",
					["secure"] = 1,
					["version"] = 1,
				}, -- [39]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["flo"] = 3,
					["name"] = "player",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -49,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "12",
					["secure"] = 1,
					["version"] = 1,
				}, -- [40]
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
		["Raid_Main_Group7"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							[7] = true,
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
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
				["targetpath_2"] = "default:set_debuff_curse",
				["targetpath_3"] = "default:set_debuff_disease",
				["targetpath_4"] = "WoWRDX:None_fset",
				["targetpath_1"] = "default:set_debuff_disease",
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
		["infoIsIndelible"] = false,
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
		["Buff_Priest_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 79105,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 79107,
				},
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
		["Interrupt_Druid_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 80964,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 80965,
				},
			},
		},
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
						["cb"] = 1,
						["ca"] = 1,
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
						["title"] = "Default",
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["sy"] = 0,
						["cb"] = 0.8901960784313725,
						["name"] = "Default",
						["size"] = 8,
					},
					["fontkey"] = {
						["size"] = 10,
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["title"] = "Default",
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["sy"] = 0,
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["ca"] = 1,
						["cr"] = 1,
					},
					["headerstateType"] = "None",
					["abid"] = 13,
					["version"] = 1,
					["name"] = "barbut2",
					["orientation"] = "RIGHT",
					["size"] = 36,
					["headerstateCustom"] = "",
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
					["h"] = 34,
					["version"] = 1,
					["w"] = 160,
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
					["nIcons"] = 5,
				}, -- [2]
			},
		},
		["Meter_Overheal_Done_tm"] = {
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
		["Target_Alternate_Bar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "ALTERNATE_POWER_INDEX",
					["name"] = "fm",
				}, -- [1]
				{
					["feature"] = "base_default",
					["h"] = 28,
					["version"] = 1,
					["w"] = 120,
					["alpha"] = 1,
				}, -- [2]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "subframe",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "120",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -14,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [3]
				{
					["feature"] = "backdrop",
					["owner"] = "subframe",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "fer1",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0,
						["edgeSize"] = 8,
						["kr"] = 0,
						["bb"] = 0,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\Ferous\\Borders\\fer1",
						["ka"] = 0.2,
						["kg"] = 0,
						["bg"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [4]
				{
					["interpolate"] = 1,
					["frac"] = "1",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0,
					},
					["sublevel"] = 1,
					["owner"] = "decor",
					["w"] = "116",
					["color1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["drawLayer"] = "ARTWORK",
					["h"] = "10",
					["name"] = "alternateBar",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_subframe",
					},
					["orientation"] = "HORIZONTAL",
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalU",
					},
				}, -- [5]
				{
					["feature"] = "txt_np",
					["h"] = "14",
					["version"] = 1,
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "120",
					["name"] = "np",
				}, -- [6]
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
					["h"] = 20,
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
					["version"] = 1,
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.08627450980392157,
						["b"] = 0.1098039215686275,
					},
					["orientation"] = "RIGHT",
					["name"] = "customicon1",
					["color5"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.08627450980392157,
						["b"] = 0.1098039215686275,
					},
					["usebs"] = true,
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
					["version"] = 1,
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
					["name"] = "texcd_earth",
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
					["flo"] = 3,
					["secure"] = 1,
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
					["version"] = 1,
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
					["name"] = "texcd_Fire",
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
					["h"] = 36,
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
					["flo"] = 3,
					["secure"] = 1,
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
					["version"] = 1,
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
					["name"] = "texcd_water",
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
					["flo"] = 3,
					["secure"] = 1,
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
					["version"] = 1,
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
					["name"] = "texcd_air",
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
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
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
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
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
					["name"] = "tex1",
					["version"] = 1,
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
						["justifyH"] = "CENTER",
						["sx"] = 0,
						["sy"] = 0,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 14,
					},
				}, -- [4]
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
					["name"] = "np",
					["h"] = "12",
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
					["name"] = "hlt",
					["version"] = 1,
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
					["flag"] = "rezinc_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "yellow",
					["texture"] = "hlt",
				}, -- [8]
				{
					["flag"] = "rezdone_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "green",
					["texture"] = "hlt",
				}, -- [9]
			},
		},
		["Partytarget_Main"] = {
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
					["design"] = "WoWRDX:Partytarget_Main_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:Party_fset",
					},
				}, -- [3]
				{
					["feature"] = "Secure Assists",
					["interval"] = 0.1,
					["suffix2"] = "targettarget",
					["suffix1"] = "target",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "dmg",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_dmg",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "target",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "interrupt",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Interrupt_mb",
				}, -- [7]
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
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Paladin_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.2274509803921569,
					["b"] = 0.4862745098039216,
				},
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Paladin_fset",
					},
				},
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
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.6392156862745098,
						["r"] = 1,
					},
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
		["Raid_Main_Group2"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							[2] = true,
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
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
					["rows"] = 1,
					["feature"] = "vehiclebar",
					["iconspx"] = 2,
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
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["cb"] = 0.1058823529411765,
						["ca"] = 1,
						["cr"] = 1,
					},
					["iconspy"] = 0,
					["nIcons"] = 3,
					["showkey"] = 1,
					["owner"] = "Base",
					["name"] = "vehiclebar",
					["version"] = 1,
					["externalButtonSkin"] = "bs_simplesquare",
					["orientation"] = "RIGHT",
					["usebs"] = true,
					["size"] = 36,
					["headervisiType"] = "Vehicle",
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
					["condVar"] = "isExhaustion",
					["name"] = "xpcolor",
					["colorVar1"] = "blue",
					["feature"] = "ColorVariable: Conditional Color",
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
					["name"] = "infoText",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
					["version"] = 1,
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["justifyH"] = "CENTER",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
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
							["sy"] = 0,
							["justifyH"] = "CENTER",
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
					["version"] = 1,
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
					["name"] = "texcd_earth",
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
					["version"] = 1,
					["h"] = 36,
					["flo"] = 3,
				}, -- [5]
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
					["version"] = 1,
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
					["name"] = "texcd_Fire",
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
					["version"] = 1,
					["h"] = 36,
					["flo"] = 3,
				}, -- [7]
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
					["version"] = 1,
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
					["name"] = "texcd_water",
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
					["version"] = 1,
					["h"] = 36,
					["flo"] = 3,
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
							["title"] = "Default",
							["sy"] = 0,
							["name"] = "Default",
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
					["version"] = 1,
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
					["name"] = "texcd_air",
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
					["version"] = 1,
					["h"] = 36,
					["flo"] = 3,
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
					["flo"] = 3,
					["h"] = 14,
					["name"] = "remove",
				}, -- [13]
			},
		},
		["Deathknight_Runes6"] = {
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
					["design"] = "WoWRDX:Deathknight_Runes6_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["infoIsShare"] = false,
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune1_tex",
					["sublevel"] = 1,
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
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["size"] = 9,
					},
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
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "LEFT",
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
					["textType"] = "Tenths",
					["timerVar"] = "rune1",
					["txt"] = "rune1_name",
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
					["statusBar"] = "rune1_bar",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune2_tex",
					["sublevel"] = 1,
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
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "LEFT",
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
					["statusBar"] = "rune2_bar",
					["textInfo"] = "rune2_text",
					["timerVar"] = "rune2",
					["textType"] = "Tenths",
					["txt"] = "rune2_name",
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
					["TEIDefaultState"] = "Default",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune3_tex",
					["sublevel"] = 1,
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
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "LEFT",
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
					["textType"] = "Tenths",
					["timerVar"] = "rune3",
					["statusBar"] = "rune3_bar",
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
					["txt"] = "rune3_name",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune4_tex",
					["sublevel"] = 1,
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
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "LEFT",
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
					["textType"] = "Tenths",
					["timerVar"] = "rune4",
					["statusBar"] = "rune4_bar",
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
					["txt"] = "rune4_name",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune5_tex",
					["sublevel"] = 1,
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
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "LEFT",
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
					["textType"] = "Tenths",
					["timerVar"] = "rune5",
					["statusBar"] = "rune5_bar",
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
					["txt"] = "rune5_name",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune6_tex",
					["sublevel"] = 1,
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
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["justifyH"] = "LEFT",
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
					["textType"] = "Tenths",
					["timerVar"] = "rune6",
					["statusBar"] = "rune6_bar",
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
					["txt"] = "rune6_name",
				}, -- [50]
			},
		},
		["Threat"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Ability_BackStab",
					},
					["title"] = "Threat",
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
		["Decurse_Druid_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 2782,
				},
			},
		},
		["Interrupt_Deathknight_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 47528,
				},
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune1_tex",
					["sublevel"] = 1,
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
					["tex"] = "rune1_icon",
					["txt"] = "rune1_name",
					["timerVar"] = "rune1",
					["TEIExpireState"] = "Default",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune2_tex",
					["sublevel"] = 1,
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
					["tex"] = "rune2_icon",
					["txt"] = "rune2_name",
					["timerVar"] = "rune2",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["feature"] = "texture",
					["h"] = 19,
					["version"] = 1,
					["sublevel"] = 1,
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
					["tex"] = "rune3_icon",
					["txt"] = "rune3_name",
					["timerVar"] = "rune3",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["feature"] = "texture",
					["h"] = 19,
					["version"] = 1,
					["sublevel"] = 1,
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
					["tex"] = "rune4_icon",
					["txt"] = "rune4_name",
					["timerVar"] = "rune4",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["feature"] = "texture",
					["h"] = 19,
					["version"] = 1,
					["sublevel"] = 1,
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
					["tex"] = "rune5_icon",
					["txt"] = "rune5_name",
					["timerVar"] = "rune5",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["feature"] = "texture",
					["h"] = 19,
					["version"] = 1,
					["sublevel"] = 1,
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
					["tex"] = "rune6_icon",
					["txt"] = "rune6_name",
					["timerVar"] = "rune6",
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Shaman_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0.00392156862745098,
					["g"] = 0.7019607843137257,
					["b"] = 0.5098039215686274,
				},
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
					["interval"] = 0.2,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [4]
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
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Mage_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 0.3333333333333333,
					["b"] = 1,
				},
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Mage_fset",
					},
				},
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
					["classColor"] = 1,
					["font"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sy"] = -1,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sb"] = 0,
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 10,
					},
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["h"] = 18,
					["feature"] = "txt_np",
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
					["name"] = "kings",
					["h"] = "16",
					["flo"] = 3,
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
					["name"] = "might",
					["h"] = "16",
					["flo"] = 3,
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
					["version"] = 1,
					["name"] = "tex_range",
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
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "range",
					["colorVar1"] = "red",
					["condVar"] = "unitnotInRange30_flag",
					["colorVar2"] = "alpha",
				}, -- [20]
				{
					["flag"] = "true",
					["feature"] = "Highlight: Texture Map",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [21]
			},
		},
		["Meter_Heal_Done_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_tablemeter",
					["name"] = "combatmeter1",
					["tablemeter"] = "WoWRDX:Meter_Heal_Done_tm",
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
					["feature"] = "txt_np",
					["font"] = {
						["sr"] = 0,
						["face"] = "Fonts\\ARIALN.TTF",
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
						["title"] = "Default",
						["sy"] = -1,
						["cg"] = 1,
						["sx"] = 1,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["cb"] = 1,
						["ca"] = 1,
						["sr"] = 0,
						["sb"] = 0,
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
		["Interrupt_Paladin_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["S1"] = {
					["action"] = "cast",
					["spell"] = "Repentir",
				},
				["1"] = {
					["action"] = "cast",
					["spell"] = "Réprimandes",
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = "Marteau de la justice",
				},
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
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["b"] = 0.7803921568627451,
						["g"] = 0.03137254901960784,
						["r"] = 0.4352941176470588,
					},
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
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
				}, -- [6]
			},
		},
		["Interrupt_Warrior_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 6552,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 85388,
				},
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
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
				}, -- [6]
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
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["path"] = "Interface\\Icons\\INV_Misc_QuestionMark",
						["blendMode"] = "BLEND",
					},
					["title"] = "Class Mana Status",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["interval"] = 0.3,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [12]
				{
					["feature"] = "Description",
					["description"] = "Class Power statistics",
				}, -- [13]
			},
		},
		["infoAuthor"] = "Sigg",
		["Raid_Main_ds"] = {
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
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "couleurporte",
					["colorVar1"] = "vie",
					["colorVar2"] = "gris2",
					["condVar"] = "range_flag",
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
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["tile"] = false,
						["br"] = 0.4470588235294117,
						["kg"] = 0,
						["kr"] = 0,
						["bb"] = 0.3803921568627451,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\straight-border",
						["_border"] = "straight",
						["edgeSize"] = 8,
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
						["class"] = "file",
						["file"] = "default:set_debuff_poison",
					},
					["texture1"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					},
					["set1"] = {
						["class"] = "file",
						["file"] = "default:set_debuff_magic",
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
						["class"] = "file",
						["file"] = "default:set_debuff_curse",
					},
					["feature"] = "Variables decurse",
					["texture4"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_RemoveCurse",
					},
					["raColor2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["set3"] = {
						["class"] = "file",
						["file"] = "default:set_debuff_disease",
					},
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
					["var"] = "decurseIcon",
					["version"] = 1,
					["texture"] = "TextureDecurse",
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
					["secure"] = 1,
					["flo"] = 4,
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
					["sublevel"] = 1,
					["owner"] = "pdt",
					["w"] = "16",
					["h"] = "16",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "powerColor",
					["name"] = "manaBar",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 22,
						["dy"] = 2,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_pdt",
					},
					["orientation"] = "VERTICAL",
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX\\Skin\\vbar_halfoutline",
					},
				}, -- [37]
				{
					["w"] = "20",
					["feature"] = "hotspot",
					["flo"] = 4,
					["name"] = "player",
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
					["secure"] = 1,
					["h"] = "20",
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
					["interpolate"] = 1,
					["drawLayer"] = "ARTWORK",
					["h"] = "18",
					["owner"] = "high2",
					["w"] = "120",
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["colorVar"] = "couleurporte",
					["name"] = "viebar",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high2",
					},
					["sublevel"] = 1,
					["frac"] = "fh",
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
					["feature"] = "Subframe",
					["h"] = "20",
					["name"] = "high5",
					["flOffset"] = 5,
					["owner"] = "pdt",
					["w"] = "120",
					["anchor"] = {
						["dx"] = 40,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
				}, -- [45]
				{
					["w"] = "120",
					["feature"] = "hotspot",
					["secure"] = 1,
					["name"] = "heal",
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
					["h"] = "20",
					["flo"] = 4,
					["version"] = 1,
				}, -- [46]
				{
					["feature"] = "commentline",
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
					["name"] = "texparlera",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Common\\VoiceChat-Speaker",
					},
				}, -- [48]
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
				}, -- [49]
				{
					["color"] = "blanc",
					["feature"] = "Highlight: Texture Map",
					["flag"] = "voice_flag",
					["texture"] = "texparlera",
				}, -- [50]
				{
					["feature"] = "Highlight: Texture Map",
					["color"] = "blanc",
					["flag"] = "voice_flag",
					["texture"] = "texparlerb",
				}, -- [51]
				{
					["feature"] = "commentline",
				}, -- [52]
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
				}, -- [53]
				{
					["feature"] = "Highlight: Texture Map",
					["color"] = "colorrezincom",
					["flag"] = "rezincom_flag",
					["texture"] = "texrez",
				}, -- [54]
				{
					["feature"] = "Highlight: Texture Map",
					["color"] = "colorrezdone",
					["flag"] = "rezdone_flag",
					["texture"] = "texrez",
				}, -- [55]
				{
					["feature"] = "commentline",
				}, -- [56]
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
				}, -- [57]
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
				}, -- [58]
				{
					["owner"] = "high3",
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
						["size"] = 8,
					},
					["name"] = "txt_state",
					["anchor"] = {
						["dx"] = -25,
						["dy"] = 1,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_high3",
					},
					["ty"] = "fdld",
					["h"] = "14",
					["version"] = 1,
				}, -- [59]
				{
					["externalNameFilter"] = "default:aurafilter_buff",
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
					["filterNameList"] = {
					},
					["owner"] = "high3",
					["playerauras"] = 1,
					["size"] = 12,
					["bkd"] = {
					},
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "regen",
					["orientation"] = "LEFT",
					["usebs"] = true,
					["filterName"] = 1,
					["unitfilter"] = "",
				}, -- [60]
				{
					["externalNameFilter"] = "default:aurafilter_boss",
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
				}, -- [61]
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
				}, -- [62]
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
				}, -- [63]
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
				}, -- [64]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [65]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["name"] = "BlackColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [66]
				{
					["color"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0,
					},
					["name"] = "BlueColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [67]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["name"] = "YellowColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [68]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["name"] = "GreenColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [69]
				{
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["name"] = "RedColor",
					["feature"] = "ColorVariable: Static Color",
				}, -- [70]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [71]
				{
					["feature"] = "Variable: Unit In Set",
					["showlink"] = 1,
					["name"] = "BlueSet",
					["set"] = {
						["file"] = "default:set_blue",
						["class"] = "file",
					},
				}, -- [72]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high3",
					["w"] = "5",
					["feature"] = "texture",
					["h"] = "5",
					["version"] = 1,
					["name"] = "bottomLeftBg",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_high3",
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
				}, -- [73]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "BlueSet_flag",
					["color"] = "BlackColor",
					["texture"] = "bottomLeftBg",
				}, -- [74]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high5",
					["w"] = "4",
					["feature"] = "texture",
					["h"] = "4",
					["version"] = 1,
					["name"] = "bottomLeftTex",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Frame_high5",
					},
					["sublevel"] = 2,
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
				}, -- [75]
				{
					["feature"] = "Highlight: Texture Map",
					["flag"] = "BlueSet_flag",
					["color"] = "BlueColor",
					["texture"] = "bottomLeftTex",
				}, -- [76]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [77]
				{
					["feature"] = "Variable: Unit In Set",
					["showlink"] = 1,
					["name"] = "GreenSet",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_green",
					},
				}, -- [78]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high3",
					["w"] = "5",
					["feature"] = "texture",
					["h"] = "5",
					["name"] = "bottomRightBg",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Frame_high3",
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
				}, -- [79]
				{
					["flag"] = "GreenSet_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "BlackColor",
					["texture"] = "bottomRightBg",
				}, -- [80]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high5",
					["w"] = "4",
					["feature"] = "texture",
					["h"] = "4",
					["name"] = "bottomRightTex",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Frame_high5",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 2,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [81]
				{
					["flag"] = "GreenSet_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "GreenColor",
					["texture"] = "bottomRightTex",
				}, -- [82]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [83]
				{
					["feature"] = "Variable: Unit In Set",
					["showlink"] = 1,
					["name"] = "RedSet",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_red",
					},
				}, -- [84]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high3",
					["w"] = "5",
					["feature"] = "texture",
					["h"] = "5",
					["name"] = "topLeftBgTex",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high3",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 1,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [85]
				{
					["flag"] = "RedSet_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "BlackColor",
					["texture"] = "topLeftBgTex",
				}, -- [86]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high5",
					["w"] = "4",
					["feature"] = "texture",
					["h"] = "4",
					["name"] = "topLeftTex",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_high5",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 2,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [87]
				{
					["flag"] = "RedSet_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "RedColor",
					["texture"] = "topLeftTex",
				}, -- [88]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [89]
				{
					["feature"] = "Variable: Unit In Set",
					["showlink"] = 1,
					["name"] = "YellowSet",
					["set"] = {
						["class"] = "file",
						["file"] = "default:set_yellow",
					},
				}, -- [90]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high3",
					["w"] = "5",
					["feature"] = "texture",
					["h"] = "5",
					["name"] = "topRightBg",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_high3",
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
				}, -- [91]
				{
					["flag"] = "YellowSet_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "BlackColor",
					["texture"] = "topRightBg",
				}, -- [92]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "high5",
					["w"] = "4",
					["feature"] = "texture",
					["h"] = "4",
					["name"] = "topRightTex",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_high5",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 2,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [93]
				{
					["flag"] = "YellowSet_flag",
					["feature"] = "Highlight: Texture Map",
					["color"] = "YellowColor",
					["texture"] = "topRightTex",
				}, -- [94]
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
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemEarthIcon",
					["sublevel"] = 1,
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
						["sb"] = 0,
						["justifyH"] = "CENTER",
						["sy"] = -1,
						["sx"] = 1,
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = 36,
				}, -- [12]
				{
					["feature"] = "commentline",
				}, -- [13]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemFireIcon",
					["sublevel"] = 1,
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemFireBar",
					},
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = 36,
				}, -- [18]
				{
					["feature"] = "commentline",
				}, -- [19]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemWaterIcon",
					["sublevel"] = 1,
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemWaterBar",
					},
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = 36,
				}, -- [24]
				{
					["feature"] = "commentline",
				}, -- [25]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemAirIcon",
					["sublevel"] = 1,
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
					["h"] = 12,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "TotemAirBar",
					},
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = 36,
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = 12,
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
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 8,
					},
					["name"] = "np",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 12,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "110",
					["h"] = "14",
				}, -- [12]
				{
					["owner"] = "decor",
					["w"] = "35",
					["feature"] = "txt_status",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 102,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
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
					["usebs"] = true,
					["mindurationfilter"] = 0,
					["auraType"] = "DEBUFFS",
					["ButtonSkinOffset"] = 0,
					["owner"] = "decor",
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
						["dx"] = 0,
						["dy"] = -1,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "subframe",
					},
					["h"] = "14",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 13,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
					},
					["h"] = "14",
					["name"] = "infoText",
				}, -- [20]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "subframe",
					["w"] = "11",
					["feature"] = "texture",
					["h"] = "11",
					["name"] = "icontex",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "subframe",
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
				}, -- [21]
				{
					["feature"] = "shader_applytex",
					["owner"] = "icontex",
					["version"] = 1,
					["var"] = "spell_icon",
				}, -- [22]
			},
		},
		["Raid_Main_Pet_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"raidpetsecure", -- [1]
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
		["Raid_Main_Pet"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["switchvehicle"] = 1,
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
						},
						["pet"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
			},
		},
		["Raid_Main_Group8"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							[8] = true,
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
			},
		},
		["Interrupt_Warlock_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 19647,
				},
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
				["color"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5254901960784313,
					["r"] = 0.02352941176470588,
				},
				["max"] = {
					["set"] = {
						["file"] = "WoWRDX:Dps_fset",
						["class"] = "file",
					},
					["qty"] = "smaxhp",
				},
				["pct"] = 1,
				["sv"] = 1,
				["val"] = {
					["set"] = {
						["file"] = "WoWRDX:Dps_fset",
						["class"] = "file",
					},
					["qty"] = "shp",
				},
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
		["Meter_Damage_Done_tm"] = {
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
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Warlock_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0.1843137254901961,
					["g"] = 0,
					["b"] = 0.611764705882353,
				},
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Warlock_fset",
					},
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
					["name"] = "totembar1",
					["version"] = 1,
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
					["name"] = "totembar2",
					["version"] = 1,
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
					["name"] = "totembar3",
					["version"] = 1,
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
		["Debuff_Primary_fset"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["targetpath_5"] = "WoWRDX:None_fset",
				["class"] = "class",
				["targetpath_7"] = "default:set_debuff_curse",
				["targetpath_8"] = "WoWRDX:None_fset",
				["targetpath_2"] = "default:set_debuff_poison",
				["targetpath_3"] = "default:set_debuff_poison",
				["targetpath_4"] = "default:set_debuff_curse",
				["targetpath_1"] = "default:set_debuff_magic",
				["targetpath_10"] = "WoWRDX:None_fset",
				["targetpath_9"] = "WoWRDX:None_fset",
				["targetpath_6"] = "default:set_debuff_magic",
			},
		},
		["Player_Debuff_Icon_ds"] = {
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
					["rows"] = 10,
					["fontst"] = {
						["sr"] = 0,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 14,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["GfxReverse"] = true,
						["Font"] = {
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
							["ca"] = 1,
							["cg"] = 0.807843137254902,
							["title"] = "Default",
							["cb"] = 0.02745098039215686,
							["justifyH"] = "CENTER",
							["name"] = "Default",
							["flags"] = "THICKOUTLINE",
							["cr"] = 1,
						},
						["TimerType"] = "COOLDOWN&TEXT",
						["Offsety"] = -25,
						["UpdateSpeed"] = 0.3,
						["Offsetx"] = 3,
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
					["usebs"] = true,
					["maxdurationfilter"] = "",
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "LEFT",
					["bkd"] = {
					},
					["size"] = 40,
					["unitfilter"] = "",
				}, -- [2]
			},
		},
		["Meter_Damage_Done_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"nidmask", -- [1]
				}, -- [2]
				{
					"tablemeter", -- [1]
					"WoWRDX:Meter_Damage_Done_tm", -- [2]
					1, -- [3]
					10000000, -- [4]
				}, -- [3]
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
							["ca"] = 1,
							["cg"] = 0.04313725490196078,
							["title"] = "Default",
							["cb"] = 0,
							["flags"] = "OUTLINE",
							["name"] = "Default",
							["justifyH"] = "CENTER",
							["size"] = 10,
						},
						["TimerType"] = "TEXT",
						["Offsety"] = -20,
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
		["Meter_Heal_Done"] = {
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
					["design"] = "WoWRDX:Meter_Heal_Done_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Meter_Heal_Done_sort",
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
					["path"] = "WoWRDX:Meter_Heal_Done_tm",
				}, -- [7]
			},
		},
		["Status_Raid"] = {
			["ty"] = "StatusWindow",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["title"] = "Status",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["interval"] = 0.3,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [9]
				{
					["feature"] = "Description",
					["description"] = "Status (Alive, Dead, Not Here, Offline)",
				}, -- [10]
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
						["ca"] = 1,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["cb"] = 0.1058823529411765,
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["iconspy"] = 0,
					["nIcons"] = 10,
					["showkey"] = 1,
					["hidebs"] = 1,
					["externalButtonSkin"] = "bs_simplesquare",
					["owner"] = "Base",
					["usebs"] = true,
					["bkd"] = {
					},
					["abid"] = 1,
					["headervisiCustom"] = "",
					["name"] = "actionbarpet",
					["version"] = 1,
					["orientation"] = "RIGHT",
					["flo"] = 5,
					["size"] = 36,
					["headervisiType"] = "Pet",
				}, -- [2]
			},
		},
		["Meter_Overheal_Done"] = {
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
					["design"] = "WoWRDX:Meter_Overheal_Done_ds",
				}, -- [2]
				{
					["feature"] = "Data Source: Sort",
					["sortPath"] = "WoWRDX:Meter_Overheal_Done_sort",
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
					["path"] = "WoWRDX:Meter_Overheal_Done_tm",
				}, -- [7]
			},
		},
		["Deathknight_Runes1"] = {
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
					["design"] = "WoWRDX:Deathknight_Runes1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["infoRunAutoexec"] = false,
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
					["fontkey"] = {
						["cr"] = 1,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["cb"] = 0.1058823529411765,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 10,
					},
					["anyup"] = 1,
					["iconspx"] = 0,
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
					["nIcons"] = 12,
					["feature"] = "actionbar",
					["flo"] = 5,
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
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["size"] = 36,
					["showkey"] = 1,
					["barid"] = "mainbar1",
					["usebs"] = true,
					["bkd"] = {
						["ka"] = 1,
						["edgeSize"] = 12,
						["tile"] = false,
						["kr"] = 0.1,
						["kb"] = 0.1,
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
					["name"] = "barbut1",
					["owner"] = "Base",
					["headerstateType"] = "Defaultui",
					["flyoutdirection"] = "UP",
					["headerstateCustom"] = "",
					["headervisiCustom"] = "",
					["version"] = 1,
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
					["orientation"] = "RIGHT",
					["showtooltip"] = 1,
					["headervisType"] = "None",
					["headervisiType"] = "None",
				}, -- [2]
			},
		},
		["Interrupt_mb"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["targetpath_5"] = "WoWRDX:Interrupt_Warrior_mb",
				["class"] = "class",
				["targetpath_7"] = "WoWRDX:Interrupt_Mage_mb",
				["targetpath_8"] = "WoWRDX:Interrupt_Rogue_mb",
				["targetpath_2"] = "WoWRDX:Interrupt_Druid_mb",
				["targetpath_3"] = "WoWRDX:Interrupt_Paladin_mb",
				["targetpath_4"] = "WoWRDX:Interrupt_Shaman_mb",
				["targetpath_1"] = "WoWRDX:Interrupt_Priest_mb",
				["targetpath_10"] = "WoWRDX:Interrupt_Deathknight_mb",
				["targetpath_9"] = "WoWRDX:Interrupt_Hunter_mb",
				["targetpath_6"] = "WoWRDX:Interrupt_Warlock_mb",
			},
		},
		["Raid_Main_GroupAll_fset"] = {
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
		["Meter_Overheal_Done_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"nidmask", -- [1]
				}, -- [2]
				{
					"tablemeter", -- [1]
					"WoWRDX:Meter_Overheal_Done_tm", -- [2]
					1, -- [3]
					10000000, -- [4]
				}, -- [3]
			},
		},
		["Party_Main"] = {
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
					["feature"] = "Data Source: Secure Set",
					["rostertype"] = "RAID",
					["set"] = {
						["class"] = "file",
						["file"] = "default:Party_fset",
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
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [7]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [8]
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
					["title"] = "Main Tanks",
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["mbFriendly"] = "default:bindings_target",
				}, -- [5]
				{
					["feature"] = "NominativeSet Editor",
				}, -- [6]
			},
		},
		["infoIsCommon"] = false,
		["Dispell_mb"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["targetpath_5"] = "WoWRDX:Noop_mb",
				["class"] = "class",
				["targetpath_7"] = "WoWRDX:Noop_mb",
				["targetpath_8"] = "WoWRDX:Noop_mb",
				["targetpath_2"] = "WoWRDX:Noop_mb",
				["targetpath_3"] = "WoWRDX:Noop_mb",
				["targetpath_4"] = "WoWRDX:Dispell_Shaman_mb",
				["targetpath_1"] = "WoWRDX:Dispell_Priest_mb",
				["targetpath_10"] = "WoWRDX:Noop_mb",
				["targetpath_9"] = "WoWRDX:Noop_mb",
				["targetpath_6"] = "WoWRDX:Noop_mb",
			},
		},
		["Assists_Main"] = {
			["ty"] = "Window",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Frame: Lightweight",
					["texicon"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_DeathKnight_Explode_Ghoul",
					},
					["title"] = "Main Assists",
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
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [7]
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
						["size"] = 10,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["sy"] = 0,
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["cb"] = 0.1058823529411765,
						["ca"] = 1,
						["cr"] = 1,
					},
					["iconspy"] = 0,
					["size"] = 36,
					["showkey"] = 1,
					["owner"] = "Base",
					["nIcons"] = 8,
					["version"] = 1,
					["name"] = "stancebar",
					["orientation"] = "RIGHT",
					["externalButtonSkin"] = "bs_simplesquare",
					["usebs"] = true,
					["flo"] = 5,
				}, -- [2]
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
					["w"] = 90,
					["alpha"] = 1,
					["ph"] = 1,
				}, -- [1]
				{
					["owner"] = "Base",
					["w"] = "90",
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
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["classColor"] = 1,
					["h"] = "14",
				}, -- [2]
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
					["design"] = "WoWRDX:Info_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
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
						["ka"] = 0.2749999761581421,
						["kg"] = 0,
						["kb"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "HalStraight",
						["edgeSize"] = 8,
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
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["sb"] = 0,
						["sr"] = 0,
					},
					["name"] = "np",
					["version"] = 1,
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
					["ty"] = "hpp",
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
						["face"] = "Fonts\\FRIZQT__.TTF",
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
					["h"] = "20",
					["name"] = "text_hp_percent",
				}, -- [18]
				{
					["w"] = "140",
					["feature"] = "hotspot",
					["h"] = "20",
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
					["secure"] = 1,
					["flo"] = 3,
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
					["usebs"] = true,
					["size"] = 10,
					["name"] = "debuffs",
					["version"] = 1,
					["maxdurationfilter"] = "",
					["orientation"] = "RIGHT",
					["filterNameList"] = {
					},
					["petauras"] = 1,
					["unitfilter"] = "",
				}, -- [21]
			},
		},
		["Raid_Main_Group6"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							[6] = true,
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["dpm1"] = 0,
					["period"] = 0.1,
					["version"] = 1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
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
					["cd"] = 588,
					["timer1"] = "0",
					["timer2"] = "0",
					["name"] = "auraia",
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["alpha"] = 1,
					["w"] = 80,
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
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
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
					["TEIExpireState"] = "Default",
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
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
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
				}, -- [2]
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
					["feature"] = "Variables: Buffs Debuffs Info",
					["cd"] = 79061,
					["name"] = "aurai",
					["timer2"] = "0",
					["color3"] = {
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
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["feature"] = "base_default",
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
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
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
					["version"] = 1,
					["name"] = "tex_range",
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
					["flag"] = "true",
					["feature"] = "Highlight: Texture Map",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [17]
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
		["infoComment"] = "",
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
						["edgeSize"] = 16,
						["kb"] = 0,
						["kr"] = 0,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
						["_border"] = "tooltip",
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
					["ty"] = "level",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 5,
						["dy"] = -5,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
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
					["name"] = "level_text",
				}, -- [3]
				{
					["owner"] = "decor",
					["w"] = "120",
					["feature"] = "txt_np",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_level_text",
					},
					["name"] = "np",
					["classColor"] = 1,
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_level_text",
					},
					["name"] = "class_text_static",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_class_text_static",
					},
					["name"] = "race_text_static",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_race_text_static",
					},
					["name"] = "mobtype_text_static",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_mobtype_text_static",
					},
					["name"] = "group_text_static",
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
					["name"] = "guild_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_group_text_static",
					},
					["version"] = 1,
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
					["name"] = "target_text_static",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_guild_text_static",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [10]
				{
					["owner"] = "decor",
					["w"] = "100",
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
					["name"] = "guild_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_guild_text_static",
					},
					["version"] = 1,
					["ty"] = "guild",
					["h"] = "14",
				}, -- [11]
				{
					["owner"] = "decor",
					["w"] = "100",
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
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_class_text_static",
					},
					["name"] = "class_text_var",
					["h"] = "14",
					["ty"] = "class",
				}, -- [12]
				{
					["owner"] = "decor",
					["w"] = "100",
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
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_race_text_static",
					},
					["name"] = "race_text_var",
					["h"] = "14",
					["ty"] = "race",
				}, -- [13]
				{
					["owner"] = "decor",
					["w"] = "100",
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
					["name"] = "mobtype_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_mobtype_text_static",
					},
					["version"] = 1,
					["ty"] = "mobtype",
					["h"] = "14",
				}, -- [14]
				{
					["owner"] = "decor",
					["w"] = "100",
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
					["name"] = "group_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_group_text_static",
					},
					["version"] = 1,
					["ty"] = "gn",
					["h"] = "14",
				}, -- [15]
				{
					["editor"] = "--enter your code here\n\nlocal varsc1 = UnitName(uid .. \"target\");",
					["feature"] = "var_scripted",
					["name"] = "varsc1",
					["vartype"] = "TextData",
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
					["name"] = "target_text_var",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Text_target_text_static",
					},
					["version"] = 1,
					["h"] = "14",
				}, -- [17]
				{
					["feature"] = "Variable: Fractional health (fh)",
				}, -- [18]
				{
					["frac"] = "fh",
					["color2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
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
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Text_target_text_static",
					},
					["orientation"] = "HORIZONTAL",
					["feature"] = "statusbar_horiz",
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
						["dy"] = 5,
						["lp"] = "BOTTOM",
						["rp"] = "BOTTOM",
						["af"] = "Base",
					},
					["name"] = "hp_text",
					["h"] = "14",
					["ty"] = "hpp",
				}, -- [20]
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
					["iconspx"] = 0,
					["anyup"] = 1,
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
						["title"] = "Default",
						["cb"] = 1,
						["sy"] = 0,
						["name"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 10,
					},
					["externalButtonSkin"] = "bs_simplesquare",
					["feature"] = "actionbar",
					["flo"] = 5,
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
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["title"] = "Default",
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.6588235294117647,
						["sy"] = 0,
						["cb"] = 0.1058823529411765,
						["justifyH"] = "RIGHT",
						["sx"] = 0,
						["ca"] = 1,
						["cr"] = 1,
					},
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["barid"] = "bar5",
					["usebs"] = true,
					["fontmacro"] = {
						["cr"] = 1,
						["flags"] = "OUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["name"] = "Default",
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["title"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["cb"] = 0.8901960784313725,
						["justifyH"] = "RIGHT",
						["size"] = 8,
					},
					["version"] = 1,
					["owner"] = "Base",
					["headerstateCustom"] = "",
					["headerstateType"] = "None",
					["flyoutdirection"] = "UP",
					["headervisiCustom"] = "",
					["name"] = "barbut2",
					["bkd"] = {
					},
					["orientation"] = "RIGHT",
					["size"] = 36,
					["headervisType"] = "None",
					["headervisiType"] = "None",
				}, -- [2]
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
						["justifyH"] = "LEFT",
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["name"] = "Default",
						["size"] = 10,
					},
					["version"] = 1,
					["name"] = "np",
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
						["size"] = 9,
					},
					["name"] = "group",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Base",
					},
					["h"] = "10",
					["ty"] = "gn",
					["version"] = 1,
				}, -- [3]
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
		["Rogue_Combo"] = {
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
					["design"] = "WoWRDX:Rogue_Combo_ds",
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
		["Interrupt_Priest_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 15487,
				},
				["2"] = {
					["action"] = "cast",
					["spell"] = 8122,
				},
			},
		},
		["Buff_Warrior_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 2048,
				},
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
						["flags"] = "THICKOUTLINE",
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sx"] = 1,
						["sy"] = -1,
						["sb"] = 0,
						["sa"] = 1,
						["sr"] = 0,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["size"] = 10,
							["name"] = "Default",
							["title"] = "Default",
							["cg"] = 0.7372549019607844,
							["sx"] = 1,
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["sy"] = -1,
							["sa"] = 1,
							["sg"] = 0,
							["justifyH"] = "CENTER",
							["cb"] = 0.1333333333333333,
							["ca"] = 1,
							["sr"] = 0,
							["sb"] = 0,
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
					["size"] = 30,
					["unitfilter"] = "",
				}, -- [2]
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
		["infoAuthorWebSite"] = "http://www.wowrdx.com",
		["Deathknight_Runes5"] = {
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
					["design"] = "WoWRDX:Deathknight_Runes5_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
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
					["a"] = 1,
					["h"] = 14,
					["version"] = 1,
					["ph"] = true,
					["w"] = 90,
					["alpha"] = 1,
					["feature"] = "base_default",
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
				}, -- [5]
				{
					["owner"] = "Base",
					["w"] = "50",
					["feature"] = "txt_np",
					["h"] = "14",
					["version"] = 1,
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
					["classColor"] = 1,
					["name"] = "np",
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
					["name"] = "status_text",
					["ty"] = "fdld",
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
					["name"] = "text_hp_percent",
					["ty"] = "hpp",
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
				}, -- [8]
			},
		},
		["Warrior_Shout_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
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
					["color3"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["cd"] = 6673,
					["timer2"] = 0,
					["name"] = "auraia",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["color0"] = {
						["a"] = 0,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0,
					},
					["timer1"] = 0,
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
					["ph"] = 1,
					["h"] = 20,
					["version"] = 1,
					["hlt"] = 1,
					["feature"] = "base_default",
					["w"] = 100,
					["alpha"] = 1,
				}, -- [4]
				{
					["frac"] = "",
					["sublevel"] = 1,
					["owner"] = "decor",
					["w"] = "80",
					["colorVar"] = "yellow",
					["feature"] = "statusbar_horiz",
					["h"] = "20",
					["name"] = "statusBar",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 20,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["drawLayer"] = "ARTWORK",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
				}, -- [5]
				{
					["cleanupPolicy"] = 2,
					["owner"] = "decor",
					["w"] = "20",
					["feature"] = "texture",
					["h"] = "20",
					["name"] = "tex1",
					["version"] = 1,
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
				}, -- [6]
				{
					["script"] = "",
					["owner"] = "decor",
					["w"] = "40",
					["feature"] = "txt_custom",
					["font"] = {
						["size"] = 10,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
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
					["h"] = "20",
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
			},
		},
		["Threat_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"nidmask", -- [1]
			},
		},
		["Focus_Main"] = {
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
					["unit"] = "focus",
				}, -- [3]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.1,
					["slot"] = "RepaintAll",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "dmg",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_dmg",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "target",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "interrupt",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Interrupt_mb",
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
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "FilterSet Editor",
				}, -- [6]
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
					["iconspx"] = 0,
					["anyup"] = 1,
					["showtooltip"] = 1,
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
					["externalButtonSkin"] = "bs_simplesquare",
					["feature"] = "actionbar",
					["flo"] = 5,
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
					["nIcons"] = 12,
					["showkey"] = 1,
					["barid"] = "bar6_druid_stealth",
					["usebs"] = true,
					["fontmacro"] = {
						["size"] = 8,
						["title"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["cb"] = 0.8901960784313725,
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["name"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["flags"] = "OUTLINE",
						["justifyH"] = "RIGHT",
						["cr"] = 1,
					},
					["version"] = 1,
					["owner"] = "Base",
					["headerstateCustom"] = "",
					["headerstateType"] = "None",
					["flyoutdirection"] = "UP",
					["headervisiCustom"] = "",
					["name"] = "barbut2",
					["bkd"] = {
					},
					["orientation"] = "RIGHT",
					["size"] = 36,
					["headervisType"] = "None",
					["headervisiType"] = "None",
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
						["file"] = "WoWRDX:Healer_fset",
					},
				},
				["pct"] = 1,
				["texture"] = "",
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
					["nIcons"] = 5,
					["drawLayer"] = "ARTWORK",
					["usebs"] = true,
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
					["h"] = 20,
					["color5"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["bkd"] = {
						["ka"] = 1,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["kg"] = 0.1,
						["_border"] = "IshBorder",
						["edgeSize"] = 12,
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
		["Party_Main_ds"] = {
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
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "BaseWidth",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -24,
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
						["_border"] = "IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "RIGHT",
						["size"] = 10,
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["sx"] = 0,
						["sy"] = 0,
						["title"] = "Default",
						["justifyH"] = "LEFT",
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "LEFT",
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["title"] = "Default",
						["size"] = 10,
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
						["_border"] = "IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["title"] = "Default",
						["sx"] = 0,
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["sy"] = 0,
						["size"] = 10,
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
					["condVar"] = "aggro_flag",
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
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["justifyH"] = "LEFT",
						["sx"] = 0,
						["name"] = "Default",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 14,
					},
					["name"] = "status_text",
				}, -- [35]
				{
					["owner"] = "pdt",
					["w"] = "200",
					["classColor"] = 1,
					["h"] = "30",
					["version"] = 1,
					["font"] = {
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "LEFT",
						["title"] = "Default",
						["sy"] = 0,
						["size"] = 14,
					},
					["anchor"] = {
						["dx"] = 21,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_pdt",
					},
					["trunc"] = 20,
					["feature"] = "txt_np",
					["name"] = "np",
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
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "15",
					["drawLayer"] = "ARTWORK",
				}, -- [37]
				{
					["feature"] = "tex_role",
					["h"] = "15",
					["name"] = "role",
					["ButtonSkinOffset"] = 10,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 2,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_sf_sup",
					},
					["owner"] = "sf_sup",
					["w"] = "15",
					["drawLayer"] = "ARTWORK",
				}, -- [38]
				{
					["set2"] = {
						["class"] = "debuff",
						["buff"] = "@poison",
					},
					["texture1"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					},
					["set1"] = {
						["class"] = "debuff",
						["buff"] = "@magic",
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
						["class"] = "debuff",
						["buff"] = "@curse",
					},
					["feature"] = "Variables decurse",
					["texture4"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Icons\\Spell_Nature_RemoveCurse",
					},
					["raColor2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
					["set3"] = {
						["class"] = "debuff",
						["buff"] = "@disease",
					},
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
				}, -- [39]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "24",
					["feature"] = "texture",
					["h"] = "24",
					["version"] = 1,
					["name"] = "tex1",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
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
				}, -- [40]
				{
					["feature"] = "shader_applytex",
					["owner"] = "tex1",
					["version"] = 1,
					["var"] = "decurseIcon",
				}, -- [41]
				{
					["rows"] = 1,
					["fontst"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "CENTER",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
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
						["Offsety"] = 0,
						["TimerType"] = "COOLDOWN",
						["Offsetx"] = 0,
						["UpdateSpeed"] = 0.3,
						["TextType"] = "Seconds",
						["HideText"] = 0,
					},
					["ButtonSkinOffset"] = 0,
					["anchor"] = {
						["dx"] = 3,
						["dy"] = -62,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["externalButtonSkin"] = "bs_default",
					["iconspy"] = 0,
					["nIcons"] = 10,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["owner"] = "decor",
					["playerauras"] = 1,
					["filterNameList"] = {
					},
					["size"] = 14,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["version"] = 1,
					["name"] = "ai1",
					["orientation"] = "RIGHT",
					["maxdurationfilter"] = "",
					["usebs"] = true,
					["unitfilter"] = "",
				}, -- [42]
				{
					["feature"] = "commentline",
				}, -- [43]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["h"] = "22",
					["version"] = 1,
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -26,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["flo"] = 3,
					["secure"] = 1,
					["name"] = "heal",
				}, -- [44]
				{
					["mover"] = 1,
					["w"] = "206",
					["feature"] = "hotspot",
					["h"] = "12",
					["name"] = "player",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -49,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [45]
				{
					["mover"] = 1,
					["w"] = "24",
					["feature"] = "hotspot",
					["h"] = "24",
					["name"] = "decurse",
					["hlt"] = {
						["blendMode"] = "ADD",
						["path"] = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "TOPRIGHT",
						["af"] = "Base",
					},
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
				}, -- [46]
			},
		},
		["Player_CastBar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_spellinfo",
					["raColor2"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["raColor4"] = {
						["a"] = 1,
						["b"] = 0.3,
						["g"] = 0.3,
						["r"] = 0.3,
					},
					["raColor3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0,
						["r"] = 0,
					},
					["raColor1"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 0,
					},
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
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "barColor",
					["colorVar1"] = "yellow",
					["condVar"] = "spell_channeled",
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
						["_border"] = "HalStraight",
						["edgeSize"] = 8,
						["kb"] = 0,
						["tile"] = false,
						["bg"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kr"] = 0,
						["ka"] = 0.4239999651908875,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["bb"] = 0,
						["kg"] = 0,
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
					["version"] = 1,
					["name"] = "highlight",
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
						["size"] = 10,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_subframe",
					},
					["h"] = "14",
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
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
				}, -- [13]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "subframe",
					["w"] = "20",
					["feature"] = "texture",
					["h"] = "20",
					["name"] = "spellIcon",
					["version"] = 1,
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
					["countTypeFlag"] = "spell_casting",
					["tex"] = "spell_icon",
					["txt"] = "spell_name_rank",
					["timerVar"] = "spell",
					["TEIExpireState"] = "Hide",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPRIGHT",
						["rp"] = "BOTTOMRIGHT",
						["af"] = "Frame_subframe",
					},
					["name"] = "infoText",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
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
				}, -- [17]
				{
					["feature"] = "shader_showhide",
					["owner"] = "subframe",
					["version"] = 1,
					["flag"] = "spell_castingOrChanneled",
				}, -- [18]
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
						["_border"] = "straight",
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
					["drawLayer"] = "ARTWORK",
					["owner"] = "sf_plife",
					["w"] = "200",
					["h"] = "21",
					["sublevel"] = 1,
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
					["drawLayer"] = "ARTWORK",
					["colorVar"] = "hostilityclassColor",
					["owner"] = "sf_life",
					["w"] = "200",
					["name"] = "sb_life",
					["feature"] = "statusbar_horiz",
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
						["ka"] = 0.7119999825954437,
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
					["name"] = "debuff",
					["size"] = 12,
					["orientation"] = "RIGHT",
					["version"] = 1,
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
					["owner"] = "decor",
					["w"] = "145",
					["flOffset"] = 1,
				}, -- [7]
				{
					["feature"] = "backdrop",
					["owner"] = "main",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.2749999761581421,
						["edgeSize"] = 8,
						["kb"] = 0,
						["kr"] = 0,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["kg"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
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
					["owner"] = "decor",
					["w"] = "144",
					["flOffset"] = 2,
				}, -- [14]
				{
					["feature"] = "txt_np",
					["h"] = "15",
					["name"] = "np",
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
						["sx"] = 1,
						["name"] = "Default",
						["sr"] = 0,
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
				}, -- [15]
				{
					["owner"] = "main2",
					["w"] = "35",
					["feature"] = "txt_status",
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
						["justifyH"] = "RIGHT",
						["sr"] = 0,
					},
					["version"] = 1,
					["anchor"] = {
						["dx"] = -4,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "RIGHT",
						["af"] = "Frame_main2",
					},
					["ty"] = "hpp",
					["h"] = "15",
					["name"] = "text_hp_percent",
				}, -- [16]
				{
					["feature"] = "commentline",
				}, -- [17]
				{
					["feature"] = "var_spellinfo",
					["raColor2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["raColor1"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
					["raColor3"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 1,
					},
					["raColor4"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
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
					["feature"] = "statusbar_horiz",
					["h"] = "7",
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0,
					},
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
					["h"] = "7",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -12,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_main2",
					},
					["font"] = {
						["size"] = 8,
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Bold.ttf",
						["justifyV"] = "CENTER",
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["title"] = "Default",
						["sb"] = 0,
						["justifyH"] = "CENTER",
						["sr"] = 0,
					},
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
					["TEIExpireState"] = "Hide",
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
					["texIcon"] = "",
					["tex"] = "",
					["txt"] = "spell_name_rank",
					["timerVar"] = "spell",
					["countTypeFlag"] = "true",
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
					["usebs"] = true,
					["nIcons"] = 12,
					["cdTxtType"] = "MinSec",
					["size"] = 10,
					["mindurationfilter"] = "",
					["auraType"] = "BUFFS",
					["cdHideTxt"] = "0",
					["owner"] = "decor",
					["playerauras"] = 1,
					["petauras"] = 1,
					["name"] = "debuffs",
					["cdoffx"] = 0,
					["version"] = 1,
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
					["orientation"] = "RIGHT",
					["filterNameList"] = {
					},
					["cdFont"] = {
						["title"] = "Default",
						["name"] = "Default",
						["justifyH"] = "LEFT",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 12,
					},
					["unitfilter"] = "",
				}, -- [25]
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
					["w"] = 320,
					["alpha"] = 1,
				}, -- [1]
				{
					["owner"] = "decor",
					["rows"] = 1,
					["feature"] = "menubar",
					["iconspx"] = -2,
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["orientation"] = "RIGHT",
					["name"] = "mbar",
					["iconspy"] = 0,
					["nIcons"] = 12,
				}, -- [2]
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
					["defaultbuttons"] = 1,
					["titleColor"] = {
						["a"] = 1,
						["r"] = 0.2941176470588235,
						["g"] = 0.3647058823529412,
						["b"] = 1,
					},
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
		["Shaman_Totems2"] = {
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
		["Meter_Heal_Done_sort"] = {
			["ty"] = "Sort",
			["version"] = 2,
			["data"] = {
				["sort"] = {
					{
						["vname"] = "cs8086490",
						["op"] = "tablemeter",
						["path"] = "WoWRDX:Meter_Heal_Done_tm",
					}, -- [1]
				},
				["set"] = {
					["class"] = "file",
					["file"] = "WoWRDX:Meter_Heal_Done_fset",
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
					["alpha"] = 1,
					["w"] = 30,
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
					["name"] = "unshiftedHlt",
					["version"] = 1,
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
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -2,
						["lp"] = "TOP",
						["rp"] = "TOP",
						["af"] = "Base",
					},
					["font"] = {
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "CENTER",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 6,
					},
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
					["version"] = 1,
					["name"] = "np",
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
		["Priest_Buff_Shadow_af"] = {
			["ty"] = "AuraFilter",
			["version"] = 1,
			["data"] = {
				79107, -- [1]
			},
		},
		["Interrupt_Shaman_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["1"] = {
					["action"] = "cast",
					["spell"] = 57994,
				},
			},
		},
		["Focustarget_Main"] = {
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
					["unit"] = "focustarget",
				}, -- [3]
				{
					["feature"] = "Event: Periodic Repaint",
					["interval"] = 0.1,
					["slot"] = "RepaintAll",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
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
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemEarthIcon",
					["sublevel"] = 1,
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
					["name"] = "earth",
					["secure"] = 1,
					["h"] = 36,
				}, -- [12]
				{
					["feature"] = "commentline",
				}, -- [13]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemFireIcon",
					["sublevel"] = 1,
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
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
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
					["name"] = "fire",
					["secure"] = 1,
					["h"] = 36,
				}, -- [18]
				{
					["feature"] = "commentline",
				}, -- [19]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemWaterIcon",
					["sublevel"] = 1,
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
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
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
					["timerVar"] = "totemwater",
					["TEIExpireState"] = "Hide",
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
					["name"] = "water",
					["secure"] = 1,
					["h"] = 36,
				}, -- [25]
				{
					["feature"] = "commentline",
				}, -- [26]
				{
					["cleanupPolicy"] = 3,
					["owner"] = "decor",
					["w"] = 36,
					["feature"] = "texture",
					["h"] = 36,
					["name"] = "TotemAirIcon",
					["sublevel"] = 1,
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
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
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
					["timerVar"] = "totemair",
					["TEIExpireState"] = "Hide",
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
					["name"] = "air",
					["secure"] = 1,
					["h"] = 36,
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
					["name"] = "remove",
					["secure"] = 1,
					["h"] = 12,
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
						["cb"] = 0.08235294117647057,
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["sy"] = 0,
						["sx"] = 0,
						["justifyH"] = "CENTER",
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
					["version"] = 1,
					["name"] = "rune1_tc",
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
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["justifyH"] = "CENTER",
						["cb"] = 0.08235294117647057,
						["ca"] = 1,
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
					["version"] = 1,
					["name"] = "rune2_tc",
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
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["justifyH"] = "CENTER",
						["cb"] = 0.08235294117647057,
						["ca"] = 1,
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
					["version"] = 1,
					["name"] = "rune3_tc",
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
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["name"] = "Default",
						["cb"] = 0.08235294117647057,
						["flags"] = "OUTLINE",
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
					["version"] = 1,
					["name"] = "rune4_tc",
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
						["cb"] = 0.08235294117647057,
						["flags"] = "OUTLINE",
						["cg"] = 0.7686274509803921,
						["justifyH"] = "CENTER",
						["sx"] = 0,
						["title"] = "Default",
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
					["version"] = 1,
					["name"] = "rune5_tc",
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
						["ca"] = 1,
						["cg"] = 0.7686274509803921,
						["title"] = "Default",
						["cb"] = 0.08235294117647057,
						["flags"] = "OUTLINE",
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
					["version"] = 1,
					["name"] = "rune6_tc",
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.3882352941176471,
						["title"] = "Default",
						["cb"] = 1,
						["sy"] = 0,
						["sx"] = 0,
						["ca"] = 1,
						["cr"] = 0.2980392156862745,
					},
					["anyup"] = 1,
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
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["barid"] = "bar4",
					["flo"] = 5,
					["fontkey"] = {
						["cr"] = 1,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["cb"] = 0.1058823529411765,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 10,
					},
					["fontmacro"] = {
						["size"] = 8,
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["ca"] = 1,
						["title"] = "Default",
						["cr"] = 1,
					},
					["owner"] = "Base",
					["headerstateCustom"] = "",
					["name"] = "barbut2",
					["flyoutdirection"] = "UP",
					["headerstateType"] = "None",
					["version"] = 1,
					["size"] = 36,
					["orientation"] = "DOWN",
					["usebs"] = true,
					["headervisType"] = "None",
					["hidebs"] = 1,
				}, -- [2]
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
					["feature"] = "Frame: Black",
					["title"] = "Rng 0-10",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
						["file"] = "default:Range_0_10_ODM_fset",
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
					["version"] = 1,
					["deathColor"] = {
						["a"] = 1,
						["b"] = 0.6000000000000001,
						["g"] = 0.3,
						["r"] = 0.6000000000000001,
					},
					["name"] = "rune_bar_skin",
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
				["pct"] = 1,
				["sv"] = 2,
				["max"] = {
					["qty"] = "smaxmp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Hunter_fset",
					},
				},
				["color"] = {
					["a"] = 1,
					["r"] = 0,
					["g"] = 0.5450980392156861,
					["b"] = 0.1019607843137255,
				},
				["val"] = {
					["qty"] = "smp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Hunter_fset",
					},
				},
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
					["rows"] = 1,
					["owner"] = "decor",
					["name"] = "rune_bar",
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
					["version"] = 1,
					["iconspy"] = 0,
					["nIcons"] = 6,
				}, -- [2]
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
				["color"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxhp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Healer_fset",
					},
				},
				["sv"] = 1,
				["texture"] = "",
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = "20",
					["spec"] = "{ title = \"Time\", width = 55, font = Fonts.Default10 },\n{ title = \"HP\", width = 50, font = Fonts.Default10 },\n{ title = \"Amt\", width = 50, font = Fonts.Default10 },\n{ title = \"Ability\", width = 180, font = Fonts.Default10 },\n{ title = \"Misc\", width = 55, font = Fonts.Default10 },\n\n\n\n",
					["name"] = "combatlogs",
				}, -- [2]
			},
		},
		["FactionBar"] = {
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
					["design"] = "WoWRDX:FactionBar_ds",
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
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["kb"] = 0,
						["kr"] = 0,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["edgeSize"] = 8,
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
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "lunar",
					["cd"] = 48518,
					["timer2"] = "0",
					["color3"] = {
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
					["feature"] = "Variables: Buffs Debuffs Info",
					["name"] = "solar",
					["cd"] = 48517,
					["timer2"] = "0",
					["color3"] = {
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
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "LunarColor",
					["colorVar1"] = "BlueColor",
					["condVar"] = "lunar_possible",
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
					["feature"] = "ColorVariable: Conditional Color",
					["name"] = "SolarColor",
					["colorVar1"] = "YellowColor",
					["condVar"] = "solar_possible",
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
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "RIGHT",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
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
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "CENTER",
						["af"] = "Base",
					},
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
					["feature"] = "Header Grid",
					["dxn"] = 1,
					["axis"] = 1,
					["bkt"] = 1,
					["cols"] = 40,
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
					["feature"] = "texture",
					["h"] = 19,
					["version"] = 1,
					["sublevel"] = 1,
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
					["name"] = "earth",
					["flo"] = 3,
					["secure"] = 1,
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
					["feature"] = "texture",
					["h"] = 19,
					["version"] = 1,
					["sublevel"] = 1,
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
					["h"] = 14,
					["version"] = 1,
					["anchor"] = {
						["dx"] = -5,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemFireBar",
					},
					["font"] = {
						["size"] = 9,
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemFireBar",
					},
					["name"] = "status_text_firea",
					["h"] = 14,
				}, -- [19]
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
						["dy"] = -20,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 20,
					["flo"] = 3,
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "TotemWaterIcon",
					["sublevel"] = 1,
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
						["title"] = "Default",
						["sb"] = 0,
						["name"] = "Default",
						["sy"] = -1,
						["sx"] = 1,
						["sr"] = 0,
					},
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
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "TotemWaterBar",
					},
					["name"] = "status_text_water",
					["h"] = 14,
				}, -- [26]
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
						["dy"] = -40,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["h"] = 20,
					["flo"] = 3,
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
					["feature"] = "texture",
					["h"] = 19,
					["version"] = 1,
					["sublevel"] = 1,
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
					["font"] = {
						["size"] = 9,
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
				}, -- [32]
				{
					["txt"] = "totemair_name",
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
					["name"] = "status_text_air",
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = 20,
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
					["version"] = 1,
					["flo"] = 3,
					["h"] = 80,
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
					["feature"] = "ColorVariable: Unit PowerType Color",
					["manaColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 0.75,
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
				}, -- [4]
				{
					["feature"] = "commentline",
				}, -- [5]
				{
					["ph"] = 1,
					["h"] = 14,
					["version"] = 1,
					["w"] = 90,
					["alpha"] = 1,
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
				}, -- [7]
				{
					["interpolate"] = 1,
					["owner"] = "Base",
					["w"] = "90",
					["colorVar"] = "powerColor",
					["feature"] = "statusbar_horiz",
					["h"] = "3",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "BOTTOMLEFT",
						["rp"] = "BOTTOMLEFT",
						["af"] = "Base",
					},
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
					["feature"] = "txt_np",
					["h"] = "14",
					["version"] = 1,
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
					["name"] = "text_hp_percent",
					["ty"] = "hpp",
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
					["name"] = "status_text",
					["ty"] = "fdld",
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
				}, -- [11]
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
		["Assists_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
				["S1"] = {
					["action"] = "assist",
				},
				["1"] = {
					["action"] = "target",
				},
				["2"] = {
					["action"] = "menu",
				},
			},
		},
		["Shaman_Totems3"] = {
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
		["Target_Debuff"] = {
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
					["design"] = "WoWRDX:Target_Debuff_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "target",
				}, -- [3]
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
					["feature"] = "Frame: Black",
					["title"] = "Rng 10-15",
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
						["file"] = "default:Range_0_15_ODM_fset",
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
		["Raid_Main_GroupAll"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
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
		["Player_SecureBuff_Bar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 150,
					["version"] = 1,
					["w"] = 200,
					["alpha"] = 1,
				}, -- [1]
				{
					["separateown"] = "NONE",
					["point"] = "TOPLEFT",
					["wrapafter"] = 10,
					["sortmethod"] = "INDEX",
					["feature"] = "sec_aura_bars",
					["showweapons"] = 1,
					["template"] = "RDXAB200x20Template",
					["auraType"] = "BUFFS",
					["owner"] = "Base",
					["name"] = "sab1",
					["sbtib"] = {
						["nametxt"] = {
							["flags"] = "OUTLINE",
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["borientation"] = "HORIZONTAL",
						["btype"] = "Frame",
						["w"] = 200,
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
						},
						["timetxt"] = {
							["flags"] = "OUTLINE",
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "RIGHT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["h"] = 20,
						["stacktxt"] = {
							["flags"] = "OUTLINE",
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 10,
						},
						["bkd"] = {
							["ka"] = 0.5279999673366547,
							["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
							["_backdrop"] = "solid",
							["tile"] = false,
							["kb"] = 1,
							["_border"] = "none",
							["kg"] = 0.6549019607843137,
							["kr"] = 0,
						},
						["banchor"] = "LEFT",
						["showicon"] = true,
						["showname"] = true,
						["iconposition"] = "LEFT",
					},
					["countTypeFlag"] = "false",
					["maxwraps"] = 2,
					["version"] = 1,
					["xoffset"] = 0,
					["orientation"] = "DOWN",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["yoffset"] = -2,
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
						["sx"] = 1,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["justifyH"] = "LEFT",
						["title"] = "Default",
						["size"] = 10,
					},
					["rows"] = 1,
					["filterNameList"] = {
					},
					["sbcolor"] = 1,
					["feature"] = "aura_bars2",
					["iconspx"] = 0,
					["unitfilter"] = "",
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
					["smooth"] = 1,
					["iconspy"] = 1,
					["nIcons"] = 10,
					["sbtexture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\TargetingFrame\\UI-StatusBar",
					},
					["h"] = "14",
					["mindurationfilter"] = 0,
					["sbfont"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\airstrip.ttf",
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
					["sbtimerfont"] = {
						["sr"] = 0,
						["face"] = "Interface\\Addons\\RDX_mediapack\\Fonts\\airstrip.ttf",
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
					["owner"] = "decor",
					["w"] = "90",
					["name"] = "ab1",
					["sbtib"] = {
						["nametxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "LEFT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["borientation"] = "HORIZONTAL",
						["btype"] = "Frame",
						["w"] = 220,
						["h"] = 20,
						["timetxt"] = {
							["name"] = "Default",
							["title"] = "Default",
							["justifyH"] = "RIGHT",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
							["justifyV"] = "CENTER",
							["size"] = 9,
						},
						["btexture"] = {
							["blendMode"] = "BLEND",
							["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
						},
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
					["feature"] = "Frame: Default",
					["title"] = "Rez Monitor",
					["bkd"] = {
						["bgFile"] = "Interface\\DialogFrame\\UI-DialogBox-Background",
						["tileSize"] = 16,
						["tile"] = true,
						["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
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
		["Noop_mb"] = {
			["ty"] = "MouseBindings",
			["version"] = 1,
			["data"] = {
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
					["version"] = 1,
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
					["name"] = "texcd_earth",
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
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
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
					["version"] = 1,
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
					["name"] = "texcd_Fire",
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
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
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
					["version"] = 1,
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
					["name"] = "texcd_water",
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
					["version"] = 1,
					["secure"] = 1,
					["flo"] = 3,
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
					["version"] = 1,
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
					["name"] = "texcd_air",
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
					["version"] = 1,
					["secure"] = 1,
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
						["dx"] = 36,
						["dy"] = -36,
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
					["version"] = 1,
					["deathColor"] = {
						["a"] = 1,
						["b"] = 0.6000000000000001,
						["g"] = 0.3,
						["r"] = 0.6000000000000001,
					},
					["name"] = "rune_bar_skin",
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
					["interpolate"] = 1,
					["owner"] = "pdt",
					["w"] = "BaseWidth",
					["h"] = "12",
					["feature"] = "statusbar_horiz",
					["colorVar"] = "red",
					["version"] = 1,
					["frac"] = "fthreat",
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
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["name"] = "Default",
						["sy"] = -1,
						["justifyH"] = "LEFT",
						["size"] = 10,
					},
					["classColor"] = 1,
					["name"] = "np",
				}, -- [6]
				{
					["txt"] = "threat_info",
					["owner"] = "pdt",
					["w"] = "40",
					["feature"] = "txt_dyn",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "RIGHT",
						["af"] = "Text_np",
					},
					["name"] = "infothreat",
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
				}, -- [7]
				{
					["txt"] = "threat_value",
					["owner"] = "pdt",
					["w"] = "80",
					["feature"] = "txt_dyn",
					["h"] = "12",
					["version"] = 1,
					["anchor"] = {
						["dx"] = -2,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "RIGHT",
						["af"] = "Text_infothreat",
					},
					["name"] = "infoText",
					["font"] = {
						["size"] = 10,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
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
		["Shaman_Totems1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 14,
					["version"] = 1,
					["w"] = 180,
					["alpha"] = 1,
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
					["h"] = "14",
					["name"] = "earth_s",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "46",
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
					["owner"] = "earth_s",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.25,
						["edgeSize"] = 4,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_border"] = "HalStraightwotlk",
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorderWOTLK",
						["bb"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["br"] = 0,
						["insets"] = {
							["top"] = 1,
							["right"] = 1,
							["left"] = 1,
							["bottom"] = 1,
						},
					},
				}, -- [9]
				{
					["frac"] = "",
					["feature"] = "statusbar_horiz",
					["owner"] = "decor",
					["w"] = "42",
					["h"] = "12",
					["drawLayer"] = "ARTWORK",
					["colorVar"] = "green",
					["name"] = "TotemEarthBar",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 2,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_earth_s",
					},
					["orientation"] = "HORIZONTAL",
					["sublevel"] = 1,
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour3",
					},
				}, -- [10]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "10",
					["feature"] = "texture",
					["h"] = "10",
					["version"] = 1,
					["name"] = "EarthTex",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Frame_earth_s",
					},
					["sublevel"] = 2,
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
				}, -- [11]
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
					["text"] = "",
					["texIcon"] = "EarthTex",
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
				}, -- [12]
				{
					["gt"] = "earth_Totem",
					["owner"] = "decor",
					["w"] = "46",
					["feature"] = "artbutton",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_earth_s",
					},
					["name"] = "EarthBtn",
					["editor"] = "DestroyTotem(2);",
				}, -- [13]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [14]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "fire_s",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "46",
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_earth_s",
					},
				}, -- [15]
				{
					["feature"] = "backdrop",
					["owner"] = "fire_s",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "HalStraightwotlk",
						["edgeSize"] = 4,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["ka"] = 0.25,
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorderWOTLK",
						["_backdrop"] = "solid",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["br"] = 0,
						["insets"] = {
							["top"] = 1,
							["right"] = 1,
							["left"] = 1,
							["bottom"] = 1,
						},
					},
				}, -- [16]
				{
					["frac"] = "",
					["sublevel"] = 1,
					["owner"] = "decor",
					["w"] = "42",
					["h"] = "12",
					["drawLayer"] = "ARTWORK",
					["colorVar"] = "red",
					["name"] = "TotemFireBar",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_fire_s",
					},
					["orientation"] = "HORIZONTAL",
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour3",
					},
				}, -- [17]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "10",
					["feature"] = "texture",
					["h"] = "10",
					["version"] = 1,
					["name"] = "FireTex",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Frame_fire_s",
					},
					["drawLayer"] = "ARTWORK",
					["sublevel"] = 2,
					["texture"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["blendMode"] = "BLEND",
					},
				}, -- [18]
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
					["text"] = "",
					["texIcon"] = "FireTex",
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
				}, -- [19]
				{
					["gt"] = "fire_Totem",
					["owner"] = "decor",
					["w"] = "46",
					["feature"] = "artbutton",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_fire_s",
					},
					["name"] = "FireBtn",
					["editor"] = "DestroyTotem(1);",
				}, -- [20]
				{
					["feature"] = "commentline",
					["version"] = 1,
					["name"] = "",
				}, -- [21]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "water_s",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "46",
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_fire_s",
					},
				}, -- [22]
				{
					["feature"] = "backdrop",
					["owner"] = "water_s",
					["version"] = 1,
					["bkd"] = {
						["ka"] = 0.25,
						["edgeSize"] = 4,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["_border"] = "HalStraightwotlk",
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorderWOTLK",
						["bb"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["br"] = 0,
						["insets"] = {
							["top"] = 1,
							["right"] = 1,
							["left"] = 1,
							["bottom"] = 1,
						},
					},
				}, -- [23]
				{
					["frac"] = "",
					["sublevel"] = 1,
					["owner"] = "decor",
					["w"] = "42",
					["h"] = "12",
					["drawLayer"] = "ARTWORK",
					["colorVar"] = "blue",
					["name"] = "TotemWaterBar",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_water_s",
					},
					["orientation"] = "HORIZONTAL",
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour3",
					},
				}, -- [24]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "10",
					["feature"] = "texture",
					["h"] = "10",
					["name"] = "WaterTex",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Frame_water_s",
					},
					["sublevel"] = 2,
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
				}, -- [25]
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
					["text"] = "",
					["texIcon"] = "WaterTex",
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
				}, -- [26]
				{
					["gt"] = "water_Totem",
					["owner"] = "decor",
					["w"] = "46",
					["feature"] = "artbutton",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_water_s",
					},
					["name"] = "WaterBtn",
					["editor"] = "DestroyTotem(3);",
				}, -- [27]
				{
					["feature"] = "commentline",
				}, -- [28]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "air_s",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "46",
					["anchor"] = {
						["dx"] = -1,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPRIGHT",
						["af"] = "Frame_water_s",
					},
				}, -- [29]
				{
					["feature"] = "backdrop",
					["owner"] = "air_s",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "HalStraightwotlk",
						["edgeSize"] = 4,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["ka"] = 0.25,
						["ba"] = 1,
						["bb"] = 0,
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorderWOTLK",
						["_backdrop"] = "solid",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["br"] = 0,
						["insets"] = {
							["top"] = 1,
							["right"] = 1,
							["left"] = 1,
							["bottom"] = 1,
						},
					},
				}, -- [30]
				{
					["frac"] = "",
					["drawLayer"] = "ARTWORK",
					["owner"] = "decor",
					["w"] = "42",
					["h"] = "12",
					["sublevel"] = 1,
					["colorVar"] = "yellow",
					["name"] = "TotemAirBar",
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = -1,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_air_s",
					},
					["version"] = 1,
					["feature"] = "statusbar_horiz",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\statusbars\\Glamour3",
					},
				}, -- [31]
				{
					["cleanupPolicy"] = 1,
					["owner"] = "decor",
					["w"] = "10",
					["feature"] = "texture",
					["h"] = "10",
					["name"] = "AirTex",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "CENTER",
						["rp"] = "CENTER",
						["af"] = "Frame_air_s",
					},
					["sublevel"] = 2,
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
				}, -- [32]
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
					["text"] = "",
					["texIcon"] = "AirTex",
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
				}, -- [33]
				{
					["gt"] = "air_Totem",
					["owner"] = "decor",
					["w"] = "46",
					["feature"] = "artbutton",
					["h"] = "14",
					["version"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_air_s",
					},
					["name"] = "AirBtn",
					["editor"] = "DestroyTotem(4);",
				}, -- [34]
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
					["feature"] = "statusbar_horiz",
					["h"] = 19,
					["version"] = 1,
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune1_tex",
					["sublevel"] = 1,
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
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["title"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "RIGHT",
						["name"] = "Default",
						["size"] = 9,
					},
					["name"] = "rune1_timer",
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
					["texIcon"] = "rune1_tex",
					["TL"] = 0,
					["text"] = "rune1_timer",
					["sbblendcolor"] = 1,
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["countTypeFlag"] = "true",
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["tex"] = "rune1_icon",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["timerVar"] = "rune1",
					["statusBar"] = "rune1_bar",
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
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["h"] = 19,
					["version"] = 1,
					["feature"] = "statusbar_horiz",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune2_tex",
					["sublevel"] = 1,
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
				}, -- [17]
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
					["sbcolorVar2"] = "rune2_color",
					["countTypeFlag"] = "true",
					["text"] = "rune2_timer",
					["tex"] = "rune2_icon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timerVar"] = "rune2",
					["txt"] = "rune2_name",
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
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["h"] = 19,
					["version"] = 1,
					["feature"] = "statusbar_horiz",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune3_tex",
					["sublevel"] = 1,
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
				}, -- [25]
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
					["sbcolorVar2"] = "rune3_color",
					["countTypeFlag"] = "true",
					["text"] = "rune3_timer",
					["tex"] = "rune3_icon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timerVar"] = "rune3",
					["txt"] = "rune3_name",
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
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["h"] = 19,
					["version"] = 1,
					["feature"] = "statusbar_horiz",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune4_tex",
					["sublevel"] = 1,
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
				}, -- [33]
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
					["sbcolorVar2"] = "rune4_color",
					["countTypeFlag"] = "true",
					["text"] = "rune4_timer",
					["tex"] = "rune4_icon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timerVar"] = "rune4",
					["txt"] = "rune4_name",
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
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["h"] = 19,
					["version"] = 1,
					["feature"] = "statusbar_horiz",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune5_tex",
					["sublevel"] = 1,
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
				}, -- [41]
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
					["sbcolorVar2"] = "rune5_color",
					["countTypeFlag"] = "true",
					["text"] = "rune5_timer",
					["tex"] = "rune5_icon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timerVar"] = "rune5",
					["txt"] = "rune5_name",
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
					["color2"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["h"] = 19,
					["version"] = 1,
					["feature"] = "statusbar_horiz",
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
					["feature"] = "texture",
					["h"] = 19,
					["name"] = "rune6_tex",
					["sublevel"] = 1,
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
				}, -- [49]
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
					["sbcolorVar2"] = "rune6_color",
					["countTypeFlag"] = "true",
					["text"] = "rune6_timer",
					["tex"] = "rune6_icon",
					["TEIExpireState"] = "Hide",
					["color2"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["TL"] = 0,
					["version"] = 1,
					["sbcolorVar1"] = "alpha",
					["sbblendcolor"] = 1,
					["color1"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["timerVar"] = "rune6",
					["txt"] = "rune6_name",
				}, -- [51]
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
				["color"] = {
					["a"] = 1,
					["r"] = 0.02352941176470588,
					["g"] = 0.5254901960784313,
					["b"] = 0,
				},
				["pct"] = 1,
				["max"] = {
					["qty"] = "smaxhp",
					["set"] = {
						["class"] = "file",
						["file"] = "WoWRDX:Tank_fset",
					},
				},
				["sv"] = 1,
				["texture"] = "",
			},
		},
		["Raid_Main_Group4"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							[4] = true,
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["version"] = 1,
					["dpm1"] = 0,
					["period"] = 0.1,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
			},
		},
		["Meter_Heal_Done_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"nidmask", -- [1]
				}, -- [2]
				{
					"tablemeter", -- [1]
					"WoWRDX:Meter_Heal_Done_tm", -- [2]
					1, -- [3]
					10000000, -- [4]
				}, -- [3]
			},
		},
		["MainMenu"] = {
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
					["design"] = "WoWRDX:MainMenu_ds",
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
						["flags"] = "THICKOUTLINE",
						["cg"] = 0.3882352941176471,
						["title"] = "Default",
						["cb"] = 1,
						["sy"] = 0,
						["sx"] = 0,
						["ca"] = 1,
						["cr"] = 0.2980392156862745,
					},
					["anyup"] = 1,
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
					["externalButtonSkin"] = "bs_simplesquare",
					["iconspy"] = 0,
					["nIcons"] = 12,
					["showkey"] = 1,
					["barid"] = "bar3",
					["flo"] = 5,
					["fontkey"] = {
						["cr"] = 1,
						["flags"] = "THICKOUTLINE",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf",
						["justifyV"] = "TOP",
						["cb"] = 0.1058823529411765,
						["ca"] = 1,
						["cg"] = 0.6588235294117647,
						["name"] = "Default",
						["sx"] = 0,
						["justifyH"] = "RIGHT",
						["sy"] = 0,
						["title"] = "Default",
						["size"] = 10,
					},
					["fontmacro"] = {
						["size"] = 8,
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["flags"] = "OUTLINE",
						["cg"] = 0.3568627450980392,
						["justifyH"] = "RIGHT",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["ca"] = 1,
						["title"] = "Default",
						["cr"] = 1,
					},
					["owner"] = "Base",
					["headerstateCustom"] = "",
					["name"] = "barbut2",
					["flyoutdirection"] = "UP",
					["headerstateType"] = "None",
					["version"] = 1,
					["size"] = 36,
					["orientation"] = "DOWN",
					["usebs"] = true,
					["headervisType"] = "None",
					["hidebs"] = 1,
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
					["interval"] = 0.3,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [7]
				{
					["feature"] = "Description",
					["description"] = "Mana statistics",
				}, -- [8]
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
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
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
				}, -- [2]
				{
					["feature"] = "Design",
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
					["axis"] = 1,
					["cols"] = 1,
					["dxn"] = 1,
				}, -- [5]
				{
					["interval"] = 0.10000000149012,
					["feature"] = "Event: Periodic Repaint",
					["slot"] = "RepaintAll",
				}, -- [6]
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
						["flags"] = "THICKOUTLINE",
						["sg"] = 0,
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["sx"] = 1,
						["sa"] = 1,
						["sr"] = 0,
					},
					["feature"] = "aura_icons",
					["iconspx"] = 3,
					["cd"] = {
						["HideText"] = 0,
						["Font"] = {
							["cr"] = 1,
							["justifyH"] = "CENTER",
							["face"] = "Interface\\Addons\\VFL\\Fonts\\bs.ttf",
							["justifyV"] = "CENTER",
							["cb"] = 0.1333333333333333,
							["flags"] = "OUTLINE",
							["cg"] = 0.7372549019607844,
							["sy"] = 0,
							["sx"] = 0,
							["name"] = "Default",
							["ca"] = 1,
							["title"] = "Default",
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
					["usebs"] = true,
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
		["ClassBar_ds"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["DEATHKNIGHT"] = "WoWRDX:Deathknight_Runes1_ds",
				["SHAMAN"] = "WoWRDX:Shaman_Totems1_ds",
				["class"] = "class&form",
				["WARLOCK"] = "WoWRDX:Warlock_Shards_ds",
				["ROGUE"] = "WoWRDX:Rogue_Combo_ds",
				["DRUIDELEM"] = "WoWRDX:Druid_EclipseBar_ds",
				["all"] = "WoWRDX:ClassBarDefault_ds",
				["DRUIDCAT"] = "WoWRDX:Rogue_Combo_ds",
				["PALADIN"] = "WoWRDX:Paladin_HolyPower_ds",
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
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [6]
			},
		},
		["Shaman_Totems8"] = {
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
					["bkd"] = {
						["_border"] = "none",
						["_backdrop"] = "none",
					},
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
		["Meter_Overheal_Done_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "var_tablemeter",
					["name"] = "combatmeter1",
					["tablemeter"] = "WoWRDX:Meter_Overheal_Done_tm",
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
						["name"] = "Default",
						["sy"] = -1,
						["cg"] = 1,
						["sx"] = 1,
						["face"] = "Fonts\\ARIALN.TTF",
						["justifyV"] = "CENTER",
						["title"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "RIGHT",
						["sb"] = 0,
						["ca"] = 1,
						["sr"] = 0,
						["cb"] = 1,
						["cr"] = 1,
					},
				}, -- [7]
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
						["file"] = "default:Range_40plus_fset",
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
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [6]
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
		["ChatFrame1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 180,
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
					["name"] = "cf1",
					["channel"] = 1,
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["version"] = 1,
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
						["size"] = 12,
					},
				}, -- [2]
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
		["infoVersion"] = "1.0.0",
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
					["owner"] = "decor",
					["mindurationfilter"] = 0,
					["sbtib"] = {
						["nametxt"] = {
							["flags"] = "OUTLINE",
							["name"] = "Default",
							["title"] = "Default",
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
							["_border"] = "none",
							["_backdrop"] = "none",
						},
						["timetxt"] = {
							["flags"] = "OUTLINE",
							["name"] = "Default",
							["title"] = "Default",
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
		["Deathknight_Runes8"] = {
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
					["design"] = "WoWRDX:Deathknight_Runes8_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		},
		["Buff_mb"] = {
			["ty"] = "SymLink",
			["version"] = 3,
			["data"] = {
				["targetpath_5"] = "WoWRDX:Buff_Warrior_mb",
				["class"] = "class",
				["targetpath_7"] = "WoWRDX:Buff_Mage_mb",
				["targetpath_8"] = "WoWRDX:Noop_mb",
				["targetpath_2"] = "WoWRDX:Buff_Druid_mb",
				["targetpath_3"] = "WoWRDX:Buff_Paladin_mb",
				["targetpath_4"] = "WoWRDX:Noop_mb",
				["targetpath_1"] = "WoWRDX:Buff_Priest_mb",
				["targetpath_10"] = "WoWRDX:Noop_mb",
				["targetpath_9"] = "WoWRDX:Noop_mb",
				["targetpath_6"] = "WoWRDX:Noop_mb",
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
					["version"] = 1,
					["clickable"] = 1,
					["unit"] = "target",
				}, -- [3]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "dmg",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_dmg",
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "target",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_target",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "interrupt",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Interrupt_mb",
				}, -- [6]
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
					["cd"] = 79105,
					["timer1"] = "0",
					["timer2"] = "0",
					["name"] = "aurai",
					["feature"] = "Variables: Buffs Debuffs Info",
					["color0"] = {
						["a"] = 0,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0,
					},
					["color3"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
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
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
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
						["title"] = "Default",
						["sb"] = 0,
						["sy"] = -1,
						["name"] = "Default",
						["justifyH"] = "LEFT",
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
					["version"] = 1,
					["name"] = "tex_range",
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
					["flag"] = "true",
					["feature"] = "Highlight: Texture Map",
					["color"] = "range",
					["texture"] = "tex_range",
				}, -- [17]
			},
		},
		["Player_Alternate_Bar_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "Variable: Fractional mana (fm)",
					["powertype"] = "ALTERNATE_POWER_INDEX",
					["name"] = "fm",
				}, -- [1]
				{
					["feature"] = "base_default",
					["h"] = 28,
					["version"] = 1,
					["w"] = 120,
					["alpha"] = 1,
				}, -- [2]
				{
					["feature"] = "Subframe",
					["h"] = "14",
					["name"] = "subframe",
					["flOffset"] = 1,
					["owner"] = "decor",
					["w"] = "120",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -14,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
				}, -- [3]
				{
					["feature"] = "backdrop",
					["owner"] = "subframe",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "fer1",
						["edgeSize"] = 8,
						["tile"] = false,
						["kb"] = 0,
						["bg"] = 0,
						["kg"] = 0,
						["kr"] = 0,
						["ka"] = 0.2,
						["ba"] = 1,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\Ferous\\Borders\\fer1",
						["bb"] = 0,
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["br"] = 0,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
				}, -- [4]
				{
					["interpolate"] = 1,
					["sublevel"] = 1,
					["color2"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0,
						["b"] = 1,
					},
					["name"] = "alternateBar",
					["owner"] = "decor",
					["w"] = "116",
					["color1"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["drawLayer"] = "ARTWORK",
					["h"] = "10",
					["version"] = 1,
					["orientation"] = "HORIZONTAL",
					["anchor"] = {
						["dx"] = 1,
						["dy"] = 0,
						["lp"] = "LEFT",
						["rp"] = "LEFT",
						["af"] = "Frame_subframe",
					},
					["feature"] = "statusbar_horiz",
					["frac"] = "1",
					["texture"] = {
						["blendMode"] = "BLEND",
						["path"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalU",
					},
				}, -- [5]
				{
					["feature"] = "txt_np",
					["font"] = {
						["flags"] = "OUTLINE",
						["name"] = "Default",
						["title"] = "Default",
						["justifyH"] = "LEFT",
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["size"] = 10,
					},
					["version"] = 1,
					["name"] = "np",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["owner"] = "decor",
					["w"] = "120",
					["h"] = "14",
				}, -- [6]
			},
		},
		["Raid_Main_Group1"] = {
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
					["design"] = "WoWRDX:Raid_Main_ds",
				}, -- [2]
				{
					["feature"] = "header",
					["version"] = 1,
					["header"] = {
						["frameAnchor"] = "TOP",
						["w"] = 1,
						["sortType"] = 1,
						["classes"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
							true, -- [4]
							true, -- [5]
							true, -- [6]
							true, -- [7]
							true, -- [8]
							true, -- [9]
							true, -- [10]
						},
						["driver"] = 2,
						["colAnchor"] = "LEFT",
						["groupType"] = 1,
						["padding"] = 0,
						["groups"] = {
							true, -- [1]
						},
						["switchvehicle"] = 1,
					},
				}, -- [3]
				{
					["feature"] = "mp_args",
					["period"] = 0.1,
					["version"] = 1,
					["dpm1"] = 0,
				}, -- [4]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "heal",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_heal",
				}, -- [5]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "player",
					["version"] = 1,
					["mbFriendly"] = "default:bindings_player",
				}, -- [6]
				{
					["feature"] = "mousebindings",
					["hotspot"] = "decurse",
					["version"] = 1,
					["mbFriendly"] = "WoWRDX:Decurse_mb",
				}, -- [7]
			},
		},
	},
-- End Export Data for win_DispelGrid
-- End RDX Data Export
        };
});
