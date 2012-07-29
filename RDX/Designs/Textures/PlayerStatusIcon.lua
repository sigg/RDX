
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
