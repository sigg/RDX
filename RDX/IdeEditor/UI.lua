-- UI.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL. UNLICENSED COPYING IS PROHIBITED.
--
-- Primitives associated with the RDX UI.
RDXUI = RegisterVFLModule({
	name = "RDXUI";
	title = VFLI.i18n("RDX UI Tools");
	description = "RDX UI Tools";
	version = {1,0,0};
	parent = RDX;
});




-- Helpful tools and objects for the UnitFrames UIs.

---------------------------------------------------
-- Generate a right-embedded color swatch inside a container.
---------------------------------------------------
function RDXUI.GenerateColorSwatch(ctr, text)
	local er = VFLUI.EmbedRight(ctr, text);
	local swatch = VFLUI.ColorSwatch:new(er);
	swatch:Show();
	er:EmbedChild(swatch); er:Show();
	ctr:InsertFrame(er);
	return swatch;
end

----------------------------------------------------
-- Given a unitframe state, compose a list of available objects on that state.
----------------------------------------------------
function RDXUI.ComposeObjectList(state, prefix, includeBase)
	local tbl = {};
	if (not state) or (not state:Slot("Base")) then return tbl; end
	if includeBase then table.insert(tbl, {text = "Base"}); end
	if type(prefix) == "table" then
		for i,p in pairs(prefix) do
			for x in state:SlotsMatching("^" .. p) do
				local _,_,trim = string.find(x, "^" .. p .. "(.*)$");
				if trim then
					table.insert(tbl, {text = p .. trim});
				end
			end
		end
	else
		for x in state:SlotsMatching("^" .. prefix) do
			local _,_,trim = string.find(x, "^" .. prefix .. "(.*)$");
			if trim then
				table.insert(tbl, {text = trim});
			end
		end
	end
	return tbl;
end

function RDXUI.ComposeFrameList(state)
	return RDXUI.ComposeObjectList(state, "Frame_", true);
end

function RDXUI.ComposeAnchorList(state)
	--return RDXUI.ComposeObjectList(state, "Frame_", true);
	return RDXUI.ComposeObjectList(state, {"Frame_", "Text_", "Texture_", }, true);
end

----------------------------------------------------
-- Generate a dropdown that selects slots with a given prefix from a state.
----------------------------------------------------
function RDXUI.MakeSlotSelectorDropdown(ctr, title, state, prefix, includeBase, x1, x2)
	local er = VFLUI.EmbedRight(ctr, title);
	local dd_array = RDXUI.ComposeObjectList(state, prefix, includeBase);
	if x1 then table.insert(dd_array, {text = x1}); end
	if x2 then table.insert(dd_array, {text = x2}); end
	local dd = VFLUI.ComboBox:new(er, function() return dd_array; end);
	dd:SetWidth(250); dd:Show();
	er:EmbedChild(dd); er:Show();
	ctr:InsertFrame(er);

	return dd;
end

-- Validity check for boolean variables (allow true/false constants)
function RDXUI.IsValidBoolVar(vn, state)
	if (not vn) then return nil; end
	if (vn == "true") or (vn == "false") or (state:Slot("BoolVar_" .. vn)) then return true; else return nil; end
end

