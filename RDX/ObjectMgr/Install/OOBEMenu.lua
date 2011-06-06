-- OpenRDX
-- Sigg Rashgarroth EU

-- Show a window for selecting packages.
local dlg = nil;

local function ShowOOBEListWindow(title, text, src, callback)
	if dlg then return; end
	if not callback then callback = VFL.Noop; end

	-- From the source array, build a local array of packages
	local pkgs = {};
	if src then
		for k,_ in pairs(src) do
			table.insert(pkgs, {pkg = k});
		end
	end
	table.sort(pkgs, function(p1,p2) return p1.pkg < p2.pkg; end);
	
	dlg = VFLUI.Window:new();
	dlg:SetFrameStrata("FULLSCREEN");
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(250); dlg:SetHeight(250);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText(title);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("oobe_manager") then RDXPM.RestoreLayout(dlg, "oobe_manager"); end

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
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "oobe_manager");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);

	-- OK/Cancel etc
	local btnCancel = VFLUI.CancelButton:new(dlg);
	btnCancel:SetHeight(25); btnCancel:SetWidth(60);
	btnCancel:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnCancel:SetText("Cancel"); btnCancel:Show();
	btnCancel:SetScript("OnClick", function()
		VFL.EscapeTo(esch);
		callback(nil);
	end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("RIGHT", btnCancel, "LEFT");
	btnOK:SetText("OK"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local psel = {};
		for k,v in pairs(pkgs) do
			if v.sel then psel[v.pkg] = true; end
		end
		VFL.EscapeTo(esch);
		callback(psel);
	end);

	local btnNone = VFLUI.Button:new(dlg);
	btnNone:SetHeight(25); btnNone:SetWidth(60);
	btnNone:SetPoint("RIGHT", btnOK, "LEFT");
	btnNone:SetText("None"); btnNone:Show();
	btnNone:SetScript("OnClick", function()
		for _,v in pairs(pkgs) do v.sel = nil; end
		pkgList:Update();
	end);

	local btnAll = VFLUI.Button:new(dlg);
	btnAll:SetHeight(25); btnAll:SetWidth(60);
	btnAll:SetPoint("RIGHT", btnNone, "LEFT");
	btnAll:SetText("All"); btnAll:Show();
	btnAll:SetScript("OnClick", function()
		for _,v in pairs(pkgs) do v.sel = true; end
		pkgList:Update();
	end);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		btnCancel:Destroy(); btnOK:Destroy(); btnNone:Destroy(); btnAll:Destroy();
		btnCancel = nil; btnOK = nil; btnNone = nil; btnAll = nil;
		VFLUI.ReleaseRegion(txt); txt = nil;
		pkgList:Destroy(); pkgList = nil;
	end, dlg.Destroy);
end

----------------------------------------------------
-- DROP
----------------------------------------------------
local function DoDrop(ary)
	if not ary then return; end
	for name,_ in pairs(ary) do
		RDX.ClearInstaller(name)
	end
	ReloadUI();
end

function RDXDB.DropOOBE()
	--VFL.poptree:Release();
	ShowOOBEListWindow("OOBE Manager", "Select OOBE to reinstall. The UI will be reloaded.", RDXG.oobe, DoDrop)
end


