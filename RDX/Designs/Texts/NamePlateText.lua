-- Text.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Unit frame features that add text to various places on the unit frame.

-------------------- NAMEPLATE
RDX.RegisterFeature({
	name = "txt_np"; version = 1; multiple = true;
	title = VFLI.i18n("Text Nameplate");
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
		state:AddSlot("Text_" .. desc.name);
		return flg;
	end;
	ApplyFeature = function(desc, state)
		if not VFLUI.isFacePathExist(desc.font.face) then desc.font.face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf"; end
		local tname = RDXUI.ResolveTextReference(desc.name);

		-- Text
		local textExpr;
		if desc.trunc then
			textExpr = "unit:GetProperName():sub(1, " .. desc.trunc .. ")";
		else
			textExpr = "unit:GetProperName()";
		end
		
		-- Color
		local colorclassBoo, colorVar, colorBoo = "false", strtrim(desc.color or ""), "false";
		if desc.classColor then colorclassBoo = "true"; end
		if colorVar ~= "" then colorBoo = "true"; end

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
]] .. tname .. [[:SetTextColor(1,1,1,1);
]];

		local paintCode = [[
if UnitExists(uid) then
	]] .. tname .. [[:SetText(]] .. textExpr .. [[);
else
	]] .. tname .. [[:SetText("");
end
if ]] .. colorclassBoo .. [[ then
	]] .. tname .. [[:SetTextColor(VFL.explodeColor(unit:GetClassColor()));
end

if ]] .. colorBoo .. [[ then
	]] .. tname .. [[:SetTextColor(VFL.explodeRGBA(]] .. colorVar .. [[));
end

]];

		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode(cleanupCode); end);
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		
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

		local ed_trunc = VFLUI.LabeledEdit:new(ui, 50); ed_trunc:Show();
		ed_trunc:SetText(VFLI.i18n("Max name length (blank = no truncation)"));
		if desc and desc.trunc then ed_trunc.editBox:SetText(desc.trunc); end
		ui:InsertFrame(ed_trunc);

		local chk_colorclass = VFLUI.Checkbox:new(ui); chk_colorclass:Show();
		chk_colorclass:SetText(VFLI.i18n("Use class color"));
		if desc and desc.classColor then chk_colorclass:SetChecked(true); else chk_colorclass:SetChecked(); end
		ui:InsertFrame(chk_colorclass);
		
		local colorVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.color then colorVar:SetSelection(desc.color); end

		function ui:GetDescriptor()
			local trunc = tonumber(ed_trunc.editBox:GetText());
			if trunc then trunc = VFL.clamp(trunc, 1, 50); end
			local scolorVar = strtrim(colorVar:GetSelection() or "");
			if scolorVar == "" then
				scolorVar = nil;
			end
			return { 
				feature = "txt_np"; version = 1;
				trunc = trunc;
				classColor = chk_colorclass:GetChecked();
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				font = fontsel:GetSelectedFont();
				color = scolorVar;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "txt_np"; version = 1;
			name = "np", w = 50, h = 14, owner = "decor",
			anchor = { lp = "LEFT", af = "Base", rp = "LEFT", dx = 0, dy = 0 };
			font = VFL.copy(Fonts.Default); 
		};
	end;
});



