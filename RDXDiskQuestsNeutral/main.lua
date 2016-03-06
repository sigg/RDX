WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskQuestsNeutral then RDXDiskQuestsNeutral = {}; end
	RDXDB.RegisterDisk("RDXDiskQuestsNeutral", RDXDiskQuestsNeutral);
end);

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	RDXDB.GetOrCreatePackage("RDXDiskQuestsNeutral", "quests", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskQuestsNeutral", "quests", "infoIsIndelible", true);
end);

--RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()

--end);
