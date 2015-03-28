WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskQuestsHorde then RDXDiskQuestsHorde = {}; end
	RDXDB.RegisterDisk("RDXDiskQuestsHorde", RDXDiskQuestsHorde);
end);

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	RDXDB.GetOrCreatePackage("RDXDiskQuestsHorde", "quests", "1.0.0", "WoWRDX", "", "team@wowrdx.com", "http://www.wowrdx.com", "RDX package");
	RDXDB.SetPackageMetadata("RDXDiskQuestsHorde", "quests", "infoIsIndelible", true);
end);

--RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()

--end);
