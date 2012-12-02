-- Portraits.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Support for portraits on unit frames.

-- Modify by Joeba18

-- Global function to set a model to camera zero
--function SetCameraZero(self) self:SetCamera(0); end
--function SetCameraOne(self) self:SetCamera(1); end

function SetCameraZero(self) self:SetPortraitZoom(1); end
function SetCameraOne(self) self:SetCamera(1); end

local _types = {
	{ text = "SetCameraZero" },
	{ text = "SetCameraOne" },
};
local function _dd_cameratypes() return _types; end

RDX.RegisterFeature({
	name = "portrait_3d";
	version = 31338;
	invisible = true;
	title = VFLI.i18n("Indicator");
	category = VFLI.i18n("Textures");
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "portrait_3d2";
		desc.unit = "default";
	end;
});

local units = {
    { text = "default" },
	{ text = "player" },
	{ text = "target" },
	{ text = "focus" },
	{ text = "pet" },
};
local function unitSel() return units; end

RDX.RegisterFeature({
	name = "portrait_3d2"; version = 1; multiple = true;
	title = VFLI.i18n("Blizzard 3D Portrait");
	category = VFLI.i18n("Complexes");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then 
			state:AddSlot("Frame_" .. desc.name);
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		local id = math.random(10000000);
		local camera = "SetCameraZero";
		if desc and desc.cameraType then camera = desc.cameraType; end
		local unit = "player";
		if desc and desc.unit then unit = desc.unit; end

		-- Creation/destruction
		local createCode = [[
	local _f = VFLUI.AcquireFrame("PlayerModel");
	VFLUI.StdSetParent(_f, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[, ]] .. desc.flOffset .. [[);
	_f:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	_f:SetWidth(]] .. desc.w .. [[); _f:SetHeight(]] .. desc.h .. [[);
	_f:Show();
	
	local uu = "player";
	
	_f.rdxupdate =  function()
		_f:SetUnit(uu);
		]].. camera ..[[(_f);
		if UnitIsVisible(uu) then 
			_f:Show();
		else
			_f:Hide();
		end
	end
]];
	if unit == "default" then
		createCode = createCode .. [[
	uu = frame:GetAttribute("unit") or "player";
	WoWEvents:Bind("UNIT_PORTRAIT_UPDATE", nil, function(uid) if uid == "uu" then _f.rdxupdate(); end; end, "]] .. id .. [[");
	WoWEvents:Bind("PLAYER_TARGET_CHANGED", nil, _f.rdxupdate, "]] .. id .. [[");
	WoWEvents:Bind("PLAYER_FOCUS_CHANGED", nil, _f.rdxupdate, "]] .. id .. [[");
]];
	elseif unit == "player" then
		createCode = createCode .. [[
	uu = "player";
	WoWEvents:Bind("UNIT_PORTRAIT_UPDATE", nil, function(uid) if uid == "player" or uid == "vehicle" then _f.rdxupdate(); end; end, "]] .. id .. [[");
]];
	elseif unit == "pet" then
		createCode = createCode .. [[
	uu = "pet";
	WoWEvents:Bind("UNIT_PORTRAIT_UPDATE", nil, function(uid) if uid == "pet" or uid == "vehicle" then _f.rdxupdate(); end; end, "]] .. id .. [[");
]];
	elseif unit == "target" then
		createCode = createCode .. [[
	uu = "target";
	WoWEvents:Bind("PLAYER_TARGET_CHANGED", nil, _f.rdxupdate, "]] .. id .. [[");
]];
	elseif unit == "focus" then
		createCode = createCode .. [[
	uu = "focus";
	WoWEvents:Bind("PLAYER_FOCUS_CHANGED", nil, _f.rdxupdate, "]] .. id .. [[");
]];
	end
		createCode = createCode .. [[
	VFLT.schedule(1, _f.rdxupdate);
	frame.]] .. objname .. [[ = _f;
]];
		local destroyCode = [[
		WoWEvents:Unbind("]] .. id .. [[");
		frame.]] .. objname .. [[.rdxupdate = nil;
		frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local er = VFLUI.EmbedRight(ui, "Unit");
		local dd_unit = VFLUI.Dropdown:new(er, unitSel);
		dd_unit:SetWidth(100); dd_unit:Show();
		if desc and desc.unit then dd_unit:SetSelection(desc.unit); end
		er:EmbedChild(dd_unit); er:Show();
		ui:InsertFrame(er);

		local ed_flOffset = VFLUI.LabeledEdit:new(ui, 50); ed_flOffset:Show();
		ed_flOffset:SetText(VFLI.i18n("FrameLevel offset"));
		if desc and desc.flOffset then ed_flOffset.editBox:SetText(desc.flOffset); end
		ui:InsertFrame(ed_flOffset);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Camera Type"));
		local dd_cameraType = VFLUI.Dropdown:new(er, _dd_cameratypes);
		dd_cameraType:SetWidth(200); dd_cameraType:Show();
		if desc and desc.cameraType then 
			dd_cameraType:SetSelection(desc.cameraType); 
		else
			dd_cameraType:SetSelection("SetCameraZero");
		end
		er:EmbedChild(dd_cameraType); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			local a = ed_flOffset.editBox:GetNumber(); if not a then a=0; end a = VFL.clamp(a, -2, 5);
			return { 
				feature = "portrait_3d2"; version = 1;
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				unit = dd_unit:GetSelection();
				flOffset = a;
				cameraType = dd_cameraType:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "portrait_3d2"; version = 1; 
			name = "portrait3d"; owner = "Frame_decor";
			w = 30; h = 30; 
			anchor = {lp = "RIGHT", af = "Frame_decor", rp = "LEFT", dx = 0, dy = 0};
			unit = "default";
			flOffset = 1;
		};
	end;
});
