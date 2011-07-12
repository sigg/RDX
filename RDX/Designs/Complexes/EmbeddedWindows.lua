-- EmbeddedWindows.lua
-- OpenRDX
-- Sigg Rashgarroth EU
-- disable too much problem see toc file
-- deprecated

local wl = {};

local function BuildWindowList(class)
	VFL.empty(wl);
	local desc = nil;
	for pkg,data in pairs(RDXData) do
		for file,md in pairs(data) do
			if (type(md) == "table") and md.data and md.ty and string.find(md.ty, class) then
				table.insert(wl, {text = RDXDB.MakePath(pkg, file)});
			end
		end
	end
	table.sort(wl, function(x1,x2) return x1.text<x2.text; end);
end

local function _fnListWindows() BuildWindowList("Window"); return wl; end
local function _fnListStatusWindows() BuildWindowList("StatusWindow"); return wl; end

RDX.RegisterFeature({
	name = "emb_windows";
	version = 1;
	title = VFLI.i18n("Embedded Window");
	category = VFLI.i18n("Complexes");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.wind == nil or desc.wind == "" then VFL.AddError(errs, VFLI.i18n("Missing window.")); return nil; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		
		------------------ On frame creation
		local createCode = [[
local wind = RDXDB._GetObject("]] .. desc.wind .. [[", "Instantiate", true);
if wind then
	VFLUI.StdSetParent(wind, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
	wind:WMGetPositionalFrame():SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
	
	local function winUpdate(name, scale, alpha, strata)
		if name == "]] .. desc.wind .. [[" then
			wind:SetScale(scale);
			wind:SetAlpha(alpha);
			wind:WMGetPositionalFrame():SetFrameStrata(strata);
		end
	end
	wind.winUpdate = winUpdate;
	
	DesktopEvents:Bind("EMBEDDEDWINDOW_UPDATE", nil, wind.winUpdate, "desktop_]] .. objname ..[[");
	wind:Show();
else
	RDX.printW("Windows is not available or already acquired");
end
frame.]] .. objname .. [[ = wind;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
if frame.]] .. objname .. [[ then
	DesktopEvents:Unbind("desktop_]] .. objname ..[[");
	frame.]] .. objname .. [[.winUpdate = nil;
	--RDXDB._RemoveInstance("]] .. desc.wind .. [[", true);
	frame.]] .. objname .. [[:Destroy();
	frame.]] .. objname .. [[._path = nil;
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
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_", true);
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local er, dd_windowId;
		
		er = VFLUI.EmbedRight(ui, VFLI.i18n("Window:"));
		dd_windowId = VFLUI.Dropdown:new(er, _fnListWindows, nil, nil, nil, 30);
		dd_windowId:SetWidth(250); dd_windowId:Show();
		if desc and desc.wind then 
			dd_windowId:SetSelection(desc.wind); 
		end
		er:EmbedChild(dd_windowId); er:Show();
		ui:InsertFrame(er);
		
		local ed_scale = VFLUI.LabeledEdit:new(ui, 50); ed_scale:Show();
		ed_scale:SetText(VFLI.i18n("Scale:"));
		if desc and desc.scale then ed_scale.editBox:SetText(desc.scale); end
		ui:InsertFrame(ed_scale);
		
		local ed_alpha = VFLUI.LabeledEdit:new(ui, 50); ed_alpha:Show();
		ed_alpha:SetText(VFLI.i18n("Alpha: "));
		if desc and desc.alpha then ed_alpha.editBox:SetText(desc.alpha); end
		ui:InsertFrame(ed_alpha);
		
		function ui:GetDescriptor()
			return { 
				feature = "emb_windows"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				wind = dd_windowId:GetSelection();
				scale = VFL.clamp(ed_scale.editBox:GetNumber(), 0.1, 2);
				alpha = VFL.clamp(ed_alpha.editBox:GetNumber(), 0.1, 2);
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "emb_windows"; version = 1; 
			name = "emb1", owner = "Base";
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			scale = 1; alpha = 1;
		};
	end;
});

