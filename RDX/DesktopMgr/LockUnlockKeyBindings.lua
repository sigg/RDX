-- OpenRDX
-- Sigg Rashgarroth EU
--
-- Lock / Unlock KeyBindings

--function RDXDK.IsKeyBindingsLocked()
--	if RDXU then 
--		if not RDXU.keyNotlocked then return true; else return nil; end 
--	end
--end

--function RDXDK.UnlockKeyBindings()
--	if not InCombatLockdown() then 
--		RDXU.keyNotlocked = true;
--		DesktopEvents:Dispatch("DESKTOP_UNLOCK_BINDINGS");
--	else
--		RDX.printI(VFLI.i18n("Cannot change unlock state while in combat."));
--	end
--end

--function RDXDK.LockKeyBindings()
--	RDXU.keyNotlocked = nil;
--	DesktopEvents:Dispatch("DESKTOP_LOCK_BINDINGS");
	--SaveBindings(GetCurrentBindingSet());
--end

--function RDXDK.ToggleKeyBindingsLock()
--	if RDXDK.IsKeyBindingsLocked() then
--		RDXDK.UnlockKeyBindings();
--		RDX.printI(VFLI.i18n("Unlocking Key Bindings."));
--	else 
--		RDXDK.LockKeyBindings();
--		RDX.printI(VFLI.i18n("Locking Key Bindings."));
--	end
--end

-- lock desktop if in combat
--VFLEvents:Bind("PLAYER_COMBAT", nil, function()
--	if InCombatLockdown() and not RDXDK.IsKeyBindingsLocked() then
--		RDXDK.LockKeyBindings();
--	end
--end);

--DesktopEvents:Bind("INIT_POST_DESKTOP", nil, function()	
--	if RDXDK.IsKeyBindingsLocked() then
--		RDXDK.LockKeyBindings();
--	else
--		RDXDK.UnlockKeyBindings();
--	end
--end);

