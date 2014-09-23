WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskTheme then RDXDiskTheme = {}; end
	RDXDB.RegisterDisk("RDXDiskTheme", RDXDiskTheme);
end);

--RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
--	RDXDB.GetOrCreatePackage("RDXDiskTheme", "default", "1.0.0", "WoWRDX", "", "sigg@wowrdx.com", "http://www.wowrdx.com", "RDX package");
--	RDXDB.SetPackageMetadata("RDXDiskTheme", "default", "infoIsIndelible", true);
--end);