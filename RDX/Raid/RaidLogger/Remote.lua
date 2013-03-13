-- Remote.lua
-- RDX - Project Omniscience
-- (C)2006 Bill Johnson
--
-- Facilities for querying and creating tables on remote machines.
--/script PlaySoundFile("Sound\\Event Sounds\\Wisp\\WispYes1.wav");

----------------------------------------------
-- TABLE I/O
----------------------------------------------
----------- Parameters
local security_maxTables = 50;
local security_maxTableLength = 2500;

-- The remote session
local rmtSess = Omni.Session:new("Remote");

local function Omni_OpenRemoteTable(commInfo, name, source, format, timeOffset)
	-- Security check: don't allow "spamming" of table creation
	if table.getn(rmtSess:Tablespace()) > security_maxTables then return nil; end
	-- Verify this table doesn't already exist
	if rmtSess:FindTable(name) then return nil; end
	-- OK, create a new table with this name.
	local tbl = Omni.Table:new(name);
	tbl.source = source; tbl.format = format;
	tbl.timeOffset = timeOffset; tbl.displayTime = "RELATIVE";
	tbl.immutable = nil; tbl.open = true; tbl.data = {};
	-- Add it to the session
	rmtSess:AddTable(tbl);
end
RPC.Bind("Omni_OT", Omni_OpenRemoteTable);

local function Omni_WriteRemoteTable(commInfo, name, symtab, data)
	-- Sanity checks
	local tbl = rmtSess:FindTable(name); if not tbl then return; end
	if (type(data) ~= "table") then return; end
	-- Security check: prevent a remote from spamming a huge table that would fill up memory
	if (table.getn(data)) > security_maxTableLength then return; end
	-- Recover the data from the symtab
	tbl.data = Omni.DecompressData(symtab, data);
	if not tbl.data then return; end
	-- Convert things to numbers which should be numbers
	tbl:Cleanse(); tbl:SetOpen(nil);
	-- Notify of received info
	RDX.printI("|cFFAAFF00Omniscience:|r |cFFFFFFFFReceived new table <" .. name .. "> from " .. commInfo.sender);
	PlaySoundFile("Sound\\Event Sounds\\Wisp\\WispYes1.wav");
end
RPC.Bind("Omni_WFT", Omni_WriteRemoteTable);

function Omni.SendWholeTable(tbl, prefix, overrideName)
	if type(tbl) ~= "table" then return; end
	local tbln;
	if overrideName then
		tbln = overrideName;
	else
		local myunit = RDXDAL.GetMyUnit();
		tbln = (prefix or "") .. myunit.name .. " " .. date("%H:%M:%S", VFLT.GetServerTime());
	end
	local symtab, cdata = Omni.CompressData(tbl);
	RPC.Invoke("Omni_OT", tbln, tbl.source, tbl.format, tbl.timeOffset);
	RPC.Invoke("Omni_WFT", tbln, symtab, cdata);
end

--------------------------------------
-- PREDEFINED QUERIES
--------------------------------------
------------ "History" query: starting from now, retrieve information for the past N seconds.
local function Omni_HistoryQuery(commInfo, name, secs)
	-- If not from a leader, abort
	if not RPC.IsGroupLeader(commInfo) then return; end
	local myunit = RDXDAL.GetMyUnit();
	-- If this query isn't directed at me, abort.
	if string.lower(name) ~= myunit.name then return; end
	secs = tonumber(secs); if (not secs) then return; end
	secs = VFL.clamp(secs, 0, 3600);
	Omni.SendWholeTable(Omni.History(secs))
end
RPC.Bind("Omni_Q_Hist", Omni_HistoryQuery);

------------- "Server time" query: retrieve information surrounding a specific moment of server time.
local function Omni_TimeQuery(commInfo, name, serverTime, window)
	-- If not from a leader, abort
	if not RPC.IsGroupLeader(commInfo) then return; end
	local myunit = RDXDAL.GetMyUnit();
	-- If this query isn't directed at me, abort.
	if string.lower(name) ~= myunit.name then return; end
	serverTime, window = tonumber(serverTime), VFL.clamp(tonumber(window), 0, 3600);
	if (not serverTime) or (serverTime < 0) then return; end
	-- Generate the table.
	Omni.SendWholeTable(Omni.ExtractWindow(serverTime, window));
end
RPC.Bind("Omni_Q_Time", Omni_TimeQuery);

local function ExecTimeQuery(who, strTime, window)
	-- Convert from a string time to a numerical server time.
	local stime = VFLT.GetServerTime();
	local h,m,s = VFLT.ParseHMS(strTime);
	if h then
		-- Project us into the server's timeframe.
		local now = date("*t", stime);
		now.hour = h; now.min = m; now.sec = s;
		-- Unproject.
		now = time(now);
		-- If we went into the future, move us back 24h.
		if(now > stime) then now = now - 24*3600; end
		stime = now;
	else
		stime = tonumber(strTime);
	end
	if not stime then return; end
	-- Convert the window
	window = VFL.clamp(tonumber(window), 0, 3600);
	-- Invoke the query
	RPC.Invoke("Omni_Q_Time", string.lower(who), stime, window);
end

