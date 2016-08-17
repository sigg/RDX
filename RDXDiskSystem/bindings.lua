

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
	elseif class == "MONK" then
		ret = {
		   -- ["1"] = {
			--["action"] = "cast",
			--["spell"] = 57934,
		 --   },
		};
	elseif class == "DEMONHUNTER" then
		ret = {
		   -- ["1"] = {
			--["action"] = "cast",
			--["spell"] = 57934,
		 --   },
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
	elseif class == "MONK" then
		ret = {
		   -- ["1"] = {
			--["action"] = "cast",
			--["spell"] = 47541,
		 --   },
		   -- ["2"] = {
			--["action"] = "cast",
			--["spell"] = 77575,
		    --},
		};
	elseif class == "DEMONHUNTER" then
		ret = {
		   -- ["1"] = {
			--["action"] = "cast",
			--["spell"] = 47541,
		 --   },
		   -- ["2"] = {
			--["action"] = "cast",
			--["spell"] = 77575,
		    --},
		};
	else
		ret = {};
	end
	return ret;
end

RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	--
	-- Create player-talent-specific bindings if they don't exist
	-- default:bindings_player
	-- type talent&name&realm
	local bindings = RDXDB.GetPackage("RDXDiskSystem", "bindings");
	
	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":bindings_player_" .. i);
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
	end
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_player");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "bindings_player_", ty = "MouseBindings"};
	end
	
	--
	-- Create player-talent-specific bindings if they don't exist
	-- default:bindings_target
	-- type talent&name&realm
	
	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":bindings_target_" .. i);
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
	end
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_target");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "bindings_target_", ty = "MouseBindings"};
	end
	
	-- heal bindings
	
	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":bindings_heal_" .. i);
		if not mbo.data then
			mbo.data = heal_default();
			mbo.ty = "MouseBindings"; 
			mbo.version = 1;
		end
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_heal");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "bindings_heal_", ty = "MouseBindings"};
	end
	
	-- damage

	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":bindings_dmg_" .. i);
		if not mbo.data then
			mbo.data = dmg_default();
			mbo.ty = "MouseBindings"; 
			mbo.version = 1;
		end
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_dmg");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "bindings_dmg_", ty = "MouseBindings"};
	end
	
	-- decurse
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse_priest");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse_paladin");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse_mage");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse_shaman");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 77130,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse_druid");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 88423,
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse_monk");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
			["1"] = {
				["action"] = "cast",
				["spell"] = 115450,
			},
		};
	end
	
	--local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse_demonhunter");
	--if not mbo.data then 
	--	mbo.ty = "MouseBindings"; 
	--	mbo.version = 1;
	--	mbo.data = {
	--		["1"] = {
	--			["action"] = "cast",
	--			["spell"] = 115450,
	--		},
	--	};
	--end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_default");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_decurse");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "RDXDiskSystem:bindings:bindings_default",
			["class"] = "class",
			["targetpath_7"] = "RDXDiskSystem:bindings:bindings_decurse_mage",
			["targetpath_8"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_2"] = "RDXDiskSystem:bindings:bindings_decurse_druid",
			["targetpath_3"] = "RDXDiskSystem:bindings:bindings_decurse_paladin",
			["targetpath_4"] = "RDXDiskSystem:bindings:bindings_decurse_shaman",
			["targetpath_1"] = "RDXDiskSystem:bindings:bindings_decurse_priest",
			["targetpath_10"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_9"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_6"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_11"] = "RDXDiskSystem:bindings:bindings_decurse_monk",
			["targetpath_12"] = "RDXDiskSystem:bindings:bindings_default",
		};
	end
	if mbo.data and not mbo.data.targetpath_12 then mbo.data.targetpath_12 = "RDXDiskSystem:bindings:bindings_default"; end
	
	-- dispell a buff on mob
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_dispell_shaman");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_dispell_priest");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_dispell");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "RDXDiskSystem:bindings:bindings_default",
			["class"] = "class",
			["targetpath_7"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_8"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_2"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_3"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_4"] = "RDXDiskSystem:bindings:bindings_dispell_shaman",
			["targetpath_1"] = "RDXDiskSystem:bindings:bindings_dispell_priest",
			["targetpath_10"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_9"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_6"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_11"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_12"] = "RDXDiskSystem:bindings:bindings_default",
		};
	end
	if mbo.data and not mbo.data.targetpath_12 then mbo.data.targetpath_12 = "RDXDiskSystem:bindings:bindings_default"; end
	
	-- buff
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_buff_warrior");
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
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_buff_paladin");
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
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_buff_druid");
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
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_buff_priest");
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
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_buff_mage");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_buff");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "RDXDiskSystem:bindings:bindings_buff_warrior",
			["class"] = "class",
			["targetpath_7"] = "RDXDiskSystem:bindings:bindings_buff_mage",
			["targetpath_8"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_2"] = "RDXDiskSystem:bindings:bindings_buff_druid",
			["targetpath_3"] = "RDXDiskSystem:bindings:bindings_buff_paladin",
			["targetpath_4"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_1"] = "RDXDiskSystem:bindings:bindings_buff_priest",
			["targetpath_10"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_9"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_6"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_11"] = "RDXDiskSystem:bindings:bindings_default",
			["targetpath_12"] = "RDXDiskSystem:bindings:bindings_default",
		};
	end
	if mbo.data and not mbo.data.targetpath_12 then mbo.data.targetpath_12 = "RDXDiskSystem:bindings:bindings_default"; end
	
	-- interrupt
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_priest");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_rogue");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_deathknight");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_hunter");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_warlock");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_paladin");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_mage");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_warrior");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_druid");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_shaman");
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
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_monk");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt_demonhunter");
	if not mbo.data then 
		mbo.ty = "MouseBindings"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:bindings:bindings_interrupt");
	if not mbo.data then 
		mbo.ty = "SymLink"; 
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "RDXDiskSystem:bindings:bindings_interrupt_warrior",
			["class"] = "class",
			["targetpath_7"] = "RDXDiskSystem:bindings:bindings_interrupt_mage",
			["targetpath_8"] = "RDXDiskSystem:bindings:bindings_interrupt_rogue",
			["targetpath_2"] = "RDXDiskSystem:bindings:bindings_interrupt_druid",
			["targetpath_3"] = "RDXDiskSystem:bindings:bindings_interrupt_paladin",
			["targetpath_4"] = "RDXDiskSystem:bindings:bindings_interrupt_shaman",
			["targetpath_1"] = "RDXDiskSystem:bindings:bindings_interrupt_priest",
			["targetpath_10"] = "RDXDiskSystem:bindings:bindings_interrupt_deathknight",
			["targetpath_9"] = "RDXDiskSystem:bindings:bindings_interrupt_hunter",
			["targetpath_6"] = "RDXDiskSystem:bindings:bindings_interrupt_warlock",
			["targetpath_11"] = "RDXDiskSystem:bindings:bindings_interrupt_monk",
			["targetpath_12"] = "RDXDiskSystem:bindings:bindings_interrupt_demonhunter",
		};
	end
	if mbo.data and not mbo.data.targetpath_12 then mbo.data.targetpath_12 = "RDXDiskSystem:bindings:bindings_interrupt_demonhunter"; end
	
end);