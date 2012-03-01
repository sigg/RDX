
--
-- TAB nampelates
--
local framen = VFLUI.AcquireFrame("Frame");
framen:SetHeight(400); framen:SetWidth(216);

local function SetFramen(froot)

end

local function UnsetFramen()

end

framen:Hide();

RDXDK.RegisterTool("Nameplates", 75, framen, SetFramen, UnsetFramen);