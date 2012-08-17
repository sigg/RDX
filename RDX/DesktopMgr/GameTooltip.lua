-- GameTooltip.lua

-------------------------------------
-- Gametooltip
-- Some codes are coming from Tiptop
-------------------------------------
local descg = {};

local TooltipsList = {
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	GameTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3,
	ItemRefTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	WorldMapTooltip,
};

--hack
-- Blizzard is repainting the backdrop color in dark blue. only rdx can change the color of the backdrop now.
for i, v in ipairs (TooltipsList) do
	v._SetBackdropColor = v.SetBackdropColor;
	v.SetBackdropColor = VFL.Noop;
	v._SetBackdropBorderColor = v.SetBackdropBorderColor;
	v.SetBackdropBorderColor = VFL.Noop;
	v._SetBackdrop = v.SetBackdrop;
	v.SetBackdrop = VFL.Noop;
end

local function SetGameTooltipBackdrop()
	local bkdtmp = descg.bkd;
	for i, v in ipairs (TooltipsList) do
		v:_SetBackdrop(bkdtmp);
		if bkdtmp.br then
			v:_SetBackdropBorderColor(bkdtmp.br or 1, bkdtmp.bg or 1, bkdtmp.bb or 1, bkdtmp.ba or 1);
		else
			v:_SetBackdropBorderColor(1,1,1,1);
		end
		if bkdtmp.kr then
			v:_SetBackdropColor(bkdtmp.kr or 1, bkdtmp.kg or 1, bkdtmp.kb or 1, bkdtmp.ka or 1);
		else
			v:_SetBackdropColor(1,1,1,1);
		end
	end
end

local function SetGameTooltipFont()
	local font = descg.font;
	VFLUI.SetFont(GameTooltipHeaderText, font, font.size + 3, true);
	VFLUI.SetFont(GameTooltipText, font, nil, true);
	VFLUI.SetFont(GameTooltipTextSmall, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip1TextLeft1, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip1TextLeft2, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip1TextLeft3, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip2TextLeft1, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip2TextLeft2, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip2TextLeft3, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip3TextLeft1, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip3TextLeft2, font, nil, true);
	VFLUI.SetFont(ShoppingTooltip3TextLeft3, font, nil, true);
	
	for i = 1, ShoppingTooltip1:NumLines() do
		VFLUI.SetFont(_G["ShoppingTooltip1TextRight"..i], font, nil, true);
	end
	for i = 1, ShoppingTooltip2:NumLines() do
		VFLUI.SetFont(_G["ShoppingTooltip2TextRight"..i], font, nil, true);
	end
	for i = 1, ShoppingTooltip3:NumLines() do
		VFLUI.SetFont(_G["ShoppingTooltip3TextRight"..i], font, nil, true);
	end
	
	if GameTooltipMoneyFrame1 then
		VFLUI.SetFont(GameTooltipMoneyFrame1PrefixText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1SuffixText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1CopperButtonText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1SilverButtonText, font, nil, true);
		VFLUI.SetFont(GameTooltipMoneyFrame1GoldButtonText, font, nil, true);
	end
end

local function SetGameTooltipSB()
	if descg.tex then
		GameTooltipStatusBar:SetStatusBarTexture(descg.tex.path);
	end
end

local btn = VFLUI.Button:new();
btn:SetHeight(50); btn:SetWidth(100);
btn:SetText(VFLI.i18n("GameTooltip"));
btn:SetClampedToScreen(true);
btn:SetFrameStrata("FULLSCREEN_DIALOG");
btn:Hide();

local function SetGameTooltipLocation()
	if descg.anchorx and descg.anchory then
		btn:ClearAllPoints();
		btn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descg.anchorx, descg.anchory);
	end
end

-- on desktop update
-- update Tooltip
function RDXDK.SetGameTooltip(desc)
	--VFL.copyInto(descg, desc);
	descg = desc;
	SetGameTooltipLocation();
	SetGameTooltipBackdrop();
	SetGameTooltipFont();
	SetGameTooltipSB();
end

-- on desktop unlock
-- Show the moving box
function RDXDK.SetUnlockGameTooltip()
	btn:ClearAllPoints();
	btn:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descg.anchorx, descg.anchory);
	btn:Show();
	btn:SetMovable(true);
	btn:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	btn:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing(); descg.anchorx,_,_,descg.anchory = VFLUI.GetUniversalBoundary(btn); end);
end

-- on desktop lock
-- Hide the moving box
-- return all data to desktop
function RDXDK.GetLockGameTooltip()
	btn:SetMovable(nil);
	btn:SetScript("OnMouseDown", nil);
	btn:SetScript("OnMouseUp", nil);
	btn:Hide();
	return descg;
end

