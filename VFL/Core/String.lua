--- String.lua
-- @author (C) 2005-2006 Bill Johnson and The VFL Project
--
-- Contains various useful primitive operations on strings
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

local strformat, strrep, strfind, strlen, strsub, strgsub, strupper = string.format, string.rep, string.find, string.len, string.sub, string.gsub, string.upper;
local mmax = math.max;

--- Convert nil to the empty string
function VFL.nonnil(str)
	return (str or "");
end

--- A "flag string" is a string where the presence of a character indicates the truth of a property
-- Check if a flag string contains a given flag.
function VFL.checkFlag(str, flag)
	if(str == nil) then return false; end
	return strfind(str, flag, 1, true);
end

--- Set a flag in the given flag string.
function VFL.setFlag(str, flag)
	if(str == nil) then return flag; end
	if VFL.checkFlag(str,flag) then return str; else return str .. flag; end
end

--- Get the first space-delimited word from the given string
-- (word, rest) = VFL.word(str)
function VFL.word(str)
	if(str == nil) or (str == "") then return nil; end
	ti = strfind(str, " ", 1, true);
	if(ti == nil) then return str, ""; end
	return strsub(str, 1,  ti-1), strsub(str, ti+1, -1);
end

--- Get the first \n-delimited line from the given string
-- (word, rest) = VFL.line(str)
function VFL.line(str)
	if(str == nil) or (str == "") then return nil; end
	ti = strfind(str, "\n", 1, true);
	if(ti == nil) then return str, ""; end
	return strsub(str, 1,  ti-1), strsub(str, ti+1, -1);
end

--- Capitalize the first letter of a string
function VFL.capitalize(str)
	return strgsub(str, "^%l", strupper);
end

--- Trim all leading and trailing whitespace from a string
function VFL.trim(str)
	if not str then return nil; end
	_,_,str = strfind(str,"^%s*(.*)");
	if not str then return ""; end
	_,_,str = strfind(str,"(.-)%s*$");
	if not str then return ""; end
	return str;
end

--- Determines if the string is a valid identity, that is, pure alphanumerics, dashes, and underlines
function VFL.isValidIdentity(str)
	if not str then return false; end
	if strfind(str,"^[%w_-]*$") then return true; else return false; end
end

--- Determines if the string is a valid name (alphanumeric followed by alpha/space followed by alpha)
function VFL.isValidName(str)
	if not str then return false; end
	if strfind(str,"^%w[%w%s]*%w$") then return true; else return false; end
end

--- Wildcard converter. Converts "simple" wildcard strings using * as a wildcard into Lua regular expressions.
function VFL.WildcardToRegex(wc)
	local ret = strgsub(wc, "[^%w]", function(m)
		if(m == "*") then return ".*"; else return "%" .. m; end
	end);
	return ret;
end

--- Pad a stringified number with zeroes.
function VFL.zeropad(n, pad, zprefix, nprefix)
	local nstr = strformat("%d", n);
	return zprefix .. strrep("0", mmax(pad - strlen(nstr), 0)) .. nprefix .. nstr;
end

--- Insert a string in an other string at a specific position
function VFL.strinsert(str, pos, insertStr)
	return strgsub(str, 1, pos) .. insertStr .. strgsub(str, pos + 1);
end

--- Delete a piece of string defining by two positions
function VFL.strdelete(str, pos1, pos2)
	return strsub(str, 1, pos1 - 1) .. strsub(str, pos2 + 1)
end

-- ConcatBuffer

VFL.ConcatBuffer = {};

local tinsert, tremove, strlen = table.insert, table.remove, string.len;

--- Construct a new, empty ConcatBuffer object
-- @description An implementation of Roberto Ierusalimschy's fast string concatenation
-- buffer scheme at http://www.lua.org/notes/ltn009.html
function VFL.ConcatBuffer.new() return {}; end

--- Append a string to the concatBuffer object
-- @param buf The VFL.ConcatBuffer object
-- @param str The string to append
function VFL.ConcatBuffer.append(buf, str)
	tinsert(buf, str);
	for i=(#buf - 1), 1, -1 do
		if strlen(buf[i]) > strlen(buf[i+1]) then break; end
		buf[i] = buf[i] .. tremove(buf);
	end
end

--- Tostring the concatBuffer object
-- @param buf The VFL.ConcatBuffer object
-- @return The string text
function VFL.ConcatBuffer.toString(buf)
	for i=(#buf - 1), 1, -1 do
		buf[i] = buf[i] .. tremove(buf);
	end
	return buf[1];
end

--- "Sanitize" a string, removing all quotations and anything else that could be used to inject
-- Lua code into a string.
function VFL.SanitizeCodeString(str)
	str = string.gsub(str, '"', '\\"');
	str = string.gsub(str, "'", "\\'");
	return str;
end