RDXUI.UnitFrameAnchorSelector = {};
function RDXUI.UnitFrameAnchorSelector:new(parent)
	local self = VFLUI.GroupBox:new(parent);
	VFLUI.GroupBox.MakeTextCaption(self, VFLI.i18n("Anchor"));
	self:SetLayoutConstraint("WIDTH_DOWNWARD_HEIGHT_UPWARD");
	local ctr = VFLUI.CompoundFrame:new(self); ctr:Show();
	self:SetClient(ctr);

	-- Local anchor point
	local er = VFLUI.EmbedRight(ctr, VFLI.i18n("Anchor local point:"));
	local dd_lp = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
	dd_lp:SetWidth(150); dd_lp:Show(); dd_lp:SetSelection("TOPLEFT");
	er:EmbedChild(dd_lp); er:Show();
	ctr:InsertFrame(er);

	-- Remote anchor frame
	local afArray = {};
	local afOnBuild = function() return afArray; end
	function self:SetAFArray(x) afArray = x; end

	er = VFLUI.EmbedRight(ctr, VFLI.i18n("To object:"));
	local dd_af = VFLUI.ComboBox:new(er, afOnBuild);
	dd_af:SetWidth(150); dd_af:Show();
	er:EmbedChild(dd_af); er:Show();
	ctr:InsertFrame(er);
	
	-- Remote anchor point
	local er = VFLUI.EmbedRight(ctr, VFLI.i18n("and remote point:"));
	local dd_rp = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
	dd_rp:SetWidth(150); dd_rp:Show(); dd_rp:SetSelection("TOPLEFT");
	er:EmbedChild(dd_rp); er:Show();
	ctr:InsertFrame(er);

	-- OffsetY
	local edy = VFLUI.LabeledEdit:new(ctr, 75); edy:SetText(VFLI.i18n("Offset X/Y:")); edy:Show();
	local edx = VFLUI.Edit:new(edy); edx:Show();
	edx:SetHeight(24); edx:SetWidth(75); edx:SetPoint("RIGHT", edy.editBox, "LEFT");
	edy.Destroy = VFL.hook(function() edx:Destroy(); end, edy.Destroy);
	ctr:InsertFrame(edy);

	------------------------ SETUP
	function self:SetAnchorInfo(ai)
		dd_lp:SetSelection(ai.lp); dd_rp:SetSelection(ai.rp); dd_af:SetText(ai.af);
		edx:SetText(ai.dx); edy.editBox:SetText(ai.dy);
	end
	function self:GetAnchorInfo()
		local dx = VFL.clamp(edx:GetNumber(), -1024, 1024);
		local dy = VFL.clamp(edy.editBox:GetNumber(), -1024, 1024);
		return {
			lp = dd_lp:GetSelection(), rp = dd_rp:GetSelection(), af = dd_af:GetSelection(),
			dx = dx, dy = dy
		};
	end

	----------------------- Destructor
	self.Destroy = VFL.hook(function(s)
		s.SetAFArray = nil; 
		afArray = nil; afOnBuild = nil;
		s.SetAnchorInfo = nil; s.GetAnchorInfo = nil;
	end, self.Destroy);

	return self;
end

--- A helper function to resolve a frame reference to a variable on the object.
function RDXUI.ResolveFrameReference(ref)
	if (not ref) or (ref == "") or (ref == "Base") then return "frame"; end
	if string.find(ref, "^Frame_") then
		VFL.TripError("RDX", VFLI.i18n("Warning: deprecated frame reference"), VFLI.i18n("Deprecated frame reference <") .. ref .. ">");
		return "frame." .. ref;
	else
		return "frame.Frame_" .. ref;
	end
end

function RDXUI.ResolveTextureReference(ref)
	if (not ref) or (ref == "") or (ref == "Base") then return "tex1"; end
	return "frame.Texture_" .. ref;
end

function RDXUI.ResolveTextReference(ref)
	if (not ref) or (ref == "") or (ref == "Base") then return "customText"; end
	return "frame.Text_" .. ref;
end

--- A helper function to generate the appropriate arguments to SetPoint() given an
-- anchor descriptor
function RDXUI.ResolveAnchorReference(ref)
	if (not ref) or (ref == "") or (ref == "Base") then return "frame"; end
	if string.find(ref, "^Frame_") or string.find(ref, "^Texture_") or string.find(ref, "^Text_") then
		return "frame." .. ref;
	else
		return "frame.Frame_" .. ref;
	end
end

function RDXUI.AnchorCodeFromDescriptor(anchor)
	return "'" .. anchor.lp .. "'," .. RDXUI.ResolveAnchorReference(anchor.af) .. ",'" .. anchor.rp .. "'," .. anchor.dx .. "," .. anchor.dy;
end

------------------------------------------
-- Layout helpers
------------------------------------------

