-- Assets.lua
-- VFL
-- (C)2007 Bill Johnson and the VFL Project.
--
-- Asset management for textures, fonts, backdrops and other reusable
-- UI types.

----------------------------------
-- FONT SYSTEM
----------------------------------
--- Font face database
local faces = {};
local sortedFaces = {};
function VFLUI.RegisterFontFace(path, name)
	if type(path) ~= "string" or type(name) ~= "string" then
		error("invalid arguments to RegisterFontFace");
	end
	if faces[path] then return; end -- dup reg
	faces[path] = name;
	-- Sorted faces list for menus.
	table.insert(sortedFaces, {path = path, name = name});
	table.sort(sortedFaces, function(x1,x2) return x1.name < x2.name; end);
end

function VFLUI._GetFontFaces() return sortedFaces; end
function VFLUI.GetFontFaceName(path) return faces[path]; end

function VFLUI.isFacePathExist(path)
	if (not path) or (not faces[path]) then return false; else return true end
end

--- Font descriptor database
Fonts = {};
FontObjects = {};
FontIndex = {};

function VFLUI.RegisterFont(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then
		error("Invalid argument to RegisterFont");
	end
	if Fonts[tbl.name] then
		error("Duplicate font registration for " .. tbl.name);
	end
	if type(tbl.face) ~= "string" then tbl.face = sortedFaces[1].path; end
	if type(tbl.size) ~= "number" then tbl.size = 12; end
	--if type(tbl.justifyH) ~= "string" then tbl.justifyH = "LEFT"; end
	--if type(tbl.justifyV) ~= "string" then tbl.justifyV = "CENTER"; end
	Fonts[tbl.name] = tbl;

	-- Also create a font object for use with buttons.
	local fo = CreateFont("zzz_" .. tbl.name);
	fo:SetFont(tbl.face, tbl.size, tbl.flags);
	if tbl.color then
		fo:SetTextColor(VFL.explodeRGBA(tbl.color));
	elseif tbl.cr then
		fo:SetTextColor(tbl.cr, tbl.cg, tbl.cb, tbl.ca);
	end
	if tbl.justifyH then
		fo:SetJustifyH(tbl.justifyH);
	end
	FontObjects[tbl.name] = fo;
	table.insert(FontIndex, {text = "Fonts." .. tbl.name});
end

function VFLUI._GetFontIndex() return FontIndex; end

--- Apply a font descriptor to a FontInstance.
function VFLUI.SetFont(obj, descr, sz, justify)
	if type(descr) ~= "table" then descr = Fonts.Default;	end
	if not VFLUI.isFacePathExist(descr.face) then descr.face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf"; end
	obj:SetFont(descr.face, (sz or descr.size or 10), descr.flags);
	if descr.sx then
		obj:SetShadowOffset(descr.sx or 0, descr.sy or 0);
		obj:SetShadowColor(descr.sr or 0, descr.sg or 0, descr.sb or 0, descr.sa or 1);
	else
		obj:SetShadowOffset(0,0);
	end
	if descr.cr then
		obj:SetTextColor(descr.cr or 1, descr.cg or 1, descr.cb or 1, descr.ca or 1);
	end
	if justify then
		obj:SetJustifyH(descr.justifyH or "LEFT"); obj:SetJustifyV(descr.justifyV or "CENTER");
	end
end

--- Generate the code that will apply a font descriptor to a FontInstance.
function VFLUI.GenerateSetFontCode(obj, descr, sz, justify)
	if type(descr) ~= "table" then descr = Fonts.Default;	end
	if not VFLUI.isFacePathExist(descr.face) then descr.face = "Interface\\Addons\\VFL\\Fonts\\LiberationSans-Regular.ttf"; end
	local ret = [[
]] .. obj .. ":SetFont(" .. string.format("%q", descr.face) .. ", " .. (sz or descr.size or 10);
	if descr.flags then ret = ret .. ", " .. string.format("%q", descr.flags); end
	ret = ret.. [[);
]];
	if descr.sx then
		ret = ret .. obj .. [[:SetShadowOffset(]] .. (descr.sx or 0) .. "," .. (descr.sy or 0) .. [[);
]] .. obj .. [[:SetShadowColor(]] .. (descr.sr or 0) .. "," .. (descr.sg or 0) .. "," .. (descr.sb or 0) .. "," .. (descr.sa or 1) .. [[);
]];
	else
		ret = ret .. obj .. [[:SetShadowOffset(0,0);
]];
	end
	if descr.cr and descr.cg and descr.cb and descr.ca then
		ret = ret .. obj .. [[:SetTextColor(]] .. (descr.cr or 1) .. "," .. (descr.cg or 1) .. "," .. (descr.cb or 1) .. "," .. (descr.ca or 1) .. [[);
]];
	end
	if justify then
		ret = ret .. obj .. [[:SetJustifyH("]] .. (descr.justifyH or "LEFT") .. [["); ]] .. obj .. [[:SetJustifyV("]] .. (descr.justifyV or "CENTER") .. [[");
]];
	end
	return ret;
