-- TextStatus.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Unit frame features that add text to various places on the unit frame.

-- Set the colors of status text appropriately.
function RDX.SetStatusText(txt, val, color, fadeColor, text)
	if fadeColor then
		tempcolor:blend(fadeColor, color, val);
		txt:SetTextColor(tempcolor.r, tempcolor.g, tempcolor.b);
	else
		txt:SetTextColor(color.r, color.g, color.b);
	end
end

----------------- Status text types and code
local statusText = {};
local statusIndex = {};
function RDX.RegisterStatusTextType(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if statusText[tbl.name] then RDX.printW("Attempt to register duplicate Status Text Type " .. tbl.name); return; end
	statusText[tbl.name] = tbl;
	table.insert(statusIndex, {value = tbl.name, text = tbl.title});
end

local function hpPrereq(desc, state, errs)
	return true; -- Fractional health no longer required.
end
local function hpHint(desc, state)
	local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
	local mask = mux:GetPaintMask("HEALTH");
	mux:Event_UnitMask("UNIT_HEALTH", mask);
end
local function mpPrereq(desc, state, errs)
	return true;
end
local function mpHint(desc, state)
	local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
	local mask = mux:GetPaintMask("POWER");
	mux:Event_UnitMask("UNIT_POWER", mask);
end

RDX.RegisterStatusTextType({
	name = "fdld";
	title = VFLI.i18n("Feigned/Dead/LD");
	OnExpose = VFL.Noop;
	OnApply = hpHint;
	GeneratePaintCode = function(objname) return [[
if unit:IsFeigned() then
	]] .. objname .. [[:SetText(VFLI.i18n("Feign"));
elseif unit:IsDead() then
	]] .. objname .. [[:SetText(VFLI.i18n("|cFFFF0000Dead|r"));
elseif not unit:IsOnline() then
	]] .. objname .. [[:SetText(VFLI.i18n("|cFF777777LD|r"));
else
	]] .. objname .. [[:SetText("");
end
]]; end;
	GeneratePaintCodeTest = function(objname) return [[
]] .. objname .. [[:SetText(VFLI.i18n("|cFFFF0000Dead|r"));
]]; end;
});

RDX.RegisterStatusTextType({
	name = "fdld2";
	title = VFLI.i18n("Feigned/Dead");
	OnExpose = VFL.Noop;
	OnApply = hpHint;
	GeneratePaintCode = function(objname) return [[
if unit:IsFeigned() then
	]] .. objname .. [[:SetText(VFLI.i18n("Feign"));
elseif unit:IsDead() then
	]] .. objname .. [[:SetText(VFLI.i18n("|cFFFF0000Dead|r"));
else
	]] .. objname .. [[:SetText("");
end
]]; end;
	GeneratePaintCodeTest = function(objname) return [[
]] .. objname .. [[:SetText(VFLI.i18n("|cFFFF0000Dead|r"));
]]; end;
});

RDX.RegisterStatusTextType({
	name = "gn";
	title = VFLI.i18n("Group Number");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
	]] .. objname .. [[:SetFormattedText("%d",  unit:GetGroup());
]]; end;
});

RDX.RegisterStatusTextType({
	name = "gn2";
	title = VFLI.i18n("Group");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	if UnitInRaid(uid) then
		RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
		]] .. objname .. [[:SetFormattedText("G:%d",  unit:GetGroup());
	end
]]; end;
	GeneratePaintCodeTest = function(objname) return [[
RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
]] .. objname .. [[:SetFormattedText("G:%d",  1);
]]; end;
});

RDX.RegisterStatusTextType({
	name = "class";
	title = VFLI.i18n("Class");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	text = "";
	if UnitIsPlayer(uid) then
		text = unit:GetClass() or "";
	else
		if UnitCreatureType(uid) == "Beast" and UnitCreatureFamily(uid) then
			text = UnitCreatureFamily(uid);
		else
			text = UnitCreatureType(uid) or "";
		end
	end
	RDX.SetStatusText(]] .. objname .. [[, 1, unit:GetClassColor(), nil);
	]] .. objname .. [[:SetText(text);
]]; end;
});

RDX.RegisterStatusTextType({
	name = "class4";
	title = VFLI.i18n("Class 4");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	text = "";
	if UnitIsPlayer(uid) then
		text = unit:GetClass() or "";
	else
		if UnitCreatureType(uid) == "Beast" and UnitCreatureFamily(uid) then
			text = UnitCreatureFamily(uid);
		else
			text = UnitCreatureType(uid) or "";
		end
	end
	if string.len(text) > 4 then text = string.sub(text,1,4); end
	RDX.SetStatusText(]] .. objname .. [[, 1, unit:GetClassColor(), nil);
	]] .. objname .. [[:SetText(text);
]]; end;
});

