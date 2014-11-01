--
-- OpenRDX
--

-------------------
-- helper
-------------------

-- The windows list container
local wl = {};
local function BuildWindowList()
	VFL.empty(wl);
	local _, _, auiname = RDXDB.ParsePath(RDXU.AUI);
	local _, _, a, b = string.find(auiname, "^(.*)_(.*)$");
	if b then
		local desc = nil;
		for pkg,data in pairs(RDXDB.GetDisk(a)) do
			if pkg == b or RDXDB.IsCommonPackage(a, pkg) then
				for file,md in pairs(data) do
					if (type(md) == "table") and md.data and md.ty and string.find(md.ty, "Window$") then
						local hide = RDXDB.HasFeature(md.data, "WindowListHide");
						if not hide then
							table.insert(wl, {text = RDXDB.MakePath(a, b, file)});
						end
					end
				end
			end
		end
	end
	table.sort(wl, function(x1,x2) return x1.text<x2.text; end);
	return wl;
end

---------------------------------------------------------------------------------
-- ACTION REPOSITORY
---------------------------------------------------------------------------------
local stateActions = {};

function RDX.RegisterStateAction(tbl)
	if not tbl then error(VFLI.i18n("expected table, got nil")); end
	local n = tbl.name;
	if not n then error(VFLI.i18n("attempt to register anonymous state action")); end
	if stateActions[n] then error(VFLI.i18n("attempt to register duplicate state action")); end
	stateActions[n] = tbl;
	return true;
end

function RDX.GetStateActionByName(n)
	if not n then return nil; end
	return stateActions[n];
end

RDX.RegisterStateAction({
	name = "WINDOW_OPEN";
	title = "Open";
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Window:"));
		local dd_windowId = VFLUI.Dropdown:new(er, BuildWindowList, nil, nil, nil, 30);
		dd_windowId:SetWidth(250); dd_windowId:Show();
		if desc and desc.name then 
			dd_windowId:SetSelection(desc.name); 
		end
		er:EmbedChild(dd_windowId); er:Show();
		ui:InsertFrame(er);

		ui.GetDescriptor = function(s) return { name = dd_windowId:GetSelection(); }; end

		return ui;
	end;
	GetClickFunc = function() return VFL.Noop; end
});

RDX.RegisterStateAction({
	name = "WINDOW_CLOSE";
	title = "Close";
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Window:"));
		local dd_windowId = VFLUI.Dropdown:new(er, BuildWindowList, nil, nil, nil, 30);
		dd_windowId:SetWidth(250); dd_windowId:Show();
		if desc and desc.name then 
			dd_windowId:SetSelection(desc.name); 
		end
		er:EmbedChild(dd_windowId); er:Show();
		ui:InsertFrame(er);

		ui.GetDescriptor = function(s) return { name = dd_windowId:GetSelection(); }; end

		return ui;
	end;
	GetClickFunc = function() return VFL.Noop; end
});

RDX.RegisterStateAction({
	name = "WINDOW_DOCK";
	title = "Dock";
	GetUI = VFL.Nil;
	GetClickFunc = function() return VFL.Noop; end
});

---
-- State Action Editor
---

