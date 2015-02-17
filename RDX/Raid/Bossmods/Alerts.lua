-- Alerts.lua
-- RDX - Raid Data Exchange
-- (C)2005-06 Bill Johnson 
--
-- An alert is a UI frame with an associated timetable. Animations, sounds,
-- and other events are executed based on this timetable.
--
-- There are two "stacks" of alerts onscreen, one stack in the center and one
-- at the top. Alerts can migrate between the two stacks via smooth animations.
-- 

local clamp = VFL.clamp;

------------- ANIMATION HELPER FUNCTIONS
local function GenMoveFunc(point, fromx, fromy, tox, toy, froma, toa, froms, tos, t0, dt)
	if(not dt) or (dt == 0) then return VFL.Noop; end
	return function(frame, t)
		local f = clamp((t-t0)/dt, 0, 1);
		frame:SetScale(froms+((tos-froms)*f)); 
		frame:SetAlpha(froma+((toa-froma)*f));
		frame:ClearAllPoints();
		frame:SetPoint( point, UIParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, fromx+((tox-fromx)*f), fromy+((toy-fromy)*f)) );
	end
end

local function GenFadeFunc(froma, toa, t0, dt)
	return function(frame, t)
		local f = clamp((t-t0)/dt, 0, 1);
		frame:SetAlpha(froma+((toa-froma)*f));
	end
end

local function GenCountdownFunc(dt, endt, dtFlash, color1, color2)
	return function(frame, t)
		local q = endt - t;
		frame.timer:SetTime(q);
		if(q < 0) then return; end
		local f = 1-(q/dt);
		if frame.statusBar then
			frame.statusBar:SetValue(f);
			if(q < dtFlash) then
				tempcolor:blend(color1, color2, 0.5*(math.cos(q*5) + 1));
				frame.statusBar:SetStatusBarColor(VFL.explodeColor(tempcolor));
			else
				frame.statusBar:SetStatusBarColor(VFL.explodeColor(color1));
			end
		end
	end
end

------------------------------------------------
-- Alert management
------------------------------------------------
-- Complete alert table.
local alerts = {};
RDX.Alert = {};

--- Create a new alert.
function RDX.Alert:new()
	local self = VFLUI.AcquireFrame("Frame");
	self:SetParent(AlertParent); self:SetFrameStrata("FULLSCREEN_DIALOG");
	self:SetScale(1);
	self:Show();

	-- Animation and data processing.
	local animFunc, blendFunc, dataFunc = nil, nil;
	function self:SetAnimationFunction(f) animFunc = f; end
	function self:SetBlendFunction(f) blendFunc = f; end
	function self:GetBlendFunction() return blendFunc; end
	function self:SetDataFunction(f) dataFunc = f; end
	function self:Stop() animFunc = nil; end

	-- ZMA scheduling for this alert.
	local sched, sfunq, sched_active = {}, {}, true;
	function self:Schedule(dt, func)
		local tt, i = math.floor((GetTime() + dt) * 1000), 0;
		while sched[tt+i] do i=i+1; end
		sched[tt+i] = func;
		return tt+i;
	end

	-- Master update handler.
	self:SetScript("OnUpdate", function(frame)
		local t0, t, i = GetTime(), math.floor(GetTime() * 1000), 0;
		-- Run all animations
		if animFunc then animFunc(frame, t0); end 
		if dataFunc then dataFunc(frame, t0); end	
		if blendFunc then blendFunc(frame, t0); end
		-- Run scheduled stuff.
		for st,func in pairs(sched) do
			if(t > st) then	i=i+1; sfunq[i] = func;	sched[st] = nil; end
		end
		for j=1,i do
			if sched_active then sfunq[j](); end
			sfunq[j] = nil;
		end
	end);

	self.Destroy = VFL.hook(function(s)
		sched_active = nil;
		s:SetScript("OnUpdate", nil); sched = nil; s.Schedule = nil;
		RDX.Alert.RemoveFromStacks(s);
		animFunc = nil; s.SetAnimationFunction = nil;
		dataFunc = nil; s.SetDataFunction = nil;
		blendFunc = nil; s.SetBlendFunction = nil; s.GetBlendFunction = nil;
		s.Stop = nil;
		alerts[s] = nil;
	end, self.Destroy);

	alerts[self] = true;
	return self;
