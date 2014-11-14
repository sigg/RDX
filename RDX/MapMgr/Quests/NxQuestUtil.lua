

--------
-- Play a completed sound
-- (snd index or nil for random)

function RDXMAP.Quest.PlaySound (sndI)

	if not sndI then

		local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
		local opts = mbo.data
		local cnt = 0

		for n = 1, 10 do
			if opts["QSnd" .. n] then
				cnt = cnt + 1
			end
		end

		if cnt > 0 then

			local i = random (1, cnt)
			cnt = 0

			for n = 1, 10 do
				if opts["QSnd" .. n] then
					cnt = cnt + 1
					if cnt == i then
						sndI = n
						break
					end
				end
			end
		end
	end

	if sndI then
		local snd = RDXMAP.Quest.OptsDataSounds[sndI]
		VFLIO.PlaySoundFile (snd)
	end
end

--------
-- Calculate the watch colors

function RDXMAP.Quest.CalcWatchColors()

--	Nx.QLocColors = { 1,0,0, "QuestWatchR", 0,1,0, "QuestWatchG", .2,.2,1, "QuestWatchB" }

	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local opts = mbo.data

	local colors = {}
	RDXMAP.Quest.QLocColors = colors

	local a = VFL.Util_num2a (opts["QMapWatchAreaAlpha"])

	local colMax = opts["QMapWatchColorCnt"]
	local colI = 1

	for n = 1, 15 do

		local color = {}
		colors[n] = color

		local r, g, b = VFL.explodeHexNumberRGBA (opts["QMapWatchC" .. colI])
		color[1] = r
		color[2] = g
		color[3] = b
		color[4] = a
		color[5] = "QuestListWatch"

		colI = colI + 1
		colI = colI > colMax and 1 or colI
	end
end

--------
-- Show quest is not in DB

function RDXMAP.Quest.MsgNotInDB (typ)

	if typ == "O" then
		UIErrorsFrame:AddMessage ("This objective is not in the database", 1, 0, 0, 1)
	elseif typ == "Z" then
		UIErrorsFrame:AddMessage ("This objective zone is not in the database", 1, 0, 0, 1)
	else
		UIErrorsFrame:AddMessage ("This quest is not in the database", 1, 0, 0, 1)
	end
end
