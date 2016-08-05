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
			VFLUI.SetBackdropBorderColor(self.healthBar, 1, 1, 1, 1);
		else
			r, g, b = self.glowRegion:GetVertexColor();
			if g + b == 0 then
				VFLUI.SetBackdropBorderColor(self.healthBar, 1, 0, 0, 1);
			else
				VFLUI.SetBackdropBorderColor(self.healthBar, 0, 1, 1, 1);
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
	--self.castBar:SetHeight(10);
	--self.castBar:SetWidth(100);

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
	
	--VFLUI.ResizeBackdropBorderRDX(self.healthBar, 1);
	--VFLUI.ResizeBackdropBorderRDX(self.castBar, 1);
	--if self.healthBar._fbd then
	--	VFLUI.ResizeBackdropRDX(self.healthBar, 2);
	--	VFLUI.ResizeBackdropRDX(self.castBar, 2)
	--end
	VFLUI.SetBackdrop(self.healthBar, descn.bkd);
	--if self.castBar and self.castBar:GetWidth() > 10 and self.castBar:GetHeight() > 10 then
		--VFLUI.SetBackdrop(self.castBar, descn.bkd);
	--end
end

--
-- Castbar hook script
--

local FixCastbar = function(self)
	self.count = self.count + 1;
	self:ClearAllPoints();
	self:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -3);
	if self:GetWidth() ~= 100 and self.count < 2 then
		self:SetHeight(10);
		self:SetWidth(100);
		VFLUI.SetBackdrop(self, descn.bkd);
	end
	self.spellIconRegion:ClearAllPoints()
	self.spellIconRegion:SetPoint("RIGHT", self, "LEFT");
	self.spellIconRegion:SetSize(15, 15);
	self.count = self.count - 1;
end


local OnSizeChangedCB = function(self, width, height)
	if floor(height) ~= 10 or floor(width) ~= 100 then
		self.needFix = true
	end
end

--local OnSizeChangedCB = VFLT.CreatePeriodicLatch(0.2, function(self, width, height)
--	if floor(height) ~= 10 or floor(width) ~= 100 then
--		self.needFix = true
--	end
--end);

local OnShowCB = function(self)
	if self.needFix then FixCastbar(self); self.needFix = nil; end
	if self.shieldedRegion:IsShown() then
		self:SetStatusBarColor(0.8, 0.05, 0);
	end
end

local OnValueChangedCB = function(self, curValue)
	if self.needFix then FixCastbar(self); self.needFix = nil; end
end

--
-- Style the nameplate
--

local CreateNameplate = function(frame)

	if frame._rdxnp then return; end
	frame._rdxnp = true;
	
	

	local barFrame, nameFrame = frame:GetChildren();
	--f.barFrame.threat, f.barFrame.border, f.barFrame.highlight, f.barFrame.level, f.barFrame.boss, f.barFrame.raid, f.barFrame.dragon = f.barFrame:GetRegions()
	--f.nameFrame.name = f.nameFrame:GetRegions()
	--f.barFrame.healthbar, f.barFrame.castbar = f.barFrame:GetChildren()
	--f.barFrame.healthbar.texture =  f.barFrame.healthbar:GetRegions()
	--f.barFrame.castbar.texture, f.barFrame.castbar.border, f.barFrame.castbar.shield, f.barFrame.castbar.icon =  f.barFrame.castbar:GetRegions()
	
	local healthBar, castBar = barFrame:GetChildren();
	frame.healthBar = healthBar;
	frame.castBar = castBar;
	castBar.healthBar = healthBar; -- fix castbar
	
	local glowRegion, overlayRegion, highlightRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion = barFrame:GetRegions();
	glowRegion:SetTexture(nil);
	overlayRegion:SetTexture(nil);
	bossIconRegion:SetTexture(nil);
	stateIconRegion:SetTexture(nil);
	frame.glowRegion = glowRegion;
	frame.overlayRegion = overlayRegion;
	frame.highlightRegion = highlightRegion;
	frame.levelTextRegion = levelTextRegion;
	frame.bossIconRegion = bossIconRegion;
	frame.raidIconRegion = raidIconRegion;
	frame.stateIconRegion = stateIconRegion;
	
	frame.nameTextRegion = nameFrame:GetRegions();
	
	local _, castbarOverlay, shieldedRegion, spellIconRegion = castBar:GetRegions();
	castbarOverlay:SetTexture(nil);
	--shieldedRegion:SetTexture(nil);
	castBar.castbarOverlay = castbarOverlay;
	--castBar.shieldedRegion = shieldedRegion;
	castBar.spellIconRegion = spellIconRegion;

	--frame.oldname = nameTextRegion
	--nameTextRegion:Hide()

	--local newNameRegion = frame:CreateFontString()
	--newNameRegion:SetPoint("BOTTOMLEFT", healthBar, "TOPLEFT", 0, pixelScale(-2))
	--newNameRegion:SetFont(font, fontSize, fontOutline)
	--newNameRegion:SetTextColor(0.84, 0.75, 0.65)
	--newNameRegion:SetShadowOffset(1.25, -1.25)
	--frame.name = newNameRegion
	
	if descn.font then
		VFLUI.SetFont(frame.nameTextRegion, descn.font, nil, true);
		VFLUI.SetFont(levelTextRegion, descn.font, nil, true);
	end
	
	if descn.tex then
		healthBar:SetStatusBarTexture(descn.tex.path);
		castBar:SetStatusBarTexture(descn.tex.path);
		highlightRegion:SetTexture(descn.tex.path);
		highlightRegion:SetVertexColor(0.25, 0.25, 0.25);
	end
	
	if descn.bkd then
		VFLUI.SetBackdrop(healthBar, descn.bkd);
		--VFLUI.SetBackdrop(castBar, descn.bkd);
	end

	castBar.count = 0;
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
		if descn.bkd then
			VFLUI.SetBackdrop(v.healthBar, descn.bkd);
			if v.castBar and v.castBar:GetWidth() > 10 and v.castBar:GetHeight() > 10 then
				VFLUI.SetBackdrop(v.castBar, descn.bkd);
			end
			--VFLUI.SetBackdrop(v.castBar, descn.bkd);
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

--[[
RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function()
	local opt =  RDXG.RDXopt;
	if not opt.dnp then
		WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, function() 
			VFLT.AdaptiveUnschedule2("nameplatesearch");
			VFLT.AdaptiveSchedule2("nameplatesearch", 0.2, search);
		end);
		
		SetCVar("bloattest", 0) -- 1 might make nameplates larger but it fixes the disappearing ones.
		SetCVar("bloatnameplates", 0) -- 1 makes nameplates larger depending on threat percentage.
		SetCVar("bloatthreat", 0) -- 1 makes nameplates resize depending on threat gain/loss. Only active when a mob has multiple units on its threat table.
		
		SetCVar("ShowClassColorInNameplate", 1)
		SetCVar("nameplateShowEnemyTotems", 1)
		
		--SetCVar("spreadnameplates", 0) -- 0 makes nameplates overlap.
	end

end);
]]