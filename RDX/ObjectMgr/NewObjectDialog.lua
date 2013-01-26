-- NewObjectDialog.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson

------------------------------------------------
-- The new object dialog
------------------------------------------------
local dlg = nil;
local otypes = {};
function RDXDB.NewObjectDialog(parent, pkgName)
	if dlg or (not pkgName) then return; end

	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 20);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText(VFLI.i18n("New object in package ") .. pkgName);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetHeight(350); dlg:SetWidth(260);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("nod") then RDXPM.RestoreLayout(dlg, "nod"); end

	local ca = dlg:GetClientArea();

	--------------------- Predeclarations
	local activeType = nil; 
	local UpdateTypeList, SetActiveType;

	--------------------- Name editor
	local nameEd = VFLUI.Edit:new(dlg);
	nameEd:SetHeight(25); nameEd:SetWidth(250);
	nameEd:SetPoint("TOPLEFT", ca, "TOPLEFT", 0, -10);
	nameEd:Show();
	
	local lbl1 = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Enter name of new object:"));
	lbl1:SetPoint("BOTTOMLEFT", nameEd, "TOPLEFT", 3, 0);

	------------------- Objtypes list
	local decor1 = VFLUI.AcquireFrame("Frame");
	decor1:SetParent(dlg);
	decor1:SetBackdrop(VFLUI.BlackDialogBackdrop);
	decor1:SetPoint("TOPLEFT", nameEd, "BOTTOMLEFT", 0, -10);
	decor1:SetWidth(250); decor1:SetHeight(238); decor1:Show();

	local lbl1 = VFLUI.MakeLabel(nil, dlg, VFLI.i18n("Select type of new object:"));
	lbl1:SetPoint("TOPLEFT", decor1, "TOPLEFT", 3, 10);

	local otList = VFLUI.List:new(dlg, 12, VFLUI.Selectable.AcquireCell)
	otList:SetPoint("TOPLEFT", decor1, "TOPLEFT", 5, -5);
	otList:SetWidth(240); otList:SetHeight(228);
	otList:Rebuild(); otList:Show();

	otList:SetDataSource(function(cell, data, pos)
		cell.text:SetText(data);
		if(data == activeType) then
			cell.selTexture:SetVertexColor(0,0,1); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		cell:SetScript("OnClick", function() SetActiveType(data); end);
	end, VFL.ArrayLiterator(otypes));

	function UpdateTypeList()
		VFL.empty(otypes); local i = 0;
		for k,v in pairs(RDXDB._GetObjectTypes()) do
			if IsShiftKeyDown() then
				if v.invisible and v.New then
					i=i+1; otypes[i] = k;
				end
			else
				if not v.invisible then
					i=i+1; otypes[i] = k;
				end
			end
		end
		-- Burning Crusade: remove table.setn
		if not table.maxn then table.setn(otypes, i); end
		table.sort(otypes, function(a,b) return a<b; end);
		otList:Update();
	end

	function SetActiveType(at)
		if(at ~= activeType) then
			activeType = at;
			otList:Update();
		end
	end
	
	----------------- Feedback
	local feedback = VFLUI.MakeLabel(nil, dlg, "");
	feedback:SetPoint("TOPLEFT", decor1, "BOTTOMLEFT", 3, 0);
	feedback:SetWidth(250);

	---------------- OK button
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText("OK");
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", ca, "BOTTOMRIGHT");
	btnOK:Show();

	----------------- Close functionality
	dlg.Destroy = VFL.hook(function()
		nameEd:Destroy(); nameEd = nil;
		otList:Destroy(); otList = nil;
		decor1:Destroy(); decor1 = nil;
		btnOK:Destroy(); btnOK = nil;
	end, dlg.Destroy);
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "nod");
			dlg:Destroy(); dlg = nil;
		end);
	end

	VFL.AddEscapeHandler(esch);
	local closebtn = VFLUI.CloseButton:new();
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	-- OK handler
	local function OnOK()
		if activeType then
			local x1, x2 = RDXDB.CreateObject(pkgName, nameEd:GetText(), activeType);
			if x1 then -- all OK
				VFL.EscapeTo(esch);
			else -- error :\
				feedback:SetText("|cFFFF0000" .. x2 .. "|r");
				return;
			end
		else
			feedback:SetText(VFLI.i18n("|cFFFF0000Select an object type.|r"));
			return;
		end
	end
	btnOK:SetScript("OnClick", OnOK);
	nameEd:SetScript("OnEnterPressed", OnOK);


	------------------- Dlginit
	UpdateTypeList();
end
