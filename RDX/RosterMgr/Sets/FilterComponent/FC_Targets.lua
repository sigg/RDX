-- target
-- OpenRDX
-- (C)2007 Sigg / Rashgarroth eu

local sig_unit_hottarget = RDXEvents:LockSignal("UNIT_HOTTARGET");

-- uids target
-- proto_uids unit
local uids, proto_uids = {}, {};

RDXDAL.Unit.TargetgetIndex = VFL.Zero;
RDXDAL.Unit.TargetgetName = VFL.Zero;
RDXDAL.Unit.TargetgetGuid = VFL.Zero;
RDXDAL.Unit.TargetSetIndex = VFL.Zero;
RDXDAL.Unit.TargetSetName = VFL.Zero;
RDXDAL.Unit.TargetSetGuid = VFL.Zero;

RDXEvents:Bind("NDATA_CREATED", nil, function(ndata, name)
	if name == "" then return; end
	local t = {};
	t.index = 100; 
	t.name = "";
	t.guid = 0;
	
	ndata.TargetgetIndex = function()
		return t.index;
	end;
	ndata.TargetgetName = function()
		return t.name;
	end
	ndata.TargetgetGuid = function()
		return t.guid;
	end
	
	ndata.TargetSetIndex = function(index)
		if index then
			t.index = index;
		else
			t.index = 10;
		end
	end;
	ndata.TargetSetName = function(name)
		t.name = name;
	end
	ndata.TargetSetGuid = function(guid)
		t.guid = guid;
	end
	
	ndata:SetNField("targetEngine", t);
end);


local function gettarget(puid)
	if not UnitExists(puid .. "target") then return nil; end
	local ii = 0;
	if UnitIsEnemy(puid, puid .. "target") then ii = 1;
	--elseif UnitIsFriend(puid .. "target") then ii = 2;
	else ii = 2;
	end
	return puid, puid .. "target", ii;
end

local proto_uid, tuid, ix, flag, name, ii;
local function targetparse()
	VFL.empty(uids); 
	proto_uid, tuid, ix, flag, name, ii = nil, nil, 0, nil, nil, 0;
	for _,unit in RDXDAL.Group() do
		proto_uid = unit.uid;
		proto_uid, tuid, ii = gettarget(proto_uid);
		if proto_uid then
			flag = true;
			for j=1,ix do
				if UnitIsUnit(tuid, uids[j]) then flag = false;
				break; end
			end
			-- If all tests passed, add it
			if flag then
				ix = ix + 1;
				unit.TargetSetIndex(ii);
				name = UnitName(tuid);
				unit.TargetSetName(name);
				uids[ix] = tuid;
				sig_unit_hottarget:Raise(unit, unit.nid, unit.uid);
			else
				unit.TargetSetIndex(4);
				name = UnitName(tuid);
				unit.TargetSetName(name);
			end
		else
			unit.TargetSetIndex(5);
			unit.TargetSetName("");
			sig_unit_hottarget:Raise(unit, unit.nid, unit.uid);
		end
	end
end

------------------------------------------------
-- INIT
------------------------------------------------
local function _Checkraid()
	if RDXDAL.GetNumUnits() == 1 then
		--VFL.print("stop");
		VFLT.AdaptiveUnschedule("target_update");
	else
		--VFL.print("launch");
		VFLT.AdaptiveUnschedule("target_update");
		VFLT.AdaptiveSchedule("target_update", 0.2, targetparse);
	end
end

RDXEvents:Bind("PARTY_IS_RAID", nil, _Checkraid);
RDXEvents:Bind("PARTY_IS_NONRAID", nil, _Checkraid);
VFLEvents:Bind("PLAYER_IN_BATTLEGROUND", nil, _Checkraid);

