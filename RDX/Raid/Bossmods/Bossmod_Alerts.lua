-- Bossmod_Alerts.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- Alert features for Bossmod objects.

local strformat = string.format;

------------------------------------------------------------------------
-- GUI Bossmods module for RDX
--   By: Trevor Madsen (Gibypri, Kilrogg realm), Sigg Rashgarroth
--
-- Note:
--  Licensed exclusively to Raid Informatics
------------------------------------------------------------------------

local function PreviewDropdown(desc)
	if not desc.title then return false; end
	RDX.Alert.Dropdown("bm_test", VFLI.i18n(desc.title), tonumber(desc.totaltime), tonumber(desc.sTime), desc.sound, desc.fstColor, desc.scdColor, desc.spam);
end

local function PreviewCenterPopup(desc)
	if not desc.title then return false; end
	RDX.Alert.CenterPopup("bm_test", VFLI.i18n(desc.title), tonumber(desc.totaltime), desc.sound, tonumber(desc.sTime), desc.fstColor, desc.scdColor, desc.spam);
end

local function PreviewSimple(desc)
	if not desc.title then return false; end
	RDX.Alert.Simple(VFLI.i18n(desc.title), desc.sound, tonumber(desc.totaltime), desc.spam)
end

local _icontypes = {
	{ text = "Yellow 4 point Star" },
	{ text = "Orange Circle" },
	{ text = "Purple Diamond" },
	{ text = "Green Triangle" },
	{ text = "White Crescent Moon" },
	{ text = "Blue Square" },
	{ text = "Red X Cross" },
	{ text = "White Skull" },
};
local function _dd_icontypes() return _icontypes; end

local _icontable = {};
_icontable[1] = "Yellow 4 point Star";
_icontable[2] = "Orange Circle";
_icontable[3] = "Purple Diamond";
_icontable[4] = "Green Triangle";
_icontable[5] = "White Crescent Moon";
_icontable[6] = "Blue Square";
_icontable[7] = "Red X Cross";
_icontable[8] = "White Skull";

local _icontableToID = VFL.invert(_icontable);

