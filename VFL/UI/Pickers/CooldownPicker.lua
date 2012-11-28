-- CooldownPicker.lua
-- VFL
-- OpenRDX Sigg
--
-- A window that allows a cooldown to be chosen visually.

VFLUI.defaultCooldown = {
	Font = {name="Default",title="Default",justifyH="CENTER",face="Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf", justifyV="CENTER", size=10},
	TimerType = "COOLDOWN",
	GfxReverse = false,
	UpdateSpeed = 0.3;
	Offsetx = 0,
	Offsety = 0,
	TextType = "Seconds",
	HideText = 0,
};

local curCD, clipboard = {}, nil;
local onOK, onCancel, cp_owner = VFL.Noop, VFL.Noop, nil;

--------------- Cooldown picker window
local cp = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(cp, 20);
cp:SetBackdrop(VFLUI.BlackDialogBackdrop);
cp:SetText("Cooldown Picker");
cp:SetTitleColor(0,0,.6);
cp:SetWidth(330); cp:SetHeight(285);
cp:SetPoint("CENTER", VFLParent, "CENTER");
cp:SetMovable(true); cp:SetToplevel(nil);
VFLUI.Window.StdMove(cp, cp:GetTitleBar());
cp:Hide();
cp:SetClampedToScreen(true);
local ca = cp:GetClientArea();

--local PikCooldownUpdate;

-------------------- Cooldown
local lbl2 = VFLUI.MakeLabel(nil, ca, "Cooldown:");
lbl2:SetWidth(140); lbl2:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -10);
local dd_cooldown = VFLUI.Dropdown:new(ca, VFLUI.TimerTypesDropdownFunction);
dd_cooldown:SetWidth(180); 
dd_cooldown:SetPoint("LEFT", lbl2, "RIGHT");
dd_cooldown:Show();

local chk_reverse = VFLUI.Checkbox:new(ca);
chk_reverse:SetHeight(16); chk_reverse:SetWidth(300);
chk_reverse:SetPoint("TOPLEFT", lbl2, "BOTTOMLEFT", 0, -15);
chk_reverse:SetText("Graphics Reverse Cooldown"); chk_reverse:Show();

-- text
local ed_hidetext = VFLUI.LabeledEdit:new(ca, 80);
ed_hidetext:SetHeight(16); ed_hidetext:SetWidth(320);
ed_hidetext:SetPoint("TOPLEFT", chk_reverse, "BOTTOMLEFT", 0, -15);
ed_hidetext:SetText(VFLI.i18n("Hide Text Cooldown (seconds left)"));
ed_hidetext:Show();

local ed_updatespeed = VFLUI.LabeledEdit:new(ca, 80);
ed_updatespeed:SetHeight(16); ed_updatespeed:SetWidth(320);
ed_updatespeed:SetPoint("TOPLEFT", ed_hidetext, "BOTTOMLEFT", 0, -15);
ed_updatespeed:SetText(VFLI.i18n("Update speed text"));
ed_updatespeed:Show();

local lbl3 = VFLUI.MakeLabel(nil, ca, "Timer Text Font:");
lbl3:SetWidth(140); lbl3:SetPoint("TOPLEFT", ed_updatespeed, "BOTTOMLEFT", 0, -15);
local dd_font = VFLUI.MakeFontSelectButton(ca, nil, nil, true); 
dd_font:SetPoint("LEFT", lbl3, "RIGHT");
dd_font:Show();

local lbl4 = VFLUI.MakeLabel(nil, ca, "Timer Text Type:");
lbl4:SetWidth(140); lbl4:SetPoint("TOPLEFT", lbl3, "BOTTOMLEFT", 0, -15);
local dd_textType = VFLUI.Dropdown:new(ca, VFLUI.TextTypesDropdownFunction);
dd_textType:SetWidth(180); 
dd_textType:SetPoint("LEFT", lbl4, "RIGHT");
dd_textType:Show();

local ed_offsetx = VFLUI.LabeledEdit:new(ca, 80);
ed_offsetx:SetHeight(16); ed_offsetx:SetWidth(320);
ed_offsetx:SetPoint("TOPLEFT", lbl4, "BOTTOMLEFT", 0, -15);
ed_offsetx:SetText(VFLI.i18n("Timer Text Offset X"));
ed_offsetx:Show();

local ed_offsety = VFLUI.LabeledEdit:new(ca, 80);
ed_offsety:SetHeight(16); ed_offsety:SetWidth(320);
ed_offsety:SetPoint("TOPLEFT", ed_offsetx, "BOTTOMLEFT", 0, -15);
ed_offsety:SetText(VFLI.i18n("Timer Text Offset Y"));
ed_offsety:Show();

