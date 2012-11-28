-- OpenRDX
-- Sigg / Rashgarroth EU

local tysl = {};
local savelink = {}; -- use to store previous link to check a change.

function RDXDB.GetSymLinkTarget(data)
	if not data or not data.class then return; end
	local sl = tysl[data.class];
	if not sl then return; end
	return sl.GetTargetPath(data);
end

function RDXDB.RegisterSymLinkClass(tbl)
	local name = tbl.name;
	if not name then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Attempt to register an anonymous SymLink type.")); return; end
	if tysl[name] then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Attempt to register duplicate SymLink type ") .. name .. "."); return; end
	tysl[name] = tbl;
end

local function GetSymLinkClassByName(n)
	if not n then return nil; end
	return tysl[n];
end


-- The "SymLink" object type
local dlg = nil;
local function EditSymlink(parent, path, md)
	if dlg then
		RDX.printI(VFLI.i18n("A symlink editor is already open. Please close it first.")); return;
	end
	if (not path) or (not md) then return; end
	-- Create the dialog
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(335); dlg:SetHeight(350);
	dlg:SetText(VFLI.i18n("Edit Symlink: ") .. path);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("symlink_editor") then RDXPM.RestoreLayout(dlg, "symlink_editor"); end

	local slsel = RDXDB.SymLinkFinder:new(dlg:GetClientArea());
	slsel:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	slsel:SetWidth(310); slsel:SetHeight(260);

	if md.data and type(md.data) == "table" then slsel:SetDescriptor(md.data); end
	slsel.isLayoutRoot = true;
	if slsel.DialogOnLayout then slsel:DialogOnLayout(); end
	slsel:Show();
	-- Show the editor
	dlg:Show();	
	--dlg:Show(.2, true);

	---------- Destruction
	local esch = function() 
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "symlink_editor");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText(VFLI.i18n("OK")); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		md.data = slsel:GetDescriptor();
		VFL.EscapeTo(esch);
		local sl = tysl[md.data.class];
		if sl and sl.Unregister then sl.Unregister(path); end
		if sl and sl.Register then sl.Register(path); end
		RDXDB.NotifyUpdate(path);
		savelink[path] = RDXDB.ResolvePath(path);
	end);

	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		slsel:Destroy(); slsel = nil;
		dlg = nil;
	end, dlg.Destroy);
end

--- Open an editor for the given symlink
function RDXDB.EditSymLink(path, parent)
	local data = RDXDB._AccessPathRaw(RDXDB.ParsePath(path));
	if not data then return; end
	EditSymlink(parent, path, data);
end

--- Repoint the given symlink at another destination.
-- DEPRECATED
function RDXDB.SetSymLinkTarget(linkPath, targetPath)
	-- Sanity check
	local data = RDXDB._AccessPathRaw(RDXDB.ParsePath(linkPath));
	if (not data) or (data.ty ~= "SymLink") then return; end
	-- Update the link
	data.data = {class = "simple"; targetpath = targetPath;};
	-- Notify of update
	RDXDB.NotifyUpdate(linkPath);
	--VFL.print("DEPRECATED FUNCTION RDXDB.SetSymLinkTarget");
end

RDXDB.RegisterObjectType({
	name = "SymLink";
	version = 3;
	VersionMismatch = function(md)
		-- code update version 1 and version 2 to version 3;
		md.version = 3;
		-- save md.data
		local tmpdata = md.data;
		if type(tmpdata) == "string" then 
			md.data = {class = "simple"; targetpath = tmpdata;};
			tmpdata = nil;
		end
		return true;
	end,
	New = function(path, md) md.version = 3; md.data = {class = "simple"; targetpath = ""}; end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit");
			OnClick = function()
				VFL.poptree:Release();
				EditSymlink(dlg, path, md);
			end;
		});
	end;
});

