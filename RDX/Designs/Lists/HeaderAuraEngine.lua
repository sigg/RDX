-- HeaderAuraEngine.lua
-- OpenRDX / Sigg / Rashgarroth FR
--

local modf, floor, abs, strlower = math.modf, math.floor, math.abs, string.lower;
local GetRDXUnit = RDXDAL._ReallyFastProject;

----------- Helper functions for headers.
local function siter_active_children(header, i)
	i = i + 1;
	local child = header:GetAttribute("child" .. i);
	if child and child:IsShown() then
		return i, child, child:GetAttribute("index");
	end
end

local function siter_all_children(header, i)
	i = i + 1;
	local child = header:GetAttribute("child" .. i);
	if child then
		return i, child, child:GetAttribute("index");
	end
end

----------------------- Common header API
local headerAuraAPI = {};
-- Return a stateless iterator over *active* children in this header.
function headerAuraAPI:ActiveChildren() return siter_active_children, self, 0; end

-- Return a stateless iterator over *all* children in this header.
function headerAuraAPI:AllChildren() return siter_all_children, self, 0; end

-- Get the i'th child of this smart header.
function headerAuraAPI:GetChild(i) return self:GetAttribute("child" .. i); end

-- Get the i'th child of this smart header only if it is active; just return nil
-- otherwise.
function headerAuraAPI:GetActiveChild(i)
	local ch = self:GetAttribute("child" .. i);
	if ch and ch:IsShown() then return ch; end
end

-- Set this header to a comma-separated list of names
function headerAuraAPI:SetFilterList(list)
	self:SetAttribute("filter", list);
end

-- options of the smart header
-- ICON template
local icontemplates = {
	{ text = "RDXAB40x40Template" },
	{ text = "RDXAB30x30Template" },
	{ text = "RDXAB20x20Template" },
};
function RDX.IconTemplatesFunc() return icontemplates; end

-- BAR template
local bartemplates = {
	{ text = "RDXAB30x90Template" },
	{ text = "RDXAB20x60Template" },
	{ text = "RDXAB90x30Template" },
	{ text = "RDXAB60x20Template" },
};
function RDX.BarTemplatesFunc() return bartemplates; end

local sortmethod = {
	{ text = "INDEX" },
	{ text = "NAME" },
	{ text = "TIME" },
};
function RDX.SortMethodFunc() return sortmethod; end

local separateown = {
	{ text = "BEFORE" },
	{ text = "AFTER" },
	{ text = "NONE" },
};
function RDX.SeparateOwnFunc() return separateown; end


-- Set this header orientation
function headerAuraAPI:SetOrientation(template, orientation, wrapAfter, maxWraps, xoffset, yoffset)
	local x, y, wx, wy = 0, 0, 0, 0;
	local _, _, dx, dy = string.find(template, "^RDXAB(.*)x(.*)Template$");
	if dx and dy then
		if orientation == "RIGHT" then
			x = dx;
		elseif orientation == "LEFT" then
			x = -dx;
		elseif orientation == "UP" then
			y = dy;
		elseif orientation == "DOWN" then
			y = -dy;
		end
	end
	if not wrapAfter or wrapAfter == 0 then wrapAfter = 10; end
	if wrapAfter > 1 then
		if orientation == "RIGHT" then
			wx = 0; wy = -dy;
		elseif orientation == "LEFT" then
			wx = 0; wy = -dy;
		elseif orientation == "UP" then
			wx = dx; wy = 0;
		elseif orientation == "DOWN" then
			wx = dx; wy = 0;
		end
	end
	self:SetAttribute("xOffset", x + xoffset);
	self:SetAttribute("yOffset", y + yoffset);
	self:SetAttribute("wrapAfter", wrapAfter);
	self:SetAttribute("wrapXOffset", wx + xoffset);
	self:SetAttribute("wrapYOffset", wy + yoffset);
	self:SetAttribute("maxWraps", maxWraps);
end

local function CleanupHeader(x)
	x:Hide(); --x:SetScale(1); x:SetBackdrop(nil);
	-- Set default attributes
	--x:SetAttribute("showRaid", true); x:SetAttribute("showParty", true); x:SetAttribute("showSolo", true); x:SetAttribute("showPlayer", true);
	x:SetAttribute("filter", nil); --x:SetAttribute("groupFilter", nil); x:SetAttribute("strictFiltering", nil);
	
	x:SetAttribute("point", "TOPLEFT"); 
	x:SetAttribute("xOffset", 0); 
	x:SetAttribute("yOffset", 0);
	x:SetAttribute("wrapAfter", 10);
	x:SetAttribute("wrapXOffset", 0);
	x:SetAttribute("wrapYOffset", 0);
	x:SetAttribute("maxWraps", 1);
	--x:SetAttribute("sortMethod", nil); x:SetAttribute("sortDir", nil);
	--x:SetAttribute("template", "SecureFrameTemplate"); x:SetAttribute("templateType", "Frame");
	-- Frame specific cleanup
	VFLUI._CleanupLayoutFrame(x);
end

------------------------------------------------------------
-- A pooled wrapper for Blizzard's secure header template.
------------------------------------------------------------
VFLUI.CreateFramePool("SecureAuraHeader", function(pool, frame)
	CleanupHeader(frame);
end, function()
	local f = CreateFrame("Frame", "SAH" .. VFL.GetNextID(), nil, "SecureAuraHeaderTemplate");
	CleanupHeader(f);
	-- Mixin the API
	VFL.mixin(f, headerAuraAPI);
	return f;
end);

------------------------------------------------------------
-- SMART AURA HEADER
------------------------------------------------------------
RDX.SmartHeaderAura = {};
function RDX.SmartHeaderAura:new()
	local obj = VFLUI.AcquireFrame("SecureAuraHeader");
	obj.updateFunc = VFL.Noop;
	obj.listener = VFLUI.AcquireFrame("Frame");
	obj.listener:RegisterEvent("UNIT_AURA");
	obj.listener:SetScript("OnEvent", function(self, event, arg1) if (arg1 == "player") then obj:updateFunc(); end; end);
	obj.Destroy = VFL.hook(function(s)
		if InCombatLockdown() then
			error(VFLI.i18n("Attempt to destroy secure aura header while in combat."));
		end
		s.listener:Destroy(); s.listener = nil;
		s.updateFunc = nil;
		-- Clear data
		s:Hide();
		-- Invoke :Destroy on any children that have a destroy method
		-- in fact doesn't work but....
		for _,child in s:AllChildren() do
			if child.Destroy then 
				child:Destroy(); child.Destroy = nil; 
			end
		end
	end, obj.Destroy);
	return obj;
end

