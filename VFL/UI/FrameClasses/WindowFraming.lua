-- WindowFraming.lua
-- VFL
-- (C)2006 Bill Johnson/The VFL Project
--
-- Various "framing" types for VFL window objects. Framing allows clients to change the skin of
-- VFL windows to taste.
VFLUI.Framing = {};
local FormatMicro = VFLT.FormatMicro;

-----------------------------------------------------
-- None FRAMING
-----------------------------------------------------

function VFLUI.Framing.None(self, titleHeight, bkd)
	-------------------------- WINDOW DECOR
	
	self.bkd = bkd;
	
	local perf, perfText;
	if VFLP.IsEnabled() then
		perf = VFLUI.AcquireFrame("Frame");
		perf:SetParent(self);
		perf:SetFrameLevel(self:GetFrameLevel() + 6);
		perf:SetHeight(5);
		perf:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
		VFLUI.SetBackdrop(perf, {bgFile="Interface\\Addons\\VFL\\Skin\\black", tile = true, tileSize = 16,});
		perf:Show();
		
		perfText = VFLUI.CreateFontString(perf);
		perfText:SetAllPoints(perf);
		VFLUI.SetFont(perfText, Fonts.DefaultShadowed, 8);
		perfText:SetJustifyH("RIGHT"); 
		perfText:Show();
		
		function self:SetPerfText(txt) perfText:SetText(FormatMicro(txt)); end
	end

	---------------------------- FIXED ELEMENT LAYOUT
	if self.SetInsets then
		if self.bkd and self.bkd.insets then
			self:SetInsets(self.bkd.insets.left or 0, self.bkd.insets.top or 0, self.bkd.insets.right or 0, self.bkd.insets.bottom or 0);
		else
			self:SetInsets(0, 0, 0, 0);
		end
	else
		local clientArea = self:GetClientArea();
		clientArea:ClearAllPoints();
		clientArea:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0);
		function self:Accomodate(dx, dy)
			self:SetWidth(dx); self:SetHeight(dy);
		end
	end
	
	if self.bkd then self:SetBackdrop(self.bkd); end

	----------------------------- LAYOUT OPERATORS
	function self:_FrameLayout() end

	function self:_FrameResize()
		local l,r = self:GetLeft(), self:GetRight();
		if not l then return; end
		local tw = math.abs(r-l);
		if VFLP.IsEnabled() then
			if tw > 50 then
				perf:SetWidth(50);
			else
				perf:SetWidth(tw);
			end
		end
		
		if self.SetInsets then
			if self.bkd and self.bkd.insets then
				self:SetInsets(self.bkd.insets.left or 0, self.bkd.insets.top or 0, self.bkd.insets.right or 0, self.bkd.insets.bottom or 0);
			else
				self:SetInsets(0, 0, 0, 0);
			end
		else
			local ca = self:GetClientArea();
			ca:SetWidth(self:GetWidth()); ca:SetHeight(self:GetHeight());
		end
		
		if self.bkd then self:SetBackdrop(self.bkd); end
	end

	function self:_FrameDestroy()
		if VFLP.IsEnabled() then
			perfText:ClearAllPoints();
			VFLUI.ReleaseRegion(perfText); perfText = nil;
			perf:ClearAllPoints();
			perf:Destroy(); perf = nil;
		end
		if self.bkd then self:SetBackdrop(nil); end
		self.bkd = nil;
	end

	self:_FrameLayout();
	self:_FrameResize();
end

