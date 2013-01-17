
RDX.RegisterFeature({
	name = "var_issolar"; 
	title = VFLI.i18n("Var EclipseDirection?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_solardirection");
		state:AddSlot("BoolVar_lunardirection");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local solardirection = true;
local lunardirection = true;
]]);
		else
			code:AppendCode([[
local solardirection, lunardirection = nil, nil;
local direction = GetEclipseDirection()
if direction == "moon" then
	solardirection, lunardirection = nil, true;
elseif direction == "sun" then
	solardirection, lunardirection = true, nil;
end
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local mask = mux:GetPaintMask("FLAGS");
			mux:Event_UnitMask("UNIT_FLAGS", mask);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "var_issolar" }; end
});
