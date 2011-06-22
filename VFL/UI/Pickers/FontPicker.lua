-- FontPicker.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A window that allows a font to be chosen visually.

local curFont, clipboard = {}, nil;
local onOK, onCancel, fp_owner = VFL.Noop, VFL.Noop, nil;
local UpdateFontPicker;

-- Font picker window
local fp = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(fp, 20);
fp:SetText("Font Picker");
fp:SetTitleColor(0,0,.6);
fp:SetWidth(330); fp:SetHeight(301);
fp:SetPoint("CENTER", VFLParent, "CENTER");
fp:SetMovable(true); fp:SetToplevel(nil);
VFLUI.Window.StdMove(fp, fp:GetTitleBar());
fp:Hide();
local ca = fp:GetClientArea();

------ Font preview
local lbl = VFLUI.MakeLabel(nil, fp, "Preview");
lbl:SetWidth(120);
lbl:SetPoint("TOPLEFT", ca, "TOPLEFT");

-- Background
local pvwf = VFLUI.AcquireFrame("Frame");
pvwf:SetParent(ca); pvwf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
pvwf:SetWidth(120); pvwf:SetHeight(180);
pvwf:SetBackdrop(VFLUI.DefaultDialogBackdrop);
pvwf:Show();

local pvwBkg = VFLUI.CreateTexture(pvwf);
pvwBkg:SetDrawLayer("ARTWORK");
pvwBkg:SetPoint("TOPLEFT", pvwf, "TOPLEFT", 5, -5);
pvwBkg:SetWidth(110); pvwBkg:SetHeight(170);
pvwBkg:SetTexture(.5,.5,.5,1); pvwBkg:Show();

local pvw = VFLUI.CreateFontString(pvwf);
pvw:SetDrawLayer("OVERLAY");
pvw:SetPoint("TOPLEFT", pvwf, "TOPLEFT", 5, -5);
pvw:SetWidth(110); pvw:SetHeight(170); pvw:Show();
VFLUI.SetFont(pvw, Fonts.Default, nil, true);
pvw:SetText("Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?, daniel ly");

-------- Face selector
local lbl2 = VFLUI.MakeLabel(nil, fp, "Face");
lbl2:SetWidth(136);
lbl2:SetPoint("TOPLEFT", lbl, "TOPRIGHT");

local fs_decor = VFLUI.AcquireFrame("Frame");
fs_decor:SetParent(ca);
fs_decor:SetPoint("TOPLEFT", pvwf, "TOPRIGHT");
fs_decor:SetWidth(136); fs_decor:SetHeight(180);
fs_decor:SetBackdrop(VFLUI.DefaultDialogBorder); fs_decor:Show();

local fs = VFLUI.List:new(ca, 12, VFLUI.Selectable.AcquireCell);
fs:SetPoint("TOPLEFT", fs_decor, "TOPLEFT", 5, -5);
fs:SetWidth(126); fs:SetHeight(170); fs:Show();
fs:SetDataSource(function(cell, data, pos)
	-- Select the current face
	if curFont.face and (data.path == curFont.face) then
		cell:Select();
	else
		cell:Unselect();
	end
	-- Apply the text
	cell.text:SetFont(data.path, 12);
	cell.text:SetText(data.name);
	cell:SetScript("OnClick", function()
		curFont.face = data.path;
		UpdateFontPicker();
	end);
end, VFL.ArrayLiterator(VFLUI._GetFontFaces()));
fs:Rebuild();

---------- Size selector
local sizes = {};
for i=4,20 do sizes[i-3] = i; end

lbl = VFLUI.MakeLabel(nil, fp, "Size");
lbl:SetWidth(65);
lbl:SetPoint("TOPLEFT", lbl2, "TOPRIGHT");

local ss_decor = VFLUI.AcquireFrame("Frame");
ss_decor:SetParent(ca);
ss_decor:SetPoint("TOPLEFT", fs_decor, "TOPRIGHT");
ss_decor:SetWidth(65); ss_decor:SetHeight(180);
ss_decor:SetBackdrop(VFLUI.DefaultDialogBorder); ss_decor:Show();

local ss = VFLUI.List:new(ca, 12, VFLUI.Selectable.AcquireCell);
ss:SetPoint("TOPLEFT", ss_decor, "TOPLEFT", 5, -5);
ss:SetWidth(55); ss:SetHeight(170); ss:Show();
ss:SetDataSource(function(cell, data, pos)
	-- Select the current face
	if curFont.size and (data == curFont.size) then
		cell:Select();
	else
		cell:Unselect();
	end
	-- Apply the text
	cell.text:SetText(data);
	cell:SetScript("OnClick", function() curFont.size = data;	UpdateFontPicker();	end);
end, VFL.ArrayLiterator(sizes));
ss:Rebuild();

----------- Halign
local hadd = {
	{ text = "LEFT" },
	{ text = "CENTER" },
	{ text = "RIGHT" }
};
function VFLUI.HAlignDropdownFunction() return hadd; end

