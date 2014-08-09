-- Poll.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Logistics functions for polling.

local strftime, char = VFLT.FormatSmartMinSec, string.char;

----------------------------------------------------------
-- Poll dispatch handler
----------------------------------------------------------
local polls = {};

local function PollWin_ApplyData(win, frame, icv, data)
	local nm = win._nameMap; if not nm then return; end
	local row = nm[data]; if not row then return; end
	if row.t0 then
		local remain = row.t1 - GetTime(); if remain < 0 then remain = 0; end
		local to = row.t1 - row.t0; if(to < 0.1) then to = 1; end
		local frac = 1 - VFL.clamp(remain/to, 0, 1);
		frame.bar:SetStatusBarColor(0.6,0.6,0);
		frame.bar:SetValue(frac); frame.text2:SetText(strftime(remain));
		frame.text1:SetText("Time left");
	elseif row.baseAnswer then
		frame.text1:SetText(row.baseAnswer);
		local n, tc = VFL.clamp(row.n, 0, 1000), VFL.clamp(win.totalCount, 1, 1000);
		local frac = n/tc;
		frame.bar:SetStatusBarColor(0,0.6,0.6);
		frame.bar:SetValue(frac);
		frame.text2:SetText(n .. " [" .. string.format("%0.0f%%", frac*100) .. "]");
	else
		frame.bar:SetValue(0);
		frame.text1:SetText(VFL.strtcolor(RDXMD.GetClassColor(row.class)) .. row.name .. "|r");
		frame.text2:SetText(row.answer);
	end
end

local function Poll_ResponseRcvd(ci, resp)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (not ci) or (not ci.sender) or (not ci.id) then return; end

	local win = polls[ci.id]; if not win then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	local nm = win._nameMap; if (not nm) or (not nm[ci.sender]) then return; end

	-- Update the response.
	nm[ci.sender].answer = resp;
	local respToken = "!" .. resp;
	if nm[respToken] then
		nm[respToken].n = nm[respToken].n + 1;
	end
	-- Repaint the window
	win:RepaintAll();
end

local function SendPoll(data)
	local timeout = data.timeout; if type(timeout) ~= "number" then error("Bad timeout"); end
	local ans = data.a; 
	if type(ans) ~= "table" then error("Bad answer table"); end

	local pw = Logistics.NewWindow(nil, data.title, true, 150, 70);
	pw:SetApplyData(PollWin_ApplyData);

	-- Name data map
	local nameMap, totalCount = {}, 0;
	for _,unit in RDXDAL.Group() do
		if unit:IsValid() then
			totalCount = totalCount + 1;
			nameMap[unit.name] = { 
				name = unit:GetProperName(); 
				class = unit:GetClassID();
				answer = "|cFF444444(no resp)|r";
			};
		end
	end
	-- Stupid sorting tricks. Insert the answer and timeout lines as "virtual" entries.
	nameMap["!!timeout"] = {
		name = char(4) .. char(4); class = -11; answer = char(3);
		t0 = GetTime(); t1 = GetTime() + timeout;
	};
	for an,ad in ipairs(ans) do if type(ad) == "string" then
		nameMap["!" .. ad] = {
			name = char(4) .. char(an + 60); class = -11 + an; answer = char(4) .. char(an+60);
			n = 0; baseAnswer = ad;
		};
	end end

	pw._nameMap = nameMap;
	pw.totalCount = totalCount;

	-- Paint entry map
	local paintMap = pw._dataList;
	VFL.empty(paintMap);
	for name,_ in pairs(nameMap) do	table.insert(paintMap, name);	end

	-- Window popup menu
	function pw:_WindowMenu(mnu)
		table.insert(mnu, {
			text = "Sort by Name", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "name"); end
		});
		table.insert(mnu, {
			text = "Sort by Class", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "class"); end
		});
		table.insert(mnu, {
			text = "Sort by Answer", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "answer"); end
		});
	end

	-- Destructor. On destroy, clear us from the polls table
	pw.Destroy = VFL.hook(function(s)
		s._WindowMenu = nil;
		s._nameMap = nil; s.totalCount = nil;
		polls[s._rpcid] = nil;
	end, pw.Destroy);

	-- Send out the RPC and bind us to the responses.
	local rpcid = RPC_Group:Invoke("logistics_poll", data);
	pw._rpcid = rpcid;
	polls[rpcid] = pw;
	RPC_Group:Wait(rpcid, Poll_ResponseRcvd, data.timeout + 5);

	Logistics.StdSort(pw, "name");
end

