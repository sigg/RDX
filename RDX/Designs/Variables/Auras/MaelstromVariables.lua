RDX.RegisterFeature({
	name = "Variable maelstrom";
	title = "Vars Maelstrom";
	category = VFLI.i18n("Variables Aura");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = VFL.Nil;
	ApplyFeature = VFL.Nil;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variables: Buffs Debuffs Info"; name = "maelstrom"; auraType = "BUFFS"; cd = 53817}; end
});