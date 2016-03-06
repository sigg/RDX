-- TableViewer.lua
-- RDX - Project Omniscience
-- (C)2006 Bill Johnson
--

local strlen, strrep, strformat = string.len, string.rep, string.format;
local max = math.max;
local zeropad = VFL.zeropad;

local _green, _red = {r=0,g=0.75,b=0}, {r=0.75,g=0,b=0};

local colspec = {
	{ title = "Time", width = 100},
	{ title = "Source", width = 200},
	{ title = "Target", width = 200},
	{ title = "HP", width = 150},
	{ title = "Amt", width = 100},
	{ title = "Ability", width = 250},
	{ title = "Misc", width = 100},
};

-- The onclick function for omni table cells.
local function CellOnClick(self, arg1)
	local curtbl = self._srcTbl; if not curtbl then return; end
	local pos, t = self._pos, self._time;
	if(arg1 == "LeftButton") then
		----- LMB clicks
		if IsShiftKeyDown() then
			-- Crop
			if not curtbl.mark then return; end
			local nt = curtbl:Crop(curtbl.mark, pos);
			curtbl.session:AddTable(nt);
		else
			-- Mark
			curtbl.mark = pos; Omni._RefreshActiveTable();
		end
		return;
	else
		----- RMB clicks
	end
	local mnu = {
		{ text = VFL.strcolor(.5, .5, .5) .. "(Row " .. pos .. ")|r" };
	};
	if (not curtbl:IsImmutable()) then 
		table.insert(mnu, { 
			text = "Timeshift", 
			func = function() 
				curtbl:Timeshift(-t); 
				Omni._RefreshActiveTable(); 
				VFL.poptree:Release(); 
			end
		});
	end
	VFL.poptree:Begin(120, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
	VFL.poptree:Expand(nil, mnu);
end

-- Create a cell.
function Omni._CreateCell(ctr, ty)
	if not ty then ty = "Button"; end
	local self = VFLUI.AcquireFrame(ty);
	VFLUI.StdSetParent(self, ctr); self:SetHeight(10);

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
	for i=1,7 do
		-- Create the text object.
		local colText = VFLUI.CreateFontString(self);
		colText:SetDrawLayer("OVERLAY");
		VFLUI.SetFont(colText, Fonts.Default, 10);
		colText:SetShadowOffset(1,-1); colText:SetShadowColor(0,0,0,1);
		colText:SetTextColor(1,1,1,1); colText:SetJustifyH("LEFT");
		colText:SetPoint("TOPLEFT", af, ap); 
		colText:SetHeight(10);
		colText:Show();
		-- Save it
		self.col[i] = colText;
		-- Update iterative variables
		af = colText; ap = "TOPRIGHT";
	end

	-- Update the Destroy function
	self.Destroy = VFL.hook(function(s)
		-- Destroy columns
		for _,column in pairs(s.col) do column._type = nil; column:Destroy(); column = nil; end
		s.col = nil;
		-- Clear temp data
		s._srcTbl = nil; s._pos = nil; s._time = nil;
		-- Destroy textures
		if s.hltTexture then VFLUI.ReleaseRegion(s.hltTexture); s.hltTexture = nil; end
		if s.selTexture then VFLUI.ReleaseRegion(s.selTexture); s.selTexture = nil; end
	end, self.Destroy);

	self.OnDeparent = self.Destroy;

	return self;
end

-- Apply a column spec to a row.
function Omni._ApplyColSpec(cs, row)
	local colInfo, col;
	for i=1,table.getn(row.col) do
		colInfo = cs[i]; col = row.col[i];
		if colInfo then
			col:Show(); col:SetWidth(colInfo.width);
			VFLUI.SetFont(col, colInfo.font);
			col:SetJustifyH(colInfo.justifyH or "LEFT");
			col:SetShadowOffset(1,-1); col:SetShadowColor(0,0,0,1);
			col._type = colInfo.title;
		else
			col:Hide();
		end
	end
end

-- Apply a column spec to a table control.
function Omni._ApplyColSpecToList(l, cs)
	local grid = l:_GetGrid(); if not grid then return; end
	for _,cell in grid:StatelessIterator(1) do
		Omni._ApplyColSpec(cs, cell);
	end
end


-------------------------------
-- Table format registration.
-- Fields:
--   - name - the canonical format name
--   - colspec - A field describing each column's width.
--   - TitleRow - render the title row into a cell.
--   - ApplyData - render a data row into a cell.
-------------------------------
local fmts = {};
function Omni.RegisterTableFormat(fmt)
	if (not fmt) or (not fmt.name) then error ("Usage: Omni.RegisterTableFormat(format_descriptor)"); end
	if fmts[fmt.name] then error("Duplicate format name."); end
	fmts[fmt.name] = fmt;
	return true;
end

function Omni.GetTableFormat(fn)
	if not fn then return nil; end
	return fmts[fn];
end

--- Overall function to apply appropriate settings for an Omni table.
function Omni.SetupTable(list, tbl, xad)
	xad = xad or VFL.Noop;
	-- First let's get the table format
	local fmt = Omni.GetTableFormat(tbl.format);
	if not fmt then error("Invalid table format"); end
	-- Now let's apply the colspec to the list
	Omni._ApplyColSpecToList(list, fmt.colspec);
	local _titleRow, _row, dta = fmt.TitleRow, fmt.ApplyData, tbl.data;
	list:SetDataSource(function(cell, data, pos, absPos)
		if(absPos == 1) then
			_titleRow(cell);
		else
			_row(tbl, cell, data, pos);
			xad(cell, data, pos, absPos);
		end
	end, function()
		return #dta + 1;
	end, function(n)
		if n == 1 then return true; else return dta[n-1]; end
	end);
end

------------------------------------------------
-- The default Omniscience table format.
------------------------------------------------
-- Get the ability string from a table row.
function Omni.GetAbilityString(data, rowType)
	local str = VFL.strtcolor(RDXMD.GetEventTypeColor(rowType));
	if (rowType == 1) or (rowType == 2) or (rowType == 3) then -- Damage in/out
		if data.a then
			str = VFL.strtcolor(RDXMD.GetDamageTypeColor(data.d)) .. tostring(data.a) .. "|r";	
		end
	elseif(rowType == 7) or (rowType == 8) or (rowType == 9) then
		str = str .. tostring(data.a) .. "|r";
	elseif(rowType == 21) then
		str = str .. "----- Death -----|r";
	else
		str = str .. RDXMD.GetEventType(rowType);
		if data.a then
			str = str .. ":|r " .. data.a;
		end
	end
	return str;
end

-- Determine if a row is a crit.
function Omni.IsCritRow(row) return row.xic; end

--- Get the miscellaneous string from a log row.
function Omni.GetMiscString(row)
	if not row then return ""; end
	local str = "";
	if row.xia and row.xia > 0 then str = str .. "A[|cFFFFFF00" .. row.xia .. "|r] "; end
	if row.xir and row.xir > 0 then str = str .. "R[|cFFFFFF00" .. row.xir .. "|r] "; end
	if row.xib and row.xib > 0 then str = str .. "B[|cFFFFFF00" .. row.xib .. "|r] "; end
	if row.xioh and row.xioh > 0 then str = str .. "OH[|cFF00FF00" .. row.xioh .. "|r] "; end
	if row.xiok and row.xiok > 0 then str = str .. "OK[|cFFF00000" .. row.xiok .. "|r] "; end
	return str;
end

-- Data application function; map a table row onto the display.
function Omni._ApplyData(tbl, cell, data, pos)
	local cols = cell.col;
	local tm, src, targ, hp, amt, abil, misc = cols[1],cols[2],cols[3],cols[4],cols[5],cols[6],cols[7];
	local rowType = data.y;
	local str = nil;
	-------------- TIME
	if (tbl.displayTime == "RELATIVE") then
		str = string.format("%0.1f", (data.tm / 10));
		if(data.tm < 0) then str = "T" .. str; else str = "T+" .. str; end
		tm:SetText("|cFFAAAAAA" .. str .. "|r");
	elseif (tbl.displayTime == "ABSOLUTE") then
		local stWhole, stFrac = VFL.modf( (tbl.timeOffset + data.tm) / 10);
		local str = date("%H:%M:%S", stWhole);
		str = str .. string.format(".%1d", stFrac*10);
		tm:SetText("|cFFAAAAAA" .. str .. "|r");
	end
	-------------- SOURCE/TARGET
	--src:SetText(tbl:GetRowSource(data) or "");
	--targ:SetText(tbl:GetRowTarget(data) or "");
	src:SetText(data.s or "");
	targ:SetText(data.t or "");
	
	-------------- AMOUNT
	if data.x then
		str = VFL.strtcolor(RDXMD.GetEventTypeColor(rowType)) .. tostring(data.x);
		if Omni.IsCritRow(data) then
			amt:SetFont(Fonts.Default.face, 12);
			str = str .. "!";
		else
			amt:SetFont(Fonts.Default.face, 10);
		end
		amt:SetText(str .. "|r");
	else
		amt:SetText("");
	end

	-------------- ABILITY
	abil:SetText(Omni.GetAbilityString(data, rowType));

	----------------- HP
	if data.uh then
		local pct = VFL.clamp(data.uh / data.uhm, 0, 1);
		tempcolor:blend(_red, _green, pct);
		hp:SetText(zeropad(data.uh, 5, "|cFF333333", "|r" .. tempcolor:GetFormatString()) .. "|r/" .. zeropad(data.uhm, 5, "|cFF333333", "|r"));
	else
		hp:SetText("");
	end
	
	----------------- EXTENSION TYPE + MISC dot, hot, range
	str = "";
	if data.xic then str = str .. "|cFF00FFFF[|rcrit|cFF00FFFF]|r "; end
	if data.xidot then str = str .. "|cFF00FFFF[|rdot|cFF00FFFF]|r "; end
	if data.xihot then str = str .. "|cFF00FFFF[|rhot|cFF00FFFF]|r "; end
	if data.r then str = str .. "|cFF00FFFF[|rdist|cFF00FFFF]|r "; end
	str = str .. Omni.GetMiscString(data);
	misc:SetText(str);
end



function Omni._TitleRow(c)
	c:Show();
	c.selTexture:SetVertexColor(0,0,1,0.3);
	c.selTexture:Show();	
	for i=1,#colspec do
		c.col[i]:SetText(colspec[i].title);
	end
end

Omni.RegisterTableFormat({
	name = "LOCAL Combat Logs";
	colspec = colspec;
	TitleRow = Omni._TitleRow;
	ApplyData = Omni._ApplyData;
});

Omni.RegisterTableFormat({
	name = "REMOTE Combat Logs";
	colspec = colspec;
	TitleRow = Omni._TitleRow;
	ApplyData = Omni._ApplyData;
});


Omni.RegisterTableFormat({
	name = "LOCAL Damage Meter";
	colspec = colspec;
	TitleRow = Omni._TitleRow;
	ApplyData = Omni._ApplyData;
});