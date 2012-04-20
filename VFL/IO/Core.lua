
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
	function(_, key) -- on fallback
		local f = CreateFrame("ScrollingMessageFrame", "SMF" .. key, nil, "ChatFrameTemplate");
		f:UnregisterEvent("UPDATE_CHAT_WINDOWS");
		f:UnregisterEvent("UPDATE_CHAT_COLOR");
		f:SetScript("OnMouseWheel", scroll);
		f:EnableMouseWheel(true);
		return f;
	end, 
	function(_, f) -- on acquired
		--f:Show();
		--f:ClearAllPoints();
	end,
"key");


VFLIO.Console = VFLUI.AcquireFrame("ChatFrame", "console");
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
