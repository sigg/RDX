-- Obj_ActionBindings.lua
-- OpenRDX
--
-- Code from SpellBinder by Nymbia

RDXKB = RegisterVFLModule({
	name = "RDXKB";
	title = VFLI.i18n("RDX Key Bindings Object");
	description = VFLI.i18n("RDX Desktop GUI Editor");
	version = {1,0,0};
	parent = RDX;
});

---------------------------------------------------------
-- Helpers
---------------------------------------------------------

local currentKeyBindings = nil;
local currentpath = nil;

local keys = {
	'ESCAPE', "`", 'TAB', '²', 'SPACE', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S',
	'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '-', '=', '[', ']', ')',
	'\\', ';', "'", '.', '/', ',', 'ENTER', 'MOUSEWHEELUP', 'MOUSEWHEELDOWN', 'BACKSPACE', 'DELETE',
	'INSERT', 'HOME', 'END', 'PAGEUP', 'PAGEDOWN', 'NUMLOCK', 'NUMPADSLASH', 'NUMPADMULTIPLY', 'NUMPADMINUS',
	'NUMPADPLUS', 'NUMPADENTER', 'NUMPADPERIOD',
}
for i = 0, 9 do
	keys[#keys+1] = tostring(i);
	keys[#keys+1] = 'NUMPAD' .. i;
end
for i = 1, 12 do
	keys[#keys+1] = 'F' .. i;
end
for i = 1, 10 do
	keys[#keys+1] = 'BUTTON' .. i;
end

local modifiers = {
	'', 'ALT-', 'CTRL-', 'SHIFT-', 'ALT-CTRL-', 'ALT-SHIFT-', 'CTRL-SHIFT-', 'ALT-CTRL-SHIFT-',
}

local function SaveKeyBindings(keylist)
	for _, modifier in ipairs(modifiers) do
		for _, key in ipairs(keys) do
			local action = GetBindingAction(modifier..key);
			if action and action ~= "" then
				keylist[modifier..key] = action;
			end
		end
	end
end

local function LoadKeyBindings(keylist)
	for k, v in pairs(keylist) do
		local key1, key2 = GetBindingKey(v);
		if key1 then SetBinding(key1); end
		if key2 then SetBinding(key2); end
		SetBinding(k, v);
	end
	if GetCurrentBindingSet() then
		SaveBindings(GetCurrentBindingSet());
	end
end

-- libkey bound to short
function RDXKB.ToShortKey(key)
	key = key:upper();
	key = key:gsub(" ", "");
	key = key:gsub("ALT%-", "A");
	key = key:gsub("CTRL%-", "C");
	key = key:gsub("SHIFT%-", "S");

	key = key:gsub("NUMPAD", "N");

	key = key:gsub("BACKSPACE", "BS");
	key = key:gsub("PLUS", "%+");
	key = key:gsub("MINUS", "%-");
	key = key:gsub("MULTIPLY", "%*");
	key = key:gsub("DIVIDE", "%/");
	key = key:gsub("HOME", "HN");
	key = key:gsub("INSERT", "Ins");
	key = key:gsub("DELETE", "Del");
	key = key:gsub("BUTTON1", "M1");
	key = key:gsub("BUTTON2", "M2");
	key = key:gsub("BUTTON3", "M3");
	key = key:gsub("BUTTON4", "M4");
	key = key:gsub("BUTTON5", "M5");
	key = key:gsub("BUTTON6", "M6");
	key = key:gsub("BUTTON7", "M7");
	key = key:gsub("BUTTON8", "M8");
	key = key:gsub("BUTTON9", "M9");
	key = key:gsub("BUTTON10", "M10");
	key = key:gsub("MOUSEWHEELDOWN", "WD");
	key = key:gsub("MOUSEWHEELUP", "WU");
	key = key:gsub("PAGEDOWN", "PD");
	key = key:gsub("PAGEUP", "PU");

	return key
end

--------------------------------------------------------
-- KeyBindings object
--------------------------------------------------------

RDXKB.KeyBindings = {};
function RDXKB.KeyBindings:new(parent)
	local self = VFLUI.AcquireFrame("Frame");
	self:SetParent(parent or VFLDIALOG);
	
	function self:LoadKB(keylist)
		LoadKeyBindings(keylist);
	end
	
	function self:SaveKB(keylist)
		SaveKeyBindings(keylist);
	end
	
	self.Destroy = VFL.hook(function(s)
		s.LoadKB = nil; s.SaveKB = nil
	end, self.Destroy);
	
	return self;
end

local function EditKeyBindings(path, md, parent)
	--TODO
end

-- The Window object type.
RDXDB.RegisterObjectType({
	name = "KeyBindings",
	version = 1,
	New = function(path, md)
		md.version = 1;
		md.data = {};
		SaveKeyBindings(md.data);
	end,
	Edit = function(path, md, parent)
		if currentpath == path then
			EditKeyBindings(path, md, parent);
		else
			RDX.printW("Edit only active KB");
		end
	end,
	Instantiate = function(path, obj)
		if currentKeyBindings then RDX.printI("a key bindings is already instantiated"); return nil; end
		local kb = RDXKB.KeyBindings:new(parent);
		-- Set the path
		kb._path = path;
		currentpath = path;
		-- Setup desktop
		kb:LoadKB(obj.data);
		return kb;
	end,
	Deinstantiate = function(instance, path, obj, nosave)
		if not nosave then instance:SaveKB(obj.data); end
		instance:Destroy();
		instance._path = nil;
		instance = nil;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		--table.insert(mnu, {
		--	text = VFLI.i18n("Edit..."),
		--	OnClick = function()
		--		VFL.poptree:Release();
		--		RDXDB.OpenObject(path, "Edit", dlg);
		--	end
		--});
	end,
});

local tblink = {};
tblink["ACTIONBUTTON1"] = "VFLButton1";
tblink["ACTIONBUTTON2"] = "VFLButton2";
tblink["ACTIONBUTTON3"] = "VFLButton3";
tblink["ACTIONBUTTON4"] = "VFLButton4";
tblink["ACTIONBUTTON5"] = "VFLButton5";
tblink["ACTIONBUTTON6"] = "VFLButton6";
tblink["ACTIONBUTTON7"] = "VFLButton7";
tblink["ACTIONBUTTON8"] = "VFLButton8";
tblink["ACTIONBUTTON9"] = "VFLButton9";
tblink["ACTIONBUTTON10"] = "VFLButton10";
tblink["ACTIONBUTTON11"] = "VFLButton11";
tblink["ACTIONBUTTON12"] = "VFLButton12";
tblink["MULTIACTIONBAR4BUTTON1"] = "VFLButton25";
tblink["MULTIACTIONBAR4BUTTON2"] = "VFLButton26";
tblink["MULTIACTIONBAR4BUTTON3"] = "VFLButton27";
tblink["MULTIACTIONBAR4BUTTON4"] = "VFLButton28";
tblink["MULTIACTIONBAR4BUTTON5"] = "VFLButton29";
tblink["MULTIACTIONBAR4BUTTON6"] = "VFLButton30";
tblink["MULTIACTIONBAR4BUTTON7"] = "VFLButton31";
tblink["MULTIACTIONBAR4BUTTON8"] = "VFLButton32";
tblink["MULTIACTIONBAR4BUTTON9"] = "VFLButton33";
tblink["MULTIACTIONBAR4BUTTON10"] = "VFLButton34";
tblink["MULTIACTIONBAR4BUTTON11"] = "VFLButton35";
tblink["MULTIACTIONBAR4BUTTON12"] = "VFLButton36";
tblink["MULTIACTIONBAR3BUTTON1"] = "VFLButton37";
tblink["MULTIACTIONBAR3BUTTON2"] = "VFLButton38";
tblink["MULTIACTIONBAR3BUTTON3"] = "VFLButton39";
tblink["MULTIACTIONBAR3BUTTON4"] = "VFLButton40";
tblink["MULTIACTIONBAR3BUTTON5"] = "VFLButton41";
tblink["MULTIACTIONBAR3BUTTON6"] = "VFLButton42";
tblink["MULTIACTIONBAR3BUTTON7"] = "VFLButton43";
tblink["MULTIACTIONBAR3BUTTON8"] = "VFLButton44";
tblink["MULTIACTIONBAR3BUTTON9"] = "VFLButton45";
tblink["MULTIACTIONBAR3BUTTON10"] = "VFLButton46";
tblink["MULTIACTIONBAR3BUTTON11"] = "VFLButton47";
tblink["MULTIACTIONBAR3BUTTON12"] = "VFLButton48";
tblink["MULTIACTIONBAR1BUTTON1"] = "VFLButton49";
tblink["MULTIACTIONBAR1BUTTON2"] = "VFLButton50";
tblink["MULTIACTIONBAR1BUTTON3"] = "VFLButton51";
tblink["MULTIACTIONBAR1BUTTON4"] = "VFLButton52";
tblink["MULTIACTIONBAR1BUTTON5"] = "VFLButton53";
tblink["MULTIACTIONBAR1BUTTON6"] = "VFLButton54";
tblink["MULTIACTIONBAR1BUTTON7"] = "VFLButton55";
tblink["MULTIACTIONBAR1BUTTON8"] = "VFLButton56";
tblink["MULTIACTIONBAR1BUTTON9"] = "VFLButton57";
tblink["MULTIACTIONBAR1BUTTON10"] = "VFLButton58";
tblink["MULTIACTIONBAR1BUTTON11"] = "VFLButton59";
tblink["MULTIACTIONBAR1BUTTON12"] = "VFLButton60";
tblink["MULTIACTIONBAR2BUTTON1"] = "VFLButton61";
tblink["MULTIACTIONBAR2BUTTON2"] = "VFLButton62";
tblink["MULTIACTIONBAR2BUTTON3"] = "VFLButton63";
tblink["MULTIACTIONBAR2BUTTON4"] = "VFLButton64";
tblink["MULTIACTIONBAR2BUTTON5"] = "VFLButton65";
tblink["MULTIACTIONBAR2BUTTON6"] = "VFLButton66";
tblink["MULTIACTIONBAR2BUTTON7"] = "VFLButton67";
tblink["MULTIACTIONBAR2BUTTON8"] = "VFLButton68";
tblink["MULTIACTIONBAR2BUTTON9"] = "VFLButton69";
tblink["MULTIACTIONBAR2BUTTON10"] = "VFLButton70";
tblink["MULTIACTIONBAR2BUTTON11"] = "VFLButton71";
tblink["MULTIACTIONBAR2BUTTON12"] = "VFLButton72";

-- call this function to move key from Blizzard to VFL at init
function RDXKB.Init()
	-- test the key of the ActionBUTTON 1
	if not InCombatLockdown() then
		local keyflag = GetBindingKey("ACTIONBUTTON1");
		if keyflag then
			local key1, key2;
			for k,v in pairs(tblink) do
				if _G[v] then
					key1, key2 = GetBindingKey(k);
					if key2 then SetBinding(key2); end
					if key1 then SetBinding(key1); SetBindingClick(key1, v); end
				end
			end
			--if GetCurrentBindingSet() then
				SaveBindings(GetCurrentBindingSet());
			--end
		end
	end
end

