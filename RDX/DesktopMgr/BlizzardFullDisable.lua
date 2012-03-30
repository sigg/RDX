-- OpenRDX
-- Sigg Rashgarroth

local opt = nil;

local disabledframes = {
	"ActionBarButtonEventsFrame",
	"ActionBarActionEventsFrame",
	"ActionButton1",
	"ActionButton2",
	"ActionButton3",
	"ActionButton4",
	"ActionButton5",
	"ActionButton6",
	"ActionButton7",
	"ActionButton8",
	"ActionButton9",
	"ActionButton10",
	"ActionButton11",
	"ActionButton12",
	"PlayerFrameAlternateManaBar",
	"BonusActionButton1",
	"BonusActionButton2",
	"BonusActionButton3",
	"BonusActionButton4",
	"BonusActionButton5",
	"BonusActionButton6",
	"BonusActionButton7",
	"BonusActionButton8",
	"BonusActionButton9",
	"BonusActionButton10",
	"BonusActionButton11",
	"BonusActionButton12",
	"BonusActionBarFrame",
	"PossessButton1",
	"PossessButton2",
	"PossessBarFrame",
	"BuffFrame",
	"ConsolidatedBuffs",
	"ConsolidatedBuffsTooltip",
	"TemporaryEnchantFrame",
	"TempEnchant1",
	"TempEnchant2",
	"TempEnchant3",
	"CastingBarFrame",
	"ComboPoint1",
	"ComboPoint2",
	"ComboPoint3",
	"ComboPoint4",
	"ComboPoint5",
	"ComboFrame",
	"EclipseBarFrame",
	"FocusFrameHealthBar",
	"FocusFrameManaBar",
	"FocusFrameSpellBar",
	--"FocusFrameDebuff1",
	--"FocusFrameDebuff2",
	--"FocusFrameDebuff3",
	--"FocusFrameDebuff4",
	--"FocusFrameDebuff5",
	--"FocusFrameDebuff6",
	--"FocusFrameDebuff7",
	--"FocusFrameDebuff8",
	"FocusFrameNumericalThreat",
	"FocusFrame",
	--"TargetofFocusHealthBar",
	--"TargetofFocusManaBar",
	--"TargetofFocusFrameDebuff1",
	--"TargetofFocusFrameDebuff2",
	--"TargetofFocusFrameDebuff3",
	--"TargetofFocusFrameDebuff4",
	--"TargetofFocusFrame",
	"MainMenuExpBar",
	"ExhaustionTick",
	"MainMenuBarMaxLevelBar",
	"MainMenuBar",
	"MinimapCluster",
	"MultiBarBottomLeftButton1",
	"MultiBarBottomLeftButton2",
	"MultiBarBottomLeftButton3",
	"MultiBarBottomLeftButton4",
	"MultiBarBottomLeftButton5",
	"MultiBarBottomLeftButton6",
	"MultiBarBottomLeftButton7",
	"MultiBarBottomLeftButton8",
	"MultiBarBottomLeftButton9",
	"MultiBarBottomLeftButton10",
	"MultiBarBottomLeftButton11",
	"MultiBarBottomLeftButton12",
	"MultiBarBottomLeft",
	"MultiBarBottomRightButton1",
	"MultiBarBottomRightButton2",
	"MultiBarBottomRightButton3",
	"MultiBarBottomRightButton4",
	"MultiBarBottomRightButton5",
	"MultiBarBottomRightButton6",
	"MultiBarBottomRightButton7",
	"MultiBarBottomRightButton8",
	"MultiBarBottomRightButton9",
	"MultiBarBottomRightButton10",
	"MultiBarBottomRightButton11",
	"MultiBarBottomRightButton12",
	"MultiBarBottomRight",
	"MultiBarRightButton1",
	"MultiBarRightButton2",
	"MultiBarRightButton3",
	"MultiBarRightButton4",
	"MultiBarRightButton5",
	"MultiBarRightButton6",
	"MultiBarRightButton7",
	"MultiBarRightButton8",
	"MultiBarRightButton9",
	"MultiBarRightButton10",
	"MultiBarRightButton11",
	"MultiBarRightButton12",
	"MultiBarRight",
	"MultiBarLeftButton1",
	"MultiBarLeftButton2",
	"MultiBarLeftButton3",
	"MultiBarLeftButton4",
	"MultiBarLeftButton5",
	"MultiBarLeftButton6",
	"MultiBarLeftButton7",
	"MultiBarLeftButton8",
	"MultiBarLeftButton9",
	"MultiBarLeftButton10",
	"MultiBarLeftButton11",
	"MultiBarLeftButton12",
	"MultiBarLeft",
	"MultiCastFlyoutFrame",
	"MultiCastFlyoutFrameOpenButton",
	"MultiCastSummonSpellButton",
	"MultiCastSlotButton1",
	"MultiCastSlotButton2",
	"MultiCastSlotButton3",
	"MultiCastSlotButton4",
	"MultiCastActionBarFrame",
	"PaladinPowerBar",
	"PartyMemberFrame1Debuff1",
	"PartyMemberFrame1Debuff2",
	"PartyMemberFrame1Debuff3",
	"PartyMemberFrame1Debuff4",
	"PartyMemberFrame1PowerBarAlt",
	"PartyMemberFrame1HealthBar",
	"PartyMemberFrame1ManaBar",
	"PartyMemberFrame1MyHealPredictionBar",
	"PartyMemberFrame1OtherHealPredictionBar",
	"PartyMemberFrame1Speaker",
	"PartyMemberFrame1SpeakerFrame",
	"PartyMemberFrame1ReadyCheck",
	"PartyMemberFrame1PhasingIcon",
	"PartyMemberFrame1",
	"PartyMemberFrame2Debuff1",
	"PartyMemberFrame2Debuff2",
	"PartyMemberFrame2Debuff3",
	"PartyMemberFrame2Debuff4",
	"PartyMemberFrame2PowerBarAlt",
	"PartyMemberFrame2HealthBar",
	"PartyMemberFrame2ManaBar",
	"PartyMemberFrame2MyHealPredictionBar",
	"PartyMemberFrame2OtherHealPredictionBar",
	"PartyMemberFrame2Speaker",
	"PartyMemberFrame2SpeakerFrame",
	"PartyMemberFrame2ReadyCheck",
	"PartyMemberFrame2PhasingIcon",
	"PartyMemberFrame2",
	"PartyMemberFrame3Debuff1",
	"PartyMemberFrame3Debuff2",
	"PartyMemberFrame3Debuff3",
	"PartyMemberFrame3Debuff4",
	"PartyMemberFrame3PowerBarAlt",
	"PartyMemberFrame3HealthBar",
	"PartyMemberFrame3ManaBar",
	"PartyMemberFrame3MyHealPredictionBar",
	"PartyMemberFrame3OtherHealPredictionBar",
	"PartyMemberFrame3Speaker",
	"PartyMemberFrame3SpeakerFrame",
	"PartyMemberFrame3ReadyCheck",
	"PartyMemberFrame3PhasingIcon",
	"PartyMemberFrame3",
	"PartyMemberFrame4Debuff1",
	"PartyMemberFrame4Debuff2",
	"PartyMemberFrame4Debuff3",
	"PartyMemberFrame4Debuff4",
	"PartyMemberFrame4PowerBarAlt",
	"PartyMemberFrame4HealthBar",
	"PartyMemberFrame4ManaBar",
	"PartyMemberFrame4MyHealPredictionBar",
	"PartyMemberFrame4OtherHealPredictionBar",
	"PartyMemberFrame4Speaker",
	"PartyMemberFrame4SpeakerFrame",
	"PartyMemberFrame4ReadyCheck",
	"PartyMemberFrame4PhasingIcon",
	"PartyMemberFrame4",
	"PartyMemberFrame1PetFrameDebuff1",
	"PartyMemberFrame1PetFrameDebuff2",
	"PartyMemberFrame1PetFrameDebuff3",
	"PartyMemberFrame1PetFrameDebuff4",
	"PartyMemberFrame1PetFrameHealthBar",
	"PartyMemberFrame1PetFrame",
	"PartyMemberFrame2PetFrameDebuff1",
	"PartyMemberFrame2PetFrameDebuff2",
	"PartyMemberFrame2PetFrameDebuff3",
	"PartyMemberFrame2PetFrameDebuff4",
	"PartyMemberFrame2PetFrameHealthBar",
	"PartyMemberFrame2PetFrame",
	"PartyMemberFrame3PetFrameDebuff1",
	"PartyMemberFrame3PetFrameDebuff2",
	"PartyMemberFrame3PetFrameDebuff3",
	"PartyMemberFrame3PetFrameDebuff4",
	"PartyMemberFrame3PetFrameHealthBar",
	"PartyMemberFrame3PetFrame",
	"PartyMemberFrame4PetFrameDebuff1",
	"PartyMemberFrame4PetFrameDebuff2",
	"PartyMemberFrame4PetFrameDebuff3",
	"PartyMemberFrame4PetFrameDebuff4",
	"PartyMemberFrame4PetFrameHealthBar",
	"PartyMemberFrame4PetFrame",
	"PetActionButton1",
	"PetActionButton2",
	"PetActionButton3",
	"PetActionButton4",
	"PetActionButton5",
	"PetActionButton6",
	"PetActionButton7",
	"PetActionButton8",
	"PetActionButton9",
	"PetActionButton10",
	"PetActionBarFrame",
	"PetFrameDebuff1",
	"PetFrameDebuff2",
	"PetFrameDebuff3",
	"PetFrameDebuff4",
	"PetFrameHealthBar",
	"PetFrameManaBar",
	"PetFrameMyHealPredictionBar",
	"PetFrameOtherHealPredictionBar",
	"PetFrame",
	"PetCastingBarFrame",
	"PlayerFrameHealthBar",
	"PlayerFrameManaBar",
	"PlayerFrameMyHealPredictionBar",
	"PlayerFrameOtherHealPredictionBar",
	"PlayerSpeakerFrame",
	"PlayerFrameReadyCheck",
	"PlayerPVPIconHitArea",
	"PlayerStatusGlow",
	"PlayerPlayTime",
	"PlayerFrameGroupIndicator",
	"PlayerFrame",
	"RuneButtonIndividual1",
	"RuneButtonIndividual2",
	"RuneButtonIndividual3",
	"RuneButtonIndividual4",
	"RuneButtonIndividual5",
	"RuneButtonIndividual6",
	"RuneFrame",
	"ShapeshiftButton1",
	"ShapeshiftButton2",
	"ShapeshiftButton3",
	"ShapeshiftButton4",
	"ShapeshiftButton5",
	"ShapeshiftButton6",
	"ShapeshiftButton7",
	"ShapeshiftButton8",
	"ShapeshiftButton9",
	"ShapeshiftButton10",
	"ShapeshiftBarFrame",
	"ShardBarFrameShard1",
	"ShardBarFrameShard2",
	"ShardBarFrameShard3",
	"ShardBarFrame",
	--"TargetFrameToTNumericalThreat",
	--"TargetFrameToTDebuffs",
	--"TargetFrameToTBuffs",
	"TargetFrameToTManaBar",
	--"TargetFrameToTOtherHealPredictionBar",
	--"TargetFrameToTMyHealPredictionBar",
	"TargetFrameToTHealthBar",
	"TargetFrameToTTextureFrame",
	--"TargetFrameToTPowerBarAlt",
	--"TargetFrameToTSpellBar",
	"TargetFrameToT",
	"TargetFrameDebuffs",
	"TargetFrameBuffs",
	"TargetFrameHealthBar",
	"TargetFrameManaBar",
	"TargetFrameMyHealPredictionBar",
	"TargetFrameOtherHealPredictionBar",
	"TargetFrameNumericalThreat",
	"TargetFrameTextureFrame",
	"TargetFramePowerBarAlt",
	"TargetFrameSpellBar",
	"TargetFrame",
	--"FocusFrameToTNumericalThreat",
	--"FocusFrameToTDebuffs",
	--"FocusFrameToTBuffs",
	"FocusFrameToTManaBar",
	--"FocusFrameToTOtherHealPredictionBar",
	--"FocusFrameToTMyHealPredictionBar",
	"FocusFrameToTHealthBar",
	"FocusFrameToTTextureFrame",
	--"FocusFrameToTPowerBarAlt",
	--"FocusFrameToTSpellBar",
	"FocusFrameToT",
	"FocusFrameNumericalThreat",
	"FocusFrameDebuffs",
	"FocusFrameBuffs",
	"FocusFrameManaBar",
	"FocusFrameOtherHealPredictionBar",
	"FocusFrameMyHealPredictionBar",
	"FocusFrameHealthBar",
	"FocusFrameTextureFrame",
	"FocusFramePowerBarAlt",
	"FocusFrameSpellBar",
	"FocusFrame",
	"Boss1TargetFrameNumericalThreat",
	"Boss1TargetFrameDebuffs",
	"Boss1TargetFrameBuffs",
	"Boss1TargetFrameManaBar",
	"Boss1TargetFrameOtherHealPredictionBar",
	"Boss1TargetFrameMyHealPredictionBar",
	"Boss1TargetFrameHealthBar",
	"Boss1TargetFrameTextureFrame",
	"Boss1TargetFramePowerBarAlt",
	"Boss1TargetFrame",
	"Boss2TargetFrameNumericalThreat",
	"Boss2TargetFrameDebuffs",
	"Boss2TargetFrameBuffs",
	"Boss2TargetFrameManaBar",
	"Boss2TargetFrameOtherHealPredictionBar",
	"Boss2TargetFrameMyHealPredictionBar",
	"Boss2TargetFrameHealthBar",
	"Boss2TargetFrameTextureFrame",
	"Boss2TargetFramePowerBarAlt",
	"Boss2TargetFrame",
	"Boss3TargetFrameNumericalThreat",
	"Boss3TargetFrameDebuffs",
	"Boss3TargetFrameBuffs",
	"Boss3TargetFrameManaBar",
	"Boss3TargetFrameOtherHealPredictionBar",
	"Boss3TargetFrameMyHealPredictionBar",
	"Boss3TargetFrameHealthBar",
	"Boss3TargetFrameTextureFrame",
	"Boss3TargetFramePowerBarAlt",
	"Boss3TargetFrame",
	"Boss4TargetFrameNumericalThreat",
	"Boss4TargetFrameDebuffs",
	"Boss4TargetFrameBuffs",
	"Boss4TargetFrameManaBar",
	"Boss4TargetFrameOtherHealPredictionBar",
	"Boss4TargetFrameMyHealPredictionBar",
	"Boss4TargetFrameHealthBar",
	"Boss4TargetFrameTextureFrame",
	"Boss4TargetFramePowerBarAlt",
	"Boss4TargetFrame",
	"TotemFrameTotem4",
	"TotemFrameTotem3",
	"TotemFrameTotem2",
	"TotemFrameTotem1",
	"TotemFrame",
	"VehicleMenuBarActionButton1",
	"VehicleMenuBarActionButton2",
	"VehicleMenuBarActionButton3",
	"VehicleMenuBarActionButton4",
	"VehicleMenuBarActionButton5",
	"VehicleMenuBarActionButton6",
	"VehicleMenuBarHealthBar",    
	"VehicleMenuBarPowerBar",
	"VehicleMenuBar",
	--"ReputationFrame",
	"ReputationWatchBar",
};