end

-- Quash all alerts matching the given pattern
function RDX.QuashAlertsByPattern(ptn)
	local cont = true;
	while cont do
		cont = false;
		for alert,_ in pairs(alerts) do
			if(alert.name) and (alert.name:match(ptn)) then
				alert:Destroy(); cont = true; break;
			end
		end
	end
end

---------------------------------------
-- The default alert style (RDX5-ish)
---------------------------------------
function RDX.Alert.DefaultStyle(alert, w, h, noTimer)
	w = w or 250; h = h or 20;
	alert:SetWidth(w); alert:SetHeight(h);

	---------------- Background: backdrop + a status bar
	local bkd = VFLUI.AcquireFrame("Frame");
	bkd:SetParent(alert); bkd:SetAllPoints(alert);
	bkd:SetBackdrop(VFLUI.WhiteBackdrop);
	bkd:SetBackdropColor(0.5,0.5,0.5,0.2);
	bkd:SetFrameLevel(1); bkd:Show();

	local sb = VFLUI.AcquireFrame("StatusBar");
	sb:SetParent(bkd); sb:SetFrameLevel(2);
	sb:SetPoint("TOPLEFT", bkd, "TOPLEFT");
	sb:SetWidth(w); sb:SetHeight(h);
	sb:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
	sb:SetMinMaxValues(0,1); sb:SetValue(0); sb:Show();
	alert.statusBar = sb;

	--------------- Foreground: timer + text
	local fgd = VFLUI.AcquireFrame("Frame");
	fgd:SetParent(alert); fgd:SetAllPoints(alert);
	fgd:SetFrameLevel(2); fgd:Show();

	--------------- Icons (fridgid)
	local _tl = VFLUI.CreateTexture(sb);
	_tl:SetDrawLayer("ARTWORK");
	_tl:SetPoint('RIGHT',sb,'LEFT',-1,0);
	_tl:SetWidth(20); _tl:SetHeight(20);
	_tl:Hide();
	_tl:SetTexture(1,1,1); _tl:SetBlendMode("BLEND"); _tl:SetVertexColor(1,1,1);
	alert._tl = _tl;
	local _tr = VFLUI.CreateTexture(sb);
	_tr:SetDrawLayer("ARTWORK");
	_tr:SetPoint('LEFT',sb,'RIGHT',1,0);
	_tr:SetWidth(20); _tr:SetHeight(20);
	_tr:Hide();
	_tr:SetTexture(1,1,1); _tr:SetBlendMode("BLEND"); _tr:SetVertexColor(1,1,1);
	alert._tr = _tr;
	
	if not noTimer then
		local timer = VFLUI.TimerWidget:new(fgd);
		timer:SetPoint("RIGHT", fgd, "RIGHT", 5, 0);
		timer:SetWidth(75); timer:SetHeight(18); timer:Show();
		alert.timer = timer;
		function alert:SortValue() return -1 * timer:GetTime(); end
	end

	local fstr = VFLUI.CreateFontString(fgd);
	fstr:SetHeight(h);
	if noTimer then fstr:SetWidth(w); else fstr:SetWidth(w-75); end
	fstr:SetPoint("LEFT", fgd, "LEFT", 0, 0);
	VFLUI.SetFont(fstr, Fonts.Default);
	fstr:SetJustifyH("LEFT");
	fstr:Show();

	function alert:SetText(x) fstr:SetText(x); end

	alert.Destroy = VFL.hook(function(s)
		s.statusBar:Destroy(); s.statusBar = nil;
		bkd:Destroy(); bkd = nil;
		s._tl:Destroy(); s._tl = nil;
		s._tr:Destroy(); s._tr = nil;
		if s.timer then s.timer:Destroy(); s.timer = nil; end
		VFLUI.ReleaseRegion(fstr); fstr = nil;
		fgd:Destroy(); fgd = nil;
		s.SetText = nil; s.SortValue = nil;
	end, alert.Destroy);
