-- Text.lua
-- OpenRDX

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
	name = "levelrace";
	title = VFLI.i18n("Level Race");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	text = UnitLevel(uid);
	if text then
		if (text < 0) then
			text = VFL.tcolorize("?? ", GetQuestDifficultyColor(text));
		else
			text = VFL.tcolorize(text, GetQuestDifficultyColor(text)) .. " ";
		end
	else
		text = "";
	end
	if UnitIsPlayer(uid) then
		text = text .. (UnitRace(uid) or "");
	else
		if UnitCreatureType(uid) == "Beast" and UnitCreatureFamily(uid) then
			text = text .. UnitCreatureFamily(uid);
		else
			text = text .. UnitCreatureType(uid) or "";
		end
	end
	]] .. objname .. [[:SetText(text);
]]; end;
});

RDX.RegisterStatusTextType({
	name = "guild";
	title = VFLI.i18n("Guild");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	GeneratePaintCode = function(objname) return [[
	text = "";
	textcolor = _grey;
	if UnitIsPlayer(uid) then
		_apps = GetGuildInfo(uid);
		if _apps then
			text = _apps;
			_meta = GetGuildInfo("player")
			if _apps == _meta then
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
	_meta = UnitClassification(uid);
	text = "";
	textcolor = _grey;
	if (_meta ~= "normal") then
		if (_meta == "worldboss") then
			text = "Boss";
			textcolor = _white;
		elseif (_meta == "rareelite") then
			text = "Rare Elite";
			textcolor = _yellow;
		elseif (_meta == "elite") then
			text = "Elite Mob";
			textcolor = _yellow;
		elseif (_meta == "rare") then
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
			_i = unit:PowerType();
			if _i == 0 then text = "Mana: ";
			elseif _i == 1 then text = "Rage: ";
			elseif _i == 3 then text = "Energy: ";
			elseif _i == 6 then text = "Rune: ";
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

----------------- Other text types and code
local otherText = {};
local otherIndex = {};
function RDX.RegisterOtherTextType(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if otherText[tbl.name] then RDX.printW("Attempt to register duplicate Other Text Type " .. tbl.name); return; end
	otherText[tbl.name] = tbl;
	table.insert(otherIndex, {value = tbl.name, text = tbl.title});
	table.sort(otherIndex, function(x1,x2) return x1.text < x2.text; end);
end
local function getotherIndex() return otherIndex; end

RDX.RegisterOtherTextType({
	name = "AUI";
	title = VFLI.i18n("AUI Name");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "event"; -- "event" or "interval"
	eventType = "RDXEvents"; -- "WoWEvents" or "RDXEvents"
	eventName = "AUI";
	interval = 2;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_, word = RDXDB.ParsePath(RDXU.AUI);
text = "AUI: " .. (word or "Unknown");
]]; end;
});

RDX.RegisterOtherTextType({
	name = "AUIState";
	title = VFLI.i18n("AUI State");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "event"; -- "event" or "interval"
	eventType = "RDXEvents"; -- "WoWEvents" or "RDXEvents"
	eventName = "AUIState";
	interval = 2;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
text = "State: " .. (RDXU.AUIState or "Unknown");
]]; end;
});

RDX.RegisterOtherTextType({
	name = "Repository";
	title = VFLI.i18n("Repository size");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_i = GetAddOnMemoryUsage("RDX_filesystem");
textcolor = _green;
if _i > 10000 then textcolor = _yellow; end
if _i > 20000 then textcolor = _orange; end
if _i > 30000 then textcolor = _red; end
_i = _i * 1000;
text = "Repository: " .. VFL.KayMemory(_i, textcolor);
]]; end;
});

RDX.RegisterOtherTextType({
	name = "Usage";
	title = VFLI.i18n("Mem/Fps/Ms");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
text = VFLP.GetTextPerf();
]]; end;
});

