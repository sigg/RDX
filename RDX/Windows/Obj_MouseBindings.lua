-- Obj_MouseBindings.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Glue code and interface code for customizable MouseBindings.

-- Helper functions/metadata
local btnNumberToName = { "LeftButton", "RightButton", "MiddleButton", "Button4", "Button5", "Button6", "Button7", "Button8", "Button9", "Button10"};
local btnNameToNumber = VFL.invert(btnNumberToName);

---------------------------------------------
-- Click symbol helper functions
---------------------------------------------

local function DecodeClickSymbol(cs)
	local ret = "";
	if string.find(cs, "S", 1, true) then ret = ret .. "Shift+"; end
	if string.find(cs, "C", 1, true) then ret = ret .. "Ctrl+"; end
	if string.find(cs, "A", 1, true) then ret = ret .. "Alt+"; end
	local _,_,qq = string.find(cs, "(%d)$");
	if qq then
		ret = ret .. btnNumberToName[tonumber(qq)];
		return ret;
	else
		return nil;
	end
end

local function GetClickSymbol(mbtn)
	if not mbtn then return ""; end
	local str = "";
	if IsShiftKeyDown() then str = str .. "S"; end
	if IsControlKeyDown() then str = str .. "C"; end
	if IsAltKeyDown() then str = str .. "A"; end
	local qq = btnNameToNumber[mbtn];
	if not qq then return ""; end
	return str .. qq;
end


---------------------------------------------------------------------------------
-- CLICK ACTION REPOSITORY
---------------------------------------------------------------------------------
local clickActions = {};

--- Register a click-bindable action. The registration table must have the following
-- fields:
-- name = The internal name of the action.
-- title = The text displayed when the action appears in the UI.
-- GetUI(parent, descr) = A function to generate a hierarchical UI object for editing
--   this action.
-- GetClickFunc(descr) = A function to generate the click function for this action. The
--   click function must be of the form F(unit) where unit is an RDX unit object.
function RDX.RegisterClickAction(tbl)
	if not tbl then error(VFLI.i18n("expected table, got nil")); end
	local n = tbl.name;
	if not n then error(VFLI.i18n("attempt to register anonymous click action")); end
	if clickActions[n] then error(VFLI.i18n("attempt to register duplicate click action")); end
	clickActions[n] = tbl;
	return true;
end

function RDX.GetClickActionByName(n)
	if not n then return nil; end
	return clickActions[n];
end

--- Given mouse binding data, build a function F(arg1, unit) that processes
-- the mouse click defined by arg1.
function RDX.BuildOnClickFunction(mbData)
	if (not mbData) or (not type(mbData) == "table") then return VFL.Noop; end
	-- Build the click table (map from ClickSymbol -> function)
	local clicktbl, qq = {}, nil;
	for k,v in pairs(mbData) do
		qq = RDX.GetClickActionByName(v.action);
		if qq then
			clicktbl[k] = qq.GetClickFunc(v);
		end
	end
	-- Now our function references the clicktable as an upvalue
	return function(click, unit, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
		local f = clicktbl[GetClickSymbol(click)];
		if f then f(unit, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10); end
	end
end

---------------------------------------------------------------------------------
-- MOUSE BINDING EDITOR
--
-- The mouse binding editor is a hierarchical control designed to manipulate
-- a single mouse binding. It will be embedded into the mouse binding editor
-- dialog.
---------------------------------------------------------------------------------
RDXUI.MouseBindingEditor = {};
function RDXUI.MouseBindingEditor:new(parent)
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

	local lbl2 = VFLUI.MakeLabel(nil, self, "Action type");
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
		for k,v in pairs(clickActions) do table.insert(qq, {text = v.title, value = v}); end
		return qq;
	end, function(val) SetAction(val) end);
	dd:SetPoint("LEFT", lbl2, "RIGHT"); dd:SetWidth(150); dd:Show();

	---------- Data storage and retrieval
	local bindingCode = nil;
	function self:GetBindingCode() return bindingCode; end
	function self:SetBindingCode(bc)
		bindingCode = bc;
		label:SetText(DecodeClickSymbol(bc));
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
		local cls = RDX.GetClickActionByName(desc.action);
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

