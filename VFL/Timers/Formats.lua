
local mathdotfloor = math.floor;
local strformat = string.format;

----------------------------------------------------------------
-- PARSING, FORMATTING
----------------------------------------------------------------
local thr, tmin, tsec;

--- Convert elapsed seconds to elapsed {hour, min, sec}
function VFLT.GetHMS(sec)
	tmin = mathdotfloor(sec/60); sec = VFL.mmod(sec, 60);
	thr = mathdotfloor(tmin/60); tmin = VFL.mmod(tmin, 60);
	return { hour = thr; min = tmin; sec = sec; };
end

--- Convert {hour, min, sec} to seconds
function VFLT.HMSToSec(hms)
	return (hms.hour * 3600) + (hms.min * 60) + hms.sec;
end

--- Format seconds as mm:ss
function VFLT.FormatMinSec(sec)
	tmin = mathdotfloor(sec/60); sec = VFL.mmod(sec, 60);
	return strformat("%d:%02d", tmin, sec);
end

--- Format seconds as hh:mm:ss
function VFLT.FormatHMS(sec)
	tmin = mathdotfloor(sec/60); sec = VFL.mmod(sec, 60);
	thr = mathdotfloor(tmin/60); tmin = VFL.mmod(tmin, 60);
	return strformat("%02d:%02d:%02d", thr, tmin, sec);
end

--- Format seconds as 14h08m35s or 8m35s or 35s depending on magnitude
function VFLT.FormatSmartMinSec(sec)
	if sec < 0 then return "*"; end
	tmin = mathdotfloor(sec/60); sec = VFL.mmod(sec, 60);
	thr = mathdotfloor(tmin/60); tmin = VFL.mmod(tmin, 60);
	if thr > 0 then
		return strformat("%dh%02dm", thr, tmin);
	elseif tmin > 0 then
		return strformat("%dm%02ds", tmin, sec);
	else
		return strformat("%0.1fs", sec);
	end
end

--- Format seconds as 14h or 8m or 35s depending on magnitude
function VFLT.Emm(sec)
	if sec < 60 then
		return floor(sec) .. "s";
	elseif sec < 3600 then
		return VFL.round(sec/60) .. "m";
	else
		return VFL.round(sec/3600) .. "h";
	end
end

--- Format very small time periods as a string.
function VFLT.FormatMicro(time)
	if(time < .001) then
		return strformat("%d|cFF444444µs|r", mathdotfloor(time * 1000000));
	elseif(time < .1) then
		return strformat("%0.2f|cFFAAAAAAms|r", time * 1000);
	else
		return strformat("%0.2f|cFFFFFFFFs|r", time);
	end
end

--- Parse a string date
-- @param str format hh:mm:ss
-- @return thr Hours
-- @return tmin Minutes
-- @return tsec secondes
function VFLT.ParseHMS(str)
	thr,tmin,tsec = string.match(str, "(%d+):(%d+):(%d+)");
	thr = tonumber(thr); tmin = tonumber(tmin); tsec = tonumber(tsec);
	if (not thr) or (not tmin) or (not tsec) then return nil; else return thr,tmin,tsec; end
end

local ASDate = {};
ASDate["HH:MM STR"] = function(str, color) return format("%s[%s]|r %s", VFL.strtcolor(color), date("%H:%M"), str); end
ASDate["STR HH:MM"] = function(str, color) return format("%s[%s]|r %s", VFL.strtcolor(color), str, date("%H:%M")); end
ASDate["HH:MM:SS STR"] = function(str, color) return format("%s[%s]|r %s", VFL.strtcolor(color), date("%H:%M:%S"), str); end
ASDate["STR HH:MM:SS"] = function(str, color) return format("%s[%s]|r %s", VFL.strtcolor(color), str, date("%H:%M:%S")); end

local ASDatelist = {
	{ text = "None" },
	{ text = "HH:MM STR" },
	{ text = "STR HH:MM" },
	{ text = "HH:MM:SS STR" },
	{ text = "STR HH:MM:SS" },
};
local function asdOnBuild() return ASDatelist; end
VFL.ASDateListSelectionFunc = asdOnBuild;

local fdate;

--- Add a date to a String
-- @param str The text string
-- @param ty Type of format date
-- @param color Color the date text
-- @return the new text with date
function VFL.AddStringDate(str, ty, color)
	fdate = ASDate[ty];
	if fdate then return fdate(str, color); else return str; end
end