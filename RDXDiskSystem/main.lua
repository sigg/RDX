WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskSystem then RDXDiskSystem = {}; end
	RDXDB.RegisterDisk("RDXDiskSystem", RDXDiskSystem);
end);

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "globals", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "globals", "infoIsIndelible", true);
	--RDXDB.GetOrCreatePackage("RDXDiskSystem", "users", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	--RDXDB.SetPackageMetadata("RDXDiskSystem", "users", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "locales", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "locales", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "default", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "default", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "tabs", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "tabs", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "bindings", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "bindings", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "scripts", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "scripts", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "desktops", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "desktops", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "aurafilters", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "aurafilters", "infoIsIndelible", true);
	RDXDB.GetOrCreatePackage("RDXDiskSystem", "sets", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", "sets", "infoIsIndelible", true);
	-- new
	RDXDB.GetOrCreatePackage("RDXDiskSystem", RDX.pspace, "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX User Package");
	RDXDB.SetPackageMetadata("RDXDiskSystem", RDX.pspace, "infoIsIndelible", true);
end);
