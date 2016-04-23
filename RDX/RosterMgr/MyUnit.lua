local a, o, myunit, plZX, plZY, x, y, zName, isIndoor, IndoorFlag, indoorMapFileName, mapId, cmaId, gcmd, tmDif, lvl, ang, moveDist, tm

local mapIdsave; -- when entering mini dungeon

local RidingSpells = {
	[75] = GetSpellInfo (33389) or "",
	[150] = GetSpellInfo (33392) or "",
	[225] = GetSpellInfo (34092) or "",		-- Expert
	[300] = GetSpellInfo (34093) or "",		-- Artisan
	[375] = GetSpellInfo (90265) or "",		-- Master
}

function SSS()
	for i = 1, 99 do

		-- Terrokar has 4 overlays with "" for name
		zname, zw, zh, zx, zy = GetMapOverlayInfo (i)
		if not zname then
			break
		end
		--VFL.print(zname .. ":" .. zw .. "," .. zh .. "," .. zx .. "," .. zy);
	end
end
-- /script SSS()
function RRR()
	local mapFileName, textureHeight, _, isMicroDungeon, microDungeonMapName = GetMapInfo();
	--VFL.print(mapFileName);
end
-- /script RRR()
-- /script VFL.print(GetCurrentMapAreaID());
local contbl
local function ProcessMyUnit(self, elapsed)
	-- Player real mapid
	zName = GetRealZoneText()
	a, a, a, isIndoor, indoorMapFileName = GetMapInfo();
	cmaId = GetCurrentMapAreaID()
	gcmd = GetCurrentMapDungeonLevel();
	mapId = nil;
	
	tm = GetTime()
	
	if zName then
		if myunit.contId then
			contbl = RDXMAP.MapNameToId[myunit.contId]
			if contbl then
				mapId = contbl[zName]; -- Carbonite	
			end
		end
		
		if not mapId then
			mapId = RDXMAP.InstanceNameToId[zName]; -- Carbonite	
		end
		
		--mapId = RDXMAP.APIMap.NameToId (zName, contId)
		if not mapId then
			--VFL.print("ZONE_CHANGED_NEW_AREA continent " .. myunit.contId);

			--SetMapToCurrentZone();
			--cmaId = GetCurrentMapAreaID()
			--gcmd = GetCurrentMapDungeonLevel();
			--VFL.print("ProcessMyUnit no mapId found " .. zName .. " " .. cmaId);
			mapId = cmaId;
		end
	end	
	--VFL.print(zName);
	--VFL.print(myunit.contId);
	--VFL.print(mapId);
	
	
	--VFL.print("ProcessMyUnit mapId " .. mapId);
	myunit.mapId = mapId;
	myunit.isIndoor = isIndoor;
	-- Player position (blizzard on the current map)
	plZX, plZY = GetPlayerMapPosition ("player");
	plZX = plZX * 100
	plZY = plZY * 100
	
	if plZX > 0 and mapId == cmaId then
		myunit.PlyrRZX = plZX
		myunit.PlyrRZY = plZY
	end
	
	myunit.PlyrDir = 360 - GetPlayerFacing() / 2 / math.pi * 360
	
	-- Player position and speed (Carbonite)
	if IsInInstance() then -- instance
		myunit.InstanceId = mapId
		x, y = RDXMAP.APIMap.GetWorldPos (mapId, 0, 0)
		lvl = max (GetCurrentMapDungeonLevel(), 1)	
		myunit.PlyrX = x + myunit.PlyrRZX * 1002 / 25600
		myunit.PlyrY = y + myunit.PlyrRZY * 668 / 25600 + (lvl - 1) * 668 / 256
		myunit.PlyrSpeed = 0
	elseif isIndoor then -- micro dungeon
		myunit.InstanceId = nil;
		lvl = max (GetCurrentMapDungeonLevel(), 1)	
		myunit.PlyrX = myunit.SaveLastX + myunit.PlyrRZX * 1002 / 25600
		myunit.PlyrY = myunit.SaveLastY + myunit.PlyrRZY * 668 / 25600
		
	--	myunit.PlyrSpeed = 0
	else -- external
		myunit.InstanceId = nil;
		x, y = RDXMAP.APIMap.GetWorldPos (mapId, myunit.PlyrRZX, myunit.PlyrRZY)
		
		if elapsed > 0 then
			if x == myunit.PlyrX and y == myunit.PlyrY then	-- Not moving?
				myunit.PlyrSpeedCalcTime = tm
				myunit.PlyrSpeed = 0
				myunit.PlyrSpeedX = x
				myunit.PlyrSpeedY = y

			else
				tmDif = GetTime() - myunit.PlyrSpeedCalcTime
				if tmDif > .5 then
					myunit.PlyrSpeedCalcTime = tm
					myunit.PlyrSpeed = ((x - myunit.PlyrSpeedX) ^ 2 + (y - myunit.PlyrSpeedY) ^ 2) ^ .5 * 4.575 / tmDif
					myunit.PlyrSpeedX = x
					myunit.PlyrSpeedY = y
				end
			end
		end
		myunit.PlyrX = x
		myunit.PlyrY = y
		
		--myunit.MoveLastX = x;
		--myunit.MoveLastY = y;
		
		--VFL.print("bliz " .. plZX);
		--VFL.print("carb " .. x);
		
	end
	
	if isIndoor ~= IndoorFlag then
		--VFL.print("Save Indoor " .. myunit.PlyrX .. " " .. myunit.PlyrY);
		myunit.SaveLastX = myunit.PlyrX
		myunit.SaveLastY = myunit.PlyrY
		IndoorFlag = isIndoor;
	end
	
	--VFL.print("carb " .. myunit.PlyrX .. " " .. myunit.PlyrY);
	--VFL.print("bliz " .. myunit.PlyrX .. " " .. myunit.PlyrY);
	
	if mapIdsave ~= mapId then
		--myunit.SaveLastX = myunit.PlyrX
		--myunit.SaveLastY = myunit.PlyrY
		--VFL.print(mapId);
		RDXEvents:Dispatch("PlayerZoneChanged", mapId);
		--SetMapToCurrentZone();
		mapIdsave = mapId;
	end
	
	myunit.DistX = myunit.PlyrX - myunit.MoveLastX
	myunit.DistY = myunit.PlyrY - myunit.MoveLastY
	ang = myunit.PlyrDir - myunit.PlyrLastDir
	moveDist = (myunit.DistX * myunit.DistX + myunit.DistY * myunit.DistY) ^ .5
	
	if moveDist >= .01 * RDXMAP.BaseScale or abs (ang) > .01 then
		myunit.MoveLastX = myunit.PlyrX
		myunit.MoveLastY = myunit.PlyrY
		myunit.PlyrLastDir = myunit.PlyrDir
		myunit.movetick = true;
		--VFL.print("MOVE")
	else
		myunit.movetick = false;
	end
	
	x = myunit.PlyrHist.LastX - myunit.MoveLastX
	y = myunit.PlyrHist.LastY - myunit.MoveLastY
	moveDist = (x * x + y * y) ^ .5
	
	--if moveDist > map.GOpts["MapTrailDist"] * RDXMAP.BaseScale then
	if moveDist > 2 * RDXMAP.BaseScale then

		myunit.PlyrHist.LastX = myunit.MoveLastX
		myunit.PlyrHist.LastY = myunit.MoveLastY

		myunit.PlyrHist.Time = tm

		a = myunit.PlyrHist.Next
		o = a * 4 - 3

		myunit.PlyrHist[o] = tm
		myunit.PlyrHist[o + 1] = myunit.PlyrX
		myunit.PlyrHist[o + 2] = myunit.PlyrY
		myunit.PlyrHist[o + 3] = myunit.PlyrDir
		

		if a >= myunit.PlyrHist.Cnt then
			a = 0
		end

		myunit.PlyrHist.Next = a + 1
	end
	
