-- SetDebugger.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- The RDX6 set debugger.

-- Show the set debugger
function RDXM_Debug.SetDebugger()
	local sdb = RDXDAL._GetSetDatabase();

	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(.6,.6,0);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(400); dlg:SetHeight(432);
	dlg:SetText("Set Debugger");
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("setDebugger") then RDXPM.RestoreLayout(dlg, "setDebugger"); end
	--dlg:Show();

	local activeSet = nil;
	local function sd_setclick(self)
		activeSet = self._set;
	end
	local function sd_deparent(x)
		x._set = nil;
		x:Destroy();
	end

	-- The setlist
	local function SetApplyData(cell, set, pos)
		local text = pos .. ". ";
		if set:IsOpen() then text = text .. VFL.strcolor(0,1,0); else text = text .. VFL.strcolor(0.6, 0.6, 0.6); end
		text = text .. set.name .. " (" .. set:GetSetSize() .. ") <" .. set:_GetRefCount() .. ">|r";
		cell.text:SetText(text);
		if(set == activeSet) then
			cell.selTexture:SetVertexColor(0,0,1);
			cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		cell._set = set;
		cell:SetScript("OnClick", sd_setclick);
	end

	local setList = VFLUI.List:new(dlg, 12, function()
		local c = VFLUI.Selectable:new();
		c.OnDeparent = sd_deparent;
		return c;
	end);
	setList:SetDataSource(SetApplyData, VFL.ArrayLiterator(sdb));
	setList:SetWidth(284); setList:SetHeight(30*12 + 1);
	setList:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT", 5, -5);
	setList:Rebuild(); setList:Show();

	local function UpdateSetList()
		setList:Update();
	end

	-- The set content list
	local dta = {};

	local function CLApplyData(cell, data)
		cell.text:SetText(data);
	end
	local contentList = VFLUI.List:new(dlg, 12, function()
		local c = VFLUI.Selectable:new();
		c.OnDeparent = c.Destroy;
		return c;
	end);
	contentList:SetWidth(90); contentList:SetHeight(30*12 + 1);
	contentList:SetPoint("TOPLEFT", setList, "TOPRIGHT");
	contentList:SetDataSource(CLApplyData, VFL.ArrayLiterator(dta));
	contentList:Rebuild(); contentList:Show();

	local function UpdateSetData()
		VFL.empty(dta);
		if activeSet then
			local i = 1;
			for ctl,_,x in activeSet:Iterator() do 
				dta[i] = x:GetUnitID() .. ": " .. x:GetName();
				i=i+1;
			 end
		end
		contentList:Update();
	end

	-- Scheduling
	local schedEnt = nil;
	local function UpdateDlg()
		UpdateSetList();
		UpdateSetData();
		schedEnt = VFLT.ZMSchedule(.2, UpdateDlg);
	end
	UpdateDlg();
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "autoswitch_desktop");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	local btnClose = VFLUI.Button:new(dlg);
	btnClose:SetText("Close");
	btnClose:SetHeight(25); btnClose:SetWidth(75);
	btnClose:SetPoint("BOTTOMRIGHT", dlg, "BOTTOMRIGHT", -5, 5);
	btnClose:Show();
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnIncRef = VFLUI.Button:new(dlg);
	btnIncRef:SetText("IncRef");
	btnIncRef:SetHeight(25); btnIncRef:SetWidth(75);
	btnIncRef:SetPoint("RIGHT", btnClose, "LEFT");
	btnIncRef:Show();
	btnIncRef:SetScript("OnClick", function()
		if activeSet then activeSet:Open(); end
	end);

	dlg.Destroy = VFL.hook(function(s)
		if schedEnt then VFLT.ZMUnschedule(schedEnt); schedEnt = nil; end
		setList:Destroy(); setList = nil;
		contentList:Destroy(); contentList = nil;
		btnClose:Destroy(); btnClose = nil;
		btnIncRef:Destroy(); btnIncRef = nil;
	end, dlg.Destroy);
end



