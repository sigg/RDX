-- Layout_Misc.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Miscellaneous layout code.

local GetRDXUnit = RDXDAL._ReallyFastProject;
local UIDToNumber = RDXDAL.UIDToNumber;
local bor,band = bit.bor, bit.band;

-------------------------------------------------------------------
-- SINGLE HEADER DRIVER
--
-- This allows a window to be driven directly by a single header.
-------------------------------------------------------------------
RDX.RegisterFeature({
	name = "header"; version = 1;
	title = VFLI.i18n("Header Single"); category = VFLI.i18n("Data Source and Layout");
	IsPossible = function(state)
		if not state:Slot("Frame") then return nil; end
		if not state:Slot("SetupSubFrame") then return nil; end
		if not state:Slot("SubFrameDimensions") then return nil; end
		if state:Slot("AssistFrame") then return nil; end
		if state:Slot("DataSource") then return nil; end -- Can't use a DataSource with a header.
		if state:Slot("SecureDataSource") then return nil; end -- Can't use a DataSource with a header.
		if state:Slot("Layout") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		if (not desc.header) or (not desc.header.driver) then
			VFL.AddError(errs, VFLI.i18n("Missing header definition.")); return nil;
		end
		if desc.header.driver == 1 then
			local _,_,_,ty = RDXDB.GetObjectData(desc.header.nset);
			if(not ty) or (ty ~= "NominativeSet") then
				VFL.AddError(errs, VFLI.i18n("Invalid set pointer.")); return nil;
			end
			local inst = RDXDB.GetObjectInstance(desc.header.nset);
			if not inst then
				VFL.AddError(errs, VFLI.i18n("Could not instantiate set.")); return nil;
			end
		end
		state:AddSlot("HeaderDriver");
		state:AddSlot("Layout");
		state:AddSlot("RepaintAll"); state:AddSlot("RepaintData");
		state:AddSlot("DataSource"); state:AddSlot("DataSourceSize"); state:AddSlot("DataSourceIterator");
		state:AddSlot("SecureDataSource"); -- Data sources are automatically Secured by HeaderGrids.
		state:AddSlot("SecureSubframes"); -- Data sources are automatically Secured by HeaderGrids.
		state:AddSlot("CellPrePaintAdvice", true); state:AddSlot("CellPostPaintAdvice", true);
		state:AddSlot("TotalPrePaintAdvice", true); state:AddSlot("TotalPostPaintAdvice", true);
		state:AddSlot("AcclimatizeAdvice", true); state:AddSlot("DeacclimatizeAdvice", true);
		return true;
	end;
	ApplyFeature = function(desc, state)

		---------------- Post-assemble functions
		local tprepa, prePaintAdvice, postPaintAdvice, tpostpa = VFL.Noop, VFL.Noop, VFL.Noop, VFL.Noop;
		local acca, deacca = VFL.Noop, VFL.Noop;
		local setTitle = VFL.Noop;
		state:_Attach(state:Slot("Assemble"), true, function(state, win)
			setTitle = state:GetSlotFunction("SetTitleText");
			tprepa = state:GetSlotFunction("TotalPrePaintAdvice");
			prePaintAdvice = state:GetSlotFunction("CellPrePaintAdvice");
			postPaintAdvice = state:GetSlotFunction("CellPostPaintAdvice");
			tpostpa = state:GetSlotFunction("TotalPostPaintAdvice");
			acca = state:GetSlotFunction("AcclimatizeAdvice");
			deacca = state:GetSlotFunction("DeacclimatizeAdvice");
		end);

		---------------- Locals
		local axis, hlt, hdef = desc.axis or 1, desc.hlt, desc.header;
		local grid, win, ucount = nil, nil, 0;
				local paintSecure, paintData;
		local nset = nil; -- The nominative set we're operating from
		local defaultPaintMask = 0;

		-------- UNIT FINDER
		local umap = {}; -- Map from uids to grid cells...
		local function lookupUnit(rdxu,_,nid)
			if rdxu then
				return umap[rdxu.nid];
			elseif nid then
				return umap[nid];
			end
		end

		---------------- UnitFrame allocator
		local genUF = state:GetSlotFunction("SetupSubFrame");
		local dx, dy = (state:GetSlotFunction("SubFrameDimensions"))();
		dx = dx or 50; dy = dy or 12; -- BUGFIX: incase something goes wrong, don't crash/do unreasonable things

		-- "Acclimatize" a secure button to this window.
		local function Acclimatize(hdr, frame)
			genUF(frame); frame:Cleanup();
			acca(nil, hdr, frame);
			frame._paintmask = defaultPaintMask;
		end

		-- "De-acclimatize" a secure button from this window
		local function Deacclimatize(hdr, secureBtn)
			-- Deacclimatize advice
			deacca(nil, hdr, secureBtn);
		end

		-- Update trigger for nominative sets
		local function NominativeSetUpdate(s)
			if not InCombatLockdown() then
				grid:SetNameList(s:GetHeaderList());
			end
		end

		-- Allow our grid to function as a data source.
		local function ds_size() return ucount; end
		local function ds_iter()
			if grid then
				return grid:IterateAsDataSource();
			else
				return VFL.Nil, nil, nil;
			end
		end
		state:Attach(state:Slot("DataSourceSize"), nil, ds_size);
		state:Attach(state:Slot("DataSourceIterator"), nil, ds_iter);

		-- PAINT-SECURE FUNCTION
		-- Called on secure updates.
		-- Resize the window to properly accomodate the new content; repaint mouse binding
		-- attributes; etc.
		function paintSecure()
			if not grid then return; end
			-- Update the Unit ID mapping.
			for k in pairs(umap) do umap[k] = nil; end
			ucount = 0;
			for idx, cell, uid in grid:ActiveChildren() do
				if uid then
					ucount = ucount + 1;
					umap[UIDToNumber(uid)] = cell;
					cell._paintmask = 1;
				end
			end
			setTitle(" (" .. ucount .. ")");
			-- Paint the data as well
			paintData();
		end

		-- PAINT-DATA FUNCTION
		-- Iterate over the grid itself and apply to each cell's _subframe the appropriate unit
		-- data.
		function paintData(maskmod)
			if not grid then return; end
			maskmod = maskmod or 0;
			tprepa(win); -- Total prepaint advice
			local csf, rdxUnit, index = nil, nil, 0;
			for idx,cell,uid in grid:ActiveChildren() do
				index = index + 1; rdxUnit = GetRDXUnit(uid);
				if rdxUnit and rdxUnit:IsCacheValid() then
					cell._paintmask = bor(cell._paintmask or 0, maskmod);
					prePaintAdvice(win, cell, index, idx, uid, rdxUnit);
					cell:SetData(idx, uid, rdxUnit);
					postPaintAdvice(win, cell, index, idx, uid, rdxUnit);
				else
					cell:Cleanup();
				end
				cell._paintmask = defaultPaintMask;
			end
			tpostpa(win); -- Total postpaint advice
		end

		-- CREATION FUNCTION
		-- Acquire our window upon creation
		local htype = nil; if desc.pet then htype = "SecureGroupPetHeader"; end
		local function create(w)
			win = w;
			-- Make the grid
			grid = RDX.SmartHeader:new(htype); 
			grid:Hide(); grid:SetMovable(true);
			w:SetClient(grid);

			-- Acclimatize all subframes.
			grid.OnAllocateFrame = Acclimatize;
			for _,frame in grid:AllChildren() do Acclimatize(grid, frame);end
			grid.OnSecureUpdate = paintSecure;

			-- Apply header attributes!
			RDXUI.ApplyHeaderDescriptor(grid, hdef);

			-- Apply min width/height based on grid dxn
			if(hdef.frameAnchor == "TOP") or (hdef.frameAnchor == "BOTTOM") then
				grid:SetAttribute("minWidth", dx); grid:SetAttribute("minHeight", 0.1);
			elseif(hdef.frameAnchor == "LEFT") or (hdef.frameAnchor == "RIGHT") then
				grid:SetAttribute("minWidth", 0.1); grid:SetAttribute("minHeight", dy);
			end

			-- We have to apply the nominative driver ourselves since it's interactive with the set update triggers.
			if hdef.driver == 1 then
				nset = RDXDB.GetObjectInstance(hdef.nset);
				local nlist = nset:GetHeaderList();
				grid:SetNameList(nlist);
				nset.SigNamesChanged:Connect(nil, NominativeSetUpdate, win);
			end
			grid:Show();

			if w._path then
				-- Add a little icon to the window that lets you edit the header
				local btn = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\RDX\\Skin\\funnel");
				btn:SetHighlightColor(1,1,0,1);
				w:AddButton(btn);
				local path = w._path;
				btn:SetScript("OnClick", function()
					local x = RDXDB.GetObjectData(path);
					if (type(x) ~= "table") or (type(x.data) ~= "table") then return; end
					x = RDXDB.HasFeature(x.data, "header");
					if not x then return; end
					RDXDB.MiniFeatureEditor(nil, x, function(newfd)	VFL.copyOver(x, newfd); RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, w._path); end);
				end);
				if VFLP.IsEnabled() then
					-- Profiling hooks.
					VFLP.RegisterCategory("Win: " .. w._path);
					VFLP.RegisterFunc("Win: " .. w._path, "RepaintSecure", paintSecure, true);
					VFLP.RegisterFunc("Win: " .. w._path, "RepaintData", paintData, true);
					VFLP.RegisterFunc("Win: " .. w._path, "LookupUnit", lookupUnit, true);
					VFLT.AdaptiveSchedule("Perf" .. w._path, 1, function() w:SetPerfText(VFLP.GetCategoryCPU("Win: " .. w._path)); end);
				end
			end
		end

		-- DESTROY FUNCTION
		-- Tear down all this
		local function destroy()
			if VFLP.IsEnabled() then
				VFLT.AdaptiveUnschedule("Perf" .. win._path);
			end
			win:SetClient(nil); -- BUGFIX: remember to remove client refs before destroying client..
			-- Unbind events
			if nset then
				nset.SigNamesChanged:DisconnectByID(win);
				nset = nil;
			end
			-- Deacclimatize all frames
			for _,frame in grid:AllChildren() do Deacclimatize(grid, frame); end
			grid:Destroy(); grid = nil;
			if win._path then VFLP.UnregisterCategory("Win: " .. win._path); end
			VFL.empty(umap);
			win.LookupUnit = nil;
			win = nil;
		end

		-- At assembly time, download the default paintmask from the multiplexer...
		state:Attach("Assemble", true, function(state, win)
			defaultPaintMask = tonumber(state:GetSlotValue("DefaultPaintMask")) or 0;
			win.LookupUnit = lookupUnit;
		end);

		state:Attach("Create", true, create);
		state:Attach("Destroy", true, destroy);
		state:Attach("RepaintAll", nil, function()
			local succ,err = pcall(paintData, 1);
			if not succ then RDXDK.PrintError(win, "RepaintData", err); end
		end);
		state:Attach("RepaintLayout", nil, function()
			local succ,err = pcall(paintData, 1);
			if not succ then RDXDK.PrintError(win, "RepaintData", err); end
		end);
		state:Attach("RepaintData", nil, function(z)
			local succ,err = pcall(paintData, z);
			if not succ then RDXDK.PrintError(win, "RepaintData", err); end
		end);
	end,
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local hdef = RDXUI.HeaderEditor:new(ui); hdef:Show();
		if desc and desc.header then hdef:SetDescriptor(desc.header); end
		ui:InsertFrame(hdef);

		function ui:GetDescriptor()
			return { 
				feature = "header"; version = 1;
				header = hdef:GetDescriptor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "header"; version = 1;
		};
	end;
});


