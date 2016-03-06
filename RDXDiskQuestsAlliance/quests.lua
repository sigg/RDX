RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()

	local quests = RDXDB.GetPackage("RDXDiskQuestsAlliance", "quests");
	
	local mbo = RDXDB.TouchObject("RDXDiskQuestsAlliance:quests:quests");
	if not mbo.data then
		mbo.ty = "QuestSet"; 
		mbo.version = 1;
		mbo.data = {};
	end
	
end);