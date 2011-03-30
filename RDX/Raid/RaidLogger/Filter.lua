-- Filter.lua
-- RDX6 - Project Omniscience
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Code for filtration of Omniscience logs.

local strfind, strlower = string.find, string.lower;
local band = bit.band;

-------------------------------------------------
-- The filter editor dialog
-------------------------------------------------
Omni.FilterEditor = {};
function Omni.FilterEditor:new(parent, callback)
	local dlg = VFLUI.AcquireFrame("Frame");
	if parent then
		dlg:SetParent(parent); 
		dlg:SetFrameStrata(parent:GetFrameStrata());
		dlg:SetFrameLevel(parent:GetFrameLevel() + 3);
	end
	dlg:SetWidth(346); dlg:SetHeight(340); 
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:Show();

	-- Scrollframe
	local sf = VFLUI.VScrollFrame:new(dlg);
	sf:SetWidth(320); sf:SetHeight(330);
	sf:SetPoint("TOPLEFT", dlg, "TOPLEFT", 5, -5);
	sf:Show();

	-- Root
	local ui = VFLUI.CompoundFrame:new(sf); ui.isLayoutRoot = true;

	-- Event types
	local ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText("Event Types");
	ui:InsertFrame(ctr);
	local ctd = VFLUI.CheckGroup:new(ctr); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	local eventMap = RDXMD.idToEvent;
	ctd:SetLayout(#eventMap, 2);
	for i=1,#eventMap do 
		ctd.checkBox[i]:SetText(VFL.strtcolor(RDXMD.GetEventTypeColor(i)) .. RDXMD.GetEventType(i) .. "|r");
	end
	local etypes_container, etypes_checks = ctr,ctd;

	-- Damage types
	ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText("Damage Types");
	ui:InsertFrame(ctr);
	ctd = VFLUI.CheckGroup:new(ctr); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	local damageMap = RDXMD.idToDmg;
	ctd:SetLayout(VFL.tsize(damageMap), 3);
	local j = 1;
	for k,v in pairs(damageMap) do
		ctd.checkBox[j]:SetText(VFL.strtcolor(RDXMD.GetDamageTypeColor(k)) .. v .. "|r");
		j = j + 1;
	end
	local dtypes_container, dtypes_checks = ctr, ctd;

	-- Modifiers
	ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText("Modifiers");
	ui:InsertFrame(ctr);
	ctd = VFLUI.CheckGroup:new(ctr); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	local modifierMap = RDXMD.idToExtd;
	ctd:SetLayout(#modifierMap, 3);
	for i=1,#modifierMap do 
		ctd.checkBox[i]:SetText(RDXMD.GetExtdType(i));
	end
	local mtypes_container, mtypes_checks = ctr, ctd;

	-- Source Filter
	ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText("Source");
	ui:InsertFrame(ctr);
	ctd = VFLUI.LabeledEdit:new(ctr, 200); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	ctd:SetText("* is a wildcard, player, pet, Sigg, playerName");
	local src_container, src_edit = ctr,ctd;

	-- Target Filter
	ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText("Target");
	ui:InsertFrame(ctr);
	ctd = VFLUI.LabeledEdit:new(ctr, 200); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	ctd:SetText("* is a wildcard, player, pet, Sigg, playerName");
	local targ_container, targ_edit = ctr,ctd;	

	-- Ability Filter
	ctr = VFLUI.CollapsibleFrame:new(ui); ctr:Show();
	ctr:SetText("Ability");
	ui:InsertFrame(ctr);
	ctd = VFLUI.LabeledEdit:new(ctr, 250); ctd:Show();
	ctr:SetChild(ctd); ctr:SetCollapsed(true);
	ctd:SetText("* is a wildcard");
	local abil_container, abil_edit = ctr,ctd;	

	--- Layout Engine Bootstrap
	sf:SetScrollChild(ui);
	ui:SetWidth(sf:GetWidth());
	ui:DialogOnLayout(); ui:Show();

	function dlg:GetDescriptor()
		local desc = {};
		if not etypes_container:IsCollapsed() then
			local found = nil;
			desc.etypes = {};
			for i=1,#RDXMD.idToEvent do 
				if etypes_checks.checkBox[i]:GetChecked() then desc.etypes[i] = true; found = true; end
			end
			if not found then desc.etypes = nil; end
		else
			desc.etypes = nil;
		end

		if not dtypes_container:IsCollapsed() then
			local found = nil;
			desc.dtypes = 0;
			local j = 1;
			for k,v in pairs(RDXMD.idToDmg) do
				if dtypes_checks.checkBox[j]:GetChecked() then desc.dtypes = bit.bor(desc.dtypes, k); found = true; end
				j = j + 1;
			end
			if not found then desc.dtypes = nil; end
		else
			desc.dtypes = nil;
		end

		if not mtypes_container:IsCollapsed() then
			local found = nil;
			desc.mtypes = {};
			for i=1,#RDXMD.idToExtd do 
				if mtypes_checks.checkBox[i]:GetChecked() then desc.mtypes[i] = true; found = true; end
			end
			if not found then desc.mtypes = nil; end
		else
			desc.mtypes = nil;
		end

		if not src_container:IsCollapsed() then desc.src = src_edit.editBox:GetText(); else desc.src = nil; end
		if desc.src == "" then desc.src = nil; end
		if not targ_container:IsCollapsed() then desc.targ = targ_edit.editBox:GetText(); else desc.targ = nil; end
		if desc.targ == "" then desc.targ = nil; end
		if not abil_container:IsCollapsed() then desc.abil = abil_edit.editBox:GetText(); else desc.abil = nil; end
		if desc.abil == "" then desc.abil = nil; end

		return desc;
	end
	
	function dlg:SetDescriptor(desc)
		if not desc then return; end
		if desc.etypes then
			etypes_container:ToggleCollapsed();
			for i=1,#RDXMD.idToEvent do
				if desc.etypes[i] then etypes_checks.checkBox[i]:SetChecked(true); end
			end
		end
		
		if desc.dtypes then
			if type(desc.dtypes) == "table" then desc.dtypes = 0; end
			dtypes_container:ToggleCollapsed();
			local j = 1;
			for k,v in pairs(RDXMD.idToDmg) do
				if bit.band(desc.dtypes, k) ~= 0 then dtypes_checks.checkBox[j]:SetChecked(true); end
				j = j + 1;
			end
		end

		if desc.mtypes then
			mtypes_container:ToggleCollapsed();
			for i=1,#RDXMD.idToExtd do
				if desc.mtypes[i] then mtypes_checks.checkBox[i]:SetChecked(true); end
			end
		end

		if desc.src then
			src_container:ToggleCollapsed();
			src_edit.editBox:SetText(desc.src);
		end
		
		if desc.targ then
			targ_container:ToggleCollapsed();
			targ_edit.editBox:SetText(desc.targ);
		end
		
		if desc.abil then
			abil_container:ToggleCollapsed();
			abil_edit.editBox:SetText(desc.abil);
		end
	end

	dlg.Destroy = VFL.hook(function(s)
		s.GetDescriptor = nil;
		s.SetDescriptor = nil;
		sf:SetScrollChild(nil);
		ui:Destroy(); ui = nil; sf:Destroy(); sf = nil;
	end, dlg.Destroy);

	return dlg;
end

-- Given a descriptor, return a function that accepts a (table, row) pair and returns TRUE iff the row
-- matches the filter
function Omni.FilterFunctor(desc, unitname)
	if type(desc) ~= "table" then return VFL.True; end
	-- Load defaults
	local etypes, dtypes, mtypes = {}, nil, {};
	for i=1,#RDXMD.idToEvent do etypes[i] = true; end
	--for k,_ in pairs(RDXMD.idToDmg) do
	--	dtypes[k] = true;
	--end
	for i=1,#RDXMD.idToExtd do mtypes[i] = true; end
	local mtype = true;
	local re_src, re_targ, re_abil = nil, nil, nil;

	-- Deviate from defaults as needed
	if desc.etypes then for i=1,#RDXMD.idToEvent do etypes[i] = desc.etypes[i]; end end
	if type(desc.dtypes) == "table" then desc.dtypes = 0; end
	dtypes = desc.dtypes;
	if desc.mtypes then for i=1,#RDXMD.idToExtd do mtypes[i] = desc.mtypes[i]; end else mtype = nil; end
	
	if unitname then
		re_src = unitname;
	elseif desc.src then
		local name = strlower(desc.src);
		if name == "player" or name == "pet" then
			name = UnitName(name); 
		end
		re_src = VFL.WildcardToRegex(strlower(name));
	end
	
	if unitname then
		re_targ = unitname;
	elseif desc.targ then
		local name = strlower(desc.targ);
		if name == "player" or name == "pet" then
			name = UnitName(name); 
		end
		re_targ = VFL.WildcardToRegex(strlower(name));
	end
	if desc.abil then re_abil = VFL.WildcardToRegex(strlower(desc.abil)); end

	return function(tbl, row)
		if not etypes[row.y] then return nil; end
		if dtypes and row.d and band(dtypes,row.d) == 0 then return nil; end
		-- Modifier type
		if mtype then
			local modFlag = nil;
			if (mtypes[3] and row.xia) or (mtypes[2] and row.xib) or (mtypes[1] and row.xir) or (mtypes[4] and row.xic) then modFlag = true; end
			if not modFlag then return nil; end
		end
		if re_src or re_targ then
			local modFlag = nil;
			if (re_src and (strfind(strlower(row.s or ""), re_src))) or (re_targ and (strfind(strlower(row.t or ""), re_targ))) then modFlag = true; end
			if not modFlag then return nil; end
		end
		if re_abil and (not strfind(strlower(row.a or ""), re_abil)) then return nil; end
		return true;
	end
end