RDX.RegisterOtherTextType({
	name = "Memory Debit";
	title = VFLI.i18n("Memory Debit");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_, text = VFLP.GetTextPerf();
]]; end;
});

RDX.RegisterOtherTextType({
	name = "Time";
	title = VFLI.i18n("Time");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
text = date("%H:%M");
]]; end;
});

RDX.RegisterOtherTextType({
	name = "bagsfree";
	title = VFLI.i18n("Bags Free Slots");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 5;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_i, _j = 0, 0;
for i=1, 4 do 
	_j = GetContainerNumFreeSlots(i);
	_i = _i + _j;
end
text = _i;
]]; end;
});

RDX.RegisterOtherTextType({
	name = "mails";
	title = VFLI.i18n("Inbox mails");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 5;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
CheckInbox();
_i = GetInboxNumItems();
if _i then text = _i; else text = "0"; end 
]]; end;
});

RDX.RegisterOtherTextType({
	name = "mapzonetext";
	title = VFLI.i18n("Map Zone Text");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_bn = GetMinimapZoneText();
_i, _j = GetPlayerMapPosition("player");
_apps = "";
if(_i == 0 and _j == 0) then
	_apps = "";
else
	_apps = " "..format("%.2d || %.2d",_i*100,_j*100);
end
text = (_bn.._apps);
]]; end;
});

RDX.RegisterOtherTextType({
	name = "Time 2";
	title = VFLI.i18n("Time 2");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_apps = false;
_i = date("%H");
_j = date("%M");
--minute = floor(minute / 10) == 0 and "0" .. minute or minute
text = "";

if _apps then
	text = _i .. ":" .. _j;
else
	_meta = (floor(_i / 12) == 1) and  "pm" or "am";
	_i = mod(_i, 12);
	if _i == 0 then _i = 12 end
	if _meta == "pm" then
		_meta = VFL.strtcolor(_bluesky) .. _meta;
	else
		_meta = VFL.strcolor(1,1,.5) .. _meta;
	end
	text = _i .. ":" .. _j .. " " .. _meta;
end
]]; end;
});

RDX.RegisterOtherTextType({
	name = "mapzonetext 2";
	title = VFLI.i18n("Map Zone Text 2");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_bn = GetMinimapZoneText();
_apps = GetZonePVPInfo();
if (_apps == "sanctuary") then 
  color = VFL.strcolor(.408,.8,.937) .. _bn; 
elseif (_apps == "arena") then 
  color = VFL.strcolor(1,.098,.098) ..  _bn;
elseif (_apps == "friendly") then 
  color = VFL.strcolor(.098,1,.098) .. _bn;
elseif (_apps == "hostile" or _apps == "combat") then 
  color = VFL.strcolor(1,.098,.098) .. _bn;
elseif (_apps == "contested") then 
  color = VFL.strcolor(1,.635,0) .. _bn;
elseif (_apps == nil) then 
  color = VFL.strcolor(1,.98,.98) .. _bn;
end;
text = color
]]; end;
});

RDX.RegisterOtherTextType({
	name = "btnf";
	title = VFLI.i18n("BattleNet Friends");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_i = 0;
_j = 0;
for n=1, GetNumFriends() do
  _,_,_,_, _apps = GetFriendInfo(n);
  if _apps then _i = _i + 1; end
end
for bn=1, BNGetNumFriends() do
  _,_,_,_, _apps = BNGetFriendInfo(bn);
  if _apps then _j = _j + 1; end
end
text = VFL.strtcolor(_white) .. "F: " .. VFL.strcolor(1,1,.50) .. _i .. VFL.strtcolor(_white) .. "/" .. VFL.strcolor(1,1,.5) .. GetNumFriends() .. VFL.strtcolor(_white) .. " BN: " .. VFL.strtcolor(_bluesky) .. _j .. VFL.strtcolor(_white) ..  "/" .. VFL.strtcolor(_bluesky) .. BNGetNumFriends();
]]; end;
});

