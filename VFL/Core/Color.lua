--- Color.lua
-- @author (C)2006 Bill Johnson and The VFL Project
-- @description Data structures for dealing with color tables and color vectors.

local strformat = string.format;
local floor = floor;
local d, r, g, b, a, a1, a2;
local rshift = bit.rshift
local band = bit.band

-- Given three numbers x, y, z, put them in order from least to greatest. Returns a vector (min, mid, max).
local function ordinate(x,y,z)
	if x<=y then
		if y<=z then return x,y,z; elseif z<=x then	return z,x,y;	else return x,z,y; end
	else -- y<=x
		if x<=z then return y,x,z; elseif z<=y then return z,y,x;	else return y,z,x; end
	end
end

-- Convert an RGB(0,1) color to an HLS(0,1) color.
local function RGBtoHLS(r,g,b)
	-- Ordinate the RGB values. The luminosity is the max.
	local cmin, cmid, l = ordinate(r,g,b);
	-- Early out for black or grey
	if(l == 0) then return 0,0,0; end -- black
	if(l == cmin) then return 0,l,0; end

	-- Compute saturation (max-min)/max
	local s = (l - cmin) / l;

	-- Compute hue.
	local ofs = (cmid - cmin) / (l - cmin) / 6.0;

	if l == r then -- primary hue is red
		if cmid == g then -- intermediary hue is green
			return ofs, l, s;
		else -- intermediary hue is blue
			return 1-ofs, l, s;
		end
	elseif l == g then -- primary hue is green
		if cmid == b then -- intermediary hue is blue
			return .333333 + ofs, l, s;
		else -- intermediary hue is red
			return .333333 - ofs, l, s;
		end
	else -- primary hue is blue
		if cmid == r then -- intermediary is red
			return .666666 + ofs, l, s;
		else -- intermediary is green
			return .666666 - ofs, l, s;
		end
	end
end

-- Convert an HLS(0,1) color to an RGB(0,1) color.
local function HLStoRGB(h,l,s)
	-- Grey case
	if(l == 0) then return 0,0,0; elseif(s == 0) then return l,l,l; end
	-- Magic numbers
	local x1 = l * (1 - s);	local x2 = l - x1;
	-- Color wheel cases
	if(h < .166667) then -- red->green
		return l, x1 + (x2 * h * 6), x1;
	elseif(h < .333333) then -- yellow->red
		return l - (x2 * (h - .166667) * 6), l, x1;
	elseif(h < .5) then -- green->blue
		return x1, l, x1 + (x2 * (h - .333333) * 6);
	elseif(h < .666667) then -- cyan->green
		return x1, l - (x2 * (h - .5) * 6), l;
	elseif(h < .833333) then -- blue->red
		return x1 + (x2 * (h - .666667) * 6), x1, l;
	else -- magenta->blue
		return l, x1, l - (x2 * (h - .833333) * 6);
	end
end

-- GLOBAL COLOR METHODS
-- Some global methods to manipulate colors quickly.

--- Linearly interpolate two color values, returning a vector.
function VFL.CVFromCTLerp(c1, c2, t)
	d = 1-t;
	r,g,b = (d*c1.r + t*c2.r), (d*c1.g + t*c2.g), (d*c1.b + t*c2.b);
	a1,a2 = c1.a or 1, c2.a or 1;
	return r,g,b,(d*a1 + t*a2);
end

--- Retrieve a string formatting code from a color vector
function VFL.strcolor(r,g,b,a)
	return strformat("|c%02X%02X%02X%02X", floor((a or 1)*255), floor(r*255), floor(g*255), floor(b*255));
end

--- Retrieve a string formatting code from a color table
function VFL.strtcolor(t)
	if not t then t = _grey; end
	a1 = t.a or 1;
	r,g,b = floor(t.r*255), floor(t.g*255), floor(t.b*255);	a1 = floor(a1*255);
	return strformat("|c%02X%02X%02X%02X", a1, r, g, b);
end
function strtcolor(t)
	VFL.print("strtcolor is deprecated, replace it by VFL.strtcolor");
	return VFL.strtcolor(t);
end

--- Use a color table to color a string
function VFL.tcolorize(str, t)
	r,g,b,a1 = floor(t.r*255), floor(t.g*255), floor(t.b*255), floor((t.a or 1) * 255);
	return strformat("|c%02X%02X%02X%02X%s|r", a1, r, g, b, str);
end

--- Use a color vector to color a string
function VFL.colorize(str, r, g, b, a1)
	r = floor(r*255); g = floor(g*255); b = floor(b*255);	a1 = floor((a1 or 1) * 255);
	return strformat("|c%02X%02X%02X%02X%s|r", a1, r, g, b, str);
end

--- Convert a color table to a color 3-vector
function VFL.explodeColor(rgb)
	if not rgb then rgb = _grey; end
	return rgb.r, rgb.g, rgb.b;
end

--- Convert a color table to a color 4-vector
function VFL.explodeRGBA(rgb)
	if not rgb then rgb = _grey; end
	return rgb.r, rgb.g, rgb.b, rgb.a or 1;
end

--- Convert hex color string to R G B floats (0-1)
function VFL.explodeHexStringColor(colors)
	r = tonumber (strsub (colors, 1, 2), 16) / 255
	g = tonumber (strsub (colors, 3, 4), 16) / 255
	b = tonumber (strsub (colors, 5, 6), 16) / 255
	return r, g, b
