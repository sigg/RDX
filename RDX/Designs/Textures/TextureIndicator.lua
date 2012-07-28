-- OpenRDX

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

RDX.RegisterFeature({
	name = "tex_indicator";
	title = VFLI.i18n("Indicator");
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
		if state:Slot("Tx_rdx_" .. desc.class) then
			VFL.AddError(errs, VFLI.i18n("Texture Indicator class already add")); return nil;
		end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); state:AddSlot("Tx_rdx_" .. desc.class); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local path = Indicators[desc.class].set.file; local afname = desc.name;
		state:GetContainingWindowState():Attach("Menu", true, function(win, mnu)
			table.insert(mnu, {
				text = VFLI.i18n("Edit Indicator: ") .. afname;
				OnClick = function()
					VFL.poptree:Release();
					RDXDB.OpenObject(path, "Edit", VFLDIALOG);
				end;
			});
		end);
		local objname = "Frame_" .. desc.name;
		------------------ On frame creation
		local createCode = [[
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
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode([[
VFLUI.ReleaseRegion(frame.]] .. objname .. [[._t); frame.]] .. objname .. [[._t = nil;
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;
]]); end);
		-- On closure, acquire the set locally
		state:Attach(state:Slot("EmitClosure"), true, function(code) code:AppendCode(Indicators[desc.class].emitClosureCode); end);
		
		state:Attach(state:Slot("EmitCleanup"), true, function(code) code:AppendCode([[
frame.]] .. objname .. [[:Hide();
]]); end);

		------------------ On paint.
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

		-- Drawlayer
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Draw layer"));
		local drawLayer = VFLUI.Dropdown:new(er, RDXUI.DrawLayerDropdownFunction);
		drawLayer:SetWidth(100); drawLayer:Show();
		if desc and desc.drawLayer then drawLayer:SetSelection(desc.drawLayer); else drawLayer:SetSelection("ARTWORK"); end
		er:EmbedChild(drawLayer); er:Show();
		ui:InsertFrame(er);
		
		-- SubLevel
		local ed_sublevel = VFLUI.LabeledEdit:new(ui, 50); ed_sublevel:Show();
		ed_sublevel:SetText(VFLI.i18n("TextureLevel offset"));
		if desc and desc.sublevel then ed_sublevel.editBox:SetText(desc.sublevel); end
		ui:InsertFrame(ed_sublevel);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Indicator Type"));
		local dd_class = VFLUI.Dropdown:new(er, function() return IndicatorIndex; end);
		dd_class:SetWidth(200); dd_class:Show();
		if desc and desc.class then dd_class:SetSelection(desc.class); else dd_class:SetSelection("Blue"); end
		er:EmbedChild(dd_class); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return { 
				feature = "tex_indicator",
				name = ed_name.editBox:GetText(),
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				drawLayer = drawLayer:GetSelection();
				sublevel = VFL.clamp(ed_sublevel.editBox:GetNumber(), 1, 20);
				class = dd_class:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "tex_indicator", name = "Indicator1", owner = "decor", drawLayer = "ARTWORK";
			w = 4; h = 4; sublevel = 2; class = "Blue";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
		};
	end;
});