-----------------------------------------------------------------
-- Poll receipt handler
-----------------------------------------------------------------
local function OpenPoll(sender, data, onAnswer)
	-- Sanity check data
	if (not data) then return; end
	local title = data.title; if type(title) ~= "string" then return; end
	local question = data.q; if type(question) ~= "string" then return; end
	local answers = data.a; 
	if (type(answers) ~= "table" or table.getn(answers) < 1 or table.getn(answers) > 10) then return; end
	local timeout = data.timeout; if type(timeout) ~= "number" or timeout < 0.1 then return; end
	local t0, t1 = GetTime(), GetTime() + timeout;

	-- Create a window to display this poll
	local win = VFLUI.Window:new();
	win:SetFraming(VFLUI.Framing.Default, 22);
	win:SetText(VFLI.i18n("Question from") .. " " .. VFL.capitalize(sender));
	win:SetTitleColor(0,0,0.6);
	win:SetPoint("CENTER", RDXParent, "CENTER");
	win:Accomodate(300, 80 + table.getn(answers) * 25);
	win:Show();
	local ca = win:GetClientArea();

	local bar = VFLUI.AcquireFrame("StatusBar");
	bar:SetParent(ca);
	bar:SetWidth(300); bar:SetHeight(20);
	bar:SetPoint("TOPLEFT", ca, "TOPLEFT");
	bar:SetStatusBarTexture("Interface\\Addons\\RDX\\Skin\\bar1");
	bar:SetMinMaxValues(0,1); bar:SetStatusBarColor(0.6,0.6,0);
	bar:Show();

	local titleTxt = VFLUI.CreateFontString(bar);
	titleTxt:SetWidth(250); titleTxt:SetHeight(16);
	titleTxt:SetFontObject(VFLUI.GetFont(Fonts.Default, 16));
	titleTxt:SetJustifyH("LEFT"); titleTxt:SetJustifyV("CENTER");
	titleTxt:SetPoint("LEFT", bar, "LEFT", 4, 0); titleTxt:Show();
	titleTxt:SetText(title);

	local timeTxt = VFLUI.CreateFontString(bar);
	timeTxt:SetWidth(50); timeTxt:SetHeight(12);
	timeTxt:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	timeTxt:SetJustifyH("RIGHT"); timeTxt:SetJustifyV("CENTER");
	timeTxt:SetPoint("RIGHT", bar, "RIGHT", -4, 0); timeTxt:Show();

	local questionTxt = VFLUI.CreateFontString(ca);
	questionTxt:SetWidth(ca:GetWidth()); questionTxt:SetHeight(60);
	questionTxt:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	questionTxt:SetPoint("TOPLEFT", bar, "BOTTOMLEFT"); questionTxt:Show();
	questionTxt:SetJustifyH("CENTER"); questionTxt:SetJustifyV("CENTER");
	questionTxt:SetText(question);


	-- Build the answer buttons.
	local ansBtn, i, af = {}, 0, questionTxt;
	for anum,answer in ipairs(answers) do if type(answer) == "string" then
		i=i+1;
		ansBtn[i] = VFLUI.Button:new(ca);
		ansBtn[i]:SetWidth(300); ansBtn[i]:SetHeight(25);
		ansBtn[i]:SetPoint("TOPLEFT", af, "BOTTOMLEFT"); af = ansBtn[i];
		ansBtn[i]:SetText(answer);
		ansBtn[i]:Show();
		local cl_anum, cl_answer = anum, answer;
		ansBtn[i]:SetScript("OnClick", function() win:Destroy(); onAnswer(cl_anum, cl_answer); end);
	end end

	-- Schedule some updates for our timer
	win:SetScript("OnUpdate", function()
		local remain = t1 - GetTime(); if remain < 0 then remain = 0; end
		local frac = 1 - VFL.clamp(remain/timeout, 0, 1);
		bar:SetValue(frac); timeTxt:SetText(strftime(remain));
	end);

	-- At the timeout, schedule auto-destruction
	local schedTok = VFLT.ZMSchedule(timeout, function() win:Destroy(); onAnswer(nil, nil); end);

	win.Destroy = VFL.hook(function(s)
		if schedTok then VFLT.ZMUnschedule(schedTok); end
		VFLUI.ReleaseRegion(titleTxt); titleTxt = nil;
		VFLUI.ReleaseRegion(timeTxt); timeTxt = nil;
		VFLUI.ReleaseRegion(questionTxt); questionTxt = nil;
		bar:Destroy(); bar = nil;
		-- Destroy answer buttons
		for _,btn in ipairs(ansBtn) do btn:Destroy(); end
		ansBtn = nil;
	end, win.Destroy);
end

local function PollIncRPC(ci, data)
	-- Sanity check sender
	if (not ci) then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	-- Only leaders can send polls.
	if not sunit:IsLeader() then return; end
	OpenPoll(ci.sender, data, function(an, ansr)
		if type(ansr) == "string" then
			RPC_Group:SendResponse(id, ansr);
		else
			RPC_Group:SendResponse(id, "|cFFFFFF00Timeout|r");
		end
	end);
end

RPC_Group:Bind("logistics_poll", PollIncRPC);