function RDXDK.DisableAll()
	local f;

	for i,v in ipairs(disabledframes) do
		f = _G[v];
		if f then
			f:UnregisterAllEvents();
			f:SetScript("OnUpdate", nil);
			f:SetScript("OnHide", nil);
			f:SetScript("OnShow", nil);
			f:Hide();
		else
			VFL.print(v);
		end
	end
	
	-- MainMenuBarArtFrame some events must be active
	MainMenuBarArtFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
	MainMenuBarArtFrame:UnregisterEvent("BAG_UPDATE");
	MainMenuBarArtFrame:UnregisterEvent("ACTIONBAR_PAGE_CHANGED");
	--MainMenuBarArtFrame:UnregisterEvent("CURRENCY_DISPLAY_UPDATE");
	MainMenuBarArtFrame:UnregisterEvent("ADDON_LOADED");
	MainMenuBarArtFrame:UnregisterEvent("UNIT_ENTERING_VEHICLE");
	MainMenuBarArtFrame:UnregisterEvent("UNIT_ENTERED_VEHICLE");
	MainMenuBarArtFrame:UnregisterEvent("UNIT_EXITING_VEHICLE");
	MainMenuBarArtFrame:UnregisterEvent("UNIT_EXITED_VEHICLE");
	MainMenuBarArtFrame:UnregisterEvent("UNIT_LEVEL");
	MainMenuBarArtFrame:SetScript("OnUpdate", nil);
	MainMenuBarArtFrame:Hide();
	
	local ignorebuttons = {
		"MiniMapMailFrame",
		"MiniMapBattlefieldFrame",
		"MinimapPing",
		"MiniMapVoiceChatFrame",
	};

	local flagfoundbutton = nil
	local function findButtons()
		for i, child in ipairs({Minimap:GetChildren()}) do
			flagfoundbutton = nil;
			for k,v in ipairs(ignorebuttons) do
				if child:GetName() == v then flagfoundbutton = true; end
			end
			if not flagfoundbutton then child:Hide(); end
		end
	end
	WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, findButtons);
	RDXEvents:Bind("INIT_DEFERRED", nil, findButtons);
	findButtons();
	
	-- combatlogs
	Blizzard_CombatLog_Update_QuickButtons = VFL.Noop;
	CombatLog_OnEvent = VFL.Noop;
	ChatFrame2:Hide();
	ChatFrame2:SetScript("OnShow", ChatFrame2.Hide);
	ChatFrame2Tab:Hide();
	ChatFrame2Tab:SetScript("OnShow", ChatFrame2Tab.Hide);

	-- disable focus function
	for _, menu in pairs(UnitPopupMenus) do
		for button, name in pairs(menu) do
			if (name == 'SET_FOCUS') then
				table.remove(menu, button);
			elseif (name == 'CLEAR_FOCUS') then
				table.remove(menu, button);
			elseif (name == 'MOVE_PLAYER_FRAME') then
				table.remove(menu, button);
			elseif (name == 'MOVE_TARGET_FRAME') then
				table.remove(menu, button);
			elseif (name == 'LOCK_FOCUS_FRAME') then
				table.remove(menu, button);
			elseif (name == 'UNLOCK_FOCUS_FRAME') then
				table.remove(menu, button);
			elseif (name == 'PET_DISMISS') then
				table.remove(menu, button);
			end
		end
	end
	
	MainMenuBarBackpackButton_UpdateFreeSlots = VFL.Noop;
	
	-- boss
	for i=1,4 do
		f = _G["Boss"..i.."TargetFrame"];
		f:SetScript("OnShow", f.Hide);
		f.SetScript = VFL.Noop;
	end
	
	CompactRaidFrameManager:UnregisterAllEvents();
	CompactRaidFrameManager:Hide();
	CompactRaidFrameContainer:UnregisterEvent("RAID_ROSTER_UPDATE");
	CompactRaidFrameContainer:UnregisterEvent("UNIT_PET");
	CompactRaidFrameContainer:Hide();
	
	AuraButton_Update = VFL.Noop;
	TalentMicroButton:UnregisterEvent("PLAYER_TALENT_UPDATE");
	
	MultiBarBottomLeft.ignoreFramePositionManager = true;
	MultiBarRight.ignoreFramePositionManager = true;
	CastingBarFrame.ignoreFramePositionManager = true;    
	PlayerPowerBarAlt.ignoreFramePositionManager = true;
	ExtraActionBarFrame.ignoreFramePositionManager = true;
	ChatFrame1.ignoreFramePositionManager = true;
	ChatFrame2.ignoreFramePositionManager = true;
	ShapeshiftBarFrame.ignoreFramePositionManager = true;
	PossessBarFrame.ignoreFramePositionManager = true;
	MultiCastActionBarFrame.ignoreFramePositionManager = true;
	MainMenuBarMaxLevelBar.ignoreFramePositionManager = true;
	ReputationWatchBar.ignoreFramePositionManager = true;
	MainMenuBarMaxLevelBar.ignoreFramePositionManager = true;
	
	ReputationWatchBar_Update = VFL.Noop;
	
	-- TO BE TESTED
	FCF_OnUpdate = VFL.Noop;
	
	RDX.ManageChatFrames();
	
	--[[
	ActionButton_OnLoad = VFL.Noop;
	ActionButton_OnEvent = VFL.Noop;
	ActionButton_Update = VFL.Noop;
	ActionButton_UpdateFlyout = VFL.Noop;	
	
	
	AlternatePowerBar_OnEvent = VFL.Noop;
	TextStatusBar_OnEvent = VFL.Noop;
	
	BonusActionBar_OnLoad = VFL.Noop;
	BonusActionBar_OnEvent = VFL.Noop;
	BonusActionBar_OnUpdate = VFL.Noop;
	
	BossTargetFrame_OnLoad = VFL.Noop;
	
	PossessBar_OnLoad = VFL.Noop;
	PossessBar_OnEvent = VFL.Noop;
	PossessBar_Update = VFL.Noop;
	
	BuffFrame_OnLoad = VFL.Noop;
	BuffFrame_OnEvent = VFL.Noop;
	BuffFrame_OnUpdate = VFL.Noop;
	AuraButton_Update = VFL.Noop;
	AuraButton_OnUpdate = VFL.Noop;
	ConsolidatedBuffs_OnUpdate = VFL.Noop;
	TemporaryEnchantFrame_OnUpdate = VFL.Noop;
	TempEnchantButton_OnLoad = VFL.Noop;
	TempEnchantButton_OnUpdate = VFL.Noop;
	
	CastingBarFrame_OnLoad = VFL.Noop;
	CastingBarFrame_OnEvent = VFL.Noop;
	CastingBarFrame_OnUpdate = VFL.Noop;
	
	ComboFrame_OnEvent = VFL.Noop;
	ComboFrame_Update = VFL.Noop;
	
	FocusFrame_OnLoad = VFL.Noop;
	FocusFrame_OnEvent = VFL.Noop;
	FocusFrame_Update = VFL.Noop;
	FocusFrame_OnUpdate = VFL.Noop;
	FocusFrame_HealthUpdate = VFL.Noop;
	Focus_Spellbar_OnLoad = VFL.Noop;
	Focus_Spellbar_OnEvent = VFL.Noop;
	
	MainMenuBar_OnLoad = VFL.Noop;
	MainMenuBar_OnEvent = VFL.Noop;
	ExhaustionTick_OnLoad = VFL.Noop;
	ExhaustionTick_OnEvent = VFL.Noop;
	MainMenuExpBar_Update = VFL.Noop;
	MainMenuBar_ToPlayerArt = VFL.Noop;
	
	MultiActionBar_Update = VFL.Noop;
	MultiActionBarFrame_OnLoad = VFL.Noop;
	
	ShowPartyFrame = VFL.Noop;
	PartyMemberFrame_OnLoad = VFL.Noop;
	PartyMemberFrame_OnEvent = VFL.Noop;
	PartyMemberFrame_OnUpdate = VFL.Noop;
	PartyMemberFrame_UpdateMember = VFL.Noop;
	
	PartyMemberFrame_UpdatePet = VFL.Noop;
	PetActionButton_OnLoad = VFL.Noop;
	PetActionButton_OnEvent = VFL.Noop;
	PetActionBar_OnLoad = VFL.Noop;
	PetActionBar_OnEvent = VFL.Noop;
	PetActionBarFrame_OnUpdate = VFL.Noop;
	
	PetFrame_OnLoad = VFL.Noop;
	PetFrame_OnEvent = VFL.Noop;
	PetFrame_OnUpdate = VFL.Noop;
	PetCastingBarFrame_OnLoad = VFL.Noop;
	PetCastingBarFrame_OnEvent = VFL.Noop;
	
	PlayerFrame_OnLoad = VFL.Noop;
	PlayerFrame_OnEvent = VFL.Noop;
	PlayerFrame_OnUpdate = VFL.Noop;
	UnitFrameHealthBar_OnValueChanged = VFL.Noop;
	
	RuneButton_OnLoad = VFL.Noop;
	RuneButton_OnUpdate = VFL.Noop;
	RuneFrame_OnLoad = VFL.Noop;
	RuneFrame_OnEvent = VFL.Noop;
	EclipseBar_Update = VFL.Noop;
	
	ShapeshiftBar_OnLoad = VFL.Noop;
	ShapeshiftBar_OnEvent = VFL.Noop;
	ShapeshiftBar_Update = VFL.Noop;
	
	TargetFrame_OnLoad = VFL.Noop;
	TargetFrame_OnEvent = VFL.Noop;
	TargetFrame_OnUpdate = VFL.Noop;
	TargetFrame_HealthUpdate = VFL.Noop;
	
	TextStatusBar_OnEvent = VFL.Noop;
	TextStatusBar_OnValueChanged = VFL.Noop;
	--HealthBar_OnValueChanged = VFL.Noop;
	UnitFrame_OnEvent = VFL.Noop;
	UnitFrame_Update = VFL.Noop;
	UnitFrameHealthBar_OnEvent = VFL.Noop;
	UnitFrameHealthBar_OnUpdate = VFL.Noop;
	UnitFrameHealthBar_OnValueChanged = VFL.Noop;
	UnitFrameManaBar_OnEvent = VFL.Noop;
	UnitFrameManaBar_OnUpdate = VFL.Noop;
	UnitFrameThreatIndicator_OnEvent = VFL.Noop;
	
	UIParent_ManageFramePosition = VFL.Noop;
	
	VehicleMenuBar_OnLoad = VFL.Noop;
	VehicleMenuBar_OnEvent = VFL.Noop;
	VehicleMenuBarPitch_OnLoad = VFL.Noop;
	VehicleMenuBarPitch_OnEvent = VFL.Noop;
	]]
