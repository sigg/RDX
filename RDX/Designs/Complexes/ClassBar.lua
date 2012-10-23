RDXUI.ClassBar = {};

function RDXUI.ClassBar:new(parent, root, desc)
	
	local f = VFLUI.AcquireFrame(desc.btype);
	f:SetParent(parent);
	f:SetFrameLevel(parent:GetFrameLevel());
	f:SetWidth(desc.w);
	f:SetHeight(desc.h);
	f:Show();
	f.list = {};
	
	f.id = "ClassBar_" .. math.random(10000000);;
	
	local class = select(2, UnitClass("PLAYER"));
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
		
	elseif class == "WARLOCK" and spec == SPEC_WARLOCK_AFFLICTION then --and IsPlayerSpell(WARLOCK_SOULBURN) then
		
	elseif class == "WARLOCK" and spec == SPEC_WARLOCK_DESTRUCTION then --and IsPlayerSpell(WARLOCK_BURNING_EMBERS) then
		
	elseif class == "WARLOCK" and spec == SPEC_WARLOCK_DEMONOLOGY then
		
	elseif class == "DRUID" and (form == MOONKIN_FORM or not form) and spec == 1 then
		
	--elseif class == "DRUID" and form == 3 then
	--	return data["DRUIDCAT"];
	elseif class == "PALADIN" then
		for i = 1, 5 do
			btn = VFLUI.AcquireFrame("Frame");
			-- size will reset depend of additional rune
			btn:SetWidth(desc.w /3); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Show();
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetAllPoints(btn);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			VFLUI.SetTexture(btn.tex, desc.texture);
			btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri2);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		
	elseif class == "MONK" then
	
		for i = 1, 4 do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /4); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Show();
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetAllPoints(btn);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			VFLUI.SetTexture(btn.tex, desc.texture);
			btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri2);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		
		f.Update = function(self)
			local numOrbs = UnitPower(root:GetAttribute("unit"), SPELL_POWER_LIGHT_FORCE);
			for i = 1, 4 do
				local orb = self.list[i];
				local shouldShow = i <= numOrbs;
				if shouldShow then
					f.list[i]:Show();
				else
					f.list[i]:Hide();
				end
			end
		end
		
		f.CheckAndShow = function(self)
			WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function() f:Update(); end, f.id);
			WoWEvents:Bind("UNIT_POWER_FREQUENT", nil, function(self, arg1, arg2) 
				if (arg1 == root:GetAttribute("unit") and ( arg2 == "LIGHT_FORCE" or arg2 == "DARK_FORCE" ) then
					f:Update();
				end 
			end, f.id);
			f:Update();
		end
		
		-- call
		f:CheckAndShow();
		
	elseif class == "PRIEST" then
		
		-- create
		for i = 1, PRIEST_BAR_NUM_ORBS do
			btn = VFLUI.AcquireFrame("Frame");
			btn:SetWidth(desc.w /PRIEST_BAR_NUM_ORBS); btn:SetHeight(desc.h);
			btn:SetParent(f); btn:SetFrameLevel(f:GetFrameLevel());
			btn:Show();
			
			if desc.driver == 2 then
				VFLUI.SetButtonSkin(btn, desc.bs);
			elseif desc.driver == 3 then
				VFLUI.SetBackdrop(btn, desc.bkd);
			end
			
			btn.tex = VFLUI.CreateTexture(btn);
			btn.tex:SetAllPoints(btn);
			btn.tex:SetDrawLayer("ARTWORK", 3);
			VFLUI.SetTexture(btn.tex, desc.texture);
			btn.tex:Show();
				
			if i == 1 then
				btn:SetPoint(opri1, f, opri2);
			else
				btn:SetPoint(opri1, f.list[i-1], opri2, csx, csy);
			end
			
			f.list[i] = btn;
		end
		
		f.Update = function(self)
			local numOrbs = UnitPower(root:GetAttribute("unit"), SPELL_POWER_SHADOW_ORBS);
			for i = 1, PRIEST_BAR_NUM_ORBS do
				local orb = self.list[i];
				local shouldShow = i <= numOrbs;
				if shouldShow then
					f.list[i]:Show();
				else
					f.list[i]:Hide();
				end
			end
		end
		
		f.CheckAndShow = function(self)
			local spec = GetSpecialization();
			if ( spec == SPEC_PRIEST_SHADOW ) then
				WoWEvents:Bind("UNIT_DISPLAYPOWER", nil, function() f:Update(); end, f.id);
				WoWEvents:Bind("UNIT_POWER_FREQUENT", nil, function(self, arg1, arg2) 
					if (arg1 == root:GetAttribute("unit") and ( arg2 == "SHADOW_ORBS" ) then
						f:Update();
					end 
				end, f.id);
			else
				WoWEvents:Unbind(f.id);
			end
			f:Update();
		end
		
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function() 
			--PLAYER_FORM_UPDATE
			f:CheckAndShow();
		end, f.id);
		
		-- call
		f:CheckAndShow();
		
	else
		-- do nothing
	end
	
	f.Destroy = VFL.hook(function(s2)
		WoWEvents:Unbind(s2.id);
		VFLEvents:Unbind(s2.id);
		s2.id = nil;
		s2.Update = nil;
		s2.CheckAndShow = nil;
		for i,v in pairs(s2.list) do
			if v.tex then v.tex:Destroy(); v.tex = nil; end
			v:Destroy(); v = nil;
		end
	end, f.Destroy);
	return f;
end