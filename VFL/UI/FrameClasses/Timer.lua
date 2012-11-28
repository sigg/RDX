
VFLUI.TimerWidget = {};
function VFLUI.TimerWidget:new(parent)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent); self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	local txt1 = VFLUI.CreateFontString(self);
	VFLUI.SetFont(txt1, Fonts.BastardusSans, 12);
	txt1:SetDrawLayer("OVERLAY"); txt1:SetJustifyH("RIGHT");
	txt1:SetJustifyV("BOTTOM");
	txt1:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT");
	txt1:Show();

	local txt2 = VFLUI.CreateFontString(self);
	VFLUI.SetFont(txt2, Fonts.BastardusSans, 12);
	txt2:SetDrawLayer("OVERLAY"); txt2:SetJustifyH("LEFT"); 
	txt2:SetJustifyV("BOTTOM");
	txt2:SetPoint("LEFT", txt1, "RIGHT", 0, 0);
	txt2:Show();
	
	local function Layout()
		local w = math.max(self:GetWidth(), 0);
		local h = math.max(self:GetHeight(), 0);
		VFLUI.SetFont(txt2, Fonts.BastardusSans, h*0.6);
		txt2:SetHeight(h*.6); txt2:SetWidth(h*1.2);
		txt2:SetPoint("LEFT", txt1, "RIGHT", 0, -(h*.15));

		VFLUI.SetFont(txt1, Fonts.BastardusSans, h);
		txt1:SetHeight(h); 
		txt1:SetWidth(math.max(w-(h*1.2), 0));
	end
	self:SetScript("OnShow", Layout);
	self:SetScript("OnSizeChanged", Layout);

	local t = 0;
	function self:SetTime(sec)
		t = sec;
		if(sec < 0) then sec = 0; end
		local s = math.floor(sec); local frac = (sec - s)*100;
		local m = math.floor(sec/60); sec = VFL.mmod(sec, 60);
		txt1:SetText(string.format("%d:%02d", m, sec));
		txt2:SetText(string.format("%02d", frac));
	end

	function self:GetTime() return t; end

	self.Destroy = VFL.hook(function(s)
		s.SetTime = nil; s.GetTime = nil;
		VFLUI.ReleaseRegion(txt1); txt1 = nil;
		VFLUI.ReleaseRegion(txt2); txt2 = nil;
	end, self.Destroy);
	
	return self;
end
