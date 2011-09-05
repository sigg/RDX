-- CombatLogs.lua
-- OpenRDX
-- Sigg Rashgarroth EU

local min,max = math.min, math.max;

local _cltype = {
	{ text = "Time" },
	{ text = "Source" },
	{ text = "Target" },
	{ text = "HP" },
	{ text = "Amt" },
	{ text = "Ability" },
	{ text = "Misc" },
};
local function cltypeFunc() return _cltype; end

local olw = nil;
local olw_lines, olw_width = 20, 346;
local olw_bkd = { r=0,g=0,b=0,a=0.1 };
local zeropad = VFL.zeropad;

-- colspec
-- Time, Source, Target, HP, Amt, Ability, Misc
function __LastNLiterator(array, n)
	local function sz()
		return min(#array, n);
	end
	local function get(i)
		local z = #array;
		if(z < n) then
			return array[i];
		else
			return array[z - n + i];
		end
	end
	return sz, get;
end

------------------ Paint function
function __LWApplyData(tbl, cell, data, pos)
	local cols = cell.col;
	local rowType = data.y;
	local str = nil;
	local stWhole, stFrac;
	
	for i = 1, table.getn(cols) do
		if cols[i]._type == "Time" then
			if data.tm then
				--str = date("%H:%M:%S", data.tm);
				stWhole, stFrac = VFL.modf( (tbl.timeOffset + data.tm) / 10);
				str = date("%H:%M:%S", stWhole);
				--str = str .. string.format(".%1d", stFrac*10);
				cols[i]:SetText("|cFFAAAAAA" .. str .. "|r");
			end
		elseif cols[i]._type == "Source" then
			cols[i]:SetText(data.s or "");
		elseif cols[i]._type == "Target" then
			cols[i]:SetText(data.t or "");
		elseif cols[i]._type == "HP" then
			if data.uh then
				local pct = VFL.clamp(data.uh / data.uhm, 0, 1);
				tempcolor:blend(_red, _green, pct);
				cols[i]:SetText(zeropad(data.uh, 5, "|cFF333333", "|r" .. tempcolor:GetFormatString()) .. "|r"); --/" .. zeropad(data.uhm, 5, "|cFF333333", "|r"));
			else
				cols[i]:SetText("");
			end
		elseif cols[i]._type == "Amt" then
			if data.x then
				str = VFL.strtcolor(RDXMD.GetEventTypeColor(rowType)) .. tostring(data.x);
				if Omni.IsCritRow(data) then
					--cols[i]:SetFont(Fonts.Default.face, 12);
					str = str .. "!";
				else
					--cols[i]:SetFont(Fonts.Default.face, 10);
				end
				cols[i]:SetText(str .. "|r");
			else
				cols[i]:SetText("");
			end
		elseif cols[i]._type == "Ability" then
			cols[i]:SetText(Omni.GetAbilityString(data, rowType));
		elseif cols[i]._type == "Misc" then
			local str2 = RDXMD.GetExtdType(data.e);
			if str2 then
				str = "|cFF00FFFF[|r" .. str2 .. "|cFF00FFFF]|r " .. Omni.GetMiscString(data);
			else
				str = Omni.GetMiscString(data);
			end
			cols[i]:SetText(str);
		end
	end
end
----------------------------------------
local wl = {};

local function BuildTabLogList()
	VFL.empty(wl);
	local desc = nil;
	for pkg,data in pairs(RDXData) do
		for file,md in pairs(data) do
			if (type(md) == "table") and md.data and md.ty and string.find(md.ty, "TableLog") then
				table.insert(wl, {text = RDXDB.MakePath(pkg, file)});
			end
		end
	end
	table.sort(wl, function(x1,x2) return x1.text<x2.text; end);
end

local function _fnListTabLog() BuildTabLogList(); return wl; end

-----------------------------------------
RDX.RegisterFeature({
	name = "combatlogs";
	multiple = true;
	version = 1;
	title = VFLI.i18n("RDX Combat Logs");
	category = VFLI.i18n("Complexes");
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("Base") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not RDXUI.DescriptorCheck(desc, state, errs) then return nil; end
		if desc.owner == "Base" then desc.owner = "decor"; end
		local flg = true;
		if not RDXDB.CheckObject(desc.tablelog, "TableLog") then VFL.AddError(errs, VFLI.i18n("Invalid tablelog")); flg = nil; end
		flg = flg and RDXUI.UFFrameCheck_Proto("Frame_", desc, state, errs);
		flg = flg and RDXUI.UFAnchorCheck(desc.anchor, state, errs);
		flg = flg and RDXUI.UFOwnerCheck(desc.owner, state, errs);
		if flg then state:AddSlot("Frame_" .. desc.name); end
		return flg;
	end;
	ApplyFeature = function(desc, state)
		local objname = "Frame_" .. desc.name;
		
		if not desc.spec then desc.spec = [[
{ title = "Time", width = 100, font = Fonts.Default },
{ title = "HP", width = 75, font = Fonts.Default },
{ title = "Amt", width = 40, font = Fonts.Default },
{ title = "Misc", width = 160, font = Fonts.Default },
]]; end
		
		------------------ On frame creation
		local createCode = [[
local colspec = {]] .. desc.spec .. [[};

local btn = VFLUI.List:new(nil, 10, function(x) return Omni._CreateCell(x, "Frame"); end);
VFLUI.StdSetParent(btn, ]] .. RDXUI.ResolveFrameReference(desc.owner) .. [[);
btn:SetPoint(]] .. RDXUI.AnchorCodeFromDescriptor(desc.anchor) .. [[);
btn:SetWidth(]] .. desc.w .. [[); btn:SetHeight((]] .. desc.line .. [[ * 10) + 2);
btn:Show();
btn:SetScrollBarEnabled(true);
btn.path = "]] .. desc.tablelog .. [[";
OmniEvents:Bind("TABLE_DATA_CHANGED", nil, function(tbl) if tbl.path == "]] .. desc.tablelog .. [[" then btn:Update(); end; end, "]] .. objname .. [[");
btn:Rebuild();
btn.tablelog = RDXDB.GetObjectInstance("]] .. desc.tablelog .. [[");

btn:SetDataSource(function(cell, data, pos, absPos) __LWApplyData(btn.tablelog, cell, data, pos); end, __LastNLiterator(btn.tablelog.data, ]] .. desc.line .. [[));
Omni._ApplyColSpecToList(btn, colspec);

btn:Update();
local cc = VFLUI.AcquireFrame("Button");
VFLUI.StdSetParent(cc, btn);
cc:SetAllPoints(btn);
cc:SetScript("OnClick", function() Omni.Open(); Omni.SetActiveTable(btn.tablelog); end);
cc:RegisterForClicks("AnyUp");
cc:Show();
btn.highbtn = cc;
frame.]] .. objname .. [[ = btn;
]];
		state:Attach(state:Slot("EmitCreate"), true, function(code) code:AppendCode(createCode); end);

		------------------ On frame destruction.
		local destroyCode = [[
OmniEvents:Unbind("]] .. objname .. [[");
local btn = frame.]] .. objname .. [[;
if btn then
	btn.highbtn:Destroy(); btn.highbtn = nil;
	btn.path = nil;
	btn.tablelog = nil;
	btn:Destroy(); btn = nil;
end
frame.]] .. objname .. [[ = nil;
]];
		state:Attach(state:Slot("EmitDestroy"), true, function(code) code:AppendCode(destroyCode); end);

		return true;
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		-- Name/width/height
		local ed_name, ed_width, ed_height = RDXUI.GenNameWidthHeightPortion(ui, desc, state);

		-- Owner
		local owner = RDXUI.MakeSlotSelectorDropdown(ui, VFLI.i18n("Owner"), state, "Subframe_");
		if desc and desc.owner then owner:SetSelection(desc.owner); end

		-- Anchor
		local anchor = RDXUI.UnitFrameAnchorSelector:new(ui); anchor:Show();
		anchor:SetAFArray(RDXUI.ComposeAnchorList(state));
		if desc and desc.anchor then anchor:SetAnchorInfo(desc.anchor); end
		ui:InsertFrame(anchor);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Table Log"));
		local dd_tablogId = VFLUI.Dropdown:new(er, _fnListTabLog, nil, nil, nil, 30);
		dd_tablogId:SetWidth(250); dd_tablogId:Show();
		if desc and desc.tablelog then 
			dd_tablogId:SetSelection(desc.tablelog); 
		end
		er:EmbedChild(dd_tablogId); er:Show();
		ui:InsertFrame(er);
		
		local ed_line = VFLUI.LabeledEdit:new(ui, 50); ed_line:Show();
		ed_line:SetText(VFLI.i18n("Lines"));
		if desc and desc.line then ed_line.editBox:SetText(desc.line); end
		ui:InsertFrame(ed_line);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Column type"));
		local dd_cltype = VFLUI.Dropdown:new(er, cltypeFunc);
		dd_cltype:SetWidth(200); dd_cltype:Show();
		--if desc and desc.orientation then 
		--	dd_cltype:SetSelection(desc.orientation); 
		--else
			dd_cltype:SetSelection("Time");
		--end
		er:EmbedChild(dd_cltype); er:Show();
		ui:InsertFrame(er);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Column Font"));
		local dd_clfont = VFLUI.Dropdown:new(er, VFLUI._GetFontIndex);
		dd_clfont:SetWidth(200); dd_clfont:Show();
		--if desc and desc.orientation then 
		--	dd_cltype:SetSelection(desc.orientation); 
		--else
			dd_clfont:SetSelection("Fonts.Default");
		--end
		er:EmbedChild(dd_clfont); er:Show();
		ui:InsertFrame(er);
		
		local leb_spec = VFLUI.TextEditor:new(ui, "LuaEditBox");
		leb_spec:SetHeight(200); leb_spec:Show();
		leb_spec:SetText(desc.spec or "");
		leb_spec:GetEditWidget():SetFocus();
		ui:InsertFrame(leb_spec);
		
		function ui:GetDescriptor()
			return { 
				feature = "combatlogs"; version = 1;
				name = ed_name.editBox:GetText();
				owner = owner:GetSelection();
				w = ed_width:GetSelection();
				h = ed_height:GetSelection();
				anchor = anchor:GetAnchorInfo();
				tablelog = dd_tablogId:GetSelection();
				line = VFL.clamp(ed_line.editBox:GetNumber(), 1, 100);
				spec = leb_spec:GetText();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { 
			feature = "combatlogs"; version = 1; 
			name = "combatlogs", owner = "decor";
			w = 140; h = 20;
			anchor = { lp = "TOPLEFT", af = "Base", rp = "TOPLEFT", dx = 0, dy = 0};
			tablelog = "default:Logs_Me_tl"; line = 10; 
			spec = [[
{ title = "Time", width = 100, font = Fonts.Default },
{ title = "HP", width = 75, font = Fonts.Default },
{ title = "Amt", width = 40, font = Fonts.Default },
{ title = "Misc", width = 160, font = Fonts.Default },
]];
		};
	end;
});


