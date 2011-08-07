-- Minimap.lua
-- OpenRDX
-- Sigg Rashgarroth EU


VFLUI.CreateFramePool("Minimap",
	function(pool, x)
		x:SetZoom(0);
		x:SetBlipTexture("Interface\\Minimap\\ObjectIcons");
		x:SetMaskTexture("Textures\\MinimapMask");
		VFLUI._CleanupLayoutFrame(x);
	end, 
	function(_, key) 
		--return CreateFrame("Minimap");
		return Minimap;
	end,
	function(_, f) -- on acquired
		--f:Show();
		MinimapBackdrop:Hide();
		GameTimeFrame:Hide();
		--TimeManagerClockButton:Hide();
		f:ClearAllPoints();
	end,
"key");

RDX.RegisterFeature({
	name = "minimap"; 
	version = 1; 
	title = VFLI.i18n("Blizzard Minimap"); 
	category = VFLI.i18n("Complexes");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;

		------------------ On frame creation
		local createCode = [[
--local mmap = VFLUI.AcquireFrame("Minimap", "main");

local mmap = nil;
-- Carbonite fix
if not NXInit then mmap= Minimap; end
if mmap then
	MinimapBackdrop:Hide();
	GameTimeFrame:Hide();
	mmap:ClearAllPoints();
	VFLUI.StdSetParent(mmap, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
	mmap:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	mmap:SetWidth(]] .. desc.w .. [[); mmap:SetHeight(]] .. desc.h .. [[);
	mmap:SetBlipTexture(VFLUI.GetBlipTexture("]] .. desc.blipType .. [["));
	mmap:SetMaskTexture(VFLUI.GetMaskTexture("]] .. desc.maskType .. [["));
	
	mmap:SetZoom(1);
	
	mmap:EnableMouseWheel(true);
	mmap:SetScript('OnMouseWheel', function(_, dir)
		if (dir > 0) then
			Minimap_ZoomIn();
		else
			Minimap_ZoomOut();
		end
	end)
	
	mmap:Show();
	frame.]] .. objname .. [[ = mmap;
else
	--RDX.printW("Minimap is not available or already acquired");
end
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
local btn = frame.]] .. objname .. [[;
if btn then
	btn:SetZoom(0);
	btn:SetBlipTexture("Interface\\Minimap\\ObjectIcons");
	btn:SetMaskTexture("Textures\\MinimapMask");
	VFLUI._CleanupLayoutFrame(btn);
	btn = nil; 
end
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Blip Type"));
		local dd_blipType = VFLUI.Dropdown:new(er, VFLUI.GetListBlipTexture);
		dd_blipType:SetWidth(150); dd_blipType:Show();
		if desc and desc.blipType then 
			dd_blipType:SetSelection(desc.blipType); 
		else
			dd_blipType:SetSelection("Blizzard");
		end
		er:EmbedChild(dd_blipType); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Mask Type"));
		local dd_maskType = VFLUI.Dropdown:new(er, VFLUI.GetListMaskTexture);
		dd_maskType:SetWidth(150); dd_maskType:Show();
		if desc and desc.maskType then 
			dd_maskType:SetSelection(desc.maskType); 
		else
			dd_maskType:SetSelection("Blizzard");
		end
		er:EmbedChild(dd_maskType); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Compass Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er, desc.font); fontsel:Show();
		er:EmbedChild(fontsel); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "minimap"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				blipType = dd_blipType:GetSelection();
				maskType = dd_maskType:GetSelection();
				font = fontsel:GetSelectedFont();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "minimap"; version = 1; 
			name = "minimap1", owner = "decor";
			w = 140; h = 140;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			blipType = "Blizzard"; maskType = "Blizzard";
		};
	end;
});




