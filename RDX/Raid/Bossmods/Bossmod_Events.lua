-- Bossmod_Events.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- Event bindings for bossmod objects.

------------------------------------------------------------------------
-- GUI Bossmods module for RDX
--   By: Trevor Madsen (Gibypri, Kilrogg realm)
--
-- Note:
--  Licensed exclusively to Raid Informatics
------------------------------------------------------------------------
local function GenerateEventDispatchUI(desc, ui, txt)
	local devent = RDXBM.CreateEventEdit(ui, txt)
	if desc and desc.devent then devent.editBox:SetText(desc.devent); end
	ui:InsertFrame(devent);

	local lockout = VFLUI.LabeledEdit:new(ui, 40); lockout:Show();
	lockout:SetText(VFLI.i18n("Lockout (seconds)")); lockout.editBox:SetText(0);
	if desc and desc.lockout then lockout.editBox:SetText(desc.lockout); end
	ui:InsertFrame(lockout);
	
	local rpc = VFLUI.Checkbox:new(ui);
	rpc:SetHeight(25); rpc:SetWidth(135);
	if desc and desc.rpc then rpc:SetChecked(desc.rpc); end
	rpc:SetText(VFLI.i18n("RPC")); rpc:Show();
	ui:InsertFrame(rpc);
	
	return devent, lockout, rpc;
end

