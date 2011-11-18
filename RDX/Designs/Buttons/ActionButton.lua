-- ActionButton.lua
-- OpenRDX
-- Sigg / rashgarroth EU

-- Replace Blizzard action bar button template

------------------------------------------------------
-- Action Bar button
------------------------------------------------------

VFLUI.CreateFramePool("SecureActionButtonBar", 
	function(pool, x)
		if (not x) then return; end
		x:SetScript("OnAttributeChanged", nil); 
		x:SetScript("OnDragStart", nil); x:SetScript("OnReceiveDrag", nil);
		--VFLUI._CleanupButton(x);
		--VFLUI._CleanupLayoutFrame(x);
		x:SetBackdrop(nil);
		x:Hide(); x:SetParent(VFLParent); x:ClearAllPoints();
	end,
	function(_, key)
		local f = nil;
		if key > 0 and key < 146 then
			f = CreateFrame("CheckButton", "VFLButton" .. key, nil, "SecureActionButtonTemplate");
			VFLUI._FixFontObjectNonsense(f);
		end
		return f;
	end, 
	function(_, f) -- on acquired
	end,
"key");

local tmpId = 200;
local function GetTmpId()
	tmpId = tmpId + 1;
	return tmpId;
end

VFLUI.CreateFramePool("SecureActionButtonBarTmp", 
	function(pool, x)
		if (not x) then return; end
		x:SetScript("OnAttributeChanged", nil); 
		x:SetScript("OnDragStart", nil); x:SetScript("OnReceiveDrag", nil);
		--VFLUI._CleanupButton(x);
		--VFLUI._CleanupLayoutFrame(x);
		x:SetBackdrop(nil);
		x:Hide(); x:SetParent(VFLParent); x:ClearAllPoints();
	end,
	function(_, key)
		local f = CreateFrame("CheckButton", "VFLButton" .. GetTmpId(), nil, "SecureActionButtonTemplate");
		VFLUI._FixFontObjectNonsense(f);
		return f;
	end, 
	function(_, f) -- on acquired
		f:ClearAllPoints();
		f:Show();
	end);

local function ABShowGameTooltip(self)
	if self.action then
		if HasAction(self.action) then
			if self.showtooltip then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetAction(self.action);
				GameTooltip:Show();
			end
		else
			local infoType = GetCursorInfo();
			if infoType then
				if self.usebs then
					self._texFlash:SetAlpha(1);
					--self._texGloss:Show();
				end
			else
				if self.usebs then
					--self._texGloss:Hide();
					self._texFlash:SetAlpha(0);
				end
			end
		end
	end
	self.IsShowingTooltip = true;
end

local function ABHideGameTooltip(self)
	GameTooltip:Hide();
	if self.usebs then
		--self._texGloss:Hide();
		self._texFlash:SetAlpha(0);
	end
	self.IsShowingTooltip = nil;
end

RDXUI.ActionButton = {};

