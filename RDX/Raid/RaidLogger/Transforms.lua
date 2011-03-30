-- Transforms.lua
-- RDX - Project Omniscience
-- (C)2006 Bill Johnson
--
-- Transformation operations on Omniscience data tables.

--------------------------------------------------
-- TOTALS TABLES
--------------------------------------------------
local total_cs = {
	{title = "Group"; width = 200;},
	{title = "Count"; width = 60;},
	{title = "Avg"; width = 60;},
	{title = "Min"; width = 60;},
	{title = "Max"; width = 60;},
	{title = "Total"; width = 60;},
};

Omni.RegisterTableFormat({
	name = "TOTALS";
	colspec = total_cs;
	TitleRow = function(c)
		c:Show();
		c.selTexture:SetVertexColor(0,0,1,0.3); c.selTexture:Show();	
		for i=1,6 do
			c.col[i]:SetText(total_cs[i].title);
		end
	end;
	ApplyData = function(tbl, cell, data, pos)
		local cols = cell.col;
		local group,cnt,avg,min,max,ttl = cols[1],cols[2],cols[3],cols[4],cols[5],cols[6];
		group:SetText(data.group);
		cnt:SetText(data.count);
		avg:SetText(string.format("%0.2f", data.avg));
		if data.min then min:SetText(data.min); end
		if data.max then max:SetText(data.max); end
		ttl:SetText(data.total);
	end;
});

function Omni.TotalsTransform(tbl, cfg)
	if (not tbl) or (not cfg) then return nil; end
	local gby = cfg.groupBy;
	local d = tbl:GetData();

	-- Generate tabulation system
	local itIdx = nil;
	local ri = function()
		local ret;
		itIdx, ret = next(d, itIdx);
		return ret;
	end;
	local fnClassify = function(row)
		if (not row.x) or (row.x == 0) then return nil; end
		local class, sep = "", "";
		if gby[1] then class = class .. RDXMD.GetEventType(row.y); sep = ":"; end
		if gby[2] then class = class .. sep .. (tbl:GetRowSource(row) or ""); sep = ":"; end
		if gby[3] then class = class .. sep .. (tbl:GetRowTarget(row) or ""); sep = ":"; end
		if gby[4] then class = class .. sep .. (row.a or ""); sep = ":"; end
		if (class ~= "") then return "*", class; else return "*"; end
	end;
	local fnGenRep = function(row, class)
		return {group = class, total = 0, count = 0, avg = 0, min = nil, max = nil};
	end;
	local fnAdd = function(repRow, r)
		if (not repRow.max) or (r.x > repRow.max) then repRow.max = r.x; end
		if (not repRow.min) or (r.x < repRow.min) then repRow.min = r.x; end
		repRow.total = repRow.total + r.x;
		repRow.count = repRow.count + 1;
	end;

	-- Tabulate
	local sum = VFL.gsum(ri, fnClassify, fnGenRep, fnAdd);
	for _,v in pairs(sum) do if (v.count > 0) then v.avg = v.total / v.count; end end
	-- Reconstrue
	local out = {};
	for _,v in pairs(sum) do table.insert(out, v); end
	sum = nil;
	table.sort(out, function(r1,r2) return r1.group < r2.group; end);

	local ret = Omni.Table:new("totals " .. tbl.name);
	ret.data = out; ret.format = "TOTALS";
	return ret;
end

