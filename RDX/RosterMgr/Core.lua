-- Core.lua
-- OpenRDX
-- Daniel Ly

RDXDAL = RegisterVFLModule({
	name = "RDXDAL";
	title = VFLI.i18n("RDX Data Abstraction Layer");
	description = "RDX Data Abstraction Layer";
	version = {1,0,0};
	parent = RDX;
});

local tempty, strlower, strmatch, strgsub = VFL.empty, string.lower, string.match, string.gsub;
VFLP.RegisterCategory("RDXDAL");
-------------------------------------------------------------------
-- UNIT AURA METADATA
-------------------------------------------------------------------
VFLP.RegisterCategory("RDXDAL: UnitAura");
-- Local override for debuff categorization.
-- Example: debuffCategoryOverride[VFLI.i18n("arcane blast")] = "@other";
local debuffCategoryOverride = {};

-- The aura metadata caches.
local function GenMetadataCacheFuncs(ncache)
	local Set = function(texture, name, category, properName, properCategory, descr)
		if not name then return; end
		local x = { name = name, texture = texture, properName = properName, category = category, properCategory = properCategory, descr = descr };
		ncache[name] = x;
		return x;
	end

	local NGet = function(name) 
		return ncache[name]; 
	end

	return Set, NGet;
end

local buffCacheN = {};
local debuffCacheN = {};

local buffcache_nset, buffcache_nget = GenMetadataCacheFuncs(buffCacheN);
local debuffcache_nset, debuffcache_nget = GenMetadataCacheFuncs(debuffCacheN);

--- @return A table containing information on the buff with the given texture, if seen this session.
-- Nil otherwise.
RDXDAL.GetBuffInfoByName = buffcache_nget;
RDXDAL.GetDebuffInfoByName = debuffcache_nget;

function RDXDAL._GetBuffCache()
	return buffCacheN;
end

function RDXDAL._GetDebuffCache()
	return debuffCacheN;
end

-----------------------------------------------------------------------------------

local name, lname, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable, testUnit, info, category;

-- INTERNAL: Get information about a debuff from a unit.
local function LoadDebuffFromUnit(uid, i, castable, cache)
	-- looking for unit in database RDX
	if cache then
		testUnit = RDXDAL._ReallyFastProject(uid);
		if (not testUnit) then cache = false; end
	end
	
	if cache then
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = testUnit:GetDeBuffCache(i);
	else
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff(uid, i, castable);
	end
	
	if (not name) then return nil; end
	lname = strlower(name);
	if expirationTime and expirationTime > 0 then timeLeft = expirationTime - GetTime(); end
	if (not count) or (count < 1) then count = 1; end
	
	-- Query cache; early out if we already have the infos.
	info = debuffcache_nget(lname);
	if info then
		return true, name, lname, info.category, info, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable;
	else
		-- Munge category
		category = debuffType;
		if debuffCategoryOverride[lname] then
			category = debuffCategoryOverride[lname];
		elseif category then
			category = "@" .. strlower(category);
		else
			category = "@other";
		end
		-- Stuff tooltip
		VFLTipTextLeft1:SetText(nil); VFLTipTextRight1:SetText(nil);
		VFLTipTextLeft2:SetText(nil);
		VFLTip:SetUnitDebuff(uid, i);
		-- Add to cache
		info = debuffcache_nset(icon, lname, category, name, VFLTipTextRight1:GetText(), VFLTipTextLeft2:GetText());
		return true, name, lname, category, info, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable;
	end
end
RDXDAL.LoadDebuffFromUnit = LoadDebuffFromUnit;
VFLP.RegisterFunc("RDXDAL: UnitAura", "LoadDebuffFromUnit", LoadDebuffFromUnit, true);

