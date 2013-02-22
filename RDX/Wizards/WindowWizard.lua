-- ThemeWizard.lua
-- OpenRDX
-- 

local wtype = {
	{ text = "ActionBar1" },
	{ text = "ActionBar3" },
	{ text = "ActionBar4" },
	{ text = "ActionBar5" },
	{ text = "ActionBar6" },
	{ text = "ActionBarStance" },
	{ text = "ActionBarPet" },
	{ text = "ActionBarVehicle" },
	
	{ text = "Player_Main" },
	{ text = "Player_CastBar" },
	--{ text = "Player_PowerBarAlt" },
	{ text = "Player_Alternate_Bar" },
	{ text = "Player_Buff_Icon" },
	{ text = "Player_Buff_Secured_Icon" },
	{ text = "Player_Debuff_Icon" },
	{ text = "Player_Debuff_Secured_Icon" },
	{ text = "Player_Cooldowns_Used" },
	{ text = "Cooline" },
	{ text = "ClassBar" },
	
	{ text = "Target_Main" },
	{ text = "Target_CastBar" },
	{ text = "Target_Alternate_Bar" },
	{ text = "Target_Debuff" },
	{ text = "Targettarget_Main" },
	
	{ text = "Pet_Main" },
	{ text = "Pettarget_Main" },
	
	{ text = "Focus_Main" },
	{ text = "Focus_CastBar" },
	{ text = "Focustarget_Main" },

	{ text = "MiniMap" },
	{ text = "MiniMapButtons" },
	{ text = "MainPanel" },
	{ text = "MainMenu" },
	{ text = "Bags" },
	{ text = "TabManager1" },
	{ text = "TabManager2" },
	{ text = "TabManager3" },
	{ text = "TabManager4" },
	{ text = "FactionBar" },
	{ text = "XpBar" },
	
	{ text = "Party_Main" },
	{ text = "Partytarget_Main" },
	--{ text = "Partypet_Main" },
	
	{ text = "Raid_Main" },
	--{ text = "Raid_Main_Group1" },
	--{ text = "Raid_Main_Group2" },
	--{ text = "Raid_Main_Group3" },
	--{ text = "Raid_Main_Group4" },
	--{ text = "Raid_Main_Group5" },
	--{ text = "Raid_Main_Group6" },
	--{ text = "Raid_Main_Group7" },
	--{ text = "Raid_Main_Group8" },
	--{ text = "Raid_Main_GroupAll" },
	{ text = "Raidpet_Main" },
	
	{ text = "Boss_Main" },
	--{ text = "Bosstarget_Main" },
	{ text = "Bosspet_Main" },
	
	{ text = "Arena_Main" },
	--{ text = "Arenatarget_Main" },
	{ text = "Arenapet_Main" },
	
	--{ text = "TabDamageMeter" },
	--{ text = "TabHealMeter" },
	--{ text = "TabThread" },
	
};
table.sort(wtype, function(x1,x2) return x1.text<x2.text; end);
local function GetWindowsType() return wtype; end

-- page 1 type de fenêtre
-- page 2 frame
-- page 3 design (copy or new)
-- page 4 new default (size)
-- page 5 new display (nos skin, button skin or backdrop)
-- page 6 new display (Cooldown)
-- page 7 new display (Font)
-- page 8 new layout (Orientation, row number, width spacing, height spacing)
-- page 6 new display (STIB)
-- 

local ww = RDXUI.Wizard:new();

local page_id = 0;
local function GetNextPageId()
	page_id = page_id + 1;
	return page_id;
end

---------------------------------------------
-- WIZARD PAGES
---------------------------------------------
ww:RegisterPage(GetNextPageId(), "intro", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Wizard Tool");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		local plb = VFLUI.MakeLabel(nil, page, "Welcome to the Window Wizard. This tool will help you to build some windows for your theme.\n");
		plb:SetWidth(300); plb:SetHeight(30);
		plb:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		wizard:OnNext(function(wiz) wiz:SetPage(nil, "wtype"); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.pkg) then errs:AddError("Invalid package name."); end
		if (not desc.suffix) then errs:AddError("Invalid suffix."); end
		return not errs:HasError();
	end;
});

-------------------------------------------
-- Page: Select type of window
-------------------------------------------
ww:RegisterPage(GetNextPageId(), "wtype", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Window type/Suffix");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "Select the type of window you want to create:");
		lbl:SetWidth(300); lbl:SetHeight(30);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local dd_wtype = VFLUI.Dropdown:new(page, GetWindowsType);
		if desc and desc.wtype then 
			dd_wtype:SetSelection(desc.wtype); 
		end
		dd_wtype:SetWidth(300); 
		dd_wtype:SetPoint("TOPRIGHT", lbl, "BOTTOMRIGHT");
		dd_wtype:Show();
		
		--[[local page = RDXUI.GenerateStdWizardPage(parent, "Package/Prefix");
		
		local lbl = VFLUI.MakeLabel(nil, page, "Select a package to create your new window in. You may select a preexisting package or enter a name for a new package.\n\nPackage names must contain only alphanumeric characters and underscores.");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		local edPkg = RDXDB.PackageSelector:new(page);
		edPkg:SetPoint("TOPRIGHT", lbl, "BOTTOMRIGHT"); edPkg:SetWidth(225); edPkg:Show();
		if desc and desc.pkg then edPkg:SetPackage(desc.pkg); end]]

		local lbl = VFLUI.MakeLabel(nil, page, "Enter a suffix for this window. The suffix will be added to each of this window's objects. By using different suffix, you can create multiple windows in a single theme.");
		lbl:SetWidth(300); lbl:SetHeight(40);
		lbl:SetPoint("TOPRIGHT", dd_wtype, "BOTTOMRIGHT", 0, -10);
		local edSfx = VFLUI.Edit:new(page);
		edSfx:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		edSfx:SetHeight(25); edSfx:SetWidth(300); edSfx:Show();
		if desc and desc.suffix then edSfx:SetText(desc.suffix); end
		

		local lbl = VFLUI.MakeLabel(nil, page, "Enter a window title for this window. (optional)");
		lbl:SetWidth(300); lbl:SetHeight(10);
		lbl:SetPoint("TOPRIGHT", edSfx, "BOTTOMRIGHT", 0, -10);
		local edTtl = VFLUI.Edit:new(page);
		edTtl:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		edTtl:SetHeight(25); edTtl:SetWidth(300); edTtl:Show();
		if desc and desc.title then edTtl:SetText(desc.title); end

		function page:GetDescriptor()
			local st = VFL.trim(edSfx:GetText());
			if (st ~= "") and (not string.find(st, "_$")) then st = "_" .. st; end
			local _, auiname = RDXDB.ParsePath(RDXU.AUI);
			return {
				wtype = dd_wtype:GetSelection();
				pkg = auiname;
				suffix = st;
				title = edTtl:GetText();
			};
		end

		page.Destroy = VFL.hook(function(s)
			--edPkg:Destroy(); edPkg = nil;
			dd_wtype:Destroy(); dd_wtype = nil;
			edSfx:Destroy(); edSfx = nil;
			edTtl:Destroy(); edTtl = nil;
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(nil, "chkwin"); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.pkg) then errs:AddError("Invalid package name."); end
		if (not desc.suffix) then errs:AddError("Invalid suffix."); end    
		if (not desc.wtype) then errs:AddError("Invalid window type."); end
		return not errs:HasError();
	end;
});

-------------------------------------------
-- Page: Check duplicate window
-------------------------------------------
ww:RegisterPage(GetNextPageId(), "chkwin", {
	OpenPage = function(parent, wizard, desc)
		-- Formulate our page first.
		local txt = "";
		local pld = wizard:GetPageDescriptor(nil, "wtype");
		if not RDXDB.GetPackage(pld.pkg) then
			txt = txt .. "The package '" .. pld.pkg .. "' does not exist and will be created.\n";
		end

		local chk = pld.pkg .. ":" .. pld.wtype;
		if pld.suffix then chk = chk .. pld.suffix; end
		if RDXDB.GetObjectData(chk) then
			txt = txt .. "The data files for this window already exist. If you proceed, they will be overwritten and the window will be rebuilt from scratch.\n";
		end

		if txt == "" then wizard:SetPage(nil, "framing"); return; end -- Peaceout if we don't have anything to say.
		txt = txt .. "\nClick Next to confirm, or Cancel to abort.";
		txt = txt .. "\nClick Prev to add a suffix to the name of your window.";

		local page = RDXUI.GenerateStdWizardPage(parent, "Confirm");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetWidth(300); lbl:SetHeight(100); lbl:SetJustifyV("TOP");
		lbl:SetText(txt);

		wizard:OnNext(function(wiz) wiz:SetPage(nil, "framing"); end);
		return page;
	end;
	Verify = VFL.True;
});

