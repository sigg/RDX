-- Inventory.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Inventory checking.
-- item:6265:0:0:0:0:0:0:7194380


local GetCoreItemLink;

if WoW20 then
	function GetCoreItemLink(link)
		local _,_,core = string.find(link, "(.*item:%d+:%d+:%d+:%d+)");
		local _,_,name = string.find(link, "%[(.+)%]");
		if (not core) or (not name) then return; end
		link = core .. "|h[" .. name .. "]|r";
		return name, link;
	end
else
	function GetCoreItemLink(link)
		local _, _, pre, n1, n2, n3, n4, name = string.find(link, "^(.*)item:(%d+):(%d+):(%d+):(%d+).*%[(.+)%]");
		if not pre then return; end
		link = pre .. "item:" .. n1 .. ":0:" .. n3 .. ":0|h[" .. name .. "]|r";
		return name, link;
	end
end

-- Count items in inventory matching the given regex. Individual matches
-- are stored in the passed table and the total matches found is returned.
function Logistics.ItemsMatching(regex, tbl)
	local ret = 0;
	-- For each bag, for each item in that bag...
	for i=0,4 do for j=1,MAX_CONTAINER_ITEMS do
		local link = GetContainerItemLink(i,j);
		if link then
			name, link = GetCoreItemLink(link);
			if name and string.find(string.lower(name), regex) then
				if not tbl[link] then tbl[link] = 0; end
				local _,count = GetContainerItemInfo(i,j);
				tbl[link] = tbl[link] + count; ret = ret + count;
			end
		end -- if link
	end end -- foreach bag, item
	return ret;
end

local function ExtractItemLink(str)
	local _,_,link = string.find(str, "(item:%d+:%d+:%d+:%d+)");
	return link;
end

-----------------------------------------------
-- RESPONDER
-----------------------------------------------
local function SanityCheckQuery(qry)
	local wc, nwc = 0, 0;
	for i=1,string.len(qry) do
		if string.sub(qry, i, i) == "*" then wc = wc + 1; else nwc = nwc + 1; end
	end
	if nwc < 3 then return nil, "Must be at least 3 non-wildcard characters."; end
	if wc > 3 then return nil, "No more than 3 wildcards."; end
	return true;
end

local ic_resp = {};
local function DoIC(data)
	if type(data) ~= "string" then return; end
	if not SanityCheckQuery(data) then return; end
	local regex = VFL.WildcardToRegex(data);
	regex = string.lower(regex);
	VFL.empty(ic_resp);
	local count = Logistics.ItemsMatching(regex, ic_resp);
	if count > 0 then return ic_resp; end
end

local function ICIncRPC(ci, data)
	-- Sanity check sender
	if (not ci) then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	-- Only leaders can send polls.
	if not sunit:IsLeader() then return; end
	return DoIC(data);
end

RPC_Group:Bind("logistics_inv", ICIncRPC);

-----------------------------------------------
-- DETAIL WINDOW
-----------------------------------------------
local rwin = nil;

local function RWAD(cell, d, pos)
	cell:Show();
	local c = ExtractItemLink(d);
	if c then
		cell:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_NONE");
			GameTooltip:SetPoint("TOPLEFT", self, "CENTER");
			GameTooltip:SetHyperlink(c);
			GameTooltip:Show();
		end);
		cell:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	end
	cell.text1:SetText(d);
end

local function MakeRWin()
	if rwin then return; end
	rwin = Logistics.MakeDetailWindow(RWAD);
	rwin.Destroy = VFL.hook(function()
		rwin = nil;
	end, rwin.Destroy);
end

local function ShowResults(name, rsts)
	if (not name) or (not rsts) then return; end
	MakeRWin();
	rwin:SetText("Inventory Detail: " .. name);
	local q = rwin.data;
	VFL.empty(q); local i = 0;
	for link,qty in pairs(rsts) do
		i=i+1;
		q[i] = "|cFF888888" .. string.format("%02d", VFL.clamp(qty, 0, 99)) .. "|r " .. link;
	end
	if not table.maxn then table.setn(q,i); end -- XXX
	rwin:Update();
