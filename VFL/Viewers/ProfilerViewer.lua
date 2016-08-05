-- Window.lua
-- VFL_Profiler
-- (C)2007 Bill Johnson and The VFL Project
--
-- The main interface for the VFL profiler.

local FormatMicro = VFLT.FormatMicro;
--local strformat = string.format;

local profw = VFLUI.Window:new(VFLFULLSCREEN);
VFLUI.Window.SetDefaultFraming(profw, 24);
profw:SetText("VFL Profiler");
profw:SetTitleColor(0,0,.6);
profw:SetWidth(570); profw:SetHeight(380);
profw:SetPoint("CENTER", VFLParent, "CENTER");
profw:SetMovable(true); profw:SetToplevel(nil);
VFLUI.Window.StdMove(profw, profw:GetTitleBar());
profw:Hide();
profw:SetClampedToScreen(true);
local ca = profw:GetClientArea();

----------- Detailed prof toggle
local toggle = VFLUI.Button:new(ca);
toggle:SetPoint("TOPLEFT", ca, "TOPLEFT");
toggle:SetWidth(100); toggle:SetHeight(25); toggle:Show();
if VFLP.IsEnabled() then
	toggle:SetText("Stop Profiling");
	toggle:SetScript("OnClick", function()
		VFLUI.MessageBox("Confirm", "Stop profiling and reload the UI?", nil, "Yes", function()
			SetCVar("scriptProfile", 0); ReloadUI();
		end, "No", VFL.Noop, profw);
	end);
else
	toggle:SetText("Start Profiling");
	toggle:SetScript("OnClick", function()
		VFLUI.MessageBox("Confirm", "Start profiling? |cFFFF0000WARNING: Profiling uses up a lot of UI resources and can cause significant slowdowns and 'jerky' behavior. You must quit the game and relaunch it! Reload UI is not sufficient.", nil, "Yes", function()
			SetCVar("scriptProfile", 1); ReloadUI();
		end, "No", VFL.Noop, profw);
	end);
end

local reset = VFLUI.Button:new(ca);
reset:SetPoint("TOPLEFT", toggle, "TOPRIGHT");
reset:SetWidth(100); reset:SetHeight(25); reset:Show();
reset:SetText("Reset CPU");
reset:SetScript("OnClick", function() VFLP.ResetCPU(); end);

---------------------------------------------------------------
-- DATA LIST
---------------------------------------------------------------

-- The onclick function for omni table cells.
local function CellOnClick(self, arg1)
	--local curtbl = self._srcTbl; if not curtbl then return; end
	--local pos = self._pos;
	if(arg1 == "LeftButton") then
		----- LMB clicks
		if IsShiftKeyDown() then
			-- Crop
			--if not curtbl.mark then return; end
			--local nt = curtbl:Crop(curtbl.mark, pos);
			--curtbl.session:AddTable(nt);
		else
			-- Mark
			--curtbl.mark = pos; Omni._RefreshActiveTable();
		end
		return;
	else
		----- RMB clicks
	end
	local mnu = {
		{ text = VFL.strcolor(.5, .5, .5) .. "(Row )|r" };
	};
	--if (not curtbl:IsImmutable()) then 
		table.insert(mnu, { 
			text = "Kill", 
			func = function() 
				--curtbl:Timeshift(-t); 
				--Omni._RefreshActiveTable();
				self.kill();
				VFL.poptree:Release(); 
			end
		});
	--end
	VFL.poptree:Begin(120, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
	VFL.poptree:Expand(nil, mnu);
end

-- Create a cell in the data table
local function CreateCell(parent)
	local self = VFLUI.AcquireFrame("Button");
	VFLUI.StdSetParent(self, parent); self:SetHeight(10);
	
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	
	-- Create the button highlight texture
	local hltTexture = VFLUI.CreateTexture(self);
	hltTexture:SetAllPoints(self); hltTexture:Show();
	hltTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	hltTexture:SetBlendMode("ADD");
	self:SetHighlightTexture(hltTexture);
	self.hltTexture = hltTexture;

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
	local selTexture = VFLUI.CreateTexture(self);
	selTexture:Hide();
	selTexture:SetDrawLayer("ARTWORK", 1);
	selTexture:SetAllPoints(self);
	selTexture:SetColorTexture(0, 0, 0.6, 0.6);
	self.selTexture = selTexture;

	-- Update the Destroy function
	self.Destroy = VFL.hook(function(s)
		-- Destroy columns
		for _,column in pairs(s.col) do column:Destroy();	end
		s.col = nil;
		-- Destroy textures
		if s.hltTexture then s.hltTexture:Destroy(); s.hltTexture = nil; end
		if s.selTexture then s.selTexture:Destroy(); s.selTexture = nil; end
	end, self.Destroy);
	self.OnDeparent = self.Destroy;

	return self;
end

local data_decor = VFLUI.AcquireFrame("Frame");
data_decor:SetParent(ca);
data_decor:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -25);
data_decor:SetWidth(560); data_decor:SetHeight(310);
data_decor:SetBackdrop(VFLUI.DefaultDialogBorder); data_decor:Show();

