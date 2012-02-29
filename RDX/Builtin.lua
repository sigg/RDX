-- Builtin.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- A few useful built-in structures.

-- 34721, -- Frostweave Bandage
-- 34722, -- Heavy Frostweave Bandage

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()

	local default = RDXDB.GetOrCreatePackage("default");
	if not default["autodesk"] then
		default["autodesk"] = {
			["ty"] = "Desktop",
			["version"] = 2,
			["data"] = {
				{
					["strata"] = "LOW",
					["b"] = 0,
					["anchorxrid"] = 255.4666801982218,
					["uiscale"] = 0.8533333539962769,
					["dgp"] = true,
					["resolution"] = "1600",
					["feature"] = "Desktop main",
					["offsetbottom"] = 0,
					["bkd"] = {
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\a80black",
						["tileSize"] = 16,
						["tile"] = true,
						["edgeFile"] = "Interface\\Addons\\VFL\\Skin\\HalBorder",
						["edgeSize"] = 8,
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
					["l"] = 0,
					["offsettop"] = 0,
					["scale"] = 1,
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "default:ActionBar1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -10,
						},
						["BOTTOMLEFT"] = {
							["id"] = "default:ChatFrame1",
							["x"] = -10,
							["point"] = "BOTTOMLEFT",
							["y"] = -10,
						},
					},
					["offsetleft"] = 0,
					["offsetright"] = 0,
					["r"] = 1365.333426704711,
					["root"] = true,
					["t"] = 767.9999824928667,
					["alpha"] = 1,
					["anchoryrid"] = 465.386732369479,
					["title"] = "updated",
					["font"] = {
						["title"] = "Default 10pt",
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["name"] = "Default10",
						["size"] = 10,
					},
					["name"] = "root",
					["open"] = true,
					["tex"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["path"] = "Interface\\Addons\\RDX\\Skin\\bar1",
						["blendMode"] = "BLEND",
					},
					["anchorx"] = 285.333341904534,
					["anchory"] = 320.3201048020767,
					["ap"] = "TOPLEFT",
				}, -- [1]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "root",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 10,
						},
					},
					["scale"] = 1,
					["t"] = 39.25338038594755,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "default:ActionBar1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 8.533333656676994,
					["r"] = 866.9866965304984,
				}, -- [2]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOM"] = {
							["id"] = "default:ChatFrame1",
							["x"] = 0,
							["point"] = "TOP",
							["y"] = 0,
						},
					},
					["scale"] = 1,
					["t"] = 187.7333479166043,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "default:ChatEditBox1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 8.533303777835435,
					["b"] = 162.1333506814285,
					["r"] = 349.866743416295,
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["TOP"] = {
							["id"] = "default:ChatEditBox1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = 0,
						},
						["BOTTOMLEFT"] = {
							["id"] = "root",
							["x"] = 10,
							["point"] = "BOTTOMLEFT",
							["y"] = 10,
						},
					},
					["scale"] = 1,
					["t"] = 162.1333506814285,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "default:ChatFrame1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 8.533333656676994,
					["b"] = 8.533333656676994,
					["r"] = 349.8667135374535,
				}, -- [4]
			},
		};
	end
	
	if not default["assists"] then
		default["assists"] = {
			["ty"] = "NominativeSet",
			["version"] = 1,
			["data"] = {},
		};
	end

	if not default["Health_ds"] then
		default["Health_ds"] = {
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
					["feature"] = "base_default",
					["w"] = 90,
					["alpha"] = 1,
					["ph"] = true,
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
		};
	end
	if not default["Logs_Me_tl"] then
		default["Logs_Me_tl"] = {
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
		};
	end
	
	if not default["Party_with_me_fset"] then
		default["Party_with_me_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"mygroup", -- [1]
				}, -- [2]
			},
		};
	end
	
	if not default["Party_without_me_fset"] then
		default["Party_without_me_fset"] = {
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
		};
	end
	
	if not default["Arena_fset"] then
		default["Arena_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"arena", -- [1]
				true, -- [2]
				true, -- [3]
			},
		};
	end
	
	if not default["Boss_fset"] then
		default["Boss_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"boss", -- [1]
			},
		};
	end

	if not default["Not_Dead_fset"] then
		default["Not_Dead_fset"] = {
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
		};
	end
	
	if not default["Dead_fset"] then
		default["Dead_fset"] = {
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
		};
	end
	
	if not default["Raid_needsHeals_fset"] then
		default["Raid_needsHeals_fset"] = {
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
		};
	end
	
	if not default["ClassBarDefault_ds"] then
		default["ClassBarDefault_ds"] = {
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
		};
	end
	
	-- action bar and chatframes
	if not default["ChatEditBox1_ds"] then
		default["ChatEditBox1_ds"] = {
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
		};
	end
	
	if not default["ChatEditBox1"] then
		default["ChatEditBox1"] = {
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
					["design"] = "default:ChatEditBox1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		};
	end
	
	if not default["ActionBar1"] then
		default["ActionBar1"] = {
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
					["design"] = "default:ActionBar1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		};
	end
	
	if not default["ActionBar1_ds"] then
		default["ActionBar1_ds"] = {
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
					["externalButtonSkin"] = "bs_simplesquare",
					["showtooltip"] = 1,
					["flo"] = 5,
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
					["nIcons"] = 12,
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
					["size"] = 36,
					["showkey"] = 1,
					["barid"] = "mainbar1",
					["usebs"] = true,
					["bkd"] = {
						["ka"] = 1,
						["kg"] = 0.1,
						["kb"] = 0.1,
						["kr"] = 0.1,
						["tile"] = false,
						["_backdrop"] = "solid",
						["edgeFile"] = "Interface\\AddOns\\RDX_mediapack\\sharedmedia\\borders\\IshBorder",
						["bgFile"] = "Interface\\Addons\\VFL\\Skin\\white",
						["_border"] = "IshBorder",
						["edgeSize"] = 12,
						["insets"] = {
							["top"] = 4,
							["right"] = 4,
							["left"] = 4,
							["bottom"] = 4,
						},
					},
					["name"] = "barbut1",
					["owner"] = "Base",
					["headerstateCustom"] = "",
					["headerstateType"] = "Defaultui",
					["flyoutdirection"] = "UP",
					["headervisiCustom"] = "",
					["version"] = 1,
					["fontmacro"] = {
						["size"] = 8,
						["name"] = "Default",
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "BOTTOM",
						["sx"] = 0,
						["ca"] = 1,
						["cg"] = 0.3568627450980392,
						["title"] = "Default",
						["cb"] = 0.8901960784313725,
						["sy"] = 0,
						["flags"] = "OUTLINE",
						["justifyH"] = "RIGHT",
						["cr"] = 1,
					},
					["orientation"] = "RIGHT",
					["anyup"] = 1,
					["headervisType"] = "None",
					["headervisiType"] = "None",
				}, -- [2]
			},
		};
	end
	
	if not default["ChatFrame1_ds"] then
		default["ChatFrame1_ds"] = {
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
						["name"] = "Default",
						["sa"] = 1,
						["sg"] = 0,
						["justifyH"] = "LEFT",
						["sb"] = 0,
						["sx"] = 1,
						["sy"] = -1,
						["title"] = "Default",
						["size"] = 12,
					},
				}, -- [2]
			},
		};
	end
	
	if not default["ChatFrame1"] then
		default["ChatFrame1"] = {
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
					["design"] = "default:ChatFrame1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		};
	end
	
	-- range
	if not default["Range_0_10_fset"] then
		default["Range_0_10_fset"] = {
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
		};
	end
	
	if not default["Range_0_10_ODM_fset"] then
		default["Range_0_10_ODM_fset"] = {
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
		};
	end
	
	if not default["Range_40plus_fset"] then
		default["Range_40plus_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "default:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "default:Range_15_30_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "default:Range_30_40_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"ol", -- [1]
				}, -- [5]
			},
		};
	end
	
	if not default["Range_0_70_fset"] then
		default["Range_0_70_fset"] = {
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
		};
	end
	
	if not default["Range_0_15_ODM_fset"] then
		default["Range_0_15_ODM_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["file"] = "default:Range_0_15_fset",
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
		};
	end
	
	if not default["Range_not_0_30_dead_fset"] then
		default["Range_not_0_30_dead_fset"] = {
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
		};
	end
	
	if not default["Range_70plus_fset"] then
		default["Range_70plus_fset"] = {
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
		};
	end
	
	if not default["Range_0_30_fset"] then
		default["Range_0_30_fset"] = {
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
		};
	end
	
	if not default["Range_0_15_fset"] then
		default["Range_0_15_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["item"] = 34722,
						["class"] = "itemrange",
					}, -- [2]
				}, -- [2]
				{
					"ol", -- [1]
				}, -- [3]
			},
		};
	end
	
	if not default["Range_15_30_fset"] then
		default["Range_15_30_fset"] = {
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
							["file"] = "default:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
			},
		};
	end
	
	if not default["Range_40_70_fset"] then
		default["Range_40_70_fset"] = {
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
							["file"] = "default:Range_0_40_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
			},
		};
	end
	
	if not default["Range_0_40_fset"] then
		default["Range_0_40_fset"] = {
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
		};
	end
	
	if not default["Range_30_40_fset"] then
		default["Range_30_40_fset"] = {
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
							["file"] = "default:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "default:Range_15_30_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [4]
				{
					"ol", -- [1]
				}, -- [5]
			},
		};
	end
	
	if not default["Range_10_15_fset"] then
		default["Range_10_15_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"and", -- [1]
				{
					"set", -- [1]
					{
						["item"] = 34722,
						["class"] = "itemrange",
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "default:Range_0_10_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"ol", -- [1]
				}, -- [4]
			},
		};
	end
	
	if not default["Range_30plus_fset"] then
		default["Range_30plus_fset"] = {
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
		};
	end
	
