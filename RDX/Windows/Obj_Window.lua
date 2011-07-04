-- Obj_Window.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- This file contains copyrighted and licensed content. Unlicensed copying is prohibited.
-- See the accompanying LICENSE file for license terms.
--
-- Backend, registration and user interface for the Window object type.

-----------------------------------------------
-- The WindowState for a generic window.
-----------------------------------------------
RDX.WindowState = {};
function RDX.WindowState:new()
	local st = RDXDB.ObjectState:new();
	st.OnResetSlots = function(state)
		state:AddSlot("Create", true);
		state:AddSlot("PostCreate", true);
		state:AddSlot("Hide", true);
		state:AddSlot("Show", true);
		state:AddSlot("Destroy", true);
		state:AddSlot("Update", true);
		state:AddSlot("Window", nil);
	end;
	st:Clear();
	return st;
end

RDX.GenericWindowState = {};
function RDX.GenericWindowState:new()
	local st = RDXDB.ObjectState:new();
	st.OnResetSlots = function(state)
		state:AddSlot("Create", true); state:AddSlot("PostCreate", true); state:AddSlot("Hide", true); state:AddSlot("Show", true);
		state:AddSlot("Destroy", true);	state:AddSlot("Update", true); state:AddSlot("Window", nil);
		--state:AddSlot("UnitWindow", nil);
		state:AddSlot("Menu");
		-- Each window gets a new multiplexer
		state:SetSlotValue("Multiplexer", RDX.Multiplexer:new());
		-- On assembly, open the multiplexer.
		state:Attach(state:Slot("Assemble"), true, function(s,w)
			-- Apply the multiplexer to the window.
			local mux = s:GetSlotValue("Multiplexer");
			w.Multiplexer = mux;
			mux:SetPeriod(nil);
			mux:Open(w);
			-- Compat.
			w.RepaintLayout = w.RepaintAll;

			s:Attach("Create", true, function(theWindow)
				theWindow.Multiplexer:Bind(theWindow);
			end);
			s:Attach("Show", true, function(theWindow)
				-- On show, always repaint all.
				if theWindow.RepaintAll then
					theWindow.RepaintAll();
				end
			end);
			s:Attach("Destroy", true, function(theWindow)
				theWindow.Multiplexer:Unbind(theWindow);
			end);

			-- Attach downstream menu hooks to WMMenu.
			w._WindowMenu = s:GetSlotFunction("Menu");
		end);	
	end
	st:Clear();
	return st;
end

-- Error compilation, create a blank window
local function CreateErrWindow(state)
	state:AddFeature({feature = "Frame: Lightweight", title = VFLI.i18n("Error compilation"), showtitlebar = true});
	state:_SetSlotFunction("SetTitleText", VFL.Noop);
	state:AddFeature({feature = "Design", design = "default:Health_ds"});
	state:AddFeature({feature = "layout_single_unitframe", unit = "player", clickable = true});
end

--------------------------------------------------
-- The generic RDX Window object.
-- Provides slots for Create, Destroy, Show, and Hide events.
-- Based on the VFL Window object, which allows custom
-- framing.
--------------------------------------------------
RDX.Window = {};
function RDX.Window:new(parent)
	local self = VFLUI.InvertedControlWindow:new(parent);
	
	local hide, show, destroy, update = VFL.Noop, VFL.Noop, VFL.Noop, VFL.Noop;
	
	-- Properly invoke destructors.
	local function ProperDestroy()
		self._WindowMenu = nil; self.secure = nil;
		self:SetScript("OnUpdate", nil);
		if self:IsShown() and hide then hide(self); end
		if destroy then destroy(self); end
		if self.Multiplexer then self.Multiplexer:Close(self); self.Multiplexer = nil; end
		self.RepaintLayout = nil; self.RepaintSort = nil; self.RepaintData = nil; self.RepaintAll = nil;
		hide = nil; show = nil; destroy = nil; update = nil;
	end
	
	function self:UnloadState()
		self:SetClient(nil);
		ProperDestroy();
		self:TearDown();
	end

	function self:LoadState(state)
		self.RepaintAll = state:GetSlotFunction("RepaintAll");
		self.RepaintLayout = state:GetSlotFunction("RepaintAll"); -- COMPAT
		self.RepaintData = state:GetSlotFunction("RepaintData");
		self.RepaintSort = state:GetSlotFunction("RepaintSort");
		-- Run assembly functions
		(state:GetSlotFunction("Assemble"))(state, self);
		(state:GetSlotFunction("Create"))(self);
		(state:GetSlotFunction("PostCreate"))(self);
		-- Get API
		hide = state:GetSlotFunction("Hide"); show = state:GetSlotFunction("Show");
		update = state:GetSlotFunction("Update"); destroy = state:GetSlotFunction("Destroy");
		-- Bind API to window.
		if self:IsShown() then show(self); end
		self:SetScript("OnHide", hide);	self:SetScript("OnShow", show);
		if update ~= VFL.Noop then self:SetScript("OnUpdate", update); end
	end

	self.Destroy = VFL.hook(function(s)
		ProperDestroy();
		s.UnloadState = nil; s.LoadState = nil; s.Multiplexer = nil;
	end, self.Destroy);

	return self;
