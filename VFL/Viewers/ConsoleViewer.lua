-- ConsoleViewer.lua
--

local dlg = nil;

function VFL.OpenConsoleDialog()
	if dlg then return; end
	
	dlg = VFLUI.Window:new(VFLFULLSCREEN_DIALOG);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(.6,0,0);
	dlg:SetText("Console");
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetHeight(400); dlg:SetWidth(400);
	dlg:SetClampedToScreen(true);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	local ca = dlg:GetClientArea();

	---------------- Console
	--VFLIO.Console:SetAllPoints(ca);
	VFLIO.Console:SetPoint("TOPLEFT", ca, "TOPLEFT");
	VFLIO.Console:SetWidth(400); VFLIO.Console:SetHeight(330);
	VFLIO.Console:SetParent(ca);
	VFLIO.Console:Show();

	dlg:_Show(.2);

	-------------------- Interactions
	
	local esch = function()
		dlg:_Hide(.2, nil, function()
			dlg:Destroy(); dlg = nil;
		end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local btnCancel = VFLUI.CancelButton:new(dlg);
	btnCancel:SetHeight(25); btnCancel:SetWidth(60);
	btnCancel:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnCancel:SetText("Close"); btnCancel:Show();
	btnCancel:SetScript("OnClick", function()
		VFL.EscapeTo(esch);
	end);

	local btnNone = VFLUI.Button:new(dlg);
	btnNone:SetHeight(25); btnNone:SetWidth(60);
	btnNone:SetPoint("RIGHT", btnCancel, "LEFT");
	btnNone:SetText("Clear"); btnNone:Show();
	btnNone:SetScript("OnClick", function() VFLIO.Console:Clear();  end);

	dlg.Destroy = VFL.hook(function(s)
		VFLIO.Console:ClearAllPoints();
		VFLIO.Console:SetParent(VFLParent);
		VFLIO.Console:Hide();
		btnCancel:Destroy(); btnNone:Destroy();
		btnCancel = nil; btnNone = nil;
		s._esch = nil;
		dlg = nil;
	end, dlg.Destroy);

	return dlg;
end

function VFL.CloseConsoleDialog()
	dlg:_esch();
end

function VFL.ToggleConsoleDialog()
	if dlg then
		VFL.CloseConsoleDialog();
	else
		VFL.OpenConsoleDialog();
		
	end
end

SLASH_CON1 = "/con";
SlashCmdList["CON"] = VFL.OpenConsoleDialog;

