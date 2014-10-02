-- PackagesUpdaterDialog.lua
-- OpenRDX

--[[
local dlg = nil;
function RDXDB.ShowUpdaterDialog
onglet vos packages
package name     package version    package author    package comment   bouton recherche

onglet package de quelqu un
end

-- depuis le menu du joueur, consulter la liste des packages disponibles
function GetSharePackageInfo("sigg")
package name     package version    package author    package comment   bouton get
end

function Request

function Response


-- Rechercher le package le plus à jour disponible
recherche :

nom 
package name     package version    package author    package comment   bouton get



function récupère package info
]]

--------------------------------------
-- CLIENT
-- Receive package from server 
-- and install it
--------------------------------------

local function ClientSendPkg(si, data, targets)
	if (not si) or (type(data) ~= "table") then
		RPC:Debug(1, "Received integrate with invalid parameters");
		return;
	end
	local myunit = RDXDAL.GetMyUnit();
	local name = si.sender;	if not name then RPC:Debug(1, "Ignoring integrate with unknown sender."); return; end
	-- Don't integrate my own stuff.
	if(name == myunit.name) then RPC:Debug(2, "Ignoring integrate from self."); end
	-- Check against allowedSenders and deniedSenders.
	local d = RDXDB.GetObjectData("RDXDiskSystem:default:allowedSenders");
	if d and d.data then
		if not VFL.vfind(d.data, name) then RPC:Debug(1, "Ignoring integrate from unallowed sender " .. name); return; end
	end
	d = RDXDB.GetObjectData("RDXDiskSystem:default:deniedSenders");
	if d and d.data then
		if VFL.vfind(d.data, name) then RPC:Debug(1, "Ignoring integrate from denied sender " .. name); return; end
	end
	-- Match against target list.
	-- This is not a very efficient way to do this, but it's rarely called so it shouldn't be a major issue.
	if type(targets) == "table" then
		local match = false;
		for _,targ in pairs(targets) do
			local p = targ:match("^%*class:(.*)$");
			if p and p == myunit:GetClassMnemonic() then match = true; break; end
			p = targ:match("^%*group:(%d+)$");
			if p and tonumber(p) == myunit:GetGroup() then match = true; break; end
			if targ == myunit.name then match = true; break; end
		end
		if not match then return; end
	end
	-- Do it
	RPC:Debug(2, "Integrating from user " .. name);
	RDX.TryIntegrate(VFLDIALOG, data, name);
end

RPC.GlobalBind("rau_sendpkg", ClientSendPkg);

function RDXDB.RAU_RequestPkg(conf, who, pkg)
	if type(who) ~= "string" or type(pkg) ~= "string" then return; end
	who = string.lower(who);
	local rpcid;
	if conf == "GROUP" then 
		rpcid = RPC_Group:Invoke("rau_requestPkg", conf, who, pkg);
	else
		rpcid = RPC_Guild:Invoke("rau_requestPkg", conf, who, pkg);
	end
	
	--local hours, minutes = GetGameTime();
	--local dataTransfert = { name = pkg; version = vs; duload = "Download"; who = who; dt = hours .. ":" .. minutes; status = "Start"; };
	--NewTransfert(dataTransfert, rpcid);
	--RPC_Group:Wait(rpcid, RAU_ReqPck_Rcvd, 300);
	--VFLT.ZMSchedule(301, function()
	--	if GetTransfertStatus(rpcid) == "Start" then
	--		UpdateTransfertStatus(rpcid, "Timeout");
			--RDXDB.UpdateRAUMode(4);
	--	end
	--end);
end



-----------------------------
-- OLD DISPATCHER Request Package
-----------------------------
--local function RAU_ReqPck_Rcvd(ci, resp)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
--	if (not ci) or (not ci.sender) or (not ci.id) or (type(resp) ~= "table") then return; end
--	local su = RPC.GetSenderUnit(ci); if not su then return; end
--	UpdateTransfertStatus(ci.id, "Done");
--	RDX.TryIntegrate(VFLDIALOG, resp, "test", nil);
--	if not RDXDB.IsRAUShown() then RDXDB.ShowRAU(); end
--	RDXDB.UpdateRAUMode(2);
--end


----------------------------------------------------------------------------
-- GUI
----------------------------------------------------------------------------

local dlg = nil; -- Main dialog
local fdlg = nil; -- Generic subdialog variable

