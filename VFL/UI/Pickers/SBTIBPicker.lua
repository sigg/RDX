-- StatusBarPicker.lua
-- VFL
-- OpenRDX Sigg
--
-- A window that allows a statusbar to be defined
-- usefull for aurabarlist, cooldownbarlist, totem bar list, rune bar list etc ...
-- backdrop and icon texture available
-- StatusBarTextureIconBackdrop (SBTIB)

VFLUI.defaultSBTIB = {
	btype = "Frame",
	w = 220,
	h = 20,
	bkd = { _border = "tooltip", edgeSize = 16, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", _backdrop = "none", insets = {top = 4,right = 4,left = 4,bottom = 4,}, },
	borientation = "HORIZONTAL",
	banchor = "LEFT",
	btexture = { path = "Interface\\Addons\\RDX\\Skin\\bar1", blendMode = "BLEND" },
	showicon = true,
	iconposition = "LEFT",
	stacktxt = {name="Default",title="Default",justifyH="CENTER",face="Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf", justifyV="CENTER", size=9},
	showname = true;
	nametxt = {name="Default",title="Default",justifyH="LEFT",face="Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf", justifyV="CENTER", size=9},
	timetxt = {name="Default",title="Default",justifyH="RIGHT",face="Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf", justifyV="CENTER", size=9},
};

local cur, clipboard = {}, nil;
local onOK, onCancel, sbp_owner = VFL.Noop, VFL.Noop, nil;

--------------- Cooldown picker window
local sbp = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(sbp, 20);
sbp:SetBackdrop(VFLUI.BlackDialogBackdrop);
sbp:SetText("StatusBar Picker");
sbp:SetTitleColor(0,0,.6);
sbp:SetWidth(330); sbp:SetHeight(420);
sbp:SetPoint("CENTER", VFLParent, "CENTER");
sbp:SetMovable(true); sbp:SetToplevel(nil);
VFLUI.Window.StdMove(sbp, sbp:GetTitleBar());
sbp:Hide();
local ca = sbp:GetClientArea();

--local PikCooldownUpdate;

local _btypes = {
	{ text = "Frame" },
	{ text = "Button" },
};
local function btypes() return _btypes; end

local _borientations = {
	{text = "HORIZONTAL"},
	{text = "VERTICAL"},
};
local function borientations() return _borientations; end

local _banchors = {
	{text = "LEFT"},
	{text = "TOP"},
	{text = "RIGHT"},
	{text = "BOTTOM"},
};
local function banchors() return _banchors; end

-------------------- SBTIB
local lbl1 = VFLUI.MakeLabel(nil, ca, "Type:");
lbl1:SetWidth(140); lbl1:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -10);
local dd_btype = VFLUI.Dropdown:new(ca, btypes);
dd_btype:SetWidth(180); 
dd_btype:SetPoint("LEFT", lbl1, "RIGHT");
dd_btype:Show();

local ed_width = VFLUI.LabeledEdit:new(ca, 80);
ed_width:SetHeight(16); ed_width:SetWidth(320);
ed_width:SetPoint("TOPLEFT", lbl1, "BOTTOMLEFT", 0, -15);
ed_width:SetText(VFLI.i18n("Width"));
ed_width:Show();

local ed_height = VFLUI.LabeledEdit:new(ca, 80);
ed_height:SetHeight(16); ed_height:SetWidth(320);
ed_height:SetPoint("TOPLEFT", ed_width, "BOTTOMLEFT", 0, -15);
ed_height:SetText(VFLI.i18n("Height"));
ed_height:Show();

local lbl2 = VFLUI.MakeLabel(nil, ca, "Backdrop:");
lbl2:SetWidth(140); lbl2:SetPoint("TOPLEFT", ed_height, "BOTTOMLEFT", 0, -15);
local dd_bkd = VFLUI.MakeBackdropSelectButton(ca, nil, nil, true); 
dd_bkd:SetPoint("LEFT", lbl2, "RIGHT");
dd_bkd:Show();

local lbl3 = VFLUI.MakeLabel(nil, ca, "Bar orientation:");
lbl3:SetWidth(140); lbl3:SetPoint("TOPLEFT", lbl2, "BOTTOMLEFT", 0, -15);
local dd_borientation = VFLUI.Dropdown:new(ca, borientations);
dd_borientation:SetWidth(180); 
dd_borientation:SetPoint("LEFT", lbl3, "RIGHT");
dd_borientation:Show();

