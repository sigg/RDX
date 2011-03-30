-- RDX_filesystem.lua
-- OpenRDX
--
-- This addon is just used to store filesystem database
--

---------------------------------------------------
-- INIT
---------------------------------------------------
WoWEvents:Bind("VARIABLES_LOADED", nil, function()
	if not RDXData then RDXData = {}; end
end);

