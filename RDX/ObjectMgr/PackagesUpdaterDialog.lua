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



----------------------------------------------------------------------------
-- GUI
----------------------------------------------------------------------------

local dlg = nil; -- Main dialog
local fdlg = nil; -- Generic subdialog variable

local dlg = VFLUI.Window:new();
VFLUI.Window.SetDefaultFraming(dlg, 24);
dlg:SetText("RDX Packages Updater (Beta)");
dlg:SetTitleColor(0,0,.6);
dlg:SetWidth(660); dlg:SetHeight(380);
dlg:SetPoint("CENTER", VFLParent, "CENTER");
dlg:SetMovable(true); dlg:SetToplevel(nil);
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
				text = "Download", 
				OnClick = function() 
					-- who, packagename, version
					RDXDB.RAU_ReqPck_Ask(self.col[7]:GetText(), self.col[1]:GetText(), self.col[2]:GetText());
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
				text = "Info Package", 
				OnClick = function() 
					-- who, packagename, version
					RDXDB.PackageMetadataDialog(self.col[1]:GetText(), self);
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
	for pkgName, pkgData in pairs(RDXData) do
		if not RDXDB.IsProtectedPkg(pkgName) then
			local pkg = GetPkgInfo(pkgName, flagall);
			if pkg then
				newlist[i] = pkg; i = i + 1;
			end
		end
	end
	return newlist;
end

local function GetFilterListPkgInfo(str)
	VFL.empty(newlist);
	local i = 1;
	for pkgName, pkgData in pairs(RDXData) do
		if not RDXDB.IsProtectedPkg(pkgName) and string.find(pkgName, str) then
			local pkg = GetPkgInfo(pkgName);
			if pkg then
				newlist[i] = pkg; i = i + 1;
			end
		end
	end
	return newlist;
end


--------------------------------------------------------------------------------
-- Search Mode, view list of packages
--------------------------------------------------------------------------------

local slist = {};

local colspec_srch = {
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
	{ title = "Player"; width = 100; r=.95; g=.95; b=.45; jh="LEFT";
	  paint = function(cell, data) cell:SetText(data.player); end;};
};

local function SetSearchMode()
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
RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, UpdatePList);
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
--------------------------------------------------------------------------------

local mode = 1;

function RDXDB.GetRAUMode()
	return mode;
end

local mb1 = VFLUI.Button:new(ca);
--mb1:SetPoint("LEFT", toggle, "RIGHT", 15, 0);
mb1:SetPoint("TOPLEFT", ca, "TOPLEFT");
mb1:SetWidth(100); mb1:SetHeight(25); mb1:Show();
mb1:SetText("Settings");
mb1:SetScript("OnClick", function() RDXDB.UpdateRAUMode(1); end);

local mb2 = VFLUI.Button:new(ca);
mb2:SetPoint("LEFT", mb1, "RIGHT");
mb2:SetWidth(100); mb2:SetHeight(25); mb2:Show();
mb2:SetText("Search");
mb2:SetScript("OnClick", function() RDXDB.UpdateRAUMode(2); end);

local mb3 = VFLUI.Button:new(ca);
mb3:SetPoint("LEFT", mb2, "RIGHT");
mb3:SetWidth(100); mb3:SetHeight(25); mb3:Show();
mb3:SetText("MyPackages");
mb3:SetScript("OnClick", function() RDXDB.UpdateRAUMode(3); end);

local mb4 = VFLUI.Button:new(ca);
mb4:SetPoint("LEFT", mb3, "RIGHT");
mb4:SetWidth(100); mb4:SetHeight(25); mb4:Show();
mb4:SetText("Transfert");
mb4:SetScript("OnClick", function() RDXDB.UpdateRAUMode(4); end);

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
	mb1:UnlockHighlight(); mb2:UnlockHighlight(); mb3:UnlockHighlight(); mb4:UnlockHighlight();
	if n ~= mode then dlg.message:SetText(""); end
	mode = n;
	find:Hide();
	magGlass:Hide();
	if(n == 1) then
		--mb1:LockHighlight(); SetSummaryMode();
	elseif(n == 2) then
		mb2:LockHighlight(); SetSearchMode();
		find:Show();
		magGlass:Show();
	elseif(n == 3) then
		mb3:LockHighlight(); SetPackageMode();
	elseif(n == 4) then
		mb4:LockHighlight(); SetTransfertMode();
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


