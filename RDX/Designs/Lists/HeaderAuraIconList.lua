-- HeaderAuraIconList.lua
-- OpenRDX - Sigg - Rashgarroth FR
--

RDX.RegisterFeature({
	name = "sec_aura_icons";
	version = 1;
	title = VFLI.i18n("Icons Aura Secured");
	category = VFLI.i18n("Lists");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if not desc.usebkd then desc.usebs = true; end
		if not desc.xoffset then desc.xoffset = "0"; end
		if not desc.yoffset then desc.yoffset = "0"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Icons_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs, true);
		if flg then state:AddSlot("Icons_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Icons_" .. desc.name;
		local usebs = "false"; if desc.usebs then usebs = "true"; end
		local ebs = desc.externalButtonSkin or "bs_default";
		local usebkd = "false"; if desc.usebkd then usebkd = "true"; end
		local bkd = desc.bkd or VFLUI.defaultBackdrop;	
		local os = 0; 
		if desc.usebs then 
			os = desc.ButtonSkinOffset or 0;
		elseif desc.usebkd then
			if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
		end
		
		local r, g, b, a = bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1;
		
		local showweapons = "false";
		if desc.showweapons then showweapons = "true"; end
		local sortdir = "+";
		if desc.sortdir then sortdir = "-"; end
		local separateown = "0";
		if desc.separateown == "BEFORE" then sortdir = "1"; end
		if desc.separateown == "AFTER" then sortdir = "-1"; end
		
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
headerAura:SetAttribute("minWidth", 1);
headerAura:SetAttribute("minHeight", 1);
headerAura:SetAttribute("point", "]] .. desc.point .. [[");
headerAura:SetOrientation("]] .. desc.template .. [[", "]] .. desc.orientation .. [[", ]] .. desc.wrapafter .. [[, ]] .. desc.maxwraps .. [[, ]] .. desc.xoffset .. [[, ]] .. desc.yoffset .. [[);
headerAura:SetAttribute("sortMethod", "]] .. desc.sortmethod .. [[");
headerAura:SetAttribute("sortDir", "]] .. sortdir .. [[");
headerAura:SetAttribute("separateOwn", ]] .. separateown .. [[);
headerAura:Show();

headerAura.updateFunc = function(self)
	for _,child in self:ActiveChildren() do
		if not child.btn then
			local btn;
			if ]] .. usebs .. [[ then 
				btn = VFLUI.SkinButton:new();
				btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, true);
			elseif ]] .. usebkd .. [[ then
				btn = VFLUI.AcquireFrame("Frame");
				VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
			else
				btn = VFLUI.AcquireFrame("Frame");
			end
			btn:SetParent(child); btn:SetFrameLevel(child:GetFrameLevel());
			btn:SetAllPoints(child);
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. os .. [[, -]] .. os .. [[);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. os .. [[, ]] .. os .. [[);
			btn.tex:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
			btn.tex:SetDrawLayer("ARTWORK", 2);
			btn.tex:Show();
			
			btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
			btn.cd:SetAllPoints(btn.tex);
			btn.cd:Show();
			
			btn.frtxt = VFLUI.AcquireFrame("Frame");
			btn.frtxt:SetParent(btn);
			btn.frtxt:SetFrameLevel(btn:GetFrameLevel() + 2);
			btn.frtxt:SetAllPoints(btn);
			btn.frtxt:Show();
			
			btn.sttxt = VFLUI.CreateFontString(btn.frtxt);
			btn.sttxt:SetAllPoints(btn.frtxt);
			btn.sttxt:Show();
			]];
			createCode = createCode .. VFLUI.GenerateSetFontCode("btn.sttxt", desc.fontst, nil, true);
			createCode = createCode .. [[
			btn.filter = "]] .. filter .. [[";
			child.btn = btn;
		end
		_bn, _, _tex, _apps, _dispelt, _dur, _et = UnitAura("player",child:GetID(), "]] .. filter .. [[");
		if _bn then
			child.btn.tex:SetTexture(_tex);
			if _dispelt and DebuffTypeColor[_dispelt] then
				if ]] .. usebs .. [[ then
					child.btn._texBorder:SetVertexColor(VFL.explodeColor(DebuffTypeColor[_dispelt]));
				elseif ]] .. usebkd .. [[ then
					child.btn:SetBackdropBorderColor(VFL.explodeRGBA(DebuffTypeColor[_dispelt]));
				end
			else
				if ]] .. usebs .. [[ then
					child.btn._texBorder:SetVertexColor(1, 1, 1, 1);
				elseif ]] .. usebkd .. [[ then
					child.btn:SetBackdropBorderColor(]] .. r .. [[, ]] .. g .. [[, ]] .. b .. [[, ]] .. a .. [[);
				end
			end
			child.btn.cd:SetCooldown(_et - _dur, _dur);
			if _apps > 1 then child.btn.sttxt:SetText(_apps); else child.btn.sttxt:SetText("");end
			child.btn:Show();
		else
			child.btn:Hide();
		end
	end
	local hasMainHandEnchant, mainHandBuffName, mainHandBuffRank, mainHandCharges, mainHandBuffStart, mainHandBuffDur, mainHandTex, mainHandBuffTex, mainHandSlot, hasOffHandEnchant, offHandBuffName, offHandBuffRank, offHandCharges, offHandBuffStart, offHandBuffDur, offHandTex, offHandBuffTex, offHandSlot, hasThrownEnchant, thrownBuffName, thrownBuffRank, thrownCharges, thrownBuffStart, thrownBuffDur, thrownTex, thrownBuffTex, thrownSlot;
	local tempEnchant1 = self:GetAttribute("tempEnchant1");
	local tempEnchant2 = self:GetAttribute("tempEnchant2");
	local tempEnchant3 = self:GetAttribute("tempEnchant3");
	if tempEnchant1 or tempEnchant2 or tempEnchant3 then
		hasMainHandEnchant, mainHandBuffName, mainHandBuffRank, mainHandCharges, mainHandBuffStart, mainHandBuffDur, mainHandTex, mainHandBuffTex, mainHandSlot, hasOffHandEnchant, offHandBuffName, offHandBuffRank, offHandCharges, offHandBuffStart, offHandBuffDur, offHandTex, offHandBuffTex, offHandSlot, hasThrownEnchant, thrownBuffName, thrownBuffRank, thrownCharges, thrownBuffStart, thrownBuffDur, thrownTex, thrownBuffTex, thrownSlot = RDXDAL.LoadWeaponsBuff();
	end
	if tempEnchant1 then
		if not tempEnchant1.btn then
			local btn;
			if ]] .. usebs .. [[ then
				btn = VFLUI.SkinButton:new();
				btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, true);
			elseif ]] .. usebkd .. [[ then
				btn = VFLUI.AcquireFrame("Frame");
				VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
			else
				btn = VFLUI.AcquireFrame("Frame");
			end
			btn:SetParent(tempEnchant1); btn:SetFrameLevel(tempEnchant1:GetFrameLevel());
			btn:SetAllPoints(tempEnchant1);
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. os .. [[, -]] .. os .. [[);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. os .. [[, ]] .. os .. [[);
			btn.tex:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
			btn.tex:SetDrawLayer("ARTWORK", 2);
			btn.tex:Show();
			
			btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
			btn.cd:SetAllPoints(btn.tex);
			btn.cd:Show();
			
			btn.frtxt = VFLUI.AcquireFrame("Frame");
			btn.frtxt:SetParent(btn);
			btn.frtxt:SetFrameLevel(btn:GetFrameLevel() + 2);
			btn.frtxt:SetAllPoints(btn);
			btn.frtxt:Show();
			
			btn.sttxt = VFLUI.CreateFontString(btn.frtxt);
			btn.sttxt:SetAllPoints(btn.frtxt);
			btn.sttxt:Show();
			]];
			createCode = createCode .. VFLUI.GenerateSetFontCode("btn.sttxt", desc.fontst, nil, true);
			createCode = createCode .. [[
			tempEnchant1.btn = btn;
		end
		if hasMainHandEnchant then
			tempEnchant1.btn.tex:SetTexture(mainHandTex);
			tempEnchant1.btn.cd:SetCooldown(mainHandBuffStart, mainHandBuffDur);
			if mainHandCharges > 1 then tempEnchant1.btn.sttxt:SetText(mainHandCharges); else tempEnchant1.btn.sttxt:SetText("");end
			tempEnchant1.btn:Show();
		else
			tempEnchant1.btn:Hide();
		end
	end
	local tempEnchant2 = self:GetAttribute("tempEnchant2");
	if tempEnchant2 then
		if not tempEnchant2.btn then
			local btn;
			if ]] .. usebs .. [[ then
				btn = VFLUI.SkinButton:new();
				btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, true);
			elseif ]] .. usebkd .. [[ then
				btn = VFLUI.AcquireFrame("Frame");
				VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
			else
				btn = VFLUI.AcquireFrame("Frame");
			end
			btn:SetParent(tempEnchant2); btn:SetFrameLevel(tempEnchant2:GetFrameLevel());
			btn:SetAllPoints(tempEnchant2);
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. os .. [[, -]] .. os .. [[);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. os .. [[, ]] .. os .. [[);
			btn.tex:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
			btn.tex:SetDrawLayer("ARTWORK", 2);
			btn.tex:Show();
			
			btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
			btn.cd:SetAllPoints(btn.tex);
			btn.cd:Show();
			
			btn.frtxt = VFLUI.AcquireFrame("Frame");
			btn.frtxt:SetParent(btn);
			btn.frtxt:SetFrameLevel(btn:GetFrameLevel() + 2);
			btn.frtxt:SetAllPoints(btn);
			btn.frtxt:Show();
			
			btn.sttxt = VFLUI.CreateFontString(btn.frtxt);
			btn.sttxt:SetAllPoints(btn.frtxt);
			btn.sttxt:Show();
			]];
			createCode = createCode .. VFLUI.GenerateSetFontCode("btn.sttxt", desc.fontst, nil, true);
			createCode = createCode .. [[
			tempEnchant2.btn = btn;
		end
		if hasOffHandEnchant then
			tempEnchant2.btn.tex:SetTexture(offHandTex);
			tempEnchant2.btn.cd:SetCooldown(offHandBuffStart, offHandBuffDur);
			if offHandCharges > 1 then tempEnchant2.btn.sttxt:SetText(offHandCharges); else tempEnchant2.btn.sttxt:SetText("");end
			tempEnchant2.btn:Show();
		else
			tempEnchant2.btn:Hide();
		end
	end
	local tempEnchant3 = self:GetAttribute("tempEnchant3");
	if tempEnchant3 then
		if not tempEnchant3.btn then
			local btn;
			if ]] .. usebs .. [[ then
				btn = VFLUI.SkinButton:new();
				btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, true);
			elseif ]] .. usebkd .. [[ then
				btn = VFLUI.AcquireFrame("Frame");
				VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
			else
				btn = VFLUI.AcquireFrame("Frame");
			end
			btn:SetParent(tempEnchant3); btn:SetFrameLevel(tempEnchant3:GetFrameLevel());
			btn:SetAllPoints(tempEnchant3);
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. os .. [[, -]] .. os .. [[);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. os .. [[, ]] .. os .. [[);
			btn.tex:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
			btn.tex:SetDrawLayer("ARTWORK", 2);
			btn.tex:Show();
			
			btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
			btn.cd:SetAllPoints(btn.tex);
			btn.cd:Show();
			
			btn.frtxt = VFLUI.AcquireFrame("Frame");
			btn.frtxt:SetParent(btn);
			btn.frtxt:SetFrameLevel(btn:GetFrameLevel() + 2);
			btn.frtxt:SetAllPoints(btn);
			btn.frtxt:Show();
			
			btn.sttxt = VFLUI.CreateFontString(btn.frtxt);
			btn.sttxt:SetAllPoints(btn.frtxt);
			btn.sttxt:Show();
			]];
			createCode = createCode .. VFLUI.GenerateSetFontCode("btn.sttxt", desc.fontst, nil, true);
			createCode = createCode .. [[
			tempEnchant3.btn = btn;
		end
		if hasThrownEnchant then
			tempEnchant3.btn.tex:SetTexture(thrownTex);
			tempEnchant3.btn.cd:SetCooldown(thrownBuffStart, thrownBuffDur);
			if thrownCharges > 1 then tempEnchant3.btn.sttxt:SetText(thrownCharges); else tempEnchant3.btn.sttxt:SetText("");end
			tempEnchant3.btn:Show();
		else
			tempEnchant3.btn:Hide();
		end
	end
end
headerAura:updateFunc();
frame.]] .. objname .. [[ = headerAura;
]];
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
for _,child in frame.]] .. objname .. [[:AllChildren() do
	local btn = child.btn;
	if btn then
		VFLUI.ReleaseRegion(btn.sttxt); btn.sttxt = nil;
		btn.frtxt:Destroy(); btn.frtxt = nil;
		btn.cd:Destroy(); btn.cd = nil;
		VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
		btn:Destroy(); btn = nil;
	end
end
local tempEnchant1 = frame.]] .. objname .. [[:GetAttribute("tempEnchant1");
if tempEnchant1 then
	local btn = tempEnchant1.btn;
	if btn then
		VFLUI.ReleaseRegion(btn.sttxt); btn.sttxt = nil;
		btn.frtxt:Destroy(); btn.frtxt = nil;
		btn.cd:Destroy(); btn.cd = nil;
		VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
		btn:Destroy(); btn = nil;
	end
end
local tempEnchant2 = frame.]] .. objname .. [[:GetAttribute("tempEnchant2");
if tempEnchant2 then
	local btn = tempEnchant2.btn;
	if btn then
		VFLUI.ReleaseRegion(btn.sttxt); btn.sttxt = nil;
		btn.frtxt:Destroy(); btn.frtxt = nil;
		btn.cd:Destroy(); btn.cd = nil;
		VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
		btn:Destroy(); btn = nil;
	end
end
local tempEnchant3 = frame.]] .. objname .. [[:GetAttribute("tempEnchant3");
if tempEnchant3 then
	local btn = tempEnchant3.btn;
	if btn then
		VFLUI.ReleaseRegion(btn.sttxt); btn.sttxt = nil;
		btn.frtxt:Destroy(); btn.frtxt = nil;
		btn.cd:Destroy(); btn.cd = nil;
		VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
		btn:Destroy(); btn = nil;
	end
end
frame.]] .. objname .. [[:Destroy();
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
--		local paintCode = [[

--]];
--		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		
		------------------- Cleanup
--		local cleanupCode = [[

--]];
--		state:Attach("EmitCleanup", true, function(code) code:AppendCode(cleanupCode); end);

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

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_", true);
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Template"));
		local dd_template = VFLUI.Dropdown:new(er, RDX.IconTemplatesFunc);
		dd_template:SetWidth(250); dd_template:Show();
		if desc and desc.template then 
			dd_template:SetSelection(desc.template); 
		else
			dd_template:SetSelection("RDXAB30x30Template");
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
		
		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Button Skin parameters")));
		
		local chk_bs = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use Button Skin"));
		local dd_buttonSkin = VFLUI.Dropdown:new(chk_bs, VFLUI.GetButtonSkinList);
		dd_buttonSkin:SetWidth(150); dd_buttonSkin:Show();
		dd_buttonSkin:SetSelection(desc.externalButtonSkin); 
		if desc and desc.usebs then
			chk_bs:SetChecked(true);
		else
			chk_bs:SetChecked();
		end
		chk_bs:EmbedChild(dd_buttonSkin); chk_bs:Show();
		ui:InsertFrame(chk_bs);
		
		local ed_bs = VFLUI.LabeledEdit:new(ui, 50); ed_bs:Show();
		ed_bs:SetText(VFLI.i18n("Button Skin Size Offset"));
		if desc and desc.ButtonSkinOffset then ed_bs.editBox:SetText(desc.ButtonSkinOffset); end
		ui:InsertFrame(ed_bs);
		
		local chk_bkd = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use Backdrop"));
		local dd_backdrop = VFLUI.MakeBackdropSelectButton(chk_bkd, desc.bkd);
		dd_backdrop:Show();
		if desc and desc.usebkd then
			chk_bkd:SetChecked(true);
		else
			chk_bkd:SetChecked();
		end
		chk_bkd:EmbedChild(dd_backdrop); chk_bkd:Show();
		ui:InsertFrame(chk_bkd);
		
		-------------- CooldownDisplay
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown parameters")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Font parameters")));
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font stack"));
		local fontsel2 = VFLUI.MakeFontSelectButton(er_st, desc.fontst); fontsel2:Show();
		er_st:EmbedChild(fontsel2); er_st:Show();
		ui:InsertFrame(er_st);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Smooth show hide")));
		local chk_smooth = VFLUI.Checkbox:new(ui); chk_smooth:Show();
		chk_smooth:SetText(VFLI.i18n("Use smooth on show and hide"));
		if desc and desc.smooth then chk_smooth:SetChecked(true); else chk_smooth:SetChecked(); end
		ui:InsertFrame(chk_smooth);
		
		------------ Sort
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Sort parameters")));
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Sort Method:"));
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
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Separate Own:"));
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
			if chk_bs:GetChecked() then chk_bkd:SetChecked(); end
			return { 
				feature = "sec_aura_icons"; version = 1;
				name = ed_name.editBox:GetText();
				auraType = dd_auraType:GetSelection();
				showweapons = chk_showweapons:GetChecked();
				-- layout
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				template = dd_template:GetSelection();
				point = dd_point:GetSelection();
				orientation = dd_orientation:GetSelection();
				wrapafter = VFL.clamp(ed_wrapafter.editBox:GetNumber(), 1, 40);
				maxwraps = VFL.clamp(ed_maxwraps.editBox:GetNumber(), 1, 40);
				xoffset = VFL.clamp(ed_xoffset.editBox:GetNumber(), -10, 10);
				yoffset = VFL.clamp(ed_yoffset.editBox:GetNumber(), -10, 10);
				-- display
				usebs = chk_bs:GetChecked();
				externalButtonSkin = dd_buttonSkin:GetSelection();
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				usebkd = chk_bkd:GetChecked();
				bkd = dd_backdrop:GetSelectedBackdrop();
				-- cooldown
				cd = cd:GetSelectedCooldown();
				fontst = fontsel2:GetSelectedFont();
				smooth = chk_smooth:GetChecked();
				-- sort
				sortmethod = dd_sortMethod:GetSelection();
				sortdir = chk_sortDir:GetChecked();
				separateown = dd_separateOwn:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		local font = VFL.copy(Fonts.Default); font.size = 8; font.justifyV = "CENTER"; font.justifyH = "CENTER";
		return { 
			feature = "sec_aura_icons";
			version = 1;
			name = "sai1";
			auraType = "BUFFS";
			owner = "Base";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			template = "RDXAB30x30Template"; orientation = "LEFT"; wrapafter = 10; maxwraps = 2; xoffset = 0; yoffset = 0; point = "TOPLEFT";
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			cd = VFL.copy(VFLUI.defaultCooldown);
			fontst = font;
			sortmethod = "INDEX";
			separateown = "NONE";
		};
	end;
});


