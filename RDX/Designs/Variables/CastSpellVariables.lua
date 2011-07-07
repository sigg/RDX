
RDX.RegisterFeature({
	name = "var_spellinfo";
	title = VFLI.i18n("Vars Spell");
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if state:Slot("ColorVar_spell_color") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name.")); return nil;
		end
		if not desc.raColor1 then desc.raColor1 = _green; end
		if not desc.raColor2 then desc.raColor2 = _yellow; end
		if not desc.raColor3 then desc.raColor3 = _blue; end
		if not desc.raColor4 then desc.raColor4 = _grey; end
		state:AddSlot("TimerVar_spell");
		state:AddSlot("BoolVar_spell_channeled");
		state:AddSlot("BoolVar_spell_casting");
		state:AddSlot("BoolVar_spell_castingOrChanneled");
		state:AddSlot("BoolVar_spell_istradeskill");
		state:AddSlot("BoolVar_spell_notinterruptible");
		state:AddSlot("ColorVar_spell_color");
		state:AddSlot("TextData_spell_name_rank");
		state:AddSlot("TextData_vertical_spell_name_rank");
		state:AddSlot("TexVar_spell_icon");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local umask = mux:GetPaintMask("CAST_TIMER_UPDATE");
		local smask = mux:GetPaintMask("CAST_TIMER_STOP");
		state:Attach(state:Slot("EmitClosure"), true, function(code)
		code:AppendCode([[
local spColor_cf = {};
spColor_cf[1] = ]] .. Serialize(desc.raColor1) .. [[;
spColor_cf[2] = ]] .. Serialize(desc.raColor2) .. [[;
spColor_cf[3] = ]] .. Serialize(desc.raColor3) .. [[;
spColor_cf[4] = ]] .. Serialize(desc.raColor4) .. [[;
]]);
		end);
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local spell_channeled, spell_casting, spell_castingOrChanneled, spell_name_rank, vertical_spell_name_rank, spell_duration, spell_color = nil, nil, nil, "", "", 0, _alphafull;
local spell_name, spell_rank, spell_fullname, spell_icon, spell_start, spell_end, spell_istradeskill, _, spell_notinterruptible = UnitCastingInfo(uid);
if not spell_name then
	spell_name, spell_rank, spell_fullname, spell_icon, spell_start, spell_end, spell_istradeskill, spell_notinterruptible = UnitChannelInfo(uid);
	if spell_name then = 
		spell_channeled = true;
		spell_castingOrChanneled = true;
		spell_color = spColor_cf[2];
	end
else
	spell_casting = true;
	spell_castingOrChanneled = true;
	spell_color = spColor_cf[1];
end
if spell_castingOrChanneled then
	spell_start = spell_start / 1000;
	spell_end = spell_end / 1000;
	spell_duration = spell_end - spell_start;
	if spell_istradeskill then spell_color = spColor_cf[3];
	elseif not spell_notinterruptible then spell_color = spColor_cf[4];
	end
else
	spell_casting = nil; spell_casting = nil; spell_castingOrChanneled = nil;
	spell_name = ""; spell_start = 0; spell_duration = 0; spell_color = _alphafull;
end
if spell_name and spell_name ~= "" then
	spell_name_rank = spell_name;
	vertical_spell_name_rank = spell_name;
	vertical_spell_name_rank = string.gsub(vertical_spell_name_rank, "[^A-Z:0-9.]","")
	if string.len(vertical_spell_name_rank) > 5 then
		vertical_spell_name_rank = string.sub(vertical_spell_name_rank,1,5);
	end
	local vtext = "";
	for i=1,string.len(vertical_spell_name_rank) do
		vtext = vtext..string.sub(vertical_spell_name_rank,i,i).."\n";
	end
	vertical_spell_name_rank = vtext;
end
]]);
		end);

		mux:Event_UnitMask("UNIT_CAST_TIMER_UPDATE", umask);
		mux:Event_UnitMask("UNIT_CAST_TIMER_STOP", smask);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Options")));
		
		local er1 = VFLUI.EmbedRight(ui, VFLI.i18n("Cast color"));
		local swatch_raColor1 = VFLUI.ColorSwatch:new(er1);
		swatch_raColor1:Show();
		if desc and desc.raColor1 then swatch_raColor1:SetColor(VFL.explodeRGBA(desc.raColor1)); end
		er1:EmbedChild(swatch_raColor1); er1:Show();
		ui:InsertFrame(er1);
		
		local er2 = VFLUI.EmbedRight(ui, VFLI.i18n("Chanel color"));
		local swatch_raColor2 = VFLUI.ColorSwatch:new(er2);
		swatch_raColor2:Show();
		if desc and desc.raColor2 then swatch_raColor2:SetColor(VFL.explodeRGBA(desc.raColor2)); end
		er2:EmbedChild(swatch_raColor2); er2:Show();
		ui:InsertFrame(er2);
		
		local er3 = VFLUI.EmbedRight(ui, VFLI.i18n("Tradeskill color"));
		local swatch_raColor3 = VFLUI.ColorSwatch:new(er3);
		swatch_raColor3:Show();
		if desc and desc.raColor3 then swatch_raColor3:SetColor(VFL.explodeRGBA(desc.raColor3)); end
		er3:EmbedChild(swatch_raColor3); er3:Show();
		ui:InsertFrame(er3);
		
		local er4 = VFLUI.EmbedRight(ui, VFLI.i18n("Interrupt color"));
		local swatch_raColor4 = VFLUI.ColorSwatch:new(er4);
		swatch_raColor4:Show();
		if desc and desc.raColor4 then swatch_raColor4:SetColor(VFL.explodeRGBA(desc.raColor4)); end
		er4:EmbedChild(swatch_raColor4); er4:Show();
		ui:InsertFrame(er4);

		function ui:GetDescriptor()
			return {
				feature = "var_spellinfo";
				raColor1 = swatch_raColor1:GetColor(); 
				raColor2 = swatch_raColor2:GetColor();
				raColor3 = swatch_raColor3:GetColor();
				raColor4 = swatch_raColor4:GetColor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "var_spellinfo"
			raColor1 = _green;
			raColor2 = _yellow;
			raColor3 = _blue;
			raColor4 = _grey;
		}; 
	end
});