local data = VFLUI.List:new(ca, 12, CreateCell);
data:SetPoint("TOPLEFT", data_decor, "TOPLEFT", 5, -5);
data:SetWidth(550); data:SetHeight(300); data:Show(); data:Rebuild();

local cs, col;
local function SetupLayout(colspec, cols)
	for i=1,8 do
		cs, col = colspec[i], cols[i];
		if cs then
			col:Show(); col:SetWidth(colspec[i].width); col:SetJustifyH(cs.jh or "LEFT");
		else
			col:Hide();
		end
	end
end

local function PaintTitle(colspec, cols)
	for i=1,8 do
		cs, col = colspec[i], cols[i];
		if cs then
			col:SetTextColor(1,1,1); col:SetText(cs.title);
		end
	end
end

local function PaintData(colspec, cols, data)
	for i=1,8 do
		cs,col = colspec[i], cols[i];
		if cs then
			col:SetTextColor(cs.r, cs.g, cs.b);
			cs.paint(col, data);
		end
	end
end

local colspec_summ = {
	{ title = "Name"; width = 150; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.title); end; };
	{ title = "mem"; width = 55; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetFormattedText("%0.2fk", data.mem); end; };
	{ title = "mem/sec"; width = 55; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetFormattedText("%0.2fk", data.raMem / VFLP.GetSummaryUpdateInterval()); end; };
	{ title = "CPU%"; width = 50; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetFormattedText("%0.2f%%", data.raCPU * 100 / VFLP.GetSummaryUpdateInterval()); end; };
	--{ title = "PIC%"; width = 50; r=.95; g=.95; b=.45; jh="RIGHT";
	--  paint = function(cell, data) cell:SetFormattedText("%0.2f%%", data.PicCPU * 100 / VFLP.GetSummaryUpdateInterval()); end; };
	--{ title = "NbPIC"; width = 45; r=.95; g=.95; b=.45; jh="RIGHT";
	--  paint = function(cell, data) cell:SetText(data.nbPicCPU); end; };
	{ title = "CPU/frame"; width = 55; r=.75; g=.35; b=.35; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(FormatMicro(data.raCPU / VFLP.GetFramesPerSummaryUpdate())); end; };
	{ title = "CPU time"; width = 55; r=.95;g=.5;b=.5; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(FormatMicro(data.CPU)); end; };  
	{ title = "FPS impact"; width = 65; r=0;g=.7;b=0; jh="RIGHT";
		paint = function(cell, data)
			local timePerFrame = data.raCPU / VFLP.GetFramesPerSummaryUpdate();
			if timePerFrame > 0.0000001 then
				local fr = GetFramerate();
				local nfr = (1/fr) - timePerFrame;
				if nfr > 0.00001 then nfr = 1/nfr else nfr = fr; end
				cell:SetFormattedText("%0.2f", nfr - fr);
			else
				cell:SetText(0);
			end
		end; };
};

