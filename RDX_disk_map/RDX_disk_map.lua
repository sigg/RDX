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