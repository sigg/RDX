-- Framing.lua
-- RDX
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
-- 
-- Features to alter the framing and appearance of RDX windows.

--- Helper function to generate a title UI.
function RDXUI.GenerateFrameTitleUI(feature, desc, parent)
	local ui = VFLUI.CompoundFrame:new(parent);

	local title = VFLUI.LabeledEdit:new(ui, 100); title:Show();
	title:SetText(VFLI.i18n("Window Title"));
	if desc and desc.title then title.editBox:SetText(desc.title); end
	ui:InsertFrame(title);
	
	--local chk_showtitlebar = VFLUI.Checkbox:new(ui); chk_showtitlebar:Show();
	--chk_showtitlebar:SetText(VFLI.i18n("Show Title Bar"));
	--if desc and desc.showtitlebar then chk_showtitlebar:SetChecked(true); else chk_showtitlebar:SetChecked(); end
	--ui:InsertFrame(chk_showtitlebar);
	
	local chk_defaultbuttons = VFLUI.Checkbox:new(ui); chk_defaultbuttons:Show();
	chk_defaultbuttons:SetText(VFLI.i18n("Add close and reduce buttons"));
	if desc and desc.defaultbuttons then chk_defaultbuttons:SetChecked(true); else chk_defaultbuttons:SetChecked(); end
	ui:InsertFrame(chk_defaultbuttons);
	
	local er_icon = VFLUI.EmbedRight(ui, VFLI.i18n("Icon in desktop bar"));
	local texicon = VFLUI.MakeTextureSelectButton(er_icon, desc.texicon); texicon:Show();
	er_icon:EmbedChild(texicon); er_icon:Show();
	ui:InsertFrame(er_icon);
	
	function ui:GetDescriptor()
		return {
			feature = feature;
			title = title.editBox:GetText();
			--showtitlebar = chk_showtitlebar:GetChecked();
			defaultbuttons = chk_defaultbuttons:GetChecked();
			texicon = texicon:GetSelectedTexture();
		};
	end
	ui.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil;
	end, ui.Destroy);
	return ui;
end

function RDX.GetWindowIcon(path)
	local feat = RDXDB.GetFeatureData(path, "Frame: Default");
	if not feat then feat = RDXDB.GetFeatureData(path, "Frame: Lightweight"); end
	if not feat then feat = RDXDB.GetFeatureData(path, "Frame: Black"); end
	if not feat then feat = RDXDB.GetFeatureData(path, "Frame: Box"); end
	if not feat then feat = RDXDB.GetFeatureData(path, "Frame: iDesktop"); end
	if feat then return feat.texicon.path; end
end

