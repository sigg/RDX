-- Streams.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Mechanisms for the streaming transfer of data.

-- Imported functions
local byte, strlen, strsub, char, random = string.byte, string.len, string.sub, string.char, math.random;
local strgsub = string.gsub;
local strformat = string.format;
local tinsert, tremove, tempty = table.insert, table.remove, VFL.empty;
local modf, abs, frexp, ldexp = math.modf, math.abs, math.frexp, math.ldexp;
local cbnew, cbappend, cbtostr = VFL.ConcatBuffer.new, VFL.ConcatBuffer.append, VFL.ConcatBuffer.toString;
local ZMSchedule = VFLT.ZMSchedule;

-- Imported events
local sigStreamOutOpened = RPCEvents:LockSignal("STREAM_OUT_OPENED");
local sigStreamOutProgress = RPCEvents:LockSignal("STREAM_OUT_PROGRESS");
local sigStreamOutClosed = RPCEvents:LockSignal("STREAM_OUT_CLOSED");

local sigStreamInProgress = RPCEvents:LockSignal("STREAM_IN_PROGRESS");
local sigStreamInOpened = RPCEvents:LockSignal("STREAM_IN_OPENED");
local sigStreamInHeader = RPCEvents:LockSignal("STREAM_IN_HEADER");
local sigStreamInClosed = RPCEvents:LockSignal("STREAM_IN_CLOSED");

-- Parameters
local lineDelay = .25; -- The interval, in seconds, between sideband transmissions.
local maxInStreams = 60; -- Maximum number of simultaneous inbound streams.

-----------------------------------------------------
-- BASIC STRING PROCESSING
-----------------------------------------------------
local c253, c254, c255, c0, c10, c124 = char(253), char(254), char(255), char(0), char(10), char(124);
local c240, c241, c252 = char(240), char(241), char(252);
local c200, c201, c202 = char(200), char(201), char(202);
local c247, c248, c249 = char(247), char(248), char(249);

-- Remove unxferable bytes from a string 0-246
local function cleanChar(n)
	if n == 0 then
		return c247;
	elseif n == 10 then
		return c248;
	elseif n == 124 then
		return c249;
	end
	return char(n); -- Tailcall optimization
end

-- Undo cleanChar.
local function cleanByte(str, i)
	local c = byte(str, i);
	if c == 247 then
		return 0;
	elseif c == 248 then
		return 10;
	elseif c == 249 then
		return 124;
	else
		return c;
	end
end

-- Number codecs
EncodeInt1, DecodeInt1 = VFL.GetRadixCodec(246, 1, 0, cleanChar, cleanByte);
EncodeInt2, DecodeInt2 = VFL.GetRadixCodec(246, 2, 0, cleanChar, cleanByte);
EncodeInt4, DecodeInt4 = VFL.GetRadixCodec(246, 4, 0, cleanChar, cleanByte);
EncodeInt7, DecodeInt7 = VFL.GetRadixCodec(246, 7, 0, cleanChar, cleanByte);
EncodeInt8, DecodeInt8 = VFL.GetRadixCodec(246, 8, 0, cleanChar, cleanByte);

local function EncodeFloat(f)
	local m,e = frexp(f);
	return EncodeInt7(modf(ldexp(m, 54))) .. EncodeInt2(e);
end

local function DecodeFloat(s)
	local m,e = strsub(s, 1, 7), strsub(s, 8, 9);
	m = ldexp(DecodeInt7(m), -54); e = DecodeInt2(e);
	return ldexp(m, e);
end

local function EncodeNumber(n)
	local x,y = modf(n);
	-- Float case
	if y ~= 0 then
		-- Save an indirection, this is an inline version of EncodeFloat() above.
		x,y = frexp(n);
		return EncodeInt7(modf(ldexp(x, 54))) .. EncodeInt2(y);
	end
	-- Int case
	x = abs(x);
	if(x < 122) then
		return EncodeInt1(n);
	elseif(x < 30257) then
		return EncodeInt2(n);
	elseif(x < 1831093127) then
		return EncodeInt4(n);
	else
		return EncodeInt8(n);
	end
