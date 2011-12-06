-- MainMenu.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- Functions for manipulating, displaying, and accessing the RDX6 main menu.

local _submenu_color = {r=0.2, g=0.9, b=0.9};

----------------------------------------------------
-- MENU OBJECT
----------------------------------------------------
RDXPM.Menu = {};
RDXPM.Menu.__index = RDXPM.Menu;

function RDXPM.Menu:new()
	local self = {};
	self.mm = {};
	self.entries = {};
	setmetatable(self, RDXPM.Menu);
	return self;
end

-- Destroy the menu
function RDXPM.Menu:Destroy()
	VFL.empty(self.mm); self.mm = nil;
	VFL.empty(self.entries); self.entries = nil;
	-- to test
	self = nil;
end

function RDXPM.Menu:RegisterMenuFunction(func)
	if type(func) ~= "function" then return; end
	table.insert(self.mm, func);
	return true;
end

function RDXPM.Menu:RegisterMenuEntry(title, isSubmenu, fn)
	if (not title) or (not fn) then return nil; end
	if isSubmenu then
		self:RegisterMenuFunction(function(entry)
			entry.text = title;
			entry.color = _submenu_color;
			entry.isSubmenu = true;
			entry.func = fn;
		end);
	else
		self:RegisterMenuFunction(function(entry)
			entry.text = title;
			entry.func = fn;
		end);
	end
	return true;
end

function RDXPM.Menu:Open(point, parent, relpoint, x, y)
	local i = 0;
	local mm, entries = self.mm, self.entries;
	for _,func in ipairs(mm) do
		i=i+1;
		if not entries[i] then entries[i] = {}; end
		VFL.empty(entries[i]);
		func(entries[i]);
	end
	for j,_ in ipairs(entries) do if j > i then entries[j] = nil; end end
	--if tree then
	--	tree:Expand(parent, entries);
	--else
		VFLUI.PopUpMenu(entries, point, parent, relpoint, x, y);
	--end
end

function RDXPM.Menu:Close()
	VFLUI.ClosePopUp();
end

function RDXPM.Menu:ResetMenu()
	VFL.empty(self.mm);
end

---------------------------------------------------------
-- THE MAIN MENU
---------------------------------------------------------
RDXPM.mainMenu = RDXPM.Menu:new();

--- Register an entry on the RDX main menu whose values are determined by function.
-- The function should accept a menu entry table and update the text, OnClick, etc as appropriate.
function RDXPM.RegisterMainMenuFunction(func)
	return RDXPM.mainMenu:RegisterMenuFunction(func);
end

--- Register an entry on the RDX main menu. 
--
-- When clicked, the entry will
-- invoke the given function, passing in the menu and the attach frame
-- as parameters for the purpose of spawning a submenu.
--
-- If isSubmenu is true, the menu entry will be decorated like a submenu
-- entry. isSubmenu causes no functional change.
function RDXPM.RegisterMainMenuEntry(title, isSubmenu, fn)
	return RDXPM.mainMenu:RegisterMenuEntry(title, isSubmenu, fn);
end

--- Show the RDX main menu at the current mouse position.
function RDXPM.ShowMainMenu()
	VFL.poptree:Begin(160, 14, VFLFULLSCREEN_DIALOG, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(VFLFULLSCREEN_DIALOG));
	RDXPM.mainMenu:Open(VFL.poptree, nil);
end

---------------------------------------------------------
-- The third party MENU
---------------------------------------------------------

RDXPM.ThirdPartyMenu = RDXPM.Menu:new();

function RDXPM.RegisterThirdPartyMenuFunction(func)
	return RDXPM.ThirdPartyMenu:RegisterMenuFunction(func);
end

function RDXPM.RegisterThirdPartyMenuEntry(title, isSubmenu, fn)
	return RDXPM.ThirdPartyMenu:RegisterMenuEntry(title, isSubmenu, fn);
end

function RDXPM.ShowThirdPartyMenu()
	VFL.poptree:Begin(160, 14, VFLFULLSCREEN_DIALOG, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(VFLFULLSCREEN_DIALOG));
	RDXPM.ThirdPartyMenu:Open(VFL.poptree, nil);
end