lbl2 = VFLUI.MakeLabel(nil, ca, "Horizontal align:");
lbl2:SetWidth(80); lbl2:SetPoint("TOPLEFT", pvwf, "BOTTOMLEFT", 0, -5);

local dd_halign = VFLUI.Dropdown:new(ca, VFLUI.HAlignDropdownFunction, function(algn)
	curFont.justifyH = algn;
	UpdateFontPicker();
end);
dd_halign:SetWidth(80); dd_halign:SetPoint("LEFT", lbl2, "RIGHT");
dd_halign:Show();

----------- Valign
local vadd = {
	{ text = "TOP" },
	{ text = "CENTER" },
	{ text = "BOTTOM" }
};
function VFLUI.VAlignDropdownFunction() return vadd; end

lbl = VFLUI.MakeLabel(nil, ca, "Vertical align:");
lbl:SetWidth(80); lbl:SetPoint("LEFT", dd_halign, "RIGHT", 0, 0);

local dd_valign = VFLUI.Dropdown:new(ca, VFLUI.VAlignDropdownFunction, function(algn)
	curFont.justifyV = algn;
	UpdateFontPicker();
end);
dd_valign:SetWidth(80); dd_valign:SetPoint("LEFT", lbl, "RIGHT");
dd_valign:Show();

----------- Dropshadow
local DropShadowUpdate;

local chk_ds = VFLUI.Checkbox:new(ca);
chk_ds:SetHeight(16); chk_ds:SetWidth(90);
chk_ds:SetPoint("TOPLEFT", lbl2, "BOTTOMLEFT", 0, -5);
chk_ds:SetText("Drop shadow"); chk_ds:Show();
chk_ds.check:SetScript("OnClick", function() DropShadowUpdate(); end);

local cs_ds = VFLUI.ColorSwatch:new(ca);
cs_ds:SetPoint("LEFT", chk_ds, "RIGHT", 0, -1); cs_ds:Show();
cs_ds:SetColor(0,0,0,1);
function cs_ds:OnColorChanged() DropShadowUpdate(); end

function DropShadowUpdate()
	if chk_ds:GetChecked() then
		curFont.sx = 1; curFont.sy = -1;
		local r,g,b,a = cs_ds:GetColorValues();
		curFont.sr = r; curFont.sg = g; curFont.sb = b; curFont.sa = a;
	else
		curFont.sx = 0; curFont.sy = 0;
		curFont.sr = nil; curFont.sg = nil; curFont.sb = nil; curFont.sa = nil;
	end
	UpdateFontPicker();
end

----------- Default color
local DefaultColorUpdate;

local chk_dcolor = VFLUI.Checkbox:new(ca);
chk_dcolor:SetHeight(16); chk_dcolor:SetWidth(90);
chk_dcolor:SetPoint("LEFT", cs_ds, "RIGHT", 3, 0);
chk_dcolor:SetText("Default color"); chk_dcolor:Show();
chk_dcolor.check:SetScript("OnClick", function() DefaultColorUpdate(); end);

local cs_dcolor = VFLUI.ColorSwatch:new(ca);
cs_dcolor:SetPoint("LEFT", chk_dcolor, "RIGHT", 0, -1); cs_dcolor:Show();
cs_dcolor:SetColor(1,1,1,1);
function cs_dcolor:OnColorChanged() DefaultColorUpdate(); end

function DefaultColorUpdate()
	if chk_dcolor:GetChecked() then
		local r,g,b,a = cs_dcolor:GetColorValues();
		curFont.cr = r; curFont.cg = g; curFont.cb = b; curFont.ca = a;
	else
		curFont.cr = nil; curFont.cg = nil; curFont.cb = nil; curFont.ca = nil;
	end
	UpdateFontPicker();
end

----------- FLAGS
local FlagsUpdate;

local rg = VFLUI.RadioGroup:new(ca);
rg:SetPoint("TOPLEFT", chk_ds, "BOTTOMLEFT", 0, 0);
rg:Show();
rg:SetLayout(4,4);
rg.buttons[1]:SetWidth(70);
rg.buttons[2]:SetWidth(70);
rg.buttons[3]:SetWidth(70);
rg.buttons[4]:SetWidth(70);
rg.buttons[1]:SetText(VFLI.i18n("None")); 
rg.buttons[2]:SetText(VFLI.i18n("OUTLINE"));
rg.buttons[3]:SetText(VFLI.i18n("THICKOUTLINE"));
rg.buttons[4]:SetText(VFLI.i18n("MONOCHROME"));
rg.buttons[1].button:HookScript("OnClick", function() FlagsUpdate(); end);
rg.buttons[2].button:HookScript("OnClick", function() FlagsUpdate(); end);
rg.buttons[3].button:HookScript("OnClick", function() FlagsUpdate(); end);
rg.buttons[4].button:HookScript("OnClick", function() FlagsUpdate(); end);

function FlagsUpdate()
	if rg:GetValue() == 1 then
		curFont.flags = nil;
	elseif rg:GetValue() == 2 then
		curFont.flags = "OUTLINE";
	elseif rg:GetValue() == 3 then
		curFont.flags = "THICKOUTLINE";
	elseif rg:GetValue() == 4 then
		curFont.flags = "MONOCHROME";
	end
	
	UpdateFontPicker();
