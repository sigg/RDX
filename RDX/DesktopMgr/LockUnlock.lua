-- OpenRDX
-- Sigg Rashgarroth EU /
-- Cidan
--
-- Lock / Unlock Desktop

-- Drag context
local DockingDragContext = VFLUI.DragContext:new();

------------------------------
-- dock dialog
------------------------------
local dlg = nil;
local function OpenDockDialog(frameprops, point)
	if dlg then return; end
	local x, y = RDXDK.GetDockOffset(frameprops, point);
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(230); dlg:SetHeight(125);
	dlg:SetText("Dock Options");
	
	if RDXPM.Ismanaged("lockunlock") then RDXPM.RestoreLayout(dlg, "lockunlock"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(200); sf:SetHeight(70);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	local ed_x = VFLUI.LabeledEdit:new(ui, 100); ed_x:Show();
	ed_x:SetText(VFLI.i18n("Offset x"));
	if x then ed_x.editBox:SetText(x); else ed_x.editBox:SetText("0"); end
	ui:InsertFrame(ed_x);
	
	local ed_y = VFLUI.LabeledEdit:new(ui, 100); ed_y:Show();
	ed_y:SetText(VFLI.i18n("Offset y"));
	if y then ed_y.editBox:SetText(y); else ed_y.editBox:SetText("0"); end
	ui:InsertFrame(ed_y);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "lockunlock");
			dlg:Destroy(); dlg = nil;
		end);
	end
	
	VFL.AddEscapeHandler(esch);
	function dlg:_esch() VFL.EscapeTo(esch); end
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT", -15, 0);
	btnOK:SetText("OK"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local newx = ed_x.editBox:GetNumber();
		if not newx then newx = 0 ; end
		local newy = ed_y.editBox:GetNumber();
		if not newy then newy = 0 ; end
		DesktopEvents:Dispatch("WINDOW_DOCKOFFSET", frameprops, point, newx, newy);
		VFL.EscapeTo(esch);
	end);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end

local function DockingDragStart(btn)
	local proxy = VFLUI.CreateGenericDragProxy(btn, "", btn.data);
	proxy.point = btn.point;
	DockingDragContext:Drag(btn, proxy);
end

local function DockingDropOn(target, proxy, source, context)
	if target == source then
		RDX.NewLearnWizardName("docking_windows");
	else
		local offset = nil;
		if IsShiftKeyDown() then
			offset = true;
		end
		DesktopEvents:Dispatch("WINDOW_DOCK", proxy.data, proxy.point, target.data, target.point, offset);
	end
end

VFLUI.CreateFramePool("ButtonLayout",
function(pool, x) -- onrelease
	x.OnDrop = nil; DockingDragContext:UnregisterDragTarget(x);
	VFLUI._CleanupButton(x);
end, 
function() -- onfallback
	local f = CreateFrame("Button");
	VFLUI._FixFontObjectNonsense(f);
	return f;
end,
function(_, f) -- onacquire
	f:SetHeight(10); f:SetWidth(10);
	f:SetBackdrop(VFLUI.BlueDialogBackdrop);
	f:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	f.OnDrop = DockingDropOn;
	DockingDragContext:RegisterDragTarget(f);
	f:SetScript("OnClick", function(self, arg1)
		if(arg1 == "LeftButton") then
			if RDXDK.IsDockedPoint(self.data, self.point) then
				OpenDockDialog(self.data, self.point);
			else
				DockingDragStart(self);
			end
		elseif(arg1 == "RightButton") then
			DesktopEvents:Dispatch("WINDOW_UNDOCK", self.data, self.point);
		end
	end);
	f:SetScript("OnEnter", function(self)
		if RDXDK.IsDockedPoint(self.data, self.point) then
			self:SetBackdrop(VFLUI.YellowDialogBackdrop);
			local di = RDXDK.GetDockPoints(self.data);
			local ri = di[self.point];
			DesktopEvents:Dispatch("WINDOW_UPDATE", ri.id, "OVERLAY", ri.point, VFLUI.YellowDialogBackdrop);
		end
	end);
	f:SetScript("OnLeave", function(self)
		if RDXDK.IsDockedPoint(self.data, self.point) then
			DesktopEvents:Dispatch("WINDOW_UPDATE_ALL", "OVERLAY");
		end
	end);
end);

