-- FeatureEditor.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
-- 
-- The dialog box for editing an ObjectState's features.

RDXIE = RegisterVFLModule({
	name = "RDXIE";
	title = VFLI.i18n("RDX IDE Editor");
	description = "RDX IDE EDITOR";
	version = {1,0,0};
	parent = RDX;
});
RDXIEEvents = DispatchTable:new();

local dlg = nil;

function RDXIE.IsFeatureEditorOpen() return dlg; end

local features = {};
local pfeatures = {}; -- DragDrop system: possible features now in a separate table.

local category_color = {r=.5,g=.4,b=.35};
local addfeature_color = {r=0.3, g=0.7, b=0.5};

local AddFeatureDragContext = VFLUI.DragContext:new();
local MoveFeatureDragContext = VFLUI.DragContext:new();

-- Drag start helpers
local function AddFeatureDragStart(btn)
	if btn.feat then
		RDX:Debug(1, ("AddFeatureDragStart for feature %s"):format(tostring(btn.feat.title)));
		local proxy = VFLUI.CreateGenericDragProxy(btn, btn.text:GetText(), btn.feat);
		AddFeatureDragContext:Drag(btn, proxy);
	end
end
local function MoveFeatureDragStart(btn)
	if btn.idx then
		RDX:Debug(1, ("MoveFeatureDragStart at index %s"):format(tostring(btn.idx)));
		local proxy = VFLUI.CreateGenericDragProxy(btn, btn.text:GetText(), btn.idx);
		MoveFeatureDragContext:Drag(btn, proxy);
	end
end

