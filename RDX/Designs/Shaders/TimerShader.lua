-- FreeTimer.lua
-- RDX - Raid Data Exchange
-- (C)2007 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- A "free timer" that runs independent of unit frame repainting, which allows event-driven
-- timers to work without a Periodic Repaint.

-- Modify by Sigg

FreeTimer = {};
-- Some useful constants
FreeTimer.SB_Hide = "self.bar:Hide();";
FreeTimer.SB_Empty = "self.bar:SetValue(0);";
FreeTimer.SB_Full = "self.bar:SetValue(1);";

local _SBStates = {
	{ text = "Hide" },
	{ text = "Empty" },
	{ text = "Full" },
};
local function _cc_SBStates() return _SBStates; end

FreeTimer.Text_Hide = "self.text:Hide();";
FreeTimer.Text_None = "self.text:SetText('');";
FreeTimer.Text_Unknown = "self.text:SetText('?');";
FreeTimer.Text_Default = "self.text:SetText('');";

FreeTimer.TextInfo_Hide = "self.textInfo:Hide();";
FreeTimer.TextInfo_None = "self.textInfo:SetText('');";
FreeTimer.TextInfo_Unknown = "self.textInfo:SetText('?');";
FreeTimer.TextInfo_Default = "self.textInfo:SetText(self.txt);";

local _TTIStates = {
	{ text = "Hide" },
	{ text = "None" },
	{ text = "Unknown" },
	{ text = "Default" },
};
local function _cc_TTIStates() return _TTIStates; end

FreeTimer.TexIcon_Hide = "self.texIcon:Hide();";
FreeTimer.TexIcon_None = "self.texIcon:SetTexture('');";
FreeTimer.TexIcon_Unknown = "self.texIcon:Show(); self.texIcon:SetTexture('Interface\\InventoryItems\\WoWUnknownItem01.blp');";
FreeTimer.TexIcon_Default = "self.texIcon:Show(); self.texIcon:SetTexture(self.tex);";

local _TEIStates = {
	{ text = "Hide" },
	{ text = "None" },
	{ text = "Unknown" },
	{ text = "Default" },
};
local function _cc_TEIStates() return _TEIStates; end

local function ftSetTimer(self, start, dur)
	self.start = start; 
	self.dur = dur;
	if start and dur then
		self.tl = dur - (GetTime() - start);
	else
		self.tl = 0;
	end
end

local function ftSetData(self, txt, tex)
	self.txt = txt;
	if tex and tex ~= "" then self.tex = tex; end
end

local function ftSetFormula(self, formula)
	self.formula = formula;
end

local function ftSetSBBlendColor(self, sbcolorVar1, sbcolorVar2)
	self.bar:SetColors(sbcolorVar1, sbcolorVar2);
	if not self.t1 then -- fix deaktknight
		self.bar:SetColorTable(sbcolorVar2);
	end
end

local function ftSetVariableColor(self, numcolor)
	if tonumber(numcolor) then self.numcolor = numcolor; end
end

local function ftDestroy(self)
	self.start = nil; self.dur = nil; self.t1 = nil;
	self.txt = nil; self.tex = nil;
	self.numcolor = nil;
	self.blftcolor = nil;
	self.bar = nil; self.SetFormula = nil; self.formula = nil;
	self.text = nil; self.textcolor1 = nil; self.textcolor2 = nil; self.SetTimer = nil;
	self.textInfo = nil; self.texIcon = nil; self.SetData = nil; 
	self.SetVariableColor = nil;
	self.SetSBBlendColor = nil;
end

