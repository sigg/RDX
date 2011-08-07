-- Backdrops.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Creation and modifications of backdrops on UnitFrames and subframes.

------------------------------------------------------
-- Backdrop feature. Adds a backdrop to a subframe.
------------------------------------------------------
RDX.RegisterFeature({
	name = "backdrop";
	title = "Backdrop";
	category = "Basics";
	multiple = true;
	version = 1;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing descriptor.")); return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		if not RDXUI.UFOwnerCheck(desc.owner, state, errs) then return nil; end
		-- Verify there isn't two backdrops on the same owner frame
		if state:Slot("Bkdp_" .. desc.owner) then
			VFL.AddError(errs, VFLI.i18n("Owner frame already has a backdrop.")); return nil;
		end
		-- Verify backdrop
		if type(desc.bkd) ~= "table" then VFL.AddError(errs, VFLI.i18n("Invalid backdrop.")); return nil; end
		state:AddSlot("Bkdp_" .. desc.owner);
		return true;
	end;
	ApplyFeature = function(desc, state)
		local fvar = RDXUI.ResolveFrameReference(desc.owner);

		-- Closure
		local closureCode = [[
local bkdp_]] .. desc.owner .. [[ = ]] .. Serialize(desc.bkd) .. [[;
]];
		state:Attach("EmitClosure", true, function(code) code:AppendCode(closureCode); end);

		-- Create
		local createCode = [[
VFLUI.SetBackdrop(]] .. fvar .. [[, bkdp_]] .. desc.owner .. [[);
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		-- Destroy
		local destroyCode = [[
if ]] .. fvar .. [[ then ]] .. fvar .. [[:SetBackdrop(nil); end
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, "Owner", state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Backdrop
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop style"));
		local bkd = VFLUI.MakeBackdropSelectButton(er, desc.bkd); bkd:Show();
		er:EmbedChild(bkd); er:Show();
		ui:InsertFrame(er);

		function ui:GetDescriptor()
			return { 
				feature = "backdrop"; version = 1;
				owner = owner:GetSelection();
				bkd = bkd:GetSelectedBackdrop();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "backdrop"; owner = "decor"; version = 1; bkd = VFL.copy(VFLUI.defaultBackdrop);};
	end;
});

RDX.RegisterFeature({
	name = "artbackdrop";
	version = 2;
	multiple = true;
	invisible = true;
	IsPossible = VFL.Nil;
	VersionMismatch = function(desc)
		desc.feature = "backdrop"; desc.version = 1;
	end;
});

