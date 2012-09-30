-- ButtonSkinPicker.lua
-- OpenRDX
--

local curButtonSkin, clipboard = {}, nil;
local onOK, onCancel, bsp_owner = VFL.Noop, VFL.Noop, nil;
local UpdateButtonSkinPicker;

-- Backdrop picker window.
local bsp = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(bsp, 20);
bsp:SetText("Button Skin Picker"); bsp:SetTitleColor(0,0,.6);
bsp:SetWidth(290); bsp:SetHeight(335);
bsp:SetPoint("CENTER", VFLParent, "CENTER");
bsp:SetMovable(true); bsp:SetToplevel(nil);
VFLUI.Window.StdMove(bsp, bsp:GetTitleBar());
bsp:Hide();
bsp:SetClampedToScreen(true);
local ca = bsp:GetClientArea();

---------- Preview
local lbl = VFLUI.MakeLabel(nil, ca, "Preview");
lbl:SetWidth(200);
lbl:SetPoint("TOPLEFT", ca, "TOPLEFT");

local pvwfb = VFLUI.AcquireFrame("Frame");
pvwfb:SetParent(ca); pvwfb:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
pvwfb:SetWidth(270); pvwfb:SetHeight(95);
pvwfb:SetBackdrop({
	bgFile="Interface\\Addons\\VFL\\Skin\\Checker", tile = true, tileSize = 15,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
});
pvwfb:Show();

local pvwf = VFLUI.AcquireFrame("Frame");
pvwf:SetParent(pvwfb); pvwf:SetPoint("CENTER", pvwfb, "CENTER");
pvwf:SetWidth(80); pvwf:SetHeight(80);
pvwf:Show();
----------- Border and Backdrop styles
local dd_buttonskin;

local lbl2 = VFLUI.MakeLabel(nil, ca, "ButtonSkin:");
lbl2:SetWidth(80); lbl2:SetPoint("TOPLEFT", pvwfb, "BOTTOMLEFT", 0, -10);

dd_buttonskin = VFLUI.Dropdown:new(ca, VFLUI.GetButtonSkinList, function(selectedButtonSkin)
	--VFLUI.ApplyBaseBackdrop(curButtonSkin, selectedButtonSkin);
	VFL.copyInto(curButtonSkin, selectedButtonSkin);
	UpdateButtonSkinPicker();
end);
dd_buttonskin:SetWidth(190); 
dd_buttonskin:SetPoint("LEFT", lbl2, "RIGHT");
dd_buttonskin:Show();


----------- Insets
local InsetsUpdate;

local function MakeBox(x, lw)
	lw = lw or 12;

	local b = VFLUI.Edit:new(ca);
	b:SetWidth(42); b:SetHeight(25); b:Show();
	b:SetScript("OnTextChanged", function() InsetsUpdate() end);

	local lbl = VFLUI.CreateFontString(ca);
	VFLUI.SetFont(lbl, Fonts.Default, 10);
	lbl:SetWidth(lw); lbl:SetHeight(25);
	lbl:SetPoint("RIGHT", b, "LEFT");
	lbl:Show(); lbl:SetText(x);

	return b;
end

local b_l = MakeBox("Inset", 40);
b_l:SetPoint("TOPLEFT", lbl2, "BOTTOMLEFT", 40, -5);
--local b_t = MakeBox("T");
--b_t:SetPoint("LEFT", b_l, "RIGHT", 17, 0);
--local b_r = MakeBox("R");
--b_r:SetPoint("LEFT", b_t, "RIGHT", 17, 0);
--local b_b = MakeBox("B");
--b_b:SetPoint("LEFT", b_r, "RIGHT", 17, 0);

function InsetsUpdate()
	if not curButtonSkin.insets then return; end
	-- Early out with invalid numbers.
	local l = tonumber(b_l:GetText()); if not l then return; end
	--local r = tonumber(b_r:GetText()); if not r then return; end
	--local t = tonumber(b_t:GetText()); if not t then return; end
	--local b = tonumber(b_b:GetText()); if not b then return; end
	-- Clamp ranges
	l = math.floor(VFL.clamp(l, 0, 1024));
	--r = math.floor(VFL.clamp(r, 0, 1024));
	--t = math.floor(VFL.clamp(t, 0, 1024));
	--b = math.floor(VFL.clamp(b, 0, 1024));
	-- Apply settings
	local changed = nil;
	if l ~=	curButtonSkin.insets.left then curButtonSkin.insets.left = l; changed = true; end
	--if r ~= curBackdrop.insets.right then curBackdrop.insets.right = r; changed = true; end
	--if t ~= curBackdrop.insets.top then curBackdrop.insets.top = t; changed = true; end
	--if b ~= curBackdrop.insets.bottom then curBackdrop.insets.bottom = b; changed = true; end
	-- Update
	if changed then UpdateButtonSkinPicker(); end
