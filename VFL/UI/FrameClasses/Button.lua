-- Button.lua
-- VFL
-- (C)2006 Bill Johnson
--
-- Button templates for the dynamic frame engine.

--- Create a standard VFL-themed button.
VFLUI.Button = {};
function VFLUI.Button:new(parent)
	local btn = VFLUI.AcquireFrame("Button");
	if parent then
		btn:SetParent(parent);
		--btn:SetFrameStrata(parent:GetFrameStrata());
		--btn:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	
	-- Background
	btn:SetBackdrop(VFLUI.DefaultDialogBorder);

	-- Textures Bkg
	local tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.1);
	tex:SetDrawLayer("ARTWORK", 1);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn.texBkg = tex;

	-- Normal Texture is owned by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetNormalTexture(tex);
	btn.texNor = tex;

	-- Disabled Texture is owned by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(0.5, 0.5, 0.5, 1);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetDisabledTexture(tex);
	btn.texDis = tex;

	-- Highlight Texture is owned by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.2);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetHighlightTexture(tex);
	btn.texHig = tex;

	-- Pushed Texture is owned by the button
	tex = VFLUI.CreateTexture(btn);
	tex:SetTexture(1, 1, 1, 0.4);
	tex:SetDrawLayer("ARTWORK", 2);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 4, -4);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -4, 4);
	tex:Show();
	btn:SetPushedTexture(tex);
	btn.texPus = tex;

	-- Fonts
	btn:SetNormalFontObject(Fonts.Default);
	btn:SetDisabledFontObject(Fonts.Default); 
	btn:SetHighlightFontObject(Fonts.Default);

	btn.Destroy = VFL.hook(function(s)
		VFLUI.ReleaseRegion(s.texBkg); s.texBkg = nil;
		VFLUI.ReleaseRegion(s.texNor); s.texNor = nil;
		VFLUI.ReleaseRegion(s.texDis); s.texDis = nil;
		VFLUI.ReleaseRegion(s.texHig); s.texHig = nil;
		VFLUI.ReleaseRegion(s.texPus); s.texPus = nil;
	end, btn.Destroy);

	return btn;
end

--- "Cancel" button with red text
VFLUI.CancelButton = {};
function VFLUI.CancelButton:new(parent)
	local btn = VFLUI.Button:new(parent);
	btn:SetNormalFontObject(Fonts.DefaultRed);
	btn:SetDisabledFontObject(Fonts.DefaultRed); 
	btn:SetHighlightFontObject(Fonts.DefaultRed);
	return btn;
end

--- "OK" button
VFLUI.OKButton = {};
function VFLUI.OKButton:new(parent)
	local btn = VFLUI.Button:new(parent);
	btn:SetNormalFontObject(Fonts.DefaultGreen);
	btn:SetDisabledFontObject(Fonts.DefaultGreen); 
	btn:SetHighlightFontObject(Fonts.DefaultGreen);
	return btn;
end

--- Single-texture square-shaped highlightable button.
VFLUI.TexturedButton = {};
function VFLUI.TexturedButton:new(parent, dim, texture)
	local self = VFLUI.AcquireFrame("Button");
	-- Inheritance
	if parent then
		self:SetParent(parent);
		--self:SetFrameStrata(parent:GetFrameStrata());
		--self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	
	if not dim then dim=16; end
	self:SetWidth(dim); self:SetHeight(dim);
	
	-- Textures
	local norTex = VFLUI.CreateTexture(self);
	norTex:SetAllPoints(self); norTex:Show();
	norTex:SetTexture(texture);
	self:SetNormalTexture(norTex);
	norTex:SetVertexColor(1,1,1);
	
	local hltTex = VFLUI.CreateTexture(self);
	hltTex:SetAllPoints(self); hltTex:Show();
	hltTex:SetTexture(texture);
	self:SetHighlightTexture(hltTex);
	hltTex:SetBlendMode("DISABLE");

	function self:SetHighlightColor(r,g,b,a)
		hltTex:SetVertexColor(r,g,b,a);
	end
	
	self.Destroy = VFL.hook(function(s)
		VFLUI.ReleaseRegion(hltTex); hltTex = nil;
		VFLUI.ReleaseRegion(norTex); norTex = nil;
		s.SetHighlightColor = nil;
	end, self.Destroy);
	return self;
end

