-- Obj_Bossmod.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A
-- SEPARATE LICENSE. UNLICENSED COPYING IS PROHIBITED.

------------------------------------------------------------------------
-- GUI Bossmods module for RDX
--   By: Trevor Madsen (Gibypri, Kilrogg realm)
--
-- Note:
--  Licensed exclusively to Raid Informatics
------------------------------------------------------------------------

local msgEvents = {
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_WHISPER",
	"CHAT_MSG_MONSTER_YELL",
	-- "CHAT_MSG_SAY", good for debugging
};

function RDXBM.BindMsgEvents(encid, BossmodEvents)
	local n = #msgEvents;
	for i=1,n do
		WoWEvents:Bind(msgEvents[i], nil, function()
			BossmodEvents:Dispatch("MSG");
		end, encid);
	end
	BossmodEvents:LockSignal("MSG");
end

function RDXBM.BindAbilityEvents(encid, BossmodEvents)
	RDXEvents:Bind("LOG_ROW_ADDED", nil, function(logrow, unitsrc, unittgt)
		BossmodEvents:Dispatch("LOG", logrow, unitsrc, unittgt);
	end, encid);
	BossmodEvents:LockSignal("LOG");
end

function RDXBM.EventIsLocal(event, state)
	if string.match(event, "^MSG") or string.match(event, "^LOG") then return true; end
	if event == "START" or event == "STOP" or event == "ACTIVATE" or event == "DEACTIVATE" then 
	return true; end
	for _,desc in ipairs(state.features) do
		if desc.devent and desc.devent == event then
			return true;
		end
	end

	return false;
end


function RDXBM._GetEventCache()
	local db = {};
	local bmState = RDXBM.GetbmState();
	for feat,desc in ipairs(bmState.features) do
		if desc.devent and desc.devent ~= "" then
			if VFL.vfind(db, desc.devent) == nil then
				table.insert(db, desc.devent);
			end
		end
	end
--	table.insert(db, "ACTIVATE") this can't really be used by non-script objects
	table.insert(db, "START")
	table.insert(db, "STOP")
	table.insert(db, "DEACTIVATE")
	if bmState:Slot("BasicEvents") then
		--table.insert(db, "ABILITY");
		table.insert(db, "MSG");
		table.insert(db, "OMNI");
	end
	return db;
end

function RDXBM.EventCachePopup(db, callback, frame, point, dx, dy)
	local qq = {};
	for _,v in pairs(db) do
		local dbEntry = v;
		table.insert(qq, {
			text = v;
			func = function()
				VFL.poptree:Release();
				callback(dbEntry);
			end
		});
	end
	table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
	table.insert(qq, { text = VFLI.i18n("WoWEvents not listed...") });
	VFL.poptree:Begin(200, 12, frame, point, dx, dy);
	VFL.poptree:Expand(nil, qq, 20);
end

function RDXBM.CreateEventEdit(parent, text)
	local ui = VFLUI.LabeledEdit:new(parent, 200);
	ui:SetText(text); ui:Show();
	
	local btn = VFLUI.Button:new(ui);
	btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
	btn:SetPoint("RIGHT", ui.editBox, "LEFT"); btn:Show();
	btn:SetScript("OnClick", function()
		RDXBM.EventCachePopup(RDXBM._GetEventCache(), function(x) 
			if x then ui.editBox:SetText(x); end
		end, btn, "CENTER");
	end);
	
	ui.Destroy = VFL.hook(function(s)
			btn:Destroy(); btn = nil;
	end, ui.Destroy);
	
	return ui;
end

local AlertID = 9999
--Unique ID's to track alerts for quashing
function RDXBM.GetUniqueAlertID()
	AlertID = AlertID + 1;
	return AlertID;
end

-------------------------------------------
-- BOSSMOD EDITOR
-- just a modified feature editor for bossmods
-------------------------------------------
RDX.IsBossmodEditorOpen = RDXIE.IsFeatureEditorOpen;

function RDX.BossmodEditor(state, callback, augText, parent)
	local dlg = RDXIE.FeatureEditor(state, callback, augText, parent);
	if not dlg then return nil; end

	local function GetMobName()
		for idx,fd in ipairs(dlg:GetActiveState():Features()) do
			if fd.feature == "Register Encounter" and fd.bossname then
				return fd.bossname;
			end
		end
		return nil;
	end
	
	local btnToggleListMode = VFLUI.Button:new(dlg);
	btnToggleListMode:SetHeight(25); btnToggleListMode:SetWidth(100);
	btnToggleListMode:SetPoint("BOTTOM", dlg:GetClientArea(), "BOTTOM");
	btnToggleListMode:SetText(VFLI.i18n("Ability Tracker")); btnToggleListMode:Show();
	btnToggleListMode:SetScript("OnClick", function()
		RDXBM.ToggleTrackerWindow(); 
		local bn = GetMobName(); 
		if bn then RDXBM.SetTrackerWindow(bn, VFLI.i18n("Choose Ability"));
		else RDXBM.SetTrackerWindow(VFLI.i18n("<choose mob>"), VFLI.i18n("Choose Ability")); end
	end);
	

	------ Close procedure
	dlg.Destroy = VFL.hook(function(s)
		btnToggleListMode:Destroy(); btnToggleListMode = nil;
		RDXBM.CloseTrackerWindow();
	end, dlg.Destroy);
