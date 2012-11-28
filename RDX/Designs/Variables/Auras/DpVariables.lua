RDX.RegisterFeature({
	name = "Variable dp";
	title = "Vars Dp";
	category = VFLI.i18n("Variables Aura");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = VFL.Nil;
	ApplyFeature = VFL.Nil;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variables: Buffs Debuffs Info"; name = "dp"; auraType = "DEBUFFS"; cd = 72330}; end
});