------------------------------------
-- No frame whatsoever
------------------------------------
RDX.RegisterFeature({
	name = "Frame: None";
	title = VFLI.i18n("Frame: None");
	category = VFLI.i18n("Window Frames");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		if state:Slot("Frame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state)
		if not desc then return nil; end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop); end
		state:AddSlot("Frame");
		state:AddSlot("SetTitleText");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local win = nil;
		state:_Attach(state:Slot("Create"), true, function(w)
			win = w;
			w:SetFraming(VFLUI.Framing.None, 0, desc.bkd);
		end);
		return true;
	end,
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop style"));
		local bkd = VFLUI.MakeBackdropSelectButton(er, desc.bkd); bkd:Show();
		er:EmbedChild(bkd); er:Show();
		ui:InsertFrame(er);
		
		function ui:GetDescriptor()
			return {
				feature = "Frame: None";
				bkd = bkd:GetSelectedBackdrop();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Frame: None"}; end
});

------------------------------------
-- The VFL default frame
------------------------------------
RDX.RegisterFeature({
	name = "Frame: Default";
	title = VFLI.i18n("Frame: Default");
	category = VFLI.i18n("Window Frames");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Create") then return nil; end
		if state:Slot("Frame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state)
		if not desc then return nil; end
		desc.bkd = VFL.copy(VFLUI.BlizzardDialogBackdrop);
		state:AddSlot("Frame");
		state:AddSlot("SetTitleText");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local win, title = nil, (desc.title or VFLI.i18n("(No Title)"));
		local btnReduce, btnClose;
		--local st = desc.showtitlebar;
		if not desc.texicon then desc.texicon = VFL.copy(VFLUI.ErrorTexture); end
		
		state:_Attach(state:Slot("Create"), true, function(w)
			win = w;
			w:SetFraming(VFLUI.Framing.Default, 18, desc.bkd);
			w:SetText(title); w:SetTitleColor(0,0,0.6);
			
			if desc.defaultbuttons then
				btnClose = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\x");
				btnClose:SetHighlightColor(1,0,0,1);
				w:AddButton(btnClose);
				btnClose:SetScript("OnClick", function()
					RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path);
				end);
				
				--btnReduce = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\minus");
				--btnReduce:SetHighlightColor(1,1,0,1);
				--w:AddButton(btnReduce);
				--btnReduce:SetScript("OnClick", function()
				--	RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path, true);
				--	RDXPM.AddButtonWB({name = w._path, title = w._path, desc = "test", texture = (desc.texicon.path)});
				--end);
			end
		end);
		
		--state:_Attach(state:Slot("PostCreate"), true, function(w)
		--	if not st then w:HideTitleBar(); end
		--end);
		
		--state:Attach("Menu", true, function(w, mnu)
		--	table.insert(mnu, {
		--		text = VFLI.i18n("Toggle Titlebar");
		--		OnClick = function()
		--			if st then
		--				w:HideTitleBar();
		--				st = nil;
		--				desc.showtitlebar = nil;
		--			else
		--				w:ShowTitleBar();
		--				st = true;
		--				desc.showtitlebar = true;
		--			end
		--			VFL.poptree:Release();
		--		end;
		--	});
		--end);

		state:_Attach(state:Slot("SetTitleText"), nil, function(txt)
			win:SetText(title .. txt);
		end);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		return RDXUI.GenerateFrameTitleUI("Frame: Default", desc, parent);
	end,
	CreateDescriptor = function() 
		return {
			feature = "Frame: Default";
			showtitlebar = true;
			texicon = VFL.copy(VFLUI.ErrorTexture);
		}; 
	end
});

