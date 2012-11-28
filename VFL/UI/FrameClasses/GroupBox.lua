-- GroupBox.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A group box is a decorational box that groups related controls visually.
VFLUI.GroupBox = {};

--- Create a new GroupBox.
function VFLUI.GroupBox:new(parent)
	local gb = VFLUI.AcquireFrame("Frame");
	VFLUI.StdSetParent(gb, parent, 3);

	------------------- Decorations
	local decor = nil;
	function gb:AddDecoration(dec)
		if not dec then return; end
		if not decor then decor = {}; end
		dec:SetParent(self);
		table.insert(decor, dec);
	end
	local border = VFLUI.AcquireFrame("Frame");
	border:SetParent(gb);
	border:SetPoint("TOPLEFT", gb, "TOPLEFT", 0, -5);
	border:SetPoint("BOTTOMRIGHT", gb, "BOTTOMRIGHT");
	border:SetBackdrop(VFLUI.DefaultDialogBorder); border:SetAlpha(0.5);
	border:SetFrameLevel(gb:GetFrameLevel() + 1); border:Show();

	local caption = VFLUI.AcquireFrame("Frame");
	caption:SetParent(gb);
	caption:SetPoint("TOPLEFT", gb, "TOPLEFT", 8, 1); caption:SetHeight(16);
	caption:SetFrameLevel(gb:GetFrameLevel() + 2);
	caption:Show();
	function gb:GetCaptionArea() return caption; end

	

	--------------------------- Client frame management
	local client = VFLUI.AcquireFrame("Frame");
	local cl, ct, cr, cb = 0, 0, 0, 0;
	function gb:SetClientInsets(l,t,r,b)
		cl = l; ct = t; cr = r; cb = b;
	end
	gb:SetClientInsets(4, 15, 4, 4);
	VFLUI.StdSetParent(client, gb, 2);
	client.DialogOnLayout = VFL.Noop;
	client:SetPoint("TOPLEFT", gb, "TOPLEFT", 4, -15);
	client:Show();
	function gb:GetClientArea() return client; end
	function gb:SetClient(cli)
		if client then client:Destroy(); client = nil; end
		if not cli then return; end
		client = cli;
		VFLUI.StdSetParent(client, gb, 2);
		if not client.DialogOnLayout then client.DialogOnLayout = VFL.Noop; end
		client:SetPoint("TOPLEFT", gb, "TOPLEFT", cl, -ct);
		client:Show();
		self:DialogOnLayout();
	end

	----------------------- LAYOUT
	local function LayoutCaption()
		caption:SetWidth(VFL.clamp( (gb:GetWidth() - 12) , 0, 5000));
	end
	gb.DialogOnLayout = VFL.Noop;
	function gb:SetLayoutConstraint(q)
		if(q == "NONE") then
			self.DialogOnLayout = VFL.Noop
		elseif(q == "DOWNWARD") then
			function self:DialogOnLayout()
				client:SetWidth(VFL.clamp( (gb:GetWidth() - 8), 0, 5000));
				client:SetHeight(VFL.clamp( (gb:GetHeight() - 19), 0, 5000));
				LayoutCaption();
				client:DialogOnLayout();
			end
		elseif(q == "UPWARD") then
			function self:DialogOnLayout()
				client:DialogOnLayout();
				gb:SetWidth(VFL.clamp( (client:GetWidth() + 8), 0, 5000));
				gb:SetHeight(VFL.clamp( (client:GetHeight() + 19), 0, 5000));
				LayoutCaption();
			end
		elseif(q == "WIDTH_DOWNWARD_HEIGHT_UPWARD") then
			function self:DialogOnLayout()
				client:SetWidth(VFL.clamp( (gb:GetWidth() - 8), 0, 5000));
				client:DialogOnLayout();
				gb:SetHeight(VFL.clamp( (client:GetHeight() + 19), 0, 5000));
				LayoutCaption();
			end
		end
	end
	gb:SetLayoutConstraint("DOWNWARD");

	local layoutTrigger = function(self) self:DialogOnLayout(); end
	gb:SetScript("OnShow", layoutTrigger);
	gb:SetScript("OnSizeChanged", layoutTrigger);
	
	---------------- Destructor
	gb.Destroy = VFL.hook(function(s)
		s.GetCaptionArea = nil; s.GetClientArea = nil;
		s.SetLayoutConstraint = nil;
		s.DialogOnLayout = nil; LayoutCaption = nil;
		border:Destroy(); border = nil; caption:Destroy(); caption = nil;
		if decor then
			for _,dec in pairs(decor) do dec:Destroy(); end
			decor = nil;
		end
		client:Destroy(); client = nil;
	end, gb.Destroy);

	return gb;
end

--- A helper function to create a default text caption on a groupbox.
function VFLUI.GroupBox.MakeTextCaption(gb, text)
	if (not gb) or (not text) then return; end
	local x = VFLUI.MakeLabel(nil, gb:GetCaptionArea(), text);
	x:SetTextColor(0.85, 0.8, 0);
	x:SetPoint("TOPLEFT", gb:GetCaptionArea(), "TOPLEFT");
end
