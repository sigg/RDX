RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:rdx");
	if not mbo.data then
		mbo.ty = "Global"; 
		mbo.version = 1;
		mbo.data = {};
	end
end);