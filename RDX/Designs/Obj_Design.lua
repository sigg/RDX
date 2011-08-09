-- Obj_Design.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Setup and generative code for feature-based UnitFrames.

-------------------------------------------
-- UNITFRAME EDITOR
-- just a modified feature editor for unitframe
-------------------------------------------
RDX.IsDesignEditorOpen = RDXIE.IsFeatureEditorOpen;

function RDX.DesignEditor(state, callback, augText, parent)
	local dlg = RDXIE.FeatureEditor(state, callback, augText, parent);
	if not dlg then return nil; end
	
	RDX.TogglePreviewWindow(dlg);
	
	------ Close procedure
	dlg.Destroy = VFL.hook(function(s)
		RDX.ClosePreviewWindow();
	end, dlg.Destroy);
end

----------------------------------------------------------------------
-- The UnitFrameType filetype
----------------------------------------------------------------------
local dState = RDX.DesignState:new();

local function EditDesign(parent, path, md)
	if RDX.IsDesignEditorOpen() then return; end
	dState:LoadDescriptor(md.data, path);
	RDX.DesignEditor(dState, function(x)
		md.data = x:GetDescriptor();
		RDXDB.NotifyUpdate(path);
	end, path, parent);
end

RDXDB.RegisterObjectType({
	name = "Design";
	isFeatureDriven = true;
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		EditDesign(parent, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});

RDXDB.RegisterObjectType({
	name = "UnitFrameType";
	isFeatureDriven = true;
	version = 2;
	VersionMismatch = function(md)
		md.version = 1;
		md.ty = "Design";
	end,
});

RDXDB.RegisterObjectType({
	name = "ArtFrameType";
	isFeatureDriven = true;
	version = 2;
	VersionMismatch = function(md)
		md.version = 1;
		md.ty = "Design";
	end,
});
