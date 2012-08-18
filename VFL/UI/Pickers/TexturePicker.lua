-- TexturePicker.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A window that allows a texture to be chosen visually.

VFLUI.defaultTexture = {
	color = {r=1,g=1,b=1,a=1};
	blendMode = "BLEND";
};

VFLUI.ErrorTexture = {
	color = {r=1,g=1,b=1,a=1};
	blendMode = "BLEND";
	path = "Interface\\Icons\\INV_Misc_QuestionMark";
};

local curTex, clipboard = {}, nil;
local onOK, onCancel, tp_owner = VFL.Noop, VFL.Noop, nil;
local UpdatePicker;

--------------- Texture picker window
local tp = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(tp, 20);
tp:SetBackdrop(VFLUI.BlackDialogBackdrop);
tp:SetText("Texture Picker");
tp:SetTitleColor(0,0,.6);
tp:SetWidth(650); tp:SetHeight(465);
tp:SetPoint("CENTER", VFLParent, "CENTER");
tp:SetMovable(true); tp:SetToplevel(nil);
VFLUI.Window.StdMove(tp, tp:GetTitleBar());
tp:Hide();
tp:SetClampedToScreen(true);
local ca = tp:GetClientArea();

------------------ Base texture selector
local tmpTex = VFLUI.CreateTexture(ca); tmpTex:Hide();
local BaseTextureUpdate;

local pathEdit = VFLUI.Edit:new(ca);
pathEdit:SetWidth(400); pathEdit:SetHeight(24);
pathEdit:SetPoint("TOPLEFT", ca, "TOPLEFT");
pathEdit:Show();

local chk_sc = VFLUI.Checkbox:new(ca);
chk_sc:SetHeight(16); chk_sc:SetWidth(100);
chk_sc:SetPoint("LEFT", pathEdit, "RIGHT", 25, 0);
chk_sc:SetText("Use solid color"); chk_sc:Show();
chk_sc.check:SetScript("OnClick", function() pathEdit:SetText(""); end);

local cs_sc = VFLUI.ColorSwatch:new(ca);
cs_sc:SetPoint("LEFT", chk_sc, "RIGHT", 0, -1); cs_sc:Show();
cs_sc:SetColor(1,1,1,1);
function cs_sc:OnColorChanged() BaseTextureUpdate(); end

pathEdit:SetScript("OnTextChanged", function(self)
	local tx = self:GetText() or "";
	-- See if the texture exists; if not, inform user by turning red
	if (tx == "") or (not tmpTex:SetTexture(tx)) then
		self:SetTextColor(1,0,0);
	else
		self:SetTextColor(1,1,1);
		chk_sc:SetChecked(nil);
		BaseTextureUpdate();
	end
end);

function BaseTextureUpdate()
	if chk_sc:GetChecked() then
		curTex.path = nil;
		curTex.color = cs_sc:GetColor();
	else
		curTex.color = nil;
		curTex.path = pathEdit:GetText();
	end
	UpdatePicker();
end

------------------- Preview
local pvwf = VFLUI.AcquireFrame("Frame");
pvwf:SetParent(ca);
pvwf:SetWidth(194); pvwf:SetHeight(194);
pvwf:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -25);
pvwf:SetBackdrop({
	bgFile="Interface\\Addons\\VFL\\Skin\\Checker", tile = true, tileSize = 15,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
});
pvwf:Show();

local pvw = pvwf:CreateTexture();
pvw:SetPoint("CENTER", pvwf, "CENTER");
pvw:SetWidth(192); pvw:SetHeight(192);
pvw:SetTexture(1,1,1,0.4); pvw:Show();

----------- Blend
local hadd = {
	{ text = "DISABLE" },
	{ text = "BLEND" },
	{ text = "ALPHAKEY" },
	{ text = "ADD" },
	{ text = "MOD" },
};
function VFLUI.BlendModeDropdownFunction() return hadd; end

local lbl = VFLUI.MakeLabel(nil, ca, "Blend mode:");
lbl:SetWidth(80); lbl:SetPoint("TOPLEFT", pvwf, "BOTTOMLEFT", 0, -8);

local dd_blend = VFLUI.Dropdown:new(ca, VFLUI.BlendModeDropdownFunction, function(bm)
	curTex.blendMode = bm;
	UpdatePicker();
end);
dd_blend:SetWidth(90); dd_blend:SetPoint("LEFT", lbl, "RIGHT"); dd_blend:Show();