----------------------------------
-- A "lightweight" frame
----------------------------------
RDX.RegisterFeature({
	name = "Frame: Lightweight",
	title = VFLI.i18n("Frame: Lightweight"),
	category = VFLI.i18n("Window Frames");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Create") then return nil; end
		if state:Slot("Frame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state)
		if not desc then return nil; end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop); end
		state:AddSlot("Frame");
		state:AddSlot("SetTitleText");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local win, title = nil, (desc.title or VFLI.i18n("(No title)"));
		local titleColor = desc.titleColor or _black;
		--local bkdColor = desc.bkdColor or _alphaBlack;
		local btnReduce, btnClose;
		--local st = desc.showtitlebar;
		if not desc.texicon then desc.texicon = VFL.copy(VFLUI.ErrorTexture); end
		
		state:_Attach(state:Slot("Create"), true, function(w)
			win = w;
			w:SetFraming(VFLUI.Framing.Sleek, 18, desc.bkd);
			win:SetText(title);
			win:SetTitleColor(VFL.explodeRGBA(titleColor));
			win:SetBackdropColor(VFL.explodeRGBA(bkdColor));
			
			if desc.defaultbuttons then
				btnClose = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\x");
				btnClose:SetHighlightColor(1,0,0,1);
				w:AddButton(btnClose);
				btnClose:SetScript("OnClick", function()
					RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path);
				end);
				
				--btnReduce = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\minus");
				--btnReduce:SetHighlightColor(1,1,0,1);
				--w:AddButton(btnReduce);
				--btnReduce:SetScript("OnClick", function()
				--	RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path, true);
				--	RDXPM.AddButtonWB({name = w._path, title = w._path, desc = "test", texture = (desc.texicon.path)});
				--end);
			end
		end);

		--state:_Attach(state:Slot("PostCreate"), true, function(w)
		--	if not st then w:HideTitleBar(); end
		--end);

		--state:Attach("Menu", true, function(w, mnu)
		--	table.insert(mnu, {
		--		text = VFLI.i18n("Toggle Titlebar");
		--		OnClick = function()
		--			if not w:IsHiddenClientArea() then
		--				VFL.print("hide");
		--				w:HideClientArea();
						--st = nil;
						--desc.showtitlebar = nil;
		--			else
		--				VFL.print("show");
		--				w:ShowClientArea();
						--st = true;
						--desc.showtitlebar = true;
		--			end
		--			VFL.poptree:Release();
		--		end;
		--	});
		--end);

		state:_Attach(state:Slot("SetTitleText"), nil, function(txt)
			win:SetText(title .. txt);
		end);
		return true;
	end,
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local title = VFLUI.LabeledEdit:new(ui, 100); title:Show();
		title:SetText(VFLI.i18n("Window Title"));
		if desc and desc.title then title.editBox:SetText(desc.title); end
		ui:InsertFrame(title);

		local titleColor = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Title color"));
		if desc and desc.titleColor then titleColor:SetColor(VFL.explodeRGBA(desc.titleColor)); end

		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Backdrop style"));
		local bkd = VFLUI.MakeBackdropSelectButton(er, desc.bkd); bkd:Show();
		er:EmbedChild(bkd); er:Show();
		ui:InsertFrame(er);
		
		--local bkdColor = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Background color"));
		--if desc and desc.bkdColor then bkdColor:SetColor(VFL.explodeRGBA(desc.bkdColor)); end

		--local chk_showtitlebar = VFLUI.Checkbox:new(ui); chk_showtitlebar:Show();
		--chk_showtitlebar:SetText(VFLI.i18n("Show Title Bar"));
		--if desc and desc.showtitlebar then chk_showtitlebar:SetChecked(true); else chk_showtitlebar:SetChecked(); end
		--ui:InsertFrame(chk_showtitlebar);
		
		local chk_defaultbuttons = VFLUI.Checkbox:new(ui); chk_defaultbuttons:Show();
		chk_defaultbuttons:SetText(VFLI.i18n("Add close and reduce buttons"));
		if desc and desc.defaultbuttons then chk_defaultbuttons:SetChecked(true); else chk_defaultbuttons:SetChecked(); end
		ui:InsertFrame(chk_defaultbuttons);
		
		local er_icon = VFLUI.EmbedRight(ui, VFLI.i18n("Icon in desktop bar"));
		local texicon = VFLUI.MakeTextureSelectButton(er_icon, desc.texicon); texicon:Show();
		er_icon:EmbedChild(texicon); er_icon:Show();
		ui:InsertFrame(er_icon);
		
		function ui:GetDescriptor()
			return {
				feature = "Frame: Lightweight"; 
				title = title.editBox:GetText();
				titleColor = titleColor:GetColor();
				bkd = bkd:GetSelectedBackdrop();
				--bkdColor = bkdColor:GetColor();
				--showtitlebar = chk_showtitlebar:GetChecked();
				defaultbuttons = chk_defaultbuttons:GetChecked();
				texicon = texicon:GetSelectedTexture();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() 
		return {
			feature = "Frame: Lightweight";
			titleColor = { r=0,g=0,b=0,a=1 };
			--bkdColor = {r=0,g=0,b=0,a=0};
			--showtitlebar = true;
			texicon = VFL.copy(VFLUI.ErrorTexture);
		}; 
	end
});

