-- Obj_Status.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- The basic status objects.
RDXRS = RegisterVFLModule({
	name = "RaidStatus";
	title = "Raid Status";
	parent = RDX;
	version = {1,0,0};
});

--- Parameters
local statUpdatePeriod = .25;

-----------------------------------------------
-- Registries
-----------------------------------------------
local sq = {};
--- Register a new statistical quantity.
-- Name and title fields are as usual. The functional field is
-- GenerateCode = function(desc, initCode, computeCode, deinitCode, meta) which must
-- append the appropriate code for this filter to the given code blocks.
function RDXRS.RegisterStatisticalQuantity(tbl)
	if (not tbl) or (not tbl.name) then error("invalid registration table"); end
	if sq[tbl.name] then error("duplicate registration"); end
	sq[tbl.name] = tbl;
end

function RDXRS.GetStatisticalQuantity(n)
	if not n then return nil; end
	return sq[n];
end

-- Append to the given code a function that will compute the quantity.
local function QuantityGeneratingFunctor(desc, code)
	local qty = desc.qty; if not qty then return nil; end
	local qdef = sq[qty]; if not qdef then return nil; end
	if not qdef.GenerateCode then return nil; end
	qdef.GenerateCode(desc, code);
	return true;
end

---------------------------------------------------------------
-- The Statistic object
---------------------------------------------------------------
RDXRS.Statistic = {};
RDXRS.Statistic.__index = RDXRS.Statistic;
function RDXRS.Statistic:new()
	local self = {};
	setmetatable(self, RDXRS.Statistic);
	self.name = ""; self.color = _green; self.fadeColor = _red;
	self.val = 0; self.max = 0; self.pct = nil; self.sv = 2;
	self._computeVal = VFL.Noop; self._computeMax = VFL.Noop;
	self.lut = 0;
	return self;
end

-- Accessors
function RDXRS.Statistic:GetValue() return self.val; end
function RDXRS.Statistic:GetMaxValue() return self.max; end
function RDXRS.Statistic:GetRatio()
	if self.max > 0 then
		return VFL.clamp(self.val/self.max, 0, 1);
	else
		return 0;
	end
end

-- Functor - from a statistic's descriptor, make the statistic.
function RDXRS.Statistic:LoadDescriptor(desc)
	if (not desc) or (not desc.val) or (not desc.max) then return nil; end
	self.name = desc.name; self.color = desc.color; self.fadeColor = desc.fadeColor;
	self.texture = desc.texture; self.pct = desc.pct; self.sv = desc.sv;
	local f1,f2,err = nil, nil;
	-- Generate val getter
	local code = VFL.Snippet:new();
	if not QuantityGeneratingFunctor(desc.val, code) then return nil;	end
	f1,err = loadstring(code:GetCode()); if not f1 then return nil, err; end
	self._computeVal = f1();
	-- Generate max getter
	code:Clear();
	if not QuantityGeneratingFunctor(desc.max, code) then return nil;	end
	f2,err = loadstring(code:GetCode()); if not f2 then return nil, err; end
  self._computeMax = f2();
end

-- Update the statistic.
function RDXRS.Statistic:Compute()
	local t = GetTime();
	if( (t - self.lut) < statUpdatePeriod ) then return; end
	self.val = self:_computeVal(); 
	self.max = self:_computeMax();
	self.lut = t;
end

---------------------------------------------------------------
-- Statistic editor
---------------------------------------------------------------
local function CreateQuantityEditor(parent)
	local self = VFLUI.SelectEmbed:new(parent, 150, function()
		local qq = {};
		for k,v in pairs(sq) do table.insert(qq, {text = v.title, value = v}); end
		return qq;
	end, function(ctl, desc)
		local cls = RDXRS.GetStatisticalQuantity(desc.qty);
		if cls then
			return cls.GetUI(ctl, desc), cls.title, cls;
		end
	end);
	self:SetText( VFLI.i18n("Quantity"));
	return self;
end