function RDXUI.ActionButton:new(parent, id, size, usebs, ebs, usebkd, bkd, os, ebhide, statesString, nbuttons, cd, showkey, showtooltip, anyup, selfcast, flyout, showgloss)
	local self = nil;
	if usebs then
		self = VFLUI.SkinButton:new(parent, "SecureActionButtonBar", id);
		if not self then self = VFLUI.SkinButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 200; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonSkin(ebs, true, true, true, true, true, true, false, true, true, showgloss);
	elseif usebkd then
		self = VFLUI.BckButton:new(parent, "SecureActionButtonBar", id);
		if not self then self = VFLUI.BckButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 200; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonBkd(bkd);
	end
	--VFLUI.StdSetParent(self, parent);
	--self:SetFrameLevel(parent:GetFrameLevel());
	-- store the id 1 to 120 of the frame for keybinding. 
	-- This is not the action. A button id can have many action when using state.
	self.id = id;
	self.btype = "";
	self.usebs = usebs;
	self.usebkd = usebkd;
	self.ebhide = ebhide;
	self.showtooltip = showtooltip;
	
	-- animating
	self.gacp = 0;
	
	-- icon texture
	self.icon = VFLUI.CreateTexture(self);
	self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", os, -os);
	self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -os, os);
	self.icon:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	self.icon:SetDrawLayer("ARTWORK", 2);
	self.icon:Show();
	-- cooldown
	self.cd = VFLUI.CooldownCounter:new(self, cd);
	self.cd:SetAllPoints(self.icon);
	-- frame for text
	self.frtxt = VFLUI.AcquireFrame("Frame");
	self.frtxt:SetParent(self);
	self.frtxt:SetFrameLevel(self:GetFrameLevel() + 2);
	self.frtxt:SetAllPoints(self);
	self.frtxt:Show();
	-- text count
	self.txtCount = VFLUI.CreateFontString(self.frtxt);
	self.txtCount:SetAllPoints(self.frtxt);
	-- text macro
	self.txtMacro = VFLUI.CreateFontString(self.frtxt);
	self.txtMacro:SetAllPoints(self.frtxt);
	-- text hotkey
	self.txtHotkey = VFLUI.CreateFontString(self.frtxt);
	self.txtHotkey:SetAllPoints(self.frtxt);
	
	local start, duration, enable, spellid = 0, 0, nil, nil;
	local function UpdateCooldown()
		start, duration, enable = GetActionCooldown(self.action);
		--if ( start > 0 and duration > 1.5 and enable > 0 ) then
		if ( start > 0 and enable > 0 ) then
			self.cd:SetCooldown(start, duration);
			self.cd:Show();
			-- store your real cooldown
			if duration >= 2 then
				_, spellid  = GetActionInfo(self.action);
				if spellid then
					--RDXEvents:Dispatch("COOLDOWN_DURATION", spellid, duration);
					RDXU.CooldownDB[spellid] = duration;
				end
			end
		else
			self.cd:SetCooldown(0, 0);
			self.cd:Hide();
		end
	end
	
	local isUsable, notEnoughMana = nil, nil;
	local function UpdateUsable()
		isUsable, notEnoughMana = IsUsableAction(self.action);
		if (isUsable) then
			self.icon:SetAlpha(1);
			self.ua = nil;
		elseif (notEnoughMana) then
			self.icon:SetAlpha(0.75);
			self.ua = true;
		else
			self.icon:SetAlpha(0.3);
		end
		if (IsConsumableAction(self.action) or IsStackableAction(self.action)) then
			self.txtCount:SetText(GetActionCount(self.action));
			self.txtCount:Show();
		else
			self.txtCount:Hide();
		end
	end
	
	local function UpdateGlow()
		local spellType, id, subType  = GetActionInfo(self.action);
		if (spellType == "spell" and IsSpellOverlayed(id)) then
			self.ga = true;
		else
			self.ga = nil;
		end
	end
	
	local function UpdateState()
		if self.usebs then
			self._texFlash:SetVertexColor(1, 1, 1, 0);
		--elseif usebkd then
			--self:SetBackdropBorderColor(1, 1, 1, 0);
		end
		if self.error then
			self.icon:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01.blp");
		else
			self.icon:SetTexture(GetActionTexture(self.action));
			if (IsCurrentAction(self.action) or IsAutoRepeatAction(self.action)) then
				self.ca = true;
			else
				self.ca = nil;
			end
		end
	end
	
	-- use when bar page changed, and the action is changed
	local function UpdateNewAction()
		self.action = self:GetAttribute("action");
		if not self.action then return; end
		if HasAction(self.action) then
			WoWEvents:Unbind("actionButton" .. self.id);
			WoWEvents:Bind("ACTIONBAR_UPDATE_STATE", nil, UpdateState, "actionButton" .. self.id);
			WoWEvents:Bind("STOP_AUTOREPEAT_SPELL", nil, UpdateState, "actionButton" .. self.id);
			WoWEvents:Bind("START_AUTOREPEAT_SPELL", nil, UpdateState, "actionButton" .. self.id);
			WoWEvents:Bind("PLAYER_LEAVE_COMBAT", nil, UpdateState, "actionButton" .. self.id);
			WoWEvents:Bind("PLAYER_ENTER_COMBAT", nil, UpdateState, "actionButton" .. self.id);
			WoWEvents:Bind("ACTIONBAR_UPDATE_USABLE", nil, UpdateUsable, "actionButton" .. self.id);
			WoWEvents:Bind("ACTIONBAR_UPDATE_COOLDOWN", nil, UpdateCooldown, "actionButton" .. self.id);
			WoWEvents:Bind("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", nil, UpdateGlow, "actionButton" .. self.id);
			WoWEvents:Bind("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE", nil, UpdateGlow, "actionButton" .. self.id);
		else
			WoWEvents:Unbind("actionButton" .. self.id);
		end
		
		if self.error then
			self.icon:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01.blp");
		else
			self.icon:SetTexture(GetActionTexture(self.action));
			UpdateGlow();
			UpdateState();
			UpdateUsable();
			UpdateCooldown();
			if HasAction(self.action) then
				if (not IsConsumableAction(self.action) and not IsStackableAction(self.action)) then
					self.txtMacro:SetText(GetActionText(self.action));
					self.txtMacro:Show();
				else
					self.txtMacro:SetText("");
					self.txtMacro:Hide();
				end
				
				if (IsEquippedAction(self.action)) then
					self.ea = true;
				else
					self.ea = nil;
				end
				
				-- Border and gloss indicator
				VFLT.AdaptiveUnschedule("ScheduleactionButton" .. id);
				VFLT.AdaptiveSchedule("ScheduleactionButton" .. id, 0.1, function()
					-- flash
					if self.ga then
						if self.gacp > 0.5 then
							self.gacp = 0;
							if self.gacolor then self.gacolor = nil; else self.gacolor = true; end
						else
							self.gacp = self.gacp + 0.1;
						end
						if self.gacolor then
							if self.usebs then
								self._texBorder:SetVertexColor(1, 0.5, 0, 0.8);
								self._texGloss:SetVertexColor(1, 0.5, 0, 0.8);
							elseif self.usebkd then
								self:SetBackdropBorderColor(1, 0.5, 0, 0.8);
							end
						else
							if self.usebs then
								self._texBorder:SetVertexColor(1, 1, 0, 0.8);
								self._texGloss:SetVertexColor(1, 1, 0, 0.8);
							elseif self.usebkd then
								self:SetBackdropBorderColor(1, 1, 0, 0.8);
							end
						end
					-- current action yellow color
					elseif self.ca then
						if self.usebs then
							self._texBorder:SetVertexColor(1, 1, 0, 0.8);
							self._texGloss:SetVertexColor(1, 1, 0, 0.8);
						elseif self.usebkd then
							self:SetBackdropBorderColor(1, 1, 0, 0.8);
						end
					-- out of range red color
					elseif IsActionInRange(self.action) == 0 then
						if self.usebs then
							self._texBorder:SetVertexColor(1, 0, 0, 0.8);
							self._texGloss:SetVertexColor(1, 0, 0, 0.8);
						elseif self.usebkd then
							self:SetBackdropBorderColor(1, 0, 0, 0.8);
						end
					-- out of mana blue color
					elseif self.ua then
						if self.usebs then
							self._texBorder:SetVertexColor(0, 0, 1, 0.8);
							self._texGloss:SetVertexColor(0, 0, 1, 0.8);
						elseif self.usebkd then
							self:SetBackdropBorderColor(0, 0, 1, 0.8);
						end
					-- equipement item green color
					elseif self.ea then
						if self.usebs then
							self._texBorder:SetVertexColor(0, 1, 0, 0.35);
							self._texGloss:SetVertexColor(0, 1, 0, 0.35);
						elseif self.usebkd then
							self:SetBackdropBorderColor(0, 1, 0, 0.35);
						end
					-- default color
					else
						if self.usebs then
							self._texBorder:SetVertexColor(1, 1, 1, 1);
							self._texGloss:SetVertexColor(1, 1, 1, 1);
						elseif self.usebkd then
							self:SetBackdropBorderColor(bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1);
						end
					end
				end);
			else
				VFLT.AdaptiveUnschedule("ScheduleactionButton" .. id);
				self.txtMacro:Hide();
				if self.usebs then
					self._texBorder:SetVertexColor(1, 1, 1, 1);
					self._texGloss:SetVertexColor(1, 1, 1, 1);
				elseif self.usebkd then
					self:SetBackdropBorderColor(bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1);
				end
			end
		end
		-- Button Skin Hide
		if self.ebhide and (not HasAction(self.action)) then
			self:bsHide();
		else
			self:bsShow();
		end
		if self.IsShowingTooltip then ABShowGameTooltip(self); end
	end
	
	-- use when drag new action binding (bug so I added IncombatLockdown)
	local function UpdateAction(action)
		--if self:GetAttribute("action") == action and not InCombatLockdown() then
		if self:GetAttribute("action") == action then
			UpdateNewAction();
		end
	end
	
	self:SetScript("OnLeave", ABHideGameTooltip);
	self:SetScript("OnEnter", ABShowGameTooltip);
	
	self:SetAttribute("type", "action");
	self:SetAttribute("action", __RDXGetCurrentButtonId(statesString, nbuttons, id));
	
	if anyup then
		self:RegisterForClicks("AnyUp");
	else
		self:RegisterForClicks("AnyDown");
	end
	self:SetAttribute('useparent-actionpage', nil);
	--self:SetAttribute('useparent-unit', true);
	self:SetAttribute("checkselfcast", true);
	self:SetAttribute("checkfocuscast", true);
	-- Add right click cast on self
	if selfcast then
		self:SetAttribute("*unit2", "player");
	end
	
	self:SetAttribute("flyoutDirection", flyout);
	
	-- Add state action for bar change
	if statesString then
		__RDXModifyActionButtonState(self, statesString, nbuttons, id);
	end
	
	-- when the state bar change, attribute action is changing
	self:SetScript("OnAttributeChanged", function()
		UpdateNewAction();
	end);
	
	self:RegisterForDrag("LeftButton", "RightButton");
	self:SetScript("OnDragStart", function()
		if not InCombatLockdown() and IsShiftKeyDown() then
			PickupAction(self:GetAttribute("action"));
			UpdateState();
		end
	end);
	self:SetScript("OnReceiveDrag", function()
		if not InCombatLockdown() then
			PlaceAction(self:GetAttribute("action"));
			UpdateState();
		end
	end);
	
	WoWEvents:Bind("ACTIONBAR_SLOT_CHANGED", nil, UpdateAction, "mainactionButton" .. self.id);
	WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, UpdateNewAction, "mainactionButton" .. self.id);
	VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, UpdateNewAction, "mainactionButton" .. self.id);
	
	----------------------------------- Bindings
	
	self.btnbind = VFLUI.AcquireFrame("Button");
	self.btnbind:SetParent(self);
	self.btnbind:SetAllPoints(self.icon);
	self.btnbind:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	self.btnbind.id = self.id;
	self.btnbind.btype = self.btype;
	self.btnbind:SetNormalFontObject("GameFontHighlight");
	--btn.btnbind:SetTextColor(0.8,0.7,0,1);
	self.btnbind:SetText(self.id);
	self.btnbind:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	self.btnbind:SetScript("OnClick", __RDXBindingKeyOnClick);
	self.btnbind:SetScript("OnEnter", __RDXBindingKeyOnEnter);
	self.btnbind:SetScript("OnLeave", __RDXBindingKeyOnLeave);
	self.btnbind:Hide();
	
	local function UpdateKeyBinding()
		local key = GetBindingKey("CLICK VFLButton" .. self.id .. ":LeftButton");
		if key then
			key = RDXKB.ToShortKey(key);
			local bindingText = GetBindingText(key, "KEY_", true);
			self.txtHotkey:SetText(bindingText or key);
			if showkey then self.txtHotkey:Show(); else self.txtHotkey:Hide(); end
		else
			self.txtHotkey:Hide();
		end
	end
	
	local function ShowBindingEdit()
		self.btnbind:Show();
	end
	
	local function HideBindingEdit()
		self.btnbind:Hide();
	end
	
	DesktopEvents:Bind("DESKTOP_UNLOCK_BINDINGS", nil, ShowBindingEdit, "bindingactionButton" .. self.id);
	DesktopEvents:Bind("DESKTOP_LOCK_BINDINGS", nil, HideBindingEdit, "bindingactionButton" .. self.id);
	DesktopEvents:Bind("DESKTOP_UPDATE_BINDINGS", nil, UpdateKeyBinding, "bindingactionButton" .. self.id);
	RDXEvents:Bind("INIT_POST_DESKTOP", nil, UpdateKeyBinding, "bindingactionButton" .. self.id);
	
	-------------------------- init
	function self:Init()
		UpdateNewAction();
		UpdateKeyBinding();
		--if RDXDK.IsKeyBindingsLocked() then
			HideBindingEdit();
		--else
		--	ShowBindingEdit();
		--end
	end
	
	self.Destroy = VFL.hook(function(s)
		VFLT.AdaptiveUnschedule("FlashactionButton" .. s.id);
		VFLT.AdaptiveUnschedule("ScheduleactionButton" .. s.id);
		DesktopEvents:Unbind("bindingactionButton" .. s.id);
		RDXEvents:Unbind("bindingactionButton" .. s.id);
		WoWEvents:Unbind("actionButton" .. s.id);
		WoWEvents:Unbind("mainactionButton" .. s.id);
		VFLEvents:Unbind("mainactionButton" .. s.id);
		s.btnbind.id = nil;
		s.btnbind.btype = nil;
		s.btnbind:Destroy(); s.btnbind = nil;
		ShowBindingEdit = nil;
		HideBindingEdit = nil;
		UpdateKeyBinding = nil;
		s.Init = nil;
		UpdateGlow = nil;
		UpdateState = nil;
		UpdateUsable = nil;
		UpdateCooldown = nil;
		UpdateAction = nil;
		UpdateNewAction = nil;
		UpdateKeyBinding = nil;
		VFLUI.ReleaseRegion(s.txtCount); s.txtCount = nil;
		VFLUI.ReleaseRegion(s.txtMacro); s.txtMacro = nil;
		VFLUI.ReleaseRegion(s.txtHotkey); s.txtHotkey = nil;
		VFLUI.ReleaseRegion(s.icon); s.icon = nil;
		s.frtxt:Destroy(); s.frtxt = nil;
		s.cd:Destroy(); s.cd = nil;
		s.id = nil;
		s.ca = nil;
		s.ua = nil;
		s.ea = nil;
		s.ga = nil;
		s.gacp = nil;
		s.gacolor = nil;
		s.flash = nil;
		s.usebs = nil;
		s.usebkd = nil;
		s.ebhide = nil;
		s.btype = nil;
		s.action = nil;
		s.showtooltip = nil;
		s.error = nil;
		s.IsShowingTooltip = nil;
	end, self.Destroy);
	
	return self;
