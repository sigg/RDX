-- ActionBarsHandler.lua
-- OpenRDX
-- Sigg Rashgarroth EU

-- WOW 3.0 and Handler

VFLUI.CreateFramePool("SecureHandlerBase", function(pool, frame)
	UnregisterStateDriver(frame, "visibility");
	VFLUI._CleanupLayoutFrame(frame);
end, function()
	local f = CreateFrame("Frame", "SHB" .. VFL.GetNextID(), nil, "SecureHandlerBaseTemplate");
	return f;
end);

VFLUI.CreateFramePool("SecureHandlerAttribute", function(pool, frame)
	UnregisterStateDriver(frame, "visibility");
	UnregisterStateDriver(frame, "page");
	frame:SetAttribute("_onattributechanged", "");
	VFLUI._CleanupLayoutFrame(frame);
end, function()
	local f = CreateFrame("Frame", "SHA" .. VFL.GetNextID(), nil, "SecureHandlerAttributeTemplate");
	return f;
end);

--VFLUI.CreateFramePool("SecureHandlerState", function(pool, frame)
--	VFLUI._CleanupLayoutFrame(frame);
--end, function()
--	local f = CreateFrame("Frame", "SHS" .. VFL.GetNextID(), nil, "SecureHandlerStateTemplate");
--	return f;
--end);

local function convertStatesString(tablestates)
	local str = "";
	for _, v in ipairs(tablestates) do
		str = v.condition .. " " .. v.page ..";";
	end
	return str;
end

local function convertStatesTable(stringstates)
	local statesTable = {};
	local cond, pag;
	local tbl = { strsplit(";", stringstates) };
	for i, v in ipairs(tbl) do
		cond, pag = strmatch(v, "(.*) (.*)");
		if cond then statesTable[i] = {condition = strtrim(cond); page = pag}; end
	end
	return statesTable;
end
__RDXconvertStatesTable = convertStatesTable;

function __RDXGetStates(statestype)
	local str, myunit = "", RDXDAL.GetMyUnit();
	if statestype == "Actionbar" then
		str = "[bar:2] 1; [bar:3] 2; [bar:4] 3; [bar:5] 4; [bar:6] 5; [bonusbar:5] possess;";
	elseif statestype == "Shift" then
		str = "[mod:shift] 9;";
	elseif statestype == "Ctrl" then
		str = "[mod:ctrl] 9;";
	elseif statestype == "Alt" then
		str = "[mod:alt] 9;";
	elseif statestype == "Defaultui" then
		str = "[bar:2] 1; [bar:3] 2; [bar:4] 3; [bar:5] 4; [bar:6] 5; [bonusbar:5] possess;";
		local class = myunit:GetClassMnemonic();
		if class == "PRIEST" then str = str .. " [bonusbar:1] 6;";
		elseif class == "ROGUE" then str = str .. " [bonusbar:1] 6; [bonusbar:2] 6;";
		elseif class == "DRUID" then str = str .. " [bonusbar:1,stealth] 5; [bonusbar:1] 6; [bonusbar:2] 7; [bonusbar:3] 8; [bonusbar:4] 9;";
		elseif class == "WARRIOR" then str = str .. " [bonusbar:1] 6; [bonusbar:2] 7; [bonusbar:3] 8;";
		end
	elseif statestype == "Stance" then
		local class = myunit:GetClassMnemonic();
		if class == "PRIEST" then str = str .. " [bonusbar:1] 6;";
		elseif class == "ROGUE" then str = str .. " [bonusbar:1] 6; [bonusbar:2] 6;";
		elseif class == "DRUID" then str = str .. " [bonusbar:1,stealth] 5; [bonusbar:1] 6; [bonusbar:2] 7; [bonusbar:3] 8; [bonusbar:4] 9;";
		elseif class == "WARRIOR" then str = str .. " [bonusbar:1] 6; [bonusbar:2] 7; [bonusbar:3] 8;";
		end
	end
	return str;
end

function __RDXGetVisi(visitype)
	local str = "";
	if visitype == "InCombat" then
		str = "[combat] show; hide;";
	elseif visitype == "InStealth" then
		str = "[stealth, harm] show; hide";
	elseif visitype == "InForm3" then
		str = "[form:3] show; hide";
	end
	return str;
end

local _visi = {
	{ text = "None"},
	{ text = "Pet"},
	{ text = "PetInCombat"},
	{ text = "Vehicle"},
	{ text = "VehicleInCombat"},
	{ text = "InCombat"},
	{ text = "Custom"},
};
function __RDX_dd_visi() return _visi; end

function __RDXGetOtherVisi(visitype)
	local str = "";
	if visitype == "Pet" then
		str = "[target=pet,exists] show; hide;";
	elseif visitype == "PetInCombat" then
		str = "[combat] show; hide; [target=pet,exists] show; hide;";
	elseif visitype == "Vehicle" then
		str = "[target=vehicle,exists] show; hide;";
	elseif visitype == "VehicleInCombat" then
		str = "[combat] show; hide; [target=vehicle,exists] show; hide;";
	elseif visitype == "InCombat" then
		str = "[combat] show; hide;";
	end
	return str;
end

-- GLOBAL FUNCTION

function __RDXCreateHeaderHandlerAttribute(statesString, visString)
	local h = VFLUI.AcquireFrame("SecureHandlerAttribute");
	if not InCombatLockdown() then
		if statesString then
			h:SetAttribute('_onattributechanged', [[ 
				if name == 'state-page' then
					--print("new state " .. value);
					newpage = value;
					control:ChildUpdate();
				end 
			]] );
			--RegisterStateDriver(h, 'page', '[bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6; [bonusbar:1] 6; [mod:ctrl] 6; 1');
			RegisterStateDriver(h, "page", statesString .. " " .. 0);
		end
		if visString then
			RegisterStateDriver(h, "visibility", visString);
		end
	end
	return h;
end

-- add many action state to the button
function __RDXModifyActionButtonState(btn, statesString, nbuttons, id)
	btn:SetAttribute("action--" .. 0, id);
	local statesTable = convertStatesTable(statesString);
	for _, v in ipairs (statesTable) do
		local page = v.page;
		--if page == "possess" then page = 10; end
		if page == "possess" and id < 13 then
			btn:SetAttribute('action--' .. v.page, id + 120);
		elseif page ~= "possess" then
			btn:SetAttribute('action--' .. v.page, id + (nbuttons * page));
		end
	end
	btn:SetAttribute("_childupdate", [[
		--print("child " .. newpage);
		self:SetAttribute('action', self:GetAttribute('action--' .. newpage) or self:GetAttribute('action--' .. 0));
	]]);
end

-- find the current active page in case of closing/openning window
function __RDXGetCurrentButtonId(statesString, nbuttons, id)
	local statesTable = convertStatesTable(statesString);
	local currentPage, barPage, offsetPage = 0, GetActionBarPage(), GetBonusBarOffset();
	for _,v in ipairs(statesTable) do
		if v.condition == "[bar:" .. barPage .. "]" then currentPage = v.page; end
		if currentPage == "possess" then currentPage = 10; end
	end
	if (offsetPage > 0) and (barPage == 1) then
		for _,v in ipairs(statesTable) do
			if v.condition == "[bonusbar:" .. offsetPage .. "]" then currentPage = v.page; end
			if currentPage == "possess" then currentPage = 10; end
		end
	end
	return id + (nbuttons * currentPage);
end

-- pet/other handler

function __RDXCreateHeaderHandlerBase(visString)
	local h = VFLUI.AcquireFrame("SecureHandlerBase");
	RegisterStateDriver(h, "visibility", visString)
	return h;
end

