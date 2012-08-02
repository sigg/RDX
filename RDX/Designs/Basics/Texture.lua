-- Textures.lua
-- OpenRDX
--
-- Textures for application on unitframes.

local IndicatorIndex = {};
local Indicators = {};

function RDX.RegisterTextureIndicator(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if Indicators[tbl.name] then RDX.printW("Attempt to register duplicate Indicator Type " .. tbl.name); return; end
	Indicators[tbl.name] = tbl;
	table.insert(IndicatorIndex, {value = tbl.name, text = tbl.title});
end

RDX.RegisterTextureIndicator({
	name = "Blue";
	title = VFLI.i18n("Blue");
	emitClosureCode = [[
local rdxset_blue = RDXDAL.FindSet({class = "file", file = "sets:set_blue"});
if not rdxset_blue:IsOpen() then rdxset_blue:Open(); end
]];
	createCode = [[
btn._t:SetTexture(0,0,1,1);
]];
	paintCodeTest = [[
if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
if rdxset_blue:IsMember(unit) then
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	set = {class = "file", file = "default:set_blue"};
});

RDX.RegisterTextureIndicator({
	name = "Red";
	title = VFLI.i18n("Red");
	emitClosureCode = [[
local rdxset_red = RDXDAL.FindSet({class = "file", file = "sets:set_red"});
if not rdxset_red:IsOpen() then rdxset_red:Open(); end
]];
	createCode = [[
btn._t:SetTexture(1,0,0,1);
]];
	paintCodeTest = [[
if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
if rdxset_red:IsMember(unit) then
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	set = {class = "file", file = "default:set_red"};
});

RDX.RegisterTextureIndicator({
	name = "Green";
	title = VFLI.i18n("Green");
	emitClosureCode = [[
local rdxset_green = RDXDAL.FindSet({class = "file", file = "sets:set_green"});
if not rdxset_green:IsOpen() then rdxset_green:Open(); end
]];
	createCode = [[
btn._t:SetTexture(0,1,0,1);
]];
	paintCodeTest = [[
if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
if rdxset_green:IsMember(unit) then
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	set = {class = "file", file = "default:set_green"};
});

RDX.RegisterTextureIndicator({
	name = "Yellow";
	title = VFLI.i18n("Yellow");
	emitClosureCode = [[
local rdxset_yellow = RDXDAL.FindSet({class = "file", file = "sets:set_yellow"});
if not rdxset_yellow:IsOpen() then rdxset_yellow:Open(); end
]];
	createCode = [[
btn._t:SetTexture(1,1,0,1);
]];
	paintCodeTest = [[
if not btn:IsShown() then btn:Show(); end
]];
	paintCode = [[
if rdxset_green:IsMember(unit) then
	if not btn:IsShown() then btn:Show(); end
else
	if btn:IsShown() then btn:Hide(); end
end
]];
	set = {class = "file", file = "default:set_yellow"};
});

---------------------------------------------------------------

local IconsIndex = {};
local Icons = {};

function RDX.RegisterTextureIcon(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if Icons[tbl.name] then RDX.printW("Attempt to register duplicate Icon Type " .. tbl.name); return; end
	Icons[tbl.name] = tbl;
	table.insert(IconsIndex, {value = tbl.name, text = tbl.title});
end

--------------------------------------------------------------
-- A Texture is an independent texture object on a unitframe.
--------------------------------------------------------------
RDX.RegisterFeature({
	name = "texture2"; version = 1; 
	title = VFLI.i18n("Texture"); 
	category = VFLI.i18n("Basics");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local flg = true;
		if desc.ftype == 1 then
			flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
			flg = flg and RDXUI.UFFrameCheck_Proto("Texture_", desc, state, errs);
			flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
			if desc.sublevel and (tonumber(desc.sublevel) < 0 or tonumber(desc.sublevel) > 7) then
				VFL.AddError(errs, VFLI.i18n("Texture level must be between 0 to 7")); flg = nil;
			end
			if flg then state:AddSlot("Texture_" .. desc.name); end
		elseif ftype == 2 then
			flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
			flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
			flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
			if flg then state:AddSlot("Frame_" .. desc.name); end
		elseif ftype == 3 then
			if state:Slot("Tx_rdx_" .. desc.class) then
				VFL.AddError(errs, VFLI.i18n("Texture Indicator class already add")); return nil;
			end
			flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
			flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
			flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
			if flg then state:AddSlot("Frame_" .. desc.name); state:AddSlot("Tx_rdx_" .. desc.intype); end
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = RDXUI.ResolveTextureReference(desc.name);
		------------------ On frame creation
		local createCode = ""
		if desc.ftype == 1 then
			createCode = createCode .. [[
local _t = VFLUI.CreateTexture(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
_t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "1") .. [[);
_t:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
_t:SetWidth(]] .. desc.w .. [[); _t:SetHeight(]] .. desc.h .. [[);
_t:Show();
]] .. objname .. [[ = _t;
]];
			createCode = createCode .. VFLUI.GenerateSetTextureCode("_t", desc.texture);
		elseif ftype == 2 then
			createCode = createCode .. [[
local btn, owner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
if ]] .. ebsflag .. [[ then 
	btn = VFLUI.SkinButton:new();
	btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, true);
else
	btn = VFLUI.AcquireFrame("Frame");
end
btn:SetParent(owner);
btn:SetFrameLevel(owner:GetFrameLevel());
btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
btn._t = VFLUI.CreateTexture(btn);
btn._t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", 2);
btn._t:SetPoint("CENTER", btn, "CENTER");
btn._t:SetWidth(]] .. desc.w .. [[ - ]] .. ebsos .. [[); btn._t:SetHeight(]] .. desc.h .. [[ - ]] .. ebsos .. [[);
btn._t:SetVertexColor(1,1,1,1);
btn._t:Show();
btn:Hide();
]];
			createCode = createCode .. Icons[desc.class].createCode;
			createCode = createCode .. [[
frame.]] .. objname .. [[ = btn;
]];
		elseif ftype == 3 then
			local path = Indicators[desc.class].set.file; 
			state:GetContainingWindowState():Attach("Menu", true, function(win, mnu)
				table.insert(mnu, {
					text = VFLI.i18n("Edit Indicator: ") .. desc.name;
					OnClick = function()
						VFL.poptree:Release();
						RDXDB.OpenObject(path, "Edit", VFLDIALOG);
					end;
				});
			end);
			createCode = createCode .. [[
local btn, owner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
btn = VFLUI.AcquireFrame("Frame");
btn:SetParent(owner);
btn:SetFrameLevel(owner:GetFrameLevel());
btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
btn._t = VFLUI.CreateTexture(btn);
btn._t:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "2") .. [[);
btn._t:SetPoint("CENTER", btn, "CENTER");
btn._t:SetWidth(]] .. desc.w .. [[); btn._t:SetHeight(]] .. desc.h .. [[);
btn._t:SetVertexColor(1,1,1,1);
btn._t:Show();
btn:Hide();
]];
			createCode = createCode .. Indicators[desc.class].createCode;
			createCode = createCode .. [[
frame.]] .. objname .. [[ = btn;
]];
		end
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = ""
		if desc.ftype == 1 then
			destroyCode = destroyCode .. [[
]] .. objname .. [[:Destroy();
]] .. objname .. [[ = nil;
]];
		elseif desc.ftype == 2 or desc.ftype == 3 then
			destroyCode = destroyCode .. [[
VFLUI.ReleaseRegion(frame.]] .. objname .. [[._t); 
frame.]] .. objname .. [[._t = nil;
frame.]] .. objname .. [[:Destroy(); 
frame.]] .. objname .. [[ = nil;
]];		
		end
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		if desc.ftype == 1 then
		if (desc.cleanupPolicy == 2) then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
]] .. objname .. [[:Hide();
]]); end);
		elseif (desc.cleanupPolicy == 3) then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
]] .. objname .. [[:Show();
]]); end);
		end
		
		elseif ftype == 2 or ftype == 3 then
			state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
frame.]] .. objname .. [[:Hide();
]]); end);
		end
		
		if desc.ftype == 2 then
			local paintCode = [[
btn = frame.]] .. objname .. [[;
]];
			paintCode = paintCode .. Icons[desc.class].paintCode;
			local paintCodeTest = [[
btn = frame.]] .. objname .. [[;
]];
			paintCodeTest = paintCodeTest .. Icons[desc.class].paintCodeTest;
			
			if desc.test then
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCodeTest); end);
			else
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
			end
			
			local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
			mux:Event_MaskAll(Icons[desc.class].event, 2);
		elseif desc.ftype == 3 then
			local paintCode = [[
btn = frame.]] .. objname .. [[;
]];
			paintCode = paintCode .. Indicators[desc.class].paintCode;
			local paintCodeTest = [[
btn = frame.]] .. objname .. [[;
]];
			paintCodeTest = paintCodeTest .. Indicators[desc.class].paintCodeTest;
			
			if desc.test then
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCodeTest); end);
			else
				state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
			end
			
			-- Event hint: update on sort.
			local set = RDXDAL.FindSet(Indicators[desc.class].set);
			local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
			mux:Event_SetDeltaMask(set, 2); -- mask 2 = generic repaint
		end	

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Default parameters")));

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);
		
		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture parameters")));

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
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Skin parameters")));
		
		local driver = VFLUI.DisjointRadioGroup:new();
		
		local driver_BS = driver:CreateRadioButton(ui);
		driver_BS:SetText(VFLI.i18n("Use Button Skin"));
		local driver_BD = driver:CreateRadioButton(ui);
		driver_BD:SetText(VFLI.i18n("Use Backdrop"));
		local driver_RB = driver:CreateRadioButton(ui);
		driver_RB:SetText(VFLI.i18n("Use RDX Border"));
		driver:SetValue(desc.driver or 2);
		
		ui:InsertFrame(driver_BS);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Button Skin"));
		local dd_buttonSkin = VFLUI.Dropdown:new(er, VFLUI.GetButtonSkinList);
		dd_buttonSkin:SetWidth(150); dd_buttonSkin:Show();
		dd_buttonSkin:SetSelection(desc.externalButtonSkin); 
		er:EmbedChild(dd_buttonSkin); er:Show();
		ui:InsertFrame(er);
		
		local ed_bs = VFLUI.LabeledEdit:new(ui, 50); ed_bs:Show();
		ed_bs:SetText(VFLI.i18n("Button Skin Size Offset"));
		if desc and desc.ButtonSkinOffset then ed_bs.editBox:SetText(desc.ButtonSkinOffset); end
		ui:InsertFrame(ed_bs);
		
		local chk_showgloss = VFLUI.Checkbox:new(ui); chk_showgloss:Show();
		chk_showgloss:SetText(VFLI.i18n("Button Skin Show Gloss"));
		if desc and desc.showgloss then chk_showgloss:SetChecked(true); else chk_showgloss:SetChecked(); end
		ui:InsertFrame(chk_showgloss);
		
		local color_bsdefault = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Button Skin default color"));
		if desc and desc.bsdefault then color_bsdefault:SetColor(VFL.explodeRGBA(desc.bsdefault)); end
		
		ui:InsertFrame(driver_BD);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop"));
		local dd_backdrop = VFLUI.MakeBackdropSelectButton(er, desc.bkd);
		dd_backdrop:Show();
		er:EmbedChild(dd_backdrop); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(driver_RB);
		
		local ed_borsize = VFLUI.LabeledEdit:new(ui, 50); ed_borsize:Show();
		ed_borsize:SetText(VFLI.i18n("Border size"));
		if desc and desc.bordersize then ed_borsize.editBox:SetText(desc.bordersize); end
		ui:InsertFrame(ed_borsize);
		
		-- Feature type
		local ftype = VFLUI.DisjointRadioGroup:new();
		local ftype_1 = ftype:CreateRadioButton(ui);
		ftype_1:SetText(VFLI.i18n("Use Custom Texture"));
		local ftype_2 = ftype:CreateRadioButton(ui);
		ftype_2:SetText(VFLI.i18n("Use Icon Texture"));
		local ftype_3 = ftype:CreateRadioButton(ui);
		ftype_3:SetText(VFLI.i18n("Use Indicator Texture"));
		ftype:SetValue(desc.ftype or 2);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture Type")));
		ui:InsertFrame(ftype_1);
		
		local cleanupPolicy = VFLUI.RadioGroup:new(ui);
		cleanupPolicy:SetLayout(3,3);
		cleanupPolicy.buttons[1]:SetText(VFLI.i18n("No cleanup"));
		cleanupPolicy.buttons[2]:SetText(VFLI.i18n("Hide on clean"));
		cleanupPolicy.buttons[3]:SetText(VFLI.i18n("Show on clean"));
		if desc and desc.cleanupPolicy then
			cleanupPolicy:SetValue(desc.cleanupPolicy);
		else
			cleanupPolicy:SetValue(1);
		end
		ui:InsertFrame(cleanupPolicy);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(ftype_2);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Icon Type"));
		local dd_ictype = VFLUI.Dropdown:new(er, function() return IconsIndex; end);
		dd_ictype:SetWidth(200); dd_ictype:Show();
		if desc and desc.ictype then dd_ictype:SetSelection(desc.ictype); else dd_ictype:SetSelection("Faction"); end
		er:EmbedChild(dd_ictype); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(ftype_3);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Indicator Type"));
		local dd_intype = VFLUI.Dropdown:new(er, function() return IndicatorIndex; end);
		dd_intype:SetWidth(200); dd_intype:Show();
		if desc and desc.intype then dd_intype:SetSelection(desc.intype); else dd_intype:SetSelection("Blue"); end
		er:EmbedChild(dd_intype); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "texture2"; version = 1;
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				--
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				--
				driver = driver:GetValue();
				externalButtonSkin = dd_buttonSkin:GetSelection();
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				showgloss = chk_showgloss:GetChecked();
				bsdefault = color_bsdefault:GetColor();
				bkd = dd_backdrop:GetSelectedBackdrop();
				bordersize = VFL.clamp(ed_borsize.editBox:GetNumber(), 0, 50);
				--
				ftype = ftype:GetValue();
				cleanupPolicy = cleanupPolicy:GetValue();
				texture = tsel:GetSelectedTexture();
				ictype = dd_ictype:GetSelection();
				intype = dd_intype:GetSelection();
			};
		end
		
		ui.Destroy = VFL.hook(function(s) 
			ftype:Destroy(); ftype = nil;
			driver:Destroy(); driver = nil; 
		end, ui.Destroy);

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "texture2"; version = 1; 
			name = "tex1", owner = "decor",
			w = 90; h = 14;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			drawLayer = "ARTWORK"; sublevel = 1;
			
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			bkd = VFL.copy(VFLUI.defaultBackdrop);
			bordersize = 1;
			
			cleanupPolicy = 1;
			texture = VFL.copy(VFLUI.defaultTexture);
		};
	end;
});

-- specific function to update the texture path of a feature.
function RDXDB.SetTextureData(path, key, value, newtexpath )
	local x = RDXDB.GetObjectData(path); if not x then return; end
	local feat = RDXDB.HasFeature(x.data, "texture", key, value);
	if feat and feat.texture then
		feat.texture.path = newtexpath;
		return true;
	end
	return nil;
end