local lbl4 = VFLUI.MakeLabel(nil, ca, "Bar anchor:");
lbl4:SetWidth(140); lbl4:SetPoint("TOPLEFT", lbl3, "BOTTOMLEFT", 0, -15);
local dd_banchor = VFLUI.Dropdown:new(ca, banchors);
dd_banchor:SetWidth(180); 
dd_banchor:SetPoint("LEFT", lbl4, "RIGHT");
dd_banchor:Show();

local lbl5 = VFLUI.MakeLabel(nil, ca, "Bar Texture:");
lbl5:SetWidth(140); lbl5:SetPoint("TOPLEFT", lbl4, "BOTTOMLEFT", 0, -15);
local dd_btexture = VFLUI.MakeTextureSelectButton(ca, nil, nil, true); 
dd_btexture:SetPoint("LEFT", lbl5, "RIGHT");
dd_btexture:Show();

local chk_showicon = VFLUI.Checkbox:new(ca);
chk_showicon:SetHeight(16); chk_showicon:SetWidth(300);
chk_showicon:SetPoint("TOPLEFT", lbl5, "BOTTOMLEFT", 0, -15);
chk_showicon:SetText("Show Icon");
chk_showicon:Show();

local lbl6 = VFLUI.MakeLabel(nil, ca, "Icon anchor:");
lbl6:SetWidth(140); lbl6:SetPoint("TOPLEFT", chk_showicon, "BOTTOMLEFT", 0, -15);
local dd_iconposition = VFLUI.Dropdown:new(ca, banchors);
dd_iconposition:SetWidth(180); 
dd_iconposition:SetPoint("LEFT", lbl6, "RIGHT");
dd_iconposition:Show();

local lbl7 = VFLUI.MakeLabel(nil, ca, "Stack Text Font:");
lbl7:SetWidth(140); lbl7:SetPoint("TOPLEFT", lbl6, "BOTTOMLEFT", 0, -15);
local dd_stacktxt = VFLUI.MakeFontSelectButton(ca, nil, nil, true); 
dd_stacktxt:SetPoint("LEFT", lbl7, "RIGHT");
dd_stacktxt:Show();

local chk_showname = VFLUI.Checkbox:new(ca);
chk_showname:SetHeight(16); chk_showname:SetWidth(300);
chk_showname:SetPoint("TOPLEFT", lbl7, "BOTTOMLEFT", 0, -15);
chk_showname:SetText("Show Name Text");
chk_showname:Show();

local lbl8 = VFLUI.MakeLabel(nil, ca, "Name Text Font:");
lbl8:SetWidth(140); lbl8:SetPoint("TOPLEFT", chk_showname, "BOTTOMLEFT", 0, -15);
local dd_nametxt = VFLUI.MakeFontSelectButton(ca, nil, nil, true); 
dd_nametxt:SetPoint("LEFT", lbl8, "RIGHT");
dd_nametxt:Show();

local lbl9 = VFLUI.MakeLabel(nil, ca, "Time Text Font:");
lbl9:SetWidth(140); lbl9:SetPoint("TOPLEFT", lbl8, "BOTTOMLEFT", 0, -15);
local dd_timetxt = VFLUI.MakeFontSelectButton(ca, nil, nil, true); 
dd_timetxt:SetPoint("LEFT", lbl9, "RIGHT");
dd_timetxt:Show();

function PikSBTIBUpdate()
	cur.btype = dd_btype:GetSelection();
	cur.w = ed_width.editBox:GetNumber();
	cur.h = ed_height.editBox:GetNumber();
	cur.bkd = dd_bkd:GetSelectedBackdrop();
	cur.borientation = dd_borientation:GetSelection();
	cur.banchor = dd_banchor:GetSelection();
	cur.btexture = dd_btexture:GetSelectedTexture();
	if chk_showicon:GetChecked() then cur.showicon = true; else cur.showicon = nil; end
	cur.iconposition = dd_iconposition:GetSelection();
	cur.stacktxt = dd_stacktxt:GetSelectedFont();
	if chk_showname:GetChecked() then cur.showname = true; else cur.showname = nil; end
	cur.nametxt = dd_nametxt:GetSelectedFont();
	cur.timetxt = dd_timetxt:GetSelectedFont();
end

