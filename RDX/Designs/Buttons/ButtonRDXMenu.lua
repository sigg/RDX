-- ButtonRDXMenu.lua
-- Add a button that will open a dropdown menu
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
	name = "buttonmenurdx"; version = 1; 
	title = VFLI.i18n("Button RDX Menu"); 
	category = VFLI.i18n("Buttons");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		flg = flg and RDXUI.UFFrameCheck_Proto("Button_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Button_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Button_" .. desc.name;
		local rdxmenu = "RDXPM.CompactMenu";
		if desc and desc.rdxmenu then rdxmenu = desc.rdxmenu; end
		
		------------------ On frame creation
		local createCode = [[
local btn, btnOwner = nil, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[;
btn = VFLUI.AcquireFrame("Button");
btn:SetParent(btnOwner); btn:SetFrameLevel(btnOwner:GetFrameLevel());
btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight(]] .. desc.h .. [[);
btn:Show();
btn:RegisterForClicks("AnyUp");
btn:SetScript("OnClick", function(self) 
	]] .. rdxmenu .. [[:Open();
end);
frame.]] .. objname .. [[ = btn;
]];
		if (type(desc.hlt) == "table") then
			createCode = createCode .. [[
local _tex = VFLUI.CreateTexture(btn);
_tex:SetAllPoints(btn);
btn.hltTex = _tex;
btn:SetHighlightTexture(_tex);
]] .. VFLUI.GenerateSetTextureCode("_tex", desc.hlt);
      		end

		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		
		------------------ On frame destruction.
		local destroyCode = [[
if frame.]] .. objname .. [[.hltTex then
	frame.]] .. objname .. [[.hltTex:Destroy();
	frame.]] .. objname .. [[.hltTex = nil;
end
frame.]] .. objname .. [[:Destroy();
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
		
		function ui:GetDescriptor()
			local hlt = nil; if chk_hlt:GetChecked() then hlt = tsel:GetSelectedTexture(); end
			return { 
				feature = "buttonmenurdx"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				hlt = hlt;
				rdxmenu = dd_rdxmenu:GetSelection();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "buttonmenurdx"; version = 1; 
			name = "btn1", owner = "decor", drawLayer = "ARTWORK";
			w = 30; h = 30;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
		};
	end;
});

