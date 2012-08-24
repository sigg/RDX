-- AuraBars.lua
-- OpenRDX
-- Code for aura bars attached to unitframes.
-- Sigg Rashgarroth EU
--

local strsub = string.sub;

RDX.RegisterFeature({
	name = "aura_bars2";
	version = 2;
	title = VFLI.i18n("Bars Aura");
	category = VFLI.i18n("Lists");
	multiple = true;
	VersionMismatch = function(desc)
		desc.version = 2;
		desc.nIcons = 10;
		desc.nBars = nil;
		return true;
	end;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.sbtib then desc.sbtib = VFL.copy(VFLUI.defaultSBTIB); end
		if not desc.formulaType then desc.formulaType = "simple"; end
		--if not desc.countTypeFlag then desc.countTypeFlag = "false"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Bars_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		--flg = flg and RDXUI.UFLayoutCheck(desc, state, errs);
		if not desc.mindurationfilter then desc.mindurationfilter = 0; end
		if (not tonumber(desc.mindurationfilter)) then 
			if (desc.mindurationfilter ~= "") then VFL.AddError(errs, VFLI.i18n("Min duration is not a number or empty")); flg = nil; end 
		end
		if not desc.maxdurationfilter then desc.maxdurationfilter = 3000; end
		if (not tonumber(desc.maxdurationfilter)) then 
			if (desc.maxdurationfilter ~= "") then VFL.AddError(errs, VFLI.i18n("Max duration is not a number or empty")); flg = nil; end 
		end
		if desc.externalNameFilter and desc.externalNameFilter ~= "" then
			if not RDXDB.CheckObject(desc.externalNameFilter, "AuraFilter") then VFL.AddError(errs, VFLI.i18n("Invalid aurafilter")); flg = nil; end
		end
		if desc.sbblendcolor then
			if not desc.sbcolorVar1 or desc.sbcolorVar1 == "" or not state:Slot("ColorVar_" .. desc.sbcolorVar1) then
				VFL.AddError(errs, VFLI.i18n("Invalid Status Bar Color Variable 1")); flg = nil;
			end
			if not desc.sbcolorVar2 or desc.sbcolorVar2 == "" or not state:Slot("ColorVar_" .. desc.sbcolorVar2) then
				VFL.AddError(errs, VFLI.i18n("Invalid Status Bar Color Variable 2")); flg = nil;
			end
		end
		if flg then state:AddSlot("Bars_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Bars_" .. desc.name;
		local loadCode = "LoadBuffFromUnit";
		-- Event hinting.
		local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		if desc.auraType == "DEBUFFS" then
			mask = mux:GetPaintMask("DEBUFFS");
			mux:Event_UnitMask("UNIT_DEBUFF_*", mask);
			loadCode = "LoadDebuffFromUnit";
		else
			mask = mux:GetPaintMask("BUFFS");
			mux:Event_UnitMask("UNIT_BUFF_*", mask);
		end
		mask = bit.bor(mask, 1);
		
		local winpath = state:GetContainingWindowState():GetSlotValue("Path");
		local md = RDXDB.GetObjectData(winpath);
		local auracache = "false"; if md and RDXDB.HasFeature(md.data, "AuraCache") then auracache = "true"; end
		local smooth = "nil"; if desc.smooth then smooth = "RDX.smooth"; end
		local raidfilter = "nil"; if desc.raidfilter then raidfilter = "true"; end
		
		local aurasfilter, afflag = " (", nil; 
		if desc.playerauras then aurasfilter = aurasfilter .. " _caster == 'player'"; afflag = true; end
		if desc.othersauras then
			if afflag then
				aurasfilter = aurasfilter .. " or _caster ~= 'player'";
			else
				aurasfilter = aurasfilter .. " _caster ~= 'player'"; afflag = true;
			end
		end
		if desc.petauras then 
			if afflag then
				aurasfilter = aurasfilter .. " or _caster == 'pet' or _caster == 'vehicle'" ;
			else
				aurasfilter = aurasfilter .. " _caster == 'pet' or _caster == 'vehicle'"; afflag = true;
			end
		end
		if desc.targetauras then 
			if afflag then
				aurasfilter = aurasfilter .. " or _caster == 'target'";
			else
				aurasfilter = aurasfilter .. " _caster == 'target'"; afflag = true;
			end
		end
		if desc.focusauras then 
			if afflag then
				aurasfilter = aurasfilter .. " or _caster == 'focus'";
			else
				aurasfilter = aurasfilter .. " _caster == 'focus'"; afflag = true;
			end
		end
		if not afflag then aurasfilter = aurasfilter .. " true"; end
		aurasfilter = aurasfilter .. " )";
		
		local isstealablefilter = "true"; if desc.isstealablefilter then isstealablefilter = "_isStealable"; end
		local curefilter = "true"; if desc.curefilter then curefilter = "(_dispelt and RDXSS.GetCategoryByName('CURE_'..string.upper(_dispelt)))"; end
		local timefilter = "true"; 
		if desc.timefilter then timefilter = "(_dur > 0";
			if (desc.mindurationfilter ~= "") then timefilter = timefilter .. " and _dur >= " .. desc.mindurationfilter; end
			if (desc.maxdurationfilter ~= "") then timefilter = timefilter .. " and _dur <= " .. desc.maxdurationfilter; end
			timefilter = timefilter ..")";
		elseif desc.notimefilter then
			timefilter = "(_dur == 0)";
		end
		local namefilter = "true"; if desc.filterName then
			namefilter = "(" .. objname .. "_fnames[_bn] or " .. objname .. "_fnames[_meta.category])";
			namefilter = namefilter .. " and (not (" .. objname .. "_fnames['!'.._bn] or " .. objname .. "_fnames['!'.._meta.category]))"
		end
		local countTypeFlag = "nil" if desc.countTypeFlag and desc.countTypeFlag ~= "" then countTypeFlag = desc.countTypeFlag; end
		local usedebuffcolor = "true"; if (not desc.sbcolor) then usedebuffcolor = "false"; end
		local auranametrunc = "nil"; if desc.trunc then auranametrunc = desc.trunc; end
		local auranameab = "true"; if (not desc.abr) then auranameab = "false"; end
		local sorticons = " "; 
		desc.sort = nil;
		if desc.sort then
			if desc.sortduration then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._dur < x2._dur; end); ]];
			end
			if desc.sortstack then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._apps < x2._apps; end); ]];
			end
			if desc.sorttimeleft then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._tl < x2._tl; end); ]];
			end
			if desc.sortname then sorticons = sorticons .. [[
			table.sort(sort_icons, function(x1,x2) return x1._bn < x2._bn; end); ]];
			end
			
		end
		
		local sbblendcolor = "false"; if desc.sbblendcolor then sbblendcolor = "true"; end
		
		local tet = desc.textType or "VFL.Hundredths";
		local showduration = "false"; if desc.showduration then showduration = "true"; end
		local blendcolor = "false"; if desc.blendcolor then blendcolor = "true"; end
		if not desc.color1 then desc.color1 = _white; end
		if not desc.color2 then desc.color2 = _white; end
		
		local showicon = "nil"; if desc.sbtib and desc.sbtib.showicon then showicon = "true"; end
		local showtimertext = "nil"; if desc.sbtib and desc.sbtib.showtimertext then showtimertext = "true"; end
		
		-- If there's an external filter, add a quick menu to the window to edit it.
		if desc.externalNameFilter then
			local path = desc.externalNameFilter; local afname = desc.name;
			state:GetContainingWindowState():Attach("Menu", true, function(win, mnu)
				table.insert(mnu, {
					text = VFLI.i18n("Edit AuraFilter: ") .. afname;
					OnClick = function()
						VFL.poptree:Release();
						RDXDB.OpenObject(path, "Edit", VFLDIALOG);
					end;
				});
			end);
		end

		------------ Closure
		local closureCode = [[
local ftc_]] .. objname .. [[ = FreeTimer.CreateFreeTimerClass(true, ]] .. showtimertext .. [[ , nil, VFLUI.GetTextTimerTypesString("]] .. tet .. [["), false, false, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide, ]] .. showduration .. [[, ]] .. blendcolor .. [[);
]];
		if desc.filterName then
			closureCode = closureCode .. [[
local ]] .. objname .. [[_fnames = ]];
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
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", auname) .. "] = true; ";
							else
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", auname) .. "] = true; ";
							end
						else
							if flag then
								name = "!" .. name;
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", name) .. "] = true; ";
							else
								closureCode = closureCode .. objname .. "_fnames[" .. string.format("%q", name) .. "] = true; ";
							end
						end
					end
				end
			end
		end
		
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		----------------- Creation
		local createCode = [[
frame.]] .. objname .. [[ = {};
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
for i=1,]] .. desc.nIcons .. [[ do
	btn = VFLUI.SBTIB:new(btnOwner, ]] .. Serialize(desc.sbtib) .. [[);
]];
		if desc.sbtib and desc.sbtib.btype == "Button" then
			createCode = createCode .. [[
	btn:SetScript("OnEnter", __AuraIconOnEnter);
	btn:SetScript("OnLeave", __AuraIconOnLeave);
	btn:RegisterForClicks("RightButtonUp");
	btn:SetScript("OnClick", __AuraIconOnClick);
]];
		end
	
		createCode = createCode .. [[
	btn.ftc = ftc_]] .. objname .. [[(btn, btn.sb, btn.timetxt, nil, nil, ]] .. Serialize(desc.color1) .. [[, ]] .. Serialize(desc.color2) .. [[);
	frame.]] .. objname .. [[[i] = btn;
end
]];
		createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
