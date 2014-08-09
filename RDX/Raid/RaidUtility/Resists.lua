-- Resists.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Resist checking.

function Logistics.GetResists()
	local _,fire = UnitResistance("player", 2);
	local _,nature = UnitResistance("player", 3);
	local _,frost = UnitResistance("player", 4);
	local _,shadow = UnitResistance("player", 5);
	local _,arcane = UnitResistance("player", 6);
	return fire, frost, nature, arcane, shadow;
end

----------------------------------------------
-- RESPONDER
----------------------------------------------
local function RCIncRPC(ci)
	-- Sanity check sender
	if (not ci) then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	if not sunit:IsLeader() then return; end
	return Logistics.GetResists();
end

RPC_Group:Bind("logistics_res", RCIncRPC);

----------------------------------------------
-- DISPLAY
----------------------------------------------
local rchecks = {};

local function RC_ResponseRcvd(ci, fire, frost, nature, arcane, shadow)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (not ci) or (not ci.sender) or (not ci.id) then return; end
	fire = tonumber(fire); frost = tonumber(frost); nature = tonumber(nature); arcane = tonumber(arcane);
	shadow = tonumber(shadow);
	if(not fire) or (not frost) or (not nature) or (not arcane) or (not shadow) then return; end

	local win = rchecks[ci.id]; if not win then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	local nm = win._nameMap; if (not nm) then return; end
	local qq = nm[ci.sender]; if not qq then return; end

	-- Update the response.
	qq.fire = fire;
	qq.frost = frost;
	qq.nature = nature;
	qq.arcane = arcane;
	qq.shadow = shadow;
	qq.total = fire+frost+nature+arcane+shadow;
	qq.resp = true;

	win:RepaintAll();
end

local function RCWin_ApplyData(win, frame, icv, data)
	local nm = win._nameMap; if not nm then return; end
	local row = nm[data]; if not row then return; end
	frame.bar:SetValue(0);
	frame.text1:SetText(VFL.strtcolor(RDXMD.GetClassColor(row.class)) .. row.name .. "|r");
	if (not row.resp) then -- no resp
		frame.text2:SetText("|cFF444444(No resp)|r");
		return; 
	end
	frame.text2:SetText(VFL.strcolor(1,0,0)..row.fire.." "..VFL.strcolor(0,1,0)..row.nature.." "..VFL.strcolor(0,0,1)..row.frost.." "..VFL.strcolor(1,1,1)..row.arcane.." "..VFL.strcolor(0.4,0.4,0.4)..row.shadow);
end

local function ResistMenuEntry(self, mnu, resist)
	table.insert(mnu, {
		text = "Sort by resist: " .. resist, func = function() VFL.poptree:Release(); Logistics.StdSortGT(self, resist); end
	});
end

function Logistics.ResistCheck_Start()
	local pw = Logistics.NewWindow(nil, "Resists", nil, 150, 50);
	pw:SetApplyData(RCWin_ApplyData);

	-- Name data map
	local nameMap, totalCount = {}, 0;
	for _,unit in RDXDAL.Group() do
		if unit:IsValid() then
			totalCount = totalCount + 1;
			nameMap[unit.name] = { 
				name = unit:GetProperName(); 
				class = unit:GetClassID();
				fire=0; frost=0; nature=0; arcane=0; shadow=0; total=0;
			};
		end
	end
	pw._nameMap = nameMap;
	pw.totalCount = totalCount;

	-- Paint entry map
	local paintMap = pw._dataList;
	VFL.empty(paintMap);
	for name,_ in pairs(nameMap) do	table.insert(paintMap, name);	end

	-- Window popup menu
	function pw:_WindowMenu(mnu)
		table.insert(mnu, {
			text = "Sort by Name", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "name"); end
		});
		table.insert(mnu, {
			text = "Sort by Class", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "class"); end
		});
		ResistMenuEntry(self, mnu, "fire");
		ResistMenuEntry(self, mnu, "nature");
		ResistMenuEntry(self, mnu, "shadow");
		ResistMenuEntry(self, mnu, "frost");
		ResistMenuEntry(self, mnu, "arcane");
		ResistMenuEntry(self, mnu, "total");
	end

	-- Destructor. On destroy, clear us from the checks table
	pw.Destroy = VFL.hook(function(s)
		s._WindowMenu = nil;
		s._nameMap = nil; s.totalCount = nil;
		rchecks[s._rpcid] = nil;
	end, pw.Destroy);

	-- Send out the RPC and bind us to the responses.
	local rpcid = RPC_Group:Invoke("logistics_res");
	pw._rpcid = rpcid;
	rchecks[rpcid] = pw;
	RPC_Group:Wait(rpcid, RC_ResponseRcvd, 10);

	Logistics.StdSort(pw, "name");
end

