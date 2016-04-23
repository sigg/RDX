WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskLog then RDXDiskLog = {}; end
	RDXDB.RegisterDisk("RDXDiskLog", RDXDiskLog);
end);

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	RDXDB.GetOrCreatePackage("RDXDiskLog", "tabs", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskLog", "tabs", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskLog", "save", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskLog", "save", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", RDX.pspace, "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX User Package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", RDX.pspace, "infoIsIndelible", true);
end);