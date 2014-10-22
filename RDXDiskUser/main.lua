WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskUser then RDXDiskUser = {}; end
	RDXDB.RegisterDisk("RDXDiskUser", RDXDiskUser);
end);