function FreeTimer.CreateFreeTimerClass(statusBar, textTimer, formula, textFilter, textInfo, texIcon, unknownSB, unknownText, unknownTextInfo, unknownTexIcon, expiredSB, expiredText, expiredTextinfo, expiredTexIcon, showduration, blendcolor, color1, color2, stackFlag, stackMax, sbblendcolor, shaderTL)
	-- Build the onupdate script.
	local shaderscript = "";
	if shaderTL and shaderTL > 0 then shaderscript = "or self.tl > " .. shaderTL; end
	local onUpdate = [[
return function(self)
]];
	onUpdate = onUpdate .. [[
	self.tl = (self.start + self.dur) - GetTime();
	if not self.tl ]] .. shaderscript .. [[ then
]];
	-- "Unknown"/"no timer" case.
	if statusBar then onUpdate = onUpdate .. unknownSB; end
	if textTimer then onUpdate = onUpdate .. unknownText; end
	if textInfo then onUpdate = onUpdate .. unknownTextInfo; end
	if texIcon then onUpdate = onUpdate .. unknownTexIcon; end
	-- End unknown case
	onUpdate = onUpdate .. [[
	  return;
	end
	if self.tl > 0 then
]];
	-- Within-bounds case
	if statusBar then 
		onUpdate = onUpdate .. [[
self.bar:Show(); 
if self.formula then 
	self.bar:SetValue(1 - self.tl/self.dur);
else
	self.bar:SetValue(self.tl/self.dur);
end
]];
	end
	if textTimer then 
		if showduration then onUpdate = onUpdate .. "self.text:SetFormattedText('%s/%s', " .. textFilter .. "(self.tl, self.dur), " .. textFilter .. "(self.dur));";
		else 
			onUpdate = onUpdate .. "self.text:SetText(" .. textFilter .. "(self.tl, self.dur));";
		end
	end
	if textTimer and blendcolor then
		if stackFlag then onUpdate = onUpdate .. "tempcolor:blend(self.textcolor1, self.textcolor2, (self.numcolor - 1)/(" .. stackMax .. " - 1));";
		else onUpdate = onUpdate .. "tempcolor:blend(self.textcolor1, self.textcolor2, self.tl/self.dur);";
		end
		onUpdate = onUpdate .. " self.text:SetTextColor(tempcolor:RGBVector()); "; 
	end
	if textInfo then onUpdate = onUpdate .. "self.textInfo:Show(); self.textInfo:SetText(self.txt);"; end
	if texIcon then onUpdate = onUpdate .. "self.texIcon:Show(); self.texIcon:SetTexture(self.tex);"; end
	-- End within bounds case
	onUpdate = onUpdate .. [[
	else
]];
	-- Expired case
	if statusBar then onUpdate = onUpdate .. expiredSB; end
	if textTimer then onUpdate = onUpdate .. expiredText; end
	if textInfo then onUpdate = onUpdate .. expiredTextinfo; end
	if texIcon then onUpdate = onUpdate .. expiredTexIcon; end
	-- End expired case
	onUpdate = onUpdate .. [[
	end
end;
]];
	local updater = loadstring(onUpdate);
	if updater then updater = updater(); else updater = VFL.Noop; end

	return function(parent, sb, textTimer, textInfo, texIcon, ttcolor1, ttcolor2)
		local f = VFLUI.AcquireFrame("Frame");
		f:SetParent(parent);
		f:Show();
		-- variable
		f.start = 0; f.dur = 0; f.tl = 0;
		f.txt = ""; f.tex = "";
		f.formula = "self.tl/self.dur";
		f.numcolor = 0;
		-- object and updater
		f.bar = sb; f.SetFormula = ftSetFormula;
		f.text = textTimer; f.textcolor1 = ttcolor1; f.textcolor2 = ttcolor2; f.SetTimer = ftSetTimer;
		f.textInfo = textInfo; f.texIcon = texIcon; f.SetData = ftSetData; f.SetVariableColor = ftSetVariableColor;
		f.SetSBBlendColor = ftSetSBBlendColor;
		f:SetScript("OnUpdate", updater);
		f.Destroy = VFL.hook(ftDestroy, f.Destroy);
		return f;
	end
end

