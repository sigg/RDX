-----------------------------------------------------------
-- A premade status bar.
-----------------------------------------------------------
local tbl_hvert = { {text = "HORIZONTAL"}, {text = "VERTICAL"} };
local function hvert_gen() return tbl_hvert; end

RDX.RegisterFeature({
	name = "statusbar_horiz";
	title = "Status Bar"; 
	category = VFLI.i18n("Basics");
	multiple = true;
	version = 1;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not RDXUI.UFLayoutCheck(desc, state, errs) then return nil; end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop); end
		local flg = true;
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFFrameCheck_Proto("StatusBar_", desc, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if desc.frac and desc.frac ~= "" then
			if not tonumber(desc.frac) and not (state:Slot("FracVar_" .. desc.frac)) then 
				VFL.AddError(errs, VFLI.i18n("Missing variable Frac")); flg = nil;
			end
		end
		if desc.colorVar and (not state:Slot("ColorVar_" .. desc.colorVar)) then
			VFL.AddError(errs, VFLI.i18n("Missing variable Color")); flg = nil;
		end
		if desc.sublevel and (tonumber(desc.sublevel) < 0 or tonumber(desc.sublevel) > 7) then
			VFL.AddError(errs, VFLI.i18n("Texture level must be between 0 to 7")); flg = nil;
		end
		if flg then 
			state:AddSlot("StatusBar_" .. desc.name);
			if desc.usebkd then
				state:AddSlot("Bkdp_" .. desc.name);
			end
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "StatusBar_" .. desc.name;
		-- Closure
		if desc.color1 then
			local closureCode = [[
local c1_]] .. objname .. " = " .. Serialize(desc.color1) .. [[
local c2_]] .. objname .. " = " .. Serialize(desc.color2) .. [[
]];
			state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);
		end -- if desc.color1

		-- Creation
		local orientation = "HORIZONTAL";
		if desc.orientation == "VERTICAL" then orientation = "VERTICAL"; end
		local reducey = desc.reducey or "false";
		local reducex = desc.reducex or "false";
		local createCode = [[
local _t = VFLUI.StatusBarTexture:new(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[, ]] ..reducey..[[, ]] ..reducex..[[, "]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);
frame.]] .. objname .. [[ = _t;
_t:SetOrientation("]] .. orientation .. [[");
_t:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
_t:SetWidth(]] .. desc.w .. [[); _t:SetHeight(]] .. desc.h .. [[);
_t:Show();
]];
		if desc.usebkd then
			createCode = createCode .. [[
VFLUI.SetBackdrop(_f, ]] .. Serialize(desc.bkd) .. [[);
]];
		end
		createCode = createCode .. VFLUI.GenerateSetTextureCode("_t", desc.texture);
		if desc.color1 then createCode = createCode .. [[
_t:SetColors(c1_]] .. objname .. [[, c2_]] .. objname .. [[);
]];
		end
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		-- Cleanup
		local cleanupCode = [[
frame.]] .. objname .. [[:SetValue(0);
]];
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode(cleanupCode); end);

		-- Paint (only apply paint code if the fraction exists)
		local frac = strtrim(desc.frac or "");
		local colorVar = strtrim(desc.colorVar or "");
		local paintCode;
		if frac ~= "" then
			paintCode = [[
_i = 0.2;
if ]] .. desc.frac .. [[ == 1 or ]] .. desc.frac .. [[ == 0 then _i = nil; else _i = 0.2; end
]];
			if desc.interpolate then
				if colorVar ~= "" then paintCode = paintCode .. [[
frame.]] .. objname .. [[:SetValueAndColorTable(]] .. desc.frac .. [[, ]] .. desc.colorVar .. [[,_i);
]];
                		else paintCode = paintCode .. [[
frame.]] .. objname .. [[:SetValue(]] .. desc.frac .. [[,_i);
]];
                		end
			else
				if colorVar ~= "" then paintCode = [[
frame.]] .. objname .. [[:SetValueAndColorTable(]] .. desc.frac .. [[, ]] .. desc.colorVar .. [[);
]];
                		else paintCode = [[
frame.]] .. objname .. [[:SetValue(]] .. desc.frac .. [[);
]];
                		end
			end
		elseif colorVar ~= "" then
			paintCode = [[
frame.]] .. objname .. [[:SetValueAndColorTable(1, ]] .. desc.colorVar .. [[);
]];
		else
			paintCode = [[
frame.]] .. objname .. [[:SetValue(1);
]];
		end
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		-- Destroy
		local destroyCode = [[
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", "StatusBar_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local chk_er = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Add Backdrop"));
		local bkd = VFLUI.MakeBackdropSelectButton(chk_er, desc.bkd); bkd:Show();
		chk_er:EmbedChild(bkd); chk_er:Show();
		if desc and desc.usebkd then chk_er:SetChecked(true); else chk_er:SetChecked(); end
		ui:InsertFrame(chk_er);

		-- Orientation
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation"));
		local dd_orientation = VFLUI.Dropdown:new(er, hvert_gen);
		dd_orientation:SetWidth(150); dd_orientation:Show();
		if desc and desc.orientation then 
			dd_orientation:SetSelection(desc.orientation); 
		else
			dd_orientation:SetSelection("HORIZONTAL");
		end
		er:EmbedChild(dd_orientation); er:Show();
		ui:InsertFrame(er);

		-- Texture
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);
		
		-- Drawlayer
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Draw layer"));
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(150); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);
		
		-- SubLevel
		local ed_sublevel = VFLUI.LabeledEdit:new(ui, 50); ed_sublevel:Show();
		ed_sublevel:SetText(VFLI.i18n("TextureLevel offset"));
		if desc and desc.sublevel then ed_sublevel.editBox:SetText(desc.sublevel); end
		ui:InsertFrame(ed_sublevel);

		-- Statusbar-specific parameters
		local frac = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Fraction variable"), state, "FracVar_");
		if desc and desc.frac then frac:SetSelection(desc.frac); end
		
		local chk_notusecolor = VFLUI.Checkbox:new(ui); chk_notusecolor:Show();
		chk_notusecolor:SetText(VFLI.i18n("Not use color"));
		if desc and desc.notusecolor then chk_notusecolor:SetChecked(true); else chk_notusecolor:SetChecked(); end
		ui:InsertFrame(chk_notusecolor);
		
		local colorVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Color variable"), state, "ColorVar_");
		if desc and desc.colorVar then colorVar:SetSelection(desc.colorVar); end

		local color1 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Static empty color"));
		if desc and desc.color1 then color1:SetColor(VFL.explodeRGBA(desc.color1)); end

		local color2 = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Static full color"));
		if desc and desc.color2 then color2:SetColor(VFL.explodeRGBA(desc.color2)); end
        
		local chk_interpolate = VFLUI.Checkbox:new(ui); chk_interpolate:Show();
		chk_interpolate:SetText(VFLI.i18n("Smooth effect"));
		if desc and desc.interpolate then chk_interpolate:SetChecked(true); else chk_interpolate:SetChecked(); end
		ui:InsertFrame(chk_interpolate);
		
		local chk_reducey = VFLUI.Checkbox:new(ui); chk_reducey:Show();
		chk_reducey:SetText(VFLI.i18n("Always reduce status bar texture from top to bottom, if vertical"));
		if desc and desc.reducey then chk_reducey:SetChecked(true); else chk_reducey:SetChecked(); end
		ui:InsertFrame(chk_reducey);
		
		local chk_reducex = VFLUI.Checkbox:new(ui); chk_reducex:Show();
		chk_reducex:SetText(VFLI.i18n("Always reduce status bar texture from right to left, if horizontal"));
		if desc and desc.reducex then chk_reducex:SetChecked(true); else chk_reducex:SetChecked(); end
		ui:InsertFrame(chk_reducex);
        
		function ui:GetDescriptor()
			local scolorVar, scolor1, scolor2 = nil, nil, nil;
			if not chk_notusecolor:GetChecked() then
				scolorVar = strtrim(colorVar:GetSelection() or "");
				if scolorVar == "" then
					scolorVar = nil;
					scolor1 = color1:GetColor(); scolor2 = color2:GetColor();
				end
			end
			return {
				feature = "statusbar_horiz"; version = 1;
				owner = owner:GetSelection();
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				usebkd = chk_er:GetChecked();
				bkd = bkd:GetSelectedBackdrop();
				orientation = dd_orientation:GetSelection();
				texture = tsel:GetSelectedTexture();
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				frac = frac:GetSelection();
				notusecolor = chk_notusecolor:GetChecked();
				colorVar = scolorVar; color1 = scolor1; color2 = scolor2;
				interpolate = chk_interpolate:GetChecked();
				reducey = chk_reducey:GetChecked();
				reducex = chk_reducex:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "statusbar_horiz"; version = 1;
			name = "statusBar";
			w = 90; h = 14; owner = "Frame_decor"; 
			orientation = "HORIZONTAL";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			texture = VFL.copy(VFLUI.defaultTexture);
			bkd = VFL.copy(VFLUI.defaultBackdrop);
		};
	end;
});