end

-------------------------------------------
-- Multi Cast bar
-------------------------------------------
RDXUI.MultiCastButton = {};

function RDXUI.MultiCastButton:new(parent, id, size, usebs, ebs, usebkd, bkd, os, ebhide, statesString, nbuttons, cd, showkey, showtooltip, anyup)
	local self = nil;
	if usebs then
		self = VFLUI.SkinButton:new(parent, "SecureActionButtonBar", id);
		if not self then self = VFLUI.SkinButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 200; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonSkin(ebs, true, true, true, true, true, true, false, true, true, true);
	elseif usebkd then
		self = VFLUI.BckButton:new(parent, "SecureActionButtonBar", id);
		if not self then self = VFLUI.BckButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 200; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonBkd(bkd);
	end
	--VFLUI.StdSetParent(self, parent);
	--self:SetFrameLevel(parent:GetFrameLevel());
	-- store the id 1 to 120 of the frame for keybinding. 
	-- This is not the action. A button id can have many action when using state.
	self.id = id;
	self.btype = "";
	self.usebs = usebs;
	self.usebkd = usebkd;
	self.ebhide = ebhide;
	self.showtooltip = showtooltip;
	
	-- icon texture
	self.icon = VFLUI.CreateTexture(self);
	self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", os, -os);
	self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -os, os);
	self.icon:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	self.icon:SetDrawLayer("ARTWORK", 2);
	self.icon:Show();
	-- cooldown
	self.cd = VFLUI.CooldownCounter:new(self, cd);
	self.cd:SetAllPoints(self.icon);
	-- frame for text
	self.frtxt = VFLUI.AcquireFrame("Frame");
	self.frtxt:SetParent(self);
	self.frtxt:SetFrameLevel(self:GetFrameLevel() + 2);
	self.frtxt:SetAllPoints(self);
	self.frtxt:Show();
	-- text count
	self.txtCount = VFLUI.CreateFontString(self.frtxt);
	self.txtCount:SetAllPoints(self.frtxt);
	-- text macro
	self.txtMacro = VFLUI.CreateFontString(self.frtxt);
	self.txtMacro:SetAllPoints(self.frtxt);
	-- text hotkey
	self.txtHotkey = VFLUI.CreateFontString(self.frtxt);
	self.txtHotkey:SetAllPoints(self.frtxt);
	
	local start, duration, enable = 0, 0, nil;
	local function UpdateCooldown()
		start, duration, enable = GetActionCooldown(self.action);
		--if ( start > 0 and duration > 1.5 and enable > 0 ) then
		if ( start > 0 and enable > 0 ) then
			self.cd:SetCooldown(start, duration);
			self.cd:Show();
		else
			self.cd:SetCooldown(0, 0);
			self.cd:Hide();
		end
	end
	
	local isUsable, notEnoughMana = nil, nil;
	local function UpdateUsable()
		isUsable, notEnoughMana = IsUsableAction(self.action);
		if (isUsable) then
			self.icon:SetAlpha(1);
			self.ua = nil;
		elseif (notEnoughMana) then
			self.icon:SetAlpha(0.75);
			self.ua = true;
		else
			self.icon:SetAlpha(0.3);
		end
		if (IsConsumableAction(self.action) or IsStackableAction(self.action)) then
			self.txtCount:SetText(GetActionCount(self.action));
			self.txtCount:Show();
		else
			self.txtCount:Hide();
		end
	end
	
	local function UpdateState()
		if self.usebs then
			self._texFlash:SetVertexColor(1, 1, 1, 0);
		--elseif usebkd then
			--self:SetBackdropBorderColor(1, 1, 1, 0);
		end
		if self.error then
			self.icon:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01.blp");
		else
			self.icon:SetTexture(GetActionTexture(self.action));
			if (IsCurrentAction(self.action) or IsAutoRepeatAction(self.action)) then
				self.ca = true;
			else
				self.ca = nil;
			end
		end
	end
	
	-- use when bar page changed, and the action is changed
	local function UpdateNewAction()
		self.action = self:GetAttribute("action");
		if not self.action then return; end
		if HasAction(self.action) then
			WoWEvents:Unbind("multicastButton" .. self.id);
			WoWEvents:Bind("ACTIONBAR_UPDATE_STATE", nil, UpdateState, "multicastButton" .. self.id);
			--WoWEvents:Bind("STOP_AUTOREPEAT_SPELL", nil, UpdateState, "multicastButton" .. self.id);
			--WoWEvents:Bind("START_AUTOREPEAT_SPELL", nil, UpdateState, "multicastButton" .. self.id);
			--WoWEvents:Bind("PLAYER_LEAVE_COMBAT", nil, UpdateState, "multicastButton" .. self.id);
			--WoWEvents:Bind("PLAYER_ENTER_COMBAT", nil, UpdateState, "multicastButton" .. self.id);
			WoWEvents:Bind("ACTIONBAR_UPDATE_USABLE", nil, UpdateUsable, "multicastButton" .. self.id);
			WoWEvents:Bind("ACTIONBAR_UPDATE_COOLDOWN", nil, UpdateCooldown, "multicastButton" .. self.id);
		else
			WoWEvents:Unbind("multicastButton" .. self.id);
		end
		
		if self.error then
			self.icon:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01.blp");
		else
			self.icon:SetTexture(GetActionTexture(self.action));
			UpdateState();
			UpdateUsable();
			UpdateCooldown();
			if HasAction(self.action) then
				if (not IsConsumableAction(self.action) and not IsStackableAction(self.action)) then
					self.txtMacro:SetText(GetActionText(self.action));
					self.txtMacro:Show();
				else
					self.txtMacro:SetText("");
					self.txtMacro:Hide();
				end
				
				if (IsEquippedAction(self.action)) then
					self.ea = true;
				else
					self.ea = nil;
				end
				
				-- Border and gloss indicator
				VFLT.AdaptiveUnschedule("SchedulemulticastButton" .. id);
				VFLT.AdaptiveSchedule("SchedulemulticastButton" .. id, 0.1, function()
					-- current action yellow color
					if self.ca then
						if self.usebs then
							self._texBorder:SetVertexColor(1, 1, 0, 0.8);
							self._texGloss:SetVertexColor(1, 1, 0, 0.8);
						elseif self.usebkd then
							self:SetBackdropBorderColor(1, 1, 0, 0.8);
						end
					-- out of range red color
					elseif IsActionInRange(self.action) == 0 then
						if self.usebs then
							self._texBorder:SetVertexColor(1, 0, 0, 0.8);
							self._texGloss:SetVertexColor(1, 0, 0, 0.8);
						elseif self.usebkd then
							self:SetBackdropBorderColor(1, 0, 0, 0.8);
						end
					-- out of mana blue color
					elseif self.ua then
						if self.usebs then
							self._texBorder:SetVertexColor(0, 0, 1, 0.8);
							self._texGloss:SetVertexColor(0, 0, 1, 0.8);
						elseif self.usebkd then
							self:SetBackdropBorderColor(0, 0, 1, 0.8);
						end
					-- equipement item green color
					elseif self.ea then
						if self.usebs then
							self._texBorder:SetVertexColor(0, 1, 0, 0.35);
							self._texGloss:SetVertexColor(0, 1, 0, 0.35);
						elseif self.usebkd then
							self:SetBackdropBorderColor(0, 1, 0, 0.35);
						end
					-- default color
					else
						if self.usebs then
							self._texBorder:SetVertexColor(1, 1, 1, 1);
							self._texGloss:SetVertexColor(1, 1, 1, 1);
						elseif self.usebkd then
							self:SetBackdropBorderColor(bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1);
						end
					end
				end);
			else
				VFLT.AdaptiveUnschedule("SchedulemulticastButton" .. id);
				self.txtMacro:Hide();
				if self.usebs then
					self._texBorder:SetVertexColor(1, 1, 1, 1);
					self._texGloss:SetVertexColor(1, 1, 1, 1);
				elseif self.usebkd then
					self:SetBackdropBorderColor(bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1);
				end
			end
		end
		-- Button Skin Hide
		if self.ebhide and (not HasAction(self.action)) then
			self:bsHide();
		else
			self:bsShow();
		end
	end
	
	-- use when drag new action binding (bug so I added IncombatLockdown)
	local function UpdateAction(action)
		if self:GetAttribute("action") == action and not InCombatLockdown() then
			UpdateNewAction();
		end
	end
	
	self:SetScript("OnLeave", ABHideGameTooltip);
	self:SetScript("OnEnter", ABShowGameTooltip);
	
	self:SetAttribute("type", "action");
	self:SetAttribute("action", __RDXGetCurrentButtonId(statesString, nbuttons, id));
	
	if anyup then
		self:RegisterForClicks("AnyUp");
	else
		self:RegisterForClicks("AnyDown");
	end
	
	self:RegisterForDrag("LeftButton", "RightButton");
	self:SetScript("OnDragStart", function()
		if not InCombatLockdown() and IsShiftKeyDown() then
			PickupAction(self:GetAttribute("action"));
			UpdateState();
		end
	end);
	self:SetScript("OnReceiveDrag", function()
		if not InCombatLockdown() then
			PlaceAction(self:GetAttribute("action"));
			UpdateState();
		end
	end);
	
	WoWEvents:Bind("ACTIONBAR_SLOT_CHANGED", nil, UpdateAction, "mainmulticastButton" .. self.id);
	WoWEvents:Bind("UPDATE_MULTI_CAST_ACTIONBAR", nil, UpdateNewAction, "mainmulticastButton" .. self.id);
	WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, UpdateNewAction, "mainmulticastButton" .. self.id);
	-- bug: action are not available when player talent update
	VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, UpdateNewAction, "mainmulticastButton" .. self.id);
	
	----------------------------------- Bindings
	
	self.btnbind = VFLUI.AcquireFrame("Button");
	self.btnbind:SetParent(self);
	self.btnbind:SetAllPoints(self.icon);
	self.btnbind:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	self.btnbind.id = self.id;
	self.btnbind.btype = self.btype;
	self.btnbind:SetNormalFontObject("GameFontHighlight");
	--btn.btnbind:SetTextColor(0.8,0.7,0,1);
	self.btnbind:SetText(self.id);
	self.btnbind:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	self.btnbind:SetScript("OnClick", __RDXBindingKeyOnClick);
	self.btnbind:SetScript("OnEnter", __RDXBindingKeyOnEnter);
	self.btnbind:SetScript("OnLeave", __RDXBindingKeyOnLeave);
	
	local function UpdateKeyBinding()
		local key = GetBindingKey("CLICK VFLButton" .. self.id .. ":LeftButton");
		if key then
			key = RDXKB.ToShortKey(key);
			local bindingText = GetBindingText(key, "KEY_", 1);
			self.txtHotkey:SetText(bindingText or key);
			if showkey then self.txtHotkey:Show(); else self.txtHotkey:Hide(); end
		else
			self.txtHotkey:Hide();
		end
	end
	
	local function ShowBindingEdit()
		self.btnbind:Show();
	end
	
	local function HideBindingEdit()
		self.btnbind:Hide();
	end
	
	DesktopEvents:Bind("DESKTOP_UNLOCK_BINDINGS", nil, ShowBindingEdit, "bindingmulticastButton" .. self.id);
	DesktopEvents:Bind("DESKTOP_LOCK_BINDINGS", nil, HideBindingEdit, "bindingmulticastButton" .. self.id);
	DesktopEvents:Bind("DESKTOP_UPDATE_BINDINGS", nil, UpdateKeyBinding, "bindingmulticastButton" .. self.id);
	RDXEvents:Bind("INIT_POST_DESKTOP", nil, UpdateKeyBinding, "bindingmulticastButton" .. self.id);
	
	-------------------------- init
	function self:Init()
		UpdateNewAction();
		UpdateKeyBinding();
		--if RDXDK.IsKeyBindingsLocked() then
			HideBindingEdit();
		--else
		--	ShowBindingEdit();
		--end
	end
	
	self.Destroy = VFL.hook(function(s)
		VFLT.AdaptiveUnschedule("FlashmulticastButton" .. s.id);
		VFLT.AdaptiveUnschedule("SchedulemulticastButton" .. s.id);
		DesktopEvents:Unbind("bindingmulticastButton" .. s.id);
		RDXEvents:Unbind("bindingmulticastButton" .. s.id);
		WoWEvents:Unbind("multicastButton" .. s.id);
		WoWEvents:Unbind("mainmulticastButton" .. s.id);
		VFLEvents:Unbind("mainmulticastButton" .. s.id);
		s.btnbind.id = nil;
		s.btnbind.btype = nil;
		s.btnbind:Destroy(); s.btnbind = nil;
		ShowBindingEdit = nil;
		HideBindingEdit = nil;
		UpdateKeyBinding = nil;
		s.Init = nil;
		UpdateState = nil;
		UpdateUsable = nil;
		UpdateCooldown = nil;
		UpdateAction = nil;
		UpdateNewAction = nil;
		UpdateKeyBinding = nil;
		VFLUI.ReleaseRegion(s.txtCount); s.txtCount = nil;
		VFLUI.ReleaseRegion(s.txtMacro); s.txtMacro = nil;
		VFLUI.ReleaseRegion(s.txtHotkey); s.txtHotkey = nil;
		VFLUI.ReleaseRegion(s.icon); s.icon = nil;
		s.frtxt:Destroy(); s.frtxt = nil;
		s.cd:Destroy(); s.cd = nil;
		s.id = nil;
		s.ca = nil;
		s.ua = nil;
		s.ea = nil;
		s.flash = nil;
		s.usebs = nil;
		s.usebkd = nil;
		s.ebhide = nil;
		s.btype = nil;
		s.action = nil;
		s.showtooltip = nil;
		s.error = nil;
	end, self.Destroy);
	
	return self;
