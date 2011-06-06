-- WindowLessList.lua
-- OpenRDX
--

---------------------------------------------------------------------
-- The window list dialog.
---------------------------------------------------------------------
local dlg = nil;

local wl = {};

local function BuildWindowList()
	VFL.empty(wl);
	local desc = nil;
	for k,v in pairs(RDXDK._GetWindowsLess()) do
		table.insert(wl, {path = k, data = v});
	end
	table.sort(wl, function(x1,x2) return x1.path<x2.path; end);
end

local function CreateWindowListFrame()
	local self = VFLUI.AcquireFrame("Button");
	
	-- Create the button highlight texture
	local hltTexture = VFLUI.CreateTexture(self);
	hltTexture:SetAllPoints(self);
	hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	hltTexture:Show();
	self:SetHighlightTexture(hltTexture);

	-- Create the text
	local text = VFLUI.CreateFontString(self);
	text:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));	text:SetJustifyH("LEFT");
	text:SetTextColor(1,1,1,1);
	text:SetPoint("LEFT", self, "LEFT"); text:SetHeight(10); text:SetWidth(200);
	text:Show();
	self.text = text;

	text = VFLUI.CreateFontString(self);
	text:SetFontObject(VFLUI.GetFont(Fonts.Default, 10)); text:SetJustifyH("LEFT");
	text:SetTextColor(1,1,1,1);
	text:SetPoint("RIGHT", self, "RIGHT");  text:SetHeight(10); text:SetWidth(350);
	text:Show();
	self.text2 = text;

	self.Destroy = VFL.hook(function(self)
		-- Destroy allocated regions
		VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
		VFLUI.ReleaseRegion(self.text); self.text = nil;
		VFLUI.ReleaseRegion(self.text2); self.text2 = nil;
	end, self.Destroy);

	self.OnDeparent = self.Destroy;

	return self;
end

local function WindowListClick(path)
	-- "Close" case
	if InCombatLockdown() then return; end
	if RDXDK._IsWindowOpen(path) then
		RDXDK._DelRegisteredWindowRDX(path);
	else
		RDXDK._AddRegisteredWindowRDX(path);
	end
end

function RDXDK.WindowLessList()
	if dlg then return; end

	dlg = VFLUI.Window:new();
	dlg:SetFraming(VFLUI.Framing.Sleek);
	dlg:SetBackdropColor(0,0,0,.8);
	dlg:SetTitleColor(0,.5,0);
	dlg:SetText(VFLI.i18n("Window List"));
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:Accomodate(566, 348);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("windowlesslist") then RDXPM.RestoreLayout(dlg, "windowlesslist"); end
	local ca = dlg:GetClientArea();

	local list = VFLUI.List:new(dlg, 12, CreateWindowListFrame);
	list:SetPoint("TOPLEFT", ca, "TOPLEFT");
	list:SetWidth(566); list:SetHeight(348);
	list:Rebuild(); list:Show();
	list:SetDataSource(function(cell, data, pos)
		local p = data.path;
		if data.data.IsOpen and data.data.IsOpen() then
			cell.text:SetText("|cFF00FF00" .. p .. "|r");
		else
			cell.text:SetText(p);
		end
		local str = data.data.Description;
		if str then
			cell.text2:SetText("|cFFCCCCCC" .. str .. "|r");
		else
			cell.text2:SetText(VFLI.i18n("|cFF777777(No description)|r"));
		end
		cell:SetScript("OnClick", function()
			WindowListClick(p); list:Update();
		end);
	end, VFL.ArrayLiterator(wl));
	
	-- Build the base list
	BuildWindowList();
	list:Update();
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	-- Escapement
	local esch = function() 
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "windowlesslist");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);
	
	----------------- Close functionality
	dlg.Destroy = VFL.hook(function(s)
		s._esch = nil;
		list:Destroy(); list = nil;
	end, dlg.Destroy);
end

function RDXDK.ToggleWindowLessList()
	if dlg then
		dlg:_esch();
	else
		RDXDK.WindowLessList();
	end
end


