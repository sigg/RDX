-- Resurrection.lua
-- RDX - Raid Data Exchange
-- (C)2006 Raid Informatics
--
-- THIS FILE CONTAINS COPYRIGHTED CONTENT SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Rez monitoring.

----------------------------------
-- REZ MONITOR - CONSUMER SIDE
-- Intercept sent RPCs and maintain the rez sets.
----------------------------------

---------- The set definitions
local inc = RDXDAL.Set:new();
inc.name = "<Rez Incoming>";
RDXDAL.RegisterSet(inc);
local done = RDXDAL.Set:new();
done.name = "<Rez Done>";
RDXDAL.RegisterSet(done);

-- "Sweeper" code - constantly remove alive people from the rez sets.
local function Sweep()
	RDXDAL.BeginEventBatch();
	for un,_,unit in inc:Iterator() do
		if not unit:IsDead() then	inc:_Set(un, false); end
	end
	for un,_,unit in done:Iterator() do
		if not unit:IsDead() then done:_Set(un, false); end
	end
	RDXDAL.EndEventBatch();
end
VFLP.RegisterFunc("RDX", "_rezmonitor", Sweep, true);

local refcount = 0;
local function Activate()
	refcount = refcount + 1;
	if refcount == 1 then
		VFLT.AdaptiveUnschedule("_rezmonitor");
		VFLT.AdaptiveSchedule("_rezmonitor", 0.5, Sweep); 
	end
end
local function Deactivate()
	if refcount > 0 then
		refcount = refcount - 1;
		if refcount == 0 then VFLT.AdaptiveUnschedule("_rezmonitor"); end
	end
end
inc._OnActivate = Activate; inc._OnDeactivate = Deactivate;
done._OnActivate = Activate; done._OnDeactivate = Deactivate;

-- Setclass registration.
-- Uses the same IDs as Arakir's version for compatibility between the two.
RDXDAL.RegisterSetClass({
	name = "rez";
	title = VFLI.i18n("Rez Status");
	GetUI = function(parent, desc)
		local ui = VFLUI.RadioGroup:new(parent);
		ui:SetLayout(2,2);
		ui.buttons[1]:SetText(VFLI.i18n("Incoming")); ui.buttons[2]:SetText(VFLI.i18n("Done"));
		if desc and desc.n then ui:SetValue(desc.n); end

		function ui:GetDescriptor() return {class="rez", n=ui:GetValue()}; end

		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil end, ui.Destroy);
		return ui;
	end;
	FindSet = function(desc)
		if not desc then return nil; end
		if desc.n == 1 then
			return inc;
		elseif desc.n == 2 then
			return done;
		else
			return nil;
		end
	end
});

----------- RPC bindings
RPC_Group:Bind("rez_start", function(ci, targ)
	local u = RPC.GetSenderUnit(ci); if not u then return; end
	targ = RDXDAL.GetUnitByNameIfInGroup(targ); if not targ then return; end
	-- If the rez target is dead, or he already has a pending rez, abort.
	if (not targ:IsDead()) or (done:IsMember(targ)) then return; end
	local n = inc:IsMember(targ);
	if n then
		-- There were already incoming rezzes on this guy, increment count.
		inc:_Poke(targ.nid, n+1);
	else
		-- Start us off at 1 incoming rez.
		inc:_Set(targ.nid, 1);
	end
end);

RPC_Group:Bind("rez_done", function(ci, targ)
	local u = RPC.GetSenderUnit(ci); if not u then return; end
	targ = RDXDAL.GetUnitByNameIfInGroup(targ); if not targ then return; end
	-- If the target isn't done or already has an inc rez, abort.
	if (not targ:IsDead()) then return; end
	-- Update the sets.
	done:_Set(targ.nid, true); inc:_Set(targ.nid, false);
end);

RPC_Group:Bind("rez_fail", function(ci, targ)
	local u = RPC.GetSenderUnit(ci); if not u then return; end
	targ = RDXDAL.GetUnitByNameIfInGroup(targ); if not targ then return; end
	-- If the target isn't done or already has an inc rez, abort.
	if (not targ:IsDead()) or (done:IsMember(targ)) then return; end
	local n = inc:IsMember(targ);
	if n and n > 0 then
		-- Decrement the number of incoming rezzes.
		n = n - 1;
		-- If the last of the incoming rezzes failed, remove from the incoming set.
		-- Otherwise update the count.
		if n == 0 then 
			inc:_Set(targ.nid, false); 
		else
			inc:_Poke(targ.nid, n);
		end
	end
end);

RPC_Group:Bind("rez_ss", function(ci)
	local u = RPC.GetSenderUnit(ci); if not u then return; end
	-- We have a soulstone ready for use.
	-- Remove us from inc rezzes, just in case we were there
	inc:_Set(u.nid, false);
	-- Add us to completed rezzes
	done:_Set(u.nid, true);
end);

----------------------------------
-- REZ MONITOR - CASTER SIDE
-- Watch spellcasts and RPC when rezzes happen.
----------------------------------
local _,ret = UnitClass("player");
local pclass = ret or "NONE";
local rezSpell = nil;
if pclass == "PRIEST" then
	rezSpell = GetSpellInfo(2006); --VFLI.i18n("Resurrection");
elseif pclass == "PALADIN" then
	rezSpell = GetSpellInfo(7328); --VFLI.i18n("Redemption");
elseif pclass == "SHAMAN" then
	rezSpell = GetSpellInfo(2008); --VFLI.i18n("Ancestral Spirit");
elseif pclass == "DRUID" then
	rezSpell = GetSpellInfo(50769); --VFLI.i18n("Rebirth");
end

if rezSpell then
	local rezTarget = nil;
	-- Detect when a rez is first cast.
	WoWEvents:Bind("UNIT_SPELLCAST_SENT", nil, function(arg1, arg2, arg3, arg4)
		if (arg1 ~= "player") or (arg2 ~= rezSpell) then return; end
		local target = RDXDAL.GetUnitByNameIfInGroup(string.lower(arg4));
		if target then
			rezTarget = target;
			RPC_Group:Invoke("rez_start", target.name);
		end
	end);

	-- Detect when a rez is finished.
	WoWEvents:Bind("UNIT_SPELLCAST_SUCCEEDED", nil, function()
		if not rezTarget then return; end
		RPC_Group:Invoke("rez_done", rezTarget.name);
		rezTarget = nil;
	end);

	-- Detect rez failure
	local function fail()
		if not rezTarget then return; end
		RPC_Group:Invoke("rez_fail", rezTarget.name);
		rezTarget = nil;
	end
	WoWEvents:Bind("UNIT_SPELLCAST_FAILED", nil, fail);
	WoWEvents:Bind("UNIT_SPELLCAST_INTERRUPTED", nil, fail);
end

-- Watch for my death. If I have a soulstone up, then broadcast me as "recoverable."
WoWEvents:Bind("PLAYER_DEAD", nil, function()
	if HasSoulstone() then
		-- Wait 1 sec for lag, if the other end doesn't think we're dead this won't work.
		VFLT.schedule(1.5, RPC_Group.Invoke, RPC_Group, "rez_ss");
	end
end);

----------------------------
-- PUBLIC API
----------------------------
--- Determine if the current player can rez.
function RDXDAL.PlayerCanRez()
	return rezSpell;
end