end

----------- Updater
function UpdateFontPicker()
	pvw:SetTextColor(1,1,1,1);
	VFLUI.SetFont(pvw, curFont, nil, true);
	dd_halign:SetSelection(curFont.justifyH);
	dd_valign:SetSelection(curFont.justifyV);
	if curFont.sx and curFont.sx ~= 0 then
		chk_ds:SetChecked(true);
		cs_ds:SetColor(curFont.sr, curFont.sg, curFont.sb, curFont.sa);
	else
		chk_ds:SetChecked(nil);
		cs_ds:SetColor(0,0,0,1);
	end
	if curFont.cr then
		chk_dcolor:SetChecked(true);
		cs_dcolor:SetColor(curFont.cr, curFont.cg, curFont.cb, curFont.ca);
	else
		chk_dcolor:SetChecked(nil);
		cs_dcolor:SetColor(1,1,1,1);
	end
	if curFont.flags then
		if curFont.flags == "OUTLINE" then
			rg:SetValue(2);
		elseif curFont.flags == "THICKOUTLINE" then
			rg:SetValue(3);
		elseif curFont.flags == "MONOCHROME" then
			rg:SetValue(4);
		end
	else
		rg:SetValue(1);
	end
	ss:Update(); fs:Update();
end

----------- Buttons
local btnCopy = VFLUI.Button:new(fp);
btnCopy:SetHeight(25); btnCopy:SetWidth(79);
btnCopy:SetPoint("BOTTOMLEFT", fp:GetClientArea(), "BOTTOMLEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local btnPaste = VFLUI.Button:new(fp);
btnPaste:SetHeight(25); btnPaste:SetWidth(79);
btnPaste:SetPoint("LEFT", btnCopy, "RIGHT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCancel = VFLUI.CancelButton:new(fp);
btnCancel:SetHeight(25); btnCancel:SetWidth(79);
btnCancel:SetPoint("LEFT", btnPaste, "RIGHT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnOK = VFLUI.OKButton:new(fp);
btnOK:SetHeight(25); btnOK:SetWidth(79);
btnOK:SetPoint("LEFT", btnCancel, "RIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

local function ClosePicker()
	fp:Hide();
	curFont = VFL.copy(Fonts.Default);
	fp_owner = nil;
	onCancel = VFL.Noop; onOK = VFL.Noop;
end

local function CancelPicker()
	if not fp:IsShown() then return; end
	onCancel();	ClosePicker();
end

local function OKPicker()
	if not fp:IsShown() then return; end
	onOK(VFL.copy(curFont));
	ClosePicker();
end

btnCancel:SetScript("OnClick", CancelPicker);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clipboard then
		curFont = VFL.copy(clipboard);
		UpdateFontPicker();
	end
end);
btnCopy:SetScript("OnClick", function()
	clipboard = VFL.copy(curFont);
end);

---------------------------- API
--- Launch the font picker.
function VFLUI.FontPicker(owner, fnOK, fnCancel, font, flaganchor)
	if type(font) ~= "table" then font = Fonts.Default; end
	-- Cancel any preexisting picker.
	if fp:IsShown() then CancelPicker(); end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop;
	fp_owner = owner; fp:Show();
	if flaganchor then fp:SetPoint("LEFT", fp_owner, "RIGHT", 10, 0); end
	curFont = VFL.copy(font); UpdateFontPicker();
end
--- Check the picker's owner.
function VFLUI.FontPickerOwner() return fp_owner; end
--- Close the picker.
function VFLUI.CloseFontPicker() ClosePicker(); end

--- Create a "font select" button that will open the font picker and invoke a callback
-- when the font is changed.
local function GetFontInfoString(font)
	if font.face then
		if not VFLUI.GetFontFaceName(font.face) then return ""; end 
		return VFLUI.GetFontFaceName(font.face) .. " " .. font.size;
	else
		return "(unknown)";
	end
end

function VFLUI.MakeFontSelectButton(parent, font, fnOK, flaganchor)
	if not fnOK then fnOK = VFL.Noop; end
	if not font then font = VFL.copy(Fonts.Default); end

	local self = VFLUI.Button:new(parent);
	self:SetWidth(180); self:SetHeight(24);
	self:SetText(GetFontInfoString(font));
	self.DialogOnLayout = VFL.Noop;

	function self:GetSelectedFont() return font; end
	function self:SetSelectedFont(f) font = VFL.copy(f); self:SetText(GetFontInfoString(f)); end

	self:SetScript("OnClick", function()
		VFLUI.FontPicker(parent, function(newFont) 
			font = newFont;
			self:SetText(GetFontInfoString(font));
			fnOK(font); 
		end, VFL.Noop, font, flaganchor);
	end);

	self.Destroy = VFL.hook(function(s)
		font = nil;
		s.GetSelectedFont = nil; 
		s.SetSelectedFont = nil;
	end, self.Destroy);
	return self;
end