end

-------------------------------------------
-- PetActionButton
-------------------------------------------

VFLUI.CreateFramePool("SecureActionButtonPet", 
	function(pool, x)
	if (not x) then return; end
		x:SetScript("OnDragStart", nil); x:SetScript("OnReceiveDrag", nil);
		--VFLUI._CleanupButton(x);
		--VFLUI._CleanupLayoutFrame(x);
		x:SetBackdrop(nil);
		x:Hide(); x:SetParent(VFLParent); x:ClearAllPoints();
		end,
	function(_, key)
		local f = nil;
		if key > 0 and key < 11 then
			f = CreateFrame("CheckButton", "VFLPetButton" .. key, nil, "SecureActionButtonTemplate");
			VFLUI._FixFontObjectNonsense(f);
		end
		return f;
	end, 
	function(_, f) -- on acquired
		f:ClearAllPoints();
		f:SetBackdrop(nil);
		f:Show();
	end,
"key");

function ABPShowGameTooltip(self)
	if ( not self.tooltipName ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if self.isToken then
		GameTooltip:SetText(self.tooltipName..NORMAL_FONT_COLOR_CODE.." ("..GetBindingText(GetBindingKey("VFLPetButton"..self.id), "KEY_")..")"..FONT_COLOR_CODE_CLOSE, 1.0, 1.0, 1.0);
		if ( self.tooltipSubtext ) then
			GameTooltip:AddLine(self.tooltipSubtext, "", 0.5, 0.5, 0.5);
		end
	else
		GameTooltip:SetPetAction(self.id);
	end
	GameTooltip:Show();
end

function ABPHideGameTooltip()
	GameTooltip:Hide();
end

RDXUI.PetActionButton = {};

function RDXUI.PetActionButton:new(parent, id, size, usebs, ebs, usebkd, bkd, os, ebhide, statesString, nbuttons, cd, showkey, showtooltip, anyup)
	local self = nil;
	if usebs then
		self = VFLUI.SkinButton:new(parent, "SecureActionButtonPet", id);
		if not self then self = VFLUI.SkinButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 400; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonSkin(ebs, true, true, true, true, true, true, false, true, true, true);
	elseif usebkd then
		self = VFLUI.BckButton:new(parent, "SecureActionButtonPet", id);
		if not self then self = VFLUI.BckButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 400; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonBkd(bkd);
	end
	VFLUI.StdSetParent(self, parent);
	self:SetFrameLevel(parent:GetFrameLevel());
	-- store the id 1 to 10 of the frame for keybinding. 
	-- This is not the action. A button id can have many action when using state.
	self.id = id;
	self.btype = "Pet";
	self.usebs = usebs;
	self.usebkd = usebkd;
	self.ebhide = ebhide;
	
	-- icon texture
	self.icon = VFLUI.CreateTexture(self);
	self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", os, -os);
	self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -os, os);
	self.icon:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	self.icon:SetDrawLayer("ARTWORK", 2);
	self.icon:Show();
	-- cooldown
	self.cd = VFLUI.CooldownCounter:new(self, cd);
	self.cd:SetAllPoints(self.icon);
	-- frame for text
	self.frtxt = VFLUI.AcquireFrame("Frame");
	self.frtxt:SetParent(self);
	self.frtxt:SetFrameLevel(self:GetFrameLevel() + 2);
	self.frtxt:SetAllPoints(self);
	self.frtxt:Show();
	self.txtHotkey = VFLUI.CreateFontString(self.frtxt);
	self.txtHotkey:SetAllPoints(self.frtxt);
	
	local start, duration, enable = 0, 0, nil;
	local function UpdateCooldown()
		start, duration, enable = GetPetActionCooldown(self.id);
		if ( start > 0 and enable > 0 ) then
			self.cd:SetCooldown(start, duration);
			self.cd:Show();
		else
			self.cd:SetCooldown(0, 0);
			self.cd:Hide();
		end
	end
	
	local isUsable, notEnoughMana = nil, nil;
	local function UpdateUsable()
		isUsable, notEnoughMana = GetPetActionsUsable(self.id);
		if (isUsable) then
			self.icon:SetAlpha(1);
			self.ua = nil;
		elseif (notEnoughMana) then
			self.icon:SetAlpha(0.75);
			self.ua = true;
		else
			self.icon:SetAlpha(0.3);
		end
	end
	
	local name, subtext, texture, token, active, autocastallowed, autocastenabled = nil, nil, nil, nil, nil, nil, nil;
	local function UpdateState()
		if self.usebs then
			self._texFlash:SetVertexColor(0, 0, 0, 0);
		--elseif usebkd then
		--	self:SetBackdropBorderColor(0, 0, 0, 0);
		end
		self.icon:SetTexture(texture);
		if active then
			self.ca = true;
		else
			self.ca = nil;
		end
	end
	
	-- use when bar page changed, and the action is changed
	local function UpdateNewAction()
		name, subtext, texture, isToken, active, autocastallowed, autocastenabled = GetPetActionInfo(self.id);
		self.isToken = isToken;
		self.tooltipSubtext = subtext;
		if isToken then texture = _G[texture]; self.ea = nil; self.tooltipName = _G[name] else self.ea = true; self.tooltipName = name; end
		self.icon:SetTexture(texture);
		if autocastallowed and (not InCombatLockdown()) then
			self:SetAttribute("macrotext2", "/petautocasttoggle "..name);
		end
		if name then
			WoWEvents:Unbind("actionButtonPet" .. self.id);
			WoWEvents:Bind("PLAYER_CONTROL_LOST", nil, UpdateState, "actionButtonPet" .. self.id);
			WoWEvents:Bind("PLAYER_CONTROL_GAINED", nil, UpdateState, "actionButtonPet" .. self.id);
			WoWEvents:Bind("START_AUTOREPEAT_SPELL", nil, UpdateState, "actionButtonPet" .. self.id);
			WoWEvents:Bind("PET_BAR_UPDATE_COOLDOWN", nil, UpdateCooldown, "actionButtonPet" .. self.id);
		else
			WoWEvents:Unbind("actionButtonPet" .. self.id);
		end
		UpdateState();
		UpdateUsable();
		UpdateCooldown();
		if name then
			-- Border and gloss indicator
			VFLT.AdaptiveUnschedule("ScheduleactionButtonPet" .. self.id);
			VFLT.AdaptiveSchedule("ScheduleactionButtonPet" .. self.id, 0.3, function()
				-- current action yellow color
				if self.ca then
					if self.usebs then
						self._texBorder:SetVertexColor(1, 1, 0, 0.8);
						self._texGloss:SetVertexColor(1, 1, 0, 0.8);
					elseif self.usebkd then
						self:SetBackdropBorderColor(1, 1, 0, 0.8);
					end
				-- out of range red color
				--elseif IsActionInRange(action) == 0 then
				--	self._texBorder:SetVertexColor(1, 0, 0, 0.8);
				--	self._texGloss:SetVertexColor(1, 0, 0, 0.8);
				-- out of mana blue color
				elseif self.ua then
					if self.usebs then
						self._texBorder:SetVertexColor(0, 0, 1, 0.8);
						self._texGloss:SetVertexColor(0, 0, 1, 0.8);
					elseif self.usebkd then
						self:SetBackdropBorderColor(0, 0, 1, 0.8);
					end
				-- local spell
				elseif self.ea and autocastenabled then
					if self.usebs then
						self._texBorder:SetVertexColor(0, 1, 0, 0.35);
						self._texGloss:SetVertexColor(0, 1, 0, 0.35);
					elseif self.usebkd then
						self:SetBackdropBorderColor(0, 1, 0, 0.35);
					end
				-- default color
				else
					if self.usebs then
						self._texBorder:SetVertexColor(1, 1, 1, 1);
						self._texGloss:SetVertexColor(1, 1, 1, 1);
					elseif self.usebkd then
						self:SetBackdropBorderColor(bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1);
					end
				end
			end);
		else
			VFLT.AdaptiveUnschedule("ScheduleactionButtonPet" .. self.id);
			if self.usebs then
				self._texBorder:SetVertexColor(1, 1, 1, 1);
				self._texGloss:SetVertexColor(1, 1, 1, 1);
			elseif self.usebkd then
				self:SetBackdropBorderColor(bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1);
			end
		end
		
		-- Button Skin Hide
		if self.ebhide and (not name) then
			self:bsHide();
		else
			self:bsShow();
		end
	end
	
	-- use when drag new action binding
	local function UpdateAction(arg1)
		if arg1 == "player" and not InCombatLockdown() then UpdateNewAction(); end
	end
	
	if  showtooltip then
		self:SetScript("OnLeave", ABPHideGameTooltip);
		self:SetScript("OnEnter", ABPShowGameTooltip);
	end
	
	self:SetAttribute("*type1", "pet");
	self:SetAttribute("*action1", self.id);
	self:SetAttribute("type2", "macro");
	
	if anyup then
		self:RegisterForClicks("AnyUp");
	else
		self:RegisterForClicks("AnyDown");
	end
	
	self:RegisterForDrag("LeftButton", "RightButton");
	self:SetScript("OnDragStart", function()
		if not InCombatLockdown() and IsShiftKeyDown() then
			PickupPetAction(self.id);
			UpdateState();
		end
	end);
	self:SetScript("OnReceiveDrag", function()
		if not InCombatLockdown() then
			PickupPetAction(self.id);
			UpdateState();
		end
	end);
	
	--WoWEvents:Bind("PLAYER_CONTROL_LOST", nil, UpdateState, "actionButtonPet" .. self.id);
	--WoWEvents:Bind("PLAYER_CONTROL_GAINED", nil, UpdateState, "actionButtonPet" .. self.id);
	--WoWEvents:Bind("START_AUTOREPEAT_SPELL", nil, UpdateState, "actionButtonPet" .. self.id);
	--WoWEvents:Bind("PET_BAR_UPDATE_COOLDOWN", nil, UpdateCooldown, "actionButtonPet" .. self.id);
	
	WoWEvents:Bind("PET_BAR_UPDATE", nil, UpdateNewAction, "mainactionButtonPet" .. self.id);
	WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, UpdateNewAction, "mainactionButtonPet" .. self.id);
	WoWEvents:Bind("UNIT_PET", nil, UpdateAction, "mainactionButtonPet" .. self.id);
	VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, UpdateNewAction, "mainactionButtonPet" .. self.id);
	
	----------------------------------- Bindings
	
	self.btnbind = VFLUI.AcquireFrame("Button");
	self.btnbind:SetParent(self);
	self.btnbind:SetAllPoints(self.icon);
	self.btnbind:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	self.btnbind.id = self.id;
	self.btnbind.btype = self.btype;
	self.btnbind:SetNormalFontObject("GameFontHighlight");
	--btn.btnbind:SetTextColor(0.8,0.7,0,1);
	self.btnbind:SetText(self.id);
	self.btnbind:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	self.btnbind:SetScript("OnClick", __RDXBindingKeyOnClick);
	self.btnbind:SetScript("OnEnter", __RDXBindingKeyOnEnter);
	self.btnbind:SetScript("OnLeave", __RDXBindingKeyOnLeave);
	
	local function UpdateKeyBinding()
		local key = GetBindingKey("CLICK VFLPetButton" .. self.id .. ":LeftButton");
		if key then
			key = RDXKB.ToShortKey(key);
			local bindingText = GetBindingText(key, "KEY_", 1);
			self.txtHotkey:SetText(bindingText or key);
			if showkey then self.txtHotkey:Show(); else self.txtHotkey:Hide(); end
		else
			self.txtHotkey:Hide();
		end
	end
	
	local function ShowBindingEdit()
		self.btnbind:Show();
	end
	
	local function HideBindingEdit()
		self.btnbind:Hide();
	end
	
	DesktopEvents:Bind("DESKTOP_UNLOCK_BINDINGS", nil, ShowBindingEdit, "bindingactionButtonPet" .. self.id);
	DesktopEvents:Bind("DESKTOP_LOCK_BINDINGS", nil, HideBindingEdit, "bindingactionButtonPet" .. self.id);
	DesktopEvents:Bind("DESKTOP_UPDATE_BINDINGS", nil, UpdateKeyBinding, "bindingactionButtonPet" .. self.id);
	RDXEvents:Bind("INIT_POST_DESKTOP", nil, UpdateKeyBinding, "bindingactionButtonPet" .. self.id);
	
	-------------------------- init
	function self:Init()
		UpdateNewAction();
		UpdateKeyBinding();
		--if RDXDK.IsKeyBindingsLocked() then
			HideBindingEdit();
		--else
		--	ShowBindingEdit();
		--end
	end
	
	self.Destroy = VFL.hook(function(s)
		VFLT.AdaptiveUnschedule("ScheduleactionButtonPet" .. s.id);
		DesktopEvents:Unbind("bindingactionButtonPet" .. s.id);
		RDXEvents:Unbind("bindingactionButtonPet" .. s.id);
		WoWEvents:Unbind("actionButtonPet" .. s.id);
		WoWEvents:Unbind("mainactionButtonPet" .. s.id);
		VFLEvents:Unbind("mainactionButtonPet" .. s.id);
		s.btnbind.id = nil;
		s.btnbind.btype = nil;
		s.btnbind:Destroy(); s.btnbind = nil;
		ShowBindingEdit = nil;
		HideBindingEdit = nil;
		UpdateKeyBinding = nil;
		s.Init = nil;
		UpdateState = nil;
		UpdateUsable = nil;
		UpdateCooldown = nil;
		UpdateAction = nil;
		UpdateNewAction = nil;
		VFLUI.ReleaseRegion(s.txtHotkey); s.txtHotkey = nil;
		VFLUI.ReleaseRegion(s.icon); s.icon = nil;
		s.frtxt:Destroy(); s.frtxt = nil;
		s.cd:Destroy(); s.cd = nil;
		s.isToken = nil;
		s.tooltipSubtext = nil;
		s.id = nil;
		s.ca = nil;
		s.ua = nil;
		s.ea = nil;
		s.flash = nil;
		s.usebs = nil;
		s.usebkd = nil;
		s.ebhide = nil;
		s.btype = nil;
	end, self.Destroy);
	
	return self;
