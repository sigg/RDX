-- AuraInfo.lua
-- OpenRDX
-- Sigg

-------------------------------------
-- Buff Debuff Info by Sigg Rashgarroth eu
-------------------------------------

local i, name, icon, apps, dur, expirationTime, caster, fdur, timeleft, possible, start, bn;

function __rdxloadbuff(uid, buffname, auracache, playerauras, othersauras, petauras, targetauras, focusauras)
	i, name, icon, apps, dur, expirationTime, caster, fdur, timeleft, possible, start, bn = 1, nil, "", nil, nil, nil, nil, 0, 0, false, 0, nil;
	if type(buffname) == "number" then
		bn = GetSpellInfo(buffname);
		if not bn then bn = buffname; end
	else
		bn = buffname;
	end
	name, _, icon, apps, _, dur, expirationTime, caster, isStealable = UnitAura(uid, bn);
	if (name == bn) then
		possible = true;
		if dur and dur > 0 then
			fdur = dur;
			timeleft = expirationTime - GetTime();
			start = expirationTime - dur;
		else
			fdur = 0;
			timeleft = 0;
			start = 0;
		end
		if (playerauras and caster ~= "player") or (othersauras and caster == "player") or (petauras and caster ~= "pet") or (targetauras and caster ~= "target") or (focusauras and caster ~= "focus") then
			fdur = 0;
			timeleft = 0;
			start = 0;
			possible = false;
		end
	end
	return possible, apps, icon, start, fdur, caster, timeleft;
end

function __rdxloaddebuff(uid, debuffname, auracache, playerauras, othersauras, petauras, targetauras, focusauras)
	i, name, icon, apps, dur, expirationTime, caster, fdur, timeleft, possible, start, bn = 1, nil, "", nil, nil, nil, nil, 0, 0, false, 0, nil;
	if type(debuffname) == "number" then
		bn = GetSpellInfo(debuffname);
		if not bn then bn = debuffname; end
	else
		bn = debuffname;
	end
	name, _, icon, apps, _, dur, expirationTime, caster, isStealable = UnitDebuff(uid, bn);
	if (name == bn) then
		possible = true;
		if dur and dur > 0 then
			fdur = dur;
			start = expirationTime - dur;
			timeleft = expirationTime - GetTime();
		else
			fdur = 0;
			timeleft = 0;
			start = 0;
		end
		if (playerauras and caster ~= "player") or (othersauras and caster == "player") or (petauras and caster ~= "pet") or (targetauras and caster ~= "target") or (focusauras and caster ~= "focus") then
			fdur = 0;
			timeleft = 0;
			start = 0;
			possible = false;
		end
	end
	return possible, apps, icon, start, fdur, caster, timeleft;
end
-----------------------ADD FOR SINESTRA WRACK -------------------------------
function __rdxloadInverseDebuff(uid, debuffname, auracache, playerauras, othersauras, petauras, targetauras, focusauras)
	i, name, icon, apps, dur, expirationTime, caster, fdur, timeleft, possible, start, bn = 1, nil, "", nil, nil, nil, nil, 0, 0, false, 0, nil;
	if type(debuffname) == "number" then
		bn = GetSpellInfo(debuffname);
		if not bn then bn = debuffname; end
	else
		bn = debuffname;
	end
	name, _, icon, apps, _, dur, expirationTime, caster, isStealable = UnitDebuff(uid, bn);
	if (name == bn) then
		possible = true;
		-------- dur = 6
		-------- expirtime = 24856
		-------- start = 24856 - 6 = 24850
		-------- time = 24853 - 24850 =3
		if dur and dur > 0 then
			fdur = dur;
			start = expirationTime - dur;
			timeleft = GetTime() - start;
		else
			fdur = 0;
			ftimeleft = 0;
			start = 0;
		end
	end
	return possible, apps, icon, start, fdur, caster, timeleft;
end

-------------------------------------------------------------------------------
local _types = {
	{ text = "BUFFS" },
	{ text = "DEBUFFS" },
	{ text = "INV_DEBUFFS" },
};
local function _dd_types() return _types; end

