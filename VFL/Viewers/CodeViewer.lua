---------------------------------------------
-- Code viewer
---------------------------------------------
function VFL.Debug_ShowCode(code)
	-- Add line numbers to the passed code
	local ln = 1;
	code = "|cFF00FF00001|r " .. string.gsub(code, "\n", function() 
		ln = ln + 1; 
		return string.format("\n|cFF00FF00%03d|r ", ln);
	end);

	-- Create a simple display window for the code.
	local win = VFLUI.Window:new(VFLFULLSCREEN_DIALOG);
	VFLUI.Framing.Default(win, 18);
	win:SetText("Code Viewer"); win:SetTitleColor(0.6, 0, 0);
	win:SetWidth(510); win:SetHeight(385); win:SetPoint("CENTER", VFLParent, "CENTER");
	VFLUI.Window.StdMove(win, win:GetTitleBar());
	win:Show();
	win:SetClampedToScreen(true);

	local f = VFLUI.TextEditor:new(win:GetClientArea());
	f:SetWidth(500); f:SetHeight(350);
	f:SetPoint("CENTER", win:GetClientArea(), "CENTER");
	f:SetText(code);
	f:Show();

	local esch = function()
		--win:_Hide(.5, nil, function() 
		f:Destroy(); f = nil; win:Destroy(); win = nil; 
		--end);
	end;
	VFL.AddEscapeHandler(esch);
	
	local closebtn = VFLUI.CloseButton:new();
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	win:AddButton(closebtn);
end