-----------------------------------------------------------------------
-- THE MOUSE BINDING EDITOR DIALOG
-----------------------------------------------------------------------
-- Helper: open up a subdialog where the user can select a button combination
local function BindingCodePopup(parent, callback)
	------------------ CREATE
	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(200); dlg:SetHeight(260);
	dlg:SetText(VFLI.i18n("Select Button Combination"));
	dlg:Show();

	local gb_mods = VFLUI.GroupBox:new(dlg);
	gb_mods:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	gb_mods:SetHeight(190); gb_mods:SetWidth(80); gb_mods:Show();
	VFLUI.GroupBox.MakeTextCaption(gb_mods, "Modifiers");

	local mods = VFLUI.CheckGroup:new(gb_mods:GetClientArea());
	mods:SetPoint("TOPLEFT", gb_mods:GetClientArea(), "TOPLEFT");
	mods:SetLayout(3, 1);
	mods:SetWidth(70);
	mods.checkBox[1]:SetText("Shift");
	mods.checkBox[2]:SetText("Ctrl");
	mods.checkBox[3]:SetText("Alt");
	RDX:Debug(1, "Mods dimensions: " .. mods:GetHeight() .. "x" .. mods:GetWidth());
	mods:Show();

	local gb_btn = VFLUI.GroupBox:new(dlg);
	gb_btn:SetPoint("TOPLEFT", gb_mods, "TOPRIGHT");
	gb_btn:SetHeight(190); gb_btn:SetWidth(110); gb_btn:Show();
	VFLUI.GroupBox.MakeTextCaption(gb_btn, "Button");

	local btn = VFLUI.RadioGroup:new(gb_btn:GetClientArea());
	btn:SetPoint("TOPLEFT", gb_btn:GetClientArea(), "TOPLEFT");
	btn:SetLayout(10, 1);
	btn:SetWidth(100);
	btn.buttons[1]:SetText("Left");
	btn.buttons[2]:SetText("Right");
	btn.buttons[3]:SetText("Middle");
	btn.buttons[4]:SetText("Button 4");
	btn.buttons[5]:SetText("Button 5");
	btn.buttons[6]:SetText("Button 6");
	btn.buttons[7]:SetText("Button 7");
	btn.buttons[8]:SetText("Button 8");
	btn.buttons[9]:SetText("Button 9");
	btn.buttons[10]:SetText("Button 10");
	btn:Show();
	btn:SetValue(1);

	----------------- INTERACT
	local esch = function() dlg:Destroy(); dlg = nil; end
	VFL.AddEscapeHandler(esch);

	local function Save()
		local str, v = "", btn:GetValue();
		if mods.checkBox[1]:GetChecked() then str = str .. "S"; end
		if mods.checkBox[2]:GetChecked() then str = str .. "C"; end
		if mods.checkBox[3]:GetChecked() then str = str .. "A"; end
		if v == 1 then
			str = str .. "1";
		elseif v == 2 then
			str = str .. "2";
		elseif v == 3 then
			str = str .. "3";
		elseif v == 4 then
			str = str .. "4";
		elseif v == 5 then
			str = str .. "5";
		elseif v == 6 then
			str = str .. "6";
		elseif v == 7 then
			str = str .. "7";
		elseif v == 8 then
			str = str .. "8";
		elseif v == 9 then
			str = str .. "9";
		elseif v == 10 then
			str = str .. "10";
		else
			str = nil;
		end
		if callback then callback(str); end
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
		mods:Destroy(); mods = nil;
		gb_mods:Destroy(); gb_mods = nil;
		btn:Destroy(); btn = nil;
		gb_btn:Destroy(); gb_btn = nil;
	end, dlg.Destroy);
end


-- The main dialog
local dlg = nil;
local function EditMouseBindingsDialog(parent, path, md, callback)
	if (not path) or (not md) or (not md.data) then return nil; end
	local desc = VFL.copy(md.data);
	------------------ CREATE
	if dlg then return nil; end
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:Accomodate(390, 350);
	dlg:SetText(VFLI.i18n("Edit MouseBindings: ") .. path);
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("mbDialog") then RDXPM.RestoreLayout(dlg, "mbDialog"); end
	dlg:Show();

	local ui, sf = VFLUI.CreateScrollingCompoundFrame(dlg);
	sf:SetWidth(390 - 16); sf:SetHeight(350 - 25);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");

	----------------- POPULATE
	-- Push already-extant mouse bindings into the container
	for k,v in pairs(desc) do
		local mbFrame = RDXUI.MouseBindingEditor:new(ui);
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
	local esch = function() RDXPM.StoreLayout(dlg, "mbDialog"); dlg:Destroy(); dlg = nil; end
	VFL.AddEscapeHandler(esch);

	-- On add, check if the binding already exists; if not, add it.
	local function Add(bCode)
		if desc[bCode] then
			VFLUI.MessageBox(VFLI.i18n("Error"), VFLI.i18n("That button combination is already bound. Try editing the current binding."));
			return nil;
		else
			local mbFrame = RDXUI.MouseBindingEditor:new(ui);
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
			desc[bCode] = true;
		end
	end

	local btnAdd = VFLUI.OKButton:new(dlg);
	btnAdd:SetText(VFLI.i18n("New Binding")); btnAdd:SetHeight(25); btnAdd:SetWidth(75);
	btnAdd:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnAdd:Show();
	btnAdd:SetScript("OnClick", function()
		BindingCodePopup(dlg, function(str) if str then Add(str); end end);
	end);
	
	local function Save()
		desc = {};
		-- Depopulate the controls
		local qq,rr;
		for mbFrame in ui:Iterator() do
			qq,rr = mbFrame:GetDescriptor();
			desc[qq] = rr;
		end
		-- Save to the file metadata
		md.data = desc;
		-- callback
		if callback then callback(md.data); end
		-- Notify the FS that we've updated.
		RDXDB.NotifyUpdate(path);
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

