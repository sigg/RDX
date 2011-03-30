-- sigg OpenRDX

------------------------------------------------------------------------
-- GUI binding window
--   By: Daniel LY (Sigg, Rashgarroth realm)
-- Cogsbar binding "Portions used with permission from Matthew Orlando"
------------------------------------------------------------------------

local binding_window;

local function OpenBindingWindow(parent)
	if binding_window then return binding_window; end
	
	binding_window = VFLUI.Window:new(parent); 
	binding_window:SetFrameStrata("FULLSCREEN");
	VFLUI.Window.SetDefaultFraming(binding_window, 24);
	binding_window:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	binding_window:SetTitleColor(0,.6,0);
	binding_window:SetText("Bind a key");
	binding_window:SetWidth(100); 
	binding_window:SetHeight(70);
	binding_window:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT");
	VFLUI.Window.StdMove(binding_window, binding_window:GetTitleBar());
	binding_window:SetID(parent.id);
	binding_window:SetScript("OnKeyDown", function(self, arg1)
		__RDXSetBindingKey(arg1, parent.btype);
		SaveBindings(GetCurrentBindingSet());
		DesktopEvents:Dispatch("DESKTOP_UPDATE_BINDINGS", parent.id);
	end);
	binding_window:EnableKeyboard(true);
	binding_window:Show();
	
	local btnOK = VFLUI.OKButton:new(binding_window);
	btnOK:SetText(VFLI.i18n("SAVE")); btnOK:SetHeight(25); btnOK:SetWidth(80);
	btnOK:SetPoint("BOTTOM", binding_window:GetClientArea(), "BOTTOM");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		--SaveBindings(GetCurrentBindingSet());
		--DesktopEvents:Dispatch("DESKTOP_UPDATE_BINDINGS", parent.id);
		binding_window:Destroy();
	end);
	
	binding_window.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		binding_window:SetID(0);
		binding_window = nil;
	end, binding_window.Destroy);
	
	return binding_window;
end

local function BindingKey(id, btype)
	if not btype then btype = ""; end
	return (GetBindingKey("CLICK VFL" .. btype .. "Button"..id..":LeftButton"));
end

local ignoredKeys = {
	["UNKNOWN"] = true,
	["SHIFT"] = true,
	["CTRL"] = true,
	["ALT"] = true,
}

function __RDXSetBindingKey(button, btype)
	if button == "ESCAPE" then
		binding_window:Destroy();
		return;
	end
	
	local screenshotKey = GetBindingKey("SCREENSHOT")
	if screenshotKey and button == screenshotKey then
		TakeScreenshot();
		return;
	end
	
	if ignoredKeys[button] then
		return;
	end
	
	if IsShiftKeyDown() then
		button = "SHIFT-"..button;
	end
	if IsControlKeyDown() then
		button = "CTRL-"..button;
	end
	if IsAltKeyDown() then
		button = "ALT-"..button;
	end
	
	local id = binding_window:GetID();
	local oldKey = BindingKey(id, btype);
	if oldKey then
		SetBinding(oldKey);
	end
	SetBindingClick(button, "VFL" .. btype .. "Button"..id);
end

function __RDXBindingKeyOnEnter(self)
	GameTooltip:SetOwner(self);
	local bindingText = GetBindingText(BindingKey(self.id, self.btype), "KEY_");
	if bindingText ~= "" then
		GameTooltip:SetText(VFLI.i18n("Click to change binding"));
		GameTooltip:AddLine(VFLI.i18n("Right-click to remove binding"), 1, 1, 1);
		local color = GREEN_FONT_COLOR;
		GameTooltip:AddDoubleLine(VFLI.i18n("Currently Bound:"), bindingText, 1, 1, 1, color.r, color.g, color.b);
	else
		GameTooltip:SetText(VFLI.i18n("Click to bind a key"));
	end
	GameTooltip:Show();
end

function __RDXBindingKeyOnLeave()
	GameTooltip:Hide();
end

function __RDXBindingKeyOnClick(self, arg1)
	if(arg1 == "LeftButton") then
		OpenBindingWindow(self);
	elseif(arg1 == "RightButton") then
		local key = BindingKey(self.id, self.btype);
		if key then
			SetBinding(BindingKey(self.id, self.btype));
		end
	end
end




