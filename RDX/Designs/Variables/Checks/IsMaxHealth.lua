
RDX.RegisterFeature({
	name = "var_isMaxHealth";
	title = VFLI.i18n("Var IsMaxHealth?");
	category = VFLI.i18n("Variables True/False");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_ismaxhealth");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
local ismaxhealth = false;
if unit:Health() == unit:MaxHealth() then ismaxhealth = true end;
]]);
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("HEALTH");
		mux:Event_UnitMask("UNIT_HEALTH", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isMaxHealth" }; end
});
