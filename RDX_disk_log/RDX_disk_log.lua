WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskLog then RDXDiskLog = {}; end
	RDXDB.RegisterDisk("RDXDiskLog", RDXDiskLog);
end);
