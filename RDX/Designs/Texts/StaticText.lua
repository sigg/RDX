
RDX.RegisterFeature({
	name = "txt_static";
	version = 1;
	multiple = true;
	title = VFLI.i18n("Text Static");
	category = VFLI.i18n("Texts");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if (not desc.txt) then
			VFL.AddError(errs, VFLI.i18n("Invalid texte")); return nil;
		end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Text_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then 
			state:AddSlot("Text_" .. desc.name);
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		if not VFLUI.isFacePathExist(desc.font.face) then desc.font.face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf"; end
		local tname = RDXUI.ResolveTextReference(desc.name);
		local colorVar, colorBoo = strtrim(desc.color or ""), "false";
		if colorVar ~= "" then colorBoo = "true"; end
		
		---- Generate the code.
		local createCode = [[
local txt = VFLUI.CreateFontString(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
txt:SetWidth(]] .. desc.w .. [[); txt:SetHeight(]] .. desc.h .. [[);
txt:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
]] .. VFLUI.GenerateSetFontCode("txt", desc.font, nil, true) .. [[
txt:Show();
]] .. tname .. [[ = txt;
]];
		local destroyCode = [[
]] .. tname .. [[:Destroy(); 
]] .. tname .. [[ = nil;
]];
		local cleanupCode = [[
]] .. tname .. [[:SetText("");
]];
		-- Apply the static text
		local paintCode = [[
]] .. tname .. [[:SetText("]] .. desc.txt .. [[");
if ]] .. colorBoo .. [[ then
	]] .. tname .. [[:SetTextColor(VFL.explodeRGBA(]] .. colorVar .. [[));
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode(cleanupCode); end);
		
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er, desc.font); fontsel:Show();
		er:EmbedChild(fontsel); er:Show();
		ui:InsertFrame(er);

		local txt = VFLUI.LabeledEdit:new(ui, 200);
		txt:SetText(VFLI.i18n("Text Static"));
		txt:Show();
		if desc and desc.txt then txt.editBox:SetText(desc.txt); end
		ui:InsertFrame(txt);
		
		local colorVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then colorVar:SetSelection(desc.color); end

		function ui:GetDescriptor()
			local scolorVar = strtrim(colorVar:GetSelection() or "");
			if scolorVar == "" then scolorVar = nil; end
			return { 
				feature = "txt_static"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				font = fontsel:GetSelectedFont();
				txt =  txt.editBox:GetText();
				color = scolorVar;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "txt_static", version = 1,
			name = "staticText", w = 50, h = 14, owner = "decor",
			anchor = { lp = "LEFT", af = "Base", rp = "LEFT", dx = 0, dy = 0 }, 
			font = VFL.copy(Fonts.Default);
		};
	end;
});