local function GenerateAlertDescripterUI(desc, parent, type)
	local ui = VFLUI.CompoundFrame:new(parent);
	
	local bevent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Bind to event")); 
	if desc and desc.bevent then bevent.editBox:SetText(desc.bevent); end
	ui:InsertFrame(bevent);
	
	local delay = VFLUI.LabeledEdit:new(ui, 50); delay:Show();
	delay:SetText(VFLI.i18n("Scheduled Delay (seconds)"));
	if desc and desc.delay then delay.editBox:SetText(desc.delay); end
	ui:InsertFrame(delay);
	
	local title, chkSource, chkTarget, rg_icon, er, dd_iconType;
	if not (type == "Icon") then
	
		title = VFLUI.LabeledEdit:new(ui, 200); title:Show();
		title:SetText(VFLI.i18n("Alert Text"));
		if desc and desc.title then title.editBox:SetText(desc.title); end
		ui:InsertFrame(title);
		
		chkSource = VFLUI.Checkbox:new(ui);
		chkSource:SetHeight(25); chkSource:SetWidth(135);
		if desc and desc.s then chkSource:SetChecked(true); else chkSource:SetChecked(); end
		chkSource:SetText(VFLI.i18n("Add source name as prefix in Alert Text")); chkSource:Show();
		ui:InsertFrame(chkSource);
	
		chkTarget = VFLUI.Checkbox:new(ui);
		chkTarget:SetHeight(25); chkTarget:SetWidth(135);
		if desc and desc.t then chkTarget:SetChecked(true); else chkTarget:SetChecked(); end
		chkTarget:SetText(VFLI.i18n("Add target name as prefix in Alert Text")); chkTarget:Show();
		ui:InsertFrame(chkTarget);
	else
		er = VFLUI.EmbedRight(ui, VFLI.i18n("ICON Type:"));
		dd_iconType = VFLUI.Dropdown:new(er, _dd_icontypes);
		dd_iconType:SetWidth(150); dd_iconType:Show();
		if desc and desc.iconType then 
			dd_iconType:SetSelection(desc.iconType); 
		else
			dd_iconType:SetSelection("White Skull");
		end
		er:EmbedChild(dd_iconType); er:Show();
		ui:InsertFrame(er);
		
		rg_icon = VFLUI.RadioGroup:new(ui); 
		rg_icon:Show();
		rg_icon:SetLayout(2,2);
		rg_icon.buttons[1]:SetText(VFLI.i18n("Source")); rg_icon.buttons[2]:SetText(VFLI.i18n("Target"));
		rg_icon:SetValue(1);
		if desc and desc.icon == "TARGET" then rg_icon:SetValue(2); end
		ui:InsertFrame(rg_icon);
	end
	
	local totaltime = VFLUI.LabeledEdit:new(ui, 50); totaltime:Show();
	totaltime:SetText(VFLI.i18n("Total Time (seconds)"));
	if desc and desc.totaltime then totaltime.editBox:SetText(desc.totaltime); end
	ui:InsertFrame(totaltime);
	
	local sTime;
	if (type == "CenterPopup") or (type == "Dropdown") then
			local typeStr = "Dropdown"
			if type == "CenterPopup" then typeStr = "Flash"; end
		sTime = VFLUI.LabeledEdit:new(ui, 50); sTime:Show();
		sTime:SetText(typeStr..VFLI.i18n(" Time (seconds)"));
		if desc and desc.sTime then sTime.editBox:SetText(desc.sTime); end
		ui:InsertFrame(sTime);
	end

	local er = VFLUI.EmbedRight(ui, VFLI.i18n("Sound"));
	local sound = VFLUI.MakeSoundSelectButton(er, desc.sound); sound:Show();
	er:EmbedChild(sound); er:Show();
	ui:InsertFrame(er);
	
	local fstColor, scdColor;
	if (type == "CenterPopup") or (type == "Dropdown") then
		fstColor = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("First Flash Color"));
		if desc and desc.fstColor then fstColor:SetColor(VFL.explodeRGBA(desc.fstColor)); end
		
		scdColor = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Second Flash Color"));
		if desc and desc.scdColor then scdColor:SetColor(VFL.explodeRGBA(desc.scdColor)); end
	end
	
	local quashevent;
	if (type == "CenterPopup") or (type == "Dropdown") then
		quashevent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Secondary Quash Event (STOP is primary)"));
		if desc and desc.quashevent then quashevent.editBox:SetText(desc.quashevent); end
		ui:InsertFrame(quashevent);
	end
	
	local devent, chkSpam, chkQuash, btnSPreview, btnPreview;
	if not (type == "Icon") then
		devent = RDXBM.CreateEventEdit(ui, VFLI.i18n("Dispatch event on alert COMPLETION"));
		if desc and desc.devent then devent.editBox:SetText(desc.devent); end
		ui:InsertFrame(devent);	
	
		chkSpam = VFLUI.Checkbox:new(ui);
		chkSpam:SetHeight(25); chkSpam:SetWidth(135);
		chkSpam:SetPoint("TOPRIGHT", devent, "BOTTOMRIGHT");
		if desc and desc.spam then chkSpam:SetChecked(desc.spam); end
		chkSpam:SetText(VFLI.i18n("Supress Announce Spam")); chkSpam:Show();
	
		chkQuash = VFLUI.Checkbox:new(ui);
		chkQuash:SetHeight(25); chkQuash:SetWidth(120);
		chkQuash:SetPoint("RIGHT", chkSpam, "LEFT");
		if desc and desc.selfquash then chkQuash:SetChecked(desc.selfquash); end
		chkQuash:SetText(VFLI.i18n("Quash Old Duplicates")); chkQuash:Show();

		btnSPreview = VFLUI.Button:new(ui);
		btnSPreview:SetHeight(25); btnSPreview:SetWidth(85);
		btnSPreview:SetPoint("TOPRIGHT", chkSpam, "BOTTOMRIGHT");
		btnSPreview:SetText(VFLI.i18n("Stop Preview")); btnSPreview:Show();
		btnSPreview:SetScript("OnClick", function() RDX.QuashAlertsByPattern("^bm_test"); end);
		
		btnPreview = VFLUI.Button:new(ui);
		btnPreview:SetHeight(25); btnPreview:SetWidth(85);
		btnPreview:SetPoint("TOPRIGHT", btnSPreview, "TOPLEFT");
		btnPreview:SetText(VFLI.i18n("Preview Alert")); btnPreview:Show();
			local func = PreviewDropdown;
			if type == "CenterPopup" then func = PreviewCenterPopup; end
			if type == "Simple" then func = PreviewSimple; end
		btnPreview:SetScript("OnClick", function() func(ui:GetDescriptor()); end);
	end
	
	if type == "Simple" then
		function ui:GetDescriptor()
			return {
				feature = "Alert: Simple";
				bevent = bevent.editBox:GetText();
				delay = delay.editBox:GetText();
				title = title.editBox:GetText();
				s = chkSource:GetChecked();
				t = chkTarget:GetChecked();
				totaltime = totaltime.editBox:GetText();
				sound = sound:GetSelectedSound();
				devent = devent.editBox:GetText();
				spam = chkSpam:GetChecked();
				selfquash = chkQuash:GetChecked();
			};
		end
	elseif type == "Icon" then
		function ui:GetDescriptor()
			local icon = "SOURCE";
			if rg_icon:GetValue() == 2 then icon = "TARGET"; end
			return {
				feature = "Alert: Icon";
				bevent = bevent.editBox:GetText();
				delay = delay.editBox:GetText();
				iconType = dd_iconType:GetSelection();
				icon = icon;
				totaltime = totaltime.editBox:GetText();
				sound = sound:GetSelectedSound();
			};
		end
	else
		local descStr = "Alert: Dropdown";
		if type == "CenterPopup" then descStr = "Alert: CenterPopup"; end
	
		function ui:GetDescriptor()
			return {
				feature = descStr; 
				bevent = bevent.editBox:GetText();
				delay = delay.editBox:GetText();
				title = title.editBox:GetText();
				s = chkSource:GetChecked();
				t = chkTarget:GetChecked();
				totaltime = totaltime.editBox:GetText();
				sTime = sTime.editBox:GetText();
				sound = sound:GetSelectedSound();
				fstColor = fstColor:GetColor();
				scdColor = scdColor:GetColor();
				devent = devent.editBox:GetText();
				quashevent = quashevent.editBox:GetText();
				spam = chkSpam:GetChecked();
				selfquash = chkQuash:GetChecked();
			};
		end
	end
		
	ui.Destroy = VFL.hook(function(s)
		if not (type == "Icon") then
			btnPreview:Destroy(); btnPreview = nil;
			btnSPreview:Destroy(); btnSPreview = nil;
			chkSpam:Destroy(); chkSpam = nil;
			chkQuash:Destroy(); chkQuash = nil;
		end
	end, ui.Destroy);
	
	return ui;
