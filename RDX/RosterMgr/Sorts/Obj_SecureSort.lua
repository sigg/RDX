-- Obj_SecureSort.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Glue code for the SecureSort object type.

-- Registration and controls for the Sort object type.
RDXDB.RegisterObjectType({
	name = "SecureSort",
	New = function(path, md)
		md.version = 1;
	end,
	Instantiate = function(path, obj)
		-- Sanity checks
		if not obj.data then return nil; end
		local d1, d2 = obj.data.set, obj.data.sort;
		-- Try to get our set.
		local set = RDXDAL.FindSet(d1);
		if not set then 
			VFL.TripError("RDX", VFLI.i18n("Could not instantiate sort at ") .. tostring(path), VFLI.i18n("Underlying set appears to be invalid."));
			return nil, VFLI.i18n("Could not instantiate set."); 
		end
		-- Make the sort
		local x = RDXDAL.Sort:new(); 
		x.name = path;
		if not x:Setup(d2, set, true) then
			VFL.TripError("RDX", VFLI.i18n("Could not instantiate sort at ") .. tostring(path), VFLI.i18n("Sort generation error, see other error logs for more info."));
			return nil;
		end
		return x;
	end,
	Edit = function(path, md, parent)
		RDXDAL.EditSortDialog(parent or VFLFULLSCREEN, path, md);
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit..."),
			OnClick = function() 
				VFL.poptree:Release(); 
				RDXDAL.EditSortDialog(dlg, path, md); 
			end
		});
		--if RDXU.devflag then
			table.insert(mnu, {
				text = VFLI.i18n("Transform Sort"),
				OnClick = function() 
					VFL.poptree:Release();
					local pkg, file = RDXDB.ParsePath(path);
					md.ty = "Sort";
					md.version = 2;
					RDXDBEvents:Dispatch("OBJECT_MOVED", pkg, file, pkg, file, md);
				end
			});
		--end
	end
});