local se = nil;

function RDXDK.AddUnlockOverlay(frame, frameprops)
	-- create the blue window
	local tf, tfIdent;
	if not frameprops.root then
		tf = VFLUI.AcquireFrame("Button");
		tf:SetParent(RDXParent);
		--tf:SetFrameStrata(VFLUI.GetRelativeStata(frame:GetFrameStrata(), 1));
		tf:SetFrameStrata(frame:GetFrameStrata());
		tf:SetFrameLevel(100);
		tf:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		tf:Show();
	
		-- Now for the font
		tfIdent = VFLUI.CreateFontString(tf);
		tfIdent:SetJustifyV("CENTER");
		tfIdent:SetJustifyH("CENTER");
		tfIdent:SetFontObject(Fonts.Default10Shadowed);
		tfIdent:Show();
	else
		tf = VFLUI.AcquireFrame("Frame");
		tf:SetParent(RDXParent);
		tf:SetAllPoints(RDXParent);
		tf:Show();
	end
	frame.tf = tf;
	frame.tfIdent = tfIdent;
	
	------------------------------------------
	
	local tfl = VFLUI.AcquireFrame("ButtonLayout");
	tfl:SetParent(tf);
	tfl:SetPoint("LEFT", tf, "LEFT");
	tfl:SetFrameLevel(tf:GetFrameLevel()+1);
	tfl.point = "LEFT";
	tfl.data = frameprops;
	tfl:Show();
	frame.tfl = tfl;
	
	--
	
	local tftl = VFLUI.AcquireFrame("ButtonLayout");
	tftl:SetParent(tf);
	tftl:SetPoint("TOPLEFT", tf, "TOPLEFT");
	tftl:SetFrameLevel(tf:GetFrameLevel()+1);
	tftl.point = "TOPLEFT";
	tftl.data = frameprops;
	tftl:Show();
	frame.tftl = tftl;
	
	---------------------------------------------
	
	local tft = VFLUI.AcquireFrame("ButtonLayout");
	tft:SetParent(tf);
	tft:SetPoint("TOP", tf, "TOP");
	tft:SetFrameLevel(tf:GetFrameLevel()+1);
	tft.point = "TOP";
	tft.data = frameprops;
	tft:Show();
	frame.tft = tft;
	
	-------
	
	local tftr = VFLUI.AcquireFrame("ButtonLayout");
	tftr:SetParent(tf);
	tftr:SetPoint("TOPRIGHT", tf, "TOPRIGHT");
	tftr:SetFrameLevel(tf:GetFrameLevel()+1);
	tftr.point = "TOPRIGHT";
	tftr.data = frameprops;
	tftr:Show();
	frame.tftr = tftr;
	
	------------------
	
	local tfr = VFLUI.AcquireFrame("ButtonLayout");
	tfr:SetParent(tf);
	tfr:SetPoint("RIGHT", tf, "RIGHT");
	tfr:SetFrameLevel(tf:GetFrameLevel()+1);
	tfr.point = "RIGHT";
	tfr.data = frameprops;
	tfr:Show();
	frame.tfr = tfr;
	
	------------------
	
	local tfbr = VFLUI.AcquireFrame("ButtonLayout");
	tfbr:SetParent(tf);
	tfbr:SetPoint("BOTTOMRIGHT", tf, "BOTTOMRIGHT");
	tfbr:SetFrameLevel(tf:GetFrameLevel()+1);
	tfbr.point = "BOTTOMRIGHT";
	tfbr.data = frameprops;
	tfbr:Show();
	frame.tfbr = tfbr;
	
	-------------------------------------------------
	
	local tfb = VFLUI.AcquireFrame("ButtonLayout");
	tfb:SetParent(tf);
	tfb:SetPoint("BOTTOM", tf, "BOTTOM");
	tfb:SetFrameLevel(tf:GetFrameLevel()+1);
	tfb.point = "BOTTOM";
	tfb.data = frameprops;
	tfb:Show();
	frame.tfb = tfb;
	
	-------------------------------------------------
	
	local tfbl = VFLUI.AcquireFrame("ButtonLayout");
	tfbl:SetParent(tf);
	tfbl:SetPoint("BOTTOMLEFT", tf, "BOTTOMLEFT");
	tfbl:SetFrameLevel(tf:GetFrameLevel()+1);
	tfbl.point = "BOTTOMLEFT";
	tfbl.data = frameprops;
	tfbl:Show();
	frame.tfbl = tfbl;
	
	--------------------------
	
	local tfc = VFLUI.AcquireFrame("ButtonLayout");
	tfc:SetParent(tf);
	tfc:SetPoint("CENTER", tf, "CENTER");
	tfc:SetFrameLevel(tf:GetFrameLevel()+1);
	tfc.point = "CENTER";
	tfc.data = frameprops;
	tfc:Show();
	frame.tfc = tfc;
	
	--------------------------
	
	if frameprops.root then
		frame.tfl:Hide();
		frame.tftl:Hide();
		frame.tft:Hide();
		frame.tftr:Hide();
		frame.tfr:Hide();
		frame.tfbr:Hide();
		frame.tfb:Hide();
		frame.tfbl:Hide();
		frame.tfc:Hide();
	end
	
	function frame:Unlock(frameprops)
		if frame.tfIdent then
			local h, w = 0, 0;
			if frame:GetHeight() < 10 then h = 10; end
			if frame:GetWidth() < 10 then w = 10; end
			frame.tf:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
			frame.tf:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", w, -h);
			
			RDXDK.StdMove(frame, frame.tf, function() RDXDK.SetFramew_window(frameprops); DesktopEvents:Dispatch("WINDOW_UPDATE_ALL", "OVERLAY", frameprops); end);
			
			frame.tfIdent:SetPoint("CENTER", frame.tf, "CENTER", 0, 10);
			frame.tfIdent:SetWidth(frame.tf:GetWidth()+200); 
			frame.tfIdent:SetHeight(frame.tf:GetHeight()-5);
			frame.tfIdent:SetText(frame._path);
			
			frame.tf:Show();
		end
		frame.tfl.data = frameprops; frame.tfl:Show();
		frame.tftl.data = frameprops; frame.tftl:Show();
		frame.tft.data = frameprops; frame.tft:Show();
		frame.tftr.data = frameprops; frame.tftr:Show();
		frame.tfr.data = frameprops; frame.tfr:Show();
		frame.tfbr.data = frameprops; frame.tfbr:Show();
		frame.tfb.data = frameprops; frame.tfb:Show();
		frame.tfbl.data = frameprops; frame.tfbl:Show();
		frame.tfc.data = frameprops; frame.tfc:Show();
		frame:UpdateUnlockOverlay(frameprops);
	end
	
	function frame:Lock(frameprops)
		if frame.tfIdent then
			frame.tf:SetScript("OnMouseDown", nil);
			frame.tf:SetScript("OnMouseUp", nil);
			frame.tf:Hide();
		end
		frame.tfl.data = nil; frame.tfl:Hide();
		frame.tftl.data = nil; frame.tftl:Hide();
		frame.tft.data = nil; frame.tft:Hide();
		frame.tftr.data = nil; frame.tftr:Hide();
		frame.tfr.data = nil; frame.tfr:Hide();
		frame.tfbr.data = nil; frame.tfbr:Hide();
		frame.tfb.data = nil; frame.tfb:Hide();
		frame.tfbl.data = nil; frame.tfbl:Hide();
		frame.tfc.data = nil; frame.tfc:Hide();
		se = nil;
	end
	
	function frame:UpdateUnlockOverlay(frameprops, select)
		if select then se = select; end
		if not select and se then select = se; end
		if RDXDK.IsDockedPoint(frameprops, "LEFT") then
			frame.tfl:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tfl:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "TOPLEFT") then
			frame.tftl:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tftl:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "TOP") then
			frame.tft:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tft:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "TOPRIGHT") then
			frame.tftr:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tftr:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "RIGHT") then
			frame.tfr:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tfr:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "BOTTOMRIGHT") then
			frame.tfbr:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tfbr:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "BOTTOM") then
			frame.tfb:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tfb:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "BOTTOMLEFT") then
			frame.tfbl:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tfbl:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if RDXDK.IsDockedPoint(frameprops, "CENTER") then
			frame.tfc:SetBackdrop(VFLUI.RedDialogBackdrop);
		else
			frame.tfc:SetBackdrop(VFLUI.BlueDialogBackdrop);
		end
		if not frameprops.root then
			if frameprops.dgp then
				--frame.tf:SetBackdrop(VFLUI.MagentaDialogBackdrop);
				if frameprops == select then
					frame.tf:SetBackdrop(VFLUI.DefaultDialogBorder);
				else
					frame.tf:SetBackdrop(VFLUI.MagentaDialogBackdrop);
				end
			else
				if frameprops == select then
					frame.tf:SetBackdrop(VFLUI.DefaultDialogBorder);
				else
					frame.tf:SetBackdrop(VFLUI.BlueDialogBackdrop);
				end
				
			end
			frame.tf:SetFrameStrata(VFLUI.GetRelativeStata(frame:GetFrameStrata(), 1));
		end
		--RDXDK.UpdateDesktopTools(frameprops);
	end