function RDXUI.LayoutCodeMultiRows(objname, desc)
	local createCode = [[
frame.]] .. objname .. [[[1]:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
for i=2, ]] .. desc.nIcons .. [[ do ]];
	local opri1, opri2, osec1, osec2, csx, csy, csxm, csym = '"RIGHT"', '"LEFT"', '"TOP"', '"BOTTOM"', -tonumber(desc.iconspx), 0, 0, -tonumber(desc.iconspy);
	if desc.orientation == "RIGHT" then
		opri1 = '"LEFT"'; opri2 = '"RIGHT"'; csx = tonumber(desc.iconspx); csy = 0;
	elseif desc.orientation == "DOWN" then
		opri1 = '"TOP"'; opri2 = '"BOTTOM"'; osec1 = '"LEFT"'; osec2 = '"RIGHT"'; csx = 0; csy = -tonumber(desc.iconspy); csxm = tonumber(desc.iconspx); csym = 0;
	elseif desc.orientation == "UP" then
		opri1 = '"BOTTOM"'; opri2 = '"TOP"'; osec1 = '"LEFT"'; osec2 = '"RIGHT"'; csx = 0; csy = tonumber(desc.iconspy); csxm = tonumber(desc.iconspx); csym = 0;
	end
	if desc.rows == 1 then 
		-- Single-row code
		createCode = createCode .. [[frame.]] .. objname .. [[[i]:SetPoint(]] .. opri1 .. [[, frame.]] .. objname .. [[[i-1], ]] .. opri2 .. [[, ]] .. csx .. [[, ]] .. csy .. [[);]];
	else 
		-- Multi-row code
		createCode = createCode .. [[
	if( VFL.mmod ( i + ]] .. desc.rows .. [[-1,]] .. desc.rows .. [[)  == 0 ) then 
	    frame.]] .. objname .. [[[i]:SetPoint(]] .. osec1 .. [[, frame.]] .. objname .. "[i-" .. desc.rows .. [[], ]] .. osec2 .. [[, ]] .. csxm .. [[, ]] .. csym .. [[);
	else 
	    frame.]] .. objname .. [[[i]:SetPoint(]] .. opri1 .. [[, frame.]] .. objname .. "[i-1], " .. opri2 .. [[, ]] .. csx .. [[, ]] .. csy .. [[);
	end
]];
	end
		createCode = createCode .. [[
end
]];
	return createCode;
end

---------------------------------------------
-- Factored-out oft-repeated fragments
---------------------------------------------

function RDXUI.GenWidthHeightPortion(ui, desc, state)
	local ed_width = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Width"), state, "StaticVar_");
	if desc and desc.w then ed_width:SetSelection(desc.w); end
	
	local ed_height = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Height"), state, "StaticVar_");
	if desc and desc.h then ed_height:SetSelection(desc.h); end
	
	return ed_width, ed_height;
end

function RDXUI.GenNameWidthHeightPortion(ui, desc, state)
	local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
	ed_name:SetText(VFLI.i18n("Name"));
	ed_name.editBox:SetText(desc.name);
	ui:InsertFrame(ed_name);
	
	local ed_width = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Width"), state, "StaticVar_");
	if desc and desc.w then ed_width:SetSelection(desc.w); end
	
	local ed_height = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Height"), state, "StaticVar_");
	if desc and desc.h then ed_height:SetSelection(desc.h); end

	return ed_name, ed_width, ed_height;
end

--- Check to see if an object name is a valid name (alphanumeric/underscores only, 15 chars or less)
-- and is not previously taken on a state. Designed for use in ExposeFeature methods
function RDXUI.UFFrameCheck_Proto(prefix, desc, state, errs)
	if desc and desc.name then
		if(desc.name == "Base") then
			VFL.AddError(errs, VFLI.i18n("No object can be named 'Base.'"));
			return nil;
		end
		if not RDXDB.IsValidFileName(desc.name) then
			VFL.AddError(errs, VFLI.i18n("Object names must be alphanumeric."));
			return nil;
		end
		if state:Slot(prefix .. desc.name) then
			VFL.AddError(errs, VFLI.i18n("Duplicate object name '") .. desc.name .. "'.");
			return nil;
		end
		return true;
	else
		VFL.AddError(errs, VFLI.i18n("Bad or missing object name."));
		return nil;
	end
end

function RDXUI.UFFrameCheck(prefix)
	return function(desc, state, errs)
		return RDXUI.UFFrameCheck_Proto(prefix, desc, state, errs);
	end;
end

RDXUI.UFObjCheck = RDXUI.UFFrameCheck("Obj_");

--- Check an anchor descriptor against a state to make sure we're anchoring to something that exists.
function RDXUI.UFAnchorCheck(anchor, state, errs)
	if not anchor then
		VFL.AddError(errs, VFLI.i18n("Invalid anchor definition."));
		return nil;
	end
	if (not anchor.lp) or (not anchor.rp) or (not anchor.dx) or (not anchor.dy) then
		VFL.AddError(errs, VFLI.i18n("Missing anchor layout parameters."));
		return nil;
	end
	if (not anchor.af) then
		VFL.AddError(errs, VFLI.i18n("Missing anchor target frame.")); return nil;
	end
	if (anchor.af == "Base") or (state:Slot("Frame_" .. anchor.af)) or (state:Slot("Text_" .. anchor.af)) or (state:Slot("Texture_" .. anchor.af)) then return true; end
	if state:Slot(anchor.af) then return true; end
	VFL.AddError(errs, VFLI.i18n("Anchor target frame does not exist.")); return nil;
