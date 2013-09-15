-- OpenRDX

local runeColors = {
	[1] = {1, 0, 0},
	[2] = {0, 0.5, 0},
	[3] = {0, 1, 1},
	[4] = {0.8, 0.1, 1},
};
--RUNE_MAPPING = {
--	[1] = "BLOOD",
--	[2] = "UNHOLY",
--	[3] = "FROST",
--	[4] = "DEATH",
--}

RDXUI.ClassBar = {};

function RDXUI.ClassBar:new(parent, root, desc)
	
	local f = VFLUI.AcquireFrame("Frame");
	f:SetParent(parent);
	f:SetFrameLevel(parent:GetFrameLevel());
	f:SetWidth(desc.w);
	f:SetHeight(desc.h);
	f:Show();
	f.list = {};
	
	local os = 0;
	if desc.driver == 2 then
		if desc.bs and desc.bs.insets then os = desc.bs.insets or 0; end
	elseif desc.driver == 3 then
		if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
	end
	
	f.id = "ClassBar_" .. math.random(10000000);
	local class = select(2, UnitClass(root:GetAttribute("unit") or "player"));
	local btn;
	
	local opri1, opri2, osec1, osec2, csx, csy, csxm, csym = "RIGHT", "LEFT", "TOP", "BOTTOM", -tonumber(desc.iconspx), 0, 0, -tonumber(desc.iconspy);
	if desc.orientation == "RIGHT" then
		opri1 = "LEFT"; opri2 = "RIGHT"; csx = tonumber(desc.iconspx); csy = 0;
	elseif desc.orientation == "DOWN" then
		opri1 = "TOP"; opri2 = "BOTTOM"; osec1 = "LEFT"; osec2 = "RIGHT"; csx = 0; csy = -tonumber(desc.iconspy); csxm = tonumber(desc.iconspx); csym = 0;
	elseif desc.orientation == "UP" then
		opri1 = "BOTTOM"; opri2 = "TOP"; osec1 = "LEFT"; osec2 = "RIGHT"; csx = 0; csy = tonumber(desc.iconspy); csxm = tonumber(desc.iconspx); csym = 0;
	end
	
	
	if class == "DEATHKNIGHT" then
	
		local ftc = FreeTimer.CreateFreeTimerClass(true, true, nil, VFLUI.GetTextTimerTypesString("Seconds"), false, false, FreeTimer.SB_Full, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide, FreeTimer.SB_Full, FreeTimer.Text_None, FreeTimer.TextInfo_None, FreeTimer.TexIcon_Hide, nil, nil);
	
		for i = 1, 6 do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /6); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Show(); -- hide by default
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.sb = VFLUI.StatusBarTexture:new(btn, nil, nil, "ARTWORK", 2);
			btn.sb:SetParent(btn);
			btn.sb:SetOrientation("HORIZONTAL");
			btn.sb:SetPoint("LEFT", btn, "LEFT", os, 0);
			btn.sb:SetWidth(desc.w /6 - (2*os)); btn.sb:SetHeight(desc.h - (2*os));
			VFLUI.SetTexture(btn.sb, desc.texture);
			btn.sb:Show();
			
			local runeType = GetRuneType(i);
			if (runeType) then
				btn.sb:SetVertexColor(unpack(runeColors[runeType]));
			end
			
			btn.txt = VFLUI.CreateFontString(btn);
			btn.txt:SetAllPoints(btn);
			VFLUI.SetFont(btn.txt, desc.font, nil, true);
			btn.txt:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri1);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			btn.ftc = ftc(btn, btn.sb, btn.txt, nil, nil, nil, nil);
			btn.ftc:SetFormula(true, "simple");
			
			f.list[i] = btn;
		end
		
		f.CheckAndShow = function(self)
			WoWEvents:Bind("RUNE_POWER_UPDATE", nil, function(runeIndex, isEnergize)
				if runeIndex and runeIndex >= 1 and runeIndex <= 6  then 
					local btn = self.list[runeIndex];
					local start, duration, runeReady = GetRuneCooldown(runeIndex);
					
					if not runeReady then
						if start then
							btn.ftc:SetTimer(start, duration);
						end
					--	runeButton.energize:Stop();
					--else
					--	cooldown:Hide();
					--	runeButton.shine:SetVertexColor(1, 1, 1);
					--	RuneButton_ShineFadeIn(runeButton.shine)
					end
					
					--if isEnergize  then
					--	runeButton.energize:Play();
					--end
				else 
					--assert(false, "Bad rune index")
				end
			end, self.id);
			WoWEvents:Bind("RUNE_TYPE_UPDATE", nil, function(runeIndex) 
				if ( runeIndex and runeIndex >= 1 and runeIndex <= 6 ) then
					local btn = self.list[runeIndex];
					local runeType = GetRuneType(runeIndex);
					if (runeType) then
						btn.sb:SetVertexColor(unpack(runeColors[runeType]));
					end
				end
			end, self.id);
			--self:Update();
		end
		
		-- call
		f:CheckAndShow();
		
		
	elseif class == "WARLOCK" then
		-- affliction
		for i = 1, 4 do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /4); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Hide(); -- hide by default
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", os, -os);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -os, os);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			VFLUI.SetTexture(btn.tex, desc.texture);
			btn.tex:SetVertexColor(0.5,0,1,1);
			btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri1);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		-- destruction
		for i = 1, 4 do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /4); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Show(); -- hide by default
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.sb = VFLUI.StatusBarTexture:new(btn, nil, nil, "ARTWORK", 2);
			btn.sb:SetParent(btn);
			btn.sb:SetOrientation("HORIZONTAL");
			btn.sb:SetPoint("LEFT", btn, "LEFT", os, 0);
			btn.sb:SetWidth(desc.w /4 - (2*os)); btn.sb:SetHeight(desc.h - (2*os));
			VFLUI.SetTexture(btn.sb, desc.texture);
			btn.sb:SetVertexColor(1,0,0,1);
			btn.sb:Show();
			btn.sb:SetValue(0);
			
			--btn.tex = VFLUI.CreateTexture(btn);
			--btn.tex:SetAllPoints(btn);
			--btn.tex:SetDrawLayer("ARTWORK", 3);
			--VFLUI.SetTexture(btn.tex, desc.texture);
			--btn.tex:SetVertexColor(1,0,0,1);
			--btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri1);
			else
				btn:SetPoint(opri1, f.list[i-1 + 4], opri2, csx, csy);
			end
			
			f.list[i + 4] = btn;
		end
		
		-- create the bar demonology
		btn = VFLUI.AcquireFrame("Frame");
		btn:SetWidth(desc.w); btn:SetHeight(desc.h);
		btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
		btn:SetPoint("LEFT", f, "LEFT");
		btn:Show();
		
		if desc.driver == 2 then
			VFLUI.SetButtonSkin(btn, desc.bs);
		elseif desc.driver == 3 then
			VFLUI.SetBackdrop(btn, desc.bkd);
		end
		
		btn.sb = VFLUI.StatusBarTexture:new(btn, nil, nil, "ARTWORK", 2);
		btn.sb:SetParent(btn);
		btn.sb:SetOrientation("HORIZONTAL");
		btn.sb:SetPoint("LEFT", btn, "LEFT", os, 0);
		btn.sb:SetWidth(desc.w - (2*os)); btn.sb:SetHeight(desc.h - (2*os));
		VFLUI.SetTexture(btn.sb, desc.texture);
		btn.sb:SetVertexColor(0.5,0,1,1);
		btn.sb:Show();
		btn.sb:SetValue(0);
		f.list[9] = btn;
		
		f.Update = function(self, id)
			if id == "SOUL_SHARDS" and self.spec == SPEC_WARLOCK_AFFLICTION then
				local numShards = UnitPower( root:GetAttribute("unit") or "player", SPELL_POWER_SOUL_SHARDS );
				local maxShards = UnitPowerMax( root:GetAttribute("unit") or "player", SPELL_POWER_SOUL_SHARDS );
				
				local numOrbs = UnitPower(root:GetAttribute("unit") or "player", SPELL_POWER_SHADOW_ORBS);
				for i = 1, maxShards do
					local shard = self.list[i];
					local shouldShow = i <= numShards;
					if shouldShow then
						self.list[i]:Show();
					else
						self.list[i]:Hide();
					end
				end
				
				if ( self.shardCount ~= maxShards ) then
					for i = 1, 4 do
						local btn = self.list[i];
						btn:SetWidth(desc.w / maxShards);
					end
					self.shardCount = maxShards;
				end
			elseif id == "BURNING_EMBERS" and self.spec == SPEC_WARLOCK_DESTRUCTION then
				local power = UnitPower( root:GetAttribute("unit") or "player", SPELL_POWER_BURNING_EMBERS, true );
				local maxPower = UnitPowerMax( root:GetAttribute("unit") or "player", SPELL_POWER_BURNING_EMBERS, true );
				local numEmbers = floor(maxPower / MAX_POWER_PER_EMBER);
				
				if ( self.emberCount ~= numEmbers ) then
					for i = 1, 4 do
						local btn = self.list[i + 4];
						btn:SetWidth(desc.w / numEmbers);
						btn.sb:SetWidth(desc.w / numEmbers);
						if i<= numEmbers then
							btn:Show();
						else
							btn:Hide();
						end
					end
					self.emberCount = numEmbers;
				end
				
				--local numOrbs = UnitPower(root:GetAttribute("unit") or "player", SPELL_POWER_SHADOW_ORBS);
				for i = 1, numEmbers do
					local ember = self.list[i + 4];
					if power <= 0 then
						ember.sb:SetValue(0, 0.2);
					elseif power >= MAX_POWER_PER_EMBER then
						ember.sb:SetValue(1, 0.2);
					else
						ember.sb:SetValue(power/MAX_POWER_PER_EMBER, 0.2);
					end
					
					power = power - MAX_POWER_PER_EMBER;
					
				end
			--elseif id == "DEMONIC_FURY" and self.spec == SPEC_WARLOCK_DEMONOLOGY then
				--local power = UnitPower( root:GetAttribute("unit") or "player", SPELL_POWER_DEMONIC_FURY );
				--local maxPower = UnitPowerMax( root:GetAttribute("unit") or "player", SPELL_POWER_DEMONIC_FURY );
				--local demonic = self.list[9];
				--demonic.sb:SetValue(power/maxPower, 0.2);
			end
		end
		
		f.CheckAndShow = function(self)
			local spec = GetSpecialization();
			if ( spec == SPEC_WARLOCK_AFFLICTION ) then
				if ( self.spec ~= spec ) then
					self.spec = spec;
					VFLT.AdaptiveUnschedule(self.id)
					WoWEvents:Unbind(self.id);
					--for i = 1, 4 do
						--self.list[i]:Show();
					--end
					for i = 5, 8 do
						self.list[i]:Hide();
					end
					self.list[9]:Hide();
					WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function() self:Update("SOUL_SHARDS"); end, self.id);
					WoWEvents:Bind("UNIT_POWER_FREQUENT", nil, function(arg1, arg2)
						if (arg1 == root:GetAttribute("unit") or "player") then
							self:Update(arg2);
						end 
					end, self.id);
					self:Update("SOUL_SHARDS");
				end
				
			elseif ( spec == SPEC_WARLOCK_DESTRUCTION ) then
				if ( self.spec ~= spec ) then
					self.spec = spec;
					VFLT.AdaptiveUnschedule(self.id)
					WoWEvents:Unbind(self.id);
					-- hide destruction
					for i = 1, 4 do
						self.list[i]:Hide();
					end
					for i = 5, 8 do
						self.list[i]:Show();
					end
					self.list[9]:Hide();
					WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function() self:Update("BURNING_EMBERS"); end, self.id);
					WoWEvents:Bind("UNIT_POWER_FREQUENT", nil, function(arg1, arg2)
						if (arg1 == root:GetAttribute("unit") or "player") then
							self:Update(arg2);
						end 
					end, self.id);
					self:Update("BURNING_EMBERS");
				end
			elseif ( spec == SPEC_WARLOCK_DEMONOLOGY ) then
				if ( self.spec ~= spec ) then
					self.spec = spec;
					WoWEvents:Unbind(self.id);
					for i = 1, 4 do
						self.list[i]:Hide();
					end
					for i = 5, 8 do
						self.list[i]:Hide();
					end
					self.list[9]:Show();
					local power, maxPower;
					local demonic = self.list[9];
					VFLT.AdaptiveSchedule2(self.id, 0.2, function()
						power = UnitPower( "player", SPELL_POWER_DEMONIC_FURY );
						maxPower = UnitPowerMax( "player", SPELL_POWER_DEMONIC_FURY );
						demonic.sb:SetValue(power/maxPower, 0.2);
					end)
				end
			else
				-- nospec
				VFLT.AdaptiveUnschedule2(self.id)
				WoWEvents:Unbind(self.id);
			end
		end
		
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function() 
			f:CheckAndShow();
		end, f.id .. "h");
		
		-- call
		f:CheckAndShow();
	
	--and spec == SPEC_WARLOCK_AFFLICTION then --and IsPlayerSpell(WARLOCK_SOULBURN) then
	--elseif class == "WARLOCK" and spec == SPEC_WARLOCK_DESTRUCTION then --and IsPlayerSpell(WARLOCK_BURNING_EMBERS) then
	--elseif class == "WARLOCK" and spec == SPEC_WARLOCK_DEMONOLOGY then
		
	elseif class == "DRUID" then
		
		for i = 1, 2 do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /2); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Show();
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.sb = VFLUI.StatusBarTexture:new(btn, nil, nil, "ARTWORK", 2);
			btn.sb:SetParent(btn);
			btn.sb:SetOrientation("HORIZONTAL");
			VFLUI.SetTexture(btn.sb, desc.texture);
			if i == 1 then 
				btn.sb:SetPoint("RIGHT", btn, "RIGHT", -os, 0);
				btn.sb:SetVertexColor(0,0,1,1);
			else
				btn.sb:SetPoint("LEFT", btn, "LEFT", os, 0);
				btn.sb:SetVertexColor(1,1,0,1);
			end
			btn.sb:SetWidth(desc.w /2 - (2*os)); btn.sb:SetHeight(desc.h - (2*os));
			btn.sb:Show();
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetWidth(desc.h); btn.tex:SetHeight(desc.h);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			if i == 1 then
				btn.tex:SetTexture("Interface\\Addons\\VFL\\Skin\\sb_left");
				btn.tex:SetPoint("LEFT", btn, "LEFT");
				btn.tex:SetVertexColor(0,0,1,1);
			else
				btn.tex:SetTexture("Interface\\Addons\\VFL\\Skin\\sb_right");
				btn.tex:SetPoint("RIGHT", btn, "RIGHT");
				btn.tex:SetVertexColor(1,1,0,1);
			end
			btn.tex:Hide(); -- Hide by default
			
			btn.txt = VFLUI.CreateFontString(btn);
			btn.txt:SetAllPoints(btn);
			VFLUI.SetFont(btn.txt, desc.font, nil, true);
			btn.txt:Hide();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri1);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		
		f.Update = function(self)
			local power = UnitPower(root:GetAttribute("unit") or "player", SPELL_POWER_ECLIPSE);
			local maxPower = UnitPowerMax(root:GetAttribute("unit") or "player", SPELL_POWER_ECLIPSE);
			if maxPower == 0 then maxPower = 1; end
			local frac=power/maxPower;
			
			if frac > 1 then frac = 1; end
			if frac < -1 then frac = -1; end
			
			local moon = self.list[1];
			local sun = self.list[2];
			if frac > 0 then
				sun.sb:SetValue(frac, 0.2);
				moon.sb:Hide();
				sun.sb:Show();
				sun.txt:SetText(abs(power));
				moon.txt:Hide();
				sun.txt:Show();
			elseif frac < 0 then
				moon.sb:SetValue(abs(frac), 0.2);
				moon.sb:Show();
				sun.sb:Hide();
				moon.txt:SetText(abs(power));
				moon.txt:Show();
				sun.txt:Hide();
			else
				local direction = GetEclipseDirection();
				if direction == "moon" then
					moon.sb:SetValue(0);
					sun.sb:SetValue(0);
					moon.sb:Show();
					sun.sb:Hide();
					moon.txt:SetText(0);
					moon.txt:Show();
					sun.txt:Hide();
				elseif direction == "sun" then
					moon.sb:SetValue(0);
					sun.sb:SetValue(0);
					moon.sb:Hide();
					sun.sb:Show();
					sun.txt:SetText(0);
					moon.txt:Hide();
					sun.txt:Show();
				end
			end
			local direction = GetEclipseDirection();
			if direction == "moon" then
				moon.tex:Show();
				sun.tex:Hide();
			elseif direction == "sun" then
				moon.tex:Hide();
				sun.tex:Show();
			end
		end
		
		f.CheckAndShow = function(self)
			local spec = GetSpecialization();
			local form  = GetShapeshiftFormID();
			--if ( form == MOONKIN_FORM ) then
				if GetSpecialization() == 1 then
					WoWEvents:Unbind(self.id);
					WoWEvents:Bind("UNIT_POWER", nil, function() self:Update(); end, self.id);
					WoWEvents:Bind("ECLIPSE_DIRECTION_CHANGE", nil, function() self:Update(); end, self.id);
					self:Show();
				else
					WoWEvents:Unbind(self.id);
					self:Hide();
				end
			--else
			--	WoWEvents:Unbind(self.id);
			--	self:Hide();
			--end
			self:Update();
		end
		
		WoWEvents:Bind("UPDATE_SHAPESHIFT_FORM", nil, function()
			f:CheckAndShow();
		end, f.id .. "h");
		
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function()
			f:CheckAndShow();
		end, f.id .. "h");
		
		-- call
		f:CheckAndShow();
		
		
	elseif class == "PALADIN" then
		local maxHolyPower = UnitPowerMax(root:GetAttribute("unit"), SPELL_POWER_HOLY_POWER);
		f.maxHolyPower = maxHolyPower;
		for i = 1, 5 do
			btn = VFLUI.AcquireFrame("Frame");
			-- size will reset depend of additional rune
			btn:SetWidth(desc.w / maxHolyPower); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Hide(); -- hide by default
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", os, -os);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -os, os);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			VFLUI.SetTexture(btn.tex, desc.texture);
			btn.tex:SetVertexColor(1,1,0,1);
			btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri1);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		
		f.Update = function(self)
			local numHolyPower = UnitPower( root:GetAttribute("unit") or "player", SPELL_POWER_HOLY_POWER );
			local maxHolyPower = UnitPowerMax( root:GetAttribute("unit") or "player", SPELL_POWER_HOLY_POWER );
			for i = 1, maxHolyPower do
				local shouldShow = i <= numHolyPower;
				if shouldShow then
					self.list[i]:Show();
				else
					self.list[i]:Hide();
				end
			end
			-- in case number of rune change, resize width
			if self.maxHolyPower ~= maxHolyPower then
				for i = 1, 5 do
					local btn = self.list[i];
					btn:SetWidth(desc.w / maxHolyPower);
				end				
				self.maxHolyPower = maxHolyPower;
			end			
		end
		
		f.CheckAndShow = function(self)
			WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function() self:Update(); end, self.id);
			WoWEvents:Bind("UNIT_POWER", nil, function(arg1, arg2) 
				if (arg1 == root:GetAttribute("unit") or "player") and ( arg2 == "HOLY_POWER" ) then
					self:Update();
				end 
			end, self.id);
			self:Update();
		end
		
		-- call
		f:CheckAndShow();
		
	elseif class == "MONK" then
	
		for i = 1, 4 do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /4); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Hide(); -- hide by default
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", os, -os);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -os, os);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			VFLUI.SetTexture(btn.tex, desc.texture);
			btn.tex:SetVertexColor(0,1,1,1);
			btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri1);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		
		f.Update = function(self)
			local numOrbs = UnitPower(root:GetAttribute("unit") or "player", SPELL_POWER_CHI);
			for i = 1, 4 do
				local orb = self.list[i];
				local shouldShow = i <= numOrbs;
				if shouldShow then
					self.list[i]:Show();
				else
					self.list[i]:Hide();
				end
			end
		end
		
		f.CheckAndShow = function(self)
			WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function() self:Update(); end, self.id);
			WoWEvents:Bind("UNIT_POWER_FREQUENT", nil, function(arg1, arg2) 
				if (arg1 == root:GetAttribute("unit") or "player") and ( arg2 == "CHI" ) then
					self:Update();
				end 
			end, self.id);
			self:Update();
		end
		
		-- call
		f:CheckAndShow();
		
	elseif class == "PRIEST" then
		
		-- create
		for i = 1, PRIEST_BAR_NUM_ORBS do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /PRIEST_BAR_NUM_ORBS); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Hide(); -- hide by default
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end

			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", os, -os);
			btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -os, os);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			VFLUI.SetTexture(btn.tex, desc.texture);
			btn.tex:SetVertexColor(0.5,0,1,1);
			btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri1);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		
		f.Update = function(self)
			local numOrbs = UnitPower(root:GetAttribute("unit") or "player", SPELL_POWER_SHADOW_ORBS);
			for i = 1, PRIEST_BAR_NUM_ORBS do
				local orb = self.list[i];
				local shouldShow = i <= numOrbs;
				if shouldShow then
					self.list[i]:Show();
				else
					self.list[i]:Hide();
				end
			end
		end
		
		f.CheckAndShow = function(self)
			local spec = GetSpecialization();
			if ( spec == SPEC_PRIEST_SHADOW ) then
				WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function() self:Update(); end, self.id);
				WoWEvents:Bind("UNIT_POWER_FREQUENT", nil, function(arg1, arg2) 
					if (arg1 == root:GetAttribute("unit") or "player") and ( arg2 == "SHADOW_ORBS" ) then
						self:Update();
					end 
				end, self.id);
			else
				WoWEvents:Unbind(self.id);
			end
			self:Update();
		end
		
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function() 
			--PLAYER_FORM_UPDATE
			f:CheckAndShow();
		end, f.id .. "h");
		
		-- call
		f:CheckAndShow();
		
	else
		-- do nothing
	end
	
	f.Destroy = VFL.hook(function(s2)
		VFLT.AdaptiveUnschedule(s2.id)
		WoWEvents:Unbind(s2.id);
		VFLEvents:Unbind(s2.id);
		WoWEvents:Unbind(s2.id .. "h");
		VFLEvents:Unbind(s2.id .. "h");
		s2.id = nil;
		s2.Update = nil;
		s2.CheckAndShow = nil;
		s2.maxHolyPower = nil;
		for i,v in pairs(s2.list) do
			if v.tex then v.tex:Destroy(); v.tex = nil; end
			if v.txt then v.txt:Destroy(); v.txt = nil; end
			if v.sb then v.sb:Destroy(); v.sb = nil; end
			v:Destroy(); v = nil;
		end
	end, f.Destroy);
	return f;
