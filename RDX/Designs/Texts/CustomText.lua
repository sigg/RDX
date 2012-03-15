
RDX.RegisterFeature({
	name = "txt_custom";
	version = 1;
	multiple = true;
	title = VFLI.i18n("Text Custom");
	category = VFLI.i18n("Texts");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Text_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then 
			state:AddSlot("Text_" .. desc.name);
			state:AddSlot("TextCustom_" .. desc.name);
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

		-- Apply the custom code.
		local md,_,_,ty = RDXDB.GetObjectData(desc.script);
		if (md) and (ty == "Script") and (md.data) and ( md.data.script) then
			local paintCode = [[
text = ]] .. (desc.useNil and 'nil' or '""') .. [[;

]] .. md.data.script .. [[

if text then ]] .. tname .. [[:SetText(text); 
	if ]] .. colorBoo .. [[ then ]] .. tname .. [[:SetTextColor(explodeRGBA(]] ..colorVar .. [[)); end 
end
]];
			state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		end
		
		--state:Attach(state:Slot("EmitClosure"), true, function(code) code:AppendCode(closureCode); end);
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

		local chk_useNil = VFLUI.Checkbox:new(ui); 
		chk_useNil:Show(); chk_useNil:SetText(VFLI.i18n("Preserve existing content if text local variable is undefined"))
		if desc and desc.useNil then chk_useNil:SetChecked(true); end
		ui:InsertFrame(chk_useNil);

		local scriptsel = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Script")); end);
		scriptsel:SetLabel(VFLI.i18n("Script")); scriptsel:Show();
		if desc and desc.script then scriptsel:SetPath(desc.script); end
		ui:InsertFrame(scriptsel);
		
		local colorVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then colorVar:SetSelection(desc.color); end 

		function ui:GetDescriptor()
			local scolorVar = strtrim(colorVar:GetSelection() or "");
			if scolorVar == "" then scolorVar = nil; end 
			return { 
				feature = "txt_custom"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				font = fontsel:GetSelectedFont();
				useNil = chk_useNil:GetChecked();
				script = scriptsel:GetPath();
				color = scolorVar;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "txt_custom", version = 1,
			name = "customText", w = 50, h = 14, owner = "decor",
			anchor = { lp = "LEFT", af = "Base", rp = "LEFT", dx = 0, dy = 0 }, 
			font = VFL.copy(Fonts.Default);
		};
	end;
});

RDX.RegisterFeature({
	name = "txtart_custom";
	version = 2;
	multiple = true;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "txt_custom"; desc.version = 1;
	end;
});
