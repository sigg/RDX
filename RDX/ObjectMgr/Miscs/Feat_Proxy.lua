-- ProxyFeature.lua
-- RDX - Raid Data Exchange
-- (C)2006 Bill Johnson
--
-- A proxy feature is a feature that is "inert" at design time, but at runtime, loads
-- feature data from another source and impersonates that feature in every detail.

local function LoadFeatureFromFile(x)
	local md = RDXDB.GetObjectData(x); if not md then return; end
	local d = md.data;
	if (md.ty == "FeatureData") and (type(d) == "table") and (type(d.feature) == "string") then
		return d, RDXDB.GetFeatureByName(d.feature);
	end
end
RDXDB.LoadFeatureFromFile = LoadFeatureFromFile;

RDX.RegisterFeature({
	name = "Proxy: File";
	category = VFLI.i18n("Miscs");
	multiple = true;
	IsPossible = VFL.True;
	ExposeFeature = function(desc, state, errs)
		local data, feat = LoadFeatureFromFile(desc.file);
		if data then
			return feat.ExposeFeature(data, state, errs);
		else
			return true;
		end
	end;
	ApplyFeature = function(desc, state)
		local data, feat = LoadFeatureFromFile(desc.file);
		if feat then
			return feat.ApplyFeature(data, state);
		end
	end;
	UIFromDescriptor = function(desc, parent, state)
		local ui = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "FeatureData$")); end);
		ui:SetLabel(VFLI.i18n("Feature data"));
		if desc and desc.file then ui:SetPath(desc.file); end

		function ui:GetDescriptor()
			return {feature = "Proxy: File", file = self:GetPath()};
		end

		return ui;
	end;
	CreateDescriptor = function() return {feature = "Proxy: File"}; end;
});