----------------------------------------------------------
-- TARGET FILTER
----------------------------------------------------------
RDXDAL.RegisterFilterComponent({
	name = "hot_target", title = VFLI.i18n("High Order Target..."), category = VFLI.i18n("Unit Status"),
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.FilterDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("High Order Target...")); ui:Show();
		local container = VFLUI.CompoundFrame:new(ui);
		ui:SetChild(container); container:Show();

		local perc_numer = VFLUI.RadioGroup:new(container);
		container:InsertFrame(perc_numer);
		perc_numer:SetLayout(1, 1);
		perc_numer.buttons[1]:SetText(VFLI.i18n("Index"));
		perc_numer:SetValue(desc[2]);
		perc_numer:Show();

		local lb = VFLUI.LabeledEdit:new(container, 50);
		container:InsertFrame(lb);
		lb:SetText(VFLI.i18n("Lower bound")); lb.editBox:SetText(desc[3]);
		lb:Show();
		local ub = VFLUI.LabeledEdit:new(container, 50);
		container:InsertFrame(ub);
		ub:SetText(VFLI.i18n("Upper bound")); ub.editBox:SetText(desc[4]);
		ub:Show();

		ui.GetDescriptor = function(x)
			local lwr = lb.editBox:GetNumber(); if (not lwr) or (lwr < 0) then lwr = 0; end
			local upr = ub.editBox:GetNumber(); if (not upr) or (upr < 0) then upr = 1; end
			if(upr < lwr) then local temp = upr; upr = lwr; lwr = temp; end
			return {"hot_target", perc_numer:GetValue(), lwr, upr};
		end

		return ui;
	end,
	GetBlankDescriptor = function() return {"hot_target", 1, 1, 1}; end,
	FilterFromDescriptor = function(desc, metadata)
		local lb, ub, vexpr = desc[3], desc[4];
		-- Figure out which stat we want to use
		if desc[2] == 1 then -- damage done
			vexpr = "(unit:TargetgetIndex())";
		end
		-- Generate the closures/locals
		local vC = RDXDAL.GenerateFilterUpvalue();
		table.insert(metadata, { class = "LOCAL", name = vC, value = vexpr });
		-- Generate the filtration expression.
		return "((" .. vC .. " >= " .. lb ..") and (" .. vC .. " <= " .. ub .."))";
	end;
	ValidateDescriptor = VFL.True;
	SetsFromDescriptor = VFL.Noop;
	EventsFromDescriptor = function(desc, metadata)
		RDXDAL.FilterEvents_FullUpdate(metadata, "UNIT_HOTTARGET");
	end;
});

------------------
-- RANGE TARGET
------------------
--[[
local sig_unit_rangetarget = RDXEvents:LockSignal("UNIT_RANGETARGET");

local ingroupflag, hostileflag;

local function changetarget()
	ingroupflag = nil; hostileflag = nil;
	for _,unit in RDXDAL.Group() do
		if UnitIsUnit(unit.uid, "target") then ingroupflag = true; break; end
	end
	if not ingroupflag and UnitCanAttack("player", "target") then hostileflag = true; end
end

local function parsetarget()
	-- 10
	CheckInteractDistance(uid, 3);
	-- 30
	CheckInteractDistance(uid, 4);
	
	-- 40
	if unitingroup then
		UnitInRange(uid);
	if hostile
		Spell 40
	else
		Spell 40
	end
	
	-- 100
	if UnitIsVisible
	
	sig_unit_hottarget:Raise(unit, unit.nid, unit.uid);

end

RDXDAL.Unit.GetRangeValue = VFL.Zero;

RDXEvents:Bind("NDATA_CREATED", nil, function(ndata, name)
	if name == "" then return; end
	local t = {};
	t.index = 100; 
	t.name = "";
	t.guid = 0;
	
	ndata.TargetgetIndex = function()
		return t.index;
	end;
	ndata.TargetgetName = function()
		return t.name;
	end
	ndata.TargetgetGuid = function()
		return t.guid;
	end
	
	ndata.TargetSetIndex = function(index)
		if index then
			t.index = index;
		else
			t.index = 10;
		end
	end;
	ndata.TargetSetName = function(name)
		t.name = name;
	end
	ndata.TargetSetGuid = function(guid)
		t.guid = guid;
	end
	
	ndata:SetNField("targetEngine", t);
end);

]]
