
local s
local t

--------
-- Save map view

function RDXMAP.APIMap.SaveView (map, name)

	s = format ("%s%s", RDX.InBG or "", name)

--	VFL.vprint ("Save view %s", s)

	t = map.ViewSavedData[s]

	if not t then
		t = {}
		map.ViewSavedData[s] = t
	end

	t.Scale = map.Scale
	t.x = map.MapPosX
	t.y = map.MapPosY
end

--------
-- Restore map view

function RDXMAP.APIMap.RestoreView (map, name)

	s = format ("%s%s", RDX.InBG or "", name)

--	VFL.vprint ("Restore view %s", s)

	t = map.ViewSavedData[s]

	if t then
		map.Scale = t.Scale
		map.MapPosX = t.x
		map.MapPosY = t.y

		map.StepTime = 5
	end
end