function RDXRS.StatisticEditor(parent, path, md)
	-- Sanity checks
	if (not path) or (not md) or (not md.data) then return nil; end
	local desc = md.data;

	local inst = RDXDB.GetObjectInstance(path);

	local dlg = VFLUI.Window:new(parent);
	VFLUI.Window.SetDefaultFraming(dlg, 22);
	dlg:SetTitleColor(0,0,.6);
	dlg:SetBackdrop(VFLUI.BlackDialogBackdrop);
	dlg:SetPoint("CENTER", RDXParent, "CENTER");
	dlg:SetWidth(316); dlg:SetHeight(357);
	dlg:SetText( VFLI.i18n("Edit Statistic: ") .. path);
	dlg:SetClampedToScreen(true);
	dlg:Show();
	VFLUI.Window.StdMove(dlg, dlg:GetTitleBar());

	local sf = VFLUI.VScrollFrame:new(dlg);
	sf:SetWidth(290); sf:SetHeight(300);
	sf:SetPoint("TOPLEFT", dlg:GetClientArea(), "TOPLEFT");
	sf:Show();

	local ui = VFLUI.CompoundFrame:new(sf);
	ui:SetParent(sf); sf:SetScrollChild(ui);
	ui.isLayoutRoot = true;

	local ed_name = VFLUI.LabeledEdit:new(ui, 100); ed_name:Show();
	ed_name:SetText( VFLI.i18n("Name"));
	if desc and desc.name then ed_name.editBox:SetText(desc.name); end
	ui:InsertFrame(ed_name);

	local er = VFLUI.EmbedRight(ui,  VFLI.i18n("Color"));
	local swatch_c = VFLUI.ColorSwatch:new(er);
	swatch_c:Show();
	if desc and desc.color then swatch_c:SetColor(VFL.explodeColor(desc.color)); end
	er:EmbedChild(swatch_c); er:Show();
	ui:InsertFrame(er);

	er = VFLUI.EmbedRight(ui,  VFLI.i18n("Fade color"));
	local swatch_fc = VFLUI.ColorSwatch:new(er);
	swatch_fc:Show();
	if desc and desc.fadeColor then swatch_fc:SetColor(VFL.explodeColor(desc.fadeColor)); end
	er:EmbedChild(swatch_fc); er:Show();
	ui:InsertFrame(er);

	er = VFLUI.EmbedRight(ui,  VFLI.i18n("Icon"));
	local ip = VFLUI.IconPicker:new(er); ip:Show();
	if desc and desc.texture then ip:SetIconPath(desc.texture); end
	er:EmbedChild(ip); er:Show(); ui:InsertFrame(er);

	local chk_pct = VFLUI.Checkbox:new(ui); chk_pct:Show();
	chk_pct:SetText( VFLI.i18n("Show percentage"));
	if desc and desc.pct then chk_pct:SetChecked(true); else chk_pct:SetChecked(); end
	ui:InsertFrame(chk_pct);

	local rg_sv = VFLUI.RadioGroup:new(ui);
	rg_sv:SetLayout(3,1);
	rg_sv.buttons[1]:SetText( VFLI.i18n("No value display"));
	rg_sv.buttons[2]:SetText( VFLI.i18n("Current value"));
	rg_sv.buttons[3]:SetText( VFLI.i18n("Current/Max"));
	if desc and desc.sv then rg_sv:SetValue(desc.sv); else rg_sv:SetValue(1); end
	ui:InsertFrame(rg_sv);

	local val = CreateQuantityEditor(ui); val:Show();
	val:SetText( VFLI.i18n("Value"));
	if desc and desc.val then val:SetDescriptor(desc.val); end
	ui:InsertFrame(val);

	local max = CreateQuantityEditor(ui); max:Show();
	max:SetText( VFLI.i18n("Max value"));
	if desc and desc.max then max:SetDescriptor(desc.max); end
	ui:InsertFrame(max);

	ui:SetWidth(sf:GetWidth());
	ui:Show(); VFLUI.UpdateDialogLayout(ui);
	
	------------------- DESTRUCTORS
	local esch = function() dlg:Destroy(); end
	VFL.AddEscapeHandler(esch);
	
	local function Save()
		desc.name = ed_name.editBox:GetText();
		desc.color = swatch_c:GetColor();
		desc.fadeColor = swatch_fc:GetColor();
		desc.texture = ip:GetIconPath();
		desc.val = val:GetDescriptor();
		desc.max = max:GetDescriptor();
		desc.pct = chk_pct:GetChecked();
		desc.sv = rg_sv:GetValue();
		if inst then
			inst:LoadDescriptor(desc); inst:Compute();
		end
		VFL.EscapeTo(esch);
	end

	local savebtn = VFLUI.SaveButton:new()
	savebtn:SetScript("OnClick", Save);
	dlg:AddButton(savebtn);

	local closebtn = VFLUI.CloseButton:new(dlg);
	closebtn:SetScript("OnClick", function() VFL.EscapeTo(esch); end);
	dlg:AddButton(closebtn);

	dlg.Destroy = VFL.hook(function(s)
		sf:SetScrollChild(nil);
		ui:Destroy(); ui = nil; 
		sf:Destroy(); sf = nil;
	end, dlg.Destroy);
end

--- The Statistic object type.
RDXDB.RegisterObjectType({
	name = "Statistic";
	New = function(path,md)
		md.version = 1;
	end;
	Instantiate = function(path, obj)
		if(not obj) or (not obj.data) then return nil; end
		local st = RDXRS.Statistic:new();
		st:LoadDescriptor(obj.data);
		return st;
	end;
	GenerateBrowserMenu = function(mnu, path, md, dlg)
		table.insert(mnu, {
			text =  VFLI.i18n("Edit"),
			OnClick = function() 
				VFL.poptree:Release();
				RDXRS.StatisticEditor(dlg, path, md)
			end
		});
	end;
});
