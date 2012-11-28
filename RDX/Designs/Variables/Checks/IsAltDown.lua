
RDX.RegisterFeature({
	name = "var_isAltDown"; 
	title = VFLI.i18n("Var IsAltHeldDown?"); 
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_isAltDown");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local isAltDown = true;
]]);
		else
			code:AppendCode([[
local isAltDown = IsAltKeyDown();
]]);
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("HARDWARE");
		mux:Event_UnitMask("MODIFIER_STATE_CHANGED", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isAltDown" }; end
});