RDXDB.SymLinkFinder = {};
function RDXDB.SymLinkFinder:new(parent)
	local self = VFLUI.SelectEmbed:new(parent, 150, function()
		local qq = {};
		for k,v in pairs(tysl) do table.insert(qq, {text = v.title, value = v}); end
		return qq;
	end, function(ctl, desc)
		local cls = GetSymLinkClassByName(desc.class);
		if cls then
			return cls.GetUI(ctl, desc), cls.title, cls;
		end
	end);
	self:SetText(VFLI.i18n("Set Class:"));
	return self;
end

RDXDB.RegisterSymLinkClass({
	name = "simple";
	title = "simple";
	GetTargetPath = function(data)
		return data.targetpath;
	end;
	Register = function(path, data)
		--VFL.print("REGISTER " .. path);
		local link = RDXDB.GetSymLinkTarget(data);
		RDXDBEvents:Bind("OBJECT_UPDATED", nil, function(up, uf)
				local cpath = (up .. ":" .. uf);
				if cpath == link then RDXDB.NotifyUpdate(path); end
		end, "symlink_" .. path);
	end;
	Unregister = function(path)
		--VFL.print("UNREGISTER " .. path);
		VFLEvents:Unbind("symlink_" .. path);
		RDXDBEvents:Unbind("symlink_" .. path);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ff = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff:SetLabel(VFLI.i18n("Link target"));
		if desc and desc.targetpath then ff:SetPath(desc.targetpath); end
		ff:Show();
		ui:InsertFrame(ff);

		ui.GetDescriptor = function(x)
			return {class = "simple", targetpath = ff:GetPath()};
		end;

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
});

RDXDB.RegisterSymLinkClass({
	name = "talent";
	title = "talent";
	GetTargetPath = function(data)
		return data["talentpath_" .. GetActiveTalentGroup()];
	end;
	Register = function(path)
		--VFL.print("REGISTER " .. path);
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function()
			local newlink = RDXDB.ResolvePath(path);
			if savelink[path] ~= newlink then
				RDXDB.NotifyUpdate(path);
				savelink[path] = newlink;
			end
		end, "symlink_" .. path);
	end;
	Unregister = function(path)
		--VFL.print("UNREGISTER " .. path);
		VFLEvents:Unbind("symlink_" .. path);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ff = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff:SetLabel(VFLI.i18n("Talent 1"));
		if desc and desc.talentpath_1 then ff:SetPath(desc.talentpath_1); end
		ff:Show();
		ui:InsertFrame(ff);
		
		local ff2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff2:SetLabel(VFLI.i18n("Talent 2"));
		if desc and desc.talentpath_2 then ff2:SetPath(desc.talentpath_2); end
		ff2:Show();
		ui:InsertFrame(ff2);

		ui.GetDescriptor = function(x)
			return {class = "talent", talentpath_1 = ff:GetPath(), talentpath_2 = ff2:GetPath()};
		end;

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
});