end

--- Escape the passed string for transport over a stream.
function RPC.EscapeString(s)
	return strgsub(s, ".", function(c)
		local b = byte(c);
		if b == 0 then
			return char(255, 200);
		elseif b == 10 then
			return char(255, 201);
		elseif b == 124 then
			return char(255, 202);
		elseif b >= 250 then
			return char(255, b);
		else
			return c;
		end
	end);
end

--- Unescape the passed string.
local xsre = char(255) .. "(.)";
function RPC.UnescapeString(s)
	return strgsub(s, xsre, function(c)
		if(c == c200) then return c0;
		elseif(c == c201) then return c10;
		elseif(c == c202) then return c124;
		else return c; end
	end);
end

--[[
function tesc()
	local s = "";
	for i=1,255 do 
		local j = random(250,256); if j >= 255 then j=0; end
		s = s .. char(j);
	end
	local sprime = RPC.EscapeString(s);
	local sdprime = RPC.UnescapeString(sprime);
	if not (s == sdprime) then
		VFL.print("SX:");
		VFL.print("s=" .. RPC.GetReadableBytes(s));
		VFL.print("s'=" .. RPC.GetReadableBytes(sprime));
		VFL.print("s''=" .. RPC.GetReadableBytes(sdprime));
	end
end
]]--

--- Generate n clean random bytes
local function GenerateCleanByte()
	local r = random(2,230);
	if r == 10 then r=231;
	elseif r == 124 then r=232;
	end
	return char(r);
end
function RPC.GenerateCleanBytes(n)
	local out = "";
	for i=1,n do out = out .. GenerateCleanByte(); end
	return out;
end

-- Convert a string to readable hex code.
function RPC.GetReadableBytes(s)
	return string.gsub(s, ".", function(c) return strformat("%02x", byte(c)); end);
end

--------------------------------------------------------------
-- OUTPUT STREAM MULTIPLEXER
--------------------------------------------------------------
local oplex = {};
local oplexi = 1;
local oplexse = nil;

local function oplex_exec()
	-- If there's a plex entry at our current index...
	local cur_o = oplex[oplexi];
	if cur_o then
		if (not cur_o:SendLine()) then
			tremove(oplex, oplexi);
			cur_o:Close();
		else
			oplexi = oplexi + 1;
		end
		oplexse = ZMSchedule(lineDelay, oplex_exec);
	-- If there's a first plex entry
	elseif oplex[1] then
		cur_o = oplex[1]; oplexi = 1; -- Cycle back around to the beginning.
		if (not cur_o:SendLine()) then
			tremove(oplex, oplexi);
			cur_o:Close();
		else
			oplexi = oplexi + 1;
		end
		oplexse = ZMSchedule(lineDelay, oplex_exec);
	-- No plex entries, no rescheduling.
	else
		oplexse = nil;
	end
end

-- Add a stream to the oplexer.
local function oplex_insert(strm)
	tinsert(oplex, strm);
	if not oplexse then	oplex_exec();	end
end

--------------------------------------------------------------
-- OUTPUT STREAMS
--------------------------------------------------------------
-- Free streams table
local free_ostreams = {};