local btn = nil;
for i=1,]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i]
	btn.meta = nil;
	btn.ftc:Destroy(); btn.ftc = nil;
	btn:Destroy(); btn = nil;
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint

		local paintCodeWithoutSort = [[
if band(paintmask, ]] .. mask .. [[) ~= 0 then
	_i, _j, _bn, _tex, _apps, _meta, _dur, _tl, _dispelt, _caster, _isStealable = 1,1,nil,nil,nil,nil,nil,nil,nil,nil;
	_icons = frame.]] .. objname .. [[;
	while true do
		if (_j > ]] .. desc.nIcons .. [[) then break; end
		_, _bn, _, _, _meta, _, _tex, _apps, _dispelt, _dur, _, _tl, _caster, _isStealable = ]] .. loadCode .. [[(uid, _i, ]] .. raidfilter .. [[, ]] .. auracache .. [[);
		if not _meta then break; end
		if (not _meta.isInvisible) and ]] .. aurasfilter .. [[ and ]] .. isstealablefilter .. [[ and ]] .. curefilter .. [[ and ]] .. timefilter .. [[ and ]] .. namefilter .. [[ then
			btn = _icons[_j];
			if not btn:IsShown() then btn:Show(]] .. smooth .. [[); end
			
			if btn.icon then btn.icon:SetTexture(_tex); end
			
			if btn.nametxt then
				if ]] .. auranameab .. [[ then
					word, text = nil, "";
					for word in string.gmatch(_meta.properName, "%a+")
						do text = text .. word:sub(1, 1);
					end
					btn.nametxt:SetText(text);
				elseif ]] .. auranametrunc .. [[ then
					btn.nametxt:SetText(strsub(_meta.properName, 1, ]] .. auranametrunc .. [[));
				else
					btn.nametxt:SetText(_meta.properName);
				end
			end
			
			if "]] .. desc.auraType .. [[" == "DEBUFFS" and ]] .. usedebuffcolor .. [[ and _dispelt then
				btn.sb:SetColorTable(DebuffTypeColor[_dispelt]);
]];
if desc.sbblendcolor then 
			paintCodeWithoutSort = paintCodeWithoutSort .. [[
			elseif ]] .. sbblendcolor .. [[ then
				btn.ftc:SetSBBlendColor(]] .. desc.sbcolorVar1 .. [[, ]] .. desc.sbcolorVar2 .. [[);
]];
end			
			paintCodeWithoutSort = paintCodeWithoutSort .. [[
			else
				btn.sb:SetColorTable(_grey);
			end
			
			btn.ftc:SetFormula(]] .. countTypeFlag .. [[,']] .. desc.formulaType .. [[');
			if _dur and _dur > 0 and btn.ftc then
				btn.ftc:SetTimer(GetTime() + _tl - _dur , _dur);
			else
				btn.ftc:SetTimer(0, 0);
			end
			
			if btn.stacktxt then
				if _apps and _apps > 1 then btn.stacktxt:SetText(_apps); else btn.stacktxt:SetText(""); end
			end
			
			_j = _j + 1;
		end
		_i = _i + 1;
	end
	while _j <= ]] .. desc.nIcons .. [[ do
		if _icons[_j]:IsShown() then _icons[_j]:Hide(]] .. smooth .. [[); end
		_j = _j + 1;
	end
end
]];

		if desc.sort then
			state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		else
			state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCodeWithoutSort); end);
		end
		------------------- Cleanup
		local cleanupCode = [[
local btn = nil;
for i=1,]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i];
	btn:Hide(); btn.meta = nil;
