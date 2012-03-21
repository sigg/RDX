-- BackdropPicker.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A window that allows a backdrop to be chosen visually.

VFLUI.defaultBackdrop = {
	_border = "none";
	_backdrop = "none";
};

VFLUI.nilBackdrop = {
	_border = "none";
	bgFile = nil;
	_backdrop = "none";
	edgeFile = nil;
};

local curBackdrop, clipboard = {}, nil;
local onOK, onCancel, bdp_owner = VFL.Noop, VFL.Noop, nil;
local UpdateBackdropPicker;

-- Backdrop picker window.
local bdp = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(bdp, 20);
bdp:SetText("Backdrop Picker"); bdp:SetTitleColor(0,0,.6);
bdp:SetWidth(280); bdp:SetHeight(290);
bdp:SetPoint("CENTER", VFLParent, "CENTER");
bdp:SetMovable(true); bdp:SetToplevel(nil);
VFLUI.Window.StdMove(bdp, bdp:GetTitleBar());
bdp:Hide();
bdp:SetClampedToScreen(true);
local ca = bdp:GetClientArea();

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
pvwf:SetWidth(243); pvwf:SetHeight(86);
pvwf:Show();

----------- Border and Backdrop styles
local dd_border, dd_backdrop;

-------------------- Border
local lbl2 = VFLUI.MakeLabel(nil, ca, "Border:");
lbl2:SetWidth(80); lbl2:SetPoint("TOPLEFT", pvwf, "BOTTOMLEFT", -13, -10);

dd_border = VFLUI.Dropdown:new(ca, VFLUI.GetBackdropBorderList, function(selectedBorder)
	VFLUI.ApplyBaseBackdrop(curBackdrop, selectedBorder);
	UpdateBackdropPicker();
end);
dd_border:SetWidth(190); 
dd_border:SetPoint("LEFT", lbl2, "RIGHT");
dd_border:Show();

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

local b_l = MakeBox("Inset L", 40);
b_l:SetPoint("TOPLEFT", lbl2, "BOTTOMLEFT", 40, -5);
local b_t = MakeBox("T");
b_t:SetPoint("LEFT", b_l, "RIGHT", 17, 0);
local b_r = MakeBox("R");
b_r:SetPoint("LEFT", b_t, "RIGHT", 17, 0);
local b_b = MakeBox("B");
b_b:SetPoint("LEFT", b_r, "RIGHT", 17, 0);

function InsetsUpdate()
	if not curBackdrop.insets then return; end
	-- Early out with invalid numbers.
	local l = tonumber(b_l:GetText()); if not l then return; end
	local r = tonumber(b_r:GetText()); if not r then return; end
	local t = tonumber(b_t:GetText()); if not t then return; end
	local b = tonumber(b_b:GetText()); if not b then return; end
	-- Clamp ranges
	l = math.floor(VFL.clamp(l, 0, 1024));
	r = math.floor(VFL.clamp(r, 0, 1024));
	t = math.floor(VFL.clamp(t, 0, 1024));
	b = math.floor(VFL.clamp(b, 0, 1024));
	-- Apply settings
	local changed = nil;
	if l ~=	curBackdrop.insets.left then curBackdrop.insets.left = l; changed = true; end
	if r ~= curBackdrop.insets.right then curBackdrop.insets.right = r; changed = true; end
	if t ~= curBackdrop.insets.top then curBackdrop.insets.top = t; changed = true; end
	if b ~= curBackdrop.insets.bottom then curBackdrop.insets.bottom = b; changed = true; end
	-- Update
	if changed then UpdateBackdropPicker(); end
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
		curBackdrop.br = r; curBackdrop.bg = g; curBackdrop.bb = b; curBackdrop.ba = a;
	else
		curBackdrop.br = nil; curBackdrop.bg = nil; curBackdrop.bb = nil; curBackdrop.ba = nil;
	end
	UpdateBackdropPicker();
end

-------------------- Edge Size
local EdgeSizeUpdate;

lbl = VFLUI.MakeLabel(nil, ca, "Edge size:");
lbl:SetWidth(80); lbl:SetPoint("LEFT", cs_bcolor, "RIGHT", 0, 0);

local ed_edgeSize = VFLUI.Edit:new(ca);
ed_edgeSize:SetPoint("LEFT", lbl, "RIGHT"); ed_edgeSize:Show();
ed_edgeSize:SetWidth(50); ed_edgeSize:SetHeight(24);
ed_edgeSize:SetScript("OnTextChanged", function() EdgeSizeUpdate(); end);

function EdgeSizeUpdate()
	if curBackdrop.edgeSize then
		local es = tonumber(ed_edgeSize:GetText());
		if not es then return; end
		es = math.floor(VFL.clamp(es, 1, 1024));
		if curBackdrop.edgeSize ~= es then
			curBackdrop.edgeSize = es;
			UpdateBackdropPicker();
		end
	end
end

