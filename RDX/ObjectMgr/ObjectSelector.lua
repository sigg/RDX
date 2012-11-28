-- ObjectSelector.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- UI primitives for selecting preexisting objects.

--------------------------------------------------------------------------------
-- An edit control with file finding capabilities. Supports DialogOnLayout()
-- hierarchical layout system, and text added to the textbox is utilized
-- as a filter against the filename.
--------------------------------------------------------------------------------
RDXDB.ObjectFinder = {};

function RDXDB.ObjectFinder:new(parent, fileFilter)
	local obj = VFLUI.AcquireFrame("Frame");
	if parent then 
		obj:SetParent(parent);
		obj:SetFrameStrata(parent:GetFrameStrata()); obj:SetFrameLevel(parent:GetFrameLevel());
	end
	obj:SetHeight(24); obj:Show();

	--------------------------- Controls
	local btn = VFLUI.Button:new(obj);
	btn:SetHeight(24); btn:SetWidth(24);
	btn:SetPoint("RIGHT", obj, "RIGHT"); 
	btn:SetText("...");
	btn:Show();

	local editBox = VFLUI.Edit:new(obj);
	editBox:SetHeight(24); editBox:SetWidth(200);
	editBox:SetPoint("RIGHT", btn, "LEFT", 0, 0); editBox:SetText("");
	editBox:Show();

	local txt = VFLUI.CreateFontString(obj);
	txt:SetPoint("TOPLEFT", obj, "TOPLEFT");
	txt:SetPoint("BOTTOMRIGHT", editBox, "BOTTOMLEFT");
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));
	txt:SetJustifyV("CENTER"); txt:SetJustifyH("LEFT");
	txt:SetText(""); txt:Show();

	---------------------------- Gluecode
	local textFilter = VFL.True;
	local function CheckValid()
		local d,p,f = RDXDB.GetObjectData(editBox:GetText());
		return (d and fileFilter(p,f,d));
	end
	editBox:SetScript("OnTextChanged", function(self)
		if CheckValid() then
			self:SetTextColor(1,1,1);
			obj:OnPathChanged();
		else
			self:SetTextColor(1,0,0);
		end
	end);

	local function ToggleList()
		if RDXDB.IsExplorerPopupOpen() then
			RDXDB.CloseExplorerPopup();
		else
			local xp = RDXDB.ExplorerPopup(obj);
			xp:SetPoint("TOPRIGHT", obj, "BOTTOMRIGHT"); xp:Show();
			xp:SetFileFilter(fileFilter); xp:Rebuild();
			if CheckValid() then xp:SetPath(editBox:GetText()); end
			xp:EnableFeedback(function(zz)
				local p = zz:GetPath(); if p then editBox:SetText(p); end
			end);
		end
	end

	btn:SetScript("OnClick", ToggleList);

	--------- API
	obj.SetLabel = function(s, t) txt:SetText(t); end
	obj.SetPath = function(s, t) 
		editBox:SetText(t);
		VFLUI.FixEditBoxCursor(editBox);
	end
	obj.SetPathWidth = function(s, t) 
		editBox:SetWidth(t);
		--VFLUI.FixEditBoxCursor(editBox);
	end
	obj.CheckValid = CheckValid;
	obj.GetPath = function() return editBox:GetText(); end
	obj.DialogOnLayout = VFL.Noop;
	obj.OnPathChanged = VFL.Noop;
	
	--------- Destructor
	obj.Destroy = VFL.hook(function(s)
		-- Destroy API
		s.SetLabel = nil; s.SetPath = nil; s.SetPathWidth = nil; s.GetPath = nil; s.DialogOnLayout = nil;
		s.CheckValid = nil; s.OnPathChanged = nil;
		-- Destroy subobjects
		RDXDB.CloseExplorerPopup();
		btn:Destroy(); btn = nil; editBox:Destroy(); editBox = nil;
		VFLUI.ReleaseRegion(txt); txt = nil;
	end, obj.Destroy);

	return obj;
end

