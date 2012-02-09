-- Layout_SingleUnitFrame.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE LICENSE.
-- UNLICENSED COPYING IS PROHIBITED.
--
-- A layout engine that confers the ability to create a window that displays only one specific unit ID.
-- Grossbaaffe : Add vehicle switch

local tempUnit = RDXDAL.tempUnit;
local bor, band = bit.bor, bit.band;

---------------------------
-- A new "Bind" operator for the multiplexer for a single unit window.
-- The ordinary multiplexer assumes that RDXEvents will always fire; this is only true for raid units.
-- This version understands that for single unit ids that isn't always the case.
---------------------------

local aura_maskcache = 0;

local function SingleUnitMuxEventTranslator_MaskUnit(ev, mask, mux, rd)
	local function filter(arg1)
		if arg1 == mux.uid then rd(mask); end
	end
	if(ev == "UNIT_HEALTH") then
		WoWEvents:Bind("UNIT_HEALTH", nil, filter, mux);
		WoWEvents:Bind("UNIT_MAXHEALTH", nil, filter, mux);
	elseif(ev == "UNIT_HEAL_PREDICTION") then
		WoWEvents:Bind("UNIT_HEAL_PREDICTION", nil, filter, mux);
	elseif(ev == "UNIT_POWER") then
		WoWEvents:Bind("UNIT_POWER", nil, filter, mux);
		WoWEvents:Bind("UNIT_MAXPOWER", nil, filter, mux);
	elseif(ev == "UNIT_FLAGS") then
		WoWEvents:Bind("UNIT_FLAGS", nil, filter, mux);
		WoWEvents:Bind("UNIT_DYNAMIC_FLAGS", nil, filter, mux);
	elseif(ev == "UNIT_CAST_TIMER_UPDATE") then
		WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_START", nil, filter, mux);
		WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_UPDATE", nil, filter, mux);
		WoWEvents:Bind("UNIT_SPELLCAST_DELAYED", nil, filter, mux);
		WoWEvents:Bind("UNIT_SPELLCAST_START", nil, filter, mux);
	elseif(ev == "UNIT_CAST_TIMER_STOP") then
		WoWEvents:Bind("UNIT_SPELLCAST_CHANNEL_STOP", nil, filter, mux);
		WoWEvents:Bind("UNIT_SPELLCAST_FAILED", nil, filter, mux);
		WoWEvents:Bind("UNIT_SPELLCAST_INTERRUPTED", nil, filter, mux);
		WoWEvents:Bind("UNIT_SPELLCAST_SUCCEEDED", nil, function(arg1)
			local spellName = UnitCastingInfo(arg1);
			if not spellName then
				spellName = UnitChannelInfo(arg1);
			end
			if not spellName then
				filter();
			end
		end, mux);
		WoWEvents:Bind("UNIT_SPELLCAST_STOP", nil, filter, mux);
	elseif(ev == "UNIT_PORTRAIT_UPDATE") then
		WoWEvents:Bind("UNIT_PORTRAIT_UPDATE", nil, filter, mux);
	elseif(ev == "UNIT_XP_UPDATE") then
		WoWEvents:Bind("PLAYER_XP_UPDATE", nil, filter, mux);
		WoWEvents:Bind("UPDATE_EXHAUSTION", nil, filter, mux);
		WoWEvents:Bind("PLAYER_LEVEL_UP", nil, filter, mux);
		WoWEvents:Bind("UNIT_PET_EXPERIENCE", nil, filter, mux);
	elseif( (ev == "UNIT_BUFF_*") or (ev == "UNIT_DEBUFF_*") ) then
		-- We want to bind to UNIT_AURA, but let's be sure to disallow double binds.
		-- Also, or the mask with our mask cache for multi masks.
		aura_maskcache = bor(aura_maskcache, mask);
		local closure_sux = aura_maskcache;
		WoWEvents:Unbind(mux, "UNIT_AURA");
		WoWEvents:Bind("UNIT_AURA", nil, function(arg1)
			if arg1 == mux.uid then rd(closure_sux); end
		end, mux);
	else
		-- We're dealing with a plain RDX event, so let's match against mux.nid
		RDXEvents:Bind(ev, nil, function(unit)
			if unit.nid == mux.nid then rd(mask); end
		end, mux);
	end
