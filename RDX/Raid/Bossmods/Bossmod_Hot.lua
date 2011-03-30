-- Sigg OPENRDX

RDX.RegisterFeature({
	name = "Reset Encounter",
	category = VFLI.i18n("Encounters");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		if not desc.bevent or desc.bevent == "" then
			VFL.AddError(errs, VFLI.i18n("You must bind to an event"));
			return false;
		end
		return true;
	end,
	ApplyFeature = function(desc, state)
		local events = "WoWEvents";
		if RDXBM.EventIsLocal(desc.bevent, state) then events = "BossmodEvents"; end	
		state.Code:AppendCode([[
		]]..events..[[:Bind("]]..desc.bevent..[[", nil, function()
			-- track is created in register
			RDX.AutoStartStopEncounter(track);
			RDX.AutoUpdateEncounterPane(track);
		end, encid); -- event
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local bevent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Bind to event")); 
		if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
		ui:InsertFrame(bevent);
		
		function ui:GetDescriptor()
			return {
				feature = "Reset Encounter";
				bevent = bevent.editBox:GetText();
			};
		end
		return ui;
	end,
	CreateDescriptor = function() return {feature = "Reset Encounter"}; end
});