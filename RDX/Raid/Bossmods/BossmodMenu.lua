-- BossmodMenu.lua
-- OpenRDX
--

--[[
RDXPM.RegisterMainButton({
	name = "bossmods";
	id = 10;
	btype = "custom";
	title = VFLI.i18n("Bossmods");
	desc = VFLI.i18n("Open Encounter Panel");
	texture = "Interface\\Addons\\RDX\\Skin\\boomy\\burn";
	toggletexture = "Interface\\Addons\\RDX\\Skin\\boomy\\burn";
	IsToggle = RDX.IsEncounterPaneShow;
	OnClick = RDX.ToggleEncounterPane;
});
]]
