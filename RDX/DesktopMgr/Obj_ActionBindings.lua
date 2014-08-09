-- Obj_ActionBindings.lua
-- OpenRDX
--

RDXAB = RegisterVFLModule({
	name = "RDXAB";
	title = VFLI.i18n("RDX Action Bindings Object");
	description = VFLI.i18n("RDX Desktop GUI Editor");
	version = {1,0,0};
	parent = RDX;
});

-------------------------------------------------------------------
-- Action type registration 
-------------------------------------------------------------------
local actiontypes = {};

function RDXAB.RegisterActionType(tbl)
	if (not tbl) or (not tbl.name) then RDX.printW(VFLI.i18n("Attempt to register anonymous Action type bindings")); return; end
	local n = tbl.name;
	if actiontypes[n] then RDX.printW(VFLI.i18n("Duplicate registration Action type bindings ") .. tbl.name); return; end
	actiontypes[n] = tbl;
end

function RDXAB.IsRegisterActionType(cn)
	if not cn or not actiontypes[cn] then return nil; else return true; end
end

function RDXAB.GetActionType(cn)
	if not cn then return nil; end
	return actiontypes[cn];
end

function RDXAB._GetActionTypes()
	return actiontypes;
end

RDXAB.RegisterActionType({
	name = "nothing",
	save = function(actionid)
		return {
			actiontype = "nothing",
		};
	end,
	load = function(newactionid, id)
		return true;
	end,
});

RDXAB.RegisterActionType({
	name = "spell",
	save = function(actionid)
		return {
			actiontype = "spell",
			actionid = actionid,
		};
	end,
	load = function(newactionid, id)
		--VFL.print("spell load " .. newactionid .. " " .. id);
		local spellid = RDXSS.GetSpellByFullName(newactionid, true);
		if spellid then
			PickupSpell(spellid, BOOKTYPE_SPELL);
			PlaceAction(id);
			return true;
		--else
		--	return nil;
		end
	end,
});
--[[
RDXAB.RegisterActionType({
	name = "critter",
	save = function(actionid)
		return {
			actiontype = "critter",
			actionid = actionid,
		};
	end,
	load = function(newactionid, id)
		local creatureInfo = RDXSS.GetSpellCritterByName(newactionid);
		if creatureInfo then
			--VFL.print("critter " .. newactionid .. " " .. creatureInfo.i);
			PickupCompanion("critter", creatureInfo.i);
			PlaceAction(id);
			return true;
		end
	end,	
});]]

RDXAB.RegisterActionType({
	name = "companion",
	save = function(actionid, subType, globalID)
		return {
			actiontype = "companion",
			actionid = actionid,
			subType = subType,
			globalID = globalID,
		};
	end,
	load = function(newactionid, id, subType, globalID)
		--VFL.print(newactionid);
		--VFL.print(id);
		--VFL.print(subType);
		--VFL.print(globalID);
		--local creatureInfo = RDXSS.GetSpellMountByName(newactionid);
		--if creatureInfo then
			--VFL.print("mount " .. newactionid .. " " .. creatureInfo.i);
			PickupCompanion(subType, globalID);
			PlaceAction(id);
			return true;
		--end
	end,	
});

RDXAB.RegisterActionType({
	name = "item",
	save = function(actionid)
		return {
			actiontype = "item",
			actionid = actionid,
		};
	end,
	load = function(newactionid, id)
		--VFL.print("item " .. newactionid);
		PickupItem(newactionid);
		PlaceAction(id);
		return true;
	end,	
});

RDXAB.RegisterActionType({
	name = "macro",
	save = function(actionid)
		return {
			actiontype = "macro",
			actionid = actionid,
		};
	end,
	load = function(newactionid, id)
		PickupMacro(newactionid);
		PlaceAction(id);
		return true;
	end,	
});

---------------------------------------------------------
--
---------------------------------------------------------

local currentActionBindings = nil;
local currentpath = nil;

local function FindCompanion(i)
	local creatureInfo = nil;
	VFLTip:SetOwner(RDXParent, "ANCHOR_NONE");
	VFLTip:ClearLines();
	VFLTip:SetAction(i)
	creatureInfo = RDXSS.GetSpellCritterByName(VFLTipTextLeft1:GetText());
	if creatureInfo then return "critter", creatureInfo.creatureName; end
	creatureInfo = RDXSS.GetSpellMountByName(VFLTipTextLeft1:GetText());
	if creatureInfo then return "mount", creatureInfo.creatureName; end
	return nil, nil;
