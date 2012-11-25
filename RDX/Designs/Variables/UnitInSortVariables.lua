-------------------------------------------------------------------
-- Unit In Sort/Unit In Set variables
-------------------------------------------------------------------
RDX.RegisterFeature({
	name = "Variable: Unit In Sort";
	title = "Vars Unit In Sort";
	category = VFLI.i18n("Variables");
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)		
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		local _,_,_,ty = RDXDB.GetObjectData(desc.sort);
		if (not ty) or (not string.find(ty, "Sort$")) or (not RDXDB.GetObjectInstance(desc.sort)) then
			VFL.AddError(errs, VFLI.i18n("Invalid sort pointer.")); return nil;
		end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("BoolVar_" .. desc.name .. "_flag");
		state:AddSlot("FracVar_" .. desc.name .. "_grade");
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- On closure, acquire the set locally
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[ = RDXDB.GetObjectInstance("]] .. desc.sort .. [[");
]]);
		end);
		-- On paint preamble, create flag and grade variables
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
			code:AppendCode([[
		local ]] .. desc.name .. [[_idx, ]] .. desc.name .. [[_flag, ]] .. desc.name .. [[_grade = ]] .. desc.name .. [[:IndexOfUID(uid), false, 0;
		if not  ]] .. desc.name .. [[_idx then
			]] .. desc.name .. [[_idx = 0;
		elseif ]] .. desc.name .. [[_idx <= ]] .. desc.order .. [[ then
			]] .. desc.name .. [[_flag = true;
]]);
			if desc.order ~= 1000 then
				-- Case 1: grade = pos / fixed number
				code:AppendCode(desc.name .. [[_grade = (]] .. desc.name .. [[_idx - 1) / (]] .. desc.order .. [[);
]]);
			else
				-- Case 2: grade = pos / sortsize
				code:AppendCode(desc.name .. [[_grade = (]] .. desc.name .. [[_idx - 1) / (]] .. desc.name .. [[:GetSortSize());
]]);
			end
			code:AppendCode([[
		end
]]);
		end);
		-- Event hint: update on sort.
		local sort = RDXDB.GetObjectInstance(desc.sort);
		local mux = state:GetContainingWindowState():GetSlotValue("Multiplexer");
		mux:Event_SigUpdateMaskAll(sort, 2); -- mask 2 = generic repaint
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local sort = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Sort$")); end);
		sort:SetLabel(VFLI.i18n("Sort")); sort:Show();
		if desc and desc.sort then sort:SetPath(desc.sort); end
		ui:InsertFrame(sort);

		local chk_order = VFLUI.Checkbox:new(ui); chk_order:Show();
		local order = VFLUI.Edit:new(chk_order); order:Show();
		order:SetHeight(25); order:SetWidth(50); order:SetPoint("RIGHT", chk_order, "RIGHT");
		chk_order.Destroy = VFL.hook(function() order:Destroy(); end, chk_order.Destroy);
		chk_order:SetText(VFLI.i18n("Limit size of sort to:"));
		if desc and desc.order and (desc.order ~= 1000) then 
			chk_order:SetChecked(true); 
			order:SetText(desc.order);
		else 
			chk_order:SetChecked();
			order:SetText("1");
		end
		ui:InsertFrame(chk_order);
	
		function ui:GetDescriptor()
			local ord = 1000;
			if chk_order:GetChecked() then ord = VFL.clamp(order:GetNumber(), 1, 40); end
			return {
				feature = "Variable: Unit In Sort";
				name = name.editBox:GetText(); sort = sort:GetPath();
				order = ord;
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variable: Unit In Sort"; name = "unitInSort"; order = 1000; };
	end;
});