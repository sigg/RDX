--- Table.lua
-- @author (C) 2005-2006 Bill Johnson and The VFL Project
--
-- Contains various useful primitive operations on tables
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
local ipairs = ipairs;
local type = type;
local next = next;
local type = type;
local tinsert = table.insert;
local tgetn = table.getn;
local tremove = table.remove;

-- Variables
local ti; -- number
local tn; -- number
local tr; -- number
local tf; -- fraction
local td; -- number inverse

-- Constant empty table.
VFL.emptyTable = {};

--- Returns true if the table T has no entries whatsoever.
function VFL.isempty(T)
	for k,v in pairs(T) do return false; end
	return true;
end

--- Nils out all entries of T
function VFL.empty(T)
	for k,v in pairs(T) do T[k] = nil; end
end

--- Return the actual size of the table T.
function VFL.tsize(T)
	ti = 0;
	for _,_ in pairs(T) do ti = ti + 1; end
	return ti;
end

--- Returns an array containing the unique keys of the table T
function VFL.getkeys(T)
	if(T == nil) then return nil; end
	local ret = {};
	for k,v in pairs(T) do tinsert(ret, k); end
	return ret;
end

--- Returns a pairs() type iterator function over the given table that only returns
-- entries that match the given filter f(k,v).
function VFL.filteredIterator(T, f)
	local k = nil;
	return function()
		local v;
		k,v = next(T,k);
		while k and (not f(k,v)) do k,v = next(T,k); end
		return k,v;
	end;
end

--- An unordered iterator over the values of T
function VFL.vals(T)
	local k = nil;
	return function()
		local v;
		k,v = next(T,k);
		return v;
	end
end

--- Like ipairs(), only just returns values.
function VFL.ivals(T)
	local i = 0;
	return function()
		i = i + 1;
		return T[i];
	end
end

--- Creates an identical, deep copy of T
function VFL.copy(T)
	if(T == nil) then return nil; end
	local out = {};
	local k,v;
	for k,v in pairs(T) do
		if type(v) == "table" then
			out[k] = VFL.copy(v); -- deepcopy subtable
		else
			out[k] = v; -- softcopy primitives
		end
	end
	return out;
end

--- Copies T[k] into D[k] for all k in keys(T)
-- T is unchanged, and all other entries of D are unchanged.
function VFL.copyInto(D, T)
	for k,v in pairs(T) do
		if type(v) == "table" then D[k] = VFL.copy(v); else D[k] = v; end
	end
	return true;
end

--- Sets to nil all entries of D that do not have a corresponding
-- entry in T, i.e. if T[k] == nil then D[k] will be made nil.
-- T is unchanged.
function VFL.collapse(D, T)
	if(D == nil) or (T == nil) then return false; end
	for k,_ in pairs(D) do
		if T[k] == nil then D[k] = nil; end
	end
	return true;
end

--- Makes the table referenced by D identical to the table referenced by T.
-- T is unchanged.
function VFL.copyOver(D, T)
	return (VFL.copyInto(D,T) and VFL.collapse(D,T));
end;

--- Add all of the function entries of T to D if they don't already exist.
-- If "force" is true, mixes in even if the entries already exist
function VFL.mixin(D, T, force)
	for k,v in pairs(T) do
		if (type(v) == "function") and (force or (D[k] == nil)) then
			D[k] = v;
		end
	end
end

--- Nil all the function entries in D that have corresponding entries in T.
-- "Reverses" the operation of mixin.
function VFL.unmix(D, T)
	for k,v in pairs(T) do
		if (type(v) == "function") and (D[k] == v) then
			D[k] = nil;
		end
	end
end

--- Returns k such that T[k] == v, or nil if no such k exists.
function VFL.vfind(T, v)
	if not T then return nil; end
	for k,val in pairs(T) do
		if val == v then return k; end
	end
	return nil;
end

--- Returns k,T[k] such that b(T[k]), or nil if no such k exists.
function VFL.vmatch(T, b)
	if not T then return nil; end
	for k,val in pairs(T) do
		if b(val) then return k,val; end
	end
	return nil;
end

--- Locates the first i such that L[i] = v, then removes it, returning v.
function VFL.vremove(L, v)
	local n = tgetn(L);
	for i=1,n do if L[i] == v then return tremove(L,i); end end
	return nil;
end

--- Returns new L' < L with b(x) true for all x in L'
function VFL.filter(L, b)
	if not L then return nil; end
	local tmp = {};
	for _,v in pairs(L) do
		if b(v) then tinsert(tmp, v); end
	end
	return tmp;
end

--- Modifies L, removing all elements for which b(x) is false.
function VFL.filterInPlace(L, b)
	if (not L) or (not b) then return nil; end
	tn,ti = #L, 1;
	while (ti <= tn) do
		if b(L[ti]) then ti=ti+1; else tremove(L,ti); tn=tn-1; end
	end
end

--- From L (which is assumed to be a list of tables) remove all entries
-- whose field "field" has value "val". Returns the number of entries removed
function VFL.removeFieldMatches(L, field, val)
	if (type(L) ~= "table") or (field == nil) then return 0; end
	tn,ti,tr = #L, 1, 0;
	while (ti <= tn) do
		if (L[ti][field] ~= val) then ti=ti+1; else tremove(L, ti); tn=tn-1; tr=tr+1; end
	end
	return tr;
end

--- Returns a table T' whose keys are the values of T and whose values are corresponding keys.
-- This function is invalid for inputs T with duplicated values.
function VFL.invert(T)
	if(T == nil) then return nil; end
	local ret = {};
	for k,v in pairs(T) do ret[v] = k; end
	return ret;
end

