-- StatWindow.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.

----------------------------------------------------------------------------
-- All raid status windows must have this base feature. Collects all the
-- Statistic features into one single iterator.
----------------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Raid Status DataSource",
	IsPossible = function(state)
		if not state:Slot("StatusWindow") then return nil; end
		if state:Slot("DataSource") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("DataSource");
		state:AddSlot("AddStatistic");
		state:AddSlot("DataSourceIterator");
		state:AddSlot("DataSourceSize");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local stats = {};

		-- Setup no hinting/aperiodicity
		local mux = state:GetSlotValue("Multiplexer");
		mux:SetNoHinting(true); mux:SetPeriod(nil);

		state:_SetSlotFunction("AddStatistic", function(st)
			if st then table.insert(stats, st); end
		end);
		state:_SetSlotFunction("DataSourceSize", function() return #stats; end);
		state:_SetSlotFunction("DataSourceIterator", function() return pairs(stats); end);
	end,
	UIFromDescriptor = function(desc, parent) return nil; end,
	CreateDescriptor = function() return {feature = "Raid Status DataSource"}; end,
});

---------------------------------------------------------------------------
-- Each Statistic in the window must be added as a feature.
---------------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Statistic"; multiple = true;
	IsPossible = function(state)
		if not state:Slot("AddStatistic") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if desc and desc.stat then
			local _,_,_,ty = RDXDB.GetObjectData(desc.stat);
			if(ty ~= "Statistic") then
				VFL.AddError(errs, "Invalid Statistic pointer.");
				return nil;
			end
			local si = RDXDB.GetObjectInstance(desc.stat);
			if not si then
				VFL.AddError(errs, "Invalid Statistic pointer.");
				return nil;
			end
			return true;
		else
			VFL.AddError(errs, "Bad or missing Statistic pointer.");
			return nil;
		end
	end;
	ApplyFeature = function(desc, state)
		local as = state:GetSlotFunction("AddStatistic");
		local si = RDXDB.GetObjectInstance(desc.stat);
		as(si);
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Statistic$")); end);
		ui:SetLabel(VFLI.i18n("Statistic"));
		if desc and desc.stat then ui:SetPath(desc.stat); end

		function ui:GetDescriptor()
			return {feature = "Statistic", stat = self:GetPath()};
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
	CreateDescriptor = function() return {feature = "Statistic"}; end;
});

---------------------------------------------------------------------------------------
-- The Iconic stat frame - displays stats as icons with current or current/max style.
---------------------------------------------------------------------------------------

local function ISF_Cleanup(frame)
end

local function ISF_SetData(frame, icv, stat)
	stat:Compute();
	frame.texture:SetTexture(stat.texture or "Interface\\InventoryItems\\WoWUnknownItem01.blp");
	local txt = "";
	if stat.pct then
		tempcolor:blend(_red, _white, stat:GetRatio());
		txt = tempcolor:GetFormatString() .. string.format("%0.0f%%", stat:GetRatio() * 100) .. "|r";
	elseif stat.sv == 2 then
		txt = VFL.strtcolor(stat.color) .. string.format("%d", stat:GetValue()) .. "|r";
	elseif stat.sv == 3 then
		txt = VFL.strtcolor(stat.color) .. string.format("%d/%d", stat:GetValue(), stat:GetMaxValue()) .. "|r";
	end
	frame.text:SetText(txt);
end

-- Create an iconic stat frame
local function CreateISF(frame, dim, fsz)
	frame:SetWidth(dim); frame:SetHeight(dim);

	local texture = VFLUI.CreateTexture(frame);
	texture:SetAllPoints(frame); texture:Show();
	frame.texture = texture;
	local txt = VFLUI.CreateFontString(frame);
	txt:SetWidth(dim); txt:SetHeight(fsz);
	txt:SetPoint("CENTER", frame, "CENTER");
	txt:SetFontObject(VFLUI.GetFont(Fonts.DefaultShadowed, fsz));
	txt:Show();
	frame.text = txt;

	frame.SetData = ISF_SetData; frame.Cleanup = ISF_Cleanup;

	frame.Destroy = VFL.hook(function(s)
		VFLUI.ReleaseRegion(s.texture); s.texture = nil;
		VFLUI.ReleaseRegion(s.text); s.text = nil;
		s.SetData = nil; s.Cleanup = nil;
	end, frame.Destroy);

	return frame;