-------------------- Backdrop
lbl = VFLUI.MakeLabel(nil, ca, "Backdrop:");
lbl:SetWidth(80); lbl:SetPoint("TOPLEFT", chk_bcolor, "BOTTOMLEFT", 0, -9);
dd_backdrop = VFLUI.Dropdown:new(ca, VFLUI.GetBackdropList, function(selectedBackdrop)
	VFLUI.ApplyBaseBackdrop(curBackdrop, nil, selectedBackdrop);
	UpdateBackdropPicker();
end);
dd_backdrop:SetWidth(190); 
dd_backdrop:SetPoint("LEFT", lbl, "RIGHT");
dd_backdrop:Show();

----------- Tile
local TileUpdate;

local chk_tile = VFLUI.Checkbox:new(ca);
chk_tile:SetHeight(16); chk_tile:SetWidth(180);
chk_tile:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, -8);
chk_tile:SetText("Tile backdrop with tiles of size:");
chk_tile:Show();
chk_tile.check:SetScript("OnClick", function() TileUpdate(); end);

local ed_tile = VFLUI.Edit:new(ca);
ed_tile:SetPoint("LEFT", chk_tile, "RIGHT"); ed_tile:Show();
ed_tile:SetWidth(50); ed_tile:SetHeight(24);
ed_tile:SetScript("OnTextChanged", function() TileUpdate(); end);

function TileUpdate()
	if chk_tile:GetChecked() then
		local changed = nil; if not curBackdrop.tile then changed = true; end
		curBackdrop.tile = true;
		local ts = tonumber(ed_tile:GetText());	if not ts then return; end
		ts = math.floor(VFL.clamp(ts, 1, 1024));
		if curBackdrop.tileSize ~= ts then changed = true; curBackdrop.tileSize = ts; end
		if changed then UpdateBackdropPicker(); end
	else
		if curBackdrop.tile then
			curBackdrop.tile = nil; curBackdrop.tileSize = nil;
			UpdateBackdropPicker();
		end
	end
end
 
----------- Backdrop color
local BackdropColorUpdate;

local chk_kcolor = VFLUI.Checkbox:new(ca);
chk_kcolor:SetHeight(16); chk_kcolor:SetWidth(100);
chk_kcolor:SetPoint("TOPLEFT", chk_tile, "BOTTOMLEFT", 0, -5);
chk_kcolor:SetText("Backdrop color"); chk_kcolor:Show();
chk_kcolor.check:SetScript("OnClick", function() BackdropColorUpdate(); end);

local cs_kcolor = VFLUI.ColorSwatch:new(ca);
cs_kcolor:SetPoint("LEFT", chk_kcolor, "RIGHT", 0, -1); cs_kcolor:Show();
cs_kcolor:SetColor(1,1,1,1);
function cs_kcolor:OnColorChanged() BackdropColorUpdate(); end

function BackdropColorUpdate()
	if chk_kcolor:GetChecked() then
		local r,g,b,a = cs_kcolor:GetColorValues();
		curBackdrop.kr = r; curBackdrop.kg = g; curBackdrop.kb = b; curBackdrop.ka = a;
	else
		curBackdrop.kr = nil; curBackdrop.kg = nil; curBackdrop.kb = nil; curBackdrop.ka = nil;
	end
	UpdateBackdropPicker();
end

--------------- Updater
UpdateBackdropPicker = function()
	VFLUI.SetBackdrop(pvwf, curBackdrop);
	--if curBackdrop._backdrop == "none" then
	--	pvwf:SetBackdrop({
	--		bgFile="Interface\\Addons\\VFL\\Skin\\Checker", tile = true, tileSize = 15,
	--		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	--	});
	--end
	dd_border:SetSelection(VFLUI.GetBackdropBorderTitle(curBackdrop._border), curBackdrop._border or "none", true);
	dd_backdrop:SetSelection(VFLUI.GetBackdropTitle(curBackdrop._backdrop), curBackdrop._backdrop or "none", true);
	-- Edge size
	if ed_edgeSize:GetNumber() ~= curBackdrop.edgeSize then
		ed_edgeSize:SetText(curBackdrop.edgeSize or "");
	end

	-- Tile
	if curBackdrop.tile then
		chk_tile:SetChecked(true);
		if ed_tile:GetNumber() ~= curBackdrop.tileSize then ed_tile:SetText(curBackdrop.tileSize or ""); end
	else
		chk_tile:SetChecked(nil); ed_tile:SetText("");
	end

	-- Insets
	if curBackdrop.insets then
		if b_l:GetNumber() ~= curBackdrop.insets.left then b_l:SetText(curBackdrop.insets.left); end
		if b_r:GetNumber() ~= curBackdrop.insets.right then b_r:SetText(curBackdrop.insets.right); end
		if b_b:GetNumber() ~= curBackdrop.insets.bottom then b_b:SetText(curBackdrop.insets.bottom); end
		if b_t:GetNumber() ~= curBackdrop.insets.top then	b_t:SetText(curBackdrop.insets.top); end
	else
		b_l:SetText(""); b_r:SetText(""); b_t:SetText(""); b_b:SetText("");
	end
	-- BorderColor
	if curBackdrop.br then
		chk_bcolor:SetChecked(true);
		cs_bcolor:SetColor(curBackdrop.br, curBackdrop.bg, curBackdrop.bb, curBackdrop.ba);
	else
		chk_bcolor:SetChecked(nil);
		cs_bcolor:SetColor(1,1,1,1);
	end
	-- BackdropColor
	if curBackdrop.kr then
		chk_kcolor:SetChecked(true);
		cs_kcolor:SetColor(curBackdrop.kr, curBackdrop.kg, curBackdrop.kb, curBackdrop.ka);
	else
		chk_kcolor:SetChecked(nil);
		cs_kcolor:SetColor(1,1,1,1);
	end
