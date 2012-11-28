-- ColorSwatch.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A control that allows the selection of colors.

VFLUI.ColorSwatch = {};
function VFLUI.ColorSwatch:new(parent)
	local self = VFLUI.AcquireFrame("Button");
	if parent then
		self:SetParent(parent); self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	self:SetHeight(16); self:SetWidth(16);
	self.r = 1; self.g = 1; self.b = 1; self.a = 1;
	
	local swatch = self:CreateTexture();
	swatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
	swatch:SetAllPoints(self);
	swatch:SetDrawLayer("ARTWORK", 2);
	swatch:Show(); self:SetNormalTexture(swatch);
		
	local border = VFLUI.CreateTexture(self);
	border:SetHeight(14); border:SetWidth(14); border:SetPoint("CENTER", self, "CENTER");
	border:SetTexture("Interface\\AddOns\\VFL\\Skin\\Checker");
	border:SetDrawLayer("BORDER", 1); border:Show();

	function self:SetColor(r, g, b, a)
		a = a or 1;
		self.r = r; self.g = g; self.b = b; self.a = a;
		swatch:SetVertexColor(r,g,b,a);
	end

	function self:SetColorTable(t)
		local r,g,b,a = t.r,t.g,t.b,(t.a or 1);
		self.r = r; self.g = g; self.b = b; self.a = a;
		swatch:SetVertexColor(r,g,b,a);
	end

	function self:SaveColor(dstTbl)
		dstTbl.r = self.r; dstTbl.g = self.g; dstTbl.b = self.b; dstTbl.a = self.a;
	end

	function self:GetColorValues()
		return self.r, self.g, self.b, self.a;
	end

	function self:GetColor()
		return {r=self.r, g=self.g, b=self.b, a = (self.a or 1)};
	end

	self.OnColorChanged = VFL.Noop;

	self:SetScript("OnClick", function(sw)
		local okFunc = function(r,g,b,a)
			sw:SetColor(r,g,b,a);
			sw:OnColorChanged();
		end
		local updateFunc = function(r,g,b,a)
			sw:SetColor(r,g,b,a);
		end;
		local previousValues = {r=sw.r, g=sw.g, b=sw.b, a=(sw.a or 1)};
		local cancelFunc = function()
			sw:SetColor(previousValues.r, previousValues.g, previousValues.b, previousValues.a);
		end;
		-- CHANGE this self
		VFLUI.ColorPicker(sw, okFunc, cancelFunc, updateFunc, sw.r, sw.g, sw.b, sw.a);
	end);

	self.Destroy = VFL.hook(function(s)
		VFLUI.ReleaseRegion(border); border = nil;
		if VFLUI.ColorPickerOwner() == s then VFLUI.CloseColorPicker(); end
		s.SetColor = nil; s.SaveColor = nil; s.GetColor = nil; s.GetColorValues = nil;
		s.SetColorTable = nil;
	end, self.Destroy);

	return self;
end
