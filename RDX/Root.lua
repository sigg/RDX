-- Root.lua
-- RDX - Raid Data Exchange
-- (C)2005 Bill Johnson
--
-- Event dispatcher, core simple functions, loaded before all other scripts
--

RDX = RegisterVFLModule({
	name = "RDX";
	description = "Raid Data Exchange";
	parent = VFL;
});
RDX:LoadVersionFromTOC("RDX");
--RDX:ModuleSetDebugLevel(7);

-- The module tablespace
--RDXM = {};
local initd = nil;

function RDX.IsInitialized()
	return initd;
end

function RDX.Initialized()
	initd = true;
end

----------------------------
-- KEYBINDING NAMES
----------------------------
BINDING_HEADER_RDX = "RDX";
BINDING_NAME_RDXHIDEUI = VFLI.i18n("Show/Hide RDX");
BINDING_NAME_RDXMENU = VFLI.i18n("RDX Main Menu");
BINDING_NAME_RDXEXPLORER = VFLI.i18n("RDX Explorer");
BINDING_NAME_RDXWL = VFLI.i18n("Window List");
BINDING_NAME_RDXROSTER = VFLI.i18n("Open Roster");

----------------------------
-- EVENT DISPATCHER
----------------------------
RDXEvents = DispatchTable:new();
RDXEvents.name = "RDXEvents";

-------------------
-- UI SUPPORT FUNCTIONS
-------------------
-- Spam RDX-type chat
function RDX.print(str)
	VFL.print("* |cFFAAAAAARDX:|r " .. str);
end

function RDX.printI(str)
	VFL.print(" |cFFAAAAAARDX|r |cFF00FF00INFO:|r " .. str);
	RDXEvents:Dispatch("INFO", " |cFF00FF00INFO:|r " .. str);
end

function RDX.printW(str)
	VFL.print(" |cFFAAAAAARDX|r |cFFFFFF00WARNING:|r" .. str);
	RDXEvents:Dispatch("WARNING", " |cFFFFFF00WARNING:|r" .. str);
end

function RDX.printE(str)
	VFL.print(" |cFFAAAAAARDX|r |cFFFF0000ERROR:|r" .. str);
	RDXEvents:Dispatch("ERROR", " |cFFFF0000ERROR:|r" .. str);
end

-- Generate a unique ID number
function RDX.GenerateUniqueID()
	return math.random(10000000);
end




