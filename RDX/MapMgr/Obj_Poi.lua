-- Obj_Design.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Setup and generative code for feature-based UnitFrames.


----------------------------------------------------------------------
-- The UnitFrameType filetype
----------------------------------------------------------------------


local function EditDesign(parent, path, md, offline)
	--if RDX.IsDesignEditorOpen() then return; end
	--dState:LoadDescriptor(md.data, path);
	--RDX.DesignEditor(dState, function(x)
	--	md.data = x:GetDescriptor();
	--	RDXDB.NotifyUpdate(path);
	--end, path, parent, offline);
end

RDXDB.RegisterObjectType({
	name = "Poi";
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent, offline)
		EditDesign(parent, path, md, offline);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function()
				VFL.poptree:Release();
				if IsShiftKeyDown() then
					RDXDB.OpenObject(upath, "Edit", dlg, true);
				else
					RDXDB.OpenObject(path, "Edit", dlg);
				end
			end
		});
	end;
});