end


local function SingleUnitMuxEventTranslator_MaskAll(ev, mask, mux, rd)
	local function unfilter() rd(mask); end
	
	if(ev == "UNIT_HEALTH") then
	-- Noop here, just don't allow this, it should never happen and if it does it would be horribly inefficient.
	elseif(ev == "UNIT_POWER") then
	-- Noop here, just don't allow this, it should never happen and if it does it would be horribly inefficient.
	elseif( (ev == "UNIT_BUFF_*") or (ev == "UNIT_DEBUFF_*") ) then
	-- Noop here, just don't allow this, it should never happen and if it does it would be horribly inefficient.
	elseif(ev == "RAID_TARGET_UPDATE") then
		WoWEvents:Bind("RAID_TARGET_UPDATE", nil, unfilter, mux);
	elseif(ev == "PLAYER_UPDATE_RESTING") then
		WoWEvents:Bind("PLAYER_REGEN_DISABLED", nil, unfilter, mux);
		WoWEvents:Bind("PLAYER_REGEN_ENABLED", nil, unfilter, mux);
		WoWEvents:Bind("PLAYER_UPDATE_RESTING", nil, unfilter, mux);
	elseif(ev == "PARTY_LOOT_METHOD_CHANGED") then
		WoWEvents:Bind("PARTY_LOOT_METHOD_CHANGED", nil, unfilter, mux);
	else
		-- Pass thru direct to repaint subroutine.
		RDXEvents:Bind(ev, nil, function() rd(mask); end, mux);
	end
end 


local function SingleUnitMuxBind(self, win)
	aura_maskcache = 0;
	local rd, rs, ra, lu = win.RepaintData, win.RepaintSort, win.RepaintAll, win.LookupUnit;

	RDXEvents:Bind("DISRUPT_WINDOWS", nil, ra, self);
	local baseHinting = (not self.noHinting);

	-- Bind events
	for k,v in pairs(self.binds) do
		local ty = v.ty;
		local hinting = baseHinting or v.forceHinting;
		RDX:Debug(10, "SingleUnitEvent Bind: ", ty, " on ", tostring(k), " -> ", tostring(win));
		if (ty == "UPDATE_MASK_ALL") and hinting then
			local z = v.mask;
			k.SigUpdate:Connect(nil, function() rd(z); end, self);
		elseif (ty == "DELTA_MASK") and hinting then
			local z = v.mask;
			k.SigUpdate:Connect(nil, function(_, md, d)
				if md then
					-- If our unit is among the delta'd units, fire the paint event.
					for un in pairs(md) do if un == self.nid then rd(z); break; end end
				else
					if d == self.nid then rd(z); end
				end
			end, self);
		elseif (ty == "MASK_ALL") and hinting then
			SingleUnitMuxEventTranslator_MaskAll(k, v.mask, self, rd);
		elseif ((ty == "MASK_ALL_IF_PRESENT") or (ty == "UNIT_MASK")) and hinting then
			SingleUnitMuxEventTranslator_MaskUnit(k, v.mask, self, rd);
		end -- if...
	end -- for k,v in pairs(binds) do
end

------------------------------------------
-- The single unitframe layout driver.
------------------------------------------
local units = {
	{ text = "player" },
	{ text = "target" },
	{ text = "targettarget" },
	{ text = "targettargettarget" },
	{ text = "focus" },
	{ text = "focustarget" },
	{ text = "focustargettarget" },
	{ text = "pet" },
	{ text = "pettarget"},
	{ text = "pettargettarget"},
	{ text = "vehicle" },
	{ text = "mouseover" },
};
local function unitSel() return units; end

