
function RDXMAP.Quest.BuildMenu(self, map)
	
	self.IconMenu = RDXPM.Menu:new();
	self.IconMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Track");
		ent.func = function() VFL.poptree:Release(); self.Menu_OnTrack(self); end 
	end);
	self.IconMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Show Quest Log");
		ent.func = function() VFL.poptree:Release(); self.Menu_OnShowQuest(self); RDXMapEvents:Dispatch("Guide:ClearAll"); end 
	end);
	self.IconMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Watch");
		ent.func = function() VFL.poptree:Release(); self.Menu_OnWatch(self); end 
	end);
	self.IconMenu:RegisterMenuFunction(function(ent)
		ent.text = VFLI.i18n("Add Note");
		ent.func = function() VFL.poptree:Release(); map.Menu_OnAddNote(map); end 
	end);
end