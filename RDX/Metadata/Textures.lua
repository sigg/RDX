-------- Texture registration
------------------------------
-- BAR TEXTURES
------------------------------
VFLUI.RegisterTexture({
	name = "blizzard_bar";
	category = VFLI.i18n("SB (Horiz)");
	title = VFLI.i18n("Blizzard");
	path = "Interface\\TargetingFrame\\UI-StatusBar";
	dx = 256; dy = 32;
});

VFLUI.RegisterTexture({
	name = "rdx_bar1";
	category = VFLI.i18n("SB (Horiz)");
	title = VFLI.i18n("Beveled");
	path = "Interface\\Addons\\RDX\\Skin\\bar1";
	dx = 256; dy = 32;
});

VFLUI.RegisterTexture({
	name = "rdx_barsmooth";
	category = VFLI.i18n("SB (Horiz)");
	title = VFLI.i18n("Smooth");
	path = "Interface\\Addons\\RDX\\Skin\\bar_smooth";
	dx = 256; dy = 32;
});

VFLUI.RegisterTexture({
	name = "rdx_barhoutline";
	category = VFLI.i18n("SB (Horiz)");
	title = VFLI.i18n("Half Outline");
	path = "Interface\\Addons\\RDX\\Skin\\bar_halfoutline";
	dx = 256; dy = 32;
});

VFLUI.RegisterTexture({
	name = "rdx_bar1vert";
	category = VFLI.i18n("SB (Vert)");
	title = VFLI.i18n("Beveled");
	path = "Interface\\Addons\\RDX\\Skin\\vbar1";
	dx = 32; dy = 256;
});

VFLUI.RegisterTexture({
	name = "rdx_barhoutlinevert";
	category = VFLI.i18n("SB (Vert)");
	title = VFLI.i18n("Half Outline");
	path = "Interface\\Addons\\RDX\\Skin\\vbar_halfoutline";
	dx = 32; dy = 256;
});

------------------------------------
-- ICONS
------------------------------------
local function ricon(title, path)
	VFLUI.RegisterTexture({
		name = "rdxi_" .. string.gsub(title, "[^%w_]", "_");
		category = VFLI.i18n("RDX Icons");
		title = VFLI.i18n(title);
		path = "Interface\\Addons\\RDX\\Skin\\" .. path;
		dx = 32; dy = 32;
	});
end
ricon("Crosshair", "crosshair");
ricon("Desktop Picker", "desktop");
ricon("Disk", "disk2");
ricon("Folder", "folder");
ricon("Funnel", "funnel");
ricon("Menu", "menu");
ricon("Minimize", "minimize");
ricon("Play", "play");
ricon("Play_I", "play_i");
ricon("Speaker", "speaker");
ricon("Stop", "stop");
ricon("Sync", "sync");
ricon("X", "x");
ricon("Skull", "skull");
