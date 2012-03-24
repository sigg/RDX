-- StatusBarTexture.lua
-- VFL
-- (C)2006 The VFL Project
--
-- A status bar system that provides some essential features missing from Blizzard's internal
-- StatusBar object.

local function statusBar_SetValueAndColorTable(self, v, c, t)
	self:SetValue(v, t); 
	self:SetVertexColor(c.r, c.g, c.b, c.a or 1);
end
local function statusBar_SetColorTable(self, c)
	if c then self:SetVertexColor(c.r, c.g, c.b, c.a or 1); end
end

local function newonupdateH(self, elapsed)
	self._totalElapsed = self._totalElapsed + elapsed
	if self._totalElapsed >= self.t then
		self._totalElapsed = 0;
		self.f:SetScript("OnUpdate", nil);
		self._bSetWidth(self, self.v*self.maxw + (1-self.v)*0.001);
		if self._horiFix then
			self:SetTexCoord(1-self.v, 1, 0, 1);
		else
			self:SetTexCoord(0, self.v, 0, 1);
		end
		self._value = self.v;
	else
		self._value = VFL.lerp1(1/self.t*self._totalElapsed, self._value, self.v);
		self._bSetWidth(self, self._value*self.maxw + (1-self._value)*0.001);
		if self._horiFix then
			self:SetTexCoord(1-self._value, 1, 0, 1);
		else
			self:SetTexCoord(0, self._value, 0, 1);
		end
	end
	if self.color1 then self2:SetVertexColor(VFL.CVFromCTLerp(self.color1, self.color2, self._value)); end
end

local function newonupdateV(self, elapsed)
	self._totalElapsed = self._totalElapsed + elapsed
	if self._totalElapsed >= self.t then
		self._totalElapsed = 0;
		self.f:SetScript("OnUpdate", nil);
		self._bSetHeight(self, self.v*self.maxh + (1-self.v)*0.001);
		if self._vertFix then
			self:SetTexCoord(0, 1, 1-self.v, 1);
		else
			self:SetTexCoord(0, 1, 0, self.v);
		end
		self._value = self.v;
	else
		self._value = VFL.lerp1(1/self.t*self._totalElapsed, self._value, self.v);
		self._bSetHeight(self, self._value*self.maxh + (1-self._value)*0.001);
		if self._vertFix then
			self:SetTexCoord(0, 1, 1-self._value, 1);
		else
			self:SetTexCoord(0, 1, 0, self._value);
		end
	end
	if self.color1 then self2:SetVertexColor(VFL.CVFromCTLerp(self.color1, self.color2, self._value)); end
end


