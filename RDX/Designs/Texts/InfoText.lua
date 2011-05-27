-- InfoText.lua
-- Daniel Ly  / OpenRDX

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
	interval = 0;
	GenerateCreateCodeVariable = function(objname) return [[
]]; end;
	GenerateCreateCode = function(objname) return [[
local _, duiname = RDXDB.ParsePath(RDXU.AUI);
text = "AUI: " .. (duiname or "Unknown");
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
	interval = 0;
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
local zone = GetMinimapZoneText();
local x, y = GetPlayerMapPosition("player");
local coords;
if(x == 0 and y == 0) then
	coords = "";
else
	coords = " "..format("%.2d || %.2d",x*100,y*100);
end
text = (zone..coords);
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
local  time24 = false --True if you want military time
local hour = date("%H")
local minute = date("%M")
minute = floor(minute / 10) == 0 and "0" .. minute or minute
local time = ""
if time24 == true then
  time = hour .. ":" .. minute
else
  local ampm = (floor(hour / 12) == 1) and  "pm" or "am"
  hour = mod(hour, 12)
  if hour == 0 then
    hour = 12
  end
  if ampm == "pm" then 
    ampm = VFL.strtcolor(_bluesky) .. ampm
  else
    ampm = VFL.strcolor(1,1,.5) .. ampm
  end
  time = hour .. ":" .. minute .. " " .. ampm
end
text = time
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
local zone = GetMinimapZoneText();
local pvpType = GetZonePVPInfo();
if (pvpType == "sanctuary") then 
  color = VFL.strcolor(.408,.8,.937) .. zone; 
elseif (pvpType == "arena") then 
  color = VFL.strcolor(1,.098,.098) ..  zone;
elseif (pvpType == "friendly") then 
  color = VFL.strcolor(.098,1,.098) .. zone;
elseif (pvpType == "hostile" or pvpType == "combat") then 
  color = VFL.strcolor(1,.098,.098) .. zone;
elseif (pvpType == "contested") then 
  color = VFL.strcolor(1,.635,0) .. zone;
elseif (pvpType == nil) then 
  color = VFL.strcolor(1,.98,.98) .. zone;
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
local f = 0;
local bnf = 0;
for n=1, GetNumFriends() do
  _,_,_,_, conn = GetFriendInfo(n);
  if conn then f = f +1; end
end
for bn=1, BNGetNumFriends() do
  _,_,_,_, conn = BNGetFriendInfo(bn);
  if conn then bnf = bnf +1; end
end
text = VFL.strtcolor(_white) .. "F: " .. VFL.strcolor(1,1,.50) .. f .. VFL.strtcolor(_white) .. "/" .. VFL.strcolor(1,1,.5) .. GetNumFriends() .. VFL.strtcolor(_white) .. " BN: " .. VFL.strtcolor(_bluesky) .. bnf .. VFL.strtcolor(_white) ..  "/" .. VFL.strtcolor(_bluesky) .. BNGetNumFriends();
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
local fpstext = "";
local fps = floor(GetFramerate() or "" );
if fps >= 50 then
  fpstext = VFL.strtcolor(_green) ..fps ..VFL.strtcolor(_white) .."fps ";
elseif fps <= 49 and fps >= 35 then
  fpstext = VFL.strtcolor(_yellow) ..fps ..VFL.strtcolor(_white) .."fps ";
elseif fps <= 34 and fps >= 21 then
  fpstext = VFL.strtcolor(_orange) ..fps ..VFL.strtcolor(_white) .."fps ";
elseif fps <= 20 then
  fpstext = VFL.strtcolor(_red) .. fps .. VFL.strtcolor(_white) .."fps ";
end;
local _,_,lag = GetNetStats();
if lag <= 125 then
  lag = VFL.strtcolor(_green) ..lag.. VFL.strtcolor(_white) .. "ms";
elseif lag >= 126 and lag <= 250 then
  lag = VFL.strtcolor(_yellow) ..lag.. VFL.strtcolor(_white) .. "ms";
elseif lag >= 251 and lag <= 375 then
  lag = VFL.strtcolor(_orange) ..lag.. VFL.strtcolor(_white) .. "ms";
elseif lag >= 376 then
  lag = VFL.strtcolor(_red) ..lag.. VFL.strtcolor(_white) .. "ms";
end;  
text = fpstext  .. lag;
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
local total = GetNumGuildMembers(true)
local onlineTotal = 0
local offlineTotal = 0
for i = 1, total 
do 
  local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(i)
  if online
  then
    onlineTotal = onlineTotal + 1
  else
    offlineTotal = offlineTotal + 1
  end
end
text =  "Guild: " .. VFL.strtcolor(_green) .. onlineTotal;
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
local currdur, maxdur = Logistics.GetDurability();
local dura = floor((currdur/maxdur) *100);

if dura >=75 then
  text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_green) .. dura .. VFL.strtcolor(_white) .. "%";
elseif dura <=74 and dura >=50 then
  text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_yellow) .. dura .. VFL.strtcolor(_white) .. "%";
