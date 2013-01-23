-- Desktop_Windows.lua
-- OpenRDX

----------------------------------
-- win
----------------------------------

RDX.RegisterFeature({
	name = "desktop_window",
	title = "XW";
	category = "Windows";
	multiple = true;
	IsPossible = function(state)
		if not state:Slot("Desktop") then return nil; end
		if not state:Slot("Desktop main") then return nil; end
		return true;
	end,
	ExposeFeature = function(desc, state, errs)
		if not __DesktopCheck_Name(desc, state, errs) then return nil; end
		return true;
	end,
	ApplyFeature = function(desc, state)
		state.Code:AppendCode([[
DesktopEvents:Dispatch("WINDOW_OPEN", "]] .. desc.name .. [[");
		]]);
		return true;
	end,
	UIFromDescriptor = RDXUI.defaultUIFromDescriptor;
	CreateDescriptor = function()
		return {
			feature = "desktop_window";
			open = true;
			scale = 1;
			alpha = 1;
			strata = "MEDIUM";
			anchor = "TOPLEFT";
		}; 
	end;
});

-- direct function access

function RDXDK._AddWindowRDX(path)
	DesktopEvents:Dispatch("WINDOW_OPEN", path, true);
end

function RDXDK._DelWindow(path)
	DesktopEvents:Dispatch("WINDOW_CLOSE", path, true);
end