end
	

RDX.RegisterFeature({
	name = "Alert: Dropdown",
	category = VFLI.i18n("Alerts");
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
		elseif not tonumber(desc.totaltime) or not tonumber(desc.sTime) then
			VFL.AddError(errs, VFLI.i18n("Time fields must be a number or a representation of a number"))
			return false;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- make sure sound and alert txt fields are valid
		desc.title = desc.title or "";
		desc.sound = desc.sound or "";
		
		-- delay needs to be a number
		if not desc.delay or not tonumber(desc.delay) then
			desc.delay = 0;
		end
		
		local descs, desct = "false", "false";
		if desc.s then descs = "true"; end
		if desc.t then desct = "true"; end

		local id = RDXBM.GetUniqueAlertID();
		local spam = "false";
		if desc.spam then spam = "true"; end
		local events = "WoWEvents";
		if RDXBM.EventIsLocal(desc.bevent, state) then events = "BossmodEvents"; end	
		state.Code:AppendCode([[
		]]..events..[[:Bind("]]..desc.bevent..[[", nil, function(source, sourceguid, target, targetguid)
			if not source then source = "No source"; end
			if not target then target = "No target"; end
			local delay, totaltime, dropdown, spam = ]]..desc.delay..[[,]]..desc.totaltime..[[,]]..desc.sTime..[[,]]..spam..[[;
			local sound, fstcolor, scdcolor = ]]..strformat("%q", desc.sound)..[[,]].. Serialize(desc.fstColor)..[[,]].. Serialize(desc.scdColor)..[[;
			local title = "";
			if ]].. descs ..[[ then title = source .. " || ]]..desc.title..[[";
			elseif ]].. desct ..[[ then title = target .. " || ]]..desc.title..[[";
			else title = "]]..desc.title..[[";
			end
		]]);
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
			VFLT.scheduleNamed("bm]]..id..[[", tonumber(delay), function()
		]]); end
		
		if desc.selfquash then
			state.Code:AppendCode([[
				RDX.QuashAlertsByPattern("^bm]]..id..[[");
			]]);
			if desc.devent and desc.devent ~= "" then
				state.Code:AppendCode([[
				VFLT.UnscheduleByName("bm]]..id..[[");
				]]); end; end;
				
		state.Code:AppendCode([[
				RDX.Alert.Dropdown("bm]]..id..[[", VFLI.i18n(title), tonumber(totaltime), tonumber(dropdown), sound, fstcolor, scdcolor, spam);
		]]);
		if desc.devent and desc.devent ~= "" then
		state.Code:AppendCode([[
				VFLT.scheduleNamed("bm]]..id..[[", tonumber(totaltime), function() 
					BossmodEvents:Dispatch("]]..desc.devent..[[");
				end)
		]]); end
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
				end); -- end schedule
		]]); end
		state.Code:AppendCode([[
		end, encid); -- event
		]]);
		if desc.quashevent and desc.quashevent ~= "" then
			local qevents = "WoWEvents";
			if RDXBM.EventIsLocal(desc.quashevent, state) then qevents = "BossmodEvents"; end
			state.Code:AppendCode([[
				]]..qevents..[[:Bind("]]..desc.quashevent..[[", nil, function()
					RDX.QuashAlertsByPattern("^bm]]..id..[[")
				]]);
			if desc.devent and desc.devent ~= "" then
				state.Code:AppendCode([[
					VFLT.UnscheduleByName("bm]]..id..[[");
				]]); end;
			state.Code:AppendCode([[
				end, encid);
			]]);
		end;
		
		state.Code:AppendCode([[
			BossmodEvents:Bind("STOP", nil, function()
				VFLT.UnscheduleByName("bm]]..id..[[");
			end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		return GenerateAlertDescripterUI(desc, parent, "Dropdown");
	end,
	CreateDescriptor = function() return {feature = "Alert: Dropdown"}; end
});

RDX.RegisterFeature({
	name = "Alert: CenterPopup",
	category = VFLI.i18n("Alerts");
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
		elseif not tonumber(desc.totaltime) or not tonumber(desc.sTime) then
			VFL.AddError(errs, VFLI.i18n("Time fields must be a number or a representation of a number"))
			return false;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- make sure sound and alert txt fields are valid
		desc.title = desc.title or "";
		desc.sound = desc.sound or "";
		
		-- delay needs to be a number
		if not desc.delay or not tonumber(desc.delay) then
			desc.delay = 0;
		end
		
		local descs, desct = "false", "false";
		if desc.s then descs = "true"; end
		if desc.t then desct = "true"; end
		
		local id = RDXBM.GetUniqueAlertID();
		local spam = "false";
		if desc.spam then spam = "true"; end
		local events = "WoWEvents";
		if RDXBM.EventIsLocal(desc.bevent, state) then events = "BossmodEvents"; end	
		state.Code:AppendCode([[
		]]..events..[[:Bind("]]..desc.bevent..[[", nil, function(source, sourceguid, target, targetguid)
			if not source then source = "No source"; end
			if not target then target = "No target"; end
			local delay, totaltime, flash, spam = ]]..desc.delay..[[,]]..desc.totaltime..[[,]]..desc.sTime..[[,]]..spam..[[;
			local sound, fstcolor, scdcolor = ]]..strformat("%q", desc.sound)..[[,]].. Serialize(desc.fstColor)..[[,]].. Serialize(desc.scdColor)..[[;
			local title = "]]..desc.title..[[";
			if ]].. desct ..[[ then title = target .. " || " .. title; end
			if ]].. descs ..[[ then title = source .. " || " .. title; end
		]]);
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
			VFLT.scheduleNamed("bm]]..id..[[", tonumber(delay), function()
		]]); end
		
		if desc.selfquash then
			state.Code:AppendCode([[
				RDX.QuashAlertsByPattern("^bm]]..id..[[");
			]]);
			if desc.devent and desc.devent ~= "" then
				state.Code:AppendCode([[
				VFLT.UnscheduleByName("bm]]..id..[[");
				]]); end; end;
		state.Code:AppendCode([[
				RDX.Alert.CenterPopup("bm]]..id..[[", VFLI.i18n(title), tonumber(totaltime), sound, tonumber(flash), fstcolor, scdcolor, spam);
		]]);
		if desc.devent and desc.devent ~= "" then
		state.Code:AppendCode([[
				VFLT.scheduleNamed("bm]]..id..[[", tonumber(totaltime), function() 
					BossmodEvents:Dispatch("]]..desc.devent..[[");
				end)
		]]); end
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
				end); -- end schedule
		]]); end
		state.Code:AppendCode([[
		end, encid); -- event
		]]);
		if desc.quashevent and desc.quashevent ~= "" then
			local qevents = "WoWEvents";
			if RDXBM.EventIsLocal(desc.quashevent, state) then qevents = "BossmodEvents"; end
			state.Code:AppendCode([[
				]]..qevents..[[:Bind("]]..desc.quashevent..[[", nil, function()
					RDX.QuashAlertsByPattern("^bm]]..id..[[")
				]]);
			if desc.devent and desc.devent ~= "" then
				state.Code:AppendCode([[
					VFLT.UnscheduleByName("bm]]..id..[[");
				]]); end;
			state.Code:AppendCode([[
				end, encid);
			]]);
		end;
		
		state.Code:AppendCode([[
			BossmodEvents:Bind("STOP", nil, function()
				VFLT.UnscheduleByName("bm]]..id..[[");
			end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		return GenerateAlertDescripterUI(desc, parent, "CenterPopup");
	end,
	CreateDescriptor = function() return {feature = "Alert: CenterPopup"}; end
});

--RDX.Alert.Simple(text, sound, persist, suppressSpam)
RDX.RegisterFeature({
	name = "Alert: Simple",
	category = VFLI.i18n("Alerts");
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
		elseif not tonumber(desc.totaltime) then
			VFL.AddError(errs, VFLI.i18n("Time fields must be a number or a representation of a number"))
			return false;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- make sure sound and alert txt fields are valid
		desc.title = desc.title or "";
		desc.sound = desc.sound or "";
		
		-- delay needs to be a number
		if not desc.delay or not tonumber(desc.delay) then
			desc.delay = 0;
		end
		
		local descs, desct = "false", "false";
		if desc.s then descs = "true"; end
		if desc.t then desct = "true"; end
		
		local id = RDXBM.GetUniqueAlertID();
		local spam = "false";
		if desc.spam then spam = "true"; end
		local events = "WoWEvents";
		if RDXBM.EventIsLocal(desc.bevent, state) then events = "BossmodEvents"; end	
		state.Code:AppendCode([[
		]]..events..[[:Bind("]]..desc.bevent..[[", nil, function(source, sourceguid, target, targetguid)
			if not source then source = "No source"; end
			if not target then target = "No target"; end
			local delay, totaltime, spam = ]]..desc.delay..[[,]]..desc.totaltime..[[,]]..spam..[[;
			local sound = ]]..strformat("%q", desc.sound)..[[;
			local title = "]]..desc.title..[[";
			if ]].. desct ..[[ then title = target .. " || " .. title; end
			if ]].. descs ..[[ then title = source .. " || " .. title; end
		]]);
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
			VFLT.scheduleNamed("bm]]..id..[[", tonumber(delay), function()
		]]); end
		
		if desc.selfquash then
			state.Code:AppendCode([[
				RDX.QuashAlertsByPattern("^bm]]..id..[[");
			]]);
			if desc.devent and desc.devent ~= "" then
				state.Code:AppendCode([[
				VFLT.UnscheduleByName("bm]]..id..[[");
				]]); end; end;
		state.Code:AppendCode([[
				RDX.Alert.Simple(VFLI.i18n(title), sound, tonumber(totaltime), spam);
		]]);
		if desc.devent and desc.devent ~= "" then
		state.Code:AppendCode([[
				VFLT.scheduleNamed("bm]]..id..[[", tonumber(totaltime), function() 
					BossmodEvents:Dispatch("]]..desc.devent..[[");
				end)
		]]); end
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
				end); -- end schedule
		]]); end
		state.Code:AppendCode([[
		end, encid); -- event
		]]);
		
		state.Code:AppendCode([[
			BossmodEvents:Bind("STOP", nil, function()
				VFLT.UnscheduleByName("bm]]..id..[[");
			end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		return GenerateAlertDescripterUI(desc, parent, "Simple");
	end,
	CreateDescriptor = function() return {feature = "Alert: Simple"}; end
});

RDX.RegisterFeature({
	name = "Alert: Icon",
	category = VFLI.i18n("Alerts");
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
		elseif not tonumber(desc.totaltime) then
			VFL.AddError(errs, VFLI.i18n("Time fields must be a number or a representation of a number"))
			return false;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- make sure sound and alert txt fields are valid
		desc.title = desc.title or "";
		desc.sound = desc.sound or "";
		
		-- delay needs to be a number
		if not desc.delay or not tonumber(desc.delay) then
			desc.delay = 0;
		end
		
		local descs, desct = "false", "false";
		if desc.s then descs = "true"; end
		if desc.t then desct = "true"; end
		
		local id = RDXBM.GetUniqueAlertID();
		local spam = "false";
		if desc.spam then spam = "true"; end
		
		local iconid = _icontableToID[desc.iconType] or 0;
		
		state.Code:AppendCode([[
		BossmodEvents:Bind("]]..desc.bevent..[[", nil, function(source, sourceguid, target, targetguid)
			if not sourceguid and not targetguid then return; end
			local delay, totaltime, spam = ]]..desc.delay..[[,]]..desc.totaltime..[[,]]..spam..[[;
			local sound = ]]..strformat("%q", desc.sound)..[[;
			local typeicon = ]].. iconid ..[[;
		]]);
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
			VFLT.scheduleNamed("bm]]..id..[[", tonumber(delay), function()
		]]); end
		
		if desc.icon == "SOURCE" then
		state.Code:AppendCode([[
			if IsRaidLeader() or IsRaidOfficer() then
				SetRaidTarget(source, typeicon);
			end
		]]);
		elseif desc.icon == "TARGET" then
		state.Code:AppendCode([[
			if IsRaidLeader() or IsRaidOfficer() then
				SetRaidTarget(target, typeicon);
			end
		]]);
		end
		
		if desc.totaltime and desc.totaltime ~= "" and desc.icon == "SOURCE" then
		state.Code:AppendCode([[
				VFLT.scheduleNamed("bm]]..id..[[", tonumber(totaltime), function() 
					if IsRaidLeader() or IsRaidOfficer() then
						SetRaidTarget(source, 0);
					end
				end)
		]]);
		elseif desc.totaltime and desc.totaltime ~= "" and desc.icon == "TARGET" then
		state.Code:AppendCode([[
				VFLT.scheduleNamed("bm]]..id..[[", tonumber(totaltime), function() 
					if IsRaidLeader() or IsRaidOfficer() then
						SetRaidTarget(target, 0);
					end
				end)
		]]); 
		end
		if tonumber(desc.delay) > 0 then state.Code:AppendCode([[
				end); -- end schedule
		]]); end
		state.Code:AppendCode([[
		end, encid); -- event
		]]);
		
		state.Code:AppendCode([[
			BossmodEvents:Bind("STOP", nil, function()
				VFLT.UnscheduleByName("bm]]..id..[[");
			end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		return GenerateAlertDescripterUI(desc, parent, "Icon");
	end,
	CreateDescriptor = function() return {feature = "Alert: Icon"}; end
});