---------------- Main output stream class
RPC.StdOutputStream = {};
function RPC.StdOutputStream:new()
	local os = {};

	local bufs, curBuf, locked, str = {}, 1, nil, nil;
	
	--- Clear this output stream to a pristine state.
	function os:Clear()
		if locked then error(VFLI.i18n("attempt to clear locked channel")); end
		tempty(bufs); curBuf = 1;
		self.preSeq = nil; self.length = 0; self.progress = 0; self.channel = nil; self.streamID = nil;
		return true;
	end

	--- Set up the comm channel dispatch function for this output stream.
	function os:Open(channel)
		self:Clear();
		self.channel = channel;
		sigStreamOutOpened:Raise(self);
	end

	--- Append a raw string to this stream.
	function os:AppendRaw(...)
		if locked then return; end
		local x;
		for i=1,select("#",...) do
			x = select(i, ...);
			if type(x) == "string" then
				self.length = self.length + strlen(x);
				cbappend(bufs, x);
			end
		end
	end

	--- Faster routine for appending a single character. ASSUMES VALIDITY.
	function os:_AppendByte(...)
		self.length = self.length + select("#", ...);
		cbappend(bufs, char(...));
	end

	--- Append a vector to this stream.
	function os:AppendVector(...)
		local n = select("#", ...);
		-- Move back to the first non-nil element
		local j = n;
		while (j>0) and (select(j,...) == nil) do j=j-1; end
		-- Build the vector.
		self:_AppendByte(254, 1);
		for i=1,math.min(j,10) do	self:AppendObject(select(i, ...));	end
		self:_AppendByte(253);
	end

	--- Append an object to this stream.
	function os:AppendObject(obj)
		if type(obj) == "nil" then
			self:_AppendByte(250, 240);
		elseif type(obj) == "table" then
			-- Check array condition.
			if VFL.isArray(obj) then
				-- Array case
				self:_AppendByte(254, 2);
				for k,v in ipairs(obj) do	self:AppendObject(v);	end
				self:_AppendByte(253);
			else
				-- Pure table case
				self:_AppendByte(254, 3);
				for k,v in pairs(obj) do
					if (type(k) == "string" or type(k) == "number") then
						self:AppendObject(k);	self:AppendObject(v);
					else
						VFL.TripError("RDX", VFLI.i18n("Warning: attempt to serialize table with non-scalar key."), "");
					end
				end
				self:_AppendByte(253);
			end
		elseif type(obj) == "number" then
			self:AppendRaw(char(251), EncodeNumber(obj));
		elseif type(obj) == "string" then
			self:AppendRaw(char(252), RPC.EscapeString(obj));
		elseif type(obj) == "boolean" then
			if not obj then 
				self:_AppendByte(250, 242);
			else
				self:_AppendByte(250, 241);
			end
		end
	end

	--- Dispatch the contents of this stream to the underlying messaging subsystem.
	function os:Send(stid)
		-- Lock the stream
		if locked then return; end
		self.length = self.length + 4;
		locked = char(1) .. EncodeInt4(self.length) .. cbtostr(bufs);
		
		-- Come up with a stream ID.
		if stid then self.streamID = stid; else self.streamID = RPC.GenerateCleanBytes(6); end

		-- Initial sequencing
		self.preSeq = char(1); curBuf = 1;

		-- Add this stream to the plexer.
		oplex_insert(self);
	end

	--- Send a single line from this ostream.
	function os:SendLine()
		if not locked then error(VFLI.i18n("attempt to dispatch from unlocked stream")); end
		local l, n, postSeq = math.ceil(self.length / 227), (curBuf-1)*227, nil;
		-- Sequence data and send.
		if(curBuf == l) then postSeq = char(1); else postSeq = GenerateCleanByte(); end
		self.channel:Send( self.streamID .. self.preSeq .. postSeq .. strsub(locked, n+1, n+227) );
		self.preSeq = postSeq;
		-- Progress notifier
		self.progress = math.min(self.length, 227*curBuf);
		sigStreamOutProgress:Raise(self, "OUT", self.progress, self.length);
		-- If we're not done return TRUE for continuance
		if postSeq ~= char(1) then curBuf = curBuf + 1; return true; end
	end

	--- Close this stream.
	function os:Close()
		-- Unlock us, clear us out, and return us to the pile.
		locked = nil; tempty(bufs);
		sigStreamOutClosed:Raise(self);
		self:Clear();
		free_ostreams[self] = true;
	end

	return os;
end

