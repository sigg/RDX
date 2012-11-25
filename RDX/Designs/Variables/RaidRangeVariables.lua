
RDX.RegisterFeature({
	name = "Variables range";
	title = VFLI.i18n("Vars Range (frac, color)");
	category = VFLI.i18n("Variables");
	IsPossible = function(state)
		if not state:HasSlots("UnitFrame", "EmitClosure", "EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)		
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if (not RDXDAL.FindSet(desc.set1)) or (not RDXDAL.FindSet(desc.set2)) or (not RDXDAL.FindSet(desc.set3)) or (not RDXDAL.FindSet(desc.set4)) then
			VFL.AddError(errs, VFLI.i18n("Invalid set pointer."));
			return nil;
		end
		if state:Slot("Var_rangeColor") then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name.")); return nil;
		end
		state:AddSlot("Var_rangeColor");
		state:AddSlot("ColorVar_rangeColor");
		state:AddSlot("FracVar_rangeFrac");
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- On closure, acquire the set locally
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode("local st1 = RDXDAL.FindSet(" .. Serialize(desc.set1) .. ");");
			code:AppendCode("local st2 = RDXDAL.FindSet(" .. Serialize(desc.set2) .. ");");
			code:AppendCode("local st3 = RDXDAL.FindSet(" .. Serialize(desc.set3) .. ");");
			code:AppendCode("local st4 = RDXDAL.FindSet(" .. Serialize(desc.set4) .. ");");
			code:AppendCode([[
local raColor_cf = {};
raColor_cf[1] = ]] .. Serialize(desc.raColor1) .. [[;
raColor_cf[2] = ]] .. Serialize(desc.raColor2) .. [[;
raColor_cf[3] = ]] .. Serialize(desc.raColor3) .. [[;
raColor_cf[4] = ]] .. Serialize(desc.raColor4) .. [[;
]]);
		end);
		-- On paint preamble, create flag and grade variables
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
		local rangeColor, rangeFrac = raColor_cf[1], 1;
		if st1:IsMember(unit) then
			rangeColor = raColor_cf[1];
			rangeFrac = 1;
		elseif st2:IsMember(unit) then
			rangeColor = raColor_cf[2];
			rangeFrac = 0.66;
		elseif st3:IsMember(unit) then
			rangeColor = raColor_cf[3];
			rangeFrac = 0.33;
		elseif st4:IsMember(unit) then
			rangeColor = raColor_cf[4];
			rangeFrac = 0;
		end
]]);
		end);
		-- Event hint: update on sort.
		local set1 = RDXDAL.FindSet(desc.set1);
		local set2 = RDXDAL.FindSet(desc.set2);
		local set3 = RDXDAL.FindSet(desc.set3);
		local set4 = RDXDAL.FindSet(desc.set4);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		mux:Event_SetDeltaMask(set1, 2); -- mask 2 = generic repaint
		mux:Event_SetDeltaMask(set2, 2); -- mask 2 = generic repaint
		mux:Event_SetDeltaMask(set3, 2); -- mask 2 = generic repaint
		mux:Event_SetDeltaMask(set4, 2); -- mask 2 = generic repaint
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local sf1 = RDXDAL.SetFinder:new(ui); sf1:Show();
		ui:InsertFrame(sf1); 
		if desc and desc.set1 then sf1:SetDescriptor(desc.set1); end
		
		local er1 = VFLUI.EmbedRight(ui, VFLI.i18n("0-15 color"));
		local swatch_raColor1 = VFLUI.ColorSwatch:new(er1);
		swatch_raColor1:Show();
		if desc and desc.raColor1 then swatch_raColor1:SetColor(VFL.explodeRGBA(desc.raColor1)); end
		er1:EmbedChild(swatch_raColor1); er1:Show();
		ui:InsertFrame(er1);
		
		local sf2 = RDXDAL.SetFinder:new(ui); sf2:Show();
		ui:InsertFrame(sf2); 
		if desc and desc.set2 then sf2:SetDescriptor(desc.set2); end
		
		local er2 = VFLUI.EmbedRight(ui, VFLI.i18n("15-30 color"));
		local swatch_raColor2 = VFLUI.ColorSwatch:new(er2);
		swatch_raColor2:Show();
		if desc and desc.raColor2 then swatch_raColor2:SetColor(VFL.explodeRGBA(desc.raColor2)); end
		er2:EmbedChild(swatch_raColor2); er2:Show();
		ui:InsertFrame(er2);
		
		local sf3 = RDXDAL.SetFinder:new(ui); sf3:Show();
		ui:InsertFrame(sf3); 
		if desc and desc.set3 then sf3:SetDescriptor(desc.set3); end
		
		local er3 = VFLUI.EmbedRight(ui, VFLI.i18n("30-40 color"));
		local swatch_raColor3 = VFLUI.ColorSwatch:new(er3);
		swatch_raColor3:Show();
		if desc and desc.raColor3 then swatch_raColor3:SetColor(VFL.explodeRGBA(desc.raColor3)); end
		er3:EmbedChild(swatch_raColor3); er3:Show();
		ui:InsertFrame(er3);
		
		local sf4 = RDXDAL.SetFinder:new(ui); sf4:Show();
		ui:InsertFrame(sf4); 
		if desc and desc.set4 then sf4:SetDescriptor(desc.set4); end
		
		local er4 = VFLUI.EmbedRight(ui, VFLI.i18n("40+ color"));
		local swatch_raColor4 = VFLUI.ColorSwatch:new(er4);
		swatch_raColor4:Show();
		if desc and desc.raColor4 then swatch_raColor4:SetColor(VFL.explodeRGBA(desc.raColor4)); end
		er4:EmbedChild(swatch_raColor4); er4:Show();
		ui:InsertFrame(er4);

		function ui:GetDescriptor()
			return {
				feature = "Variables range";
				set1 = sf1:GetDescriptor();  
				set2 = sf2:GetDescriptor();
				set3 = sf3:GetDescriptor();
				set4 = sf4:GetDescriptor();
				raColor1 = swatch_raColor1:GetColor(); 
				raColor2 = swatch_raColor2:GetColor();
				raColor3 = swatch_raColor3:GetColor();
				raColor4 = swatch_raColor4:GetColor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variables range"; 
			set1 = { file = "default:Range_0_15_fset", class = "file"};
			set2 = { file = "default:Range_15_30_fset", class = "file"};
			set3 = { file = "default:Range_30_40_fset", class = "file"}; 
			set4 = { file = "default:Range_40plus_fset", class = "file"};
			raColor1 = _green;
			raColor2 = _yellow;
			raColor3 = _orange;
			raColor4 = _red;
		};
	end;
});
