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
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Main panel")));
	
	local chk_asmp = VFLUI.Checkbox:new(ui); chk_asmp:Show();
	chk_asmp:SetText(VFLI.i18n("Always Show Main Panel"));
	if opt and opt.asmp then chk_asmp:SetChecked(true); else chk_asmp:SetChecked(); end
	ui:InsertFrame(chk_asmp);
	
	--local chk_hmp = VFLUI.Checkbox:new(ui); chk_hmp:Show();
	--chk_hmp:SetText(VFLI.i18n("Always Hide Main Panel"));
	--if opt and opt.hmp then chk_hmp:SetChecked(true); else chk_hmp:SetChecked(); end
	--ui:InsertFrame(chk_hmp);
	
	
	local chk_upp = VFLUI.Checkbox:new(ui); chk_upp:Show();
	chk_upp:SetText(VFLI.i18n("Use Perfect Pixel"));
	if opt and opt.upp then chk_upp:SetChecked(true); else chk_upp:SetChecked(); end
	ui:InsertFrame(chk_upp);
	
	local er = VFLUI.EmbedRight(ui, VFLI.i18n("Main Menu Skin"));
	local dd_mmskin = VFLUI.Dropdown:new(er, RDX.GetMainMenuSkins);
	dd_mmskin:SetWidth(100); dd_mmskin:Show();
	dd_mmskin:SetSelection(opt.mmskin or "Crystal");
	er:EmbedChild(dd_mmskin); er:Show(); ui:InsertFrame(er);
	
	--local chk_dgr = VFLUI.Checkbox:new(ui); chk_dgr:Show();
	--chk_dgr:SetText(VFLI.i18n("Enable GameTooltip in RDX (ReloadUI need)"));
	--if opt and opt.dgr then chk_dgr:SetChecked(true); else chk_dgr:SetChecked(); end
	--ui:InsertFrame(chk_dgr);
	
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
		opt.asmp = chk_asmp:GetChecked();
		--opt.hmp = chk_hmp:GetChecked();
		opt.upp = chk_upp:GetChecked();
		--opt.dgr = chk_dgr:GetChecked();
		local mainPane = RDXPM.GetMainPane();
		if mainPane then
			mainPane:SetAllwaysShow(opt.asmp);
		end
		if opt.upp then
			SetCVar("uiScale", 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"));
		end
		opt.mmskin = dd_mmskin:GetSelection();
		mainPane:SetSkin(opt.mmskin);
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