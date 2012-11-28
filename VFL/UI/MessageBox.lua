-- MessageBox.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A MessageBox is a small dialog box that appears in the center of the screen
-- to inform or collect input from the user.

function VFLUI.MessageBox(title, text, editText, b1_text, b1_callback, b2_text, b2_callback, parent)
	-- layout arguments
	local th, eh, bh = 0, 0, 25;
	local btn1, btn2, editor = nil, nil, nil;
	local GetEditText = VFL.Noop;
	
	-- Create window
	local dlg = VFLUI.Window:new(parent or VFLFULLSCREEN_DIALOG);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetPoint("CENTER", VFLParent, "CENTER", 0, 50);
	dlg:SetText(title);
	dlg:SetWidth(300);

	-- Create and layout text
	local fs = VFLUI.CreateFontString(dlg);
	fs:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	fs:SetWidth(290);
	--- Compute requisite size...
	VFLUI.SetFont(fs, Fonts.Default);
	fs:SetJustifyH("LEFT"); fs:SetText(text);
	th = math.ceil(fs:GetStringWidth() / 270) * 14;
	fs:SetHeight(th); fs:Show();
	
	local function Close()
		dlg:Destroy(); dlg = nil;
	end

	-- Normalize input controls. b1 = cancel.
	if not b1_callback then b1_callback = VFL.Noop; end
	if not b2_callback then b2_callback = VFL.Noop; end
	--if not b2_text then b2_callback = b1_callback; end -- If no B2 is provided, then ok == cancel.
	local function OK() 
		local et = GetEditText(); 
		Close(); b2_callback(et);
	end
	local function Cancel() 
		local et = GetEditText(); 
		Close(); b1_callback(et); 
	end
	
	-- Create edit control if necessary
	if editText then
		eh = 25;
		editor = VFLUI.Edit:new(dlg);
		editor:SetHeight(25); editor:SetWidth(290);
		editor:SetPoint("TOPLEFT", fs, "BOTTOMLEFT"); editor:Show();
		editor:SetText(editText); editor:SetFocus();
		GetEditText = function() return editor:GetText(); end;
		editor:SetScript("OnEnterPressed", OK);
	end

	btn1 = VFLUI.Button:new(dlg);
	btn1:SetWidth(60); btn1:SetHeight(25);
	btn1:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btn1:SetText(b1_text or "Close"); btn1:Show();
	btn1:SetScript("OnClick", Cancel);

	if b2_text then
		btn2 = VFLUI.Button:new(dlg);
		btn2:SetWidth(60); btn2:SetHeight(25);
		btn2:SetPoint("RIGHT", btn1, "LEFT");
		btn2:SetText(b2_text); btn2:Show();
		btn2:SetScript("OnClick", OK);
	end

	dlg:SetHeight(40 + th + eh + bh); dlg:SetBackdrop(VFLUI.BlackDialogBackdrop); dlg:Show();
	
	dlg.Destroy = VFL.hook(function(s)
		GetEditText = nil;
		if editor then editor:Destroy(); editor = nil; end
		if btn1 then btn1:Destroy(); btn1 = nil; end
		if btn2 then btn2:Destroy(); btn2 = nil; end
		VFLUI.ReleaseRegion(fs); fs = nil;
	end, dlg.Destroy);

	return mb;
end
