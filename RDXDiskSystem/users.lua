RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	local mbo = RDXDB.TouchObject("RDXDiskSystem:users:" .. RDX.pspace);
	if not mbo.data then
		mbo.ty = "User"; 
		mbo.version = 1;
		mbo.data = {};
	end
end);