end

-------------------------------------------
-- Stance Button
-------------------------------------------

VFLUI.CreateFramePool("SecureActionButtonStance", function(pool, x)
	if (not x) then return; end
	--VFLUI._CleanupButton(x);
	--VFLUI._CleanupLayoutFrame(x);
	x:SetBackdrop(nil);
	x:Hide(); x:SetParent(VFLParent); x:ClearAllPoints();
end, function(_, key)
	local f = nil;
	if key > 0 and key < 11 then
		f = CreateFrame("CheckButton", "VFLStanceButton" .. key, nil, "SecureActionButtonTemplate");
		VFLUI._FixFontObjectNonsense(f);
	end
	return f;
end, VFL.Noop, "key");

function ABSShowGameTooltip(self)
	if ( not self.tooltipName ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if self.isToken then
		GameTooltip:SetText(self.tooltipName..NORMAL_FONT_COLOR_CODE.." ("..GetBindingText(GetBindingKey("VFLPetButton"..self.id), "KEY_")..")"..FONT_COLOR_CODE_CLOSE, 1.0, 1.0, 1.0);
		if ( self.tooltipSubtext ) then
			GameTooltip:AddLine(self.tooltipSubtext, "", 0.5, 0.5, 0.5);
		end
	else
		GameTooltip:SetPetAction(self.id);
	end
	GameTooltip:Show();
end

function ABSHideGameTooltip()
	GameTooltip:Hide();
end

RDXUI.StanceButton = {};

function RDXUI.StanceButton:new(parent, id, size, usebs, ebs, usebkd, bkd, os, ebhide, statesString, nbuttons, cd, showkey, showtooltip)
	local self = nil;
	if usebs then
		self = VFLUI.SkinButton:new(parent, "SecureActionButtonStance", id);
		if not self then self = VFLUI.SkinButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 300; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonSkin(ebs, true, true, true, true, true, true, false, true, true, true);
	elseif usebkd then
		self = VFLUI.BckButton:new(parent, "SecureActionButtonStance", id);
		if not self then self = VFLUI.BckButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 200; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonBkd(bkd);
	end
	--VFLUI.StdSetParent(self, parent);
	--self:SetFrameLevel(parent:GetFrameLevel());
	
	self.id = id;
	self.btype = "Stance";
	self.usebs = usebs;
	self.usebkd = usebkd;
	self.ebhide = ebhide;
	
	-- icon texture
	self.icon = VFLUI.CreateTexture(self);
	self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", os, -os);
	self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -os, os);
	self.icon:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	self.icon:SetDrawLayer("ARTWORK", 2);
	self.icon:Show();
	-- cooldown
	self.cd = VFLUI.CooldownCounter:new(self, cd);
	self.cd:SetAllPoints(self.icon);
	-- frame for text
	self.frtxt = VFLUI.AcquireFrame("Frame");
	self.frtxt:SetParent(self);
	self.frtxt:SetFrameLevel(self:GetFrameLevel() + 2);
	self.frtxt:SetAllPoints(self);
	self.frtxt:Show();
	self.txtHotkey = VFLUI.CreateFontString(self.frtxt);
	self.txtHotkey:SetAllPoints(self.frtxt);
	
	local start, duration, enable = 0, 0, nil;
	local function UpdateCooldown()
		start, duration, enable = GetShapeshiftFormCooldown(self.id);
		if ( start > 0 and enable > 0 ) then
			self.cd:SetCooldown(start, duration);
			self.cd:Show();
		else
			self.cd:SetCooldown(0, 0);
			self.cd:Hide();
		end
	end
	
	local texture, name, isActive, isCastable = "", nil, nil, nil;
	local function UpdateState()
		texture, name, isActive, isCastable = GetShapeshiftFormInfo(self.id);
		if self.usebs then
			self._texFlash:SetVertexColor(0, 0, 0, 0);
		--elseif usebkd then
		--	self:SetBackdropBorderColor(0, 0, 0, 0);
		end
		self.icon:SetTexture(texture);
		if isActive then
			if self.usebs then
				self._texBorder:SetVertexColor(1, 1, 0, 0.8);
				self._texGloss:SetVertexColor(1, 1, 0, 0.8);
			elseif usebkd then
				self:SetBackdropBorderColor(1, 1, 0, 0.8);
			end
		else
			if self.usebs then
				self._texBorder:SetVertexColor(1, 1, 1, 1);
				self._texGloss:SetVertexColor(1, 1, 1, 1);
			elseif usebkd then
				self:SetBackdropBorderColor(bkd.br or 1, bkd.bg or 1, bkd.bb or 1, bkd.ba or 1);
			end
		end
		if isCastable then
			self.icon:SetAlpha(1);
		else
			self.icon:SetAlpha(0.3);
		end
	end
	
	local function UpdateBinds()
		self:SetAttribute("type", "spell");
		self:SetAttribute("spell", select(2, GetShapeshiftFormInfo(self.id)));
	end
	
	-- use when bar page changed, and the action is changed
	local function UpdateNewAction()
		texture, name, isActive, isCastable = GetShapeshiftFormInfo(self.id);
		self.icon:SetTexture(texture);
		if name then
			self:Show();
			WoWEvents:Unbind("actionButtonStance" .. self.id);
			WoWEvents:Bind("UPDATE_SHAPESHIFT_FORM", nil, UpdateState, "actionButtonStance" .. self.id);
			WoWEvents:Bind("UPDATE_SHAPESHIFT_USABLE", nil, UpdateState, "actionButtonStance" .. self.id);
			WoWEvents:Bind("UPDATE_SHAPESHIFT_COOLDOWN", nil, UpdateCooldown, "actionButtonStance" .. self.id);
		else
			self:Hide();
			WoWEvents:Unbind("actionButtonStance" .. self.id);
		end
		UpdateBinds();
		UpdateState();
		UpdateCooldown();
	end

	if showtooltip then
		self:SetScript("OnLeave", ABSHideGameTooltip);
		self:SetScript("OnEnter", ABSShowGameTooltip);
	end
	
	WoWEvents:Bind("UPDATE_SHAPESHIFT_FORMS", nil, UpdateAction, "mainactionButtonStance" .. self.id);
	WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, UpdateNewAction, "mainactionButtonStance" .. self.id);
	--WoWEvents:Bind("PLAYER_TALENT_UPDATE", nil, UpdateNewAction, "mainactionButtonStance" .. self.id);
	VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, UpdateNewAction, "mainactionButtonStance" .. self.id);
	
	----------------------------------- Bindings
	
	self.btnbind = VFLUI.AcquireFrame("Button");
	self.btnbind:SetParent(self);
	self.btnbind:SetAllPoints(self.icon);
	self.btnbind:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	self.btnbind.id = self.id;
	self.btnbind.btype = self.btype;
	self.btnbind:SetNormalFontObject("GameFontHighlight");
	self.btnbind:SetText(self.id);
	self.btnbind:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	self.btnbind:SetScript("OnClick", __RDXBindingKeyOnClick);
	self.btnbind:SetScript("OnEnter", __RDXBindingKeyOnEnter);
	self.btnbind:SetScript("OnLeave", __RDXBindingKeyOnLeave);
	
	local function UpdateKeyBinding()
		local key = GetBindingKey("CLICK VFLStanceButton" .. self.id .. ":LeftButton");
		if key then
			key = RDXKB.ToShortKey(key);
			local bindingText = GetBindingText(key, "KEY_", 1);
			self.txtHotkey:SetText(bindingText or key);
			if showkey then self.txtHotkey:Show(); else self.txtHotkey:Hide(); end
		else
			self.txtHotkey:Hide();
		end
	end
	
	local function ShowBindingEdit()
		self.btnbind:Show();
	end
	
	local function HideBindingEdit()
		self.btnbind:Hide();
	end
	
	DesktopEvents:Bind("DESKTOP_UNLOCK_BINDINGS", nil, ShowBindingEdit, "bindingactionButtonStance" .. self.id);
	DesktopEvents:Bind("DESKTOP_LOCK_BINDINGS", nil, HideBindingEdit, "bindingactionButtonStance" .. self.id);
	DesktopEvents:Bind("DESKTOP_UPDATE_BINDINGS", nil, UpdateKeyBinding, "bindingactionButtonStance" .. self.id);
	RDXEvents:Bind("INIT_POST_DESKTOP", nil, UpdateKeyBinding, "bindingactionButtonStance" .. self.id);
	
	-------------------------- init
	function self:Init()
		UpdateNewAction();
		UpdateKeyBinding();
		--if RDXDK.IsKeyBindingsLocked() then
			HideBindingEdit();
		--else
		--	ShowBindingEdit();
		--end
	end
	
	self.Destroy = VFL.hook(function(s)
		s:SetAttribute("type", nil);
		s:SetAttribute("spell", nil);
		DesktopEvents:Unbind("bindingactionButtonStance" .. s.id);
		RDXEvents:Unbind("bindingactionButtonStance" .. s.id);
		WoWEvents:Unbind("actionButtonStance" .. s.id);
		WoWEvents:Unbind("mainactionButtonStance" .. s.id);
		VFLEvents:Unbind("mainactionButtonStance" .. s.id);
		s.btnbind.id = nil;
		s.btnbind.btype = nil;
		s.btnbind:Destroy(); s.btnbind = nil;
		ShowBindingEdit = nil;
		HideBindingEdit = nil;
		UpdateKeyBinding = nil;
		s.Init = nil;
		UpdateState = nil;
		UpdateCooldown = nil;
		UpdateAction = nil;
		UpdateNewAction = nil;
		VFLUI.ReleaseRegion(s.txtHotkey); s.txtHotkey = nil;
		VFLUI.ReleaseRegion(s.icon); s.icon = nil;
		s.frtxt:Destroy(); s.frtxt = nil;
		s.cd:Destroy(); s.cd = nil;
		s.id = nil;
		s.usebs = nil;
		s.usebkd = nil;
		s.ebhide = nil;
		s.btype = nil;
	end, self.Destroy);
	
	return self;