-----------------------------------------------------
-- DEFAULT FRAMING
-----------------------------------------------------
function VFLUI.Framing.Default(self, titleHeight, bkd)
	-------------------------- WINDOW DECOR
	
	self.bkd = bkd or VFLUI.BlackDialogBackdrop;
	
	--self:SetBackdrop(bkd or VFLUI.BlackDialogBackdrop);

	local titleBar = self:GetTitleBar();
	titleBar:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	titleBar:SetHeight(titleHeight - 5); titleBar:Show();

	local titleText = VFLUI.CreateFontString(titleBar);
	titleText:SetPoint("TOPLEFT", titleBar, "TOPLEFT", 3, 0);
	titleText:SetHeight(titleHeight - 5);
	VFLUI.SetFont(titleText, Fonts.Default, titleHeight * 0.5);
	titleText:SetJustifyH("LEFT"); titleText:Show();
    
	local tx1 = VFLUI.CreateTexture(titleBar);
	tx1:SetDrawLayer("ARTWORK");
	tx1:SetTexture("Interface\\TradeSkillFrame\\UI-TradeSkill-SkillBorder");
	tx1:SetTexCoord(0.1, 0.5, 0, 0.25);
	tx1:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -(titleHeight-4));
	tx1:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -5, -(titleHeight+4));
	tx1:Show();
    
	local tx2 = VFLUI.CreateTexture(titleBar);
	tx2:SetDrawLayer("ARTWORK");
	tx2:SetTexture(1,1,1); tx2:SetGradient("VERTICAL",1,1,1,0.3,0.3,0.3);
	tx2:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	tx2:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -5, -titleHeight);
	tx2:Show();

	function self:SetText(txt) titleText:SetText(txt); end
	function self:SetTitleColor(r,g,b) tx2:SetTexture(r,g,b); end
	
	local perf, perfText;
	if VFLP.IsEnabled() then
		perf = VFLUI.AcquireFrame("Frame");
		perf:SetParent(self);
		perf:SetFrameLevel(self:GetFrameLevel() + 6);
		perf:SetHeight(5);
		perf:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
		VFLUI.SetBackdrop(perf, {bgFile="Interface\\Addons\\VFL\\Skin\\black", tile = true, tileSize = 16,});
		perf:Show();
		
		perfText = VFLUI.CreateFontString(perf);
		perfText:SetAllPoints(perf);
		VFLUI.SetFont(perfText, Fonts.DefaultShadowed, 8);
		perfText:SetJustifyH("RIGHT"); 
		perfText:Show();
		
		function self:SetPerfText(txt) perfText:SetText(FormatMicro(txt)); end
	end

	---------------------------- FIXED ELEMENT LAYOUT
	if self.SetInsets then
		self:SetInsets(5, titleHeight + 2, 5, 5);
	else
		local clientArea = self:GetClientArea();
		clientArea:ClearAllPoints();
		clientArea:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -titleHeight-2);
		function self:Accomodate(dx, dy)
			self:SetWidth(dx + 10); self:SetHeight(dy + titleHeight + 7);
		end
	end
	
	if self.bkd then self:SetBackdrop(self.bkd); end

	----------------------------- LAYOUT OPERATORS
	function self:_FrameLayout()
		VFLUI.Window.RightButtonStrip(self, titleHeight*.7, self, "TOPRIGHT", -5, -(titleHeight/2)-2);
		-- Restore frame sublevel relationships
		titleBar:SetFrameLevel(self:GetFrameLevel());
	end

	function self:_FrameResize()
		local l,r = self:GetLeft(), self:GetRight();
		if not l then return; end
		local tw = math.abs(r-l);
		local mtw = tw - 10 - (table.getn(self.ctlButtons) * .7 * titleHeight);
		titleBar:SetWidth(mtw);
		titleText:SetWidth(mtw);
		if VFLP.IsEnabled() then
			if tw > 50 then
				perf:SetWidth(50);
			else
				perf:SetWidth(tw);
			end
		end
		if not self.SetInsets then
			local ca = self:GetClientArea();
			ca:SetWidth(tw - 10); ca:SetHeight(self:GetHeight() - titleHeight - 7);
		end
		
		if self.bkd then self:SetBackdrop(self.bkd); end
	end

	function self:_FrameDestroy()
		if VFLP.IsEnabled() then
			perfText:ClearAllPoints();
			VFLUI.ReleaseRegion(perfText); perfText = nil;
			perf:ClearAllPoints();
			perf:Destroy(); perf = nil;
		end
		if self.bkd then self:SetBackdrop(nil); end
		self.bkd = nil;
		VFLUI.ReleaseRegion(titleText); titleText = nil;
		VFLUI.ReleaseRegion(tx1); tx1 = nil;
		VFLUI.ReleaseRegion(tx2); tx2 = nil;
	end

	self:_FrameLayout();
	self:_FrameResize();
end

