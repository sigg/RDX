-- Feature.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- A feature is a modifier to an object state.
--
-- Features have the following MANDATORY fields:
--
-- * name - A unique string name for the feature.
--
-- * ApplyFeature(desc, wState, isConfig) - Add the described feature to the window state, performing
-- whatever modifications are required. If the isConfig argument is true, this state is in 
-- "configuration" mode and is not being applied to a live object.
--
-- * IsPossible(wState) - return TRUE if the feature can be added to the state, NIL
-- if not.
--
-- * CreateDescriptor(wState) - Create a new feature descriptor for a feature to be added
-- to the given state.
--
-- * Verify(desc, wState, errs) - Verify that this descriptor is valid for the given state.
--
-- Features have the following OPTIONAL fields:
--
-- * GetUI(parent, desc) - Construct a UI from the descriptor. The returned UI must have a
-- GetDescriptor() function. 

local featdb = {};
local feat_array = {};

--- Register a new feature.
function RDX.RegisterFeature(tbl)
	if (not tbl) or (not tbl.name) then RDX.printI(VFLI.i18n("attempt to register anonymous feature")); return; end
	if (not tbl.title) then tbl.title = tbl.name; end
	if (not tbl.category) then tbl.category = VFLI.i18n("Uncategorized"); end
	if (not tbl.VersionMismatch) then tbl.VersionMismatch = VFL.Noop; end
	local n = tbl.name;
	if featdb[n] then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Duplicate registration Feature ") .. tbl.name); return; end
	featdb[n] = tbl;
	table.insert(feat_array, tbl);
end

function RDXDB._GetAllFeatures()
	return featdb;
end

function RDXDB._GetFeatureArray()
	return feat_array;
end

--- Get a feature by its name.
function RDXDB.GetFeatureByName(n)
	if not n then return nil; end
	return featdb[n];
end

--- Get a feature by its feature descriptor.
function RDXDB.GetFeatureByDescriptor(desc)
	if (not desc) or (not desc.feature) then return nil; end
	return featdb[desc.feature];
end

--------------------------------------------
-- Global functions to access features data
--------------------------------------------

--- Pick a given feature from a list of features.
--- feature in the name of the feature
--- key is the unique id of the feature when there are multiple features
function RDXDB.HasFeature(features, feature, key, value)
	if not features then return nil; end
	for idx,entry in ipairs(features) do
		if entry.feature == feature then
			if key then
				if entry[key] == value then return entry, idx; end
			else
				return entry, idx;
			end
		elseif entry.feature == "Proxy: File" then
			local pdata, pfeat = RDXDB.LoadFeatureFromFile(entry.file);
			if pdata and pdata.feature == feature then
				if key then
					if pdata[key] == value then return pdata, idx; end
				else
					return pdata, idx;
				end
			end
		end
	end
	return nil;
end

--- Get the fields of a particular feature
function RDXDB.GetFeatureData(path, feature, key, value)
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat = RDXDB.HasFeature(x.data, feature, key, value); 
	return feat;
end

--- Set the fields of a particular feature
function RDXDB.SetFeatureData(path, feature, key, value, newfeat)
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat = RDXDB.HasFeature(x.data, feature, key, value);
	if feat then VFL.empty(feat); VFL.copyInto(feat, newfeat); end
end

--- Update the fields of a particular feature on a particular filesystem object.
function RDXDB.SetFeatureFields(path, feature, key, value, ...)
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat = RDXDB.HasFeature(x.data, feature, key, value); if not feat then return; end
	for i=1,math.floor(select("#",...) / 2) do
		feat[select(2*i - 1, ...)] = select(2*i, ...);
	end
end

--- Add a feature (you must know what you are doing, no check)
function RDXDB.AddFeatureData(path, feature, key, value, newfeat)
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat = RDXDB.HasFeature(x.data, feature, key, value);
	if not feat then
		table.insert(x.data, newfeat);
		RDXDB.NotifyUpdate(path);
	end
end

--- Add a feature (you must know what you are doing, no check)
function RDXDB.DelFeatureData(path, feature, key, value)
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat, id = RDXDB.HasFeature(x.data, feature, key, value);
	if feat then
		table.remove(x.data, id);
		RDXDB.NotifyUpdate(path);
	end
end

--- The FeatureData objecttype represents a feature on the filesystem.
-- Editor
-- TODO: this code is really redundant with the script editor... a new abstraction is
-- probably in order here.
local function EditSavedFeature(parent, path, md)
	-- Sanity checks
	if (not path) or (not md) or (type(md.data) ~= "table") then return nil; end
	if not parent then parent = VFLFULLSCREEN; end
	--local ctype, font = "LuaEditBox", nil;
	
	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(500); dlg:SetHeight(500);
	dlg:SetText("FeatureData Editor: " .. path);
	dlg:SetClampedToScreen(true);
	dlg:Show();
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());

	local editor = VFLUI.TextEditor:new(dlg, ctype, font);
	editor:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	editor:SetWidth(490); editor:SetHeight(430); editor:Show();
	editor:SetText(Serialize(md.data));
	editor:GetEditWidget():SetFocus();

	local esch = function() dlg:Destroy(); end
	VFL.AddEscapeHandler(esch);

	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText("OK"); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		md.data = Deserialize(editor:GetText());
		if not md.data then md.data = {}; end
		VFL.EscapeTo(esch);
	end);

	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		editor:Destroy(); editor = nil;
		dlg = nil;
	end, dlg.Destroy);
