-- LDBObject.lua
-- OpenRDX
-- Sigg Rashgarroth EU

local LDB, LDB_init = nil, false;
if LibStub then LDB = LibStub("LibDataBroker-1.1", true); end
if LDB then LDB_init = true; end

---------------------------------------
-- Helper tooltips and click
---------------------------------------

local function SetTooltipAnchor(localframe, remoteFrame)
	localframe:SetOwner(remoteFrame, "ANCHOR_NONE");
	localframe:ClearAllPoints();
	localframe:SetPoint("TOPLEFT", remoteFrame, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(RDXParent));
end

local function LDB_OnEnter(self)
	local obj  = self.obj
	local name = self.name
	if obj.tooltip then -- obj.tooltip is a frame
		SetTooltipAnchor(obj.tooltip, self)
		obj.tooltip:Show();
	elseif obj.OnTooltipShow then -- obj.OnTooltipShow is a function
		SetTooltipAnchor(GameTooltip, self)
		obj.OnTooltipShow(GameTooltip)
		GameTooltip:Show();
	elseif obj.tooltiptext then -- obj.OnTooltipShow is a string deprecated
		SetTooltipAnchor(GameTooltip, self)
		GameTooltip:SetText(obj.tooltiptext);
		GameTooltip:Show();		
	elseif obj.OnEnter then
		obj.OnEnter(self);
	end
end

local function LDB_OnLeave(self)
	local obj  = self.obj
	local name = self.name
	--if MouseIsOver(GameTooltip) and (obj.tooltiptext or obj.OnTooltipShow) then return; end
	
	if obj.tooltip then obj.tooltip:Hide(); end
	if obj.OnTooltipShow or obj.tooltiptext then GameTooltip:Hide(); end
	if obj.OnLeave then
		obj.OnLeave(self)
	end
end

local function LDB_OnClick(self, ...)
	local obj  = self.obj
	local name = self.name
	
	if obj.tooltip then obj.tooltip:Hide(); end
	if obj.OnTooltipShow or obj.tooltiptext then GameTooltip:Hide(); end
	if obj.OnLeave then
		obj.OnLeave(self)
	end
	
	if obj.OnClick then
		obj.OnClick(self, ...)
	end
end

--------------------------------------------------------
-- LDB Object pool
-- Use to store all LDB objects.
--------------------------------------------------------

VFLUI.CreateFramePool("LDBObjects",
	function(pool, ldbo) -- on released
		if (not ldbo) then return; end
		ldbo:SetScript("OnClick", nil);
		ldbo:SetScript("OnEnter", nil);
		ldbo:SetScript("OnLeave", nil);
		ldbo.tex:Hide();
		ldbo.text:Hide();
		ldbo:Hide();
		ldbo:Disable();
		LDB.UnregisterCallback(ldbo, "LibDataBroker_AttributeChanged_" .. ldbo.name);
		--VFLT.AdaptiveUnschedule("LDBObject".. ldbo.name);
		VFLUI._CleanupLayoutFrame(ldbo);
	end,
	function(_, key) -- create
		if not LDB_init then return nil; end
		local obj = LDB:GetDataObjectByName(key);
		if not obj then return nil; end
		local ldbo = CreateFrame("Button", "RDXLDBObject" .. key, nil);
		ldbo.name = key;
		ldbo.obj = obj;
		
		ldbo.tex = VFLUI.CreateTexture(ldbo);
		ldbo.tex:SetPoint("LEFT", ldbo, "LEFT", 0, 0);
		--ldbo.tex:SetTexCoord(0.08, 1-0.08, 0.08, 1-0.08);
		
		ldbo.text = VFLUI.CreateFontString(ldbo);
		ldbo.text:SetPoint("LEFT", ldbo.tex, "RIGHT", 1, 0);
		
		ldbo.Updater = function(_, event, name, key, value)
			local update = RDXUI.LDBUpdaters[key];
			if update then
				update(ldbo, ldbo.obj, name)
			end
		end
		
		if obj.OnCreate then
			obj.OnCreate(obj, ldbo);
		end
		
		return ldbo;
	end, 
	function(_, ldbo) -- on acquired
		if (not ldbo) then return; end
		ldbo:SetScript("OnClick", LDB_OnClick);
		ldbo:SetScript("OnEnter", LDB_OnEnter);
		ldbo:SetScript("OnLeave", LDB_OnLeave);
		ldbo:RegisterForClicks("AnyUp");
		ldbo.tex:Show();
		ldbo.text:Show();
		ldbo:Show();
		ldbo:Enable();
		LDB.RegisterCallback(ldbo, "LibDataBroker_AttributeChanged_" .. ldbo.name, "Updater");
		--VFLT.AdaptiveUnschedule("LDBObject".. ldbo.name);
		--VFLT.AdaptiveSchedule("LDBObject".. ldbo.name, 15, function()
		--	ldbo.Updater(_, _, ldbo.name, "text");
		--end);
	end,
	"key"
);