-- Get an output stream.
function RPC.GetOutputStream()
	-- See if there's a free output stream anywhere.
	local k = next(free_ostreams, nil);
	if k then 
		free_ostreams[k] = nil; -- Remove it from the free table
		return k; 
	end
	-- Make one.
	return RPC.StdOutputStream:new();
end

--------------------------------------------------------------
-- STACK SYSTEM
--------------------------------------------------------------
-- Stack storage
local state_stack, data_stack = {}, {};
local curVec, vecIdx = {}, 0; -- Vector register for efficiency purposes
local stackContext = nil; -- Context variable for subroutines
local stackErr = nil; -- error register
local sptr = 0;

-- Resets the stack to pristine.
local function ResetStack()
	tempty(state_stack); tempty(data_stack); sptr = 0;
	state_stack[0] = VFL.Noop; stackErr = nil;
end

-- Trigger an error on the stack.
local function StackError(err)
	local f = state_stack[0];
	ResetStack(); stackErr = err;
	-- Notify upstream handler of error
	f(3, nil, "ERROR", err);
end

--------------- Stack states
local function stack_string(op, data, a1, a2)
--	VFL.print("stack_string " .. op .. "," .. tostring(a1) .. "," .. tostring(a2));
	if(op == 1) then -- a1 = current parse position
		data_stack[sptr] = a1 + 1;
	elseif(op == 2) then -- a2 = the whole shebang
	  return "STRING", RPC.UnescapeString(strsub(a2, data, a1 - 1));
	end
end

local function stack_number(op, data, a1, a2)
--	VFL.print("stack_number " .. op .. "," .. tostring(a1) .. "," .. tostring(a2));
	if(op == 1) then
		data_stack[sptr] = a1 + 1;
	elseif(op == 2) then
		local z = strsub(a2, data, a1 - 1);
		if strlen(z) == 1 then
			return "NUMBER", DecodeInt1(z);
		elseif strlen(z) == 2 then
			return "NUMBER", DecodeInt2(z);
		elseif strlen(z) == 4 then
			return "NUMBER", DecodeInt4(z);
		elseif strlen(z) == 8 then
			return "NUMBER", DecodeInt8(z);
		elseif strlen(z) == 9 then
			return "NUMBER", DecodeFloat(z);
		end
	end
end

local function stack_bool(op, data, a1, a2)
	if(op == 1) then
		data_stack[sptr] = a1 + 1;
	elseif(op == 2) then
		local z = strsub(a2, data, data);
		if z == c240 then
			return "BOOLEAN", nil;
		elseif z == c241 then
			return "BOOLEAN", true;
		elseif z == c242 then
			return "BOOLEAN", false;
		end
	end
end

local function stack_vector(op, data, a1, a2)
--	VFL.print("stack_vector " .. op .. "," .. tostring(a1) .. "," .. tostring(a2));
	if(op == 1) then
		tempty(curVec); vecIdx = 1;
	elseif(op == 2) then
		return "VECTOR", curVec;
	elseif(op == 3) then
		if a1 == "VECTOR" then -- No nested vectors!
			StackError(VFLI.i18n("Nested vectors"));
			return; 
		end 
		curVec[vecIdx] = a2; vecIdx = vecIdx + 1;
	end
end

local function stack_array(op, data, a1, a2)
--	VFL.print("stack_array " .. op .. "," .. tostring(a1) .. "," .. tostring(a2));
	if(op == 1) then
		local x = {}; x.__index = 1;
		data_stack[sptr] = x;
	elseif(op == 2) then
		data.__index = nil;
		return "TABLE", data;
	elseif(op == 3) then
		data[data.__index] = a2; data.__index = data.__index + 1;
	end
end

