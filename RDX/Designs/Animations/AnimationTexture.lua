-- AnimationFrame.lua
-- OpenRDX
-- From original code by Andrew Grimes

--Translation

RDX.RegisterFeature({
	name = "tex_animation_translation"; version = 1;
	title = "Texture: Translation"; category = "Animations";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		if not state:Slot("AnimationTexture") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No Descriptor.")); return nil; end
		if not (desc.owner) or (not state:Slot("AGTex_" .. desc.owner)) then
			VFL.AddError(errs, VFLI.i18n("Invalid Animation Group")); return nil;
		end        
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "AniTex_" .. desc.name;
		local aname = "AGTex_" .. desc.owner;
		
		local usecdn = "false"; if desc.usecdn then usecdn = "true" end
		local flag = "false"; if desc.flag then flag = desc.flag; end
		------------------- Creation
		local createCode = [[
local translation = VFLUI.CreateAnimation(frame.]] .. aname .. [[, "TRANSLATION"); 
translation:SetOffset(]] .. desc.xoffset .. [[, ]] .. desc.yoffset .. [[); 
translation:SetDuration(]] .. desc.duration .. [[); 
if (]] .. desc.smooth .. [[~= "None") then translation:SetSmoothing("]] .. desc.smooth .. [["); end
translation:SetStartDelay(]] .. desc.startdelay .. [[);
translation:SetEndDelay(]] .. desc.enddelay .. [[);
translation:SetOrder(]] .. desc.order .. [[);
frame.]] .. objname .. [[_translation = translation;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		------------------- Destruction
		local destroyCode = [[
frame.]] .. objname .. [[_translation:Destroy(); 
frame.]] .. objname .. [[_translation = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		------------------- Paint
		local paintCode = [[
if ]] .. usecdn .. [[ then 
	if ]] .. flag .. [[ then 
		if not frame.]] .. objname .. [[_translation:IsPlaying() then
			frame.]] .. objname .. [[_translation:Play();
		end
	else 
		if not frame.]] .. objname .. [[_translation:IsStopped() then
			if frame.]] .. aname .. [[:GetLooping() == "BOUNCE" or frame.]] .. aname .. [[:GetLooping() == "REPEAT" then
				frame.]] .. aname .. [[:Stop();
			else
				frame.]] .. objname .. [[_translation:Stop();
			end
		end
	end
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local name = VFLUI.LabeledEdit:new(er_name, 100); 
		name:SetText(VFLI.i18n("Name")); name:Show();
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("translation1"); end
		ui:InsertFrame(name);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Animation Group"), state, "AGTex_", nil);
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local duration = VFLUI.LabeledEdit:new(ui, 50);
		duration:SetText(VFLI.i18n("Duration"));
		duration:Show();
		if desc and desc.duration then duration.editBox:SetText(desc.duration); end
		ui:InsertFrame(duration);
		
		local xoffset = VFLUI.LabeledEdit:new(ui, 50);
		xoffset:SetText(VFLI.i18n("X Offset"));
		xoffset:Show();
		if desc and desc.xoffset then xoffset.editBox:SetText(desc.xoffset); end
		ui:InsertFrame(xoffset);
		
		local yoffset = VFLUI.LabeledEdit:new(ui, 50);
		yoffset:SetText(VFLI.i18n("Y Offset"));
		yoffset:Show();
		if desc and desc.yoffset then yoffset.editBox:SetText(desc.yoffset); end
		ui:InsertFrame(yoffset);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Smoothing"));
		local smooth = VFLUI.Dropdown:new(er, RDXUI.SmoothSelectionFunc);
		smooth:SetWidth(100); smooth:Show(); smooth:SetSelection("None");
		if desc and desc.smooth then smooth:SetSelection(desc.smooth); end
		er:EmbedChild(smooth); er:Show();
		ui:InsertFrame(er);
		
		local startdelay = VFLUI.LabeledEdit:new(ui, 50);
		startdelay:SetText(VFLI.i18n("Start Delay"));
		startdelay:Show();
		if desc and desc.startdelay then startdelay.editBox:SetText(desc.startdelay); end
		ui:InsertFrame(startdelay);
		
		local enddelay = VFLUI.LabeledEdit:new(ui, 50);
		enddelay:SetText(VFLI.i18n("End Delay"));
		enddelay:Show();
		if desc and desc.enddelay then enddelay.editBox:SetText(desc.enddelay); end
		ui:InsertFrame(enddelay);
		
		local order = VFLUI.LabeledEdit:new(ui, 50);
		order:SetText(VFLI.i18n("Animation Order"));
		order:Show();
		if desc and desc.order then order.editBox:SetText(desc.order); end
		ui:InsertFrame(order);
		
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
				feature = "tex_animation_translation"; version = 1;
				name = name.editBox:GetText();
				owner = owner:GetSelection();
				duration = duration.editBox:GetText();
				xoffset = xoffset.editBox:GetText();
				yoffset = yoffset.editBox:GetText();
				smooth = smooth:GetSelection();
				startdelay = startdelay.editBox:GetText();
				enddelay = enddelay.editBox:GetText();
				order = order.editBox:GetText();
				usecdn = chk_usecdn:GetChecked();
				flag = flagtmp;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "tex_animation_translation", version = 1,
			name = "translation1", owner = "Base", duration = 10, xoffset = 50, yoffset = 0,
			smooth = "None",
			startdelay = 0, enddelay = 0, order = 1, flag = "false",
		};
	end;
});

-- Rotation

RDX.RegisterFeature({
	name = "tex_animation_rotation"; version = 1;
	title = "Texture: Rotation"; category = "Animations";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		if not state:Slot("AnimationTexture") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No Descriptor.")); return nil; end
		if not (desc.owner) or (not state:Slot("AGTex_" .. desc.owner)) then
			VFL.AddError(errs, VFLI.i18n("Invalid Animation Group")); return nil;
		end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "AniTex_" .. desc.name;
		local aname = "AGTex_" .. desc.owner;
		
		local usecdn = "false"; if desc.usecdn then usecdn = "true" end
		local flag = "false"; if desc.flag then flag = desc.flag; end
		------------------- Creation
		local createCode = [[
local rotation = VFLUI.CreateAnimation(frame.]] .. aname .. [[, "ROTATION"); 
rotation:SetDegrees(]] .. desc.degrees .. [[); 
rotation:SetDuration(]] .. desc.duration .. [[);
rotation:SetOrigin("]] .. desc.origin .. [[", ]] .. desc.xoff .. [[, ]] .. desc.yoff .. [[); 
if (]] .. desc.smooth .. [[ ~= "None") then rotation:SetSmoothing("]] .. desc.smooth .. [["); end
rotation:SetStartDelay(]] .. desc.startdelay .. [[);
rotation:SetEndDelay(]] .. desc.enddelay .. [[);
rotation:SetOrder(]] .. desc.order .. [[);
frame.]] .. objname .. [[_rotation = rotation;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		------------------- Destruction
		local destroyCode = [[
frame.]] .. objname .. [[_rotation:Destroy(); 
frame.]] .. objname .. [[_rotation = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		------------------- Paint
		local paintCode = [[
if ]] .. usecdn .. [[ then 
	if ]] .. flag .. [[ then 
		if not frame.]] .. objname .. [[_rotation:IsPlaying() then
			frame.]] .. objname .. [[_rotation:Play();
		end
	else 
		if not frame.]] .. objname .. [[_rotation:IsStopped() then
			if frame.]] .. aname .. [[:GetLooping() == "BOUNCE" or frame.]] .. aname .. [[:GetLooping() == "REPEAT" then
				frame.]] .. aname .. [[:Stop();
			else
				frame.]] .. objname .. [[_rotation:Stop();
			end
		end
	end
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local name = VFLUI.LabeledEdit:new(er_name, 100); 
		name:SetText(VFLI.i18n("Name")); name:Show();
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("rotation1"); end
		ui:InsertFrame(name);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Animation Group"), state, "AGTex_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local duration = VFLUI.LabeledEdit:new(ui, 50);
		duration:SetText(VFLI.i18n("Duration"));
		duration:Show();
		if desc and desc.duration then duration.editBox:SetText(desc.duration); end
		ui:InsertFrame(duration);
		
		local degrees = VFLUI.LabeledEdit:new(ui, 50);
		degrees:SetText(VFLI.i18n("Degrees"));
		degrees:Show();
		if desc and desc.degrees then degrees.editBox:SetText(desc.degrees); end
		ui:InsertFrame(degrees);
		
		--Origin
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Origin"));
		local origin = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
		origin:SetWidth(100); origin:Show(); origin:SetSelection("CENTER");
		if desc and desc.origin then origin:SetSelection(desc.origin); end
		er:EmbedChild(origin); er:Show();
		ui:InsertFrame(er);
		
		local edy = VFLUI.LabeledEdit:new(ctr, 75); edy:SetText(VFLI.i18n("Offset X/Y:")); edy:Show();
		local edx = VFLUI.Edit:new(edy); edx:Show();
		edx:SetHeight(24); edx:SetWidth(75); edx:SetPoint("RIGHT", edy.editBox, "LEFT");
		if desc and desc.xoff then edx:SetText(desc.xoff); end
		if desc and desc.yoff then edy.editBox:SetText(desc.yoff); end
		edy.Destroy = VFL.hook(function() edx:Destroy(); end, edy.Destroy);
		ui:InsertFrame(edy);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Smoothing"));
		local smooth = VFLUI.Dropdown:new(er, RDXUI.SmoothSelectionFunc);
		smooth:SetWidth(100); smooth:Show(); smooth:SetSelection("None");
		if desc and desc.smooth then smooth:SetSelection(desc.smooth); end
		er:EmbedChild(smooth); er:Show();
		ui:InsertFrame(er);
		
		local startdelay = VFLUI.LabeledEdit:new(ui, 50);
		startdelay:SetText(VFLI.i18n("Start Delay"));
		startdelay:Show();
		if desc and desc.startdelay then startdelay.editBox:SetText(desc.startdelay); end
		ui:InsertFrame(startdelay);
		
		local enddelay = VFLUI.LabeledEdit:new(ui, 50);
		enddelay:SetText(VFLI.i18n("End Delay"));
		enddelay:Show();
		if desc and desc.enddelay then enddelay.editBox:SetText(desc.enddelay); end
		ui:InsertFrame(enddelay);
		
		local order = VFLUI.LabeledEdit:new(ui, 50);
		order:SetText(VFLI.i18n("Animation Order"));
		order:Show();
		if desc and desc.order then order.editBox:SetText(desc.order); end
		ui:InsertFrame(order);
		
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
				feature = "tex_animation_rotation"; version = 1;
				name = name.editBox:GetText();
				owner = owner:GetSelection();
				duration = duration.editBox:GetText();
				degrees = degrees.editBox:GetText();
				origin = origin:GetSelection();
				xoff = edx:GetNumber();
				yoff = edy.editBox:GetText();
				smooth = smooth:GetSelection();
				startdelay = startdelay.editBox:GetText();
				enddelay = enddelay.editBox:GetText();
				order = order.editBox:GetText();
				usecdn = chk_usecdn:GetChecked();
				flag = flagtmp;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "tex_animation_rotation", version = 1,
			name = "rotation1", owner = "Base", duration = 10, degrees = 360,
			origin = "CENTER", xoff = 0, yoff = 0, smooth = "None",
			startdelay = 0, enddelay = 0, order = 1, flag = "false",
		};
	end;
});

--Scale

RDX.RegisterFeature({
	name = "tex_animation_scale"; version = 1;
	title = "Texture: Scale"; category = "Animations";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		if not state:Slot("AnimationTexture") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No Descriptor.")); return nil; end
		if not (desc.owner) or (not state:Slot("AGTex_" .. desc.owner)) then
			VFL.AddError(errs, VFLI.i18n("Invalid Animation Group")); return nil;
		end        
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "AniTex_" .. desc.name;
		local aname = "AGTex_" .. desc.owner;
		
		local usecdn = "false"; if desc.usecdn then usecdn = "true" end
		local flag = "false"; if desc.flag then flag = desc.flag; end
		------------------- Creation
		local createCode = [[
local scale = VFLUI.CreateAnimation(frame.]] .. aname .. [[, "SCALE"); 
scale:SetScale(]] .. desc.xscale .. [[, ]] .. desc.yscale .. [[); 
scale:SetDuration(]] .. desc.duration .. [[);
scale:SetOrigin(']] .. desc.origin .. [[', ]] .. desc.xoff .. [[, ]] .. desc.yoff .. [[); 
if (]] .. desc.smooth .. [[~= "None") then scale:SetSmoothing("]] .. desc.smooth .. [["); end
scale:SetStartDelay(]] .. desc.startdelay .. [[);
scale:SetEndDelay(]] .. desc.enddelay .. [[);
scale:SetOrder(]] .. desc.order .. [[);
frame.]] .. objname .. [[_scale = scale;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		------------------- Destruction
		local destroyCode = [[
frame.]] .. objname .. [[_scale:Destroy(); 
frame.]] .. objname .. [[_scale = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		------------------- Paint
		local paintCode = [[
if ]] .. usecdn .. [[ then 
	if ]] .. flag .. [[ then 
		if not frame.]] .. objname .. [[_scale:IsPlaying() then
			frame.]] .. objname .. [[_scale:Play();
		end
	else 
		if not frame.]] .. objname .. [[_scale:IsStopped() then
			if frame.]] .. aname .. [[:GetLooping() == "BOUNCE" or frame.]] .. aname .. [[:GetLooping() == "REPEAT" then
				frame.]] .. aname .. [[:Stop();
			else
				frame.]] .. objname .. [[_scale:Stop();
			end
		end
	end
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
		
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local name = VFLUI.LabeledEdit:new(er_name, 100); 
		name:SetText(VFLI.i18n("Name")); name:Show();
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("scale1"); end
		ui:InsertFrame(name);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Animation Group"), state, "AGTex_", nil);
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local duration = VFLUI.LabeledEdit:new(ui, 50);
		duration:SetText(VFLI.i18n("Duration"));
		duration:Show();
		if desc and desc.duration then duration.editBox:SetText(desc.duration); end
		ui:InsertFrame(duration);
		
		local xscale = VFLUI.LabeledEdit:new(ui, 50);
		xscale:SetText(VFLI.i18n("X Scale"));
		xscale:Show();
		if desc and desc.xscale then xscale.editBox:SetText(desc.xscale); end
		ui:InsertFrame(xscale);
		
		local yscale = VFLUI.LabeledEdit:new(ui, 50);
		yscale:SetText(VFLI.i18n("Y Scale"));
		yscale:Show();
		if desc and desc.yscale then yscale.editBox:SetText(desc.yscale); end
		ui:InsertFrame(yscale);
		
		--Origin
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Origin"));
		local origin = VFLUI.Dropdown:new(er, RDXUI.AnchorPointSelectionFunc);
		origin:SetWidth(100); origin:Show(); origin:SetSelection("CENTER");
		if desc and desc.origin then origin:SetSelection(desc.origin); end
		er:EmbedChild(origin); er:Show();
		ui:InsertFrame(er);
		
		local edy = VFLUI.LabeledEdit:new(ctr, 75); edy:SetText(VFLI.i18n("Offset X/Y:")); edy:Show();
		local edx = VFLUI.Edit:new(edy); edx:Show();
		edx:SetHeight(24); edx:SetWidth(75); edx:SetPoint("RIGHT", edy.editBox, "LEFT");
		if desc and desc.xoff then edx:SetText(desc.xoff); end
		if desc and desc.yoff then edy.editBox:SetText(desc.yoff); end
		edy.Destroy = VFL.hook(function() edx:Destroy(); end, edy.Destroy);
		ui:InsertFrame(edy);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Smoothing"));
		local smooth = VFLUI.Dropdown:new(er, RDXUI.SmoothSelectionFunc);
		smooth:SetWidth(100); smooth:Show(); smooth:SetSelection("None");
		if desc and desc.smooth then smooth:SetSelection(desc.smooth); end
		er:EmbedChild(smooth); er:Show();
		ui:InsertFrame(er);
		
		local startdelay = VFLUI.LabeledEdit:new(ui, 50);
		startdelay:SetText(VFLI.i18n("Start Delay"));
		startdelay:Show();
		if desc and desc.startdelay then startdelay.editBox:SetText(desc.startdelay); end
		ui:InsertFrame(startdelay);
		
		local enddelay = VFLUI.LabeledEdit:new(ui, 50);
		enddelay:SetText(VFLI.i18n("End Delay"));
		enddelay:Show();
		if desc and desc.enddelay then enddelay.editBox:SetText(desc.enddelay); end
		ui:InsertFrame(enddelay);
		
		local order = VFLUI.LabeledEdit:new(ui, 50);
		order:SetText(VFLI.i18n("Animation Order"));
		order:Show();
		if desc and desc.order then order.editBox:SetText(desc.order); end
		ui:InsertFrame(order);
		
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
				feature = "tex_animation_scale"; version = 1;
				name = name.editBox:GetText();
				owner = owner:GetSelection();
				duration = duration.editBox:GetText();
				xscale = xscale.editBox:GetText();
				yscale = yscale.editBox:GetText();
				origin = origin:GetSelection();
				xoff = edx:GetNumber();
				yoff = edy.editBox:GetText();
				smooth = smooth:GetSelection();
				startdelay = startdelay.editBox:GetText();
				enddelay = enddelay.editBox:GetText();
				order = order.editBox:GetText();
				usecdn = chk_usecdn:GetChecked();
				flag = flagtmp;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "tex_animation_scale", version = 1,
			name = "scale1", owner = "Base", duration = 10, xscale = 1, yscale = 1,
			origin = "CENTER", xoff = 0, yoff = 0, smooth = "None",
			startdelay = 0, enddelay = 0, order = 1, flag = "false",
		};
	end;
});

RDX.RegisterFeature({
	name = "tex_animation_alpha"; version = 1;
	title = "Texture: Alpha"; category = "Animations";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		if not state:Slot("AnimationTexture") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No Descriptor.")); return nil; end
		if not (desc.owner) or (not state:Slot("AGTex_" .. desc.owner)) then
			VFL.AddError(errs, VFLI.i18n("Invalid Animation Group")); return nil;
		end        
		return true;
	end;
	ApplyFeature = function(desc, state)
		local objname = "AniTex_" .. desc.name;
		local aname = "AGTex_" .. desc.owner;
		
		local usecdn = "false"; if desc.usecdn then usecdn = "true" end
		local flag = "false"; if desc.flag then flag = desc.flag; end
		------------------- Creation
		local createCode = [[
local alpha = VFLUI.CreateAnimation(frame.]] .. aname .. [[, "ALPHA");
alpha:SetChange(]] .. desc.da .. [[); 
alpha:SetDuration(]] .. desc.duration .. [[);
if (]] .. desc.smooth .. [[~= "None") then alpha:SetSmoothing("]] .. desc.smooth .. [["); end
alpha:SetStartDelay(]] .. desc.startdelay .. [[);
alpha:SetEndDelay(]] .. desc.enddelay .. [[);
alpha:SetOrder(]] .. desc.order .. [[);
frame.]] .. objname .. [[_alpha = alpha;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);
		------------------- Destruction
		local destroyCode = [[
frame.]] .. objname .. [[_alpha:Destroy(); 
frame.]] .. objname .. [[_alpha = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);
		------------------- Paint
		local paintCode = [[
if ]] .. usecdn .. [[ then 
	if ]] .. flag .. [[ then 
		if not frame.]] .. objname .. [[_alpha:IsPlaying() then
			frame.]] .. objname .. [[_alpha:Play();
		end
	else 
		if not frame.]] .. objname .. [[_alpha:IsStopped() then
			if frame.]] .. aname .. [[:GetLooping() == "BOUNCE" or frame.]] .. aname .. [[:GetLooping() == "REPEAT" then
				frame.]] .. aname .. [[:Stop();
			else
				frame.]] .. objname .. [[_alpha:Stop();
			end
		end
	end
end
]];
		state:Attach(state:Slot("EmitPaint"), true, function(code) code:AppendCode(paintCode); end);
	end;

	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local name = VFLUI.LabeledEdit:new(er_name, 100); 
		name:SetText(VFLI.i18n("Name")); name:Show();
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("alpha1"); end
		ui:InsertFrame(name);
		
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Animation Group"), state, "AGTex_", nil);
		if desc and desc.owner then owner:SetSelection(desc.owner); end
		
		local duration = VFLUI.LabeledEdit:new(ui, 50);
		duration:SetText(VFLI.i18n("Duration"));
		duration:Show();
		if desc and desc.duration then duration.editBox:SetText(desc.duration); end
		ui:InsertFrame(duration);
		
		local da = VFLUI.LabeledEdit:new(ui, 50);
		da:SetText(VFLI.i18n("Change Alpha to"));
		da:Show();
		if desc and desc.da then da.editBox:SetText(desc.da); end
		ui:InsertFrame(da);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Smoothing"));
		local smooth = VFLUI.Dropdown:new(er, RDXUI.SmoothSelectionFunc);
		smooth:SetWidth(100); smooth:Show(); smooth:SetSelection("None");
		if desc and desc.smooth then smooth:SetSelection(desc.smooth); end
		er:EmbedChild(smooth); er:Show();
		ui:InsertFrame(er);
		
		local startdelay = VFLUI.LabeledEdit:new(ui, 50);
		startdelay:SetText(VFLI.i18n("Start Delay"));
		startdelay:Show();
		if desc and desc.startdelay then startdelay.editBox:SetText(desc.startdelay); end
		ui:InsertFrame(startdelay);
		
		local enddelay = VFLUI.LabeledEdit:new(ui, 50);
		enddelay:SetText(VFLI.i18n("End Delay"));
		enddelay:Show();
		if desc and desc.enddelay then enddelay.editBox:SetText(desc.enddelay); end
		ui:InsertFrame(enddelay);
		
		local order = VFLUI.LabeledEdit:new(ui, 50);
		order:SetText(VFLI.i18n("Animation Order"));
		order:Show();
		if desc and desc.order then order.editBox:SetText(desc.order); end
		ui:InsertFrame(order);
		
		local chk_usecdn = VFLUI.Checkbox:new(ui); chk_usecdn:Show();
		chk_usecdn:SetText(VFLI.i18n("Use Condition"));
		if desc and desc.usecdn then chk_usecdn:SetChecked(true); else chk_usecdn:SetChecked(); end
		ui:InsertFrame(chk_usecdn);
		
		local flag = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Condition variable"), state, "BoolVar_", nil, "true", "false");
		if desc and desc.flag then flag:SetSelection(desc.flag); end
		
		function ui:GetDescriptor()
			return {
				feature = "tex_animation_alpha"; version = 1;
				name = name.editBox:GetText();
				owner = owner:GetSelection();
				duration = duration.editBox:GetText();
				da = da.editBox:GetText();
				smooth = smooth:GetSelection();
				startdelay = startdelay.editBox:GetText();
				enddelay = enddelay.editBox:GetText();
				order = order.editBox:GetText();
				usecdn = chk_usecdn:GetChecked();
				flag = flagtmp;
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "tex_animation_alpha", version = 1,
			name = "alpha1", owner = "Base", duration = 10, da = 1,
			startdelay = 0, enddelay = 0, order = 1, flag = "false",
		};
	end;
});