end

--- Check a frame owner exist.
function RDXUI.UFOwnerCheck(owner, state, errs, allowBase)
	if not owner then
		VFL.AddError(errs, VFLI.i18n("Invalid owner definition."));
		return nil;
	end
	if allowBase and (owner == "Base") then return true; end
	--if (owner == "Base") then return true; end
	if (state:Slot("Frame_" .. owner)) or (state:Slot("Subframe_" .. owner)) then return true; end
	VFL.AddError(errs, VFLI.i18n("Owner frame does not exist.")); return nil;
end

function RDXUI.UFLayoutCheck(desc, state, errs)
	if not desc.w then VFL.AddError(errs, VFLI.i18n("No width")); return nil; end
	if not desc.h then VFL.AddError(errs, VFLI.i18n("No height")); return nil; end
	return true;
end

-----------------------------
-- Game Tooltip
-----------------------------

function __RDX_GetGameTooltipType(str)
	if not str or type(str) ~= "string" then return nil; end
	local _, _, _, b = string.find(str, "^(.*)_(.*)$");
	if b then
		return "__RDX_" .. b .. "OnEnter";
	else
		return "nil";
	end
end

function __RDX_InventoryItemOnEnter(self)
	if self.gtid then
		GameTooltip:SetOwner(self, "ANCHOR_NONE");
		GameTooltip:SetPoint("TOPLEFT", self, "RIGHT");
		GameTooltip:SetInventoryItem("player", self.gtid);
		GameTooltip:Show();
	end
end

function __RDX_TotemOnEnter(self)
	if self.gtid then
		GameTooltip:SetOwner(self, "ANCHOR_NONE");
		GameTooltip:SetPoint("TOPLEFT", self, "RIGHT");
		GameTooltip:SetTotem(self.gtid);
		GameTooltip:Show();
	end
end

function __RDX_OnLeave()
	GameTooltip:Hide();
end

----------------------------------------------------
-- all windows must have these properties
----------------------------------------------------