------------------------------
-- RealId
------------------------------
local descr = {};
local anchorxrid, anchoryrid = 0, 0;
local btnrid = VFLUI.Button:new();
btnrid:SetHeight(50); btnrid:SetWidth(100);
btnrid:SetText(VFLI.i18n("Realid"));
btnrid:SetClampedToScreen(true);
btnrid:SetFrameStrata("FULLSCREEN_DIALOG");
btnrid:Hide();

-- on desktop update
-- update Realid
function RDXDK.SetRealid(desc)
	--VFL.copyInto(descr, desc);
	descr = desc;
	if descr.anchorxrid and descr.anchoryrid then
		btnrid:ClearAllPoints();
		btnrid:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descr.anchorxrid, descr.anchoryrid);
	end
end

-- on desktop unlock
-- Show the moving box
function RDXDK.SetUnlockRealid()
	btnrid:ClearAllPoints();
	btnrid:SetPoint("BOTTOMLEFT", RDXParent, "BOTTOMLEFT", descr.anchorxrid, descr.anchoryrid);
	btnrid:Show();
	btnrid:SetMovable(true);
	btnrid:SetScript("OnMouseDown", function(th) th:StartMoving(); end);
	btnrid:SetScript("OnMouseUp", function(th) th:StopMovingOrSizing(); descr.anchorxrid,_,_,descr.anchoryrid = VFLUI.GetUniversalBoundary(btnrid); end);
end

-- on desktop lock
-- Hide the moving box
-- return all data to desktop
function RDXDK.GetLockRealid()
	btnrid:SetMovable(nil);
	btnrid:SetScript("OnMouseDown", nil);
	btnrid:SetScript("OnMouseUp", nil);
	btnrid:Hide();
	return descr;
end

