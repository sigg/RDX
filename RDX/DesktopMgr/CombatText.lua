

local fontl = nil;


-- ou


function RDXDK.SetCombatTextFont(font)
	fontl = font;
	--VFL.print(font.face);
	--if CombatText then
	--	for i, child in ipairs({CombatText:GetRegions()}) do
	--		VFLUI.SetFont(child, font, nil, true);
	--	end
	--end

end

function RDXDK.GetLockCombatTextFont()
	return VFL.copy(fontl);
end