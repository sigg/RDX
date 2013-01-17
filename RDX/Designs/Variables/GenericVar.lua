-- VariablesGeneric.lua
-- OpenRDX

--------------------------
-- Variable Generic
--------------------------
local vartypes = {
	{ text = "Var" },
	{ text = "BoolVar" },
	{ text = "FracVar" },
	{ text = "TimerVar" },
	{ text = "TexVar" },
	{ text = "TextData" },
	{ text = "ColorVar" }
};
local function vtOnBuild() return vartypes; end

RDX.RegisterFeature({
	name = "var_scripted"; 
	title = VFLI.i18n("Vars Scripted"); 
	category = VFLI.i18n("Variables");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		state:AddSlot("Var_".. desc.name);
		state:AddSlot(desc.vartype .. "_" .. desc.name);
		if desc.vartype == "TimerVar" then
			state:AddSlot("TextData_" .. desc.name .. "_text");
			state:AddSlot("TexVar_" .. desc.name .. "_tex");
			state:AddSlot("BoolVar_" .. desc.name .. "_bool");
			state:AddSlot("NumberVar_" .. desc.name .. "_number");
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code, state)
			code:AppendCode(desc.editor);
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux, mask = wstate:GetSlotValue("Multiplexer"), 0;
			if desc.flags then
				mask = mux:GetPaintMask("FLAGS");
				mux:Event_UnitMask("UNIT_FLAGS", mask);
			end
			if desc.target then
				mask = mux:GetPaintMask("TARGET");
				mux:Event_UnitMask("UNIT_TARGET", mask);
			end
			if desc.ranged then
				mask = mux:GetPaintMask("RANGED");
				mux:Event_UnitMask("UNIT_RANGED", mask);
			end
			if desc.xp then
				mask = mux:GetPaintMask("XP_UPDATE");
				mux:Event_UnitMask("UNIT_XP_UPDATE", mask);
			end
			if desc.health then
				mask = mux:GetPaintMask("HEALTH");
				mux:Event_UnitMask("UNIT_HEALTH", mask);
			end
			if desc.power then
				mask = mux:GetPaintMask("POWER");
				mux:Event_UnitMask("UNIT_POWER", mask);
			end
			if desc.hardware then
				mask = mux:GetPaintMask("HARDWARE");
				mux:Event_UnitMask("MODIFIER_STATE_CHANGED", mask);
			end
			if desc.debuff then
				mask = mux:GetPaintMask("DEBUFFS");
				mux:Event_UnitMask("UNIT_DEBUFF_*", mask);
			end
			if desc.buff then
				mask = mux:GetPaintMask("BUFFS");
				mux:Event_UnitMask("UNIT_BUFF_*", mask);
			end
		end
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local name = VFLUI.LabeledEdit:new(ui, 100); 
		name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Variable Type:"));
		local dd_vartype = VFLUI.Dropdown:new(er, vtOnBuild);
		dd_vartype:SetWidth(100); dd_vartype:Show();
		if desc and desc.vartype then 
			dd_vartype:SetSelection(desc.vartype); 
		else
			dd_vartype:SetSelection("Var");
		end
		er:EmbedChild(dd_vartype); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Script")));
		
		local editor = VFLUI.TextEditor:new(ui, "LuaEditBox");
		editor:SetHeight(200); editor:Show();
		editor:SetText(desc.editor or "");
		editor:GetEditWidget():SetFocus();
		ui:InsertFrame(editor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Event listener")));
		
		local chk_flags = VFLUI.Checkbox:new(ui); chk_flags:Show();
		chk_flags:SetText(VFLI.i18n("Flags event"));
		if desc and desc.flags then chk_flags:SetChecked(true); else chk_flags:SetChecked(); end
		ui:InsertFrame(chk_flags);
		
		local chk_ranged = VFLUI.Checkbox:new(ui); chk_ranged:Show();
		chk_ranged:SetText(VFLI.i18n("Range event"));
		if desc and desc.ranged then chk_ranged:SetChecked(true); else chk_ranged:SetChecked(); end
		ui:InsertFrame(chk_ranged);
		
		local chk_xp = VFLUI.Checkbox:new(ui); chk_xp:Show();
		chk_xp:SetText(VFLI.i18n("XP event"));
		if desc and desc.xp then chk_xp:SetChecked(true); else chk_xp:SetChecked(); end
		ui:InsertFrame(chk_xp);
		
		local chk_target = VFLUI.Checkbox:new(ui); chk_target:Show();
		chk_target:SetText(VFLI.i18n("Target event"));
		if desc and desc.target then chk_target:SetChecked(true); else chk_target:SetChecked(); end
		ui:InsertFrame(chk_target);
		
		local chk_health = VFLUI.Checkbox:new(ui); chk_health:Show();
		chk_health:SetText(VFLI.i18n("Health event"));
		if desc and desc.health then chk_health:SetChecked(true); else chk_health:SetChecked(); end
		ui:InsertFrame(chk_health);
		
		local chk_power = VFLUI.Checkbox:new(ui); chk_power:Show();
		chk_power:SetText(VFLI.i18n("Power event"));
		if desc and desc.power then chk_power:SetChecked(true); else chk_power:SetChecked(); end
		ui:InsertFrame(chk_power);
		
		local chk_debuff = VFLUI.Checkbox:new(ui); chk_debuff:Show();
		chk_debuff:SetText(VFLI.i18n("Debuff event"));
		if desc and desc.debuff then chk_debuff:SetChecked(true); else chk_debuff:SetChecked(); end
		ui:InsertFrame(chk_debuff);
		
		local chk_buff = VFLUI.Checkbox:new(ui); chk_buff:Show();
		chk_buff:SetText(VFLI.i18n("Buff event"));
		if desc and desc.buff then chk_buff:SetChecked(true); else chk_buff:SetChecked(); end
		ui:InsertFrame(chk_buff);
		
		local chk_hardware = VFLUI.Checkbox:new(ui); chk_hardware:Show();
		chk_hardware:SetText(VFLI.i18n("Hardware event"));
		if desc and desc.hardware then chk_hardware:SetChecked(true); else chk_hardware:SetChecked(); end
		ui:InsertFrame(chk_hardware);
		
		function ui:GetDescriptor()
			return {
				feature = "var_scripted";
				name = name.editBox:GetText();
				vartype = dd_vartype:GetSelection();
				editor = editor:GetText() .. [[ 
]];
				flags = chk_flags:GetChecked();
				ranged = chk_ranged:GetChecked();
				xp = chk_xp:GetChecked();
				target = chk_target:GetChecked();
				health = chk_health:GetChecked();
				power = chk_power:GetChecked();
				debuff = chk_debuff:GetChecked();
				buff = chk_buff:GetChecked();
				hardware = chk_hardware:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "var_scripted";
			name = "varsc1";
			vartype = "Var";
			editor = [[--enter your code here
]];
		};
	end;
});
