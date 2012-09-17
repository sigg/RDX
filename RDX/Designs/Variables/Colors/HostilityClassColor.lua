
-- Aichi Priest
-- Black Fraternity 

RDX.RegisterFeature({
    name = "colorvar_hostility_class";
    title = VFLI.i18n("Color Hostility & Class");
    category = VFLI.i18n("Variables Colors");
    multiple = true;
    IsPossible = function(state)
       if not state:Slot("DesignFrame") then return nil; end
      if not state:Slot("EmitClosure") then return nil; end
        return true;
    end;
    ExposeFeature = function(desc, state, errs)
      if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
      if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
      state:AddSlot("Var_" .. desc.name);
      state:AddSlot("ColorVar_" .. desc.name);
      return true;
    end;
    ApplyFeature = function(desc, state)
    	if not desc.friendlyDeathKnightColor then desc.friendlyDeathKnightColor = {r=0.77, g=0.12, b=0.23,a=1}; end
        state:Attach(state:Slot("EmitClosure"), true, function(code)
            code:AppendCode([[
local hostileColor_class_cf = {};
hostileColor_class_cf[1] = ]] .. Serialize(desc.friendlyColor) .. [[;
hostileColor_class_cf[2] = ]] .. Serialize(desc.neutralColor) .. [[;
hostileColor_class_cf[3] = ]] .. Serialize(desc.hostileColor) .. [[;
hostileColor_class_cf[4] = ]] .. Serialize(desc.friendlyPriestColor) .. [[;
hostileColor_class_cf[5] = ]] .. Serialize(desc.friendlyWarlockColor) .. [[;
hostileColor_class_cf[6] = ]] .. Serialize(desc.friendlyHunterColor) .. [[;
hostileColor_class_cf[7] = ]] .. Serialize(desc.friendlyWarriorColor) .. [[;
hostileColor_class_cf[8] = ]] .. Serialize(desc.friendlyPaladinColor) .. [[;
hostileColor_class_cf[9] = ]] .. Serialize(desc.friendlyMageColor) .. [[;
hostileColor_class_cf[10] = ]] .. Serialize(desc.friendlyDruidColor) .. [[;
hostileColor_class_cf[11] = ]] .. Serialize(desc.friendlyShamanColor) .. [[;
hostileColor_class_cf[12] = ]] .. Serialize(desc.friendlyRogueColor) .. [[;
hostileColor_class_cf[13] = ]] .. Serialize(desc.friendlyDeathKnightColor) .. [[;
]]);
        end);
        state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
            code:AppendCode([[
local ]]  .. desc.name .. [[ = hostileColor_class_cf[1];
_name = unit:GetClassMnemonic();
if UnitIsFriend(uid, "player") and UnitIsPlayer(uid) then
    if _name == "PRIEST" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[4];
    elseif _name == "WARLOCK" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[5];
    elseif _name == "HUNTER" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[6];
    elseif _name == "WARRIOR" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[7];
    elseif _name == "PALADIN" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[8];
    elseif _name == "MAGE" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[9];
    elseif _name == "DRUID" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[10];
    elseif _name == "SHAMAN" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[11];
    elseif _name == "ROGUE" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[12];
    elseif _name == "DEATHKNIGHT" then
        ]] .. desc.name .. [[  = hostileColor_class_cf[13];
    else
        ]] .. desc.name .. [[  = hostileColor_class_cf[1];
    end
elseif UnitIsEnemy(uid, "player") then
        ]] .. desc.name .. [[  = hostileColor_class_cf[3];
else
        ]] .. desc.name .. [[  = hostileColor_class_cf[2];
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
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly color"));
        local swatch_friendlyColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyColor:Show();
        if desc and desc.friendlyColor then swatch_friendlyColor:SetColor(VFL.explodeRGBA(desc.friendlyColor)); end
        er:EmbedChild(swatch_friendlyColor); er:Show();
        ui:InsertFrame(er);

        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Priest color"));
        local swatch_friendlyPriestColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyPriestColor:Show();
        if desc and desc.friendlyPriestColor then swatch_friendlyPriestColor:SetColor(VFL.explodeRGBA(desc.friendlyPriestColor)); end
        er:EmbedChild(swatch_friendlyPriestColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Warlock color"));
        local swatch_friendlyWarlockColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyWarlockColor:Show();
        if desc and desc.friendlyWarlockColor then swatch_friendlyWarlockColor:SetColor(VFL.explodeRGBA(desc.friendlyWarlockColor)); end
        er:EmbedChild(swatch_friendlyWarlockColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Hunter color"));
        local swatch_friendlyHunterColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyHunterColor:Show();
        if desc and desc.friendlyHunterColor then swatch_friendlyHunterColor:SetColor(VFL.explodeRGBA(desc.friendlyHunterColor)); end
        er:EmbedChild(swatch_friendlyHunterColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Warrior color"));
        local swatch_friendlyWarriorColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyWarriorColor:Show();
        if desc and desc.friendlyWarriorColor then swatch_friendlyWarriorColor:SetColor(VFL.explodeRGBA(desc.friendlyWarriorColor)); end
        er:EmbedChild(swatch_friendlyWarriorColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Paladin color"));
        local swatch_friendlyPaladinColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyPaladinColor:Show();
        if desc and desc.friendlyPaladinColor then swatch_friendlyPaladinColor:SetColor(VFL.explodeRGBA(desc.friendlyPaladinColor)); end
        er:EmbedChild(swatch_friendlyPaladinColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Mage color"));
        local swatch_friendlyMageColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyMageColor:Show();
        if desc and desc.friendlyMageColor then swatch_friendlyMageColor:SetColor(VFL.explodeRGBA(desc.friendlyMageColor)); end
        er:EmbedChild(swatch_friendlyMageColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Druid color"));
        local swatch_friendlyDruidColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyDruidColor:Show();
        if desc and desc.friendlyDruidColor then swatch_friendlyDruidColor:SetColor(VFL.explodeRGBA(desc.friendlyDruidColor)); end
        er:EmbedChild(swatch_friendlyDruidColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Shaman color"));
        local swatch_friendlyShamanColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyShamanColor:Show();
        if desc and desc.friendlyShamanColor then swatch_friendlyShamanColor:SetColor(VFL.explodeRGBA(desc.friendlyShamanColor)); end
        er:EmbedChild(swatch_friendlyShamanColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Rogue color"));
        local swatch_friendlyRogueColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyRogueColor:Show();
        if desc and desc.friendlyRogueColor then swatch_friendlyRogueColor:SetColor(VFL.explodeRGBA(desc.friendlyRogueColor)); end
        er:EmbedChild(swatch_friendlyRogueColor); er:Show();
        ui:InsertFrame(er);
	
	local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly Deathknight color"));
        local swatch_friendlyDeathKnightColor = VFLUI.ColorSwatch:new(er);
        swatch_friendlyDeathKnightColor:Show();
        if desc and desc.friendlyDeathKnightColor then swatch_friendlyDeathKnightColor:SetColor(VFL.explodeRGBA(desc.friendlyDeathKnightColor)); end
        er:EmbedChild(swatch_friendlyDeathKnightColor); er:Show();
        ui:InsertFrame(er);
       
        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Neutral color"));
        local swatch_neutralColor = VFLUI.ColorSwatch:new(er);
        swatch_neutralColor:Show();
        if desc and desc.neutralColor then swatch_neutralColor:SetColor(VFL.explodeRGBA(desc.neutralColor)); end
        er:EmbedChild(swatch_neutralColor); er:Show();
        ui:InsertFrame(er);

        local er = VFLUI.EmbedRight(ui, VFLI.i18n("Hostile color"));
        local swatch_hostileColor = VFLUI.ColorSwatch:new(er);
        swatch_hostileColor:Show();
        if desc and desc.hostileColor then swatch_hostileColor:SetColor(VFL.explodeRGBA(desc.hostileColor)); end
        er:EmbedChild(swatch_hostileColor); er:Show();
        ui:InsertFrame(er);
       
        function ui:GetDescriptor()
            return {
                feature = "colorvar_hostility_class";
                name = name.editBox:GetText();
                friendlyColor = swatch_friendlyColor:GetColor();
                friendlyPriestColor = swatch_friendlyPriestColor:GetColor(); 
                friendlyWarlockColor = swatch_friendlyWarlockColor:GetColor();
                friendlyHunterColor = swatch_friendlyHunterColor:GetColor();
                friendlyWarriorColor = swatch_friendlyWarriorColor:GetColor();
                friendlyPaladinColor = swatch_friendlyPaladinColor:GetColor();   
                friendlyMageColor = swatch_friendlyMageColor:GetColor();
                friendlyDruidColor = swatch_friendlyDruidColor:GetColor();
                friendlyShamanColor = swatch_friendlyShamanColor:GetColor();   
                friendlyRogueColor = swatch_friendlyRogueColor:GetColor();   
		friendlyDeathKnightColor = swatch_friendlyDeathKnightColor:GetColor();
                neutralColor = swatch_neutralColor:GetColor();
                hostileColor = swatch_hostileColor:GetColor();
            };
        end
       
        return ui;
    end;
    CreateDescriptor = function()
        return {
            feature = "colorvar_hostility_class";
            name = "hostilityclassColor";
            friendlyColor = {r=0, g=0.75, b=0,a=1};
            friendlyPriestColor = {r=1.0, g=1.0, b=1.0,a=1}; 
             friendlyWarlockColor = {r=0.58, g=0.51, b=0.79,a=1};
             friendlyHunterColor = {r=0.67, g=0.83, b=0.45,a=1};
             friendlyWarriorColor = {r=0.78, g=0.61, b=0.43,a=1};
             friendlyPaladinColor = {r=0.96, g=0.55, b=0.73,a=1};   
             friendlyMageColor = {r=0.41, g=0.8, b=0.94,a=1};
             friendlyDruidColor = {r=1.0, g=0.49, b=0.04,a=1};
             friendlyShamanColor = {r=0.14, g=0.34, b=1.0,a=1};   
             friendlyRogueColor = {r=1.0, g=0.96, b=0.41,a=1};
	     friendlyDeathKnightColor = {r=0.77, g=0.12, b=0.23,a=1};
            neutralColor = {r=0.75,g=0.75,b=0,a=1};
            hostileColor = {r=0.75,g=0.15,b=0,a=1};
        };
    end;
}); 