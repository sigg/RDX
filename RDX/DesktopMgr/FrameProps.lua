-- FrameProps.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
-- OpenRDX

-------------------------------------------------------
-- Props (properties) menu
--
-- The props are assembled by listing the basic WM properties
-- (undock, hide, close, etc) followed by any custom entries specified
-- by the window class's PropsMenu routine
-------------------------------------------------------
function RDXDK.FrameProperties(frame)
	-- Make sure this is a managed frame.
	-- Properties menus are not available during InCombatLockdown().
	-- or (not frame:IsVisible()) -- This is no longer needed, since we have overlay frames.
	local frameprops = RDXDK.GetCurrentDesktop():_GetFrameProps(frame._dk_name);
	if (not frame) or (not frameprops) or InCombatLockdown() then 
		return; 
	end
	local mnu = {};
	table.insert(mnu, { text = VFLI.i18n("Layout..."), OnClick = function() RDXDK.LayoutPropsDialog(frameprops); VFL.poptree:Release(); end });
	--table.insert(mnu, { text = VFLI.i18n("Drag to move"), 
	--	OnMouseDown = function() frame:WMDrag(); end, 
	--	OnMouseUp = function() VFL.poptree:Release(); frame:WMStopDrag(); end 
	--});
	
	if frameprops.feature == "desktop_window" or frameprops.feature == "desktop_statuswindow" then
		table.insert(mnu, {
			text = VFLI.i18n("Edit Window"),
			OnClick = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(frameprops.name, "Edit", VFLDIALOG);
			end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Rebuild"),
			OnClick = function()
				VFL.poptree:Release();
				RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, frameprops.name);
			end
		});
	end
	
	local feat = RDXDB.GetFeatureData(frameprops.name, "Design");
	local upath = feat["design"];
	table.insert(mnu, {text = VFLI.i18n("Clone..."), OnClick = function() 
		VFL.poptree:Release();
		RDX.CloneWindow(frameprops.name, upath, VFLDIALOG); 
		end;
	});
	
	if RDXDK.IsDocked(frameprops) then
		if not RDXDK.IsDGP(frameprops) then
			local rootfrp = RDXDK.Findroot(frameprops);
			if not rootfrp then
				table.insert(mnu, {text = VFLI.i18n("Make Dock Parent"), OnClick = function()
					DesktopEvents:Dispatch("WINDOW_PARENTDOCK", frameprops);
					VFL.poptree:Release();
				end });
			end
		end
	end
	
	-- Allow downstream menu hooks for class-less windows.
	if type(frame._WindowMenu) == "function" then
		frame:_WindowMenu(mnu, frameprops.name, frame);
	end
	
	--table.insert(mnu, { text = VFLI.i18n("Close"), OnClick = function() 
	--	VFL.poptree:Release();
	--	RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, frame._dk_name);
	--end });
	
	VFL.poptree:Begin(150, 12, frame, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(frame));
	VFL.poptree:Expand(nil, mnu);
end

local function _MakeNudgeButton(parent, texture, dgpprops, dx, dy)
	local btn = VFLUI.Button:new(parent);
	btn:SetWidth(24); btn:SetHeight(24); btn:Show();
	local tex = VFLUI.CreateTexture(btn);
	tex:SetPoint("TOPLEFT", btn, "TOPLEFT", 6, -6);
	tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -6, 6);
	tex:SetDrawLayer("OVERLAY"); tex:SetTexture(texture); tex:Show();
	btn.Destroy = VFL.hook(function() VFLUI.ReleaseRegion(tex); end, btn.Destroy);

	btn:SetScript("OnClick", function()
		local dgpframe = RDXDK.GetFrame(dgpprops.name);
		if not dgpprops.l then RDXDK.SavePosition(dgpframe, dgpprops, true); end
		if not dgpprops.l then return; end
		
		dgpprops.l = dgpprops.l + dx; dgpprops.r = dgpprops.r + dx;
		dgpprops.t = dgpprops.t + dy; dgpprops.b = dgpprops.b + dy;
		RDXDK.SavePosition(dgpframe, dgpprops, true);
		RDXDK.ResetDockGroupLayout(dgpframe); 
		RDXDK.LayoutDockGroup(dgpframe);
	end);
	return btn;
end

