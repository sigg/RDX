-- Core.lua
-- OpenRDX - Raid Data Exchange
-- Sigg

RDXBM = RegisterVFLModule({
	name = "RDXBM";
	title = VFLI.i18n("RDX Bossmod");
	description = "RDX Bossmod GUI Editor";
	version = {1,0,0};
	parent = RDX;
});

-----------------------------------------
-- Menu Bossmods
-----------------------------------------
RDXBossmods = {};
RDXBossmods.menu = RDXPM.Menu:new();
--RDX.RegisterMainMenuEntry("Bossmods", true, function(tree,frame) RDXBossmods.menu:Open(tree, frame); end);

RDXBossmods.menu:RegisterMenuFunction(function(ent)
	if RDXU.atracker then
		ent.text = VFLI.i18n("Ability Tracker |cFF00FF00[ON]|r"); 
		ent.func = function() RDXBM.StopAbilityTracker(); VFL.poptree:Release(); end;
	else
		ent.text = VFLI.i18n("Ability Tracker |cFFFF0000[OFF]|r"); 
		ent.func = function() RDXBM.StartAbilityTracker(); VFL.poptree:Release(); end;
	end
end);

RDXBossmods.menu:RegisterMenuFunction(function(ent)
	if RDXBM.isMoveAlerts() then
		ent.text = "Lock Alerts"; 
		ent.func = function() RDXBM.StopMovingAlerts(); VFL.poptree:Release(); end;
	else
		ent.text = "Move Alerts"; 
		ent.func = function() RDXBM.MoveAlerts(); VFL.poptree:Release(); end;
	end
end);

RDXBossmods.menu:RegisterMenuFunction(function(ent)
	if RDXU.nosound then
		ent.text = VFLI.i18n("Sound |cFFFF0000[OFF]|r"); 
		ent.func = function() RDXU.nosound = nil; VFL.poptree:Release(); end;
	else
		ent.text = VFLI.i18n("Sound |cFF00FF00[ON]|r");
		ent.func = function() RDXU.nosound = true; VFL.poptree:Release(); end;
	end
end);

RDXBossmods.menu:RegisterMenuFunction(function(ent)
	if RDXU.spam then
		ent.text = VFLI.i18n("Announce |cFF00FF00[ON]|r"); 
		ent.func = function() RDX.AnnounceOff(); VFL.poptree:Release(); end;
	else
		ent.text = VFLI.i18n("Announce |cFFFF0000[OFF]|r"); 
		ent.func = function() RDX.AnnounceOn(); VFL.poptree:Release(); end;
	end
end);



function RDX.ShowBossmodsMenu()
	VFL.poptree:Begin(160, 14, UIParent, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(UIParent));
	RDXBossmods.menu:Open(VFL.poptree, nil);
end


