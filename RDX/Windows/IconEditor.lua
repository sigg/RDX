------------------------------------------------------
-- NOMINATIVE SET EDITOR
-- The nominative set editor is a panel of 3 buttons that attaches to a window that has
-- a NominativeSet as its underlying set.
------------------------------------------------------
RDX.RegisterFeature({
	name = "NominativeSet Editor";
	title = VFLI.i18n("Icon NominativeSet"),
	category = VFLI.i18n("Icon Editor"),
	IsPossible = function(state)
		if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("SetDataSource") then return nil; end
		if not state:Slot("Layout") then return nil; end
		if state:Slot("NominativeSetEditor") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		state:AddSlot("NominativeSetEditor");
		local set = state:RunSlot("SetDataSource");
		if (not set) or (not set.name) then
			VFL.AddError(errs, VFLI.i18n("Missing underlying Set"));
			return nil;
		end
		if not set.AddName then
			VFL.AddError(errs, VFLI.i18n("Underlying set is not nominative"));
			return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local btnPlus, btnMinus, btnStar;
		local set = state:RunSlot("SetDataSource");
		local path = set.path;
		local orientation = desc.orientation or "LEFT";

		-- Upon window creation, generate the framepool's fallback function.
		state:_Attach(state:Slot("Create"), true, function(w)
			
			-- Allow this window to be used for drag/drop operations from the
			-- roster screen.
			RDXUI.dc_RaidMembers:RegisterDragTarget(w);
			function w:OnDrop(dropped)
				local n = dropped.data; if type(n) ~= "string" then return; end
				RDXDB.OpenObject(path, "Twiddle", n, true);
			end
			
			btnStar = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\RDX\\Skin\\menu");
			btnStar:SetHighlightColor(0,1,1,1);
			w:AddButton(btnStar);		
			btnStar:SetScript("OnClick", function()
				RDXDB.OpenObject(path, "Edit", VFLDIALOG);
			end);
			
			btnMinus = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\minus");
			btnMinus:SetHighlightColor(1,0,0,1);
			w:AddButton(btnMinus);		
			btnMinus:SetScript("OnClick", function()
				local n = UnitName("target"); if not n then return; end
				n = string.lower(n);
				RDXDB.OpenObject(path, "Twiddle", n, nil);
			end);

			btnPlus = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\plus");
			btnPlus:SetHighlightColor(0,1,0,1);
			w:AddButton(btnPlus);
			btnPlus:SetScript("OnClick", function()
				local n = UnitName("target"); if not n then return; end
				if not UnitIsPlayer("target") then return; end
				n = string.lower(n);
				RDXDB.OpenObject(path, "Twiddle", n, true);
			end);

		end);
		
		-- Upon window destruction, also destroy the underlying framepool.
		state:_Attach(state:Slot("Destroy"), true, function(w)
			RDXUI.dc_RaidMembers:UnregisterDragTarget(w); w.OnDrop = nil;
		end);

		return true;
	end,
--[[	UIFromDescriptor = function(desc, parent)
		local self = VFLUI.RadioGroup:new(parent);
		self:SetLayout(2,2);
		self.buttons[1]:SetText("Orient Left");
		self.buttons[2]:SetText("Orient Right");
		if desc and desc.orientation and desc.orientation == "RIGHT" then
			self:SetValue(2);
		else
			self:SetValue(1);
		end

		function self:GetDescriptor()		
			local ori = "LEFT";
			if self:GetValue() == 2 then ori = "RIGHT"; end
			return {feature = "NominativeSet Editor", orientation = ori;};
		end

		return self;
	end, ]] --
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return { feature = "NominativeSet Editor" }; end,
});

-- Sort Editor feature
RDX.RegisterFeature({
	name = "Sort Editor",
	title = VFLI.i18n("Icon Sort"),
	category = VFLI.i18n("Icon Editor"),
	IsPossible = function(state)
		if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("SortDataSource") then return nil; end
		if not state:Slot("Layout") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		local sort = state:RunSlot("SortDataSource");
		if (not sort) or (not sort.name) then
			VFL.AddError(errs, VFLI.i18n("Missing underlying Sort"));
			return nil;
		end
		--if not set.SetFilter then
		--	VFL.AddError(errs, VFLI.i18n("Underlying set is not a FilterSet."));
		--	return nil;
		--end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local sort = state:RunSlot("SortDataSource");
		local path = sort.name;
		local btn;

		-- Upon window creation, generate the framepool's fallback function.
		state:_Attach(state:Slot("Create"), true, function(w)
			btn = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\RDX\\Skin\\sync");
			btn:SetHighlightColor(1,1,0,1);
			w:AddButton(btn);
			btn:SetScript("OnClick", function()
				RDXDB.OpenObject(path, "Edit", VFLDIALOG);
			end);
		end);
		
		state:Attach("Menu", true, function(win, mnu)
			table.insert(mnu, {
				text = VFLI.i18n("Edit Sort");
				func = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Edit", VFLDIALOG);
				end;
			});
		end);

		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		return nil;
	end,
	CreateDescriptor = function() return { feature = "Sort Editor" }; end,
});