--- COMPAT: A lot of code uses this.
function VFLUI.Window.SetDefaultFraming(self, titleHeight, bkd)
	self:SetFraming(VFLUI.Framing.Default, titleHeight, bkd);
end

-----------------------------------------------------
-- SLEEK FRAMING
-----------------------------------------------------
local plainBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\white", tile = true, tileSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
};

function VFLUI.Framing.Sleek(self, bkd)
	------------------------------------ WINDOW DECOR
	
	self.bkd = bkd or plainBackdrop;

	local decor = VFLUI.AcquireFrame("Frame");
	decor:SetParent(self);
	decor:ClearAllPoints();
	decor:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0); decor:SetHeight(14);
	decor:SetBackdrop(plainBackdrop); decor:Show();	

	local titleBar = self:GetTitleBar();
	titleBar:ClearAllPoints(); 	titleBar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0);
	titleBar:SetHeight(14);
	titleBar:Show();

	local titleText = VFLUI.CreateFontString(titleBar);
	titleText:SetPoint("LEFT", decor, "LEFT", 4, 0);
	titleText:SetHeight(14);
	VFLUI.SetFont(titleText, Fonts.Default, 10);
	titleText:SetJustifyH("LEFT"); titleText:Show();
	
	function self:SetText(txt) titleText:SetText(txt); end
	function self:SetTitleColor(r,g,b,a) decor:SetBackdropColor(r,g,b,a); end
	
	local perf, perfText;
	if VFLP.IsEnabled() then
		perf = VFLUI.AcquireFrame("Frame");
		perf:SetParent(self);
		perf:SetFrameLevel(self:GetFrameLevel() + 6);
		perf:SetHeight(5);
		perf:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
		VFLUI.SetBackdrop(perf, {bgFile="Interface\\Addons\\VFL\\Skin\\black", tile = true, tileSize = 16,});
		perf:Show();
		
		perfText = VFLUI.CreateFontString(perf);
		perfText:SetAllPoints(perf);
		VFLUI.SetFont(perfText, Fonts.DefaultShadowed, 8);
		perfText:SetJustifyH("RIGHT"); 
		perfText:Show();
		
		function self:SetPerfText(txt) perfText:SetText(FormatMicro(txt)); end
	end
	
	--local isShown = nil;
	--function self:HideTitleBar() 
	--	decor:Hide(); titleBar:Hide();
	--	local cb = self.ctlButtons;
	--	local i = 1;
	--	while cb[i] do cb[i]:Hide(); i=i+1; end
	--	self:Hide();
	--	isShown = nil;
	--end
	--function self:ShowTitleBar()
	--	decor:Show(); titleBar:Show();
	--	local cb = self.ctlButtons;
	--	local i = 1;
	--	while cb[i] do cb[i]:Show(); i=i+1; end
	--	self:Show();
	--	isShown = true;
	--end
	--function self:IsShownTitleBar()
	--	return isShown;
	--end

	---------------------------- FIXED ELEMENT LAYOUT
	if self.SetInsets then
		if self.bkd and self.bkd.insets then
			self:SetInsets(self.bkd.insets.left or 1, (self.bkd.insets.top or 1) + 13, self.bkd.insets.right or 1, self.bkd.insets.bottom or 1);
		else
			self:SetInsets(1, 14, 1, 1);
		end
	else
		local clientArea = self:GetClientArea();
		clientArea:ClearAllPoints();
		clientArea:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -15);
		function self:Accomodate(dx, dy)
			self:SetWidth(dx + 2); self:SetHeight(dy + 15);
		end
	end
	
	if self.bkd then self:SetBackdrop(self.bkd); end

	----------------------------- LAYOUT OPERATORS
	function self:_FrameLayout()
		--VFLUI.Window.RightButtonStrip(self, 12, self, "TOPRIGHT", -4, -7);
		VFLUI.Window.RightInverseButtonStrip(self, 12, self, "TOPRIGHT", -15, -7);
		-- Restore frame sublevel relationships, we hope.
		decor:SetFrameLevel(self:GetFrameLevel() + 1);
		titleBar:SetFrameLevel(self:GetFrameLevel()+ 1);
	end

	function self:_FrameResize()
		local l,r = self:GetLeft(), self:GetRight();
		if not l then return; end
		local tw = math.abs(r-l);
		local mtw = VFL.clamp(tw - ((table.getn(self.ctlButtons) * 12) + 4), 0, 10000);
		decor:SetWidth(tw);
		titleBar:SetWidth(mtw); titleText:SetWidth(mtw);
		if VFLP.IsEnabled() then
			if tw > 50 then
				perf:SetWidth(50);
			else
				perf:SetWidth(tw);
			end
		end
		if not self.SetInsets then
			local ca = self:GetClientArea();
			ca:SetWidth(tw - 2); ca:SetHeight(self:GetHeight() - 15);
		end
		
		if self.bkd then self:SetBackdrop(self.bkd); end
	end

	function self:_FrameDestroy()
		if VFLP.IsEnabled() then
			perfText:ClearAllPoints();
			VFLUI.ReleaseRegion(perfText); perfText = nil;
			perf:ClearAllPoints();
			perf:Destroy(); perf = nil;
		end
		self:SetBackdrop(nil); 
		decor:Destroy(); decor = nil;
		titleText:ClearAllPoints();
		VFLUI.ReleaseRegion(titleText); titleText = nil;
	end

	self:_FrameLayout();
	self:_FrameResize();