function RDXIE.FeatureEditor(state, callback, path, parent)
	if (dlg) or (not state) then return nil; end
	RDXIEEvents:Dispatch("OPEN");
	
	-- Save the current state to be able to restore later
	state:Backup();
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	--dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText(VFLI.i18n("Feature Editor: ") .. path);
	dlg:SetWidth(700); dlg:SetHeight(500);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetClampedToScreen(true);
	
	-- OpenRDX 7.1 RDXPM
	if RDXPM.Ismanaged("FeatureEditor") then RDXPM.RestoreLayout(dlg, "FeatureEditor"); end
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	local ca = dlg:GetClientArea();

	-- Predeclarations
	local featList, possibleFeatList, sf, ui;
	local activeFeat;
	local RebuildFeatureList, RebuildActiveFeatureList, RebuildPossibleFeatureList, SetActiveFeature, HideErrors, ShowErrors;

	------ Helper functions   
	local function AddFeatureAt(feat, idx)
		-- Spin up the state to the target index.
		state:InSituState(idx);
		-- Check possibility of feature
		-- Disable
		--if not feat.IsPossible(state) then
		--	VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Feature is not possible at that position."));
		--	return;
		--end
		-- Create and add the descriptor.
		local desc = feat.CreateDescriptor(state);
		table.insert(state.features, idx, desc);
		state.featuresByName[feat.name] = true;
		-- Check to see if our active feature needs moved
		if activeFeat and activeFeat >= idx then
			activeFeat = activeFeat + 1;
		end
		-- Restore the full in-situ state
		state:InSituState();
		-- Rebuild the feature list
		RebuildFeatureList();
	end

	local function ResetFeatureUI()
		if ui then
			ui:Hide();
			sf:SetScrollChild(nil);
			ui.GetDescriptor = nil; -- BUGFIX: Remove the GetDescriptor from a feature UI before freeing it.
			ui:Destroy();
			ui = nil;
		end
	end

	-- Get the currently-edited state
	function dlg:GetActiveState() return state; end

	-- Callback: save the current feature
	local function SaveActiveFeature(nofeedback)
		if (not activeFeat) or (not ui) then return; end
		-- Find the feature on the local state; if not found, fail out.
		local fd = state:_GetFeatureByIndex(activeFeat);
		if not fd then return; end
		local feat = RDXDB.GetFeatureByDescriptor(fd);
		if not feat then return; end
		-- Get the edited data from the feature UI, and save it.
		local descr = ui:GetDescriptor();
		descr.disable = fd.disable;
		descr.test = fd.test;
		feat = RDXDB.GetFeatureByDescriptor(descr);
		state:_SaveFeatureByIndex(activeFeat, descr);
		if not nofeedback then
			state:InSituState(activeFeat);
			vflErrors:Clear();
			if state:_ExposeFeatureInSitu(descr, feat, vflErrors) then
				-- ??
			else
				ShowErrors(vflErrors);
			end
		end
	end

	-- Callback: select a new active feature.
	function SetActiveFeature(idx, force)
		-- Activate the feature only if required
		if activeFeat == idx and not force then return; end
		-- Save outstanding changes to the previous feature
		SaveActiveFeature(true);
		-- Find the feature on the local state; if not found, fail out.
		local fd = state:_GetFeatureByIndex(idx);
		if not fd then return; end
		local feat = RDXDB.GetFeatureByDescriptor(fd);
		if not feat then return; end
		-- Update the active feature. Rebuild the feature list.
		activeFeat = idx;
		state:InSituState(activeFeat);
		RebuildFeatureList();
		-- Now build the feature config UI.
		ResetFeatureUI();   
		if (not feat.UIFromDescriptor) then return; end -- no UI
		ui = feat.UIFromDescriptor(fd, sf, state); if not ui then return; end
		-- Layout and show the feature config UI.
		ui.isLayoutRoot = true;
		ui:SetParent(sf); sf:SetScrollChild(ui);
		ui:SetWidth(sf:GetWidth());
		if ui.DialogOnLayout then ui:DialogOnLayout(); end
		ui:Show();
		-- If there are any errors, show them
		state:InSituState(activeFeat);
		vflErrors:Clear();
		if state:_ExposeFeatureInSitu(fd, feat, vflErrors) then
			HideErrors();
		else
			ShowErrors(vflErrors);
		end
	end
	
	function dlg:SetActiveFeature(idx) SetActiveFeature(idx); end
	-- Remove the feature at the given index. Anything that depended on this
	-- feature will be blasted as well.
	local function RemoveFeatureAt(idx)
		-- Remove the feature
		local qq = state:Features();
		local x = table.remove(qq, idx); if not x then return; end
		-- Check our active feature; if this was it make sure to unset it
		if activeFeat then
			if activeFeat == idx then
				ResetFeatureUI(); HideErrors();
				activeFeat = nil;
			elseif activeFeat > idx then
				activeFeat = activeFeat - 1;
			end
		end
		-- Rebuild the state.
		state:Clear();
		-- Readd each feature one at a time
		for ix,ft in ipairs(qq) do state:AddFeatureInSitu(ft); end
		-- Rebuild the list
		RebuildFeatureList();
	end
   
	-- Move a feature from one index to another
	local function MoveFeature(src, dest)
		if (src < 1) or (src == dest) then return; end -- nothing to do
		local qq = state:Features();
		if dest > #qq then dest = #qq; end -- out of bounds
		local tmp = table.remove(qq, src); -- delete the source feature
		table.insert(qq, dest, tmp); -- move it to the destination
		-- We want our active feature after the operation to be the same
		-- as before.
		if activeFeat then
			if(activeFeat == src) then
				activeFeat = dest;
			else
				-- First we're "deleting" the source feature
				if src < activeFeat then activeFeat = activeFeat - 1; end
				-- Then we're "adding" a feature at the destination.
				if dest <= activeFeat then activeFeat = activeFeat + 1; end
			end
		end
		RebuildFeatureList();
	end

	local function DisableFeature(idx)
		SetActiveFeature(idx);
		local qq = state:Features();
		local x = qq[idx]; if not x then return; end
		x.disable = true;
		-- Check our active feature; if this was it make sure to unset it
		if activeFeat then
			if activeFeat == idx then
				ResetFeatureUI(); HideErrors();
				activeFeat = nil;
			elseif activeFeat > idx then
				activeFeat = activeFeat - 1;
			end
		end
		-- Rebuild the state.
		state:Clear();
		-- Readd each feature one at a time
		for ix,ft in ipairs(qq) do state:AddFeatureInSitu(ft); end
		-- Rebuild the list
		RebuildFeatureList();
	end
   
	local function EnableFeature(idx)
		SetActiveFeature(idx);
		local qq = state:Features();
		local x = qq[idx]; if not x then return; end
		x.disable = nil;
		-- Check our active feature; if this was it make sure to unset it
		if activeFeat then
			if activeFeat == idx then
				ResetFeatureUI(); HideErrors();
				activeFeat = nil;
			elseif activeFeat > idx then
				activeFeat = activeFeat - 1;
			end
		end
		-- Rebuild the state.
		state:Clear();
		-- Readd each feature one at a time
		for ix,ft in ipairs(qq) do state:AddFeatureInSitu(ft); end
		-- Rebuild the list
		RebuildFeatureList();
	end
   
	local function IsFeatureDisabled(idx)
		local feats = state:Features();
		local x = feats[idx]; if not x then return; end
		return x.disable;
	end
	
	-- test feature
	
	local function ActivateTestFeature(idx)
		SetActiveFeature(idx);
		local qq = state:Features();
		local x = qq[idx]; if not x then return; end
		x.test = true;
		-- Check our active feature; if this was it make sure to unset it
		if activeFeat then
			if activeFeat == idx then
				ResetFeatureUI(); HideErrors();
				activeFeat = nil;
			elseif activeFeat > idx then
				activeFeat = activeFeat - 1;
			end
		end
		-- Rebuild the state.
		state:Clear();
		-- Readd each feature one at a time
		for ix,ft in ipairs(qq) do state:AddFeatureInSitu(ft); end
		-- Rebuild the list
		RebuildFeatureList();
	end
   
	local function DesactivateTestFeature(idx)
		SetActiveFeature(idx);
		local qq = state:Features();
		local x = qq[idx]; if not x then return; end
		x.test = nil;
		-- Check our active feature; if this was it make sure to unset it
		if activeFeat then
			if activeFeat == idx then
				ResetFeatureUI(); HideErrors();
				activeFeat = nil;
			elseif activeFeat > idx then
				activeFeat = activeFeat - 1;
			end
		end
		-- Rebuild the state.
		state:Clear();
		-- Readd each feature one at a time
		for ix,ft in ipairs(qq) do state:AddFeatureInSitu(ft); end
		-- Rebuild the list
		RebuildFeatureList();
	end
	
	local function IsFeatureTest(idx)
		local feats = state:Features();
		local x = feats[idx]; if not x then return; end
		local feat = RDXDB.GetFeatureByDescriptor(x);
		return feat.test, x.test;
	end


	-- Import a feature from disk, adding it to the end of the featurelist.
	local function ImportFeatureFrom(file, btn)
		RDX:Debug(1, "ImportFeatureFrom " .. tostring(file));
		local md = RDXDB.GetObjectData(file);
		-- Sanity check.
		if(type(md) ~= "table") or (md.ty ~= "FeatureData") or (type(md.data) ~= "table") or (type(md.data.feature) ~= "string") then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("Not a valid FeatureData file.")); return;
		end
		-- Import it.
		--AddFeatureAt(VFL.copy(md.data), btn.idx);
		-- We'll VFL.copy() it just to be safe.
		state:InSituState(btn.idx + 1);
		table.insert(state.features, btn.idx + 1, VFL.copy(md.data));
		-- Restore the full in-situ state
		state:InSituState();
		-- Rebuild the list
		RebuildFeatureList();
	end
	
	local function ImportFeature(self)
		local xp = RDXDB.ExplorerPopup(self);
		xp:SetPoint("BOTTOMLEFT", self, "TOPLEFT"); xp:Show();
		xp:SetFileFilter(function(_,_,md) if type(md) == "table" then return (md.ty == "FeatureData"); end; end); 
		xp:Rebuild();
		xp:EnableFeedback(function(zz) ImportFeatureFrom(zz:GetPath(), self); end);
	end
	
	-- Export the active feature to disk at the given location.
	local function ExportFeatureTo(file)
		RDX:Debug(1, "ExportFeatureTo " .. tostring(file));
		local qq = state:Features();
		if (not activeFeat) or (not qq[activeFeat]) then return; end
		file = RDXDB.TouchObject(file);
		if not file then
			-- TODO: error message here? shouldn't really ever happen but who knows.
			return;
		end
		-- Check file integrity
		if(file.ty == "Typeless") then file.ty = "FeatureData"; file.version = 1; end
		if(file.ty ~= "FeatureData") then
			VFLUI.MessageBox("Error", VFLI.i18n("Cannot overwrite a non-FeatureData object with FeatureData. Delete it first."));
			return;
		end
		-- Write the data
		file.data = VFL.copy(qq[activeFeat]);
	end
	
	local function ExportFeature(self)
		local xp = RDXDB.ExplorerPopup(self);
		xp:SetPoint("BOTTOMLEFT", self, "TOPLEFT"); xp:Show();
		xp:SetFileFilter(VFL.True); 
		xp:Rebuild();
		xp:EnableFeedback(function(zz) ExportFeatureTo(zz:GetPathRaw()); end);
	end
   
	-- Callback for when a drag-and-drop feature is dropped on another
	-- feature.
	local function FeatureDropOn(target, proxy, _, context)
		local src, dest = proxy.data, target.idx;
		-- The destination should always be a numbered cell in the feature editor
		if (type(dest) ~= "number") then return; end
		-- Fork depending on which context we're in
		if context == AddFeatureDragContext then
			-- Source data should be an actual feature entity.
			AddFeatureAt(src, dest);
		elseif context == MoveFeatureDragContext then
			-- Source should be a numbered feature
			if (type(src) ~= "number") then return; end
			if(src == dest) then
				-- Drag without a move, must have been just a click.
				-- Activate the feature.
				SetActiveFeature(src); return;
			end
			MoveFeature(src, dest);
		end
	end

	-- Callback when a feature is dragged from the active list and dropped
	-- on the trash.
	local function FeatureDropTrash(_, proxy, _, context)
		-- Check to make sure this is an active feature being dragged
		if context ~= MoveFeatureDragContext then return; end
		-- Get the drag source
		local src = proxy.data;
		-- Should be a numbered feature
		if type(src) ~= "number" then return; end
		-- Delete it.
		RemoveFeatureAt(src);
	end
	
	local function DuplicateFeature(idx)
		local qq = state:Features();
		local x = qq[idx]; if not x then return; end
		state:InSituState(idx);
		table.insert(state.features, idx, VFL.copy(x));
		-- Restore the full in-situ state
		state:InSituState();
		-- Rebuild the list
		RebuildFeatureList();
	end
	
	local function DropFeature(idx)
		SetActiveFeature(nil); RemoveFeatureAt(ix);
		-- Rebuild the state.
		state:Clear();
		-- Readd each feature one at a time
		for ix,ft in ipairs(qq) do state:AddFeatureInSitu(ft); end
		-- Rebuild the list
		RebuildFeatureList();
	end

	local mnu = {};
	local function OpenMenuFeature(btn)
		VFL.empty(mnu);
		if IsFeatureDisabled(btn.idx) then
			table.insert(mnu, { 
				text = VFLI.i18n("Enable"); 
				OnClick = function()
					VFL.poptree:Release();
					EnableFeature(btn.idx);
				end;
			});
		else
			table.insert(mnu, { 
				text = VFLI.i18n("Disable"); 
				OnClick = function()
					VFL.poptree:Release();
					DisableFeature(btn.idx)
				end;
			});
		end
		local testpossible, testenable = IsFeatureTest(btn.idx)
		if testpossible then
			if testenable then
				table.insert(mnu, { 
					text = VFLI.i18n("Desactivate Test"); 
					OnClick = function()
						VFL.poptree:Release();
						DesactivateTestFeature(btn.idx);
					end;
				});
			else
				table.insert(mnu, { 
					text = VFLI.i18n("Activate Test"); 
					OnClick = function()
						VFL.poptree:Release();
						ActivateTestFeature(btn.idx);
					end;
				});
			end
		end
		table.insert(mnu, { 
			text = VFLI.i18n("Duplicate"); 
			OnClick = function()
				VFL.poptree:Release();
				DuplicateFeature(btn.idx);
			end;
		});
		table.insert(mnu, { 
			text = VFLI.i18n("Import"); 
			OnClick = function()
				VFL.poptree:Release();
				ImportFeature(btn);
			end;
		});
		table.insert(mnu, { 
			text = VFLI.i18n("Export"); 
			OnClick = function()
				VFL.poptree:Release();
				ExportFeature(btn);
			end;
		});
		table.insert(mnu, { 
			text = VFLI.i18n("Drop"); 
			OnClick = function()
				VFL.poptree:Release();
				if btn.idx then
					SetActiveFeature(nil); RemoveFeatureAt(btn.idx);
				end
			end;
		});
		VFL.poptree:Begin(120, 12, btn, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(btn));
		VFL.poptree:Expand(nil, mnu);
	end

	---------------------------------
	--  The active feature list.
	---------------------------------
	-- Create the active-feature buttons.
	local function GetActiveFeatureButton()
		local btn = VFLUI.Selectable:new();
		btn.OnDrop = FeatureDropOn;
		AddFeatureDragContext:RegisterDragTarget(btn);
		MoveFeatureDragContext:RegisterDragTarget(btn);
		btn:RegisterForClicks("LeftButtonDown", "RightButtonDown");
		btn:SetScript("OnClick", function(self, arg1)
			if(arg1 == "LeftButton") then
				MoveFeatureDragStart(self);
			elseif(arg1 == "RightButton") then
				OpenMenuFeature(self);
			end
		end);
		btn.Destroy = VFL.hook(btn.Destroy, function(x)
			AddFeatureDragContext:UnregisterDragTarget(x);
			MoveFeatureDragContext:UnregisterDragTarget(x);
			x.OnDrop = nil;
			x.idx = nil;
		end);
		btn.OnDeparent = btn.Destroy;
		return btn;
	end
	
	featList = VFLUI.List:new(dlg, 12, GetActiveFeatureButton);
	featList:SetPoint("TOPLEFT", ca, "TOPLEFT");
	featList:SetWidth(200); featList:SetHeight(448);
	featList:Rebuild(); featList:Show();
	featList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data.text);
		cell.idx = data.idx;
		if activeFeat and (data.idx == activeFeat) then
			cell.selTexture:SetVertexColor(0,0,0.6); cell.selTexture:Show();
		elseif data.hlt then
			cell.selTexture:SetVertexColor(data.hlt.r, data.hlt.g, data.hlt.b); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
	end, VFL.ArrayLiterator(features));

	function RebuildActiveFeatureList()
		VFL.empty(features);
		local feats, feat, text = state:Features();
		for idx,fd in ipairs(feats) do
			state:InSituState(idx);
			feat = RDXDB.GetFeatureByDescriptor(fd);
			local tit = feat.title;
			if fd.name then tit = tit .. ": " .. fd.name; end
			if not feat then
				text = VFLI.i18n("(Invalid!)");
			elseif fd.disable then
				text = ("|cFF777777%s|r"):format(tit);
			elseif fd.test then
				text = ("|cFF00FF00%s|r"):format(tit);
			elseif not feat.IsPossible(state) then
				text = ("|cFFFF0000%s|r"):format(tit);
			elseif not state:_ExposeFeatureInSitu(fd, feat) then
				text = ("|cFFFFFF00%s|r"):format(tit);
			elseif feat.deprecated then
				text = ("|cFFDD0077%s|r"):format(tit);
			else
				text = tit;
			end
			table.insert(features, {idx=idx, text=text});
		end
		table.insert(features, {idx=#feats+1, hlt=addfeature_color, text = VFLI.i18n("(drag new feature here)")});
		featList:Update();
	end

	---------------------------------
	--  The possible feature list.
	---------------------------------
	local function GetPossibleFeatureButton()
		local btn = VFLUI.Selectable:new();
		btn:RegisterForClicks("LeftButtonDown");
		btn:SetScript("OnClick", AddFeatureDragStart);
		btn.Destroy = VFL.hook(btn.Destroy, function(x)
			x.feat = nil;
		end);
		btn.OnDeparent = btn.Destroy;
		return btn;
	end

	possibleFeatList = VFLUI.List:new(dlg, 12, GetPossibleFeatureButton);
	possibleFeatList:SetPoint("TOPRIGHT", ca, "TOPLEFT", -10, -5);
	possibleFeatList:SetWidth(200); possibleFeatList:SetHeight(448);
	possibleFeatList:Rebuild(); possibleFeatList:Show();
	possibleFeatList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data.text);
		cell.feat = data.feat;
		if data.hlt then
			cell.selTexture:SetVertexColor(data.hlt.r, data.hlt.g, data.hlt.b); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
	end, VFL.ArrayLiterator(pfeatures));

	local possibleFeatureBackdrop = VFLUI.AcquireFrame("Frame");
	possibleFeatureBackdrop:SetParent(dlg);
	possibleFeatureBackdrop:SetPoint("TOPLEFT", possibleFeatList, "TOPLEFT", -5, 5);
	possibleFeatureBackdrop:SetPoint("BOTTOMRIGHT", possibleFeatList, "BOTTOMRIGHT", 5, -5);
	possibleFeatureBackdrop:SetBackdrop(VFLUI.DarkDialogBackdrop);
	possibleFeatureBackdrop:Show();

	function RebuildPossibleFeatureList()
	VFL.empty(pfeatures);
	state:InSituState();
	-- Sort the features by category, then name.
	local flist = RDXDB._GetFeatureArray();
	table.sort(flist, function(f1, f2)
		if(f1.category == f2.category) then
			return (f1.title < f2.title);
		else
			return (f1.category < f2.category);
		end
	end);

	-- Traverse the list in order, inserting a category-header whenever the category changes.
	local curCat, text = "";
	for idx,feat in ipairs(flist) do
		if state:IsFeaturePossible(feat) and (not feat.invisible) then
			if(feat.category ~= curCat) then
				table.insert(pfeatures, {text = feat.category, hlt = category_color}); curCat = feat.category;
			end
			local txt = feat.title;
			if feat.deprecated then txt = ("|cFFDD0077%s|r"):format(txt); end
				table.insert(pfeatures, { text = txt, feat = feat });
			end
		end
		possibleFeatList:Update();
	end
	
	function RebuildFeatureList()
		RebuildActiveFeatureList();
		RebuildPossibleFeatureList();
		-- Rebuild preview frame
		RDXIEEvents:Dispatch("REBUILD", state, path);
	end
	dlg.RebuildFeatureList = RebuildFeatureList;
	
	RebuildFeatureList();
	
	VFLT.ZMSchedule(1, RebuildFeatureList);

	------ The feature config ui.
	sf = VFLUI.VScrollFrame:new(dlg);
	sf:SetWidth(470); sf:SetHeight(440);
	sf:SetPoint("TOPLEFT", featList, "TOPRIGHT");
	sf:Show();

	------ The error frame
	local el = VFLUI.List:new(dlg, 10, VFLUI.Selectable.AcquireCell);
	local function elad(cell, data)
		cell.text:SetText(data);
		if(data ~= "Errors") then
			cell.selTexture:Hide();
		else
			cell.selTexture:SetVertexColor(0.75,0,0); cell.selTexture:Show();
		end
	end;
	el:SetPoint("TOPLEFT", sf, "BOTTOMLEFT");
	el:SetWidth(470); el:SetHeight(100); el:Rebuild(); el:Hide();
	
	function HideErrors()
		sf:SetHeight(440); el:Hide();
	end
	function ShowErrors(err)
		sf:SetHeight(340); el:Show();
		local ec, et = err:Count(), err:ErrorTable();
		el:SetDataSource(elad, function() return ec + 1; end, function(x) if(x == 1) then return "Errors"; else return et[x-1]; end; end);
	end

	------ Save/revert buttons
	local btnRefresh = VFLUI.Button:new(dlg);
	btnRefresh:SetHeight(25); btnRefresh:SetWidth(65);
	btnRefresh:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnRefresh:SetText(VFLI.i18n("Refresh")); btnRefresh:Show();
	btnRefresh:SetScript("OnClick", function() 
		SetActiveFeature(activeFeat, true); 
	end);
	
	-- Save : Add all modifications
	local function Save()
		-- Save the active feature before exiting
		dlg:_Hide(RDX.smooth, nil, function()
			SaveActiveFeature(true);
			RDXPM.StoreLayout(dlg, "FeatureEditor");
			if callback then callback(state); end
			dlg:Destroy(); dlg = nil;
		end);
	end

	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);
	
	dlg:_Show(RDX.smooth);

	-- Close : cancel all modifications
	local function Close()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "FeatureEditor");
			state:Restore();
			dlg:Destroy(); dlg = nil;
		end);
	end

	local closebtn = VFLUI.CloseButton:new()
	closebtn:SetScript("OnClick", Close);
	dlg:AddButton(closebtn);

	------ Close procedure
	dlg.Destroy = VFL.hook(function(s)
		RDXIEEvents:Dispatch("CLOSED");
		-- Remove exposed API
		s.SetActiveFeature = nil; s.RebuildFeatureList = nil;
		s.GetActiveState = nil;
		
		-- Tear down controls
		ResetFeatureUI();
		featList:Destroy(); featList = nil;
		possibleFeatList:Destroy(); possibleFeatList = nil;
		possibleFeatureBackdrop:Destroy(); possibleFeatureBackdrop = nil;
		el:Destroy(); el = nil;
		btnRefresh:Destroy(); btnRefresh = nil;
		sf:Destroy(); sf = nil;
	end, dlg.Destroy);

	return dlg;
end 

function RDXIE.CloseFeatureEditor()
	dlg:Destroy(); dlg = nil;
end
