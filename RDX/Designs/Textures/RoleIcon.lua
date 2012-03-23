--
-- 3.3 role icon
--
RDX.RegisterTextureIcon({
	name = "Role";
	title = VFLI.i18n("Role");
	createCode = [[
btn._t:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES");
]];
	paintCodeTest = [[
btn._t:SetTexCoord(20/64, 39/64, 1/64, 20/64);
btn:Show();
]];
	paintCode = [[
_meta = UnitGroupRolesAssigned(uid);
if _meta == "TANK" then
	btn._t:SetTexCoord(0, 19/64, 22/64, 41/64);
	if not btn:IsShown() then btn:Show(); end
elseif _meta == "HEALER" then
	btn._t:SetTexCoord(20/64, 39/64, 1/64, 20/64);
	if not btn:IsShown() then btn:Show(); end
elseif _meta == "DAMAGER" then
	btn._t:SetTexCoord(20/64, 39/64, 22/64, 41/64);
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	event = "PARTY_MEMBERS_CHANGED";
});

RDX.RegisterFeature({
	name = "tex_role"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Role";
	end;
});
