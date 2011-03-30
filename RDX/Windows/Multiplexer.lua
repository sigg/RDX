-- Multiplexer.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE LICENSE.
-- UNLICENSED COPYING IS PROHIBITED.
--
-- The core of the new mask-driven paint engine. The multiplexer's duties are many:
--
-- 1) Handle "event floods" reasonably, for instance, by throttling the # of repaints per unit time like the
--    old Periodic Multiplexer.
-- 2) Hand out paintmask IDs on local windows.
-- 3) When an event hits, find the frame(s) associated with the event and update their paintmasks appropriately.
-- 4) Maintain a "default paintmask"

local bor, band = bit.bor, bit.band;
----------------------------------------
-- MULTIPLEXER OBJECT
----------------------------------------
RDX.Multiplexer = {};
RDX.Multiplexer.__index = RDX.Multiplexer;

--- Create a new multiplexer with the given functions.
function RDX.Multiplexer:new()
	local x = {};
	setmetatable(x, RDX.Multiplexer);

	-- Current paintmask index
	x.pm = 2; x.paintmasks = {};
	-- Event binds
	x.binds = {};
	-- Default period
	x.period = 0.075;

	return x;
end

-------------------------- PARAMETERS
function RDX.Multiplexer:SetPeriod(p)
	if not p then self.period = nil; return; end
	p = tonumber(p); if not p then p = .075; end
	self.period = VFL.clamp(p, 0.01, 5);
end
function RDX.Multiplexer:SetNoHinting(flag)
	if flag then self.noHinting = true; else self.noHinting = nil; end
end

-------------------------- PAINT MASKS
--- Create a new paint mask on this multiplexer
function RDX.Multiplexer:_CreatePaintMask()
	local mask = self.pm; self.pm = self.pm + 1;
	if mask > 30 then error(VFLI.i18n("Exceeded the hard limit of 30 paintmasks per window. Try reducing the number of components on this window.")); end
	return mask;
end

--- Get a paint mask by ID from this multiplexer, creating it if it doesn't exist yet.
function RDX.Multiplexer:GetPaintMask(id)
	local mask = self.paintmasks[id];
	if mask then return mask; end
	mask = 2^(self:_CreatePaintMask());
	self.paintmasks[id] = mask;
	return mask;
end

--- Get the "response paintmask" for the given IDs. If any of these masks trigger, a band will return nonzero.
function RDX.Multiplexer:RepaintOnMasks(...)
	local ret = 1;
	for i=1,select("#",...) do
		ret = bor( ret, self:GetPaintMask(select(i, ...)) )
	end
	return ret;
end

----------------------------- EVENT HINTING/BINDINGS
--- When the given event name fires, the unit specified by arg1 will have the
-- given mask applied.
function RDX.Multiplexer:Event_UnitMask(event, mask, force)
	if type(event) ~= "string" then return; end
	local ev = self.binds[event];
	if ev then
		if (ev.ty == "UNIT_MASK") then
			-- If there's already a unit mask for this event, add the new mask.
			ev.mask = bor(ev.mask, mask);
		end
	else
		self.binds[event] = {
			ty = "UNIT_MASK";
			mask = mask;
		};
	end
end

--- When the given event name fires, ALL frames in this window will have the given
-- mask applied.
function RDX.Multiplexer:Event_MaskAll(event, mask)
	if type(event) ~= "string" then return; end
	local ev = self.binds[event];
	if ev then
		if (ev.ty == "UNIT_MASK") then
			-- Upgrade the UNIT_MASK to a MASK_ALL, merging the masks in the process.
			ev.ty = "MASK_ALL"; ev.mask = bor(ev.mask, mask);
		elseif(ev.ty == "MASK_ALL") then
			-- Just merge the masks.
			ev.mask = bor(ev.mask, mask);
		end
	else
		self.binds[event] = {
			ty = "MASK_ALL";
			mask = mask;
		};
	end
end