------------------ Vertex color
local VCUpdate, chk_vc, chk_grad, chk_transform, chk_tr2;

chk_vc = VFLUI.Checkbox:new(ca);
chk_vc:SetHeight(16); chk_vc:SetWidth(120);
chk_vc:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, -8);
chk_vc:SetText("Use vertex color"); chk_vc:Show();
chk_vc.check:SetScript("OnClick", function(self)
	if self:GetChecked() then chk_grad:SetChecked(nil); end
	VCUpdate(); 
end);

local cs_vc = VFLUI.ColorSwatch:new(ca);
cs_vc:SetPoint("LEFT", chk_vc, "RIGHT", 0, -1); cs_vc:Show();
cs_vc:SetColor(1,1,1,1);
function cs_vc:OnColorChanged() VCUpdate(); end

chk_grad = VFLUI.Checkbox:new(ca);
chk_grad:SetHeight(16); chk_grad:SetWidth(100);
chk_grad:SetPoint("TOPLEFT", chk_vc, "BOTTOMLEFT", 0, -5);
chk_grad:SetText("Use gradient:"); chk_grad:Show();
chk_grad.check:SetScript("OnClick", function(self) 
	if self:GetChecked() then chk_vc:SetChecked(nil); end
	VCUpdate(); 
end);

local gdir = {
	{ text = "HORIZONTAL" },
	{ text = "VERTICAL" },
};
function VFLUI.GradientDirectionDropdownFunction() return gdir; end
local dd_gradDir = VFLUI.Dropdown:new(ca, VFLUI.GradientDirectionDropdownFunction, function(gd)
	if VCUpdate then VCUpdate(); end
end);
dd_gradDir:SetWidth(110); dd_gradDir:SetPoint("TOPLEFT", chk_grad, "BOTTOMLEFT", 0, -2);
dd_gradDir:SetSelection("HORIZONTAL");
dd_gradDir:Show();

local cs_grad1 = VFLUI.ColorSwatch:new(ca);
cs_grad1:SetPoint("LEFT", dd_gradDir, "RIGHT", 3, 0); cs_grad1:Show();
cs_grad1:SetColor(1,1,1,1);
function cs_grad1:OnColorChanged() VCUpdate(); end

local cs_grad2 = VFLUI.ColorSwatch:new(ca);
cs_grad2:SetPoint("LEFT", cs_grad1, "RIGHT", 3, 0); cs_grad2:Show();
cs_grad2:SetColor(1,1,1,1);
function cs_grad2:OnColorChanged() VCUpdate(); end

----- transform

chk_transform = VFLUI.Checkbox:new(ca);
chk_transform:SetHeight(16); chk_transform:SetWidth(200);
chk_transform:SetPoint("TOPLEFT", dd_gradDir, "BOTTOMLEFT", 0, -5);
chk_transform:SetText("Use transform (l,r,b,t):"); chk_transform:Show();
chk_transform.check:SetScript("OnClick", function(self) 
	if self:GetChecked() then chk_tr2:SetChecked(nil); end
	VCUpdate(); 
end);

local tlEdit = VFLUI.Edit:new(ca);
tlEdit:SetWidth(40); tlEdit:SetHeight(24);
tlEdit:SetPoint("TOPLEFT", chk_transform, "BOTTOMLEFT");
tlEdit:Show();
--tlEdit:SetScript("OnTextChanged", function(self)
--	VCUpdate();
--end);

local trEdit = VFLUI.Edit:new(ca);
trEdit:SetWidth(40); trEdit:SetHeight(24);
trEdit:SetPoint("TOPLEFT", tlEdit, "TOPRIGHT");
trEdit:Show();
--trEdit:SetScript("OnTextChanged", function(self)
--	VCUpdate();
--end);

local tbEdit = VFLUI.Edit:new(ca);
tbEdit:SetWidth(40); tbEdit:SetHeight(24);
tbEdit:SetPoint("TOPLEFT", trEdit, "TOPRIGHT");
tbEdit:Show();
--tbEdit:SetScript("OnTextChanged", function(self)
--	VCUpdate();
--end);

local ttEdit = VFLUI.Edit:new(ca);
ttEdit:SetWidth(40); ttEdit:SetHeight(24);
ttEdit:SetPoint("TOPLEFT", tbEdit, "TOPRIGHT");
ttEdit:Show();
--ttEdit:SetScript("OnTextChanged", function(self)
--	VCUpdate();
--end);