end

----------- Border color
local BorderColorUpdate;

local chk_bcolor = VFLUI.Checkbox:new(ca);
chk_bcolor:SetHeight(16); chk_bcolor:SetWidth(100);
chk_bcolor:SetPoint("TOPLEFT", b_l, "BOTTOMLEFT", -40, 0);
chk_bcolor:SetText("Border color"); chk_bcolor:Show();
chk_bcolor.check:SetScript("OnClick", function() BorderColorUpdate(); end);

local cs_bcolor = VFLUI.ColorSwatch:new(ca);
cs_bcolor:SetPoint("LEFT", chk_bcolor, "RIGHT", 0, -1); cs_bcolor:Show();
cs_bcolor:SetColor(1,1,1,1);
function cs_bcolor:OnColorChanged() BorderColorUpdate(); end

function BorderColorUpdate()
	if chk_bcolor:GetChecked() then
		local r,g,b,a = cs_bcolor:GetColorValues();
		curButtonSkin.br = r; curButtonSkin.bg = g; curButtonSkin.bb = b; curButtonSkin.ba = a;
	else
		curButtonSkin.br = nil; curButtonSkin.bg = nil; curButtonSkin.bb = nil; curButtonSkin.ba = nil;
	end
	UpdateButtonSkinPicker();
end

-------------------- ShowFlash
local ShowFlashUpdate;

local chk_showflash = VFLUI.Checkbox:new(ca);
chk_showflash:SetHeight(16); chk_showflash:SetWidth(100);
chk_showflash:SetPoint("TOPLEFT", chk_bcolor, "BOTTOMLEFT", 0, -10);
chk_showflash:SetText("Show Flash"); chk_showflash:Show();
chk_showflash.check:SetScript("OnClick", function() ShowFlashUpdate(); end);

function ShowFlashUpdate()
	if curButtonSkin.showflash then
		local es = chk_showflash:GetChecked();
		if curButtonSkin.showflash ~= es then
			curButtonSkin.showflash = es;
			UpdateButtonSkinPicker();
		end
	end
end

-------------------- ShowGloss
local ShowGlossUpdate;

local chk_showgloss = VFLUI.Checkbox:new(ca);
chk_showgloss:SetHeight(16); chk_showgloss:SetWidth(100);
chk_showgloss:SetPoint("TOPLEFT", chk_showflash, "BOTTOMLEFT", 0, -10);
chk_showgloss:SetText("Show Gloss"); chk_showgloss:Show();
chk_showgloss.check:SetScript("OnClick", function() ShowGlossUpdate(); end);

function ShowGlossUpdate()
	if curButtonSkin.showgloss then
		local es = chk_showgloss:GetChecked();
		if curButtonSkin.showgloss ~= es then
			curButtonSkin.showgloss = es;
			UpdateButtonSkinPicker();
		end
	end
end
--------------- Updater

UpdateButtonSkinPicker = function()
	VFLUI.SetButtonSkin(pvwf, curButtonSkin);
	
	dd_buttonskin:SetSelection(curButtonSkin.name or "none", curButtonSkin.name or "none", true);

	-- Insets
	if curButtonSkin.insets then
		if b_l:GetNumber() ~= curButtonSkin.insets then b_l:SetText(curButtonSkin.insets); end
	else
		b_l:SetText("");
	end
	-- BorderColor
	if curButtonSkin.br then
		chk_bcolor:SetChecked(true);
		cs_bcolor:SetColor(curButtonSkin.br, curButtonSkin.bg, curButtonSkin.bb, curButtonSkin.ba);
	else
		chk_bcolor:SetChecked(nil);
		cs_bcolor:SetColor(1,1,1,1);
	end
	
	if curButtonSkin.showflash then
		chk_showflash:SetChecked(true);
	else
		chk_showflash:SetChecked(nil);
	end
	
	if curButtonSkin.showgloss then
		chk_showgloss:SetChecked(true);
	else
		chk_showgloss:SetChecked(nil);
	end
