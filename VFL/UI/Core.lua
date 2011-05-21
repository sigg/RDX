-- UI\Core.lua
-- VFL 
-- (C)2006 Bill Johnson and the VFL Project.
--
-- Core functions for managing dynamic WoW UI primitives.

VFLUI = RegisterVFLModule({
	name = "VFLUI";
	description = "Common UI components for VFL";
	parent = VFL;
});
VFLP.RegisterCategory("VFL UI");

--------------------------------------------------
-- Fixed metadata
--------------------------------------------------
--- The "default" Dialog backdrop

--[[VFLUI.DefaultDialogBackdrop = { 
	bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
	edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = { left = 5, right = 5, top = 4, bottom = 5 }
};

VFLUI.DarkDialogBackdrop = { 
	bgFile="Interface\\Addons\\VFL\\Skin\\a80black", tile = true, tileSize = 16,
	edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = { left = 5, right = 5, top = 4, bottom = 5 }
};

VFLUI.BlackDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\black", tile = true, tileSize = 16,
	edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = { left = 5, right = 5, top = 4, bottom = 5 }
};

VFLUI.DefaultDialogBorder = {
	edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = { left = 5, right = 5, top = 4, bottom = 5 }
};
]]

VFLUI.BorderlessDialogBackdrop = {
	bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
};

VFLUI.WhiteBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\white", tile = true, tileSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
};

