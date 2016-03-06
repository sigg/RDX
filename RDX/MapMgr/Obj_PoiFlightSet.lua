

RDXDB.RegisterObjectType({
	name = "POIFlightSet",
	New = function(path, md)
		md.version = 1;
	end,
});



local function BindingCodePopup(parent, callback)
	------------------ CREATE
	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(200); dlg:SetHeight(360);
	dlg:SetText(VFLI.i18n("Select Button Combination"));
	dlg:SetClampedToScreen(true);

	local gb_mods = VFLUI.GroupBox:new(dlg);
	gb_mods:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	gb_mods:SetHeight(190); gb_mods:SetWidth(80); gb_mods:Show();
	VFLUI.GroupBox.MakeTextCaption(gb_mods, "Modifiers");

	local mods = VFLUI.CheckGroup:new(gb_mods:GetClientArea());
	mods:SetPoint("TOPLEFT", gb_mods:GetClientArea(), "TOPLEFT");
	mods:SetLayout(3, 1);
	mods:SetWidth(70);
	mods.checkBox[1]:SetText("Shift");
	mods.checkBox[2]:SetText("Ctrl");
	mods.checkBox[3]:SetText("Alt");
	RDX:Debug(1, "Mods dimensions: " .. mods:GetHeight() .. "x" .. mods:GetWidth());
	mods:Show();

	local gb_btn = VFLUI.GroupBox:new(dlg);
	gb_btn:SetPoint("TOPLEFT", gb_mods, "TOPRIGHT");
	gb_btn:SetHeight(290); gb_btn:SetWidth(110); gb_btn:Show();
	VFLUI.GroupBox.MakeTextCaption(gb_btn, "Button");

	local btn = VFLUI.RadioGroup:new(gb_btn:GetClientArea());
	btn:SetPoint("TOPLEFT", gb_btn:GetClientArea(), "TOPLEFT");
	btn:SetLayout(15, 1);
	btn:SetWidth(100);
	btn.buttons[1]:SetText("Left");
	btn.buttons[2]:SetText("Right");
	btn.buttons[3]:SetText("Middle");
	btn.buttons[4]:SetText("Button 4");
	btn.buttons[5]:SetText("Button 5");
	btn.buttons[6]:SetText("Button 6");
	btn.buttons[7]:SetText("Button 7");
	btn.buttons[8]:SetText("Button 8");
	btn.buttons[9]:SetText("Button 9");
	btn.buttons[10]:SetText("Button 10");
	btn.buttons[11]:SetText("Button 11");
	btn.buttons[12]:SetText("Button 12");
	btn.buttons[13]:SetText("Button 13");
	btn.buttons[14]:SetText("Button 14");
	btn.buttons[15]:SetText("Button 15");
	btn:Show();
	btn:SetValue(1);

	----------------- INTERACT
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);
	
	local esch = function() 
		dlg:_Hide(RDX.smooth, nil, function() 
			dlg:Destroy(); dlg = nil;
		end);
	end
	VFL.AddEscapeHandler(esch);

	local function Save()
		local str, v = "", btn:GetValue();
		if mods.checkBox[1]:GetChecked() then str = str .. "S"; end
		if mods.checkBox[2]:GetChecked() then str = str .. "C"; end
		if mods.checkBox[3]:GetChecked() then str = str .. "A"; end
		if v then
			str = str .. v;
		else
			str = nil;
		end
		if callback then callback(str); end
		-- Destroy the window
		VFL.EscapeTo(esch);
	end
	
	local btnOK = VFLUI.OKButton:new(dlg); -- OK button
	btnOK:SetText(VFLI.i18n("OK")); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		Save();
	end);
	
	local btnCancel = VFLUI.CancelButton:new(dlg); -- OK button
	btnCancel:SetText(VFLI.i18n("Cancel")); btnCancel:SetHeight(25); btnCancel:SetWidth(75);
	btnCancel:SetPoint("RIGHT", btnOK, "LEFT");
	btnCancel:Show();
	btnCancel:SetScript("OnClick", function()
		VFL.EscapeTo(esch); 
	end);

	----------------- DESTROY
	dlg.Destroy = VFL.hook(function(s)
		btnCancel:Destroy(); btnCancel = nil;
		btnOK:Destroy(); btnOK = nil;
		mods:Destroy(); mods = nil;
		gb_mods:Destroy(); gb_mods = nil;
		btn:Destroy(); btn = nil;
		gb_btn:Destroy(); gb_btn = nil;
	end, dlg.Destroy);
end