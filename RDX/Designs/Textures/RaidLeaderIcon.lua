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
