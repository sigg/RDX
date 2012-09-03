-- HeaderAuraIconList.lua
-- OpenRDX - Sigg - Rashgarroth FR
--

RDX.RegisterFeature({
	name = "sec_aura_bars";
	version = 1;
	title = VFLI.i18n("Bars Aura Secured");
	category = VFLI.i18n("Lists");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		desc.owner = "Base";
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Bars_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		if flg then state:AddSlot("Bars_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Bars_" .. desc.name;
		if not desc.formulaType then desc.formulaType = "simple"; end
		local countTypeFlag = "nil" if desc.countTypeFlag and desc.countTypeFlag ~= "" then countTypeFlag = desc.countTypeFlag; end
		local usedebuffcolor = "true"; if (not desc.sbcolor) then usedebuffcolor = "false"; end
		local auranametrunc = "nil"; if desc.trunc then auranametrunc = desc.trunc; end
		local auranameab = "true"; if (not desc.abr) then auranameab = "false"; end
		
		local showweapons = "false";
		if desc.showweapons then showweapons = "true"; end
		local sortdir = "+";
		if desc.sortdir then sortdir = "-"; end
		local separateown = "0";
		if desc.separateown == "BEFORE" then sortdir = "1"; end
		if desc.separateown == "AFTER" then sortdir = "-1"; end
		
		local showicon = "nil"; if desc.sbtib and desc.sbtib.showicon then showicon = "true"; end
		local showtimertext = "nil"; if desc.sbtib and desc.sbtib.showtimertext then showtimertext = "true"; end
		
		local _, _, dx, dy = string.find(desc.template, "^RDXAB(.*)x(.*)Template$");
		--local borientation, isize, barx, bary;
		--if desc.showtex then
		--	borientation, isize, barx, bary = "HORIZONTAL", dy, dx - dy, dy;
		--	if dy > dx then borientation = "VERTICAL"; isize = dx; barx = dx; bary = dy - dx; end
		--else
		--	borientation, isize, barx, bary = "HORIZONTAL", dy, dx, dy;
		--	if dy > dx then borientation = "VERTICAL"; isize = dx; barx = dx; bary = dy; end
		--end
		
		-- Event hinting.
		--local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		local filter;
		if desc.auraType == "DEBUFFS" then
		--	mask = mux:GetPaintMask("DEBUFFS");
		--	mux:Event_UnitMask("DELAYED_UNIT_DEBUFF_*", mask);
			filter = "HARMFUL";
		else
		--	mask = mux:GetPaintMask("BUFFS");
		--	mux:Event_UnitMask("DELAYED_UNIT_BUFF_*", mask);
			filter = "HELPFUL";
		end
		--local smask = mux:GetPaintMask("UNIT_BUFFWEAPON");
		--mux:Event_UnitMask("UNIT_BUFFWEAPON_UPDATE", smask);
		
		--mask = bit.bor(mask, 1);
		
		------------ Closure
		local closureCode = [[
local ftc_]] .. objname .. [[ = FreeTimer.CreateFreeTimerClass(true, ]] .. showtimertext .. [[, nil, VFLUI.GetTextTimerTypesString("MinSec"), false, false, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide);
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		----------------- Creation
		local createCode = [[
local headerAura = RDX.SmartHeaderAura:new();
headerAura:SetParent(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
headerAura:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
headerAura:SetAttribute("useparent-unit", true); 
headerAura:SetAttribute("useparent-unitsuffix", true); 
headerAura:SetAttribute("filter", "]] .. filter .. [[");
headerAura:SetAttribute("template", "]] .. desc.template .. [[");
if ]] .. showweapons .. [[ then
	headerAura:SetAttribute("includeWeapons", 1);
	headerAura:SetAttribute("weaponTemplate", "]] .. desc.template .. [[");
end
headerAura:SetAttribute("minWidth", 100);
headerAura:SetAttribute("minHeight", 100);
headerAura:SetOrientation("]] .. desc.template .. [[", "]] .. desc.orientation .. [[", ]] .. desc.wrapafter .. [[, ]] .. desc.maxwraps .. [[, ]] .. desc.xoffset .. [[, ]] .. desc.yoffset .. [[);
headerAura:SetAttribute("sortMethod", "]] .. desc.sortmethod .. [[");
headerAura:SetAttribute("sortDir", "]] .. sortdir .. [[");
headerAura:SetAttribute("separateOwn", ]] .. separateown .. [[);
headerAura:Show();

headerAura.updateFunc = function(self)
	for _,frame in self:ActiveChildren() do
		if not frame.btn then
			local btn = VFLUI.SBTIB:new(frame, ]] .. Serialize(desc.sbtib) .. [[);
			btn:SetPoint("TOPLEFT", frame, "TOPLEFT");
			btn.ftc = ftc_]] .. objname .. [[(btn, btn.sb, btn.timetxt);
			frame.btn = btn;
		end
		_bn, _, _tex, _apps, _dispelt, _dur, _et = UnitAura("player", frame:GetID(), "]] .. filter .. [[");
		if _bn then
			if frame.btn.icon then frame.btn.icon:SetTexture(_tex); end
			if frame.btn.nametxt then
				if ]] .. auranameab .. [[ then
					local word, anstr = nil, "";
					for word in string.gmatch(_bn, "%a+")
						do anstr = anstr .. word:sub(1, 1);
					end
					frame.btn.nametxt:SetText(anstr);
				elseif ]] .. auranametrunc .. [[ then
					frame.btn.nametxt:SetText(strsub(_bn, 1, ]] .. auranametrunc .. [[));
				else
					frame.btn.nametxt:SetText(_bn);
				end
			end
			
			if ]] .. desc.auraType .. [[ == "DEBUFFS" and ]] .. usedebuffcolor .. [[ then
				if _dispelt then
					btn.sb:SetColorTable(DebuffTypeColor[_dispelt]);
				else
					btn.sb:SetColorTable(_grey);
				end
			end
			
			frame.btn.ftc:SetFormula(]] .. countTypeFlag .. [[,']] .. desc.formulaType .. [[');
			frame.btn.ftc:SetTimer(_et - _dur , _dur);
			if _apps > 1 then frame.btn.stacktxt:SetText(_apps); else frame.btn.stacktxt:SetText("");end
			
			frame.btn:Show();
		else
			frame.btn:Hide();
		end
	end
	local hasMainHandEnchant, mainHandBuffName, mainHandBuffRank, mainHandCharges, mainHandBuffStart, mainHandBuffDur, mainHandTex, mainHandBuffTex, mainHandSlot, hasOffHandEnchant, offHandBuffName, offHandBuffRank, offHandCharges, offHandBuffStart, offHandBuffDur, offHandTex, offHandBuffTex, offHandSlot;
	local tempEnchant1 = self:GetAttribute("tempEnchant1");
	local tempEnchant2 = self:GetAttribute("tempEnchant2");
	if tempEnchant1 or tempEnchant2 then
		hasMainHandEnchant, mainHandBuffName, mainHandBuffRank, mainHandCharges, mainHandBuffStart, mainHandBuffDur, mainHandTex, mainHandBuffTex, mainHandSlot, hasOffHandEnchant, offHandBuffName, offHandBuffRank, offHandCharges, offHandBuffStart, offHandBuffDur, offHandTex, offHandBuffTex, offHandSlot = RDXDAL.LoadWeaponsBuff();
	end
	if tempEnchant1 then
		if not tempEnchant1.btn then
			local btn = VFLUI.SBTIB:new(tempEnchant1, ]] .. Serialize(desc.sbtib) .. [[);
			btn:SetPoint("TOPLEFT", frame, "TOPLEFT");
			btn.ftc = ftc_]] .. objname .. [[(btn, btn.sb, btn.timetxt);
			tempEnchant1.btn = btn;
		end
		if hasMainHandEnchant then
			tempEnchant1.btn.icon:SetTexture(mainHandTex);
			if tempEnchant1.btn.nametxt then
				if ]] .. auranameab .. [[ then
					local word, anstr = nil, "";
					for word in string.gmatch(mainHandBuffName, "%a+")
						do anstr = anstr .. word:sub(1, 1);
					end
					tempEnchant1.btn.nametxt:SetText(anstr);
				elseif ]] .. auranametrunc .. [[ then
					tempEnchant1.btn.nametxt:SetText(strsub(mainHandBuffName, 1, ]] .. auranametrunc .. [[));
				else
					tempEnchant1.btn.nametxt:SetText(mainHandBuffName);
				end
			end
			tempEnchant1.btn.ftc:SetFormula(]] .. countTypeFlag .. [[,']] .. desc.formulaType .. [[');
			tempEnchant1.btn.ftc:SetTimer(mainHandBuffStart, mainHandBuffDur);
			if mainHandCharges > 1 then tempEnchant1.btn.stacktxt:SetText(mainHandCharges); else tempEnchant1.btn.stacktxt:SetText("");end
			tempEnchant1.btn:Show();
		else
			tempEnchant1.btn:Hide();
		end
	end
	if tempEnchant2 then
		if not tempEnchant2.btn then
			local btn = VFLUI.SBTIB:new(tempEnchant2, ]] .. Serialize(desc.sbtib) .. [[);
			btn:SetPoint("TOPLEFT", frame, "TOPLEFT");
			btn.ftc = ftc_]] .. objname .. [[(btn, btn.sb, btn.timetxt);
			tempEnchant2.btn = btn;
		end
		if hasOffHandEnchant then
			tempEnchant2.btn.icon:SetTexture(offHandTex);
			if tempEnchant2.btn.nametxt then
				if ]] .. auranameab .. [[ then
					local word, anstr = nil, "";
					for word in string.gmatch(offHandBuffName, "%a+")
						do anstr = anstr .. word:sub(1, 1);
					end
					tempEnchant2.btn.nametxt:SetText(anstr);
				elseif ]] .. auranametrunc .. [[ then
					tempEnchant2.btn.nametxt:SetText(strsub(offHandBuffName, 1, ]] .. auranametrunc .. [[));
				else
					tempEnchant2.btn.nametxt:SetText(offHandBuffName);
				end
			end
			tempEnchant2.btn.ftc:SetFormula(]] .. countTypeFlag .. [[,']] .. desc.formulaType .. [[');
			tempEnchant2.btn.ftc:SetTimer(offHandBuffStart, offHandBuffDur);
			if offHandCharges > 1 then tempEnchant2.btn.stacktxt:SetText(offHandCharges); else tempEnchant2.btn.stacktxt:SetText("");end
			tempEnchant2.btn:Show();
		else
			tempEnchant2.btn:Hide();
		end
	end
end

headerAura:updateFunc();
frame.]] .. objname .. [[ = headerAura;
]];
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
for _,frame in frame.]] .. objname .. [[:ActiveChildren() do
	local btn = frame.btn;
	if btn then
		btn.ftc:Destroy(); btn.ftc = nil;
		btn:Destroy(); btn = nil;
	end
	frame.btn = nil;
end
local tempEnchant1 = frame.]] .. objname .. [[:GetAttribute("tempEnchant1");
if tempEnchant1 then
	local btn = tempEnchant1.btn;
	if btn then
		btn.ftc:Destroy(); btn.ftc = nil;
		btn:Destroy(); btn = nil;
	end
	tempEnchant1.btn = nil;
end
local tempEnchant2 = frame.]] .. objname .. [[:GetAttribute("tempEnchant2");
if tempEnchant2 then
	local btn = tempEnchant2.btn;
	if btn then
		btn.ftc:Destroy(); btn.ftc = nil;
		btn:Destroy(); btn = nil;
	end
	tempEnchant2.btn = nil;
end
frame.]] .. objname .. [[:Destroy();
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

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
		
		local chk_showweapons = VFLUI.Checkbox:new(ui); chk_showweapons:Show();
		chk_showweapons:SetText(VFLI.i18n("Show Weapons Enchant"));
		if desc and desc.showweapons then chk_showweapons:SetChecked(true); else chk_showweapons:SetChecked(); end
		ui:InsertFrame(chk_showweapons);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));

		--local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", }, true);
		--if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Template"));
		local dd_template = VFLUI.Dropdown:new(er, RDX.BarTemplatesFunc);
		dd_template:SetWidth(250); dd_template:Show();
		if desc and desc.template then 
			dd_template:SetSelection(desc.template); 
		else
			dd_template:SetSelection("RDXAB20x120Template");
		end
		er:EmbedChild(dd_template); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Point"));
		local dd_point = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
		dd_point:SetWidth(150); dd_point:Show();
		if desc and desc.point then 
			dd_point:SetSelection(desc.point); 
		else
			dd_point:SetSelection("TOPLEFT");
		end
		er:EmbedChild(dd_point); er:Show();
		ui:InsertFrame(er);
		
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
		
		local ed_wrapafter = VFLUI.LabeledEdit:new(ui, 50); ed_wrapafter:Show();
		ed_wrapafter:SetText(VFLI.i18n("Wrap After"));
		if desc and desc.wrapafter then ed_wrapafter.editBox:SetText(desc.wrapafter); else ed_wrapafter.editBox:SetText("10"); end
		ui:InsertFrame(ed_wrapafter);
		
		local ed_maxwraps = VFLUI.LabeledEdit:new(ui, 50); ed_maxwraps:Show();
		ed_maxwraps:SetText(VFLI.i18n("Max Wraps"));
		if desc and desc.maxwraps then ed_maxwraps.editBox:SetText(desc.maxwraps); else ed_maxwraps.editBox:SetText("1"); end
		ui:InsertFrame(ed_maxwraps);
		
		local ed_xoffset = VFLUI.LabeledEdit:new(ui, 50); ed_xoffset:Show();
		ed_xoffset:SetText(VFLI.i18n("Offset x"));
		if desc and desc.xoffset then ed_xoffset.editBox:SetText(desc.xoffset); else ed_xoffset.editBox:SetText("0"); end
		ui:InsertFrame(ed_xoffset);
		
		local ed_yoffset = VFLUI.LabeledEdit:new(ui, 50); ed_yoffset:Show();
		ed_yoffset:SetText(VFLI.i18n("Offset y"));
		if desc and desc.yoffset then ed_yoffset.editBox:SetText(desc.yoffset); else ed_yoffset.editBox:SetText("0"); end
		ui:InsertFrame(ed_yoffset);
		
		-------------- display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Display parameters")));
		
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
			dd_formulaType:SetSelection("simplereverse");
		end
		tt:EmbedChild(dd_formulaType); tt:Show();
		ui:InsertFrame(tt);
		
		local chk_bc = VFLUI.Checkbox:new(ui); chk_bc:Show();
		chk_bc:SetText(VFLI.i18n("Use Bar color debuff"));
		if desc and desc.sbcolor then chk_bc:SetChecked(true); else chk_bc:SetChecked(); end
		ui:InsertFrame(chk_bc);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Font parameters")));
		
		local ed_trunc = VFLUI.LabeledEdit:new(ui, 50); ed_trunc:Show();
		ed_trunc:SetText(VFLI.i18n("Max aura length (blank = no truncation)"));
		if desc and desc.trunc then ed_trunc.editBox:SetText(desc.trunc); end
		ui:InsertFrame(ed_trunc);
		
		local chk_abr = VFLUI.Checkbox:new(ui); chk_abr:Show();
		chk_abr:SetText(VFLI.i18n("Use abbreviating"));
		if desc and desc.abr then chk_abr:SetChecked(true); else chk_abr:SetChecked(); end
		ui:InsertFrame(chk_abr);
		
		------------ Sort
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Sort parameters")));
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Sort Method"));
		local dd_sortMethod = VFLUI.Dropdown:new(er, RDX.SortMethodFunc);
		dd_sortMethod:SetWidth(75); dd_sortMethod:Show();
		if desc and desc.sortmethod then 
			dd_sortMethod:SetSelection(desc.sortmethod); 
		else
			dd_sortMethod:SetSelection("INDEX");
		end
		er:EmbedChild(dd_sortMethod); er:Show();
		ui:InsertFrame(er);
		
		local chk_sortDir = VFLUI.Checkbox:new(ui); chk_sortDir:Show();
		chk_sortDir:SetText(VFLI.i18n("Sort Direction -"));
		if desc and desc.sortdir then chk_sortDir:SetChecked(true); else chk_sortDir:SetChecked(); end
		ui:InsertFrame(chk_sortDir);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Separate Own"));
		local dd_separateOwn = VFLUI.Dropdown:new(er, RDX.SeparateOwnFunc);
		dd_separateOwn:SetWidth(75); dd_separateOwn:Show();
		if desc and desc.separateown then 
			dd_separateOwn:SetSelection(desc.separateown); 
		else
			dd_separateOwn:SetSelection("NONE");
		end
		er:EmbedChild(dd_separateOwn); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "sec_aura_bars"; version = 1;
				name = ed_name.editBox:GetText();
				auraType = dd_auraType:GetSelection();
				showweapons = chk_showweapons:GetChecked();
				-- layout
				owner = "Base";
				anchor = anchor:GetAnchorInfo();
				template = dd_template:GetSelection();
				point = dd_point:GetSelection();
				orientation = dd_orientation:GetSelection();
				wrapafter = VFL.clamp(ed_wrapafter.editBox:GetNumber(), 1, 40);
				maxwraps = VFL.clamp(ed_maxwraps.editBox:GetNumber(), 1, 40);
				xoffset = VFL.clamp(ed_xoffset.editBox:GetNumber(), -10, 10);
				yoffset = VFL.clamp(ed_yoffset.editBox:GetNumber(), -10, 10);
				-- display
				sbtib = sbtib:GetSelectedSBTIB();
				countTypeFlag = countTypeFlag:GetSelection();
				formulaType = dd_formulaType:GetSelection();
				sbcolor = chk_bc:GetChecked();
				-- fonts
				trunc = trunc;
				abr = chk_abr:GetChecked();
				-- sort
				sortmethod = dd_sortMethod:GetSelection();
				sortdir = chk_sortDir:GetChecked();
				separateown = dd_separateOwn:GetSelection();
			};
		end
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "sec_aura_bars";
			version = 1;
			name = "sab1";
			auraType = "BUFFS";
			owner = "Base";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			template = "RDXAB20x120Template"; orientation = "LEFT"; wrapafter = 10; maxwraps = 2; xoffset = 0; yoffset = 0;
			sbtib = VFL.copy(VFLUI.defaultSBTIB);
			countTypeFlag = "true";
			sortmethod = "INDEX";
			separateown = "NONE";
		};
	end;
});