local dlg = VFLUI.Window:new();
VFLUI.Window.SetDefaultFraming(dlg, 24);
dlg:SetText(VFLI.i18n("RDX Packages Updater"));
dlg:SetTitleColor(0,0,.6);
dlg:SetWidth(660); dlg:SetHeight(390);
dlg:SetPoint("CENTER", RDXParent, "CENTER");
dlg:SetMovable(true); dlg:SetToplevel(nil);
dlg:SetClampedToScreen(true);
VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
dlg:Hide();
local ca = dlg:GetClientArea();

---------------------------------------------------------------
-- DATA LIST
---------------------------------------------------------------

local function CellOnClick(self, arg1)
	if RDXDB.GetRAUMode() == 2 then
		if(arg1 == "RightButton") then
			local mnu = {
				{ text = VFL.strcolor(.5, .5, .5) .. "Package " .. self.col[1]:GetText() .. "|r" };
			};
			table.insert(mnu, { 
				text = VFLI.i18n("Info"), 
				func = function()
					local data = {};
					data["infoVersion"] = self.col[2]:GetText(); --version
					data["infoAuthor"] = self.col[3]:GetText(); --author
					data["infoComment"] = self.col[4]:GetText(); --Comment
					RDXDB.PackageMetadataDialog(self, self.col[1]:GetText(), data);
					VFL.poptree:Release(); 
				end
			});
			table.insert(mnu, { 
				text = VFLI.i18n("Download"), 
				func = function() 
					-- who, packagename, version
					RDXDB.RAU_RequestPkg("GUILD", self.col[7]:GetText(), self.col[1]:GetText(), self.col[2]:GetText());
					VFL.poptree:Release(); 
				end
			});
			
			VFL.poptree:Begin(120, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
			VFL.poptree:Expand(nil, mnu);
		end
	elseif RDXDB.GetRAUMode() == 3 then
		if(arg1 == "RightButton") then
			local mnu = {
				{ text = VFL.strcolor(.5, .5, .5) .. "Package " .. self.col[1]:GetText() .. "|r" };
			};
			table.insert(mnu, { 
				text = VFLI.i18n("Info Package"), 
				func = function() 
					-- who, packagename, version
					RDXDB.PackageMetadataDialog(self, self.col[1]:GetText(), RDXDB.GetAllPackageMetadata(self.col[1]:GetText()), function(pkgname, pkgdata) RDXDB.SetAllPackageMetadata(pkgname, pkgdata); RDXDB.UpdateRAUMode(3); end);
					VFL.poptree:Release();
				end
			});
			
			VFL.poptree:Begin(120, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
			VFL.poptree:Expand(nil, mnu);
		end
	end
end

-- Create a cell in the data table
local function CreateCell(parent, ty)
	if not ty then ty = "Button"; end
	local self = VFLUI.AcquireFrame(ty);
	VFLUI.StdSetParent(self, parent); self:SetHeight(10);
	
	-- Button-specific handling
	if ty == "Button" then
		self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		self:SetScript("OnClick", CellOnClick);
		-- Create the button highlight texture
		local hltTexture = VFLUI.CreateTexture(self);
		hltTexture:SetAllPoints(self); hltTexture:Show();
		hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		hltTexture:SetBlendMode("ADD");
		self:SetHighlightTexture(hltTexture);
		self.hltTexture = hltTexture;
		-- Create the selection texture
		local selTexture = VFLUI.CreateTexture(self);
		selTexture:Hide();
		selTexture:SetDrawLayer("BACKGROUND");
		selTexture:SetAllPoints(self);
		selTexture:SetTexture(1, 1, 1, 1);
		self.selTexture = selTexture;
	end

	-- Create the columns.
	local w, af, ap = 0, self, "TOPLEFT";
	self.col = {};
	for i=1,8 do
		-- Create the text object.
		local colText = VFLUI.CreateFontString(self);
		colText:SetDrawLayer("OVERLAY");
		VFLUI.SetFont(colText, Fonts.Default, 9);
		colText:SetShadowOffset(1,-1);
		colText:SetShadowColor(0,0,0,.6);
		colText:SetTextColor(1,1,1,1); colText:SetJustifyH("LEFT");
		colText:SetPoint("TOPLEFT", af, ap); 
		colText:SetHeight(10);
		colText:Show();
		-- Save it
		self.col[i] = colText;
		-- Update iterative variables
		af = colText; ap = "TOPRIGHT";
	end

	-- Create the selection texture
	--local selTexture = VFLUI.CreateTexture(self);
	--selTexture:Hide(); selTexture:SetDrawLayer("BACKGROUND");	selTexture:SetAllPoints(self);
	--selTexture:SetTexture(0, 0, 0.6, 0.6);
	--self.selTexture = selTexture;

	-- Update the Destroy function
	self.Destroy = VFL.hook(function(s)
		-- Destroy columns
		for _,column in pairs(s.col) do column:Destroy(); end
		s.col = nil;
		-- Destroy textures
		if s.hltTexture then VFLUI.ReleaseRegion(s.hltTexture); s.hltTexture = nil; end
		if s.selTexture then VFLUI.ReleaseRegion(s.selTexture); s.selTexture = nil; end
	end, self.Destroy);
	self.OnDeparent = self.Destroy;

	return self;
end

local data_decor = VFLUI.AcquireFrame("Frame");
data_decor:SetParent(ca);
data_decor:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -25);
data_decor:SetWidth(650); data_decor:SetHeight(310);
data_decor:SetBackdrop(VFLUI.DefaultDialogBorder); data_decor:Show();

local data = VFLUI.List:new(ca, 12, CreateCell);
data:SetPoint("TOPLEFT", data_decor, "TOPLEFT", 5, -5);
data:SetWidth(640); data:SetHeight(300); data:Show(); data:Rebuild();

local function SetupLayout(colspec, cols)
	for i=1,8 do
		local cs, col = colspec[i], cols[i];
		if cs then
			col:Show(); col:SetWidth(colspec[i].width); col:SetJustifyH(cs.jh or "LEFT");
		else
			col:Hide();
		end
	end
end

local function PaintTitle(colspec, cols)
	for i=1,8 do
		local cs, col = colspec[i], cols[i];
		if cs then
			col:SetTextColor(1,1,1); col:SetText(cs.title);
		end
	end
end

local function PaintData(colspec, cols, data)
	for i=1,8 do
		local cs,col = colspec[i], cols[i];
		if cs then
			col:SetTextColor(cs.r, cs.g, cs.b);
			cs.paint(col, data);
		end
	end
end

--------------------------------------------------------------------------------
-- Helper
--------------------------------------------------------------------------------

local function GetPkgInfo(pkgName, flagall)
	if not RDXDB.IsProtectedPkg(pkgName) and (flagall or RDXDB.GetPackageMetadata(pkgName, "infoIsShare")) then
		local isA = "no"; if RDXDB.GetPackageMetadata(pkgName, "infoRunAutoexec") then isA = "yes"; end
		local isS = "no"; if RDXDB.GetPackageMetadata(pkgName, "infoIsShare") then isS = "yes"; end
		local pkgInfo = {
			name = pkgName;
			player = UnitName("player");
			guild = GetGuildInfo("player");
			version = RDXDB.GetPackageMetadata(pkgName, "infoVersion");
			author = RDXDB.GetPackageMetadata(pkgName, "infoAuthor");
			realm = RDXDB.GetPackageMetadata(pkgName, "infoAuthorRealm");
			comment = RDXDB.GetPackageMetadata(pkgName, "infoComment");
			objects = RDXDB.GetNumberObjects(pkgName);
			isAutoexec = isA;
			isShare = isS;
		};
		return pkgInfo;
	end
	return nil;
end

local newlist = {};
local function GetListPkgInfo(flagall)
	VFL.empty(newlist);
	local i = 1;
	for pkgName, pkgData in pairs(RDXDB.GetDisk("RDXData")) do
		if not RDXDB.IsProtectedPkg(pkgName) then
			local pkg = GetPkgInfo(pkgName, flagall);
			if pkg then
				newlist[i] = pkg; i = i + 1;
			end
		end
	end
	table.sort(newlist, function(x1,x2) return x1.name < x2.name; end);
	return newlist;
end

--------------------------------------------------------------------------------
-- Packstore Mode
--------------------------------------------------------------------------------

local plist = {};

local colspec_packstore = {
	{ title = "Name"; width = 100; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.name); end;};
	{ title = "Version"; width = 100; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data)
	  	local str = RDXDB.GetPackageMetadata(data.name, "infoVersion");
		if str then
			cell:SetText(data.version .. " (" .. str ..")");
		else
			cell:SetText(data.version);
		end
	end;};
	{ title = "Author"; width = 100; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.author); end;};
	{ title = "Comment"; width = 120; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.comment); end; };
	{ title = "Objects"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.objects); end};
	{ title = "isExec"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.isAutoexec); end;};
	{ title = "Player"; width = 100; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.player); end;};
};