RDXDB.RegisterSymLinkClass({
	name = "class";
	title = "class";
	GetTargetPath = function(data)
		return data["targetpath_" .. RDXMD.GetClassID(select(2, UnitClass("PLAYER")))];
	end;
	Unregister = function(path)
		--VFL.print("UNREGISTER " .. path);
		VFLEvents:Unbind("symlink_" .. path);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ff = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff:SetLabel(VFLI.i18n("PRIEST"));
		if desc and desc.targetpath_1 then ff:SetPath(desc.targetpath_1); end
		ff:Show();
		ui:InsertFrame(ff);
		
		local ff2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff2:SetLabel(VFLI.i18n("DRUID"));
		if desc and desc.targetpath_2 then ff2:SetPath(desc.targetpath_2); end
		ff2:Show();
		ui:InsertFrame(ff2);
		
		local ff3 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff3:SetLabel(VFLI.i18n("PALADIN"));
		if desc and desc.targetpath_3 then ff3:SetPath(desc.targetpath_3); end
		ff3:Show();
		ui:InsertFrame(ff3);
		
		local ff4 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff4:SetLabel(VFLI.i18n("SHAMAN"));
		if desc and desc.targetpath_4 then ff4:SetPath(desc.targetpath_4); end
		ff4:Show();
		ui:InsertFrame(ff4);
		
		local ff5 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff5:SetLabel(VFLI.i18n("WARRIOR"));
		if desc and desc.targetpath_5 then ff5:SetPath(desc.targetpath_5); end
		ff5:Show();
		ui:InsertFrame(ff5);
		
		local ff6 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff6:SetLabel(VFLI.i18n("WARLOCK"));
		if desc and desc.targetpath_6 then ff6:SetPath(desc.targetpath_6); end
		ff6:Show();
		ui:InsertFrame(ff6);
		
		local ff7 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff7:SetLabel(VFLI.i18n("MAGE"));
		if desc and desc.targetpath_7 then ff7:SetPath(desc.targetpath_7); end
		ff7:Show();
		ui:InsertFrame(ff7);
		
		local ff8 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff8:SetLabel(VFLI.i18n("ROGUE"));
		if desc and desc.targetpath_8 then ff8:SetPath(desc.targetpath_8); end
		ff8:Show();
		ui:InsertFrame(ff8);
		
		local ff9 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff9:SetLabel(VFLI.i18n("HUNTER"));
		if desc and desc.targetpath_9 then ff9:SetPath(desc.targetpath_9); end
		ff9:Show();
		ui:InsertFrame(ff9);
		
		local ff10 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff10:SetLabel(VFLI.i18n("DEATHKNIGHT"));
		if desc and desc.targetpath_10 then ff10:SetPath(desc.targetpath_10); end
		ff10:Show();
		ui:InsertFrame(ff10);
		
		local ff11 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff11:SetLabel(VFLI.i18n("MONK"));
		if desc and desc.targetpath_11 then ff11:SetPath(desc.targetpath_11); end
		ff11:Show();
		ui:InsertFrame(ff11);

		ui.GetDescriptor = function(x)
			return {
				class = "class", 
				targetpath_1 = ff:GetPath(),
				targetpath_2 = ff2:GetPath(),
				targetpath_3 = ff3:GetPath(),
				targetpath_4 = ff4:GetPath(),
				targetpath_5 = ff5:GetPath(),
				targetpath_6 = ff6:GetPath(),
				targetpath_7 = ff7:GetPath(),
				targetpath_8 = ff8:GetPath(),
				targetpath_9 = ff9:GetPath(),
				targetpath_10 = ff10:GetPath(),
				targetpath_11 = ff11:GetPath(),
			};
		end;

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
});