end

-----------------------------------------------
-- FAT FRAMING (used to be Lightweight (rofl))
-----------------------------------------------
function VFLUI.Framing.Fat(self)
	-------------------------- DECOR
	local decor = VFLUI.AcquireFrame("Frame");
	decor:SetParent(self);
	decor:ClearAllPoints();
	decor:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0); decor:SetHeight(22);
	decor:SetBackdrop(VFLUI.DefaultDialogBackdrop); decor:SetAlpha(0.6);
	decor:Show();	

	local titleBar = self:GetTitleBar();
	titleBar:ClearAllPoints(); 	titleBar:SetPoint("LEFT", decor, "LEFT", 0, 0);
	titleBar:SetHeight(22);
	titleBar:Show();

	local titleText = VFLUI.CreateFontString(titleBar);
	titleText:SetPoint("LEFT", decor, "LEFT", 4, 0);
	titleText:SetHeight(14);
	VFLUI.SetFont(titleText, Fonts.Default, 10);
	titleText:SetJustifyH("CENTER"); titleText:Show();
	
	function self:SetText(txt) titleText:SetText(txt); end
	function self:SetTitleColor(r,g,b) end
	
	local perf, perfText;
	if VFLP.IsEnabled() then
		perf = VFLUI.AcquireFrame("Frame");
		perf:SetParent(self);
		perf:SetFrameLevel(self:GetFrameLevel() + 6);
		perf:SetHeight(5);
		perf:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
		VFLUI.SetBackdrop(perf, {bgFile="Interface\\Addons\\VFL\\Skin\\black", tile = true, tileSize = 16,});
		perf:Show();
		
		perfText = VFLUI.CreateFontString(perf);
		perfText:SetAllPoints(perf);
		VFLUI.SetFont(perfText, Fonts.DefaultShadowed, 8);
		perfText:SetJustifyH("RIGHT"); 
		perfText:Show();
		
		function self:SetPerfText(txt) perfText:SetText(FormatMicro(txt)); end
	end

	---------------------------- FIXED ELEMENT LAYOUT
	if self.SetInsets then
		self:SetInsets(0, 22, 0, 0);
	else
		local clientArea = self:GetClientArea();
		clientArea:ClearAllPoints();
		clientArea:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -22);
		function self:Accomodate(dx, dy)
			self:SetWidth(dx); self:SetHeight(dy + 22);
		end
	end

	----------------------------- LAYOUT OPERATORS
	function self:_FrameLayout()
		VFLUI.Window.RightButtonStrip(self, 12, self, "TOPRIGHT", -6, -11);
		-- Restore frame sublevel relationships, we hope.
		decor:SetFrameLevel(self:GetFrameLevel() + 1);
		titleBar:SetFrameLevel(self:GetFrameLevel()+ 1);
	end

	function self:_FrameResize()
		local l,r = self:GetLeft(), self:GetRight();
		if not l then return; end
		local tw = math.abs(r-l);
		local mtw = VFL.clamp(tw - (table.getn(self.ctlButtons) * 12) - 5, 0, 10000);
		decor:SetWidth(tw);
		titleBar:SetWidth(mtw); titleText:SetWidth(mtw);
		if VFLP.IsEnabled() then
			if tw > 50 then
				perf:SetWidth(50);
			else
				perf:SetWidth(tw);
			end
		end
		if not self.SetInsets then
			local ca = self:GetClientArea();
			ca:SetWidth(tw); ca:SetHeight(self:GetHeight() - 22);
		end
		--decor:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	end

	function self:_FrameDestroy()
		if VFLP.IsEnabled() then
			perfText:ClearAllPoints();
			VFLUI.ReleaseRegion(perfText); perfText = nil;
			perf:ClearAllPoints();
			perf:Destroy(); perf = nil;
		end
		self:SetBackdrop(nil); 
		decor:Destroy(); decor = nil;
		titleText:ClearAllPoints(); VFLUI.ReleaseRegion(titleText); titleText = nil;
	end

	self:_FrameLayout();
	self:_FrameResize();