-------------------------------------------
-- Page: Framing page
-------------------------------------------
RDX.RegisterFeature({
	name = "__veni_frametest";
	invisible = true;
	IsPossible = VFL.True;
	ExposeFeature = VFL.True;
	ApplyFeature = function(desc, state)
		local faux = nil;
		state:Attach(state:Slot("Create"), true, function(w)
			faux = VFLUI.AcquireFrame("Frame"); faux:Show();
			w:SetClient(faux);
			faux:SetWidth(100); faux:SetHeight(100);
			faux:SetBackdrop(VFLUI.WhiteBackdrop); faux:SetBackdropColor(.8,.8,1,0.6);
			local lbl = VFLUI.MakeLabel(nil, faux, "Window content");
			lbl:SetPoint("CENTER", faux, "CENTER");
		end);
		state:Attach(state:Slot("Destroy"), true, function(w)
			w:SetClient(nil);
			faux:Destroy(); faux = nil;
		end);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "__veni_frametest"; }; end;
});
ww:RegisterPage(GetNextPageId(), "framing", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Framing");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		local lbl = VFLUI.MakeLabel(nil, page, "Select a frame for the window:");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		-- Build sample window
		local state = RDX.WindowState:new();
		state:AddFeature({feature = "Frame: None"});
		state:AddFeature({feature = "__veni_frametest"});
		local sample = RDX.Window:new(page);

		-- Frame replacers
		local allFrames = {};
		local frameIdx = 1;
		for k,v in pairs(RDXDB._GetAllFeatures()) do
			if string.find(k, "^Frame%: ") then
				table.insert(allFrames, k);
			end
		end

		local curFrame = VFLUI.MakeLabel(nil, page, "CURRENT FRAME TEXT");
		curFrame:SetJustifyH("CENTER"); curFrame:SetWidth(140);
		curFrame:SetPoint("BOTTOM", page, "BOTTOM", 0, 10);

		local function UpdateFrame()
			if(frameIdx < 1) then frameIdx = #allFrames; 
			elseif(frameIdx > #allFrames) then frameIdx = 1; end

			local fn = allFrames[frameIdx];
			curFrame:SetText(fn);
			-- Rebuild the state
			state.features[1].feature = allFrames[frameIdx];
			if not state:ApplyAll() then sample:Hide(); return; end
			-- Apply it
			sample:UnloadState();
			sample:LoadState(state);
			sample:Show();
			sample:WMGetPositionalFrame():SetPoint("TOP", page, "TOP", 0, -75);
		end

		local btnPrev = VFLUI.TexturedButton:new(page, 16, "Interface\\Addons\\VFL\\Skin\\sb_left");
		btnPrev:SetHighlightColor(1,1,1,0);
		btnPrev:SetPoint("RIGHT", curFrame, "LEFT"); btnPrev:Show();
		btnPrev:SetScript("OnClick", function() frameIdx = frameIdx - 1; UpdateFrame(); end);

		local btnNext = VFLUI.TexturedButton:new(page, 16, "Interface\\Addons\\VFL\\Skin\\sb_right");
		btnNext:SetHighlightColor(1,1,1,0);
		btnNext:SetPoint("LEFT", curFrame, "RIGHT"); btnNext:Show();
		btnNext:SetScript("OnClick", function() frameIdx = frameIdx + 1; UpdateFrame(); end);

		UpdateFrame();

		function page:GetDescriptor()
			local zz = allFrames[frameIdx];
			return { frame = zz };
		end

		page.Destroy = VFL.hook(function(s)
			btnPrev:Destroy(); btnPrev = nil; btnNext:Destroy(); btnNext = nil;
			sample:Destroy(); sample = nil;
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(nil, "designtype"); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.frame) then errs:AddError("Invalid style."); end
		return not errs:HasError();
	end
});

-----------------------------------------------------------
-- Page: Design Type page
-----------------------------------------------------------
ww:RegisterPage(GetNextPageId(), "designtype", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Design");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local lbl = VFLUI.MakeLabel(nil, page, "Select the type of design you want to use.");
		lbl:SetWidth(300); lbl:SetHeight(30);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local btn1 = VFLUI.Button:new(page);
		btn1:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 5, -15);
		btn1:SetWidth(25); btn1:SetHeight(25); btn1:Show(); btn1:SetText(">");
		local blbl = VFLUI.MakeLabel(nil, page, "Copy the design of the same window type from another theme.");
		blbl:SetWidth(300); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn1, "RIGHT");
		wizard:MakeNextButton(btn1, function(wiz, dsc)
			dsc.designType = 1; wiz:SetPage(nil, "design");
		end);
		
		local btn2 = VFLUI.Button:new(page);
		btn2:SetPoint("TOP", btn1, "BOTTOM", 0, -20);
		btn2:SetWidth(25); btn2:SetHeight(25); btn2:Show(); btn2:SetText(">");
		blbl = VFLUI.MakeLabel(nil, page, "Copy an existing design in the current theme");
		blbl:SetWidth(300); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn2, "RIGHT");
		wizard:MakeNextButton(btn2, function(wiz, dsc)
			dsc.designType = 2; wiz:SetPage(nil, "design");
		end);

		local btn3 = VFLUI.Button:new(page);
		btn3:SetPoint("TOP", btn2, "BOTTOM", 0, -20);
		btn3:SetWidth(25); btn3:SetHeight(25); btn3:Show(); btn3:SetText(">");
		blbl = VFLUI.MakeLabel(nil, page, "Use an existing design in the current theme (windows will share the same design, any modification in the design will impact all windows)");
		blbl:SetWidth(300); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn3, "RIGHT");
		wizard:MakeNextButton(btn3, function(wiz, dsc)
			dsc.designType = 3; wiz:SetPage(nil, "design");
		end);
		
		local btn4 = VFLUI.Button:new(page);
		btn4:SetPoint("TOP", btn3, "BOTTOM", 0, -20);
		btn4:SetWidth(25); btn4:SetHeight(25); btn4:Show(); btn4:SetText(">");
		blbl = VFLUI.MakeLabel(nil, page, "Create a new empty or predefined design. Predefined Design are only available for simple windows like actionbar, buff icons, etc ... PlayerFrame will be empty.");
		blbl:SetWidth(300); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn4, "RIGHT");
		wizard:MakeNextButton(btn4, function(wiz, dsc)
			dsc.designType = 4;
			if pld.wtype == "ActionBar1" or pld.wtype == "ActionBar3" or pld.wtype == "ActionBar4" or pld.wtype == "ActionBar5" or pld.wtype == "ActionBar6" or pld.wtype == "ActionBarStance" or pld.wtype == "ActionBarPet" or pld.wtype == "ActionBarVehicle" then
				wiz:SetPage(nil, "d_size_spacing");
			elseif pld.wtype == "Raid_Main" or pld.wtype == "Raidpet_Main" then
				wiz:SetPage(nil, "singleheader");
			elseif pld.wtype == "TabManager1" or pld.wtype == "TabManager2" or pld.wtype == "TabManager3" or pld.wtype == "TabManager4" then
				wiz:SetPage(nil, "d_base_default");
			elseif pld.wtype == "FactionBar" or pld.wtype == "XpBar" then
				wiz:SetPage(nil, "d_base_default");
			else
				--if pld.wtype == "ActionBar1" then
				--	wiz:SetPage(nil, "ActionBar1");
				--else
					wiz:SetPage(nil, "done");
				--end
			end
		end);

		function page:GetDescriptor() return {}; end
		page.Destroy = VFL.hook(function(s)
			btn1:Destroy(); btn2:Destroy(); btn3:Destroy(); btn4:Destroy();
		end, page.Destroy);
		return page;
	end;
	Verify = VFL.True;
});

