

local fontl = nil;


-- ou

--local btn = VFLUI.AcquireFrame("BlizzardElement", "CombatText");
--if btn then
--	for i, child in ipairs({btn:GetRegions()}) do
--		VFLUI.SetFont(child, descr, nil, true);
--	end
--end

function RDXDK.SetCombatTextFont(font)
	fontl = font;
	VFLUI.SetFont(CombatText1, font, nil, true);
	VFLUI.SetFont(CombatText2, font, nil, true);
	VFLUI.SetFont(CombatText3, font, nil, true);
	VFLUI.SetFont(CombatText4, font, nil, true);
	VFLUI.SetFont(CombatText5, font, nil, true);
	VFLUI.SetFont(CombatText6, font, nil, true);
	VFLUI.SetFont(CombatText7, font, nil, true);
	VFLUI.SetFont(CombatText8, font, nil, true);
	
end

function RDXDK.GetLockCombatTextFont()
	return VFL.copy(fontl);
end