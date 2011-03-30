-- MyCooldownDB.lua
-- OpenRDX
-- Sigg

-------------------------------------------------
-- store your real cooldown duration in user db
-------------------------------------------------
--[[
local MyGUID, spellid, spell_id, start, duration;
local GetSpellIdBook = RDXSS.GetSpellIdBook;

local function SetCooldownValue(spellid, value)
	if not spellid or not value then return; end
	RDXU.CooldownDB[spellid] = value;
end

local function GetCooldownValue(spellid)
	return RDXU.CooldownDB[spellid];
end

local function ParseSpellSuccessCD(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellname)
	if (event == "SPELL_CAST_SUCCESS") and sourceGUID == MyGUID then
		RDXCD.SPEI, RDXCD.SPEN = spellid, spellname;
		VFLT.schedule(1, function()
			VFL.print(RDXCD.SPEN);
			local i=1;
			while true do
				local name = GetSpellBookItemName(i, BOOKTYPE_SPELL);
				if not name then break; end
				if RDXCD.SPEN == name then spell_id = i; end
				i=i+1;
			end
			--spell_id = RDXSS.GetSpellIdBook(RDXCD.SPEN); --spell_id from the book, not from spellid log.
			if spell_id then
				start, duration = GetSpellCooldown(RDXCD.SPEN, BOOKTYPE_SPELL);
				if duration and duration > 1 then
					SetCooldownValue(RDXCD.SPEI, duration);
					VFL.print("found cd " .. RDXCD.SPEN .. " " .. duration);
				end
			else
				VFL.print("NOT found");
			end
		end);
	end
end
]]

RDXEvents:Bind("INIT_SPELL", nil, function()
	local myunit = RDXDAL.GetMyUnit();
	local cd_used, cd_avail, cd_possi = myunit:GetCooldowns();
	local cds = RDXCD.GetCDs();
	local myduration = RDXU.CooldownDB;
	local name, start, duration, enabled;
	local i=1;
	while true do
		local name = GetSpellBookItemName(i, BOOKTYPE_SPELL);
		if not name then break; end
		for k,v in pairs(cds) do
			if v.spellname == name then
				cd_possi[k] = myduration[k] or v.duration;
				cd_avail[k] = true;
				start, duration, enabled = GetSpellCooldown(i, BOOKTYPE_SPELL);
				if enabled > 0 and duration > 0 then
					myunit:AddCooldown(k, start + cd_possi[k] - GetTime());
				end
				break;
			end
		end
		i=i+1;
	end		
end);

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	if not RDXU.CooldownDB then RDXU.CooldownDB = {}; end
end);

function RDXCD.WipeCooldownDB()
	VFL.empty(RDXU.CooldownDB);
end

function RDXCD.DebugCooldownDB()
	for k,v in pairs(RDXU.CooldownDB) do
		local name = GetSpellInfo(k);
		if name then
			VFL.print(name .. ":" .. v);
		else
			VFL.print("Unknown Spellid" .. k);
		end
	end
end

