-- Filters.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Filters and Sorts related to the heal sync system.

------------------------------------------------------------------------
-- Healing Synchronization module for RDX
--   By: Trevor Madsen (Gibypri, Kilrogg realm)
--
-- Note:
--  Licensed exclusively to Raid Informatics
------------------------------------------------------------------------



-- HP% sort.
RDXDAL.RegisterSortOperator({
	name = "shpp";
	title = VFLI.i18n("Predicted HP%");
	category = VFLI.i18n("Status");
	EmitLocals = function(desc, code, vars)
		if not vars["hh"] then
			vars["hh"] = true;
			code:AppendCode([[
local hh1,hh2 = u1:FracSmartHealth(), u2:FracSmartHealth();
]]);
		end
	end;
	EmitCode = function(desc, code, context)
		code:AppendCode([[
if(hh1 == hh2) then
]]);
		RDXDAL._SortContinuation(context);
		code:AppendCode([[else
]]);
		if desc.reversed then
			code:AppendCode([[return hh1 > hh2;]]);
		else
			code:AppendCode([[return hh1 < hh2;]]);
		end
code:AppendCode([[
end
]]);
	end;
	GetUI = RDXDAL.TrivialSortUI("shpp", "Predicted HP%");
	GetBlankDescriptor = function() return {op = "shpp"}; end;
	Events = function(desc, ev) 
		ev["UNIT_HEALTH"] = true;
		ev["UNIT_INCOMING_HEALS"] = true;
	end;
});

-- HP sort.
RDXDAL.RegisterSortOperator({
	name = "shp";
	title = VFLI.i18n("Predicted HP");
	category = VFLI.i18n("Status");
	EmitLocals = function(desc, code, vars)
		if not vars["hnfh"] then
			vars["hnfh"] = true;
			code:AppendCode([[
local hnfh1,hnfh2 = u1:SmartHealth(), u2:SmartHealth();
]]);
		end
	end;
	EmitCode = function(desc, code, context)
		code:AppendCode([[
if(hnfh1 == hnfh2) then
]]);
		RDXDAL._SortContinuation(context);
		code:AppendCode([[else
]]);
		if desc.reversed then
			code:AppendCode([[return hnfh1 > hnfh2;]]);
		else
			code:AppendCode([[return hnfh1 < hnfh2;]]);
		end
code:AppendCode([[
end
]]);
	end;
	GetUI = RDXDAL.TrivialSortUI("shp", "Predicted HP");
	GetBlankDescriptor = function() return {op = "shp"}; end;
	Events = function(desc, ev) 
		ev["UNIT_HEALTH"] = true;
		ev["UNIT_INCOMING_HEALS"] = true;
	end;
});
