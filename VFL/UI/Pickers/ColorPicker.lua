-- ColorPicker.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A VFL enhanced version of the WoW ColorPicker widget. Supports transparency,
-- copy/paste, and direct value entry.

local cur_r,cur_g,cur_b,cur_a = 1,1,1,1;

local clip_r, clip_g, clip_b, clip_a = nil, nil, nil, nil;

local onChange = VFL.Noop;
local onOK = VFL.Noop;
local onCancel = VFL.Noop;
local cp_owner = nil;

local cp = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(cp, 20);
cp:SetText("Color Picker");
cp:SetTitleColor(0,0,.6);
cp:SetWidth(325); cp:SetHeight(225);
cp:SetPoint("CENTER", VFLParent, "CENTER");
cp:SetMovable(true); cp:SetToplevel(true);
VFLUI.Window.StdMove(cp, cp:GetTitleBar());
cp:Hide();
cp:SetClampedToScreen(true);

--- Color select texture with wheel and value
local cs = CreateFrame("ColorSelect");
cs:SetParent(cp);
cs:SetWidth(128+32+5);
cs:SetHeight(128);
cs:SetPoint("TOPLEFT", cp:GetClientArea(), "TOPLEFT");
cs:Show();

local cw = cs:CreateTexture();
cw:SetWidth(128); cw:SetHeight(128);
cw:SetPoint("TOPLEFT", cs, "TOPLEFT", 5, 0);
cw:Show();
cs:SetColorWheelTexture(cw);

local cwtt = cs:CreateTexture();
cwtt:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons");
cwtt:SetWidth(10); cwtt:SetHeight(10);
cwtt:SetTexCoord(0,0.15625,0,0.625);
cwtt:Show();
cs:SetColorWheelThumbTexture(cwtt);

local cv = cs:CreateTexture();
cv:SetWidth(32); cv:SetHeight(128);
cv:SetPoint("LEFT", cw, "RIGHT", 10, -7);
cv:Show();
cs:SetColorValueTexture(cv);

local cvtt = cs:CreateTexture();
cvtt:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons");
cvtt:SetWidth(48); cvtt:SetHeight(14);
cvtt:SetTexCoord(0.25,1,0,0.875);
cvtt:Show();
cs:SetColorValueThumbTexture(cvtt);

--- Alpha slider.
local as = VFLUI.AcquireFrame("Slider");
as:SetParent(cs); as:SetFrameLevel(cs:GetFrameLevel() + 2);
as:SetMinMaxValues(0,1); as:SetValue(1);
as:SetOrientation("VERTICAL");
as:SetWidth(32); as:SetHeight(142);
as:SetPoint("LEFT", cv, "RIGHT", 15, 0);
as:Show();

local astt = as:CreateTexture();
astt:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons");
astt:SetWidth(48); astt:SetHeight(14);
astt:SetTexCoord(0.25,1,0,0.875);
astt:Show();
as:SetThumbTexture(astt);

local as_bkd = VFLUI.AcquireFrame("Frame");
as_bkd:SetParent(cs); as_bkd:SetFrameLevel(cs:GetFrameLevel() + 1);
as_bkd:SetPoint("TOPLEFT", as, "TOPLEFT", 0, -7);
as_bkd:SetWidth(as:GetWidth()); as_bkd:SetHeight(as:GetHeight() - 14);
as_bkd:SetBackdrop({
	bgFile="Interface\\Addons\\VFL\\Skin\\Checker", tile = true, tileSize = 15,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
});
as_bkd:Show();

local as_bkg = as:CreateTexture();
as_bkg:SetDrawLayer("ARTWORK");
as_bkg:SetPoint("TOPLEFT", as, "TOPLEFT", 0, -7);
as_bkg:SetWidth(as:GetWidth()); as_bkg:SetHeight(as:GetHeight() - 14);
as_bkg:Show();
as_bkg:SetTexture(1,1,1,1);

