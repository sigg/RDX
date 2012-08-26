-- PlayerWizard.lua
-- OpenRDX
-- Sigg
--

-- Implementation of the Window Wizard.
local ww = RDXUI.Wizard:new();

---------------------------------------------
-- WIZARD PAGES
---------------------------------------------
ww:RegisterPage(1, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Package/Prefix");
		
		local lbl = VFLUI.MakeLabel(nil, page, "Select a package to create your new window in. You may select a preexisting package or enter a name for a new package.\n\nPackage names must contain only alphanumeric characters and underscores.");
		lbl:SetWidth(250); lbl:SetHeight(60);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		local edPkg = RDXDB.PackageSelector:new(page);
		edPkg:SetPoint("TOPRIGHT", lbl, "BOTTOMRIGHT"); edPkg:SetWidth(225); edPkg:Show();
		if desc and desc.pkg then edPkg:SetPackage(desc.pkg); end

		local lbl = VFLUI.MakeLabel(nil, page, "Enter a prefix for this window. The prefix will be added to each of this window's objects. By using different prefixes, you can create multiple windows in a single package.");
		lbl:SetWidth(250); lbl:SetHeight(40);
		lbl:SetPoint("TOPRIGHT", edPkg, "BOTTOMRIGHT", 0, -10);
		local edPfx = VFLUI.Edit:new(page);
		edPfx:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		edPfx:SetHeight(25); edPfx:SetWidth(250); edPfx:Show();
		if desc and desc.prefix then edPfx:SetText(desc.prefix); end

		local lbl = VFLUI.MakeLabel(nil, page, "Enter a window title for this window.");
		lbl:SetWidth(250); lbl:SetHeight(10);
		lbl:SetPoint("TOPRIGHT", edPfx, "BOTTOMRIGHT", 0, -10);
		local edTtl = VFLUI.Edit:new(page);
		edTtl:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		edTtl:SetHeight(25); edTtl:SetWidth(250); edTtl:Show();
		if desc and desc.title then edTtl:SetText(desc.title); end

		function page:GetDescriptor()
			local pt = VFL.trim(edPfx:GetText());
			if (pt ~= "") and (not string.find(pt, "_$")) then pt = pt .. "_"; end
			return { pkg = edPkg:GetPackage(); prefix = pt; title = edTtl:GetText(); };
		end

		page.Destroy = VFL.hook(function(s)
			edPkg:Destroy(); edPkg = nil;
			edPfx:Destroy(); edPfx = nil;
			edTtl:Destroy(); edTtl = nil;
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(2); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.pkg) then errs:AddError("Invalid package name."); end
		if (not desc.prefix) then errs:AddError("Invalid prefix."); end
		return not errs:HasError();
	end;
});
ww:RegisterPage(2, {
	OpenPage = function(parent, wizard, desc)
		-- Formulate our page first.
		local txt = "";
		local p1d = wizard:GetPageDescriptor(1);
		if not RDXDB.GetPackage(p1d.pkg) then
			txt = txt .. "The package '" .. p1d.pkg .. "' does not exist and will be created.\n";
		end

		local chk = p1d.pkg .. ":" .. p1d.prefix .. "window";
		if RDXDB.GetObjectData(chk) then
			txt = txt .. "The data files for this window already exist. If you proceed, they will be overwritten and the window will be rebuilt from scratch.\n";
		end

		if txt == "" then wizard:SetPage(3); return; end -- Peaceout if we don't have anything to say.
		txt = txt .. "\nClick Next to confirm, or Cancel to abort.";

		local page = RDXUI.GenerateStdWizardPage(parent, "Confirm");
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetWidth(250); lbl:SetHeight(80); lbl:SetJustifyV("TOP");
		lbl:SetText(txt);
		page:SetHeight(80);

		wizard:OnNext(function(wiz) wiz:SetPage(3); end);
		return page;
	end;
	Verify = VFL.True;
});

-------------------------------------------
-- Pg 3: Framing page
-------------------------------------------
ww:RegisterPage(3, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Framing");
		parent:SetBackdropColor(1,1,1,0.4);
		local lbl = VFLUI.MakeLabel(nil, page, "Select a frame for the window:");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		-- Build sample window
		local state = RDX.WindowState:new();
		state:AddFeature({feature = "Frame: Default"});
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
		wizard:OnNext(function(wiz) wiz:SetPage(9); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.frame) then errs:AddError("Invalid style."); end
		return not errs:HasError();
	end
});

