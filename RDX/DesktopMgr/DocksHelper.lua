-- OpenRDX
-- Sigg Rashgarroth EU /
--

------------------------------
-- dock helper
------------------------------
local dlg = nil;
local function OpenDockHelper()
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(230); dlg:SetHeight(125);
	dlg:SetText("Dock Options");
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
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "rdx_settings");
			dlg:Destroy(); dlg = nil;
		--end);
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

RDXDK.OpenDockHelper = OpenDockHelper;
