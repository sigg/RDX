
RDX.RegisterFeature({
	name = "ColorVariable: Role Color";
	title = VFLI.i18n("Color Role");
	category = VFLI.i18n("Variables Colors");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitClosure") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.colornone then VFL.AddError(errs, VFLI.i18n("Missing Color")); return nil; end
		if not desc.colortank then VFL.AddError(errs, VFLI.i18n("Missing Color")); return nil; end
		if not desc.colorheal then VFL.AddError(errs, VFLI.i18n("Missing Color")); return nil; end
		if not desc.colordps then VFL.AddError(errs, VFLI.i18n("Missing Color")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("ColorVar_" .. desc.name);
		state:AddSlot("BoolVar_" .. desc.name .. "_set");
		return true;
	end;
	
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
			local rolecolor_cf = {};
			rolecolor_cf[1] = ]] .. Serialize(desc.colortank) .. [[;
			rolecolor_cf[2] = ]] .. Serialize(desc.colorheal) .. [[;
			rolecolor_cf[3] = ]] .. Serialize(desc.colordps) .. [[;
			rolecolor_cf[4] = ]] .. Serialize(desc.colornone) .. [[;
			]]);
			end);
			state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
            code:AppendCode([[
local ]] .. desc.name .. [[ = rolecolor_cf[1];
_role = UnitGroupRolesAssigned(uid);
  if _role == "TANK" then 
    ]] .. desc.name .. [[ = ]] .. Serialize(desc.colortank) .. [[;
	]] .. desc.name .. [[_set = true;
  elseif _role == "HEALER"  then
    ]] .. desc.name .. [[ = ]] .. Serialize(desc.colorheal) .. [[;
	]] .. desc.name .. [[_set = true;
  elseif _role == "DAMAGER" then
    ]] .. desc.name .. [[ = ]] .. Serialize(desc.colordps) .. [[;
	]] .. desc.name .. [[_set = true;
  elseif _role == "NONE" then
    ]] .. desc.name .. [[ = ]] .. Serialize(desc.colornone) .. [[;
	]] .. desc.name .. [[_set = false;
  else
    ]] .. desc.name .. [[ = ]] .. Serialize(desc.colornone) .. [[;
	]] .. desc.name .. [[_set = false;
  end

]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local colornone = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("None Color"));
		if desc and desc.colornone then colornone:SetColor(VFL.explodeRGBA(desc.colornone)); end
		
		local colortank = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Tank Color"));
		if desc and desc.colortank then colortank:SetColor(VFL.explodeRGBA(desc.colortank)); end
		
		local colorheal = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Healer Color"));
		if desc and desc.colorheal then colorheal:SetColor(VFL.explodeRGBA(desc.colorheal)); end
		
		local colordps = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Dps Color"));
		if desc and desc.colordps then colordps:SetColor(VFL.explodeRGBA(desc.colordps)); end

		function ui:GetDescriptor()
			return {
				feature = "ColorVariable: Role Color"; name = name.editBox:GetText();
				colornone = colornone:GetColor();
				colortank = colortank:GetColor();
				colorheal = colorheal:GetColor();
				colordps = colordps:GetColor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 	feature = "ColorVariable: Role Color"; 
					name = "roleColor"; 
					colornone = {r=1,g=1,b=1,a=1};
					colortank = {r=0,g=0,b=1,a=1};
					colorheal = {r=0,g=1,b=0,a=1};
					colordps = {r=1,g=0,b=0,a=1};
					};
	end;
});