WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskQuestsAlliance then RDXDiskQuestsAlliance = {}; end
	RDXDB.RegisterDisk("RDXDiskQuestsAlliance", RDXDiskQuestsAlliance);
end);

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	RDXDB.GetOrCreatePackage("RDXDiskQuestsAlliance", "quests", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskQuestsAlliance", "quests", "infoIsIndelible", true);
end);

--RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()

--end);