-- Hook secure
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
		if descg.tooltipmouse then
			GameTooltip:SetOwner(parent, "ANCHOR_CURSOR");
		else
			GameTooltip:SetOwner(parent, "ANCHOR_NONE");
			GameTooltip:SetPoint("CENTER", btn, "CENTER");
		end
	end);
	
	local unit, class, level, classif, item, quality, r, g, b, colortable, requestguid, _;
	local talents = {};
	-- for unknown reason, item on world map are blue.
	-- strongly recommend to use a texture backdrop instead of solid color
	local function fix()
		if descg.bkd and descg.bkd.kr then
			GameTooltip:_SetBackdropColor(descg.bkd.kr or 1, descg.bkd.kg or 1, descg.bkd.kb or 1, descg.bkd.ka or 1);
		else
			GameTooltip:_SetBackdropColor(1,1,1,1);
		end
	end
	
	-- Show the target
	local function setTargetText()
		if descg.showTarget then
			local target, tserver = UnitName("mouseovertarget");
			local _,tclass = UnitClass("mouseovertarget");
			if target and target ~= UNKNOWN and tclass then
				local targetLine;
				local left, right, leftText, rightText;
				for i=1, GameTooltip:NumLines() do
					left = _G[GameTooltip:GetName().."TextLeft"..i];
					leftText = left:GetText();
					right = _G[GameTooltip:GetName().."TextRight"..i];
					if leftText == "Target:" then
						if target == player and (tserver == nil or tserver == server) then
							right:SetText("<<YOU>>");
							right:SetTextColor(.9, 0, .1);
						else
							right:SetText(target);
							right:SetTextColor(RAID_CLASS_COLORS[tclass].r,RAID_CLASS_COLORS[tclass].g,RAID_CLASS_COLORS[tclass].b);
						end
						GameTooltip:Show();
						targetLine = true;
					end
				end
				if targetLine ~= true then
					if target == player and (tserver == nil or tserver == server) then
						GameTooltip:AddDoubleLine("Target:", "<<YOU>>", nil, nil, nil, .9, 0, .1);
					else
						local tcolor = RAID_CLASS_COLORS[tclass];
						if tcolor then
							GameTooltip:AddDoubleLine("Target:", target, nil,nil,nil,tcolor.r,tcolor.g,tcolor.b);
						end
					end
					GameTooltip:Show();
				else 
					targetLine = false;
				end
			end
		end
	end
	
	VFLT.AdaptiveSchedule2("GameTooltipUpdate", 0.5, setTargetText);
	
	--GameTooltip:HookScript("OnShow", fix);
	GameTooltip:HookScript("OnHide", function(self)
		self:_SetBackdropBorderColor(1,1,1,1);
	end);
	GameTooltip:HookScript("OnTooltipSetItem", function(self)
		--fix();
		_,item = self:GetItem();
		if item then
			_,_,quality = GetItemInfo(item);
			if quality then
				r, g, b = GetItemQualityColor(quality);
				if r then
					self:_SetBackdropBorderColor(r,g,b,1);
				end
			end
		end
	end);
	GameTooltip:HookScript("OnTooltipSetUnit", function(self)
		--fix();
		
		if descg.hideInCombat and InCombatLockdown() then
			return self:Hide();
		end
		
		_, unit = self:GetUnit();
		if unit then
			classif = UnitClassification(unit);
			_,class = UnitClass(unit);
			level = UnitLevel(unit);
			-- color BackdropBorder
			if UnitIsDead(unit) or not UnitIsConnected(unit) then
				self:_SetBackdropBorderColor(_grey.r, _grey.g, _grey.b, _grey.a);
			elseif not UnitPlayerControlled(unit) and UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
				self:_SetBackdropBorderColor(_grey.r, _grey.g, _grey.b, _grey.a);
			elseif UnitIsFriend("player", unit) then
				self:_SetBackdropBorderColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1);
			elseif descg.showDiffColor and level then
				if level == -1 then
					level = 85
				elseif classif == "elite" or classif == "rareelite" then
					level = level + 3
				elseif classif == "boss" or classif == "worldboss" then
					level = level + 5
				end
				colortable = GetQuestDifficultyColor(level);
				self:_SetBackdropBorderColor(colortable.r, colortable.g, colortable.b, 1);
			else
				self:_SetBackdropBorderColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1);
			end
			
			-- append text classif or AFK DND
			if UnitIsAFK(unit) then
				self:AppendText(" (AFK)")
			elseif UnitIsDND(unit) then
				self:AppendText(" (DND)")
			else
				if classif then
					self:AppendText(" (" .. classif .. ")");
				end
			end
			
			-- add Talent
			-- By TipTop
			--[[ disable no authorization yet
			if CanInspect(unit) and descg.showTalent then
				if UnitName(unit) ~= UnitName("player") and UnitLevel(unit) > 9 then
					local talentline = nil;
					for i=1, GameTooltip:NumLines() do
						local left, leftText;
						left = _G["GameTooltipTextLeft"..i];
						leftText = left:GetText();
						if leftText == "Talents:" then
							talentline = 1;
						end
					end
					if not talentline then
						if InspectFrame and InspectFrame:IsShown() then	--to not step on default UI's toes
							GameTooltip:AddDoubleLine("Talents:", "Inspect Frame is open", nil,nil,nil, 1,0,0);
						elseif Examiner and Examiner:IsShown() then		--same thing with Examiner
							GameTooltip:AddDoubleLine("Talents:", "Examiner frame is open", nil,nil,nil, 1,0,0);
						else
							requestguid = UnitGUID(unit);
							NotifyInspect(unit);
							GameTooltip:AddDoubleLine("Talents:", "...");
						end
						GameTooltip:Show();
					end
				end
			end]]
		end
	end);
	
	-- By TipTop
	--[[ disable no authorization yet
	local maxtree,pnts,tree,active,left,leftText,right;
	local function TalentText()
		if UnitExists("mouseover") then
			active = GetActiveTalentGroup(1);
			maxtree = GetPrimaryTalentTree(true);
			for i=1,3 do
				_,tree,_,_,pnts = GetTalentTabInfo(i, 1, nil, active);
				if not tree then break end
				talents[i] = pnts;
				if i == maxtree then
					maxtree = tree;
				end
			end
			for i=1, GameTooltip:NumLines() do
				left = _G[GameTooltip:GetName().."TextLeft"..i];
				leftText = left:GetText();
				if leftText == "Talents:" then	--finds the Talents line and updates with info
					right = _G[GameTooltip:GetName().."TextRight"..i];
					right:SetFormattedText("%s (%s)", maxtree or "", table.concat(talents,"/"));
				end
				GameTooltip:Show();
			end
		end
		maxtree,pnts,tree = nil	--reset these variables;
	end]]
	
	-- By TipTop
	--[[ disable no authorization yet
	WoWEvents:Bind("INSPECT_READY", nil, function(guid)
		if requestguid == guid then
			TalentText();
		end
	end);]]
	
	local min, max, txt;
	local kay = VFL.Kay;
	
	GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
		if not self.text then
			self.text = VFLUI.CreateFontString(self);
			--self.text:SetPoint("CENTER", GameTooltipStatusBar);
			self.text:SetAllPoints(GameTooltipStatusBar);
			VFLUI.SetFont(self.text, descg.font, nil, true);
			self.text:SetJustifyH("CENTER");
			self.text:Show();
		end
		if descg.showTextBar then
			if not value then self.text:SetText(""); return; end
			min, max = self:GetMinMaxValues();
			if (value < min) or (value > max) then self.text:SetText(""); return; end
			_, unit = GameTooltip:GetUnit();
			if unit then
				min, max = UnitHealth(unit), UnitHealthMax(unit);
				txt = kay(min).." / "..kay(max);
				self.text:SetText(txt);
			else
				self.text:SetText("");
			end
		else
			self.text:SetText("");
		end
	end)
	
	BNToastFrame_UpdateAnchor = VFL.noop;
	BNToastFrame:ClearAllPoints();
	BNToastFrame:SetPoint("CENTER", btnrid, "CENTER");
end);