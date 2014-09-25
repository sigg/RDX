-- ObjectDB.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- The Object Database is the main method of persistent global storage for RDX.
-- The object database is divided into Packages, each of which is a container
-- that can hold any number of Objects.
--
-- Objects are referred to by a path of the form "package:object"
RDXDB = RegisterVFLModule({
	name = "RDXDB";
	title = VFLI.i18n("RDX Database");
	description = "RDX Database";
	version = {1,0,0};
	parent = RDX;
});
RDXDBEvents = DispatchTable:new();

-----------------------------------------------------------
-- CORE ROUTINES
-----------------------------------------------------------
local disks = {};
local function RegisterDisk(name, tbl)
	--if disks[name] then ; end
	disks[name] = tbl;	
end
RDXDB.RegisterDisk = RegisterDisk;

local function GetDisk(name)
	return disks[name]
end
RDXDB.GetDisk = GetDisk;

local function GetDisks()
	return disks;
end
RDXDB.GetDisks = GetDisks;

-- Parse a path (a:b --> a, b)
local function ParsePath(path)
	if not path or type(path) ~= "string" then return nil; end
	local _, _, a, b, c = string.find(path, "^(.*):(.*):(.*)$");
	if c then
		return a,b,c;
	end
end
RDXDB.ParsePath = ParsePath;

-- Generate a path from components (a, b --> a:b)
local function MakePath(dk, pkg, obj)
	if obj then
		return dk .. ":" .. pkg .. ":" .. obj;
	end
end
RDXDB.MakePath = MakePath;

-- Access the data stored at a given path, possibly resolving symlinks
local function AccessPathRaw(dk, pkg, obj)
	if not dk then return nil; end
	if obj then
		local disk = RDXDB.GetDisk(dk);
		local qq = disk[pkg];
		if not qq or (type(qq[obj]) ~= "table") then return nil; end
		return qq[obj];
	end
end
local function AccessPath(dk, pkg, obj)
	if obj then
		local d1 = AccessPathRaw(dk, pkg, obj);
		if not d1 then return nil; end
		if d1.ty ~= "SymLink" then return d1; end
		local sl = AccessPathRaw(ParsePath(RDXDB.GetSymLinkTarget(d1.data)));
		if not sl or sl == "" then sl = dl; end
		return sl;
	end
end
RDXDB._AccessPathRaw = AccessPathRaw;
RDXDB.AccessPath = AccessPath;

-- Resolve a path. If the path points to a symlink, returns the symlink
-- destination, otherwise returns the original path.
local function ResolvePath(path)
	if not path then return nil; end
	local d1 = AccessPathRaw(ParsePath(path));
	if (not d1) or (d1.ty ~= "SymLink") then return path; end
	if d1.data then return RDXDB.GetSymLinkTarget(d1.data); end
end
RDXDB.ResolvePath = ResolvePath;

-- Some words objects are now forbidden to be used (metadata package)
local reservedWords = {};
reservedWords["infoVersion"] = true;
reservedWords["infoAuthor"] = true;
reservedWords["infoAuthorRealm"] = true;
reservedWords["infoAuthorEmail"] = true;
reservedWords["infoAuthorWebSite"] = true;
reservedWords["infoComment"] = true;
reservedWords["infoIsShare"] =  true;
reservedWords["infoIsImmutable"] = true;
reservedWords["infoIsIndelible"] = true;
reservedWords["infoRunAutoexec"] = true;
--reservedWords["infoRunAutoDelete"] = true;
reservedWords["infoRequiredRDXVersion"] = true;
reservedWords["infoIsCommon"] = true;

function RDXDB.IsReserveWord(name)
	return reservedWords[name];
end

-- Some packages are protected
local protectedPkg = {};
protectedPkg["scripts"] = true;
protectedPkg["default"] = true;
protectedPkg["desktops"] = true;

function RDXDB.IsProtectedPkg(name)
	return protectedPkg[name];
end

--local function nu_iter(pkg, file, data, matchPath)
--	if (data.ty == "SymLink") and (data.data == matchPath) then
--		RDXDBEvents:Dispatch("OBJECT_UPDATED", pkg, file);
--	end
--end
--- Notify downstream processes that a file has been updated.
function RDXDB.NotifyUpdate(path)
	--VFL.print("notify update " .. path);
	local dk,pkg,obj = ParsePath(path); if (not pkg) or (not obj) then return; end
	RDXDBEvents:Dispatch("OBJECT_UPDATED", dk, pkg, obj);
	-- All symlinks into this file are considered to be updated as well.
	--RDXDB.Foreach(nu_iter, path);
