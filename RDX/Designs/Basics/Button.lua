-- Button.lua
-- OpenRDX
-- Sigg Rashgarroth EU

local _menus = {
	{ text = "RDXPM.CompactMenu" },
	{ text = "RDXPM.CharacterMenu" },
	{ text = "RDXPM.GuildMenu" },
	{ text = "RDXPM.DuiMenu" },
	{ text = "RDXPM.ObjectMenu" },
	{ text = "RDXPM.MainMenu" },
};
local function _dd_menus() return _menus; end

RDX.RegisterFeature({
	name = "button2";
	version = 1; 
	title = VFLI.i18n("Button"); 
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
		if desc.ftype == 1 or desc.ftype == 2 or desc.ftype == 3 then
			flg = flg and RDXUI.UFFrameCheck_Proto("Button_", desc, state, errs);
			flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
			flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
			if flg then state:AddSlot("Button_" .. desc.name); end
		end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Button_" .. desc.name;
		if not desc.editor then desc.editor = ""; end
		local rdxmenu = desc.rdxmenu or "RDXPM.CompactMenu";
		
		-- common code
		local createCode = [[
	local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
	btn = VFLUI.AcquireFrame("Button");
	btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
	btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
	btn:Show();
	btn:RegisterForClicks("AnyUp");
]];
		if (type(desc.hlt) == "table") then
			createCode = createCode .. [[
	local _tex = VFLUI.CreateTexture(btn);
	_tex:SetAllPoints(btn);
	btn.hltTex = _tex;
	btn:SetHighlightTexture(_tex);
]] .. VFLUI.GenerateSetTextureCode("_tex", desc.hlt);
      		end
      		
      		if (type(desc.nt) == "table") then
			createCode = createCode .. [[
	local _tex = VFLUI.CreateTexture(btn);
	_tex:SetAllPoints(btn);
	btn.ntTex = _tex;
	btn:SetNormalTexture(_tex);
]] .. VFLUI.GenerateSetTextureCode("_tex", desc.nt);
      		end
      		
     		createCode = createCode .. [[
	frame.]] .. objname .. [[ = btn;
]];		

		local destroyCode = "";
		local paintCode = "";
		
		
		if desc.ftype == 1 then
		
		------------------ On frame creation
			createCode = createCode .. [[
	btn:SetScript("OnClick", function() ]] .. desc.editor .. [[ end);
]];
			if desc.gt then
				local gtType = __RDX_GetGameTooltipType(desc.gt);
				createCode = createCode .. [[
	btn:SetScript("OnEnter", ]] .. gtType .. [[);
	btn:SetScript("OnLeave", __RDX_OnLeave);
]];
			end

			if desc.gt and desc.gt ~= "" then
		------------------- Paint
			paintCode = [[
	frame.]] .. objname .. [[.gtid = ]] .. desc.gt .. [[;
]];
			end
		elseif desc.ftype == 2 then
			createCode = createCode .. [[
	btn:SetScript("OnClick", function(self) 
		]] .. rdxmenu .. [[:Open();
	end);
]];
		elseif desc.ftype == 3 then
			createCode = createCode .. [[
	btn:SetScript("OnClick", function(self) 
		RDXDK.FrameProperties(RDXDK.GetCurrentDesktop():_GetFrame(windowpath));
	end);
]];
		end
		
		------------------ On frame destruction.
		destroyCode = [[
		if frame.]] .. objname .. [[.hltTex then
			frame.]] .. objname .. [[.hltTex:Destroy();
			frame.]] .. objname .. [[.hltTex = nil;
		end
		if frame.]] .. objname .. [[.ntTex then
			frame.]] .. objname .. [[.ntTex:Destroy();
			frame.]] .. objname .. [[.ntTex = nil;
		end
		frame.]] .. objname .. [[.gtid = nil;
		frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, {"Frame_", "Button_", "Cooldown_", });
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Common Parameters")));
		
		local chk_hlt = VFLUI.CheckEmbedRight(parent, VFLI.i18n("Highlight")); chk_hlt:Show();
		local tsel = VFLUI.MakeTextureSelectButton(chk_hlt); tsel:Show();
		chk_hlt:EmbedChild(tsel);
		if desc and desc.hlt then
			chk_hlt:SetChecked(true); tsel:SetSelectedTexture(desc.hlt);
		else
			chk_hlt:SetChecked();
		end
		ui:InsertFrame(chk_hlt);
		
		local chk_nt = VFLUI.CheckEmbedRight(parent, VFLI.i18n("Normal")); chk_nt:Show();
		local tsel2 = VFLUI.MakeTextureSelectButton(chk_nt); tsel2:Show();
		chk_nt:EmbedChild(tsel2);
		if desc and desc.nt then
			chk_nt:SetChecked(true); tsel2:SetSelectedTexture(desc.nt);
		else
			chk_nt:SetChecked();
		end
		ui:InsertFrame(chk_nt);
		
		local ftype = VFLUI.DisjointRadioGroup:new();
		local ftype_1 = ftype:CreateRadioButton(ui);
		ftype_1:SetText(VFLI.i18n("Use Custom Button"));
		local ftype_2 = ftype:CreateRadioButton(ui);
		ftype_2:SetText(VFLI.i18n("Use Menu RDX Button"));
		local ftype_3 = ftype:CreateRadioButton(ui);
		ftype_3:SetText(VFLI.i18n("Use Menu Window Button"));
		ftype:SetValue(desc.ftype or 1);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Custom Button")));
		ui:InsertFrame(ftype_1);
		
		local gt = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("GameTooltip"), state, "GameTooltips_");
		if desc and desc.gt then gt:SetSelection(desc.gt); end

		local editor = VFLUI.TextEditor:new(ui, "LuaEditBox");
		editor:SetHeight(200); editor:Show();
		editor:SetText(desc.editor or "");
		editor:GetEditWidget():SetFocus();
		ui:InsertFrame(editor);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Menu RDX Button")));
		ui:InsertFrame(ftype_2);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("RDX Menu Type"));
		local dd_rdxmenu = VFLUI.Dropdown:new(er, _dd_menus);
		dd_rdxmenu:SetWidth(200); dd_rdxmenu:Show();
		if desc and desc.rdxmenu then 
			dd_rdxmenu:SetSelection(desc.rdxmenu); 
		else
			dd_rdxmenu:SetSelection("RDXPM.CompactMenu");
		end
		er:EmbedChild(dd_rdxmenu); er:Show();
		ui:InsertFrame(er);
		
		ui:InsertFrame(VFLUI.Separator:new(ui, VFLI.i18n("Menu Window Button")));
		ui:InsertFrame(ftype_3);
		
		function ui:GetDescriptor()
			local hlt = nil; if chk_hlt:GetChecked() then hlt = tsel:GetSelectedTexture(); end
			local nt = nil; if chk_nt:GetChecked() then nt = tsel2:GetSelectedTexture(); end
			return { 
				feature = "button2"; version = 1;
				name = ed_name.editBox:GetText();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				owner = owner:GetSelection();
				anchor = anchor:GetAnchorInfo();
				hlt = hlt;
				nt = nt;
				ftype = ftype:GetValue();
				gt = gt:GetSelection();
				editor = editor:GetText();
				rdxmenu = dd_rdxmenu:GetSelection();
			};
		end
		
		ui.Destroy = VFL.hook(function(s) 
			ftype:Destroy(); ftype = nil;
		end, ui.Destroy);

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "button2"; version = 1; 
			name = "btn1";
			w = 30; h = 30;
			 owner = "Frame_decor";
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			hlt = { path = "Interface\\QuestFrame\\UI-QuestTitleHighlight", blendMode = "ADD" };
			ftype = 1;
		};
	end;
});

RDX.RegisterFeature({
	name = "artbutton";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "button2";
		desc.ftype = 1;
	end;
});

RDX.RegisterFeature({
	name = "buttonmenurdx";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "button2";
		desc.ftype = 2;
	end;
});

RDX.RegisterFeature({
	name = "buttonrdx";
	version = 31338;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "button2";
		desc.ftype = 3;
	end;
});

