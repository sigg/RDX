--- ModuleViewer.lua
-- @author Sigg Rashgarroth EU
--
-- A window to show module and set the debugger.

-- Repaint signal for the window
local sigRepaint = VFL.Signal:new();

local dlg = nil;

function VFL.OpenModuleDialog()
	if dlg then return; end
	
	dlg = VFLUI.Window:new(VFLFULLSCREEN_DIALOG);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetTitleColor(.6,0,0);
	dlg:SetText("Modules");
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetHeight(370); dlg:SetWidth(400);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	dlg:SetClampedToScreen(true);
	local ca = dlg:GetClientArea();
	
	-- Panel On the left
	local decor1 = VFLUI.AcquireFrame("Frame");
	decor1:SetParent(dlg);
	decor1:SetBackdrop(VFLUI.BlackDialogBackdrop);
	decor1:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, 0);
	decor1:SetWidth(125); decor1:SetHeight(310); decor1:Show();

	-- Scrollframe on the left
	local sf = VFLUI.VScrollFrame:new(dlg);
	sf:SetWidth(100); sf:SetHeight(300);
	sf:SetPoint("TOPLEFT", decor1, "TOPLEFT", 5, -5);
	sf:Show();

	-- Root
	local ui = VFLUI.CompoundFrame:new(sf); 
	ui.isLayoutRoot = true;
	
	local tree = {};
	local p = nil;
	
	-- Tree module menu
	Root:ModuleListModules(function(indent, m)
		local btn = VFLUI.Button:new(ui);
		btn:SetHeight(20);
		btn:SetText(m.name);
		btn:Show();
		ui:InsertFrame(btn);
	end, 0);

	--- Layout Engine Bootstrap
	sf:SetScrollChild(ui);
	ui:SetWidth(sf:GetWidth());
	ui:DialogOnLayout(); ui:Show();
	
	----------------- Right side (module description)
	local decor2 = VFLUI.AcquireFrame("Frame");
	decor2:SetParent(dlg);
	decor2:SetBackdrop(VFLUI.BlackDialogBackdrop);
	decor2:SetPoint("TOPLEFT", decor1, "TOPRIGHT", 5, 0);
	decor2:SetWidth(260); decor2:SetHeight(310); decor2:Show();
	
	
	
	function UpdateModuleInfo()
		
	end
	
	dlg:Show();
	
	-------------------- Interactions
	local esch = function()
		--dlg:_Hide(.2, nil, function() 
		dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnOK:SetText("Close"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		VFL.EscapeTo(esch);
	end);

	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		decor1:Destroy(); decor1 = nil;
		decor2:Destroy(); decor2 = nil;
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);

	return dlg;
end

function VFL.CloseModuleDialog()
	dlg:_esch();
end

function VFL.ToggleModuleDialog()
	if dlg then
		VFL.CloseModuleDialog();
	else
		VFL.OpenModuleDialog();
	end
end

SLASH_MD1 = "/md";
SlashCmdList["MD"] = VFL.OpenModuleDialog;