-----------------------------
-- RPC Request Package
-----------------------------
local function RAU_ReqPck_RPC(ci, who, pkg, vs, id)
	-- Sanity check sender
	if (not ci) or (type(who) ~= "string") then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	local hours, minutes = GetGameTime();
	local dataTransfert = { name = pkg; version = vs; duload = "Upload"; who = who; dt = hours .. ":" .. minutes; status = "Done"; };
	NewTransfert(dataTransfert);
	local myunit = RDXDAL.GetMyUnit();
	if string.lower(who) == myunit.name then
		local newdata = {};
		newdata[pkg] = VFL.copy(RDXDB.GetPackage(pkg));
		return newdata;
	end
end
-----------------------------
-- DISPATCHER Request Package
-----------------------------
local function RAU_ReqPck_Rcvd(ci, resp)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (not ci) or (not ci.sender) or (not ci.id) or (type(resp) ~= "table") then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	UpdateTransfertStatus(ci.id, "Done");
	RDX.TryIntegrate(VFLDIALOG, resp, "test", nil);
	if not RDXDB.IsRAUShown() then RDXDB.ShowRAU(); end
	RDXDB.UpdateRAUMode(2);
end
function RDXDB.RAU_ReqPck_Ask(who, pkg, vs)
	if type(who) ~= "string" or type(pkg) ~= "string" then return; end
	who = string.lower(who);
	local rpcid = RPC_Group:Invoke("rau_requestPkg", who, pkg, vs, id);
	local hours, minutes = GetGameTime();
	local dataTransfert = { name = pkg; version = vs; duload = "Download"; who = who; dt = hours .. ":" .. minutes; status = "Start"; };
	NewTransfert(dataTransfert, rpcid);
	RPC_Group:Wait(rpcid, RAU_ReqPck_Rcvd, 300);
	VFLT.ZMSchedule(301, function()
		if GetTransfertStatus(rpcid) == "Start" then
			UpdateTransfertStatus(rpcid, "Timeout");
			--RDXDB.UpdateRAUMode(4);
		end
	end);
end

-----------------------------
-- RPC Search
-----------------------------
local function RAU_Search_RPC(ci, str)
	if (not ci) or (type(str) ~= "string") then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	return VFL.copy(GetFilterListPkgInfo(str));
end
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
	local rpcid = RPC_Group:Invoke("rau_searchPkg", str);
	RPC_Group:Wait(rpcid, RAU_Search_Rcvd, 10);
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
-- RPC See Addons player
-----------------------------
local function RAU_SeeAddons_RPC(ci, who)
	if (not ci) or (type(who) ~= "string") then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	local myunit = RDXDAL.GetMyUnit();
	if string.lower(who) == myunit.name then
		return VFL.copy(GetListPkgInfo());
	end
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
	local rpcid = RPC_Group:Invoke("rau_seeAddons", who);
	RPC_Group:Wait(rpcid, RAU_SeeAddons_Rcvd, 10);
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
	RPC_Group:Bind("rau_seeAddons", RAU_SeeAddons_RPC);
	RPC_Group:Bind("rau_requestPkg", RAU_ReqPck_RPC);
	RPC_Group:Bind("rau_searchPkg", RAU_Search_RPC);
end);

----------------
-- Helper
----------------

function RDXDB.ShowRAU()
	if RDXPM.Ismanaged("rau") then RDXPM.RestoreLayout(dlg, "rau"); end; 
	RDXG.ShowRAU = true;
	dlg:Show();
	--dlg:Show(.2, true);
end

function RDXDB.HideRAU()
	RDXPM.StoreLayout(dlg, "rau");
	RDXG.ShowRAU = nil;
	dlg:Hide();
	--dlg:Hide(.2, true);
end

function RDXDB.ToggleRAU()
	if RDXG.ShowRAU then
		RDXDB.HideRAU();
		--RDX.printI(VFLI.i18n("Hide RAU"));
	else
		RDXDB.ShowRAU()
		--RDX.printI(VFLI.i18n("Show RAU"));
	end
end

function RDXDB.IsRAUShown()
	return RDXG.ShowRAU;
end


