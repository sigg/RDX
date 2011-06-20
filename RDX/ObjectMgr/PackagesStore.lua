

-----------------------------------------------
-- ALL will be open only in durotar zone.
-----------------------------------------------

RPC_AllCmd = RDX.GetChatChannel("rdxallcmd");
RPC.StreamingRPCMixin(RPC_AllCmd, true);

-- Request list client
local storename = "rdx store";
local function cli_req_list(filter)
	if type(filter) ~= "string" then VFL.print("Please, enter a valid search text. Thanks."); return; end
	local rpcid = RPC_AllCmd:Invoke("store_req_list", filter);
	RPC_AllCmd:Wait(rpcid, function(ci, resp)
		-- Sanity check all incoming parameters; make sure everything exists that should exist
		if (not ci) or (not ci.sender) or (ci.sender ~= storename) or (not ci.id) or (type(resp) ~= "table") then return; end
		updatelistGUI(resp);
	end, 20);
end
-- Request list store
local function store_req_list(ci, filter)
	if (not ci) or (not ci.id) then return; end
	return VFL.copy(GetFilterListPkgInfo(filter));
end

-- Request Package client
local function cli_req_Pkg(pkgname)
	if type(pkgname) ~= "string" then VFL.print("Please, enter a valid package name. Thanks."); return; end
	local rpcid = RPC_AllCmd:Invoke("store_req_pkg", pkgname);
	RPC_AllCmd:Wait(rpcid, function(ci, respflag, resptxt)
		-- Sanity check all incoming parameters; make sure everything exists that should exist
		if (not ci) or (not ci.sender) or (ci.sender ~= storename) or (not ci.id) then return; end
		VFL.print(resptxt);
	end, 20);
end
-- Request Package store
local function store_req_list(ci, pkgname)
	if (not ci) or (not ci.id) then return; end
	if not existpackage then
		return false, "Package unknown";
	else
		if packageis transferring then
			table.insert(RDXPS[pkgname], ci.sender);
		else
			table.insert(RDXPS[pkgname], ci.sender);
		end
		return true, "Request in the queue";
	end
end

-- Update our RPC channel pointer when our status changes...
local function _RPC_Checkzone()
	if false then
		if not RPC_AllCmd:IsOpen() then
			RDX:Debug(2, "|cFF0000FFOpen channel All|r");
			RPC_AllCmd:Open();
			-- identify you are the client or the server.
			if store then
				RPC_AllCmd:Bind("store_req_list", store_req_list);
			else
			
			end
		end
	else
		if RPC_AllCmd:IsOpen() then
			--RPC_AllCmd:UnbindPattern("client");
			RPC_AllCmd:UnbindPattern("store");
			RDX:Debug(2, "|cFF0000FFClose channel All|r");
			RPC_AllCmd:Close();
		end
	end
end
WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, _RPC_Checkzone);
WoWEvents:Bind("ZONE_CHANGED_NEW_AREA", nil, _RPC_Checkzone);