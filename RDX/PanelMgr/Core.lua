-- Core.lua
-- OpenRDX
-- Sigg / Rashgarroth EU
-- Manage RDX Panels (main menu and editors)

RDXPM = RegisterVFLModule({
	name = "RDXPM";
	title = VFLI.i18n("RDX Panel Management");
	description = "RDX Panel Management";
	version = {1,0,0};
	parent = RDX;
});

--- The root dispatch table.
-- Events:

RDXPMEvents = DispatchTable:new();

--
--
--

-- store and restore RDX Editors positions
-- positions are stored in RDXG

function RDXPM.Ismanaged(name)
	if RDXG.EditorsPanel[name] then return true; else return false; end
end

function RDXPM.StoreLayout(frame, name)
	local lt,tt,rt,bt = VFLUI.GetUniversalBoundary(frame);
	local tbl = {l=lt, t=tt, r=rt, b=bt};
	RDXG.EditorsPanel[name] = tbl;
end

function RDXPM.RestoreLayout(frame, name)
	local tbl = RDXG.EditorsPanel[name];
	if tbl then
		VFLUI.SetAnchorFramebyPosition(frame, "TOPLEFT", tbl.l, tbl.t, tbl.r, tbl.b);
	end
end

-- delete all positions
local function ResetLayouts()
	VFL.empty(RDXG.MainPanel);
	VFL.empty(RDXG.EditorsPanel);
	ReloadUI();
end

function RDXPM.ResetLayouts()
	VFLUI.MessageBox("Reset", "Do you want to reset all RDX editors layout? All editors will be moved to the center of the screen.", nil, "No", nil, "Yes", ResetLayouts);
end

RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	if not RDXG.MainPanel then RDXG.MainPanel = {}; end
	if not RDXG.EditorsPanel then RDXG.EditorsPanel = {}; end
end);

--RDXEvents:Bind("USER_RESET_UI", nil, function()
--	RDXPM.ResetLayouts()
--end);

--RDXPM.RegisterSlashCommand("reset_layout", ResetLayouts);

