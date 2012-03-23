-- OpenRDX
-- Sigg / Rashgarroth EU
-- by Aichi

RDX.RegisterTextureIcon({
	name = "Ready Check";
	title = VFLI.i18n("Ready Check");
	createCode = [[
btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Waiting");
]];
	paintCodeTest = [[
btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
btn:Show();
]];
	paintCode = [[
_meta = nil;
if IsRaidLeader() or IsRaidOfficer() or IsPartyLeader() then
	_meta = GetReadyCheckStatus(uid);
end
if _meta then
	if ( _meta == "ready" ) then
		btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready");
		if not btn:IsShown() then btn:Show(); end
	elseif ( _meta == "notready" ) then
		btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady");
		if not btn:IsShown() then btn:Show(); end
	elseif ( _meta == "waiting" ) then
		btn._t:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Waiting");
		if not btn:IsShown() then btn:Show(); end
	end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	event = "UNIT_READY_CHECK_UPDATE";
});

RDX.RegisterFeature({
	name = "Ready Check Icon"; version = 31338; invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "tex_icon";
		desc.class = "Ready Check";
	end;
});