end

-------------------------------------
-- Animation aids
-------------------------------------
--- Move the alert linearly through (x,y,alpha,scale) space from its current point
-- to the given destination point over dt seconds.
function RDX.Alert.Move(alert, point, dt, x, y, a, s)
	if not alert.Stop then return; end
	local fx,fy = VFLUI.GetUniversalPoint(alert, "CENTER");
	if (not fx) then
		-- This frame just got reanchored. Do it next frame.
		VFLT.NextFrame(math.random(100000000), function()
			RDX.Alert.Move(alert, point, dt, x, y, a, s);
		end);
		return;
	end
	alert:SetAnimationFunction(GenMoveFunc(point, fx, fy, x, y, alert:GetAlpha(), a, alert:GetScale(), s, GetTime(), dt));
	alert:Schedule(dt, function() alert:Stop(); end);
end

--- Start a countdown timer on this alert. It will countdown from dt seconds, beginning
-- to flash at fdt seconds, and flashing between color1 and color2.
function RDX.Alert.Countdown(alert, dt, fdt, color1, color2)
	if not alert.timer then return; end
	if not fdt then fdt = dt; end
	if not color1 then color1 = _midgrey; end
	if not color2 then color2 = color1; end
	local endt = GetTime() + dt;
	alert.timer:SetTime(dt);
	alert:SetDataFunction(GenCountdownFunc(dt, endt, fdt, color1, color2));
	alert:Schedule(dt + .01, function() alert:SetDataFunction(nil); end);
end

--- Fade the alert over dt seconds from its current alpha level to
-- alpha level a1.
function RDX.Alert.Fade(alert, dt, a1)
	alert:SetBlendFunction(GenFadeFunc(alert:GetAlpha(), a1, GetTime(), dt));
	alert:Schedule(dt, function() alert:SetBlendFunction(nil); end);
end

-------------------------------------
-- Alert stacks
-------------------------------------
-- Stack properties: (center_x, center_y, direction, opp, alpha, scale)
local topstack_props = {512, 750, "TOP", "BOTTOM", .4, 1};
local bottomstack_props = {512, 450, "BOTTOM", "TOP", .9, 1};

local topstack = {};
local bottomstack = {};

local function stacksort(a1, a2)
	local v1,v2 = 1, 1;
	if a1.SortValue then v1 = a1:SortValue(); end
	if a2.SortValue then v2 = a2:SortValue(); end
	return v1<v2;
end

local function layout_stack(stack, props)
	local dir,opp,a,s = props[3],props[4],props[5],props[6];
	local af = nil;
	table.sort(stack, stacksort);
	for _,alert in ipairs(stack) do
		alert:Stop(); alert:ClearAllPoints();
		if not alert:GetBlendFunction() then alert:SetAlpha(a); end
		alert:SetScale(s);
		if af then
			alert:SetPoint(dir, af, opp);
		else
			alert:SetPoint("CENTER", UIParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(alert, props[1], props[2]));
		end
		af = alert;
	end
end