function PikCooldownUpdate()
	curCD.TimerType = dd_cooldown:GetSelection();
	if chk_reverse:GetChecked() then curCD.GfxReverse = true; else curCD.GfxReverse = nil; end
	curCD.HideText = ed_hidetext.editBox:GetNumber();
	curCD.UpdateSpeed = ed_updatespeed.editBox:GetNumber();
	curCD.Font = dd_font:GetSelectedFont();
	curCD.TextType = dd_textType:GetSelection();
	curCD.Offsetx = ed_offsetx.editBox:GetNumber();
	curCD.Offsety = ed_offsety.editBox:GetNumber();
end

----------- Updater
function UpdateCooldownPicker()
	dd_cooldown:SetSelection(curCD.TimerType or "COOLDOWN");
	if curCD.GfxReverse then
		chk_reverse:SetChecked(true);
	end
	ed_hidetext.editBox:SetNumber(curCD.HideText);
	ed_updatespeed.editBox:SetNumber(curCD.UpdateSpeed or 0.3);
	dd_textType:SetSelection(curCD.TextType or "MinSec");
	ed_offsetx.editBox:SetNumber(curCD.Offsetx or 0);
	ed_offsety.editBox:SetNumber(curCD.Offsety or 0);
	dd_font:SetSelectedFont(curCD.Font);
end

----------- Buttons
local btnOK = VFLUI.OKButton:new(cp);
btnOK:SetHeight(25); btnOK:SetWidth(79);
btnOK:SetPoint("BOTTOMRIGHT", cp:GetClientArea(), "BOTTOMRIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

local btnCancel = VFLUI.CancelButton:new(cp);
btnCancel:SetHeight(25); btnCancel:SetWidth(79);
btnCancel:SetPoint("RIGHT", btnOK, "LEFT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnPaste = VFLUI.Button:new(cp);
btnPaste:SetHeight(25); btnPaste:SetWidth(79);
btnPaste:SetPoint("RIGHT", btnCancel, "LEFT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCopy = VFLUI.Button:new(cp);
btnCopy:SetHeight(25); btnCopy:SetWidth(79);
btnCopy:SetPoint("RIGHT", btnPaste, "LEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local function ClosePicker(nosmooth)
	--if nosmooth then
		cp:Hide();
		curCD = VFL.copy(VFLUI.defaultCooldown);
		cp_owner = nil;	onCancel = VFL.Noop; onOK = VFL.Noop;
	--else
	--	cp:_Hide(.2, nil, function()
	--		curCD = VFL.copy(VFLUI.defaultCooldown);
	--		cp_owner = nil;	onCancel = VFL.Noop; onOK = VFL.Noop;
	--	end);
	--end
end

local function CancelPicker(nosmooth)
	if not cp:IsShown() then return; end
	onCancel();
	ClosePicker(nosmooth);
end

local function OKPicker()
	if not cp:IsShown() then return; end
	PikCooldownUpdate();
	onOK(VFL.copy(curCD));
	ClosePicker();
end

btnCancel:SetScript("OnClick", function() CancelPicker(); end);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clipboard then
		curCD = VFL.copy(clipboard);
		UpdateCooldownPicker();
		PikCooldownUpdate();
	end
end);
btnCopy:SetScript("OnClick", function()
	clipboard = VFL.copy(curCD);
end);


---------------------------- API
--- Launch the picker.
function VFLUI.CooldownPicker(owner, fnOK, fnCancel, cd)
	if type(cd) ~= "table" then cd = VFL.copy(VFLUI.defaultCooldown); end
	-- Cancel any preexisting picker.
	if cp:IsShown() then CancelPicker(true); end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop;
	cp_owner = owner;
	curCD = VFL.copy(cd);
	UpdateCooldownPicker();
	cp:Show();
	--cp:_Show(.2);
end
--- Check the picker's owner.
function VFLUI.CooldownPickerOwner() return cp_owner; end
--- Close the picker.
function VFLUI.CloseCooldownPicker() ClosePicker(); end

function VFLUI.MakeCooldownSelectButton(parent, cooldown, fnOK)
	if not fnOK then fnOK = VFL.Noop; end
	if not cooldown then 
		cooldown = VFL.copy(VFLUI.defaultCooldown);
	end

	local self = VFLUI.Button:new(parent);
	self:SetWidth(180); self:SetHeight(24);
	self:SetText(cooldown.TimerType);
	self.DialogOnLayout = VFL.Noop;

	function self:GetSelectedCooldown() return cooldown; end
	function self:SetSelectedCooldown(f) 
		if type(f) ~= "table" then return; end
		cooldown = VFL.copy(f);
		self:SetText(cooldown.TimerType);
	end

	self:SetScript("OnClick", function()
		VFLUI.CooldownPicker(parent, function(newC) 
			cooldown = newC;
			self:SetText(cooldown.TimerType);
			fnOK(cooldown); 
		end, VFL.Noop, cooldown);
	end);

	self.Destroy = VFL.hook(function(s)
		cooldown = nil;
		s.GetSelectedCooldown = nil;
		s.SetSelectedCooldown = nil;
	end, self.Destroy);
	return self;
end