VFLUI.BlizzardDialogBackdrop = { 
	bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
	edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.DefaultDialogBackdrop = { 
	bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.DarkDialogBackdrop = { 
	bgFile="Interface\\Addons\\VFL\\Skin\\a80black", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.BlackDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\black", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.DefaultDialogBorder = {
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.BlueDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80blue", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.RedDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80red", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.GreenDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80green", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.YellowDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80yellow", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.MagentaDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80magenta", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.CyanDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80cyan", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

VFLUI.GreyDialogBackdrop = {
	bgFile="Interface\\Addons\\VFL\\Skin\\a80grey", tile = true, tileSize = 16,
	edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder", edgeSize = 8,
	insets = { left = 2, right = 2, top = 2, bottom = 2 },
};

--------------------------------------------------
-- WoW Universal Coordinates
--------------------------------------------------
local v;
local l, t, r, b, mx, my;
--- Convert a distance from frame-local coordinates to universal coordinates.
-- @param frame The local frame.
-- @param dx The amount to convert.
-- @return The distance in universal coordinates.
function VFLUI.ToUniversalAxis(frame, dx)
	return dx*frame:GetEffectiveScale();
end

function VFLUI.ToLocalAxis(frame, dx)
	return dx/frame:GetEffectiveScale();
end

function VFLUI.GetUniversalCoords(frame, x, y)
	if not x then return nil; end
	v = frame:GetEffectiveScale();
	return x*v, y*v;
end

function VFLUI.GetUniversalCoords4(frame, x, y, z, w)
	if not x then return nil; end
	v = frame:GetEffectiveScale();
	return x*v, y*v, z*v, w*v;
end

function VFLUI.GetLocalCoords(frame, x, y)
	if not x then return nil; end
	v = (1/frame:GetEffectiveScale());
	return x*v, y*v;
end

function VFLUI.GetLocalCoords4(frame, x, y, z, w)
	if not x then return nil; end
	v = (1/frame:GetEffectiveScale());
	return x*v, y*v, z*v, w*v;
end

function VFLUI.TransformCoords(from, to, x, y)
	v = (from:GetEffectiveScale() / to:GetEffectiveScale());
	return x*v, y*v;
end

function VFLUI.TransformCoords4(from, to, x, y, z, w)
	v = (from:GetEffectiveScale() / to:GetEffectiveScale());
	return x*v, y*v, z*v, w*v;
end

--- Get the mouse position in the local coordinates of the given frame.
function VFLUI.GetLocalMousePosition(frame)
	return VFLUI.GetLocalCoords(frame, GetCursorPosition());
end

--- Get the mouse position in the local coordinates of the given frame RELATIVE TO THE TOPLEFT OF THAT FRAME.
function VFLUI.GetRelativeLocalMousePosition(frame)
	l, t, mx, my = frame:GetLeft(), frame:GetTop(), VFLUI.GetLocalCoords(frame, GetCursorPosition());
	return (mx - l), (my - t);
end

function VFLUI.GetRelativeLocalMousePositionBL(frame)
	l, b, mx, my = frame:GetLeft(), frame:GetBottom(), VFLUI.GetLocalCoords(frame, GetCursorPosition());
	return (mx - l), (my - b);
end

--- Get the left, top, right, and bottom points of a frame in universal coordinates.
function VFLUI.GetUniversalBoundary(frame)
	return VFLUI.GetUniversalCoords4(frame, frame:GetLeft(), frame:GetTop(), frame:GetRight(), frame:GetBottom());
end
function VFLUI.GetLocalBoundary(frame)
	return frame:GetLeft(), frame:GetTop(), frame:GetRight(), frame:GetBottom();
end

--- Get the local coordinates of a point on the frame.
function VFLUI.GetPoint(frame, point)
	l,t,r,b = frame:GetLeft(), frame:GetTop(), frame:GetRight(), frame:GetBottom();
	if not l then return nil; end
	if point == "TOPLEFT" then
		return l,t;
	elseif point == "TOP" then
		return (l+r)/2, t;
	elseif point == "TOPRIGHT" then
		return r, t;
	elseif point == "RIGHT" then
		return r, (t+b)/2;
	elseif point == "BOTTOMRIGHT" then
		return r, b;
	elseif point == "BOTTOM" then
		return (l+r)/2, b;
	elseif point == "BOTTOMLEFT" then
		return l, b;
	elseif point == "LEFT" then
		return l, (t+b)/2;
	else
		return (l+r)/2, (t+b)/2;
	end
end

--- Get the universal coordinates of a given point on the frame.
function VFLUI.GetUniversalPoint(frame, point)
	mx,my = VFLUI.GetPoint(frame, point);
	if mx then
		v = frame:GetEffectiveScale();
		return mx*v, my*v;
	end
end

--- These codes were in the RDXWM, useful to be there. Sigg
--- Gets the corner of the screen (quadrant) best containing the box with the
-- given universal coordinates.
--
-- The screen is divided into four quadrants based on universal coordinates.
-- Information about these quadrants is used to make decisions about window layouts.
function VFLUI.GetBoxQuadrantbyPosition(left, top, right, bottom)
	left = math.abs(left - VFLUI.uScreenLeft);
	top = math.abs(top - VFLUI.uScreenTop);
	right = math.abs(right - VFLUI.uScreenRight);
	bottom = math.abs(bottom - VFLUI.uScreenBottom);
	if(top < bottom) then
		if(left < right) then return "TOPLEFT"; else return "TOPRIGHT"; end
	else
		if(left < right) then return "BOTTOMLEFT"; else return "BOTTOMRIGHT"; end
	end
end

--- Gets the corner of the screen (quadrant) best containing the given frame.
function VFLUI.GetFrameQuadrantbyFrame(frame)
	return VFLUI.GetBoxQuadrantbyPosition(VFLUI.GetUniversalBoundary(frame));
end

--- Given frame coordinates and an anchor point, anchors the frame appropriately based on that point.
function VFLUI.SetAnchorFramebyPosition(frame, ap, left, top, right, bottom)
	if(ap == "TOPLEFT") then
		frame:SetPoint("TOPLEFT", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, left, top));
	elseif(ap == "TOP") then
		frame:SetPoint("TOP", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, (left+right)/2, top));
	elseif(ap == "TOPRIGHT") then
		frame:SetPoint("TOPRIGHT", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, right, top));
	elseif(ap == "RIGHT") then
		frame:SetPoint("RIGHT", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, right, (top+bottom)/2));
	elseif(ap == "BOTTOMRIGHT") then
		frame:SetPoint("BOTTOMRIGHT", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, right, bottom));
	elseif(ap == "BOTTOM") then
		frame:SetPoint("BOTTOM", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, (left+right)/2, bottom));
	elseif(ap == "BOTTOMLEFT") then
		frame:SetPoint("BOTTOMLEFT", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, left, bottom));
	elseif(ap == "LEFT") then
		frame:SetPoint("LEFT", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, left, (top+bottom)/2));
	elseif(ap == "CENTER") then
		frame:SetPoint("CENTER", VFLParent, "BOTTOMLEFT", VFLUI.GetLocalCoords(frame, (left+right)/2, (top+bottom)/2));
	else
		error("VFLUI.SetAnchorFramebyPosition: invalid anchorpoint");
	end
end

-- Global universal coordinates for the screen itself
local scx, scy = VFLUI.GetUniversalCoords(VFLParent, VFLParent:GetCenter());
VFLUI.uxScreenCenter = scx;
VFLUI.uyScreenCenter = scy;
local sl, st, sr, sb = VFLUI.GetUniversalBoundary(VFLParent);
VFLUI.uScreenLeft = sl;
VFLUI.uScreenTop = st;
VFLUI.uScreenRight = sr;
VFLUI.uScreenBottom = sb;

