--- Error.lua
-- @author (C)2006 Bill Johnson and The VFL Project

-- A frame for collecting error information with full stack traces.

local errsByTitle = {};
local errs = {};

local function ErrorHandler(msg)
	if not msg then return; end
	local prev = errsByTitle[msg];
	if prev then
		prev.count = prev.count + 1;
	else
		local err = {};
		err.msg = string.gsub(msg, "^[Ii]nterface%\\[Aa]dd[Oo]ns%\\", "");
		err.full = msg .. "\n\nStack trace:\n-----------\n" .. debugstack(4,50,50);
		err.count = 1;
		errsByTitle[msg] = err;
		table.insert(errs, 1, err);
		--VFL.print("|cFFFF0000[*] Lua error:|r |cFFFFFFFF" .. msg .. "|r - Type /err to view extended info.");
		VFLEvents:Dispatch("ERRORLUA", "|cFFFF0000[*] Lua error:|r |cFFFFFFFF" .. msg .. "|r - Type /err to view extended info.");
	end
end
-- Bind Error Handler
seterrorhandler(ErrorHandler);

--- Clear all errors
function VFL._ClearErrors()
	VFL.empty(errsByTitle);
	VFL.empty(errs);
end

--- Get all errors
function VFL.GetErrors()
	return errs;
end

--- Trip an error.
-- @param context The context of the problem
-- @param msg The error message
-- @param extended Extended info
function VFL.TripError(context, msg, extended)
	context = tostring(context); msg = tostring(msg); extended = tostring(extended);
	local err = {};
	err.msg = context .. ": " .. msg;
	err.full = err.msg .. "\n\nExtended info:\n-----------\n" .. extended;
	err.count = 1;
	errsByTitle[err.msg] = err;
	table.insert(errs, 1, err);
	--VFL.print("|cFFFF0000[*] " .. context .. ":|r |cFFFFFFFF" .. msg .. "|r - Type /err to view extended info.");
	VFLEvents:Dispatch("ERROR", "|cFFFF0000[*] " .. context .. ":|r |cFFFFFFFF" .. msg .. "|r - Type /err to view extended info.");
end

-- VFL.Error

VFL.Error = {};
VFL.Error.__index = VFL.Error;

--- Construct a new, empty error
-- @description A hierarchical error handling scheme.
-- @return a new VFL.Error object
function VFL.Error:new()
	local x = {};
	x.errors = {};
	x.count = 0;
	x.context = nil;
	setmetatable(x, VFL.Error);
	return x;
end

--- Set the context of this error
-- @param ctx the error context
function VFL.Error:SetContext(ctx)
	self.context = ctx;
end

--- Add a new error message
-- @param msg the error message
function VFL.Error:AddError(msg)
	if not msg then return; end
	self.count = self.count + 1;
	if self.context then
		table.insert(self.errors, self.context .. ":" .. msg);
	else
		table.insert(self.errors, msg);
	end
end

--- Get number of error message
-- @return number
function VFL.Error:Count() return self.count; end

--- HasError
-- @return boolean
function VFL.Error:HasError() return (self.count > 0); end

--- Clean this error Message
function VFL.Error:Clear()
	VFL.empty(self.errors); self.count = 0; self.context = nil;
end

--- Format all errors in single line
-- @return the string error
function VFL.Error:FormatErrors_SingleLine()
	local str = "";
	for _,err in pairs(self.errors) do
		str = str .. err .. "; ";
	end
	return str;
end

--- Dump the error into the chat
function VFL.Error:DumpToChat(msg)
	msg = msg or "Errors:";
	VFL.print(msg);
	VFL.print("------------");
	for _,err in ipairs(self.errors) do
		VFL.print(err);
	end
end

--- Send the error to the ErrorHandler
-- @param context The context error
-- @param msg the last error message
function VFL.Error:ToErrorHandler(context, msg)
	local s = "";
	for _,err in ipairs(self.errors) do s = s .. err .. "\n"; end
	VFL.TripError(context, msg, s);
end

--- Get the error Table
-- @return a table with all errors
function VFL.Error:ErrorTable()
	return self.errors;
end

--- Add error in a error object declare as param
-- @param errs The error object VFL.error
-- @param msg The error message to add
function VFL.AddError(errs, msg)
	if errs then errs:AddError(msg); end
end

--- HasError in a error object declare as param
-- @param errs The error object VFL.error
function VFL.HasError(errs)
	if errs then return errs:HasError(); else return nil; end
end

--- A global error object to save memory.
-- USE WITH CAUTION! WHEN IN DOUBT, JUST MAKE A NEW ONE.
vflErrors = VFL.Error:new();