local function get_stack_bottom(stack, props)
	local bottomFrame = stack[#stack];
	if bottomFrame then
		local ux, uy = VFLUI.GetUniversalPoint(bottomFrame, props[4]);
		if not ux then return props[1], props[2], "CENTER"; else	return ux, uy, props[3]; end
	else
		return props[1], props[2], "CENTER";
	end
end

local function remove_from_stack(alert, stack)
	VFL.filterInPlace(stack, function(x) return x ~= alert; end);
end

function RDX.Alert.RemoveFromStacks(alert)
	remove_from_stack(alert, topstack);	remove_from_stack(alert, bottomstack);
	layout_stack(topstack, topstack_props);	layout_stack(bottomstack, bottomstack_props);
end

local function ToStack(alert, time, stack, props)
	RDX.Alert.RemoveFromStacks(alert);
	if not time then
		table.insert(stack, alert); layout_stack(stack, props);
	else
		local x,y,point = get_stack_bottom(stack, props);
		RDX.Alert.Move(alert, point, time, x, y, props[5], props[6]);
		alert:Schedule(time, function() ToStack(alert, nil, stack, props); end);
	end
end

function RDX.Alert.ToTop(alert, animTime)
	ToStack(alert, animTime, topstack, topstack_props);
end

function RDX.Alert.ToBottom(alert, animTime)
	ToStack(alert, animTime, bottomstack, bottomstack_props);
end

local function PaintIcons(alert, leftIcon, rightIcon)
	-- Show the icons
	local _tl = alert._tl;
	if leftIcon then
		_tl:Show();
		_tl:SetWidth(20);
		_tl:SetHeight(20);
		_tl:SetTexture(leftIcon)
		_tl:SetVertexColor(1,1,1);
	else
		_tl:Hide();
	end
	local _tr = alert._tr;
	if rightIcon then
		_tr:Show();
		_tr:SetWidth(20);
		_tr:SetHeight(20);
		_tr:SetTexture(rightIcon)
		_tr:SetVertexColor(1,1,1);
	else
		_tr:Hide();
	end
end

-------------------------------------------------
-- PREMADE ALERT FUNCTIONS
-------------------------------------------------
-- Dropdown alert. Starts at the top of the screen, moves to the middle when time grows
-- short.
function RDX.Alert.Dropdown(id, text, totalTime, leadTime, sound, c1, c2, suppressSpam, leftIcon, rightIcon)
	local ldt = totalTime - leadTime;
	local alert = RDX.Alert:new();
	RDX.Alert.DefaultStyle(alert);
	PaintIcons(alert, leftIcon, rightIcon);
	alert.name = id;
	alert:SetText(text); 
	RDX.Alert.Countdown(alert, totalTime, leadTime, c1, c2);
	RDX.Alert.ToTop(alert);
	alert:Schedule(totalTime-leadTime, function()
		RDX.Alert.ToBottom(alert, 0.5);
		if(sound) then RDX.Alert.Sound(sound); end
		if not suppressSpam then RDX.Alert.Spam(VFLI.i18n("*** ").. text.." - "..leadTime..VFLI.i18n(" SEC! ***")); end
	end);
	alert:Schedule(totalTime, function() RDX.Alert.Fade(alert, 3,0); end);
	alert:Schedule(totalTime+3, function() alert:Destroy(); end);
	return alert;
end

-- Center popup countdown alert
-- This alert plays a sound right away, then displays a countdown midscreen.
function RDX.Alert.CenterPopup(id, text, time, sound, flash, c1, c2, suppressSpam, leftIcon, rightIcon)
	local alert = RDX.Alert:new();
	RDX.Alert.DefaultStyle(alert);
	PaintIcons(alert, leftIcon, rightIcon);
	alert.name = id;
	alert:SetText(text);
	RDX.Alert.Countdown(alert, time, flash, c1, c2);
	RDX.Alert.ToBottom(alert); 
	if(sound) then RDX.Alert.Sound(sound); end
	if(not suppressSpam) then RDX.Alert.Spam(VFLI.i18n("*** ") .. text .. " - " .. time .. VFLI.i18n(" SEC! ***")); end
	alert:Schedule(time, function() RDX.Alert.Fade(alert, 3, 0); end);
	alert:Schedule(time+3, function() alert:Destroy(); end);
	return alert;
end

-- Center popup, simple text
function RDX.Alert.Simple(text, sound, persist, suppressSpam, leftIcon, rightIcon)
	if not persist then persist = 3; end
	local alert = RDX.Alert:new();
	RDX.Alert.DefaultStyle(alert, nil, nil, true);
	PaintIcons(alert, leftIcon, rightIcon);
	alert:SetText(text);
	RDX.Alert.ToBottom(alert);
	if(sound) then RDX.Alert.Sound(sound); end
	if not suppressSpam then RDX.Alert.Spam(VFLI.i18n("*** ") .. text .. VFLI.i18n(" ***")); end
	alert:Schedule(persist, function() RDX.Alert.Fade(alert,3,0); end);
	alert:Schedule(persist+3, function() alert:Destroy(); end);
	return alert;
end

--------------------------------------------------
-- ALERT PREFS
--------------------------------------------------
---------- Chatspam
function RDX.Alert.Spam(txt)
	if not RDXU.spam then return; end
	if GetNumRaidMembers() > 0 then
		local myunit = RDXDAL.GetMyUnit();
		if myunit:IsLeader() then
			SendChatMessage(txt, "RAID_WARNING");
		else
			SendChatMessage(txt, "RAID");
		end
	elseif GetNumPartyMembers() > 0 then
		SendChatMessage(txt, "PARTY");
	end
end
function RDX.Alert.RaidChat(txt)
	if not RDXU.spam then return; end
	if GetNumRaidMembers() > 0 then
		SendChatMessage(txt, "RAID");
	elseif GetNumPartyMembers() > 0 then
		SendChatMessage(txt, "PARTY");
	end
end

---------- Soundspam
function RDX.Alert.Sound(sound)
	if (not RDXU.nosound) and (type(sound) == "string") and (string.len(sound) > 0) then
		VFLIO.PlaySoundFile(sound);
	end
end

---------- Movable frames
local stackdxn_list = { "TOP", "BOTTOM", "LEFT", "RIGHT" };
local function CreateMoveFrame(name, props)
	local f = VFLUI.Button:new(AlertParent);
	f:SetHeight(24); f:SetWidth(250);
	f:SetScale(props[6]); f:SetAlpha(props[5]);
	f:SetPoint("CENTER", UIParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(f, props[1], props[2]));
	f:SetText(name .. VFLI.i18n(" Alert"));
	f:Show();
	f:SetMovable(true);
	f:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	f:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing(); end);

	local aslider = VFLUI.HScrollBar:new(AlertParent, true);
	aslider:SetWidth(80);	aslider:SetPoint("RIGHT", f, "CENTER", -25, -24); aslider:Show();
	aslider:SetScript("OnValueChanged", function(fr, value)
		f:SetAlpha(value);
	end);
	aslider:SetMinMaxValues(.25, 1);	aslider:SetValue(props[5]);

	local asfs = VFLUI.CreateFontString(aslider);
	asfs:SetAllPoints(aslider); asfs:Show();
	VFLUI.SetFont(asfs, Fonts.Default);
	asfs:SetTextColor(0,0.6,0.75); asfs:SetJustifyH("CENTER");
	asfs:SetText(VFLI.i18n("Alpha"));

	local sslider = VFLUI.HScrollBar:new(AlertParent, true);
	sslider:SetWidth(80);	sslider:SetPoint("LEFT", aslider, "RIGHT", 4, 0); sslider:Show();
	sslider:SetScript("OnValueChanged", function(fr, value)
		local x,y = VFLUI.GetUniversalPoint(f, "CENTER"); if not x then return; end
		f:SetScale(value);
		f:ClearAllPoints();
		f:SetPoint("CENTER", UIParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(f, x, y));
	end);
	sslider:SetMinMaxValues(.25, 1.75); sslider:SetValue(props[6]);

	local ssfs = VFLUI.CreateFontString(sslider);
	ssfs:SetAllPoints(sslider); ssfs:Show();
	VFLUI.SetFont(ssfs, Fonts.Default);	ssfs:SetTextColor(0.6,0.75,0); ssfs:SetJustifyH("CENTER");
	ssfs:SetText(VFLI.i18n("Scale"));

	local stackdxn = VFLUI.Button:new(AlertParent);
	stackdxn:SetHeight(24); stackdxn:SetWidth(53);
	stackdxn:SetPoint("LEFT", sslider, "RIGHT"); stackdxn:Show();
	stackdxn:SetText(props[3]);
	stackdxn:SetScript("OnClick", function(s)
		local i,t = nil, s:GetText();
		for j=1,#stackdxn_list do if stackdxn_list[j] == t then i=j+1; end end
		if not i then return; end	if i>4 then i=1; end
		s:SetText(stackdxn_list[i]);
	end);

	function f:GetPropsArray()
		local x,y = VFLUI.GetUniversalPoint(self, "CENTER");
		local point = stackdxn:GetText();
		return {x, y, point, VFLUI.GetOppositePoint(point), self:GetAlpha(), self:GetScale()};
	end

	f.Destroy = VFL.hook(function(s)
		s.GetPropsArray = nil;
		asfs:Destroy(); asfs = nil; aslider:Destroy(); aslider = nil;
		ssfs:Destroy(); ssfs = nil; sslider:Destroy(); sslider = nil;
		stackdxn:Destroy();
	end, f.Destroy);

	return f;
