-- OpenRDX
-- Sigg Rashgarroth

local opt = nil;

local function DisableAll()
	local f;
	
	-- enable chatframe
	if not opt.ec then
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
	
		-- analyse CPU usage of chatframes
		--VFLP.RegisterFrame("Blizzard", "GeneralDockManager", GeneralDockManager, true);
		--VFLP.RegisterFrame("Blizzard", "ChatFrame1", ChatFrame1, true);
		--VFLP.RegisterFrame("Blizzard", "ChatFrame2", ChatFrame2, true);
		--VFLP.RegisterFrame("Blizzard", "FriendsMicroButton", FriendsMicroButton, true);
		--VFLP.RegisterFrame("Blizzard", "ChatFrameMenuButton", ChatFrameMenuButton, true);
		
		-- combatlogs
		Blizzard_CombatLog_Update_QuickButtons = VFL.Noop;
		CombatLog_OnEvent = VFL.Noop;
		ChatFrame2:Hide();
		ChatFrame2:SetScript("OnShow", ChatFrame2.Hide);
		ChatFrame2Tab:Hide();
		ChatFrame2Tab:SetScript("OnShow", ChatFrame2Tab.Hide);
		
		ChatFrame1.ignoreFramePositionManager = true;
		ChatFrame2.ignoreFramePositionManager = true;
		
		SetCVar("chatStyle", "im");
	end
	
	-- enable actionbars
	if not opt.ea then
		local frames = {
			-- ActionbarController.xml
			--"ActionBarController",
			-- ActionBarFrame.xml
			---"ActionBarButtonEventsFrame",  -- TODO TES
			---"ActionBarActionEventsFrame",
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
			"ActionBarUpButton",
			"ActionBarDownButton",
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
			-- ??
			"PossessButton1",
			"PossessButton2",
			"PossessBarFrame",
			
			"MainMenuExpBar",
			"ExhaustionTick",
			"MainMenuBarMaxLevelBar",
			---"MainMenuBar", --bug extrabar
			
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
			
			"OverrideActionBarButton1",
			"OverrideActionBarButton2",
			"OverrideActionBarButton3",
			"OverrideActionBarButton4",
			"OverrideActionBarButton5",
			"OverrideActionBarButton6",
			
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
		};
		
		for i,v in ipairs(frames) do
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
		
		-- ActionBarController
		--[[
		ActionBarController:UnregisterEvent("PLAYER_ENTERING_WORLD");
		ActionBarController:UnregisterEvent("ACTIONBAR_PAGE_CHANGED");
		ActionBarController:UnregisterEvent("UPDATE_BONUS_ACTIONBAR");
		ActionBarController:UnregisterEvent("UNIT_DISPLAYPOWER");
		ActionBarController:UnregisterEvent("UPDATE_VEHICLE_ACTIONBAR");
		ActionBarController:UnregisterEvent("UPDATE_OVERRIDE_ACTIONBAR");
		ActionBarController:UnregisterEvent("UPDATE_SHAPESHIFT_FORM");
		ActionBarController:UnregisterEvent("UPDATE_SHAPESHIFT_FORMS");
		ActionBarController:UnregisterEvent("UPDATE_SHAPESHIFT_USABLE");
		ActionBarController:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
		ActionBarController:UnregisterEvent("UPDATE_POSSESS_BAR");]]
		
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
		MoveMicroButtons = VFL.Noop;
		
		MainMenuBar:UnregisterEvent("BAG_UPDATE");
		MainMenuBar:UnregisterEvent("ACTIONBAR_PAGE_CHANGED");
		--MainMenuBar:UnregisterEvent("CURRENCY_DISPLAY_UPDATE");
		MainMenuBar:UnregisterEvent("ADDON_LOADED");
		--MainMenuBar:UnregisterEvent("UNIT_LEVEL");
		ActionBarController_UpdateAll = VFL.Noop;
		UpdateMicroButtonsParent = VFL.Noop;
		MoveMicroButtons = VFL.Noop;
		StanceBar_Update = VFL.Noop;
		MainMenuBarVehicleLeaveButton_OnEvent = VFL.Noop;
		MainMenuBar:EnableMouse(false);
		
		TalentMicroButton:UnregisterEvent("PLAYER_TALENT_UPDATE");
		
		MainMenuBarBackpackButton_UpdateFreeSlots = VFL.Noop;
		
		MainMenuBarMaxLevelBar.ignoreFramePositionManager = true;
		MultiBarBottomLeft.ignoreFramePositionManager = true;
		MultiBarRight.ignoreFramePositionManager = true;
		StanceBarFrame.ignoreFramePositionManager = true;
		PossessBarFrame.ignoreFramePositionManager = true;
		MultiCastActionBarFrame.ignoreFramePositionManager = true;
		ExtraActionBarFrame.ignoreFramePositionManager = true;
		PlayerPowerBarAlt.ignoreFramePositionManager = true;
		
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
		
		
		local tblink = {};
		tblink["ACTIONBUTTON1"] = "VFLButton1";
		tblink["ACTIONBUTTON2"] = "VFLButton2";
		tblink["ACTIONBUTTON3"] = "VFLButton3";
		tblink["ACTIONBUTTON4"] = "VFLButton4";
		tblink["ACTIONBUTTON5"] = "VFLButton5";
		tblink["ACTIONBUTTON6"] = "VFLButton6";
		tblink["ACTIONBUTTON7"] = "VFLButton7";
		tblink["ACTIONBUTTON8"] = "VFLButton8";
		tblink["ACTIONBUTTON9"] = "VFLButton9";
		tblink["ACTIONBUTTON10"] = "VFLButton10";
		tblink["ACTIONBUTTON11"] = "VFLButton11";
		tblink["ACTIONBUTTON12"] = "VFLButton12";
		tblink["BONUSACTIONBUTTON1"] = "VFLButton13";
		tblink["BONUSACTIONBUTTON2"] = "VFLButton14";
		tblink["BONUSACTIONBUTTON3"] = "VFLButton15";
		tblink["BONUSACTIONBUTTON4"] = "VFLButton16";
		tblink["BONUSACTIONBUTTON5"] = "VFLButton17";
		tblink["BONUSACTIONBUTTON6"] = "VFLButton18";
		tblink["BONUSACTIONBUTTON7"] = "VFLButton19";
		tblink["BONUSACTIONBUTTON8"] = "VFLButton20";
		tblink["BONUSACTIONBUTTON9"] = "VFLButton21";
		tblink["BONUSACTIONBUTTON10"] = "VFLButton22";
		tblink["BONUSACTIONBUTTON11"] = "VFLButton23";
		tblink["BONUSACTIONBUTTON12"] = "VFLButton24";
		tblink["MULTIACTIONBAR4BUTTON1"] = "VFLButton25";
		tblink["MULTIACTIONBAR4BUTTON2"] = "VFLButton26";
		tblink["MULTIACTIONBAR4BUTTON3"] = "VFLButton27";
		tblink["MULTIACTIONBAR4BUTTON4"] = "VFLButton28";
		tblink["MULTIACTIONBAR4BUTTON5"] = "VFLButton29";
		tblink["MULTIACTIONBAR4BUTTON6"] = "VFLButton30";
		tblink["MULTIACTIONBAR4BUTTON7"] = "VFLButton31";
		tblink["MULTIACTIONBAR4BUTTON8"] = "VFLButton32";
		tblink["MULTIACTIONBAR4BUTTON9"] = "VFLButton33";
		tblink["MULTIACTIONBAR4BUTTON10"] = "VFLButton34";
		tblink["MULTIACTIONBAR4BUTTON11"] = "VFLButton35";
		tblink["MULTIACTIONBAR4BUTTON12"] = "VFLButton36";
		tblink["MULTIACTIONBAR3BUTTON1"] = "VFLButton37";
		tblink["MULTIACTIONBAR3BUTTON2"] = "VFLButton38";
		tblink["MULTIACTIONBAR3BUTTON3"] = "VFLButton39";
		tblink["MULTIACTIONBAR3BUTTON4"] = "VFLButton40";
		tblink["MULTIACTIONBAR3BUTTON5"] = "VFLButton41";
		tblink["MULTIACTIONBAR3BUTTON6"] = "VFLButton42";
		tblink["MULTIACTIONBAR3BUTTON7"] = "VFLButton43";
		tblink["MULTIACTIONBAR3BUTTON8"] = "VFLButton44";
		tblink["MULTIACTIONBAR3BUTTON9"] = "VFLButton45";
		tblink["MULTIACTIONBAR3BUTTON10"] = "VFLButton46";
		tblink["MULTIACTIONBAR3BUTTON11"] = "VFLButton47";
		tblink["MULTIACTIONBAR3BUTTON12"] = "VFLButton48";
		tblink["MULTIACTIONBAR1BUTTON1"] = "VFLButton49";
		tblink["MULTIACTIONBAR1BUTTON2"] = "VFLButton50";
		tblink["MULTIACTIONBAR1BUTTON3"] = "VFLButton51";
		tblink["MULTIACTIONBAR1BUTTON4"] = "VFLButton52";
		tblink["MULTIACTIONBAR1BUTTON5"] = "VFLButton53";
		tblink["MULTIACTIONBAR1BUTTON6"] = "VFLButton54";
		tblink["MULTIACTIONBAR1BUTTON7"] = "VFLButton55";
		tblink["MULTIACTIONBAR1BUTTON8"] = "VFLButton56";
		tblink["MULTIACTIONBAR1BUTTON9"] = "VFLButton57";
		tblink["MULTIACTIONBAR1BUTTON10"] = "VFLButton58";
		tblink["MULTIACTIONBAR1BUTTON11"] = "VFLButton59";
		tblink["MULTIACTIONBAR1BUTTON12"] = "VFLButton60";
		tblink["MULTIACTIONBAR2BUTTON1"] = "VFLButton61";
		tblink["MULTIACTIONBAR2BUTTON2"] = "VFLButton62";
		tblink["MULTIACTIONBAR2BUTTON3"] = "VFLButton63";
		tblink["MULTIACTIONBAR2BUTTON4"] = "VFLButton64";
		tblink["MULTIACTIONBAR2BUTTON5"] = "VFLButton65";
		tblink["MULTIACTIONBAR2BUTTON6"] = "VFLButton66";
		tblink["MULTIACTIONBAR2BUTTON7"] = "VFLButton67";
		tblink["MULTIACTIONBAR2BUTTON8"] = "VFLButton68";
		tblink["MULTIACTIONBAR2BUTTON9"] = "VFLButton69";
		tblink["MULTIACTIONBAR2BUTTON10"] = "VFLButton70";
		tblink["MULTIACTIONBAR2BUTTON11"] = "VFLButton71";
		tblink["MULTIACTIONBAR2BUTTON12"] = "VFLButton72";
		tblink["SHAPESHIFTBUTTON1"] = "VFLStanceButton1";
		tblink["SHAPESHIFTBUTTON2"] = "VFLStanceButton2";
		tblink["SHAPESHIFTBUTTON3"] = "VFLStanceButton3";
		tblink["SHAPESHIFTBUTTON4"] = "VFLStanceButton4";
		tblink["SHAPESHIFTBUTTON5"] = "VFLStanceButton5";
		tblink["SHAPESHIFTBUTTON6"] = "VFLStanceButton6";
		tblink["SHAPESHIFTBUTTON7"] = "VFLStanceButton7";
		tblink["SHAPESHIFTBUTTON8"] = "VFLStanceButton8";
		tblink["SHAPESHIFTBUTTON9"] = "VFLStanceButton9";
		tblink["SHAPESHIFTBUTTON10"] = "VFLStanceButton10";

		-- call this function to move key from Blizzard to VFL at init
		local function Init()
			-- test the key of the ActionBUTTON 1
			if not InCombatLockdown() and RDXDK.GetCurrentDesktop() then
				local keyflag = GetBindingKey("ACTIONBUTTON1");
				if keyflag then
					local key1, key2;
					for k,v in pairs(tblink) do
						if _G[v] then
							key1, key2 = GetBindingKey(k);
							if key2 then SetBinding(key2); end
							if key1 then SetBinding(key1); SetBindingClick(key1, v); end
						end
					end
					--if GetCurrentBindingSet() then
						SaveBindings(GetCurrentBindingSet());
					--end
					DesktopEvents:Dispatch("DESKTOP_UPDATE_BINDINGS");
				end
			end
		end

		RDXEvents:Bind("INIT_POST", nil, Init);
		
	end
	
	if not opt.eb then
	
		local disabledminimaps = {
			"MinimapCluster",
		};
		for i,v in ipairs(disabledminimaps) do
			f = _G[v];
			if f then
				f:UnregisterAllEvents();
				f:SetScript("OnUpdate", nil);
				f:SetScript("OnHide", nil);
				f:SetScript("OnShow", f.Hide);
				f:Hide();
			end
		end
	
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
	end
	
	local disabledframes = {
		-- AlternatePowerBar.xml
		"PlayerFrameAlternateManaBar",
		-- Bufframe.xml
		"BuffFrame",
		"ConsolidatedBuffs",
		"ConsolidatedBuffsTooltip",
		"TemporaryEnchantFrame",
		"TempEnchant1",
		"TempEnchant2",
		"TempEnchant3",
		-- CastingBarFrame.xml
		"CastingBarFrame",
		-- ComboFrame.xml
		"ComboPoint1",
		"ComboPoint2",
		"ComboPoint3",
		"ComboPoint4",
		"ComboPoint5",
		"ComboFrame",
		-- EclipseBarframe.xml
		"EclipseBarFrame",
		-- FocusFrame.xml
		--"FocusFrameDebuff1",
		--"FocusFrameDebuff2",
		--"FocusFrameDebuff3",
		--"FocusFrameDebuff4",
		--"FocusFrameDebuff5",
		--"FocusFrameDebuff6",
		--"FocusFrameDebuff7",
		--"FocusFrameDebuff8",
		"FocusFrameNumericalThreat",
		"FocusFrameSpellBar",
		"FocusFrameManaBar",
		"FocusFrameHealthBar",
		--"FocusFrameTextureFrameFullSize",
		--"FocusFrameTextureFrameSmall",
		"FocusFrameTextureFrame",
		"FocusFrame",
		-- to be tested
		--"TargetofFocusFrameDebuff1",
		--"TargetofFocusFrameDebuff2",
		--"TargetofFocusFrameDebuff3",
		--"TargetofFocusFrameDebuff4",
		--"TargetofFocusManaBar",
		--"TargetofFocusHealthBar",
		--"TargetofFocusTextureFrame",
		--"TargetofFocusFrame",
		
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
	
	RaidOptionsFrame_UpdatePartyFrames = VFL.Noop;
	
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
	
	CastingBarFrame.ignoreFramePositionManager = true;    
	PlayerPowerBarAlt.ignoreFramePositionManager = true;
	
	ReputationWatchBar.ignoreFramePositionManager = true;
	
	ReputationWatchBar_Update = VFL.Noop;
	
	-- hack
	--SetCVar("chatStyle", "classic");
	SetCVar("showTutorials", 0);
	
	--chatMouseScroll
	--conversationMode popout popout_and_inline inline
	--whisperMode popout popout_and_inline inline
	--wholeChatWindowClickable
	
	
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
	opt = RDXG.RDXopt;
	if not InCombatLockdown() then
		DisableAll();
	else
		efdb = true;
	end
end);