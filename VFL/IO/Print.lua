--- Io.lua
-- @author (C) 2005-2006 Bill Johnson and The VFL Project
--
-- Contains various useful primitive operations on functions, strings, and tables.
--
-- Notational conventions are:
-- STRUCTURAL PARAMETERS
--    T is a table. k,v indicate keys and values of T respectively
--    A is an array (table with positive integer keys)
--		L is a list (table with keys ignored) L' < L indicates the sublist relation.
-- FUNCTION PARAMETERS:
--    b is a boolean predicate on an applicable domain (must return true/false)
--    f is a function to be specified.
-- OTHER PARAMETERS:
--    x is an arbitrary parameter.

--- Print a single line to the chat window.
function VFL.print(str)
	if(str == nil) then str = "nil"; end
	if type(str) == "number" then str = tostring(str);
	elseif type(str) == "function" then str = "function";
	elseif type(str) == "table" then str = "table";
	end 
	ChatFrame1:AddMessage(str, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	if VFLIO and VFLIO.Console then
		VFLIO.Console:AddMessage(str, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
end

--- Print the contain of a table "KEY " .. k .. ",VALUE " .. v
function VFL.tprint(table)
	if type(table) ~= "table" then VFL.print(table); return; end
	for k,v in pairs(table) do 
		if type(v) == "boolean" then v = "boolean"; end
		if type(v) == "table" then v = "table"; end 
		VFL.print("KEY " .. k .. ",VALUE " .. v);
	end
end

--- Print a single line in the center of the screen.
function VFL.cprint(str)
	if(str == nil) then return; end
	UIErrorsFrame:AddMessage(str, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1.0, UIERRORS_HOLD_TIME);
end

--- Print a string for debugging at the given verbosity level.
function VFL.debug(str, level)
	if(not level) or (VFL._dv > level) then
		VFL.print("[Debug] " .. str);
	end
end