end

RDX.RegisterFeature({
	name = "Stat Frames: Iconic";
	IsPossible = function(state)
		if not state:Slot("StatusWindow") then return nil; end
		if state:Slot("SetupSubFrame") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if desc then
			if not tonumber(desc.w) then
				VFL.AddError(errs, "Invalid dimension parameter.");
				return nil;
			end
			state:AddSlot("SetupSubFrame");
			state:AddSlot("SubFrameDimensions");
			return true;
		else
			VFL.AddError(errs, "Missing descriptor.");
			return nil;
		end
	end;
	ApplyFeature = function(desc, state)
		local dx, fsz = desc.w, VFL.clamp(desc.fsz,4,24);
		state:_SetSlotFunction("SubFrameDimensions", function() return dx, dx; end);
		state:_Attach(state:Slot("SetupSubFrame"), nil, function(frame) CreateISF(frame, dx, fsz); end);
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		local ed_width = VFLUI.LabeledEdit:new(ui, 50); ed_width:Show();
		ed_width:SetText(VFLI.i18n("Dimension of icons"));
		if desc and desc.w then ed_width.editBox:SetText(desc.w); end
		ui:InsertFrame(ed_width);

		local ed_fsz = VFLUI.LabeledEdit:new(ui, 50); ed_fsz:Show();
		ed_fsz:SetText(VFLI.i18n("Font size"));
		if desc and desc.fsz then ed_fsz.editBox:SetText(desc.fsz); end
		ui:InsertFrame(ed_fsz);

		function ui:GetDescriptor()
			local w = VFL.clamp(ed_width.editBox:GetNumber(), 0, 1000);
			local fsz = VFL.clamp(ed_fsz.editBox:GetNumber(), 0, 24);
			return { feature = "Stat Frames: Iconic"; w = w; fsz = fsz; };
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Stat Frames: Iconic"; w = 32; fsz = 10; };
	end;
});

------------------------------------------------------------------------------
-- The Bar Statframe - displays the statistic as a bar with a min/max ratio.
------------------------------------------------------------------------------
-- Cleanup a BSF
local function BSF_Cleanup(frame)
end

-- Apply data to a BSF
local function BSF_SetData(frame, icv, stat)
	stat:Compute();
	RDX.SetStatusBar(frame.bar, stat:GetRatio(), stat.color, stat.fadeColor);
	frame.text1:SetText(stat.name);
	local txt = "";
	if stat.pct then
		tempcolor:blend(_red, _white, stat:GetRatio());
		txt = " [" .. tempcolor:GetFormatString() .. string.format("%0.0f%%", stat:GetRatio() * 100) .. "|r]";
	end
	if stat.sv == 2 then
		txt = string.format("%d", stat:GetValue()) .. txt;
	elseif stat.sv == 3 then
		txt = string.format("%d/%d", stat:GetValue(), stat:GetMaxValue()) .. txt;
	end
	frame.text2:SetText(txt);
end

-- Create a bar statframe.
local function CreateBSF(frame, dx, dy, tdx, fsz)
	frame:SetWidth(dx); frame:SetHeight(dy);

	local bar = VFLUI.AcquireFrame("StatusBar");
	VFLUI.StdSetParent(bar, frame, -1);
	bar:SetAllPoints(frame);
	bar:SetStatusBarTexture("Interface\\Addons\\RDX\\Skin\\bar1");
	bar:SetMinMaxValues(0,1);	bar:Show();
	frame.bar = bar;
	
	-- Text 1
	local txt = VFLUI.CreateFontString(frame);
	txt:SetWidth(dx - tdx); txt:SetHeight(12);
	txt:SetPoint("LEFT", frame, "LEFT"); txt:SetJustifyH("LEFT");
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 10));
	txt:Show();
	frame.text1 = txt;

	-- Text 2
	txt = VFLUI.CreateFontString(frame);
	txt:SetWidth(tdx); txt:SetHeight(fsz);
	txt:SetPoint("RIGHT", frame, "RIGHT"); txt:SetJustifyH("RIGHT");
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, fsz));
	txt:Show();
	frame.text2 = txt;

	-- API
	frame.Cleanup = BSF_Cleanup; frame.SetData = BSF_SetData;

	frame.Destroy = VFL.hook(function(s)
		frame.bar:Destroy(); frame.bar = nil;
		VFLUI.ReleaseRegion(s.text1); s.text1 = nil;
		VFLUI.ReleaseRegion(s.text2); s.text2 = nil;
		frame.Cleanup = nil; frame.SetData = nil;
	end, frame.Destroy);

	return frame;
