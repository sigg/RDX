-- Highlights.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics LLC
--
-- THIS FILE CONTAINS CONTENT PROTECTED BY COPYRIGHT LAW AND INTERNATIONAL TREATY PROVISIONS.
-- DISTRIBUTION AND USE ARE BY THE TERMS OF A SEPARATE LICENSE.
--

---------------------------------------------------------------------------------
-- Graded highlight.
--
-- Show the given texture and grade its vertex color based on the underlying
-- unit's position in the given Sort.
---------------------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Highlight: Texture Map";
	title = VFLI.i18n("Texture: Map and Highlight");
	category = VFLI.i18n("Shaders");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not RDXUI.IsValidBoolVar(desc.flag, state) then
			VFL.AddError(errs, VFLI.i18n("Invalid flag variable")); return nil;
		end
		-- Verify our texture
		if (not desc.texture) or (not state:Slot("Texture_" .. desc.texture)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		if (not desc.color) or (not state:Slot("ColorVar_" .. desc.color)) then
			VFL.AddError(errs, VFLI.i18n("Invalid color variable")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local tname = RDXUI.ResolveTextureReference(desc.texture);
		local paintCode = [[
if ]] .. desc.flag .. [[ then
	]] .. tname .. [[:Show();
	]] .. tname .. [[:SetVertexColor(VFL.explodeRGBA(]] .. desc.color .. [[));
end
]];
		-- If there's not already a highlight preamble for this texture, add it.
		if not state:Slot("__Hlt_Preamble_" .. desc.texture) then
			state:AddSlot("__Hlt_Preamble_" .. desc.texture);
			state:Attach("EmitPaintPreamble", true, function(code) code:AppendCode([[
]] .. tname .. [[:Hide();
]]);
			end);
		end
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Show condition variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture"), state, "Texture_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end
		
		local color = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then color:SetSelection(desc.color); end
		
		function ui:GetDescriptor()
			return {
				feature = "Highlight: Texture Map";
				flag = flag:GetSelection();
				texture = texture:GetSelection(); 
				color = color:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "Highlight: Texture Map";
			flag = "true";
		};
	end;
});

RDX.RegisterFeature({
	name = "Texture: Colorizer";
	title = VFLI.i18n("Texture: Colorizer");
	category = VFLI.i18n("Shaders");
	multiple = true;
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
		if (not desc.color) or (not state:Slot("ColorVar_" .. desc.color)) then
			VFL.AddError(errs, VFLI.i18n("Invalid color variable")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local tname = RDXUI.ResolveTextureReference(desc.texture);
		local paintCode = [[
]] .. tname .. [[:SetVertexColor(VFL.explodeRGBA(]] .. desc.color .. [[));
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture"), state, "Texture_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end
		
		local color = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then color:SetSelection(desc.color); end
		
		function ui:GetDescriptor()
			return {
				feature = "Texture: Colorizer";
				texture = texture:GetSelection(); 
				color = color:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "Texture: Colorizer";
		};
	end;
});

RDX.RegisterFeature({
	name = "shader_applytex"; version = 1;
	title = VFLI.i18n("Texture: Map"); 
	category = VFLI.i18n("Shaders");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.texture and desc.owner then
			desc.texture = desc.owner;
			desc.owner = nil;
		end
		if (not desc.texture) or (not state:Slot("Texture_" .. desc.texture)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		if (not desc.var) then VFL.AddError(errs, VFLI.i18n("Invalid texture variable")); return nil; end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local tname = RDXUI.ResolveTextureReference(desc.texture);
		local paintCode = [[
]] .. tname .. [[:SetTexture(]] .. desc.var .. [[);
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture"), state, "Texture_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end

		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture variable"), state, "TexVar_");
		if desc and desc.var then flag:SetSelection(desc.var); end
		
		function ui:GetDescriptor()
			return {
				feature = "shader_applytex"; version = 1;
				texture = texture:GetSelection();
				var = flag:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "shader_applytex"; version = 1;
		};
	end;
});

------------------------------
-- Show/Hide Texture shader
------------------------------
RDX.RegisterFeature({
	name = "shaderTex_showhide"; version = 1;
	title = VFLI.i18n("Texture: Show/Hide");
	category = VFLI.i18n("Shaders");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.texture and desc.owner then
			desc.texture = desc.owner;
			desc.owner = nil;
		end
		if (not desc.texture) or (not state:Slot("Texture_" .. desc.texture)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		if not desc.flag then desc.flag = "true"; end
		if not (desc.flag == "true" or desc.flag == "false" or state:Slot("BoolVar_" .. desc.flag)) then
			VFL.AddError(errs, VFLI.i18n("Invalid flag variable")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local tname = RDXUI.ResolveTextureReference(desc.texture);
		local inverse = "";
		if desc.inverse then inverse = "not "; end
		local paintCode = [[
if ]] .. inverse .. desc.flag .. [[ then ]] .. tname .. [[:Show(); else ]] .. tname .. [[:Hide(); end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture"), state, "Texture_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end

		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Flag variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end
		
		local chk_inverse = VFLUI.Checkbox:new(ui); chk_inverse:Show();
		chk_inverse:SetText(VFLI.i18n("Inverse variable"));
		if desc and desc.inverse then chk_inverse:SetChecked(true); else chk_inverse:SetChecked(); end
		ui:InsertFrame(chk_inverse);
		
		function ui:GetDescriptor()
			return {
				feature = "shaderTex_showhide"; version = 1;
				texture = texture:GetSelection();
				flag = flag:GetSelection();
				inverse = chk_inverse:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "shaderTex_showhide"; version = 1;
			owner = "Base"; flag = "true";
		};
	end;
});