RDXDB.RegisterSymLinkClass({
	name = "classtalent";
	title = "class&talent";
	GetTargetPath = function(data)
		return data["targetpath_" .. RDXMD.GetClassID(select(2, UnitClass("PLAYER"))) .. "_" .. GetActiveTalentGroup()];
	end;
	Register = function(path)
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function()
			local newlink = RDXDB.ResolvePath(path);
			if savelink[path] ~= newlink then
				RDXDB.NotifyUpdate(path);
				savelink[path] = newlink;
			end
		end, "symlink_" .. path);
	end;
	Unregister = function(path)
		VFLEvents:Unbind("symlink_" .. path);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ff1_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff1_1:SetLabel(VFLI.i18n("PRIEST TALENT 1"));
		if desc and desc.targetpath_1_1 then ff1_1:SetPath(desc.targetpath_1_1); end
		ff1_1:Show();
		ui:InsertFrame(ff1_1);
		
		local ff1_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff1_2:SetLabel(VFLI.i18n("PRIEST TALENT 2"));
		if desc and desc.targetpath_1_2 then ff1_2:SetPath(desc.targetpath_1_2); end
		ff1_2:Show();
		ui:InsertFrame(ff1_2);
		
		local ff2_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff2_1:SetLabel(VFLI.i18n("DRUID TALENT 1"));
		if desc and desc.targetpath_2_1 then ff2_1:SetPath(desc.targetpath_2_1); end
		ff2_1:Show();
		ui:InsertFrame(ff2_1);
		
		local ff2_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff2_2:SetLabel(VFLI.i18n("DRUID TALENT 2"));
		if desc and desc.targetpath_2_2 then ff2_2:SetPath(desc.targetpath_2_2); end
		ff2_2:Show();
		ui:InsertFrame(ff2_2);
		
		local ff3_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff3_1:SetLabel(VFLI.i18n("PALADIN TALENT 1"));
		if desc and desc.targetpath_3_1 then ff3_1:SetPath(desc.targetpath_3_1); end
		ff3_1:Show();
		ui:InsertFrame(ff3_1);
		
		local ff3_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff3_2:SetLabel(VFLI.i18n("PALADIN TALENT 2"));
		if desc and desc.targetpath_3_2 then ff3_2:SetPath(desc.targetpath_3_2); end
		ff3_2:Show();
		ui:InsertFrame(ff3_2);
		
		local ff4_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff4_1:SetLabel(VFLI.i18n("SHAMAN TALENT 1"));
		if desc and desc.targetpath_4_1 then ff4_1:SetPath(desc.targetpath_4_1); end
		ff4_1:Show();
		ui:InsertFrame(ff4_1);
		
		local ff4_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff4_2:SetLabel(VFLI.i18n("SHAMAN TALENT 2"));
		if desc and desc.targetpath_4_2 then ff4_2:SetPath(desc.targetpath_4_2); end
		ff4_2:Show();
		ui:InsertFrame(ff4_2);
		
		local ff5_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff5_1:SetLabel(VFLI.i18n("WARRIOR TALENT 1"));
		if desc and desc.targetpath_5_1 then ff5_1:SetPath(desc.targetpath_5_1); end
		ff5_1:Show();
		ui:InsertFrame(ff5_1);
		
		local ff5_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff5_2:SetLabel(VFLI.i18n("WARRIOR TALENT 2"));
		if desc and desc.targetpath_5_2 then ff5_2:SetPath(desc.targetpath_5_2); end
		ff5_2:Show();
		ui:InsertFrame(ff5_2);
		
		local ff6_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff6_1:SetLabel(VFLI.i18n("WARLOCK TALENT 1"));
		if desc and desc.targetpath_6_1 then ff6_1:SetPath(desc.targetpath_6_1); end
		ff6_1:Show();
		ui:InsertFrame(ff6_1);
		
		local ff6_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff6_2:SetLabel(VFLI.i18n("WARLOCK TALENT 2"));
		if desc and desc.targetpath_6_2 then ff6_2:SetPath(desc.targetpath_6_2); end
		ff6_2:Show();
		ui:InsertFrame(ff6_2);
		
		local ff7_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff7_1:SetLabel(VFLI.i18n("MAGE TALENT 1"));
		if desc and desc.targetpath_7_1 then ff7_1:SetPath(desc.targetpath_7_1); end
		ff7_1:Show();
		ui:InsertFrame(ff7_1);
		
		local ff7_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff7_2:SetLabel(VFLI.i18n("MAGE TALENT 2"));
		if desc and desc.targetpath_7_2 then ff7_2:SetPath(desc.targetpath_7_2); end
		ff7_2:Show();
		ui:InsertFrame(ff7_2);
		
		local ff8_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff8_1:SetLabel(VFLI.i18n("ROGUE TALENT 1"));
		if desc and desc.targetpath_8_1 then ff8_1:SetPath(desc.targetpath_8_1); end
		ff8_1:Show();
		ui:InsertFrame(ff8_1);
		
		local ff8_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff8_2:SetLabel(VFLI.i18n("ROGUE TALENT 2"));
		if desc and desc.targetpath_8_2 then ff8_2:SetPath(desc.targetpath_8_2); end
		ff8_2:Show();
		ui:InsertFrame(ff8_2);
		
		local ff9_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff9_1:SetLabel(VFLI.i18n("HUNTER TALENT 1"));
		if desc and desc.targetpath_9_1 then ff9_1:SetPath(desc.targetpath_9_1); end
		ff9_1:Show();
		ui:InsertFrame(ff9_1);
		
		local ff9_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff9_2:SetLabel(VFLI.i18n("HUNTER TALENT 2"));
		if desc and desc.targetpath_9_2 then ff9_2:SetPath(desc.targetpath_9_2); end
		ff9_2:Show();
		ui:InsertFrame(ff9_2);
		
		local ff10_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff10_1:SetLabel(VFLI.i18n("DEATHKNIGHT TALENT 1"));
		if desc and desc.targetpath_10_1 then ff10_1:SetPath(desc.targetpath_10_1); end
		ff10_1:Show();
		ui:InsertFrame(ff10_1);
		
		local ff10_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff10_2:SetLabel(VFLI.i18n("DEATHKNIGHT TALENT 2"));
		if desc and desc.targetpath_10_2 then ff10_2:SetPath(desc.targetpath_10_2); end
		ff10_2:Show();
		ui:InsertFrame(ff10_2);
		
		local ff11_1 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff11_1:SetLabel(VFLI.i18n("MONK TALENT 1"));
		if desc and desc.targetpath_11_1 then ff11_1:SetPath(desc.targetpath_11_1); end
		ff11_1:Show();
		ui:InsertFrame(ff11_1);
		
		local ff11_2 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		ff11_2:SetLabel(VFLI.i18n("MONK TALENT 2"));
		if desc and desc.targetpath_11_2 then ff11_2:SetPath(desc.targetpath_11_2); end
		ff11_2:Show();
		ui:InsertFrame(ff11_2);

		ui.GetDescriptor = function(x)
			return {
				class = "classtalent",
				targetpath_1_1 = ff1_1:GetPath(),
				targetpath_2_1 = ff2_1:GetPath(),
				targetpath_3_1 = ff3_1:GetPath(),
				targetpath_4_1 = ff4_1:GetPath(),
				targetpath_5_1 = ff5_1:GetPath(),
				targetpath_6_1 = ff6_1:GetPath(),
				targetpath_7_1 = ff7_1:GetPath(),
				targetpath_8_1 = ff8_1:GetPath(),
				targetpath_9_1 = ff9_1:GetPath(),
				targetpath_10_1 = ff10_1:GetPath(),
				targetpath_11_1 = ff11_1:GetPath(),
				targetpath_1_2 = ff1_2:GetPath(),
				targetpath_2_2 = ff2_2:GetPath(),
				targetpath_3_2 = ff3_2:GetPath(),
				targetpath_4_2 = ff4_2:GetPath(),
				targetpath_5_2 = ff5_2:GetPath(),
				targetpath_6_2 = ff6_2:GetPath(),
				targetpath_7_2 = ff7_2:GetPath(),
				targetpath_8_2 = ff8_2:GetPath(),
				targetpath_9_2 = ff9_2:GetPath(),
				targetpath_10_2 = ff10_2:GetPath(),
				targetpath_11_2 = ff11_2:GetPath(),
			};
		end;

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
});