end

--
-- button test
--

RDXUI.ActionButtonTest = {};

function RDXUI.ActionButtonTest:new(parent, id, size, usebs, ebs, usebkd, bkd, os, ebhide, statesString, nbuttons, cd, showkey, showtooltip, anyup)
	local self = nil;
	if usebs then
		self = VFLUI.SkinButton:new(parent, "SecureActionButtonBarTmp"); id = 400;
		if not self then self = VFLUI.SkinButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 400; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonSkin(ebs, true, true, false, true, true, true, false, true, true, true);
	elseif usebkd then
		self = VFLUI.BckButton:new(parent, "SecureActionButtonBar", id);
		if not self then self = VFLUI.BckButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 400; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonBkd(bkd);
	end
	--VFLUI.StdSetParent(self, parent);
	--self:SetFrameLevel(parent:GetFrameLevel());
	-- store the id 1 to 10 of the frame for keybinding. 
	
	self.usebs = usebs;
	self.usebkd = usebkd;
	self.ebhide = ebhide;
	
	-- icon texture
	self.icon = VFLUI.CreateTexture(self);
	self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", os, -os);
	self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -os, os);
	self.icon:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	self.icon:SetDrawLayer("ARTWORK", 2);
	self.icon:Show();
	-- cooldown
	self.cd = VFLUI.CooldownCounter:new(self, cd);
	self.cd:SetAllPoints(self.icon);
	-- frame for text
	self.frtxt = VFLUI.AcquireFrame("Frame");
	self.frtxt:SetParent(self);
	self.frtxt:SetFrameLevel(self:GetFrameLevel() + 2);
	self.frtxt:SetAllPoints(self);
	self.frtxt:Show();
	self.txtHotkey = VFLUI.CreateFontString(self.frtxt);
	self.txtHotkey:SetAllPoints(self.frtxt);
	
	function self:Init()
		self.cd:SetCooldown(GetTime() + 60 - 120, 120);
		self.cd:Show();
		self.txtHotkey:SetText("1");
		self.icon:SetTexture("Interface\\Addons\\RDX\\Skin\\whackaMole");
		self.txtHotkey:Show();
		self:bsShow();
	end
	
	self.Destroy = VFL.hook(function(s)
		s.Init = nil;
		VFLUI.ReleaseRegion(s.txtHotkey); s.txtHotkey = nil;
		s.frtxt:Destroy(); s.frtxt = nil;
		VFLUI.ReleaseRegion(s.icon); s.icon = nil;
		s.cd:Destroy(); s.cd = nil;
		s.usebs = nil;
		s.usebkd = nil;
		s.ebhide = nil;
	end, self.Destroy);
	
	return self;
