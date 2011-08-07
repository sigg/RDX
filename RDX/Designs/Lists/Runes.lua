-- Runes.lua
-- OpenRDX


function __SetRunes(btn, dur, tl, hide)
	if hide then
		btn:Hide();
	else
		btn:Show();
	end
	if tl and tl > 0 then
		btn.cd:SetCooldown(GetTime() + tl - dur , dur);
	else
		btn.cd:SetCooldown(0, 0);
	end

	return true;
end

function __RuneOnEnter(self)
	if self.tooltipText then 
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(self.tooltipText);
		GameTooltip:Show(); 
	end
end
function __RuneOnLeave()
	GameTooltip:Hide();
end

--------------- Code emitter helpers
local function _EmitCreateCode(objname, desc)
	if not desc.nIcons then desc.nIcons = 6; end
	if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
	local createCode = [[
frame.]] .. objname .. [[ = {};
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
for i=1,6 do
	btn = VFLUI.AcquireFrame("Button");
	btn:SetParent(btnOwner);
	btn:SetFrameLevel(btnOwner:GetFrameLevel());
	btn:SetWidth(]] .. desc.size .. [[); btn:SetHeight(]] .. desc.size .. [[);
	btn:SetID(i);
	btn:SetScript("OnEnter", __RuneOnEnter);
	btn:SetScript("OnLeave", __RuneOnLeave);
	
	btn.texrune = VFLUI.CreateTexture(btn);
	btn.texrune:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "2") .. [[);
	btn.texrune:SetPoint("TOPLEFT", btn, "TOPLEFT");
	btn.texrune:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT");
	btn.texrune:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	btn.texrune:SetTexture("Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood");
	local runeType = GetRuneType(i);
	if (runeType) then
		btn.texrune:SetTexture(RDXMD.GetRuneIconTexturesNormal(runeType));
		btn.texrune:Show();
		btn.tooltipText = _G["COMBAT_TEXT_RUNE_"..RDXMD.GetRuneMapping(runeType)];
	else
		btn.texrune:Hide();
		btn.tooltipText = nil;
	end
	
	btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
	btn.cd:SetPoint("TOPLEFT", btn.texrune, "TOPLEFT", 2, -2);
	btn.cd:SetPoint("BOTTOMRIGHT", btn.texrune, "BOTTOMRIGHT", -2, 2);
	btn.cd:Show();
]];
	createCode = createCode .. VFLUI.GenerateSetFontCode("btn.cd.fs", desc.font, nil, true);
	createCode = createCode .. [[
	btn.fraborder = VFLUI.AcquireFrame("Frame");
	btn.fraborder:SetParent(btn);
	btn.fraborder:SetFrameLevel(btn:GetFrameLevel() + 2);
	btn.fraborder:Show();
	btn.texborder = VFLUI.CreateTexture(btn.fraborder);
	btn.texborder:SetPoint("TOPLEFT", btn, "TOPLEFT");
	btn.texborder:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT");
	btn.texborder:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	btn.texborder:SetTexture("Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Ring");
	btn.texborder:Show();

	frame.]] .. objname .. [[[i] = btn;
end
]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	return createCode;
end

-----------------------------
-- RUNES
-----------------------------
RDX.RegisterFeature({
	name = "runes_bar";
	version = 1;
	title = VFLI.i18n("Bars Rune");
	category = VFLI.i18n("Lists");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		
		-- Event hinting.
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local smask = mux:GetPaintMask("RUNE_POWER_UPDATE");
		local umask = mux:GetPaintMask("RUNE_TYPE_UPDATE");
		
		------------ Closure
		local closureCode = [[
local mddata_]] .. objname .. [[ = RDXDB.GetObjectInstance(]] .. Serialize(desc.externalButtonSkin) .. [[);
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		----------------- Creation
		local createCode = _EmitCreateCode(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
local btn = nil;
for i=1,6 do
	btn = frame.]] .. objname .. [[[i]
	VFLUI.ReleaseRegion(btn.texrune); btn.texrune = nil;
	btn.cd:Destroy(); btn.cd = nil;
	VFLUI.ReleaseRegion(btn.texborder); btn.texborder = nil;
	btn.fraborder:Destroy(); btn.fraborder = nil;
	btn.tooltipText = nil;
	btn:Destroy();
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		local paintCode = [[
local hide = nil;
local classMnemonic = unit:GetClassMnemonic();
if ( classMnemonic ~= "DEATHKNIGHT" ) then
	hide = true;
end
local _runes = frame.]] .. objname .. [[;
local start, duration, runeReady, timeleft, runeType;

for i=1,6 do
	start, duration, runeReady = GetRuneCooldown(i);
	timeleft = duration - (GetTime() - start);
	runeType = GetRuneType(i);
	if (runeType) then
		_runes[i].texrune:SetTexture(RDXMD.GetRuneIconTexturesNormal(runeType));
		_runes[i].tooltipText = _G["COMBAT_TEXT_RUNE_"..RDXMD.GetRuneMapping(runeType)];
	end
	__SetRunes(_runes[i], duration, timeleft, hide);
end
]];
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		------------------- Cleanup
		local cleanupCode = [[
local btn = nil;
for i=1,6 do
	btn = frame.]] .. objname .. [[[i];
	btn:Hide(); btn.meta = nil;
end
]];
		--state:Attach("EmitCleanup", true, function(code) code:AppendCode(cleanupCode); end);
		
		mux:Event_UnitMask("UNIT_RUNE_POWER_UPDATE", smask);
		mux:Event_UnitMask("UNIT_RUNE_TYPE_UPDATE", umask);
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

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

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
		
		local ed_size = VFLUI.LabeledEdit:new(ui, 50); ed_size:Show();
		ed_size:SetText(VFLI.i18n("Icon Size"));
		if desc and desc.size then ed_size.editBox:SetText(desc.size); end
		ui:InsertFrame(ed_size);
		
		function ui:GetDescriptor()
			return { 
				feature = "runes_bar"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				rows = VFL.clamp(ed_rows.editBox:GetNumber(), 1, 5);
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), 0, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), 0, 200);
				size = VFL.clamp(ed_size.editBox:GetNumber(), 1, 50);
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		local font = VFL.copy(Fonts.Default); font.size = 8; font.justifyV = "CENTER"; font.justifyH = "CENTER";
		return { 
			feature = "runes_bar"; 
			version = 1;
			name = "rune_bar";
			owner = "decor";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			size = 20; rows = 1; orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			font = font;
			cd = VFL.copy(VFLUI.defaultCooldown);
		};
	end;
});

-------------------------------------
-- Runes Bar Skin
-- 
-- UnitFrameFeature to create custom Deathknight RuneElements
-- Cripsii Kirin Tor EU
-------------------------------------

--------------- Code emitter helpers
local function _EmitCreateCode2(objname, desc)
	if not desc.nIcons then desc.nIcons = 6; end
	
	local ebsflag, ebs, ebsos = "false", "bs_default", 0;
	if desc.externalButtonSkin then
		ebsflag = "true";
		ebs = desc.externalButtonSkin;
		if desc.ButtonSkinOffset then ebsos = desc.ButtonSkinOffset; end
	else
		if not desc.bkd then desc.bkd = {}; end
		if desc.bkd.edgeSize then ebsos = desc.bkd.edgeSize/3; end
	end
	
	if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
	
	local createCode = [[
	frame.]] .. objname .. [[ = {};
	local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
	for i=1,6 do
		if ]] .. ebsflag .. [[ then 
			btn = VFLUI.SkinButton:new();
			btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, true);
		else
			btn = VFLUI.AcquireFrame("Frame");
		end
		btn:SetParent(btnOwner);
		btn:SetFrameLevel(btnOwner:GetFrameLevel());
		btn:SetWidth(]] .. desc.sizew .. [[); btn:SetHeight(]] .. desc.sizeh .. [[);
		
		btn:SetScript("OnEnter", __RuneOnEnter);
		btn:SetScript("OnLeave", __RuneOnLeave);

		btn.tex = VFLUI.CreateTexture(btn);
		btn.tex:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "2") .. [[);
		btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. ebsos .. [[, -]] .. ebsos .. [[);
		btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. ebsos .. [[, ]] .. ebsos .. [[);
		btn.tex:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
		btn.tex:SetTexture("Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood");
		local runeType = GetRuneType(i);
		if runeType then
			]];
			if desc.customtexture then
				createCode = createCode .. VFLUI.GenerateSetTextureCode("btn.tex", desc.runetexture);
				createCode = createCode .. [[
				btn.tex:SetVertexColor(VFL.explodeRGBA(runecolo_cl[runeType]));
				]];
			else
				createCode = createCode .. [[
				btn.tex:SetTexture(RDXMD.GetRuneIconTexturesOn(runeType));]]; 
			end
			
			createCode = createCode ..[[   
			btn.tex:Show();
			btn.tooltipText = _G["COMBAT_TEXT_RUNE_"..RDXMD.GetRuneMapping(runeType)];
		end
		
		btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
		btn.cd:SetAllPoints(btn.tex);
		btn.cd:Show();
		
		]];
		createCode = createCode .. VFLUI.GenerateSetFontCode("btn.cd.fs", desc.cdFont, nil, true);
		
		createCode = createCode .. [[
		frame.]] .. objname .. [[[i] = btn;
	end
]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	return createCode;
end

RDX.RegisterFeature({
	name = "runes_bar_vars";
	title = VFLI.i18n("Icons Rune");
	version = 1;
	multiple = false;
	category = VFLI.i18n("Lists");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if not desc.externalButtonSkin then VFL.AddError(errs, VFLI.i18n("Select button skin")); flg = nil; end
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		-- Event hinting.
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("RUNE_POWER_UPDATE");
		local mask = mux:GetPaintMask("RUNE_TYPE_UPDATE");
		
		------------ Closure
		local closureCode = [[
local runecolo_cl = {};
runecolo_cl[1] = ]] .. Serialize(desc.bloodColor) .. [[;
runecolo_cl[2] = ]] .. Serialize(desc.unholyColor) .. [[;
runecolo_cl[3] = ]] .. Serialize(desc.frostColor) .. [[;
runecolo_cl[4] = ]] .. Serialize(desc.deathColor) .. [[;
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);
		
		----------------- Creation
		local createCode = _EmitCreateCode2(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);
	
		------------------- Destruction
      		local destroyCode = [[
local btn = nil;
for i=1,6 do
	btn = frame.]] .. objname .. [[[i]
	VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
	btn.cd:Destroy(); btn.cd = nil;
	btn.tooltipText = nil;
	btn:Destroy(); btn = nil;
end
frame.]] .. objname .. [[ = nil;
		]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		
		local paintCode = [[
local hide = false;
local classMnemonic = unit:GetClassMnemonic();
if ( classMnemonic ~= "DEATHKNIGHT" ) then
	hide = true;
end
local _runes = frame.]] .. objname .. [[;
local start, duration, timeleft, runeType;
for i=1,6 do
	start, duration = GetRuneCooldown(i);
	timeleft = duration - (GetTime() - start);
	runeType = GetRuneType(i);
	if (runeType) then 
	]];
		if desc.customtexture then
			paintCode = paintCode .. VFLUI.GenerateSetTextureCode("_runes[i].tex", desc.runetexture);
			paintCode = paintCode .. [[
			_runes[i].tex:SetVertexColor(VFL.explodeRGBA(runecolo_cl[runeType]));
			]];
		else
			paintCode = paintCode .. [[
			_runes[i].tex:SetTexture(RDXMD.GetRuneIconTexturesOn(runeType));
			]];
		end
	
		paintCode = paintCode .. [[
		_runes[i].tooltipText = _G["COMBAT_TEXT_RUNE_"..RDXMD.GetRuneMapping(runeType)];
	end
	__SetRunes(_runes[i], duration, timeleft, hide);
end
]];
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		
		mux:Event_UnitMask("UNIT_RUNE_POWER_UPDATE", mask);
		mux:Event_UnitMask("UNIT_RUNE_TYPE_UPDATE", mask);
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
		
		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
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
		
		local ed_sizew = VFLUI.LabeledEdit:new(ui, 50); ed_sizew:Show();
		ed_sizew:SetText(VFLI.i18n("Icon width"));
		if desc and desc.sizew then ed_sizew.editBox:SetText(desc.sizew); end
		ui:InsertFrame(ed_sizew);
		
		local ed_sizeh = VFLUI.LabeledEdit:new(ui, 50); ed_sizeh:Show();
		ed_sizeh:SetText(VFLI.i18n("Icon height"));
		if desc and desc.sizeh then ed_sizeh.editBox:SetText(desc.sizeh); end
		ui:InsertFrame(ed_sizeh);
	
		-------------- ButtonSkin or Frame
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Button Skin parameters")));
		
		local chk_bs = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use Button Skin"));
		local dd_buttonSkin = VFLUI.Dropdown:new(chk_bs, VFLUI.GetButtonSkinList);
		dd_buttonSkin:SetWidth(150); dd_buttonSkin:Show();
		if desc and desc.externalButtonSkin then
			chk_bs:SetChecked(true);
			dd_buttonSkin:SetSelection(desc.externalButtonSkin); 
		else
			chk_bs:SetChecked();
			dd_buttonSkin:SetSelection("bs_default");
		end
		chk_bs:EmbedChild(dd_buttonSkin); chk_bs:Show();
		ui:InsertFrame(chk_bs);
	
		local ed_bs = VFLUI.LabeledEdit:new(ui, 50); ed_bs:Show();
		ed_bs:SetText(VFLI.i18n("Button Skin Size Offset"));
		if desc and desc.ButtonSkinOffset then ed_bs.editBox:SetText(desc.ButtonSkinOffset); end
		ui:InsertFrame(ed_bs);
		
		local chk_texture = VFLUI.Checkbox:new(ui); chk_texture:Show();
		chk_texture:SetText(VFLI.i18n("Use Custom Texture"));
		if desc and desc.customtexture then chk_texture:SetChecked(true); else chk_texture:SetChecked(); end
		ui:InsertFrame(chk_texture);
	
		local er_btx = VFLUI.EmbedRight(ui, VFLI.i18n("Rune Texture"));
		local runetexsel = VFLUI.MakeTextureSelectButton(er_btx, desc.runetexture); runetexsel:Show();
		er_btx:EmbedChild(runetexsel); er_btx:Show();
		ui:InsertFrame(er_btx);
		
		local sw_blood = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Blood rune color"));
		if desc and desc.bloodColor then sw_blood:SetColor(VFL.explodeRGBA(desc.bloodColor)); end
		local sw_unholy = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Unholy rune color"));
		if desc and desc.unholyColor then sw_unholy:SetColor(VFL.explodeRGBA(desc.unholyColor)); end
		local sw_frost = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Frost rune color"));
		if desc and desc.frostColor then sw_frost:SetColor(VFL.explodeRGBA(desc.frostColor)); end
		local sw_death = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Death rune color"));
		if desc and desc.deathColor then sw_death:SetColor(VFL.explodeRGBA(desc.deathColor)); end
		
		-------------- Cooldown Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown parameters")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);
		
		function ui:GetDescriptor()
			local ebs = nil;
			if chk_bs:GetChecked() then ebs = dd_buttonSkin:GetSelection(); end
			return {
				feature = "runes_bar_vars"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				rows = VFL.clamp(ed_rows.editBox:GetNumber(), 1, 5);
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), 0, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), 0, 200);
				sizew = VFL.clamp(ed_sizew.editBox:GetNumber(), 1, 50);
				sizeh = VFL.clamp(ed_sizeh.editBox:GetNumber(), 1, 50);
				
				customtexture = chk_texture:GetChecked();
				runetexture = runetexsel:GetSelectedTexture();
				externalButtonSkin = ebs;
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				bloodColor = sw_blood:GetColor();
				unholyColor = sw_unholy:GetColor();
				frostColor = sw_frost:GetColor();
				deathColor = sw_death:GetColor();
				
				cd = cd:GetSelectedCooldown();
				cdTimerType = nil;
				cdGfxReverse = nil;
				cdHideTxt = nil;
				cdFont = nil;
				cdTxtType = nil;
				cdoffx = nil;
				cdoffy = nil;
			};
		end
		return ui;
	end;
	CreateDescriptor = function()
		local font = VFL.copy(Fonts.Default); font.size = 8; font.justifyV = "CENTER"; font.justifyH = "CENTER";
		return {
			feature = "runes_bar_vars"; 
			version = 1;
			name = "rune_bar_skin";
			owner = "decor";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			sizew = 20; sizeh = 20; rows = 1; orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			cd = VFL.copy(VFLUI.defaultCooldown);
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			bloodColor =  {r=1,g=0,b=0.2,a=1};
			unholyColor = {r=0,g=1,b=0,a=1};
			frostColor =  {r=0,g=0.6,b=1,a=1};
			deathColor =  {r=0.6,g=0.3,b=0.6,a=1};
		};
	end;
});
