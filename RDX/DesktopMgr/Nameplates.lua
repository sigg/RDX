-- OpenRDX
-- Nameplates.lua
-- inspired from caelNameplates

-- list of nameplates registered
local listNp = {};

-- default nameplate design option
local descn = {};

--local UpdateTime = function(self, curValue)
--	local minValue, maxValue = self:GetMinMaxValues()
--	if self.channeling then
--		self.time:SetFormattedText("%.1f ", curValue)
--	else
--		self.time:SetFormattedText("%.1f ", maxValue - curValue)
--	end
--end

--
-- Nameplate hook script
--

local r, g, b;
local OnUpdate = function(self, elapsed)
	self.elapsed = self.elapsed + elapsed;
	if self.elapsed >= 0.2 then
		if not self.glowRegion:IsShown() then
			VFLUI.ApplyColorBackdropBorderRDX(self.healthBar, _black);
		else
			r, g, b = self.glowRegion:GetVertexColor();
			if g + b == 0 then
				VFLUI.ApplyColorBackdropBorderRDX(self.healthBar, _red);
			else
				VFLUI.ApplyColorBackdropBorderRDX(self.healthBar, _yellow);
			end
		end
		self.elapsed = 0
	end
end

local OnShow = function(self)
	self.healthBar:ClearAllPoints();
	self.healthBar:SetPoint("TOP", self.nameTextRegion, "BOTTOM");
	self.healthBar:SetHeight(10);
	self.healthBar:SetWidth(100);

	self.castBar:ClearAllPoints()
	self.castBar:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -5)
	self.castBar:SetHeight(10);
	self.castBar:SetWidth(100);

	self.highlightRegion:ClearAllPoints();
	self.highlightRegion:SetAllPoints(self.healthBar);

	--local oldName = self.oldname:GetText()
	--local newName = (string.len(oldName) > 20) and string.gsub(oldName, "%s?(.[\128-\191]*)%S+%s", "%1. ") or oldName -- "%s?(.)%S+%s"
	--self.name:SetText(newName)
	
	self.levelTextRegion:ClearAllPoints()
	self.levelTextRegion:SetPoint("RIGHT", self.healthBar, "LEFT");
	
	local level, elite = tonumber(self.levelTextRegion:GetText()), self.stateIconRegion:IsShown();
	if self.bossIconRegion:IsShown() then
		self.levelTextRegion:SetText("??");
		self.levelTextRegion:SetTextColor(0.8, 0.05, 0);
	else
		self.levelTextRegion:SetText(level..(elite and "+" or ""));
	end
	
	VFLUI.ResizeBackdropBorderRDX(self.healthBar, 1);
	VFLUI.ResizeBackdropBorderRDX(self.castBar, 1);
end

--
-- Castbar hook script
--

local FixCastbar = function(self)
	self:ClearAllPoints();
	self:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -3);
	self:SetHeight(10);
	self.spellIconRegion:ClearAllPoints()
	self.spellIconRegion:SetPoint("RIGHT", self, "LEFT");
	self.spellIconRegion:SetSize(15, 15)
end

local OnSizeChangedCB = function(self, width, height)
	if floor(height) ~= 10 then
		self.needFix = true
	end
end

local OnShowCB = function(self)
	if self.needFix then FixCastbar(self); self.needFix = nil; end
	if self.shieldedRegion:IsShown() then
		self:SetStatusBarColor(0.8, 0.05, 0);
	end
end

local OnValueChangedCB = function(self, curValue)
	--UpdateTime(self, curValue)
	if self.needFix then FixCastbar(self); self.needFix = nil; end
end

--
-- Style the nameplate
--