local function stack_table(op, data, a1, a2)
--	VFL.print("stack_table " .. op .. "," .. tostring(a1) .. "," .. tostring(a2));
	if(op == 1) then
		local x = {}; x.__index = nil;
		data_stack[sptr] = x;
	elseif(op == 2) then
		data.__index = nil;
		return "TABLE", data;
	elseif(op == 3) then
		if data.__index ~= nil then
			data[data.__index] = a2;
			data.__index = nil;
		else
			if a1 == "NUMBER" or a1 == "STRING" then
				data.__index = a2;
			else
				StackError(VFLI.i18n("Table index must be STRING or NUMBER")); return;
			end
		end
	end
end

-- Pop an entry from the stack. Invokes the pop procedure of the entry and
-- the preceding entry.
local function PopStack(a1, a2)
	if sptr == 0 then return; end

	-- Get state being popped
	local ps, pd = state_stack[sptr], data_stack[sptr]; 

	-- Invoke the statefunction
	local upv1, upv2 = ps(2, pd, a1, a2);

	-- Remove us from the stack
	state_stack[sptr] = nil; data_stack[sptr] = nil; 
	sptr = sptr - 1;

	-- Invoke the upfunction
	ps = state_stack[sptr]; pd = data_stack[sptr];
	ps(3, pd, upv1, upv2);

	return true;
end

-- Pops an object off the stack, escaping one scalar context if it's there
local function PopObject(a1, a2)
	local ps = state_stack[sptr]; if not ps then return; end
	-- If it's a scalar...
	if(ps == stack_string) or (ps == stack_number) or (ps == stack_bool) then	
		-- Pop it and reacquire
		PopStack(a1, a2);
		ps = state_stack[sptr];
	end
	-- Pop an object.
	if(ps == stack_vector) or (ps == stack_array) or (ps == stack_table) then
		PopStack(a1, a2);
	end
end

-- Push an entry to the stack, popping any previous scalar entry while we're at it.
local function PushStack(st, a1, a2)
	-- If there's a scalar at the top of the stack, pop it before proceeding
	local ps = state_stack[sptr];
	if(ps == stack_string) or (ps == stack_number) or (ps == stack_bool) then	
		PopStack(a1, a2);
	end

	-- Add to the stack
	sptr = sptr + 1;
	if(sptr > 64) then StackError(VFLI.i18n("Serialization stack overflow")); end
	state_stack[sptr] = st;

	-- Invoke the "just added" handler for the state.
	st(1, nil, a1, a2);
end

--------------------------------------------------------------
-- INBOUND STREAM DECODER
--------------------------------------------------------------
-- Free input streams
local free_istreams = {};
local open_istreams = 0;
-- Inbound stream routing table
local instreams = {};