end

local function saveActionBindings(actionslist)
	for i = 1, 120 do
		local actiontype, actioninfo, subType, globalID  = GetActionInfo(i);
		local actionid = nil;
		if not actiontype then
			-- nothing case
			actiontype, actionid = "nothing", "";
		elseif actiontype == "companion" then
			--VFL.print(actiontype);
			--VFL.print(actioninfo);
			--VFL.print(subType);
			--VFL.print(globalID);
			actionid = actioninfo;
		elseif actiontype == "spell" then
			actionid = RDXSS.GetSpellFullNameByBookId(actioninfo);
		elseif actiontype == "item" then
			actionid = GetItemInfo(actioninfo);
		elseif actiontype == "macro" then
			actionid = GetMacroInfo(actioninfo);
		end
		local oldaction = actionslist[i];
		if not oldaction or actiontype ~= oldaction.actiontype or actionid ~= oldaction.actionid then
			ClearCursor();
			if oldaction then VFL.empty(oldaction); oldaction = nil; end
			if RDXAB.IsRegisterActionType(actiontype) then
				actionslist[i] = RDXAB.GetActionType(actiontype).save(actionid, subType, globalID);
			end
		end
	end
	ClearCursor();
end

local function loadActionBindings(actionslist)
	for i = 1, 120 do
		local actiontype, actioninfo = GetActionInfo(i);
		local actionid = nil;
		if not actiontype then
			-- nothing case
			actiontype, actionid = "nothing", "";
		elseif actiontype == "companion" then
			-- companion case
			actionid = actioninfo;
		elseif actiontype == "spell" then
			-- general spell case , actionid is the full name
			actionid = RDXSS.GetSpellFullNameByBookId(actioninfo);
		elseif actiontype == "item" then
			actionid = GetItemInfo(actioninfo);
		elseif actiontype == "macro" then
			actionid = GetMacroInfo(actioninfo);
		end
		local newaction = actionslist[i];
		-- modify if it is different.
		if not newaction or actiontype ~= newaction.actiontype or actionid ~= newaction.actionid then
			ClearCursor();
			-- delete action binding before replace.
			if actiontype ~= "nothing" then PickupAction(i); ClearCursor(); end
			-- Add new action binding
			if newaction and RDXAB.IsRegisterActionType(newaction.actiontype) then
				RDXAB.GetActionType(newaction.actiontype).load(newaction.actionid, i, newaction.subType, newaction.globalID);
			end
		end
	end
	ClearCursor();
end

--------------------------------------------------------
-- ActionBindings object
--------------------------------------------------------

RDXAB.ActionBindings = {};
function RDXAB.ActionBindings:new(parent)
	local self = VFLUI.AcquireFrame("Frame");
	self:SetParent(parent or VFLDIALOG);
	
	function self:LoadAB(actionslist)
		loadActionBindings(actionslist);
	end
	
	function self:SaveAB(actionslist)
		saveActionBindings(actionslist);
	end
	
	self.Destroy = VFL.hook(function(s)
		s.LoadAB = nil; s.SaveAB = nil
	end, self.Destroy);
	
	return self;
end

local function EditActionBindings(path, md, parent)
	--TODO
end

-- The Window object type.
RDXDB.RegisterObjectType({
	name = "ActionBindings",
	version = 1,
	New = function(path, md)
		md.version = 1;
		md.data = {};
		saveActionBindings(md.data);
	end,
	Edit = function(path, md, parent)
		if currentpath == path then
			EditActionBindings(path, md, parent);
		else
			RDX.printI("Edit only active AB");
		end
	end,
	Instantiate = function(path, obj)
		if currentActionBindings then RDX.printI("a action bindings is already instantiated"); return nil; end
		local ab = RDXAB.ActionBindings:new(parent);
		-- Set the path
		ab._path = path;
		currentpath = path;
		-- Setup desktop
		ab:LoadAB(obj.data);
		return ab;
	end,
	Deinstantiate = function(instance, path, obj, nosave)
		if not nosave then instance:SaveAB(obj.data); end
		instance:Destroy();
		instance._path = nil;
		instance = nil;
	end,
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		--table.insert(mnu, {
		--	text = VFLI.i18n("Edit..."),
		--	func = function()
		--		VFL.poptree:Release();
		--		RDXDB.OpenObject(path, "Edit", dlg);
		--	end
		--});
	end,
});