local function SetPackstoreMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_packstore, cell.col);
	end
	local alist = plist;
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetTexture(0,0,0.6,0.6);
			PaintTitle(colspec_packstore, col);
		else
			PaintData(colspec_packstore, col, data);
		end
	end, function() return #alist + 1; end, function(n) if n == 1 then return true; else return alist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	--RDXDBEvents:Unbind(dlg);
	-- Notify to update on repaint
	--RDXDBEvents:Bind("TRANSFERT_RAU_UPDATE", data, data.Update, dlg);
end

--------------------------------------------------------------------------------
-- Guild Mode, view list of packages
--------------------------------------------------------------------------------

local slist = {};

local colspec_srch = {
	{ title = "Name"; width = 100; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.name); end;};
	{ title = "Version"; width = 100; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data)
	  	local str = RDXDB.GetPackageMetadata(data.name, "infoVersion");
		if str then
			cell:SetText(data.version .. " (" .. str ..")");
		else
			cell:SetText(data.version);
		end
	end;};
	{ title = "Author"; width = 100; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.author); end;};
	{ title = "Comment"; width = 120; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.comment); end; };
	{ title = "Objects"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.objects); end};
	{ title = "isExec"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.isAutoexec); end;};
	{ title = "Player"; width = 100; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.player); end;};
};

