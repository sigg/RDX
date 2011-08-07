-- Desktop_ActionBindings.lua
-- OpenRDX

----------------------------------
-- win
----------------------------------

RDX.RegisterFeature({
	name = "desktop_actionbindings",
	title = "Action Bindings";
	category = "Others";
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if not state:Slot("Desktop main") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc and not desc.objectAB then return nil; end
		return true;
	end,
	ApplyFeature = function(desc, state)
		state.Code:AppendCode([[

DesktopEvents:Bind("DESKTOP_POST_OPEN", nil, function()
	RDXDB.GetObjectInstance("]] .. desc.objectAB .. [[");
end, encid);

DesktopEvents:Bind("DESKTOP_PRE_CLOSE", nil, function(nosave)
	RDXDB._RemoveInstance("]] .. desc.objectAB .. [[", nosave);
end, encid);

		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ofAB = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty=="ActionBindings"); end);
		ofAB:SetLabel(VFLI.i18n("Action bindings"));
		if desc and desc.objectAB then ofAB:SetPath(desc.objectAB); end
		ui:InsertFrame(ofAB);

		function ui:GetDescriptor()
			return { 
				feature = "desktop_actionbindings";
				objectAB = ofAB:GetPath();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "desktop_actionbindings";
		}; 
	end;
});

