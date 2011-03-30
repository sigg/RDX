-- EscapeHandler.lua
-- VFL
-- (C)2006 Bill Johnson, The VFL Project
--
-- Creates a callback system to bind to the ESCAPE key. Useful for allowing the
-- end user to abort out of UI feedback mechanisms easily.

--- The escape monitor frame.
VFLEscapeMonitor = CreateFrame("Frame", "VFLEscapeMonitor");
VFLEscapeMonitor:Hide();
table.insert(UISpecialFrames, "VFLEscapeMonitor");
VFLEscapeMonitor:SetScript("OnHide", function() VFL.Escape(); end);


local esch = {};

--- Simulate the press of the Escape key.
function VFL.Escape()
	local n = table.getn(esch);
	if(n == 0) then return; end
	-- Invoke the escape handler.
 	(table.remove(esch))();
	-- If there are still escape handlers left, reshow the frame
	n=n-1;
	if(n > 0) then VFLEscapeMonitor:Show(); end
end

--- "Escape to" the given escape handler, previously registered via AddEscapeHandler.
-- If the handler is found, this will invoke the handler and every handler above it in 
-- the stack. If the second argument is true, it will escape to the level ABOVE the
-- provided function.
function VFL.EscapeTo(f, elide)
	-- First, find f
	local fi, n = nil, table.getn(esch);
	for i=1,n do
		if esch[i] == f then fi = i; break; end
	end
	if not fi then return; end
	if elide then fi = fi + 1; if not esch[fi] then return; end end
	-- Invoke the escape handlers in stack-appropriate order.
	for i=n,fi,(-1) do 
		if esch[i] then	(esch[i])(); end
		esch[i] = nil;
	end
	-- If there are none left, hide the escape monitor
	if(fi == 1) then VFLEscapeMonitor:Hide(); else VFLEscapeMonitor:Show(); end
end

--- Add an escape handler. This function will be called the next time Escape is pressed.
-- Escape handlers form a last-in-first-out stack, with one ESC press causing one handler
-- to be invoked at a time.
function VFL.AddEscapeHandler(f)
	if not f then return; end
	VFLEscapeMonitor:Show();
	table.insert(esch, f);
end

--- Remove an escape handler previously registered by VFL.AddEscapeHandler.
function VFL.RemoveEscapeHandler(f)
	-- Find and remove the escape handler.
	for i=1,table.getn(esch) do
		if esch[i] == f then table.remove(esch, i); break; end
	end
	-- If there are no escape handlers left, hide the escape monitor.
	if table.getn(esch) == 0 then VFLEscapeMonitor:Hide(); end
end