-- Swatch frame
local sf = VFLUI.AcquireFrame("Frame");
sf:SetParent(cp);
sf:SetWidth(64); sf:SetHeight(64);
sf:SetPoint("LEFT", as, "RIGHT", 13, 0);
sf:SetBackdrop({
	bgFile="Interface\\Addons\\VFL\\Skin\\Checker", tile = true, tileSize = 15,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
});
sf:Show();

local swatch = sf:CreateTexture();
swatch:SetAllPoints(sf);
swatch:SetTexture(1,1,1,1);
swatch:Show();

-- RGBA boxes
local function MakeBox(x)
	local b = VFLUI.Edit:new(cp);
	b:SetWidth(60); b:SetHeight(25); b:Show();

	local lbl = VFLUI.CreateFontString(cp);
	VFLUI.SetFont(lbl, Fonts.Default);
	lbl:SetWidth(12); lbl:SetHeight(25);
	lbl:SetPoint("RIGHT", b, "LEFT");
	lbl:Show(); lbl:SetText(x);

	return b;
end

local b_r = MakeBox("R");
b_r:SetPoint("BOTTOMLEFT", cp:GetClientArea(), "BOTTOMLEFT", 17, 30);
local b_g = MakeBox("G");
b_g:SetPoint("LEFT", b_r, "RIGHT", 17, 0);
local b_b = MakeBox("B");
b_b:SetPoint("LEFT", b_g, "RIGHT", 17, 0);
local b_a = MakeBox("A");
b_a:SetPoint("LEFT", b_b, "RIGHT", 17, 0);