end

local taMove, baMove;

--local function isMoveAlerts()
--	return taMove;
--end
--RDXBM.isMoveAlerts = isMoveAlerts;

local function MoveAlerts()
	if taMove then return; end
	taMove = CreateMoveFrame("Top", topstack_props);
	baMove = CreateMoveFrame("Bottom", bottomstack_props);
end
local function StopMovingAlerts()
	if not taMove then return; end
	taMove:StopMovingOrSizing();
	VFL.copyOver(topstack_props, taMove:GetPropsArray());
	taMove:Destroy(); taMove = nil;

	baMove:StopMovingOrSizing();
	VFL.copyOver(bottomstack_props, baMove:GetPropsArray());
	baMove:Destroy(); baMove = nil;
end

--local function ToggleMoveAlerts()
--	if isMoveAlerts() then
--		StopMovingAlerts();
--	else
--		MoveAlerts();
--	end
--end

--RDXBM.MoveAlerts = MoveAlerts;
--RDXBM.StopMovingAlerts = StopMovingAlerts;

function RDXBM.GetStackProps()
	StopMovingAlerts();
	return VFL.copy(topstack_props), VFL.copy(bottomstack_props);
end

function RDXBM.SetUnlockAlerts()
	MoveAlerts();
end

function RDXBM.SetAlertsLocation(top, bottom)
	VFL.copyOver(topstack_props, top);
	VFL.copyOver(bottomstack_props, bottom);
