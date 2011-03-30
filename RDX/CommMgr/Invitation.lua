-- Invitation.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- RPC commands for autojoining conferences based on remote requests.

-- Accept an invitation to a conference
--[[
local function _AcceptInvitation(cn, chan, to)
	if(not cn) or (not chan) or (not tonumber(to)) then return nil; end
	RDX.printI("Joining conference id <" .. cn .. "> in channel <" .. chan ..">");
	local conf = RPC.CreateConference();
	RPC.ImbueStandardRPC(conf);
	RPC.AttachChatChannel(RDX.GetChatChannel(chan), conf);
	RPC.RegisterConference(conf, cn, to);
end

-- Process an invitation that applies to me.
local function _ProcessInvitation(sender, cn, chan, to)
	if(not sender) or (not cn) or (not chan) or (not to) then return; end
	RPC:Debug(4, "_ProcessInvitation(" .. sender.name .. "," .. tostring(cn) .. "," .. tostring(chan) .. "," .. tostring(to));
	-- If I'm already in this conference, ignore.
	if RPC.GetConferenceByID(cn) then return nil; end
	-- If the sender is a raid/group leader, auto-accept the invitation.
	if sender:IsLeader() then
		_AcceptInvitation(cn, chan, to); return true;
	else
		-- TODO: how to handle nonleader invitations?
	end
end

RPC.Bind("conf_inv_l", function(ci, cn, chan, to, list)
	if (not cn) or (not chan) or (not to) or (not list) then return; end
	local sdr = RPC.GetSenderUnit(ci);
	local myunit = RDXDAL.GetMyUnit();
	if (not sdr) or (not sdr:IsValid()) then return; end
	for _,n in pairs(list) do
		if n == myunit.name then
			RPC:Debug(2, "Received invitation from " .. sdr.name .. " to channel " .. chan);
			_ProcessInvitation(sdr, cn, chan, to); return;
		end
	end
end);

RPC.Bind("conf_inv_f", function(ci, cn, chan, to, filt)
		if (not cn) or (not chan) or (not to) then return; end
	local sdr = RPC.GetSenderUnit(ci); if not sdr then return; end
	local test = RDXDAL.FilterFunctor(filt); if not test then return; end
	local myunit = RDXDAL.GetMyUnit();
	if test(myunit) then
		RPC:Debug(2, "Received invitation from " .. sdr.name .. " to channel " .. chan);
		_ProcessInvitation(sdr, cn, chan, to);
	end
end);
]]--