--- "X"-shaped Close button
VFLUI.CloseButton = {};
function VFLUI.CloseButton:new(parent, dim)
	local ret = VFLUI.TexturedButton:new(parent, dim, "Interface\\Addons\\VFL\\Skin\\x");
	ret:SetHighlightColor(1,0,0,1);
	return ret;
end

VFLUI.SaveButton = {};
function VFLUI.SaveButton:new(parent, dim)
	local ret = VFLUI.TexturedButton:new(parent, dim, "Interface\\Addons\\VFL\\Skin\\disk2");
	ret:SetHighlightColor(0,1,0,1);
	return ret;
end

--- VFL-themed checkbox with paired text control
VFLUI.Checkbox = {};
function VFLUI.Checkbox:new(parent)
	local self = VFLUI.AcquireFrame("Frame");

	if parent then
		self:SetParent(parent);
		--self:SetFrameStrata(parent:GetFrameStrata());
		--self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	
	local chk = VFLUI.AcquireFrame("CheckButton");
	chk:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
	chk:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
	chk:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
	chk:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");

	chk:SetParent(self); chk:SetFrameStrata(self:GetFrameStrata()); chk:SetFrameLevel(self:GetFrameLevel() + 1);
	chk:SetPoint("LEFT", self, "LEFT", 2, -1);
	chk:SetHeight(19); chk:SetWidth(19); chk:Show();

	self.check = chk; 
	
	self:SetHeight(16); self:SetWidth(0);

	local txt = VFLUI.CreateFontString(self);
	txt:SetPoint("LEFT", chk, "RIGHT"); txt:SetHeight(16);
	txt:SetJustifyH("LEFT");
	VFLUI.SetFont(txt, Fonts.Default, 10);
	self.text = txt;

	self.SetText = function(self, t) self.text:SetText(t); end;
	self.GetChecked = function(self) return self.check:GetChecked(); end;
	self.SetChecked = function(self, x) self.check:SetChecked(x); end;

	local function layout()
		local w = self:GetWidth();
		if(w < 25) then self.text:SetWidth(0); self.text:Hide(); else self.text:SetWidth(w - 19); self.text:Show(); end
	end
	self:SetScript("OnShow", layout);
	self:SetScript("OnSizeChanged", layout);
	self.DialogOnLayout = layout;

	self.Destroy = VFL.hook(function(s)
		s.check:Destroy(); s.check = nil;
		VFLUI.ReleaseRegion(s.text); s.text = nil; 
		s.SetText = nil; s.GetChecked = nil; s.SetChecked = nil;
	end, self.Destroy);

	return self;
end

-- VFL-themed Radio Button with text control
VFLUI.RadioButton = {};
function VFLUI.RadioButton:new(parent)
	-- Containing frame
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent);
		--self:SetFrameStrata(parent:GetFrameStrata());
		--self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	self:SetHeight(16); self:SetWidth(16);
	
	-- The radio button
	local chk = VFLUI.AcquireFrame("CheckButton");
	
	local tex = chk:CreateTexture();
	if not tex:SetTexture("Interface\\Buttons\\UI-RadioButton") then error("texture"); end
	tex:SetAllPoints();
	tex:SetTexCoord(0, 0.25, 0, 1); tex:Show();
	chk:SetNormalTexture(tex);
	
	local htex = chk:CreateTexture();
	if not htex:SetTexture("Interface\\Buttons\\UI-RadioButton") then error("texture"); end
	htex:SetAllPoints();
	htex:SetTexCoord(0.5, 0.75, 0, 1);
	htex:SetBlendMode("ADD"); htex:Show();
	chk:SetHighlightTexture(htex);

	tex = chk:CreateTexture();
	if not tex:SetTexture("Interface\\Buttons\\UI-RadioButton") then error("texture"); end
	tex:SetAllPoints();
	tex:SetTexCoord(0.25, 0.49, 0, 1); tex:Show();
	chk:SetCheckedTexture(tex);

	chk:SetParent(self); chk:SetFrameStrata(self:GetFrameStrata()); chk:SetFrameLevel(self:GetFrameLevel() + 1);
	chk:SetPoint("LEFT", self, "LEFT", 3, 0);
	chk:SetHeight(16); chk:SetWidth(16); chk:Show();

	self.button = chk;

	-- The text box
	local txt = VFLUI.CreateFontString(self);
	txt:SetPoint("LEFT", chk, "RIGHT"); txt:SetHeight(16);
	txt:SetJustifyH("LEFT"); txt:Show();
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));

	self.SetText = function(s, t) txt:SetText(t); end;
	self.GetChecked = function(s) return chk:GetChecked(); end;
	self.SetChecked = function(s, ch) 
