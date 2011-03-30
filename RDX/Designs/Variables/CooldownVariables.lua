-- CooldownInfo.lua
-- OpenRDX
-- Sigg

-----------------------------------------------
-- COOLDOWN VARIABLES
-- Allows unit frames to be constructed that display a cooldown value.
-----------------------------------------------

RDX.RegisterFeature({
	name = "Variables: Cooldown Info";
	title = "Vars Cooldown Info";
	category =  VFLI.i18n("Variables");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)		
		if not desc then VFL.AddError(errs, VFLI.i18n( "No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if not RDXCD.GetCooldownInfoBySpellid(desc.cd) then VFL.AddError(errs,  VFLI.i18n("Invalid cooldown.")); return nil; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("BoolVar_" .. desc.name .. "_used");
		state:AddSlot("TimerVar_" .. desc.name .."_cd");
		state:AddSlot("TextData_" .. desc.name .. "_cd_name");
		state:AddSlot("TexVar_" .. desc.name .."_icon");
		--state:AddSlot("Var_" .. desc.name .. "_cd_timeleft");
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- Event hinting.
		local mux, mask = state:GetContainingWindowState():GetSlotValue("Multiplexer"), 0;
		mask = mux:GetPaintMask("COOLDOWN");
		mux:Event_UnitMask("UNIT_COOLDOWN", mask);
		
		local loadCode = "unit:GetUsedCooldownBySpellid";
		-- Event hinting.
		if desc.cooldownType == "AVAIL" then
			loadCode = "unit:GetAvailCooldownBySpellid";
		end
				
		-- On paint preamble, create flag and grade variables
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[_used, ]] .. desc.name .. [[_cd_name, _, ]] .. desc.name .. [[_icon , ]] .. desc.name .. [[_cd_duration, ]] .. desc.name .. [[_cd_start = ]] .. loadCode .. [[(]] .. desc.cd .. [[);
]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText("Variable Name");
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown Type:"));
		local dd_cooldownType = VFLUI.Dropdown:new(er, RDXUI.CooldownsTypesDropdownFunction);
		dd_cooldownType:SetWidth(150); dd_cooldownType:Show();
		if desc and desc.cooldownType then 
			dd_cooldownType:SetSelection(desc.cooldownType); 
		else
			dd_cooldownType:SetSelection("USED");
		end
		er:EmbedChild(dd_cooldownType); er:Show();
		ui:InsertFrame(er);
		
		local cd = VFLUI.LabeledEdit:new(ui, 250);
		cd:SetText(VFLI.i18n("Cooldown Name"));
		cd:Show();
		if desc and desc.cd then 
			local cdinfo = RDXCD.GetCooldownInfoBySpellid(desc.cd);
			if cdinfo then
				cd.editBox:SetText(cdinfo.text);
			end
		end
		ui:InsertFrame(cd);
		
		local btn = VFLUI.Button:new(cd);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", cd.editBox, "LEFT"); 
		btn:Show();
		btn:SetScript("OnClick", function()
			RDXDAL.CooldownCachePopup(RDXCD.GetCDs(), function(x) 
				if x then cd.editBox:SetText(x.text); end
			end, btn, "CENTER");
		end);

		--local cd = VFLUI.Dropdown:new(parent, function() return Omni.cdmnuDropdownFunction; end); cd:Show();
		--ui:InsertFrame(cd);
		--local c_text, c_value = "", "";
		--if desc and desc.cd and cds[desc.cd] then c_value = desc.cd; c_text = cds[desc.cd].spellname; end
		--cd:RawSetSelection(c_text, c_value);

		function ui:GetDescriptor()
			--local _,val = cd:GetSelection();
			return {
				feature = "Variables: Cooldown Info"; name = name.editBox:GetText(); cd = RDXCD.GetCooldownInfoByText(cd.editBox:GetText());
			};
		end
		
		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variables: Cooldown Info"; name = "cd"; };
	end;
});