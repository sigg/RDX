-- RaidWindow.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- An RDX-based emulation of the Blizzard raid frame that allows arbitrary
-- drag and drop handling on the subobjects.

--- The master drag context for raid players
RDXUI.dc_RaidMembers = VFLUI.DragContext:new();

local groupOrder = {1,3,5,7,2,4,6,8};

local dlg = nil;

local function OpenRaidWindow(parent)
	if dlg then -- window's already open.
		return;
	end

	-- Create window
	dlg = VFLUI.Window:new(parent); 
	VFLUI.Window.SetDefaultFraming(dlg, 24);
	dlg:SetMovable(true);
	dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(100*2 + 10); dlg:SetHeight(12*24 + 50 + 10);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetText(VFLI.i18n("Roster"));
	
	--dlg:Show();
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("roster") then RDXPM.RestoreLayout(dlg, "roster"); end

	local ca = dlg:GetClientArea();

	-- Create sort buttons
	local curSort, sortTbl = 1, {};
	local Update, btnGroup, btnClass, btnAlpha;

	local function sortClick(btn)
		btnGroup:UnlockHighlight(); btnClass:UnlockHighlight(); btnAlpha:UnlockHighlight();
		local id = btn:GetID();
		if(id == 1) then btnGroup:LockHighlight() elseif(id == 2) then btnClass:LockHighlight() elseif(id == 3) then btnAlpha:LockHighlight() end
		curSort = id; Update();
	end

	btnGroup = VFLUI.Button:new(dlg);
	btnGroup:SetPoint("TOPLEFT", ca, "TOPLEFT"); btnGroup:SetHeight(25); btnGroup:SetWidth(67);
	btnGroup:SetText(VFLI.i18n("Group")); btnGroup:SetID(1); btnGroup:Show(); btnGroup:LockHighlight();
	btnGroup:SetScript("OnClick", sortClick);
	btnClass = VFLUI.Button:new(dlg);
	btnClass:SetPoint("LEFT", btnGroup, "RIGHT", 0, 0); btnClass:SetHeight(25); btnClass:SetWidth(66);
	btnClass:SetText(VFLI.i18n("Class")); btnClass:SetID(2); btnClass:Show();
	btnClass:SetScript("OnClick", sortClick);
	btnAlpha = VFLUI.Button:new(dlg);
	btnAlpha:SetPoint("LEFT", btnClass, "RIGHT", 0, 0); btnAlpha:SetHeight(25); btnAlpha:SetWidth(67);
	btnAlpha:SetText(VFLI.i18n("Alpha")); btnAlpha:SetID(3); btnAlpha:Show();
	btnAlpha:SetScript("OnClick", sortClick);

	local grid = VFLUI.Grid:new(dlg);
	grid:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -25); grid:Show();
	grid:Size(2, 24, VFLUI.Selectable.AcquireCell);
	grid:SetCellDimensions(100, 12);

	-- Drag/drop support
	local function DragScript(cell)
		if cell.unitName then
			RDXUI.dc_RaidMembers:Drag(cell, VFLUI.CreateGenericDragProxy(cell, cell.unitTitle, cell.unitName));
		elseif cell.class then
			RDXUI.dc_RaidMembers:Drag(cell, VFLUI.CreateGenericDragProxy(cell, cell.text:GetText() or cell.class, "*class:" .. cell.class));
		elseif cell.group then
			RDXUI.dc_RaidMembers:Drag(cell, VFLUI.CreateGenericDragProxy(cell, cell.text:GetText() or cell.group, "*group:" .. cell.group));
		end
	end
	-- Drop to switch groups. (This is DISABLED until blizzard figures out a way to secure their code
	-- without F!#%^ing up legitimate usage)
	local DropScript = nil;
	--[[
	local function DropScript(cell, dropped)
		if not cell.group then return; end
		if not RDXDAL.InRaid() then return; end
		local unit = RDXDAL.GetUnitByNameIfInGroup(dropped.data); if not unit then return; end
		if cell.unitName then
			local unit2 = RDXDAL.GetUnitByNameIfInGroup(cell.unitName);
			if not unit2 then return; end
			SwapRaidSubgroup(unit.nid, unit2.nid);
		else
			SetRaidSubgroup(unit.nid, cell.group);
		end
	end
	]]--

	-- Updater subroutines
	local function ClearCell(cell)
		cell:Unselect(); cell.text:SetText("");
		cell:SetScript("OnMouseDown", nil); cell.OnDrop = nil; 
		cell.group = nil; cell.class = nil;
		cell.unitName = nil; cell.unitTitle = nil;
		RDXUI.dc_RaidMembers:UnregisterDragTarget(cell);
	end
	local function SetCell(cell, unit)
		cell:Show(); cell:Unselect();
		local unitTitle = VFL.strtcolor(unit:GetClassColor()) .. unit:GetProperName() .. "|r";
		local llv = unit:GetLeaderLevel();
		if llv == 2 then
			unitTitle = unitTitle .. " (L)";
		elseif llv == 1 then
			unitTitle = unitTitle .. " (A)";
		end
		cell.text:SetText(unitTitle);
		cell.OnDrop = nil; cell.group = nil; cell.unitName = unit.name; cell.unitTitle = unitTitle;
		cell:SetScript("OnMouseDown", DragScript);
		RDXUI.dc_RaidMembers:UnregisterDragTarget(cell);
	end
	local function SetGroup(cell, group)
		cell.group = group; 
		--cell.OnDrop = DropScript; RDXUI.dc_RaidMembers:RegisterDragTarget(cell);
		cell.OnDragEnter = cell.LockHighlight; cell.OnDragLeave = cell.UnlockHighlight;
	end
	local function HideRest(i_func, i_state, i_ctl)
		i_ctl, cell = i_func(i_state, i_ctl);
		while cell do
			cell:Hide();
			i_ctl, cell = i_func(i_state, i_ctl);
		end
		return i_ctl;
	end

	function Update()
		local i_func, i_state, i_ctl = grid:StatelessIterator(5);
		local cell = nil;
		local i,j;
		if curSort == 2 or curSort == 3 then
			VFL.empty(sortTbl);
			for _,unit in RDXDAL.Group() do if UnitIsPlayer(unit.uid) then
				table.insert(sortTbl, unit);
			end end
			if curSort == 2 then
				table.sort(sortTbl, function(u1,u2) return (u1:GetClassID() < u2:GetClassID()); end);
			elseif curSort == 3 then
				table.sort(sortTbl, function(u1,u2) return u1.name < u2.name; end);
			end
			local curHeading = "";
			for _,unit in ipairs(sortTbl) do
				if curSort == 2 and curHeading ~= unit:GetClass() then
					curHeading = unit:GetClass();
					i_ctl, cell = i_func(i_state, i_ctl);
					cell:Show(); cell.text:SetText(unit:GetClass()); cell:Select(); 
					cell.class = unit:GetClassMnemonic();
					cell:SetScript("OnMouseDown", DragScript);
				end
				i_ctl, cell = i_func(i_state, i_ctl);
				SetCell(cell, unit);
			end
			i_ctl = HideRest(i_func, i_state, i_ctl);
		else
			for i=1,8 do
				local g = groupOrder[i];
				i_ctl, cell = i_func(i_state, i_ctl);
				cell:Show(); cell.text:SetText(VFLI.i18n("Group ") .. g); cell:Select(); cell.group = g;
				cell:SetScript("OnMouseDown", DragScript);
				j=0;
				for _,unit in RDXDAL.Group(g) do if UnitIsPlayer(unit.uid) then
					i_ctl, cell = i_func(i_state, i_ctl);
					SetCell(cell, unit); SetGroup(cell, g);
					j=j+1;
				end end
				for k=j+1,5 do
					i_ctl, cell = i_func(i_state, i_ctl);
					ClearCell(cell); cell:Show(); SetGroup(cell, g);
				end
			end
		end
	end
	
	dlg:Show(.2, true);

	local closebtn = VFLUI.CloseButton:new()
	closebtn:SetScript("OnClick", function() 
		dlg:Hide(.2, true);
		VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "roster");
			dlg:Destroy(); dlg = nil;
		end);
	end);
	dlg:AddButton(closebtn);

	dlg.Destroy = VFL.hook(function(s)
		-- Cleanup the temp vars we stored on the cells.
		for _,cell in grid:StatelessIterator(1) do ClearCell(cell);	end
		RDXEvents:Unbind(s);
		btnGroup:Destroy(); btnClass:Destroy(); btnAlpha:Destroy();
		btnGroup = nil; btnClass = nil; btnAlpha = nil;
		grid:Destroy(); grid = nil;
		dlg = nil;
	end, dlg.Destroy);

	Update();
	RDXEvents:Bind("ROSTER_UPDATE", nil, Update, dlg);
end

-- Public API/hooks
RDX.OpenRosterWindow = OpenRaidWindow;

function RDX.CloseRosterWindow()
	if dlg and dlg.Destroy then dlg:Destroy(); end
end

