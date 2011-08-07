

RDX.RegisterFeature({
	name = "ColorVariable: Unit PowerType Color";
	title = VFLI.i18n("Color Unit PowerType");
	category = VFLI.i18n("Colors");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if state:Slot("ColorVar_powerColor") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name.")); return nil;
		end
		-- add tmp
		if not desc.runeColor then desc.runeColor = {r=0, g=0.75, b=1,a=1} end
		if not desc.focusColor then desc.focusColor = {r=1, g=0.5, b=0.2,a=1} end
		state:AddSlot("Var_powerColor");
		state:AddSlot("ColorVar_powerColor");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local powerColor_cf = {};
powerColor_cf[0] = ]] .. Serialize(desc.manaColor) .. [[;
powerColor_cf[1] = ]] .. Serialize(desc.rageColor) .. [[;
powerColor_cf[2] = ]] .. Serialize(desc.focusColor) .. [[;
powerColor_cf[3] = ]] .. Serialize(desc.energyColor) .. [[;
powerColor_cf[4] = powerColor_cf[0];
powerColor_cf[5] = powerColor_cf[0];
powerColor_cf[6] = ]] .. Serialize(desc.runeColor) .. [[;
]]);
		end);
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode("local powerColor = powerColor_cf[unit:PowerType()] or powerColor_cf[0];");
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Mana Color"));
		local swatch_manac = VFLUI.ColorSwatch:new(er);
		swatch_manac:Show();
		if desc and desc.manaColor then swatch_manac:SetColor(VFL.explodeRGBA(desc.manaColor)); end
		er:EmbedChild(swatch_manac); er:Show();
		ui:InsertFrame(er);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Energy Color"));
		local swatch_energyc = VFLUI.ColorSwatch:new(er);
		swatch_energyc:Show();
		if desc and desc.energyColor then swatch_energyc:SetColor(VFL.explodeRGBA(desc.energyColor)); end
		er:EmbedChild(swatch_energyc); er:Show();
		ui:InsertFrame(er);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Rage Color"));
		local swatch_ragec = VFLUI.ColorSwatch:new(er);
		swatch_ragec:Show();
		if desc and desc.rageColor then swatch_ragec:SetColor(VFL.explodeRGBA(desc.rageColor)); end
		er:EmbedChild(swatch_ragec); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Focus Color"));
		local swatch_focusc = VFLUI.ColorSwatch:new(er);
		swatch_focusc:Show();
		if desc and desc.focusColor then swatch_focusc:SetColor(VFL.explodeRGBA(desc.focusColor)); end
		er:EmbedChild(swatch_focusc); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Rune Color"));
		local swatch_runec = VFLUI.ColorSwatch:new(er);
		swatch_runec:Show();
		if desc and desc.runeColor then swatch_runec:SetColor(VFL.explodeRGBA(desc.runeColor)); end
		er:EmbedChild(swatch_runec); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "ColorVariable: Unit PowerType Color";
				manaColor = swatch_manac:GetColor(); 
				energyColor = swatch_energyc:GetColor();
				rageColor = swatch_ragec:GetColor();
				focusColor = swatch_focusc:GetColor();
				runeColor = swatch_runec:GetColor();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "ColorVariable: Unit PowerType Color";
			manaColor = {r=0, g=0, b=0.75,a=1}, rageColor = {r=1,g=0,b=0,a=1}, focusColor = {r=1, g=0.5, b=0.2,a=1}, energyColor = {r=0.75,g=0.75,b=0,a=1}, runeColor = {r=0, g=0.75, b=1,a=1};
		};
	end;
});