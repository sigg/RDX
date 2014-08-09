-- Durability.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Durability checking.

function Logistics.GetDurability()
	local currDur, maxDur, brokenItems = 0, 0, 0;
	local itemIds = { 1, 2, 3, 5, 6, 7, 8, 9, 10, 16, 17, 18 };
	for k, v in ipairs(itemIds) do
		VFLTip:ClearLines();
		VFLTip:SetInventoryItem("player", v);
		for i = 1, VFLTip:NumLines(), 1 do
			local _, _, sMin, sMax = string.find(_G["VFLTipTextLeft" .. i]:GetText() or "", VFLI.i18n("^Durability (%d+) / (%d+)$"));
			if (sMin and sMax) then
				local iMin, iMax = tonumber(sMin), tonumber(sMax);
				if (iMin == 0) then	brokenItems = brokenItems + 1; end
				currDur = currDur + iMin;
				maxDur = maxDur + iMax;
				break;
			end
		end
	end
	return currDur, maxDur, brokenItems;
end

----------------------------------------------
-- RESPONDER
----------------------------------------------
local function DCIncRPC(ci)
	-- Sanity check sender
	if (not ci) then return; end
	local sunit = RPC.GetSenderUnit(ci); if not sunit then return; end
	local id = ci.id; if not id then return; end
	return Logistics.GetDurability();
end

RPC_Group:Bind("logistics_dura", DCIncRPC);

----------------------------------------------
-- DISPLAY
----------------------------------------------
local dchecks = {};

local function DC_ResponseRcvd(ci, cur, tot, brk)
	-- Sanity check all incoming parameters; make sure everything exists that should exist
	if (not ci) or (not ci.sender) or (not ci.id) then return; end
	cur = tonumber(cur); tot = tonumber(tot); brk = tonumber(brk);
	if (not cur) or (not tot) or (not brk) then return; end
	if(tot < 0.1) then tot = 1; end

	local win = dchecks[ci.id]; if not win then return; end
	local su = RPC.GetSenderUnit(ci); if not su then return; end
	local nm = win._nameMap; if (not nm) or (not nm[ci.sender]) then return; end

	-- Update the response.
	nm[ci.sender].resp = true;
	nm[ci.sender].pct = VFL.clamp(cur/tot, 0, 1);
	nm[ci.sender].brk = brk;

	-- Repaint the window
	if win.sortField == "pct" then
		Logistics.StdSort(win, "pct");
	else
		win:RepaintAll();
	end
end

local function DCWin_ApplyData(win, frame, icv, data)
	local nm = win._nameMap; if not nm then return; end
	local row = nm[data]; if not row then return; end
	frame.text1:SetText(VFL.strtcolor(RDXMD.GetClassColor(row.class)) .. row.name .. "|r");
	if (not row.resp) then -- no resp
		frame.bar:SetValue(0);
		frame.text2:SetText("|cFF444444(No resp)|r");
		return; 
	end
	local pct = tonumber(row.pct);
	RDX.SetStatusBar(frame.bar, pct, _green, _red);
	local str = string.format("%0.0f%%", pct*100) .. " (";
	if row.brk > 0 then
		frame.text2:SetText(str .. "|cFFFF0000" .. row.brk .. "|r)");
	else
		frame.text2:SetText(str .. "0)");
	end
end

function Logistics.DuraCheck_Start()
	local pw = Logistics.NewWindow(nil, "Durability", nil, 110, 70);
	pw:SetApplyData(DCWin_ApplyData);
	pw:SetupNameMap(function(x,t) t.pct = 1.1; end);

	-- Window popup menu
	function pw:_WindowMenu(mnu)
		table.insert(mnu, {
			text = "Sort by Name", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "name"); end
		});
		table.insert(mnu, {
			text = "Sort by Class", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "class"); end
		});
		table.insert(mnu, {
			text = "Sort by Durability", func = function() VFL.poptree:Release(); Logistics.StdSort(self, "pct"); end
		});
	end

	-- Destructor. On destroy, clear us from the checks table
	pw.Destroy = VFL.hook(function(s)
		dchecks[s._rpcid] = nil;
	end, pw.Destroy);

	-- Send out the RPC and bind us to the responses.
	local rpcid = RPC_Group:Invoke("logistics_dura");
	pw._rpcid = rpcid;
	dchecks[rpcid] = pw;
	RPC_Group:Wait(rpcid, DC_ResponseRcvd, 10);

	Logistics.StdSort(pw, "pct");
end

