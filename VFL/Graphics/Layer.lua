-- Layer.lua
-- VFL
-- (C)2006 Bill Johnson and The VFL Project
--
-- A Layer is a frame that has an associated texture pool and can be drawn upon with line-drawing primitives.

local band, bor = bit.band, bit.bor;
local max, min = math.max, math.min;
local sqrt = math.sqrt;

-- Deprecated old stuff
function VFL.MakeLayer(f)
	return f;
end

-----------------------------------------
-- CLIPPING AND TRANSFORM ALGORITHMS
-----------------------------------------
local clipFlag = false;
local clip_l, clip_r, clip_t, clip_b = 0,0,0,0;

-- Set the clip region for all clipping algorithms.
local function SetClipRegion(nl, nt, nr, nb)
	clip_l = nl; clip_r = nr; clip_t = nt; clip_b = nb;
end
VFLG.SetClipRegion = SetClipRegion;

function VFLG.SetClipFlag(f) clipFlag = f; end

-- Perform Cohen-Sutherland clipping on the given line.
local function CS_Clip(x0, y0, x1, y1)
	local oc0, oc1, tmp;
	while true do -- Loop until we've clipped everything (at most 2 iters)
		-- Compute "outcodes" which are bitfields indicating whether and how the respective points fail
		-- to be within the clipping box
		oc0 = 0; oc1 = 0;
		if(y0 > clip_t) then oc0 = oc0 + 1; elseif(y0 < clip_b) then oc0 = oc0 + 2; end
		if(x0 > clip_r) then oc0 = oc0 + 4; elseif(x0 < clip_l) then oc0 = oc0 + 8; end
		if(y1 > clip_t) then oc1 = oc1 + 1; elseif(y1 < clip_b) then oc1 = oc1 + 2; end
		if(x1 > clip_r) then oc1 = oc1 + 4; elseif(x1 < clip_l) then oc1 = oc1 + 8; end
		-- If both outcodes are in the box, we're done, the whole line is good.
		if( (oc0 == 0) and (oc1 == 0) ) then return x0, y0, x1, y1; end
		-- If both outcodes are on the same side outside of the box, we're done, no line
		-- need be drawn.
		if(band(oc0, oc1) ~= 0) then return nil; end

		-- OK, we do need to do some clipping. We'll assume that point 0 is outside the
		-- box to reduce the cases. if not, swap p1 and p0 in the algorithm.
		if(oc0 == 0) then
			tmp = x0; x0 = x1; x1 = tmp;
			tmp = y0; y0 = y1; y1 = tmp;
			oc0 = oc1; oc1 = 0;
		end

		-- Four cases. In each case, "average" the out-of-bounds point with the
		-- side of the box that it intersects.
		if(band(oc0, 1) ~= 0) then
			x0 = x0 + ((x1 - x0) * (clip_t - y0))/(y1 - y0);
			y0 = clip_t;
		elseif(band(oc0, 2) ~= 0) then
			x0 = x0 + ((x1 - x0) * (clip_b - y0))/(y1 - y0);
			y0 = clip_b;
		elseif(band(oc0, 4) ~= 0) then
			y0 = y0 + ((y1 - y0) * (clip_r - x0))/(x1 - x0);
			x0 = clip_r;
		elseif(band(oc0, 8) ~= 0) then
			y0 = y0 + ((y1 - y0) * (clip_l - x0))/(x1 - x0);
			x0 = clip_l;
		end

		-- We'll repeat until we've clipped the entire line.
	end
end

-- Temp vectors used in the next calculation
local tempMatrix = Affine2D:new();