function Omni.TimeQueryDialog(who, when, window)
	-- If no time is provided populate with current time
	if not when then
		local now = date("*t", VFLT.GetServerTime());
		when = string.format("%02d:%02d:%02d", now.hour, now.min, now.sec);
	end
	if not window then window = 120; end

	local dlg = VFLUI.Window:new();
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetText("Time Query: " .. who);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetHeight(150); dlg:SetWidth(300);
	dlg:SetClampedToScreen(true);
	dlg:Show();
	local ca = dlg:GetClientArea();

	local esch = function() dlg:Destroy(); end
	VFL.AddEscapeHandler(esch);
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local ed_time = VFLUI.LabeledEdit:new(dlg, 75);
	ed_time:SetPoint("TOPLEFT", ca, "TOPLEFT"); ed_time:SetWidth(290); ed_time:Show();
	ed_time:SetText("Server time to investigate");
	ed_time.editBox:SetText(when);

	local ed_window = VFLUI.LabeledEdit:new(dlg, 75);
	ed_window:SetPoint("TOPLEFT", ed_time, "BOTTOMLEFT"); ed_window:SetWidth(290); ed_window:Show();
	ed_window:SetText("Window (in seconds) for investigation");
	ed_window.editBox:SetText(window);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText("OK"); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		ExecTimeQuery(who, ed_time.editBox:GetText(), ed_window.editBox:GetText());
		VFL.EscapeTo(esch);
	end);

	dlg.Destroy = VFL.hook(function(s)
		ed_time:Destroy(); ed_time = nil;
		ed_window:Destroy(); ed_window = nil;
		btnOK:Destroy(); btnOK = nil;
	end, dlg.Destroy);
end


-------------------------------------------------
-- QUERY DIALOG
-------------------------------------------------
local dlg = nil;
function Omni.PredefinedQuery(who)
	if dlg then return; end

	dlg = VFLUI.Window:new();
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetText("Omniscience Query: " .. who);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetHeight(200); dlg:SetWidth(200);
	dlg:SetClampedToScreen(true);
	dlg:Show();
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	local ca = dlg:GetClientArea();

	local esch = function() dlg:Destroy(); end
	VFL.AddEscapeHandler(esch);
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	
	local btnPast5 = VFLUI.Button:new(dlg);
	btnPast5:SetHeight(24); btnPast5:SetWidth(180);
	btnPast5:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, 0);
	btnPast5:SetText("Past 5 Minutes");
	btnPast5:SetScript("OnClick", function()
		RPC.Invoke("Omni_Q_Hist", string.lower(who), 180);
		VFL.EscapeTo(esch);
	end);
	btnPast5:Show();

	local btnTime = VFLUI.Button:new(dlg);
	btnTime:SetHeight(24); btnTime:SetWidth(180);
	btnTime:SetPoint("TOPLEFT", btnPast5, "BOTTOMLEFT", 0, 0);
	btnTime:SetText("Investigate Server Time...");
	btnTime:SetScript("OnClick", function()
		VFL.EscapeTo(esch);
		Omni.TimeQueryDialog(who);
	end);
	btnTime:Show();

	dlg.Destroy = VFL.hook(function(s)
		btnPast5:Destroy(); btnPast5 = nil;
		btnTime:Destroy(); btnTime = nil;
		dlg = nil;
	end, dlg.Destroy);
end

-- Slash command to execute a quick query.
SLASH_OMNI1 = "/omni";
SlashCmdList["OMNI"] = function()
	if UnitExists("target") and (UnitInParty("target") or UnitInRaid("target")) then
		Omni.PredefinedQuery(string.lower(UnitName("target")));
	else
		VFL.print("* Target is not in your raid or party; cannot query Omniscience data.");
	end
end

----------------------------------------
-- GLUE
-- Create a menu option on the character context menus.
----------------------------------------

-- Unit popup button to execute a quick query.
-- This is causing irrevocable taint and is now disabled.
--[[
UnitPopupButtons["RDX_OMNI"] = { text = "RDX: Omniscience", dist = 0 };
local function _fudgemenu(menu)
	if menu then table.insert(menu, "RDX_OMNI"); end
end
_fudgemenu(UnitPopupMenus["PLAYER"]);
_fudgemenu(UnitPopupMenus["RAID"]);
_fudgemenu(UnitPopupMenus["PARTY"]);

local function _menuhook(self)
	local dropdownFrame = _G[UIDROPDOWNMENU_INIT_MENU];
	local unit = dropdownFrame.unit;
	local name = dropdownFrame.name;

	if (self.value == "RDX_OMNI") then
		if UnitExists(unit) then name = UnitName(unit); end
		name = string.lower(name);
		Omni.PredefinedQuery(name);
	end
end

hooksecurefunc("UnitPopup_OnClick", _menuhook)
]]


---------------------------------------------
-- "PUSH" OPERATION
---------------------------------------------
Omni.RegisterTableMenuHandler(function(mnu, tbl, dialog)
	if (tbl ~= Omni.localLog) then
		table.insert(mnu, {text="Push", OnClick = function() 
			VFL.poptree:Release();
			-- First timeshift the table
			local r1 = tbl:GetRow(1);
			if r1 and r1.t then
				tbl:Timeshift(-r1.t);
			end
			Omni.SendWholeTable(tbl, nil, UnitName("player") .. ": " .. tbl.name);
		end});
	end
end);