--- Return a table T' whose pairs are related to pairs of T by (k',v')=f(k,v).
-- f is a two-argument function valid on the pairs of T
function VFL.transform(T, f)
	if(T == nil) then return nil; end
	local ret = {};
	local kp, vp;
	for k,v in pairs(T) do
		kp,vp = f(k,v);
		ret[kp] = vp;
	end
	return ret;
end

--- Modifies the values of the table T based on a function f(k,v) of the pair.
function VFL.transformInPlace(T, f)
	if type(T) ~= "table" then return nil; end
	for k,v in pairs(T) do T[k] = f(k,v); end
	return T;
end

--- Forces the indices of the array A to be valid for the range [1..n]. Any indices outside of this range
-- are quashed, and any indices inside this range that are missing are added, with the given default value.
function VFL.asize(A, n, default)
	for k,_ in ipairs(A) do
		if(k>n) then A[k] = nil; end
	end
	for i=1,n do
		if not A[i] then A[i] = default; end
	end
end

--- Like asize, only will not quash entries beyond the end.
function VFL.asizeup(A, n, default)
	for i=1,n do
		if not A[i] then A[i] = default; end
	end
end

--- Return true if tbl is Array
function VFL.isArray(T)
	tn,ti = 0,0;
	for _,_ in pairs(T) do tn = tn + 1; end
	if T.n then tn=tn-1; end
	for _,_ in ipairs(T) do ti=ti+1; end
	if ti == tn then return true; else return nil; end
end

--- GENERALIZED SUM
-- Collapses a table along its rows, by identifying certain rows
-- as being in certain equivalence classes, then accumulating over those
-- classes. (Similar to an aggregate SQL query.)
--
-- General algorithm:
--  Foreach row R in iterator:
--   Identify similarity class of row R sc(R) [via fnClassify(R)]
--   Get the representative row rep(sc(R)), creating if nonexistent [via fnGenRep(R)]
--   rep(sc(R)) <-- rep(sc(R)) + R [via fnAddInPlace(rep, R)]
--
-- Details of arguments:
--  * ri must be a Lua iterator that returns tables to be regarded as rows.
--  * fnClassify(R) must take a row and return a classification of that row, or nil if the row is to
--  be ignored. The classification function may split the row into up to 5 separate categories, each of which
--  must be returned.
--  * fnGenRep(R, class) must take a row and its class and generate a representative row suitable for fnAddInPlace.
--  * fnAddInPlace(Rrep, R) must set Rrep=Rrep+R.
--
-- Returns:
--  The cumulated representatives of each row class.
-- 
-- Usage:
--  Given a time series of events (hits with damage, for example) one might want to classify each type of hit
--  (Eviscerate, Sinister Strike, etc) and arrive at a final table describing each TYPE of hit and the TOTAL
--  or AVERAGE damage over that type. If fnClassify were a projection onto the hit-type axis, and
--  fnAddInPlace was a sum or average cumulator, this function would perform this task.
function VFL.gsum(ri, fnClassify, fnGenRep, fnAddInPlace)
	-- Begin afresh
	local reps, classify = {}, {};
	-- Foreach row
	for R in ri do
		-- Attempt to classify row
		local c1, c2, c3, c4, c5 = fnClassify(R);
		-- If class is nil, ignore, otherwise proceed.
		if c1 then
			classify[1] = c1; classify[2] = c2; classify[3] = c3; classify[4] = c4; classify[5] = c5;
			-- For each classification...
			for _,rclass in pairs(classify) do
				-- Obtain representative row, creating one if none exists
				local rrep = reps[rclass];
				if not rrep then reps[rclass] = fnGenRep(R, rclass); rrep = reps[rclass]; end
				-- Add this row to the representative row, in place (i.e. rrep <-- rrep + R)
				if rrep then fnAddInPlace(rrep, R, rclass); end
			end -- for _,rclass in classify
		end -- if c1
	end -- for R in ri
	-- Return the representative rows.
	return reps;
end

local function dest_recurse(context, key, value)
	context.depth = context.depth + 1;
	context.path[context.depth] = key;
	for k,v in pairs(value) do
		context._func(context, k, v);
	end
	context.path[context.depth] = nil;
	context.depth = context.depth - 1;
end

--- DESTRUCTURE
--
-- Applies a "destructuring operator" to a table, which extracts or transforms substructures 
-- of tables in an extremely general way. Similar to (but more general than) the 
-- pattern matching construct in languages like ML.
--
-- How it works: You provide a function f(context, key, value) that is evaluated at each pair 
-- of the table. This function is given a "context" object, which is the heart of the 
-- destructuring algorithm.
--
-- The context object provides lots of useful information, including the current recursion level
-- within the table, and the "path" of keys starting from the top that was used to reach the
-- current node.
-- While processing a node that's a table, you can decide whether to recurse or not. If you call
-- context:Recurse(key, value), the destructure will continue down that node. Otherwise it will not.
-- This gives you enhanced control over performance and can also make algorithms easy to write (only
-- recurse when needed.)
--
-- As the context is a lua table, you can also initialize it however you want, as well as storing
-- arbitrary information on it. However, you may not touch the following reserved fields:
-- context.depth - INTEGER - the current destructure depth
-- context.path - TABLE - the current path in the destructuring
-- context._func - FUNCTION - the destructure operator.
-- context.Recurse - FUNCTION - the recurse trigger.
--
-- At the end of the destructure, the context object is returned.
function VFL.destructure(T, f, context)
	if (type(T) ~= "table") or (type(f) ~= "function") then 
		error("VFL.destructure: unexpected argument type"); 
	end
	-- Setup the context
	if type(context) ~= "table" then context = {}; end
	context.depth = 0; context.path = {}; context.Recurse = dest_recurse; context._func = f;
	-- Depth 0 scan
	for k,v in pairs(T) do
		f(context, k, v);
	end
	-- Done
	return context;
end