-- Texture-box clipping. In this case, we will not only be clipping the bounds of the texture,
-- we will also clip the texcoords as well.
-- NOTE: The transformation induced by the passed texcoords MUST BE AFFINE. Nonaffine components
-- will be discarded.
local function ClipTexture(xl, xt, xr, xb, ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
	-- If clipping is disabled we've nothing to do here.
	if not clipFlag then
		return xl, xt, xr, xb, ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
	end

	-- Find the clipped edges of the box
	local nl, nt, nr, nb = max(clip_l, xl), min(clip_t, xt), min(clip_r, xr), max(clip_b, xb);

	-- If the resulting box is degenerate it's outside the viewport and thus
	-- completely clipped away so return nil.
	if(nt <= nb) or (nr <= nl) then return nil; end
	-- If the resulting box equals the original texture box, there was no clipping necessary.
	-- In this case avoid the next part which is expensive and just return the original parameters
	if( (nl == xl) and (nt == xt) and (nr == xr) and (nb == xb) ) then
		return xl, xt, xr, xb, ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
	end

	-- OK, now we have the new points and we need to remap the texture coords.
	-- We will do this by first deriving the affine transformation from the original XY space into
	-- UV space, and resample the points in UV space according to their new positions in XY space.
	tempMatrix:LoadXYtoUV_Corners(ULx, ULy, LLx, LLy, URx, URy);

	-- Now compute the clip fractions
	local texW, texH = xr - xl, xt - xb;
	local l_clip_frac, r_clip_frac = (nl - xl) / texW, 1 - ((xr - nr) / texW);
	local t_clip_frac, b_clip_frac = (xt - nt) / texH, 1 - ((nb - xb) / texH);

	-- Resample each corner point accordingly.
	ULx, ULy = tempMatrix:ApplyToPoint(l_clip_frac, t_clip_frac);
	LLx, LLy = tempMatrix:ApplyToPoint(l_clip_frac, b_clip_frac);
	URx, URy = tempMatrix:ApplyToPoint(r_clip_frac, t_clip_frac);
	LRx, LRy = tempMatrix:ApplyToPoint(r_clip_frac, b_clip_frac);

	return nl, nt, nr, nb, ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
end

-- For the texture with the given AABB coords and texcoords, compute the AABB coords and texcoords
-- of said texture after the affine transform t is applied.
local function TransformTexture(t, xULx, xULy, xLRx, xLRy, ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
	-- Concept: The UV-space corners project into the XY-space of the new AABB as the XY-image of the
	-- old AABB. So set up a map so that the corners of the XY-image of the old AABB line up with the
	-- given UV coords.

	-- Transform the original box corners
	local xLLx, xLLy = t:ApplyToPoint(xULx, xLRy);
	local xURx, xURy = t:ApplyToPoint(xLRx, xULy);
	xULx, xULy = t:ApplyToPoint(xULx, xULy);
	xLRx, xLRy = t:ApplyToPoint(xLRx, xLRy);

	-- The new box is quite possibly no longer an AABB. Compute the containing AABB.
	local nl, nt, nr, nb;
	nl = min(xULx, xLLx, xURx, xLRx); nr = max(xULx, xLLx, xURx, xLRx); 
	nb = min(xULy, xLLy, xURy, xLRy); nt = max(xULy, xLLy, xURy, xLRy);

	-- If we're doing clipping, check the new AABB. 
	-- If it's completely out-of-scene we don't need to bother jiggering with texcoords.
	if clipFlag and ((nr < clip_l) or (nl > clip_r) or (nb > clip_t) or (nt < clip_b)) then return nil; end

	-- Treat the new AABB as a (l)[0,1](r)x(t)[0,1](b) box and map the transformed box into it.
	-- Derive a transform that sends the new AABB's volume into [0,1]x[0,1]
	tempMatrix:LoadXYtoUV_Corners(nl, nt, nl, nb, nr, nt):Invert();

	-- Apply clipping
	local cl, ct, cr, cb = 0, 0, 1, 1;
	if clipFlag then
		nl = max(clip_l, nl); nt = min(clip_t, nt); nr = min(clip_r, nr); nb = max(clip_b, nb);
		cl, ct = tempMatrix:ApplyToPoint(nl, nt);
		cr, cb = tempMatrix:ApplyToPoint(nr, nb);
	end

	-- Apply to the transformed corner points of the old box.
	xULx, xULy = tempMatrix:ApplyToPoint(xULx, xULy);
	xLLx, xLLy = tempMatrix:ApplyToPoint(xLLx, xLLy);
	xURx, xURy = tempMatrix:ApplyToPoint(xURx, xURy);

	-- Now derive an XY-to-UV transform that sends (xl, xt) to (ULx,ULy) et cetera.
	tempMatrix:LoadXYtoUV_MatchPoints(xULx, xULy, ULx, ULy, xLLx, xLLy, LLx, LLy, xURx, xURy, URx, URy);

	-- Evaluate at the clipped corners to get our new texcoords!
	ULx, ULy = tempMatrix:ApplyToPoint(cl, ct);
	LLx, LLy = tempMatrix:ApplyToPoint(cl, cb);
	URx, URy = tempMatrix:ApplyToPoint(cr, ct);
	LRx, LRy = tempMatrix:ApplyToPoint(cr, cb);

	return nl, nt, nr, nb, ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
end


-----------------------------------------
-- LINE DRAWING
-----------------------------------------
local TEXTURE_SIZE = (256/254)/2;

-- Draw a line.
local function DrawLine_Raw(layer, texture, x0, y0, x1, y1, w, r, g, b, a)
	-- Clipping check
	if clipFlag then
		x0, y0, x1, y1 = CS_Clip(x0, y0, x1, y1);
		if not x0 then texture:Hide(); return; end -- Clip reject
	end

	local dx, dy = x1 - x0, y1 - y0;

	-- Distance check. If line is extremely short, don't bother
	local dist = sqrt(dx*dx + dy*dy);
	if dist < .000001 then texture:Hide(); return; end
	
	-- Compute midpoint, which will be used as the anchor for the texture.
	x0 = (x0+x1)/2; y0 = (y0+y1)/2;

	-- Compute sine and cosine of the line's inclination. Reorient so everything is
	-- nice.
	if(dx < 0) then dx,dy = -dx,-dy; end
	local s,c = -dy/dist, dx/dist;
	local sc = s*c;

	-- Texture coords
	local Bw, Bh, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy;
	if dy>=0 then
		Bw = ((dist * c) - (w * s)) * TEXTURE_SIZE;
		Bh = ((w * c) - (dist * s)) * TEXTURE_SIZE;
		BLx, BLy, BRy = (w/dist) * sc, s * s, (dist/w) * sc;
		BRx, TLx, TLy, TRx = 1-BLy, BLy, 1-BRy, 1-BLx;
		TRy = BRx;
	else
		-- Sign change in width and height to make sure everything is positive
		Bw = ((dist * c) + (w * s)) * TEXTURE_SIZE;
		Bh = ((w * c) + (dist * s)) * TEXTURE_SIZE;
		-- Inversion of x and y here
		BLx, BLy, BRx = s * s, -(dist/w) * sc, 1 + (w/dist)*sc;
		BRy, TLx, TLy, TRy = BLx, 1-BRx, 1-BLx, 1-BLy;
		TRx = TLy;
	end

	-- Apply the details to the texture itself.
	texture:ClearAllPoints();
	texture:SetTexture("Interface\\Addons\\VFL\\Skin\\Box.tga");
	texture:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy);
	texture:SetPoint("BOTTOMLEFT", layer, "BOTTOMLEFT", x0 - Bw, y0 - Bh);
	texture:SetPoint("TOPRIGHT", layer, "BOTTOMLEFT", x0 + Bw, y0 + Bh);
	texture:SetVertexColor(r,g,b,a);
	texture:Show();
end

--- Draw a line onto a layer.
VFLG.DrawLine = DrawLine_Raw;
VFLG.DrawClippedLine = DrawLine_Raw;
VFLG.TransformTexture = TransformTexture;
VFLG.ClipTexture = ClipTexture;

