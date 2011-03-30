-- HeaderAuraIconList.lua
-- OpenRDX - Sigg - Rashgarroth FR
--

RDX.RegisterFeature({
	name = "sec_aura_bars";
	version = 1;
	title = VFLI.i18n("Secure Aura Bars");
	category = VFLI.i18n("Lists");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Bars_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Bars_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Bars_" .. desc.name;
		local showweapons = "false";
		if desc.showweapons then showweapons = "true"; end
		local sortdir = "+";
		if desc.sortdir then sortdir = "-"; end
		local separateown = "0";
		if desc.separateown == "BEFORE" then sortdir = "1"; end
		if desc.separateown == "AFTER" then sortdir = "-1"; end
		
		local _, _, dx, dy = string.find(desc.template, "^RDXAB(.*)x(.*)Template$");
		local borientation, isize, barx, bary;
		if desc.showtex then
			borientation, isize, barx, bary = "HORIZONTAL", dy, dx - dy, dy;
			if dy > dx then borientation = "VERTICAL"; isize = dx; barx = dx; bary = dy - dx; end
		else
			borientation, isize, barx, bary = "HORIZONTAL", dy, dx, dy;
			if dy > dx then borientation = "VERTICAL"; isize = dx; barx = dx; bary = dy; end
		end
		
		-- Event hinting.
		local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		local filter;
		if desc.auraType == "DEBUFFS" then
			mask = mux:GetPaintMask("DEBUFFS");
			mux:Event_UnitMask("DELAYED_UNIT_DEBUFF_*", mask);
			filter = "HARMFUL";
		else
			mask = mux:GetPaintMask("BUFFS");
			mux:Event_UnitMask("DELAYED_UNIT_BUFF_*", mask);
			filter = "HELPFUL";
		end
		local smask = mux:GetPaintMask("UNIT_BUFFWEAPON");
		mux:Event_UnitMask("UNIT_BUFFWEAPON_UPDATE", smask);
		
		mask = bit.bor(mask, 1);
		
		------------ Closure
		local closureCode = [[
local ftc_]] .. objname .. [[ = FreeTimer.CreateFreeTimerClass(true,true, nil, VFLUI.GetTextTimerTypesString("MinSec"), false, false, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide, FreeTimer.SB_Hide, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide);
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
frame.]] .. objname .. [[ = headerAura;
]];
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
for _,frame in frame.]] .. objname .. [[:ActiveChildren() do
	local btn = frame.btn;
	VFLUI.ReleaseRegion(btn.icon); btn.icon = nil;
	VFLUI.ReleaseRegion(btn.icontxt); btn.icontxt = nil;
	btn.sb:Destroy(); btn.sb = nil;
	VFLUI.ReleaseRegion(btn.sbtxt); btn.sbtxt = nil;
	VFLUI.ReleaseRegion(btn.sbtimetxt); btn.sbtimetxt = nil;
	btn.ftc:Destroy(); btn.ftc = nil;
	btn:Destroy(); btn = nil;
end
frame.]] .. objname .. [[:Destroy();
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		local paintCode = [[
for _,frame in frame.]] .. objname .. [[:ActiveChildren() do
	if not frame.btn then
		local btn = VFLUI.AcquireFrame("Frame");
		btn:SetParent(frame); btn:SetFrameLevel(frame:GetFrameLevel());
		btn:SetAllPoints(frame);
		VFLUI.SetBackdrop(btn, ]] .. Serialize(desc.bkd) .. [[);
		btn.icon = VFLUI.CreateTexture(btn);
		btn.icon:SetWidth(]] .. isize .. [[); btn.icon:SetHeight(]] .. isize .. [[);
		btn.icon:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
		btn.sb = VFLUI.StatusBarTexture:new(btn, nil, nil, "ARTWORK", 1);
		btn.sb:SetOrientation("]] .. borientation .. [[");
		btn.sb:SetWidth(]] .. barx .. [[); btn.sb:SetHeight(]] .. bary .. [[);
		btn.sb:Show();
]];
		paintCode = paintCode .. VFLUI.GenerateSetTextureCode("btn.sb", desc.sbtexture);
		paintCode = paintCode .. [[
		btn.icontxt = VFLUI.CreateFontString(btn);
		btn.icontxt:SetAllPoints(btn.icon); 
		btn.icontxt:Show();
]];
		paintCode = paintCode .. VFLUI.GenerateSetFontCode("btn.icontxt", desc.iconfont, nil, true);
		paintCode = paintCode .. [[
		btn.sbtxt = VFLUI.CreateFontString(btn);
		btn.sbtxt:SetAllPoints(btn.sb);
		btn.sbtxt:Show();
]];
		paintCode = paintCode .. VFLUI.GenerateSetFontCode("btn.sbtxt", desc.sbfont, nil, true);
		paintCode = paintCode .. [[
		btn.sbtimetxt = VFLUI.CreateFontString(btn);
		btn.sbtimetxt:SetAllPoints(btn.sb);
		btn.sbtimetxt:Show();
]];
		paintCode = paintCode .. VFLUI.GenerateSetFontCode("btn.sbtimetxt", desc.sbtimerfont, nil, true);
		paintCode = paintCode .. [[
		btn.ftc = ftc_]] .. objname .. [[(frame, btn.sb, btn.sbtimetxt);
]];
		if desc.showtex then
			if borientation == "HORIZONTAL" then
				paintCode = paintCode .. [[ 
					btn.icon:SetPoint("TOPLEFT", btn, "TOPLEFT");
					btn.sb:SetPoint("TOPLEFT", btn.icon, "TOPLEFT");
]];
			else
				paintCode = paintCode .. [[ 
					btn.icon:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT");
					btn.sb:SetPoint("BOTTOMLEFT", btn.icon, "BOTTOMLEFT");
]];			
			end
		else
			if borientation == "HORIZONTAL" then
				paintCode = paintCode .. [[ 
					btn.icon:SetPoint("TOPLEFT", btn, "TOPLEFT");
					btn.sb:SetPoint("TOPLEFT", btn, "TOPLEFT");
]];
			else
				paintCode = paintCode .. [[ 
					btn.icon:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT");
					btn.sb:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT");
]];			
			end
		end
		paintCode = paintCode .. [[
		frame.btn = btn;
	end
	_bn, _, _tex, _apps, _dispelt, _dur, _et = UnitAura(uid,frame:GetID());
	if _bn then
		frame.btn.icon:SetTexture(_tex);
		if _apps > 1 then frame.btn.icontxt:SetText(_apps); else frame.btn.icontxt:SetText("");end
		frame.btn.sb:SetColorTable(DebuffTypeColor[_dispelt]);
		frame.btn.sbtxt:SetText(_bn);
		frame.btn.ftc:SetFormula("]] .. desc.countTypeFlag .. [[");
		frame.btn.ftc:SetTimer(_et - _dur , _dur);
		frame.btn:Show();
	else
		frame.btn:Hide();
	end
end
]];
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		
		------------------- Cleanup
		local cleanupCode = [[

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

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Aura Type:"));
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
		chk_showweapons:SetText(VFLI.i18n("Show Weapons"));
		if desc and desc.showweapons then chk_showweapons:SetChecked(true); else chk_showweapons:SetChecked(); end
		ui:InsertFrame(chk_showweapons);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout")));

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, "Owner", state, "Subframe_", true);
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Template:"));
		local dd_template = VFLUI.Dropdown:new(er, RDX.BarTemplatesFunc);
		dd_template:SetWidth(250); dd_template:Show();
		if desc and desc.template then 
			dd_template:SetSelection(desc.template); 
		else
			dd_template:SetSelection("RDXAB30x90Template");
		end
		er:EmbedChild(dd_template); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Point:"));
		local dd_point = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
		dd_point:SetWidth(150); dd_point:Show();
		if desc and desc.point then 
			dd_point:SetSelection(desc.point); 
		else
			dd_point:SetSelection("TOPLEFT");
		end
		er:EmbedChild(dd_point); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation:"));
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
		ed_xoffset:SetText(VFLI.i18n("X offset"));
		if desc and desc.xoffset then ed_xoffset.editBox:SetText(desc.xoffset); else ed_xoffset.editBox:SetText("0"); end
		ui:InsertFrame(ed_xoffset);
		
		local ed_yoffset = VFLUI.LabeledEdit:new(ui, 50); ed_yoffset:Show();
		ed_yoffset:SetText(VFLI.i18n("Y offset"));
		if desc and desc.yoffset then ed_yoffset.editBox:SetText(desc.xoffset); else ed_yoffset.editBox:SetText("0"); end
		ui:InsertFrame(ed_yoffset);
		
		-------------- display
		
		local er_bkd = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop style"));
		local bkd = VFLUI.MakeBackdropSelectButton(er_bkd, desc.bkd); bkd:Show();
		er_bkd:EmbedChild(bkd); er_bkd:Show();
		ui:InsertFrame(er_bkd);
		
		local chk_showtex = VFLUI.Checkbox:new(ui); chk_showtex:Show();
		chk_showtex:SetText(VFLI.i18n("Show icon texture"));
		if desc and desc.showtex then chk_showtex:SetChecked(true); else chk_showtex:SetChecked(); end
		ui:InsertFrame(chk_showtex);
		
		--local er_ip = VFLUI.EmbedRight(ui, VFLI.i18n("Icon Position"));
		--local dd_ip = VFLUI.Dropdown:new(er_ip, RDXUI.OrientationDropdownFunction);
		--dd_ip:SetWidth(100); dd_ip:Show();
		--if desc and desc.iconposition then 
		--	dd_ip:SetSelection(desc.iconposition); 
		--else
		--	dd_ip:SetSelection("LEFT");
		--end
		--er_ip:EmbedChild(dd_ip); er_ip:Show();
		--ui:InsertFrame(er_ip);
		
		local er_if = VFLUI.EmbedRight(ui, VFLI.i18n("Icon Font Stack"));
		local iconfontsel = VFLUI.MakeFontSelectButton(er_if, desc.iconfont); iconfontsel:Show();
		er_if:EmbedChild(iconfontsel); er_if:Show();
		ui:InsertFrame(er_if);
		
		local er_btx = VFLUI.EmbedRight(ui, VFLI.i18n("Bar Texture"));
		local sbtexsel = VFLUI.MakeTextureSelectButton(er_btx, desc.sbtexture); sbtexsel:Show();
		er_btx:EmbedChild(sbtexsel); er_btx:Show();
		ui:InsertFrame(er_btx);
		
		local er_bf = VFLUI.EmbedRight(ui, VFLI.i18n("Bar Font Aura name"));
		local barfontsel = VFLUI.MakeFontSelectButton(er_bf, desc.sbfont); barfontsel:Show();
		er_bf:EmbedChild(barfontsel); er_bf:Show();
		ui:InsertFrame(er_bf);
		
		local ed_trunc = VFLUI.LabeledEdit:new(ui, 50); ed_trunc:Show();
		ed_trunc:SetText(VFLI.i18n("Max aura length (blank = no truncation)"));
		if desc and desc.trunc then ed_trunc.editBox:SetText(desc.trunc); end
		ui:InsertFrame(ed_trunc);
		
		local chk_abr = VFLUI.Checkbox:new(ui); chk_abr:Show();
		chk_abr:SetText(VFLI.i18n("Use abbreviating"));
		if desc and desc.abr then chk_abr:SetChecked(true); else chk_abr:SetChecked(); end
		ui:InsertFrame(chk_abr);
		
		local er_tf = VFLUI.EmbedRight(ui, VFLI.i18n("Bar Font Aura Timer"));
		local timerfontsel = VFLUI.MakeFontSelectButton(er_tf, desc.sbtimerfont); timerfontsel:Show();
		er_tf:EmbedChild(timerfontsel); er_tf:Show();
		ui:InsertFrame(er_tf);
		
		--local chk_bc = VFLUI.Checkbox:new(ui); chk_bc:Show();
		--chk_bc:SetText(VFLI.i18n("Use Bar color debuff"));
		--if desc and desc.sbcolor then chk_bc:SetChecked(true); else chk_bc:SetChecked(); end
		--ui:InsertFrame(chk_bc);
		
		local countTypeFlag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Count type (true CountUP, false CountDOWN)"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.countTypeFlag then countTypeFlag:SetSelection(desc.countTypeFlag); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Smooth show hide")));
		local chk_smooth = VFLUI.Checkbox:new(ui); chk_smooth:Show();
		chk_smooth:SetText(VFLI.i18n("Use smooth on show and hide"));
		if desc and desc.smooth then chk_smooth:SetChecked(true); else chk_smooth:SetChecked(); end
		ui:InsertFrame(chk_smooth);
		
		------------ Sort
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Sort")));
		
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
			return { 
				feature = "sec_aura_bars"; version = 1;
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
				bkd = bkd:GetSelectedBackdrop();
				showtex = chk_showtex:GetChecked();
				--iconposition = dd_ip:GetSelection();
				iconfont = iconfontsel:GetSelectedFont();
				sbtexture = sbtexsel:GetSelectedTexture();
				sbfont = barfontsel:GetSelectedFont();
				trunc = VFL.clamp(ed_trunc.editBox:GetNumber(), 1, 50);
				abr = chk_abr:GetChecked();
				sbtimerfont = timerfontsel:GetSelectedFont();
				--sbcolor = chk_bc:GetChecked();
				countTypeFlag = countTypeFlag:GetSelection();
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
			feature = "sec_aura_bars";
			version = 1;
			name = "sab1";
			auraType = "BUFFS";
			owner = "Base";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			template = "RDXAB30x30Template"; orientation = "LEFT"; wrapafter = 10; maxwraps = 2; xoffset = 0; yoffset = 0;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			--iconposition = "LEFT";
			iconfont = VFL.copy(Fonts.Default);
			sbtexture = { blendMode = "BLEND"; path = "Interface\\TargetingFrame\\UI-StatusBar"; };
			sbfont = VFL.copy(Fonts.Default);
			sbtimerfont = sbtfont;
			countTypeFlag = "true";
			sortmethod = "INDEX";
			separateown = "NONE";
		};
	end;
});


