-- PackagesUpdaterServer.lua
-- OpenRDX

-------------------------------------
-- List PackStores
-------------------------------------
-- "realm" = "name"
-- Add here more Packstores ID

--local ps_horde = {
--	"Rashgarroth" = {
--		"SiggPack",
--	};
--};

--local ps_alliance = {
--	
--};

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

--------------------------------------
-- SERVER
-- Asynchrone send package to CLIENT
-- but only one package is send at a time.
-- I know that RDX is able to have 60 parallel stream
-- but the debit will be very slow
--------------------------------------
-- 1 = {
--	pkgname = "Carkass",
--	users = { sigg, toto, titi},
--}

local rs_group = {};
local rs_guild = {};

local function AddUserRequest(conf, pkgname, username)
	local found = nil;
	local rs;
	if conf == "GROUP" then 
		rs = rs_group;
	else
		rs = rs_guild;
	end
	for i,v in ipairs(rs) do
		if v.pkg == pkgname then
			table.insert(v.users, username);
			found = true;
		end
	end
	if not found then
		table.insert(rs, { pkg = pkgname, users = { username }});
	end
end

local function GetNextRequest(conf)
	local rs;
	if conf == "GROUP" then 
		rs = rs_group;
	else
		rs = rs_guild;
	end
	if not VFL.isempty(rs) then
		return table.remove(rs, 1);
	end
end

local stid_group = nil;
local stid_guild = nil;
local function AsyncSendPck()
	if not RPC_Group:IsSend(stid_group) then
		local tbl = GetNextRequest("GROUP");
		if tbl then
			local data = {};
			if tbl.pkg then data[tbl.pkg] = RDXData[tbl.pkg]; end
			if VFL.tsize(data) > 0 then
				stid_group = RPC_Group:Invoke("rau_sendpkg", data, targets);
			end
		end
	end
	if not RPC_Guild:IsSend(stid_guild) then
		local tbl = GetNextRequest("GUILD");
		if tbl then
			local data = {};
			if tbl.pkg then data[tbl.pkg] = RDXData[tbl.pkg]; end
			if VFL.tsize(data) > 0 then
				stid_guild = RPC_Guild:Invoke("rau_sendpkg", data, targets);
			end
		end
	end
end

VFLT.AdaptiveSchedule(nil, 10, AsyncSendPck);

local function ServerRequestPkg(ci, conf, who, pkg)
	-- Sanity check sender
	if (not ci) or (type(who) ~= "string") then return; end
	--local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	
	local myunit = RDXDAL.GetMyUnit();
	if string.lower(who) == myunit.name then
		AddUserRequest(conf, pkg, id);
	end
	
	--local hours, minutes = GetGameTime();
	--local dataTransfert = { name = pkg; version = vs; duload = "Upload"; who = who; dt = hours .. ":" .. minutes; status = "Done"; };
	--NewTransfert(dataTransfert);
	--local myunit = RDXDAL.GetMyUnit();
	--if string.lower(who) == myunit.name then
	--	local newdata = {};
	--	newdata[pkg] = VFL.copy(RDXDB.GetPackage(pkg));
	--	return newdata;
	--end
end
RPC.GlobalBind("rau_requestPkg", ServerRequestPkg);

----------------------------------------
-- RPC Search
----------------------------------------
local function RAU_Search_RPC(ci, str)
	if (not ci) or (type(str) ~= "string") then return nil, "error request"; end
	--local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	--local id = ci.id; if not id then return; end
	--local myunit = RDXDAL.GetMyUnit();
	--if string.lower(id) ~= myunit.name then
		return VFL.copy(GetFilterListPkgInfo(str));
	--end
end
RPC.GlobalBind("rau_searchPkg", RAU_Search_RPC);

-----------------------------------------
-- RPC View All packages from a player
-----------------------------------------
local function RAU_ViewAll_RPC(ci, who)
	if (not ci) or (type(who) ~= "string") then return nil, "error request"; end
	--local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	--local id = ci.id; if not id then return; end
	local myunit = RDXDAL.GetMyUnit();
	if string.lower(who) == myunit.name then
		return VFL.copy(GetListPkgInfo());
	end
end
RPC.GlobalBind("rau_viewAllPkg", RAU_ViewAll_RPC);