end

RDX.RegisterFeature({
	name = "Stat Frames: Bar";
	IsPossible = function(state)
		if not state:Slot("StatusWindow") then return nil; end
		if state:Slot("SetupSubFrame") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if desc then
			if (not tonumber(desc.w)) or (not tonumber(desc.h)) or (not tonumber(desc.tdx)) then
				VFL.AddError(errs, "Invalid dimension parameter.");
				return nil;
			end
			state:AddSlot("SetupSubFrame");
			state:AddSlot("SubFrameDimensions");
			return true;
		else
			VFL.AddError(errs, "Missing descriptor.");
			return nil;
		end
	end;
	ApplyFeature = function(desc, state)
		local dx,dy,tdx,fsz = desc.w, desc.h, desc.tdx, VFL.clamp(desc.fsz,5,24);
		state:_SetSlotFunction("SubFrameDimensions", function() return dx, dy; end);
		state:_Attach("SetupSubFrame", nil, function(f) CreateBSF(f, dx, dy, tdx, fsz); end);
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		local ed_width, ed_height = RDXUI.GenWidthHeightPortion(ui, desc, state);

		local ed_tdx = VFLUI.LabeledEdit:new(ui, 50); ed_tdx:Show();
		ed_tdx:SetText(VFLI.i18n("Status text width"));
		if desc and desc.tdx then ed_tdx.editBox:SetText(desc.tdx); end
		ui:InsertFrame(ed_tdx);

		local ed_fsz = VFLUI.LabeledEdit:new(ui, 50); ed_fsz:Show();
		ed_fsz:SetText(VFLI.i18n("Status text font size"));
		if desc and desc.fsz then ed_fsz.editBox:SetText(desc.fsz); end
		ui:InsertFrame(ed_fsz);

		function ui:GetDescriptor()
			local tdx = VFL.clamp(ed_tdx.editBox:GetNumber(), 0, 1000);
			local fsz = VFL.clamp(ed_fsz.editBox:GetNumber(), 0, 24);
			return { feature = "Stat Frames: Bar"; w = ed_width:GetSelection();
				h = ed_height:GetSelection(); tdx=tdx; fsz = fsz; };
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Stat Frames: Bar"; w = 120; h = 16; sv = 2; tdx = 50; fsz = 8; };
	end;
});
----------------------------------
-- Windowing system glue
----------------------------------
local state = RDXDB.ObjectState:new();
state.OnResetSlots = function(st)
	st:AddSlot("Create", true);	st:AddSlot("Hide", nil);	st:AddSlot("Show", nil);	st:AddSlot("Destroy", true);
	st:AddSlot("Window", nil);	st:AddSlot("StatusWindow", nil);
	-- Each window gets a new multiplexer
	state:SetSlotValue("Multiplexer", RDX.Multiplexer:new());

	-- On assembly, open the multiplexer.
	state:Attach(state:Slot("Assemble"), true, function(s,w)
		-- Apply the multiplexer to the window.
		local mux = s:GetSlotValue("Multiplexer");
		w.Multiplexer = mux;
		mux:Open(w);
		-- Compat.
		w.RepaintLayout = w.RepaintAll;

		s:Attach("Create", true, function(theWindow)
			theWindow.Multiplexer:Bind(theWindow);
		end);
		s:Attach("Show", true, function(theWindow)
			-- On show, always repaint all.
			theWindow.RepaintAll();
		end);
		s:Attach("Destroy", true, function(theWindow)
			theWindow.Multiplexer:Unbind(theWindow);
		end);

		-- Attach downstream menu hooks to WMMenu.
		w._WindowMenu = s:GetSlotFunction("Menu");
	end);	