local _objectsadd = {
	{ text = "AuraFilter" },
	{ text = "MouseBindings" },
	{ text = "UnitFrameType" },
};
local function ObjectsTypesDropdownFunction() return _objectsadd; end

RDXDB.RegisterSymLinkClass({
	name = "name&realm";
	title = "name&realm";
	GetTargetPath = function(data)
		if not data.pkg or not data.prefixfile or not data.ty then return nil; end
		if data.pkg ~= "default" then
			RDXDB.CreateObject(data.pkg, data.prefixfile .. RDX.pspace, data.ty);
		end
		return data.pkg .. ":" .. data.prefixfile .. RDX.pspace;
	end;
	Unregister = function(path)
		VFLEvents:Unbind("symlink_" .. path);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_pkg = VFLUI.LabeledEdit:new(ui, 150); ed_pkg:Show();
		ed_pkg:SetText(VFLI.i18n("Package"));
		if desc and desc.pkg then ed_pkg.editBox:SetText(desc.pkg); end
		ui:InsertFrame(ed_pkg);
		
		local ed_prefixfile = VFLUI.LabeledEdit:new(ui, 150); ed_prefixfile:Show();
		ed_prefixfile:SetText(VFLI.i18n("Prefix"));
		if desc and desc.prefixfile then ed_prefixfile.editBox:SetText(desc.prefixfile); end
		ui:InsertFrame(ed_prefixfile);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Object Type:"));
		local dd_objectType = VFLUI.Dropdown:new(er, ObjectsTypesDropdownFunction);
		dd_objectType:SetWidth(150); dd_objectType:Show();
		if desc and desc.ty then 
			dd_objectType:SetSelection(desc.ty); 
		else
			dd_objectType:SetSelection("AuraFilter");
		end
		er:EmbedChild(dd_objectType); er:Show();
		ui:InsertFrame(er);
		
		ui.GetDescriptor = function(x)
			return {
				class = "name&realm", 
				pkg = ed_pkg.editBox:GetText(),
				prefixfile = ed_prefixfile.editBox:GetText(),
				ty = dd_objectType:GetSelection();
			};
		end;

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
});

