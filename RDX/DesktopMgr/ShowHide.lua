-- ShowHide.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- OpenRDX
-- Sigg Rashgarroth EU
-- Desktop Main function
-- Show / Hide

-------------------------------------------------------
-- Show/hide entire desktop
-------------------------------------------------------
local flag = nil;

function RDXDK.IsRDXHidden()
	return flag;
end

function RDXDK.ShowRDX()
	if InCombatLockdown() then 
		RDX.printI(VFLI.i18n("Cannot change show/hide state while in combat."));
		return; 
	end
	if (not RDXDK.IsRDXHidden()) then return; end
	flag = nil;
	RDXParent:Show();
end

function RDXDK.HideRDX()
	if InCombatLockdown() then 
		RDX.printI(VFLI.i18n("Cannot change show/hide state while in combat."));
		return; 
	end
	if RDXDK.IsRDXHidden() then return; end
	flag = true;
	RDXParent:Hide();
end

function RDXDK.ToggleRDX()
	if flag then
		RDXDK.ShowRDX();
	else
		RDXDK.HideRDX();
	end
end

-- /rdx show and /rdx hide
RDXPM.RegisterSlashCommand("show", RDXDK.ShowRDX);
RDXPM.RegisterSlashCommand("hide", RDXDK.HideRDX);

