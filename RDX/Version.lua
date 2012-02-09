-- Version.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Raidwide version check.

-- alpha, beta, RC (Release candidate) or nothing (General Availability)
local version_flag = "_alpha";

function RDX.GetVersion()
	if not RDX.version[4] then RDX.version[4] = 0; end
	return RDX.version[1] .. "." .. RDX.version[2] .. "." .. RDX.version[3] .. "." .. RDX.version[4] .. version_flag;
end

function RDX.SetPatchVersion(id)
	RDX.version[4] = id;
end

function RDX.GetPatchVersion()
	return RDX.version[4];
end

----------------------------------------------
-- RESPONDER
----------------------------------------------
local function VersionIncRPC(ci)
	-- Sanity check sender
	if (not ci) then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	return RDX.GetVersion();
end

RPC_Group:Bind("rdx_version_check", VersionIncRPC);

----------------------------------------------
-- DISPLAY
----------------------------------------------
local vchecks = {};

local function Version_ResponseRcvd(ci, version)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (type(version) ~= "string") or (not ci) or (not ci.sender) or (not ci.id) then return; end

	local win = vchecks[ci.id]; if not win then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	local nm = win._nameMap; if (not nm) then return; end
	local qq = nm[ci.sender]; if not qq then return; end

	-- Update the response.
	qq.version = version; qq.resp = true;

	win:RepaintAll();
end

local function Version_ApplyData(win, frame, icv, data)
	local nm = win._nameMap; if not nm then return; end
	local row = nm[data]; if not row then return; end
	frame.bar:SetValue(0);
	frame.text1:SetText(VFL.strtcolor(RDXMD.GetClassColor(row.class)) .. row.name .. "|r");
	if (not row.resp) then -- no resp
		frame.text2:SetText(VFLI.i18n("|cFF444444(No resp)|r"));
		return; 
	end
	frame.text2:SetText(VFL.strcolor(1,1,0)..row.version);
end

function RDX.VersionCheck_Start()
	local pw = RDX.CreateLogisticsWindow(nil, VFLI.i18n("Version Check"), nil, 110, 50);
	pw:SetApplyData(Version_ApplyData);
	pw:SetupNameMap(function(x,t) t.version = ""; t.resp = nil; end);

	-- Window popup menu
	function pw:_WindowMenu(mnu)
		table.insert(mnu, {
			text = VFLI.i18n("Sort by Name"), OnClick = function() VFL.poptree:Release(); pw:Sort("name"); end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Sort by Class"), OnClick = function() VFL.poptree:Release(); pw:Sort("class"); end
		});
	end

	-- Destructor. On destroy, clear us from the checks table
	pw.Destroy = VFL.hook(function(s)
		vchecks[s._rpcid] = nil;
	end, pw.Destroy);

	-- Send out the RPC and bind us to the responses.
	local rpcid = RPC_Group:Invoke("rdx_version_check");
	pw._rpcid = rpcid;
	vchecks[rpcid] = pw;
	RPC_Group:Wait(rpcid, Version_ResponseRcvd, 10);

	pw:Sort("name");
end

--------------------------------------------
-- moteur de mise à jour patch
-- request addon + patch version from all
-- if patch is superior.
-- Request download
--------------------------------------------

local function PatchListener(ci, who)
	-- Sanity check sender
	if (not ci) or (type(who) ~= "string") then return; end
	-- get latest patch.
	local tbl = RDXDB.GetObjectData("default:RDX" .. RDX.version[1] .. RDX.version[2] .. RDX.version[3]);
	return tbl;
end
--RPC_Guild:Bind("request_patch", PatchListener);

local function PatchResponse(ci, resp)
	RDX.printI("PATCH downloaded");
	RDX.printI("Installing PATCH");
	local tbl = RDXDB.TouchObject("default:RDX" .. RDX.version[1] .. RDX.version[2] .. RDX.version[3]);
	RDX.printI("PATCH installed");
	RDX.printI("Request reloadui");
end

local function PatchRequest(who)
	if type(who) ~= "string" then return; end
	who = string.lower(who);
	-- RDX.printI("Request Download PATCH");
	local rpcid = RPC_Guild:Invoke("request_patch", who);
	RPC_Guild:Wait(rpcid, PatchResponse, 20);
end

local function RpcVersionPatch(ci, version)
	--VFL.print(ci.sender);
	-- check if current version is the same
	local sup, flag = nil, nil;
	if version[1] == RDX.version[1] then
		if version[2] == RDX.version[2] then
			if version[3] == RDX.version[3] then
				if version[4] > RDX.version[4] then
					-- NEW PATCH
					PatchRequest(ci.sender)
				end
			elseif version[3] > RDX.version[3] then
				sup = true;
			end
		elseif version[2] > RDX.version[2] then
			sup = true;
		end
	elseif version[1] > RDX.version[1] then
		sup = true;
	end
	if sup and not flag then
		RDX.printI("Please download and install new version RDX " .. version[1] .. "." .. version[2] .. "." .. version[3]);
		flag = true;
	end
	
end
--RPC_Guild:Bind("version_patch", RpcVersionPatch);

-- Send the current version to everyone, every 5 minutes.
local function SendVersionPatch()
	if not InCombatLockdown() then
		RPC_Guild:Flash("version_patch", RDX.version);
	end
end

-- disable
--RDXEvents:Bind("INIT_DEFERRED", nil, function()
	--SendVersionPatch();
	-- Start periodic broadcasts
	--VFLT.AdaptiveSchedule(nil, 300, SendVersionPatch);
--end);

------------------------------------------
-- INIT
------------------------------------------

RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	RDX.printI("Version " .. RDX.GetVersion());
	RDX.printI("http://www.wowrdx.com");
	local languageVersion, locale = VFL.GetLanguagePackVersion();
	if languageVersion then
		RDX.printI("Language Pack " .. locale .." Version " .. languageVersion[1] .. "." .. languageVersion[2] .. "." .. languageVersion[3]);
	end
end);