RDXDB.RegisterSymLinkClass({
	name = "talent&name&realm";
	title = "talent&name&realm";
	GetTargetPath = function(data)
		if not data.pkg or not data.prefixfile or not data.ty then return nil; end
		if data.pkg ~= "default" then
			RDXDB.CreateObject(data.pkg, data.prefixfile .. RDX.pspace .. RDXMD.GetSelfTalentNoIndex(), data.ty);
		end
		if not RDXDB.AccessPath(data.pkg, data.prefixfile .. RDX.pspace .. RDXMD.GetSelfTalentNoIndex()) then
			RDXDB.CreateObject(data.pkg, data.prefixfile .. RDX.pspace .. RDXMD.GetSelfTalentNoIndex(), data.ty);
		end
		return data.pkg .. ":" .. data.prefixfile .. RDX.pspace .. RDXMD.GetSelfTalentNoIndex();
	end;
	Register = function(path)
		--VFL.print("REGISTER " .. path);
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function() 
			local newlink = RDXDB.ResolvePath(path);
			if savelink[path] ~= newlink then
				RDXDB.NotifyUpdate(path);
				savelink[path] = newlink;
			end
		end, "symlink_" .. path);
	end;
	Unregister = function(path)
		VFLEvents:Unbind("symlink_" .. path);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_pkg = VFLUI.LabeledEdit:new(ui, 150); ed_pkg:Show();
		ed_pkg:SetText(VFLI.i18n("Package"));
		if desc and desc.pkg then ed_pkg.editBox:SetText(desc.pkg); end
		ui:InsertFrame(ed_pkg);
		
		local ed_prefixfile = VFLUI.LabeledEdit:new(ui, 150); ed_prefixfile:Show();
		ed_prefixfile:SetText(VFLI.i18n("Prefix"));
		if desc and desc.prefixfile then ed_prefixfile.editBox:SetText(desc.prefixfile); end
		ui:InsertFrame(ed_prefixfile);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Object Type:"));
		local dd_objectType = VFLUI.Dropdown:new(er, ObjectsTypesDropdownFunction);
		dd_objectType:SetWidth(150); dd_objectType:Show();
		if desc and desc.ty then 
			dd_objectType:SetSelection(desc.ty); 
		else
			dd_objectType:SetSelection("AuraFilter");
		end
		er:EmbedChild(dd_objectType); er:Show();
		ui:InsertFrame(er);
		
		ui.GetDescriptor = function(x)
			return {
				class = "talent&name&realm", 
				pkg = ed_pkg.editBox:GetText(),
				prefixfile = ed_prefixfile.editBox:GetText(),
				ty = dd_objectType:GetSelection();
			};
		end;

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
});