-- rotation

chk_tr2 = VFLUI.Checkbox:new(ca);
chk_tr2:SetHeight(16); chk_tr2:SetWidth(200);
chk_tr2:SetPoint("TOPLEFT", tlEdit, "BOTTOMLEFT", 0, -5);
chk_tr2:SetText("Use (ULx, ULy, LLx, LLy, URx, URy, LRx, LRy):"); chk_tr2:Show();
chk_tr2.check:SetScript("OnClick", function(self) 
	if self:GetChecked() then chk_transform:SetChecked(nil); end
	VCUpdate(); 
end);

local tULxEdit = VFLUI.Edit:new(ca);
tULxEdit:SetWidth(40); tULxEdit:SetHeight(24);
tULxEdit:SetPoint("TOPLEFT", chk_tr2, "BOTTOMLEFT");
tULxEdit:Show();

local tULyEdit = VFLUI.Edit:new(ca);
tULyEdit:SetWidth(40); tULyEdit:SetHeight(24);
tULyEdit:SetPoint("TOPLEFT", tULxEdit, "TOPRIGHT");
tULyEdit:Show();

local tLLxEdit = VFLUI.Edit:new(ca);
tLLxEdit:SetWidth(40); tLLxEdit:SetHeight(24);
tLLxEdit:SetPoint("TOPLEFT", tULyEdit, "TOPRIGHT");
tLLxEdit:Show();

local tLLyEdit = VFLUI.Edit:new(ca);
tLLyEdit:SetWidth(40); tLLyEdit:SetHeight(24);
tLLyEdit:SetPoint("TOPLEFT", tLLxEdit, "TOPRIGHT");
tLLyEdit:Show();

local tURxEdit = VFLUI.Edit:new(ca);
tURxEdit:SetWidth(40); tURxEdit:SetHeight(24);
tURxEdit:SetPoint("TOPLEFT", tULxEdit, "BOTTOMLEFT");
tURxEdit:Show();

local tURyEdit = VFLUI.Edit:new(ca);
tURyEdit:SetWidth(40); tURyEdit:SetHeight(24);
tURyEdit:SetPoint("TOPLEFT", tURxEdit, "TOPRIGHT");
tURyEdit:Show();

local tLRxEdit = VFLUI.Edit:new(ca);
tLRxEdit:SetWidth(40); tLRxEdit:SetHeight(24);
tLRxEdit:SetPoint("TOPLEFT", tURyEdit, "TOPRIGHT");
tLRxEdit:Show();

local tLRyEdit = VFLUI.Edit:new(ca);
tLRyEdit:SetWidth(40); tLRyEdit:SetHeight(24);
tLRyEdit:SetPoint("TOPLEFT", tLRxEdit, "TOPRIGHT");
tLRyEdit:Show();

function VCUpdate()
	if chk_vc:GetChecked() then
		curTex.vertexColor = cs_vc:GetColor();
		curTex.gradDir = nil; curTex.grad1 = nil; curTex.grad2 = nil;
	elseif chk_grad:GetChecked() then
		curTex.vertexColor = nil;
		curTex.gradDir = dd_gradDir:GetSelection();
		curTex.grad1 = cs_grad1:GetColor(); curTex.grad2 = cs_grad2:GetColor();
	else
		curTex.vertexColor = nil;	curTex.gradDir = nil; curTex.grad1 = nil; curTex.grad2 = nil;
	end
	if chk_transform:GetChecked() then
		curTex.coord2 = nil;
		if not curTex.coord then curTex.coord = {}; end
		curTex.coord.l = VFL.clamp(tlEdit:GetNumber(), 0, 1);
		curTex.coord.r = VFL.clamp(trEdit:GetNumber(), 0, 1);
		curTex.coord.b = VFL.clamp(tbEdit:GetNumber(), 0, 1);
		curTex.coord.t = VFL.clamp(ttEdit:GetNumber(), 0, 1);
	elseif chk_tr2:GetChecked() then
		curTex.coord = nil;
		if not curTex.coord2 then curTex.coord2 = {}; end
		curTex.coord2.ULx = VFL.clamp(tULxEdit:GetNumber(), 0, 1);
		curTex.coord2.ULy = VFL.clamp(tULyEdit:GetNumber(), 0, 1);
		curTex.coord2.LLx = VFL.clamp(tLLxEdit:GetNumber(), 0, 1);
		curTex.coord2.LLy = VFL.clamp(tLLyEdit:GetNumber(), 0, 1);
		curTex.coord2.URx = VFL.clamp(tURxEdit:GetNumber(), 0, 1);
		curTex.coord2.URy = VFL.clamp(tURyEdit:GetNumber(), 0, 1);
		curTex.coord2.LRx = VFL.clamp(tLRxEdit:GetNumber(), 0, 1);
		curTex.coord2.LRy = VFL.clamp(tLRyEdit:GetNumber(), 0, 1);
	else
		curTex.coord2 = nil;
		curTex.coord = nil;
	end
	UpdatePicker();