end

--RDXBM.ToggleMoveAlerts = ToggleMoveAlerts;
------------ Announce toggle
-- Announce button
local anbtn = VFLUI.AcquireFrame("Button");
local antex = VFLUI.CreateTexture(anbtn);
antex:SetAllPoints(anbtn);
antex:Show();
anbtn:SetHighlightTexture(antex);
antex:SetBlendMode("DISABLE");
if RDX._skin == "boomy" then
	anbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\boomy\\music");
	antex:SetTexture("Interface\\Addons\\RDX\\Skin\\boomy\\music");
elseif RDX._skin == "kids" then
	anbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\kids\\kcm-sound");
	antex:SetTexture("Interface\\Addons\\RDX\\Skin\\kids\\kcm-sound");
else
	anbtn:SetNormalTexture("Interface\\Addons\\RDX\\Skin\\speaker");
	antex:SetTexture("Interface\\Addons\\RDX\\Skin\\speaker");
end
antex:SetVertexColor(0.88, 0.88, 0.4);

function RDX.AnnounceOn()
	RDXU.spam = true;
	anbtn:LockHighlight();
	--RDX.printI(VFLI.i18n("Announce ON"));
end
function RDX.AnnounceOff()
	RDXU.spam = nil;
	anbtn:UnlockHighlight();
	--RDX.printI(VFLI.i18n("Announce OFF"));
end
function RDX.AnnounceToggle()
	if RDXU.spam then RDX.AnnounceOff(); else RDX.AnnounceOn(); end
end

anbtn:SetScript("OnClick", RDX.AnnounceToggle);

-- Load prefs into locals
RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RDXU.alert_top_x = nil; RDXU.alert_top_y = nil; RDXU.alert_bottom_x = nil; RDXU.alert_bottom_y = nil;
	
	--deprecated manage by Obj_Desktop now
	--if RDXU.alert_top then topstack_props = RDXU.alert_top; else RDXU.alert_top = topstack_props; end
	--if RDXU.alert_bottom then bottomstack_props = RDXU.alert_bottom; else RDXU.alert_bottom = bottomstack_props; end

	if RDXU.spam then RDX.AnnounceOn() else RDX.AnnounceOff(); end
