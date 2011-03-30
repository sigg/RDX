-- Security.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Base code for the RDX security and permissions system.

-----------------------------------------------------------------------------------
-- DANGEROUS OBJECT DETECTION
--
-- Detect objects that might contain Lua code or other exploitable mechanisms.
-- Warn the user before he installs any such object.
-----------------------------------------------------------------------------------

local dofs = {};

--- Register a dangerous object filter. The registration table has two fields:
-- matchType - The type of objects to match. "*" matches any type.
-- Filter - a function of the form F(metadata) called for each object to filter against.
--   Should return TRUE iff the object is dangerous.
function RDXDB.RegisterDangerousObjectFilter(tbl)
	if (not tbl) then error(VFLI.i18n("expected table, got nil")); end
	if (not tbl.matchType) then error(VFLI.i18n("missing table.matchType")); end
	if not tbl.Filter then error(VFLI.i18n("missing table.Filter")); end

	-- Create the type table
	local x = dofs[tbl.matchType]; 
	if not x then
		x = {}; dofs[tbl.matchType] = x;
	end
	-- Add our filter to the table
	table.insert(x, tbl.Filter);
end

--- Using dangerous object filters, determine whether the given object is dangerous.
function RDXDB.IsDangerousObject(md)
	-- Any bad or untyped object is presumed dangerous.
	if (not md) or (not md.ty) then return true; end
	local filts = dofs[md.ty];
	if filts then
		for _,filt in pairs(filts) do if filt(md) then return true; end end
	end
	filts = dofs["*"];
	if filts then
		for _,filt in pairs(filts) do if filt(md) then return true; end end
	end
	return nil;
end

--- Determine whether any feature on the given feature list is dangerous.
function RDXDB.ContainsDangerousFeature(featList)
	for _,feature in pairs(featList) do
		if RDXDB.IsDangerousFeature(feature) then return true; end
	end
	return nil;
end

--- Determine whether the given feature is dangerous.
function RDXDB.IsDangerousFeature(feat)
	return nil;
end