end

-- A "mini feature editor" for editing a saved feature object.
local dlg = nil;
local function MiniFeatureEditor(parent, featData, callback, extraInfo)
	-- Sanity checks
	if (dlg) then return nil; end
	if not parent then parent = VFLFULLSCREEN; end
	local feat = RDXDB.GetFeatureByDescriptor(featData);
	if not feat then return nil; end
	if type(extraInfo) ~= "string" then extraInfo = ""; end

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(500); dlg:SetHeight(500);
	dlg:SetText(VFLI.i18n("FeatureData Editor: ") .. extraInfo .. "(" .. feat.title .. ")");
	dlg:SetClampedToScreen(true);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("MiniFeatureEditor") then RDXPM.RestoreLayout(dlg, "MiniFeatureEditor"); end

	------ The feature config ui.
	local ui = nil;
	local sf = VFLUI.VScrollFrame:new(dlg);
	sf:SetWidth(470); sf:SetHeight(440);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	sf:Show();

	ui = feat.UIFromDescriptor(featData, sf);
	if ui then
		ui.isLayoutRoot = true;
		ui:SetParent(sf); sf:SetScrollChild(ui);
		ui:SetWidth(sf:GetWidth());
		if ui.DialogOnLayout then ui:DialogOnLayout(); end
		ui:Show();
	end

	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "MiniFeatureEditor");
			dlg:Destroy(); dlg = nil;
		end);
	end
	VFL.AddEscapeHandler(esch);

	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText("OK"); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		local descr = ui:GetDescriptor();
		if descr then callback(descr); end
		VFL.EscapeTo(esch);
	end);

	dlg.Destroy = VFL.hook(function(s)
		if ui then sf:SetScrollChild(nil); ui:Destroy(); ui.GetDescriptor = nil; ui = nil; end
		sf:Destroy(); sf = nil;
		btnOK:Destroy(); btnOK = nil;
		dlg = nil;
	end, dlg.Destroy);
end
RDXDB.MiniFeatureEditor = MiniFeatureEditor;

local function EditSavedFeature2(parent, path, md)
	if (not path) or (not md) or (type(md.data) ~= "table") then return; end
	MiniFeatureEditor(parent, md.data, function(fdata) md.data = fdata; end, path);
end

-- Objtype
RDXDB.RegisterObjectType({
	name = "FeatureData";
	New = function(path, md) md.version = 1; end;
	Edit = function(path, md, parent)
		EditSavedFeature(parent, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, parent)
		table.insert(mnu, {
			text = VFLI.i18n("Edit"),
			OnClick = function()
				VFL.poptree:Release();
				EditSavedFeature2(parent, path, md);
			end
		});
		table.insert(mnu, {
			text = VFLI.i18n("Edit Raw Data"),
			OnClick = function()
				VFL.poptree:Release();
				EditSavedFeature(parent, path, md);
			end
		});
	end
});

------------------------------------------------------------------
-- FEATURE VERSION MANAGEMENT
-- When WoW starts, check all feature-driven objects for features
-- with out-of-date descriptors, and run their VersionMismatch()
-- methods to correct the issue.
------------------------------------------------------------------
local function CheckVers(featDesc, pkg, file)
	local feature = RDXDB.GetFeatureByDescriptor(featDesc);
	if feature and (feature.version ~= featDesc.version) and feature.VersionMismatch then
		if feature.VersionMismatch(featDesc) then 
			RDX.printI(VFLI.i18n("|cFF00FFFFFeature Updater|r: Updating feature ") .. feature.name .. VFLI.i18n(" on object ") .. RDXDB.MakePath(pkg,file));
			return true;
		end
	end
end

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	-- Iterate over the entire FS...
	RDXDB.Foreach(function(pkg, file, md)
		local ty = RDXDB.GetObjectType(md.ty);
		if not ty then return; end
		-- Iterate over features on feature driven objects
		if ty.isFeatureDriven and (type(md.data) == "table") then
			for _,featDesc in ipairs(md.data) do
				if CheckVers(featDesc, pkg, file) then RDXDB.objupdate = true; end
			end
		end

		-- For actual Feature objects, update them directly.
		if ty.name == "FeatureData" then
			if CheckVers(md.data, pkg, file) then RDXDB.objupdate = true; end
		end
	end);
end);
