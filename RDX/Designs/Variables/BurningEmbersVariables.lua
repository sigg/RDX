local EMBER1 = 1;
local EMBER2 = 2;
local EMBER3 = 3;
local EMBER4 = 4;

RDX.RegisterFeature({
	name = "Variable: Burning Embers";
	title = "Vars Burning Embers";
	category = VFLI.i18n("Variables");
	test = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc.name then desc.name = "be"; end
		for i=1, 4 do
		state:AddSlot("BoolVar_burning_" .. i .. "_ready");
		state:AddSlot("TextData_burning_" .. i .. "_text");
		state:AddSlot("ColorVar_burning_" .. i .. "_color");
		state:AddSlot("FracVar_burning_" .. i .. "_frac");
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
	
			local closureCode = [[ 
local embersColors = {};
]];
		for i=1, 4 do
			closureCode = closureCode .. [[
embersColors[]] .. i .. [[] = ]] .. Serialize(desc.colors[i]) .. [[;
]];
		end
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode(closureCode);
		end);
	
	
	
		local paintCode = "";
	
			paintCode = paintCode .. [[
	local MAX_POWER_PER_EMBER = 10
	local maxPower = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true) -- 40
	local power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true) -- xx
	local numEmbers = floor(maxPower / MAX_POWER_PER_EMBER) -- 4
]];

	for i=1, 4 do 
		if i>1 then
			paintCode = paintCode .. [[
			local emb]] .. i .. [[ = power - (MAX_POWER_PER_EMBER * ]] .. i-1 ..[[);
			if emb]] .. i .. [[ < 0 then emb]] .. i .. [[ = 0 end;
			if emb]] .. i .. [[ > 10 then emb]] .. i .. [[ = 10 end;
			burning_]] .. i .. [[_text = emb]] .. i .. [[;
			burning_]] .. i .. [[_frac = emb]] .. i .. [[/10;
			if emb]] .. i .. [[ >= 10 then 
			burning_]] .. i .. [[_ready = true;
			else 
			burning_]] .. i .. [[_ready = false;
			end;
			burning_]] .. i .. [[_color = embersColors[]] .. i .. [[];
			]];
		else
			paintCode = paintCode .. [[
			local emb1 = power;
			if emb1 < 0 then emb1 = 0 end;
			if emb1 > 10 then emb1 = 10 end;
			burning_]] .. i .. [[_text = emb1;
			burning_]] .. i .. [[_frac = emb1/10;
			if emb1 >= 10 then
			burning_]] .. i .. [[_ready = true;
			else
			burning_]] .. i .. [[_ready = false;
			end
			burning_]] .. i .. [[_color = embersColors[]] .. i .. [[];
			]];
		end
	end
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode(paintCode);
		end);
		
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		local mask = mux:GetPaintMask("POWER");
		mux:Event_UnitMask("UNIT_POWER", mask);
	end;

	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("nm"); end
		ui:InsertFrame(name);
		
		local be_1 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Burning Ember 1 color"));
		if desc and desc.colors and desc.colors[EMBER1] then be_1:SetColor(VFL.explodeRGBA(desc.colors[EMBER1])); end
		local be_2 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Burning Ember 2 color"));
		if desc and desc.colors and desc.colors[EMBER2] then be_2:SetColor(VFL.explodeRGBA(desc.colors[EMBER2])); end
		local be_3 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Burning Ember 3 color"));
		if desc and desc.colors and desc.colors[EMBER3] then be_3:SetColor(VFL.explodeRGBA(desc.colors[EMBER3])); end
		local be_4 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Burning Ember 4 color"));
		if desc and desc.colors and desc.colors[EMBER4] then be_4:SetColor(VFL.explodeRGBA(desc.colors[EMBER4])); end
		
		function ui:GetDescriptor()
			return {
				feature = "Variable: Burning Embers";
				name = name.editBox:GetText();
				colors = {
					[EMBER1] = be_1:GetColor(),
					[EMBER2] = be_2:GetColor(),
					[EMBER3] = be_3:GetColor(),
					[EMBER4] = be_4:GetColor(),
				};
			};
		end

		return ui;
	end;
	CreateDescriptor = function() return { 
		feature = "Variable: Burning Embers"; 
		name = "be"; 
		colors = {
				[EMBER1] =  { r=0.2,   g=0,   b=0.6, a=1 },
				[EMBER2] = { r=0.4,   g=0.2,   b=0.8,   a=1 },
				[EMBER3] =  { r=0.46,   g=0.26, b=0.86,   a=1 },
				[EMBER4] =  { r=0.6, g=0.4, b=1, a=1 },
			};
		}; end
});