--- Create a stream decoder.
RPC.StreamDecoder = {};
function RPC.StreamDecoder:new()
	local self = {};

	------------------------------- COMMAND AND CONTROL
	local rootHandler = VFL.Noop;
	local isOpen, isHdlg = nil, nil;
	-- Concat buffer for reassembling incoming strings
	local concatBuf = {};

	-- Open this input stream as a clean slate.
	function self:Open(sid, sdr, chn, hdlr)
		if (not sid) or (not sdr) or (not chn) or (not hdlr) then
			error(VFLI.i18n("invalid parameters to StreamDecoder:Open()"));
		end
		if isOpen then error(VFLI.i18n("Open on already-open stream.")); end
		RPC:Debug(10, "InStream<" .. tostring(self) .. ">:Open()");
		-- Setup dynamic parameters
		self.streamID = sid; self.sender = sdr; self.channel = chn;
		self.length = 0; self.progress = 0; self.preSeq = char(1);
		self.timeout = GetTime() + 5; -- Autotimeout in 5sec if we don't get more data.
		rootHandler = hdlr;
		-- Notify downstream processes that we've opened
		sigStreamInOpened:Raise(self);
		instreams[sid] = self; isOpen = true;
	end

	-- Change the handler for this input stream
	function self:SetHandler(hdlr) rootHandler = hdlr or VFL.Noop; end
	
	-- Close this input stream, terminating further inputs.
	function self:Close()
		RPC:Debug(10, "InStream<" .. tostring(self) .. ">:Close()");
		if not isOpen then return; end
		isOpen = nil;
		-- Notify downstream processes that we're closing.
		sigStreamInClosed:Raise(self); 
		-- Remove us from the routing table
		instreams[self.streamID] = nil; 
		-- Clear all stuff set by :Open().
		self.streamID = nil; self.sender = nil; self.channel = nil;
		self.timeout = nil; self.length = 0; self.progress = 0; self.preSeq = nil;
		rootHandler = VFL.Noop;
		-- Empty our concat buffer
		tempty(concatBuf);
		-- Clear our stack
		ResetStack();
		-- Add us to freestreams.
		open_istreams = open_istreams - 1; free_istreams[self] = true;
	end

	-- Trip an error message on this stream.
	function self:Error(msg)
		if isHdlg then 
			StackError(msg);
		else
			RPC:Debug(1, "|cFFFF0000StreamDecoder error:|r ", msg);
			self:Close();
		end
	end
	
	---------------------------------------
	-- DECODER CORE
	---------------------------------------
	local function hproc(v, d, a1, a2)
		rootHandler(self, a1, a2);
	end
	
	local function Handle()
		-- Mark us as in the handler loop
		isHdlg = true;

		-- Completely unwind the concatenation buffer.
		local str = cbtostr(concatBuf);	local len = strlen(str);

		-- Setup the root stack handler
		state_stack[0] = hproc;

		-- Iterate over the string.
		local i, n = 1, nil;
		while i <= strlen(str) do
			if stackErr or (not isOpen) then break; end -- Error = forced abort.
			n = byte(str, i);
			if(n == 255) then -- Escape character; advance past with no alteration.
				i=i+1; 
			elseif(n == 254) then -- Begin vectored object.
				n = byte(str, i+1);
				if n == 1 then
					PushStack(stack_vector, i, str);
				elseif n == 2 then
					PushStack(stack_array, i, str);
				elseif n == 3 then
					PushStack(stack_table, i, str);
				else
					StackError(VFLI.i18n("Invalid vectored object type"));
				end
				i=i+1; -- Advance the cursor
			elseif(n == 253) then
				PopObject(i, str);
			elseif(n == 252) then
				PushStack(stack_string, i, str);
			elseif(n == 251) then
				PushStack(stack_number, i, str);
			elseif(n == 250) then
				PushStack(stack_bool, i, str);
			end
			-- Advance the cursor
			i=i+1;
		end
		-- Handle errors
		if stackErr then
			RPC:Debug(1, "|cFFFF0000StreamDecoder error:|r ", stackErr);
		else
			-- We're done decoding, pop everything
			while PopStack(i, str) do end
			rootHandler(self, "EOF");
		end
		-- Close down the stream.
		isHdlg = nil; -- No longer in the handler loop
		self:Close();
	end
	
	--- Handle an incoming data block.
	function self:HandleBlock(str, eos)
		local l = strlen(str); self.progress = self.progress + l;
		cbappend(concatBuf, str);
		if eos then Handle(); end
	end

	return self;
end

--- Get an input stream.
function RPC.GetInputStream()
	open_istreams = open_istreams + 1;
	-- See if there's a free output stream anywhere.
	local k = next(free_istreams, nil);
	if k then 
		free_istreams[k] = nil; -- Remove it from the free table
		return k; 
	end
	-- Make one.
	return RPC.StreamDecoder:new();
end

function RPC.GetOpenInStreams() return open_istreams, VFL.tsize(free_istreams); end

------------------------------------------------------------------------------
-- TIMEOUT TROLLING
-- Troll the current input stream list for streams that have timed out and
-- close them.
------------------------------------------------------------------------------
local function TimeoutTroll()
	local t = GetTime();
	--local found = nil;
	for strx,strv in pairs(instreams) do
		--found = true;
		if strv and (t > strv.timeout) then
			RPC:Debug(4, "Timing out stream with id ", strv.streamID);
			strv:Close(); 
		end
	end
	--if not found then
		-- there is no more instreams we can stop the schedule of the TimeoutTroll
	--	VFLT.AdaptiveUnschedule2("TimeoutTroll");
	--end
