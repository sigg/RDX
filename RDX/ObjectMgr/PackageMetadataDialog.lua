-- PackageMetadataDialog.lua
-- OpenRDX
-- Sigg / Rashgarroth EU

---------------------------------------------------------------
-- GUI to manage package metadata info
---------------------------------------------------------------

local dlg = nil;
function RDXDB.PackageMetadataDialog(parent, pkgname, pkgdata, callback)
	if dlg then return; end
	if not pkgname or not pkgdata then return; end
	if not callback then callback = VFL.Noop; end
	
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	--dlg:SetBackdrop(VFLUI.DefaultDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(260); dlg:SetHeight(300);
	dlg:SetTitleColor(0,.6,0);
	dlg:SetText("Package" .. " " .. pkgname .. " " .. "Metadata");
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("PackageMetadata") then RDXPM.RestoreLayout(dlg, "PackageMetadata"); end
	
	local ed_author = VFLUI.LabeledEdit:new(dlg, 150);
	ed_author:SetText(VFLI.i18n("Author"));
	ed_author.editBox:SetText(pkgdata["infoAuthor"] or "");
	ed_author:SetHeight(25); ed_author:SetWidth(250);
	ed_author:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	ed_author:Show();
	
	local ed_authorrealm = VFLUI.LabeledEdit:new(dlg, 150);
	ed_authorrealm:SetText(VFLI.i18n("Author realm"));
	ed_authorrealm.editBox:SetText(pkgdata["infoAuthorRealm"] or "");
	ed_authorrealm:SetHeight(25); ed_authorrealm:SetWidth(250);
	ed_authorrealm:SetPoint("TOPLEFT", ed_author, "BOTTOMLEFT");
	ed_authorrealm:Show();
	
	local ed_authoremail = VFLUI.LabeledEdit:new(dlg, 150);
	ed_authoremail:SetText(VFLI.i18n("Author email"));
	ed_authoremail.editBox:SetText(pkgdata["infoAuthorEmail"] or "");
	ed_authoremail:SetHeight(25); ed_authoremail:SetWidth(250);
	ed_authoremail:SetPoint("TOPLEFT", ed_authorrealm, "BOTTOMLEFT");
	ed_authoremail:Show();
	
	local ed_authorwebsite = VFLUI.LabeledEdit:new(dlg, 150);
	ed_authorwebsite:SetText(VFLI.i18n("Author website"));
	ed_authorwebsite.editBox:SetText(pkgdata["infoAuthorWebSite"] or "");
	ed_authorwebsite:SetHeight(25); ed_authorwebsite:SetWidth(250);
	ed_authorwebsite:SetPoint("TOPLEFT", ed_authoremail, "BOTTOMLEFT");
	ed_authorwebsite:Show();
	
	local ed_packageversion = VFLUI.LabeledEdit:new(dlg, 150);
	ed_packageversion:SetText(VFLI.i18n("Package version"));
	ed_packageversion.editBox:SetText(pkgdata["infoVersion"] or "");
	ed_packageversion:SetHeight(25); ed_packageversion:SetWidth(250);
	ed_packageversion:SetPoint("TOPLEFT", ed_authorwebsite, "BOTTOMLEFT");
	ed_packageversion:Show();
	
	local ed_comment = VFLUI.LabeledEdit:new(dlg, 150);
	ed_comment:SetText(VFLI.i18n("Comments"));
	ed_comment.editBox:SetText(pkgdata["infoComment"] or "");
	ed_comment:SetHeight(25); ed_comment:SetWidth(250);
	ed_comment:SetPoint("TOPLEFT", ed_packageversion, "BOTTOMLEFT");
	ed_comment:Show();
	
	local chk_isshare = VFLUI.Checkbox:new(dlg);
	chk_isshare:SetPoint("TOPLEFT", ed_comment, "BOTTOMLEFT");
	chk_isshare:SetHeight(25); chk_isshare:SetWidth(250);
	chk_isshare:SetText(VFLI.i18n("Package can be share"));
	if pkgdata["infoIsShare"] then chk_isshare:SetChecked(true); else chk_isshare:SetChecked(); end
	chk_isshare:Show();
	
	local chk_isimmutable = VFLUI.Checkbox:new(dlg);
	chk_isimmutable:SetPoint("TOPLEFT", chk_isshare, "BOTTOMLEFT");
	chk_isimmutable:SetHeight(25); chk_isimmutable:SetWidth(250);
	chk_isimmutable:SetText(VFLI.i18n("Package is immutable"));
	if pkgdata["infoIsImmutable"] then chk_isimmutable:SetChecked(true); else chk_isimmutable:SetChecked(); end
	chk_isimmutable:Show();
	
	local chk_isindelible = VFLUI.Checkbox:new(dlg);
	chk_isindelible:SetPoint("TOPLEFT", chk_isimmutable, "BOTTOMLEFT");
	chk_isindelible:SetHeight(25); chk_isindelible:SetWidth(250);
	chk_isindelible:SetText(VFLI.i18n("Package is indelible"));
	if pkgdata["infoIsIndelible"] then chk_isindelible:SetChecked(true); else chk_isindelible:SetChecked(); end
	chk_isindelible:Show();
	
	local chk_runautoexec = VFLUI.Checkbox:new(dlg);
	chk_runautoexec:SetPoint("TOPLEFT", chk_isindelible, "BOTTOMLEFT");
	chk_runautoexec:SetHeight(25); chk_runautoexec:SetWidth(250);
	chk_runautoexec:SetText(VFLI.i18n("Run autoexec script"));
	if pkgdata["infoRunAutoexec"] then chk_runautoexec:SetChecked(true); else chk_runautoexec:SetChecked(); end
	chk_runautoexec:Show();
	
	local chk_iscommon = VFLUI.Checkbox:new(dlg);
	chk_iscommon:SetPoint("TOPLEFT", chk_runautoexec, "BOTTOMLEFT");
	chk_iscommon:SetHeight(25); chk_iscommon:SetWidth(250);
	chk_iscommon:SetText(VFLI.i18n("Package is common"));
	if pkgdata["infoIsCommon"] then chk_iscommon:SetChecked(true); else chk_iscommon:SetChecked(); end
	chk_iscommon:Show();
	
	dlg:Show();
	
	local esch = function()
		RDXPM.StoreLayout(dlg, "PackageMetadata");
		dlg:Destroy(); dlg = nil;
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
		local pkgdata = {};
		pkgdata["infoAuthor"] = ed_author.editBox:GetText();
		pkgdata["infoAuthorRealm"] = ed_authorrealm.editBox:GetText();
		pkgdata["infoAuthorEmail"] = ed_authoremail.editBox:GetText();
		pkgdata["infoAuthorWebSite"] = ed_authorwebsite.editBox:GetText();
		pkgdata["infoVersion"] = ed_packageversion.editBox:GetText();
		pkgdata["infoComment"] = ed_comment.editBox:GetText();
		if chk_isshare:GetChecked() then pkgdata["infoIsShare"] = true; else pkgdata["infoIsShare"] = false; end
		if chk_isimmutable:GetChecked() then pkgdata["infoIsImmutable"] = true; else pkgdata["infoIsImmutable"] = false; end
		if chk_isindelible:GetChecked() then pkgdata["infoIsIndelible"] = true; else pkgdata["infoIsIndelible"] = false; end
		if chk_runautoexec:GetChecked() then pkgdata["infoRunAutoexec"] = true; else pkgdata["infoRunAutoexec"] = false; end
		if chk_iscommon:GetChecked() then pkgdata["infoIsCommon"] = true; else pkgdata["infoIsCommon"] = false; end
		if callback then callback(pkgname, pkgdata); end
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
		chk_iscommon:Destroy(); chk_iscommon = nil;
		btnOK:Destroy(); btnOK = nil;
	end, dlg.Destroy);
end

--
RDXDB.RegisterPackageMenuHandler(function(mnu, pkg, dialog)
	table.insert(mnu, {
		text = VFLI.i18n("Info Package"), func = function() VFL.poptree:Release(); RDXDB.PackageMetadataDialog(dialog, pkg, RDXDB.GetAllPackageMetadata(pkg), function(pkgname, pkgdata) RDXDB.SetAllPackageMetadata(pkgname, pkgdata) end); end
	});
end);