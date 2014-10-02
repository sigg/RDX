-- RaidInvites.lua
-- Frome the old file RDX6 Raid Invite Module
-- (C)2006 Dayne <Paradosi> / (Kargath/US)

-- Presets of saved Variables
RDXRI_OPTIONS={};

--[[
weekday, month, day, year = CalendarGetDate();

local month, day = 0, 10;
local numEvents = CalendarGetNumDayEvents(month, day);
VFL.print(numEvents);
if numEvents > 0 then
local title, hour, minute, calendarType, sequenceType, eventType, texture, modStatus, inviteStatus = CalendarGetDayEvent(month, day, 1)
VFL.print(title);
VFL.print(eventType);
CalendarOpenEvent(month, day, 1);
for i =1 , CalendarEventGetNumInvites() do
	
end
end

]]

-------------------------------------------------------------------------------
-- Function minlevel
-------------------------------------------------------------------------------

-- Text popup box for setting minimum level for raid invite
function Logistics.SetMinLevel()
	local function OkPressed(editText)
		RDXG.MINLEVEL = tonumber(editText);
		RDX.printI("Minimum level for raid invite set to " .. RDXG.MINLEVEL);
	end;
	VFLUI.MessageBox("Set Minimum Level","Please enter the minimum level a player must be to receive a raid invite. Numbers only.","","Cancel",nil,"Ok",OkPressed);
end;

------------------------------------------------------------------------
-- Mass Invite DISABLE see calendar function
------------------------------------------------------------------------

-- Mass Invite Function

-- Three situations for creating a raid
-- #1 - Player is solo, nobody in party
-- #2 - Player is in a group and is the leader
-- #3 - Player is in a raid and is the leader


function RDXI_Invite()
	GuildRoster();
	-- First lets check to make sure you're in a guild
	if (not GetGuildInfo("player")) then
		VFL.print("[RDX] You must be in a guild to mass invite");
		return;
	end;

	-- next, let's see if you're in a group/raid, but aren't promoted
	if (GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0) then
		if (not IsRaidLeader() and not IsRaidOfficer() and not IsPartyLeader()) then
			VFL.print("[RDX] You must be promoted or the party/raid leader to mass invite");	
			return;
		end;
	end;

	-- Alright, assuming both those are good, if you're in a raid and a leader/promoted, go ahead and invite the guild
	if (GetNumRaidMembers() > 0) and (IsRaidLeader() or IsRaidOfficer()) then
		SendChatMessage("[RDX] Raid Invites in 10 Seconds","GUILD");
		RDX.Alert.CenterPopup("ri", "Raid invites in ", 10, nil, nil, nil, nil, true);
		VFLT.ZMSchedule(10, function() RDXI_BeginInvites(); end);
		return;
	end;
	-- Alright, now, let's check if you're not in a raid, but are in a group and are the leader
	if (GetNumRaidMembers() == 0) and (GetNumPartyMembers() > 0) and IsPartyLeader() then
		ConvertToRaid();
		SendChatMessage("[RDX] Raid Invites in 10 Seconds","GUILD");
		RDX.Alert.CenterPopup("ri", "Raid invites in ", 10, nil, nil, nil, nil, true);
		VFLT.ZMSchedule(10, function() RDXI_BeginInvites(); end);
		return;		
	end;
	-- And finally, if you're not grouped or in a raid, create a raid and the trigger mass invites
	if (GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0) then
		VFLT.ZMSchedule(5, function() RDXI_CreateSoloRaid(); end);
		return;
	end;	
end;

-- Invite the first 4 people in the loop, and schedule a raid conversion for 2 seconds later

function RDXI_CreateSoloRaid()
	local i;
	local x;
	GuildRoster();
	SetGuildRosterShowOffline(false);
	SetGuildRosterSelection(0);
	GetGuildRosterInfo(0);
	local numGuildMembers = GetNumGuildMembers();
	local playerName = UnitName("player");
	for i = 1, 4, 1 do 
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
		if (level >= RDXRI_OPTIONS.MINLEVEL and name ~= playerName and online) then
			InviteUnit(name);
		end;
	end;
	VFLT.ZMSchedule(2, function() ConvertToRaid(); end);
	VFLT.ZMSchedule(5, function() RDXI_VerifyRaid(); end);
end;

-- Verify the creation of a raid and begin mass invites, otherwise schedule another raid conversion and check

