RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	local lc = GetLocale();
	local mbo = RDXDB.TouchObject("RDXDiskSystem:locales:spells_" .. lc);
	if not mbo.data then 
		mbo.data = {};
		mbo.ty = "Local"; 
		mbo.version = 1;
	end
	
	local mbsl = RDXDB.TouchObject("RDXDiskSystem:locales:spells");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "Local" then
		mbsl.ty = "SymLink"; mbsl.version = 3; mbsl.data = {class = "Local", dk = "RDXDiskSystem", pkg = "locales", prefixfile = "spells_", ty = "Local"};
	end
end);