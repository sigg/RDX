-- ClickMenu.lua
-- OpenRDX
-- Taelnia Perenolde US

-- I cleaned up all the repetetive code into this function that can be called from anywhere to add a button to the unitpopup menu
-- When I get time, I'll see about making this add the buttons into a cascading RDX submenu button to clean up the actual in game interface.

local buttonList = {};

RDX.AddPopupButton = function(label, _func)
	local button = {};

	button.text = label;
	button.func = function()
	  local dropdownFrame = UIDropDownMenu_GetCurrentDropDown();
	  local unit = dropdownFrame.unit;
	  local name = dropdownFrame.name;
	  if UnitExists(unit) then
	    name = UnitName(unit);
	  end
	  _func(dropdownFrame, unit, name);
  end;
	button.dist = 0;
	button.notCheckable = true;

	table.insert(buttonList, button);
end

local function _RDX_UnitPopup(dropdownMenu, which, unit, name, userData)
	if(dropdownMenu.which == "RAID" or dropdownMenu.which == "SELF" or dropdownMenu.which == "PLAYER" or dropdownMenu.which == "PARTY") then
		for k, button in pairs(buttonList) do
			UIDropDownMenu_AddButton(button);
		end
	end
end
hooksecurefunc("UnitPopup_ShowMenu", _RDX_UnitPopup);


RDX.AddPopupButton("RDX: Add to Assists", function(frame, unit, name) Logistics.AddAssist(name); end);
RDX.AddPopupButton("RDX: Remove from Assists", function(frame, unit, name) Logistics.DropAssist(name); end);
RDX.AddPopupButton("RDX: Add to Auto-Promote", function(frame, unit, name) Logistics.AddPromote(name); end);
RDX.AddPopupButton("RDX: Remove from Auto-Promote", function(frame, unit, name) Logistics.DropPromote(name); end);
RDX.AddPopupButton("RDX: Character Sheet", function(frame, unit, name) Omni.CS_Ask(name); end);
RDX.AddPopupButton("RDX: Omniscience", function(frame, unit, name) Omni.PredefinedQuery(string.lower(name)); end);
RDX.AddPopupButton("RDX: See Addons", function(frame, unit, name) RDXDB.RAU_SeeAddons_Ask(name); end);