function RDXUI.defaultUIFromDescriptor(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		local ft = desc.feature;
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Main properties")));
		local er, dd_windowId;
		if ft == "desktop_window" then
			er = VFLUI.EmbedRight(ui, VFLI.i18n("Window:"));
			dd_windowId = VFLUI.Dropdown:new(er, RDXUI.fnListWindows, nil, nil, nil, 30);
			dd_windowId:SetWidth(250); dd_windowId:Show();
			if desc and desc.name then 
				dd_windowId:SetSelection(desc.name); 
			end
			er:EmbedChild(dd_windowId); er:Show();
			ui:InsertFrame(er);
		elseif ft == "desktop_statuswindow" then
			er = VFLUI.EmbedRight(ui, VFLI.i18n("Status Window:"));
			dd_windowId = VFLUI.Dropdown:new(er, RDXUI.fnListStatusWindows, nil, nil, nil, 30);
			dd_windowId:SetWidth(250); dd_windowId:Show();
			if desc and desc.name then 
				dd_windowId:SetSelection(desc.name); 
			end
			er:EmbedChild(dd_windowId); er:Show();
			ui:InsertFrame(er);
		elseif ft == "desktop_windowless" then
			er = VFLUI.EmbedRight(ui, VFLI.i18n("Registered Window:"));
			dd_windowId = VFLUI.Dropdown:new(er, RDXUI.fnListWindowsLess, nil, nil, nil, 30);
			dd_windowId:SetWidth(250); dd_windowId:Show();
			if desc and desc.name then 
				dd_windowId:SetSelection(desc.name); 
			end
			er:EmbedChild(dd_windowId); er:Show();
			ui:InsertFrame(er);
		end
		
		local chkopen = VFLUI.Checkbox:new(ui); chkopen:Show();
		chkopen:SetText(VFLI.i18n("Open this element"));
		if desc and desc.open then chkopen:SetChecked(true); else chkopen:SetChecked(); end
		ui:InsertFrame(chkopen);
		
		local txtwindowsbar = VFLUI.SimpleText:new(ui, 1, 200); txtwindowsbar:Show();
		local str = "";
		if desc and desc.windowsbar then str="Info: In windows bar"; else str="Info:" end
		txtwindowsbar:SetText(str);
		ui:InsertFrame(txtwindowsbar);
		
		--local txtopen = VFLUI.SimpleText:new(ui, 1, 200); txtopen:Show();
		--local str = "";
		--if desc and desc.open then str="Window is shown on your desktop"; else str="Window is hidden in your desktop" end
		--txtopen:SetText(str);
		--ui:InsertFrame(txtopen);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Layout properties")));
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 50); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale:"));
		if desc and desc.scale then ed_scale.editBox:SetText(desc.scale); end
		ui:InsertFrame(ed_scale);
		
		local ed_alpha = VFLUI.LabeledEdit:new(ui, 50); ed_alpha:Show();
		ed_alpha:SetText(VFLI.i18n("Alpha: "));
		if desc and desc.alpha then ed_alpha.editBox:SetText(desc.alpha); end
		ui:InsertFrame(ed_alpha);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Stratum: "));
		local dd_strataType = VFLUI.Dropdown:new(er, RDXUI.DesktopStrataFunction);
		dd_strataType:SetWidth(150); dd_strataType:Show();
		if desc and desc.strata then 
			dd_strataType:SetSelection(desc.strata); 
		else
			dd_strataType:SetSelection("MEDIUM");
		end
		er:EmbedChild(dd_strataType); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Anchor:"));
		local dd_anchorType = VFLUI.Dropdown:new(er, RDXUI.DesktopAnchorFunction);
		dd_anchorType:SetWidth(150); dd_anchorType:Show();
		if desc and desc.ap then 
			dd_anchorType:SetSelection(desc.ap); 
		else
			dd_anchorType:SetSelection("TOPLEFT");
		end
		er:EmbedChild(dd_anchorType); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Dock properties")));
		
		local chkCTS = VFLUI.Checkbox:new(ui); chkCTS:Show();
		chkCTS:SetText(VFLI.i18n("Clamp to screen (only if undocked)"));
		if desc and desc.cts then chkCTS:SetChecked(true); else chkCTS:SetChecked(); end
		ui:InsertFrame(chkCTS);
		
		local chkNoAttach = VFLUI.Checkbox:new(ui); chkNoAttach:Show();
		chkNoAttach:SetText(VFLI.i18n("Prevent this window from attaching to others"));
		if desc and desc.noattach then chkNoAttach:SetChecked(true); else chkNoAttach:SetChecked(); end
		ui:InsertFrame(chkNoAttach);
		
		local chkNoHold = VFLUI.Checkbox:new(ui); chkNoHold:Show();
		chkNoHold:SetText(VFLI.i18n("Prevent other windows from attaching to this one"));
		if desc and desc.nohold then chkNoHold:SetChecked(true); else chkNoHold:SetChecked(); end
		ui:InsertFrame(chkNoHold);
		
		local n = 2; 
		if desk and desk.dock then n = #desk.dock + 1 end
		if desk and desk.dgp then n = n + 1 end
		local txtCurDock = VFLUI.SimpleText:new(ui, n, 200); txtCurDock:Show();
		local str = VFLI.i18n("Current Docks:\n");
		if desc.dock then
			for k,v in pairs(desc.dock) do
				str = str .. k .. ": " .. v.id .. "\n";
			end
		else
			str = str .. "(none)\n";
		end
		if desc.dgp then str = str .. "This element is parent dock"; end
		
		txtCurDock:SetText(str);
		ui:InsertFrame(txtCurDock);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Position properties")));
		
		local ed_leftpos = VFLUI.LabeledEdit:new(ui, 50); ed_leftpos:Show();
		ed_leftpos:SetText(VFLI.i18n("Left:"));
		if desc and desc.l then ed_leftpos.editBox:SetText(desc.l); end
		ui:InsertFrame(ed_leftpos);
		
		local ed_toppos = VFLUI.LabeledEdit:new(ui, 50); ed_toppos:Show();
		ed_toppos:SetText(VFLI.i18n("Top:"));
		if desc and desc.t then ed_toppos.editBox:SetText(desc.t); end
		ui:InsertFrame(ed_toppos);
		
		local ed_rightpos = VFLUI.LabeledEdit:new(ui, 50); ed_rightpos:Show();
		ed_rightpos:SetText(VFLI.i18n("Right:"));
		if desc and desc.r then ed_rightpos.editBox:SetText(desc.r); end
		ui:InsertFrame(ed_rightpos);
		
		local ed_bottompos = VFLUI.LabeledEdit:new(ui, 50); ed_bottompos:Show();
		ed_bottompos:SetText(VFLI.i18n("Bottom:"));
		if desc and desc.b then ed_bottompos.editBox:SetText(desc.b); end
		ui:InsertFrame(ed_bottompos);
		
		function ui:GetDescriptor()
			local nname = ft;
			if ft == "desktop_window" or ft == "desktop_statuswindow" or ft == "desktop_windowless"  then
				nname = dd_windowId:GetSelection();
			end
			local ll = ed_leftpos.editBox:GetNumber();
			if ll == 0 then ll = nil; end
			local ddock, dgp = nil, nil;
			if chkopen:GetChecked() then
				ddock = desc.dock;
				ddgp = desc.dgp;
			end
			
			return {
				feature = ft;
				name = nname;
				open = chkopen:GetChecked();
				scale = VFL.clamp(ed_scale.editBox:GetNumber(), 0.1, 2);
				alpha = VFL.clamp(ed_alpha.editBox:GetNumber(), 0.1, 2);
				strata = dd_strataType:GetSelection();
				ap = dd_anchorType:GetSelection();
				cts = chkCTS:GetChecked();
				noattach = chkNoAttach:GetChecked();
				nohold = chkNoHold:GetChecked();
				dock = ddock;
				dgp = ddgp;
				r = ed_rightpos.editBox:GetNumber();
				b = ed_bottompos.editBox:GetNumber();
				t = ed_toppos.editBox:GetNumber();
				l = ll;
				windowsbar = desc.windowsbar;
			};
		end
		
		return ui;