local function SetSummaryMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_summ, cell.col);
	end
	local alist = VFLP._GetAddonSummary();
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetColorTexture(0,0,0.6,0.6);
			PaintTitle(colspec_summ, col);
		else
			cell.selTexture:Hide();
			cell:SetScript("OnClick", nil);
			cell.kill = nil;
			PaintData(colspec_summ, col, data);
		end
	end, function() return #alist + 1; end, function(n) if n == 1 then return true; else return alist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	VFLP.Events:Unbind(profw);
	-- Notify to update on repaint
	VFLP.Events:Bind("SUMMARY_PROFILE_UPDATED", data, data.Update, profw);
end

local colspec_obj = {
	{ title = "Name"; width = 110; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.title); end; };
	{ title = "call"; width = 55; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(data.calls); end; };
	{ title = "call/sec"; width = 55; r=.75; g=.75; b=.25; jh="RIGHT";
		paint = function(cell, data) cell:SetFormattedText("%0.2f", data.raCalls / VFLP.GetObjectUpdateInterval()); end; };
	{ title = "call/frame"; width = 52; r=.75; g=.75; b=.25; jh="RIGHT";
		paint = function(cell, data) cell:SetFormattedText("%0.2f", data.raCalls / VFLP.GetFramesPerObjectUpdate()); end; };
	{ title = "sec/call"; width = 50; r=.75; g=.35; b=.35; jh="RIGHT";
	  paint = function(cell, data) 
			cell:SetText( ((data.type == "category") or (data.calls == 0)) and "" or FormatMicro(data.CPU / data.calls)); 
		end; };
	{ title = "sec/frame"; width = 50; r=.75; g=.35; b=.35; jh="RIGHT";
		paint = function(cell, data) cell:SetText(FormatMicro(data.raCPU / VFLP.GetFramesPerObjectUpdate())); end; };
	{ title = "CPU%"; width = 45; r=1;g=1;b=1; jh="RIGHT";
		paint = function(cell, data) cell:SetFormattedText("%0.2f%%", data.raCPU * 100 / VFLP.GetObjectUpdateInterval()); end; };
	{ title = "CPU time"; width = 55; r=.95;g=.5;b=.5; jh="RIGHT";
		paint = function(cell, data) cell:SetText(FormatMicro(data.CPU)); end; };
};

local function SetObjectMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_obj, cell.col);
	end
	local alist = VFLP._flist;
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetColorTexture(0,0,0.6,0.6);
			PaintTitle(colspec_obj, col);
		else
			if data.type == "category" then
				cell.selTexture:Show(); cell.selTexture:SetColorTexture(0,0.6,0.6,1);
			else
				cell.selTexture:Hide();
				
				if data.kill then
					cell:SetScript("OnClick", CellOnClick);
					cell.kill = data.kill;
				else
					cell:SetScript("OnClick", nil);
					cell.kill = nil;
				end			
				
			end
			PaintData(colspec_obj, col, data);
		end
	end, function() return #alist + 1; end, function(n) if n == 1 then return true; else return alist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	VFLP.Events:Unbind(profw);
	-- Notify to update on repaint
	VFLP.Events:Bind("OBJECT_PROFILE_UPDATED", data, data.Update, profw);
end

