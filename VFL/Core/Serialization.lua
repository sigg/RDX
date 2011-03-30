--- Serialization.lua
-- @author (C) 2005-2006 Bill Johnson and The VFL Project
--
-- Contains various useful primitive operations
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

local pairs = pairs;
local type = type;
local tostring = tostring;
local loadstring = loadstring;
local setfenv = setfenv;
local strformat, strsub, strlen = string.format, string.sub, string.len;
local tgetn = table.getn;
local dsFunc;


local ti; -- number

local function GetEntryCount(tbl)
	ti = 0;
	for _,_ in pairs(tbl) do ti = ti + 1; end
	return ti;
end

--- Serialize an object and return a string
function Serialize(obj)
	if(obj == nil) then
		return "";
	elseif (type(obj) == "string") then
		return strformat("%q", obj);
	elseif (type(obj) == "table") then
		local str = "{ ";
		if obj[1] and ( tgetn(obj) == GetEntryCount(obj) ) then
			-- Array case
			for i=1,tgetn(obj) do str = str .. Serialize(obj[i]) .. ","; end
		else
			-- Nonarray case
			for k,v in pairs(obj) do
				if (type(k) == "number") then
					str = str .. "[" .. k .. "]=";
				elseif (type(k) == "string") then
					str = str .. '["' .. k .. '"]=';
				else
					error("bad table key type");
				end
				str = str .. Serialize(v) .. ",";
			end
		end
		-- Strip trailing comma, tack on syntax
		return strsub(str, 0, strlen(str) - 1) .. "}";
	elseif (type(obj) == "number") then
		return tostring(obj);
	elseif (type(obj) == "boolean") then
		return obj and "true" or "false";
	else
		error("could not serialize object of type " .. type(obj));
	end
end

--- Deserialize a string and return the object
function Deserialize(data)
	if not data then return nil; end
	dsFunc = loadstring("return " .. data);
	if dsFunc then 
		-- Prevent the deserialization function from making external calls
		setfenv(dsFunc, VFL.emptyTable);
		-- Call the deserialization function
		return dsFunc();
	else 
		return nil; 
	end
end