----------------------------------------------------------------
-- Frame:Black, for compatibility purposes.
----------------------------------------------------------------
RDX.RegisterFeature({
	name = "Frame: Black";
	title = VFLI.i18n("Frame: Black");
	category = VFLI.i18n("Window Frames");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Create") then return nil; end
		if state:Slot("Frame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state)
		if not desc then return nil; end
		if not desc.bkd then desc.bkd = VFL.copy(VFLUI.defaultBackdrop); end
		state:AddSlot("Frame");
		state:AddSlot("SetTitleText");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local win, title = nil, (desc.title or VFLI.i18n("(No title)"));
		local btnReduce, btnClose;
		--local st = desc.showtitlebar;
		if not desc.texicon then desc.texicon = VFL.copy(VFLUI.ErrorTexture); end
		
		state:_Attach(state:Slot("Create"), true, function(w)
			win = w;
			w:SetFraming(VFLUI.Framing.Sleek, 18, desc.bkd);
			win:SetText(title);
			win:SetTitleColor(VFL.explodeColor(_black));
			--win:SetBackdropColor(VFL.explodeRGBA(_alphaBlack));
			
			if desc.defaultbuttons then
				btnClose = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\x");
				btnClose:SetHighlightColor(1,1,0,1);
				w:AddButton(btnClose);
				btnClose:SetScript("OnClick", function()
					RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path);
				end);
				
				--btnReduce = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\minus");
				--btnReduce:SetHighlightColor(1,1,0,1);
				--w:AddButton(btnReduce);
				--btnReduce:SetScript("OnClick", function()
				--	RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path, true);
				--	RDXPM.AddButtonWB({name = w._path, title = w._path, desc = "test", texture = (desc.texicon.path)});
				--end);
			end
		end);
		
		--state:_Attach(state:Slot("PostCreate"), true, function(w)
		--	if not st then w:HideTitleBar(); end
		--end);
		
		--state:Attach("Menu", true, function(w, mnu)
		--	table.insert(mnu, {
		--		text = VFLI.i18n("Toggle Titlebar");
		--		OnClick = function()
		--			if st then
		--				w:HideTitleBar();
		--				st = nil;
		--				desc.showtitlebar = nil;
		--			else
		--				w:ShowTitleBar();
		--				st = true;
		--				desc.showtitlebar = true;
		--			end
		--			VFL.poptree:Release();
		--		end;
		--	});
		--end);

		state:_Attach(state:Slot("SetTitleText"), nil, function(txt)
			win:SetText(title .. txt);
		end);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ed_title = VFLUI.LabeledEdit:new(parent, 100);
		ed_title:SetText(VFLI.i18n("Window title")); ed_title:Show();
		if desc and desc.title then ed_title.editBox:SetText(desc.title); end
		ui:InsertFrame(ed_title);
		
		--local chk_showtitlebar = VFLUI.Checkbox:new(ui); chk_showtitlebar:Show();
		--chk_showtitlebar:SetText(VFLI.i18n("Show Title Bar"));
		--if desc and desc.showtitlebar then chk_showtitlebar:SetChecked(true); else chk_showtitlebar:SetChecked(); end
		--ui:InsertFrame(chk_showtitlebar);
		
		local chk_defaultbuttons = VFLUI.Checkbox:new(ui); chk_defaultbuttons:Show();
		chk_defaultbuttons:SetText(VFLI.i18n("Add close and reduce buttons"));
		if desc and desc.defaultbuttons then chk_defaultbuttons:SetChecked(true); else chk_defaultbuttons:SetChecked(); end
		ui:InsertFrame(chk_defaultbuttons);
		
		local er_icon = VFLUI.EmbedRight(ui, VFLI.i18n("Icon in desktop bar"));
		local texicon = VFLUI.MakeTextureSelectButton(er_icon, desc.texicon); texicon:Show();
		er_icon:EmbedChild(texicon); er_icon:Show();
		ui:InsertFrame(er_icon);

		function ui:GetDescriptor()
			return {
				feature = "Frame: Black"; 
				title = ed_title.editBox:GetText();
				--showtitlebar = chk_showtitlebar:GetChecked();
				defaultbuttons = chk_defaultbuttons:GetChecked();
				texicon = texicon:GetSelectedTexture();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "Frame: Black"; 
			color = {r=0,g=0,b=0};
			--showtitlebar = true;
			texicon = VFL.copy(VFLUI.ErrorTexture);
		}; 
	end
});

