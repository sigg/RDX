-- Builtin.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- A few useful built-in structures.

local strlower = string.lower;

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	local default = RDXDB.GetOrCreatePackage("default");
	if not default["assists"] then
		default["assists"] = {
			["ty"] = "NominativeSet",
			["version"] = 1,
			["data"] = {}
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
end);

--------------------------------------
-- Builtin default mouse bindings
--------------------------------------
RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	
	--
	-- Create player-talent-specific bindings if they don't exist
	-- default:bindings
	-- type talent&name&realm
	
	local mbo = RDXDB.TouchObject("default:bindings_" .. RDX.pspace.. RDXMD.GetSelfTalentNoIndex());
	if not mbo.data then
		mbo.data = {}; mbo.ty = "MouseBindings"; mbo.version = 1;
	end
	local mbsl = RDXDB.TouchObject("default:bindings");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "bindings_", ty = "MouseBindings"};
	end
	
	--
	-- Create player-specific bindings status for windows if they don't exist
	-- default:bindings_status_
	--
	mbo = RDXDB.TouchObject("default:bindings_status_" .. RDX.pspace);
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
	mbsl = RDXDB.TouchObject("default:bindings_status");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "name&realm" then
	      mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", pkg = "default", prefixfile = "bindings_status_", ty = "MouseBindings"};
	end

	--
	-- Create player-specific bindings decurse for windows if they don't exist
	-- default:bindings_decurse_
	--
	mbo = RDXDB.TouchObject("default:bindings_decurse_" .. RDX.pspace);
	if not mbo.data then
		local _,class = UnitClass("player");
		if class == "PRIEST" then
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
		elseif class == "DRUID" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 2782,
			    },
			};
		elseif class == "PALADIN" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 4987,
			    },
			};
		elseif class == "SHAMAN" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 51886,
			    },
			};
		elseif class == "MAGE" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 475,
			    },
			};
		else
			mbo.data = {};
		end
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	-- Create symlink if it doesn't exist
	mbsl = RDXDB.TouchObject("default:bindings_decurse");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", pkg = "default", prefixfile = "bindings_decurse_", ty = "MouseBindings"};
	end
	
	--
	-- Create player-specific bindings decurse for windows if they don't exist
	-- default:bindings_action_
	--
	local mbo = RDXDB.TouchObject("default:bindings_action_" .. RDX.pspace .. RDXMD.GetSelfTalentNoIndex());
	if not mbo.data then
		local _,class = UnitClass("player");
		if class == "PRIEST" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 48071,
			    },
			};
		elseif class == "DRUID" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 48378,
			    },
			};
		elseif class == "PALADIN" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 48785,
			    },
			};
		elseif class == "SHAMAN" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 49273,
			    },
			};
		elseif class == "WARRIOR" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 53476,
			    },
			};
		elseif class == "HUNTER" then
			mbo.data = {
			    ["1"] = {
				["action"] = "cast",
				["spell"] = 35079,
			    },
			};
		else
			mbo.data = {};
		end
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:bindings_action");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", pkg = "default", prefixfile = "bindings_action_", ty = "MouseBindings"};
	end

end);

--------------------------------------
-- Builtin default set color
--------------------------------------
RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	-- Create player-specific set yellow if they don't exist
	local mbo = RDXDB.TouchObject("default:set_yellow_" .. RDX.pspace);
	if not mbo.data then 
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "ags",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_yellow");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", pkg = "default", prefixfile = "set_yellow_", ty = "FilterSet"};
	end
	
	-- Create player-specific set red if they don't exist
	local mbo = RDXDB.TouchObject("default:set_red_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "ags",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_red");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", pkg = "default", prefixfile = "set_red_", ty = "FilterSet"};
	end
	
	-- Create player-specific set green if they don't exist
	local mbo = RDXDB.TouchObject("default:set_green_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "ags",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_green");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", pkg = "default", prefixfile = "set_green_", ty = "FilterSet"};
	end
	
	-- Create player-specific set blue if they don't exist
	local mbo = RDXDB.TouchObject("default:set_blue_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "FilterSet"; 
		mbo.version = 1;
		mbo.data = {
			"set",
			{
				["class"] = "haspet",
			},
		};
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("default:set_blue");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", pkg = "default", prefixfile = "set_blue_", ty = "FilterSet"};
	end
end);