RDXUI.StateActionEditor = {};
function RDXUI.StateActionEditor:new(parent, path)
	local self = VFLUI.AcquireFrame("Frame");
	if parent then
		self:SetParent(parent);
		self:SetFrameStrata(parent:GetFrameStrata());
		self:SetFrameLevel(parent:GetFrameLevel() + 1);
	end
	self:SetBackdrop(VFLUI.BlackDialogBackdrop);
	
	------------ Static controls
	local btn = VFLUI.CloseButton:new(self, 12);
	btn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -5, -5);
	btn:Hide();
	function self:EnableCloseButton(closeFunc)
		btn:Show(); btn:SetScript("OnClick", closeFunc);
	end

	local label = VFLUI.CreateFontString(self);
	label:SetHeight(12); label:SetWidth(150);
	label:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	label:SetFontObject(Fonts.Default10); label:SetJustifyH("LEFT"); label:Show();

	local lbl2 = VFLUI.MakeLabel(nil, self, VFLI.i18n("Action type"));
	lbl2:SetPoint("TOPLEFT", label, "BOTTOMLEFT"); lbl2:SetHeight(25);

	---------- Child object handling
	local child, typeName = nil, nil;
	local function DestroyChild()
		if child then
			child:Destroy();  child.GetDescriptor = nil; child = nil;
			VFLUI.UpdateDialogLayout(self);
		end
	end
	local function SetChild(ch)
		if ch then
			child = ch; child:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -42); child:Show();
			VFLUI.UpdateDialogLayout(self);
		else DestroyChild(); end
	end
	local function SetAction(qq)
		DestroyChild();
		typeName = qq.name;
		SetChild(qq.GetUI(self));
	end

	-- Hierarchichal layout
	function self:DialogOnLayout()
		RDX:Debug(1, "MouseBindingEditor:DialogOnLayout()");
		if child then
			child:SetWidth(self:GetWidth() - 10); -- width constrained downward
			child:DialogOnLayout();
			self:SetHeight(47 + child:GetHeight()); -- height constrained upward
		else
			self:SetHeight(47);
		end
	end
	
	---------- The binding-class-dropdown
	local dd = VFLUI.Dropdown:new(self, function()
		local qq = {};
		for k,v in pairs(stateActions) do table.insert(qq, {text = v.title, value = v}); end
		return qq;
	end, function(val) SetAction(val) end);
	dd:SetPoint("LEFT", lbl2, "RIGHT"); dd:SetWidth(100); dd:Show();

	---------- Data storage and retrieval
	local bindingCode = nil;
	function self:GetBindingCode() return bindingCode; end
	function self:SetBindingCode(bc)
		bindingCode = bc;
		label:SetText(bc);
	end
	function self:GetDescriptor()
		if not bindingCode then return nil; end
		local dd = nil;
		if child then dd = child:GetDescriptor(); else dd = {}; end
		dd.action = typeName;
		return bindingCode, dd;
	end
	function self:SetDescriptor(bcode, desc)
		self:SetBindingCode(bcode);
		local cls = RDX.GetStateActionByName(desc.action);
		if cls then
			typeName = desc.action;
			dd:RawSetSelection(cls.title, cls);
			DestroyChild(); SetChild(cls.GetUI(self, desc));
		end
	end

	------------ Destructor
	self.Destroy = VFL.hook(function(s)
		dd:Destroy(); dd = nil; btn:Destroy(); btn = nil;
		VFLUI.ReleaseRegion(label); label = nil;
		if child then child:Destroy(); child.GetDescriptor = nil; child = nil;  end
		s.GetDescriptor = nil; s.SetDescriptor = nil; 
		s.GetBindingCode = nil; s.SetBindingCode = nil;
		s.DialogOnLayout = nil; s.EnableCloseButton = nil;
	end, self.Destroy);

	return self;
end

-- POPUP Enter a name

local function BindingCodePopup(parent, callback)
	------------------ CREATE
	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(200); dlg:SetHeight(80);
	dlg:SetText(VFLI.i18n("Enter a name for your action"));
	dlg:SetClampedToScreen(true);
	dlg:Show();

	local name = VFLUI.LabeledEdit:new(dlg, 140); name:SetHeight(25); name:SetWidth(190);
	name:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT", 0, 0); name:SetText(VFLI.i18n("Name")); 
	name:Show();

	----------------- INTERACT
	local esch = function() dlg:Destroy(); dlg = nil; end
	VFL.AddEscapeHandler(esch);

	local function Save()
		if callback then callback(name.editBox:GetText()); end
		-- Destroy the window
		VFL.EscapeTo(esch);
	end
	
	local btnOK = VFLUI.OKButton:new(dlg); -- OK button
	btnOK:SetText(VFLI.i18n("OK")); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		Save();
	end);
	
	local btnCancel = VFLUI.CancelButton:new(dlg); -- OK button
	btnCancel:SetText(VFLI.i18n("Cancel")); btnCancel:SetHeight(25); btnCancel:SetWidth(75);
	btnCancel:SetPoint("RIGHT", btnOK, "LEFT");
	btnCancel:Show();
	btnCancel:SetScript("OnClick", function()
		VFL.EscapeTo(esch); 
	end);

	----------------- DESTROY
	dlg.Destroy = VFL.hook(function(s)
		btnCancel:Destroy(); btnCancel = nil;
		btnOK:Destroy(); btnOK = nil;
		name:Destroy(); name = nil;
	end, dlg.Destroy);
