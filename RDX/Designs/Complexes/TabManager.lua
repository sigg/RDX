-- OpenRDX

-- tabmanager
-- backdrop
-- font

RDX.RegisterFeature({
	name = "tabmanager";
	version = 1;
	title = VFLI.i18n("RDX Tab Manager");
	multiple = true;
	category = VFLI.i18n("Complexes");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if not desc.orientation then desc.orientation = "TOP"; end
		if not desc.bkd then desc.bkd = { edgeFile="Interface\\Addons\\VFL\\Skin\\HalBorder"; edgeSize = 8; insets = { left = 2, right = 2, top = 2, bottom = 2 }; _bkdtype = 1; borl = 2; bors = 1; }; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if desc.cfm and desc.cfm ~= "" then
			if not RDXDB.CheckObject(desc.cfm, "TabManager") then VFL.AddError(errs, VFLI.i18n("Invalid TabManager")); flg = nil; end
		end
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		------------------ On frame creation
		local createCode = [[
	if not RDXDB.PathHasInstance("]] .. desc.cfm .. [[") then
		local tm = RDXDB.GetObjectInstance("]] .. desc.cfm .. [[", nil, ]] .. Serialize(desc) .. [[);
		tm.tabbox:SetParent(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
		tm.tabbox:SetFrameLevel(frame:GetFrameLevel());
		tm.tabbox:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
		tm.tabbox:SetWidth(]] .. desc.w .. [[); tm.tabbox:SetHeight(]] .. desc.h .. [[);
		VFLUI.SetBackdrop(tm.tabbox, nil);
		tm.tabbox:Show();

		VFLT.NextFrame(math.random(10000000), function()
			tm.tabbox:GetTabBar():SelectTabId(1);
		end);
		
		--tm.tabbox:GetTabBar():SetBackdropTab(]] .. Serialize(desc.bkd) .. [[);
		--tm.tabbox:GetTabBar():SetFontTab(]] .. Serialize(desc.font) .. [[);
		frame.]] .. objname .. [[ = tm;
	else
		local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
		btn = VFLUI.AcquireFrame("Frame");
		btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
		btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
		btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
		VFLUI.SetBackdrop(btn, ]] .. Serialize(desc.bkd) .. [[);
		btn:Show();
		btn.error = true;
		frame.]] .. objname .. [[ = btn;
	end
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
		local tm = frame.]] .. objname .. [[;
		if tm then
			if tm.error then
				tm.error = nil;
				tm:Destroy();
			else
				RDXDB._RemoveInstance("]] .. desc.cfm .. [[");
			end
			frame.]] .. objname .. [[ = nil;
		end
]];
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
		
		local cfmsel = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "TabManager")); end);
		cfmsel:SetLabel(VFLI.i18n("Tab Manager")); cfmsel:Show();
		if desc and desc.cfm then cfmsel:SetPath(desc.cfm); end
		ui:InsertFrame(cfmsel);
		
		--local er_ts = VFLUI.EmbedRight(ui, VFLI.i18n("Timestamp type"));
		--local dd_ts = VFLUI.Dropdown:new(er_ts, VFL.ASDateListSelectionFunc);
		--dd_ts:SetWidth(150); dd_ts:Show();
		--if desc and desc.ts then
		--	dd_ts:SetSelection(desc.ts);
		--else
		--	dd_ts:SetSelection("None");
		--end
		--er_ts:EmbedChild(dd_ts); er_ts:Show();
		--ui:InsertFrame(er_ts);
		
		--local color = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Timestamp color"));
		--if desc and desc.color then color:SetColor(VFL.explodeRGBA(desc.color)); end
		
		--local chk_channel = VFLUI.Checkbox:new(ui); chk_channel:Show();
		--chk_channel:SetText(VFLI.i18n("Minimize channel name"));
		--if desc and desc.channel then chk_channel:SetChecked(true); else chk_channel:SetChecked(); end
		--ui:InsertFrame(chk_channel);
		
		-- Orientation
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Orientation"));
		local dd_orientation = VFLUI.Dropdown:new(er, RDXUI.InserModeDropdownFunction);
		dd_orientation:SetWidth(150); dd_orientation:Show();
		if desc and desc.orientation then 
			dd_orientation:SetSelection(desc.orientation); 
		else
			dd_orientation:SetSelection("TOP");
		end
		er:EmbedChild(dd_orientation); er:Show();
		ui:InsertFrame(er);
		
		local er_font = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er_font, desc.font); fontsel:Show();
		er_font:EmbedChild(fontsel); er_font:Show();
		ui:InsertFrame(er_font);
		
		--local chk_fading = VFLUI.Checkbox:new(ui); chk_fading:Show();
		--chk_fading:SetText(VFLI.i18n("Fading"));
		--if desc and desc.fading then chk_fading:SetChecked(true); else chk_fading:SetChecked(); end
		--ui:InsertFrame(chk_fading);
		
		-- Backdrop
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop style"));
		local bkd = VFLUI.MakeBackdropSelectButton(er, desc.bkd); bkd:Show();
		er:EmbedChild(bkd); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "tabmanager"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				cfm = cfmsel:GetPath();
				--ts = dd_ts:GetSelection();
				--color = color:GetColor();
				--channel = chk_channel:GetChecked();
				orientation = dd_orientation:GetSelection();
				font = fontsel:GetSelectedFont();
				--fading = chk_fading:GetChecked();
				bkd = bkd:GetSelectedBackdrop();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "tabmanager"; version = 1; 
			name = "cf1", owner = "Frame_decor";
			w = 400; h = 200;
			anchor = { lp = "TOPLEFT", af = "Frame_decor", rp = "TOPLEFT", dx = 0, dy = 0};
			cfm = "default:TabManager1_tm";
			ts = "None";
			color = {r=1,g=1,b=1,a=1};
			font = VFL.copy(Fonts.Default);
			bkd =  { edgeFile="Interface\\Addons\\VFL\\Skin\\tab_top", edgeSize = 16, insets = { left = 5, right = 5, top = 4, bottom = 0 } };
		};
	end;
});



