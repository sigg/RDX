-- LogisticsWindow.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- General-purpose windows for displaying results from logistics queries.

------------------ Logistics window support routines
local function LW_Sort(self, fld)
	local tbl, nl = self._dataList, self._nameMap;
	self.sortField = fld;
	table.sort(tbl, function(x1, x2)
		local nlx1, nlx2 = nl[x1], nl[x2];
		if nlx1 and nlx2 then
			return nlx1[fld] < nlx2[fld];
		elseif nlx2 then
			return true;
		elseif nlx1 then
			return nil;
		end
	end);
	self:RepaintAll();
end

local function LW_SortGT(self, fld)
	local tbl, nl = self._dataList, self._nameMap;
	self.sortField = fld;
	table.sort(tbl, function(x1, x2)
		local nlx1, nlx2 = nl[x1], nl[x2];
		if nlx1 and nlx2 then
			return nlx1[fld] > nlx2[fld];
		elseif nlx2 then
			return true;
		elseif nlx1 then
			return nil;
		end
	end);
	self:RepaintAll();
end

function LW_SetupNameMap(self, augmentor)
	if not augmentor then augmentor = VFL.Noop; end

	-- Name data map
	local nameMap, totalCount = {}, 0;
	for _,unit in RDXDAL.Group() do
		totalCount = totalCount + 1;
		local t = { 
			name = unit:GetProperName(); 
			class = unit:GetClassID(); 
		};
		nameMap[unit.name] = t;
		augmentor(self, t);
	end
	self._nameMap = nameMap; self.totalCount = totalCount;

	-- Paint entry map
	local paintMap = self._dataList;
	VFL.empty(paintMap);
	for name,_ in pairs(nameMap) do	table.insert(paintMap, name);	end
end

--- Create a new logistics window with the given ID and title.
-- Return a handler to the window.
function RDX.CreateLogisticsWindow(id, title, periodicRepaint, totalWidth, t1width)
	totalWidth = totalWidth or 150;
	t1width = t1width or 70;
	local state = RDX.GenericWindowState:new();
	local win = RDX.Window:new(RDXParent);
	
	-- Add window frame
	state:AddFeature({feature = "Frame: Lightweight", title = title, titleColor = {r=0,g=0,b=0,a=1}, bkdColor = {r=0,g=.15,b=.15,a=1}, showtitlebar = true, bkd = VFL.copy(VFLUI.DarkDialogBackdrop)});
	
	-- ApplyData invokes a user provided function
	local applyData = VFL.Noop;
	state:AddSlot("_ApplyData");
	state:_SetSlotFunction("_ApplyData", function(frame, icv, member)
		applyData(win, frame, icv, member);
	end);
	function win:SetApplyData(fn) applyData = fn; end
	
	-- Add generic subframe
	state:AddFeature({feature = "Generic Subframe", w = totalWidth, h = 14, tdx = t1width});
	
	-- The data source will pull directly from a client-maintained data list.
	local dataList = {};
	state:AddSlot("DataSource");
	state:AddSlot("DataSourceIterator");
	state:_SetSlotFunction("DataSourceIterator", function() return ipairs(dataList); end);
	state:AddSlot("DataSourceSize");
	state:_SetSlotFunction("DataSourceSize", function() return table.getn(dataList); end);
	
	-- Layout
	state:AddFeature({feature = "Grid Layout", cols = 2, axis = 1, dxn = 1});
	if periodicRepaint then
		state:AddFeature({feature = "Event: Periodic Repaint", interval=0.2, slot = "RepaintAll"});
	end

	-- Create the window.
	win:LoadState(state);
	--win.RepaintAll = state:GetSlotFunction("RepaintAll");
	state = nil;
	win._dataList = dataList;
	win:GetClientArea():SetPoint("LEFT", VFLParent, "LEFT", 50, 0);
	VFLUI.Window.StdMoveICW(win, win:GetTitleBar());

	local closebtn = VFLUI.CloseButton:new();
	closebtn:SetScript("OnClick", function() win:Destroy(); end);
	win:AddButton(closebtn);
	
	win:Show();

	-- Prep methods
	win.Sort = LW_Sort; win.SortGT = LW_SortGT; win.SetupNameMap = LW_SetupNameMap;

	-- Destructor code
	win.Destroy = VFL.hook(function(s)
		dataList = nil;
		s._rpcid = nil; s._WindowMenu = nil;
		s.sortField = nil; 
		s._nameMap = nil; s.totalCount = nil; s._dataList = nil; 
		s.Sort = nil; s.SortRev = nil; s.SetupNameMap = nil;
		s.SetApplyData = nil; s.RepaintAll = nil;
	end, win.Destroy);

	return win;
end

--- Core logistics window moved into RDX main codebase; point to that code.
Logistics.NewWindow = RDX.CreateLogisticsWindow;
Logistics.StdSort = function(w,f) w:Sort(f); end;
Logistics.StdSortGT = function(w,f) w:SortGT(f); end;

------------------------------------------------------------------------------
-- A general purpose scrolling list used by several of the logistics modules.
------------------------------------------------------------------------------
-- Individual results window
local function rwframe()
	local self = VFLUI.AcquireFrame("Button");
	self:SetWidth(250); self:SetHeight(12);

	-- Create the text
	local text1 = VFLUI.CreateFontString(self);
	text1:SetPoint("LEFT", self, "LEFT"); text1:SetWidth(250); text1:SetHeight(12);
	text1:Show();
	text1:SetFontObject(Fonts.Default);
	text1:SetTextColor(1,1,1,1);
	text1:SetJustifyH("LEFT");
	self.text1 = text1;

	self.Destroy = VFL.hook(function(self)
		VFLUI.ReleaseRegion(self.text1); self.text1 = nil;
	end, self.Destroy);
	self.OnDeparent = self.Destroy;

	return self;
end

function Logistics.MakeDetailWindow(fnAD)
	local rwin = VFLUI.Window:new();
	rwin:SetFraming(VFLUI.Framing.Default, 22);
	rwin:SetTitleColor(0,0,0.6);
	rwin:SetPoint("CENTER", VFLParent, "CENTER");
	rwin:Accomodate(250, 240);
	VFLUI.Window.StdMove(rwin, rwin:GetTitleBar());
	rwin:Show();
	local ca = rwin:GetClientArea();

	local data = {};
	rwin.data = data;

	local list = VFLUI.List:new(ca, 12, rwframe);
	list:SetPoint("TOPLEFT", ca, "TOPLEFT");
	list:SetWidth(250); list:SetHeight(240);
	list:Rebuild(); list:Show();
	list:SetDataSource(fnAD, VFL.ArrayLiterator(data));
	function rwin:Update() list:Update();	end

	local closebtn = VFLUI.CloseButton:new();
	closebtn:SetScript("OnClick", function() rwin:Destroy(); end);
	rwin:AddButton(closebtn);

	rwin.Destroy = VFL.hook(function(s)
		s.Update = nil;
		list:Destroy(); list = nil;
		s.data = nil; data = nil;
		rwin = nil;
	end, rwin.Destroy);

	return rwin;
end