end);

--------------------------------------
-- Builtin default mouse bindings
--------------------------------------

local function heal_default()
	local _,class = UnitClass("player");
	local ret = nil;
	if class == "PRIEST" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 2061,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 17,
		    },
		};
	elseif class == "DRUID" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 5185,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 774,
		    },
		};
	elseif class == "PALADIN" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 635,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 19750,
		    },
		};
	elseif class == "SHAMAN" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 331,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 8004,
		    },
		};
	elseif class == "MAGE" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 54646,
		    },
		};
	elseif class == "HUNTER" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 34477,
		    },
		};
	elseif class == "WARRIOR" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 3411,
		    },
		};
	elseif class == "WARLOCK" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 80398,
		    },
		};
	elseif class == "DEATHKNIGHT" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 47541,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 47541,
		    },
		};
	elseif class == "ROGUE" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 57934,
		    },
		};
	else
		ret = {};
	end
	return ret;
end

local function dmg_default()
	local _,class = UnitClass("player");
	local ret = nil;
	if class == "PRIEST" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 585,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 8092,
		    },
		};
	elseif class == "DRUID" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 5176,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 8921,
		    },
		};
	elseif class == "PALADIN" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 879,
		    },
		};
	elseif class == "SHAMAN" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 403,
		    },
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 421,
		    },
		};
	elseif class == "MAGE" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 133,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 116,
		    },
		};
	elseif class == "HUNTER" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 56641,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 5116,
		    },
		};
	elseif class == "WARRIOR" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 1464,
		    },
		};
	elseif class == "WARLOCK" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 686,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 348,
		    },
		};
	elseif class == "DEATHKNIGHT" then
		ret = {
		    ["1"] = {
			["action"] = "cast",
			["spell"] = 47541,
		    },
		    ["2"] = {
			["action"] = "cast",
			["spell"] = 77575,
		    },
		};
	else
		ret = {};
	end
	return ret;
