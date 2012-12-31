-- Textures.lua
-- OpenRDX
--
-- Textures for application on unitframes.

local IndicatorIndex = {};
local Indicators = {};

function RDX.RegisterTextureIndicator(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if Indicators[tbl.name] then RDX.printW("Attempt to register duplicate Indicator Type " .. tbl.name); return; end
	Indicators[tbl.name] = tbl;
	table.insert(IndicatorIndex, {value = tbl.name, text = tbl.title});
end

RDX.RegisterTextureIndicator({
	name = "Blue";
	title = VFLI.i18n("Blue");
	emitClosureCode = [[
local rdxset_blue = RDXDAL.FindSet({class = "file", file = "sets:set_blue"});
if not rdxset_blue:IsOpen() then rdxset_blue:Open(); end
]];
	createCode = [[
	btn._t:SetTexture(0,0,1,1);
]];
	paintCodeTest = [[
		if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
		if rdxset_blue:IsMember(unit) then
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	set = {class = "file", file = "sets:set_blue"};
});

RDX.RegisterTextureIndicator({
	name = "Red";
	title = VFLI.i18n("Red");
	emitClosureCode = [[
local rdxset_red = RDXDAL.FindSet({class = "file", file = "sets:set_red"});
if not rdxset_red:IsOpen() then rdxset_red:Open(); end
]];
	createCode = [[
	btn._t:SetTexture(1,0,0,1);
]];
	paintCodeTest = [[
		if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
		if rdxset_red:IsMember(unit) then
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	set = {class = "file", file = "sets:set_red"};
});

RDX.RegisterTextureIndicator({
	name = "Green";
	title = VFLI.i18n("Green");
	emitClosureCode = [[
local rdxset_green = RDXDAL.FindSet({class = "file", file = "sets:set_green"});
if not rdxset_green:IsOpen() then rdxset_green:Open(); end
]];
	createCode = [[
	btn._t:SetTexture(0,1,0,1);
]];
	paintCodeTest = [[
		if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
		if rdxset_green:IsMember(unit) then
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	set = {class = "file", file = "sets:set_green"};
});

RDX.RegisterTextureIndicator({
	name = "Yellow";
	title = VFLI.i18n("Yellow");
	emitClosureCode = [[
local rdxset_yellow = RDXDAL.FindSet({class = "file", file = "sets:set_yellow"});
if not rdxset_yellow:IsOpen() then rdxset_yellow:Open(); end
]];
	createCode = [[
	btn._t:SetTexture(1,1,0,1);
]];
	paintCodeTest = [[
		if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
		if rdxset_green:IsMember(unit) then
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	set = {class = "file", file = "sets:set_yellow"};
});

---------------------------------------------------------------

local IconsIndex = {};
local Icons = {};

function RDX.RegisterTextureIcon(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if Icons[tbl.name] then RDX.printW("Attempt to register duplicate Icon Type " .. tbl.name); return; end
	Icons[tbl.name] = tbl;
	table.insert(IconsIndex, {value = tbl.name, text = tbl.title});
end

RDX.RegisterTextureIcon({
	name = "Player Status";
	title = VFLI.i18n("Player Status");
	createCode = [[
	btn._t:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
]];
	paintCodeTest = [[
		btn._t:SetTexCoord(0, 0.5, 0, 0.421875);
		btn:Show();
]];
	paintCode = [[
		_name = UnitName(uid);
		myunit = RDXDAL.GetMyUnit();
		if UnitAffectingCombat(uid) or ((myunit.rosterName == _name) and IsResting()) then
			btn._t:SetTexCoord(0, 0.5, 0, 0.421875);
			if UnitAffectingCombat(uid) then btn._t:SetTexCoord(0.5, 1, 0, 0.49); end
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "PLAYER_UPDATE_RESTING";
});

RDX.RegisterFeature({
	name = "Player Status Icon"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Player Status";
	end;
});


RDX.RegisterTextureIcon({
	name = "Class Round";
	title = VFLI.i18n("Class Round");
	createCode = [[
	btn._t:SetTexture("Interface\\AddOns\\RDX\\Skin\\icon_class");
]];
	paintCodeTest = [[
		if UnitIsPlayer(uid) then
			tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
			btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	paintCode = [[
		if UnitIsPlayer(uid) then
			tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
			btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "UNIT_FLAGS";
});

RDX.RegisterTextureIcon({
	name = "Class";
	title = VFLI.i18n("Class");
	createCode = [[
	btn._t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
]];
	paintCodeTest = [[
		if UnitIsPlayer(uid) then
			tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
			btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	paintCode = [[
		if UnitIsPlayer(uid) then
			tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
			btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "UNIT_FLAGS";
});

RDX.RegisterFeature({
	name = "tex_class"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Class";
		desc.iconflag = nil;
	end;
});


RDX.RegisterTextureIcon({
	name = "Master Looter";
	title = VFLI.i18n("Master Looter");
	createCode = [[
	btn._t:SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter");
]];
	paintCodeTest = [[
		if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
		_name, _meta = nil, nil;
		_, _tl, _et = GetLootMethod();
		if _et then
			if unit.rosterName then
				_name = unit.rosterName;
			else
				_name = UnitName(uid);
			end
			if (_name == GetUnitByNumber(_et).rosterName) then
				if not btn:IsShown() then btn:Show(); end
			else
				if btn:IsShown() then btn:Hide(); end
			end
		elseif _tl then
			_name = UnitName(uid);
			_meta = UnitName("party" .. _tl);
			myunit = RDXDAL.GetMyUnit();
			if (_tl == 0) and (myunit.rosterName == _name) then
				if not btn:IsShown() then btn:Show(); end
			elseif (_name == _meta) then
				if not btn:IsShown() then btn:Show(); end
			else
				if btn:IsShown() then btn:Hide(); end
			end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "UNIT_FLAGS";
});


RDX.RegisterFeature({
	name = "Master Looter Icon"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Master Looter";
	end;
});

RDX.RegisterTextureIcon({
	name = "Faction";
	title = VFLI.i18n("Faction");
	createCode = [[]];
	paintCodeTest = [[]];
	paintCode = [[
		_apps, _meta = nil, nil;
		if UnitIsPVPFreeForAll(uid) then 
			_apps = "FFA";
		else
			_meta = UnitFactionGroup(uid);
			if _meta then _apps = _meta; end
		end
		if _apps then
			tempcolor = RDXMD.GetPVPIcon(_apps);
			btn._t:SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. _apps);
			btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "UNIT_FACTION";
});

RDX.RegisterFeature({
	name = "tex_pvp"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Faction";
	end;
});

RDX.RegisterTextureIcon({
	name = "Role";
	title = VFLI.i18n("Role");
	createCode = [[
	btn._t:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES");
]];
	paintCodeTest = [[
		btn._t:SetTexCoord(20/64, 39/64, 1/64, 20/64);
		btn:Show();
]];
	paintCode = [[
		_meta = UnitGroupRolesAssigned(uid);
		if _meta == "TANK" then
			btn._t:SetTexCoord(0, 19/64, 22/64, 41/64);
			if not btn:IsShown() then btn:Show(); end
		elseif _meta == "HEALER" then
			btn._t:SetTexCoord(20/64, 39/64, 1/64, 20/64);
			if not btn:IsShown() then btn:Show(); end
		elseif _meta == "DAMAGER" then
			btn._t:SetTexCoord(20/64, 39/64, 22/64, 41/64);
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "PARTY_MEMBERS_CHANGED";
});

RDX.RegisterFeature({
	name = "tex_role"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Role";
	end;
});

-- OpenRDX
-- Sigg / Rashgarroth EU
-- by Aichi

RDX.RegisterTextureIcon({
	name = "Ready Check";
	title = VFLI.i18n("Ready Check");
	createCode = [[
	btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Waiting");
]];
	paintCodeTest = [[
		btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
		btn:Show();
]];
	paintCode = [[
		_meta = nil;
		myunit = RDXDAL.GetMyUnit();
		if UnitIsGroupLeader(myunit.uid) or UnitIsRaidOfficer(myunit.uid) then
			_meta = GetReadyCheckStatus(uid);
		end
		if _meta then
			if ( _meta == "ready" ) then
				btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
				if not btn:IsShown() then btn:Show(); end
			elseif ( _meta == "notready" ) then
				btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady");
				if not btn:IsShown() then btn:Show(); end
			elseif ( _meta == "waiting" ) then
				btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Waiting");
				if not btn:IsShown() then btn:Show(); end
			end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "UNIT_READY_CHECK_UPDATE";
});

RDX.RegisterFeature({
	name = "Ready Check Icon"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Ready Check";
	end;
});

----------------------------------------------------------------------
-- An iconic representation of the underlying unit's raid target icon.
----------------------------------------------------------------------
RDX.RegisterTextureIcon({
	name = "Raid Target";
	title = VFLI.i18n("Raid Target");
	createCode = [[
	btn._t:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons");
]];
	paintCodeTest = [[
		SetRaidTargetIconTexture(btn._t, 1);
		btn:Show();
]];
	paintCode = [[
		_i = GetRaidTargetIndex(uid);
		if _i then
			SetRaidTargetIconTexture(btn._t, _i);
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "RAID_TARGET_UPDATE";
});

RDX.RegisterFeature({
	name = "Raid Target Icon"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Raid Target";
	end;
});

----------------------------------------------------------------------
-- An iconic representation if unit is leader (made by superraider)
----------------------------------------------------------------------
RDX.RegisterTextureIcon({
	name = "Raid Leader";
	title = VFLI.i18n("Raid Leader");
	createCode = [[
	btn._t:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon");
]];
	paintCodeTest = [[
		btn:Show();
]];
	paintCode = [[
		if UnitIsPartyLeader(uid) then
			if not btn:IsShown() then btn:Show(); end
		else
			if btn:IsShown() then btn:Hide(); end
		end
]];
	event = "PARTY_LOOT_METHOD_CHANGED";
});

RDX.RegisterFeature({
	name = "Raid Leader Icon"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Raid Leader";
	end;
});

--
-- PVP Icon
--

RDX.RegisterTextureIcon({
	name = "PVP";
	title = VFLI.i18n("PVP");
	createCode = [[]];
	paintCodeTest = [[
		tempcolor = RDXMD.GetPVPIcon("FFA");
		btn._t:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
		btn:Show();
]];
	paintCode = [[
		if UnitIsPVP(uid) then
			_meta = UnitFactionGroup(uid);
			if UnitIsPVPFreeForAll(uid) then _meta = "FFA"; end
			if _meta then 
				tempcolor = RDXMD.GetPVPIcon(_meta);
				btn._t:SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. _meta);
				btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
				if not btn:IsShown() then btn:Show(); end
			else
				if btn:IsShown() then btn:Hide(); end
			end
		else
			if btn:IsShown() then btn:Hide(); end
		end;
]];
	event = "UNIT_FACTION";
});

RDX.RegisterFeature({
	name = "tex_pvp2"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "PVP";
	end;
});

--------------------------------------------------------------
-- A Texture is an independent texture object on a unitframe.
--------------------------------------------------------------
RDX.RegisterFeature({
	name = "texture2";
	version = 1; 
	title = VFLI.i18n("Texture"); 
	category = VFLI.i18n("Basics");
	multiple = true;
	test = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local flg = true;
		if desc.ftype == 1 then
			flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
			flg = flg and RDXUI.UFFrameCheck_Proto("Texture_", desc, state, errs);
			flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
			if desc.sublevel and (tonumber(desc.sublevel) < 0 or tonumber(desc.sublevel) > 7) then
				VFL.AddError(errs, VFLI.i18n("Texture level must be between 0 to 7")); flg = nil;
			end
			if flg then state:AddSlot("Texture_" .. desc.name); state:AddSlot("TextureCustom_" .. desc.name); end
		elseif desc.ftype == 2 then
			flg = flg and RDXUI.UFFrameCheck_Proto("Texture_", desc, state, errs);
			flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
			flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
			if desc.ictype then
				if not Icons[desc.ictype] then VFL.AddError(errs, VFLI.i18n("Missing ictype")); flg = nil; end
			end
			if flg then state:AddSlot("Texture_" .. desc.name); end
		elseif desc.ftype == 3 then
			if state:Slot("Tx_rdx_" .. desc.intype) then
				VFL.AddError(errs, VFLI.i18n("Texture Indicator class already add")); return nil;
			end
			flg = flg and RDXUI.UFFrameCheck_Proto("Texture_", desc, state, errs);
			flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
			flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
			if desc.intype then
				if not Indicators[desc.intype] then VFL.AddError(errs, VFLI.i18n("Missing intype")); flg = nil; end
			end
			if flg then state:AddSlot("Texture_" .. desc.name); state:AddSlot("Tx_rdx_" .. desc.intype); end
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = RDXUI.ResolveTextureReference(desc.name);
		
		local driver = desc.driver or 1;
		local bs = desc.bs or VFLUI.defaultButtonSkin;
		local bkd = desc.bkd or VFLUI.defaultBackdrop;
		
		local os = 0; 
		if driver == 2 then
			if desc.bs and desc.bs.insets then os = desc.bs.insets or 0; end
		elseif driver == 3 then
			if desc.bkd and desc.bkd.insets and desc.bkd.insets.left then os = desc.bkd.insets.left or 0; end
		end
		------------------ On Closure
		if desc.ftype == 3 then
			state:Attach(state:Slot("EmitClosure"), true, function(code) code:AppendCode(Indicators[desc.intype].emitClosureCode); end);
		end
		
		------------------ On frame creation
		local createCode = ""
		if desc.ftype == 1 then
			createCode = createCode .. [[
	local _t = VFLUI.CreateTexture(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
	_t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);
	_t:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	_t:SetWidth(]] .. desc.w .. [[); _t:SetHeight(]] .. desc.h .. [[);
	_t:Show();
	]] .. objname .. [[ = _t;
]];
			createCode = createCode .. VFLUI.GenerateSetTextureCode("_t", desc.texture);
		elseif desc.ftype == 2 then
			createCode = createCode .. [[
	local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
]];
			if driver == 1 then 
				createCode = createCode .. [[
	btn = VFLUI.AcquireFrame("Button");
]];
			elseif driver == 2 then
				createCode = createCode .. [[
	btn = VFLUI.AcquireFrame("Button");
	VFLUI.SetButtonSkin(btn, ]] .. Serialize(bs) .. [[);
]];
			elseif driver == 3 then
				createCode = createCode .. [[
	btn = VFLUI.AcquireFrame("Button");
	VFLUI.SetBackdrop(btn, ]] .. Serialize(bkd) .. [[);
]];
			end
			createCode = createCode .. [[
	btn:SetParent(btnOwner);
	btn:SetFrameLevel(btnOwner:GetFrameLevel());
	btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
	btn._t = VFLUI.CreateTexture(btn);
	btn._t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", 2);
	btn._t:SetPoint("CENTER", btn, "CENTER");
	btn._t:SetWidth(]] .. desc.w .. [[ - ]] .. os .. [[); btn._t:SetHeight(]] .. desc.h .. [[ - ]] .. os .. [[);
	btn._t:SetVertexColor(1,1,1,1);
	btn._t:Show();
	btn:Hide();
]];
			createCode = createCode .. Icons[desc.ictype].createCode;
			createCode = createCode .. [[
	]] .. objname .. [[ = btn;
]];
		elseif desc.ftype == 3 then
			local path = Indicators[desc.intype].set.file; 
			state:GetContainingWindowState():Attach("Menu", true, function(win, mnu)
				table.insert(mnu, {
					text = VFLI.i18n("Edit Indicator: ") .. desc.name;
					OnClick = function()
						VFL.poptree:Release();
						RDXDB.OpenObject(path, "Edit", VFLDIALOG);
					end;
				});
			end);
			createCode = createCode .. [[
	local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
	btn = VFLUI.AcquireFrame("Frame");
	btn:SetParent(btnOwner);
	btn:SetFrameLevel(btnOwner:GetFrameLevel());
	btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
	btn._t = VFLUI.CreateTexture(btn);
	btn._t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "2") .. [[);
	btn._t:SetPoint("CENTER", btn, "CENTER");
	btn._t:SetWidth(]] .. desc.w .. [[); btn._t:SetHeight(]] .. desc.h .. [[);
	btn._t:SetVertexColor(1,1,1,1);
	btn._t:Show();
	btn:Hide();
]];
			createCode = createCode .. Indicators[desc.intype].createCode;
			createCode = createCode .. [[
	]] .. objname .. [[ = btn;
]];
		end
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = ""
		if desc.ftype == 1 then
			destroyCode = destroyCode .. [[
		]] .. objname .. [[:Destroy();
		]] .. objname .. [[ = nil;
]];
		elseif desc.ftype == 2 or desc.ftype == 3 then
			destroyCode = destroyCode .. [[
		VFLUI.ReleaseRegion(]] .. objname .. [[._t); 
		]] .. objname .. [[._t = nil;
		]] .. objname .. [[:Destroy(); 
		]] .. objname .. [[ = nil;
]];		
		end
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		if desc.ftype == 1 then
			if (desc.cleanupPolicy == 2) then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
	]] .. objname .. [[:Hide();
]]); end);
			elseif (desc.cleanupPolicy == 3) then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
	]] .. objname .. [[:Show();
]]); end);
			end
		
		elseif desc.ftype == 2 or desc.ftype == 3 then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
	]] .. objname .. [[:Hide();
]]); end);
		end
		
		if desc.ftype == 2 then
			local paintCode = [[
		btn = ]] .. objname .. [[;
]];
			paintCode = paintCode .. Icons[desc.ictype].paintCode;
			local paintCodeTest = [[
		btn = ]] .. objname .. [[;
]];
			paintCodeTest = paintCodeTest .. Icons[desc.ictype].paintCodeTest;
			
			if desc.test then
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCodeTest); end);
			else
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
			end
			
			local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
			mux:Event_MaskAll(Icons[desc.ictype].event, 2);
		elseif desc.ftype == 3 then
			local paintCode = [[
		btn = ]] .. objname .. [[;
]];
			paintCode = paintCode .. Indicators[desc.intype].paintCode;
			local paintCodeTest = [[
		btn = ]] .. objname .. [[;
]];
			paintCodeTest = paintCodeTest .. Indicators[desc.intype].paintCodeTest;
			
			if desc.test then
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCodeTest); end);
			else
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
			end
			
			-- Event hint: update on sort.
			local set = RDXDAL.FindSet(Indicators[desc.intype].set);
			local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
			mux:Event_SetDeltaMask(set, 2); -- mask 2 = generic repaint
		end	

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);
		
		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture parameters")));

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
		
		-- Feature type
		local ftype = VFLUI.DisjointRadioGroup:new();
		local ftype_1 = ftype:CreateRadioButton(ui);
		ftype_1:SetText(VFLI.i18n("Use Custom Texture"));
		local ftype_2 = ftype:CreateRadioButton(ui);
		ftype_2:SetText(VFLI.i18n("Use Icon Texture"));
		local ftype_3 = ftype:CreateRadioButton(ui);
		ftype_3:SetText(VFLI.i18n("Use Indicator Texture"));
		ftype:SetValue(desc.ftype or 2);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture Type Custom")));
		ui:InsertFrame(ftype_1);
		
		local cleanupPolicy = VFLUI.RadioGroup:new(ui);
		cleanupPolicy:SetLayout(3,3);
		cleanupPolicy.buttons[1]:SetText(VFLI.i18n("No cleanup"));
		cleanupPolicy.buttons[2]:SetText(VFLI.i18n("Hide on clean"));
		cleanupPolicy.buttons[3]:SetText(VFLI.i18n("Show on clean"));
		if desc and desc.cleanupPolicy then
			cleanupPolicy:SetValue(desc.cleanupPolicy);
		else
			cleanupPolicy:SetValue(1);
		end
		ui:InsertFrame(cleanupPolicy);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture Type Icon")));
		ui:InsertFrame(ftype_2);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Icon Type"));
		local dd_ictype = VFLUI.Dropdown:new(er, function() return IconsIndex; end);
		dd_ictype:SetWidth(200); dd_ictype:Show();
		if desc and desc.ictype then dd_ictype:SetSelection(Icons[desc.ictype].title, desc.ictype); else dd_ictype:SetSelection("Faction"); end
		er:EmbedChild(dd_ictype); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture Type Indicator")));
		ui:InsertFrame(ftype_3);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Indicator Type"));
		local dd_intype = VFLUI.Dropdown:new(er, function() return IndicatorIndex; end);
		dd_intype:SetWidth(200); dd_intype:Show();
		if desc and desc.intype then dd_intype:SetSelection(Indicators[desc.intype].title, desc.intype); else dd_intype:SetSelection("Blue"); end
		er:EmbedChild(dd_intype); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			local _,ict = dd_ictype:GetSelection();
			local _,int = dd_intype:GetSelection();
			return { 
				feature = "texture2"; version = 1;
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				--
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				--
				driver = driver:GetValue();
				bs = dd_buttonskin:GetSelectedButtonSkin();
				bkd = dd_backdrop:GetSelectedBackdrop();
				--
				ftype = ftype:GetValue();
				cleanupPolicy = cleanupPolicy:GetValue();
				texture = tsel:GetSelectedTexture();
				ictype = ict;
				intype = int;
			};
		end
		
		ui.Destroy = VFL.hook(function(s) 
			ftype:Destroy(); ftype = nil;
			driver:Destroy(); driver = nil; 
		end, ui.Destroy);

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "texture2"; version = 1; 
			name = "tex1";
			w = 45; h = 45;
			owner = "Frame_decor";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			drawLayer = "ARTWORK"; sublevel = 1;
			driver = 1;
			ftype = 2;
			cleanupPolicy = 1;
			texture = VFL.copy(VFLUI.defaultTexture);
			ictype = "Faction";
			intype = "Blue";
		};
	end;
});

-- specific function to update the texture path of a feature.
function RDXDB.SetTextureData(path, key, value, newtexpath )
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat = RDXDB.HasFeature(x.data, "texture2", key, value);
	if feat and feat.texture then
		feat.texture.path = newtexpath;
		return true;
	end
	return nil;
end

RDX.RegisterFeature({
	name = "tex_icon";
	version = 31338;
	invisible = true;
	title = VFLI.i18n("Indicator");
	category = VFLI.i18n("Textures");
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "texture2";
		desc.ftype = 2;
		desc.ictype = desc.class;
		desc.class = nil;
	end;
});

RDX.RegisterFeature({
	name = "tex_indicator";
	version = 31338;
	invisible = true;
	title = VFLI.i18n("Indicator");
	category = VFLI.i18n("Textures");
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "texture2";
		desc.ftype = 3;
		desc.intype = desc.class;
		desc.class = nil;
	end;
});

RDX.RegisterFeature({
	name = "texture";
	version = 31338;
	invisible = true;
	title = VFLI.i18n("Indicator");
	category = VFLI.i18n("Textures");
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "texture2";
		desc.ftype = 1;
	end;
});