end

function RDXDK.RemoveUnlockOverlay(frame)
	frame.tfc.point = nil; frame.tfc.data = nil; frame.tfc:Destroy(); frame.tfc = nil;
	frame.tfbl.point = nil; frame.tfbl.data = nil; frame.tfbl:Destroy(); frame.tfbl = nil;
	frame.tfb.point = nil; frame.tfb.data = nil; frame.tfb:Destroy(); frame.tfb = nil;
	frame.tfbr.point = nil; frame.tfbr.data = nil; frame.tfbr:Destroy(); frame.tfbr = nil;
	frame.tfr.point = nil; frame.tfr.data = nil; frame.tfr:Destroy(); frame.tfr = nil;
	frame.tftr.point = nil; frame.tftr.data = nil; frame.tftr:Destroy(); frame.tftr = nil;
	frame.tft.point = nil; frame.tft.data = nil; frame.tft:Destroy(); frame.tft = nil;
	frame.tftl.point = nil; frame.tftl.data = nil; frame.tftl:Destroy(); frame.tftl = nil;
	frame.tfl.point = nil; frame.tfl.data = nil; frame.tfl:Destroy(); frame.tfl = nil;
	if frame.tfIdent then
		VFLUI.ReleaseRegion(frame.tfIdent); frame.tfIdent = nil;
	end
	frame.tf:Destroy(); frame.tf = nil;
	frame.Lock = nil; frame.Unlock = nil; frame.UpdateUnlockOverlay = nil;
