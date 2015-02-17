

local f = {};

function RDXMAP.Hud.Create(Parent)
	
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	local gopts = mbo.data
	f.GOpts = gopts
	
	-- Create player icon
	local hud = VFLUI.AcquireFrame("Frame");
	hud:SetParent(Parent);
	--m.PlyrFrm = plf
	--plf.NxMap = m

	hud:SetWidth (44)
	hud:SetHeight (44)

	local t = VFLUI.CreateTexture(hud)
	t:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Arrow")
	t:SetAllPoints (hud)
	t:Show();
	hud.texture = t
	
	local t = VFLUI.CreateTexture(hud)
	t:SetTexture ("Interface\\AddOns\\RDX\\Skin\\Arrow-UP")
	t:SetAllPoints (hud)
	t:Hide();
	hud.texture2 = t

	hud:SetPoint ("CENTER", Parent, "CENTER")
	hud:Hide()
	
	f.hud = hud;
	f.ButR, f.ButG, f.ButB, f.ButA = VFL.explodeHexNumberRGBA (gopts["HUDTButColor"])
	f.ButCR, f.ButCG, f.ButCB, f.ButCA = VFL.explodeHexNumberRGBA (gopts["HUDTButCombatColor"])

end

local twoPi = math.pi * 2


local myunit = {};
myunit.PlyrX = 0;
myunit.PlyrY = 0;
myunit.mapId = 13;
local gopts;
RDXEvents:Bind("INIT_POST", nil, function() 
	myunit = RDXDAL.GetMyUnit();
	local mbo = RDXDB.TouchObject("RDXDiskSystem:globals:mapmanager");
	gopts = mbo.data
end);	


function RDXMAP.Hud.Update()
	if #RDXMAP.Tracking > 0 and not gopts["HUDHide"] and not (RDX.InBG and gopts["HUDHideInBG"]) then
		local srcX = myunit.PlyrX
		local srcY = myunit.PlyrY
		local tr = RDXMAP.Tracking[1];
		local tarX = tr.x
		local tarY = tr.y
		f.hud:Show()
		local dx = (tarX - srcX) --* MininoteLib.Conversion[continentID][0].xscale;
		local dy = (tarY - srcY) --* MininoteLib.Conversion[continentID][0].yscale;
		--VFL.print(sqrt(dx * dx + dy * dy));
		--if (sqrt(dx * dx + dy * dy) > 1.2) then
			--local delta_x = (this.x - player_x) * MininoteLib.Conversion[continentID][currentZoom].xscale * (MininoteLib.isInside and MininoteLib.Conversion["isInside"][currentZoom] or 1);
			--local delta_y = (this.y - player_y) * MininoteLib.Conversion[continentID][currentZoom].yscale * (MininoteLib.isInside and MininoteLib.Conversion["isInside"][currentZoom] or 1);
			local rad_angle = math.atan2(dx, -dy);
			--VFL.print(rad_angle);
			--rad_angle = rad_angle
			if ( rad_angle > 0 ) then
				rad_angle = twoPi - rad_angle;
			else
				rad_angle = -rad_angle;
			end
			local player = GetPlayerFacing()
			--VFL.print(player);
			angle = rad_angle - player
			--local imageIndex = math.fmod(math.floor((-MapNotesMininote.playerModel:GetFacing() - rad_angle - math.rad(90))* 17.188733853924696263039446444232)+ 216, 108)
			local imageIndex = math.floor(angle / twoPi * 108 + 0.5) % 108
			local col, row = math.fmod(imageIndex, 9), math.floor(imageIndex/9);
			f.hud.texture:SetTexCoord(col*56/512, (col+1)*56/512, row*42/512, (row+1)*42/512);
			f.hud.texture:Show()
			--MapNotesMininoteWaypointArrow:Show();
			--MapNotesMininoteWaypointArrowUp:Hide();
		--else
		--	f.hud.texture:Hide()
		--end
	else
		f.hud:Hide()
	end
end

RDXEvents:Bind("INIT_DESKTOP", nil, function()
	VFLT.AdaptiveSchedule2("UpdateHUD", 0.05, function() 
		RDXMAP.Hud.Update()
	end);
end);