end

-----------------------------------------------
-- BOX FRAMING
-----------------------------------------------
function VFLUI.Framing.Box(self)
	
    -------------------------- DECOR
	local decor = VFLUI.AcquireFrame("Frame");
	decor:SetParent(self);
	decor:ClearAllPoints();
	decor:SetPoint("TOPLEFT", self, "TOPLEFT");
	decor:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");

	decor:SetBackdrop(VFLUI.DefaultDialogBackdrop); 
	decor:SetAlpha(0.6);
	decor:Show();

	local titleBar = self:GetTitleBar(); titleBar:ClearAllPoints(); 	
	titleBar:SetPoint("TOP", decor, "TOP", 0, -1);
	titleBar:SetHeight(18);
	titleBar:Show();

	local titleText = VFLUI.CreateFontString(titleBar);
	titleText:SetPoint("BOTTOM", titleBar, "BOTTOM", 0, 2);
	titleText:SetHeight(14);
	VFLUI.SetFont(titleText, Fonts.Default, 10);
	titleText:SetJustifyH("CENTER"); titleText:Show();
	
	function self:SetText(txt) titleText:SetText(txt); end
	function self:SetTitleColor(r,g,b) end

	---------------------------- FIXED ELEMENT LAYOUT
	if self.SetInsets then
		self:SetInsets(7, 18, 7, 7);
	else
		local clientArea = self:GetClientArea();
		clientArea:ClearAllPoints();
		clientArea:SetPoint("TOPLEFT", decor, "TOPLEFT", 10, -10);
		clientArea:SetPoint("BOTTOMRIGHT", decor, "BOTTOMRIGHT", -10, 10);
		function self:Accomodate(dx, dy)
			self:SetWidth(dx+60); self:SetHeight(dy + 60);
		end
	end

	----------------------------- LAYOUT OPERATORS
	function self:_FrameLayout()
		VFLUI.Window.RightButtonStrip(self, 12, self, "TOPRIGHT", -6, -11);
		-- Restore frame sublevel relationships, we hope.
		decor:SetFrameLevel(self:GetFrameLevel() + 1);
		titleBar:SetFrameLevel(self:GetFrameLevel()+ 1);
	end

	function self:_FrameResize()
		local l,r = self:GetLeft(), self:GetRight();
		if not l then return; end
		local tw = math.abs(r-l);
		local mtw = VFL.clamp(tw - (table.getn(self.ctlButtons) * 12) - 5, 0, 10000);
		titleBar:SetWidth(mtw); titleText:SetWidth(mtw);
		if not self.SetInsets then
			local ca = self:GetClientArea();
			ca:SetWidth(tw-30); ca:SetHeight(self:GetHeight() - 30);
		end
		--decor:SetBackdrop(VFLUI.DefaultDialogBackdrop); 
	end

	function self:_FrameDestroy()
		self:SetBackdrop(nil); 
		decor:Destroy(); decor = nil;
		titleText:ClearAllPoints(); VFLUI.ReleaseRegion(titleText); titleText = nil;
	end

	self:_FrameLayout();
	self:_FrameResize();
end