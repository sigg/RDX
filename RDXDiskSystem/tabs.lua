RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()

	local tabs = RDXDB.GetPackage("RDXDiskSystem", "tabs");
	
	if not tabs["BlizzMenu"] then
		tabs["BlizzMenu"] = {
			["ty"] = "TabWindow",
			["version"] = 2,
			["data"] = {
				{
					["feature"] = "Frame: None",
					["bkd"] = {
						["borderlevel"] = 2,
						["dl"] = "ARTWORK",
						["off"] = 0,
						["_backdrop"] = "none",
						["offset"] = 0,
						["borl"] = 2,
						["_border"] = "none",
						["bors"] = 1,
						["boff"] = 1,
					},
				}, -- [1]
				{
					["feature"] = "Design",
					["design"] = "RDXDiskSystem:tabs:BlizzMenu_ds",
				}, -- [2]
				{
					["feature"] = "layout_single_unitframe",
					["version"] = 1,
					["unit"] = "player",
				}, -- [3]
				{
					["feature"] = "taboptions",
					["tabtitle"] = "Menu",
					["tabwidth"] = 80,
				}, -- [4]
			},
		};
	end
	
	if not tabs["BlizzMenu_ds"] then
		tabs["BlizzMenu_ds"] = {
			["ty"] = "Design",
			["version"] = 1,
			["data"] = {
				{
					["feature"] = "base_default",
					["h"] = 80,
					["version"] = 1,
					["bkd"] = {
					},
					["w"] = 320,
					["alpha"] = 1,
				}, -- [1]
				{
					["rows"] = 1,
					["owner"] = "Frame_decor",
					["feature"] = "menubar",
					["iconspx"] = -2,
					["version"] = 1,
					["orientation"] = "RIGHT",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = 21,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_decor",
					},
					["name"] = "mbar",
					["iconspy"] = 0,
					["nIcons"] = 12,
				}, -- [2]
				{
					["owner"] = "Frame_decor",
					["rows"] = 1,
					["feature"] = "bagsbar",
					["iconspx"] = 2,
					["name"] = "bbar",
					["orientation"] = "RIGHT",
					["anchor"] = {
						["dx"] = 0,
						["dy"] = -38,
						["lp"] = "TOPLEFT",
						["rp"] = "TOPLEFT",
						["af"] = "Frame_decor",
					},
					["version"] = 1,
					["iconspy"] = 0,
					["nIcons"] = 5,
				}, -- [3]
			},
		};
	end
end);