end

-----------------------------------------------
-- DISPATCHER
-----------------------------------------------
local ichecks = {};

local function IC_ResponseRcvd(ci, resp)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (not ci) or (not ci.sender) or (not ci.id) or (type(resp) ~= "table") then return; end
	local win = ichecks[ci.id]; if not win then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	local nm = win._nameMap; if (not nm) or (not nm[ci.sender]) then return; end

	-- Update the response.
	nm[ci.sender].detail = resp;
	local ct = 0;
	for k,v in pairs(resp) do ct = ct + v; end
	nm[ci.sender].count = ct;

	-- Repaint the window
	win:RepaintAll();
end

local function InvWin_ApplyData(win, frame, icv, data)
	local nm = win._nameMap; if not nm then return; end
	local row = nm[data]; if not row then return; end
	frame.bar:SetValue(0);
	frame.text1:SetText(VFL.strtcolor(RDXMD.GetClassColor(row.class)) .. row.name .. "|r");
	if row.count > 0 then
		frame.text2:SetText(row.count);
		local rsts = row.detail;
		frame:GetHotspot():SetScript("OnClick", function() ShowResults(data, rsts); end);
	else
		frame.text2:SetText("|cFF4444440|r");
		frame:GetHotspot():SetScript("OnClick", nil);
	end
end

local function InvCheck_Start(query)
	local pw = Logistics.NewWindow(nil, "Inventory: " .. query, nil, 100, 60);
	pw:SetApplyData(InvWin_ApplyData);

	-- Name data map
	local nameMap, totalCount = {}, 0;
	for _,unit in RDXDAL.Group() do
		if unit:IsValid() then
			totalCount = totalCount + 1;
			nameMap[unit.name] = { 
				name = unit:GetProperName(); 
				class = unit:GetClassID();
				count = 0; detail = nil;
			};
		end
	end
	pw._nameMap = nameMap;
	pw.totalCount = totalCount;

	-- Paint entry map
	local paintMap = pw._dataList;
	VFL.empty(paintMap);
	for name,_ in pairs(nameMap) do	table.insert(paintMap, name);	end

	-- Window popup menu
	function pw:_WindowMenu(mnu)
		table.insert(mnu, {
			text = "Sort by Name", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "name"); end
		});
		table.insert(mnu, {
			text = "Sort by Class", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "class"); end
		});
		table.insert(mnu, {
			text = "Sort by Count", func = function() VFL.poptree:Release(); Logistics.StdSortGT(self, "count"); end
		});
	end

	-- Destructor. On destroy, clear us from the checks table
	pw.Destroy = VFL.hook(function(s)
		s._WindowMenu = nil;
		s._nameMap = nil; s.totalCount = nil;
		ichecks[s._rpcid] = nil;
	end, pw.Destroy);

	-- Send out the RPC and bind us to the responses.
	local rpcid = RPC_Group:Invoke("logistics_inv", query);
	pw._rpcid = rpcid;
	ichecks[rpcid] = pw;
	RPC_Group:Wait(rpcid, IC_ResponseRcvd, 10);

	Logistics.StdSort(pw, "name");
end

------------------------------------------
-- GLUE
------------------------------------------
function Logistics.DoInvCheck(qry)
	local x,err = SanityCheckQuery(qry);
	if not x then VFL.TripError("RDX", err); return; end
	qry = string.lower(qry);
	if RDXU then
		if not RDXU.icMRU then RDXU.icMRU = {}; end
		if not VFL.vfind(RDXU.icMRU, qry) then
			table.insert(RDXU.icMRU, 1, qry);
		end
		VFL.asize(RDXU.icMRU, 10, nil);
	end
	InvCheck_Start(qry);
end

function Logistics.InvCheckFrontend()
	VFLUI.MessageBox("Inventory Check", "Enter string to search for. * is a wildcard.", "", "Cancel", VFL.Noop, "OK", function(qry) Logistics.DoInvCheck(qry); end);
end



