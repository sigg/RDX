------------------------------------------------------
-- Manager
------------------------------------------------------

local dlg = nil;
function RDXPM.RDXManage(parent)
	if dlg then return; end
	local opt =  RDXG.RDXopt;
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(330); dlg:SetHeight(300);
	dlg:SetText("Show/Hide Blizzard UI Element");
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("blizzard_desktop") then RDXPM.RestoreLayout(dlg, "blizzard_desktop"); end
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(305); sf:SetHeight(240);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	local chk_upp = VFLUI.Checkbox:new(ui); chk_upp:Show();
	chk_upp:SetText(VFLI.i18n("Use Perfect Pixel"));
	if opt and opt.upp then chk_upp:SetChecked(true); else chk_upp:SetChecked(); end
	ui:InsertFrame(chk_upp);
	
	local chk_dnp = VFLUI.Checkbox:new(ui); chk_dnp:Show();
	chk_dnp:SetText(VFLI.i18n("Disable RDX Nameplates"));
	if opt and opt.dnp then chk_dnp:SetChecked(true); else chk_dnp:SetChecked(); end
	ui:InsertFrame(chk_dnp);
	
	local chk_dgt = VFLUI.Checkbox:new(ui); chk_dgt:Show();
	chk_dgt:SetText(VFLI.i18n("Disable RDX Gametooltips"));
	if opt and opt.dgt then chk_dgt:SetChecked(true); else chk_dgt:SetChecked(); end
	ui:InsertFrame(chk_dgt);
	
	local chk_scc = VFLUI.Checkbox:new(ui); chk_scc:Show();
	chk_scc:SetText(VFLI.i18n("Store Compiled Code"));
	if opt and opt.scc then chk_scc:SetChecked(true); else chk_scc:SetChecked(); end
	ui:InsertFrame(chk_scc);
	
	local chk_pwm = VFLUI.Checkbox:new(ui); chk_pwm:Show();
	chk_pwm:SetText(VFLI.i18n("Party with me"));
	if opt and opt.pwm then chk_pwm:SetChecked(true); else chk_pwm:SetChecked(); end
	ui:InsertFrame(chk_pwm);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "blizzard_desktop");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local function Save()
		opt.upp = chk_upp:GetChecked();
		opt.dnp = chk_dnp:GetChecked();
		opt.dgt = chk_dgt:GetChecked();
		opt.scc = chk_scc:GetChecked();
		opt.pwm = chk_pwm:GetChecked();
		if opt.upp then
			SetCVar("uiScale", 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"));
		end
		ReloadUI();
		VFL.EscapeTo(esch);
	end
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end

function RDXPM.CloseRDXManage()
	dlg:_esch();
end

function RDXPM.ToggleRDXManage()
	if dlg then
		RDXPM.CloseRDXManage();
	else
		RDXPM.RDXManage(VFLDIALOG);
	end
end

function RDXPM.IsRDXManageOpen()
	if dlg then return true; else return nil; end
end