end

--- Completely clear the RDX database and restart RDX. WARNING: data loss.
function RDXDB.ClearRDXDatabase()
	local disk = RDXDB.GetDisk("RDXData");
	disk = {};
	ReloadUI();
end

-- copy with replace Filesystem
function RDXDB.copyfd(T, srcDk, srcPkg, dstDk, dstPkg)
	if(T == nil) then return nil; end
	local out = {};
	local k,v;
	local a, b, c;
	for k,v in pairs(T) do
		if type(v) == "table" then
			out[k] = RDXDB.copyfd(v, srcDk, srcPkg, dstDk, dstPkg); -- deepcopy subtable
		else
			if type(v) == "string" then
			 	local a, b, c = ParsePath(v);
				if a and a == srcDk and b and b == srcPkg then v = dstDk .. ":" .. dstPkg .. ":" .. c; end
			end
			out[k] = v; -- softcopy primitives
		end
	end
	return out;
end


function RDXDB.copy10(T)
	if(T == nil) then return nil; end
	local out = {};
	local k,v;
	local a, b;
	for k,v in pairs(T) do
		if type(v) == "table" then
			out[k] = RDXDB.copy10(v); -- deepcopy subtable
		else
			if type(v) == "string" and k ~= "feature" and k ~= "infoAuthorWebSite" then
			 	local a, b, c = ParsePath(v);
				if not c then
					local a, b = ParsePath(v);
					if a and b then
						if a == "default" or a == "tabs" or a == "bindings" or a == "scripts" or a == "desktops" or a == "aurafilters" or a == "sets" then
							v = "RDXDiskSystem:" .. a .. ":" .. b;
						else
							v = "RDXData:" .. a .. ":" .. b;
						end
					end
				end
			end
			out[k] = v; -- softcopy primitives
		end
	end
	return out;
end

function RDXDB.Upgrade10()
	RDXData = RDXDB.copy10(RDXData);
	ReloadUI();
end

--/script RDXDB.Upgrade10()

----------------------------------------------------------------------
-- OBJECT TYPES
----------------------------------------------------------------------
-- The object-type database.
local tydb = {};

--- Register a persistent object type that can be stored in the ObjectDB.
-- Object types must provide the following methods:
-- .New(path, metadata) - Populate the metadata and data tables as appropriate for an
--    object of this type.
-- .GenerateBrowserMenu(array, path, metadata) - Generate a menu to be displayed when
--    the item is right clicked in the browser. The array is passed to the standard VFL
--    popup menu.
function RDXDB.RegisterObjectType(tbl)
	local name = tbl.name;
	if not name then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Attempt to register an anonymous object type.")); return; end
	if tydb[name] then VFL.print(VFLI.i18n("|cFFFF0000[RDX]|r Info : Attempt to register duplicate object type ") .. name .. "."); return; end
	tydb[name] = tbl;
end

--- Return an object type previously registered by RegisterObjectType.
function RDXDB.GetObjectType(ty)
	if not ty then return nil; end
	return tydb[ty];
end

function RDXDB._GetObjectTypes()
	return tydb;
end

-- The "Typeless" default type
RDXDB.RegisterObjectType({
	name = "Typeless";
	New = VFL.Noop;
	GenerateBrowserMenu = VFL.Noop;
});

------------------------------------------------
-- SINGLETON INSTANCE SYSTEM
------------------------------------------------
-- The object-instance database.
local instdb, rinstdb = {}, {};

--- Determine if the given path has an instance.
function RDXDB.PathHasInstance(path)
	path = ResolvePath(path);
	if not path then return nil; end
	return instdb[path];
end

--- "Reverse-lookup" an instance of an object, returning the path it was instantiated
-- from, if possible.
function RDXDB.InstanceReverseLookup(instance)
	if not instance then return nil; end
	return rinstdb[instance];
end

