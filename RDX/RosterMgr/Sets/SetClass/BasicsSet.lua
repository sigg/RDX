------------- Basic set classes.
RDXDAL.RegisterSetClass({
	name = "none";
	title = VFLI.i18n("None");
	GetUI = RDXDAL.TrivialSetFinderUI("none");
	FindSet = function() return nil; end
});

RDXDAL.RegisterSetClass({
	name = "group";
	title = VFLI.i18n("Group");
	GetUI = RDXDAL.TrivialSetFinderUI("group");
	FindSet = function() return RDXDAL.groupSet; end
});

RDXDAL.RegisterSetClass({
	name = "empty";
	title = VFLI.i18n("Empty Set");
	GetUI = RDXDAL.TrivialSetFinderUI("empty");
	FindSet = function() return RDXDAL.emptySet; end
});

RDXDAL.RegisterSetClass({
	name = "file",
	title = VFLI.i18n("File"),
	GetUI = function(parent, desc)
		local ui = RDXDB.ObjectFinder:new(parent, function(p,f,md) return (md and type(md) == "table" and md.ty and string.find(md.ty, "Set$")); end);
		ui:SetLabel(VFLI.i18n("File")); ui:Show();
		if desc and desc.file then ui:SetPath(desc.file); end
		ui.GetDescriptor = function()
			return {class = "file", file = ui:GetPath()};
		end
		ui.Destroy = VFL.hook(function(s) s.GetDescriptor = nil; end, ui.Destroy);

		return ui;
	end,
	FindSet = function(desc)
		if not desc.file then return nil; end
		return RDXDB.GetObjectInstance(desc.file);
	end,
});