end
]];
		state:Attach("EmitCleanup", true, function(code) code:AppendCode(cleanupCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		------------- Core
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Core Parameters")));

		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		ed_name.editBox:SetText(desc.name);
		ui:InsertFrame(ed_name);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Aura Type"));
		local dd_auraType = VFLUI.Dropdown:new(er, RDXUI.AurasTypesDropdownFunction);
		dd_auraType:SetWidth(150); dd_auraType:Show();
		if desc and desc.auraType then 
			dd_auraType:SetSelection(desc.auraType); 
		else
			dd_auraType:SetSelection("BUFFS");
		end
		er:EmbedChild(dd_auraType); er:Show();
		ui:InsertFrame(er);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local ed_mb = VFLUI.LabeledEdit:new(ui, 50); ed_mb:Show();
		ed_mb:SetText(VFLI.i18n("Max bars"));
		if desc and desc.nIcons then ed_mb.editBox:SetText(desc.nIcons); end
		ui:InsertFrame(ed_mb);

		local ed_rows = VFLUI.LabeledEdit:new(ui, 50); ed_rows:Show();
		ed_rows:SetText(VFLI.i18n("Row number"));
		if desc and desc.rows then ed_rows.editBox:SetText(desc.rows); end
		ui:InsertFrame(ed_rows);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation"));
		local dd_orientation = VFLUI.Dropdown:new(er, RDXUI.OrientationDropdownFunction);
		dd_orientation:SetWidth(75); dd_orientation:Show();
		if desc and desc.orientation then 
			dd_orientation:SetSelection(desc.orientation); 
		else
			dd_orientation:SetSelection("RIGHT");
		end
		er:EmbedChild(dd_orientation); er:Show();
		ui:InsertFrame(er);
		
		local ed_iconspx = VFLUI.LabeledEdit:new(ui, 50); ed_iconspx:Show();
		ed_iconspx:SetText(VFLI.i18n("Width spacing"));
		if desc and desc.iconspx then ed_iconspx.editBox:SetText(desc.iconspx); else ed_iconspx.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspx);
		
		local ed_iconspy = VFLUI.LabeledEdit:new(ui, 50); ed_iconspy:Show();
		ed_iconspy:SetText(VFLI.i18n("Height spacing"));
		if desc and desc.iconspy then ed_iconspy.editBox:SetText(desc.iconspy); else ed_iconspy.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspy);
		
		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Statusbar parameters")));
		
		local er2 = VFLUI.EmbedRight(ui, VFLI.i18n("Statusbar style"));
		local sbtib = VFLUI.MakeSBTIBSelectButton(er2, desc.sbtib); sbtib:Show();
		er2:EmbedChild(sbtib); er2:Show();
		ui:InsertFrame(er2);
		
		local countTypeFlag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Count type (true CountUP, false CountDOWN)"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.countTypeFlag then countTypeFlag:SetSelection(desc.countTypeFlag); end
		
		local tt = VFLUI.EmbedRight(ui, VFLI.i18n("Formula Type"));
		local dd_formulaType = VFLUI.Dropdown:new(tt, RDX.GetFormula);
		dd_formulaType:SetWidth(200); dd_formulaType:Show();
		if desc and desc.formulaType then 
			dd_formulaType:SetSelection(desc.formulaType); 
		else
			dd_formulaType:SetSelection("simple");
		end
		tt:EmbedChild(dd_formulaType); tt:Show();
		ui:InsertFrame(tt);
		
		local chk_bc = VFLUI.Checkbox:new(ui); chk_bc:Show();
		chk_bc:SetText(VFLI.i18n("Use Bar color debuff"));
		if desc and desc.sbcolor then chk_bc:SetChecked(true); else chk_bc:SetChecked(); end
		ui:InsertFrame(chk_bc);
		
		local chk_sbblendcolor = VFLUI.Checkbox:new(ui); chk_sbblendcolor:Show();
		chk_sbblendcolor:SetText(VFLI.i18n("Use blend color"));
		if desc and desc.sbblendcolor then chk_sbblendcolor:SetChecked(true); else chk_sbblendcolor:SetChecked(); end
		ui:InsertFrame(chk_sbblendcolor);
		
		local sbcolorVar1 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Static empty color"), state, "ColorVar_");
		if desc and desc.sbcolorVar1 and type(desc.sbcolorVar1) == "string" then sbcolorVar1:SetSelection(desc.sbcolorVar1); end
		
		local sbcolorVar2 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Static full color"), state, "ColorVar_");
		if desc and desc.sbcolorVar2 and type(desc.sbcolorVar2) == "string" then sbcolorVar2:SetSelection(desc.sbcolorVar2); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Timer parameters")));
		
		local tt = VFLUI.EmbedRight(ui, VFLI.i18n("Text Timer Type"));
		local dd_textType = VFLUI.Dropdown:new(tt, VFLUI.TextTypesDropdownFunction);
		dd_textType:SetWidth(200); dd_textType:Show();
		if desc and desc.textType then 
			dd_textType:SetSelection(desc.textType); 
		else
			dd_textType:SetSelection("VFL.Hundredths");
		end
		tt:EmbedChild(dd_textType); tt:Show();
		ui:InsertFrame(tt);
		
		local chk_blendcolor = VFLUI.Checkbox:new(ui); chk_blendcolor:Show();
		chk_blendcolor:SetText(VFLI.i18n("Use blend color"));
		if desc and desc.blendcolor then chk_blendcolor:SetChecked(true); else chk_blendcolor:SetChecked(); end
		ui:InsertFrame(chk_blendcolor);
		
		local color1 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Static empty color"));
		if desc and desc.color1 then color1:SetColor(VFL.explodeRGBA(desc.color1)); end

		local color2 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Static full color"));
		if desc and desc.color2 then color2:SetColor(VFL.explodeRGBA(desc.color2)); end
		
		local chk_duration = VFLUI.Checkbox:new(ui); chk_duration:Show();
		chk_duration:SetText(VFLI.i18n("Show max duration"));
		if desc and desc.showduration then chk_duration:SetChecked(true); else chk_duration:SetChecked(); end
		ui:InsertFrame(chk_duration);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Aura name parameters")));
		
		local ed_trunc = VFLUI.LabeledEdit:new(ui, 50); ed_trunc:Show();
		ed_trunc:SetText(VFLI.i18n("Max aura length (blank = no truncation)"));
		if desc and desc.trunc then ed_trunc.editBox:SetText(desc.trunc); end
		ui:InsertFrame(ed_trunc);
		
		local chk_abr = VFLUI.Checkbox:new(ui); chk_abr:Show();
		chk_abr:SetText(VFLI.i18n("Use abbreviating"));
		if desc and desc.abr then chk_abr:SetChecked(true); else chk_abr:SetChecked(); end
		ui:InsertFrame(chk_abr);
		
		local chk_smooth = VFLUI.Checkbox:new(ui); chk_smooth:Show();
		chk_smooth:SetText(VFLI.i18n("Use smooth on show and hide"));
		if desc and desc.smooth then chk_smooth:SetChecked(true); else chk_smooth:SetChecked(); end
		ui:InsertFrame(chk_smooth);
		
		------------ Sort
		--[[ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Sort")));
		
		local chk_sort = VFLUI.Checkbox:new(ui); chk_sort:Show();
		chk_sort:SetText(VFLI.i18n("Activate Sort"));
		if desc and desc.sort then chk_sort:SetChecked(true); else chk_sort:SetChecked(); end
		ui:InsertFrame(chk_sort);
		
		local chk_sortstack = VFLUI.Checkbox:new(ui); chk_sortstack:Show();
		chk_sortstack:SetText(VFLI.i18n("Sort by stack"));
		if desc and desc.sortstack then chk_sortstack:SetChecked(true); else chk_sortstack:SetChecked(); end
		ui:InsertFrame(chk_sortstack);
		
		local chk_sortduration = VFLUI.Checkbox:new(ui); chk_sortduration:Show();
		chk_sortduration:SetText(VFLI.i18n("Sort by duration"));
		if desc and desc.sortduration then chk_sortduration:SetChecked(true); else chk_sortduration:SetChecked(); end
		ui:InsertFrame(chk_sortduration);
		
		local chk_sorttimeleft = VFLUI.Checkbox:new(ui); chk_sorttimeleft:Show();
		chk_sorttimeleft:SetText(VFLI.i18n("Sort by timeleft"));
		if desc and desc.sorttimeleft then chk_sorttimeleft:SetChecked(true); else chk_sorttimeleft:SetChecked(); end
		ui:InsertFrame(chk_sorttimeleft);
		
		local chk_sortname = VFLUI.Checkbox:new(ui); chk_sortname:Show();
		chk_sortname:SetText(VFLI.i18n("Sort by name"));
		if desc and desc.sortname then chk_sortname:SetChecked(true); else chk_sortname:SetChecked(); end
		ui:InsertFrame(chk_sortname);]]

		------------ Filter
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering parameters")));

		local chk_raidfilter = VFLUI.Checkbox:new(ui); chk_raidfilter:Show();
		chk_raidfilter:SetText(VFLI.i18n("Use Blizzard raid filter"));
		if desc and desc.raidfilter then chk_raidfilter:SetChecked(true); else chk_raidfilter:SetChecked(); end
		ui:InsertFrame(chk_raidfilter);
		
		local chk_playerauras = VFLUI.Checkbox:new(ui); chk_playerauras:Show();
		chk_playerauras:SetText(VFLI.i18n("Filter auras by player"));
		if desc and desc.playerauras then chk_playerauras:SetChecked(true); else chk_playerauras:SetChecked(); end
		ui:InsertFrame(chk_playerauras);
		
		local chk_othersauras = VFLUI.Checkbox:new(ui); chk_othersauras:Show();
		chk_othersauras:SetText(VFLI.i18n("Filter auras by other players"));
		if desc and desc.othersauras then chk_othersauras:SetChecked(true); else chk_othersauras:SetChecked(); end
		ui:InsertFrame(chk_othersauras);

		local chk_petauras = VFLUI.Checkbox:new(ui); chk_petauras:Show();
		chk_petauras:SetText(VFLI.i18n("Filter auras by pet/vehicle"));
		if desc and desc.petauras then chk_petauras:SetChecked(true); else chk_petauras:SetChecked(); end
		ui:InsertFrame(chk_petauras);
		
		local chk_targetauras = VFLUI.Checkbox:new(ui); chk_targetauras:Show();
		chk_targetauras:SetText(VFLI.i18n("Filter auras by target"));
		if desc and desc.targetauras then chk_targetauras:SetChecked(true); else chk_targetauras:SetChecked(); end
		ui:InsertFrame(chk_targetauras);
		
		local chk_focusauras = VFLUI.Checkbox:new(ui); chk_focusauras:Show();
		chk_focusauras:SetText(VFLI.i18n("Filter auras by focus"));
		if desc and desc.focusauras then chk_focusauras:SetChecked(true); else chk_focusauras:SetChecked(); end
		ui:InsertFrame(chk_focusauras);
		
		local chk_nameauras = VFLUI.Checkbox:new(ui); chk_nameauras:Show();
		chk_nameauras:SetText(VFLI.i18n("Filter auras by name"));
		if desc and desc.nameauras then chk_nameauras:SetChecked(true); else chk_nameauras:SetChecked(); end
		ui:InsertFrame(chk_nameauras);
		
		local ed_unitfilter = VFLUI.LabeledEdit:new(ui, 200); ed_unitfilter:Show();
		ed_unitfilter:SetText(VFLI.i18n("Name of the unit"));
		if desc and desc.unitfilter then ed_unitfilter.editBox:SetText(desc.unitfilter); else ed_unitfilter.editBox:SetText(""); end
		ui:InsertFrame(ed_unitfilter);
		
		local chk_isStealable = VFLUI.Checkbox:new(ui); chk_isStealable:Show();
		chk_isStealable:SetText(VFLI.i18n("Show only Stealable auras"));
		if desc and desc.isstealablefilter then chk_isStealable:SetChecked(true); else chk_isStealable:SetChecked(); end
		ui:InsertFrame(chk_isStealable);
		
		local chk_curefilter = VFLUI.Checkbox:new(ui); chk_curefilter:Show();
		chk_curefilter:SetText(VFLI.i18n("Show only auras that I can cure"));
		if desc and desc.curefilter then chk_curefilter:SetChecked(true); else chk_curefilter:SetChecked(); end
		ui:InsertFrame(chk_curefilter);
		
		local chk_notimefilter = VFLUI.Checkbox:new(ui); chk_notimefilter:Show();
		chk_notimefilter:SetText(VFLI.i18n("Show only auras with no timer"));
		if desc and desc.notimefilter then chk_notimefilter:SetChecked(true); else chk_notimefilter:SetChecked(); end
		ui:InsertFrame(chk_notimefilter);
		
		local chk_timefilter = VFLUI.Checkbox:new(ui); chk_timefilter:Show();
		chk_timefilter:SetText(VFLI.i18n("Show only auras with timer"));
		if desc and desc.timefilter then chk_timefilter:SetChecked(true); else chk_timefilter:SetChecked(); end
		ui:InsertFrame(chk_timefilter);
                
		local ed_maxduration = VFLUI.LabeledEdit:new(ui, 50); ed_maxduration:Show();
		ed_maxduration:SetText(VFLI.i18n("Filter by Max duration (sec)"));
		if desc and desc.maxdurationfilter then ed_maxduration.editBox:SetText(desc.maxdurationfilter); else ed_maxduration.editBox:SetText(""); end
		ui:InsertFrame(ed_maxduration);
		
		local ed_minduration = VFLUI.LabeledEdit:new(ui, 50); ed_minduration:Show();
		ed_minduration:SetText(VFLI.i18n("Filter by min duration (sec)"));
		if desc and desc.mindurationfilter then ed_minduration.editBox:SetText(desc.mindurationfilter); else ed_minduration.editBox:SetText(""); end
		ui:InsertFrame(ed_minduration);

		local chk_filterName = VFLUI.Checkbox:new(ui); chk_filterName:Show();
		chk_filterName:SetText(VFLI.i18n("Filter by aura name"));
		if desc and desc.filterName then chk_filterName:SetChecked(true); else chk_filterName:SetChecked(); end
		ui:InsertFrame(chk_filterName);

		local chk_external = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use external aura list"));
		local file_external = RDXDB.ObjectFinder:new(chk_external, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "AuraFilter$")); end);
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
			local ssbcolor1, ssbcolor2, scolor1, scolor2, sstack, sstackVar, sstackMax, sTL = nil, nil, nil, nil, nil, nil, nil, 0;
			if chk_sbblendcolor:GetChecked() then
				ssbcolor1 = strtrim(sbcolorVar1:GetSelection() or ""); 
				ssbcolor2 = strtrim(sbcolorVar2:GetSelection() or "");
				if ssbcolor1 == "" then ssbcolor1 = nil; end
				if ssbcolor2 == "" then ssbcolor2 = nil; end
			end
			if chk_blendcolor:GetChecked() then
				scolor1 = color1:GetColor(); scolor2 = color2:GetColor();
			end
			local trunc = tonumber(ed_trunc.editBox:GetText());
			if trunc then trunc = VFL.clamp(trunc, 1, 50); end
			local filterName, filterNameList, filternl, ext, unitfi = nil, nil, {}, nil, "";
			if chk_nameauras:GetChecked() then
				unitfi = string.lower(ed_unitfilter.editBox:GetText());
			end
			if chk_timefilter:GetChecked() then
				maxdurfil = ed_maxduration.editBox:GetText();
				mindurfil = ed_minduration.editBox:GetText();
				chk_notimefilter:SetChecked();
			end
			if chk_filterName:GetChecked() then
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
				if chk_external:GetChecked() then ext = file_external:GetPath(); end
			end
			--if  not chk_sort:GetChecked() then
			--	chk_sortstack:SetChecked();
			--	chk_sortduration:SetChecked();
			--	chk_sorttimeleft:SetChecked();
			--	chk_sortname:SetChecked();
			--end
			return { 
				feature = "aura_bars2"; 
				version = 2;
				name = ed_name.editBox:GetText();
				auraType = dd_auraType:GetSelection();
				-- layout
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				nIcons = VFL.clamp(ed_mb.editBox:GetNumber(), 1, 40);
				rows = VFL.clamp(ed_rows.editBox:GetNumber(), 1, 40);
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), -100, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), -100, 200);
				-- display bar
				sbtib = sbtib:GetSelectedSBTIB();
				countTypeFlag = countTypeFlag:GetSelection();
				formulaType = dd_formulaType:GetSelection();
				sbcolor = chk_bc:GetChecked();
				sbblendcolor = chk_sbblendcolor:GetChecked();
				sbcolorVar1 = ssbcolor1; sbcolorVar2 = ssbcolor2;
				-- timer text
				blendcolor = chk_blendcolor:GetChecked();
				color1 = scolor1; color2 = scolor2;
				textType = dd_textType:GetSelection();
				showduration = chk_duration:GetChecked();
				-- fonts
				trunc = trunc;
				abr = chk_abr:GetChecked();
				-- smooth
				smooth = chk_smooth:GetChecked();
				-- filter
				raidfilter = chk_raidfilter:GetChecked();
				playerauras = chk_playerauras:GetChecked();
				othersauras = chk_othersauras:GetChecked();
				petauras = chk_petauras:GetChecked();
				targetauras = chk_targetauras:GetChecked();
				focusauras = chk_focusauras:GetChecked();
				nameauras = chk_nameauras:GetChecked();
				unitfilter = unitfi;
				isstealablefilter = chk_isStealable:GetChecked();
				curefilter = chk_curefilter:GetChecked();
				notimefilter = chk_notimefilter:GetChecked();
				timefilter = chk_timefilter:GetChecked();
				maxdurationfilter = maxdurfil;
				mindurationfilter = mindurfil;
				filterName = chk_filterName:GetChecked();
				externalNameFilter = ext;
				filterNameList = filternl;
				-- sort
				--sort = chk_sort:GetChecked();
				--sortstack = chk_sortstack:GetChecked();
				--sortduration = chk_sortduration:GetChecked();
				--sorttimeleft = chk_sorttimeleft:GetChecked();
				--sortname = chk_sortname:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "aura_bars2";
			version = 1;
			name = "ab1";
			auraType = "BUFFS";
			owner = "Frame_decor";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			nIcons = 10; rows = 1; orientation = "DOWN"; iconspx = 0; iconspy = 1;
			sbtib = VFL.copy(VFLUI.defaultSBTIB);
		};
	end;
});