-- Remove all traces of the given path from the instance db, forward and reverse.
function RDXDB._RemoveInstance(path, a1, a2, a3)
	path = ResolvePath(path);
	if not path then return; end
	local i = instdb[path]; if not i then return; end
	-- If there's an instance available, and we're about to destroy it, call the type's
	-- Deinstantiate() callback.
	local md = AccessPath(ParsePath(path));
	if md then
		local ty = RDXDB.GetObjectType(md.ty);
		if ty and ty.Deinstantiate then
			ty.Deinstantiate(i, path, md, a1, a2, a3);
		end
	end
	rinstdb[i] = nil; instdb[path] = nil;
	local tdk, tpkg, tobj = ParsePath(path)
	RDXDBEvents:Dispatch("OBJECT_DEINSTANCIATED", tdk, tpkg, tobj);
end

-- Create an instance, given predefined path and type info. This should only be called after
-- it has been confirmed that an instance doesn't already exist.
local function _CreateInstance(opath, obj, a1, a2, a3)
	-- Query the object's type. Check for instantiability.
	local ot = RDXDB.GetObjectType(obj.ty); if (not ot) then return nil; end
	-- Allow the overriding of default instantiation behavior.
	local oi = ot.OverrideInstantiate;
	if oi then return oi(opath, obj);	end
	-- Check for default instantiaton behavior
	oi = ot.Instantiate;
	if (not oi) then return nil; end
	-- Try to instantiate.
	local inst = oi(opath, obj, a1, a2, a3); if not inst then return nil; end
	-- If successful, store in all relevant databases.
	instdb[opath] = inst;
	if not rinstdb[inst] then rinstdb[inst] = opath; end
	local tdk, tpkg, tobj = ParsePath(opath)
	RDXDBEvents:Dispatch("OBJECT_INSTANCIATED", tdk, tpkg, tobj);
	return inst;
end


--------------------------------------------------
-- PACKAGE METADATA
--------------------------------------------------
-- Set metadata package
function RDXDB.SetPackageMetadata(dk, pkg, field, val)
	if val then
		if not RDXDB.GetPackage(dk, pkg) then return nil; end
		if (type(val) == "table") or (type(val) == "function") then return nil; end
		local disk = RDXDB.GetDisk(dk);
		if not disk[pkg] then disk[pkg] = {}; end
		disk[pkg][field] = val;
		RDXDBEvents:Dispatch("PACKAGE_METADATA_UPDATE", dk, pkg);
		return true;
	end
end

function RDXDB.SetAllPackageMetadata(dk, pkg, pkgdata)
	if not RDXDB.GetPackage(dk, pkg) then return nil; end
	if (type(pkgdata) ~= "table") then return nil; end
	local disk = RDXDB.GetDisk(dk);
	local qq = disk[pkg];
	if not qq then return nil; end
	VFL.copyInto(qq, pkgdata);
	RDXDBEvents:Dispatch("PACKAGE_METADATA_UPDATE", dk, pkg);
	return true;
end

-- Get metadata package
function RDXDB.GetPackageMetadata(dk, pkg, field)
	if field then
		if not pkg then return nil; end
		local disk = RDXDB.GetDisk(dk);
		local qq = disk[pkg];
		if not qq or (type(qq[field]) == "table") then return nil; end
		return qq[field];
	end
end

-- Get all metadata package
function RDXDB.GetAllPackageMetadata(dk, pkg)
	if not pkg then return nil; end
	local disk = RDXDB.GetDisk(dk);
	local qq = disk[pkg];
	if not qq then return nil; end
	local ret = {};
	for k, v in pairs(qq) do
		if type(v) ~= "table" then
			ret[k] = v;
		end
	end
	return ret;
end

