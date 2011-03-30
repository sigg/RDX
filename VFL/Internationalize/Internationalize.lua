-- VFL.Internationalize.lua
-- @author OpenRDX
-- @description internationalize package

VFLI = RegisterVFLModule({
	name = "VFLI";
	description = "Internationalyze";
	parent = VFL;
});

local Locale = GetLocale();

local i18n_table = {};

--- Main function to translate a text
-- @param str The text to translate
-- @return The translated text or the initial text
function VFLI.i18n(str)
	if not str then return nil; end
	return i18n_table[str] or str;
end

function i18n(str)
	VFL.print("i18n is deprecated, replace by VFLI.i18n(str)");
	return VFLI.i18n(str);
end

--- Update the translate table, can be call many times
-- @param locale the locale of the pack (frFR or deDE)
-- @param data The table of translation text
function VFL.Internationalize(locale, data)
	if Locale == locale then
		-- Load the translations into the translation table
		for k,v in pairs(data) do i18n_table[k] = v; end
	end
	data = nil;
end

local packs_table = {};

function VFL.RegisterLanguagePack(tbl, locale)
	if (not tbl) or (not locale) then VFL.print("|cFFFF0000[VFL]|r Info : attempt to register anonymous Language Pack"); return; end
	if packs_table[locale] then VFL.print("|cFFFF0000[RDX]|r Info : Duplicate registration locale " .. locale); return; end
	packs_table[locale] = tbl;
end

function VFL.GetLanguagePackVersion()
	local locale = GetLocale();
	if packs_table[locale] then
		return packs_table[locale].version, locale;
	end
	return nil, locale;
end

