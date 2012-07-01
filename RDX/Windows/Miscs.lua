-- Misc.lua
-- OpenRDX
--

---------------------------------------------------------------------
-- The "Description" feature that lets windows have descriptions.
---------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Description";
	title = VFLI.i18n("Description");
	category = VFLI.i18n("Miscs");
	IsPossible = function(state)
		if state:Slot("GetContainingWindowState") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if (not desc) or (not desc.description) then
			VFL.AddError(errs, VFLI.i18n("Invalid description"));
			return nil;
		end
		return true;
	end;
	ApplyFeature = VFL.Noop;
	UIFromDescriptor = function(desc, parent, state)
		local txt = VFLUI.AcquireFrame("EditBox");
		VFLUI.StdSetParent(txt, parent, 1);
		txt:SetFontObject(Fonts.Default);
		txt:SetTextInsets(0,0,0,0);
		txt:SetAutoFocus(nil); txt:ClearFocus();
		txt:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
		txt:SetMultiLine(true); txt:Show();
		if desc and desc.description then txt:SetText(desc.description); end
		txt:SetFocus()

		txt.DialogOnLayout = VFL.Noop;
		function txt:GetDescriptor() return {feature = "Description", description = self:GetText(); } end

		return txt;
	end;
	CreateDescriptor = function() return {feature = "Description", description = ""}; end;
});

---------------------------------------------------------------------
-- Feature for hiding in windowlist.
---------------------------------------------------------------------
RDX.RegisterFeature({
	name = "WindowListHide";
	title = VFLI.i18n("Hide From Window list");
	category = VFLI.i18n("Miscs");
	IsPossible = function(state)
		if not state:Slot("Window") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		return true;
	end;
	ApplyFeature = VFL.Noop;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return {feature = "WindowListHide"}; end;
});


---------------------------------------------------------------------
-- The Tab feature that lets windows have tabtitle and tabsize.
---------------------------------------------------------------------
RDX.RegisterFeature({
	name = "taboptions";
	title = VFLI.i18n("Tab Options");
	category = VFLI.i18n("Miscs");
	IsPossible = function(state)
		if state:Slot("GetContainingWindowState") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if (not desc) or (not desc.tabtitle) or (not desc.tabwidth) then
			VFL.AddError(errs, VFLI.i18n("Invalid title or width"));
			return nil;
		end
		return true;
	end;
	ApplyFeature = VFL.Noop;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local ed_tabtitle = VFLUI.LabeledEdit:new(ui, 100); ed_tabtitle:Show();
		ed_tabtitle:SetText(VFLI.i18n("Tab Title"));
		if desc and desc.tabtitle then ed_tabtitle.editBox:SetText(desc.tabtitle); end
		ui:InsertFrame(ed_tabtitle);
		
		local ed_tabwidth = VFLUI.LabeledEdit:new(ui, 100); ed_tabwidth:Show();
		ed_tabwidth:SetText(VFLI.i18n("Tab Width"));
		if desc and desc.tabwidth then ed_tabwidth.editBox:SetText(desc.tabwidth); end
		ui:InsertFrame(ed_tabwidth);
		
		function ui:GetDescriptor()
			local a = ed_tabwidth.editBox:GetNumber(); if not a then a=80; end a = VFL.clamp(a, 1, 400);
			return {feature = "taboptions", tabtitle = ed_tabtitle.editBox:GetText(); tabwidth = a; }
		end

		return ui;
	end;
	CreateDescriptor = function() return {feature = "taboptions", tabtitle = "Tab", tabwidth = 80}; end;
});

RDX.RegisterFeature({
	name = "AuraCache";
	title = VFLI.i18n("AuraCache");
	category = VFLI.i18n("Miscs");
	IsPossible = function(state)
		if state:Slot("GetContainingWindowState") then return nil; end
		if not state:Slot("DesignFrame") then return nil; end
		if state:Slot("RepaintAllArgs") then return true; end
		return nil;
	end;
	ExposeFeature = function(desc, state, errs)
		return true;
	end;
	ApplyFeature = function(desc, state)
		return true;
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return {feature = "AuraCache"}; end;
});