RDX.RegisterOtherTextType({
	name = "Usage 2";
	title = VFLI.i18n("Fps/Ms");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = "RDXEvents"; -- "WoWEvents" or "RDXEvents"
	eventName = "AUI";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_apps = "";
_i = floor(GetFramerate() or "");
if _i >= 50 then
  _apps = VFL.strtcolor(_green) .. _i ..VFL.strtcolor(_white) .."fps ";
elseif _i <= 49 and _i >= 35 then
  _apps = VFL.strtcolor(_yellow) .. _i ..VFL.strtcolor(_white) .."fps ";
elseif _i <= 34 and _i >= 21 then
  _apps = VFL.strtcolor(_orange) .. _i ..VFL.strtcolor(_white) .."fps ";
elseif _i <= 20 then
  _apps = VFL.strtcolor(_red) .. _i .. VFL.strtcolor(_white) .."fps ";
end;
_,_, _j = GetNetStats();
if _j <= 125 then
  _j = VFL.strtcolor(_green) .. _j .. VFL.strtcolor(_white) .. "ms";
elseif _j >= 126 and _j <= 250 then
  _j = VFL.strtcolor(_yellow) .. _j .. VFL.strtcolor(_white) .. "ms";
elseif _j >= 251 and _j <= 375 then
  _j = VFL.strtcolor(_orange) .. _j .. VFL.strtcolor(_white) .. "ms";
elseif _j >= 376 then
  _j = VFL.strtcolor(_red) .. _j .. VFL.strtcolor(_white) .. "ms";
end;  
text = _apps  .. _j;
]]; end;
});

RDX.RegisterOtherTextType({
	name = "guild";
	title = VFLI.i18n("Guild");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_i = GetNumGuildMembers(true);
_j = 0;
--_bn = 0;
for i = 1, _i do
	_,_,_,_,_,_,_,_,_apps = GetGuildRosterInfo(i);
	if _apps then
		_j = _j + 1;
	--else
	--	_bn = _bn + 1;
	end
end
text =  "Guild: " .. VFL.strtcolor(_green) .. _j;
]]; end;
});

RDX.RegisterOtherTextType({
	name = "durability";
	title = VFLI.i18n("Durability");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_i, _j = Logistics.GetDurability();
_apps = floor((_i/_j) *100);
if _apps >=75 then
	text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_green) .. _apps .. VFL.strtcolor(_white) .. "%";
elseif _apps <=74 and _apps >=50 then
	text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_yellow) .. _apps .. VFL.strtcolor(_white) .. "%";
elseif _apps <=49 and _apps >=25 then
	text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_orange)  .. _apps .. VFL.strtcolor(_white) .. "%";
elseif _apps <= 24 then
	text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_red).. _apps .. VFL.strtcolor(_white) .. "%";
else
	text = "";
end;
]]; end;
});

RDX.RegisterOtherTextType({
	name = "gold";
	title = VFLI.i18n("Gold");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 1;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_i = GetMoney();
if _i <= 99 then
  text = VFL.strcolor(1,.450,.300) .. _i .. "c";
elseif _i >= 100 and _i <= 9999 then
  text = VFL.strcolor(.750,.900,1) .. strsub(_i,  -4, -3) .. "s " .. VFL.strcolor(1,.450,.300) .. strsub(_i,  -2) .. "c";
elseif _i >= 10000 then
  text = VFL.strtcolor(_yellow) .. strsub(_i, 0, -5) .. "g " .. VFL.strcolor(.750,.900,1) .. strsub(_i,  -4, -3) .. "s " .. VFL.strcolor(1,.450,.300) .. strsub(_i,  -2) .. "c";
else
  text = "";
end
]]; end;
});

