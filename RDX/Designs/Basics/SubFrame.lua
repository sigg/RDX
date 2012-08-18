

----------------------------------------------------------
-- A sub-frame for layering and aligning texture objects.
----------------------------------------------------------
RDX.RegisterFeature({
	name = "Subframe";
	title = VFLI.i18n("Frame");
	category = VFLI.i18n("Basics");
	multiple = true;
	version = 1;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not RDXUI.UFLayoutCheck(desc, state, errs) then return nil; end
		if desc.flOffset < 1 then desc.flOffset = 1 end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop); end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then 
			state:AddSlot("Frame_" .. desc.name);
			if desc.usebkd then
				state:AddSlot("Bkdp_" .. desc.name);
			end
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		
		local createCode = [[
local _f = VFLUI.AcquireFrame("Frame");
_f:SetParent(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
_f:SetFrameLevel(frame:GetFrameLevel() + (]] .. desc.flOffset .. [[));
_f:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
_f:SetWidth(]] .. desc.w .. [[); _f:SetHeight(]] .. desc.h .. [[);
_f:Show();
]];
		if desc.usebkd then
			createCode = createCode .. [[
VFLUI.SetBackdrop(_f, ]] .. Serialize(desc.bkd) .. [[);
]];
		end
		createCode = createCode .. [[
frame.]] .. objname .. [[ = _f;
]];
		local destroyCode = [[
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[=nil;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", "StatusBar_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local ed_flOffset = VFLUI.LabeledEdit:new(ui, 50); ed_flOffset:Show();
		ed_flOffset:SetText(VFLI.i18n("FrameLevel offset"));
		if desc and desc.flOffset then ed_flOffset.editBox:SetText(desc.flOffset); end
		ui:InsertFrame(ed_flOffset);
		
		local chk_er = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Add Backdrop"));
		local bkd = VFLUI.MakeBackdropSelectButton(chk_er, desc.bkd); bkd:Show();
		chk_er:EmbedChild(bkd); chk_er:Show();
		if desc and desc.usebkd then chk_er:SetChecked(true); else chk_er:SetChecked(); end
		ui:InsertFrame(chk_er);

		function ui:GetDescriptor()
			local a = ed_flOffset.editBox:GetNumber(); if not a then a=1; end a = VFL.clamp(a, 1, 50);
			return { 
				feature = "Subframe";
				owner = owner:GetSelection();
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				flOffset = a;
				usebkd = chk_er:GetChecked();
				bkd = bkd:GetSelectedBackdrop();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Subframe"; name = "subframe1"; owner = "decor"; w = 90; h = 14; anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0}; flOffset = 1; bkd = VFL.copy(VFLUI.defaultBackdrop); };
	end;
});