local function SetGuildMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_srch, cell.col);
	end
	local alist = slist;
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetTexture(0,0,0.6,0.6);
			PaintTitle(colspec_srch, col);
		else
			PaintData(colspec_srch, col, data);
		end
	end, function() return #alist + 1; end, function(n) if n == 1 then return true; else return alist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	--RDXDBEvents:Unbind(dlg);
	-- Notify to update on repaint
	--RDXDBEvents:Bind("PACKAGE_RAU_UPDATED", data, data.Update, dlg);
end

--------------------------------------------------------------------------------
-- Package Mode, view list of yours packages
--------------------------------------------------------------------------------

local sig_PackageUpdated = RDXDBEvents:LockSignal("PACKAGE_RAU_UPDATED");

local plist = {};

local function UpdatePList()
	VFL.empty(plist);
	plist = VFL.copy(GetListPkgInfo(true));
	sig_PackageUpdated:Raise();
end
RDXEvents:Bind("INIT_POST_VARIABLES_LOADED", nil, UpdatePList);
RDXDBEvents:Bind("PACKAGE_METADATA_UPDATE", nil, UpdatePList);
RDXDBEvents:Bind("PACKAGE_CREATED", nil, UpdatePList);
RDXDBEvents:Bind("PACKAGE_DELETED", nil, UpdatePList);

local colspec_pkg = {
	{ title = "Name"; width = 100; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.name); end;};
	{ title = "Version"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.version); end;};
	{ title = "Author"; width = 100; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.author); end;};
	{ title = "Comment"; width = 120; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.comment); end; };
	{ title = "Objects"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.objects); end};
	{ title = "isExec"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.isAutoexec); end;};
	{ title = "isShare"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.isShare); end;};
};

local function SetPackageMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_pkg, cell.col);
	end
	local alist = plist;
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetTexture(0,0,0.6,0.6);
			PaintTitle(colspec_pkg, col);
		else
			PaintData(colspec_pkg, col, data);
		end
	end, function() return #alist + 1; end, function(n) if n == 1 then return true; else return alist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	RDXDBEvents:Unbind(dlg);
	-- Notify to update on repaint
	RDXDBEvents:Bind("PACKAGE_RAU_UPDATED", data, data.Update, dlg);
end

--------------------------------------------------------------------------------
-- Transfert Mode, view list of transfert
--------------------------------------------------------------------------------

local sig_TransfertUpdate = RDXDBEvents:LockSignal("TRANSFERT_RAU_UPDATE");

local tlist = {};
local function NewTransfert(tbl, id)
	tbl.id = id;
	table.insert(tlist, tbl);
	sig_TransfertUpdate:Raise();
end
local function UpdateTransfertStatus(id, status)
	for _,v in ipairs(tlist) do
		if v.id and (v.id == id) then v.status = status; end
	end
	sig_TransfertUpdate:Raise();
