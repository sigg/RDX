-- ErrorViewer.lua
-- @author (C)2006 Bill Johnson and The VFL Project
--
-- A frame for collecting error information with full stack traces.

-- Repaint signal for the window
local sigRepaint = VFL.Signal:new();

local dlg = nil;

function VFL.OpenErrorDialog()
	if dlg then return; end
	
	dlg = VFLUI.Window:new(VFLFULLSCREEN_DIALOG);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(.6,0,0);
	dlg:SetText("Errors");
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetHeight(400); dlg:SetWidth(400);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	local ca = dlg:GetClientArea();

	---------------- Error list
	local selection = nil;
	local errorList = VFLUI.List:new(dlg, 12, VFLUI.Selectable.AcquireCell);
	errorList:SetPoint("TOPLEFT", ca, "TOPLEFT");
	errorList:SetWidth(390); errorList:SetHeight(96);
	errorList:Rebuild(); errorList:Show();
	errorList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data.msg);
		if data == selection then
			cell.selTexture:SetVertexColor(0,0,1); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		cell:SetScript("OnClick", function() selection = data; sigRepaint:Raise(); end);
	end, VFL.ArrayLiterator(VFL.GetErrors()));

	---------------------- View box
	local viewBox = VFLUI.TextEditor:new(dlg);
	viewBox:SetPoint("TOPLEFT", errorList, "BOTTOMLEFT");
	viewBox:SetWidth(390); viewBox:SetHeight(250); viewBox:Show();
	
	dlg:Show(.2, true);

	--------------------- Repaint
	local function Repaint()
		errorList:Update();
		if selection and VFL.vfind(VFL.GetErrors(), selection) then
			viewBox:SetText(selection.full or "");
		else
			selection = nil; viewBox:SetText("");
		end
	end
	sigRepaint:Connect(nil, Repaint, "repaint");

	-------------------- Interactions
	
	local esch = function()
		dlg:Hide(.2, true);
		VFLT.ZMSchedule(.25, function()
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
	btnNone:SetScript("OnClick", function() VFL._ClearErrors(); Repaint(); end);

	dlg.Destroy = VFL.hook(function(s)
		sigRepaint:DisconnectByID("repaint"); Repaint = nil;
		btnCancel:Destroy(); btnNone:Destroy();
		btnCancel = nil; btnNone = nil;
		errorList:Destroy(); errorList = nil; selection = nil;
		viewBox:Destroy(); viewBox = nil; s._esch = nil;
		dlg = nil;
	end, dlg.Destroy);

	return dlg;
end

function VFL.CloseErrorDialog()
	dlg:_esch();
end

function VFL.ToggleErrorDialog()
	if dlg then
		VFL.CloseErrorDialog();
	else
		VFL.OpenErrorDialog();
	end
end

SLASH_ERR1 = "/err";
SlashCmdList["ERR"] = VFL.OpenErrorDialog;

