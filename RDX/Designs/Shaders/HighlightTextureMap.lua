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

RDX.RegisterFeature({
	name = "Shader: Texture Transform";
	title = VFLI.i18n("Shader: Texture Transform");
	category = VFLI.i18n("Shaders");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		--if not desc.flag then desc.flag = "true"; end
		--if not RDXUI.IsValidBoolVar(desc.flag, state) then
		--	VFL.AddError(errs, VFLI.i18n("Invalid flag variable")); return nil;
		--end
		-- Verify our texture
		if (not desc.texture) or (not state:Slot("Texture_" .. desc.texture)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		-- Verify our blend fraction
		--if (not desc.frac) or (not state:Slot("FracVar_" .. desc.frac)) then
		--	VFL.AddError(errs, VFLI.i18n("Invalid blend fraction variable")); return nil;
		--end
		--if (not desc.color) or (not state:Slot("ColorVar_" .. desc.color)) then
		--	VFL.AddError(errs, VFLI.i18n("Invalid color variable")); return nil;
		--end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = RDXUI.ResolveTextureReference(desc.texture);
		local paintCode = [[
--if ]] .. desc.flag .. [[ then
	]] .. objname .. [[:Show();
	--]] .. objname .. [[:SetWidth(VFL.lerp1(]] .. desc.frac .. "," .. desc.w1 .. "," .. desc.w2 .. [[));
	--]] .. objname .. [[:SetHeight(VFL.lerp1(]] .. desc.frac .. "," .. desc.h1 .. "," .. desc.h2 .. [[));
	]] .. objname .. [[:SetTexCoord(]] .. desc.l1 .. "," .. desc.l2 .. "," .. desc.r1 .. "," .. desc.r2 .. "," .. desc.b1 .. "," .. desc.b2 .. "," .. desc.t1 .. "," .. desc.t2 .. [[);
	--]] .. objname .. [[:SetVertexColor(VFL.explodeRGBA(]] .. desc.color .. [[));
--else
--	]] .. objname .. [[:Hide();
--end
]];
		local cleanupCode = [[
--]] .. objname .. [[:Hide();
]];
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode(cleanupCode); end);
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		--local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Show condition variable"), state, "BoolVar_", nil, "true", "false");
		--if desc and desc.flag then flag:SetSelection(desc.flag); end

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture"), state, "TexVar_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end

		--local frac = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Fraction variable"), state, "FracVar_");
		--if desc and desc.frac then frac:SetSelection(desc.frac); end
		
		--local color = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		--if desc and desc.color then color:SetSelection(desc.color); end
		
		--local wh1 = NEditor(ui, 2, VFLI.i18n("Empty width/height"), 50);
		--if desc then wh1:SetNumbers(desc.w1, desc.h1); end
		--ui:InsertFrame(wh1);

		--local wh2 = NEditor(ui, 2, VFLI.i18n("Full width/height"), 50);
		--if desc then wh2:SetNumbers(desc.w2, desc.h2); end
		--ui:InsertFrame(wh2);

		local tc1 = NEditor(ui, 4, VFLI.i18n("Empty texcoords (l,b,r,t)"), 50);
		if desc then tc1:SetNumbers(desc.l1, desc.b1, desc.r1, desc.t1); end
		ui:InsertFrame(tc1);

		local tc2 = NEditor(ui, 4, VFLI.i18n("Full texcoords (l,b,r,t)"), 50);
		if desc then tc2:SetNumbers(desc.l2, desc.b2, desc.r2, desc.t2); end
		ui:InsertFrame(tc2);

		function ui:GetDescriptor()
			--local w1,h1 = wh1:GetNumbers(0.1, 1000);
			--local w2,h2 = wh2:GetNumbers(0.1, 1000);
			local l1,b1,r1,t1 = tc1:GetNumbers(0, 1);
			local l2,b2,r2,t2 = tc2:GetNumbers(0, 1);
			return {
				feature = "Shader: Texture Transform";
				--flag = flag:GetSelection();
				texture = texture:GetSelection(); 
				--frac = frac:GetSelection(); 
				--color = color:GetSelection();
				--w1 = w1; h1 = h1; w2 = w2; h2 = h2;
				l1 = l1; r1 = r1; b1 = b1; t1 = t1;
				l2 = l2; r2 = r2; b2 = b2; t2 = t2;
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "Shader: Texture Transform";
			--flag = "true";
			--w1 = 0.1; h1 = 14; w2 = 90; h2 = 14;
			l1 = 0; r1 = 0; b1 = 0; t1 = 1;
			l2 = 0; r2 = 1; b2 = 0; t2 = 1;
		};
	end;
});
