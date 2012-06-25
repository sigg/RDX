-- OpenRDX

-- tabmanager
-- backdrop
-- font

RDX.RegisterFeature({
	name = "tabmanager";
	version = 1;
	title = VFLI.i18n("RDX Tab Manager");
	category = VFLI.i18n("Complexes");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not desc.bkd then desc.bkd = { edgeFile="Interface\\Addons\\VFL\\Skin\\tab_top", edgeSize = 16, insets = { left = 5, right = 5, top = 4, bottom = 0 } }; end
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
local tabbox = VFLUI.TabBox:new(]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[, 22, "TOP");
tabbox:SetFrameLevel(frame:GetFrameLevel());
tabbox:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
tabbox:SetWidth(]] .. desc.w .. [[); tabbox:SetHeight(]] .. desc.h .. [[);
tabbox:SetBackdrop(nil);
tabbox:Show();
tabbox.cfs = {};
--local cn = RDX.CreateChatChannelList(GetChannelList());
local md,_,_,ty = RDXDB.GetObjectData("]] .. desc.cfm .. [[");
if (md) and (ty == "TabManager") and (md.data) then
	local count, title = 0, "";
	for k,v in pairs(md.data.cfm) do
		local md2,_,_,ty2 = RDXDB.GetObjectData(v.op);
		if (md2) and (ty2 == "ChatFrame") and (md2.data) then
			count = count + 1;
			local flag = RDXDB.GetObjectInstance(v.op, true);
			local f, tab;
			if not md2.data.tabwidth then md2.data.tabwidth = 80; end
			if flag then
				f = VFLUI.SimpleText:new(nil, 5, 100);
				f._path = nil;
				f:SetText("Already acquired !");
				VFLUI.SetBackdrop(f, ]] .. Serialize(desc.bkd) .. [[);
				tab = tabbox:GetTabBar():AddTab(md2.data.tabwidth, function(self, arg1) tabbox:SetClient(f, true); end, function() end);
			else
				f = RDXDB.GetObjectInstance(v.op);
				local _, _, _, _, objdesc = RDXDB.GetObjectData(v.op);
				f._path = v.op;
				VFLUI.SetBackdrop(f.cfbg, ]] .. Serialize(desc.bkd) .. [[);
				VFLUI.SetBackdrop(f.ebbg, ]] .. Serialize(desc.bkd) .. [[);
				VFLUI.SetFont(f.cf, ]] .. Serialize(desc.font) .. [[);
				tab = tabbox:GetTabBar():AddTab(md2.data.tabwidth, function(self, arg1)
					tabbox:SetClient(f, true); ChatEdit_SetLastActiveWindow(f.cf.editBox);
				end, function() end, function(mnu, dlg) return objdesc.GenerateBrowserMenu(mnu, v.op, nil, dlg) end);
			end
			tab.font:SetText(md2.data.title);
			f.tab = tab;
			tabbox.cfs["cf" .. count] = f;
		elseif (md2) and (ty2 == "CombatLogs") and (md2.data) then
			count = count + 1;
			local flag = RDXDB.GetObjectInstance(v.op, true);
			local f, tab;
			if not md2.data.tabwidth then md2.data.tabwidth = 80; end
			if flag then
				f = VFLUI.SimpleText:new(nil, 5, 100);
				f._path = nil;
				f:SetText("Already acquired !");
				VFLUI.SetBackdrop(f, ]] .. Serialize(desc.bkd) .. [[);
				tab = tabbox:GetTabBar():AddTab(md2.data.tabwidth, function(self, arg1) tabbox:SetClient(f, true); end, function() end);
			else
				f = RDXDB.GetObjectInstance(v.op);
				local _, _, _, _, objdesc = RDXDB.GetObjectData(v.op);
				f._path = v.op;
				VFLUI.SetBackdrop(f, ]] .. Serialize(desc.bkd) .. [[);
				f.font = ]] .. Serialize(desc.font) .. [[;
				tab = tabbox:GetTabBar():AddTab(md2.data.tabwidth, 
					function(self, arg1) tabbox:SetClient(f, true); end, 
					function() end,
					function(mnu, dlg) return objdesc.GenerateBrowserMenu(mnu, v.op, nil, dlg) end
				);
			end
			tab.font:SetText(md2.data.title);
			f.tab = tab;
			tabbox.cfs["cf" .. count] = f;
		end
	end
	
	VFLT.NextFrame(math.random(10000000), function()
		tabbox:GetTabBar():SelectTabId(1);
	end);
end

tabbox:GetTabBar():SetBackdropTab(]] .. Serialize(desc.bkd) .. [[);
tabbox:GetTabBar():SetFontTab(]] .. Serialize(desc.font) .. [[);
frame.]] .. objname .. [[ = tabbox;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
local btn = frame.]] .. objname .. [[;
for k,v in pairs(tabbox.cfs) do
	v.tab = nil;
	if v._path then
		v.font = nil;
		RDXDB._RemoveInstance(v._path); v = nil;
	else
		v:Destroy(); v = nil;
	end
end
btn:Destroy(); btn = nil; 
frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

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
		
		local cfmsel = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "TabManager")); end);
		cfmsel:SetLabel(VFLI.i18n("Tab Manager")); cfmsel:Show();
		if desc and desc.cfm then cfmsel:SetPath(desc.cfm); end
		ui:InsertFrame(cfmsel);
		
		local er_ts = VFLUI.EmbedRight(ui, VFLI.i18n("Timestamp type"));
		local dd_ts = VFLUI.Dropdown:new(er_ts, VFL.ASDateListSelectionFunc);
		dd_ts:SetWidth(150); dd_ts:Show();
		if desc and desc.ts then
			dd_ts:SetSelection(desc.ts);
		else
			dd_ts:SetSelection("None");
		end
		er_ts:EmbedChild(dd_ts); er_ts:Show();
		ui:InsertFrame(er_ts);
		
		local color = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Timestamp color"));
		if desc and desc.color then color:SetColor(VFL.explodeRGBA(desc.color)); end
		
		local chk_channel = VFLUI.Checkbox:new(ui); chk_channel:Show();
		chk_channel:SetText(VFLI.i18n("Minimize channel name"));
		if desc and desc.channel then chk_channel:SetChecked(true); else chk_channel:SetChecked(); end
		ui:InsertFrame(chk_channel);
		
		local er_font = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er_font, desc.font); fontsel:Show();
		er_font:EmbedChild(fontsel); er_font:Show();
		ui:InsertFrame(er_font);
		
		local chk_fading = VFLUI.Checkbox:new(ui); chk_fading:Show();
		chk_fading:SetText(VFLI.i18n("Fading"));
		if desc and desc.fading then chk_fading:SetChecked(true); else chk_fading:SetChecked(); end
		ui:InsertFrame(chk_fading);
		
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
				ts = dd_ts:GetSelection();
				color = color:GetColor();
				channel = chk_channel:GetChecked();
				font = fontsel:GetSelectedFont();
				fading = chk_fading:GetChecked();
				bkd = bkd:GetSelectedBackdrop();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "tabmanager"; version = 1; 
			name = "cf1", owner = "decor";
			w = 400; h = 200;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			cfm = "default:ChatFrames_tm";
			ts = "None";
			color = {r=1,g=1,b=1,a=1};
			font = VFL.copy(Fonts.Default);
			bkd =  { edgeFile="Interface\\Addons\\VFL\\Skin\\tab_top", edgeSize = 16, insets = { left = 5, right = 5, top = 4, bottom = 0 } };
		};
	end;
});



