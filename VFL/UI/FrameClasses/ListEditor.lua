-- ListEditor.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A ListEditor allows the editing and rearrangement of linear lists of objects.

-- Helper

local function buildPopupDropdown(db, callback, frame, point, dx, dy)
	local qq = {};
	for _,v in pairs(db) do
		local dbEntry = v;
		table.insert(qq, {
			text = v.text;
			texture = v.texture or "Interface\\InventoryItems\\WoWUnknownItem01.blp";
			func = function()
				VFL.poptree:Release();
				callback(dbEntry);
			end
		});
	end
	table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
	VFL.poptree:Begin(150, 12, frame, point, dx, dy);
	VFL.poptree:Expand(nil, qq, 20);
end

VFLUI.ListEditor = {};

--- Create a new list editor.
-- @param parent The parent frame.
-- @param fnBuildDropdown The "build" function for the associated DropDown. If not
--   provided, a simple edit box will be used instead of a DropDown.
-- @param fnApplyData The function used to paint the cells of the list.
-- @param fnAcceptEntry Called whenever an entry is made to the edit box/dropdown;
--   should add the entry to the list if it is to be accepted.
function VFLUI.ListEditor:new(parent, list, fnApplyData, fnBuildDropdown, fnAcceptEntry)
	if not parent then error("parent is required"); end
	if not list then
		error("VFLUI.ListEditor:new: list is required.");
	end
	if not fnApplyData then
		error("VFLUI.ListEditor:new: fnApplyData is required.");
	end

	local le = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(le, parent, 1);

	----------------- PREDECLARATIONS
	local listCtl, selection = nil, nil;
	local function Select(pos)
		selection = pos; listCtl:Update();
	end

	local function OnEntry(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
		fnAcceptEntry(list, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
		listCtl:Update();
	end

	function le:GetList() return list; end
	
	------------------ CONTROLS
	local edit;
	
	local btnlist = VFLUI.Button:new(le);
	btnlist:SetHeight(25); btnlist:SetWidth(25); btnlist:SetText("...");
	btnlist:SetPoint("TOPLEFT", le, "TOPLEFT");
	btnlist:Disable();
	btnlist:Show();
	if fnBuildDropdown then
		btnlist:Enable();
		btnlist:SetScript("OnClick", function()
			buildPopupDropdown(fnBuildDropdown(), function(x)
				edit:SetText(x.text);
			end, btnlist, "CENTER");
		end);
	end
		
	edit = VFLUI.Edit:new(le);
	edit:SetPoint("LEFT", btnlist, "RIGHT"); edit:SetHeight(25);
	edit:Show();
	edit:SetScript("OnEnterPressed", function(self)
		OnEntry("EDIT", self, self:GetText());
	end);
	-- Apply default AcceptEntry function for edit boxes
	if not fnAcceptEntry then
		fnAcceptEntry = function(list, ty, ctl, txt)
			if txt and txt ~= "" then 
				table.insert(list, txt);
				if ctl then
					ctl:SetText("");
				end
			else
				VFLUI.MessageBox("Error", "Enter something please.");
			end
		end
	end
	
	local decor = VFLUI.AcquireFrame("Frame");
	decor:SetParent(le);
	decor:SetBackdrop(VFLUI.DefaultDialogBorder);
	decor:SetPoint("TOPLEFT", btnlist, "BOTTOMLEFT");
	decor:Show();
	
	listCtl = VFLUI.List:new(le, 12, VFLUI.Selectable.AcquireCell);
	listCtl:SetPoint("TOPLEFT", decor, "TOPLEFT", 5, -5);
	listCtl:Show();
	listCtl:SetDataSource(function(cell, data, pos)
		fnApplyData(cell, data, pos);
		if(pos == selection) then
			cell.selTexture:SetVertexColor(0,0,1); cell.selTexture:Show();
		else
			cell.selTexture:Hide();
		end
		cell:SetScript("OnClick", function() Select(pos); end);
	end, VFL.ArrayLiterator(list));

	local btnRemove = VFLUI.Button:new(le);
	btnRemove:SetText(VFLI.i18n("Remove"));
	btnRemove:SetHeight(25); btnRemove:SetWidth(80);
	btnRemove:SetPoint("TOPRIGHT", decor, "BOTTOMRIGHT");
	btnRemove:Show();
	btnRemove:SetScript("OnClick", function()
		if selection then
			table.remove(list, selection); 
			if(list[selection]) then Select(selection) else Select(nil) end
		end
	end);
	local btnDn = VFLUI.Button:new(le);
	btnDn:SetText(VFLI.i18n("Down"));
	btnDn:SetHeight(25); btnDn:SetWidth(80);
	btnDn:SetPoint("RIGHT", btnRemove, "LEFT");
	btnDn:Show();
	btnDn:SetScript("OnClick", function()
		if selection and selection < table.getn(list) then
			local tmp = list[selection];
			list[selection] = list[selection+1];
			list[selection+1] = tmp;
			Select(selection+1);
		end
	end);
	local btnUp = VFLUI.Button:new(le);
	btnUp:SetText(VFLI.i18n("Up"));
	btnUp:SetHeight(25); btnUp:SetWidth(80);
	btnUp:SetPoint("RIGHT", btnDn, "LEFT");
	btnUp:Show();
	btnUp:SetScript("OnClick", function()
		if selection and selection > 1 then
			local tmp = list[selection];
			list[selection] = list[selection-1];
			list[selection-1] = tmp;
			Select(selection-1);
		end
	end);

	--------------- LAYOUT
	local function Layout()
		VFL:Debug(1, "ListEditor:Layout() to " .. le:GetWidth() .. "x" .. le:GetHeight());
		edit:SetWidth(le:GetWidth() - 25);
		decor:SetWidth(le:GetWidth()); 
		decor:SetHeight(VFL.clamp(le:GetHeight() - 25, 0, 2000));
		listCtl:SetWidth(VFL.clamp(le:GetWidth() - 10, 0, 2000));
		listCtl:SetHeight(VFL.clamp(le:GetHeight() - 35, 0, 2000));
		listCtl:Rebuild();
	end
	le.DialogOnLayout = Layout;
	le:SetScript("OnShow", Layout); le:SetScript("OnSizeChanged", Layout);

	-------------- DESTRUCTORS
	le.Destroy = VFL.hook(function(s)
		listCtl:Destroy(); listCtl = nil;
		decor:Destroy(); decor = nil;
		edit:Destroy(); edit = nil;
		btnlist:Destroy(); btnlist = nil;
		btnRemove:Destroy(); btnRemove = nil; btnDn:Destroy(); btnDn = nil;
		btnUp:Destroy(); btnUp = nil;
		s.DialogOnLayout = nil; s.GetList = nil;
		list = nil;
	end, le.Destroy);

	return le;
end