end

--- Convert hex color string to R G B A floats (0-1)
function VFL.explodeHexStringRGBA(colors)
	r = tonumber (strsub (colors, 1, 2), 16) / 255
	g = tonumber (strsub (colors, 3, 4), 16) / 255
	b = tonumber (strsub (colors, 5, 6), 16) / 255
	a = tonumber (strsub (colors, 7, 8), 16) / 255
	return r, g, b, a
end

-- Convert hex color number to R G B A floats (0-1) (RRGGBBAA number)
function VFL.explodeHexNumberRGBA(colors)
	r = rshift (colors, 24) / 255
	g = band (rshift (colors, 16), 0xff) / 255
	b = band (rshift (colors, 8), 0xff) / 255
	a = band (colors, 0xff) / 255
	return r, g, b, a
end

--------
-- Convert hex color number to alpha float (0-1)
-- (RRGGBBAA number)
function VFL.Util_num2a (colors)

	return bit.band (colors, 0xff) / 255
end

-- COLOR OBJECT
-- Object oriented color manipulations.

VFL.Color = {};
VFL.Color.__index = VFL.Color;

--- Create a new color on the given object.
-- @param o A table Color {r, g, b, a};
function VFL.Color:new(o)
	x = o or {}; setmetatable(x, VFL.Color);
	return x;
end

--- Clone this color, creating an identical new color object.
function VFL.Color:clone()
	local x = {r=self.r, g=self.g, b=self.b, a=self.a};
	setmetatable(x, VFL.Color);
	return x;
end

--- Copy from the target color into this color
-- @param target A table Color {r, g, b, a};
function VFL.Color:set(target)
	self.r = target.r; self.g = target.g; self.b = target.b; self.a = target.a;
end

--- Set color directly
-- @param r Red
-- @param g Green
-- @param b Blue
-- @param a Alpha
function VFL.Color:RGBA(r,g,b,a)
	self.r = r; self.g = g; self.b = b; self.a = a;
end

-- BLEND OPERATORS

--- Blend this color via RGB linear interpolation between two colors.
function VFL.Color:blend(c1, c2, t)
	d = 1-t;
	self.r = d*c1.r + t*c2.r;
	self.g = d*c1.g + t*c2.g;
	self.b = d*c1.b + t*c2.b;
	a1,a2 = c1.a or 1, c2.a or 1;
	self.a = d*a1 + t*a2;
end

--- Modify the HLS of the passed color c2, storing the result in this color.
-- Any arguments not provided will be assumed to go unmodified in the transformation.
function VFL.Color:HLSTransform(c2, h, l, s)
	local x, y, z = RGBtoHLS(c2.r, c2.g, c2.b);
	h = h or x; l = l or y; s = s or z;
	x, y, z = HLStoRGB(h, l, s);
	self.r = x; self.g = y; self.b = z; self.a = c2.a or 1;
end

-- OUTPUT OPERATORS

--- Get the WOW text formatting string corresponding to this color
-- @return A string |c%02X%02X%02X%02X
function VFL.Color:GetFormatString()
	return strformat("|c%02X%02X%02X%02X", floor((self.a or 1)*255), floor(self.r*255), floor(self.g*255), floor(self.b*255));
end

--- Colorize the given string with this color
-- @param str The string to color
-- @return A string |c%02X%02X%02X%02Xstr|r"
function VFL.Color:colorize(str)
	return strformat("|c%02X%02X%02X%02X%s|r", floor((self.a or 1)*255), floor(self.r*255), floor(self.g*255), floor(self.b*255), str);
end

--- Get a vector from this color
function VFL.Color:RGBAVector()
	return self.r, self.g, self.b, self.a;
end

--- Get a vector from this color without alpha
function VFL.Color:RGBVector()
	return self.r, self.g, self.b;
end

-- TEMPORARY COLORS

tempcolor = VFL.Color:new();

--- A self-walking temp. color array for more complicated blending scenarios.
local tc_array = {};
for i=1,20 do tc_array[i] = VFL.Color:new({r=1,g=1,b=1,a=1}); end
local tc_i = 0;

--- Use temporary colors to perform blend operations without consuming memory.
-- Global temporary color, used to reduce memory allocations during blend ops
function VFL_TempColor()
	tc_i = tc_i + 1; if(tc_i > 20) then tc_i = 1; end
	return tc_array[tc_i];
end

-------------------------
-- SOME GLOBAL COLORS
-------------------------
_red = {r=0.9,g=0,b=0,a=1};
_yellow = {r=1,g=1,b=0,a=1};
_orange = {r=1,g=0.5,b=0,a=1};
_green = {r=0,g=1,b=0,a=1};
_blue = {r=0,g=0,b=1,a=1};
_white = {r=1,g=1,b=1,a=1};
_black = {r=0,g=0,b=0,a=1};
_alphaBlack = {r=0,g=0,b=0,a=.5};
_grey = {r=.3, g=.3, b=.3, a=1};
_cyan = {r=0, g=.6, b=.6, a=1};
_midgrey = {r=.5, g=.5, b=.5, a=1};
_alphafull = {r=0, g=0, b=0, a=0};
_purple = {r=.5, g=0, b=1, a=1};
_bluesky = {r=.5, g=.75, b=1, a = 1};
_greensky = {r=.5, g=1, b=0, a = 1};