--		VFLUI:Debug(7, "RadioButton(" .. tostring(s) .."):SetChecked(" .. tostring(ch) .. ")");
		chk:SetChecked(ch); 
	end
	
	self:SetScript("OnSizeChanged", function(self)
		local w = self:GetWidth();
--		VFLUI:Debug(7, "RadioButton:OnSizeChanged " .. w);
		if(w < 25) then txt:SetWidth(0); txt:Hide(); else txt:SetWidth(w - 19); txt:Show(); end
	end);

	self.Destroy = VFL.hook(function(s)
		chk:Destroy(); chk = nil; self.button = nil;
		VFLUI.ReleaseRegion(txt); txt = nil;
		htex = nil;
		s.SetText = nil; s.GetChecked = nil; s.SetChecked = nil;
	end, self.Destroy);

	return self;
end

--- class VFLUI.CheckGroup
-- A check group is a numerically indexed array of checkboxes arranged in a grid.
VFLUI.CheckGroup = {};
function VFLUI.CheckGroup:new(parent)
	local self = VFLUI.Grid:new(parent);
	self:Show();

	self.checkBox = {};
	self.SetLayout = function(s, nChecks, nCols)
		-- Size the thing
		local nRows = math.ceil(nChecks / nCols);
		s:Size(nCols, nRows, function(grid)
			local cb = VFLUI.Checkbox:new(grid);
			cb.OnDeparent = cb.Destroy;
			return cb;
		end);
		-- Populate the checkboxes array
		s.checkBox = {};
		local n = 0;
		for cell in s:Iterator() do
			n = n + 1;
			if(n > nChecks) then cell:Hide() else
				cell:Show(); s.checkBox[n] = cell;
			end
		end
		-- Trip upward layout since we changed heights.
		VFLUI.UpdateDialogLayout(s);
	end

	self.DialogOnLayout = VFL.Noop;

	self.Destroy = VFL.hook(function(s)
		VFLUI:Debug(5, "CheckGroup(" .. tostring(s) .. "):Destroy()");
		s.checkBox = nil; s.SetLayout = nil;
		s.DialogOnLayout = nil;
	end, self.Destroy);

	return self;
end

--- class VFLUI.RadioGroup
-- A radio group is a grid of mutually exclusive radio buttons.
VFLUI.RadioGroup = {};
function VFLUI.RadioGroup:new(parent)
	local self = VFLUI.Grid:new(parent);
	self:Show();

	self.buttons = {};
	self.value = nil;
	self.SetLayout = function(s, nChecks, nCols)
		-- Size the thing
		local nRows = math.ceil(nChecks / nCols);
		s:Size(nCols, nRows, function(grid)
			local cb = VFLUI.RadioButton:new(grid);
			cb.OnDeparent = cb.Destroy;
			return cb;
		end);
		-- Populate the checkboxes array
		s.buttons = {};
		local n = 0;
		for cell in s:Iterator() do
			n = n + 1;
			if(n > nChecks) then cell:Hide() else
				cell:Show(); s.buttons[n] = cell;
				local qq = n;
				cell.button:SetScript("OnClick", function() s:SetValue(qq); end);
			end
		end
		-- Relayout the dialog.
		VFLUI.UpdateDialogLayout(s);
	end

	self.SetValue = function(s, v)
		s.value = v;
		local n = 0;
		for cell in s:Iterator() do
			n=n+1;
			if(n == v) then cell:SetChecked(true); else cell:SetChecked(nil); end
		end
	end
	self.GetValue = function(s) return s.value; end

	self.DialogOnLayout = VFL.Noop;

	self.Destroy = VFL.hook(function(s)
		VFLUI:Debug(5, "RadioGroup(" .. tostring(s) .. "):Destroy()");
		s.buttons = nil; s.SetLayout = nil;
		s.SetValue = nil; s.GetValue = nil; s.value = nil;
		s.DialogOnLayout = nil;
	end, self.Destroy);

	return self;
end

