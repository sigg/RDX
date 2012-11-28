--- DispatchTable.lua
-- @author (C)2006 Bill Johnson and The VFL Project
-- @class file
-- @name VFL.DispatchTable
-- @description A dispatch table is a keyed table of signals that can be Connected and Raised
-- by key.
-- The DispatchTable can have optional event handling methods that are triggered
-- when certain things happen.

DispatchTable = {};
-- The metatable for dispatch tables
local DispatchPrototype = {};
local DispatchMeta = {};
DispatchMeta.__index = DispatchPrototype;

-- Automatic key deleter submethod.
local function _DeleteAssociatedKey(sig)
	sig._dt_parent:DeleteKey(sig._dt_key);
end

--- Get the signal associated to the given key, creating it if it does not exist.
-- @param key The key to acquire.
-- @return The signal at the key, or NIL if the action is impossible.
function DispatchPrototype:GetSignal(key)
	-- Sanity check
	if not key then return nil; end
	-- If the key already exists, just return the signal
	local sig = self.dtbl[key];
	if sig then return sig; end
	-- If not, create a new key
	sig = VFL.Signal:new();
	-- Name the signal
	sig.name = tostring(key); sig._dt_key = key; sig._dt_parent = self;
	-- Honor the OnCreateKey contract
	if self.OnCreateKey then
		if not self:OnCreateKey(key, sig) then return nil; end
	end
	-- Bind the signal's OnEmpty handler to a function that will auto-destroy the signal
	sig.OnEmpty = _DeleteAssociatedKey;
	-- Store the new signal and return it
	self.dtbl[key] = sig;
	return sig;
end

--- Lock the signal associated with this key, preventing it from being auto deleted
-- when it becomes empty. This can be used to make commonly-dispatched events more
-- efficient.
-- @param key The key to lock
-- @return sig The signal object.
function DispatchPrototype:LockSignal(key)
	local sig = self:GetSignal(key);
	sig.OnEmpty = nil;
	return sig;
end

--- Delete the signal at the given key. Don't call this unless you're sure you know what
-- you're doing. The normal method for removing dispatch entries is via proper use of :Bind(id)
-- and :Unbind(id).
-- @param key The key to destroy.
function DispatchPrototype:DeleteKey(key)
	local sig = self.dtbl[key];
	if not sig then return; end
	if self.OnDeleteKey then
		self:OnDeleteKey(key, sig);
	end
	self.dtbl[key] = nil;
end

--- Create a new binding on this dispatch table.
-- @param key The key to which the new binding should be associated.
-- @param object The object on which the binding will be invoked.
-- @param method The method that will be invoked when the binding is activated.
-- @param id Optional - An ID that can be used later to unbind this object.
-- @return If successful, a handle which can be later used with UnbindByHandle. If failed, NIL.
function DispatchPrototype:Bind(key, object, method, id)
	-- Get the signal associated with the key, creating if necessary
	local sig = self:GetSignal(key);
	if not sig then return nil; end
	-- Bind
	return sig:Connect(object, method, id);
end

--- Remove bindings from this dispatch table by ID.
-- @param id The ID used with DispatchTable:Bind(), all instances of which will be unbound.
-- @param event Optional - If provided, unbind the specific event only. ID must also match.
function DispatchPrototype:Unbind(id, event)
	if not event then
		for _,sig in pairs(self.dtbl) do
			sig:DisconnectByID(id);
		end
	else
		local sig = self.dtbl[event];
		if sig then sig:DisconnectByID(id); end
	end
end

--- Remove bindings from this dispatch table by handle.
-- @param handle The handle returned by DispatchTable:Bind(), which will be unbound.
function DispatchPrototype:UnbindByHandle(handle)
	for _,sig in pairs(self.dtbl) do
		sig:DisconnectByHandle(handle);
	end
end

--- Determine whether something with the given id is bound to the given key.
-- @param key The signal of this dispatch table
-- @param id The id of the method
function DispatchPrototype:IsBound(key, id)
	local sig = self:GetSignal(key);
	if not sig then return; end
	return sig:IsIDConnected(id);
end

--- Make a dispatch.
-- @param key The key to dispatch on. The remaining arguments are passed along as arguments to
-- the dispatch.
function DispatchPrototype:Dispatch(key, ...)
	local sig = self.dtbl[key]; if not sig then return; end
	for _,hsig in ipairs(sig) do hsig(...);	end
end
local _Dispatch = DispatchPrototype.Dispatch;

--- Make a dispatch if enough time has passed.
-- @param dt A time in seconds that must have passed since the last latched dispatch
-- or this dispatch is ignored
-- @param key The key to dispatch on. The remaining arguments are passed along as arguments to
-- the dispatch.
-- @return TRUE iff the dispatch was performed.
function DispatchPrototype:LatchedDispatch(dt, key, ...)
	local elapsed;
	local x,t = self.lasttime, GetTime();
	if not x then x = {}; self.lasttime = x; end
	if not ( (t - (x[key] or 0)) >= dt ) then return; end
	x[key] = t;
	local sig = self.dtbl[key];	if not sig then return; end
	for _,hsig in ipairs(sig) do hsig(...); end
	return true;
end

--- Force all dispatches to pass through the given debug provider.
-- Passing nil as provider removes any debugging.
-- @param prov The debug provider through which dispatches should flow.
-- @param level The debug level to use.
function DispatchPrototype:DebugDispatches(prov, level)
	if not prov then self.Dispatch = nil; end
	self.Dispatch = function(self, key, ...)
		prov:Debug(level, self.name, "> ", tostring(key), "(", tostring(select(1,...)), ",", tostring(select(2,...)), ",", tostring(select(3,...)), ", ...)")
		_Dispatch(self, key, ...);
	end
end

--- Create a new dispatch table
-- @param name The name of the dispatch table
-- @param OnCreateKey function dt:OnCreateKey(key, signal) is called whenever a new key is created.
--  Should return TRUE if the key creation should be allowed to proceed, NIL if not.
-- @param OnDeleteKey function dt:OnDeleteKey(key, signal) is called whenever a key is deleted.
-- @return A new, empty dispatch table.
function DispatchTable:new(name, OnCreateKey, OnDeleteKey)
	local self = {};
	self.dtbl = {}; 
	self.name = name or "(anonymous)";
	self.OnCreateKey = OnCreateKey;
	self.OnDeleteKey = OnDeleteKey;
	setmetatable(self, DispatchMeta);
	return self;
end

local function RegisterAdapter(frame, key) frame:RegisterEvent(key); return true; end
local function UnregisterAdapter(frame, key) frame:UnregisterEvent(key); return true; end

--- Convert a frame into a dispatch table. Slightly faster than maintaining a separate dispatch table;
-- also has the advantage of supporting native event args.
-- This operation CANNOT be reversed; once a frame is subsumed it is permanently so.
function DispatchTable:SubsumeFrame(frame)
	frame.dtbl = {}; frame.name = "(anonymous)";
	VFL.mixin(frame, DispatchPrototype);
	frame.OnCreateKey = RegisterAdapter;
	frame.OnDeleteKey = UnregisterAdapter;
	frame:SetScript("OnEvent", frame.Dispatch);
end

--- The root World of Warcraft event dispatcher
WoWEvents = CreateFrame("Frame"); WoWEvents:Show();
DispatchTable:SubsumeFrame(WoWEvents);

--- The VFL root event dispatcher.
VFLEvents = DispatchTable:new();
VFLEvents.name = "VFLEvents";
