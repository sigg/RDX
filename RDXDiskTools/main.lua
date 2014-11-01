WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXDiskTools then RDXDiskTools = {}; end
	RDXDB.RegisterDisk("RDXDiskTools", RDXDiskTools);
end);