end



----------- Updater
function UpdatePicker()
	VFLUI.SetTexture(pvw, curTex, true);
	if curTex.path then
		local resx, resy = 32, 32;
		local t = VFLUI.GetTextureByPath(curTex.path);
		if t then	resx, resy = VFLUI.AspectConstrainedFit(t.dx, t.dy, 192, 192); end
		pvw:SetWidth(resx); pvw:SetHeight(resy);
	else
		pvw:SetWidth(192); pvw:SetHeight(192);
	end
	if curTex.gradDir then
		chk_grad:SetChecked(true);
		dd_gradDir:SetSelection(curTex.gradDir);
		cs_grad1:SetColor(VFL.explodeRGBA(curTex.grad1));
		cs_grad2:SetColor(VFL.explodeRGBA(curTex.grad2));
	end
	if curTex.vertexColor then
		chk_vc:SetChecked(true);
		cs_vc:SetColor(VFL.explodeRGBA(curTex.vertexColor));
	end
	if curTex.coord then
		chk_transform:SetChecked(true);
		tlEdit:SetText(curTex.coord.l);
		trEdit:SetText(curTex.coord.r);
		tbEdit:SetText(curTex.coord.b);
		ttEdit:SetText(curTex.coord.t);
	elseif curTex.coord2 then
		chk_tr2:SetChecked(true);
		tULxEdit:SetText(curTex.coord2.ULx);
		tULyEdit:SetText(curTex.coord2.ULy);
		tLLxEdit:SetText(curTex.coord2.LLx);
		tLLyEdit:SetText(curTex.coord2.LLy);
		tURxEdit:SetText(curTex.coord2.URx);
		tURyEdit:SetText(curTex.coord2.URy);
		tLRxEdit:SetText(curTex.coord2.LRx);
		tLRyEdit:SetText(curTex.coord2.LRy);
	end
	dd_blend:SetSelection(curTex.blendMode);
end

----------- Category selector
local curCat, UpdateBrowser = nil, nil;
local curCatData = {};
local lbl2 = VFLUI.MakeLabel(nil, ca, "Category");
lbl2:SetWidth(126);
lbl2:SetPoint("TOPLEFT", pvwf, "TOPRIGHT");

local cs_decor = VFLUI.AcquireFrame("Frame");
cs_decor:SetParent(ca);
cs_decor:SetPoint("TOPLEFT", lbl2, "BOTTOMLEFT");
cs_decor:SetWidth(126); cs_decor:SetHeight(4*88 + 10);
cs_decor:SetBackdrop(VFLUI.DefaultDialogBorder); cs_decor:Show();

local cs = VFLUI.List:new(ca, 12, VFLUI.Selectable.AcquireCell);
cs:SetPoint("TOPLEFT", cs_decor, "TOPLEFT", 5, -5);
cs:SetWidth(116); cs:SetHeight(4*88); cs:Show();
cs:SetDataSource(function(cell, data, pos)
	-- Select the current face
	if curCat and curCat == data then	cell:Select(); else	cell:Unselect();end
	cell.text:SetText(data);
	cell:SetScript("OnClick", function() curCat = data; UpdateBrowser(); end);
end, VFL.ArrayLiterator(VFLUI.GetSortedTextureCategories()));
cs:Rebuild();

----------- Browser
lbl = VFLUI.MakeLabel(nil, ca, "Browser");
lbl:SetWidth(126);
lbl:SetPoint("LEFT", lbl2, "RIGHT");

local browser_decor = VFLUI.AcquireFrame("Frame");
browser_decor:SetParent(ca);
browser_decor:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
browser_decor:SetWidth(4*74 + 10 + 16); browser_decor:SetHeight(4*88 + 10);
browser_decor:SetBackdrop(VFLUI.DefaultDialogBorder); browser_decor:Show();