--- class VFLUI.SkinButton
-- A skin button contains many texture border, background (see register buttonskins)
VFLUI.SkinButton = {};
function VFLUI.SkinButton:new(parent, btype, id)
	if not btype then btype = "Button"; end
	local obj = VFLUI.AcquireFrame(btype, id);
	if not obj then return nil; end
	
	if parent then
		obj:SetParent(parent);
		--obj:SetAllPoints(parent);
		--obj:SetFrameStrata(parent:GetFrameStrata());
		--obj:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	
	obj:Show();
	
	local framesup = VFLUI.AcquireFrame("Frame");
	framesup:SetParent(obj);
	framesup:SetFrameStrata(obj:GetFrameStrata());
	framesup:SetFrameLevel(obj:GetFrameLevel() + 2);
	framesup:SetAllPoints(obj);
	framesup:Show();
	obj.framesup = framesup;
	
	local _texBackdrop = VFLUI.CreateTexture(obj);
	_texBackdrop:SetAllPoints(obj);
	_texBackdrop:Hide();
	obj._texBackdrop = _texBackdrop;
	
	
	local _texBorder = VFLUI.CreateTexture(framesup);
	_texBorder:SetAllPoints(framesup);
	_texBorder:Hide();
	obj._texBorder = _texBorder;
	
	local _texFlash = VFLUI.CreateTexture(framesup);
	_texFlash:SetAllPoints(framesup);
	_texFlash:Hide();
	obj._texFlash = _texFlash;
	
	-- normal
	local _texNormal = VFLUI.CreateTexture(obj);
	_texNormal:SetAllPoints(obj);
	obj._texNormal = _texNormal;
	
	-- pushed
	local _texPushed = VFLUI.CreateTexture(obj);
	_texPushed:SetAllPoints(obj);
	obj._texPushed = _texPushed;
	
	-- disabled
	local _texDisabled = VFLUI.CreateTexture(obj);
	_texDisabled:SetAllPoints(obj);
	obj._texDisabled = _texDisabled;
	
	-- checked
	local _texChecked = VFLUI.CreateTexture(obj);
	_texChecked:SetAllPoints(obj);
	obj._texChecked = _texChecked;
	
	-- highlights
	local _texHighlight = VFLUI.CreateTexture(obj);
	_texHighlight:SetAllPoints(obj);
	obj._texHighlight = _texHighlight;
	
	-- gloss
	local _texGloss = VFLUI.CreateTexture(obj);
	_texGloss:SetAllPoints(obj);
	_texGloss:Hide();
	obj._texGloss = _texGloss;
	
	-- set button skin function
	obj.SetButtonSkin = function(self, name, backdrop, border, flash, normal, pushed, disabled, checked, highlight, autocastable, gloss)
		local desc = VFLUI.GetButtonSkin(name);
		if not desc then return; end
		self.sbs = true;
		if backdrop and desc.backdrop then
			VFLUI.SetTexture(self._texBackdrop, desc.backdrop);
			self._texBackdrop:SetDrawLayer("ARTWORK", 1);
			self._texBackdrop:Show();
		end
		if border and desc.border then
			VFLUI.SetTexture(self._texBorder, desc.border);
			self._texBorder:SetDrawLayer("ARTWORK", 6);
			self._texBorder:Show();
		end
		if flash and desc.flash then
			VFLUI.SetTexture(self._texFlash, desc.flash);
			self._texFlash:SetDrawLayer("ARTWORK", 7);
			self._texFlash:Show();
		end
		if normal and desc.normal then
			VFLUI.SetTexture(self._texNormal, desc.normal);
			self._texNormal:SetDrawLayer("ARTWORK", 3);
			self:SetNormalTexture(self._texNormal);
		end
		if pushed and desc.pushed then
			VFLUI.SetTexture(self._texPushed, desc.pushed);
			self._texPushed:SetDrawLayer("ARTWORK", 3);
			self:SetPushedTexture(self._texPushed);
		end
		if disabled and desc.disabled then
			VFLUI.SetTexture(self._texDisabled, desc.disabled);
			self._texDisabled:SetDrawLayer("ARTWORK", 3);
			self:SetDisabledTexture(self._texDisabled);
		end
		if checked and desc.checked and self:GetObjectType() == "CheckButton" then
		--	VFLUI.SetTexture(self:GetCheckedTexture(), desc.checked);
		--	self:GetCheckedTexture():SetDrawLayer("ARTWORK", 3);
		--	self:GetCheckedTexture():Show();
		--	self.ctex = desc.checked;
		end
		if highlight and desc.highlight then
			VFLUI.SetTexture(self._texHighlight, desc.highlight);
			self._texHighlight:SetDrawLayer("ARTWORK", 3);
			self:SetHighlightTexture(self._texHighlight);
		end
		if gloss and desc.gloss then
			VFLUI.SetTexture(self._texGloss, desc.gloss);
			self._texGloss:SetDrawLayer("ARTWORK", 4);
			self._texGloss:Show();
		end
	end;
	
	obj.bsHide = function(self)
		self._texBackdrop:Hide();
		self._texBorder:Hide();
		self._texFlash:Hide();
		self._texNormal:Hide();
		self._texPushed:Hide();
		self._texDisabled:Hide();
		self._texHighlight:Hide();
		self._texGloss:Hide();
	end
	
	obj.bsShow = function(self)
		self._texBackdrop:Show();
		self._texBorder:Show();
		self._texFlash:Show();
		self._texNormal:Show();
		self._texPushed:Show();
		self._texDisabled:Show();
		self._texHighlight:Show();
		self._texGloss:Show();
	end

	obj.Destroy = VFL.hook(function(s)
		VFLUI:Debug(5, "SkinButton(" .. tostring(s) .. "):Destroy()");
		s.sbs = nil; s.ntex = nil; s.ptex = nil; s.dtex = nil; s.ctex = nil; s.htex = nil;
		s.SetButtonSkin = nil; s.bsHide = nil; s.bsShow = nil;
		VFLUI.ReleaseRegion(s._texBackdrop); s._texBackdrop = nil;
		VFLUI.ReleaseRegion(s._texBorder); s._texBorder = nil;
		VFLUI.ReleaseRegion(s._texFlash); s._texFlash = nil;
		VFLUI.ReleaseRegion(s._texNormal); s._texNormal = nil;
		VFLUI.ReleaseRegion(s._texPushed); s._texPushed = nil;
		VFLUI.ReleaseRegion(s._texDisabled); s._texDisabled = nil;
		VFLUI.ReleaseRegion(s._texChecked); s._texChecked = nil;
		VFLUI.ReleaseRegion(s._texHighlight); s._texHighlight = nil;
		VFLUI.ReleaseRegion(s._texGloss); s._texGloss = nil;
		s.framesup:Destroy(); s.framesup = nil;
	end, obj.Destroy);

	return obj;