end

VFLT.AdaptiveSchedule2("TimeoutTroll", 5, TimeoutTroll);

---------------------------------------------------------------------------
-- STANDARD INPUT STREAMS
--
-- For each incoming stream message, verify its formatting and sequencing,
-- collate it into a "bin" based on stream ID, and process.
---------------------------------------------------------------------------
local function GetHeaderHdlr(stream, dataType, data)
--	RPC:Debug(10, "InStream:GetHeaderHdlr<",RPC.GetReadableBytes(stream.streamID), ">:", tostring(ev), ",", tostring(dataType), ",", tostring(data));
	-- Abort on errors.
	if(dataType == "ERROR") then return; end
	-- Propagate header signal
	sigStreamInHeader:Raise(stream, dataType, data);
end

--- Input handler for standard streams.
function RPC.StdStreamIn(channel, sender, prefix, line)
	-- Exclude bogus inputs.
	if (not channel) or (not sender) or (not line) then return; end
	sender = string.lower(sender);
	-- Parse stream ID and sequence identifiers
	if strlen(line) < 8 then return; end -- not enough data.
	local sid = strsub(line, 1, 6);
	local preSeq, postSeq = strsub(line, 7, 7), strsub(line, 8, 8);
	local data = strsub(line, 9, -1);
	-- Do we have a stream with this ID?
	local strm = instreams[sid];
	if not strm then
		-- No we do not.
		-- Is it a new stream? If not,we're in the middle of another stream, so ignore.
		if preSeq == char(1) then
			-- Security check: don't allow more than 60 simultaneous open streams.
			if(open_istreams > maxInStreams) then return; end
			-- Examine the data for a four-byte length identifier
			-- (streamType = 1byte) (length = 4bytes) ...
			local len = DecodeInt4(strsub(data, 2, 5));
			if(len > 0) then
				-- Clip off the length portion
				data = strsub(data, 6, -1);
				-- Create a new stream handler.
				strm = RPC.GetInputStream();
				-- Open the handler and point the input handling functions at the GetLengthHdlr
				-- function.
				strm:Open(sid, sender, channel, GetHeaderHdlr);
				-- Compute length and timeout
				strm.length = len;
				strm.timeout = GetTime() + (math.ceil(len / 227) * lineDelay * 10) + 30;
			else
				RPC:Debug(5, "Malformed stream length ", tostring(len));
				return;
			end
		else
			-- Unsequenced stream, nothing further to do.
			RPC:Debug(5, "Unsequenced stream.");
			return;
		end
	end
	-- Verify the sequence number.
	if preSeq ~= strm.preSeq then strm:Error(VFLI.i18n("Out-of-sequence packet")); return; end
	strm.preSeq = postSeq;
	-- Verify the sender.
	if sender ~= strm.sender then return; end
	-- Notify of our progress.
	sigStreamInProgress:Raise(strm, "IN", strm.progress, strm.length);
	-- Apply the block that we read to this stream.
	strm:HandleBlock(data, (postSeq == char(1)));
	
	-- start scheduling TimeoutTroll
	--VFLT.AdaptiveUnschedule2("TimeoutTroll");
	--VFLT.AdaptiveSchedule2("TimeoutTroll", 5, TimeoutTroll);
end

-------------------------
-- STATUS WINDOW
-------------------------
local _lrpc = {};
local _lrpc_window = nil;

