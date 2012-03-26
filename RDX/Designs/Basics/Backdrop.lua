-- Backdrops.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Creation and modifications of backdrops on UnitFrames and subframes.

------------------------------------------------------
-- Backdrop feature. Adds a backdrop to a subframe.
------------------------------------------------------
RDX.RegisterFeature({
	name = "backdrop";
	title = VFLI.i18n("Backdrop");
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
		if not RDXUI.UFOwnerCheck(desc.owner, state, errs) then return nil; end
		-- Verify there isn't two backdrops on the same owner frame
		if state:Slot("Bkdp_" .. desc.owner) then
			VFL.AddError(errs, VFLI.i18n("Owner frame already has a backdrop")); return nil;
		end
		-- Verify backdrop
		if type(desc.bkd) ~= "table" then VFL.AddError(errs, VFLI.i18n("Invalid backdrop")); return nil; end
		state:AddSlot("Bkdp_" .. desc.owner);
		return true;
	end;
	ApplyFeature = function(desc, state)
		local fvar = RDXUI.ResolveFrameReference(desc.owner);

		-- Closure
		local closureCode = [[
local bkdp_]] .. desc.owner .. [[ = ]] .. Serialize(desc.bkd) .. [[;
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		-- Create
		local createCode = [[
VFLUI.SetBackdrop(]] .. fvar .. [[, bkdp_]] .. desc.owner .. [[);
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		-- Destroy
		local destroyCode = [[
if ]] .. fvar .. [[ then ]] .. fvar .. [[:SetBackdrop(nil); end
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Backdrop
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop style"));
		local bkd = VFLUI.MakeBackdropSelectButton(er, desc.bkd); bkd:Show();
		er:EmbedChild(bkd); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return { 
				feature = "backdrop"; version = 1;
				owner = owner:GetSelection();
				bkd = bkd:GetSelectedBackdrop();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "backdrop"; owner = "decor"; version = 1; bkd = VFL.copy(VFLUI.defaultBackdrop);};
	end;
});

RDX.RegisterFeature({
	name = "artbackdrop";
	version = 2;
	multiple = true;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "backdrop"; desc.version = 1;
	end;
});

-- From an idea of Crispii

RDX.RegisterFeature({
	name = "backdrop_rdx";
	title = VFLI.i18n("Backdrop Border RDX");
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
		if not RDXUI.UFOwnerCheck(desc.owner, state, errs) then return nil; end
		-- Verify there isn't two backdrops on the same owner frame
		if state:Slot("Bkdp_" .. desc.owner) or state:Slot("Bkdp_rdx_" .. desc.owner) then
			VFL.AddError(errs, VFLI.i18n("Owner frame already has a backdrop")); return nil;
		end
		if desc.sublevel and (tonumber(desc.sublevel) < 0 or tonumber(desc.sublevel) > 7) then
			VFL.AddError(errs, VFLI.i18n("Texture level must be between 0 to 7")); return nil;
		end
		state:AddSlot("Bkdp_rdx_" .. desc.owner);
		return true;
	end;
	ApplyFeature = function(desc, state)
		local fvar = RDXUI.ResolveFrameReference(desc.owner);

		-- Create
		local createCode = [[
local _l = VFLUI.CreateTexture(]] .. fvar .. [[);
local _t = VFLUI.CreateTexture(]] .. fvar .. [[);
local _r = VFLUI.CreateTexture(]] .. fvar .. [[);
local _b = VFLUI.CreateTexture(]] .. fvar .. [[);

_l:SetTexture(VFL.explodeRGBA(]] .. Serialize(desc.color) .. [[);
_t:SetTexture(VFL.explodeRGBA(]] .. Serialize(desc.color) .. [[);
_r:SetTexture(VFL.explodeRGBA(]] .. Serialize(desc.color) .. [[);
_b:SetTexture(VFL.explodeRGBA(]] .. Serialize(desc.color) .. [[);

_l:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);
_t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);
_r:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);
_b:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);

_l:SetVertexColor(1,1,1,1);
_t:SetVertexColor(1,1,1,1);
_r:SetVertexColor(1,1,1,1);
_b:SetVertexColor(1,1,1,1);

_l:SetPoint("LEFT", ]] .. fvar .. [[, "LEFT");
_t:SetPoint("TOP", ]] .. fvar .. [[, "TOP");
_r:SetPoint("RIGHT", ]] .. fvar .. [[, "RIGHT");
_b:SetPoint("BOTTOM", ]] .. fvar .. [[, "BOTTOM");

_l:SetWidth(]] .. (desc.size or "1") .. [[); _t:SetHeight(]] .. fvar .. [[:GetHeight());
_t:SetWidth(]] .. fvar .. [[:GetWidth()); _t:SetHeight(]] .. (desc.size or "1") .. [[);
_r:SetWidth(]] .. (desc.size or "1") .. [[); _t:SetHeight(]] .. fvar .. [[:GetHeight());
_b:SetWidth(]] .. fvar .. [[:GetWidth()); _t:SetHeight(]] .. (desc.size or "1") .. [[);

_l:Show();
_t:Show();
_r:Show();
_b:Show();

]] .. fvar .. [[_l = _l;
]] .. fvar .. [[_t = _t;
]] .. fvar .. [[_r = _r;
]] .. fvar .. [[_b = _b;

]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		-- Destroy
		local destroyCode = [[
]] .. fvar .. [[_l:Destroy();
]] .. fvar .. [[_l = nil;
]] .. fvar .. [[_t:Destroy();
]] .. fvar .. [[_l = nil;
]] .. fvar .. [[_r:Destroy();
]] .. fvar .. [[_r = nil;
]] .. fvar .. [[_b:Destroy();
]] .. fvar .. [[_b = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Draw layer"));
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(150); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);
		
		local ed_sublevel = VFLUI.LabeledEdit:new(ui, 50); ed_sublevel:Show();
		ed_sublevel:SetText(VFLI.i18n("TextureLevel offset"));
		if desc and desc.sublevel then ed_sublevel.editBox:SetText(desc.sublevel); end
		ui:InsertFrame(ed_sublevel);
		
		local ed_size = VFLUI.LabeledEdit:new(ui, 50); ed_size:Show();
		ed_size:SetText(VFLI.i18n("Texture size"));
		if desc and desc.size then ed_size.editBox:SetText(desc.size); end
		ui:InsertFrame(ed_size);
		
		local color = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Texture color"));
		if desc and desc.color then color:SetColor(VFL.explodeRGBA(desc.color)); end
		
		function ui:GetDescriptor()
			return { 
				feature = "backdrop_rdx"; version = 1;
				owner = owner:GetSelection();
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				size = VFL.clamp(ed_size.editBox:GetNumber(), 1, 10);
				color = color:GetColor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "backdrop_rdx"; owner = "decor"; version = 1; sublevel = 1; size = 1; color = {r=0,g=0,b=0,a=1};};
	end;
});

