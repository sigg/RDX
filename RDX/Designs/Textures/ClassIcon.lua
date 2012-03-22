
RDX.RegisterTextureIcon({
	name = "Class Round";
	title = VFLI.i18n("Class Round");
	createCode = [[
btn._t:SetTexture("Interface\\AddOns\\RDX\\Skin\\icon_class");
]];
	paintCodeTest = [[
if UnitIsPlayer(uid) then
	tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
	btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	paintCode = [[
if UnitIsPlayer(uid) then
	tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
	btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	event = "UNIT_FLAGS";
});

RDX.RegisterTextureIcon({
	name = "Class";
	title = VFLI.i18n("Class");
	createCode = [[
btn._t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
]];
	paintCodeTest = [[
if UnitIsPlayer(uid) then
	tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
	btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	paintCode = [[
if UnitIsPlayer(uid) then
	tempcolor = RDXMD.GetClassIcon(unit:GetClassMnemonic());
	btn._t:SetTexCoord(tempcolor[1], tempcolor[2], tempcolor[3], tempcolor[4]);
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	event = "UNIT_FLAGS";
});

RDX.RegisterFeature({
	name = "tex_class"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Class";
		desc.iconflag = nil;
	end;
});
