-- SlashCommands.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Infrastructure for basic slash-command handling.
local rdxslash = {};

function RDXPM.RegisterSlashCommand(name, fn)
	if (not name) then error(VFLI.i18n("name is required")); end
	if rdxslash[name] then error(VFLI.i18n("duplicate slash command registration ") .. name); end
	rdxslash[name] = fn;
end

local function printUsage()
	RDX.printI(VFLI.i18n("USAGE: /rdx [command] [arguments]"));
	RDX.printI(VFLI.i18n("Valid commands are:"));
	for k,_ in pairs(rdxslash) do
		RDX.printI("- /rdx " .. k);
	end
end

SLASH_RDX1 = "/rdx";
SlashCmdList["RDX"] = function(arg)
	local cmd,arg = VFL.word(arg);
	if type(cmd) ~= "string" then printUsage(); return; end
	cmd = string.lower(cmd);
	if rdxslash[cmd] then
		rdxslash[cmd](arg);
	else
		printUsage();
	end
end
