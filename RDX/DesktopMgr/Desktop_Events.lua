-- Desktop_Events.lua
-- OpenRDX

function RDXDK._GetEventCache()
	local db = {};
	local dkState = RDXDK._GetdkState();
	for feat,desc in ipairs(dkState.features) do
		if desc.devent and desc.devent ~= "" then
			if VFL.vfind(db, desc.devent) == nil then
				table.insert(db, desc.devent);
			end
		end
		if desc.odevent and desc.odevent ~= "" then
			if VFL.vfind(db, desc.odevent) == nil then
				table.insert(db, desc.odevent);
			end
		end
	end
--	table.insert(db, "ACTIVATE") this can't really be used by non-script objects
	--if dkState:Slot("BasicEvents") then
	--	table.insert(db, "MSG");
	--	table.insert(db, "OMNI");
	--end
	return db;
end

local DesktopID = 1500
function RDXDK.GetUniqueID()
	DesktopID = DesktopID + 1;
	return DesktopID;
end

local function GenerateEventDispatchUI(desc, ui, txt)
	local devent = VFLUI.CreateElementEdit(ui, txt, RDXDK._GetEventCache)
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

local msgEvents = {
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_WHISPER",
	"CHAT_MSG_MONSTER_YELL",
	-- "CHAT_MSG_SAY", good for debugging
};

RDX.RegisterFeature({
	name = "DesktopEventChat",
	title = "DesktopEvent: Chat",
	category = "Events";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if not state:Slot("Desktop main") then return nil; end
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
		return true;
	end;
	ApplyFeature = function(desc, state)
		desc.srchStr = desc.srchStr or "";
		
		state.Code:AppendCode([[
		DesktopEvents:Bind("DESKTOP_ACTIVATE", nil, function()
		WoWEvents:Bind("]]..desc.bevent..[[", nil, function(arg1)
			if arg1:match("]]..desc.srchStr..[[") then
				local sent = DesktopEvents:LatchedDispatch(]]..desc.lockout..[[, "]]..desc.devent..[[");
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
		
		local bevent = VFLUI.CreateElementEdit(ui, VFLI.i18n("Bind to event:"), msgEvents)
		if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
		ui:InsertFrame(bevent);
		
		local srchStr = VFLUI.LabeledEdit:new(ui, 200); srchStr:Show();
		srchStr:SetText("Find message:");
		if desc and desc.srchStr then srchStr.editBox:SetText(desc.srchStr); end
		ui:InsertFrame(srchStr);
		
		local devent, lockout, rpc = GenerateEventDispatchUI(desc, ui, VFLI.i18n("If message found, Dispatch Event:"))		

		function ui:GetDescriptor()
			return {
				feature = "DesktopEventChat"; 
				bevent = bevent.editBox:GetText();
				srchStr = srchStr.editBox:GetText();
				devent = devent.editBox:GetText();
				lockout = lockout.editBox:GetText();
				rpc = rpc:GetChecked();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "DesktopEventChat"}; end
});

local unitEvents = {
	"UNIT_COMBAT",
};

RDX.RegisterFeature({
	name = "DesktopEventUnit",
	title = "DesktopEvent: Unit",
	category = "Events";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if not state:Slot("Desktop main") then return nil; end
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
		return true;
	end;
	ApplyFeature = function(desc, state)
		desc.srchStr = desc.srchStr or "";
		
		state.Code:AppendCode([[
		DesktopEvents:Bind("DESKTOP_ACTIVATE", nil, function()
		WoWEvents:Bind("]]..desc.bevent..[[", nil, function(arg1)
			--if arg1:match("]]..desc.srchStr..[[") then
				local sent = DesktopEvents:LatchedDispatch(]]..desc.lockout..[[, "]]..desc.devent..[[");
		]]);
		if desc.rpc then
		state.Code:AppendCode([[
				if sent then RPC.Invoke(encid, "]]..desc.devent..[["); end
		]]); end
		state.Code:AppendCode([[
			--end
		end, encid);
		end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local bevent = VFLUI.CreateElementEdit(ui, VFLI.i18n("Bind to event:"), msgEvents)
		if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
		ui:InsertFrame(bevent);
		
		local devent, lockout, rpc = GenerateEventDispatchUI(desc, ui, VFLI.i18n("If event, Dispatch Event:"))		

		function ui:GetDescriptor()
			return {
				feature = "DesktopEventUnit"; 
				bevent = bevent.editBox:GetText();
				devent = devent.editBox:GetText();
				lockout = lockout.editBox:GetText();
				rpc = rpc:GetChecked();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "DesktopEventUnit"}; end
});


RDX.RegisterFeature({
	name = "DesktopEventRDXSet",
	title = "DesktopEvent: RDX Set",
	category = "Events";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if not state:Slot("Desktop main") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		if not desc.set then 
			VFL.AddError(errs, VFLI.i18n("You must select a RDX Set"));
			return false;
		end
		if not desc.devent or desc.devent == "" then 
			VFL.AddError(errs, VFLI.i18n("You must dispatch an event for if in set"));
			return false;
		end
		if not desc.odevent or desc.odevent == "" then 
			VFL.AddError(errs, VFLI.i18n("You must dispatch an event for if not in set"));
			return false;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		
		local id = RDXDK.GetUniqueID();
		
		state.Code:AppendCode([[
		
		local set]] .. id ..[[ = RDXDAL.FindSet(]].. Serialize(desc.set) .. [[);
		local setObject]] .. id ..[[ = {};
		local Check]] .. id ..[[ = function()
			if (set]] .. id ..[[:GetSetSize() > 0) then
				DesktopEvents:Dispatch("]]..desc.devent..[[");
			else
				DesktopEvents:Dispatch("]]..desc.odevent..[[");
			end
		end
		
		DesktopEvents:Bind("DESKTOP_ACTIVATE", nil, function()
			set]] .. id ..[[:ConnectDelta(setObject]] .. id ..[[, Check]] .. id ..[[);
		end, encid);
		
		DesktopEvents:Bind("DESKTOP_DEACTIVATE", nil, function()
			set:RemoveDelta(setObject]] .. id ..[[);
			setObject]] .. id ..[[ = nil;
			Check]] .. id ..[[ = nil;
		end, encid);
		
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local setsel = RDXDAL.SetFinder:new(ui); setsel:Show();
		if desc.set then setsel:SetDescriptor(desc.set); end
		ui:InsertFrame(setsel);
		
		local devent = VFLUI.CreateElementEdit(ui, VFLI.i18n("If in Set Dispatch Event:"), RDXDK._GetEventCache())
		if desc and desc.devent then devent.editBox:SetText(desc.devent); end
		ui:InsertFrame(devent);
		
		local odevent = VFLUI.CreateElementEdit(ui, VFLI.i18n("If not in Set Dispatch Event"), RDXDK._GetEventCache())
		if desc and desc.odevent then odevent.editBox:SetText(desc.odevent); end
		ui:InsertFrame(odevent);
		
		function ui:GetDescriptor()
			return {
				feature = "DesktopEventRDXSet"; 
				set = setsel:GetDescriptor();
				devent = devent.editBox:GetText();
				odevent = odevent.editBox:GetText();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "DesktopEventRDXSet"}; end
});