--------------------------------------------------------
-- Page: The Infamous Design Page
--------------------------------------------------------
ww:RegisterPage(GetNextPageId(), "design", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Design");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		local lbl = VFLUI.MakeLabel(nil, page, "Choose a design for your window. A preview will be shown below. (classbar/buff : if you have no charge or no aura, the window may be empty) ");
		lbl:SetWidth(300); lbl:SetHeight(40);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		
		local pld = wizard:GetPageDescriptor(nil, "wtype");

		-- Design chooser box
		local ofDesign;
		if wizard:GetPageDescriptor(nil, "designtype").designType == 1 then
			ofDesign = RDXDB.ObjectFinder:new(page, function(p,f,md) return (md and type(md) == "table" and md.ty == "Design" and string.find(f, pld.wtype)) end);
		else
			ofDesign = RDXDB.ObjectFinder:new(page, function(p,f,md) return (md and type(md) == "table" and md.ty == "Design" and p == pld.pkg) end);
		end
		ofDesign:SetPoint("BOTTOM", page, "BOTTOM");
		ofDesign:SetWidth(300); ofDesign:Show();
		ofDesign:SetLabel("Design:");
		if desc and desc.design then ofDesign:SetPath(desc.design); end

		-- Unitframe sample renderer
		local curUF, curDesign = nil, nil;
		local function UpdateUnitFrameDesign()
			local design = ofDesign:GetPath();
			if design == curDesign then return; end
			-- Destroy the old frame
			if curUF then curUF:Destroy(); curUF = nil; end
			-- Load the new design.
			local ufState = RDX.LoadDesign(design, nil, RDX._exportedWindowState);
			if not ufState then return; end
			local createFrame = RDX.DesignGeneratingFunctor(ufState);
			if not createFrame then return; end
			-- Success, update the uf.
			curDesign = design;
			curUF = VFLUI.AcquireFrame("Frame"); 
			VFLUI.StdSetParent(curUF, page);
			createFrame(curUF);
			curUF:SetPoint("CENTER", page, "CENTER", 0, 0); curUF:Show();
		end
		local function PaintUnitFrame()
			if curUF then 
				local unit = RDXDAL.ProjectUnitID("player");
				if unit then
					curUF._paintmask = 1;
					curUF:SetData(1, unit.uid, unit);
				end
			end
		end
		VFLT.AdaptiveSchedule2("__uf_sample", 1, PaintUnitFrame);

		-- Hook design chooser into renderer.
		ofDesign.OnPathChanged = UpdateUnitFrameDesign;

		function page:GetDescriptor()
			return { design = ofDesign:GetPath(); };
		end

		page.Destroy = VFL.hook(function(s)
			ofDesign:Destroy();
			if curUF then curUF:Destroy(); end
			VFLT.AdaptiveUnschedule2("__uf_sample");
		end, page.Destroy);
		
		wizard:OnNext(function(wiz) 
			if pld.wtype == "Raid_Main" or pld.wtype == "Raidpet_Main" then
				wiz:SetPage(nil, "singleheader");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if not desc.design then 
			errs:AddError("Missing design");
		else
			if not RDX.LoadDesign(desc.design, RDXDB.ObjectState.Verify, RDX._exportedWindowState) then
				VFL.AddError(errs, "Could not load Design at <" .. tostring(desc.design) .. ">.");
			end
		end
		return not errs:HasError();
	end
});

-- base_default feature
ww:RegisterPage(GetNextPageId(), "d_base_default", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Height/Width");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may enter the height and the width of your window");

		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");

		local ed_width = VFLUI.LabeledEdit:new(ui, 100); ed_width:Show();
		ed_width:SetText(VFLI.i18n("Width"));
		if desc and desc.w then ed_width.editBox:SetText(desc.w); end
		ui:InsertFrame(ed_width);
		
		local ed_height = VFLUI.LabeledEdit:new(ui, 100); ed_height:Show();
		ed_height:SetText(VFLI.i18n("Height"));
		if desc and desc.h then ed_height.editBox:SetText(desc.h); end
		ui:InsertFrame(ed_height);

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				w = ed_width.editBox:GetNumber();
				h = ed_height.editBox:GetNumber();
			};
		end

		page.Destroy = VFL.hook(function(s)
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		
		wizard:OnNext(function(wiz)
			if pld.wtype == "TabManager1" or pld.wtype == "TabManager2" or pld.wtype == "TabManager3" or pld.wtype == "TabManager4" then
				wiz:SetPage(nil, "d_backdrop");
			elseif pld.wtype == "FactionBar" or pld.wtype == "XpBar" then
				wiz:SetPage(nil, "d_backdrop");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if not desc.w then errs:AddError(VFLI.i18n("Missing width")); end
		if not desc.h then errs:AddError(VFLI.i18n("Missing height")); end
		return not errs:HasError();
	end
});