------------------------------------------------------------------
-- Temporal extraction transform.
-- Starting from startPoint (either "FIRST" or "LAST"), proceed from that end of the
-- given table to the other, searching for a row matching startFunc. If no row is found, the
-- first row of the table is automatically used.
--
-- Starting at that row and moving in the direction dxn (+1 or -1), extract all rows that match
-- filterFunc. filterFunc must be contiguous (the first time filterFunc returns false, the whole
-- operation is aborted.)
--
-- If the optional filterFunctor is provided, filterFunc is generated based on the 
-- start row by passing it to filterFunctor.
--
-- That section is then cropped into a new dataset which will be the return value of this function.
------------------------------------------------------------------
function Omni.TemporalExtractionTransform(tbl, startPoint, startFunc, dxn, filterFunc, filterFunctor)
	local i, d, tdxn, limit, firstrow, lastrow = 0, tbl.data, 1, 1, 1, 1;
	-- Empty table....
	if (not d) or (table.getn(d) == 0) then return nil; end
	
	if(startPoint == "FIRST") then
		i=1; tdxn = 1; limit = table.getn(d);
	elseif(startPoint == "LAST") then
		i = table.getn(d); tdxn = -1; limit = 1;
	else error("Invalid startPoint"); end
	
	-- Find the first row
	while true do
		if not d[i] then break; end
		if startFunc(tbl, d[i]) then firstrow = i; break; end
		if i == limit then break; end
		i = i + tdxn;
	end
	
	-- Execute filter functor
	if filterFunctor then filterFunc = filterFunctor(tbl, d[firstrow]); end

	-- Renormalize direction
	if dxn == 1 then
		limit = table.getn(d); lastrow = limit; tdxn = nil;
	elseif dxn == -1 then
		limit = 1; lastrow = limit; tdxn = 1;
	else error("Invalid direction"); end
	
	-- Beginning at the first row and moving in dxn, look for the last row
	local rds = {};
	i = firstrow;
	while true do
		if not d[i] then break; end
		if filterFunc(tbl, d[i], i) then
			if dxn == 1 then
				table.insert(rds, VFL.copy(d[i]));
			else
				table.insert(rds, 1, VFL.copy(d[i]));
			end
		else
			break;
		end
		if i == limit then break; end
		i = i + dxn;
	end

	-- Extract the new table
	local ret = Omni.Table:new("extract " .. tbl.name);
	ret:SetMetadataFrom(tbl);
	ret.immutable = nil;
	ret.data = rds;
	return ret;
end

--- Starting from the given row ("FIRST" or "LAST"), find up to n rows that match the
-- given filter and return the timestamps, in seconds.
function Omni.ExtractTemporalMatches(tbl, n, startPoint, filterFunc)
	local d,st,dxn,en,matches = tbl.data, 1, 1, 0, 0;
	local dt = tbl.timeOffset;
	if type(d) ~= "table" then return nil; end
	if(startPoint == "LAST") then dxn = -1; st = #d; en = 1; else dxn = 1; st = 1; en = #d; end
	local ret = {};
	for i=st,en,dxn do
		if filterFunc(tbl, d[i], i) then
			-- Add the time to our results
			table.insert(ret, math.floor( (d[i].t + dt) / 10));
			matches = matches + 1;
			if(matches >= n) then break; end
		end
	end
	return ret;
end

--- Starting from now, extract the past T seconds from the local combat log.
function Omni.History(t)
	t = math.modf(t*10);
	local now = VFLT.GetTimeTenths();
	local targetTime = now - t;
	local session = Omni.GetSessionByName("Local");
	if session then
		local tbl = session:FindTable("WoWRDX:Logs_Me_tl");
		if tbl then
			local ret = Omni.TemporalExtractionTransform(tbl, "LAST", VFL.True, -1, function(tbl, row)
				if row.tm and row.tm >= targetTime then return true; end
			end);
			if ret then ret:Timeshift(-now); end
			return ret;
		end
	end
end

-- Starting from the given server time, extract a window of +/- w seconds.
function Omni.ExtractWindow(t, w)
	t = math.modf(t*10); w = math.modf(w*10);
	local t0, t1, dt = t-w, t+w;
	local session = Omni.GetSessionByName("Local");
	if session then
		local tbl = session:FindTable("WoWRDX:Logs_Me_tl");
		dt = tbl.timeOffset;
		if tbl then
			local ret = Omni.TemporalExtractionTransform(tbl, "LAST", VFL.True, -1, function(tbl, row)
				local rt = row.tm; if not rt then return; end
				rt = rt + dt;
				if(rt < t0) or (rt > t1) then return nil; else return true; end
			end);
			if ret then ret:Timeshift(dt-t); end
			return ret;
		end
	end
end
