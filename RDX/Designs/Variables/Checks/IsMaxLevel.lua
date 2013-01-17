
-- Brainn
RDX.RegisterFeature({
	name = "var_isMaxLevel";
	title = VFLI.i18n("Var IsMaxLevel?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_ismaxlevel");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) 
		if desc.test then
			code:AppendCode([[
local ismaxlevel = true;
]]);
		else
			code:AppendCode([[
local ismaxlevel = false;
if UnitLevel(uid) == 85 then ismaxlevel = true; end;
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("XP_UPDATE");
			mux:Event_UnitMask("UNIT_XP_UPDATE", mask);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_isMaxLevel" }; end
});
