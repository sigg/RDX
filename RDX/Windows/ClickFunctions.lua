-- ClickFunctions.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Code for each mouse binding click function.

----------------------------------------------------
-- SOME BASIC CLICK FUNCTIONS
----------------------------------------------------
--- Register a click-bindable action. The registration table must have the following
-- fields:
-- name = The internal name of the action.
-- title = The text displayed when the action appears in the UI.
-- GetUI(parent, descr) = A function to generate a hierarchical UI object for editing
--   this action.
-- GetClickFunc(descr) = A function to generate the click function for this action. The
--   click function must be of the form F(unit) where unit is an RDX unit object.
-- ApplySecureAttributes(descr, secureUnitFrame, buttonPrefix, buttonID) = Set the attributes of the given secure
--   UnitFrame appropriately. If a ClickAction does not provide this, it will be considered
--   "insecure" and will not apply to secure frames.

-- Do nothing
RDX.RegisterClickAction({
	name = "none";
	title = "Nothing";
	GetUI = VFL.Nil;
	GetClickFunc = function() return VFL.Noop; end
});

-- Target unit
local function target_rdx_unit(u) u:Target(); end
RDX.RegisterClickAction({
	name = "target"; 
	title = "Target Unit";
	GetUI = VFL.Nil;
	GetClickFunc = function() return VFL.Noop; end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "target");
	end;
});

-- Assist unit
RDX.RegisterClickAction({
	name = "assist"; 
	title = "Assist Unit";
	GetUI = VFL.Nil;
	GetClickFunc = function() return VFL.Noop; end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "assist");
	end;
});

-- Unit dropdown
local function menuFunc(frame, unit)
	local blizz_func = nil;
	local mode = "normal"
	if UnitIsUnit("pet","vehicle") then mode= "vehicle" ; end
 
	if (unit == "player" and mode=="normal") then
		blizz_func = PlayerFrameDropDown;
	elseif (unit == "player" and mode=="vehicle") then
		blizz_func = PetFrameDropDown;
	elseif unit == "vehicle" then
		blizz_func = PlayerFrameDropDown;
	elseif unit == "pet" and mode == "normal" then
		blizz_func = PetFrameDropDown;
	elseif unit == "pet" and mode == "vehicle" then
		blizz_func = PlayerFrameDropDown;
	elseif unit == "focus" then
		blizz_func = FocusFrameDropDown;
    elseif(unit == "target") then
		blizz_func = TargetFrameDropDown;
	else
		local pn = unit:match("^party(%d)$");
		if pn then
			blizz_func = _G["PartyMemberFrame" .. pn .. "DropDown"];
		else
			pn = unit:match("^raid(%d+)$");
			if pn then
				blizz_func = FriendsDropDown;
				-- Hate to pollute the frame with this BS but the menu code requires it..
				blizz_func.unit = unit;
				blizz_func.name = UnitName(unit);
				blizz_func.id = tonumber(pn);
				blizz_func.displayMode = "MENU";
				--FriendsDropDown.lineID = tonumber(pn);
				FriendsDropDown.initialize = RaidFrameDropDown_Initialize;
				--FriendsDropDown.initialize = FriendsFrameDropDown_Initialize;
			end
		end
	end

	if blizz_func then
		HideDropDownMenu(1);
		blizz_func.unit = unit;
		blizz_func.name = UnitName(unit);
		ToggleDropDownMenu(1, nil, blizz_func, "cursor");
	end
end

RDX.RegisterClickAction({
	name = "menu"; 
	title = "Open Unit Menu";
	GetUI = VFL.Nil;
	GetClickFunc = function() 
		return VFL.Noop;
	end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "unitmenu");
		uf.unitmenu = menuFunc;
	end;
});

local menuCompact = function()
	RDXPM.CompactMenu:Open();
end

RDX.RegisterClickAction({
	name = "rdxmenu"; 
	title = "Open RDX Compact Menu";
	GetUI = VFL.Nil;
	GetClickFunc = function() 
		return VFL.Noop;
	end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "unitmenu");
		uf.unitmenu = menuCompact
	end;
});

RDX.RegisterClickAction({
	name = "rdxunlock";
	title = "Toggle RDX";
	GetUI = spellGetUI;
	GetClickFunc = function(desc)
		return VFL.Noop;
	end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "macro");
		uf:SetAttribute(pfx .. "macrotext" .. id, "/rdx toggledesk");
	end;
});

