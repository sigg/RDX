-- OpenRDX
-- Sigg Rashgarroth EU
-- Desktop Main function

---------------------------------------------------
-- Desktop Clear
-- A "clear" quashes all desktops and custom settings, but does not actually erase
-- any data.
---------------------------------------------------
local function ClearCurrentDesktop()
	VFL.print("TODO");
end

function RDXDK.DeskClear()
	VFLUI.MessageBox("Clear", "Do you want to clear your current desktop? All windows will be closed and your desktop will be reset to the default state. Your UI will be reload.", nil, "No", nil, "Yes", ClearCurrentDesktop);
end

-------------------------------------------------------
-- Desktop RESET
-------------------------------------------------------
local function ResetCurrentDesktop()
	if InCombatLockdown() then 
		RDX.printI(VFLI.i18n("Cannot reset desktop while in combat."));
		return; 
	end
	-- Show everything
	--RDXDK.ShowRDX();
	-- Restore us from mini status.
	--RDXPM.Maximize();

	-- If we don't have a current desktop, just bring us back to the default.
	local p = RDXDK.GetCurrentDesktopPath();
	if not p then RDXDK.SecuredChangeDesktop("desktops:default"); return; end

	local data = RDXDB.GetObjectData(p);
	if (not data) or (not data.data) then RDXDK.SecuredChangeDesktop("desktops:default"); return; end
	data = data.data; -- lol

	-- OK, let's iterate over the desktop and kill all stored layouts
	for ident,dbe in pairs(data) do
		if dbe.feature == "desktop_window" or dbe.feature == "desktop_statuswindow" or  dbe.feature == "desktop_windowless" then
			dbe.scale = 1; dbe.alpha = 1;
			dbe.dock = nil;
			dbe.l = VFLUI.uxScreenCenter;
			dbe.r = VFLUI.uxScreenCenter;
			dbe.t = VFLUI.uyScreenCenter;
			dbe.b = VFLUI.uyScreenCenter;
		end
	end

	-- Now force-reload the desktop.
	RDXDK.SecuredChangeDesktop(p);

	-- Reset downstream stuff.
	--RDXEvents:Dispatch("USER_RESET_UI");
end


function RDXDK.DeskReset()
	VFLUI.MessageBox("Reset", "Do you want to reset your current desktop? All windows will be undocked and moved to the center of the screen.", nil, "No", nil, "Yes", ResetCurrentDesktop);
end