-----------------------------------------------------------
-- Pg. 4: Type page
-----------------------------------------------------------
ww:RegisterPage(4, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Window Type");
		local lbl = VFLUI.MakeLabel(nil, page, "Select the type of window you want to create. Clickable windows cannot sort or filter while in combat.");
		lbl:SetWidth(250); lbl:SetHeight(30);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local btn1 = VFLUI.Button:new(page);
		btn1:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT", 5, -15);
		btn1:SetWidth(25); btn1:SetHeight(25); btn1:Show(); btn1:SetText(">");
		local blbl = VFLUI.MakeLabel(nil, page, "A window that can filter and re-sort in combat. |cFFFF0000Not clickable.|r |cFF00FF00Works in parties or raids.|r |cFF666666(Grid Layout)|r");
		blbl:SetWidth(200); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn1, "RIGHT");
		wizard:MakeNextButton(btn1, function(w, dsc)
			dsc.windowType = 1; w:SetPage(6);
		end);
		
		local btn2 = VFLUI.Button:new(page);
		btn2:SetPoint("TOP", btn1, "BOTTOM", 0, -20);
		btn2:SetWidth(25); btn2:SetHeight(25); btn2:Show(); btn2:SetText(">");
		blbl = VFLUI.MakeLabel(nil, page, "A simple, one-column group or class window that can filter in combat, but cannot sort. |cFF00FF00Clickable.|r |cFFFF0000Works in raids only.|r |cFF666666(Single Raid Header)|r");
		blbl:SetWidth(200); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn2, "RIGHT");
		wizard:MakeNextButton(btn2, function(w, dsc)
			dsc.windowType = 2; w:SetPage(5);
		end);

		local btn3 = VFLUI.Button:new(page);
		btn3:SetPoint("TOP", btn2, "BOTTOM", 0, -20);
		btn3:SetWidth(25); btn3:SetHeight(25); btn3:Show(); btn3:SetText(">");
		blbl = VFLUI.MakeLabel(nil, page, "A filtered window in a grid layout. |cFF00FF00Clickable. Works in parties or raids. No sorting artifacts.|r |cFFFF0000Cannot show pets!|r |cFF666666(Header Grid)|r");
		blbl:SetWidth(200); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn3, "RIGHT");
		wizard:MakeNextButton(btn3, function(w, dsc)
			dsc.windowType = 3; w:SetPage(6);
		end);

		local btn4 = VFLUI.Button:new(page);
		btn4:SetPoint("TOP", btn3, "BOTTOM", 0, -20);
		btn4:SetWidth(25); btn4:SetHeight(25); btn4:Show(); btn4:SetText(">");
		blbl = VFLUI.MakeLabel(nil, page, "A filtered window in a grid layout. |cFF00FF00Clickable. Works in parties or raids. Can show pets. |r |cFFFF0000Sorting artifacts!|r |cFF666666(secure Grid Layout)|r");
		blbl:SetWidth(200); blbl:SetHeight(40); blbl:SetPoint("LEFT", btn4, "RIGHT");
		wizard:MakeNextButton(btn4, function(w, dsc)
			dsc.windowType = 4; w:SetPage(6);
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
-- Page 5: Header definition (for single-header windows)
--------------------------------------------------------
ww:RegisterPage(5, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Header Definition");
		page:SetWidth(315); page:SetHeight(350);

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
		wizard:OnNext(function(wiz) wiz:SetPage(9); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.header) then errs:AddError("Please create a header definition."); end
		return not errs:HasError();
	end
});

--------------------------------------------------------
-- Page 6: Filter definition (for grid-shaped windows)
--------------------------------------------------------
ww:RegisterPage(6, {
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
});

--------------------------------------------------------
-- Page 7: Sort definition (for grid-shaped windows)
--------------------------------------------------------
ww:RegisterPage(7, {
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
		rg_sort:SetWidth(250); rg_sort:SetHeight(16*math.ceil(nSorts/2));
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
});

--------------------------------------------------------
-- Page 8: Layout definition (for grid-shaped windows)
--------------------------------------------------------
ww:RegisterPage(8, {
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
});

--------------------------------------------------------
-- Page 9: The Infamous Unitframe Page
--------------------------------------------------------
ww:RegisterPage(9, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Design");
		parent:SetBackdropColor(1,1,1,0.4);
		page:SetWidth(300); page:SetHeight(220);
		local lbl = VFLUI.MakeLabel(nil, page, "Choose a unit frame design for your window. A preview will be shown below.");
		lbl:SetWidth(300); lbl:SetHeight(20);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		-- Design chooser box
		local ofDesign = RDXDB.ObjectFinder:new(page, function(p,f,md) return (md and type(md) == "table" and md.ty == "Design"); end);
		ofDesign:SetPoint("BOTTOM", page, "BOTTOM");
		ofDesign:SetWidth(300); ofDesign:Show();
		ofDesign:SetLabel("Frame type:");
		if desc and desc.design then ofDesign:SetPath(desc.design); end

		-- Unitframe sample renderer
		local curUF, curDesign = nil, nil;
		local function UpdateUnitFrameDesign()
			local design = ofDesign:GetPath();
			if design == curDesign then return; end
			-- Destroy the old frame
			if curUF then curUF:Destroy(); curUF = nil; end
			-- Load the new design.
			local ufState = RDX.LoadUnitFrameDesign(design, nil, RDX._exportedWindowState);
			if not ufState then return; end
			local createFrame = RDX.UnitFrameGeneratingFunctor(ufState);
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
		wizard:OnNext(function(wiz) wiz:SetPage(20); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if not desc.design then 
			errs:AddError("Missing design");
		else
			if not RDX.LoadUnitFrameDesign(desc.design, RDXDB.ObjectState.Verify, RDX._exportedWindowState) then
				VFL.AddError(errs, "Could not load UnitFrameDesign at <" .. tostring(desc.design) .. ">.");
			end
		end
		return not errs:HasError();
	end
});

