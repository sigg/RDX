RDX.RegisterFeature({
	name = "Variable combo";
	title = "Vars Combo";
	category = VFLI.i18n("Variables");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("NumberVar_combopoint") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_combopoint");
		state:AddSlot("NumberVar_combopoint");
		state:AddSlot("FracVar_combopoints");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local combopoint = 5;
local combopoints = 1;
]]);
		else
			code:AppendCode([[
local combopoint = GetComboPoints(uid);
local combopoints = GetComboPoints(uid) / 5;
]]); 
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("COMBO_POINTS");
		mux:Event_UnitMask("UNIT_COMBO_POINTS", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variable combo" }; end
});