-- Scroll.lua
-- VFL
-- (C)2006 Bill Johnson
--
-- Generators for horizontal and vertical scrollbars, and other scrolling-
-- related frametypes.

-- Internal: Create a scroll button with the given textures.
local function CreateScrollButton(nrm, psh, dis, hlt)
	local self = VFLUI.AcquireFrame("Button");
	-- Size is 16x16
	self:SetWidth(16); self:SetHeight(16);

	-- Button textures
	self:SetNormalTexture(nrm);
	self:SetPushedTexture(psh);
	self:SetDisabledTexture(dis);
	
	-- Highlight texture requires special handling (for blend mode)
	local hltTex = VFLUI.CreateTexture(self);
	hltTex:SetAllPoints(self); hltTex:Show();
	hltTex:SetTexture(hlt);
	hltTex:SetBlendMode("ADD");
	self:SetHighlightTexture(hltTex);
	self.hltTex = hltTex;

	self.Destroy = VFL.hook(function(s) 
		VFLUI.ReleaseRegion(s.hltTex);
		s.hltTex = nil;
	end, self.Destroy);

	return self;
end

--- Check the value of a scroll bar, and grey out the scroll buttons
-- as appropriate.
function VFLUI.ScrollBarRangeCheck(sb)
	local min,max = sb:GetMinMaxValues();
	local val = sb:GetValue();
	if(VFL.close(val,min)) then
		sb.btnDecrease:Disable();
	else
		sb.btnDecrease:Enable();
	end
	if(VFL.close(val, max)) then
		sb.btnIncrease:Disable();
	else
		sb.btnIncrease:Enable();
	end
end

--- Create a button with the VFL "Scroll up" skin.
function VFLUI.CreateScrollUpButton()
	return CreateScrollButton("Interface\\Addons\\VFL\\Skin\\sb_up", 
		"Interface\\Addons\\VFL\\Skin\\sb_up_pressed", 
		"Interface\\Addons\\VFL\\Skin\\sb_up_disabled",
		"Interface\\Addons\\VFL\\Skin\\sb_up_hlt");
end

--- Create a button with the VFL "Scroll down" skin.
function VFLUI.CreateScrollDownButton()
	return CreateScrollButton("Interface\\Addons\\VFL\\Skin\\sb_down", 
		"Interface\\Addons\\VFL\\Skin\\sb_down_pressed", 
		"Interface\\Addons\\VFL\\Skin\\sb_down_disabled",
		"Interface\\Addons\\VFL\\Skin\\sb_down_hlt");
end

--- Create a button with the "Scroll right" skin
function VFLUI.CreateScrollRightButton()
	return CreateScrollButton("Interface\\Addons\\VFL\\Skin\\sb_right", 
		"Interface\\Addons\\VFL\\Skin\\sb_right_pressed", 
		"Interface\\Addons\\VFL\\Skin\\sb_right_disabled",
		"Interface\\Addons\\VFL\\Skin\\sb_right_hlt");
end

--- Create a button with the "Scroll left" skin
function VFLUI.CreateScrollLeftButton()
	return CreateScrollButton("Interface\\Addons\\VFL\\Skin\\sb_left", 
		"Interface\\Addons\\VFL\\Skin\\sb_left_pressed", 
		"Interface\\Addons\\VFL\\Skin\\sb_left_disabled",
		"Interface\\Addons\\VFL\\Skin\\sb_left_hlt");
end

local vsb_backdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\sb_vgutter"; 
	insets = { left = 0; right = 0; top = 0; bottom = 0; }; 
	tile = true; tileSize = 16;
};