local function _CreateLongRPCWindow(parent)
	if _lrpc_window then return; end
	
	-- Build the long RPC window from features.
	local state = RDX.GenericWindowState:new();
	-- Add window frame
	state:AddFeature({feature = "Frame: Default", title = "Data Streams", bkd = VFL.copy(VFLUI.BlizzardDialogBackdrop)});
	
	-- ApplyData invokes a user provided function
	state:AddSlot("_ApplyData");
	state:_SetSlotFunction("_ApplyData", function(frame, icv, data)
		local r,g,b,arrow=1,1,1, "> ";
		if data.dir == "IN" then g=.5; arrow = "< "; end
		frame.bar:SetStatusBarColor(r,g,b);
		frame.bar:SetValue(data.p);
		frame.text1:SetText(arrow .. data.name);
		frame.text2:SetText(string.format("%0.1f/%0.1fk", data.progress/1000, data.length/1000));
	end);
	
	-- Add generic subframe
	state:AddFeature({feature = "Generic Subframe", w = 120, h = 14, tdx = 50});
	
	-- Custom slots
	state:AddSlot("DataSource");
	state:AddSlot("DataSourceIterator");
	state:_SetSlotFunction("DataSourceIterator", function() return pairs(_lrpc); end);
	state:AddSlot("DataSourceSize");
	state:_SetSlotFunction("DataSourceSize", function() return VFL.tsize(_lrpc); end);
	
	-- Layout
	state:AddFeature({feature = "Grid Layout", cols = 1, dxn = 1});

	_lrpc_window = RDX.Window:new(parent);
	_lrpc_window:LoadState(state);
	_lrpc_window.RepaintAll = state:GetSlotFunction("RepaintAll");
	_lrpc_window:WMGetPositionalFrame():SetPoint("CENTER", VFLParent, "CENTER");
	VFLUI.Window.StdMove(_lrpc_window:WMGetPositionalFrame(), _lrpc_window:GetTitleBar());
	if RDXPM.Ismanaged("RPC_window") then RDXPM.RestoreLayout(_lrpc_window:WMGetPositionalFrame(), "RPC_window"); end
	state = nil;
end

local function _UpdateLongRPCWindow()
	local n = VFL.tsize(_lrpc);
	if(n == 0) then -- No window should be shown at all.
		if _lrpc_window then 
			--_lrpc_window:WMStopDrag(true);
			RDXPM.StoreLayout(_lrpc_window:WMGetPositionalFrame(), "RPC_window");
			_lrpc_window:Hide();
		end
	else
		if (not _lrpc_window) then
			_CreateLongRPCWindow(VFLFULLSCREEN);
		end
		if _lrpc_window then
			_lrpc_window:Show();
			_lrpc_window:RepaintAll();
		end
	end
end

local function _LongRPCStatus(strm, dxn, cur, total)
	local sid = strm.streamID; if not sid then return; end
	sid = sid .. dxn;
	-- If there's not a stream by this name, make it if applicable
	local utbl = _lrpc[sid];
	if not utbl then
		if total and total > 2500 and cur < total then
			utbl = { dir = dxn; p = 0; name = strm.sender or ""; progress = 0; length = total };
			_lrpc[sid] = utbl;
		else
			return;
		end
	end
	-- Update fields
	utbl.p = VFL.clamp(cur/math.max(total,1), 0, 1);
	utbl.progress = cur; utbl.length = total;
	_UpdateLongRPCWindow();
end

local function _LongRPCCloseOut(strm)
	local sid = strm.streamID; if not sid then return; end
	sid = sid .. "OUT";
	if _lrpc[sid] then
		_lrpc[sid] = nil; _UpdateLongRPCWindow();
	end
end
local function _LongRPCCloseIn(strm)
	local sid = strm.streamID; if not sid then return; end
	sid = sid .. "IN";
	if _lrpc[sid] then
		_lrpc[sid] = nil; _UpdateLongRPCWindow();
	end
end

RPCEvents:Bind("STREAM_OUT_PROGRESS", nil, _LongRPCStatus);
RPCEvents:Bind("STREAM_OUT_CLOSED", nil, _LongRPCCloseOut);
RPCEvents:Bind("STREAM_IN_PROGRESS", nil, _LongRPCStatus);
RPCEvents:Bind("STREAM_IN_CLOSED", nil, _LongRPCCloseIn);