--- Fit an original image into a constrained box, preserving the original image's aspect
-- ratio.
function VFLUI.AspectConstrainedFit(origW, origH, constraintW, constraintH)
	-- Abort if there's no work to do
	if(origW <= constraintW) and (origH <= constraintH) then return origW, origH; end
	-- Figure out the aspect ratio
	local ar, newx = origW / origH, 0;
	-- Try to fit the larger of the two constraints
	if constraintH >= constraintW then
		-- Try to fit constraintH first, if successful return, otherwise fit constraintW
		newx = constraintH * ar;
		if newx <= constraintW then return newx, constraintH; else return constraintW, constraintW*(1/ar); end
	else
		newx = constraintW * (1/ar);
		if newx <= constraintH then return constraintW, newx; else return constraintH * ar, constraintH; end
	end
end

----------------------------------
-- FRAME POOLS
----------------------------------
local objp = {};
local sobjp = {};

-- A simple ID counter for objects that require a name, to prevent naming collisions
local idcount = 0;
local function GetNextID()
	idcount = idcount + 1; return idcount;
end
VFL.GetNextID = GetNextID;

-- DEFERRED RELEASER
--
-- Concept: We don't want to reuse a frame until one render-frame after it gets released.
-- If we do, we can have dependency issues. So we must wait some time before reusing a
-- given frame.
--
-- Can't use traditional scheduling for this because it causes too much closure spam.
-- So let's use a data structure just like the ZMScheduler.
local drot, drpt = {}, {};
local mathdotfloor = math.floor;

local DRt, DRi;
local function DeferredRelease(dt, obj, pool)
	-- First "feign" the release...
	pool:OnRelease(obj);
	-- Now schedule the actual repopulation for later
	DRt, DRi = mathdotfloor((GetTime() + dt) * 1000), 0;
	while drot[DRt+DRi] do DRi=DRi+1; end
	drot[DRt+DRi] = obj; drpt[DRt+DRi] = pool
end

local DRTimer;
local function _DR()
	DRTimer = mathdotfloor(GetTime() * 1000), 0;
	for st, obj in pairs(drot) do
		if DRTimer > st then
			if obj.IsProtected and obj:IsProtected() then obj.jail = true; obj:EnableMouse(false); end
			drpt[st]:_Release(obj);
			drot[st] = nil; drpt[st] = nil;
		end
	end
end

local drframe = CreateFrame("Frame");
drframe:SetScript("OnUpdate", _DR);

-- Generic destructor function for pooled frames
local function GenericDestroy(self)
	if self.keypool then
		local pool = self._sourcePool;
		pool:OnRelease(self);
		pool:_Release(self);
	else
		DeferredRelease(1, self, self._sourcePool);
	end
	self._sourcePool = nil;
	self.Destroy = nil;
	self._originalAlpha = nil;
	self._originalScale = nil;
end
VFLP.RegisterFunc("VFL UI", "Destroy frame", GenericDestroy, true);


-- FRAME POOL CREATION API
--
-- Create a new kernel frame pool. After this operation completes,
-- VFLUI.AcquireFrame() will be usable to acquire frames of the new
-- type.
-- @param name The name of the object type stored in this pool.
-- @param onRel the OnRelease handler for this pool.
-- @param onFallback the OnFallback handler for this pool.
-- @param onAcq the OnAcquire handler for this pool.
function VFLUI.CreateFramePool(name, onRel, onFallback, onAcq, typepool)
	local p = VFL.Pool:new(typepool);
	p.name = name; 
	p.OnRelease = onRel; p.OnFallback = onFallback; p.OnAcquire = onAcq;
	objp[name] = p;
	table.insert(sobjp, p);
	table.sort(sobjp, function(x1,x2) return x1.name<x2.name; end);
end

----------------------------------------------
-- BASE FRAMEPOOLS
----------------------------------------------
-- Cleanup a LayoutFrame.
local function CleanupLayoutFrame(x)
	x:Hide(); x:SetParent(VFLParent); x:ClearAllPoints();
	x:SetHeight(1); x:SetWidth(1); x:SetAlpha(1); 
end
VFLUI._CleanupLayoutFrame = CleanupLayoutFrame;

local function RemoveFrameScripts(x)
	x:SetScript("OnUpdate", nil);	x:SetScript("OnShow", nil);	x:SetScript("OnHide", nil);
	x:SetScript("OnSizeChanged", nil); x:SetScript("OnEvent", nil); x:SetScript("OnMouseUp", nil);
	x:SetScript("OnMouseDown", nil); x:SetScript("OnMouseWheel", nil); x:SetScript("OnEnter", nil);
	x:SetScript("OnLeave", nil); x:SetScript("OnKeyDown", nil);	x:SetScript("OnKeyUp", nil);
end
VFLUI._RemoveFrameScripts = RemoveFrameScripts;

