

function VFLUI.CheckEmbedRight(parent, label)
	local frame = VFLUI.Checkbox:new(parent);
	frame:SetText(label);

	local child = nil;
	function frame:EmbedChild(chd)
		if child then return; end
		child = chd;
		child:ClearAllPoints(); child:SetPoint("RIGHT", frame, "RIGHT");
		frame:SetHeight(VFL.clamp(child:GetHeight(), 16, 1000));
	end
	frame.DialogOnLayout = VFL.Noop;

	frame.Destroy = VFL.hook(function(s)
		s.EmbedChild = nil;
		if child then child:Destroy(); child = nil; end
	end, frame.Destroy);
	return frame;
end