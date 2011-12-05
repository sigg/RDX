-- Textures.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Textures for application on unitframes.

--------------------------------------------------------------
-- A Texture is an independent texture object on a unitframe.
--------------------------------------------------------------
RDX.RegisterFeature({
	name = "texture"; version = 1; 
	title = VFLI.i18n("Texture Custom"); 
	category = VFLI.i18n("Textures");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.sublevel or desc.sublevel == 0 then desc.sublevel = 1; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("Texture_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Texture_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = RDXUI.ResolveTextureReference(desc.name);
		------------------ On frame creation
		local createCode = [[
local _t = VFLUI.CreateTexture(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
_t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);
_t:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
_t:SetWidth(]] .. desc.w .. [[); _t:SetHeight(]] .. desc.h .. [[);
_t:Show();
]] .. objname .. [[ = _t;
]];
		createCode = createCode .. VFLUI.GenerateSetTextureCode("_t", desc.texture);
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
]] .. objname .. [[:Destroy();
]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		if (desc.cleanupPolicy == 2) then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
]] .. objname .. [[:Hide();
]]); end);
		elseif (desc.cleanupPolicy == 3) then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
]] .. objname .. [[:Show();
]]); end);
		end

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

		-- Drawlayer
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Draw layer"));
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(150); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);
		
		-- SubLevel
		local ed_sublevel = VFLUI.LabeledEdit:new(ui, 50); ed_sublevel:Show();
		ed_sublevel:SetText(VFLI.i18n("TextureLevel offset"));
		if desc and desc.sublevel then ed_sublevel.editBox:SetText(desc.sublevel); end
		ui:InsertFrame(ed_sublevel);

		-- Cleanup policy
		local cleanupPolicy = VFLUI.RadioGroup:new(ui);
		cleanupPolicy:SetLayout(3,3);
		cleanupPolicy.buttons[1]:SetText(VFLI.i18n("No cleanup"));
		cleanupPolicy.buttons[2]:SetText(VFLI.i18n("Hide on clean"));
		cleanupPolicy.buttons[3]:SetText(VFLI.i18n("Show on clean"));
		if desc and desc.cleanupPolicy then
			cleanupPolicy:SetValue(desc.cleanupPolicy);
		else
			cleanupPolicy:SetValue(1);
		end
		ui:InsertFrame(cleanupPolicy);

		-- Texture
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "texture"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				texture = tsel:GetSelectedTexture();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				cleanupPolicy = cleanupPolicy:GetValue();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "texture"; version = 1; 
			name = "tex1", owner = "decor", drawLayer = "ARTWORK"; sublevel = 0;
			texture = VFL.copy(VFLUI.defaultTexture);
			w = 90; h = 14;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			cleanupPolicy = 1;
		};
	end;
});

-- specific function to update the texture path of a feature.
function RDXDB.SetTextureData(path, feature, key, value, newtexpath )
	if feature ~= "texture" then return; end
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat = RDXDB.HasFeature(x.data, feature, key, value);
	if feat and feat.texture then
		feat.texture.path = newtexpath;
		return true;
	end
	return nil;
end
