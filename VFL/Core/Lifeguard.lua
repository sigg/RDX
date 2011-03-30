--- Lifeguard.lua
-- @author (C)2006 Bill Johnson and The VFL Project


local _EnumerateFrames = EnumerateFrames;

--- Rewrite Blizzard's EnumerateFrames() so it doesn't touch VFL frames.
function EnumerateFrames(x)
	x = _EnumerateFrames(x);
	while x and x._VFL do x = _EnumerateFrames(x); end
	return x;
end

--[[
function VFLShowFrame()
local frame = EnumerateFrames()
while frame do
    if frame:IsVisible() and MouseIsOver(frame) then
        DEFAULT_CHAT_FRAME:AddMessage(frame:GetName())
    end
    frame = EnumerateFrames(frame)
end

end
]]


--- Reload the UI
function VFLReloadUI()
	ReloadUI();
end;

SLASH_RELOAD1 = "/reload";
SlashCmdList["RELOAD"] = VFLReloadUI;

SLASH_RELOADUI1 = "/reloadui";
SlashCmdList["RELOADUI"] = VFLReloadUI;


--- GC
function VFLGC()
	collectgarbage("collect");
end;

SLASH_GC1 = "/gc";
SlashCmdList["GC"] = VFLGC;