RDX.RegisterOtherTextType({
	name = "yourthreat";
	title = VFLI.i18n("Your Threat Percent");
	OnExpose = VFL.Noop;
	OnApply = VFL.Noop;
	repaintType = "interval"; -- "event" or "interval"
	eventType = ""; -- "WoWEvents" or "RDXEvents"
	eventName = "";
	interval = 2;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
_, _, _i, _, _ = UnitDetailedThreatSituation("player", "target");
if _i > 90 then
	text = VFL.strtcolor(_red) .. _i .. "%";
elseif _i > 70 then
	text = VFL.strtcolor(_orange) .. _i .. "%";
elseif _i > 50 then
	text = VFL.strtcolor(_yellow) .. _i .. "%";
else
	text = VFL.strtcolor(_green) .. _i .. "%";
end
]]; end;
});

--------------------------------------------------------------------------------

RDX.RegisterFeature({
	name = "txt2";
	version = 1; 
	multiple = true;
	test = true;
	title = VFLI.i18n("Text");
	category = VFLI.i18n("Basics");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.tyo then desc.tyo = "gold"; end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Text_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if desc.ftype == 1 then
		
		elseif desc.ftype == 2 then
			if not desc.txt then
				VFL.AddError(errs, VFLI.i18n("Invalid texte")); flg = nil;
			end
		elseif desc.ftype == 3 then
			if not desc.txtdata or (not state:Slot("TextData_" .. desc.txtdata)) then
				VFL.AddError(errs, VFLI.i18n("Invalid text object pointer")); flg = nil;
			end
		elseif desc.ftype == 4 then
			if (not desc.ty) or (not statusText[desc.ty]) then VFL.AddError(errs,VFLI.i18n("Invalid text type")); flg = nil; end
			statusText[desc.ty].OnExpose(desc, state, errs);
			if VFL.HasError(errs) then flg = nil; end
		elseif desc.ftype == 5 then
		
		elseif desc.ftype == 6 then
			if flg then 
				state:AddSlot("TextCustom_" .. desc.name);
			end
		end
		if flg then state:AddSlot("Text_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		if not VFLUI.isFacePathExist(desc.font.face) then desc.font.face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf"; end
		local tname = RDXUI.ResolveTextReference(desc.name);
		
		local driver = desc.driver or 1;
		
		local createCode = "";
		local destroyCode = "";
		local cleanupCode = "";
		local paintCode = "";
		local paintCodeTest = "";
		
		-- Color
		local colorVar, colorBoo = strtrim(desc.color or ""), "false";
		if colorVar ~= "" then colorBoo = "true"; end
		
		if desc.ftype == 1 then
			-- Text
			local textExpr;
			if desc.trunc then
				textExpr = "unit:GetProperName():sub(1, " .. desc.trunc .. ")";
			else
				textExpr = "unit:GetProperName()";
			end
			
			local colorclassBoo = "false";
			if desc.classColor then colorclassBoo = "true"; end

			createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]];

			destroyCode = [[
]] .. tname .. [[:Destroy();
]] .. tname .. [[ = nil;
]];

			cleanupCode = [[
]] .. tname .. [[:SetText("");
]] .. tname .. [[:SetTextColor(1,1,1,1);
]];

			paintCode = [[
if UnitExists(uid) then
	]] .. tname .. [[:SetText(]] .. textExpr .. [[);
else
	]] .. tname .. [[:SetText("");
end
if ]] .. colorclassBoo .. [[ then
	]] .. tname .. [[:SetTextColor(explodeRGBA(unit:GetClassColor()));
end

if ]] .. colorBoo .. [[ then
	]] .. tname .. [[:SetTextColor(explodeRGBA(]] .. colorVar .. [[));
end

]];
			paintCodeTest = paintCode;
		elseif desc.ftype == 2 then
			createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]];
			destroyCode = [[
]] .. tname .. [[:Destroy(); 
]] .. tname .. [[ = nil;
]];
			cleanupCode = [[
]] .. tname .. [[:SetText("");
]];
			paintCode = [[
]] .. tname .. [[:SetText("]] .. desc.txt .. [[");
if ]] .. colorBoo .. [[ then
	]] .. tname .. [[:SetTextColor(explodeRGBA(]] .. colorVar .. [[));
end
]];
			paintCodeTest = paintCode;
		elseif desc.ftype == 3 then
			createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]];
			destroyCode = [[
]] .. tname .. [[:Destroy();
]] .. tname .. [[ = nil;
]];
			cleanupCode = [[
]] .. tname .. [[:SetText("");
]];
			paintCode = [[
]] .. tname .. [[:SetText(]] .. desc.txtdata .. [[);
if ]] .. colorBoo .. [[ then
	]] .. tname .. [[:SetTextColor(explodeRGBA(]] .. colorVar .. [[));
end
]];
			paintCodeTest = paintCode;
		elseif desc.ftype == 4 then
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
]] .. tname .. [[:SetTextColor(explodeRGBA(]] .. colorVar .. [[));
]];
			else
				colorExpr = [[ ]];
			end

			---- Generate the code.
			createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]];

			destroyCode = [[
]] .. tname .. [[:Destroy();
]] .. tname .. [[ = nil;
]];

			cleanupCode = [[
]] .. tname .. [[:SetText("");
]] .. tname .. [[:SetTextColor(1,1,1,1);
]];
			if desc.hidecombat then
				paintCode = [[
			if UnitAffectingCombat(uid) then
				]] .. tname .. [[:SetText("");
			else
]];
				paintCode = paintCode .. statusText[desc.ty].GeneratePaintCode(tname) .. colorExpr;
				paintCode = paintCode .. [[
			end
]];
			else
				paintCode = statusText[desc.ty].GeneratePaintCode(tname) .. colorExpr;
			end

			if statusText[desc.ty].GeneratePaintCodeTest then
				paintCodeTest = statusText[desc.ty].GeneratePaintCodeTest(tname) .. colorExpr;
			else
				paintCodeTest = statusText[desc.ty].GeneratePaintCode(tname) .. colorExpr;
			end
		elseif desc.ftype == 5 then
			createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]] .. otherText[desc.tyo].GenerateCreateCodeVariable(tname) .. [[
local function artf_]] .. desc.name .. [[()
	]] .. otherText[desc.tyo].GenerateCreateCode(tname) .. [[
	if text then ]] .. tname .. [[:SetText(text); end
end
artf_]] .. desc.name .. [[();
]];
			if otherText[desc.tyo].repaintType == "interval" then
				createCode = createCode .. [[
VFLT.AdaptiveSchedule("artf_]] .. desc.name .. [[", ]] .. otherText[desc.tyo].interval .. [[, artf_]] .. desc.name .. [[);
]];
			else
				createCode = createCode .. [[
]] .. otherText[desc.tyo].eventType ..[[:Bind("]] .. otherText[desc.tyo].eventName .. [[", nil, artf_]] .. desc.name .. [[, "artf_]] .. desc.name .. [[");
]];
			end
			
			destroyCode = [[
]];
			if otherText[desc.tyo].repaintType == "interval" then
				destroyCode = destroyCode .. [[
VFLT.AdaptiveUnschedule("artf_]] .. desc.name .. [[");
]]
			else
				destroyCode = destroyCode .. [[
]] .. otherText[desc.tyo].eventType ..[[:Unbind("artf_]] .. desc.name .. [[");
]];
			end
			destroyCode = destroyCode .. [[
]] .. tname .. [[:Destroy(); ]] .. tname .. [[ = nil;
]];	
		elseif desc.ftype == 6 then
			createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]];
			destroyCode = [[
]] .. tname .. [[:Destroy(); 
]] .. tname .. [[ = nil;
]];
			cleanupCode = [[
]] .. tname .. [[:SetText("");
]];
			local md,_,_,ty = RDXDB.GetObjectData(desc.script);
			if (md) and (ty == "Script") and (md.data) and ( md.data.script) then
				paintCode = [[
text = ]] .. (desc.useNil and 'nil' or '""') .. [[;

]] .. md.data.script .. [[

if text then ]] .. tname .. [[:SetText(text); 
	if ]] .. colorBoo .. [[ then ]] .. tname .. [[:SetTextColor(explodeRGBA(]] ..colorVar .. [[)); end 
end
]];
			end
		end

		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode(cleanupCode); end);
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		
		if desc.ftype == 4 then
			statusText[desc.ty].OnApply(desc, state);
		end
		
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Default parameters")));

		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Font parameters")));

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er, desc.font); fontsel:Show();
		er:EmbedChild(fontsel); er:Show();
		ui:InsertFrame(er);
		
		local colorVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then colorVar:SetSelection(desc.color); end
		
		local ftype = VFLUI.DisjointRadioGroup:new();
		local ftype_1 = ftype:CreateRadioButton(ui);
		ftype_1:SetText(VFLI.i18n("Use Nameplate Text"));
		local ftype_2 = ftype:CreateRadioButton(ui);
		ftype_2:SetText(VFLI.i18n("Use Static Text"));
		local ftype_3 = ftype:CreateRadioButton(ui);
		ftype_3:SetText(VFLI.i18n("Use Dynamic Text"));
		local ftype_4 = ftype:CreateRadioButton(ui);
		ftype_4:SetText(VFLI.i18n("Use Status Text"));
		local ftype_5 = ftype:CreateRadioButton(ui);
		ftype_5:SetText(VFLI.i18n("Use Info Text"));
		local ftype_6 = ftype:CreateRadioButton(ui);
		ftype_6:SetText(VFLI.i18n("Use Custom Text"));
		ftype:SetValue(desc.ftype or 1);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Type Nameplate")));
		ui:InsertFrame(ftype_1);

		local ed_trunc = VFLUI.LabeledEdit:new(ui, 50); ed_trunc:Show();
		ed_trunc:SetText(VFLI.i18n("Max name length (blank = no truncation)"));
		if desc and desc.trunc then ed_trunc.editBox:SetText(desc.trunc); end
		ui:InsertFrame(ed_trunc);

		local chk_colorclass = VFLUI.Checkbox:new(ui); chk_colorclass:Show();
		chk_colorclass:SetText(VFLI.i18n("Use class color"));
		if desc and desc.classColor then chk_colorclass:SetChecked(true); else chk_colorclass:SetChecked(); end
		ui:InsertFrame(chk_colorclass);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Type Static")));
		ui:InsertFrame(ftype_2);
		
		local txt = VFLUI.LabeledEdit:new(ui, 200);
		txt:SetText(VFLI.i18n("Text Static"));
		txt:Show();
		if desc and desc.txt then txt.editBox:SetText(desc.txt); end
		ui:InsertFrame(txt);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Type Dynamic")));
		ui:InsertFrame(ftype_3);
		
		local txtdata = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Text Data"), state, "TextData_");
		if desc and desc.txtdata then txtdata:SetSelection(desc.txtdata); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Type Status")));
		ui:InsertFrame(ftype_4);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Display"));
		local display = VFLUI.Dropdown:new(er, function() return statusIndex; end);
		display:SetWidth(250); display:Show();
		if desc.ty then 
			display:SetSelection(statusText[desc.ty].title, desc.ty);
		end
		er:EmbedChild(display); er:Show(); ui:InsertFrame(er);
		
		local chk_static = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use static color"));
		local swatch = VFLUI.ColorSwatch:new(chk_static); swatch:Show();
		if desc and desc.staticColor then 
			chk_static:SetChecked(true);
			swatch:SetColorTable(desc.staticColor);
		else 
			chk_static:SetChecked(); 
			swatch:SetColor(1,1,1,1);
		end
		chk_static:EmbedChild(swatch); chk_static:Show();
		ui:InsertFrame(chk_static);
		
		local chk_hidecombat = VFLUI.Checkbox:new(ui); chk_hidecombat:Show();
		chk_hidecombat:SetText(VFLI.i18n("Hide Under combat"));
		if desc and desc.hidecombat then chk_hidecombat:SetChecked(true); else chk_hidecombat:SetChecked(); end
		ui:InsertFrame(chk_hidecombat);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Type Info")));
		ui:InsertFrame(ftype_5);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Display"));
		local display2 = VFLUI.Dropdown:new(er, getotherIndex);
		display2:SetWidth(250); display2:Show();
		display2:SetSelection(otherText[desc.tyo].title, desc.tyo);
		er:EmbedChild(display2); er:Show(); ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Type Custom")));
		ui:InsertFrame(ftype_6);
		
		local chk_useNil = VFLUI.Checkbox:new(ui); 
		chk_useNil:Show(); chk_useNil:SetText(VFLI.i18n("Preserve existing content if text local variable is undefined"))
		if desc and desc.useNil then chk_useNil:SetChecked(true); end
		ui:InsertFrame(chk_useNil);

		local scriptsel = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Script")); end);
		scriptsel:SetLabel(VFLI.i18n("Script")); scriptsel:Show();
		if desc and desc.script then scriptsel:SetPath(desc.script); end
		ui:InsertFrame(scriptsel);

		function ui:GetDescriptor()
			local trunc = tonumber(ed_trunc.editBox:GetText());
			if trunc then trunc = VFL.clamp(trunc, 1, 50); end
			local scolorVar = strtrim(colorVar:GetSelection() or "");
			if scolorVar == "" then scolorVar = nil; end
			local _,ty = display:GetSelection();
			local _,tyo = display2:GetSelection();
			local sc = nil;
			if chk_static:GetChecked() then sc = swatch:GetColor(); end
			return { 
				feature = "txt2";
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				--
				font = fontsel:GetSelectedFont();
				color = scolorVar;
				--
				ftype = ftype:GetValue();
				trunc = trunc;
				classColor = chk_colorclass:GetChecked();
				txt =  txt.editBox:GetText();
				txtdata = txtdata.editBox:GetText();
				ty = ty;
				staticColor = sc;
				hidecombat = chk_hidecombat:GetChecked();
				tyo = tyo;
				useNil = chk_useNil:GetChecked();
				script = scriptsel:GetPath();
			};
		end
		
		ui.Destroy = VFL.hook(function(s) 
			ftype:Destroy(); ftype = nil;
		end, ui.Destroy);
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "txt2"; version = 1;
			name = "text1", w = 50, h = 14, owner = "Frame_decor",
			anchor = { lp = "LEFT", af = "Frame_decor", rp = "LEFT", dx = 0, dy = 0 };
			font = VFL.copy(Fonts.Default);
			ftype = 1;
			ty = "fdld";
			tyo = "gold";
		};
	end;
});

RDX.RegisterFeature({
	name = "txt_np";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "txt2";
		desc.ftype = 1;
	end;
});

RDX.RegisterFeature({
	name = "txt_static";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "txt2";
		desc.ftype = 2;
	end;
});

RDX.RegisterFeature({
	name = "txt_dyn";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "txt2";
		desc.ftype = 3;
		desc.txtdata = desc.txt;
		desc.txt = nil;
	end;
});

RDX.RegisterFeature({
	name = "txt_status";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "txt2";
		desc.ftype = 4;
	end;
});

RDX.RegisterFeature({
	name = "txt_other";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "txt2";
		desc.ftype = 5;
		desc.tyo = desc.ty;
		desc.ty = "fdld";
	end;
});

RDX.RegisterFeature({
	name = "txt_custom";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "txt2";
		desc.ftype = 6;
	end;
});