----------------------------------------------------------------
-- Frame: Fat
----------------------------------------------------------------
RDX.RegisterFeature({
	name = "Frame: Fat";
	title = VFLI.i18n("Frame: Fat");
	category = VFLI.i18n("Window Frames");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Create") then return nil; end
		if state:Slot("Frame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state)
		if not desc then return nil; end
		state:AddSlot("Frame");
		state:AddSlot("SetTitleText");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local win, title = nil, (desc.title or VFLI.i18n("(No title)"));
		local btnReduce, btnClose;
		--local st = desc.showtitlebar;
		if not desc.texicon then desc.texicon = VFL.copy(VFLUI.ErrorTexture); end
		
		state:_Attach(state:Slot("Create"), true, function(w)
			win = w;
			w:SetFraming(VFLUI.Framing.Fat, 18, desc.bkd);
			win:SetText(title);
			
			if desc.defaultbuttons then
				btnClose = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\x");
				btnClose:SetHighlightColor(1,0,0,1);
				w:AddButton(btnClose);
				btnClose:SetScript("OnClick", function()
					RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path);
				end);
				
				--btnReduce = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\minus");
				--btnReduce:SetHighlightColor(1,1,0,1);
				--w:AddButton(btnReduce);
				--btnReduce:SetScript("OnClick", function()
				--	RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path, true);
				--	RDXPM.AddButtonWB({name = w._path, title = w._path, desc = "test", texture = (desc.texicon.path)});
				--end);
			end
		end);
		
		--state:_Attach(state:Slot("PostCreate"), true, function(w)
		--	if not st then w:HideTitleBar(); end
		--end);
		
		--state:Attach("Menu", true, function(w, mnu)
		--	table.insert(mnu, {
		--		text = VFLI.i18n("Toggle Titlebar");
		--		OnClick = function()
		--			if st then
		--				w:HideTitleBar();
		--				st = nil;
		--				desc.showtitlebar = nil;
		--			else
		--				w:ShowTitleBar();
		--				st = true;
		--				desc.showtitlebar = true;
		--			end
		--			VFL.poptree:Release();
		--		end;
		--	});
		--end);

		state:_Attach(state:Slot("SetTitleText"), nil, function(txt)
			win:SetText(title .. txt);
		end);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ed_title = VFLUI.LabeledEdit:new(parent, 100);
		ed_title:SetText(VFLI.i18n("Window title")); ed_title:Show();
		if desc and desc.title then ed_title.editBox:SetText(desc.title); end
		ui:InsertFrame(ed_title);
		
		--local chk_showtitlebar = VFLUI.Checkbox:new(ui); chk_showtitlebar:Show();
		--chk_showtitlebar:SetText(VFLI.i18n("Show Title Bar"));
		--if desc and desc.showtitlebar then chk_showtitlebar:SetChecked(true); else chk_showtitlebar:SetChecked(); end
		--ui:InsertFrame(chk_showtitlebar);
		
		local chk_defaultbuttons = VFLUI.Checkbox:new(ui); chk_defaultbuttons:Show();
		chk_defaultbuttons:SetText(VFLI.i18n("Add close and reduce buttons"));
		if desc and desc.defaultbuttons then chk_defaultbuttons:SetChecked(true); else chk_defaultbuttons:SetChecked(); end
		ui:InsertFrame(chk_defaultbuttons);
		
		local er_icon = VFLUI.EmbedRight(ui, VFLI.i18n("Icon in desktop bar"));
		local texicon = VFLUI.MakeTextureSelectButton(er_icon, desc.texicon); texicon:Show();
		er_icon:EmbedChild(texicon); er_icon:Show();
		ui:InsertFrame(er_icon);

		function ui:GetDescriptor()
			return {
				feature = "Frame: Fat"; 
				title = ed_title.editBox:GetText();
				--showtitlebar = chk_showtitlebar:GetChecked();
				defaultbuttons = chk_defaultbuttons:GetChecked();
				texicon = texicon:GetSelectedTexture();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function() 
		return {
			feature = "Frame: Fat",
			--showtitlebar = true;
			texicon = VFL.copy(VFLUI.ErrorTexture);
		}; 
	end
});