function RDXI_VerifyRaid()
	if GetNumRaidMembers() > 0 then
		VFLT.ZMSchedule(10, function() RDXI_BeginInvites(); end);
		SendChatMessage("[RDX] Raid Invites in 10 Seconds","GUILD");
		RDX.Alert.CenterPopup("ri", "Raid invites in ", 10, nil, nil, nil, nil, true);
	else
		VFLT.ZMSchedule(2, function() ConvertToRaid(); end);
		VFLT.ZMSchedule(5, function() RDXI_VerifyRaid(); end);
	end;	

end;

-- Main Mass Invite loop

function Logistics.BeginInvites()
	local i;
	local x;
	GuildRoster();
	SetGuildRosterShowOffline(false);
	SetGuildRosterSelection(0);
	GetGuildRosterInfo(0);
	local numGuildMembers = GetNumGuildMembers();
	local playerName = UnitName("player");
	for i = 1, numGuildMembers, 1 do 
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
		if (level >= RDXRI_OPTIONS.MINLEVEL and name ~= playerName and online) then
			local match = false;
			for x = 1, GetNumRaidMembers(), 1 do
				local rname = GetRaidRosterInfo(x);
				if name == rname then 
					match = true;
				end;
			end;
			if not match and online then
				InviteUnit(name);
			end;			
		end;
	end;
end;

------------------------------------------------------------------------
-- Invite Request through Guild comm channel
------------------------------------------------------------------------

function Logistics.RequestInvite()
	SendAddonMessage("RDXRI", UnitName("player"), "GUILD");
end;
-- Process Invite request message via guild comm channel

local function ProcessRequest(arg1)
	if arg1 == "RDXRI" then
		if IsRaidLeader() or IsRaidOfficer() then
			InviteUnit(arg4);
		end;
	end;
end;

WoWEvents:Bind("CHAT_MSG_ADDON", nil, ProcessRequest, "rdxi_procreq");

------------------------------------------------------------------------
-- Raid Disband
------------------------------------------------------------------------

function Logistics.Disband()
	if GetNumRaidMembers() > 0 then
		if IsRaidLeader() then
			SendChatMessage("[RDX] Disbanding Raid","RAID");
			local numRaidMembers = GetNumRaidMembers();
			local playerName = UnitName("player");
			for i =	1, numRaidMembers, 1 do
				local name = GetRaidRosterInfo(i);
				if name ~= playerName then
					UninviteUnit(name);
				end;
			end;
		else
			RDX.printI("You Must Be The Raid Leader To Disband");
		end;
	else 
		RDX.printI("You Are Not In A Raid");
	end;
end;

------------------------------------------------------------------------
-- Keyword Invite whisp
------------------------------------------------------------------------

-- Keyword Invite Function

local function KeywordInvite(arg1)
	if (arg1 == RDXG.KEYWORD) then
		InviteUnit(arg2);
	end;
end;

-- Disable/Enable keyword invites

local function EnableKeyword()
	WoWEvents:Unbind("rdxi_keyword");
	WoWEvents:Bind("CHAT_MSG_WHISPER", nil, KeywordInvite, "rdxi_keyword");
	RDXG.AUTOINVITE = true;
end

local function DisableKeyword()
	WoWEvents:Unbind("rdxi_keyword");
	RDXG.AUTOINVITE = false;
end

function Logistics.ToggleKeyword()
	if RDXG.AUTOINVITE then
		RDX.printI("Disabling Keyword Invites");
		DisableKeyword();
	else
		RDX.printI("Enabling Keyword Invites");
		EnableKeyword();
	end;
end;

function Logistics.IsKeywordEnable()
	return RDXG.AUTOINVITE;
end

-- init
RDXEvents:Bind("INIT_DEFFERED", nil, function()
	if Logistics.IsKeywordEnable() then
		EnableKeyword();
	end;
end);

-- Text popup box for setting auto-invite keyword
function Logistics.SetKeyword()
	local function OkPressed(editText)
		RDXG.KEYWORD = editText;
		RDX.printI("Setting invite keyword to " .. RDXG.KEYWORD);
	end;
	VFLUI.MessageBox("Set Keyword","Enter Keyword for Auto-Invite","","Ok",OkPressed);
end;

------------------------------------------------------------------------
-- Remote logout
------------------------------------------------------------------------

function Logistics.RemoteLog(afkplayer)
	if IsRaidLeader() or IsRaidOfficer() then
		RPC_Group:Flash("raidinvite_remotelog", afkplayer);
	end;
end;

local function RPCRemoteLog(commInfo, name)
	local unit = RPC.GetSenderUnit(commInfo);
	if not unit or not unit:IsLeader() then return; end
	if name == UnitName("player") then
		Logout();
	end;
end

RPC_Group:Bind("raidinvite_remotelog", RPCRemoteLog);

