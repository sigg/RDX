
----------------------------------------- TARGETS
-- No maps

local cp = 0;

-- Target object to be reuse
VFLUI.CreateFramePool("MapTarget",
function(pool, x) -- onrelease
	tar.TargetType = nil
	tar.TargetX1 = nil
	tar.TargetY1 = nil
	tar.TargetX2 = nil
	tar.TargetY2 = nil
	tar.TargetMX = nil
	tar.TargetMY = nil
	tar.TargetTex = nil
	tar.TargetId = nil
	tar.TargetName = nil
	tar.MapId = nil
end, 
function() -- onfallback
	local f = {};
	cp = cp + 1;
	f.UniqueId = cp;
	return f;
end,
function(_, f) -- onacquire

end);

local tar;

function RDXMAP.SetTargetName (name, id)
	if not id = then id = 1; end
	tar = RDXMAP.Targets[id]
	if tar then
		tar.TargetName = name
	else
		tar = VFLUI.AcquireFrame("MapTarget");
		tar.TargetName = name
		table.insert(RDXMAP.Targets, tar);
	end
	TargetEvents:Dispatch("Update");
end

--------
-- Set map target
-- (type string, x, y, x2, y2, texture (nil for default, false for none), user id, name)

function RDXMAP.AddTarget (typ, x1, y1, x2, y2, tex, id, name, mapId)

	assert (x1)
	
	local tar = VFLUI.AcquireFrame("MapTarget");
	tar.TargetType = typ
	tar.TargetX1 = x1
	tar.TargetY1 = y1
	tar.TargetX2 = x2
	tar.TargetY2 = y2
	tar.TargetMX = (x1 + x2) * .5		-- Mid point
	tar.TargetMY = (y1 + y2) * .5
	tar.TargetTex = tex
	tar.TargetId = id
	tar.TargetName = name
--	tar.ArrowPulse = 1
	tar.MapId = mapId
	
	tinsert (RDXMAP.Targets, tar)

	--local i = map.TargetNextUniqueId
	--tar.UniqueId = i
	--map.TargetNextUniqueId = i + 1

	--local typ = keep and "Target" or "TargetS"
	--local zx, zy = RDXMAP.APIMap.GetZonePos (mapId, tar.TargetMX, tar.TargetMY)

	--Nx.Fav:Record (typ, name, mapId, zx, zy)
	TargetEvents:Dispatch("Update");
	return tar
end

--------
-- Clear all targets
-- (matchType we will clear or nil for any)
function RDXMAP.ClearTargets (matchType)
	if matchType then
		for i, v in ipairs (RDXMAP.Targets) do
			if matchType == v.TargetType then
				v:Destroy();
			end
		end
		VFL.removeFieldMatches(RDXMAP.Targets, "TargetType", matchType)
	else
		for i, v in ipairs (RDXMAP.Targets) do
			v:Destroy();
		end
		VFL.empty(RDXMAP.Targets);
	end
	TargetEvents:Dispatch("Update");
end

function RDXMAP.ClearTarget (uniqueId)
	for i, v in ipairs (RDXMAP.Targets) do
		if uniqueId == v.UniqueId then
			v:Destroy();
		end
	end
	VFL.removeFieldMatches(RDXMAP.Targets, "UniqueId", uniqueId)
	TargetEvents:Dispatch("Update");
end

--------
-- Get map target type, id
function RDXMAP.GetTargetInfo()
	local tar = RDXMAP.Targets[1]
	if tar then
		return tar.TargetType, tar.TargetId
	end
end

--------
-- Get map target pos

function RDXMAP.GetTargetPos()
	local tar = RDXMAP.Targets[1]
	if tar then
		return tar.TargetX1, tar.TargetY1, tar.TargetX2, tar.TargetY2
	end
end

function RDXMAP.FindTarget (uniqueId)
	for n, tar in ipairs (RDXMAP.Targets) do
		if tar.UniqueId == uniqueId then
			return tar, n
		end
	end
end


