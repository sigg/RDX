-- Desktop_Basics.lua
-- OpenRDX
--
-- Main feature for Desktop objects.
--

RDX.RegisterFeature({
	name = "Desktop main",
	title = "Desktop";
	category = "Basics";
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if state:Slot("Desktop main") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then return nil; end
		--if not desc.title then
		--	VFL.AddError(errs, VFLI.i18n("Missing field"));
		--	return nil;
		--end
		state:AddSlot("Desktop main");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local useviewport = "nil"; if desc.viewport then useviewport = "true"; end
		if not desc.offsetleft then desc.offsetleft = 0; end
		if not desc.offsettop then desc.offsettop = 0; end
		if not desc.offsetright then desc.offsetright = 0; end
		if not desc.offsetbottom then desc.offsetbottom = 0; end
		
		if not desc.gametooltip then
			desc.gametooltip = {};
			desc.gametooltip.anchorx = 200;
			desc.gametooltip.anchory = 200;
			desc.gametooltip.bkd = { _bkdtype = 2; borl = 2; bors = 1; _border = "fer9"; bgFile = "Interface\\Addons\\VFL\\Skin\\black"; tileSize = 16; tile = true; _backdrop = "VFL_black"; edgeSize = 12; edgeFile = "Interface\\AddOns\\RDX_mediapack\\Ferous\\Borders\\fer9";};
			desc.gametooltip.font = { face = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\BigNoodleTitling.ttf"; justifyH = "LEFT"; size = 14; flags = "OUTLINE"; };
			desc.gametooltip.tex = { path = "Interface\\Addons\\RDX\\Skin\\bar1"; blendMode = "BLEND"; color = {r=1,g=1,b=1,a=1}; };
		end	
		local tooltipmouse = "nil"; if desc.gametooltip.tooltipmouse then tooltipmouse = "true"; end
		desc.anchorx = nil;
		desc.anchory = nil;
		desc.bkd = nil;
		desc.font = nil;
		desc.tex = nil;
		
		if not desc.realid then
			desc.realid = {};
			desc.realid.anchorxrid = 200;
			desc.realid.anchoryrid = 200;
		end
		desc.anchorxrid = nil;
		desc.anchoryrid = nil;
		
		if not desc.nameplates then
			desc.nameplates = {};
			desc.nameplates.bkd = { _bkdtype = 2; borl = 2; bors = 1; _border = "fer9"; bgFile = "Interface\\Addons\\VFL\\Skin\\white"; tileSize = 16; tile = true; _backdrop = "solid"; edgeSize =8; edgeFile = "Interface\\AddOns\\RDX_mediapack\\Ferous\\Borders\\fer9"; kr = 0; kg = 0; kb = 0; ka = 0.5};
			desc.nameplates.font = { face = "Interface\\Addons\\RDX_mediapack\\sharedmedia\\fonts\\BigNoodleTitling.ttf"; justifyH = "LEFT"; size = 14; flags = "OUTLINE"; };
			desc.nameplates.tex = { path = "Interface\\Addons\\RDX\\Skin\\bar1"; blendMode = "BLEND"; color = {r=1,g=1,b=1,a=1}; };
		end
		
		if not desc.nameplates.bkd then desc.nameplates.bkd = { _bkdtype = 2; borl = 2; bors = 1; _border = "fer9"; bgFile = "Interface\\Addons\\VFL\\Skin\\white"; tileSize = 16; tile = true; _backdrop = "solid"; edgeSize =8; edgeFile = "Interface\\AddOns\\RDX_mediapack\\Ferous\\Borders\\fer9"; kr = 0; kg = 0; kb = 0; ka = 0.5}; end
		
		if not desc.open then desc.open = true; end
		if not desc.root then desc.root = true; end
		if not desc.name then desc.name = "root"; end
		if not desc.dgp then desc.dgp = true; end
		if not desc.scale then desc.scale = 1; end
		if not desc.alpha then desc.alpha = 1; end
		if not desc.strata then desc.strata = "LOW"; end
		if not desc.ap then desc.ap = "TOPLEFT"; end
		
		if not desc.rdxiconx then desc.rdxiconx = 300; end
		if not desc.rdxicony then desc.rdxicony = 300; end
		if not desc.rdxmtxt then desc.rdxmtxt = "default"; end
		
		if not desc.topstack_props then desc.topstack_props = {512, 750, "TOP", "BOTTOM", .4, 1}; end
		if not desc.bottomstack_props then desc.bottomstack_props = {512, 450, "BOTTOM", "TOP", .9, 1}; end
		
		if not desc.ctffont then desc.ctffont = VFL.copy(Fonts.Default10); end
		
		if not desc.blizzard then
			desc.blizzard = {};
		end
		
		local _, _, auiname = RDXDB.ParsePath(RDXU.AUI);
		
		if not desc.states then
			desc.states = {};
			desc.states.SOLO = {};
			desc.states.SOLO.OnSelect = {};
			desc.states.SOLO.OnSelect.arena = {};
			desc.states.SOLO.OnSelect.arena.name = "RDXDiskTheme:" .. auiname .. ":Arena_Main";
			desc.states.SOLO.OnSelect.arena.action = "WINDOW_CLOSE";
			desc.states.SOLO.OnSelect.party = {};
			desc.states.SOLO.OnSelect.party.name = "RDXDiskTheme:" .. auiname .. ":Party_Main";
			desc.states.SOLO.OnSelect.party.action = "WINDOW_CLOSE";
			desc.states.SOLO.OnSelect.partytarget = {};
			desc.states.SOLO.OnSelect.partytarget.name = "RDXDiskTheme:" .. auiname .. ":Partytarget_Main";
			desc.states.SOLO.OnSelect.partytarget.action = "WINDOW_CLOSE";
			desc.states.SOLO.OnSelect.raid = {};
			desc.states.SOLO.OnSelect.raid.name = "RDXDiskTheme:" .. auiname .. ":Raid_Main";
			desc.states.SOLO.OnSelect.raid.action = "WINDOW_CLOSE";
			desc.states.SOLO.OnSelect.boss = {};
			desc.states.SOLO.OnSelect.boss.name = "RDXDiskTheme:" .. auiname .. ":Boss_Main";
			desc.states.SOLO.OnSelect.boss.action = "WINDOW_CLOSE";
			desc.states.PARTY = {};
			desc.states.PARTY.OnSelect = {};
			desc.states.PARTY.OnSelect.arena = {};
			desc.states.PARTY.OnSelect.arena.name = "RDXDiskTheme:" .. auiname .. ":Arena_Main";
			desc.states.PARTY.OnSelect.arena.action = "WINDOW_CLOSE";
			desc.states.PARTY.OnSelect.party = {};
			desc.states.PARTY.OnSelect.party.name = "RDXDiskTheme:" .. auiname .. ":Party_Main";
			desc.states.PARTY.OnSelect.party.action = "WINDOW_OPEN";
			desc.states.PARTY.OnSelect.partytarget = {};
			desc.states.PARTY.OnSelect.partytarget.name = "RDXDiskTheme:" .. auiname .. ":Partytarget_Main";
			desc.states.PARTY.OnSelect.partytarget.action = "WINDOW_OPEN";
			desc.states.PARTY.OnSelect.raid = {};
			desc.states.PARTY.OnSelect.raid.name = "RDXDiskTheme:" .. auiname .. ":Raid_Main";
			desc.states.PARTY.OnSelect.raid.action = "WINDOW_CLOSE";
			desc.states.PARTY.OnSelect.boss = {};
			desc.states.PARTY.OnSelect.boss.name = "RDXDiskTheme:" .. auiname .. ":Boss_Main";
			desc.states.PARTY.OnSelect.boss.action = "WINDOW_CLOSE";
			desc.states.RAID = {};
			desc.states.RAID.OnSelect = {};
			desc.states.RAID.OnSelect.arena = {};
			desc.states.RAID.OnSelect.arena.name = "RDXDiskTheme:" .. auiname .. ":Arena_Main";
			desc.states.RAID.OnSelect.arena.action = "WINDOW_CLOSE";
			desc.states.RAID.OnSelect.party = {};
			desc.states.RAID.OnSelect.party.name = "RDXDiskTheme:" .. auiname .. ":Party_Main";
			desc.states.RAID.OnSelect.party.action = "WINDOW_CLOSE";
			desc.states.RAID.OnSelect.partytarget = {};
			desc.states.RAID.OnSelect.partytarget.name = "RDXDiskTheme:" .. auiname .. ":Partytarget_Main";
			desc.states.RAID.OnSelect.partytarget.action = "WINDOW_CLOSE";
			desc.states.RAID.OnSelect.raid = {};
			desc.states.RAID.OnSelect.raid.name = "RDXDiskTheme:" .. auiname .. ":Raid_Main";
			desc.states.RAID.OnSelect.raid.action = "WINDOW_OPEN";
			desc.states.RAID.OnSelect.boss = {};
			desc.states.RAID.OnSelect.boss.name = "RDXDiskTheme:" .. auiname .. ":Boss_Main";
			desc.states.RAID.OnSelect.boss.action = "WINDOW_OPEN";
			desc.states.BATTLEGROUND = {};
			desc.states.BATTLEGROUND.OnSelect = {};
			desc.states.BATTLEGROUND.OnSelect.arena = {};
			desc.states.BATTLEGROUND.OnSelect.arena.name = "RDXDiskTheme:" .. auiname .. ":Arena_Main";
			desc.states.BATTLEGROUND.OnSelect.arena.action = "WINDOW_CLOSE";
			desc.states.BATTLEGROUND.OnSelect.party = {};
			desc.states.BATTLEGROUND.OnSelect.party.name = "RDXDiskTheme:" .. auiname .. ":Party_Main";
			desc.states.BATTLEGROUND.OnSelect.party.action = "WINDOW_CLOSE";
			desc.states.BATTLEGROUND.OnSelect.partytarget = {};
			desc.states.BATTLEGROUND.OnSelect.partytarget.name = "RDXDiskTheme:" .. auiname .. ":Partytarget_Main";
			desc.states.BATTLEGROUND.OnSelect.partytarget.action = "WINDOW_CLOSE";
			desc.states.BATTLEGROUND.OnSelect.raid = {};
			desc.states.BATTLEGROUND.OnSelect.raid.name = "RDXDiskTheme:" .. auiname .. ":Raid_Main";
			desc.states.BATTLEGROUND.OnSelect.raid.action = "WINDOW_OPEN";
			desc.states.BATTLEGROUND.OnSelect.boss = {};
			desc.states.BATTLEGROUND.OnSelect.boss.name = "RDXDiskTheme:" .. auiname .. ":Boss_Main";
			desc.states.BATTLEGROUND.OnSelect.boss.action = "WINDOW_CLOSE";
			desc.states.ARENA = {};
			desc.states.ARENA.OnSelect = {};
			desc.states.ARENA.OnSelect.arena = {};
			desc.states.ARENA.OnSelect.arena.name = "RDXDiskTheme:" .. auiname .. ":Arena_Main";
			desc.states.ARENA.OnSelect.arena.action = "WINDOW_OPEN";
			desc.states.ARENA.OnSelect.party = {};
			desc.states.ARENA.OnSelect.party.name = "RDXDiskTheme:" .. auiname .. ":Party_Main";
			desc.states.ARENA.OnSelect.party.action = "WINDOW_OPEN";
			desc.states.ARENA.OnSelect.partytarget = {};
			desc.states.ARENA.OnSelect.partytarget.name = "RDXDiskTheme:" .. auiname .. ":Partytarget_Main";
			desc.states.ARENA.OnSelect.partytarget.action = "WINDOW_OPEN";
			desc.states.ARENA.OnSelect.raid = {};
			desc.states.ARENA.OnSelect.raid.name = "RDXDiskTheme:" .. auiname .. ":Raid_Main";
			desc.states.ARENA.OnSelect.raid.action = "WINDOW_CLOSE";
			desc.states.ARENA.OnSelect.boss = {};
			desc.states.ARENA.OnSelect.boss.name = "RDXDiskTheme:" .. auiname .. ":Boss_Main";
			desc.states.ARENA.OnSelect.boss.action = "WINDOW_CLOSE";
		end
		
		state.Code:Clear();
		state.Code:AppendCode([[
DesktopEvents:Dispatch("WINDOW_OPEN", "root");
DesktopEvents:Dispatch("DESKTOP_VIEWPORT", ]] .. useviewport .. [[, ]] .. desc.offsetleft .. [[, ]] .. desc.offsettop .. [[, ]] .. desc.offsetright .. [[, ]] .. desc.offsetbottom .. [[);
DesktopEvents:Dispatch("DESKTOP_GAMETOOLTIP", ]] .. Serialize(desc.gametooltip) .. [[);
DesktopEvents:Dispatch("DESKTOP_REALID", ]] .. Serialize(desc.realid) .. [[);
DesktopEvents:Dispatch("DESKTOP_RDXICON_POSITION", ]] .. desc.rdxiconx .. [[, ]] .. desc.rdxicony .. [[);
DesktopEvents:Dispatch("DESKTOP_RDXICON_TYPE", ']] .. desc.rdxmtxt  .. [[');
DesktopEvents:Dispatch("DESKTOP_ALERTS", ]] .. Serialize(desc.topstack_props) .. [[, ]] .. Serialize(desc.bottomstack_props) .. [[);
DesktopEvents:Dispatch("DESKTOP_COMBATTEXT", ]] .. Serialize(desc.ctffont) .. [[);
DesktopEvents:Dispatch("DESKTOP_NAMEPLATE", ]] .. Serialize(desc.nameplates) .. [[);
DesktopEvents:Dispatch("DESKTOP_BLIZZARD", ]] .. Serialize(desc.blizzard) .. [[);
]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local title = VFLUI.LabeledEdit:new(ui, 200); title:Show();
		title:SetText(VFLI.i18n("Desktop Title"));
		if desc and desc.title then title.editBox:SetText(desc.title); end
		ui:InsertFrame(title);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("ViewPort")));
		
		local chk_viewport = VFLUI.Checkbox:new(ui); chk_viewport:Show();
		chk_viewport:SetText(VFLI.i18n("Activate Viewport"));
		if desc and desc.viewport then chk_viewport:SetChecked(true); else chk_viewport:SetChecked(); end
		ui:InsertFrame(chk_viewport);
		
		local offsettop = VFLUI.LabeledEdit:new(ui, 200); offsettop:Show();
		offsettop:SetText(VFLI.i18n("Offset Top"));
		if desc and desc.offsettop then offsettop.editBox:SetText(desc.offsettop); else offsettop.editBox:SetText("0"); end
		ui:InsertFrame(offsettop);
		
		local offsetleft = VFLUI.LabeledEdit:new(ui, 200); offsetleft:Show();
		offsetleft:SetText(VFLI.i18n("Offset Left"));
		if desc and desc.offsetleft then offsetleft.editBox:SetText(desc.offsetleft); else offsetleft.editBox:SetText("0"); end
		ui:InsertFrame(offsetleft);
		
		local offsetbottom = VFLUI.LabeledEdit:new(ui, 200); offsetbottom:Show();
		offsetbottom:SetText(VFLI.i18n("Offset Bottom"));
		if desc and desc.offsetbottom then offsetbottom.editBox:SetText(desc.offsetbottom); else offsetbottom.editBox:SetText("0"); end
		ui:InsertFrame(offsetbottom);
		
		local offsetright = VFLUI.LabeledEdit:new(ui, 200); offsetright:Show();
		offsetright:SetText(VFLI.i18n("Offset Right"));
		if desc and desc.offsetright then offsetright.editBox:SetText(desc.offsetright); else offsetright.editBox:SetText("0"); end
		ui:InsertFrame(offsetright);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Dock properties")));
		
		local n = 2; 
		if desk and desk.dock then n = #desk.dock + 1 end
		if desk and desk.dgp then n = n + 1 end
		local txtCurDock = VFLUI.SimpleText:new(ui, n, 200); txtCurDock:Show();
		local str = VFLI.i18n("Current Docks:\n");
		if desc.dock then
			for k,v in pairs(desc.dock) do
				str = str .. k .. ": " .. v.id .. "\n";
			end
		else
			str = str .. "(none)\n";
		end
		if desc.dgp then str = str ..  VFLI.i18n("This element is parent dock"); end
		
		txtCurDock:SetText(str);
		ui:InsertFrame(txtCurDock);
		
		
		--local l,t,r,b = VFLUI.GetUniversalBoundary(frame);
		
		--VFLUI.SetAnchorFramebyPosition(frame, ap, left, top, right, bottom)

		function ui:GetDescriptor()
			return {
				feature = "Desktop main";
				name = "root";
				title = title.editBox:GetText();
				--resolution = VFLUI.GetCurrentResolution();
				--scale = VFLUI.GetCurrentEffectiveScale();
				--perfectpixel = chk_perfectpixel:GetChecked();
				--vanchor = dd_vanchor:GetSelection();
				viewport = chk_viewport:GetChecked();
				offsettop = offsettop.editBox:GetText();
				offsetleft = offsetleft.editBox:GetText();
				offsetbottom = offsetbottom.editBox:GetText();
				offsetright = offsetright.editBox:GetText();
				gametooltip = desc.gametooltip;
				realid = desc.realid;
				nameplates = desc.nameplates;
				rdxiconx = desc.rdxiconx;
				rdxicony = desc.rdxicony;
				rdxmtxt = desc.rdxmtxt;
				topstack_props = desc.topstack_props;
				bottomstack_props = desc.bottomstack_props;
				blizzard = desc.blizzard;
				dock = desc.dock;
				dgp = desc.dgp;
				-- save position
				sp = desc.sp;
				-- states
				states = desc.states;
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Desktop main", name = "root", resolution = VFLUI.GetCurrentResolution(), scale = VFLUI.GetCurrentEffectiveScale()}; end
});

