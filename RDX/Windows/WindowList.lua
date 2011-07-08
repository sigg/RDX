-- WindowList.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE LICENSE.
-- UNLICENSED COPYING IS PROHIBITED.
--
-- The window list is a dialog that allows the rapid opening and closing of windows without
-- digging through the RDX Explorer.

---------------------------------------------------------------------
-- The "Description" feature that lets windows have descriptions.
---------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Description";
	title = VFLI.i18n("Description");
	category = VFLI.i18n("Misc");
	IsPossible = function(state)
		if state:Slot("GetContainingWindowState") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if (not desc) or (not desc.description) then
			VFL.AddError(errs, VFLI.i18n("Invalid description"));
			return nil;
		end
		return true;
	end;
	ApplyFeature = VFL.Noop;
	UIFromDescriptor = function(desc, parent, state)
		local txt = VFLUI.AcquireFrame("EditBox");
		VFLUI.StdSetParent(txt, parent, 1);
		txt:SetFontObject(Fonts.Default);
		txt:SetTextInsets(0,0,0,0);
		txt:SetAutoFocus(nil); txt:ClearFocus();
		txt:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
		txt:SetMultiLine(true); txt:Show();
		if desc and desc.description then txt:SetText(desc.description); end
		txt:SetFocus()

		txt.DialogOnLayout = VFL.Noop;
		function txt:GetDescriptor() return {feature = "Description", description = self:GetText(); } end

		return txt;
	end;
	CreateDescriptor = function() return {feature = "Description", description = ""}; end;
});

---------------------------------------------------------------------
-- Feature for hiding in windowlist.
---------------------------------------------------------------------
RDX.RegisterFeature({
	name = "WindowListHide";
	title = VFLI.i18n("Hide From Windowlist");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		return true;
	end;
	ApplyFeature = VFL.Noop;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return {feature = "WindowListHide"}; end;
});


---------------------------------------------------------------------
-- The window list dialog.
---------------------------------------------------------------------
local wl = {};

local function BuildWindowList(pkgfilter)
	VFL.empty(wl);
	local desc = nil;
	for pkg,data in pairs(RDXData) do
		if not pkgfilter or pkg == pkgfilter or pkg == "WoWRDX" or pkg == "default" then
			for file,md in pairs(data) do
				if (type(md) == "table") and md.data and md.ty and string.find(md.ty, "Window$") then
					local hide = RDXDB.HasFeature(md.data, "WindowListHide");
					if not hide then
						table.insert(wl, {path = RDXDB.MakePath(pkg, file), data = md.data});
					end
				end
			end
		end
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
	local inst = RDXDB.GetObjectInstance(path, true);
	if inst then
		--RDX.printI(VFLI.i18n("Closing Window at <") .. path .. ">");
		RDXDB.OpenObject(path, "Close");
		return;
	end
	-- "Open" case
	--RDX.printI(VFLI.i18n("Opening Window at <") .. path .. ">");
	RDXDB.OpenObject(path);
end

local dlg = nil;
function RDXDK.WindowList(parent)
	if dlg then return nil; end
	dlg = VFLUI.Window:new(parent);
	dlg:SetFraming(VFLUI.Framing.Sleek, nil, VFLUI.DarkDialogBackdrop);
	--dlg:SetBackdropColor(0,0,0,.8);
	dlg:SetTitleColor(0,.5,0);
	dlg:SetText(VFLI.i18n("Window List"));
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:Accomodate(566, 348);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	
	if RDXPM.Ismanaged("windowlist") then RDXPM.RestoreLayout(dlg, "windowlist"); end
	
	local ca = dlg:GetClientArea();

	local list = VFLUI.List:new(dlg, 12, CreateWindowListFrame);
	list:SetPoint("TOPLEFT", ca, "TOPLEFT");
	list:SetWidth(566); list:SetHeight(348);
	list:Rebuild(); list:Show();
	list:SetDataSource(function(cell, data, pos)
		local p = data.path;
		if RDXDB.PathHasInstance(p) then
			cell.text:SetText("|cFF00FF00" .. p .. "|r");
		else
			cell.text:SetText(p);
		end
		local str, df = nil, RDXDB.HasFeature(data.data, "Description");
		if df then str = df.description; end
		if str then
			cell.text2:SetText("|cFFCCCCCC" .. str .. "|r");
		else
			cell.text2:SetText(VFLI.i18n("|cFF777777(No description)|r"));
		end
		cell:SetScript("OnClick", function()
			WindowListClick(p); list:Update();
		end);
	end, VFL.ArrayLiterator(wl));
	
	-- Get current AUI name
	local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
	
	-- Build the base list
	BuildWindowList(auiname);
	list:Update();
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	-- Escapement
	local esch = function() 
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "windowlist");
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
	
	local listbtn = VFLUI.TexturedButton:new(dlg, 16, "Interface\\AddOns\\RDX\\Skin\\menu");
	listbtn:SetHighlightColor(0,1,1,1);
	listbtn:SetScript("OnClick", function()
		if dlg.toggle then
			local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
			BuildWindowList(auiname);
			dlg.toggle = nil
		else
			BuildWindowList();
			dlg.toggle = true;
		end
		list:Update();
	end);
	dlg:AddButton(listbtn);
	
	----------------- Close functionality
	dlg.Destroy = VFL.hook(function(s)
		s.toggle = nil;
		s._esch = nil;
		list:Destroy(); list = nil;
	end, dlg.Destroy);
