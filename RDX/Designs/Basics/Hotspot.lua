-- Hotspot.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
-- 
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
-- 
-- A Hotspot is a separate clickable subregion of a window.
-- (edited by SuperRaider for support of mouseover tooltips)

RDX.RegisterFeature({
	name = "hotspot";
	title = VFLI.i18n("Hotspot");
	category = VFLI.i18n("Basics");
	multiple = true;
	version = 1;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitCreate") then return nil; end
		if not state:Slot("EmitDestroy") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		local n = desc.name;
		if (type(n) ~= "string") then
			VFL.AddError(errs, VFLI.i18n("Invalide hotspot name")); return nil;
		end
		n = strtrim(n);
		if (n ~= "") and (not RDXDB.IsValidFileName(n)) then
			VFL.AddError(errs, VFLI.i18n("Object names must be alphanumeric")); return nil;
		end
		if state:Slot("Hotspot_" .. n) or state:Slot("Frame_" .. n) then
			VFL.AddError(errs, VFLI.i18n("Duplicate variable name")); return nil;
		end
		--if (not tonumber(desc.w)) or (not tonumber(desc.h)) then
		--	VFL.AddError(errs, VFLI.i18n("Bad or missing width/height parameters")); return nil;
		--end
		if (not desc.anchor) or (not desc.anchor.af) or desc.anchor.af ~= "Base" then
			VFL.AddError(errs, VFLI.i18n("Hotspot always anchor to Base")); return nil;
		end
		state:AddSlot("Hotspot_" .. n);
		--if(n ~= "") then state:AddSlot("Frame_" .. n); end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local n = strtrim(desc.name);
		local objname = n;   if (n == "") then objname = "_phs"; else objname = "Hotspot_" .. n; end
		if n == "" then n = "nil"; else n = string.format("%q", n); end
		local ty = "Button"; if desc.secure then ty = "SecureUnitButton"; end
		local flo = tonumber(desc.flo); if not flo then flo = 1; end flo = VFL.clamp(flo,1,10);
		
		local createCode = [[
local hs = VFLUI.AcquireFrame("]] .. ty .. [[");
hs:SetAttribute("useparent-unit", true); hs:SetAttribute("unit", nil);
hs:SetAttribute("useparent-unitsuffix", true); hs:SetAttribute("unitsuffix", nil);
hs:SetParent(frame); hs:SetFrameLevel(frame:GetFrameLevel() + (]] .. flo .. [[));
hs:SetWidth(]] .. desc.w .. [[); hs:SetHeight(]] .. desc.h .. [[);
hs:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
if frame:GetAttribute("toggleForVehicle") then
	hs:SetAttribute("toggleForVehicle", true);
end
]];
		if desc.mover and (not RDX.IsDesignEditorOpen()) then createCode = createCode .. [[
hs:SetScript("OnEnter", function()
	hs.unit = hs:GetParent():GetAttribute("unit");
	UnitFrame_OnEnter(hs);
end);
hs:SetScript("OnLeave", function() UnitFrame_OnLeave(hs); end);
]];
		end
		createCode = createCode .. [[
hs:Show();
frame:SetHotspot(]] .. n .. [[, hs);
frame.]] .. objname .. [[ = hs;
]];
		if (type(desc.hlt) == "table") then
			createCode = createCode .. [[
local _tex = VFLUI.CreateTexture(hs);
_tex:SetAllPoints(hs);
hs.hltTex = _tex;
hs:SetHighlightTexture(_tex);
]] .. VFLUI.GenerateSetTextureCode("_tex", desc.hlt);
      		end

		local destroyCode = [[
frame:SetHotspot(]] .. n .. [[, nil);
if frame.]] .. objname .. [[.hltTex then
	frame.]] .. objname .. [[.hltTex:Destroy(); frame.]] .. objname .. [[.hltTex = nil;
end
frame.]] .. objname .. [[:Destroy(); frame.]] .. objname .. [[ = nil;

]];

		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);
		
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local ed_flo = VFLUI.LabeledEdit:new(ui, 50); ed_flo:Show();
		ed_flo:SetText(VFLI.i18n("FrameLevel offset"));
		if desc and desc.flo then ed_flo.editBox:SetText(desc.flo); else ed_flo.editBox:SetText(3); end
		ui:InsertFrame(ed_flo);
		
		local chk_sec = VFLUI.Checkbox:new(ui);
		chk_sec:Show(); chk_sec:SetText(VFLI.i18n("Secure"));
		if desc and desc.secure then chk_sec:SetChecked(true); end
		ui:InsertFrame(chk_sec);
		
		local chk_mover = VFLUI.Checkbox:new(ui);
		chk_mover:Show(); chk_mover:SetText(VFLI.i18n("Mouseover Tooltip"));
		if desc and desc.mover then chk_mover:SetChecked(true); end
		ui:InsertFrame(chk_mover);
		
		local chk_hlt = VFLUI.Checkbox:new(ui); chk_hlt:Show();
		local tsel = VFLUI.MakeTextureSelectButton(chk_hlt); tsel:Show();
		tsel:SetPoint("RIGHT", chk_hlt, "RIGHT");
		chk_hlt.Destroy = VFL.hook(function() tsel:Destroy(); end, chk_hlt.Destroy);
		chk_hlt:SetText(VFLI.i18n("Highlight"));
		if desc and desc.hlt then
			chk_hlt:SetChecked(true); tsel:SetSelectedTexture(desc.hlt);
		else
			chk_hlt:SetChecked();
		end
		ui:InsertFrame(chk_hlt);
		
		function ui:GetDescriptor()
			local name = ed_name.editBox:GetText();
			local hlt = nil; if chk_hlt:GetChecked() then hlt = tsel:GetSelectedTexture(); end
			return {
				feature = "hotspot"; version = 1;
				name = name;
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				flo = VFL.clamp(ed_flo.editBox:GetNumber(), 1, 10);
				secure = chk_sec:GetChecked();
				mover = chk_mover:GetChecked();
				hlt = hlt;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "hotspot"; version = 1;
			name = "";
			w = 90; h = 14; anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0 };
			secure = true;
			mover = false;
			hlt = { path = "Interface\\QuestFrame\\UI-QuestTitleHighlight", blendMode = "ADD" };
			flo = 3;
		};
	end;
}); 

