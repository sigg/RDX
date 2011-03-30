-- OpenRDX Sigg

-- to remove

local _types = {
	{ text = "BUFFS" },
	{ text = "DEBUFFS" },
};
local function _dd_types() return _types; end

RDX.RegisterFeature({
	name = "Aura Timer Engine Info",
	category = VFLI.i18n("Auras");
	invisible = true;
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Bossmod") then return nil; end
		if not state:Slot("Registered") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc then VFL.AddError(errs, VFLI.i18n( "No descriptor.")); return nil; end
		if not desc.cd or desc.cd == "" then VFL.AddError(errs, VFLI.i18n("Miss aura name")); return nil; end
		if not desc.duration or desc.duration == "" then VFL.AddError(errs, VFLI.i18n("Miss duration name")); return nil; end
		return true;
	end;
	ApplyFeature = function(desc, state)
		local AddAura, RemoveAura, pathaurafilter = "RDXATE.AddBuff", "RDXATE.RemoveBuff", "Builtin:bm_ate_debuff_afilter";
		if desc.auraType == "DEBUFFS" then 
			AddAura, RemoveAura, pathaurafilter = "RDXATE.AddDebuff", "RDXATE.RemoveDebuff", "Builtin:bm_ate_debuff_afilter";
			
		end
		state.Code:AppendCode([[
		BossmodEvents:Bind("ACTIVATE", nil, function()
			]].. AddAura ..[[("]].. desc.cd ..[[", ]].. desc.duration ..[[);
			local mbo = RDXDB.TouchObject("]]..  pathaurafilter ..[[");
			local inst = RDXDB.GetObjectInstance("]]..  pathaurafilter ..[[", true);
			if VFL.vfind(mbo.data, "]].. desc.cd ..[[") == nil then
				table.insert(mbo.data, "]].. desc.cd ..[[");
				if inst then RDXDB.WriteFilter(inst, mbo.data); end
			end
		end, encid);
		
		BossmodEvents:Bind("DEACTIVATE", nil, function()
			]].. RemoveAura ..[[("]].. desc.cd ..[[", ]].. desc.duration ..[[);
			local mbo = RDXDB.TouchObject("]]..  pathaurafilter ..[[");
			local inst = RDXDB.GetObjectInstance("]]..  pathaurafilter ..[[", true);
			VFL.vremove(mbo.data, "]].. desc.cd ..[[");
			if inst then RDXDB.WriteFilter(inst, mbo.data); end
		end, encid);
		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);
		
		local er = VFLUI.EmbedRight(ui, VFLI.i18n("Aura Type:"));
		local dd_auraType = VFLUI.Dropdown:new(er, _dd_types);
		dd_auraType:SetWidth(150); dd_auraType:Show();
		if desc and desc.auraType then 
			dd_auraType:SetSelection(desc.auraType); 
		else
			dd_auraType:SetSelection("DEBUFFS");
		end
		er:EmbedChild(dd_auraType); er:Show();
		ui:InsertFrame(er);
		
		local cd = VFLUI.LabeledEdit:new(ui, 150);
		cd:SetText(VFLI.i18n("Aura Name"));
		cd:Show();
		if desc and desc.cd then cd.editBox:SetText(desc.cd); end
		ui:InsertFrame(cd);
		
		local btn = VFLUI.Button:new(cd);
		btn:SetHeight(25); btn:SetWidth(25); btn:SetText("...");
		btn:SetPoint("RIGHT", cd.editBox, "LEFT"); 
		btn:Show();
		if dd_auraType:GetSelection() == "BUFFS" then 
			btn:SetScript("OnClick", function()
				RDXDAL.AuraCachePopup(RDXDAL._GetBuffCache(), function(x) 
					if x then cd.editBox:SetText(x.name); end
				end, btn, "CENTER");
			end);
		else
			btn:SetScript("OnClick", function()
				RDXDAL.AuraCachePopup(RDXDAL._GetDebuffCache(), function(x) 
					if x then cd.editBox:SetText(x.name); end
				end, btn, "CENTER");
			end);
		end
		
		local duration = VFLUI.LabeledEdit:new(ui, 50); duration:Show();
		duration:SetText(VFLI.i18n("Duration (seconds)"));
		if desc and desc.duration then duration.editBox:SetText(desc.duration); end
		ui:InsertFrame(duration);
		
		function ui:GetDescriptor()
			local t = cd.editBox:GetText();
			if(not t) or (t == "") then return nil; end
			t = string.lower(t);
			return {
				feature = "Aura Timer Engine Info";
				auraType = dd_auraType:GetSelection();
				cd = t;
				duration = duration.editBox:GetText();
			};
		end
		
		ui.Destroy = VFL.hook(function(s) btn:Destroy(); s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end,
	CreateDescriptor = function() return {feature = "Aura Timer Engine Info"; auraType = "DEBUFFS";}; end
});

