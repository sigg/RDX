
RDXDAL.Friends = {}
RDXDAL.PalNames = {}

local function OnFriendguild_update()


--	VFL.vprint ("OnFriendguild_update")
	
	VFL.empty(RDXDAL.PalNames);
	VFL.empty(RDXDAL.Friends);
	
	local gNum = GetNumGuildMembers()

	for n = 1, gNum do
		local name, _, _, _, _, _, _, _, online = GetGuildRosterInfo (n)
		if online then
			RDXDAL.PalNames [name] = true
		end
	end

	local i = 1

	for n = 1, GetNumFriends() do

		local name, lvl, class, area, con, status = GetFriendInfo (n)
		if con then

			if not RDXDAL.PalNames[name] then

--				VFL.vprint ("Add friend %s", name)

				RDXDAL.Friends[i] = name
				i = i + 1
			end
		end
	end

	for k, v in ipairs (RDXDAL.Friends) do
		RDXDAL.PalNames[v] = false
	end
end

WoWEvents:Bind("FRIENDLIST_UPDATE", nil, OnFriendguild_update);
WoWEvents:Bind("GUILD_ROSTER_UPDATE", nil, OnFriendguild_update);
