--- Io.lua
-- @author (C) 2005-2006 Bill Johnson and The VFL Project
--
-- Contains various useful primitive operations on functions, strings, and tables.
--
-- Notational conventions are:
-- STRUCTURAL PARAMETERS
--    T is a table. k,v indicate keys and values of T respectively
--    A is an array (table with positive integer keys)
--		L is a list (table with keys ignored) L' < L indicates the sublist relation.
-- FUNCTION PARAMETERS:
--    b is a boolean predicate on an applicable domain (must return true/false)
--    f is a function to be specified.
-- OTHER PARAMETERS:
--    x is an arbitrary parameter.

--- Print a single line to the chat window.
function VFL.print(str)
	if (str == nil) then str = "nil";
	elseif type(str) == "boolean" then str = tostring(str);
	elseif type(str) == "number" then str = tostring(str);
	elseif type(str) == "function" then str = "function";
	elseif type(str) == "table" then str = "table";
	end
	--if DEFAULT_CHAT_FRAME then
	--	DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFFFF[VFL]|r " .. str, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	--end
	if VFLIO and VFLIO.Console then
		VFLIO.Console:AddMessage("|cFFFFFFFF[VFL]|r " .. str, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	if VFLIO and VFLIO.Chatframe1 then
		VFLIO.Chatframe1.cf:AddMessage("|cFFFFFFFF[VFL]|r " .. str, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
end

--- Print a single line after format it.
function VFL.vprint(str, ...)
	VFL.print(format (str, ...) or "nil");
end

--- Print the contain of a table "KEY " .. k .. ",VALUE " .. v
function VFL.tprint(table)
	if type(table) ~= "table" then VFL.print(table); return; end
	for k,v in pairs(table) do 
		if type(v) == "boolean" then v = "boolean";
		elseif type(v) == "table" then v = "table"; 
		elseif type(v) == "function" then v = "function";
		--else v = "other";
		end
		VFL.print("KEY " .. k .. ",VALUE " .. v);
	end
end

--- Print a single line in the center of the screen.
function VFL.cprint(str)
	if(str == nil) then return; end
	UIErrorsFrame:AddMessage(str, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1.0, UIERRORS_HOLD_TIME);
end

--- Print a string for debugging at the given verbosity level.
function VFL.debug(str, level)
	if(not level) or (VFL._dv > level) then
		VFL.print("[Debug] " .. str);
	end
end

--- Print hex string
function VFL.hprint(str)
	for n = 1, #str, 4 do
		local s = "";
		for n2 = n, min (#str, n + 3) do
			s = s .. format (" %x", strbyte (str, n2));
		end
		VFL.print(s);
	end
end

--- Print frame
function VFL.fprint(frame)
	local parent = frame:GetParent();
	VFL.print(format(" Frame: %s Shown%d Vis%d P>%s", frame:GetName() or "nil", frame:IsShown() or 0, frame:IsVisible() or 0, parent and parent:GetName() or "nil"));
	VFL.print(format(" EScale %f, Lvl %f", frame:GetEffectiveScale(), frame:GetFrameLevel()));
	VFL.print(format(" LR %f, %f", frame:GetLeft() or -999, frame:GetRight() or -999));
	VFL.print(format(" BT %f, %f", frame:GetBottom() or -999, frame:GetTop() or -999));

	local reg = { frame:GetRegions() };
	for n, o in ipairs (reg) do
		local str = "";
		if o:IsObjectType ("Texture") then
			str = o:GetTexture();
		end
		VFL.print(format("  %d %s: %s", n, o:GetObjectType(), str));
	end
end

--- Print frame children
function VFL.fcprint(frame, lvl)

	lvl = lvl or 1

	local pad = ""

	for n = 1, lvl do
		pad = pad.." "
	end

	local ch = { frame:GetChildren() }

	for n = 1, #ch do

		local c = ch[n]

		if c:IsObjectType ("Frame") then

			VFL.print(format("%s#%d %s ID%s (%s) show%d l%d x%d y%d", pad, n, c:GetName() or "nil",
				c:GetID() or "nil", c:GetObjectType(),
				c:IsShown() or 0, frame:GetFrameLevel(),
				c:GetLeft() or -99999, c:GetTop() or -99999
				));

			VFL.fcprint(c, lvl + 1);
		end
	end
end