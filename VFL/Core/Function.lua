--- Function.lua
-- @author (C) 2005-2006 Bill Johnson and The VFL Project
--
-- Contains various useful primitive operations on functions
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

-- Constant functions
--- Function Noop
function VFL.Noop() end
--- Function return true
function VFL.True() return true; end
--- Function return false
function VFL.False() return false; end
--- Function return 0
function VFL.Zero() return 0; end
--- Function return 1
function VFL.One() return 1; end
--- Function return nil
function VFL.Nil() return nil; end
--- Function return param
-- @param x the param
function VFL.Identity(x) return x; end

--- If f is a function, return f evaluated at the arguments, otherwise return f
function VFL.call(f, ...)
	if type(f) == "function" then return f(...); else return f; end
end

--- Wrap a "method invocation" on an object into a portable closure.
function VFL.WrapInvocation(obj, meth)
	if obj then
		return function(...) 
			return meth(obj, ...); 
		end
	else
		return meth;
	end
end

--- Create a simple hook.
-- @param fnBefore The function to call first in the hook chain.
-- @param fnAfter The function to call second in the hook chain.
-- @return The new hook chain.
function VFL.hook(fnBefore, fnAfter)
	-- If one of the hooks is invalid, just return the other.
	if (not fnBefore) or (fnBefore == VFL.Noop) then
		return fnAfter;
	elseif (not fnAfter) or (fnAfter == VFL.Noop) then
		return fnBefore;
	end
	-- Otherwise generate the hook.
	return function(...)
		fnBefore(...); fnAfter(...);
	end
end

--- Return a function that generates an increasing series of numbered
-- tokens beginning with the given prefix string.
function VFL.GenerateSequencer(prefix)
	local i = 0;
	return function()
		i=i+1; return prefix .. i;
	end
end
