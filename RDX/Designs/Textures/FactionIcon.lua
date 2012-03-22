
RDX.RegisterTextureIcon({
	name = "Faction";
	title = VFLI.i18n("Faction");
	createCode = [[
]];
	paintCodeTest = [[
]];
	paintCode = [[
_apps, _meta = nil, nil;
if UnitIsPVPFreeForAll(uid) then 
	_apps = "FFA";
else
	_meta = UnitFactionGroup(uid);
	if _meta then _apps = _meta; end
end
if _apps then
	tempcolor = RDXMD.GetPVPIcon(_apps);
	btn._t:SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. _apps);
	btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	event = "UNIT_FACTION";
});

RDX.RegisterFeature({
	name = "tex_pvp"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Faction";
	end;
});

