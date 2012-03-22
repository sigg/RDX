
RDX.RegisterTextureIcon({
	name = "Master Looter";
	title = VFLI.i18n("Master Looter");
	createCode = [[
btn._t:SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter");
]];
	paintCodeTest = [[
if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
_name, _meta = nil, nil;
_, _tl, _et = GetLootMethod();
if _et then
	if unit.rosterName then
		_name = unit.rosterName;
	else
		_name = UnitName(uid);
	end
	if (_name == GetUnitByNumber(_et).rosterName) then
		if not btn:IsShown() then btn:Show(); end
	else
		if btn:IsShown() then btn:Hide(); end
	end
elseif _tl then
	_name = UnitName(uid);
	_meta = UnitName("party" .. _tl);
	myunit = RDXDAL.GetMyUnit();
	if (_tl == 0) and (myunit.rosterName == _name) then
		if not btn:IsShown() then btn:Show(); end
	elseif (_name == _meta) then
		if not btn:IsShown() then btn:Show(); end
	else
		if btn:IsShown() then btn:Hide(); end
	end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	event = "UNIT_FLAGS";
});


RDX.RegisterFeature({
	name = "Master Looter Icon"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Master Looter";
	end;
});
