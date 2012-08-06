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
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not VFLUI.isFacePathExist(desc.font.face) then VFL.AddError(errs, VFLI.i18n("Font path not found.")); return nil; end
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
