-- Math.lua
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

local strformat, strrep = string.format, string.rep;
local min, max, abs, floor, ceil = math.min, math.max, math.abs, math.floor, math.ceil;

-- Variables
local ti; -- number
local tn; -- number
local tr; -- number
local tf; -- fraction
local td; -- number inverse

--- math.mod is broken on negative dividends Here is a fixed version
-- @param k 
-- @param n 
function VFL.mod(k, n)
	return k - floor(k/n)*n;
end

--- Burning Crusade: fix for missing math.mod (which is used everywhere...)
VFL.mmod = math.fmod;
--- Fractional part extraction
VFL.modf = math.modf;

--- Quick and dirty rounding
function VFL.round(x)
	ti,tf = math.modf(x);
	if ti >= 0 then
		if(tf > 0.5) then return ti+1; else return ti; end
	else
		if(tf < -0.5) then return ti-1; else return ti; end
	end
end

--- Are two numbers "close?" (within an epsilon distance)
function VFL.close(x, y)
	return (abs(x-y) < 0.000001);
end

--- Constrain a number to lie between certain boundaries.
-- @param n 
-- @param min minimum 
-- @param max maximum 
function VFL.clamp(n, min, max)
	if (type(n) ~= "number") then return min; end
	if(n < min) then return min; elseif(n > max) then return max; else return n; end
end

--- Constrain a number to lie between 0 and 1
function VFL.clamp01(x)
	if(x<0) then return 0; elseif(x>1) then return 1; else return x; end
end

--- Linear interpolation x
function VFL.lerp1(t, x0, x1)
	if not x1 or not x0 then return 0; end
	if(t<0) then t=0; elseif(t>1) then t=1; end
	td = 1-t;
	return td*x0 + t*x1;
end

--- Linear interpolation x, y
function VFL.lerp2(t, x0, x1, y0, y1)
	if(t<0) then t=0; elseif(t>1) then t=1; end
	td = 1-t;
	return td*x0 + t*x1, td*y0 + t*y1;
end

--- Linear interpolation x, y with t0 and t1
function VFL.lerp1x2(t0, t1, x0, x1)
	if(t0 < 0) then t0 = 0; elseif(t0 > 1) then t0 = 1; end
	if(t1 < 0) then t1 = 0; elseif(t1 > 1) then t1 = 1; end
	local d0, d1 = 1-t0, 1-t1;
	return d0*x0 + t0*x1, d1*x0 + t1*x1;
end

--- Linear interpolation x, y, z, u
function VFL.lerp4(t, x0, x1, y0, y1, z0, z1, u0, u1)
	if(t<0) then t=0; elseif(t>1) then t=1; end
	td = 1-t;
	return td*x0 + t*x1, td*y0 + t*y1, td*z0 + t*z1, td*u0 + t*u1;
end

--- Linear interpolation x, y, z, u, v
function VFL.lerp5(t, x0, x1, y0, y1, z0, z1, u0, u1, v0, v1)
	if(t<0) then t=0; elseif(t>1) then t=1; end
	td = 1-t;
	return td*x0 + t*x1, td*y0 + t*y1, td*z0 + t*z1, td*u0 + t*u1, td*v0 + t*v1;
end

--- Linear interpolation x, y, z, u, v, w
function VFL.lerp6(t, x0, x1, y0, y1, z0, z1, u0, u1, v0, v1, w0, w1)
	if(t<0) then t=0; elseif(t>1) then t=1; end
	td = 1-t;
	return td*x0 + t*x1, td*y0 + t*y1, td*z0 + t*z1, td*u0 + t*u1, td*v0 + t*v1, td*w0 + t*w1;
end

--- Cosinus interpolation x
function VFL.lerpCosine(t, x0, x1)
	t = (1 - math.cos (t * math.pi) ) / 2;
	td = 1-t;
	return td*x0 + t*x1;
end

--------
-- Step a value to the target value by a step
-- ret new value

function VFL.Util_StepValue (value, target, step)

	if value < target then
		value = value + step
		if value > target then
			value = target
		end

	elseif value > target then
		value = value - step
		if value < target then
			value = target
		end
	end

	return value
end

--- Convert a number to a string formatted as k(ilo) or m(ega)
function VFL.Kay(n)
	tn = abs(n);
	if tn < 1000 then
		return strformat("%d", n);
	elseif tn < 1000000 then
		return strformat("%0.1fk", n/1000);
	else
		return strformat("%0.2fm", n/1000000);
	end
end

--- Convert a number to a string formatted as k(ilo) or m(ega) with color
-- @param n the number
-- @param color The table color definition, _red = {r=0.9,g=0,b=0,a=1};
function VFL.KayMemory(n, color)
	if not color then color = _white end
	tn = abs(n);
	if tn < 1000 then
		return VFL.tcolorize(strformat("%d", n), color) .. "b";
	elseif tn < 1000000 then
		return VFL.tcolorize(strformat("%0.1f", n/1000), color) .. "Kb";
	else
		return VFL.tcolorize(strformat("%0.2f", n/1000000), color) .. "Mb";
	end
end

--- Format a number to Hundredths
function VFL.Hundredths(t)
	return strformat("%0.2f", t);
end

--- Format a number to Tenths
function VFL.Tenths(t)
	return strformat("%0.1f", t);
end

--- Floor a number
function VFL.NumberFloor(t)
	return floor(t);
end

function VFL.GetMoneyStr (money)

	if not money then
		return "|cffff4040?"
	end

	if money == 0 then
		return "0"
	end

	local pre = money > 0 and "" or "-"

	money = abs (money)

	local str = ""

	local g = floor (money / 10000)
	if g > 0 then
		str = format ("|cffffff00%dg", g)
	end

	local s = mod (floor (money / 100), 100) 
	if s > 0 then
		str = format ("%s |cffbfbfbf%ds", str, s)
	end

	local c = mod (money, 100) 
	if c > 0 then
		str = format ("%s |cff7f7f00%dc", str, c)
	end

	return pre .. strtrim (str)
end