-- INTERNAL: Get information about a buff from a unit.
local function LoadBuffFromUnit(uid, i, castable, cache)
	-- looking for unit in database RDX
	if cache then
		testUnit = RDXDAL._ReallyFastProject(uid);
		if (not testUnit) then cache = false; end
	end
	
	if cache then
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = testUnit:GetBuffCache(i);
	else
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff(uid, i, castable);
	end
	
	if (not name) then return nil; end
	lname = strlower(name);
	if expirationTime and expirationTime > 0 then timeLeft = expirationTime - GetTime(); end
	if (not count) or (count < 1) then count = 1; end
	
	-- Attempt to get buff data from the cache
	info = buffcache_nget(lname);
	if info then
		return true, name, lname, info.category, info, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable;
	else
		-- Stuff tooltip
		VFLTipTextLeft1:SetText(nil); VFLTipTextRight1:SetText(nil);
		VFLTipTextLeft2:SetText(nil);
		VFLTip:SetUnitBuff(uid, i);
		-- Write to cache and return
		info = buffcache_nset(icon, lname, "@other", name, nil, VFLTipTextLeft2:GetText());
		return true, name, lname, "@other", info, rank, icon, count, debuffType, duration, expirationTime, timeLeft, caster, isStealable;
	end
end
RDXDAL.LoadBuffFromUnit = LoadBuffFromUnit;
VFLP.RegisterFunc("RDXDAL: UnitAura", "LoadBuffFromUnit", LoadBuffFromUnit, true);
--VFLP.RegisterFunc(VFLI.i18n("RDXDAL: UnitAura"), "UnitBuff", UnitBuff, true);
--VFLP.RegisterFunc(VFLI.i18n("RDXDAL: UnitAura"), "UnitBuffCache", UnitBuffCache, true);

-- Debuff categories
RDXEvents:Bind("INIT_PRELOAD", nil, function()
	debuffCacheN["@curse"] = {	
		name = "@curse",
		texture = "Interface\\InventoryItems\\WoWUnknownItem01.blp",
		properName = VFLI.i18n("@curse"),
		descr = VFLI.i18n("Matches any curse."),
		set = RDXDAL.GetDebuffSet("@curse"), isInvisible = true,
	};

	debuffCacheN["@magic"] = {
		name = "@magic",
		texture = "Interface\\InventoryItems\\WoWUnknownItem01.blp",
		properName = VFLI.i18n("@magic"),
		descr = VFLI.i18n("Matches any magic debuff."),
		set = RDXDAL.GetDebuffSet("@magic"), isInvisible = true,
	};

	debuffCacheN["@poison"] = {
		name = "@poison",
		texture = "Interface\\InventoryItems\\WoWUnknownItem01.blp",
		properName = VFLI.i18n("@poison"),
		descr = VFLI.i18n("Matches any poison debuff."),
		set = RDXDAL.GetDebuffSet("@poison"), isInvisible = true,
	};
	
	debuffCacheN["@disease"] = {
		name = "@disease",
		texture = "Interface\\InventoryItems\\WoWUnknownItem01.blp",
		properName = VFLI.i18n("@disease"),
		descr = VFLI.i18n("Matches any disease debuff."),
		set = RDXDAL.GetDebuffSet("@disease"), isInvisible = true,
	};

	debuffCacheN["@other"] = {
		name = "@other",
		texture = "Interface\\InventoryItems\\WoWUnknownItem01.blp",
		properName = VFLI.i18n("@other"),
		descr = VFLI.i18n("Matches any debuff that is not disease, poison, magic, or curse."),
		set = RDXDAL.GetDebuffSet("@other"), isInvisible = true,
	};
end);

--- Reproduce an aura tooltip from an entry in an aura cache.
function RDXDAL.ShowAuraTooltip(meta, frame, anchor)
	GameTooltip:SetOwner(frame, "ANCHOR_NONE");
	GameTooltip:SetPoint("TOPLEFT", frame, anchor);
	GameTooltip:ClearLines();
	GameTooltip:AddDoubleLine(meta.properName, meta.properCategory);
	GameTooltip:AddLine(meta.descr, 1, 1, 1, 1, true);
	GameTooltip:Show();
end

-- METADATA table
local Buffweapons = {};

function RDXDAL.registerBuffWeapon(spellid, duration, icon)
	local name = nil;
	name = GetSpellInfo(spellid);
	if not name then name = spellid; end --else VFL.print(name); end
	local t = {};
	t.duration = duration;
	t.icon = icon;
	if Buffweapons[name] then error("Duplicate Buff Weapon registration " .. name); end
	Buffweapons[name] = t;
	return true;
end;

