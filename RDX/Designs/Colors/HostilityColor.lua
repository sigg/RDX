
RDX.RegisterFeature({
	name = "colorvar_hostility"; 
	title = VFLI.i18n("Color Hostility");
	category = VFLI.i18n("Colors");
	IsPossible = function(state)
		if not state:HasSlots("EmitClosure", "EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if state:Slot("ColorVar_hostileColor") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name")); return nil;
		end
		state:AddSlot("Var_hostileColor");
		state:AddSlot("ColorVar_hostileColor");
		return true;
	end;
	ApplyFeature = function(desc, state)
		if desc and not(desc.XPColor) then desc.XPColor = {r=0.5,g=0.5,b=0.5,a=1}; end
		if desc and not(desc.selfColor) then desc.selfColor = {r=0,g=0,b=1,a=1}; end
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local hostileColor_cf = {};
hostileColor_cf[1] = ]] .. Serialize(desc.friendlyColor) .. [[;
hostileColor_cf[2] = ]] .. Serialize(desc.neutralColor) .. [[;
hostileColor_cf[3] = ]] .. Serialize(desc.hostileColor) .. [[;
hostileColor_cf[4] = ]] .. Serialize(desc.XPColor) .. [[;
hostileColor_cf[5] = ]] .. Serialize(desc.selfColor) .. [[;
]]);
		end);
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
local hostileColor = hostileColor_cf[1];
if not UnitIsFriend(uid, "player") then
	if UnitIsEnemy(uid, "player") then
		hostileColor = hostileColor_cf[3];
	else
		hostileColor = hostileColor_cf[2];
	end
end
if UnitIsTapped(uid) and not UnitIsTappedByPlayer(uid) then
	hostileColor = hostileColor_cf[4];
end
if UnitIsUnit(uid, "player") or UnitInGroup(uid) then
	hostileColor = hostileColor_cf[5];
end
if not UnitExists(uid) then
	hostileColor = Serialize({r=0,g=0,b=0,a=0});
end
]]);
		end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly color"));
		local swatch_friendlyColor = VFLUI.ColorSwatch:new(er);
		swatch_friendlyColor:Show();
		if desc and desc.friendlyColor then swatch_friendlyColor:SetColor(VFL.explodeRGBA(desc.friendlyColor)); end
		er:EmbedChild(swatch_friendlyColor); er:Show();
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
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Not tap color"));
		local swatch_XPColor = VFLUI.ColorSwatch:new(er);
		swatch_XPColor:Show();
		if desc and desc.XPColor then swatch_XPColor:SetColor(VFL.explodeRGBA(desc.XPColor)); end
		er:EmbedChild(swatch_XPColor); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Your color"));
		local swatch_selfColor = VFLUI.ColorSwatch:new(er);
		swatch_selfColor:Show();
		if desc and desc.selfColor then swatch_selfColor:SetColor(VFL.explodeRGBA(desc.selfColor)); end
		er:EmbedChild(swatch_selfColor); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "colorvar_hostility";
				friendlyColor = swatch_friendlyColor:GetColor(); 
				neutralColor = swatch_neutralColor:GetColor();
				hostileColor = swatch_hostileColor:GetColor();
				XPColor = swatch_XPColor:GetColor();
				selfColor = swatch_selfColor:GetColor();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "colorvar_hostility";
			friendlyColor = {r=0, g=0.75, b=0,a=1};
			neutralColor = {r=0.75,g=0.75,b=0,a=1};
			hostileColor = {r=0.75,g=0.15,b=0,a=1};
			XPColor = {r=0.5,g=0.5,b=0.5,a=1};
			selfColor = {r=0,g=0,b=1,a=1};
		};
	end;
});