-- AbilityTrackWindow.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics

------------------------------------------------------------------------
-- GUI Bossmods module for RDX
--   By: Trevor Madsen (Gibypri, Kilrogg realm)
--
-- Note:
--  Licensed exclusively to Raid Informatics
------------------------------------------------------------------------

local track_window, ca;

local function CreateEventFeature(src, ability, alrtType, ty, ids)
	local rpc, devent, omnirow = true, "OMNI_"..ability, "DamageIn";
	if ty == 2 then
		omnirow = "+Debuff";
	elseif ty == 3 then
		omnirow = "+BuffMob";
		devent = devent.."_Buff";
	elseif alrtType == "cp" then
		rpc = false;
		omnirow = "CastMob";
		devent = devent.."_Cast";
	end
	local data = {
		feature = "Event: Omniscience";
		devent = devent;
		bevent = "OMNI";
		omnirow = omnirow;
		omniabiName = ability;
		omniabiID = ids;
		lockout = 2;
		rpc = rpc;
	};		
	return data;
end

-- return event: Omniscience and alert: dropdown feature data
local function CreateDropdownPair(src, ability, cooldown, ty, ids)
	local edata = CreateEventFeature(src, ability, "dd", ty, ids);
	local adata = {
		bevent = "OMNI_"..ability;
		totaltime = cooldown;
		quashevent = "";
		feature = "Alert: Dropdown";
		fstColor = { r=1,g=1,b=1 };
		scdColor = { r=1,g=1,b=1 };
		title = ability;
		selfquash = true;
		sTime = 5;
		sound = "Sound\\Doodad\\BellTollAlliance.wav"
	}
	return edata, adata;
end

-- return event: Omniscience and alert: centerpopup feature data
local function CreateCenterPopupPair(src, ability, ct, ty, ids)
	local edata = CreateEventFeature(src, ability, "cp", ty, ids);
	local adata = {
		bevent = "OMNI_"..ability.."_Cast";
		totaltime = ct;
		quashevent = "";
		feature = "Alert: CenterPopup";
		fstColor = { r=1,g=1,b=1 };
		scdColor = { r=1,g=1,b=1 };
		title = ability;
		selfquash = true;
		sTime = ct;
		spam = true; -- usually want to suppress spam for these
		sound = "Sound\\Doodad\\BellTollAlliance.wav"
	}
	return edata, adata;
end

-- return event: Omniscience and alert: centerpopup feature data
local function CreateAlertPopupPair(src, ability, ct, ty, ids)
	local edata = CreateEventFeature(src, ability, "cp", ty, ids);
	local adata = {
		bevent = "OMNI_"..ability.."_Buff";
		totaltime = 2;
		delay = 2;
		feature = "Alert: Simple";
		title = ability;
		selfquash = true;
		spam = true; -- usually want to suppress spam for these
		sound = "Sound\\Doodad\\BellTollAlliance.wav"
	}
	return edata, adata;
end

local function CleanFontString(txt)
	txt:Hide(); txt:SetParent(VFLOrphan); txt:ClearAllPoints(); txt:SetAlpha(1);
	txt:SetHeight(0); txt:SetWidth(0);
	txt:SetFontObject(GameFontNormal);
	txt:SetTextColor(1,1,1,1);
	txt:SetJustifyH("CENTER"); txt:SetJustifyV("CENTER");
	txt:SetText("");
end

-- return event: Omniscience and alert: centerpopup feature data
local function AbilityFontString(parent)
	local txt = VFLUI.CreateFontString(parent);
	txt:SetHeight(16); txt:SetWidth(150);
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 16));
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP");
	txt.Set = function(self, ability)
		self:SetText(VFL.strcolor(.7,0,.6)..ability);
	end;
	
	txt.Destroy = function(self)
		CleanFontString(self);
	end
	
	return txt;
end