--[[
----------------------------------------
-- GLUE
-- ASSISTS
-- By Taelnia
----------------------------------------
local RDX_PopupButton_AddAssist = { text = "RDX: Add to Assists", dist = 0, func = function() local dropdownFrame = UIDropDownMenu_GetCurrentDropDown(); local unit = dropdownFrame.unit; local name = dropdownFrame.name; if UnitExists(unit) then name = UnitName(unit); end Logistics.AddAssist(name); end, arg1 = "", arg2 = "", notCheckable = true };
local RDX_PopupButton_RemoveAssist = { text = "RDX: Remove from Assists", dist = 0, func = function() local dropdownFrame = UIDropDownMenu_GetCurrentDropDown(); local unit = dropdownFrame.unit; local name = dropdownFrame.name; if UnitExists(unit) then name = UnitName(unit); end Logistics.DropAssist(name); end, arg1 = "", arg2 = "", notCheckable = true };
local function _MA_UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if(dropdownMenu.which == "RAID" or dropdownMenu.which == "SELF" or dropdownMenu.which == "PLAYER" or dropdownMenu.which == "PARTY") then
		UIDropDownMenu_AddButton(RDX_PopupButton_AddAssist);
		UIDropDownMenu_AddButton(RDX_PopupButton_RemoveAssist);
	end
end
hooksecurefunc("UnitPopup_ShowMenu", _MA_UnitPopup_ShowMenu);

-----------------------------
-- RAIDINVITES
-----------------------------
local RDX_PopupButton_AddPromote = { text = "RDX: Add to Auto-Promote", dist = 0, func = function() local dropdownFrame = UIDropDownMenu_GetCurrentDropDown(); local unit = dropdownFrame.unit; local name = dropdownFrame.name; if UnitExists(unit) then name = UnitName(unit); end Logistics.AddPromote(name); end, arg1 = "", arg2 = "", notCheckable = true };
local RDX_PopupButton_RemovePromote = { text = "RDX: Remove from Auto-Promote", dist = 0, func = function() local dropdownFrame = UIDropDownMenu_GetCurrentDropDown(); local unit = dropdownFrame.unit; local name = dropdownFrame.name; if UnitExists(unit) then name = UnitName(unit); end Logistics.DropPromote(name); end, arg1 = "", arg2 = "", notCheckable = true };
local function _promote_UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if(dropdownMenu.which == "RAID" or dropdownMenu.which == "SELF" or dropdownMenu.which == "PLAYER" or dropdownMenu.which == "PARTY") then
		UIDropDownMenu_AddButton(RDX_PopupButton_AddPromote);
		UIDropDownMenu_AddButton(RDX_PopupButton_RemovePromote);
	end
end
hooksecurefunc("UnitPopup_ShowMenu", _promote_UnitPopup_ShowMenu);

-----------------------------
-- CHARACTER SHEET
-----------------------------
local RDX_PopupButton_CharacterSheet = { text = "RDX: Character Sheet", dist = 0, func = function() local dropdownFrame = UIDropDownMenu_GetCurrentDropDown(); local unit = dropdownFrame.unit; local name = dropdownFrame.name; if UnitExists(unit) then name = UnitName(unit); end CS_Ask(name); end , arg1 = "", arg2 = "", notCheckable = true };
local function _CHAR_UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if(dropdownMenu.which == "RAID" or dropdownMenu.which == "SELF" or dropdownMenu.which == "PLAYER" or dropdownMenu.which == "PARTY") then
		UIDropDownMenu_AddButton(RDX_PopupButton_CharacterSheet);
	end
end
hooksecurefunc("UnitPopup_ShowMenu", _CHAR_UnitPopup_ShowMenu);

-----------------------------
-- Omniscience
-----------------------------
local RDX_PopupButton_Omni = { text = "RDX: Omniscience", dist = 0, func = function() local dropdownFrame = UIDropDownMenu_GetCurrentDropDown(); local unit = dropdownFrame.unit; local name = dropdownFrame.name; if UnitExists(unit) then name = UnitName(unit); end name = string.lower(name); Omni.PredefinedQuery(name); end , arg1 = "", arg2 = "", notCheckable = true };
local function _OMNI_UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if(dropdownMenu.which == "RAID" or dropdownMenu.which == "SELF" or dropdownMenu.which == "PLAYER" or dropdownMenu.which == "PARTY") then
		UIDropDownMenu_AddButton(RDX_PopupButton_Omni);
	end
end
hooksecurefunc("UnitPopup_ShowMenu", _OMNI_UnitPopup_ShowMenu);

-----------------------------
-- PackageUpdater
-----------------------------
local RDX_PopupButton_RAUSearchSheet = { text = "RDX: See Addons", dist = 0, func = function() local dropdownFrame = UIDropDownMenu_GetCurrentDropDown(); local unit = dropdownFrame.unit; local name = dropdownFrame.name; if UnitExists(unit) then name = UnitName(unit); end RDXDB.RAU_SeeAddons_Ask(name); end , arg1 = "", arg2 = "", notCheckable = true };
local function _RAUSearch_UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if(dropdownMenu.which == "RAID" or dropdownMenu.which == "SELF" or dropdownMenu.which == "PLAYER" or dropdownMenu.which == "PARTY") then
		UIDropDownMenu_AddButton(RDX_PopupButton_RAUSearchSheet);
	end
end
hooksecurefunc("UnitPopup_ShowMenu", _RAUSearch_UnitPopup_ShowMenu);

]]--