-- symlink for windows class (holy, shard, rune or other)
RDXDB.RegisterSymLinkClass({
	name = "class&form";
	title = "class&form";
	GetTargetPath = function(data)
		local class = select(2, UnitClass("PLAYER"));
		local form = GetShapeshiftFormID();
		local spec = GetSpecialization();
		if class == "DEATHKNIGHT" then
			return data["DEATHKNIGHT"];
		--elseif class == "SHAMAN" then
		--	return data["SHAMAN"];
		--elseif class == "ROGUE" then
		--	return data["ROGUE"];
		elseif class == "WARLOCK" and spec == SPEC_WARLOCK_AFFLICTION then --and IsPlayerSpell(WARLOCK_SOULBURN) then
			return data["WARLOCK_AFFLICTION"];
		elseif class == "WARLOCK" and spec == SPEC_WARLOCK_DESTRUCTION then --and IsPlayerSpell(WARLOCK_BURNING_EMBERS) then
			return data["WARLOCK_DESTRUCTION"];
		elseif class == "WARLOCK" and spec == SPEC_WARLOCK_DEMONOLOGY then
			return data["WARLOCK_DEMONOLOGY"];
		elseif class == "DRUID" and (form == MOONKIN_FORM or not form) and spec == 1 then
			return data["DRUID_MOONKIN"];
		--elseif class == "DRUID" and form == 3 then
		--	return data["DRUIDCAT"];
		elseif class == "PALADIN" then
			return data["PALADIN"];
		elseif class == "MONK" then
			return data["MONK"];
		elseif class == "PRIEST" and spec == SPEC_PRIEST_SHADOW then
			return data["PRIEST_SHADOW"];
		else
			return data["all"];
		end
	end;
	Register = function(path)
		VFLEvents:Bind("PLAYER_TALENT_UPDATE", nil, function()
			local newlink = RDXDB.ResolvePath(path);
			if savelink[path] ~= newlink then
				RDXDB.NotifyUpdate(path);
				savelink[path] = newlink;
			end
		end, "symlink_" .. path);
		VFLEvents:Bind("PLAYER_FORM_UPDATE", nil, function() 
			local newlink = RDXDB.ResolvePath(path);
			if savelink[path] ~= newlink then
				RDXDB.NotifyUpdate(path);
				savelink[path] = newlink;
			end
		end, "symlink_" .. path);
		--WoWEvents:Bind("SPELLS_CHANGED", nil, function() 
		--	local newlink = RDXDB.ResolvePath(path);
		--	if savelink[path] ~= newlink then
		--		RDXDB.NotifyUpdate(path);
		--		savelink[path] = newlink;
		--	end
		--end, "symlink_" .. path);
	end;
	Unregister = function(path)
		--VFL.print("UNREGISTER " .. path);
		VFLEvents:Unbind("symlink_" .. path);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local dk = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		dk:SetLabel(VFLI.i18n("DEATHKNIGHT"));
		if desc and desc.DEATHKNIGHT then dk:SetPath(desc.DEATHKNIGHT); end
		dk:Show();
		ui:InsertFrame(dk);
		
		--local sh = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		--sh:SetLabel(VFLI.i18n("SHAMAN"));
		--if desc and desc.SHAMAN then sh:SetPath(desc.SHAMAN); end
		--sh:Show();
		--ui:InsertFrame(sh);
		
		--local ff3 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		--ff3:SetLabel(VFLI.i18n("ROGUE"));
		--if desc and desc.ROGUE then ff3:SetPath(desc.ROGUE); end
		--ff3:Show();
		--ui:InsertFrame(ff3);
		
		local wlaf = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		wlaf:SetLabel(VFLI.i18n("WARLOCK AFFLICTION"));
		if desc and desc.WARLOCK_AFFLICTION then wlaf:SetPath(desc.WARLOCK_AFFLICTION); end
		wlaf:Show();
		ui:InsertFrame(wlaf);
		
		local wldt = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		wldt:SetLabel(VFLI.i18n("WARLOCK DESTRUCTION"));
		if desc and desc.WARLOCK_DESTRUCTION then wldt:SetPath(desc.WARLOCK_DESTRUCTION); end
		wldt:Show();
		ui:InsertFrame(wldt);
		
		local wldm = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		wldm:SetLabel(VFLI.i18n("WARLOCK DEMONOLOGY"));
		if desc and desc.WARLOCK_DEMONOLOGY then wldm:SetPath(desc.WARLOCK_DEMONOLOGY); end
		wldm:Show();
		ui:InsertFrame(wldm);
		
		local drm = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		drm:SetLabel(VFLI.i18n("DRUID MOONKIN"));
		if desc and desc.DRUID_MOONKIN then drm:SetPath(desc.DRUID_MOONKIN); end
		drm:Show();
		ui:InsertFrame(drm);
		
		--local ff6 = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		--ff6:SetLabel(VFLI.i18n("DRUID CAT"));
		--if desc and desc.DRUIDCAT then ff6:SetPath(desc.DRUIDCAT); end
		--ff6:Show();
		--ui:InsertFrame(ff6);
		
		local pa = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		pa:SetLabel(VFLI.i18n("PALADIN"));
		if desc and desc.PALADIN then pa:SetPath(desc.PALADIN); end
		pa:Show();
		ui:InsertFrame(pa);
		
		local mo = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		mo:SetLabel(VFLI.i18n("MONK"));
		if desc and desc.MONK then mo:SetPath(desc.MONK); end
		mo:Show();
		ui:InsertFrame(mo);
		
		local prs = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		prs:SetLabel(VFLI.i18n("PRIEST SHADOW"));
		if desc and desc.PRIEST_SHADOW then prs:SetPath(desc.PRIEST_SHADOW); end
		prs:Show();
		ui:InsertFrame(prs);
		
		local all = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table"); end);
		all:SetLabel(VFLI.i18n("ALL"));
		if desc and desc.all then all:SetPath(desc.all); end
		all:Show();
		ui:InsertFrame(all);

		ui.GetDescriptor = function(x)
			return {
				class = "class&form", 
				DEATHKNIGHT = dk:GetPath(),
				--SHAMAN = sh:GetPath(),
				--ROGUE = ff3:GetPath(),
				WARLOCK_AFFLICTION = wlaf:GetPath(),
				WARLOCK_DESTRUCTION = wldt:GetPath(),
				WARLOCK_DEMONOLOGY = wldm:GetPath(),
				DRUID_MOONKIN = drm:GetPath(),
				--DRUIDCAT = ff6:GetPath(),
				PALADIN = pa:GetPath(),
				MONK = mo:GetPath(),
				PRIEST_SHADOW = prs:GetPath(),
				all = all:GetPath(),
			};
		end;

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
});

