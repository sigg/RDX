-- TextureBundle.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A texture bundle is an associated bundle of textures in the same layer.

VFLG.TextureBundle = {};

--- Create a new texture bundle on the given layer.
function VFLG.TextureBundle:new(layer)
	local self = {};

	local tpool = {};
	--- Gets the n'th texture in this texture bundle; auto-acquires new textures if
	-- the bundle is not large enough.
	function self:GetTexture(n)
		if n < 1 then return nil; end
		if(n > #tpool) then
			for i=(#tpool + 1),n do
				tpool[i] = VFLUI.CreateTexture(layer);
			end
		end
		return tpool[n];
	end

	--- Hides all textures in this texture bundle
	function self:HideAll()
		for _,tex in pairs(tpool) do tex:Hide(); end
	end

	--- Using the n'th texture in this texture bundle, draw a line.
	function self:Line(n, x0, y0, x1, y1, w, r, g, b, a)
		VFLG.DrawLine(layer, self:GetTexture(n), x0, y0, x1, y1, w, r, g, b, a);
	end

	function self:UniversalLine(n, x0, y0, x1, y1, w, r, g, b, a)
		x0, y0, x1, y1 = VFLUI.GetLocalCoords4(layer, x0, y0, x1, y1);
		VFLG.DrawLine(layer, self:GetTexture(n), x0, y0, x1, y1, w, r, g, b, a);
	end
	
	-- Redraw-able texture bundles can override this.
	self.Redraw = VFL.Noop;

	--- Destroy this texture bundle
	function self:Destroy()
		for _,tex in pairs(tpool) do VFLUI.ReleaseRegion(tex); end
		tpool = nil;
		self.HideAll = nil; self.Line = nil; self.GetTexture = nil;
		self.UniversalLine = nil;
	end
	
	return self;
end