end




RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	--
	-- Create player-talent-specific bindings if they don't exist
	-- default:bindings_player
	-- type talent&name&realm
	
	local mbo = RDXDB.TouchObject("default:bindings_player_" .. RDX.pspace .. "1");
	if not mbo.data then
		mbo.data = {
			["1"] = {
			    ["action"] = "target",
			},
			["2"] = {
			    ["action"] = "menu",
			},
	     };
	     mbo.ty = "MouseBindings"; 
	     mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_player_" .. RDX.pspace .. "2");
	if not mbo.data then
		mbo.data = {
			["1"] = {
			    ["action"] = "target",
			},
			["2"] = {
			    ["action"] = "menu",
			},
	     };
	     mbo.ty = "MouseBindings"; 
	     mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_player_" .. RDX.pspace .. "3");
	if not mbo.data then
		mbo.data = {
			["1"] = {
			    ["action"] = "target",
			},
			["2"] = {
			    ["action"] = "menu",
			},
	     };
	     mbo.ty = "MouseBindings"; 
	     mbo.version = 1;
	end
	local mbsl = RDXDB.TouchObject("default:bindings_player");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "bindings_player_", ty = "MouseBindings"};
	end
	
	--
	-- Create player-talent-specific bindings if they don't exist
	-- default:bindings_target
	-- type talent&name&realm
	
	local mbo = RDXDB.TouchObject("default:bindings_target_" .. RDX.pspace .. "1");
	if not mbo.data then
		mbo.data = {
			["1"] = {
			    ["action"] = "target",
			},
			["2"] = {
			    ["action"] = "menu",
			},
			["S1"] = {
			    ["action"] = "focus",
			},
	     };
	     mbo.ty = "MouseBindings"; 
	     mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_target_" .. RDX.pspace .. "2");
	if not mbo.data then
		mbo.data = {
			["1"] = {
			    ["action"] = "target",
			},
			["2"] = {
			    ["action"] = "menu",
			},
			["S1"] = {
			    ["action"] = "focus",
			},
	     };
	     mbo.ty = "MouseBindings"; 
	     mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_target_" .. RDX.pspace .. "3");
	if not mbo.data then
		mbo.data = {
			["1"] = {
			    ["action"] = "target",
			},
			["2"] = {
			    ["action"] = "menu",
			},
			["S1"] = {
			    ["action"] = "focus",
			},
	     };
	     mbo.ty = "MouseBindings"; 
	     mbo.version = 1;
	end
	local mbsl = RDXDB.TouchObject("default:bindings_target");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "bindings_target_", ty = "MouseBindings"};
	end
	
	-- heal bindings
	
	local mbo = RDXDB.TouchObject("default:bindings_heal_" .. RDX.pspace .. "1");
	if not mbo.data then
		mbo.data = heal_default();
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_heal_" .. RDX.pspace .. "2");
	if not mbo.data then
		mbo.data = heal_default();
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_heal_" .. RDX.pspace .. "3");
	if not mbo.data then
		mbo.data = heal_default();
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:bindings_heal");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "bindings_heal_", ty = "MouseBindings"};
	end
	
	-- damage
	local mbo = RDXDB.TouchObject("default:bindings_dmg_" .. RDX.pspace .. "1");
	if not mbo.data then
		mbo.data = dmg_default();
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_dmg_" .. RDX.pspace .. "2");
	if not mbo.data then
		mbo.data = dmg_default();
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	local mbo = RDXDB.TouchObject("default:bindings_dmg_" .. RDX.pspace .. "3");
	if not mbo.data then
		mbo.data = dmg_default();
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:bindings_dmg");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "bindings_dmg_", ty = "MouseBindings"};
	end
	
	-- decurse
	local mbo = RDXDB.TouchObject("default:bindings_decurse_druid");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 2782,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_decurse_priest");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 527,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 528,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_decurse_mage");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 475,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_decurse_paladin");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 4987,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_decurse_shaman");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 51886,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_default");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_decurse");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "default:bindings_default",
			["class"] = "class",
			["targetpath_7"] = "default:bindings_decurse_mage",
			["targetpath_8"] = "default:bindings_default",
			["targetpath_2"] = "default:bindings_decurse_druid",
			["targetpath_3"] = "default:bindings_decurse_paladin",
			["targetpath_4"] = "default:bindings_decurse_shaman",
			["targetpath_1"] = "default:bindings_decurse_priest",
			["targetpath_10"] = "default:bindings_default",
			["targetpath_9"] = "default:bindings_default",
			["targetpath_6"] = "default:bindings_default",
		};
	end
	
	-- dispell a buff on mob
	local mbo = RDXDB.TouchObject("default:bindings_dispell_shaman");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 370,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_dispell_priest");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 527,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_dispell");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "default:bindings_default",
			["class"] = "class",
			["targetpath_7"] = "default:bindings_default",
			["targetpath_8"] = "default:bindings_default",
			["targetpath_2"] = "default:bindings_default",
			["targetpath_3"] = "default:bindings_default",
			["targetpath_4"] = "default:bindings_dispell_shaman",
			["targetpath_1"] = "default:bindings_dispell_priest",
			["targetpath_10"] = "default:bindings_default",
			["targetpath_9"] = "default:bindings_default",
			["targetpath_6"] = "default:bindings_default",
		};
	end
	
	-- buff
	local mbo = RDXDB.TouchObject("default:bindings_buff_warrior");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 2048,
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:bindings_buff_paladin");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 79062,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 79102,
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:bindings_buff_druid");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 79061,
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:bindings_buff_priest");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 79105,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 79107,
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:bindings_buff_mage");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 42995,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 43002,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_buff");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "default:bindings_buff_warrior",
			["class"] = "class",
			["targetpath_7"] = "default:bindings_buff_mage",
			["targetpath_8"] = "default:bindings_default",
			["targetpath_2"] = "default:bindings_buff_druid",
			["targetpath_3"] = "default:bindings_buff_paladin",
			["targetpath_4"] = "default:bindings_default",
			["targetpath_1"] = "default:bindings_buff_priest",
			["targetpath_10"] = "default:bindings_default",
			["targetpath_9"] = "default:bindings_default",
			["targetpath_6"] = "default:bindings_default",
		};
	end
	
	-- interrupt
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_priest");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 15487,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 8122,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_rogue");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 1766,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_deathknight");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 47528,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_hunter");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 34490,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 19503,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_warlock");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 19647,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_paladin");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["S1"] = {
				["action"] = "cast",
				["spell"] = 20066,
			},
			["1"] = {
				["action"] = "cast",
				["spell"] = 96231,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 853,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_mage");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 2139,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_warrior");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 6552,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 85388,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_druid");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 80964,
			},
			["2"] = {
				["action"] = "cast",
				["spell"] = 80965,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt_shaman");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 57994,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("default:bindings_interrupt");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "default:bindings_interrupt_warrior",
			["class"] = "class",
			["targetpath_7"] = "default:bindings_interrupt_mage",
			["targetpath_8"] = "default:bindings_interrupt_rogue",
			["targetpath_2"] = "default:bindings_interrupt_druid",
			["targetpath_3"] = "default:bindings_interrupt_paladin",
			["targetpath_4"] = "default:bindings_interrupt_shaman",
			["targetpath_1"] = "default:bindings_interrupt_priest",
			["targetpath_10"] = "default:bindings_interrupt_deathknight",
			["targetpath_9"] = "default:bindings_interrupt_hunter",
			["targetpath_6"] = "default:bindings_interrupt_warlock",
		};
	end
	
	
