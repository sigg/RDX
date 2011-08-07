-- Desktop_ActionBindings.lua
-- OpenRDX

----------------------------------
-- win
----------------------------------

RDX.RegisterFeature({
	name = "desktop_keybindings",
	title = "Key Bindings";
	category = "Others";
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if not state:Slot("Desktop main") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not desc and not desc.objectKB then return nil; end
		return true;
	end,
	ApplyFeature = function(desc, state)
		state.Code:AppendCode([[

DesktopEvents:Bind("DESKTOP_POST_OPEN", nil, function()
	RDXDB.GetObjectInstance("]] .. desc.objectKB .. [[");
end, encid);

DesktopEvents:Bind("DESKTOP_PRE_CLOSE", nil, function(nosave)
	RDXDB._RemoveInstance("]] .. desc.objectKB .. [[", nosave);
end, encid);

		]]);
		return true;
	end,
	UIFromDescriptor = function(desc, parent)
		local ui = VFLUI.CompoundFrame:new(parent);

		local ofKB = RDXDB.ObjectFinder:new(ui, function(p,f,md) return (md and type(md) == "table" and md.ty=="KeyBindings"); end);
		ofKB:SetLabel(VFLI.i18n("Key bindings"));
		if desc and desc.objectKB then ofKB:SetPath(desc.objectKB); end
		ui:InsertFrame(ofKB);

		function ui:GetDescriptor()
			return { 
				feature = "desktop_keybindings";
				objectKB = ofKB:GetPath();
			};
		end
		
		return ui;
	end;
	CreateDescriptor = function()
		return {
			feature = "desktop_keybindings";
		}; 
	end;
});

