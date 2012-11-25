-------------------------------------
-- Vars: Rune Info - Deathknight rune variables
-- 
-- UnitFrameFeature to create custom Deathknight RuneElements
-- Karma - Blackrock EU
-------------------------------------
local RUNETYPE_BLOOD = 1;
local RUNETYPE_UNHOLY = 2;
local RUNETYPE_FROST = 3;
local RUNETYPE_DEATH = 4;

RDX.RegisterFeature({
	name = "Vars: Rune Info";
	title = VFLI.i18n("Vars Rune Info");
	category =  VFLI.i18n("Variables");
	version = 1;
	multiple = false;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)      
		if not desc then VFL.AddError(errs, VFLI.i18n( "No descriptor.")); return nil; end
		for i=1, 6 do
			state:AddSlot("TimerVar_rune" .. i);
			state:AddSlot("BoolVar_rune" .. i .. "_ready");
			state:AddSlot("TextData_rune" .. i .. "_name");
			state:AddSlot("TexVar_rune" .. i .. "_icon");
			state:AddSlot("ColorVar_rune" .. i .. "_color");
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		if not desc.TextureType then desc.TextureType = "Normal"; end
		-- Event hinting.
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local smask = mux:GetPaintMask("RUNE_POWER_UPDATE");
		local umask = mux:GetPaintMask("RUNE_TYPE_UPDATE");
		
		local closureCode = [[ 
local runeColors = {};
]];
		for i=1, 4 do
			closureCode = closureCode .. [[
runeColors[]] .. i .. [[] = ]] .. Serialize(desc.colors[i]) .. [[;
]];
		end
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode(closureCode);
		end);
		
		local paintCode = "";
		for i=1, 6 do 
			paintCode = paintCode .. [[
		local rune]] .. i .. [[_name, rune]] .. i .. [[_icon, rune]] .. i .. [[_color = "", nil, nil;
		local rune]] .. i .. [[_start, rune]] .. i .. [[_duration, rune]] .. i .. [[_ready = 0, 0, false;
]];
		end

		paintCode = paintCode .. [[
		local classMnemonic = unit:GetClassMnemonic();
		if ( classMnemonic == "DEATHKNIGHT" ) then
			local runetype;
]];
	for i=1,6 do
		paintCode = paintCode .. [[
			runeType = GetRuneType(]] .. i .. [[);
			if (runeType) then
				rune]] .. i .. [[_name = RDXMD.GetRuneMapping(runeType);
				rune]] .. i .. [[_icon = RDXMD.GetRuneIconTextures]] .. desc.TextureType .. [[(runeType);
				rune]] .. i .. [[_color = runeColors[runeType];
				rune]] .. i .. [[_start, rune]] .. i .. [[_duration, rune]] .. i .. [[_ready = GetRuneCooldown(]] .. i .. [[);
			end
]];
	end
	paintCode = paintCode .. [[
		end
]];
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode(paintCode);
		end);
		
		mux:Event_UnitMask("UNIT_RUNE_POWER_UPDATE", smask);
		mux:Event_UnitMask("UNIT_RUNE_TYPE_UPDATE", umask);
		return true;
	end;

	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local er_TextureType = VFLUI.EmbedRight(ui, VFLI.i18n("Texture Type:"));
		local dd_TextureType = VFLUI.Dropdown:new(er_TextureType, RDXMD.RuneTextureTypeDropdownFunction);
		dd_TextureType:SetWidth(150); dd_TextureType:Show();
		if desc and desc.TextureType then 
			dd_TextureType:SetSelection(desc.TextureType); 
		else
			dd_TextureType:SetSelection("Normal");
		end
		er_TextureType:EmbedChild(dd_TextureType); er_TextureType:Show();
		ui:InsertFrame(er_TextureType);
		
		local sw_blood = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Blood rune color"));
		if desc and desc.colors and desc.colors[RUNETYPE_BLOOD] then sw_blood:SetColor(VFL.explodeRGBA(desc.colors[RUNETYPE_BLOOD])); end
		local sw_unholy = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Unholy rune color"));
		if desc and desc.colors and desc.colors[RUNETYPE_UNHOLY] then sw_unholy:SetColor(VFL.explodeRGBA(desc.colors[RUNETYPE_UNHOLY])); end
		local sw_frost = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Frost rune color"));
		if desc and desc.colors and desc.colors[RUNETYPE_FROST] then sw_frost:SetColor(VFL.explodeRGBA(desc.colors[RUNETYPE_FROST])); end
		local sw_death = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Death rune color"));
		if desc and desc.colors and desc.colors[RUNETYPE_DEATH] then sw_death:SetColor(VFL.explodeRGBA(desc.colors[RUNETYPE_DEATH])); end
		
		function ui:GetDescriptor()
			return {
				feature = "Vars: Rune Info";
				TextureType = dd_TextureType:GetSelection();
				colors = {
					[RUNETYPE_BLOOD] = sw_blood:GetColor(),
					[RUNETYPE_UNHOLY] = sw_unholy:GetColor(),
					[RUNETYPE_FROST] = sw_frost:GetColor(),
					[RUNETYPE_DEATH] = sw_death:GetColor(),
				};
			};
		end
		return ui;
	end;   

	CreateDescriptor = function()
		return {
			feature = "Vars: Rune Info";
			colors = {
				[RUNETYPE_BLOOD] =  { r=1,   g=0,   b=0.2, a=1 },
				[RUNETYPE_UNHOLY] = { r=0,   g=1,   b=0,   a=1 },
				[RUNETYPE_FROST] =  { r=0,   g=0.6, b=1,   a=1 },
				[RUNETYPE_DEATH] =  { r=0.6, g=0.3, b=0.6, a=1 },
			};
		};
	end;
});