-- StreamingRPC.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--

--- A small function that unpacks marshalled function arguments from
-- a table.
local function UnpackArgs(ty, d)
	if(ty == "VECTOR") then	
		return unpack(d); 
	end
end

-- reusable commInfo structire
local commInfo = {};

--- Given an underlying chat channel, add streaming RPC to that channel.
function RPC.StreamingRPCMixin(ch, noglobal)
	-- If there's already an RPC mixin here, ignore
	if ch.Bind then return; end
	
	-- Local data structures
	local waits, wtos, binds, outStids = {}, {}, {}, {};
	if not noglobal then setmetatable(binds, RPC._globalBinds); end

	local function RequestCompletion(strm, dataType, data)
		-- Ignore invalid inputs
		if (dataType ~= "VECTOR") and (dataType ~= "BOOLEAN") then return; end
		-- Pull our binding data
		local q = strm._rpcid; if not q then return; end
		q = binds[q]; if not q then return; end
		-- Build commInfo and execute
		commInfo.conference = strm.channel; commInfo.sender = strm.sender; commInfo.id = strm.streamID;
		local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10 = q(commInfo, UnpackArgs(dataType, data));
		-- If we're supposed to return a value, do so.
		if r1 then
			RPC:Debug(7, "-> QRY: RSP on ID ", RPC.GetReadableBytes(strm.streamID));
			local os = RPC.GetOutputStream();
			os:Open(strm.channel);
			os:AppendObject("R" .. strm.streamID);
			os:AppendVector(r1, r2, r3, r4, r5, r6, r7, r8, r9, r10);
			os:Send();
		end
		RPC:Debug(7, "-> QRY: completed");
	end
	
	local function ResponseCompletion(strm, dataType, data)
		-- Ignore invalid inputs
		if (dataType ~= "VECTOR") and (dataType ~= "BOOLEAN") then return; end
		-- Pull our wait data
		local w = strm._rpcid; if not w then return; end
		RPC:Debug(7, "-> RSP: completed");
		w = waits[w]; if not w then return; end
		-- Make a commInfo structure...
		commInfo.conference = strm.channel; commInfo.sender = strm.sender; commInfo.id = strm._rpcid;
		w(commInfo, UnpackArgs(dataType, data));
	end

	local function GotRequestHeader(strm, rest)
		RPC:Debug(7, "QRY: header on stream ", RPC.GetReadableBytes(strm.streamID), " from ", strm.sender, " data [", tostring(rest), "]");
		-- See if we have bindings for this event, if not, peaceout.
		if not binds[rest] then
			RPC:Debug(7, "-> QRY: invalid bind ", rest, ", aborting.");
			strm:Close(); return; 
		end
		strm._rpcid = rest;
		-- Switch to request handling mode
		strm:SetHandler(RequestCompletion);
	end
	local function GotResponseHeader(strm, rest)
		RPC:Debug(7, "RSP: header on stream ", RPC.GetReadableBytes(strm.streamID),  " from ", strm.sender, " data [", RPC.GetReadableBytes(rest), "]");
		-- If we weren't waiting for this RPC, peaceout.
		if not waits[rest] then 
			RPC:Debug(3, "Received response for invalid wait ", RPC.GetReadableBytes(rest));
			strm:Close(); return; 
		end
		strm._rpcid = rest;
		-- Get timeout data for this wait
		if wtos[rest] then
			-- Update the timeout for this wait to account for the length of this response and its estimated
			-- completion time.
			wtos[rest] = math.max(wtos[rest], GetTime() + (math.ceil(strm.length / 227) * 0.5) + 5);
		end
		-- Switch the stream's handler function to the response completion function
		strm:SetHandler(ResponseCompletion);
	end

	-- When the header of a new stream comes in...
	RPCEvents:Bind("STREAM_IN_HEADER", nil, function(strm, ht, hc)
		-- Sanity checks
		if(ht ~= "STRING") or (strm.channel ~= ch) then return; end
		local rtng, rest = string.sub(hc, 1, 1), string.sub(hc, 2, -1);
		if(rtng == "Q") then -- request
			GotRequestHeader(strm, rest);
		elseif(rtng == "R") then -- response
			GotResponseHeader(strm, rest);
		else
			-- Invalid content type.
			RPC:Debug(9, "!!! Invalid header routing: ", string.byte(rtng), " (", rtng, ")");
			strm:Close();
		end
	end, ch);

	-- When an input stream is closed, remove any wait value we might have saved there.
	RPCEvents:Bind("STREAM_IN_CLOSED", nil, function(strm) strm._rpcid = nil; end);
	
	-- Bind our channel to the stream handler.
	ch.sig:Connect(nil, RPC.StdStreamIn);
	
	-- clean timeout will start at the first wait call.
	local function CleanTimeOut()
		local t = GetTime();
		local found = nil;
		for wid,wto in pairs(wtos) do
			found = true;
			if wto < t then
				waits[wid] = nil; wtos[wid] = nil;
			end
		end
		if not found then
			VFLT.AdaptiveUnschedule("CleanTimeOut " .. ch.name);
		end
	end

	------------------------------------- END USER API
	function ch:Bind(routine, fn)
		if (not routine) or (binds[routine]) then return nil; end
		binds[routine] = fn; return true;
	end

	function ch:UnbindPattern(regex)
		if not regex then return; end
		for k,_ in pairs(binds) do
			if string.find(k, regex) then binds[k] = nil; end
		end
	end

	function ch:Invoke(routine, ...)	
		local strm = RPC.GetOutputStream();
		strm:Open(self);
		strm:AppendObject("Q" .. routine);
		strm:AppendVector(...);
		local stid = RPC.GenerateCleanBytes(6);
		strm:Send(stid);
		outStids[stid] = true;
		return stid;
	end
	ch.Flash = ch.Invoke; -- Flashing IS invoking in stream RPC.

	function ch:SendResponse(id, ...)
		local os = RPC.GetOutputStream();
		os:Open(self);
		os:AppendObject("R" .. id);
		os:AppendVector(...);
		os:Send();
	end

	function ch:Wait(id, fn, timeout)
		timeout = timeout or 30;
		waits[id] = fn; 
		wtos[id] = GetTime() + timeout;
		-- Schedule Cleantimeout
		VFLT.AdaptiveUnschedule("CleanTimeOut " .. ch.name);
		VFLT.AdaptiveSchedule("CleanTimeOut " .. ch.name, 5, CleanTimeOut);
	end
	
	function ch:IsSend(stid)
		return outStids[stid];
	end
	
	RPCEvents:Bind("STREAM_OUT_CLOSED", nil, function(strm) 
		local stid = strm.streamID; if not stid then return; end
		outStids[stid] = nil;
	end);

	return ch;
