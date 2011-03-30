-- ObjectState.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- An object state is a set of functions and metadata that dictate how an object
-- should be built and updated.
--
-- A state is built of "features" which are applied in sequence. Each
-- feature imprints its changes on the state itself. After all features are applied,
-- the state can be assembled onto an object

RDXDB.ObjectState = {};
RDXDB.ObjectState.__index = RDXDB.ObjectState;

function RDXDB.ObjectState:new()
	local self = {};
	setmetatable(self, RDXDB.ObjectState);
	self:Clear();
	return self;
end

--------------------------------------------------------------
-- FEATURE LIST MANAGEMENT
-- The feature list is an internal data structure of the window
-- storing the features currently being applied.
--------------------------------------------------------------

--- Return the array of features of this state.
function RDXDB.ObjectState:Features()
	return self.features;
end

-- Get a feature by index
function RDXDB.ObjectState:_GetFeatureByIndex(idx)
	if not idx then return nil; end
	return self.features[idx];
end

-- Save a feature into the given index
function RDXDB.ObjectState:_SaveFeatureByIndex(idx, fd)
	if (not idx) or (not fd) then return nil; end
	if not self.features[idx] then return nil; end
	self.features[idx] = fd;
end

--- Reset the feature list
function RDXDB.ObjectState:Clear()
	self.features = {}; self.featuresByName = {}; self:ResetSlots();
	if self.OnReset then self:OnReset(); end
end

RDXDB.ObjectState.ClearFeatureList = RDXDB.ObjectState.Clear; -- COMPAT

function RDXDB.ObjectState:Backup()
	self.savefeatures = VFL.copy(self.features);
end

function RDXDB.ObjectState:Restore()
	self.features = VFL.copy(self.savefeatures);
end

--- Get the descriptor (which is really just the feature list)
function RDXDB.ObjectState:GetDescriptor()
	return VFL.copy(self.features);
end

--- Load a descriptor.
function RDXDB.ObjectState:LoadDescriptor(descr, path)
	self.path = path;
	self:Clear();
	for idx,feat in ipairs(descr) do self:AddFeatureInSitu(feat); end
end

--- Determine if a feature is possible on this ObjectState
function RDXDB.ObjectState:IsFeaturePossible(feat)
	if not feat then return nil; end
	if (not feat.multiple) and (self.featuresByName[feat.name]) then return nil; end
	if self.allowedFeatures then
		if not self.allowedFeatures[feat.name] then return nil; end
	elseif self.deniedFeatures then
		if self.deniedFeatures[feat.name] then return nil; end
	end
	return feat.IsPossible(self);
end

--- Determine if this ObjectState has a feature, by name
function RDXDB.ObjectState:HasFeatureNamed(name)
	if not name then return nil; end
	return self.featuresByName[name];
end

-- Helpers for feature manipulation
local function _ExposeFeature(desc, feat, state, errs)
	if (not desc) or (not feat) or (not state) then return nil; end
	return feat.ExposeFeature(desc, state, errs);
end
local function _IsFeaturePossible(feat, state)
	if (not feat) or (not state) then return nil; end
	return feat.IsPossible(state);
end

--- Set internal state to the in-situ state of the given index. This basically
-- means that all features above the given index will be Exposed, and all features at
-- or below will be ignored.
function RDXDB.ObjectState:InSituState(idx)
	-- Reset us
	self:ResetSlots();
	-- Sanity check
	if not idx then idx = table.getn(self.features) + 1; end
	if(idx < 1) or (idx > (table.getn(self.features) + 1)) then return nil; end
	-- Do it
	local featDesc, feat = nil, nil;
	for i=1,(idx-1) do
		featDesc = self.features[i];
		feat = RDXDB.GetFeatureByDescriptor(featDesc);
		if not featDesc.disable and _IsFeaturePossible(feat, self) then _ExposeFeature(featDesc, feat, self); end
	end
end

