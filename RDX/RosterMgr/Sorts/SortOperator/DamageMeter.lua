-- DamageMeter.lua Sort
-- Sigg OpenRDX

RDXDAL.RegisterSortOperator({
	name = "tablemeter";
	title = VFLI.i18n("TableMeter");
	category = VFLI.i18n("Status");
	EmitLocals = function(desc, code, vars)
		if not vars["tablemeter"] then
			vars["tablemeter"] = true;
			code:AppendCode([[
local d1,d2 = u1:GetTableMeterValue("]] .. desc.path .. [["), u2:GetTableMeterValue("]] .. desc.path .. [[");
]]);
		end
	end;
	EmitCode = function(desc, code, context)
		code:AppendCode([[
if(d1 == d2) then
]]);
		RDXDAL._SortContinuation(context);
		code:AppendCode([[else
]]);
		if desc.reversed then
			code:AppendCode([[return d1 < d2;]]);
		else
			code:AppendCode([[return d1 > d2;]]);
		end
code:AppendCode([[
end
]]);
	end;
	GetUI = function(parent, desc)
		local ui = VFLUI.SortDialogFrame:new(parent);
		ui:SetText(VFLI.i18n("TableMeter")); ui:Show();

		local sf = VFLUI.Dropdown:new(ui, RDXDB._fnListTabMeter, nil, nil, nil, 30);
		ui:SetChild(sf); sf:Show();
		if desc.path then sf:SetSelection(desc.path); end

		ui.GetDescriptor = function(x)
			return {op = "tablemeter"; vname = desc.vname or ("cs" .. math.random(1,10000000)); path = sf:GetSelection()};
		end

		return ui;
	end;
	GetBlankDescriptor = function() return {op = "tablemeter"; vname = "cs" .. math.random(1, 10000000)}; end;
	Events = function(desc, ev) 
		ev[desc.path .. "UNIT_METER_UPDATE"] = true;
	end;
});