VFLUI.VScrollBar = {};
--- Create a new vertical scrollbar.
function VFLUI.VScrollBar:new(parent)
	local self = VFLUI.AcquireFrame("Slider");
	self:SetWidth(16); self:SetHeight(0);

	if parent then
		self:SetParent(parent);
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	-- Gutter texture
	local gutter = VFLUI.CreateTexture(self);
	gutter:SetAllPoints(self);
	gutter:SetTexture("Interface\\Addons\\VFL\\Skin\\sb_vgutter");
	gutter:Show();

	-- Thumb texture
	local sbThumb = self:CreateTexture();
	sbThumb:SetWidth(16); sbThumb:SetHeight(16); sbThumb:Show();
	sbThumb:SetTexture("Interface\\Addons\\VFL\\Skin\\sb_nub");
	self:SetThumbTexture(sbThumb);

	-- Create the up/down buttons
	local btn = VFLUI.CreateScrollUpButton();
	btn:SetParent(self); btn:SetFrameLevel(self:GetFrameLevel()); btn:Show();
	btn:SetPoint("BOTTOM", self, "TOP");
	btn:SetScript("OnClick", function(x)
		local sb = x:GetParent();
		sb:SetValue(sb:GetValue() - sb:GetPageSize());
		PlaySound("UChatScrollButton");
	end);
	self.btnDecrease = btn;

	btn = VFLUI.CreateScrollDownButton();
	btn:SetParent(self); btn:SetFrameLevel(self:GetFrameLevel()); btn:Show();
	btn:SetPoint("TOP", self, "BOTTOM");
	btn:SetScript("OnClick", function(x)
		local sb = x:GetParent();
		sb:SetValue(sb:GetValue() + sb:GetPageSize());
		PlaySound("UChatScrollButton");
	end);
	self.btnIncrease = btn;

	-- Create the onscroll script
	self:SetScript("OnValueChanged", function(x, val)
		VFLUI.ScrollBarRangeCheck(x);
		local p = x:GetParent();
		if p and p.SetVerticalScroll then p:SetVerticalScroll(val); end
	end);
	
	-- Page size handling
	local pageSize = nil;
	function self:SetPageSize(n) pageSize = tonumber(n); end
	function self:GetPageSize()
		if pageSize then return pageSize; end
		local min,max = self:GetMinMaxValues();
		return (max-min)/5;
	end

	-- Hook the destroy handler
	self.Destroy = VFL.hook(function(self)
		self.SetPageSize = nil; self.GetPageSize = nil;
		self.btnDecrease:Destroy(); self.btnDecrease = nil;
		self.btnIncrease:Destroy(); self.btnIncrease = nil;
		gutter:Destroy(); gutter = nil;
	end, self.Destroy);

	-- Done
	return self;
end

---------------------------------------
-- @class VFLUI.VScrollFrame
-- A class similar to a Blizzard ScrollFrame, preloaded with VFL-themed
-- scrollbars and appropriate scripts.
---------------------------------------
VFLUI.VScrollFrame = {};
function VFLUI.VScrollFrame:new(parent)
	local self = VFLUI.AcquireFrame("ScrollFrame");
	self.offset = 0; self.scrollBarHideable = true;

	if parent then
		self:SetParent(parent);
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	local sb = VFLUI.VScrollBar:new(self);
	sb:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, -16);
	sb:SetPoint("BOTTOMLEFT", self, "BOTTOMRIGHT", 0, 16);
	sb.btnIncrease:Disable(); sb.btnDecrease:Disable();
	sb:Show();

	local function OnScrollRangeChanged()
		scrollrange = self:GetVerticalScrollRange();
		sb:SetMinMaxValues(0, scrollrange);
		sb:SetPageSize(self:GetHeight());
		local value = sb:GetValue();
		if ( value > scrollrange ) then value = scrollrange; end
		sb:SetValue(value);
		if ( math.floor(scrollrange) == 0 ) then
			if (self.scrollBarHideable ) then
				sb:Hide();
			else
				sb:Show();
				sb.btnIncrease:Disable(); sb.btnIncrease:Show();
				sb.btnDecrease:Disable(); sb.btnDecrease:Show();
			end
		else
			sb:Show();
			sb.btnDecrease:Show();
			sb.btnIncrease:Show(); sb.btnIncrease:Enable();
		end
	end

	self:SetScript("OnScrollRangeChanged", OnScrollRangeChanged);

	--- Scroll child management.
	local BlizzSetScrollChild = self.SetScrollChild;
	self.SetScrollChild = function(s, sc)
		-- If we had an old scroll child, be sure to undo any changes we made to it.
		if s._scrollChild then
			s._scrollChild:SetScript("OnSizeChanged", s._oldChildOnSizeChanged);
			s._oldChildOnSizeChanged = nil;
		end
		-- Point to the new scroll child
		s._scrollChild = sc;
		BlizzSetScrollChild(s, sc);
		-- If the new scroll child is extant...
		if sc then
			-- Apply a new SizeChanged script.
			local osc = sc:GetScript("OnSizeChanged");
			s._oldChildOnSizeChanged = osc;
			if not osc then osc = VFL.Noop; end
			sc:SetScript("OnSizeChanged", function(th, w, h)
				osc(th, w, h);
				s:UpdateScrollChildRect();
				OnScrollRangeChanged();
			end);
		end
	end
	
	-- Enable mousewheel scrolling
	self:EnableMouseWheel(true)
	self:SetScript("OnMouseWheel", function(self, delta)
		local curpos, minpos, maxpos = sb:GetValue(), sb:GetMinMaxValues();
		-- Move a fifth of a page
		local mv = self:GetHeight() / 5;
		curpos = curpos - (delta*mv);
		if(curpos < minpos) then curpos = minpos; elseif (curpos > maxpos) then curpos = maxpos; end
		sb:SetValue(curpos);
	end)

	self:SetScript("OnVerticalScroll", function(self, arg1) sb:SetValue(arg1); VFLUI.ScrollBarRangeCheck(sb); end);

	self.Destroy = VFL.hook(function(s)
		s:SetScrollChild(nil); s.SetScrollChild = nil; -- Deallocate extant scroll children.
		s.offset = nil; s.scrollBarHideable = nil;
		s._oldChildOnSizeChanged = nil;
		sb:Destroy();
	end, self.Destroy);
	return self;