end

--WoWEvents:Bind("ZONE_CHANGED", nil, function() 
--	VFL.print("ZONE_CHANGED");
--	SetMapToCurrentZone()
--end);

--WoWEvents:Bind("ZONE_CHANGED_INDOORS", nil, function() 
--	VFL.print("ZONE_CHANGED_INDOORS");
--	SetMapToCurrentZone()
--end);

local function initCont()
	SetMapToCurrentZone();
	if myunit then
		myunit.contId = GetCurrentMapContinent();
		--VFL.print("ZONE_CHANGED_NEW_AREA continent " .. myunit.contId);
	end
end

WoWEvents:Bind("ZONE_CHANGED_NEW_AREA", nil, function() 
	initCont();
end);


RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, function() 
	myunit = RDXDAL.GetMyUnit();
	myunit.contId = 1;
	local hist = {}
	hist.LastX = -99999999
	hist.LastY = -99999999
	hist.Next = 1
	hist.Cnt = 100 -- default
	for n = 1, hist.Cnt * 4, 4 do
		hist[n] = 0				-- Secs
		hist[n + 1] = 0		-- World X
		hist[n + 2] = 0		-- World Y
		hist[n + 3] = 0		-- Direction
	end
	myunit.PlyrHist = hist;
	
	initCont();
	
	-- local myunit = RDXDAL.GetMyUnit();
	-- myunit.mapId
	local myunitFrame = CreateFrame("Frame");
	myunitFrame:SetScript("OnUpdate", ProcessMyUnit);
	VFLP.RegisterFunc("RDXDAL: UnitDB", "ProcessMyUnit", ProcessMyUnit, true);
	
	for skill, name in pairs (RidingSpells) do
		if GetSpellInfo (name) then
			myunit.SkillRiding = skill
			break
		end
	end
	
	myunit.speed = 2 / 4.5
	if myunit.SkillRiding then
		if myunit.SkillRiding < 75 then
			myunit.speed = 1 / 4.5
		elseif myunit.SkillRiding < 150 then
			myunit.speed = 1.6 / 4.5
		elseif myunit.SkillRiding >= 225 then
			myunit.speed = 2.5 / 4.5
		end
	end
	
