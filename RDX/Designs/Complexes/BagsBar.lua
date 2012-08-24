-- BagsBar.lua
-- OpenRDX
-- Sigg Rashgarroth EU

local function _EmitCreateCode(objname, desc)
	desc.nIcons = #RDX.BlizzardBagsButtons;
	desc.rows = 1;
	local onebag = "nil"; if desc.onebag then onebag = "true"; end
	local createCode = [[
frame.]] .. objname .. [[ = {};
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
local error;
for i=1, ]] .. desc.nIcons .. [[ do
	btn = VFLUI.AcquireFrame("BlizzardElement", RDX.BlizzardBagsButtons[i]);
	if btn then
		btn:SetParent(btnOwner);
		btn:SetFrameLevel(btnOwner:GetFrameLevel());
		--btn:SetHeight(36); btn:SetWidth(19);
		btn:Show();
	else
		error = true;
	end
	frame.]] .. objname .. [[[i] = btn;
end
if error then
	RDX.printE("BlizzardMicroButtons already used");
else
]];
	createCode = createCode .. RDXUI.LayoutCodeMultiRows(objname, desc);
	createCode = createCode .. [[
end
]];
	return createCode;
end

local _orientations = {
	{ text = "LEFT"},
	{ text = "RIGHT"},
	{ text = "DOWN"},
	{ text = "UP"},
};
local function _dd_orientations() return _orientations; end

-------------------------------------
-- Bags bar
-------------------------------------

RDX.RegisterFeature({
	name = "bagsbar";
	version = 1;
	title = VFLI.i18n("Blizzard Bags");
	category = VFLI.i18n("Complexes");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Icons_" .. desc.name;
		------------------ On frame creation

		local createCode = _EmitCreateCode(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);
		
		------------------ On frame destruction.
		local destroyCode = [[
local btn = nil;
for i=1, ]] .. desc.nIcons .. [[ do
	btn = frame.]] .. objname .. [[[i];
	if btn then btn:Destroy(); btn = nil; end
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation"));
		local dd_orientation = VFLUI.Dropdown:new(er, _dd_orientations);
		dd_orientation:SetWidth(75); dd_orientation:Show();
		if desc and desc.orientation then 
			dd_orientation:SetSelection(desc.orientation); 
		else
			dd_orientation:SetSelection("RIGHT");
		end
		er:EmbedChild(dd_orientation); er:Show();
		ui:InsertFrame(er);
		
		local ed_iconspx = VFLUI.LabeledEdit:new(ui, 50); ed_iconspx:Show();
		ed_iconspx:SetText(VFLI.i18n("Width spacing"));
		if desc and desc.iconspx then ed_iconspx.editBox:SetText(desc.iconspx); else ed_iconspx.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspx);
		
		local ed_iconspy = VFLUI.LabeledEdit:new(ui, 50); ed_iconspy:Show();
		ed_iconspy:SetText(VFLI.i18n("Height spacing"));
		if desc and desc.iconspy then ed_iconspy.editBox:SetText(desc.iconspy); else ed_iconspy.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspy);
		
		local chk_onebag = VFLUI.Checkbox:new(ui); chk_onebag:Show();
		chk_onebag:SetText(VFLI.i18n("Show only one bag"));
		if desc and desc.onebag then chk_onebag:SetChecked(true); else chk_onebag:SetChecked(); end
		ui:InsertFrame(chk_onebag);
		
		function ui:GetDescriptor()
			return { 
				feature = "bagsbar"; version = 1;
				name = "bbar";
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), -10, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), -25, 200);
				onebag = chk_onebag:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "bagsbar"; version = 1; 
			name = "bbar"; owner = "Frame_decor";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			orientation = "RIGHT"; iconspx = 2; iconspy = 0;
		};
	end;
});



