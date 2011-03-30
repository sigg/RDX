-- AnimationGroup.lua
-- OpenRDX
-- From original code by Andrew Grimes

RDX.RegisterFeature({
	name = "frame_animation_group"; version = 1;
	title = VFLI.i18n("AG Frame"); category = VFLI.i18n("Animations");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing Descriptor.")); return nil; end
		if not RDXUI.UFOwnerCheck(desc.owner, state, errs) then return nil; end
		if not state:Slot("AnimationFrame") then state:AddSlot("AnimationFrame"); end
		if state:Slot("AGFra_" .. desc.owner) then
			VFL.AddError(errs, VFLI.i18n("Error AG already created:'") .. desc.owner .. "'.");
			return nil;
		else
			state:AddSlot("AGFra_" .. desc.owner);
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "AGFra_" .. desc.owner;
		local fname = RDXUI.ResolveFrameReference(desc.owner);
		local usecdn = "false"; if desc.usecdn then usecdn = "true" end
		local flag = "false"; if desc.flag then flag = desc.flag; end
		
		local createCode = [[
local fag = ]] .. fname .. [[.AnimationGroup;
fag:SetLooping("]] .. desc.loop .. [[");
frame.]] .. objname .. [[ = fag;
]];

		local destroyCode = [[
frame.]] .. objname .. [[:SetLooping("NONE");
frame.]] .. objname .. [[:Stop();
frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		
		local paintCode = [[
if ]] .. usecdn .. [[ then 
	if ]] .. flag .. [[ then 
		if not frame.]] .. objname .. [[:IsPlaying() then
			frame.]] .. objname .. [[:Play();
		end
	else 
		if not frame.]] .. objname .. [[:IsDone() then
			frame.]] .. objname .. [[:Stop();
		end
	end
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, "Frame", state, "Subframe_", true);
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Animation Loop Type"));
		local loop = VFLUI.Dropdown:new(er, RDXUI.LoopSelectionFunc);
		loop:SetWidth(150); loop:Show();
		if desc and desc.loop then loop:SetSelection(desc.loop); else loop:SetSelection("NONE"); end
		er:EmbedChild(loop); er:Show();
		ui:InsertFrame(er);
		
		local chk_usecdn = VFLUI.Checkbox:new(ui); chk_usecdn:Show();
		chk_usecdn:SetText(VFLI.i18n("Use Condition"));
		if desc and desc.usecdn then chk_usecdn:SetChecked(true); else chk_usecdn:SetChecked(); end
		ui:InsertFrame(chk_usecdn);
		
		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Condition variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end
		
		function ui:GetDescriptor()
			local flagtmp = nil;
			if chk_usecdn:GetChecked() then
				flagtmp = flag:GetSelection();
			end
			return {
				feature = "frame_animation_group"; version = 1;
				owner = owner:GetSelection();
				loop = loop:GetSelection();
				usecdn = chk_usecdn:GetChecked();
				flag = flagtmp;
			};
		end
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "frame_animation_group", version = 1,
			owner = "Base", loop = "NONE",
		};
	end;
});

RDX.RegisterFeature({
	name = "texture_animation_group"; version = 1;
	title = VFLI.i18n("AG Texture"); category = VFLI.i18n("Animations");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing Descriptor.")); return nil; end
		if not (desc.owner) or (not state:Slot("Tex_" .. desc.owner)) then
			VFL.AddError(errs, VFLI.i18n("Invalid texture")); return nil;
		end
		if not state:Slot("AnimationTexture") then state:AddSlot("AnimationTexture"); end
		if state:Slot("AGTex_" .. desc.owner) then
			VFL.AddError(errs, VFLI.i18n("Error AG already created:'") .. desc.owner .. "'.");
			return nil;
		else
			state:AddSlot("AGTex_" .. desc.owner);
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "AGTex_" .. desc.owner;
		local tname = RDXUI.ResolveTextureReference(desc.owner);
		local usecdn = "false"; if desc.usecdn then usecdn = "true" end
		local flag = "false"; if desc.flag then flag = desc.flag; end
		
		local createCode = [[
local tag = ]] .. tname .. [[.AnimationGroup;
tag:SetLooping("]] .. desc.loop .. [[");
frame.]] .. objname .. [[ = tag;
]];

		local destroyCode = [[
frame.]] .. objname .. [[:SetLooping("NONE");
frame.]] .. objname .. [[:Stop();
frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		local paintCode = [[
if ]] .. usecdn .. [[ then 
	if ]] .. flag .. [[ then 
		if not frame.]] .. objname .. [[:IsPlaying() then
			frame.]] .. objname .. [[:Play();
		end
	else 
		if not frame.]] .. objname .. [[:IsDone() then
			frame.]] .. objname .. [[:Stop();
		end
	end
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner Texture"), state, "Texture_", nil);
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Animation Loop Type"));
		local loop = VFLUI.Dropdown:new(er, RDXUI.LoopSelectionFunc);
		loop:SetWidth(150); loop:Show();
		if desc and desc.loop then loop:SetSelection(desc.loop); else loop:SetSelection("NONE"); end
		er:EmbedChild(loop); er:Show();
		ui:InsertFrame(er);
		
		local chk_usecdn = VFLUI.Checkbox:new(ui); chk_usecdn:Show();
		chk_usecdn:SetText(VFLI.i18n("Use Condition"));
		if desc and desc.usecdn then chk_usecdn:SetChecked(true); else chk_usecdn:SetChecked(); end
		ui:InsertFrame(chk_usecdn);
		
		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Condition variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end
		
		function ui:GetDescriptor()
			local flagtmp = nil;
			if chk_usecdn:GetChecked() then
				flagtmp = flag:GetSelection();
			end
			return {
				feature = "texture_animation_group"; version = 1;
				owner = owner:GetSelection();
				loop = loop:GetSelection();
				usecdn = chk_usecdn:GetChecked();
				flag = flagtmp;
			};
		end
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "texture_animation_group", version = 1,
			loop = "NONE",
		};
	end;
});

RDX.RegisterFeature({
	name = "text_animation_group"; version = 1;
	title = VFLI.i18n("AG Text"); category = VFLI.i18n("Animations");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("Missing Descriptor.")); return nil; end
		if not (desc.owner) or (not state:Slot("Text_" .. desc.owner)) then
			VFL.AddError(errs, VFLI.i18n("Invalid text")); return nil;
		end
		if not state:Slot("AnimationText") then state:AddSlot("AnimationText"); end
		if state:Slot("AGText_" .. desc.owner) then
			VFL.AddError(errs, VFLI.i18n("Error AG already created:'") .. desc.owner .. "'.");
			return nil;
		else
			state:AddSlot("AGText_" .. desc.owner);
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "AGText_" .. desc.owner;
		local tname = RDXUI.ResolveTextReference(desc.owner);
		local usecdn = "false"; if desc.usecdn then usecdn = "true" end
		local flag = "false"; if desc.flag then flag = desc.flag; end
		
		local createCode = [[
local tag = ]] .. tname .. [[.AnimationGroup;
tag:SetLooping("]] .. desc.loop .. [[");
frame.]] .. objname .. [[ = tag;
]];

		local destroyCode = [[
frame.]] .. objname .. [[:SetLooping("NONE");
frame.]] .. objname .. [[:Stop();
frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		
		local paintCode = [[
if ]] .. usecdn .. [[ then 
	if ]] .. flag .. [[ then 
		if not frame.]] .. objname .. [[:IsPlaying() then
			frame.]] .. objname .. [[:Play();
		end
	else 
		if not frame.]] .. objname .. [[:IsDone() then
			frame.]] .. objname .. [[:Stop();
		end
	end
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner Text"), state, "Text_", nil);
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Animation Loop Type"));
		local loop = VFLUI.Dropdown:new(er, RDXUI.LoopSelectionFunc);
		loop:SetWidth(150); loop:Show();
		if desc and desc.loop then loop:SetSelection(desc.loop); else loop:SetSelection("NONE"); end
		er:EmbedChild(loop); er:Show();
		ui:InsertFrame(er);
		
		local chk_usecdn = VFLUI.Checkbox:new(ui); chk_usecdn:Show();
		chk_usecdn:SetText(VFLI.i18n("Use Condition"));
		if desc and desc.usecdn then chk_usecdn:SetChecked(true); else chk_usecdn:SetChecked(); end
		ui:InsertFrame(chk_usecdn);
		
		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Condition variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end
		
		function ui:GetDescriptor()
			local flagtmp = nil;
			if chk_usecdn:GetChecked() then
				flagtmp = flag:GetSelection();
			end
			return {
				feature = "text_animation_group"; version = 1;
				owner = owner:GetSelection();
				loop = loop:GetSelection();
				usecdn = chk_usecdn:GetChecked();
				flag = flagtmp;
			};
		end
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "text_animation_group", version = 1,
			loop = "NONE",
		};
	end;
});