RDX.RegisterFeature({
	name = "Variables: Buffs Debuffs Info";
	title = VFLI.i18n("Vars Aura Info");
	category =  VFLI.i18n("Variables");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)		
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if not desc.cd then VFL.AddError(errs, VFLI.i18n( "No aura selected.")); return nil; end
		if not desc.timer1 then desc.timer1 = "0"; end
		if not desc.timer2 then desc.timer2 = "0"; end
		if not desc.color0 then desc.color0 = {r=0,g=0,b=0,a=0}; end
		if not desc.color1 then desc.color1 = {r=1,g=1,b=1,a=1}; end
		if not desc.color2 then desc.color2 = {r=1,g=1,b=1,a=1}; end
		if not desc.color3 then desc.color3 = {r=1,g=1,b=1,a=1}; end
		state:AddSlot("BoolVar_" .. desc.name .."_possible");
		state:AddSlot("TimerVar_" .. desc.name .."_aura");
		state:AddSlot("TextData_" .. desc.name .."_aura_name");
		state:AddSlot("TextData_" .. desc.name .."_aura_stack");
		state:AddSlot("TextData_" .. desc.name .."_time");
		state:AddSlot("NumberVar_" .. desc.name .. "_stack");
		state:AddSlot("ColorVar_" .. desc.name .. "_color");
		--state:AddSlot("TextData_" .. desc.name .."_aura_caster");
		state:AddSlot("TexVar_" .. desc.name .."_icon");
		state:AddSlot("Var_" .. desc.name .. "_timeleft");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local playerauras = "false"; if desc.playerauras then playerauras = "true"; end
		local othersauras = "false"; if desc.othersauras then othersauras = "true"; end
		local petauras = "false"; if desc.petauras then petauras = "true"; end
		local targetauras = "false"; if desc.targetauras then targetauras = "true"; end
		local focusauras = "false"; if desc.focusauras then focusauras = "true"; end
		local loadCode = "__rdxloadbuff";
		local reverse = "true" if desc.reverse then reverse = "false"; end
		
		-- Event hinting.
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = 0; 
		if desc.auraType == "DEBUFFS" then
			mask = mux:GetPaintMask("DEBUFFS");
			mux:Event_UnitMask("UNIT_DEBUFF_*", mask);
			loadCode = "__rdxloaddebuff";
		elseif desc.auraType == "INV_DEBUFFS" then
			mask = mux:GetPaintMask("DEBUFFS");
			mux:Event_UnitMask("UNIT_DEBUFF_*", mask);
			loadCode = "__rdxloadInverseDebuff";
		else
			mask = mux:GetPaintMask("BUFFS");
			mux:Event_UnitMask("UNIT_BUFF_*", mask);
		end
		
		local tcd = nil;
		if type(desc.cd) == "number" then
			tcd = desc.cd;
		else
			tcd = [["]] .. desc.cd .. [["]];
		end
		
		local winpath = state:GetContainingWindowState():GetSlotValue("Path");
		local md = RDXDB.GetObjectData(winpath);
		local auracache = "false"; if md and RDXDB.HasFeature(md.data, "AuraCache") then auracache = "true"; end
		
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[_possible, ]] .. desc.name .. [[_stack, ]] .. desc.name .. [[_icon , ]] .. desc.name .. [[_aura_start, ]] .. desc.name .. [[_aura_duration, ]] .. desc.name .. [[_caster, ]] .. desc.name .. [[_timeleft = ]] .. loadCode .. [[(uid, ]] .. tcd .. [[, ]] .. auracache .. [[, ]] .. playerauras .. [[, ]] .. othersauras .. [[, ]] .. petauras .. [[, ]] .. targetauras .. [[, ]] .. focusauras .. [[);
local ]] .. desc.name .. [[_aura_name = "";
local ]] .. desc.name .. [[_aura_stack = 0;
local ]] .. desc.name .. [[_aura_caster = "";
local ]] .. desc.name .. [[_color = ]] .. Serialize(desc.color0) .. [[;
if not ]] .. reverse .. [[ then
	]] .. desc.name .. [[_possible = not ]] .. desc.name .. [[_possible;
end
if ]] .. desc.name .. [[_possible then
	]] .. desc.name .. [[_aura_name = "]] .. desc.name .. [[";
end
if not ]] .. desc.name .. [[_stack then ]] .. desc.name .. [[_stack = 0; end
if ]] .. desc.name .. [[_stack > 0 then
	]] .. desc.name .. [[_aura_stack = ]] .. desc.name .. [[_stack;
end
--if ]] .. desc.name .. [[_caster and ]] .. desc.name .. [[_caster ~= "" then
--	local unitu = RDXDAL._ReallyFastProject(]] .. desc.name .. [[_caster);
--	if unitu then
--		]] .. desc.name .. [[_aura_caster = unitu:GetName();
--	else
--		]] .. desc.name .. [[_aura_caster = ]] .. desc.name .. [[_caster;
--	end
--end

if ]] .. desc.name .. [[_timeleft then ]] .. desc.name .. [[_time = strformat("%0.f",]] .. desc.name .. [[_timeleft); end
if not ]] .. desc.name .. [[_timeleft then ]] .. desc.name .. [[_timeleft = 0; end
if ]] .. desc.name .. [[_timeleft < ]] .. desc.timer1 .. [[ and ]] .. desc.name .. [[_timeleft > 0 then
	]] .. desc.name .. [[_color = ]] .. Serialize(desc.color1) .. [[;
elseif (]] .. desc.name .. [[_timeleft < ]] .. desc.timer2 .. [[ and ]] .. desc.name .. [[_timeleft >= ]] .. desc.timer1 .. [[) then
	]] .. desc.name .. [[_color = ]] .. Serialize(desc.color2) .. [[;
elseif ]] .. desc.name .. [[_timeleft > ]] .. desc.timer2 .. [[ then
	]] .. desc.name .. [[_color = ]] .. Serialize(desc.color3) .. [[;
elseif ]] .. desc.name .. [[_timeleft == 0 then
	]] .. desc.name .. [[_color =  ]] .. Serialize(desc.color0) .. [[;
else
	]] .. desc.name .. [[_color =  ]] .. Serialize(desc.color0) .. [[; 
end

]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local iname = VFLUI.LabeledEdit:new(ui, 100); 
		iname:Show();
		iname:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then iname.editBox:SetText(desc.name); end
		ui:InsertFrame(iname);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Aura Type:"));
		local dd_auraType = VFLUI.Dropdown:new(er, _dd_types);
		dd_auraType:SetWidth(150); dd_auraType:Show();
		if desc and desc.auraType then 
			dd_auraType:SetSelection(desc.auraType); 
		else
			dd_auraType:SetSelection("BUFFS");
		end
		er:EmbedChild(dd_auraType); er:Show();
		ui:InsertFrame(er);
		
		local cd = VFLUI.LabeledEdit:new(ui, 150);
		cd:SetText(VFLI.i18n("Aura Name"));
		cd:Show();
		if desc and desc.cd then 
			if type(desc.cd) == "number" then
				local name = GetSpellInfo(desc.cd);
				cd.editBox:SetText(name);
			else
				cd.editBox:SetText(desc.cd);
			end
		end
		ui:InsertFrame(cd);
		
		local btn = VFLUI.Button:new(cd);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", cd.editBox, "LEFT"); 
		btn:Show();
		if dd_auraType:GetSelection() == "BUFFS" then 
			btn:SetScript("OnClick", function()
				RDXDAL.AuraCachePopup(RDXDAL._GetBuffCache(), function(x) 
					if x then cd.editBox:SetText(x.properName); end
				end, btn, "CENTER");
			end);
		else
			btn:SetScript("OnClick", function()
				RDXDAL.AuraCachePopup(RDXDAL._GetDebuffCache(), function(x) 
					if x then cd.editBox:SetText(x.properName); end
				end, btn, "CENTER");
			end);
		end
		
		------------ Filter
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Filtering")));
		
		local chk_playerauras = VFLUI.Checkbox:new(ui); chk_playerauras:Show();
		chk_playerauras:SetText(VFLI.i18n("Filter auras by player"));
		if desc and desc.playerauras then chk_playerauras:SetChecked(true); else chk_playerauras:SetChecked(); end
		ui:InsertFrame(chk_playerauras);
		
		local chk_othersauras = VFLUI.Checkbox:new(ui); chk_othersauras:Show();
		chk_othersauras:SetText(VFLI.i18n("Filter auras by other players"));
		if desc and desc.othersauras then chk_othersauras:SetChecked(true); else chk_othersauras:SetChecked(); end
		ui:InsertFrame(chk_othersauras);

		local chk_petauras = VFLUI.Checkbox:new(ui); chk_petauras:Show();
		chk_petauras:SetText(VFLI.i18n("Filter auras by pet/vehicle"));
		if desc and desc.petauras then chk_petauras:SetChecked(true); else chk_petauras:SetChecked(); end
		ui:InsertFrame(chk_petauras);
		
		local chk_targetauras = VFLUI.Checkbox:new(ui); chk_targetauras:Show();
		chk_targetauras:SetText(VFLI.i18n("Filter auras by target"));
		if desc and desc.targetauras then chk_targetauras:SetChecked(true); else chk_targetauras:SetChecked(); end
		ui:InsertFrame(chk_targetauras);
		
		local chk_focusauras = VFLUI.Checkbox:new(ui); chk_focusauras:Show();
		chk_focusauras:SetText(VFLI.i18n("Filter auras by focus"));
		if desc and desc.focusauras then chk_focusauras:SetChecked(true); else chk_focusauras:SetChecked(); end
		ui:InsertFrame(chk_focusauras);
        
		local chk_reverse = VFLUI.Checkbox:new(ui); chk_reverse:Show();
		chk_reverse:SetText(VFLI.i18n("Reverse filtering (report when NOT possible)"));
		if desc and desc.reverse then chk_reverse:SetChecked(true); else chk_reverse:SetChecked(); end
		ui:InsertFrame(chk_reverse);
		
	
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Color (timer elapsed)")));
-----------------
		local itimer1 = VFLUI.LabeledEdit:new(ui, 100); 
		itimer1:Show();
		itimer1:SetText(VFLI.i18n("First Timer after Application (Color1)"));
		if desc and desc.timer1 then itimer1.editBox:SetText(desc.timer1); end
		ui:InsertFrame(itimer1);
		
		local itimer2 = VFLUI.LabeledEdit:new(ui, 100); 
		itimer2:Show();
		itimer2:SetText(VFLI.i18n(" Second Timer (Color2 & Color3)"));
		if desc and desc.timer2 then itimer2.editBox:SetText(desc.timer2); end
		ui:InsertFrame(itimer2);
		
		--local itimer3 = VFLUI.LabeledEdit:new(ui, 100); 
		--itimer3:Show();
		--itimer3:SetText(VFLI.i18n(" Third Timer ("));
		--if desc and desc.timer3 then itimer3.editBox:SetText(desc.timer3); end
		--ui:InsertFrame(itimer3);
		local color0 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Color0 (Color nothing)"));
		if desc and desc.color0 then color0:SetColor(VFL.explodeRGBA(desc.color0)); end
		
		local color1 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Color1 (Color when elapsed < timer1)"));
		if desc and desc.color1 then color1:SetColor(VFL.explodeRGBA(desc.color1)); end
		
		local color2 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Color2 (Color when timer1 < elapsed < timer2)"));
		if desc and desc.color2 then color2:SetColor(VFL.explodeRGBA(desc.color2)); end
		
		local color3 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Color3 (Color when elapsed > timer2)"));
		if desc and desc.color3 then color3:SetColor(VFL.explodeRGBA(desc.color3)); end
		
	
-----------------
		function ui:GetDescriptor()
			local t = cd.editBox:GetText();
			return {
				feature = "Variables: Buffs Debuffs Info"; 
				name = iname.editBox:GetText();
				auraType = dd_auraType:GetSelection();
				cd = RDXSS.GetSpellIdByLocalName(t) or t;
				playerauras = chk_playerauras:GetChecked();
				othersauras = chk_othersauras:GetChecked();
				petauras = chk_petauras:GetChecked();
				targetauras = chk_targetauras:GetChecked();
				focusauras = chk_focusauras:GetChecked();
				reverse = chk_reverse:GetChecked();
				
				timer1 = itimer1.editBox:GetText();
				timer2 = itimer2.editBox:GetText();
				--timer3 = itimer3.editBox:GetText();
				color0 = color0:GetColor();
				color1 = color1:GetColor();
				color2 = color2:GetColor();
				color3 = color3:GetColor();
				
			};
		end
		
		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variables: Buffs Debuffs Info"; 
		name = "aurai"; auraType = "BUFFS"; 
		
		timer1 = "0"; timer2 = "0"; --timer3 = "0";
		color0 = {r=0,g=0,b=0,a=0}; 
		color1 = {r=1,g=1,b=1,a=1}; 
		color2 = {r=1,g=1,b=1,a=1}; 
		color3 = {r=1,g=1,b=1,a=1};
		
		};
	end;
});