end

local w = {
	{ text = "60" },
	{ text = "120" },
	{ text = "180" },
	{ text = "240" },
	{ text = "300" },
	{ text = "360" },
	{ text = "420" },
};
local function ddw() return w; end


RDX.RegisterFeature({
	name = "classbar";
	version = 1;
	title = VFLI.i18n("RDX ClassBar");
	test = true;
	category = VFLI.i18n("Complexes");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Classbar_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Classbar_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Classbar_" .. desc.name;
		
		local driver = desc.driver or 1;
		local bs = desc.bs or VFLUI.defaultButtonSkin;
		local bkd = desc.bkd or VFLUI.defaultBackdrop;
		
		local os = 0;
		if driver == 2 then
			if desc.bs and desc.bs.insets then os = desc.bs.insets or 0; end
		elseif driver == 3 then
			if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
		end
		
		local r, g, b, a = 1, 1, 1, 1;
		if driver == 2 then
			r, g, b, a = bs.br or 1, bs.bg or 1, bs.bb or 1, bs.ba or 1;
		elseif driver == 3 then
			r, g, b, a = bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1;
		end
		
		if not desc.drawLayer then desc.drawLayer = "ARTWORK"; end
		if not desc.sublevel then desc.sublevel = 3; end
		--if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
		
		----------------- Creation
		local createCode = [[
	local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
	btn = RDXUI.ClassBar:new(btnOwner, frame, ]] .. Serialize(desc) .. [[)
	btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	btn:Show();
	frame.]] .. objname .. [[ = btn;
]];
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);
		
		------------------- Destruction
		local destroyCode = [[
		local btn = frame.]] .. objname .. [[;
		if btn then
			btn:Destroy(); btn = nil;
		end
		frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		------------- Core
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Core Parameters")));

		local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
		ed_name:SetText(VFLI.i18n("Name"));
		ed_name.editBox:SetText(desc.name);
		ui:InsertFrame(ed_name);

		------------- Layout
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout parameters")));

		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation"));
		local dd_orientation = VFLUI.Dropdown:new(er, RDXUI.OrientationDropdownFunction);
		dd_orientation:SetWidth(75); dd_orientation:Show();
		if desc and desc.orientation then 
			dd_orientation:SetSelection(desc.orientation); 
		else
			dd_orientation:SetSelection("RIGHT");
		end
		er:EmbedChild(dd_orientation); er:Show();
		ui:InsertFrame(er);
		
		local ed_iconspx = VFLUI.LabeledEdit:new(ui, 50); ed_iconspx:Show();
		ed_iconspx:SetText(VFLI.i18n("Width spacing"));
		if desc and desc.iconspx then ed_iconspx.editBox:SetText(desc.iconspx); else ed_iconspx.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspx);
		
		local ed_iconspy = VFLUI.LabeledEdit:new(ui, 50); ed_iconspy:Show();
		ed_iconspy:SetText(VFLI.i18n("Height spacing"));
		if desc and desc.iconspy then ed_iconspy.editBox:SetText(desc.iconspy); else ed_iconspy.editBox:SetText("0"); end
		ui:InsertFrame(ed_iconspy);
		
		--local ed_width = VFLUI.LabeledEdit:new(ui, 50); ed_width:Show();
		--ed_width:SetText(VFLI.i18n("Width"));
		--if desc and desc.w then ed_width.editBox:SetText(desc.w); else ed_width.editBox:SetText("20"); end
		--ui:InsertFrame(ed_width);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Width"));
		local dd_width = VFLUI.Dropdown:new(er, ddw);
		dd_width:SetWidth(150); dd_width:Show();
		if desc and desc.w then dd_width:SetSelection(desc.w); else dd_width:SetSelection("180"); end
		er:EmbedChild(dd_width); er:Show();
		ui:InsertFrame(er);
		
		local ed_height = VFLUI.LabeledEdit:new(ui, 50); ed_height:Show();
		ed_height:SetText(VFLI.i18n("Height"));
		if desc and desc.h then ed_height.editBox:SetText(desc.h); else ed_height.editBox:SetText("20"); end
		ui:InsertFrame(ed_height);
		
		-------------- Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Skin parameters")));
		
		local driver = VFLUI.DisjointRadioGroup:new();
		
		local driver_NS = driver:CreateRadioButton(ui);
		driver_NS:SetText(VFLI.i18n("No Skin"));
		local driver_BS = driver:CreateRadioButton(ui);
		driver_BS:SetText(VFLI.i18n("Use Button Skin"));
		local driver_BD = driver:CreateRadioButton(ui);
		driver_BD:SetText(VFLI.i18n("Use Backdrop"));
		driver:SetValue(desc.driver or 1);
		
		ui:InsertFrame(driver_NS);
		
		ui:InsertFrame(driver_BS);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("ButtonSkin"));
		local dd_buttonskin = VFLUI.MakeButtonSkinSelectButton(er, desc.bs);
		dd_buttonskin:Show();
		er:EmbedChild(dd_buttonskin); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(driver_BD);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop"));
		local dd_backdrop = VFLUI.MakeBackdropSelectButton(er, desc.bkd);
		dd_backdrop:Show();
		er:EmbedChild(dd_backdrop); er:Show();
		ui:InsertFrame(er);
			
		-------------- Texture
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture parameters")));
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);

		-- Drawlayer
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Draw layer"));
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(150); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);
		
		-- SubLevel
		local ed_sublevel = VFLUI.LabeledEdit:new(ui, 50); ed_sublevel:Show();
		ed_sublevel:SetText(VFLI.i18n("TextureLevel offset"));
		if desc and desc.sublevel then ed_sublevel.editBox:SetText(desc.sublevel); end
		ui:InsertFrame(ed_sublevel);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Font parameters")));
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er_st, desc.font); fontsel:Show();
		er_st:EmbedChild(fontsel); er_st:Show();
		ui:InsertFrame(er_st);
		
		function ui:GetDescriptor()
			return { 
				feature = "classbar"; version = 1;
				name = ed_name.editBox:GetText();
				-- layout
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				orientation = dd_orientation:GetSelection();
				iconspx = VFL.clamp(ed_iconspx.editBox:GetNumber(), -200, 200);
				iconspy = VFL.clamp(ed_iconspy.editBox:GetNumber(), -200, 200);
				w = dd_width:GetSelection();
				h = VFL.clamp(ed_height.editBox:GetNumber(), 1, 100);
				-- display
				driver = driver:GetValue();
				bs = dd_buttonskin:GetSelectedButtonSkin();
				bkd = dd_backdrop:GetSelectedBackdrop();
				-- texture
				texture = tsel:GetSelectedTexture();
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				-- other
				font = fontsel:GetSelectedFont();
			};
		end
		
		ui.Destroy = VFL.hook(function(s) 
			driver:Destroy(); driver = nil;
		end, ui.Destroy);

		return ui;
	end;
	CreateDescriptor = function()
		local font = VFL.copy(Fonts.Default); font.size = 8; font.justifyV = "CENTER"; font.justifyH = "CENTER";
		return { 
			feature = "classbar";
			version = 1;
			name = "cb";
			owner = "Frame_decor";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			orientation = "RIGHT"; iconspx = 5; iconspy = 0;
			w = 180; h = 30;
			driver = 1;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			drawLayer = "ARTWORK"; sublevel = 1;
			fontst = font;
			texture = VFL.copy(VFLUI.defaultTexture);
		};
	end;
});