end

-----------------------------------------------
-- GLUE STREAMING RPC TO DEFAULT CODE
-----------------------------------------------
RegisterAddonMessagePrefix("RDX");

RPC_Guild = RDX.ImbueAddonChannel(nil, "RDX", "GUILD");
RPC.StreamingRPCMixin(RPC_Guild);
RPC.RegisterConference(RPC_Guild, "GUILD");

RPC_Officer = RDX.ImbueAddonChannel(nil, "RDX", "OFFICER");
RPC.StreamingRPCMixin(RPC_Officer);
RPC.RegisterConference(RPC_Officer, "OFFICER");

RPC_Group = RDX.ImbueAddonChannel(nil, "RDX", "RAID");
RPC.StreamingRPCMixin(RPC_Group);
RPC.RegisterConference(RPC_Group, "GROUP");

-- Update our RPC channel pointer when our status changes...
local function _RPC_Checkraid()
	if VFL.InArena() then
		--RDX.printI(VFLI.i18n("Switching to |cFF00FF00BATTLEGROUND|r channel"));
		RDX:Debug(2, "|cFF0000FFSwitch channel Arena|r");
		RDX.ImbueAddonChannel(RPC_Group, "RDX", "BATTLEGROUND");
	elseif VFL.InBattleground() then
		--RDX.printI(VFLI.i18n("Switching to |cFF00FF00BATTLEGROUND|r channel"));
		RDX:Debug(2, "|cFF0000FFSwitch channel PVP|r");
		RDX.ImbueAddonChannel(RPC_Group, "RDX", "BATTLEGROUND");
	elseif RDXDAL.InRaid() then
		--RDX.printI(VFLI.i18n("Switching to |cFF00FF00RAID|r channel"));
		RDX:Debug(2, "|cFF0000FFSwitch channel RAID|r");
		RDX.ImbueAddonChannel(RPC_Group, "RDX", "RAID");
	elseif RDXDAL.GetNumUnits() == 1 then
		--RDX.printI(VFLI.i18n("Switching to |cFF00FF00SOLO|r channel"));
		RDX:Debug(2, "|cFF0000FFSwitch channel SOLO|r");
		RDX.ImbueLoopbackChannel(RPC_Group, "RDX");
	else
		--RDX.printI(VFLI.i18n("Switching to |cFF00FF00PARTY|r channel"));
		RDX:Debug(2, "|cFF0000FFSwitch channel PARTY|r");
		RDX.ImbueAddonChannel(RPC_Group, "RDX", "PARTY");
	end
