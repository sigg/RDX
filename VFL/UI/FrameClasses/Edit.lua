-- Edit.lua
-- VFL
-- (C)2006 Bill Johnson
--
-- VFLized implementations of the WoW EditBox frame.


VFLUI.Edit = {};
--- Create a new single-line edit control.
function VFLUI.Edit:new(parent, overrideFix)
	local self = VFLUI.AcquireFrame("EditBox");

	if parent then
		self:SetParent(parent);
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end

	-- Appearance
	self:SetBackdrop(VFLUI.BlackDialogBackdrop);
	VFLUI.SetFont(self, Fonts.Default);
	self:SetTextInsets(5,5,5,5);
	self:SetAutoFocus(nil); self:ClearFocus();

	-- Scripts
	self:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
	
	-- Fix the dumb edit cursor bug, unless the coder doesn't want it fixed.
	if not overrideFix then
		local oldSetText = self.SetText;
		function self:SetText(txt)
			if not txt then txt = ""; end
			oldSetText(self, txt);
			VFLUI.FixEditBoxCursor(self);
		end

		self.Destroy = VFL.hook(function(s) s.SetText = nil; end, self.Destroy);
	end
	
	return self;
end

--- This function resets the cursor position in an EditBox on the next frame.
-- From http://www.wowwiki.com/HOWTO:_Scroll_EditBoxes_to_the_left_programatically
function VFLUI.FixEditBoxCursor(eb)
	eb:SetScript("OnUpdate", function(self)
		self:HighlightText(0,1);
		self:Insert(" "..strsub(self:GetText(),1,1));
		self:HighlightText(0,1);
		self:Insert("");
		self:SetScript("OnUpdate", nil);
	end);
end

--- class VFLUI.LabeledEdit
-- An edit box with a label.
VFLUI.LabeledEdit = {};
function VFLUI.LabeledEdit:new(parent, editWidth)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent); self:SetFrameStrata(parent:GetFrameStrata()); self:SetFrameLevel(parent:GetFrameLevel());
	end

	self:SetHeight(24); self:Show();

	local editBox = VFLUI.Edit:new(self);
	editBox:SetHeight(24); editBox:SetWidth(editWidth);
	editBox:SetPoint("RIGHT", self, "RIGHT", 0, 0); editBox:SetText("");
	editBox:Show();
	self.editBox = editBox;

	local txt = VFLUI.CreateFontString(self);
	txt:SetPoint("TOPLEFT", self, "TOPLEFT");
	txt:SetPoint("BOTTOMRIGHT", editBox, "BOTTOMLEFT");
	VFLUI.SetFont(txt, Fonts.Default, 10);
	txt:SetJustifyV("CENTER"); txt:SetJustifyH("LEFT");
	txt:SetText(""); txt:Show();
	self.text = txt;

	self.SetText = function(s, t) s.text:SetText(t); end
	self.DialogOnLayout = VFL.Noop;

	self.Destroy = VFL.hook(function(s)
		s.DialogOnLayout = nil; s.SetText = nil;
		s.editBox:Destroy(); s.editBox = nil;
		VFLUI.ReleaseRegion(s.text); s.text = nil;
	end, self.Destroy);

	return self;
end
