-- Quantities.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- THIS FILE CONTAINS COPYRIGHTED MATERIAL SUBJECT TO THE TERMS OF A SEPARATE
-- LICENSE. UNLICENSED COPYING IS PROHIBITED.
--
-- Statistical quantities for use with stat objects.

RDXRS.RegisterStatisticalQuantity({
	name = "num";
	title = "Fixed value";
	GetUI = function(parent, desc)
		local ui = VFLUI.LabeledEdit:new(parent, 60); ui:Show();
		ui:SetText("Value");
		if desc and desc.x then ui.editBox:SetText(desc.x); end
		
		function ui:GetDescriptor() return { qty="num", x = ui.editBox:GetNumber(); } end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		return ui;
	end;
	GenerateCode = function(desc, code)
		code:AppendCode([[
return function() return ]] .. desc.x .. [[; end;
]]);
	end
});

RDXRS.RegisterStatisticalQuantity({
	name = "shp";
	title = "Set HP";
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		local setsel = RDXDAL.SetFinder:new(ui); setsel:Show();
		if desc and desc.set then setsel:SetDescriptor(desc.set); end
		ui:InsertFrame(setsel);

		function ui:GetDescriptor()
			return { qty = "shp";	set = setsel:GetDescriptor(); };
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		return ui;
	end;
	GenerateCode = function(desc, code)
		if (not desc) or (not desc.set) then return; end
		code:AppendCode([[
local set = RDXDAL.FindSet(]] .. Serialize(desc.set) .. [[);
if not set then return VFL.Zero; end
set:Open();
return function()
	local ret = 0;
	for _, _, unit in set:Iterator() do
		if unit:IsValid() then
			ret = ret + unit:Health();
		end
	end
	return ret;
end;
]]);
	end
});

RDXRS.RegisterStatisticalQuantity({
	name = "smaxhp";
	title = "Set MaxHP";
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		local setsel = RDXDAL.SetFinder:new(ui); setsel:Show();
		if desc and desc.set then setsel:SetDescriptor(desc.set); end
		ui:InsertFrame(setsel);

		function ui:GetDescriptor()
			return { qty = "smaxhp";	set = setsel:GetDescriptor(); };
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		return ui;
	end;
	-- Quirk in generated code: if the player is in combat, don't allow max HP to drop because of
	-- people dying.
	GenerateCode = function(desc, code)
		if (not desc) or (not desc.set) then return; end
		code:AppendCode([[
local set = RDXDAL.FindSet(]] .. Serialize(desc.set) .. [[);
if not set then return VFL.Zero; end
set:Open();
local max = 0;
return function()
	local val = 0;
	for _, _, unit in set:Iterator() do
		if unit:IsValid() then
			val = val + unit:MaxHealth();
		end
	end
	if UnitAffectingCombat("player") then
		max = math.max(max, val);
	else
		max = val;
	end
	return max;
end;
]]);
	end
});

RDXRS.RegisterStatisticalQuantity({
	name = "smp";
	title = "Set Power";
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		local setsel = RDXDAL.SetFinder:new(ui); setsel:Show();
		if desc and desc.set then setsel:SetDescriptor(desc.set); end
		ui:InsertFrame(setsel);

		function ui:GetDescriptor()
			return { qty = "smp";	set = setsel:GetDescriptor(); };
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		return ui;
	end;
	GenerateCode = function(desc, code)
		if (not desc) or (not desc.set) then return; end
		code:AppendCode([[
local set = RDXDAL.FindSet(]] .. Serialize(desc.set) .. [[);
if not set then return VFL.Zero; end
set:Open();
return function()
	local ret = 0;
	for _, _, unit in set:Iterator() do
		if unit:IsValid() then
			ret = ret + unit:Power();
		end
	end
	return ret;
end;
]]);
	end
});

RDXRS.RegisterStatisticalQuantity({
	name = "smaxmp";
	title = "Set Max Power";
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		local setsel = RDXDAL.SetFinder:new(ui); setsel:Show();
		if desc and desc.set then setsel:SetDescriptor(desc.set); end
		ui:InsertFrame(setsel);

		function ui:GetDescriptor()
			return { qty = "smaxmp";	set = setsel:GetDescriptor(); };
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		return ui;
	end;
	-- Quirk in generated code: if the player is in combat, don't allow max HP to drop because of
	-- people dying.
	GenerateCode = function(desc, code)
		if (not desc) or (not desc.set) then return; end
		code:AppendCode([[
local set = RDXDAL.FindSet(]] .. Serialize(desc.set) .. [[);
if not set then return VFL.Zero; end
set:Open();
local max = 0;
return function()
	local val = 0;
	for _, _, unit in set:Iterator() do
		if unit:IsValid() then
			val = val + unit:MaxPower();
		end
	end
	if UnitAffectingCombat("player") then
		max = math.max(max, val);
	else
		max = val;
	end
	return max;
end;
]]);
	end
});

RDXRS.RegisterStatisticalQuantity({
	name = "ssz";
	title = "Size of Set";
	GetUI = function(parent, desc)
		local ui = VFLUI.CompoundFrame:new(parent);
		local setsel = RDXDAL.SetFinder:new(ui); setsel:Show();
		if desc and desc.set then setsel:SetDescriptor(desc.set); end
		ui:InsertFrame(setsel);

		function ui:GetDescriptor()
			return { qty = "ssz";	set = setsel:GetDescriptor(); };
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);
		return ui;
	end;
	GenerateCode = function(desc, code)
		if (not desc) or (not desc.set) then return; end
		code:AppendCode([[
local set = RDXDAL.FindSet(]] .. Serialize(desc.set) .. [[);
if not set then return VFL.Zero; end
set:Open();
return function() return set:GetSetSize(); end;
]]);
	end
});
