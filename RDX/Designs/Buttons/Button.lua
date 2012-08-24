-- Button.lua
-- OpenRDX
-- Sigg Rashgarroth EU

RDX.RegisterFeature({
	name = "artbutton"; version = 1; 
	title = VFLI.i18n("Button Script"); 
	category = VFLI.i18n("Buttons");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Button_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Button_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Button_" .. desc.name;
		if not desc.editor then desc.editor = ""; end

		------------------ On frame creation
		local createCode = [[
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
btn = VFLUI.AcquireFrame("Button");
btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
btn:Show();
btn:RegisterForClicks("AnyUp");
btn:SetScript("OnClick", function() ]] .. desc.editor .. [[ end);
]];
		if desc.gt then
		local gtType = __RDX_GetGameTooltipType(desc.gt);
		createCode = createCode .. [[
btn:SetScript("OnEnter", ]] .. gtType .. [[);
btn:SetScript("OnLeave", __RDX_OnLeave);
]];
		end
		createCode = createCode .. [[
frame.]] .. objname .. [[ = btn;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		if desc.gt and desc.gt ~= "" then
		------------------- Paint
			local paintCode = [[
frame.]] .. objname .. [[.gtid = ]] .. desc.gt .. [[;
]];
			state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);
		end
		
		------------------ On frame destruction.
		local destroyCode = [[
frame.]] .. objname .. [[.gtid = nil;
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("GameTooltip parameters")));
		
		local gt = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("GameTooltip"), state, "GameTooltips_");
		if desc and desc.gt then gt:SetSelection(desc.gt); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Script parameters")));

		local editor = VFLUI.TextEditor:new(ui, "LuaEditBox");
		editor:SetHeight(200); editor:Show();
		editor:SetText(desc.editor or "");
		editor:GetEditWidget():SetFocus();
		ui:InsertFrame(editor);
		
		function ui:GetDescriptor()
			return { 
				feature = "artbutton"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				editor = editor:GetText();
				gt = gt:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "artbutton"; version = 1; 
			name = "btn1", owner = "Frame_decor", drawLayer = "ARTWORK";
			w = 30; h = 30;
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
		};
	end;
});

-- TODO one day
RDX.RegisterFeature({
	name = "buttonspell"; version = 1; 
	title = VFLI.i18n("Button Spell"); 
	category = VFLI.i18n("Buttons");
	invisible = true;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Button_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Button_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Button_" .. desc.name;
		if not desc.editor then desc.editor = ""; end

		------------------ On frame creation
		local createCode = [[
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
btn = VFLUI.AcquireFrame("Button");
btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
btn:Show();
btn:RegisterForClicks("AnyUp");
btn:SetScript("OnClick", function() ]] .. desc.editor .. [[ end);
frame.]] .. objname .. [[ = btn;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Script parameters")));

		local editor = VFLUI.TextEditor:new(ui, "LuaEditBox");
		editor:SetHeight(200); editor:Show();
		editor:SetText(desc.editor or "");
		editor:GetEditWidget():SetFocus();
		ui:InsertFrame(editor);
		
		function ui:GetDescriptor()
			return { 
				feature = "artbutton"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				editor = editor:GetText();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "buttonspell"; version = 1; 
			name = "btns1", owner = "Frame_decor", drawLayer = "ARTWORK";
			w = 30; h = 30;
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
		};
	end;
});

