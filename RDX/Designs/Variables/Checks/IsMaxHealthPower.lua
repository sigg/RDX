
-- By unlimit
RDX.RegisterFeature({
	name = "var_IsMaxHealthPower";
	title = VFLI.i18n("Var IsMaxHealthPower?");
	category = VFLI.i18n("Variables True/False");
	test = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_ismaxhealthpower");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
local ismaxhealthpower = true;
]]);
		else
			code:AppendCode([[
local ismaxhealthpower = false;
local pt = unit:PowerType();
if unit:Health() == unit:MaxHealth() then
	if unit:Power() == unit:MaxPower() and (pt == 0 or pt == 2 or pt == 3) then
		ismaxhealthpower = true;
	elseif  unit:Power() >= 1 and (pt == 1 or pt == 6) then
		ismaxhealthpower = true;
	end
end
]]);
		end
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux, mask = wstate:GetSlotValue("Multiplexer"), 0;
			mask = mux:GetPaintMask("POWER");
			mux:Event_UnitMask("UNIT_POWER", mask);
			mask = mux:GetPaintMask("HEALTH");
			mux:Event_UnitMask("UNIT_HEALTH", mask);
		end
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local stxt = VFLUI.SimpleText:new(ui, 2, 200); stxt:Show();
		stxt:SetText("This feature is inverse for Runic Power or Rage.");
		ui:InsertFrame(stxt);
		
		function ui:GetDescriptor()
			return {
				feature = "var_IsMaxHealthPower";
			};
		end

		return ui;
	end;
	CreateDescriptor = function() return { feature = "var_IsMaxHealthPower" }; end
});
