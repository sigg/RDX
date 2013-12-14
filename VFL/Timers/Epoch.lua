--- Epoch.lua
-- @author (C)2006 Bill Johnson and The VFL Project

VFLT.Epoch = {};
VFLT.Epoch.__index = VFLT.Epoch;

--- An epoch is a specified "zero point" in time, and tools to
-- transform time based around that zero point.
-- @return a new Epoch object
function VFLT.Epoch:new()
	local self = {};
	setmetatable(self, VFLT.Epoch);
	return self;
end

--- Establish an epoch using an exact minute (hh:mm:00.00)
function VFLT.Epoch:Synchronize(kernelTime, localTime, serverHr, serverMin)
	-- First priority is to compute the discrepancy between our estimate of the
	-- server time, and the actual server time.
	
	-- Get our estimate of the server's time
	local estServerDate = date("*t", localTime + VFLT.GetServerTimeOffset());

	-- Assuming our estimate isn't too far off, the EXACT server time can be
	-- obtained by setting the hour, minute, second fields appropriately
	estServerDate.hour = serverHr;
	estServerDate.min = serverMin;
	estServerDate.sec = 0;
	self.serverTime = time(estServerDate);

	self.localTime = localTime;
	self.kernelTime = kernelTime;
end

--- Get the discrepancy between server and local time as it was when
-- this epoch was synchronized.
function VFLT.Epoch:GetLocalTimeCorrection()
	return self.serverTime - self.localTime - VFLT.GetServerTimeOffset();
end

--- Get the discrepancy between kernel and server time, such that
-- kernelTime + GetKernelTimeCorrection() = serverTime
function VFLT.Epoch:GetKernelTimeCorrection()
	return self.serverTime - self.kernelTime;
end

--- Get the server time according to this epoch.
function VFLT.Epoch:GetServerTime()
	return (GetTime() - self.kernelTime) + self.serverTime;
end

--- Convert a time to epochal server time.
function VFLT.Epoch:KernelToServerTime(ktime)
	return (ktime - self.kernelTime) + self.serverTime;
end

-- Print debug information about an epoch.
function VFLT.Epoch:Dump()
	VFL:Debug(1, "Epoch: kernelTime(" .. self.kernelTime .. ") = localTime(" .. self.localTime ..") = serverTime(" .. self.serverTime ..") = epochTime(0)");
	local kNow, sh, sm = GetTime(), GetGameTime();
	local eSvrTm = self.serverTime + (kNow - self.kernelTime);
	local eSvrDate = date(nil, eSvrTm);
	VFL:Debug(1, "* Epochal serverTime [" .. eSvrDate .. "] -- source " .. eSvrTm);
	VFL:Debug(1, "* Actual serverTime: " .. sh .. ":" .. sm);
	VFL:Debug(1, "* Exact discrepancy: " .. (self.serverTime - self.localTime - VFLT.GetServerTimeOffset()));
end

----------------------------------------------------------------
-- UNIVERSAL TIME
----------------------------------------------------------------
-- System epoch management
local lastmin, sysEpoch, tz, kernelToServer = nil, nil, 0, 0;

--- Get the hourly offset from local time to server time.
-- @return the number of seconds X satisfying ServerTime = LocalTime + X
function VFLT.GetServerTimeOffset() 
	return tz * 3600;
end

local function TimeFixUpdate()
	-- Check the game time
	local h,m = GetGameTime();
	-- If the minute ticked, we have a time fix!
	if(m ~= lastmin) then
		local kernelTime, localTime = GetTime(), time();
		sysEpoch = VFLT.Epoch:new();
		sysEpoch:Synchronize(kernelTime, localTime, h, m);
		VFL.print("System epoch established!");
		sysEpoch:Dump();
		kernelToServer = sysEpoch:GetKernelTimeCorrection();
		VFLEvents:Dispatch("SYSTEM_EPOCH_ESTABLISHED", sysEpoch);
	else
		-- Keep spamming time checks (we need 0.1 sec precision)
		VFLT.ZMSchedule(0.1, TimeFixUpdate);
	end
