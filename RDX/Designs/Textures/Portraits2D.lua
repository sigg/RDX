-- Portraits.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Support for portraits on unit frames.

----------- 2D Portrait
RDX.RegisterFeature({
	name = "portrait_2d"; version = 1; multiple = true;
	title = VFLI.i18n("Texture: 2D Portrait"); 
	category = VFLI.i18n("Shaders");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		-- Verify our texture
		if (not desc.texture) or (not state:Slot("Texture_" .. desc.texture)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Texture_" .. desc.texture;

		-- Event hinting.
		local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		mask = mux:GetPaintMask("PORTRAIT");
		mux:Event_UnitMask("UNIT_PORTRAIT_UPDATE", mask);
		mask = bit.bor(mask, 1);

		-- Painting
		local paintCode = [[
if band(paintmask, ]] .. mask .. [[) ~= 0 then
	SetPortraitTexture(frame.]] .. objname .. [[, uid);
end
]];
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Apply portrait to texture"), state, "Texture_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end

		function ui:GetDescriptor()
			return { 
				feature = "portrait_2d"; version = 1;
				texture = texture:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "portrait_2d"; version = 1; 
		};
	end;
});