--[[

local function onupdateH(self, elapsed, v, t, maxx)
	self._totalElapsed = self._totalElapsed + elapsed
	if self._totalElapsed >= t then
		self._totalElapsed = 0;
		self.f:SetScript("OnUpdate", nil);
		self._bSetWidth(self, v*maxx + (1-v)*0.001);
		self:SetTexCoord(0, v, 0, 1);
		self._value = v;
		return v;
	end
	offset = VFL.lerp1(1/t*self._totalElapsed, self._value, v);
	self._bSetWidth(self, offset*maxx + (1-offset)*0.001);
	self:SetTexCoord(0, offset, 0, 1);
	self._value = offset;
	return offset;
end

local function onupdateV(self, elapsed, v, t, maxx)
	self._totalElapsed = self._totalElapsed + elapsed
	if self._totalElapsed >= t then
		self._totalElapsed = 0;
		self.f:SetScript("OnUpdate", nil);
		self._bSetHeight(self, v*maxx + (1-v)*0.001);
		if self._vertFix then
			self:SetTexCoord(0, 1, 1-v, 1);
		else
			self:SetTexCoord(0, 1, 0, v);
		end
		self._value = v;
		return v;
	end
	offset = VFL.lerp1(1/t*self._totalElapsed, self._value, v);
	self._bSetHeight(self, offset*maxx + (1-offset)*0.001);
	if self._vertFix then
		self:SetTexCoord(0, 1, 1-offset, 1);
	else
		self:SetTexCoord(0, 1, 0, offset);
	end
	self._value = offset;
	return offset;
end
]]
VFLUI.StatusBarTexture = {};
function VFLUI.StatusBarTexture:new(parent, vertFix, horiFix, drawLayer, sublevel)
	local f = VFLUI.AcquireFrame("Frame");
	f:SetParent(parent);
	f:SetFrameLevel(parent:GetFrameLevel());
	f:SetWidth(1);
	f:SetHeight(1);
	f:Show();
	
	local s = VFLUI.CreateTexture(f);
	s:SetDrawLayer(drawLayer, sublevel);
	s:SetWidth(0.001); s:SetHeight(0.001);
	s.f = f;

	-- Internal state variables
	s.maxw = 0.001;
	s.maxh = 0.001;
	s.color1 = nil;
	s.color2 = nil;
	s._value = -1;
	s.v = nil;
	s.t = nil;
	s._vertFix = vertFix;
	s._horiFix = horiFix;
    
	s._bSetWidth, s._bSetHeight = s.SetWidth, s.SetHeight;
	local bSetWidth, bSetHeight = s._bSetWidth, s._bSetHeight;
	function s:SetWidth(w) s.maxw = w; bSetWidth(self, w); end
	function s:SetHeight(h) s.maxh = h; bSetHeight(self, h); end
	function s:SetColors(c1, c2) s.color1 = c1; s.color2 = c2; end
	
	function s:SetOrientation(o)
		bSetWidth(self, s.maxw); bSetHeight(self, s.maxh);
		if(o == "HORIZONTAL") then
			function self.SetValue(self2, v, t)
				if not v then return; end
				if v < 0 then v = 0.001; end
				if self2._value == v then return; end
				self2.v = v;
				self2.t = t;
				if self2.t then
					self2._totalElapsed = 0;
					self2.f:SetScript("OnUpdate", function(self3, elapsed) newonupdateH(self2, elapsed); end);
				else
					self.f:SetScript("OnUpdate", nil);
					bSetWidth(self2, self2.v*self2.maxw + (1-self2.v)*0.001);
					if self2._horiFix then
						self2:SetTexCoord(1-self2.v, 1, 0, 1);
					else
						self2:SetTexCoord(0, self2.v, 0, 1);
					end
					if self2.color1 then self2:SetVertexColor(VFL.CVFromCTLerp(self2.color1, self2.color2, self2.v)); end
					self2._value = self2.v;
				end
			end
		elseif(o == "VERTICAL") then
			function self.SetValue(self2, v, t)
				if not v then return; end
				if v < 0 then v = 0.001; end
				if self2._value == v then return; end
				self2.v = v;
				self2.t = t;
				if self2.t then
					self2._totalElapsed = 0;
					self2.f:SetScript("OnUpdate", function(self3, elapsed) newonupdateV(self2, elapsed); end);
				else
					self.f:SetScript("OnUpdate", nil);
					bSetHeight(self2, self2.v*self2.maxh + (1-self2.v)*0.001);
					if self2._vertFix then
						self2:SetTexCoord(0, 1, 1-self2.v, 1);
					else
						self2:SetTexCoord(0, 1, 0, self2.v);
					end
					if self2.color1 then self2:SetVertexColor(VFL.CVFromCTLerp(self2.color1, self2.color2, self2.v)); end
					self2._value = self2.v;
				end
			end
		end
	end

	s.SetValueAndColorTable = statusBar_SetValueAndColorTable;
	s.SetColorTable = statusBar_SetColorTable;

	s.Destroy = VFL.hook(function(s2)
		s2.f:SetScript("OnUpdate", nil);
		s2.SetValueAndColorTable = nil; s2.SetColorTable = nil;
		s2.SetOrientation = nil; s2.SetWidth = nil; s2.SetHeight = nil; s2.SetColors = nil;
		s2._totalElapsed = nil;
		s2.v = nil;
		s2.t = nil;
		s._value = nil;
		s2._vertFix = nil;
		s2._horiFix = nil;
		s2.color1 = nil;
		s2.color2 = nil;
		s2.maxw = nil;
		s2.maxh = nil;
		s2.f:Destroy();
		s2.f = nil;
	end, s.Destroy);
	return s;
end