end

----------- Buttons
local btnCopy = VFLUI.Button:new(bsp);
btnCopy:SetHeight(25); btnCopy:SetWidth(69);
btnCopy:SetPoint("BOTTOMLEFT", bsp:GetClientArea(), "BOTTOMLEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local btnPaste = VFLUI.Button:new(bsp);
btnPaste:SetHeight(25); btnPaste:SetWidth(69);
btnPaste:SetPoint("LEFT", btnCopy, "RIGHT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCancel = VFLUI.CancelButton:new(bsp);
btnCancel:SetHeight(25); btnCancel:SetWidth(69);
btnCancel:SetPoint("LEFT", btnPaste, "RIGHT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnOK = VFLUI.OKButton:new(bsp);
btnOK:SetHeight(25); btnOK:SetWidth(69);
btnOK:SetPoint("LEFT", btnCancel, "RIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

local function ClosePicker(nosmooth)
	--if nosmooth then
		bsp:Hide();
		curButtonSkin = {};
		bsp_owner = nil;
		onCancel = VFL.Noop; 
		onOK = VFL.Noop;
	--else
	--	bdp:_Hide(.2, nil, function()
	--		curBackdrop = {};
	--		bdp_owner = nil;
	--		onCancel = VFL.Noop; 
	--		onOK = VFL.Noop;
	--	end);
	--end
end

local function CancelPicker(nosmooth)
	if not bsp:IsShown() then return; end
	onCancel();
	ClosePicker(nosmooth);
end

local function OKPicker()
	if not bsp:IsShown() then return; end
	onOK(VFL.copy(curButtonSkin));
	ClosePicker();
end

btnCancel:SetScript("OnClick", function() CancelPicker(); end);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clipboard then
		curButtonSkin = VFL.copy(clipboard);
		BorderColorUpdate();
	end
end);
btnCopy:SetScript("OnClick", function()
	clipboard = VFL.copy(curButtonSkin);
end);

---------------------------- API
--- Launch the picker.
function VFLUI.ButtonSkinPicker(owner, fnOK, fnCancel, buttonskin, flaganchor)
	if type(buttonskin) ~= "table" then buttonskin = {}; end
	-- Cancel any preexisting picker.
	if bsp:IsShown() then CancelPicker(true); end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop;
	bsp_owner = owner; 
	if flaganchor then bsp:SetPoint("LEFT", bsp_owner, "RIGHT", 10, 0); end
	curButtonSkin = VFL.copy(buttonskin);
	UpdateButtonSkinPicker();
	bsp:Show();
end
--- Check the picker's owner.
function VFLUI.ButtonSkinPickerOwner() return bsp_owner; end
--- Close the picker.
function VFLUI.CloseButtonSkin() ClosePicker(); end

--- Create a "select" button that will open the picker and invoke a callback on changes
local function GetButtonSkinInfoString(bkdp)
	local str = "";
	if type(bkdp) == "table" then
		if bkdp.name then str = str .. VFLUI.GetBackdropBorderTitle(bkdp.name); end
	end
	if str == "" then str = "unknown"; end
	return str;
end

function VFLUI.MakeButtonSkinSelectButton(parent, buttonskin, fnOK, flaganchor)
	if not fnOK then fnOK = VFL.Noop; end
	if not buttonskin then buttonskin = {}; end

	local self = VFLUI.Button:new(parent);
	self:SetWidth(180); self:SetHeight(24);
	self:SetText(GetButtonSkinInfoString(buttonskin));
	self.DialogOnLayout = VFL.Noop;

	function self:GetSelectedButtonSkin() return buttonskin; end
	function self:SetSelectedButtonSkin(f)
		buttonskin = VFL.copy(f);
		self:SetText(GetButtonSkinInfoString(buttonskin));
	end

	self:SetScript("OnClick", function()
		VFLUI.ButtonSkinPicker(parent, function(new) 
			buttonskin = new;
			self:SetText(GetButtonSkinInfoString(buttonskin));
			fnOK(buttonskin);
		end, VFL.Noop, buttonskin, flaganchor);
	end);

	self.Destroy = VFL.hook(function(s)
		buttonskin = nil;
		s.GetSelectedButtonSkin = nil; 
		s.SetSelectedButtonSkin = nil;
	end, self.Destroy);
	return self;
end