--- When the given event name fires, ALL frames in this window will have the given
-- mask applied BUT ONLY IF the unit for which the event fires is PRESENT in the window.
function RDX.Multiplexer:Event_MaskAllIfPresent(event, mask)
	if type(event) ~= "string" then return; end
	local ev = self.binds[event];
	if ev then
		if (ev.ty == "UNIT_MASK") then
			ev.ty = "MASK_ALL_IF_PRESENT"; ev.mask = bor(ev.mask, mask);
		elseif(ev.ty == "MASK_ALL_IF_PRESENT") then
			ev.mask = bor(ev.mask, mask);
		end
	else
		self.binds[event] = {
			ty = "MASK_ALL_IF_PRESENT";
			mask = mask;
		};
	end
end

--- Bind the delta event of a given set to this multiplexer in such a way that for every
-- delta of the set, the given mask is applied to the delta units.
function RDX.Multiplexer:Event_SetDeltaMask(set, mask)
	if type(set) ~= "table" or (not set.SigUpdate) then return; end
	local ev = self.binds[set];
	if ev then	
		if (ev.ty == "DELTA_MASK") or (ev.ty == "UPDATE_MASK_ALL") then 
			-- If there's already a masked event associated to this set, add us to the mask.
			ev.mask = bor(ev.mask, mask); 
		else 
			-- Abort; a higher up event is already here.
			return; 
		end
	else
		self.binds[set] = {
			ty = "DELTA_MASK";
			mask = mask;
		};
	end
end

--- Bind the SigUpdate of the given object to this window. When it fires, mask ALL the frames
-- in the window with the given mask.
function RDX.Multiplexer:Event_SigUpdateMaskAll(obj, mask)
	if type(obj) ~= "table" or (not obj.SigUpdate) then return; end
	local ev = self.binds[obj];
	if ev then
		if ev.ty == "DELTA_MASK" then
			-- Upgrade a delta mask to a mask all
			ev.ty = "UPDATE_MASK_ALL"; ev.mask = bor(ev.mask, mask);
		elseif ev.ty == "UPDATE_MASK_ALL" then
			-- Straight importation of the mask.
			ev.mask = bor(ev.mask, mask);
		end
	else
		self.binds[obj] = {
			ty = "UPDATE_MASK_ALL";
			mask = mask;
		};
	end
end

--- When the given sort triggers a level 2 update, RepaintLayout, else RepaintForce(1).
function RDX.Multiplexer:Event_SortDataSource(sort)
	if type(sort) ~= "table" or (not sort.SigUpdate) then return; end
	local ev = self.binds[sort];
	if ev then
		ev.ty = "SORT_DATA_SOURCE"; ev.mask = nil;
	else
		self.binds[sort] = { ty = "SORT_DATA_SOURCE"; }
	end
end

--- Whenever the given set fires an update, RepaintLayout.
function RDX.Multiplexer:Event_SetDataSource(set)
	if type(set) ~= "table" or (not set.SigUpdate) then return; end
	local ev = self.binds[set];
	if ev then
		-- Quash all previous events on this set; just outright replace them.
		ev.ty = "SET_DATA_SOURCE"; ev.mask = nil;
	else
		self.binds[set] = {	ty = "SET_DATA_SOURCE" };
	end
end

--- Force hinting on a given event.
function RDX.Multiplexer:_ForceHinting(evname)
	local ev = self.binds[evname]; if not ev then return; end
	ev.forceHinting = true;
end

-- Apply the modifications to this frame's repaint functions (should be run before :Assemble())
function RDX.Multiplexer:Open(win)
	-- Get all the paint functions from the containing window.
	local rd, rs, ra = win.RepaintData, win.RepaintSort, win.RepaintAll;

	-- Artificially promote missing functions to their appropriate counterparts.
	if (not rd) or (rd == VFL.Noop) then rd = ra; end
	if (not rs) or (rs == VFL.Noop) then rs = rd; end

	-- If this multiplexer is periodic, redefine its repaint structures appropriately.
	if self.period then
		local s,z = 0,0;
		local sfunc = {rd, rs, ra}; sfunc[0] = VFL.Noop;
		local function updater()
			sfunc[s](z); s=0; z=0; 
		end
		local plexer, terminator = VFLT.CreatePeriodicLatch(self.period, updater);

		ra = function() if s<3 then s=3; end plexer(); end;
		rs = function() if s<2 then s=2; end plexer(); end;
		rd = function(zp)
			if s<1 then s=1; end 
			z = bor(z,(zp or 0)); 
			plexer(); 
		end;
	end

	-- Override the window's paint code!
	win.RepaintData = rd; win.RepaintSort = rs; win.RepaintAll = ra;