-- Filter Set Editor feature, for creating easily filterable windows.
RDX.RegisterFeature({
	name = "FilterSet Editor",
	title = VFLI.i18n("Icon FilterSet"),
	category = VFLI.i18n("Icon Editor"),
	IsPossible = function(state)
		if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("SetDataSource") then return nil; end
		if not state:Slot("Layout") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		local set = state:RunSlot("SetDataSource");
		if (not set) or (not set.name) then
			VFL.AddError(errs, VFLI.i18n("Missing underlying Set"));
			return nil;
		end
		if not set.SetFilter then
			VFL.AddError(errs, VFLI.i18n("Underlying set is not a FilterSet"));
			return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local set = state:RunSlot("SetDataSource");
		local path = set.path;
		local btn;

		-- Upon window creation, generate the framepool's fallback function.
		state:_Attach(state:Slot("Create"), true, function(w)
			btn = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\RDX\\Skin\\funnel");
			btn:SetHighlightColor(1,1,0,1);
			w:AddButton(btn);
			btn:SetScript("OnClick", function()
				RDXDB.OpenObject(path, "Edit", VFLDIALOG);
			end);
		end);
		
		state:Attach("Menu", true, function(win, mnu)
			table.insert(mnu, {
				text = VFLI.i18n("Edit FilterSet");
				func = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Edit", VFLDIALOG);
				end;
			});
		end);

		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		return nil;
	end,
	CreateDescriptor = function() return { feature = "FilterSet Editor" }; end,
});

-- Table Meter Editor feature.
RDX.RegisterFeature({
	name = "TableMeter Editor",
	title = VFLI.i18n("Icon TableMeter"),
	category = VFLI.i18n("Icon Editor"),
	IsPossible = function(state)
		if not state:Slot("UnitWindow") then return nil; end
		if not state:Slot("SetDataSource") then return nil; end
		if not state:Slot("Layout") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc.path then return nil; end
		--local set = state:RunSlot("SetDataSource");
		--if (not set) or (not set.name) then
		--	VFL.AddError(errs, VFLI.i18n("Underlying set is missing or invalid."));
		--	return nil;
		--end
		--if not set.SetFilter then
		--	VFL.AddError(errs, VFLI.i18n("Underlying set is not a FilterSet."));
		--	return nil;
		--end
		return true;
	end;
	ApplyFeature = function(desc, state)
		--local set = state:RunSlot("SetDataSource");
		local path = desc.path;
		local pkg,file = RDXDB.ParsePath(path);
		local btn;

		-- Upon window creation, generate the framepool's fallback function.
		state:_Attach(state:Slot("Create"), true, function(w)
			btn = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\RDX\\Skin\\crosshair");
			btn:SetHighlightColor(1,1,0,1);
			w:AddButton(btn);
			btn:SetScript("OnClick", function()
				RDXDB.OpenObject(path, "Edit", VFLDIALOG);
			end);
		end);
		
		state:Attach("Menu", true, function(win, mnu)
			table.insert(mnu, {
				text = VFLI.i18n("Edit TableMeter");
				func = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Edit", VFLDIALOG);
				end;
			});
		end);
		
		state:Attach("Create", true, function(w)
			RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(up, uf)
				if(up == pkg) and (uf == file) then RDXDK.QueueLockdownAction(RDXDK._AsyncRebuildWindowRDX, w._path); end
			end, w._path .. path);
		end);
		state:Attach("Destroy", true, function(w)
			RDXDBEvents:Unbind(w._path .. path);
		end);
		

		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Table Meter"));
		local dd_tabmeterId = VFLUI.Dropdown:new(er, RDXDB._fnListTabMeter, nil, nil, nil, 30);
		dd_tabmeterId:SetWidth(250); dd_tabmeterId:Show();
		if desc and desc.path then 
			dd_tabmeterId:SetSelection(desc.path); 
		end
		er:EmbedChild(dd_tabmeterId); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return {
				feature = "TableMeter Editor";
				path = dd_tabmeterId:GetSelection();
			};
		end
		
		return ui;
	end,
	CreateDescriptor = function() return { feature = "TableMeter Editor" }; end,
});
