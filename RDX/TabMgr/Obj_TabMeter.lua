

-- Create a cell in the data table
local function CreateCell(parent)
	local self = VFLUI.AcquireFrame("Button");
	VFLUI.StdSetParent(self, parent); self:SetHeight(10);
	
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	local sbt = VFLUI.StatusBarTexture:new(parent, nil, nil, "ARTWORK", 1);
	sbt:SetOrientation("HORIZONTAL");
	sbt:SetValue(1)
	sbt:SetAllPoints(self); sbt:Show();
	self.sbt = sbt;
	
	-- Create the button highlight texture
	local hltTexture = VFLUI.CreateTexture(self);
	hltTexture:SetAllPoints(self); hltTexture:Show();
	hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	hltTexture:SetBlendMode("ADD");
	self:SetHighlightTexture(hltTexture);
	self.hltTexture = hltTexture;
	
	local nameText = VFLUI.CreateFontString(self);
	nameText:SetDrawLayer("OVERLAY");
	VFLUI.SetFont(nameText, Fonts.Default, 9);
	nameText:SetShadowOffset(1,-1);
	nameText:SetShadowColor(0,0,0,.6);
	nameText:SetTextColor(1,1,1,1); nameText:SetJustifyH("LEFT");
	nameText:SetAllPoints(self);
	nameText:SetHeight(10);
	nameText:Show();
	self.nameText = nameText;
	
	local nText = VFLUI.CreateFontString(self);
	nText:SetDrawLayer("OVERLAY");
	VFLUI.SetFont(nText, Fonts.Default, 9);
	nText:SetShadowOffset(1,-1);
	nText:SetShadowColor(0,0,0,.6);
	nText:SetTextColor(1,1,1,1); nText:SetJustifyH("RIGHT");
	nText:SetAllPoints(self);
	nText:SetHeight(10);
	nText:Show();
	self.nText = nText;


	-- Update the Destroy function
	self.Destroy = VFL.hook(function(s)
		s.nameText:Destroy(); s.nameText = nil;
		s.nText:Destroy(); s.nText = nil;
		-- Destroy textures
		if s.hltTexture then s.hltTexture:Destroy(); s.hltTexture = nil; end
		s.sbt:Destroy(); s.sbt = nil;
	end, self.Destroy);
	self.OnDeparent = self.Destroy;

	return self;
end



-- The Window object type.
RDXDB.RegisterObjectType({
	name = "TabMeter";
	isFeatureDriven = true;
	invisible = true;
	New = function(path, md)
		md.version = 1;
		md.data = {};
	end,
	Edit = function(path, md, parent)
		RDX.EditTableMeterDialog(parent or VFLFULLSCREEN, path, md, function(data) local inst = RDXDB.GetObjectInstance(path); inst:SetFilter(RDXLF.SelectFunctor(data)); inst:Reset(); end);
	end,
	Instantiate = function(path, md)
		local mf = VFLUI.AcquireFrame("Frame");
		
		local data = VFLUI.List:new(mf, 12, CreateCell); 
		data:Show();
		mf.data = data;
		
		local function layout()
			local w = mf:GetWidth();
			local h = mf:GetHeight();
			data:ClearAllPoints();
			data:SetPoint("CENTER", mf, "CENTER");
			data:SetWidth(w - 2);
			data:SetHeight(h - 2);
			data:Rebuild();
		end
		mf:SetScript("OnShow", layout);
		mf:SetScript("OnSizeChanged", layout);
		
		local x = RDXLF.GetTM(path);
		x:SetFilter(RDXLF.SelectFunctor(md.data));
		RDXEvents:Bind("LOG_ROW_ADDED", x, x.Update, x);
		mf.tbmeter = x;
		
		mf.a = {};
		mf.cp = 0;
		
		mf.data:SetDataSource(function(cell, data, pos, absPos)
			cell:SetScript("OnClick", nil);
			cell.nameText:SetText(data.unit.name or "None");
		end, VFL.ArrayLiterator(mf.a));
		
		--function
		VFLT.AdaptiveUnschedule2("TabMeter" .. path)
		VFLT.AdaptiveSchedule2("TabMeter" .. path, 1, function()
			if mf.tbmeter then
				local size = mf.tbmeter:Size();
				if mf.cp < size then
					VFL.empty(mf.a);
					local tmp = mf.tbmeter:GetData();
					for k, v in pairs (tmp) do
						table.insert(mf.a, v);
					end
					mf.cp = size;
				end
				--sort
				mf.data:Update();
			end
		end)
		

		return mf;
	end,
	Deinstantiate = function(instance, path, md)
		--instance:_Hide(RDX.smooth, nil, function() instance:Destroy(); instance._path = nil; instance = nil; end);
		--if instance.m then
		--	instance.m:Destroy();
		--	instance.m = nil;
		--end
		VFLT.AdaptiveUnschedule2("TabMeter" .. path)
		instance.data:Destroy()
		VFL.empty(instance.a);
		instance.a = nil;
		instance.cp = nil;
		instance.tbmeter = nil;
		instance:Destroy();
		instance = nil;
	end,
	OpenTab = function(tabbox, path, md, objdesc, desc, tm)
		local tabtitle, tabwidth = "Tab", 80;
		for k, v in pairs(md.data) do
			--if v.feature == "taboptions" then
			--	tabtitle = v.tabtitle;
			--	tabwidth = v.tabwidth;
			--end
		end
		local f = RDXDB.GetObjectInstance(path);
		local tab = tabbox:GetTabBar():AddTab(tabwidth, function(self, arg1)
			tabbox:SetClient(f);
			VFLUI.SetBackdrop(f, desc.bkd);
			--f.font = desc.font;
			--if f.NxWin then f.NxWin:Enable(); end
		end,
		function()
			--if f.NxWin then f.NxWin:Disable(); end
		end, 
		function(mnu, dlg) 
			return objdesc.GenerateBrowserMenu(mnu, path, nil, dlg, tm)
		end);
		tab.font:SetText(tabtitle);
		tab.f = f;
		return tab;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg, tm)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
		local feat = RDXDB.GetFeatureData(path, "Design");
		if not feat then feat = RDXDB.GetFeatureData(path, "Assist Frames"); end
		if feat then
			local upath = feat["design"];
			table.insert(mnu, {
				text = VFLI.i18n("Edit Design"),
				func = function() 
					VFL.poptree:Release();
					if IsShiftKeyDown() then
						RDXDB.OpenObject(upath, "Edit", VFLDIALOG, true);
					else
						RDXDB.OpenObject(upath, "Edit", VFLDIALOG);
					end
				end
			});
		end
		if tm then 
			table.insert(mnu, {
				text = VFLI.i18n("Close Tab");
				func = function()
					VFL.poptree:Release();
					tm:RemoveTab(path, true);
				end;
			});
		end
	end,
});