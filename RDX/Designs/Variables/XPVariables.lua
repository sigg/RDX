---------------------------------------------------
-- Fractional XP (fridgid)
---------------------------------------------------
RDX.RegisterFeature({
	name = "Variable: Frac XP (fxp)";
	title = "Vars Frac XP (fxp)";
	test = true;
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		if state:Slot("Var_fxp") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("Var_fxp");
		state:AddSlot("FracVar_fxp");
		state:AddSlot("TextData_fpxptxt");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) 
		if desc.test then
		code:AppendCode([[	
local fxp = 0.5;
local fpxptxt = "xp test"
]]);
		else
		code:AppendCode([[
local fxp = UnitXP("player")/UnitXPMax("player");
local fpxptxt = floor((UnitXP("player")/UnitXPMax("player")) * 100) .. "% | " .. UnitXP("Player") .. " / " .. UnitXPMax("player");
if GetXPExhaustion() then fpxptxt = fpxptxt .. " " .. (GetXPExhaustion()/2).. " R"; end
]]); 
		end
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("XP_UPDATE");
		mux:Event_UnitMask("UNIT_XP_UPDATE", mask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variable: Frac XP (fxp)" }; end
});