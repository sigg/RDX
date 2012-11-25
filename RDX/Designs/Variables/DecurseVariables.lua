-------------------------
-- Sigg / Rashgarroth eu
-------------------------

RDX.RegisterFeature({
	name = "Variables decurse";
	title = VFLI.i18n("Vars Decurse (Texicon, color)");
	category = VFLI.i18n("Variables");
	test = true;
	IsPossible = function(state)
		if not state:HasSlots("DesignFrame", "EmitClosure", "EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)		
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not desc.raColor5 then desc.raColor5 = _alphafull; end
		if (not RDXDAL.FindSet(desc.set1)) or (not RDXDAL.FindSet(desc.set2)) or (not RDXDAL.FindSet(desc.set3)) or (not RDXDAL.FindSet(desc.set4)) then
			VFL.AddError(errs, VFLI.i18n("Invalid set pointer."));
			return nil;
		end
		if state:Slot("ColorVar_decurseColor") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name.")); return nil;
		end
		--state:AddSlot("Var_decurseColor");
		state:AddSlot("ColorVar_decurseColor");
		state:AddSlot("TexVar_decurseIcon");
		state:AddSlot("BoolVar_decurse_possible");
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- On closure, acquire the set locally
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local st1 = RDXDAL.FindSet(]] .. Serialize(desc.set1) .. [[);
local st2 = RDXDAL.FindSet(]] .. Serialize(desc.set2) .. [[);
local st3 = RDXDAL.FindSet(]] .. Serialize(desc.set3) .. [[);
local st4 = RDXDAL.FindSet(]] .. Serialize(desc.set4) .. [[);
local deColor_cf = {};
deColor_cf[1] = ]] .. Serialize(desc.raColor1) .. [[;
deColor_cf[2] = ]] .. Serialize(desc.raColor2) .. [[;
deColor_cf[3] = ]] .. Serialize(desc.raColor3) .. [[;
deColor_cf[4] = ]] .. Serialize(desc.raColor4) .. [[;
deColor_cf[5] = ]] .. Serialize(desc.raColor5) .. [[;
local deTex_cf = {};
deTex_cf[1] = ]] .. string.format("%q", desc.texture1.path) .. [[;
deTex_cf[2] = ]] .. string.format("%q", desc.texture2.path) .. [[;
deTex_cf[3] = ]] .. string.format("%q", desc.texture3.path) .. [[;
deTex_cf[4] = ]] .. string.format("%q", desc.texture4.path) .. [[;
]]);
		end);
		-- On paint preamble, create flag and grade variables
		local cmagic, cpoison, cdisease, ccurse = "and RDXSS.GetCategoryByName('CURE_MAGIC') ", "and RDXSS.GetCategoryByName('CURE_POISON') ", "and RDXSS.GetCategoryByName('CURE_DISEASE') ", "and RDXSS.GetCategoryByName('CURE_CURSE') ";
		if desc.nocurefilter then
			cmagic, cpoison, cdisease, ccurse = "", "", "", "";
		end
		
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
		local decurseColor, decurseIcon, decurse_possible = deColor_cf[1], deTex_cf[1], true;
]]);
		else
			code:AppendCode([[
		local decurseColor, decurseIcon, decurse_possible = _alphafull, "", false;
		if st1:IsMember(unit) ]] .. cmagic .. [[ then
			decurseColor = deColor_cf[1];
			decurseIcon = deTex_cf[1];
			decurse_possible = true;
		elseif st2:IsMember(unit) ]] .. cpoison .. [[ then
			decurseColor = deColor_cf[2];
			decurseIcon = deTex_cf[2];
			decurse_possible = true;
		elseif st3:IsMember(unit) ]] .. cdisease .. [[ then
			decurseColor = deColor_cf[3];
			decurseIcon = deTex_cf[3];
			decurse_possible = true;
		elseif st4:IsMember(unit) ]] .. ccurse .. [[ then
			decurseColor = deColor_cf[4];
			decurseIcon = deTex_cf[4];
			decurse_possible = true;
		else
			decurseColor = deColor_cf[5];
			decurse_possible = false
		end
]]);
		end
		end);
		-- Event hint: update on sort.
		local set1 = RDXDAL.FindSet(desc.set1);
		local set2 = RDXDAL.FindSet(desc.set2);
		local set3 = RDXDAL.FindSet(desc.set3);
		local set4 = RDXDAL.FindSet(desc.set4);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		mux:Event_SetDeltaMask(set1, 2); -- mask 2 = generic repaint
		mux:Event_SetDeltaMask(set2, 2); -- mask 2 = generic repaint
		mux:Event_SetDeltaMask(set3, 2); -- mask 2 = generic repaint
		mux:Event_SetDeltaMask(set4, 2); -- mask 2 = generic repaint
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Options")));
		
		local chk_nocurefilter = VFLUI.Checkbox:new(ui); chk_nocurefilter:Show();
		chk_nocurefilter:SetText(VFLI.i18n("No filter, show all debuff"));
		if desc and desc.nocurefilter then chk_nocurefilter:SetChecked(true); else chk_nocurefilter:SetChecked(); end
		ui:InsertFrame(chk_nocurefilter);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Magic")));
		
		local sf1 = RDXDAL.SetFinder:new(ui); sf1:Show();
		ui:InsertFrame(sf1); 
		if desc and desc.set1 then sf1:SetDescriptor(desc.set1); end
		
		local er1 = VFLUI.EmbedRight(ui, VFLI.i18n("Magic"));
		local swatch_raColor1 = VFLUI.ColorSwatch:new(er1);
		swatch_raColor1:Show();
		if desc and desc.raColor1 then swatch_raColor1:SetColor(VFL.explodeRGBA(desc.raColor1)); end
		er1:EmbedChild(swatch_raColor1); er1:Show();
		ui:InsertFrame(er1);
		
		local er1 = VFLUI.EmbedRight(ui, VFLI.i18n("Texture Magic"));
		local tsel1 = VFLUI.MakeTextureSelectButton(er1, desc.texture1); tsel1:Show();
		er1:EmbedChild(tsel1); er1:Show();
		ui:InsertFrame(er1);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("poison")));
		
		local sf2 = RDXDAL.SetFinder:new(ui); sf2:Show();
		ui:InsertFrame(sf2); 
		if desc and desc.set2 then sf2:SetDescriptor(desc.set2); end
		
		local er2 = VFLUI.EmbedRight(ui, VFLI.i18n("Poison"));
		local swatch_raColor2 = VFLUI.ColorSwatch:new(er2);
		swatch_raColor2:Show();
		if desc and desc.raColor2 then swatch_raColor2:SetColor(VFL.explodeRGBA(desc.raColor2)); end
		er2:EmbedChild(swatch_raColor2); er2:Show();
		ui:InsertFrame(er2);
		
		local er2 = VFLUI.EmbedRight(ui, VFLI.i18n("Texture Poison"));
		local tsel2 = VFLUI.MakeTextureSelectButton(er2, desc.texture2); tsel2:Show();
		er2:EmbedChild(tsel2); er2:Show();
		ui:InsertFrame(er2);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Disease")));
		
		local sf3 = RDXDAL.SetFinder:new(ui); sf3:Show();
		ui:InsertFrame(sf3); 
		if desc and desc.set3 then sf3:SetDescriptor(desc.set3); end
		
		local er3 = VFLUI.EmbedRight(ui, VFLI.i18n("Disease"));
		local swatch_raColor3 = VFLUI.ColorSwatch:new(er3);
		swatch_raColor3:Show();
		if desc and desc.raColor3 then swatch_raColor3:SetColor(VFL.explodeRGBA(desc.raColor3)); end
		er3:EmbedChild(swatch_raColor3); er3:Show();
		ui:InsertFrame(er3);
		
		local er3 = VFLUI.EmbedRight(ui, VFLI.i18n("Texture Disease"));
		local tsel3 = VFLUI.MakeTextureSelectButton(er3, desc.texture3); tsel3:Show();
		er3:EmbedChild(tsel3); er3:Show();
		ui:InsertFrame(er3);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Curse")));
		
		local sf4 = RDXDAL.SetFinder:new(ui); sf4:Show();
		ui:InsertFrame(sf4); 
		if desc and desc.set4 then sf4:SetDescriptor(desc.set4); end
		
		local er4 = VFLUI.EmbedRight(ui, VFLI.i18n("Curse"));
		local swatch_raColor4 = VFLUI.ColorSwatch:new(er4);
		swatch_raColor4:Show();
		if desc and desc.raColor4 then swatch_raColor4:SetColor(VFL.explodeRGBA(desc.raColor4)); end
		er4:EmbedChild(swatch_raColor4); er4:Show();
		ui:InsertFrame(er4);
		
		local er4 = VFLUI.EmbedRight(ui, VFLI.i18n("Texture Curse"));
		local tsel4 = VFLUI.MakeTextureSelectButton(er4, desc.texture4); tsel4:Show();
		er4:EmbedChild(tsel4); er4:Show();
		ui:InsertFrame(er4);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Default")));
		
		local er5 = VFLUI.EmbedRight(ui, VFLI.i18n("Default color"));
		local swatch_raColor5 = VFLUI.ColorSwatch:new(er5);
		swatch_raColor5:Show();
		if desc and desc.raColor5 then swatch_raColor5:SetColor(VFL.explodeRGBA(desc.raColor5)); end
		er5:EmbedChild(swatch_raColor5); er5:Show();
		ui:InsertFrame(er5);

		function ui:GetDescriptor()
			return {
				feature = "Variables decurse";
				nocurefilter = chk_nocurefilter:GetChecked();
				set1 = sf1:GetDescriptor();  
				set2 = sf2:GetDescriptor();
				set3 = sf3:GetDescriptor();
				set4 = sf4:GetDescriptor();
				texture1 = tsel1:GetSelectedTexture();
				texture2 = tsel2:GetSelectedTexture();
				texture3 = tsel3:GetSelectedTexture();
				texture4 = tsel4:GetSelectedTexture();
				raColor1 = swatch_raColor1:GetColor(); 
				raColor2 = swatch_raColor2:GetColor();
				raColor3 = swatch_raColor3:GetColor();
				raColor4 = swatch_raColor4:GetColor();
				raColor5 = swatch_raColor5:GetColor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variables decurse";
			set1 = { file = "default:set_debuff_magic", class = "file"};
			set2 = { file = "default:set_debuff_poison", class = "file"};
			set3 = { file = "default:set_debuff_disease", class = "file"}; 
			set4 = { file = "default:set_debuff_curse", class = "file"};
			texture1 = { blendMode = "BLEND", path = "Interface\\Icons\\Spell_Holy_DispelMagic"};
			texture2 = { blendMode = "BLEND", path = "Interface\\Icons\\Spell_Nature_NullifyPoison_02"};
			texture3 = { blendMode = "BLEND", path = "Interface\\Icons\\Spell_Nature_RemoveDisease"};
			texture4 = { blendMode = "BLEND", path = "Interface\\Icons\\Spell_Nature_RemoveCurse"};
			raColor1 = _blue;
			raColor2 = _green;
			raColor3 = _yellow;
			raColor4 = _red;
			raColor5 = _alphafull;
		};
	end;
});
