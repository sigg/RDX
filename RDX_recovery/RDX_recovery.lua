-- RDX_Recovery.lua
-- OpenRDX
--
-- This addon is just used to store recovery database
--

---------------------------------------------------
-- INIT
---------------------------------------------------
WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXBackup then RDXBackup = {}; end
end);
