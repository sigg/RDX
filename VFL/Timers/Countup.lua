VFLT.CountUpTimer = {};

--- Create a new countup timer object
-- @description A simple counter up object
function VFLT.CountUpTimer:new()
	local s = {};

	local baseline, t0 = 0, nil;
	function s:Start() t0 = GetTime(); end
	function s:Get()
		if t0 then return baseline + (GetTime() - t0); else return baseline; end
	end
	function s:Stop()
		baseline = self:Get(); t0 = nil;
	end
	function s:Reset() baseline = 0; t0 = nil; end
	function s:IsRunning() return t0; end

	return s;
end