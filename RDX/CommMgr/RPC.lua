-- RPC.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- RPC is Remote Procedure Call, a mechanism for transferring code and data between
-- clients over a common substrate.
--
-- A "Conference" is the fundamental underlying substrate for RPC. People in
-- a Conference see every message sent to the Conference (with the possible
-- exception of the sender himself, see reflexive vs. non-reflexive conferences)
--
-- Some Conferences also provide a higher-level API that automatically deals with the
-- nuances of the transaction system. These are the high level methods:
--
-- :Flash("routine", ...) - Execute the given routine on this conference WITHOUT A TRANSACTION.
--    This means that no response is possible, and that the request must be <200 characters.
-- :Invoke("routine", ...) - Execute the given routine on this conference. Returns the transaction
--    ID for use with :Wait.
-- :Wait(xid, onRecv, timeout) - Wait on the transaction with the given ID. For
--   each completed response, onRecv is called. When the timeout has expired, further responses
--   are discarded.

--------------------------------------------------------
-- STANDARD RPC
--------------------------------------------------------
--- Determine if the entity pointed to by this CommInfo is a member of your current group.
-- If so, return his RDX Unit.
function RPC.IsGroupMember(ci)
	if(not ci) or (not ci.sender) then return nil; end
	return RDXDAL.GetUnitByNameIfInGroup(ci.sender);
end

--- Determine if the entity poitned to by this CommInfo is a leader of your current group.
-- If so, return his unit. If not, return nil.
function RPC.IsGroupLeader(ci)
	if(not ci) or (not ci.sender) then return nil; end
	local u = RDXDAL.GetUnitByNameIfInGroup(ci.sender); if not u then return nil; end
	if u:IsLeader() then return u; else return nil; end
end

--- Get the unit entity for the sender if it exists
function RPC.GetSenderUnit(ci)
	if(not ci) or (not ci.sender) then return nil; end
	--VFL.print(ci.sender);
	return RDXDAL.GetUnitByNameIfInGroup(ci.sender);
end

------------------------------------------------
-- Compatibility with old RPC syntax
------------------------------------------------
function RPC.Invoke(routine, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	return RPC_Group:Invoke(routine, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
end

