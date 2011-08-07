-- Desktop_StatusWindows.lua
-- OpenRDX

----------------------------------
-- win
----------------------------------

RDX.RegisterFeature({
	name = "desktop_statuswindow",
	title = "SW";
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
DesktopEvents:Dispatch("WINDOW_OPEN", "]] .. desc.name .. [[", "desktop_statuswindow");
		]]);
		return true;
	end,
	UIFromDescriptor = RDXUI.defaultUIFromDescriptor;
	CreateDescriptor = function()
		return {
			feature = "desktop_statuswindow";
			open = true;
			scale = 1;
			alpha = 1;
			strata = "MEDIUM";
			anchor = "TOPLEFT";
		}; 
	end;
});

-- direct function access

function RDXDK._AddStatusWindowRDX(path)
	DesktopEvents:Dispatch("WINDOW_OPEN", path, "desktop_statuswindow");
end

function RDXDK._DelStatusWindowRDX(path)
	DesktopEvents:Dispatch("WINDOW_CLOSE", path, "desktop_statuswindow");
end
