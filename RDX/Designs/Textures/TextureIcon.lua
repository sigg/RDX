-- OpenRDX

local IconsIndex = {};
local Icons = {};

function RDX.RegisterTextureIcon(tbl)
	if (type(tbl) ~= "table") or (type(tbl.name) ~= "string") then return; end
	if statusText[tbl.name] then RDX.printW("Attempt to register duplicate Icon Type " .. tbl.name); return; end
	Icons[tbl.name] = tbl;
	table.insert(IconsIndex, {value = tbl.name, text = tbl.title});
end

RDX.RegisterFeature({
	name = "tex_icon";
	title = VFLI.i18n("Icon");
	category = VFLI.i18n("Textures");
	multiple = true;
	test = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not desc.class then desc.class = "Faction"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		local ebsflag, ebs, ebsos = "false", "bs_default", 0;
		if desc.externalButtonSkin then
			ebsflag = "true";
			ebs = desc.externalButtonSkin;
			if desc.ButtonSkinOffset then ebsos = desc.ButtonSkinOffset; end
		end
		------------------ On frame creation
		local createCode = [[
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
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode([[
VFLUI.ReleaseRegion(frame.]] .. objname .. [[._t); frame.]] .. objname .. [[._t = nil;
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]]); end);
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
frame.]] .. objname .. [[:Hide();
]]); end);

		------------------ On paint.
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
		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Drawlayer
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Draw layer"));
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(100); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
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
		
		-- Drawlayer
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Icon Type"));
		local dd_class = VFLUI.Dropdown:new(er, function() return IconsIndex; end);
		dd_class:SetWidth(100); dd_class:Show();
		if desc and desc.class then dd_class:SetSelection(desc.class); else dd_class:SetSelection("Faction"); end
		er:EmbedChild(dd_class); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			local ebs = nil;
			if chk_bs:GetChecked() then ebs = dd_buttonSkin:GetSelection(); end
			return { 
				feature = "tex_icon",
				name = ed_name.editBox:GetText(),
				owner = owner:GetSelection();
				drawLayer = drawLayer:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				externalButtonSkin = ebs;
				ButtonSkinOffset = VFL.clamp(ed_bs.editBox:GetNumber(), 0, 50);
				class = dd_class:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "tex_icon", name = "Icon1", owner = "decor", drawLayer = "ARTWORK";
			w = 14; h = 14;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			ButtonSkinOffset = 10;
		};
	end;
});