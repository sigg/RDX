-- RDX_combatlogs.lua
-- OpenRDX
--
--
Omni_Logs = {};
Omni_TableLogs = {};

function RDXGetTableLogs(name)
	if not Omni_TableLogs[name] then 
		Omni_TableLogs[name] = {};
	end
	return Omni_TableLogs[name];
end

function RDXDropTableLogs(name)
	local x = Omni_TableLogs[name];
	if x then 
		VFL.empty(x);
		Omni_TableLogs[name] = nil;
	end
end

---------------------------------------------------
-- INIT
---------------------------------------------------
WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not Omni_SavedTables then Omni_SavedTables = {}; end
end);