end);

-- Register the announce button.
--RDXEvents:Bind("INIT_PRELOAD", nil, function() RDX.AddToolbarButton(anbtn, true); end);

-- FOG system

local textop, texleft, texright, texbottom

local function createFog()
	textop = VFLUI.CreateTexture(AlertParent)
	textop:SetPoint("TOP", AlertParent, "TOP");
	textop:SetWidth(AlertParent:GetWidth());
	textop:SetHeight(30);
	textop:SetTexture(1,1,1,1);
	
	textop:Show();
	
	texleft = VFLUI.CreateTexture(AlertParent)
	texleft:SetPoint("LEFT", AlertParent, "LEFT");
	texleft:SetWidth(30);
	texleft:SetHeight(AlertParent:GetHeight());
	texleft:SetTexture(1,1,1,1);
	
	texleft:Show();
	
	texright = VFLUI.CreateTexture(AlertParent)
	texright:SetPoint("RIGHT", AlertParent, "RIGHT");
	texright:SetWidth(30);
	texright:SetHeight(AlertParent:GetHeight());
	texright:SetTexture(1,1,1,1);
	
	texright:Show();
	
	texbottom = VFLUI.CreateTexture(AlertParent)
	texbottom:SetPoint("BOTTOM", AlertParent, "BOTTOM");
	texbottom:SetWidth(AlertParent:GetWidth());
	texbottom:SetHeight(30);
	texbottom:SetTexture(1,1,1,1);
	
	texbottom:Show();

end

function RDX.SetFogColor(r,g,b,a)
	textop:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, r, g, b, a)
	texleft:SetGradientAlpha("HORIZONTAL", r, g, b, a, 0, 0, 0, 0)
	texright:SetGradientAlpha("HORIZONTAL", 0, 0, 0, 0, r, g, b, a)
	texbottom:SetGradientAlpha("VERTICAL", r, g, b, a, 0, 0, 0, 0)
end

RDXEvents:Bind("INIT_POST", nil, function()
	createFog();
	RDX.SetFogColor (0,0,0,0);
	
	local myunit = RDXDAL.GetMyUnit();
	
	local set1 = RDXDAL.FindSet({ file = "RDXDiskSystem:sets:set_debuff_magic", class = "file"});
	local set2 = RDXDAL.FindSet({ file = "RDXDiskSystem:sets:set_debuff_poison", class = "file"});
	local set3 = RDXDAL.FindSet({ file = "RDXDiskSystem:sets:set_debuff_disease", class = "file"});
	local set4 = RDXDAL.FindSet({ file = "RDXDiskSystem:sets:set_debuff_curse", class = "file"});
	
	local lowhealth = false;
	
	local function changeFog()
		if lowhealth then
			RDX.SetFogColor (1,0,0,1);
		elseif set1:IsMember(myunit) then
			RDX.SetFogColor (0,0,1,1);
		elseif set2:IsMember(myunit) then
			RDX.SetFogColor (0,1,0,1);
		elseif set3:IsMember(myunit) then
			RDX.SetFogColor (1,1,0,1);
		elseif set4:IsMember(myunit) then
			RDX.SetFogColor (0.5,0,1,1);
		else
			RDX.SetFogColor (0,0,0,0);
		end
	end
	
	set1:ConnectDelta("fog", changeFog);
	set2:ConnectDelta("fog", changeFog);
	set3:ConnectDelta("fog", changeFog);
	set4:ConnectDelta("fog", changeFog);
	
	local function checkHealth()
		if myunit:FracHealth() <= 0.15 and lowhealth == false then
			lowhealth = true
			changeFog()
		elseif myunit:FracHealth() > 0.15 and lowhealth == true then
			lowhealth = false
			changeFog()
		end
	end
	
	RDXEvents:Bind("UNIT_HEALTH", nil, function(unit)
		if unit:IsPlayer() then checkHealth(); end
	end, "fog2");
	
end);
