
---------------------------------------------
-- Builtin default set magic, curse, poison
---------------------------------------------
RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	local sets = RDXDB.GetPackage("RDXDiskSystem", "sets");
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_primary");
	if not mbo.data then
		mbo.ty = "SymLink";
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "RDXDiskSystem:sets:set_debuff_none",
			["class"] = "class",
			["targetpath_7"] = "RDXDiskSystem:sets:set_debuff_curse",
			["targetpath_8"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_2"] = "RDXDiskSystem:sets:set_debuff_poison",
			["targetpath_3"] = "RDXDiskSystem:sets:set_debuff_poison",
			["targetpath_4"] = "RDXDiskSystem:sets:set_debuff_curse",
			["targetpath_1"] = "RDXDiskSystem:sets:set_debuff_magic",
			["targetpath_10"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_9"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_6"] = "RDXDiskSystem:sets:set_debuff_magic",
			["targetpath_11"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_12"] = "RDXDiskSystem:sets:set_debuff_none",
		};
	end
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_secondary");
	if not mbo.data then
		mbo.ty = "SymLink";
		mbo.version = 3;
		mbo.data = {
			["targetpath_5"] = "RDXDiskSystem:sets:set_debuff_none",
			["class"] = "class",
			["targetpath_7"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_8"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_2"] = "RDXDiskSystem:sets:set_debuff_curse",
			["targetpath_3"] = "RDXDiskSystem:sets:set_debuff_disease",
			["targetpath_4"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_1"] = "RDXDiskSystem:sets:set_debuff_disease",
			["targetpath_10"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_9"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_6"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_11"] = "RDXDiskSystem:sets:set_debuff_none",
			["targetpath_12"] = "RDXDiskSystem:sets:set_debuff_none",
		};
	end
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"or", -- [1]
				{
					"set", -- [1]
					{
						["file"] = "RDXDiskSystem:sets:set_debuff_primary",
						["class"] = "file",
					}, -- [2]
				}, -- [2]
				{
					"set", -- [1]
					{
						["file"] = "RDXDiskSystem:sets:set_debuff_secondary",
						["class"] = "file",
					}, -- [2]
				}, -- [3]
		};
	end
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_both");
	if not mbo.data then
		mbo.ty = "FilterSet";
		mbo.version = 1;
		mbo.data = {
			"and", -- [1]
			{
				"set", -- [1]
				{
					["file"] = "RDXDiskSystem:sets:set_debuff_primary",
					["class"] = "file",
				}, -- [2]
			}, -- [2]
			{
				"set", -- [1]
				{
					["file"] = "RDXDiskSystem:sets:set_debuff_secondary",
					["class"] = "file",
				}, -- [2]
			}, -- [3]
		};
	end
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_none");
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
						["file"] = "RDXDiskSystem:sets:set_debuff_primary",
					}, -- [2]
				}, -- [2]
			}, -- [2]
			{
				"not", -- [1]
				{
					"set", -- [1]
					{
						["class"] = "file",
						["file"] = "RDXDiskSystem:sets:set_debuff_secondary",
					}, -- [2]
				}, -- [2]
			}, -- [3]
		};
	end
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_magic");
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
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_curse");
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
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_poison");
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
	local mbo = RDXDB.TouchObject("RDXDiskSystem:sets:set_debuff_disease");
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
RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	-- Create player-specific set yellow if they don't exist
	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":set_yellow_" .. i);
		if not mbo.data then 
			mbo.ty = "FilterSet"; 
			mbo.version = 1;
			mbo.data = {
				"set",
				{
					["class"] = "empty",
				},
			};
		end
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:sets:set_yellow");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "set_yellow_", ty = "FilterSet"};
	end
	
	-- Create player-specific set red if they don't exist
	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":set_red_" .. i);
		if not mbo.data then
			mbo.ty = "FilterSet";
			mbo.version = 1;
			mbo.data = {
				"set",
				{
					["class"] = "empty",
				},
			};
		end
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:sets:set_red");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "set_red_", ty = "FilterSet"};
	end
	
	-- Create player-specific set green if they don't exist
	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":set_green_" .. i);
		if not mbo.data then
			mbo.ty = "FilterSet"; 
			mbo.version = 1;
			mbo.data = {
				"set",
				{
					["class"] = "empty",
				},
			};
		end
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:sets:set_green");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "set_green_", ty = "FilterSet"};
	end
	
	-- Create player-specific set blue if they don't exist
	for i=1,GetNumSpecializations() do
		local mbo = RDXDB.TouchObject("RDXDiskSystem:" .. RDX.pspace .. ":set_blue_" .. i);
		if not mbo.data then
			mbo.ty = "FilterSet"; 
			mbo.version = 1;
			mbo.data = {
				"set",
				{
					["class"] = "empty",
				},
			};
		end
	end
	-- Create symlink if it doesn't exist
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:sets:set_blue");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "talent&name&realm" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "talent&name&realm", dk = "RDXDiskSystem", prefixfile = "set_blue_", ty = "FilterSet"};
	end
	
end);