local CreateNameplate = function(frame)

	if frame._rdxnp then return; end
	frame._rdxnp = true;

	local healthBar, castBar = frame:GetChildren();
	frame.healthBar = healthBar;
	frame.castBar = castBar;
	castBar.healthBar = healthBar; -- fix castbar
	
	local glowRegion, overlayRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion = frame:GetRegions();
	glowRegion:SetTexture(nil);
	overlayRegion:SetTexture(nil);
	bossIconRegion:SetTexture(nil);
	stateIconRegion:SetTexture(nil);
	frame.glowRegion = glowRegion;
	frame.overlayRegion = overlayRegion;
	frame.highlightRegion = highlightRegion;
	frame.nameTextRegion = nameTextRegion;
	frame.levelTextRegion = levelTextRegion;
	frame.bossIconRegion = bossIconRegion;
	frame.raidIconRegion = raidIconRegion;
	frame.stateIconRegion = stateIconRegion;
	
	local _, castbarOverlay, shieldedRegion, spellIconRegion = castBar:GetRegions();
	castbarOverlay:SetTexture(nil);
	shieldedRegion:SetTexture(nil);
	castBar.castbarOverlay = castbarOverlay;
	castBar.shieldedRegion = shieldedRegion;
	castBar.spellIconRegion = spellIconRegion;
	
	VFLUI.SetBackdropBorderRDX(frame.healthBar, _black, "ARTWORK", 5, 1, _alphaBlack);
	VFLUI.SetBackdropBorderRDX(frame.castBar, _black, "ARTWORK", 5, 1, _alphaBlack);

	--frame.oldname = nameTextRegion
	--nameTextRegion:Hide()

	--local newNameRegion = frame:CreateFontString()
	--newNameRegion:SetPoint("BOTTOMLEFT", healthBar, "TOPLEFT", 0, pixelScale(-2))
	--newNameRegion:SetFont(font, fontSize, fontOutline)
	--newNameRegion:SetTextColor(0.84, 0.75, 0.65)
	--newNameRegion:SetShadowOffset(1.25, -1.25)
	--frame.name = newNameRegion
	
	if descn.font then
		VFLUI.SetFont(nameTextRegion, descn.font, nil, true);
		VFLUI.SetFont(levelTextRegion, descn.font, nil, true);
	end
	
	if descn.tex then
		healthBar:SetStatusBarTexture(descn.tex.path);
		castBar:SetStatusBarTexture(descn.tex.path);
		highlightRegion:SetTexture(descn.tex.path);
		highlightRegion:SetVertexColor(0.25, 0.25, 0.25);
	end

	castBar:HookScript("OnShow", OnShowCB)
	castBar:HookScript("OnSizeChanged", OnSizeChangedCB)
	castBar:HookScript("OnValueChanged", OnValueChangedCB)

	--castBar.time = castBar:CreateFontString(nil, "ARTWORK")
	--castBar.time:SetPoint("RIGHT", castBar, "LEFT", pixelScale(-2), 0)
	--castBar.time:SetFont(font, fontSize, fontOutline)
	--castBar.time:SetTextColor(0.84, 0.75, 0.65)
	--castBar.time:SetShadowOffset(1.25, -1.25)

	raidIconRegion:ClearAllPoints();
	raidIconRegion:SetPoint("RIGHT", healthBar, "LEFT");
	raidIconRegion:SetSize(15, 15);
	--raidIconRegion:SetTexture(raidIcons);	


	OnShow(frame);
	frame:SetScript("OnShow", OnShow);
	frame.elapsed = 0;
	frame:SetScript("OnUpdate", OnUpdate)
end


-- on desktop update
-- update Tooltip
function RDXDK.SetNameplate(desc)
	descn = desc;
	for i, v in ipairs(listNp) do
		if descn.font then
			VFLUI.SetFont(v.nameTextRegion, descn.font, nil, true);
			VFLUI.SetFont(v.levelTextRegion, descn.font, nil, true);
		end
		if descn.tex then
			v.healthBar:SetStatusBarTexture(descn.tex.path);
			v.castBar:SetStatusBarTexture(descn.tex.path);
			v.highlightRegion:SetTexture(descn.tex.path);
			v.highlightRegion:SetVertexColor(0.25, 0.25, 0.25);
		end
	end
end

---
-- SEARCH SYSTEM
---

local numChildren, children;

local function search()
	numChildren = WorldFrame:GetNumChildren()
	if numChildren ~= #listNp then
		for i = #listNp + 1, numChildren do
			local frame = select(i, WorldFrame:GetChildren());
			if not frame._rdxnp and frame:GetName() and frame:GetName():find("NamePlate%d") then
				CreateNameplate(frame);
				table.insert(listNp, frame);
			end
		end
	end
	
end
VFLP.RegisterFunc("RDX", "Nameplates", search, true);

WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, function() 
	VFLT.AdaptiveUnschedule2("nameplatesearch");
	VFLT.AdaptiveSchedule2("nameplatesearch", 0.2, search);
end);

SetCVar("bloattest", 0) -- 1 might make nameplates larger but it fixes the disappearing ones.
SetCVar("bloatnameplates", 0) -- 1 makes nameplates larger depending on threat percentage.
SetCVar("bloatthreat", 0) -- 1 makes nameplates resize depending on threat gain/loss. Only active when a mob has multiple units on its threat table.

SetCVar("ShowClassColorInNameplate", 1)
SetCVar("nameplateShowEnemyTotems", 1)

SetCVar("spreadnameplates", 0) -- 0 makes nameplates overlap.