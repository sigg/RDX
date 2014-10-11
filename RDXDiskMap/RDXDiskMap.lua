WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskMap then RDXDiskMap = {}; end
	RDXDB.RegisterDisk("RDXDiskMap", RDXDiskMap);
end);

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	RDXDB.GetOrCreatePackage("RDXDiskMap", "quests", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskMap", "quests", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskMap", "maps", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskMap", "maps", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskMap", "poisG", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskMap", "poisG", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskMap", "poisT", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskMap", "poisT", "infoIsIndelible", true);
end);

RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()

	local tabs = RDXDB.GetPackage("RDXDiskSystem", "tabs");
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:tabs:MapFrame1");
	if not mbo.data then
		mbo.ty = "TabMap"; 
		mbo.version = 1;
		mbo.data = {
			["NXQuestAlpha"] = 0.3,
			["NXDotRaidScale"] = 1,
			["NXShowUnexplored"] = false,
			["NXDotPalScale"] = 1,
			["NXAutoScaleMin"] = 0.01,
			[0] = {
				["NXMapPosX"] = -1020.524185167836,
				["NXPlyrFollow"] = true,
				["NXWorldShow"] = true,
				["NXScale"] = 2.473202843661703,
				["NXMapPosY"] = 1421.614285837348,
				["NXScaleSave"] = 3.076983077499069,
			},
			["NXBackgndAlphaFade"] = 1,
			["NXBackgndAlphaFull"] = 1,
			["NXMMDockScale"] = 0.4,
			["NXMMAlpha"] = 0.1,
			["NXDotZoneScale"] = 1,
			["NXMMDockAlpha"] = 1,
			["NXArchAlpha"] = 0.3,
			["NXMMFull"] = false,
			["NXDetailAlpha"] = 1,
			["NXPOIAtScale"] = 1,
			["NXAutoScaleOn"] = true,
			["NXDotPartyScale"] = 1,
			["NXAutoScaleMax"] = 4,
			["NXKillShow"] = false,
			["NXMMDockOnAtScale"] = 0.6,
			["NXMMDockScaleBG"] = 0.4,
			["NXDetailScale"] = 2,
			["NXIconNavScale"] = 1,
			["NXIconScale"] = 1,
			["NXUnexploredAlpha"] = 0.35,
		};
	end
end);