--------------------------------------------------
-- SINGLE PACKAGE SELECTOR
--------------------------------------------------
RDXDB.PackageSelector = {};
function RDXDB.PackageSelector:new(parent)
	local pkgEdit = VFLUI.Edit:new(parent);
	pkgEdit:SetHeight(25);

	local btn = VFLUI.Button:new(pkgEdit);
	btn:SetHeight(25); btn:SetWidth(25);
	btn:SetPoint("RIGHT", pkgEdit, "LEFT"); btn:Show(); 
	btn:SetText("...");
	btn:SetScript("OnClick", function()
		local qq = { };
		for pkg,_ in pairs(RDXDB.GetPackages()) do
			local retVal = pkg;
			table.insert(qq, { 
				text = retVal, 
				OnClick = function() 
					VFL.poptree:Release();
					pkgEdit:SetText(retVal);
				end
			});
		end
		table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
		VFL.poptree:Begin(150, 12, btn, "CENTER");
		VFL.poptree:Expand(nil, qq, 20);
	end);

	function pkgEdit:GetPackage()
		local txt = self:GetText();
		if RDXDB.IsValidFileName(txt) then return txt; end
	end
	function pkgEdit:SetPackage(sp)
		self:SetText(sp);
	end

	pkgEdit.Destroy = VFL.hook(function(s)
		s.GetPackage = nil; s.SetPackage = nil;
		btn:Destroy(); btn = nil;
	end, pkgEdit.Destroy);

	return pkgEdit;
end

--------------------------------------------------
-- MASS PACKAGE SELECTOR
--------------------------------------------------
function RDXDB.PackageListWindow(parent, title, text, filter, callback)
	if not callback then callback = VFL.Noop; end

	-- From the source array, build a local array of packages
	local pkgs = {};
	for k,pkg in pairs(RDXData) do
		if filter(k) then
			table.insert(pkgs, {pkg = k});
		end
	end
	table.sort(pkgs, function(p1,p2) return p1.pkg < p2.pkg; end);
	
	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(250); dlg:SetHeight(250);
	dlg:SetTitleColor(0,0,0.6); dlg:SetText(title); 
	dlg:Show();
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());


	local txt = VFLUI.CreateFontString(dlg);
	txt:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	txt:SetWidth(240); txt:SetHeight(30);
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP");
	txt:SetFontObject(Fonts.Default10);
	txt:Show(); txt:SetText(text);

	local pkgList = VFLUI.List:new(dlg, 12, function(parent)
		local c = VFLUI.Checkbox:new(parent);
		c.OnDeparent = c.Destroy;
		return c;
	end);
	pkgList:SetPoint("TOPLEFT", txt, "BOTTOMLEFT");
	pkgList:SetWidth(240); pkgList:SetHeight(156);
	pkgList:Rebuild(); pkgList:Show();
	pkgList:SetDataSource(function(cell, data, pos)
		cell:SetText(data.pkg);
		cell:SetChecked(data.sel);
		cell.check:SetScript("OnClick", function(self) data.sel = self:GetChecked(); end);
	end, VFL.ArrayLiterator(pkgs));
	pkgList:Update();

	-- OK/Cancel etc
	local btnCancel = VFLUI.CancelButton:new(dlg);
	btnCancel:SetHeight(25); btnCancel:SetWidth(60);
	btnCancel:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnCancel:SetText(VFLI.i18n("Cancel")); btnCancel:Show();
	btnCancel:SetScript("OnClick", function()
		dlg:Destroy();
		callback(nil);
	end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("RIGHT", btnCancel, "LEFT");
	btnOK:SetText(VFLI.i18n("OK")); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local psel = {};
		for k,v in pairs(pkgs) do
			if v.sel then psel[v.pkg] = true; end
		end
		dlg:Destroy();
		callback(psel);
	end);

	local btnNone = VFLUI.Button:new(dlg);
	btnNone:SetHeight(25); btnNone:SetWidth(60);
	btnNone:SetPoint("RIGHT", btnOK, "LEFT");
	btnNone:SetText(VFLI.i18n("None")); btnNone:Show();
	btnNone:SetScript("OnClick", function()
		for _,v in pairs(pkgs) do v.sel = nil; end
		pkgList:Update();
	end);

	local btnAll = VFLUI.Button:new(dlg);
	btnAll:SetHeight(25); btnAll:SetWidth(60);
	btnAll:SetPoint("RIGHT", btnNone, "LEFT");
	btnAll:SetText(VFLI.i18n("All")); btnAll:Show();
	btnAll:SetScript("OnClick", function()
		for _,v in pairs(pkgs) do v.sel = true; end
		pkgList:Update();
	end);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		btnCancel:Destroy(); btnOK:Destroy(); btnNone:Destroy(); btnAll:Destroy();
		btnCancel = nil; btnOK = nil; btnNone = nil; btnAll = nil;
		VFLUI.ReleaseRegion(txt); txt = nil;
		pkgList:Destroy(); pkgList = nil; pkgs = nil;
	end, dlg.Destroy);
end
