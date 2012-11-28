-- ConfMgr.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- UI tools for managing conferences.

------------------------------------------------------------------------------------------
-- A tool for selecting an RPC conference from a list of currently available conferences.
------------------------------------------------------------------------------------------
RPC.ConfFinder = {};

local _ctbl = {};
local function buildConfDD()
	VFL.empty(_ctbl); local i = 0;
	for id,conf in pairs(RPC.Conferences()) do
		table.insert(_ctbl, {text = id}); i=i+1;
	end
	table.sort(_ctbl, function(x1,x2) return x1.text<x2.text; end);
	return _ctbl;
end

function RPC.ConfFinder:new(parent)
	local self = VFLUI.Dropdown:new(parent, buildConfDD);
	self:SetSelection("(none)");

-- Chat-based conferences temporarily disabled
--[[
	local ncbtn = VFLUI.Button:new(self);
	ncbtn:SetHeight(25); ncbtn:SetWidth(25); ncbtn:SetPoint("LEFT", self, "RIGHT");
	ncbtn:Show(); ncbtn:SetText("+");
	ncbtn:SetScript("OnClick", function()
		RPC.createConference:SetDescriptor({});
		RPC.createConference:Open(parent);
	end);
]]--

	function self:GetConference()
		return RPC.GetConferenceByID(self:GetSelection());
	end

	function self:SetConferenceID(id)
		self:SetSelection(id or "(none)");
	end

	self.Destroy = VFL.hook(function(s)
		s.GetConference = nil;
--		ncbtn:Destroy(); ncbtn = nil;
	end, self.Destroy);

	return self;
end

-----------------------------------------------------------------
-- A "wizard" type tool for creating new conferences.
-----------------------------------------------------------------
--[[
local cw = RDXUI.Wizard:new();

cw:RegisterPage(1, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Basics");
		
		local lbl = VFLUI.MakeLabel(nil, page, "Enter a name for this conference. You can use the randomly generated name below or create your own. Your name must not exceed 15 characters in length and must contain only alphanumeric characters.");
		lbl:SetWidth(250); lbl:SetHeight(50);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);
		local edName = VFLUI.Edit:new(page);
		edName:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		edName:SetHeight(25); edName:SetWidth(250); edName:Show();
		if desc and desc.name then
			edName:SetText(desc.name)
		else
			edName:SetText(math.random(1, 10000000));
		end

		local lbl = VFLUI.MakeLabel(nil, page, "Enter a timeout in minutes after which time this conference will automatically shut down:");
		lbl:SetWidth(250); lbl:SetHeight(20);
		lbl:SetPoint("TOPLEFT", edName, "BOTTOMLEFT", 0, -5);
		local edTo = VFLUI.Edit:new(page);
		edTo:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		edTo:SetHeight(25); edTo:SetWidth(250); edTo:Show();
		edTo:SetText("10");
		if desc and desc.timeout then
			edTo:SetText(desc.timeout);
		else
			edTo:SetText(10);
		end

		function page:GetDescriptor()
			return { name = edName:GetText(); timeout = VFL.clamp(edTo:GetNumber(), 1, 120); };
		end

		page.Destroy = VFL.hook(function(s)
			edName:Destroy(); edTo:Destroy();
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(2); end);
		return page;
		end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.name) or (not RDXDB.IsValidFileName(desc.name)) or (string.len(desc.name) > 15) then errs:AddError("Invalid conference name."); end
		if RPC.GetConferenceByID(desc.name) then errs:AddError("That conference name is already in use."); end
		-- TODO: check to see if this conference already exists!
		if (not desc.timeout) then errs:AddError("Invalid timeout."); end
		return not errs:HasError();
	end;
});

cw:RegisterPage(2, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Invitations");
		
		local lbl = VFLUI.MakeLabel(nil, page, "You can invite people in your group to join this conference. You can either invite all people matching a given filter, or invite people by entering their names directly.");
		lbl:SetWidth(250); lbl:SetHeight(40);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local btn1 = VFLUI.Button:new(page);
		btn1:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		btn1:SetWidth(250); btn1:SetHeight(25);
		btn1:Show(); btn1:SetText("Invite by filter");
		btn1:SetScript("OnClick", function() wizard:SetPage(3); end);
		local btn2 = VFLUI.Button:new(page);
		btn2:SetPoint("TOPLEFT", btn1, "BOTTOMLEFT");
		btn2:SetWidth(250); btn2:SetHeight(25);
		btn2:Show(); btn2:SetText("Invite by list of names");
		btn2:SetScript("OnClick", function() wizard:SetPage(4); end);

		page:SetHeight(120);

		page.Destroy = VFL.hook(function(s)
			btn1:Destroy(); btn2:Destroy();
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(5); end);
		return page;
		end;
	Verify = function(desc, wizard, errs)
		return true;
	end;
});

