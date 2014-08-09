-- Search.lua
-- RDX - Project Omniscience
-- (C)2006 Raid Informatics
--
-- Implementation of the remote log search interface.


-- "Search" query: match a log against a filter, returning a number of matches.
local function Omni_SearchQuery(commInfo, filterDef)
	if not RPC.IsGroupLeader(commInfo) then return; end
	-- Get the filter function from the remote filter definition
	local filter = Omni.FilterFunctor(filterDef);
	-- Execute and find the matches
	return Omni.ExtractTemporalMatches(Omni.localLog, 10, "LAST", filter);
end
RPC.Bind("Omni_Q_Search", Omni_SearchQuery);

------------------------------------------------
-- RESULTS DISPLAY
------------------------------------------------
local searches = {};

local function Search_ResponseRcvd(ci, data)
	if (type(data) ~= "table") then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	local win = searches[ci.id]; if not win then return; end
	local nm = win._nameMap; if (not nm) or (not nm[ci.sender]) then return; end

	-- Update the response
	nm[ci.sender].resp = true;
	nm[ci.sender].n = #data;
	nm[ci.sender].matches = data;

	if win.sortField == "n" then
		win:SortGT("n");
	else
		win:RepaintAll();
	end
end

local function Search_ApplyData(win, frame, icv, data)
	local nm = win._nameMap; if not nm then return; end
	local row = nm[data]; if not row then return; end
	frame.text1:SetText(VFL.strtcolor(RDXMD.GetClassColor(row.class)) .. row.name .. "|r");
	frame.bar:SetValue(0);
	if (not row.resp) then -- no resp
		frame.text2:SetText("|cFF444444(No resp)|r");
		return; 
	end
	frame.text2:SetText("|cFFFFFFFF" .. row.n .. "|r");
	-- When clicked, popup the matches and let user investigate in detail.
	local name, matches = row.name, row.matches;
	if not matches then frame:GetHotspot():SetScript("OnClick", nil); return; end
	frame:GetHotspot():SetScript("OnClick", function(self)
		local mnu = {};
		for _,t in ipairs(matches) do
			table.insert(mnu, {
				text = date("%H:%M:%S", t);
				func = function() VFL.poptree:Release(); Omni.TimeQueryDialog(string.lower(name), t, 120); end;
			});
		end
		VFL.poptree:Begin(120, 12, self, "TOPLEFT", VFLUI.GetRelativeLocalMousePosition(self));
		VFL.poptree:Expand(nil, mnu);
	end);
end

local function Search_Start(filterDef)
	if type(filterDef) ~= "table" then return; end
	local pw = Logistics.NewWindow(nil, "Omniscience Search", nil, 110, 70);
	pw:SetApplyData(Search_ApplyData);
	pw:SetupNameMap(function(x,t) t.n = 0; end);

	-- Window popup menu
	function pw:_WindowMenu(mnu)
		table.insert(mnu, {
			text = "Sort by Name", func = function() VFL.poptree:Release(); self:Sort("name"); end
		});
		table.insert(mnu, {
			text = "Sort by Class", func = function() VFL.poptree:Release(); self:Sort("class"); end
		});
		table.insert(mnu, {
			text = "Sort by Matches", func = function() VFL.poptree:Release(); self:SortGT("n"); end
		});
	end

	-- Destructor. On destroy, clear us from the checks table
	pw.Destroy = VFL.hook(function(s) searches[s._rpcid] = nil; end, pw.Destroy);

	-- Send out the RPC and bind us to the responses.
	local rpcid = RPC_Group:Invoke("Omni_Q_Search", filterDef);
	pw._rpcid = rpcid;
	searches[rpcid] = pw;
	RPC_Group:Wait(rpcid, Search_ResponseRcvd, 30);
	pw:Sort("n");
end

--- Menu hook
local dlg = nil;
local function DoOmniSearch(parent)
	if dlg then return; end
	dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(360); dlg:SetHeight(390);
	dlg:SetText("Search Logs");
	dlg:SetClampedToScreen(true);
	
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());
	if RDXPM.Ismanaged("search_omniscience") then RDXPM.RestoreLayout(dlg, "search_omniscience"); end

	local fe = Omni.FilterEditor:new(dlg);
	fe:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	fe:Show();
	
	--dlg:Show();
	dlg:_Show(RDX.smooth);

	local esch = function()
		dlg:_Hide(RDX.smooth, nil, function()
			RDXPM.StoreLayout(dlg, "search_omniscience");
			dlg:Destroy(); dlg = nil;
		end);
	end

	VFL.AddEscapeHandler(esch);
	
	function dlg:_esch()
		VFL.EscapeTo(esch);
	end
	
	local btnClose = VFLUI.CloseButton:new(dlg);
	dlg:AddButton(btnClose);
	btnClose:SetScript("OnClick", function() VFL.EscapeTo(esch); end);

	local btnOK = VFLUI.OKButton:new(dlg);
	btnOK:SetText("OK"); btnOK:SetHeight(25); btnOK:SetWidth(75);
	btnOK:SetPoint("BOTTOMRIGHT", dlg:GetClientArea(), "BOTTOMRIGHT");
	btnOK:Show();
	btnOK:SetScript("OnClick", function()
		Search_Start(fe:GetDescriptor());
		VFL.EscapeTo(esch);
	end);

	dlg.Destroy = VFL.hook(function(s)
		btnOK:Destroy(); btnOK = nil;
		fe:Destroy(); fe = nil;
		dlg = nil;
	end, dlg.Destroy);
end

function Omni.ToggleOmniSearch()
	if dlg then
		dlg:_esch();
	else
		DoOmniSearch();
	end
end