-- Cleanup a Frame
local function CleanupFrame(x)
	-- Cleanup scripts
	x:UnregisterAllEvents(); RemoveFrameScripts(x);
	x.isLayoutRoot = nil; x.DialogOnLayout = nil;
	-- Stop any and all movement
	x:StopMovingOrSizing();
	x:SetMovable(nil); x:SetResizable(nil); x:SetClampedToScreen(nil);
	x:Hide();
	x:SetFrameStrata("MEDIUM"); x:SetFrameLevel(1);
	-- Perform LayoutFrame cleanup...
	CleanupLayoutFrame(x);
	-- Frame specific cleanup
	x:SetScale(1);
	x:SetBackdrop(nil);
end
VFLUI._CleanupFrame = CleanupFrame;

-- Cleanup a Button
local function CleanupButton(x)
	x:SetScript("OnClick", nil); x:SetScript("PreClick", nil); x:SetScript("PostClick", nil);
	x:SetScript("OnDoubleClick", nil);
	x:RegisterForClicks("LeftButtonUp");
	x:SetNormalTexture(nil); x:SetHighlightTexture(nil); x:SetDisabledTexture(nil); x:SetPushedTexture(nil);
	x:EnableMouse(true);
	x:Enable(); x:SetButtonState("NORMAL", nil); x:UnlockHighlight();
	x:SetText("");
	x:SetNormalFontObject(Fonts.Default);
	x:SetDisabledFontObject(Fonts.Default);
	x:SetHighlightFontObject(Fonts.Default);
	CleanupFrame(x);
end

VFLUI._CleanupButton = CleanupButton;

-- Dirty hack: Font objects are broken. Override SetFontObject to do the right thing.
local function VFL_SetFontObject(frame, font, sz)
	if font.face then
		VFLUI.SetFont(frame, font, sz);
	else
		VFLUI.SetFont(frame, Fonts.Default, sz);
	end
end

-- Munge the font object twiddles on a Button/EditBox to do the right thing.
local function munged_STFO(btn, fo)
	if (type(fo) ~= "table") or (not fo.name) then btn:_SetNormalFontObject(fo); return; end
	btn:_SetNormalFontObject(FontObjects[fo.name]);
end
local function munged_SDFO(btn, fo)
	if (type(fo) ~= "table") or (not fo.name) then btn:_SetDisabledFontObject(fo); return; end
	btn:_SetDisabledFontObject(FontObjects[fo.name]);
end
local function munged_SHFO(btn, fo)
	if (type(fo) ~= "table") or (not fo.name) then btn:_SetHighlightFontObject(fo); return; end
	btn:_SetHighlightFontObject(FontObjects[fo.name]);
end
local function FixFontObjectNonsense(btn)
	btn._SetNormalFontObject = btn.SetNormalFontObject;
	btn._SetDisabledFontObject = btn.SetDisabledFontObject;
	btn._SetHighlightFontObject = btn.SetHighlightFontObject;
	btn.SetNormalFontObject = munged_STFO; 
	btn.SetDisabledFontObject = munged_SDFO;
	btn.SetHighlightFontObject = munged_SHFO;
end

VFLUI._FixFontObjectNonsense = FixFontObjectNonsense;

-- Class: Frame
VFLUI.CreateFramePool("Frame", function(pool, frame) CleanupFrame(frame); end, function() return CreateFrame("Frame"); end);

-- Class: SecureFrame
VFLUI.CreateFramePool("SecureFrame", function(pool, x)
	x:SetAttribute("toggleForVehicle", nil);
	CleanupFrame(x);
end, function()
	local f = CreateFrame("Frame", nil, nil, "SecureFrameTemplate");
	return f;
end);

-- Class: Button
VFLUI.CreateFramePool("Button", function(pool, x)
	CleanupButton(x);
end, function()
	local f = CreateFrame("Button");
	FixFontObjectNonsense(f);
	return f;
end, function(_, x)
	x:Enable();
end);

-- Class: CheckButton
VFLUI.CreateFramePool("CheckButton", function(pool, x) 
	x:SetCheckedTexture(nil); x:SetDisabledCheckedTexture(nil); x:SetChecked(nil);
	CleanupButton(x);
end, function()
	local f = CreateFrame("CheckButton");
	FixFontObjectNonsense(f);
	return f;
end, function(_, x)
	x:Enable();
end);

-- Class: SecureUnitButton
VFLUI.CreateFramePool("SecureUnitButton", function(pool, x)
	x:SetAttribute("toggleForVehicle", nil);
	x:SetScript("PreClick", nil); x:SetScript("PostClick", nil);
	x:SetNormalTexture(nil); x:SetHighlightTexture(nil); x:SetDisabledTexture(nil); x:SetPushedTexture(nil);
	x:Enable(); x:SetButtonState("NORMAL", nil); x:UnlockHighlight();
	x:SetText("");
	CleanupFrame(x);
end, function()
	local f = CreateFrame("Button", "secub" .. GetNextID(), nil, "SecureUnitButtonTemplate");
	FixFontObjectNonsense(f);
	return f;
end);