-- Cast spell on target
local function buildSpellMenu()
	local ret = {};
	for spell,_ in pairs(RDXSS.GetAllSpells()) do
		table.insert(ret, { text = spell });
	end
	table.sort(ret, function(e1,e2) return e1.text<e2.text; end);
	return ret;
end

local function spellGetUI(parent, desc)
	-- Get current spell
	local csp = "(none)"; 
	if desc and desc.spell then
		if type(desc.spell) == "number" then
			csp = GetSpellInfo(desc.spell);
			if not csp then csp = "tochange"; end
		else
			csp = desc.spell;
		end
	end
	-- Build the UI
	local ui = VFLUI.CompoundFrame:new(parent);

	local spellEdit = VFLUI.LabeledEdit:new(ui, 200);
	spellEdit:SetText(VFLI.i18n("Spell Name"));
	spellEdit:Show();
	spellEdit.editBox:SetText(csp);
	ui:InsertFrame(spellEdit);

	local btn = VFLUI.Button:new(spellEdit);
	btn:SetHeight(25); btn:SetWidth(25); 
	btn:SetText("...");	btn:SetPoint("RIGHT", spellEdit.editBox, "LEFT");
	btn:Show();
	btn:SetScript("OnClick", function()
		local qq = { };
		for spell,_ in pairs(RDXSS.GetAllSpells()) do
			local retVal = spell;
			table.insert(qq, { 
				text = retVal, 
				func = function() 
					VFL.poptree:Release();
					spellEdit.editBox:SetText(retVal);
				end
			});
		end
		table.sort(qq, function(x1,x2) return tostring(x1.text) < tostring(x2.text); end);
		VFL.poptree:Begin(200, 12, btn, "CENTER");
		VFL.poptree:Expand(nil, qq, 20);
	end);
		
	ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);
	ui.GetDescriptor = function(s)
		local spelltmp = spellEdit.editBox:GetText();
		return { spell = RDXSS.GetSpellIdByLocalName(spelltmp) or spelltmp }; 
	end;

	return ui;
end

RDX.RegisterClickAction({
	name = "cast";
	title = "Cast Spell on Unit";
	GetUI = spellGetUI;
	GetClickFunc = function(desc)
		return VFL.Noop;
	end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "spell");
		local spell;
		if type(desc.spell) == "number" then
			spell = GetSpellInfo(desc.spell);
		else
			spell = desc.spell;
		end
		uf:SetAttribute(pfx .. "spell" .. id, spell);
	end;
});

RDX.RegisterClickAction({
	name = "tcast";
	title = "Target and Cast";
	GetUI = spellGetUI;
	GetClickFunc = function(desc)
		return VFL.Noop;
	end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "macro");
		local spell;
		if type(desc.spell) == "number" then
			spell = GetSpellInfo(desc.spell);
		else
			spell = desc.spell;
		end
		uf:SetAttribute(pfx .. "macrotext" .. id, "/target mouseover\n/cast " .. spell);
	end;
});

RDX.RegisterClickAction({
	name = "macro";
	title = "Execute Macro Text";
	GetUI = function(parent, desc)
		-- Build the UI
		local ui = VFLUI.CompoundFrame:new(parent);

		local scriptsel = RDXDB.ObjectFinder:new(ui, function(d,p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Macro")); end);
		scriptsel:SetLabel(VFLI.i18n("Macro")); scriptsel:Show();
		if desc and desc.script then scriptsel:SetPath(desc.script); end
		ui:InsertFrame(scriptsel);

		ui.GetDescriptor = function(s) return { script = scriptsel:GetPath(); }; end

		return ui;
	end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		local md,_,_,typename = RDXDB.GetObjectData(desc.script);
		if(not md) or (typename ~= "Macro") then return; end
		local str = md.data.script;
		uf:SetAttribute(pfx .. "type" .. id, "macro");
		uf:SetAttribute(pfx .. "macrotext" .. id, str);
	end;
});

----------------------------------------------------------------------
-- A SetFocus click action. (made by superraider)
----------------------------------------------------------------------
RDX.RegisterClickAction({
	name = "focus"; 
	title = "Set Unit Focus";
	GetUI = VFL.Nil;
	GetClickFunc = function() return VFL.Noop; end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "focus")
	end;
});

RDX.RegisterClickAction({
	name = "rfocus";
	title = "Focus (macro)";
	GetUI = VFL.Nil;
	GetClickFunc = function(desc) return VFL.Noop; end;
	ApplySecureAttributes = function(desc, uf, pfx, id)
		uf:SetAttribute(pfx .. "type" .. id, "macro");
		uf:SetAttribute(pfx .. "macrotext" .. id, "/focus");
	end;
});
