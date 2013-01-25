-- UnitFrameGlue.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Glue the custom UnitFrame system to the Windowing system.

-----------------------------------
-- The ObjectState for the design.
-----------------------------------
RDX.DesignState = {};
function RDX.DesignState:new()
	local st = RDXDB.ObjectState:new();

	st.SetContainingWindowState = function(state, cws)
		state._ownerWindowState = cws;
	end;

	st.GetContainingWindowState = function(state) return state._ownerWindowState; end

	st.OnResetSlots = function(state)
		-- Mark this state as a Design
		state:AddSlot("DesignFrame", nil);
		-- The owner window also gets a slot
		state:AddSlot("GetContainingWindowState", nil);
		local qq = state._ownerWindowState;
		state:_SetSlotFunction("GetContainingWindowState", function() return qq; end);
		-- Add the code-emitter slots
		state:AddSlot("EmitClosure", true);
		state:AddSlot("EmitCreatePreamble", true);
		state:AddSlot("EmitCreate", true);
		state:AddSlot("EmitReparent", true);
		state:AddSlot("EmitPaintPreamble", true);
		state:AddSlot("EmitPaint", true);
		state:AddSlot("EmitCleanupPreamble", true);
		state:AddSlot("EmitCleanup", true);
		state:AddSlot("EmitDestroy", true);
		state:AddSlot("PaintHint", true);
		-- Add the decor-frame slot
		state:AddSlot("Subframe_decor");
		state:AddSlot("Frame_decor");
	end

	st:Clear();
	return st;
end

----------------------------------------------------------------------
-- Code generation functor. Given a unitframe ObjectState, build the
-- create, paint, cleanup, and destroy functions.
----------------------------------------------------------------------
function RDX.DesignGeneratingFunctor(state, path, winpath, getcode)
	if not state then return nil; end

	--- Build the code from the features
	local code = VFL.Snippet:new();
	code:AppendCode([[
local windowpath = "]] .. tostring(winpath) .. [[";
local designpath = "]] .. tostring(path) .. [[";
local GetUnitByNumber = RDXDAL.GetUnitByNumber;
local UnitInGroup = RDXDAL.UnitInGroup;
local LoadBuffFromUnit = RDXDAL.LoadBuffFromUnit;
local LoadDebuffFromUnit = RDXDAL.LoadDebuffFromUnit;
local explodeRGBA = VFL.explodeRGBA;
local band, min, max, clamp, strformat = bit.band, math.min, math.max, VFL.clamp, string.format;
local btn, _i, _j, _avail, _bn, _tex, _apps, _meta, _start, _dur, _tl, _et, _dispelt, _caster, _isStealable, _name;
local btnOwner;
local _icons;
local text, word = "", "";
local textcolor = _grey
local tempcolor = {};
local _;
local myunit;
]]);
	state:RunSlot("EmitClosure", code);
	code:AppendCode([[
local function _paint(frame, icv, uid, unit, a1, a2, a3, a4, a5, a6, a7)
	if not unit then return; end
	if not uid then uid = unit.uid; end
	local paintmask = frame._paintmask or 0;
	if paintmask ~= 0 then
]]);
	state:RunSlot("EmitPaintPreamble", code);
	state:RunSlot("EmitPaint", code);
	code:AppendCode([[
	end
end
local function _cleanup(frame)
]]);
	state:RunSlot("EmitCleanupPreamble", code);
	state:RunSlot("EmitCleanup", code);
	code:AppendCode([[
end

local hindex = {};
local hpri = nil;
local function _hotspot_set(frame, id, spot)
	if not id then
		hpri = spot;
	else
		hindex[id] = spot;
	end
end
local function _hotspot_get(frame, id)
	if id then return hindex[id]; else return hpri; end
end

local function _create(frame)
	frame.Cleanup = _cleanup; frame.SetData = _paint;
	frame.GetHotspot = _hotspot_get; frame.SetHotspot = _hotspot_set;
	frame.Frame_decor = VFLUI.AcquireFrame("Frame");
	frame.Frame_decor:SetParent(frame);
	frame.Frame_decor:SetAllPoints(frame);
	frame.Frame_decor:Show();
]]);
	state:RunSlot("EmitCreatePreamble", code);
	state:RunSlot("EmitCreate", code);
	code:AppendCode([[

	frame.Destroy = VFL.hook(function(frame)
		frame.Cleanup = nil; frame.SetData = nil; 
]]);
	state:RunSlot("EmitDestroy", code);
		code:AppendCode([[
		frame.Frame_decor:Destroy(); frame.Frame_decor = nil;
		frame.GetHotspot = nil; frame.SetHotspot = nil;
		frame._paintmask = nil;
	end, frame.Destroy);

	return frame;
end

return _create;
]]);

	code = code:GetCode();

	-- If the debug module is enabled, store the compiled code for possible later analysis
	if path and RDXM_Debug.IsStoreCompilerActive() then
		RDXM_Debug.StoreCompiledObject(path, code);
	end
	
	if getcode then
		return code;
	else
		--- Execute the code
		local f, err = loadstring(code);
		if not f then
			VFL.TripError("RDX", VFLI.i18n("Could not compile Design."), VFLI.i18n("Error") .. ":" .. err .. VFLI.i18n("\n\nCode:\n------------\n") .. code);
			return nil;
		end
		return f();
	end
