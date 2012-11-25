-- StatusBars.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Allows any Texture to be used as a StatusBar.


local function NEditor(ctr, nC, label, ew)
	label = label or ""; ew = ew or 50;
	
	local f = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(f, ctr);
	f:SetHeight(25);
	f.DialogOnLayout = VFL.Noop; f:Show();

	local t1 = VFLUI.CreateFontString(f);
	t1:SetFontObject(Fonts.Default10); t1:SetWidth(150); t1:SetHeight(25);
	t1:SetJustifyH("LEFT");
	t1:SetPoint("LEFT", f, "LEFT");
	t1:SetText(label); t1:Show();

	f.edit = {};
	local af = t1;
	for i=1,nC do
		local ed = VFLUI.Edit:new(f);
		ed:SetHeight(25); ed:SetWidth(ew);
		ed:SetPoint("LEFT", af, "RIGHT", 1, 0); ed:Show();
		af = ed; f.edit[i] = ed;
	end

	function f:SetNumbers(n1,n2,n3,n4)
		if n1 and self.edit[1] then self.edit[1]:SetText(n1); end
		if n2 and self.edit[2] then self.edit[2]:SetText(n2); end
		if n3 and self.edit[3] then self.edit[3]:SetText(n3); end
		if n4 and self.edit[4] then self.edit[4]:SetText(n4); end
	end
	
	function f:GetNumbers(cmin, cmax)
		local n = {};
		for i=1,nC do
			n[i] = VFL.clamp(self.edit[i]:GetNumber(), cmin, cmax);
		end
		return n[1], n[2], n[3], n[4];
	end

	f.Destroy = VFL.hook(function(s)
		s.SetNumbers = nil; s.GetNumbers = nil;
		for _,editor in pairs(s.edit) do editor:Destroy(); end
		VFLUI.ReleaseRegion(t1);
		s.edit = nil;
	end, f.Destroy);

	return f;
end


RDX.RegisterFeature({
	name = "StatusBar Texture Map";
	title = VFLI.i18n("Sh: Texture Map/Frac");
	category = VFLI.i18n("Shaders");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.flag then desc.flag = "true"; end
		if not RDXUI.IsValidBoolVar(desc.flag, state) then
			VFL.AddError(errs, VFLI.i18n("Invalid flag variable")); return nil;
		end
		-- Verify our texture
		if (not desc.texture) or (not state:Slot("TextureCustom_" .. desc.texture)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		-- Verify our blend fraction
		if (not desc.frac) or (not state:Slot("FracVar_" .. desc.frac)) then
			VFL.AddError(errs, VFLI.i18n("Invalid blend fraction variable")); return nil;
		end
		if (not desc.color) or (not state:Slot("ColorVar_" .. desc.color)) then
			VFL.AddError(errs, VFLI.i18n("Invalid color variable")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = RDXUI.ResolveTextureReference(desc.texture);
		local paintCode = [[
		if ]] .. desc.flag .. [[ then
			]] .. objname .. [[:Show();
			]] .. objname .. [[:SetWidth(VFL.lerp1(]] .. desc.frac .. "," .. desc.w1 .. "," .. desc.w2 .. [[));
			]] .. objname .. [[:SetHeight(VFL.lerp1(]] .. desc.frac .. "," .. desc.h1 .. "," .. desc.h2 .. [[));
			]] .. objname .. [[:SetTexCoord(VFL.lerp4(]] .. desc.frac .. "," .. desc.l1 .. "," .. desc.l2 .. "," .. desc.r1 .. "," .. desc.r2 .. "," .. desc.b1 .. "," .. desc.b2 .. "," .. desc.t1 .. "," .. desc.t2 .. [[));
			]] .. objname .. [[:SetVertexColor(explodeRGBA(]] .. desc.color .. [[));
		else
			]] .. objname .. [[:Hide();
		end
]];
		local cleanupCode = [[
	]] .. objname .. [[:Hide();
]];
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode(cleanupCode); end);
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Show condition variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture"), state, "TextureCustom_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end

		local frac = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Fraction variable"), state, "FracVar_");
		if desc and desc.frac then frac:SetSelection(desc.frac); end
		
		local color = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then color:SetSelection(desc.color); end
		
		local wh1 = NEditor(ui, 2, VFLI.i18n("Empty width/height"), 50);
		if desc then wh1:SetNumbers(desc.w1, desc.h1); end
		ui:InsertFrame(wh1);

		local wh2 = NEditor(ui, 2, VFLI.i18n("Full width/height"), 50);
		if desc then wh2:SetNumbers(desc.w2, desc.h2); end
		ui:InsertFrame(wh2);

		local tc1 = NEditor(ui, 4, VFLI.i18n("Empty texcoords (l,b,r,t)"), 50);
		if desc then tc1:SetNumbers(desc.l1, desc.b1, desc.r1, desc.t1); end
		ui:InsertFrame(tc1);

		local tc2 = NEditor(ui, 4, VFLI.i18n("Full texcoords (l,b,r,t)"), 50);
		if desc then tc2:SetNumbers(desc.l2, desc.b2, desc.r2, desc.t2); end
		ui:InsertFrame(tc2);

		function ui:GetDescriptor()
			local w1,h1 = wh1:GetNumbers(0.1, 1000);
			local w2,h2 = wh2:GetNumbers(0.1, 1000);
			local l1,b1,r1,t1 = tc1:GetNumbers(0, 1);
			local l2,b2,r2,t2 = tc2:GetNumbers(0, 1);
			return {
				feature = "StatusBar Texture Map";
				flag = flag:GetSelection();
				texture = texture:GetSelection(); frac = frac:GetSelection(); color = color:GetSelection();
				w1 = w1; h1 = h1; w2 = w2; h2 = h2;
				l1 = l1; r1 = r1; b1 = b1; t1 = t1;
				l2 = l2; r2 = r2; b2 = b2; t2 = t2;
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "StatusBar Texture Map";
			flag = "true";
			w1 = 0.1; h1 = 14; w2 = 90; h2 = 14;
			l1 = 0; r1 = 0; b1 = 0; t1 = 1;
			l2 = 0; r2 = 1; b2 = 0; t2 = 1;
		};
	end;
});

RDX.RegisterFeature({
	name = "Shader: Texture Transform";
	title = VFLI.i18n("Sh: Texture Coord");
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
		if (not desc.texture) or (not state:Slot("TextureCustom_" .. desc.texture)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = RDXUI.ResolveTextureReference(desc.texture);
		local paintCode = [[
		]] .. objname .. [[:SetTexCoord(]] .. desc.l1 .. "," .. desc.b1 .. "," .. desc.r1 .. "," .. desc.t1 .. [[);
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local texture = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture"), state, "TextureCustom_");
		if desc and desc.texture then texture:SetSelection(desc.texture); end

		local tc1 = NEditor(ui, 4, VFLI.i18n("Texcoords (l,b,r,t)"), 50);
		if desc then tc1:SetNumbers(desc.l1, desc.b1, desc.r1, desc.t1); end
		ui:InsertFrame(tc1);

		function ui:GetDescriptor()
			local l1,b1,r1,t1 = tc1:GetNumbers(0, 1);
			return {
				feature = "Shader: Texture Transform";
				texture = texture:GetSelection(); 
				l1 = l1; r1 = r1; b1 = b1; t1 = t1;
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "Shader: Texture Transform";
			l1 = 0; r1 = 1; b1 = 0; t1 = 1;
		};
	end;
});
