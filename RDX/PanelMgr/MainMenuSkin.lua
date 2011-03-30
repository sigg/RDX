-- MainMenuSkin

local mmskin = {};
local mmskinIndex = {};
function RDX.RegisterMainMenuSkin(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if mmskin[tbl.name] then RDX.printW("Attempt to register duplicate Skin name " .. tbl.name); return; end
	mmskin[tbl.name] = tbl;
	table.insert(mmskinIndex, {value = tbl.name, text = tbl.name});
	table.sort(mmskinIndex, function(x1,x2) return x1.text < x2.text; end);
end
function RDX.GetMainMenuSkins() return mmskinIndex; end

function RDX.IsMMSkinValid(name)
	if mmskin[name] then return true; else return nil; end
end

function RDX.GetSkin(name)
	return mmskin[name];
end

RDX.RegisterMainMenuSkin({
	name = "Crystal";
	solo = "Interface\\Addons\\RDX\\Skin\\crystal\\solo";
	multi = "Interface\\Addons\\RDX\\Skin\\crystal\\multi";
	ui = "Interface\\Addons\\RDX\\Skin\\crystal\\ui";
	database = "Interface\\Addons\\RDX\\Skin\\crystal\\database";
	settings = "Interface\\Addons\\RDX\\Skin\\crystal\\settings";
});

RDX.RegisterMainMenuSkin({
	name = "Kcori";
	solo = "Interface\\Addons\\RDX\\Skin\\kcori\\solo";
	multi = "Interface\\Addons\\RDX\\Skin\\kcori\\multi";
	ui = "Interface\\Addons\\RDX\\Skin\\kcori\\ui";
	database = "Interface\\Addons\\RDX\\Skin\\kcori\\database";
	settings = "Interface\\Addons\\RDX\\Skin\\kcori\\settings";
});

RDX.RegisterMainMenuSkin({
	name = "Upojenie";
	solo = "Interface\\Addons\\RDX\\Skin\\upojenie\\solo";
	multi = "Interface\\Addons\\RDX\\Skin\\upojenie\\multi";
	ui = "Interface\\Addons\\RDX\\Skin\\upojenie\\ui";
	database = "Interface\\Addons\\RDX\\Skin\\upojenie\\database";
	settings = "Interface\\Addons\\RDX\\Skin\\upojenie\\settings";
});