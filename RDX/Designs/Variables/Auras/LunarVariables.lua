RDX.RegisterFeature({
	name = "Variable lunar";
	title = "Vars Lunar";
	category = VFLI.i18n("Variables Aura");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = VFL.Nil;
	ApplyFeature = VFL.Nil;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variables: Buffs Debuffs Info"; name = "lunar"; auraType = "BUFFS"; cd = 48518}; end
});