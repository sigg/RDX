
---------------------------------------------
-- Multi faction variable by Taelnia
---------------------------------------------

RDX.RegisterFeature({
	name = "Variables: Detailed Faction Info";
	title = VFLI.i18n("Vars Detailed Faction Info");
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
		if (not desc.factionID) or (desc.factionID < 1) then
			VFL.AddError(errs, VFLI.i18n("Missing faction identifier.")); return nil;
		end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("FracVar_" .. desc.name);
		state:AddSlot("TextData_" .. desc.name .. "txt");
		state:AddSlot("ColorVar_" .. desc.name .. "cv");
		return true;
	end;
      
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitClosure"), true, function(code) code:AppendCode([[
local reputationColor_cf = {};
reputationColor_cf[0] = ]] .. Serialize(desc.colorUnknown) .. [[;
reputationColor_cf[1] = ]] .. Serialize(desc.colorHated) .. [[;
reputationColor_cf[2] = ]] .. Serialize(desc.colorHostile) .. [[;
reputationColor_cf[3] = ]] .. Serialize(desc.colorUnfriendly) .. [[;
reputationColor_cf[4] = ]] .. Serialize(desc.colorNeutral) .. [[;
reputationColor_cf[5] = ]] .. Serialize(desc.colorFriendly) .. [[;
reputationColor_cf[6] = ]] .. Serialize(desc.colorHonored) .. [[;
reputationColor_cf[7] = ]] .. Serialize(desc.colorRevered) .. [[;
reputationColor_cf[8] = ]] .. Serialize(desc.colorExalted) .. [[;
]]);
		end);
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code) code:AppendCode([[
local ]] .. desc.name .. [[, ]] .. desc.name .. [[txt, ]] .. desc.name .. [[cv = 0, "", Serialize({r=0.5,g=0.5,b=0.5,a=1});
if(]] .. desc.factionID .. [[ > 0) then
	local name,_, repstanding, repmin, repmax, repvalue = GetFactionInfo(]] .. desc.factionID .. [[);
	if name and repvalue then
		local crep = repvalue - repmin;
		local cmax = repmax - repmin;
		]] .. desc.name .. [[ = crep / cmax;
		]] .. desc.name .. [[txt = name .. ": ".. crep .. "/".. cmax .. " ".. floor((crep/cmax) *100) .."%";
		]] .. desc.name .. [[cv = reputationColor_cf[repstanding];
	end
end
]]); 
		end);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		mux:Event_MaskAll("UNIT_FACTION", 2);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local start, finish, done = 1, GetNumFactions(), false;
		local name, isHeader, isCollapsed;
		local collapsedHeaders = {};
		
		local factionList = {};
		repeat
		for i = start, finish do
			name, _, _, _, _, _, _, _, isHeader, isCollapsed, _, _, _ = GetFactionInfo(i);
		
			table.insert(factionList, { text = name, id = i });
		
			if(isHeader and isCollapsed) then
				collapsedHeaders[i] = true;
				ExpandFactionHeader(i);
				start = i + 1;
				finish = GetNumFactions();
				break;
			end
		
			if(i == finish) then done = true; end
		end
		until done == true
		
		local playerFactionCount = GetNumFactions();
		
		for i = playerFactionCount, 1, -1 do
			if(collapsedHeaders[i] == true) then
				CollapseFactionHeader(i);
				collapsedHeaders[i] = nil;
			end
		end
		
		start, finish, done, name, isHeader, isCollapsed, collapsedHeaders = nil, nil, nil, nil, nil, nil ,nil;
		
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local iname = VFLUI.LabeledEdit:new(ui, 180);
		iname:Show();
		iname:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then iname.editBox:SetText(desc.name); end
		ui:InsertFrame(iname);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Faction:"));
		local dd_factionList = VFLUI.Dropdown:new(er, function() return factionList; end);
		dd_factionList:SetWidth(180); dd_factionList:Show();
		if desc and desc.factionName then
			dd_factionList:SetSelection(desc.factionName);
		else
			dd_factionList:SetSelection("Other");
		end
		er:EmbedChild(dd_factionList); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Unknown color"));
		local swatch_colorUnknown = VFLUI.ColorSwatch:new(er);
		swatch_colorUnknown:Show();
		if desc and desc.colorUnknown then swatch_colorUnknown:SetColor(VFL.explodeRGBA(desc.colorUnknown)); end
		er:EmbedChild(swatch_colorUnknown); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Hated color"));
		local swatch_colorHated = VFLUI.ColorSwatch:new(er);
		swatch_colorHated:Show();
		if desc and desc.colorHated then swatch_colorHated:SetColor(VFL.explodeRGBA(desc.colorHated)); end
		er:EmbedChild(swatch_colorHated); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Hostile color"));
		local swatch_colorHostile = VFLUI.ColorSwatch:new(er);
		swatch_colorHostile:Show();
		if desc and desc.colorHostile then swatch_colorHostile:SetColor(VFL.explodeRGBA(desc.colorHostile)); end
		er:EmbedChild(swatch_colorHostile); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Unfriendly color"));
		local swatch_colorUnfriendly = VFLUI.ColorSwatch:new(er);
		swatch_colorUnfriendly:Show();
		if desc and desc.colorUnfriendly then swatch_colorUnfriendly:SetColor(VFL.explodeRGBA(desc.colorUnfriendly)); end
		er:EmbedChild(swatch_colorUnfriendly); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Neutral color"));
		local swatch_colorNeutral = VFLUI.ColorSwatch:new(er);
		swatch_colorNeutral:Show();
		if desc and desc.colorNeutral then swatch_colorNeutral:SetColor(VFL.explodeRGBA(desc.colorNeutral)); end
		er:EmbedChild(swatch_colorNeutral); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Friendly color"));
		local swatch_colorFriendly = VFLUI.ColorSwatch:new(er);
		swatch_colorFriendly:Show();
		if desc and desc.colorFriendly then swatch_colorFriendly:SetColor(VFL.explodeRGBA(desc.colorFriendly)); end
		er:EmbedChild(swatch_colorFriendly); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Honored color"));
		local swatch_colorHonored = VFLUI.ColorSwatch:new(er);
		swatch_colorHonored:Show();
		if desc and desc.colorHonored then swatch_colorHonored:SetColor(VFL.explodeRGBA(desc.colorHonored)); end
		er:EmbedChild(swatch_colorHonored); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Revered color"));
		local swatch_colorRevered = VFLUI.ColorSwatch:new(er);
		swatch_colorRevered:Show();
		if desc and desc.colorRevered then swatch_colorRevered:SetColor(VFL.explodeRGBA(desc.colorRevered)); end
		er:EmbedChild(swatch_colorRevered); er:Show();
		ui:InsertFrame(er);
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Exalted color"));
		local swatch_colorExalted = VFLUI.ColorSwatch:new(er);
		swatch_colorExalted:Show();
		if desc and desc.colorExalted then swatch_colorExalted:SetColor(VFL.explodeRGBA(desc.colorExalted)); end
		er:EmbedChild(swatch_colorExalted); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			local facName = dd_factionList:GetSelection();
			local facID = 0;
		
			for index, value in pairs(factionList) do
				if value.text == facName then
				facID = value.id;
				break;
				end
			end
		
			return {
				feature = VFLI.i18n("Variables: Detailed Faction Info");
				name = iname.editBox:GetText();
				factionName = facName;
				factionID = facID;
				colorUnknown = swatch_colorUnknown:GetColor();
				colorHated = swatch_colorHated:GetColor();
				colorHostile = swatch_colorHostile:GetColor();
				colorUnfriendly = swatch_colorUnfriendly:GetColor();
				colorNeutral = swatch_colorNeutral:GetColor();
				colorFriendly = swatch_colorFriendly:GetColor();
				colorHonored = swatch_colorHonored:GetColor();
				colorRevered = swatch_colorRevered:GetColor();
				colorExalted = swatch_colorExalted:GetColor();
			};
		end
		
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; for index, value in pairs(factionList) do value.text = nil; value.id = nil; factionList[index] = nil; end factionList = nil; end, ui.Destroy);
	
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature         = VFLI.i18n("Variables: Detailed Faction Info");
			name            = "faction1";
			factionName     = "";
			factionID       = 0;
			colorUnknown    = {r = 0.5,  g = 0.5,  b = 0.5,  a = 1};
			colorHated      = {r = 0.8,  g = 0.13, b = 0.13, a = 1};
			colorHostile    = {r = 1,    g = 0,    b = 0,    a = 1};
			colorUnfriendly = {r = 0.93, g = 0.4,  b = 0.13, a = 1};
			colorNeutral    = {r = 1,    g = 1,    b = 0,    a = 1};
			colorFriendly   = {r = 0,    g = 1,    b = 0,    a = 1};
			colorHonored    = {r = 0,    g = 1,    b = 0.53, a = 1};
			colorRevered    = {r = 0,    g = 1,    b = 0.8,  a = 1};
			colorExalted    = {r = 0,    g = 1,    b = 1,    a = 1};
		};
	end;
});