end

-- The folowing feature is used to hide all buttons around the minimap

-- move into design

function RDXDK.DisableChatFrames()
	--FCF_OpenNewWindow = VFL.Noop;
	--FCF_SetWindowName = VFL.Noop;
	--FCF_SetWindowColor
	--FCF_SetWindowAlpha
	
	--FCF_ToggleLock = VFL.Noop;
	
	--FCF_OpenTemporaryWindow = VFL.Noop;
	
	--FCF_OnUpdate = VFL.Noop;
	--FCF_UpdateButtonSide = VFL.Noop;
	
	-- no Tab
	--FCFTab_OnUpdate
	--FCF_Tab_OnClick = VFL.Noop;
	--FCF_SetTabPosition = VFL.Noop;
	--FCFTab_OnDragStop
	
	-- save position disable
	--FCF_SavePositionAndDimensions = VFL.Noop;
	--FCF_RestorePositionAndDimensions = VFL.Noop;
	
	-- disable docking
	--FCF_DockFrame = VFL.Noop;
	--FCF_UnDockFrame = VFL.Noop;
	--FCF_StopDragging = VFL.Noop;
	--FCF_UpdateDockPosition = VFL.Noop;
	-- disable flash
	--FCF_FlashTab = VFL.Noop;
	
	-- disable button Friends
	--FriendsMicroButton:Hide();
	--FriendsMicroButton:UnregisterAllEvents();
	
	-- strange problem fix
	--local tt = ChatEdit_UpdateHeader;
	
	--ChatEdit_UpdateHeader = function(editBox)
	--	local header = _G[editBox:GetName().."Header"];
	--	header:ClearAllPoints();
	--	header:SetPoint("LEFT", editBox, "LEFT", 15, 0);
	--	if header:GetRight() ~= nil and header:GetLeft() ~= nil then
	--		tt(editBox);
	--	end
	--end
	
	RDX.ManageChatFrames();
	