-- size spacing feature
ww:RegisterPage(GetNextPageId(), "d_size_spacing", {
	OpenPage = function(parent, wizard, desc)
		if not desc then desc = {}; end
		local page = RDXUI.GenerateStdWizardPage(parent, "Size/Spacing");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may enter the size and the spacing of each button");

		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");

		local ed_size = VFLUI.LabeledEdit:new(ui, 200); ed_size:Show();
		ed_size:SetText(VFLI.i18n("Size"));
		if desc and desc.size then ed_size.editBox:SetText(desc.size); end
		ui:InsertFrame(ed_size);
		
		local ed_spacing = VFLUI.LabeledEdit:new(ui, 200); ed_spacing:Show();
		ed_spacing:SetText(VFLI.i18n("Height"));
		if desc and desc.spacing then ed_spacing.editBox:SetText(desc.spacing); end
		ui:InsertFrame(ed_spacing);

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				size = ed_size.editBox:GetNumber();
				spacing = ed_spacing.editBox:GetNumber();
			};
		end

		page.Destroy = VFL.hook(function(s)
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		
		wizard:OnNext(function(wiz)
			if pld.wtype == "ActionBar1" or pld.wtype == "ActionBar3" or pld.wtype == "ActionBar4" or pld.wtype == "ActionBar5" or pld.wtype == "ActionBar6" or pld.wtype == "ActionBarStance" or pld.wtype == "ActionBarPet" or pld.wtype == "ActionBarVehicle" then
				wiz:SetPage(nil, "d_skin_cd");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if not desc.size then errs:AddError(VFLI.i18n("Missing size")); end
		if not desc.spacing then errs:AddError(VFLI.i18n("Missing spacing")); end
		return not errs:HasError();
	end
});

-- size spacing feature
ww:RegisterPage(GetNextPageId(), "d_skin_cd", {
	OpenPage = function(parent, wizard, desc)
		if not desc then desc = {}; end
		local page = RDXUI.GenerateStdWizardPage(parent, "Skin / cd");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("Select the skin of your button/icon and the type of cooldown");

		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Skin parameters")));

		local driver = VFLUI.DisjointRadioGroup:new();
		
		local driver_NS = driver:CreateRadioButton(ui);
		driver_NS:SetText(VFLI.i18n("No Skin"));
		local driver_BS = driver:CreateRadioButton(ui);
		driver_BS:SetText(VFLI.i18n("Use Button Skin"));
		local driver_BD = driver:CreateRadioButton(ui);
		driver_BD:SetText(VFLI.i18n("Use Backdrop"));
		driver:SetValue(desc.driver or 1);
		
		ui:InsertFrame(driver_NS);
		
		ui:InsertFrame(driver_BS);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("ButtonSkin"));
		local dd_buttonskin = VFLUI.MakeButtonSkinSelectButton(er, desc.bs);
		dd_buttonskin:Show();
		er:EmbedChild(dd_buttonskin); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(driver_BD);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop"));
		local dd_backdrop = VFLUI.MakeBackdropSelectButton(er, desc.bkd);
		dd_backdrop:Show();
		er:EmbedChild(dd_backdrop); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown parameters")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				driver = driver:GetValue();
				bs = dd_buttonskin:GetSelectedButtonSkin();
				bkd = dd_backdrop:GetSelectedBackdrop();
				cd = cd:GetSelectedCooldown();
			};
		end

		page.Destroy = VFL.hook(function(s)
			driver:Destroy(); driver = nil;
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		
		wizard:OnNext(function(wiz)
			if pld.wtype == "ActionBar1" or pld.wtype == "ActionBar3" or pld.wtype == "ActionBar4" or pld.wtype == "ActionBar5" or pld.wtype == "ActionBar6" or pld.wtype == "ActionBarStance" or pld.wtype == "ActionBarPet" or pld.wtype == "ActionBarVehicle" then
				wiz:SetPage(nil, "d_font_multi");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});

-- backdrop feature
ww:RegisterPage(GetNextPageId(), "d_backdrop", {
	OpenPage = function(parent, wizard, desc)
		if not desc then desc = {}; end
		local page = RDXUI.GenerateStdWizardPage(parent, "Backdrop");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may select the backdrop for your window");

		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop"));
		local bkd = VFLUI.MakeBackdropSelectButton(er, desc.bkd); bkd:Show();
		er:EmbedChild(bkd); er:Show();
		ui:InsertFrame(er);

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				bkd = bkd:GetSelectedBackdrop();
			};
		end

		page.Destroy = VFL.hook(function(s)
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		
		wizard:OnNext(function(wiz)
			if pld.wtype == "TabManager1" or pld.wtype == "TabManager2" or pld.wtype == "TabManager3" or pld.wtype == "TabManager4" then
				wiz:SetPage(nil, "d_font");
			elseif pld.wtype == "FactionBar" or pld.wtype == "XpBar" then
				wiz:SetPage(nil, "d_texture");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});

-- Texture feature
ww:RegisterPage(GetNextPageId(), "d_texture", {
	OpenPage = function(parent, wizard, desc)
		if not desc then desc = {}; end
		local page = RDXUI.GenerateStdWizardPage(parent, "Texture");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may select a texture for your window");

		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Draw layer"));
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(150); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);
		
		local ed_sublevel = VFLUI.LabeledEdit:new(ui, 50); ed_sublevel:Show();
		ed_sublevel:SetText(VFLI.i18n("TextureLevel offset"));
		if desc and desc.sublevel then ed_sublevel.editBox:SetText(desc.sublevel); end
		ui:InsertFrame(ed_sublevel);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				texture = tsel:GetSelectedTexture();
			};
		end

		page.Destroy = VFL.hook(function(s)
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		
		wizard:OnNext(function(wiz)
			if pld.wtype == "Raid_Main" or pld.wtype == "Raidpet_Main" then
				wiz:SetPage(nil, "singleheader");
			elseif pld.wtype == "FactionBar" or pld.wtype == "XpBar" then
				wiz:SetPage(nil, "d_font");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});

-- Font feature
ww:RegisterPage(GetNextPageId(), "d_font", {
	OpenPage = function(parent, wizard, desc)
		if not desc then desc = {}; end
		local page = RDXUI.GenerateStdWizardPage(parent, "Font");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may select a font for your window");

		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er, desc.font); fontsel:Show();
		er:EmbedChild(fontsel); er:Show();
		ui:InsertFrame(er);

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				font = fontsel:GetSelectedFont();
			};
		end

		page.Destroy = VFL.hook(function(s)
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		
		wizard:OnNext(function(wiz)
			if pld.wtype == "TabManager1" or pld.wtype == "TabManager2" or pld.wtype == "TabManager3" or pld.wtype == "TabManager4" then
				wiz:SetPage(nil, "done");
			elseif pld.wtype == "FactionBar" or pld.wtype == "XpBar" then
				wiz:SetPage(nil, "done");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});

ww:RegisterPage(GetNextPageId(), "d_font_multi", {
	OpenPage = function(parent, wizard, desc)
		if not desc then desc = {}; end
		local page = RDXUI.GenerateStdWizardPage(parent, "Fonts");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may select a font for your window");

		local pld = wizard:GetPageDescriptor(nil, "wtype");
		
		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");

		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font Key"));
		local fontkey = VFLUI.MakeFontSelectButton(er_st, desc.fontkey); fontkey:Show();
		er_st:EmbedChild(fontkey); er_st:Show();
		ui:InsertFrame(er_st);
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font Macro"));
		local fontmacro = VFLUI.MakeFontSelectButton(er_st, desc.fontmacro); fontmacro:Show();
		er_st:EmbedChild(fontmacro); er_st:Show();
		ui:InsertFrame(er_st);
		
		local er_st = VFLUI.EmbedRight(ui, VFLI.i18n("Font Count"));
		local fontcount = VFLUI.MakeFontSelectButton(er_st, desc.fontcount); fontcount:Show();
		er_st:EmbedChild(fontcount); er_st:Show();
		ui:InsertFrame(er_st);

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				fontkey = fontkey:GetSelectedFont();
				fontmacro = fontmacro:GetSelectedFont();
				fontcount = fontcount:GetSelectedFont();
			};
		end

		page.Destroy = VFL.hook(function(s)
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		
		wizard:OnNext(function(wiz)
			if pld.wtype == "ActionBar1" or pld.wtype == "ActionBar3" or pld.wtype == "ActionBar4" or pld.wtype == "ActionBar5" or pld.wtype == "ActionBar6" or pld.wtype == "ActionBarStance" or pld.wtype == "ActionBarPet" or pld.wtype == "ActionBarVehicle" then
				wiz:SetPage(nil, "done");
			else
				wiz:SetPage(nil, "done");
			end
		end);
		
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});

--------------------------------------------------------
-- Page: Add Highlights
--------------------------------------------------------
--[[ww:RegisterPage(GetNextPageId(), "designhighlight", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Highlights");
		page:SetWidth(336); page:SetHeight(378);
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may add up to four highlight conditions to your unit frame. If the unit is in the set you select, it will be highlighted with the color you choose. If multiple highlights apply, the last one will take precedence. (Remember to change the alpha value! If you set the alpha value to 1, it will obscure the unitframe completely.)");

		local ui, sf = VFLUI.CreateScrollingCompoundFrame(page);
		sf:SetWidth(320); sf:SetHeight(300);
		sf:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");

		local hlt1color = RDXUI.GenerateColorSwatch(ui, "Highlight 1 color:");
		if desc and desc.hlt1color then hlt1color:SetColor(VFL.explodeRGBA(desc.hlt1color)); end
		local hlt1set = RDXDAL.SetFinder:new(ui);
		hlt1set:SetText("Highlight 1 set class:");
		hlt1set:Show(); ui:InsertFrame(hlt1set); 
		if desc and desc.hlt1set then hlt1set:SetDescriptor(desc.hlt1set); end

		local hlt2color = RDXUI.GenerateColorSwatch(ui, "Highlight 2 color:");
		if desc and desc.hlt2color then hlt2color:SetColor(VFL.explodeRGBA(desc.hlt2color)); end
		local hlt2set = RDXDAL.SetFinder:new(ui);
		hlt2set:SetText("Highlight 2 set class:");
		hlt2set:Show(); ui:InsertFrame(hlt2set); 
		if desc and desc.hlt2set then hlt2set:SetDescriptor(desc.hlt2set); end

		local hlt3color = RDXUI.GenerateColorSwatch(ui, "Highlight 3 color:");
		if desc and desc.hlt3color then hlt3color:SetColor(VFL.explodeRGBA(desc.hlt3color)); end
		local hlt3set = RDXDAL.SetFinder:new(ui);
		hlt3set:SetText("Highlight 3 set class:");
		hlt3set:Show(); ui:InsertFrame(hlt3set); 
		if desc and desc.hlt3set then hlt3set:SetDescriptor(desc.hlt3set); end

		local hlt4color = RDXUI.GenerateColorSwatch(ui, "Highlight 4 color:");
		if desc and desc.hlt4color then hlt4color:SetColor(VFL.explodeRGBA(desc.hlt4color)); end
		local hlt4set = RDXDAL.SetFinder:new(ui);
		hlt4set:SetText("Highlight 4 set class:");
		hlt4set:Show(); ui:InsertFrame(hlt4set); 
		if desc and desc.hlt4set then hlt4set:SetDescriptor(desc.hlt4set); end

		VFLUI.ActivateScrollingCompoundFrame(ui, sf);

		function page:GetDescriptor()
			return {
				hlt1color = hlt1color:GetColor();
				hlt1set = hlt1set:GetDescriptor();
				hlt2color = hlt2color:GetColor();
				hlt2set = hlt2set:GetDescriptor();
				hlt3color = hlt3color:GetColor();
				hlt3set = hlt3set:GetDescriptor();
				hlt4color = hlt4color:GetColor();
				hlt4set = hlt4set:GetDescriptor();
			};
		end

		page.Destroy = VFL.hook(function(s)
			VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(11); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});
]]
--------------------------------------------------------
-- Page: Add alpha fade
--------------------------------------------------------
--[[ww:RegisterPage(GetNextPageId(), "designalpha",{
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Alpha Fade");
		page:SetWidth(300); page:SetHeight(300);
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetWidth(300); lbl:SetHeight(30);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetText("You may add an alpha fade to this window. The transparency of the frame will be altered depending whether or not the unit is in the set you select.");

		local ui = VFLUI.CompoundFrame:new(page);
		ui.isLayoutRoot = true;

		local alphaset = RDXDAL.SetFinder:new(ui);
		alphaset:Show(); ui:InsertFrame(alphaset); 
		if desc and desc.alphaset then alphaset:SetDescriptor(desc.alphaset); end

		local falseAlpha = VFLUI.LabeledEdit:new(ui, 50); falseAlpha:Show();
		falseAlpha:SetText("Alpha when NOT IN SET");
		if desc and desc.falseAlpha then falseAlpha.editBox:SetText(desc.falseAlpha); end
		ui:InsertFrame(falseAlpha);

		local trueAlpha = VFLUI.LabeledEdit:new(ui, 50); trueAlpha:Show();
		trueAlpha:SetText("Alpha when IN SET");
		if desc and desc.trueAlpha then trueAlpha.editBox:SetText(desc.trueAlpha); end
		ui:InsertFrame(trueAlpha);

		ui:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		ui:SetWidth(300); ui:Show(); ui:DialogOnLayout();

		function page:GetDescriptor()
			local fa, ta = VFL.clamp(falseAlpha.editBox:GetNumber(), 0, 1), VFL.clamp(trueAlpha.editBox:GetNumber(), 0, 1);
			return {
				alphaset = alphaset:GetDescriptor();
				falseAlpha = fa; trueAlpha = ta;
			};
		end

		page.Destroy = VFL.hook(function(s)
			ui:Destroy();
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(12); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});
]]
--------------------------------------------------------
-- Page: Header definition (for single-header windows)
--------------------------------------------------------
ww:RegisterPage(GetNextPageId(), "singleheader", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Header Definition");
		page:SetWidth(315); page:SetHeight(350);
		parent:SetBackdropColor(1,1,1,0.4);

		local lbl = VFLUI.MakeLabel(nil, page, "Choose which groups and classes you want to display and how you would like to sort them.");
		lbl:SetWidth(325); lbl:SetHeight(20);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local he = RDXUI.HeaderEditor:new(page);
		he:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 0, -5);
		he:SetWidth(315); he:DialogOnLayout(); he:Show();
		if desc and desc.header then he:SetDescriptor(desc.header); end

		function page:GetDescriptor()
			return { header = he:GetDescriptor() };
		end
		page.Destroy = VFL.hook(function(s)
			he:Destroy(); he = nil;
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(nil, "done"); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.header) then errs:AddError("Please create a header definition."); end
		return not errs:HasError();
	end
});

--------------------------------------------------------
-- Page: Filter definition (for grid-shaped windows)
--------------------------------------------------------
--[[ww:RegisterPage(GetNextPageId(), "filterset", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Filter");
		local lbl = VFLUI.MakeLabel(nil, page, "Create a filter for the window by dragging conditions from the left to the right. Conditions can be dragged to any spot marked 'Drag a Filter Component Here'. You can combine conditions using logic operations like AND, OR, and NOT. Your filter must use at least one condition; use the 'Everyone' condition to make a window that displays everyone.");
		lbl:SetWidth(430); lbl:SetHeight(40);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local fe = RDXDAL.FilterEditor:new(page);
		fe:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		fe:Show();
		if desc and desc.filter then fe:LoadDescriptor(desc.filter); else fe:LoadDescriptor(nil); end

		page:SetWidth(fe:GetWidth());
		page:SetHeight(fe:GetHeight() + 65);

		function page:GetDescriptor()
			return { filter = fe:GetDescriptor() };
		end

		page.Destroy = VFL.hook(function(s)
			fe:Destroy(); fe = nil;
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(7); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.filter) then errs:AddError("Please create a filter."); end
		return not errs:HasError();
	end
});]]

