
--------------- Code emitter helpers
local function _EmitCreateCode(objname, desc)
	local ebsflag, ebs, ebsos = "false", "bs_default", 0;
	if desc.externalButtonSkin then
		ebsflag = "true";
		ebs = desc.externalButtonSkin;
		if desc.ButtonSkinOffset then ebsos = desc.ButtonSkinOffset; end
	end
	
	if not desc.cd then desc.cd = VFL.copy(VFLUI.defaultCooldown); end
	local createCode = [[
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
if ]] .. ebsflag .. [[ then 
	btn = VFLUI.SkinButton:new();
	btn:SetButtonSkin("]] .. ebs ..[[", true, true, false, true, true, true, false, true, true, true);
else
	btn = VFLUI.AcquireFrame("Frame");
end
btn:SetParent(btnOwner);
btn:SetFrameLevel(btnOwner:GetFrameLevel());
btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
btn.tex = VFLUI.CreateTexture(btn);
btn.tex:SetDrawLayer("]] .. (desc.drawLayer or "ARTWORK") .. [[", ]] .. (desc.sublevel or "2") .. [[);
btn.tex:SetPoint("TOPLEFT", btn, "TOPLEFT", ]] .. ebsos .. [[, -]] .. ebsos .. [[);
btn.tex:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -]] .. ebsos .. [[, ]] .. ebsos .. [[);
if not RDXG.usecleanicons then
	btn.tex:SetTexCoord(0.05, 1-0.06, 0.05, 1-0.04);
end
btn.tex:Show();
]];
	createCode = createCode .. VFLUI.GenerateSetTextureCode("btn.tex", desc.texture);
	createCode = createCode .. [[
btn.cd = VFLUI.CooldownCounter:new(btn, ]] .. Serialize(desc.cd) .. [[);
btn.cd:SetAllPoints(btn.tex);
btn.cd:Show();
]];
	if desc.gt then
	local gtType = __RDX_GetGameTooltipType(desc.gt);
	createCode = createCode .. [[
btn:SetScript("OnEnter", ]] .. gtType .. [[);
btn:SetScript("OnLeave", __RDX_OnLeave);
]];
	else
	createCode = createCode .. [[

]];
	end
	createCode = createCode .. [[
frame.]] .. objname .. [[ = btn;

]];
	return createCode;
end