RDX.RegisterFeature({
	name = "layout_single_unitframe"; version = 1;
	title = VFLI.i18n("Single Unit Frame"); 
	category = VFLI.i18n("Data Source and Layout");
	IsPossible = function(state)
		-- Check for unitframe
		if not state:HasSlots("Frame", "SetupSubFrame", "SubFrameDimensions") then return nil; end
		-- Exclusive with other layouts and datasources.
		if state:Slot("AssistFrame") then return nil; end
		if state:Slot("DataSource") then return nil; end
		if state:Slot("Layout") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		state:AddSlot("Layout");
		state:AddSlot("RepaintAll"); state:AddSlot("RepaintSort"); state:AddSlot("RepaintData");
		if desc.clickable then
			state:AddSlot("SecureDataSource");
			state:AddSlot("SecureSubframes");
		else
			state:AddSlot("DataSource");
			state:AddSlot("SetupSubFrame");
		end
		state:AddSlot("AcclimatizeAdvice", true); state:AddSlot("DeacclimatizeAdvice", true);
		state:AddSlot("IsSingleUnitFrame");
		return true;
	end;
	ApplyFeature = function(desc, state)
		---------------- Post-assemble functions
		local acca, deacca = VFL.Noop, VFL.Noop;
		state:_Attach(state:Slot("Assemble"), true, function(state, win)
			acca = state:GetSlotFunction("AcclimatizeAdvice");
			deacca = state:GetSlotFunction("DeacclimatizeAdvice");
		end);

		---------------- Locals
		-- Get the unit id, and create a projective unit wrapping that uid.
		local uid = (desc.unit or "none");
		local curunit = RDXDAL.ProjectiveUnit:new(); curunit.uid = uid;
		local fhandler, frame, win = nil, nil, nil;
		local defaultPaintMask = 0;
		local paintAll, paintData;

		------------------ Multiplexer hacks
		local mux = state:GetSlotValue("Multiplexer");
		mux.uid = uid;
		mux.Bind = SingleUnitMuxBind;
		mux:SetPeriod(nil);

		------------------ Unit lookup
		local function lookupUnit(rdxu,_,nid)
			if rdxu then
				return (rdxu.nid == curunit.nid);
			elseif nid then
				return (nid == curunit.nid);
			end
		end

		local function projectUnit() curunit:_Project(); mux.nid = curunit.nid; end
		
		local function changevehicle()
			local modunit = SecureButton_GetModifiedUnit(frame);
			mux.uid = modunit;
			curunit.uid = modunit;
			projectUnit();
			uid = modunit;
			paintAll();
		end
		if desc.clickable and desc.switchvehicle and (uid == "player" or uid == "pet") then state:SetSlotValue("SwitchVehicle", true); end

		---------------- UnitFrame allocator
		local genUF = state:GetSlotFunction("SetupSubFrame");
		local dx, dy = (state:GetSlotFunction("SubFrameDimensions"))();
		dx = dx or 50; dy = dy or 12; -- BUGFIX: incase something goes wrong, don't crash/do unreasonable things

		-- PAINT-DATA FUNCTION
		-- Iterate over the grid itself and apply to each cell's _subframe the appropriate unit
		-- data.
		local succ,err;
		function paintData(maskmod)
			if not frame then return; end
			maskmod = maskmod or 0;
			frame._paintmask = bor(frame._paintmask or 0, maskmod);
			if UnitExists(uid) then
				succ,err = pcall(frame.SetData, frame, 1, uid, curunit);
				if not succ then RDXDK.PrintError(win, "SetData", err); end
			else
				succ,err = pcall(frame.Cleanup, frame);
				if not succ then RDXDK.PrintError(win, "Cleanup", err); end
			end
			frame._paintmask = defaultPaintMask;
		end

		-- PAINT-ALL = paint-data with full mask
		function paintAll() paintData(1); end
		
		-- CREATION FUNCTION
		-- Acquire our window upon creation
		local frameType = "Frame";
		if desc.clickable and uid ~= "mouseover" then frameType = "SecureFrame"; end
		local unitWatch = nil; if desc.unitWatch then unitWatch = true; end
		local function create(w)
			win = w;
			frame = VFLUI.AcquireFrame(frameType);
			frame:SetScale(1); frame:SetMovable(true); --frame:Show();
			frame:SetAttribute("unit", uid);
			w:SetClient(frame);
			-- indicate toggle vehicle, must be before genUF
			if desc.clickable and desc.switchvehicle and (uid == "player" or uid == "pet") then
				frame:SetAttribute("toggleForVehicle", true);
			end
			-- Set us up as a unitframe.
			genUF(frame); 
			if not frame.Cleanup then
				frame.Cleanup = VFL.Noop;
				frame.SetData = VFL.Noop;
				frame.GetHotspot = VFL.Noop;
				frame.SetHotspot = VFL.Noop;
				frame.Destroy = VFL.hook(function(frame)
					frame.Cleanup = nil; frame.SetData = nil; 
					frame.GetHotspot = nil; frame.SetHotspot = nil;
					frame._paintmask = nil;
				end, frame.Destroy);
			end
			frame:Cleanup();
			acca(nil, nil, frame);
			frame._paintmask = defaultPaintMask;
			--- For player or target frames, reproject on ROSTER_UPDATE
			if(uid == "player") or (uid == "target") or (uid == "focus") then
				RDXEvents:Bind("ROSTER_NIDS_CHANGED", nil, projectUnit, w);
				if desc.clickable and desc.switchvehicle then
					WoWEvents:Bind("UNIT_ENTERED_VEHICLE", nil, changevehicle, w);
					WoWEvents:Bind("UNIT_EXITED_VEHICLE", nil, changevehicle, w);
				end
				--projectUnit(); -- Do an initial projection.
				changevehicle();
			end
			if(uid == "pet") then
				RDXEvents:Bind("ROSTER_PETS_CHANGED", nil, projectUnit, w);
				if desc.clickable and desc.switchvehicle then
					WoWEvents:Bind("UNIT_ENTERED_VEHICLE", nil, changevehicle, w);
					WoWEvents:Bind("UNIT_EXITED_VEHICLE", nil, changevehicle, w);
				end
				WoWEvents:Bind("LOCALPLAYER_PET_RENAMED", nil, paintAll, w);
				--projectUnit();
				changevehicle();
			end
			--- For first-order target frames, reproject on PLAYER_TARGET_CHANGED.
			if(uid == "target") then
				WoWEvents:Bind("PLAYER_TARGET_CHANGED", nil, projectUnit, w);
			end
			--- For target frames, when PLAYER_TARGET_CHANGED, we need to redo the frames.
			if(uid == "target") or (uid == "targettarget") or (uid == "targettargettarget") then
				WoWEvents:Bind("PLAYER_TARGET_CHANGED", nil, paintAll, w);
			end
			--- For focus frames, PLAYER_FOCUS_CHANGED needs to re-project and trigger an update
			if(uid == "focus") then
				WoWEvents:Bind("PLAYER_FOCUS_CHANGED", nil, projectUnit, w);
			end
			--- For focus frames, PLAYER_FOCUS_CHANGED, we need to redo the frames.
			if(uid == "focus") or (uid == "focustarget") or (uid == "focustargettarget") then
				WoWEvents:Bind("PLAYER_FOCUS_CHANGED", nil, paintData(1), w);
			end
			--[[	if(uid == "focus") then
				WoWEvents:Bind("PLAYER_FOCUS_CHANGED", nil, function()
					projectUnit(); paintData(1);
				end, w);
			end
			]]
			if(uid == "mouseover") then
				WoWEvents:Bind("UPDATE_MOUSEOVER_UNIT", nil, projectUnit, w);
				WoWEvents:Bind("UPDATE_MOUSEOVER_UNIT", nil, paintData(1), w);
			end

			-- Set this frame up for UnitWatch if needed.
			if unitWatch then RegisterUnitWatch(frame);	end

			-- Profiling hooks
			if w._path and VFLP.IsEnabled() then
				VFLP.RegisterCategory("Win: " .. w._path);
				VFLP.RegisterFunc("Win: " .. w._path, "RepaintData", paintData, true);
			end
		end

		-- DESTROY FUNCTION
		-- Tear down all this
		local function destroy(w)
			-- Adaptive schedule
			if VFLP.IsEnabled() then
				VFLT.AdaptiveUnschedule("Perf" .. win._path);
			end
			-- Unbind us from all events we bound to in Create()
			WoWEvents:Unbind(w); RDXEvents:Unbind(w);
			-- Clear us outta there
			win:SetClient(nil);
			if frame then
				UnregisterUnitWatch(frame);
				frame:Destroy(); frame = nil; 
			end
			if win._path then VFLP.UnregisterCategory("Win: " .. win._path); end
			win.LookupUnit = nil;
			win = nil;
		end

		-- At assembly time, download the default paintmask from the multiplexer...
		state:Attach("Assemble", true, function(state, win)
			defaultPaintMask = tonumber(state:GetSlotValue("DefaultPaintMask")) or 0;
			win.LookupUnit = lookupUnit;
		end);

		state:_Attach(state:Slot("Create"), true, create);
		state:_Attach(state:Slot("Destroy"), true, destroy);
		state:_Attach(state:Slot("RepaintAll"), nil, function()
			local succ,err = pcall(paintAll, 1);
			if not succ then RDXDK.PrintError(win, "RepaintAll", err); end
		end);
		state:_Attach(state:Slot("RepaintData"), nil, function(z)
			local succ,err = pcall(paintData, z);
			if not succ then RDXDK.PrintError(win, "RepaintData", err); end
		end);
	end,
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local er = VFLUI.EmbedRight(ui, "Unit");
		local dd_unit = VFLUI.Dropdown:new(er, unitSel);
		dd_unit:SetWidth(100); dd_unit:Show();
		if desc and desc.unit then dd_unit:SetSelection(desc.unit); end
		er:EmbedChild(dd_unit); er:Show();
		ui:InsertFrame(er);

		local chk_clickable = VFLUI.Checkbox:new(ui); chk_clickable:Show();
		chk_clickable:SetText(VFLI.i18n("Clickable"));
		if desc and desc.clickable then	chk_clickable:SetChecked(true);	else chk_clickable:SetChecked(nil); end
		ui:InsertFrame(chk_clickable);

		local chk_unitwatch = VFLUI.Checkbox:new(ui); chk_unitwatch:Show();
		chk_unitwatch:SetText(VFLI.i18n("Auto-hide if unit does not exist"));
		if desc and desc.unitWatch then	chk_unitwatch:SetChecked(true);	else chk_unitwatch:SetChecked(nil); end
		ui:InsertFrame(chk_unitwatch);
		
		local chk_switchvehicle = VFLUI.Checkbox:new(ui); chk_switchvehicle:Show();
		chk_switchvehicle:SetText(VFLI.i18n("Switch vehicle"));
		if desc and desc.switchvehicle then chk_switchvehicle:SetChecked(true); else chk_switchvehicle:SetChecked(nil); end
		ui:InsertFrame(chk_switchvehicle);

		function ui:GetDescriptor()
			if dd_unit:GetSelection() == "mouseover" then chk_switchvehicle:SetChecked(nil); chk_clickable:SetChecked(nil); chk_unitwatch:SetChecked(true); end
			return { 
				feature = "layout_single_unitframe"; version = 1;
				unit = dd_unit:GetSelection();
				clickable = chk_clickable:GetChecked();
				unitWatch = chk_unitwatch:GetChecked();
				interval = nil;
				switchvehicle = chk_switchvehicle:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "layout_single_unitframe"; version = 1;
			unit = "player"; clickable = true;
		};
	end;
});


RDX.RegisterFeature({
	name = "layout_single_artframe"; 
	version = 2;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "layout_single_unitframe"; desc.version = 1; desc.unit = "player";
	end;
});
