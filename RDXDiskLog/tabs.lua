RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()

	local tabs = RDXDB.GetPackage("RDXDiskLog", "tabs");
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame1_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabChatFrame"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "General",
				["tabtitle"] = "CG",
				["tabwidth"] = 30,
				["discussion"] = {
					["SAY"] = true,
					["EMOTE"] = true,
					["YELL"] = true,
					["GUILD"] = true,
					["OFFICER"] = true,
					["GUILD_ACHIEVEMENT"] = true,
					["ACHIEVEMENT"] = true,
					["WHISPER"] = true,
					["BN_WHISPER"] = true,
					["PARTY"] = true,
					["PARTY_LEADER"] = true,
					["RAID"] = true,
					["RAID_LEADER"] = true,
					["RAID_WARNING"] = true,
					["BATTLEGROUND"] = true,
					["BATTLEGROUND_LEADER"] = true,
					["BN_CONVERSATION"] = true,
				},
				["creature"] = {
					["MONSTER_SAY"] = true,
					["MONSTER_EMOTE"] = true,
					["MONSTER_YELL"] = true,
					["MONSTER_WHISPER"] = true,
					["MONSTER_BOSS_EMOTE"] = true,
					["MONSTER_BOSS_WHISPER"] = true,
				},
				["combat"] = {
					["COMBAT_FACTION_CHANGE"] = true,
					["SKILL"] = true,
					["LOOT"] = true,
					["CURRENCY"] = true,
					["MONEY"] = true,
				},
				["pvp"] = {
					["BG_SYSTEM_HORDE"] = true,
					["BG_SYSTEM_ALLIANCE"] = true,
					["BG_SYSTEM_NEUTRAL"] = true,
				},
				["system"] = {
					["SYSTEM"] = true,
					["ERRORS"] = true,
					["IGNORED"] = true,
					["CHANNEL"] = true,
					["BN_INLINE_TOAST_ALERT"] = true,
				},
				["channels"] = {
					["CHANNEL1"] = true,
					["CHANNEL2"] = true,
					["CHANNEL3"] = true,
				}
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame1");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "ChatFrame1_", ty = "TabChatFrame"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame2_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabChatFrame"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "Guild",
				["tabtitle"] = "CGU",
				["tabwidth"] = 30,
				["discussion"] = {
					["GUILD"] = true,
					["OFFICER"] = true,
					["GUILD_ACHIEVEMENT"] = true,
					["BN_WHISPER"] = true,
					["PARTY"] = true,
					["PARTY_LEADER"] = true,
					["RAID"] = true,
					["RAID_LEADER"] = true,
					["RAID_WARNING"] = true,
					["BATTLEGROUND"] = true,
					["BATTLEGROUND_LEADER"] = true,
					["BN_CONVERSATION"] = true,
				},
				["creature"] = {
				},
				["combat"] = {
				},
				["pvp"] = {
				},
				["system"] = {
				},
				["channels"] = {
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame2");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "ChatFrame2_", ty = "TabChatFrame"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame3_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabChatFrame"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "Loot",
				["tabtitle"] = "CL",
				["tabwidth"] = 30,
				["discussion"] = {
				},
				["creature"] = {
				},
				["combat"] = {
					["LOOT"] = true,
				},
				["pvp"] = {
				},
				["system"] = {
				},
				["channels"] = {
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame3");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "ChatFrame3_", ty = "TabChatFrame"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame4_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabChatFrame"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "PVP",
				["tabtitle"] = "CP",
				["tabwidth"] = 30,
				["discussion"] = {
					["PARTY"] = true,
					["PARTY_LEADER"] = true,
					["RAID"] = true,
					["RAID_LEADER"] = true,
					["RAID_WARNING"] = true,
					["BATTLEGROUND"] = true,
					["BATTLEGROUND_LEADER"] = true,
				},
				["creature"] = {
				},
				["combat"] = {
				},
				["pvp"] = {
					["BG_SYSTEM_HORDE"] = true,
					["BG_SYSTEM_ALLIANCE"] = true,
					["BG_SYSTEM_NEUTRAL"] = true,
				},
				["system"] = {
				},
				["channels"] = {
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame4");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "ChatFrame4_", ty = "TabChatFrame"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame5_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabChatFrame"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "Creature",
				["tabtitle"] = "CC",
				["tabwidth"] = 30,
				["discussion"] = {
				},
				["creature"] = {
					["MONSTER_SAY"] = true,
					["MONSTER_EMOTE"] = true,
					["MONSTER_YELL"] = true,
					["MONSTER_WHISPER"] = true,
					["MONSTER_BOSS_EMOTE"] = true,
					["MONSTER_BOSS_WHISPER"] = true,
				},
				["combat"] = {
				},
				["pvp"] = {
				},
				["system"] = {
				},
				["channels"] = {
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame5");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "ChatFrame5_", ty = "TabChatFrame"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:ChatFrame6_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabChatFrame"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "System",
				["tabtitle"] = "CS",
				["tabwidth"] = 30,
				["discussion"] = {
				},
				["creature"] = {
				},
				["combat"] = {
				},
				["pvp"] = {
				},
				["system"] = {
					["SYSTEM"] = true,
					["ERRORS"] = true,
					["IGNORED"] = true,
					["CHANNEL"] = true,
					["BN_INLINE_TOAST_ALERT"] = true,
				},
				["channels"] = {
				},
			};
	end
	
	if not tabs["ChatFrame7"] then
		tabs["ChatFrame7"] = {
			["ty"] = "TabChatFrame",
			["version"] = 1,
			["data"] = {
				["title"] = "Undefined",
				["tabtitle"] = "CU",
				["tabwidth"] = 30,
				["discussion"] = {
				},
				["creature"] = {
				},
				["combat"] = {
				},
				["pvp"] = {
				},
				["system"] = {
				},
				["channels"] = {
				},
			},
		};
	end
	
	if not tabs["ChatFrame8"] then
		tabs["ChatFrame8"] = {
			["ty"] = "TabChatFrame",
			["version"] = 1,
			["data"] = {
				["title"] = "Undefined",
				["tabtitle"] = "CU",
				["tabwidth"] = 30,
				["discussion"] = {
				},
				["creature"] = {
				},
				["combat"] = {
				},
				["pvp"] = {
				},
				["system"] = {
				},
				["channels"] = {
				},
			},
		};
	end
	
	if not tabs["ChatFrame9"] then
		tabs["ChatFrame9"] = {
			["ty"] = "TabChatFrame",
			["version"] = 1,
			["data"] = {
				["title"] = "Undefined",
				["tabtitle"] = "CU",
				["tabwidth"] = 30,
				["discussion"] = {
				},
				["creature"] = {
				},
				["combat"] = {
				},
				["pvp"] = {
				},
				["system"] = {
				},
				["channels"] = {
				},
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:CombatLogs1_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabCombatLogs"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "Player",
				["tabtitle"] = "LP",
				["filter"] = 1,
				["tabwidth"] = 30,
				["size"] = 1000,
				["filters"] = {
					["targ"] = "player",
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
					["src"] = "player",
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:CombatLogs1");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "CombatLogs1_", ty = "TabCombatLogs"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:CombatLogs2_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabCombatLogs"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "All",
				["tabtitle"] = "LA",
				["filter"] = 1,
				["tabwidth"] = 30,
				["size"] = 1000,
				["filters"] = {
					["targ"] = "*",
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
					["src"] = "*",
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:CombatLogs2");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "CombatLogs2_", ty = "TabCombatLogs"};
	end
	
	if not tabs["CombatLogs3"] then
		tabs["CombatLogs3"] = {
			["ty"] = "TabCombatLogs",
			["version"] = 1,
			["data"] = {
				["title"] = "Undefined",
				["tabtitle"] = "LU",
				["filter"] = 1,
				["tabwidth"] = 30,
				["size"] = 1000,
				["filters"] = {
					["targ"] = "*",
					["src"] = "*",
				},
			},
		};
	end
	
	if not tabs["CombatLogs4"] then
		tabs["CombatLogs4"] = {
			["ty"] = "TabCombatLogs",
			["version"] = 1,
			["data"] = {
				["title"] = "Undefined",
				["tabtitle"] = "LU",
				["filter"] = 1,
				["tabwidth"] = 30,
				["size"] = 1000,
				["filters"] = {
					["targ"] = "*",
					["src"] = "*",
				},
			},
		};
	end
	
	if not tabs["CombatLogs5"] then
		tabs["CombatLogs5"] = {
			["ty"] = "TabCombatLogs",
			["version"] = 1,
			["data"] = {
				["title"] = "Undefined",
				["tabtitle"] = "LU",
				["filter"] = 1,
				["tabwidth"] = 30,
				["size"] = 1000,
				["filters"] = {
					["targ"] = "*",
					["src"] = "*",
				},
			},
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:Meter1_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabMeter"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "Heal Done",
				["tabtitle"] = "MH",
				["tabwidth"] = 30,
				["filters"] = {
					["etypes"] = {
						[8]=true,
					},
					["dtypes"] = {
						[1]=true,
					},
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:Meter1");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "Meter1_", ty = "TabMeter"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:Meter2_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabMeter"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "OverHeal Done",
				["tabtitle"] = "MOH",
				["tabwidth"] = 30,
				["filters"] = {
					["etypes"] = {
						[44]=true,
					},
					["dtypes"] = {
						[1]=true,
					},
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:Meter2");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "Meter2_", ty = "TabMeter"};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskLog:tabs:Meter3_" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "TabMeter"; 
		mbo.version = 1;
		mbo.data = {
				["title"] = "Damage Done",
				["tabtitle"] = "MD",
				["tabwidth"] = 30,
				["filters"] = {
					["etypes"] = {
						[2]=true,
					},
					["dtypes"] = {
						[1]=true,
					},
				},
			};
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskLog:tabs:Meter3");
	if mbsl.ty ~= "SymLink" or mbsl.data.class ~= "name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "name&realm", dk = "RDXDiskLog", pkg = "tabs", prefixfile = "Meter3_", ty = "TabMeter"};
	end

	
end);