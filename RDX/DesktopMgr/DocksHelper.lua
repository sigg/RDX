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
	dlg:SetText("Dock Helper");
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(200); sf:SetHeight(70);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			dlg:Destroy(); dlg = nil;
		--end);
	end
	
	VFL.AddEscapeHandler(esch);
	function dlg:_esch() VFL.EscapeTo(esch); end
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end

RDXDK.OpenDockHelper = OpenDockHelper;