-- Buttons
local btnCopy = VFLUI.Button:new(cp);
btnCopy:SetHeight(25); btnCopy:SetWidth(79);
btnCopy:SetPoint("BOTTOMLEFT", cp:GetClientArea(), "BOTTOMLEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local btnPaste = VFLUI.Button:new(cp);
btnPaste:SetHeight(25); btnPaste:SetWidth(79);
btnPaste:SetPoint("LEFT", btnCopy, "RIGHT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCancel = VFLUI.CancelButton:new(cp);
btnCancel:SetHeight(25); btnCancel:SetWidth(79);
btnCancel:SetPoint("LEFT", btnPaste, "RIGHT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnOK = VFLUI.OKButton:new(cp);
btnOK:SetHeight(25); btnOK:SetWidth(79);
btnOK:SetPoint("LEFT", btnCancel, "RIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

---------- SETTERS
local disable_text_update, disable_slider_update, disable_rgb_update = nil, nil, 0;

local function SetColor_Boxes(r,g,b,a)
	b_r:SetText(string.format("%0.3f", r));
	b_g:SetText(string.format("%0.3f", g));
	b_b:SetText(string.format("%0.3f", b));	
	b_a:SetText(string.format("%0.3f", a));
end

-- Respond to an alpha slider change
local function AlphaSlider()
	if disable_slider_update then
		disable_slider_update = nil; return;
	end
	local a = (1 - as:GetValue()); a = VFL.clamp(a,0,1);
	cur_a = a;
	swatch:SetVertexColor(cur_r,cur_g,cur_b,cur_a);
	disable_text_update = true;
	b_a:SetText(string.format("%0.3f", cur_a));
	onChange(cur_r, cur_g, cur_b, cur_a);
end

-- Respond to an alpha text change
local function AlphaText()
	if disable_text_update then
		disable_text_update = nil; return;
	end
	local a = VFL.clamp(b_a:GetNumber(), 0, 1);
	cur_a = a;
	swatch:SetVertexColor(cur_r, cur_g, cur_b, cur_a);
	disable_slider_update = true;
	as:SetValue(1-cur_a);
	onChange(cur_r, cur_g, cur_b, cur_a);
end

-- Respond to an RGB-setter change
local function RGBSlider(self, arg1, arg2, arg3)
	if disable_slider_update then
		disable_slider_update = nil; return;
	end
	local r = VFL.clamp(arg1, 0, 1);
	local g = VFL.clamp(arg2, 0, 1);
	local b = VFL.clamp(arg3, 0, 1);
	cur_r = r; cur_g = g; cur_b = b;
	-- Set text
	disable_rgb_update = 3;
	b_r:SetText(string.format("%0.3f", r));
	b_g:SetText(string.format("%0.3f", g));
	b_b:SetText(string.format("%0.3f", b));	
	-- Set colored things
	swatch:SetVertexColor(r, g, b, cur_a);
	as_bkg:SetGradientAlpha("VERTICAL",r,g,b,0,r,g,b,1);
	recurse_flag = nil;
	onChange(cur_r, cur_g, cur_b, cur_a);
end

-- Respond to an rgb text change
local function RGBText()
	if disable_rgb_update > 0 then
		disable_rgb_update = disable_rgb_update - 1; return;
	end
	local r = VFL.clamp(b_r:GetNumber(), 0, 1);
	local g = VFL.clamp(b_g:GetNumber(), 0, 1);
	local b = VFL.clamp(b_b:GetNumber(), 0, 1);
	cur_r = r; cur_g = g; cur_b = b;
	-- Set color wheel and other widgets
	disable_slider_update = true;
	cs:SetColorRGB(r,g,b);
	swatch:SetVertexColor(r,g,b,cur_a);
	as_bkg:SetGradientAlpha("VERTICAL",r,g,b,0,r,g,b,1);
	onChange(cur_r, cur_g, cur_b, cur_a);
end

as:SetScript("OnValueChanged", AlphaSlider);
b_a:SetScript("OnTextChanged", AlphaText);

cs:SetScript("OnColorSelect", RGBSlider);
b_r:SetScript("OnTextChanged", RGBText);
b_g:SetScript("OnTextChanged", RGBText);
b_b:SetScript("OnTextChanged", RGBText);


local function SetColor_All(r,g,b,a)
	-- Renormalize parameters
	r = VFL.clamp(r,0,1); g = VFL.clamp(g,0,1); b = VFL.clamp(b,0,1);
	if not a then a=1; end a = VFL.clamp(a,0,1);
	-- Setup widgets
	cs:SetColorRGB(r,g,b);
	swatch:SetVertexColor(r,g,b,a);
	as_bkg:SetGradientAlpha("VERTICAL",r,g,b,0,r,g,b,1);
	as:SetValue(1-a);
	cur_r = r; cur_g = g; cur_b = b; cur_a = a;
	recurse_flag = nil;
end

local function ClosePicker(nosmooth)
	--if nosmooth then
		cp:Hide();
		cur_r = 1; cur_g = 1; cur_b = 1; cur_a = 1; cp_owner = nil;
		onCancel = VFL.Noop; onOK = VFL.Noop; onChange = VFL.Noop;
	--else
	--	cp:_Hide(.2, nil, function()
	--		cur_r = 1; cur_g = 1; cur_b = 1; cur_a = 1; cp_owner = nil;
	--		onCancel = VFL.Noop; onOK = VFL.Noop; onChange = VFL.Noop;
	--	end);
	--end
end

local function CancelPicker(nosmooth)
	if not cp:IsShown() then return; end
	onCancel(cur_r, cur_g, cur_b, cur_a);
	ClosePicker(nosmooth);
end

local function OKPicker()
	if not cp:IsShown() then return; end
	onOK(cur_r, cur_g, cur_b, cur_a);
	ClosePicker();
end

btnCancel:SetScript("OnClick", function() CancelPicker(); end);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clip_r then SetColor_All(clip_r, clip_g, clip_b, clip_a); end
end);
btnCopy:SetScript("OnClick", function()
	clip_r = cur_r; clip_g = cur_g; clip_b = cur_b; clip_a = cur_a;
end);

--- Launch the color picker.
function VFLUI.ColorPicker(owner, fnOK, fnCancel, fnChange, r, g, b, a)
	-- Cancel any preexisting color picker.
	local smooth = .2;
	if cp:IsShown() then CancelPicker(true); smooth = nil; end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop; onChange = fnChange or VFL.Noop;
	cp_owner = owner;
	SetColor_All(r,g,b,a);
	cp:Show();
	--cp:_Show(smooth);
end
--- Check the color picker's owner.
function VFLUI.ColorPickerOwner() return cp_owner; end
--- Close the color picker.
function VFLUI.CloseColorPicker()
	ClosePicker();
end