local colspec_event = {
	{ title = "Name"; width = 110; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.title); end; };
	{ title = "call"; width = 55; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(data.calls); end; };
	{ title = "call/sec"; width = 55; r=.75; g=.75; b=.25; jh="RIGHT";
		paint = function(cell, data) cell:SetFormattedText("%0.2f", data.raCalls / VFLP.GetEventUpdateInterval()); end; };
	{ title = "call/frame"; width = 52; r=.75; g=.75; b=.25; jh="RIGHT";
		paint = function(cell, data) cell:SetFormattedText("%0.2f", data.raCalls / VFLP.GetFramesPerEventUpdate()); end; };
	{ title = "sec/call"; width = 50; r=.75; g=.35; b=.35; jh="RIGHT";
	  paint = function(cell, data) 
			cell:SetText( ((data.type == "category") or (data.calls == 0)) and "" or FormatMicro(data.CPU / data.calls)); 
		end; };
	{ title = "sec/frame"; width = 50; r=.75; g=.35; b=.35; jh="RIGHT";
		paint = function(cell, data) cell:SetText(FormatMicro(data.raCPU / VFLP.GetFramesPerEventUpdate())); end; };
	{ title = "CPU%"; width = 45; r=1;g=1;b=1; jh="RIGHT";
		paint = function(cell, data) cell:SetFormattedText("%0.2f%%", data.raCPU * 100 / VFLP.GetEventUpdateInterval()); end; };
	{ title = "sec"; width = 55; r=.95;g=.5;b=.5; jh="RIGHT";
		paint = function(cell, data) cell:SetText(FormatMicro(data.CPU)); end; };
};

local function SetEventMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_event, cell.col);
	end
	local alist = VFLP._elist;
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetColorTexture(0,0,0.6,0.6);
			PaintTitle(colspec_event, col);
		else
			if data.type == "category" then
				cell.selTexture:Show(); cell.selTexture:SetColorTexture(0,0.6,0.6,1);
			else
				cell.selTexture:Hide();
				cell:SetScript("OnClick", nil);
				cell.kill = nil;
			end
			PaintData(colspec_event, col, data);
		end
	end, function() return #alist + 1; end, function(n) if n == 1 then return true; else return alist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	VFLP.Events:Unbind(profw);
	-- Notify to update on repaint
	VFLP.Events:Bind("OBJECT_PROFILE_UPDATED", data, data.Update, profw);
end

local colspec_pool = {
	{ title = "Name"; width = 150; r=1; g=1; b=1;
	  paint = function(cell, data) cell:SetText(data.title); end; };
	{ title = "create"; width = 55; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(data.create); end; };
	{ title = "available"; width = 52; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(data.available); end; };
	{ title = "use"; width = 55; r=.95; g=.95; b=.45; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(data.use); end; };
	{ title = "jail"; width = 50; r=.75; g=.35; b=.35; jh="RIGHT";
	  paint = function(cell, data) cell:SetText(data.jail); end; };
};