RDX.RegisterFeature({
	name = "texture_cooldown";
	title = "Cooldown";
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
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if not desc.timerVar or desc.timerVar == "" then VFL.AddError(errs, VFLI.i18n("Missing variable Timer")); flg = nil; end
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		local texIcondata = desc.tex or "";
		
		----------------- Creation
		local createCode = _EmitCreateCode(objname, desc);
		state:Attach("EmitCreate", true, function(code) code:AppendCode(createCode); end);

		------------------- Destruction
		local destroyCode = [[
local btn = frame.]] .. objname .. [[;
btn.cd:Destroy(); btn.cd = nil;
VFLUI.ReleaseRegion(btn.tex); btn.tex = nil;
btn:Destroy(); btn = nil;
frame.]] .. objname .. [[ = nil;
]];
		state:Attach("EmitDestroy", true, function(code) code:AppendCode(destroyCode); end);

		------------------- Paint
		local paintCode = [[
local btn = frame.]] .. objname .. [[;
]];
		if desc.dyntexture then
		paintCode = paintCode .. [[
btn.tex:SetTexture(]] .. texIcondata .. [[);
]];
		end
		paintCode = paintCode .. [[
if ]] .. desc.timerVar .. [[_start and ]] .. desc.timerVar .. [[_start > 0 then
	btn.cd:SetCooldown(]] .. desc.timerVar .. [[_start, ]] .. desc.timerVar .. [[_duration);
	if not btn:IsShown() then btn:Show(0.2); end
else
	if btn:IsShown() then btn:Hide(0.2); end
end
]];
		if desc.gt and desc.gt ~= "" then
		paintCode = paintCode .. [[
btn.gtid = ]] .. desc.gt .. [[;
]];
		end
		state:Attach("EmitPaint", true, function(code) code:AppendCode(paintCode); end);

		------------------- Cleanup
		local cleanupCode = [[
frame.]] .. objname .. [[:Hide();
]];
		state:Attach("EmitCleanup", true, function(code) code:AppendCode(cleanupCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		------------- Core
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Core parameters")));
		
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Timer parameters")));
		
		local timerVar = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Timer variable"), state, "TimerVar_");
		if desc and desc.timerVar then timerVar:SetSelection(desc.timerVar); end
		
		------------- ButtonSkin
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Button Skin parameters")));
		
		local chk_bs = VFLUI.CheckEmbedRight(ui, VFLI.i18n("Use Button Skin"));
		local dd_buttonSkin = VFLUI.Dropdown:new(chk_bs, VFLUI.GetButtonSkinList);
		dd_buttonSkin:SetWidth(150); dd_buttonSkin:Show();
		if desc and desc.externalButtonSkin then
			chk_bs:SetChecked(true);
			dd_buttonSkin:SetSelection(desc.externalButtonSkin); 
		else
			chk_bs:SetChecked();
			dd_buttonSkin:SetSelection("bs_default");
		end
		chk_bs:EmbedChild(dd_buttonSkin); chk_bs:Show();
		ui:InsertFrame(chk_bs);
		
		local ed_bs = VFLUI.LabeledEdit:new(ui, 50); ed_bs:Show();
		ed_bs:SetText(VFLI.i18n("Button Skin Size Offset"));
		if desc and desc.ButtonSkinOffset then ed_bs.editBox:SetText(desc.ButtonSkinOffset); end
		ui:InsertFrame(ed_bs);
		
		-------------- Texture
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Texture parameters")));
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Texture"));
		local tsel = VFLUI.MakeTextureSelectButton(er, desc.texture); tsel:Show();
		er:EmbedChild(tsel); er:Show();
		ui:InsertFrame(er);
		
		local chk_dyntexture = VFLUI.Checkbox:new(ui); chk_dyntexture:Show();
		chk_dyntexture:SetText(VFLI.i18n("Use texture variable"));
		if desc and desc.dyntexture then chk_dyntexture:SetChecked(true); else chk_dyntexture:SetChecked(); end
		ui:InsertFrame(chk_dyntexture);
		
		local tex = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Texture variable"), state, "TexVar_");
		if desc and desc.tex then tex:SetSelection(desc.tex); end
		
		-------------- Cooldown Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Cooldown parameters")));
		local ercd = VFLUI.EmbedRight(ui, VFLI.i18n("Cooldown"));
		local cd = VFLUI.MakeCooldownSelectButton(ercd, desc.cd); cd:Show();
		ercd:EmbedChild(cd); ercd:Show();
		ui:InsertFrame(ercd);
		
		-------------- Game Tooltip Display
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("GameTooltip parameters")));
		local gt = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("GameTooltip"), state, "GameTooltips_");
		if desc and desc.gt then gt:SetSelection(desc.gt); end
		
		function ui:GetDescriptor()
			local ebs = nil;
			if chk_bs:GetChecked() then ebs = dd_buttonSkin:GetSelection(); end
			return { 
				feature = "texture_cooldown"; 
				version = 1;
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				timerVar = timerVar:GetSelection();
				externalButtonSkin = ebs;
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				texture = tsel:GetSelectedTexture();
				dyntexture = chk_dyntexture:GetChecked();
				tex = tex:GetSelection();
				cd = cd:GetSelectedCooldown();
				cdTimerType = nil;
				cdGfxReverse = nil;
				cdHideTxt = nil;
				cdFont = nil;
				cdTxtType = nil;
				cdoffx = nil;
				cdoffy = nil;
				gt = gt:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		local font = VFL.copy(Fonts.Default); font.size = 8; font.justifyV = "CENTER"; font.justifyH = "CENTER";
		return { 
			feature = "texture_cooldown";
			version = 1;
			name = "texcd1";
			owner = "decor";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			w = 36; h = 36;
			externalButtonSkin = "bs_default";
			ButtonSkinOffset = 0;
			cd = VFL.copy(VFLUI.defaultCooldown);
		};
	end;
});
