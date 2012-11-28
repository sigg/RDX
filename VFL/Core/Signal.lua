--- Signal.lua
-- @author (C)2006 Bill Johnson and The VFL Project
-- @class file
-- @name VFL.Signal
-- @description A Signal is a device for calling methods in sequence. Usually called
-- to handle an outside stimulus and allow multiple procedures to gain
-- input from the stimulus.
-- Each Signal can have optional event handling methods attached to it
-- which will be called when certain things happen. The available methods are

local tinsert, tremove = table.insert, table.remove;

VFL.Signal = {};
VFL.Signal.__index = VFL.Signal;

--- Create a new, empty signal.
-- @param name The name of the signal
-- @param OnEmpty function s:OnEmpty() is called when the signal becomes empty.
-- @param OnNonEmpty function s:OnNonEmpty() is called when the signal becomes nonempty.
-- @return a new VFL.Signal object
function VFL.Signal:new(name, OnEmpty, OnNonEmpty)
	-- Initialize the signal to empty.
	local self = {};
	self.name = name or "(anonymous)";
	self.OnEmpty = OnEmpty;
	self.OnNonEmpty = OnNonEmpty;
	self.metadata = {};
	setmetatable(self, VFL.Signal);
	return self;
end

--- Test the signal for emptiness.
-- @return TRUE if the signal is empty.
function VFL.Signal:IsEmpty()
	if #self > 0 then return nil; else return true; end
end

--- Actuate the signal, calling all bound methods.
-- All the arguments are passed directly onto the called methods.
function VFL.Signal:Raise(...)
	for _,hsig in ipairs(self) do hsig(...); end
end

--- Connect a method to this signal.
-- @param obj The object to bind, or nil for a standalone method.
-- @param method The method to bind. This can either be a function (in which case the function will be invoked directly) or a string (in which case the function will be looked up)
-- @param id Optional - An ID that can be later used to unbind this object.
-- @return a handle to the connection that can be later used to manipulate it.
function VFL.Signal:Connect(obj, method, id)
	-- Verify method
	if (type(obj) == "table") and (type(method) == "string") then method = obj[method]; end
	if (type(method) ~= "function") then return nil; end
	-- Add to chain
	tinsert(self, VFL.WrapInvocation(obj, method));
	local hsig = {id = id, obj = obj, method = method};
	tinsert(self.metadata, hsig);
	-- Fire Nonempty handler if applicable
	if self.OnNonEmpty and (#self == 1) then self:OnNonEmpty(); end
	return hsig;
end

--- Determine if an ID is connected to this signal.
-- @param id An ID of the connected method
function VFL.Signal:IsIDConnected(id)
	if not id then return; end
	local md = self.metadata;
	for i=1,#self do if md[i].id == id then return true; end end
end

--- Disconnect an object or method from this signal using the handle returned by Connect()
-- @param handle A handle returned by a previous call to Signal:Connect().
function VFL.Signal:DisconnectByHandle(handle)
	if not handle then return; end
	local md = self.metadata;
	local n,i = #self, 1; if(n == 0) then return; end
	while (i<=n) do
		if (md[i] == handle) then tremove(self, i); tremove(md, i);	n=n-1; else i=i+1; end
	end
	-- Fire Empty handler if applicable
	if self.OnEmpty and (n == 0) then self:OnEmpty(); end
end

--- Disconnect an object or method from this signal matching the given ID.
-- @param id An ID used in Signal:Connect() to connect a method to this signal.
function VFL.Signal:DisconnectByID(id)
	if not id then return; end
	local md = self.metadata;
	local n,i = #self, 1; if (n == 0) then return; end
	while (i<=n) do
		if (md[i].id == id) then tremove(self, i);	tremove(md, i);	n=n-1; else i=i+1; end
	end
	-- Fire Empty handler if applicable
	if self.OnEmpty and (n == 0) then self:OnEmpty(); end
end

--- Disconnect an object or method from this signal by object or method pointer.
-- @param targ The object or method to be disconnected. If targ is a function, all bindings with matching
-- functions will be removed. If targ is a nonfunction, all bindings with matching objects will be removed.
function VFL.Signal:Disconnect(targ)
	local n,i = #self, 1; if (n == 0) or (not targ) then return; end
	local field = "obj"; if type(targ) == "function" then field = "method"; end
	local md = self.metadata;
	while(i <= n) do
		if (md[i][field] == targ) then tremove(self, i); tremove(md, i); n=n-1; else i=i+1; end
	end
	-- Fire Empty handler if applicable
	if self.OnEmpty and (n == 0) then self:OnEmpty(); end
end

--- Remove all objects from this signal.
function VFL.Signal:DisconnectAll()
	if(#self == 0) then return; end
	-- Quash all connected objects.
	for k,_ in ipairs(self) do self[k] = nil; end
	local md = self.metadata;
	for k,_ in ipairs(md) do md[k] = nil; end
	-- Fire Empty handler if applicable
	if self.OnEmpty then self:OnEmpty(); end
end