function RDXUI.GetLDBobjectsName()
	local t = {};
	if not LDB_init then
		table.insert(t, {text = "No LibStub available"});
	else
		table.insert(t, {text = "null"});
		for name,_ in LDB:DataObjectIterator() do
			table.insert(t, {text = name});
		end
	end
	return t;
end;

RDXUI.LDBUpdaters = {
	text = function(frame, obj, name, hide)
		if hide then 
			frame.text:Hide();
		else
			if obj.label then
				if obj.value then
					frame.text:SetFormattedText("%s: %s%s", obj.label, obj.value, obj.suffix or "")
				elseif obj.text and obj.text ~= obj.label then
					frame.text:SetFormattedText("%s: %s", obj.label, obj.text)
				else	
					frame.text:SetFormattedText("%s", obj.label)
				end
				frame.text:Show();
			elseif obj.text then
				if obj.value then
					frame.text:SetFormattedText("%s%s", obj.value, obj.suffix or "")
				else
					frame.text:SetFormattedText("%s", obj.text);
				end
				frame.text:Show();
			else
				frame.text:Hide();
			end
		end
	end,
	
	icon = function(frame, obj, name)
		if not obj.icon then
		    frame.text:SetPoint("LEFT", frame, "LEFT");
		    frame.text:SetPoint("RIGHT", frame, "RIGHT");
		    frame.tex:Hide();
		else
		    frame.tex:SetTexture(obj.icon);
		    frame.tex:Show();
		end
	end,
	
	texcoord = function(frame, obj, name)
		if obj.texcoord then
			frame.tex:SetTexCoord(unpack(obj.texcoord));
		end
	end,

	iconCoords = function(frame, obj, name)
		if obj.iconCoords then
			frame.tex:SetTexCoord(unpack(obj.iconCoords))
		end
	end,
}

RDX.RegisterFeature({
	name = "ldbobject"; 
	multiple = true; 
	version = 1; 
	title = VFLI.i18n("Button LDB"); 
	category = VFLI.i18n("Buttons");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not desc.ldbo or desc.ldbo == "null" then VFL.AddError(errs, VFLI.i18n("Invalid object LDB")); return nil; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		local hidelabel = "false"; if desc.hidelabel then hidelabel = "true"; end
		------------------ On frame creation
		local createCode = [[
local btn = VFLUI.AcquireFrame("LDBObjects", "]] .. desc.ldbo .. [[");
if btn then
	VFLUI.StdSetParent(btn, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
	btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
	
	]];
		createCode = createCode .. VFLUI.GenerateSetFontCode("btn.text", desc.font, nil, true);
		createCode = createCode .. [[
	
	btn.tex:SetHeight(]] .. desc.h .. [[);
	btn.tex:SetWidth(]] .. desc.h .. [[);
	btn.text:SetHeight(]] .. desc.h .. [[);
	btn.text:SetWidth(]] .. desc.w .. [[ - ]] .. desc.h .. [[);
	
	for key, func in pairs(RDXUI.LDBUpdaters) do
		func(btn, btn.obj, "]] .. desc.ldbo .. [[", hidelabel);
	end
else
	--RDX.printW("]] .. desc.ldbo .. [[ is not available or already acquired in an other LDBObject");
end

frame.]] .. objname .. [[ = btn;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
local btn = frame.]] .. objname .. [[;
if btn then btn:Destroy(); end
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
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("LDB Object"));
		local dd_ldbo = VFLUI.Dropdown:new(er, RDXUI.GetLDBobjectsName);
		dd_ldbo:SetWidth(150); dd_ldbo:Show();
		if desc and desc.ldbo then
			dd_ldbo:SetSelection(desc.ldbo);
		else
			dd_ldbo:SetSelection("null");
		end
		er:EmbedChild(dd_ldbo); er:Show();
		ui:InsertFrame(er);
		
		local er_font = VFLUI.EmbedRight(ui, VFLI.i18n("Font"));
		local fontsel = VFLUI.MakeFontSelectButton(er_font, desc.font); fontsel:Show();
		er_font:EmbedChild(fontsel); er_font:Show();
		ui:InsertFrame(er_font);
		
		local chk_hidelabel = VFLUI.Checkbox:new(ui); chk_hidelabel:Show();
		chk_hidelabel:SetText(VFLI.i18n("Hide label"));
		if desc and desc.hidelabel then chk_hidelabel:SetChecked(true); else chk_hidelabel:SetChecked(); end
		ui:InsertFrame(chk_hidelabel);
		
		function ui:GetDescriptor()
			return { 
				feature = "ldbobject"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				ldbo = dd_ldbo:GetSelection();
				font = fontsel:GetSelectedFont();
				hidelabel = chk_hidelabel:GetChecked();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "ldbobject"; version = 1; 
			name = "ldbo1", owner = "decor";
			w = 140; h = 20;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			font = VFL.copy(Fonts.Default);
		};
	end;
});