RDX.RegisterFeature({
	name = "Event: Simple",
	category = VFLI.i18n("Events");
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
		
		if not desc.devent or desc.devent == "" then 
			VFL.AddError(errs, VFLI.i18n("You must dispatch an event"));
			return false;
		end
		
		state:AddSlot("BossmodSimpleEvent");
		return true;
	end;
	ApplyFeature = function(desc, state)
		desc.srchStr = desc.srchStr or "";
		
		local events = "WoWEvents";
		if RDXBM.EventIsLocal(desc.bevent, state) then events = "BossmodEvents"; end		
		state.Code:AppendCode([[
		BossmodEvents:Bind("ACTIVATE", nil, function()
		]]..events..[[:Bind("]]..desc.bevent..[[", nil, function()
			if arg1 and arg1:match("]]..desc.srchStr..[[") then
				local sent = BossmodEvents:LatchedDispatch(]]..desc.lockout..[[, "]]..desc.devent..[[");
		]]);
		if desc.rpc then
		state.Code:AppendCode([[
				if sent then RPC.Invoke(encid, "]]..desc.devent..[["); end
		]]); end
		state.Code:AppendCode([[
			end
		end, encid);
		end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		
		local bevent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Bind to event:"))
		if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
		ui:InsertFrame(bevent);
		
		local srchStr = VFLUI.LabeledEdit:new(ui, 200); srchStr:Show();
		srchStr:SetText("Find message: ");
		if desc and desc.srchStr then srchStr.editBox:SetText(desc.srchStr); end
		ui:InsertFrame(srchStr);
		
		local devent, lockout, rpc = GenerateEventDispatchUI(desc, ui, VFLI.i18n("If message found, Dispatch Event:"))		

		function ui:GetDescriptor()
			return {
				feature = "Event: Simple"; 
				bevent = bevent.editBox:GetText();
				srchStr = srchStr.editBox:GetText();
				devent = devent.editBox:GetText();
				lockout = lockout.editBox:GetText();
				rpc = rpc:GetChecked();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Event: Simple"}; end
});

local _rowtypes = {
	{ text = "DamageIn"},
	{ text = "DamageOut"},
	{ text = "HealingIn"},
	{ text = "HealingOut"},
	{ text = "+Debuff"},
	{ text = "-Debuff"},
	{ text = "+Buff"},
	{ text = "-Buff"},
	{ text = "Killing Blow"},
	{ text = "Death"},
	{ text = "CastMob"},
	{ text = "CastMobSuccess"},
	{ text = "+BuffMob"},
	{ text = "-BuffMob"},
	{ text = "+DebuffMob"},
	{ text = "-DebuffMob"},
	{ text = "Interrupt"},
	{ text = "InterruptMob"},
	{ text = "Summon"},
};
local function _dd_rowtypes() return _rowtypes; end

typeToRow = RDXMD.eventToId;

RDX.RegisterFeature({
	name = "Event: Omniscience",
	category = VFLI.i18n("Events");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		if not desc.bevent or desc.bevent == "" then 
			VFL.AddError(errs, VFLI.i18n("You must bind to an event")); return false;
		end
		if not desc.omnirow or desc.omnirow == "" then 
			VFL.AddError(errs, VFLI.i18n("You must select a row type")); return false;
		end
		if (not desc.omniabiName or desc.omniabiName == "") and (not desc.omniabiID or desc.omniabiID == "") then 
			VFL.AddError(errs, VFLI.i18n("You must enter a spellname or spellid (by default engine compare spellid first)")); return false;
		end
		if not desc.devent or desc.devent == "" then 
			VFL.AddError(errs, VFLI.i18n("You must dispatch an event"));
			return false;
		end
		state:AddSlot("BossmodOmniEvent");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local idorname = desc.omniabiName;
		if desc.omniabiID and desc.omniabiID ~= "" then 
			idorname = desc.omniabiID;
			state.Code:AppendCode([[
			BossmodEvents:Bind("ACTIVATE", nil, function()
			BossmodEvents:Bind("]]..desc.bevent..[[", nil, function(rowtype, source, sourceGUID, target, targetGUID, spellname, spellid)
				if (rowtype == typeToRow["]].. desc.omnirow ..[["]) and (spellid == ]].. idorname ..[[) then
				local sent = BossmodEvents:LatchedDispatch(]]..desc.lockout..[[, "]]..desc.devent..[[", source, sourceGUID, target, targetGUID);
			]]);
		else
			state.Code:AppendCode([[
			BossmodEvents:Bind("ACTIVATE", nil, function()
			BossmodEvents:Bind("]]..desc.bevent..[[", nil, function(rowtype, source, sourceGUID, target, targetGUID, spellname, spellid)
				if (rowtype == typeToRow["]].. desc.omnirow ..[["]) and (spellname == "]].. idorname ..[[") then
				local sent = BossmodEvents:LatchedDispatch(]]..desc.lockout..[[, "]]..desc.devent..[[", source, sourceGUID, target, targetGUID);
			]]);
		end
		if desc.rpc then
		state.Code:AppendCode([[
				if sent then RPC.Invoke(encid, "]]..desc.devent..[[", source, sourceGUID, target, targetGUID); end
		]]); end
		state.Code:AppendCode([[
			end
		end, encid);
		end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local bevent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Bind to event:"))
		if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
		ui:InsertFrame(bevent);
		
		local omnirow = VFLUI.EmbedRight(ui, VFLI.i18n("Row Type:"));
		local dd_rowType = VFLUI.Dropdown:new(omnirow, _dd_rowtypes);
		dd_rowType:SetWidth(100); dd_rowType:Show();
		omnirow:EmbedChild(dd_rowType); omnirow:Show();
		if desc and desc.omnirow then dd_rowType:SetSelection(desc.omnirow); end
		ui:InsertFrame(omnirow);
		
		local omniabiID = VFLUI.LabeledEdit:new(ui, 200); omniabiID:Show();
		omniabiID:SetText("Ability ID or Spell ID : ");
		if desc and desc.omniabiID then omniabiID.editBox:SetText(desc.omniabiID); end
		ui:InsertFrame(omniabiID);
		
		local omniabiName = VFLUI.LabeledEdit:new(ui, 200); omniabiName:Show();
		omniabiName:SetText("Ability Name or Spell Name : ");
		if desc and desc.omniabiName then omniabiName.editBox:SetText(desc.omniabiName); end
		ui:InsertFrame(omniabiName);
		
		--[[local srchStr = VFLUI.LabeledEdit:new(ui, 200); srchStr:Show();
		srchStr:SetText("Find message: ");
		if desc and desc.srchStr then srchStr.editBox:SetText(desc.srchStr); end
		ui:InsertFrame(srchStr);]]
		
		local devent, lockout, rpc = GenerateEventDispatchUI(desc, ui, VFLI.i18n("If message found, Dispatch Event:"))		

		function ui:GetDescriptor()
			return {
				feature = "Event: Omniscience"; 
				bevent = bevent.editBox:GetText();
				omnirow = dd_rowType:GetSelection();
				omniabiID = omniabiID.editBox:GetText();
				omniabiName = omniabiName.editBox:GetText();
				devent = devent.editBox:GetText();
				lockout = lockout.editBox:GetText();
				rpc = rpc:GetChecked();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Event: Omniscience", bevent = "OMNI"}; end
});

RDX.RegisterFeature({
	name = "Event: Scripted",
	category = VFLI.i18n("Events");
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
		
		if not desc.devent or desc.devent == "" then 
			VFL.AddError(errs, VFLI.i18n("You must dispatch an event"));
			return false;
		end
		
		state:AddSlot("BossmodScriptedEvent");
		return true;
	end;
	ApplyFeature = function(desc, state)
		desc.lualogic = desc.lualogic or "";
		local events = "WoWEvents";
		if RDXBM.EventIsLocal(desc.bevent, state) then events = "BossmodEvents"; end	
		state.Code:AppendCode([[
		BossmodEvents:Bind("ACTIVATE", nil, function()
			local bfunc = loadstring(]] .. string.format("%q", desc.lualogic) .. [[);
		]]..events..[[:Bind("]]..desc.bevent..[[", nil, function()
			if bfunc() then
				local sent = BossmodEvents:LatchedDispatch(]]..desc.lockout..[[, "]]..desc.devent..[[");
		]]);
		if desc.rpc then
		state.Code:AppendCode([[
				if sent then RPC.Invoke(encid, "]]..desc.devent..[["); end
		]]); end
		state.Code:AppendCode([[
			end
		end, encid);
		end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		
		local bevent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Bind to event:"))
		if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
		ui:InsertFrame(bevent);
		
		local lualogic = VFLUI.TextEditor:new(ui); lualogic:Show();
		lualogic:SetText(VFLI.i18n("-- This lua block is evaluated as a boolean function, the event fires if it returns true"));
		lualogic:SetWidth(400); lualogic:SetHeight(200);
		if desc and desc.lualogic then lualogic:SetText(desc.lualogic); end
		ui:InsertFrame(lualogic);
		
		local devent, lockout, rpc = GenerateEventDispatchUI(desc, ui, VFLI.i18n("If true, Dispatch Event:"))		

		function ui:GetDescriptor()
			return {
				feature = "Event: Scripted"; 
				bevent = bevent.editBox:GetText();
				lualogic = lualogic:GetText();
				devent = devent.editBox:GetText();
				lockout = lockout.editBox:GetText();
				rpc = rpc:GetChecked();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Event: Scripted"}; end
});


RDX.RegisterFeature({
	name = "Custom Script",
	category = VFLI.i18n("Uncategorized");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc or not desc.lualogic then return nil; end
		return true;
	end;
	ApplyFeature = function(desc, state)
		state.Code:AppendCode(desc.lualogic);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local lualogic = VFLUI.TextEditor:new(ui); lualogic:Show();
		lualogic:SetText([[
-- This lua block is run when the features are applied, in list order
-- If you bind any events/RPCs, use the id 'encid' (variable)
-- First arg of RPC can be a BossmodEvent event name
-- To use any bossmod events, use the handle BossmodEvents
-- Remember to bind/unbind WoW/RDXEvents on ACTIVATE/DEACTIVATE
-- These are special handles and variables handled by the bossmod engine
]]);
		lualogic:SetWidth(400); lualogic:SetHeight(350);
		if desc and desc.lualogic then lualogic:SetText(desc.lualogic); end
		ui:InsertFrame(lualogic);

		function ui:GetDescriptor()
			return {
				feature = "Custom Script"; 
				lualogic = lualogic:GetText();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Custom Script"}; end
});

RDX.RegisterFeature({
	name = "bm_timer"; title = VFLI.i18n("Timer"); category = VFLI.i18n("Events"); version = 1;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if type(desc) ~= "table" then return nil; end
		if type(desc.bevent) ~= "string" then return nil; end
		if type(desc.devent) ~= "string" then return nil; end
		local n = tonumber(desc.delay); if type(n) ~= "number" then return nil; end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local delay = 0; if desc.delay then delay = tonumber(desc.delay); end
		
		local id = RDXBM.GetUniqueAlertID();

		local events = "WoWEvents";
		if RDXBM.EventIsLocal(desc.bevent, state) then events = "BossmodEvents"; end
		state.Code:AppendCode([[
]] .. events .. [[:Bind(]] .. string.format("%q", desc.bevent) .. [[, nil, function() ]]);
		if delay > 0 then
			state.Code:AppendCode([[
VFLT.scheduleNamed("bm]] .. id .. '", ' .. delay .. [[, BossmodEvents.Dispatch, BossmodEvents, ]] .. string.format("%q", desc.devent) .. ");");
		else
			state.Code:AppendCode([[
BossmodEvents:Dispatch(]] .. string.format("%q", desc.devent) .. ");");
		end
		state.Code:AppendCode([[
end, encid);
BossmodEvents:Bind("STOP", nil, function() VFLT.UnscheduleByName("bm]] .. id .. [["); end, encid);
]]);

		return true;
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
	
		local bevent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Bind to event:")); 
		if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
		ui:InsertFrame(bevent);
	
		local delay = VFLUI.LabeledEdit:new(ui, 50); delay:Show();
		delay:SetText(VFLI.i18n("Wait time (sec) (0 = instant trigger)"));
		if desc and desc.delay then delay.editBox:SetText(desc.delay); end
		ui:InsertFrame(delay);

		local devent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Then fire event:"));
		if desc and desc.devent then devent.editBox:SetText(desc.devent); end
		ui:InsertFrame(devent);

		function ui:GetDescriptor()
			return {
				feature = "bm_timer"; version = 1;
				bevent = bevent.editBox:GetText();
				delay = tonumber(delay.editBox:GetText());
				devent = devent.editBox:GetText();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "bm_timer"; version = 1; delay = 0;
		}; 
	end
});

RDX.RegisterFeature({
	name = "bm_event_hpp"; title = VFLI.i18n("Event: HP%"); category = VFLI.i18n("Events"); version = 1;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		if not tonumber(desc.hp) then 
			VFL.AddError(errs, VFLI.i18n("You must specify a trigger HP percentage.")); return false;
		end
		
		if not tonumber(desc.hp_reset) then 
			VFL.AddError(errs, VFLI.i18n("You must specify a reset HP.")); return false;
		end

		if tonumber(desc.hp_reset) < tonumber(desc.hp) then 
			VFL.AddError(errs, VFLI.i18n("Reset HP must be higher than trigger.")); return false;
		end
		
		if not desc.devent or desc.devent == "" then
			VFL.AddError(errs, VFLI.i18n("You must dispatch an event"));	return false;
		end

		return true;
	end;
	ApplyFeature = function(desc, state)
		local hp = 0; if desc.hp then hp = tonumber(desc.hp); end
		local hp_reset = 100; if desc.hp_reset then hp_reset = tonumber(desc.hp_reset); end
	
		state.Code:AppendCode([[
			BossmodEvents:Bind("START", nil, function()
				if not track then return; end
				local hp_latch = true;
				track.sigTrace:Connect(nil, function(trk)
					local hp = ((UnitHealth(trk:First()) / UnitHealthMax(trk:First())) * 100);
					if hp_latch and (hp <= ]] .. hp .. [[) then
						BossmodEvents:Dispatch(]] .. string.format("%q", desc.devent) .. [[);
						hp_latch = false;
					elseif (not hp_latch) and (hp >= ]] .. hp_reset .. [[) then
						hp_latch = true;
					end;
				end, encid .. "_track_hp");
			end, encid);
			
			BossmodEvents:Bind("STOP", nil, function()
				if not track then return; end
			  track.sigTrace:DisconnectByID(encid .. "_track_hp");
			end, encid);
		]]);
		return true;
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
				
		local hpTriggerBox = VFLUI.LabeledEdit:new(ui, 50); hpTriggerBox:Show();
		hpTriggerBox:SetText(VFLI.i18n("HP% to trigger event: "));
		if desc and desc.hp then hpTriggerBox.editBox:SetText(desc.hp); end
		ui:InsertFrame(hpTriggerBox);

		local hpResetBox = VFLUI.LabeledEdit:new(ui, 50); hpResetBox:Show();
		hpResetBox:SetText(VFLI.i18n("HP% to reset trigger:"));
		if desc and desc.hp_reset then hpResetBox.editBox:SetText(desc.hp_reset); end
		ui:InsertFrame(hpResetBox);
		
		local devent = RDXBM.CreateEventEdit(ui, VFLI.i18n("When enemy's HP% drops, fire event:"))
		if desc and desc.devent then devent.editBox:SetText(desc.devent); end
		ui:InsertFrame(devent);

		function ui:GetDescriptor()
			return {
				feature = "bm_event_hpp"; version = 1;
				hp = hpTriggerBox.editBox:GetText();
				hp_reset = hpResetBox.editBox:GetText();
				devent = devent.editBox:GetText();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() 
		return { feature = "bm_event_hpp"; version = 1; hp = "20";	hp_reset = "100"; }; 
	end
});

RDX.RegisterFeature({
	name = "bm_event_mpp"; title = VFLI.i18n("Event: Mana%"); category = VFLI.i18n("Events"); version = 1;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		if not tonumber(desc.mp) then 
			VFL.AddError(errs, VFLI.i18n("You must specify a trigger mana percentage.")); return false;
		end
		
		if not tonumber(desc.mp_reset) then 
			VFL.AddError(errs, VFLI.i18n("You must specify a reset mana percentage.")); return false;
		end

		if tonumber(desc.mp_reset) < tonumber(desc.mp) then 
			VFL.AddError(errs, VFLI.i18n("Reset mana must be higher than trigger."));
			return false;
		end
		
		if not desc.devent or desc.devent == "" then
			VFL.AddError(errs, VFLI.i18n("You must dispatch an event"));
			return false;
		end

		return true;
	end;
	ApplyFeature = function(desc, state)
		local mp = 0; if desc.mp then mp = tonumber(desc.mp); end
		local mp_reset = 100; if desc.mp_reset then mp_reset = tonumber(desc.mp_reset); end
	
		state.Code:AppendCode([[
			BossmodEvents:Bind("START", nil, function()
				if not track then return; end
				local mp_latch = true;
				track.sigTrace:Connect(nil, function(trk)
					local tf = trk:First();	if UnitManaMax(tf) < 1 then return; end
				  local mp = UnitMana(tf) / UnitManaMax(tf) * 100;
					if mp_latch and (mp <= ]] .. mp .. [[) then
						BossmodEvents:Dispatch("]] .. desc.devent .. [[");
						mp_latch = false;
					elseif (not mp_latch) and (mp >= ]] .. mp_reset .. [[) then
						mp_latch = true;
					end;
				end, encid .. "_track_mp");
			end, encid);
			
			BossmodEvents:Bind("STOP", nil, function()
				if not track then return; end
			  track.sigTrace:DisconnectByID(encid .. "_track_mp");
			end, encid);
		]]);

		return true;
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
				
		local mpTriggerBox = VFLUI.LabeledEdit:new(ui, 50); mpTriggerBox:Show();
		mpTriggerBox:SetText(VFLI.i18n("Mana percent to trigger event: "));
		if desc and desc.mp then mpTriggerBox.editBox:SetText(desc.mp); end
		ui:InsertFrame(mpTriggerBox);

		local mpResetBox = VFLUI.LabeledEdit:new(ui, 50); mpResetBox:Show();
		mpResetBox:SetText(VFLI.i18n("Mana percent to reset trigger:"));
		if desc and desc.mp_reset then mpResetBox.editBox:SetText(desc.mp_reset); end
		ui:InsertFrame(mpResetBox);
		
		local devent = RDXBM.CreateEventEdit(ui, VFLI.i18n("When enemy's mana drops, fire event:"))
		if desc and desc.devent then devent.editBox:SetText(desc.devent); end
		ui:InsertFrame(devent);

		function ui:GetDescriptor()
			return {
				feature = "bm_event_mpp"; version = 1;
				mp = mpTriggerBox.editBox:GetText();
				mp_reset = mpResetBox.editBox:GetText();
				devent = devent.editBox:GetText();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() 
		return { feature = "bm_event_mpp"; version = 1; mp = "20"; mp_reset = "100"; }; 
	end
});

