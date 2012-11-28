-- Dropdown.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A dropdown box allows the selection of something from a predefined list.
-- Closely related, the combo box is an edit control with an attached dropdown
-- list that also allows the entry of custom data.

-- Helper popup function for a dropdown.
local function dd_popup(btn)
	local self = btn:GetParent(); -- The dropdown is the parent of the button.
	if VFL.poptree:IsInUse() then VFL.Escape(); return; end
	VFL.poptree:Begin(math.max(self:GetWidth() - 10, 24), 12, self);
	-- TODO: Some temp table and closure spam here, try to get rid of it?
	local mnu = self.onBuild();
	for _,mentry in ipairs(mnu) do
		local x,y = mentry.text, mentry.value;
		mentry.OnClick = function() self:SetSelection(x,y); VFL.poptree:Release(); end
	end
	VFL.poptree:Expand(nil, mnu, self.limit);
end

VFLUI.Dropdown = {};
function VFLUI.Dropdown:new(parent, onBuild, onSelChanged, initText, initValue, limit)
	if not onBuild then error("expected onBuild function, got nil"); end
	if not onSelChanged then onSelChanged = VFL.Noop; end
	if initText then
		if not initValue then initValue = initText; end
	end

	local self = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(self, parent);
	self:SetBackdrop(VFLUI.BlackDialogBackdrop); self:SetHeight(25);
	self.onBuild = onBuild;
	
	if not limit then limit = 20; end
	self.limit = limit;

	local selTxt, selValue = initText, initValue;
	
	local txt = VFLUI.CreateFontString(self);
	txt:SetPoint("LEFT", self, "LEFT", 5, 0); txt:SetHeight(12);
	VFLUI.SetFont(txt, Fonts.Default);
	txt:SetJustifyH("LEFT");
	if initText then txt:SetText(initText); end
	txt:Show();

	local function Layout()
		txt:SetWidth(math.max(self:GetWidth() - 22, 0));
	end
	self:SetScript("OnShow", Layout);
	self:SetScript("OnSizeChanged", Layout);

	function self:RawSetSelection(text, value)
		if not value then value = text; end
		selTxt = text; selValue = value;
		txt:SetText(selTxt or "");
	end

	function self:SetSelection(text, value, flag)
		if not value then value = text; end
		selTxt = text; txt:SetText(selTxt or "");
		if(selValue ~= value) then
			selValue = value;
			if not flag then
				onSelChanged(value);
			end
		end
	end

	function self:GetSelection() return selTxt, selValue; end
	function self:GetText() return selTxt; end
	
	local btn = VFLUI.AcquireFrame("Button");
	btn:SetParent(self);
	btn:SetFrameLevel(self:GetFrameLevel() + 2);
	btn:SetHeight(12); btn:SetWidth(12);
	btn:SetNormalTexture("Interface\\Addons\\VFL\\Skin\\sb_down");
	btn:SetPoint("RIGHT", self, "RIGHT", -5, 0); btn:Show();
	btn:SetScript("OnClick", dd_popup);

	self.DialogOnLayout = VFL.Noop;

	self.Destroy = VFL.hook(function(s)
		if VFL.poptree:IsInUse() then VFL.Escape(); end
		VFLUI.ReleaseRegion(txt); txt = nil;
		btn:Destroy(); btn = nil;
		s.onBuild = nil;
		s.SetSelection = nil; s.GetSelection = nil; s.RawSetSelection = nil;
		s.GetText = nil; s.limit = nil;
	end, self.Destroy);

	return self;
end

-- A combo box allows the selection of stuff from a predefined list, as well as
-- direct manual entry.
local function cb_popup(btn)
	local self = btn:GetParent(); -- combo is parent of btn
	if VFL.poptree:IsInUse() then VFL.Escape(); return; end
	VFL.poptree:Begin(math.max(self:GetWidth() - 24, 24), 12, self);
	local mnu = self.onBuild();
	for _,mentry in ipairs(mnu) do
		local x = mentry.value or mentry.text;
		mentry.OnClick = function() self:SetText(x); VFL.poptree:Release(); end
	end
	VFL.poptree:Expand(nil, mnu, self.limit);
end

VFLUI.ComboBox = {};
function VFLUI.ComboBox:new(parent, onBuild, initText, limit)
	if not onBuild then error("expected onBuild function, got nil"); end

	local self = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(self, parent);
	self:SetHeight(24);
	self.onBuild = onBuild;
	
	if not limit then limit = 20; end
	self.limit = limit;

	local ed = VFLUI.Edit:new(self);
	ed:SetPoint("LEFT", self, "LEFT"); ed:SetHeight(24); ed:Show();
	if initText then ed:SetText(initText); end
	self.editBox = ed;
	
	local function Layout()
		ed:SetWidth(math.max(self:GetWidth() - 24, 0));
	end
	self:SetScript("OnShow", Layout);
	self:SetScript("OnSizeChanged", Layout);

	function self:SetText(text)	self.editBox:SetText(text or "");	end
	function self:GetText() return self.editBox:GetText(); end
	self.SetSelection = self.SetText; -- COMPAT with dropdown
	self.GetSelection = self.GetText; -- COMPAT with dropdown
	
	local btn = VFLUI.Button:new(self);
	btn:SetPoint("RIGHT", self, "RIGHT");
	btn:SetHeight(24); btn:SetWidth(24); btn:SetText("..."); btn:Show();
	btn:SetScript("OnClick", cb_popup);

	self.DialogOnLayout = VFL.Noop;

	self.Destroy = VFL.hook(function(s)
		if VFL.poptree:IsInUse() then VFL.Escape(); end
		s.editBox:Destroy(); s.editBox = nil;
		btn:Destroy(); btn = nil;
		s.onBuild = nil;
		s.SetText = nil; s.GetText = nil; s.SetSelection = nil; s.GetSelection = nil; s.limit = nil;
	end, self.Destroy);

	return self;
end
