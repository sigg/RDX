
RDX.RegisterFeature({
	name = "var_hascdused";
	title = VFLI.i18n("Var HasCDUsed?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_hasCDUsed");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local hasCDUsed = true;
]]);
		else
			code:AppendCode([[
local hasCDUsed = nil
local cd_used = unit:GetCooldowns();
if not VFL.isempty(cd_used) then
	hasCDUsed = true;
end
]]);
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("COOLDOWN");
		mux:Event_UnitMask("UNIT_COOLDOWN", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_hascdused" }; end
});