end

-----------------------------------------------------------
-- Window meta-control
-----------------------------------------------------------
-- Master priming function for compiling windows.
local function SetupWindow(path, win, desc)
	local state = RDX.GenericWindowState:new();
	if (not win) or (not desc) then return nil; end
	--RDX:Debug(5, "SetupWindow<", tostring(path), ">");
	
	-- Quash the old window
	win:UnloadState();
	
	-- Setup the new window
	win._path = path;

	-- Load the features.
	state:LoadDescriptor(desc, path);
	local _errs = VFL.Error:new();
	if not state:ApplyAll(_errs) then
		local feat = RDXDB.GetFeatureData(path, "Design");
		if not feat then feat = RDXDB.GetFeatureData(path, "Assist Frames"); end
		if not feat then VFL.TripError("RDX", VFLI.i18n("Could not build window at <") .. tostring(path) .. ">.", VFLI.i18n("The window at <") .. tostring(path) .. VFLI.i18n("> is missing a Frame type feature")); return nil; end
		local upath = feat["design"];
		_errs:ToErrorHandler("RDX", VFLI.i18n("Could not build window at <") .. tostring(path) .. ">");
		state:ResetSlots();
		CreateErrWindow(state);
		
		local desPkg, desFile = RDXDB.ParsePath(upath);
		state:_Attach(state:Slot("Create"), true, function(w)
			-- When the window's underlying unitframe is updated, rebuild it.
			RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(up, uf)
				if(up == desPkg) and (uf == desFile) then RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, w._path); end
			end, w._path .. upath);
		end);
		state:_Attach(state:Slot("Destroy"), true, function(w)
			-- Unbind us from the database update events
			RDXDBEvents:Unbind(w._path .. upath);
		end);
		
		-- Make a menu for editing the unitframe type.
		state:Attach("Menu", true, function(win, mnu)
			table.insert(mnu, {
				text = VFLI.i18n("Edit Original Design");
				OnClick = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(upath, "Edit", VFLDIALOG);
				end;
			});
		end);
		if RDXG.cdebug then
			state:Attach("Menu", true, function(win, mnu)
				local x = tostring(RDXM_Debug.GetStoreCompiledObject(upath) or "");
				table.insert(mnu, {
					text = VFLI.i18n("View Original Design Code");
					OnClick = function() VFL.poptree:Release(); VFL.Debug_ShowCode(x); end;
				});
			end);
		end
	end
	_errs = nil;

	-- Sanity check; make sure there are layouts and frames
	if (not state:Slot("Frame")) or (not state:Slot("Layout")) then
		VFL.TripError("RDX", VFLI.i18n("Cannot open window <") .. tostring(path) .. ">.", VFLI.i18n("The window at <") .. tostring(path) .. VFLI.i18n("> is missing a Frame or Layout."));
		return nil;
	end

	-- If we are in combat, and the pre- or post-build window is Secure, we can't rebuild it.
	--if (win.secure or state:Slot("SecureSubframes")) and InCombatLockdown() then
	if InCombatLockdown() then
		VFL.TripError("RDX", VFLI.i18n("Attempt to build secure window while in combat."), VFLI.i18n("Could not build secure window at <") .. tostring(path) .. VFLI.i18n(">. Player was in combat."));
		return nil;
	end
	if state:Slot("SecureSubframes") then win.secure = true; else win.secure = nil; end
	
	state:Attach("Menu", true, function(win, mnu)
		local feat = RDXDB.GetFeatureData(path, "Design");
		local upath = feat["design"];
		table.insert(mnu, {
			text = VFLI.i18n("Clone...");
			OnClick = function() VFL.poptree:Release(); RDX.CloneWindow(path, upath, VFLDIALOG); end;
		});
	end);

	
	-- Apply the features to the window. If the window will be secure, mark it so.
	win:LoadState(state);
	
	-- Destroy the state to prevent memory leakage
	state:Clear();

	return true;