-- Text popup box for passing name for logging out afkplayer
function Logistics.BootAfk()
	local function OkPressed(editText)
		Logistics.RemoteLog(editText);
		RDX.printI("Sending logout command to " .. editText);
	end;
	VFLUI.MessageBox("Remote Logout","Enter the Name of the Character to Logout","","Ok",OkPressed);
end;

------------------------------------------------------------------------
-- Promote
------------------------------------------------------------------------

-- Scan through the nominative set for auto-promotion. If the person is on the list and not
-- already promoted, promote them. 
local function ScanPromote()
	local promote_set = RDXDB.GetObjectData("RDXDiskSystem:default:promotes");
	if promote_set then
		local numRaidMembers = GetNumRaidMembers();
		for x = 1, numRaidMembers, 1 do
			local pname, prank = GetRaidRosterInfo(x);
			pname = string.lower(pname);
			for k, v in pairs(promote_set.data) do
				if v == pname then
					if prank > 0 then
						VFL.noop();
					else
						PromoteToAssistant(pname);
					end;
				end;
			end;
		end;
	end
end;

-- Schedule a scan for auto-promote list with lockout to keep from getting into an endless
-- loop due to constant RAID_ROSTER_UPDATES firing from constantly promoting the people on
-- your list. Only fires if you are the Raid Leader

local PromoteScanLockout = false;

function Logistics.ScheduleScanPromote()
	if IsRaidLeader() then
		if not PromoteScanLockout then
			PromoteScanLockout = true;
			VFLT.ZMSchedule(2, function() ScanPromote(); end);
			VFLT.ZMSchedule(5, function() PromoteScanLockout = false; end);
		end;
	end;
end;

-- Bind RAID_ROSTER_UPDATE event to schedule a check of the raid list to see if folks need
-- to be promoted

WoWEvents:Bind("RAID_ROSTER_UPDATE", nil, Logistics.ScheduleScanPromote, "rdxi_promotes");	

-- Add name of person to automatically promote, will make sure the name isn't already on the list.

function Logistics.AddPromote(name)
	if (not name) and (UnitInRaid("target") or UnitInParty("target")) then
		name = UnitName("target");
	end
	local match = false;
	name = string.lower(name);
	if name then
		local win_set = RDXDB.GetObjectInstance("RDXDiskSystem:default:promotes");
		win_set:AddName(name);
		local promote_set = RDXDB.GetObjectData("RDXDiskSystem:default:promotes");
		for k, v in pairs(promote_set.data, k) do
			if v == name then
				match = true;
			end;
		end;
		if not match then
			table.insert(promote_set.data, name);
			RDX.printI("Adding " .. name .. " to Auto-Promote");
		else
			RDX.printW("Already present in Auto-Promote list");
		end;
	else
		RDX.printW("Target someone!");
	end
end;

-- Remove name from Autopromote list

function Logistics.DropPromote(name)
	if (not name) then name = UnitName("target"); end
	name = string.lower(name);
	if name then
		local win_set = RDXDB.GetObjectInstance("RDXDiskSystem:default:promotes");
		win_set:RemoveName(name);
		local promote_set = RDXDB.GetObjectData("RDXDiskSystem:default:promotes");
		for k, v in pairs(promote_set.data) do
			if v == name then table.remove(promote_set.data, k); end
		end
		RDX.printI("Removing "..name.." from Auto-Promote");
	else
		RDX.printW("Target someone!");
	end
end

--RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
--	if IsRaidLeader() or IsRaidOfficer() then
--		hooksecurefunc("UnitPopup_ShowMenu", _promote_UnitPopup_ShowMenu);
--	end;
--end);

------------------------------------------------------------------------
-- Command Handler
------------------------------------------------------------------------

-- Help Function

local function Help()
	VFL.print("Usage: ");
	VFL.print("        /rdxi inv   - mass raid invite");
	VFL.print("       /rdxi disband   - disband raid");
end;

SLASH_RDX6_RI1 = "/rdxi";
SlashCmdList["RDX6_RI"] = function(cmd)
	if (cmd == "inv") then
		Logistics.Invite();
	elseif (cmd == "disband") then
		Logistics.Disband();
	else
		Help();
	end;
end;

-------------------------------------------------------------------------
-- Create the package and nominative set for the Auto-Promote function 
-- if it doesn't exist
-------------------------------------------------------------------------

RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	local dd;
	if not RDXDB.CheckObject("RDXDiskSystem:default:promotes", "NominativeSet") then
		dd = RDXDB._DirectCreateObject("RDXDiskSystem", "default", "promotes");
		dd.ty = "NominativeSet"; dd.version = 1;
	end
end);
