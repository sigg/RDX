
--- Helper function: embed a fixed-width control on the right side of a variable-width
-- frame with a label.
function VFLUI.EmbedRight(parent, label)
	local frame = VFLUI.AcquireFrame("Frame");
	if parent then
		frame:SetParent(parent); frame:SetFrameStrata(parent:GetFrameStrata());
		frame:SetFrameLevel(parent:GetFrameLevel());
	end
	local lbl = VFLUI.MakeLabel(nil, frame, label);
	lbl:SetPoint("LEFT", frame, "LEFT");
	local child = nil
	function frame:EmbedChild(chd)
		if child then return; end
		child = chd;
		child:ClearAllPoints(); child:SetPoint("RIGHT", frame, "RIGHT");
		frame:SetHeight(VFL.clamp(child:GetHeight(), 12, 1000));
	end
	frame.DialogOnLayout = VFL.Noop;
	frame.Destroy = VFL.hook(function(s)
		s.EmbedChild = nil;
		if child then child:Destroy(); child = nil; end
	end, frame.Destroy);
	return frame;
end