end
RDXEvents:Bind("PARTY_IS_RAID", nil, _RPC_Checkraid);
RDXEvents:Bind("PARTY_IS_NONRAID", nil, _RPC_Checkraid);
VFLEvents:Bind("PLAYER_IN_BATTLEGROUND", nil, _RPC_Checkraid);

---- Tests
--[[
RPC_Group:Bind("test0", function(ci, x1) 
	VFL.print("|cFF00FF00SUCCESSFUL TEST SEND from <" .. tostring(ci.sender) .. ">: no args");
end);
RPC_Group:Bind("test1", function(ci, x1) 
	VFL.print("|cFF00FF00SUCCESSFUL TEST SEND from <" .. tostring(ci.sender) .. ">: length " .. string.len(tostring(x1)) .. "|r");
end);
RPC_Group:Bind("test2", function(ci, x1) 
	VFL.print("|cFF00FFFFSUCCESSFUL TEST RET From <" .. tostring(ci.sender) .. ">: length " .. string.len(tostring(x1)) .. "|r");
	return x1;
end);
RPC_Group:Bind("test3", function(ci, ...) 
	VFL.print("|cFFFFFF00SUCCESSFUL TEST3 From <" .. tostring(ci.sender) .. ">: nargs " .. select("#", ...) .. "|r");
	return ...;
end);

function rettest(n, tcsz)
	if type(n) ~= "number" then n = 1; end
	if type(tcsz) ~= "number" then tcsz = 50; end
	local cbfr = {};
	for i=1,tcsz do VFL.ConcatBuffer.append(cbfr, string.char(math.random(0,255))); end
	local str = VFL.ConcatBuffer.toString(cbfr);
	local rseq = 1;
	for tests = 1,n do
		local id = RPC.Invoke("test2", str);
		RPC_Group:Wait(id, function(ci, resp)
			VFL.print("|cFFFFFF00RESPONSE|r #" .. rseq .. ": " .. ci.sender .. "<idcheck " .. RPC.GetReadableBytes(id) .. "=" .. RPC.GetReadableBytes(ci.id) .."> returned length " .. string.len(tostring(resp)) .. " cmp " .. tostring(resp == str));
			rseq = rseq + 1;
			if(resp ~= str) then
				VFL.print("|cFFFF0000resp: " .. RPC.GetReadableBytes(resp) .. "|r");
				VFL.print("|cFFFF0000str:  " .. RPC.GetReadableBytes(str) .. "|r");
			end
		end, 600);
	end
end

local pingtime = 0;
RPC_Group:Bind("ping1", function(ci)
	local myunit = RDXDAL.GetMyUnit();
--	if ci.sender == myunit.name then return; end -- dont answer own pings, buggy
	local _,_,latency = GetNetStats();
	RPC_Group:Invoke("ping2", ci.sender, latency);
end);
RPC_Group:Bind("ping2", function(ci, origin, latency)
	local myunit = RDXDAL.GetMyUnit();
	if origin == myunit.name then
		local _,_,local_latency = GetNetStats();
		latency = latency / 1000; local_latency = local_latency / 1000;
		local total = latency + local_latency;
		VFL.print("Ping returned by " .. ci.sender .. " in " .. (GetTime() - pingtime) .. " sec");
		VFL.print("Remote latency " .. latency .. " local latency " .. local_latency .. " total " .. total .. " half " .. total/2);
	end
end);
function pingTest()
	pingtime = GetTime();
	RPC_Group:Invoke("ping1");
end
]]--

