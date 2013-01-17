
RDX.RegisterFeature({
	name = "var_inInstance";
	title = VFLI.i18n("Var IsInInstance?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_inInstance");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local inInstance = true;
]]);
		else
			code:AppendCode([[
local inInstance = true;
local posX = GetPlayerMapPosition(uid);
if posX and (posX > 0) then inInstance = false; end
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
	CreateDescriptor = function() return { feature = "var_inInstance" }; end
});
