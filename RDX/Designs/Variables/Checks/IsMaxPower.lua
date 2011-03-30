
RDX.RegisterFeature({
	name = "var_isMaxPower";
	title = VFLI.i18n("Var IsMaxPower?");
	category = VFLI.i18n("Variables Check");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_ismaxpower");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local ismaxpower = true;
]]);
		else
			code:AppendCode([[
local ismaxpower = false;
if unit:Power() == unit:MaxPower() then ismaxpower = true end;
]]);
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("POWER");
		mux:Event_UnitMask("UNIT_POWER", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isMaxPower" }; end
});
