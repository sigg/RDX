-- RDX6_MASync.lua
-- RDX - Raid Data Exchange
-- (C)2006 Will Dobbins
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--

function Logistics.AddAssist(name)
	if name == nil and (UnitInRaid("target") or UnitInParty("target")) then
		name = UnitName("target");
	end
	if(name) then
	    name = string.lower(name);
		local win_set = RDXDB.GetObjectInstance("RDXDiskSystem:default:assists");
		win_set:AddName(name);
		local assist_set = RDXDB.GetObjectData("RDXDiskSystem:default:assists");
		table.insert(assist_set.data, name);
		local myunit = RDXDAL.GetMyUnit();
		if myunit:IsLeader() then
		    RPC_Group:Flash("sync_assist", assist_set.data);
		end
	else
		VFL.print("Target someone!");
	end
end

function Logistics.DropAssist(name)
	
	if name == nil then name = UnitName("target"); end
	if(name) then
	    name = string.lower(name);
	    local win_set = RDXDB.GetObjectInstance("RDXDiskSystem:default:assists");
	    win_set:RemoveName(name);
		local assist_set = RDXDB.GetObjectData("RDXDiskSystem:default:assists");
		for k, v in pairs(assist_set.data) do
		    if v == name then
		        table.remove(assist_set.data, k);
			end
		end
		local myunit = RDXDAL.GetMyUnit();
		if myunit:IsLeader() then
		    RPC_Group:Flash("sync_assist", assist_set.data);
		end
	else
		VFL.print("Target someone!");
	end
end

function Logistics.SyncAssists()
	local myunit = RDXDAL.GetMyUnit();
	if not myunit:IsLeader() then return; end
	local assist_set = RDXDB.GetObjectData("RDXDiskSystem:default:assists");
	if assist_set then
		RPC_Group:Flash("sync_assist", assist_set.data);
 	end
end

function Logistics.ClearAssists()
	
	local assist_set = RDXDB.GetObjectData("RDXDiskSystem:default:assists");
	assist_set.data = {};
	local win_set = RDXDB.GetObjectInstance("RDXDiskSystem:default:assists");
	win_set:ClearNames();
	local myunit = RDXDAL.GetMyUnit();
	if myunit:IsLeader() then
		RPC_Group:Flash("sync_assist", assist_set.data);
	end
end

local function RPCSyncAssists(commInfo, names)
	local unit = RPC.GetSenderUnit(commInfo);
	if not unit then return; end

	win_set = RDXDB.GetObjectInstance("RDXDiskSystem:default:assists");
	assist_set = RDXDB.GetObjectData("RDXDiskSystem:default:assists");
	if not assist_set then VFL.print("assist set not found"); return; end
	assist_set.data = names;
	win_set:ClearNames();
	for k, v in pairs(names) do
	    win_set:AddName(v);
	end
end

--------------------------------------------------
-- SLASH COMMANDS
--------------------------------------------------
SLASH_RDX6_MASYNC1 = "/rdxsa";
SlashCmdList["RDX6_MASYNC"] = function(arg)
	local _,_,cmd = string.find(arg, "^(%w+)");
	local _,_,name = string.find(arg, "(%w+)$"); -- I'm sure this could be done more efficiently by someone more
	if cmd == name then name = nil; end          -- more familiar with find function :P
	if(cmd == "add") then
		Logistics.AddAssist(name);
	elseif(cmd == "drop") then
		Logistics.DropAssist(name);
	elseif(cmd == "sync") then
		Logistics.SyncAssists();
	elseif(cmd == "clear") then
		Logistics.ClearAssists();
	else
		VFL.print("ERROR: Usage: /rdxsa add [playername]");
		VFL.print("              /rdxsa drop [playername]");
		VFL.print("              /rdxsa sync");
		VFL.print("              /rdxsa clear");
		VFL.print("arg was ", arg);
	end
end

--------------------------------------------------
-- Bind RPC's
--------------------------------------------------
RPC_Group:Bind("sync_assist", RPCSyncAssists);

