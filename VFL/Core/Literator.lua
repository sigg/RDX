--- Literator.lua
-- @author (C)2006 Bill Johnson and The VFL Project
--
-- @description A literator is a linear iterator - a slightly enhanced variant of a Lua iterator
-- that is able to treat the underlying data structure as if it were an array.
-- A literator is actually a pair of functions, the SIZE function and the ACCESSOR function.
-- The SIZE function must return the size of the underlying data structure as an integer.
-- The ACCESSOR function must accept an integer value. For values between 1-(SIZE), the
-- accessor should return the value at that index in the data structure. For other values,
-- the accessor must return nil.

--- Return a literator over an empty set. Size is always zero and data is always nil.
function VFL.EmptyLiterator() return VFL.Zero, VFL.Nil; end

--- Adapt a literator that spans the given array.
function VFL.ArrayLiterator(a)
	local f1 = function() return #a end;
	local f2 = function(idx) return a[idx] end;
	return f1,f2;
end

--- Reverse literator that spans the given array.
function VFL.ReversedArrayLiterator(a)
	return function() return #a; end, function(idx) return a[#a + 1 - idx]; end;
end

local ci,n,iter;

--- Literator Delayed Foreach
-- @description For every item x in the literator, call f(x), introducing a delay of dt seconds
-- in between each call.
function VFL.LiDelayedForeach(dt, f, liN, liX)
	ci,n,iter = 1,liN(),nil;
	if(n == 0) then return nil; end
	function iter()
		f(liX(ci), ci, n);
		if(ci < n) then ci=ci+1; VFLT.ZMSchedule(dt, iter); end
	end
	VFLT.ZMSchedule(dt, iter);
	return true;
end

--- Iterator Delayed Foreach
function VFL.DelayedForeach(dt, f, fDone, liN, liX)
	ci,n,iter = 1,liN(),nil;
	if(n == 0) then return nil; end
	function iter()
		f(liX(ci), ci, n);
		if(ci < n) then ci=ci+1; VFLT.ZMSchedule(dt, iter); else fDone(); end
	end
	iter();
	return true;
end
