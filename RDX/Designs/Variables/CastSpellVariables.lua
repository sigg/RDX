
RDX.RegisterFeature({
	name = "var_spellinfo";
	title = VFLI.i18n("Vars Spell Info"); category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("TimerVar_spell");
		state:AddSlot("BoolVar_spell_channeled");
		state:AddSlot("BoolVar_spell_casting");
		state:AddSlot("BoolVar_spell_castingOrChanneled");
		state:AddSlot("TextData_spell_name_rank");
		state:AddSlot("TextData_vertical_spell_name_rank");
		state:AddSlot("TexVar_spell_icon");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local umask = mux:GetPaintMask("CAST_TIMER_UPDATE");
		local smask = mux:GetPaintMask("CAST_TIMER_STOP");
		
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local spell_channeled, spell_casting, spell_castingOrChanneled, spell_name_rank, vertical_spell_name_rank = nil, nil, nil, "", "";
local spell_name, spell_rank, spell_fullname, spell_icon, spell_start, spell_duration = UnitCastingInfo(uid);
if not spell_name then
	spell_name, spell_rank, spell_fullname, spell_icon, spell_start, spell_duration = UnitChannelInfo(uid);
	if spell_name then
		spell_channeled = true;
		spell_castingOrChanneled = true;
	end
else
	spell_casting = true;
	spell_castingOrChanneled = true;
end
if spell_castingOrChanneled then
	spell_start = spell_start / 1000;
	spell_duration = (spell_duration / 1000) - spell_start;
else
	spell_casting = nil; spell_casting = nil; spell_castingOrChanneled = nil;
	spell_name = ""; spell_start = 0; spell_duration = 0;
end
if spell_name and spell_name ~= "" then
	spell_name_rank = spell_name;
	vertical_spell_name_rank = spell_name;
	if spell_rank and spell_rank ~= "" then
		spell_name_rank = spell_name_rank .. " (" .. spell_rank .. ")";
		vertical_spell_name_rank = vertical_spell_name_rank .. spell_rank;
	end
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
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_spellinfo" }; end
});