--------------------------------------------------------
-- Page: Sort definition (for grid-shaped windows)
--------------------------------------------------------
--[[ww:RegisterPage(GetNextPageId(), "sort", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Sort");
		local lbl = VFLUI.MakeLabel(nil, page, "Select a sort ordering for your window:");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		-- Figure out if we're secure or not. If secure, get rid of the nonsecure sorts.
		local nSorts = 4;
		local p4d = wizard:GetPageDescriptor(4);
		if p4d.windowType == 1 then nSorts = 6; end

		local rg_sort = VFLUI.RadioGroup:new(page);
		rg_sort:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		rg_sort:SetLayout(nSorts, 2); rg_sort:Show();
		rg_sort.buttons[1]:SetText("Alphabetical");
		rg_sort.buttons[2]:SetText("Class");
		rg_sort.buttons[3]:SetText("Group Number");
		rg_sort.buttons[4]:SetText("Raid Index");
		if nSorts > 4 then -- add nonsecure sorts
			rg_sort.buttons[5]:SetText("HP");
			rg_sort.buttons[6]:SetText("Mana");
		end
		rg_sort:SetWidth(300); rg_sort:SetHeight(16*math.ceil(nSorts/2));
		if desc and desc.sort then rg_sort:SetValue(desc.sort); else rg_sort:SetValue(1); end

		local chk_reverse = VFLUI.Checkbox:new(page); chk_reverse:Show();
		chk_reverse:SetHeight(20); chk_reverse:SetWidth(120);
		chk_reverse:SetPoint("TOPLEFT", rg_sort, "BOTTOMLEFT");
		chk_reverse:SetText("Reverse sort");
		if desc and desc.reverse then chk_reverse:SetChecked(true); else chk_reverse:SetChecked(); end
		
		page:SetHeight(100);
		function page:GetDescriptor()
			return { sort = rg_sort:GetValue() or 1; reverse = chk_reverse:GetChecked();  };
		end
		page.Destroy = VFL.hook(function(s)
			rg_sort:Destroy(); chk_reverse:Destroy();
		end, page.Destroy);

		wizard:OnNext(function(wiz) wiz:SetPage(8); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});]]