-----------------------------------------
-- Register event for symlink
-----------------------------------------

RDXDBEvents:Bind("OBJECT_DELETED", nil, function(pkg, file, md)
	if md and md.ty == "SymLink" then
		local path = RDXDB.MakePath(pkg,file);
		if md.data and type(md.data) == "table" then
			local sl = tysl[md.data.class];
			if not sl then return; end
			if sl.Unregister then sl.Unregister(path); end
		end
	end
end);
RDXDBEvents:Bind("OBJECT_MOVED", nil, function(pkg, file, newpkg, newfile, md)
	if md and md.ty == "SymLink" then
		local path = RDXDB.MakePath(pkg,file);
		local path2 =  RDXDB.MakePath(newpkg,newfile);
		if md.data and type(md.data) == "table" then
			local sl = tysl[md.data.class];
			if not sl then return; end
			if sl.Unregister then sl.Unregister(path); end
			if sl.Register then sl.Register(path2, md.data); end
		end
	end
end);

-- run on UI load 
local function ApplyEvents()
	for pkgName,pkg in pairs(RDXData) do
		for objName,md in pairs(pkg) do
			if type(md) == "table" and md.ty == "SymLink" then
				if md.data and type(md.data) == "table" then
					local sl = tysl[md.data.class];
					if not sl then return; end
					if sl.Register then sl.Register(pkgName .. ":" ..objName, md.data); end
					-- store the path
					savelink[pkgName .. ":" ..objName] = RDXDB.ResolvePath(pkgName .. ":" ..objName);
				end
			end
		end
	end
end
RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, function()
	ApplyEvents();
end);