end
local function SetupSysEpoch()
	VFL:Debug(1, "* Establishing system epoch.");
	_, lastmin = GetGameTime();
	TimeFixUpdate();
end

--- Get the VFL system epoch.
function VFLT.GetSystemEpoch()
	return sysEpoch;
end

--- Initialize the VFL kernel's timing subsystem.
function VFLT.InitTime()
	VFL:Debug(1, "VFLT.InitTime(): Initializing timing subsystem.");

	-- Mark the current time.
	local now, sh, sm = time(), GetGameTime();
	local today = date("*t");

	-- Mmmkay, we need to figure out the offset in hours between local time and server time.
	-- Let's pick the number that is LESS THAN 12 HOURS that gives us the best fit.
	-- Compute the difference between the server hour and the current hour mod 24 hours.
	-- Use minutes for higher precision.
	tz = VFL.mod( (sh*60 + sm) - ((today.hour*60) + today.min), 24*60);
	-- If the value is more than 12 hours, go the other way round the clock instead.
	if(tz > 720) then
		tz = -VFL.mod( ((today.hour * 60) + today.min) - (sh*60 + sm) , 24*60);
	end
	-- Convert back to hours.
	tz = VFL.round(tz/60);
	-- Print info
	VFL.print("Local time is |cFF00FF00" .. today.hour .. ":" .. today.min .. "|r, server time is |cFF00FF00" .. sh .. ":" .. sm .. "|r");
	VFL.print("Autodetected time difference: Server = Local + |cFF00FF00" .. tz .. " hours|r");
	-- Allow the timezone to be directly overridden.
	if not VFLConfig then VFLConfig = {}; end
	if VFLConfig.overrideTZ then
		tz = VFLConfig.overrideTZ;
		VFL.print("Override timezone: |cFF00FF00" .. tz .. " hours|r");
	end

	-- Figure out the projected server time based on the server time offset.
	local projServerTime = now + VFLT.GetServerTimeOffset();
	local projServerDate = date("*t", projServerTime);
	projServerDate.hour = sh; projServerDate.min = sm;
	local serverTime = time(projServerDate);
	
	-- Verify that the estimated server time is somewhat accurate.
	-- If not, demand the user set the offset.
	local diff = math.abs(projServerTime - serverTime);
	VFL:Debug(1, "* Time discrepancy of " .. diff .. "s detected.");
	if(diff > 3600) then
		VFL.print("|cFFFFFFFF[VFL]|r Clock discrepancy of |cFFFF0000" .. diff .. " seconds|r detected. Your time zone may be set incorrectly. Use /timezone to set your timezone manually.");
	end

	-- Get a time fix
	SetupSysEpoch();
end

--- Get the UTC server time.
function VFLT.GetServerTime()
	return GetTime() + kernelToServer;
end

-- Manual timezone setup
SLASH_TIMEZONE1 = "/timezone";
SlashCmdList["TIMEZONE"] = function(arg)
	if(arg == "clear") then VFLConfig.overrideTZ = nil; return; end
	local n = tonumber(arg)
	if not n then
		local sh, sm = GetGameTime();
		local today = date("*t");
		VFL.print("|cFFFFFFFF[VFL]|r Local time is |cFF00FF00" .. today.hour .. ":" .. today.min .. "|r, server time is |cFF00FF00" .. sh .. ":" .. sm .. "|r");
		VFL.print("|cFFFFFFFF[VFL]|r Current timezone value: Server = Local + |cFF00FF00" .. tz .. " hours|r");
		VFL.print("|cFFFFFFFF[VFL]|r Type |cFF00FF00/timezone NNN|r to forcibly change the timezone, where NNN is the number of hours difference between the server and you.");
	else
		tz = VFL.clamp(n,-24,24);
		VFLConfig.overrideTZ = tz;
		SetupSysEpoch();
	end
end