local function BrowserCellOnClick(cell)
	curTex = VFLUI.CopyTexture(cell._texture);
	if curTex.path then
		pathEdit:SetText(curTex.path);
	else
	end
end

local function BrowserAcquireCell(parent)
	local f = VFLUI.AcquireFrame("Button");
	VFLUI.StdSetParent(f, parent);
	f:SetWidth(74); f:SetHeight(88);
	f:SetScript("OnClick", BrowserCellOnClick);

	local hltTex = VFLUI.CreateTexture(f);
	hltTex:SetTexture(1,1,1,0.1);
	hltTex:SetAllPoints();
	hltTex:Show();
	f:SetHighlightTexture(hltTex);

	local tex = VFLUI.CreateTexture(f);
	tex:SetPoint("CENTER", f, "CENTER", 0, 6); tex:Show();

	local lbl = VFLUI.CreateFontString(f);
	lbl:SetHeight(20); lbl:SetWidth(74);
	lbl:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 1);
	VFLUI.SetFont(lbl, Fonts.Default, 10);
	lbl:SetTextColor(.75,.75,.25);
	lbl:Show();

	function f:SetTextureData(td)
		if not td then return; end
		VFLUI.SetTexture(tex, td);
		if td.path then
			local resx, resy = VFLUI.AspectConstrainedFit(td.dx, td.dy, 72, 72);
			tex:SetWidth(resx); tex:SetHeight(resy);
		else
			tex:SetWidth(72); tex:SetHeight(72);
		end
		lbl:SetText(td.title);
		self._texture = td;
	end

	f.Destroy = VFL.hook(function(s)
		s.SetTextureData = nil;
		s._texture = nil;
		hltTex:Destroy(); hltTex = nil;
		tex:Destroy(); tex = nil; lbl:Destroy(); lbl = nil;
	end, f.Destroy);

	return f;
end

local browser = VFLUI.Grid:new(ca);
browser:SetPoint("TOPLEFT", browser_decor, "TOPLEFT", 5, -5); browser:Show();
browser:Size(4, 4, BrowserAcquireCell); browser:Relayout();