end


--
-- The main dialog
--

local dlg = nil;
function RDXDK.EditStateActionDialog(parent, desc, callback)
	------------------ CREATE
	if dlg then return nil; end
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:Accomodate(390, 350);
	dlg:SetText(VFLI.i18n("Edit State Action"));
	dlg:SetClampedToScreen(true);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("stDialog") then RDXPM.RestoreLayout(dlg, "stDialog"); end
	dlg:Show();

	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(390 - 16); sf:SetHeight(350 - 25);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");

	----------------- POPULATE
	-- Push already-extant mouse bindings into the container
	for k,v in pairs(desc) do
		local mbFrame = RDXUI.StateActionEditor:new(ui);
		mbFrame:SetDescriptor(k, v); mbFrame:Show();
		mbFrame:EnableCloseButton(function()
			if ui:RemoveFrame(mbFrame) then
				desc[mbFrame:GetBindingCode()] = nil;
				mbFrame:Destroy();
				VFLUI.UpdateDialogLayout(ui);
			end
		end);
		ui:InsertFrame(mbFrame);
	end
	VFLUI.ActivateScrollingCompoundFrame(ui, sf);

	----------------- INTERACT
	local esch = function() RDXPM.StoreLayout(dlg, "stDialog"); dlg:Destroy(); dlg = nil; end
	VFL.AddEscapeHandler(esch);

	-- On add, check if the binding already exists; if not, add it.
	local function Add(bCode)
		if desc[bCode] then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("That name is already used."));
			return nil;
		else
			local mbFrame = RDXUI.StateActionEditor:new(ui, path);
			mbFrame:SetBindingCode(bCode); mbFrame:Show();
			mbFrame:EnableCloseButton(function()
				if ui:RemoveFrame(mbFrame) then
					desc[mbFrame:GetBindingCode()] = nil;
					mbFrame:Destroy();
					VFLUI.UpdateDialogLayout(ui);
				end
			end);
			mbFrame:SetWidth(sf:GetWidth()); ui:InsertFrame(mbFrame);
			VFLUI.UpdateDialogLayout(ui);
			desc[bCode] = {};
		end
	end

	local btnAdd = VFLUI.OKButton:new(dlg);
	btnAdd:SetText(VFLI.i18n("New Action")); btnAdd:SetHeight(25); btnAdd:SetWidth(150);
	btnAdd:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnAdd:Show();
	btnAdd:SetScript("OnClick", function()
		BindingCodePopup(dlg, function(str) if str then Add(str); end end);
	end);
	
	local function Save()
		VFL.empty(desc);
		-- Depopulate the controls
		local qq,rr;
		for mbFrame in ui:Iterator() do
			qq,rr = mbFrame:GetDescriptor();
			desc[qq] = rr;
		end
		-- callback
		if callback then callback(desc); end
		-- Destroy the window
		VFL.EscapeTo(esch);
	end

	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	----------------- DESTROY
	dlg.Destroy = VFL.hook(function(s)
		btnAdd:Destroy(); btnAdd = nil;
		VFLUI.DestroyScrollingCompoundFrame(ui, sf);
		ui = nil; sf = nil;
	end, dlg.Destroy);
end