elseif dura <=49 and dura >=25 then
  text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_orange)  .. dura .. VFL.strtcolor(_white) .. "%";
elseif dura <= 24 then
  text = VFL.strtcolor(_white) .. "Durability: " .. VFL.strtcolor(_red).. dura .. VFL.strtcolor(_white) .. "%";
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
local money = GetMoney();

if money <= 99 then
  text = VFL.strcolor(1,.450,.300) .. money .. "c";
elseif money >= 100 and money <= 9999 then
  text = VFL.strcolor(.750,.900,1) .. strsub(money,  -4, -3) .. "s " .. VFL.strcolor(1,.450,.300) .. strsub(money,  -2) .. "c";
elseif money >= 10000 then
  text = VFL.strtcolor(_yellow) .. strsub(money, 0, -5) .. "g " .. VFL.strcolor(.750,.900,1) .. strsub(money,  -4, -3) .. "s " .. VFL.strcolor(1,.450,.300) .. strsub(money,  -2) .. "c";
else
  text = "";
end
]]; end;
});

--- Scripted custom text.
RDX.RegisterFeature({
	name = "txt_other"; version = 1; multiple = true;
	title = VFLI.i18n("Text Info");
	category = VFLI.i18n("Texts");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not VFLUI.isFacePathExist(desc.font.face) then VFL.AddError(errs, i18n("Font path not found.")); return nil; end
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
		local objname = "Text_" .. desc.name;
		
		---- Generate the code.
		local createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
frame.]] .. objname .. [[ = txt;

]] .. otherText[desc.ty].GenerateCreateCodeVariable(objname) .. [[

local function artf_]] .. objname .. [[()
	]] .. otherText[desc.ty].GenerateCreateCode(objname) .. [[
	if text then frame.]] .. objname .. [[:SetText(text); end
end

artf_]] .. objname .. [[();
]];
if otherText[desc.ty].repaintType == "interval" then
		createCode = createCode .. [[
VFLT.AdaptiveSchedule("artf_]] .. objname .. [[", ]] .. otherText[desc.ty].interval .. [[, artf_]] .. objname .. [[);
]];
else
		createCode = createCode .. [[
]] .. otherText[desc.ty].eventType ..[[:Bind("]] .. otherText[desc.ty].eventName .. [[", nil, artf_]] .. objname .. [[, "artf_]] .. objname .. [[");
]];
end

		local destroyCode = [[
]]
if otherText[desc.ty].repaintType == "interval" then
		destroyCode = destroyCode .. [[
VFLT.AdaptiveUnschedule("artf_]] .. objname .. [[");
]]
else
		destroyCode = destroyCode .. [[
]] .. otherText[desc.ty].eventType ..[[:Unbind("artf_]] .. objname .. [[");
]];
end
		destroyCode = destroyCode .. [[
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];

		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		
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
		local display = VFLUI.Dropdown:new(er, getotherIndex);
		display:SetWidth(250); display:Show();
		display:SetSelection(otherText[desc.ty].title, desc.ty);
		er:EmbedChild(display); er:Show(); ui:InsertFrame(er);

		function ui:GetDescriptor()
			local _,ty = display:GetSelection();
			return { 
				feature = "txt_other"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				font = fontsel:GetSelectedFont();
				ty = ty;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "txt_other", version = 1,
			name = "otxt1", w = 50, h = 14, owner = "decor",
			anchor = { lp = "LEFT", af = "Base", rp = "LEFT", dx = 0, dy = 0 }, 
			font = VFL.copy(Fonts.Default); ty = "AUI",
		};
	end;
});
