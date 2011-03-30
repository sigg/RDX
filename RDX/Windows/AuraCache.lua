-- AuraCache.lua
-- OpenRDX

RDX.RegisterFeature({
	name = "AuraCache";
	title = VFLI.i18n("AuraCache");
	IsPossible = function(state)
		if state:Slot("GetContainingWindowState") then return nil; end
		if not state:Slot("DesignFrame") then return nil; end
		if state:Slot("RepaintAllArgs") then return true; end
		return nil;
	end;
	ExposeFeature = function(desc, state, errs)
		return true;
	end;
	ApplyFeature = function(desc, state)
		return true;
	end;
	UIFromDescriptor = VFL.Nil;
	CreateDescriptor = function() return {feature = "AuraCache"}; end;
});