cw:RegisterPage(3, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Filter");
		page:SetWidth(430); page:SetHeight(342);
		local lbl = VFLUI.MakeLabel(nil, page, "Create a filter that will be used to invite people to the conference.");
		lbl:SetWidth(430); lbl:SetHeight(20);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local fe = RDXDAL.FilterEditor:new(page);
		fe:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		fe:Show();
		if desc and desc.filter then fe:LoadDescriptor(desc.filter); else fe:LoadDescriptor(nil); end

		function page:GetDescriptor()
			return { filter = fe:GetDescriptor() };
		end

		page.Destroy = VFL.hook(function(s)
			fe:Destroy(); fe = nil;
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(5); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.filter) then errs:AddError("Please create a filter."); end
		return not errs:HasError();
	end
});

cw:RegisterPage(4, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Invite List");
		page:SetWidth(250); page:SetHeight(280);

		local list = nil; if desc then list = desc.list; end
		list = list or {};
		
		local lbl = VFLUI.MakeLabel(nil, page, "Enter a list of names to be invited to this conference.");
		lbl:SetWidth(250); lbl:SetHeight(20);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		local le = VFLUI.ListEditor:new(page, list, function(cell,data) cell.text:SetText(data); end);
		le:SetPoint("TOPLEFT", lbl, "BOTTOMLEFT");
		le:SetWidth(250); le:SetHeight(183); le:Show();

		function page:GetDescriptor()
			local list = le:GetList();
			for k,v in pairs(list) do list[k] = string.lower(tostring(v)); end
			return { list = list };
		end

		page.Destroy = VFL.hook(function(s)
			le:Destroy(); le = nil;
		end, page.Destroy);
		wizard:OnNext(function(wiz) wiz:SetPage(5); end);
		return page;
	end;
	Verify = function(desc, wizard, errs)
		if not desc then errs:AddError("Invalid descriptor."); end
		if (not desc.list) then errs:AddError("Please enter a list."); end
		return not errs:HasError();
	end
});

cw:RegisterPage(5, {
	OpenPage = function(parent, wizard, desc)
		local page = RDXUI.GenerateStdWizardPage(parent, "Finalize");
		page:SetWidth(250); page:SetHeight(100);
		
		local lbl = VFLUI.MakeLabel(nil, page, "You've entered all necessary information. Click OK to create your conference and invite the participants, or Cancel to abort all actions.");
		lbl:SetWidth(250); lbl:SetHeight(50);
		lbl:SetPoint("TOPLEFT", page, "TOPLEFT", 0, -20);

		wizard:Final();
		return page;
	end;
	Verify = function(desc, wizard, errs)
		return true;
	end
});

function cw:OnOK()
	local confName = self:GetPageDescriptor(1).name;
	local confTimeout = tonumber(self:GetPageDescriptor(1).timeout) * 60;

	-- Generate the conference
	local conf = RPC.CreateConference();
	RPC.ImbueStandardRPC(conf);
	RPC.AttachChatChannel(RDX.GetChatChannel("rdx" .. confName), conf);
	RPC.RegisterConference(conf, confName, confTimeout);

	if self:GetPageDescriptor(3) then
		VFLT.schedule(2, function()
			RPC:Debug(1, "Sending conf_inv_f invite.");
			RPC_Group:Invoke("conf_inv_f", confName, "rdx" .. confName, confTimeout, self:GetPageDescriptor(3).filter);
		end);
	elseif self:GetPageDescriptor(4) then
		VFLT.schedule(2, function()
			RPC:Debug(1, "Sending conf_inv_l invite.");
			RPC_Group:Invoke("conf_inv_l", confName, "rdx" .. confName, confTimeout, self:GetPageDescriptor(4).list);
		end);
	end
end

cw.title = "Create conference";
RPC.createConference = cw;
]]--