end

local dstate = RDX.DesignState:new();

-- Unitframe state object used throughout
function RDX.LoadDesign(path, func, windowState)
	if not func then func = dstate.ApplyAll; end
	local md,_,_,ty = RDXDB.GetObjectData(path);
	if (not md) or (not md.data) or (md.ty ~= "Design") then return nil; end
	dstate:SetContainingWindowState(windowState);
	dstate:LoadDescriptor(md.data, path);
	local _errs = VFL.Error:new();
	if not func(dstate, _errs, path) then
		_errs:ToErrorHandler("RDX", VFLI.i18n("Could not load Design at <") .. tostring(path) .. ">");
		return nil;
	end
	return dstate;
end

-----------------------------------------------------------------
-- The Design feature.
-----------------------------------------------------------------
RDX.RegisterFeature({
	name = "Design",
	title = "Design",
	category = "Subframes";
	IsPossible = function(state)
		--if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Frame") then return nil; end
		if state:Slot("StatusWindow") then return nil; end
		if state:Slot("DesignFrame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if (not desc) or (not desc.design) then
			VFL.AddError(errs, VFLI.i18n("Missing Design"));
			return nil;
		else
			if not RDX.LoadDesign(desc.design, RDXDB.ObjectState.Verify, state) then return nil; end
		end
		state:AddSlot("UnitWindow", nil);
		state:AddSlot("DesignFrame");
		state:AddSlot("SetupSubFrame");
		state:AddSlot("SubFrameDimensions");
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- This variable will hold the frame pool for all unit frames associated to
		-- this window.
		local fp = nil;
		
		-- store un the state path
		state:SetSlotValue("windowpath", state.path);
		state:SetSlotValue("designpath", desc.design);

		-- Load the functions from the design object provided by the user.
		local path = desc.design;
		local desPkg, desFile = RDXDB.ParsePath(desc.design);
		if not RDX.LoadDesign(desc.design, nil, state) then return nil; end
		local createFrame  = RDX.DesignGeneratingFunctor(dstate, desc.design, state.path);	
		if not createFrame then return nil; end

		-- Attach a function allowing other processes to get the ambient dimensions of the unit frame
		local dx,dy = dstate:RunSlot("FrameDimensions");
		state:_Attach(state:Slot("SubFrameDimensions"), nil, function() return dx,dy; end);
	
		state:_Attach(state:Slot("Create"), true, function(w)
			-- When the window's underlying unitframe is updated, rebuild it.
			RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(up, uf)
				if(up == desPkg) and (uf == desFile) then RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, w._path); end
			end, w._path .. path);
		end);
		
		-- The UnitFrame function should imbue a frame with unit-frame-hood
		state:_Attach(state:Slot("SetupSubFrame"), nil, createFrame);
		
		state:_Attach(state:Slot("Destroy"), true, function(w)
			-- Unbind us from the database update events
			RDXDBEvents:Unbind(w._path .. path);
		end);

		-- Make a menu for editing the unitframe type.
		--state:Attach("Menu", true, function(win, mnu)
		--		table.insert(mnu, {
		--			text = VFLI.i18n("Edit Design");
		--			OnClick = function()
		--				VFL.poptree:Release();
		--				RDXDB.OpenObject(path, "Edit", VFLDIALOG);
		--			end;
		--		});
		--end);
		
		--if RDXM_Debug.IsStoreCompilerActive() then
		--	state:Attach("Menu", true, function(win, mnu)
		--		local x = tostring(RDXM_Debug.GetStoreCompiledObject(path) or "");
		--		table.insert(mnu, {
		--			text = VFLI.i18n("View Design Code");
		--			OnClick = function() VFL.poptree:Release(); VFL.Debug_ShowCode(x); end;
		--		});
		--	end);
		--end

		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ofDesign = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty=="Design"); end);
		ofDesign:SetLabel(VFLI.i18n("Design"));
		if desc and desc.design then ofDesign:SetPath(desc.design); end
		ui:InsertFrame(ofDesign);

		function ui:GetDescriptor()
			return { feature = "Design", design = ofDesign:GetPath() };
		end
		
		return ui;
	end,
	CreateDescriptor = function() return { feature = "Design" }; end,
});

RDX.RegisterFeature({
	name = "UnitFrame";
	version = 31337;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "Design"; desc.version = 1; 
		return true;
	end;
});

RDX.RegisterFeature({
	name = "ArtFrame";
	version = 31337;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "Design"; desc.version = 1; 
		return true;
	end;
});
