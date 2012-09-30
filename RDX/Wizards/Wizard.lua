-- Wizard.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Basic UI primitives used in constructing a "wizard" scheme.

RDXUI.Wizard = {};
RDXUI.Wizard.__index = RDXUI.Wizard;

function RDXUI.Wizard:new(desc)
	local x = {};
	x.desc = desc or {};
	x.page = {};
	x.index = {};
	x.pageNum = nil; x.history = {};
	x.child = nil;
	x.window = nil; 
	x.nextBtn = nil; x.prevBtn = nil; x.OKBtn = nil; x.cancelBtn = nil;
	x.title = "";
	x.OnOK = VFL.Noop; x.OnCancel = VFL.Noop;
	setmetatable(x, RDXUI.Wizard);
	return x;
end

--- Open this wizard, displaying the first page.
function RDXUI.Wizard:Open(parent, num)
	self.history = {}; self.desc._ok = nil;
	if not self.window then

		local win = VFLUI.Window:new(parent);
		VFLUI.Window.SetDefaultFraming(win, 20);
		win:SetBackdrop(VFLUI.BlackDialogBackdrop);
		win:SetTitleColor(0,0,.6); win:SetText(self.title);
		win:SetPoint("TOPLEFT", VFLParent, "TOPLEFT", 100, -200);
		win:SetMovable(true); 
		VFLUI.Window.StdMove(win, win:GetTitleBar());
		win:SetClampedToScreen(true);
		win:Show();
		self.window = win;
		
		local btn1 = VFLUI.Button:new(win);
		btn1:SetHeight(25); btn1:SetWidth(60);
		btn1:SetPoint("BOTTOMRIGHT", win:GetClientArea(), "BOTTOMRIGHT");
		btn1:SetText(VFLI.i18n("Next") .. " >"); btn1:Show(); btn1:Disable();
		self.nextBtn = btn1;
	
		local btn2 = VFLUI.Button:new(win);
		btn2:SetHeight(25); btn2:SetWidth(60);
		btn2:SetPoint("RIGHT", self.nextBtn, "LEFT");
		btn2:SetText("< " .. VFLI.i18n("Prev")); btn2:Show(); btn2:Disable();
		btn2:SetScript("OnClick", function()
			if self.history then
				local cp = table.remove(self.history);
				if cp then
					cp = table.remove(self.history);
					if cp then
						self:SetPage(cp);
					end
				end
			end
		end);
		self.prevBtn = btn2;
	
		local btn3 = VFLUI.CancelButton:new(win);
		btn3:SetHeight(25); btn3:SetWidth(60);
		btn3:SetPoint("RIGHT", self.prevBtn, "LEFT");
		btn3:SetText(VFLI.i18n("Cancel")); btn3:Show(); btn3:Enable();
		btn3:SetScript("OnClick", function() self:Close(nil); end);
		self.cancelBtn = btn3;
	
		local btn4 = VFLUI.OKButton:new(win);
		btn4:SetHeight(25); btn4:SetWidth(60);
		btn4:SetPoint("RIGHT", self.cancelBtn, "LEFT");
		btn4:SetText(VFLI.i18n("OK")); btn4:Show(); btn4:Disable();
		self.OKBtn = btn4;
	
		win.Destroy = VFL.hook(function(s)
			self:ClearPage();
			self.nextBtn:Destroy(); self.nextBtn = nil;
			self.prevBtn:Destroy(); self.prevBtn = nil;
			self.cancelBtn:Destroy(); self.cancelBtn = nil;
			self.OKBtn:Destroy(); self.OKBtn = nil;
			self.window = nil; self.pageNum = nil;
		end, win.Destroy);
	
	end
	
	self.window:Show();
	
	if num then
		i = 1;
		while(true) do
			if i == num then break; end
			table.insert(self.history, i);
			i=i+1;
		end
	end
	
	self:SetPage(num or 1);
	return true;
end

--- Close the wizard.
function RDXUI.Wizard:Close(result)
	self.window:Destroy(); self.window = nil;
	if result then
		self:OnOK();
		self.desc._ok = true;
	else
		self:OnCancel();
	end
end

--- Set the page number for this wizard.
function RDXUI.Wizard:SetPage(num, name)
	-- Sanity check arguments
	if not num then
		-- try finding by name
		if name then
			num = self.index[name];
		end
		if not num then
			error(VFLI.i18n("expected number, got nil"));
		end
	end
	local pgdef = self.page[num]; if not pgdef then return; end

	-- Clean out the existing page.
	self:ClearPage();
	self.nextBtn:Disable(); self.nextBtn:SetScript("OnClick", nil);
	self.OKBtn:Disable(); self.OKBtn:SetScript("OnClick", nil);
	self.pageNum = nil;
	-- Return the window back to its ordinary settings
	self.window:SetBackdrop(VFLUI.BlackDialogBackdrop);
	self.window:SetBackdropColor(1,1,1,1); self.window:SetBackdropBorderColor(1,1,1,1);

	-- Attempt to open the new page.
	self.pageNum = num;
	local child = pgdef.OpenPage(self.window, self, self.desc[num]);
	if not child then
		-- If we're still on the same page, quash the page.
	--	if self.pageNum == num then self.pageNum = nil; end
	--	return; 
	end

	-- Add to history.
	table.insert(self.history, num);
	if(table.getn(self.history) > 1) and (not self.noPrev) then
		self.prevBtn:Enable();
	else
		self.prevBtn:Disable();
	end

	-- Setup child window.
	child:SetPoint("TOPLEFT", self.window:GetClientArea(), "TOPLEFT");
	local w = VFL.clamp(child:GetWidth(), 240, 2000);
	self.window:Accomodate(w, child:GetHeight() + 25);
	self.child = child; child:Show();
