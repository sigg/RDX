-- SoundPicker.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A window that allows a sound to be chosen and previewed from a database
-- of preregistered sounds.

local clipboard = nil, nil;
local onOK, onCancel, owner = VFL.Noop, VFL.Noop, nil;
local UpdateSoundPicker;

local picker = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(picker, 20);
picker:SetText("Sound Picker"); picker:SetTitleColor(0,0,.6);
picker:SetWidth(280); picker:SetHeight(320);
picker:SetPoint("CENTER", VFLParent, "CENTER");
picker:SetMovable(true); picker:SetToplevel(nil);
VFLUI.Window.StdMove(picker, picker:GetTitleBar());
picker:Hide();
picker:SetClampedToScreen(true);
local ca = picker:GetClientArea();

-- Filename input
local lbl = VFLUI.MakeLabel(nil, ca, "Sound File (wav or mp3)");
lbl:SetWidth(270);
lbl:SetPoint("TOPLEFT", ca, "TOPLEFT");

local pathEdit = VFLUI.Edit:new(ca);
pathEdit:SetWidth(245); pathEdit:SetHeight(24);
pathEdit:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
pathEdit:Show();

-- Play button
local play = VFLUI.TexturedButton:new(ca, 24, "Interface\\AddOns\\VFL\\Skin\\play");
play:SetHighlightColor(0,1,0);
play:SetPoint("LEFT", pathEdit, "RIGHT"); play:Show();
play:SetScript("OnClick", function()
	local snd = pathEdit:GetText();
	-- Don't try to play an empty sound; this crashes some systems (Mac in particular)
	if (not snd) or (snd == "") then return; end 
	PlaySoundFile(snd);
end);

-- Preregistered sound list
lbl = VFLUI.MakeLabel(nil, ca, "Predefined Sounds");
lbl:SetWidth(270);
lbl:SetPoint("TOPLEFT", pathEdit, "BOTTOMLEFT");

local fs_decor = VFLUI.AcquireFrame("Frame");
fs_decor:SetParent(ca);
fs_decor:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
fs_decor:SetWidth(270); fs_decor:SetHeight(204);
fs_decor:SetBackdrop(VFLUI.DefaultDialogBorder); fs_decor:Show();

local fs = VFLUI.List:new(ca, 12, VFLUI.Selectable.AcquireCell);
fs:SetPoint("TOPLEFT", fs_decor, "TOPLEFT", 5, -5);
fs:SetWidth(260); fs:SetHeight(194); fs:Show();
fs:SetDataSource(function(cell, data, pos)
	-- Select the current sound
	if (data.name == pathEdit:GetText()) then cell:Select(); else cell:Unselect(); end
	-- Apply the text
	cell.text:SetText(data.title);
	local closure = data.name;
	cell:SetScript("OnClick", function() pathEdit:SetText(closure); fs:Update(); end);
end, VFL.ArrayLiterator(VFLUI.GetSoundList()));
fs:Rebuild();

function UpdateSoundPicker() fs:Update(); end

----------- Buttons
local btnCopy = VFLUI.Button:new(picker);
btnCopy:SetHeight(25); btnCopy:SetWidth(68);
btnCopy:SetPoint("BOTTOMLEFT", picker:GetClientArea(), "BOTTOMLEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local btnPaste = VFLUI.Button:new(picker);
btnPaste:SetHeight(25); btnPaste:SetWidth(68);
btnPaste:SetPoint("LEFT", btnCopy, "RIGHT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCancel = VFLUI.CancelButton:new(picker);
btnCancel:SetHeight(25); btnCancel:SetWidth(68);
btnCancel:SetPoint("LEFT", btnPaste, "RIGHT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnOK = VFLUI.OKButton:new(picker);
btnOK:SetHeight(25); btnOK:SetWidth(68);
btnOK:SetPoint("LEFT", btnCancel, "RIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

local function ClosePicker(nosmooth)
	if nosmooth then
		picker:Hide(); 
		pathEdit:SetText("");
		owner = nil;
		onCancel = VFL.Noop; onOK = VFL.Noop;
	else
		picker:_Hide(.2, nil, function()
			pathEdit:SetText("");
			owner = nil;
			onCancel = VFL.Noop; onOK = VFL.Noop;
		end);
	end
end

local function CancelPicker(nosmooth)
	if not picker:IsShown() then return; end
	onCancel();
	ClosePicker(nosmooth);
end

local function OKPicker()
	if not picker:IsShown() then return; end
	onOK(pathEdit:GetText());
	ClosePicker();
end

btnCancel:SetScript("OnClick", function() CancelPicker(); end);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clipboard then
		pathEdit:SetText(clipboard);
		UpdateSoundPicker();
	end
end);
btnCopy:SetScript("OnClick", function()
	clipboard = pathEdit:GetText();
end);

---------------------------- API
--- Launch the picker.
function VFLUI.SoundPicker(p_owner, fnOK, fnCancel, sound)
	if type(sound) ~= "string" then sound = ""; end
	-- Cancel any preexisting picker.
	if picker:IsShown() then CancelPicker(true); end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop;
	owner = p_owner; 
	pathEdit:SetText(sound);
	UpdateSoundPicker();
	picker:_Show(.2);
end
--- Check the picker's owner.
function VFLUI.SoundPickerOwner() return owner; end
--- Close the picker.
function VFLUI.CloseSoundPicker() ClosePicker(); end

-- Extract the key info from a sound path.
local function GetSoundInfoString(path)
	return string.match(path, "([^%/%\\]*)$") or "[none]";
end

--- Create a "select" button that will open the picker and invoke a callback
-- when the sound is changed.
function VFLUI.MakeSoundSelectButton(parent, sound, fnOK)
	if not fnOK then fnOK = VFL.Noop; end
	if not sound then sound = ""; end

	local self = VFLUI.Button:new(parent);
	self:SetWidth(180); self:SetHeight(24);
	self:SetText(GetSoundInfoString(sound));
	self.DialogOnLayout = VFL.Noop;

	function self:GetSelectedSound() return sound; end
	function self:SetSelectedSound(f) 
		sound = f;
		self:SetText(GetSoundInfoString(f));
	end

	self:SetScript("OnClick", function()
		VFLUI.SoundPicker(parent, function(snd) 
			sound = snd;
			self:SetText(GetSoundInfoString(snd));
			fnOK(snd); 
		end, VFL.Noop, sound);
	end);

	self.Destroy = VFL.hook(function(s)
		sound = nil;
		s.GetSelectedSound = nil; 
		s.SetSelectedSound = nil;
	end, self.Destroy);
	return self;
end
