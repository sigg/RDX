-- Omni.lua
-- RDX - Project Omniscience
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Combat logging and data collection facilities for Project Omniscience.

Omni = RegisterVFLModule({
	name = "Omniscience";
	title = "Omniscience";
	description = "Omniscience - a combat logging facility for RDX";
	parent = RDX;
	version = {2,0,0};
});

--- The root Omniscience dispatch table.
-- Events:
-- SESSION_CREATED(session) - fired whenever a session is created.
-- SESSION_DELETED(deletedSessionName) - fired whenver a session is deleted.
-- SESSION_TABLE_ADDED(session, tableAdded) - fired whenever a table is added to a session.
-- SESSION_TABLE_DELETED(session, deletedTableName) - fired whenever a table is removed from a session.
-- SESSION_TABLE_RENAMED(session, tableRenamed) - fired whenever a table is renamed on a session.
-- TABLE_CURRENT_CHANGED(newTbl) - fired whenever the current table is changed.
-- TABLE_DATA_CHANGED(tbl) - fired whenever a table's data changes.
OmniEvents = DispatchTable:new();

--------- Load saved tables
RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	-- Verify saved variables
	--if not Omni_SavedTables then Omni_SavedTables = {}; end
	-- Create the saved session
	--local saved = Omni.Session:new("Saved Tables");
	--saved.isLocal = true;
	--saved.tablespace = Omni_SavedTables;
	-- Remap the metadata for the tables in the saved session.
	--for _,tbl in pairs(saved.tablespace) do
	--	setmetatable(tbl, Omni.Table);
	--	tbl:SetFormat(tbl.format);
	--	tbl.session = saved;
	--end
	-- Cleanse the tables
	--saved:Cleanse();
	
	
	
	
end);