end);

------------------------------------------------
-- Combat and Battleground Detection
------------------------------------------------
function VFL._ForceCombatFlag(f)
	if f then
		RDX.InCombat = true;
		VFL:Debug(1, "********** VFL combat flag TRUE *************");
		VFLEvents:Dispatch("PLAYER_COMBAT", true);
	else
		RDX.InCombat = nil;
		VFL:Debug(1, "********** VFL combat flag FALSE *************");
		VFLEvents:Dispatch("PLAYER_COMBAT", nil);
	end
end

WoWEvents:Bind("PLAYER_REGEN_DISABLED", nil, function() VFL._ForceCombatFlag(true); end);
WoWEvents:Bind("PLAYER_REGEN_ENABLED", nil, function() VFL._ForceCombatFlag(nil); end);

function VFL.PlayerInCombat() return InCombatLockdown(); end

-- talent detection
local talent = nil;
function VFL._ForceTalentSwitch(f, nosend)
	if f ~= talent then
		talent = f;
		if not nosend then
			VFL:Debug(1, "********** Talent_changed *************");
			if not InCombatLockdown() then
				VFLT.schedule(0.5, function() VFLEvents:Dispatch("PLAYER_TALENT_UPDATE", f); end)
			end
		end
	end
end
WoWEvents:Bind("PLAYER_TALENT_UPDATE", nil, function() VFL._ForceTalentSwitch(GetSpecialization()); end);
WoWEvents:Bind("PLAYER_ENTERING_WORLD", nil, function() VFL._ForceTalentSwitch(GetSpecialization(), true); end);

function VFL.GetPlayerTalent()
	return talent;
end

-- UPDATE_SHAPESHIFT_FORM
-- UPDATE_SHAPESHIFT_FORMS
local ssform = 0;
function VFL._ForceFormSwitch(nosend)
	local index = GetShapeshiftForm();
	--VFL.print(index);
	if index and index > 0 then
		local _, name = GetShapeshiftFormInfo(index); 
		--VFL.print(name);
		if ssform ~= index then
			ssform = index;
			if not nosend then
				VFL:Debug(1, "********** Form_changed *************");
				VFLEvents:Dispatch("PLAYER_FORM_UPDATE", ssform);
				--VFL.print("event " .. name);
			end
		end
	end
end
WoWEvents:Bind("UPDATE_SHAPESHIFT_FORM", nil, function() VFL._ForceFormSwitch(); end);

function VFL.GetPlayerForm()
	return ssform;
end

-- Bg detection
RDX.InBG = nil;
local function SetBGFlag(f)
	if f and RDX.InBG ~= f then
		RDX.InBG = f;
		VFLEvents:Dispatch("PLAYER_IN_BATTLEGROUND", f);
	elseif (not f) and RDX.InBG then
		RDX.InBG = nil;
		VFLEvents:Dispatch("PLAYER_IN_BATTLEGROUND", nil);
	end
end

-- Arena detection
RDX.InA = nil;
local function SetAFlag(f)
	if f and RDX.InA ~= f then
		RDX.InA = f;
		VFLEvents:Dispatch("PLAYER_IN_ARENA", f);
	elseif (not f) and RDX.InA then
		RDX.InA = nil;
		VFLEvents:Dispatch("PLAYER_IN_ARENA", nil);
	end
end

function VFL.InBattleground()
	--return (MiniMapBattlefieldFrame.status == "active") and select(2,IsInInstance()) == "pvp";
	return select(2,IsInInstance()) == "pvp";
end

function VFL.InArena()
	--return (MiniMapBattlefieldFrame.status == "active") and select(2, IsInInstance()) == "arena";
	return select(2, IsInInstance()) == "arena";
end

function VFL.InSanctuary()
	--return (MiniMapBattlefieldFrame.status == "active") and select(2, IsInInstance()) == "arena";
	return GetZonePVPInfo() == "sanctuary";
end

WoWEvents:Bind("UPDATE_BATTLEFIELD_STATUS", nil, function()
	if VFL.InBattleground() then
		SetBGFlag(myunit.mapId);
	else
		SetBGFlag(nil);
	end
	if VFL.InArena() then
		SetAFlag(myunit.mapId);
	else
		SetAFlag(nil);
	end
end);

function VFL.GetBGName(name)
	-- remove any dash
	local _, _, bg_name = string.find(name, "^(.*)-(.*)$");
	-- Record the target
	if bg_name then return bg_name; else return name; end
end

function RDX.PPZ()
	--VFL.print(GetCurrentMapAreaID())
end
-- /script RDX.PPZ();
