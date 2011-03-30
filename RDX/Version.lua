-- Version.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Raidwide version check.

-- alpha, beta, RC (Release candidate) or nothing (General Availability)
local version_flag = "_beta";

function RDX.GetVersion()
	return RDX.version[1] .. "." .. RDX.version[2] .. "." .. RDX.version[3] .. version_flag;
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

------------------------------------------
-- INIT
------------------------------------------

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	RDX.printI("Version " .. RDX.version[1] .. "." .. RDX.version[2] .. "." .. RDX.version[3] .. version_flag);
	--RDX.printI("http://www.wowrdx.com");
	local languageVersion, locale = VFL.GetLanguagePackVersion();
	if languageVersion then
		RDX.printI("Language Pack " .. locale .." Version " .. languageVersion[1] .. "." .. languageVersion[2] .. "." .. languageVersion[3]);
	end
end);