end

function RDXDK.UpdateUnlockOverlay()
	if not InCombatLockdown() then 
		local currentDesktop = RDXDK.GetCurrentDesktop()
		if currentDesktop then currentDesktop:UpdateUnlockOverlay(); end
	end
end

-- deprecated
--function RDXDK.IsDesktopLocked()
--	local a = RDXDK.GetCurrentDesktop();
--	if a then return a:_IsLocked(); else VFL.print("error desktop not instanced"); end
--end

--function RDXDK.UnlockDesktop()
--	if not InCombatLockdown() then 
--		DesktopEvents:Dispatch("DESKTOP_UNLOCK");
--		RDX.printI(VFLI.i18n("Unlocking desktop."));
--	else
--		RDX.printI(VFLI.i18n("Cannot change unlock state while in combat."));
--	end
--end

--function RDXDK.LockDesktop()
--	DesktopEvents:Dispatch("DESKTOP_LOCK");
--	RDX.printI(VFLI.i18n("Locking desktop."));
--end

--function RDXDK.ToggleDesktopLock()
--	if RDXDK.IsDesktopLocked() then
--		RDXDK.UnlockDesktop();
--	else 
--		RDXDK.LockDesktop();
--	end
--end

-- lock desktop if in combat
--VFLEvents:Bind("PLAYER_COMBAT", nil, function()
--	if InCombatLockdown() and not RDXDK.IsDesktopLocked() then
--		RDXDK.LockDesktop();
--	end
--end);

