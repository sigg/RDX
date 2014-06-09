------------------------------------------------------
-- Manager
------------------------------------------------------

local dlg = nil;
function RDX.MapManage(parent)
	if dlg then return; end
	local opt =  RDXG.MAPopt;
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(330); dlg:SetHeight(300);
	dlg:SetText("Map Settings");
	dlg:SetClampedToScreen(true);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("Map Settings") then RDXPM.RestoreLayout(dlg, "Map Settings"); end
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(305); sf:SetHeight(240);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	local chk_upp = VFLUI.Checkbox:new(ui); chk_upp:Show();
	chk_upp:SetText(VFLI.i18n("Use Perfect Pixel (UI Scale will be set)"));
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
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Global Viewport")));
	
	local offsettop = VFLUI.LabeledEdit:new(ui, 200); offsettop:Show();
	offsettop:SetText(VFLI.i18n("Viewport Top"));
	if opt and opt.offsettop then offsettop.editBox:SetText(opt.offsettop); else offsettop.editBox:SetText("0"); end
	ui:InsertFrame(offsettop);
	
	local offsetleft = VFLUI.LabeledEdit:new(ui, 200); offsetleft:Show();
	offsetleft:SetText(VFLI.i18n("Viewport Left"));
	if opt and opt.offsetleft then offsetleft.editBox:SetText(opt.offsetleft); else offsetleft.editBox:SetText("0"); end
	ui:InsertFrame(offsetleft);
	
	local offsetbottom = VFLUI.LabeledEdit:new(ui, 200); offsetbottom:Show();
	offsetbottom:SetText(VFLI.i18n("Viewport Bottom"));
	if opt and opt.offsetbottom then offsetbottom.editBox:SetText(opt.offsetbottom); else offsetbottom.editBox:SetText("0"); end
	ui:InsertFrame(offsetbottom);
	
	local offsetright = VFLUI.LabeledEdit:new(ui, 200); offsetright:Show();
	offsetright:SetText(VFLI.i18n("Viewport Right"));
	if opt and opt.offsetright then offsetright.editBox:SetText(opt.offsetright); else offsetright.editBox:SetText("0"); end
	ui:InsertFrame(offsetright);

	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Enable Blizzard")));
	
	local chk_ec = VFLUI.Checkbox:new(ui); chk_ec:Show();
	chk_ec:SetText(VFLI.i18n("Enable Blizzard Chatframe/CombatLogs"));
	if opt and opt.ec then chk_ec:SetChecked(true); else chk_ec:SetChecked(); end
	ui:InsertFrame(chk_ec);
	
	local chk_ea = VFLUI.Checkbox:new(ui); chk_ea:Show();
	chk_ea:SetText(VFLI.i18n("Enable Blizzard ActionBars"));
	if opt and opt.ea then chk_ea:SetChecked(true); else chk_ea:SetChecked(); end
	ui:InsertFrame(chk_ea);
	
	local chk_eb = VFLUI.Checkbox:new(ui); chk_eb:Show();
	chk_eb:SetText(VFLI.i18n("Enable Blizzard Minimap"));
	if opt and opt.eb then chk_eb:SetChecked(true); else chk_eb:SetChecked(); end
	ui:InsertFrame(chk_eb);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "Map Settings");
			dlg:Destroy(); dlg = nil;
		end);
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
		opt.ec = chk_ec:GetChecked();
		opt.ea = chk_ea:GetChecked();
		opt.eb = chk_eb:GetChecked();
		if opt.upp then
			SetCVar("uiScale", 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"));
		end
		opt.offsettop = VFL.clamp(offsettop.editBox:GetNumber(), 0, 200);
		opt.offsetleft = VFL.clamp(offsetleft.editBox:GetNumber(), 0, 200);
		opt.offsetbottom = VFL.clamp(offsetbottom.editBox:GetNumber(), 0, 200);
		opt.offsetright = VFL.clamp(offsetright.editBox:GetNumber(), 0, 200);
		
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

function RDX.CloseMapManage()
	dlg:_esch();
end

function RDX.ToggleMapManage()
	if dlg then
		RDX.CloseMapManage();
	else
		RDX.MapManage(VFLDIALOG);
	end
end

function RDXPM.IsMapManageOpen()
	if dlg then return true; else return nil; end
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	if not RDXG.MAPopt then RDXG.MAPopt = {}; end
end);