end

-------------------------------------------
-- Vehicle Button
-------------------------------------------

VFLUI.CreateFramePool("ButtonVehicle",
	function(pool, x)
		if (not x) then return; end
		--x:SetScript("OnDragStart", nil); x:SetScript("OnReceiveDrag", nil);
		--VFLUI._CleanupButton(x);
		--VFLUI._CleanupLayoutFrame(x);
		x:SetBackdrop(nil);
		x:Hide(); x:SetParent(VFLParent); x:ClearAllPoints();
		end, 
	function(_, key)
		local f = nil;
		if key > 0 and key < 11 then
			f = CreateFrame("Button", "VFLVehicleButton" .. key, nil, "SecureUnitButtonTemplate");
			VFLUI._FixFontObjectNonsense(f);
		end
		return f;
	end,
VFL.Noop, "key");

function ABVShowGameTooltip(self)
	if ( not self.tooltipName ) then
		return;
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if self.isToken then
		GameTooltip:SetText(self.tooltipName..NORMAL_FONT_COLOR_CODE.." ("..GetBindingText(GetBindingKey("VFLVehicleButton"..self.id), "KEY_")..")"..FONT_COLOR_CODE_CLOSE, 1.0, 1.0, 1.0);
		if ( self.tooltipSubtext ) then
			GameTooltip:AddLine(self.tooltipSubtext, "", 0.5, 0.5, 0.5);
		end
	else
		GameTooltip:SetText(self.tooltipName..NORMAL_FONT_COLOR_CODE, "", 1.0, 1.0, 1.0);
	end
	GameTooltip:Show();
