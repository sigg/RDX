-- PackageMetadataDialog.lua
-- OpenRDX
-- Sigg / Rashgarroth EU

---------------------------------------------------------------
-- GUI to manage package metadata info
---------------------------------------------------------------

local dlg = nil;
function RDXDB.PackageMetadataDialog(pkg, parent)
	if dlg then return; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	--dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", VFLParent, "CENTER");
	dlg:SetWidth(260); dlg:SetHeight(275);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText("Package " .. pkg .. " Metadata Dialog");
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("PackageMetadata") then RDXPM.RestoreLayout(dlg, "PackageMetadata"); end
	
	local ed_author = VFLUI.LabeledEdit:new(dlg, 150);
	ed_author:SetText(VFLI.i18n("Author"));
	ed_author.editBox:SetText(RDXDB.GetPackageMetadata(pkg, "infoAuthor") or "");
	ed_author:SetHeight(25); ed_author:SetWidth(250);
	ed_author:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	ed_author:Show();
	
	local ed_authorrealm = VFLUI.LabeledEdit:new(dlg, 150);
	ed_authorrealm:SetText(VFLI.i18n("Author realm"));
	ed_authorrealm.editBox:SetText(RDXDB.GetPackageMetadata(pkg, "infoAuthorRealm") or "");
	ed_authorrealm:SetHeight(25); ed_authorrealm:SetWidth(250);
	ed_authorrealm:SetPoint("TOPLEFT", ed_author, "BOTTOMLEFT");
	ed_authorrealm:Show();
	
	local ed_authoremail = VFLUI.LabeledEdit:new(dlg, 150);
	ed_authoremail:SetText(VFLI.i18n("Author email"));
	ed_authoremail.editBox:SetText(RDXDB.GetPackageMetadata(pkg, "infoAuthorEmail") or "");
	ed_authoremail:SetHeight(25); ed_authoremail:SetWidth(250);
	ed_authoremail:SetPoint("TOPLEFT", ed_authorrealm, "BOTTOMLEFT");
	ed_authoremail:Show();
	
	local ed_authorwebsite = VFLUI.LabeledEdit:new(dlg, 150);
	ed_authorwebsite:SetText(VFLI.i18n("Author website"));
	ed_authorwebsite.editBox:SetText(RDXDB.GetPackageMetadata(pkg, "infoAuthorWebSite") or "");
	ed_authorwebsite:SetHeight(25); ed_authorwebsite:SetWidth(250);
	ed_authorwebsite:SetPoint("TOPLEFT", ed_authoremail, "BOTTOMLEFT");
	ed_authorwebsite:Show();
	
	local ed_packageversion = VFLUI.LabeledEdit:new(dlg, 150);
	ed_packageversion:SetText(VFLI.i18n("Package version"));
	ed_packageversion.editBox:SetText(RDXDB.GetPackageMetadata(pkg, "infoVersion") or "");
	ed_packageversion:SetHeight(25); ed_packageversion:SetWidth(250);
	ed_packageversion:SetPoint("TOPLEFT", ed_authorwebsite, "BOTTOMLEFT");
	ed_packageversion:Show();
	
	local ed_comment = VFLUI.LabeledEdit:new(dlg, 150);
	ed_comment:SetText(VFLI.i18n("Comment"));
	ed_comment.editBox:SetText(RDXDB.GetPackageMetadata(pkg, "infoComment") or "");
	ed_comment:SetHeight(25); ed_comment:SetWidth(250);
	ed_comment:SetPoint("TOPLEFT", ed_packageversion, "BOTTOMLEFT");
	ed_comment:Show();
	
	local chk_isshare = VFLUI.Checkbox:new(dlg);
	chk_isshare:SetPoint("TOPLEFT", ed_comment, "BOTTOMLEFT");
	chk_isshare:SetHeight(25); chk_isshare:SetWidth(250);
	chk_isshare:SetText("Package can be share");
	if RDXDB.GetPackageMetadata(pkg, "infoIsShare") then chk_isshare:SetChecked(true); else chk_isshare:SetChecked(); end
	chk_isshare:Show();
	
	local chk_isimmutable = VFLUI.Checkbox:new(dlg);
	chk_isimmutable:SetPoint("TOPLEFT", chk_isshare, "BOTTOMLEFT");
	chk_isimmutable:SetHeight(25); chk_isimmutable:SetWidth(250);
	chk_isimmutable:SetText("Package is immutable");
	if RDXDB.GetPackageMetadata(pkg, "infoIsImmutable") then chk_isimmutable:SetChecked(true); else chk_isimmutable:SetChecked(); end
	chk_isimmutable:Show();
	
	local chk_isindelible = VFLUI.Checkbox:new(dlg);
	chk_isindelible:SetPoint("TOPLEFT", chk_isimmutable, "BOTTOMLEFT");
	chk_isindelible:SetHeight(25); chk_isindelible:SetWidth(250);
	chk_isindelible:SetText("Package is indelible");
	if RDXDB.GetPackageMetadata(pkg, "infoIsIndelible") then chk_isindelible:SetChecked(true); else chk_isindelible:SetChecked(); end
	chk_isindelible:Show();
	
	local chk_runautoexec = VFLUI.Checkbox:new(dlg);
	chk_runautoexec:SetPoint("TOPLEFT", chk_isindelible, "BOTTOMLEFT");
	chk_runautoexec:SetHeight(25); chk_runautoexec:SetWidth(250);
	chk_runautoexec:SetText("Run autoexec script");
	if RDXDB.GetPackageMetadata(pkg, "infoRunAutoexec") then chk_runautoexec:SetChecked(true); else chk_runautoexec:SetChecked(); end
	chk_runautoexec:Show();
	
	dlg:Show();
	--dlg:Show(.2, true);
	
	local esch = function()
		--dlg:Hide(.2, true);
		--VFLT.ZMSchedule(.25, function()
			RDXPM.StoreLayout(dlg, "PackageMetadata");
			dlg:Destroy(); dlg = nil;
		--end);
	end
	VFL.AddEscapeHandler(esch);
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	
	-- OK
	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetHeight(25); btnOK:SetWidth(60);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:SetText("OK"); btnOK:Show();
	btnOK:SetScript("OnClick", function()
		RDXDB.SetPackageMetadata(pkg, "infoAuthor", ed_author.editBox:GetText());
		RDXDB.SetPackageMetadata(pkg, "infoAuthorRealm", ed_authorrealm.editBox:GetText());
		RDXDB.SetPackageMetadata(pkg, "infoAuthorEmail", ed_authoremail.editBox:GetText());
		RDXDB.SetPackageMetadata(pkg, "infoAuthorWebSite", ed_authorwebsite.editBox:GetText());
		RDXDB.SetPackageMetadata(pkg, "infoVersion", ed_packageversion.editBox:GetText());
		RDXDB.SetPackageMetadata(pkg, "infoComment", ed_comment.editBox:GetText());
		RDXDB.SetPackageMetadata(pkg, "infoIsShare", chk_isshare:GetChecked());
		RDXDB.SetPackageMetadata(pkg, "infoIsImmutable", chk_isimmutable:GetChecked());
		RDXDB.SetPackageMetadata(pkg, "infoIsIndelible", chk_isindelible:GetChecked());
		RDXDB.SetPackageMetadata(pkg, "infoRunAutoexec", chk_runautoexec:GetChecked());
		VFL.EscapeTo(esch);
	end);

	-- Destructor
	dlg.Destroy = VFL.hook(function(s)
		ed_author:Destroy(); ed_author = nil;
		ed_authorrealm:Destroy(); ed_authorrealm = nil;
		ed_authoremail:Destroy(); ed_authoremail = nil;
		ed_authorwebsite:Destroy(); ed_authorwebsite = nil;
		ed_packageversion:Destroy(); ed_packageversion = nil;
		ed_comment:Destroy(); ed_comment = nil;
		chk_isshare:Destroy(); chk_isshare = nil;
		chk_isimmutable:Destroy(); chk_isimmutable = nil;
		chk_isindelible:Destroy(); chk_isindelible = nil;
		chk_runautoexec:Destroy(); chk_runautoexec = nil;
		btnOK:Destroy(); btnOK = nil;
	end, dlg.Destroy);
end

RDXDB.RegisterPackageMenuHandler(function(mnu, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Info Package"), OnClick = function() VFL.poptree:Release(); RDXDB.PackageMetadataDialog(pkg, dialog); end
	});
end);