--------------------------------------------------------
-- Page: Layout definition (for grid-shaped windows)
--------------------------------------------------------
--[[ww:RegisterPage(GetNextPageId(), {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Window Layout");
		local lbl = VFLUI.MakeLabel(nil, page, "Choose the layout of your window:");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local layout = VFLUI.DisjointRadioGroup:new();

		local layout_SC = layout:CreateRadioButton(page);
		layout_SC:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT"); layout_SC:SetWidth(100);
		layout_SC:SetText("Single column"); layout_SC:Show();

		local layout_grid = layout:CreateRadioButton(page);
		layout_grid:SetPoint("LEFT", layout_SC, "LEFT", 0, -20); layout_grid:SetWidth(90);
		layout_grid:SetText("Grid of width"); layout_grid:Show();

		local ed_gw = VFLUI.Edit:new(page);
		ed_gw:SetHeight(25); ed_gw:SetWidth(50);
		ed_gw:SetPoint("LEFT", layout_grid, "RIGHT"); ed_gw:Show();
		if desc and desc.cols then ed_gw:SetText(desc.cols); end

		if desc and desc.layout then layout:SetValue(desc.layout); else layout:SetValue(1); end

		function page:GetDescriptor()
			local cols = VFL.clamp(ed_gw:GetNumber(), 1, 20);
			return { layout = layout:GetValue() or 1, cols = cols };
		end

		page:SetHeight(100);

		page.Destroy = VFL.hook(function(s)
			layout_SC:Destroy(); layout_grid:Destroy(); ed_gw:Destroy();
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(9); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if not desc.layout then errs:AddError("Invalid layout."); end
		return not errs:HasError();
	end
});]]



--------------------------------------------------------
-- Page: Mouse bindings
--------------------------------------------------------
ww:RegisterPage(GetNextPageId(), "mousebindings", {
	OpenPage = function(parent, wizard, desc)
		-- Figure out if we're secure or not. If not, just peaceout.
		local p4d = wizard:GetPageDescriptor(4);
		if p4d.windowType == 1 then
			wizard:SetPage(20); return;
		end

		local page = RDXUI.GenerateStdWizardPage(parent, "Mouse Bindings");
		parent:SetBackdropColor(1,1,1,0.4);
		page:SetWidth(300); page:SetHeight(150);
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetWidth(300); lbl:SetHeight(20); lbl:SetJustifyV("TOP");
		lbl:SetText("Select mouse bindings for this window. Mouse bindings determine what happens when you click on this window.");

		local btype = VFLUI.DisjointRadioGroup:new();

		local btype_none = btype:CreateRadioButton(page);
		btype_none:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		btype_none:SetWidth(300); btype_none:Show();
		btype_none:SetText("No mouse bindings");

		local btype_intl = btype:CreateRadioButton(page);
		btype_intl:SetPoint("TOPLEFT", btype_none, "BOTTOMLEFT");
		btype_intl:SetWidth(300); btype_intl:Show();
		btype_intl:SetText("Use RDX mouse bindings");

		local ofMB = RDXDB.ObjectFinder:new(page, function(p,f,md) return (md and type(md) == "table" and md.ty=="MouseBindings"); end);
		ofMB:SetWidth(300); ofMB:SetPoint("TOPLEFT", btype_intl, "BOTTOMLEFT"); ofMB:Show();
		ofMB:SetLabel("Bindings:");
		if desc and desc.mb then ofMB:SetPath(desc.mb); end

		local btype_extl = nil;
		--if wizard:GetPageDescriptor(4).windowType ~= 4 then
	  	--btype_extl = btype:CreateRadioButton(page);
		--	btype_extl:SetPoint("TOPLEFT", ofMB, "BOTTOMLEFT");
		--	btype_extl:SetWidth(300); btype_extl:Show();
		--	btype_extl:SetText("Use external program (Clique etc.)");
		--end

		btype:SetValue(1);

		function page:GetDescriptor()
			return {
				btype = btype:GetValue() or 1;
				mb = ofMB:GetPath();
			};
		end

		page.Destroy = VFL.hook(function(s)
			btype_none:Destroy(); btype_intl:Destroy();
			ofMB:Destroy(); 
			if btype_extl then btype_extl:Destroy(); end
		end, page.Destroy);

		wizard:OnNext(function(wiz) wiz:SetPage(nil, "done"); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});

--------------------
-- Page (done)
--------------------
ww:RegisterPage(GetNextPageId(), "done", {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Done!");
		page:SetWidth(336); page:SetHeight(378);
		parent:SetBackdropColor(1,1,1,0.4);
		
		local lbl = VFLUI.MakeLabel(nil, page, "You have now entered all information necessary to create your window.\n\nIf you click OK, your window will be created and moved to the center of the screen.\n\nIf you choose Cancel, this process will be aborted and no changes will be made.");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetWidth(300); lbl:SetHeight(110); lbl:SetJustifyV("TOP");

		wizard:Final();
		return page;
	end;
	Verify = function(desc, wizard, errs)
		return true;
	end
});

-------------------------------------------------
-- OK FUNCTION
-- All the actual work is done here. Process the input.
-------------------------------------------------
local function handleHighlight(setDesc, color, ufd, hnum, htAdded)
	-- See if our set is valid
	local x = RDXDAL.FindSet(setDesc); if not x then return; end
	-- If we haven't added a highlight texture...
	if not htAdded then
		local baseframe = RDXDB.HasFeature(ufd, "base_default");
		if not baseframe then return nil; end
		table.insert(ufd, {
			feature = "texture"; version = 1;
			name = "wwizhtex"; owner = "Base"; drawLayer = "ARTWORK";
			texture = {
				color={r=1,g=1,b=1,a=1};
				blendMode = "BLEND";
			};
			w = baseframe.w; h = baseframe.h;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0 };
			cleanupPolicy = 2;
		});
	end
	-- Add the hlt color variable
	table.insert(ufd, {
		feature = "ColorVariable: Static Color";
		name = "wwizhcol" .. hnum;
		color = color;
	});
	-- Add the set toggle variable
	table.insert(ufd, {
		feature = "Variable: Unit In Set";
		name = "wwizhset" .. hnum;
		set = setDesc;
	});
	-- Add the highlight shader
	table.insert(ufd, {
		feature = "Highlight: Texture Map";
		flag = "wwizhset" .. hnum .. "_flag";
		texture = "wwizhtex";
		color = "wwizhcol" .. hnum;
	});
	return true;
end

local function handleAlpha(setDesc, a0, a1, ufd)
	local x = RDXDAL.FindSet(setDesc); if not x then return; end
	-- Add the set toggle variable
	table.insert(ufd, {
		feature = "Variable: Unit In Set";
		name = "wwizaset";
		set = setDesc;
	});
	-- Add the alpha shader
	table.insert(ufd, {
		feature = "shader_ca"; version = 1;
		flag = "wwizaset_flag";
		falseAlpha = a0; trueAlpha = a1;
	});
end

function ww:OnOK()
	------------------------ BASIC SETUP
	local obj, pd;
	-- Get the window type
	--pd = self:GetPageDescriptor(4);
	--if not pd then error("Missing window type"); end
	--local wtype = pd.windowType;
	--if type(wtype) ~= "number" then error("Bad window type (should be impossible!)"); end
	-- Setup the package/prefix
	pd = self:GetPageDescriptor(nil, "wtype");
	local wtype, pkg, suffix, title = pd.wtype, pd.pkg, pd.suffix, pd.title;
	--local pkgData = RDXDB.GetOrCreatePackage(pkg);
	--if not pkgData then error("Bad package in window wizard (should be impossible!)"); end

	------------------------- CLOSE EXISTING
	DesktopEvents:Dispatch("WINDOW_CLOSE", RDXDB.MakePath(pkg, wtype .. suffix));
	------------------------- CLEANUP PREEXISTING
	-- Delete all preexisting files in that package, destroying instances as well.
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, wtype .. suffix .. "_set"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, wtype .. suffix .. "_sort"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, wtype .. suffix .. "_tm"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, wtype .. suffix .. "_ds"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, wtype .. suffix));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, wtype .. suffix .. "_wz")); -- wizard
	
	-------------------------- GENERATE TABMANAGER IF NECESSARY
	if wtype == "TabManager1" or wtype == "TabManager2" or wtype == "TabManager3" then
		obj = RDXDB._DirectCreateObject(pkg, wtype .. suffix .. "_tm");
		obj.ty = "TabManager"; obj.version = 2;
		obj.data = {
			"root",
		}
	end
	-------------------------- GENERATE SET AND SORT IF NECESSARY
	--[[if wtype ~= 2 then
		-- Create the FilterSet
		obj = RDXDB._DirectCreateObject(pkg, prefix .. "set");
		obj.ty = "FilterSet"; obj.version = 1;
		obj.data = self:GetPageDescriptor(6).filter; -- pull filter def from filter page

		-- Create the sort function
		local sortFunc, sortRev, sortSel;
		sortRev = self:GetPageDescriptor(7).reverse;
		sortSel = self:GetPageDescriptor(7).sort;

		if sortSel == 1 then -- alpha
			sortFunc = {{op = "alpha", reversed = sortRev}};
		elseif sortSel == 2 then -- class
			sortFunc = {{op = "class", reversed = sortRev}, {op = "alpha"}};
		elseif sortSel == 3 then -- group
			sortFunc = {{op = "group", reversed = sortRev}, {op = "alpha"}};
		elseif sortSel == 4 then -- raidid
			sortFunc = {{op = "nid", reversed = sortRev}};
		elseif sortSel == 5 then -- hp
			sortFunc = {{op = "hpp", reversed = sortRev}, {op = "alpha"}};
		elseif sortSel == 6 then -- mana
			sortFunc = {{op = "mpp", reversed = sortRev}, {op = "alpha"}};
		end

		-- Create the sort object
		obj = RDXDB._DirectCreateObject(pkg, prefix .. "sort");
		if wtype == 4 then obj.ty = "SecureSort"; else obj.ty = "Sort"; end
		obj.version = 2;
		obj.data = {
			sort = sortFunc;
			set = { class = "file"; file = RDXDB.MakePath(pkg, prefix .. "set"); } 
		};
	end]]
	
	---------------------------- GENERATE DESIGN
	if self:GetPageDescriptor(nil, "designtype").designType == 1 or self:GetPageDescriptor(nil, "designtype").designType == 2 then
		-- Copy the unitframe object
		local design = RDXDB.ResolvePath(self:GetPageDescriptor(nil, "design").design);
		RDXDB.Copy(design, RDXDB.MakePath(pkg, wtype .. suffix .. "_ds"));
		local ufd = RDXDB.GetObjectData(RDXDB.MakePath(pkg, wtype .. suffix .. "_ds"));
		if not ufd then error("Missing design in wizard"); end
	elseif self:GetPageDescriptor(nil, "designtype").designType == 3 then
		-- do nothing, reuse a existing design
	elseif self:GetPageDescriptor(nil, "designtype").designType == 4 then
		-- Create a default empty object
		local dState = RDX.DesignState:new();
		
		-- simple object has default design
		if wtype == "ActionBar1" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 12, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "ab1", headervisiType = "None", headervisiCustom = "", nIcons = 12, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 1, barid = "mainbar1", selfcast = 1, headerstateType = "Defaultui", headerstateCustom = "", });
		elseif wtype == "ActionBar3" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 12, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "ab3", headervisiType = "None", headervisiCustom = "", nIcons = 12, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 1, barid = "bar3", selfcast = 1, headerstateType = "None", headerstateCustom = "", });
		elseif wtype == "ActionBar4" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 12, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "ab4", headervisiType = "None", headervisiCustom = "", nIcons = 12, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 1, barid = "bar4", selfcast = 1, headerstateType = "None", headerstateCustom = "", });
		elseif wtype == "ActionBar5" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 12, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "ab5", headervisiType = "None", headervisiCustom = "", nIcons = 12, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 1, barid = "bar5", selfcast = 1, headerstateType = "None", headerstateCustom = "", });
		elseif wtype == "ActionBar6" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 12, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "ab6", headervisiType = "None", headervisiCustom = "", nIcons = 12, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 1, barid = "bar6_druid_stealth", selfcast = 1, headerstateType = "None", headerstateCustom = "", });
		elseif wtype == "ActionBarStance" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 8, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "sb", headervisiType = "None", headervisiCustom = "", nIcons = 8, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 3, barid = "bar3", selfcast = 1, headerstateType = "None", headerstateCustom = "", });
		elseif wtype == "ActionBarPet" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 10, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "abp", headervisiType = "Pet", headervisiCustom = "", nIcons = 10, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 2, barid = "bar3", selfcast = 1, headerstateType = "None", headerstateCustom = "", });
		elseif wtype == "ActionBarVehicle" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_size_spacing").size , w = (self:GetPageDescriptor(nil, "d_size_spacing").size + self:GetPageDescriptor(nil, "d_size_spacing").spacing) * 3, alpha = 1, });
			dState:AddFeature({feature = "listbuttons", version = 1, name = "abp", headervisiType = "Vehicle", headervisiCustom = "", nIcons = 3, owner = "Base", flo = 2, anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, rows = 1, orientation = "RIGHT", iconspx = self:GetPageDescriptor(nil, "d_size_spacing").spacing, iconspy = 0, w = self:GetPageDescriptor(nil, "d_size_spacing").size, h = self:GetPageDescriptor(nil, "d_size_spacing").size, flyoutdirection = "UP", driver = self:GetPageDescriptor(nil, "d_skin_cd").driver, bs = self:GetPageDescriptor(nil, "d_skin_cd").bs, bkd = self:GetPageDescriptor(nil, "d_skin_cd").bkd, shader = 1, cd = self:GetPageDescriptor(nil, "d_skin_cd").cd, fontkey = self:GetPageDescriptor(nil, "d_font_multi").fontkey, fontmacro = self:GetPageDescriptor(nil, "d_font_multi").fontmacro, fontcount = self:GetPageDescriptor(nil, "d_font_multi").fontcount, showtooltip = 1, ftype = 4, barid = "bar3", selfcast = 1, headerstateType = "None", headerstateCustom = "", });
		elseif wtype == "TabManager1" or wtype == "TabManager2" or wtype == "TabManager3" or wtype == "TabManager4" then
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_base_default").h, w = self:GetPageDescriptor(nil, "d_base_default").w, alpha = 1, });
			dState:AddFeature({feature = "tabmanager", version = 1, owner = "Frame_decor", h = "BaseHeight", w = "BaseWidth", name = "tm1", anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, font = self:GetPageDescriptor(nil, "d_font").font, bkd = self:GetPageDescriptor(nil, "d_backdrop").bkd, orientation = "TOP", cfm = pkg .. ":" .. wtype .. suffix .. "_tm", });
		elseif wtype == "FactionBar" then
			dState:AddFeature(RDXDB.GetFeatureByName("Variables: Detailed Faction Info").CreateDescriptor());
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_base_default").h, w = self:GetPageDescriptor(nil, "d_base_default").w, alpha = 1, });
			dState:AddFeature({feature = "Subframe", owner = "Frame_decor", h = "BaseHeight", w = "BaseWidth", name = "subframe", anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, usebkd = 1, bkd = self:GetPageDescriptor(nil, "d_backdrop").bkd, flOffset = 1, });
			dState:AddFeature({feature = "statusbar_horiz", version = 1, owner = "Frame_decor", h = "BaseHeight", w = "BaseWidth", name = "statusBar", anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, bkd = {_bkdtype = 1, _backdrop = "none", _border = "none",}, drawLayer = self:GetPageDescriptor(nil, "d_texture").drawLayer, sublevel = self:GetPageDescriptor(nil, "d_texture").sublevel, orientation = "HORIZONTAL", texture = self:GetPageDescriptor(nil, "d_texture").texture, frac = "faction1", colorVar = "faction1cv", });
			dState:AddFeature({feature = "txt2", version = 1, owner = "Frame_decor", h = "BaseHeight", w = "BaseWidth", name = "infoText", anchor = {dx = 0, dy = 0, lp = "CENTER", rp = "CENTER", af = "Frame_decor",}, ftype = 3, txtdata = "faction1txt", tyo = "gold", font = self:GetPageDescriptor(nil, "d_font").font,});
		elseif wtype == "XpBar" then
			dState:AddFeature({feature = "Variable: Frac XP (fxp)", });
			dState:AddFeature({feature = "var_isExhaustion", });
			dState:AddFeature({feature = "ColorVariable: Static Color", name = "blue", color = {a = 1, b = 1, g = 0, r = 0}, });
			dState:AddFeature({feature = "ColorVariable: Static Color", name = "green", color = {a = 1, b = 0, g = 1, r = 0}, });
			dState:AddFeature({feature = "ColorVariable: Conditional Color", name = "xpcolor", colorVar1 = "blue", colorVar2 = "green", condVar = "isExhaustion", });
			dState:AddFeature({feature = "base_default", version = 1, h = self:GetPageDescriptor(nil, "d_base_default").h, w = self:GetPageDescriptor(nil, "d_base_default").w, alpha = 1, });
			dState:AddFeature({feature = "Subframe", owner = "Frame_decor", h = "BaseHeight", w = "BaseWidth", name = "subframe", anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, usebkd = 1, bkd = self:GetPageDescriptor(nil, "d_backdrop").bkd, flOffset = 1, });
			dState:AddFeature({feature = "statusbar_horiz", version = 1, owner = "Frame_decor", h = "BaseHeight", w = "BaseWidth", name = "statusBar", anchor = {dx = 0, dy = 0, lp = "TOPLEFT", rp = "TOPLEFT", af = "Frame_decor",}, bkd = {_bkdtype = 1, _backdrop = "none", _border = "none",}, drawLayer = self:GetPageDescriptor(nil, "d_texture").drawLayer, sublevel = self:GetPageDescriptor(nil, "d_texture").sublevel, orientation = "HORIZONTAL", texture = self:GetPageDescriptor(nil, "d_texture").texture, frac = "fxp", colorVar = "xpcolor", });
			dState:AddFeature({feature = "txt2", version = 1, owner = "Frame_decor", h = "BaseHeight", w = "BaseWidth", name = "infoText", anchor = {dx = 0, dy = 0, lp = "CENTER", rp = "CENTER", af = "Frame_decor",}, ftype = 3, txtdata = "fpxptxt", tyo = "gold", font = self:GetPageDescriptor(nil, "d_font").font,});
		else
			dState:AddFeature({feature = "base_default", version = 1, h = 20, w = 100, alpha = 1, });
		end
		
		obj = RDXDB._DirectCreateObject(pkg, wtype .. suffix .. "_ds");
		obj.ty = "Design"; obj.version = 1;
		obj.data = dState:GetDescriptor();
		dState = nil;
	end

	-- Generate highlights
	--local htAdded = nil;
	--pd = self:GetPageDescriptor(10);
	--htAdded = handleHighlight(pd.hlt1set, pd.hlt1color, ufd.data, 1, htAdded);
	--htAdded = handleHighlight(pd.hlt2set, pd.hlt2color, ufd.data, 2, htAdded);
	--htAdded = handleHighlight(pd.hlt3set, pd.hlt3color, ufd.data, 3, htAdded);
	--htAdded = handleHighlight(pd.hlt4set, pd.hlt4color, ufd.data, 4, htAdded);

	-- Generate alpha shader
	--pd = self:GetPageDescriptor(11);
	--handleAlpha(pd.alphaset, pd.falseAlpha, pd.trueAlpha, ufd.data);


	---------------------------- GENERATE WINDOW
	-- Create the window.
	local state = RDX.GenericWindowState:new();
	-- Frame:
	local frame = self:GetPageDescriptor(nil, "framing");
	if frame then frame = frame.frame; else frame = "Frame: None"; end
	state:AddFeature({feature = frame, title = title, });
	-- Design
	if self:GetPageDescriptor(nil, "designtype").designType == 1 or self:GetPageDescriptor(nil, "designtype").designType == 2 or self:GetPageDescriptor(nil, "designtype").designType == 4 then
		state:AddFeature({feature = "Design", design = RDXDB.MakePath(pkg, wtype .. suffix .. "_ds"), });
	else
		state:AddFeature({feature = "Design", design = self:GetPageDescriptor(nil, "design").design});
	end
	-- Datasource and Layout
	--if(wtype == 4) then
	--	state:AddFeature({feature = "Data Source: Secure", sortPath = RDXDB.MakePath(pkg, prefix .. "sort"); });
	--elseif(wtype == 1) or (wtype == 3) then
	--	state:AddFeature({feature = "Data Source: Sort", sortPath = RDXDB.MakePath(pkg, prefix .. "sort"); });
	--end
	if wtype == "ActionBar1" or wtype == "ActionBar3" or wtype == "ActionBar4" or wtype == "ActionBar5" or wtype == "ActionBar6" or wtype == "ActionBarStance" or wtype == "ActionBarPet" or wtype == "ActionBarVehicle" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "player", });
	elseif wtype == "Player_Main" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "player", switchvehicle = true, clickable = true, });
	elseif wtype == "Player_CastBar" or wtype == "Player_Alternate_Bar" or wtype == "Player_Buff_Secured_Icon" or wtype == "Player_Debuff_Icon" or wtype == "Cooline" or wtype == "ClassBar" or wtype == "Player_Cooldowns_Used" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "player", switchvehicle = true, });
	elseif wtype == "Target_Main" or wtype == "Target_CastBar" or wtype == "Target_Alternate_Bar" or wtype == "Target_Debuff" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "target", clickable = true, });
	elseif wtype == "Targettarget_Main" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "targettarget", clickable = true, });
	elseif wtype == "Pet_Main" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "pet", switchvehicle = true, clickable = true, });
	elseif wtype == "Pettarget_Main" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "pettarget", clickable = true, });
	elseif wtype == "Focus_Main" or wtype == "Focus_CastBar" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "focus", clickable = true, });
	elseif wtype == "Focustarget_Main" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "focustarget", clickable = true, });
	elseif wtype == "MiniMap" or wtype == "MiniMapButtons" or wtype == "MainPanel" or wtype == "MainMenu" or wtype == "Bags" or wtype == "TabManager1" or wtype == "TabManager2" or wtype == "TabManager3" or wtype == "TabManager4" or wtype == "FactionBar" or wtype == "XpBar" then
		state:AddFeature({feature = "layout_single_unitframe", version = 1, unit = "player", });
	elseif wtype == "Party_Main" then
		state:AddFeature({
			feature = "Data Source: Secure Set";
			set = {
				file = "default:Party_fset",
				class = "file",
			},
			rostertype = "RAID";
		});
		state:AddFeature({
			feature = "Header Grid";
			bkt = 1,
			switchvehicle = 1,
			dxn = 1,
			axis = 2,
			cols = 1,
		});
		state:AddFeature({
			feature = "mp_args";
			version = 1,
			period = 0.2,
			dpm1 = 0,
		});
	elseif wtype == "Partytarget_Main" then
		state:AddFeature({
			feature = "Data Source: Secure Set";
			set = {
				file = "default:Party_fset",
				class = "file",
			},
			rostertype = "RAID";
		});
		state:AddFeature({
			feature = "Secure Assists";
			interval = 0.2,
			suffix1 = "target",
			suffix2 = "targettarget",
		});
	--elseif wtype == "Partypet_Main" then
	--	state:AddFeature({
	--		feature = "Data Source: Secure Set";
	--		set = {
	--			file = "default:Party_fset",
	--			class = "file",
	--		},
	--		rostertype = "RAID";
	--	});
	--	state:AddFeature({
	--		feature = "Secure Assists";
	--		interval = 0.2,
	--		suffix1 = "target",
	--		suffix2 = "targettarget",
	--	});
	elseif wtype == "Raid_Main" then
		local header = self:GetPageDescriptor(20).header;
		header.pet = nil;
		state:AddFeature({
			feature = "header"; version = 1;
			header = header;
		});
		state:AddFeature({
			feature = "mp_args";
			version = 1,
			period = 0.2,
			dpm1 = 0,
		});
	elseif wtype == "Raidpet_Main" then
		local header = self:GetPageDescriptor(20).header;
		header.pet = true;
		state:AddFeature({
			feature = "header"; version = 1;
			header = header;
		});
		state:AddFeature({
			feature = "mp_args";
			version = 1,
			period = 0.2,
			dpm1 = 0,
		});
	elseif wtype == "Boss_Main" then
		state:AddFeature({
			feature = "Data Source: Secure Set";
			set = {
				file = "default:Boss_fset",
				class = "file",
			},
			rostertype = "BOSS";
		});
		state:AddFeature({
			feature = "Boss Layout";
			dxn = 1,
			cols = 1,
			axis = 1,
		});
		state:AddFeature({
			feature = "mp_args";
			version = 1,
			period = 0.2,
			dpm1 = 0,
		});
	elseif wtype == "Arena_Main" then
		state:AddFeature({
			feature = "Data Source: Secure Set";
			set = {
				file = "default:Arena_fset",
				class = "file",
			},
			rostertype = "ARENA";
		});
		state:AddFeature({
			feature = "Arena Layout";
			dxn = 1,
			cols = 1,
			axis = 1,
		});
		state:AddFeature({
			feature = "mp_args";
			version = 1,
			period = 0.2,
			dpm1 = 0,
		});
	elseif wtype == "Arenapet_Main" then
		state:AddFeature({
			feature = "Data Source: Secure Set";
			set = {
				file = "default:Arenapet_fset",
				class = "file",
			},
			rostertype = "ARENAPET";
		});
		state:AddFeature({
			feature = "Arena Layout";
			dxn = 1,
			cols = 1,
			axis = 1,
		});
		state:AddFeature({
			feature = "mp_args";
			version = 1,
			period = 0.2,
			dpm1 = 0,
		});
	end
	--if(wtype == 2) then
		-- Single Raid Header.
	--	state:AddFeature({
	--		feature = "header"; version = 1;
	--		header = self:GetPageDescriptor(5).header;
	--	});
	--else
		-- Determine grid layout settings.
	--	pd = self:GetPageDescriptor(8);
	--	local cols = 1; if pd.layout == 2 then cols = pd.cols; end
	--	local axis, dxn = 1, 1;
	--	if(wtype == 3) then -- Header grid
	--		if(cols > 1) then 
	--			axis = 2; dxn = 2; 
	--		else
	--			cols = 100;
	--		end
	--		state:AddFeature({
	--			feature = "Header Grid";
	--			axis = axis; dxn = dxn; cols = cols;
	--			hlt = true;
	--		});
	--	else
	--		state:AddFeature({
	--			feature = "Grid Layout";
	--			axis = 1; dxn = 2; cols = cols;
	--		});
	--	end
	--end
	-- MouseBindings
	if wtype == "Player_Main" or wtype == "Pet_Main" or wtype == "Targettarget_Main" or wtype == "Focustarget_Main" or wtype == "Party_Main" or wtype == "Partypet_Main" or wtype == "Raid_Main" or wtype == "Raidpet_Main" then
		state:AddFeature({feature = "mousebindings", version = 1, hotspot = "heal", mbFriendly = "bindings:bindings_heal", });
		state:AddFeature({feature = "mousebindings", version = 1, hotspot = "player", mbFriendly = "bindings:bindings_player", });
		state:AddFeature({feature = "mousebindings", version = 1, hotspot = "decurse", mbFriendly = "bindings:bindings_decurse", });
	elseif wtype == "Target_Main" or wtype == "Pettarget_Main" or wtype == "Focus_Main" or wtype == "Partytarget_Main" or wtype == "Boss_Main" or wtype == "Bosspet_Main" or wtype == "Arena_Main" or wtype == "Arenapet_Main" then
		state:AddFeature({feature = "mousebindings", version = 1, hotspot = "dmg", mbFriendly = "bindings:bindings_dmg", });
		state:AddFeature({feature = "mousebindings", version = 1, hotspot = "target", mbFriendly = "bindings:bindings_target", });
		state:AddFeature({feature = "mousebindings", version = 1, hotspot = "interrupt", mbFriendly = "bindings:bindings_interrupt", });
	elseif wtype == "Target_CastBar" then
		state:AddFeature({feature = "mousebindings", version = 1, hotspot = "interrupt", mbFriendly = "bindings:bindings_interrupt", });
	end

	-- Create the subobjects
	obj = RDXDB._DirectCreateObject(pkg, wtype .. suffix);
	obj.ty = "Window"; obj.version = 1;
	obj.data = state:GetDescriptor();
	state = nil;

	-- Create the wizard object
	--obj = RDXDB._DirectCreateObject(pkg, prefix .. "wz");
	--obj.ty = "WindowWizard"; obj.version = 2;
	--obj.data = self:GetDescriptor();

	-- Open the window!
	DesktopEvents:Dispatch("WINDOW_OPEN", RDXDB.MakePath(pkg, wtype .. suffix), true);
end

ww.title = "Window Wizard";
RDX.windowWizard = ww;

function RDX.NewWindowWizard()
	RDX.windowWizard:SetDescriptor({});
	RDX.windowWizard:Open(VFLDIALOG);
end

------------------------------------
-- Glue the Window Wizard to RDX.
------------------------------------
RDXDB.RegisterObjectType({
	name = "WindowWizard",
	invisible = true;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = "Open",
			OnClick = function()
				VFL.poptree:Release();
				if md.version ~= 2 then
					VFL.TripError("RDX", "Old WindowWizard data version. Cannot open.", "");
					return;
				end
				RDX.windowWizard:SetDescriptor(md.data);
				RDX.windowWizard:Open(VFLDIALOG);
			end
		});
	end,
});

