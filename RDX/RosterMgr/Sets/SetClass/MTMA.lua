-- MTMA.lua
-- RDX - Raid Data Exchange
-- (C)2007 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Sets that match the WoW "Main Tank" and "Main Assist" roles.

local mt_set = RDXDAL.Set:new();
mt_set.name = "WoW MTs";
RDXDAL.RegisterSet(mt_set);

local ma_set = RDXDAL.Set:new();
ma_set.name = "WoW MAs";
RDXDAL.RegisterSet(ma_set);

local GetUnitByNumber = RDXDAL.GetUnitByNumber;

-----------------------------------------------
-- Updater
-----------------------------------------------
RDXEvents:Bind("ROSTER_UPDATE", nil, function()
	for i=1,40 do
		local unit = GetUnitByNumber(i);
		if unit:IsValid() then
			if GetPartyAssignment("MAINTANK", unit.uid) then
				mt_set:_Set(i, true); ma_set:_Set(i, false);
			elseif GetPartyAssignment("MAINASSIST", unit.uid) then
				mt_set:_Set(i, false); ma_set:_Set(i, true);
			else
				mt_set:_Set(i, false); ma_set:_Set(i, false);
			end
		else
			mt_set:_Set(i, false); ma_set:_Set(i, false);
		end
	end
end);

-----------------------------------------------
-- Setclass
-----------------------------------------------
RDXDAL.RegisterSetClass({
	name = "mtma";
	title = VFLI.i18n("WoW Main Tanks/Assists");
	GetUI = function(parent, desc)
		local ui = VFLUI.RadioGroup:new(parent);
		ui:SetLayout(2,2);
		ui.buttons[1]:SetText(VFLI.i18n("MTs")); ui.buttons[2]:SetText(VFLI.i18n("MAs"));
		if desc and desc.n then ui:SetValue(desc.n); end

		function ui:GetDescriptor() return {class="mtma", n=ui:GetValue()}; end

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil end, ui.Destroy);
		return ui;
	end;
	FindSet = function(desc)
		if not desc then return nil; end
		if desc.n == 1 then
			return mt_set;
		elseif desc.n == 2 then
			return ma_set;
		end
	end;
});