end

function ABVHideGameTooltip()
	GameTooltip:Hide();
end

RDXUI.VehicleButton = {};

function RDXUI.VehicleButton:new(parent, id, size, usebs, ebs, usebkd, bkd, os, ebhide, statesString, nbuttons, testmode)
	local self = nil;
	if usebs then
		self = VFLUI.SkinButton:new(parent, "ButtonVehicle", id);
		if not self then self = VFLUI.SkinButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 400; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonSkin(ebs, true, true, false, true, true, true, false, false, true, true);
	elseif usebkd then
		self = VFLUI.BckButton:new(parent, "ButtonVehicle", id);
		if not self then self = VFLUI.BckButton:new(parent, "SecureActionButtonBarTmp"); self.error = true; id = 200; end
		self:SetWidth(size); self:SetHeight(size);
		self:SetButtonBkd(bkd);
	end
	--VFLUI.StdSetParent(self, parent);
	--self:SetFrameLevel(parent:GetFrameLevel());
	
	self.id = id;
	self.btype = "Vehicle";
	self.usebs = usebs;
	self.usebkd = usebkd;
	
	-- icon texture
	self.icon = VFLUI.CreateTexture(self);
	self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", os, -os);
	self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -os, os);
	self.icon:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
	self.icon:SetDrawLayer("ARTWORK", 2);
	self.icon:Show();
	self.frtxt = VFLUI.AcquireFrame("Frame");
	self.frtxt:SetParent(self);
	self.frtxt:SetFrameLevel(self:GetFrameLevel() + 2);
	self.frtxt:SetAllPoints(self);
	self.frtxt:Show();
	self.txtHotkey = VFLUI.CreateFontString(self.frtxt);
	self.txtHotkey:SetAllPoints(self.frtxt);
	
	local function UpdateNewAction()
		if self.id == 1 then
			self.icon:SetTexture("Interface\\Vehicles\\UI-Vehicles-Button-Pitch-Up");
			self.icon:SetTexCoord(0.21875, 0.765625, 0.234375, 0.78125);
		elseif self.id == 2 then
			self.icon:SetTexture("Interface\\Vehicles\\UI-Vehicles-Button-PitchDown-Up");
			self.icon:SetTexCoord(0.21875, 0.765625, 0.234375, 0.78125);
		elseif self.id == 3 then
			self.icon:SetTexture("Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up");
			self.icon:SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375);
		end
		if testmode then
			self.icon:Show();
			self:bsShow();
		else
			if IsVehicleAimAngleAdjustable() then
				if self.id == 1 or self.id == 2 then
					self.icon:Show();
					self:bsShow();
				end
			else
				if self.id == 1 or self.id == 2 then
					self.icon:Hide();
					self:bsHide();
				end
			end
			if CanExitVehicle() then
				if self.id == 3 then
					self.icon:Show();
					self:bsShow();
				end
			else
				if self.id == 3 then
					self.icon:Hide();
					self:bsHide();
				end
			end
		end
	end
	
	-- use when drag new action binding
	local function UpdateAction(arg1)
		if arg1 == "player" then UpdateNewAction(); end
	end
	
	self:SetScript("OnLeave", ABVHideGameTooltip);
	self:SetScript("OnEnter", ABVShowGameTooltip);
	self:SetAttribute("unit", "player");
	
	if self.id == 1 then
		self.tooltipName = "Target UP";
		self:SetAttribute("type", "macro");
		self:SetAttribute("macrotext", "/run VehicleAimIncrement()");
	elseif self.id == 2 then
		self.tooltipName = "Target DOWN";
		self:SetAttribute("type", "macro");
		self:SetAttribute("macrotext", "/run VehicleAimDecrement()");
	elseif self.id == 3 then
		self.tooltipName = "Vehicle Exit";
		self:SetScript("OnClick", VehicleExit);
	end
	
	WoWEvents:Bind("UNIT_ENTERED_VEHICLE", nil, UpdateAction, "actionButtonVehicle" .. self.id);
	
	----------------------------------- Bindings
	
	self.btnbind = VFLUI.AcquireFrame("Button");
	self.btnbind:SetParent(self);
	self.btnbind:SetAllPoints(self.icon);
	self.btnbind:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	self.btnbind.id = self.id;
	self.btnbind.btype = self.btype;
	self.btnbind:SetNormalFontObject("GameFontHighlight");
	self.btnbind:SetText(self.id);
	self.btnbind:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	self.btnbind:SetScript("OnClick", __RDXBindingKeyOnClick);
	self.btnbind:SetScript("OnEnter", __RDXBindingKeyOnEnter);
	self.btnbind:SetScript("OnLeave", __RDXBindingKeyOnLeave);
	
	local function UpdateKeyBinding()
		local key = GetBindingKey("CLICK VFLVehicleButton" .. self.id .. ":LeftButton");
		if key then
			key = RDXKB.ToShortKey(key);
			local bindingText = GetBindingText(key, "KEY_", 1);
			self.txtHotkey:SetText(bindingText or key);
			self.txtHotkey:Show();
		else
			self.txtHotkey:Hide();
		end
	end
	
	local function ShowBindingEdit()
		self.btnbind:Show();
	end
	
	local function HideBindingEdit()
		self.btnbind:Hide();
	end
	
	DesktopEvents:Bind("DESKTOP_UNLOCK_BINDINGS", nil, ShowBindingEdit, "bindingactionButtonVehicle" .. self.id);
	DesktopEvents:Bind("DESKTOP_LOCK_BINDINGS", nil, HideBindingEdit, "bindingactionButtonVehicle" .. self.id);
	DesktopEvents:Bind("DESKTOP_UPDATE_BINDINGS", nil, UpdateKeyBinding, "bindingactionButtonVehicle" .. self.id);
	RDXEvents:Bind("INIT_POST_DESKTOP", nil, UpdateKeyBinding, "bindingactionButtonVehicle" .. self.id);
	
	-------------------------- init
	function self:Init()
		UpdateNewAction();
		UpdateKeyBinding();
		--if RDXDK.IsKeyBindingsLocked() then
			HideBindingEdit();
		--else
		--	ShowBindingEdit();
		--end
	end
	
	self.Destroy = VFL.hook(function(s)
		DesktopEvents:Unbind("bindingactionButtonVehicle" .. s.id);
		RDXEvents:Unbind("bindingactionButtonVehicle" .. s.id);
		WoWEvents:Unbind("actionButtonVehicle" .. s.id);
		s.btnbind.id = nil;
		s.btnbind.btype = nil;
		s.btnbind:Destroy(); s.btnbind = nil;
		ShowBindingEdit = nil;
		HideBindingEdit = nil;
		UpdateKeyBinding = nil;
		s.Init = nil;
		UpdateAction = nil;
		UpdateNewAction = nil;
		VFLUI.ReleaseRegion(s.txtHotkey); s.txtHotkey = nil;
		VFLUI.ReleaseRegion(s.icon); s.icon = nil;
		s.frtxt:Destroy(); s.frtxt = nil;
		s.id = nil;
		s.btype = nil;
		s.usebs = nil;
		s.usebkd = nil;
		s.ebhide = nil;
	end, self.Destroy);
	
	return self;
end

