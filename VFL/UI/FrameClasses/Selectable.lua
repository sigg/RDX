-- Frame_Selectable.lua
-- VFL - Venificus' Function Library
-- (C)2006 Bill Johnson (Venificus of Eredar server)
--
-- The Selectable frame class is a utility frame class for use in menus, etc.
--

VFLUI.Selectable = {};

--- Create a new Selectable.
function VFLUI.Selectable:new(_, font)
	font = font or Fonts.Default;
	local self = VFLUI.AcquireFrame("Button");
	
	-- Create the button highlight texture
	local hltTexture = VFLUI.CreateTexture(self);
	hltTexture:SetAllPoints(self);
	hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	hltTexture:Show();
	self:SetHighlightTexture(hltTexture);
	-- Create the selection texture
	local selTexture = VFLUI.CreateTexture(self);
	selTexture:Hide();
	selTexture:SetDrawLayer("ARTWORK", 1);
	selTexture:SetAllPoints(self);
	selTexture:SetTexture(1, 1, 1, 1);
	self.selTexture = selTexture;
	-- Create the text
	local text = VFLUI.CreateFontString(self);
	text:SetDrawLayer("OVERLAY");
	text:SetAllPoints(self); text:Show();
	VFLUI.SetFont(text, font);
	text:SetTextColor(1,1,1,1);
	text:SetJustifyH("LEFT");
	self.text = text;
	-- Create the icons
	local icon = VFLUI.CreateTexture(self);
	icon:SetDrawLayer("OVERLAY"); icon:Hide();
	icon:SetWidth(12); icon:SetHeight(12);
	self.icon = icon;
	icon = VFLUI.CreateTexture(self);
	icon:SetDrawLayer("OVERLAY"); icon:Hide();
	icon:SetWidth(12); icon:SetHeight(12);
	self.icon2 = icon;
	-- Repurposing: functions
	local pfuncs = {};
	pfuncs[1] = function(self)
		local dx,dy = self:GetWidth(), self:GetHeight();
		self.text:SetPoint("TOPLEFT", self, "TOPLEFT");
		self.text:SetWidth(dx-1); self.text:SetHeight(dy); self.text:SetJustifyH("LEFT");
		self.icon:Hide(); self.icon2:Hide();
	end
	pfuncs[2] = function(self)
		local dx,dy = self:GetWidth(), self:GetHeight();
		self.text:SetPoint("TOPLEFT", self, "TOPLEFT");
		self.text:SetWidth(dx-1); self.text:SetHeight(dy); self.text:SetJustifyH("LEFT");
		self.icon:ClearAllPoints(); self.icon:SetPoint("RIGHT", self, "RIGHT");
		self.icon2:Hide();
	end
	pfuncs[3] = function(self)
		local dx,dy = self:GetWidth(), self:GetHeight();
		self.text:SetPoint("TOPLEFT", self, "TOPLEFT");
		self.text:SetWidth(dx-1); self.text:SetHeight(dy); self.text:SetJustifyH("RIGHT");
		self.icon:ClearAllPoints(); self.icon:SetPoint("LEFT", self, "LEFT");
		self.icon2:Hide();
	end
	pfuncs[4] = function(self)
		local dx,dy = self:GetWidth(), self:GetHeight();
		self.icon:ClearAllPoints(); self.icon:SetPoint("LEFT", self, "LEFT");
		self.text:ClearAllPoints();
		self.text:SetPoint("LEFT", self.icon, "RIGHT");
		self.text:SetWidth(dx-(self.icon:GetWidth())); self.text:SetHeight(dy); self.text:SetJustifyH("LEFT");
		self.icon2:Hide();
	end
	-- Repurposing functor
	self.pfunc = pfuncs[1];
	self.SetPurpose = function(self, n)
		if(self.pfunc ~= pfuncs[n]) then 
			self.pfunc = pfuncs[n];
			self:pfunc();
		end
	end
	-- Resize handler
	self:SetScript("OnSizeChanged", function(self) self:pfunc(); end);

	-- Local functionality
	self.Select = function(x)
		x.selTexture:SetVertexColor(0,0,1,0.3);
		x.selTexture:Show();
	end
	self.Unselect = function(x)
		x.selTexture:Hide();
	end

	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	-- Append destroy handler
	self.Destroy = VFL.hook(function(s)
		s.pfunc = nil;
		s.SetPurpose = nil;
		s.Select = nil; s.Unselect = nil;
		-- Destroy allocated regions
		VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
		VFLUI.ReleaseRegion(s.selTexture);
		s.selTexture = nil; 
		VFLUI.ReleaseRegion(s.text);
		s.text = nil;
		VFLUI.ReleaseRegion(s.icon);
		s.icon = nil; 
		VFLUI.ReleaseRegion(s.icon2);
		s.icon2 = nil;
	end, self.Destroy);

	return self;
end

--- A simple ApplyData function to apply text to a selectable cell.
function VFLUI.Selectable.ApplyData_TextOnly(cell, data)
	cell.icon:Hide(); cell.icon2:Hide();
	cell:Enable(); cell:Show();
	cell.text:SetText(data.text);
	if(data.hlt) then
		cell.selTexture:SetVertexColor(data.hlt.r, data.hlt.g, data.hlt.b, data.hlt.a);
		cell.selTexture:Show();
	else
		cell.selTexture:Hide();
	end
	cell:SetScript("OnClick", data.OnClick);
	cell:SetScript("OnMouseDown", data.OnMouseDown);
	cell:SetScript("OnMouseUp", data.OnMouseUp);
end

--- A simple AcquireCell function for Selectables.
function VFLUI.Selectable.AcquireCell()
	local c = VFLUI.Selectable:new();
	c.OnDeparent = c.Destroy;
	return c;
end

--- A simple AcquireCell function for Selectables.
function VFLUI.Selectable.AcquireCell_smallFont()
	local c = VFLUI.Selectable:new(_, Fonts.Default8);
	c.OnDeparent = c.Destroy;
	return c;
end