----------------------------------
-- status bar + backdrop + icon
----------------------------------
-- StatusBarTextureIconBackdrop
VFLUI.SBTIB = {};
function VFLUI.SBTIB:new(parent, desc)
	if not desc.btype then desc.btype = "Frame"; end
	desc.w = tonumber(desc.w or 0);
	desc.h = tonumber(desc.h or 0);
	if not desc.borientation then desc.borientation = "HORIZONTAL"; end
	if not desc.banchor then desc.banchor = "LEFT"; end
	
	local f = VFLUI.AcquireFrame(desc.btype);
	f:SetParent(parent);
	f:SetFrameLevel(parent:GetFrameLevel());
	f:SetWidth(desc.w);
	f:SetHeight(desc.h);
	f:Show();
	
	local iw, ih, bw, bh = 0, 0, 0, 0;
	local ioffsetx, ioffsety, boffsetx, boffsety = 0, 0, 0, 0;
	
	if desc.bkd then
		local l, r, t, b = 0, 0, 0, 0;
		if desc.bkd.insets then
			l = tonumber(desc.bkd.insets.left or 0);
			r = tonumber(desc.bkd.insets.right or 0);
			t = tonumber(desc.bkd.insets.top or 0);
			b = tonumber(desc.bkd.insets.bottom or 0);
		end
		
		if desc.showicon and not desc.anchorbar then
			if desc.borientation == "VERTICAL" then
				iw = desc.w - l - r;
				ih = desc.w - t - b;
				bw = desc.w - l - r;
				bh = desc.h - ih - t - b;
				if desc.iconposition == "TOP" then
					ioffsetx, ioffsety, boffsetx, boffsety = l, bh + b, l, b;
				else
					ioffsetx, ioffsety, boffsetx, boffsety = l, b, l, ih + b;
				end
			else -- HORIZONTAL
				iw = desc.h - l - r;
				ih = desc.h - t - b;
				bw = desc.w - iw - l - r;
				bh = desc.h - t - b;
				if desc.iconposition == "RIGHT" then
					ioffsetx, ioffsety, boffsetx, boffsety = bw + l, b, l, b;
				else -- LEFT
					ioffsetx, ioffsety, boffsetx, boffsety = l, b, iw + l, b;
				end
			end
		else
			bw = desc.w - l - r;
			bh = desc.h - t - b;
			boffsetx, boffsety = l, b;
			if desc.borientation == "VERTICAL" then
				iw = desc.w - l - r;
				ih = desc.w - t - b;
			else
				iw = desc.h - l - r;
				ih = desc.h - t - b;
			end
		end
	else
		if desc.showicon and not desc.anchorbar then
			if desc.borientation == "VERTICAL" then
				iw, ih = desc.w, desc.w;
				bw, bh = desc.w, desc.h - desc.w;
				if desc.iconposition == "TOP" then
					ioffsetx, ioffsety, boffsetx, boffsety = 0, bh, 0, 0;
				else -- or BOTTOM
					ioffsetx, ioffsety, boffsetx, boffsety = 0, 0, 0, ih;
				end
			else
				iw, ih = desc.h, desc.h;
				bw, bh = desc.w - desc.h, desc.h;
				if desc.iconposition == "RIGHT" then
					ioffsetx, ioffsety, boffsetx, boffsety = bw, 0, 0, 0;
				else -- or LEFT
					ioffsetx, ioffsety, boffsetx, boffsety = 0, 0, iw, 0;
				end
			end
		else
			bw, bh = desc.w, desc.h;
			if desc.borientation == "VERTICAL" then
				iw, ih = desc.w, desc.w;
			else
				iw, ih = desc.h, desc.h;
			end
		end
	end
	
	-- backdrop
	if desc.bkd then
		VFLUI.SetBackdrop(f, desc.bkd);
	end
	
	-- statusbartexture
	f.bg = VFLUI.AcquireFrame("Frame");
	f.bg:SetParent(f);
	f.bg:SetWidth(bw);
	f.bg:SetHeight(bh);
	f.bg:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", boffsetx, boffsety);
	f.bg:Show();
	f.sb = VFLUI.StatusBarTexture:new(f.bg, nil, nil, "ARTWORK", 1);
	f.sb:SetParent(f.bg);
	f.sb:SetWidth(bw);
	f.sb:SetHeight(bh);
	f.sb:SetOrientation(desc.borientation);
	f.sb:SetPoint(desc.banchor, f.bg, desc.banchor);
	VFLUI.SetTexture(f.sb, desc.btexture);
	f.sb:Show();
	
	-- icon
	if desc.showicon then
		f.icon = VFLUI.CreateTexture(f);
		f.icon:SetWidth(iw);
		f.icon:SetHeight(ih);
		if desc.anchorbar then
			f.icon:SetPoint("CENTER", f.sb, desc.iconposition);
		else
			f.icon:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", ioffsetx, ioffsety);
		end
		f.icon:Show();
	end
	
	-- stacktxt
	if desc.showicon then
		f.stacktxt = VFLUI.CreateFontString(f);
		f.stacktxt:SetAllPoints(f.icon);
		VFLUI.SetFont(f.stacktxt, desc.stacktxt, nil, true);
		f.stacktxt:Show();
	else
		f.stacktxt = VFLUI.CreateFontString(f);
		f.stacktxt:SetAllPoints(f);
		VFLUI.SetFont(f.stacktxt, desc.stacktxt, nil, true);
		f.stacktxt:Show();
	end
	
	if desc.showname then
		-- nametxt
		f.nametxt = VFLUI.CreateFontString(f.bg);
		f.nametxt:SetAllPoints(f.bg);
		VFLUI.SetFont(f.nametxt, desc.nametxt, nil, true);
		f.nametxt:Show();
	end
	
	-- timetxt
	f.timetxt = VFLUI.CreateFontString(f.bg);
	f.timetxt:SetAllPoints(f.bg);
	VFLUI.SetFont(f.timetxt, desc.timetxt, nil, true);
	f.timetxt:Show();
	
	f.Destroy = VFL.hook(function(s2)
		VFLUI.ReleaseRegion(s2.timetxt); s2.timetxt = nil;
		if s2.nametxt then VFLUI.ReleaseRegion(s2.nametxt); s2.nametxt = nil; end
		VFLUI.ReleaseRegion(s2.stacktxt); s2.stacktxt = nil;
		s2.sb:Destroy(); s2.sb = nil;
		s2.bg:Destroy(); s2.bg = nil;
		if s2.icon then VFLUI.ReleaseRegion(s2.icon); s2.icon = nil; end
	end, f.Destroy);
	return f;
end
