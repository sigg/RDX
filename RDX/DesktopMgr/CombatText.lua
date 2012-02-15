

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

function RDXDK.debugCT()
	--local numchild = WorldFrame:GetNumChildren()
	--for i = 1, numchild do
	--	local frame = select(i, WorldFrame:GetChildren());
	--	VFL.print(frame:GetName());
	--end
	for i, child in ipairs({WorldFrame:GetRegions()}) do
		VFL.print(child:GetName());
	end
end

-- /script RDXDK.debugCT();