end

----------- Buttons
local btnCopy = VFLUI.Button:new(bdp);
btnCopy:SetHeight(25); btnCopy:SetWidth(69);
btnCopy:SetPoint("BOTTOMLEFT", bdp:GetClientArea(), "BOTTOMLEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local btnPaste = VFLUI.Button:new(bdp);
btnPaste:SetHeight(25); btnPaste:SetWidth(69);
btnPaste:SetPoint("LEFT", btnCopy, "RIGHT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCancel = VFLUI.CancelButton:new(bdp);
btnCancel:SetHeight(25); btnCancel:SetWidth(69);
btnCancel:SetPoint("LEFT", btnPaste, "RIGHT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnOK = VFLUI.OKButton:new(bdp);
btnOK:SetHeight(25); btnOK:SetWidth(69);
btnOK:SetPoint("LEFT", btnCancel, "RIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

local function ClosePicker(nosmooth)
	if nosmooth then
		bdp:Hide();
		curBackdrop = {};
		bdp_owner = nil;
		onCancel = VFL.Noop; 
		onOK = VFL.Noop;
	else
		bdp:_Hide(.2, nil, function()
			curBackdrop = {};
			bdp_owner = nil;
			onCancel = VFL.Noop; 
			onOK = VFL.Noop;
		end);
	end
end

local function CancelPicker(nosmooth)
	if not bdp:IsShown() then return; end
	onCancel();
	ClosePicker(nosmooth);
end

local function OKPicker()
	if not bdp:IsShown() then return; end
	onOK(VFL.copy(curBackdrop));
	ClosePicker();
end

btnCancel:SetScript("OnClick", function() CancelPicker(); end);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clipboard then
		curBackdrop = VFL.copy(clipboard);
		UpdateBackdropPicker();
	end
end);
btnCopy:SetScript("OnClick", function()
	clipboard = VFL.copy(curBackdrop);
end);

---------------------------- API
--- Launch the picker.
function VFLUI.BackdropPicker(owner, fnOK, fnCancel, backdrop, flaganchor)
	if type(backdrop) ~= "table" then backdrop = {}; end
	-- Cancel any preexisting picker.
	if bdp:IsShown() then CancelPicker(true); end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop;
	bdp_owner = owner; 
	if flaganchor then bdp:SetPoint("LEFT", bdp_owner, "RIGHT", 10, 0); end
	curBackdrop = VFL.copy(backdrop);
	UpdateBackdropPicker();
	--bdp:Show();
	bdp:_Show(.2);
end
--- Check the picker's owner.
function VFLUI.BackdropPickerOwner() return bdp_owner; end
--- Close the picker.
function VFLUI.CloseBackdropPicker() ClosePicker(); end

--- Create a "select" button that will open the picker and invoke a callback on changes
local function GetBackdropInfoString(bkdp)
	local str = "";
	if type(bkdp) == "table" then
		if bkdp._border then str = str .. VFLUI.GetBackdropBorderTitle(bkdp._border) .. "/"; end
		if bkdp._backdrop then str = str .. VFLUI.GetBackdropTitle(bkdp._backdrop); end
	end
	if str == "" then str = "unknown"; end
	return str;
end

function VFLUI.MakeBackdropSelectButton(parent, backdrop, fnOK, flaganchor)
	if not fnOK then fnOK = VFL.Noop; end
	if not backdrop then backdrop = {}; end

	local self = VFLUI.Button:new(parent);
	self:SetWidth(180); self:SetHeight(24);
	self:SetText(GetBackdropInfoString(backdrop));
	self.DialogOnLayout = VFL.Noop;

	function self:GetSelectedBackdrop() return backdrop; end
	function self:SetSelectedBackdrop(f)
		backdrop = VFL.copy(f);
		self:SetText(GetBackdropInfoString(backdrop));
	end

	self:SetScript("OnClick", function()
		VFLUI.BackdropPicker(parent, function(new) 
			backdrop = new;
			self:SetText(GetBackdropInfoString(backdrop));
			fnOK(backdrop);
		end, VFL.Noop, backdrop, flaganchor);
	end);

	self.Destroy = VFL.hook(function(s)
		backdrop = nil;
		s.GetSelectedBackdrop = nil; 
		s.SetSelectedBackdrop = nil;
	end, self.Destroy);
	return self;
end