end

--- COMPAT: compatibility with oldschool font api.
function VFLUI.GetFont(base, sz)
	return base, sz;
end

------------------------------------------------
-- TEXTURE SYSTEM
------------------------------------------------
local textures = {};
local texCategories = {};
local tcSorted = {};
local texByPath = {};
function VFLUI.RegisterTexture(tbl, fast)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then
		error("Invalid arguments to RegisterTexture()");
	end
	if not tbl.title then tbl.title = tbl.name; end
	if not tbl.category then tbl.category = "Uncategorized"; end
	if not tbl.dx then tbl.dx = 32; end
	if not tbl.dy then tbl.dy = 32; end
	if not tbl.blendMode then tbl.blendMode = "BLEND"; end
	if not texCategories[tbl.category] then 
		texCategories[tbl.category] = true; 
		table.insert(tcSorted, tbl.category); table.sort(tcSorted);
	end
	textures[tbl.name] = tbl;
	if tbl.path and (not fast) then texByPath[tbl.path] = tbl; end
end

function VFLUI.RegisterAbilIcon(class, title, path)
	VFLUI.RegisterTexture({
		name = string.gsub(title, "[^%w_]", "_");
		category = "Spells" .. ": " .. class;
		title = title;
		path = "Interface\\Icons\\" .. path;
		dx = 32; dy = 32;
	});
end

function VFLUI._AllTextures()
	return textures;
end

function VFLUI.GetTextureByPath(path)
	return texByPath[path];
end

function VFLUI.GetSortedTextureCategories()
	return tcSorted;
end

--- Copy only the UI-relevant portions of a texture object.
function VFLUI.CopyTexture(tex)
	local ret = {};
	if tex.color then ret.color = VFL.copy(tex.color); end
	if tex.path then ret.path = tex.path; end
	ret.blendMode = tex.blendMode;
	ret.gradDir = tex.gradDir;
	if tex.vertexColor then ret.vertexColor = VFL.copy(tex.vertexColor); end
	if tex.grad1 then ret.grad1 = VFL.copy(tex.grad1); end
	if tex.grad2 then ret.grad2 = VFL.copy(tex.grad2); end
	return ret;
end

--- Apply a texture descriptor to a Texture.
function VFLUI.SetTexture(obj, descr)
	if descr.color then
		obj:SetTexture(VFL.explodeRGBA(descr.color));
	elseif descr.path then
		obj:SetTexture(descr.path);
	else
		return;
	end
	obj:SetBlendMode(descr.blendMode);
	if descr.vertexColor then
		obj:SetVertexColor(VFL.explodeRGBA(descr.vertexColor));
	elseif descr.gradDir then
		local c = descr.grad1
		obj:SetGradientAlpha(descr.gradDir, c.r, c.g, c.b, c.a, VFL.explodeRGBA(descr.grad2));
	else
		obj:SetVertexColor(1,1,1,1);
	end
end

