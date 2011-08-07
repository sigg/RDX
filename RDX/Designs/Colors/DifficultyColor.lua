

RDX.RegisterFeature({
	name = "color_difficulty";
	title = VFLI.i18n("Color Difficulty"); 
	category = VFLI.i18n("Colors");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if state:Slot("ColorVar_difficultyColor") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name.")); return nil;
		end
		state:AddSlot("Var_difficultyColor");
		state:AddSlot("ColorVar_difficultyColor");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode("local difficultyColor = GetQuestDifficultyColor(UnitLevel(uid));");
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function()
		return { feature = "color_difficulty"; };
	end;
});