--- Add a feature to the end of this object's feature list.
function RDXDB.ObjectState:AddFeatureInSitu(featDesc)
	-- Verify integrity
	local feat = RDXDB.GetFeatureByDescriptor(featDesc);
	if not feat then return nil, VFLI.i18n("Couldn't find feature."); end
	table.insert(self.features, featDesc);
	self.featuresByName[feat.name] = true;
	if not feat.IsPossible(self) then return nil, VFLI.i18n("Feature is not possible."); end
	feat.ExposeFeature(featDesc, self);
	return true;
end

--- Directly add a feature, end-to-end, railroading past all
-- error checking. Call this only if you know what you're doing.
function RDXDB.ObjectState:AddFeature(featDesc)
	local feat = RDXDB.GetFeatureByDescriptor(featDesc);
	if not feat then return nil, VFLI.i18n("Couldn't find feature."); end
	table.insert(self.features, featDesc);
	self.featuresByName[feat.name] = true;
	if not feat.IsPossible(self) then return nil, VFLI.i18n("Feature is not possible."); end
	if feat.ExposeFeature(featDesc, self) then
		feat.ApplyFeature(featDesc, self);
	else
		return nil, VFLI.i18n("Could not ExposeFeature.");
	end
	return true;
end

--- Expose a feature in situ
function RDXDB.ObjectState:_ExposeFeatureInSitu(featDesc, feat, errs)
	return _ExposeFeature(featDesc, feat, self, errs);
end

--- Apply this object's feature list to itself. 
-- Should Verify first; un-verified features will be auto rejected.
function RDXDB.ObjectState:ApplyAll(errObj, preview)
	errObj = errObj or vflErrors;
	self:ResetSlots(); errObj:Clear();
	local pkg, obj = RDXDB.ParsePath(self.path);
	
	local ret, feat = true, nil;
	for idx,featDesc in ipairs(self.features) do
		if not featDesc.disable then
			feat = RDXDB.GetFeatureByDescriptor(featDesc);
			if feat then
				if errObj then errObj:SetContext(feat.name); end
				if feat.IsPossible(self) then
					if feat.ExposeFeature(featDesc, self, errObj) then
						feat.ApplyFeature(featDesc, self, pkg, obj, preview);
					else
						VFL.AddError(errObj, VFLI.i18n("Feature options contain errors. Check the Feature Editor."));
						ret = nil;
					end
				else
					VFL.AddError(errObj, VFLI.i18n("Feature cannot be added. Check that the prerequisites are met."));
					ret = nil;
				end
			else
				errObj:SetContext(nil);
			end
		end
	end
	return ret;
end

--- Verify this object's features by Exposing them.
function RDXDB.ObjectState:Verify(errObj)
	errObj = errObj or vflErrors;	self:ResetSlots(); errObj:Clear();

	local ret,feat = true,nil;
	for idx,featDesc in ipairs(self.features) do
		if not featDesc.disable then
			feat = RDXDB.GetFeatureByDescriptor(featDesc);
			if feat then
				if errObj then errObj:SetContext(feat.name); end
				if feat.IsPossible(self) then
					if not feat.ExposeFeature(featDesc, self, errObj) then
						VFL.AddError(errObj, VFLI.i18n("Feature options contain errors. Check the Feature Editor."));
						ret = nil;
					end
				else
					VFL.AddError(errObj, VFLI.i18n("Feature cannot be added. Check that the prerequisites are met."));
					ret = nil;
				end
			else
				errObj:SetContext(nil);
			end
		end
	end
	return ret;
end

--- Completely reload a descriptor, applying all features as well
function RDXDB.ObjectState:Rebuild(desc, path)
	self:LoadDescriptor(desc, path);
	self:ApplyAll();
end

--- Verify the feature at the given index.
function RDXDB.ObjectState:VerifyAt(idx, errs)
	local featDesc = self.features[idx];
	local feat = RDXDB.GetFeatureByDescriptor(featDesc);
	if (not featDesc) or (not feat) then return nil; end
	if errs then errs:SetContext(feat.name); end
	return feat.ExposeFeature(featDesc, self, errs);
end