-- Class: EditBox
VFLUI.CreateFramePool("EditBox", function(pool, x) 
	x:SetScript("OnEditFocusGained", nil); x:SetScript("OnEditFocusLost", nil);
	x:SetScript("OnEnterPressed", nil);	x:SetScript("OnEscapePressed", nil);
	x:SetScript("OnTabPressed", nil);
	x:SetScript("OnTextChanged", nil); x:SetScript("OnTextSet", nil);
	x:SetAutoFocus(nil); x:ClearFocus();
	x:SetNumeric(nil); x:SetPassword(nil); x:SetMultiLine(nil);
	x:SetText(""); x:SetTextColor(1,1,1,1);
	CleanupFrame(x);
end, function() 
	local f = CreateFrame("EditBox");
	f.SetFontObject = VFL_SetFontObject;
	return f;
end);

-- Class: Slider
VFLUI.CreateFramePool("Slider", function(pool, x) 
	x:SetScript("OnValueChanged", nil);
	x:SetOrientation("VERTICAL");
	x:SetThumbTexture(nil);	x:SetMinMaxValues(0,0); x:SetValue(0);
	CleanupFrame(x);
end, function() return CreateFrame("Slider"); end);

-- Class: ScrollFrame
VFLUI.CreateFramePool("ScrollFrame", function(pool, x) 
	x:SetScrollChild(nil);
	x:SetScript("OnScrollRangeChanged", nil);
	x:SetScript("OnVerticalScroll", nil); x:SetScript("OnHorizontalScroll", nil);
	x:SetHorizontalScroll(0); x:SetVerticalScroll(0);
	CleanupFrame(x);
end, function() return CreateFrame("ScrollFrame"); end);

-- Class: StatusBar
VFLUI.CreateFramePool("StatusBar", function(pool, x) 
	x:SetMinMaxValues(0,1);	
	x:SetStatusBarTexture(nil);
	CleanupFrame(x);
end, function() return CreateFrame("StatusBar"); end);

-- Class: CoolDown
VFLUI.CreateFramePool("Cooldown", function(pool, x)
	x:SetCooldown(0,0);
	CleanupFrame(x);
end, function() return CreateFrame("Cooldown"); end);

-- Class: PlayerModel
VFLUI.CreateFramePool("PlayerModel", function(pool, x)
	x:ClearModel();
	CleanupFrame(x);
end, function() return CreateFrame("PlayerModel"); end);

-- Class: MessageFrame
VFLUI.CreateFramePool("MessageFrame", function(pool, x)
	x:Clear();
	CleanupFrame(x);
end, function() return CreateFrame("MessageFrame"); end);

-- New Hide/Show functions for frames.
local function TimerHide(f, t, z)
	if not t then return; end
	-- Calling because this function is hooked securely post-show.
	f:Show(); 
	if not f._originalAlpha then f._originalAlpha = f:GetAlpha(); end
	if not f._originalScale then f._originalScale = f:GetScale(); end
	VFLT.AdaptiveUnschedule(tostring(f).."hide");
	VFLT.AdaptiveUnschedule(tostring(f).."show");
	local currentAlpha = f:GetAlpha();
	local totalElapsed = 0;
	local tmp = 0;
	VFLT.AdaptiveSchedule(tostring(f).."hide", 0.021, function(_,elapsed)
		totalElapsed = totalElapsed + elapsed;
		if totalElapsed > t then
			VFLT.AdaptiveUnschedule(tostring(f).."hide");
			totalElapsed = 0;
			f:Hide();
			f:SetAlpha(f._originalAlpha or 1);
			if z then
				f:SetScale(f._originalScale or 1);
			end
			return;
		end
		f:SetAlpha(VFL.lerp1(1/t*totalElapsed, f._originalAlpha, 0));
		if z then
			tmp = VFL.lerp1(1/t*totalElapsed, f._originalScale, 0.01);
			if tmp == 0 then tmp = 0.01; end
			f:SetScale(tmp);
		end
	end);
end

