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