----------- Updater
function UpdateSBTIBPicker()
	dd_btype:SetSelection(cur.btype or "Frame");
	ed_width.editBox:SetNumber(cur.w or 90);
	ed_height.editBox:SetNumber(cur.h or 14);
	dd_bkd:SetSelectedBackdrop(cur.bkd);
	dd_borientation:SetSelection(cur.borientation or "HORIZONTALE");
	dd_banchor:SetSelection(cur.banchor or "LEFT");
	dd_btexture:SetSelectedTexture(cur.btexture);
	if cur.showicon then
		chk_showicon:SetChecked(true);
	end
	dd_iconposition:SetSelection(cur.iconposition or "LEFT");
	dd_stacktxt:SetSelectedFont(cur.stacktxt);
	if cur.showname then
		chk_showname:SetChecked(true);
	end
	dd_nametxt:SetSelectedFont(cur.nametxt);
	dd_timetxt:SetSelectedFont(cur.timetxt);
end

----------- Buttons
local btnOK = VFLUI.OKButton:new(sbp);
btnOK:SetHeight(25); btnOK:SetWidth(79);
btnOK:SetPoint("BOTTOMRIGHT", sbp:GetClientArea(), "BOTTOMRIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

local btnCancel = VFLUI.CancelButton:new(sbp);
btnCancel:SetHeight(25); btnCancel:SetWidth(79);
btnCancel:SetPoint("RIGHT", btnOK, "LEFT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnPaste = VFLUI.Button:new(sbp);
btnPaste:SetHeight(25); btnPaste:SetWidth(79);
btnPaste:SetPoint("RIGHT", btnCancel, "LEFT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCopy = VFLUI.Button:new(sbp);
btnCopy:SetHeight(25); btnCopy:SetWidth(79);
btnCopy:SetPoint("RIGHT", btnPaste, "LEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local function ClosePicker()
	sbp:Hide();
	cur = VFL.copy(VFLUI.defaultSBTIB);
	sbp_owner = nil; onCancel = VFL.Noop; onOK = VFL.Noop;
end

local function CancelPicker()
	if not sbp:IsShown() then return; end
	onCancel(); ClosePicker();
end

local function OKPicker()
	if not sbp:IsShown() then return; end
	PikSBTIBUpdate();
	onOK(VFL.copy(cur));
	ClosePicker();
end

btnCancel:SetScript("OnClick", CancelPicker);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clipboard then
		cur = VFL.copy(clipboard);
		UpdateSBTIBPicker();
		PikSBTIBUpdate();
	end
end);
btnCopy:SetScript("OnClick", function()
	clipboard = VFL.copy(cur);
end);

---------------------------- API
--- Launch the picker.
function VFLUI.SBTIBPicker(owner, fnOK, fnCancel, sb)
	if type(sb) ~= "table" then sb = VFL.copy(VFLUI.defaultSBTIB); end
	-- Cancel any preexisting picker.
	if sbp:IsShown() then CancelPicker(); end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop;
	sbp_owner = owner; sbp:Show();
	cur = VFL.copy(sb);
	UpdateSBTIBPicker();
end
--- Check the picker's owner.
function VFLUI.SBTIBPickerOwner() return sbp_owner; end
--- Close the picker.
function VFLUI.CloseSBTIBPicker() ClosePicker(); end

function VFLUI.MakeSBTIBSelectButton(parent, sb, fnOK, flaganchor)
	if not fnOK then fnOK = VFL.Noop; end
	if not sb then sb = VFL.copy(VFLUI.defaultSBTIB); end

	local self = VFLUI.Button:new(parent);
	self:SetWidth(180); self:SetHeight(24);
	self:SetText("Timer Bar");
	self.DialogOnLayout = VFL.Noop;

	function self:GetSelectedSBTIB() return sb; end
	function self:SetSelectedSBTIB(f) 
		if type(f) ~= "table" then return; end
		sb = VFL.copy(f);
		--self:SetText("Timer Bar");
	end

	self:SetScript("OnClick", function()
		VFLUI.SBTIBPicker(parent, function(newC) 
			sb = newC;
			--self:SetText(cooldown.TimerType);
			fnOK(sb); 
		end, VFL.Noop, sb, flaganchor);
	end);

	self.Destroy = VFL.hook(function(s)
		sb = nil;
		s.GetSelectedSBTIB = nil;
		s.SetSelectedSBTIB = nil;
	end, self.Destroy);
	return self;
end