end

---------------------------------
-- Check
---------------------------------

-- Check to see if an object name is a valid name and is not previously taken on a state. 
-- Designed for use in ExposeFeature methods
function __DesktopCheck_Name(desc, state, errs)
	if desc and desc.name then
		if state:Slot(desc.name) then
			VFL.AddError(errs, VFLI.i18n("Duplicate object name '") .. desc.name .. "'.");
			return nil;
		end
		state:AddSlot(desc.name);
		return true;
	else
		VFL.AddError(errs, VFLI.i18n("Bad or missing object name."));
		return nil;
	end
end

-----------------------------------------------------
-- UnitFrame rendering helpers.
-----------------------------------------------------
-- Set the value and colors of a status bar appropriately.
function RDX.SetStatusBar(bar, val, color, fadeColor)
	if fadeColor then
		tempcolor:blend(fadeColor, color, val);
		bar:SetStatusBarColor(tempcolor.r, tempcolor.g, tempcolor.b);
	else
		bar:SetStatusBarColor(color.r, color.g, color.b);
	end
	bar:SetValue(val);
end

--- Subroutine to check a variable name for validity.
local reservedWords = {};
reservedWords["frame"] = true;
reservedWords["unit"] = true;
reservedWords["uid"] = true;
reservedWords["true"] =  true;
reservedWords["false"] = true;
reservedWords["nil"] = true;

function RDX._CheckVariableNameValidity(name, state, errs)
	if not name or not type(name) == "string" then VFL.AddError(errs, VFLI.i18n("Missing variable name.")); return nil; end
	if type(name) == "number" then VFL.AddError(errs, VFLI.i18n("Variable name must be alpha.")); return nil; end
	if not string.find(name, "^%w+$") then
		VFL.AddError(errs, VFLI.i18n("Invalid characters in variable name")); return nil;
	end
	if string.sub(name,1,1) == "_" then VFL.AddError(errs, VFLI.i18n("Name may not begin with an underscore.")); return nil; end
	if reservedWords[name] then VFL.AddError(errs, VFLI.i18n("The name '") .. name .. VFLI.i18n("' is a reserved word.")); return nil; end
	if state:Slot("Var_" .. name) then
		VFL.AddError(errs, VFLI.i18n("The name '") .. name .. VFLI.i18n("' is already in use.")); return nil; 
	end
	return true;
end

function RDX._AddReservedVariableName(name)
	reservedWords[name] = true;
end