local dlg = nil;
function RDXDK.LayoutPropsDialog(frameprops)
	if dlg then return; end
	local dd, dgp = frameprops, (RDXDK.FindDockGroupParent(frameprops) or frameprops);

	local x = nil;
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 20);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(250); dlg:SetHeight(300); 
	dlg:SetTitleColor(0,0,.6);
	dlg:SetText(VFLI.i18n("Layout Properties: ") .. dd.name);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("frame_props") then RDXPM.RestoreLayout(dlg, "frame_props"); end
	
	
	local ca = dlg:GetClientArea();
	local lblScale = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Scale"));
	lblScale:SetPoint("TOPLEFT", ca, "TOPLEFT"); lblScale:SetHeight(25);
	local edScale = VFLUI.Edit:new(dlg, true); edScale:SetHeight(25); edScale:SetWidth(50);
	edScale:SetPoint("TOPRIGHT", ca, "TOPRIGHT", 0, 0); edScale:Show();
	local slScale = VFLUI.HScrollBar:new(dlg);
	slScale:SetPoint("RIGHT", edScale, "LEFT", -16, 0); slScale:SetWidth(100);
	slScale:Show();
	slScale:SetMinMaxValues(.1, 3.0); slScale:SetValue(dd.scale);
	VFLUI.BindSliderToEdit(slScale, edScale);


	local lblAlpha = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Alpha"));
	lblAlpha:SetPoint("TOPLEFT", lblScale, "BOTTOMLEFT"); lblAlpha:SetHeight(25);
	local edAlpha = VFLUI.Edit:new(dlg, true); edAlpha:SetHeight(25); edAlpha:SetWidth(50);
	edAlpha:SetPoint("TOPRIGHT", edScale, "BOTTOMRIGHT", 0, 0); edAlpha:Show();
	local slAlpha = VFLUI.HScrollBar:new(dlg);
	slAlpha:SetPoint("RIGHT", edAlpha, "LEFT", -16, 0); slAlpha:SetWidth(100);
	slAlpha:Show();
	slAlpha:SetMinMaxValues(0, 1); slAlpha:SetValue(dd.alpha);
	VFLUI.BindSliderToEdit(slAlpha, edAlpha);

	local lblStrata = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Stratum"));
	lblStrata:SetPoint("TOPLEFT", lblAlpha, "BOTTOMLEFT"); lblStrata:SetHeight(25);
	local ddStrata = VFLUI.Dropdown:new(dlg, RDXUI.DesktopStrataFunction);
	ddStrata:SetPoint("TOPRIGHT", edAlpha, "BOTTOMRIGHT", 0, 0); ddStrata:SetWidth(132);
	ddStrata:SetSelection(dd.strata);
	ddStrata:Show();

	local lblAP = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Anchor point"));
	lblAP:SetPoint("TOPLEFT", lblStrata, "BOTTOMLEFT"); lblAP:SetHeight(25);
	local ddAP = VFLUI.Dropdown:new(dlg, RDXUI.DesktopAnchorFunction);
	ddAP:SetPoint("TOPRIGHT", ddStrata, "BOTTOMRIGHT", 0, 0); ddAP:SetWidth(132);
	ddAP:SetSelection(dd.ap or "TOPLEFT");
	ddAP:Show();

	--local chkCTS = VFLUI.Checkbox:new(dlg); chkCTS:Show();
	--chkCTS:SetHeight(20); chkCTS:SetWidth(200);
	--chkCTS:SetPoint("TOPLEFT", lblAP, "BOTTOMLEFT");
	--chkCTS:SetText(VFLI.i18n("Clamp to screen (only if undocked)"));
	--chkCTS:SetChecked(dd.cts);

	--local chkNoAttach = VFLUI.Checkbox:new(dlg); chkNoAttach:Show();
	--chkNoAttach:SetHeight(20); chkNoAttach:SetWidth(250);
	--chkNoAttach:SetPoint("TOPLEFT", chkCTS, "BOTTOMLEFT");
	--chkNoAttach:SetText(VFLI.i18n("Prevent this window from attaching to others"));
	--chkNoAttach:SetChecked(dd.noattach);

	--local chkNoHold = VFLUI.Checkbox:new(dlg); chkNoHold:Show();
	--chkNoHold:SetHeight(20); chkNoHold:SetWidth(250);
	--chkNoHold:SetPoint("TOPLEFT", chkNoAttach, "BOTTOMLEFT");
	--chkNoHold:SetText(VFLI.i18n("Prevent other windows from attaching to this one"));
	--chkNoHold:SetChecked(dd.nohold);

	--local lblNudge = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Nudge"));
	--lblNudge:SetPoint("TOPLEFT", chkNoHold, "BOTTOMLEFT", 0, -25);
	--local nudgeLeft = _MakeNudgeButton(dlg, "Interface\\Addons\\VFL\\Skin\\sb_left", dgp, -1, 0);
	--nudgeLeft:SetPoint("LEFT", lblNudge, "RIGHT");
	--local nudgeUp = _MakeNudgeButton(dlg, "Interface\\Addons\\VFL\\Skin\\sb_up", dgp, 0, 1);
	--nudgeUp:SetPoint("BOTTOMLEFT", nudgeLeft, "RIGHT");
	--local nudgeDown = _MakeNudgeButton(dlg, "Interface\\Addons\\VFL\\Skin\\sb_down", dgp, 0, -1);
	--nudgeDown:SetPoint("TOPLEFT", nudgeLeft, "RIGHT");
	--local nudgeRight = _MakeNudgeButton(dlg, "Interface\\Addons\\VFL\\Skin\\sb_right", dgp, 1, 0);
	--nudgeRight:SetPoint("LEFT", nudgeDown, "TOPRIGHT");

	local txtCurDock = VFLUI.CreateFontString(dlg);
	txtCurDock:SetPoint("TOPLEFT", lblAP, "BOTTOMLEFT");
	txtCurDock:SetWidth(180); txtCurDock:SetHeight(60);
	txtCurDock:SetJustifyV("TOP");
	txtCurDock:SetJustifyH("LEFT");
	txtCurDock:SetFontObject(Fonts.Default10); txtCurDock:Show();
	local str = VFLI.i18n("Docks:\n");
	if dd.dock then
		for k,v in pairs(dd.dock) do
			str = str .. k .. ": " .. v.id .. "\n";
		end
	else
		str = str .. "(none)";
	end
	txtCurDock:SetText(str);
	
	--dlg:Show(.2, true);
	dlg:Show();
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "frame_props");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);

	----------- ok/cancel
	local btnCancel = VFLUI.CancelButton:new(dlg);
	btnCancel:SetHeight(25); btnCancel:SetWidth(75); btnCancel:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnCancel:SetText(VFLI.i18n("Cancel")); btnCancel:Show();
	btnCancel:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(75); btnOK:SetPoint("RIGHT", btnCancel, "LEFT");
	btnOK:SetText(VFLI.i18n("OK")); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		DesktopEvents:Dispatch("WINDOW_UPDATE", dd.name, "SCALE", slScale:GetValue());
		DesktopEvents:Dispatch("WINDOW_UPDATE", dd.name, "ALPHA", slAlpha:GetValue());
		DesktopEvents:Dispatch("WINDOW_UPDATE", dd.name, "STRATA", ddStrata:GetSelection());
		--DesktopEvents:Dispatch("WINDOW_UPDATE", dd.name, "CTS", chkCTS:GetChecked());
		--dd.scale = slScale:GetValue();
		--dd.alpha = slAlpha:GetValue();
		--dd.strata = ddStrata:GetSelection();
		if ddAP:GetSelection() == "Auto" then dd.ap = nil; else dd.ap = ddAP:GetSelection(); end
		--dd.cts = chkCTS:GetChecked();
		--dd.noattach = chkNoAttach:GetChecked();
		--dd.nohold = chkNoHold:GetChecked();
		VFL.EscapeTo(esch);
	end);

	dlg.Destroy = VFL.hook(function(s)
		btnCancel:Destroy(); btnCancel = nil;
		btnOK:Destroy(); btnOK = nil;
		slScale:Destroy(); slScale = nil; edScale:Destroy(); edScale = nil;
		slAlpha:Destroy(); slAlpha = nil; edAlpha:Destroy(); edAlpha = nil;
		ddStrata:Destroy(); ddStrata = nil;ddAP:Destroy(); ddAP = nil;
		--chkCTS:Destroy(); chkCTS = nil; chkNoAttach:Destroy(); chkNoAttach = nil;
		--chkNoHold:Destroy(); chkNoHold = nil;
		--nudgeLeft:Destroy(); nudgeLeft = nil; nudgeRight:Destroy(); nudgeRight = nil;
		--nudgeUp:Destroy(); nudgeUp = nil; nudgeDown:Destroy(); nudgeDown = nil;
		VFLUI.ReleaseRegion(txtCurDock); txtCurDock = nil;
	end, dlg.Destroy);
end

