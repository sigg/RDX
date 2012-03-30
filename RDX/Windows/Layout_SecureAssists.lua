-- Layout_SecureAssists.lua
-- RDX - Raid Data Exchange
-- (C)2006-2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--

local GetRDXUnit = RDXDAL._ReallyFastProject;
local tempUnit = RDXDAL.tempUnit;

-------------------------------------------------------------------
-- SECURE ASSIST HEADER DRIVER
-- This drives a trio of headers that work like an assist window.
-------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Secure Assists";
	category = VFLI.i18n("Layout");
	IsPossible = function(state)
		if not state:Slot("Frame") then return nil; end
		if not state:Slot("SetupSubFrame") then return nil; end
		if not state:Slot("SubFrameDimensions") then return nil; end
		if not state:Slot("SecureDataSource") then return nil; end
		if state:Slot("AssistFrame") then return nil; end
		if state:Slot("Layout") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		state:AddSlot("HeaderDriver");
		state:AddSlot("Layout");
		state:AddSlot("RepaintAll"); state:AddSlot("RepaintData");
		--state:AddSlot("SecureDataSource"); -- Data sources are automatically Secured by HeaderGrids.
		state:AddSlot("SecureSubframes"); -- Data sources are automatically Secured by HeaderGrids.
		state:AddSlot("AcclimatizeAdvice", true); state:AddSlot("DeacclimatizeAdvice", true);
		return true;
	end;
	ApplyFeature = function(desc, state)

		---------------- Post-assemble functions
		local setTitle = VFL.Noop;
		local acca, deacca = VFL.Noop, VFL.Noop;
		state:Attach("Assemble", true, function(state, win)
			setTitle = state:GetSlotFunction("SetTitleText");
			acca = state:GetSlotFunction("AcclimatizeAdvice");
			deacca = state:GetSlotFunction("DeacclimatizeAdvice");
		end);

		---------------- Locals
		local limit = desc.limit or 1000;
		local iFunc = state:GetSlotFunction("DataSourceIterator");
		local sizeFunc = state:GetSlotFunction("DataSourceSize");
		local showAssist, showTT = desc.showAssist, desc.showTT;
		local suffix1, suffix2 = desc.suffix1 or "target", desc.suffix2 or "targettarget";
		local gridAssist, gridT, gridTT = nil, nil, nil;
		local win, faux = nil, nil;
		local paintAll, paintSecure, paintData;
		local interval = 0.1;
		if tonumber(desc.interval) then interval = VFL.clamp(tonumber(desc.interval), 0.05, 5); end

		------------- Unit lookup
		local umap = {};
		local function lookupUnit(rdxu)
			if rdxu then
				return umap[rdxu.uid];
			end
		end

		---------------- UnitFrame allocator
		local genUF = state:GetSlotFunction("SetupSubFrame");
		local dx, dy = (state:GetSlotFunction("SubFrameDimensions"))();
		dx = dx or 50; dy = dy or 12; -- BUGFIX: incase something goes wrong, don't crash/do unreasonable things

		-- "Acclimatize" a secure button to this window.
		local function Acclimatize(hdr, frame)
			genUF(frame); frame:Cleanup();
			if(hdr == gridAssist) then
				frame:SetAttribute("unitsuffix", nil);
			elseif(hdr == gridT) then
				frame:SetAttribute("unitsuffix", suffix1);
			elseif(hdr == gridTT) then
				frame:SetAttribute("unitsuffix", suffix2);
			end
			frame._paintmask = 1;
			acca(nil, hdr, frame);
		end

		-- "De-acclimatize" a secure button from this window
		local function Deacclimatize(hdr, frame)
			deacca(nil, hdr, frame);
			frame:SetAttribute("unitsuffix", nil);
		end

		local function GetWindowWidth()
			local mult = 1;
			if showAssist then mult = mult + 1; end
			if showTT then mult = mult + 1; end
			return dx*mult;
		end

		-- Generate a header
		local function GenHdr()
			local grid = RDX.SmartHeader:new(); grid:SetParent(faux);
			grid:Hide();
			grid.OnAllocateFrame = Acclimatize;
			grid:SetAttribute("minWidth", dx); grid:SetAttribute("minHeight", 0.1);
			grid:SetAttribute("point", "TOP");
			return grid;
		end
		local function AccHdr(h)
			for _,frame in h:AllChildren() do Acclimatize(h, frame); end
		end

		-- PAINT-ALL FUNCTION
		-- The paint all function updates the name lists of all the subordinate grids.
		function paintAll()
			if not InCombatLockdown() then -- Can't change the content of headers while in combat.
				local n = sizeFunc(); if not n then return; end
				n = math.min(limit, n);
				local str, idx, name, server = "", 0, nil, nil;
				for ctl,uid in iFunc() do if (UnitInParty(uid) or UnitInRaid(uid)) then
					idx = idx + 1; if(idx > n) then break; end
					name, server = UnitName(uid);
					if (server and server ~= "") then
						name = name .. "-" .. server;
					end
					str = str .. name .. ",";
				end end
				if gridAssist then gridAssist:SetNameList(str); end
				if gridT then gridT:SetNameList(str); end
				if gridTT then gridTT:SetNameList(str); end
			end
		end

		-- PAINT-SECURE FUNCTION
		-- Called on secure updates.
		-- Resize the window to properly accomodate the new content; repaint mouse binding
		-- attributes; etc.
		function paintSecure()
			if not gridT then return; end
			-- If not ICLD, resize the window
			if not InCombatLockdown() then
				faux:SetWidth(GetWindowWidth());
				faux:SetHeight(gridT:GetHeight());
			end
			-- Update the unit map
			for k in pairs(umap) do umap[k] = nil; end
			for idx,cell in gridT:ActiveChildren() do
				local uid = cell:GetAttribute("unit");
				if uid then umap[uid] = cell;	end
			end
			-- Paint the data as well
			paintData();
		end

		-- PAINT-DATA FUNCTION
		-- Iterate over the grid itself and apply to each cell's _subframe the appropriate unit
		-- data.
		local succ,err;
		local function subPaintData(grid)
			if not grid then return nil; end
			local uid,unit,n = nil,nil,0;
			for idx,cell in grid:ActiveChildren() do
				uid = VFL.GetSecureButtonUnit(cell);
				n = n + 1;
				if UnitExists(uid) then
					-- Project onto RDX unitspace. Use the tempUnit if we can't get a regular unit.
					unit = GetRDXUnit(uid);	if not unit then unit = tempUnit; unit.uid = uid; end
					-- Force a FULL repaint of each cell.
					cell._paintmask = 1;
					succ,err = pcall(cell.SetData, cell, idx, uid, unit);
					if not succ then RDXDK.PrintError(win, "SetData", err); end
				else
					succ,err = pcall(cell.Cleanup, cell);
					if not succ then RDXDK.PrintError(win, "Cleanup", err); end
				end
			end
			return n;
		end
		function paintData()
			subPaintData(gridAssist);
			local n = subPaintData(gridT);
			setTitle(" (" .. n .. ")");
			subPaintData(gridTT);
		end
		
		-- CREATION FUNCTION
		-- Acquire our window upon creation
		local function create(w)
			win = w;
			-- "Faux frame" that will stand in as a client in the inverted control window.
			faux = VFLUI.AcquireFrame("Frame");
			faux:SetScale(1); faux:SetMovable(true); faux:Show();
			w:SetClient(faux);

			gridT = GenHdr(); AccHdr(gridT); 
			gridT.OnSecureUpdate = paintSecure;
			if showAssist then 
				gridAssist = GenHdr(); AccHdr(gridAssist);
				gridAssist:SetPoint("TOPLEFT", faux, "TOPLEFT");
				gridT:SetPoint("TOPLEFT", gridAssist, "TOPRIGHT");
				-- activate update
				gridAssist:SetAttribute("_ignore", nil);
				-- to view, set a attribute make the internal engine to run
				gridAssist:SetAttribute("toto", "ok");
			else
				gridT:SetPoint("TOPLEFT", faux, "TOPLEFT");
			end
			if showTT then 
				gridTT = GenHdr(); AccHdr(gridTT);
				gridTT:SetPoint("TOPLEFT", gridT, "TOPRIGHT");
				-- activate update
				gridTT:SetAttribute("_ignore", nil);
				-- to view, set a attribute make the internal engine to run
				gridTT:SetAttribute("toto", "ok");
			end
			
			-- activate update
			gridT:SetAttribute("_ignore", nil);
			-- to view, set a attribute make the internal engine to run
			gridT:SetAttribute("toto", "ok");

			-- Profiling hooks
			if w._path and VFLP.IsEnabled() then
				VFLP.RegisterCategory("Win: " .. w._path);
				VFLP.RegisterFunc("Win: " .. w._path, "RepaintLayout", paintAll, true);
				VFLP.RegisterFunc("Win: " .. w._path, "RepaintSecure", paintSecure, true);
				VFLP.RegisterFunc("Win: " .. w._path, "RepaintData", paintData, true);
				VFLP.RegisterFunc("Win: " .. w._path, "LookupUnit", lookupUnit, true);
			end
		end

		-- DESTROY FUNCTION
		-- Tear down all this
		local function destroySubHdr(sh)
			if not sh then return; end
			for _,frame in sh:AllChildren() do Deacclimatize(sh, frame); end
			sh:Destroy();
		end
		local function destroy()
			gridT:SetAttribute("toto", nil);
			gridT:SetAttribute("_ignore", "RDXIgnore");
			if gridAssist then
				gridAssist:SetAttribute("toto", nil);
				gridAssist:SetAttribute("_ignore", "RDXIgnore");
			end
			if gridTT then
				gridTT:SetAttribute("toto", nil);
				gridTT:SetAttribute("_ignore", "RDXIgnore");
			end
			if VFLP.IsEnabled() then
				VFLT.AdaptiveUnschedule("Perf" .. win._path);
			end
			win:SetClient(nil); -- BUGFIX: remember to remove client refs before destroying client..
			destroySubHdr(gridAssist); gridAssist = nil;
			destroySubHdr(gridT); gridT = nil;
			destroySubHdr(gridTT); gridTT = nil;
			faux:Destroy(); faux = nil;
			-- Undo profiling
			if win._path then	VFLP.UnregisterCategory("Win: " .. win._path); end
			VFL.empty(umap);
			win.LookupUnit = nil;
			win = nil;
		end

		---------------------- EVENT SETUP
		-- On an assist window, let's force no-hinting, and force aperiodicity.
		local mux = state:GetSlotValue("Multiplexer");
		mux:SetNoHinting(true); mux:SetPeriod(nil);
		-- On UNIT_TARGET for one of the units in this window, force updating.
		mux:Event_MaskAllIfPresent("UNIT_TARGET", 1);	mux:_ForceHinting("UNIT_TARGET");

		local schedid = "assist" .. math.random(1, 1000000000);
		state:Attach("Show", true, function(w)
			VFLT.AdaptiveSchedule2(schedid, interval, w.RepaintData);
		end);
		state:Attach("Hide", true, function(w)
			VFLT.AdaptiveUnschedule2(schedid);
		end);

		-- Assist windows have no unit lookup capacities.
		state:Attach("Assemble", true, function(state, w)
			w.LookupUnit = lookupUnit;
		end);

		state:Attach("Create", true, create);
		state:Attach("Destroy", true, destroy);
		state:Attach("RepaintAll", nil, function()
			local succ,err = pcall(paintAll);
			if not succ then RDXDK.PrintError(win, "RepaintAll", err); end
		end);
		state:Attach("RepaintLayout", nil, function()
			local succ,err = pcall(paintAll);
			if not succ then RDXDK.PrintError(win, "RepaintAll", err); end
		end);
		state:Attach("RepaintData", nil, function(z)
			local succ,err = pcall(paintData, z);
			if not succ then RDXDK.PrintError(win, "RepaintData", err); end
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local showAssist = VFLUI.Checkbox:new(ui); showAssist:Show();
		showAssist:SetText(VFLI.i18n("Show base unit"));
		if desc and desc.showAssist then	showAssist:SetChecked(true);	else showAssist:SetChecked(nil); end
		ui:InsertFrame(showAssist);

		local showTT = VFLUI.Checkbox:new(ui); showTT:Show();
		showTT:SetText(VFLI.i18n("Show second-order unit"));
		if desc and desc.showTT then	showTT:SetChecked(true);	else showTT:SetChecked(nil); end
		ui:InsertFrame(showTT);

		local chk_limit = VFLUI.Checkbox:new(ui); chk_limit:Show();
		local ed_limit = VFLUI.Edit:new(chk_limit); ed_limit:Show();
		ed_limit:SetHeight(25); ed_limit:SetWidth(50); ed_limit:SetPoint("RIGHT", chk_limit, "RIGHT");
		chk_limit.Destroy = VFL.hook(function() ed_limit:Destroy(); end, chk_limit.Destroy);
		chk_limit:SetText(VFLI.i18n("Limit number of displayed frames to"));
		if desc and desc.limit then 
			chk_limit:SetChecked(true);
			ed_limit:SetText(desc.limit);
		else 
			chk_limit:SetChecked();
			ed_limit:SetText("1");
		end
		ui:InsertFrame(chk_limit);

		local interval = VFLUI.LabeledEdit:new(ui, 50); interval:Show();
		interval:SetText(VFLI.i18n("Period between repaints (sec)"));
		interval.editBox:SetText(desc.interval or "0.2");
		ui:InsertFrame(interval);

		local suffix1 = VFLUI.LabeledEdit:new(ui, 100); suffix1:Show();
		suffix1:SetText(VFLI.i18n("Suffix"));
		suffix1.editBox:SetText(desc.suffix1 or "target");
		ui:InsertFrame(suffix1);

		local suffix2 = VFLUI.LabeledEdit:new(ui, 100); suffix2:Show();
		suffix2:SetText(VFLI.i18n("Second-order suffix"));
		suffix2.editBox:SetText(desc.suffix2 or "targettarget");
		ui:InsertFrame(suffix2);
		

		function ui:GetDescriptor()
			local limit = nil;
			if chk_limit:GetChecked() then
				limit = VFL.clamp(ed_limit:GetNumber(), 1, 100);
			end
			local intvl = VFL.clamp(interval.editBox:GetNumber(), 0.05, 5);
			local s1, s2 = suffix1.editBox:GetText(), suffix2.editBox:GetText();
			return { 
				feature = "Secure Assists"; 
				showAssist = showAssist:GetChecked(); showTT = showTT:GetChecked();
				interval = intvl;
				limit = limit; suffix1 = s1; suffix2 = s2;
			};
		end

		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "Secure Assists";
			showAssist = true; showTT = true;
			suffix1 = "target"; suffix2 = "targettarget";
			interval = 0.1;
		};
	end;
});

