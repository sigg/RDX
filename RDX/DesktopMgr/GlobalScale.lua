-- OpenRDX
-- Daniel Ly / Sigg

local dlg = nil;
function RDXDK.GlobalScaleDialog()
	if dlg then return; end
	if not RDXG.GlobalScale then RDXG.GlobalScale = {}; end
	if type(RDXG.GlobalScale) ~= "table" then RDXG.GlobalScale = {}; end
	
	dlg = VFLUI.Window:new();
	VFLUI.Window.SetDefaultFraming(dlg, 20);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(250); dlg:SetHeight(80); 
	dlg:SetTitleColor(0,0,.6);
	dlg:SetText(VFLI.i18n("Global Scale:"));
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("GlobalScale") then RDXPM.RestoreLayout(dlg, "GlobalScale"); end
	
	local ca = dlg:GetClientArea();
	local lblScale = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Scale"));
	lblScale:SetPoint("TOPLEFT", ca, "TOPLEFT"); lblScale:SetHeight(25);
	local edScale = VFLUI.Edit:new(dlg, true); edScale:SetHeight(25); edScale:SetWidth(50);
	edScale:SetPoint("TOPRIGHT", ca, "TOPRIGHT", 0, 0); edScale:Show();
	local slScale = VFLUI.HScrollBar:new(dlg, nil, function(value)
		if value == 0 then value = 0.01; end
		DesktopEvents:Dispatch("WINDOW_UPDATE_ALL", "SCALE", value);
	end);
	slScale:SetPoint("RIGHT", edScale, "LEFT", -16, 0); slScale:SetWidth(100);
	slScale:Show();
	slScale:SetMinMaxValues(.1, 3.0); 
	local scale = RDXG.GlobalScale[RDXU.AUI];
	if not scale then scale = 1; end
	slScale:SetValue(scale);
	VFLUI.BindSliderToEdit(slScale, edScale);
	
	dlg:_Show(.2);
	
	local esch = function()
		dlg:_Hide(.2, nil, function()
			RDXPM.StoreLayout(dlg, "GlobalScale");
			dlg:Destroy(); dlg = nil;
		end);
	end
	VFL.AddEscapeHandler(esch);
	
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(75); btnOK:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnOK:SetText(VFLI.i18n("OK")); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		RDXG.GlobalScale[RDXU.AUI] = slScale:GetValue();
		VFL.EscapeTo(esch);
	end);
	
	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		slScale:Destroy(); slScale = nil; edScale:Destroy(); edScale = nil;
	end, dlg.Destroy);
end