local function TimerShow(f, t, z)
	if not t then return; end
	if not f._originalAlpha then f._originalAlpha = f:GetAlpha(); end
	if not f._originalScale then f._originalScale = f:GetScale(); end
	VFLT.AdaptiveUnschedule(tostring(f).."hide");
	VFLT.AdaptiveUnschedule(tostring(f).."show");
	local totalElapsed = 0;
	f:SetAlpha(0);
	if z then f:SetScale(0.01); end
	f:Show();
	VFLT.AdaptiveSchedule(tostring(f).."show", 0.021, function(_,elapsed)
		totalElapsed = totalElapsed + elapsed;
		if totalElapsed > t then
			VFLT.AdaptiveUnschedule(tostring(f).."show");
			totalElapsed = 0;
			f:Show();
			f:SetAlpha(f._originalAlpha or 1);
			if z then
				f:SetScale(f._originalScale or 1);
			end
			return;
		end
		f:SetAlpha(VFL.lerp1(1/t*totalElapsed, 0, f._originalAlpha));
		if z then
			f:SetScale(VFL.lerp1(1/t*totalElapsed, 0.01, f._originalScale));
		end
	end);
end

----------------------------------
-- FRAME POOL PUBLIC INTERFACES
----------------------------------
--- Get pools
function VFLUI.GetPoolsObject()
	return objp;
end

function VFLUI.GetSortPoolsObject()
	return sobjp;
end

--- Get pool
function VFLUI.GetPoolObject(frameType)
	return objp[frameType];
end

--- Empty the pool frame, call _Destroy if exist.
-- @param frameType The type of object desired. ("Frame", "Button", etc.)
function VFLUI.EmptyPool(frameType)
	local pool = objp[frameType];
	if not pool then return; end
	pool:Empty(function(self) if self._Destroy then self._Destroy(); self._Destroy = nil; end; end);
end

--- Determine if the given framepool exists.
function VFLUI.CanAcquireFrame(frameType)
	if objp[frameType] then return true; end
end

-- Move a frame to x,y position on screen over t seconds
local function moveFrame(frame, x, y, t)
    if not frame or not x or not y then
        return;
    end
    
end