end

function RDXDK.ToggleWindowList()
	if dlg then
		dlg:_esch();
	else
		RDXDK.WindowList();
	end
end

-- Mini window list
-- use with only classic menu bar

local function CreateMiniWindowListFrame()
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

	self.Destroy = VFL.hook(function(self)
		-- Destroy allocated regions
		VFLUI.ReleaseRegion(hltTexture); hltTexture = nil;
		VFLUI.ReleaseRegion(self.text); self.text = nil;
	end, self.Destroy);

	self.OnDeparent = self.Destroy;

	return self;
end

local dlg2 = nil;
function RDXDK.MiniWindowList(parent)
	if dlg2 then return nil; end
	dlg2 = VFLUI.Window:new(parent);
	dlg2:SetFraming(VFLUI.Framing.Sleek, nil, VFLUI.DarkDialogBackdrop);
	--dlg2:SetBackdropColor(0,0,0,.8);
	dlg2:SetTitleColor(0,.5,0);
	dlg2:SetText(VFLI.i18n("Window List"));
	dlg2:SetPoint("CENTER", VFLParent, "CENTER", -200, 0);
	dlg2:Accomodate(216, 250);
	
	VFLUI.Window.StdMove(dlg2, dlg2:GetTitleBar());
	
	if RDXPM.Ismanaged("miniwindowlist") then RDXPM.RestoreLayout(dlg2, "miniwindowlist"); end
	
	local ca = dlg2:GetClientArea();

	local list = VFLUI.List:new(dlg2, 10, CreateMiniWindowListFrame);
	list:SetPoint("TOPLEFT", ca, "TOPLEFT");
	list:SetWidth(216); list:SetHeight(250);
	list:Rebuild(); list:Show();
	list:SetDataSource(function(cell, data, pos)
		local p = data.path;
		if RDXDB.PathHasInstance(p) then
			cell.text:SetText("|cFF00FF00" .. p .. "|r");
		else
			cell.text:SetText(p);
		end
		cell:SetScript("OnClick", function()
			WindowListClick(p); list:Update();
		end);
	end, VFL.ArrayLiterator(wl));
	
	-- Get current AUI name
	local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
	
	-- Build the base list
	BuildWindowList(auiname);
	list:Update();
	
	dlg2:Show();
	
	-- Escapement
	local esch = function() 
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg2, "miniwindowlist");
			dlg2:Destroy(); dlg2 = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg2:_esch()
		VFL.EscapeTo(esch);
	end
	
	--local closebtn = VFLUI.CloseButton:new(dlg2);
	--closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	--dlg2:AddButton(closebtn);
	
	local listbtn = VFLUI.TexturedButton:new(dlg2, 16, "Interface\\AddOns\\RDX\\Skin\\menu");
	listbtn:SetHighlightColor(0,1,1,1);
	listbtn:SetScript("OnClick", function()
		if dlg2.toggle then
			local auipkg, auiname = RDXDB.ParsePath(RDXU.AUI);
			BuildWindowList(auiname);
			dlg2.toggle = nil
		else
			BuildWindowList();
			dlg2.toggle = true;
		end
		list:Update();
	end);
	dlg2:AddButton(listbtn);
	
	----------------- Close functionality
	dlg2.Destroy = VFL.hook(function(s)
		s.toggle = nil;
		s._esch = nil;
		list:Destroy(); list = nil;
	end, dlg2.Destroy);
end

function RDXDK.ToggleMiniWindowList()
	if dlg2 then
		dlg2:_esch();
	else
		RDXDK.MiniWindowList();
	end
end

function RDXDK.OpenMiniWindowList()
	if not dlg2 then
		RDXDK.MiniWindowList();
	end
end

function RDXDK.CloseMiniWindowList()
	if dlg2 then
		dlg2:_esch();
	end
end