local function CooldownFontString(parent)
	local txt = VFLUI.CreateFontString(parent);
	txt:SetHeight(12); txt:SetWidth(150);
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP");
	txt:SetText("     "..VFL.strcolor(0,.8,1).."Cooldowns");
	
	local prefix = "          "..VFL.strcolor(0,.6,.8);
	
	txt.mn = VFLUI.CreateFontString(parent);
	txt.mn:SetPoint("TOPLEFT", txt, "BOTTOMLEFT");
	txt.mn:SetHeight(12); txt.mn:SetWidth(150);
	txt.mn:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	txt.mn:SetJustifyH("LEFT"); txt.mn:SetJustifyV("TOP");
	txt.mn.Set = function(self, mn)
		self:SetText(prefix.."Min: "..VFL.strcolor(1,1,1)..mn.."s");
	end
	
	txt.md = VFLUI.CreateFontString(parent);
	txt.md:SetPoint("TOPLEFT", txt.mn, "BOTTOMLEFT");
	txt.md:SetHeight(12); txt.md:SetWidth(150);
	txt.md:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	txt.md:SetJustifyH("LEFT"); txt.md:SetJustifyV("TOP");
	txt.md.Set = function(self, md)
		self:SetText(prefix.."Median: "..VFL.strcolor(1,1,1)..md.."s");
	end
	
	txt.mx = VFLUI.CreateFontString(parent);
	txt.mx:SetPoint("TOPLEFT", txt.md, "BOTTOMLEFT");
	txt.mx:SetHeight(12); txt.mx:SetWidth(150);
	txt.mx:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	txt.mx:SetJustifyH("LEFT"); txt.mx:SetJustifyV("TOP");
	txt.mx.Set = function(self, mx)
		self:SetText(prefix.."Max: "..VFL.strcolor(1,1,1)..mx.."s");
	end
	
	txt.Destroy = function(self)
		CleanFontString(self);
		CleanFontString(self.mn);
		CleanFontString(self.md);
		CleanFontString(self.mx);
	end
	
	return txt;
end

local function CastTimeFontString(parent)
	local txt = VFLUI.CreateFontString(parent);
	txt:SetHeight(12); txt:SetWidth(150);
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP");
	local prefix = "     "..VFL.strcolor(.4,1,.4)
	txt.Set = function(self, t)
		if t > 0 then
			txt:SetText(prefix.."Casting Time: "..VFL.strcolor(1,1,1)..t.."s");
		elseif t == -1 then
			txt:SetText(prefix.."Casting Time: "..VFL.strcolor(1,.3,.3).."??");
		else
			txt:SetText(prefix.."Casting Time: "..VFL.strcolor(1,.3,.3).."Instant");
		end
	end
	
	txt.Destroy = function(self)
		CleanFontString(self);
	end
	
	return txt;
end

local function CastIDFontString(parent)
	local txt = VFLUI.CreateFontString(parent);
	txt:SetHeight(12); txt:SetWidth(150);
	txt:SetFontObject(VFLUI.GetFont(Fonts.Default, 12));
	txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP");
	local prefix = "     "..VFL.strcolor(.4,1,.4)
	txt.Set = function(self, t)
		if t then
			txt:SetText(prefix.."Spell Id: "..VFL.strcolor(1,1,1)..t);
		else
			txt:SetText(prefix.."Spell Id: "..VFL.strcolor(1,.3,.3).."??");
		end
		
	end
	txt.Destroy = function(self)
		CleanFontString(self);
	end
	
	return txt;
end

local function CleanTrackerWindow()
	local twin = track_window;
	if not twin then return; end
	
	twin.abl:Hide(); twin.ct:Hide(); twin.ids:Hide();
	local cd = twin.cd; cd:Hide();
	cd.mn:Hide(); cd.md:Hide(); cd.mx:Hide();
	
	twin.btnOmni:Hide(); twin.btnDd:Hide(); twin.btnCp:Hide();
	twin.btnas:Hide();
	
	return true;
end

