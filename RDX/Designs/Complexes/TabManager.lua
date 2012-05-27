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
local cn = RDX.CreateChatChannelList(GetChannelList());
local md,_,_,ty = RDXDB.GetObjectData("]] .. desc.cfm .. [[");
if (md) and (ty == "TabManager") and (md.data) then
	local count, title = 0, "";
	for k,v in pairs(md.data.cfm) do
		local md2,_,_,ty2 = RDXDB.GetObjectData(v.op);
		if (md2) and (ty2 == "ChatFrame") and (md2.data) then
			count = count + 1;
			local cf = VFLUI.AcquireFrame("ChatFrame");
			if count == 1 then title = md2.data.title; end
			VFLUI.SetFont(cf, ]] .. Serialize(desc.font) .. [[);
			
			for k,v in pairs(md2.data.discussion) do
				ChatFrame_AddMessageGroup(cf, k);
			end
			for k,v in pairs(md2.data.creature) do
				ChatFrame_AddMessageGroup(cf, k);
			end
			for k,v in pairs(md2.data.combat) do
				ChatFrame_AddMessageGroup(cf, k);
			end
			for k,v in pairs(md2.data.pvp) do
				ChatFrame_AddMessageGroup(cf, k);
			end
			for k,v in pairs(md2.data.system) do
				ChatFrame_AddMessageGroup(cf, k);
			end
			for k,v in pairs(md2.data.channels) do
				for k2,v2 in ipairs(cn) do
					if v2.type == k then
						ChatFrame_AddChannel(cf, v2.channelName);
					end
				end
			end
			tabbox:GetTabBar():AddTab("80", function(self) tabbox:SetClient(cf, true); ChatEdit_SetLastActiveWindow(cf.editBox); end, function() end):SetText(md2.data.title);
			tabbox.cfs["cf" .. count] = cf;
		end
	end
	
	DesktopEvents:Bind("INIT_POST_DESKTOP", nil, function() tabbox:GetTabBar():SelectTabName(title); end, "tabmanager]] .. objname .. [[");
	
end

frame.]] .. objname .. [[ = tabbox;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
DesktopEvents:Unbind("tabmanager]] .. objname .. [[");
local btn = frame.]] .. objname .. [[;
for k,v in pairs(tabbox.cfs) do
	v:Destroy(); v = nil;
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
		};
	end;
});



