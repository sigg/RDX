-- CID: Currency ID
--- Available here: wowhead.com/currencies

-- CTA: Currency, Total Amount
--- Manually specified cap,  e.g. 4000 maximum honor.
---- Unfortunately, "_,_,_,_,_,totalMax,_ = GetCurrencyInfo()" returns seem to be bugged, so an automatic cap
---- is impossible currently, unless someone has a better alternative or knows something I don't.
----- Confirmed here: wowinterface.com/forums/showthread.php?p=249103#post249103

function RDXDAL.Unit:FracCurrency(cid,cta)
	local _,currentAmount,_,_,_,_,_ = GetCurrencyInfo(cid)
	local a,b = currentAmount,cta;
	local fractional
	if(b<1) then fractional = 0; end
	a=a/b;
	if a<0 then fractional = 0 elseif a>1 then fractional = 1; else fractional = a; end
	return currentAmount,fractional
end

RDX.RegisterFeature({
	name = "Variable: Fractional Currency";
	title = VFLI.i18n("Vars Frac Currency");
	category = VFLI.i18n("Variables");
	test = true;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if not desc.name then desc.name = "cid"; end
		if not desc.currencyid then desc.currencyid = "nil"; end
		if not desc.currencytotalamount then desc.currencytotalamount = "nil"; end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("FracVar_" .. desc.name);
		state:AddSlot("TextData_" .. desc.name .. "txt");
		return true;
	end;
	ApplyFeature = function(desc, state)
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		code:AppendCode([[
		local currentAmount,fractional = unit:FracCurrency(]] .. desc.currencyid .. [[,]] .. desc.currencytotalamount .. [[);
		local ]] .. desc.name .. [[ = fractional
		local ]] .. desc.name .. [[txt = string.format("%0.0f%% | %s / %s", (currentAmount/]] .. desc.currencytotalamount .. [[)*100, currentAmount, ]] .. desc.currencytotalamount .. [[);
]]);
		end);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			mux:Event_MaskAll("CURRENCY_DISPLAY_UPDATE", 2);
		end
	end;

	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); else name.editBox:SetText("currencyid"); end
		ui:InsertFrame(name);

		local currencyid = VFLUI.LabeledEdit:new(ui, 100); currencyid:Show();
		currencyid:SetText(VFLI.i18n("Currency: ID"));
		if desc and desc.currencyid then currencyid.editBox:SetText(desc.currencyid); else currencyid.editBox:SetText("392"); end
		ui:InsertFrame(currencyid);
		
		local currencytotalamount = VFLUI.LabeledEdit:new(ui, 140); currencytotalamount:Show();
		currencytotalamount:SetText(VFLI.i18n("Currency: Total Amount"));
		if desc and desc.currencytotalamount then currencytotalamount.editBox:SetText(desc.currencytotalamount); else currencytotalamount.editBox:SetText("4000"); end
		ui:InsertFrame(currencytotalamount);

		function ui:GetDescriptor()
			return {
				feature = "Variable: Fractional Currency";
				name = name.editBox:GetText();
				currencyid = currencyid.editBox:GetText();
				currencytotalamount = currencytotalamount.editBox:GetText();
			};
		end

		return ui;
	end;
	CreateDescriptor = function() return { feature = "Variable: Fractional Currency"; name = "cid"; currencyid = "nil"; currencytotalamount = "nil" }; end
});