--------------------------------------------------
-- LOADING AND INITIALIZATION
--------------------------------------------------
local function InitObjectDB()
	RDX:Debug(1, "InitObjectDB()");
	
	-- langage
	local lc = GetLocale();
	if lc == "ruRU" or lc == "koKR" or lc == "zhCN" or lc == "zhTW"  then 
		function RDXDB.IsValidFileName(x)
			if (type(x) ~= "string") or (x == "") or (x == "ty") then return nil; end
			return true;
		end
	else
		--- Returns TRUE iff the name passed is valid for storage in the RDX object database,
		-- NIL otherwise.
		-- A valid file name is pure alphanumeric with no whitespace.
		function RDXDB.IsValidFileName(x)
			if (type(x) ~= "string") or (x == "") or (x == "ty") then return nil; end
			if string.find(x, "^[%w_]+$") then return true; else return nil; end
		end
	end

	--- Get a package's contents if it exists; return NIL if it doesn't
	function RDXDB.GetPackage(dk, pkg)
		if not dk then return nil; end
		if pkg then
			local disk = RDXDB.GetDisk(dk);
			return disk[pkg];
		end
	end

	--- Iterate a function over all files
	function RDXDB.Foreach(f, ...)
		for name,disk in pairs (RDXDB.GetDisks()) do
			for pkg,pd in pairs(disk) do
				for file,fd in pairs(pd) do
					if type(fd) == "table" then
						f(name, pkg, file, fd, ...);
					end
				end
			end
		end
	end

	--- Get a package's contents, creating it if it doesn't exist.
	function RDXDB.GetOrCreatePackage(dk, pkg, infoversion, infoname, inforealm, infoemail, infowebsite, infocomment)
		local disk = RDXDB.GetDisk(dk);
		local d = disk[pkg];
		if not d then
			if RDXDB.CreatePackage(dk, pkg, infoversion, infoname, inforealm, infoemail, infowebsite, infocomment) then
				return disk[pkg];
			else
				return nil;
			end
		end
		return d;
	end

	--- Create a package. Returns (NIL, error code) on failure.
	function RDXDB.CreatePackage(dk, pkg, infoversion, infoname, inforealm, infoemail, infowebsite, infocomment)
		if not RDXDB.IsValidFileName(pkg) then return nil, VFLI.i18n("Invalid filename. Filenames must be alphanumeric."); end
		local disk = RDXDB.GetDisk(dk);
		if disk[pkg] then return nil, VFLI.i18n("Package already exists."); end
		local d = {};
		disk[pkg] = d;
		if not infoversion then infoversion = "1.0.0"; end
		if not infoname then infoname = UnitName("player"); end
		if not inforealm then inforealm = GetRealmName(); end
		if not infocomment then infocomment = ""; end
		RDXDB.SetPackageMetadata(dk, pkg, "infoVersion", infoversion);
		RDXDB.SetPackageMetadata(dk, pkg, "infoAuthor", infoname);
		RDXDB.SetPackageMetadata(dk, pkg, "infoAuthorRealm", inforealm);
		RDXDB.SetPackageMetadata(dk, pkg, "infoAuthorEmail", infoemail);
		RDXDB.SetPackageMetadata(dk, pkg, "infoAuthorWebSite", infowebsite);
		RDXDB.SetPackageMetadata(dk, pkg, "infoComment", infocomment);
		RDXDBEvents:Dispatch("PACKAGE_CREATED", dk, pkg, d);
		return true;
	end
	
	function RDXDB.IsCommonPackage(dk, pkg)
		local disk = RDXDB.GetDisk(dk);
		local d = disk[pkg];
		if not d then return nil; end
		if RDXDB.GetPackageMetadata(dk, pkg, "infoIsCommon") then return true; else return nil; end
	end

	--- Delete a package. Fails, returning NIL, if the package is not empty.
	function RDXDB.DeletePackage(dk, pkg, force)
		local disk = RDXDB.GetDisk(dk);
		local d = disk[pkg];
		if not d then return true; end
		if RDXDB.GetPackageMetadata(dk, pkg, "infoIsImmutable") or RDXDB.GetPackageMetadata(dk, pkg, "infoIsIndelible") then
			return nil, VFLI.i18n("Cannot delete indelible package.");
		end
		if (not force) and (VFL.tsize(d) > 0) then return nil, VFLI.i18n("Cannot delete non-empty package."); end
		--if RDXDB.GetPackageMetadata(pkg, "infoRunAutoDelete") then
			local adel = d["autodel"];
			if adel and adel.ty == "Script" then
				RDXDB.OpenObject(dk, pkg .. ":autodel", "Open", "local pkg = '" .. pkg .. "';");
			end
		--end
		disk[pkg] = nil;
		RDXDBEvents:Dispatch("PACKAGE_DELETED", dk, pkg);
		return true;
	end
	
	function RDXDB.CopyPackage(srcDk, srcPkg, dstPkg)
		if not srcPkg or not dstPkg then return nil; end
		local disk = RDXDB.GetDisk(srcDk);
		local d = disk[srcPkg];
		if not d then return nil, VFLI.i18n("Source package does not exist."); end
		local e = disk[dstPkg];
		if e then return nil, VFLI.i18n("Destination package exists."); end
		local e = {};
		for file,fd in pairs(d) do
			if type(fd) == "table" then
				local newfd = RDXDB.copyfd(fd, srcDk, srcPkg, srcDk, dstPkg)
				e[file] = newfd;
			else
				e[file] = fd;
			end
		end
		disk[dstPkg] = e;
		RDXDBEvents:Dispatch("PACKAGE_CREATED", dk, dstPkg, e);
		return true;
	end
	
	function RDXDB.MigratePackage(srcDk, srcPkg, dstDk, dstPkg)
		if not srcDk or not srcPkg or not dstDk then return nil; end
		local sd = RDXDB.GetDisk(srcDk);
		local dd = RDXDB.GetDisk(dstDk);
		if not sd then return nil, VFLI.i18n("source disk does not exist."); end
		if not dd then return nil, VFLI.i18n("destination disk does not exist."); end
		local d = sd[srcPkg];
		if not d then return nil, VFLI.i18n("Source package does not exist."); end
		local e = dd[dstPkg];
		if e then return nil, VFLI.i18n("Destination package exists."); end
		local e = {};
		for file,fd in pairs(d) do
			if type(fd) == "table" then
				local newfd = RDXDB.copyfd(fd, srcDk, srcPkg, dstDk, dstPkg)
				e[file] = newfd;
			else
				e[file] = fd;
			end
		end
		dd[dstPkg] = e;
		RDXDBEvents:Dispatch("PACKAGE_CREATED", dstDk, dstPkg, e);
		return true;
	end
	
	function RDXDB.CopyIntoPackage(dk, srcPkg, dstPkg)
		local disk = RDXDB.GetDisk(dk);
		local d = disk[srcPkg];
		if not d then return nil, VFLI.i18n("Source package does not exist."); end
		local e = disk[dstPkg];
		if not e then return nil, VFLI.i18n("Destination package does not exists."); end
		for file,fd in pairs(d) do
			if type(fd) == "table" then
				local newfd = RDXDB.copyfd(fd, dk, srcPkg, dk, dstPkg)
				e[file] = newfd;
			else
				e[file] = fd;
			end
		end
		return true;
	end
	
	function RDXDB.CopyIntoAllPackages(dk, srcPkg)
		local disk = RDXDB.GetDisk(dk);
		local d = disk[srcPkg];
		if not d then return nil, VFLI.i18n("Source package does not exist."); end
		for k,v in pairs(disk) do
			if v["autodesk"] and k ~= "default" then
				for file,fd in pairs(d) do
					if type(fd) == "table" then
						local newfd = RDXDB.copyfd(fd, dk, srcPkg, dk, k)
						v[file] = newfd;
					else
						v[file] = fd;
					end
				end
			end
		end
		return true;
	end

	--- Empty a package.
	function RDXDB._EmptyPackage(dk, pkg)
		local disk = RDXDB.GetDisk(dk);
		local d = disk[pkg];
		if type(d) ~= "table" then return; end
		VFL.empty(d);
		RDXDBEvents:Dispatch("PACKAGE_MASS_CHANGE", dk, pkg);
	end
	
	-- Return number of objects in this package
	function RDXDB.GetNumberObjects(dk, pkg)
		if not dk or not pkg then return 0; end
		local disk = RDXDB.GetDisk(dk);
		local d, cp = disk[pkg], 0;
		if type(d) ~= "table" then return 0; end
		for file,fd in pairs(d) do
			if type(fd) == "table" then
				cp = cp + 1;
			end
		end
		return cp;
	end

	--- Check the object at the given path; verify that it exists and matches the given type
	function RDXDB.CheckObject(path, ty, version)
		local obj = AccessPath(ParsePath(path)); if not obj then return nil; end
		--if version and obj.version ~= version then return nil; end
		return (obj.ty == ty), obj;
	end

	--- Get the object metadata at the given path, or NIL if it doesn't exist
	function RDXDB.GetObjectData(path)
		local dk, pkg, file = ParsePath(path);
		local fd = AccessPath(dk, pkg, file); if not fd then return nil; end
		return fd, pkg, file, fd.ty, RDXDB.GetObjectType(fd.ty); 
	end

	--- Find an available temporary file name in the given package.
	function RDXDB.tmpnam(pkg)
		local p = RDXDB.GetPackage(pkg); if not p then return nil; end
		local i, str = 0, "unnamed";
		while p[str] do
			i=i+1; str = "unnamed" .. i;
		end
		return str;
	end

	--- Create a new object at a node where no object is.
	function RDXDB.CreateObject(dk, pkg, file, ty, forcename)
		if (not dk) or (not pkg) or (not file) then return nil, VFLI.i18n("Invalid path."); end
		local t = RDXDB.GetObjectType(ty);
		if (not t) or (not t.New) then return nil, VFLI.i18n("Invalid object type."); end
		if (not RDXDB.IsValidFileName(file)) and (not forcename) then return nil, VFLI.i18n("Invalid filename. Filenames must be alphanumeric."); end
		if (RDXDB.IsReserveWord(file)) then return nil, VFLI.i18n("Invalid filename. Filename protected."); end
		local p = RDXDB.GetPackage(dk, pkg);
		if not p then return nil, VFLI.i18n("Package does not exist."); end
		if RDXDB.GetPackageMetadata(dk, pkg, "infoIsImmutable") then
			return nil, VFLI.i18n("Cannot create object in immutable package.");
		end
		if p[file] then return nil, VFLI.i18n("File already exists in package."); end
		-- Create the object
		local fmd = { ty = ty, version = 0, data = {} };
		p[file] = fmd;
		t.New(RDXDB.MakePath(dk, pkg, file), fmd);
		VFLT.NextFrame(math.random(100000000), function()
			RDXDBEvents:Dispatch("OBJECT_CREATED", dk, pkg, file, fmd);
		end);
		return true;
	end

	--- Create an object, overriding most restrictions and bypassing initialization schemes.
	function RDXDB._DirectCreateObject(dk, pkg, file)
		if (not dk) or (not pkg) or (not file) then return nil; end
		local p = RDXDB.GetPackage(dk, pkg);
		if not p then return nil; end
		local fmd = { ty = "Typeless", version = 0, data = {} };
		p[file] = fmd;
		VFLT.NextFrame(math.random(100000000), function()
			RDXDBEvents:Dispatch("OBJECT_CREATED", dk, pkg, file, fmd);
		end);
		return fmd;
	end

	--- Delete an object.
	function RDXDB.DeleteObject(path)
		local dk, pkg, file = ParsePath(path);
		if (not dk) or (not pkg) or (not file) then return nil, VFLI.i18n("Invalid path."); end
		local p = RDXDB.GetPackage(dk, pkg);
		if not p then return nil, VFLI.i18n("Package does not exist."); end
		if RDXDB.GetPackageMetadata(dk, pkg, "infoIsImmutable") then
			return nil, VFLI.i18n("Cannot delete object in immutable package."); 
		end
		local qq = p[file];
		if not qq then return nil, VFLI.i18n("File does not exist."); end
		if qq.virtual then return nil, VFLI.i18n("Virtual files cannot be deleted."); end
		-- Perform the deletion
		RDXDB._RemoveInstance(path, qq); -- Remove any instances that are out there...
		p[file] = nil;
		RDXDBEvents:Dispatch("OBJECT_DELETED", dk, pkg, file, qq);
		return true;
	end

	--- Rename an object.
	function RDXDB.RenameObject(path, newFileName)
		local dk, pkg, file = ParsePath(path);
		if (not dk) or (not pkg) or (not file) then return nil, VFLI.i18n("Invalid path."); end
		if not RDXDB.IsValidFileName(newFileName) then return nil, VFLI.i18n("New filename is invalid."); end
		if RDXDB.IsReserveWord(newFileName) then return nil, VFLI.i18n("New filename is invalid. (protected)"); end
		local p = RDXDB.GetPackage(dk, pkg);
		if not p then return nil, VFLI.i18n("Package does not exist."); end
		if RDXDB.GetPackageMetadata(dk, pkg, "infoIsImmutable") then
			return nil, VFLI.i18n("Cannot rename object in immutable package."); 
		end
		if p[newFileName] then
			return nil, VFLI.i18n("That file already exists.");
		end
		local qq = p[file];
		if not qq then return nil, VFLI.i18n("File does not exist."); end
		if qq.virtual then return nil, VFLI.i18n("Virtual files cannot be renamed."); end
		-- Do the rename
		RDXDB._RemoveInstance(path);
		p[file] = nil; p[newFileName] = qq;
		RDXDBEvents:Dispatch("OBJECT_MOVED", dk, pkg, file, dk, pkg, newFileName, qq);
		return true;
	end

	--- Move an object
	function RDXDB.MoveObject(path, newDk, newPkg)
		local dk, pkg, file = ParsePath(path);
		if (not dk) or (not pkg) or (not file) then return nil, VFLI.i18n("Invalid path."); end
		local pSrc = RDXDB.GetPackage(dk, pkg); if not pSrc then return nil, VFLI.i18n("Source package does not exist."); end
		local pDst = RDXDB.GetPackage(newDk, newPkg); if not pDst then return nil, VFLI.i18n("Destination package does not exist."); end
		if RDXDB.GetPackageMetadata(dk, pkg, "infoIsImmutable") or RDXDB.GetPackageMetadata(newDk, newPkg, "infoIsImmutable") then
			return nil, VFLI.i18n("Cannot modify an immutable package.");
		end
		if pDst[file] then return nil, VFLI.i18n("Destination file already exists."); end
		local qq = pSrc[file]; if not qq then return nil, VFLI.i18n("Source file does not exist."); end
		if qq.virtual then return nil, VFLI.i18n("Virtual files cannot be moved."); end
		-- Do the move
		RDXDB._RemoveInstance(path);
		pSrc[file] = nil; pDst[file] = qq;
		RDXDBEvents:Dispatch("OBJECT_MOVED", dk, pkg, file, newDk, newPkg, file, qq);
		return true;
	end

	--- Copy an object.
	function RDXDB.CopyObject(path, newDk, newPkg)
		local dk, pkg, file = ParsePath(path);
		if not dk or not pkg or not file then return nil, VFLI.i18n("Invalid path."); end
		return RDXDB.Copy(path, MakePath(newDk, newPkg, file), "RENAME");
	end

	--- Copies a preexisting object.
	function RDXDB.Copy(srcPath, dstPath, eh, rn)
		if not eh then eh = "OVERWRITE"; end
		---- Source validation
		local sdk, spkg, sfile = ParsePath(srcPath);
		if (not sdk) or (not spkg) or (not sfile) then return nil, VFLI.i18n("Invalid source path."); end
		local spd = RDXDB.GetPackage(sdk, spkg); if not spd then return nil, VFLI.i18n("Source package does not exist."); end
		local sfd = spd[sfile]; if not sfd then return nil, VFLI.i18n("Source file does not exist."); end
		---- Destination validation
		local ddk, dpkg, dfile = ParsePath(dstPath);
		if (not ddk) or (not dpkg) or (not dfile) then return nil, VFLI.i18n("Invalid destination path."); end
		if RDXDB.GetPackageMetadata(ddk, dpkg, "infoIsImmutable") then return nil, VFLI.i18n("Destination package is immutable."); end
		local dpd = RDXDB.GetOrCreatePackage(ddk, dpkg); if not dpd then return nil, VFLI.i18n("Could not get destination package."); end
		local dfd = dpd[dfile];
		-- If the destination exists, typecheck vs the source
		if dfd then
			if eh == "FAIL" then 
				return nil, VFLI.i18n("Destination already exists."); 
			elseif eh == "RENAME" then
				local n, ofile = 1, dfile;
				while dpd[dfile] do dfile = ofile .. "_copy" .. n; n = n + 1; end
			elseif eh == "OVERWRITE" then
				if (dfd.ty ~= sfd.ty) or (dfd.version ~= sfd.version) then return nil, VFLI.i18n("Type mismatch."); end
			end
		end
		if not rn then
			dpd[dfile] = VFL.copy(sfd);
		else
			dpd[dfile] = RDXDB.copyfd(sfd, sdk, spkg, ddk, dpkg); -- rename pkg
		end
		VFLT.NextFrame(math.random(100000000), function()
			RDXDBEvents:Dispatch("OBJECT_CREATED", ddk, dpkg, dfile, dpd[dfile]);
		end);
		return true;
	end

	--- "Touch" an object, returning a direct reference to its contents if we have the ability to
	-- update it. Automatically creates it as a typeless object if it doesn't exist.
	function RDXDB.TouchObject(path)
		local dk, pkg, file = ParsePath(path);
		if (not dk) or (not pkg) or (not file) then return nil, VFLI.i18n("Invalid path."); end
		local pkgData = RDXDB.GetOrCreatePackage(dk, pkg); if not pkgData then return nil, VFLI.i18n("Invalid package."); end
		-- If the file already exists, we're golden.
		local od = pkgData[file];
		if od then
			return od;
		else
			if RDXDB.GetPackageMetadata(dk, pkg, "infoIsImmutable") then
				return nil, VFLI.i18n("Cannot create object in immutable package.");
			end
			-- Create the object
			local fmd = { ty = "Typeless", version = 0 };
			pkgData[file] = fmd;
			VFLT.NextFrame(math.random(100000000), function()
				RDXDBEvents:Dispatch("OBJECT_CREATED", dk, pkg, file, fmd);
			end);
			return fmd;
		end
	end

	--- Get an instace of the object at the given path. If the second argument is
	-- non-NIL, the object will NOT be created if it doesn't already exist.
	function RDXDB.GetObjectInstance(path, noCreate, a1, a2, a3)
		-- Symlinks to instances should resolve first.
		path = ResolvePath(path);
		-- If there's already an instance of this object, return it
		if instdb[path] then return instdb[path]; end
		-- If we're not creating, just abort
		if noCreate then return nil; end
		-- Let's find the object...
		local obj = AccessPathRaw(ParsePath(path));
		if (not obj) or (not obj.ty) then return nil; end
		-- OK, create an instance
		return _CreateInstance(path, obj, a1, a2, a3);		
	end

	--- Run an object's Open method, if possible. If "op" is specified, runs
	-- that operation instead of the open method, with the given arguments.
	function RDXDB.OpenObject(path, op, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
		local data,_,_,_,ty = RDXDB.GetObjectData(path);
		if (not data) or (not ty) then return nil, VFLI.i18n("Invalid or missing object."); end
		if not op then op = "Open"; end
		if not ty[op] then return nil, VFLI.i18n("Type does not have the ") .. op .. VFLI.i18n(" method"); end
		ty[op](path, data, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
		return true;
	end
	
	function RDXDB._GetObject(path, op, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
		local data,_,_,_,ty = RDXDB.GetObjectData(path);
		if (not data) or (not ty) then return nil, VFLI.i18n("Invalid or missing object."); end
		if not ty[op] then return nil, VFLI.i18n("Type does not have the ") .. op .. VFLI.i18n(" method"); end
		return ty[op](path, data, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
	end

	-- Two-phase init
	RDXDB:Debug(1, "**************** INIT_DATABASE_LOADED ****************");
	RDXEvents:Dispatch("INIT_DATABASE_LOADED");
	RDXEvents:DeleteKey("INIT_DATABASE_LOADED");
	RDXDB:Debug(1, "**************** INIT_POST_DATABASE_LOADED ****************");
	RDXEvents:Dispatch("INIT_POST_DATABASE_LOADED");
	RDXEvents:DeleteKey("INIT_POST_DATABASE_LOADED");
end

RDXEvents:Bind("INIT_VARIABLES_LOADED", nil, InitObjectDB);

------------------------------------------------------------------
-- OBJECT VERSION MANAGEMENT
-- When WoW starts, check all objects with out-of-date descriptors, 
-- and run their VersionMismatch()
-- methods to correct the issue.
------------------------------------------------------------------
local function CheckVers(dk, pkg, file, ty, md)
	if (ty.version ~= md.version) and ty.VersionMismatch then
		if ty.VersionMismatch(md) then 
			RDX.printI(VFLI.i18n("|cFF00FFFFObject Updater|r: Updating object ") .. RDXDB.MakePath(dk,pkg,file));
			return true;
		end
	end
end

RDXEvents:Bind("INIT_DATABASE_LOADED", nil, function()
	-- Iterate over the entire FS...
	RDXDB.Foreach(function(dk, pkg, file, md)
		local ty = RDXDB.GetObjectType(md.ty);
		if not ty then return; end
		if CheckVers(dk, pkg, file, ty, md) then RDXDB.objupdate = true; end
	end);
end);

----------------------------------------------------------------------
-- Reload after update
----------------------------------------------------------------------

RDXDB.objupdate = nil;

RDXEvents:Bind("INIT_POST_DATABASE_LOADED", nil, function()
	if RDXDB.objupdate then
		RDX.printI(VFLI.i18n("Object updated, checking for UI reload."));
		VFLT.ZMSchedule(2, function()
			VFLUI.MessageBox(VFLI.i18n("Reload UI"), VFLI.i18n("Some old RDX objects were updated. In order for these updates to take effect, your UI must be reloaded. Click Yes to reload, No to abort."), nil, VFLI.i18n("No"), VFL.Noop, VFLI.i18n("Yes"), ReloadUI);
		end);
		RDXDB.objupdate = nil;
	end
end);
