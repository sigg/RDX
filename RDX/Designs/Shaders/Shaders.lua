-- Shaders.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- "Shaders" are independent pieces of code that change the way unit frames are
-- painted.

------------------------------
-- Show/Hide Element shader
------------------------------
RDX.RegisterFeature({
	name = "shader_showhide"; version = 1;
	title = VFLI.i18n("Frame: Show/Hide");
	category = VFLI.i18n("Shaders");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not desc.flag then desc.flag = "true"; end
		if not (desc.flag == "true" or desc.flag == "false" or state:Slot("BoolVar_" .. desc.flag)) then
			VFL.AddError(errs, VFLI.i18n("Invalid flag variable")); return nil;
		end
		local flg = true;
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local fname = RDXUI.ResolveFrameReference(desc.owner);
		local inverse = "";
		if desc.inverse then inverse = "not "; end
		local paintCode = [[
if ]] .. inverse .. desc.flag .. [[ then ]] .. fname .. [[:Show(); else ]] .. fname .. [[:Hide(); end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("frame"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Flag variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end
		
		local chk_inverse = VFLUI.Checkbox:new(ui); chk_inverse:Show();
		chk_inverse:SetText(VFLI.i18n("Inverse variable"));
		if desc and desc.inverse then chk_inverse:SetChecked(true); else chk_inverse:SetChecked(); end
		ui:InsertFrame(chk_inverse);
		
		function ui:GetDescriptor()
			return {
				feature = "shader_showhide"; version = 1;
				owner = owner:GetSelection();
				flag = flag:GetSelection();
				inverse = chk_inverse:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "shader_showhide"; version = 1;
			owner = "decor"; flag = "true";
		};
	end;
});





