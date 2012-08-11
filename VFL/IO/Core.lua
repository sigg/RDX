
VFLIO = RegisterVFLModule({
	name = "VFLIO";
	description = "Common IO components for VFL";
	parent = VFL;
});
VFLP.RegisterCategory("VFL IO");

-- helper scroll
local function scroll(self, arg1)
	if arg1 > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop();
		elseif IsControlKeyDown() then
			self:PageUp();
		else
			self:ScrollUp();
		end
	elseif arg1 < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom();
		elseif IsControlKeyDown() then
			self:PageDown();
		else
			self:ScrollDown();
		end
	end
end

VFLUI.CreateFramePool("ChatFrame", 
	function(pool, x) -- on released
		if (not x) then return; end
		VFLUI._CleanupLayoutFrame(x);
	end,
	function() -- on fallback
		local id = VFL.GetNextID()
		local f = CreateFrame("ScrollingMessageFrame", "SMF" .. id, nil, "VFLChatFrameTemplate");
		f:UnregisterEvent("UPDATE_CHAT_WINDOWS");
		f:UnregisterEvent("UPDATE_CHAT_COLOR");
		f:SetScript("OnMouseWheel", scroll);
		f:EnableMouseWheel(true);
		f:SetID(1);
		return f;
	end, 
	function(_, f) -- on acquired
		--f:Show();
		--f:ClearAllPoints();
		ChatFrame_RemoveAllMessageGroups(f);
		f.channelList = {};
		f.zoneChannelList = {};
	end
);

VFLUI.CreateFramePool("ChatFrame2", 
	function(pool, x) -- on released
		if (not x) then return; end
		x:SetScript("OnShow", nil);
		x:SetScript("OnSizeChanged", nil);
		--VFLUI._CleanupLayoutFrame(x);
		x:Hide(); x:SetParent(nil);
	end,
	function() -- on fallback
		-- main frame
		local f = CreateFrame("Frame");
		f:SetWidth(400); f:SetHeight(250);
		-- cf bg
		f.cfbg = CreateFrame("Frame");
		f.cfbg:SetParent(f);
		f.cfbg:SetWidth(f:GetWidth()); f.cfbg:SetHeight(f:GetHeight() - 26);
		f.cfbg:SetPoint("TOP", f, "TOP");
		f.cfbg:Show();
		-- eb bg
		f.ebbg = CreateFrame("Frame");
		f.ebbg:SetParent(f);
		f.ebbg:SetWidth(f:GetWidth()); f.ebbg:SetHeight(26);
		f.ebbg:SetPoint("TOP", f.cfbg, "BOTTOM");
		f.ebbg:Show();
		
		-- the chatframe
		f.cf = CreateFrame("ScrollingMessageFrame", "SMF" .. VFL.GetNextID(), nil, "VFLChatFrameTemplate");
		f.cf:SetParent(f.cfbg);
		f.cf:SetWidth(f:GetWidth() - 10); f.cf:SetHeight(f:GetHeight() - 36);
		f.cf:SetPoint("TOPLEFT", f.cfbg, "TOPLEFT", 5, -5);
		f.cf:Show();
		
		f.cf:UnregisterEvent("UPDATE_CHAT_WINDOWS");
		f.cf:UnregisterEvent("UPDATE_CHAT_COLOR");
		f.cf:SetScript("OnMouseWheel", scroll);
		f.cf:EnableMouseWheel(true);
		f.cf:SetID(1);
		local left, mid, right, l2, m2, r2 = select(6, f.cf.editBox:GetRegions());
		left:Hide();
		mid:Hide();
		right:Hide();
		l2:SetTexture(nil);
		m2:SetTexture(nil);
		r2:SetTexture(nil);
		
		return f;
	end, 
	function(_, f) -- on acquired
		--f:Show();
		--f:ClearAllPoints();
		ChatFrame_RemoveAllMessageGroups(f.cf);
		f.cf.channelList = {};
		f.cf.zoneChannelList = {};
		
		f:SetScript("OnShow", function(self)
			self.cfbg:SetWidth(self:GetWidth()); self.cfbg:SetHeight(self:GetHeight() - 26);
			self.ebbg:SetWidth(self:GetWidth()); self.ebbg:SetHeight(26);
			self.cf:SetWidth(self:GetWidth() - 10); self.cf:SetHeight(self:GetHeight() - 36);
		end);
		
		f:SetScript("OnSizeChanged", function(self)
			self.cfbg:SetWidth(self:GetWidth()); self.cfbg:SetHeight(self:GetHeight() - 26);
			self.ebbg:SetWidth(self:GetWidth()); self.ebbg:SetHeight(26);
			self.cf:SetWidth(self:GetWidth() - 10); self.cf:SetHeight(self:GetHeight() - 36);
		end);
	end
);

-- hack
local ts = ChatEdit_UpdateHeader;
ChatEdit_UpdateHeader = function(editBox)
	local header = _G[editBox:GetName().."Header"];
	if header then
		header:ClearAllPoints();
		header:SetPoint("LEFT", editBox, "LEFT", 15, 0);
		if header:GetRight() ~= nil and header:GetLeft() ~= nil then
			ts(editBox);
		end
	end
end
-- reset the defaut editbox on hide
ChatEdit_OnHide = VFL.Noop;

VFLUI.CreateFramePool("ChatFrameEditBox", 
	function(pool, x) -- on released
		if (not x) then return; end
		--VFLUI._CleanupLayoutFrame(x);
		x:Hide();
	end,
	function(_, key) -- on fallback
		--local f = CreateFrame("EditBox", "EB" .. key, nil, "ChatFrameEditBoxTemplate");
		local f = _G["ChatFrame1EditBox"];
		return f;
	end, 
	function(_, f) -- on acquired
		--f:Show();
		f:ClearAllPoints();
	end,
"key");


VFLIO.Console = VFLUI.AcquireFrame("ChatFrame");
ChatFrame_AddMessageGroup(VFLIO.Console, "SYSTEM");


--[[
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "SYSTEM");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "SAY");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "EMOTE");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "YELL");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "WHISPER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BN_WHISPER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "PARTY");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "PARTY_LEADER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "RAID");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "RAID_LEADER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "RAID_WARNING");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BATTLEGROUND");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BATTLEGROUND_LEADER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "GUILD");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "OFFICER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "MONSTER_SAY");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "MONSTER_YELL");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "MONSTER_EMOTE");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "MONSTER_WHISPER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "MONSTER_BOSS_EMOTE");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "MONSTER_BOSS_WHISPER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "ERRORS");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "AFK");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "DND");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "IGNORED");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BG_HORDE");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BG_ALLIANCE");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BG_NEUTRAL");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "COMBAT_XP_GAIN");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "COMBAT_HONOR_GAIN");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "COMBAT_FACTION_CHANGE");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "SKILL");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "LOOT");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "CURRENCY");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "MONEY");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "OPENING");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "TRADESKILLS");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "PET_INFO");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "COMBAT_MISC_INFO");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "ACHIEVEMENT");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "GUILD_ACHIEVEMENT");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "CHANNEL");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "TARGETICONS");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BN_WHISPER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BN_CONVERSATION");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "BN_INLINE_TOAST_ALERT");
ChatFrame_AddMessageGroup(VFLIO.Chatframe1, "COMBAT_GUILD_XP_GAIN");

VFLIO.Chatframe2 = VFLUI.AcquireFrame("ChatFrame");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "SAY");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "YELL");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "GUILD");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "WHISPER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "BN_WHISPER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "PARTY");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "PARTY_LEADER");
ChatFrame_AddMessageGroup(VFLIO.Chatframe2, "CHANNEL");
]]