end
RDX.SetupWindow = SetupWindow;

-- A general state object to be reused by this engine
local localstate = RDX.GenericWindowState:new();
RDX._exportedWindowState = RDX.GenericWindowState:new();

-- Called after the Feature Editor is closed. Repopulates the window.
local function UpdateWindowAfterEdit(path, md, newState)
	md.data = newState:GetDescriptor();
	RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, path);
end

-- Open the feature editor for the window.
local function EditWindow(parent, path, md)
	if not RDXIE.IsFeatureEditorOpen() then
		localstate:Rebuild(md.data, path);
		RDXIE.FeatureEditor(localstate, function(x) UpdateWindowAfterEdit(path, md, x); end, path, parent);
	end
end
RDX.EditWindow = EditWindow;

-- The Window object type.
RDXDB.RegisterObjectType({
	name = "Window";
	isFeatureDriven = true;
	New = function(path, md)
		md.version = 1;
	end,
	Edit = function(path, md, parent)
		EditWindow(parent, path, md);
	end,
	Open = function(path, md)
		if not RDXDB.GetObjectInstance(path, true) then
			RDXDK.QueueLockdownAction(RDXDK._OpenWindowRDX, path, true);
		end
	end,
	Close = function(path, md)
		local inst = RDXDB.GetObjectInstance(path, true);
		if inst then 
			RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, path);
		end
	end,
	Instantiate = function(path, md)
		local w = RDX.Window:new(RDXParent);
		-- Attempt to setup the window; if it fails, just bail out.
		if not SetupWindow(path, w, md.data) then w:Destroy(); return nil; end
		RDXDK.StdMove(w, w:GetTitleBar());
		RDX:Debug(5, "Instantiate WindowObject<", path, ">");
		return w;
	end,
	Deinstantiate = function(instance, path, md)
		instance:Hide(RDX.smooth);
		--RDX:Debug(5, "Hide WindowObject<", path, ">");
		--instance:Hide();
		if RDX.smooth then 
			VFLT.schedule(RDX.smooth, function()
				instance:Destroy();
				instance._path = nil; -- Remove the path previously stored
				RDX:Debug(5, "Deinstantiate WindowObject<", path, ">");
			end);
		else
			instance:Destroy();
			instance._path = nil; -- Remove the path previously stored
			RDX:Debug(5, "Deinstantiate WindowObject<", path, ">");
		end
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit..."),
			OnClick = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
		if not RDXDB.PathHasInstance(path) then
			table.insert(mnu, {
				text = VFLI.i18n("Open"),
				OnClick = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Open");
				end
			});
		else
			table.insert(mnu, {
				text = VFLI.i18n("Close"),
				OnClick = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Close");
				end
			});
		end
	end,
});

local dlg = nil;
function RDX.CloneWindow(path, upath, parent)
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(230); dlg:SetHeight(125);
	dlg:SetText("Clone Window");
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(200); sf:SetHeight(70);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	local ed_path = VFLUI.LabeledEdit:new(ui, 100); ed_path:Show();
	ed_path:SetText(VFLI.i18n("Window Path"));
	if path then ed_path.editBox:SetText(path); else ed_path.editBox:SetText("null"); end
	ui:InsertFrame(ed_path);
	
	local ed_upath = VFLUI.LabeledEdit:new(ui, 100); ed_upath:Show();
	ed_upath:SetText(VFLI.i18n("Design Path"));
	if upath then ed_upath.editBox:SetText(upath); else ed_upath.editBox:SetText("0"); end
	ui:InsertFrame(ed_upath);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "rdx_clonewindows");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	
	VFL.AddEscapeHandler(esch);
	function dlg:_esch() VFL.EscapeTo(esch); end
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT", -15, 0);
	btnOK:SetText("OK"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local new_path = ed_path.editBox:GetText();
		local new_upath = ed_upath.editBox:GetText();
		-- Do the clone
		
		-- Open it on the desktop
		VFL.EscapeTo(esch);
	end);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end
