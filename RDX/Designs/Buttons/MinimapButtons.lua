-- MinimapButtons.lua
-- OpenRDX
-- Sigg Rashgarroth EU

VFLUI.CreateFramePool("BlizzButton", 
	function(pool, x) -- on released
		if (not x) then return; end
		VFLUI._CleanupLayoutFrame(x);
		--x:SetParent(nil); x:ClearAllPoints();
	end,
	function(_, key) -- on fallback
		local f = key;
		return f;
	end, 
	function(_, f) -- on acquired
		f:ClearAllPoints();
		if f:GetName() == "MiniMapTracking" or f:GetName() == "MiniMapWorldMapButton" or f:GetName() == "MinimapZoomIn"  or f:GetName() == "MinimapZoomOut" or f:GetName() == "GameTimeFrame" then
			f:Show();
		elseif f:GetName() == "MiniMapMailFrame" then
			if (HasNewMail()) then
				f:Show();
			else
				f:Hide();
			end
		elseif f:GetName() == "MiniMapBattlefieldFrame" then
			PVP_UpdateStatus(1);
		elseif f:GetName() == "MiniMapLFGFrame" then
			MiniMapLFG_UpdateIsShown();
		elseif f:GetName() == "MiniMapVoiceChatFrame" then
			MiniMapVoiceChat_Update();
		end
	end,
"key");

local BlizzButtons = { 
	{ text = "MiniMapTracking" },
	{ text = "MiniMapVoiceChatFrame" },
	{ text = "MiniMapWorldMapButton" },
	{ text = "MiniMapLFGFrame" },
	{ text = "MinimapZoomIn" },
	{ text = "MinimapZoomOut" },
	{ text = "MiniMapMailFrame" },
	{ text = "MiniMapBattlefieldFrame" },
	{ text = "GameTimeFrame" },
	{ text = "FeedbackUIButton" },
	{ text = "MiniMapRecordingButton" },
	{ text = "MiniMapInstanceDifficulty" },
	{ text = "GuildInstanceDifficulty" },
};

local function amOnBuild() return BlizzButtons; end
RDXUI.BlizzButtonsSelectionFunc = amOnBuild;

RDX.RegisterFeature({
	name = "minimapbutton";
	version = 1;
	title = VFLI.i18n("Button Minimap");
	test = true;
	category = VFLI.i18n("Buttons");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if (not desc.mbuttontype) then
			VFL.AddError(errs, VFLI.i18n("Button type invalide")); return nil;
		end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		if desc.owner == "Base" then desc.owner = "decor"; end
		local objname = "Button_" .. desc.name;

		------------------ On frame creation
		local createCode = [[
]];
		if desc.test then
			createCode = createCode .. [[
local btn = VFLUI.TexturedButton:new(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[, 32, "Interface\\Addons\\RDX\\Skin\\whackaMole");
btn:Show();
]];
		else
			createCode = createCode .. [[
local btn = VFLUI.AcquireFrame("BlizzButton", ]] .. desc.mbuttontype .. [[);
]];
		end
		createCode = createCode .. [[
if btn then
	VFLUI.StdSetParent(btn, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
	btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
	frame.]] .. objname .. [[ = btn;
else
	--RDX.printW("Minimap button ]] .. desc.mbuttontype .. [[ is not available or already acquired");
end
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
if frame.]] .. objname .. [[ then frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil; end
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_", true);
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Button"));
		local dd_mbuttontype = VFLUI.Dropdown:new(er, RDXUI.BlizzButtonsSelectionFunc);
		dd_mbuttontype:SetWidth(200); dd_mbuttontype:Show();
		if desc and desc.mbuttontype then 
			dd_mbuttontype:SetSelection(desc.mbuttontype); 
		else
			dd_mbuttontype:SetSelection("MiniMapTracking");
		end
		er:EmbedChild(dd_mbuttontype); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "minimapbutton"; 
				version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				mbuttontype = dd_mbuttontype:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "minimapbutton"; version = 1; 
			name = "but1", owner = "decor";
			w = 32; h = 32;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
		};
	end;
});

