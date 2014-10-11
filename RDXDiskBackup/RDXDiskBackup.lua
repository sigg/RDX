WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskBackup then RDXDiskBackup = {}; end
	RDXDB.RegisterDisk("RDXDiskBackup", RDXDiskBackup);
end);