end

VFLUI.BckButton = {};
function VFLUI.BckButton:new(parent, btype, id)
	if not btype then btype = "Button"; end
	local obj = VFLUI.AcquireFrame(btype, id);
	if not obj then return nil; end
	if parent then
		obj:SetParent(parent);
		--obj:SetFrameStrata(parent:GetFrameStrata());
		--obj:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	obj:Show();
	
	--local frbkd = VFLUI.AcquireFrame("Frame");
	--frbkd:SetParent(obj);
	--frbkd:SetAllPoints(obj);
	--frbkd:Show();
	--obj.frbkd = frbkd;
	
	-- set button skin function
	obj.SetButtonBkd = function(self, bkd)
		VFLUI.SetBackdrop(self, bkd);
	end;
	
	obj.bsHide = function(self)
		self:Hide();
	end
	
	obj.bsShow = function(self)
		self:Show();
	end

	obj.Destroy = VFL.hook(function(s)
		s.SetButtonBck = nil; s.bsHide = nil; s.bsShow = nil;
		--s.frbkd:Destroy(); s.frbkd = nil;
	end, obj.Destroy);

	return obj;
end

VFLUI.BRButton = {};
function VFLUI.BRButton:new(parent, btype, id)
	if not btype then btype = "Button"; end
	local obj = VFLUI.AcquireFrame(btype, id);
	if not obj then return nil; end
	if parent then
		obj:SetParent(parent);
		--obj:SetFrameStrata(parent:GetFrameStrata());
		--obj:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	obj:Show();
	
	-- set button skin function
	obj.SetButtonBR = function(self, level, bordersize)
		--VFLUI.SetBackdropBorderRDX(self, _black, "ARTWORK", level, bordersize);
	end;
	
	obj.bsHide = function(self)
		--self.frbkd:Hide();
	end
	
	obj.bsShow = function(self)
		--self.frbkd:Show();
	end

	obj.Destroy = VFL.hook(function(s)
		s.SetButtonBR = nil; s.bsHide = nil; s.bsShow = nil;
		--s.frbkd:Destroy(); s.frbkd = nil;
	end, obj.Destroy);

	return obj;
end