end
local function GetTransfertStatus(id)
	for _,v in ipairs(tlist) do
		if v.id and (v.id == id) then return v.status end
	end
	return nil;
end

local colspec_transfert = {
	{ title = "Name"; width = 100; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.name); end;};
	{ title = "Version"; width = 55; r=.95; g=.95; b=.45; jh="CENTER";
	  paint = function(cell, data) cell:SetText(data.version); end;};
	{ title = "Type"; width = 55; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.duload); end; };
	{ title = "From/To"; width = 100; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.who); end};
	{ title = "date/time"; width = 55; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.dt); end;};
	{ title = "Status"; width = 55; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.status); end;};
};

local function SetTransfertMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_transfert, cell.col);
	end
	local alist = tlist;
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetTexture(0,0,0.6,0.6);
			PaintTitle(colspec_transfert, col);
		else
			PaintData(colspec_transfert, col, data);
		end
	end, function() return #alist + 1; end, function(n) if n == 1 then return true; else return alist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	RDXDBEvents:Unbind(dlg);
	-- Notify to update on repaint
	RDXDBEvents:Bind("TRANSFERT_RAU_UPDATE", data, data.Update, dlg);
end

--------------------------------------------------------------------------------
-- Mode buttons
-- Mode 1 (Search PackStore)
-- Mode 2 (Search Guild Package)
-- Mode 3 (My Packages)
-- Mode 4 (Transfert Download)
-- Mode 5 (Transfert Upload)
--------------------------------------------------------------------------------

local mode = 1;

function RDXDB.GetRAUMode()
	return mode;
end

local mb1 = VFLUI.Button:new(ca);
--mb1:SetPoint("LEFT", toggle, "RIGHT", 15, 0);
mb1:SetPoint("TOPLEFT", ca, "TOPLEFT");
mb1:SetWidth(100); mb1:SetHeight(25); mb1:Show();
mb1:SetText("PackStore");
mb1:SetScript("OnClick", function() RDXDB.UpdateRAUMode(1); end);

local mb2 = VFLUI.Button:new(ca);
mb2:SetPoint("LEFT", mb1, "RIGHT");
mb2:SetWidth(100); mb2:SetHeight(25); mb2:Show();
mb2:SetText("Guild");
mb2:SetScript("OnClick", function() RDXDB.UpdateRAUMode(2); end);

local mb3 = VFLUI.Button:new(ca);
mb3:SetPoint("LEFT", mb2, "RIGHT");
mb3:SetWidth(100); mb3:SetHeight(25); mb3:Show();
mb3:SetText("My Packages");
mb3:SetScript("OnClick", function() RDXDB.UpdateRAUMode(3); end);

--local mb4 = VFLUI.Button:new(ca);
--mb4:SetPoint("LEFT", mb3, "RIGHT");
--mb4:SetWidth(100); mb4:SetHeight(25); mb4:Show();
--mb4:SetText("Transfert");
--mb4:SetScript("OnClick", function() RDXDB.UpdateRAUMode(4); end);

local find = VFLUI.Edit:new(ca);
find:SetHeight(25); find:SetWidth(125);

local magGlass = VFLUI.Button:new(ca);
magGlass:SetNormalTexture("Interface\\Addons\\VFL\\Skin\\mag_glass.tga");
magGlass:SetWidth(25); magGlass:SetHeight(25);

magGlass:SetPoint("TOPRIGHT", ca, "TOPRIGHT");
find:SetPoint("RIGHT", magGlass, "LEFT");

magGlass:SetScript("OnClick", function()
	RDXDB.RAU_Search_Ask(find:GetText());
end);

function RDXDB.UpdateRAUMode(n)
	mb1:UnlockHighlight(); mb2:UnlockHighlight(); mb3:UnlockHighlight(); 
	--mb4:UnlockHighlight();
	if n ~= mode then dlg.message:SetText(""); end
	mode = n;
	find:Hide();
	magGlass:Hide();
	if(n == 1) then
		mb1:LockHighlight(); SetPackstoreMode();
	elseif(n == 2) then
		mb2:LockHighlight(); SetGuildMode();
		find:Show();
		magGlass:Show();
	elseif(n == 3) then
		mb3:LockHighlight(); SetPackageMode();
	--elseif(n == 4) then
	--	mb4:LockHighlight(); SetTransfertMode();
	end