RDX.RegisterStatusTextType({
	name = "race";
	title = VFLI.i18n("Race");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	text = "";
	if UnitIsPlayer(uid) then
		text = (UnitRace(uid) or "");
	else
		if UnitCreatureType(uid) == "Beast" and UnitCreatureFamily(uid) then
			text = UnitCreatureFamily(uid);
		else
			text = UnitCreatureType(uid) or "";
		end
	end
	RDX.SetStatusText(]] .. objname .. [[, 1, unit:GetClassColor(), nil);
	]] .. objname .. [[:SetText(text);
]]; end;
});

RDX.RegisterStatusTextType({
	name = "guild";
	title = VFLI.i18n("Guild");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	local guild, pguild;
	text = "";
	textcolor = _grey;
	if UnitIsPlayer(uid) then
		guild = GetGuildInfo(uid);
		if guild then
			text = guild;
			pguild = GetGuildInfo("player")
			if guild == pguild then
				if string.len(text) > 22 then text = string.sub(text,1,22); end
				textcolor = _green;
			else
				if string.len(text) > 22 then text = string.sub(text,1,22); end
				textcolor = _red;
			end
		end
	end
	RDX.SetStatusText(]] .. objname .. [[, 1, textcolor, nil);
	]] .. objname .. [[:SetText(text);
]]; end;
});

RDX.RegisterStatusTextType({
	name = "mobtype";
	title = VFLI.i18n("Mob type");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	local classification = UnitClassification(uid);
	text = "";
	textcolor = _grey;
	if (classification ~= "normal") then
		if (classification == "worldboss") then
			text = "Boss";
			textcolor = _white;
		elseif (classification == "rareelite") then
			text = "Rare Elite";
			textcolor = _yellow;
		elseif (classification == "elite") then
			text = "Elite Mob";
			textcolor = _yellow;
		elseif (classification == "rare") then
			text = "Rare Mob";
			textcolor = _grey;
		end
	end
	RDX.SetStatusText(]] .. objname .. [[, 1, textcolor, nil);
	]] .. objname .. [[:SetText(text);
]]; end;
	GeneratePaintCodeTest = function(objname) return [[
RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
]] .. objname .. [[:SetText("Boss");
]]; end;
});

RDX.RegisterStatusTextType({
	name = "level";
	title = VFLI.i18n("Level");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	text = UnitLevel(uid);
	if text then
		if (text < 0) then
			RDX.SetStatusText(]] .. objname .. [[, 1, GetQuestDifficultyColor(text), nil);
			]] .. objname .. [[:SetText("??");
		else
			RDX.SetStatusText(]] .. objname .. [[, 1, GetQuestDifficultyColor(text), nil);
			]] .. objname .. [[:SetText(text);
		end
	else
		RDX.SetStatusText(]] .. objname .. [[, 1, GetQuestDifficultyColor(UnitLevel(uid)), nil, "");
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "realm";
	title = VFLI.i18n("Realms");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	_, text = UnitName(uid);
	RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
	]] .. objname .. [[:SetText(text);
]]; end;
});



RDX.RegisterStatusTextType({
	name = "cp";
	title = VFLI.i18n("Combo Points");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	text = 0
	if (uid == "target") then 
		text = GetComboPoints("player");
	else
		text = GetComboPoints(uid);
	end
	if text == 0 then
		]] .. objname .. [[:SetText("");
	else
		RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
		]] .. objname .. [[:SetText(text);
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "hpp";
	title = VFLI.i18n("HP%");
	OnExpose = hpPrereq;
	OnApply = hpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		RDX.SetStatusText(]] .. objname .. [[, unit:FracHealth(), _white, _red);
		]] .. objname .. [[:SetFormattedText("%0.0f%%", unit:FracHealth()*100);
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "hp";
	title = VFLI.i18n("HP");
	OnExpose = hpPrereq;
	OnApply = hpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		if UnitIsPlayer(uid) then 
			RDX.SetStatusText(]] .. objname .. [[, unit:FracHealth(), _white, _red);
			]] .. objname .. [[:SetText(unit:Health());
		else
			RDX.SetStatusText(]] .. objname .. [[, unit:FracHealth(), _white, _red);
			]] .. objname .. [[:SetText(VFL.Kay(unit:Health()));
		end
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "hpm";
	title = VFLI.i18n("HP Missing");
	OnExpose = hpPrereq;
	OnApply = hpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		RDX.SetStatusText(]] .. objname .. [[, unit:FracHealth(), _white, _red);
		]] .. objname .. [[:SetFormattedText("-%d", unit:MissingHealth());
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "hpi";
	title = VFLI.i18n("HP Incoming");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	if (ih or 0) > 0 then
		RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
		]] .. objname .. [[:SetFormattedText("+%d", ih);
	else
		RDX.SetStatusText(]] .. objname .. [[, 1, _white, nil);
		]] .. objname .. [[:SetText("");
	end
	
]]; end;
});