----------------------------------------------------------------
-- SLOT MANAGEMENT
-- A slot is a hookable function that imbues the underlying window
-- with functionality, or is otherwise used as a marker by features.
----------------------------------------------------------------

--- Reset all the slots of a ObjectState, keeping the features
function RDXDB.ObjectState:ResetSlots()
	self.slots = {};
	self:AddSlot("Assemble", true);
	if self.OnResetSlots then self:OnResetSlots(); end
end

--- Iterate over the slots of an object matching a given pattern.
function RDXDB.ObjectState:SlotsMatching(ptn)
	local ck, cv, qq = nil, nil, self.slots;
	return function()
		ck, cv = next(qq, ck);
		while (ck and not string.find(ck, ptn)) do ck, cv = next(qq, ck); end
		if not ck then return nil; else return ck, cv; end
	end
end

--- Determine if the object has any slot at all matching the given pattern.
function RDXDB.ObjectState:HasSlotLike(ptn)
	for k,v in self.slots do
		if string.find(k, ptn) then return v; end
	end
	return nil;
end

--- Add a slot to this window state. Does nothing if the slot already exists.
function RDXDB.ObjectState:AddSlot(name, hookable)
	local s = self.slots;
	if s[name] then return nil; end
--	local smeta = { name = name, hookable = hookable, func = nil };
--	s[name] = smeta;
	s[name] = true;
	return true;
end

--- Determine if a slot exists on this state.
function RDXDB.ObjectState:Slot(name)
	if not name then return; end
	if self.slots[name] then return name; end
end
function RDXDB.ObjectState:HasSlots(...)
	local sl = self.slots;
	for i=1,select("#",...) do
		local x = select(i, ...);
		if (not x) or (not sl[x]) then return nil; end
	end
	return true;
end

function RDXDB.ObjectState:ListSlots()
	VFL.print("*********************************");
	for k, v in pairs(self.slots) do
		VFL.print(k);
	end
end

--- Determine if a slot is able to be bound to, hookably or not.
function RDXDB.ObjectState:CheckSlot(name, hookable)
	if not name then return nil; end
	local slot = self.slots[name]; if not slot then return nil; end
	if self.allowedSlots then
		if (not self.allowedSlots[name]) then return nil; end
	elseif self.deniedSlots then
		if self.deniedSlots[name] then return nil; end
	end
	return true;
end

--- Directly attach a function to a slot.
function RDXDB.ObjectState:Attach(slot, hookable, fn)
	if not slot then return; end
	local val = self.slots[slot];
	if val == true then
		self.slots[slot] = fn;
	else
		self.slots[slot] = VFL.hook(val, fn);
	end
	return true;
end

RDXDB.ObjectState._Attach = RDXDB.ObjectState.Attach;

--- Get a function for the given slot
function RDXDB.ObjectState:GetSlotFunction(name)
	if not name then return VFL.Noop; end
	local slot = self.slots[name];
	if type(slot) == "function" then return slot; else return VFL.Noop; end
end

-- Directly overwrite a slot's function
function RDXDB.ObjectState:_SetSlotFunction(name, func)
	if (not name) or (not self.slots[name]) then return nil; end
	self.slots[name] = func;	
end

function RDXDB.ObjectState:SetSlotValue(name, val)
	self.slots[name] = val;
end

function RDXDB.ObjectState:GetSlotValue(name)
	return self.slots[name];
end

function RDXDB.ObjectState:AppendSlotValue(name, x)
	self.slots[name] = self.slots[name] .. x;
end

function RDXDB.ObjectState:PrependSlotValue(name, x)
	self.slots[name] = x .. self.slots[name];
end

--- Execute the given slot with the given parameters.
function RDXDB.ObjectState:RunSlot(name, ...)
	if not name then return nil; end
	local slot = self.slots[name]; if type(slot) ~= "function" then return nil; end
	return slot(...);
end

--- Assemble this window state onto a window.
function RDXDB.ObjectState:Assemble(win)
	if self.OnAssemble then self:OnAssemble(win); end
	self:RunSlot("Assemble", self, win);
end
