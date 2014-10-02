RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	local default = RDXDB.GetPackage("RDXDiskSystem", "default");
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
							["id"] = "RDXDiskSystem:default:ActionBar1",
							["x"] = 0,
							["point"] = "BOTTOM",
							["y"] = -10,
						},
						["BOTTOMLEFT"] = {
							["id"] = "RDXDiskSystem:default:TabManager1",
							["x"] = -10,
							["point"] = "BOTTOMLEFT",
							["y"] = -10,
						},
						["BOTTOMRIGHT"] = {
							["id"] = "RDXDiskSystem:default:TabManager2",
							["x"] = 10,
							["point"] = "BOTTOMRIGHT",
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
					["name"] = "RDXDiskSystem:default:ActionBar1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 498.3466885378205,
					["b"] = 8.533333656676994,
					["r"] = 866.9866965304984,
				}, -- [2]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
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
					["name"] = "RDXDiskSystem:default:TabManager1",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 8.533333656676994,
					["b"] = 8.533333656676994,
					["r"] = 349.8667135374535,
				}, -- [3]
				{
					["strata"] = "MEDIUM",
					["dock"] = {
						["BOTTOMRIGHT"] = {
							["id"] = "root",
							["x"] = -10,
							["point"] = "BOTTOMRIGHT",
							["y"] = 10,
						},
					},
					["scale"] = 1,
					["t"] = 162.1333506814285,
					["open"] = true,
					["feature"] = "desktop_window",
					["name"] = "RDXDiskSystem:default:TabManager2",
					["alpha"] = 1,
					["anchor"] = "TOPLEFT",
					["l"] = 8.533333656676994,
					["b"] = 8.533333656676994,
					["r"] = 349.8667135374535,
				}, -- [4]
			},
		};
	end
	
	if not default["TabManager1_tm"] then
		default["TabManager1_tm"] = {
			["ty"] = "TabManager",
			["version"] = 1,
			["data"] = {
				["cfm"] = {
					{
						["op"] = "RDXDiskSystem:tabs:ChatFrame1",
					},
					{
						["op"] = "RDXDiskSystem:tabs:ChatFrame2",
					},
					{
						["op"] = "RDXDiskSystem:tabs:ChatFrame3",
					},
				},
			},
		};
	end
	
	if not default["TabManager1_ds"] then
		default["TabManager1_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 200,
					["version"] = 1,
					["w"] = 400,
					["alpha"] = 1,
				}, -- [1]
				{
					["ts"] = "None",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["owner"] = "Frame_decor",
					["w"] = "400",
					["feature"] = "tabmanager",
					["h"] = "200",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "HalStraight",
						["edgeSize"] = 8,
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["font"] = {
						["sr"] = 0,
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "CENTER",
						["title"] = "Default",
						["size"] = 12,
					},
					["name"] = "cf1",
					["cfm"] = "RDXDiskSystem:default:TabManager1_tm",
				}, -- [2]
			},
		};
	end
	
	if not default["TabManager1"] then
		default["TabManager1"] = {
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
					["design"] = "RDXDiskSystem:default:TabManager1_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
			},
		};
	end
	
	if not default["TabManager2_tm"] then
		default["TabManager2_tm"] = {
			["ty"] = "TabManager",
			["version"] = 1,
			["data"] = {
				["cfm"] = {
					{
						["op"] = "RDXDiskSystem:tabs:CombatLogs1",
					},
				},
			},
		};
	end
	
	if not default["TabManager2_ds"] then
		default["TabManager2_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 200,
					["version"] = 1,
					["w"] = 400,
					["alpha"] = 1,
				}, -- [1]
				{
					["ts"] = "None",
					["color"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["owner"] = "Frame_decor",
					["w"] = "400",
					["feature"] = "tabmanager",
					["h"] = "200",
					["version"] = 1,
					["bkd"] = {
						["_border"] = "HalStraight",
						["edgeSize"] = 8,
						["edgeFile"] = "Interface\\Addons\\RDX_mediapack\\Halcyon\\HalBorder",
						["insets"] = {
							["top"] = 2,
							["right"] = 2,
							["left"] = 2,
							["bottom"] = 2,
						},
					},
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 0,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Base",
					},
					["font"] = {
						["sr"] = 0,
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["face"] = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf",
						["justifyV"] = "CENTER",
						["sb"] = 0,
						["sa"] = 1,
						["sg"] = 0,
						["name"] = "Default",
						["sx"] = 1,
						["sy"] = -1,
						["justifyH"] = "CENTER",
						["title"] = "Default",
						["size"] = 12,
					},
					["name"] = "cf1",
					["cfm"] = "RDXDiskSystem:default:TabManager2_tm",
				}, -- [2]
			},
		};
	end
	
	if not default["TabManager2"] then
		default["TabManager2"] = {
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
					["design"] = "RDXDiskSystem:default:TabManager2_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
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
	
	if not default["Party_fset"] then
		default["Party_fset"] = {
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
	
	if not default["Partypet_fset"] then
		default["Party_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"raidpet", -- [1]
			},
		};
	end
	
	if not default["Arena_fset"] then
		default["Arena_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"arena", -- [1]
			},
		};
	end
	
	if not default["Arenapet_fset"] then
		default["Arena_fset"] = {
			["ty"] = "FilterSet",
			["version"] = 1,
			["data"] = {
				"arenapet", -- [1]
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
					["design"] = "RDXDiskSystem:default:ActionBar1_ds",
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
					["feature"] = "listbuttons",
					["ftype"] = 1,
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
					["bs"] = {
						["name"] = "bs_simplesquare";
						["insets"] = 6;
					},
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
					["driver"] = 2,
				}, -- [2]
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
							["file"] = "RDXDiskSystem:default:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [2]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "RDXDiskSystem:default:Range_15_30_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "RDXDiskSystem:default:Range_30_40_fset",
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
						["file"] = "RDXDiskSystem:default:Range_0_15_fset",
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
							["file"] = "RDXDiskSystem:default:Range_0_15_fset",
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
							["file"] = "RDXDiskSystem:default:Range_0_40_fset",
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
							["file"] = "RDXDiskSystem:default:Range_0_15_fset",
							["class"] = "file",
						}, -- [2]
					}, -- [2]
				}, -- [3]
				{
					"not", -- [1]
					{
						"set", -- [1]
						{
							["file"] = "RDXDiskSystem:default:Range_15_30_fset",
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
							["file"] = "RDXDiskSystem:default:Range_0_10_fset",
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