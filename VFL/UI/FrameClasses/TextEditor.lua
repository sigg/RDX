-- TextEditor.lua
-- VFL
-- (C)2006 Bill Johnson
--
-- A frame that can be used to view and change long strings of text.

-- If the "ForAllIndentsAndPurposes" library is installed, allow the creation of syntax highlighted edit boxes.
VFLUI.CreateFramePool("LuaEditBox", function(pool, x)
	IndentationLib.disable(x)
	x:SetScript("OnEditFocusGained", nil);
	x:SetScript("OnEditFocusLost", nil);
	x:SetScript("OnEnterPressed", nil);
	x:SetScript("OnEscapePressed", nil);
	x:SetScript("OnTextSet", nil);
	x:SetAutoFocus(nil); x:ClearFocus();
	x:SetNumeric(nil); x:SetPassword(nil); x:SetMultiLine(nil);
	x:SetText(""); x:SetTextColor(1,1,1,1);
	VFLUI._CleanupFrame(x);
end, function()
	local f = CreateFrame("EditBox");
	return f;
end, function(_, f)
	IndentationLib.enable(f, nil, 2);
end);


VFLUI.TextEditor = {};
function VFLUI.TextEditor:new(parent, controlType, font)
	if type(controlType) ~= "string" then controlType = "EditBox"; end
	if type(font) ~= "table" then font = Fonts.Default; end

	local self = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(self, parent);
	self:SetBackdrop(VFLUI.BlackDialogBackdrop);

	local sf = VFLUI.VScrollFrame:new(self); sf:Show();
	sf:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	
	local txt = VFLUI.AcquireFrame(controlType);
	if not txt then error("invalid controlType"); end
	VFLUI.StdSetParent(txt, self, 1);
	VFLUI.SetFont(txt, font);
	txt:SetTextInsets(0,0,0,0);
	txt:SetAutoFocus(nil); txt:ClearFocus();
	txt:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
	txt:SetMultiLine(true); txt:Show();
	
	sf:SetScrollChild(txt);
	
	local function Layout()
		sf:SetWidth(self:GetWidth() - 26);
		sf:SetHeight(self:GetHeight() - 10);
		txt:SetWidth(sf:GetWidth());
	end
	self:SetScript("OnShow", Layout); self:SetScript("OnSizeChanged", Layout);
	self.DialogOnLayout = Layout;

	function self:SetText(x)
		txt:SetText(x);
	end

	function self:GetText() return txt:GetText(); end

	function self:GetEditWidget() return txt; end

	self.Destroy = VFL.hook(function(s)
		s.SetText = nil; s.GetText = nil;
		sf:SetScrollChild(nil);
		txt:Destroy(); txt = nil;
		sf:Destroy(); sf = nil;
	end, self.Destroy);
	
	return self;
end
