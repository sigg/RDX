

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
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not RDXUI.UFLayoutCheck(desc, state, errs) then return nil; end
		if desc.flOffset < 1 then desc.flOffset = 1 end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then 
			state:AddSlot("Subframe_" .. desc.name);
			state:AddSlot("Frame_" .. desc.name);
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
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
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

		function ui:GetDescriptor()
			local a = ed_flOffset.editBox:GetNumber(); if not a then a=1; end a = VFL.clamp(a, 1, 50);
			return { 
				feature = "Subframe";
				owner = owner:GetSelection();
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				flOffset = a; 
				anchor = anchor:GetAnchorInfo();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Subframe"; name = "subframe"; owner = "decor"; w = 90; h = 14; anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0}, flOffset = 1};
	end;
});

RDX.RegisterFeature({
	name = "artSubframe";
	version = 2;
	multiple = true;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "Subframe"; desc.version = 1;
	end;
});