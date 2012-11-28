--- Kernel.lua
-- @author (C) 2005-2006 Bill Johnson and The VFL Project
--
-- Main code for the VFL kernel and module system.

-- Burning Crusade: Quick hack to figure out if we're on WoW 2.0 or 1.0
WoW20 = true;

-- Kernel start time
local kStartTime = GetTime();
local mathdotfloor = math.floor;
local mathdotmodf = math.modf;
local blizzGetTime = GetTime;

--- Get the OS time when the kernel started.
function VFLKernelGetStartTime()
	return kStartTime;
end

--- Get the time since session start.
function VFLKernelGetTime()
	return GetTime() - kStartTime;
end

--- Get the time since session start, rounded to the tenths place.
function VFLKernelGetTimeTenths()
	return mathdotmodf((blizzGetTime() - kStartTime) * 10);
end

--- Debugger object
-- A debugger object is an interface to a system for printing VFL module debug
-- messages.
-- @field Print A function taking arguments (src, txt), where src is a string
-- indicating the source of data and txt is a string of debug data. The
-- function should render the data as appropriate.
VFL_debugger = {
	Print = function(src, txt)
		ChatFrame1:AddMessage("[" .. src .. "] " .. txt, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
};

--- Change the system debugger.
-- This can be used to differently direct debug output.
-- @param dbg A table representing the new system debugger.
function VFLSetDebugger(dbg)
	VFL_debugger = dbg;
end

--- Module-level debugging function
function VFL_DebugPrint(refLevel, level, annot, ...)
	if ((not level) or (refLevel > level)) then
		VFL_debugger.Print(annot .. tostring(level), strconcat(...));
	end
end

----------------------------------------------
-- MODULE OBJECT
----------------------------------------------
if not Module then 
	Module = {}; 
else
	error("VFL: Module class already exists. Load aborted.");
end

Module.__index = Module;

Module.noop = function() end;

--- Create a new module.
-- @param x An optional base object to imbue with Modulehood.
function Module:new(x)
	-- Verify and create
	if not x.name then error("cannot create a module with no name"); end
	local self = x or {};
	
	-- Patriate this module
	self.children = {};
	if not self.parent then self.parent = Root; end
	self.parent:ModuleAddChild(self);
	-- Initial debug functionality: do nothing
	self.Debug = Module.noop;
	-- Setup
	setmetatable(self, Module);
	return self;
end

--- Get all children of this module.
-- @return A list of children of this module.
function Module:ModuleGetChildren()
	return self.children;
end

--- Add a child module
-- @param x The Module object of the child module.
function Module:ModuleAddChild(x)
	table.insert(self.children, x);
end

--- Issue a module command
-- @param cmd A string command to be executed on the module, if it exists.
-- The remaining arguments are used as arguments to this command.
function Module:ModuleCommand(cmd, ...)
	local x = self[cmd];
	-- If the module command exists, execute it
	if x and (type(x)=="function") then x(self, ...); end
end

--- Issue a command to this module's children
function Module:ModuleCommandChildren(cmd, ...)
	for _,child in pairs(self.children) do
		child:ModuleCommand(cmd, ...);
	end
end

--- Determine if a module has the given command available.
-- @param cmd The string command to be checked.
-- @return TRUE iff the command exists on this module. Nil otherwise.
function Module:ModuleHasCommand(cmd)
	local x = self[cmd];
	if x and (type(x)=="function") then return true; else return nil; end
end

--- Set the debug level of a module
-- @param n The new numeric debug level for the module. 0 disables debugging
-- for the module.
function Module:ModuleSetDebugLevel(n)
	-- Apply the debug settings
	if (not n) or (n <= 0) then
		self.Debug = Module.noop;
	else
		self.Debug = function(mod, lvl, ...) VFL_DebugPrint(n, lvl, mod.name, ...); end
	end
	-- Persist the debug settings
	if(self._saved) then
		self._saved.debug = n;
	end
end

--- Get a module's version number by loading and parsing a string from a WoW toc file.
function Module:LoadVersionFromTOC(addon)
	local str = GetAddOnMetadata(addon, "Version"); if not str then self.version = {0,0,0}; return; end
	local x,y,z = str:match("^(%d+)%.(%d+)%.(%d+)");
	if not x then self.version = {0,0,0}; return; end
	self.version = {tonumber(x), tonumber(y), tonumber(z)};
end

local function _printer(indent, modu)
	local str = "";
	for i=1,indent do str = str .. "  "; end
	Root:Debug(nil, str .. modu.name);
end

--- Recursively list submodules.
-- @param func The function to call
-- @param indent The recursion level
-- @param parent Link object (optional)
function Module:ModuleListModules(func, indent)
	if type(func) ~= "function" then func = _printer; end
	if type(indent) ~= "number" then indent = 0; end
	func(indent, self, parent);
	for _,child in pairs(self.children) do
		child:ModuleListModules(func, indent + 1);
	end
end

--------------------------------------------
-- ROOT MODULE
--------------------------------------------
Root = {};
Root.children = {};
Root.parent = nil;
Root.name = "Root";
setmetatable(Root, Module);
Root:ModuleSetDebugLevel(0);

--------------------------------------------
-- MODULE DATABASE
--------------------------------------------
VFL_moduledb = {};
VFL_moduledb[Root.name] = Root;

--- Register a new VFL module
-- @param x A table contaning characteristics for the new module. The fields of the table are as follows:
-- @field name The name of the module. (required)
-- @field parent The parent Module of the module. (optional, if not specified, defaults to Root)
-- @field description A text description of the module. (optional)
-- @field version A table of the form {major, minor, release} representing the version of the module. (required)
-- @field devel TRUE iff the module is a development release.
function RegisterVFLModule(x)
	-- Hard reject unnamed modules
	if not x.name then
		error("modules must have name entries");
		return nil;
	end
	Root:Debug(1, "RegisterVFLModule(" .. x.name .. ")");
	-- Soft reject preexisting modules
	if VFL_moduledb[x.name] then
		Root:Debug(1, "RegisterVFLModule(): Multiple registration of name " .. x.name);
		return nil;
	end
	local m = Module:new(x);
	VFL_moduledb[m.name] = m;
	return m;
end

-- When saved variables are loaded, project them onto the modules.
function VFLLoadModuleData()
	Root:Debug(1, "VFLLoadModuleData()");
	if not VFLModuleData then VFLModuleData = {}; end
	-- Foreach module
	for _,m in pairs(VFL_moduledb) do
		-- Get data from saved var, or create if it doesn't exist
		local md = VFLModuleData[m.name];
		if not md then
			md = {};
			VFLModuleData[m.name] = md;
		end
		-- Map saved variable
		m._saved = md;
		-- Restore persisted debug level
		m:ModuleSetDebugLevel(md.debug);
	end
end

-- VFL module
VFL = RegisterVFLModule({
	name = "VFL";
	description = "VFL";
});
VFL:LoadVersionFromTOC("VFL");

-- DEBUG VERBOSITY
VFL._dv = 0;

