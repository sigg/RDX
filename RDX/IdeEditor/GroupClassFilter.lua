-- GroupClassFilter.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE LICENCE.
-- UNLICENSED COPYING IS PROHIBITED.
--
-- Custom controls for generic group/class-based filtering schemes.

------------------------------
-- Group filter
------------------------------
RDXUI.GroupFilterUI = {};

function RDXUI.GroupFilterUI:new(parent)
	local self = VFLUI.GroupBox:new(parent);
	VFLUI.GroupBox.MakeTextCaption(self, VFLI.i18n("Groups"));
	self:SetLayoutConstraint("WIDTH_DOWNWARD_HEIGHT_UPWARD");

	local checks = VFLUI.CheckGroup:new(self);
	self:SetClient(checks); checks:Show();
	checks:SetLayout(8, 2);
	for i=1,8 do checks.checkBox[i]:SetText(VFLI.i18n("Group ") .. i); end

	local all = VFLUI.Button:new(self);
	all:SetBackdrop(VFLUI.BorderlessDialogBackdrop);
	all:SetHeight(16); all:SetWidth(35); all:SetText(VFLI.i18n("All"));
	all:SetPoint("RIGHT", self:GetCaptionArea(), "RIGHT"); all:Show();
	all:SetScript("OnClick", function() for i=1,8 do checks.checkBox[i]:SetChecked(true); end end);
	self:AddDecoration(all);

	local none = VFLUI.Button:new(self);
	none:SetBackdrop(VFLUI.BorderlessDialogBackdrop);
	none:SetHeight(16); none:SetWidth(35); none:SetText(VFLI.i18n("None"));
	none:SetPoint("RIGHT", all, "LEFT"); none:Show();
	none:SetScript("OnClick", function() for i=1,8 do checks.checkBox[i]:SetChecked(); end end);
	self:AddDecoration(none);

	function self:GetGroups()
		local grps = {};
		for i=1,8 do
			if checks.checkBox[i]:GetChecked() then grps[i] = true; end
		end
		return grps;
	end
	function self:SetGroups(grps)
		if type(grps) ~= "table" then grps = nil; end
		for i=1,8 do
			if grps and grps[i] then checks.checkBox[i]:SetChecked(true); else checks.checkBox[i]:SetChecked(); end
		end
	end

	self.Destroy = VFL.hook(function(s)
		s.GetGroups = nil; s.SetGroups = nil;
	end, self.Destroy);

	return self;
end

------------------------------
-- Class filter
------------------------------
RDXUI.ClassFilterUI = {};

function RDXUI.ClassFilterUI:new(parent)
	local self = VFLUI.GroupBox:new(parent);
	VFLUI.GroupBox.MakeTextCaption(self, VFLI.i18n("Classes"));
	self:SetLayoutConstraint("WIDTH_DOWNWARD_HEIGHT_UPWARD");

	local checks = VFLUI.CheckGroup:new(self);
	self:SetClient(checks); checks:Show();
	checks:SetLayout(10, 3);
	for i=1,10 do 
		checks.checkBox[i]:SetText(VFL.strtcolor(RDXMD.GetClassColor(i)) .. RDXMD.GetClassName(i) .. "|r" ); 
	end

	local all = VFLUI.Button:new(self);
	all:SetBackdrop(VFLUI.BorderlessDialogBackdrop);
	all:SetHeight(16); all:SetWidth(35); all:SetText(VFLI.i18n("All"));
	all:SetPoint("RIGHT", self:GetCaptionArea(), "RIGHT"); all:Show();
	all:SetScript("OnClick", function() for i=1,10 do checks.checkBox[i]:SetChecked(true); end end);
	self:AddDecoration(all);

	local none = VFLUI.Button:new(self);
	none:SetBackdrop(VFLUI.BorderlessDialogBackdrop);
	none:SetHeight(16); none:SetWidth(35); none:SetText(VFLI.i18n("None"));
	none:SetPoint("RIGHT", all, "LEFT"); none:Show();
	none:SetScript("OnClick", function() for i=1,10 do checks.checkBox[i]:SetChecked(); end end);
	self:AddDecoration(none);

	function self:GetClasses()
		local grps = {};
		for i=1,10 do
			if checks.checkBox[i]:GetChecked() then grps[i] = true; end
		end
		return grps;
	end
	function self:SetClasses(grps)
		if type(grps) ~= "table" then grps = nil; end
		for i=1,10 do
			if grps and grps[i] then checks.checkBox[i]:SetChecked(true); else checks.checkBox[i]:SetChecked(); end
		end
	end

	self.Destroy = VFL.hook(function(s)
		s.GetClasses = nil; s.SetClasses = nil;
	end, self.Destroy);

	return self;
end