end

--- Execute the binds for this multiplexer. Should run after :Assemble()
function RDX.Multiplexer:Bind(win)
	local rd, rs, ra, lu = win.RepaintData, win.RepaintSort, win.RepaintAll, win.LookupUnit;

	-- Bind disruptions directly to repaintall.
	RDXEvents:Bind("DISRUPT_WINDOWS", nil, ra, self);

	local baseHinting = (not self.noHinting);

	-- Bind events
	for k,v in pairs(self.binds) do
		local ty = v.ty;
		local hinting = baseHinting or v.forceHinting;
		RDX:Debug(10, "AutoEvent Bind: ", ty, " on ", tostring(k), " -> ", tostring(win));
		if ty == "SET_DATA_SOURCE" then
			k.SigUpdate:Connect(nil, ra, self);
		elseif ty == "SORT_DATA_SOURCE" then
			k.SigUpdate:Connect(nil, function(_, lvl)
				if lvl == 1 then rs(); else ra(); end
			end, self);
		elseif (ty == "UPDATE_MASK_ALL") and hinting then
			local z = v.mask;
			k.SigUpdate:Connect(nil, function() rd(z); end, self);
		elseif (ty == "DELTA_MASK") and hinting then
			local z = v.mask;
			k.SigUpdate:Connect(nil, function(_, md, d)
				if md then
					-- Lookup each unit and modify paintmask
					for un in pairs(md) do
						local f = lu(nil, nil, un);
						if f and f._paintmask then f._paintmask = bor(f._paintmask, z); end
					end
					rd();
				else
					-- Find the single unit.
					local f = lu(nil, nil, d);
					if f and f._paintmask then f._paintmask = bor(f._paintmask, z); rd(); end
				end
			end, self);
		elseif (ty == "MASK_ALL") and hinting then
			local z = v.mask;
			RDXEvents:Bind(k, nil, function() rd(z); end, self);
		elseif (ty == "MASK_ALL_IF_PRESENT") and hinting then
			local z = v.mask;
			RDXEvents:Bind(k, nil, function(unit)	
				if lu(unit) then rd(z); end	
			end, self);
		elseif (ty == "UNIT_MASK") and hinting then
			local z = v.mask;
			RDXEvents:Bind(k, nil, function(unit)
				local f = lu(unit);
				if f and f._paintmask then 
					f._paintmask = bor(f._paintmask, z); rd();
				end
			end, self);
		end -- if...
	end -- for k,v in pairs(binds) do
end

--- Unbind all events associated to this multiplexer.
function RDX.Multiplexer:Unbind(win)
	RDX:Debug(10, "Mux:Unbind(", tostring(win), ")");
	RDXEvents:Unbind(self, "DISRUPT_WINDOWS");

	for k,v in pairs(self.binds) do
		local ty = v.ty;
		RDX:Debug(10, "AutoEvent Unbind: ", ty, " on ", tostring(k), " -> ", tostring(win));
		if (ty == "SET_DATA_SOURCE") or (ty == "SORT_DATA_SOURCE") or (ty == "UPDATE_MASK_ALL") or (ty == "DELTA_MASK") then
			k.SigUpdate:DisconnectByID(self);
		end
	end
	RDXEvents:Unbind(self);
	WoWEvents:Unbind(self);
end

--- Undo everything done by :Open.
function RDX.Multiplexer:Close(win)
	self:Unbind(win);
	VFL.empty(self.binds); 
	VFL.empty(self.paintmasks);
	self.pm = 2; 
	self.period = 0.075; self.noHinting = nil;
end