end
state:Clear();

-- Error compilation, create a blank window
local function CreateErrWindow(state)
	state:AddFeature({feature = "Frame: Lightweight", title = "Error compilation", showtitlebar = true});
	state:_SetSlotFunction("SetTitleText", VFL.Noop);
	state:AddFeature({feature = "Raid Status DataSource"});
	state:AddFeature({feature = "Stat Frames: Bar",  w = 120, h = 16, sv = 2, tdx = 50, fsz = 8});
	state:AddFeature({feature = "Grid Layout", axis = 1, cols = 1, dxn = 1});
end

local function SetupStatusWindow(path, win, desc)
	if (not win) or (not desc) then return nil; end
	-- Load the features.
	state:LoadDescriptor(desc, path);
	local _errs = VFL.Error:new();
	if not state:ApplyAll(_errs) then
		_errs:ToErrorHandler("RDX", VFLI.i18n("Could not build status window at <") .. tostring(path) .. ">");
		--return nil;
		state:ResetSlots();
		CreateErrWindow(state);
	end
	_errs = nil;

	win:UnloadState();
	win:LoadState(state);
	win:Show();
	--if win.WMRebuild then win:WMRebuild(); end
	return true;
end
RDX.SetupStatusWindow = SetupStatusWindow;

-- Called after the Feature Editor is closed. Repopulates the window.
local function UpdateWindowAfterEdit(path, md, newState)
	md.data = newState:GetDescriptor();
	RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, path);
end

-- Open the feature editor for the window.
local function EditStatusWindow(parent, path, md)
	if not RDXIE.IsFeatureEditorOpen() then
		state:Rebuild(md.data, path);
		RDXIE.FeatureEditor(state, function(x) UpdateWindowAfterEdit(path, md, x); end, path, parent);
	end
end
RDX.EditStatusWindow = EditStatusWindow;

--[[
RDXDK.RegisterWindowClass({
	name = "statwin",
	Open = function(id)
		local _,_,qq = string.find(id,"^sw_(.*)$"); if not qq then return nil; end
		if not RDXDB.CheckObject(qq, "StatusWindow") then return nil; end
		return RDXDB.GetObjectInstance(qq);
	end;
	Close = function(win, id)
		local _,_,qq = string.find(id,"^sw_(.*)$");	if not qq then return nil; end
		RDXDB._RemoveInstance(qq);
		return true;
	end;
	Rebuild = function(win, id)
		local _,_,qq = string.find(id,"^sw_(.*)$");	if not qq then return nil; end
		local md = RDXDB.GetObjectData(qq);
		if (not md) or (not md.data) then return; end
		SetupStatusWindow(qq, win, md.data);
	end;
	Props = VFL.Noop;
});]]

RDXDB.RegisterObjectType({
	name = "StatusWindow"; 
	isFeatureDriven = true;
	New = function(path, md)
		md.version = 1;
	end,
	Edit = function(path, md, parent)
		EditStatusWindow(parent, path, md);
	end,
	Open = function(path, md)
		if not RDXDB.GetObjectInstance(path, true) then
			--RDXDK._OpenWindowRDX(path);
			RDXDK.QueueLockdownAction(RDXDK._OpenWindowRDX, path);
		end
	end,
	Close = function(path, md)
		local inst = RDXDB.GetObjectInstance(path, true);
		if inst then
			--RDXDK._CloseWindowRDX(path);
			RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, path);
		end
	end,
	Instantiate = function(path, obj)
		local w = RDX.Window:new(RDXParent); w:Show();
		if not SetupStatusWindow(path, w, obj.data) then w:Destroy(); return nil; end
		RDXDK.StdMove(w, w:GetTitleBar());
		return w;
	end,
	Deinstantiate = function(instance, path, obj)
		instance:Destroy();
		instance._path = nil;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
		if not RDXDB.PathHasInstance(path) then
			table.insert(mnu, {
				text = VFLI.i18n("Open"),
				func = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Open");
				end
			});
		else
			table.insert(mnu, {
				text = VFLI.i18n("Close"),
				func = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Close");
				end
			});
		end
	end,
});