end);

--
-- Builtin Aurafilter
--

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	local mbo = RDXDB.TouchObject("default:aurafilter_priest_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			17, -- priest bouclié
			139, -- priest rénovation
			6346, -- priest gardien de peur
			33076, -- priest prière de guérison
			10060, -- priest infusion de puissance
			33206, -- priest suppression de la douleur
			47788, -- priest esprit gardien
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_druid_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			774, -- druid récupération
			8936, -- druid rétablissement
			29166, -- druid innervation
			33778, -- druid fleur de vie
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_paladin_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			1022, -- paladin main de protection
			1044, -- paladin main de liberté
			1038, -- paladin main de salut
			6940, -- paladin main de sacrifice
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_shaman_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			2825, -- shaman fury sanguinaire
			32182, -- shaman heroisme
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_mage_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			80353, -- mage distorsion temporelle
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_hunter_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			34477, -- hunter détournement
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_warrior_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			6673, -- warrior shout
			469, -- warrior cri de commandement
			97462, -- warrior cri de ralliement
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_deathknight_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_warlock_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_rogue_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
		};
	end

	local mbsl = RDXDB.TouchObject("default:aurafilter_buff");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "class" then
		mbsl.ty = "SymLink"; mbsl.version = 3; 
		mbsl.data = {
			class = "class",
			targetpath_1 = "default:aurafilter_priest_buff",
			targetpath_2 = "default:aurafilter_druid_buff",
			targetpath_3 = "default:aurafilter_paladin_buff",
			targetpath_4 = "default:aurafilter_shaman_buff",
			targetpath_5 = "default:aurafilter_warrior_buff",
			targetpath_6 = "default:aurafilter_warlock_buff",
			targetpath_7 = "default:aurafilter_mage_buff",
			targetpath_8 = "default:aurafilter_rogue_buff",
			targetpath_9 = "default:aurafilter_hunter_buff",
			targetpath_10 = "default:aurafilter_deathknight_buff",
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_dot");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			5570, -- druid essain d'insecte
			589, -- priest douleur
			2944, -- priest peste dévorante
			34914, -- priest toucher vampirique
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_block");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			51514, -- shaman maléfice
			5782, -- warlock fear
			710, -- warlock bannir
			2637, -- druid hibernation
			118, -- mage métamorphose
			9484, -- priest entrave des morts vivants
			28271, -- mage
			28272, -- mage
			61305, -- mage
			61721, -- mage
			61780, -- mage
			20066, -- paladin repentir
			6770, -- rogue assome
			2094, -- rogue cecité
		};
	end
	
	local mbo = RDXDB.TouchObject("default:aurafilter_boss");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			"@other", -- [1]
			"!69127", -- [2]
			"!57724", -- [3]
		};
	end