RDX.RegisterStatusTextType({
	name = "hptxt";
	title = VFLI.i18n("HP / HP Max");
	OnExpose = hpPrereq;
	OnApply = hpHint;
	GeneratePaintCode = function(objname) return [[
	RDX.SetStatusText(]] .. objname .. [[, unit:FracHealth(), _white, _red);
	if unit:IsIncapacitated() then
		]] .. objname .. [[:SetText("");
	elseif UnitIsDead(uid) then
		]] .. objname .. [[:SetText("Dead");
	elseif UnitIsGhost(uid) then
		]] .. objname .. [[:SetText("Ghost");
	elseif not UnitIsConnected(uid) then
		]] .. objname .. [[:SetText("LinkDead");
	elseif UnitIsPlayer(uid) then
		]] .. objname .. [[:SetFormattedText("%d / %d", unit:Health(), unit:MaxHealth());
	else
		]] .. objname .. [[:SetFormattedText("%s / %s", VFL.Kay(unit:Health()), VFL.Kay(unit:MaxHealth()));
	end
	
]]; end;
});

RDX.RegisterStatusTextType({
	name = "hptxt2";
	title = VFLI.i18n("HP% | HP / HP Max");
	OnExpose = hpPrereq;
	OnApply = hpHint;
	GeneratePaintCode = function(objname) return [[
	RDX.SetStatusText(]] .. objname .. [[, unit:FracHealth(), _white, _red);
	if not unit:IsIncapacitated() then
		if UnitIsDead(uid) then
			]] .. objname .. [[:SetText("Dead");
		elseif UnitIsGhost(uid) then
			]] .. objname .. [[:SetText("Ghost");
		elseif not UnitIsConnected(uid) then
			]] .. objname .. [[:SetText("LinkDead");
		elseif UnitIsPlayer(uid) then
			]] .. objname .. [[:SetFormattedText("%0.0f%% | %d / %d", unit:FracHealth()*100, unit:Health(), unit:MaxHealth());
		else
			]] .. objname .. [[:SetFormattedText("%0.0f%% | %s / %s", unit:FracHealth()*100, VFL.Kay(unit:Health()), VFL.Kay(unit:MaxHealth()));
		end
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "mpp";
	title = VFLI.i18n("Power%");
	OnExpose = mpPrereq;
	OnApply = mpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
		]] .. objname .. [[:SetFormattedText("%0.0f%%", unit:FracPower()*100);
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "txtmpp";
	title = VFLI.i18n("Type: Power%");
	OnExpose = mpPrereq;
	OnApply = mpHint;
	GeneratePaintCode = function(objname) return [[
		if not unit:IsIncapacitated() then
			local pt = unit:PowerType();
			if pt == 0 then text = "Mana: ";
			elseif pt == 1 then text = "Rage: ";
			elseif pt == 3 then text = "Energy: ";
			elseif pt == 6 then text = "Rune: ";
			end
			RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
			]] .. objname .. [[:SetFormattedText("%s%0.0f%%", text, unit:FracPower()*100);
		else
			]] .. objname .. [[:SetText("");
		end
	]]; end;
});

RDX.RegisterStatusTextType({
	name = "mp";
	title = VFLI.i18n("Power");
	OnExpose = mpPrereq;
	OnApply = mpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		if UnitIsPlayer(uid) then 
			RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
			]] .. objname .. [[:SetText(unit:Power());
		else
			RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
			]] .. objname .. [[:SetText(VFL.Kay(unit:Power()));
		end
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "mpm";
	title = VFLI.i18n("Power Missing");
	OnExpose = mpPrereq;
	OnApply = mpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
		]] .. objname .. [[:SetFormattedText("-%d", unit:MissingPower());
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "mptxt";
	title = VFLI.i18n("Power / Power Max");
	OnExpose = mpPrereq;
	OnApply = mpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		if UnitIsPlayer(uid) then 
			RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
			]] .. objname .. [[:SetFormattedText("%d / %d", unit:Power(), unit:MaxPower());
		else
			RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
			]] .. objname .. [[:SetFormattedText("%s / %s", VFL.Kay(unit:Power()), VFL.Kay(unit:MaxPower()));
		end
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

RDX.RegisterStatusTextType({
	name = "mptxt2";
	title = VFLI.i18n("Power% | Power / Power Max");
	OnExpose = mpPrereq;
	OnApply = mpHint;
	GeneratePaintCode = function(objname) return [[
	if not unit:IsIncapacitated() then
		if UnitIsPlayer(uid) then 
			RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
			]] .. objname .. [[:SetFormattedText("%0.0f%% | %d / %d", unit:FracPower()*100, unit:Power(), unit:MaxPower());
		else
			RDX.SetStatusText(]] .. objname .. [[, unit:FracPower(), _white, _red);
			]] .. objname .. [[:SetFormattedText("%0.0f%% | %s / %s", unit:FracPower()*100, VFL.Kay(unit:Power()), VFL.Kay(unit:MaxPower()));
		end
	else
		]] .. objname .. [[:SetText("");
	end
]]; end;
});

-------------------- STATUS TEXT
RDX.RegisterFeature({
	name = "txt_status"; version = 1; multiple = true;
	title = VFLI.i18n("Text Status");
	category = VFLI.i18n("Texts");
	test = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if (not desc) then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if (not desc.ty) or (not statusText[desc.ty]) then VFL.AddError(errs,VFLI.i18n("Invalid text type.")); return nil; end
		statusText[desc.ty].OnExpose(desc, state, errs);
		if VFL.HasError(errs) then return nil; end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Text_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then
			state:AddSlot("Text_" .. desc.name);
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		if not VFLUI.isFacePathExist(desc.font.face) then desc.font.face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf"; end
		local tname = RDXUI.ResolveTextReference(desc.name);
		
		-- Colorization
		local colorExpr;
		if desc.staticColor then
			local sc = desc.staticColor;
			colorExpr = [[
]] .. tname .. [[:SetTextColor(]] .. sc.r .. "," .. sc.g .. "," .. sc.b .. "," .. sc.a .. [[);
]];
		elseif desc.color then
			local colorVar = strtrim(desc.color or "");
			colorExpr = [[ 
]] .. tname .. [[:SetTextColor(VFL.explodeRGBA(]] .. colorVar .. [[));
]];
		else
			colorExpr = [[ ]];
		end

		---- Generate the code.
		local createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]];

		local destroyCode = [[
]] .. tname .. [[:Destroy();
]] .. tname .. [[ = nil;
]];

		local cleanupCode = [[
]] .. tname .. [[:SetText("");
]] .. tname .. [[:SetTextColor(1,1,1,1);
]];

		local paintCode = statusText[desc.ty].GeneratePaintCode(tname) .. colorExpr;
		
		local paintCodeTest;
		if statusText[desc.ty].GeneratePaintCodeTest then
			paintCodeTest = statusText[desc.ty].GeneratePaintCodeTest(tname) .. colorExpr;
		else
			paintCodeTest = statusText[desc.ty].GeneratePaintCode(tname) .. colorExpr;
		end

		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode(cleanupCode); end);
		state:Attach(state:Slot("EmitPaint"), true, function(code) if desc.test then code:AppendCode(paintCodeTest); else code:AppendCode(paintCode); end end);

		statusText[desc.ty].OnApply(desc, state);
		
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er, desc.font); fontsel:Show();
		er:EmbedChild(fontsel); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Display"));
		local display = VFLUI.Dropdown:new(er, function() return statusIndex; end);
		display:SetWidth(250); display:Show();
		display:SetSelection(statusText[desc.ty].title, desc.ty);
		er:EmbedChild(display); er:Show(); ui:InsertFrame(er);
		
		local chk_static = VFLUI.Checkbox:new(ui); chk_static:Show();
		chk_static:SetText(VFLI.i18n("Use static color"));
		local swatch = VFLUI.ColorSwatch:new(chk_static);
		swatch:SetPoint("RIGHT", chk_static, "RIGHT"); swatch:Show();
		if desc and desc.staticColor then 
			chk_static:SetChecked(true);
			swatch:SetColorTable(desc.staticColor);
		else 
			chk_static:SetChecked(); 
			swatch:SetColor(1,1,1,1);
		end
		ui:InsertFrame(chk_static);
		
		local colorVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then colorVar:SetSelection(desc.color); end

		function ui:GetDescriptor()
			local _,ty = display:GetSelection();
			local sc = nil;
			if chk_static:GetChecked() then sc = swatch:GetColor(); end
			local scolorVar = strtrim(colorVar:GetSelection() or "");
			if scolorVar == "" then scolorVar = nil; end
			return { 
				feature = "txt_status"; version = 1;
				ty = ty;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				font = fontsel:GetSelectedFont();
				staticColor = sc;
				color = scolorVar;
			};
		end
		
		ui.Destroy = VFL.hook(function() swatch:Destroy(); end, ui.Destroy);
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "txt_status"; version = 1;
			ty = "fdld"; owner = "decor";
			name = "status_text", w = 40, h = 14, anchor = { lp = "RIGHT", af = "Base", rp = "RIGHT", dx = 0, dy = 0 };
			font = VFL.copy(Fonts.Default);
		};
	end;
});