local function SetPoolMode()
	for _,cell in data:_GetGrid():StatelessIterator(1) do
		SetupLayout(colspec_pool, cell.col);
	end
	local plist = VFLP._GetPools();
	data:SetDataSource(function(cell, data, pos, absPos)
		local col = cell.col;
		if(absPos == 1) then
			cell.selTexture:Show(); cell.selTexture:SetColorTexture(0,0,0.6,0.6);
			PaintTitle(colspec_pool, col);
		else
			if data.type == "category" then
				cell.selTexture:Show(); cell.selTexture:SetColorTexture(0,0.6,0.6,1);
			else
				cell.selTexture:Hide();
				cell:SetScript("OnClick", nil);
				cell.kill = nil;
			end
			PaintData(colspec_pool, col, data);
		end
	end, function() return #plist + 1; end, function(n) if n == 1 then return true; else return plist[n-1]; end end);
	-- Unbind any events previousl bound to the window
	VFLP.Events:Unbind(profw);
	-- Notify to update on repaint
	VFLP.Events:Bind("POOL_PROFILE_UPDATED", data, data.Update, profw);
end

--------- Mode buttons
local mode = 1;
local UpdateMode;

local mb1 = VFLUI.Button:new(ca);
mb1:SetPoint("LEFT", reset, "RIGHT", 15, 0);
mb1:SetWidth(60); mb1:SetHeight(25); mb1:Show();
mb1:SetText("Addons");
mb1:SetScript("OnClick", function() UpdateMode(1); end);

--local mb2 = VFLUI.Button:new(ca);
--mb2:SetPoint("LEFT", mb1, "RIGHT");
--mb2:SetWidth(60); mb2:SetHeight(25); mb2:Show();
--mb2:SetText("Events");
--mb2:SetScript("OnClick", function() UpdateMode(2); end);

local mb3 = VFLUI.Button:new(ca);
mb3:SetPoint("LEFT", mb1, "RIGHT");
mb3:SetWidth(60); mb3:SetHeight(25); mb3:Show();
mb3:SetText("Objects");
mb3:SetScript("OnClick", function() UpdateMode(3); end);

local mb4 = VFLUI.Button:new(ca);
mb4:SetPoint("LEFT", mb3, "RIGHT");
mb4:SetWidth(60); mb4:SetHeight(25); mb4:Show();
mb4:SetText("Pools");
mb4:SetScript("OnClick", function() UpdateMode(4); end);

function UpdateMode(n)
	mb1:UnlockHighlight(); 
	--mb2:UnlockHighlight();
	mb3:UnlockHighlight(); mb4:UnlockHighlight();
	mode = n;
	if(n == 1) then
		mb1:LockHighlight(); SetSummaryMode();
	--elseif(n == 2) then
	--	mb2:LockHighlight(); SetEventMode();
	elseif(n == 3) then
		mb3:LockHighlight(); SetObjectMode();
	elseif(n == 4) then
		mb4:LockHighlight(); SetPoolMode();
	end
end

profw:SetScript("OnHide", function(self) VFLP.Events:Unbind(self); end);
profw:SetScript("OnShow", function() UpdateMode(mode); end);

profw.fps = VFLUI.CreateFontString(profw);
profw.fps:SetWidth(60); profw.fps:SetHeight(20);
profw.fps:SetPoint("BOTTOMRIGHT", profw, "BOTTOMRIGHT");
profw.fps:SetFontObject(Fonts.DefaultShadowed);
profw.fps:SetJustifyH("LEFT");

profw.lag = VFLUI.CreateFontString(profw);
profw.lag:SetWidth(100); profw.lag:SetHeight(20);
profw.lag:SetPoint("RIGHT", profw.fps, "LEFT");
profw.lag:SetFontObject(Fonts.DefaultShadowed);
profw.lag:SetJustifyH("LEFT");


local closebtn = VFLUI.CloseButton:new();
closebtn:SetScript("OnClick", function() VFLP.HideProfiler(); end);
profw:AddButton(closebtn);

----------------
-- main function
----------------

function VFLP.ShowProfiler()
	profw:Show();
end

function VFLP.HideProfiler()
	profw:Hide();
end

function VFLP.ToggleProfiler()
	if profw:IsShown() then
		VFLP.HideProfiler();
	else
		VFLP.ShowProfiler();
	end
end

-----------------------------
-- COMMAND
-----------------------------

SLASH_PROFILER1 = "/vflprofiler";
SlashCmdList["PROFILER"] = function() profw:Show(); end

-----------------------------
-- INIT
-----------------------------

--WoWEvents:Bind("ADDON_LOADED", nil, function()
	--if RDXG and RDXG.ShowProfiler then VFLP.ShowProfiler(); end
	--if VFLP.IsEnabled() then
	--	local latency = nil;
	--	VFL.AdaptiveSchedule("VFLPProfilerFPSLAG", 2, function()
	--		profw.fps:SetFormattedText("FPS %d", floor(GetFramerate()));
	--		_,_,latency = GetNetStats();
	--		profw.lag:SetFormattedText("Latency %dms", latency);
	--	end);
	--end
	
--end);
