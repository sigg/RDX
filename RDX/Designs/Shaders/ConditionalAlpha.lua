-----------------------------------------------------------
-- Alpha shaders
-----------------------------------------------------------
RDX.RegisterFeature({
	name = "shader_ca"; version = 1;
	title = VFLI.i18n("Frame: Conditional Alpha");
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
		if not RDXUI.IsValidBoolVar(desc.flag, state) then
			VFL.AddError(errs, VFLI.i18n("Invalid flag variable.")); return nil;
		end
		if (not tonumber(desc.falseAlpha)) or (not tonumber(desc.trueAlpha)) then
			VFL.AddError(errs, VFLI.i18n("Invalid alpha values.")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local fname = RDXUI.ResolveFrameReference(desc.owner);
		local paintCode = [[
if ]] .. desc.flag .. [[ then
	]] .. fname .. [[:SetAlpha(]] .. desc.trueAlpha .. [[);
else
	]] .. fname .. [[:SetAlpha(]] .. desc.falseAlpha .. [[);
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Frame"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Flag variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end

		local falseAlpha = VFLUI.LabeledEdit:new(ui, 50); falseAlpha:Show();
		falseAlpha:SetText(VFLI.i18n("Alpha when false"));
		if desc and desc.falseAlpha then falseAlpha.editBox:SetText(desc.falseAlpha); end
		ui:InsertFrame(falseAlpha);

		local trueAlpha = VFLUI.LabeledEdit:new(ui, 50); trueAlpha:Show();
		trueAlpha:SetText(VFLI.i18n("Alpha when true"));
		if desc and desc.trueAlpha then trueAlpha.editBox:SetText(desc.trueAlpha); end
		ui:InsertFrame(trueAlpha);
		
		function ui:GetDescriptor()
			local fa, ta = VFL.clamp(falseAlpha.editBox:GetNumber(), 0, 1), VFL.clamp(trueAlpha.editBox:GetNumber(), 0, 1);
			return {
				feature = "shader_ca"; version = 1;
				owner = owner:GetSelection();
				flag = flag:GetSelection();
				falseAlpha = fa; trueAlpha = ta;
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "shader_ca"; version = 1;
			owner = "decor";
			flag = "true"; falseAlpha = 1; trueAlpha = 1;
		};
	end;
});