local pool, frame;
--- Acquire a Frame-derived object of the given type
-- @param frameType The type of object desired. ("Frame", "Button", etc.)
-- @return An object of the given type in a clean state, or NIL on failure.
function VFLUI.AcquireFrame(frameType, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	pool = objp[frameType];
	if not pool then return nil; end
	frame = pool:Acquire(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
	--if not frame then return RDX.printE("no object in the pool " .. frameType); end
	if not frame then return nil; end
	frame._VFL = true;
	frame._sourcePool = pool;
	frame.Destroy = GenericDestroy;
	--if not frame._hookedHideShow then
	--	frame._hookedHideShow = true;
	--	hooksecurefunc(frame, "Hide", TimerHide);
	--	hooksecurefunc(frame, "Show", TimerShow);
	--end
	--frame.AnimationGroup = frame:CreateAnimationGroup();
	return frame;
end
VFLP.RegisterFunc("VFL UI", "Acquire frame", VFLUI.AcquireFrame, true);

--- Release a Frame-derived object.
-- @param frame An object previously returned by VFLUI.AcquireFrame.
function VFLUI.ReleaseFrame(frame)
	-- Sanity check
	if not frame then return; end
	-- Try for the Destroy method
	if frame.Destroy then 
		frame:Destroy();
	else
		VFLUI:Debug(1, "VFLUI: Error: VFLUI.ReleaseFrame() called on object without a Destroy method.");
	end
end

-----------------------------------------------------------------
-- REGION POOLING
-----------------------------------------------------------------

-- Dirty hack #2: save closures by pre-storing the parent objects. should be a large memory saver.
local acquire_parent = nil;

---------------------- FONTSTRING POOL
local p_fs = VFL.Pool:new();
p_fs.name = "FontStrings"; 
p_fs.OnRelease = function(pool, x) 
	x:Hide(); x:SetParent(VFLOrphan); x:ClearAllPoints(); x:SetAlpha(1);
	x:SetHeight(0); x:SetWidth(0);
--	x:SetFontObject(GameFontNormal);
	x:SetTextColor(1,1,1,1); 
--	x:SetAlphaGradient(0,0);
	x:SetShadowColor(0,0,0,0); x:SetShadowOffset(0,0);
	x:SetJustifyH("CENTER"); x:SetJustifyV("CENTER");
	x:SetText("");
end;
p_fs.OnFallback = function()
	local fs = acquire_parent:CreateFontString();
	fs.SetFontObject = VFL_SetFontObject;
	return fs; 
end

local function DestroyFontString(x)
	DeferredRelease(1, x, p_fs);
	x.Destroy = nil;
end

--- Acquire a FontString as a child of the given frame.
-- @param parent The frame to which this FontString will be attached.
-- @return The FontString, or NIL on failure.
function VFLUI.CreateFontString(parent)
	acquire_parent = parent;
	local rgn = p_fs:Acquire();
	acquire_parent = nil;
	rgn:SetParent(parent);
	--rgn.AnimationGroup = rgn:CreateAnimationGroup();
	rgn.Destroy = DestroyFontString;
	return rgn;
end

--- Get pool
function VFLUI.GetPoolFonts()
	return p_fs;
end

-------------------- TEXTURE POOL
local p_tex = VFL.Pool:new();
p_tex.name = "Textures"; 
p_tex.OnRelease = function(pool, x) 
	x:Hide(); x:SetTexture(nil); 
	x:SetParent(VFLOrphan); x:ClearAllPoints(); x:SetAlpha(1);
	x:SetDesaturated(nil);
	x:SetTexCoord(0,1,0,1);
	x:SetBlendMode("BLEND"); x:SetDrawLayer("ARTWORK", 1); 
	x:SetVertexColor(1,1,1,1);
end;
p_tex.OnFallback = function()
	return acquire_parent:CreateTexture();
end

local function DestroyTexture(x)
	DeferredRelease(1, x, p_tex);
	x.Destroy = nil;
end

--- Acquire a Texture as a child of the given frame.
-- @param parent The frame to which this Texture will be attached.
-- @return The texture, or NIL on failure.
function VFLUI.CreateTexture(parent)
	if not parent then return nil; end
	acquire_parent = parent;
	local rgn = p_tex:Acquire();
	acquire_parent = nil;
	rgn:SetParent(parent);
	--rgn.AnimationGroup = rgn:CreateAnimationGroup();
	rgn.Destroy = DestroyTexture;
	return rgn;
end

function VFLUI.GetPoolTextures()
	return p_tex;
end

--- Manually release a Region.
-- @param rgn The region to be freed.
function VFLUI.ReleaseRegion(rgn)
	rgn:Destroy();
end

--------------------------------------------------------
-- Animation Group Pool WoW3.1 
-- NOT USE... erf
-- an AG is link to his parent object and can not be reused
--------------------------------------------------------
local p_ag = VFL.Pool:new();
p_ag.name = "AnimationGroups"; 
p_ag.OnRelease = function(pool, x) 
	x:Hide();
	x:Stop();
	x:SetLooping("NONE");
	--Animation release
	x:SetScript("OnLoad", nil);
	x:SetScript("OnPlay", nil);
	x:SetScript("OnPaused", nil);
	x:SetScript("OnStop", nil);
	x:SetScript("OnFinished", nil);
	x:SetScript("OnUpdate", nil);
	x:SetParent(VFLOrphan);
end;
p_ag.OnFallback = function()
	return acquire_parent:CreateAnimationGroup();
end

local function DestroyAnimationGroup(x)
	DeferredRelease(1, x, p_ag);
	x.Destroy = nil;
end

--- Acquire a AnimationGroup as a child of the given object.
-- @param parent The object to which this AnimationGroup will be attached.
-- @return The Animation, or NIL on failure.
function VFLUI.CreateAnimationGroup(parent)
	acquire_parent = parent;
	local ag = p_ag:Acquire();
	acquire_parent = nil;
	--ag:SetParent(parent);
	ag.Destroy = DestroyAnimationGroup;
	return ag;
end

--- Manually release a Region.
-- @param rgn The region to be freed.
--function VFLUI.ReleaseRegion(ag)
--	ag:Destroy();
--end

--------------------------------------------------------
-- Animation Pool WoW3.1
--------------------------------------------------------
local function DestroyAnimation(x)
	DeferredRelease(1, x, x._sourcePool);
	x.Destroy = nil;
end

local anip = {};

-- Animation POOL CREATION API
--
-- Create a new kernel animation pool. After this operation completes,
-- VFLUI.AcquireAnimation() will be usable to acquire Animations of the new
-- type.
-- @param name The name of the object type stored in this pool.
-- @param onRel the OnRelease handler for this pool.
-- @param onFallback the OnFallback handler for this pool.
-- @param onAcq the OnAcquire handler for this pool.
function VFLUI.CreateAnimationPool(name, onRel, onFallback, onAcq)
	local p = VFL.Pool:new();
	p.name = name; 
	p.OnRelease = onRel; p.OnFallback = onFallback; p.OnAcquire = onAcq;
	anip[name] = p;
end

VFLUI.CreateAnimationPool("ROTATION", function(pool, x)
	x:Stop();
	x:SetDuration(0);
	x:SetDegrees(0);
	--x:SetOrigin();
	x:SetParent(VFLOrphanAnimGroup);
end, function(_, _, AGparent)
	return AGparent:CreateAnimation("ROTATION");
end);

VFLUI.CreateAnimationPool("TRANSLATION", function(pool, x)
	x:Stop();
	x:SetDuration(0);
	x:SetParent(VFLOrphanAnimGroup);
end, function(_, _, AGparent)
	return AGparent:CreateAnimation("TRANSLATION");
end);

VFLUI.CreateAnimationPool("ALPHA", function(pool, x)
	x:Stop();
	x:SetDuration(0);
	x:SetChange(1);
	x:SetParent(VFLOrphanAnimGroup);
end, function(_, _, AGparent)
	return AGparent:CreateAnimation("ALPHA");
end);

VFLUI.CreateAnimationPool("SCALE", function(pool, x)
	x:Stop();
	x:SetDuration(0);
	x:SetParent(VFLOrphanAnimGroup);
end, function(_, _, AGparent)
	return AGparent:CreateAnimation("SCALE");
end);

--- Acquire a Animation as a child of the given AnimationGroup.
-- @param parent The AnimationGroup to which this Animation will be attached.
-- @return The Animation, or NIL on failure.
function VFLUI.CreateAnimation(AGparent, aniType)
	local pool = anip[aniType];
	if not pool then return nil; end
	local ani = pool:Acquire(_, AGparent);
	if not ani then return nil; end
	ani:SetParent(AGparent);
	ani._VFL = true;
	ani._sourcePool = pool;
	ani.Destroy = DestroyAnimation;
	return ani;
end

--- Manually release a Animation.
-- @param ani The Animation to be freed.
function VFLUI.ReleaseAnimation(ani)
	ani:Destroy();
end

--------------------------------------------
-- HIERARCHICAL LAYOUT CORE
--------------------------------------------
--- Find the root of the given layout tree.
-- @param x An element of a dialog layout tree.
-- @returns The root element of the layout tree, or NIL for none.
function VFLUI.FindLayoutRoot(x)
	while x do
		if x.isLayoutRoot then return x; end
		x = x:GetParent();
	end
	return nil;
end

--- Update a dialog's layout. CATACLYSM
--function VFLUI.UpdateDialogLayout(x)
--	local r = VFLUI.FindLayoutRoot(x);
--	if (not r) or r._layout_dirty then return; end
--	r._layout_dirty = true;
--	r._oldOnUpdate = r:GetScript("OnUpdate");
--	r:SetScript("OnUpdate", function(this)
--		this:SetScript("OnUpdate", this._oldOnUpdate); this._oldOnUpdate = nil;
--		this._layout_dirty = nil;
--		this:DialogOnLayout();
--	end);
--end
function VFLUI.UpdateDialogLayout(x)
	local r = VFLUI.FindLayoutRoot(x);
	if (not r) or r._layout_dirty then return; end
	r._layout_dirty = true;
	r._oldOnUpdate = r:GetScript("OnUpdate");
	r:SetScript("OnUpdate", function(self)
		self:SetScript("OnUpdate", self._oldOnUpdate); self._oldOnUpdate = nil;
		self._layout_dirty = nil;
		self:DialogOnLayout();
	end);
end

---------------------------------------
-- HOOKABLE UI SCRIPTING
---------------------------------------
function VFLUI.AddScript(frame, event, fn)
	local oldScript = frame:GetScript(event);
	if not oldScript then
		frame:SetScript(event, fn);
	else
		frame:SetScript(event, function() oldScript(); fn(); end);
	end
end

------------------------------------------
-- USEFUL HELPER FUNCTIONS
------------------------------------------
-- Set the parent of the given frame to the given frame, and adjust the
-- layout parameters appropriately.
function VFLUI.StdSetParent(frame, parent, flm)
	if frame and parent then
		frame:SetParent(parent); frame:SetFrameStrata(parent:GetFrameStrata());
		frame:SetFrameLevel(parent:GetFrameLevel() + (flm or 1));
	end
end

--- Get the "opposite" side of a given point.
function VFLUI.GetOppositePoint(point)
	if (point == "TOP") then
		return "BOTTOM", 0, -1;
	elseif (point == "TOPRIGHT") then
		return "TOPLEFT", -1, 0;
	elseif (point == "RIGHT") then
		return "LEFT", -1, 0;
	elseif (point == "BOTTOMRIGHT") then
		return "TOPLEFT", -1, 1;
	elseif (point == "BOTTOM") then
		return "TOP", 0, 1;
	elseif (point == "BOTTOMLEFT") then
		return "TOPRIGHT", 1, 1;
	elseif (point == "LEFT") then
		return "RIGHT", 1, 0;
	elseif (point == "TOPLEFT") then
		return "TOPRIGHT", 1, 0;
	else
		error("VFLUI.GetOppositePoint(): Invalid anchor point");
	end
end

local idToStrata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"FULLSCREEN",
	--"FULLSCREEN_DIALOG",
	--"TOOLTIP",
};
local strataToId = VFL.invert(idToStrata);

local idstrata;
function VFLUI.GetRelativeStata(strata, inc)
	if not strata or not inc then return(strata); end
	idstrata = strataToId [strata];
	if not idstrata then return(strata); end
	return idToStrata[idstrata + inc] or strata;
end