--------------------------------------------------
-- THE MOUSE BINDING OBJECT
--------------------------------------------------
RDXDB.RegisterObjectType({
	name = "MouseBindings";
	New = function(path, md)
		md.version = 1;
	end;
	Edit = function(path, md, parent)
		EditMouseBindingsDialog(parent or VFLFULLSCREEN, path, md);
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text = VFLI.i18n("Edit..."),
			OnClick = function() 
				VFL.poptree:Release(); 
				EditMouseBindingsDialog(dlg, path, md); 
			end
		});
	end;
});

------------------------------------------------------------------------
-- Post-Click Hook
-- Allow the addition of scripts to any window with the appropriate advice.
------------------------------------------------------------------------
-- A subfunction to make unclickable frames clickable (non-secure-based)
local function buttonCreator(cell)
	uf = VFLUI.AcquireFrame("Button");
	uf:SetParent(cell); uf:SetFrameLevel(cell:GetFrameLevel() + 4);
	uf:SetAllPoints(cell); uf:Show();
	uf:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
	cell._clickable = uf;
	cell.Destroy = VFL.hook(function(s)
		if s._clickable then s._clickable:Destroy(); s._clickable = nil; end
	end, cell.Destroy);
	return uf;
end

local function GenerateButtonGenerator(state, clickf)
	state:Attach(state:Slot("CellPrePaintAdvice"), true, function(window, cell, index, icv, a1, a2, a3, a4, a5)
		local uf = cell._clickable;
		if not uf then uf = buttonCreator(cell); end
		uf:SetScript("PostClick", function() clickf(window, cell, index, icv, a1, a2, a3, a4, a5); end);
	end);
end

RDX.RegisterFeature({
	name = "Script Click Hook";
	category = VFLI.i18n("Mouse Bindings");
	IsPossible = function(state)
		if not state:Slot("CellPrePaintAdvice") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		local md,_,_,ty = RDXDB.GetObjectData(desc.script);
		if (not md) or (ty ~= "Script") or (not md.data) or (not md.data.script) then
			VFL.AddError(errs, VFLI.i18n("Invalid script pointer.")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- Compile the script.
		local md = RDXDB.GetObjectData(desc.script);
		local str = [[return function(window, cell, index, icv, a1, a2, a3, a4, a5)
]];
		str = str .. md.data.script .. [[

end]];
		local clickf,err = loadstring(str);
		if not clickf then
			VFL.TripError("RDX", VFLI.i18n("Could not compile click hook."), err .. VFLI.i18n("\n\nCode:\n------------------\n\n") .. str);
			return;
		end
		clickf = clickf();

		-- Do the work.
		GenerateButtonGenerator(state, clickf);
	end;
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local scriptsel = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Script")); end);
		scriptsel:SetLabel(VFLI.i18n("Script object")); scriptsel:Show();
		if desc and desc.script then scriptsel:SetPath(desc.script); end
		ui:InsertFrame(scriptsel);

		function ui:GetDescriptor()
			return { 
				feature = "Script Click Hook";
				script = scriptsel:GetPath();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Script Click Hook" };
	end;
});

RDX.RegisterFeature({
	name = "Generic Click Hook";
	invisible = true;
	IsPossible = function(state)
		if not state:Slot("CellPrePaintAdvice") then return nil; end
		return true;
	end;
	ExposeFeature = VFL.True;
	ApplyFeature = function(desc, state)
		clickf = state:GetSlotFunction("_ClickFunction");
		GenerateButtonGenerator(state, clickf);
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function()
		return { feature = "Generic Click Hook" };
	end;
});