end

-------------------------------
-- The universal bossmod state
-------------------------------
RDX.BossmodState = {};
function RDX.BossmodState:new()
	local st = RDXDB.ObjectState:new();

	st.OnResetSlots = function(state)
		-- Mark this state as a Bossmod
		state:AddSlot("Bossmod", nil);
	end
	
	st.Code = VFL.Snippet:new();
	
	st:Clear();
	return st;
end

local bmState = RDX.BossmodState:new();
RDXBM.GetbmState = function() return bmState; end;

----------------------------------------------------------------------
-- The Bossmod filetype
----------------------------------------------------------------------
local function SetupBossmod(path, desc)
	if (not path) or (not desc) then return nil; end
	-- Load the features.
	bmState:LoadDescriptor(desc, path);
	bmState:ResetSlots();
		
	local dk, pkg, file = RDXDB.ParsePath(path);
	
	local errObj = VFL.Error:new();
	errObj:Clear();
	
	local feat = nil;
	for idx,featDesc in ipairs(bmState.features) do
		feat = RDXDB.GetFeatureByDescriptor(featDesc);
		if feat then
			if errObj then errObj:SetContext(feat.name); end
			if feat.IsPossible(bmState) then
				if feat.ExposeFeature(featDesc, bmState, errObj) then
					feat.ApplyFeature(featDesc, bmState, pkg, file);
				else
					VFL.AddError(errObj, VFLI.i18n("Feature options contain errors. Check the Bossmod Editor."));
				end
			else
				VFL.AddError(errObj, VFLI.i18n("Feature cannot be added. Check that the prerequisites are met."));
			end
		else
			errObj:SetContext(nil);
		end
	end
	
	local code = bmState.Code:GetCode();
	local encid = "bm_"..pkg..file;
	local setback = false;
	
	local f,err = loadstring(code);
	if not f then
		VFL.TripError("RDX", VFLI.i18n("Could not compile bossmod at <") .. tostring(path) .. ">", VFLI.i18n("Error: ") .. err);
	else
		f();
	end
end

local function EditBossmod(parent, path, md)
	if RDX.IsBossmodEditorOpen() then return; end
	bmState:LoadDescriptor(md.data, path);
	RDX.BossmodEditor(bmState, function(x)
		md.data = x:GetDescriptor();
		RDX.QuashAlertsByPattern("^bm_test");
		RDXDB.NotifyUpdate(path);
	end, path, parent);
end


RDXDB.RegisterObjectType({
	name = "Bossmod";
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		EditBossmod(parent, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit..."),
			func = function()
				VFL.poptree:Release();
				RDXDB.OpenObject(path, "Edit", dlg);
			end
		});
	end;
});

-- Dangerous object filter registration: bossmods could contain lua code.
RDXDB.RegisterDangerousObjectFilter({
	matchType = "Bossmod";
	Filter = VFL.True;
});

------------------------------------------
-- Update hooks - make sure when a bossmod changes we reload it.
------------------------------------------
RDXDBEvents:Bind("OBJECT_DELETED", nil, function(dk, pkg, file, md)
	if md and md.ty == "Bossmod" then
		RDX.UnregisterEncounter("bm_"..pkg..file);
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(dk, pkg, file, newdk, newpkg, newfile, md)
	if md and md.ty == "Bossmod" then
		RDX.UnregisterEncounter("bm_"..pkg..file);
	end
end);
RDXDBEvents:Bind("OBJECT_CREATED", nil, function(dk, pkg, file) 
	local path = RDXDB.MakePath(dk,pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "Bossmod" then	SetupBossmod(path, obj.data) end
end);
RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(dk, pkg, file) 
	local path = RDXDB.MakePath(dk,pkg,file);
	local obj,_,_,ty = RDXDB.GetObjectData(path)
	if ty == "Bossmod" then	SetupBossmod(path, obj.data) end
end);

-----------------------------------------
-- Register Bossmod Objects as Encounters
-----------------------------------------
-- run on UI load 
local function ApplyBossmods()
	RDXDB.Foreach(function(dk, pkg, file, md)
		local ty = RDXDB.GetObjectType(md.ty);
		if not ty then return; end
		if ty == "Bossmod" then 
			SetupBossmod(RDXDB.MakePath(dk,pkg,file), md.data)
		end
	end);
end
RDX.ApplyBossmods = ApplyBossmods;
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	RDX.ApplyBossmods();
end);