local strfind = string.find;
function RDXDAL.getBuffWeaponInfo(name)
	if not name then return; end
	local duration, icon, found = 0, "", nil;
	for k, v in pairs(Buffweapons) do
		found = strfind(k, name);
		if found then duration = v.duration; icon = v.icon; end
	end
	return duration, icon;
end;

----------------------------
-- Weapons Metadata
-----------------------------
-- INTERNAL: Get information about weapons buff.
-- "MainHandSlot"
-- "SecondaryHandSlot"
local function scanHand(hand)
	VFLTip:SetOwner(RDXParent, "ANCHOR_NONE");
	VFLTip:ClearLines();
	local idslot = GetInventorySlotInfo(hand);
	VFLTip:SetInventoryItem("player", idslot);
	local mytext, strfound = nil, nil;
	local buffname, buffrank, bufftex;
	for i = 1, VFLTip:NumLines() do
		mytext = _G["VFLTipTextLeft" .. i];
		strfound = strmatch(mytext:GetText(), "^(.*) %(%d+ [^%)]+%)$");
		if strfound then break; end
	end
	if strfound then
		strfound = strgsub(strfound, " %(%d+ [^%)]+%)", "");
		buffname, buffrank = strmatch(strfound, "(.*) (%d*)$");
		if not buffname then
			buffname, buffrank = strmatch(strfound, "(.*) ([IVXLMCD]*)$");
		end
		if not buffname then
			buffname, buffrank = strmatch(strfound, "(.*)(%d)");
			-- specific fucking french language langue de feu
			if buffname then
				local a = string.len(buffname);
				buffname = string.sub(buffname, 1, a - 2);
			else 
				buffname = strfound;
			end
			--if buffname then VFL.print(buffname); VFL.print(a); end
		end
		if not buffname then
			buffname = "unknown parse";
		end
		bufftex = GetInventoryItemTexture("player", idslot);
	end
	VFLTip:Hide();
	return buffname, buffrank, bufftex, idslot;
end;

local function LoadWeaponsBuff()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	local mainHandBuffName, mainHandBuffRank, mainHandBuffStart, mainHandBuffDur, mainHandTex, mainHandBuffTex, mainHandSlot, offHandBuffName, offHandBuffRank, offHandBuffStart, offHandBuffDur, offHandTex, offHandBuffTex, offHandSlot;
	if hasMainHandEnchant then
		mainHandBuffName, mainHandBuffRank, mainHandTex, mainHandSlot = scanHand("MainHandSlot");
		mainHandBuffDur, mainHandBuffTex = RDXDAL.getBuffWeaponInfo(mainHandBuffName);
		if mainHandBuffDur and mainHandBuffDur > 0 then
			mainHandBuffStart = GetTime() - (mainHandBuffDur - mainHandExpiration / 1000);
		else 
			mainHandBuffStart = 0;
			mainHandBuffDur = 0;
		end
	else
		mainHandBuffStart = 0;
		mainHandBuffDur = 0;
	end
	if hasOffHandEnchant then
		offHandBuffName, offHandBuffRank, offHandTex, offHandSlot = scanHand("SecondaryHandSlot");
		offHandBuffDur, offHandBuffTex = RDXDAL.getBuffWeaponInfo(offHandBuffName);
		if offHandBuffDur and offHandBuffDur > 0 then
			offHandBuffStart = GetTime() - (offHandBuffDur - offHandExpiration / 1000);
		else 
			offHandBuffStart = 0;
			offHandBuffDur = 0;
		end
	else
		offHandBuffStart = 0;
		offHandBuffDur = 0;
	end
	return hasMainHandEnchant, mainHandBuffName, mainHandBuffRank, mainHandCharges, mainHandBuffStart, mainHandBuffDur, mainHandTex, mainHandBuffTex, mainHandSlot, hasOffHandEnchant, offHandBuffName, offHandBuffRank, offHandCharges, offHandBuffStart, offHandBuffDur, offHandTex, offHandBuffTex, offHandSlot;
end
VFLP.RegisterFunc("RDXDAL: UnitAura", "LoadWeaponsBuff", LoadWeaponsBuff, true);

RDXDAL.LoadWeaponsBuff = LoadWeaponsBuff;
