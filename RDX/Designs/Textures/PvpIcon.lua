--
-- PVP Icon
--

RDX.RegisterTextureIcon({
	name = "PVP";
	title = VFLI.i18n("PVP");
	createCode = [[
]];
	paintCodeTest = [[
tempcolor = RDXMD.GetPVPIcon("FFA");
btn._t:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
btn:Show();
]];
	paintCode = [[
if UnitIsPVP(uid) then
	_meta = UnitFactionGroup(uid);
	if UnitIsPVPFreeForAll(uid) then _meta = "FFA"; end
	if _meta then 
		tempcolor = RDXMD.GetPVPIcon(_meta);
		btn._t:SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. _meta);
		btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
		if not btn:IsShown() then btn:Show(); end
	else
		if btn:IsShown() then btn:Hide(); end
	end
else
	if btn:IsShown() then btn:Hide(); end
end;
]];
	event = "UNIT_FACTION";
});

RDX.RegisterFeature({
	name = "tex_pvp2"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "PVP";
	end;
});