RDX.RegisterFeature({
	name = "free_timer"; version = 1; multiple = true;
	title = VFLI.i18n("StatusBar: Apply Timer"); 
	category = VFLI.i18n("Shaders");
	IsPossible = function(state)
		if not state:HasSlots("DesignFrame", "EmitClosure", "EmitCreate", "EmitPaint", "EmitDestroy") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		local flg = true;
		if not desc.timerVar or desc.timerVar == "" or not state:Slot("TimerVar_" .. desc.timerVar) then VFL.AddError(errs, VFLI.i18n("Missing variable timer.")); flg = nil; end
		if desc.statusBar and desc.statusBar ~= "" and not state:Slot("StatusBar_" .. desc.statusBar) then
			VFL.AddError(errs, VFLI.i18n("Invalid statusbar.")); flg = nil;
		end
		if desc.text and desc.text ~= "" and not state:Slot("Text_" .. desc.text) then
			VFL.AddError(errs, VFLI.i18n("Invalid text.") .. " Timer"); flg = nil;
		end
		if desc.textInfo and desc.textInfo ~= "" and not state:Slot("Text_" .. desc.textInfo) then
			VFL.AddError(errs, VFLI.i18n("Invalid text.") .. " Info"); flg = nil;
		end
		if desc.texIcon and desc.texIcon ~= "" and not state:Slot("Texture_" .. desc.texIcon) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture.")); flg = nil;
		end
		if desc.sbblendcolor then
			if not desc.sbcolorVar1 or desc.sbcolorVar1 == "" or not state:Slot("ColorVar_" .. desc.sbcolorVar1) then
				VFL.AddError(errs, VFLI.i18n("Status Bar Color Variable 1 Invalide")); flg = nil;
			end
			if not desc.sbcolorVar2 or desc.sbcolorVar2 == "" or not state:Slot("ColorVar_" .. desc.sbcolorVar2) then
				VFL.AddError(errs, VFLI.i18n("Status Bar Color Variable 2 Invalide")); flg = nil;
			end
		end
		return flg;
	end;
	ApplyFeature = function(desc, state, errs)
		local objname = "FreeTimer_" .. math.random(10000000); -- Generate a random ID.
		if not desc.countTypeFlag then desc.countTypeFlag = "true"; end
		
		local sb = strtrim(desc.statusBar or "");
		local sbblendcolor = "false"; if desc.sbblendcolor then sbblendcolor = "true"; end
		
		local textTimer = strtrim(desc.text or "");
		local tet = desc.textType or "VFL.Hundredths";
		local blendcolor = "false"; if desc.blendcolor then blendcolor = "true"; end
		if not desc.color1 then desc.color1 = _white; end
		if not desc.color2 then desc.color2 = _white; end
		local showduration = "false"; if desc.showduration then showduration = "true"; end
		local stackFlag, stackVar, stackMax = "false", 0, 0; 
		if desc.stackVar then stackFlag = "true"; stackVar = desc.stackVar or 0; stackMax = desc.stackMax or 0; end
		
		local textInfo = strtrim(desc.textInfo or "");
		local textInfodata = desc.txt or "";
		if textInfodata == "" then textInfodata = "nil"; end
		
		local texIcon = strtrim(desc.texIcon or "");
		local texIcondata = desc.tex or "";
		if texIcondata == "" then texIcondata = "nil"; end
		
		local sbPresent, txtPresent, txtInfoPresent, texIconPresent = "true", "true", "true", "true";
		if sb == "" then sbPresent = "false"; sb = "nil"; else sb = RDXUI.ResolveFrameReference(desc.statusBar); end
		if textTimer == "" then txtPresent = "false"; textTimer = "nil"; else textTimer = RDXUI.ResolveTextReference(desc.text); end
		if textInfo == "" then txtInfoPresent = "false"; textInfo = "nil"; else textInfo = RDXUI.ResolveTextReference(desc.textInfo); end
		if texIcon == "" then texIconPresent = "false"; texIcon = "nil"; else texIcon = RDXUI.ResolveTextureReference(desc.texIcon); end
		
		local TL = desc.TL or "0";
		local sbDS = desc.sbDefaultState or "Hide";
		local sbES = desc.sbExpireState or "Hide";
		local TTIDS = desc.TTIDefaultState or "Hide";
		local TTIES = desc.TTIExpireState or "Hide";
		local TEIDS = desc.TEIDefaultState or "Hide";
		local TEIES = desc.TEIExpireState or "Hide";
		
		--- Closure
		-- Create a free timer class for our frame (this avoids the nasty situation where we have to recompile
		-- the code every time a frame is created.)
		local closureCode = [[
local ftc_]] .. objname .. [[ = FreeTimer.CreateFreeTimerClass(]] .. sbPresent .. [[,]] .. txtPresent .. [[, nil, VFLUI.GetTextTimerTypesString("]] .. tet .. [["), ]] .. txtInfoPresent .. [[, ]] .. texIconPresent .. [[, FreeTimer.SB_]] .. sbDS .. [[, FreeTimer.Text_None, FreeTimer.TextInfo_]] .. TTIDS .. [[, FreeTimer.TexIcon_]] .. TEIDS .. [[, FreeTimer.SB_]] .. sbES .. [[, FreeTimer.Text_None, FreeTimer.TextInfo_]] .. TTIES .. [[, FreeTimer.TexIcon_]] .. TEIES .. [[, ]] .. showduration .. [[,  ]] .. blendcolor .. [[, ]] .. Serialize(desc.color1) .. [[, ]] .. Serialize(desc.color2) .. [[, ]] .. stackFlag .. [[, ]] .. stackMax .. [[, ]] .. sbblendcolor .. [[, ]] .. TL .. [[);
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		--- Creation
		-- The free timer is just a frame with an OnUpdate routine that updates the linked objects.
		local createCode = [[
frame.]] .. objname .. [[ = ftc_]] .. objname .. [[(frame, ]] .. sb .. [[, ]] .. textTimer .. [[, ]] .. textInfo .. [[, ]] .. texIcon .. [[, ]] .. Serialize(desc.color1) .. [[, ]] .. Serialize(desc.color2) .. [[);
]];
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		--- Paint
		local paintCode = [[
frame.]] .. objname .. [[:SetFormula(]] .. desc.countTypeFlag .. [[);
]];
if desc.sbblendcolor then 
		paintCode = paintCode .. [[
frame.]] .. objname .. [[:SetSBBlendColor(]] .. desc.sbcolorVar1 .. [[, ]] .. desc.sbcolorVar2 .. [[);
]];
end
		paintCode = paintCode .. [[
frame.]] .. objname .. [[:SetVariableColor(]] .. stackVar .. [[);
frame.]] .. objname .. [[:SetData(]] .. textInfodata .. [[, ]] .. texIcondata .. [[);
frame.]] .. objname .. [[:SetTimer(]] .. desc.timerVar .. [[_start, ]] .. desc.timerVar .. [[_duration);
]];
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);

		--- Destruction
		local destroyCode = [[
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local timerVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Timer variable"), state, "TimerVar_");
		if desc and desc.timerVar then timerVar:SetSelection(desc.timerVar); end
		
		local countTypeFlag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Count type (true CountUP, false CountDOWN)"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.countTypeFlag then countTypeFlag:SetSelection(desc.countTypeFlag); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Statusbar")));
		
		local statusBar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Statusbar"), state, "StatusBar_");
		if desc and desc.statusBar then statusBar:SetSelection(desc.statusBar); end
		
		local chk_sbblendcolor = VFLUI.Checkbox:new(ui); chk_sbblendcolor:Show();
		chk_sbblendcolor:SetText(VFLI.i18n("Use blend color"));
		if desc and desc.sbblendcolor then chk_sbblendcolor:SetChecked(true); else chk_sbblendcolor:SetChecked(); end
		ui:InsertFrame(chk_sbblendcolor);
		
		local sbcolorVar1 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Empty color variable"), state, "ColorVar_");
		if desc and desc.sbcolorVar1 and type(desc.sbcolorVar1) == "string" then sbcolorVar1:SetSelection(desc.sbcolorVar1); end
		
		local sbcolorVar2 = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Full color variable"), state, "ColorVar_");
		if desc and desc.sbcolorVar2 and type(desc.sbcolorVar2) == "string" then sbcolorVar2:SetSelection(desc.sbcolorVar2); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Timer")));
		
		local text = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Text Timer"), state, "TextCustom_");
		if desc and desc.text then text:SetSelection(desc.text); end
		
		local tt = VFLUI.EmbedRight(ui, VFLI.i18n("Text Timer Type:"));
		local dd_textType = VFLUI.Dropdown:new(tt, VFLUI.TextTypesDropdownFunction);
		dd_textType:SetWidth(200); dd_textType:Show();
		if desc and desc.textType then 
			dd_textType:SetSelection(desc.textType); 
		else
			dd_textType:SetSelection("VFL.Hundredths");
		end
		tt:EmbedChild(dd_textType); tt:Show();
		ui:InsertFrame(tt);
		
		local chk_duration = VFLUI.Checkbox:new(ui); chk_duration:Show();
		chk_duration:SetText(VFLI.i18n("Show max duration"));
		if desc and desc.showduration then chk_duration:SetChecked(true); else chk_duration:SetChecked(); end
		ui:InsertFrame(chk_duration);
		
		local chk_blendcolor = VFLUI.Checkbox:new(ui); chk_blendcolor:Show();
		chk_blendcolor:SetText(VFLI.i18n("Use blend color"));
		if desc and desc.blendcolor then chk_blendcolor:SetChecked(true); else chk_blendcolor:SetChecked(); end
		ui:InsertFrame(chk_blendcolor);
		
		local color1 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Static min color"));
		if desc and desc.color1 then color1:SetColor(VFL.explodeRGBA(desc.color1)); end

		local color2 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Static max color"));
		if desc and desc.color2 then color2:SetColor(VFL.explodeRGBA(desc.color2)); end
		
		local chk_stack = VFLUI.Checkbox:new(ui); chk_stack:Show();
		chk_stack:SetText(VFLI.i18n("Use variable instead of time for blend color"));
		if desc and desc.stack then chk_stack:SetChecked(true); else chk_stack:SetChecked(); end
		ui:InsertFrame(chk_stack);
		
		local var_stackVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Variable number"), state, "Var_");
		if desc and desc.stackVar then var_stackVar:SetSelection(desc.stackVar); end
		
		local ed_stackMax = VFLUI.LabeledEdit:new(ui, 50); ed_stackMax:Show();
		ed_stackMax:SetText(VFLI.i18n("Variable number max "));
		if desc and desc.stackMax then ed_stackMax.editBox:SetText(desc.stackMax); end
		ui:InsertFrame(ed_stackMax);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Text Info (spell name, aura name ...)")));
		
		local textInfo = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Text Info"), state, "TextCustom_");
		if desc and desc.textInfo then textInfo:SetSelection(desc.textInfo); end
		
		local txt = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Text Info data"), state, "TextData_");
		if desc and desc.txt then txt:SetSelection(desc.txt); end
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Icon texture")));
		
		local texIcon = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture Icon"), state, "Texture_");
		if desc and desc.texIcon then texIcon:SetSelection(desc.texIcon); end

		local tex = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture Icon data"), state, "TexVar_");
		if desc and desc.tex then tex:SetSelection(desc.tex); end
		
		----------------------------------------------------------------------------
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Shader")));
		
		local chk_defaultTL = VFLUI.Checkbox:new(ui); chk_defaultTL:Show();
		chk_defaultTL:SetText(VFLI.i18n("Use Timeleft Condition"));
		if desc and desc.defaultTL then chk_defaultTL:SetChecked(true); else chk_defaultTL:SetChecked(); end
		ui:InsertFrame(chk_defaultTL);
		
		local ed_TL = VFLUI.LabeledEdit:new(ui, 50); ed_TL:Show();
		ed_TL:SetText(VFLI.i18n("Show when Timeleft is inferior"));
		if desc and desc.TL then ed_TL.editBox:SetText(desc.TL); else ed_TL.editBox:SetText("0");end
		ui:InsertFrame(ed_TL);
		
		local er_sbDefaultState = VFLUI.EmbedRight(ui, VFLI.i18n("Status Bar Default State:"));
		local dd_sbDefaultState = VFLUI.Dropdown:new(er_sbDefaultState, _cc_SBStates);
		dd_sbDefaultState:SetWidth(200); dd_sbDefaultState:Show();
		if desc and desc.sbDefaultState then 
			dd_sbDefaultState:SetSelection(desc.sbDefaultState); 
		else
			dd_sbDefaultState:SetSelection("Hide");
		end
		er_sbDefaultState:EmbedChild(dd_sbDefaultState); er_sbDefaultState:Show();
		ui:InsertFrame(er_sbDefaultState);
		
		local er_sbExpireState = VFLUI.EmbedRight(ui, VFLI.i18n("Status Bar Shader State:"));
		local dd_sbExpireState = VFLUI.Dropdown:new(er_sbExpireState, _cc_SBStates);
		dd_sbExpireState:SetWidth(200); dd_sbExpireState:Show();
		if desc and desc.sbExpireState then 
			dd_sbExpireState:SetSelection(desc.sbExpireState); 
		else
			dd_sbExpireState:SetSelection("Hide");
		end
		er_sbExpireState:EmbedChild(dd_sbExpireState); er_sbExpireState:Show();
		ui:InsertFrame(er_sbExpireState);
		
		local er_TTIDefaultState = VFLUI.EmbedRight(ui, VFLI.i18n("Text Info Default State:"));
		local dd_TTIDefaultState = VFLUI.Dropdown:new(er_TTIDefaultState, _cc_TTIStates);
		dd_TTIDefaultState:SetWidth(200); dd_TTIDefaultState:Show();
		if desc and desc.TTIDefaultState then 
			dd_TTIDefaultState:SetSelection(desc.TTIDefaultState); 
		else
			dd_TTIDefaultState:SetSelection("Hide");
		end
		er_TTIDefaultState:EmbedChild(dd_TTIDefaultState); er_TTIDefaultState:Show();
		ui:InsertFrame(er_TTIDefaultState);
		
		local er_TTIExpireState = VFLUI.EmbedRight(ui, VFLI.i18n("Text Info Shader State:"));
		local dd_TTIExpireState = VFLUI.Dropdown:new(er_TTIExpireState, _cc_TTIStates);
		dd_TTIExpireState:SetWidth(200); dd_TTIExpireState:Show();
		if desc and desc.TTIExpireState then 
			dd_TTIExpireState:SetSelection(desc.TTIExpireState); 
		else
			dd_TTIExpireState:SetSelection("Hide");
		end
		er_TTIExpireState:EmbedChild(dd_TTIExpireState); er_TTIExpireState:Show();
		ui:InsertFrame(er_TTIExpireState);
		
		local er_TEIDefaultState = VFLUI.EmbedRight(ui, VFLI.i18n("Icon Texture Default State:"));
		local dd_TEIDefaultState = VFLUI.Dropdown:new(er_TEIDefaultState, _cc_TEIStates);
		dd_TEIDefaultState:SetWidth(200); dd_TEIDefaultState:Show();
		if desc and desc.TEIDefaultState then 
			dd_TEIDefaultState:SetSelection(desc.TEIDefaultState); 
		else
			dd_TEIDefaultState:SetSelection("Hide");
		end
		er_TEIDefaultState:EmbedChild(dd_TEIDefaultState); er_TEIDefaultState:Show();
		ui:InsertFrame(er_TEIDefaultState);
		
		local er_TEIExpireState = VFLUI.EmbedRight(ui, VFLI.i18n("Icon Texture Shader State:"));
		local dd_TEIExpireState = VFLUI.Dropdown:new(er_TEIExpireState, _cc_TEIStates);
		dd_TEIExpireState:SetWidth(200); dd_TEIExpireState:Show();
		if desc and desc.TEIExpireState then 
			dd_TEIExpireState:SetSelection(desc.TEIExpireState); 
		else
			dd_TEIExpireState:SetSelection("Hide");
		end
		er_TEIExpireState:EmbedChild(dd_TEIExpireState); er_TEIExpireState:Show();
		ui:InsertFrame(er_TEIExpireState);

		function ui:GetDescriptor()
			local ssbcolor1, ssbcolor2, scolor1, scolor2, sstack, sstackVar, sstackMax, sTL = nil, nil, nil, nil, nil, nil, nil, 0;
			if chk_sbblendcolor:GetChecked() then
				ssbcolor1 = strtrim(sbcolorVar1:GetSelection() or ""); 
				ssbcolor2 = strtrim(sbcolorVar2:GetSelection() or "");
				if ssbcolor1 == "" then ssbcolor1 = nil; end
				if ssbcolor2 == "" then ssbcolor2 = nil; end
			end
			if chk_blendcolor:GetChecked() then
				scolor1 = color1:GetColor(); scolor2 = color2:GetColor();
				sstack = chk_stack:GetChecked();
				if chk_stack:GetChecked() then
					sstackVar = var_stackVar:GetSelection();
					sstackMax = VFL.clamp(ed_stackMax.editBox:GetNumber(), 1, 20);
				end
			end
			if chk_defaultTL:GetChecked() then
				sTL = ed_TL.editBox:GetNumber();
			end
			return {
				feature = "free_timer"; version = 1;
				timerVar = timerVar:GetSelection();
				countTypeFlag = countTypeFlag:GetSelection();
				statusBar = statusBar:GetSelection();
				sbblendcolor = chk_sbblendcolor:GetChecked();
				sbcolorVar1 = ssbcolor1; sbcolorVar2 = ssbcolor2;
				text = text:GetSelection();
				--cflag = cflag:GetSelection();
				textType = dd_textType:GetSelection();
				showduration = chk_duration:GetChecked();
				blendcolor = chk_blendcolor:GetChecked();
				color1 = scolor1; color2 = scolor2;
				stack = sstack;
				stackVar = sstackVar;
				stackMax = sstackMax;
				textInfo = textInfo:GetSelection(); -- frame
				txt =  txt:GetSelection(); -- data
				texIcon = texIcon:GetSelection(); -- texture
				tex = tex:GetSelection(); -- data
				
				defaultTL = chk_defaultTL:GetChecked();
				TL = sTL;
				
				sbDefaultState = dd_sbDefaultState:GetSelection();
				TTIDefaultState = dd_TTIDefaultState:GetSelection();
				TEIDefaultState = dd_TEIDefaultState:GetSelection();
				
				sbExpireState = dd_sbExpireState:GetSelection();
				TTIExpireState = dd_TTIExpireState:GetSelection();
				TEIExpireState = dd_TEIExpireState:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "free_timer"; version = 1; countTypeFlag = "true";
		};
	end;
});

