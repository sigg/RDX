-- OpenRDX
-- Sigg Rashgaroth

-------------------------------------------------------
-- Cooldown count widget
-- This is just a cooldown with a fontstring optionally bolted onto it.
-------------------------------------------------------
VFLUI.CooldownCounter = {};
function VFLUI.CooldownCounter:new(parent, cooldown)
	if not cooldown.UpdateSpeed or type(cooldown.UpdateSpeed) ~= "number" then cooldown.UpdateSpeed = 0.5; end
	if not cooldown.HideText or type(cooldown.HideText) ~= "number" then cooldown.HideText = 0; end
	local s = VFLUI.AcquireFrame("Frame");
	s:SetParent(parent); s:SetFrameLevel(parent:GetFrameLevel() + 2);

	-- If desired, create the cooldown graphic.
	if cooldown.TimerType == "COOLDOWN&TEXT" or cooldown.TimerType == "COOLDOWN" then
		s.cd = VFLUI.AcquireFrame("Cooldown");
		s.cd:SetParent(parent); s.cd:SetFrameLevel(parent:GetFrameLevel() + 1);
		s.cd:SetReverse(cooldown.GfxReverse);
		s.cd:SetAllPoints(s); s.cd:Hide();
	end
	
	-- Create a FontString subcontrol for number display.
	s.fs = VFLUI.CreateFontString(s);
	s.fs:SetPoint("CENTER", s, "CENTER", cooldown.Offsetx, cooldown.Offsety);
	s.fs:SetWidth(parent:GetWidth() + 50); s.fs:SetHeight(parent:GetHeight() + 50);
	s.fs:Show();
	VFLUI.SetFont(s.fs, cooldown.Font);
	
	function s:SetCooldown(start, duration)
		if start == 0 then
			self.expiration = 0;
			if self.cd then self.cd:Hide(); end
			return;
		end
		self.expiration = start + duration;
		if self.cd then self.cd:Show(); self.cd:SetCooldown(start, duration); end
	end

	if cooldown.TimerType == "COOLDOWN&TEXT" or cooldown.TimerType == "TEXT" then
		s.transform = VFLUI.GetTextTimerTypesFunction(cooldown.TextType);
		s.expiration = 0;
		local lastUpdate = 0;
		local t, u;
		s:SetScript("OnUpdate", function(self)
			-- Throttle
			t = GetTime();	if (t - lastUpdate) < cooldown.UpdateSpeed then return; end
			lastUpdate = t;
			-- Update
			u = self.expiration - t;
			if u > 0 and u > cooldown.HideText then
				self.fs:SetText(self.transform(u));
			else
				self.fs:SetText("");
			end
		end);
	end

	s.Destroy = VFL.hook(function(self)
		if self.cd then self.cd:Destroy(); self.cd = nil; end
		self.SetCooldown = nil;
		self.transform = nil; self.expiration = nil;
		self.fs:Destroy(); self.fs = nil;
	end, s.Destroy);

	return s;
end