end




------------------------------------------------------
-- Manager
------------------------------------------------------
--[[
local dlg = nil;
function RDXDK.BlizzardManage(parent)
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(230); dlg:SetHeight(300);
	dlg:SetText("Show/Hide Blizzard UI Element");
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("rdx_settings") then RDXPM.RestoreLayout(dlg, "rdx_settings"); end
	
	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(205); sf:SetHeight(240);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Bars")));
	
	local chk_ab = VFLUI.Checkbox:new(ui); chk_ab:Show();
	chk_ab:SetText(VFLI.i18n("Disable Action bars"));
	if opt and opt.ab then chk_ab:SetChecked(true); else chk_ab:SetChecked(); end
	ui:InsertFrame(chk_ab);
	
	local chk_mb = VFLUI.Checkbox:new(ui); chk_mb:Show();
	chk_mb:SetText(VFLI.i18n("Disable Multi bars"));
	if opt and opt.mb then chk_mb:SetChecked(true); else chk_mb:SetChecked(); end
	ui:InsertFrame(chk_mb);
	
	local chk_bb = VFLUI.Checkbox:new(ui); chk_bb:Show();
	chk_bb:SetText(VFLI.i18n("Disable Bonus bar"));
	if opt and opt.bb then chk_bb:SetChecked(true); else chk_bb:SetChecked(); end
	ui:InsertFrame(chk_bb);
	
	local chk_ssb = VFLUI.Checkbox:new(ui); chk_ssb:Show();
	chk_ssb:SetText(VFLI.i18n("Disable Shapeshift bar"));
	if opt and opt.ssb then chk_ssb:SetChecked(true); else chk_ssb:SetChecked(); end
	ui:InsertFrame(chk_ssb);
	
	local chk_pb = VFLUI.Checkbox:new(ui); chk_pb:Show();
	chk_pb:SetText(VFLI.i18n("Disable Possess bar"));
	if opt and opt.pb then chk_pb:SetChecked(true); else chk_pb:SetChecked(); end
	ui:InsertFrame(chk_pb);
	
	local chk_peb = VFLUI.Checkbox:new(ui); chk_peb:Show();
	chk_peb:SetText(VFLI.i18n("Disable Pet bar"));
	if opt and opt.peb then chk_peb:SetChecked(true); else chk_peb:SetChecked(); end
	ui:InsertFrame(chk_peb);
	
	local chk_cb = VFLUI.Checkbox:new(ui); chk_cb:Show();
	chk_cb:SetText(VFLI.i18n("Disable Casting bar"));
	if opt and opt.cb then chk_cb:SetChecked(true); else chk_cb:SetChecked(); end
	ui:InsertFrame(chk_cb);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Buffs")));
	
	local chk_bf = VFLUI.Checkbox:new(ui); chk_bf:Show();
	chk_bf:SetText(VFLI.i18n("Disable Aura frame"));
	if opt and opt.bf then chk_bf:SetChecked(true); else chk_bf:SetChecked(); end
	ui:InsertFrame(chk_bf);
	
	local chk_tef = VFLUI.Checkbox:new(ui); chk_tef:Show();
	chk_tef:SetText(VFLI.i18n("Disable Enchant frame"));
	if opt and opt.tef then chk_tef:SetChecked(true); else chk_tef:SetChecked(); end
	ui:InsertFrame(chk_tef);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("UI Elements")));
	
	local chk_chf = VFLUI.Checkbox:new(ui); chk_chf:Show();
	chk_chf:SetText(VFLI.i18n("Disable Chatframes"));
	if opt and opt.chf then chk_chf:SetChecked(true); else chk_chf:SetChecked(); end
	ui:InsertFrame(chk_chf);
	
	local chk_clf = VFLUI.Checkbox:new(ui); chk_clf:Show();
	chk_clf:SetText(VFLI.i18n("Disable CombatLogs"));
	if opt and opt.clf then chk_clf:SetChecked(true); else chk_clf:SetChecked(); end
	ui:InsertFrame(chk_clf);
	
	local chk_mmb = VFLUI.Checkbox:new(ui); chk_mmb:Show();
	chk_mmb:SetText(VFLI.i18n("Disable Mainmenu Artframe"));
	if opt and opt.mmb then chk_mmb:SetChecked(true); else chk_mmb:SetChecked(); end
	ui:InsertFrame(chk_mmb);
	
	local chk_micb = VFLUI.Checkbox:new(ui); chk_micb:Show();
	chk_micb:SetText(VFLI.i18n("Disable Menu micro buttons"));
	if opt and opt.micb then chk_micb:SetChecked(true); else chk_micb:SetChecked(); end
	ui:InsertFrame(chk_micb);
	
	local chk_mm = VFLUI.Checkbox:new(ui); chk_mm:Show();
	chk_mm:SetText(VFLI.i18n("Disable Minimap"));
	if opt and opt.mm then chk_mm:SetChecked(true); else chk_mm:SetChecked(); end
	ui:InsertFrame(chk_mm);
	
	local chk_buttonmm = VFLUI.Checkbox:new(ui); chk_buttonmm:Show();
	chk_buttonmm:SetText(VFLI.i18n("Hide Minimap Button"));
	if opt and opt.buttonmm then chk_buttonmm:SetChecked(true); else chk_buttonmm:SetChecked(); end
	ui:InsertFrame(chk_buttonmm);
	
	local chk_vmb = VFLUI.Checkbox:new(ui); chk_vmb:Show();
	chk_vmb:SetText(VFLI.i18n("Disable Vehicle Menu bar"));
	if opt and opt.vmb then chk_vmb:SetChecked(true); else chk_vmb:SetChecked(); end
	ui:InsertFrame(chk_vmb);
	
	local chk_uim = VFLUI.Checkbox:new(ui); chk_uim:Show();
	chk_uim:SetText(VFLI.i18n("Disable UI Position Frame"));
	if opt and opt.uim then chk_uim:SetChecked(true); else chk_uim:SetChecked(); end
	ui:InsertFrame(chk_uim);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Unitframes")));
	
	local chk_cuf = VFLUI.Checkbox:new(ui); chk_cuf:Show();
	chk_cuf:SetText(VFLI.i18n("Disable Combo frame"));
	if opt and opt.cuf then chk_cuf:SetChecked(true); else chk_cuf:SetChecked(); end
	ui:InsertFrame(chk_cuf);
	
	local chk_fuf = VFLUI.Checkbox:new(ui); chk_fuf:Show();
	chk_fuf:SetText(VFLI.i18n("Disable Focus frame"));
	if opt and opt.fuf then chk_fuf:SetChecked(true); else chk_fuf:SetChecked(); end
	ui:InsertFrame(chk_fuf);
	
	local chk_puf = VFLUI.Checkbox:new(ui); chk_puf:Show();
	chk_puf:SetText(VFLI.i18n("Disable Party frame"));
	if opt and opt.puf then chk_puf:SetChecked(true); else chk_puf:SetChecked(); end
	ui:InsertFrame(chk_puf);
	
	local chk_raiduf = VFLUI.Checkbox:new(ui); chk_raiduf:Show();
	chk_raiduf:SetText(VFLI.i18n("Disable Raid frame"));
	if opt and opt.raiduf then chk_raiduf:SetChecked(true); else chk_raiduf:SetChecked(); end
	ui:InsertFrame(chk_raiduf);
	
	local chk_peuf = VFLUI.Checkbox:new(ui); chk_peuf:Show();
	chk_peuf:SetText(VFLI.i18n("Disable Pet frame"));
	if opt and opt.peuf then chk_peuf:SetChecked(true); else chk_peuf:SetChecked(); end
	ui:InsertFrame(chk_peuf);
	
	local chk_pluf = VFLUI.Checkbox:new(ui); chk_pluf:Show();
	chk_pluf:SetText(VFLI.i18n("Disable Player frame"));
	if opt and opt.pluf then chk_pluf:SetChecked(true); else chk_pluf:SetChecked(); end
	ui:InsertFrame(chk_pluf);
	
	local chk_ruf = VFLUI.Checkbox:new(ui); chk_ruf:Show();
	chk_ruf:SetText(VFLI.i18n("Disable Rune frame"));
	if opt and opt.ruf then chk_ruf:SetChecked(true); else chk_ruf:SetChecked(); end
	ui:InsertFrame(chk_ruf);
	
	local chk_tuf = VFLUI.Checkbox:new(ui); chk_tuf:Show();
	chk_tuf:SetText(VFLI.i18n("Disable Target frame"));
	if opt and opt.tuf then chk_tuf:SetChecked(true); else chk_tuf:SetChecked(); end
	ui:InsertFrame(chk_tuf);
	
	local chk_bouf = VFLUI.Checkbox:new(ui); chk_bouf:Show();
	chk_bouf:SetText(VFLI.i18n("Disable Boss frame"));
	if opt and opt.bouf then chk_bouf:SetChecked(true); else chk_bouf:SetChecked(); end
	ui:InsertFrame(chk_bouf);
	
	local chk_uuf = VFLUI.Checkbox:new(ui); chk_uuf:Show();
	chk_uuf:SetText(VFLI.i18n("Disable Unitframe engine"));
	if opt and opt.uuf then chk_uuf:SetChecked(true); else chk_uuf:SetChecked(); end
	ui:InsertFrame(chk_uuf);
	
	ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("GameTooltips")));
	
	local chk_toolposition = VFLUI.Checkbox:new(ui); chk_toolposition:Show();
	chk_toolposition:SetText(VFLI.i18n("Enable RDX Tooltip position"));
	if opt and opt.toolposition then chk_toolposition:SetChecked(true); else chk_toolposition:SetChecked(); end
	ui:InsertFrame(chk_toolposition);
	
	local chk_tooltipunit = VFLUI.Checkbox:new(ui); chk_tooltipunit:Show();
	chk_tooltipunit:SetText(VFLI.i18n("Disable Tooltip unit (beta)"));
	if opt and opt.tooltipunit then chk_tooltipunit:SetChecked(true); else chk_tooltipunit:SetChecked(); end
	ui:InsertFrame(chk_tooltipunit);
	
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local btnNone = VFLUI.Button:new(dlg);
	btnNone:SetHeight(25); btnNone:SetWidth(60);
	btnNone:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnNone:SetText(VFLI.i18n("None")); btnNone:Show();
	btnNone:SetScript("OnClick", function()
		chk_ab:SetChecked();
		chk_mb:SetChecked();
		chk_bb:SetChecked();
		chk_ssb:SetChecked();
		chk_pb:SetChecked();
		chk_peb:SetChecked();
		chk_cb:SetChecked();
		chk_bf:SetChecked();
		chk_tef:SetChecked();
		chk_chf:SetChecked();
		chk_clf:SetChecked();
		chk_mmb:SetChecked();
		chk_micb:SetChecked();
		chk_mm:SetChecked();
		chk_buttonmm:SetChecked();
		chk_vmb:SetChecked();
		chk_uim:SetChecked();
		chk_cuf:SetChecked();
		chk_fuf:SetChecked();
		chk_puf:SetChecked();
		chk_raiduf:SetChecked();
		chk_peuf:SetChecked();
		chk_pluf:SetChecked();
		chk_ruf:SetChecked();
		chk_tuf:SetChecked();
		chk_bouf:SetChecked();
		chk_uuf:SetChecked();
		chk_toolposition:SetChecked();
		chk_tooltipunit:SetChecked();
	end);

	local btnAll = VFLUI.Button:new(dlg);
	btnAll:SetHeight(25); btnAll:SetWidth(60);
	btnAll:SetPoint("RIGHT", btnNone, "LEFT");
	btnAll:SetText(VFLI.i18n("All")); btnAll:Show();
	btnAll:SetScript("OnClick", function()
		chk_ab:SetChecked(true);
		chk_mb:SetChecked(true);
		chk_bb:SetChecked(true);
		chk_ssb:SetChecked(true);
		chk_pb:SetChecked(true);
		chk_peb:SetChecked(true);
		chk_cb:SetChecked(true);
		chk_bf:SetChecked(true);
		chk_tef:SetChecked(true);
		chk_chf:SetChecked(true);
		chk_clf:SetChecked(true);
		chk_mmb:SetChecked(true);
		chk_micb:SetChecked(true);
		chk_mm:SetChecked(true);
		chk_buttonmm:SetChecked(true);
		chk_vmb:SetChecked(true);
		chk_uim:SetChecked(true);
		chk_cuf:SetChecked(true);
		chk_fuf:SetChecked(true);
		chk_puf:SetChecked(true);
		chk_raiduf:SetChecked(true);
		chk_peuf:SetChecked(true);
		chk_pluf:SetChecked(true);
		chk_ruf:SetChecked(true);
		chk_tuf:SetChecked(true);
		chk_bouf:SetChecked(true);
		chk_uuf:SetChecked(true);
		chk_toolposition:SetChecked(true);
		chk_tooltipunit:SetChecked(true);
	end);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "rdx_settings");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local function Save()
		opt.ab = chk_ab:GetChecked();
		opt.mb = chk_mb:GetChecked();
		opt.bb = chk_bb:GetChecked();
		opt.ssb = chk_ssb:GetChecked();
		opt.pb = chk_pb:GetChecked();
		opt.peb = chk_peb:GetChecked();
		opt.cb = chk_cb:GetChecked();
		opt.bf = chk_bf:GetChecked();
		opt.tef = chk_tef:GetChecked();
		opt.chf = chk_chf:GetChecked();
		opt.clf = chk_clf:GetChecked();
		opt.mmb = chk_mmb:GetChecked();
		opt.micb = chk_micb:GetChecked();
		opt.mm = chk_mm:GetChecked();
		opt.buttonmm = chk_buttonmm:GetChecked();
		opt.vmb = chk_vmb:GetChecked();
		opt.uim = chk_uim:GetChecked();
		opt.cuf = chk_cuf:GetChecked();
		opt.fuf = chk_fuf:GetChecked();
		opt.puf = chk_puf:GetChecked();
		opt.raiduf = chk_raiduf:GetChecked();
		opt.peuf = chk_peuf:GetChecked();
		opt.pluf = chk_pluf:GetChecked();
		opt.ruf = chk_ruf:GetChecked();
		opt.tuf = chk_tuf:GetChecked();
		opt.bouf = chk_bouf:GetChecked();
		opt.uuf = chk_uuf:GetChecked();
		opt.toolposition = chk_toolposition:GetChecked();
		opt.tooltipunit = chk_tooltipunit:GetChecked();
		ReloadUI();
		VFL.EscapeTo(esch);
	end
	
	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
		btnNone:Destroy(); btnNone = nil;
		btnAll:Destroy(); btnAll = nil;
		s._esch = nil
	end, dlg.Destroy);