--- Generate the code that will apply a texture to a Texture object.
function VFLUI.GenerateSetTextureCode(obj, descr)
	local ret = "";
	if descr.color then
		local c = descr.color;
		ret = obj .. ":SetTexture(" .. c.r .. "," .. c.g .. "," .. c.b .. "," .. c.a .. "); ";
	elseif descr.path then
		ret = obj .. ":SetTexture(" .. string.format("%q", descr.path) .. "); ";
	end
	ret = ret .. obj .. ":SetBlendMode(" .. string.format("%q", descr.blendMode) .. "); ";
	if descr.vertexColor then
		local c = descr.vertexColor;
		ret = ret .. obj .. ":SetVertexColor(" .. c.r .. "," .. c.g .. "," .. c.b .. "," .. c.a .. [[);
]];
	elseif descr.gradDir then
		local c,c2 = descr.grad1, descr.grad2;
		ret = ret .. obj .. ":SetGradientAlpha('" .. descr.gradDir .. "'," .. c.r .. "," .. c.g .. "," .. c.b .. "," .. c.a .. "," .. c2.r .. "," .. c2.g .. "," .. c2.b .. "," .. c2.a .. [[);
]];

	else
		ret = ret .. obj .. [[:SetVertexColor(1,1,1,1);
]];
	end
	return ret;
end

--------------------------------
-- BUTTON SKINS
--------------------------------
local buttonskins = {};
local buttonskinsList = {};