local vg = VFLUI.VirtualGrid:new(browser);
function vg:GetVirtualSize() return 1, math.ceil(#curCatData / 4); end
function vg:OnRenderCell(c, x, y, vx, vy)
	local tx = curCatData[ (x+vx-1) + 4*(y+vy-2) ];
	if tx then
		c:SetTextureData(tx); c:Show();
	else
		c:Hide();
	end
end
vg:SetVirtualPosition(1,1);

function browser:SetVerticalScroll(val)
	local oldv,newv = vg.vy, math.floor(val);
	if(oldv ~= newv) then vg:SetVirtualPosition(1, newv); end
end

local sb = VFLUI.VScrollBar:new(browser);
sb:SetPoint("TOPLEFT", browser, "TOPRIGHT", 0, -16);
sb:SetWidth(16); sb:SetHeight(browser:GetHeight() - 32); sb:Show();
sb:SetMinMaxValues(1, 1); sb:SetValue(1);

function UpdateBrowser()
	cs:Update();
	VFL.empty(curCatData);
	if curCat then
		for _,tex in pairs(VFLUI._AllTextures()) do
			if tex.category == curCat then
				table.insert(curCatData, tex);
			end
		end
		table.sort(curCatData, function(x1,x2) return x1.title < x2.title; end);
	end

	local dx,dy = vg:GetVirtualSize();
	sb:SetMinMaxValues(1,dy);
	vg:SetVirtualPosition(1, 1);
end

----------- Init
local function InitPicker()
	if curTex.path then
		chk_sc:SetChecked(nil);
		pathEdit:SetText(curTex.path);
	elseif curTex.color then
		chk_sc:SetChecked(true);
		cs_sc:SetColor(VFL.explodeRGBA(curTex.color));
		UpdatePicker();
	end
	cs:Update();
end

----------- Buttons
local btnOK = VFLUI.OKButton:new(tp);
btnOK:SetHeight(25); btnOK:SetWidth(79);
btnOK:SetPoint("BOTTOMRIGHT", tp:GetClientArea(), "BOTTOMRIGHT", 0, 0);
btnOK:SetText("OK");
btnOK:Show();

local btnCancel = VFLUI.CancelButton:new(tp);
btnCancel:SetHeight(25); btnCancel:SetWidth(79);
btnCancel:SetPoint("RIGHT", btnOK, "LEFT", 0, 0);
btnCancel:SetText("Cancel");
btnCancel:Show();

local btnPaste = VFLUI.Button:new(tp);
btnPaste:SetHeight(25); btnPaste:SetWidth(79);
btnPaste:SetPoint("RIGHT", btnCancel, "LEFT", 0, 0);
btnPaste:SetText("Paste");
btnPaste:Show();

local btnCopy = VFLUI.Button:new(tp);
btnCopy:SetHeight(25); btnCopy:SetWidth(79);
btnCopy:SetPoint("RIGHT", btnPaste, "LEFT", 0, 0);
btnCopy:SetText("Copy");
btnCopy:Show();

local function ClosePicker(nosmooth)
	--if nosmooth then
		tp:Hide();
		curTex = VFL.copy(VFLUI.defaultTexture);
		tp_owner = nil;	onCancel = VFL.Noop; onOK = VFL.Noop;
	--else
	--	tp:_Hide(.2, nil, function()
	--		curTex = VFL.copy(VFLUI.defaultTexture);
	--		tp_owner = nil;	onCancel = VFL.Noop; onOK = VFL.Noop;
	--	end);
	--end
end

local function CancelPicker(nosmooth)
	if not tp:IsShown() then return; end
	onCancel();
	ClosePicker(nosmooth);
end

local function OKPicker()
	if not tp:IsShown() then return; end
	onOK(VFL.copy(curTex));
	ClosePicker();
end

btnCancel:SetScript("OnClick", function() CancelPicker(); end);
btnOK:SetScript("OnClick", OKPicker);
btnPaste:SetScript("OnClick", function()
	if clipboard then
		curTex = VFL.copy(clipboard);
		UpdatePicker();
	end
end);
btnCopy:SetScript("OnClick", function()
	clipboard = VFL.copy(curTex);
end);


---------------------------- API
--- Launch the picker.
function VFLUI.TexturePicker(owner, fnOK, fnCancel, tex, flaganchor)
	if type(tex) ~= "table" then tex = VFL.copy(VFLUI.defaultTexture); end
	-- Cancel any preexisting picker.
	if tp:IsShown() then CancelPicker(true); end
	onOK = fnOK or VFL.Noop; onCancel = fnCancel or VFL.Noop;
	tp_owner = owner;
	if flaganchor then tp:SetPoint("LEFT", tp_owner, "RIGHT", 10, 0); end
	curTex = VFLUI.CopyTexture(tex); 
	InitPicker();
	tp:Show();
	--tp:_Show(.2);
end
--- Check the picker's owner.
function VFLUI.TexturePickerOwner() return tp_owner; end
--- Close the picker.
function VFLUI.CloseTexturePicker() ClosePicker(); end

--- Create a "texture select" button that will open the picker and invoke a callback
-- when the texture is changed.
local function GetTexInfoString(texture)
	if texture.path then
		return string.match(texture.path, "([^%/%\\]*)$") or "[unknown]";
	elseif texture.color then
		local c = texture.color
		return "(" .. string.format("%0.1f", c.r) .. "," .. string.format("%0.1f", c.g) .. "," .. string.format("%0.1f", c.b) .. "," .. string.format("%0.1f", c.a) .. ")";
	else
		return "[unknown]";
	end
end

function VFLUI.MakeTextureSelectButton(parent, texture, fnOK, flaganchor)
	if not fnOK then fnOK = VFL.Noop; end
	if not texture then texture = VFL.copy(VFLUI.defaultTexture); end

	local self = VFLUI.Button:new(parent);
	self:SetWidth(180); self:SetHeight(24);
	self:SetText(GetTexInfoString(texture));
	self.DialogOnLayout = VFL.Noop;

	function self:GetSelectedTexture() return texture; end
	function self:SetSelectedTexture(f) 
		if type(f) ~= "table" then return; end
		texture = VFL.copy(f);
		self:SetText(GetTexInfoString(texture));
	end

	self:SetScript("OnClick", function()
		VFLUI.TexturePicker(parent, function(newT) 
			texture = newT;
			self:SetText(GetTexInfoString(texture));
			fnOK(texture); 
		end, VFL.Noop, texture, flaganchor);
	end);

	self.Destroy = VFL.hook(function(s)
		texture = nil;
		s.GetSelectedTexture = nil;
		s.SetSelectedTexture = nil;
	end, self.Destroy);
	return self;
end