local function PaintTrackerWindow(mobname, ability)
	local abt = RDXBM.GetAbilityTable(mobname, ability);
	if not abt then CleanTrackerWindow() return; end
	
	local mn, median, mx, ct, ty, tcasts, ids = RDXBM.GetAbilityInfo(abt);
	if not mn then CleanTrackerWindow() return; end
	
	local twin = track_window;
	if not twin then return; end
	
	twin.abl:Set(ability); twin.ct:Set(ct);
	twin.abl:Show(); twin.ct:Show();
	twin.ids:Set(ids); twin.ids:Show();
	
	------- Cooldowns
	local cd = twin.cd; cd:Show();
	cd.mn:Set(mn); cd.md:Set(median); cd.mx:Set(mx);
	cd.mn:Show(); cd.md:Show(); cd.mx:Show();
	
	------- Buttons
	if Omni then 
		twin.btnOmni:SetScript("OnClick", function()
			Omni.Open();
			local tblSpc = Omni.Sessions()[1].tablespace;
			local tbl = tblSpc[1];
			Omni.SetActiveTable(tbl);
			local pdesc = { abil = ability };
			local ff = Omni.FilterFunctor(pdesc);
			local nt = tbl:Filter(ff);
			tbl.session:AddTable(nt);
			Omni.SetActiveTable(nt);
		end); twin.btnOmni:Show();
	else twin.btnOmni:Hide(); end
	
	if tonumber(mn) and mn > 5 then
		twin.btnDd:SetScript("OnClick", function()
			local edata,adata = CreateDropdownPair(mobname, ability, mn, ty, ids)
			local state,beditor = RDXBM.GetbmState(),RDX.IsBossmodEditorOpen();
			state:AddFeature(edata);
			state:AddFeature(adata);
			beditor.RebuildFeatureList();
			beditor.SetActiveFeature(#state.features);
		end); twin.btnDd:Show();
	else twin.btnDd:Hide(); end
	
	if ty == 3 then
		twin.btnas:SetScript("OnClick", function()
			local edata,adata = CreateAlertPopupPair(mobname, ability, mn, ty, ids)
			local state,beditor = RDXBM.GetbmState(),RDX.IsBossmodEditorOpen();
			state:AddFeature(edata);
			state:AddFeature(adata);
			beditor.RebuildFeatureList();
			beditor.SetActiveFeature(#state.features);
		end); twin.btnas:Show();
	else twin.btnas:Hide(); end
		
	if not (ct > 0) then twin.btnCp:Hide(); return true; end
	twin.btnCp:SetScript("OnClick", function()
		local edata,adata = CreateCenterPopupPair(mobname, ability, ct, ty, ids)
		local state,beditor = RDXBM.GetbmState(),RDX.IsBossmodEditorOpen();
		state:AddFeature(edata);
		state:AddFeature(adata);
		beditor.RebuildFeatureList();
		beditor.SetActiveFeature(#state.features);
	end); twin.btnCp:Show();
		
	return true;
end

local function OpenTrackerWindow()
	if track_window then return track_window, ca; end
	local parent = RDX.IsBossmodEditorOpen();
	
	track_window = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(track_window, 24);
	track_window:SetBackdrop(VFLUI.BlackDialogBackdrop);
	track_window:SetTitleColor(1,.1,.2);
	track_window:SetText("Abilities Tracking");
	track_window:SetWidth(325); track_window:SetHeight(150);
	track_window:SetPoint("CENTER", VFLParent, "CENTER");
	track_window:Show();
	if RDXPM.Ismanaged("AbilityTracker") then RDXPM.RestoreLayout(track_window, "AbilityTracker"); end
	VFLUI.Window.StdMove(track_window, track_window:GetTitleBar());
	ca = track_window:GetClientArea();
	
	local abl = AbilityFontString(ca, ability);
	abl:SetPoint("TOPLEFT", ca, "TOPLEFT");
	track_window.abl = abl;
	
	local btnOmni = VFLUI.Button:new(ca);
	btnOmni:SetHeight(20); btnOmni:SetWidth(150);
	btnOmni:SetPoint("TOPRIGHT", ca, "TOPRIGHT");
	btnOmni:SetText(VFLI.i18n("Parse Omniscience")); btnOmni:Show();
	track_window.btnOmni = btnOmni;
	
	local cd = CooldownFontString(ca);
	cd:SetPoint("TOPLEFT", abl, "BOTTOMLEFT");
	track_window.cd = cd;
	
	local btnDd = VFLUI.Button:new(ca);
	btnDd:SetHeight(20); btnDd:SetWidth(150);
	btnDd:SetPoint("TOPRIGHT", ca, "TOPRIGHT", 0, -35);
	btnDd:SetText(VFLI.i18n("Create Dropdown"));
	track_window.btnDd = btnDd;
	
	local btnas = VFLUI.Button:new(ca);
	btnas:SetHeight(20); btnas:SetWidth(150);
	btnas:SetPoint("TOPRIGHT", ca, "TOPRIGHT", 0, -35);
	btnas:SetText(VFLI.i18n("Create Alert Buff"));
	track_window.btnas = btnas;
	
	--local casttime = 0;
	local ct = CastTimeFontString(ca)
	ct:SetPoint("TOPLEFT", cd.mx, "BOTTOMLEFT", -20);
	track_window.ct = ct;
	
	local ids = CastIDFontString(ca)
	ids:SetPoint("TOPLEFT", ct, "BOTTOMLEFT", -20);
	track_window.ids = ids;
	
	local btnCp = VFLUI.Button:new(ca);
	btnCp:SetHeight(20); btnCp:SetWidth(150);
	btnCp:SetPoint("TOPRIGHT", ca, "TOPRIGHT", 0, -65);
	btnCp:SetText(VFLI.i18n("Create Center Popup"));
	track_window.btnCp = btnCp;
	
	local mobSel = VFLUI.Dropdown:new(ca, function()
		return RDXBM.GetMobList();
		end,
		function()
			track_window.ablSel:SetSelection("");
		end
	);
	mobSel:SetPoint("BOTTOMLEFT", ca, "BOTTOMLEFT");
	mobSel:SetWidth(150); mobSel:Show();
	track_window.mobSel = mobSel;
	
	local ablSel = VFLUI.Dropdown:new(ca, function()
		return RDXBM.GetAbilityList(mobSel:GetText());
		end,
		function(abl)
			local mob = track_window.mobSel:GetText();
			PaintTrackerWindow(mob, abl);
		end
	);
	ablSel:SetPoint("TOPLEFT", mobSel, "TOPRIGHT");
	ablSel:SetWidth(150); ablSel:Show();
	track_window.ablSel = ablSel;
	
	track_window.Destroy = VFL.hook(function(s)
		abl:Destroy(); cd:Destroy(); ct:Destroy(); ids:Destroy();
		btnCp:Destroy(); btnCp = nil;
		btnDd:Destroy(); btnDd = nil;
		btnas:Destroy(); btnas = nil;
		btnOmni:Destroy(); btnOmni = nil;
		mobSel:Destroy(); mobSel = nil;
		ablSel:Destroy(); ablSel = nil;
	end, track_window.Destroy);
	
	local function Close()
		-- new 7.1 sigg store editors position
		RDXPM.StoreLayout(track_window, "AbilityTracker");
		track_window:Destroy(); track_window = nil;
	end
	
	local closebtn = VFLUI.CloseButton:new()
	closebtn:SetScript("OnClick", Close);
	track_window:AddButton(closebtn);
		
	return track_window, ca;
end

local function SetTrackerWindow(mobname, ability)
	if not track_window then return; end
	track_window.mobSel:SetSelection(mobname);
	track_window.ablSel:SetSelection(ability);
end

local function CloseTrackerWindow()
	if track_window then track_window:Destroy(); track_window = nil; end
	return true;
end

local function ToggleTrackerWindow()
	if track_window then
		return CloseTrackerWindow();
	else
		return OpenTrackerWindow();
	end
end

RDXBM.SetTrackerWindow = SetTrackerWindow;
RDXBM.ToggleTrackerWindow = ToggleTrackerWindow;
RDXBM.CloseTrackerWindow = CloseTrackerWindow;