end

--- Try to save this page.
function RDXUI.Wizard:SavePage()
	local desc = nil;
	if(self.child) then
		if self.pageNum and self.child.GetDescriptor then
			local pgdef = self.page[self.pageNum];
			desc = self.child:GetDescriptor();
			vflErrors:Clear();
			if pgdef.Verify(desc, self, vflErrors) then
				self.desc[self.pageNum] = desc;
				return true, nil, desc;
			else
				return nil, vflErrors;
			end
		end
	end
	return true;
end

--- Clear and save whatever page is currently being displayed
function RDXUI.Wizard:ClearPage()
	if (self.child) then
		self.child:Destroy();
		self.child.GetDescriptor = nil;
		self.child = nil;
	end
end

--- Enable the "next page" button, invoking the given script if the save is
-- a success.
function RDXUI.Wizard:OnNext(fn)
	self.nextBtn:SetScript("OnClick", function()
		local flag, errs = self:SavePage();
		if flag then
			fn(self);
		else
			VFLUI.MessageBox(VFLI.i18n("Wizard Errors"), VFLI.i18n("Cannot proceed: ") .. vflErrors:FormatErrors_SingleLine());
		end
	end);
	self.nextBtn:Enable();
end

--- Make a WoW Button frame into a "next button" that invokes the given function.
function RDXUI.Wizard:MakeNextButton(btn, fn)
	btn:SetScript("OnClick", function()
		local flag, errs, descr = self:SavePage();
		if flag then
			fn(self, descr);
		else
			VFLUI.MessageBox(VFLI.i18n("Wizard Errors"), VFLI.i18n("Cannot proceed: ") .. vflErrors:FormatErrors_SingleLine());
		end
	end);
end

--- Enable the "OK" button.
function RDXUI.Wizard:Final(fn)
	fn = fn or VFL.Noop;
	self.OKBtn:SetScript("OnClick", function()
		local flag, errs, descr = self:SavePage();
		if flag then
			fn(self, descr);
			self:Close(true);
		else
			VFLUI.MessageBox(VFLI.i18n("Wizard Errors"), VFLI.i18n("Cannot proceed: ") .. vflErrors:FormatErrors_SingleLine());
		end
	end);
	self.OKBtn:Enable();
end

--- Disable the "Cancel" button
function RDXUI.Wizard:NoCancel()
	self.cancelBtn:Disable();
end

--- If there is a numerically-next page in this wizard, go to it; otherwise just exit.
-- The given function is called before the pageflip.
function RDXUI.Wizard:TurnPage(fn)
	fn = fn or VFL.Noop;
	local n, pgs = tonumber(self.pageNum), self.page;
	if not n then
		return; 
	end
	for i=(n+1),100 do
		local cl_i = i;
		if self.page[i] then 
			self:OnNext(function(s) fn(s); s:SetPage(cl_i); end); 
			return; 
		end
	end
	self:Final(fn);
end

----------- Descriptor management
function RDXUI.Wizard:GetDescriptor()
	return self.desc;
end
function RDXUI.Wizard:SetDescriptor(desc)
	if self.window then return; end
	if not desc then error(VFLI.i18n("expected descriptor, got nil")); end
	self.desc = desc;
end

function RDXUI.Wizard:GetPageDescriptor(num, name)
	if not num then
		-- try finding by name
		if name then
			num = self.index[name];
		end
		if not num then
			error(VFLI.i18n("expected number, got nil ") .. name);
		end
	end
	return self.desc[num];
end

------------ Page Registration
function RDXUI.Wizard:RegisterPage(n, name, tbl)
	if (not n) or (not tbl) then error(VFLI.i18n("usage: RegisterPage(pageNum, pageIndex, page)")); end
	self.page[n] = tbl;
	-- store a name reference to the page number
	if name then
		if not self.index[name] then
			self.index[name] = n;
		else
			error(VFLI.i18n("Same PageIndex ") .. name);
		end
	end
end


------------------------------- Test
function RDXUI.GenerateStdWizardPage(parent, title)
	local frame = VFLUI.AcquireFrame("Frame");
	frame:SetParent(parent);
	frame:SetWidth(250); frame:SetHeight(250);

	local txt = VFLUI.CreateFontString(frame);
	txt:SetPoint("TOPLEFT", frame, "TOPLEFT");
	txt:SetHeight(16); txt:SetWidth(250); txt:Show();
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 16));
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("Center");
	txt:SetText(title);

	frame.Destroy = VFL.hook(function(s)
		VFLUI.ReleaseRegion(txt); txt = nil;
	end, frame.Destroy);
	
	return frame;
end

---------------------------------------
-- Package Wizard
---------------------------------------
--RDXDB.wizardMenu = RDXPM.Menu:new();

--RDXDB.pkgname = "";

--RDXDB.wizardMenu:RegisterMenuFunction(function(ent)
--	ent.text = "Hello";
--	ent.OnClick = function()
--		VFL.poptree:Release();
--		VFL.print("test " .. RDXDB.pkgname);
--	end;
--end);

--RDXDB.RegisterPackageMenuHandler(function(mnu, pkg, dialog)
--	table.insert(mnu, {
--		text = VFLI.i18n("Wizard"), isSubmenu = true, OnClick = function(self) RDXDB.pkgname = pkg; RDXDB.wizardMenu:Open(nil, self, nil, nil, nil, VFL.poptree); end
--	});
--end);


