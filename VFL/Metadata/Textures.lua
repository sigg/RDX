---------- Icons
local function ricon(title, path, dx, dy)
	VFLUI.RegisterTexture({
		name = "vfli_" .. string.gsub(title, "[^%w_]", "_");
		category = "VFL Icons";
		title = title;
		path = "Interface\\Addons\\VFL\\Skin\\" .. path;
		dx = dx or 32; dy = dy or 32;
	});
end
ricon("Magnifier", "mag_glass");
ricon("Checkerboard", "checker");
ricon("Minus", "minus");
ricon("Plus", "plus");
ricon("Up", "sb_up", 16, 16);
ricon("Down", "sb_down", 16, 16);
ricon("Left", "sb_left", 16, 16);
ricon("Right", "sb_right", 16, 16);
ricon("X", "x");
ricon("Font Picker", "fontsel");

---------- All blizz icons
for i=1,GetNumMacroIcons() do
	local name = string.format("bicon%03d", i);
	VFLUI.RegisterTexture({
		name = name;
		category = "All Blizzard Icons";
		title = name;
		path = GetMacroIconInfo(i);
		dx=32; dy=32;
	}, true);
end

----------- Highlights
VFLUI.RegisterTexture({
	name = "hlt_QuestTitleHighlight";
	category = "Highlights";
	title = "Default Blizzard";
	path = "Interface\\QuestFrame\\UI-QuestTitleHighlight";
	dx = 256; dy = 32;
});

----------- Backdrops
VFLUI.RegisterBackdropBorder({
	name = "straight"; title = "Straight";
	edgeFile = "Interface\\Addons\\VFL\\Skin\\straight-border"; edgeSize = 8;
	insets = { left = 2, right = 2, top = 2, bottom = 2};
});

VFLUI.RegisterBackdropBorder({
	name = "tooltip"; title = "Tooltip";
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border"; edgeSize = 16;
	insets = { left = 4, right = 4, top = 4, bottom = 4};
});

VFLUI.RegisterBackdropBorder({
	name = "dialog"; title = "WoW Dialog";
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border"; edgeSize = 16;
	insets = { left = 4, right = 4, top = 4, bottom = 4};
});

VFLUI.RegisterBackdrop({
	name = "solid"; title = "Solid Color";
	bgFile = "Interface\\Addons\\VFL\\Skin\\white"; tile = false;
});

VFLUI.RegisterBackdrop({
	name = "checker"; title = "Checkerboard";
	bgFile = "Interface\\Addons\\VFL\\Skin\\checker"; tile = true; tileSize = 10;
});