end);

---------------------------------------------
-- Builtin default set magic, curse, poison
---------------------------------------------
RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	local mbo = RDXDB.TouchObject("default:set_debuff_primary");
	if not mbo.data then
		mbo.ty = "SymLink";
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "default:set_debuff_none",
			["class"] = "class",
			["targetpath_7"] = "default:set_debuff_curse",
			["targetpath_8"] = "default:set_debuff_none",
			["targetpath_2"] = "default:set_debuff_poison",
			["targetpath_3"] = "default:set_debuff_poison",
			["targetpath_4"] = "default:set_debuff_curse",
			["targetpath_1"] = "default:set_debuff_magic",
			["targetpath_10"] = "default:set_debuff_none",
			["targetpath_9"] = "default:set_debuff_none",
			["targetpath_6"] = "default:set_debuff_magic",
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff_secondary");
	if not mbo.data then
		mbo.ty = "SymLink";
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "default:set_debuff_none",
			["class"] = "class",
			["targetpath_7"] = "default:set_debuff_none",
			["targetpath_8"] = "default:set_debuff_none",
			["targetpath_2"] = "default:set_debuff_curse",
			["targetpath_3"] = "default:set_debuff_disease",
			["targetpath_4"] = "default:set_debuff_none",
			["targetpath_1"] = "default:set_debuff_disease",
			["targetpath_10"] = "default:set_debuff_none",
			["targetpath_9"] = "default:set_debuff_none",
			["targetpath_6"] = "default:set_debuff_none",
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"or", -- [1]
				{
					"set", -- [1]
					{
						["file"] = "default:set_debuff_primary",
						["class"] = "file",
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["file"] = "default:set_debuff_secondary",
						["class"] = "file",
					}, -- [2]
				}, -- [3]
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff_both");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"and", -- [1]
			{
				"set", -- [1]
				{
					["file"] = "default:set_debuff_primary",
					["class"] = "file",
				}, -- [2]
			}, -- [2]
			{
				"set", -- [1]
				{
					["file"] = "default:set_debuff_secondary",
					["class"] = "file",
				}, -- [2]
			}, -- [3]
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff_none");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"and", -- [1]
			{
				"not", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "file",
						["file"] = "default:set_debuff_primary",
					}, -- [2]
				}, -- [2]
			}, -- [2]
			{
				"not", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "file",
						["file"] = "default:set_debuff_secondary",
					}, -- [2]
				}, -- [2]
			}, -- [3]
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff_magic");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
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
						["buff"] = 30108,
						["class"] = "debuff",
					}, -- [2]
				}, -- [2]
			}, -- [3]
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff_curse");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"and", -- [1]
			{
				"set", -- [1]
				{
					["buff"] = "@curse",
					["class"] = "debuff",
				}, -- [2]
			}, -- [2]
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff_poison");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"and", -- [1]
			{
				"set", -- [1]
				{
					["buff"] = "@poison",
					["class"] = "debuff",
				}, -- [2]
			}, -- [2]
		};
	end
	local mbo = RDXDB.TouchObject("default:set_debuff_disease");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"and", -- [1]
			{
				"set", -- [1]
				{
					["buff"] = "@disease",
					["class"] = "debuff",
				}, -- [2]
			}, -- [2]
		};
	end
