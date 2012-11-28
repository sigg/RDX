-- IconPicker.lua
-- VFL
-- (C)2006 Bill Johnson
--
-- A frame that can be used to select an icon or texture, either from WoW's
-- internal repository or from a user-entered path.

local function IWAcquireCell(parent)
	local f = VFLUI.AcquireFrame("Button");
  VFLUI.StdSetParent(f, parent);
	f:SetWidth(32); f:SetHeight(32);
	local tex = VFLUI.CreateTexture(f);
	tex:SetAllPoints(f); tex:Show();
	function f:SetIcon(path) tex:SetTexture(path); end

	f.Destroy = VFL.hook(function(s)
		s.SetIcon = nil;
		VFLUI.ReleaseRegion(tex); tex = nil;
	end, f.Destroy);

	f.OnDeparent = f.Destroy;
	
	return f;
end
	
local iw = nil;

local function CloseIconWindow()
	if iw then iw:Destroy(); iw = nil; end
end

local function OpenIconWindow(parent, callback, lp, rf, rp, dx, dy)
	-- Destroy any preexisting icon window
	if iw then iw:Destroy(); iw = nil; end

	iw = VFLUI.AcquireFrame("Frame");
	iw:SetParent(parent or VFLFULLSCREEN);
	iw:SetScale(parent:GetEffectiveScale() / VFLParent:GetEffectiveScale());
	iw:SetWidth(202); iw:SetHeight(122);
	iw:SetPoint(lp, rf, rp, dx, dy);
	iw:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	iw:Show();

	local g = VFLUI.Grid:new(iw);
	g:SetPoint("TOPLEFT", iw, "TOPLEFT", 5, -5); g:Show();
	g:Size(6, 3, IWAcquireCell); g:Relayout();

	local vg = VFLUI.VirtualGrid:new(g);
	function vg:GetVirtualSize()
		return ((GetNumMacroIcons() / 3) - 3), 3;
	end
	function vg:OnRenderCell(c, x, y, vx, vy)
		local tx = GetMacroIconInfo( 3*(x+vx-2) + (y+vy-1) );
		c:SetIcon(tx);
		c:SetScript("OnClick", function() iw:Destroy(); callback(tx); end);
		c:Show();
	end
	local dx,dy = vg:GetVirtualSize();
	vg:SetVirtualPosition(1, 1);

	function g:SetHorizontalScroll(val)
		local oldv,newv = vg.vx, math.floor(val);
		if(oldv ~= newv) then vg:SetVirtualPosition(newv, 1); end
	end

	local sb = VFLUI.HScrollBar:new(g);
	sb:SetPoint("TOPLEFT", g, "BOTTOMLEFT", 16, 0);
	sb:SetWidth(g:GetWidth() - 32); sb:SetHeight(16);
	sb:Show();
	sb:SetMinMaxValues(1, dx);
	sb:SetValue(1);
	VFL.AddEscapeHandler(CloseIconWindow);
	
	iw.Destroy = VFL.hook(function(s)
		VFL.RemoveEscapeHandler(CloseIconWindow);
		sb:Destroy(); sb = nil;
		g.SetHorizontalScroll = nil; vg:Destroy(); vg = nil; g = nil;
		iw = nil;
	end, iw.Destroy);
end

VFLUI.IconPicker = {};
function VFLUI.IconPicker:new(parent)
	local self = VFLUI.AcquireFrame("Frame");
	self:SetHeight(32); self:SetWidth(202);
	VFLUI.StdSetParent(self, parent);

	local curTex = VFLUI.CreateTexture(self);
	curTex:SetHeight(32); curTex:SetWidth(32);
	curTex:SetPoint("LEFT", self, "LEFT"); curTex:Show();

	local curPath = VFLUI.Edit:new(self);
	curPath:SetHeight(25); curPath:SetWidth(145);
	curPath:SetPoint("LEFT", curTex, "RIGHT"); curPath:Show();
	curPath:SetScript("OnTextChanged", function(self)
		if curTex:SetTexture(self:GetText()) then
			self:SetTextColor(1,1,1);
		else
			curTex:SetTexture(nil);
			self:SetTextColor(1,0,0);
		end
	end);

	-- Icon panel opener
	local btn = VFLUI.Button:new(self);
	btn:SetHeight(25); btn:SetWidth(25);
	btn:SetPoint("LEFT", curPath, "RIGHT"); btn:SetText("..."); btn:Show();
	btn:SetScript("OnClick", function()
		OpenIconWindow(self, function(tex)
			curPath:SetText(tex or "");
		end, "TOPLEFT", self, "BOTTOMLEFT");
	end);
	
	function self:SetIconPath(txt) curPath:SetText(txt or ""); end
	function self:GetIconPath() return curPath:GetText(); end

	self.DialogOnLayout = VFL.Noop;

	self.Destroy = VFL.hook(function(s)
		CloseIconWindow();
		VFLUI.ReleaseRegion(curTex); curTex = nil;
		curPath:Destroy(); curPath = nil;
		btn:Destroy(); btn = nil;
		s.SetIconPath = nil; s.GetIconPath = nil;
	end, self.Destroy);

	return self;
end

