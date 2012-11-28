
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
		if not desc.raColor4 then desc.raColor4 = _red; end
		if desc.filterName then
			if desc.externalNameFilter then
				-- one day
			else
				if VFL.tsize(desc.filterNameList) == 0 then 
					VFL.AddError(errs, VFLI.i18n("Empty filter list.")); return nil;
				end
			end
		end
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
		
		local closureCode = "";
		closureCode = closureCode ..[[
local spColor_cf = {};
spColor_cf[1] = ]] .. Serialize(desc.raColor1) .. [[;
spColor_cf[2] = ]] .. Serialize(desc.raColor2) .. [[;
spColor_cf[3] = ]] .. Serialize(desc.raColor3) .. [[;
spColor_cf[4] = ]] .. Serialize(desc.raColor4) .. [[;
]];
		if desc.filterName then
			closureCode = closureCode ..[[
local _fnames = ]];
			if desc.externalNameFilter then
				closureCode = closureCode .. [[RDXDB.GetObjectInstance(]] .. string.format("%q", desc.externalNameFilter) .. [[);
]];
			else
				-- Internal filter
				closureCode = closureCode .. [[{};
]];
				if desc.filterNameList then
					local flag;
					for _,name in pairs(desc.filterNameList) do
						flag = nil;
						local test = string.sub(name, 1, 1);
						if test == "!" then
							flag = true;
							name = string.sub(name, 2);
						end
						local testnumber = tonumber(name);
						if testnumber then
							local auname = GetSpellInfo(name);
							if not auname then auname = name; end
							if flag then
								auname = "!" .. auname;
								closureCode = closureCode .. "_fnames[" .. string.format("%q", auname) .. "] = true; ";
							else
								closureCode = closureCode .. "_fnames[" .. string.format("%q", auname) .. "] = true; ";
							end
						else
							if flag then
								name = "!" .. name;
								closureCode = closureCode .. "_fnames[" .. string.format("%q", name) .. "] = true; ";
							else
								closureCode = closureCode .. "_fnames[" .. string.format("%q", name) .. "] = true; ";
							end
						end
					end
				end
			end
		end
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		local namefilter = "true"; 
		if desc.filterName then
			namefilter = "(_fnames[spell_name])";
			namefilter = namefilter .. " and (not (_fnames['!'.. spell_name]))";
		end

		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
		local spell_channeled, spell_casting, spell_castingOrChanneled, spell_name_rank, vertical_spell_name_rank, spell_duration, spell_color = nil, nil, nil, "", "", 0, _alphafull;
		local spell_name, spell_rank, spell_fullname, spell_icon, spell_start, spell_end, spell_istradeskill, _, spell_notinterruptible = UnitCastingInfo(uid);
		if not spell_name then
			spell_name, spell_rank, spell_fullname, spell_icon, spell_start, spell_end, spell_istradeskill, spell_notinterruptible = UnitChannelInfo(uid);
			if spell_name and ]] .. namefilter .. [[ then
				spell_channeled = true;
				spell_castingOrChanneled = true;
				spell_color = spColor_cf[2];
			end
		else
			if ]] .. namefilter .. [[ then
				spell_casting = true;
				spell_castingOrChanneled = true;
				spell_color = spColor_cf[1];
			end
		end
		if spell_castingOrChanneled then
			spell_start = spell_start / 1000;
			spell_end = spell_end / 1000;
			spell_duration = spell_end - spell_start;
			if spell_istradeskill then spell_color = spColor_cf[3];
			elseif not spell_notinterruptible and UnitIsEnemy("player", uid) then spell_color = spColor_cf[4];
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
		
		local chk_filterName = VFLUI.Checkbox:new(ui); chk_filterName:Show();
		chk_filterName:SetText(VFLI.i18n("Filter by spell name"));
		if desc and desc.filterName then chk_filterName:SetChecked(true); else chk_filterName:SetChecked(); end
		ui:InsertFrame(chk_filterName);
		
		local chk_external = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use external spell list"));
		local file_external = RDXDB.ObjectFinder:new(chk_external, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "SpellFilter$")); end);
		file_external:SetWidth(200); file_external:Show();
		chk_external:EmbedChild(file_external); chk_external:Show();
		ui:InsertFrame(chk_external);
		if desc.externalNameFilter then
			chk_external:SetChecked(true); file_external:SetPath(desc.externalNameFilter);
		else
			chk_external:SetChecked();
		end

		local le_names = VFLUI.ListEditor:new(ui, desc.filterNameList or {}, function(cell,data) 
			if type(data) == "number" then
				local name = GetSpellInfo(data);
				cell.text:SetText(name);
			else
				local test = string.sub(data, 1, 1);
				if test == "!" then
					local uname = string.sub(data, 2);
					local vname = GetSpellInfo(uname);
					if vname then
						cell.text:SetText("!" .. vname);
					else
						cell.text:SetText(data);
					end
				else
					cell.text:SetText(data);
				end
			end
		end);
		le_names:SetHeight(183); le_names:Show();
		ui:InsertFrame(le_names);

		function ui:GetDescriptor()
			local filterName, filterNameList, filternl, ext, unitfi, maxdurfil, mindurfil = nil, nil, {}, nil, "", "", "";
			if chk_filterName:GetChecked() then
				if chk_external:GetChecked() then 
					ext = file_external:GetPath(); filternl = nil;
				else
					ext = nil;
					filterNameList = le_names:GetList();
					local flag;
					for k,v in pairs(filterNameList) do
						flag = nil;
						local test = string.sub(v, 1, 1);
						if test == "!" then
							flag = true;
							v = string.sub(v, 2);
						end
						local testnumber = tonumber(v);
						if testnumber then
							if flag then
								filternl[k] = "!" .. testnumber;
							else
								filternl[k] = testnumber;
							end
						else
							if flag then
								local spellid = RDXSS.GetSpellIdByLocalName(v);
								if spellid then
									filternl[k] = "!" .. spellid;
								else
									filternl[k] = "!" .. v;
								end
							else
								filternl[k] = RDXSS.GetSpellIdByLocalName(v) or v;
							end
						end
					end
				end
			end
			return {
				feature = "var_spellinfo";
				raColor1 = swatch_raColor1:GetColor(); 
				raColor2 = swatch_raColor2:GetColor();
				raColor3 = swatch_raColor3:GetColor();
				raColor4 = swatch_raColor4:GetColor();
				filterName = chk_filterName:GetChecked();
				externalNameFilter = ext;
				filterNameList = filternl;
			};
		end

		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "var_spellinfo";
			raColor1 = _green;
			raColor2 = _yellow;
			raColor3 = _blue;
			raColor4 = _red;
		}; 
	end
});