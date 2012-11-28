-------------------------------------------------------------------
-- WEAPONS UNITFRAME VARIABLES
-------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Variables: Weapons Buff Info";
	title = VFLI.i18n("Vars Weapons Enchant Info");
	category =  VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("BoolVar_bMainHandEnchant");
		state:AddSlot("Var_MainHandEnchant_name");
		state:AddSlot("TimerVar_MainHandEnchant");
		state:AddSlot("TextData_MandHandEnchant_name_rank");
		state:AddSlot("TexVar_MainHand_icon");
		state:AddSlot("TexVar_MainHandEnchant_icon");
		state:AddSlot("GameTooltips_MainHandEnchant_InventoryItem");
		state:AddSlot("BoolVar_bOffHandEnchant");
		state:AddSlot("Var_OffHandEnchant_name");
		state:AddSlot("TimerVar_OffHandEnchant");
		state:AddSlot("TextData_OffHandEnchant_name_rank");
		state:AddSlot("TexVar_OffHand_icon");
		state:AddSlot("TexVar_OffHandEnchant_icon");
		state:AddSlot("GameTooltips_OffHandEnchant_InventoryItem");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local smask = mux:GetPaintMask("BUFFWEAPON_UPDATE");
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
		local bMainHandEnchant, MainHandEnchant_name, MainHandEnchant_rank, MainHandEnchant_charge, MainHandEnchant_start, MainHandEnchant_duration, MainHand_icon, MainHandEnchant_icon, MainHandEnchant_InventoryItem, bOffHandEnchant, OffHandEnchant_name, OffHandEnchant_rank, OffHandEnchant_charge, OffHandEnchant_start, OffHandEnchant_duration, OffHand_icon, OffHandEnchant_icon, OffHandEnchant_InventoryItem = RDXDAL.LoadWeaponsBuff();
		local MandHandEnchant_name_rank, OffHandEnchant_name_rank = "", "";
		if MainHandEnchant_name and MainHandEnchant_name ~= "" then
			MandHandEnchant_name_rank = MainHandEnchant_name;
			if MainHandEnchant_rank and MainHandEnchant_rank ~= "" then
				MandHandEnchant_name_rank = MandHandEnchant_name_rank .. " " .. MainHandEnchant_rank;
			end
			if MainHandEnchant_charge and MainHandEnchant_charge ~= "" then
				MandHandEnchant_name_rank = MandHandEnchant_name_rank .. " (" .. MainHandEnchant_charge .. ")";
			end
		end
		if OffHandEnchant_name and OffHandEnchant_name ~= "" then
			OffHandEnchant_name_rank = OffHandEnchant_name;
			if OffHandEnchant_rank and OffHandEnchant_rank ~= "" then
				OffHandEnchant_name_rank = OffHandEnchant_name_rank .. " " .. OffHandEnchant_rank;
			end
			if OffHandEnchant_charge and OffHandEnchant_charge ~= "" then
				OffHandEnchant_name_rank = OffHandEnchant_name_rank .. " (" .. OffHandEnchant_charge .. ")";
			end
		end
]]);
		end);
		
		mux:Event_UnitMask("UNIT_BUFFWEAPON_UPDATE", smask);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "Variables: Weapons Buff Info" }; end;
});
