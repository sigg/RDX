
RDX.RegisterFeature({
	name = "Variable: Unit In Set";
	title = "Vars Unit In Set";
	category = VFLI.i18n("Variables");
	multiple = true;
	test = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)		
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if not RDXDAL.FindSet(desc.set) then
			VFL.AddError(errs, VFLI.i18n("Invalid set pointer."));
			return nil;
		end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("BoolVar_" .. desc.name .. "_flag");
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- Add edit to menu
		if desc.set and desc.set.class == "file" and desc.showlink and not string.find(desc.set.file, "Builtin") then
			local path = desc.set.file; local afname = desc.name;
			local wstate = state:GetContainingWindowState();
			if wstate then
				wstate:Attach("Menu", true, function(win, mnu)
					table.insert(mnu, {
						text = VFLI.i18n("Edit File Set: ") .. afname;
						OnClick = function()
							VFL.poptree:Release();
							RDXDB.OpenObject(path, "Edit", VFLDIALOG);
						end;
					});
				end);
			end
		end
		-- On closure, acquire the set locally
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[ = RDXDAL.FindSet(]] .. Serialize(desc.set) .. [[);
if not ]] .. desc.name .. [[:IsOpen() then ]] .. desc.name .. [[:Open(); end
]]);
		end);
		-- On paint preamble, create flag and grade variables
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
		local ]] .. desc.name .. [[_flag = true;
]]);
		else
			code:AppendCode([[
		local ]] .. desc.name .. [[_flag = ]] .. desc.name .. [[:IsMember(unit);
]]);
		end
		end);
		-- Event hint: update on sort.
		local set = RDXDAL.FindSet(desc.set);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			mux:Event_SetDeltaMask(set, 2); -- mask 2 = generic repaint
		end
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local chk_showlink = VFLUI.Checkbox:new(ui); chk_showlink:Show();
		chk_showlink:SetText(VFLI.i18n("Show link to edit this filterfile from window. Only working for set class file"));
		if desc and desc.showlink then chk_showlink:SetChecked(true); else chk_showlink:SetChecked(); end
		ui:InsertFrame(chk_showlink);

		local sf = RDXDAL.SetFinder:new(ui); sf:Show();
		ui:InsertFrame(sf); 
		if desc and desc.set then sf:SetDescriptor(desc.set); end

		function ui:GetDescriptor()
			return {
				feature = "Variable: Unit In Set";
				name = name.editBox:GetText();
				showlink = chk_showlink:GetChecked();
				set = sf:GetDescriptor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variable: Unit In Set"; name = "unitInSet"; };
	end;
});

RDX.RegisterFeature({
	name = "Variable: SetEmpty";
	title = "Vars SetEmpty";
	category = VFLI.i18n("Variables");
	multiple = true;
	test = true;
	IsPossible = function(state)
		if not state:Slot("DesignFrame") then return nil; end
		if not state:Slot("EmitPaintPreamble") then return nil; end
		return true;
	end;
	ExposeFeature = function(desc, state, errs)		
		if not desc then VFL.AddError(errs, VFLI.i18n("No descriptor.")); return nil; end
		if not RDX._CheckVariableNameValidity(desc.name, state, errs) then return nil; end
		if not RDXDAL.FindSet(desc.set) then
			VFL.AddError(errs, VFLI.i18n("Invalid set pointer."));
			return nil;
		end
		state:AddSlot("Var_" .. desc.name);
		state:AddSlot("BoolVar_" .. desc.name .. "_flag");
		return true;
	end;
	ApplyFeature = function(desc, state)
		-- Add edit to menu
		if desc.set and desc.set.class == "file" and desc.showlink and not string.find(desc.set.file, "Builtin") then
			local path = desc.set.file; local afname = desc.name;
			local wstate = state:GetContainingWindowState();
			if wstate then
				wstate:Attach("Menu", true, function(win, mnu)
					table.insert(mnu, {
						text = VFLI.i18n("Edit File Set: ") .. afname;
						OnClick = function()
							VFL.poptree:Release();
							RDXDB.OpenObject(path, "Edit", VFLDIALOG);
						end;
					});
				end);
			end
		end
		-- On closure, acquire the set locally
		state:Attach(state:Slot("EmitClosure"), true, function(code)
			code:AppendCode([[
local ]] .. desc.name .. [[ = RDXDAL.FindSet(]] .. Serialize(desc.set) .. [[);
if not ]] .. desc.name .. [[:IsOpen() then ]] .. desc.name .. [[:Open(); end
]]);
		end);
		-- On paint preamble, create flag and grade variables
		state:Attach(state:Slot("EmitPaintPreamble"), true, function(code)
		if desc.test then
			code:AppendCode([[
		local ]] .. desc.name .. [[_flag = true;
]]);
		else
			code:AppendCode([[
		local ]] .. desc.name .. [[_flag = ]] .. desc.name .. [[:IsEmpty();
]]);
		end
		end);
		-- Event hint: update on sort.
		local set = RDXDAL.FindSet(desc.set);
		local wstate = state:GetContainingWindowState();
		if wstate then
			local mux = wstate:GetSlotValue("Multiplexer");
			mux:Event_SetDeltaMask(set, 2); -- mask 2 = generic repaint
		end
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = VFLUI.CompoundFrame:new(parent);

		local name = VFLUI.LabeledEdit:new(ui, 100); name:Show();
		name:SetText(VFLI.i18n("Variable Name"));
		if desc and desc.name then name.editBox:SetText(desc.name); end
		ui:InsertFrame(name);

		local chk_showlink = VFLUI.Checkbox:new(ui); chk_showlink:Show();
		chk_showlink:SetText(VFLI.i18n("Show link to edit this filterfile from window. Only working for set class file"));
		if desc and desc.showlink then chk_showlink:SetChecked(true); else chk_showlink:SetChecked(); end
		ui:InsertFrame(chk_showlink);

		local sf = RDXDAL.SetFinder:new(ui); sf:Show();
		ui:InsertFrame(sf); 
		if desc and desc.set then sf:SetDescriptor(desc.set); end

		function ui:GetDescriptor()
			return {
				feature = "Variable: SetEmpty";
				name = name.editBox:GetText();
				showlink = chk_showlink:GetChecked();
				set = sf:GetDescriptor();
			};
		end

		return ui;
	end;
	CreateDescriptor = function()
		return { feature = "Variable: SetEmpty"; name = "setempty"; };
	end;
});