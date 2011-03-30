-- StatusBar.lua
-- VFL
-- (C)2008 The VFL Project
--
-- Standard Blizzard status bars with extra modifications.

local function statusBar_SetValueAndColorTable(self, v, c, t)
	self:SetValue(v, t); 
	self:SetVertexColor(c.r, c.g, c.b, c.a or 1);
end

local function statusBar_SetColorTable(self, c)
	self:SetVertexColor(c.r, c.g, c.b, c.a or 1);
end

local function statusBar_SetVertexColor(self,r,g,b,a)
	self:SetStatusBarColor(r,g,b,a);
end

local function statusBar_SetBlendMode(self, mode)
	if self:GetStatusBarTexture() then
		self:GetStatusBarTexture():SetBlendMode(mode);
	end
end

local function statusBar_SetTexture(self, tex, g, b, a)
	if g then
		self:SetStatusBarColor(tex,g,b,a);
	else
		self:SetStatusBarTexture(tex);
	end
end

-- TODO:
-- Set a default all white texture for the status bar.
VFLUI.StatusBar = {};
function VFLUI.StatusBar:new(parent)
	local self = VFLUI.AcquireFrame("StatusBar");
	self:SetParent(parent);
	self:SetMinMaxValues(0,1);
	self:SetFrameStrata(parent:GetFrameStrata());
	self:SetFrameLevel(parent:GetFrameLevel());
	self.SetValueAndColorTable = statusBar_SetValueAndColorTable;
	self.SetColorTable = statusBar_SetColorTable;
	self.SetTexture = self.SetStatusBarTexture;
	self.GetTexture = self.GetStatusBarTexture;
	self.SetBlendMode = statusBar_SetBlendMode;
	self.SetVertexColor = statusBar_SetVertexColor;
	
	self.color1 = nil; self.color2 = nil;
	function self:SetColors(c1, c2) self.color1 = c1; self.color2 = c2; end
	
	self._blizzSetValue = self.SetValue;
	
	self.SetValue = function(self, v)
		self:_blizzSetValue(v);
		if self.color1 then
			self:SetVertexColor(VFL.CVFromCTLerp(self.color1, self.color2, v));
		end
	end;
	
	self.Destroy = VFL.hook(function(s2)
		s2.SetValueAndColorTable = nil; s2.SetColorTable = nil;
		self.color1 = nil; self.color2 = nil;
		self.SetValue = self._blizzSetValue; self._blizzSetValue = nil;
	end, self.Destroy);
	
	return self;
end