--------------------------------------------------------
-- Page 10: Add Highlights
--------------------------------------------------------
ww:RegisterPage(10, {
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

--------------------------------------------------------
-- Page 11: Add alpha fade
--------------------------------------------------------
ww:RegisterPage(11, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Alpha Fade");
		page:SetWidth(300); page:SetHeight(250);
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

--------------------------------------------------------
-- Page 12: Mouse bindings
--------------------------------------------------------
ww:RegisterPage(12, {
	OpenPage = function(parent, wizard, desc)
		-- Figure out if we're secure or not. If not, just peaceout.
		local p4d = wizard:GetPageDescriptor(4);
		if p4d.windowType == 1 then
			wizard:SetPage(20); return;
		end

		local page = RDXUI.GenerateStdWizardPage(parent, "Mouse Bindings");
		page:SetWidth(300); page:SetHeight(150);
		local lbl = VFLUI.MakeLabel(nil, page, "TEXT");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetWidth(250); lbl:SetHeight(20); lbl:SetJustifyV("TOP");
		lbl:SetText("Select mouse bindings for this window. Mouse bindings determine what happens when you click on this window.");

		local btype = VFLUI.DisjointRadioGroup:new();

		local btype_none = btype:CreateRadioButton(page);
		btype_none:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		btype_none:SetWidth(250); btype_none:Show();
		btype_none:SetText("No mouse bindings");

		local btype_intl = btype:CreateRadioButton(page);
		btype_intl:SetPoint("TOPLEFT", btype_none, "BOTTOMLEFT");
		btype_intl:SetWidth(250); btype_intl:Show();
		btype_intl:SetText("Use RDX mouse bindings");

		local ofMB = RDXDB.ObjectFinder:new(page, function(p,f,md) return (md and type(md) == "table" and md.ty=="MouseBindings"); end);
		ofMB:SetWidth(300); ofMB:SetPoint("TOPLEFT", btype_intl, "BOTTOMLEFT"); ofMB:Show();
		ofMB:SetLabel("Bindings:");
		if desc and desc.mb then ofMB:SetPath(desc.mb); end

		local btype_extl = nil;
		if wizard:GetPageDescriptor(4).windowType ~= 4 then
	  	btype_extl = btype:CreateRadioButton(page);
			btype_extl:SetPoint("TOPLEFT", ofMB, "BOTTOMLEFT");
			btype_extl:SetWidth(250); btype_extl:Show();
			btype_extl:SetText("Use external program (Clique etc.)");
		end

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

		wizard:OnNext(function(wiz) wiz:SetPage(20); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		return not errs:HasError();
	end
});

--------------------
-- Page 20 (done)
--------------------
ww:RegisterPage(20, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Done!");
		local lbl = VFLUI.MakeLabel(nil, page, "You have now entered all information necessary to create your window.\n\nIf you click OK, your window will be created and moved to the center of the screen.\n\nIf you choose Cancel, this process will be aborted and no changes will be made.");
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		lbl:SetWidth(250); lbl:SetHeight(110); lbl:SetJustifyV("TOP");
		page:SetHeight(130);

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
	pd = self:GetPageDescriptor(4);
	if not pd then error("Missing window type"); end
	local wtype = pd.windowType;
	if type(wtype) ~= "number" then error("Bad window type (should be impossible!)"); end
	-- Setup the package/prefix
	pd = self:GetPageDescriptor(1);
	local pkg, prefix, title = pd.pkg, pd.prefix, pd.title;
	local pkgData = RDXDB.GetOrCreatePackage(pkg);
	if not pkgData then error("Bad package in window wizard (should be impossible!)"); end


	------------------------- CLEANUP PREEXISTING
	-- Delete all preexisting files in that package, destroying instances as well.
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, prefix .. "set"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, prefix .. "sort"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, prefix .. "unitframe"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, prefix .. "window"));
	RDXDB.DeleteObject(RDXDB.MakePath(pkg, prefix .. "wizard"));
	-- Excise the window's definition from the window manager.
	--RDXDK._CloseWindowRDX(RDXDB.MakePath(pkg, prefix .. "window"));
	RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, RDXDB.MakePath(pkg, prefix .. "window"));

	-------------------------- GENERATE SET AND SORT IF NECESSARY
	if wtype ~= 2 then
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
	end

	---------------------------- GENERATE UNITFRAME
	-- Copy the unitframe object
	local design = RDXDB.ResolvePath(self:GetPageDescriptor(9).design);

	RDXDB.Copy(design, RDXDB.MakePath(pkg, prefix .. "_ds"));
	local ufd = RDXDB.GetObjectData(RDXDB.MakePath(pkg, prefix .. "_ds"));
	if not ufd then error("Missing design in wizard"); end

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
	local frame = self:GetPageDescriptor(3);
	if frame then frame = frame.frame; else frame = "Frame: Default"; end
	state:AddFeature({
		feature = frame,
		title = title,
	});
	-- Unitframe
	state:AddFeature({feature = "UnitFrame", design = RDXDB.MakePath(pkg, prefix .. "unitframe"); });
	-- Datasource
	if(wtype == 4) then
		state:AddFeature({feature = "Data Source: Secure", sortPath = RDXDB.MakePath(pkg, prefix .. "sort"); });
	elseif(wtype == 1) or (wtype == 3) then
		state:AddFeature({feature = "Data Source: Sort", sortPath = RDXDB.MakePath(pkg, prefix .. "sort"); });
	end
	-- Layout
	if(wtype == 2) then
		-- Single Raid Header.
		state:AddFeature({
			feature = "header"; version = 1;
			header = self:GetPageDescriptor(5).header;
		});
	else
		-- Determine grid layout settings.
		pd = self:GetPageDescriptor(8);
		local cols = 1; if pd.layout == 2 then cols = pd.cols; end
		local axis, dxn = 1, 1;
		if(wtype == 3) then -- Header grid
			if(cols > 1) then 
				axis = 2; dxn = 2; 
			else
				cols = 100;
			end
			state:AddFeature({
				feature = "Header Grid";
				axis = axis; dxn = dxn; cols = cols;
				hlt = true;
			});
		else
			state:AddFeature({
				feature = "Grid Layout";
				axis = 1; dxn = 2; cols = cols;
			});
		end
	end
	-- Mousebindings
	if(wtype ~= 1) then
		pd = self:GetPageDescriptor(12);
		if pd.btype == 2 then
			state:AddFeature({feature = "mousebindings", version = 1, mbFriendly = pd.mb});
		elseif pd.btype == 3 then
			state:AddFeature({feature = "Mouse Bindings (Exported)"});
		end
	end

	-- Create the subobjects
	obj = RDXDB._DirectCreateObject(pkg, prefix .. "window");
	obj.ty = "Window"; obj.version = 1;
	obj.data = state:GetDescriptor();
	state = nil;

	-- Create the wizard object
	obj = RDXDB._DirectCreateObject(pkg, prefix .. "wizard");
	obj.ty = "WindowWizard"; obj.version = 2;
	obj.data = self:GetDescriptor();

	-- Open the window!
	--RDXDK._OpenWindowRDX(RDXDB.MakePath(pkg, prefix .. "window"));
	RDXDK.QueueLockdownAction(RDXDK._OpenWindowRDX, RDXDB.MakePath(pkg, prefix .. "window"));
end

ww.title = "Player Window Wizard";
RDX.PlayerWizard = ww;

------------------------------------
-- Glue the Window Wizard to RDX.
------------------------------------
--RDXDB.RegisterObjectType({
--	name = "WindowWizard",
--	GenerateBrowserMenu = function(mnu, path, md, dlg)
--		table.insert(mnu, {
--			text = "Open",
--			OnClick = function()
--				VFL.poptree:Release();
--				if md.version ~= 2 then
--					VFL.TripError("RDX", "Old WindowWizard data version. Cannot open.", "");
--					return;
--				end
--				RDX.windowWizard:SetDescriptor(md.data);
--				RDX.windowWizard:Open(VFLDIALOG);
--			end
--		});
--	end,
--});

RDXDB.wizardMenu:RegisterMenuFunction(function(ent)
	ent.text = "Add Player Window";
	ent.OnClick = function()
		VFL.poptree:Release();
		VFL.print("Add Player Window in " .. RDXDB.pkgname);
		RDX.PlayerWizard:SetDescriptor({pkg = RDXDB.pkgname, prefix = "Player_Main"});
		RDX.PlayerWizard:Open(VFLDIALOG);
	end;
end);

