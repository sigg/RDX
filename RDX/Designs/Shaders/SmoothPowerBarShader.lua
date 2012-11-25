------------------------------------
-- Smooth power bar shader
-- working like the freetimer
-- by Sigg
------------------------------------

local function ftStart(self, unit)
	self.start = true; self.unit = unit; self.fp = -1;
end

local function ftIsStart(self)
	return self.start;
end

local function ftDestroy(self)
	self.start = nil; self.unit = nil; self.fp = nil;
	self.bar = nil; self.text = nil; self.Start = nil; self.IsStart = nil; 
end

function RDX.CreateSPBClass(statusBar, textPower)
	-- Build the onupdate script.
	local onUpdate = [[
return function(self)
	if self.start and self.unit then
		self.fp = self.unit:FracPower();
]];
	if statusBar then onUpdate = onUpdate .. "self.bar:Show(); self.bar:SetValue(self.fp);"; end
	if textPower then onUpdate = onUpdate .. "self.text:SetText(string.format('%0.0f%%', self.fp*100));"; end
	
	-- stop when max power
	onUpdate = onUpdate .. [[
		if (self.unitGetClassMnemonic == "WARRIOR" or self.unitGetClassMnemonic == "DEATHKNIGHT") then
			if (self.fp == 0) then self.start = false; end
		else
			if (self.fp == 1) then self.start = false; end
		end
]];
	onUpdate = onUpdate .. [[
	end
end;
]];
	local updater = loadstring(onUpdate);
	if updater then updater = updater(); else updater = VFL.Noop; end

	return function(parent, sb, txt)
		local f = VFLUI.AcquireFrame("Frame");
		f:SetParent(parent);
		f:Show();
		f.bar = sb; f.text = txt; 
		f.Start = ftStart;
		f.IsStart = ftIsStart;
		f:SetScript("OnUpdate", updater);
		f.Destroy = VFL.hook(ftDestroy, f.Destroy);
		return f;
	end
end

RDX.RegisterFeature({
	name = "shader_SPB"; 
	version = 1;	
	multiple = true;
	title = VFLI.i18n("Sh: StatusBar Smooth Power Bar");
	category = VFLI.i18n("Shaders");
	IsPossible = function(state)
		if not state:HasSlots("DesignFrame", "EmitClosure", "EmitCreate", "EmitPaint", "EmitDestroy") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local flg = true;
		if desc.statusBar and desc.statusBar ~= "" and not state:Slot("StatusBar_" .. desc.statusBar) then
			VFL.AddError(errs, VFLI.i18n("Invalid statusbar")); flg = nil;
		end
		if desc.text and desc.text ~= "" and not state:Slot("Text_" .. desc.text) then
			VFL.AddError(errs, VFLI.i18n("Invalid text")); flg = nil;
		end
		return flg;
	end;
	ApplyFeature = function(desc, state, errs)
		local objname = "shader_SPB_" .. math.random(10000000); -- Generate a random ID.
		local sb = strtrim(desc.statusBar or "");
		local txt = strtrim(desc.text or "");
		local sbPresent, txtPresent = "true", "true";
		if sb == "" then sbPresent = "false"; sb = "nil"; else sb = RDXUI.ResolveStatusBarReference(desc.statusBar); end
		if txt == "" then txtPresent = "false"; txt = "nil"; else txt = RDXUI.ResolveTextReference(desc.text); end

		--- Closure
		-- Create a SPB class for our frame (this avoids the nasty situation where we have to recompile
		-- the code every time a frame is created.)
		local closureCode = [[
local ftc_]] .. objname .. [[ = RDX.CreateSPBClass(]] .. sbPresent .. [[,]] .. txtPresent .. [[);
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		--- Creation
		-- The shader is just a frame with an OnUpdate routine that updates the linked objects.
		local createCode = [[
	frame.]] .. objname .. [[ = ftc_]] .. objname .. [[(frame, ]] .. sb .. [[, ]] .. txt .. [[);
]];
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		--- Paint
		local paintCode = [[
		if not frame.]] .. objname .. [[:IsStart() then
			frame.]] .. objname .. [[:Start(unit);
		end
]];
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);

		--- Destruction
		local destroyCode = [[
		frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);
		
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("POWER");
		mux:Event_UnitMask("UNIT_POWER", mask);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local statusBar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Statusbar"), state, "StatusBar_");
		if desc and desc.statusBar then statusBar:SetSelection(desc.statusBar); end
		
		local text = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Text"), state, "Text_");
		if desc and desc.text then text:SetSelection(desc.text); end
		
		function ui:GetDescriptor()
			return {
				feature = "shader_SPB"; version = 1;
				statusBar = statusBar:GetSelection();
				text = text:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "shader_SPB"; version = 1;
		};
	end;
});