-- OpenRDX
-- Sigg Rashgarroth

local opt = nil;

local disabledframes = {
	"ActionBarController",
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
	--"BonusActionButton1",
	--"BonusActionButton2",
	--"BonusActionButton3",
	--"BonusActionButton4",
	--"BonusActionButton5",
	--"BonusActionButton6",
	--"BonusActionButton7",
	--"BonusActionButton8",
	--"BonusActionButton9",
	--"BonusActionButton10",
	--"BonusActionButton11",
	--"BonusActionButton12",
	--"BonusActionBarFrame",
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
	--"PartyMemberFrame1PhasingIcon",
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
	--"PartyMemberFrame2PhasingIcon",
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
	--"PartyMemberFrame3PhasingIcon",
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
	--"PartyMemberFrame4PhasingIcon",
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
	"StanceButton1",
	"StanceButton2",
	"StanceButton3",
	"StanceButton4",
	"StanceButton5",
	"StanceButton6",
	"StanceButton7",
	"StanceButton8",
	"StanceButton9",
	"StanceButton10",
	"StanceBarFrame",
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
	--"VehicleMenuBarActionButton1",
	--"VehicleMenuBarActionButton2",
	--"VehicleMenuBarActionButton3",
	--"VehicleMenuBarActionButton4",
	--"VehicleMenuBarActionButton5",
	--"VehicleMenuBarActionButton6",
	--"VehicleMenuBarHealthBar",    
	--"VehicleMenuBarPowerBar",
	--"VehicleMenuBar",
	--"ReputationFrame",
	"ReputationWatchBar",
};

local function DisableAll()
	local f;

	for i,v in ipairs(disabledframes) do
		f = _G[v];
		if f then
			f:UnregisterAllEvents();
			f:SetScript("OnUpdate", nil);
			f:SetScript("OnHide", nil);
			f:SetScript("OnShow", f.Hide);
			f:Hide();
		else
			VFL.print("BD:This object do not exist " .. v);
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
	MainMenuBar_ToPlayerArt = VFL.Noop;
	
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
	
	-- TO BE TESTED
	--FCF_OnUpdate = VFL.Noop;
	--GeneralDockManager:Hide();
	--GeneralDockManager:UnregisterAllEvents();
	--GeneralDockManager:SetScript("OnUpdate", nil);
	--GeneralDockManagerOverflowButton:Hide();
	--GeneralDockManagerOverflowButton:UnregisterAllEvents();
	

	ChatFrame1:Hide();
	ChatFrame1:SetScript("OnShow", ChatFrame1.Hide);
	ChatFrame1:SetScript("OnUpdate", nil);
	ChatFrame1Tab:Hide();
	ChatFrame1Tab:SetScript("OnShow", ChatFrame1Tab.Hide);
	ChatFrame1:UnregisterAllEvents();
	FriendsMicroButton:Hide();
	FriendsMicroButton:UnregisterAllEvents();
	ChatFrameMenuButton:Hide();
	ChatFrameMenuButton:UnregisterAllEvents();
	ChatFrameMenuButton:SetScript("OnShow", ChatFrameMenuButton.Hide);
	FCF_StartAlertFlash = VFL.Noop;
	
	
	VFLP.RegisterFrame("Blizzard", "GeneralDockManager", GeneralDockManager, true);
	VFLP.RegisterFrame("Blizzard", "ChatFrame1", ChatFrame1, true);
	VFLP.RegisterFrame("Blizzard", "ChatFrame2", ChatFrame2, true);
	VFLP.RegisterFrame("Blizzard", "FriendsMicroButton", FriendsMicroButton, true);
	VFLP.RegisterFrame("Blizzard", "ChatFrameMenuButton", ChatFrameMenuButton, true);
	
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
	StanceBarFrame.ignoreFramePositionManager = true;
	PossessBarFrame.ignoreFramePositionManager = true;
	MultiCastActionBarFrame.ignoreFramePositionManager = true;
	MainMenuBarMaxLevelBar.ignoreFramePositionManager = true;
	ReputationWatchBar.ignoreFramePositionManager = true;
	MainMenuBarMaxLevelBar.ignoreFramePositionManager = true;
	
	ReputationWatchBar_Update = VFL.Noop;
	
	-- hack
	--SetCVar("chatStyle", "classic");
	SetCVar("showTutorials", 0);
	SetCVar("chatStyle", "im");
	--chatMouseScroll
	--conversationMode popout popout_and_inline inline
	--whisperMode popout popout_and_inline inline
	--wholeChatWindowClickable
	--SHOW_MULTI_ACTIONBAR_1 = nil;
	--SHOW_MULTI_ACTIONBAR_2 = nil;
	--SHOW_MULTI_ACTIONBAR_3 = nil;
	--SHOW_MULTI_ACTIONBAR_4 = nil;
	--
	--MultiActionBar_Update();
	
	_G["SHOW_MULTI_ACTIONBAR_1"] = nil;
	_G["SHOW_MULTI_ACTIONBAR_2"] = nil;
	_G["SHOW_MULTI_ACTIONBAR_3"] = nil;
	_G["SHOW_MULTI_ACTIONBAR_4"] = nil;
	SetActionBarToggles(nil, nil, nil, nil, nil);
	
	--displayFreeBagSlots
	
	--rotateMinimap
	
	--editBox.isGM
	--/script VFL.print(GetCVar("whisperMode"));
	
end

local efdb = nil;

VFLEvents:Bind("PLAYER_COMBAT", nil, function()
	if efdb then
		DisableAll();
		efdb = nil;
	end
end);

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	if not InCombatLockdown() then
		DisableAll();
	else
		efdb = true;
	end
end);