end

--dlg:SetScript("OnHide", function(self) VFLP.Events:Unbind(self); end);
dlg:SetScript("OnShow", function() RDXDB.UpdateRAUMode(mode); end);

dlg.message = VFLUI.CreateFontString(ca);
dlg.message:SetWidth(300); dlg.message:SetHeight(20);
dlg.message:SetPoint("BOTTOMLEFT", ca, "BOTTOMLEFT");
dlg.message:SetFontObject(Fonts.DefaultShadowed);
dlg.message:SetJustifyH("LEFT");

local closebtn = VFLUI.CloseButton:new();
closebtn:SetScript("OnClick", function() RDXDB.HideRAU() end);
dlg:AddButton(closebtn);

-----------------------
-- packstore
-----------------------

function RDX.RequestInvite(toon)
	SendAddonMessage("RDXPS", "Invite", "WHISPER", toon);
end;
-- Process Invite request message via guild comm channel

local function ProcessRequestInvite(arg1)
	if arg1 == "RDXPS" then
		-- if still available place then
		local myunit = RDXDAL.GetMyUnit();
		if UnitIsGroupLeader(myunit.uid) or UnitIsRaidOfficer(myunit.uid) then
			InviteUnit(arg4);
		end;
	end;
end;

-- test if I am a Packstore
WoWEvents:Bind("CHAT_MSG_ADDON", nil, ProcessRequestInvite);


-----------------------------
-- DISPATCHER Search
-----------------------------
local function RAU_Search_Rcvd(ci, resp)
	if (not ci) or (not ci.sender) or (not ci.id) or (type(resp) ~= "table") then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	for _,v in pairs(resp) do
		table.insert(slist, v);
	end
	if not RDXDB.IsRAUShown() then RDXDB.ShowRAU(); end
	RDXDB.UpdateRAUMode(2);
end
function RDXDB.RAU_Search_Ask(str)
	if type(str) ~= "string" then dlg.message:SetText("Please, enter a valid search text. Thanks."); return; end
	VFL.empty(slist);
	local rpcid = RPC_Guild:Invoke("rau_searchPkg", str);
	RPC_Guild:Wait(rpcid, RAU_Search_Rcvd, 10);
	dlg.message:SetText("Searching ...");
	VFLT.ZMSchedule(11, function()
		if VFL.isempty(slist) then
			dlg.message:SetText("No package " .. str .. " found !");
		else
			dlg.message:SetText("Found (" .. #slist ..")");
		end
	end);
end



-----------------------------
-- DISPATCHER See Addons player
-----------------------------
local function RAU_SeeAddons_Rcvd(ci, resp)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (not ci) or (not ci.sender) or (not ci.id) or (type(resp) ~= "table") then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	slist = VFL.copy(resp);
	if not RDXDB.IsRAUShown() then RDXDB.ShowRAU(); end
	RDXDB.UpdateRAUMode(2);
end
function RDXDB.RAU_SeeAddons_Ask(who)
	if type(who) ~= "string" then return; end
	VFL.empty(slist);
	who = string.lower(who);
	local rpcid = RPC_Guild:Invoke("rau_seeAddons", who);
	RPC_Guild:Wait(rpcid, RAU_SeeAddons_Rcvd, 60);
	VFLT.ZMSchedule(11, function()
		if VFL.isempty(slist) then
			dlg.message:SetText("No package found !");
		else
			dlg.message:SetText("Found (" .. #slist ..")");
		end
	end);
end

-----------------------------
-- INIT
-----------------------------
RDXEvents:Bind("INIT_DEFERRED", nil, function()
	if RDXG.ShowRAU then RDXDB.ShowRAU(); end
end);

----------------
-- Helper
----------------

function RDXDB.ShowRAU()
	if RDXPM.Ismanaged("rau") then RDXPM.RestoreLayout(dlg, "rau"); end; 
	RDXG.ShowRAU = true;
	dlg:_Show(RDX.smooth);
end

function RDXDB.HideRAU()
	RDXPM.StoreLayout(dlg, "rau");
	RDXG.ShowRAU = nil;
	dlg:_Hide(RDX.smooth);
end

function RDXDB.ToggleRAU()
	if RDXG.ShowRAU then
		RDXDB.HideRAU();
	else
		RDXDB.ShowRAU()
	end
end

function RDXDB.IsRAUShown()
	return RDXG.ShowRAU;
end