end

---------------------------------------------------
-- @class VFLUI.HScrollBar
-- A horizontal slider.
---------------------------------------------------
local hsb_backdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\sb_hgutter"; 
	insets = { left = 0; right = 0; top = 0; bottom = 0; }; 
	tile = true; tileSize = 16;
};
VFLUI.HScrollBar = {};
function VFLUI.HScrollBar:new(parent, noButtons)
	local self = VFLUI.AcquireFrame("Slider");
	self:SetHeight(16); self:SetWidth(0);
	self:SetOrientation("HORIZONTAL");
	if parent then
		self:SetParent(parent);
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel());
	end

	-- Gutter texture
	self:SetBackdrop(hsb_backdrop);
	-- Thumb texture
	local sbThumb = self:CreateTexture();
	sbThumb:SetWidth(16); sbThumb:SetHeight(16); sbThumb:Show();
	sbThumb:SetTexture("Interface\\Addons\\VFL\\Skin\\sb_nub");
	self:SetThumbTexture(sbThumb);

	if not noButtons then
		-- Create the up/down buttons
		local btn = VFLUI.CreateScrollLeftButton();
		btn:SetParent(self); btn:Show();
		btn:SetPoint("RIGHT", self, "LEFT");
		btn:SetScript("OnClick", function(self)
			local sb = self:GetParent();
			local min,max = sb:GetMinMaxValues();
			sb:SetValue(sb:GetValue() - ((max-min) / 5));
			PlaySound("UChatScrollButton");
		end);
		self.btnDecrease = btn;

		btn = VFLUI.CreateScrollRightButton();
		btn:SetParent(self); btn:Show();
		btn:SetPoint("LEFT", self, "RIGHT");
		btn:SetScript("OnClick", function(self)
			local sb = self:GetParent();
			local min,max = sb:GetMinMaxValues();
			sb:SetValue(sb:GetValue() + ((max-min) / 5));
			PlaySound("UChatScrollButton");
		end);
		self.btnIncrease = btn;
	end

	-- Create the onscroll script
	self:SetScript("OnValueChanged", function(self, arg1)
		VFLUI.ScrollBarRangeCheck(self);
		local p = self:GetParent();
		if p and p.SetHorizontalScroll then
			p:SetHorizontalScroll(arg1);
		end
	end);

	-- Hook the destroy handler
	self.Destroy = VFL.hook(function(s)
		if s.btnDecrease then s.btnDecrease:Destroy(); s.btnDecrease = nil; end
		if s.btnIncrease then s.btnIncrease:Destroy(); s.btnIncrease = nil; end
	end, self.Destroy);

	-- Done
	return self;
end

------------------------------------------------------------------------
-- Bind a slider to an edit box.
------------------------------------------------------------------------
function VFLUI.BindSliderToEdit(slider, edit)
	local _recurse_prevent = false;

	local old_ovc = slider:GetScript("OnValueChanged");
	slider:SetScript("OnValueChanged", function(self, arg1)
		if not _recurse_prevent then
			_recurse_prevent = true;
			edit:SetText(string.format("%0.2f", arg1));
			_recurse_prevent = false;
		end
		if old_ovc then old_ovc(self, arg1); end
	end);

	local old_otc = edit:GetScript("OnTextChanged");
	edit:SetScript("OnTextChanged", function(self)
		if not _recurse_prevent then
			_recurse_prevent = true;
			local n = self:GetNumber();
			VFL.clamp(n, slider:GetMinMaxValues());
			slider:SetValue(n);
			_recurse_prevent = false;
		end
		if old_otc then old_otc(self); end
	end);

	edit:SetText(string.format("%0.2f", slider:GetValue()));
end