end

function RDXDK.CloseBlizzardManage()
	dlg:_esch();
end

function RDXDK.ToggleBlizzardManage()
	if dlg then
		RDXDK.CloseBlizzardManage();
	else
		RDXDK.BlizzardManage(VFLDIALOG);
	end
end

function RDXDK.IsBlizzardManageOpen()
	if dlg then return true; else return nil; end
end

local function disableblizz()
	if opt then
		if opt.ab then RDXDK.DisableActionBar(); end
		if opt.mb then RDXDK.DisableMultiBars(); end
		if opt.bb then RDXDK.DisableBonusBar(); end
		if opt.ssb then RDXDK.DisableShapeshiftBar(); end
		if opt.pb then RDXDK.DisablePossessBar(); end
		if opt.peb then RDXDK.DisablePetActionBar(); end
		if opt.cb then RDXDK.DisableCastingBar(); end
		if opt.bf then RDXDK.DisableBuffFrame(); end
		if opt.tef then RDXDK.DisableTemporaryEnchant(); end
		if opt.chf then RDXDK.DisableChatFrames(); end
		if opt.clf then RDXDK.DisableCombatLogsFrames(); end
		if opt.mmb then RDXDK.DisableMainMenuBar(); end
		if opt.micb then  RDXDK.DisableMicroButton(); end
		if opt.mm then RDXDK.DisableMinimap(); end
		if opt.buttonmm then RDXDK.DisableButtonMinimap(); end
		if opt.vmb then RDXDK.DisableVehicleMenuBar(); end
		if opt.uim then RDXDK.DisableUIManager(); end
		if opt.cuf then RDXDK.DisableComboFrame(); end
		if opt.fuf then RDXDK.DisableFocusFrame(); end
		if opt.puf then RDXDK.DisablePartyMember(); end
		if opt.raiduf then RDXDK.DisableCompactRaidFrameManager(); end
		if opt.peuf then RDXDK.DisablePetFrames(); end
		if opt.pluf then RDXDK.DisablePlayerFrames(); end
		if opt.ruf then RDXDK.DisableRuneFrames(); end
		if opt.tuf then RDXDK.DisableTargetFrames(); end
		if opt.bouf then RDXDK.DisableBoss(); end
		if opt.uuf then RDXDK.DisableUnitframesEngine(); end
	end
end]]

local efdb = nil;

VFLEvents:Bind("PLAYER_COMBAT", nil, function()
	if efdb then
		--disableblizz();
		RDXDK.DisableAll();
		efdb = nil;
	end
end);

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	--[[RDXU.disablebliz = nil;
	if not RDXU.disablebliz2 then 
		RDXU.disablebliz2 = {
			ab = true,
			mb = true,
			bb = true,
			ssb = true,
			pb = true,
			peb = true,
			cb = true,
			bf = true,
			tef = true,
			chf = true,
			clf = true,
			mmb = true,
			micb = true,
			mm = true,
			buttonmm = true,
			vmb = true,
			uim = true,
			cuf = true,
			fuf = true,
			puf = true,
			raiduf = true,
			peuf = true,
			pluf = true,
			ruf = true,
			tuf = true,
			bouf = true,
			uuf = true,
			toolposition = true,
		}; 
	end
	opt = RDXU.disablebliz2;]]
	if not InCombatLockdown() then
		--disableblizz();
		RDXDK.DisableAll();
	else
		efdb = true;
	end
end);