end);

--------------------------------------
-- Builtin default set color
--------------------------------------
RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	-- Create player-specific set yellow if they don't exist
	local mbo = RDXDB.TouchObject("default:set_yellow_" .. RDX.pspace .. "1");
	if not mbo.data then 
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_yellow_" .. RDX.pspace .. "2");
	if not mbo.data then 
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_yellow_" .. RDX.pspace .. "3");
	if not mbo.data then 
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_yellow");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "set_yellow_", ty = "FilterSet"};
	end
	
	-- Create player-specific set red if they don't exist
	local mbo = RDXDB.TouchObject("default:set_red_" .. RDX.pspace .. "1");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_red_" .. RDX.pspace .. "2");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_red_" .. RDX.pspace .. "3");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_red");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "set_red_", ty = "FilterSet"};
	end
	
	-- Create player-specific set green if they don't exist
	local mbo = RDXDB.TouchObject("default:set_green_" .. RDX.pspace .. "1");
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_green_" .. RDX.pspace .. "2");
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_green_" .. RDX.pspace .. "3");
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_green");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "set_green_", ty = "FilterSet"};
	end
	
	-- Create player-specific set blue if they don't exist
	local mbo = RDXDB.TouchObject("default:set_blue_" .. RDX.pspace .. "1");
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_blue_" .. RDX.pspace .. "2");
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	local mbo = RDXDB.TouchObject("default:set_blue_" .. RDX.pspace .. "3");
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "none",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_blue");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "set_blue_", ty = "FilterSet"};
	end
	
end);


RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RDXDB.GetObjectInstance("default:Logs_Me_tl");
end);
