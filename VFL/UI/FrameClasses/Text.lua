--- class VFLUI.SimpleText
-- An text frame
VFLUI.SimpleText = {};
function VFLUI.SimpleText:new(parent, nblines, width)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent); 
		self:SetFrameStrata(parent:GetFrameStrata()); 
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	self:SetHeight(12 * nblines); self:SetWidth(width); self:Show();

	local txt = VFLUI.CreateFontString(self);
	txt:SetPoint("TOPLEFT", self, "TOPLEFT");
	txt:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
	VFLUI.SetFont(txt, Fonts.Default, 10);
	txt:SetJustifyV("TOP"); txt:SetJustifyH("LEFT");
	txt:SetText(""); txt:Show();
	self.text = txt;

	self.SetText = function(s, t) s.text:SetText(t); end

	self.Destroy = VFL.hook(function(s)
		s.SetText = nil;
		VFLUI.ReleaseRegion(s.text); s.text = nil;
	end, self.Destroy);

	return self;
end

VFLUI.StaticText = {};
function VFLUI.StaticText:new(parent, tt)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent); 
		self:SetFrameStrata(parent:GetFrameStrata()); 
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	--self:SetHeight(12 * nblines); self:SetWidth(width); 
	self:Show();

	local txt = VFLUI.CreateFontString(self);
	txt:SetPoint("TOPLEFT", self, "TOPLEFT");
	txt:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
	VFLUI.SetFont(txt, Fonts.Default, 10);
	txt:SetJustifyV("CENTER"); txt:SetJustifyH("CENTER");
	txt:SetText(""); txt:Show();
	self.text = txt;

	self.SetText = function(s, t) s.text:SetText(t); end

	self.Destroy = VFL.hook(function(s)
		s.SetText = nil;
		VFLUI.ReleaseRegion(s.text); s.text = nil;
	end, self.Destroy);

	return self;
end

VFLUI.SeparatorText = {};
function VFLUI.SeparatorText:new(parent, nblines, width)
	local self = VFLUI.AcquireFrame("Button");
	if parent then
		self:SetParent(parent); 
		self:SetFrameStrata(parent:GetFrameStrata()); 
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	self:SetHeight(12 * nblines); self:SetWidth(width); self:Show();

	local txt = VFLUI.CreateFontString(self);
	txt:SetAllPoints(self);
	VFLUI.SetFont(txt, Fonts.Default, 10);
	txt:SetJustifyV("TOP"); txt:SetJustifyH("LEFT");
	txt:SetText(""); txt:Show();
	self.text = txt;
	
	local tex = VFLUI.CreateTexture(self);
	tex:SetAllPoints(self);
	tex:SetTexture(0,0,0.6); tex:SetGradient("HORIZONTAL", 1,1,1,0.1,0.1,0.1);
	tex:Show();
	self.tex = tex;

	self.SetText = function(s, t) s.text:SetText(t); end

	self.Destroy = VFL.hook(function(s)
		s.SetText = nil;
		VFLUI.ReleaseRegion(s.tex); s.tex = nil;
		VFLUI.ReleaseRegion(s.text); s.text = nil;
	end, self.Destroy);

	return self;
end