function VFLUI.RegisterButtonSkin(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then
		error("Invalid arguments to RegisterButtonSkin()");
	end
	if not tbl.title then tbl.title = tbl.name; end
	-- Value and text fields for dropdowns
	tbl.value = tbl.name; tbl.text = tbl.name;
	buttonskins[tbl.name] = tbl;
	table.insert(buttonskinsList, tbl);
end

function VFLUI._AllButtonSkins()
	return buttonskins;
end

function VFLUI.GetButtonSkin(name)
	return buttonskins[name];
end

function VFLUI.GetButtonSkinList() return buttonskinsList; end
VFLUI.RegisterButtonSkin({ name = "bs_default"; title = "None"; });

-------------------------------------------------
-- COOLDOWN SYSTEM
-------------------------------------------------

local titadd = {
	{ text = "COOLDOWN&TEXT" },
	{ text = "COOLDOWN" },
	{ text = "TEXT" },
	{ text = "NONE" },
};
function VFLUI.TimerTypesDropdownFunction() return titadd; end

local tetadd = {
	{ text = "Largest" },
	{ text = "MinSec" },
	{ text = "Seconds" },
	{ text = "Tenths" },
	{ text = "Hundredths" },
};
function VFLUI.TextTypesDropdownFunction() return tetadd; end

local mapNTT = {
	["Largest"] = VFLT.Emm,
	["MinSec"] = VFLT.FormatMinSec,
	["Seconds"] = VFL.NumberFloor,
	["Tenths"] = VFL.Tenths,
	["Hundredths"] = VFL.Hundredths,
}
function VFLUI.GetTextTimerTypesFunction(name) return mapNTT[name] or VFLT.FormatMinSec; end

local mapNTS = {
	["Largest"] = "VFLT.Emm",
	["MinSec"] = "VFLT.FormatMinSec",
	["Seconds"] = "VFL.NumberFloor",
	["Tenths"] = "VFL.Tenths",
	["Hundredths"] = "VFL.Hundredths",
}
function VFLUI.GetTextTimerTypesString(name) return mapNTS[name] or "VFLT.FormatMinSec"; end

-------------------------------------------------
-- MINIMAP BLIP Texture
-------------------------------------------------
local blipTexture = {};

function VFLUI.RegisterBlipTexture(name, path)
	if blipTexture[name] then error("Duplicate BlipTexture registration " .. name); end
	blipTexture[name] = path;
	return true;
end;

function VFLUI.GetBlipTexture(name)
	return blipTexture[name];
end;

function VFLUI.GetListBlipTexture()
	local t = {};
	for k,_ in pairs(blipTexture) do
		table.insert(t, {text = k});
	end
	return t;
end;

-------------------------------------------------
-- MINIMAP MASK Texture
-------------------------------------------------
local maskTexture = {};

function VFLUI.RegisterMaskTexture(name, path)
	if maskTexture[name] then error("Duplicate MaskTexture registration " .. name); end
	maskTexture[name] = path;
	return true;
end;

function VFLUI.GetMaskTexture(name)
	return maskTexture[name];
end;

function VFLUI.GetListMaskTexture()
	local t = {};
	for k,_ in pairs(maskTexture) do
		table.insert(t, {text = k});
	end
	return t;
end;

-------------------------------------------------
-- BACKDROP SYSTEM
-------------------------------------------------
--------------- Registration for borders and backdrops
local backdropBorders = {};
local backdropBorderList = {};
function VFLUI.GetBackdropBorderTitle(name)
	local x = backdropBorders[name or "none"]; if not x then return "None"; end
	return x.title;
end
function VFLUI.GetBackdropBorderList() return backdropBorderList; end
function VFLUI.RegisterBackdropBorder(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then
		error("Invalid arguments to RegisterBackdropBorder()");
	end
	if not tbl.title then tbl.title = tbl.name; end
	-- Value and text fields for dropdowns
	tbl.value = tbl.name; tbl.text = tbl.title;

	backdropBorders[tbl.name] = tbl;
	table.insert(backdropBorderList, tbl);
end

local backdrops = {};
local backdropList = {};
function VFLUI.GetBackdropTitle(name) 
	local x = backdrops[name or "none"]; if not x then return "None"; end
	return x.title;
end
function VFLUI.GetBackdropList() return backdropList; end
function VFLUI.RegisterBackdrop(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then
		error("Invalid arguments to RegisterBackdrop()");
	end
	if not tbl.title then tbl.title = tbl.name; end
	-- Value and text fields for dropdowns
	tbl.value = tbl.name; tbl.text = tbl.title;

	backdrops[tbl.name] = tbl;
	table.insert(backdropList, tbl);
end

-------------- The empty "None" backdrops
VFLUI.RegisterBackdropBorder({ name = "none"; title = "None"; });
VFLUI.RegisterBackdrop({ name = "none"; title = "None"; });

-------------- Application
local function applyBorder(bkdp, border)
	bkdp.edgeFile = border.edgeFile;
	bkdp.edgeSize = border.edgeSize;
	if type(border.insets) == "table" then bkdp.insets = VFL.copy(border.insets); else bkdp.insets = nil; end
end

local function applyBackdrop(bkdp, bkmeta)
	bkdp.bgFile = bkmeta.bgFile; bkdp.tile = bkmeta.tile;
	if bkdp.tile then bkdp.tileSize = tonumber(bkmeta.tileSize) or 16; else bkdp.tileSize = nil; end
end

function VFLUI.ApplyBaseBackdrop(bkdp, border, backdrop)
	if border then
		bkdp._border = border or "none";
		border = backdropBorders[bkdp._border] or backdropBorders["none"];
		applyBorder(bkdp, border);
	end
	if backdrop then
		bkdp._backdrop = backdrop or "none";
		backdrop = backdrops[bkdp._backdrop] or backdrops["none"];
		applyBackdrop(bkdp, backdrop);
	end
end

function VFLUI.SetBackdrop(frame, bkdp)
	if (type(frame) ~= "table") or (type(bkdp) ~= "table") then return; end
	frame:SetBackdrop(bkdp);
	if bkdp.br then
		frame:SetBackdropBorderColor(bkdp.br or 1, bkdp.bg or 1, bkdp.bb or 1, bkdp.ba or 1);
	else
		frame:SetBackdropBorderColor(1,1,1,1);
	end
	if bkdp.kr then
		frame:SetBackdropColor(bkdp.kr or 1, bkdp.kg or 1, bkdp.kb or 1, bkdp.ka or 1);
	else
		frame:SetBackdropColor(1,1,1,1);
	end
end

-------------------------------
-- SOUND SYSTEM
-------------------------------
local sounds = {};
local soundList = {};
local function slsf(a,b) return a.title < b.title; end
function VFLUI.RegisterSound(name, title)
	if sounds[name] then return; end -- Prevent duplicate sound registration
	local x = { name = name, title = title };
	sounds[name] = x;
	table.insert(soundList, x);
	table.sort(soundList, slsf);
end

function VFLUI.GetSoundList() return soundList; end