----------------------------------
-- Box frame
----------------------------------
RDX.RegisterFeature({
	name = "Frame: Box";
	title = VFLI.i18n("Frame: Box");
	category = VFLI.i18n("Window Frames");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		if not state:Slot("Create") then return nil; end
		if state:Slot("Frame") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state)
		if not desc then return nil; end
		state:AddSlot("Frame");
		state:AddSlot("SetTitleText");
		return true;
	end;
	ApplyFeature = function(desc, state)
		local win, title = nil, (desc.title or VFLI.i18n("(No title)"));
		local titleColor = desc.titleColor or _black;
		local bkdColor = desc.bkdColor or _alphaBlack;
		local btnReduce, btnClose;
		--local st = desc.showtitlebar;
		
		state:_Attach(state:Slot("Create"), true, function(w)
			win = w;
			w:SetFraming(VFLUI.Framing.Box, 18, desc.bkd);
			win:SetText(title);
			win:SetTitleColor(VFL.explodeColor(titleColor));
			--win:SetBackdropColor(VFL.explodeRGBA(bkdColor));
			
			if desc.defaultbuttons then
				btnClose = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\x");
				btnClose:SetHighlightColor(1,0,0,1);
				w:AddButton(btnClose);
				btnClose:SetScript("OnClick", function()
					RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path);
				end);
				
				--btnReduce = VFLUI.TexturedButton:new(w, 16, "Interface\\AddOns\\VFL\\Skin\\minus");
				--btnReduce:SetHighlightColor(1,1,0,1);
				--w:AddButton(btnReduce);
				--btnReduce:SetScript("OnClick", function()
				--	RDXDK.QueueLockdownAction(RDXDK._CloseWindowRDX, w._path, true);
				--	RDXPM.AddButtonWB({name = w._path, title = w._path, desc = "test", texture = (desc.texicon.path)});
				--end);
			end
		end);
		
		--state:_Attach(state:Slot("PostCreate"), true, function(w)
		--	if not st then w:HideTitleBar(); end
		--end);
		
		--state:Attach("Menu", true, function(w, mnu)
		--	table.insert(mnu, {
		--		text = VFLI.i18n("Toggle Titlebar");
		--		OnClick = function()
		--			if st then
		--				w:HideTitleBar();
		--				st = nil;
		--				desc.showtitlebar = nil;
		--			else
		--				w:ShowTitleBar();
		--				st = true;
		--				desc.showtitlebar = true;
		--			end
		--			VFL.poptree:Release();
		--		end;
		--	});
		--end);

		state:_Attach(state:Slot("SetTitleText"), nil, function(txt)
			win:SetText(title .. txt);
		end);
		return true;
	end,
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local title = VFLUI.LabeledEdit:new(ui, 100); title:Show();
		title:SetText(VFLI.i18n("Window Title"));
		if desc and desc.title then title.editBox:SetText(desc.title); end
		ui:InsertFrame(title);

		local titleColor = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Title color"));
		if desc and desc.titleColor then titleColor:SetColor(VFL.explodeRGBA(desc.titleColor)); end

		local bkdColor = RDXUI.GenerateColorSwatch(ui, VFLI.i18n("Background color"));
		if desc and desc.bkdColor then bkdColor:SetColor(VFL.explodeRGBA(desc.bkdColor)); end

		--local chk_showtitlebar = VFLUI.Checkbox:new(ui); chk_showtitlebar:Show();
		--chk_showtitlebar:SetText(VFLI.i18n("Show Title Bar"));
		--if desc and desc.showtitlebar then chk_showtitlebar:SetChecked(true); else chk_showtitlebar:SetChecked(); end
		--ui:InsertFrame(chk_showtitlebar);
		
		local chk_defaultbuttons = VFLUI.Checkbox:new(ui); chk_defaultbuttons:Show();
		chk_defaultbuttons:SetText(VFLI.i18n("Add close and reduce buttons"));
		if desc and desc.defaultbuttons then chk_defaultbuttons:SetChecked(true); else chk_defaultbuttons:SetChecked(); end
		ui:InsertFrame(chk_defaultbuttons);
		
		local er_icon = VFLUI.EmbedRight(ui, VFLI.i18n("Icon in desktop bar"));
		local texicon = VFLUI.MakeTextureSelectButton(er_icon, desc.texicon); texicon:Show();
		er_icon:EmbedChild(texicon); er_icon:Show();
		ui:InsertFrame(er_icon);
		
		function ui:GetDescriptor()
			return {
				feature = "Frame: Box"; 
				title = title.editBox:GetText();
				titleColor = titleColor:GetColor();
				bkdColor = bkdColor:GetColor();
				--showtitlebar = chk_showtitlebar:GetChecked();
				defaultbuttons = chk_defaultbuttons:GetChecked();
				texicon = texicon:GetSelectedTexture();
			};
		end

		return ui;
	end,
	CreateDescriptor = function() 
		return {
			feature = "Frame: Box";
			titleColor = { r=0,g=0,b=0,a=1 };
			bkdColor = {r=0,g=0,b=0,a=0.5};
			--showtitlebar = true;
			texicon = VFL.copy(VFLUI.ErrorTexture);
		}; 
	end
});

