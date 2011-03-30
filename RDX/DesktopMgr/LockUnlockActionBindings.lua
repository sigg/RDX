-- OpenRDX
-- Sigg Rashgarroth EU
--
-- Lock / Unlock KeyBindings

function RDXDK.IsActionBindingsLocked()
	if RDXU then return RDXU.ablocked; else return nil; end
end

function RDXDK.UnlockActionBindings()
	RDXU.ablocked = nil;
end

function RDXDK.LockActionBindings()
	RDXU.ablocked = true;
end

function RDXDK.ToggleActionBindingsLock()
	if RDXDK.IsActionBindingsLocked() then
		RDXDK.UnlockActionBindings();
		RDX.printI(VFLI.i18n("Unlocking Action Bindings."));
	else 
		RDXDK.LockActionBindings();
		RDX.printI(VFLI.i18n("Locking Action Bindings."));
	end
end

