-- TotemsVariables.lua
-- OpenRDX
-- (C)2007 Sigg / Rashgarroth eu

RDX.RegisterFeature({
	name = "Variables: Totem Info";
	title = VFLI.i18n("Vars Totems Info");
	category =  VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_btotemearth");
		state:AddSlot("TextData_totemearth_name");
		state:AddSlot("TimerVar_totemearth");
		state:AddSlot("TexVar_totemearth_icon");
		state:AddSlot("GameTooltips_earth_Totem");
		state:AddSlot("BoolVar_btotemair");
		state:AddSlot("TextData_totemair_name");
		state:AddSlot("TimerVar_totemair");
		state:AddSlot("TexVar_totemair_icon");
		state:AddSlot("GameTooltips_air_Totem");
		state:AddSlot("BoolVar_btotemwater");
		state:AddSlot("TextData_totemwater_name");
		state:AddSlot("TimerVar_totemwater");
		state:AddSlot("TexVar_totemwater_icon");
		state:AddSlot("GameTooltips_water_Totem");
		state:AddSlot("BoolVar_btotemfire");
		state:AddSlot("TextData_totemfire_name");
		state:AddSlot("TimerVar_totemfire");
		state:AddSlot("TexVar_totemfire_icon");
		state:AddSlot("GameTooltips_fire_Totem");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
		local fire_Totem, earth_Totem, water_Totem, air_Totem = 1, 2, 3, 4;
		local btotemfire, totemfire_name, totemfire_start, totemfire_duration, totemfire_icon = GetTotemInfo(1);
		local btotemearth, totemearth_name, totemearth_start, totemearth_duration, totemearth_icon = GetTotemInfo(2);
		local btotemwater, totemwater_name, totemwater_start, totemwater_duration, totemwater_icon = GetTotemInfo(3);
		local btotemair, totemair_name, totemair_start, totemair_duration, totemair_icon = GetTotemInfo(4);
]]);
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			local smask = mux:GetPaintMask("TOTEM_UPDATE");
			local umask = mux:GetPaintMask("ENTERING_WORLD");
			mux:Event_UnitMask("UNIT_TOTEM_UPDATE", smask);
			mux:Event_UnitMask("UNIT_ENTERING_WORLD", umask);
		end
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variables: Totem Info" }; end;
});


