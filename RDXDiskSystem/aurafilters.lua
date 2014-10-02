
RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	local aurafilters = RDXDB.GetPackage("RDXDiskSystem", "aurafilters");
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_priest_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			17, -- priest bouclié
			139, -- priest rénovation
			6346, -- priest gardien de peur
			33076, -- priest prière de guérison
			10060, -- priest infusion de puissance
			33206, -- priest suppression de la douleur
			47788, -- priest esprit gardien
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_druid_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			774, -- druid récupération
			8936, -- druid rétablissement
			29166, -- druid innervation
			33778, -- druid fleur de vie
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_paladin_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			1022, -- paladin main de protection
			1044, -- paladin main de liberté
			1038, -- paladin main de salut
			6940, -- paladin main de sacrifice
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_shaman_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			2825, -- shaman fury sanguinaire
			32182, -- shaman heroisme
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_mage_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			80353, -- mage distorsion temporelle
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_hunter_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			34477, -- hunter détournement
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_warrior_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			6673, -- warrior shout
			469, -- warrior cri de commandement
			97462, -- warrior cri de ralliement
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_deathknight_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_warlock_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_rogue_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_monk_buff");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
		};
	end

	local mbsl = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_buff");
	if not mbsl.data or type(mbsl.data) ~= "table" or mbsl.data.class ~= "class" then
		mbsl.ty = "SymLink"; mbsl.version = 3; 
		mbsl.data = {
			class = "class",
			targetpath_1 = "RDXDiskSystem:aurafilters:aurafilter_priest_buff",
			targetpath_2 = "RDXDiskSystem:aurafilters:aurafilter_druid_buff",
			targetpath_3 = "RDXDiskSystem:aurafilters:aurafilter_paladin_buff",
			targetpath_4 = "RDXDiskSystem:aurafilters:aurafilter_shaman_buff",
			targetpath_5 = "RDXDiskSystem:aurafilters:aurafilter_warrior_buff",
			targetpath_6 = "RDXDiskSystem:aurafilters:aurafilter_warlock_buff",
			targetpath_7 = "RDXDiskSystem:aurafilters:aurafilter_mage_buff",
			targetpath_8 = "RDXDiskSystem:aurafilters:aurafilter_rogue_buff",
			targetpath_9 = "RDXDiskSystem:aurafilters:aurafilter_hunter_buff",
			targetpath_10 = "RDXDiskSystem:aurafilters:aurafilter_deathknight_buff",
			targetpath_11 = "RDXDiskSystem:aurafilters:aurafilter_monk_buff",
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_dot");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			5570, -- druid essain d'insecte
			589, -- priest douleur
			2944, -- priest peste dévorante
			34914, -- priest toucher vampirique
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_block");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			51514, -- shaman maléfice
			5782, -- warlock fear
			710, -- warlock bannir
			2637, -- druid hibernation
			118, -- mage métamorphose
			9484, -- priest entrave des morts vivants
			28271, -- mage
			28272, -- mage
			61305, -- mage
			61721, -- mage
			61780, -- mage
			20066, -- paladin repentir
			6770, -- rogue assome
			2094, -- rogue cecité
		};
	end
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:aurafilters:aurafilter_boss");
	if not mbo.data then 
		mbo.ty = "AuraFilter"; 
		mbo.version = 1;
		mbo.data = {
			"@other", -- [1]
			"!69127", -- [2]
			"!57724", -- [3]
		};
	end
end);