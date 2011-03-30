-- Fonts.lua
-- VFL - Venificus' Function Library
-- (C)2006 Bill Johnson (Venificus of Eredar server)
--
-- Registration for basic VFL fonts.

--- Font faces
VFLUI.RegisterFontFace("Fonts\\FRIZQT__.TTF", "Friz Quadrata TT");
VFLUI.RegisterFontFace("Fonts\\ARIALN.TTF", "Arial Narrow");
VFLUI.RegisterFontFace("Fonts\\MORPHEUS.TTF", "Morpheus");
VFLUI.RegisterFontFace("Fonts\\SKURRI.TTF", "Skurri");
VFLUI.RegisterFontFace("Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf", "LiberationSans");
VFLUI.RegisterFontFace("Interface\\Addons\\VFL\\Fonts\\LiberationSans-Bold.ttf", "LiberationSans Bold");
VFLUI.RegisterFontFace("Interface\\Addons\\VFL\\Fonts\\LiberationSans-Italic.ttf", "LiberationSans Italic");
VFLUI.RegisterFontFace("Interface\\Addons\\VFL\\Fonts\\LiberationSans-BoldItalic.ttf", "LiberationSans BoldItalic");
VFLUI.RegisterFontFace("Interface\\Addons\\VFL\\Fonts\\bs.ttf", "BastardusSans");
VFLUI.RegisterFontFace("Interface\\Addons\\VFL\\Fonts\\lucon.ttf", "Lucida Console");

--- Fonts
VFLUI.RegisterFont({
	name = "Default";
	title = "Default";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 12;
	flags = nil;
	color = {r=1,g=1,b=1};
	justifyH = "CENTER";
	justifyV = "CENTER";
});

VFLUI.RegisterFont({
	name = "DefaultRed";
	title = "Default";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 12;
	flags = nil;
	color = {r=1,g=0,b=0};
	justifyH = "CENTER";
	justifyV = "CENTER";
});

VFLUI.RegisterFont({
	name = "DefaultGreen";
	title = "Default";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 12;
	flags = nil;
	color = {r=0,g=1,b=0};
	justifyH = "CENTER";
	justifyV = "CENTER";
});

VFLUI.RegisterFont({
	name = "DefaultItalic";
	title = "Default Italic";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Italic.ttf";
	size = 12;
	flags = nil;
	color = {r=1,g=1,b=1};
});

VFLUI.RegisterFont({
	name = "Default10";
	title = "Default 10pt";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 10;
	flags = nil;
	color = {r=1,g=1,b=1};
});

VFLUI.RegisterFont({
	name = "Default8";
	title = "Default 8pt";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 8;
	flags = nil;
	color = {r=1,g=1,b=1};
});

VFLUI.RegisterFont({
	name = "Default6";
	title = "Default 6pt";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 6;
	flags = nil;
	color = {r=1,g=1,b=1};
});

VFLUI.RegisterFont({
	name = "DefaultShadowed";
	title = "Default Shadowed";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 12;
	flags = nil;
	color = {r=1,g=1,b=1};
	sx = 1; sy = -1; sr = 0; sg = 0; sb = 0; sa = 1;
});

VFLUI.RegisterFont({
	name = "Default8Shadowed";
	title = "Default Shadowed";
	face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf";
	size = 8;
	flags = nil;
	color = {r=1,g=1,b=1};
	sx = 1; sy = -1; sr = 0; sg = 0; sb = 0; sa = 1;
});

VFLUI.RegisterFont({
	name = "BastardusSans";
	title = "BastardusSans";
	face = "Interface\\Addons\\VFL\\Fonts\\bs.ttf";
	size = 12;
	flags = nil;
	color = {r=1,g=1,b=1};
});

VFLUI.RegisterFont({
	name = "Monospaced";
	title = "Monospaced";
	face = "Interface\\Addons\VFL\\Fonts\\lucon.ttf";
	size = 10;
	flags = nil;
	color = {r=1,g=1,b=1};
});

