-- CommEngine.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- The RDX communications engine. Contains facilities for sending and binding
-- to the various available chat channels. Also contains an overall "spam
-- control" system to regulate outgoing chat flow.

---------------------------------------------------------
-- CHAT CHANNEL MESSAGING
---------------------------------------------------------

-- The channels table.
local channels = {};

-- Leave all inactive channels.
function RDX.CleanupChannels()
	-- Leave all irrelevant channels
	for i=1,20 do
		local n,ch = GetChannelName(i);
		if(ch) and (string.find(ch, "^rdx")) then
			local qq = channels[ch];
			if not qq then
				RDX.printI(VFLI.i18n("Leaving orphaned RDX channel: ") .. ch);
				LeaveChannelByName(ch);
			else
				qq:Cleanup();
			end
		end
	end
end

-- Create a chat channel.
function RDX.GetChatChannel(name)
	RDX:Debug(3, "RDX.GetChatChannel(" .. tostring(name) .. ")");
	name = string.lower(name);
	-- Get existing channel
	local ch = channels[name]; if ch then return ch; end
	
	-- Create a new channel
	ch = {};

	ch.name = name;
	ch.sig = VFL.Signal:new();
	ch.num = 0;
	ch.refCount = 0;
	ch.queue = nil;

	local Joiner = VFLT.CreatePeriodicLatch(5, function()
		RDX:Debug(9, "RDX.ChatChannel(): trying to join channel <" .. tostring(name) .. ">");
		JoinChannelByName(name, nil, DEFAULT_CHAT_FRAME:GetID());
	end);

	-- Leave this channel, if we were in it, clearing out all queues, etc.
	function ch:Cleanup()
		LeaveChannelByName(self.name);
		self.queue = nil; self.num = 0;
		self.sig:DisconnectAll();
	end

	-- Check to make sure we're properly on this channel. Join if not.
	function ch:Check()
		local no, name = GetChannelName(self.num);
		if name ~= self.name then
			-- See if we're on the channel, but don't realize it
			no, name = GetChannelName(self.name);
			if(no > 0) then self.num = no; return true; end
			-- Nope, try to join.
			Joiner(); return false;
		end
		return true;
	end

	-- Send a message on this channel.
	function ch:Send(msg)
		if not self:IsOpen() then return; end
		if self:Check() then
			SendChatMessage(msg, "CHANNEL", nil, self.num);
		end
	end

	-- Bind to the OnReceive signal for this channel
	function ch:OnReceive(obj, fn)
		return self.sig:Connect(obj, fn);
	end

	-- Unbind something previously bound by OnReceive
	function ch:UnbindReceive(si)
		self.sig:DisconnectByHandle(si);
	end

	-- Check the reference count for this channel.
	function ch:IsOpen()
		return (ch.refCount > 0);
	end
	-- Increment the reference count for this channel.
	function ch:Open() 
		self.refCount = self.refCount + 1; 
		if self.refCount > 0 then self:Check(); end
	end
	-- Decrement the reference count for this channel, removing if empty.
	function ch:Close()
		self.refCount = self.refCount - 1;
		if self.refCount <= 0 then
			self.refCount = 0;
			RDX.CleanupChannels();
		end
	end
	channels[name] = ch;
	return ch;
end

-- Receptor event for chat
WoWEvents:Bind("CHAT_MSG_CHANNEL", nil, function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	local ch = channels[arg9];
	if ch and ch:IsOpen() then ch.sig:Raise(arg1, arg2); end
end);

---------------------------------------------------
-- ANTISPAM
---------------------------------------------------
-- Removed for WoW 2.0, possibly causing taint issues...
--[[
local _OldChatHandler = ChatFrame_OnEvent;
ChatFrame_OnEvent = function(event)	
	-- If it's an RDX channel...
	if (arg9) and string.find(arg9, "^rdx") then
		-- If it's not a chatlist or system msg
		if(event ~= "CHAT_MSG_CHANNEL_LIST") and (event ~= "CHAT_MSG_SYSTEM") then 
			-- Suppress it.
			return;
		end
	end
	_OldChatHandler(event);
end

-- On deferred init, cleanup old chat channels
RDXEvents:Bind("INIT_DEFERRED", nil, function()
	RDX.CleanupChannels();
end);
]]--

--------------------------------------------------
-- ADDON MESSAGING
--------------------------------------------------
function RDX.ImbueAddonChannel(preChannel, prefix, chType)
	-- Create a new channel
	ch = preChannel or {};
	if ch.Cleanup then ch:Cleanup(); end

	ch.name = chType .. "<" .. prefix .. ">";
	ch.chType = chType;
	ch.prefix = prefix;

	local theSig = ch.sig;
	if not theSig then
		theSig = VFL.Signal:new();
		ch.sig = theSig;
	end

	-- Check to make sure we're properly on this channel. Join if not. (No sense for an
	-- addon channel.)
	function ch:Check()
		return true;
	end

	-- Send a message on this channel.
	function ch:Send(msg)
		SendAddonMessage(prefix, msg, chType);
	end

	-- Check the reference count for this channel.
	function ch:IsOpen() return true; end
	-- Increment the reference count for this channel.
	function ch:Open() end
	-- Decrement the reference count for this channel, removing if empty.
	function ch:Close() end

	-- Leave this channel, if we were in it, clearing out all queues, etc. (Makes no sense
	-- for an addon channel.)
	function ch:Cleanup()
		RPC:Debug(1, "Unbinding (" .. chType .. "," .. prefix .. ") from examination.");
		self.chType = nil; self.prefix = nil;
		WoWEvents:Unbind(self);
	end


	RPC:Debug(1, "Binding (" .. chType .. "," .. prefix .. ") for examination.");
	WoWEvents:Bind("CHAT_MSG_ADDON", nil, function(arg1, arg2, arg3, arg4)
		if(arg1 == prefix) and (arg3 == chType) then
			theSig:Raise(ch, arg4, arg1, arg2, arg3);
		end
	end, ch);
	
	return ch;
end

-- Loopback channel for solo play.
function RDX.ImbueLoopbackChannel(preChannel, prefix)
	-- Create a new channel
	ch = preChannel or {};
	if ch.Cleanup then ch:Cleanup(); end

	ch.name = "LOOPBACK";
	ch.chType = ""; ch.prefix = prefix;

	local theSig = ch.sig;
	if not theSig then
		theSig = VFL.Signal:new();
		ch.sig = theSig;
	end

	-- Check to make sure we're properly on this channel. Join if not. (No sense for an
	-- addon channel.)
	function ch:Check()	return true; end

	-- Send a message on this channel.
	function ch:Send(msg)
		local myunit = RDXDAL.GetMyUnit();
		-- Schedule for the next frame.
		VFLT.schedule(0.01, theSig.Raise, theSig, ch, myunit.name, prefix, msg, "");
	end

	-- Check the reference count for this channel.
	function ch:IsOpen() return true; end
	-- Increment the reference count for this channel.
	function ch:Open() end
	-- Decrement the reference count for this channel, removing if empty.
	function ch:Close() end

	-- Leave this channel, if we were in it, clearing out all queues, etc. (Makes no sense
	-- for an addon channel.)
	function ch:Cleanup()
		RPC:Debug(1, "Unbinding loopback from examination.");
		self.chType = nil; self.prefix = nil;
	end

	RPC:Debug(1, "Binding loopback for examination.");
	
	return ch;
end