----------------------------------------------
-- Custom Poll
----------------------------------------------
local dlg = nil;
local function CustomPollDlg()
	if dlg then return; end

	dlg = VFLUI.Window:new();
	dlg:SetFraming(VFLUI.Framing.Default, 22);
	dlg:SetText("Custom Poll");
	dlg:SetTitleColor(0,0,0.6);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:Accomodate(250, 270);
	dlg:SetClampedToScreen(true);
	dlg:Show();
	local ca = dlg:GetClientArea();

	local lbl = VFLUI.MakeLabel(nil, ca, "Poll title:");
	lbl:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, 0);

	local pollTitle = VFLUI.Edit:new(ca);
	pollTitle:SetHeight(25); pollTitle:SetWidth(250);
	pollTitle:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, 0);
	pollTitle:Show(); pollTitle:SetFocus();

	lbl = VFLUI.MakeLabel(nil, ca, "Poll question:");
	lbl:SetPoint("TOPLEFT", pollTitle, "BOTTOMLEFT", 0, 0);

	local pollQuestion = VFLUI.Edit:new(ca);
	pollQuestion:SetHeight(25); pollQuestion:SetWidth(250);
	pollQuestion:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, 0);
	pollQuestion:Show();

	lbl = VFLUI.MakeLabel(nil, ca, "Timeout (sec):");
	lbl:SetPoint("TOPLEFT", pollQuestion, "BOTTOMLEFT", 0, 0);

	local pollTimeout = VFLUI.Edit:new(ca);
	pollTimeout:SetHeight(25); pollTimeout:SetWidth(250);
	pollTimeout:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, 0);
	pollTimeout:SetText("15");
	pollTimeout:Show();

	lbl = VFLUI.MakeLabel(nil, ca, "Poll answers (one per line, limit 20 chars each)");
	lbl:SetPoint("TOPLEFT", pollTimeout, "BOTTOMLEFT", 0, 0);

	local pollAnswers = VFLUI.TextEditor:new(ca);
	pollAnswers:SetWidth(250); pollAnswers:SetHeight(90);
	pollAnswers:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, 0);
	pollAnswers:Show();

	local btnOK = VFLUI.OKButton:new(ca);
	btnOK:SetText("OK");
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnOK:Show();

	------------- Tab Order
	pollTitle:SetScript("OnEnterPressed", function() pollQuestion:SetFocus(); end);
	pollQuestion:SetScript("OnEnterPressed", function() pollTimeout:SetFocus(); end);
	pollTimeout:SetScript("OnEnterPressed", function() pollAnswers:GetEditWidget():SetFocus(); end);

	------------- Escapement
	local esch = function() dlg:Destroy(); dlg = nil; end
	VFL.AddEscapeHandler(esch);
	local closebtn = VFLUI.CloseButton:new();
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	local function OnOK()
		local title = pollTitle:GetText();
		if string.len(title) < 1 then VFL.TripError("RDX", "Invalid poll title."); return; end
		local question = pollQuestion:GetText();
		if string.len(question) < 1 then VFL.TripError("RDX", "Invalid poll question."); return; end
		local timeout = VFL.clamp(pollTimeout:GetNumber(), 5, 120);
		local answers = {};
		local line,rest = VFL.line(pollAnswers:GetText());
		while line do
			line = string.sub(line,1,20);
			if string.len(line) > 0 then table.insert(answers, line); end
			line,rest = VFL.line(rest);
		end
		if (table.getn(answers) < 1) or (table.getn(answers) > 10) then VFL.TripError("RDX", "Invalid poll answers."); return; end
		SendPoll({ title = title; timeout = timeout; q = question; a = answers;	});
		VFL.EscapeTo(esch);
	end

	btnOK:SetScript("OnClick", OnOK);

	dlg.Destroy = VFL.hook(function(s)
		pollTitle:Destroy(); pollTitle = nil;
		pollQuestion:Destroy(); pollQuestion = nil;
		pollTimeout:Destroy(); pollTimeout = nil;
		pollAnswers:Destroy(); pollAnswers = nil;
		btnOK:Destroy(); btnOK = nil;
	end, dlg.Destroy);
end

Logistics.CustomPollDlg = CustomPollDlg;

----------------------------------------------
-- Standard ready check
----------------------------------------------
local readyCheck = {
	title = VFLI.i18n("Ready Check");
	timeout = 15;
	q = VFLI.i18n("Are you ready?");
	a = {"|cFF00FF00" .. VFLI.i18n("Ready") .. "|r",	"|cFFFF0000" .. VFLI.i18n("Not Ready") .. "|r"};
};

function Logistics.ReadyCheck()
	SendPoll(readyCheck);
	LogisticsEvents:Dispatch("READY_CHECK_SENT");
end

--Logistics.menu:RegisterMenuEntry(VFLI.i18n("Ready Check"), nil, function(tree) ReadyCheck(); tree:Release(); end);
--Logistics.menu:RegisterMenuEntry("Poll...", nil, function(tree) CustomPollDlg(); tree:Release(); end);

